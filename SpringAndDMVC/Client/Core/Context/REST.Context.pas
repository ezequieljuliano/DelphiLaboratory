unit REST.Context;

interface

uses
  Spring.Container;

procedure RegisterTypes(const container: TContainer);

implementation

uses
  MVCFramework.RESTClient,
  MVCFramework.Commons,
  Produto.Resource, Produto.Resource.Impl;

procedure RegisterTypes(const container: TContainer);
begin
  container.RegisterType<TRESTClient>.DelegateTo(
    function: TRESTClient
    begin
      Result := TRESTClient.Create('localhost', 8080);
      Result.Accept(TMVCMediaType.APPLICATION_JSON);
      Result.ContentType(TMVCMediaType.APPLICATION_JSON);
      Result.AcceptCharSet(TMVCCharSet.ISO88591);
      Result.ContentCharSet(TMVCCharSet.ISO88591);
    end);

  container.RegisterType<IProdutoResource, TProdutoResource>;

  container.Build;
end;

end.
