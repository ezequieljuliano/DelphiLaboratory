unit Main.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus, Spring.Services;

type

  TMainView = class(TForm)
    MainMenu: TMainMenu;
    Cadastros1: TMenuItem;
    Produtos1: TMenuItem;
    Clientes1: TMenuItem;
    procedure Produtos1Click(Sender: TObject);
    procedure Clientes1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  Produto.View, Cliente.View;

{$R *.dfm}

procedure TMainView.Clientes1Click(Sender: TObject);
var
  clienteView: TClienteView;
begin
  clienteView := ServiceLocator.GetService<TClienteView>;
  try
    clienteView.ShowModal;
  finally
    clienteView.Free;
  end;
end;

procedure TMainView.Produtos1Click(Sender: TObject);
var
  produtoView: TProdutoView;
begin
  produtoView := ServiceLocator.GetService<TProdutoView>;
  try
    produtoView.ShowModal;
  finally
    produtoView.Free;
  end;
end;

end.
