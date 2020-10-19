unit UnitPasVar;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, UnitPasSynHighlighter;

type
  TUVar = class
    vCurrentFileName : TFileName;
    vImageIndexNormalFile : Byte;
    vImageIndexModifiedFile : Byte;
    vASETypeLang : TStringList;
    vSynHighlighter : TUSynHighlighter;
    vReservedWords : array[0..6] of WideString; // to determine size of the array, see TASETypeLang
    constructor Create (AOwner : TComponent);
  end;

var
  VUVar : TUVar;

implementation

uses
  UnitPasReserveWords, UnitPasTools;

constructor TUVar.Create (AOwner : TComponent);
var
  LRsrvWrd : Integer;
begin
  Self.vCurrentFileName := '';
  Self.vImageIndexNormalFile := 3;
  Self.vImageIndexModifiedFile := 4;
  vASETypeLang := VUTools.FcStringExplode('C#|HTML|Java|JSON|Pascal|PHP|Python','|');
  vSynHighlighter := TUSynHighlighter.Create(AOwner);
  {Reserve Words}
  LRsrvWrd := -1;
  LRsrvWrd := LRsrvWrd + 1; vReservedWords[LRsrvWrd] := VUReserveWords.fcCS;
  LRsrvWrd := LRsrvWrd + 1; vReservedWords[LRsrvWrd] := VUReserveWords.fcHTML;
  LRsrvWrd := LRsrvWrd + 1; vReservedWords[LRsrvWrd] := VUReserveWords.fcJava;
  LRsrvWrd := LRsrvWrd + 1; vReservedWords[LRsrvWrd] := VUReserveWords.fcJSON;
  LRsrvWrd := LRsrvWrd + 1; vReservedWords[LRsrvWrd] := VUReserveWords.fcPascal;
  LRsrvWrd := LRsrvWrd + 1; vReservedWords[LRsrvWrd] := VUReserveWords.fcPHP;
  LRsrvWrd := LRsrvWrd + 1; vReservedWords[LRsrvWrd] := VUReserveWords.fcPython;
end;

end.

