unit up_currentdata;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SynEditHighlighter, up_synhighlighter;

type
  tupCurrentData = class
    vLang : taseLang;
    vLangTxt : string;
    vSynHighlighter : tupSynHighlighter;
    vHighlighter : TSynCustomHighlighter;
    vFileName : TFileName;
    constructor Create (AHighlighter : tupSynHighlighter);
    procedure fcUpdate (ALang : taseLang); overload;
    procedure fcUpdate (AFileName : TFileName); overload;
    procedure fcUpdate (ALang : taseLang; AFileName : TFileName); overload;
  end;

var
  vupCurrentData : tupCurrentData;

implementation

uses
  up_lang;

constructor tupCurrentData.Create (AHighlighter : tupSynHighlighter);
begin
  Self.vLang := aseLangNone;
  Self.vLangTxt := '';
  Self.vSynHighlighter := AHighlighter;
  Self.vHighlighter := AHighlighter.vNone;
  Self.vFileName := '';
end;

procedure tupCurrentData.fcUpdate (ALang : taseLang);
begin
  Self.fcUpdate(ALang,Self.vFileName);
end;

procedure tupCurrentData.fcUpdate (AFileName : TFileName);
begin
  Self.vLang := vupLang.fcGetLang(ExtractFileExt(AFileName));
  Self.fcUpdate(Self.vLang,AFileName);
end;

procedure tupCurrentData.fcUpdate (ALang : taseLang; AFileName : TFileName);
begin
  Self.vLang := ALang;
  Self.vLangTxt := vupLang.fcGetLangTxt(Self.vLang);
  Self.vHighlighter := Self.vSynHighlighter.fcGetHighlighter(Self.vLang);
  Self.vFileName := AFileName;
end;

end.

