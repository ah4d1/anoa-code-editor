unit UnitFormMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ComCtrls,
  StdCtrls, Spin, SynEdit, SynHighlighterPas, SynHighlighterJava,
  SynHighlighterHTML, SynHighlighterPHP, SynCompletion, SynHighlighterPython;

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
    SynCompletionHTML: TSynCompletion;
    SynCompletionPHP: TSynCompletion;
    SynCompletionPas: TSynCompletion;
    SynCompletionJava: TSynCompletion;
    SynEditMain: TSynEdit;
    SynHTMLSynMain: TSynHTMLSyn;
    SynJavaSynMain: TSynJavaSyn;
    SynPasSynMain: TSynPasSyn;
    SynPHPSynMain: TSynPHPSyn;
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
    procedure MenuItemSettingsLangPascalClick(Sender: TObject);
    procedure MenuItemSettingsLangPHPClick(Sender: TObject);
    procedure SpinEditFontSizeChange(Sender: TObject);
    procedure SynEditMainChange(Sender: TObject);
  private
    procedure OpenFile (AFileName : TFileName);
  public

  end;

var
  FormMain: TFormMain;

implementation

{$R *.lfm}

{ TFormMain }

uses
  UnitVar, UnitSave, UnitLang, UnitTools;

procedure TFormMain.MenuItemFileExitClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFormMain.MenuItemFileNewClick(Sender: TObject);
begin
  Self.PageControlMain.ActivePage.ImageIndex := 3;
  Self.PageControlMain.ActivePage.Caption := 'New';
  Self.SynEditMain.Lines.Clear;
  Self.StatusBarMain.SimpleText := 'Ready';
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
begin
  LFileName := AFileName;
  VUVar.vCurrentFileName := LFileName;
  Self.SynEditMain.Lines.LoadFromFile(LFileName);
  Self.PageControlMain.ActivePage.Caption := ExtractFileName(LFileName);
  Self.StatusBarMain.SimpleText := LFileName;
  VULang.SetHightlighter(LFileName,Self.SynEditMain,
    Self.SynHTMLSynMain,Self.SynJavaSynMain,Self.SynPasSynMain,Self.SynPHPSynMain
  );
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
  VULang.SetLang(aseLangHTML,Self.SynEditMain,
    Self.SynHTMLSynMain,Self.SynJavaSynMain,Self.SynPasSynMain,Self.SynPHPSynMain,
    Self.SynCompletionHTML,Self.SynCompletionJava,Self.SynCompletionPas,Self.SynCompletionPHP
  );
end;

procedure TFormMain.MenuItemSettingsLangJavaClick(Sender: TObject);
begin
  VULang.SetLang(aseLangJava,Self.SynEditMain,
    Self.SynHTMLSynMain,Self.SynJavaSynMain,Self.SynPasSynMain,Self.SynPHPSynMain,
    Self.SynCompletionHTML,Self.SynCompletionJava,Self.SynCompletionPas,Self.SynCompletionPHP
  );
end;

procedure TFormMain.MenuItemSettingsLangPascalClick(Sender: TObject);
begin
  VULang.SetLang(aseLangPas,Self.SynEditMain,
    Self.SynHTMLSynMain,Self.SynJavaSynMain,Self.SynPasSynMain,Self.SynPHPSynMain,
    Self.SynCompletionHTML,Self.SynCompletionJava,Self.SynCompletionPas,Self.SynCompletionPHP
  );
end;

procedure TFormMain.MenuItemSettingsLangPHPClick(Sender: TObject);
begin
  VULang.SetLang(aseLangPHP,Self.SynEditMain,
    Self.SynHTMLSynMain,Self.SynJavaSynMain,Self.SynPasSynMain,Self.SynPHPSynMain,
    Self.SynCompletionHTML,Self.SynCompletionJava,Self.SynCompletionPas,Self.SynCompletionPHP
  );
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
