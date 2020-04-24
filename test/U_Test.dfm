object F_Test: TF_Test
  Left = 0
  Top = 0
  Caption = 'F_Test'
  ClientHeight = 242
  ClientWidth = 472
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 40
    Top = 8
    Width = 393
    Height = 89
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
  end
  object Button1: TButton
    Left = 40
    Top = 103
    Width = 105
    Height = 25
    Caption = 'Name table'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 358
    Top = 103
    Width = 75
    Height = 25
    Caption = 'Field PK'
    TabOrder = 2
    OnClick = Button2Click
  end
end
