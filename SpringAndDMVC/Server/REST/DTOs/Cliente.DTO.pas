unit Cliente.DTO;

interface

type

  TClienteDTO = class
  strict private
    fId: Int64;
    fNome: string;
  public
    property Id: Int64 read fId write fId;
    property Nome: string read fNome write fNome;
  end;

implementation

end.
