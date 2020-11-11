unit up_reservewords;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ace_synhighlighter, Dialogs;

type
  tupReserveWords = class
    constructor Create (ASynHighlighter : TAceSynHighlighter);
  private
    procedure fcResWordToArr (ASynHighlighter : TAceSynHighlighter);
    function fcResWord (ALangTxt : string) : WideString;
  end;

var
  vupReserveWords : tupReserveWords;

implementation

uses
  up_var, ac_filedir, ac_string, ac_stringlist;

constructor tupReserveWords.Create (ASynHighlighter : TAceSynHighlighter);
begin
  Self.fcResWordToArr(ASynHighlighter);
end;

procedure tupReserveWords.fcResWordToArr (ASynHighlighter : TAceSynHighlighter);
var
  i : Integer;
  LLangs : TStringList;
begin
  LLangs := ASynHighlighter.vLangs;
  for i := 0 to LLangs.Count - 1 do
  begin
    ASynHighlighter.vReservedWords.Add(string(Self.fcResWord(LLangs[i])));
  end;
end;

function tupReserveWords.fcResWord (ALangTxt : string) : WideString;
var
  LResWordList : TStringList;
begin
  LResWordList := vacFileDir.fcFileToStringList(vupVar.vAppDir + '/addon/resword/' + ALangTxt + '.rw');
  Result := vacStringList.fcToDelimited(LResWordList,'|');
end;

end.

