program Server;

uses
  Vcl.Forms,
  Main.View in 'Main.View.pas' {MainView} ,
  Svr.Service in 'Svr.Service.pas',
  Svr.Service.Impl in 'Svr.Service.Impl.pas';

{$R *.res}

begin

  ReportMemoryLeaksOnShutdown := True;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainView, MainView);
  Application.Run;

end.
