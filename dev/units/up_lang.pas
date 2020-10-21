unit up_lang;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, up_synhighlighter;

type
  tupLang = object
    function fcGetLang (AFileExt : string) : TASETypeLang;
    function fcGetLangTxt (AASETypeLang : TASETypeLang) : string;
  end;

var
  vupLang : tupLang;

implementation

uses
  up_var;

function tupLang.fcGetLang (AFileExt : string) : TASETypeLang;
begin
  Result := vupVar.vSynHighlighter.fcGetLang(AFileExt);
end;

function tupLang.fcGetLangTxt (AASETypeLang : TASETypeLang) : string;
begin
  Result := vupVar.vASETypeLang[Ord(AASETypeLang)];
end;

end.

