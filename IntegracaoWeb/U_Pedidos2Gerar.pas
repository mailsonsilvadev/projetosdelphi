unit U_Pedidos2Gerar;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, Buttons, ExtCtrls, DBCtrls, DB, DBClient, Grids, DBGrids,
  CClientes, CFormaPgnto, CNaturezaOpr, Consulta, CWtpedido, Conexao,
  CWtpedidoitem, CPedidoVenda, CItensPedido, Transacao, CTransportadoras,
  CProdutos, CProxcst, U_WebIntegracaoSaldoTmp, CVendedores;

type
  TF_Pedidos2Gerar = class(TForm)
    Panel2: TPanel;
    GridItens: TDBGrid;
    dsItens: TDataSource;
    cdsItens: TClientDataSet;
    Panel4: TPanel;
    Label16: TLabel;
    Label5: TLabel;
    lbQuant: TLabel;
    TotalPed: TEdit;
    Panel1: TPanel;
    Fechar: TSpeedButton;
    Confirmar: TBitBtn;
    OrcNro: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Data: TMaskEdit;
    CODCLID: TEdit;
    CODCLI: TEdit;
    Label6: TLabel;
    Label3: TLabel;
    CODPAG: TEdit;
    CODPAGD: TEdit;
    edtDesconto: TEdit;
    Label4: TLabel;
    edtFrete: TEdit;
    Label7: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FecharClick(Sender: TObject);
    procedure CODCLIChange(Sender: TObject);
    procedure CODPAGChange(Sender: TObject);
    procedure CODPAGExit(Sender: TObject);
    procedure CODPAGKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure ConfirmarClick(Sender: TObject);
    procedure GridItensDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    obItemOrcamento: TWtpedidoitem;
    obClientes: TClientes;
    obFormaPgnto: TFormaPgnto;
    obNaturezaOpr: TNaturezaOpr;
    obPedidoVenda: TPedidoVenda;
    obItensPedido: TItensPedido;
    obProdutos: TProdutos;
    obProxCst: TProxcst;
    obVendedor: TVendedores;
    obTransp: TTransportadoras;

    procedure CriaTemp;
    procedure MostraItens(Orc: String);
    procedure RecalcItend;
    function VerificaDadosParaPedido: Boolean;
    function AvisoEstoque(CodPro, CodAlx: String; QtdeTotal: Real; ComExcecao: Boolean = true): Boolean;
    function GerarPedido: String;
    function GracarCabecPedido: String;
    procedure GravaItensPedido(NrPed: String; cdsDados: TClientDataSet);
    function PermiteLiberacao: Boolean;
    procedure AtualizarHistorico(NrPedido: String);

    { Private declarations }
  public
    obWebPedido: TWtpedido;
    { Public declarations }
    procedure Mostra;
  end;

var
  F_Pedidos2Gerar: TF_Pedidos2Gerar;

implementation

uses U_Sisproc, U_NroNF, U_T2, U_Orcamento1, U_Tributacao, U_HistoricoPedido, U_UteisOrc; // , U_Pedido;

{$R *.DFM}

procedure TF_Pedidos2Gerar.FormCreate(Sender: TObject);
begin
  obWebPedido := TWtpedido.Create;
  obItemOrcamento := TWtpedidoitem.Create;
  obClientes := TClientes.Create;
  obFormaPgnto := TFormaPgnto.Create;
  obNaturezaOpr := TNaturezaOpr.Create;
  obPedidoVenda := TPedidoVenda.Create;
  obItensPedido := TItensPedido.Create;
  obProdutos := TProdutos.Create;
  obProxCst := TProxcst.Create;
  obVendedor := TVendedores.Create;
  obTransp := TTransportadoras.Create;
end;

procedure TF_Pedidos2Gerar.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  obWebPedido.Free;
  obItemOrcamento.Free;
  obClientes.Free;
  obFormaPgnto.Free;
  obNaturezaOpr.Free;
  obPedidoVenda.Free;
  obItensPedido.Free;
  obProdutos.Free;
  obProxCst.Free;
  obVendedor.Free;
  obTransp.Free;

  if T2.cdsgWtpedido.Active then
    T2.cdsgWtpedido.Refresh;

  Action := Cafree;
  F_Pedidos2Gerar := nil;
end;

procedure TF_Pedidos2Gerar.FormKeyPress(Sender: TObject; var Key: Char);
begin
  NextControl(self, Key);
end;

procedure TF_Pedidos2Gerar.FecharClick(Sender: TObject);
begin
  close;
end;

