unit Helpful;

interface

uses
  System.SyncObjs,
  System.SysUtils;

type

  TCore = record
  public
    class function CriticalSection: TCriticalSection; static;
  end;

implementation

type

  TSingletonCriticalSection = class sealed
  strict private
    class var fInstance: TCriticalSection;
    class constructor Create;
    class destructor Destroy;
  public
    class function Instance: TCriticalSection; static;
  end;

  { TSingletonCriticalSection }

class constructor TSingletonCriticalSection.Create;
begin
  fInstance := TCriticalSection.Create;
end;

class destructor TSingletonCriticalSection.Destroy;
begin
  fInstance.Free;
end;

class function TSingletonCriticalSection.Instance: TCriticalSection;
begin
  Result := fInstance;
end;

{ TCore }

class function TCore.CriticalSection: TCriticalSection;
begin
  Result := TSingletonCriticalSection.Instance;
end;

end.
