unit U_ConfigObjetos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, Buttons, ExtCtrls, DBCtrls, CWebObjeto, Transacao, U_Script;

type
  TF_ConfigObjetos = class(TForm)
    Panel1: TPanel;
    Confirmar: TBitBtn;
    fechar: TSpeedButton;
    gbGerais: TGroupBox;
    gbProdutos: TGroupBox;
    gbClientes: TGroupBox;
    gbPedidos: TGroupBox;
    cktcliente: TCheckBox;
    cktconvenio: TCheckBox;
    cktgrupocli: TCheckBox;
    cktfontecli: TCheckBox;
    cktsegmentocli: TCheckBox;
    cktregiaocli: TCheckBox;
    cktproduto: TCheckBox;
    cktreferencia: TCheckBox;
    ckttabpreco: TCheckBox;
    cktgrupopro: TCheckBox;
    ckttabprecoval: TCheckBox;
    cktpedido: TCheckBox;
    cktcadocorrencias: TCheckBox;
    cktcadtna: TCheckBox;
    cktcadcfop: TCheckBox;
    cktncmtributacao: TCheckBox;
    ckticmsuf: TCheckBox;
    cktcondpagamento: TCheckBox;
    ckttipopag: TCheckBox;
    cktbanco: TCheckBox;
    ckttransportador: TCheckBox;
    cktvendedor: TCheckBox;
    cktferiado: TCheckBox;
    cktpais: TCheckBox;
    cktcidade: TCheckBox;
    btnCriarObjetos: TBitBtn;
    btMarcaDesmarca: TSpeedButton;
    cktsaldotmp: TCheckBox;
    cktpedidohist: TCheckBox;
    ckttitulo: TCheckBox;
    ckttipoatend: TCheckBox;
    cktempresa: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure fecharClick(Sender: TObject);
    procedure ConfirmarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cktcadtnaClick(Sender: TObject);
    procedure btnCriarObjetosClick(Sender: TObject);
    procedure btMarcaDesmarcaClick(Sender: TObject);
  private
    { Private declarations }

    AdmUsu, AdmSen: String;
    AlterouObj: Boolean;

    obObjeto: TWebobjeto;

    function GravarObjetos: Boolean;
    procedure DeletarObjetos;
    procedure CarregarObjetos;
    procedure VerificarTabelas;
    procedure CriarObjetos;
    procedure HabilitarForm(Habilitar: Boolean);
  public
    { Public declarations }
  end;

var
  F_ConfigObjetos: TF_ConfigObjetos;

implementation

uses U_Sisproc, Conexao, U_T2, U_GerarObjetos;

{$R *.DFM}

procedure TF_ConfigObjetos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  obObjeto.Free;

  Action := Cafree;
  F_ConfigObjetos := nil;
end;

procedure TF_ConfigObjetos.FormCreate(Sender: TObject);
var
  I: Integer;
begin
  obObjeto := TWebobjeto.Create;

  VerificarTabelas;
  CarregarObjetos;

  AdmUsu := BuscaCFG2(T2.qgSepeCfg, 'SEPECFG', 'CFG_ADMUSU', 'Usuário administrador do banco de dados', '', 1, 200);
  AdmSen := DescriptaSenha(Copy(BuscaCFG2(T2.qgSepeCfg, 'SEPECFG', 'CFG_ADMSEN', 'Senha do usuário administrador do banco de dados', '', 1, 200), 8));

  AlterouObj := False;

  // No Demander a integração deve ser sempre completa
  if (Application.Title = 'Integração Demander') then
  begin
    for I := 0 to ComponentCount - 1 do
    begin
      if Components[I].ClassType = TCheckBox then
      begin
        TCheckBox(Components[I]).Enabled := False;
        TCheckBox(Components[I]).Checked := True;
      end;
    end;

    cktgrupocli.Checked := False;
    cktsegmentocli.Checked := False;
    cktconvenio.Checked := False;
    cktregiaocli.Checked := False;
    cktfontecli.Checked := False;

    cktreferencia.Checked := False;
    cktcadocorrencias.Checked := False;
    cktpedidohist.Checked := False;

    cktcadtna.Checked := False;
    cktcadcfop.Checked := False;
    ckticmsuf.Checked := False;
    cktbanco.Checked := False;
    cktferiado.Checked := False;
    cktncmtributacao.Checked := False;

    ckttitulo.Checked := True;
    ckttitulo.Enabled := False;

    ckttipoatend.Checked := True;
    ckttipoatend.Enabled := False;

    cktempresa.Checked := True;
    cktempresa.Enabled := False;

    Confirmar.Visible := False;
    btMarcaDesmarca.Visible := False;
  end
  else if (Application.Title = 'Integração e-Commerce') then
  begin
    for I := 0 to ComponentCount - 1 do
    begin
      if Components[I].ClassType = TCheckBox then
      begin
        TCheckBox(Components[I]).Enabled := False;
        TCheckBox(Components[I]).Checked := False;
      end;
    end;

    cktproduto.Checked := True;
    ckttabprecoval.Checked := True;
    cktsaldotmp.Checked := True;

    Confirmar.Visible := False;
    btMarcaDesmarca.Visible := False;
  end
  else
  begin
    ckttipoatend.Checked := False;
    ckttipoatend.Enabled := False;

    cktempresa.Checked := False;
    cktempresa.Enabled := False;

    ckttitulo.Checked := False;
    ckttitulo.Enabled := False;
  end;
