unit up_reservewords;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  tupReserveWords = class
    vLangTxt          : WideString;
    vReservedWords    : array[0..10] of WideString; // always check size of the array
    function fcNone   : WideString;
    function fcCobol  : WideString;
    function fcCS     : WideString; // C Sharp
    function fcCSS    : WideString;
    function fcHTML   : WideString;
    function fcJava   : WideString;
    function fcJSON   : WideString;
    function fcPascal : WideString;
    function fcPHP    : WideString;
    function fcPython : WideString;
    function fcSQL    : WideString;
    constructor Create (AOwner : TComponent);
  end;

var
  vupReserveWords : tupReserveWords;

implementation

constructor tupReserveWords.Create (AOwner : TComponent);
var
  LRsrvWrd : Integer;
begin
  Self.vLangTxt := '|COBOL|C#|CSS|HTML|Java|JSON|Pascal|PHP|Python|SQL';
  LRsrvWrd := -1;
  LRsrvWrd := LRsrvWrd + 1; Self.vReservedWords[LRsrvWrd] := Self.fcNone;
  LRsrvWrd := LRsrvWrd + 1; Self.vReservedWords[LRsrvWrd] := Self.fcCobol;
  LRsrvWrd := LRsrvWrd + 1; Self.vReservedWords[LRsrvWrd] := Self.fcCS;
  LRsrvWrd := LRsrvWrd + 1; Self.vReservedWords[LRsrvWrd] := Self.fcCSS;
  LRsrvWrd := LRsrvWrd + 1; Self.vReservedWords[LRsrvWrd] := Self.fcHTML;
  LRsrvWrd := LRsrvWrd + 1; Self.vReservedWords[LRsrvWrd] := Self.fcJava;
  LRsrvWrd := LRsrvWrd + 1; Self.vReservedWords[LRsrvWrd] := Self.fcJSON;
  LRsrvWrd := LRsrvWrd + 1; Self.vReservedWords[LRsrvWrd] := Self.fcPascal;
  LRsrvWrd := LRsrvWrd + 1; Self.vReservedWords[LRsrvWrd] := Self.fcPHP;
  LRsrvWrd := LRsrvWrd + 1; Self.vReservedWords[LRsrvWrd] := Self.fcPython;
  LRsrvWrd := LRsrvWrd + 1; Self.vReservedWords[LRsrvWrd] := Self.fcSQL;
end;

function tupReserveWords.fcNone : WideString;
begin
  Result := '';
end;

