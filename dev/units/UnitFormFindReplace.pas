unit UnitFormFindReplace;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls, SynEditTypes;

type

  { TFormFindReplace }

  TFormFindReplace = class(TForm)
    ButtonReplaceAll: TButton;
    EditFind: TEdit;
    EditReplaceWith: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    PageControlMain: TPageControl;
    TabSheetReplace: TTabSheet;
    procedure ButtonReplaceAllClick(Sender: TObject);
  private

  public

  end;

var
  FormFindReplace: TFormFindReplace;

implementation

{$R *.lfm}

{ TFormFindReplace }

uses
  UnitFormMain;

procedure TFormFindReplace.ButtonReplaceAllClick(Sender: TObject);
begin
  FormMain.SynEditMain.SearchReplace(Self.EditFind.Text,Self.EditReplaceWith.Text,[ssoReplaceAll]);;
end;

end.

