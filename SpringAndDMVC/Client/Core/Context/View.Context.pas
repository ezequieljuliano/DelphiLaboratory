unit View.Context;

interface

uses
  Spring.Container;

procedure RegisterTypes(const container: TContainer);

implementation

uses
  Vcl.Forms,
  Main.View,
  Produto.View,
  Cliente.View;

procedure RegisterTypes(const container: TContainer);
begin
  container.RegisterType<TMainView>.DelegateTo(
    function: TMainView
    begin
      Application.CreateForm(TMainView, Result);
    end).AsSingleton;

  container.RegisterType<TProdutoView>.DelegateTo(
    function: TProdutoView
    begin
      Application.CreateForm(TProdutoView, Result);
    end);

  container.RegisterType<TClienteView>.DelegateTo(
    function: TClienteView
    begin
      Application.CreateForm(TClienteView, Result);
    end);

  container.Build;
end;

end.