function tupReserveWords.fcCobol : WideString;
begin
  Result := 'ACCEPT|ACCESS|ADD|ADDRESS|ADVANCING|AFTER|ALL|ALPHABET|ALPHABETIC|ALPHABETIC-LOWER'
    + '|ALPHABETIC-UPPER|ALPHANUMERIC|ALPHANUMERIC-EDITED|ALSO|ALTER|ALTERNATE|AND|ANY|APPLY|ARE'
    + '|AREA|AREAS|ASCENDING|ASSIGN|AT|AUTHOR|BASIS|BEFORE|BEGINNING|BINARY|BLANK|BLOCK|BOTTOM|BY'
    + '|CALL|CANCEL|CBL|CD|CF|CH|CHARACTER|CHARACTERS|CLASS|CLASS-ID|CLOCK-|NITS|CLOSE|COBOL|CODE'
    + '|CODE-SET|COLLATING|COLUMN|COMMA|COMMON|COMMUNICATION|COMP|COMP-1|COMP-2|COMP-3|COMP-4|COMP-5'
    + '|COMPUTATIONAL|COMPUTATIONAL-1|COMPUTATIONAL-2|COM|UTATIONAL-3|COMPUTATIONAL-4|COMPUTATIONAL-5'
    + '|COMPUTE|COM-REG|CONFIGURATION|CONTAINS|CONTENT|CONTINUE|CONTROL|CONTROLS|CONVERTING|COPY|CORR'
    + '|CORRESPONDING|COUNT|CURREN|Y|DATA|DATE-COMPILED|DATE-WRITTEN|DAY|DAY-OF-WEEK|DBCS|DE|DEBUG-CONTENTS'
    + '|DEBUGGING|DEBUG-ITEM|DEBUG-LINE|DEBUG-NAME|DEBUG-SUB-1|DEBUG-SUB-2|DEBUG-SUB-3|DECIMAL-POINT'
    + '|DECLARATIVES|DELETE|DELIMITED|DELIMITER|DEPENDING|DESCENDING|DESTINATION|DETAIL|DISPLAY|DISPLAY-1'
    + '|DIVIDE|DIVISION|DOWN|DUPLICATES|DYNAMIC|EGCS|EGI|EJECT|ELSE|EMI|E|ABLE|END|END-ADD|END-CALL|END-COMPUTE'
    + '|END-DELETE|END-DIVIDE|END-EVALUATE|END-IF|ENDING|END-INVOKE|END-MULTIPLY|END-OF-PAGE|END-PERFORM'
    + '|END-READ|END-RECEIVE|END-RETU|N|END-REWRITE|END-SEARCH|END-START|END-STRING|END-SUBTRACT|END-UNSTRING'
    + '|END-WRITE|ENTER|ENTRY|ENVIRONMENT|EOP|EQUAL|ERROR|ESI|EVALUATE|EVERY|EXCEPTION|EXIT|EXTEND|E|TERNAL'
    + '|FALSE|FD|FILE|FILE-CONTROL|FILLER|FINAL|FIRST|FOOTING|FOR|FROM|FUNCTION|GENERATE|GIVING|GLOBAL|GO|GOBACK'
    + '|GREATER|GROUP|HEADING|HIGH-VALUE|HIGH-VALUES|ID|IDEN|IFICATION|IF|IN|INDEX|INDEXED|INDICATE|INHERITS'
    + '|INITIAL|INITIALIZE|INITIATE|INPUT|INPUT-OUTPUT|INSERT|INSPECT|INSTALLATION|INTO|INVALID|INVOKE'
    + '|I-O|I-O-CONTROL|IS|JU|T|JUSTIFIED|KANJI|KEY|LABEL|LAST|LEADING|LEFT|LENGTH|LESS|LIMIT|LIMITS|LINAGE'
    + '|LINAGE-COUNTER|LINE|LINE-COUNTER|LINES|LINKAGE|LOCAL-STORAGE|LOCK|LOW-VALUE|LOW-VALUES|MEMORY|MERGE'
    + '|MESSAGE|METACLASS|METHOD|METHOD-ID|MODE|MODULES|MORE-LABELS|MOVE|MULTIPLE|MULTIPLY|NATIVE|NATIVE_BINARY'
    + '|NEGATIVE|NEXT|NO|NOT|NULL|NULLS|NUMBER|NUMERIC|NUMERIC-EDITED|OBJECT|OBJECT-COMPUTER|OCCURS|OF|OFF'
    + '|OMITTED|ON|OPEN|OPTIONAL|OR|ORDER|ORGANIZATION|OTHER|OUTPUT|OVERFLOW|OVERRIDE|PACKED-DECIMAL|PADDING'
    + '|PAGE|PAGE-CO|NTER|PASSWORD|PERFORM|PF|PH|PIC|PICTURE|PLUS|POINTER|POSITION|POSITIVE|PRINTING|PROCEDURE'
    + '|PROCEDURE-POINTER|PROCEDURES|PROCEED|PROCESSING|PROGRAM|PROGRAM-ID|PURGE|Q|EUE|QUOTE|QUOTES|RANDOM|RD'
    + '|READ|READY|RECEIVE|RECORD|RECORDING|RECORDS|RECURSIVE|REDEFINES|REEL|REFERENCE|REFERENCES|RELATIVE'
    + '|RELEASE|RELOAD|REMAINDER|REMOVAL|RENAM|S|REPLACE|REPLACING|REPORT|REPORTING|REPORTS|REPOSITORY|RERUN'
    + '|RESERVE|RESET|RETURN|RETURN-CODE|RETURNING|REVERSED|REWIND|REWRITE|RF|RH|RIGHT|ROUNDED|RUN|SAME|SD|SEA'
    + '|CH|SECTION|SECURITY|SEGMENT|SEGMENT-LIMIT|SELECT|SELF|SEND|SENTENCE|SEPARATE|SEQUENCE|SEQUENTIAL|SERVICE'
    + '|SET|SHIFT-IN|SHIFT-OUT|SIGN|SIZE|SKIP1|SKIP2|SKIP3|SORT|SOR|-CONTROL|SORT-CORE-SIZE|SORT-FILE-SIZE'
    + '|SORT-MERGE|SORT-MESSAGE|SORT-MODE-SIZE|SORT-RETURN|SOURCE|SOURCE-COMPUTER|SPACE|SPACES|SPECIAL-NAMES'
    + '|STANDARD|STANDARD-1|STAN|ARD-2|START|STATUS|STOP|STRING|SUB-QUEUE-1|SUB-QUEUE-2|SUB-QUEUE-3|SUBTRACT|SUM'
    + '|SUPER|SUPPRESS|SYMBOLIC|SYNC|SYNCHRONIZED|TABLE|TALLY|TALLYING|TAPE|TERMINAL|TERMINA|E|TEST|TEXT|THAN|THEN'
    + '|THROUGH|THRU|TIME|TIMES|TITLE|TO|TOP|TRACE|TRAILING|TRUE|TYPE|UNIT|UNSTRING|UNTIL|UP|UPON|USAGE|USE|USING'
    + '|VALUE|VALUES|VARYING|WHEN|WHEN-COMPILED|WITH|WORDS|WORKING-STORAGE|WRITE|WRITE-ONLY|ZERO|ZEROES|ZEROS'
  ;
