unit uc_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Controls, Menus, Spin, SynEditHighlighter, up_var, up_currentdata,
  uc_pagecontrol, uc_statusbar, Dialogs, SynEditTypes, ShellCtrls;

type
  TUcMain = class(TComponent)
  private
    FShellTreeView : TShellTreeView;
    FPageControl : tucPageControl;
    FStatusBar : tucStatusBar;
    FSaveDialog : TSaveDialog;
  public
    property vShellTreeView : TShellTreeView read FShellTreeView write FShellTreeView;
    property vPageControl : tucPageControl read FPageControl write FPageControl;
    property vStatusBar : tucStatusBar read FStatusBar write FStatusBar;
    property vSaveDialog : TSaveDialog read FSaveDialog write FSaveDialog;
    constructor Create (AOwner : TWinControl; AImageList : TImageList; APopupMenu : TPopupMenu;
      AShellTreeView : TShellTreeView; ASpinEdit : TSpinEdit; ASaveDialog : TSaveDialog); overload;
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

constructor TUcMain.Create (AOwner : TWinControl; AImageList : TImageList; APopupMenu : TPopupMenu;
  AShellTreeView : TShellTreeView; ASpinEdit : TSpinEdit; ASaveDialog : TSaveDialog); overload;
begin
  Self.vSaveDialog := ASaveDialog;
  Self.vStatusBar := tucStatusBar.Create(AOwner);
  Self.vStatusBar.Parent := AOwner;
  Self.vPageControl := tucPageControl.Create(AOwner);
  Self.vPageControl.Parent := AOwner;
  Self.vPageControl.fcInit(AImageList,APopupMenu,AShellTreeView,ASpinEdit,
    Self.vStatusBar,Self.vSaveDialog
  );
end;

procedure TUcMain.fcAddNewTab (APopupMenu : TPopupMenu);
begin
  Self.vPageControl.fcAddNewTab(APopupMenu);
end;

procedure TUcMain.fcAddNewTab (ACurrentData : tupCurrentData; APopupMenu : TPopupMenu);
begin
  vupVar.vTabNo := vupVar.vTabNo + 1;
  Self.vPageControl.fcAddNewTabThenOpen(ACurrentData,APopupMenu);
  Self.vStatusBar.fcUpdate(ACurrentData);
end;

procedure TUcMain.fcCloseCurrentTab (ACurrentData : tupCurrentData; APopupMenu : TPopupMenu);
begin
  Self.vPageControl.fcCloseCurrentTab(ACurrentData,vupVar.vTabPrefix + IntToStr(vupVar.vTabNo),
    vupVar.vImageIndexNormalFile,APopupMenu
  );
  Self.vPageControl.Change;
end;

procedure TUcMain.fcCloseAllTabs (ACurrentData : tupCurrentData; APopupMenu : TPopupMenu);
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

procedure TUcMain.fcCloseAllOtherTabs (ACurrentData : tupCurrentData; APopupMenu : TPopupMenu);
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

procedure TUcMain.fcUpdate;
begin
  Self.vPageControl.fcUpdate;
end;

procedure TUcMain.fcUpdate (ACurrentData : tupCurrentData);
begin
  Self.vPageControl.fcUpdate(ACurrentData);
  Self.vStatusBar.fcUpdate(ACurrentData);
end;

procedure TUcMain.fcUndo;
begin
  Self.vPageControl.fcUndo;
end;

procedure TUcMain.fcRedo;
begin
  Self.vPageControl.fcRedo;
end;

procedure TUcMain.fcCopy;
begin
  Self.vPageControl.fcCopy;
end;

procedure TUcMain.fcCut;
begin
  Self.vPageControl.fcCut;
end;

procedure TUcMain.fcPaste;
begin
  Self.vPageControl.fcPaste;
end;

procedure TUcMain.fcSelectAll;
begin
  Self.vPageControl.fcSelectAll;
end;

procedure TUcMain.fcSave (AFileName : TFileName);
begin
  Self.vPageControl.fcSave(AFileName);
end;

procedure TUcMain.fcShowCompletion;
begin
  Self.vPageControl.fcShowCompletion;
end;

procedure TUcMain.fcReplace (AOldPattern,ANewPattern : string; ASynSearchOptions : TSynSearchOptions;
  AIsSpecialChar : Boolean; ASpecialChar : string);
begin
  Self.vPageControl.fcReplace(AOldPattern,ANewPattern,ASynSearchOptions,AIsSpecialChar,ASpecialChar);
end;

procedure TUcMain.fcFindNext;
begin
  Self.vPageControl.fcFindNext;
end;

procedure TUcMain.fcRunCommand;
begin
  Self.vPageControl.fcRunCommand;
end;

procedure TUcMain.fcMacroStartRecording;
begin
  Self.vPageControl.fcMacroStartRecording;
end;

procedure TUcMain.fcMacroStopRecording;
begin
  Self.vPageControl.fcMacroStopRecording;
end;

procedure TUcMain.fcMacroPlayback;
begin
  Self.vPageControl.fcMacroPlayback;
end;

end.

