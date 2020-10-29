unit uc_synedit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SynEdit, ComCtrls, Controls, Graphics, SynEditHighlighter,
  up_currentdata, uc_syncompletion, Dialogs, SynEditTypes, Menus, up_var;

type
  tucSynEdit = class(TSynEdit)
    constructor Create (AOwner : TComponent); override;
    procedure fcInit (APopupMenu : TPopupMenu);
    procedure fcUpdate (AVar : tupVar); overload;
    procedure fcUpdate (ACurrentData : tupCurrentData); overload;
    procedure fcOpen (AFileName : TFileName);
    procedure fcSave (AFileName : TFileName);
    procedure fcChange (Sender: TObject);
    procedure fcUndo;
    procedure fcRedo;
    procedure fcCopy;
    procedure fcCut;
    procedure fcPaste;
    procedure fcSelectAll;
    procedure fcShowCompletion (ASynCompletion : tucSynCompletion);
    procedure fcReplace (AOldPattern,ANewPattern : string; ASynSearchOptions : TSynSearchOptions;
      AIsSpecialChar : Boolean; ASpecialChar : string);
    procedure fcFindNext;
  private
    procedure fcSwitchColor;
    procedure fcSetColor (ALang : TSynCustomHighlighter; ACommentAttriColor,AKeyAttriColor : TColor);
  end;

implementation

uses
  uc_tabsheet, ac_color;

constructor tucSynEdit.Create (AOwner : TComponent);
begin
  inherited Create(AOwner);
  Self.Align := alClient;
  Self.Font.Name := 'Courier New';
  Self.Font.Pitch := fpFixed;
  Self.Font.Quality := fqProof;
  Self.Font.Size := vupVar.vFontSize;
  Self.LineHighlightColor.Background := vupVar.vLineHighlightColor;
  Self.OnChange := @Self.fcChange;
end;

procedure tucSynEdit.fcInit (APopupMenu : TPopupMenu);
begin
  Self.PopupMenu := APopupMenu;
end;

procedure tucSynEdit.fcUpdate (AVar : tupVar);
begin
  Self.fcSwitchColor;
  Self.Font.Size := AVar.vFontSize;
end;

procedure tucSynEdit.fcUpdate (ACurrentData : tupCurrentData);
begin
  Self.Highlighter := ACurrentData.vHighlighter;
end;

procedure tucSynEdit.fcOpen (AFileName : TFileName);
begin
  Self.Lines.LoadFromFile(AFileName);
end;

procedure tucSynEdit.fcSave (AFileName : TFileName);
begin
  Self.Lines.SaveToFile(AFileName);
end;

procedure tucSynEdit.fcChange (Sender: TObject);
begin
  (Self.Parent as tucTabSheet).ImageIndex := vupVar.vImageIndexModifiedFile;
  (Self.Parent as tucTabSheet).vTextStatus := aseTextStatusModified;
  inherited;
end;

procedure tucSynEdit.fcUndo;
begin
  Self.Undo;
end;

procedure tucSynEdit.fcRedo;
begin
  Self.Redo;
end;

procedure tucSynEdit.fcCopy;
begin
  Self.CopyToClipboard;
end;

procedure tucSynEdit.fcCut;
begin
  Self.CutToClipboard;
end;

procedure tucSynEdit.fcPaste;
begin
  Self.PasteFromClipboard;
end;

procedure tucSynEdit.fcSelectAll;
begin
  Self.SelectAll;
end;

procedure tucSynEdit.fcShowCompletion (ASynCompletion : tucSynCompletion);
begin
  Self.CommandProcessor(ASynCompletion.ExecCommandID, '', nil);
end;

procedure tucSynEdit.fcReplace (AOldPattern,ANewPattern : string; ASynSearchOptions : TSynSearchOptions;
  AIsSpecialChar : Boolean; ASpecialChar : string);
