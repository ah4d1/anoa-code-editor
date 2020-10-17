unit unit_save;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SynEdit, ComCtrls;

type
  TUSave = object
    procedure Save (AFileName : TFileName; ASynEdit : TSynEdit; APageControlMain : TPageControl;
      AImageIndex : Byte);
  end;

var
  VUSave : TUSave;

implementation

procedure TUSave.Save (AFileName : TFileName; ASynEdit : TSynEdit; APageControlMain : TPageControl;
  AImageIndex : Byte);
begin
  if FileExists(AFileName) then
  begin
    ASynEdit.Lines.SaveToFile(AFileName);
    APageControlMain.ActivePage.ImageIndex := AImageIndex;
  end;
end;

end.

