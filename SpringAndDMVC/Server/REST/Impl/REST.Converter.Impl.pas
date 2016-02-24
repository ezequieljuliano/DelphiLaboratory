unit REST.Converter.Impl;

interface

uses
  System.Rtti,
  System.SysUtils,
  System.Generics.Collections,
  Spring.Collections,
  Spring.Reflection,
  REST.Converter;

type

  TRESTConverter<TEntity, TDTO: class, constructor; TKey> = class(TInterfacedObject, IRESTConverter<TEntity, TDTO, TKey>)
  strict private
    { private declarations }
  strict protected
    function AsEntity(source: TDTO): TEntity; virtual;
    function AsEntities(source: TObjectList<TDTO>): IList<TEntity>; virtual;

    function AsDTO(source: TEntity): TDTO; virtual;
    function AsDTOs(source: IList<TEntity>): TObjectList<TDTO>; virtual;

    function KeyValue(source: TEntity): TKey; overload; virtual;
    function KeyValue(source: TDTO): TKey; overload; virtual;

    procedure Update(source: TDTO; target: TEntity); overload; virtual;
    procedure Update(source: TEntity; target: TDTO); overload; virtual;
  public
    { public declarations }
  end;

implementation


{ TRESTConverter<TEntity, TDTO, TKey> }

function TRESTConverter<TEntity, TDTO, TKey>.AsDTO(source: TEntity): TDTO;
begin
  Result := TDTO.Create;
  Update(source, Result);
end;

function TRESTConverter<TEntity, TDTO, TKey>.AsDTOs(
  source: IList<TEntity>): TObjectList<TDTO>;
var
  entity: TEntity;
begin
  Result := TObjectList<TDTO>.Create;
  for entity in source do
    Result.Add(AsDTO(entity));
end;

function TRESTConverter<TEntity, TDTO, TKey>.AsEntities(
  source: TObjectList<TDTO>): IList<TEntity>;
var
  dto: TDTO;
begin
  Result := TCollections.CreateList<TEntity>;
  for dto in source do
    Result.Add(AsEntity(dto));
end;

function TRESTConverter<TEntity, TDTO, TKey>.AsEntity(
  source: TDTO): TEntity;
begin
  Result := TEntity.Create;
  Update(source, Result);
end;

function TRESTConverter<TEntity, TDTO, TKey>.KeyValue(
  source: TEntity): TKey;
begin
  Result := TType.GetType(TEntity).GetProperty('Id').GetValue(source).AsType<TKey>;
end;

function TRESTConverter<TEntity, TDTO, TKey>.KeyValue(source: TDTO): TKey;
begin
  Result := TType.GetType(TDTO).GetProperty('Id').GetValue(source).AsType<TKey>;
end;

procedure TRESTConverter<TEntity, TDTO, TKey>.Update(source: TDTO;
  target: TEntity);
var
  tProp: TRttiProperty;
begin
  TType.GetType(TDTO).Properties.ForEach(
    procedure(const sProp: TRttiProperty)
    begin
      tProp := TType.GetType(TEntity).GetProperty(sProp.Name);
      if (tProp <> nil) and (tProp.IsWritable) then
        tProp.SetValue(target, sProp.GetValue(source));
    end
    );
end;

procedure TRESTConverter<TEntity, TDTO, TKey>.Update(source: TEntity;
target: TDTO);
var
  tProp: TRttiProperty;
begin
  TType.GetType(TEntity).Properties.ForEach(
    procedure(const sProp: TRttiProperty)
    begin
      tProp := TType.GetType(TDTO).GetProperty(sProp.Name);
      if (tProp <> nil) and (tProp.IsWritable) then
        tProp.SetValue(target, sProp.GetValue(source));
    end
    );
end;

end.
