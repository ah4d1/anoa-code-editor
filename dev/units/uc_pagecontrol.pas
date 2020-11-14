unit uc_pagecontrol;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, Controls, Menus, Spin, SynEditHighlighter, up_currentdata, uc_tabsheet,
  uc_statusbar, Dialogs, UITypes, ExtendedNotebook, SynEditTypes, ShellCtrls, up_var;

type
  TUcPageControl = class(TExtendedNotebook)
  private
    FSpinEdit : TSpinEdit;
    FShellTreeView : TShellTreeView;
    FStatusBar : tucStatusBar;
    FSaveDialog : TSaveDialog;
  public
    property vSpinEdit : TSpinEdit read FSpinEdit write FSpinEdit;
    property vShellTreeView : TShellTreeView read FShellTreeView write FShellTreeView;
    property vStatusBar : tucStatusBar read FStatusBar write FStatusBar;
    property vSaveDialog : TSaveDialog read FSaveDialog write FSaveDialog;
    constructor Create (AOwner : TComponent); override;
    procedure fcInit (AImageList : TImageList; APopupMenu : TPopupMenu;
      AShellTreeView : TShellTreeView; ASpinEdit : TSpinEdit; AStatusBar : tucStatusBar;
      ASaveDialog : TSaveDialog);
    procedure fcAddNewTab (APopupMenu : TPopupMenu);
    procedure fcAddNewTabThenOpen (ACurrentData : tupCurrentData;
      APopupMenu : TPopupMenu);
    procedure fcNewTab (ACaption : string; AImageIndex : Byte;
      APopupMenu : TPopupMenu);
    procedure fcCloseCurrentTab (ACurrentData : tupCurrentData; ACaption : string;
      AImageIndex : Byte; APopupMenu : TPopupMenu);
    procedure fcUpdate; overload;
    procedure fcUpdate (ACurrentData : tupCurrentData); overload;
    procedure fcUndo;
    procedure fcRedo;
    procedure fcCopy;
    procedure fcCut;
    procedure fcPaste;
    procedure fcSelectAll;
    procedure fcSetCurrentData;
    procedure fcSave (AFileName : TFileName);
    procedure Change; override;
    procedure fcShowCompletion;
    procedure fcReplace (AOldPattern,ANewPattern : string; ASynSearchOptions : TSynSearchOptions;
      AIsSpecialChar : Boolean; ASpecialChar : string);
    procedure fcFindNext;
    procedure fcRunCommand;
    function fcCurrentTabSheet : tucTabSheet;
    procedure fcMacroStartRecording;
    procedure fcMacroStopRecording;
    procedure fcMacroPlayback;
  end;

implementation

constructor TUcPageControl.Create (AOwner : TComponent);
begin
  inherited Create(AOwner);
  Self.Align := alClient;
  Self.TabDragMode := dmAutomatic;
  Self.TabDragAcceptMode := dmAutomatic;
  Self.vStatusBar := tucStatusBar.Create(Self);
end;

procedure TUcPageControl.fcInit (AImageList : TImageList; APopupMenu : TPopupMenu;
  AShellTreeView : TShellTreeView; ASpinEdit : TSpinEdit; AStatusBar : tucStatusBar;
  ASaveDialog : TSaveDialog);
begin
  Self.Images := AImageList;
  Self.ImagesWidth := 24;
  Self.PopupMenu := APopupMenu;
  Self.vShellTreeView := AShellTreeView;
  Self.vSpinEdit := ASpinEdit;
  Self.vStatusBar := AStatusBar;
  Self.vSaveDialog := ASaveDialog;
end;

procedure TUcPageControl.fcAddNewTab (APopupMenu : TPopupMenu);
begin
  vupVar.vTabNo := vupVar.vTabNo + 1;
  Self.fcNewTab(vupVar.vTabPrefix + IntToStr(vupVar.vTabNo),vupVar.vImageIndexNormalFile,APopupMenu);
end;

procedure TUcPageControl.fcAddNewTabThenOpen (ACurrentData : tupCurrentData;
  APopupMenu : TPopupMenu);
begin
  Self.fcNewTab(ExtractFileName(ACurrentData.vFileName),vupVar.vImageIndexNormalFile,APopupMenu);
  Self.fcCurrentTabSheet.fcOpen(ACurrentData);
end;

