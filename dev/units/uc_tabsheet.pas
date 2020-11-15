unit uc_tabsheet;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, SynEditHighlighter, up_var, up_currentdata, uc_synedit,
  uc_syncompletion, ace_synhighlighter, Dialogs, SynEditTypes, Menus, uc_memoresult, ExtCtrls,
  Controls;

type
  taseTextStatus = (aseTextStatusNormal,aseTextStatusModified);
  TUcTabSheet = class(TTabSheet)
  private
    FLang : TAceShLang;
    FLangTxt : string;
    FFileName : TFileName;
    FSynEdit : tucSynEdit;
    FSplitter : TSplitter;
    FMemoResult : tucMemoResult;
    FSynCompletion : tucSynCompletion;
    FTextStatus : taseTextStatus;
  public
    property vLang : TAceShLang read FLang write FLang;
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
    procedure fcUpdate; overload;
    procedure fcUpdate (ACurrentData : tupCurrentData); overload;
    procedure fcUndo;
    procedure fcRedo;
    procedure fcCopy;
    procedure fcCut;
    procedure fcPaste;
    procedure fcSelectAll;
    procedure fcSetCurrentData;
    procedure fcShowCompletion;
    procedure fcReplace (AOldPattern,ANewPattern : string; ASynSearchOptions : TSynSearchOptions;
      AIsSpecialChar : Boolean; ASpecialChar : string);
    procedure fcFindNext;
    procedure fcRunCommand;
    procedure fcMacroStartRecording;
    procedure fcMacroStopRecording;
    procedure fcMacroPlayback;
  end;

implementation

uses
  up_runcommand, ac_dialog;

constructor TUcTabSheet.Create (AOwner : TComponent);
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

procedure TUcTabSheet.fcInit (APopupMenu : TPopupMenu);
begin
  Self.vLang := aceShLangNone;
  Self.vLangTxt := '';
  Self.vFileName := '';
  Self.vTextStatus := aseTextStatusNormal;
  Self.vSynEdit.fcInit(APopupMenu);
end;

procedure TUcTabSheet.fcOpen (ACurrentData : tupCurrentData);
begin
  Self.vSynEdit.fcOpen(ACurrentData.vFileName);
  Self.fcUpdate(ACurrentData);
end;

procedure TUcTabSheet.fcSave (AFileName : TFileName);
begin
  Self.Caption := ExtractFileName(AFileName);
  Self.ImageIndex := vupVar.vImageIndexNormalFile;
  Self.vTextStatus := aseTextStatusNormal;
  Self.vSynEdit.fcSave(AFileName);
end;

procedure TUcTabSheet.fcUpdate;
begin
  Self.vSynEdit.fcUpdate;
end;

procedure TUcTabSheet.fcUpdate (ACurrentData : tupCurrentData);
begin
  Self.vSynEdit.fcUpdate(ACurrentData);
  Self.vSynCompletion.fcUpdate(ACurrentData.vLang);
  Self.vLang := ACurrentData.vLang;
  Self.vLangTxt := ACurrentData.vLangTxt;
  Self.vFileName := ACurrentData.vFileName;
end;

procedure TUcTabSheet.fcUndo;
begin
  Self.vSynEdit.fcUndo;
end;

procedure TUcTabSheet.fcRedo;
begin
  Self.vSynEdit.fcRedo;
end;

procedure TUcTabSheet.fcCopy;
begin
  Self.vSynEdit.fcCopy;
end;

procedure TUcTabSheet.fcCut;
begin
  Self.vSynEdit.fcCut;
end;

procedure TUcTabSheet.fcPaste;
begin
  Self.vSynEdit.fcPaste;
end;

procedure TUcTabSheet.fcSelectAll;
begin
  Self.vSynEdit.fcSelectAll;
end;

procedure TUcTabSheet.fcSetCurrentData;
begin
  vupCurrentData.fcUpdate(Self.vLang,Self.vFileName);
end;

procedure TUcTabSheet.fcShowCompletion;
begin
  Self.vSynEdit.CommandProcessor(vSynCompletion.ExecCommandID, '', nil);
end;

procedure TUcTabSheet.fcReplace (AOldPattern,ANewPattern : string; ASynSearchOptions : TSynSearchOptions;
  AIsSpecialChar : Boolean; ASpecialChar : string);
begin
  Self.vSynEdit.fcReplace(AOldPattern,ANewPattern,ASynSearchOptions,AIsSpecialChar,ASpecialChar);
end;

procedure TUcTabSheet.fcFindNext;
begin
  Self.vSynEdit.fcFindNext;
end;

procedure TUcTabSheet.fcRunCommand;
begin
  case Self.vTextStatus of
    aseTextStatusNormal : vupRunCommand.fcRun(Self.vLang,Self.vFileName,Self.vSynEdit,Self.vMemoResult,Self);
    aseTextStatusModified : vacDialog.fcInfo('Save your work before run.');
  end;
end;

procedure TUcTabSheet.fcMacroStartRecording;
begin
  Self.vSynEdit.fcMacroStartRecording;
end;

procedure TUcTabSheet.fcMacroStopRecording;
begin
  Self.vSynEdit.fcMacroStopRecording;
end;

procedure TUcTabSheet.fcMacroPlayback;
begin
  Self.vSynEdit.fcMacroPlayback;
end;

end.

