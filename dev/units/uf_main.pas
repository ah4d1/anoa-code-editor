unit uf_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ComCtrls,
  StdCtrls, Spin, SynHighlighterCobol, SynEdit, SynCompletion, uc_tabsheet,
  uc_syncompletion, up_synhighlighter;

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
    MenuItem5: TMenuItem;
    MenuItemSettingsLangCSS: TMenuItem;
    MenuItemEditPaste: TMenuItem;
    MenuItemEditCut: TMenuItem;
    MenuItemEditCopy: TMenuItem;
    MenuItemHelpAbout: TMenuItem;
    MenuItemAddTab: TMenuItem;
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
    PopupMenuPageControl: TPopupMenu;
    SaveDialogMain: TSaveDialog;
    SpinEditFontSize: TSpinEdit;
    ToolBarMain: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MenuItemEditCopyClick(Sender: TObject);
    procedure MenuItemEditCutClick(Sender: TObject);
    procedure MenuItemEditPasteClick(Sender: TObject);
    procedure MenuItemHelpAboutClick(Sender: TObject);
    procedure MenuItemAddTabClick(Sender: TObject);
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
    procedure MenuItemSettingsLangCSSClick(Sender: TObject);
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
  private
    procedure SetLang (ALang : taseLang);
  public

  end;

var
  FormMain: TFormMain;

implementation

{$R *.lfm}

{ TFormMain }

uses
  uc_main, uf_findreplace, uf_about, up_var, up_currentdata, up_tools;

procedure TFormMain.FormCreate(Sender: TObject);
var
  LFileNameOnStart : TFileName;
begin
  vupVar := tupVar.Create(Self);
  vupCurrentData := tupCurrentData.Create(vupVar.vSynHighlighter);
  LFileNameOnStart := string(vupTools.FcParamsInSingleText);
  Self.OpenDialogMain.Filter := string(vupVar.vSynHighlighter.fcSetDefaultFilter);
  Self.SaveDialogMain.Filter := string(vupVar.vSynHighlighter.fcSetDefaultFilter);
  vucMain := tucMain.Create(Self,Self.ImageListMain,Self.PopupMenuPageControl);
  if Trim(LFileNameOnStart) = '' then
    vucMain.fcAddTab
  else
  begin
    vupCurrentData.fcUpdate(LFileNameOnStart);
    vucMain.fcAddTab(vupCurrentData);
  end;
end;

procedure TFormMain.MenuItemEditCopyClick(Sender: TObject);
begin
  vucMain.fcCopy;
end;

procedure TFormMain.MenuItemEditCutClick(Sender: TObject);
begin
  vucMain.fcCut;
end;

procedure TFormMain.MenuItemEditPasteClick(Sender: TObject);
begin
  vucMain.fcPaste;
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
  vupCurrentData.fcUpdate(aseLangNone,'');
  vucMain.fcAddTab;
  vucMain.fcUpdate(vupCurrentData);
end;

procedure TFormMain.MenuItemHelpAboutClick(Sender: TObject);
begin
  FormAbout := TFormAbout.Create(Self);
  FormAbout.ShowModal;
end;

procedure TFormMain.MenuItemAddTabClick(Sender: TObject);
begin
  vupCurrentData.fcUpdate(aseLangNone,'');
  vucMain.fcAddTab;
  vucMain.fcUpdate(vupCurrentData);
end;

procedure TFormMain.MenuItemEditShowCompletionClick(Sender: TObject);
begin
  vucMain.fcShowCompletion;
end;

procedure TFormMain.MenuItemEditFindReplaceClick(Sender: TObject);
begin
  FormFindReplace := TFormFindReplace.Create(Self);
  FormFindReplace.Show;
end;

procedure TFormMain.MenuItemEditRedoClick(Sender: TObject);
begin
  vucMain.fcRedo;
end;

procedure TFormMain.MenuItemEditUndoClick(Sender: TObject);
begin
  vucMain.fcUndo;
end;

procedure TFormMain.MenuItemFileOpenClick(Sender: TObject);
begin
  Self.OpenDialogMain.FileName := '';
  if Self.OpenDialogMain.Execute then
  begin
    vupCurrentData.fcUpdate(Self.OpenDialogMain.FileName);
    vucMain.fcAddTab(vupCurrentData);
    vucMain.fcUpdate(vupCurrentData);
  end;
end;

procedure TFormMain.MenuItemFileSaveAsClick(Sender: TObject);
begin
  if Self.SaveDialogMain.Execute then
  begin
    vupCurrentData.fcUpdate(Self.SaveDialogMain.FileName);
    vucMain.fcSave(vupCurrentData.vFileName);
    vucMain.fcUpdate(vupCurrentData);
  end;
end;

procedure TFormMain.MenuItemFileSaveClick(Sender: TObject);
begin
  if FileExists(vupCurrentData.vFileName) then
  begin
    vupCurrentData.fcUpdate(vupCurrentData.vFileName);
    vucMain.fcSave(vupCurrentData.vFileName);
    vucMain.fcUpdate(vupCurrentData);
  end
  else
    Self.MenuItemFileSaveAsClick(Sender)
  ;
end;

procedure TFormMain.MenuItemSettingsAddToSysMenuClick(Sender: TObject);
begin
  vupTools.FcAddAppToWinExplorerContextMenu('Open with Anoa-Syntax-Editor',Application.ExeName);
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

procedure TFormMain.MenuItemSettingsLangCSSClick(Sender: TObject);
begin
  Self.SetLang(aseLangCSS);
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

procedure TFormMain.SetLang (ALang : taseLang);
begin
  vupCurrentData.fcUpdate(ALang);
  vucMain.fcUpdate(vupCurrentData);
  vucMain.fcUpdate(vupCurrentData);
end;

procedure TFormMain.MenuItemSettingsSwitchColorClick(Sender: TObject);
begin
  vucMain.fcSwitchEditorColor;
end;

procedure TFormMain.SpinEditFontSizeChange(Sender: TObject);
begin
  vucMain.fcSetFontSize(Self.SpinEditFontSize.Value);
end;

end.

