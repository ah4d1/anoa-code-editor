unit UnitCmpTabSheet;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, UnitCmpSynEdit, UnitCmpSynCompletion;

type
  TUTabSheet = class(TTabSheet)
  private
    FSynEdit : TUSynEdit;
    FSynCompletion : TUSynCompletion;
  public
    property vSynEdit : TUSynEdit read FSynEdit write FSynEdit;
    property vSynCompletion : TUSynCompletion read FSynCompletion write FSynCompletion;
    constructor Create (AOwner : TComponent); override;
  end;

implementation

constructor TUTabSheet.Create (AOwner : TComponent);
begin
  inherited Create(AOwner);
  Self.vSynEdit := TUSynEdit.Create(AOwner);
  Self.vSynEdit.Parent := Self;
  Self.vSynCompletion := TUSynCompletion.Create(AOwner);
  Self.vSynCompletion.Editor := Self.vSynEdit;
end;

end.

