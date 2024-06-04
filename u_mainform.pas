unit u_mainform;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.DBCtrls, u_dbframe;

type
  TFormMain = class(TForm)
    PageControl: TPageControl;
    tsGererationIncoming: TTabSheet;
    tsPlanGeneration: TTabSheet;
    Frame_Employees: TFrame_DBG;
    SplitterPlanGenerationTop: TSplitter;
    Frame_Plan1: TFrame_DBG;
    SplitterPlanGenerationBottom: TSplitter;
    Frame_Groups: TFrame_DBG;
    tsCDS: TTabSheet;
    Frame_CDEmployee: TFrame_DBG;
    Splitter1: TSplitter;
    Frame_CDGroups: TFrame_DBG;
    gb_GeneratonCSV: TGroupBox;
    btn_create_sqlitedb: TButton;
    ComboBox_DBtype: TComboBox;
    btn_generate_csv: TButton;
    l_EmployeesCount: TLabel;
    edt_EmployeesCount: TEdit;
    l_groupsCount: TLabel;
    edt_GroupsCount: TEdit;
    gb_GenerationCore: TGroupBox;
    btnCSV2CDS: TButton;
    btnEmploees2groups: TButton;
    btnCoreEG2db: TButton;
    gb_GenerationPlan: TGroupBox;
    cb_GenerationPlanType: TComboBox;
    btnGeneratePlan: TButton;
    DateTimePicker1: TDateTimePicker;
    tsPlanAnalyze: TTabSheet;
    Frame_PlanAnalyze: TFrame_DBG;
    procedure PageControlChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure buttonOnClick(Sender: TObject);
    procedure DateTimePicker1Change(Sender: TObject);
  public
    type TProc = procedure of Object;
    procedure exec_proc_withHourGlassCursor(aProc: TProc);
  public
    procedure export2csv;
    procedure import_employee2db;
    procedure import_groups2db;

    procedure importCSV2DS;
    procedure importCSV2DS_Employees;
    procedure importCSV2DS_Groups;
    procedure exportCDEmployee2core;
    procedure exportCDGroups2core;
    procedure fromCore2db; // copy of data to the database tables.
    procedure generatePlan;
    procedure exportPlanAnalyze2csv;
  end;

var
  FormMain: TFormMain;

implementation

uses
    u_dm_db
  , u_import
  , u_core
  ;


{$R *.dfm}

procedure TFormMain.buttonOnClick(Sender: TObject);
var
  btn: TButton absolute Sender;
begin
  btn.Enabled := False;
  if btn = btn_generate_csv then
    exec_proc_withHourGlassCursor( export2csv );
  if btn = btn_create_sqlitedb then
    exec_proc_withHourGlassCursor( dm_database.create_sqlite );

  if btn = Frame_Employees.btnImport then
      exec_proc_withHourGlassCursor(import_employee2db);
  if btn = Frame_Groups.btnImport then
      exec_proc_withHourGlassCursor(import_employee2db);

  //Step 1: from CSV to ClientDatasets
  if btn = btnCSV2CDS then
      exec_proc_withHourGlassCursor(importCSV2DS);

  if btn = Frame_CDEmployee.btnImport then
      exec_proc_withHourGlassCursor(importCSV2DS_Employees);
  if btn = Frame_CDGroups.btnImport then
      exec_proc_withHourGlassCursor(importCSV2DS_Groups);

  if btn = Frame_CDEmployee.btnAction1 then
      exec_proc_withHourGlassCursor(exportCDEmployee2core);
  if btn = Frame_CDGroups.btnAction1 then
      exec_proc_withHourGlassCursor(exportCDGroups2core);

  //step 2:
  if btn = btnEmploees2groups then
    CoreObject.generate_employees2groups;

  //Step 3:
  if btn = btnCoreEG2db then
    exec_proc_withHourGlassCursor(fromCore2db);

  if btn = btnGeneratePlan then
    exec_proc_withHourGlassCursor(generatePlan);

  if btn = Frame_PlanAnalyze.btnExport then
    exec_proc_withHourGlassCursor(exportPlanAnalyze2csv);


  btn.Enabled := True;
end;

procedure TFormMain.DateTimePicker1Change(Sender: TObject);
var
  d, m, y : Word;
begin
  decodedate( DateTimePicker1.Date, y, m, d);
  m := 1;
  d := 1;
  DateTimePicker1.Date := encodedate( y, m, d);
end;

procedure TFormMain.exec_proc_withHourGlassCursor(aProc: TProc);
begin
  try
    Screen.Cursor := crHourGlass;
    Application.ProcessMessages;
    aProc;
  finally
    Screen.Cursor := crDefault;
    Application.ProcessMessages;
  end;
end;

procedure TFormMain.export2csv;
var
  i : Integer;
