unit Model.Context;

interface

uses
  Spring.Container;

procedure RegisterTypes(const container: TContainer);

implementation

uses
  Produto.Model,
  Cliente.Model;

procedure RegisterTypes(const container: TContainer);
begin
  container.RegisterType<TProdutoModel>;
  container.RegisterType<TClienteModel>;

  container.Build;
end;

end.
