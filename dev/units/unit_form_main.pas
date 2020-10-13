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
    MenuItem2: TMenuItem;
    MenuItemFileOpen: TMenuItem;
    OpenDialogMain: TOpenDialog;
    StatusBarMain: TStatusBar;
    SynEditMain: TSynEdit;
    procedure MenuItem2Click(Sender: TObject);
  private

  public

  end;

var
  FormMain: TFormMain;

implementation

{$R *.lfm}

{ TFormMain }

procedure TFormMain.MenuItem2Click(Sender: TObject);
begin
  Application.Terminate;
end;

end.

