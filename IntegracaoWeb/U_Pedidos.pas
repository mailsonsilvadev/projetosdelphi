unit U_Pedidos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, U_PadraoCad, ImgList, StdCtrls, CheckLst, Grids, DBGrids, ExtCtrls,
  Buttons, ComCtrls, DBCtrls, DB, Vcl.Mask, CClientesFull, SOAPHTTPClient;

type
  TF_Pedidos = class(TF_PadraoCad)
    edtCodDe: TLabeledEdit;
    edtCodAte: TLabeledEdit;
    ckConfirmados: TCheckBox;
    ckIntegrados: TCheckBox;
    ckCancelados: TCheckBox;
    Label1: TLabel;
    DtaIni: TMaskEdit;
    DtaFim: TMaskEdit;
    Label2: TLabel;
    Label6: TLabel;
    sbCodCli: TSpeedButton;
    CodCli: TEdit;
    NomeCli: TEdit;
    GeraPedido: TBitBtn;
    procedure edtCodDeExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure IncluirClick(Sender: TObject);
    procedure btManutencaoClick(Sender: TObject);
    procedure btDuplicarClick(Sender: TObject);
    procedure DtaIniExit(Sender: TObject);
    procedure DtaIniKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sbCodCliClick(Sender: TObject);
    procedure CodCliKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CodCliExit(Sender: TObject);
    procedure CodCliChange(Sender: TObject);
    procedure ckConfirmadosClick(Sender: TObject);
    procedure GeraPedidoClick(Sender: TObject);
  private
    { Private declarations }

    obCliente: tclientesfull;

    procedure AcessoMenu;
  public
    { Public declarations }
    procedure Selecionar; override;
  end;

var
  F_Pedidos: TF_Pedidos;

implementation

uses U_T2, SelecaoAvancada, U_SisProc, Conexao, U_Pedidos1, U_IdentifUsr, U_Pedidos2Gerar;

{$R *.dfm}
{ TF_Dimensoes }

procedure TF_Pedidos.AcessoMenu;
begin
  // Incluir.Enabled      := TemAcesso('');
  // btManutencao.Enabled := TemAcesso('') or TemAcesso(''); //Alterar ou Excluir
end;

procedure TF_Pedidos.btDuplicarClick(Sender: TObject);
begin
  inherited;

  Application.CreateForm(TF_Pedidos1, F_Pedidos1);
  with F_Pedidos1 do
  begin
    obPedidoWeb.setId(T2.cdsgWtpedido['ID']);
    if not obPedidoWeb.Consultar then
    begin
      DL_Msg('Pedido não existe.', Application.Title, 'ERRO');
      exit;
    end;

    Visualizar.Visible := false;
    btExcluir.Visible := false;
    Caption := 'Incluir';

    Mostra;
    edtId.Clear;

    ShowModal;
  end;
end;

procedure TF_Pedidos.btManutencaoClick(Sender: TObject);
begin
  inherited;

  Application.CreateForm(TF_Pedidos1, F_Pedidos1);
  with F_Pedidos1 do
  begin
    obPedidoWeb.setId(T2.cdsgWtpedido['ID']);
    if not obPedidoWeb.Consultar then
    begin
      DL_Msg('Pedido não existe.', Application.Title, 'ERRO');
      exit;
    end;

    Caption := 'Manutenção';
    Mostra;
    ShowModal;
  end;
end;

procedure TF_Pedidos.ckConfirmadosClick(Sender: TObject);
begin
  inherited;
  CodCli.Modified := True;
end;

procedure TF_Pedidos.CodCliChange(Sender: TObject);
begin
  inherited;
  NomeCli.Clear;
  if (String(CodCli.Text)).Length < 6 then
    exit;

  obCliente.setCli_codigo(CodCli.Text);
  if obCliente.Consultar then
    NomeCli.Text := obCliente.getCli_nome
end;

procedure TF_Pedidos.CodCliExit(Sender: TObject);
begin
  inherited;

  NomeCli.Clear;
  if Trim(CodCli.Text) = '' then
    exit;

  CodCli.Text := StrZero(CodCli.Text, 6);
  obCliente.setCli_codigo(CodCli.Text);
  if obCliente.Consultar then
    NomeCli.Text := obCliente.getCli_nome
  else
    Raise Exception.Create('Cliente não cadatrado.');
end;

procedure TF_Pedidos.CodCliKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_F4 then
    sbCodCli.Click;
end;

procedure TF_Pedidos.DtaIniExit(Sender: TObject);
begin
  inherited;
  If Trim((Sender as TMaskEdit).Text) = '/  /' Then
  begin
    If ((Sender as TMaskEdit).Name = 'DtaIni') then
      DtaFim.Clear;
    exit;
  end;

  If Not VerData((Sender as TMaskEdit).Text) Then
  Begin
    (Sender as TMaskEdit).SetFocus;
    exit;
  End;
  (Sender as TMaskEdit).Text := FormatDateTime('dd/mm/yyyy', StrToDateTime((Sender as TMaskEdit).Text));

  If ((Sender as TMaskEdit).Name = 'DtaIni') then
    If (DtaFim.Text = '  /  /    ') or ((StrToDate((Sender as TMaskEdit).Text)) > (StrToDate(DtaFim.Text))) then
      DtaFim.Text := FormatDateTime('dd/mm/yyyy', StrToDateTime((Sender as TMaskEdit).Text));
