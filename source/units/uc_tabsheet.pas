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
  public
    property vLang : taseLang read FLang write FLang;
    property vLangTxt : string read FLangTxt write FLangTxt;
    property vFileName : TFileName read FFileName write FFileName;
    property vSynEdit : tucSynEdit read FSynEdit write FSynEdit;
    property vSynCompletion : tucSynCompletion read FSynCompletion write FSynCompletion;
    constructor Create (AOwner : TComponent); override;
    procedure fcInit;
    procedure fcOpen (AFileName : TFileName);
    procedure fcSave (AFileName : TFileName);
    procedure fcUpdate (ACurrentData : tupCurrentData);
    procedure fcUndo;
    procedure fcRedo;
    procedure fcSetFontSize (ASize : Byte);
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
end;

procedure tucTabSheet.fcOpen (AFileName : TFileName);
begin
  Self.vSynEdit.fcOpen(AFileName);
end;

procedure tucTabSheet.fcSave (AFileName : TFileName);
begin
  Self.Caption := ExtractFileName(AFileName);
  Self.ImageIndex := vupVar.vImageIndexNormalFile;
  Self.vSynEdit.fcSave(AFileName);
end;

procedure tucTabSheet.fcUpdate (ACurrentData : tupCurrentData);
begin
  Self.vSynEdit.fcUpdate(vupCurrentData.vHighlighter);
  Self.vSynCompletion.fcUpdate(vupCurrentData.vLang);
  Self.vLangTxt := vupCurrentData.vLangTxt;
  Self.vFileName := vupCurrentData.vFileName;
end;

procedure tucTabSheet.fcUndo;
begin
  Self.vSynEdit.fcUndo;
end;

procedure tucTabSheet.fcRedo;
begin
  Self.vSynEdit.fcRedo;
end;

procedure tucTabSheet.fcSetFontSize (ASize : Byte);
begin
  Self.vSynEdit.fcSetFontSize(ASize);
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

procedure tucTabSheet.fcSwitchEditorColor;
begin
  Self.vSynEdit.fcSwitchColor;
end;

end.

