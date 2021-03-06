unit uc_pagecontrol;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, Controls, Menus, Spin, SynEditHighlighter, up_currentdata, uc_tabsheet,
  uc_statusbar, Dialogs, UITypes, ExtendedNotebook, SynEditTypes, up_var;

type
  tucPageControl = class(TExtendedNotebook)
  private
    FSpinEdit : TSpinEdit;
    FStatusBar : tucStatusBar;
    FSaveDialog : TSaveDialog;
  public
    property vSpinEdit : TSpinEdit read FSpinEdit write FSpinEdit;
    property vStatusBar : tucStatusBar read FStatusBar write FStatusBar;
    property vSaveDialog : TSaveDialog read FSaveDialog write FSaveDialog;
    constructor Create (AOwner : TComponent); override;
    procedure fcInit (AImageList : TImageList; APopupMenu : TPopupMenu;
      ASpinEdit : TSpinEdit; AStatusBar : tucStatusBar; ASaveDialog : TSaveDialog);
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

constructor tucPageControl.Create (AOwner : TComponent);
begin
  inherited Create(AOwner);
  Self.Align := alClient;
  Self.TabDragMode := dmAutomatic;
  Self.TabDragAcceptMode := dmAutomatic;
  Self.vStatusBar := tucStatusBar.Create(Self);
end;

procedure tucPageControl.fcInit (AImageList : TImageList; APopupMenu : TPopupMenu;
  ASpinEdit : TSpinEdit; AStatusBar : tucStatusBar; ASaveDialog : TSaveDialog);
begin
  Self.Images := AImageList;
  Self.ImagesWidth := 24;
  Self.PopupMenu := APopupMenu;
  Self.vSpinEdit := ASpinEdit;
  Self.vStatusBar := AStatusBar;
  Self.vSaveDialog := ASaveDialog;
end;

procedure tucPageControl.fcAddNewTab (APopupMenu : TPopupMenu);
begin
  vupVar.vTabNo := vupVar.vTabNo + 1;
  Self.fcNewTab(vupVar.vTabPrefix + IntToStr(vupVar.vTabNo),vupVar.vImageIndexNormalFile,APopupMenu);
end;

procedure tucPageControl.fcAddNewTabThenOpen (ACurrentData : tupCurrentData;
  APopupMenu : TPopupMenu);
begin
  Self.fcNewTab(ExtractFileName(ACurrentData.vFileName),vupVar.vImageIndexNormalFile,APopupMenu);
  Self.fcCurrentTabSheet.fcOpen(ACurrentData);
end;

procedure tucPageControl.fcNewTab (ACaption : string; AImageIndex : Byte; APopupMenu : TPopupMenu);
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

procedure tucPageControl.fcCloseCurrentTab (ACurrentData : tupCurrentData; ACaption : string;
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

procedure tucPageControl.fcUpdate;
var
  i : Integer;
begin
  for i := 0 to Self.PageCount - 1 do
    (Self.Pages[i] as tucTabSheet).fcUpdate
  ;
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

procedure tucPageControl.fcCopy;
begin
  Self.fcCurrentTabSheet.fcCopy;
end;

procedure tucPageControl.fcCut;
begin
  Self.fcCurrentTabSheet.fcCut;
end;

procedure tucPageControl.fcPaste;
begin
  Self.fcCurrentTabSheet.fcPaste;
end;

procedure tucPageControl.fcSelectAll;
begin
  Self.fcCurrentTabSheet.fcSelectAll;
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
  Self.fcUpdate(vupCurrentData);
end;

procedure tucPageControl.fcSave (AFileName : TFileName);
begin
  Self.fcCurrentTabSheet.fcSave(AFileName);
end;

procedure tucPageControl.fcShowCompletion;
begin
  Self.fcCurrentTabSheet.fcShowCompletion;
end;

procedure tucPageControl.fcReplace (AOldPattern,ANewPattern : string; ASynSearchOptions : TSynSearchOptions;
  AIsSpecialChar : Boolean; ASpecialChar : string);
begin
  Self.fcCurrentTabSheet.fcReplace(AOldPattern,ANewPattern,ASynSearchOptions,AIsSpecialChar,ASpecialChar);
end;

procedure tucPageControl.fcFindNext;
begin
  Self.fcCurrentTabSheet.fcFindNext;
end;

function tucPageControl.fcCurrentTabSheet : tucTabSheet;
begin
  Result := (Self.ActivePage as tucTabSheet);
end;

procedure tucPageControl.fcRunCommand;
begin
  Self.fcCurrentTabSheet.fcRunCommand;
end;

procedure tucPageControl.fcMacroStartRecording;
begin
  Self.fcCurrentTabSheet.fcMacroStartRecording;
end;

procedure tucPageControl.fcMacroStopRecording;
begin
  Self.fcCurrentTabSheet.fcMacroStopRecording;
end;

procedure tucPageControl.fcMacroPlayback;
begin
  Self.fcCurrentTabSheet.fcMacroPlayback;
end;

end.