end;

procedure TF_Pedidos.DtaIniKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = 72 then
    (Sender as TMaskEdit).Text := FormatDateTime('dd/mm/yyyy', Date); { 72 = H = Hoje }
  DtaIni.Modified := True;
end;

procedure TF_Pedidos.edtCodDeExit(Sender: TObject);
begin
  inherited;
  if Trim((Sender as TLabeledEdit).Text) <> '' then
  begin
    (Sender as TLabeledEdit).Text := StrZero((Sender as TLabeledEdit).Text, 6);
    (Sender as TLabeledEdit).Modified := True;
  end;
end;

procedure TF_Pedidos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  obCliente.Free;
end;

procedure TF_Pedidos.FormCreate(Sender: TObject);
begin
  inherited;

  obCliente := tclientesfull.Create;

  edtCodDe.Text := LeSepePar('PedidosWeb', 'edtCodDe', T2.qaSepeRel, Conexao.GetUsuario);
  edtCodAte.Text := LeSepePar('PedidosWeb', 'edtCodAte', T2.qaSepeRel, Conexao.GetUsuario);

  DtaIni.Text := LeSepePar('PedidosWeb', 'DtaIni', T2.qaSepeRel, Conexao.GetUsuario);
  DtaFim.Text := LeSepePar('PedidosWeb', 'DtaFim', T2.qaSepeRel, Conexao.GetUsuario);
  CodCli.Text := LeSepePar('PedidosWeb', 'CodCli', T2.qaSepeRel, Conexao.GetUsuario);

  LeSepePar('PedidosWeb', 'ckConfirmados', ckConfirmados, T2.qaSepeRel, Conexao.GetUsuario);
  LeSepePar('PedidosWeb', 'ckIntegrados', ckIntegrados, T2.qaSepeRel, Conexao.GetUsuario);
  LeSepePar('PedidosWeb', 'ckCancelados', ckCancelados, T2.qaSepeRel, Conexao.GetUsuario);

  AcessoMenu;
end;

procedure TF_Pedidos.GeraPedidoClick(Sender: TObject);
begin
  inherited;
  if T2.cdsgWtpedido.IsEmpty then
  begin
    ShowMessage('É necessário atualizar - < F5 >!');
    exit;
  end;

  if Nst(T2.cdsgWtpedido['CodigoInt']) <> '' then
  begin
    DL_Msg('Já foi gerado o pedido de venda ' + Nst(T2.cdsgWtpedido['CodigoInt']) + '!', Application.Title, 'ERRO');
    Abort;
  end;

  try
    F_Pedidos2Gerar.Show
  Except
    Application.CreateForm(TF_Pedidos2Gerar, F_Pedidos2Gerar)
  End;
  with F_Pedidos2Gerar do
  begin
    Caption := 'Gerar Pedido';

    obWebPedido.setId(T2.cdsgWtpedido['ID']);
    if obWebPedido.Consultar then
      Mostra;
  end;
end;

procedure TF_Pedidos.IncluirClick(Sender: TObject);
begin
  inherited;

  Application.CreateForm(TF_Pedidos1, F_Pedidos1);
  with F_Pedidos1 do
  begin
    Caption := 'Incluir';
    ValoresDefault;
    Visualizar.Visible := false;
    ShowModal;
  end;
end;

procedure TF_Pedidos.Selecionar;
var
  Q, S, Status: String;
