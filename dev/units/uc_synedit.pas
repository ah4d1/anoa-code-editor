unit uc_synedit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SynEdit, ComCtrls, Controls, Graphics, SynEditHighlighter,
  up_currentdata, uc_syncompletion, Dialogs, SynEditTypes, Menus, up_var, ace_synedit;

type
  tucSynEdit = class(TAceSynEdit)
    constructor Create (AOwner : TComponent); override;
    procedure fcInit (APopupMenu : TPopupMenu);
    procedure fcUpdate; overload;
    procedure fcUpdate (ACurrentData : tupCurrentData); overload;
    procedure fcOpen (AFileName : TFileName);
    procedure fcSave (AFileName : TFileName);
    procedure fcChange (Sender: TObject);
    procedure fcShowCompletion (ASynCompletion : tucSynCompletion);
    procedure fcReplace (AOldPattern,ANewPattern : string; ASynSearchOptions : TSynSearchOptions;
      AIsSpecialChar : Boolean; ASpecialChar : string);
    procedure fcFindNext;
    procedure fcMacroStartRecording;
    procedure fcMacroStopRecording;
    procedure fcMacroPlayback;
  end;

implementation

uses
  uc_tabsheet, up_theme;

constructor tucSynEdit.Create (AOwner : TComponent);
begin
  inherited Create(AOwner);
  Self.Align := alClient;
  Self.Font.Name := 'Courier New';
  Self.Font.Pitch := fpFixed;
  Self.Font.Quality := fqProof;
  Self.Font.Size := vupVar.vFontSize;
  // Self.LineHighlightColor.Background := vupVar.vLineHighlightColor;
  Self.Options := Self.Options - [eoShowSpecialChars,eoTabsToSpaces];
  Self.VisibleSpecialChars := [vscSpace,vscTabAtFirst,vscTabAtLast];
  Self.OnChange := @Self.fcChange;
end;

procedure tucSynEdit.fcInit (APopupMenu : TPopupMenu);
begin
  Self.fcUpdate;
  Self.PopupMenu := APopupMenu;
  vupVar.vSynMacroRecorder.Editor := Self;
end;

procedure tucSynEdit.fcUpdate;
begin
  {TRY TO UPDATE HERE}
  vupTheme.fcSetThemeColor(vupVar);
  {}
  Self.vTheme := vupVar.vCurrentTheme;
  Self.Font.Size := vupVar.vFontSize;
  if vupVar.vShowSpecialChars then
    Self.Options := Self.Options + [eoShowSpecialChars]
  else
    Self.Options := Self.Options - [eoShowSpecialChars]
  ;
  vupVar.vSynMacroRecorder.Editor := Self;
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

procedure tucSynEdit.fcMacroStartRecording;
begin
  vupVar.vSynMacroRecorder.RecordMacro(Self);
end;

procedure tucSynEdit.fcMacroStopRecording;
begin
  vupVar.vSynMacroRecorder.Stop;
end;

procedure tucSynEdit.fcMacroPlayback;
begin
  vupVar.vSynMacroRecorder.PlaybackMacro(Self);
end;

end.
