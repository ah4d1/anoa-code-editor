program AnoaSyntaxEditor;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, UnitFormMain, UnitPasTools, UnitPasLang, UnitPasVar,
  UnitPasSynHighlighter, UnitPasReserveWords, UnitFormFindReplace,
  UnitFormAbout, uc_pagecontrol, uc_synedit,
  uc_tabsheet, uc_syncompletion, uc_statusbar, uc_main;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormAbout, FormAbout);
  Application.Run;
end.

