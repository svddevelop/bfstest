unit u_core;

interface

uses
    Classes
  , db
  ;

const
  C_CNT_MaxEmployees = 20;
  C_CNT_MaxGroups    = 2;

  C_PLANTYPE_EveryDay     = 0;
  C_PLANTYPE_EveryWeek    = 1;
  C_PLANTYPE_EveryMonth   = 2;

type

  T_EmployeeRec = record
    e_id    : Integer;
    e_name  : String;
  end;

  T_GroupRec = record
    g_id        : Integer;
    g_name      : String;
    arrEmployees: TArray<T_EmployeeRec>;
    procedure init;
  end;



  T_PlanRec = record
    p_id      : Integer;
    p_date    : TDate;
    e_id, g_id: Integer;
    procedure init(aRecG:T_GroupRec; aRecE: T_EmployeeRec);
  end;

  T_CoreRec = record
    employees             : TArray<T_EmployeeRec>;
    groups                : TArray<T_GroupRec>;
    plan                  : TArray<T_PlanRec>;
    MaxEmployee, MaxGroups: Integer;
    Year                  : TDate;
    procedure init;
  end;

  T_CoreClass = class
  public
    Core        : T_CoreRec;
    PlanKeyIndex: Integer;
  public
    function addToArray<T>(var aArray:TArray<T>; var aRec: T): Integer;
    function add2array<T>(var aArray:TArray<T>; var aRec: T; var aIdx: Integer): Pointer;

    procedure employees2dataset( aDS: TDataSet);
    procedure groups2dataset( aDS: TDataSet);
    procedure groupemployees2dataset( aDS: TDataSet);
    procedure dataset2employees( aDS: TDataSet);
    procedure dataset2groups( aDS: TDataSet);

    procedure plan2dataset( aDS: TDataSet );

    procedure generate_employees2groups;
    procedure copyGroups2Plan( aDate: TDate);
    procedure generatePlan(aYear: TDate; aPlanType: Integer);

    constructor Create;
    destructor Destroy; override;
  end;

var
  CoreObject : T_CoreClass;

implementation

uses

    Math
  , DateUtils
  , SysUtils
  ;

procedure T_CoreRec.init();
begin
  SetLength(employees, 0);
  SetLength(groups, 0);
  SetLength(plan, 0);
end;

{ T_Group }

procedure T_GroupRec.init;
begin
  SetLength( Self.arrEmployees, 0);
end;

{ T_CoreClass }

function T_CoreClass.add2array<T>(var aArray: TArray<T>; var aRec: T; var aIdx: Integer): Pointer;
begin
  aIdx := addToArray<T>( aArray, aRec);
  Result := @aArray[aIdx];
end;

function T_CoreClass.addToArray<T>(var aArray: TArray<T>; var aRec: T): Integer;
begin
  Result := Length(aArray);
  SetLength(aArray, Result +1);
  aArray[Result] := aRec;
end;

procedure T_CoreClass.copyGroups2Plan( aDate: TDate);
var
  recg : T_GroupRec;
  rece : T_EmployeeRec;
  recp : T_PlanRec;
begin
  recp.p_id := 0;
  for recg in Core.groups do
    for rece in recg.arrEmployees do
    begin
      recp.init(recg, rece);
      recp.p_date := aDate;
      inc(recp.p_id);
      addToArray<T_PlanRec>( Core.plan, recp);
    end;
end;

constructor T_CoreClass.Create;
begin
  Core.init;
end;

procedure T_CoreClass.dataset2employees( aDS: TDataSet);
var
  rec: T_EmployeeRec;
begin
  SetLength(Core.employees, 0);
  if aDS.Active then
  begin
    aDS.First;
    repeat
       rec.e_id := aDS.FieldValues['e_id'];
       rec.e_name := aDS.FieldValues['e_name'];
       addToArray<T_EmployeeRec>(Core.employees, rec);
       aDS.Next;
    until aDS.Eof;
  end;
end;

procedure T_CoreClass.dataset2groups( aDS: TDataSet);
var
  rec: T_GroupRec;