procedure TUcPageControl.fcNewTab (ACaption : string; AImageIndex : Byte; APopupMenu : TPopupMenu);
begin
  with tucTabSheet.Create(Self) do
  begin
    Parent := Self;
    Caption := ACaption;
    ImageIndex := AImageIndex;
  end;
  Self.TabIndex := Self.PageCount - 1;
  Self.fcCurrentTabSheet.fcInit(APopupMenu);
end;

procedure TUcPageControl.fcCloseCurrentTab (ACurrentData : tupCurrentData; ACaption : string;
  AImageIndex : Byte; APopupMenu : TPopupMenu);
var
  LConfirmation : TModalResult;
begin
  if Self.fcCurrentTabSheet.vTextStatus = aseTextStatusNormal then
    Self.fcCurrentTabSheet.Free
  else
  begin
    LConfirmation := MessageDlg('Confirmation','Do you want to save before close?',
      mtConfirmation,[mbYes,mbNo,mbCancel],0
    );
    case LConfirmation of
      mrYes :
        begin
          if FileExists(ACurrentData.vFileName) then
          begin
            Self.fcSave(ACurrentData.vFileName);
            Self.fcCurrentTabSheet.Free;
          end
          else
          begin
            if Self.vSaveDialog.Execute then
            begin
              Self.fcSave(Self.vSaveDialog.FileName);
              Self.fcCurrentTabSheet.Free;
            end;
          end;
        end;
      mrNo : Self.fcCurrentTabSheet.Free;
      mrCancel : ;
    end;
  end;
  if Self.PageCount <= 0 then Self.fcAddNewTab(APopupMenu);
end;

procedure TUcPageControl.fcUpdate;
var
  i : Integer;
begin
  for i := 0 to Self.PageCount - 1 do
    (Self.Pages[i] as tucTabSheet).fcUpdate
  ;
end;

procedure TUcPageControl.fcUpdate (ACurrentData : TUpCurrentData);
begin
  Self.fcCurrentTabSheet.fcUpdate(ACurrentData);
  Self.vShellTreeView.Root := ExtractFilePath(ACurrentData.vFileName);
end;

procedure TUcPageControl.fcUndo;
begin
  Self.fcCurrentTabSheet.fcUndo;
end;

procedure TUcPageControl.fcRedo;
begin
  Self.fcCurrentTabSheet.fcRedo;
end;

procedure TUcPageControl.fcCopy;
begin
  Self.fcCurrentTabSheet.fcCopy;
end;

procedure TUcPageControl.fcCut;
begin
  Self.fcCurrentTabSheet.fcCut;
end;

procedure TUcPageControl.fcPaste;
begin
  Self.fcCurrentTabSheet.fcPaste;
end;

procedure TUcPageControl.fcSelectAll;
begin
  Self.fcCurrentTabSheet.fcSelectAll;
end;

procedure TUcPageControl.fcSetCurrentData;
begin
  Self.fcCurrentTabSheet.fcSetCurrentData;
  Self.vStatusBar.fcUpdate(vupCurrentData);
end;

procedure TUcPageControl.Change;
begin
  inherited Change;
  Self.fcSetCurrentData;
  Self.fcUpdate(vupCurrentData);
end;

procedure TUcPageControl.fcSave (AFileName : TFileName);
begin
  Self.fcCurrentTabSheet.fcSave(AFileName);
end;

procedure TUcPageControl.fcShowCompletion;
begin
  Self.fcCurrentTabSheet.fcShowCompletion;
end;

procedure TUcPageControl.fcReplace (AOldPattern,ANewPattern : string; ASynSearchOptions : TSynSearchOptions;
  AIsSpecialChar : Boolean; ASpecialChar : string);
begin
  Self.fcCurrentTabSheet.fcReplace(AOldPattern,ANewPattern,ASynSearchOptions,AIsSpecialChar,ASpecialChar);
end;

procedure TUcPageControl.fcFindNext;
begin
  Self.fcCurrentTabSheet.fcFindNext;
end;

function TUcPageControl.fcCurrentTabSheet : tucTabSheet;
begin
  Result := (Self.ActivePage as tucTabSheet);
end;

procedure TUcPageControl.fcRunCommand;
begin
  Self.fcCurrentTabSheet.fcRunCommand;
end;

procedure TUcPageControl.fcMacroStartRecording;
begin
  Self.fcCurrentTabSheet.fcMacroStartRecording;
end;

procedure TUcPageControl.fcMacroStopRecording;
begin
  Self.fcCurrentTabSheet.fcMacroStopRecording;
end;

procedure TUcPageControl.fcMacroPlayback;
begin
  Self.fcCurrentTabSheet.fcMacroPlayback;
end;

end.

