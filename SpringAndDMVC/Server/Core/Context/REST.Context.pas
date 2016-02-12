unit REST.Context;

interface

type

  TRESTContext = record
  public
    class procedure RegisterTypes; static;
  end;

implementation

uses
  Vcl.Forms,
  Spring.Container,
  REST.Standalone.Server,
  REST.Entity.Converter,
  Produto, Produto.DTO, Produto.Converter;

{ TRESTContext }

class procedure TRESTContext.RegisterTypes;
begin
  GlobalContainer.RegisterType<TRESTStandaloneServer>.DelegateTo(
    function: TRESTStandaloneServer
    begin
      Application.CreateForm(TRESTStandaloneServer, Result);
    end).AsSingleton;

  GlobalContainer.RegisterType<IRESTEntityConverter<TProduto, TProdutoDTO, Int64>, TProdutoConverter>;

  GlobalContainer.Build;
end;

end.
