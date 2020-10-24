unit ac_color;

{**************************************************************
*  A Part of Anoa-Core                                        *
*  See https://github.com/ah4d1/anoa-core                     *
**************************************************************}

interface

uses
  Classes, SysUtils, Graphics;

type
  tacColor = object
  public
    function fcInvert (AColor: TColor): TColor;
  end;

var
  vacColor : tacColor;

implementation

function tacColor.fcInvert (AColor: TColor): TColor;
begin
  Result := clWhite - ColorToRGB(AColor);
    // OR : RGBToColor(255 - Red(AColor), 255- Green(AColor), 255 - Blue(AColor));
end;

end.

