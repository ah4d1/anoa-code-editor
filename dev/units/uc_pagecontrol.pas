unit uc_pagecontrol;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, Controls, Menus, SynEditHighlighter, uc_tabsheet, up_synhighlighter, Dialogs;

type
  tucPageControl = class(TPageControl)
  public
    constructor Create (AOwner : TComponent); override;
    procedure fcInit (AImageList : TImageList; APopupMenu : TPopupMenu);
    procedure fcAddTab (ACaption : string; AImageIndex : Byte);
    procedure fcAddTabThenOpen (AFileName : TFileName; AImageIndex : Byte);
    procedure fcUpdate (ALang : TASETypeLang; AHighlighter : TSynCustomHighlighter);
  end;

implementation

constructor tucPageControl.Create (AOwner : TComponent);
begin
  inherited Create(AOwner);
  Self.Align := alClient;
end;

procedure tucPageControl.fcInit (AImageList : TImageList; APopupMenu : TPopupMenu);
begin
  Self.Images := AImageList;
  Self.ImagesWidth := 24;
  Self.PopupMenu := APopupMenu;
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
end;

procedure tucPageControl.fcAddTabThenOpen (AFileName : TFileName; AImageIndex : Byte);
begin
  Self.fcAddTab(ExtractFileName(AFileName),AImageIndex);
  (Self.ActivePage as tucTabSheet).fcOpen(AFileName);
end;

procedure tucPageControl.fcUpdate (ALang : TASETypeLang; AHighlighter : TSynCustomHighlighter);
begin
  // Self.vTabSheet.fcUpdate(ALang,AHighlighter);
end;

end.

