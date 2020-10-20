unit UnitCmpSynEdit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SynEdit, ComCtrls, Controls, Graphics, SynEditHighlighter;

type
  TUSynEdit = class(TSynEdit)
    constructor Create (AOwner : TComponent); override;
    procedure fcUpdate (AHighlighter : TSynCustomHighlighter);
    procedure fcOpen (AFileName : TFileName);
    procedure fcSave (AFileName : TFileName);
    procedure fcChange (Sender: TObject);
  end;

implementation

uses
  UnitPasVar;

constructor TUSynEdit.Create(AOwner : TComponent);
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

procedure TUSynEdit.fcUpdate (AHighlighter : TSynCustomHighlighter);
begin
  Self.Highlighter := AHighlighter;
end;

procedure TUSynEdit.fcOpen (AFileName : TFileName);
begin
  Self.Lines.LoadFromFile(AFileName);
end;

procedure TUSynEdit.fcSave (AFileName : TFileName);
begin
  Self.Lines.SaveToFile(AFileName);
end;

procedure TUSynEdit.fcChange (Sender: TObject);
begin
  ((Self.Parent as TTabSheet).Parent as TPageControl).ActivePage.ImageIndex := VUVar.vImageIndexModifiedFile;
  inherited;
end;


end.

