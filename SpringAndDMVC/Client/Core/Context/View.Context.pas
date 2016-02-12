unit View.Context;

interface

type

  TViewContext = record
  public
    class procedure RegisterTypes; static;
  end;

implementation

uses
  Vcl.Forms,
  Spring.Container,
  Main.View,
  Produto.View;

{ TViewContext }

class procedure TViewContext.RegisterTypes;
begin
  GlobalContainer.RegisterType<TMainView>.DelegateTo(
    function: TMainView
    begin
      Application.CreateForm(TMainView, Result);
    end).AsSingleton;

  GlobalContainer.RegisterType<TProdutoView>.DelegateTo(
    function: TProdutoView
    begin
      Application.CreateForm(TProdutoView, Result);
    end);

  GlobalContainer.Build;
end;

end.
