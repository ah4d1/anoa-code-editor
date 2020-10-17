unit UnitFormMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ComCtrls,
  StdCtrls, Spin, SynHighlighterJSON, SynEdit, SynHighlighterPas,
  SynHighlighterJava, SynHighlighterHTML, SynHighlighterPHP, SynCompletion,
  SynHighlighterPython, UnitPasVar;

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
    SynCompletionPython: TSynCompletion;
    SynCompletionHTML: TSynCompletion;
    SynCompletionPHP: TSynCompletion;
    SynCompletionPas: TSynCompletion;
    SynCompletionJava: TSynCompletion;
    SynCompletionJSON: TSynCompletion;
    SynEditMain: TSynEdit;
    SynHTMLSynMain: TSynHTMLSyn;
    SynJavaSynMain: TSynJavaSyn;
    SynJSONSynMain: TSynJSONSyn;
    SynPasSynMain: TSynPasSyn;
    SynPHPSynMain: TSynPHPSyn;
    SynPythonSynMain: TSynPythonSyn;
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
    procedure MenuItemSettingsLangHTMLClick(Sender: TObject);
    procedure MenuItemSettingsLangJavaClick(Sender: TObject);
    procedure MenuItemSettingsLangJSONClick(Sender: TObject);
    procedure MenuItemSettingsLangPascalClick(Sender: TObject);
    procedure MenuItemSettingsLangPHPClick(Sender: TObject);
    procedure MenuItemSettingsLangPythonClick(Sender: TObject);
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
  UnitPasSave, UnitPasLang, UnitPasTools;

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

procedure TFormMain.FormCreate(Sender: TObject);
var
  LDefaultFilter : WideString;
  LFileNameOnStart : TFileName;
begin
  VUVar.fcInit;

  LDefaultFilter := ''
    + 'All Files (*.*)|*.*'
    + '|' + Self.SynHTMLSynMain.DefaultFilter
    + '|' + Self.SynJavaSynMain.DefaultFilter
    + '|' + Self.SynPasSynMain.DefaultFilter
    + '|' + Self.SynPHPSynMain.DefaultFilter
  ;
  Self.OpenDialogMain.Filter := LDefaultFilter;

  LFileNameOnStart := VUTools.FcParamsInSingleText;
  if Trim(LFileNameOnStart) <> '' then
  begin
    Self.OpenFile(LFileNameOnStart);
  end;
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
  LLangTxt := VULang.SetHightlighter(LFileName,Self.SynEditMain,
    Self.SynHTMLSynMain,Self.SynJavaSynMain,Self.SynJSONSynMain,Self.SynPasSynMain,
    Self.SynPHPSynMain,Self.SynPythonSynMain
  );
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

procedure TFormMain.SetLang (ALang : TASETypeLang);
var
  LLangText : string;
begin
  LLangText := VULang.SetLang(ALang,Self.SynEditMain,
    Self.SynHTMLSynMain,Self.SynJavaSynMain,Self.SynJSONSynMain,Self.SynPasSynMain,
      Self.SynPHPSynMain,Self.SynPythonSynMain,
    Self.SynCompletionHTML,Self.SynCompletionJava,Self.SynCompletionJSON,Self.SynCompletionPas,
      Self.SynCompletionPHP,Self.SynCompletionPython
  );
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

