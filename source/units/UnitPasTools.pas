unit UnitPasTools;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Registry;

type
  TUTools = object
    function FcParamsInSingleText : WideString;
    procedure FcAddAppToWinExplorerContextMenu (AMenuTitle : string; AAppExeName : TFileName);
    procedure FcRegistryWriteString (ARootKey : HKEY; AKey,AName,AValue : string);
    function FcStringExplode (AString : string; ADelimiter : Char) : TStringList;
  end;

var
  VUTools : TUTools;

implementation

// Get Params that sent to app
function TUTools.FcParamsInSingleText : WideString;
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
procedure TUTools.FcAddAppToWinExplorerContextMenu (AMenuTitle : string; AAppExeName : TFileName);
begin
  Self.FcRegistryWriteString(HKEY_CLASSES_ROOT,'*\shell\' + AMenuTitle + '\command\',
    '','"' + AAppExeName + '" %1')
  ;
end;

procedure TUTools.FcRegistryWriteString (ARootKey : HKEY; AKey,AName,AValue : string);
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

function TUTools.FcStringExplode (AString : string; ADelimiter : Char) : TStringList;
var
  LStrings : TStringList;
begin
  LStrings := TStringList.Create;
  LStrings.StrictDelimiter := True; // only use chosen delimiter, if FALSE then space will be treated as delimiter
  LStrings.Delimiter := ADelimiter; // set char as delimiter
  LStrings.DelimitedText := AString;
  Result := LStrings
end;

end.