end;

procedure TF_ConfigObjetos.FormKeyPress(Sender: TObject; var Key: Char);
begin
  NextControl(self, Key);
end;

function TF_ConfigObjetos.GravarObjetos: Boolean;
var
  I: Integer;
  Objeto: String;
begin
  Result := False;

  if not AlterouObj then
  begin
    Result := True;
    Exit;
  end;

  InicioTransacao(T2.WSepeDBX);
  Try
    DeletarObjetos;

    // Grava automaticamente cada um dos objetos a partir de sua respectiva checkbox
    for I := 0 to self.ComponentCount - 1 do
    begin
      if (self.Components[I].ClassType = TCheckBox) and (TCheckBox(self.Components[I]).Checked) then
      begin
        Objeto := Copy(self.Components[I].Name, 3, Length(self.Components[I].Name));

        // Usa a tag para manter o ID, assim não gera um novo ID para objetos já incluídos
        if self.Components[I].Tag > 0 then
          obObjeto.setId(self.Components[I].Tag)
        else
          obObjeto.setId(obObjeto.Auto_inc_id(1));

        obObjeto.setObjeto(Objeto);
        obObjeto.setUsuario(GetUsuario);
        obObjeto.setData(Date);
        obObjeto.setHora(FormatDateTime('hh:nn:ss', Time));
        obObjeto.Incluir;
      end;
    end;

    FimTransacao(T2.WSepeDBX, True);
    Result := True;
  Except
    on E: Exception do
    begin
      FimTransacao(T2.WSepeDBX, False);
      DL_Msg('Ocorreu um erro: ' + E.Message, Application.Title, 'ERRO');
      Exit;
    end
    else
    begin
      FimTransacao(T2.WSepeDBX, False);
      DL_Msg('Ocorreu um erro!', Application.Title, 'ERRO');
      Exit;
    end;
  End;
end;

procedure TF_ConfigObjetos.HabilitarForm(Habilitar: Boolean);
begin
  if Habilitar then
  begin
    btnCriarObjetos.Enabled := True;
    Confirmar.Enabled := True;
  end
  else
  begin
    btnCriarObjetos.Enabled := False;
    Confirmar.Enabled := False;
  end;
end;

procedure TF_ConfigObjetos.VerificarTabelas;
var
  obScript: TScript;
begin
  // Criação das tabelas para gravação do log Web
  obScript := TScript.Create;
  Try
    obScript.CriaTabelaLog;
    obScript.CriaTabelasConfig;
    obScript.AtualizarTabelas;
  Finally
    obScript.Free;
  End;
end;

procedure TF_ConfigObjetos.btMarcaDesmarcaClick(Sender: TObject);
var
  I: Integer;
  MarcarChecks: Boolean;
begin
  MarcarChecks := btMarcaDesmarca.Caption = '&Marcar';
  for I := 0 to self.ComponentCount - 1 do
  begin
    if self.Components[I].ClassType = TCheckBox then
      TCheckBox(self.Components[I]).Checked := MarcarChecks;
  end;

  if MarcarChecks then
    btMarcaDesmarca.Caption := '&Desmarcar'
  else
    btMarcaDesmarca.Caption := '&Marcar';
