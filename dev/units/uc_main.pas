unit uc_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Controls, Menus, Spin, SynEditHighlighter, up_var, up_currentdata,
  uc_pagecontrol, uc_statusbar, Dialogs;

type
  tucMain = class(TComponent)
  private
    FSpinEdit : TSpinEdit;
    FPageControl : tucPageControl;
    FStatusBar : tucStatusBar;
    FSaveDialog : TSaveDialog;
  public
    property vSpinEdit : TSpinEdit read FSpinEdit write FSpinEdit;
    property vPageControl : tucPageControl read FPageControl write FPageControl;
    property vStatusBar : tucStatusBar read FStatusBar write FStatusBar;
    property vSaveDialog : TSaveDialog read FSaveDialog write FSaveDialog;
    constructor Create (AOwner : TWinControl; AImageList : TImageList; APopupMenu : TPopupMenu;
      ASpinEdit : TSpinEdit; ASaveDialog : TSaveDialog); overload;
    procedure fcAddTab; overload;
    procedure fcAddTab (ACurrentData : tupCurrentData); overload;
    procedure fcCloseTab (ACurrentData : tupCurrentData);
    procedure fcUpdate (ACurrentData : tupCurrentData);
    procedure fcUpdateFontSize;
    procedure fcUndo;
    procedure fcRedo;
    procedure fcCopy;
    procedure fcCut;
    procedure fcPaste;
    procedure fcSelectAll;
    procedure fcSave (AFileName : TFileName);
    procedure fcShowCompletion;
    procedure fcSwitchEditorColor;
  end;

var
  vucMain : tucMain;

implementation

constructor tucMain.Create (AOwner : TWinControl; AImageList : TImageList; APopupMenu : TPopupMenu;
  ASpinEdit : TSpinEdit; ASaveDialog : TSaveDialog); overload;
begin
  Self.vSpinEdit := ASpinEdit;
  Self.vSaveDialog := ASaveDialog;
  Self.vStatusBar := tucStatusBar.Create(AOwner);
  Self.vStatusBar.Parent := AOwner;
  Self.vPageControl := tucPageControl.Create(AOwner);
  Self.vPageControl.Parent := AOwner;
  Self.vPageControl.fcInit(AImageList,APopupMenu,Self.vSpinEdit,Self.vStatusBar,Self.vSaveDialog);
end;

procedure tucMain.fcAddTab;
begin
  vupVar.vTabNo := vupVar.vTabNo + 1;
  Self.vPageControl.fcAddTab(vupVar.vTabPrefix + IntToStr(vupVar.vTabNo),vupVar.vImageIndexNormalFile);
end;

procedure tucMain.fcAddTab (ACurrentData : tupCurrentData);
begin
  vupVar.vTabNo := vupVar.vTabNo + 1;
  Self.vPageControl.fcAddTabThenOpen(ACurrentData,vupVar.vImageIndexNormalFile);
  Self.vStatusBar.fcUpdate(ACurrentData);
end;

procedure tucMain.fcCloseTab (ACurrentData : tupCurrentData);
begin
  Self.vPageControl.fcCloseTab(ACurrentData,Self.vSaveDialog,
    vupVar.vTabPrefix + IntToStr(vupVar.vTabNo),vupVar.vImageIndexNormalFile
  );
end;

procedure tucMain.fcUpdate (ACurrentData : tupCurrentData);
begin
  Self.vPageControl.fcUpdate(ACurrentData);
  Self.vStatusBar.fcUpdate(ACurrentData);
end;

procedure tucMain.fcUpdateFontSize;
begin
  Self.vPageControl.fcUpdateFontSize;
end;

procedure tucMain.fcUndo;
begin
  Self.vPageControl.fcUndo;
end;

procedure tucMain.fcRedo;
begin
  Self.vPageControl.fcRedo;
end;

procedure tucMain.fcCopy;
begin
  Self.vPageControl.fcCopy;
end;

procedure tucMain.fcCut;
begin
  Self.vPageControl.fcCut;
end;

procedure tucMain.fcPaste;
begin
  Self.vPageControl.fcPaste;
end;

procedure tucMain.fcSelectAll;
begin
  Self.vPageControl.fcSelectAll;
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

