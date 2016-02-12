unit DAL.Connection;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Base.Data.Module,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  FireDAC.VCLUI.Wait, FireDAC.Comp.UI, FireDAC.Phys.IBBase,
  FireDAC.Comp.Client,
  Spring.Persistence.Core.Interfaces,
  Spring.Persistence.Adapters.FireDAC,
  Spring.Persistence.SQL.Interfaces;

type

  EDALConnectionException = class(Exception);

  TDALConnection = class(TBaseDataModule)
    FDConnection: TFDConnection;
    FDPhysFBDriverLink: TFDPhysFBDriverLink;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    procedure DataModuleCreate(Sender: TObject);
  strict private
    fConnection: IDBConnection;
    procedure Build;
  public
    property Connection: IDBConnection read fConnection;
  end;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

{ TDALConnection }

procedure TDALConnection.Build;
begin
  fConnection := TFireDACConnectionAdapter.Create(FDConnection);
  fConnection.AutoFreeConnection := False;
  fConnection.Connect;
end;

procedure TDALConnection.DataModuleCreate(Sender: TObject);
begin
  inherited;
  Build;
end;

end.
