unit U_ParametrosBD;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Vcl.Forms, Dialogs,
  StdCtrls, Mask, Buttons, ExtCtrls, DBCtrls, AlignEdit, StrUtils,
  Consulta, U_OpenDirectory, CParametrosBDIni;

type
  TF_ParametrosBD = class(TForm)
    Panel1: TPanel;
    Confirmar: TBitBtn;
    fechar: TSpeedButton;
    OpenFile: TOpenDialog;
    gbBD: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    SpeedButton2: TSpeedButton;
    edtUsuario: TEdit;
    edtSenha: TEdit;
    edtBase: TEdit;
    gbIntegracao: TGroupBox;
    Label12: TLabel;
    edtServidor: TEdit;
    edtWebService: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtUsuarioWs: TEdit;
    Label3: TLabel;
    edtSenhaWs: TEdit;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure fecharClick(Sender: TObject);

    procedure ConfirmarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtDtaUltExit(Sender: TObject);
    procedure edtDtaUltKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    obConfig: TParametrosBDIni;

    procedure CarregarConfiguracoes;
  public
    { Public declarations }
  end;

var
  F_ParametrosBD: TF_ParametrosBD;

implementation

uses U_Sisproc, U_T2;

{$R *.DFM}

procedure TF_ParametrosBD.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  obConfig.Free;

  Action := Cafree;
  F_ParametrosBD := nil;
end;

procedure TF_ParametrosBD.FormCreate(Sender: TObject);
begin
  obConfig := TParametrosBDIni.Create;
  CarregarConfiguracoes;
end;

procedure TF_ParametrosBD.FormKeyPress(Sender: TObject; var Key: Char);
begin
  NextControl(self, Key);
end;

procedure TF_ParametrosBD.fecharClick(Sender: TObject);
begin
  close;
end;

procedure TF_ParametrosBD.CarregarConfiguracoes;
var
  DataUltima: TDateTime;
begin
  if obConfig.CarregarConfiguracao then
  begin
    edtUsuario.Text := obConfig.Conexao.Usuario;
    edtSenha.Text := obConfig.Conexao.Senha;
    edtBase.Text := obConfig.Conexao.Base;
    edtServidor.Text := obConfig.Integracao.Token;
    edtWebService.Text := obConfig.Envio.WeService;
    edtUsuarioWs.Text := obConfig.Envio.Usuario;
    edtSenhaWs.Text := obConfig.Envio.Senha;
  end;
end;

procedure TF_ParametrosBD.ConfirmarClick(Sender: TObject);
begin
  if Trim(edtBase.Text) = '' then
  begin
    FocarObj(edtBase);
    DL_Msg('Informe a base de dados para exportar e importar registros para o sistema Wsepe!', Application.Title, 'ERRO');
    Exit;
  end;

  if Trim(edtUsuario.Text) = '' then
  begin
    FocarObj(edtUsuario);
    DL_Msg('Informe o usu�rio para acesso ao sistema Wsepe!', Application.Title, 'ERRO');
    Exit;
  end;

  if Trim(edtSenha.Text) = '' then
  begin
    FocarObj(edtSenha);
    DL_Msg('Informe a senha do usu�rio para acesso ao sistema Wsepe!', Application.Title, 'ERRO');
    Exit;
  end;

  if Trim(edtServidor.Text) = '' then
  begin
    FocarObj(edtServidor);
    DL_Msg('Informe o servidor com a aplica��o de e-commerce!', Application.Title, 'ERRO');
    Exit;
  end;

  if Trim(edtWebService.Text) = '' then
  begin
    FocarObj(edtWebService);
    DL_Msg('Informe o servidor do webservice que enviar� as informa��es para o e-commerce!', Application.Title, 'ERRO');
    Exit;
  end;

  //Dentro de um try porque no primeiro acesso a base de dados n�o est� acess�vel, ent�o o sistema reinicia e a� sim pode ser configurado o usu�rio
  Try GravaCfg(T2.qC1, 'CFG_WEBUSU', edtUsuario.Text); Except End;
  Try GravaCfg(T2.qC1, 'CFG_WEBSEN', EncriptaSenha('encript' + edtSenha.Text)); Except End;

  obConfig.CarregarConfiguracao;
  obConfig.Conexao.Base := edtBase.Text;
  obConfig.Conexao.Usuario := edtUsuario.Text;
  obConfig.Conexao.Senha := edtSenha.Text;
  obConfig.Integracao.Token := edtServidor.Text;
  obConfig.Envio.WeService := edtWebService.Text;
  obConfig.Envio.Usuario := edtUsuarioWs.Text;
  obConfig.Envio.Senha := edtSenhaWs.Text;
  obConfig.SalvarConfiguracao;

  // S� avisa quando � o primeiro acesso
  if not T2.WSepeDBX.Connected then
    DL_Msg('Configura��o da base de dados realizada com sucesso.' + sLineBreak + 'Reinicie a aplica��o e verifique as outras configura��es!', Application.Title, 'INFORMACAO');

  ModalResult := MrOk;
end;

procedure TF_ParametrosBD.edtDtaUltExit(Sender: TObject);
begin
  If ((Sender as TMaskEdit).Text) = '  /  /    ' Then
  begin
    (Sender as TMaskEdit).Clear;
    Exit;
  end;

  If Not VerData((Sender as TMaskEdit).Text) Then
  Begin
    (Sender as TMaskEdit).SetFocus;
    Exit;
  End;
  (Sender as TMaskEdit).Text := FormatDateTime('dd/mm/yyyy', StrToDateTime((Sender as TMaskEdit).Text));
end;

procedure TF_ParametrosBD.edtDtaUltKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 72 then
    (Sender as TMaskEdit).Text := FormatDateTime('dd/mm/yyyy', Date); { 72 = H = Hoje }
end;

end.
