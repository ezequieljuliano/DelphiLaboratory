unit Produto.Converter;

interface

uses
  System.Generics.Collections,
  Spring.Collections,
  REST.Converter,
  REST.Converter.Impl,
  Produto, Produto.DTO;

type

  TProdutoConverter = class(TRESTConverter<TProduto, TProdutoDTO, Int64>, IRESTConverter<TProduto, TProdutoDTO, Int64>)
  strict private
    { private declarations }
  strict protected
    { protected declarations }
  public
    { public declarations }
  end;

implementation

end.
