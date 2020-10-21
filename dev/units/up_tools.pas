unit up_tools;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Registry, Graphics;

type
  tupTools = object
    function fcParamsInSingleText : WideString;
    procedure fcAddAppToWinExplorerContextMenu (AMenuTitle : string; AAppExeName : TFileName);
    procedure fcRegistryWriteString (ARootKey : HKEY; AKey,AName,AValue : string);
    function fcStringExplode (AString : string; ADelimiter : Char) : TStringList;
    function fcComplementaryColor (AColor: TColor): TColor;
  end;

var
  vupTools : tupTools;

implementation

// Get Params that sent to app
function tupTools.fcParamsInSingleText : WideString;
var
  i : Cardinal;
  LResult : WideString;
begin
  LResult := '';
  for i := 1 to ParamCount() do
  begin
    LResult := Trim(LResult + ' ' + ParamStr(i));
  end;
  Result := LResult;
end;

// App must be as Administrator
procedure tupTools.fcAddAppToWinExplorerContextMenu (AMenuTitle : string; AAppExeName : TFileName);
begin
  Self.FcRegistryWriteString(HKEY_CLASSES_ROOT,'*\shell\' + AMenuTitle + '\command\',
    '','"' + AAppExeName + '" %1')
  ;
end;

procedure tupTools.fcRegistryWriteString (ARootKey : HKEY; AKey,AName,AValue : string);
var
  LRegistry : TRegistry;
begin
  LRegistry := TRegistry.Create();
  LRegistry.RootKey := ARootKey;
  LRegistry.OpenKey(AKey,True);
  LRegistry.WriteString(AName,AValue);
  LRegistry.CloseKey();
  LRegistry.Free;
end;

function tupTools.fcStringExplode (AString : string; ADelimiter : Char) : TStringList;
var
  LStrings : TStringList;
begin
  LStrings := TStringList.Create;
  LStrings.StrictDelimiter := True; // only use chosen delimiter, if FALSE then space will be treated as delimiter
  LStrings.Delimiter := ADelimiter; // set char as delimiter
  LStrings.DelimitedText := AString;
  Result := LStrings
end;

function tupTools.fcComplementaryColor (AColor: TColor): TColor;
begin
  Result := clWhite - ColorToRGB(AColor);
    // OR : RGBToColor(255 - Red(AColor), 255- Green(AColor), 255 - Blue(AColor));
end;

end.

