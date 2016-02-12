unit Produto.Controller;

interface

uses
  System.SysUtils, System.Classes, Base.Controller, Data.DB,
  Spring.Persistence.ObjectDataset.Abstract,
  Spring.Persistence.ObjectDataset, Produto.Resource, Produto.DTO,
  Spring.Container.Common, Spring.Collections;

type

  TProdutoController = class(TBaseController)
    Produto: TObjectDataset;
    ProdutoId: TLargeintField;
    ProdutoEan: TWideStringField;
    ProdutoDescricao: TWideStringField;
    ProdutoPreco: TCurrencyField;
    ProdutoCusto: TCurrencyField;
    procedure DataModuleDestroy(Sender: TObject);
  private
    [Inject]
    fResource: IProdutoResource;
    fList: IList<TProdutoDTO>;
  public
    procedure LoadAll;

    procedure RESTInsertCurrent;
    procedure RESTUpdateCurrent;
    procedure RESTDeleteCurrent;

    procedure FindById(const id: Int64);
  end;

implementation

uses
  Helpful.Exceptions;

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

{ TProdutoController }

procedure TProdutoController.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  fList := nil;
end;

procedure TProdutoController.RESTDeleteCurrent;
begin
  fResource.Delete(ProdutoId.AsLargeInt);
  Produto.Delete;
end;

procedure TProdutoController.FindById(const id: Int64);
begin
  Produto.Close;
  Produto.DataList := fResource.FindOneAsList(id) as IObjectList;
  Produto.Open;
end;

procedure TProdutoController.RESTInsertCurrent;
var
  idGenerated: Int64;
begin
  fResource.Insert(Produto.GetCurrentModel<TProdutoDTO>, idGenerated);

  Produto.Edit;
  ProdutoId.AsLargeInt := idGenerated;
  Produto.Post;
end;

procedure TProdutoController.LoadAll;
begin
  try
    fList := fResource.FindAll;
  except
    on E: ENoContentException do
      fList := TCollections.CreateList<TProdutoDTO>(True);
    else
      raise;
  end;
  Produto.Close;
  Produto.DataList := fList as IObjectList;
  Produto.Open;
end;

procedure TProdutoController.RESTUpdateCurrent;
begin
  fResource.Update(ProdutoId.AsLargeInt, Produto.GetCurrentModel<TProdutoDTO>);
end;

end.
