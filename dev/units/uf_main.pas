unit uf_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ComCtrls,
  StdCtrls, Spin, ExtCtrls, SynHighlighterCobol, SynEdit, SynCompletion,
  up_synhighlighter;

type

  { TFormMain }

  TFormMain = class(TForm)
    ButtonCloseTab: TButton;
    ImageListMain: TImageList;
    LabelFontSize: TLabel;
    MainMenuMain: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItemCloseAllTabs: TMenuItem;
    MenuItemCloseCurrentTab: TMenuItem;
    MenuItemEditSelectAll: TMenuItem;
    MenuItemSettingsLangCSS: TMenuItem;
    MenuItemEditPaste: TMenuItem;
    MenuItemEditCut: TMenuItem;
    MenuItemEditCopy: TMenuItem;
    MenuItemHelpAbout: TMenuItem;
    MenuItemAddNewTab: TMenuItem;
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
    PanelToolbarCenter: TPanel;
    PanelToolbarLeft: TPanel;
    PanelToolbarRight: TPanel;
    PanelToolbar: TPanel;
    PopupMenuPageControl: TPopupMenu;
    SaveDialogMain: TSaveDialog;
    SpinEditFontSize: TSpinEdit;
    ToolBarMain: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButtonCut: TToolButton;
    ToolButtonFindReplace: TToolButton;
    ToolButtonPaste: TToolButton;
    ToolButtonRedo: TToolButton;
    ToolButtonUndo: TToolButton;
    procedure ButtonCloseTabClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure MenuItemCloseAllTabsClick(Sender: TObject);
    procedure MenuItemCloseCurrentTabClick(Sender: TObject);
    procedure MenuItemEditCopyClick(Sender: TObject);
    procedure MenuItemEditCutClick(Sender: TObject);
    procedure MenuItemEditPasteClick(Sender: TObject);
    procedure MenuItemEditSelectAllClick(Sender: TObject);
    procedure MenuItemHelpAboutClick(Sender: TObject);
    procedure MenuItemAddNewTabClick(Sender: TObject);
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
    procedure fcReplaceForward (AOldPattern,ANewPattern : string);
    procedure fcReplaceAll (AOldPattern,ANewPattern : string);
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
  uc_main, uf_findreplace, uf_about, up_var, up_currentdata, ac_app, ac_sys;

procedure TFormMain.FormCreate(Sender: TObject);
var
  LFileNameOnStart : TFileName;
begin
  vupVar := tupVar.Create(Self);
  vupCurrentData := tupCurrentData.Create(vupVar.vSynHighlighter);
  LFileNameOnStart := string(vacApp.fcGetParam);
  Self.OpenDialogMain.Filter := string(vupVar.vSynHighlighter.fcSetDefaultFilter);
  Self.SaveDialogMain.Filter := string(vupVar.vSynHighlighter.fcSetDefaultFilter);
  vucMain := tucMain.Create(Self,Self.ImageListMain,Self.PopupMenuPageControl,
    Self.SpinEditFontSize,Self.SaveDialogMain
  );
  if Trim(LFileNameOnStart) = '' then
    vucMain.fcAddNewTab
  else
  begin
    vupCurrentData.fcUpdate(LFileNameOnStart);
    vucMain.fcAddNewTab(vupCurrentData);
  end;
end;

procedure TFormMain.MenuItemCloseAllTabsClick(Sender: TObject);
begin
  vucMain.fcCloseAllTabs(vupCurrentData);
end;

procedure TFormMain.MenuItemCloseCurrentTabClick(Sender: TObject);
begin
  vucMain.fcCloseCurrentTab(vupCurrentData);
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

procedure TFormMain.MenuItemEditSelectAllClick(Sender: TObject);
begin
  vucMain.fcSelectAll;
end;

procedure TFormMain.FormActivate(Sender: TObject);
begin
  if FormFindReplace <> nil then
  begin
    FormFindReplace.AlphaBlend := True;
    FormFindReplace.AlphaBlendValue := 175;
  end;
end;

procedure TFormMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  vucMain.fcCloseAllTabs(vupCurrentData);
end;

procedure TFormMain.ButtonCloseTabClick(Sender: TObject);
begin
  vucMain.fcCloseCurrentTab(vupCurrentData);
end;

procedure TFormMain.MenuItemFileExitClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFormMain.MenuItemFileNewClick(Sender: TObject);
begin
  vupCurrentData.fcUpdate(aseLangNone,'');
  vucMain.fcAddNewTab;
  vucMain.fcUpdate(vupCurrentData);
end;

procedure TFormMain.MenuItemHelpAboutClick(Sender: TObject);
begin
  FormAbout := TFormAbout.Create(Self);
  FormAbout.ShowModal;
end;

procedure TFormMain.MenuItemAddNewTabClick(Sender: TObject);
begin
  vupCurrentData.fcUpdate(aseLangNone,'');
  vucMain.fcAddNewTab;
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

procedure TFormMain.fcReplaceForward (AOldPattern,ANewPattern : string);
begin
  vucMain.fcReplaceForward(AOldPattern,ANewPattern);
end;

procedure TFormMain.fcReplaceAll (AOldPattern,ANewPattern : string);
begin
  vucMain.fcCursorToBegin;
  vucMain.fcReplaceForward(AOldPattern,ANewPattern);
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
var
  i : Byte;
begin
  Self.OpenDialogMain.FileName := '';
  if Self.OpenDialogMain.Execute then
  begin
    for i := 1 to Self.OpenDialogMain.Files.Count do
    begin
      vupCurrentData.fcUpdate(Self.OpenDialogMain.Files[i-1]);
      vucMain.fcAddNewTab(vupCurrentData);
      vucMain.fcUpdate(vupCurrentData);
      vucMain.fcUpdateFontSize;
    end;
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
  vacSys.fcAddToWinExplorerContextMenu('Open with Anoa-Syntax-Editor',Application.ExeName);
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
end;

procedure TFormMain.MenuItemSettingsSwitchColorClick(Sender: TObject);
begin
  vucMain.fcSwitchEditorColor;
end;

procedure TFormMain.SpinEditFontSizeChange(Sender: TObject);
begin
  vucMain.fcUpdateFontSize;
end;

end.

