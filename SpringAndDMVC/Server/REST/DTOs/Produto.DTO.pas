unit Produto.DTO;

interface

type

  TProdutoDTO = class
  strict private
    fId: Int64;
    fEan: string;
    fDescricao: string;
    fPreco: Currency;
    fCusto: Currency;
  public
    property Id: Int64 read fId write fId;
    property Ean: string read fEan write fEan;
    property Descricao: string read fDescricao write fDescricao;
    property Preco: Currency read fPreco write fPreco;
    property Custo: Currency read fCusto write fCusto;
  end;

implementation

end.
