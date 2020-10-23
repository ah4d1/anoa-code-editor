unit uc_tabsheet;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, SynEditHighlighter, up_var, up_currentdata, uc_synedit,
  uc_syncompletion, up_synhighlighter, Dialogs;

type
  tucTabSheet = class(TTabSheet)
  private
    FLang : taseLang;
    FLangTxt : string;
    FFileName : TFileName;
    FSynEdit : tucSynEdit;
    FSynCompletion : tucSynCompletion;
    FFontSize : Byte;
  public
    property vLang : taseLang read FLang write FLang;
    property vLangTxt : string read FLangTxt write FLangTxt;
    property vFileName : TFileName read FFileName write FFileName;
    property vSynEdit : tucSynEdit read FSynEdit write FSynEdit;
    property vSynCompletion : tucSynCompletion read FSynCompletion write FSynCompletion;
    property vFontSize : Byte read FFontSize write FFontSize;
    constructor Create (AOwner : TComponent); override;
    procedure fcInit;
    procedure fcOpen (ACurrentData : tupCurrentData);
    procedure fcSave (AFileName : TFileName);
    procedure fcUpdate (ACurrentData : tupCurrentData);
    procedure fcUndo;
    procedure fcRedo;
    procedure fcCopy;
    procedure fcCut;
    procedure fcPaste;
    procedure fcSetCurrentData;
    procedure fcShowCompletion;
    procedure fcSwitchEditorColor;
  end;

implementation

constructor tucTabSheet.Create (AOwner : TComponent);
begin
  inherited Create(AOwner);
  Self.vSynEdit := tucSynEdit.Create(AOwner);
  Self.vSynEdit.Parent := Self;
  Self.vSynCompletion := tucSynCompletion.Create(AOwner);
  Self.vSynCompletion.Editor := Self.vSynEdit;
end;

procedure tucTabSheet.fcInit;
begin
  Self.vLang := aseLangNone;
  Self.vLangTxt := '';
  Self.vFileName := '';
  Self.vFontSize := 9;
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
  Self.vSynEdit.fcSave(AFileName);
end;

procedure tucTabSheet.fcUpdate (ACurrentData : tupCurrentData);
begin
  Self.vSynEdit.fcUpdate(ACurrentData);
  Self.vSynCompletion.fcUpdate(ACurrentData.vLang);
  Self.vFontSize := ACurrentData.vFontSize;
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

procedure tucTabSheet.fcSetCurrentData;
begin
  vupCurrentData.vFontSize := Self.vFontSize;
  vupCurrentData.vLangTxt := Self.vLangTxt;
  vupCurrentData.vFileName := Self.vFileName;
end;

procedure tucTabSheet.fcShowCompletion;
begin
  Self.vSynEdit.CommandProcessor(vSynCompletion.ExecCommandID, '', nil);
end;

procedure tucTabSheet.fcSwitchEditorColor;
begin
  Self.vSynEdit.fcSwitchColor;
end;

end.

