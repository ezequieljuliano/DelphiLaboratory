unit Controller.Context;

interface

type

  TControllerContext = record
  public
    class procedure RegisterTypes; static;
  end;

implementation

uses
  Spring.Container,
  Produto.Controller;

{ TControllerContext }

class procedure TControllerContext.RegisterTypes;
begin
  GlobalContainer.RegisterType<TProdutoController>.DelegateTo(
    function: TProdutoController
    begin
      Result := TProdutoController.Create(nil);
    end);

  GlobalContainer.Build;
end;

end.
