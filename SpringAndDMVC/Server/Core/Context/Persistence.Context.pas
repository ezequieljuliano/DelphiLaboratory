unit Persistence.Context;

interface

uses
  Spring.Container;

procedure RegisterTypes(const container: TContainer);

implementation

uses
  Spring.Services,
  Spring.Persistence.Core.Interfaces,
  Spring.Persistence.Core.Session,
  Spring.Persistence.Core.Repository.Proxy,
  DAL.Connection,
  Crud.Repository, Crud.Repository.Impl,
  Produto, Produto.Repository,
  Cliente;

procedure RegisterTypes(const container: TContainer);
begin
  container.RegisterType<TDALConnection>.Implements<IDBConnection>.AsSingleton;
  container.RegisterType<TSession>.AsSingleton;

  container.RegisterType<IProdutoRepository>.DelegateTo(
    function: IProdutoRepository
    begin
      Result := TProxyRepository<TProduto, Int64>.Create(
        ServiceLocator.GetService<TSession>, TypeInfo(IProdutoRepository)) as IProdutoRepository;
    end
    );

  container.RegisterType<ICrudRepository<TCliente, Int64>, TCrudRepository<TCliente, Int64>>;

  container.Build;
end;

end.
