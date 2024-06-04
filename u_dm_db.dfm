object dm_database: Tdm_database
  OldCreateOrder = False
  Height = 387
  Width = 605
  object FDConnection: TFDConnection
    Params.Strings = (
      
        'Database=C:\RD\TMP\Work\entw\Delphi\BFS\Win64\Debug\testprojectB' +
        'FS.FDB'
      'User_Name=sysdba'
      'Password=mediking'
      'Server=127.0.0.1'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Transaction = FDTransaction
    UpdateTransaction = FDTransaction
    Left = 24
    Top = 8
  end
  object FDTransaction: TFDTransaction
    Connection = FDConnection
    Left = 112
    Top = 8
  end
  object FDQuery_Employees: TFDQuery
    Connection = FDConnection
    Transaction = FDTransaction
    UpdateTransaction = FDTransaction
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockWait, uvRefreshMode, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.LockWait = True
    UpdateOptions.RefreshMode = rmManual
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    UpdateObject = FDUpdateSQL_Employees
    SQL.Strings = (
      'select * from employees')
    Left = 24
    Top = 208
  end
  object FDUpdateSQL_Employees: TFDUpdateSQL
    Connection = FDConnection
    InsertSQL.Strings = (
      
        'insert into employees (e_id, e_name) values (:new_e_id, :New_e_n' +
        'ame);')
    ModifySQL.Strings = (
      'update employees e'
      'set e_name = :new_e_name'
      'where '
      '     e_id = :old_e_id;')
    DeleteSQL.Strings = (
      'delete from employees e'
      'where '
      '     e_id = :old_e_id;')
    Left = 24
    Top = 264
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 312
    Top = 8
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 440
    Top = 8
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 208
    Top = 8
  end
  object DataSource_Employee: TDataSource
    DataSet = FDQuery_Employees
    Left = 24
    Top = 320
  end
  object FDQuery_Groups: TFDQuery
    Connection = FDConnection
    Transaction = FDTransaction
    UpdateTransaction = FDTransaction
    UpdateObject = FDUpdateSQL_Groups
    SQL.Strings = (
      'select * from groups')
    Left = 139
    Top = 209
  end
  object FDUpdateSQL_Groups: TFDUpdateSQL
    Connection = FDConnection
    InsertSQL.Strings = (
      
        'insert into groups (g_id, g_name) values (:new_g_id, :New_g_name' +
        ');')
    ModifySQL.Strings = (
      'update groups'
      'set g_name = :new_g_name'
      'where '
      '     g_id = :old_g_id;')
    DeleteSQL.Strings = (
      'delete from groups'
      'where '
      '     g_id = :old_g_id;')
    Left = 139
    Top = 265
  end
  object DataSource_Groups: TDataSource
    DataSet = FDQuery_Groups
    Left = 139
    Top = 321
  end
  object FDQuery_GroupEmployee: TFDQuery
    Connection = FDConnection
    Transaction = FDTransaction
    UpdateTransaction = FDTransaction
    UpdateObject = FDUpdateSQL_GroupEmployee
    SQL.Strings = (
      'select '
      '  ge_id,'
      '  g_id,'
      
        '  (select g_name from groups g where g.g_id = ge.g_id) as "Group' +
        's",'
      '  e_id,'
      
        ' (select e_name from employees e where e.e_id = ge.e_id) as "Emp' +
        'loyee"'
      ' '
      'from groupemployee ge'
      'order by g_id, e_id')
    Left = 253
    Top = 207
  end
  object FDUpdateSQL_GroupEmployee: TFDUpdateSQL
    Connection = FDConnection
    InsertSQL.Strings = (
      '  insert into groupemployee ('
      '    ge_id,'
      '    g_id,'
      '    e_id)'
      '  values ('
      '    :new_ge_id,'
      '    :new_g_id,'
      '    :new_e_id);')
    ModifySQL.Strings = (
      '  update groupemployee'
      '  set ,'
      '      g_id = new_:g_id,'
      '      e_id = :new_e_id'
      '  where (ge_id = :old_ge_id);')
    DeleteSQL.Strings = (
      'delete   groupemployee'
      '  where (ge_id = :old_ge_id);')
    FetchRowSQL.Strings = (
      'select '
      '  ge_id,'
      '  g_id,'
      
        '  (select g_name from groups g where g.g_id = ge.g_id) as "Group' +
        's",'
      '  e_id,'
      
        ' (select e_name from employees e where e.e_id = ge.e_id) as "Emp' +
        'loyee"'
      ' '
      'from groupemployee ge'
      ''
      '  where (ge_id = :old_ge_id);')
    Left = 253
    Top = 263
  end
  object DataSource_GroupEmployee: TDataSource
    DataSet = FDQuery_GroupEmployee
    Left = 253
    Top = 319
  end
  object ClientDataSet_Employees: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 152
    Top = 88
  end
  object ClientDataSet_Groups: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 304
    Top = 88
  end
  object DataSource_CDEmployee: TDataSource
    DataSet = ClientDataSet_Employees
    Left = 152
    Top = 136
  end
  object DataSource_CDGroups: TDataSource
    DataSet = ClientDataSet_Groups
    Left = 304
    Top = 136
  end
  object FDQuery_Plan: TFDQuery
    Connection = FDConnection
    Transaction = FDTransaction
    UpdateTransaction = FDTransaction
    UpdateObject = FDUpdateSQL_Plan
    SQL.Strings = (
      'select '
      '  p_id,'
      '  p_date,'
      '  g_id,'
      
        '  (select g_name from groups g where g.g_id = p.g_id) as "Groups' +
        '",'
      '  e_id,'
      
        '  (select e_name from employees e where e.e_id = p.e_id) as "Emp' +
        'loyee"'
      ''
      'from planemployees p'
      'order by /*p.p_id,*/ p.p_date, p.g_id, p.e_id')
    Left = 389
    Top = 207
  end
  object FDUpdateSQL_Plan: TFDUpdateSQL
    Connection = FDConnection
    InsertSQL.Strings = (
      '  insert into planemployees ('
      '    p_id,'
      '    p_date,'
      '    g_id,'
      '    e_id)'
      '  values ('
      '    :new_p_id,'
      '    :new_p_date,'
      '    :new_g_id,'
      '    :new_e_id);')
    ModifySQL.Strings = (
      '  update planemployees'
      '  set p_date = :p_date,'
      '      g_id = :g_id,'
      '      e_id = :e_id'
      '  where (p_id = :old_p_id);')
    DeleteSQL.Strings = (
      '  delete from planemployees'
      '  where (p_id = :old_p_id);')
    FetchRowSQL.Strings = (
      'select '
      '  p_id,'
      '  p_date,'
      '  g_id,'
      
        '  (select g_name from groups g where g.g_id = p.g_id) as "Groups' +
        '",'
      '  e_id,'
      
        '  (select e_name from employees e where e.e_id = p.e_id) as "Emp' +
        'loyee"'
      ''
      'from planemployees p')
    Left = 389
    Top = 263
  end
  object DataSource_Plan: TDataSource
    DataSet = FDQuery_Plan
    Left = 389
    Top = 319
  end
  object FDQuery_PlanAnalyze: TFDQuery
    Connection = FDConnection
    Transaction = FDTransaction
    UpdateTransaction = FDTransaction
    SQL.Strings = (
      'with g_pe as ('
      'select'
      '   p.e_id, p.g_id, count(*) as "Count"'
      'from planemployees p'
      'group by 1,2'
      'order by 1'
      ')'
      'select'
      
        '   (select e_name from employees e where e.e_id=p.e_id) as "Empl' +
        'oyee",'
      
        '   (select g_name from groups g where g.g_id = p.g_id) as "Group' +
        '",'
      '   "Count"'
      'from g_pe  p'
      ';')
    Left = 509
    Top = 207
  end
  object DataSource_PlanAnalyze: TDataSource
    DataSet = FDQuery_PlanAnalyze
    Left = 509
    Top = 319
  end
end
