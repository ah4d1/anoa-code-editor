unit ac_system;

{**************************************************************
*  A Part of Anoa-Core                                        *
*  See https://github.com/ah4d1/anoa-core                     *
**************************************************************}

interface

uses
  Classes, SysUtils, Registry;

type
  tacSystem = object
  public
    procedure fcAddToWinExplorerContextMenu (AMenuTitle : string; AAppExeName : TFileName);
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

end.

