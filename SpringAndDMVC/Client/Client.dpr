program Client;

uses
  Vcl.Forms,
  Spring.Container,
  Spring.Services,
  Main.View in 'Views\Main.View.pas' {MainView} ,
  Produto.DTO in '..\Server\REST\DTOs\Produto.DTO.pas',
  Produto.View in 'Views\Produto.View.pas' {ProdutoView} ,
  Base.Data.Module in '..\Common\Base.Data.Module.pas' {BaseDataModule: TDataModule} ,
  Base.Presenter in 'Core\Template\Base.Presenter.pas' {BasePresenter: TDataModule} ,
  Base.View in '..\Common\Base.View.pas' {BaseView} ,
  Base.Client.View in 'Core\Template\Base.Client.View.pas' {BaseClientView} ,
  Presenter.Context in 'Core\Context\Presenter.Context.pas',
  REST.Context in 'Core\Context\REST.Context.pas',
  View.Context in 'Core\Context\View.Context.pas',
  App.Exceptions in '..\Common\App.Exceptions.pas',
  Crud.Resource in 'Core\Template\Crud.Resource.pas',
  Crud.Resource.Impl in 'Core\Template\Impl\Crud.Resource.Impl.pas',
  App.Core in '..\Common\App.Core.pas',
  App.Core.Impl in '..\Common\Impl\App.Core.Impl.pas',
  Crud.Presenter in 'Core\Template\Crud.Presenter.pas' {CrudPresenter: TDataModule} ,
  Produto.Presenter in 'Views\Presenters\Produto.Presenter.pas' {ProdutoPresenter: TDataModule} ,
  Produto.Resource in 'RESTClient\Resources\Produto.Resource.pas',
  Produto.Resource.Impl in 'RESTClient\Resources\Impl\Produto.Resource.Impl.pas';

{$R *.res}

begin

  ReportMemoryLeaksOnShutdown := True;

  REST.Context.RegisterTypes(GlobalContainer);
  Presenter.Context.RegisterTypes(GlobalContainer);
  View.Context.RegisterTypes(GlobalContainer);

  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  ServiceLocator.GetService<TMainView>;

  Application.Run;

end.
