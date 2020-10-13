unit unit_form_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ComCtrls,
  SynEdit, SynHighlighterPas;

type

  { TFormMain }

  TFormMain = class(TForm)
    ImageListMain: TImageList;
    MainMenuMain: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
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
    SynPasSynMain: TSynPasSyn;
    TabSheet1: TTabSheet;
    ToolBarMain: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    procedure MenuItemFileExitClick(Sender: TObject);
    procedure MenuItemFileOpenClick(Sender: TObject);
    procedure MenuItemFileSaveAsClick(Sender: TObject);
    procedure MenuItemFileSaveClick(Sender: TObject);
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

procedure TFormMain.MenuItemSettingsLangPascalClick(Sender: TObject);
begin
  Self.SynEditMain.Highlighter := Self.SynPasSynMain;
end;

end.

