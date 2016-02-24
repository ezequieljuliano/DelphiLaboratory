unit REST.Context;

interface

uses
  Spring.Container;

procedure RegisterTypes(const container: TContainer);

implementation

uses
  REST.Standalone.Server,
  REST.Container, REST.Container.Impl,
  REST.Converter, REST.Converter.Impl,
  Produto, Produto.DTO, Produto.Converter, Produto.Controller,
  Cliente, Cliente.DTO, Cliente.Controller;

procedure RegisterTypes(const container: TContainer);
begin
  container.RegisterType<TRESTStandaloneServer>.AsSingleton;
  container.RegisterType<IRESTContainer, TRESTContainer>.AsSingleton;

  container.RegisterType<IRESTConverter<TProduto, TProdutoDTO, Int64>, TProdutoConverter>;
  container.RegisterType<IRESTConverter<TCliente, TClienteDTO, Int64>, TRESTConverter<TCliente, TClienteDTO, Int64>>;

  container.RegisterType<TProdutoController>;
  container.RegisterType<TClienteController>;

  container.Build;
end;

end.
