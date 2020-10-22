unit up_var;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SynEditHighlighter, up_synhighlighter, up_reservewords;

type
  tupVar = class
    vTabPrefix : string;
    vTabNo : Byte;
    vLang : TStringList;
    vImageIndexNormalFile : Byte;
    vImageIndexModifiedFile : Byte;
    vSynHighlighter : tupSynHighlighter;
    vReservedWords : tupReserveWords;
    constructor Create (AOwner : TComponent);
  end;

var
  vupVar : tupVar;

implementation

uses
  up_lang, up_tools;

constructor tupVar.Create (AOwner : TComponent);
begin
  Self.vTabPrefix := 'Tab';
  Self.vTabNo := 0;
  Self.vImageIndexNormalFile := 3;
  Self.vImageIndexModifiedFile := 4;
  Self.vSynHighlighter := tupSynHighlighter.Create(AOwner);
  Self.vReservedWords := tupReserveWords.Create(AOwner);
  Self.vLang := vupTools.FcStringExplode(Self.vReservedWords.vLangTxt,'|');
end;

end.

