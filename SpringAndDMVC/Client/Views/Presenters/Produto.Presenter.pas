unit Produto.Presenter;

interface

uses
  System.SysUtils, System.Classes, System.Rtti, Crud.Presenter, Data.DB,
  Spring.Persistence.ObjectDataset.Abstract,
  Spring.Persistence.ObjectDataset, Produto.Resource, Produto.DTO,
  Spring.Container.Common, Spring.Collections;

type

  TProdutoPresenter = class(TCrudPresenter)
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

{ TProdutoPresenter }

procedure TProdutoPresenter.RESTDelete;
begin
  inherited;
  fResource.Delete(ProdutoId.AsLargeInt);
  Produto.Delete;
end;

procedure TProdutoPresenter.RESTFindAll;
begin
  inherited;
  Produto.Close;
  Produto.DataList := fResource.FindAll as IObjectList;
  Produto.Open;
end;

procedure TProdutoPresenter.RESTFindOne(const id: TValue);
begin
  inherited;
  Produto.Close;
  Produto.DataList := fResource.FindOneAsList(id.AsInt64) as IObjectList;
  Produto.Open;
end;

procedure TProdutoPresenter.RESTInsert;
var
  idGenerated: Int64;
begin
  inherited;
  fResource.Insert(Produto.GetCurrentModel<TProdutoDTO>, idGenerated);

  Produto.Edit;
  ProdutoId.AsLargeInt := idGenerated;
  Produto.Post;
end;

procedure TProdutoPresenter.RESTUpdate;
begin
  inherited;
  fResource.Update(ProdutoId.AsLargeInt, Produto.GetCurrentModel<TProdutoDTO>);
end;

end.
