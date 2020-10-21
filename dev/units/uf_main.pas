unit uf_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ComCtrls,
  StdCtrls, Spin, SynHighlighterCobol, SynEdit, SynCompletion, uc_tabsheet,
  uc_synedit, uc_syncompletion, up_synhighlighter;

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
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
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
    procedure MenuItemSettingsLangHTMLClick(Sender: TObject);
    procedure MenuItemSettingsLangJavaClick(Sender: TObject);
    procedure MenuItemSettingsLangJSONClick(Sender: TObject);
    procedure MenuItemSettingsLangNoneClick(Sender: TObject);
    procedure MenuItemSettingsLangPascalClick(Sender: TObject);
    procedure MenuItemSettingsLangPHPClick(Sender: TObject);
    procedure MenuItemSettingsLangPythonClick(Sender: TObject);
    procedure MenuItemSettingsLangSQLClick(Sender: TObject);
    procedure MenuItemSettingsSwitchColorClick(Sender: TObject);
    procedure PageControlMainChange(Sender: TObject);
    procedure SpinEditFontSizeChange(Sender: TObject);
    procedure SynEditMainChange(Sender: TObject);
  private
    procedure SetLang (ALang : TASETypeLang);
    function fcCurrentTabSheet : tucTabSheet;
    function fcCurrentSynEdit : tucSynEdit;
    function fcCurrentSynCompletion : tucSynCompletion;
  public

  end;

var
  FormMain: TFormMain;

implementation

{$R *.lfm}

{ TFormMain }

uses
  uc_main, uf_findreplace, uf_about, up_var, up_tools;

var
  vMain : tucMain;

procedure TFormMain.FormCreate(Sender: TObject);
var
  LFileNameOnStart : TFileName;
begin
  LFileNameOnStart := string(vupTools.FcParamsInSingleText);
  vupVar := tupVar.Create(Self);
  Self.OpenDialogMain.Filter := string(vupVar.vSynHighlighter.fcSetDefaultFilter);
  Self.SaveDialogMain.Filter := string(vupVar.vSynHighlighter.fcSetDefaultFilter);
  vMain := tucMain.Create(Self,Self.ImageListMain,Self.PopupMenuPageControl);
  if Trim(LFileNameOnStart) = '' then
    vMain.fcAddTab
  else
    vMain.fcAddTab(LFileNameOnStart)
  ;
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
  vMain.fcAddTab;
end;

procedure TFormMain.MenuItem4Click(Sender: TObject);
begin
  FormAbout := TFormAbout.Create(Self);
  FormAbout.ShowModal;
end;

procedure TFormMain.MenuItemAddTabClick(Sender: TObject);
begin
  vMain.fcAddTab;
end;

procedure TFormMain.MenuItemEditShowCompletionClick(Sender: TObject);
begin
  Self.fcCurrentSynEdit.CommandProcessor(Self.fcCurrentSynCompletion.ExecCommandID, '', nil);
end;

procedure TFormMain.MenuItemEditFindReplaceClick(Sender: TObject);
begin
  FormFindReplace := TFormFindReplace.Create(Self);
  FormFindReplace.Show;
end;

procedure TFormMain.MenuItemEditRedoClick(Sender: TObject);
begin
  Self.fcCurrentSynEdit.Redo;
end;

procedure TFormMain.MenuItemEditUndoClick(Sender: TObject);
begin
  Self.fcCurrentSynEdit.Undo;
end;

procedure TFormMain.MenuItemFileOpenClick(Sender: TObject);
begin
  if Self.OpenDialogMain.Execute then
  begin
    vMain.fcAddTab(Self.OpenDialogMain.FileName);
    // Then Update Current Data
  end;
end;

procedure TFormMain.MenuItemFileSaveAsClick(Sender: TObject);
begin
  if Self.SaveDialogMain.Execute then
  begin
    vupVar.vCurrentData.Update(Self.SaveDialogMain.FileName);
    Self.fcCurrentTabSheet.fcSave(vupVar.vCurrentData.vFileName);
    Self.fcCurrentTabSheet.fcUpdate(vupVar.vCurrentData.vASETypeLang,vupVar.vCurrentData.vHighlighter);
    // VUVar.vStatusBar.Update(Self.StatusBarMain,VUVar.vCurrentData.vLangTxt,VUVar.vCurrentData.vFileName);
  end;
end;

procedure TFormMain.MenuItemFileSaveClick(Sender: TObject);
begin
  if FileExists(vupVar.vCurrentData.vFileName) then
  begin
    // VUVar.vPageControl.Update(Self.PageControlMain,VUVar.vImageIndexNormalFile,VUVar.vCurrentData.vFileName);
    Self.fcCurrentTabSheet.fcSave(vupVar.vCurrentData.vFileName);
    Self.fcCurrentTabSheet.fcUpdate(vupVar.vCurrentData.vASETypeLang,vupVar.vCurrentData.vHighlighter);
    // VUVar.vStatusBar.Update(Self.StatusBarMain,VUVar.vCurrentData.vLangTxt,VUVar.vCurrentData.vFileName);
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
  with ((Self.PageControlMain.ActivePage) as tucTabSheet).vSynEdit do
  begin
    Color := vupTools.fcComplementaryColor(Color);
    Font.Color := vupTools.fcComplementaryColor(Color);
    Gutter.Color := vupTools.fcComplementaryColor(Color);
    Gutter.Parts[1].MarkupInfo.Background := vupTools.fcComplementaryColor(Gutter.Parts[1].MarkupInfo.Background);;
    LineHighlightColor.Background := vupTools.fcComplementaryColor(LineHighlightColor.Background);
  end;
end;

procedure TFormMain.PageControlMainChange(Sender: TObject);
begin
  // VUVar.vStatusBar.Update(Self.StatusBarMain,VUVar.vCurrentData.vLangTxt,VUVar.vCurrentData.vFileName);
end;

procedure TFormMain.SetLang (ALang : TASETypeLang);
begin
  vupVar.vCurrentData.Update(ALang);
  vMain.fcUpdate(vupVar.vCurrentData.vASETypeLang,vupVar.vCurrentData.vHighlighter);
  {
  Self.fcCurrentTabSheet.fcUpdate(VUVar.vCurrentData.vASETypeLang,VUVar.vCurrentData.vHighlighter);
  VUVar.vStatusBar.Update(Self.StatusBarMain,VUVar.vCurrentData.vASETypeLang);
  }
end;

procedure TFormMain.SpinEditFontSizeChange(Sender: TObject);
begin
  Self.fcCurrentSynEdit.Font.Size := Self.SpinEditFontSize.Value;
end;

procedure TFormMain.SynEditMainChange(Sender: TObject);
begin
  Self.PageControlMain.ActivePage.ImageIndex := vupVar.vImageIndexModifiedFile;
end;

function TFormMain.fcCurrentTabSheet : tucTabSheet;
begin
  Result := ((Self.PageControlMain.ActivePage) as tucTabSheet);
end;

function TFormMain.fcCurrentSynEdit : tucSynEdit;
begin
  Result := (((Self.PageControlMain.ActivePage) as tucTabSheet).vSynEdit as tucSynEdit);
end;

function TFormMain.fcCurrentSynCompletion : tucSynCompletion;
begin
  Result := (((Self.PageControlMain.ActivePage) as tucTabSheet).vSynCompletion as tucSynCompletion);
end;

end.

