unit LazAnimais_FormJogo;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls, Buttons, ExtCtrls, LCLProc;

type

  { TFormJogo }

  TFormJogo = class(TForm)
    BitBtnVoltar: TBitBtn;
    BitBtnAvancar: TBitBtn;
    ButtonAdicionar: TButton;
    ButtonRemover: TButton;
    ComboBoxCaracteristica: TComboBox;
    EditAnimal: TEdit;
    LabelMensagem: TLabel;
    LabelCaracteristica: TLabel;
    ListBoxCaracteristica: TListBox;
    RadioButtonSim: TRadioButton;
    RadioButtonNao: TRadioButton;
    procedure BitBtnAvancarClick(Sender: TObject);
    procedure BitBtnVoltarClick(Sender: TObject);
    procedure ButtonAdicionarClick(Sender: TObject);
    procedure ButtonRemoverClick(Sender: TObject);
    procedure EditAnimalChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure RadioButtonNaoChange(Sender: TObject);
    procedure RadioButtonSimChange(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    StringListCaracteristica: TStringList; // Codigos das caracteristicas
    StringListCaracteristicaSelecionada: TStringList; // Codigos das caracteristicas selecionadas
    Passo: ShortInt;
    procedure Passos(Incremento: ShortInt);
    procedure RadioButtonSimNaoChange;
  end;

var
  FormJogo: TFormJogo;

implementation

uses
  LazAnimais_DataModule;

{ TFormJogo }

procedure TFormJogo.FormCreate(Sender: TObject);
begin
  // Centraliza form
  Left := (Screen.Width  div 2) - (Width div 2);
  Top  := (Screen.Height div 2) - (Height div 2);
  //
  ComboBoxCaracteristica.OnKeyUp := @FormKeyUp;
  ListBoxCaracteristica.OnKeyUp  := @FormKeyUp;
  BitBtnVoltar.OnKeyUp           := @FormKeyUp;
  BitBtnAvancar.OnKeyUp          := @FormKeyUp;
  EditAnimal.OnKeyUp             := @FormKeyUp;
  RadioButtonSim.OnKeyUp         := @FormKeyUp;
  RadioButtonNao.OnKeyUp         := @FormKeyUp;
  ButtonAdicionar.OnKeyUp        := @FormKeyUp;
  ButtonRemover.OnKeyUp          := @FormKeyUp;
end;

procedure TFormJogo.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    116: Passos(-1); // F5
    117: Passos(1);  // F6
  end;
end;

procedure TFormJogo.FormShow(Sender: TObject);
begin
  StringListCaracteristica            := TStringList.Create;
  StringListCaracteristicaSelecionada := TStringList.Create;
  //
  Passo := 0;
  Passos(1);
end;

procedure TFormJogo.RadioButtonSimNaoChange;
begin
  if RadioButtonSim.Checked or RadioButtonNao.Checked then
    BitBtnAvancar.Enabled := true;
end;

procedure TFormJogo.RadioButtonNaoChange(Sender: TObject);
begin
  RadioButtonSimNaoChange;
end;

procedure TFormJogo.RadioButtonSimChange(Sender: TObject);
begin
  RadioButtonSimNaoChange;
end;

procedure TFormJogo.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  StringListCaracteristica.Free;
  StringListCaracteristicaSelecionada.Free;
end;

procedure TFormJogo.ButtonAdicionarClick(Sender: TObject);
var
  Indice: Integer;
  Caracteristica: String;
  CodigoCaracteristica: String;
begin
  case Passo of
    2: begin
      //
      // Caracteristicas do animal no qual o computador adivinhara
      //
      if ComboBoxCaracteristica.ItemIndex >= 0 then begin
        if ListBoxCaracteristica.Items.Count = 0 then begin
          // Lista vazia - adiciona caracteristica
          ListBoxCaracteristica.Items.Add(ComboBoxCaracteristica.Items.Strings[ComboBoxCaracteristica.ItemIndex]);
          StringListCaracteristicaSelecionada.Add(StringListCaracteristica.Strings[ComboBoxCaracteristica.ItemIndex]);
        end else begin
          for Indice := 0 to ListBoxCaracteristica.Items.Count do
            if Indice = ListBoxCaracteristica.Items.Count then begin
              // Somente adiciona se a caracteristica ainda nao constar na lista
              ListBoxCaracteristica.Items.Add(ComboBoxCaracteristica.Items.Strings[ComboBoxCaracteristica.ItemIndex]);
              StringListCaracteristicaSelecionada.Add(StringListCaracteristica.Strings[ComboBoxCaracteristica.ItemIndex]);
            end else
              // Caracteristica ja consta na lista - nao adiciona
              if UTF8LowerCase(ListBoxCaracteristica.Items.Strings[Indice]) = UTF8LowerCase(ComboBoxCaracteristica.Items.Strings[ComboBoxCaracteristica.ItemIndex]) then Break;
        end;
      end;
      if ListBoxCaracteristica.Items.Count = 0 then
        BitBtnAvancar.Enabled := false
      else
        BitBtnAvancar.Enabled := true;
    end;
    5: begin
      //
      // Caracteristicas do animal no qual o usuario pensou
      //
      Caracteristica := Trim(ComboBoxCaracteristica.Text);
      if ComboBoxCaracteristica.Items.Count = 0 then
        CodigoCaracteristica := '' // Caracteristica nova
      else
        for Indice := 0 to ComboBoxCaracteristica.Items.Count do
          if Indice = ComboBoxCaracteristica.Items.Count then
            CodigoCaracteristica := '' // Caracteristica nova
          else
            if UTF8LowerCase(ComboBoxCaracteristica.Items.Strings[Indice]) = UTF8LowerCase(Caracteristica) then begin
              //
              // Caracteristica ja consta na lista - pega o codigo da mesma
              //
              CodigoCaracteristica := StringListCaracteristica.Strings[Indice];
              Break;
            end;
      //
      if Length(Trim(Caracteristica)) > 0 then begin
        if ListBoxCaracteristica.Items.Count = 0 then begin
          // Lista vazia - adiciona caracteristica
          ListBoxCaracteristica.Items.Add(Caracteristica);
          StringListCaracteristicaSelecionada.Add(CodigoCaracteristica);
          ComboBoxCaracteristica.Text := '';
        end else begin
          for Indice := 0 to ListBoxCaracteristica.Items.Count do
            if Indice = ListBoxCaracteristica.Items.Count then begin
              // Somente adiciona se a caracteristica ainda nao constar na lista
              ListBoxCaracteristica.Items.Add(Caracteristica);
              StringListCaracteristicaSelecionada.Add(CodigoCaracteristica);
              ComboBoxCaracteristica.Text := '';
            end else
              // Caracteristica ja consta na lista - nao adiciona
              if UTF8LowerCase(ListBoxCaracteristica.Items.Strings[Indice]) = UTF8LowerCase(Caracteristica) then Break;
        end;
      end;
    end;
  end;
  if ListBoxCaracteristica.Items.Count = 0 then
    BitBtnAvancar.Enabled := false
  else
    BitBtnAvancar.Enabled := true;
end;

procedure TFormJogo.ButtonRemoverClick(Sender: TObject);
begin
  if ListBoxCaracteristica.ItemIndex >= 0 then begin
    StringListCaracteristicaSelecionada.Delete(ListBoxCaracteristica.ItemIndex);
    ListBoxCaracteristica.Items.Delete(ListBoxCaracteristica.ItemIndex);
  end;
  if ListBoxCaracteristica.Items.Count = 0 then
    BitBtnAvancar.Enabled := false
  else
    BitBtnAvancar.Enabled := true;
end;

procedure TFormJogo.EditAnimalChange(Sender: TObject);
begin
  if Passo = 4 then begin
    if Length(Trim(EditAnimal.Text)) > 0 then
      BitBtnAvancar.Enabled := true
    else
      BitBtnAvancar.Enabled := false;
  end;
end;

procedure TFormJogo.Passos(Incremento: ShortInt);
var
  SQL: String;
  Animal: String;
  Indice: Integer;
begin
  Passo := Passo + Incremento;
  if Passo < 1 then
    Passo := 1
  else
    if Passo > 6 then Passo := 6;
  case Passo of
    1: begin
      BitBtnVoltar.Enabled              := false;
      BitBtnAvancar.Enabled             := true;
      LabelCaracteristica.Visible       := false;
      ComboBoxCaracteristica.Visible    := false;
      ListBoxCaracteristica.Visible     := false;
      ButtonAdicionar.Visible           := false;
      ButtonRemover.Visible             := false;
      RadioButtonSim.Visible            := false;
      RadioButtonNao.Visible            := false;
      EditAnimal.Visible                := false;
      EditAnimal.Text                   := '';
      //
      LabelMensagem.Visible := true;
      LabelMensagem.Caption := 'Pense em um animal' + #13 + #10 +
                               'que tentarei advinhar.';
      ComboBoxCaracteristica.ItemIndex := -1;
      StringListCaracteristicaSelecionada.Clear;
      ListBoxCaracteristica.Clear;
    end;
    2: begin
      BitBtnVoltar.Enabled              := true;
      BitBtnAvancar.Enabled             := false;
      LabelCaracteristica.Visible       := true;
      ComboBoxCaracteristica.Visible    := true;
      ListBoxCaracteristica.Visible     := true;
      ButtonAdicionar.Visible           := true;
      ButtonRemover.Visible             := true;
      RadioButtonSim.Visible            := false;
      RadioButtonNao.Visible            := false;
      EditAnimal.Visible                := false;
      ComboBoxCaracteristica.Style      := csDropDownList;
      //
      LabelMensagem.Visible := true;
      LabelMensagem.Caption := 'Escolha as características' + #13 + #10 +
                               'deste animal:';
      //
      // Adiciona caracteristicas do banco de dados
      //
      StringListCaracteristica.Clear;
      StringListCaracteristicaSelecionada.Clear;
      ComboBoxCaracteristica.Clear;
      try
        if not DM.ZQueryCaracteristica.Active then DM.ZQueryCaracteristica.Active := true;
        DM.ZQueryCaracteristica.Open;
        DM.ZQueryCaracteristica.Refresh;
        DM.ZQueryCaracteristica.First;
        while not DM.ZQueryCaracteristica.EOF do begin
          StringListCaracteristica.Add(DM.ZQueryCaracteristica.FieldByName('codigo').AsString);
          ComboBoxCaracteristica.Items.Add(DM.ZQueryCaracteristica.FieldByName('nome').AsString);
          DM.ZQueryCaracteristica.Next;
        end;
        DM.ZQueryCaracteristica.Close;
      except
      end;
    end;
    3: begin
      BitBtnVoltar.Enabled              := true;
      BitBtnAvancar.Enabled             := true;
      LabelCaracteristica.Visible       := false;
      ComboBoxCaracteristica.Visible    := false;
      ListBoxCaracteristica.Visible     := false;
      ButtonAdicionar.Visible           := false;
      ButtonRemover.Visible             := false;
      RadioButtonSim.Visible            := false;
      RadioButtonNao.Visible            := false;
      LabelMensagem.Visible             := true;
      EditAnimal.Visible                := false;
      //
      RadioButtonSim.Checked := false;
      RadioButtonNao.Checked := false;
      //
      // Tenta localizar o animal
      //
      DM.ZQueryGeral.SQL.Clear;
      DM.ZQueryGeral.SQL.Add('SELECT (SELECT nome FROM animal WHERE codigo = codigo_animal) as nome, ' +
                             'COUNT(codigo_animal) AS total_caracteristica');
      DM.ZQueryGeral.SQL.Add('FROM animal_caracteristica');
      for Indice := 0 to ListBoxCaracteristica.Items.Count - 1 do
        if Indice = 0 then
          DM.ZQueryGeral.SQL.Add('WHERE codigo_caracteristica = ' + StringListCaracteristicaSelecionada.Strings[Indice])
        else
          DM.ZQueryGeral.SQL.Add('OR codigo_caracteristica = ' + StringListCaracteristicaSelecionada.Strings[Indice]);
      DM.ZQueryGeral.SQL.Add('GROUP BY codigo_animal');
      DM.ZQueryGeral.SQL.Add('ORDER BY total_caracteristica DESC');
      try
        if not DM.ZQueryGeral.Active then DM.ZQueryGeral.Active := true;
        DM.ZQueryGeral.Open;
        DM.ZQueryGeral.First;
        if DM.ZQueryGeral.EOF then begin
          LabelMensagem.Caption := 'Desculpe-me, não encontrei nenhum' + #13 + #10 +
                                   'animal com esta(s) característica(s).';
        end else begin
          BitBtnAvancar.Enabled  := false;
          RadioButtonSim.Visible := true;
          RadioButtonNao.Visible := true;
          LabelMensagem.Caption  := 'O animal é' + #13 + #10 +
                                    DM.ZQueryGeral.FieldByName('nome').AsString + ' ?';
        end;
        DM.ZQueryGeral.Close;
      except
        BitBtnVoltar.Enabled  := false;
        BitBtnAvancar.Enabled := false;
        LabelMensagem.Caption := 'Ocorreu um erro ao' + #13 + #10 +
                                 '(3.1) acessar o banco de dados.';
        Exit;
      end;
    end;
    4: begin
      BitBtnVoltar.Enabled              := false;
      BitBtnAvancar.Enabled             := true;
      LabelCaracteristica.Visible       := false;
      ComboBoxCaracteristica.Visible    := false;
      ListBoxCaracteristica.Visible     := false;
      ButtonAdicionar.Visible           := false;
      ButtonRemover.Visible             := false;
      RadioButtonSim.Visible            := false;
      RadioButtonNao.Visible            := false;
      EditAnimal.Visible                := false;
      //
      if RadioButtonSim.Checked then begin
        LabelMensagem.Visible := true;
        LabelMensagem.Caption := 'Obrigado por jogar.' + #13 + #10 +
                                 'Tente novamente.';
        Passo := 0;
      end else begin
        BitBtnAvancar.Enabled := false;
        EditAnimal.Visible    := true;
        LabelMensagem.Visible := true;
        LabelMensagem.Caption := 'Informe o nome do' + #13 + #10 +
                                 'animal que você pensou:';
        EditAnimal.SetFocus;
      end;
      ListBoxCaracteristica.Clear;
      ComboBoxCaracteristica.ItemIndex := -1;
      StringListCaracteristicaSelecionada.Clear;
    end;
    5: begin
      BitBtnVoltar.Enabled              := true;
      BitBtnAvancar.Enabled             := false;
      RadioButtonSim.Visible            := false;
      RadioButtonNao.Visible            := false;
      EditAnimal.Visible                := false;
      //
      // Verifica se o nome já não está cadastrado
      //
      DM.ZQueryGeral.SQL.Clear;
      DM.ZQueryGeral.SQL.Add('SELECT nome FROM animal WHERE nome = "' + UTF8LowerCase(Trim(EditAnimal.Text)) + '"');
      try
        if not DM.ZQueryGeral.Active then DM.ZQueryGeral.Active := true;
        DM.ZQueryGeral.Open;
        DM.ZQueryGeral.First;
      except
        BitBtnVoltar.Enabled  := false;
        BitBtnAvancar.Enabled := false;
        LabelMensagem.Caption := '(5.1) Ocorreu um erro ao' + #13 + #10 +
                                 'acessar o banco de dados.';
        DM.ZQueryGeral.Close;
        Exit;
      end;
      if not DM.ZQueryGeral.EOF then begin
        BitBtnAvancar.Enabled          := false;
        LabelCaracteristica.Visible    := false;
        ComboBoxCaracteristica.Visible := false;
        ListBoxCaracteristica.Visible  := false;
        ButtonAdicionar.Visible        := false;
        ButtonRemover.Visible          := false;
        LabelMensagem.Caption          := 'Este animal já consta' + #13 + #10 +
                                          'no banco de dados.';
        DM.ZQueryGeral.Close;
      end else begin
        ComboBoxCaracteristica.Style   := csDropDown;
        BitBtnVoltar.Enabled           := false;
        LabelCaracteristica.Visible    := true;
        ComboBoxCaracteristica.Visible := true;
        ListBoxCaracteristica.Visible  := true;
        ButtonAdicionar.Visible        := true;
        ButtonRemover.Visible          := true;
        LabelMensagem.Visible          := true;
        LabelMensagem.Caption          := 'Informe algumas características' + #13 + #10 +
                                          'do(a) ' + Trim(EditAnimal.Text) + ':';
        ComboBoxCaracteristica.SetFocus;
      end;
    end;
    6: begin
      BitBtnVoltar.Enabled              := false;
      BitBtnAvancar.Enabled             := true;
      LabelCaracteristica.Visible       := false;
      ComboBoxCaracteristica.Visible    := false;
      ListBoxCaracteristica.Visible     := false;
      ButtonAdicionar.Visible           := false;
      ButtonRemover.Visible             := false;
      RadioButtonSim.Visible            := false;
      RadioButtonNao.Visible            := false;
      LabelMensagem.Visible             := true;
      EditAnimal.Visible                := false;
      //
      // Adiciona as caracteristicas novas
      //
      DM.ZQueryGeral.SQL.Clear;
      for Indice := 0 to StringListCaracteristicaSelecionada.Count - 1 do
        if Length(Trim(StringListCaracteristicaSelecionada.Strings[Indice])) = 0 then begin
          DM.ZQueryGeral.SQL.Add('INSERT INTO caracteristica (nome) VALUES ("' +
                                 UTF8LowerCase(ListBoxCaracteristica.Items.Strings[Indice]) + '");');
          StringListCaracteristicaSelecionada.Strings[Indice] := '0'; // Para nao inserir novamente caso o usuario retorne ao passo anterior
        end;
      try
        if DM.ZQueryGeral.SQL.Count > 0 then DM.ZQueryGeral.ExecSQL;
      except
        BitBtnVoltar.Enabled  := false;
        BitBtnAvancar.Enabled := false;
        LabelMensagem.Caption := '(6.1) Ocorreu um erro ao' + #13 + #10 +
                                 'acessar o banco de dados.';
        Exit;
      end;
      //
      // Adiciona o novo animal
      //
      DM.ZQueryGeral.SQL.Clear;
      DM.ZQueryGeral.SQL.Add('SELECT nome FROM animal WHERE nome = "' + UTF8LowerCase(Trim(EditAnimal.Text)) + '"');
      try
        if not DM.ZQueryGeral.Active then DM.ZQueryGeral.Active := true;
        DM.ZQueryGeral.Open;
        DM.ZQueryGeral.First;
      except
        BitBtnVoltar.Enabled  := false;
        BitBtnAvancar.Enabled := false;
        LabelMensagem.Caption := '(6.2) Ocorreu um erro ao' + #13 + #10 +
                                 'acessar o banco de dados.';
        DM.ZQueryGeral.Close;
        Exit;
      end;
      if not DM.ZQueryGeral.EOF then begin
        BitBtnAvancar.Enabled := false;
        LabelMensagem.Caption := 'Este animal já consta' + #13 + #10 +
                                 'no banco de dados.';
        DM.ZQueryGeral.Close;
      end else begin
        DM.ZQueryGeral.Close;
        DM.ZQueryGeral.SQL.Clear;
        DM.ZQueryGeral.SQL.Add('INSERT INTO animal (nome) VALUES ("' + UTF8LowerCase(Trim(EditAnimal.Text)) + '");');
        try
          DM.ZQueryGeral.ExecSQL;
        except
          BitBtnVoltar.Enabled  := false;
          BitBtnAvancar.Enabled := false;
          LabelMensagem.Caption := '(6.3) Ocorreu um erro ao' + #13 + #10 +
                                   'acessar o banco de dados.';
          Exit;
        end;
        //
        // Atribui as caracteristicas ao novo animal
        //
        DM.ZQueryGeral.SQL.Clear;
        for Indice := 0 to StringListCaracteristicaSelecionada.Count - 1 do
          DM.ZQueryGeral.SQL.Add('INSERT INTO animal_caracteristica (codigo_animal, codigo_caracteristica) ' +
                                 'SELECT codigo, (SELECT codigo FROM caracteristica WHERE nome = "' +
                                 UTF8LowerCase(ListBoxCaracteristica.Items.Strings[Indice]) +
                                 '") FROM animal WHERE nome = "' + UTF8LowerCase(Trim(EditAnimal.Text)) + '";');
        try
          if DM.ZQueryGeral.SQL.Count > 0 then DM.ZQueryGeral.ExecSQL;
        except
          BitBtnVoltar.Enabled  := false;
          BitBtnAvancar.Enabled := false;
          LabelMensagem.Caption := '(6.4) Ocorreu um erro ao' + #13 + #10 +
                                   'acessar o banco de dados.';
          Exit;
        end;
      end;
      BitBtnVoltar.Enabled  := false;
      BitBtnAvancar.Enabled := true;
      LabelMensagem.Caption := 'Obrigado por ensinar-me' + #13 + #10 +
                               'mais um animal.';
      Passo := 0;
    end;
   end;
end;

procedure TFormJogo.BitBtnVoltarClick(Sender: TObject);
begin
  Passos(-1);
end;

procedure TFormJogo.BitBtnAvancarClick(Sender: TObject);
begin
  Passos(1);
end;

initialization
  {$I LazAnimais_FormJogo.lrs}

end.

