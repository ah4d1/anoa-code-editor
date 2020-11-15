unit up_lang;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Dialogs, ace_synhighlighter;

type
  TUpLang = object
    function fcGetLang (AFileExt : string) : TAceShLang;
    function fcGetLangTxt (ALang : TAceShLang) : string;
  end;

var
  vupLang : TUpLang;

implementation

uses
  up_var;

function TUpLang.fcGetLang (AFileExt : string) : TAceShLang;
begin
  vupVar.vSynHighlighter.vExt := AFileExt;
  Result := vupVar.vSynHighlighter.vLang;
end;

function TUpLang.fcGetLangTxt (ALang : TAceShLang) : string;
begin
  Result := vupVar.vLang[Ord(ALang)];
end;

end.

