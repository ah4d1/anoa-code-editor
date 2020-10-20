unit UnitPasStatusBar;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, UnitPasSynHighlighter;

type
  TUStatusBar = class
    constructor Create;
    procedure Update (AStatusBar : TStatusBar; ALang : TASETypeLang); overload;
    procedure Update (AStatusBar : TStatusBar; ALangTxt : string); overload;
    procedure Update (AStatusBar : TStatusBar; ALangTxt : string; AFileName : TFileName); overload;
  end;

implementation

uses
  UnitPasLang;

constructor TUStatusBar.Create;
begin
  //
end;

procedure TUStatusBar.Update (AStatusBar : TStatusBar; ALang : TASETypeLang);
begin
  Self.Update(AStatusBar,VULang.GetLangTxt(ALang));
end;

procedure TUStatusBar.Update (AStatusBar : TStatusBar; ALangTxt : string);
begin
  AStatusBar.Panels[0].Text := ALangTxt;
end;

procedure TUStatusBar.Update (AStatusBar : TStatusBar; ALangTxt : string; AFileName : TFileName);
begin
  AStatusBar.Panels[0].Text := ALangTxt;
  AStatusBar.Panels[1].Text := AFileName;
end;

end.

