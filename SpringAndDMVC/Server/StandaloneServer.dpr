program StandaloneServer;

uses
  Vcl.Forms,
  Spring.Services,
  Main.View in 'Views\Main.View.pas' {MainView},
  DAL.Connection in 'Persistence\DAL.Connection.pas' {DALConnection: TDataModule},
  DAL.Session in 'Persistence\DAL.Session.pas',
  REST.Controller in 'REST\REST.Controller.pas',
  REST.Standalone.Server in 'REST\REST.Standalone.Server.pas' {RESTStandaloneServer: TDataModule},
  REST.Web.Module in 'REST\REST.Web.Module.pas' {RESTWebModule: TWebModule},
  REST.Entity.Converter in 'REST\REST.Entity.Converter.pas',
  Produto in 'Entities\Produto.pas',
  Produto.Repository in 'Persistence\Repositories\Produto.Repository.pas',
  Produto.Service in 'Business\Services\Produto.Service.pas',
  Produto.Service.Impl in 'Business\Services\Impl\Produto.Service.Impl.pas',
  Produto.Controller in 'REST\Controllers\Produto.Controller.pas',
  Produto.DTO in 'REST\DTOs\Produto.DTO.pas',
  Produto.Converter in 'REST\Converters\Produto.Converter.pas',
  Helpful in '..\Common\Helpful.pas',
  Base.Data.Module in '..\Common\Base.Data.Module.pas' {BaseDataModule: TDataModule},
  Crud.Repository in 'Core\Template\Crud.Repository.pas',
  Crud.Service in 'Core\Template\Crud.Service.pas',
  Crud.Repository.Impl in 'Core\Template\Impl\Crud.Repository.Impl.pas',
  Crud.Service.Impl in 'Core\Template\Impl\Crud.Service.Impl.pas',
  Business.Context in 'Core\Context\Business.Context.pas',
  Persistence.Context in 'Core\Context\Persistence.Context.pas',
  REST.Context in 'Core\Context\REST.Context.pas',
  View.Context in 'Core\Context\View.Context.pas',
  Helpful.Exceptions in '..\Common\Helpful.Exceptions.pas';

{$R *.res}

begin

  ReportMemoryLeaksOnShutdown := True;

  TPersistenceContext.RegisterTypes;
  TBusinessContext.RegisterTypes;
  TRESTContext.RegisterTypes;
  TViewContext.RegisterTypes;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  ServiceLocator.GetService<TRESTStandaloneServer>;
  ServiceLocator.GetService<TMainView>;

  Application.Run;

end.
