unit uc_tabsheet;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, SynEditHighlighter, uc_synedit, uc_syncompletion, UnitPasSynHighlighter;

type
  tucTabSheet = class(TTabSheet)
  private
    FSynEdit : tucSynEdit;
    FSynCompletion : tucSynCompletion;
  public
    property vSynEdit : tucSynEdit read FSynEdit write FSynEdit;
    property vSynCompletion : tucSynCompletion read FSynCompletion write FSynCompletion;
    constructor Create (AOwner : TComponent); override;
    procedure fcInit (AImageIndex : Byte; ACaption : string);
    procedure fcOpen (AFileName : TFileName);
    procedure fcSave (AFileName : TFileName);
    procedure fcUpdate (AASETypeLang : TASETypeLang; AHighlighter : TSynCustomHighlighter);
  end;

implementation

uses
  UnitPasVar;

constructor tucTabSheet.Create (AOwner : TComponent);
begin
  inherited Create(AOwner);
  Self.vSynEdit := tucSynEdit.Create(AOwner);
  Self.vSynEdit.Parent := Self;
  Self.vSynCompletion := tucSynCompletion.Create(AOwner);
  Self.vSynCompletion.Editor := Self.vSynEdit;
end;

procedure tucTabSheet.fcInit (AImageIndex : Byte; ACaption : string);
begin
  Self.ImageIndex := AImageIndex;
  Self.Caption := ACaption;
end;

procedure tucTabSheet.fcSave (AFileName : TFileName);
begin
  Self.Caption    := 'New' + IntToStr(VUVar.vTabNo + 1);
  Self.ImageIndex := VUVar.vImageIndexNormalFile;
  Self.vSynEdit.fcSave(AFileName);
end;

procedure tucTabSheet.fcOpen (AFileName : TFileName);
begin
  Self.vSynEdit.fcOpen(AFileName);
end;

procedure tucTabSheet.fcUpdate (AASETypeLang : TASETypeLang; AHighlighter : TSynCustomHighlighter);
begin
  Self.vSynEdit.fcUpdate(AHighlighter);
  Self.vSynCompletion.fcUpdate(AASETypeLang);
end;

end.

