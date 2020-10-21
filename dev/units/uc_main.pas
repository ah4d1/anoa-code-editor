unit uc_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Controls, Menus, SynEditHighlighter, up_synhighlighter, uc_pagecontrol, uc_statusbar;

type
  tucMain = class(TComponent)
  private
    FTabPrefix : string;
    FTabNo : Byte;
    FPageControl : tucPageControl;
    FStatusBar : tucStatusBar;
  public
    property vTabPrefix : string read FTabPrefix write FTabPrefix;
    property vTabNo : Byte read FTabNo write FTabNo;
    property vPageControl : tucPageControl read FPageControl write FPageControl;
    property vStatusBar : tucStatusBar read FStatusBar write FStatusBar;
    constructor Create (AOwner : TWinControl; AImageList : TImageList; APopupMenu : TPopupMenu); overload;
    procedure fcUpdate (ALang : TASETypeLang; AHighlighter : TSynCustomHighlighter);
    procedure fcAddTab;
  end;

implementation

uses
  up_var;

constructor tucMain.Create (AOwner : TWinControl; AImageList : TImageList; APopupMenu : TPopupMenu);
begin
  Self.vTabPrefix := 'Tab';
  Self.vTabNo := 0;
  Self.vPageControl := tucPageControl.Create(AOwner);
  Self.vPageControl.Parent := AOwner;
  Self.vPageControl.fcInit(AImageList,APopupMenu);
  Self.vStatusBar := tucStatusBar.Create(AOwner);
  Self.vStatusBar.Parent := AOwner;
end;

procedure tucMain.fcUpdate (ALang : TASETypeLang; AHighlighter : TSynCustomHighlighter);
begin
  Self.vPageControl.fcUpdate(ALang,AHighlighter);
  Self.vStatusBar.fcUpdate(ALang);
end;

procedure tucMain.fcAddTab;
begin
  Self.vTabNo := Self.vTabNo + 1;
  Self.vPageControl.fcAddTab(Self,Self.vTabPrefix + IntToStr(Self.vTabNo),vupVar.vImageIndexNormalFile);
end;

end.

