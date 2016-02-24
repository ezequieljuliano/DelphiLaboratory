program Client;

uses
  Vcl.Forms,
  Spring.Container,
  Spring.Services,
  Main.View in 'Views\Main.View.pas' {MainView},
  Produto.DTO in '..\Server\REST\DTOs\Produto.DTO.pas',
  Produto.View in 'Views\Produto.View.pas' {ProdutoView},
  Base.Data.Module in '..\Common\Base.Data.Module.pas' {BaseDataModule: TDataModule},
  Base.Model in 'Core\Template\Base.Model.pas' {BaseModel: TDataModule},
  Base.View in '..\Common\Base.View.pas' {BaseView},
  Base.Client.View in 'Core\Template\Base.Client.View.pas' {BaseClientView},
  Model.Context in 'Core\Context\Model.Context.pas',
  RESTClient.Context in 'Core\Context\RESTClient.Context.pas',
  View.Context in 'Core\Context\View.Context.pas',
  App.Exceptions in '..\Common\App.Exceptions.pas',
  Crud.Resource in 'Core\Template\Crud.Resource.pas',
  Crud.Resource.Impl in 'Core\Template\Impl\Crud.Resource.Impl.pas',
  App.Core in '..\Common\App.Core.pas',
  App.Core.Impl in '..\Common\Impl\App.Core.Impl.pas',
  Crud.Model in 'Core\Template\Crud.Model.pas' {CrudModel: TDataModule},
  Produto.Model in 'Models\Produto.Model.pas' {ProdutoModel: TDataModule},
  Produto.Resource in 'Resources\Produto.Resource.pas',
  Produto.Resource.Impl in 'Resources\Impl\Produto.Resource.Impl.pas',
  Resource.Context in 'Core\Context\Resource.Context.pas',
  Cliente.DTO in '..\Server\REST\DTOs\Cliente.DTO.pas',
  Cliente.Model in 'Models\Cliente.Model.pas' {ClienteModel: TDataModule},
  Cliente.View in 'Views\Cliente.View.pas' {ClienteView};

{$R *.res}

begin

  ReportMemoryLeaksOnShutdown := True;

  RESTClient.Context.RegisterTypes(GlobalContainer);
  Resource.Context.RegisterTypes(GlobalContainer);
  Model.Context.RegisterTypes(GlobalContainer);
  View.Context.RegisterTypes(GlobalContainer);

  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  ServiceLocator.GetService<TMainView>;

  Application.Run;

end.
