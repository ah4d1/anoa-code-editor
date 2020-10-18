unit UnitPasLang;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SynEdit, SynHighlighterCS, SynHighlighterHTML, SynHighlighterJava, SynHighlighterJSON,
  SynHighlighterPas, SynHighlighterPHP, SynHighlighterPython, SynCompletion, UnitPasVar;

type
  TULang = object
    function SetLang (AFileName : TFileName; ASynEdit : TSynEdit;
      ASynCSSyn : TSynCSSyn; ASynHTMLSyn : TSynHTMLSyn; ASynJavaSyn : TSynJavaSyn; ASynJSONSyn : TSynJSONSyn;
        ASynPasSyn : TSynPasSyn; ASynPHPSyn : TSynPHPSyn; ASynPythonSyn : TSynPythonSyn;
      ASynCompletion : TSynCompletion) : string; overload;
    function SetLang (ALang : TASETypeLang; ASynEdit : TSynEdit;
      ASynCSSyn : TSynCSSyn; ASynHTMLSyn : TSynHTMLSyn; ASynJavaSyn : TSynJavaSyn; ASynJSONSyn : TSynJSONSyn;
        ASynPasSyn : TSynPasSyn; ASynPHPSyn : TSynPHPSyn; ASynPythonSyn : TSynPythonSyn;
      ASynCompletion : TSynCompletion
      ) : string;  overload;
  end;

var
  VULang : TULang;

implementation

uses
  UnitPasTools;

function TULang.SetLang (AFileName : TFileName; ASynEdit : TSynEdit;
  ASynCSSyn :TSynCSSyn; ASynHTMLSyn :TSynHTMLSyn; ASynJavaSyn : TSynJavaSyn; ASynJSONSyn : TSynJSONSyn;
    ASynPasSyn : TSynPasSyn; ASynPHPSyn : TSynPHPSyn; ASynPythonSyn : TSynPythonSyn;
  ASynCompletion : TSynCompletion) : string;
var
  LFileExt : string;
  LLang : TASETypeLang;
  LLangTxt : string;
begin
  LFileExt := ExtractFileExt(AFileName);
  if Pos(LFileExt,ASynCSSyn.DefaultFilter) >= 1 then LLang := aseLangCSharp
    else if Pos(LFileExt,ASynHTMLSyn.DefaultFilter) >= 1 then LLang := aseLangHTML
    else if Pos(LFileExt,ASynJavaSyn.DefaultFilter) >= 1 then LLang := aseLangJava
    else if Pos(LFileExt,ASynJSONSyn.DefaultFilter) >= 1 then LLang := aseLangJSON
    else if Pos(LFileExt,ASynPasSyn.DefaultFilter) >= 1 then LLang := aseLangPas
    else if Pos(LFileExt,ASynPHPSyn.DefaultFilter) >= 1 then LLang := aseLangPHP
    else if Pos(LFileExt,ASynPythonSyn.DefaultFilter) >= 1 then LLang := aseLangPython
  ;
  LLangTxt := Self.SetLang(LLang,ASynEdit,
    ASynCSSyn,ASynHTMLSyn,ASynJavaSyn,ASynJSONSyn,ASynPasSyn,ASynPHPSyn,ASynPythonSyn,
    ASynCompletion
  );
  Result := LLangTxt;
end;

function TULang.SetLang (ALang : TASETypeLang; ASynEdit : TSynEdit;
    ASynCSSyn : TSynCSSyn; ASynHTMLSyn : TSynHTMLSyn; ASynJavaSyn : TSynJavaSyn; ASynJSONSyn : TSynJSONSyn;
      ASynPasSyn : TSynPasSyn; ASynPHPSyn : TSynPHPSyn; ASynPythonSyn : TSynPythonSyn;
    ASynCompletion : TSynCompletion
  ) : string;
var
  LLangTxt : string;
begin
  ASynCompletion.Editor := ASynEdit;
  ASynCompletion.ItemList := VUTools.FcStringExplode(VUVar.vReservedWords[Ord(ALang)],'|');
  LLangTxt := VUVar.vASETypeLang[Ord(ALang)];
  case ALang of
    aseLangCSharp : ASynEdit.Highlighter := ASynCSSyn;
    aseLangHTML   : ASynEdit.Highlighter := ASynHTMLSyn;
    aseLangJava   : ASynEdit.Highlighter := ASynJavaSyn;
    aseLangJSON   : ASynEdit.Highlighter := ASynJSONSyn;
    aseLangPas    : ASynEdit.Highlighter := ASynPasSyn;
    aseLangPHP    : ASynEdit.Highlighter := ASynPHPSyn;
    aseLangPython : ASynEdit.Highlighter := ASynPythonSyn;
  end;
  Result := LLangTxt;
end;

end.

