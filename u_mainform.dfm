object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'FormMain'
  ClientHeight = 626
  ClientWidth = 776
  Color = 5968384
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 776
    Height = 626
    ActivePage = tsGererationIncoming
    Align = alClient
    TabOrder = 0
    OnChange = PageControlChange
    object tsGererationIncoming: TTabSheet
      Caption = 'Gereration'
      DesignSize = (
        768
        598)
      object gb_GeneratonCSV: TGroupBox
        Left = 3
        Top = 3
        Width = 762
        Height = 142
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Generaton of CSV'
        Color = 16577279
        ParentBackground = False
        ParentColor = False
        TabOrder = 0
        object l_EmployeesCount: TLabel
          Left = 200
          Top = 60
          Width = 83
          Height = 13
          Caption = 'Employees Count'
        end
        object l_groupsCount: TLabel
          Left = 352
          Top = 60
          Width = 66
          Height = 13
          Caption = 'Groups Count'
        end
        object btn_create_sqlitedb: TButton
          Left = 22
          Top = 16
          Width = 163
          Height = 25
          Caption = 'create sqlite db'
          TabOrder = 0
          OnClick = buttonOnClick
        end
        object ComboBox_DBtype: TComboBox
          Left = 191
          Top = 18
          Width = 163
          Height = 21
          ItemIndex = 1
          TabOrder = 1
          Text = 'Firebird'
          Items.Strings = (
            'SQLite'
            'Firebird')
        end
        object btn_generate_csv: TButton
          Left = 22
          Top = 55
          Width = 163
          Height = 25
          Caption = 'generate csv'
          TabOrder = 2
          OnClick = buttonOnClick
        end
        object edt_EmployeesCount: TEdit
          Left = 289
          Top = 57
          Width = 48
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          Text = '20'
          TextHint = 'Employees count'
        end
        object edt_GroupsCount: TEdit
          Left = 441
          Top = 57
          Width = 48
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          Text = '2'
          TextHint = 'Groups count'
        end
      end
      object gb_GenerationCore: TGroupBox
        Left = 3
        Top = 151
        Width = 762
        Height = 122
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Generation Core-data'
        TabOrder = 1
        object btnCSV2CDS: TButton
          Left = 11
          Top = 23
          Width = 163
          Height = 25
          Caption = 'Load CSV to Dataset '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          OnClick = buttonOnClick
        end
        object btnEmploees2groups: TButton
          Left = 11
          Top = 54
          Width = 163
          Height = 25
          Caption = 'Employees to groups'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          OnClick = buttonOnClick
        end
        object btnCoreEG2db: TButton
          Left = 45
          Top = 85
          Width = 129
          Height = 25
          Caption = 'Empoyees+Groups to DB'
          TabOrder = 2
          OnClick = buttonOnClick
        end
      end
      object gb_GenerationPlan: TGroupBox
        Left = 3
        Top = 279
        Width = 762
        Height = 250
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Generation of Plan'
        TabOrder = 2
        object cb_GenerationPlanType: TComboBox
          Left = 22
          Top = 36
          Width = 163
          Height = 21
          ItemIndex = 0
          TabOrder = 0
          Text = 'Every day'
          Items.Strings = (
            'Every day'
            'Every week'
            'Every month')
        end
        object btnGeneratePlan: TButton
          Left = 22
          Top = 90
          Width = 163
          Height = 25
          Caption = 'Generate Plan'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          OnClick = buttonOnClick
        end
        object DateTimePicker1: TDateTimePicker
          Left = 22
          Top = 63
          Width = 163
          Height = 21
          Date = 45444.824129756950000000
          Time = 45444.824129756950000000
          TabOrder = 2
          OnChange = DateTimePicker1Change
        end
      end
    end
    object tsCDS: TTabSheet
      Caption = 'Client Datasets'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Splitter1: TSplitter
        Left = 0
        Top = 286
        Width = 768
        Height = 3
        Cursor = crVSplit
        Align = alTop
        ExplicitTop = 156
        ExplicitWidth = 442
      end
      inline Frame_CDEmployee: TFrame_DBG
        Left = 0
        Top = 0
        Width = 768
        Height = 286
        Align = alTop
        Color = 4802889
        ParentBackground = False
        ParentColor = False
        TabOrder = 0
        ExplicitWidth = 768
        ExplicitHeight = 286
        inherited GroupBox1: TGroupBox
          Width = 768
          Height = 286
          Caption = 'Employees'
          ExplicitWidth = 768
          ExplicitHeight = 286
          inherited DBNavigator: TDBNavigator
            Width = 760
            DataSource = dm_database.DataSource_CDEmployee
            Hints.Strings = ()
            ExplicitWidth = 760
          end
          inherited DBGrid: TDBGrid
            Width = 762
            Height = 212
            DataSource = dm_database.DataSource_CDEmployee
          end
          inherited btnImport: TButton
            OnClick = buttonOnClick
          end
          inherited btnExport: TButton
            Left = 639
            Visible = False
            ExplicitLeft = 639
          end
          inherited btnAction1: TButton
            Caption = 'Export to CORE'
            Visible = True
            OnClick = buttonOnClick
          end
        end
      end
      inline Frame_CDGroups: TFrame_DBG
        Left = 0
        Top = 289
        Width = 768
        Height = 309
        Align = alClient
        Color = 4802889
        ParentBackground = False
        ParentColor = False
        TabOrder = 1
        ExplicitLeft = 88
        ExplicitTop = 368
        ExplicitWidth = 768
        ExplicitHeight = 309
        inherited GroupBox1: TGroupBox
          Width = 768
          Height = 309
          ExplicitWidth = 768
          ExplicitHeight = 309
          inherited DBNavigator: TDBNavigator
            Width = 760
            DataSource = dm_database.DataSource_CDGroups
            Hints.Strings = ()
            ExplicitWidth = 760
          end
          inherited DBGrid: TDBGrid
            Width = 762
            Height = 235
            DataSource = dm_database.DataSource_CDGroups
          end
          inherited btnImport: TButton
            OnClick = buttonOnClick
          end
          inherited btnExport: TButton
            Left = 639
            Visible = False
            ExplicitLeft = 639
          end
          inherited btnAction1: TButton
            Caption = 'Export to CORE'
            Visible = True
            OnClick = buttonOnClick
          end
        end
      end
    end
    object tsPlanGeneration: TTabSheet
      Caption = 'Plan controls'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object SplitterPlanGenerationTop: TSplitter
        Left = 0
        Top = 156
        Width = 768
        Height = 5
        Cursor = crVSplit
        Align = alTop
      end
      object SplitterPlanGenerationBottom: TSplitter
        Left = 0
        Top = 293
        Width = 768
        Height = 5
        Cursor = crVSplit
        Align = alBottom
        ExplicitLeft = 8
        ExplicitTop = 164
      end
      inline Frame_Employees: TFrame_DBG
        Left = 0
        Top = 0
        Width = 768
        Height = 156
        Align = alTop
        Color = 4802889
        ParentBackground = False
        ParentColor = False
        TabOrder = 0
        ExplicitWidth = 768
        inherited GroupBox1: TGroupBox
          Width = 768
          Caption = 'Employees'
          ExplicitWidth = 768
          inherited DBNavigator: TDBNavigator
            Width = 760
            DataSource = dm_database.DataSource_Employee
            Hints.Strings = ()
            ExplicitWidth = 760
          end
          inherited DBGrid: TDBGrid
            Width = 762
            DataSource = dm_database.DataSource_Employee
          end
          inherited btnImport: TButton
            OnClick = buttonOnClick
          end
          inherited btnExport: TButton
            Left = 639
            Visible = False
            ExplicitLeft = 639
          end
          inherited btnAction1: TButton
            OnClick = buttonOnClick
          end
          inherited btnAction2: TButton
            OnClick = buttonOnClick
          end
        end
      end
      inline Frame_Plan1: TFrame_DBG
        Left = 0
        Top = 298
        Width = 768
        Height = 300
        Align = alBottom
        Color = 4802889
        ParentBackground = False
        ParentColor = False
        TabOrder = 1
        ExplicitTop = 298
        ExplicitWidth = 768
        ExplicitHeight = 300
        inherited GroupBox1: TGroupBox
          Width = 768
          Height = 300
          Caption = 'Plan 1'
          ExplicitWidth = 768
          ExplicitHeight = 300
          inherited DBNavigator: TDBNavigator
            Width = 760
            DataSource = dm_database.DataSource_GroupEmployee
            Hints.Strings = ()
            ExplicitWidth = 760
          end
          inherited DBGrid: TDBGrid
            Width = 762
            Height = 226
            DataSource = dm_database.DataSource_GroupEmployee
            Columns = <
              item
                Expanded = False
                FieldName = 'GE_ID'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'GE_DATE'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'G_ID'
                Visible = False
              end
              item
                Expanded = False
                FieldName = 'Groups'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'E_ID'
                Visible = False
              end
              item
                Expanded = False
                FieldName = 'Employee'
                Visible = True
              end>
          end
          inherited btnImport: TButton
            Visible = False
            OnClick = buttonOnClick
          end
          inherited btnExport: TButton
            Left = 639
            Visible = False
            OnClick = buttonOnClick
            ExplicitLeft = 639
          end
          inherited btnAction1: TButton
            OnClick = buttonOnClick
          end
          inherited btnAction2: TButton
            OnClick = buttonOnClick
          end
        end
      end
      inline Frame_Groups: TFrame_DBG
        Left = 0
        Top = 161
        Width = 768
        Height = 132
        Align = alClient
        Color = 4802889
        ParentBackground = False
        ParentColor = False
        TabOrder = 2
        ExplicitTop = 161
        ExplicitWidth = 768
        ExplicitHeight = 132
        inherited GroupBox1: TGroupBox
          Width = 768
          Height = 132
          Caption = 'Groups'
          ExplicitWidth = 768
          ExplicitHeight = 132
          inherited DBNavigator: TDBNavigator
            Width = 760
            DataSource = dm_database.DataSource_Groups
            Hints.Strings = ()
            ExplicitWidth = 760
          end
          inherited DBGrid: TDBGrid
            Width = 762
            Height = 58
            DataSource = dm_database.DataSource_Groups
          end
          inherited btnImport: TButton
            OnClick = buttonOnClick
          end
          inherited btnExport: TButton
            Left = 639
            Visible = False
            ExplicitLeft = 639
          end
          inherited btnAction1: TButton
            OnClick = buttonOnClick
          end
          inherited btnAction2: TButton
            OnClick = buttonOnClick
          end
        end
      end
    end
    object tsPlanAnalyze: TTabSheet
      Caption = 'Plan Analyze'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      inline Frame_PlanAnalyze: TFrame_DBG
        Left = 0
        Top = 0
        Width = 768
        Height = 598
        Align = alClient
        Color = 4802889
        ParentBackground = False
        ParentColor = False
        TabOrder = 0
        ExplicitLeft = 24
        ExplicitTop = 32
        ExplicitWidth = 768
        ExplicitHeight = 598
        inherited GroupBox1: TGroupBox
          Width = 768
          Height = 598
          Caption = ''
          ExplicitWidth = 768
          ExplicitHeight = 598
          inherited DBNavigator: TDBNavigator
            Width = 760
            DataSource = dm_database.DataSource_PlanAnalyze
            Hints.Strings = ()
            ExplicitWidth = 760
          end
          inherited DBGrid: TDBGrid
            Width = 762
            Height = 524
            DataSource = dm_database.DataSource_PlanAnalyze
          end
          inherited btnImport: TButton
            Visible = False
          end
          inherited btnExport: TButton
            Left = 639
            OnClick = buttonOnClick
            ExplicitLeft = 639
          end
        end
      end
    end
  end
end
