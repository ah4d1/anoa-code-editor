unit uc_synedit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SynEdit, ComCtrls, Controls, Graphics, SynEditHighlighter,
  uc_syncompletion, Dialogs;

type
  tucSynEdit = class(TSynEdit)
    constructor Create (AOwner : TComponent); override;
    procedure fcUpdate (AHighlighter : TSynCustomHighlighter);
    procedure fcOpen (AFileName : TFileName);
    procedure fcSave (AFileName : TFileName);
    procedure fcChange (Sender: TObject);
    procedure fcUndo;
    procedure fcRedo;
    procedure fcSetFontSize (ASize : Byte);
    procedure fcShowCompletion (ASynCompletion : tucSynCompletion);
    procedure fcSwitchColor;
  end;

implementation

uses
  uc_tabsheet, up_var, up_tools;

constructor tucSynEdit.Create (AOwner : TComponent);
begin
  inherited Create(AOwner);
  Self.Align := alClient;
  Self.Font.Name := 'Courier New';
  Self.Font.Pitch := fpFixed;
  Self.Font.Quality := fqProof;
  Self.Font.Size := 9;
  Self.LineHighlightColor.Background := $00D3BD89;
  Self.OnChange := @Self.fcChange;
end;

procedure tucSynEdit.fcUpdate (AHighlighter : TSynCustomHighlighter);
begin
  Self.Highlighter := AHighlighter;
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

procedure tucSynEdit.fcSetFontSize (ASize : Byte);
begin
  Self.Font.Size := ASize;
end;

procedure tucSynEdit.fcShowCompletion (ASynCompletion : tucSynCompletion);
begin
  Self.CommandProcessor(ASynCompletion.ExecCommandID, '', nil);
end;

procedure tucSynEdit.fcSwitchColor;
begin
  Self.Color := vupTools.fcComplementaryColor(Self.Color);
  Self.Font.Color := vupTools.fcComplementaryColor(Self.Font.Color);
  Self.Gutter.Color := vupTools.fcComplementaryColor(Self.Gutter.Color);
  Self.Gutter.Parts[1].MarkupInfo.Background := vupTools.fcComplementaryColor(Self.Gutter.Parts[1].MarkupInfo.Background);;
  Self.LineHighlightColor.Background := vupTools.fcComplementaryColor(Self.LineHighlightColor.Background);
end;

end.

