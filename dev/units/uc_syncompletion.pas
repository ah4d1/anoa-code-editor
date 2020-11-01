unit uc_syncompletion;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SynCompletion, up_synhighlighter, ac_string;

type
  tucSynCompletion = class(TSynCompletion)
    constructor Create (AOwner : TComponent); override;
    procedure fcUpdate (ALang : taseLang);
  end;

implementation

uses
  up_var;

constructor tucSynCompletion.Create (AOwner : TComponent);
begin
  inherited Create(AOwner);
end;

procedure tucSynCompletion.fcUpdate (ALang : taseLang);
begin
  Self.ItemList := vacString.fcSplit(vupVar.vReservedWords.vReservedWords[Ord(ALang)],'|');
end;

end.

