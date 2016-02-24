unit REST.Converter;

interface

uses
  System.Generics.Collections,
  Spring.Collections;

type

  IRESTConverter<TEntity, TDTO: class, constructor; TKey> = interface
    ['{CB8953D8-7A64-4EBD-B534-488A126D5BA2}']
    function AsEntity(source: TDTO): TEntity;
    function AsEntities(source: TObjectList<TDTO>): IList<TEntity>;

    function AsDTO(source: TEntity): TDTO;
    function AsDTOs(source: IList<TEntity>): TObjectList<TDTO>;

    function KeyValue(source: TEntity): TKey; overload;
    function KeyValue(source: TDTO): TKey; overload;

    procedure Update(source: TDTO; target: TEntity); overload;
    procedure Update(source: TEntity; target: TDTO); overload;
  end;

implementation

end.