end;

function tupReserveWords.fcCS : WideString;
begin
  Result := 'abstract|break|char|continue|do|event|finally|foreach'
    + '|in|is|new|out|protected|return|sizeof|struct|TRUE|ulong|using|while|as|byte'
    + '|checked|decimal|double|explicit|fixed|goto|int|lock|null|override|public|sbyte'
    + '|stackalloc|switch|try|unchecked|virtual|base|case|class|default|else|extern|float'
    + '|if|interface|long|object|params|readonly|sealed|static|this|typeof|unsafe|void'
    + '|bool|catch|const|delegate|enum|FALSE|for|implicit|internal|namespace|operator'
    + '|private|ref|short|string|throw|uint|ushort|volatile'
  ;
end;

function tupReserveWords.fcCSS : WideString;
begin
  Result := ':above-level|accelerator|accesskey|:active|additive-symbols|::after|-ah-|align-content|align-items|alignment-adjust|alignment-baseline|align-self|all|::alternate|an|hor-point|<angle>|animation|animation-delay|animation-direction|animation-duration|animation-fill-mode|animation-iteration-count|animation-name|animation-play-state|animation-timing-function|::anonymous-block|::anonymous-positioned-block|:any()|:any-link|appearance|-apple-|app-region|aspect-ratio|aspect-ratio @?|:at-level|-atsc-|attr()|auto|azimuth|::backdrop|backface-visibility|background|background-attachment|background-clip|background-color|background-composite|backgr|und-image|background-inline-policy|background-origin|background-origin-x|background-origin-y|background-position|background-position-x|background-position-y|backgro|nd-repeat|background-size|baseline-shift|::before|behavior|:below-level|binding|:blank|bleed|blend-mode|block-progression|bookmark-label|bookmark-level|bookmark-sta|e|bookmark-target|border|border-after|border-after-color|border-after-style|border-after-width|border-before|border-before-color|border-before-style|border-before-w|dth|border-bottom|border-bottom-color|border-bottom-colors|border-bottom-left-radius|border-bottom-right-radius|border-bottom-style|border-bottom-width|border-clip|border-clip-bottom|border-clip-left|border-clip-right|border-clip-top|border-collapse|border-color|border-end|border-end-color|border-end-style|border-end-width|bord|r-fit|border-horizontal-spacing|border-image|border-image-outset|border-image-repeat|border-image-slice|border-image-source|border-image-width|border-left|border-le|t-colors|border-left-color|border-left-style|border-left-width|border-radius|border-right|border-right-color|border-right-colors|border-right-style|border-right-wid|h|border-spacing|border-start|border-start-color|border-start-style|border-start-width|border-style|border-top|border-top-color|border-top-colors|border-top-left-ra|ius|border-top-right-radius|border-top-style|border-top-width|border-vertical-spacing|border-width|bottom|:bound-element|box-align|box-decoration-break|box-direction|box-flex|box-flex-group|box-lines|box-ordinal-group|box-orient|box-pack|box-reflect|box-shadow|box-sizing|box-snap|break-after|break-before|break-inside|:broken|::|rowse|calc()|::canvas|canvas()|caption-side|::cell-content|ch|chains|@charset|::check|:checked|::choices|clear|::clear|clip|clip-path|clip-rule|cm|color|color @?|<color>|color-correction|color-index @?|color-profile|@color-profile|::column()|column-axis|column-break-after|column-break-before|column-break-inside|column-count|column-fill|column-gap|column-progres|ion|column-rule|column-rule-color|column-rule-style|column-rule-width|columns|column-span|column-width|:contains()|content|content-zoom-chaining|content-zooming|con|ent-zoom-limit|content-zoom-limit-max|content-zoom-limit-min|content-zoom-snap|content-zoom-snap-points|content-zoom-snap-type|@counter|counter()|counter-increment|counter-reset|counters()|@counter-style|crop|cross-fade()|cubic-bezier()|cue|cue-after|cue-before|:current|cursor|cycle()|dashboard-region|default|:default|deg|devic|-aspect-ratio @?|device-cmyk()|device-pixel-ratio @?|device-width @?|:dir()|direction|:disabled|display|display-box|display-extras|display-inside|display-outside|@document|dominant-baseline|dpcm|dpi|dppx|:drag-over|drop-initial-af|er-adjust|drop-initial-after-align|drop-initial-before-adjust|drop-initial-before-align|drop-initial-size|drop-initial-value|element()|elevation|em|:empty|empty-cel|s|:enabled|-epub-|ex|::expand|expression()|fallback|fill|::fill|::fill-lower|fill-opacity|fill-rule|::fill-upper|filter|:first|:first-child|::first-letter|::first-l|ne|:first-node|:first-of-type|::first-page|fit|fit-position|flavor|flex|flex|flex-align|flex-basis|flex-direction|flex-flow|flex-grow|flex-order|flex-pack|flex-shri|k|flex-wrap|float|float-edge|float-offset|flood-color|flood-opacity|flow-from|flow-into|:focus|:focus-inner|focus-opacity|:focus-outer|:focusring|font|font-color|fo|t-emphasize|font-emphasize-position|font-emphasize-style|@font-face|font-family|font-feature-settings|@font-feature-values|font-kerning|font-language-override|font-|ize|font-size-adjust|font-size-delta|font-smooth|font-smoothing|font-stretch|font-style|font-synthesis|font-variant|font-variant-alternates|font-variant-caps|font-v|riant-east-asian|font-variant-ligatures|font-variant-numeric|font-variant-position|font-weight|footnote|::footnote-call|::footnote-marker|force-broken-image-icon|fr|<frequency>|:fullscreen|:full-screen|:full-screen-ancestor|:future|gd|glyph-orientation-horizontal|glyph-orientation-vertical|grad|<gradient>|grid @?|grid-area|grid-auto-columns|grid-auto-flow|grid-auto-rows|grid-column|grid-column-align|grid-column-position|grid-columns|grid-column-span|grid-definition-columns|grid-definition-rows|grid-position|grid-row|grid-row-align|grid-row-position|grid-rows|grid-row-span|grid-span|grid-template|:handler-blocked|:handler-crashed|:han|ler-disabled|hanging-punctuation|height|height @?|high-contrast @?|high-contrast-adjust|highlight|horiz-align|:hover|-hp-|hsl()|hsla()|hyphenate-character|hyphenate-limit-after|hyphenate-limit-before|hyphenate-limit-chars|hyphen|te-limit-last|hyphenate-limit-lines|hyphenate-limit-zone|hyphenate-resource|hyphens|Hz|icon|image()|<image>|image-orientation|image-rect()|image-region()|image-rend|ring|image-resolution|image-orientation|images-in-menus @?|ime-mode|@import|!important|in|include-source|:indeterminate|inherit|initial|inline-box-align|inline-flex|inline-table|::inline-table|input-format|:input-placeho|der|::input-placeholder|input-required|:in-range|<integer>|interpolation-mode|interpret-as|:invalid|justify-items|justify-content|justify-self|kerning|:keyboard-act|ve|@keyframes|-khtml-|kHz|:lang()|languages|:last-child|:last-of-type|:last-node|layout-flow|layout-grid|layout-grid-char|layout-grid-char-spacing|layout-grid-line|layout-grid-mode|layout-grid-type|leader()|left|:left|<length>|letter-spacing|lighting-color|line-align|linear-gradient|line-box-contain|line-break|line-clamp|line-g|id|line-height|::line-marker|line-slack|line-snap|line-stacking|line-stacking-ruby|line-stacking-shift|line-stacking-strategy|link|:link|link-source|::list-bullet|l|st-image-1|list-image-2|list-image-3|::list-number|list-style-image|list-style-position|list-style-type|:loading|locale|:locale-dir()|:local-link|logical-height|log|cal-width|:lwtheme|:lwtheme-darktext|mac-graphite-theme @?|maemo-classic|margin|margin-after|margin-after-collapse|margin-before|margin-before-collapse|margin-bottom|margin-bottom-collapse|margin-collapse|margin-end|marg|n-left|margin-right|margin-start|margin-top|margin-top-collapse|marker|::marker|marker-end|marker-mid|marker-start|marks|marquee|marquee|marquee-dir|marquee-directi|n|marquee-increment|marquee-loop|marquee-play-count|marquee-repetition|marquee-speed|marquee-style|mask|mask-attachment|mask-box-image|mask-box-image-outset|mask-bo|-image-repeat|mask-box-image-slice|mask-box-image-source|mask-box-image-width|mask-clip|mask-composite|mask-image|mask-origin|mask-position|mask-position-x|mask-pos|tion-y|mask-repeat|mask-repeat-x|mask-repeat-y|mask-size|mask-type|:matches()|match-nearest-mail-blockquote-color|:math-anonymous|:math-columnline|:math-firstcolumn|:math-firstrow|:math-font-size|:math-font-style|:math-lastcolumn|:math-rowline|:math-lastrow|:math-stretchy|max-color-index @?|max-color @?|max-device-aspect-ratio|@?|max-device-height @?|max-device-pixel-ratio @?|max-device-width @?|max-height|max-height @?|max-logical-height|max-logical-width|max-monochrome @?|max-resolution @?|max-width|max-width @?|max-zoom|@media|min-aspect-ratio @?|min-color @?|min-color-index|@?|min-device-aspect-ratio @?|min-device-height @?|min-device-pixel-ratio @?|min-device-width @?|min-height|min-height @?|mini-fold|min-logical-height|min-logical-width|minmax()|min-monochrome @?|min-resolution @?|min-width|min-width @?|min-zoom|mm|monochrome @?|move-to|-moz-|-ms-|ms|mso-*|@namespace|nav-banner-image|nav-bottom|navbutton-*|nav-down|nav-down-shift|@navigation|nav-index|nav-left|nav-left-shift|nav-right|na|-right-shift|nav-up|nav-up-shift|nbsp-mode|negative|none|normal|:not()|:nth-child()|:nth-column()|:nth-last-child()|:nth-last-column()|:nth-last-match()|:nth-last-o|-type()|:nth-match()|:nth-of-type()|<number>|-o-|object-fit|object-position|oeb-column-number|oeb-page-foot|oeb-page-head|:only-child|:only-of-type|opacity|:optional|order|orient|orientation|orientation @?|orphans|outline|outline-color|outline-offset|outline-radius|outline-radius-bottomleft|outline-radius-bottomright|outline-radius-topleft|outline-radius-topright|o|tline-style|outline-width|:out-of-range|::outside|overflow|overflow-scrolling|overflow-style|overflow-wrap|overflow-x|overflow-y|padding|padding-after|padding-before|padding-bottom|padding-end|padding-left|padding-right|padding-start|padding-top|page|::page|::page()|@page|::pagebreak|page-break-after|page-break-before|page-brea|-inside|::page-column()|::pagecontent|page-policy|::page-sequence|panose-1|:past|pause|pause-after|pause-before|pc|pending()|<percentage>|perspective|perspective()|perspective-origin|perspective-origin-x|perspective-origin-y|phonemes|pitch|pitch-range|:placeholder|play-during|pointer-events|position|<position>|prefix|presentati|n-level|-prince-|print-color-adjust|progress-appearance|pt|punctuation-trim|punctuation-wrap|px|quotes|rad|radial-gradient|range|<ratio>|:read-only|:read-write|rect|)|@region|region-break-after|region-break-before|region-break-inside|region-overflow|rem|rendering-intent|::repeat-index|repeating-linear-gradient()|repeating-radia|-gradient()|::repeat-item|replace|:required|resize|resolution|resolution @?|<resolution>|rest|rest-after|rest-before|::reveal|rgb()|rgba()|richness|right|:right|-rim-|-ro-|:root|rotate()|rotateX()|rotateY()|rotate3D()|rotateZ()|rotate3d()|rotation|rotation-point|row-span|rounddown()|roundup()|rtl-ordering|ruby-align|ruby-overhang|ruby-position|ruby-span|running()|scale()|scaleX()|scaleY()|scaleZ()|s|ale3d(X)|scan @?|::selection|separator-image|set-link-source|<shape>|shape-inside|shape-margin|shape-outside|shape-padding|:scope|script-level|script-min-size|script-size-multipl|er|scrollbar-3dlight-color property|scrollbar-arrow-color|scrollbar-base-color|scrollbar-darkshadow-color|scrollbar-end-backward @?|scrollbar-end-forward @?|scrollbar-face-color|scrollbar-highlight-color|scrollbar-shadow-color|scrollbar-start-backward @?|scrollbar-start-forward @?|scrollbar-thumb-proportional @?|scrollbar-track-color|scroll-chaining|scroll-limit|scroll-limit-x-max|scroll-limit-x-min|scroll-limit-y-max|scroll-limit-y-min|scroll-rails|scroll-snap-points-x|scroll-snap-points-y|scroll-snap-type|scroll-snap-x|scroll-snap-y|scroll-translation|::scrolled-canvas|::scrolled-content|::scrolled-page-sequence|::selection|shape-|mage-threshold|shape-inside|shape-margin|shape-outside|shape-padding|shape-rendering|size|skew()|skewX()|skewY()|skewZ()|skew3D(X)|::slot()|speak|speak-as|speak-hea|er|speak-numeral|speak-punctuation|speech-rate|src|stack-sizing|steps()|stop-color|stop-opacity|stress|@string|string()|<string>|string-set|stroke|stroke-dasharray|stroke-dashoffset|stroke-linecap|stroke-linejoin|stroke-miterlimit|stroke-opacity|stroke-width|:submit-invalid|suffix|@supports|:suppressed|::svg-foreign-content|svg|shadow|symbols|symbols()|system|:system-metric()|::table|table-baseline|table-border-color-dark|table-border-color-light|::table-cell|::table-column|::table-column-|roup|::table-cell|table-layout|::table-outer|::table-row|::table-row-group|tab-size|tab-stops|tap-highlight-color|target|:target|target-counter()|target-counters()|target-name|target-new|target-position|target-pull()|target-text()|-tc-|text-anchor|text-align|text-align-last|text-autospace|text-blink|text-combine|text-combine-ho|izontal|text-decoration|text-decoration-color|text-decoration-line|text-decorations-in-effect|text-decoration-skip|text-decoration-style|text-effect|text-emphasis|t|xt-emphasis-color|text-emphasis-position|text-emphasis-skip|text-emphasis-style|text-fill-color|text-fit|text-height|text-indent|text-justify|text-justify-trim|text|kashida|text-kashida-space|text-line-through|text-orientation|text-outline|text-overflow|text-rendering|text-security|text-shadow|text-size-adjust|text-space-collap|e|text-spacing|text-stroke|text-stroke-color|text-stroke-width|text-transform|text-trim|text-underline|text-underline-color|text-underline-position|text-underline-s|yle|text-wrap|::thumb|::ticks-after|::ticks-before|<timing-function>|toggle()|::tooltip|top|top-bar-button|touch-action|touch-callout|touch-enabled @?|::track|transform|transform-origin|transform-origin-x|transform-origin-y|transform-origin-z|transform-style|transition|transition-delay|transition-duration|trans|tion-property|transition-repeat-count|transition-timing-function|translate()|translateX()|translateY()|translateZ()|translate3d()|:tree-checkbox|:tree-cell|:tree-ce|l-text|:tree-cell-text(hover)|:tree-column|:tree-drop-feedback|:tree-image|:tree-indentation|:tree-line|:tree-progressmeter|:tree-row|:tree-row(hover)|:tree-separat|r|:tree-twisty|turn|:ui-invalid|:ui-valid|unicode-bidi|unicode-range|<uri>|url()|use-link-source|user-drag|:user-error|user-focus|<user-ident>|user-input|user-modify|user-select|user-zoom|:valid|::value|var()|var-*|vector-effect|vertical-align|version|vh|@viewport|:viewport|@viewport|:viewport-scroll|visibility|:visited|vmax|vm|n|voice-balance|voice-duration|voice-family|voice-pitch|voice-pitch-range|voice-range|voice-rate|voice-stress|voice-volume|volume|vw|-wap-|-webkit-|white-space|wido|s|width|width @?|:window-inactive|windows-classic @?|windows-compositor @?|windows-default-theme @?|window-shadow|windows-theme @?|word-break|word-spacing|word-wrap|wrap|wrap-flow|wrap-margin|wrap-padding|wrap-through|writing-mode|::xul-anonymous-block|-xv-|z-index|zoom';
