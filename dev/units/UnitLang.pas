unit UnitLang;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SynEdit, SynHighlighterHTML, SynHighlighterJava, SynHighlighterPas,
  SynHighlighterPHP, SynCompletion, UnitVar;

type
  TULang = object
    procedure SetHightlighter (AFileName : TFileName; ASynEdit : TSynEdit; ASynHTMLSyn : TSynHTMLSyn;
      ASynJavaSyn : TSynJavaSyn; ASynPasSyn : TSynPasSyn; ASynPHPSyn : TSynPHPSyn);
    procedure SetLang (ALang : TASETypeLang; ASynEdit : TSynEdit;
        ASynHTMLSyn :TSynHTMLSyn; ASynJavaSyn : TSynJavaSyn; ASynPasSyn : TSynPasSyn; ASynPHPSyn : TSynPHPSyn;
        ASynCompletionHTML,ASynCompletionJava,ASynCompletionPas,ASynCompletionPHP : TSynCompletion
      );
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

procedure TULang.SetLang (ALang : TASETypeLang; ASynEdit : TSynEdit;
    ASynHTMLSyn :TSynHTMLSyn; ASynJavaSyn : TSynJavaSyn; ASynPasSyn : TSynPasSyn; ASynPHPSyn : TSynPHPSyn;
    ASynCompletionHTML,ASynCompletionJava,ASynCompletionPas,ASynCompletionPHP : TSynCompletion
  );
begin
  if ALang = aseLangHTML then
  begin
    ASynEdit.Highlighter := ASynHTMLSyn;
    ASynCompletionHTML.Editor := ASynEdit;
    ASynCompletionJava.Editor := nil;
    ASynCompletionPas.Editor := nil;
    ASynCompletionPHP.Editor := nil;
  end
  else if ALang = aseLangJava then
  begin
    ASynEdit.Highlighter := ASynJavaSyn;
    ASynCompletionHTML.Editor := nil;
    ASynCompletionJava.Editor := ASynEdit;
    ASynCompletionPas.Editor := nil;
    ASynCompletionPHP.Editor := nil;
  end
  else if ALang = aseLangPas then
  begin
    ASynEdit.Highlighter := ASynPasSyn;
    ASynCompletionHTML.Editor := nil;
    ASynCompletionJava.Editor := nil;
    ASynCompletionPas.Editor := ASynEdit;
    ASynCompletionPHP.Editor := nil;
  end
  else if ALang = aseLangPHP then
  begin
    ASynEdit.Highlighter := ASynPHPSyn;
    ASynCompletionHTML.Editor := nil;
    ASynCompletionJava.Editor := nil;
    ASynCompletionPas.Editor := nil;
    ASynCompletionPHP.Editor := ASynEdit;
  end;
end;

end.

