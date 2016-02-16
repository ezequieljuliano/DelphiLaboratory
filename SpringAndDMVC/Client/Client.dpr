program Client;

uses
  Vcl.Forms,
  Spring.Container,
  Spring.Services,
  Main.View in 'Views\Main.View.pas' {MainView} ,
  Produto.Resource in 'Resources\Produto.Resource.pas',
  Produto.DTO in '..\Server\REST\DTOs\Produto.DTO.pas',
  Produto.Resource.Impl in 'Resources\Impl\Produto.Resource.Impl.pas',
  Produto.Controller in 'Controllers\Produto.Controller.pas' {ProdutoController: TDataModule} ,
  Produto.View in 'Views\Produto.View.pas' {ProdutoView} ,
  Base.Data.Module in '..\Common\Base.Data.Module.pas' {BaseDataModule: TDataModule} ,
  Base.Controller in 'Core\Template\Base.Controller.pas' {BaseController: TDataModule} ,
  Base.View in '..\Common\Base.View.pas' {BaseView} ,
  Base.Client.View in 'Core\Template\Base.Client.View.pas' {BaseClientView} ,
  Controller.Context in 'Core\Context\Controller.Context.pas',
  REST.Context in 'Core\Context\REST.Context.pas',
  View.Context in 'Core\Context\View.Context.pas',
  App.Exceptions in '..\Common\App.Exceptions.pas',
  Crud.Resource in 'Core\Template\Crud.Resource.pas',
  Crud.Resource.Impl in 'Core\Template\Impl\Crud.Resource.Impl.pas',
  App.Core in '..\Common\App.Core.pas',
  App.Core.Impl in '..\Common\Impl\App.Core.Impl.pas',
  Crud.Controller in 'Core\Template\Crud.Controller.pas' {CrudController: TDataModule};

{$R *.res}

begin

  ReportMemoryLeaksOnShutdown := True;

  REST.Context.RegisterTypes(GlobalContainer);
  Controller.Context.RegisterTypes(GlobalContainer);
  View.Context.RegisterTypes(GlobalContainer);

  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  ServiceLocator.GetService<TMainView>;

  Application.Run;

end.
