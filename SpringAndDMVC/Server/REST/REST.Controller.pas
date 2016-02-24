unit REST.Controller;

interface

uses
  System.Rtti,
  System.SysUtils,
  MVCFramework,
  MVCFramework.Commons,
  Spring.Services,
  Spring.Collections,
  App.Core,
  Crud.Service, Crud.Repository,
  REST.Converter;

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

  TCrudController<TEntity, TDTO: class, constructor; TKey; IRepository: ICrudRepository<TEntity, TKey>; IService: ICrudService<TEntity, TKey, IRepository>> = class(TRESTController)
  strict private
    fService: IService;
    fConverter: IRESTConverter<TEntity, TDTO, TKey>;
    fCriticalSection: ICriticalSection;
  strict protected
    procedure MVCControllerAfterCreate; override;
    procedure MVCControllerBeforeDestroy; override;

    function GetService: IService;
    function GetConverter: IRESTConverter<TEntity, TDTO, TKey>;
    function GetCriticalSection: ICriticalSection;
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

{ TCrudController<TEntity, TKey, TDTO, IService> }

procedure TCrudController<TEntity, TDTO, TKey, IRepository, IService>.Delete(ctx: TWebContext);
var
  entity: TEntity;
begin
  GetCriticalSection.Enter;
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
    GetCriticalSection.Leave;
  end;
end;

procedure TCrudController<TEntity, TDTO, TKey, IRepository, IService>.FindOne(ctx: TWebContext);
var
  entity: TEntity;
begin
  GetCriticalSection.Enter;
  try
    entity := GetService.FindOne(TValue.From<Int64>(ctx.Request.Params['id'].ToInt64).AsType<TKey>);
    if (entity <> nil) then
    begin
      try
        Self.Render(GetConverter.AsDTO(entity));
      finally
        entity.Free;
      end;
    end
    else
      Self.Render(HTTP_STATUS.NotFound, 'Not Found');
  finally
    GetCriticalSection.Leave;
  end;
end;

procedure TCrudController<TEntity, TDTO, TKey, IRepository, IService>.FindAll(ctx: TWebContext);
var
  entities: IList<TEntity>;
begin
  GetCriticalSection.Enter;
  try
    entities := GetService.FindAll;
    if (entities <> nil) and (entities.Count > 0) then
      Self.Render<TDTO>(GetConverter.AsDTOs(entities))
    else
      Self.Render(HTTP_STATUS.NoContent, 'No Content');
  finally
    GetCriticalSection.Leave;
  end;
end;

function TCrudController<TEntity, TDTO, TKey, IRepository, IService>.GetConverter: IRESTConverter<TEntity, TDTO, TKey>;
begin
  Result := fConverter;
end;

function TCrudController<TEntity, TDTO, TKey, IRepository, IService>.GetCriticalSection: ICriticalSection;
begin
  Result := fCriticalSection;
end;

function TCrudController<TEntity, TDTO, TKey, IRepository, IService>.GetService: IService;
begin
  Result := fService;
end;

procedure TCrudController<TEntity, TDTO, TKey, IRepository, IService>.MVCControllerAfterCreate;
begin
  inherited MVCControllerAfterCreate;
  fService := ServiceLocator.GetService<IService>;
  fConverter := ServiceLocator.GetService<IRESTConverter<TEntity, TDTO, TKey>>;
  fCriticalSection := ServiceLocator.GetService<ICriticalSection>;
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
  GetCriticalSection.Enter;
  try
    dto := ctx.Request.BodyAs<TDTO>;
    try
      entity := GetConverter.AsEntity(dto);
      try
        entity := Self.GetService.Save(entity);

        id := TValue.From<TKey>(GetConverter.KeyValue(entity)).ToString;

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
    GetCriticalSection.Leave;
  end;
end;

procedure TCrudController<TEntity, TDTO, TKey, IRepository, IService>.Update(ctx: TWebContext);
var
  entity: TEntity;
  dto: TDTO;
begin
  GetCriticalSection.Enter;
  try
    entity := GetService.FindOne(TValue.From<Int64>(ctx.Request.Params['id'].ToInt64).AsType<TKey>);
    if (entity <> nil) then
    begin
      try
        dto := ctx.Request.BodyAs<TDTO>;
        try
          GetConverter.Update(dto, entity);

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
    GetCriticalSection.Leave;
  end;
end;

end.
