unit Business.Context;

interface

uses
  Spring.Container;

procedure RegisterTypes(const container: TContainer);

implementation

uses
  Crud.Service, Crud.Service.Impl, Crud.Repository,
  Produto.Service, Produto.Service.Impl,
  Cliente;

procedure RegisterTypes(const container: TContainer);
begin
  container.RegisterType<IProdutoService, TProdutoService>;
  container.RegisterType<ICrudService<TCliente, Int64, ICrudRepository<TCliente, Int64>>, TCrudService<TCliente, Int64, ICrudRepository<TCliente, Int64>>>;

  container.Build;
end;

end.
