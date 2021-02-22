object formularioListagemFornecedores: TformularioListagemFornecedores
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Listagem de fornecedores'
  ClientHeight = 324
  ClientWidth = 455
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
  object Label1: TLabel
    Left = 113
    Top = 294
    Width = 230
    Height = 16
    Caption = 'Clique sobre o registro para alterar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object btnNovo: TButton
    Left = -1
    Top = 280
    Width = 108
    Height = 44
    Caption = 'Novo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = btnNovoClick
  end
  object tabela: TDBGrid
    Left = -2
    Top = -1
    Width = 456
    Height = 281
    DataSource = conector
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = tabelaCellClick
    Columns = <
      item
        Expanded = False
        FieldName = 'cnpj_cpf'
        Title.Caption = 'C.N.P.J./C.P.F.'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'nome'
        Title.Caption = 'Nome'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'uf'
        Title.Caption = 'UF'
        Width = 30
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'nome_empresa'
        Title.Caption = 'Empresa'
        Width = 150
        Visible = True
      end>
  end
  object btnVoltar: TButton
    Left = 347
    Top = 280
    Width = 108
    Height = 44
    Caption = 'Voltar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = btnVoltarClick
  end
  object conector: TDataSource
    DataSet = consulta
    Left = 288
    Top = 16
  end
  object consulta: TZQuery
    Connection = conexao
    SQL.Strings = (
      'SELECT '
      '       fo.id,'
      '       em.nome AS nome_empresa,'
      '       fo.nome,'
      '       fo.cnpj_cpf,'
      '       fo.uf'
      'FROM   '
      '       fornecedor fo'
      '       INNER JOIN empresa em  ON fo.id_empresa = em.id ')
    Params = <>
    Left = 352
    Top = 16
    object consultaid: TIntegerField
      FieldName = 'id'
    end
    object consultauf: TWideStringField
      FieldName = 'uf'
      Size = 0
    end
    object consultanome: TWideStringField
      FieldName = 'nome'
      Size = 0
    end
    object consultacnpj: TWideStringField
      FieldName = 'cnpj_cpf'
      Size = 0
    end
    object consultanome_empresa: TWideStringField
      FieldName = 'nome_empresa'
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
    Left = 408
    Top = 16
  end
end
