unit LazAnimais_FormCadastro;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, Buttons, DBGrids, DbCtrls, ComCtrls;

type

  { TFormCadastro }

  TFormCadastro = class(TForm)
    BitBtnFechar: TBitBtn;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DBGrid3: TDBGrid;
    DBNavigator1: TDBNavigator;
    DBNavigator2: TDBNavigator;
    DBNavigator3: TDBNavigator;
    PageControlCadastro: TPageControl;
    TabSheetAnimais: TTabSheet;
    TabSheetCaracteristicas: TTabSheet;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  FormCadastro: TFormCadastro;

implementation

uses
  LazAnimais_DataModule;

{ TFormCadastro }

procedure TFormCadastro.FormCreate(Sender: TObject);
begin
  // Centraliza form
  Left := (Screen.Width  div 2) - (Width div 2);
  Top  := (Screen.Height div 2) - (Height div 2);
  //
  PageControlCadastro.ActivePageIndex := 0;
end;

procedure TFormCadastro.FormShow(Sender: TObject);
begin
  try
    if not DM.ZConnectionLazAnimais.Connected   then DM.ZConnectionLazAnimais.Connect;
    if not DM.ZQueryAnimal.Active               then DM.ZQueryAnimal.Active := true;
    if not DM.ZQueryCaracteristica.Active       then DM.ZQueryCaracteristica.Active := true;
    if not DM.ZQueryAnimalCaracteristica.Active then DM.ZQueryAnimalCaracteristica.Active := true;
  except
  end;
end;

initialization
  {$I LazAnimais_FormCadastro.lrs}

end.

