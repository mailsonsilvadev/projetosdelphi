unit U_Pedidos1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, Buttons, ExtCtrls, DBCtrls, DB, DBClient, Grids, DBGrids,
  IniFiles, CAlmoxarifado, CClientes, CFormapgnto, CTabelaprecos, CProdutos,
  CTransportadoras, CVendedores, CWtpedido, CWtpedidoitem, DateUtils,
  Provider, FMTBcd, SqlExpr, CPrecos, CNaturezaopr, CCidades,
  CCadIndex, CCadaTna, CProxCst, U_CliInadim, AlignEdit,
  U_CarregarValoresTrib, CFabricantes, CGrupopro, CWTPedidoFull;

type
  TF_Pedidos1 = class(TForm)
    Panel1: TPanel;
    Visualizar: TDBNavigator;
    Imprimir: TBitBtn;
    fechar: TSpeedButton;
    Panel2: TPanel;
    Label1: TLabel;
    edtId: TEdit;
    Label2: TLabel;
    Data: TMaskEdit;
    Ped_CODCLI: TEdit;
    NomeCli: TEdit;
    Label3: TLabel;
    CODPAG: TEdit;
    CODPAGD: TEdit;
    Label4: TLabel;
    CODTRS: TEdit;
    CODTRSD: TEdit;
    Label5: TLabel;
    CODVEN: TEdit;
    CODVEND: TEdit;
    Label7: TLabel;
    VlrFrete: TEdit;
    Panel3: TPanel;
    cdsItens: TClientDataSet;
    dsItens: TDataSource;
    Label8: TLabel;
    CODPRO: TEdit;
    CODPROD: TEdit;
    Label10: TLabel;
    CODTAB: TEdit;
    Label11: TLabel;
    VlrUnt: TEdit;
    Label12: TLabel;
    Qtde: TEdit;
    Label13: TLabel;
    VlrTot: TEdit;
    Panel5: TPanel;
    btConfItem: TBitBtn;
    btExcItem: TSpeedButton;
    UNDPRO: TEdit;
    DBGrid1: TDBGrid;
    Cidade: TEdit;
    uf: TEdit;
    Label19: TLabel;
    Label85: TLabel;
    CodTna: TEdit;
    CodTnaD: TEdit;
    Label14: TLabel;
    NatOprD: TEdit;
    NATOPR: TEdit;
    CODOPR: TEdit;
    Label18: TLabel;
    Obs: TMemo;
    ProNcm: TEdit;
    SitICM: TEdit;
    SitIpi: TEdit;
    Contato: TComboBox;
    LbContato: TLabel;
    Fone: TEdit;
    Label83: TLabel;
    Ender: TEdit;
    Frete: TComboBox;
    Label40: TLabel;
    cdsServicos: TClientDataSet;
    btnDadosCli: TSpeedButton;
    VlrDesc: TEdit;
    Label20: TLabel;
    PercDesc: TEdit;
    Label23: TLabel;
    GroupBox3: TGroupBox;
    Label64: TLabel;
    Label76: TLabel;
    Label77: TLabel;
    Label78: TLabel;
    CODCST: TEdit;
    edCstPis: TEdit;
    edCstCof: TEdit;
    EdCstIPI: TEdit;
    edCSOSN: TEdit;
    GroupBox6: TGroupBox;
    Label79: TLabel;
    Label80: TLabel;
    Label86: TLabel;
    Label22: TLabel;
    prIcm: TEdit;
    prIPI: TEdit;
    prRedICM: TEdit;
    prMVA: TEdit;
    btGravar: TBitBtn;
    btExcluir: TBitBtn;
    Tipo: TLabel;
    Panel4: TPanel;
    lbItens: TLabel;
    Label16: TLabel;
    Label46: TLabel;
    Label45: TLabel;
    Label36: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label25: TLabel;
    TotalOrc: TEdit;
    edtBasSub: TAlignEdit;
    edtVlrSub: TAlignEdit;
    edtBasIpi: TAlignEdit;
    edtVlrIpi: TAlignEdit;
    edtBasIcm: TAlignEdit;
    edtVlrIcm: TAlignEdit;
    edtVlrIrf: TAlignEdit;
    gbRetencoes: TGroupBox;
    Label6: TLabel;
    Label9: TLabel;
    Label15: TLabel;
    Label17: TLabel;
    edtRetPis: TAlignEdit;
    edtRetCof: TAlignEdit;
    edtRetCsl: TAlignEdit;
    edtRetIss: TAlignEdit;
    gbSuframa: TGroupBox;
    Label21: TLabel;
    Label24: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    edtSufIcms: TAlignEdit;
    edtSufCof: TAlignEdit;
    edtSufIpi: TAlignEdit;
    edtSufPis: TAlignEdit;
    edtIdItem: TEdit;
    Label31: TLabel;
    edtSituacao: TEdit;
    lblAviso: TLabel;
    edtPrIcmsSt: TEdit;
    edtOrdemCompra: TEdit;
    Label32: TLabel;
    edtObservacao: TEdit;
    Label33: TLabel;
    Label34: TLabel;
    edtVlrDes: TEdit;
    Label35: TLabel;
    ObsInt: TMemo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure fecharClick(Sender: TObject);
    procedure DataExit(Sender: TObject);
    procedure DataKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Ped_CODCLIChange(Sender: TObject);
    procedure Ped_CODCLIExit(Sender: TObject);
    procedure Ped_CODCLIKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CODPAGChange(Sender: TObject);
    procedure CODPAGExit(Sender: TObject);
    procedure CODPAGKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CODTRSChange(Sender: TObject);
    procedure CODTRSExit(Sender: TObject);
    procedure CODTRSKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CODVENChange(Sender: TObject);
    procedure CODVENExit(Sender: TObject);
    procedure CODVENKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure VlrFreteEnter(Sender: TObject);
    procedure VlrFreteExit(Sender: TObject);
    procedure VlrFreteKeyPress(Sender: TObject; var Key: Char);
    procedure CODPROExit(Sender: TObject);
    procedure CODPROKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CODALXExit(Sender: TObject);
    procedure CODALXKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CODTABExit(Sender: TObject);
    procedure CODTABKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure VlrUntEnter(Sender: TObject);
    procedure VlrUntExit(Sender: TObject);
    procedure VlrUntKeyPress(Sender: TObject; var Key: Char);
    procedure QtdeEnter(Sender: TObject);
    procedure QtdeKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure TpoFreteClick(Sender: TObject);
    procedure btConfItemClick(Sender: TObject);
    procedure btExcItemClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure AlertasItem(Tipo: String);
    procedure VisualizarClick(Sender: TObject; Button: TNavigateBtn);
    procedure TotalOrcEnter(Sender: TObject);
    procedure TotalOrcKeyPress(Sender: TObject; var Key: Char);
    procedure NATOPRKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CodTnaExit(Sender: TObject);
    procedure CodTnaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CODOPRExit(Sender: TObject);
    procedure ObsEnter(Sender: TObject);
    procedure ObsExit(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure CodTnaChange(Sender: TObject);
    procedure NATOPRExit(Sender: TObject);
    procedure CODOPRChange(Sender: TObject);
    function TestaDoacao: Boolean;
    procedure btnDadosCliClick(Sender: TObject);
    procedure VlrUntKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CODTABEnter(Sender: TObject);
    procedure PercDescExit(Sender: TObject);
    procedure VlrDescExit(Sender: TObject);
    procedure QtdeExit(Sender: TObject);
    procedure btGravarClick(Sender: TObject);
  private
    { Private declarations }
    obValoresTrib: TCarregarValoresTrib;

    TemNCMxTrib, AltPreco, PodeConfirmarItem, SubIrf: Boolean;
    CrdIcm, PrRetPis, PrRetCof, PrRetIrf, PrRetCsl, PrPis, PrCof, PrSufIcm, PrSufPis, PrSufCof, PrSufIpi, PrIssLin, PrInsLin, PrIrfLin, RedIssLin, RedInsLin: Real;
    TrbNCM, UFEmp, CodServico, SepAcr, SepDes, SmpNac, ConIpi, RetIssLin, RetPisLin: String;

    procedure CriaTemp;
    procedure DefaultItem;
    procedure LimpaItens;
    procedure DefaultOrcamento;
    procedure RecalcItend(var TotalProdutos, TotalServicos, TotalProdComICMS, TotalProdComPis, TotalProdComCof, TotalFaturar: Currency; var GeraFinGeral: Boolean);

    procedure Gravar;
    procedure ExcluiItens(AId: Integer);
    procedure GravaItens;
    procedure MostraItens(AId: Integer);

    procedure AtualizaItens;
    function PesqPreco(CODPRO, CODTAB: String): Boolean;
    function VerificaTributacao(ExigeTribCorreta: Boolean): Boolean;
    function BuscaRedBase(NATOPR, CodProduto: String): Real;
    function TotLinhasObs(Obs: String): Integer;
    procedure TributacaoNCM(CodigoProduto: String);
    function BuscaContatoComp(CodCli: String): String;
    // Function CadastroAtualizado(UltAtu: TDate):Boolean;
    // function AvisaCliIncompleto: Boolean;
    procedure CarregaContatos;
    procedure PesquisaProduto(Codigo, ComDescri: String);
    function JaTemPro(CODPRO: String): Boolean;
    procedure VerificarCodTna(deOnde: String);
    procedure VerificarNatOpr(deOnde: String);
    procedure VlrLiqConfere;
    Function InfValorServico: Boolean;
    function PesquisaCodigoBalanca(Codigo, ComDescri: String): Boolean;
    function PesquisaCodigoInterno(Codigo: String): Boolean;
    function PesquisaCodigoBarras(Codigo: String): Boolean;
    function BuscaTabela(TabAtu, CODPRO: String): String;
    procedure VerNatTransferencia(natMaisOpr: String);
    procedure AtualizarTrib(TotalProdutos, TotalServicos, TotalProdComICMS, TotalProdComPis, TotalProdComCof, TotalFaturar: Currency; GeraFinGeral: Boolean);
    function GeraFaturamento(lCodNat, lCodVar: String): Boolean;
    procedure CarregarConfTributos;
    procedure AtualizarTotal(TotalProdutos: Real);
    Function PrecoPro_Tab(CODPRO, CODTAB: String): Currency;
    procedure BloqueiaDescontos(MP1, MP2, MP3, MP4, MP5, MP6, Valor: Currency; Produto, Tipo: String);
    procedure VerificaDescontos;
    procedure VerificaDescontosItem;
    function TemFinanceiroGeral: Boolean;
    procedure ValidarGravacao;
  public
    { Public declarations }
    PriDes, PedDesc: String;
    P1, P2, P3, P4: Currency;
    DescontoLiberado: Boolean;
    VKDesconto_Orcam: Real;

    obItemPedidoWeb: TWtpedidoitem;
    obPedidoWeb: TWtpedido;
    obAlmoxarifado: TAlmoxarifado;
    obClientes: TClientes;
    obFormaPag: TFormapgnto;
    obTabela: TTabelaprecos;
    obTransportadora: TTransportadoras;
    obVendedor: TVendedores;
    obProduto: TProdutos;
    obPrecos: TPrecos;
    obNatureza: TNaturezaopr;
    obCidade: TCidades;
    obCadindex: TCadindex;
    obCadaTna: TCadatna;
    obProxCst: TProxcst;
    obCliInadim: TCliInadim;
    obFabricantes: TFabricantes;
    obGrupoPro: TGrupopro;

    procedure Mostra;
    procedure ValoresDefault;
  end;

var
  F_Pedidos1: TF_Pedidos1;
  NroIte, Tabela, CodProAnt, BloCli, BloInc, NomeCap, TpoComi, CliIna, RevBlo, FatInc, BCESIT: String;
  F4Cli, F4Pro, F4Cta, F4Cct, F4Esto, RPTPRO, ORCAUT, PesPro, CNPJEmp, CrgAlx, CONSRV: String;
  SerNf_DEV, NumNF_DEV, CFOP_Doacao, TABDOA, AltVlr, InicioPro, VlrTrf, CFOP_Transferencia: String;
  QtdeAnt, SaldoAnt, VlrUntAnt: Real;
  VlrUntIndex, DescIcms, VlrOrig: Currency;
  RevCli, Decimais, DecPro: Integer;
  IncCliente, AltCliente: Boolean;

implementation

uses
  U_Sisproc, U_T2, consulta, Math, Transacao, U_TribNCm, U_IdentifUsr, U_ServicoPro, U_CriaListaCFOP,
  U_Clientes1, U_CarregarTributacao, U_DescInvalido, U_SenhaDesconto, Conexao, U_UteisOrc, U_AcessoBaseCentral,
  U_Tributacao, U_ConverteMoeda, U_UteisServico;

{$R *.DFM}

procedure TF_Pedidos1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  obCidade.Free;
  obPrecos.Free;
  obAlmoxarifado.Free;
  obClientes.Free;
  obFormaPag.Free;
  obTabela.Free;
  obTransportadora.Free;
  obVendedor.Free;
  obProduto.Free;
  obNatureza.Free;
  obCadindex.Free;
  obCadaTna.Free;
  obProxCst.Free;
  obCliInadim.Free;
  obValoresTrib.Free;
  obFabricantes.Free;
  obGrupoPro.Free;

  if T2.cdsgWtpedido.Active then
    T2.cdsgWtpedido.Refresh;

  Action := Cafree;
  F_Pedidos1 := nil;
end;

procedure TF_Pedidos1.FormKeyPress(Sender: TObject; var Key: Char);
begin
  NextControl(self, Key);
end;

procedure TF_Pedidos1.fecharClick(Sender: TObject);
begin
  Close;
end;

procedure TF_Pedidos1.DataExit(Sender: TObject);
begin
  if Trim((Sender as TMaskEdit).Text) = '/  /' then
    Exit;

  if not VerData((Sender as TMaskEdit).Text) then
  begin
    (Sender as TMaskEdit).SetFocus;
    Exit;
  end;
  (Sender as TMaskEdit).Text := FormatDateTime('dd/mm/yyyy', StrToDateTime((Sender as TMaskEdit).Text));
end;

procedure TF_Pedidos1.DataKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 72 then
    (Sender as TMaskEdit).Text := FormatDateTime('dd/mm/yyyy', Date); { 72 = H = Hoje }
end;

procedure TF_Pedidos1.Ped_CODCLIChange(Sender: TObject);
begin
  NomeCli.Clear;

  // Controla botao do cliente
  if (IncCliente) and ((Caption = 'Incluir') or (Caption = 'Manutenção')) then
  begin
    btnDadosCli.Enabled := True;
    btnDadosCli.Hint := 'Incluir Cliente';
  end
  else
  begin
    btnDadosCli.Enabled := False;
    btnDadosCli.Hint := '';
  end;

  if Length(Trim((Sender as TEdit).Text)) < 6 then
    Exit;

  if Caption = 'Incluir' then
  begin
    NomeCli.TabStop := Ped_CODCLI.Text = '000000';
    NomeCli.ReadOnly := not(Ped_CODCLI.Text = '000000');
  end;

  obClientes.setCli_codigo(Trim((Sender as TEdit).Text));
  if obClientes.Consultar then
  begin
    if (AltCliente) and ((Caption = 'Incluir') or (Caption = 'Manutenção')) then
      btnDadosCli.Hint := 'Ver/Alterar Dados do Cliente'
    else
      btnDadosCli.Hint := 'Ver Dados do Cliente';

    NomeCli.Text := Copy(obClientes.getCli_nome, 1, NomeCli.MaxLength);
    // tem casos em que o cadastro do cliente tem o tamanho maior que cabe no pedido

    CarregaContatos;
  end;
end;

procedure TF_Pedidos1.Ped_CODCLIExit(Sender: TObject);
var
  IDCli: String;
  TemBloqueio: Boolean;
begin
  Ped_CODCLI.Text := StrZero(Ped_CODCLI.Text, 6);

  obClientes.setCli_codigo(Trim((Sender as TEdit).Text));
  if not obClientes.Consultar then
  begin
    (Sender as TEdit).SetFocus;
    (Sender as TEdit).SelectAll;
    Raise Exception.Create('Cliente não Cadastrado!');
  end;

  if Trim(obClientes.getCli_msgven) <> '' then
    DL_Msg(Trim(obClientes.getCli_msgven), 'Observação do Cliente', 'AVISO');

  NomeCli.Text := Copy(obClientes.getCli_nome, 1, NomeCli.MaxLength);
  // tem casos em que o cadastro do cliente tem o tamanho maior que cabe no pedido

  if Caption = 'Incluir' then
    Contato.Text := Copy(BuscaContatoComp(obClientes.getCli_codigo), 1, 30);

  Fone.Text := obClientes.getCli_dddfon + '-' + obClientes.getCli_fone;
  Ender.Text := obClientes.getCli_end + ', ' + obClientes.getCli_nroend;
  uf.Text := obClientes.getCli_uf;

  if obClientes.getCli_tipo = '2' then
    Tipo.Caption := 'PESSOA FÍSICA'
  else
    Tipo.Caption := 'PESSOA JURÍDICA';

  if obClientes.getCli_Public = 'S' then
  begin
    Tipo.Caption := 'ORGÃO PÚBLICO';
  end;

  obCidade.setMun_codigo(obClientes.getCli_codcid);
  if obCidade.Consultar then
    Cidade.Text := obCidade.getMun_descri;

  if Caption <> 'Incluir' then
    Exit;

  if Trim(obClientes.getCli_codtrs) <> '' then
  begin
    CODTRS.Text := obClientes.getCli_codtrs;
    CODTRS.Modified := True;
  end;

  if Trim(obClientes.getCli_frete) > '0' then
    Frete.ItemIndex := StrToInt(obClientes.getCli_frete) - 1;

  if Trim(obClientes.getCli_codtab) <> '' then
  begin
    CODTAB.Text := obClientes.getCli_codtab;
    CODTAB.Modified := True;
  end;

  if Trim(obClientes.getCli_codpag) <> '' then
  begin
    CODPAG.Text := obClientes.getCli_codpag;
    CODPAG.Modified := True;
  end;

  if Trim(obClientes.getCli_obsped) <> '' then
    Obs.Text := obClientes.getCli_obsped;

  NomeCli.TabStop := Ped_CODCLI.Text = '000000';
  NomeCli.ReadOnly := not(Ped_CODCLI.Text = '000000');

  // teste para ver se dever fazer pesquisa situação do cliente na bse centralizada.
  if BCESIT = 'S' then
  begin
    VerSitCliBaseCentral(obClientes.getCli_cgccpf, TemBloqueio, IDCli);
    if TemBloqueio then
    begin
      DL_Msg('Cliente com bloqueio na base central. Não pode ser feita a venda.', 'Atenção', 'Aviso');
      Ped_CODCLI.SelectAll;
      Ped_CODCLI.SetFocus;
    end;
  end;

  if Trim(obClientes.getCli_codven) <> '' then
  begin
    CODVEN.Text := obClientes.getCli_codven;
    CODVEN.Modified := True;
    CODVENExit(CODVEN);
  end;

  P4 := obClientes.getCli_prdesc;
end;

procedure TF_Pedidos1.Ped_CODCLIKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Q: String;
  ConsultaOk: Boolean;
begin
  if (Caption <> 'Incluir') and (Caption <> 'Manutenção') then
    Exit;

  if Key = VK_F4 then
  begin
    Q := 'Select CLI_CODIGO Codigo, CLI_NOME Nome, CLI_FANTAS Nome_Fantasia, CLI_CGCCPF CNPJ_CPF, ';
    Q := Q + #10#13 + 'Cli_End Endereco, CLI_NROEND Nro, CLI_BAIRRO Bairro, CLI_UF UF, CLI_CEP CEP, CLI_DDDFON DDD,';
    Q := Q + #10#13 + 'CLI_FONE Fone, CLI_INSEST Inscricao';
    Q := Q + #10#13 + 'From ScraCli';

    ConsultaOk := False;

    if CliIna = 'N' then
      Q := Q + #10#13 + 'where Cli_Sit <> ''2'' and Cli_Sit <> ''3''';

    if F4Cli = 'CODIGO' then
      if BuscaCfg2(T2.qC1, 'SepeCFG', 'CFG_F4FCLI', 'Desativar filtro na pesquisa de clientes com F4', 'N', 1, 1) = 'S' then
        ConsultaOk := ConsultaDl(T2.WsepeDBX, Q, 'Codigo', 'Consulta de Clientes')
      else
        ConsultaOk := ConsultaDl(T2.WsepeDBX, Q, 'Codigo', 'CLI_CODIGO', 'Consulta de Clientes', 'Codigo', True);

    if F4Cli = 'NOME' then
      if BuscaCfg2(T2.qC1, 'SepeCFG', 'CFG_F4FCLI', 'Desativar filtro na pesquisa de clientes com F4', 'N', 1, 1) = 'S' then
        ConsultaOk := ConsultaDl(T2.WsepeDBX, Q, 'Nome', 'Consulta de Clientes')
      else
        ConsultaOk := ConsultaDl(T2.WsepeDBX, Q, 'Nome', 'CLI_NOME', 'Consulta de Clientes', 'Nome', True);

    if F4Cli = 'FANTASIA' then
      if BuscaCfg2(T2.qC1, 'SepeCFG', 'CFG_F4FCLI', 'Desativar filtro na pesquisa de clientes com F4', 'N', 1, 1) = 'S' then
        ConsultaOk := ConsultaDl(T2.WsepeDBX, Q, 'Nome_Fantasia', 'Consulta de Clientes')
      else
        ConsultaOk := ConsultaDl(T2.WsepeDBX, Q, 'Nome_Fantasia', 'CLI_FANTAS', 'Consulta de Clientes', 'Nome_Fantasia', True);

    if F4Cli = 'FONE' then
      if BuscaCfg2(T2.qC1, 'SepeCFG', 'CFG_F4FCLI', 'Desativar filtro na pesquisa de clientes com F4', 'N', 1, 1) = 'S' then
        ConsultaOk := ConsultaDl(T2.WsepeDBX, Q, 'Fone', 'Consulta de Clientes')
      else
        ConsultaOk := ConsultaDl(T2.WsepeDBX, Q, 'Fone', 'CLI_FONE', 'Consulta de Clientes', 'Fone', True);

    if ConsultaOk then
    begin
      (Sender as TEdit).Text := consulta.getValor('Codigo');
      NomeCli.Text := Copy(consulta.getValor('Nome'), 1, NomeCli.MaxLength);
      // tem casos em que o cadastro do cliente tem o tamanho maior que cabe no pedido
    end;
  end;
end;

procedure TF_Pedidos1.PercDescExit(Sender: TObject);
begin
  // se não alterou o valor do desconto
  // e se nao alterou o valor unitario sai fora do teste
  if not(PercDesc.Modified or VlrUnt.Modified) then
    Exit;

  // se alterou o % do desconto zera o valor do desconto e recalcula o novo valor
  VlrDesc.Text := '0,00';

  if VlrOrig <= 0 then
    VlrOrig := Val(VlrUnt.Text);

  if Val(Trim(PercDesc.Text)) > 100 then
  begin
    PercDesc.SetFocus;
    PercDesc.SelectAll;
    Raise Exception.Create('O valor máximo para este campo é de 100%!!');
  end;

  if Val(PercDesc.Text) <> 0 then
    VlrDesc.Text := str((Val(PercDesc.Text) * VlrOrig) / 100, Decimais);

  VlrUnt.Text := str(VlrOrig - Val(VlrDesc.Text), Decimais);
  VlrTot.Text := str(Val(VlrUnt.Text) * Val(Qtde.Text), Decimais);
end;

procedure TF_Pedidos1.CODPAGChange(Sender: TObject);
begin
  (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Clear;
  if Length(Trim((Sender as TEdit).Text)) < 3 then
    Exit;

  obFormaPag.setPgnf_cod(Trim((Sender as TEdit).Text));
  if obFormaPag.Consultar then
  begin
    (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Text := obFormaPag.getPgnf_cond;
    P2 := obFormaPag.getPgnf_desco;
  end
  else
  begin
    (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Clear;
    P2 := 0;
  end;

end;

procedure TF_Pedidos1.CODPAGExit(Sender: TObject);
begin
  if Trim((Sender as TEdit).Text) = '' then
    Exit;

  obFormaPag.setPgnf_cod(Trim((Sender as TEdit).Text));
  if not obFormaPag.Consultar then
  begin
    (Sender as TEdit).SetFocus;
    (Sender as TEdit).SelectAll;
    Raise Exception.Create('Forma de Pagamento não Cadastrado!');
  end
  else
    (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Text := obFormaPag.getPgnf_cond;
end;

procedure TF_Pedidos1.CODPAGKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Q: String;
begin
  if (Caption = 'Ver') or (Caption = 'Excluir') then
    Exit;

  if Key = VK_F4 then
  begin
    Q := 'Select PGNF_COD Codigo, PGNF_DESCR Descricao, PGNF_COND Condicao';
    Q := Q + #10#13 + 'From SCRAPGNF';
    Q := Q + #10#13 + 'Where PGNF_ATIVO <> ''N''';
    If ConsultaDl(T2.WsepeDBX, Q, 'Condicao', 'Localiza Forma de Pagamento') Then
    begin
      (Sender as TEdit).Text := consulta.getValor('Codigo');
      (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Text := consulta.getValor('Condicao');
    end;
  end;
end;

procedure TF_Pedidos1.CODTRSChange(Sender: TObject);
begin
  (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Clear;
  if Length(Trim((Sender as TEdit).Text)) < 5 then
    Exit;

  obTransportadora.setTrs_codigo(Trim((Sender as TEdit).Text));
  if obTransportadora.Consultar then
    (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Text := obTransportadora.getTrs_nome
  else
    (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Clear;
end;

procedure TF_Pedidos1.CODTRSExit(Sender: TObject);
begin
  if Trim((Sender as TEdit).Text) = '' then
    Exit;

  (Sender as TEdit).Text := StrZero((Sender as TEdit).Text, 5);

  obTransportadora.setTrs_codigo(Trim((Sender as TEdit).Text));
  if not obTransportadora.Consultar then
  begin
    (Sender as TEdit).SetFocus;
    (Sender as TEdit).SelectAll;
    Raise Exception.Create('Transportadora não Cadastrado!');
  end
  else
    (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Text := obTransportadora.getTrs_nome;
end;

procedure TF_Pedidos1.CODTRSKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Q: String;
begin
  if (Caption = 'Ver') or (Caption = 'Excluir') then
    Exit;

  if Key = VK_F4 then
  begin
    Q := 'Select TRS_CODIGO Codigo, TRS_NOME Nome';
    Q := Q + #10#13 + 'From SCRATRS';
    If ConsultaDl(T2.WsepeDBX, Q, 'Nome', 'Localiza Transportadoras') Then
    begin
      (Sender as TEdit).Text := consulta.getValor('Codigo');
      (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Text := consulta.getValor('Nome');
    end;
  end;
end;

procedure TF_Pedidos1.CODVENChange(Sender: TObject);
begin
  (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Clear;
  if Length(Trim((Sender as TEdit).Text)) < 5 then
    Exit;

  obVendedor.setFun_codigo(Trim((Sender as TEdit).Text));
  if obVendedor.Consultar then
    (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Text := obVendedor.getFun_nome
  else
    (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Clear;
end;

procedure TF_Pedidos1.CODVENExit(Sender: TObject);
begin
  if Trim((Sender as TEdit).Text) = '' then
    Exit;

  (Sender as TEdit).Text := StrZero((Sender as TEdit).Text, 5);

  obVendedor.setFun_codigo(Trim((Sender as TEdit).Text));
  if not obVendedor.Consultar then
  begin
    (Sender as TEdit).SetFocus;
    (Sender as TEdit).SelectAll;
    Raise Exception.Create('Vendedor não Cadastrado!');
  end
  else
  begin
    (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Text := obVendedor.getFun_nome;

    if (Caption = 'Incluir') or (Caption = 'Manutenção') then
      if obVendedor.getFun_ativo <> 'S' then
      begin
        (Sender as TEdit).SetFocus;
        (Sender as TEdit).SelectAll;
        Raise Exception.Create('Vendedor Inativo!');
      end;
  end;
end;

procedure TF_Pedidos1.CODVENKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Q: String;
begin
  if (Caption = 'Ver') or (Caption = 'Excluir') then
    Exit;

  if Key = VK_F4 then
  begin
    Q := 'Select FUN_CODIGO Codigo, FUN_NOME Nome';
    Q := Q + #10#13 + 'From VenaFun';
    Q := Q + #10#13 + 'Where FUN_ATIVO = ''S''';
    if ConsultaDl(T2.WsepeDBX, Q, 'Nome', 'Localiza Vendedores') Then
    begin
      (Sender as TEdit).Text := consulta.getValor('Codigo');
      (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Text := consulta.getValor('Nome');
    end;
  end;
end;

procedure TF_Pedidos1.VlrDescExit(Sender: TObject);
var
  Vlr: Real;
begin
  // se não alterou o valor do desconto sai fora
  if not VlrDesc.Modified then
    Exit;

  // se alerou o valor do desconto zera o % de desconto e recalcula o novo % de desconto
  PercDesc.Text := '0,00';

  Vlr := Val(VlrUnt.Text);

  if VlrOrig > 0 then
    Vlr := VlrOrig;

  if (Val(VlrDesc.Text) <> 0) and (Vlr <> 0) then
    PercDesc.Text := str(100 - ((Vlr - Nvl(VlrDesc.Text)) * 100) / VlrOrig, Decimais);

  VlrUnt.Text := str(Vlr - Val(VlrDesc.Text), Decimais);
  VlrTot.Text := str(Val(VlrUnt.Text) * Val(Qtde.Text), Decimais);
end;

procedure TF_Pedidos1.VlrFreteEnter(Sender: TObject);
begin
  (Sender as TEdit).Text := Trim((Sender as TEdit).Text);
  (Sender as TEdit).SelectAll;
end;

procedure TF_Pedidos1.VlrFreteExit(Sender: TObject);
var
  TotalProdutos, TotalServicos, TotalProdComICMS, TotalProdComPis, TotalProdComCof, TotalFaturar: Currency;
  GeraFinGeral: Boolean;
begin
  (Sender as TEdit).Text := Str(Nvl((Sender as TEdit).Text), Decimais);
  RecalcItend(TotalProdutos, TotalServicos, TotalProdComICMS, TotalProdComPis, TotalProdComCof, TotalFaturar, GeraFinGeral);
  AtualizarTrib(TotalProdutos, TotalServicos, TotalProdComICMS, TotalProdComPis, TotalProdComCof, TotalFaturar, GeraFinGeral);
end;

procedure TF_Pedidos1.VlrFreteKeyPress(Sender: TObject; var Key: Char);
begin
  Key := SoValor((Sender as TEdit), Key, 2);
end;

procedure TF_Pedidos1.CODPROExit(Sender: TObject);
var
  codp: String;
begin
  AltPreco := False;

  if Trim(CODPRO.Text) = '' then
    Exit;

  if not CODPRO.Modified then
    Exit;

  CODPROD.Text := '';
  CodServico := '';
  AltPreco := False;

  codp := Trim(CODPRO.Text);

  PesquisaProduto(Trim(CODPRO.Text), 'S');

  if RPTPRO <> 'S' then
    if JaTemPro(CODPRO.Text) then
    begin
      CODPRO.SetFocus;
      Raise Exception.Create('Este código já foi utilizado neste pedido.');
    end;

  // pega desconto obrigatório de acordo com a aliquota de ICMS
  DescIcms := BuscaICMS(NATOPR.Text, CODOPR.Text, CODPRO.Text, obClientes, obProduto, True);

  // se tem codigo de operação e natureza preeenchidos
  // executa o exit de cada uma para fazer as validações e carregar a tributação
  if (CodTna.Text <> '') then
  begin
    VerificarCodTna('produto');

    if (NATOPR.Text <> '') and (CODOPR.Text <> '') then
      VerificarNatOpr('exit');
    // CodOprExit(Self);
  end;

  VlrLiqConfere;
  btConfItem.Enabled := True;

  if ORCAUT = 'S' then
    btConfItem.Click;
end;

procedure TF_Pedidos1.CODPROKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Q: String;
  ConsultaOk: Boolean;
begin
  if (Caption <> 'Incluir') and (Caption <> 'Manutenção') then
    Exit;

  if Key = VK_F4 then
  begin
    Q := 'Select PRO_CODIGO Codigo, PRO_DESCRI Descricao, PRO_CODORG Cod_Original, PRO_CODBAR Barras ';

    if Trim(F4Esto) = 'S' then
      Q := Q + #10#13 + ',ALX_CODALX ALX,ALX_QUANT SALDO';

    Q := Q + #10#13 + 'From ESTAPRO P';

    if Trim(F4Esto) = 'S' then
      Q := Q + #10#13 + 'LEFT JOIN ECMAALX ON (ALX_CODPRO = P.PRO_CODIGO)';

    Q := Q + #10#13 + 'Where PRO_ATIVO = ''S''';

    ConsultaOk := False;

    if F4Pro = 'DESCRICAO' then
      if BuscaCfg2(T2.qC1, 'SepeCFG', 'CFG_F4FPRO', 'Desativar filtro na pesquisa de produtos com F4', 'N', 1, 1) = 'S' then
        ConsultaOk := ConsultaDl(T2.WsepeDBX, Q, 'Descricao', 'Consulta de Produtos')
      else
        ConsultaOk := ConsultaDl(T2.WsepeDBX, Q, 'Descricao', 'PRO_DESCRI', 'Consulta de Produtos', 'Descricao', True);

    if F4Pro = 'CODIGO' then
      if BuscaCfg2(T2.qC1, 'SepeCFG', 'CFG_F4FPRO', 'Desativar filtro na pesquisa de produtos com F4', 'N', 1, 1) = 'S' then
        ConsultaOk := ConsultaDl(T2.WsepeDBX, Q, 'Codigo', 'Consulta de Produtos')
      else
        ConsultaOk := ConsultaDl(T2.WsepeDBX, Q, 'Codigo', 'PRO_CODIGO', 'Consulta de Produtos', 'Codigo', True);

    if F4Pro = 'BARRAS' then
      if BuscaCfg2(T2.qC1, 'SepeCFG', 'CFG_F4FPRO', 'Desativar filtro na pesquisa de produtos com F4', 'N', 1, 1) = 'S' then
        ConsultaOk := ConsultaDl(T2.WsepeDBX, Q, 'Barras', 'Consulta de Produtos')
      else
        ConsultaOk := ConsultaDl(T2.WsepeDBX, Q, 'Barras', 'PRO_CODBAR', 'Consulta de Produtos', 'Barras', True);

    if F4Pro = 'ORIGINAL' then
      if BuscaCfg2(T2.qC1, 'SepeCFG', 'CFG_F4FPRO', 'Desativar filtro na pesquisa de produtos com F4', 'N', 1, 1) = 'S' then
        ConsultaOk := ConsultaDl(T2.WsepeDBX, Q, 'Cod_Original', 'Consulta de Produtos')
      else
        ConsultaOk := ConsultaDl(T2.WsepeDBX, Q, 'Cod_Original', 'PRO_CODORG', 'Consulta de Produtos', 'Cod_Original', True);

    if ConsultaOk then
    begin
      (Sender as TEdit).Text := Nst(consulta.getValor('Codigo'));
      (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Text := Nst(consulta.getValor('Descricao'));

      // pesquisa preco pelo codigo do produto e tabela
      PesqPreco(consulta.getValor('Codigo'), CODTAB.Text);
      (Sender as TEdit).Modified := True;
    end;
  end;
end;

procedure TF_Pedidos1.CODALXExit(Sender: TObject);
begin
  if Trim((Sender as TEdit).Text) = '' then
    Exit;

  obAlmoxarifado.setEst_codigo(Trim((Sender as TEdit).Text));
  if not obAlmoxarifado.Consultar then
  begin
    (Sender as TEdit).SetFocus;
    (Sender as TEdit).SelectAll;
    Raise Exception.Create('Almoxarifado não Cadastrado!');
  end;
end;

procedure TF_Pedidos1.CODALXKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Q: String;
begin
  if (Caption = 'Ver') or (Caption = 'Excluir') then
    Exit;

  if Key = VK_F4 then
  begin
    Q := 'Select EST_CODIGO Codigo, EST_ENDER Descricao';
    Q := Q + #10#13 + 'From ESTAEST';

    if ConsultaDl(T2.WsepeDBX, Q, 'Descricao', 'Localiza Almoxarifado') Then
    begin
      (Sender as TEdit).Text := consulta.getValor('Codigo');
      (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Text := consulta.getValor('Descricao');
    end;
  end;
end;

function TF_Pedidos1.PesqPreco(CODPRO, CODTAB: String): Boolean;
var
  Vtot: Currency;
  ValorIndMoeda: Real;
begin
  Result := False;
  VlrOrig := 0;

  obPrecos.setTab_codpro(CODPRO);
  obPrecos.setTab_nro(CODTAB);

  if obPrecos.Consultar then
  begin

    obTabela.setTbc_codigo(CODTAB);
    obTabela.Consultar;

    if Nst(obTabela.getTbc_codind) <> '' then
    begin
      obCadindex.setCad_codind(Nst(obTabela.getTbc_codind));
      obCadindex.Consultar;

      if obCadindex.getCad_indper = 'S' then
      begin
        ValorIndMoeda := TotalIndice(obCadindex, Date, Date, Nvl(obPrecos.getTab_preco));

        if (ValorIndMoeda <= 0) then
          Exit;

        VlrUntIndex := ValorIndMoeda;
      end
      else
      begin
        ValorIndMoeda := BuscaValorMoeda(Nst(obTabela.getTbc_codind), Date);

        if (ValorIndMoeda <= 0) then
          Exit;

        VlrUntIndex := Nvl(obPrecos.getTab_preco) * ValorIndMoeda;
      end;
    end
    else
      VlrUntIndex := Nvl(obPrecos.getTab_preco);

    Vtot := Val(Trim(Qtde.Text)) * VlrUntIndex;
    VlrUnt.Text := str(VlrUntIndex, Decimais);
    VlrTot.Text := str(Vtot, Decimais);
    VlrOrig := VlrUntIndex;

    AlinharDireitaValor(VlrUnt);
    AlinharDireitaValor(VlrTot);

    Result := True;
  end;
end;

procedure TF_Pedidos1.CODTABEnter(Sender: TObject);
begin
  VlrOrig := 0;
end;

procedure TF_Pedidos1.CODTABExit(Sender: TObject);
begin
  if Trim((Sender as TEdit).Text) = '' then
    Exit;

  obTabela.setTbc_codigo(Trim((Sender as TEdit).Text));
  if not obTabela.Consultar then
  begin
    (Sender as TEdit).SetFocus;
    (Sender as TEdit).SelectAll;
    Raise Exception.Create('Tabela não Cadastrado!');
  end
  else
  begin

    if not PesqPreco(Trim(CODPRO.Text), Trim(CODTAB.Text)) then
    begin
      obPrecos.setTab_codpro(CODPRO.Text);
      obPrecos.setTab_nro(CODTAB.Text);

      if obPrecos.Consultar then
        VlrUnt.Text := str(obPrecos.getTab_preco, Decimais);
      VlrOrig := obPrecos.getTab_preco;
    end
    else
      VlrOrig := obPrecos.getTab_preco;

    P3 := obPrecos.getTab_desmax;

  end;
  if (obTabela.getTbc_inival <> 0) and (obTabela.getTbc_fimval <> 0) then
    if (StrToDate(Data.Text) < obTabela.getTbc_inival) or (StrToDate(Data.Text) > obTabela.getTbc_fimval) then
    begin
      CODTAB.SetFocus;
      CODTAB.SelectAll;
      Raise Exception.Create('Tabela de preços fora da validade.');
    end;

  if obTabela.getTbc_tptab = '3' then
  begin
    (Sender as TEdit).SetFocus;
    (Sender as TEdit).SelectAll;
    Raise Exception.Create('Tabela de Preços não permitida!');
  end;
end;

procedure TF_Pedidos1.CODTABKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Q: String;
begin
  if (Caption = 'Ver') or (Caption = 'Excluir') then
    Exit;

  if Key = VK_F4 then
  begin
    Q := 'Select TBC_CODIGO Codigo, TBC_DESCRI Descricao';
    Q := Q + #10#13 + 'From VENATBC';
    Q := Q + #10#13 + 'where TBC_TPTAB <> 3';

    If ConsultaDl(T2.WsepeDBX, Q, 'Descricao', 'Localiza Tabela') Then
    begin
      (Sender as TEdit).Text := consulta.getValor('Codigo');
      (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Text := consulta.getValor('Descricao');
    end;
  end;
end;

procedure TF_Pedidos1.CodTnaChange(Sender: TObject);
begin
  if Length(Trim(CodTna.Text)) < 3 then
    Exit;

  CodTnaD.Clear;
  obCadaTna.setTna_Codigo(CodTna.Text);
  if obCadaTna.Consultar then
    CodTnaD.Text := Nst(obCadaTna.getTna_descri)
  else
    CodTnaD.Clear;
end;

procedure TF_Pedidos1.CodTnaExit(Sender: TObject);
begin
  if CodTna.Text <> '' then
    CodTna.Text := StrZero(CodTna.Text, 3);

  VerificarCodTna('exit');
end;

procedure TF_Pedidos1.CodTnaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Q: String;
begin
  if Key = VK_F4 then
  begin
    Q := 'Select TNA_CODIGO Codigo, TNA_DESCRI Descricao';
    Q := Q + #13 + 'From CadaTna';
    Q := Q + #13 + 'Where TNA_OPRES = ''S''';

    if ConsultaDl(T2.WsepeDBX, Q, 'Descricao', 'Consulta de Operações') then
    begin
      (Sender as TEdit).Text := consulta.getValor('Codigo');
      (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Text := consulta.getValor('Descricao');
    end;
  end;
end;

procedure TF_Pedidos1.VlrUntEnter(Sender: TObject);
begin
  (Sender as TEdit).Text := Trim((Sender as TEdit).Text);
  (Sender as TEdit).SelectAll;
end;

procedure TF_Pedidos1.VlrUntExit(Sender: TObject);
var
  Dif: Currency;
begin
  AlinharDireitaValor((Sender as TEdit));

  if Val(VlrUnt.Text) < VlrOrig then // calcula desconto
  begin
    Dif := VlrOrig - Val(VlrUnt.Text);
    VlrDesc.Text := str(Dif, 4);

    Dif := 100 - ((Val(VlrUnt.Text) * 100) / VlrOrig);
    PercDesc.Text := CurrToStr(Dif);
  end;

  if Val(VlrUnt.Text) = VlrOrig then // zera acréscimo e descontos
  begin
    VlrDesc.Text := '0,00';
    PercDesc.Text := '0,00';
  end;

  VlrTot.Text := str(Val(VlrUnt.Text) * Val(Qtde.Text), Decimais);
end;

procedure TF_Pedidos1.VlrUntKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Q: String;

begin
  if (Caption <> 'Incluir') and (Caption <> 'Manutenção') then
    Exit;

  if Key = VK_F4 then
  begin
    Q := 'Select first 30 PED_NRO Pedido, PED_DATA Data, IPD_VLRUNT Valor, IPD_CODPRO Codigo, IPD_DESCRI Descricao ';
    Q := Q + #10#13 + 'From VENAPED, VENAIPD';
    Q := Q + #10#13 + 'Where PED_NRO    = IPD_NRO';
    Q := Q + #10#13 + 'and   COALESCE(PED_LIBER,'''') <> ''C''';
    Q := Q + #10#13 + 'and   PED_CODCLI = ' + #39 + Ped_CODCLI.Text + #39;
    Q := Q + #10#13 + 'and   IPD_CODPRO = ' + #39 + CODPRO.Text + #39;
    Q := Q + #10#13 + 'order by PED_DATA desc';

    if ConsultaDl(T2.WsepeDBX, Q, '', 'Últimas compras do cliente, deste produto (maximo 30)') Then
    begin
      VlrUnt.Text := consulta.getValor('Valor');
      VlrUnt.Modified := True;
    end;
  end;
end;

procedure TF_Pedidos1.VlrUntKeyPress(Sender: TObject; var Key: Char);
begin
  Key := SoValor((Sender as TEdit), Key);
end;

procedure TF_Pedidos1.QtdeEnter(Sender: TObject);
begin
  (Sender as TEdit).Text := Trim((Sender as TEdit).Text);
  (Sender as TEdit).SelectAll;
end;

procedure TF_Pedidos1.QtdeExit(Sender: TObject);
begin
  AlinharDireitaValor((Sender as TEdit));
  // if not PesqPreco(Trim(CodPro.Text), Trim(CodTab.Text))then
  VlrTot.Text := str(Val(VlrUnt.Text) * Val(Qtde.Text), Decimais);
end;

procedure TF_Pedidos1.QtdeKeyPress(Sender: TObject; var Key: Char);
begin
  Key := SoValor((Sender as TEdit), Key);
end;

procedure TF_Pedidos1.FormCreate(Sender: TObject);
begin
  obAlmoxarifado := TAlmoxarifado.Create();
  obClientes := TClientes.Create();
  obFormaPag := TFormapgnto.Create();
  obTabela := TTabelaprecos.Create();
  obTransportadora := TTransportadoras.Create();
  obVendedor := TVendedores.Create();
  obProduto := TProdutos.Create;
  obItemPedidoWeb := TWtpedidoitem.Create;
  obPedidoWeb := TWtpedido.Create;
  obPrecos := TPrecos.Create;
  obNatureza := TNaturezaopr.Create;
  obCidade := TCidades.Create;
  obCadindex := TCadindex.Create;
  obCadaTna := TCadatna.Create;
  obProxCst := TProxcst.Create;
  obCliInadim := TCliInadim.Create;
  obValoresTrib := TCarregarValoresTrib.Create;
  obFabricantes := TFabricantes.Create;
  obGrupoPro := TGrupopro.Create;

  DescontoLiberado := False;

  TemNCMxTrib := False;
  UFEmp := Nst(BuscaEmpresa(T2.qEmpresa, 'Estado'));
  BloCli := Trim(BuscaCfg2(T2.qgSepeCfg, 'SepeCfg', 'CFG_BLOCLI', 'Bloq Cli,1-Atraso, 2-c/vlr >lim.geral, 3-c/vlr >lim.individual', '', 1, 10));
  BloInc := Trim(BuscaCfg2(T2.qgSepeCfg, 'SepeCfg', 'CFG_BLOINC', 'Inclusão de pedido p/clliente inadimplente/sem limite B-Bloqueia/P-Pergunta/L-Libera', 'P', 1, 10));
  TpoComi := BuscaCfg2(T2.qSepeCFG, 'SEPECFG', 'CFG_TPOCOM', 'Comissao da venda é usada do (C - Cadastro Cliente/ V - Cadastro do Vendedor', 'V', 1, 1);
  CliIna := BuscaCfg2(T2.qgSepeCfg, 'SepeCfg', 'CFG_CLIINA', 'Deixa faturar para clientes inativos', 'N', 1, 1);
  RevCli := Ivl(Trim(BuscaCfg2(T2.qSepeCFG, 'SepeCfg', 'CFG_REVCLI', 'Solicita revisão no cadastro de clientes após quantos dias', '0', 1, 4)));
  RevBlo := BuscaCfg2(T2.qSepeCFG, 'SepeCfg', 'CFG_REVBLO', 'Quando o cliente não está com o cadastro revisado. Bloquear/Avisar/Nenhuma ação(B/A/N)', 'N', 1, 1);
  FatInc := BuscaCfg2(T2.qSepeCFG, 'SepeCfg', 'CFG_FATINC', 'Faturamento para clientes com cadastro incomplento. N-não critica/A-Avisa/P-pergunta/B-bloqueia', 'N', 1, 1);
  BCESIT := BuscaCfg2(T2.qSepeCFG, 'SepeCfg', 'CFG_BCESIT', 'Pesquisa situacao do cliente na base central durante a venda (S/N)?', 'N', 1, 1);
  F4Pro := BuscaCfg2(T2.qSepeCFG, 'SepeCfg', 'CFG_F4PRO', 'Forma de consulta F4 para Produtos (CODIGO, BARRAS, ORIGINAL, DESCRICAO)', 'DESCRICAO', 1, 100);
  F4Cli := BuscaCfg2(T2.qSepeCFG, 'SepeCfg', 'CFG_F4CLI', 'Forma de consulta F4 para Clientes (CODIGO, NOME, FANTASIA, FONE)', 'NOME', 1, 100);
  F4Cta := BuscaCfg2(T2.qSepeCFG, 'SepeCfg', 'CFG_F4CTA', 'Forma de consulta F4 para Contas (CODIGO, DESCRICAO)', 'DESCRICAO', 1, 100);
  F4Cct := BuscaCfg2(T2.qSepeCFG, 'SepeCfg', 'CFG_F4CCT', 'Forma de consulta F4 para Custos (CODIGO, DESCRICAO)', 'DESCRICAO', 1, 100);
  RPTPRO := BuscaCfg2(T2.qgSepeCfg, 'SepeCfg', 'CFG_RPTPRO', 'Aceita repetir o código do produto no pedido? S/N', 'S', 1, 1);
  ORCAUT := BuscaCfg2(T2.qgSepeCfg, 'SepeCfg', 'CFG_ORCAUT', 'Confirma automaticamente o produto quando informa o código no orçamento', 'N', 1, 1);
  F4Esto := BuscaCfg2(T2.qSepeCFG, 'SepeCfg', 'CFG_F4ESTO', 'Mostrar saldos de estoque quando teclar F4 para consulta de produtos nos pedidos de venda[S/N]', 'N', 1, 1);
  PesPro := BuscaCfg2(T2.qgSepeCfg, 'SepeCfg', 'CFG_PESPRO', 'PESQUISA 1-BARRAS/CODIGO  2-CODIGO/BARRAS  3-CODIGO  4-BARRA', '1', 1, 1);
  Decimais := ToInt(BuscaCfg2(T2.qgSepeCfg, 'SepeCfg', 'CFG_DECPED', 'Decimais da quantidade nos pedidos 0,1,2,3,4', '2', 1, 1));
  CNPJEmp := LimpaNumero(Nst(BuscaEmpresa(T2.qEmpresa, 'CGCMF')));
  DecPro := ToInt(BuscaCfg2(T2.qgSepeCfg, 'SepeCfg', 'CFG_DECQTD', 'Deecimais para quantidade nos orçamentos', '2', 1, 1));
  CrgAlx := BuscaCfg2(T2.qSepeCFG, 'SEPECFG', 'CFG_CRGALX', 'Utilizar almoxarifado do cadastro de produtos para movimentação de Estoque [S/N]', 'N', 1, 1);
  CONSRV := BuscaCfg2(T2.qgSepeCfg, 'SepeCfg', 'CFG_CONSRV', 'Fazer o controle de serviços da VIVO', 'N', 1, 1);
  TABDOA := BuscaCfg2(T2.qgSepeCfg, 'SepeCfg', 'CFG_TABDOA', 'Tabela de preços para doação de produtos', '', 1, 4);
  AltVlr := BuscaCfg2(T2.qSepeCFG, 'SEPECFG', 'CFG_ALTVLR', 'Permite alterar valores dos itens no pedido (S/N)?', 'S', 1, 1);
  InicioPro := BuscaCfg2(T2.qgSepeCfg, 'SepeCfg', 'CFG_PROBAL', 'Digitos iniciais dos codigos de barra gerados pela balanca', '99', 1, 2);
  VlrTrf := BuscaCfg2(T2.qgSepeCfg, 'SepeCfg', 'CFG_VLRTRF', 'Usa valor de custo da última compra nas NF de transferencia', 'N', 1, 1);
  SubIrf := BuscaCfg2(T2.qSepeCFG, 'SepeCfg', 'CFG_SUBIRF', 'Subtrair o valor de IR do valor total do Pedido', 'S', 1, 1) = 'S';
  PriDes := BuscaCFG(T2.qgSepeCfg, 'SepeCfg', 'CFG_PRIDES', 1, 1);
  PedDesc := BuscaCfg2(T2.qSepeCFG, 'SepeCfg', 'CFG_PEDDES', 'Verificar liberação para desconto acima do limite permitido: P-Ao Incluir Pedido, I-Ao Incluir Produto', 'I', 1, 1);

  CarregarConfTributos;

  IncCliente := TemAcesso('728');
  AltCliente := TemAcesso('729');

  NomeCli.MaxLength := TamDef(T2.qSepeDic, 'SCRACLI', 'CLI_NOME');
  Contato.MaxLength := TamDef(T2.qSepeDic, 'WTPEDIDO', 'CONTATO');
  CODPROD.MaxLength := TamDef(T2.qSepeDic, 'WTPEDIDOITEM', 'CODTPRODUTO');

  // Monta lista com as naturezas de transferencia
  CFOP_Transferencia := MontaListaCFOP('3', True);

  CriaTemp;
  DefaultOrcamento;
  DefaultItem;
  CriaCdsTempServico(cdsServicos);

  P1 := 0;
  P2 := 0;
  P3 := 0;
  P4 := 0;
end;

procedure TF_Pedidos1.AlertasItem(Tipo: String); // Tipo = I verifica inclusao item / Tipo = O verifica orcamento...
begin
  if Tipo = 'O' then
  begin
    if Trim(Data.Text) = '/  /' then
    begin
      Data.SetFocus;
      Raise Exception.Create('Preencha a data!');
    end;

    if Trim(Ped_CODCLI.Text) = '' then
    begin
      Ped_CODCLI.SetFocus;
      Raise Exception.Create('Preencha o Cliente!');
    end;

    if Trim(CODPAG.Text) = '' then
    begin
      CODPAG.SetFocus;
      Raise Exception.Create('Preencha a Condição de Pagamento!');
    end;

    if Trim(CODVEN.Text) = '' then
    begin
      CODVEN.SetFocus;
      Raise Exception.Create('Preencha o Vendedor!');
    end;

    if cdsItens.IsEmpty then
    begin
      CODPRO.SetFocus;
      Raise Exception.Create('Nenhum produto foi incluido!');
    end;
  end;

  if Tipo = 'I' then
  begin
    if Trim(CODPRO.Text) = '' then
    begin
      CODPRO.SetFocus;
      Raise Exception.Create('Preencha o Produto!');
    end;

    if CodTna.Text = '' then
    begin
      CodTna.SetFocus;
      Raise Exception.Create('Preencha a Operação!');
    end;

    if (NATOPR.Text = '') or (CODOPR.Text = '') then
    begin
      NATOPR.SetFocus;
      Raise Exception.Create('Preencha a natureza!');
    end;

    obClientes.setCli_codigo(Ped_CODCLI.Text);
    if obClientes.Consultar then
    begin

      if (Ivl(Copy(Trim(NATOPR.Text), 1, 1)) = 5) and (obClientes.getCli_uf <> Nst(BuscaEmpresa(T2.qEmpresa, 'Estado'))) then
      begin
        NATOPR.SetFocus;
        NATOPR.SelectAll;
        Raise Exception.Create(' Cliente fora do estado. Natureza de operação incorreta ' + NATOPR.Text + ' ' + CODOPR.Text);
      end;

      if (Ivl(Copy(NATOPR.Text, 1, 1)) <> 5) and (obClientes.getCli_uf = Nst(BuscaEmpresa(T2.qEmpresa, 'Estado'))) then
      begin
        NATOPR.SetFocus;
        NATOPR.SelectAll;
        Raise Exception.Create(' Cliente dentro do estado. Natureza de operação incorreta ' + NATOPR.Text + ' ' + CODOPR.Text);
      end;
    end;

    if Trim(CODTAB.Text) = '' then
    begin
      CODTAB.SetFocus;
      Raise Exception.Create('Preencha a Tabela!');
    end;

    if Val(Qtde.Text) <= 0 then
    begin
      Qtde.SetFocus;
      Raise Exception.Create('Preencha a Quantidade!');
    end;

    if Val(VlrUnt.Text) <= 0 then
    begin
      VlrUnt.SetFocus;
      Raise Exception.Create('Preencha o Valor Unitário!');
    end;
  end;
end;

procedure TF_Pedidos1.btExcItemClick(Sender: TObject);
var
  i: Integer;
  BMK: TBookmark;
  TotalProdutos, TotalServicos, TotalProdComICMS, TotalProdComPis, TotalProdComCof, TotalFaturar: Currency;
  GeraFinGeral: Boolean;
begin
  cdsItens.Delete;
  BMK := cdsItens.GetBookmark;

  i := 0;
  cdsItens.First;
  While not cdsItens.Eof do
  begin
    cdsItens.Edit;
    Inc(i);
    cdsItens['NRITEM'] := StrZero(IntToStr(i), 4);
    cdsItens.Post;
    cdsItens.Next;
  end;

  try
    cdsItens.GotoBookmark(BMK)
  except
  end;
  RecalcItend(TotalProdutos, TotalServicos, TotalProdComICMS, TotalProdComPis, TotalProdComCof, TotalFaturar, GeraFinGeral);
end;

procedure TF_Pedidos1.btGravarClick(Sender: TObject);
begin
  ValidarGravacao;

  if (Caption = 'Incluir') or (Caption = 'Manutenção') or (Caption = 'Duplicar') then
  begin
    if (PedDesc = 'P') and not(TemAcesso('O017')) then
      VerificaDescontos;

    AlertasItem('O');
    VerificaProAtivo('CODPRO', cdsItens);
    NomeCap := Caption;

    if (Trim(edtId.Text) = '') then
      edtId.Text := Nst(obPedidoWeb.Auto_inc_id(1));

    InicioTransacao(T2.WsepeDBX);
    try
      Gravar;
    except
      on E: Exception do
      begin
        FimTransacao(T2.WsepeDBX, False);
        DL_Msg('Erro: ' + E.message, 'Gravação', 'Erro');
        Exit;
      end
      else
      begin
        FimTransacao(T2.WsepeDBX, False);
        DL_Msg('Ocorreu um erro no processamento!', 'Gravação', 'Erro');
        Exit;
      end;
    end;
    FimTransacao(T2.WsepeDBX, True);

    if (Caption = 'Incluir') then
    begin
      DefaultOrcamento;
      DefaultItem;
      cdsItens.EmptyDataSet;
      Ped_CODCLI.SetFocus;
    end
    else if (Caption = 'Manutenção') or (Caption = 'Duplicar') then
      Close;
  end;

  if (Caption = 'Excluir') then
  begin
    obPedidoWeb.Excluir;
    ExcluiItens(obPedidoWeb.getId);
    Close;
  end;
end;

procedure TF_Pedidos1.btnDadosCliClick(Sender: TObject);
begin

  Application.CreateForm(TF_Clientes1, F_Clientes1);

  try
    with F_Clientes1 do
    begin

      obCliente.setCli_codigo(Trim(Ped_CODCLI.Text));
      if (Ped_CODCLI.Text <> '000000') and (obCliente.Consultar()) then
      begin

        if (AltCliente) and ((self.Caption = 'Incluir') or (self.Caption = 'Manutenção')) then
        begin
          Caption := 'Alterar';
          Visualizar.Visible := False;
          TransEndereco.Visible := True;
          TamanhoDefault;
        end
        else
        begin
          Caption := 'Ver';
          Confirmar.Visible := False;
          Fotografar.Enabled := False;

          ConfItem.Enabled := False;
          ExcluirItem.Enabled := False;

          DesabilitarTela(F_Clientes1);
        end;

        Mostra;
      end
      else
      begin
        if (IncCliente) and ((self.Caption = 'Incluir') or (self.Caption = 'Manutenção')) then
        begin
          Caption := 'Incluir';

          Visualizar.Visible := False;
          pnTopo.Visible := False;

          ValoresDefault;
        end
        else
          Exit;
      end;

      ChamadaExterna := True;
      ShowModal;
    end;

    if Trim(F_Clientes1.Codigo.Text) <> '' then
      Ped_CODCLI.Text := F_Clientes1.Codigo.Text;

  finally
    F_Clientes1.Free;
  end;

  if Trim(Ped_CODCLI.Text) <> '' then
    Ped_CODCLIExit(Ped_CODCLI);
end;

procedure TF_Pedidos1.TpoFreteClick(Sender: TObject);
begin
  VlrFrete.ReadOnly := True;
  if Frete.ItemIndex = 1 then
    VlrFrete.ReadOnly := False
  else
  begin
    VlrFrete.ReadOnly := True;
    VlrFrete.Text := '0,00';
  end;
end;

procedure TF_Pedidos1.TributacaoNCM(CodigoProduto: String);
var
  obTributacao: TCarregarTributacao;
begin
  NATOPR.ReadOnly := False;
  CODOPR.ReadOnly := False;

  obProduto.setPro_codigo(CodigoProduto);
  obProduto.Consultar;

  obTributacao := TCarregarTributacao.Create('C', CodTna.Text, obProduto, obClientes, nil);
  TemNCMxTrib := obTributacao.TemNCMxTrib;

  // se não tem tibutação definida pelo NCM usa o metodo anteriro de pesquisa
  if not TemNCMxTrib then
    Exit;

  ProNcm.Text := obProduto.getPro_clasfi;

  obNatureza.setNt_cfo(obTributacao.NATOPR);
  obNatureza.setNt_opc(obTributacao.CODOPR);
  if not obNatureza.Consultar then
  begin
    DL_Msg('CFOP informada no NCM não cadastrada!', 'CFOP', 'Erro');
    Exit;
  end
  else if obNatureza.getNt_ativo <> 'S' then
  begin
    DL_Msg('CFOP informada no NCM  inativa.', 'CFOP', 'Erro');
    Exit;
  end;

  // se localizou a tributação pelo NCM do produto, não pode alterar a natrueza, tem que usar a natureza que foi especificada na tributação
  NATOPR.ReadOnly := True;
  CODOPR.ReadOnly := True;

  // se localizou a tributação pelo NCM do produto, preenche todos os campos
  NATOPR.Text := obTributacao.NATOPR;
  CODOPR.Text := obTributacao.CODOPR;

  CODCST.Text := obTributacao.cstICM;
  edCstPis.Text := obTributacao.cstPIS;
  edCstCof.Text := obTributacao.CstCOF;
  EdCstIPI.Text := obTributacao.cstIPI;
  edCSOSN.Text := obTributacao.CSOSN;

  prIcm.Text := str(obTributacao.prIcm, 0);
  edtPrIcmsSt.Text := str(obTributacao.PIcmsSt, 0);
  prIPI.Text := str(obTributacao.prIPI, 2);
  prRedICM.Text := str(obTributacao.RedIcm, 4);
  prMVA.Text := str(obTributacao.prMVA, 4);

  SitICM.Text := TribICMS(CODCST.Text);
  SitIpi.Text := TribIPI(EdCstIPI.Text);

  PrIssLin := obTributacao.PrIss;
  PrInsLin := obTributacao.PrIns;
  PrIrfLin := obTributacao.PrIrf;
  RedIssLin := obTributacao.RedIss;
  RedInsLin := obTributacao.RedIns;

  RetIssLin := obTributacao.RetIss;
  RetPisLin := obTributacao.RetPis;

  // exceção se o CST ICMS for 51-Diferimento, pode ser tirubutado, desde que tenha algum % cadastrado
  // if (copy(CodCst.Text,2,2) = '51') and ((Val(prICM.Text) > 0) or (Val(prRedICM.Text) > 0))
  // then sitIcm.text   := '1'; // tributado

  // devida a variedade de uso do CST 90 e a possibilidade do CST 51 ter diferimento parcial,
  // pode ser inf separadamente se a operação é tributada, isente ou outras
  if ((Copy(CODCST.Text, 2, 2) = '51') or (Copy(CODCST.Text, 2, 2) = '90')) and (obNatureza.getNt_siticm >= '1') and (obNatureza.getNt_siticm <= '3') then
    SitICM.Text := obNatureza.getNt_siticm;

  // DSP01         := D1;
  // DSP02         := D2;
  // DSP03         := D3;
  // DSP04         := D4;

  // pnServico.Visible:= False;
  // if cstICM = '080' then
  // begin
  // pnServico.Visible := True;
  // pnServico.Top     := 1;
  // pnServico.Left    := 760;
  // end;

  obTributacao.Free;
  Application.ProcessMessages;
end;

procedure TF_Pedidos1.AtualizaItens;
begin

  // altera o item anterior, qtde = qtde do pedido e o saldo = 0
  cdsItens.Edit;
  cdsItens['QTDE'] := str(QtdeAnt - SaldoAnt, DecPro);
  cdsItens['SALDO'] := 0;
  cdsItens['VLRTOT'] := str((QtdeAnt - SaldoAnt) * VlrUntAnt, Decimais);
  cdsItens.Post;

  // inclui um novo item
  cdsItens.Append;
  cdsItens['ID'] := Ivl(edtIdItem.Text);
  cdsItens['NRITEM'] := StrZero(IntToStr(cdsItens.RecordCount + 1), 4);
  cdsItens['CODPRO'] := CODPRO.Text;
  cdsItens['OBSERVACAO'] := edtObservacao.Text;
  cdsItens['BARRAS'] := obProduto.getPro_codbar;
  cdsItens['REDUT'] := obProduto.getPro_redut;
  cdsItens['DESCRI'] := CODPROD.Text;
  cdsItens['TAB'] := CODTAB.Text;
  cdsItens['VLRUNT'] := str(Val(VlrUnt.Text), Decimais);
  cdsItens['QTDE'] := str(Val(Qtde.Text), DecPro);
  cdsItens['SALDO'] := str(Val(Qtde.Text), DecPro);
  cdsItens['VLRTOT'] := str(Val(VlrTot.Text), Decimais);
  cdsItens['NATOPR'] := NATOPR.Text;
  cdsItens['CODOPR'] := CODOPR.Text;
  cdsItens['CODTNA'] := CODOPR.Text;
  cdsItens['VLRDES'] := str(Val(VlrDesc.Text), Decimais);
  cdsItens['PERDES'] := str(Val(PercDesc.Text), Decimais);
  cdsItens['UND'] := UNDPRO.Text;
  cdsItens['Cst'] := CODCST.Text;
  cdsItens['PISCst'] := edCstPis.Text;
  cdsItens['COFCst'] := edCstCof.Text;
  cdsItens['IPICst'] := EdCstIPI.Text;
  cdsItens['CSOSN'] := edCSOSN.Text;
  cdsItens['PrAdST'] := Nvl(prMVA.Text);
  cdsItens['Icms'] := Nvl(prIcm.Text);
  cdsItens['IcmsSt'] := Nvl(edtPrIcmsSt.Text);
  cdsItens['PerIPI'] := Nvl(prIPI.Text);
  cdsItens['PrIss'] := Nvl(PrIssLin);
  cdsItens['PrInss'] := Nvl(PrInsLin);
  cdsItens['PrIrf'] := Nvl(PrIrfLin);
  cdsItens['SitIcm'] := SitICM.Text;
  cdsItens['SitIpi'] := SitIpi.Text;
  cdsItens['RedIcm'] := Nvl(prRedICM.Text);
  cdsItens['RedIss'] := Nvl(RedIssLin);
  cdsItens['RedInss'] := Nvl(RedInsLin);
  cdsItens['RetIss'] := RetIssLin;
  cdsItens['RetPis'] := RetPisLin;
  cdsItens.Post;
end;

procedure TF_Pedidos1.AtualizarTotal(TotalProdutos: Real);
begin
  TotalOrc.Text := str(TotalProdutos + Nvl(VlrFrete.Text) + Nvl(edtVlrSub.Text) + Nvl(edtVlrIpi.Text) - Nvl(edtRetPis.Text) + Nvl(edtRetCof.Text) + Nvl(edtRetCsl.Text) + Nvl(edtRetIss.Text) + Nvl(edtSufIcms.Text) + Nvl(edtSufPis.Text) + Nvl(edtSufCof.Text) + Nvl(edtSufIpi.Text) - Nvl(edtVlrDes.Text), Decimais);
end;

procedure TF_Pedidos1.AtualizarTrib(TotalProdutos, TotalServicos, TotalProdComICMS, TotalProdComPis, TotalProdComCof, TotalFaturar: Currency; GeraFinGeral: Boolean);
var
  BMK: TBookmark;
  BasIcm, VlrIcm, BasSub, VlrSub, BasIpi, VlrIpi, RetPis, RetCof, RetCsl, RetIss, SufIcm, SufPis, SufCof, SufIpi, VlrIrf: Real;
begin
  BMK := cdsItens.GetBookmark;
  cdsItens.DisableControls;
  Try
    obClientes.setCli_codigo(Ped_CODCLI.Text);
    obClientes.Consultar;

    BasIcm := 0;
    VlrIcm := 0;
    BasSub := 0;
    VlrSub := 0;
    BasIpi := 0;
    VlrIpi := 0;

    RetPis := 0;
    RetCof := 0;
    RetCsl := 0;
    RetIss := 0;
    SufIcm := 0;
    SufPis := 0;
    SufCof := 0;
    SufIcm := 0;
    VlrIcm := 0;

    cdsItens.First;
    while not cdsItens.Eof do
    begin
      // Carrega o objeto da natureza somente se este já não estiver carregado com a natureza atual
      if (Nst(cdsItens['NatOpr']) <> obNatureza.getNt_cfo) or (Nst(cdsItens['CodOpr']) <> obNatureza.getNt_opc) then
      begin
        obNatureza.setNt_cfo(Nst(cdsItens['NatOpr']));
        obNatureza.setNt_opc(Nst(cdsItens['CodOpr']));
        obNatureza.Consultar;
      end;

{$REGION 'Populando o objeto com informações de entrada necessárias para o cálculo das tributações'}
      obValoresTrib.LimparObj;

      // Dados do cabeçalho
      obValoresTrib.Variaveis.Cab.isDevolucao := False;
      obValoresTrib.Variaveis.Cab.TemNCMxTrib := TemNCMxTrib;
      obValoresTrib.Variaveis.Cab.TotFre := Nvl(VlrFrete.Text);
      obValoresTrib.Variaveis.Cab.TotAcr := 0;
      obValoresTrib.Variaveis.Cab.TotSeg := 0;
      obValoresTrib.Variaveis.Cab.TotDes := Nvl(edtVlrDes.Text);
      obValoresTrib.Variaveis.Cab.TotOut := 0;
      obValoresTrib.Variaveis.Cab.VlrSepDes := 0;
      obValoresTrib.Variaveis.Cab.VlrSepAcr := 0;

      // Dados do cliente
      obValoresTrib.Variaveis.Dest.TpoTrb := obClientes.getCli_tpotrb;
      obValoresTrib.Variaveis.Dest.Sufram := obClientes.getCli_sufram;
      obValoresTrib.Variaveis.Dest.InsEst := obClientes.getCli_insest;
      obValoresTrib.Variaveis.Dest.uf := obClientes.getCli_uf;

      // Dados do produto
      obValoresTrib.Variaveis.Prod.CODPRO := Nst(cdsItens['CODPRO']);
      obValoresTrib.Variaveis.Prod.Redut := Nvl(cdsItens['REDUT']);

      // Dados da linha
      obValoresTrib.Variaveis.Item.QtdConv := Nvl(cdsItens['Qtde']);
      obValoresTrib.Variaveis.Item.QtdPro := Nvl(cdsItens['Qtde']);
      obValoresTrib.Variaveis.Item.VlrUni := Nvl(cdsItens['VlrUnt']);
      obValoresTrib.Variaveis.Item.VlrAcr := 0;
      obValoresTrib.Variaveis.Item.VlrDes := Nvl(cdsItens['VlrDes']);
      obValoresTrib.Variaveis.Item.VlrLin := Nvl(cdsItens['VlrTot']);

      // Dados da tributação da linha
      obValoresTrib.Variaveis.Item.Trib.cstICM := Nst(cdsItens['Cst']);
      obValoresTrib.Variaveis.Item.Trib.cstPIS := Nst(cdsItens['PISCst']);
      obValoresTrib.Variaveis.Item.Trib.CstCOF := Nst(cdsItens['COFCst']);
      obValoresTrib.Variaveis.Item.Trib.cstIPI := Nst(cdsItens['IPICst']);
      obValoresTrib.Variaveis.Item.Trib.CSOSN := Nst(cdsItens['CSOSN']);
      obValoresTrib.Variaveis.Item.Trib.prMVA := Nvl(cdsItens['PrAdST']);
      obValoresTrib.Variaveis.Item.Trib.prIcm := Nvl(cdsItens['Icms']);
      obValoresTrib.Variaveis.Item.Trib.PrIcmSt := Nvl(cdsItens['IcmsSt']);
      obValoresTrib.Variaveis.Item.Trib.prIPI := Nvl(cdsItens['PerIPI']);
      obValoresTrib.Variaveis.Item.Trib.PrIss := Nvl(cdsItens['PrIss']);
      obValoresTrib.Variaveis.Item.Trib.PrIns := Nvl(cdsItens['PrInss']);
      obValoresTrib.Variaveis.Item.Trib.PrIrf := Nvl(cdsItens['PrIrf']);

      if Nst(cdsItens['SitIcm']) = '' then
      begin
        cdsItens.Edit;
        cdsItens['SitIcm'] := TribICMS(obValoresTrib.Variaveis.Item.Trib.cstICM);
        cdsItens.Post;
      end;

      if Nst(cdsItens['SitIpi']) = '' then
      begin
        cdsItens.Edit;
        cdsItens['SitIpi'] := TribIPI(obValoresTrib.Variaveis.Item.Trib.cstIPI);
        cdsItens.Post;
      end;

      obValoresTrib.Variaveis.Item.Trib.SitICM := Nst(cdsItens['SitIcm']);
      obValoresTrib.Variaveis.Item.Trib.SitIpi := Nst(cdsItens['SitIpi']);

      obValoresTrib.Variaveis.Item.Trib.RedIcm := Nvl(cdsItens['RedIcm']);
      obValoresTrib.Variaveis.Item.Trib.RedIss := Nvl(cdsItens['RedIss']);
      obValoresTrib.Variaveis.Item.Trib.RedIns := Nvl(cdsItens['RedInss']);
      obValoresTrib.Variaveis.Item.Trib.RetIss := Nst(cdsItens['RetIss']);
      obValoresTrib.Variaveis.Item.Trib.RetPis := Nst(cdsItens['RetPis']);

      // Dados da natureza de operação
      obValoresTrib.Variaveis.Nat.NATOPR := obNatureza.getNt_cfo;
      obValoresTrib.Variaveis.Nat.CODOPR := obNatureza.getNt_opc;
      obValoresTrib.Variaveis.Nat.GerDup := obNatureza.getNt_gerdup = 'S';
      obValoresTrib.Variaveis.Nat.IcmIpi := obNatureza.getNt_icmipi;
      obValoresTrib.Variaveis.Nat.IpiFre := obNatureza.getNt_IpiFre;
      obValoresTrib.Variaveis.Nat.IpiSeg := obNatureza.getNt_IpiSeg;
      obValoresTrib.Variaveis.Nat.IpiDes := obNatureza.getNt_IpiDes;
      obValoresTrib.Variaveis.Nat.IpiDfi := obNatureza.getNt_IpiDfi;
      obValoresTrib.Variaveis.Nat.IpiOut := obNatureza.getNt_ipiemb;
      obValoresTrib.Variaveis.Nat.IcmFre := obNatureza.getNt_IcmFre;
      obValoresTrib.Variaveis.Nat.IcmSeg := obNatureza.getNt_IcmSeg;
      obValoresTrib.Variaveis.Nat.IcmDes := obNatureza.getNt_IcmDes;
      obValoresTrib.Variaveis.Nat.IcmDfi := obNatureza.getNt_IcmDfi;
      obValoresTrib.Variaveis.Nat.IcmOut := obNatureza.getNt_icmemb;

      // Configurações do sistema
      obValoresTrib.Variaveis.Conf.CfgSepAcr := SepAcr;
      obValoresTrib.Variaveis.Conf.CfgSepDes := SepDes;
      obValoresTrib.Variaveis.Conf.CfgCrdIcm := CrdIcm;
      obValoresTrib.Variaveis.Conf.CfgTrbNcm := TrbNCM;
      obValoresTrib.Variaveis.Conf.CfgSmpNac := SmpNac;
      obValoresTrib.Variaveis.Conf.CfgPrRetPis := PrRetPis;
      obValoresTrib.Variaveis.Conf.CfgPrRetCof := PrRetCof;
      obValoresTrib.Variaveis.Conf.CfgPrRetIrf := PrRetIrf;
      obValoresTrib.Variaveis.Conf.CfgPrRetCsl := PrRetCsl;
      obValoresTrib.Variaveis.Conf.CfgConIpi := ConIpi;
      obValoresTrib.Variaveis.Conf.CfgPrPis := PrPis;
      obValoresTrib.Variaveis.Conf.CfgPrCof := PrCof;
      obValoresTrib.Variaveis.Conf.CfgPrSufIcm := PrSufIcm;
      obValoresTrib.Variaveis.Conf.CfgPrSufPis := PrSufPis;
      obValoresTrib.Variaveis.Conf.CfgPrSufCof := PrSufCof;
      obValoresTrib.Variaveis.Conf.CfgPrSufIpi := PrSufIpi;
{$ENDREGION}
      // Execução do cálculo
      obValoresTrib.Calcular(TotalProdutos, TotalServicos, TotalProdComICMS, TotalProdComPis, TotalProdComCof, TotalFaturar, GeraFinGeral);

{$REGION 'Alimentado o dataset com os dados do resultado da tributação'}
      cdsItens.Edit;
      cdsItens['BasSub'] := obValoresTrib.Resultado.BasSub;
      cdsItens['VlrSub'] := obValoresTrib.Resultado.VlrSub;
      cdsItens['BasIpiLin'] := obValoresTrib.Resultado.BasIpi;
      cdsItens['VlrIpi'] := obValoresTrib.Resultado.VlrIpi;
      cdsItens['BasIcmLin'] := obValoresTrib.Resultado.BasIcm;
      cdsItens['VlrIcmLin'] := obValoresTrib.Resultado.VlrIcm;
      cdsItens['VlrRetPis'] := obValoresTrib.Resultado.VlrRetPis;
      cdsItens['VlrRetCof'] := obValoresTrib.Resultado.VlrRetCof;
      cdsItens['VlrRetCsl'] := obValoresTrib.Resultado.VlrRetCsl;
      cdsItens['VlrRetIss'] := obValoresTrib.Resultado.VlrRetIss;
      cdsItens['SufIcm'] := obValoresTrib.Resultado.SufIcm;
      cdsItens['SufPis'] := obValoresTrib.Resultado.SufPis;
      cdsItens['SufCof'] := obValoresTrib.Resultado.SufCof;
      cdsItens['SufIpi'] := obValoresTrib.Resultado.SufIpi;
      if SubIrf then
        cdsItens['VlrIrf'] := Nvl(cdsItens['VlrIrf']) + obValoresTrib.Resultado.VlrIrf;

      cdsItens.Post;
{$ENDREGION};

      BasSub := BasSub + Nvl(cdsItens['BasSub']);
      VlrSub := VlrSub + Nvl(cdsItens['VlrSub']);
      BasIpi := BasIpi + Nvl(cdsItens['BasIpiLin']);
      VlrIpi := VlrIpi + Nvl(cdsItens['VlrIpi']);
      BasIcm := BasIcm + Nvl(cdsItens['BasIcmLin']);
      VlrIcm := VlrIcm + Nvl(cdsItens['VlrIcmLin']);

      RetPis := RetPis + Nvl(cdsItens['VlrRetPis']);
      RetCof := RetCof + Nvl(cdsItens['VlrRetCof']);
      RetCsl := RetCsl + Nvl(cdsItens['VlrRetCsl']);
      RetIss := RetIss + Nvl(cdsItens['VlrRetIss']);
      SufIcm := SufIcm + Nvl(cdsItens['SufIcm']);
      SufPis := SufPis + Nvl(cdsItens['SufPis']);
      SufCof := SufCof + Nvl(cdsItens['SufCof']);
      SufIpi := SufIpi + Nvl(cdsItens['SufIpi']);
      VlrIrf := VlrIrf + Nvl(cdsItens['VlrIrf']);

      Application.ProcessMessages;
      cdsItens.Next;
    end;

    edtBasSub.Text := str(BasSub, Decimais);
    edtVlrSub.Text := str(VlrSub, Decimais);
    edtBasIpi.Text := str(BasIpi, Decimais);
    edtVlrIpi.Text := str(VlrIpi, Decimais);
    edtBasIcm.Text := str(BasIcm, Decimais);
    edtVlrIcm.Text := str(VlrIcm, Decimais);
    edtRetPis.Text := str(RetPis, Decimais);
    edtRetCof.Text := str(RetCof, Decimais);
    edtRetCsl.Text := str(RetCsl, Decimais);
    edtRetIss.Text := str(RetIss, Decimais);
    edtSufIcms.Text := str(SufIcm, Decimais);
    edtSufPis.Text := str(SufPis, Decimais);
    edtSufCof.Text := str(SufCof, Decimais);
    edtSufIpi.Text := str(SufIpi, Decimais);
    edtVlrIrf.Text := str(VlrIrf, Decimais);

    AtualizarTotal(TotalProdutos);
  Finally
    cdsItens.GotoBookmark(BMK);
    cdsItens.EnableControls;
  End;
end;

procedure TF_Pedidos1.btConfItemClick(Sender: TObject);
var
  AltCodPro, TemPedido: Boolean;
  TotalProdutos, TotalServicos, TotalProdComICMS, TotalProdComPis, TotalProdComCof, TotalFaturar: Currency;
  GeraFinGeral: Boolean;
begin
  AlertasItem('I');

  obProduto.setPro_codigo(CODPRO.Text);
  obProduto.Consultar;

  if (PedDesc = 'I') and (Val(PercDesc.Text) > 0) and not(TemAcesso('O017')) then
    VerificaDescontosItem;

  if CodProAnt = Trim(CODPRO.Text) then
    AltCodPro := False
  else
    AltCodPro := True;

  if QtdeAnt = SaldoAnt then
    TemPedido := False
  else
    TemPedido := True;

  // se é uma alteração e o item tem pedido e foi alterado o cod do produto
  // entao o saldo do item anterior fica = 0 e inclui um novo item
  if TemPedido and AltCodPro and (btConfItem.Caption = 'Confirma Alteraçao') then
  begin
    if (QtdeAnt > 0) then
      AtualizaItens;
  end
  else
  begin
    if (btConfItem.Caption = 'Confirma Alteraçao') then
      cdsItens.Edit
    else
    begin
      cdsItens.Append;
      cdsItens['NRITEM'] := StrZero(IntToStr(cdsItens.RecordCount + 1), 4);
    end;

    cdsItens['ID'] := Ivl(edtIdItem.Text);
    cdsItens['CODPRO'] := CODPRO.Text;
    cdsItens['OBSERVACAO'] := edtObservacao.Text;
    cdsItens['BARRAS'] := obProduto.getPro_codbar;
    cdsItens['REDUT'] := obProduto.getPro_redut;
    cdsItens['DESCRI'] := CODPROD.Text;
    cdsItens['TAB'] := CODTAB.Text;
    cdsItens['VLRUNT'] := str(Val(VlrUnt.Text), Decimais);
    cdsItens['QTDE'] := str(Val(Qtde.Text), DecPro);

    if TemPedido and (not AltCodPro) and (btConfItem.Caption = 'Confirma Alteraçao') then
      cdsItens['SALDO'] := str((Val(Qtde.Text) - QtdeAnt) + SaldoAnt, DecPro)
    else
      cdsItens['SALDO'] := str(Val(Qtde.Text), DecPro);

    cdsItens['VLRTOT'] := str(Val(VlrTot.Text), Decimais);
    cdsItens['NATOPR'] := NATOPR.Text;
    cdsItens['CODOPR'] := CODOPR.Text;
    cdsItens['CODTNA'] := CodTna.Text;
    cdsItens['PERDES'] := Val(PercDesc.Text);
    cdsItens['VLRDES'] := Val(VlrDesc.Text);
    cdsItens['UND'] := UNDPRO.Text;

    // Carrega as variáveis das tributações para calculo dos valores
    cdsItens['Cst'] := CODCST.Text;
    cdsItens['PISCst'] := edCstPis.Text;
    cdsItens['COFCst'] := edCstCof.Text;
    cdsItens['IPICst'] := EdCstIPI.Text;
    cdsItens['CSOSN'] := edCSOSN.Text;
    cdsItens['PrAdST'] := Nvl(prMVA.Text);
    cdsItens['Icms'] := Nvl(prIcm.Text);
    cdsItens['IcmsSt'] := Nvl(edtPrIcmsSt.Text);
    cdsItens['PerIPI'] := Nvl(prIPI.Text);
    cdsItens['PrIss'] := Nvl(PrIssLin);
    cdsItens['PrInss'] := Nvl(PrInsLin);
    cdsItens['PrIrf'] := Nvl(PrIrfLin);
    cdsItens['SitIcm'] := SitICM.Text;
    cdsItens['SitIpi'] := SitIpi.Text;
    cdsItens['RedIcm'] := Nvl(prRedICM.Text);
    cdsItens['RedIss'] := Nvl(RedIssLin);
    cdsItens['RedInss'] := Nvl(RedInsLin);
    cdsItens['RetIss'] := RetIssLin;
    cdsItens['RetPis'] := RetPisLin;

    cdsItens.Post;
    LimpaItens;

  end;
  btExcItem.Enabled := True;
  btConfItem.Caption := 'Incluir Item';
  CODPRO.SetFocus;

  // Atualiza os totais dos itens
  RecalcItend(TotalProdutos, TotalServicos, TotalProdComICMS, TotalProdComPis, TotalProdComCof, TotalFaturar, GeraFinGeral);

  // Atualiza
  AtualizarTrib(TotalProdutos, TotalServicos, TotalProdComICMS, TotalProdComPis, TotalProdComCof, TotalFaturar, GeraFinGeral);

  TemNCMxTrib := False;
end;

procedure TF_Pedidos1.RecalcItend(var TotalProdutos, TotalServicos, TotalProdComICMS, TotalProdComPis, TotalProdComCof, TotalFaturar: Currency; var GeraFinGeral: Boolean);
var
  BMK: TBookmark;
  Itens: Integer;
  SomaTotal, BasIcm, VlrIcm, BasSub, VlrSub, BasIpi, VlrIpi, RetPis, RetCof, RetCsl, RetIss, SufIcm, SufPis, SufCof, SufIpi, VlrIrf: Real;
begin
  if not cdsItens.Active then
    Exit;

  if cdsItens.IsEmpty then
  begin
    lbItens.Caption := '0 - Itens';
    TotalOrc.Text := '0,00';
    Exit;
  end;

  SomaTotal := 0;
  TotalFaturar := 0;
  TotalProdutos := 0;
  TotalServicos := 0;
  TotalProdComICMS := 0;
  TotalProdComPis := 0;
  TotalProdComCof := 0;
  BasIcm := 0;
  VlrIcm := 0;
  BasSub := 0;
  VlrSub := 0;
  BasIpi := 0;
  VlrIpi := 0;
  RetPis := 0;
  RetCof := 0;
  RetCsl := 0;
  RetIss := 0;
  SufIcm := 0;
  SufPis := 0;
  SufCof := 0;
  SufIcm := 0;
  VlrIcm := 0;

  Itens := 0;
  BMK := cdsItens.GetBookmark;

  GeraFinGeral := TemFinanceiroGeral;

  cdsItens.First;
  While not cdsItens.Eof do
  begin
    Inc(Itens);
    SomaTotal := SomaTotal + Nvl(cdsItens['VLRTOT']);

    // Soma das linhas que geram duplicatas, quando nenhuma linha gera duplicata o rateio é entre todas as linhas
    if (not GeraFinGeral) or (GeraFaturamento(Nst(cdsItens['NatOpr']), Nst(cdsItens['CodOpr']))) then
      TotalFaturar := TotalFaturar + Nvl(cdsItens['VLRTOT']);

    if Nst(cdsItens['CST']) = '080' then
      TotalServicos := TotalServicos + (Nvl(cdsItens['QTDE']) * Nvl(cdsItens['VLRUNT']));

    // item é tributado ICMS
    if (cdsItens['SitICM'] = '1') then
      TotalProdComICMS := TotalProdComICMS + Nvl(cdsItens['VLRTOT']);

    if (Nst(cdsItens['PISCST']) = '01') or (Nst(cdsItens['PISCST']) = '02') or (Nst(cdsItens['PISCST']) = '03') or (Nst(cdsItens['PISCST']) = '04') or (Nst(cdsItens['PISCST']) = '06') then
      TotalProdComPis := TotalProdComPis + Nvl(cdsItens['VLRTOT']);

    if (Nst(cdsItens['COFCST']) = '01') or (Nst(cdsItens['COFCST']) = '02') or (Nst(cdsItens['COFCST']) = '03') or (Nst(cdsItens['COFCST']) = '04') or (Nst(cdsItens['COFCST']) = '06') then
      TotalProdComCof := TotalProdComCof + Nvl(cdsItens['VLRTOT']);

    BasSub := BasSub + Nvl(cdsItens['BasSub']);
    VlrSub := VlrSub + Nvl(cdsItens['VlrSub']);
    BasIpi := BasIpi + Nvl(cdsItens['BasIpiLin']);
    VlrIpi := VlrIpi + Nvl(cdsItens['VlrIpi']);
    BasIcm := BasIcm + Nvl(cdsItens['BasIcmLin']);
    VlrIcm := VlrIcm + Nvl(cdsItens['VlrIcmLin']);

    RetPis := RetPis + Nvl(cdsItens['VlrRetPis']);
    RetCof := RetCof + Nvl(cdsItens['VlrRetCof']);
    RetCsl := RetCsl + Nvl(cdsItens['VlrRetCsl']);
    RetIss := RetIss + Nvl(cdsItens['VlrRetIss']);
    SufIcm := SufIcm + Nvl(cdsItens['SufIcm']);
    SufPis := SufPis + Nvl(cdsItens['SufPis']);
    SufCof := SufCof + Nvl(cdsItens['SufCof']);
    SufIpi := SufIpi + Nvl(cdsItens['SufIpi']);
    VlrIrf := VlrIrf + Nvl(cdsItens['VlrIrf']);

    Application.ProcessMessages;
    cdsItens.Next;
  end;

  lbItens.Caption := IntToStr(Itens) + ' - Itens';

  TotalProdutos := SomaTotal;
  edtBasSub.Text := str(BasSub, Decimais);
  edtVlrSub.Text := str(VlrSub, Decimais);
  edtBasIpi.Text := str(BasIpi, Decimais);
  edtVlrIpi.Text := str(VlrIpi, Decimais);
  edtBasIcm.Text := str(BasIcm, Decimais);
  edtVlrIcm.Text := str(VlrIcm, Decimais);
  edtRetPis.Text := str(RetPis, Decimais);
  edtRetCof.Text := str(RetCof, Decimais);
  edtRetCsl.Text := str(RetCsl, Decimais);
  edtRetIss.Text := str(RetIss, Decimais);
  edtSufIcms.Text := str(SufIcm, Decimais);
  edtSufPis.Text := str(SufPis, Decimais);
  edtSufCof.Text := str(SufCof, Decimais);
  edtSufIpi.Text := str(SufIpi, Decimais);
  edtVlrIrf.Text := str(VlrIrf, Decimais);

  AtualizarTotal(TotalProdutos);

  cdsItens.GotoBookmark(BMK);
  Application.ProcessMessages;
end;

procedure TF_Pedidos1.LimpaItens;
begin
  CODPRO.Clear;
  edtObservacao.Clear;
  CODPROD.Clear;
  UNDPRO.Clear;
  CodTna.Clear;
  CodTnaD.Clear;
  NATOPR.Clear;
  NatOprD.Clear;
  CODOPR.Clear;
  CODTAB.Clear;
  CODCST.Clear;
  EdCstIPI.Clear;
  edCstCof.Clear;
  edCstPis.Clear;
  prIcm.Clear;
  edtPrIcmsSt.Clear;
  prIPI.Clear;
  prRedICM.Clear;
  prMVA.Clear;
  SitICM.Clear;
  SitIpi.Clear;

  PrIssLin := 0;
  PrInsLin := 0;
  PrIrfLin := 0;
  RedIssLin := 0;
  RedInsLin := 0;
  RetIssLin := '';
  RetPisLin := '';

  VlrUnt.Text := '0,00';
  AlinharDireitaValor(VlrUnt);
  VlrDesc.Text := '0,00';
  AlinharDireitaValor(VlrDesc);
  PercDesc.Text := '0,00';
  AlinharDireitaValor(PercDesc);
  Qtde.Text := '1,00';
  AlinharDireitaValor(Qtde);
  VlrTot.Text := '0,00';
  AlinharDireitaValor(VlrTot);
end;

procedure TF_Pedidos1.DBGrid1DblClick(Sender: TObject);
begin
  if (Caption <> 'Manutenção') and (Caption <> 'Incluir') then
    Exit;

  btConfItem.Caption := 'Confirma Alteraçao';
  btExcItem.Enabled := False;
  edtIdItem.Text := Nst(cdsItens['ID']);
  NroIte := StrZero(Trim(Nst(cdsItens['NRITEM'])), 4);
  CODPRO.Text := Nst(cdsItens['CODPRO']);
  CODPROD.Text := Nst(cdsItens['Descri']);
  edtObservacao.Text := Nst(cdsItens['OBSERVACAO']);
  CODTAB.Text := Nst(cdsItens['TAB']);
  NATOPR.Text := Nst(cdsItens['NATOPR']);
  CODOPR.Text := Nst(cdsItens['CODOPR']);
  CodTna.Text := Nst(cdsItens['CODTNA']);
  Qtde.Text := str(Nvl(cdsItens['QTDE']), DecPro);
  VlrDesc.Text := Nst(cdsItens['VLRDES']);
  PercDesc.Text := Nst(cdsItens['PERDES']);
  UNDPRO.Text := Nst(cdsItens['UND']);

  CODCST.Text := Nst(cdsItens['Cst']);
  edCstPis.Text := Nst(cdsItens['PISCst']);
  edCstCof.Text := Nst(cdsItens['COFCst']);
  EdCstIPI.Text := Nst(cdsItens['IPICst']);
  edCSOSN.Text := Nst(cdsItens['CSOSN']);
  prMVA.Text := str(Nvl(cdsItens['PrAdST']), Decimais);
  prIcm.Text := str(Nvl(cdsItens['Icms']), Decimais);
  edtPrIcmsSt.Text := str(Nvl(cdsItens['IcmsSt']), Decimais);
  prIPI.Text := str(Nvl(cdsItens['PerIPI']), Decimais);
  PrIssLin := Nvl(cdsItens['PrIss']);
  PrInsLin := Nvl(cdsItens['PrInss']);
  PrIrfLin := Nvl(cdsItens['PrIrf']);
  SitICM.Text := Nst(cdsItens['SitIcm']);
  SitIpi.Text := Nst(cdsItens['SitIpi']);
  prRedICM.Text := str(Nvl(cdsItens['RedIcm']), Decimais);
  RedIssLin := Nvl(cdsItens['RedIss']);
  RedInsLin := Nvl(cdsItens['RedInss']);
  RetIssLin := Nst(cdsItens['RetIss']);
  RetPisLin := Nst(cdsItens['RetPis']);

  AlinharDireitaValor(Qtde);
  VlrUnt.Text := str(Nvl(cdsItens['VLRUNT']), Decimais);

  AlinharDireitaValor(VlrUnt);
  VlrTot.Text := str(Nvl(cdsItens['QTDE']) * Nvl(cdsItens['VLRUNT']), Decimais);
  AlinharDireitaValor(VlrTot);

  CodProAnt := Nst(cdsItens['CODPRO']);
  QtdeAnt := Nvl(cdsItens['QTDE']);
  SaldoAnt := Nvl(cdsItens['SALDO']);
  VlrUntAnt := Nvl(cdsItens['VLRUNT']);

  CodTnaExit(CodTna);

  Qtde.SetFocus;
  Qtde.SelectAll;
end;

procedure TF_Pedidos1.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  DbgridZebra(cdsItens, DBGrid1, Rect, DataCol, Column, State);
end;

procedure TF_Pedidos1.ExcluiItens(AId: Integer);
begin
  T2.qC3.SQL.Clear;
  T2.qC3.SQL.Add('Delete From WTPEDIDOITEM Where IDTPEDIDO = ' + Nst(AId));
  T2.qC3.ExecSQL;
end;

procedure TF_Pedidos1.Gravar;
begin
  obPedidoWeb.setId(Ivl(edtId.Text));
  obPedidoWeb.setEmissao(StrToDate(Nst(Data.Text)));
  obPedidoWeb.setCodtcliente(Nst(Ped_CODCLI.Text));
  obPedidoWeb.setCodtcondpag(Nst(CODPAG.Text));
  obPedidoWeb.setCodttransporta(Nst(CODTRS.Text));
  obPedidoWeb.setCodtvendedor(Nst(CODVEN.Text));
  obPedidoWeb.setTipofrete(IntToStr(Frete.ItemIndex));
  obPedidoWeb.setContato(Contato.Text);

  obPedidoWeb.setValordesconto(Nvl(edtVlrDes.Text));
  obPedidoWeb.setValorfrete(Val(VlrFrete.Text));
  obPedidoWeb.setTotalpedido(Val(TotalOrc.Text));
  obPedidoWeb.setObservacaonf(Obs.Text);
  obPedidoWeb.setObservacaoint(ObsInt.Text);
  obPedidoWeb.setOrdemcompra(edtOrdemCompra.Text);
  obPedidoWeb.setBasest(Nvl(edtBasSub.Text));
  obPedidoWeb.setValorst(Nvl(edtVlrSub.Text));
  obPedidoWeb.setBaseipi(Nvl(edtBasIpi.Text));
  obPedidoWeb.setValoripi(Nvl(edtVlrIpi.Text));
  obPedidoWeb.setBaseicms(Nvl(edtBasIcm.Text));
  obPedidoWeb.setValoricms(Nvl(edtVlrIcm.Text));
  obPedidoWeb.setValorpisret(Nvl(edtRetPis.Text));
  obPedidoWeb.setValorcofinsret(Nvl(edtRetCof.Text));
  obPedidoWeb.setValorcsl(Nvl(edtRetCsl.Text));
  obPedidoWeb.setValorissret(Nvl(edtRetIss.Text));
  obPedidoWeb.setValoricmssuf(Nvl(edtSufIcms.Text));
  obPedidoWeb.setValorpissuf(Nvl(edtSufPis.Text));
  obPedidoWeb.setValorcofinssuf(Nvl(edtSufCof.Text));
  obPedidoWeb.setValoripisuf(Nvl(edtSufIpi.Text));
  obPedidoWeb.setValorirf(Nvl(edtVlrIrf.Text));
  obPedidoWeb.Salvar;

  GravaItens;
end;

function TF_Pedidos1.GeraFaturamento(lCodNat, lCodVar: String): Boolean;
begin
  Result := False;

  if SetKeyDL(T2.qC1, 'SlfaNto', ['Nt_Cfo', 'Nt_Opc'], [lCodNat, lCodVar], 'Nt_GerDup') then
    Result := Nst(T2.qC1['Nt_GerDup']) = 'S'; // Natureza gera faturamento
end;

procedure TF_Pedidos1.GravaItens;
begin
  if (Caption = 'Manutenção') and (Trim(edtId.Text) <> '') then
    ExcluiItens(Ivl(edtId.Text));

  cdsItens.First;

  While not cdsItens.Eof do
  begin
    obItemPedidoWeb.setIdtpedido(Ivl(edtId.Text));

    if Ivl(cdsItens['ID']) > 0 then
      obItemPedidoWeb.setId(Ivl(cdsItens['ID']))
    else
      obItemPedidoWeb.setId(obItemPedidoWeb.Auto_inc_id(1));

    obItemPedidoWeb.setIdweb(Ivl(cdsItens['IdWeb']));
    obItemPedidoWeb.setCodtproduto(Nst(cdsItens['CODPRO']));
    // obItemPedidoWeb.setCompldescricao(Nst(cdsItens['Descri']));
    obItemPedidoWeb.setObservacao(Nst(cdsItens['OBSERVACAO']));
    obItemPedidoWeb.setCodttabpreco(Nst(cdsItens['TAB']));
    obItemPedidoWeb.setQuantidade(Nvl(cdsItens['QTDE']));
    obItemPedidoWeb.setVlroriginal(Nvl(cdsItens['VLRORG']));
    obItemPedidoWeb.setVlrunitario(Nvl(cdsItens['VLRUNT']));
    obItemPedidoWeb.setCfoptcadcfop(Nst(cdsItens['NATOPR']));
    obItemPedidoWeb.setVartcadcfop(Nst(cdsItens['CODOPR']));
    obItemPedidoWeb.setValordescitem(Nvl(cdsItens['VLRDES']));
    obItemPedidoWeb.setPrdescitem(Nvl(cdsItens['PERDES']));
    obItemPedidoWeb.setTotalproduto(Nvl(cdsItens['VLRTOT']));

    obItemPedidoWeb.setCsticms(Nst(cdsItens['Cst']));
    obItemPedidoWeb.setCstpis(Nst(cdsItens['PISCst']));
    obItemPedidoWeb.setCstcofins(Nst(cdsItens['COFCst']));
    obItemPedidoWeb.setCstipi(Nst(cdsItens['IPICst']));
    obItemPedidoWeb.setCsosn(Nst(cdsItens['CSOSN']));
    obItemPedidoWeb.setPrmva(Nvl(cdsItens['PrAdST']));
    obItemPedidoWeb.setPricms(Nvl(cdsItens['Icms']));
    obItemPedidoWeb.setPricmsst(Nvl(cdsItens['IcmsSt']));
    obItemPedidoWeb.setPrredicms(Nvl(cdsItens['RedIcm']));
    obItemPedidoWeb.setPripi(Nvl(cdsItens['PerIPI']));
    obItemPedidoWeb.setPriss(Nvl(cdsItens['PrIss']));
    obItemPedidoWeb.setPrinss(Nvl(cdsItens['PrInss']));
    obItemPedidoWeb.setPrirf(Nvl(cdsItens['PrIrf']));
    obItemPedidoWeb.setBasest(Nvl(cdsItens['BasSub']));
    obItemPedidoWeb.setValorst(Nvl(cdsItens['VlrSub']));
    obItemPedidoWeb.setBaseipi(Nvl(cdsItens['BasIpiLin']));
    obItemPedidoWeb.setValoripi(Nvl(cdsItens['VlrIpi']));
    obItemPedidoWeb.setBaseicms(Nvl(cdsItens['BasIcmLin']));
    obItemPedidoWeb.setValoricms(Nvl(cdsItens['VlrIcmLin']));

    obItemPedidoWeb.setRetiss(Nst(cdsItens['RetIss']));
    obItemPedidoWeb.setRetpis(Nst(cdsItens['RetPis']));

    obItemPedidoWeb.setValorpisret(Nvl(cdsItens['VlrRetPis']));
    obItemPedidoWeb.setValorcofinsret(Nvl(cdsItens['VlrRetCof']));
    obItemPedidoWeb.setValorcsl(Nvl(cdsItens['VlrRetCsl']));
    obItemPedidoWeb.setValorissret(Nvl(cdsItens['VlrRetIss']));
    obItemPedidoWeb.setValoricmssuf(Nvl(cdsItens['SufIcm']));
    obItemPedidoWeb.setValorpissuf(Nvl(cdsItens['SufPis']));
    obItemPedidoWeb.setValorcofinssuf(Nvl(cdsItens['SufCof']));
    obItemPedidoWeb.setValoripisuf(Nvl(cdsItens['SufIpi']));
    obItemPedidoWeb.setValorirf(Nvl(cdsItens['VlrIrf']));

    obItemPedidoWeb.Incluir;

    cdsItens.Next;
  end;
end;

procedure TF_Pedidos1.Mostra;
var
  obPedidoFull: TWTPedidoFull;
begin
  Try
    if Caption <> 'Duplicar' then
    begin
      edtId.Text := Nst(obPedidoWeb.getId);
      Data.Text := datetostr(obPedidoWeb.getEmissao);
    end;

    Ped_CODCLI.Text := obPedidoWeb.getCodtcliente;
    Ped_CODCLIExit(Ped_CODCLI);
    CODPAG.Text := obPedidoWeb.getCodtcondpag;
    CODVEN.Text := obPedidoWeb.getCodtvendedor;
    CODTRS.Text := obPedidoWeb.getCodttransporta;

    Frete.ItemIndex := StrToIntDef(obPedidoWeb.getTipofrete, 3);
    Contato.Text := obPedidoWeb.getContato;
    edtSituacao.Text := obPedidoFull.GetStatusDescri(obPedidoWeb.getStatus);

    if obPedidoWeb.getStatus = '2' then
    begin
      lblAviso.Caption := 'Cancelado';
      lblAviso.Visible := True;
    end
    else if not obPedidoWeb.getCodigoint.IsEmpty then
    begin
      lblAviso.Caption := 'Gerou venda';
      lblAviso.Visible := True;
    end
    else
      lblAviso.Visible := False;

    Obs.Text := obPedidoWeb.getObservacaonf;
    ObsInt.Text := obPedidoWeb.getObservacaoint;
    edtOrdemCompra.Text := obPedidoWeb.getOrdemcompra;
    VlrFrete.Text := str(obPedidoWeb.getValorfrete, Decimais);
    edtVlrDes.Text := Str(obPedidoWeb.getValordesconto, Decimais);

    if (cdsItens.Active) then
      cdsItens.EmptyDataSet
    else
      CriaTemp;

    MostraItens(obPedidoWeb.getId);

    NomeCap := Caption;
    CriaCdsTempServico(cdsServicos);
  Finally
    obPedidoFull.Free;
  End;
end;

procedure TF_Pedidos1.MostraItens(AId: Integer);
var
  Q: String;
  TotalProdutos, TotalServicos, TotalProdComICMS, TotalProdComPis, TotalProdComCof, TotalFaturar: Currency;
  GeraFinGeral: Boolean;
begin
  LimpaItens;

  Q := 'Select ID, IDWEB, CodTProduto, CodTTabPreco, Quantidade, VlrOriginal, VlrUnitario, TotalProduto, PRO_CODBAR,';
  Q := Q + sLineBreak + 'Pro_Descri as Descricao, CstIcms, CstPis, CstCofins, CstIpi, Csosn, PrMva,';
  Q := Q + sLineBreak + 'PrIcms, PrIcmsSt, PrIpi, PrIss, PrInss, PrIrf, PrRedIcms, WTPedidoItem.Observacao,';
  Q := Q + sLineBreak + 'RetIss, RetPis, BaseST, ValorSt, BaseIpi, ValorIpi, BaseIcms, ValorIcms,';
  Q := Q + sLineBreak + 'ValorPisRet, ValorCofinsRet, ValorIssRet, ValorCsl, ValorIrf, ValorIcmsSuf, ValorPisSuf, ValorCofinsSuf, ValorIpiSuf,';
  Q := Q + sLineBreak + 'PRO_REDUT, CfopTCadCfop, VarTCadCfop, Nt_CodTna, PrDescItem, ValorDescItem, Pro_Und';
  Q := Q + sLineBreak + 'FROM WTPedidoItem';
  Q := Q + sLineBreak + 'Left Join EstaPro on Pro_Codigo = CodTProduto';
  Q := Q + sLineBreak + 'Left Join SlfaNto on Nt_Cfo = CfopTCadCfop and Nt_Opc = VarTCadCfop';
  Q := Q + sLineBreak + 'Where IdTPedido = ' + Nst(AId);
  Q := Q + sLineBreak + 'Order By ID';

  T2.cdsC2.Active := False;
  T2.qC2.Close;
  T2.qC2.SQL.Clear;
  T2.qC2.SQL.Add(Q);
  T2.cdsC2.Active := True;
  T2.cdsC2.First;

  While not T2.cdsC2.Eof do
  begin
    cdsItens.Append;
    cdsItens['ID'] := Ivl(T2.cdsC2['ID']);
    cdsItens['IDWEB'] := Ivl(T2.cdsC2['IDWEB']);
    cdsItens['NRITEM'] := StrZero(Nst(T2.cdsC2.RecNo), 4);
    cdsItens['CODPRO'] := Trim(Nst(T2.cdsC2['CodTProduto']));
    cdsItens['OBSERVACAO'] := Trim(Nst(T2.cdsC2['OBSERVACAO']));
    cdsItens['BARRAS'] := Trim(Nst(T2.cdsC2['PRO_CODBAR']));
    cdsItens['REDUT'] := Nst(T2.cdsC2['PRO_REDUT']);
    cdsItens['DESCRI'] := Trim(Nst(T2.cdsC2['Descricao']));
    cdsItens['TAB'] := Trim(Nst(T2.cdsC2['CodTTabPreco']));
    cdsItens['VLRORG'] := str(Nvl(T2.cdsC2['VlrOriginal']), Decimais);
    cdsItens['VLRUNT'] := str(Nvl(T2.cdsC2['VlrUnitario']), Decimais);
    cdsItens['QTDE'] := str(Nvl(T2.cdsC2['Quantidade']), DecPro);
    cdsItens['VLRTOT'] := str(Nvl(T2.cdsC2['TotalProduto']), Decimais);
    cdsItens['NATOPR'] := Nst(T2.cdsC2['CfopTCadCfop']);
    cdsItens['CODOPR'] := Nst(T2.cdsC2['VarTCadCfop']);
    cdsItens['CODTNA'] := Nst(T2.cdsC2['Nt_CodTna']);
    cdsItens['VLRDES'] := str(Nvl(T2.cdsC2['ValorDescItem']), Decimais);
    cdsItens['PERDES'] := str(Nvl(T2.cdsC2['PrDescItem']), Decimais);
    cdsItens['UND'] := Nst(T2.cdsC2['Pro_Und']);

    cdsItens['Cst'] := Nst(T2.cdsC2['CstIcms']);
    cdsItens['PISCst'] := Nst(T2.cdsC2['CstPis']);
    cdsItens['COFCst'] := Nst(T2.cdsC2['CstCofins']);
    cdsItens['IPICst'] := Nst(T2.cdsC2['CstIpi']);
    cdsItens['CSOSN'] := Nst(T2.cdsC2['Csosn']);
    cdsItens['PrAdST'] := Nvl(T2.cdsC2['PrMva']);
    cdsItens['Icms'] := Nvl(T2.cdsC2['PrIcms']);
    cdsItens['IcmsSt'] := Nvl(T2.cdsC2['PrIcmsSt']);
    cdsItens['PerIPI'] := Nvl(T2.cdsC2['PrIpi']);
    cdsItens['PrIss'] := Nvl(T2.cdsC2['PrIss']);
    cdsItens['PrInss'] := Nvl(T2.cdsC2['PrInss']);
    cdsItens['PrIrf'] := Nvl(T2.cdsC2['PrIrf']);
    // cdsItens['SitIcm'] := Nst(T2.cdsC2['Ite_SitIcm']);
    // cdsItens['SitIpi'] := Nvl(T2.cdsC2['Ite_SitIpi']);
    cdsItens['RedIcm'] := Nvl(T2.cdsC2['PrRedIcms']);
    // cdsItens['RedIss'] := Nvl(T2.cdsC2['Ite_RedIss']);
    // cdsItens['RedInss'] := Nvl(T2.cdsC2['Ite_RedIns']);
    cdsItens['RetIss'] := Nst(T2.cdsC2['RetIss']);
    cdsItens['RetPis'] := Nst(T2.cdsC2['RetPis']);
    cdsItens['BasSub'] := Nvl(T2.cdsC2['BaseSt']);
    cdsItens['VlrSub'] := Nvl(T2.cdsC2['ValorSt']);
    cdsItens['BasIpiLin'] := Nvl(T2.cdsC2['BaseIpi']);
    cdsItens['VlrIpi'] := Nvl(T2.cdsC2['ValorIpi']);
    cdsItens['BasIcmLin'] := Nvl(T2.cdsC2['BaseIcms']);
    cdsItens['VlrIcmLin'] := Nvl(T2.cdsC2['ValorIcms']);
    cdsItens['VlrRetPis'] := Nvl(T2.cdsC2['ValorPisRet']);
    cdsItens['VlrRetCof'] := Nvl(T2.cdsC2['ValorCofinsRet']);
    cdsItens['VlrRetCsl'] := Nvl(T2.cdsC2['ValorCsl']);
    cdsItens['VlrRetIss'] := Nvl(T2.cdsC2['ValorIssRet']);
    cdsItens['SufIcm'] := Nvl(T2.cdsC2['ValorIcmsSuf']);
    cdsItens['SufPis'] := Nvl(T2.cdsC2['ValorPisSuf']);
    cdsItens['SufCof'] := Nvl(T2.cdsC2['ValorCofinsSuf']);
    cdsItens['SufIpi'] := Nvl(T2.cdsC2['ValorIpiSuf']);
    cdsItens['VlrIrf'] := Nvl(T2.cdsC2['ValorIrf']);

    cdsItens.Post;

    T2.cdsC2.Next;
  end;

  cdsItens.First;
  RecalcItend(TotalProdutos, TotalServicos, TotalProdComICMS, TotalProdComPis, TotalProdComCof, TotalFaturar, GeraFinGeral);
end;

procedure TF_Pedidos1.CriaTemp;
begin
  if cdsItens.Active then
  begin
    cdsItens.EmptyDataSet;
    Exit;
  end;

  cdsItens.Close;
  with cdsItens.FieldDefs do
  begin
    Clear;
    Add('NRITEM', ftString, 4, False);
    Add('NAOFAT', ftString, 1, False);
    Add('CODPRO', ftString, 10, False);
    Add('OBSERVACAO', ftString, 300, False);
    Add('BARRAS', ftString, 13, False);
    Add('REDUT', ftString, 10, False);
    Add('DESCRI', ftString, TamDef(T2.qSepeDic, 'VENAIPD', 'IPD_DESCRI'), False);
    Add('SALDO', ftFloat, 0, False);
    Add('VLRTOT', ftFloat, 0, False);
    Add('ALX', ftString, 3, False);
    Add('TAB', ftString, 4, False);
    Add('Und', ftString, 3, False);
    Add('TAB2', ftString, 4, False);
    Add('QTDE', ftFloat, 0, False);
    Add('VLRUNT', ftFloat, 0, False);
    Add('VLRACR', ftFloat, 0, False);
    Add('PERDES', ftFloat, 0, False);
    Add('VLRDES', ftFloat, 0, False);
    Add('VLRLIQ', ftFloat, 0, False);
    Add('ICMS', ftFloat, 0, False);
    Add('ICMSST', ftFloat, 0, False);
    Add('NATOPR', ftString, 4, False);
    Add('CODOPR', ftString, 2, False);
    Add('PERIPI', ftFloat, 0, False);
    Add('VLRIPI', ftFloat, 0, False);
    Add('VLRORG', ftFloat, 0, False);
    Add('VLRORG2', ftFloat, 0, False);
    Add('VLRORG3', ftFloat, 0, False);
    Add('VLRORG4', ftFloat, 0, False);

    Add('PONTOS', ftInteger, 0, False);
    Add('DescPto', ftFloat, 0, False);
    Add('DescPrm', ftFloat, 0, False);

    Add('CST', ftString, 3, False);
    Add('CONTA', ftString, 10, False);
    Add('CCUSTO', ftString, 10, False);
    Add('REDICM', ftFloat, 0, False);
    Add('OBSITEM', ftString, TamDef(T2.qSepeDic, 'VENAIPD', 'IPD_OBS'), False);

    Add('BasIPILin', ftFloat, 0, False);
    Add('BasICMLin', ftFloat, 0, False);
    Add('VlrIcmLin', ftFloat, 0, False);
    Add('RedBasLin', ftFloat, 0, False);
    Add('IseIcm', ftFloat, 0, False);
    Add('OutIcm', ftFloat, 0, False);

    Add('VlrSub', ftFloat, 0, False);
    Add('BasSub', ftFloat, 0, False);
    Add('PrSub', ftFloat, 0, False);
    Add('PrAdST', ftFloat, 0, False);
    Add('RatICM', ftFloat, 0, False);
    Add('RatIPI', ftFloat, 0, False);

    Add('CODSRV', ftString, 10, False);
    Add('NRSERIAL', ftString, 25, False);

    Add('IPICST', ftString, 2, False);
    Add('CSOSN', ftString, 3, False);

    Add('PISCST', ftString, 2, False);
    Add('COFCST', ftString, 2, False);
    Add('VlrPis', ftFloat, 0, False);
    Add('VlrCof', ftFloat, 0, False);

    Add('BPisCof', ftFloat, 0, False);
    Add('AlqPis', ftFloat, 0, False);
    Add('AlqCof', ftFloat, 0, False);

    Add('SufIcm', ftFloat, 0, False);
    Add('SufPis', ftFloat, 0, False);
    Add('SufCof', ftFloat, 0, False);
    Add('SufIpi', ftFloat, 0, False);

    Add('IteDev', ftString, 1, False);

    Add('SitICM', ftString, 1, False);
    Add('SitIPI', ftString, 1, False);

    Add('CodTna', ftString, 3, False);
    Add('SerNfDev', ftString, 4, False);
    Add('NumNfDev', ftString, 7, False);

    Add('DSP01', ftString, 2, False);
    Add('DSP02', ftString, 2, False);
    Add('DSP03', ftString, 2, False);
    Add('DSP04', ftString, 2, False);

    Add('PrIss', ftFloat, 0, False);
    Add('RedIss', ftFloat, 0, False);
    Add('BasIss', ftFloat, 0, False);
    Add('VlrIss', ftFloat, 0, False);

    Add('PrInss', ftFloat, 0, False);
    Add('RedInss', ftFloat, 0, False);
    Add('BasInss', ftFloat, 0, False);
    Add('VlrInss', ftFloat, 0, False);

    Add('PrIrf', ftFloat, 0, False);
    Add('BasIrf', ftFloat, 0, False);
    Add('VlrIrf', ftFloat, 0, False);

    Add('RetIss', ftString, 1, False);
    Add('RetPis', ftString, 1, False);

    Add('DEVQTD', ftFloat, 0, False);
    Add('DEVITE', ftString, 10, False);
    Add('DEVFOR', ftString, 6, False);

    Add('RATDES', ftFloat, 0, False);
    Add('RATACR', ftFloat, 0, False);
    Add('RATFRT', ftFloat, 0, False);
    Add('RATSEG', ftFloat, 0, False);
    Add('RATOUT', ftFloat, 0, False);

    Add('QTDCONV', ftFloat, 0, False);
    Add('QTDCNV', ftFloat, 0, False);

    Add('UsrDesc', ftString, 10, False);
    Add('JustDesc', ftString, 50, False);
    Add('NCM', ftString, 10, False);
    Add('OrigRetIss', ftString, 1, False);

    Add('VRetPis', ftFloat, 0, False);
    Add('VRetCof', ftFloat, 0, False);
    Add('VRetCsl', ftFloat, 0, False);

    Add('VlrRetPis', ftFloat, 0, False);
    Add('VlrRetCof', ftFloat, 0, False);
    Add('VlrRetCsl', ftFloat, 0, False);
    Add('VlrRetIss', ftFloat, 0, False);
    Add('ID', ftInteger, 0, False);
    Add('IDWEB', ftInteger, 0, False);
  end;

  cdsItens.CreateDataSet;
  cdsItens.IndexDefs.Clear;
  cdsItens.IndexDefs.Add('cdsIndex', 'NRITEM', [ixPrimary]);
  cdsItens.IndexName := 'cdsIndex';
  cdsItens.Open;
end;

procedure TF_Pedidos1.DefaultOrcamento;
begin
  edtId.Clear;
  Ped_CODCLI.Clear;
  CODPAG.Clear;
  CODTRS.Clear;
  CODVEN.Clear;
  Data.Text := datetostr(Date);
  VlrFrete.Text := '0,00';
  edtVlrDes.Text := '0,00';
  Frete.ItemIndex := 0;
  TotalOrc.Text := '0,00';
  edtBasIcm.Text := '0,00';
  edtVlrIcm.Text := '0,00';
  edtBasSub.Text := '0,00';
  edtVlrSub.Text := '0,00';
  edtBasIpi.Text := '0,00';
  edtVlrIpi.Text := '0,00';
  edtRetPis.Text := '0,00';
  edtRetCof.Text := '0,00';
  edtRetCsl.Text := '0,00';
  edtRetIss.Text := '0,00';
  edtSufIcms.Text := '0,00';
  edtSufPis.Text := '0,00';
  edtSufCof.Text := '0,00';
  edtSufIpi.Text := '0,00';
  edtVlrIrf.Text := '0,00';

  CODTRSD.Clear;
  LimpaItens;

  T2.cdsC2.Active := False;
  T2.qC2.Close;
  T2.qC2.SQL.Clear;
  T2.qC2.SQL.Add('Select * from SepeDic');
  T2.qC2.SQL.Add('Where DIC_ARQNOM = ''ORCACAB''');
  T2.qC2.SQL.Add('Order By DIC_CAMPO');
  T2.cdsC2.Active := True;

  Ped_CODCLI.Text := ValDef(T2.cdsC2, 'ORCACAB', 'CAB_CODCLI');
  CODPAG.Text := ValDef(T2.cdsC2, 'ORCACAB', 'CAB_CODPAG');
  CODTRS.Text := ValDef(T2.cdsC2, 'ORCACAB', 'CAB_CODTRS');
  CODVEN.Text := ValDef(T2.cdsC2, 'ORCACAB', 'CAB_CODVEN');
  try
    Frete.ItemIndex := StrToInt(ValDef(T2.cdsC2, 'ORCACAB', 'CAB_TPOFRE'))
  except
  end;

  Data.Text := datetostr(Date);
  Ender.Clear;
  Cidade.Clear;
  uf.Clear;
  Obs.Clear;
  Fone.Clear;
  ObsInt.Clear;
end;

procedure TF_Pedidos1.DefaultItem;
begin
  LimpaItens;

  T2.cdsC2.Active := False;
  T2.qC2.Close;
  T2.qC2.SQL.Clear;
  T2.qC2.SQL.Add('Select * from SepeDic');
  T2.qC2.SQL.Add('Where DIC_ARQNOM = ''ORCAITE''');
  T2.qC2.SQL.Add('Order By DIC_CAMPO');
  T2.cdsC2.Active := True;

  CODPRO.Text := ValDef(T2.cdsC2, 'WTPEDIDOITEM', 'CodTProduto');
  CODTAB.Text := ValDef(T2.cdsC2, 'WTPEDIDOITEM', 'CodTTabPreco');
  NATOPR.Text := ValDef(T2.cdsC2, 'WTPEDIDOITEM', 'CfopTCadCfop');
  CODOPR.Text := ValDef(T2.cdsC2, 'WTPEDIDOITEM', 'VarTCadCfop');
  CodTna.Text := ValDef(T2.cdsC2, 'CADATNA', 'TNA_CODIGO');
  Qtde.Text := ValDef(T2.cdsC2, 'WTPEDIDOITEM', 'Quantidade');
  AlinharDireitaValor(Qtde);
end;

procedure TF_Pedidos1.VisualizarClick(Sender: TObject; Button: TNavigateBtn);
begin
  obPedidoWeb.setId(Ivl(T2.cdsgWtpedido['ID']));
  if (obPedidoWeb.Consultar) then
    Mostra;
end;

procedure TF_Pedidos1.TotalOrcEnter(Sender: TObject);
begin
  (Sender as TEdit).Text := Trim((Sender as TEdit).Text);
  (Sender as TEdit).SelectAll;
end;

procedure TF_Pedidos1.TotalOrcKeyPress(Sender: TObject; var Key: Char);
begin
  Key := SoValor((Sender as TEdit), Key);
end;

function TF_Pedidos1.TotLinhasObs(Obs: String): Integer;
var
  i, TotLin: Integer;
begin
  Result := 0;

  if Obs = '' then
    Exit;

  TotLin := 1;

  i := Pos(#13, Obs);
  while i > 0 do
  begin
    TotLin := TotLin + 1;
    Delete(Obs, i, 2);
    i := Pos(#13, Obs);
  end;

  Result := TotLin;
end;

procedure TF_Pedidos1.NATOPRExit(Sender: TObject);
begin
  // tem que obrigatorimente passar por este campo antes de prosseguir, para garantir a consistencia do processo
  CODOPR.SetFocus;
end;

procedure TF_Pedidos1.NATOPRKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Q: String;
begin

  // qdo tem a tributação pelo NCM não permite alterar a natureza
  if TemNCMxTrib then
    Exit;

  if Key = VK_F4 then
  begin
    Q := 'Select Nt_Cfo Cfo,Nt_Opc Opc,Nt_Descfo Descricao, Nt_AtuEst Est, Nt_GerDup Dup, Nt_Cst Cst ';
    Q := Q + #13 + 'From SlFanto';
    Q := Q + #13 + 'Where NT_Ativo  = ''S'' ';
    Q := Q + #13 + 'and   Nt_Cfo    > ''500''';
    Q := Q + #13 + 'and   Nt_CodTna = ' + #39 + CodTna.Text + #39;

    if ConsultaDl(T2.WsepeDBX, Q, 'Cfo;Opc', 'Consulta de Naturezas') then
    begin
      NATOPR.Text := consulta.getValor('Cfo');
      CODOPR.Text := consulta.getValor('Opc');
      NatOprD.Text := consulta.getValor('Descricao');
    end;
  end;
end;

procedure TF_Pedidos1.ObsEnter(Sender: TObject);
begin
  KeyPreview := False;
end;

procedure TF_Pedidos1.ObsExit(Sender: TObject);
begin
  KeyPreview := True;
end;

procedure TF_Pedidos1.CODOPRChange(Sender: TObject);
begin
  obNatureza.setNt_cfo(NATOPR.Text);
  obNatureza.setNt_opc(CODOPR.Text);
  if obNatureza.Consultar then
  begin
    NatOprD.Text := obNatureza.getNt_descfo;
  end;
end;

procedure TF_Pedidos1.CODOPRExit(Sender: TObject);
begin
  PodeConfirmarItem := False;

  VerificarNatOpr('exit');
  if (not InfValorServico) then
    if not TestaDoacao then
      CODPRO.SetFocus;

  // Quando é um serviço confirma o item direto
  if PodeConfirmarItem then
    btConfItemClick(btConfItem);
end;

function TF_Pedidos1.VerificaTributacao(ExigeTribCorreta: Boolean): Boolean;
var
  cCST, cPis, cCof, cIPI, cCSOSN, cEnq: string;
  alICM: Currency;

begin
  Result := False;

  // se TrbNcm estivar ativo só busca nessa rotina os códigos de CST
  // isso é util para os casos em que não existe nenhuma aliquota de tributação (ex. saidas p/demostração)
  if TrbNCM = 'S' then
  begin
    CODCST.Text := obNatureza.getNt_cst;
    edCstPis.Text := obNatureza.getNt_cstpis;
    edCstCof.Text := obNatureza.getNt_cstcofi;
    EdCstIPI.Text := obNatureza.getNt_cstIpi;
    edCSOSN.Text := obNatureza.getNt_csosn;

    SitICM.Text := TribICMS(CODCST.Text);
    SitIpi.Text := TribIPI(EdCstIPI.Text);

    // devida a variedade de uso do CST 90 e a possibilidade do CST 51 ter diferimento parcial,
    // pode ser inf separadamente se a operação é tributada, isente ou outras
    if ((Copy(CODCST.Text, 2, 2) = '51') or (Copy(CODCST.Text, 2, 2) = '90')) and (obNatureza.getNt_siticm >= '1') and (obNatureza.getNt_siticm <= '3') then
      SitICM.Text := obNatureza.getNt_siticm;

    Result := True;
    Exit;
  end;

  // O CÓDIGO DO CST DEVER SER DE ACORDO COM O TIPO DE OPERAÇÃO
  PesquisaCST(CODPRO.Text, NATOPR.Text, CODOPR.Text, CodTna.Text, obNatureza, obProxCst, cCST, cPis, cCof, cIPI, cCSOSN, cEnq);
  CODCST.Text := cCST;
  edCstPis.Text := cPis;
  edCstCof.Text := cCof;
  EdCstIPI.Text := cIPI;
  edCSOSN.Text := cCSOSN;

  Application.ProcessMessages;

  if ExigeTribCorreta then
    if (Trim(CODCST.Text) = '') or (Trim(edCstPis.Text) = '') or (Trim(edCstCof.Text) = '') or (Trim(EdCstIPI.Text) = '') then
    begin
      DL_Msg('Verifique os códigos do CST do ICMS/PIS/COFINS/IPI, no cadastro de produtos e/ou natureza de operação', 'Aviso', 'Aviso');
      if btConfItem.Caption <> 'Confirmar Alteração' then
        CODPRO.SetFocus;
      Exit;
    end;

  SitICM.Text := TribICMS(CODCST.Text);
  SitIpi.Text := TribIPI(EdCstIPI.Text);

  // devida a variedade de uso do CST 90 e a possibilidade do CST 51 ter diferimento parcial,
  // pode ser inf separadamente se a operação é tributada, isente ou outras
  if ((Copy(CODCST.Text, 2, 2) = '51') or (Copy(CODCST.Text, 2, 2) = '90')) and (obNatureza.getNt_siticm >= '1') and (obNatureza.getNt_siticm <= '3') then
    SitICM.Text := obNatureza.getNt_siticm;

  Application.ProcessMessages;

  if ExigeTribCorreta and (SitICM.Text = '') then
  begin
    DL_Msg('O código do CST ICMS está incorreto.', 'Aviso', 'Aviso');
    if btConfItem.Caption <> 'Confirmar Alteração' then
      CODPRO.SetFocus;
    Exit;
  end;

  prIcm.Text := '0';
  // so pesquisa aliq ICMS se for tributado
  if SitICM.Text = '1' then
  begin
    // Aliq ICMS
    alICM := BuscaICMS(NATOPR.Text, CODOPR.Text, CODPRO.Text, obClientes, obProduto, False);
    if alICM < 0 then
    begin
      if btConfItem.Caption <> 'Confirmar Alteração' then
        CODPRO.SetFocus;
      Exit;
    end;

    prIcm.Text := str(alICM, 0);
  end;

  // % redução base de calculo do ICMS
  prRedICM.Text := str((BuscaRedBase(NATOPR.Text + '.' + CODOPR.Text, CODPRO.Text)), Decimais);

  if ExigeTribCorreta and (SitIpi.Text = '') then
  begin
    DL_Msg('O código do CST IPI está incorreto.', 'Aviso', 'Aviso');
    if btConfItem.Caption <> 'Confirmar Alteração' then
      CODPRO.SetFocus;
    Exit;
  end;

  prIPI.Text := '0';
  if EdCstIPI.Text = '50' then
  begin
    if ExigeTribCorreta and (obProduto.getPro_ipi = 0) then
    begin
      DL_Msg('O percentual de IPI deste produto deve ser maior que zero.', 'Aviso', 'Aviso');
      if btConfItem.Caption <> 'Confirmar Alteração' then
        CODPRO.SetFocus;
      Exit;
    end;
    prIPI.Text := str(obProduto.getPro_ipi, Decimais);
  end;

  Application.ProcessMessages;
  Result := True;
end;

function TF_Pedidos1.BuscaRedBase(NATOPR, CodProduto: String): Real;
var
  Achou: Boolean;
  TemInsEst: String;
begin
  // se existir uma redução no cadastro da natureza, usa esta e não faz a pesquisa na
  // tabela de reduções
  if Nvl(obNatureza.getNt_redicm) > 0 then
  begin
    Result := Nvl(obNatureza.getNt_redicm);
    Exit;
  end;

  if (Length(Trim(Nst(obClientes.getCli_insest))) > 0) and (not Pertence('ISE', Nst(obClientes.getCli_insest))) then
    TemInsEst := '2' // tem inscricao
  else
    TemInsEst := '1'; // nao tem inscricao

  Achou := False;
  Result := 0;

  // pesquisa pela uf o cliente e codigo do produto
  SetKeyDL(T2.qC2, 'SlfaRed', ['RED_UF', 'RED_CODPRO'], [obClientes.getCli_uf, CodProduto]);

  while (Nst(T2.qC2['RED_UF']) = obClientes.getCli_uf) and (Nst(T2.qC2['RED_CODPRO']) = CodProduto) and (not T2.qC2.Eof) and (not Achou) do
  begin
    if ((Pertence(NATOPR, Nst(T2.qC2['RED_NATOPR'])) or (Trim(Nst(T2.qC2['RED_NATOPR'])) = 'TODAS'))) and ((TemInsEst = Nst(T2.qC2['RED_CLI'])) or (Nst(T2.qC2['RED_CLI']) = '3')) then
    begin
      Result := Nvl(T2.qC2['RED_REDBAS']);
      Achou := True;
    end
    else
      T2.qC2.Next;
  end;
end;

function TF_Pedidos1.BuscaContatoComp(CodCli: String): String;
var
  Q: String;
begin
  Result := '';

  Q := 'Select Ctn_Nome From CadaCtn';
  Q := Q + #10#13 + 'Where Ctn_Setor  = ''2'''; // Compras
  Q := Q + #10#13 + 'and   Ctn_Codigo = :Codigo';

  T2.cdsC4.Active := False;
  T2.qC4.Close;
  T2.qC4.SQL.Clear;
  T2.qC4.SQL.Add(Q);
  T2.qC4.ParamByName('Codigo').AsString := CodCli;
  T2.cdsC4.Active := True;

  T2.cdsC4.First;

  if not T2.cdsC4.IsEmpty then
    Result := Nst(T2.cdsC4['Ctn_Nome']);
end;

{ Function TF_Orc1.CadastroAtualizado(UltAtu: TDate):Boolean;
  var
  Dias: Integer;
  begin
  Result:= True;

  if (Nvl(UltAtu) <> 0) then
  begin
  Dias := DaysBetween(Date, UltAtu);
  if Dias > RevCli then
  begin
  DL_Msg('O cadastro deste cliente não é atualizado a ' + Nst(Dias) + ' dias.'+#10#13+'Acesse o cadastro e faça a atualização.','Atenção','Aviso');
  Result:= False;
  end;
  end
  else
  begin
  DL_Msg('O cadastro deste cliente não está atualizado.','Atenção','Aviso');
  Result:= False;
  end;
  end;

  function TF_Orc1.AvisaCliIncompleto: Boolean;
  begin
  Result := True;

  if FatInc = 'A'
  then DL_Msg('Cliente com cadastro incompleto.'+#10#13+'Acesse o cadastro para fazer os ajustes.','Atenção','Aviso');

  if FatInc= 'P'
  then if MessageBox(Handle, 'Cliente com cadastro incompleto.'+#10#13+'Acesse o cadastro para fazer os ajustes.' + #10#13 + 'Desejas continuar sem os ajustes?', PChar(Application.Title), MB_ICONQUESTION + MB_YESNO) = mrNo
  then Result := False;

  if FatInc = 'B' then
  begin
  DL_Msg('Cliente com cadastro incompleto.'+#10#13+'Acesse o cadastro para fazer os ajustes.','Atenção','Aviso');
  Result := False;
  end;
  end; }

procedure TF_Pedidos1.CarregaContatos;
begin
  T2.cdsC3.Active := False;
  T2.qC3.Close;
  T2.qC3.SQL.Clear;
  T2.qC3.SQL.Add('SELECT CTN_NOME, CTN_SETOR, CTN_EMAIL FROM CADACTN WHERE CTN_TIPO = ''C'' AND CTN_CODIGO = ' + #39 + Trim(Ped_CODCLI.Text) + #39);
  T2.cdsC3.Active := True;

  Contato.Items.Add('');
  T2.cdsC3.First;
  while not T2.cdsC3.Eof do
  begin
    Contato.Items.Add(Trim(Nst(T2.cdsC3['CTN_NOME'])));

    T2.cdsC3.Next;
  end;

  Contato.ItemIndex := 0;
  Contato.Text := ' - SELECIONE OU DIGITE - ';
end;

procedure TF_Pedidos1.CarregarConfTributos;
begin
  // Configurações para o calculo dos tributos
  TrbNCM := BuscaCfg2(T2.qgSepeCfg, 'SepeCFG', 'CFG_TRBNCM', 'Usar tributação só pelo NCM', 'N', 1, 1);
  CrdIcm := Val(BuscaCfg2(T2.qgSepeCfg, 'SepeCFG', 'CFG_CRDICM', '% de credito de ICMS gerado pelo Simples Nacional', '0', 1, 10));
  PrRetPis := Val(str(Val(Trim(BuscaCfg2(T2.qSepeCFG, 'SepeCfg', 'CFG_RETPIS', '% PIS para retenção nas vendas', '0,0', 1, 10))), 2));
  PrRetCof := Val(str(Val(Trim(BuscaCfg2(T2.qSepeCFG, 'SepeCfg', 'CFG_RETCOF', '% COFINS para retenção nas vendas', '0,00', 1, 10))), 2));
  PrRetCsl := Val(str(Val(Trim(BuscaCfg2(T2.qSepeCFG, 'SepeCfg', 'CFG_RETCSL', '% CSLL para retenção nas vendas', '0,00', 1, 10))), 2));
  PrRetIrf := Val(str(Val(Trim(BuscaCfg2(T2.qSepeCFG, 'SepeCfg', 'CFG_RETIRF', '% IRF para retenção nas vendas', '0,00', 1, 10))), 2));
  PrPis := Val(str(Val(Trim(BuscaCfg2(T2.qSepeCFG, 'SepeCfg', 'CFG_PERPIS', '% PIS nas vendas', '0,0', 1, 10))), 2));
  PrCof := Val(str(Val(Trim(BuscaCfg2(T2.qSepeCFG, 'SepeCfg', 'CFG_PERCOF', '% COFINS nas vendas', '0,00', 1, 10))), 2));
  PrSufIcm := Val(str(Val(Trim(BuscaCfg2(T2.qSepeCFG, 'SepeCfg', 'CFG_DESSUF', '% Desconto ref. ao ICMS para os clientes SUFRAMADOS', '0,00', 1, 10))), 2));
  PrSufCof := Val(str(Val(Trim(BuscaCfg2(T2.qSepeCFG, 'SepeCfg', 'CFG_COFSUF', '% Desconto ref. ao COFINS para clientes SUFRAMADOS', '0,00', 1, 10))), 2));
  PrSufPis := Val(str(Val(Trim(BuscaCfg2(T2.qSepeCFG, 'SepeCfg', 'CFG_PISSUF', '% Desconto ref. ao PIS para clientes SUFRAMADOS', '0.00', 1, 10))), 2));
  PrSufIpi := Val(str(Val(Trim(BuscaCfg2(T2.qSepeCFG, 'SepeCfg', 'CFG_IPISUF', '% Desconto ref. ao IPI para clientes SUFRAMADOS', '0.00', 1, 10))), 2));
  SepDes := BuscaCFG(T2.qC2, 'SepeCfg', 'CFG_SEPDES', 1, 1);
  SepAcr := BuscaCFG(T2.qC2, 'SepeCfg', 'CFG_SEPACR', 1, 1);
  SmpNac := BuscaCfg2(T2.qgSepeCfg, 'SepeCFG', 'CFG_SMPNAC', 'Empresa optente pelo Simples Nacional', 'N', 1, 1);
  ConIpi := BuscaCfg2(T2.qC2, 'SepeCfg', 'CFG_CONIPI', 'Contribuinte Ipi 1- Sim / 2- Nao', '2', 1, 1);
  // toda indutria é contribuite do IPI mesmo se não paga ou for do SIMPLES
end;

procedure TF_Pedidos1.PesquisaProduto(Codigo, ComDescri: String);
var
  Achou: Boolean;
  PrecoTotal, PrecoUnit: Currency;

begin
  // PesPro - peso na ordem de pesquisa do código do produto interno ou de barras
  // 1 - BARRAS/CODIGO
  // 2 - CODIGO/BARRAS
  // 3 - CODIGO
  // 4 - BARRAS

  Achou := PesquisaCodigoBalanca(Codigo, ComDescri);

  if Achou then
    Exit;

  // sempre faz a pesquisa pelo codigo interno antes de fazer pelo codigo de
  // barras, por que se for na segunda passada pelo codigo, o que aparece na
  // tele é o codigo interno, mesmo tendo digitado/lido o codigo de barras
  Achou := PesquisaCodigoInterno(Codigo);

  // so faz pesquisa pelo codigo de barras se for 1,2,4
  if (not Achou) and ((PesPro = '1') or (PesPro = '2') or (PesPro = '4')) then
    Achou := PesquisaCodigoBarras(Codigo);

  if not Achou then
  begin
    CODPRO.SetFocus;
    CODPRO.SelectAll;

    MessageBeep(MB_ICONERROR);
    Application.ProcessMessages;

    Raise Exception.Create('Código de produto não cadastrado.');
  end;

  if Achou and (obProduto.getPro_ativo <> 'S') then
    Raise Exception.Create('Produto inativo.');

  CODPRO.Text := obProduto.getPro_codigo;
  if ComDescri = 'S' then
  begin
    CODPROD.Text := obProduto.getPro_descri;
  end;

  UNDPRO.Text := obProduto.getPro_und;

  // se o produto só tem preço numa tabela mostra o código dela
  CODTAB.Text := BuscaTabela(CODTAB.Text, obProduto.getPro_codigo);

  // pesquisa preco usando codigo do produto + tabela default
  if PesqPreco(obProduto.getPro_codigo, Trim(CODTAB.Text)) then
  begin
    VlrUnt.Text := '0,00';
    PrecoUnit := VlrUntIndex;

    // caso exista desconto do ICMS, sera feito o calculo automático do valor da tabela de precos
    if DescIcms <> 0 then
      PrecoUnit := PrecoUnit - (PrecoUnit * (DescIcms / 100));

    PrecoTotal := Val(Trim(Qtde.Text)) * PrecoUnit; // quantidade * unitario
    VlrUnt.Text := str(PrecoUnit, Decimais); // valor unitario

    VlrUnt.Text := str(PrecoUnit, Decimais); // valor unitario

    AlinharDireitaValor(VlrUnt, Decimais);
  end;
end;

// verifica se o produto já foi incluido no pedido
function TF_Pedidos1.JaTemPro(CODPRO: String): Boolean;
begin
  Result := False;

  try

    cdsItens.DisableControls;
    cdsItens.First;
    while not cdsItens.Eof do
    begin
      if cdsItens['CODPRO'] = CODPRO then
        Result := True;
      cdsItens.Next;
    end;

  finally
    cdsItens.EnableControls;
  end;

end;

procedure TF_Pedidos1.VerificarCodTna(deOnde: String);
var
  Nat, Opr, Descri, cstICM, cstPIS, cstCOFINS, cstIPI, CSOSN, cEnq: String;
begin
  // Tipo de Operacao
  obCadaTna.setTna_Codigo(CodTna.Text);
  if not obCadaTna.Consultar then
  begin
    CodTna.SetFocus;
    CodTna.SelectAll;
    Raise Exception.Create('Tipo de operação não cadastrada');
  end;

  CodTnaD.Text := obCadaTna.getTna_descri;

  if deOnde = 'exit' then
  begin
    // se for uma operação de transferência só é premitodo entre empresas do mesmo grupo matriz/filial
    // por isso é feita a comparação da raiz do CNPJ se for diferente não permitre a inclusão da nota
    if (obCadaTna.getTna_tipo = '3') then
    begin
      if (obClientes.getCli_cgccpf = CNPJEmp) then
      begin
        Ped_CODCLI.SetFocus;
        Ped_CODCLI.SelectAll;
        Raise Exception.Create('Não poder ser feita um transferência para a própria empresa.');
      end;

      if Copy(obClientes.getCli_cgccpf, 1, 8) <> Copy(CNPJEmp, 1, 8) then
      begin
        Ped_CODCLI.SetFocus;
        Ped_CODCLI.SelectAll;
        Raise Exception.Create('Não pode ser feita uma transferência para uma empresa que não seja matriz/filial.');
      end;
    end;
  end;

  // faz a pesquisa pelo NCM do produto para ver se localiza a tributação
  // se localizar já preenche os campos necessários e ativa o flag TemNCMxTrib
  TributacaoNCM(CODPRO.Text);

  // se tem tibutação definida pelo NCM ou se TrbNCM estivar ativa, sai fora, não pesquisa pelo metodo antigo
  if TemNCMxTrib or (TrbNCM = 'S') then
    Exit;

  // =============== NÃO PASSA SE TEM TRIBUAÇÃO DO NCM ==================//

  LocalizaNatuteza(CODPRO.Text, CodTna.Text, uf.Text, UFEmp, obClientes.getCli_insest, obClientes.getCli_tipo, 'S', Nat, Opr, Descri, cstICM, cstPIS, cstCOFINS, cstIPI, CSOSN, cEnq);

  if Trim(Nat) <> '' then
  begin
    NATOPR.Text := Nat;
    CODOPR.Text := Opr;
    NatOprD.Text := Descri;
    CODCST.Text := cstICM;
    edCstPis.Text := cstPIS;
    edCstCof.Text := cstCOFINS;
    EdCstIPI.Text := cstIPI;
    edCSOSN.Text := CSOSN;

    // verifica se a natureza é de transferencia,
    // busca o valor do custo gravado na tebela de produtos
    VerNatTransferencia(Nat + '.' + Opr);
  end;
end;

procedure TF_Pedidos1.VerificarNatOpr(deOnde: String);
begin
  if (Trim(NATOPR.Text) = '') or (Trim(CODOPR.Text) = '') then
    Exit;

  obNatureza.setNt_cfo(NATOPR.Text);
  obNatureza.setNt_opc(CODOPR.Text);
  if not obNatureza.Consultar then
  begin
    NATOPR.SetFocus;
    NATOPR.SelectAll;
    Raise Exception.Create('Natureza + Variação não cadastrada!');
  end;

  if obNatureza.getNt_ativo <> 'S' then
  begin
    NATOPR.SetFocus;
    NATOPR.SelectAll;
    Raise Exception.Create('Natureza + Variação inativa.');
  end;

  if obNatureza.getNt_codtna <> CodTna.Text then
  begin
    NATOPR.SetFocus;
    NATOPR.SelectAll;
    Raise Exception.Create('A operação desta natureza deve ser: ' + CodTna.Text + ' - ' + CodTnaD.Text);
  end;

  NatOprD.Text := obNatureza.getNt_descfo;

  // se não tem tibutação definida pelo NCM usa o metodo anteriro de pesquisa
  if not TemNCMxTrib then
    VerificaTributacao(False);

  // verifica se a natureza é de transferencia,
  // busca o valor do custo gravado na tebela de produtos
  VerNatTransferencia(NATOPR.Text + '.' + CODOPR.Text);
end;

procedure TF_Pedidos1.VlrLiqConfere;
var
  Qt, VUni, VAcr, VDes, VLiq: Real; // , LiqUnit :Real;
begin
  VAcr := 0;
  VDes := 0;
  Qt := Val(Qtde.Text);

  VUni := Val(VlrUnt.Text);

  VLiq := Qt * (VUni + VAcr - VDes);
  VlrUnt.Text := str(VUni + VAcr - VDes, Decimais);

  AlinharDireitaValor(Qtde, DecPro);
  AlinharDireitaValor(VlrUnt, Decimais);
end;

Function TF_Pedidos1.InfValorServico: Boolean;
var
  ModuloAtual, LinhaAtual: String;
begin
  Result := False;

  PodeConfirmarItem := False;

  // qdo o produto tem controle de servico e o controle de servicos estiver ativo, é solicitao do código do servico numa tela especial
  if (CONSRV = 'S') and (obProduto.getPro_consrv = 'S') and (obNatureza.getNt_solsrv = 'S') then
  begin
    if Trim(CODVEN.Text) = '' then
    begin
      CODVEN.SetFocus;
      Raise Exception.Create('Informe o vendedor.');
    end;

    if CODPRO.Enabled = False then
      CODTAB.Enabled := False;

    // if (CODTAB.Enabled = true) or (CODPRO.Modified) or (NATOPR.Modified) or (CODOPR.Modified) then
    // begin
    AltPreco := False;
    SerNf_DEV := '';
    NumNF_DEV := '';

    try

      // try F_ServicoPro.Show; Except Application.CreateForm(TF_ServicoPro,F_ServicoPro);End;
      Application.CreateForm(TF_ServicoPro, F_ServicoPro);

      ModuloAtual := 'VENDAS_VENDA';

      F_ServicoPro.Panel3.Caption := Copy(CODPRO.Text + ' - ' + CODPROD.Text, 1, 55);

      if Pertence(NATOPR.Text + '.' + CODOPR.Text, CFOP_Doacao) then
        ModuloAtual := 'VENDAS_DOACAO';

      LinhaAtual := '';
      if (btConfItem.Caption = 'Confirmar Alteração') then
        LinhaAtual := StrZero(Trim(Nst(cdsItens['NrItem'])), 4);

      F_ServicoPro.CarregarTela(LinhaAtual, Data.Text, Ped_CODCLI.Text, NomeCli.Text, CODPRO.Text, ModuloAtual, '', StrZero(edtId.Text, 7), cdsServicos);

      F_ServicoPro.NroSerial.Enabled := False;
      F_ServicoPro.LblSerial.Enabled := False;

      if obNatureza.getNt_usavcmp = 'S' then
      begin
        F_ServicoPro.NroSerial.Enabled := True;
        F_ServicoPro.LblSerial.Enabled := True;

        // nao permite alterar o valor
        VlrUnt.Enabled := False;
      end;

      if F_ServicoPro.ShowModal = mrOK then
      begin
        CODTAB.Text := F_ServicoPro.Tabela.Text;
        CODTAB.Enabled := False;
        CodServico := F_ServicoPro.CodSrv.Text;
        AltPreco := F_ServicoPro.PermiteAlterarVlr;

        SerNf_DEV := F_ServicoPro.SerNf.Text;
        NumNF_DEV := F_ServicoPro.NumNf.Text;

        Qtde.Text := str(F_ServicoPro.getQtdeSeriais, DecPro);

        VlrUnt.Text := str(Val(F_ServicoPro.edtVlrUnit.Text) + Nvl(F_ServicoPro.edVlrDesc.Text), 2);
        AlinharDireitaValor(VlrUnt);

        CODPRO.Modified := False;

        if Qtde.Enabled then
          Qtde.SetFocus
        else if VlrUnt.Enabled then
          VlrUnt.SetFocus;

        PodeConfirmarItem := True;
        Result := True;
      end
      else
      begin
        if CODTAB.Enabled then
        begin
          CODPRO.SetFocus;
          CODPRO.SelectAll;
        end;

        Raise Exception.Create('Produto exige um tipo de serviço!');
      end;

    finally
      F_ServicoPro.Free;
    end;
    // end;
  end
  else
    CODTAB.Enabled := True;
end;

function TF_Pedidos1.TemFinanceiroGeral: Boolean;
var
  BMK: TBookmark;
begin
  Result := False;

  BMK := cdsItens.GetBookmark;
  cdsItens.DisableControls;
  Try
    cdsItens.First;
    while (not cdsItens.Eof) and (not Result) do
    begin
      Result := GeraFaturamento(Nst(cdsItens['NatOpr']), Nst(cdsItens['CodOpr']));

      Application.ProcessMessages;
      cdsItens.Next;
    end;
  Finally
    cdsItens.GotoBookmark(BMK);
    cdsItens.EnableControls;
  End;
end;

function TF_Pedidos1.TestaDoacao: Boolean;
begin
  Result := True;

  // so fazer o teste se existir uma tabela de doação configurada
  if TABDOA = '' then
    Exit;

  VlrUnt.Enabled := True;
  // nao permite alterar o valor
  if AltVlr = 'N' then
  begin
    VlrUnt.Enabled := False;
  end;

  if (Pertence(NATOPR.Text + '.' + CODOPR.Text, CFOP_Doacao)) then
  begin
    obPrecos.setTab_codpro(CODPRO.Text);
    obPrecos.setTab_nro(TABDOA);
    if not obPrecos.Consultar then
    begin
      DL_Msg('Para fazer doação é necessário que o produto esteja cadastrado na tabela de preços:' + TABDOA, 'Doação', 'Erro');
      Result := False;
      Exit;
    end;

    VlrUnt.Text := str(obPrecos.getTab_preco, Decimais);

    // antureza diz que tem que usar valor de compra
    if obNatureza.getNt_usavcmp = 'S' then
    begin
      VlrUnt.Text := str(obProduto.getPro_vlrcom, Decimais);
    end;

    CODTAB.Enabled := False;
    VlrUnt.Enabled := False;
    CODTAB.Text := TABDOA;
  end;
end;

// verifica se o codigo lido/digitado, é codigo gerado pela balança, onde o
// codigo do produto e o valor total da mercadoria estão embutidos
function TF_Pedidos1.PesquisaCodigoBalanca(Codigo, ComDescri: String): Boolean;
var
  // InicioPro: string;
  PrecoTotal: Currency;

begin
  Result := False;

  if (Length(Codigo) = 13) and (Copy(Codigo, 1, 1) = '2') then
  begin
    // InicioPro := BuscaCFG(T2.qgSepeCfg,'SepeCfg','CFG_PROBAL',1,2);

    if Trim(InicioPro) = '' then
      InicioPro := '00';

    PrecoTotal := Val(Copy(Codigo, 7, 4) + ',' + Copy(Codigo, 11, 2));
    Codigo := Trim(InicioPro) + Copy(Codigo, 3, 4);

    // se o produto não existe no cadastro, assume que o codigo não seja
    // da balanca, e sim um codigo normal
    if PesquisaCodigoInterno(Codigo) then
    begin

      // pesquisa preco pelo codigo do produto e tabela
      // se o produto não existe na tabela de precos, assume que o codigo não seja
      // da balanca, e sim um codigo normal
      if PesqPreco(Codigo, Trim(CODTAB.Text)) then
      begin

        CODPRO.Text := obProduto.getPro_codigo;

        if ComDescri = 'S' then
        begin
          CODPROD.Text := obProduto.getPro_descri;
        end;

        Qtde.Text := str(PrecoTotal / Nvl(Nst(obPrecos.getTab_preco)), DecPro); // quantidade
        VlrUnt.Text := str(Nvl(Nst(obPrecos.getTab_preco)), Decimais); // valor unitario

        AlinharDireitaValor(Qtde, DecPro);
        AlinharDireitaValor(VlrUnt, Decimais);
        Result := True;
      end;
    end;

  end;

end;

function TF_Pedidos1.PesquisaCodigoInterno(Codigo: String): Boolean;
begin
  Result := False;

  if Length(Codigo) > 10 then
    Exit;

  // faz pesquisa pelo codigo interno, se encontrar carrega o objeto obProdutos
  obProduto.setPro_codigo(Codigo);
  Result := obProduto.Consultar;

end;

function TF_Pedidos1.PesquisaCodigoBarras(Codigo: String): Boolean;
begin
  Result := False;

  // faz pesquisa pelo codigo de barras, se encontrar carrega o objeto obProdutos
  if SetKeyDL(T2.qC1, 'EstaPro', ['PRO_CODBAR'], [Codigo]) then
  begin
    obProduto.setPro_codigo(T2.qC1['PRO_CODIGO']);
    Result := obProduto.Consultar;
  end;
end;

function TF_Pedidos1.BuscaTabela(TabAtu, CODPRO: String): String;
var
  S: String;
begin
  Result := TabAtu;
  S := 'Select Tab_Nro From Venatab';
  S := S + #13 + 'Where Tab_Codpro = :Codigo';

  T2.cdsC1.Close;
  T2.qC1.Close;
  T2.qC1.SQL.Clear;
  T2.qC1.SQL.Add(S);
  T2.qC1.ParamByName('Codigo').AsString := CODPRO;
  T2.cdsC1.Open;
  if T2.cdsC1.RecordCount = 1 then
    Result := Nst(T2.cdsC1['TAB_NRO']);
end;

procedure TF_Pedidos1.VerNatTransferencia(natMaisOpr: String);
begin
  // se não for usadoo valor de transferencia o que está no cadastro do produto como sendo ultima compra,
  // sai da rotina, pois será usado o valor normal da tabela de precos
  if VlrTrf <> 'S' then
    Exit;

  CODTAB.TabStop := True;
  CODTAB.ReadOnly := False;
  if Pertence(natMaisOpr, CFOP_Transferencia) then
  begin
    VlrUnt.Text := str(obProduto.getPro_vlrcom, Decimais);
    CODTAB.TabStop := False;
    CODTAB.ReadOnly := True;
    CODTAB.Text := '';

    VlrLiqConfere;
  end;
end;

Function TF_Pedidos1.PrecoPro_Tab(CODPRO, CODTAB: String): Currency;
begin
  obPrecos.setTab_codpro(CODPRO);
  obPrecos.setTab_nro(CODTAB);
  if not obPrecos.Consultar then
    Result := -999
  else
    Result := obPrecos.getTab_preco;
end;

procedure TF_Pedidos1.BloqueiaDescontos(MP1, MP2, MP3, MP4, MP5, MP6, Valor: Currency; Produto, Tipo: String);
var
  Menordesconto, Percent1, Percent: Currency;
  StrDesc: string;
begin
  Percent := Valor;

  if PriDes = 'M' then
    if (Percent > MP1) and (Percent > MP2) and (Percent > MP3) and (Percent > MP4) and (Percent > MP5) and (Percent > MP6) then
    begin
      DescontoLiberado := False;
      Menordesconto := Percent;
      Percent := P1;
      if MP2 > Percent then
        Percent := MP2;
      if MP3 > Percent then
        Percent := MP3;
      if MP4 > Percent then
        Percent := MP4;
      if MP5 > Percent then
        Percent := MP5;
      if MP6 > Percent then
        Percent := MP6;

      StrDesc := 'Desconto ' + str(Menordesconto, 2) + ' %' + #13 + #10 + 'Máximo desconto permitido é ' + str(Percent, 2) + ' %' + #13 + #10 + 'Prioridade de desconto baseado no MAIOR percentual entre: ';
      if MP3 > 0 then
        StrDesc := StrDesc + #13 + #10 + 'Tabela de preços -> ' + str(MP3, 2) + ' %';
      if MP2 > 0 then
        StrDesc := StrDesc + #13 + #10 + 'Condição de Pagamento -> ' + str(MP2, 2) + ' %';
      if MP1 > 0 then
        StrDesc := StrDesc + #13 + #10 + 'Produto -> ' + str(MP1, 2) + ' %';
      if MP6 > 0 then
        StrDesc := StrDesc + #13 + #10 + 'Grupo de Produtos -> ' + str(MP6, 2) + ' %';
      if MP5 > 0 then
        StrDesc := StrDesc + #13 + #10 + 'Fabricante -> ' + str(MP5, 2) + ' %';
      if MP4 > 0 then
        StrDesc := StrDesc + #13 + #10 + 'Cliente -> ' + str(MP4, 2) + ' %';

      Application.CreateForm(TF_DescInvalido, F_DescInvalido);

      if Tipo = 'I' then
      begin
        if Val(PercDesc.Text) > 0 then
          F_DescInvalido.Msg1.Caption := 'Desconto no produto ' + Produto + ' + desconto total do pedido não autorizado.'
        else
          F_DescInvalido.Msg1.Caption := 'Desconto não autorizado no produto ' + Produto + '.';
      end
      else
        F_DescInvalido.Msg1.Caption := 'Desconto no total do pedido não autorizado.';

      F_DescInvalido.Msg1.Caption := F_DescInvalido.Msg1.Caption + #13 + #10 + 'O desconto máximo permitido é ' + str(Percent, 2) + ' %';
      F_DescInvalido.Msg2.Caption := StrDesc;

      F_DescInvalido.ShowModal;

      // tela para inf senha de liberação do desconto
      Application.CreateForm(TF_SenhaDesconto, F_SenhaDesconto);

      F_SenhaDesconto.codigoAcessoDesconto := 'O017';

      if F_SenhaDesconto.ShowModal = mrOK then
      begin
        DescontoLiberado := True;

        if Tipo = 'I' then // se for desconto nos itens
        begin
          cdsItens.Edit;
          cdsItens['UsrDesc'] := Trim(F_SenhaDesconto.Usuario.Text);
          cdsItens['JustDesc'] := Trim(F_SenhaDesconto.edJustificativa.Text);
          cdsItens.Post;
        end
        else // se for desconto geral
        begin
          cdsItens.First;
          while not cdsItens.Eof do
          begin
            cdsItens.Edit;
            cdsItens['UsrDesc'] := Trim(F_SenhaDesconto.Usuario.Text);
            cdsItens['JustDesc'] := Trim(F_SenhaDesconto.edJustificativa.Text);
            cdsItens.Post;
            cdsItens.Next;
          end;
        end;
      end
      else
      begin
        DescontoLiberado := False;
        FocarObj(PercDesc);

        Raise Exception.Create('Impossível prosseguir!' + #13 + 'Este usuário não possui permissão para essa operação');
      end;
    end;

  // if BuscaCFG(T2.qgSepeCfg,'SepeCfg','CFG_PRIDES',1,1) = 'R' then
  if PriDes = 'R' then
  begin
    DescontoLiberado := False;
    Percent1 := Valor;
    // Percent1 := MP1;
    if (MP1 < Percent1) and (MP1 > 0) then
      Percent1 := MP1;
    if (MP2 < Percent1) and (MP2 > 0) then
      Percent1 := MP2;
    if (MP3 < Percent1) and (MP3 > 0) then
      Percent1 := MP3;
    if (MP4 < Percent1) and (MP4 > 0) then
      Percent1 := MP4;
    if (MP5 < Percent1) and (MP5 > 0) then
      Percent1 := MP5;
    if (MP6 < Percent1) and (MP6 > 0) then
      Percent1 := MP6;

    if Percent > Percent1 then
    begin
      StrDesc := 'Desconto de ' + str(Percent, 2) + ' %' + #13 + #10 + 'Máximo desconto permitido é ' + str(Percent1, 2) + ' %' + #13 + #10 + 'Prioridade de desconto baseado no MENOR percentual entre : ';
      if MP3 > 0 then
        StrDesc := StrDesc + #13 + #10 + 'Tabela de preços -> ' + str(MP3, 2) + ' %';
      if MP2 > 0 then
        StrDesc := StrDesc + #13 + #10 + 'Condição de Pagamento -> ' + str(MP2, 2) + ' %';
      if MP1 > 0 then
        StrDesc := StrDesc + #13 + #10 + 'Produto -> ' + str(MP1, 2) + ' %';
      if MP6 > 0 then
        StrDesc := StrDesc + #13 + #10 + 'Grupo de Produtos -> ' + str(MP6, 2) + ' %';
      if MP5 > 0 then
        StrDesc := StrDesc + #13 + #10 + 'Fabricante -> ' + str(MP5, 2) + ' %';
      if MP4 > 0 then
        StrDesc := StrDesc + #13 + #10 + 'Cliente -> ' + str(MP4, 2) + ' %';

      Application.CreateForm(TF_DescInvalido, F_DescInvalido);

      if Tipo = 'I' then
      begin
        if Val(PercDesc.Text) > 0 then
          F_DescInvalido.Msg1.Caption := 'Desconto do orçamento + produto não autorizado.'
        else
          F_DescInvalido.Msg1.Caption := 'Desconto não autorizado no produto ' + Produto + '.';
      end
      else
        F_DescInvalido.Msg1.Caption := 'Desconto no total do orçamento não autorizado.';

      F_DescInvalido.Msg1.Caption := F_DescInvalido.Msg1.Caption + #13 + #10 + 'O desconto máximo permitido é ' + str(Percent1, 2) + ' %';
      F_DescInvalido.Msg2.Caption := StrDesc;

      F_DescInvalido.ShowModal;

      // tela para inf senha de liberação do desconto
      Application.CreateForm(TF_SenhaDesconto, F_SenhaDesconto);

      F_SenhaDesconto.codigoAcessoDesconto := 'O017';

      if F_SenhaDesconto.ShowModal = mrOK then
      begin
        DescontoLiberado := True;

        if Tipo = 'I' then // se for desconto nos itens
        begin
          cdsItens.Edit;
          cdsItens['UsrDesc'] := Trim(F_SenhaDesconto.Usuario.Text);;
          cdsItens['JustDesc'] := Trim(F_SenhaDesconto.edJustificativa.Text);;
          cdsItens.Post;
        end
        else // se for desconto geral
        begin
          cdsItens.First;
          while not cdsItens.Eof do
          begin
            cdsItens.Edit;
            cdsItens['UsrDesc'] := Trim(F_SenhaDesconto.Usuario.Text);
            cdsItens['JustDesc'] := Trim(F_SenhaDesconto.edJustificativa.Text);
            cdsItens.Post;
            cdsItens.Next;
          end;
        end;
      end
      else
      begin
        DescontoLiberado := False;
        FocarObj(PercDesc);

        Raise Exception.Create('Impossível prosseguir!' + #13 + 'Este usuário não possui permissão para essa operação');
      end;

    end;
  end;
end;

procedure TF_Pedidos1.ValidarGravacao;
begin
  if obPedidoWeb.getCodigoint <> '' then
  begin
    DL_Msg('Já foi gerado o pedido de venda ' + obPedidoWeb.getCodigoint + '!', Application.Title, 'ERRO');
    Abort;
  end;
end;

procedure TF_Pedidos1.ValoresDefault;
begin
  edtSituacao.Text := 'Incluído';
end;

procedure TF_Pedidos1.VerificaDescontos;
Var
  MP1, MP2, MP3, MP4, MP5, MP6, DescValor, DescPerc: Real;
  PR1, PR5, PR6: Real;
begin
  MP1 := 0;
  MP2 := 0;
  MP3 := 0;
  MP4 := 0;
  MP5 := 0;
  MP6 := 0;
  PR1 := 0;
  PR5 := 0;
  PR6 := 0;

  // Produtos
  try
    cdsItens.DisableControls;
    cdsItens.First;
    While not cdsItens.Eof do
    begin
      obProduto.setPro_codigo(Trim(Nst(cdsItens['CODPRO'])));
      obProduto.Consultar;
      PR1 := Nvl(obProduto.getPro_prdesc);
      P1 := PR1;
      if PR1 > MP1 then
        MP1 := PR1;

      // Fabricante
      obFabricantes.setFab_codigo(obProduto.getPro_codfab);
      if obFabricantes.Consultar then
        PR5 := obFabricantes.getFab_desmax;
      if PR5 > MP5 then
        MP5 := PR5;

      // Grupo de Produto
      obGrupoPro.setGru_codigo(obProduto.getPro_codgru);
      if obGrupoPro.Consultar then
        PR6 := obGrupoPro.getGru_desmax;
      if PR6 > MP6 then
        MP6 := PR6;

      // tabela de preço
      if PrecoPro_Tab(Trim(Nst(cdsItens['CODPRO'])), Trim(Nst(cdsItens['TAB']))) > -999 then
      begin
        P3 := obPrecos.getTab_desmax;

        if P3 > MP3 then
          MP3 := P3;
      end;

      cdsItens.Edit;
      cdsItens['UsrDesc'] := '';
      cdsItens['JustDesc'] := '';
      cdsItens.Post;

      cdsItens.Next;
    end;

    // forma de pagamento
    obFormaPag.setPgnf_cod(CODPAG.Text);
    if obFormaPag.Consultar then
      VKDesconto_Orcam := obFormaPag.getPgnf_desco;

    P2 := VKDesconto_Orcam;
    if P2 > MP2 then
      MP2 := P2;

    if Val(PercDesc.Text) > 0 then
      BloqueiaDescontos(MP1, MP2, MP3, MP4, MP5, MP6, Val(PercDesc.Text), '', 'T');

    cdsItens.First;
    while not cdsItens.Eof do
    begin
      obNatureza.setNt_cfo(cdsItens['NATOPR']);
      obNatureza.setNt_opc(cdsItens['CODOPR']);
      obNatureza.Consultar;

      if (Nvl(cdsItens['PerDes']) > 0) and (obNatureza.getNt_gerdup = 'S') then
      begin
        DescPerc := Nvl(cdsItens['PerDes']);

        if Val(Trim(PercDesc.Text)) > 0 then
        begin
          DescValor := ((Nvl(cdsItens['Qtde']) * Nvl(cdsItens['VlrUnt'])) * (Val(Trim(PercDesc.Text)) / 100)) + Val(Trim(cdsItens['VlrDes']));
          DescPerc := (DescValor * 100) / Nvl(cdsItens['VlrOrg'])
        end;

        BloqueiaDescontos(MP1, MP2, MP3, MP4, MP5, MP6, DescPerc, Trim(Nst(cdsItens['CODPRO'])), 'I');
      end;

      cdsItens.Next;
    end;
  finally
    cdsItens.EnableControls;
  end;
end;

procedure TF_Pedidos1.VerificaDescontosItem;
Var
  MP5, MP6, DescValor, DescPerc: Real;
begin
  MP5 := 0;
  MP6 := 0;

  // Produtos
  P1 := Nvl(obProduto.getPro_prdesc);

  // Fabricante
  obFabricantes.setFab_codigo(obProduto.getPro_codfab);
  if obFabricantes.Consultar then
    MP5 := obFabricantes.getFab_desmax;

  // Grupo de Produto
  obGrupoPro.setGru_codigo(obProduto.getPro_codgru);
  if obGrupoPro.Consultar then
    MP6 := obGrupoPro.getGru_desmax;

  BloqueiaDescontos(P1, P2, P3, P4, MP5, MP6, Val(PercDesc.Text), '', 'T');

end;

end.
