unit Business.Context;

interface

type

  TBusinessContext = record
  public
    class procedure RegisterTypes; static;
  end;

implementation

uses
  Spring.Container,
  Produto.Service, Produto.Service.Impl;

{ TBusinessContext }

class procedure TBusinessContext.RegisterTypes;
begin
  GlobalContainer.RegisterType<IProdutoService, TProdutoService>;

  GlobalContainer.Build;
end;

end.
