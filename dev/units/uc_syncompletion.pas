unit uc_syncompletion;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SynCompletion, UnitPasSynHighlighter;

type
  tucSynCompletion = class(TSynCompletion)
    constructor Create (AOwner : TComponent); override;
    procedure fcUpdate (ALang : TASETypeLang);
  end;

implementation

uses
  UnitPasVar, UnitPasTools;

constructor tucSynCompletion.Create (AOwner : TComponent);
begin
  inherited Create(AOwner);
end;

procedure tucSynCompletion.fcUpdate (ALang : TASETypeLang);
begin
  Self.ItemList := VUTools.FcStringExplode(VUVar.vReservedWords.vReservedWords[Ord(ALang)],'|');
end;

end.

