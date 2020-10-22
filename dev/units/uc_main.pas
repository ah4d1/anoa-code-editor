unit uc_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Controls, Menus, SynEditHighlighter, up_var, up_currentdata,
  uc_pagecontrol, uc_statusbar, Dialogs;

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
    procedure fcUpdate (ACurrentData : tupCurrentData);
    procedure fcUndo;
    procedure fcRedo;
    procedure fcSetFontSize (ASize : Byte);
    procedure fcSave (AFileName : TFileName);
    procedure fcShowCompletion;
    procedure fcSwitchEditorColor;
  end;

var
  vucMain : tucMain;

implementation

constructor tucMain.Create (AOwner : TWinControl; AImageList : TImageList; APopupMenu : TPopupMenu); overload;
begin
  Self.vStatusBar := tucStatusBar.Create(AOwner);
  Self.vStatusBar.Parent := AOwner;
  Self.vPageControl := tucPageControl.Create(AOwner);
  Self.vPageControl.Parent := AOwner;
  Self.vPageControl.fcInit(AImageList,APopupMenu,Self.vStatusBar);
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

procedure tucMain.fcUpdate (ACurrentData : tupCurrentData);
begin
  Self.vPageControl.fcUpdate(ACurrentData);
  Self.vStatusBar.fcUpdate(ACurrentData);
end;

procedure tucMain.fcUndo;
begin
  Self.vPageControl.fcUndo;
end;

procedure tucMain.fcRedo;
begin
  Self.vPageControl.fcRedo;
end;

procedure tucMain.fcSetFontSize (ASize : Byte);
begin
  Self.vPageControl.fcSetFontSize(ASize);
end;

procedure tucMain.fcSave (AFileName : TFileName);
begin
  Self.vPageControl.fcSave(AFileName);
end;

procedure tucMain.fcShowCompletion;
begin
  Self.vPageControl.fcShowCompletion;
end;

procedure tucMain.fcSwitchEditorColor;
begin
  Self.vPageControl.fcSwitchEditorColor;
end;

end.