begin
  SetLength(Core.groups, 0);
  if aDS.Active then
  begin
    aDS.First;
    repeat
       rec.init;
       rec.g_id := aDS.FieldValues['g_id'];
       rec.g_name := aDS.FieldValues['g_name'];
       addToArray<T_GroupRec>(Core.groups, rec);
       aDS.Next;
    until aDS.Eof;
  end;
end;

destructor T_CoreClass.Destroy;
begin
  Core.init;
  inherited;
end;

procedure T_CoreClass.employees2dataset( aDS: TDataSet);
var
  rec: T_EmployeeRec;
begin
  if aDS.Active then
    for rec in Core.employees do
    begin
      aDS.Insert;
      aDS.FieldValues['e_id'] := rec.e_id;
      aDS.FieldValues['e_name'] := rec.e_name;
      aDS.Post;
    end;
end;


procedure T_CoreClass.generate_employees2groups;
var
  erec, rec: T_EmployeeRec;
  grec: T_GroupRec;
  mg, me: Integer;
  I: Integer;
begin
  mg := length(Core.groups);
  for erec in Core.employees do
  begin
    i := Random( 100 );
    i := i mod mg;
    if i >= mg then dec(i);

    rec := eRec;
    addToArray<T_EmployeeRec>(Core.groups[i].arrEmployees, rec);

  end;


end;

procedure T_CoreClass.generatePlan(aYear: TDate; aPlanType: Integer);
var
  calcDate, endDate: TDate;
  recg : T_GroupRec;
  i : Integer;
begin
  Core.Year := aYear;
  calcDate := aYear;
  endDate := IncYear(aYear);
  SetLength(Core.plan, 0);
  PlanKeyIndex := 1;

  while (calcDate < endDate) do
  begin

    for i := 0 to length(Core.groups)-1 do
      Core.groups[i].init;

    generate_employees2groups();
    copyGroups2Plan( calcDate );

     case aPlanType of
        C_PLANTYPE_EveryDay
              : calcDate := calcDate+1;

        C_PLANTYPE_EveryWeek
              : calcDate := calcDate + 7;
        C_PLANTYPE_EveryMonth
              : calcDate := IncMonth(calcDate, 1);
     end;
  end;  //*while()


end;

procedure T_CoreClass.groupemployees2dataset( aDS: TDataSet);
var
  recg: T_GroupRec;
  rece: T_EmployeeRec;
  I: Integer;
begin
  i := 1;
  if aDS.Active then
    for recg in Core.groups do
      for rece in recg.arrEmployees do
      begin
        aDS.Insert;
        aDS.FieldValues['ge_id'] := i;
        aDS.FieldValues['g_id'] := recg.g_id;
        aDS.FieldValues['e_id'] := rece.e_id;
        aDS.Post;
        inc(i);
      end;
end;

procedure T_CoreClass.groups2dataset( aDS: TDataSet);
var
  rec: T_GroupRec;
begin
  if aDS.Active then
    for rec in Core.groups do
    begin
      aDS.Insert;
      aDS.FieldValues['g_id'] := rec.g_id;
      aDS.FieldValues['g_name'] := rec.g_name;
      aDS.Post;
    end;
end;

procedure T_CoreClass.plan2dataset(aDS: TDataSet);
var
  rec: T_PlanRec;
begin
  if aDS.Active then
    for rec in Core.plan do
    begin
      aDS.Insert;
      aDS.FieldValues['p_id']   := rec.p_id;
      aDS.FieldValues['p_date'] := rec.p_date;
      aDS.FieldValues['g_id']   := rec.g_id;
      aDS.FieldValues['e_id']   := rec.e_id;
      aDS.Post;
    end;
end;

{ T_PlanRec }

procedure T_PlanRec.init(aRecG: T_GroupRec; aRecE: T_EmployeeRec);
begin
  Self.e_id := aRecE.e_id;
  Self.g_id := aRecG.g_id;
  if Assigned(CoreObject) then
  begin
    Self.p_id := CoreObject.PlanKeyIndex;
    inc(CoreObject.PlanKeyIndex);
  end;
end;

initialization

   CoreObject := T_CoreClass.Create;

finalization

  CoreObject.Core.init;
  FreeAndNil(CoreObject);

end.