begin
  if not(AIsSpecialChar) then
    Self.SearchReplace(AOldPattern,ANewPattern,ASynSearchOptions)
  else
  begin
    if ASpecialChar = '\n' then Self.SearchReplace(AOldPattern,#13,ASynSearchOptions)
    else if ASpecialChar = '\t' then Self.SearchReplace(AOldPattern,#9,ASynSearchOptions)
  ;
  end;
end;

procedure tucSynEdit.fcFindNext;
begin
  Self.SearchReplace(vupVar.vCurrentFindKeyword,'',[]);
end;

procedure tucSynEdit.fcSwitchColor;
var
  LSynEditColor : TColor;
  LSynEditFontColor : TColor;
  LGutterColor : TColor;
  LGutterMarkupColor : TColor;
  LLineHighlightColor : TColor;
  LCommentAttriColor : TColor;
  LKeyAttriColor : TColor;
begin
  if vupVar.vCurrentTheme = aseThemeLight then
  begin
    LSynEditColor := vupVar.vSynEditColor;
    LSynEditFontColor := vupVar.vSynEditFontColor;
    LGutterColor := vupVar.vGutterColor;
    LGutterMarkupColor := vupVar.vGutterMarkupColor;
    LLineHighlightColor := vupVar.vLineHighlightColor;
    LCommentAttriColor := vupVar.vSynHighlighter.vCommentAttriColor;
    LKeyAttriColor := vupVar.vSynHighlighter.vKeyAttriColor;
  end
  else if vupVar.vCurrentTheme = aseThemeDark then
  begin
    LSynEditColor := vacColor.fcInvert(vupVar.vSynEditColor);
    LSynEditFontColor := vacColor.fcInvert(vupVar.vSynEditFontColor);
    LGutterColor := vacColor.fcInvert(vupVar.vGutterColor);
    LGutterMarkupColor := vacColor.fcInvert(vupVar.vGutterMarkupColor);
    LLineHighlightColor := vacColor.fcInvert(vupVar.vLineHighlightColor);
    LCommentAttriColor := vacColor.fcInvert(vupVar.vSynHighlighter.vCommentAttriColor);
    LKeyAttriColor := vacColor.fcInvert(vupVar.vSynHighlighter.vKeyAttriColor);
  end;
  Self.Color := LSynEditColor;
  Self.Font.Color := LSynEditFontColor;
  Self.Gutter.Color := LGutterColor;
  Self.Gutter.Parts[1].MarkupInfo.Background := LGutterMarkupColor;
  Self.LineHighlightColor.Background := LLineHighlightColor;

  Self.fcSetColor(vupVar.vSynHighlighter.vCobol,LCommentAttriColor,LKeyAttriColor);
  Self.fcSetColor(vupVar.vSynHighlighter.vCS,LCommentAttriColor,LKeyAttriColor);
  Self.fcSetColor(vupVar.vSynHighlighter.vCSS,LCommentAttriColor,LKeyAttriColor);
  Self.fcSetColor(vupVar.vSynHighlighter.vHTML,LCommentAttriColor,LKeyAttriColor);
  Self.fcSetColor(vupVar.vSynHighlighter.vJava,LCommentAttriColor,LKeyAttriColor);
  Self.fcSetColor(vupVar.vSynHighlighter.vPas,LCommentAttriColor,LKeyAttriColor);
  Self.fcSetColor(vupVar.vSynHighlighter.vPHP,LCommentAttriColor,LKeyAttriColor);
  Self.fcSetColor(vupVar.vSynHighlighter.vPython,LCommentAttriColor,LKeyAttriColor);
  Self.fcSetColor(vupVar.vSynHighlighter.vSQL,LCommentAttriColor,LKeyAttriColor);

  // vupVar.vSynHighlighter.vJSON.CommentAttri.Foreground := LCommentAttriColor;
  vupVar.vSynHighlighter.vJSON.KeyAttri.Foreground := LKeyAttriColor;
end;

procedure tucSynEdit.fcSetColor (ALang : TSynCustomHighlighter; ACommentAttriColor,AKeyAttriColor : TColor);
begin
  ALang.CommentAttribute.Foreground := ACommentAttriColor;
  ALang.KeywordAttribute.Foreground := AKeyAttriColor;
end;

end.

