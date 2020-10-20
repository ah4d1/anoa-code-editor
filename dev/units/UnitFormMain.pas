unit UnitFormMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ComCtrls,
  StdCtrls, Spin, SynHighlighterCobol, SynEdit, SynCompletion,
  UnitPasSynHighlighter;

type

  { TFormMain }

  TFormMain = class(TForm)
    ImageListMain: TImageList;
    LabelFontSize: TLabel;
    MainMenuMain: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItemSettingsLangNone: TMenuItem;
    MenuItemEditShowCompletion: TMenuItem;
    MenuItemEditRedo: TMenuItem;
    MenuItemEditUndo: TMenuItem;
    MenuItemEditFindReplace: TMenuItem;
    MenuItemEdit: TMenuItem;
    MenuItemSettingsSwitchColor: TMenuItem;
    MenuItemSettingsLangCobol: TMenuItem;
    MenuItemSettingsLangSQL: TMenuItem;
    MenuItemSettingsLangCSharp: TMenuItem;
    MenuItemSettingsLangJSON: TMenuItem;
    MenuItemSettingsLangPython: TMenuItem;
    MenuItemSettingsAddToSysMenu: TMenuItem;
    MenuItemFileNew: TMenuItem;
    MenuItemSettingsLangPHP: TMenuItem;
    MenuItemSettingsLangHTML: TMenuItem;
    MenuItemSettingsLangJava: TMenuItem;
    MenuItemSettingsLangPascal: TMenuItem;
    MenuItemSettingsLang: TMenuItem;
    MenuItemSettings: TMenuItem;
    MenuItemFileSave: TMenuItem;
    MenuItemFileExit: TMenuItem;
    MenuItemFileSaveAs: TMenuItem;
    MenuItemFileOpen: TMenuItem;
    OpenDialogMain: TOpenDialog;
    PageControlMain: TPageControl;
    SaveDialogMain: TSaveDialog;
    SpinEditFontSize: TSpinEdit;
    StatusBarMain: TStatusBar;
    SynCompletionMain: TSynCompletion;
    SynEditMain: TSynEdit;
    TabSheet1: TTabSheet;
    ToolBarMain: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItemEditShowCompletionClick(Sender: TObject);
    procedure MenuItemEditFindReplaceClick(Sender: TObject);
    procedure MenuItemEditRedoClick(Sender: TObject);
    procedure MenuItemEditUndoClick(Sender: TObject);
    procedure MenuItemFileExitClick(Sender: TObject);
    procedure MenuItemFileNewClick(Sender: TObject);
    procedure MenuItemFileOpenClick(Sender: TObject);
    procedure MenuItemFileSaveAsClick(Sender: TObject);
    procedure MenuItemFileSaveClick(Sender: TObject);
    procedure MenuItemSettingsAddToSysMenuClick(Sender: TObject);
    procedure MenuItemSettingsLangCobolClick(Sender: TObject);
    procedure MenuItemSettingsLangCSharpClick(Sender: TObject);
    procedure MenuItemSettingsLangHTMLClick(Sender: TObject);
    procedure MenuItemSettingsLangJavaClick(Sender: TObject);
    procedure MenuItemSettingsLangJSONClick(Sender: TObject);
    procedure MenuItemSettingsLangNoneClick(Sender: TObject);
    procedure MenuItemSettingsLangPascalClick(Sender: TObject);
    procedure MenuItemSettingsLangPHPClick(Sender: TObject);
    procedure MenuItemSettingsLangPythonClick(Sender: TObject);
    procedure MenuItemSettingsLangSQLClick(Sender: TObject);
    procedure MenuItemSettingsSwitchColorClick(Sender: TObject);
    procedure SpinEditFontSizeChange(Sender: TObject);
    procedure SynEditMainChange(Sender: TObject);
  private
    procedure OpenFile (AFileName : TFileName);
    procedure SetLang (ALang : TASETypeLang);
  public

  end;

var
  FormMain: TFormMain;

implementation

{$R *.lfm}

{ TFormMain }

uses
  UnitFormFindReplace, UnitFormAbout, UnitPasVar, UnitPasSave, UnitPasLang, UnitPasTools;

