unit u_dbframe;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.StdCtrls;

type
  TFrame_DBG = class(TFrame)
    GroupBox1: TGroupBox;
    DBNavigator: TDBNavigator;
    DBGrid: TDBGrid;
    btnImport: TButton;
    btnExport: TButton;
    btnAction1: TButton;
    btnAction2: TButton;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

implementation

{$R *.dfm}

end.
