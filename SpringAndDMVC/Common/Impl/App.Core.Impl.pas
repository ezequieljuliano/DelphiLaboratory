unit App.Core.Impl;

interface

uses
  App.Core,
  System.Classes,
  System.SyncObjs;

type

  TAppCriticalSection = class(TInterfacedObject, ICriticalSection)
  strict private
    fInternalCS: TCriticalSection;
  strict protected
    { protected declarations }
  public
    constructor Create;
    destructor Destroy; override;

    procedure Enter;
    procedure Leave;
  end;

implementation

{ TAppCriticalSection }

constructor TAppCriticalSection.Create;
begin
  fInternalCS := TCriticalSection.Create;
end;

destructor TAppCriticalSection.Destroy;
begin
  fInternalCS.Free;
  inherited;
end;

procedure TAppCriticalSection.Enter;
begin
  fInternalCS.Enter;
end;

procedure TAppCriticalSection.Leave;
begin
  fInternalCS.Leave;
end;

end.