end;

function tupReserveWords.fcHTML : WideString;
begin
  Result := '<!DOCTYPE>|<a>|<abbr>|<acronym>|<address>|<applet>|<area>'
    + '|<article>|<aside>|<audio>|<b>|<base>|<basefont>|<bdi>|<bdo>|<big>|<blockquote>'
    + '|<body>|<br>|<button>|<canvas>|<caption>|<center>|<cite>|<code>|<col>|<colgroup>'
    + '|<data>|<datalist>|<dd>|<del>|<details>|<dfn>|<dialog>|<dir>|<div>|<dl>|<dt>|<em>'
    + '|<embed>|<fieldset>|<figc|ption>|<figure>|<font>|<footer>|<form>|<frame>|<frameset>'
    + '|<h1>|<h2>|<h3>|<h4>|<h5>|<h6>|<head>|<header>|<hr>|<html>|<i>|<iframe>|<img>|<input>'
    + '|<ins>|<kbd>|<label>|<|egend>|<li>|<link>|<main>|<map>|<mark>|<meta>|<meter>|<nav>'
    + '|<noframes>|<noscript>|<object>|<ol>|<optgroup>|<option>|<output>|<p>|<param>|<picture>'
    + '|<pre>|<progress>|<q>|<rp>|<rt>|<ruby>|<s>|<samp>|<script>|<section>|<select>|<small>'
    + '|<source>|<span>|<strike>|<strong>|<style>|<sub>|<summary>|<sup>|<svg>|<table>|<tbody>|<td>'
    + '|<template>|<textarea>|<tfoot>|<th>|<thead>|<time>|<title>|<tr>|<track>|<tt>|<u>|<ul>'
    + '|<var>|<video>|<wbr>'
  ;
