unit UnitPasLang;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, UnitPasSynHighlighter;

type
  TULang = object
    function GetLang (AFileExt : string) : TASETypeLang;
    function GetLangTxt (AASETypeLang : TASETypeLang) : string;
  end;

var
  VULang : TULang;

implementation

uses
  UnitPasVar;

function TULang.GetLang (AFileExt : string) : TASETypeLang;
begin
  Result := VUVar.vSynHighlighter.fcGetLang(AFileExt);
end;

function TULang.GetLangTxt (AASETypeLang : TASETypeLang) : string;
begin
  Result := VUVar.vASETypeLang[Ord(AASETypeLang)];
end;

end.

