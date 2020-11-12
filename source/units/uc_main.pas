unit uc_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Controls, Menus, Spin, SynEditHighlighter, up_var, up_currentdata,
  uc_pagecontrol, uc_statusbar, Dialogs, SynEditTypes;

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
    procedure fcAddNewTab (APopupMenu : TPopupMenu);
    procedure fcAddNewTab (ACurrentData : tupCurrentData; APopupMenu : TPopupMenu); overload;
    procedure fcCloseCurrentTab (ACurrentData : tupCurrentData; APopupMenu : TPopupMenu);
    procedure fcCloseAllTabs (ACurrentData : tupCurrentData; APopupMenu : TPopupMenu);
    procedure fcCloseAllOtherTabs (ACurrentData : tupCurrentData; APopupMenu : TPopupMenu);
    procedure fcUpdate; overload;
    procedure fcUpdate (ACurrentData : tupCurrentData); overload;
    procedure fcUndo;
    procedure fcRedo;
    procedure fcCopy;
    procedure fcCut;
    procedure fcPaste;
    procedure fcSelectAll;
    procedure fcSave (AFileName : TFileName);
    procedure fcShowCompletion;
    procedure fcReplace (AOldPattern,ANewPattern : string; ASynSearchOptions : TSynSearchOptions;
      AIsSpecialChar : Boolean; ASpecialChar : string);
    procedure fcFindNext;
    procedure fcRunCommand;
    procedure fcMacroStartRecording;
    procedure fcMacroStopRecording;
    procedure fcMacroPlayback;
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

procedure tucMain.fcAddNewTab (APopupMenu : TPopupMenu);
begin
  Self.vPageControl.fcAddNewTab(APopupMenu);
end;

procedure tucMain.fcAddNewTab (ACurrentData : tupCurrentData; APopupMenu : TPopupMenu);
begin
  vupVar.vTabNo := vupVar.vTabNo + 1;
  Self.vPageControl.fcAddNewTabThenOpen(ACurrentData,APopupMenu);
  Self.vStatusBar.fcUpdate(ACurrentData);
end;

procedure tucMain.fcCloseCurrentTab (ACurrentData : tupCurrentData; APopupMenu : TPopupMenu);
begin
  Self.vPageControl.fcCloseCurrentTab(ACurrentData,vupVar.vTabPrefix + IntToStr(vupVar.vTabNo),
    vupVar.vImageIndexNormalFile,APopupMenu
  );
  Self.vPageControl.Change;
end;

procedure tucMain.fcCloseAllTabs (ACurrentData : tupCurrentData; APopupMenu : TPopupMenu);
var
  i : Byte;
begin
  for i := 1 to Self.vPageControl.PageCount do
  begin
    Self.vPageControl.fcCloseCurrentTab(ACurrentData,vupVar.vTabPrefix + IntToStr(vupVar.vTabNo),
      vupVar.vImageIndexNormalFile, APopupMenu
    );
    Self.vPageControl.Change;
  end;
end;

procedure tucMain.fcCloseAllOtherTabs (ACurrentData : tupCurrentData; APopupMenu : TPopupMenu);
var
  i : Byte;
begin
  Self.vPageControl.fcCurrentTabSheet.PageIndex := Self.vPageControl.PageCount-1;
  for i := 1 to Self.vPageControl.PageCount-1 do
  begin
    Self.vPageControl.PageIndex := 0;
    Self.vPageControl.fcCloseCurrentTab(ACurrentData,vupVar.vTabPrefix + IntToStr(vupVar.vTabNo),
      vupVar.vImageIndexNormalFile, APopupMenu
    );
    Self.vPageControl.Change;
  end;
end;

procedure tucMain.fcUpdate;
begin
  Self.vPageControl.fcUpdate;
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

procedure tucMain.fcReplace (AOldPattern,ANewPattern : string; ASynSearchOptions : TSynSearchOptions;
  AIsSpecialChar : Boolean; ASpecialChar : string);
begin
  Self.vPageControl.fcReplace(AOldPattern,ANewPattern,ASynSearchOptions,AIsSpecialChar,ASpecialChar);
end;

procedure tucMain.fcFindNext;
begin
  Self.vPageControl.fcFindNext;
end;

procedure tucMain.fcRunCommand;
begin
  Self.vPageControl.fcRunCommand;
end;

procedure tucMain.fcMacroStartRecording;
begin
  Self.vPageControl.fcMacroStartRecording;
end;

procedure tucMain.fcMacroStopRecording;
begin
  Self.vPageControl.fcMacroStopRecording;
end;

procedure tucMain.fcMacroPlayback;
begin
  Self.vPageControl.fcMacroPlayback;
end;

end.

