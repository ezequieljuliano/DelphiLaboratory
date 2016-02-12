unit REST.Context;

interface

type

  TRESTContext = record
  public
    class procedure RegisterTypes; static;
  end;

implementation

uses
  Spring.Container,
  MVCFramework.RESTClient,
  MVCFramework.Commons,
  Produto.Resource, Produto.Resource.Impl;

{ TRESTContext }

class procedure TRESTContext.RegisterTypes;
begin
  GlobalContainer.RegisterType<TRESTClient>.DelegateTo(
    function: TRESTClient
    begin
      Result := TRESTClient.Create('localhost', 8080);
      Result.Accept(TMVCMediaType.APPLICATION_JSON);
      Result.ContentType(TMVCMediaType.APPLICATION_JSON);
      Result.AcceptCharSet(TMVCCharSet.ISO88591);
      Result.ContentCharSet(TMVCCharSet.ISO88591);
    end);

  GlobalContainer.RegisterType<IProdutoResource, TProdutoResource>;

  GlobalContainer.Build;
end;

end.
