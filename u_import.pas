unit u_import;

interface

uses
    classes
  , db
  ;

type
  T_Import  = class
  public
    const C_NOT_READ = -1;
  public
//    type
//      PString = ^String;
//      TCallBackProc = procedure( aStr: PString; var aInt: Integer);
  public
    //import from a CSV-file to a Dataset
    class function import_from_csv( aFileName: string; aDS: TDataSet): Integer;
    //export from a dataset to a CSV-file
    class function export_to_csv( aFileName: string; aDS: TDataSet; const ommitFieldNames: Boolean = False): Boolean;
  public
    class procedure write2csvfile( aFileName: String; aMaxCount: Integer; const aFmtName: String);
    class function get_path: String;
  end;

implementation

uses
    strUtils
  , SysUtils
  , Math
  ;

{ T_Import }

class function T_Import.export_to_csv( aFileName: string; aDS: TDataSet; const ommitFieldNames: Boolean = False): Boolean;
var
  s : AnsiString;
  i,j : Integer;
begin
  Result := False;
  aFileName := get_path() + aFileName;
  if aDS.Active then
    with TFileStream.Create( aFileName, fmCreate) do
    try
      SetLength(s, 0);
      j := aDS.FieldCount-1;
      if not ommitFieldNames then
      begin
        for i := 0 to j do
          s := s + aDS.Fields[i].FieldName
              + IfThen(i = j, '', ';');
        s := s +#13#10;
        WriteBuffer( pointer(s)^, length(s));
      end;
      aDS.First;
      repeat
        SetLength(s, 0);
        for i := 0 to j do
          s := s + aDS.Fields[i].AsString
              + IfThen(i = j, '', ';');
        s := s +#13#10;

        WriteBuffer( pointer(s)^, length(s));
        aDS.Next;
      until aDS.Eof;
    finally
      Free;
      Result := True;
    end;
end;

class function T_Import.get_path: String;
begin
  Result := ExtractFilePath(ParamStr(0));
end;

class function T_Import.import_from_csv( aFileName: string; aDS: TDataSet): Integer;
var
  sr: TStreamReader;
  s : String;
  sa: TArray<String>;
  i,j : Integer;
begin
  Result := C_NOT_READ;
  aFileName := get_path() + aFileName;
  if  FileExists(aFileName) and ( aDS.Active) then
  begin
    sr := TStreamReader.Create(aFileName, TEncoding.UTF8);
    try
      inc(Result);
      while not sr.EndOfStream do
      begin
        s := sr.ReadLine;
        sa := s.Split([';']);

        j := min( Length(sa), aDs.FieldCount); // es kann sein, dass sa ist ungültig
        if j > 0 then
        begin
          aDS.Insert;
          for I := 0 to j-1 do
            aDS.Fields[i].AsString := sa[i];
          aDS.Post;
        end;

        inc(Result);
      end;
    finally
      sr.Free;
    end;
  end;
end;

class procedure T_Import.write2csvfile( aFileName: String; aMaxCount: Integer; const aFmtName: String);
var
  s : AnsiString;
  cnt : Integer;
begin
  aFileName := get_path() + aFileName + '.csv';
  with TFileStream.Create(aFileName, fmCreate) do
  try
    while True do
    begin
       s := Format('%d;%s %d', [aMaxCount, aFmtName, aMaxCount])+ #13#10;
       if aMaxCount = 0 then
          break;
       WriteBuffer(pointer(s)^, length(s));
       dec( aMaxCount );
    end;

  finally
    Free;
  end;
end;

end.
