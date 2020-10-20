unit UnitPasLang;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SynEdit, SynCompletion, UnitPasSynHighlighter;

type
  TULang = object
    function GetLang (AFileExt : string) : TASETypeLang;
    function GetLangTxt (AASETypeLang : TASETypeLang) : string;
    function SetLang (AFileName : TFileName; ASynEdit : TSynEdit; ASynCompletion : TSynCompletion) : string; overload;
    function SetLang (ALang : TASETypeLang; ASynEdit : TSynEdit; ASynCompletion : TSynCompletion) : string; overload;
  end;

var
  VULang : TULang;

implementation

uses
  UnitPasVar, UnitPasTools;

function TULang.GetLang (AFileExt : string) : TASETypeLang;
begin
  Result := VUVar.vSynHighlighter.fcGetLang(AFileExt);
end;

function TULang.GetLangTxt (AASETypeLang : TASETypeLang) : string;
begin
  Result := VUVar.vASETypeLang[Ord(AASETypeLang)];
end;

function TULang.SetLang (AFileName : TFileName; ASynEdit : TSynEdit; ASynCompletion : TSynCompletion) : string;
var
  LFileExt : string;
  LLang : TASETypeLang;
  LLangTxt : string;
begin
  LFileExt := ExtractFileExt(AFileName);
  LLang := VUVar.vSynHighlighter.fcGetLang(LFileExt);
  LLangTxt := Self.SetLang(LLang,ASynEdit,ASynCompletion);
  Result := LLangTxt;
end;

function TULang.SetLang (ALang : TASETypeLang; ASynEdit : TSynEdit; ASynCompletion : TSynCompletion) : string;
var
  LLangTxt : string;
begin
  ASynCompletion.Editor := ASynEdit;
  ASynCompletion.ItemList := VUTools.FcStringExplode(VUVar.vReservedWords.vReservedWords[Ord(ALang)],'|');
  ASynEdit.Highlighter := VUVar.vSynHighlighter.fcGetHighlighter(ALang);
  LLangTxt := VUVar.vASETypeLang[Ord(ALang)];
  Result := LLangTxt;
end;

end.

