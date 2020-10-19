unit UnitPasReserveWords;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  TUReserveWords = class
    vReservedWords : array[0..6] of WideString; // always check size of the array
    function fcCS : WideString; // C Sharp
    function fcHTML : WideString;
    function fcJava : WideString;
    function fcJSON : WideString;
    function fcPascal : WideString;
    function fcPHP : WideString;
    function fcPython : WideString;
    constructor Create (AOwner : TComponent);
  end;

var
  VUReserveWords : TUReserveWords;

implementation

constructor TUReserveWords.Create (AOwner : TComponent);
var
  LRsrvWrd : Integer;
begin
  LRsrvWrd := -1;
  LRsrvWrd := LRsrvWrd + 1; Self.vReservedWords[LRsrvWrd] := Self.fcCS;
  LRsrvWrd := LRsrvWrd + 1; Self.vReservedWords[LRsrvWrd] := Self.fcHTML;
  LRsrvWrd := LRsrvWrd + 1; Self.vReservedWords[LRsrvWrd] := Self.fcJava;
  LRsrvWrd := LRsrvWrd + 1; Self.vReservedWords[LRsrvWrd] := Self.fcJSON;
  LRsrvWrd := LRsrvWrd + 1; Self.vReservedWords[LRsrvWrd] := Self.fcPascal;
  LRsrvWrd := LRsrvWrd + 1; Self.vReservedWords[LRsrvWrd] := Self.fcPHP;
  LRsrvWrd := LRsrvWrd + 1; Self.vReservedWords[LRsrvWrd] := Self.fcPython;
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

end.

