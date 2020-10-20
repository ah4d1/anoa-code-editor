unit UnitPasSynCompletion;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SynCompletion, UnitPasSynHighlighter;

type
  TUSynCompletion = class
    constructor Create;
    procedure Update (ASynCompletion : TSynCompletion; ALang : TASETypeLang);
  end;

implementation

uses
  UnitPasVar, UnitPasTools;

constructor TUSynCompletion.Create;
begin
  //
end;

procedure TUSynCompletion.Update (ASynCompletion : TSynCompletion; ALang : TASETypeLang);
begin
  ASynCompletion.ItemList := VUTools.FcStringExplode(VUVar.vReservedWords.vReservedWords[Ord(ALang)],'|');
end;

end.

