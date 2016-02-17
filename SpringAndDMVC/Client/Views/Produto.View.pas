unit Produto.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Base.Client.View, Produto.Presenter, Spring.Container.Common,
  Data.DB, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, Base.View,
  Vcl.StdCtrls;

type

  TProdutoView = class(TBaseClientView)
    ProdutoSrc: TDataSource;
    DBNavigator1: TDBNavigator;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    [Inject]
    fPresenter: TProdutoPresenter;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TProdutoView.Button1Click(Sender: TObject);
var
  id: Int64;
begin
  inherited;
  try
    id := StrToInt64Def(InputBox('Id', 'Id', ''), 0);
    fPresenter.RESTFindOne(id);
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure TProdutoView.Button2Click(Sender: TObject);
begin
  inherited;
  try
    fPresenter.RESTUpdate;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure TProdutoView.Button3Click(Sender: TObject);
begin
  inherited;
  try
    fPresenter.RESTInsert;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure TProdutoView.Button4Click(Sender: TObject);
begin
  inherited;
  try
    fPresenter.RESTDelete;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure TProdutoView.FormDestroy(Sender: TObject);
begin
  inherited;
  fPresenter.Free;
end;

procedure TProdutoView.FormShow(Sender: TObject);
begin
  inherited;
  fPresenter.RESTFindAll;
  ProdutoSrc.DataSet := fPresenter.Produto;
end;

end.
