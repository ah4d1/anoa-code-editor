unit UnitCmpSynCompletion;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SynCompletion, UnitPasSynHighlighter;

type
  TUSynCompletion = class(TSynCompletion)
    constructor Create (AOwner : TComponent); override;
    procedure fcUpdate (ALang : TASETypeLang);
  end;

implementation

uses
  UnitPasVar, UnitPasTools;

constructor TUSynCompletion.Create (AOwner : TComponent);
begin
  inherited Create(AOwner);
end;

procedure TUSynCompletion.fcUpdate (ALang : TASETypeLang);
begin
  Self.ItemList := VUTools.FcStringExplode(VUVar.vReservedWords.vReservedWords[Ord(ALang)],'|');
end;

end.

