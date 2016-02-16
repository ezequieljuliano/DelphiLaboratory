inherited ProdutoController: TProdutoController
  Height = 124
  object Produto: TObjectDataset
    Left = 88
    Top = 40
    object ProdutoId: TLargeintField
      FieldName = 'Id'
    end
    object ProdutoEan: TWideStringField
      FieldName = 'Ean'
      Size = 13
    end
    object ProdutoDescricao: TWideStringField
      FieldName = 'Descricao'
      Size = 60
    end
    object ProdutoPreco: TCurrencyField
      FieldName = 'Preco'
    end
    object ProdutoCusto: TCurrencyField
      FieldName = 'Custo'
    end
  end
end
