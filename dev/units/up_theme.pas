unit up_theme;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SynEditHighlighter, Graphics, SynEdit, up_var;

type
  tupTheme = object
    vSynEditColor : TColor;
    vSynEditFontColor : TColor;
    vGutterColor : TColor;
    vGutterMarkupColor : TColor;
    vLineHighlightColor : TColor;
    vCommentAttriColor : TColor;
    vKeyAttriColor : TColor;
    procedure fcSetThemeColor (ASynEdit : TSynEdit; AVar : tupVar);
    procedure fcSetVarColor (AVar : tupVar);
    procedure fcSetSynEditColor (ASynEdit : TSynEdit; ASynEditColor,ASynEditFontColor,
      AGutterColor,AGutterMarkupColor,ALineHighlightColor : TColor);
    procedure fcSetAttriColor (ACommentAttriColor,AKeyAttriColor : TColor);
  private
    procedure fcSetColorDetail (ALang : TSynCustomHighlighter; ACommentAttriColor,AKeyAttriColor : TColor);
    procedure fcSetColorDetail (ALang : TSynCustomHighlighter; AKeyAttriColor : TColor);
  end;

var
  vupTheme : tupTheme;

implementation

uses
  ac_color;

procedure tupTheme.fcSetThemeColor (ASynEdit : TSynEdit; AVar : tupVar);
begin
  Self.fcSetVarColor(AVar);
  Self.fcSetSynEditColor(ASynEdit,Self.vSynEditColor,Self.vSynEditFontColor,Self.vGutterColor,
    Self.vGutterMarkupColor,Self.vLineHighlightColor
  );
  Self.fcSetAttriColor(Self.vCommentAttriColor,Self.vKeyAttriColor);
end;

procedure tupTheme.fcSetVarColor (AVar : tupVar);
begin
  if vupVar.vCurrentTheme = aseThemeNormal then
  begin
    Self.vSynEditColor := AVar.vSynEditColor;
    Self.vSynEditFontColor := AVar.vSynEditFontColor;
    Self.vGutterColor := AVar.vGutterColor;
    Self.vGutterMarkupColor := AVar.vGutterMarkupColor;
    Self.vLineHighlightColor := AVar.vLineHighlightColor;
    Self.vCommentAttriColor := AVar.vSynHighlighter.vCommentAttriColor;
    Self.vKeyAttriColor := AVar.vSynHighlighter.vKeyAttriColor;
  end
  else if vupVar.vCurrentTheme = aseThemeDark then
  begin
    Self.vSynEditColor := vacColor.fcInvert(AVar.vSynEditColor);
    Self.vSynEditFontColor := vacColor.fcInvert(AVar.vSynEditFontColor);
    Self.vGutterColor := vacColor.fcInvert(AVar.vGutterColor);
    Self.vGutterMarkupColor := vacColor.fcInvert(AVar.vGutterMarkupColor);
    Self.vLineHighlightColor := vacColor.fcInvert(AVar.vLineHighlightColor);
    Self.vCommentAttriColor := vacColor.fcInvert(AVar.vSynHighlighter.vCommentAttriColor);
    Self.vKeyAttriColor := vacColor.fcInvert(AVar.vSynHighlighter.vKeyAttriColor);
  end;
end;

procedure tupTheme.fcSetSynEditColor (ASynEdit : TSynEdit; ASynEditColor,ASynEditFontColor,
  AGutterColor,AGutterMarkupColor,ALineHighlightColor : TColor);
begin
  ASynEdit.Color := ASynEditColor;
  ASynEdit.Font.Color := ASynEditFontColor;
  ASynEdit.Gutter.Color := AGutterColor;
  ASynEdit.Gutter.Parts[1].MarkupInfo.Background := AGutterMarkupColor;
  ASynEdit.LineHighlightColor.Background := ALineHighlightColor;
end;

procedure tupTheme.fcSetAttriColor (ACommentAttriColor,AKeyAttriColor : TColor);
begin
  Self.fcSetColorDetail(vupVar.vSynHighlighter.vCobol,ACommentAttriColor,AKeyAttriColor);
  Self.fcSetColorDetail(vupVar.vSynHighlighter.vCS,ACommentAttriColor,AKeyAttriColor);
  Self.fcSetColorDetail(vupVar.vSynHighlighter.vCSS,ACommentAttriColor,AKeyAttriColor);
  Self.fcSetColorDetail(vupVar.vSynHighlighter.vHTML,ACommentAttriColor,AKeyAttriColor);
  Self.fcSetColorDetail(vupVar.vSynHighlighter.vJava,ACommentAttriColor,AKeyAttriColor);
  Self.fcSetColorDetail(vupVar.vSynHighlighter.vJSON,AKeyAttriColor);
  Self.fcSetColorDetail(vupVar.vSynHighlighter.vPas,ACommentAttriColor,AKeyAttriColor);
  Self.fcSetColorDetail(vupVar.vSynHighlighter.vPHP,ACommentAttriColor,AKeyAttriColor);
  Self.fcSetColorDetail(vupVar.vSynHighlighter.vPython,ACommentAttriColor,AKeyAttriColor);
  Self.fcSetColorDetail(vupVar.vSynHighlighter.vSQL,ACommentAttriColor,AKeyAttriColor);
end;

procedure tupTheme.fcSetColorDetail (ALang : TSynCustomHighlighter; ACommentAttriColor,AKeyAttriColor : TColor);
begin
  ALang.CommentAttribute.Foreground := ACommentAttriColor;
  ALang.KeywordAttribute.Foreground := AKeyAttriColor;
end;

procedure tupTheme.fcSetColorDetail (ALang : TSynCustomHighlighter; AKeyAttriColor : TColor);
begin
  ALang.KeywordAttribute.Foreground := AKeyAttriColor;
end;

end.

