unit Interfaced.Data.Module;

interface

uses
  System.SysUtils, System.Classes, Base.Data.Module;

type

  TInterfacedDataModule = class(TBaseDataModule)
  strict private
    {$IFNDEF AUTOREFCOUNT}
    const objDestroyingFlag = Integer($80000000);
    function GetRefCount: Integer; inline;
    {$ENDIF}
  strict protected
    {$IFNDEF AUTOREFCOUNT}
    [Volatile] fRefCount: Integer;
    class procedure __MarkDestroying(const Obj); static; inline;
    {$ENDIF}
    function QueryInterface(const IID: TGUID; out Obj): HResult; override; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
  public
    {$IFNDEF AUTOREFCOUNT}
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    class function NewInstance: TObject; override;
    property RefCount: Integer read GetRefCount;
    {$ENDIF}
  end;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

{ TInterfacedDataModule }

{$IFNDEF AUTOREFCOUNT}

function TInterfacedDataModule.GetRefCount: Integer;
begin
   Result := fRefCount and not objDestroyingFlag;
end;

class procedure TInterfacedDataModule.__MarkDestroying(const Obj);
var
  LRef: Integer;
begin
  repeat
    LRef := TInterfacedDataModule(Obj).fRefCount;
  until AtomicCmpExchange(TInterfacedDataModule(Obj).fRefCount, LRef or objDestroyingFlag, LRef) = LRef;
end;

procedure TInterfacedDataModule.AfterConstruction;
begin
  inherited;
  // Release the constructor's implicit refcount
  AtomicDecrement(fRefCount);
end;

procedure TInterfacedDataModule.BeforeDestruction;
begin
  if RefCount <> 0 then
    Error(reInvalidPtr);
  inherited;
end;

class function TInterfacedDataModule.NewInstance: TObject;
begin
  Result := inherited NewInstance;
  TInterfacedDataModule(Result).fRefCount := 1;
end;

{$ENDIF AUTOREFCOUNT}

function TInterfacedDataModule.QueryInterface(const IID: TGUID;
  out Obj): HResult;
begin
   inherited;
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
end;

function TInterfacedDataModule._AddRef: Integer;
begin
{$IFNDEF AUTOREFCOUNT}
  Result := AtomicIncrement(FRefCount);
{$ELSE}
  Result := __ObjAddRef;
{$ENDIF}
end;

function TInterfacedDataModule._Release: Integer;
begin
{$IFNDEF AUTOREFCOUNT}
  Result := AtomicDecrement(FRefCount);
  if Result = 0 then
  begin
    // Mark the refcount field so that any refcounting during destruction doesn't infinitely recurse.
    __MarkDestroying(Self);
    Destroy;
  end;
{$ELSE}
  Result := __ObjRelease;
{$ENDIF}
end;

end.
