unit REST.Container;

interface

uses
  Spring.Collections,
  REST.Controller;

type

  IRESTContainer = interface
    ['{1BA317EE-7184-4802-BDA6-0FE37DF729AC}']
    function Controllers(): IDictionary<string, TRESTControllerClass>;
  end;

implementation

end.
