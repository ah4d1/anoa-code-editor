unit UnitLang;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SynEdit, SynHighlighterHTML, SynHighlighterJava, SynHighlighterPas,
  SynHighlighterPHP, SynHighlighterPython, SynCompletion, UnitVar;

type
  TULang = object
    function SetHightlighter (AFileName : TFileName; ASynEdit : TSynEdit; ASynHTMLSyn :TSynHTMLSyn;
      ASynJavaSyn : TSynJavaSyn; ASynPasSyn : TSynPasSyn; ASynPHPSyn : TSynPHPSyn; ASynPythonSyn : TSynPythonSyn) : string;
    function SetLang (ALang : TASETypeLang; ASynEdit : TSynEdit;
        ASynHTMLSyn :TSynHTMLSyn; ASynJavaSyn : TSynJavaSyn; ASynPasSyn : TSynPasSyn; ASynPHPSyn : TSynPHPSyn;
          ASynPythonSyn : TSynPythonSyn;
        ASynCompletionHTML,ASynCompletionJava,ASynCompletionPas,ASynCompletionPHP,ASynCompletionPython : TSynCompletion
      ) : string;
  private
    function GetLangTxt (ALang : TASETypeLang) : string;
  end;

var
  VULang : TULang;

implementation

function TULang.SetHightlighter (AFileName : TFileName; ASynEdit : TSynEdit; ASynHTMLSyn :TSynHTMLSyn;
  ASynJavaSyn : TSynJavaSyn; ASynPasSyn : TSynPasSyn; ASynPHPSyn : TSynPHPSyn; ASynPythonSyn : TSynPythonSyn) : string;
var
  LFileExt : string;
  LLangTxt : string;
begin
  LFileExt := ExtractFileExt(AFileName);
  if Pos(LFileExt,ASynHTMLSyn.DefaultFilter) >= 1 then
  begin
    ASynEdit.Highlighter := ASynHTMLSyn;
    LLangTxt := Self.GetLangTxt(aseLangHTML);
  end
  else if Pos(LFileExt,ASynJavaSyn.DefaultFilter) >= 1 then
  begin
    ASynEdit.Highlighter := ASynJavaSyn;
    LLangTxt := Self.GetLangTxt(aseLangJava);
  end
  else if Pos(LFileExt,ASynPasSyn.DefaultFilter) >= 1 then
  begin
    ASynEdit.Highlighter := ASynPasSyn;
    LLangTxt := Self.GetLangTxt(aseLangPas);
  end
  else if Pos(LFileExt,ASynPHPSyn.DefaultFilter) >= 1 then
  begin
    ASynEdit.Highlighter := ASynPHPSyn;
    LLangTxt := Self.GetLangTxt(aseLangPHP);
  end
  else if Pos(LFileExt,ASynPythonSyn.DefaultFilter) >= 1 then
  begin
    ASynEdit.Highlighter := ASynPythonSyn;
    LLangTxt := Self.GetLangTxt(aseLangPython);
  end;
  Result := LLangTxt;
end;

function TULang.SetLang (ALang : TASETypeLang; ASynEdit : TSynEdit;
    ASynHTMLSyn :TSynHTMLSyn; ASynJavaSyn : TSynJavaSyn; ASynPasSyn : TSynPasSyn; ASynPHPSyn : TSynPHPSyn;
      ASynPythonSyn : TSynPythonSyn;
    ASynCompletionHTML,ASynCompletionJava,ASynCompletionPas,ASynCompletionPHP,ASynCompletionPython : TSynCompletion
  ) : string;
var
  LLangTxt : string;
begin
  if ALang = aseLangHTML then
  begin
    LLangTxt := Self.GetLangTxt(aseLangHTML);
    ASynEdit.Highlighter := ASynHTMLSyn;
    ASynCompletionHTML.Editor := ASynEdit;
    ASynCompletionJava.Editor := nil;
    ASynCompletionPas.Editor := nil;
    ASynCompletionPHP.Editor := nil;
    ASynCompletionPython.Editor := nil;
  end
  else if ALang = aseLangJava then
  begin
    LLangTxt := Self.GetLangTxt(aseLangJava);
    ASynEdit.Highlighter := ASynJavaSyn;
    ASynCompletionHTML.Editor := nil;
    ASynCompletionJava.Editor := ASynEdit;
    ASynCompletionPas.Editor := nil;
    ASynCompletionPHP.Editor := nil;
    ASynCompletionPython.Editor := nil;
  end
  else if ALang = aseLangPas then
  begin
    LLangTxt := Self.GetLangTxt(aseLangPas);
    ASynEdit.Highlighter := ASynPasSyn;
    ASynCompletionHTML.Editor := nil;
    ASynCompletionJava.Editor := nil;
    ASynCompletionPas.Editor := ASynEdit;
    ASynCompletionPHP.Editor := nil;
    ASynCompletionPython.Editor := nil;
  end
  else if ALang = aseLangPHP then
  begin
    LLangTxt := Self.GetLangTxt(aseLangPHP);
    ASynEdit.Highlighter := ASynPHPSyn;
    ASynCompletionHTML.Editor := nil;
    ASynCompletionJava.Editor := nil;
    ASynCompletionPas.Editor := nil;
    ASynCompletionPHP.Editor := ASynEdit;
    ASynCompletionPython.Editor := nil;
  end
  else if ALang = aseLangPython then
  begin
    LLangTxt := Self.GetLangTxt(aseLangPython);
    ASynEdit.Highlighter := ASynPythonSyn;
    ASynCompletionHTML.Editor := nil;
    ASynCompletionJava.Editor := nil;
    ASynCompletionPas.Editor := nil;
    ASynCompletionPHP.Editor := nil;
    ASynCompletionPython.Editor := ASynEdit;
  end;
  Result := LLangTxt;
end;

function TULang.GetLangTxt (ALang : TASETypeLang) : string;
var
  LLangTxt : string;
begin
  if ALang = aseLangHTML then LLangTxt := 'HTML'
    else if ALang = aseLangJava then LLangTxt := 'Java'
    else if ALang = aseLangPas then LLangTxt := 'Pascal'
    else if ALang = aseLangPHP then LLangTxt := 'PHP'
    else if ALang = aseLangPython then LLangTxt := 'Python'
  ;
  Result := LLangTxt;
end;

end.

