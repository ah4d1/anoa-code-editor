unit up_runcommand;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Controls, up_synhighlighter, uc_synedit, uc_memoresult;

type
  tupRunCommand = object
  public
    procedure fcRun (ALang : taseLang; AFileName : TFileName; ASynEdit : tucSynEdit;
      AMemoResult : tucMemoResult; AParent : TWinControl);
  private
    function fcPython (AFileName : TFileName) : TStringList;
  end;

var
  vupRunCommand : tupRunCommand;

implementation

uses
  up_var, ac_exe, ac_memo, ac_dialog, ac_filedir;

procedure tupRunCommand.fcRun (ALang : taseLang; AFileName : TFileName; ASynEdit : tucSynEdit;
  AMemoResult : tucMemoResult; AParent : TWinControl);
var
  LResults : TStringList;
  LFileName : TFileName;
  LTmpFile : Boolean;
  LContinue : Boolean;
begin
  LFileName := vupVar.fcFileName(AFileName,LTmpFile);
  ASynEdit.Lines.SaveToFile(LFileName);
  LContinue := True;
  case ALang of
    aseLangPython : LResults := Self.fcPython(LFileName);
    else
    begin
      vacDialog.fcInfo('Not Available','Run command is currently not available.');
      LContinue := False;
    end;
  end;
  if LContinue then
  begin
    AMemoResult.Lines.Add('[' + DateTimeToStr(Now()) + ']');
    vacMemo.fcAddLines(AMemoResult,LResults);
    if AMemoResult.Height = 0 then AMemoResult.Height := Round(AParent.Height / 4);
    if LTmpFile then vacFileDir.fcDeleteFile(LFileName);
  end;
end;

function tupRunCommand.fcPython (AFileName : TFileName) : TStringList;
begin
  Result := vacExe.fcRun('python',AFileName);
end;

end.

