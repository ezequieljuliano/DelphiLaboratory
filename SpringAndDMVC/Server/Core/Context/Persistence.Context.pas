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
  Produto, Produto.Repository;

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

  container.Build;
end;

end.
