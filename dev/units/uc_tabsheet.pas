unit uc_tabsheet;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, SynEditHighlighter, up_var, up_currentdata, uc_synedit,
  uc_syncompletion, up_synhighlighter, Dialogs, SynEditTypes, Menus, uc_memoresult, ExtCtrls,
  Controls;

type
  taseTextStatus = (aseTextStatusNormal,aseTextStatusModified);
  tucTabSheet = class(TTabSheet)
  private
    FLang : taseLang;
    FLangTxt : string;
    FFileName : TFileName;
    FSynEdit : tucSynEdit;
    FSplitter : TSplitter;
    FMemoResult : tucMemoResult;
    FSynCompletion : tucSynCompletion;
    FTextStatus : taseTextStatus;
  public
    property vLang : taseLang read FLang write FLang;
    property vLangTxt : string read FLangTxt write FLangTxt;
    property vFileName : TFileName read FFileName write FFileName;
    property vSynEdit : tucSynEdit read FSynEdit write FSynEdit;
    property vSplitter : TSplitter read FSplitter write FSplitter;
    property vMemoResult : tucMemoResult read FMemoResult write FMemoResult;
    property vSynCompletion : tucSynCompletion read FSynCompletion write FSynCompletion;
    property vTextStatus : taseTextStatus read FTextStatus write FTextStatus;
    constructor Create (AOwner : TComponent); override;
    procedure fcInit (APopupMenu : TPopupMenu);
    procedure fcOpen (ACurrentData : tupCurrentData);
    procedure fcSave (AFileName : TFileName);
    procedure fcUpdate (ACurrentData : tupCurrentData);
    procedure fcUndo;
    procedure fcRedo;
    procedure fcCopy;
    procedure fcCut;
    procedure fcPaste;
    procedure fcSelectAll;
    procedure fcSetCurrentData;
    procedure fcShowCompletion;
    procedure fcReplace (AOldPattern,ANewPattern : string; ASynSearchOptions : TSynSearchOptions);
    procedure fcSwitchEditorColor;
    procedure fcRunCommand;
  end;

implementation

uses
  ac_exe, ac_filedir;

constructor tucTabSheet.Create (AOwner : TComponent);
begin
  inherited Create(AOwner);
  Self.vMemoResult := tucMemoResult.Create(AOwner);
  Self.vMemoResult.Parent := Self;
  Self.vSplitter := TSplitter.Create(AOwner);
  Self.vSplitter.Parent := Self;
  Self.vSplitter.Align := alBottom;
  Self.vSynEdit := tucSynEdit.Create(AOwner);
  Self.vSynEdit.Parent := Self;
  Self.vSynCompletion := tucSynCompletion.Create(AOwner);
  Self.vSynCompletion.Editor := Self.vSynEdit;
end;

procedure tucTabSheet.fcInit (APopupMenu : TPopupMenu);
begin
  Self.vLang := aseLangNone;
  Self.vLangTxt := '';
  Self.vFileName := '';
  Self.vTextStatus := aseTextStatusNormal;
  Self.vSynEdit.fcInit(APopupMenu);
end;

procedure tucTabSheet.fcOpen (ACurrentData : tupCurrentData);
begin
  Self.vSynEdit.fcOpen(ACurrentData.vFileName);
  Self.fcUpdate(ACurrentData);
end;

procedure tucTabSheet.fcSave (AFileName : TFileName);
begin
  Self.Caption := ExtractFileName(AFileName);
  Self.ImageIndex := vupVar.vImageIndexNormalFile;
  Self.vTextStatus := aseTextStatusNormal;
  Self.vSynEdit.fcSave(AFileName);
end;

procedure tucTabSheet.fcUpdate (ACurrentData : tupCurrentData);
begin
  Self.vSynEdit.fcUpdate(ACurrentData);
  Self.vSynCompletion.fcUpdate(ACurrentData.vLang);
  Self.vLang := ACurrentData.vLang;
  Self.vLangTxt := ACurrentData.vLangTxt;
  Self.vFileName := ACurrentData.vFileName;
end;

procedure tucTabSheet.fcUndo;
begin
  Self.vSynEdit.fcUndo;
end;

procedure tucTabSheet.fcRedo;
begin
  Self.vSynEdit.fcRedo;
end;

procedure tucTabSheet.fcCopy;
begin
  Self.vSynEdit.fcCopy;
end;

procedure tucTabSheet.fcCut;
begin
  Self.vSynEdit.fcCut;
end;

procedure tucTabSheet.fcPaste;
begin
  Self.vSynEdit.fcPaste;
end;

procedure tucTabSheet.fcSelectAll;
begin
  Self.vSynEdit.fcSelectAll;
end;

procedure tucTabSheet.fcSetCurrentData;
begin
  vupCurrentData.vLangTxt := Self.vLangTxt;
  vupCurrentData.vFileName := Self.vFileName;
end;

procedure tucTabSheet.fcShowCompletion;
begin
  Self.vSynEdit.CommandProcessor(vSynCompletion.ExecCommandID, '', nil);
end;

procedure tucTabSheet.fcReplace (AOldPattern,ANewPattern : string; ASynSearchOptions : TSynSearchOptions);
begin
  Self.vSynEdit.fcReplace(AOldPattern,ANewPattern,ASynSearchOptions);
end;

procedure tucTabSheet.fcSwitchEditorColor;
begin
  Self.vSynEdit.fcSwitchColor;
end;

procedure tucTabSheet.fcRunCommand;
var
  LResults : TStringList;
  i : Integer;
  LCommand : string;
  LFileName : TFileName;
  LFileTmp : Boolean;
begin
  case Self.vLang of
    // aseLangJava : LCommand := 'javac|java';
    aseLangPython : LCommand := 'python';
  end;
  if Trim(LCommand) <> '' then
  begin
    if Trim(Self.vFileName) <> '' then
    begin
      LFileName := Self.vFileName;
      LFileTmp := False;
    end
    else
    begin
      LFileName := vacFileDir.fcGetTempFileName;
      LFileTmp := True;
    end;
    Self.vSynEdit.Lines.SaveToFile(LFileName);
    LResults := vacExe.fcRunCommand(LCommand,LFileName);
    Self.vMemoResult.Lines.Add('[' + DateTimeToStr(Now()) + ']');
    for i := 1 to LResults.Count do
    begin
      Self.vMemoResult.Lines.Add(LResults[i-1]);
    end;
    if Self.vMemoResult.Height = 0 then Self.vMemoResult.Height := Round(Self.Height / 4);
  end
  else
    MessageDlg('Not Available','Run command is currently not available for ' + Self.vLangTxt,
      mtInformation,[mbOK],0
    )
  ;
  if LFileTmp then vacFileDir.fcDeleteFile(LFileName);
end;

end.

