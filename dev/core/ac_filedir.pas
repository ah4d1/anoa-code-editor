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
    function fcFileToStringList (AFileName : TFileName) : TStringList;
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

function tacFileDir.fcFileToStringList (AFileName : TFileName) : TStringList;
var
  LStringList : TStringList;
  LFile : TextFile;
  LLine : WideString;
begin
  LStringList := TStringList.Create;
  AssignFile(LFile,AFileName);
  Reset(LFile);
  repeat
    Readln(LFile,LLine);
    LStringList.Add(string(LLine));
  until EOF(LFile);
  CloseFile(LFile);
  Result := LStringList;
end;

function tacFileDir.fcTmpFileName : TFileName;
begin
  Result := GetTempFileName;
end;

end.

