unit up_theme;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SynEditHighlighter, Graphics, up_var, ac_synedit;

type
  tupTheme = object
    vSynEditColor : TColor;
    vSynEditFontColor : TColor;
    vGutterColor : TColor;
    vGutterMarkupColor : TColor;
    vLineHighlightColor : TColor;
    vCommentAttriColor : TColor;
    vKeyAttriColor : TColor;
    procedure fcSetThemeColor (AVar : tupVar);
    procedure fcSetVarColor (AVar : tupVar);
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

procedure tupTheme.fcSetThemeColor (AVar : tupVar);
begin
  Self.fcSetVarColor(AVar);
  Self.fcSetAttriColor(Self.vCommentAttriColor,Self.vKeyAttriColor);
end;

procedure tupTheme.fcSetVarColor (AVar : tupVar);
begin
  if vupVar.vCurrentTheme = seThemeNormal then
  begin
    Self.vCommentAttriColor := AVar.vSynHighlighter.vCommentAttriColor;
    Self.vKeyAttriColor := AVar.vSynHighlighter.vKeyAttriColor;
  end
  else if vupVar.vCurrentTheme = seThemeDark then
  begin
    Self.vCommentAttriColor := vacColor.fcInvert(AVar.vSynHighlighter.vCommentAttriColor);
    Self.vKeyAttriColor := vacColor.fcInvert(AVar.vSynHighlighter.vKeyAttriColor);
  end;
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

