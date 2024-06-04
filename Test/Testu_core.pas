unit Testu_core;
{

  Delphi DUnit-Testfall
  ----------------------
  Diese Unit enthält ein Skeleton einer Testfallklasse, das vom Experten für Testfälle erzeugt wurde.
  Ändern Sie den erzeugten Code so, dass er die Methoden korrekt einrichtet und aus der 
  getesteten Unit aufruft.

}

interface

uses
  TestFramework, Classes, db, u_core;

type
  // Testmethoden für Klasse T_CoreClass

  TestT_CoreClass = class(TTestCase)
  strict private
    F_CoreClass: T_CoreClass;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestgeneratePlan;
  end;

implementation

uses
  SysUtils
  , DateUtils
  ;

procedure TestT_CoreClass.SetUp;
begin
  F_CoreClass := T_CoreClass.Create;
end;

procedure TestT_CoreClass.TearDown;
begin
  F_CoreClass.Free;
  F_CoreClass := nil;
end;

procedure TestT_CoreClass.TestgeneratePlan;
var
  aPlanType: Integer;
  aYear: TDate;
begin
  // TODO: Methodenaufrufparameter einrichten
  aYear := StrToDate('01.01.2024');
  aPlanType := -1;
  F_CoreClass.generatePlan(aYear, aPlanType);
  aPlanType := 0;
  F_CoreClass.generatePlan(aYear, aPlanType);
  aPlanType := 1;
  F_CoreClass.generatePlan(aYear, aPlanType);
  aPlanType := 2;
  F_CoreClass.generatePlan(aYear, aPlanType);
  aPlanType := 3;
  F_CoreClass.generatePlan(aYear, aPlanType);
  aPlanType := 10000;
  F_CoreClass.generatePlan(aYear, aPlanType);
  // TODO: Methodenergebnisse prüfen
end;

initialization
  // Alle Testfälle beim Testprogramm registrieren
  RegisterTest(TestT_CoreClass.Suite);
end.

