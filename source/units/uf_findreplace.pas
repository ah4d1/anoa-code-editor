unit uf_findreplace;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  ExtCtrls, SynEditTypes;

type

  { TFormFindReplace }

  TFormFindReplace = class(TForm)
    ButtonClose: TButton;
    ButtonFind: TButton;
    CheckBoxReplaceWith: TCheckBox;
    CheckBoxBackwards: TCheckBox;
    CheckBoxEntireScope: TCheckBox;
    CheckBoxMatchCase: TCheckBox;
    CheckBoxReplace: TCheckBox;
    CheckBoxReplaceAll: TCheckBox;
    CheckBoxSpecialChar: TCheckBox;
    CheckBoxSelectedOnly: TCheckBox;
    CheckBoxWholeWord: TCheckBox;
    ComboBoxReplaceWith: TComboBox;
    EditFind: TEdit;
    GroupBoxOptions: TGroupBox;
    LabelFind: TLabel;
    procedure ButtonCloseClick(Sender: TObject);
    procedure ButtonFindClick(Sender: TObject);
    procedure CheckBoxEntireScopeChange(Sender: TObject);
    procedure CheckBoxReplaceAllChange(Sender: TObject);
    procedure CheckBoxReplaceChange(Sender: TObject);
    procedure CheckBoxReplaceWithChange(Sender: TObject);
    procedure CheckBoxSelectedOnlyChange(Sender: TObject);
    procedure CheckBoxSpecialCharChange(Sender: TObject);
    procedure EditFindKeyPress(Sender: TObject; var Key: char);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  FormFindReplace: TFormFindReplace;

implementation

{$R *.lfm}

{ TFormFindReplace }

uses
  uf_main, up_var;

procedure TFormFindReplace.ButtonFindClick(Sender: TObject);
var
  LSynSearchOptions : TSynSearchOptions;
begin
  LSynSearchOptions := [];
  if Self.CheckBoxMatchCase.Checked then LSynSearchOptions := LSynSearchOptions + [ssoMatchCase];
  if Self.CheckBoxWholeWord.Checked then LSynSearchOptions := LSynSearchOptions + [ssoWholeWord];
  if Self.CheckBoxBackwards.Checked then LSynSearchOptions := LSynSearchOptions + [ssoBackwards];
  if Self.CheckBoxEntireScope.Checked then LSynSearchOptions := LSynSearchOptions + [ssoEntireScope];
  if Self.CheckBoxSelectedOnly.Checked then LSynSearchOptions := LSynSearchOptions + [ssoSelectedOnly];
  if Self.CheckBoxReplace.Checked then LSynSearchOptions := LSynSearchOptions + [ssoReplace];
  if Self.CheckBoxReplaceAll.Checked then LSynSearchOptions := LSynSearchOptions + [ssoReplaceAll];
  vupVar.vCurrentFindKeyword := Self.EditFind.Text;
  FormMain.fcReplace(Self.EditFind.Text,Self.ComboBoxReplaceWith.Text,LSynSearchOptions,
    Self.CheckBoxSpecialChar.Checked,Self.ComboBoxReplaceWith.Text
  );
end;

procedure TFormFindReplace.ButtonCloseClick(Sender: TObject);
begin
  Self.Release;
end;

procedure TFormFindReplace.CheckBoxEntireScopeChange(Sender: TObject);
begin
  if Self.CheckBoxEntireScope.Checked then Self.CheckBoxSelectedOnly.Checked := False;
end;

procedure TFormFindReplace.CheckBoxReplaceAllChange(Sender: TObject);
begin
  if Self.CheckBoxReplaceAll.Checked then
  begin
    Self.CheckBoxReplace.Checked := False;
    Self.ButtonFind.Caption := 'Replace';
  end;
  if not(Self.CheckBoxReplace.Checked) and not(Self.CheckBoxReplaceAll.Checked) then
    Self.ButtonFind.Caption := 'Find';
  ;
end;

procedure TFormFindReplace.CheckBoxReplaceChange(Sender: TObject);
begin
  if Self.CheckBoxReplace.Checked then
  begin
    Self.CheckBoxReplaceAll.Checked := False;
    Self.ButtonFind.Caption := 'Replace';
  end;
  if not(Self.CheckBoxReplace.Checked) and not(Self.CheckBoxReplaceAll.Checked) then
    Self.ButtonFind.Caption := 'Find';
  ;
end;

procedure TFormFindReplace.CheckBoxReplaceWithChange(Sender: TObject);
begin
  if Self.CheckBoxReplaceWith.Checked then
  begin
    Self.ComboBoxReplaceWith.Enabled := True;
    Self.CheckBoxSpecialChar.Enabled := True;
    {Enabled}
    Self.CheckBoxEntireScope.Enabled := True;
    Self.CheckBoxSelectedOnly.Enabled := True;
    Self.CheckBoxReplace.Enabled := True;
    Self.CheckBoxReplaceAll.Enabled := True;
    {Checked}
    Self.CheckBoxEntireScope.Checked := True;
    Self.CheckBoxReplaceAll.Checked := True;
  end
  else
  begin
    Self.ComboBoxReplaceWith.Enabled := False;
    Self.CheckBoxSpecialChar.Enabled := False;
    {Checked}
    Self.CheckBoxEntireScope.Checked := False;
    Self.CheckBoxSelectedOnly.Checked := False;
    Self.CheckBoxReplace.Checked := False;
    Self.CheckBoxReplaceAll.Checked := False;
    {Enabled}
    Self.CheckBoxEntireScope.Enabled := False;
    Self.CheckBoxSelectedOnly.Enabled := False;
    Self.CheckBoxReplace.Enabled := False;
    Self.CheckBoxReplaceAll.Enabled := False;
  end;
end;

procedure TFormFindReplace.CheckBoxSelectedOnlyChange(Sender: TObject);
begin
  if Self.CheckBoxSelectedOnly.Checked then Self.CheckBoxEntireScope.Checked := False;
end;

procedure TFormFindReplace.CheckBoxSpecialCharChange(Sender: TObject);
begin
  case Self.CheckBoxSpecialChar.Checked of
    True :
      begin
        Self.ComboBoxReplaceWith.Style := csDropDownList;
        Self.ComboBoxReplaceWith.Items.Add('\n');
        Self.ComboBoxReplaceWith.Items.Add('\t');
      end;
    False :
      begin
        Self.ComboBoxReplaceWith.Style := csDropDown;
        Self.ComboBoxReplaceWith.Items.Clear;
      end;
  end;
end;

procedure TFormFindReplace.EditFindKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then Self.ButtonFindClick(Sender);
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

procedure TFormFindReplace.FormShow(Sender: TObject);
begin
  Self.ActiveControl := Self.EditFind;
end;

end.

