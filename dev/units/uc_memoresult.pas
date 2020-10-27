unit uc_memoresult;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, StdCtrls, Controls, Graphics;

type
  tucMemoResult = class(TMemo)
    constructor Create (AOwner : TComponent); override;
  end;

implementation

constructor tucMemoResult.Create (AOwner : TComponent);
begin
  inherited Create(AOwner);
  Self.Align := alBottom;
  Self.Color := clBlack;
  Self.Font.Color := clWhite;
  Self.Height := 0;
  Self.ReadOnly := True;
  Self.ScrollBars := ssAutoBoth;
end;

end.

