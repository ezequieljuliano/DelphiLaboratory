unit Produto.Controller;

interface

uses
  System.SysUtils, System.Classes, System.Rtti, Crud.Controller, Data.DB,
  Spring.Persistence.ObjectDataset.Abstract,
  Spring.Persistence.ObjectDataset, Produto.Resource, Produto.DTO,
  Spring.Container.Common, Spring.Collections;

type

  TProdutoController = class(TCrudController)
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
    procedure RESTDelete; override;
    procedure RESTFindAll; override;
    procedure RESTFindOne(const id: TValue); override;
    procedure RESTInsert; override;
    procedure RESTUpdate; override;
  end;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

{ TProdutoController }

procedure TProdutoController.RESTDelete;
begin
  inherited;
  fResource.Delete(ProdutoId.AsLargeInt);
  Produto.Delete;
end;

procedure TProdutoController.RESTFindAll;
begin
  inherited;
  Produto.Close;
  Produto.DataList := fResource.FindAll as IObjectList;
  Produto.Open;
end;

procedure TProdutoController.RESTFindOne(const id: TValue);
begin
  inherited;
  Produto.Close;
  Produto.DataList := fResource.FindOneAsList(id.AsInt64) as IObjectList;
  Produto.Open;
end;

procedure TProdutoController.RESTInsert;
var
  idGenerated: Int64;
begin
  inherited;
  fResource.Insert(Produto.GetCurrentModel<TProdutoDTO>, idGenerated);

  Produto.Edit;
  ProdutoId.AsLargeInt := idGenerated;
  Produto.Post;
end;

procedure TProdutoController.RESTUpdate;
begin
  inherited;
  fResource.Update(ProdutoId.AsLargeInt, Produto.GetCurrentModel<TProdutoDTO>);
end;

end.
