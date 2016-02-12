program Client;

uses
  Vcl.Forms,
  Spring.Services,
  Main.View in 'Views\Main.View.pas' {MainView},
  Produto.Resource in 'Resources\Produto.Resource.pas',
  Produto.DTO in '..\Server\REST\DTOs\Produto.DTO.pas',
  Produto.Resource.Impl in 'Resources\Impl\Produto.Resource.Impl.pas',
  Produto.Controller in 'Controllers\Produto.Controller.pas' {ProdutoController: TDataModule},
  Produto.View in 'Views\Produto.View.pas' {ProdutoView},
  Base.Data.Module in '..\Common\Base.Data.Module.pas' {BaseDataModule: TDataModule},
  Base.Controller in 'Core\Template\Base.Controller.pas' {BaseController: TDataModule},
  Base.View in '..\Common\Base.View.pas' {BaseView},
  Base.Client.View in 'Core\Template\Base.Client.View.pas' {BaseClientView},
  Helpful in '..\Common\Helpful.pas',
  Controller.Context in 'Core\Context\Controller.Context.pas',
  REST.Context in 'Core\Context\REST.Context.pas',
  View.Context in 'Core\Context\View.Context.pas',
  Helpful.Exceptions in '..\Common\Helpful.Exceptions.pas',
  Crud.Resource in 'Core\Template\Crud.Resource.pas',
  Crud.Resource.Impl in 'Core\Template\Impl\Crud.Resource.Impl.pas';

{$R *.res}

begin

  ReportMemoryLeaksOnShutdown := True;

  TRESTContext.RegisterTypes;
  TControllerContext.RegisterTypes;
  TViewContext.RegisterTypes;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  ServiceLocator.GetService<TMainView>;

  Application.Run;

end.
