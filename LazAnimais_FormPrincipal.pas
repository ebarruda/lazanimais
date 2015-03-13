unit LazAnimais_FormPrincipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  Menus;

type

  { TFormPrincipal }

  TFormPrincipal = class(TForm)
    MainMenuLazAnimais: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItemJogoNovo: TMenuItem;
    MenuItemJogoSep: TMenuItem;
    MenuItemJogoSair: TMenuItem;
    MenuItemJogoSobre: TMenuItem;
    MenuItemCadastro: TMenuItem;
    MenuItemCadastroAnimais: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure MenuItemCadastroAnimaisClick(Sender: TObject);
    procedure MenuItemJogoNovoClick(Sender: TObject);
    procedure MenuItemJogoSairClick(Sender: TObject);
    procedure MenuItemJogoSobreClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  FormPrincipal: TFormPrincipal;

implementation

uses
  LazAnimais_FormSobre, LazAnimais_FormCadastro, LazAnimais_FormJogo;

{ TFormPrincipal }

procedure TFormPrincipal.MenuItemJogoSobreClick(Sender: TObject);
begin
  FormSobre.ShowModal;
end;

procedure TFormPrincipal.MenuItemJogoSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFormPrincipal.FormCreate(Sender: TObject);
begin
  // Centraliza form
  Left := (Screen.Width  div 2) - (Width div 2);
  Top  := (Screen.Height div 2) - (Height div 2);
end;

procedure TFormPrincipal.MenuItemCadastroAnimaisClick(Sender: TObject);
begin
  FormCadastro.ShowModal;
end;

procedure TFormPrincipal.MenuItemJogoNovoClick(Sender: TObject);
begin
  FormJogo.ShowModal;
end;

initialization
  {$I LazAnimais_FormPrincipal.lrs}

end.

