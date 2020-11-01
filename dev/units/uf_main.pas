unit uf_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ComCtrls,
  StdCtrls, Spin, ExtCtrls, ShellCtrls, ActnList, SynHighlighterCobol, SynEdit,
  SynCompletion, SynEditTypes, SynHighlighterPas, ac_app,
  ace_synedit, ace_synhighlighter;

type

  { TFormMain }

  TFormMain = class(TForm)
    ActionTabCloseCurrent: TAction;
    ActionTabAddNew: TAction;
    ActionTabCloseOthers: TAction;
    ActionTabCloseAll: TAction;
    ActionListMain: TActionList;
    ButtonCloseTab: TButton;
    ImageListMain: TImageList;
    LabelFontSize: TLabel;
    MainMenuMain: TMainMenu;
    MenuItemSettingsSpecialCharsHide: TMenuItem;
    MenuItemSettingsSpecialCharsShow: TMenuItem;
    MenuItemSettingsSpecialChars: TMenuItem;
    MenuItemSettingsThemeDark: TMenuItem;
    MenuItemSettingsThemeNormal: TMenuItem;
    MenuItemSettingsTheme: TMenuItem;
    MenuItemFile: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItemControlsCloseAllOtherTabs: TMenuItem;
    MenuItemControlsCloseAllTabs: TMenuItem;
    MenuItemControlsCloseCurrentTab: TMenuItem;
    MenuItemControlsAddNewTab: TMenuItem;
    MenuItemControls: TMenuItem;
    MenuItemCloseAllOtherTabs: TMenuItem;
    MenuItemEditFindNext: TMenuItem;
    MenuItemOpen: TMenuItem;
    MenuItemExit: TMenuItem;
    MenuItemFileRun: TMenuItem;
    MenuItemRun: TMenuItem;
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
    MenuItemSettingsLangCobol: TMenuItem;
    MenuItemSettingsLangSQL: TMenuItem;
    MenuItemSettingsLangCSharp: TMenuItem;
    MenuItemSettingsLangJSON: TMenuItem;
    MenuItemSettingsLangPython: TMenuItem;
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
    PanelToolbarCenter: TPanel;
    PanelToolbarLeft: TPanel;
    PanelToolbarRight: TPanel;
    PanelToolbar: TPanel;
    PopupMenuShell: TPopupMenu;
    PopupMenuSynEdit: TPopupMenu;
    PopupMenuPageControl: TPopupMenu;
    SaveDialogMain: TSaveDialog;
    ShellTreeViewMain: TShellTreeView;
    SpinEditFontSize: TSpinEdit;
    SplitterMain: TSplitter;
    ToolBarMain: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButtonRun: TToolButton;
    ToolButton9: TToolButton;
    ToolButtonCut: TToolButton;
    ToolButtonFindReplace: TToolButton;
    ToolButtonPaste: TToolButton;
    ToolButtonRedo: TToolButton;
    ToolButtonUndo: TToolButton;
    procedure ActionTabAddNewExecute(Sender: TObject);
    procedure ActionTabCloseAllExecute(Sender: TObject);
    procedure ActionTabCloseCurrentExecute(Sender: TObject);
    procedure ActionTabCloseOthersExecute(Sender: TObject);
    procedure ButtonCloseTabClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure MenuItemEditCopyClick(Sender: TObject);
    procedure MenuItemEditCutClick(Sender: TObject);
    procedure MenuItemEditFindNextClick(Sender: TObject);
    procedure MenuItemEditPasteClick(Sender: TObject);
    procedure MenuItemEditSelectAllClick(Sender: TObject);
    procedure MenuItemHelpAboutClick(Sender: TObject);
    procedure MenuItemEditShowCompletionClick(Sender: TObject);
    procedure MenuItemEditFindReplaceClick(Sender: TObject);
    procedure MenuItemEditRedoClick(Sender: TObject);
    procedure MenuItemEditUndoClick(Sender: TObject);
    procedure MenuItemFileExitClick(Sender: TObject);
    procedure MenuItemFileOpenClick(Sender: TObject);
    procedure MenuItemFileSaveAsClick(Sender: TObject);
    procedure MenuItemFileSaveClick(Sender: TObject);
    procedure MenuItemFileRunClick(Sender: TObject);
    procedure MenuItemOpenClick(Sender: TObject);
    procedure MenuItemRunClick(Sender: TObject);
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
    procedure MenuItemSettingsSpecialCharsHideClick(Sender: TObject);
    procedure MenuItemSettingsSpecialCharsShowClick(Sender: TObject);
    procedure MenuItemSettingsThemeDarkClick(Sender: TObject);
    procedure MenuItemSettingsThemeNormalClick(Sender: TObject);
    procedure ShellTreeViewMainCollapsed(Sender: TObject; Node: TTreeNode);
    procedure ShellTreeViewMainDblClick(Sender: TObject);
    procedure ShellTreeViewMainExpanded(Sender: TObject; Node: TTreeNode);
    procedure SpinEditFontSizeChange(Sender: TObject);
    procedure fcReplace (AOldPattern,ANewPattern : string; ASynSearchOptions : TSynSearchOptions;
      AIsSpecialChar : Boolean; ASpecialChar : string);
  private
    procedure UpdateShellTreeViewImages;
    procedure SetLang (ALang : TAceShLang);
  public

  end;

