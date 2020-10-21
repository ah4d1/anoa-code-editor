unit uc_pagecontrol;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, Controls, SynEditHighlighter, uc_tabsheet, UnitPasSynHighlighter;

type
  tucPageControl = class(TPageControl)
  private
    FTabSheet : tucTabSheet;
  public
    property vTabSheet : tucTabSheet read FTabSheet write FTabSheet;
    constructor Create (AOwner : TComponent); override;
    procedure fcInit (AImageList : TImageList; AImageIndex : Byte; ACaption : string);
    procedure fcUpdate (ALang : TASETypeLang; AHighlighter : TSynCustomHighlighter);
  end;

implementation

constructor tucPageControl.Create (AOwner : TComponent);
begin
  inherited Create(AOwner);
  Self.Align := alClient;

  Self.vTabSheet := tucTabSheet.Create(AOwner);
  Self.vTabSheet.Parent := Self;

  // Self.Images      := Self.ImageListMain;
  // Self.ImagesWidth := 24;
  // Self.PopupMenu   := Self.PopupMenuPageControl;
end;

procedure tucPageControl.fcInit (AImageList : TImageList; AImageIndex : Byte; ACaption : string);
begin
  Self.Images := AImageList;
  Self.ImagesWidth := 24;
  Self.vTabSheet.fcInit(AImageIndex,ACaption);
end;

procedure tucPageControl.fcUpdate (ALang : TASETypeLang; AHighlighter : TSynCustomHighlighter);
begin
  Self.vTabSheet.fcUpdate(ALang,AHighlighter);
end;

{
procedure tucPageControl.fcUpdate (APageControl : TPageControl; AImageIndex : Byte; AFileName : TFileName);
begin
  APageControl.ActivePage.ImageIndex := AImageIndex;
  APageControl.ActivePage.Caption := ExtractFileName(AFileName);
end;
}

end.

