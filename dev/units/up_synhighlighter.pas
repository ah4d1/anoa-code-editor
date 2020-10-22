unit up_synhighlighter;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SynEditHighlighter, SynHighlighterCobol, SynHighlighterCS, SynHighlighterCSS,
  SynHighlighterHTML, SynHighlighterJava, SynHighlighterJSON, SynHighlighterPas, SynHighlighterPHP,
  SynHighlighterPython, SynHighlighterSQL, Dialogs;

type
  taseLang = (aseLangNone,aseLangCobol,aseLangCS,aseLangCSS,aseLangHTML,aseLangJava,aseLangJSON,aseLangPas
    ,aseLangPHP,aseLangPython,aseLangSQL
  );
  tupSynHighlighter = class
    vNone   : TSynCustomHighLighter;
    vCobol  : TSynCobolSyn;
    vCS     : TSynCSSyn;
    vCSS    : TSynCSSSyn;
    vHTML   : TSynHTMLSyn;
    vJava   : TSynJavaSyn;
    vJSON   : TSynJSONSyn;
    vPas    : TSynPasSyn;
    vPHP    : TSynPHPSyn;
    vPython : TSynPythonSyn;
    vSQL    : TSynSQLSyn;
    constructor Create (AOwner : TComponent);
    function fcSetDefaultFilter : WideString;
    function fcGetLang (AFileExt : string) : taseLang;
    function fcGetHighlighter (ALang : taseLang) : TSynCustomHighlighter;
  private
    function fcIsExt (AFileExt : string; ADefaultFilter : string) : Boolean;
  end;

implementation

uses
  up_tools;

constructor tupSynHighlighter.Create (AOwner : TComponent);
begin
  Self.vNone   := nil;
  Self.vCobol  := TSynCobolSyn.Create(AOwner);
  Self.vCS     := TSynCSSyn.Create(AOwner);
  Self.vCSS    := TSynCSSSyn.Create(AOwner);
  Self.vHTML   := TSynHTMLSyn.Create(AOwner);
  Self.vJava   := TSynJavaSyn.Create(AOwner);
  Self.vJSON   := TSynJSONSyn.Create(AOwner);
  Self.vPas    := TSynPasSyn.Create(AOwner);
  Self.vPHP    := TSynPHPSyn.Create(AOwner);
  Self.vPython := TSynPythonSyn.Create(AOwner);
  Self.vSQL    := TSynSQLSyn.Create(AOwner);
end;

function tupSynHighlighter.fcSetDefaultFilter : WideString;
begin
  Result := ''
    + 'All Files (*.*)|*.*'
    + '|' + Self.vCobol.DefaultFilter
    + '|' + Self.vCS.DefaultFilter
    + '|' + Self.vCSS.DefaultFilter
    + '|' + Self.vHTML.DefaultFilter
    + '|' + Self.vJava.DefaultFilter
    + '|' + Self.vJSOn.DefaultFilter
    + '|' + Self.vPas.DefaultFilter
    + '|' + Self.vPHP.DefaultFilter
    + '|' + Self.vPython.DefaultFilter
    + '|' + Self.vSQL.DefaultFilter
  ;
end;

function tupSynHighlighter.fcGetLang (AFileExt : string) : taseLang;
var
  LLang : taseLang;
begin
  LLang := aseLangNone;
  if Self.fcIsExt(AFileExt,Self.vCobol.DefaultFilter) then LLang := aseLangCobol
    else if Self.fcIsExt(AFileExt,Self.vCS.DefaultFilter) then LLang := aseLangCS
    else if Self.fcIsExt(AFileExt,Self.vCSS.DefaultFilter) then LLang := aseLangCSS
    else if Self.fcIsExt(AFileExt,Self.vHTML.DefaultFilter) then LLang := aseLangHTML
    else if Self.fcIsExt(AFileExt,Self.vJava.DefaultFilter) then LLang := aseLangJava
    else if Self.fcIsExt(AFileExt,Self.vJSON.DefaultFilter) then LLang := aseLangJSON
    else if Self.fcIsExt(AFileExt,Self.vPas.DefaultFilter) then LLang := aseLangPas
    else if Self.fcIsExt(AFileExt,Self.vPHP.DefaultFilter) then LLang := aseLangPHP
    else if Self.fcIsExt(AFileExt,Self.vPython.DefaultFilter) then LLang := aseLangPython
    else if Self.fcIsExt(AFileExt,Self.vSQL.DefaultFilter) then LLang := aseLangSQL
  ;
  Result := LLang;
end;

function tupSynHighlighter.fcGetHighlighter (ALang : taseLang) : TSynCustomHighlighter;
var
  LResult : TSynCustomHighlighter;
begin
  case ALang of
    aseLangNone   : LResult := Self.vNone;
    aseLangCobol  : LResult := Self.vCobol;
    aseLangCS     : LResult := Self.vCS;
    aseLangCSS    : LResult := Self.vCSS;
    aseLangHTML   : LResult := Self.vHTML;
    aseLangJava   : LResult := Self.vJava;
    aseLangJSON   : LResult := Self.vJSON;
    aseLangPas    : LResult := Self.vPas;
    aseLangPHP    : LResult := Self.vPHP;
    aseLangPython : LResult := Self.vPython;
    aseLangSQL    : LResult := Self.vSQL;
  end;
  Result := LResult;
end;

function tupSynHighlighter.fcIsExt (AFileExt : string; ADefaultFilter : string) : Boolean;
var
  i : Byte;
  LFilters : TStringList;
  LExts : TStringList;
  LFound : Boolean;
begin
  LFilters := vupTools.fcStringExplode(ADefaultFilter,'|');
  LExts := vupTools.fcStringExplode(LFilters[1],';');
  LFound := False;
  for i := 0 to LExts.Count - 1 do
  begin
    if '*' + AFileExt = LExts[i] then
    begin
      LFound := True;
      Break;
    end;
  end;
  Result := LFound;
end;

end.

