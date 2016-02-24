unit Cliente.Model;

interface

uses
  System.SysUtils, System.Classes, Crud.Model, System.Rtti, Data.DB,
  Spring.Persistence.ObjectDataset.Abstract,
  Spring.Persistence.ObjectDataset, Cliente.DTO, Crud.Resource,
  Spring.Container.Common, Spring.Collections;

type

  TClienteModel = class(TCrudModel)
    Cliente: TObjectDataset;
    ClienteId: TLargeintField;
    ClienteNome: TWideStringField;
  private
    [Inject]
    fResource: ICrudResource<TClienteDTO, Int64>;
  public
    procedure ApplyDelete; override;
    procedure ApplyFindAll; override;
    procedure ApplyFindOne(const id: TValue); override;
    procedure ApplyInsert; override;
    procedure ApplyUpdate; override;
  end;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

{ TClienteModel }

procedure TClienteModel.ApplyDelete;
begin
  inherited;
  Delete<TClienteDTO, Int64>(fResource, Cliente, ClienteId.AsLargeInt);
end;

procedure TClienteModel.ApplyFindAll;
begin
  inherited;
  FindAll<TClienteDTO, Int64>(fResource, Cliente);
end;

procedure TClienteModel.ApplyFindOne(const id: TValue);
begin
  inherited;
  FindOne<TClienteDTO, Int64>(fResource, Cliente, id.AsInt64);
end;

procedure TClienteModel.ApplyInsert;
begin
  inherited;
  Insert<TClienteDTO, Int64>(fResource, Cliente, ClienteId);
end;

procedure TClienteModel.ApplyUpdate;
begin
  inherited;
  Update<TClienteDTO, Int64>(fResource, Cliente, ClienteId.AsLargeInt);
end;

end.
