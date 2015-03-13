unit LazAnimais_DataModule;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, LResources, Forms, Controls, Dialogs,
  ZConnection, ZDataset;

type

  { TDM }

  TDM = class(TDataModule)
    DatasourceAnimalCaracteristica: TDatasource;
    DatasourceCaracteristica: TDatasource;
    DatasourceAnimal: TDatasource;
    ZConnectionLazAnimais: TZConnection;
    ZQueryGeral: TZQuery;
    ZQueryAnimalCaracteristica: TZQuery;
    ZQueryAnimalCaracteristicacaracteristica: TStringField;
    ZQueryAnimalcodigo: TLongintField;
    ZQueryAnimalnome: TStringField;
    ZQueryCaracteristica: TZQuery;
    ZQueryAnimal: TZQuery;
    ZQueryCaracteristicacodigo: TLongintField;
    ZQueryCaracteristicanome: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure ZQueryAnimalAfterScroll(DataSet: TDataSet);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  DM: TDM;

implementation

{ TDM }

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  try
    ZConnectionLazAnimais.Database := ExtractFilePath(Application.ExeName) + 'LazAnimais.db';
    if not ZConnectionLazAnimais.Connected   then ZConnectionLazAnimais.Connect;
    if not ZQueryAnimal.Active               then ZQueryAnimal.Active := true;
    if not ZQueryCaracteristica.Active       then ZQueryCaracteristica.Active := true;
    if not ZQueryAnimalCaracteristica.Active then ZQueryAnimalCaracteristica.Active := true;
  except
  end;
end;

procedure TDM.ZQueryAnimalAfterScroll(DataSet: TDataSet);
begin
  if ZQueryAnimal.State in [dsInsert] then
    ZQueryAnimalCaracteristica.Close
  else
    try
      ZQueryAnimalCaracteristica.Close;
      ZQueryAnimalCaracteristica.SQL.Clear;
      ZQueryAnimalCaracteristica.SQL.Add('SELECT (SELECT nome FROM caracteristica WHERE codigo = codigo_caracteristica) as caracteristica');
      ZQueryAnimalCaracteristica.SQL.Add('FROM animal_caracteristica');
      ZQueryAnimalCaracteristica.SQL.Add('WHERE codigo_animal = ' + ZQueryAnimal.FieldByName('codigo').AsString);
      ZQueryAnimalCaracteristica.Open;
    finally
    end;
end;

initialization
  {$I LazAnimais_DataModule.lrs}

end.

