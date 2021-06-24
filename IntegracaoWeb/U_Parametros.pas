unit U_Parametros;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, Buttons, ExtCtrls, DBCtrls, U_Opendirectory, CSepeCfg, FileCtrl, CAlmoxarifado;

type
  TF_Parametros = class(TForm)
    Panel1: TPanel;
    Confirmar: TBitBtn;
    fechar: TSpeedButton;
    gbUsuario: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    edtAdmUsu: TEdit;
    edtAdmSen: TEdit;
    gbWebUsu: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    edtWebUsu: TEdit;
    edtWebSen: TEdit;
    gbGerais: TGroupBox;
    ckSepVen: TCheckBox;
    rgAlx: TRadioGroup;
    edtAlxPed: TEdit;
    ckConObs: TCheckBox;
    ckSepCli: TCheckBox;
    ckWebTab: TCheckBox;
    ckWebVen: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure fecharClick(Sender: TObject);
    procedure ConfirmarClick(Sender: TObject);
    procedure CarregarConfiguracoes;
    function GetPadrao(NomeCfg: String): String;
    procedure FormCreate(Sender: TObject);
    procedure edtAlxPedExit(Sender: TObject);
    procedure edtAlxPedKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtWebTabKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure rgAlxClick(Sender: TObject);
  private
    { Private declarations }

    obConfig: TSepecfg;
    obAlmox : TAlmoxarifado;

    function GetDescri(NomeCfg: String): String;
  public
    { Public declarations }
  end;

var
  F_Parametros: TF_Parametros;

implementation

uses U_Sisproc, Conexao, U_T2, Consulta;

{$R *.DFM}

procedure TF_Parametros.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  obConfig.Free;
  obAlmox.Free;

  Action := Cafree;
  F_Parametros := nil;
end;

procedure TF_Parametros.FormCreate(Sender: TObject);
begin
  obConfig := TSepecfg.Create;
  obAlmox := TAlmoxarifado.Create;

  CarregarConfiguracoes;

  if (Application.Title = 'Integração Demander') or (Application.Title = 'Integração e-Commerce') then
  begin
    gbGerais.Visible := False;
    Height := Height - gbGerais.Height;
  end;
end;

procedure TF_Parametros.FormKeyPress(Sender: TObject; var Key: Char);
begin
  NextControl(self, Key);
end;

function TF_Parametros.GetDescri(NomeCfg: String): String;
begin
  Result := '';

  if NomeCfg = 'CFG_WEBVEN' then
  begin
    Result := 'Gerar automaticamente o pedido de venda ao importar pedido web';
    Exit;
  end;

  if NomeCfg = 'CFG_ALXPED' then
  begin
    Result := 'Almoxarifado padrão para gerar o pedido';
    Exit;
  end;

  if NomeCfg = 'CFG_ADMUSU' then
  begin
    Result := 'Usuário administrador do banco de dados';
    Exit;
  end;

  if NomeCfg = 'CFG_ADMSEN' then
  begin
    Result := 'Senha do usuário administrador do banco de dados';
    Exit;
  end;

  if NomeCfg = 'CFG_WEBUSU' then
  begin
    Result := 'Usuário padrão para importação Web';
    Exit;
  end;

  if NomeCfg = 'CFG_WEBSEN' then
  begin
    Result := 'Senha do usuário padrão para importação Web';
    Exit;
  end;

  if NomeCfg = 'CFG_WEBTAB' then
  begin
    Result := 'Exportar somente tabelas de preço utilizadas para venda WEB/Mobile.';
    Exit;
  end;

  if NomeCfg = 'CFG_CONOBS' then
  begin
    Result := 'Concatenar observação do item à descrição.';
    Exit;
  end;
end;

function TF_Parametros.GetPadrao(NomeCfg: String): String;
begin
  Result := '';

  if NomeCfg = 'CFG_WEBVEN' then
  begin
    Result := 'N';
    Exit;
  end;

  if NomeCfg = 'CFG_USUATU' then
  begin
    Result := '';
    Exit;
  end;

  if NomeCfg = 'CFG_SENATU' then
  begin
    Result := '';
    Exit;
  end;

  if NomeCfg = 'CFG_CONOBS' then
  begin
    Result := 'N';
    Exit;
  end;

  if NomeCfg = 'CFG_WEBTAB' then
  begin
    Result := 'S';
    Exit;
  end;
end;

procedure TF_Parametros.rgAlxClick(Sender: TObject);
begin
  if rgAlx.ItemIndex = 0 then
  begin
    edtAlxPed.Enabled := True;
    FocarObj(edtAlxPed);
  end
  else
  begin
    edtAlxPed.Clear;
    edtAlxPed.Enabled := False;
  end;
end;

procedure TF_Parametros.CarregarConfiguracoes;
var
  NomeCfg, ValorCfg: String;
  I: Integer;
