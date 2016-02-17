unit Base.Presenter;

interface

uses
  System.SysUtils, System.Classes, Base.Data.Module, Crud.Resource;

type

  TBasePresenter = class(TBaseDataModule)
  strict private
    { private declarations }
  public
    { public declarations }
  end;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

end.
