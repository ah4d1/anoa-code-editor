unit ac_system;

{**************************************************************
*  A Part of Anoa-Core                                        *
*  See https://github.com/ah4d1/anoa-core                     *
**************************************************************}

interface

uses
  Classes, SysUtils, Windows, Dialogs, Forms;

type
  tacSystem = object
  public
    procedure fcAddToWinExplorerContextMenu (AMenuTitle : string; AAppExeName : TFileName);
    function fcFindWindow (AWindowTitle : string): HWND;
    function fcIsWindowExist (AWindowTitle : string): Boolean;
  end;

var
  vacSystem : tacSystem;

implementation

uses
  ac_registry;

// Add To Win Explorer Menu
procedure tacSystem.fcAddToWinExplorerContextMenu (AMenuTitle : string; AAppExeName : TFileName);
begin
  vacRegistry.fcWriteString(HKEY_CLASSES_ROOT,'*\shell\' + AMenuTitle + '\command\',
    '','"' + AAppExeName + '" %1')
end;

function tacSystem.fcFindWindow (AWindowTitle : string): HWND;
var
  LHWND : HWND;
  LLength : Integer;
  LCharOfTitle : array [0..254] of Char;
  LStringOfTitle : string;
begin
  LHWND := 0;
  LHWND := Windows.FindWindow(nil, nil);
  while LHWND <> 0 do
  begin
    LLength := GetWindowText(LHWND,LCharOfTitle,255);
    LStringOfTitle := LCharOfTitle;
    LStringOfTitle := Copy(LStringOfTitle,1,LLength);
    if AWindowTitle = LStringOfTitle then Break;
    LHWND := GetWindow(LHWND, GW_HWNDNEXT);
  end;
  Result := LHWND;
end;

function tacSystem.fcIsWindowExist (AWindowTitle : string): Boolean;
var
  LHWND : HWND;
begin
  LHWND := Self.fcFindWindow(AWindowTitle);
  if LHWND > 0 then Result := True else Result := False;
end;

end.

