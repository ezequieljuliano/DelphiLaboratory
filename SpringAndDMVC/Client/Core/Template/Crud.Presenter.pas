unit Crud.Presenter;

interface

uses
  System.SysUtils, System.Classes, Base.Presenter, System.Rtti;

type

  TCrudPresenter = class(TBasePresenter)
  strict private
    { private declarations }
  public
    procedure RESTFindAll(); virtual; abstract;
    procedure RESTFindOne(const id: TValue); virtual; abstract;
    procedure RESTInsert(); virtual; abstract;
    procedure RESTUpdate(); virtual; abstract;
    procedure RESTDelete(); virtual; abstract;
  end;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

end.
