unit Main.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TMainView = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainView: TMainView;

implementation

uses
  MVCFramework.Server,
  REST.Web.Module;

{$R *.dfm}

procedure TMainView.FormCreate(Sender: TObject);
var
  serverInfo: IMVCServerInfo;
begin
  serverInfo := TMVCServerInfoFactory.Build();
  serverInfo.ServerName := 'RESTServer';
  serverInfo.Port := 8080;
  serverInfo.MaxConnections := 1024;
  serverInfo.WebModuleClass := RESTWebModuleClass;

  MVCServerDefault.Container.CreateServer(serverInfo);
  MVCServerDefault.Container.StartServers;
end;

procedure TMainView.FormDestroy(Sender: TObject);
begin
  MVCServerDefault.Container.StopServers;
end;

end.
