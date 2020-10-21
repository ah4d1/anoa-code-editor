unit uc_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Controls, SynEditHighlighter, UnitPasSynHighlighter, uc_pagecontrol, uc_statusbar;

type
  tucMain = class
  private
    FPageControl : tucPageControl;
    FStatusBar : tucStatusBar;
  public
    property vPageControl : tucPageControl read FPageControl write FPageControl;
    property vStatusBar : tucStatusBar read FStatusBar write FStatusBar;
    constructor Create (AOwner : TWinControl; AImageList : TImageList; AImageIndex : Byte;
      ACaption : string);
    procedure fcUpdate (ALang : TASETypeLang; AHighlighter : TSynCustomHighlighter);
  end;

implementation

constructor tucMain.Create (AOwner : TWinControl; AImageList : TImageList; AImageIndex : Byte;
  ACaption : string);
begin
  {
  Self.vPageControl := tucPageControl.Create(AOwner);
  Self.vPageControl.Parent := AOwner;
  Self.vPageControl.fcInit(AImageList,AImageIndex,ACaption);
  }
  Self.vStatusBar := tucStatusBar.Create(AOwner);
  Self.vStatusBar.Parent := AOwner;
  // Self.vStatusBar.fcInit;
  with Self.vStatusBar.Panels.Add do
  begin
    Width := 100;
    Text := 'TEST';
  end;
  with Self.vStatusBar.Panels.Add do
  begin
    Width := 200;
    Text := 'TEST';
  end;
end;

procedure tucMain.fcUpdate (ALang : TASETypeLang; AHighlighter : TSynCustomHighlighter);
begin
  Self.vPageControl.fcUpdate(ALang,AHighlighter);
  Self.vStatusBar.fcUpdate(ALang);
end;

end.

