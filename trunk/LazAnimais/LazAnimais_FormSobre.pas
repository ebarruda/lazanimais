unit LazAnimais_FormSobre;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, Buttons, StdCtrls;

type

  { TFormSobre }

  TFormSobre = class(TForm)
    BitBtnFechar: TBitBtn;
    Image1: TImage;
    MemoLazAnimais: TMemo;
    Panel1: TPanel;
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  FormSobre: TFormSobre;

implementation

{ TFormSobre }

procedure TFormSobre.FormCreate(Sender: TObject);
begin
  // Centraliza form
  Left := (Screen.Width  div 2) - (Width div 2);
  Top  := (Screen.Height div 2) - (Height div 2);
end;

initialization
  {$I LazAnimais_FormSobre.lrs}

end.

