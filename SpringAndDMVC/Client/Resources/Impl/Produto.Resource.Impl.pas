unit Produto.Resource.Impl;

interface

uses
  Crud.Resource.Impl,
  Produto.Resource, Produto.DTO;

type

  [Path('/produtos')]
  TProdutoResource = class(TCrudResource<TProdutoDTO, Int64>, IProdutoResource)
  strict private
    { private declarations }
  strict protected
    { protected declarations }
  public
    { public declarations }
  end;

implementation

end.
