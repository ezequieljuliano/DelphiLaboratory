unit Crud.Repository.Impl;

interface

uses
  Spring.Persistence.Core.Repository.Simple,
  Crud.Repository;

type

  TCrudRepository<TEntity: class, constructor; TKey> = class(TSimpleRepository<TEntity, TKey>, ICrudRepository<TEntity, TKey>)
  strict private
    { private declarations }
  strict protected
    { protected declarations }
  public
    { public declarations }
  end;

implementation

end.
