unit up_var;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SynEditHighlighter, up_synhighlighter, up_reservewords;

type
  tupVar = class
    vTabPrefix : string;
    vTabNo : Byte;
    vImageIndexNormalFile : Byte;
    vImageIndexModifiedFile : Byte;
    vSynHighlighter : tupSynHighlighter;
    vReservedWords : tupReserveWords;
    vLang : TStringList;
    vDefaultFontSize : Byte;
    constructor Create (AOwner : TComponent);
    function fcFileName (AFileName : TFileName; var ATmpFile : Boolean) : TFileName;
  end;

var
  vupVar : tupVar;

implementation

uses
  up_lang, ac_string, ac_filedir;

constructor tupVar.Create (AOwner : TComponent);
begin
  Self.vTabPrefix := 'Tab';
  Self.vTabNo := 0;
  Self.vImageIndexNormalFile := 3;
  Self.vImageIndexModifiedFile := 4;
  Self.vSynHighlighter := tupSynHighlighter.Create(AOwner);
  Self.vReservedWords := tupReserveWords.Create(AOwner);
  Self.vLang := vacString.fcSplit(Self.vReservedWords.vLangTxt,'|');
  Self.vDefaultFontSize := 9;
end;

function tupVar.fcFileName (AFileName : TFileName; var ATmpFile : Boolean) : TFileName;
var
  LFileName : TFileName;
  LTmpFile : Boolean;
begin
  if Trim(AFileName) <> '' then
  begin
    LFileName := AFileName;
    LTmpFile := False;
  end
  else
  begin
    LFileName := vacFileDir.fcTmpFileName;
    LTmpFile := True;
  end;
  ATmpFile := LTmpFile;
  Result := LFileName;
end;

end.

