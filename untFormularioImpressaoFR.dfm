object formularioImpressaoFR: TformularioImpressaoFR
  Left = 0
  Top = 0
  Align = alClient
  BorderStyle = bsNone
  Caption = 'formularioImpressaoFR'
  ClientHeight = 378
  ClientWidth = 806
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnVoltar: TButton
    Left = 217
    Top = -4
    Width = 217
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
  object btnImprimir: TButton
    Left = 0
    Top = -4
    Width = 218
    Height = 30
    Caption = 'Imprimir'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = btnImprimirClick
  end
  object Relatorio: TRLReport
    Left = 0
    Top = 24
    Width = 794
    Height = 1123
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    object RLMemo1: TRLMemo
      Left = 41
      Top = 41
      Width = 712
      Height = 313
      Anchors = [fkLeft, fkTop]
      Behavior = [beSiteExpander]
    end
  end
end
