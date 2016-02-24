unit REST.Container.Impl;

interface

uses
  System.Rtti,
  Spring,
  Spring.Collections,
  Spring.Reflection,
  Spring.Container.Common,
  REST.Controller,
  REST.Container,
  MVCFramework,
  App.Core;

type

  TRESTContainer = class(TInterfacedObject, IRESTContainer)
  strict private
    fControllers: IDictionary<string, TRESTControllerClass>;
    [Inject]
    fCriticalSection: ICriticalSection;
  strict protected
    function Controllers(): IDictionary<string, TRESTControllerClass>;
  public
    constructor Create;
  end;

implementation

{ TRESTContainer }

function TRESTContainer.Controllers: IDictionary<string, TRESTControllerClass>;
begin
  if (fControllers = nil) then
  begin
    fCriticalSection.Enter;
    try
      fControllers := TCollections.CreateDictionary<string, TRESTControllerClass>;
      TType.GetTypes.ForEach(
        procedure(const rttiType: TRttiType)
        begin
          if (rttiType.IsInstance) and (rttiType.HasCustomAttribute<MVCPathAttribute>) then
            fControllers.AddOrSetValue(rttiType.AsClass.MetaclassType.QualifiedClassName, TRESTControllerClass(rttiType.AsClass.MetaclassType));
        end
        );
    finally
      fCriticalSection.Leave;
    end;
  end;
  Result := fControllers;
end;

constructor TRESTContainer.Create;
begin
  fControllers := nil;
end;

end.
