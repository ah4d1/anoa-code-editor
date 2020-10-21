unit UnitFormMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ComCtrls,
  StdCtrls, Spin, SynHighlighterCobol, SynEdit, SynCompletion, uc_tabsheet,
  uc_synedit, uc_syncompletion, UnitPasSynHighlighter;

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
    procedure AddTab;
    procedure OpenFile (AFileName : TFileName);
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
  uc_main, UnitFormFindReplace, UnitFormAbout, UnitPasVar, UnitPasTools;

var
  vMain : tucMain;

procedure TFormMain.FormCreate(Sender: TObject);
var
  LFileNameOnStart : TFileName;
begin
  VUVar := TUVar.Create(Self);
  Self.OpenDialogMain.Filter := string(VUVar.vSynHighlighter.fcSetDefaultFilter);
  Self.SaveDialogMain.Filter := string(VUVar.vSynHighlighter.fcSetDefaultFilter);

  vMain := tucMain.Create(Self,Self.ImageListMain,VUVar.vImageIndexNormalFile,'New');

  {
  with tucPageControl.Create(Self) do
  begin
    Align       := alClient;
    Images      := Self.ImageListMain;
    ImagesWidth := 24;
    PopupMenu   := Self.PopupMenuPageControl;
  end;
  }

  {
  Self.AddTab;

  LFileNameOnStart := string(VUTools.FcParamsInSingleText);
  if Trim(LFileNameOnStart) <> '' then Self.OpenFile(LFileNameOnStart);
  }
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
  Self.PageControlMain.ActivePage.Caption := 'New' + IntToStr(VUVar.vTabNo);
  Self.fcCurrentSynEdit.Lines.Clear;
  // VUVar.vStatusBar.Update(Self.StatusBarMain,'','');
end;

procedure TFormMain.MenuItem4Click(Sender: TObject);
begin
  FormAbout := TFormAbout.Create(Self);
  FormAbout.ShowModal;
end;

procedure TFormMain.MenuItemAddTabClick(Sender: TObject);
begin
  Self.AddTab;
end;

procedure TFormMain.AddTab;
begin
  with tucTabSheet.Create(Self) do
  begin
    Parent := Self.PageControlMain;
  end;
  Self.PageControlMain.TabIndex := Self.PageControlMain.PageCount - 1;
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
    Self.OpenFile(Self.OpenDialogMain.FileName);
  end;
end;

procedure TFormMain.OpenFile (AFileName : TFileName);
begin
  VUVar.vCurrentData.Update(AFileName);
  Self.fcCurrentSynEdit.fcOpen(AFileName);
  Self.fcCurrentTabSheet.fcOpen(AFileName);
  Self.fcCurrentTabSheet.fcUpdate(VUVar.vCurrentData.vASETypeLang,VUVar.vCurrentData.vHighlighter);
  // VUVar.vPageControl.Update(Self.PageControlMain,VUVar.vImageIndexNormalFile,VUVar.vCurrentData.vFileName);
  // VUVar.vStatusBar.Update(Self.StatusBarMain,VUVar.vCurrentData.vLangTxt,VUVar.vCurrentData.vFileName);
end;

procedure TFormMain.MenuItemFileSaveAsClick(Sender: TObject);
begin
  if Self.SaveDialogMain.Execute then
  begin
    VUVar.vCurrentData.Update(Self.SaveDialogMain.FileName);
    Self.fcCurrentTabSheet.fcSave(VUVar.vCurrentData.vFileName);
    Self.fcCurrentTabSheet.fcUpdate(VUVar.vCurrentData.vASETypeLang,VUVar.vCurrentData.vHighlighter);
    // VUVar.vStatusBar.Update(Self.StatusBarMain,VUVar.vCurrentData.vLangTxt,VUVar.vCurrentData.vFileName);
  end;
end;

procedure TFormMain.MenuItemFileSaveClick(Sender: TObject);
begin
  if FileExists(VUVar.vCurrentData.vFileName) then
  begin
    // VUVar.vPageControl.Update(Self.PageControlMain,VUVar.vImageIndexNormalFile,VUVar.vCurrentData.vFileName);
    Self.fcCurrentTabSheet.fcSave(VUVar.vCurrentData.vFileName);
    Self.fcCurrentTabSheet.fcUpdate(VUVar.vCurrentData.vASETypeLang,VUVar.vCurrentData.vHighlighter);
    // VUVar.vStatusBar.Update(Self.StatusBarMain,VUVar.vCurrentData.vLangTxt,VUVar.vCurrentData.vFileName);
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
  with ((Self.PageControlMain.ActivePage) as tucTabSheet).vSynEdit do
  begin
    Color := VUTools.ComplementaryColor(Color);
    Font.Color := VUTools.ComplementaryColor(Color);
    Gutter.Color := VUTools.ComplementaryColor(Color);
    Gutter.Parts[1].MarkupInfo.Background := VUTools.ComplementaryColor(Gutter.Parts[1].MarkupInfo.Background);;
    LineHighlightColor.Background := VUTools.ComplementaryColor(LineHighlightColor.Background);
  end;
end;

procedure TFormMain.PageControlMainChange(Sender: TObject);
begin
  // VUVar.vStatusBar.Update(Self.StatusBarMain,VUVar.vCurrentData.vLangTxt,VUVar.vCurrentData.vFileName);
end;

procedure TFormMain.SetLang (ALang : TASETypeLang);
begin
  VUVar.vCurrentData.Update(ALang);
  vMain.fcUpdate(VUVar.vCurrentData.vASETypeLang,VUVar.vCurrentData.vHighlighter);
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
  Self.PageControlMain.ActivePage.ImageIndex := VUVar.vImageIndexModifiedFile;
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

