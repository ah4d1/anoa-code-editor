unit up_reservewords;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ace_synhighlighter, Dialogs;

type
  tupReserveWords = class
    constructor Create (ASynHighlighter : TAceSynHighlighter);
  end;

var
  vupReserveWords : tupReserveWords;

implementation

uses
  up_var;

constructor tupReserveWords.Create (ASynHighlighter : TAceSynHighlighter);
begin
  ASynHighlighter.fcReserveWords(vupVar.vAppDir + '/resword/');
end;

end.

