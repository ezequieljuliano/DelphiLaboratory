inherited DALConnection: TDALConnection
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  Height = 203
  Width = 217
  object FDConnection: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey'
      
        'Database=D:\Projetos\DelphiLaboratory\SpringAndDMVC\Server\Datab' +
        'ase\FB_DATABASE.FDB'
      'DriverID=FB')
    LoginPrompt = False
    Left = 89
    Top = 16
  end
  object FDPhysFBDriverLink: TFDPhysFBDriverLink
    Left = 89
    Top = 74
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 89
    Top = 133
  end
end
