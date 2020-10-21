unit uc_statusbar;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, UnitPasSynHighlighter, Dialogs;

type
  tucStatusBar = class(TStatusBar)
  private
    FStatusPanel0 : TStatusPanel;
    FStatusPanel1 : TStatusPanel;
  public
    property vStatusPanel0 : TStatusPanel read FStatusPanel0 write FStatusPanel0;
    property vStatusPanel1 : TStatusPanel read FStatusPanel1 write FStatusPanel1;
    constructor Create (AOwner : TComponent); override;
    procedure fcInit;
    procedure fcUpdate (ALang : TASETypeLang);
    procedure fcUpdate (ALangTxt : string);
    procedure fcUpdate (ALangTxt : string; AFileName : TFileName);
  end;

implementation

uses
  UnitPasLang;

constructor tucStatusBar.Create (AOwner : TComponent);
begin
  inherited Create(AOwner);
  Self.vStatusPanel0 := Self.Panels.Add;
  Self.vStatusPanel0.Width := 200;
  Self.vStatusPanel0.Text := 'TEST';
  {
  with Self.Panels.Add do
  begin
    Alignment := taLeftJustify;
    Text := 'Test';
    Width := 100;
  end;
  with Self.Panels.Add do
  begin
    Alignment := taLeftJustify;
    Text := 'Test';
    Width := 100;
  end;
  }
end;

procedure tucStatusBar.fcInit;
begin
  {}
end;

procedure tucStatusBar.fcUpdate (ALang : TASETypeLang);
begin
  Self.fcUpdate(VULang.GetLangTxt(ALang));
end;

procedure tucStatusBar.fcUpdate (ALangTxt : string);
begin
  Self.Panels[0].Text := ALangTxt;
end;

procedure tucStatusBar.fcUpdate (ALangTxt : string; AFileName : TFileName);
begin
  Self.Panels[0].Text := ALangTxt;
  Self.Panels[1].Text := AFileName;
end;

end.