procedure TFormMain.FormCreate(Sender: TObject);
var
  LFileNameOnStart : TFileName;
begin
  VUVar := TUVar.Create(Self);
  Self.OpenDialogMain.Filter := string(VUVar.vSynHighlighter.fcSetDefaultFilter);
  Self.SaveDialogMain.Filter := string(VUVar.vSynHighlighter.fcSetDefaultFilter);

  LFileNameOnStart := string(VUTools.FcParamsInSingleText);
  if Trim(LFileNameOnStart) <> '' then Self.OpenFile(LFileNameOnStart);
end;

procedure TFormMain.FormActivate(Sender: TObject);
begin
  if FormFindReplace <> nil then
  begin
    FormFindReplace.AlphaBlend := True;
    FormFindReplace.AlphaBlendValue := 175;
  end;
end;

procedure TFormMain.MenuItemFileExitClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFormMain.MenuItemFileNewClick(Sender: TObject);
begin
  Self.PageControlMain.ActivePage.ImageIndex := VUVar.vImageIndexNormalFile;
  Self.PageControlMain.ActivePage.Caption := 'New';
  Self.SynEditMain.Lines.Clear;
  VUVar.vStatusBar.Update(Self.StatusBarMain,'','');
end;

procedure TFormMain.MenuItem4Click(Sender: TObject);
begin
  FormAbout := TFormAbout.Create(Self);
  FormAbout.ShowModal;
end;

procedure TFormMain.MenuItemEditShowCompletionClick(Sender: TObject);
begin
  Self.SynEditMain.CommandProcessor(Self.SynCompletionMain.ExecCommandID, '', nil)
end;

procedure TFormMain.MenuItemEditFindReplaceClick(Sender: TObject);
begin
  FormFindReplace := TFormFindReplace.Create(Self);
  FormFindReplace.Show;
end;

procedure TFormMain.MenuItemEditRedoClick(Sender: TObject);
begin
  Self.SynEditMain.Redo;
end;

procedure TFormMain.MenuItemEditUndoClick(Sender: TObject);
begin
  Self.SynEditMain.Undo;
end;

procedure TFormMain.MenuItemFileOpenClick(Sender: TObject);
begin
  if Self.OpenDialogMain.Execute then
  begin
    Self.OpenFile(Self.OpenDialogMain.FileName);
  end;
end;

procedure TFormMain.OpenFile (AFileName : TFileName);
begin
  VUVar.vCurrentData.Update(AFileName);
  VUVar.vSynEdit.Open(Self.SynEditMain,AFileName);
  VUVar.vSynEdit.Update(Self.SynEditMain,VUVar.vCurrentData.vHighlighter);
  VUVar.vSynCompletion.Update(Self.SynCompletionMain,VUVar.vCurrentData.vASETypeLang);
  VUVar.vPageControl.Update(Self.PageControlMain,VUVar.vImageIndexNormalFile,VUVar.vCurrentData.vFileName);
  VUVar.vStatusBar.Update(Self.StatusBarMain,VUVar.vCurrentData.vLangTxt,VUVar.vCurrentData.vFileName);
end;

procedure TFormMain.MenuItemFileSaveAsClick(Sender: TObject);
begin
  if Self.SaveDialogMain.Execute then
  begin
    VUVar.vCurrentData.Update(Self.SaveDialogMain.FileName);
    VUVar.vSynEdit.Save(Self.SynEditMain,VUVar.vCurrentData.vFileName);
    VUVar.vSynCompletion.Update(Self.SynCompletionMain,VUVar.vCurrentData.vASETypeLang);
    VUVar.vPageControl.Update(Self.PageControlMain,VUVar.vImageIndexNormalFile,VUVar.vCurrentData.vFileName);
    VUVar.vStatusBar.Update(Self.StatusBarMain,VUVar.vCurrentData.vLangTxt,VUVar.vCurrentData.vFileName);
  end;
end;