begin
  for I := 0 to ComponentCount - 1 do
  begin
    // Carrega os CheckBox, Edits, MaskEdits e AlignEdits************************
    Try
      if (Components[I] is TEdit) or (Components[I] is TMaskEdit) then
      begin
        NomeCfg := 'CFG_' + Copy(UpperCase(Components[I].Name), 4, 10);

        ValorCfg := BuscaCFG2(T2.qgSepeCfg, 'SEPECFG', NomeCfg, GetDescri(NomeCfg),
          GetPadrao(NomeCfg), 1, 200);
        if (NomeCfg = 'CFG_ADMSEN') or (NomeCfg = 'CFG_WEBSEN') or
          (NomeCfg = 'CFG_WFTPSH') then
          ValorCfg := DescriptaSenha(Copy(ValorCfg, 8));

        if (Components[I] is TEdit) then
          (FindComponent(Components[I].Name) as TEdit).Text := ValorCfg
        else if (Components[I] is TMaskEdit) then
          (FindComponent(Components[I].Name) as TMaskEdit).Text := ValorCfg;
      end;

      if (Components[I] is TCheckBox) then
      begin
        NomeCfg := 'CFG_' + Trim(Copy(UpperCase(Components[I].Name), 3, 6));
        (FindComponent(Components[I].Name) as TCheckBox).Checked :=
          BuscaCFG2(T2.qgSepeCfg, 'SEPECFG', NomeCfg, GetDescri(NomeCfg),
          GetPadrao(NomeCfg), 1, 200) = 'S';
      end;
    Except
      on E: Exception do
        DL_Msg('Ocorreu um erro ao carregar a configuração ' + NomeCfg + ': ' +
          E.Message, 'Erro', 'ERRO');
      else
        DL_Msg('Ocorreu um erro ao carregar a configuração ' + NomeCfg + '. ',
          'Erro', 'ERRO');
    End;
  end;

  if Trim(edtAlxPed.Text) <> '' then
  begin
    rgAlx.ItemIndex := 0;
  end
  else
  begin
    rgAlx.ItemIndex := 1;
  end;
  rgAlxClick(rgAlx);
end;

procedure TF_Parametros.ConfirmarClick(Sender: TObject);
var
  I: Integer;
  NomeCfg, Descri: String;
begin
  if rgAlx.ItemIndex = 0 then
  begin
    if Trim(edtAlxPed.Text) = '' then
    begin
      FocarObj(edtAlxPed);
      DL_Msg('Informe o almoxarifado Geral!', Application.Title, 'ERRO');
      Abort;
    end;
  end;

  for I := 0 to ComponentCount - 1 do
  begin
    // Grava os CheckBox, Edits, MaskEdits e AlignEdits
    Try
      if (Components[I] is TEdit) or (Components[I] is TMaskEdit) then
      begin
        NomeCfg := 'CFG_' + Copy(UpperCase(Components[I].Name), 4, 10);
        obConfig.setOpcao(NomeCfg);

        if (Components[I] is TEdit) then
          obConfig.setSit((FindComponent(Components[I].Name) as TEdit).Text)
        else if (Components[I] is TMaskEdit) then
          obConfig.setSit((FindComponent(Components[I].Name)
            as TMaskEdit).Text);

        // grava no SepeCfg
        if (NomeCfg = 'CFG_ADMSEN') or (NomeCfg = 'CFG_WEBSEN') or
          (NomeCfg = 'CFG_WFTPSH') then
          obConfig.setSit(EncriptaSenha('encript' + obConfig.getSit));

        obConfig.setDescricao(GetDescri(NomeCfg));
        obConfig.Salvar;
      end;

      if (Components[I] is TCheckBox) then
      begin
        NomeCfg := 'CFG_' + Trim(Copy(UpperCase(Components[I].Name), 3, 6));

        obConfig.setOpcao(NomeCfg);

        if (FindComponent(Components[I].Name) as TCheckBox).Checked then
          obConfig.setSit('S')
        else
          obConfig.setSit('N');

        Descri := GetDescri(NomeCfg);
        if Descri = '' then
          Descri := (Components[I] as TCheckBox).Caption;

        obConfig.setDescricao(Descri);
        obConfig.Salvar;
      end;
    Except
      on E: Exception do
        DL_Msg('Ocorreu um erro ao salvar a configuração ' + NomeCfg + ': ' +
          E.Message, 'Erro', 'ERRO');
      else
        DL_Msg('Ocorreu um erro ao salvar a configuração ' + NomeCfg + '. ',
          'Erro', 'ERRO');
    End;
  end;

  Close;
end;

procedure TF_Parametros.edtAlxPedExit(Sender: TObject);
begin
  if Trim((Sender as TEdit).Text) = '' then Exit;

  obAlmox.setEst_codigo(Trim((Sender as TEdit).Text));
  if not obAlmox.Consultar then
  begin
    (Sender as TEdit).SetFocus;
    (Sender as TEdit).SelectAll;
    Raise Exception.Create('Almoxarifado não Cadastrado!');
  end;
end;

procedure TF_Parametros.edtAlxPedKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Q :String;
begin
  if (Caption = 'Ver')or(Caption = 'Excluir') then Exit;

  if Key = VK_F4 then
  begin
    Q := 'Select EST_CODIGO Codigo, EST_ENDER Descricao';
    Q := Q +#10#13+ 'From EstaEst';
    If ConsultaDl(T2.WsepeDBX,Q,'Descricao','Localiza Almoxarifados') Then
    begin
      (Sender as TEdit).Text := Consulta.getValor('Codigo');
    end;
  end;
end;

procedure TF_Parametros.edtWebTabKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Q: String;
begin
  if Key = VK_F4 then
  begin
    Q := 'Select TBC_CODIGO Codigo, TBC_DESCRI Descricao';
    Q := Q + #10#13 + 'From VENATBC';

    if ConsultaDl(T2.WsepeDBX,Q,'Descricao','Consulta Tabelas de Preço') then
    begin
      if Trim((Sender as TEdit).Text) <> ''
      then (Sender as TEdit).Text := (Sender as TEdit).Text + ' ';

      (Sender as TEdit).Text := (Sender as TEdit).Text + Consulta.getValor('Codigo');
    end;
  end;
end;

procedure TF_Parametros.fecharClick(Sender: TObject);
begin
  Close;
end;

end.
