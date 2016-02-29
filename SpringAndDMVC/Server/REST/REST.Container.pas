unit REST.Container;

interface

uses
  Spring.Collections,
  MVCFramework,
  REST.Controller;

type

  IRESTControllerItem = interface
    ['{C618EE0B-32DB-4DE0-BB90-99823106DC37}']
    function GetControllerClass: TRESTControllerClass;
    function GetDelegate: TMVCControllerDelegate;

    property ControllerClass: TRESTControllerClass read GetControllerClass;
    property Delegate: TMVCControllerDelegate read GetDelegate;
  end;

  IRESTContainer = interface
    ['{1BA317EE-7184-4802-BDA6-0FE37DF729AC}']
    function Controllers: IDictionary<string, IRESTControllerItem>;
  end;

implementation

end.
