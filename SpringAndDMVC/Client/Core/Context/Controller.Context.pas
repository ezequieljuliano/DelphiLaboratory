unit Controller.Context;

interface

uses
  Spring.Container;

procedure RegisterTypes(const container: TContainer);

implementation

uses
  Produto.Controller;

procedure RegisterTypes(const container: TContainer);
begin
  container.RegisterType<TProdutoController>;

  container.Build;
end;

end.
