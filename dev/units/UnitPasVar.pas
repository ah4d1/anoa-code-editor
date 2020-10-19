unit UnitPasVar;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, UnitPasSynHighlighter, UnitPasReserveWords;

type
  TUVar = class
    vCurrentFileName : TFileName;
    vImageIndexNormalFile : Byte;
    vImageIndexModifiedFile : Byte;
    vASETypeLang : TStringList;
    vSynHighlighter : TUSynHighlighter;
    vReservedWords : TUReserveWords;
    constructor Create (AOwner : TComponent);
  end;

var
  VUVar : TUVar;

implementation

uses
  UnitPasTools;

constructor TUVar.Create (AOwner : TComponent);
begin
  Self.vCurrentFileName := '';
  Self.vImageIndexNormalFile := 3;
  Self.vImageIndexModifiedFile := 4;
  Self.vASETypeLang := VUTools.FcStringExplode('C#|HTML|Java|JSON|Pascal|PHP|Python','|');
  Self.vSynHighlighter := TUSynHighlighter.Create(AOwner);
  Self.vReservedWords := TUReserveWords.Create(AOwner);
end;

end.

