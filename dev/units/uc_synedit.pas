unit uc_synedit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SynEdit, ComCtrls, Controls, Graphics, SynEditHighlighter;

type
  tucSynEdit = class(TSynEdit)
    constructor Create (AOwner : TComponent); override;
    procedure fcUpdate (AHighlighter : TSynCustomHighlighter);
    procedure fcOpen (AFileName : TFileName);
    procedure fcSave (AFileName : TFileName);
    procedure fcChange (Sender: TObject);
  end;

implementation

uses
  UnitPasVar;

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
  (Self.Parent as TTabSheet).ImageIndex := VUVar.vImageIndexModifiedFile;
  inherited;
end;


end.

