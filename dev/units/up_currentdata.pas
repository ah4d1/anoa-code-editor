unit up_currentdata;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SynEditHighlighter, ac_synhighlighter, Dialogs;

type
  tupCurrentData = class
    vLang : TShLang;
    vLangTxt : string;
    vSynHighlighter : TAcSynHighlighter;
    vHighlighter : TSynCustomHighlighter;
    vFileName : TFileName;
    constructor Create (AHighlighter : TAcSynHighlighter);
    procedure fcUpdate (ALang : TShLang); overload;
    procedure fcUpdate (AFileName : TFileName); overload;
    procedure fcUpdate (ALang : TShLang; AFileName : TFileName); overload;
  end;

var
  vupCurrentData : tupCurrentData;

implementation

uses
  up_lang, up_var;

constructor tupCurrentData.Create (AHighlighter : TAcSynHighlighter);
begin
  Self.vLang := shLangNone;
  Self.vLangTxt := '';
  Self.vSynHighlighter := AHighlighter;
  Self.vHighlighter := AHighlighter.vNone;
  Self.vFileName := '';
end;

procedure tupCurrentData.fcUpdate (ALang : TShLang);
begin
  Self.fcUpdate(ALang,Self.vFileName);
end;

procedure tupCurrentData.fcUpdate (AFileName : TFileName);
begin
  Self.vLang := vupLang.fcGetLang(ExtractFileExt(AFileName));
  Self.fcUpdate(Self.vLang,AFileName);
end;

procedure tupCurrentData.fcUpdate (ALang : TShLang; AFileName : TFileName);
begin
  Self.vLang := ALang;
  Self.vLangTxt := vupLang.fcGetLangTxt(Self.vLang);
  vupVar.vSynHighlighter.vLang := Self.vLang;
  Self.vHighlighter := vupVar.vSynHighlighter.vHighlighter;
  // Self.vHighlighter := Self.vSynHighlighter.fcGetHighlighter(Self.vLang);
  Self.vFileName := AFileName;
end;

end.

