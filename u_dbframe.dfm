object Frame_DBG: TFrame_DBG
  Left = 0
  Top = 0
  Width = 543
  Height = 156
  Color = 4802889
  ParentBackground = False
  ParentColor = False
  TabOrder = 0
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 543
    Height = 156
    Align = alClient
    Caption = 'GroupBox1'
    Color = 10526880
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentColor = False
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      543
      156)
    object DBNavigator: TDBNavigator
      Left = 3
      Top = 47
      Width = 540
      Height = 18
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
    object DBGrid: TDBGrid
      Left = 3
      Top = 71
      Width = 537
      Height = 82
      Anchors = [akLeft, akTop, akRight, akBottom]
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clInfoText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = [fsBold]
    end
    object btnImport: TButton
      Left = 3
      Top = 16
      Width = 126
      Height = 25
      Caption = 'Import from CSV'
      TabOrder = 2
    end
    object btnExport: TButton
      Left = 414
      Top = 16
      Width = 126
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Export to CSV'
      TabOrder = 3
    end
    object btnAction1: TButton
      Left = 135
      Top = 16
      Width = 126
      Height = 25
      Caption = 'Action1'
      TabOrder = 4
      Visible = False
    end
    object btnAction2: TButton
      Left = 267
      Top = 16
      Width = 126
      Height = 25
      Caption = 'Action1'
      TabOrder = 5
      Visible = False
    end
  end
end
