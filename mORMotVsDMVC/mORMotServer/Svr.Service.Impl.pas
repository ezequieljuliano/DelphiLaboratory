unit Svr.Service.Impl;

interface

uses
  Svr.Service;

type

  TSvrService = class(TInterfacedObject, ISvrService)
  public
    function GetMethod(): string;
  end;

implementation

{ TSvrService }

function TSvrService.GetMethod: string;
begin
  Result := 'GET';
end;

end.
