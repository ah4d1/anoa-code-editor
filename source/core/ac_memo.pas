unit ac_memo;

{**************************************************************
*  A Part of Anoa-Core                                        *
*  See https://github.com/ah4d1/anoa-core                     *
**************************************************************}

interface

uses
  Classes, SysUtils, StdCtrls;

type
  tacMemo = object
  public
    procedure fcAddLines (AMemo : TMemo; ALines : TStringList);
  end;

var
  vacMemo : tacMemo;

implementation

procedure tacMemo.fcAddLines (AMemo : TMemo; ALines : TStringList);
var
  i : Integer;
begin
  for i := 1 to ALines.Count do
    AMemo.Lines.Add(ALines[i-1])
  ;
end;

end.