begin
    if  TryStrToInt(edt_EmployeesCount.Text, i) then
        u_import.T_Import.write2csvfile('employees', i, 'Mitarbeiter');

    if  TryStrToInt(edt_GroupsCount.Text, i) then
        u_import.T_Import.write2csvfile('groups', i, 'Group');
    Sleep(1000);
end;

procedure TFormMain.exportCDEmployee2core;
begin
  CoreObject.dataset2employees( dm_database.ClientDataSet_Employees );
end;

procedure TFormMain.exportCDGroups2core;
begin
  CoreObject.dataset2groups( dm_database.ClientDataSet_Groups );
end;

procedure TFormMain.exportPlanAnalyze2csv;
var
  s : String;
begin
  with TSaveDialog.Create(self) do
  try
    s := 'plan.csv';
    FileName := u_import.T_Import.get_path() + s;
    if execute then
      T_Import.export_to_csv(s, dm_database.FDQuery_PlanAnalyze, False);
  finally
    Free;
  end;
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  PageControl.ActivePageIndex := 0;
  ComboBox_DBtype.ItemIndex := 1;
  DateTimePicker1.OnChange(Self);
end;

procedure TFormMain.fromCore2db;
begin
  with dm_database do
  begin
    FDQuery_Employees.Active := False;
    FDQuery_Groups.Active := False;
    FDQuery_GroupEmployee.Active := False;
    FDQuery_Plan.Active := False;
    FDConnection.ExecSQL('delete from PLANEMPLOYEES');
    FDConnection.ExecSQL('delete from GROUPEMPLOYEE');
    FDConnection.ExecSQL('delete from employees');
    FDConnection.ExecSQL('delete from groups');
    if FDTransaction.Active then
       FDTransaction.Commit;
    FDQuery_Employees.Active := True;
    CoreObject.employees2dataset(dm_database.FDQuery_Employees);


    FDQuery_Groups.Active := True;
    CoreObject.groups2dataset(dm_database.FDQuery_Groups);

    FDQuery_GroupEmployee.Active := True;
    CoreObject.groupemployees2dataset(dm_database.FDQuery_GroupEmployee);

  end;
end;

procedure TFormMain.generatePlan;
begin
  dm_database.FDQuery_PlanAnalyze.Active := False;
  CoreObject.generatePlan(DateTimePicker1.Date, cb_GenerationPlanType.ItemIndex);
  dm_database.FDQuery_Plan.Active := False;
  dm_database.FDConnection.ExecSQL('delete from planemployees');
  dm_database.FDQuery_Plan.Active := True;
  CoreObject.plan2dataset( dm_database.FDQuery_Plan );
  dm_database.FDQuery_PlanAnalyze.Active := True;
end;

procedure TFormMain.importCSV2DS;
begin
   importCSV2DS_Employees;
   importCSV2DS_Groups;
   exportCDEmployee2core;
   exportCDGroups2core;
end;

procedure TFormMain.importCSV2DS_Employees;
begin
   dm_database.ClientDataSet_Employees.Active := False;
   with dm_database.ClientDataSet_Employees do
   begin
    Active := False;
    FieldDefs.Clear;
    FieldDefs.Add('e_id', ftInteger);
    FieldDefs.Add('e_name', ftString, 50);
    CreateDataSet;
    Active := True;
   end;
   T_Import.import_from_csv('employees.csv' , dm_database.ClientDataSet_Employees);
end;

procedure TFormMain.importCSV2DS_Groups;
begin
   dm_database.ClientDataSet_Groups.Active := False;
   with dm_database.ClientDataSet_Groups do
   begin
    Active := False;
    FieldDefs.Clear;
    FieldDefs.Add('g_id', ftInteger);
    FieldDefs.Add('g_name', ftString, 50);
    CreateDataSet;
    Active := True;
   end;
   T_Import.import_from_csv('groups.csv' , dm_database.ClientDataSet_Groups);
end;

procedure TFormMain.import_employee2db;
begin
  dm_database.FDConnection.ExecSQL('delete from employees');
  with T_Import do
    T_Import.import_from_csv(  'employees.csv', dm_database.FDQuery_Employees  );
end;

procedure TFormMain.import_groups2db;
begin
//  dm_database.FDConnection.ExecSQL('delete from employees');
//  with T_Import do
//    T_Import.import_from_csv(  'employees.csv', dm_database.FDQuery_Employees  );
end;

procedure TFormMain.PageControlChange(Sender: TObject);
var
  dbt : Tdm_database.T_DMDBT;
begin
  dbt :=  Tdm_database.T_DMDBT(ComboBox_DBtype.ItemIndex);
  if PageControl.ActivePage = tsPlanGeneration then
      dm_database.open_db(dbt);
end;

end.
