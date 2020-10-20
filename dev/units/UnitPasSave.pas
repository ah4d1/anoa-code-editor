unit UnitPasSave;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SynEdit;

type
  TUSave = class
    constructor Create;
    procedure Save (ASynEdit : TSynEdit; AFileName : TFileName);
  end;

var
  VUSave : TUSave;

implementation

constructor TUSave.Create;
begin
  //
end;

procedure TUSave.Save (ASynEdit : TSynEdit; AFileName : TFileName);
begin
  ASynEdit.Lines.SaveToFile(AFileName);
end;

end.

