object formularioTelefones: TformularioTelefones
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'formularioTelefones'
  ClientHeight = 348
  ClientWidth = 340
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblTelefone: TLabel
    Left = 8
    Top = 8
    Width = 78
    Height = 24
    Caption = 'Telefone'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object btnCancelar: TButton
    Left = 226
    Top = 32
    Width = 115
    Height = 35
    Caption = 'Cancelar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = btnCancelarClick
  end
  object btnGravar: TButton
    Left = -9
    Top = 32
    Width = 124
    Height = 35
    Caption = 'Gravar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = btnGravarClick
  end
  object btnExcluir: TButton
    Left = 113
    Top = 32
    Width = 118
    Height = 35
    Caption = 'Excluir'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = btnExcluirClick
  end
  object tabela: TDBGrid
    Left = -2
    Top = 66
    Width = 342
    Height = 280
    DataSource = conector
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -16
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'telefone'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'Tahoma'
        Font.Style = []
        Title.Caption = 'Telefone'
        Width = 240
        Visible = True
      end>
  end
  object editTelefone: TMaskEdit
    Left = 95
    Top = 0
    Width = 245
    Height = 32
    EditMask = '(00)0000-0000;1;_'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 13
    ParentFont = False
    TabOrder = 0
    Text = '(  )    -    '
  end
  object conector: TDataSource
    DataSet = consulta
    Left = 112
    Top = 178
  end
  object consulta: TZQuery
    Connection = conexao
    SQL.Strings = (
      'SELECT '
      '       id,'
      '       id_fornecedor,'
      '       telefone'
      'FROM   '
      '        telefone_fornecedor ')
    Params = <>
    Left = 176
    Top = 178
    object consultaid: TIntegerField
      FieldName = 'id'
    end
    object consultaid_fornecedor: TIntegerField
      FieldName = 'id_fornecedor'
    end
    object consultatelefone: TWideStringField
      FieldName = 'telefone'
      Size = 0
    end
  end
  object conexao: TZConnection
    ControlsCodePage = cCP_UTF16
    ClientCodepage = 'UTF8'
    Catalog = ''
    Properties.Strings = (
      'codepage=UTF8')
    HostName = 'localhost'
    Port = 5432
    Database = 'banco_1'
    User = 'postgres'
    Password = 'senha123'
    Protocol = 'postgresql-9'
    LibraryLocation = 'C:\Users\alans\Documents\GitHub\ListagemFornecedor\libpq.dll'
    Left = 232
    Top = 178
  end
  object consulta_2: TZQuery
    Connection = conexao
    Params = <>
    Left = 176
    Top = 250
  end
end
