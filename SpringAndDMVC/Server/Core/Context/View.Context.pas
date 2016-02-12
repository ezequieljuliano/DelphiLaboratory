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
  Main.View;

{ TViewContext }

class procedure TViewContext.RegisterTypes;
begin
  GlobalContainer.RegisterType<TMainView>.DelegateTo(
    function: TMainView
    begin
      Application.CreateForm(TMainView, Result);
    end).AsSingleton;

  GlobalContainer.Build;
end;

end.
