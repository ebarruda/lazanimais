program LazAnimais;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, LazAnimais_FormPrincipal, LResources, LazAnimais_FormSobre,
LazAnimais_DataModule, zcomponent, LazAnimais_FormCadastro, LazAnimais_FormJogo
  { you can add units after this };

{$IFDEF WINDOWS}{$R LazAnimais.rc}{$ENDIF}

begin
  {$I LazAnimais.lrs}
  Application.Initialize;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.CreateForm(TFormSobre, FormSobre);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFormCadastro, FormCadastro);
  Application.CreateForm(TFormJogo, FormJogo);
  Application.Run;
end.

