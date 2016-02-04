unit Svr.Service;

interface

type

  ISvrService = interface(IInvokable)
    ['{30C06DA0-390F-4A9A-9A9A-8063876144EA}']
    function GetMethod(): string;
  end;

implementation

end.
