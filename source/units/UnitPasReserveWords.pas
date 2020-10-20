unit UnitPasReserveWords;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  TUReserveWords = class
    vLangTxt          : WideString;
    vReservedWords    : array[0..9] of WideString; // always check size of the array
    function fcNone   : WideString;
    function fcCobol  : WideString;
    function fcCS     : WideString; // C Sharp
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
  VUReserveWords : TUReserveWords;

implementation

constructor TUReserveWords.Create (AOwner : TComponent);
var
  LRsrvWrd : Integer;
begin
  Self.vLangTxt := '|COBOL|C#|HTML|Java|JSON|Pascal|PHP|Python|SQL';
  LRsrvWrd := -1;
  LRsrvWrd := LRsrvWrd + 1; Self.vReservedWords[LRsrvWrd] := Self.fcNone;
  LRsrvWrd := LRsrvWrd + 1; Self.vReservedWords[LRsrvWrd] := Self.fcCobol;
  LRsrvWrd := LRsrvWrd + 1; Self.vReservedWords[LRsrvWrd] := Self.fcCS;
  LRsrvWrd := LRsrvWrd + 1; Self.vReservedWords[LRsrvWrd] := Self.fcHTML;
  LRsrvWrd := LRsrvWrd + 1; Self.vReservedWords[LRsrvWrd] := Self.fcJava;
  LRsrvWrd := LRsrvWrd + 1; Self.vReservedWords[LRsrvWrd] := Self.fcJSON;
  LRsrvWrd := LRsrvWrd + 1; Self.vReservedWords[LRsrvWrd] := Self.fcPascal;
  LRsrvWrd := LRsrvWrd + 1; Self.vReservedWords[LRsrvWrd] := Self.fcPHP;
  LRsrvWrd := LRsrvWrd + 1; Self.vReservedWords[LRsrvWrd] := Self.fcPython;
  LRsrvWrd := LRsrvWrd + 1; Self.vReservedWords[LRsrvWrd] := Self.fcSQL;
end;

function TUReserveWords.fcNone : WideString;
begin
  Result := '';
end;

function TUReserveWords.fcCobol : WideString;
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

function TUReserveWords.fcCS : WideString;
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

function TUReserveWords.fcHTML : WideString;
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

function TUReserveWords.fcJava : WideString;
begin
  Result := 'abstract|assert|boolean|break|byte|case|catch|char|class|continue'
    + '|const|default|do|double|else|enum|exports|extends|final|finally|float|for|goto|if'
    + '|implements|import|i|stanceof|int|interface|long|module|native|new|package|private'
    + '|protected|public|requires|return|short|static|strictfp|super|switch|synchronized|this'
    + '|throw|throws|transi|nt|try|var|void|volatile|while'
  ;
end;

function TUReserveWords.fcJSON : WideString;
begin
  Result := '';
end;

function TUReserveWords.fcPascal : WideString;
begin
  Result := 'and|array|asm|begin|break|case|const|constructor|continue'
    + '|destructor|div|do|downto|else|end|FALSE|file|for|function|goto|if'
    + '|implementation|in|inline|interface|label|mod|nil|not|object|of|on|operator'
    + '|or|packed|procedure|program|record|repeat|set|shl|shr|string|then|to|TRUE'
    + '|type|unit|until|uses|var|while|with|xor'
  ;
end;

function TUReserveWords.fcPHP : WideString;
begin
  Result := '__halt_compiler()|abstract|and|array()|as|break|callable|case|catch'
    + '|class|clone|const|continue|declare|default|die()|do|echo|else|elseif|empty()|enddeclare'
    + '|endfor|e|dforeach|endif|endswitch|endwhile|eval()|exit()|extends|final|finally|fn'
    + '|for|foreach|function|global|goto|if|implements|include|include_once|instanceof|insteadof'
    + '|interface|isset()|list()|namespace|new|or|print|private|protected|public|require|require_once'
    + '|return|static|switch|throw|trait|try|unset()|use|var|while|xor|yield'
  ;
end;

function TUReserveWords.fcPython : WideString;
begin
  Result := 'and|as|assert|break|class|continue|def|del|elif|else|except|FALSE'
    + '|finally|for|from|global|if|import|in|is|lambda|None|nonlocal|not|or|pass|raise'
    + '|return|TRUE|try|while|with|yield'
  ;
end;

function TUReserveWords.fcSQL : WideString;
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

