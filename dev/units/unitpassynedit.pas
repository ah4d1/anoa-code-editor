unit UnitPasSynEdit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SynEdit, SynEditHighlighter;

type
  TUSynEdit = class
    constructor Create;
    procedure Update (ASynEdit : TSynEdit; AHighlighter : TSynCustomHighlighter);
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

end.

