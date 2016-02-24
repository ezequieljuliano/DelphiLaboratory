inherited ClienteModel: TClienteModel
  object Cliente: TObjectDataset
    Left = 88
    Top = 56
    object ClienteId: TLargeintField
      FieldName = 'Id'
    end
    object ClienteNome: TWideStringField
      FieldName = 'Nome'
      Size = 60
    end
  end
end
