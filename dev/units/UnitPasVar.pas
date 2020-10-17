unit UnitPasVar;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  TASETypeLang = (aseLangHTML,aseLangJava,aseLangJSON,aseLangPas,aseLangPHP,aseLangPython);
  TUVar = object
    vCurrentFileName : TFileName;
    vImageIndexNormalFile : Byte;
    vImageIndexModifiedFile : Byte;
    vASETypeLang : TStringList;
    procedure fcInit;
  end;

var
  VUVar : TUVar;

implementation

uses
  UnitPasTools;

procedure TUVar.fcInit;
begin
  Self.vCurrentFileName := '';
  Self.vImageIndexNormalFile := 3;
  Self.vImageIndexModifiedFile := 4;
  vASETypeLang := VUTools.FcStringExplode('HTML|Java|JSON|Pascal|PHP|Python','|');
end;

end.

