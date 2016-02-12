unit Persistence.Context;

interface

type

  TPersistenceContext = record
  public
    class procedure RegisterTypes; static;
  end;

implementation

uses
  Spring.Container,
  Spring.Services,
  Spring.Persistence.Core.Session,
  Spring.Persistence.Core.Repository.Proxy,
  DAL.Connection,
  Produto, Produto.Repository;

{ TPersistenceContext }

class procedure TPersistenceContext.RegisterTypes;
begin
  GlobalContainer.RegisterType<TDALConnection>.DelegateTo(
    function: TDALConnection
    begin
      Result := TDALConnection.Create(nil);
    end).AsSingleton;

  GlobalContainer.RegisterType<TSession>.DelegateTo(
    function: TSession
    begin
      Result := TSession.Create(ServiceLocator.GetService<TDALConnection>.Connection);
    end).AsSingleton;

  GlobalContainer.RegisterType<IProdutoRepository>.DelegateTo(
    function: IProdutoRepository
    begin
      Result := TProxyRepository<TProduto, Int64>.Create(
        ServiceLocator.GetService<TSession>, TypeInfo(IProdutoRepository)) as IProdutoRepository;
    end
    );

  GlobalContainer.Build;
end;

end.
