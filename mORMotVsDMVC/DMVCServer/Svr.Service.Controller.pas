unit Svr.Service.Controller;

interface

uses
  MVCFramework,
  Web.HTTPApp;

type

  [MVCPath('/services')]
  TSvrServiceController = class(TMVCController)
  public
    [MVCPath('/getmethod')]
    [MVCHTTPMethod([httpGET])]
    procedure GetMethod(ctx: TWebContext);
  end;

implementation

{ TSvrServiceController }

procedure TSvrServiceController.GetMethod(ctx: TWebContext);
begin
  Render('GET');
end;

end.
