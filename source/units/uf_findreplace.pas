unit uf_findreplace;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls, SynEditTypes;

type

  { TFormFindReplace }

  TFormFindReplace = class(TForm)
    ButtonReplace: TButton;
    ComboBoxDirection: TComboBox;
    EditFind: TEdit;
    EditReplaceWith: TEdit;
    GroupBoxOptions: TGroupBox;
    LabelFind: TLabel;
    LabelReplaceWith: TLabel;
    LabelDirection: TLabel;
    procedure ButtonReplaceClick(Sender: TObject);
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
  uf_main;

procedure TFormFindReplace.ButtonReplaceClick(Sender: TObject);
begin
  if Self.ComboBoxDirection.Text = 'Replace All' then
    FormMain.fcReplaceAll(Self.EditFind.Text,Self.EditReplaceWith.Text)
  else if Self.ComboBoxDirection.Text = 'Forward' then
    FormMain.fcReplaceForward(Self.EditFind.Text,Self.EditReplaceWith.Text)
  ;
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