var
  FormMain: TFormMain;

implementation

{$R *.lfm}

{ TFormMain }

uses
  uc_main, uf_findreplace, uf_about, up_var, up_currentdata;

procedure TFormMain.FormCreate(Sender: TObject);
var
  LFileNameOnStart : TFileName;
begin
  vupVar := tupVar.Create(Self);
  vupVar.vAppDir := ExtractFilePath(Application.ExeName);
  vupVar.fcInit(Self);
  vupCurrentData := tupCurrentData.Create(vupVar.vSynHighlighter);
  LFileNameOnStart := string(vacApp.fcGetParam);
  Self.OpenDialogMain.Filter := string(vupVar.vSynHighlighter.vDefaultFilter);
  Self.SaveDialogMain.Filter := string(vupVar.vSynHighlighter.vDefaultFilter);
  vucMain := tucMain.Create(Self,Self.ImageListMain,Self.PopupMenuPageControl,
    Self.SpinEditFontSize,Self.SaveDialogMain
  );
  if Trim(LFileNameOnStart) = '' then
    vucMain.fcAddNewTab(Self.PopupMenuSynEdit)
  else
  begin
    vupCurrentData.fcUpdate(LFileNameOnStart);
    vucMain.fcAddNewTab(vupCurrentData,Self.PopupMenuSynEdit);
  end;
  Self.UpdateShellTreeViewImages;
  Self.ActiveControl := vucMain.vPageControl.fcCurrentTabSheet.vSynEdit;
end;

procedure TFormMain.UpdateShellTreeViewImages;
var
  i : Integer;
begin
  for i := 0 to Self.ShellTreeViewMain.Items.Count - 1 do
  begin
    if Self.ShellTreeViewMain.Items[i].HasChildren then
    begin
      if Self.ShellTreeViewMain.Items[i].Expanded then
        Self.ShellTreeViewMain.Items[i].ImageIndex := 0
      else
        Self.ShellTreeViewMain.Items[i].ImageIndex := 13
      ;
    end
    else
      Self.ShellTreeViewMain.Items[i].ImageIndex := 14
    ;
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

procedure TFormMain.MenuItemEditFindNextClick(Sender: TObject);
begin
  vucMain.fcFindNext;
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
  vucMain.fcCloseAllTabs(vupCurrentData,Self.PopupMenuSynEdit);
end;

procedure TFormMain.ButtonCloseTabClick(Sender: TObject);
begin
  vucMain.fcCloseCurrentTab(vupCurrentData,Self.PopupMenuSynEdit);
