unit ac_app;

{**************************************************************
*  A Part of Anoa-Core                                        *
*  See https://github.com/ah4d1/anoa-core                     *
**************************************************************}

interface

uses
  Classes, SysUtils;

type
  tacApp = object
  public
    function fcGetParam : WideString;
  end;

var
  vacApp : tacApp;

implementation

// Get params sent to app in a single text
function tacApp.fcGetParam : WideString;
var
  i : Integer;
  LResult : WideString;
begin
  LResult := '';
  for i := 1 to ParamCount() do LResult := Trim(LResult + ' ' + ParamStr(i));
  Result := LResult;
end;

end.

