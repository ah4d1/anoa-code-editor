unit uc_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Controls, Menus, SynEditHighlighter, up_synhighlighter, uc_pagecontrol, uc_statusbar;

type
  tucMain = class(TComponent)
  private
    FPageControl : tucPageControl;
    FStatusBar : tucStatusBar;
  public
    property vPageControl : tucPageControl read FPageControl write FPageControl;
    property vStatusBar : tucStatusBar read FStatusBar write FStatusBar;
    constructor Create (AOwner : TWinControl; AImageList : TImageList; APopupMenu : TPopupMenu); overload;
    procedure fcAddTab; overload;
    procedure fcAddTab (AFileName : TFileName); overload;
    procedure fcUpdate (ALang : TASETypeLang; AHighlighter : TSynCustomHighlighter);
  end;

implementation

uses
  up_var;

constructor tucMain.Create (AOwner : TWinControl; AImageList : TImageList; APopupMenu : TPopupMenu);
begin
  Self.vPageControl := tucPageControl.Create(AOwner);
  Self.vPageControl.Parent := AOwner;
  Self.vPageControl.fcInit(AImageList,APopupMenu);
  Self.vStatusBar := tucStatusBar.Create(AOwner);
  Self.vStatusBar.Parent := AOwner;
end;

procedure tucMain.fcAddTab;
begin
  vupVar.vTabNo := vupVar.vTabNo + 1;
  Self.vPageControl.fcAddTab(vupVar.vTabPrefix + IntToStr(vupVar.vTabNo),vupVar.vImageIndexNormalFile);
end;

procedure tucMain.fcAddTab (AFileName : TFileName);
begin
  vupVar.vTabNo := vupVar.vTabNo + 1;
  Self.vPageControl.fcAddTabThenOpen(AFileName,vupVar.vImageIndexNormalFile);
end;

procedure tucMain.fcUpdate (ALang : TASETypeLang; AHighlighter : TSynCustomHighlighter);
begin
  Self.vPageControl.fcUpdate(ALang,AHighlighter);
  Self.vStatusBar.fcUpdate(ALang);
end;

end.

