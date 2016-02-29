unit REST.Container.Impl;

interface

uses
  System.Rtti,
  Spring,
  Spring.Services,
  Spring.Collections,
  Spring.Reflection,
  Spring.Container.Common,
  REST.Controller,
  REST.Container,
  MVCFramework,
  App.Core;

type

  TRESTControllerItem = class(TInterfacedObject, IRESTControllerItem)
  strict private
    fControllerClass: TRESTControllerClass;
    fDelegate: TMVCControllerDelegate;
    function GetControllerClass: TRESTControllerClass;
    function GetDelegate: TMVCControllerDelegate;
  strict protected
    property ControllerClass: TRESTControllerClass read GetControllerClass;
    property Delegate: TMVCControllerDelegate read GetDelegate;
  public
    constructor Create(const controllerClass: TRESTControllerClass; const delegate: TMVCControllerDelegate);
  end;

  TRESTContainer = class(TInterfacedObject, IRESTContainer)
  strict private
    fControllers: IDictionary<string, IRESTControllerItem>;
    [Inject]
    fCriticalSection: ICriticalSection;
  strict protected
    function Controllers(): IDictionary<string, IRESTControllerItem>;
  public
    constructor Create;
  end;

implementation

{ TRESTContainer }

function TRESTContainer.Controllers: IDictionary<string, IRESTControllerItem>;
begin
  if (fControllers = nil) then
  begin
    fCriticalSection.Enter;
    try
      fControllers := TCollections.CreateDictionary<string, IRESTControllerItem>;
      TType.GetTypes.ForEach(
        procedure(const rttiType: TRttiType)
        begin
          if (rttiType.IsInstance) and (rttiType.HasCustomAttribute<MVCPathAttribute>) then
            fControllers.AddOrSetValue(rttiType.AsClass.MetaclassType.QualifiedClassName,
              TRESTControllerItem.Create(TRESTControllerClass(rttiType.AsClass.MetaclassType),
              function: TMVCController
              begin
                Result := ServiceLocator.GetService(rttiType.AsClass.Handle).AsType<TMVCController>;
              end
              ));
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

{ TRESTControllerItem }

constructor TRESTControllerItem.Create(const controllerClass: TRESTControllerClass; const delegate: TMVCControllerDelegate);
begin
  fControllerClass := controllerClass;
  fDelegate := delegate;
end;

function TRESTControllerItem.GetControllerClass: TRESTControllerClass;
begin
  Result := fControllerClass;
end;

function TRESTControllerItem.GetDelegate: TMVCControllerDelegate;
begin
  Result := fDelegate;
end;

end.
