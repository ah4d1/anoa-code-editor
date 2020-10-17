unit UnitPasLang;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SynEdit, SynHighlighterHTML, SynHighlighterJava, SynHighlighterJSON, SynHighlighterPas,
  SynHighlighterPHP, SynHighlighterPython, SynCompletion, UnitPasVar;

type
  TULang = object
    function SetHightlighter (AFileName : TFileName; ASynEdit : TSynEdit; ASynHTMLSyn :TSynHTMLSyn;
      ASynJavaSyn : TSynJavaSyn; ASynJSONSyn : TSynJSONSyn; ASynPasSyn : TSynPasSyn; ASynPHPSyn : TSynPHPSyn;
      ASynPythonSyn : TSynPythonSyn) : string;
    function SetLang (ALang : TASETypeLang; ASynEdit : TSynEdit;
        ASynHTMLSyn :TSynHTMLSyn; ASynJavaSyn : TSynJavaSyn; ASynJSONSyn : TSynJSONSyn; ASynPasSyn : TSynPasSyn;
          ASynPHPSyn : TSynPHPSyn; ASynPythonSyn : TSynPythonSyn;
        ASynCompletionHTML, ASynCompletionJava, ASynCompletionJSON, ASynCompletionPas,
          ASynCompletionPHP, ASynCompletionPython : TSynCompletion
      ) : string;
  private
    procedure SetSynCompletionEditorToNil (ASynCompletionHTML, ASynCompletionJava, ASynCompletionJSON,
        ASynCompletionPas, ASynCompletionPHP, ASynCompletionPython : TSynCompletion);
    function GetLangTxt (ALang : TASETypeLang) : string;
  end;

var
  VULang : TULang;

implementation

function TULang.SetHightlighter (AFileName : TFileName; ASynEdit : TSynEdit; ASynHTMLSyn :TSynHTMLSyn;
  ASynJavaSyn : TSynJavaSyn; ASynJSONSyn : TSynJSONSyn; ASynPasSyn : TSynPasSyn; ASynPHPSyn : TSynPHPSyn;
  ASynPythonSyn : TSynPythonSyn) : string;
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
  else if Pos(LFileExt,ASynJSONSyn.DefaultFilter) >= 1 then
  begin
    ASynEdit.Highlighter := ASynJSONSyn;
    LLangTxt := Self.GetLangTxt(aseLangJSON);
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
    ASynHTMLSyn :TSynHTMLSyn; ASynJavaSyn : TSynJavaSyn; ASynJSONSyn : TSynJSONSyn; ASynPasSyn : TSynPasSyn;
      ASynPHPSyn : TSynPHPSyn; ASynPythonSyn : TSynPythonSyn;
    ASynCompletionHTML, ASynCompletionJava, ASynCompletionJSON, ASynCompletionPas,
      ASynCompletionPHP, ASynCompletionPython : TSynCompletion
  ) : string;
var
  LLangTxt : string;
begin
  Self.SetSynCompletionEditorToNil(ASynCompletionHTML, ASynCompletionJava, ASynCompletionJSON,
    ASynCompletionPas, ASynCompletionPHP, ASynCompletionPython
  );
  if ALang = aseLangHTML then
  begin
    LLangTxt := Self.GetLangTxt(aseLangHTML);
    ASynEdit.Highlighter := ASynHTMLSyn;
    ASynCompletionHTML.Editor := ASynEdit;
  end
  else if ALang = aseLangJava then
  begin
    LLangTxt := Self.GetLangTxt(aseLangJava);
    ASynEdit.Highlighter := ASynJavaSyn;
    ASynCompletionJava.Editor := ASynEdit;
  end
  else if ALang = aseLangJSON then
  begin
    LLangTxt := Self.GetLangTxt(aseLangJSON);
    ASynEdit.Highlighter := ASynJSONSyn;
    ASynCompletionJSON.Editor := ASynEdit;
  end
  else if ALang = aseLangPas then
  begin
    LLangTxt := Self.GetLangTxt(aseLangPas);
    ASynEdit.Highlighter := ASynPasSyn;
    ASynCompletionPas.Editor := ASynEdit;
  end
  else if ALang = aseLangPHP then
  begin
    LLangTxt := Self.GetLangTxt(aseLangPHP);
    ASynEdit.Highlighter := ASynPHPSyn;
    ASynCompletionPHP.Editor := ASynEdit;
  end
  else if ALang = aseLangPython then
  begin
    LLangTxt := Self.GetLangTxt(aseLangPython);
    ASynEdit.Highlighter := ASynPythonSyn;
    ASynCompletionPython.Editor := ASynEdit;
  end;
  Result := LLangTxt;
end;

procedure TULang.SetSynCompletionEditorToNil (ASynCompletionHTML, ASynCompletionJava, ASynCompletionJSON,
    ASynCompletionPas, ASynCompletionPHP, ASynCompletionPython : TSynCompletion);
begin
  ASynCompletionHTML.Editor := nil;
  ASynCompletionJava.Editor := nil;
  ASynCompletionJSON.Editor := nil;
  ASynCompletionPas.Editor := nil;
  ASynCompletionPHP.Editor := nil;
  ASynCompletionPython.Editor := nil;
end;

function TULang.GetLangTxt (ALang : TASETypeLang) : string;
var
  LLangTxt : string;
begin
  LLangTxt := VUVar.vASETypeLang[Ord(ALang)];
  Result := LLangTxt;
end;

end.

