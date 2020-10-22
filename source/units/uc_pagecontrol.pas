unit uc_pagecontrol;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, Controls, Menus, SynEditHighlighter, up_currentdata, uc_tabsheet,
  uc_statusbar, Dialogs;

type
  tucPageControl = class(TPageControl)
  private
    FStatusBar : tucStatusBar;
  public
    property vStatusBar : tucStatusBar read FStatusBar write FStatusBar;
    constructor Create (AOwner : TComponent); override;
    procedure fcInit (AImageList : TImageList; APopupMenu : TPopupMenu; AStatusBar : tucStatusBar);
    procedure fcAddTab (ACaption : string; AImageIndex : Byte);
    procedure fcAddTabThenOpen (AFileName : TFileName; AImageIndex : Byte);
    procedure fcUpdate (ACurrentData : tupCurrentData);
    procedure fcUndo;
    procedure fcRedo;
    procedure fcSetFontSize (ASize : Byte);
    procedure fcSetCurrentData;
    procedure fcSave (AFileName : TFileName);
    procedure Change; override;
    procedure fcShowCompletion;
    procedure fcSwitchEditorColor;
  private
    function fcCurrentTabSheet : tucTabSheet;
  end;

implementation

constructor tucPageControl.Create (AOwner : TComponent);
begin
  inherited Create(AOwner);
  Self.Align := alClient;
  Self.vStatusBar := tucStatusBar.Create(Self);
end;

procedure tucPageControl.fcInit (AImageList : TImageList; APopupMenu : TPopupMenu; AStatusBar : tucStatusBar);
begin
  Self.Images := AImageList;
  Self.ImagesWidth := 24;
  Self.PopupMenu := APopupMenu;
  Self.vStatusBar := AStatusBar;
end;

procedure tucPageControl.fcAddTab (ACaption : string; AImageIndex : Byte);
begin
  with tucTabSheet.Create(Self) do
  begin
    Parent := Self;
    Caption := ACaption;
    ImageIndex := AImageIndex;
  end;
  Self.TabIndex := Self.PageCount - 1;
  Self.fcCurrentTabSheet.fcInit;
end;

procedure tucPageControl.fcAddTabThenOpen (AFileName : TFileName; AImageIndex : Byte);
begin
  Self.fcAddTab(ExtractFileName(AFileName),AImageIndex);
  Self.fcCurrentTabSheet.fcOpen(AFileName);
end;

procedure tucPageControl.fcUpdate (ACurrentData : tupCurrentData);
begin
  Self.fcCurrentTabSheet.fcUpdate(ACurrentData);
end;

procedure tucPageControl.fcUndo;
begin
  Self.fcCurrentTabSheet.fcUndo;
end;

procedure tucPageControl.fcRedo;
begin
  Self.fcCurrentTabSheet.fcRedo;
end;

procedure tucPageControl.fcSetFontSize (ASize : Byte);
begin
  Self.fcCurrentTabSheet.fcSetFontSize(ASize);
end;

procedure tucPageControl.fcSetCurrentData;
begin
  Self.fcCurrentTabSheet.fcSetCurrentData;
  Self.vStatusBar.fcUpdate(vupCurrentData);
end;

procedure tucPageControl.Change;
begin
  inherited Change;
  Self.fcSetCurrentData;
end;

procedure tucPageControl.fcSave (AFileName : TFileName);
begin
  Self.fcCurrentTabSheet.fcSave(AFileName);
end;

procedure tucPageControl.fcShowCompletion;
begin
  Self.fcCurrentTabSheet.fcShowCompletion;
end;

procedure tucPageControl.fcSwitchEditorColor;
begin
  Self.fcCurrentTabSheet.fcSwitchEditorColor;
end;

function tucPageControl.fcCurrentTabSheet : tucTabSheet;
begin
  Result := (Self.ActivePage as tucTabSheet);
end;

end.

