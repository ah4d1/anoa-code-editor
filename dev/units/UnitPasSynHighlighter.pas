unit UnitPasSynHighlighter;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SynHighlighterCS, SynHighlighterHTML, SynHighlighterJava, SynHighlighterJSON,
  SynHighlighterPas, SynHighlighterPHP, SynHighlighterPython;

type
  TUSynHighlighter = class
    vCS : TSynCSSyn;
    vHTML : TSynHTMLSyn;
    vJava : TSynJavaSyn;
    vJSON : TSynJSONSyn;
    vPas : TSynPasSyn;
    vPHP : TSynPHPSyn;
    vPython : TSynPythonSyn;
    constructor Create (AOwner : TComponent);
    function fcDefaultFilter : WideString;
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

function TUSynHighlighter.fcDefaultFilter : WideString;
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

end.

