inherited ClienteView: TClienteView
  Caption = 'ClienteView'
  ClientWidth = 559
  OnDestroy = FormDestroy
  OnShow = FormShow
  ExplicitWidth = 575
  PixelsPerInch = 96
  TextHeight = 13
  object DBNavigator1: TDBNavigator
    Left = 0
    Top = 0
    Width = 559
    Height = 41
    DataSource = ClienteSource
    Align = alTop
    TabOrder = 0
    ExplicitLeft = -80
    ExplicitWidth = 715
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 41
    Width = 559
    Height = 218
    Align = alClient
    DataSource = ClienteSource
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Id'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Nome'
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 259
    Width = 559
    Height = 41
    Align = alBottom
    TabOrder = 2
    ExplicitLeft = -80
    ExplicitWidth = 715
    object Button1: TButton
      AlignWithMargins = True
      Left = 406
      Top = 4
      Width = 128
      Height = 33
      Align = alLeft
      Caption = 'Find on Server'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      AlignWithMargins = True
      Left = 138
      Top = 4
      Width = 128
      Height = 33
      Align = alLeft
      Caption = 'Update on Server'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 128
      Height = 33
      Align = alLeft
      Caption = 'Insert on Server'
      TabOrder = 2
      OnClick = Button3Click
    end
    object Button4: TButton
      AlignWithMargins = True
      Left = 272
      Top = 4
      Width = 128
      Height = 33
      Align = alLeft
      Caption = 'Delete on Server'
      TabOrder = 3
      OnClick = Button4Click
    end
  end
  object ClienteSource: TDataSource
    DataSet = ClienteModel.Cliente
    Left = 392
    Top = 144
  end
end
