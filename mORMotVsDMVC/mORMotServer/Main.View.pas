unit Main.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,

  mORMot, mORMotHttpServer;

type

  TMainView = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    fServiceModel: TSQLModel;
    fRestServer: TSQLRestServerFullMemory;
    fServerHttp: TSQLHttpServer;
  public
    { Public declarations }
  end;

var
  MainView: TMainView;

implementation

uses
  Svr.Service, Svr.Service.Impl;

{$R *.dfm}

procedure TMainView.FormCreate(Sender: TObject);
begin
  fServiceModel := TSQLModel.Create([], 'services');
  fRestServer := TSQLRestServerFullMemory.Create(fServiceModel);
  fRestServer.ServiceRegister(TSvrService, [TypeInfo(ISvrService)], sicShared);
  fServerHttp := TSQLHttpServer.Create('8080', [fRestServer]);
end;

procedure TMainView.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fServerHttp);
  FreeAndNil(fRestServer);
  FreeAndNil(fServiceModel);
end;

end.
