unit up_lang;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Dialogs, ace_synhighlighter;

type
  tupLang = object
    function fcGetLang (AFileExt : string) : TAceShLang;
    function fcGetLangTxt (ALang : TAceShLang) : string;
  end;

var
  vupLang : tupLang;

implementation

uses
  up_var;

function tupLang.fcGetLang (AFileExt : string) : TAceShLang;
begin
  vupVar.vSynHighlighter.vExt := AFileExt;
  Result := vupVar.vSynHighlighter.vLang;
end;

function tupLang.fcGetLangTxt (ALang : TAceShLang) : string;
begin
  Result := vupVar.vLang[Ord(ALang)];
end;

end.

