unit Crud.Resource.Impl;

interface

uses
  System.SysUtils,
  System.Rtti,
  System.Generics.Collections,
  Spring.Collections,
  Crud.Resource,
  MVCFramework.Commons,
  MVCFramework.RESTClient;

type

  TCrudResource<TDTO: class, constructor; TKey> = class(TInterfacedObject, ICrudResource<TDTO, TKey>)
  strict private
    fRESTClient: TRESTClient;
    fPath: string;
  strict private
    function GetPath: string;
    procedure SetPath(const value: string);
    function GetAnnotedPath: string;
    function DoInsert(const dto: TDTO): TKey;
  strict protected
    function FindOne(const id: TKey): TDTO; virtual;
    function FindOneAsList(const id: TKey): IList<TDTO>; virtual;
    function FindAll: IList<TDTO>; virtual;

    procedure Insert(const dto: TDTO); overload; virtual;
    procedure Insert(const dto: TDTO; out id: TKey); overload; virtual;

    procedure Update(const id: TKey; const dto: TDTO); virtual;

    procedure Delete(const id: TKey); overload; virtual;

    property Path: string read GetPath write SetPath;
  public
    constructor Create(const restClient: TRESTClient); virtual;
    destructor Destroy; override;
  end;

  PathAttribute = class(TCustomAttribute)
  strict private
    fValue: string;
  public
    constructor Create(const value: string);

    property Value: string read fValue;
  end;

implementation

uses
  Spring.Reflection,
  Helpful.Exceptions;

{ PathAttribute }

constructor PathAttribute.Create(const value: string);
begin
  fValue := value;
end;

{ TCrudResource<TDTO, TKey> }

constructor TCrudResource<TDTO, TKey>.Create(const restClient: TRESTClient);
begin
  inherited Create;
  fRESTClient := restClient;
  fPath := EmptyStr;
end;

procedure TCrudResource<TDTO, TKey>.Delete(const id: TKey);
var
  response: IRESTResponse;
begin
  response := fRESTClient.Resource(Path).Params([TValue.From<TKey>(id).ToString]).doDELETE;
  case response.ResponseCode of
    HTTP_STATUS.OK, HTTP_STATUS.NoContent:
      Exit;
    HTTP_STATUS.NotFound:
      raise ENotFoundException.Create(response.ResponseCode.ToString + ' - ' + response.ResponseText);
  else
    raise EInternalErrorException.Create(response.ResponseCode.ToString + ' - ' + response.ResponseText);
  end;
end;

destructor TCrudResource<TDTO, TKey>.Destroy;
begin
  fRESTClient.Free;
  inherited;
end;

function TCrudResource<TDTO, TKey>.DoInsert(const dto: TDTO): TKey;
var
  response: IRESTResponse;
begin
  response := fRESTClient.Resource(Path).doPOST<TDTO>(dto, False);
  case response.ResponseCode of
    HTTP_STATUS.OK, HTTP_STATUS.Created:
      Exit(TValue.From<Int64>(response.BodyAsString.ToInt64).AsType<TKey>);
    HTTP_STATUS.NotFound:
      raise ENotFoundException.Create(response.ResponseCode.ToString + ' - ' + response.ResponseText);
    HTTP_STATUS.BadRequest:
      raise EBadRequestException.Create(response.ResponseCode.ToString + ' - ' + response.ResponseText);
  else
    raise EInternalErrorException.Create(response.ResponseCode.ToString + ' - ' + response.ResponseText);
  end;
end;

function TCrudResource<TDTO, TKey>.FindAll: IList<TDTO>;
var
  response: IRESTResponse;
  dtoList: TObjectList<TDTO>;
  dto: TDTO;
begin
  Result := nil;
  response := fRESTClient.Resource(Path).doGET;
  case response.ResponseCode of
    HTTP_STATUS.OK:
      begin
        dtoList := response.BodyAsJSONArray.AsObjectList<TDTO>;
        try
          dtoList.OwnsObjects := False;
          Result := TCollections.CreateObjectList<TDTO>;
          for dto in dtoList do
            Result.Add(dto);
        finally
          dtoList.Free;
        end;
      end;
    HTTP_STATUS.NoContent:
      raise ENoContentException.Create(response.ResponseCode.ToString + ' - ' + response.ResponseText);
    HTTP_STATUS.NotFound:
      raise ENotFoundException.Create(response.ResponseCode.ToString + ' - ' + response.ResponseText);
  else
    raise EInternalErrorException.Create(response.ResponseCode.ToString + ' - ' + response.ResponseText);
  end;
end;

function TCrudResource<TDTO, TKey>.GetAnnotedPath: string;
var
  rttiType: TRttiType;
  attr: TCustomAttribute;
begin
  Result := EmptyStr;
  rttiType := TType.GetType(Self.ClassType);
  for attr in rttiType.GetAttributes do
    if (attr is PathAttribute) then
      Exit(PathAttribute(attr).Value);
end;

function TCrudResource<TDTO, TKey>.FindOne(const id: TKey): TDTO;
var
  response: IRESTResponse;
begin
  Result := nil;
  response := fRESTClient.Resource(Path).Params([TValue.From<TKey>(id).ToString]).doGET;
  case response.ResponseCode of
    HTTP_STATUS.OK:
      Result := response.BodyAsJSONObject.AsObject<TDTO>;
    HTTP_STATUS.NotFound:
      raise ENotFoundException.Create(response.ResponseCode.ToString + ' - ' + response.ResponseText);
  else
    raise EInternalErrorException.Create(response.ResponseCode.ToString + ' - ' + response.ResponseText);
  end;
end;

function TCrudResource<TDTO, TKey>.FindOneAsList(const id: TKey): IList<TDTO>;
var
  dto: TDTO;
begin
  Result := nil;
  dto := FindOne(id);
  if (dto <> nil) then
  begin
    Result := TCollections.CreateObjectList<TDTO>;
    Result.Add(dto);
  end;
end;

function TCrudResource<TDTO, TKey>.GetPath: string;
begin
  if fPath.IsEmpty then
    fPath := GetAnnotedPath;
  Result := fPath;
end;

procedure TCrudResource<TDTO, TKey>.Insert(const dto: TDTO; out id: TKey);
begin
  id := DoInsert(dto);
end;

procedure TCrudResource<TDTO, TKey>.Insert(const dto: TDTO);
begin
  DoInsert(dto);
end;

procedure TCrudResource<TDTO, TKey>.SetPath(const value: string);
begin
  fPath := value;
end;

procedure TCrudResource<TDTO, TKey>.Update(const id: TKey; const dto: TDTO);
var
  response: IRESTResponse;
begin
  response := fRESTClient.Resource(Path).Params([TValue.From<TKey>(id).ToString]).doPUT<TDTO>(dto, False);
  case response.ResponseCode of
    HTTP_STATUS.OK, HTTP_STATUS.NoContent:
      Exit;
    HTTP_STATUS.NotFound:
      raise ENotFoundException.Create(response.ResponseCode.ToString + ' - ' + response.ResponseText);
    HTTP_STATUS.BadRequest:
      raise EBadRequestException.Create(response.ResponseCode.ToString + ' - ' + response.ResponseText);
  else
    raise EInternalErrorException.Create(response.ResponseCode.ToString + ' - ' + response.ResponseText);
  end;
end;

end.
