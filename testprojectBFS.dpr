program testprojectBFS;

uses
  Vcl.Forms,
  u_mainform in 'u_mainform.pas' {FormMain},
  u_import in 'u_import.pas',
  u_dm_db in 'u_dm_db.pas' {dm_database: TDataModule},
  u_dbframe in 'u_dbframe.pas' {Frame_DBG: TFrame},
  u_core in 'u_core.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(Tdm_database, dm_database);
  Application.Run;
end.
