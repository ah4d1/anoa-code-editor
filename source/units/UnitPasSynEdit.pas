unit UnitPasSynEdit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SynEdit, SynEditHighlighter;

type
  TUSynEdit = class
    constructor Create;
    procedure Update (ASynEdit : TSynEdit; AHighlighter : TSynCustomHighlighter);
    procedure Open (ASynEdit : TSynEdit; AFileName : TFileName);
    procedure Save (ASynEdit : TSynEdit; AFileName : TFileName);
  end;

implementation

constructor TUSynEdit.Create;
begin
  //
end;

procedure TUSynEdit.Update (ASynEdit : TSynEdit; AHighlighter : TSynCustomHighlighter);
begin
  ASynEdit.Highlighter := AHighlighter;
end;

procedure TUSynEdit.Open (ASynEdit : TSynEdit; AFileName : TFileName);
begin
  ASynEdit.Lines.LoadFromFile(AFileName);
end;

procedure TUSynEdit.Save (ASynEdit : TSynEdit; AFileName : TFileName);
begin
  ASynEdit.Lines.SaveToFile(AFileName);
end;

end.

