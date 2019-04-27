object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 314
  ClientWidth = 447
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 56
    Top = 144
    Width = 249
    Height = 90
    Caption = 'Button1'
    TabOrder = 0
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=D:\Repository-Database\climatenow\INTEGRADO.FDB'
      'User_Name=SYSDBA'
      'Password=414'
      'CharacterSet=WIN1252'
      'DriverID=FB')
    ConnectedStoredUsage = []
    LoginPrompt = False
    Transaction = FDTransaction1
    Left = 72
    Top = 96
  end
  object FDTransaction1: TFDTransaction
    Options.AutoStop = False
    Options.DisconnectAction = xdRollback
    Connection = FDConnection1
    Left = 161
    Top = 47
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 285
    Top = 39
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 288
    Top = 96
  end
end