procedure TFormMain.MenuItemFileSaveClick(Sender: TObject);
begin
  if FileExists(VUVar.vCurrentData.vFileName) then
  begin
    VUVar.vPageControl.Update(Self.PageControlMain,VUVar.vImageIndexNormalFile,VUVar.vCurrentData.vFileName);
    VUVar.vSynEdit.Save(Self.SynEditMain,VUVar.vCurrentData.vFileName);
    VUVar.vSynCompletion.Update(Self.SynCompletionMain,VUVar.vCurrentData.vASETypeLang);
    VUVar.vStatusBar.Update(Self.StatusBarMain,VUVar.vCurrentData.vLangTxt,VUVar.vCurrentData.vFileName);
  end
  else
    Self.MenuItemFileSaveAsClick(Sender)
  ;
end;

procedure TFormMain.MenuItemSettingsAddToSysMenuClick(Sender: TObject);
begin
  VUTools.FcAddAppToWinExplorerContextMenu('Open with Anoa-Syntax-Editor',Application.ExeName);
  MessageDlg('Please check at Windows Explorer Context Menu',mtInformation,[mbOK],0);
end;

procedure TFormMain.MenuItemSettingsLangCobolClick(Sender: TObject);
begin
  Self.SetLang(aseLangCobol);
end;

procedure TFormMain.MenuItemSettingsLangCSharpClick(Sender: TObject);
begin
  Self.SetLang(aseLangCS);
end;

procedure TFormMain.MenuItemSettingsLangHTMLClick(Sender: TObject);
begin
  Self.SetLang(aseLangHTML);
end;

procedure TFormMain.MenuItemSettingsLangJavaClick(Sender: TObject);
begin
  Self.SetLang(aseLangJava);
end;

procedure TFormMain.MenuItemSettingsLangJSONClick(Sender: TObject);
begin
  Self.SetLang(aseLangJSON);
end;

procedure TFormMain.MenuItemSettingsLangNoneClick(Sender: TObject);
begin
  Self.SetLang(aseLangNone);
end;

procedure TFormMain.MenuItemSettingsLangPascalClick(Sender: TObject);
begin
  Self.SetLang(aseLangPas);
end;

procedure TFormMain.MenuItemSettingsLangPHPClick(Sender: TObject);
begin
  Self.SetLang(aseLangPHP);
end;

procedure TFormMain.MenuItemSettingsLangPythonClick(Sender: TObject);
begin
  Self.SetLang(aseLangPython);
end;

procedure TFormMain.MenuItemSettingsLangSQLClick(Sender: TObject);
begin
  Self.SetLang(aseLangSQL);
end;

procedure TFormMain.MenuItemSettingsSwitchColorClick(Sender: TObject);
begin
  Self.SynEditMain.Color := VUTools.ComplementaryColor(Self.SynEditMain.Color);
  Self.SynEditMain.Font.Color := VUTools.ComplementaryColor(Self.SynEditMain.Font.Color);
  Self.SynEditMain.Gutter.Color := VUTools.ComplementaryColor(Self.SynEditMain.Gutter.Color);
  Self.SynEditMain.Gutter.Parts[1].MarkupInfo.Background := VUTools.ComplementaryColor(Self.SynEditMain.Gutter.Parts[1].MarkupInfo.Background);;
  Self.SynEditMain.LineHighlightColor.Background := VUTools.ComplementaryColor(Self.SynEditMain.LineHighlightColor.Background);
end;

procedure TFormMain.SetLang (ALang : TASETypeLang);
begin
  VUVar.vCurrentData.Update(ALang);
  VUVar.vSynEdit.Update(Self.SynEditMain,VUVar.vCurrentData.vHighlighter);
  VUVar.vSynCompletion.Update(Self.SynCompletionMain,ALang);
  VUVar.vStatusBar.Update(Self.StatusBarMain,VUVar.vCurrentData.vASETypeLang);
end;

procedure TFormMain.SpinEditFontSizeChange(Sender: TObject);
begin
  Self.SynEditMain.Font.Size := Self.SpinEditFontSize.Value;
end;

procedure TFormMain.SynEditMainChange(Sender: TObject);
begin
  Self.PageControlMain.ActivePage.ImageIndex := VUVar.vImageIndexModifiedFile;
end;

end.

