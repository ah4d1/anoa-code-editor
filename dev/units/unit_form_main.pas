unit unit_form_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ComCtrls,
  SynEdit, SynHighlighterPas, SynHighlighterJava, SynHighlighterHTML;

type

  { TFormMain }

  TFormMain = class(TForm)
    ImageListMain: TImageList;
    MainMenuMain: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
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
    StatusBarMain: TStatusBar;
    SynEditMain: TSynEdit;
    SynHTMLSynMain: TSynHTMLSyn;
    SynJavaSynMain: TSynJavaSyn;
    SynPasSynMain: TSynPasSyn;
    TabSheet1: TTabSheet;
    ToolBarMain: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItemFileExitClick(Sender: TObject);
    procedure MenuItemFileOpenClick(Sender: TObject);
    procedure MenuItemFileSaveAsClick(Sender: TObject);
    procedure MenuItemFileSaveClick(Sender: TObject);
    procedure MenuItemSettingsLangHTMLClick(Sender: TObject);
    procedure MenuItemSettingsLangJavaClick(Sender: TObject);
    procedure MenuItemSettingsLangPascalClick(Sender: TObject);
  private

  public

  end;

var
  FormMain: TFormMain;

implementation

{$R *.lfm}

{ TFormMain }

procedure TFormMain.MenuItemFileExitClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFormMain.MenuItem4Click(Sender: TObject);
begin
  MessageDlg('About','Anoa-Syntax-Editor',mtInformation,[mbOK],0);
end;

procedure TFormMain.MenuItemFileOpenClick(Sender: TObject);
var
  LFileName : TFileName;
begin
  if Self.OpenDialogMain.Execute then
  begin
    LFileName := Self.OpenDialogMain.FileName;
    Self.SynEditMain.Lines.LoadFromFile(LFileName);
    Self.StatusBarMain.SimpleText := LFileName;
  end;
end;

procedure TFormMain.MenuItemFileSaveAsClick(Sender: TObject);
begin
  if Self.OpenDialogMain.Execute then
  begin
    Self.SynEditMain.Lines.SaveToFile(Self.OpenDialogMain.FileName);
  end;
end;

procedure TFormMain.MenuItemFileSaveClick(Sender: TObject);
var
  LFileName : TFileName;
begin
  LFileName := Self.StatusBarMain.SimpleText;
  if FileExists(LFileName) then
  begin
    Self.SynEditMain.Lines.SaveToFile(LFileName);
  end;
end;

procedure TFormMain.MenuItemSettingsLangHTMLClick(Sender: TObject);
begin
  Self.SynEditMain.Highlighter := Self.SynHTMLSynMain;
end;

procedure TFormMain.MenuItemSettingsLangJavaClick(Sender: TObject);
begin
  Self.SynEditMain.Highlighter := Self.SynJavaSynMain;
end;

procedure TFormMain.MenuItemSettingsLangPascalClick(Sender: TObject);
begin
  Self.SynEditMain.Highlighter := Self.SynPasSynMain;
end;

end.

