unit DAL.Session;

interface

uses
  System.SysUtils,
  Spring.Services,
  Spring.Persistence.Core.Session;

type

  EDALSessionException = class(Exception);

  TDALSession = record
  public
    class function Instance: TSession; static;
  end;

implementation

{ TDALSession }

class function TDALSession.Instance: TSession;
begin
  Result := ServiceLocator.GetService<TSession>;
end;

end.
