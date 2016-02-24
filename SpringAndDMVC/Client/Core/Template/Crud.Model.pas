unit Crud.Model;

interface

uses
  System.SysUtils, System.Classes, Base.Model, System.Rtti, Crud.Resource,
  Spring.Persistence.ObjectDataset, Spring.Collections, Data.DB;

type

  TCrudModel = class(TBaseModel)
  strict private
    { private declarations }
  strict protected
    procedure FindOne<TDTO: class, constructor; TKey>(const resource: ICrudResource<TDTO, TKey>; const dataSet: TObjectDataset; const id: TKey);
    procedure FindAll<TDTO: class, constructor; TKey>(const resource: ICrudResource<TDTO, TKey>; const dataSet: TObjectDataset);
    procedure Insert<TDTO: class, constructor; TKey>(const resource: ICrudResource<TDTO, TKey>; const dataSet: TObjectDataset; const idField: TField);
    procedure Update<TDTO: class, constructor; TKey>(const resource: ICrudResource<TDTO, TKey>; const dataSet: TObjectDataset; const id: TKey);
    procedure Delete<TDTO: class, constructor; TKey>(const resource: ICrudResource<TDTO, TKey>; const dataSet: TObjectDataset; const id: TKey);
  public
    procedure ApplyFindOne(const id: TValue); virtual; abstract;
    procedure ApplyFindAll; virtual; abstract;
    procedure ApplyInsert; virtual; abstract;
    procedure ApplyUpdate; virtual; abstract;
    procedure ApplyDelete; virtual; abstract;
  end;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

{ TCrudModel }

procedure TCrudModel.Delete<TDTO, TKey>(
  const resource: ICrudResource<TDTO, TKey>; const dataSet: TObjectDataset;
  const id: TKey);
begin
  resource.Delete(id);
  dataSet.Delete;
end;

procedure TCrudModel.FindAll<TDTO, TKey>(
  const resource: ICrudResource<TDTO, TKey>;
  const dataSet: TObjectDataset);
begin
  dataSet.Close;
  dataSet.DataList := resource.FindAll as IObjectList;
  dataSet.Open;
end;

procedure TCrudModel.FindOne<TDTO, TKey>(
  const resource: ICrudResource<TDTO, TKey>; const dataSet: TObjectDataset;
  const id: TKey);
begin
  dataSet.Close;
  dataSet.DataList := resource.FindOneAsList(id) as IObjectList;
  dataSet.Open;
end;

procedure TCrudModel.Insert<TDTO, TKey>(
  const resource: ICrudResource<TDTO, TKey>; const dataSet: TObjectDataset;
  const idField: TField);
var
  idGenerated: TKey;
begin
  idGenerated := resource.Insert(dataSet.GetCurrentModel<TDTO>);
  dataSet.Edit;
  idField.AsVariant := TValue.From<TKey>(idGenerated).AsVariant;
  dataSet.Post;
end;

procedure TCrudModel.Update<TDTO, TKey>(
  const resource: ICrudResource<TDTO, TKey>; const dataSet: TObjectDataset;
  const id: TKey);
begin
  resource.Update(id, dataSet.GetCurrentModel<TDTO>);
end;

end.
