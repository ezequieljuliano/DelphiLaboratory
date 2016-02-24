unit Resource.Context;

interface

uses
  Spring.Container;

procedure RegisterTypes(const container: TContainer);

implementation

uses
  Spring.Services,
  Crud.Resource, Crud.Resource.Impl,
  MVCFramework.RESTClient,
  Produto.Resource, Produto.Resource.Impl,
  Cliente.DTO;

procedure RegisterTypes(const container: TContainer);
begin
  container.RegisterType<IProdutoResource, TProdutoResource>;
  container.RegisterType<ICrudResource<TClienteDTO, Int64>>.DelegateTo(
    function: ICrudResource<TClienteDTO, Int64>
    begin
      Result := TCrudResource<TClienteDTO, Int64>.Create(ServiceLocator.GetService<TRESTClient>);
      Result.Path := '/clientes';
    end
    );

  container.Build;
end;

end.
