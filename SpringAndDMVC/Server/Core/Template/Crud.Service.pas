unit Crud.Service;

interface

uses
  Spring.Collections,
  Crud.Repository;

type

  ICrudService<TEntity: class, constructor; TKey; IRepository: ICrudRepository<TEntity, TKey>> = interface(IInvokable)
    ['{F858C08A-D5F9-4952-ABB4-1460B13BBD08}']
    function Count: Integer;

    function FindOne(const id: TKey): TEntity;
    function FindAll: IList<TEntity>;

    function Exists(const id: TKey): Boolean;

    procedure Insert(const entity: TEntity); overload;
    procedure Insert(const entities: IEnumerable<TEntity>); overload;

    function Save(const entity: TEntity): TEntity; overload;
    function Save(const entities: IEnumerable<TEntity>): IEnumerable<TEntity>; overload;
    procedure SaveCascade(const entity: TEntity);

    procedure Delete(const entity: TEntity); overload;
    procedure Delete(const entities: IEnumerable<TEntity>); overload;
    procedure DeleteAll;
  end;

implementation

end.
