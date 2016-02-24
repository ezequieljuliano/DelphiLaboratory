unit Produto.Resource;

interface

uses
  Crud.Resource,
  Produto.DTO;

type

  IProdutoResource = interface(ICrudResource<TProdutoDTO, Int64>)
    ['{F4ABD605-280D-4319-B664-2C7D105E9688}']
  end;

implementation

end.
