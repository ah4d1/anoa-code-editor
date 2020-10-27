unit uf_findreplace;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  ExtCtrls, SynEditTypes;

type

  { TFormFindReplace }

  TFormFindReplace = class(TForm)
    ButtonFind: TButton;
    CheckBoxReplaceWith: TCheckBox;
    CheckBoxBackwards: TCheckBox;
    CheckBoxEntireScope: TCheckBox;
    CheckBoxMatchCase: TCheckBox;
    CheckBoxReplace: TCheckBox;
    CheckBoxReplaceAll: TCheckBox;
    CheckBoxSelectedOnly: TCheckBox;
    CheckBoxWholeWord: TCheckBox;
    EditFind: TEdit;
    EditReplaceWith: TEdit;
    GroupBoxOptions: TGroupBox;
    LabelFind: TLabel;
    procedure ButtonFindClick(Sender: TObject);
    procedure CheckBoxEntireScopeChange(Sender: TObject);
    procedure CheckBoxReplaceAllChange(Sender: TObject);
    procedure CheckBoxReplaceChange(Sender: TObject);
    procedure CheckBoxReplaceWithChange(Sender: TObject);
    procedure CheckBoxSelectedOnlyChange(Sender: TObject);
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
  FormMain.fcReplace(Self.EditFind.Text,Self.EditReplaceWith.Text,LSynSearchOptions);
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
    Self.EditReplaceWith.Enabled := True;
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
    Self.EditReplaceWith.Enabled := False;
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

