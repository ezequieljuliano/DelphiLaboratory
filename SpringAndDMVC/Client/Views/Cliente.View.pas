unit Cliente.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Base.Client.View, Spring.Container.Common, Cliente.Model,
  Data.DB, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls;

type

  TClienteView = class(TBaseClientView)
    DBNavigator1: TDBNavigator;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    ClienteSource: TDataSource;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    [Inject]
    fModel: TClienteModel;
  public
    { Public declarations }
  end;

implementation


{$R *.dfm}

procedure TClienteView.Button1Click(Sender: TObject);
var
  id: Int64;
begin
  inherited;
  try
    id := StrToInt64Def(InputBox('Id', 'Id', ''), 0);
    fModel.ApplyFindOne(id);
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure TClienteView.Button2Click(Sender: TObject);
begin
  inherited;
  try
    fModel.ApplyUpdate;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure TClienteView.Button3Click(Sender: TObject);
begin
  inherited;
  try
    fModel.ApplyInsert;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure TClienteView.Button4Click(Sender: TObject);
begin
  inherited;
  try
    fModel.ApplyDelete;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure TClienteView.FormDestroy(Sender: TObject);
begin
  inherited;
  fModel.Free;
end;

procedure TClienteView.FormShow(Sender: TObject);
begin
  inherited;
  fModel.ApplyFindAll;
  ClienteSource.DataSet := fModel.Cliente;
end;

end.
