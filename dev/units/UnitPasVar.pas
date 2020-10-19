unit UnitPasVar;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, UnitPasSynHighlighter;

type
  TUVar = class
    vCurrentFileName : TFileName;
    vImageIndexNormalFile : Byte;
    vImageIndexModifiedFile : Byte;
    vASETypeLang : TStringList;
    vSynHighlighter : TUSynHighlighter;
    vReservedWords : array[0..6] of WideString; // to determine size of the array, see TASETypeLang
    constructor Create (AOwner : TComponent);
  end;

var
  VUVar : TUVar;

implementation

uses
  UnitPasTools;

constructor TUVar.Create (AOwner : TComponent);
var
  LRsrvWrd : Integer;
begin
  Self.vCurrentFileName := '';
  Self.vImageIndexNormalFile := 3;
  Self.vImageIndexModifiedFile := 4;
  vASETypeLang := VUTools.FcStringExplode('C#|HTML|Java|JSON|Pascal|PHP|Python','|');
  vSynHighlighter := TUSynHighlighter.Create(AOwner);
  {Reserve Words}
  LRsrvWrd := -1;
  {CSharp}
  LRsrvWrd := LRsrvWrd + 1;
  vReservedWords[LRsrvWrd] := 'abstract|break|char|continue|do|event|finally|foreach'
    + '|in|is|new|out|protected|return|sizeof|struct|TRUE|ulong|using|while|as|byte'
    + '|checked|decimal|double|explicit|fixed|goto|int|lock|null|override|public|sbyte'
    + '|stackalloc|switch|try|unchecked|virtual|base|case|class|default|else|extern|float'
    + '|if|interface|long|object|params|readonly|sealed|static|this|typeof|unsafe|void'
    + '|bool|catch|const|delegate|enum|FALSE|for|implicit|internal|namespace|operator'
    + '|private|ref|short|string|throw|uint|ushort|volatile'
  ;
  {HTML}
  LRsrvWrd := LRsrvWrd + 1;
  vReservedWords[LRsrvWrd] := '<!DOCTYPE>|<a>|<abbr>|<acronym>|<address>|<applet>|<area>'
    + '|<article>|<aside>|<audio>|<b>|<base>|<basefont>|<bdi>|<bdo>|<big>|<blockquote>'
    + '|<body>|<br>|<button>|<canvas>|<caption>|<center>|<cite>|<code>|<col>|<colgroup>'
    + '|<data>|<datalist>|<dd>|<del>|<details>|<dfn>|<dialog>|<dir>|<div>|<dl>|<dt>|<em>'
    + '|<embed>|<fieldset>|<figc|ption>|<figure>|<font>|<footer>|<form>|<frame>|<frameset>'
    + '|<h1>|<h2>|<h3>|<h4>|<h5>|<h6>|<head>|<header>|<hr>|<html>|<i>|<iframe>|<img>|<input>'
    + '|<ins>|<kbd>|<label>|<|egend>|<li>|<link>|<main>|<map>|<mark>|<meta>|<meter>|<nav>'
    + '|<noframes>|<noscript>|<object>|<ol>|<optgroup>|<option>|<output>|<p>|<param>|<picture>'
    + '|<pre>|<progress>|<q>|<rp>|<rt>|<ruby>|<s>|<samp>|<script>|<section>|<select>|<small>'
    + '|<source>|<span>|<strike>|<strong>|<style>|<sub>|<summary>|<sup>|<svg>|<table>|<tbody>|<td>'
    + '|<template>|<textarea>|<tfoot>|<th>|<thead>|<time>|<title>|<tr>|<track>|<tt>|<u>|<ul>|<var>|<video>|<wbr>'
  ;
  {Java}
  LRsrvWrd := LRsrvWrd + 1;
  vReservedWords[LRsrvWrd] := 'abstract|assert|boolean|break|byte|case|catch|char|class|continue'
    + '|const|default|do|double|else|enum|exports|extends|final|finally|float|for|goto|if'
    + '|implements|import|i|stanceof|int|interface|long|module|native|new|package|private'
    + '|protected|public|requires|return|short|static|strictfp|super|switch|synchronized|this'
    + '|throw|throws|transi|nt|try|var|void|volatile|while'
  ;
  {JSON}
  LRsrvWrd := LRsrvWrd + 1;
  vReservedWords[LRsrvWrd] := '';
  {Pascal}
  LRsrvWrd := LRsrvWrd + 1;
  vReservedWords[LRsrvWrd] := 'and|array|asm|begin|break|case|const|constructor|continue'
    + '|destructor|div|do|downto|else|end|FALSE|file|for|function|goto|if'
    + '|implementation|in|inline|interface|label|mod|nil|not|object|of|on|operator'
    + '|or|packed|procedure|program|record|repeat|set|shl|shr|string|then|to|TRUE'
    + '|type|unit|until|uses|var|while|with|xor'
  ;
  {PHP}
  LRsrvWrd := LRsrvWrd + 1;
  vReservedWords[LRsrvWrd] := '__halt_compiler()|abstract|and|array()|as|break|callable|case|catch'
    + '|class|clone|const|continue|declare|default|die()|do|echo|else|elseif|empty()|enddeclare'
    + '|endfor|e|dforeach|endif|endswitch|endwhile|eval()|exit()|extends|final|finally|fn'
    + '|for|foreach|function|global|goto|if|implements|include|include_once|instanceof|insteadof'
    + '|interface|isset()|list()|namespace|new|or|print|private|protected|public|require|require_once'
    + '|return|static|switch|throw|trait|try|unset()|use|var|while|xor|yield'
  ;
  {Python}
  LRsrvWrd := LRsrvWrd + 1;
  vReservedWords[LRsrvWrd] := 'and|as|assert|break|class|continue|def|del|elif|else|except|FALSE'
  + '|finally|for|from|global|if|import|in|is|lambda|None|nonlocal|not|or|pass|raise'
  + '|return|TRUE|try|while|with|yield'
;
end;

end.