end;

function tupReserveWords.fcJava : WideString;
begin
  Result := 'abstract|assert|boolean|break|byte|case|catch|char|class|continue'
    + '|const|default|do|double|else|enum|exports|extends|final|finally|float|for|goto|if'
    + '|implements|import|i|stanceof|int|interface|long|module|native|new|package|private'
    + '|protected|public|requires|return|short|static|strictfp|super|switch|synchronized|this'
    + '|throw|throws|transi|nt|try|var|void|volatile|while'
  ;
end;

function tupReserveWords.fcJSON : WideString;
begin
  Result := '';
end;

function tupReserveWords.fcPascal : WideString;
begin
  Result := 'and|array|asm|begin|break|case|const|constructor|continue'
    + '|destructor|div|do|downto|else|end|FALSE|file|for|function|goto|if'
    + '|implementation|in|inline|interface|label|mod|nil|not|object|of|on|operator'
    + '|or|packed|procedure|program|record|repeat|set|shl|shr|string|then|to|TRUE'
    + '|type|unit|until|uses|var|while|with|xor'
  ;
end;

function tupReserveWords.fcPHP : WideString;
begin
  Result := '__halt_compiler()|abstract|and|array()|as|break|callable|case|catch'
    + '|class|clone|const|continue|declare|default|die()|do|echo|else|elseif|empty()|enddeclare'
    + '|endfor|e|dforeach|endif|endswitch|endwhile|eval()|exit()|extends|final|finally|fn'
    + '|for|foreach|function|global|goto|if|implements|include|include_once|instanceof|insteadof'
    + '|interface|isset()|list()|namespace|new|or|print|private|protected|public|require|require_once'
    + '|return|static|switch|throw|trait|try|unset()|use|var|while|xor|yield'
  ;
