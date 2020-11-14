program AnoaCodeEditor;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, lazcontrols, uf_main, up_lang, up_var,
  uf_findreplace, uf_about, uc_pagecontrol,
  uc_tabsheet, uc_syncompletion, uc_statusbar, uc_main, up_currentdata,
  uc_memoresult, up_runcommand, up_theme;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Title:='Anoa-Code-Editor';
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormAbout, FormAbout);
  Application.Run;
end.

