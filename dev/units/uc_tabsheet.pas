unit uc_tabsheet;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, SynEditHighlighter, up_var, up_currentdata, uc_synedit,
  uc_syncompletion, ace_synhighlighter, Dialogs, SynEditTypes, Menus, uc_memoresult, ExtCtrls,
  Controls;

type
  taseTextStatus = (aseTextStatusNormal,aseTextStatusModified);
  tucTabSheet = class(TTabSheet)
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
  end;

implementation

uses
  up_runcommand, ac_dialog;

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
  Self.vLang := aceShLangNone;
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

procedure tucTabSheet.fcUpdate;
begin
  Self.vSynEdit.fcUpdate;
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
  vupCurrentData.fcUpdate(Self.vLang,Self.vFileName);
end;

procedure tucTabSheet.fcShowCompletion;
begin
  Self.vSynEdit.CommandProcessor(vSynCompletion.ExecCommandID, '', nil);
end;

procedure tucTabSheet.fcReplace (AOldPattern,ANewPattern : string; ASynSearchOptions : TSynSearchOptions;
  AIsSpecialChar : Boolean; ASpecialChar : string);
begin
  Self.vSynEdit.fcReplace(AOldPattern,ANewPattern,ASynSearchOptions,AIsSpecialChar,ASpecialChar);
end;

procedure tucTabSheet.fcFindNext;
begin
  Self.vSynEdit.fcFindNext;
end;

procedure tucTabSheet.fcRunCommand;
begin
  case Self.vTextStatus of
    aseTextStatusNormal : vupRunCommand.fcRun(Self.vLang,Self.vFileName,Self.vSynEdit,Self.vMemoResult,Self);
    aseTextStatusModified : vacDialog.fcInfo('Save your work before run.');
  end;
end;

end.

