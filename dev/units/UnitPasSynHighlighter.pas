unit UnitPasSynHighlighter;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SynEditHighlighter, SynHighlighterCS, SynHighlighterHTML, SynHighlighterJava,
  SynHighlighterJSON, SynHighlighterPas, SynHighlighterPHP, SynHighlighterPython;

type
  TASETypeLang = (aseLangCSharp,aseLangHTML,aseLangJava,aseLangJSON,aseLangPas,aseLangPHP,aseLangPython);
  {After add TASETypeLang, see also vASETypeLang & vReservedWords at UnitPasVar}

  TUSynHighlighter = class
    vCS : TSynCSSyn;
    vHTML : TSynHTMLSyn;
    vJava : TSynJavaSyn;
    vJSON : TSynJSONSyn;
    vPas : TSynPasSyn;
    vPHP : TSynPHPSyn;
    vPython : TSynPythonSyn;
    constructor Create (AOwner : TComponent);
    function fcSetDefaultFilter : WideString;
    function fcGetLang (AFileExt : string) : TASETypeLang;
    function fcGetHighlighter (ALang : TASETypeLang) : TSynCustomHighlighter;
  end;

implementation

constructor TUSynHighlighter.Create (AOwner : TComponent);
begin
  vCS := TSynCSSyn.Create(AOwner);
  vHTML := TSynHTMLSyn.Create(AOwner);
  vJava := TSynJavaSyn.Create(AOwner);
  vJSON := TSynJSONSyn.Create(AOwner);
  vPas := TSynPasSyn.Create(AOwner);
  vPHP := TSynPHPSyn.Create(AOwner);
  vPython := TSynPythonSyn.Create(AOwner);
end;

function TUSynHighlighter.fcSetDefaultFilter : WideString;
begin
  Result := ''
    + 'All Files (*.*)|*.*'
    + '|' + Self.vCS.DefaultFilter
    + '|' + Self.vHTML.DefaultFilter
    + '|' + Self.vJava.DefaultFilter
    + '|' + Self.vJSOn.DefaultFilter
    + '|' + Self.vPas.DefaultFilter
    + '|' + Self.vPHP.DefaultFilter
     + '|' + Self.vPython.DefaultFilter
  ;
end;

function TUSynHighlighter.fcGetLang (AFileExt : string) : TASETypeLang;
var
  LLang : TASETypeLang;
begin
  if Pos(AFileExt,Self.vCS.DefaultFilter) >= 1 then LLang := aseLangCSharp
    else if Pos(AFileExt,Self.vHTML.DefaultFilter) >= 1 then LLang := aseLangHTML
    else if Pos(AFileExt,Self.vJava.DefaultFilter) >= 1 then LLang := aseLangJava
    else if Pos(AFileExt,Self.vJSON.DefaultFilter) >= 1 then LLang := aseLangJSON
    else if Pos(AFileExt,Self.vPas.DefaultFilter) >= 1 then LLang := aseLangPas
    else if Pos(AFileExt,Self.vPHP.DefaultFilter) >= 1 then LLang := aseLangPHP
    else if Pos(AFileExt,Self.vPython.DefaultFilter) >= 1 then LLang := aseLangPython
  ;
  Result := LLang;
end;

function TUSynHighlighter.fcGetHighlighter (ALang : TASETypeLang) : TSynCustomHighlighter;
var
  LResult : TSynCustomHighlighter;
begin
  case ALang of
    aseLangCSharp : LResult := Self.vCS;
    aseLangHTML   : LResult := Self.vHTML;
    aseLangJava   : LResult := Self.vJava;
    aseLangJSON   : LResult := Self.vJSON;
    aseLangPas    : LResult := Self.vPas;
    aseLangPHP    : LResult := Self.vPHP;
    aseLangPython : LResult := Self.vPython;
  end;
  Result := LResult;
end;

end.

