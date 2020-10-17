unit unit_lang;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SynEdit, SynHighlighterHTML, SynHighlighterJava, SynHighlighterPas,
  SynHighlighterPHP;

type
  TULang = object
    procedure SetHightlighter (AFileName : TFileName; ASynEdit : TSynEdit; ASynHTMLSyn : TSynHTMLSyn;
      ASynJavaSyn : TSynJavaSyn; ASynPasSyn : TSynPasSyn; ASynPHPSyn : TSynPHPSyn);
  end;

var
  VULang : TULang;

implementation

procedure TULang.SetHightlighter (AFileName : TFileName; ASynEdit : TSynEdit; ASynHTMLSyn :TSynHTMLSyn;
  ASynJavaSyn : TSynJavaSyn; ASynPasSyn : TSynPasSyn; ASynPHPSyn : TSynPHPSyn);
var
  LFileExt : string;
begin
  LFileExt := ExtractFileExt(AFileName);
  if Pos(LFileExt,ASynHTMLSyn.DefaultFilter) >= 1 then ASynEdit.Highlighter := ASynHTMLSyn
    else if Pos(LFileExt,ASynJavaSyn.DefaultFilter) >= 1 then ASynEdit.Highlighter := ASynJavaSyn
    else if Pos(LFileExt,ASynPasSyn.DefaultFilter) >= 1 then ASynEdit.Highlighter := ASynPasSyn
    else if Pos(LFileExt,ASynPHPSyn.DefaultFilter) >= 1 then ASynEdit.Highlighter := ASynPHPSyn
  ;
end;

end.

