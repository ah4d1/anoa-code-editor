unit UnitVar;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  TASETypeLang = (aseLangHTML,aseLangJava,aseLangPas,aseLangPHP,aseLangPython);
  TUVar = object
    vCurrentFileName : TFileName;
    vImageIndexNormalFile : Byte;
    vImageIndexModifiedFile : Byte;
    procedure fcInit;
  end;

var
  VUVar : TUVar;

implementation

procedure TUVar.fcInit;
begin
  Self.vCurrentFileName := '';
  Self.vImageIndexNormalFile := 3;
  Self.vImageIndexModifiedFile := 4;
end;

end.

