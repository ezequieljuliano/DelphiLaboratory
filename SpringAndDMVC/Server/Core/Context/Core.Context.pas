unit Core.Context;

interface

uses
  Spring.Container;

procedure RegisterTypes(const container: TContainer);

implementation

uses
  App.Core, App.Core.Impl;

procedure RegisterTypes(const container: TContainer);
begin
  container.RegisterType<ICriticalSection, TAppCriticalSection>.AsSingleton;

  container.Build;
end;

end.
