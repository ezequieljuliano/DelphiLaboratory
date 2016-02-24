unit Cliente.Controller;

interface

uses
  REST.Controller,
  MVCFramework,
  MVCFramework.Commons,
  Cliente, Cliente.DTO,
  Crud.Repository, Crud.Service;

type

  [MVCPath('/clientes')]
  TClienteController = class(TCrudController<TCliente, TClienteDTO, Int64, ICrudRepository<TCliente, Int64>, ICrudService<TCliente, Int64, ICrudRepository<TCliente, Int64>>>)
  strict private
    { private declarations }
  strict protected
    { protected declarations }
  public
    { public declarations }
  end;

implementation

end.
