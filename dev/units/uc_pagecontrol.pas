unit uc_pagecontrol;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, Controls, Menus, Spin, SynEditHighlighter, up_currentdata, uc_tabsheet,
  uc_statusbar, Dialogs, UITypes;

type
  tucPageControl = class(TPageControl)
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
    procedure fcAddNewTab (ACaption : string; AImageIndex : Byte);
    procedure fcAddNewTabThenOpen (ACurrentData : tupCurrentData; AImageIndex : Byte);
    procedure fcCloseCurrentTab (ACurrentData : tupCurrentData; ACaption : string; AImageIndex : Byte);
    procedure fcUpdate (ACurrentData : tupCurrentData);
    procedure fcUpdateFontSize;
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
    procedure fcCursorToBegin;
    procedure fcReplaceForward (AOldPattern,ANewPattern : string);
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

procedure tucPageControl.fcAddNewTab (ACaption : string; AImageIndex : Byte);
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

procedure tucPageControl.fcAddNewTabThenOpen (ACurrentData : tupCurrentData; AImageIndex : Byte);
begin
  Self.fcAddNewTab(ExtractFileName(ACurrentData.vFileName),AImageIndex);
  Self.fcCurrentTabSheet.fcOpen(ACurrentData);
end;

procedure tucPageControl.fcCloseCurrentTab (ACurrentData : tupCurrentData; ACaption : string; AImageIndex : Byte);
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
  if Self.PageCount <= 0 then Self.fcAddNewTab(ACaption,AImageIndex);
end;

procedure tucPageControl.fcUpdate (ACurrentData : tupCurrentData);
begin
  Self.fcCurrentTabSheet.fcUpdate(ACurrentData);
end;

procedure tucPageControl.fcUpdateFontSize;
begin
  Self.fcCurrentTabSheet.vSynEdit.Font.Size := Self.vSpinEdit.Value;
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
  Self.fcUpdateFontSize;
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

procedure tucPageControl.fcCursorToBegin;
begin
  Self.fcCurrentTabSheet.fcCursorToBegin;
end;

procedure tucPageControl.fcReplaceForward (AOldPattern,ANewPattern : string);
begin
  Self.fcCurrentTabSheet.fcReplaceForward(AOldPattern,ANewPattern);
end;

function tucPageControl.fcCurrentTabSheet : tucTabSheet;
begin
  Result := (Self.ActivePage as tucTabSheet);
end;

end.

