unit up_lang;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ac_synhighlighter;

type
  tupLang = object
    function fcGetLang (AFileExt : string) : TShLang;
    function fcGetLangTxt (ALang : TShLang) : string;
  end;

var
  vupLang : tupLang;

implementation

uses
  up_var;

function tupLang.fcGetLang (AFileExt : string) : TShLang;
begin
  vupVar.vSynHighlighter.vExt := AFileExt;
  Result := vupVar.vSynHighlighter.vLang;
  // Result := vupVar.vSynHighlighter.fcGetLang(AFileExt);
end;

function tupLang.fcGetLangTxt (ALang : TShLang) : string;
begin
  Result := vupVar.vLang[Ord(ALang)];
end;

end.

