object formularioBuscaEmpresa: TformularioBuscaEmpresa
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'formularioBuscaEmpresa'
  ClientHeight = 307
  ClientWidth = 456
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
  object btnVoltar: TButton
    Left = 175
    Top = 279
    Width = 75
    Height = 30
    Caption = 'Voltar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = btnVoltarClick
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
    OnColEnter = tabelaColEnter
    Columns = <
      item
        Expanded = False
        FieldName = 'id'
        Title.Caption = 'Id'
        Visible = True
      end
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
        Width = 200
        Visible = True
      end>
  end
  object conexao: TZConnection
    ControlsCodePage = cCP_UTF16
    ClientCodepage = 'UTF8'
    Catalog = ''
    Properties.Strings = (
      'codepage=UTF8')
    HostName = 'localhost'
    Port = 45432
    Database = 'banco_1'
    User = 'postgres'
    Password = 'senha123'
    Protocol = 'postgresql-9'
    LibraryLocation = 'C:\Users\alans\Documents\GitHub\ListagemFornecedor\libpq.dll'
    Left = 408
    Top = 16
  end
  object consulta: TZQuery
    Connection = conexao
    SQL.Strings = (
      'SELECT '
      '       id,'
      '       nome,'
      '       cnpj'
      'FROM   '
      '        empresa')
    Params = <>
    Left = 352
    Top = 16
    object consultaid: TIntegerField
      FieldName = 'id'
    end
    object consultanome: TWideStringField
      FieldName = 'nome'
      Size = 0
    end
    object consultacnpj: TWideStringField
      FieldName = 'cnpj'
      Size = 0
    end
  end
  object conector: TDataSource
    DataSet = consulta
    Left = 288
    Top = 16
  end
end
