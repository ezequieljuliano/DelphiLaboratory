unit App.Exceptions;

interface

uses
  System.SysUtils;

type

  EBaseAppException = class(Exception);
  ENoContentException = class(EBaseAppException);
  ENotFoundException = class(EBaseAppException);
  EInternalErrorException = class(EBaseAppException);
  EBadRequestException = class(EBaseAppException);

implementation

end.
