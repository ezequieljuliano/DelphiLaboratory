unit Helpful.Exceptions;

interface

uses
  System.SysUtils;

type

  EBaseException = class(Exception);
  ENoContentException = class(EBaseException);
  ENotFoundException = class(EBaseException);
  EInternalErrorException = class(EBaseException);
  EBadRequestException = class(EBaseException);

implementation

end.
