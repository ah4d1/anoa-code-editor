unit UnitPasPageControl;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls;

type
  TUPageControl = class
    constructor Create;
    procedure Update (APageControl : TPageControl; AImageIndex : Byte; AFileName : TFileName);
  end;

implementation

constructor TUPageControl.Create;
begin
  //
end;

procedure TUPageControl.Update (APageControl : TPageControl; AImageIndex : Byte; AFileName : TFileName);
begin
  APageControl.ActivePage.ImageIndex := AImageIndex;
  APageControl.ActivePage.Caption := ExtractFileName(AFileName);
end;

end.

