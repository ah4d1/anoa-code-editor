unit up_reservewords;

{
HOW TO ADD NEW RESERVED WORD :
1. Add reserve word list *.rw in directory addon/resword
}

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ace_synhighlighter;

type
  tupReserveWords = class
    vReservedWords    : array[0..10] of WideString; // always check size of the array
    constructor Create (ASynHighlighter : TAceSynHighlighter);
  private
    procedure fcResWordToArr (ALang : Widestring);
    function fcResWord (ALangTxt : string) : WideString;
  end;

var
  vupReserveWords : tupReserveWords;

implementation

uses
  up_var, ac_filedir, ac_string, ac_stringlist;

constructor tupReserveWords.Create (ASynHighlighter : TAceSynHighlighter);
begin
  Self.fcResWordToArr(ASynHighlighter.vLangResWordFile);
end;

procedure tupReserveWords.fcResWordToArr (ALang : Widestring);
var
  i : Integer;
  LLangs : TStringList;
begin
  LLangs := vacString.fcSplit(string(ALang),Char('|'));
  for i := 0 to LLangs.Count - 1 do
    Self.vReservedWords[i] := Self.fcResWord(LLangs[i])
  ;
end;

function tupReserveWords.fcResWord (ALangTxt : string) : WideString;
var
  LResWordList : TStringList;
begin
  LResWordList := vacFileDir.fcFileToStringList(vupVar.vAppDir + '/addon/resword/' + ALangTxt + '.rw');
  Result := vacStringList.fcToDelimited(LResWordList,'|');
end;

end.

