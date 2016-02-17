unit Presenter.Context;

interface

uses
  Spring.Container;

procedure RegisterTypes(const container: TContainer);

implementation

uses
  Produto.Presenter;

procedure RegisterTypes(const container: TContainer);
begin
  container.RegisterType<TProdutoPresenter>;

  container.Build;
end;

end.
