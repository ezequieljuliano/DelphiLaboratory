unit Produto.Repository;

interface

uses
  Crud.Repository,
  Produto;

type

  IProdutoRepository = interface(ICrudRepository<TProduto, Int64>)
    ['{6336BBDF-CDB6-42FB-BFDF-A372A44B27A7}']
  end;

implementation

end.
