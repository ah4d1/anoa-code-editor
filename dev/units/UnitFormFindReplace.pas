unit UnitFormFindReplace;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls, SynEditTypes;

type

  { TFormFindReplace }

  TFormFindReplace = class(TForm)
    ButtonReplaceAll: TButton;
    ComboBoxDirection: TComboBox;
    EditFind: TEdit;
    EditReplaceWith: TEdit;
    GroupBoxOptions: TGroupBox;
    LabelFind: TLabel;
    LabelReplaceWith: TLabel;
    LabelDirection: TLabel;
    procedure ButtonReplaceAllClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public

  end;

var
  FormFindReplace: TFormFindReplace;

implementation

{$R *.lfm}

{ TFormFindReplace }

uses
  UnitFormMain, UnitCmpTabSheet;

procedure TFormFindReplace.ButtonReplaceAllClick(Sender: TObject);
begin
  ((FormMain.PageControlMain.ActivePage) as TUTabSheet).vSynEdit.SearchReplace(
    Self.EditFind.Text,Self.EditReplaceWith.Text,[ssoReplaceAll]
  );
end;

procedure TFormFindReplace.FormActivate(Sender: TObject);
begin
  Self.AlphaBlend := False;
  Self.AlphaBlendValue := 255;
end;

procedure TFormFindReplace.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  Self.Release;
end;

end.

