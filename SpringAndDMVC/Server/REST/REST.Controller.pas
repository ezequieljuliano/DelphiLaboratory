unit REST.Controller;

interface

uses
  System.SysUtils,
  System.Classes,
  System.SyncObjs,
  System.Generics.Collections,
  MVCFramework,
  MVCFramework.Commons,
  Crud.Service, Crud.Repository,
  REST.Entity.Converter;

type

  ERESTControllerException = class(Exception);

  TRESTController = class(TMVCController)
  strict private
    { private declarations }
  strict protected
    { protected declarations }
  public
    { public declarations }
  end;

  TRESTControllerClass = class of TRESTController;

  TRESTManager = record
  strict private
    class var fControllers: TDictionary<string, TRESTControllerClass>;
    class constructor ClassCreate;
    class destructor ClassDestroy;
  public
    class procedure RegisterController<T: TRESTController>; static;
    class property Controllers: TDictionary<string, TRESTControllerClass> read fControllers;
  end;

  TCrudController<TEntity, TDTO: class, constructor; TKey; IRepository: ICrudRepository<TEntity, TKey>; IService: ICrudService<TEntity, TKey, IRepository>> = class(TRESTController)
  strict private
    fService: IService;
    fConverter: IRESTEntityConverter<TEntity, TDTO, TKey>;
  strict protected
    procedure MVCControllerAfterCreate; override;
    procedure MVCControllerBeforeDestroy; override;

    function GetService: IService;
    function GetConverter: IRESTEntityConverter<TEntity, TDTO, TKey>;
  public
    [MVCPath('/($id)')]
    [MVCHTTPMethod([httpGET])]
    [MVCProduces(TMVCMediaType.APPLICATION_JSON, TMVCCharSet.ISO88591)]
    procedure FindOne(ctx: TWebContext); virtual;

    [MVCPath]
    [MVCHTTPMethod([httpGET])]
    [MVCProduces(TMVCMediaType.APPLICATION_JSON, TMVCCharSet.ISO88591)]
    procedure FindAll(ctx: TWebContext); virtual;

    [MVCPath]
    [MVCHTTPMethod([httpPOST])]
    [MVCProduces(TMVCMediaType.APPLICATION_JSON, TMVCCharSet.ISO88591)]
    [MVCConsumes(TMVCMediaType.APPLICATION_JSON)]
    procedure Insert(ctx: TWebContext); virtual;

    [MVCPath('/($id)')]
    [MVCHTTPMethod([httpPUT])]
    [MVCProduces(TMVCMediaType.APPLICATION_JSON, TMVCCharSet.ISO88591)]
    [MVCConsumes(TMVCMediaType.APPLICATION_JSON)]
    procedure Update(ctx: TWebContext); virtual;

    [MVCPath('/($id)')]
    [MVCHTTPMethod([httpDELETE])]
    procedure Delete(ctx: TWebContext); virtual;
  end;

implementation

uses
  Spring.Services,
  Spring.Collections,
  System.Rtti,
  Helpful;

{ TRESTManager }

class constructor TRESTManager.ClassCreate;
begin
  fControllers := TDictionary<string, TRESTControllerClass>.Create;
end;

class destructor TRESTManager.ClassDestroy;
begin
  fControllers.Free;
end;

class procedure TRESTManager.RegisterController<T>;
begin
  fControllers.AddOrSetValue(T.QualifiedClassName, T);
end;

{ TCrudController<TEntity, TKey, TDTO, IService> }

procedure TCrudController<TEntity, TDTO, TKey, IRepository, IService>.Delete(ctx: TWebContext);
var
  entity: TEntity;
begin
  TCore.CriticalSection.Enter;
  try
    entity := GetService.FindOne(TValue.From<Int64>(ctx.Request.Params['id'].ToInt64).AsType<TKey>);
    if (entity <> nil) then
    begin
      try
        Self.GetService.Delete(entity);

        ctx.Response.RawWebResponse.Content := '';
        ctx.Response.StatusCode := HTTP_STATUS.NoContent;
        ctx.Response.ReasonString := 'No Content';
      finally
        entity.Free;
      end;
    end
    else
      Self.Render(HTTP_STATUS.NotFound, 'Not Found');
  finally
    TCore.CriticalSection.Leave;
  end;