end;

procedure TFormMain.ActionTabCloseAllExecute(Sender: TObject);
begin
  vucMain.fcCloseAllTabs(vupCurrentData,Self.PopupMenuSynEdit);
  Self.ActiveControl := vucMain.vPageControl.fcCurrentTabSheet.vSynEdit;
end;

procedure TFormMain.ActionTabCloseCurrentExecute(Sender: TObject);
begin
  vucMain.fcCloseCurrentTab(vupCurrentData,Self.PopupMenuSynEdit);
  Self.ActiveControl := vucMain.vPageControl.fcCurrentTabSheet.vSynEdit;
end;

procedure TFormMain.ActionTabAddNewExecute(Sender: TObject);
begin
  vupCurrentData.fcUpdate(aceShLangNone,'');
  vucMain.fcAddNewTab(Self.PopupMenuSynEdit);
  vucMain.fcUpdate(vupCurrentData);
  Self.ActiveControl := vucMain.vPageControl.fcCurrentTabSheet.vSynEdit;
end;

procedure TFormMain.ActionTabCloseOthersExecute(Sender: TObject);
begin
  vucMain.fcCloseAllOtherTabs(vupCurrentData,Self.PopupMenuSynEdit);
  Self.ActiveControl := vucMain.vPageControl.fcCurrentTabSheet.vSynEdit;
end;

procedure TFormMain.MenuItemFileExitClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFormMain.MenuItemHelpAboutClick(Sender: TObject);
begin
  FormAbout := TFormAbout.Create(Self);
  FormAbout.ShowModal;
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

procedure TFormMain.fcReplace (AOldPattern,ANewPattern : string; ASynSearchOptions : TSynSearchOptions;
  AIsSpecialChar : Boolean; ASpecialChar : string);
begin
  vucMain.fcReplace(AOldPattern,ANewPattern,ASynSearchOptions,AIsSpecialChar,ASpecialChar);
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
      vupVar.fcUpdate(Self.SpinEditFontSize.Value);
      vupCurrentData.fcUpdate(Self.OpenDialogMain.Files[i-1]);
      vucMain.fcAddNewTab(vupCurrentData,Self.PopupMenuSynEdit);
      vucMain.fcUpdate(vupCurrentData);
    end;
  end;
end;

procedure TFormMain.MenuItemFileSaveAsClick(Sender: TObject);
begin
  Self.SaveDialogMain.FileName := '';
  if Self.SaveDialogMain.Execute then
  begin
    vupVar.fcUpdate(Self.SpinEditFontSize.Value);
    vupCurrentData.fcUpdate(Self.SaveDialogMain.FileName);
    vucMain.fcSave(vupCurrentData.vFileName);
    vucMain.fcUpdate(vupCurrentData);
  end;
end;

procedure TFormMain.MenuItemFileSaveClick(Sender: TObject);
begin
  Self.SaveDialogMain.FileName := '';
  if FileExists(vupCurrentData.vFileName) then
  begin
    vupVar.fcUpdate(Self.SpinEditFontSize.Value);
    vupCurrentData.fcUpdate(vupCurrentData.vFileName);
    vucMain.fcSave(vupCurrentData.vFileName);
    vucMain.fcUpdate(vupCurrentData);
  end
  else
    Self.MenuItemFileSaveAsClick(Sender)
  ;
end;

procedure TFormMain.MenuItemFileRunClick(Sender: TObject);
begin
  vucMain.fcRunCommand;
end;

procedure TFormMain.MenuItemOpenClick(Sender: TObject);
var
  i : Integer;
begin
  for i := 1 to Self.ShellTreeViewMain.SelectionCount do
  begin
    vupVar.fcUpdate(Self.SpinEditFontSize.Value);
    vupCurrentData.fcUpdate(Self.ShellTreeViewMain.Selections[i-1].GetTextPath);
    vucMain.fcAddNewTab(vupCurrentData,Self.PopupMenuSynEdit);
    vucMain.fcUpdate(vupCurrentData);
  end;
