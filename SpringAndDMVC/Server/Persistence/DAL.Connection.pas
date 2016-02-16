unit DAL.Connection;

interface

uses
  // System and FireDAC
  System.SysUtils, System.Classes, Data.DB, Base.Data.Module,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  FireDAC.VCLUI.Wait, FireDAC.Comp.UI, FireDAC.Phys.IBBase,
  FireDAC.Comp.Client,
  // Spring
  Spring.Collections,
  Spring.Persistence.Core.Interfaces,
  Spring.Persistence.Adapters.FireDAC,
  Spring.Persistence.SQL.Interfaces;

type

  EDALConnectionException = class(Exception);

  TDALConnection = class(TBaseDataModule, IDBConnection)
    FDConnection: TFDConnection;
    FDPhysFBDriverLink: TFDPhysFBDriverLink;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    procedure DataModuleCreate(Sender: TObject);
  strict private
    fAdapter: IDBConnection;
    function GetAutoFreeConnection: Boolean;
    function GetExecutionListeners: IList<TExecutionListenerProc>;
    function GetQueryLanguage: TQueryLanguage;
    procedure SetAutoFreeConnection(value: Boolean);
    procedure SetQueryLanguage(const value: TQueryLanguage);
  public
    procedure Connect;
    procedure Disconnect;

    function IsConnected: Boolean;
    function CreateStatement: IDBStatement;
    function BeginTransaction: IDBTransaction;

    procedure AddExecutionListener(const listenerProc: TExecutionListenerProc);
    procedure ClearExecutionListeners;

    property AutoFreeConnection: Boolean read GetAutoFreeConnection write SetAutoFreeConnection;
    property ExecutionListeners: IList<TExecutionListenerProc> read GetExecutionListeners;
    property QueryLanguage: TQueryLanguage read GetQueryLanguage write SetQueryLanguage;
  end;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

{ TDALConnection }

procedure TDALConnection.AddExecutionListener(
  const listenerProc: TExecutionListenerProc);
begin
  fAdapter.AddExecutionListener(listenerProc);
end;

function TDALConnection.BeginTransaction: IDBTransaction;
begin
  Result := fAdapter.BeginTransaction;
end;

procedure TDALConnection.ClearExecutionListeners;
begin
  fAdapter.ClearExecutionListeners;
end;

procedure TDALConnection.Connect;
begin
  fAdapter.Connect;
end;

function TDALConnection.CreateStatement: IDBStatement;
begin
  Result := fAdapter.CreateStatement;
end;

procedure TDALConnection.DataModuleCreate(Sender: TObject);
begin
  inherited;
  fAdapter := TFireDACConnectionAdapter.Create(FDConnection);
  fAdapter.AutoFreeConnection := False;
  fAdapter.Connect;
end;

procedure TDALConnection.Disconnect;
begin
  fAdapter.Disconnect;
end;

function TDALConnection.GetAutoFreeConnection: Boolean;
begin
  Result := fAdapter.AutoFreeConnection;
end;

function TDALConnection.GetExecutionListeners: IList<TExecutionListenerProc>;
begin
  Result := fAdapter.ExecutionListeners;
end;

function TDALConnection.GetQueryLanguage: TQueryLanguage;
begin
  Result := fAdapter.QueryLanguage;
end;

function TDALConnection.IsConnected: Boolean;
begin
  Result := fAdapter.IsConnected;
end;

procedure TDALConnection.SetAutoFreeConnection(value: Boolean);
begin
  fAdapter.AutoFreeConnection := value;
end;

procedure TDALConnection.SetQueryLanguage(const value: TQueryLanguage);
begin
  fAdapter.QueryLanguage := value;
end;

end.
