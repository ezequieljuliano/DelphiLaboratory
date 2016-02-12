unit Produto.Controller;

interface

uses
  REST.Controller,
  MVCFramework,
  MVCFramework.Commons,
  Produto, Produto.DTO, Produto.Repository, Produto.Service;

type

  [MVCPath('/produtos')]
  TProdutoController = class(TCrudController<TProduto, TProdutoDTO, Int64, IProdutoRepository, IProdutoService>)
  strict private
    { private declarations }
  strict protected
    { protected declarations }
  public
    { public declarations }
  end;

implementation

initialization

TRESTManager.RegisterController<TProdutoController>;

end.
