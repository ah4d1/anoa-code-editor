unit up_var;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SynEditHighlighter, uc_pagecontrol, uc_synedit, uc_statusbar,
  up_synhighlighter, up_reservewords;

type
  tupVar_CurrentData = class
    vASETypeLang : TASETypeLang;
    vLangTxt     : string;
    vSynHighlighter : tupSynHighlighter;
    vHighlighter : TSynCustomHighlighter;
    vFileName    : TFileName;
    constructor Create (AHighlighter : tupSynHighlighter);
    procedure Update (AASETypeLang : TASETypeLang); overload;
    procedure Update (AFileName : TFileName); overload;
    procedure Update (AASETypeLang : TASETypeLang; AFileName : TFileName); overload;
  end;
  tupVar = class
    vTabPrefix : string;
    vTabNo : Byte;
    vCurrentData : tupVar_CurrentData;
    vASETypeLang : TStringList;
    vPageControl : tucPageControl;
    vImageIndexNormalFile : Byte;
    vImageIndexModifiedFile : Byte;
    vSynHighlighter : tupSynHighlighter;
    vReservedWords : tupReserveWords;
    constructor Create (AOwner : TComponent);
  end;

var
  vupVar : tupVar;

implementation

uses
  up_lang, up_tools;

constructor tupVar_CurrentData.Create (AHighlighter : tupSynHighlighter);
begin
  Self.vASETypeLang := aseLangNone;
  Self.vLangTxt := '';
  Self.vSynHighlighter := AHighlighter;
  Self.vHighlighter := AHighlighter.vNone;
  Self.vFileName := '';
end;

procedure tupVar_CurrentData.Update (AASETypeLang : TASETypeLang);
begin
  Self.Update(AASETypeLang,Self.vFileName);
end;

procedure tupVar_CurrentData.Update (AFileName : TFileName);
begin
  Self.vASETypeLang := vupLang.fcGetLang(ExtractFileExt(AFileName));
  Self.Update(Self.vASETypeLang,AFileName);
end;

procedure tupVar_CurrentData.Update (AASETypeLang : TASETypeLang; AFileName : TFileName);
begin
  Self.vASETypeLang := AASETypeLang;
  Self.vLangTxt := vupLang.fcGetLangTxt(Self.vASETypeLang);
  Self.vHighlighter := Self.vSynHighlighter.fcGetHighlighter(Self.vASETypeLang);
  Self.vFileName := AFileName;
end;

constructor tupVar.Create (AOwner : TComponent);
begin
  Self.vTabPrefix := 'Tab';
  Self.vTabNo := 0;
  Self.vImageIndexNormalFile := 3;
  Self.vImageIndexModifiedFile := 4;
  Self.vPageControl := tucPageControl.Create(AOwner);
  Self.vSynHighlighter := tupSynHighlighter.Create(AOwner);
  Self.vReservedWords := tupReserveWords.Create(AOwner);
  Self.vASETypeLang := vupTools.FcStringExplode(Self.vReservedWords.vLangTxt,'|');
  Self.vCurrentData := tupVar_CurrentData.Create(Self.vSynHighlighter);
end;

end.