end;

function tupReserveWords.fcPython : WideString;
begin
  Result := 'and|as|assert|break|class|continue|def|del|elif|else|except|FALSE'
    + '|finally|for|from|global|if|import|in|is|lambda|None|nonlocal|not|or|pass|raise'
    + '|return|TRUE|try|while|with|yield'
  ;
end;

function tupReserveWords.fcSQL : WideString;
begin
  Result := 'ADD|ADD CONSTRAINT|ALTER|ALTER COLUMN|ALTER TABLE|ALL|AND|ANY|AS|ASC'
    + '|BACKUP DATABASE|BETWEEN|CASE|CHECK|COLUMN|CONSTRAINT|CREATE|CREATE DATABASE'
    + '|CREATE INDEX|CREATE OR REPLACE VIEW|CREATE TABLE|CREATE PROCEDURE|CREATE UNIQUE INDEX'
    + '|CREATE VIEW|DATABASE|DEFAULT|DELETE|DESC|DISTINCT|DROP|DROP COLUMN|DROP CONSTRAINT'
    + '|DROP DATABASE|DROP DEFAULT|DROP INDEX|DROP TABLE|DROP VIEW|EXEC|EXISTS|FOREIGN KEY'
    + '|FROM|FULL OUTER JOIN|GROUP BY|HAVING|IN|INDEX|INNER JOIN|INSERT INTO|INSERT INTO SELECT'
    + '|IS NULL|IS NOT NULL|JOIN|LEFT JOIN|LIKE|LIMIT|NOT|NOT NULL|OR|ORDER BY|OUTER JOIN'
    + '|PRIMARY KEY|PROCEDURE|RIGHT JOIN|ROWNUM|SELECT|SELECT DISTINCT|SELECT INTO|SELECT TOP'
    + '|SET|TABLE|TOP|TRUNCATE TABLE|UNION|UNION ALL|UNIQUE|UPDATE|VALUES|VIEW|WHERE'
  ;
end;

end.

