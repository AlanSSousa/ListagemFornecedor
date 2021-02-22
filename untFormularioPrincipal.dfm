object formularioPrincipal: TformularioPrincipal
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'formularioPrincipal'
  ClientHeight = 324
  ClientWidth = 455
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object btnFechar: TSpeedButton
    Left = 310
    Top = 232
    Width = 145
    Height = 94
    Caption = 'Fechar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    OnClick = btnFecharClick
  end
  object btnEmpresa: TSpeedButton
    Left = -1
    Top = -1
    Width = 305
    Height = 98
    Caption = 'Cadastro de empresas'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    OnClick = btnEmpresaClick
  end
  object btnFornecedor: TSpeedButton
    Left = 0
    Top = 103
    Width = 304
    Height = 221
    Caption = 'Cadastro de fornecedores'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    OnClick = btnFornecedorClick
  end
  object btnImprimir: TSpeedButton
    Left = 310
    Top = 0
    Width = 145
    Height = 226
    Caption = 'Imprimir'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    OnClick = btnImprimirClick
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
    Left = 392
    Top = 168
  end
  object consulta: TZQuery
    Connection = conexao
    Params = <>
    Left = 344
    Top = 168
  end
end