end;

procedure TF_ConfigObjetos.btnCriarObjetosClick(Sender: TObject);
begin
  if DL_Pergunta('Criar a configuração para exportação WEB dos objetos selecionados?', 'Integração WEB', MB_YESNO) = mrNo then
    Exit;

  Try
    HabilitarForm(False);

    // Se consegue gravar os objetos então carrega novamente para colocar os ID nos respecitvos checkboxes
    if GravarObjetos then
      CarregarObjetos;

    CriarObjetos;
    AlterouObj := False;

    DL_Msg('Processo concluído!', Application.Title, 'INFORMACAO');
  Finally
    HabilitarForm(True);
  End;
end;

procedure TF_ConfigObjetos.CarregarObjetos;
var
  I: Integer;
  Objeto, Q: String;
begin
  Q := 'Select WebObjeto.ID, WebObjeto.Objeto From WebObjeto';

  T2.cdsC1.Active := False;
  T2.qC1.Close;
  T2.qC1.SQL.Clear;
  T2.qC1.SQL.Add(Q);
  T2.cdsC1.Active := True;

  if T2.cdsC1.IsEmpty then
    Exit;

  // Carrega automaticamente cada um dos objetos a partir de sua respectiva checkbox
  for I := 0 to self.ComponentCount - 1 do
  begin
    if self.Components[I].ClassType = TCheckBox then
    begin
      Objeto := Copy(self.Components[I].Name, 3, Length(self.Components[I].Name));
      if T2.cdsC1.Locate('OBJETO', Objeto, []) then
      begin
        // Coloca o ID na tag do checkbox para não criar um novo ID sempre que houver uma confirmação
        self.Components[I].Tag := Ivl(T2.cdsC1['ID']);
        TCheckBox(self.Components[I]).Checked := True;
      end;
    end;
  end;
end;

procedure TF_ConfigObjetos.cktcadtnaClick(Sender: TObject);
begin
  AlterouObj := True;
end;

procedure TF_ConfigObjetos.ConfirmarClick(Sender: TObject);
begin
  Try
    HabilitarForm(False);

    // Se consegue gravar os objetos então carrega novamente para colocar os ID nos respecitvos checkboxes
    if GravarObjetos then
      CarregarObjetos;

    // Se houve alteração solicita a criação das triggers novamente
    if AlterouObj then
      btnCriarObjetosClick(btnCriarObjetos);

    DL_Msg('Processo concluído!', Application.Title, 'INFORMACAO');

    AlterouObj := False;
  Finally
    HabilitarForm(True);
  End;
end;

procedure TF_ConfigObjetos.CriarObjetos;
var
  obGerarObjetos: TGerarObjetos;
  UsuIni, SenhaIni: String;
begin
  obGerarObjetos := TGerarObjetos.Create;
  Try
    // Guarda a senha padrão
    UsuIni := GetUsuario;
    SenhaIni := GetSenha;

    // Cria as triggers usando o usuário administrador
    if (Application.Title = 'Integração Demander') or (Application.Title = 'Integração e-Commerce') then
      T2.FazConexao(True, AdmUsu, AdmSen)
    else
      ConectaBase(T2.WSepeDBX, T2.WSepeDBX.ConnectionName, GetEmpresa, AdmUsu, AdmSen, 'ADM');

    obGerarObjetos.CriarTriggers;
  Finally
    if (Application.Title = 'Integração Demander') or (Application.Title = 'Integração e-Commerce') then
      T2.FazConexao()
    else
      ConectaBase(T2.WSepeDBX, T2.WSepeDBX.ConnectionName, GetEmpresa, UsuIni, SenhaIni);

    obGerarObjetos.Free;
  End;
end;

procedure TF_ConfigObjetos.DeletarObjetos;
var
  Q: String;
begin
  Q := 'Delete From WebObjeto';

  T2.qTemp.Close;
  T2.qTemp.SQL.Clear;
  T2.qTemp.SQL.Add(Q);
  T2.qTemp.ExecSQL();
end;

procedure TF_ConfigObjetos.fecharClick(Sender: TObject);
begin
  Close;
end;

end.
