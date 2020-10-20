program AnoaSyntaxEditor;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, UnitFormMain, UnitPasTools, UnitPasLang, UnitPasVar, UnitPasSave,
  UnitPasSynHighlighter, UnitPasReserveWords, UnitFormFindReplace,
  UnitFormAbout, UnitPasStatusBar, UnitPasPageControl, UnitPasSynEdit
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormAbout, FormAbout);
  Application.Run;
end.

