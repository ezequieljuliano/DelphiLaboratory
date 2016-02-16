unit REST.Context;

interface

uses
  Spring.Container;

procedure RegisterTypes(const container: TContainer);

implementation

uses
  REST.Standalone.Server,
  REST.Entity.Converter,
  Produto, Produto.DTO, Produto.Converter;

procedure RegisterTypes(const container: TContainer);
begin
  container.RegisterType<TRESTStandaloneServer>.AsSingleton;

  container.RegisterType<IRESTEntityConverter<TProduto, TProdutoDTO, Int64>, TProdutoConverter>;

  container.Build;
end;

end.
