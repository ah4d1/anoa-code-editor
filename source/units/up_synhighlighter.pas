unit up_synhighlighter;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SynEditHighlighter, SynHighlighterCobol, SynHighlighterCS, SynHighlighterHTML,
  SynHighlighterJava, SynHighlighterJSON, SynHighlighterPas, SynHighlighterPHP, SynHighlighterPython,
  SynHighlighterSQL;

type
  taseLang = (aseLangNone,aseLangCobol,aseLangCS,aseLangHTML,aseLangJava,aseLangJSON,aseLangPas
    ,aseLangPHP,aseLangPython,aseLangSQL
  );
  tupSynHighlighter = class
    vNone   : TSynCustomHighLighter;
    vCobol  : TSynCobolSyn;
    vCS     : TSynCSSyn;
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
  end;

implementation

constructor tupSynHighlighter.Create (AOwner : TComponent);
begin
  Self.vNone   := nil;
  Self.vCobol  := TSynCobolSyn.Create(AOwner);
  Self.vCS     := TSynCSSyn.Create(AOwner);
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
  if Pos(AFileExt,Self.vCobol.DefaultFilter) >= 1 then LLang := aseLangCobol
    else if Pos(AFileExt,Self.vCS.DefaultFilter) >= 1 then LLang := aseLangCS
    else if Pos(AFileExt,Self.vHTML.DefaultFilter) >= 1 then LLang := aseLangHTML
    else if Pos(AFileExt,Self.vJava.DefaultFilter) >= 1 then LLang := aseLangJava
    else if Pos(AFileExt,Self.vJSON.DefaultFilter) >= 1 then LLang := aseLangJSON
    else if Pos(AFileExt,Self.vPas.DefaultFilter) >= 1 then LLang := aseLangPas
    else if Pos(AFileExt,Self.vPHP.DefaultFilter) >= 1 then LLang := aseLangPHP
    else if Pos(AFileExt,Self.vPython.DefaultFilter) >= 1 then LLang := aseLangPython
    else if Pos(AFileExt,Self.vSQL.DefaultFilter) >= 1 then LLang := aseLangSQL
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

end.

