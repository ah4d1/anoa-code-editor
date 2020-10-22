unit up_lang;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, up_synhighlighter;

type
  tupLang = object
    function fcGetLang (AFileExt : string) : taseLang;
    function fcGetLangTxt (ALang : taseLang) : string;
  end;

var
  vupLang : tupLang;

implementation

uses
  up_var;

function tupLang.fcGetLang (AFileExt : string) : taseLang;
begin
  Result := vupVar.vSynHighlighter.fcGetLang(AFileExt);
end;

function tupLang.fcGetLangTxt (ALang : taseLang) : string;
begin
  Result := vupVar.vLang[Ord(ALang)];
end;

end.

