unit up_var;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics, SynEditHighlighter, up_synhighlighter, up_reservewords;

type
  taseTheme = (aseThemeLight,aseThemeDark);
  tupVar = class
    vAppDir : string;
    vTabPrefix : string;
    vTabNo : Byte;
    vImageIndexNormalFile : Byte;
    vImageIndexModifiedFile : Byte;
    vSynHighlighter : tupSynHighlighter;
    vReservedWords : tupReserveWords;
    vLang : TStringList;
    vFontSize : Byte;
    vCurrentFindKeyword : string;
    vCurrentTheme : taseTheme;
    vSynEditColor : TColor;
    vSynEditFontColor : TColor;
    vGutterColor : TColor;
    vGutterMarkupColor : TColor;
    vLineHighlightColor : TColor;
    constructor Create (AOwner : TComponent);
    procedure fcInit (AOwner : TComponent);
    function fcFileName (AFileName : TFileName; var ATmpFile : Boolean) : TFileName; overload;
    procedure fcUpdate (AFontSize : Byte); overload;
    procedure fcUpdate (AFontSize : Byte; ATheme : taseTheme); overload;
  end;

var
  vupVar : tupVar;

implementation

uses
  ac_string, ac_filedir;

constructor tupVar.Create (AOwner : TComponent);
begin
  Self.vTabPrefix := 'Tab';
  Self.vTabNo := 0;
  Self.vImageIndexNormalFile := 3;
  Self.vImageIndexModifiedFile := 4;
  {}
  Self.vFontSize := 9;
  Self.vCurrentFindKeyword := '';
  Self.vCurrentTheme := aseThemeLight;
  Self.vSynEditColor := clWhite;
  Self.vSynEditFontColor := clBlack;
  Self.vGutterColor := clBtnFace;
  Self.vGutterMarkupColor := clBtnFace;
  Self.vLineHighlightColor := $00EFE8D6;
end;

procedure tupVar.fcInit (AOwner : TComponent);
begin
  Self.vReservedWords := tupReserveWords.Create;
  Self.vSynHighlighter := tupSynHighlighter.Create(AOwner);
  Self.vLang := vacString.fcSplit(Self.vReservedWords.vLangTxt,'|');
end;

{if AFileName exists then use AFileName, else use TmpFile}
function tupVar.fcFileName (AFileName : TFileName; var ATmpFile : Boolean) : TFileName;
var
  LFileName : TFileName;
  LTmpFile : Boolean;
begin
  if Trim(AFileName) <> '' then
  begin
    LFileName := AFileName;
    LTmpFile := False;
  end
  else
  begin
    LFileName := vacFileDir.fcTmpFileName;
    LTmpFile := True;
  end;
  ATmpFile := LTmpFile;
  Result := LFileName;
end;

procedure tupVar.fcUpdate (AFontSize : Byte);
begin
  Self.fcUpdate(AFontSize,Self.vCurrentTheme);
end;

procedure tupVar.fcUpdate (AFontSize : Byte; ATheme : taseTheme);
begin
  Self.vFontSize := AFontSize;
  Self.vCurrentTheme := ATheme;
end;

end.

