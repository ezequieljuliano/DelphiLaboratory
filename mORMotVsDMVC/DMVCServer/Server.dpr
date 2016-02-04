program Server;

uses
  Vcl.Forms,
  Main.View in 'Main.View.pas' {MainView},
  REST.Web.Module in 'REST.Web.Module.pas' {RESTWebModule: TWebModule},
  Svr.Service.Controller in 'Svr.Service.Controller.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainView, MainView);
  Application.Run;
end.
