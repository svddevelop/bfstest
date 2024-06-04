unit u_dm_db;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.Client, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Phys.FBDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteDef, FireDAC.Phys.SQLite, FireDAC.Phys.IBBase,
  FireDAC.Phys.FB, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Datasnap.DBClient;

type
  Tdm_database = class(TDataModule)
    FDConnection: TFDConnection;
    FDTransaction: TFDTransaction;
    FDQuery_Employees: TFDQuery;
    FDUpdateSQL_Employees: TFDUpdateSQL;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    DataSource_Employee: TDataSource;
    FDQuery_Groups: TFDQuery;
    FDUpdateSQL_Groups: TFDUpdateSQL;
    DataSource_Groups: TDataSource;
    FDQuery_GroupEmployee: TFDQuery;
    FDUpdateSQL_GroupEmployee: TFDUpdateSQL;
    DataSource_GroupEmployee: TDataSource;
    ClientDataSet_Employees: TClientDataSet;
    ClientDataSet_Groups: TClientDataSet;
    DataSource_CDEmployee: TDataSource;
    DataSource_CDGroups: TDataSource;
    FDQuery_Plan: TFDQuery;
    FDUpdateSQL_Plan: TFDUpdateSQL;
    DataSource_Plan: TDataSource;
    FDQuery_PlanAnalyze: TFDQuery;
    DataSource_PlanAnalyze: TDataSource;
  public
    type
      T_DMDBT = ( dmdbtSQLite, dmdbtFirebird);
  public
    procedure create_sqlite();
    procedure setup_sqlite();
    procedure create_firebird();
    procedure setup_firebird();
    function getDbFileName( const aDBType: T_DMDBT): String;

    procedure open_db( aDBType: T_DMDBT = dmdbtSQLite);
  end;

var
  dm_database: Tdm_database;

implementation



{$R *.dfm}

{ Tdm_database }

procedure Tdm_database.create_firebird;
begin
  setup_firebird();
  FDConnection.Params.Add('PAGE_SIZE 4096');
  FDConnection.Params.Add('DEFAULT CHARACTER SET UTF8');

  FDConnection.Connected := True;
  FDConnection.ExecSQL('create database  ''' + FDConnection.Params.Values['Server']
     + ':'
     + FDConnection.Params.Database + ''' '
     + ' user ''' + FDConnection.Params.UserName + ''' '
     + ' password ''' + FDConnection.Params.Password + ''' '
     + ' DEFAULT CHARACTER SET UTF8;'
   );

end;

procedure Tdm_database.create_sqlite;
const
  c_create_table = 'create table if not exists ';
  c_tbl1 = 'EMPLOYEES (E_ID INTEGER NOT NULL, E_NAME VARCHAR(50));';
  c_tbl3 = 'GROUPEMPLOYEE (GE_ID INTEGER NOT NULL,G_ID INTEGER,E_ID INTEGER);';
  c_tbl2 = 'GROUPS (G_ID INTEGER NOT NULL,G_NAME  VARCHAR(20),E_ID INTEGER);';
  c_tbl4 = 'PLANEMPLOYEES (P_ID INTEGER NOT NULL,P_DATE  DATE,G_ID INTEGER,E_ID INTEGER);';
begin
  setup_sqlite();
  FDConnection.Connected := True;
  FDConnection.ExecSQL(
        c_create_table
        + c_tbl1
  );
  FDConnection.ExecSQL(
        c_create_table
        + c_tbl2
  );
  FDConnection.ExecSQL(
        c_create_table
        + c_tbl3
        );
  FDConnection.ExecSQL(
        c_create_table
        + c_tbl4
        );
  if FDConnection.Transaction.Active then
     FDConnection.Transaction.Commit;
end;

function Tdm_database.getDbFileName(const aDBType: T_DMDBT): String;
begin
  if aDBType = dmdbtSQLite then
    Result := '.sqlite'
  else
  if aDBType = dmdbtFirebird then
    Result := '.fdb';
  Result :=  ChangeFileExt( ParamStr(0), Result);
end;

procedure Tdm_database.open_db;
var
  i : Integer;
begin
  if FDConnection.Connected then
    FDConnection.Connected := False;

  case aDBType of
    dmdbtSQLite:    setup_sqlite();
    dmdbtFirebird:  setup_firebird();
  end;


  FDConnection.Connected      := True;
  for i  := 0 to ComponentCount-1 do
    if Components[i] is TDataSet then
       (Components[i] as TDataSet).Active := True;


end;

procedure Tdm_database.setup_firebird;
begin
    FDConnection.Params.DriverID := 'FB';
    FDConnection.Params.Database := getDbFileName(dmdbtFirebird);
    FDConnection.Params.UserName := 'sysdba';
    FDConnection.Params.Password := 'mediking';
    FDConnection.Params.Add('Server=127.0.0.1');
    FDConnection.Params.Add('Protocol=TCPIP');
    FDConnection.Params.Add('CharacterSet=UTF8');
end;

procedure Tdm_database.setup_sqlite;
begin
    FDConnection.Params.DriverID := 'SQLite';
    FDConnection.Params.Database := getDbFileName(dmdbtSQLite);
    //FDConnection.Connected := True;
end;

end.
