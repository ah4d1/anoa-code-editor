unit uc_synedit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SynEdit, ComCtrls, Controls, Graphics, SynEditHighlighter,
  up_currentdata, uc_syncompletion, Dialogs;

type
  tucSynEdit = class(TSynEdit)
    constructor Create (AOwner : TComponent); override;
    procedure fcUpdate (ACurrentData : tupCurrentData);
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
    procedure fcSwitchColor;
  end;

implementation

uses
  uc_tabsheet, up_var, ac_color;

constructor tucSynEdit.Create (AOwner : TComponent);
begin
  inherited Create(AOwner);
  Self.Align := alClient;
  Self.Font.Name := 'Courier New';
  Self.Font.Pitch := fpFixed;
  Self.Font.Quality := fqProof;
  Self.Font.Size := 9;
  Self.LineHighlightColor.Background := $00EFE8D6;
  Self.OnChange := @Self.fcChange;
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

procedure tucSynEdit.fcSwitchColor;
begin
  Self.Color := vacColor.fcInvert(Self.Color);
  Self.Font.Color := vacColor.fcInvert(Self.Font.Color);
  Self.Gutter.Color := vacColor.fcInvert(Self.Gutter.Color);
  Self.Gutter.Parts[1].MarkupInfo.Background := vacColor.fcInvert(Self.Gutter.Parts[1].MarkupInfo.Background);;
  Self.LineHighlightColor.Background := vacColor.fcInvert(Self.LineHighlightColor.Background);
end;

end.