begin
  inherited;

  GravaSepePar('PedidosWeb', 'edtCodDe', edtCodDe.Text, T2.qaSepeRel, Conexao.GetUsuario);
  GravaSepePar('PedidosWeb', 'edtCodAte', edtCodAte.Text, T2.qaSepeRel, Conexao.GetUsuario);
  GravaSepePar('PedidosWeb', 'ckConfirmados', ckConfirmados, T2.qaSepeRel, Conexao.GetUsuario);
  GravaSepePar('PedidosWeb', 'ckIntegrados', ckIntegrados, T2.qaSepeRel, Conexao.GetUsuario);
  GravaSepePar('PedidosWeb', 'ckCancelados', ckCancelados, T2.qaSepeRel, Conexao.GetUsuario);

  GravaSepePar('PedidosWeb', 'DtaIni', DtaIni.Text, T2.qaSepeRel, Conexao.GetUsuario);
  GravaSepePar('PedidosWeb', 'DtaFim', DtaFim.Text, T2.qaSepeRel, Conexao.GetUsuario);
  GravaSepePar('PedidosWeb', 'CodCli', CodCli.Text, T2.qaSepeRel, Conexao.GetUsuario);

  Q := 'Select ID, CodigoInt, Emissao, Status, BaseIcms, ValorIcms, BaseIpi, ValorIpi, BaseSt, ValorSt, TotalProdutos,';
  Q := Q + sLineBreak + 'TotalPedido, Cli_Codigo, Cli_Nome';
  Q := Q + sLineBreak + 'From WTPedido';
  Q := Q + sLineBreak + 'Left Join ScraCli on Cli_Codigo = WTPedido.CodTCliente';
  Q := Q + sLineBreak + 'Where 1 = 1';

  if tSelecao.ActivePageIndex = 0 then
  begin
    Status := '';
    if ckConfirmados.Checked then
      Status := '''V''';

    if ckIntegrados.Checked then
    begin
      if not Status.IsEmpty then
        Status := Status + ', ';

      Status := Status + '''I''';
    end;

    if ckCancelados.Checked then
    begin
      if not Status.IsEmpty then
        Status := Status + ', ';

      Status := Status + '''C''';
    end;

    if Status <> '' then
      Q := Q + sLineBreak + 'and Status in (' + Status + ')';

    if (Trim(edtCodDe.Text) <> '') and (Trim(edtCodAte.Text) <> '') then
      Q := Q + #10#13 + 'and CodigoInt between :CodDe and :CodAte';

    if (Trim(DtaIni.Text) <> '/  /') and (Trim(DtaFim.Text) <> '/  /') then
      Q := Q + #10#13 + 'and Emissao between :DtaIni and :DtaFim';

    if Trim(CodCli.Text) <> '' then
      Q := Q + sLineBreak + 'and Cli_Codigo = :CodCli';
  end;

  if tSelecao.ActivePageIndex = 1 then
  begin
    S := SentencaSelecao(DBGrid1, FieldSel1.Text, De1.Text, Ate1.Text, FieldSel2.Text, De2.Text, Ate2.Text);
    if S = '' then
      exit
    else
      Q := Q + #10#13 + 'and ' + S;
  end;

  T2.cdsgWtpedido.Active := false;

  T2.qgWtpedido.Close;
  T2.qgWtpedido.SQL.Clear;
  T2.qgWtpedido.SQL.Add(Q);

  if tSelecao.ActivePageIndex = 0 then
  begin
    if (Trim(edtCodDe.Text) <> '') and (Trim(edtCodAte.Text) <> '') then
    begin
      T2.qgWtpedido.ParamByName('CodDe').AsString := edtCodDe.Text;
      T2.qgWtpedido.ParamByName('CodAte').AsString := edtCodAte.Text;
    end;

    if (Trim(DtaIni.Text) <> '/  /') and (Trim(DtaFim.Text) <> '/  /') then
    begin
      T2.qgWtpedido.ParamByName('DtaIni').AsDate := StrToDate(DtaIni.Text);
      T2.qgWtpedido.ParamByName('DtaFim').AsDate := StrToDate(DtaFim.Text);
    end;

    if Trim(CodCli.Text) <> '' then
      T2.qgWtpedido.ParamByName('CodCli').AsString := CodCli.Text;
  end;

  Try
    T2.cdsgWtpedido.Active := True;
  except
    on E: Exception do
      ShowMessage('Erro ao fazer seleção:' + #13#10 + E.message)
    else
      ShowMessage('Erro ao fazer seleção.');
  end;

  TFloatField(T2.cdsgWtpedido.FieldByName('BaseIcms')).DisplayFormat := '###,###,##0.00';
  TFloatField(T2.cdsgWtpedido.FieldByName('ValorIcms')).DisplayFormat := '###,###,##0.00';
  TFloatField(T2.cdsgWtpedido.FieldByName('BaseIpi')).DisplayFormat := '###,###,##0.00';
  TFloatField(T2.cdsgWtpedido.FieldByName('ValorIpi')).DisplayFormat := '###,###,##0.00';
  TFloatField(T2.cdsgWtpedido.FieldByName('BaseSt')).DisplayFormat := '###,###,##0.00';
  TFloatField(T2.cdsgWtpedido.FieldByName('ValorSt')).DisplayFormat := '###,###,##0.00';
  TFloatField(T2.cdsgWtpedido.FieldByName('TotalProdutos')).DisplayFormat := '###,###,##0.00';
  TFloatField(T2.cdsgWtpedido.FieldByName('TotalPedido')).DisplayFormat := '###,###,##0.00';

  titPesq.Caption := 'Código:';
  OrdenaGridMultIndex(DBGrid1, T2.cdsgWtpedido, 'Código');

  Application.ProcessMessages;
end;

procedure TF_Pedidos.sbCodCliClick(Sender: TObject);
begin
  inherited;
  if obCliente.Selecionar then
  begin
    CodCli.Text := obCliente.getCli_codigo;
    NomeCli.Text := obCliente.getCli_nome;
    CodCli.Modified := True;
  end;
end;

end.
