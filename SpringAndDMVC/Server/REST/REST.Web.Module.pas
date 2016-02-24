unit REST.Web.Module;

interface

uses
  System.Classes,
  System.Generics.Collections,
  Web.HTTPApp,
  MVCFramework,
  MVCFramework.Commons,
  Spring.Services;

type

  TRESTWebModule = class(TWebModule)
    procedure WebModuleCreate(Sender: TObject);
    procedure WebModuleDestroy(Sender: TObject);
  strict private
    fEngine: TMVCEngine;
    procedure RegisterControllers;
  public
    { Public declarations }
  end;

var
  RESTWebModuleClass: TComponentClass = TRESTWebModule;

implementation

uses
  REST.Controller,
  REST.Container;

{$R *.dfm}

procedure TRESTWebModule.RegisterControllers;
var
  container: IRESTContainer;
begin
  container := ServiceLocator.GetService<IRESTContainer>;
  container.Controllers.ForEach(
    procedure(const controller: TPair<string, TRESTControllerClass>)
    begin
      fEngine.AddController(controller.Value);
    end
    );
end;

procedure TRESTWebModule.WebModuleCreate(Sender: TObject);
begin
  fEngine := TMVCEngine.Create(Self);
  fEngine.Config[TMVCConfigKey.SessionTimeout] := '30';
  fEngine.Config[TMVCConfigKey.DefaultContentType] := TMVCMediaType.APPLICATION_JSON;
  fEngine.Config[TMVCConfigKey.DefaultContentCharset] := TMVCCharSet.ISO88591;
  RegisterControllers;
end;

procedure TRESTWebModule.WebModuleDestroy(Sender: TObject);
begin
  fEngine.Free;
end;

end.
