unit Produto.Service.Impl;

interface

uses
  Crud.Service.Impl,
  Produto, Produto.Repository, Produto.Service;

type

  TProdutoService = class(TCrudService<TProduto, Int64, IProdutoRepository>, IProdutoService)
  strict private
    { private declarations }
  strict protected
    { protected declarations }
  public
    { public declarations }
  end;

implementation

end.
