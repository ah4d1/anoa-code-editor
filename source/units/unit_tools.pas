unit unit_tools;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Registry;

type
  TUTools = object
    function FcParamsInSingleText : WideString;
    procedure FcAddAppToWinExplorerContextMenu (AMenuTitle : string; AAppExeName : TFileName);
    procedure FcRegistryWriteString (ARootKey : HKEY; AKey,AName,AValue : string);
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

// set App as Administrator
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

end.