end;

procedure TCrudController<TEntity, TDTO, TKey, IRepository, IService>.FindOne(ctx: TWebContext);
var
  entity: TEntity;
begin
  TCore.CriticalSection.Enter;
  try
    entity := GetService.FindOne(TValue.From<Int64>(ctx.Request.Params['id'].ToInt64).AsType<TKey>);
    if (entity <> nil) then
    begin
      try
        Self.Render(GetConverter.GetAsDTO(entity));
      finally
        entity.Free;
      end;
    end
    else
      Self.Render(HTTP_STATUS.NotFound, 'Not Found');
  finally
    TCore.CriticalSection.Leave;
  end;
end;

procedure TCrudController<TEntity, TDTO, TKey, IRepository, IService>.FindAll(ctx: TWebContext);
var
  entities: IList<TEntity>;
begin
  TCore.CriticalSection.Enter;
  try
    entities := GetService.FindAll;
    if (entities <> nil) and (entities.Count > 0) then
      Self.Render<TDTO>(GetConverter.GetAsDTOs(entities))
    else
      Self.Render(HTTP_STATUS.NoContent, 'No Content');
  finally
    TCore.CriticalSection.Leave;
  end;
end;

function TCrudController<TEntity, TDTO, TKey, IRepository, IService>.GetConverter: IRESTEntityConverter<TEntity, TDTO, TKey>;
begin
  Result := fConverter;
end;

function TCrudController<TEntity, TDTO, TKey, IRepository, IService>.GetService: IService;
begin
  Result := fService;
end;

procedure TCrudController<TEntity, TDTO, TKey, IRepository, IService>.MVCControllerAfterCreate;
begin
  inherited MVCControllerAfterCreate;
  fService := ServiceLocator.GetService<IService>;
  fConverter := ServiceLocator.GetService<IRESTEntityConverter<TEntity, TDTO, TKey>>;
end;

procedure TCrudController<TEntity, TDTO, TKey, IRepository, IService>.MVCControllerBeforeDestroy;
begin
  fService := nil;
  fConverter := nil;
  inherited MVCControllerBeforeDestroy;
end;

procedure TCrudController<TEntity, TDTO, TKey, IRepository, IService>.Insert(ctx: TWebContext);
var
  dto: TDTO;
  entity: TEntity;
  id: string;
begin
  TCore.CriticalSection.Enter;
  try
    dto := ctx.Request.BodyAs<TDTO>;
    try
      entity := GetConverter.GetAsEntity(dto);
      try
        entity := Self.GetService.Save(entity);

        id := TValue.From<TKey>(GetConverter.GetEntityKeyValue(entity)).ToString;

        ctx.Response.RawWebResponse.Content := id;
        ctx.Response.Location := ctx.Request.PathInfo + '/' + id;

        ctx.Response.StatusCode := HTTP_STATUS.Created;
        ctx.Response.ReasonString := 'Created';
      finally
        entity.Free;
      end;
    finally
      dto.Free;
    end;
  finally
    TCore.CriticalSection.Leave;
  end;
end;

procedure TCrudController<TEntity, TDTO, TKey, IRepository, IService>.Update(ctx: TWebContext);
var
  entity: TEntity;
  dto: TDTO;
begin
  TCore.CriticalSection.Enter;
  try
    entity := GetService.FindOne(TValue.From<Int64>(ctx.Request.Params['id'].ToInt64).AsType<TKey>);
    if (entity <> nil) then
    begin
      try
        dto := ctx.Request.BodyAs<TDTO>;
        try
          GetConverter.UpdateEntity(dto, entity);

          Self.GetService.Save(entity);

          ctx.Response.RawWebResponse.Content := '';
          ctx.Response.StatusCode := HTTP_STATUS.NoContent;
          ctx.Response.ReasonString := 'No Content';
        finally
          dto.Free;
        end;
      finally
        entity.Free;
      end;
    end
    else
      Self.Render(HTTP_STATUS.NotFound, 'Not Found');
  finally
    TCore.CriticalSection.Leave;
  end;
end;

end.
