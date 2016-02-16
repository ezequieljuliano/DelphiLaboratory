unit REST.Standalone.Server;

interface

uses
  System.SysUtils, System.Classes, Base.Data.Module;

type

  TRESTStandaloneServer = class(TBaseDataModule)
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  MVCFramework.Server,
  REST.Web.Module;

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

procedure TRESTStandaloneServer.DataModuleCreate(Sender: TObject);
var
  serverInfo: IMVCServerInfo;
begin
  inherited;
  serverInfo := TMVCServerInfoFactory.Build;
  serverInfo.ServerName := 'RESTStandaloneServer';
  serverInfo.Port := 8080;
  serverInfo.MaxConnections := 1024;
  serverInfo.WebModuleClass := RESTWebModuleClass;

  MVCServerDefault.Container.CreateServer(serverInfo);
  MVCServerDefault.Container.StartServers;
end;

end.
