unit uc_statusbar;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, up_currentdata, Dialogs;

type
  tucStatusBar = class(TStatusBar)
  public
    constructor Create (AOwner : TComponent); override;
    procedure fcUpdate (ACurrentData : tupCurrentData); overload;
  private
    procedure fcUpdate (ALangTxt : string; AFileName : TFileName); overload;
  end;

implementation

constructor tucStatusBar.Create (AOwner : TComponent);
begin
  inherited Create(AOwner);
  with Self.Panels.Add do
  begin
    Alignment := taCenter;
    Width := 100;
  end;
  with Self.Panels.Add do
  begin
    Alignment := taLeftJustify;
  end;
  Self.SimplePanel := False;
end;

procedure tucStatusBar.fcUpdate (ACurrentData : tupCurrentData);
begin
  Self.fcUpdate(ACurrentData.vLangTxt,ACurrentData.vFileName);
end;

procedure tucStatusBar.fcUpdate (ALangTxt : string; AFileName : TFileName);
begin
  Self.Panels[0].Text := ALangTxt;
  Self.Panels[1].Text := AFileName;
end;

end.

