unit UnitPasVar;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SynEditHighlighter, uc_pagecontrol, uc_synedit,
  UnitPasStatusBar, UnitPasSynHighlighter, UnitPasReserveWords;

type
  TUVar_CurrentData = class
    vASETypeLang : TASETypeLang;
    vLangTxt     : string;
    vSynHighlighter : TUSynHighlighter;
    vHighlighter : TSynCustomHighlighter;
    vFileName    : TFileName;
    constructor Create (AHighlighter : TUSynHighlighter);
    procedure Update (AASETypeLang : TASETypeLang); overload;
    procedure Update (AFileName : TFileName); overload;
    procedure Update (AASETypeLang : TASETypeLang; AFileName : TFileName); overload;
  end;
  TUVar = class
    vTabNo : Byte;
    vCurrentData : TUVar_CurrentData;
    vASETypeLang : TStringList;
    vPageControl : tucPageControl;
    vImageIndexNormalFile : Byte;
    vImageIndexModifiedFile : Byte;
    vSynEdit : tucSynEdit;
    vStatusBar : TUStatusBar;
    vSynHighlighter : TUSynHighlighter;
    vReservedWords : TUReserveWords;
    constructor Create (AOwner : TComponent);
  end;

var
  VUVar : TUVar;

implementation

uses
  UnitPasLang, UnitPasTools;

constructor TUVar_CurrentData.Create (AHighlighter : TUSynHighlighter);
begin
  Self.vASETypeLang := aseLangNone;
  Self.vLangTxt := '';
  Self.vSynHighlighter := AHighlighter;
  Self.vHighlighter := AHighlighter.vNone;
  Self.vFileName := '';
end;

procedure TUVar_CurrentData.Update (AASETypeLang : TASETypeLang);
begin
  Self.Update(AASETypeLang,Self.vFileName);
end;

procedure TUVar_CurrentData.Update (AFileName : TFileName);
begin
  Self.vASETypeLang := VULang.GetLang(ExtractFileExt(AFileName));
  Self.Update(Self.vASETypeLang,AFileName);
end;

procedure TUVar_CurrentData.Update (AASETypeLang : TASETypeLang; AFileName : TFileName);
begin
  Self.vASETypeLang := AASETypeLang;
  Self.vLangTxt := VULang.GetLangTxt(Self.vASETypeLang);
  Self.vHighlighter := Self.vSynHighlighter.fcGetHighlighter(Self.vASETypeLang);
  Self.vFileName := AFileName;
end;

constructor TUVar.Create (AOwner : TComponent);
begin
  Self.vTabNo := 0;
  Self.vImageIndexNormalFile := 3;
  Self.vImageIndexModifiedFile := 4;
  Self.vPageControl := tucPageControl.Create(AOwner);
  Self.vSynEdit := tucSynEdit.Create(AOwner);
  Self.vStatusBar := TUStatusBar.Create;
  Self.vSynHighlighter := TUSynHighlighter.Create(AOwner);
  Self.vReservedWords := TUReserveWords.Create(AOwner);
  Self.vASETypeLang := VUTools.FcStringExplode(Self.vReservedWords.vLangTxt,'|');
  Self.vCurrentData := TUVar_CurrentData.Create(Self.vSynHighlighter);
end;

end.

