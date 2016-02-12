unit Produto.Converter;

interface

uses
  System.Generics.Collections,
  Spring.Collections,
  REST.Entity.Converter,
  Produto, Produto.DTO;

type

  TProdutoConverter = class(TInterfacedObject, IRESTEntityConverter<TProduto, TProdutoDTO, Int64>)
  public
    function GetAsEntity(source: TProdutoDTO): TProduto;
    function GetAsDTO(source: TProduto): TProdutoDTO;

    function GetAsEntities(source: TObjectList<TProdutoDTO>): IList<TProduto>;
    function GetAsDTOs(source: IList<TProduto>): TObjectList<TProdutoDTO>;

    function GetEntityKeyValue(source: TProduto): Int64;

    procedure UpdateEntity(source: TProdutoDTO; target: TProduto);
    procedure UpdateDTO(source: TProduto; target: TProdutoDTO);
  end;

implementation

{ TProdutoConverter }

function TProdutoConverter.GetAsDTO(source: TProduto): TProdutoDTO;
begin
  Result := TProdutoDTO.Create;
  UpdateDTO(source, Result);
end;

function TProdutoConverter.GetAsDTOs(source: IList<TProduto>): TObjectList<TProdutoDTO>;
var
  entity: TProduto;
begin
  Result := TObjectList<TProdutoDTO>.Create;
  for entity in source do
    Result.Add(GetAsDTO(entity));
end;

function TProdutoConverter.GetAsEntities(source: TObjectList<TProdutoDTO>): IList<TProduto>;
var
  dto: TProdutoDTO;
begin
  Result := TCollections.CreateList<TProduto>;
  for dto in source do
    Result.Add(GetAsEntity(dto));
end;

function TProdutoConverter.GetAsEntity(source: TProdutoDTO): TProduto;
begin
  Result := TProduto.Create;
  UpdateEntity(source, Result);
end;

function TProdutoConverter.GetEntityKeyValue(source: TProduto): Int64;
begin
  Result := source.Id;
end;

procedure TProdutoConverter.UpdateDTO(source: TProduto; target: TProdutoDTO);
begin
  target.Id := source.Id;
  target.Ean := source.Ean;
  target.Descricao := source.Descricao;
  target.Preco := source.Preco;
  target.Custo := source.Custo;
end;

procedure TProdutoConverter.UpdateEntity(source: TProdutoDTO; target: TProduto);
begin
  target.Id := source.Id;
  target.Ean := source.Ean;
  target.Descricao := source.Descricao;
  target.Preco := source.Preco;
  target.Custo := source.Custo;
end;

end.
