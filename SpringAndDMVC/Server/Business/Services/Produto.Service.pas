unit Produto.Service;

interface

uses
  Crud.Service,
  Produto, Produto.Repository;

type

  IProdutoService = interface(ICrudService<TProduto, Int64, IProdutoRepository>)
    ['{EBEE8375-4F98-4525-9352-4CE029BF91C7}']
  end;

implementation

end.
