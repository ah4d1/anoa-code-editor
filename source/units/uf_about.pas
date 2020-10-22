unit uf_about;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  SynEdit;

type

  { TFormAbout }

  TFormAbout = class(TForm)
    Image1: TImage;
    PanelLeft: TPanel;
    SynEdit1: TSynEdit;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public

  end;

var
  FormAbout: TFormAbout;

implementation

{$R *.lfm}

{ TFormAbout }

procedure TFormAbout.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Self.Release;
end;

end.

