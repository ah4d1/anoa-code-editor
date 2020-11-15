unit up_currentdata;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SynEditHighlighter, ace_synhighlighter, Dialogs;

type
  TUpCurrentData = class
    vLang : TAceShLang;
    vLangTxt : string;
    vSynHighlighter : TAceSynHighlighter;
    vHighlighter : TSynCustomHighlighter;
    vFileName : TFileName;
    constructor Create (AHighlighter : TAceSynHighlighter);
    procedure fcUpdate (ALang : TAceShLang); overload;
    procedure fcUpdate (AFileName : TFileName); overload;
    procedure fcUpdate (ALang : TAceShLang; AFileName : TFileName); overload;
  end;

var
  vupCurrentData : TUpCurrentData;

implementation

uses
  up_lang, up_var;

constructor TUpCurrentData.Create (AHighlighter : TAceSynHighlighter);
begin
  Self.vLang := aceShLangNone;
  Self.vLangTxt := '';
  Self.vSynHighlighter := AHighlighter;
  Self.vHighlighter := AHighlighter.vNone;
  Self.vFileName := '';
end;

procedure TUpCurrentData.fcUpdate (ALang : TAceShLang);
begin
  Self.fcUpdate(ALang,Self.vFileName);
end;

procedure TUpCurrentData.fcUpdate (AFileName : TFileName);
begin
  Self.vLang := vupLang.fcGetLang(ExtractFileExt(AFileName));
  Self.fcUpdate(Self.vLang,AFileName);
end;

procedure TUpCurrentData.fcUpdate (ALang : TAceShLang; AFileName : TFileName);
begin
  Self.vLang := ALang;
  Self.vLangTxt := vupLang.fcGetLangTxt(Self.vLang);
  vupVar.vSynHighlighter.vLang := Self.vLang;
  Self.vHighlighter := vupVar.vSynHighlighter.vHighlighter;
  Self.vFileName := AFileName;
end;

end.

