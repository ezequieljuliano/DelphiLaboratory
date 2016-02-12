unit Crud.Service.Impl;

interface

uses
  Spring.Collections,
  Crud.Repository,
  Crud.Service;

type

  TCrudService<TEntity: class, constructor; TKey; IRepository: ICrudRepository<TEntity, TKey>> = class(TInterfacedObject, ICrudService<TEntity, TKey, IRepository>)
  strict private
    fRepository: IRepository;
    fNamespace: string;
  strict protected
    function GetNamespaceFromType: string; virtual;

    function Count: Integer; virtual;

    function FindOne(const id: TKey): TEntity; virtual;
    function FindAll: IList<TEntity>; virtual;

    function Exists(const id: TKey): Boolean; virtual;

    procedure Insert(const entity: TEntity); overload; virtual;
    procedure Insert(const entities: IEnumerable<TEntity>); overload; virtual;

    function Save(const entity: TEntity): TEntity; overload; virtual;
    function Save(const entities: IEnumerable<TEntity>): IEnumerable<TEntity>; overload; virtual;
    procedure SaveCascade(const entity: TEntity);

    procedure Delete(const entity: TEntity); overload; virtual;
    procedure Delete(const entities: IEnumerable<TEntity>); overload; virtual;
    procedure DeleteAll; virtual;
  public
    constructor Create(const repository: IRepository); virtual;

    property Namespace: string read fNamespace;
  end;


implementation

uses
  Spring,
  Spring.Persistence.Core.EntityCache,
  Spring.Persistence.Mapping.Attributes;

{ TCrudService<TEntity, TKey, IRepository> }

function TCrudService<TEntity, TKey, IRepository>.Count: Integer;
begin
  Result := fRepository.Count;
end;

constructor TCrudService<TEntity, TKey, IRepository>.Create(const repository: IRepository);
begin
  inherited Create;
  fRepository := repository;
  fNamespace := GetNamespaceFromType;
end;

procedure TCrudService<TEntity, TKey, IRepository>.Delete(const entities: IEnumerable<TEntity>);
begin
  fRepository.Delete(entities);
end;

procedure TCrudService<TEntity, TKey, IRepository>.Delete(const entity: TEntity);
begin
  fRepository.Delete(entity);
end;

procedure TCrudService<TEntity, TKey, IRepository>.DeleteAll;
begin
  fRepository.DeleteAll;
end;

function TCrudService<TEntity, TKey, IRepository>.Exists(const id: TKey): Boolean;
begin
  Result := fRepository.Exists(id);
end;

function TCrudService<TEntity, TKey, IRepository>.FindAll: IList<TEntity>;
begin
  Result := fRepository.FindAll;
end;

function TCrudService<TEntity, TKey, IRepository>.FindOne(const id: TKey): TEntity;
begin
  Result := fRepository.FindOne(id);
end;

function TCrudService<TEntity, TKey, IRepository>.GetNamespaceFromType: string;
var
  table: TableAttribute;
begin
  table := TEntityCache.Get(TEntity).EntityTable;
  if Assigned(table) then
    Exit(table.Namespace);
  Result := '';
end;


procedure TCrudService<TEntity, TKey, IRepository>.Insert(const entities: IEnumerable<TEntity>);
begin
  fRepository.Insert(entities);
end;

procedure TCrudService<TEntity, TKey, IRepository>.Insert(const entity: TEntity);
begin
  fRepository.Insert(entity);
end;

function TCrudService<TEntity, TKey, IRepository>.Save(const entity: TEntity): TEntity;
begin
  Result := fRepository.Save(entity);
end;

function TCrudService<TEntity, TKey, IRepository>.Save(const entities: IEnumerable<TEntity>): IEnumerable<TEntity>;
begin
  Result := fRepository.Save(entities);
end;

procedure TCrudService<TEntity, TKey, IRepository>.SaveCascade(const entity: TEntity);
begin
  fRepository.SaveCascade(entity);
end;


end.