procedure TF_Pedidos2Gerar.CODCLIChange(Sender: TObject);
begin
  (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Clear;
  if Length(Trim((Sender as TEdit).Text)) < 6 then
    Exit;

  obClientes.setCli_codigo(Trim((Sender as TEdit).Text));
  if obClientes.Consultar then
    (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Text := obClientes.getCli_nome
  else
    (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Clear;
end;

procedure TF_Pedidos2Gerar.CODPAGChange(Sender: TObject);
begin
  (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Clear;
  if Length(Trim((Sender as TEdit).Text)) < 3 then
    Exit;

  obFormaPgnto.setPgnf_cod(Trim((Sender as TEdit).Text));
  if obFormaPgnto.Consultar then
    (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Text := obFormaPgnto.getPgnf_cond;
end;

procedure TF_Pedidos2Gerar.CODPAGExit(Sender: TObject);
begin
  if Trim((Sender as TEdit).Text) = '' then
    Exit;

  obFormaPgnto.setPgnf_cod(Trim((Sender as TEdit).Text));
  if not obFormaPgnto.Consultar then
  begin
    (Sender as TEdit).SetFocus;
    (Sender as TEdit).SelectAll;
    Raise Exception.Create('Forma de Pagamento não Cadastrada!');
  end;

end;

procedure TF_Pedidos2Gerar.CODPAGKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Q: String;
begin
  if (Caption = 'Ver') or (Caption = 'Excluir') then
    Exit;

  if Key = VK_F4 then
  begin
    Q := 'Select PGNF_COD Codigo, PGNF_DESCR Descricao, PGNF_COND Condicao';
    Q := Q + #10#13 + 'From SCRAPGNF';
    If ConsultaDl(T2.WsepeDBX, Q, 'Condicao', 'Consulta de Condições de Pagamento') Then
    begin
      (Sender as TEdit).Text := Consulta.getValor('Codigo');
      (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Text := Consulta.getValor('Descricao');
    end;
  end;
end;

procedure TF_Pedidos2Gerar.CriaTemp;
begin
  if cdsItens.Active then
  begin
    cdsItens.EmptyDataSet;
    Exit;
  end;

  cdsItens.close;
  with cdsItens.FieldDefs do
  begin
    Clear;
    Add('ITEM', ftString, 4, false);
    Add('CODPRO', ftString, 10, false);
    Add('DESCRI', ftString, 120, false);
    Add('OBSERVACAO', ftString, 300, false);
    Add('CODALX', ftString, 3, false);
    Add('CODTAB', ftString, 3, false);
    Add('VLRUNI', ftFloat, 0, false);
    Add('QTDE', ftFloat, 0, false);
    Add('VLRTOT', ftFloat, 0, false);
    Add('NATOPR', ftString, 4, false);
    Add('CODOPR', ftString, 2, false);
    Add('CODTNA', ftString, 3, false);
    Add('PERDES', ftFloat, 0, false);
    Add('VLRDES', ftFloat, 0, false);

    Add('CstIcm', ftString, 3, false);
    Add('CstPis', ftString, 2, false);
    Add('CstCof', ftString, 2, false);
    Add('CstIpi', ftString, 2, false);
    Add('Csosn', ftString, 3, false);
    Add('PrMva', ftFloat, 0, false);
    Add('PrIcm', ftFloat, 0, false);
    Add('PrIpi', ftFloat, 0, false);
    Add('PrIss', ftFloat, 0, false);
    Add('PrIns', ftFloat, 0, false);
    Add('PrIrf', ftFloat, 0, false);
    Add('SitIcm', ftString, 1, false);
    Add('SitIpi', ftString, 1, false);
    Add('RedIcm', ftFloat, 0, false);
    Add('RedIss', ftFloat, 0, false);
    Add('RedIns', ftFloat, 0, false);
    Add('RetIss', ftString, 1, false);
    Add('RetPis', ftString, 1, false);
    Add('VlrRet', ftFloat, 0, false);
    Add('BasSub', ftFloat, 0, false);
    Add('VlrSub', ftFloat, 0, false);
    Add('BasIpi', ftFloat, 0, false);
    Add('VlrIpi', ftFloat, 0, false);
    Add('BasIcm', ftFloat, 0, false);
    Add('VlrIcm', ftFloat, 0, false);
  end;

  cdsItens.CreateDataSet;
  cdsItens.IndexDefs.Clear;
  cdsItens.IndexDefs.Add('cdsIndex', 'ITEM', [ixPrimary]);
  cdsItens.IndexName := 'cdsIndex';
  cdsItens.Open;
end;

procedure TF_Pedidos2Gerar.Mostra;
begin
  OrcNro.Text := Nst(obWebPedido.getId);
  Data.Text := DateToStr(obWebPedido.getEmissao);
  CODCLI.Text := obWebPedido.getCodtcliente;
  CODPAG.Text := obWebPedido.getCodtcondpag;
  edtFrete.Text := Str(obWebPedido.getValorfrete, 2);
  edtDesconto.Text := Str(obWebPedido.getValordesconto, 2);

  if cdsItens.Active then
    cdsItens.EmptyDataSet
  else
    CriaTemp;

  try
    MostraItens(Nst(obWebPedido.getId));
  Except
    on E: Exception do
    begin
      DL_Msg('Ocorreu um erro: ' + E.Message, Application.Title, 'ERRO');
      close;
    end
    else
    begin
      DL_Msg('Ocorreu um erro!', Application.Title, 'ERRO');
      close;
    end;
  End;
end;

procedure TF_Pedidos2Gerar.MostraItens(Orc: String);
Var
  Q, CodAlx: String;
  ProSemAlx: Boolean;
  obWebSaldo: TWebIntegracaoSaldoTmp;
begin
  obWebSaldo := TWebIntegracaoSaldoTmp.Create;
  Try
    CodAlx := obWebSaldo.GetAlxPadrao('');
  Finally
    obWebSaldo.Free;
  End;

  Q := 'Select CodTProduto, WtpedidoItem.ID, CodTTabPreco, Quantidade, PRO_DESCRI Descricao, WtpedidoItem.Observacao, VlrUnitario,';
  Q := Q + #10#13 + 'TotalProduto, Nt_CodTna, PrDescItem, ValorDescItem, ValorSt, ValorIpi, CfopTCadCfop,';
  Q := Q + #10#13 + 'VarTCadCfop, BaseIpi, ValorIpi, BaseIcms, ValorIcms, CstIcms, CstPis, CstCofins,';
  Q := Q + #10#13 + 'CstIpi, Csosn, PrMva, PrIcms, PrIpi, PrIss, PrInss, PrIrf, Pro_AlxPdr as CodAlx,';
  Q := Q + #10#13 + 'PrRedIcms, RetIss, RetPis, BaseSt, ValorSt';
  Q := Q + #10#13 + 'FROM WtpedidoItem';
  Q := Q + #10#13 + 'Left Join EstaPro on Pro_Codigo = WtpedidoItem.Codtproduto';
  Q := Q + #10#13 + 'Left Join SlfaNto on Nt_Cfo = CfopTCadCfop and Nt_Opc = VarTCadCfop';
  Q := Q + #10#13 + 'Where idtpedido = ' + Orc;
  Q := Q + #10#13 + 'Order By wtpedidoitem.ID';

  T2.cdsC2.Active := false;
  T2.qC2.close;
  T2.qC2.SQL.Clear;
  T2.qC2.SQL.Add(Q);
  T2.cdsC2.Active := true;

  ProSemAlx := false;
  T2.cdsC2.First;
  While not T2.cdsC2.Eof do
  begin
    cdsItens.Append;
    cdsItens['ITEM'] := Nst(T2.cdsC2['ID']);
    cdsItens['CODPRO'] := Trim(Nst(T2.cdsC2['Codtproduto']));
    cdsItens['DESCRI'] := Trim(Nst(T2.cdsC2['Descricao']));
    cdsItens['OBSERVACAO'] := Trim(Nst(T2.cdsC2['OBSERVACAO']));

    if CodAlx.IsEmpty then
      cdsItens['CODALX'] := Nst(T2.cdsC2['CodAlx'])
    else
      cdsItens['CODALX'] := CodAlx;

    cdsItens['CODTAB'] := Trim(Nst(T2.cdsC2['Codttabpreco']));
    cdsItens['NATOPR'] := Trim(Nst(T2.cdsC2['CfopTCadCfop']));
    cdsItens['CODOPR'] := Trim(Nst(T2.cdsC2['VarTCadCfop']));
    cdsItens['VLRUNI'] := Val(Str(Nvl(T2.cdsC2['VlrUnitario']), 2));
    cdsItens['QTDE'] := Val(Str(Nvl(T2.cdsC2['Quantidade']), 2));
    cdsItens['VLRTOT'] := Val(Str(Nvl(cdsItens['QTDE']) * Nvl(cdsItens['VLRUNI']), 2));
    cdsItens['CODTNA'] := Trim(Nst(T2.cdsC2['Nt_CodTna']));
    cdsItens['PERDES'] := Val(Str(Nvl(T2.cdsC2['PrDescItem']), 2));
    cdsItens['VLRDES'] := Val(Str(Nvl(T2.cdsC2['ValorDescItem']), 2));

    cdsItens['CstIcm'] := Nst(T2.cdsC2['CstIcms']);
    cdsItens['CstPis'] := Nst(T2.cdsC2['CstPis']);
    cdsItens['CstCof'] := Nst(T2.cdsC2['CstCofins']);
    cdsItens['CstIpi'] := Nst(T2.cdsC2['CstIpi']);
    cdsItens['Csosn'] := Nst(T2.cdsC2['Csosn']);
    cdsItens['PrMva'] := Nvl(T2.cdsC2['PrMva']);
    cdsItens['PrIcm'] := Nvl(T2.cdsC2['PrIcms']);
    cdsItens['PrIpi'] := Nvl(T2.cdsC2['PrIpi']);
    cdsItens['PrIss'] := Nvl(T2.cdsC2['PrIss']);
    cdsItens['PrIns'] := Nvl(T2.cdsC2['PrInss']);
    cdsItens['PrIrf'] := Nvl(T2.cdsC2['PrIrf']);
    cdsItens['SitIcm'] := TribICMS(Nst(cdsItens['CstIcm']));
    cdsItens['SitIpi'] := TribIPI(Nst(cdsItens['CstIpi']));
    cdsItens['RedIcm'] := Nvl(T2.cdsC2['PrRedIcms']);
    cdsItens['RetIss'] := Nst(T2.cdsC2['RetIss']);
    cdsItens['RetPis'] := Nst(T2.cdsC2['RetPis']);
    cdsItens['BasSub'] := Nvl(T2.cdsC2['BaseSt']);
    cdsItens['VlrSub'] := Nvl(T2.cdsC2['ValorSt']);
    cdsItens['BasIpi'] := Nvl(T2.cdsC2['BaseIpi']);
    cdsItens['VlrIpi'] := Nvl(T2.cdsC2['ValorIpi']);
    cdsItens['BasIcm'] := Nvl(T2.cdsC2['BaseIcms']);
    cdsItens['VlrIcm'] := Nvl(T2.cdsC2['ValorIcms']);
    cdsItens.Post;

    if Nst(cdsItens['CODALX']).IsEmpty then
    begin
      ProSemAlx := true;
    end;

    T2.cdsC2.Next;
  end;

  cdsItens.First;

  VerificaProAtivo('CODPRO', cdsItens);

  RecalcItend;

  GridItens.SelectedIndex := 8;

  if ProSemAlx then
  begin
    DL_Msg('Existem produtos sem almoxarifado padrão, corrija o cadastro dos produtos e tente novamente!', Application.Title, 'AVISO');
    Confirmar.Enabled := false;
  end;
end;

procedure TF_Pedidos2Gerar.RecalcItend;
var
  BMK: TBookMark;
  Quant: Integer;
  SomaTotal: Real;
begin
  if not cdsItens.Active then
    Exit;

  if cdsItens.IsEmpty then
  begin
    TotalPed.Text := '0,00';
    Exit;
  end;

  cdsItens.DisableControls;

  Quant := 0;
  SomaTotal := 0;
  BMK := cdsItens.GetBookmark;
  cdsItens.First;
  While not cdsItens.Eof do
  begin
    cdsItens.Edit;
    cdsItens['VLRTOT'] := Str(Nvl(cdsItens['Qtde']) * Nvl(cdsItens['VLRUNI']), 2);
    cdsItens.Post;

    Quant := Quant + Ivl(cdsItens['Qtde']);
    SomaTotal := SomaTotal + Nvl(cdsItens['VLRTOT']) + Nvl(cdsItens['VLRSUB']) + Nvl(cdsItens['VLRIPI']) - Nvl(cdsItens['VLRRET']);
    cdsItens.Next;
  end;

  lbQuant.Caption := IntToStr(Quant);
  TotalPed.Text := Str(SomaTotal - Nvl(edtDesconto.Text) + Nvl(edtFrete.Text), 2);

  cdsItens.EnableControls;
  cdsItens.GotoBookmark(BMK);
  Application.ProcessMessages;

end;

function TF_Pedidos2Gerar.VerificaDadosParaPedido: Boolean;
var
  AtuEst, EstNeg, ntop, cdop: String;
begin
  Result := true;
  if Trim(OrcNro.Text) = '' then
  begin
    close;
    Raise Exception.Create('Numero do Orçamento em branco!');
  end;

  if Trim(CODCLI.Text) = '' then
  begin
    close;
    Raise Exception.Create('Cliente em branco!');
  end;

  if Trim(CODPAG.Text) = '' then
  begin
    CODPAG.SetFocus;
    CODPAG.SelectAll;
    Raise Exception.Create('Condição de Pagamento em branco!');
  end;

  if Val(lbQuant.Caption) <= 0 then
  begin
    GridItens.SetFocus;
    cdsItens.First;
    GridItens.SelectedIndex := 8;
    Raise Exception.Create('Nenhum item com quantidade maior que zero para o pedido!');
  end;

  AtuEst := BuscaCFG(T2.qgSepeCfg, 'SepeCFG', 'CFG_ATUEST', 1, 1);
  EstNeg := BuscaCFG(T2.qgSepeCfg, 'SepeCfg', 'CFG_ESTNEG', 1, 1);

  cdsItens.First;
  While not cdsItens.Eof do
  begin
    if (Trim(Nst(cdsItens['NATOPR'])) <> '') and (Trim(Nst(cdsItens['CODOPR'])) <> '') then
    begin
      ntop := Nst(cdsItens['NATOPR']);
      cdop := Nst(cdsItens['CODOPR']);
    end;

    if (Nvl(cdsItens['Qtde']) > 0) then
    begin
      obNaturezaOpr.setNt_cfo(ntop);
      obNaturezaOpr.setNt_opc(cdop);

      if (obNaturezaOpr.Consultar) and (obNaturezaOpr.getNt_atuest = 'S') then
        if (AtuEst = 'S') and (EstNeg = 'N')
        // Se Atualiza o estoque e Atualizacao do estoque passa com estoque negativo ?
        then
          AvisoEstoque(Nst(cdsItens['CODPRO']), Nst(cdsItens['CODALX']), Nvl(cdsItens['Qtde']));

    end;

    cdsItens.Next;
  end;
  // end;

end;

procedure TF_Pedidos2Gerar.AtualizarHistorico(NrPedido: String);
var
  obHistorico: THistoricoPedido;
begin
  obHistorico := THistoricoPedido.Create;
  Try
    obHistorico.GravarHistorico(NrPedido, '', 'INT');
  Finally
    obHistorico.Free;
  End;
end;

function TF_Pedidos2Gerar.AvisoEstoque(CodPro, CodAlx: String; QtdeTotal: Real; ComExcecao: Boolean = true): Boolean;
var
  MsgErro: String;
begin

  Result := true;

  if Trim(CodPro) = '' then
    Exit;

  if SetKeyDl(T2.qC1, 'EstaPro', ['PRO_CODIGO'], [CodPro]) then
    if Nst(T2.qC1['PRO_COMEST']) = 'S' then
      if SetKeyDl(T2.qC1, 'EcmaAlx', ['ALX_CODPRO', 'ALX_CODALX'], [CodPro, CodAlx]) then
      begin
        if (Nvl(T2.qC1['ALX_QUANT']) - QtdeTotal) < 0 Then
        begin
          // ConfItem.Enabled := false;
          MsgErro := 'Produto ' + CodPro + ' com  Saldo atual de ' + Str(Nvl(T2.qC1['ALX_QUANT']), 2) + ' no almoxarifado ' + CodAlx + '. Quantidade insuficiente neste almoxarifado ! ';

          Result := false;
        end;
      end
      else
      begin
        // ConfItem.Enabled := false;
        MsgErro := 'Produto ' + CodPro + ' sem saldo em estoque no almoxarifado ' + CodAlx;
        Result := false;
      end;

  if Trim(MsgErro) <> '' then
    if ComExcecao then
      Raise Exception.Create(MsgErro)
    else
      ShowMessage(MsgErro);

end;

procedure TF_Pedidos2Gerar.ConfirmarClick(Sender: TObject);
var
  NrPedido: String;
  Erro: Boolean;
begin
  if not VerificaDadosParaPedido then
    Exit;

  Confirmar.Enabled := false;
  Fechar.Enabled := false;
  Erro := false;
  try

    InicioTransacao(T2.WsepeDBX);

    try

      NrPedido := GerarPedido;

      // Não é preciso atualizar status de integrado porque foi criado uma tabela de histórico de status
      // AtualizarHistorico(NrPedido);

      FimTransacao(T2.WsepeDBX, true);

      Application.ProcessMessages;
      DL_Msg('O sistema gerou o pedido nº ' + NrPedido, 'Orçamento', 'INFORMACAO');

    except
      on E: Exception do
      begin
        ShowMessage('Erro: ' + E.Message);
        FimTransacao(T2.WsepeDBX, false);
        Erro := true;
      end
      else
      begin
        ShowMessage('Ocorreu um erro no processamento!');
        FimTransacao(T2.WsepeDBX, false);
        Erro := true;
      end;
    end;

  finally
    Confirmar.Enabled := true;
    Fechar.Enabled := true;
    Application.ProcessMessages;
  end;

  if not Erro then
  begin
    T2.cdsgVenaped.Active := false;
    T2.qgVenaped.close;
    T2.qgVenaped.SQL.Clear;
    T2.qgVenaped.SQL.Add('Select * From VenaPed');
    T2.qgVenaped.SQL.Add('Where PED_NRO = ' + #39 + NrPedido + #39);
    T2.cdsgVenaped.Active := true;
    if T2.cdsgVenaped.IsEmpty then
      Raise Exception.Create('Erro ao abrir pedido!');

    // PodeLiberar := PermiteLiberacao;

    // try
    Application.CreateForm(TF_Orcamento1, F_Orcamento1);
    F_Orcamento1.Visible := false;
    // F_Orcamento1.Show
    // except
    // Application.CreateForm(TF_Orcamento1, F_Orcamento1)
    // end;

    with F_Orcamento1 do
    begin
      Caption := 'Alterar';
      PrepararTela('Alterar');
      FazParcelamento('C', 'S');

      Cancelar.Visible := false;
      // F_Orcamento1.BorderIcons := [];
      ShowModal;
    end;

    // F_Pedido.ConfirmarLib.Visible := PodeLiberar;
    // F_Pedido.PrepararTela('Liberar_Ped');
    // F_Pedido.RecalcularPedidoVenda;
  end;

  close;

end;

function TF_Pedidos2Gerar.GerarPedido: String;
var
  Pedido: String;
begin
  Result := '';

  Pedido := StrZero(GracarCabecPedido, 7);

  obWebPedido.setCodigoint(Pedido);
  obWebPedido.setStatus('I');
  obWebPedido.setDatastatus(Date);
  obWebPedido.setCodtcondpag(CODPAG.Text);
  obWebPedido.Alterar;

  if Trim(Pedido) = '0000000' then
    Raise Exception.Create('Erro na gravação do Pedido!');

  cdsItens.First;
  While not cdsItens.Eof do
  begin

    if Nvl(cdsItens['Qtde']) > 0 then
      GravaItensPedido(Pedido, cdsItens);

    cdsItens.Next;
  end;

  /// GravaParcelasPedido(Val(TotalPed.Text));

  Result := Pedido;

end;

function TF_Pedidos2Gerar.GracarCabecPedido: String; // retorna o numero do pedido gerado...
var
  NroPedido, TpoComi: String;
begin
  Result := '';

  if not TemGenerator(T2.qgSepeCfg, 'CFG_PEDNUM') then
  begin
    NroPedido := '';
    Application.ProcessMessages;
    NroPedido := GeraNroOrcam(T2.qgSepeCfg);
    Application.ProcessMessages;

    if (NroPedido = '#######') or (NroPedido = '') then
      Raise Exception.Create('Não foi possível gerar o número do Pedido.');
  end
  else
    NroPedido := StrZero(IntToStr(IncContador(T2.qgSepeCfg, 'CFG_PEDNUM', 1)), 7);
  // 'variavel',0(zero) apenas retorna o valor mas não incrementa...

  Result := NroPedido;
  Application.ProcessMessages;

  TpoComi := BuscaCFG2(T2.qSepeCfg, 'SEPECFG', 'CFG_TPOCOM', 'Comissao da venda é usada do (C - Cadastro Cliente/ V - Cadastro do Vendedor', 'V', 1, 1);

  obPedidoVenda.setPed_nro(NroPedido);
  obPedidoVenda.setPed_nroorc(Nst(obWebPedido.getId));
  obPedidoVenda.setPed_idwped(obWebPedido.getId);
  obPedidoVenda.setPed_codcli(obWebPedido.getCodtcliente);

  obClientes.setCli_codigo(obPedidoVenda.getPed_codcli);
  obClientes.Consultar;

  obPedidoVenda.setPed_data(Date);
  obPedidoVenda.setPed_dtaent(obWebPedido.getPrventregad);
  obPedidoVenda.setPed_horent(obWebPedido.getPrventregah);
  obPedidoVenda.setPed_contat(obWebPedido.getContato);

  obPedidoVenda.setPed_vend(obWebPedido.getCodtvendedor);
  obPedidoVenda.setPed_nomcli(CODCLID.Text);
  obPedidoVenda.setPed_codpag(CODPAG.Text);
  obPedidoVenda.setPed_ger('');
  obPedidoVenda.setPed_obs1(Trim(obWebPedido.getObservacaonf + '   ' + obClientes.getCli_obsnfs));
  obPedidoVenda.setPed_obs2(obWebPedido.getObservacaoint);
  obPedidoVenda.setPed_obs3('');
  obPedidoVenda.setPed_tot1(Val(TotalPed.Text));
  obPedidoVenda.setPed_rep('');
  obPedidoVenda.setPed_prcomi(0);

  //Preferência da comissão é do cliente, só busca a comissão do vendedor se não tem comissão no cliente ou se a configuração de preferência é por vendedor
  if TpoComi = 'C' then
  begin
    obPedidoVenda.setPed_prcomi(obClientes.getCli_prcomi);
  end;

  if (TpoComi = 'V') or (obPedidoVenda.getPed_prcomi = 0) then
  begin
    obVendedor.setFun_codigo(obPedidoVenda.getPed_vend);
    if obVendedor.Consultar then
      obPedidoVenda.setPed_prcomi(obVendedor.getFun_comis);
  end;
  
  obPedidoVenda.setPed_dspicm('');
  obPedidoVenda.setPed_dspipi('');
  obPedidoVenda.setPed_iss(0);
  obPedidoVenda.setPed_inss(0);
  obPedidoVenda.setPed_bainss(obWebPedido.getBaseinss);
  obPedidoVenda.setPed_vlinss(obWebPedido.getValorinss);
  obPedidoVenda.setPed_alqirf(0);
  obPedidoVenda.setPed_codtrs(obWebPedido.getCodttransporta);
  obPedidoVenda.setPed_redesp('');

  obTransp.setTrs_codigo(obPedidoVenda.getPed_codtrs);
  if obTransp.Consultar then
  begin
    obPedidoVenda.setPed_placa(obTransp.getTrs_placa);
    obPedidoVenda.setPed_placauf(obTransp.getTrs_uf);
  end
  else
  begin
    obPedidoVenda.setPed_placa('');
    obPedidoVenda.setPed_placauf('');
  end;

  obPedidoVenda.setPed_totpro(Val(TotalPed.Text) - obWebPedido.getValorfrete + obWebPedido.getValordesconto);
  obPedidoVenda.setPed_basiss(obWebPedido.getBaseiss);
  obPedidoVenda.setPed_basccp(obWebPedido.getBasecsl);
  obPedidoVenda.setPed_alqccp(0);
  obPedidoVenda.setPed_vlrccp(obWebPedido.getValorcsl);

  obPedidoVenda.setPed_desc(obWebPedido.getPrdesconto);
  obPedidoVenda.setPed_desc1(obWebPedido.getValordesconto);
  obPedidoVenda.setPed_acres(obWebPedido.getPracrescimo);
  obPedidoVenda.setPed_acres1(obWebPedido.getValoracrescimo);

  obPedidoVenda.setPed_vlrirf(obWebPedido.getValorirf);
  obPedidoVenda.setPed_irf(0);
  obPedidoVenda.setPed_emba(obWebPedido.getValoroutras);
  obPedidoVenda.setPed_seguro(0);
  obPedidoVenda.setPed_volume(Nvl(ValDef(T2.qC1, 'VENAPED', 'PED_VOLUME')));
  obPedidoVenda.setPed_especi('');
  obPedidoVenda.setPed_marca('');
  obPedidoVenda.setPed_nrovol('');
  obPedidoVenda.setPed_pesol(0);
  obPedidoVenda.setPed_pesob(0);
  obPedidoVenda.setPed_vlfret(obWebPedido.getValorfrete);
  obPedidoVenda.setPed_retccp('N');
  obPedidoVenda.setPed_retiss('N');
  obPedidoVenda.setPed_frete(IntToStr(StrToIntDef(obWebPedido.getTipofrete, 0) + 1));
  obPedidoVenda.setPed_prfret(0);
  obPedidoVenda.setPed_pedorc(obWebPedido.getOrdemcompra);
  obPedidoVenda.setPed_dessuf(0);
  obPedidoVenda.setPed_orgped('W'); //Web

  obPedidoVenda.setPed_BasSub(obWebPedido.getBasest);
  obPedidoVenda.setPed_VlrSub(obWebPedido.getValorst);
  obPedidoVenda.setPed_BasIpi(obWebPedido.getBaseipi);
  obPedidoVenda.setPed_VlrIpi(obWebPedido.getValoripi);
  obPedidoVenda.setPed_BasIcm(obWebPedido.getBaseicms);
  obPedidoVenda.setPed_VlrIcm(obWebPedido.getValoricms);
  obPedidoVenda.setPed_datatu(Date);
  obPedidoVenda.setPed_usratu(Conexao.GetUsuario);
  obPedidoVenda.Salvar;

end;

procedure TF_Pedidos2Gerar.GravaItensPedido(NrPed: String; cdsDados: TClientDataSet);
begin
  obProdutos.setPro_codigo(Nst(cdsDados['CODPRO']));
  if not obProdutos.Consultar then
    Exit;

  obItensPedido.setIpd_nro(NrPed);
  obItensPedido.setIpd_descri(Nst(cdsDados['DESCRI']));

  // Em algumas empresas a observação do item na Web deve ser impressa na nota, então é necessário concatenar com a descrição do mesmo
  if BuscaCFG2(T2.qSepeCfg, 'SEPECFG', 'CFG_CONOBS', 'Concatenar observação do item à descrição.', 'N', 1, 1) <> 'S' then
    obItensPedido.setIpd_obs(Nst(cdsDados['OBSERVACAO']))
  else
  begin
    obItensPedido.setIpd_obs('');
    obItensPedido.setIpd_descri(Trim(obItensPedido.getIpd_descri + ' ' + Nst(cdsDados['OBSERVACAO'])));
  end;

  obItensPedido.setIpd_Codpro(Nst(cdsDados['CODPRO']));

  obItensPedido.setIpd_NatOpr(Nst(cdsDados['NATOPR']));
  obItensPedido.setIpd_codopr(Nst(cdsDados['CODOPR']));
  obItensPedido.setIpd_codtna(Nst(cdsDados['CODTNA']));

  obItensPedido.setIpd_qtde(Nvl(cdsDados['Qtde']));
  obItensPedido.setIpd_Desc(Nvl(cdsDados['VLRDES']));
  obItensPedido.setIpd_Acres(0);
  obItensPedido.setIpd_PrDesc(Nvl(cdsDados['PERDES']));
  obItensPedido.setIpd_VlrOrg(0);

  T2.cdsC4.Active := false;
  T2.qC4.close;
  T2.qC4.SQL.Clear;
  T2.qC4.SQL.Add('SELECT TAB_PRECO FROM VENATAB WHERE TAB_CODPRO = :PRO AND TAB_NRO = :TAB');
  T2.qC4.ParamByName('PRO').AsString := Nst(cdsDados['CODPRO']);
  T2.qC4.ParamByName('TAB').AsString := Nst(cdsDados['CODTAB']);
  T2.cdsC4.Active := true;

  if not T2.cdsC4.IsEmpty then
  begin
    if Nvl(T2.cdsC4['TAB_PRECO']) < Nvl(cdsDados['VLRUNI']) then
      obItensPedido.setIpd_Acres(Nvl(cdsDados['VLRUNI']) - Nvl(T2.cdsC4['TAB_PRECO']));

    if Nvl(T2.cdsC4['TAB_PRECO']) > Nvl(cdsDados['VLRUNI']) then
    begin
      obItensPedido.setIpd_Desc(Nvl(T2.cdsC4['TAB_PRECO']) - Nvl(cdsDados['VLRUNI']));
      obItensPedido.setIpd_PrDesc(100 - (Nvl(cdsDados['VLRUNI']) * 100) / Nvl(T2.cdsC4['TAB_PRECO']));
    end;

    obItensPedido.setIpd_VlrOrg(Nvl(T2.cdsC4['TAB_PRECO']));
  end;

  obItensPedido.setIpd_alx(Nst(cdsDados['CODALX']));
  obItensPedido.setIpd_tab(Nst(cdsDados['CODTAB']));
  obItensPedido.setIpd_VlOrg2(0); // Nvl(cdsDados['VLRUNI']));
  obItensPedido.setIpd_valor(Nvl(cdsDados['VLRTOT']));
  obItensPedido.setIpd_VlrLin(Nvl(cdsDados['VLRTOT']));
  obItensPedido.setIpd_codbar('');
  obItensPedido.setIpd_VlrUnt(Nvl(cdsDados['VLRUNI']));
  obItensPedido.setIpd_item(cdsItens.RecNo);
  obItensPedido.setIpd_Ipi(0);
  obItensPedido.setIpd_VlrIpi(0);
  obItensPedido.setIpd_conta('');
  obItensPedido.setIpd_ccusto('');
  obItensPedido.setIPD_BASIPI(0);
  obItensPedido.setIpd_Icm(0);

  obItensPedido.setIpd_cf(Nst(cdsItens['CstIcm']));
  obItensPedido.setIpd_piscst(Nst(cdsItens['CstPis']));
  obItensPedido.setIpd_cofcst(Nst(cdsItens['CstCof']));
  obItensPedido.setIpd_ipicst(Nst(cdsItens['CstIpi']));
  obItensPedido.setIpd_csosn(Nst(cdsItens['Csosn']));
  obItensPedido.setIpd_pradst(Nvl(cdsItens['PrMva']));
  obItensPedido.setIpd_Icm(Nvl(cdsItens['PrIcm']));
  obItensPedido.setIpd_Ipi(Nvl(cdsItens['PrIpi']));
  // obItensPedido.setIpd_    (Nvl(cdsItens['PrIss' ]));
  // obItensPedido.setIpd_    (Nvl(cdsItens['PrIns' ]));
  // obItensPedido.setIpd_    (Nvl(cdsItens['PrIrf' ]));
  obItensPedido.setIpd_siticm(Nst(cdsItens['SitIcm']));
  obItensPedido.setIpd_sitipi(Nst(cdsItens['SitIpi']));
  obItensPedido.setIpd_icmred(Nvl(cdsItens['RedIcm']));
  // obItensPedido.setIpd_    (Nvl(cdsItens['RedIss']));
  // obItensPedido.setIpd_    (Nvl(cdsItens['RedIns']));
  // obItensPedido.setIpd_    (Nvl(cdsItens['RetIss']));
  obItensPedido.setIpd_retpis(Nst(cdsItens['RetPis']));
  // obItensPedido.setIpd_    (Nvl(cdsItens['VlrRet']));
  obItensPedido.setIpd_bassub(Nvl(cdsItens['BasSub']));
  obItensPedido.setIpd_vlrsub(Nvl(cdsItens['VlrSub']));
  obItensPedido.setIPD_BASIPI(Nvl(cdsItens['BasIpi']));
  obItensPedido.setIpd_VlrIpi(Nvl(cdsItens['VlrIpi']));
  obItensPedido.setIpd_basicm(Nvl(cdsItens['BasIcm']));
  obItensPedido.setIpd_vlricm(Nvl(cdsItens['VlrIcm']));

  obItensPedido.setIpd_dessuf(0);
  obItensPedido.setIpd_datatu(Date);
  obItensPedido.setIpd_usratu(Conexao.GetUsuario);
  obItensPedido.Salvar;
end;

procedure TF_Pedidos2Gerar.GridItensDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  DbgridZebra(TClientDataSet(GridItens.DataSource.DataSet), GridItens, Rect, DataCol, Column, State);
end;

function TF_Pedidos2Gerar.PermiteLiberacao: Boolean;
var
  Datfec, Datmax: String;
begin

  Datfec := BuscaCFG(T2.qgSepeCfg, 'SEPECFG', 'CFG_DATFEC', 1, 10);
  Datmax := BuscaCFG(T2.qgSepeCfg, 'SEPECFG', 'CFG_DATMAX', 1, 10);

  obPedidoVenda.setPed_nro(T2.cdsgVenaped['Ped_Nro']);
  if not obPedidoVenda.Consultar then
    Raise Exception.Create('Pedido não encontrado.')
  else
  begin
    if Trim(obPedidoVenda.getPed_nfs) <> '' then
      Raise Exception.Create('Pedido já gerou nota fiscal: ' + obPedidoVenda.getPed_nfs + ', portanto sua liberação não pode ser modificada.');

    if (obPedidoVenda.getPed_data <= StrToDate(Datfec)) or (obPedidoVenda.getPed_data > StrToDate(Datmax)) then
      Raise Exception.Create('Pedido com data fora dos limites de operação do sistema.' + #13 + 'Limites do sistema de: ' + Datfec + ' até: ' + Datmax + #13 + 'Data do pedido: ' + DateToStr(obPedidoVenda.getPed_data));
  end;

  Result := true;

end;

end.
