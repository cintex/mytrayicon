object Form1: TForm1
  Left = 528
  Top = 260
  Caption = 'Form1'
  ClientHeight = 181
  ClientWidth = 403
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 24
    Top = 16
    Width = 153
    Height = 25
    Caption = #20351#20851#38381#25353#38062#21464#28784
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 28
    Top = 52
    Width = 149
    Height = 25
    Caption = 'Button2'
    TabOrder = 1
  end
  object TrayIcon1: TTrayIcon
    OnDblClick = TrayIcon1DblClick
    Left = 352
    Top = 20
  end
  object PopupMenu1: TPopupMenu
    Left = 352
    Top = 76
    object Close1: TMenuItem
      Caption = 'Close'
      OnClick = Close1Click
    end
    object Show1: TMenuItem
      Caption = ' Show'
      OnClick = Show1Click
    end
  end
end
