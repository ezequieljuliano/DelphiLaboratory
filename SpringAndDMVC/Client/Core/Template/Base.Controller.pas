unit Base.Controller;

interface

uses
  System.SysUtils, System.Classes, Base.Data.Module;

type

  TBaseController = class(TBaseDataModule)
  strict private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

end.
