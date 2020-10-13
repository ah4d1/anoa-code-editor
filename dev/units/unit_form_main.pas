unit unit_form_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ComCtrls,
  SynEdit;

type

  { TFormMain }

  TFormMain = class(TForm)
    MainMenuMain: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItemFileExit: TMenuItem;
    MenuItemFileSaveAs: TMenuItem;
    MenuItemFileOpen: TMenuItem;
    OpenDialogMain: TOpenDialog;
    SaveDialogMain: TSaveDialog;
    StatusBarMain: TStatusBar;
    SynEditMain: TSynEdit;
    procedure MenuItemFileExitClick(Sender: TObject);
    procedure MenuItemFileOpenClick(Sender: TObject);
    procedure MenuItemFileSaveAsClick(Sender: TObject);
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
begin
  if Self.OpenDialogMain.Execute then
  begin
    Self.SynEditMain.Lines.LoadFromFile(Self.OpenDialogMain.FileName);
  end;
end;

procedure TFormMain.MenuItemFileSaveAsClick(Sender: TObject);
begin
  if Self.OpenDialogMain.Execute then
  begin
    Self.SynEditMain.Lines.SaveToFile(Self.OpenDialogMain.FileName);
  end;
end;

end.