end;

procedure TFormMain.MenuItemRunClick(Sender: TObject);
begin
  vucMain.fcRunCommand;
end;

procedure TFormMain.MenuItemSettingsLangCobolClick(Sender: TObject);
begin
  Self.SetLang(aceShLangCobol);
end;

procedure TFormMain.MenuItemSettingsLangCSharpClick(Sender: TObject);
begin
  Self.SetLang(aceShLangCS);
end;

procedure TFormMain.MenuItemSettingsLangCSSClick(Sender: TObject);
begin
  Self.SetLang(aceShLangCSS);
end;

procedure TFormMain.MenuItemSettingsLangHTMLClick(Sender: TObject);
begin
  Self.SetLang(aceShLangHTML);
end;

procedure TFormMain.MenuItemSettingsLangJavaClick(Sender: TObject);
begin
  Self.SetLang(aceShLangJava);
end;

procedure TFormMain.MenuItemSettingsLangJSONClick(Sender: TObject);
begin
  Self.SetLang(aceShLangJSON);
end;

procedure TFormMain.MenuItemSettingsLangNoneClick(Sender: TObject);
begin
  Self.SetLang(aceShLangNone);
end;

procedure TFormMain.MenuItemSettingsLangPascalClick(Sender: TObject);
begin
  Self.SetLang(aceShLangPas);
end;

procedure TFormMain.MenuItemSettingsLangPHPClick(Sender: TObject);
begin
  Self.SetLang(aceShLangPHP);
end;

procedure TFormMain.MenuItemSettingsLangPythonClick(Sender: TObject);
begin
  Self.SetLang(aceShLangPython);
end;

procedure TFormMain.MenuItemSettingsLangSQLClick(Sender: TObject);
begin
  Self.SetLang(aceShLangSQL);
end;

procedure TFormMain.MenuItemSettingsSpecialCharsHideClick(Sender: TObject);
begin
  vupVar.vShowSpecialChars := False;
  vucMain.fcUpdate;
end;

procedure TFormMain.MenuItemSettingsSpecialCharsShowClick(Sender: TObject);
begin
  vupVar.vShowSpecialChars := True;
  vucMain.fcUpdate;
end;

procedure TFormMain.SetLang (ALang : TAceShLang);
begin
  vupCurrentData.fcUpdate(ALang);
  vucMain.fcUpdate(vupCurrentData);
end;

procedure TFormMain.MenuItemSettingsThemeDarkClick(Sender: TObject);
begin
  vupVar.vCurrentTheme := aceSeThemeDark;
  vucMain.fcUpdate;
end;

procedure TFormMain.MenuItemSettingsThemeNormalClick(Sender: TObject);
begin
  vupVar.vCurrentTheme := aceSeThemeNormal;
  vucMain.fcUpdate;
end;

procedure TFormMain.ShellTreeViewMainCollapsed(Sender: TObject; Node: TTreeNode);
begin
  Self.UpdateShellTreeViewImages
end;

procedure TFormMain.ShellTreeViewMainDblClick(Sender: TObject);
begin
  if FileExists(Self.ShellTreeViewMain.Selected.GetTextPath) then
    begin
      vupVar.fcUpdate(Self.SpinEditFontSize.Value);
      vupCurrentData.fcUpdate(Self.ShellTreeViewMain.Selected.GetTextPath);
      vucMain.fcAddNewTab(vupCurrentData,Self.PopupMenuSynEdit);
      vucMain.fcUpdate(vupCurrentData);
    end;
end;

procedure TFormMain.ShellTreeViewMainExpanded(Sender: TObject; Node: TTreeNode);
begin
  Self.UpdateShellTreeViewImages;
end;

procedure TFormMain.SpinEditFontSizeChange(Sender: TObject);
begin
  vupVar.fcUpdate(Self.SpinEditFontSize.Value);
  vucMain.fcUpdate;
end;

end.

