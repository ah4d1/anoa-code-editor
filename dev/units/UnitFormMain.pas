unit UnitFormMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ComCtrls,
  StdCtrls, Spin, SynEdit, SynCompletion, UnitPasSynHighlighter;

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
    procedure FormCreate(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
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
  UnitPasVar, UnitPasSave, UnitPasLang, UnitPasTools;

procedure TFormMain.FormCreate(Sender: TObject);
var
  LFileNameOnStart : TFileName;
begin
  VUVar := TUVar.Create(Self);
  Self.OpenDialogMain.Filter := string(VUVar.vSynHighlighter.fcSetDefaultFilter);

  LFileNameOnStart := string(VUTools.FcParamsInSingleText);
  if Trim(LFileNameOnStart) <> '' then Self.OpenFile(LFileNameOnStart);
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
  Self.StatusBarMain.Panels[1].Text := '';
end;

procedure TFormMain.MenuItem4Click(Sender: TObject);
begin
  MessageDlg('About','Anoa-Syntax-Editor',mtInformation,[mbOK],0);
end;

procedure TFormMain.MenuItemFileOpenClick(Sender: TObject);
begin
  if Self.OpenDialogMain.Execute then
  begin
    Self.OpenFile(Self.OpenDialogMain.FileName);
  end;
end;

procedure TFormMain.OpenFile (AFileName : TFileName);
var
  LFileName : TFileName;
  LLangTxt : string;
begin
  LFileName := AFileName;
  VUVar.vCurrentFileName := LFileName;
  Self.SynEditMain.Lines.LoadFromFile(LFileName);
  Self.PageControlMain.ActivePage.Caption := ExtractFileName(LFileName);
  LLangTxt := VULang.SetLang(LFileName,Self.SynEditMain,Self.SynCompletionMain);
  Self.StatusBarMain.Panels[0].Text := LLangTxt;
  Self.StatusBarMain.Panels[1].Text := LFileName;
end;

procedure TFormMain.MenuItemFileSaveAsClick(Sender: TObject);
begin
  if Self.OpenDialogMain.Execute then
  begin
    Self.SynEditMain.Lines.SaveToFile(Self.OpenDialogMain.FileName);
  end;
end;

procedure TFormMain.MenuItemFileSaveClick(Sender: TObject);
begin
  VUSave.Save(VUVar.vCurrentFileName,Self.SynEditMain,Self.PageControlMain,VUVar.vImageIndexNormalFile);
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
var
  LLangText : string;
begin
  LLangText := VULang.SetLang(ALang,Self.SynEditMain,Self.SynCompletionMain);
  Self.StatusBarMain.Panels[0].Text := LLangText;
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

