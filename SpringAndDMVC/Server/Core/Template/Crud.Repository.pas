unit Crud.Repository;

interface

uses
  Spring.Persistence.Core.Interfaces;

type

  ICrudRepository<TEntity: class, constructor; TKey> = interface(IPagedRepository<TEntity, TKey>)
    ['{C9D40D3E-56AB-49FA-A5F3-40E27A1061CF}']
  end;

implementation

end.
