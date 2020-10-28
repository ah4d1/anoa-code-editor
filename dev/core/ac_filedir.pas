unit ac_filedir;

{**************************************************************
*  A Part of Anoa-Core                                        *
*  See https://github.com/ah4d1/anoa-core                     *
**************************************************************}

interface

uses
  Classes, SysUtils;

type
  tacFileDir = object
  public
    procedure fcCreateFile (AFileName : TFileName; AText : WideString);
    procedure fcDeleteFile (AFileName : TFileName);
    function fcTmpFileName : TFileName;
  end;

var
  vacFileDir : tacFileDir;

implementation

procedure tacFileDir.fcCreateFile (AFileName : TFileName; AText : WideString);
var
  LF : TextFile;
begin
  AssignFile(LF,AFileName);
  Rewrite(LF);
  Writeln(LF,AText);
  CloseFile(LF);
end;

procedure tacFileDir.fcDeleteFile (AFileName : TFileName);
begin
  if FileExists(AFileName) then DeleteFile(AFileName);
end;

function tacFileDir.fcTmpFileName : TFileName;
begin
  Result := GetTempFileName;
end;

end.

