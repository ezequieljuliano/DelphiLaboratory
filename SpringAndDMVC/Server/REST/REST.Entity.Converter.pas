unit REST.Entity.Converter;

interface

uses
  System.Generics.Collections,
  Spring.Collections;

type

  IRESTEntityConverter<TEntity, TDTO: class, constructor; TKey> = interface
    ['{50AD68C7-92DE-4CBD-AD8B-4F2E42F4D2DC}']
    function GetAsEntity(source: TDTO): TEntity;
    function GetAsDTO(source: TEntity): TDTO;

    function GetAsEntities(source: TObjectList<TDTO>): IList<TEntity>;
    function GetAsDTOs(source: IList<TEntity>): TObjectList<TDTO>;

    function GetEntityKeyValue(source: TEntity): TKey;

    procedure UpdateEntity(source: TDTO; target: TEntity);
    procedure UpdateDTO(source: TEntity; target: TDTO);
  end;

implementation

end.
