unit Produto.Model;

interface

uses
  System.SysUtils, System.Classes, System.Rtti, Crud.Model, Data.DB,
  Spring.Persistence.ObjectDataset.Abstract,
  Spring.Persistence.ObjectDataset, Produto.Resource, Produto.DTO,
  Spring.Container.Common, Spring.Collections;

type

  TProdutoModel = class(TCrudModel)
    Produto: TObjectDataset;
    ProdutoId: TLargeintField;
    ProdutoEan: TWideStringField;
    ProdutoDescricao: TWideStringField;
    ProdutoPreco: TCurrencyField;
    ProdutoCusto: TCurrencyField;
  private
    [Inject]
    fResource: IProdutoResource;
  public
    procedure ApplyDelete; override;
    procedure ApplyFindAll; override;
    procedure ApplyFindOne(const id: TValue); override;
    procedure ApplyInsert; override;
    procedure ApplyUpdate; override;
  end;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

{ TProdutoModel }

procedure TProdutoModel.ApplyDelete;
begin
  inherited;
  Delete<TProdutoDTO, Int64>(fResource, Produto, ProdutoId.AsLargeInt);
end;

procedure TProdutoModel.ApplyFindAll;
begin
  inherited;
  FindAll<TProdutoDTO, Int64>(fResource, Produto);
end;

procedure TProdutoModel.ApplyFindOne(const id: TValue);
begin
  inherited;
  FindOne<TProdutoDTO, Int64>(fResource, Produto, id.AsInt64);
end;

procedure TProdutoModel.ApplyInsert;
begin
  inherited;
  Insert<TProdutoDTO, Int64>(fResource, Produto, ProdutoId);
end;

procedure TProdutoModel.ApplyUpdate;
begin
  inherited;
  Update<TProdutoDTO, Int64>(fResource, Produto, ProdutoId.AsLargeInt);
end;

end.
