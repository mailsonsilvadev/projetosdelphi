unit U_OperacoesNFSeMigrate;

interface

Uses
  System.Generics.Collections, System.Classes, SysUtils, SqlExpr, StrUtils, Windows, Forms, U_T2, U_Sisproc, CVenarps, U_OperacoesBasicasNFSe, CLotenfeFull,
  Conexao, CPedidovendaFull, CCadobra, CCidades, CNaturezaopr, pnfsConversao, CClientes, CPaises, pcnConversao, U_WebBrowseNFe, CNotasFiscaisFull,
  CVenaRpsFull, CItensNFFull, CScranfls, CDuplicatas, CTipopgto, U_RotinaFidelidade, CProdutos, CMovprodestoque, U_NumeroMovEstoque,
  U_CMP, Transacao, U_NFSe, U_IconesNfSe, U_PastasNFSe, CNotasresumidonfe, CVenaips, U_ImprimirNFSe, U_EnviaEmailNFSe, U_GeraImpBoleto, U_EnviaSMS,
  CDocumento,
  {$IFDEF VER340}
  System.JSON,
  {$ELSE}
  DBXJson,
  {$ENDIF}
  synacode;

const
  modelo = '98';

  Letras: array [1 .. 35] of String = ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V',
    'X', 'Y', 'Z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9');

Type
  TOperacoesNFSeMigrate = class(TOperacoesBasicasNFSe)
  private
    FListaRps: TObjectList<TVenarps>;
    FPastaNFSe: TPastasNFSe;
    FCFG_MTRNFS: Boolean;
    FCFG_SMPNAC: Boolean;
    FCFG_SEPDES: Boolean;
    FCFG_SRVCIV: Boolean;
    FCFG_SERFSE: String;
    FCFG_SERRPS: String;
    FCFG_GERDPN: String;
    FCFG_FINPED: String;
    FCFG_PTOFID: Boolean;
    FCFG_PTOGER: String;
    FCFG_NRPRAN: String;
    FCFG_ESTPED: String;
    FCFG_ATUEST: Boolean;
    FCFG_CONSER: String;
    FCFG_NATRPS: String;
    FCFG_REGTRI: String;
    FCFG_NFSAMB: String;
    FCFG_SUBISS: Boolean;
    FCFG_SUBIRF: Boolean;
    FCFG_IMPNFS: Boolean;
    FCFG_BOLNFS: Boolean;
    FCFG_ENVNFS: Boolean;
    FCFG_SMSSRV: Boolean;
    FCFG_OBNFS1: String;
    FCFG_OBNFS2: String;
    FNomeSchema: String;
    FCFG_SDECLI: Boolean;
    FSilencio  : Boolean;
    FobDocs    : TDocumento;
    FListaNotas: TStringList;

    function FormataNroEnd(Nro: String): String;
    function GeraLoteRps(ANumeroLote: String): Boolean;
    function ValidarLote(ALote: String): Boolean;
    procedure DuplicatasPED(NumFat: String; ScraNfs: TNotasFiscaisFull);
    procedure GravarDupsNfs(ANroPedido: String; ANota: TNotasFiscaisFull);
    procedure GravarPontos(ANroPedido: String; ANota: TNotasFiscaisFull);
    procedure GeraNota(ANumeroLote, ANumeroRPS: String);
//    procedure GeraNota(ANumeroLote: String);
    procedure Progresso(AMensagem: String; AProgress, AMax: Integer);
    procedure ProgressoClose;
    procedure SetobDocs(const Value: TDocumento);
    function  GetobDocs: TDocumento;
    function  GetDateTime(ADateTimeStr: String): TDateTime;
    function  FormatarMsgErro(AMsg:String): String;
    function  MontaConsultaRps(ANumeroRps: String): Boolean;
    function  ExecutaCancelamento(ASerie, ANumero, AProtocolo, AJustificativa:String; out ARetProtocolo, AHora:String; out AData: TdateTime): Boolean;
    function  ProcessarRetornoCancelamento(out AProtocolo, AHora:String; out AData: TdateTime): Boolean;
    function  ProcessarRetornoInutilizacao(out AProtocolo, AHora:String; out AData: TdateTime): Boolean;
    function  PesquisaRSP_Nota(ASerie, ANumero: String): String;
    Procedure GravarInutilizacao(ASerie,ANumeroIni,ANumeroFim,AMotivo, AProtocolo:String);
    Function  RPSSubtituir(ARps:String):Boolean;
    function  CarregaCliente(obCliente:TClientes; obPedido:TPedidovendaFull; obCidade: TCidades; obPais: TPaises): Boolean;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Limpar; override;
    function Add(IdRps: Integer): Boolean; override;
    function EnviaLote: Boolean; override;
    function ConsultaLote(ANumeroLote: String): Boolean; override;
    function CancelaNFSe(ASerie, ANumero, ACodigoCanc, AMotivo: String): Boolean; override;
    function InutilizarNumerosNFSe(ASerie,ANumeroIni,ANumeroFim,AMotivo:String): Boolean; override;
    function GetMotivosDeCancelamento: TStringList; override;
    function ConsultaRPS(ARPS, ANumeroLote:String): Boolean; override;

    property obDocs: TDocumento read GetobDocs write SetobDocs;
  end;

implementation


{ TOperacoesNFSeMigrate }

uses U_FuncFinanceiro, CNroInutil;

constructor TOperacoesNFSeMigrate.Create;
begin
  inherited Create;
  FListaRps  := TObjectList<TVenarps>.Create;
  FPastaNFSe := TPastasNFSe.Create;
  FListaNotas:= TStringList.Create;

  FCFG_NFSAMB := BuscaCFG2(T2.qgSepeCfg, 'SepeCFG', 'CFG_NFSAMB', 'NFSe -> Ambiente 1-Produção / 2-Homologação', '1', 1, 1);
  FCFG_MTRNFS := BuscaCFG2(T2.qgSepeCfg, 'SepeCFG', 'CFG_MTRNFS', 'Mostrar carga tributária na NFS-e', 'N', 1, 1) = 'S';
  FCFG_SMPNAC := BuscaCFG2(T2.qgSepeCfg, 'SepeCFG', 'CFG_SMPNAC', 'Empresa optente pelo Simples Nacional', 'N', 1, 1) = 'S';
  FCFG_SEPDES := BuscaCFG2(T2.qgSepeCfg, 'SepeCfg', 'CFG_SEPDES', 'Separa desconto no pedido', 'N', 1, 1) = 'S';
  FCFG_SRVCIV := BuscaCFG2(T2.qgSepeCfg, 'SEPECFG', 'CFG_SRVCIV', 'Empresa presta serviços para a construção civil', 'N', 1, 1) = 'S';
  FCFG_SERFSE := BuscaCFG2(T2.qgSepeCfg, 'SepeCFG', 'CFG_SERFSE', 'Série da nota fiscal de serviço NFS-e', '', 1, 3);
  FCFG_SERRPS := BuscaCFG2(T2.qgSepeCfg, 'SepeCFG', 'CFG_SERRPS', 'Série do RPS para nota fiscal de serviço', '', 1, 5);
  FCFG_GERDPN := BuscaCFG2(T2.qgSepeCfg, 'SepeCFG', 'CFG_GERDPN', 'Gera numero da duplicata diferente do numero da nota', 'N', 1, 1);
  FCFG_FINPED := BuscaCFG2(T2.qgSepeCfg, 'SepeCFG', 'CFG_FINPED', 'Atu financeiro na geração N-nota, lib V-vendas/F-financeiro/P-produção', '', 1, 1);
  FCFG_PTOFID := BuscaCFG2(T2.qgSepeCfg, 'SepeCfg', 'CFG_PTOFID', 'Ativar programa de pontos/fidelidade (S/N)', 'N', 1, 1) = 'S';
  FCFG_PTOGER := BuscaCFG2(T2.qgSepeCfg, 'SepeCfg', 'CFG_PTOGER', 'Qdo deve gerar pontos Conf. do pedido, Liberacao de Venda/Financeiro/Producao, geração do ECF/NFS', '', 1, 1);
  FCFG_NRPRAN := BuscaCFG2(T2.qgSepeCfg, 'SepeCfg', 'CFG_NRPRAN', 'Sequencia das parcelas A – Alphanumerico / N – Numerico', 'A', 1, 1);
  FCFG_ESTPED := BuscaCFG2(T2.qgSepeCfg, 'SepeCfg', 'CFG_ESTPED', 'Atu estoque na geração N-nota, lib V-vendas/F-financeiro/P-produção', '', 1, 1);
  FCFG_ATUEST := BuscaCFG2(T2.qgSepeCfg, 'SepeCfg', 'CFG_ATUEST', 'Atualizar estoque na emissão do cupom fiscal', 'N', 1, 1) = 'S';
  FCFG_CONSER := Trim(BuscaCFG2(T2.qgSepeCfg, 'SepeCfg', 'CFG_CONSER', 'Fazer controle do numero de série dos produtos. (S / N)/ PD - Pedido/ NE - NFE/ NS - NFS/ EC - ECF/ SE - Transf. Alx/ MOV - Mov. Est./ NC - NFC-E', '', 1, 250));
  FCFG_NATRPS := Trim(BuscaCFG2(T2.qgSepeCfg, 'SepeCfg', 'CFG_NATRPS', 'Natureza de operação para RPS na geração da NFS-e', '', 1, 3));
  FCFG_REGTRI := Trim(BuscaCFG2(T2.qgSepeCfg, 'SepeCfg', 'CFG_REGTRI', 'Regime especial de tributação na geração da NFS-e', '', 1, 2));
  FCFG_SUBISS := BuscaCFG2(T2.qgSepeCfg, 'SepeCfg', 'CFG_SUBISS', 'Subtrair o valor do ISS (retido) do valor total do Pedido', '', 1, 1) = 'S';
  FCFG_SUBIRF := BuscaCFG2(T2.qgSepeCfg, 'SepeCfg', 'CFG_SUBIRF', 'Subtrair o valor de IR do valor total do Pedido', '', 1, 1) = 'S';
  FCFG_IMPNFS := BuscaCFG2(T2.qgSepeCfg, 'SepeCFG', 'CFG_IMPNFS', 'Imprimir NFSe', 'N', 1, 1) = 'S';
  FCFG_BOLNFS := BuscaCFG2(T2.qgSepeCfg, 'SepeCFG', 'CFG_BOLNFS', 'Imprimir boletos após envio da NFSe', 'N', 1, 1) = 'S';
  FCFG_ENVNFS := BuscaCFG2(T2.qgSepeCfg, 'SepeCFG', 'CFG_ENVNFS', 'Enviar E-mail NFSe', 'N', 1, 1) = 'S';
  FCFG_SMSSRV := BuscaCFG2(T2.qgSepeCfg, 'SepeCFG', 'CFG_SMSSRV', 'Enviar SMS do NFSe', 'N', 1, 1) = 'S';
  FCFG_OBNFS1 := BuscaCFG2(T2.qgSepeCfg, 'SepeCFG', 'CFG_OBNFS1', 'Observação para NFS-e (1)', '', 1, 200);
  FCFG_OBNFS2 := BuscaCFG2(T2.qgSepeCfg, 'SepeCFG', 'CFG_OBNFS2', 'Observação para NFS-e (2)', '', 1, 200);
  FCFG_SDECLI := BuscaCFG2(T2.qgSepeCfg, 'SepeCFG', 'CFG_SDECLI', 'O Serviço será executado na sede do cliente', 'N', 1, 1) = 'S';

  FNomeSchema := FPastaNFSe.PastaSchemasCid + 'nfse_v20_08_2015.xsd';
  FSilencio   := False;
end;

destructor TOperacoesNFSeMigrate.Destroy;
begin
  ProgressoClose;
  FListaRps.Free;
  FPastaNFSe.Free;
  FListaNotas.Free;
  inherited;
end;

procedure TOperacoesNFSeMigrate.Progresso(AMensagem: String; AProgress, AMax: Integer);
begin
  try
    if (F_IconesNfSe = Nil) then
      Application.CreateForm(TF_IconesNfSe, F_IconesNfSe);
    F_IconesNfSe.AtualizarProgresso(AMensagem, AProgress, AMax, False);
    F_IconesNfSe.Show;
  except
  end;
end;

procedure TOperacoesNFSeMigrate.ProgressoClose;
begin
  if (F_IconesNfSe <> Nil) then
  begin
    F_IconesNfSe.AtualizarProgresso(F_IconesNfSe.Registros.Caption, F_IconesNfSe.pbProcesso.Position, F_IconesNfSe.pbProcesso.Max);
    F_IconesNfSe.Close;
    FreeAndNil(F_IconesNfSe);
    Application.ProcessMessages;
  end;
end;

procedure TOperacoesNFSeMigrate.SetobDocs(const Value: TDocumento);
begin
  FobDocs := Value;
end;

function TOperacoesNFSeMigrate.PesquisaRSP_Nota(ASerie, ANumero: String): String;
var
  S: string;

begin
  Result:= '';

  S:= 'Select RPS_NRORPS';
  S:= S + sLineBreak + 'From SCRANFS';
  S:= S + sLineBreak + 'JOIN VENARPS ON RPS_NROPED = NFS_PED1';
  S:= S + sLineBreak + 'where NFS_SERIE = :pSerie';
  S:= S + sLineBreak + 'and   NFS_NUM   = :pNumero';

  T2.qC1.Close;
  T2.qC1.SQL.Clear;
  T2.qC1.SQL.Add(S);
  T2.qC1.ParamByName('pSerie').AsString:= ASerie;
  T2.qC1.ParamByName('pNumero').AsString:= ANumero;
  T2.qC1.Open;

  if not T2.qC1.IsEmpty then
     Result:= Nst(T2.qC1['RPS_NRORPS']);
end;

function TOperacoesNFSeMigrate.FormataNroEnd(Nro: String): String;
begin
  Result := Copy(LimpaNumero(Nro), 1, 6);

  if (Pos('SEM', UpperCase(Nro)) > 0) or (Pos('S/N', UpperCase(Nro)) > 0) then
    Result := '';
end;

function TOperacoesNFSeMigrate.FormatarMsgErro(AMsg: String): String;
var
  I:  Integer;
  PInv: String;

begin
// Exemplo da mensagem de retorno
//"Rejeitado - [#inv0328] - Mensagem retornada pela prefeitura: CÃ³digo: 301, Mensagem: Error3582 Nao e possivel registrar o mesmo numero para faturas distintas (Item: 1)[#inv0328] - Mensagem retornada pela prefeitura: CÃ³digo: 301, Mensagem: Error3582 Nao e possivel registrar o mesmo numero para faturas distintas (Item: 1)[#inv0328] - Mensagem retornada pela prefeitura: CÃ³digo: 200, Mensagem: Error3582 Nao e possivel registrar o mesmo numero para faturas distintas (Item: 2)"
//"Rejeitado -
//[#inv0328] - Mensagem retornada pela prefeitura: CÃ³digo: 301, Mensagem: Error3582 Nao e possivel registrar o mesmo numero para faturas distintas (Item: 1)
//[#inv0328] - Mensagem retornada pela prefeitura: CÃ³digo: 301, Mensagem: Error3582 Nao e possivel registrar o mesmo numero para faturas distintas (Item: 1)
//[#inv0328] - Mensagem retornada pela prefeitura: CÃ³digo: 200, Mensagem: Error3582 Nao e possivel registrar o mesmo numero para faturas distintas (Item: 2)"

   Result:= '';
   Repeat
     I:= Pos('[#inv',AMsg);

     PInv:= '';
     if I = 1 then
     begin
        PInv:= copy(AMsg, 1, 10); // Copia a parte [#invXXXX]
        AMsg:= copy(AMsg, 11,  length(AMsg));
     end;

     I:= Pos('[#inv',AMsg);
     if (I > 0) then
     begin
        if Length(Result) = 0 then
           Result:= PInv + copy (AMsg, 1, I-1)
        else
           Result:= Result +  PInv + copy (AMsg, 1, I-1) + sLineBreak;

        AMsg:= copy(AMsg, I,  length(AMsg));
     end
     else
        if Length(Result) > 0 then
           Result:= Result + sLineBreak + PInv + AMsg
        else
           Result:= PInv + AMsg;
   until I <= 0;

end;

function TOperacoesNFSeMigrate.ValidarLote(ALote: String): Boolean;
Var
  NomeArq: String;
begin
  Result := False;
  try
    T2.ACBrNFSe1.NotasFiscais.ValidarLote(ALote, FNomeSchema);
    Result := True;
  Except
    On E: Exception do
    begin
      NomeArq := FPastaNFSe.PastaTemporaria + '\NFSeLote' + ALote + '.xml';
      Application.CreateForm(TF_WebBrowseNFe, F_WebBrowseNFe);
      F_WebBrowseNFe.Caption := 'Visualização de Erros do XML';
      F_WebBrowseNFe.Memo1.Lines.Clear;
      F_WebBrowseNFe.Memo1.Lines.Add(T2.ACBrNFSe1.NotasFiscais.XMLLoteOriginal);
      F_WebBrowseNFe.Memo1.Lines.SaveToFile(NomeArq);
      F_WebBrowseNFe.Memo1.Lines.Clear;
      F_WebBrowseNFe.Memo1.Lines.Add('Lote:' + ALote);
      F_WebBrowseNFe.Memo1.Lines.Add('');
      F_WebBrowseNFe.Memo1.Lines.Add(E.Message);
      F_WebBrowseNFe.WebBrowser1.Navigate(NomeArq);
      F_WebBrowseNFe.NomeArq.Caption := NomeArq;
      F_WebBrowseNFe.MsgReduzida.Caption := 'O arquivo contém erros.';
      F_WebBrowseNFe.ShowModal;

      SysUtils.DeleteFile(NomeArq);
    end;
  end;
end;

function TOperacoesNFSeMigrate.Add(IdRps: Integer): Boolean;
Var
  obVenaRps: TVenarps;
begin
  Result := False;
  try
    obVenaRps := TVenarps.Create;
    obVenaRps.setRps_id(IdRps);
    if (obVenaRps.Consultar) then
      FListaRps.Add(obVenaRps)
    else
      obVenaRps.Free;

    Result := True;
  except
    on E: Exception do
      DL_Msg('Erro: ' + E.Message, Application.Title, 'ERRO')
    else
      DL_Msg('Ocorreu erro desconhecido ao adicionar item rps.', Application.Title, 'ERRO');
  end;
end;

Function TOperacoesNFSeMigrate.RPSSubtituir(ARps:String):Boolean;
var
  S: String;
begin
  S:= 'SELECT RPS_NROPED, RPS_NRORPS, RPS_DTARPS, PED_SERNFS, PED_NFS, NFS_EMIS, NFS_HORA';
  S:= S + sLineBreak + 'FROM VENARPS';
  S:= S + sLineBreak + 'JOIN VENAPED ON PED_NRO    = RPS_NROPED';
  S:= S + sLineBreak + 'JOIN SCRANFS ON PED_SERNFS = NFS_SERIE AND  PED_NFS = NFS_NUM';
  S:= S + sLineBreak + 'WHERE RPS_NRORPS = :pRps';

  T2.qC1.Close;
  T2.qC1.SQL.Clear;
  T2.qC1.SQL.Add(S);
  T2.qC1.ParamByName('pRps').AsString:= ARps;
  T2.qC1.Open;

  if T2.qC1.IsEmpty then
    Result:= False
  else
    Result:= True;
end;

function TOperacoesNFSeMigrate.CarregaCliente(obCliente:TClientes; obPedido:TPedidovendaFull; obCidade: TCidades; obPais: TPaises): Boolean;
begin
    Result:= False;

    obCliente.setCli_codigo(obPedido.getPed_codcli);
    if not obCliente.Consultar then
      Raise Exception.Create('Cliente ' + obPedido.getPed_codcli + ' não encontrado.' + #13 + 'No Pedido ' + obPedido.getPed_nro);

    if Trim(LimpaNumero(obCliente.getCli_cep)) = '' then
      Raise Exception.Create('Cliente ' + obPedido.getPed_codcli + ' Sem CEP.' + #13 + 'No pedido ' + obPedido.getPed_nro);

    obCidade.setMun_codigo(obCliente.getCli_codcid);
    if not obCidade.Consultar then
    begin
      Raise Exception.Create('Cidade do cliente ' + obCliente.getCli_codigo + '-' + obCliente.getCli_nome + ' não encontrada.' + #13 +
                             'Verifique o cadastro do cliente!' + #13 + 'Pedido ' + obPedido.getPed_nro);
    end;

    obPais.setPai_codigo(obCidade.getMun_codpai);
    if not obPais.Consultar then
    begin
      Raise Exception.Create('País da cidade ' + obCidade.getMun_codigo + '-' + obCidade.getMun_descri + ' não encontrado.' + #13 +
                             'Verifique o cadastro de municípios!' + #13 + 'Pedido ' + obPedido.getPed_nro);
    end;

    // se chegou até aqui, deu certo
    Result:= True;

end;

function TOperacoesNFSeMigrate.GeraLoteRps(ANumeroLote: String): Boolean;
Var
  LocalTrib, ComplEnd, CodObra, DescricaoProdutos, Hora, ObsPed: String;
  AlqPis, AlqCofins, ValorLiq, ValorBruto, BaseIrf, RetPis, RetCofins, RetIss, TBAseInss, TValorInss, AlqInss, BaseIssRet: Currency;
  NatOprNf: String;
  I, X: Integer;
  Ok: Boolean;
  Nat: TnfseNaturezaOperacao;
  Reg: TnfseRegimeEspecialTributacao;

  obPedido: TPedidovendaFull;
  obCliente: TClientes;
  obProduto: TProdutos;
  obObra: TCadobra;
  obCidade: TCidades;
  obPais: TPaises;
  obVenaIps: TVenaIps;

  ListaItens, ListaParcelas: TJSONArray;
  jbServico,    jbRPSSubs, jbPrestador, jbParcela, jbTomador, jbConstCivil,
  joEnderPrest, joValores, joParcela,   joLocalServio: TJSONObject;

begin

{$REGION 'JSON Padrão para envio da NFSe'}
// [
//  {
//    "Documento": {
//      "ModeloDocumento": "NFSE",
//      "Versao": 1.00,
//      "RPS": [
//        {
//          "RPSNumero": 1,
//          "RPSSerie": "251",
//          "RPSTipo": 1,
//          "dEmis": "2020-05-19T10:47:00",
//          "dCompetencia": "2020-05-19T10:03:00",
//          "LocalPrestServ": 0,
//          "natOp": 1,
//          "Operacao": "",
//          "NumProcesso": "",
//          "RegEspTrib": 6,
//          "OptSN": 1,
//          "IncCult": 2,
//          "Status": 1,
//          "cVerificaRPS": "",
//          "EmpreitadaGlobal": 0,
//          "tpAmb": 2,
//          "RPSSubs": {
//            "SubsNumero": 0,
//            "SubsSerie": "",
//            "SubsTipo": 0,
//            "SubsNFSeNumero": 0,
//            "SubsDEmisNFSe": "0000-00-00T00:00:00"
//          },
//          "Prestador": {
//            "CNPJ_prest": "24388580000285",
//            "xNome": "MOBIZZ",
//            "xFant": "MOBIZZ",
//            "IM": "726431",
//            "IE": "0650154223",
//            "CMC": "",
//            "enderPrest": {
//              "TPEnd": "RUA",
//              "xLgr": "R 14 DE JULHO",
//              "nro": "72",
//              "xCpl": "",
//              "xBairro": "CENTRO",
//              "cMun": 4310207,
//              "UF": "RS",
//              "CEP": 98700000,
//              "fone": "",
//              "Email": ""
//            }
//          },
//          "ListaItens": [
//            {
//              "ItemSeq": 1,
//              "ItemCod": "1",
//              "ItemDesc": "",
//              "ItemQtde": 1,
//              "ItemvUnit": 399.00,
//              "ItemuMed": "UN",
//              "ItemvlDed": 0,
//              "ItemTributavel": "",
//              "ItemcCnae": "",
//              "ItemTributMunicipio": "9512600",
//              "ItemnAlvara": "",
//              "ItemvIss": 11.97,
//              "ItemvDesconto": 0.00,
//              "ItemAliquota": 0.0300,
//              "ItemVlrTotal": 399.00,
//              "ItemBaseCalculo": 399.00,
//              "ItemvlrISSRetido": 0,
//              "ItemIssRetido": 2,
//              "ItemRespRetencao": 0,
//              "ItemIteListServico": "14.02",
//              "ItemExigibilidadeISS": 1,
//              "ItemcMunIncidencia": 0,
//              "ItemNumProcesso": "",
//              "ItemDedTipo": "",
//              "ItemDedCPFRef": "",
//              "ItemDedCNPJRef": "",
//              "ItemDedNFRef": 0,
//              "ItemDedvlTotRef": 0,
//              "ItemDedPer": 0,
//              "ItemVlrLiquido": 399.00,
//              "ItemValAliqINSS": 0.0000,
//              "ItemValINSS": 0.00,
//              "ItemValAliqIR": 0.0000,
//              "ItemValIR": 0.00,
//              "ItemValAliqCOFINS": 0.0000,
//              "ItemValCOFINS": 0.00,
//              "ItemValAliqCSLL": 0.0000,
//              "ItemValCSLL": 0.00,
//              "ItemValAliqPIS": 0.0000,
//              "ItemValPIS": 0.00,
//              "ItemRedBC": 0,
//              "ItemRedBCRetido": 0,
//              "ItemBCRetido": 0,
//              "ItemValAliqISSRetido": 0.0000,
//              "ItemPaisImpDevido": "",
//              "ItemJustDed": "",
//              "ItemvOutrasRetencoes": 0,
//              "ItemDescIncondicionado": 0.00,
//              "ItemDescCondicionado": 0.00,
//              "ItemTotalAproxTribServ": 0
//            }
//          ],
//          "ListaParcelas": [],
//          "Servico": {
//            "Valores": {
//              "ValServicos": 399.00,
//              "ValDeducoes": 0,
//              "ValPIS": 0.00,
//              "ValBCPIS": 0,
//              "ValCOFINS": 0.00,
//              "ValBCCOFINS": 0,
//              "ValINSS": 0.00,
//              "ValBCINSS": 0,
//              "ValIR": 0.00,
//              "ValBCIRRF": 0,
//              "ValCSLL": 0.00,
//              "ValBCCSLL": 0,
//              "RespRetencao": 0,
//              "Tributavel": "",
//              "ValISS": 11.97,
//              "ISSRetido": 2,
//              "ValISSRetido": 0,
//              "ValTotal": 0,
//              "ValTotalRecebido": 0,
//              "ValBaseCalculo": 399.00,
//              "ValOutrasRetencoes": 0,
//              "ValAliqISS": 0.030000,
//              "ValAliqPIS": 0.0000,
//              "PISRetido": 0,
//              "ValAliqCOFINS": 0.0000,
//              "COFINSRetido": 0,
//              "ValAliqIR": 0.0000,
//              "IRRetido": 0,
//              "ValAliqCSLL": 0.0000,
//              "CSLLRetido": 0,
//              "ValAliqINSS": 0.0000,
//              "INSSRetido": 0,
//              "ValAliqCpp": 0,
//              "CppRetido": 0,
//              "ValCpp": 0,
//              "OutrasRetencoesRetido": 0,
//              "ValBCOutrasRetencoes": 0,
//              "ValAliqOutrasRetencoes": 0,
//              "ValAliqTotTributos": 0,
//              "ValLiquido": 399.00,
//              "ValDescIncond": 0.00,
//              "ValDescCond": 0.00,
//              "ValAcrescimos": 0,
//              "ValAliqISSoMunic": 0.0000,
//              "InfValPIS": "",
//              "InfValCOFINS": "",
//              "ValLiqFatura": 0,
//              "ValBCISSRetido": 0,
//              "NroFatura": 0,
//              "CargaTribValor": 0,
//              "CargaTribPercentual": 0,
//              "CargaTribFonte": "",
//              "JustDed": "",
//              "ValCredito": 0,
//              "OutrosImp": 0,
//              "ValRedBC": 0,
//              "ValRetFederais": 0,
//              "ValAproxTrib": 0
//            },
//            "LocalPrestacao": {
//              "SerEndTpLgr": "",
//              "SerEndLgr": "",
//              "SerEndNumero": "",
//              "SerEndComplemento": "",
//              "SerEndBairro": "",
//              "SerEndxMun": "",
//              "SerEndcMun": 0,
//              "SerEndCep": 0,
//              "SerEndSiglaUF": ""
//            },
//            "IteListServico": "14.02",
//            "Cnae": 0,
//            "fPagamento": "",
//            "tpag": 0,
//            "TributMunicipio": "9512600",
//            "TributMunicDesc": "",
//            "Discriminacao": "MAO DE OBRA",
//            "cMun": 4310207,
//            "SerQuantidade": 0,
//            "SerUnidade": "",
//            "SerNumAlvara": "",
//            "PaiPreServico": "BR",
//            "cMunIncidencia": 0,
//            "dVencimento": "0000-00-00T00:00:00",
//            "ObsInsPagamento": "",
//            "ObrigoMunic": 0,
//            "TributacaoISS": 0,
//            "CodigoAtividadeEconomica": "",
//            "ServicoViasPublicas": 0,
//            "NumeroParcelas": 0,
//            "NroOrcamento": 0,
//            "CodigoNBS": ""
//          },
//          "Tomador": {
//            "TomaCNPJ": "02663790000110",
//            "TomaCPF": "",
//            "TomaIE": "",
//            "TomaIM": "",
//            "TomaRazaoSocial": "AGROINOX",
//            "TomatpLgr": "AV",
//            "TomaEndereco": "Pde Dehon",
//            "TomaNumero": "153",
//            "TomaComplemento": "",
//            "TomaBairro": "CENTRO",
//            "TomacMun": 4302204,
//            "TomaxMun": "Boa vista do buricá",
//            "TomaUF": "RS",
//            "TomaPais": "BR",
//            "TomaCEP": 98918000,
//            "TomaTelefone": "5537481081",
//            "TomaTipoTelefone": "",
//            "TomaEmail": "",
//            "TomaSite": "",
//            "TomaIME": "",
//            "TomaSituacaoEspecial": "",
//            "DocTomadorEstrangeiro": "",
//            "TomaRegEspTrib": 0,
//            "TomaCadastroMunicipio": 0,
//            "TomaOrgaoPublico": 0
//          },
//          "IntermServico": {
//            "IntermRazaoSocial": "",
//            "IntermCNPJ": "",
//            "IntermCPF": "",
//            "IntermIM": "",
//            "IntermEmail": "",
//            "IntermEndereco": "",
//            "IntermNumero": "",
//            "IntermComplemento": "",
//            "IntermBairro": "",
//            "IntermCep": 0,
//            "IntermCmun": 0,
//            "IntermXmun": "",
//            "IntermFone": "",
//            "IntermIE": ""
//          },
//          "ConstCivil": {
//            "CodObra": "",
//            "Art": "",
//            "ObraLog": "",
//            "ObraCompl": "",
//            "ObraNumero": "",
//            "ObraBairro": "",
//            "ObraCEP": 0,
//            "ObraMun": 0,
//            "ObraUF": "",
//            "ObraPais": "",
//            "ObraCEI": "",
//            "ObraMatricula": "",
//            "ObraValRedBC": 0,
//            "ObraTipo": 0,
//            "ObraNomeFornecedor": "",
//            "ObraNumeroNF": 0,
//            "ObraDataNF": "0000-00-00T00:00:00",
//            "ObraNumEncapsulamento": "",
//            "AbatimentoMateriais": 0,
//            "ListaMaterial": []
//          },
//          "ListaDed": [],
//          "Transportadora": {
//            "TraNome": "",
//            "TraCPFCNPJ": "",
//            "TraIE": "",
//            "TraPlaca": "",
//            "TraEnd": "",
//            "TraMun": 0,
//            "TraUF": "",
//            "TraPais": "",
//            "TraTipoFrete": 0
//          },
//          "NFSOutrasinformacoes": "",
//          "RPSCanhoto": 0,
//          "Arquivo": "",
//          "ExtensaoArquivo": ""
//        }
//      ]
//    }
//  }
// ]
{$ENDREGION}

  obPedido  := TPedidovendaFull.Create;
  obCliente := TClientes.Create;
  obProduto := TProdutos.Create;
  obObra    := TCadobra.Create;
  obCidade  := TCidades.Create;
  obPais    := TPaises.Create;
  obVenaIps := TVenaIps.Create;

  Nat       := StrToNaturezaOperacao(Ok, FCFG_NATRPS);

  if (Ok = False) then
    raise Exception.Create('Natureza de operação para RPS inválida');

  Reg := StrToRegimeEspecialTributacao(Ok, FCFG_REGTRI);
  if (Ok = False) then
    raise Exception.Create('Regime de tributação especial para RPS inválido');

  Try
    obDocs.Clear;
    for I := 0 to FListaRps.Count - 1 do
    begin
      BaseIrf   := 0;
      RetPis    := 0;
      RetCofins := 0;
      RetIss    := 0;
      AlqPis    := 0;
      AlqCofins := 0;
      TBAseInss := 0;
      TValorInss:= 0;
      AlqInss   := 0;
      BaseIssRet:= 0;
      ValorLiq  := 0;
      ValorBruto:= 0;

      // Podem ser adicionados vários RPSs por documento
      With obDocs.AddRps do
      begin
        // AddPair('RPSNumero', TJSONNumber.Create(ANumeroLote));
        obPedido.LimpaObj;
        obPedido.setPed_nro(FListaRps.Items[I].getRps_nroped);
        if (obPedido.Consultar) then
        begin

          // carrega o objeto cliente e verifica se está com o cadastro correto para geração da nota
          if not CarregaCliente(obCliente, obPedido, obCidade, obPais) then
             exit;

          // sempre incia a NatOprNf, com o que está cadastrado nos parametros de configuração
          NatOprNf:= FCFG_NATRPS;
          ObsPed  := '';

          if (Trim(obPedido.getPed_obs1) <> '') then
            ObsPed := obPedido.getPed_obs1 + ' ';
            //DescricaoProdutos := DescricaoProdutos + obPedido.getPed_obs1 + ' ';

          if (Trim(obPedido.getPed_obs3) <> '') then // a Ped_obs2 é a obs de expedição e não deve aparecer aqui
            ObsPed := ObsPed + obPedido.getPed_obs3 + ' ';
           // DescricaoProdutos := DescricaoProdutos + obPedido.getPed_obs3 + ' ';

          if (Trim(obPedido.getPed_obs4) <> '') then
            ObsPed := ObsPed + obPedido.getPed_obs4;
           // DescricaoProdutos := DescricaoProdutos + obPedido.getPed_obs4;


{$REGION 'Identificação da NFSe'}
          AddPair('RPSNumero',        TJSONNumber.Create(Nvl(FListaRps.Items[I].getRps_nrorps)));
          AddPair('RPSSerie',         TJSONString.Create(FListaRps.Items[I].getRps_serie));
          AddPair('RPSTipo',          TJSONNumber.Create(1)); // Tipo 1 = Sempre com RPS

          Hora := obPedido.getPed_hora;
          if Hora.Trim.Length < 8 then
            Hora := FormatDateTime('hh:nn:ss', Now);

          AddPair('dEmis',            TJSONString.Create(FormatDateTime('yyyy-mm-dd', obPedido.getPed_data) + 'T' + Hora));
          AddPair('dCompetencia',     TJSONString.Create(FormatDateTime('yyyy-mm-dd', obPedido.getPed_data) + 'T' + Hora));

          //AddPair('natOp',            TJSONNumber.Create(FCFG_NATRPS));
          AddPair('natOp',            TJSONNumber.Create(NatOprNf));
          AddPair('RegEspTrib',       TJSONNumber.Create(FCFG_REGTRI));

          if FCFG_SMPNAC then
            AddPair('OptSN',          TJSONNumber.Create(1))
          else
            AddPair('OptSN',          TJSONNumber.Create(2));

          AddPair('IncCult',          TJSONNumber.Create(2));
          AddPair('Status',           TJSONNumber.Create(1));
          AddPair('EmpreitadaGlobal', TJSONNumber.Create(2));
          AddPair('tpAmb',            TJSONNumber.Create(FCFG_NFSAMB));
{$ENDREGION}

{$REGION 'ListaItens'}
          // Quando tem retenção do ISSQN o local da tributação (cidade) é do endereço da obra.
          // Falei com o Fiscal da Prefeitura de Caxias, ele disse que pode haver exeções devido a legislação municipal de cada cidade,
          // mas em regra geral é assim que funciona. Caso ocorra algum situação diferente temos que contornar ou fazer algum ajuste no sistema
          DescricaoProdutos := '';

          // Criar o array de Lista de Itens
          ListaItens := TJSONArray.Create;
          AddPair('ListaItens', ListaItens);
          with ListaItens do
          begin
            // Local tributação, código do muncípio da empresa que está emitindo a NF-e
            LocalTrib := BuscaEmpresa(T2.qEmpresa, 'CODCIDADE');

            obPedido.GetItensBD;

            for X := 0 to obPedido.Itens.Count - 1 do
            begin
              obProduto.setPro_codigo(obPedido.Itens[X].getIpd_codpro);
              if (obProduto.Consultar) then
              begin
                if (Trim(obProduto.getPro_srvmun) = '') or (Trim(obProduto.getPro_srvfed) = '') then
                  raise Exception.Create('Código municipal de serviço e ou código federal de serviço não informados no produto: ' +
                                          obProduto.getPro_codigo + sLineBreak + sLineBreak + 'É impossível continuar.');
              end;

              obVenaIps.setIps_id(obPedido.Itens[X].getIpd_ids);
              if not obVenaIps.Consultar then
                  raise Exception.Create('Não foram encontrados dados corretos do calculo dos tributos sobre o serviço');

              // se tem retençao do ISSQN ou Natrueza da operação = '1',
              // o local da tributação tem que ser o múnicipio do cliente ou da obra, quando tiver obra
              if (obVenaIps.getIps_retiss = 'S') or (NatOprNf = '1') then
              begin
                obObra.setObr_codigo(obPedido.getPed_CodObra);
                if obObra.Consultar then
                begin
                  obCidade.setMun_codigo(obObra.getObr_codcid);
                  if obCidade.Consultar then
                  begin
                     LocalTrib := obCidade.getMun_codmec;
                     NatOprNf  := '1'; // alterar para ficar com o valor padrão da Migrate de local de tributação = ao destino
                  end;
                end
                else // se não tem obra cadastrada e tem retenção do ISSQN, o local de tributação é o municipio do cliente
                begin
                  obCidade.setMun_codigo(obCliente.getCli_codcid);
                  if obCidade.Consultar then
                  begin
                     LocalTrib := obCidade.getMun_codmec;
                     NatOprNf  := '1'; // alterar para ficar com o valor padrão da Migrate de local de tributação = ao destino
                  end;
                 // if not obPedido.obCliente.obCidadePrincipal.getMun_codmec.Trim.IsEmpty then
                 // begin
                 //    LocalTrib := obPedido.obCliente.obCidadePrincipal.getMun_codmec;
                 //    NatOprNf  := '1'; // alterar para ficar com o valor padrão da Migrate de local de tributação = ao destino
                 // end;
                end;
              end;

              // salva aqui as aliquotas de PIS/COFINS para usar mais abaixo
              AlqPis    := obPedido.Itens[X].getIpd_alqpis;
              AlqCofins := obPedido.Itens[X].getIpd_alqcof;
              AlqInss   := obVenaIps.getIps_prinss;
              TBAseInss := TBAseInss  + obVenaIps.getIps_bainss;
              TValorInss:= TValorInss + obVenaIps.getIps_vlinss;

              // Cria o Json do item atual
              ListaItens.AddElement(TJSONObject.Create);
              with TJSONObject(ListaItens.Get(ListaItens.Size - 1)) do
              begin
                BaseIrf   := BaseIrf    + obVenaIps.getIps_bairf;  // não tem esse valor acumulado no cab. do pedido
                ValorLiq  := ValorLiq   + obPedido.Itens[X].getIpd_vlrlin;
                ValorBruto:= ValorBruto + (obPedido.Itens[X].getIpd_qtde * obPedido.Itens[X].getIpd_vlrunt);

                AddPair('ItemSeq',                TJSONNumber.Create(ListaItens.Size));
                AddPair('ItemCod',                TJSONString.Create(obPedido.Itens[X].getIpd_codpro));
                AddPair('ItemDesc',               TJSONString.Create(obPedido.Itens[X].getIpd_descri));
                AddPair('ItemQtde',               TJSONNumber.Create(obPedido.Itens[X].getIpd_qtde));
                AddPair('ItemvUnit',              TJSONNumber.Create(obPedido.Itens[X].getIpd_vlrunt));
                AddPair('ItemuMed',               TJSONString.Create(obProduto.getPro_und));
                AddPair('ItemvlDed',              TJSONNumber.Create(0));
                AddPair('ItemTributavel',         TJSONString.Create(''));
                AddPair('ItemcCnae',              TJSONString.Create(BuscaEmpresa(T2.qEmpresa, 'CNAE')));
                AddPair('ItemTributMunicipio',    TJSONString.Create(obProduto.getPro_srvmun));
                AddPair('ItemnAlvara',            TJSONString.Create(''));

                AddPair('ItemvDesconto',          TJSONNumber.Create(obPedido.Itens[X].getIpd_desc));
                AddPair('ItemVlrTotal',           TJSONNumber.Create(ValorBruto)); // TJSONNumber.Create(obPedido.Itens[X].getIpd_vlrlin));

                AddPair('ItemIteListServico',     TJSONString.Create(obProduto.getPro_srvfed));
               // AddPair('ItemExigibilidadeISS',   TJSONNumber.Create(FCFG_NATRPS));
                AddPair('ItemExigibilidadeISS',   TJSONNumber.Create(NatOprNf));
                AddPair('ItemcMunIncidencia',     TJSONNumber.Create(LocalTrib));
                AddPair('ItemNumProcesso',        TJSONString.Create(''));
                AddPair('ItemDedTipo',            TJSONString.Create(''));
                AddPair('ItemDedCPFRef',          TJSONString.Create(''));
                AddPair('ItemDedCNPJRef',         TJSONString.Create(''));
                AddPair('ItemDedNFRef',           TJSONNumber.Create(0));
                AddPair('ItemDedvlTotRef',        TJSONNumber.Create(0));
                AddPair('ItemDedPer',             TJSONNumber.Create(0));
               // AddPair('ItemVlrLiquido',         TJSONNumber.Create(ValorLiq)); // lança no final pois tem que calcular
                AddPair('ItemValAliqINSS',        TJSONNumber.Create(obVenaIps.getIps_prinss));
                AddPair('ItemValINSS',            TJSONNumber.Create(obVenaIps.getIps_vlinss));
                AddPair('ItemValAliqIR',          TJSONNumber.Create(obVenaIps.getIps_prirf));
                AddPair('ItemValIR',              TJSONNumber.Create(obVenaIps.getIps_vlirf));

                // só preenche estes campos se tiver retenção de PIS/COFINS
                if obVenaIps.getIps_retpis = 'S' then
                begin
                    AddPair('ItemValAliqCOFINS',  TJSONNumber.Create(obPedido.Itens[X].getIpd_alqcof));
                    AddPair('ItemValCOFINS',      TJSONNumber.Create(obPedido.Itens[X].getIpd_cofvlr));
                    AddPair('ItemValAliqPIS',     TJSONNumber.Create(obPedido.Itens[X].getIpd_alqpis));
                    AddPair('ItemValPIS',         TJSONNumber.Create(obPedido.Itens[X].getIpd_pisvlr));
                    AddPair('ItemValAliqCSLL',    TJSONNumber.Create(0));
                    AddPair('ItemValCSLL',        TJSONNumber.Create(0));

                   RetPis    := RetPis    + obPedido.Itens[X].getIpd_pisvlr;
                   RetCofins := RetCofins + obPedido.Itens[X].getIpd_cofvlr;

                   // desconta o IR e outros somente das duplicatas e valor liquido
                  if not Self.FCFG_SUBIRF then
                      ValorLiq := ValorLiq - obPedido.Itens[X].getIpd_pisvlr - obPedido.Itens[X].getIpd_cofvlr;
                end;

                AddPair('ItemRedBC',              TJSONNumber.Create(obVenaIps.getIps_rdiss));

                // SEM retenção do ISS
                if obVenaIps.getIps_retiss <> 'S' then
                begin
                   AddPair('ItemvIss',            TJSONNumber.Create(obVenaIps.getIps_vliss));
                   AddPair('ItemAliquota',        TJSONNumber.Create(obVenaIps.getIps_priss/100));
                   AddPair('ItemBaseCalculo',     TJSONNumber.Create(obVenaIps.getIps_baiss));
                   AddPair('ItemvlrISSRetido',     TJSONNumber.Create(0));
                   AddPair('ItemIssRetido',        TJSONNumber.Create(2));
                   AddPair('ItemRespRetencao',     TJSONNumber.Create(3)); // Responsavel pela retenção é o PRESTADOR
                end
                else  // COM retenção do ISS
                begin
                  AddPair('ItemRedBcRetido',      TJSONNumber.Create(0));
                  AddPair('ItemBCRetido',         TJSONNumber.Create(obVenaIps.getIps_baiss));
                  AddPair('ItemValAliqISSRetido', TJSONNumber.Create(obVenaIps.getIps_priss/100));
                  AddPair('ItemvlrISSRetido',     TJSONNumber.Create(obVenaIps.getIps_vliss));
                  AddPair('ItemIssRetido',        TJSONNumber.Create(obVenaIps.getIps_vliss));

                  RetIss    := RetIss + obVenaIps.getIps_vliss;
                  BaseIssRet:= BaseIssRet + obVenaIps.getIps_baiss;

                 // desconta o iss somente das duplicatas e valor liquido
                 if (not Self.FCFG_SUBISS) then
                    ValorLiq := ValorLiq - obVenaIps.getIps_vliss;
                end;


                {
                if obVenaIps.getIps_retiss = 'S' then
                begin
                  AddPair('ItemBCRetido',         TJSONNumber.Create(obVenaIps.getIps_baiss));
                  AddPair('ItemValAliqISSRetido', TJSONNumber.Create(obVenaIps.getIps_priss/100));


                  RetIss    := RetIss + obVenaIps.getIps_vliss;
                  BaseIssRet:= BaseIssRet + obVenaIps.getIps_baiss;

                 // desconta o iss somente das duplicatas e valor liquido
                 if (not Self.FCFG_SUBISS) then
                    ValorLiq := ValorLiq - obVenaIps.getIps_vliss;
                end;
                }
                AddPair('ItemPaisImpDevido',      TJSONString.Create(''));
                AddPair('ItemJustDed',            TJSONString.Create(''));
                AddPair('ItemvOutrasRetencoes',   TJSONNumber.Create(0));
                AddPair('ItemDescIncondicionado', TJSONNumber.Create(obPedido.Itens[X].getIpd_desc));
                AddPair('ItemDescCondicionado',   TJSONNumber.Create(0));

                if Self.FCFG_MTRNFS then
                  AddPair('ItemTotalAproxTribServ', TJSONNumber.Create(obPedido.Itens[X].getIpd_vltrib));

                obProduto.setPro_codigo(obPedido.Itens[0].getIpd_codpro);
                obProduto.Consultar;

                // desconta o IR e outros somente das duplicatas e valor liquido
                if not Self.FCFG_SUBIRF then
                   ValorLiq := ValorLiq - obVenaIps.getIps_vlirf;

                AddPair('ItemVlrLiquido',         TJSONNumber.Create(ValorLiq));

                DescricaoProdutos := DescricaoProdutos + obPedido.Itens[X].getIpd_descri + ' ';
              {
                if obVenaIps.getIps_retiss = 'S' then
                begin
                  obObra.setObr_codigo(obPedido.getPed_CodObra);
                  if obObra.Consultar then
                  begin
                    obCidade.setMun_codigo(obObra.getObr_codcid);
                    if obCidade.Consultar then
                      LocalTrib := obCidade.getMun_codmec;
                  end
              // Aqui - deu erro quando estava na faze de testes, por isso está comentado
              //    else // se não tem obra cadastrada e tem retenção do ISSQN, o local de tributação é o municipio do cliente
              //    begin
              //      if not obPedido.obCliente.obCidadePrincipal.getMun_codmec.Trim.IsEmpty then
              //        LocalTrib := obPedido.obCliente.obCidadePrincipal.getMun_codmec;
              //    end;
                end;
              }
              end; // Cria o Json do item atual - AddElement(TJSONObject.Create);
            end; // for X := 0 to obPedido.Itens.Count - 1 do
          end; // Criar o array de Lista de Itens - with TJSONArray(AddPair('ListaItens', TJSONArray.Create)) do

{$ENDREGION}

{$REGION 'ListaParcelas'}
          // Dados do parcelamento
          ListaParcelas := TJSONArray.Create;
          AddPair('ListaParcelas', ListaParcelas);
          with ListaParcelas do
          begin
            obPedido.GetParceBD;

            for X := 0 to obPedido.Parce.Count - 1 do
            begin
                joParcela := TJSONObject.Create;
                ListaParcelas.AddElement(joParcela);
                with joParcela do
                begin
                    AddPair('PrcSequencial',      TJSONNumber.Create(ListaParcelas.Size));
                    AddPair('PrcValor',           TJSONNumber.Create(obPedido.Parce[X].getPg_valor));
                    AddPair('PrcDtaVencimento',   TJSONString.Create(FormatDateTime('yyyy-mm-dd', obPedido.Parce[X].getPg_data)));
//                    AddPair('PrcNroFatura',       TJSONNumber.Create(1));   // Aqui pode ser um problema, como não nota gerada a ainda, não pode repetir o memo numero em mais que uma parcela
                    AddPair('PrcNroFatura',       TJSONNumber.Create(ListaParcelas.Size));   // Aqui pode ser um problema, como não nota gerada a ainda, não pode repetir o memo numero em mais que uma parcela
                    AddPair('PrcTipVenc',         TJSONNumber.Create('1')); // 1 - Data Certa 2 - Apresentação 3 - À vista 4 - Outros 5 - A Prazo 6 - Cartão de Crédito (exclusivo IPM) 7 - Cartão de Débito (exclusivo IPM)
                    AddPair('PrcDscTipVenc',      TJSONString.Create(''));
                    AddPair('PrcValLiquido',      TJSONNumber.Create(obPedido.Parce[X].getPg_valor));
                    AddPair('PrcValDesconto',     TJSONNumber.Create(0));
                end; //with joParcela do
              end;  //with ListaParcelas do
            end; // for X := 0 to obPedido.Parce.Count - 1 do

{$ENDREGION}

{$REGION 'Servico'}
       // Dados do somatório de todos os serviços do RPS
          jbServico := TJSONObject.Create;
          AddPair('Servico', jbServico);
          With jbServico do
          begin
            obProduto.setPro_codigo(obPedido.Itens[0].getIpd_codpro); // Ademar disse para pegar do primeiro
            if (obProduto.Consultar) then
            begin
              if (Trim(obProduto.getPro_srvmun) = '') or (Trim(obProduto.getPro_srvfed) = '') then
                  raise Exception.Create('Código municipal de serviço e ou código federal de serviço não informados no produto: ' +
                                         obProduto.getPro_codigo + sLineBreak + sLineBreak + 'É impossível continuar.');
            end;

            joValores := TJSONObject.Create;
            jbServico.AddPair('Valores', joValores);

            With joValores do
            begin

              AddPair('ValServicos',    TJSONNumber.Create(obPedido.getPed_basiss));

              AddPair('ValPIS',         TJSONNumber.Create(RetPis));       // esse valor só é calculado se tem retenção
              AddPair('ValBCPIS',       TJSONNumber.Create(obPedido.getPed_bpiscof));
              AddPair('ValCOFINS',      TJSONNumber.Create(RetCofins));    // esse valor só é calculado se tem retenção
              AddPair('ValBCCOFINS',    TJSONNumber.Create(obPedido.getPed_bpiscof));
              AddPair('ValINSS',        TJSONNumber.Create(obPedido.getPed_vlinss));
              AddPair('ValBCINSS',      TJSONNumber.Create(obPedido.getPed_bainss));
              AddPair('ValIR',          TJSONNumber.Create(obPedido.getPed_vlrirf));
              AddPair('ValBCIRRF',      TJSONNumber.Create(BaseIrf));

              AddPair('ValCSLL',        TJSONNumber.Create(0));
              AddPair('ValBCCSLL',      TJSONNumber.Create(0));
              AddPair('ValDeducoes',    TJSONNumber.Create(0));

              if obVenaIps.getIps_retiss = 'S' then
                 AddPair('RespRetencao',TJSONNumber.Create(1)) // Responsavel pela retenção é o TOMADOR
              else
                 AddPair('RespRetencao',TJSONNumber.Create(3));  // Esse código é para dizer que o responsável pela retenção é o emitente

              AddPair('Tributavel',     TJSONString.Create(''));

              if obVenaIps.getIps_retiss <> 'S' then
                 AddPair('ValISS',      TJSONNumber.Create(obPedido.getPed_vlriss));

              // ISSRetido = 1-Sim   2-Nâo  3-Substituição Tributária - Exclusivo Pdrão Betha 1.0
              if obVenaIps.getIps_retiss = 'S' then
              begin
                 AddPair('ISSRetido',   TJSONNumber.Create(1));
                 AddPair('ValISSRetido',TJSONNumber.Create(RetIss));
              end
              else
              begin
                 AddPair('ISSRetido',   TJSONNumber.Create(2));
                 AddPair('ValISSRetido',TJSONNumber.Create(0));
              end;

              AddPair('ValTotal',           TJSONNumber.Create(ValorBruto));
              AddPair('ValTotalRecebido',   TJSONNumber.Create(ValorLiq));

              if obVenaIps.getIps_retiss <> 'S' then
                 AddPair('ValBaseCalculo',  TJSONNumber.Create(obPedido.getPed_basiss));

              AddPair('ValOutrasRetencoes', TJSONNumber.Create(0));
              AddPair('ValAliqISS',         TJSONNumber.Create(obPedido.getPed_iss/100)); // Esse campo deve ser dividido por 100
              AddPair('ValAliqPIS',         TJSONNumber.Create(AlqPis/100)); // Esse campo deve ser dividido por 100
              AddPair('PISRetido',          TJSONNumber.Create(RetPis));       // esse valor só é calculado se tem retenção

              AddPair('ValAliqCOFINS',      TJSONNumber.Create(AlqCofins/100)); // Esse campo deve ser dividido por 100
              AddPair('COFINSRetido',       TJSONNumber.Create(RetCofins));    // esse valor só é calculado se tem retenção
              AddPair('ValAliqIR',          TJSONNumber.Create(obPedido.getPed_alqirf/100)); // Esse campo deve ser dividido por 100
              AddPair('IRRetido',           TJSONNumber.Create(obPedido.getPed_vlrirf));

              AddPair('ValAliqCSLL',        TJSONNumber.Create(0));
              AddPair('CSLLRetido',         TJSONNumber.Create(0));

              AddPair('ValAliqINSS',        TJSONNumber.Create(AlqInss/100)); // Esse campo deve ser dividido por 100
              AddPair('INSSRetido',         TJSONNumber.Create(TValorInss));

              AddPair('ValAliqCpp',             TJSONNumber.Create(0));
              AddPair('CppRetido',              TJSONNumber.Create(0));
              AddPair('ValCpp',                 TJSONNumber.Create(0));
              AddPair('OutrasRetencoesRetido',  TJSONNumber.Create(0));
              AddPair('ValBCOutrasRetencoes',   TJSONNumber.Create(0));
              AddPair('ValAliqOutrasRetencoes', TJSONNumber.Create(0));
              AddPair('ValAliqTotTributos',     TJSONNumber.Create(0));

              // o valor liquido pode não ser o valor exato do pedido,
              // depende dos paramentos se desconta os valores retidos do ISS, IR, PIS, COFINS e CSL
              ValorLiq := obPedido.getPed_tot1;

             // desconta o iss somente das duplicatas e valor liquido
             if (not Self.FCFG_SUBISS) then
                ValorLiq := ValorLiq - RetIss;;

             // desconta o IR/PIS/COFINS somente das duplicatas e valor liquido
             if not Self.FCFG_SUBIRF then
                ValorLiq := ValorLiq - obPedido.getPed_vlrirf - RetPis - RetCofins;

              AddPair('ValLiquido',             TJSONNumber.Create(ValorLiq));
              AddPair('ValDescIncond',          TJSONNumber.Create(obPedido.getPed_desc));
              AddPair('ValDescCond',            TJSONNumber.Create(0));
              AddPair('ValAcrescimos',          TJSONNumber.Create(0));

              AddPair('ValLiqFatura',           TJSONNumber.Create(ValorLiq));

              if obVenaIps.getIps_retiss = 'S' then
                 AddPair('ValBCISSRetido',      TJSONNumber.Create(BaseIssRet));

              AddPair('NroFatura',              TJSONNumber.Create(0));  // como preencher o nro da fatura, se não exite a nota ainda.

              if Self.FCFG_MTRNFS then
              begin
                AddPair('CargaTribValor',       TJSONNumber.Create(obPedido.getPed_vltrib));
                AddPair('CargaTribPercentual',  TJSONNumber.Create(obPedido.getPed_prTrib));
                AddPair('CargaTribFonte',       TJSONString.Create('IBPT'));
                AddPair('ValAproxTrib',         TJSONNumber.Create(obPedido.getPed_vltrib));
              end;

              AddPair('JustDed',                TJSONString.Create(''));
              AddPair('ValCredito',             TJSONNumber.Create(0));
              AddPair('ValRedBC',               TJSONNumber.Create(0));
              AddPair('ValRetFederais',         TJSONNumber.Create(0));

            end; // With AddPair('Valores', TJSONObject.Create) do

            // quando o serviço é executado na sede do cliente tem que informar no local da prestação o endereço do cliente
            if FCFG_SDECLI then
            begin
              joLocalServio := TJSONObject.Create;
              jbServico.AddPair('LocalPrestacao', joLocalServio);

              With joLocalServio do
              begin

                AddPair('SerEndTpLgr',      TJSONString.Create(''));
                AddPair('SerEndLgr',        TJSONString.Create(obCliente.getCli_end));
                AddPair('SerEndNumero',     TJSONString.Create(FormataNroEnd(obCliente.getCli_nroend)));
                AddPair('SerEndComplemento',TJSONString.Create(obCliente.getCli_endcom));
                AddPair('SerEndBairro',     TJSONString.Create(obCliente.getCli_bairro));
                AddPair('SerEndxMun',       TJSONString.Create(obCidade.getMun_descri));
                AddPair('SerEndcMun',       TJSONNumber.Create(obCidade.getMun_codmec));
                AddPair('SerEndCep',        TJSONNumber.Create(LimpaNumero(obCliente.getCli_cep)));
                AddPair('SerEndSiglaUF',    TJSONString.Create(obCliente.getCli_uf));
              end;
            end;

            AddPair('IteListServico',     TJSONString.Create(obProduto.getPro_srvfed));
            AddPair('Cnae',               TJSONNumber.Create(BuscaEmpresa(T2.qEmpresa, 'CNAE')));
            AddPair('fPagamento',         TJSONString.Create(EmptyStr));
            AddPair('tpag',               TJSONNumber.Create(0));
            AddPair('TributMunicipio',    TJSONString.Create(obProduto.getPro_srvmun));
            AddPair('TributMunicDesc',    TJSONString.Create(EmptyStr));
            AddPair('Discriminacao',      TJSONString.Create(DescricaoProdutos + ' ' + ObsPed));
            AddPair('cMun',               TJSONNumber.Create(Empresa.getCodcidade));
            AddPair('SerQuantidade',      TJSONNumber.Create(0));
            AddPair('SerUnidade',         TJSONString.Create(EmptyStr));
            AddPair('SerNumAlvara',       TJSONString.Create(EmptyStr));
            AddPair('PaiPreServico',      TJSONString.Create('BR'));
            AddPair('cMunIncidencia',     TJSONNumber.Create(LocalTrib));
            AddPair('dVencimento',        TJSONString.Create('0000-00-00T00:00:00'));
            AddPair('ObsInsPagamento',    TJSONString.Create(EmptyStr));
            AddPair('ObrigoMunic',        TJSONNumber.Create(0));
            AddPair('TributacaoISS',      TJSONNumber.Create(0));
            AddPair('CodigoAtividadeEconomica', TJSONString.Create(''));
            AddPair('ServicoViasPublicas',TJSONNumber.Create(0));
            AddPair('NumeroParcelas',     TJSONNumber.Create(0));
            AddPair('NroOrcamento',       TJSONNumber.Create(0));
            AddPair('CodigoNBS',          TJSONString.Create(''));
          end; // With AddPair('Servico', TJSONObject.Create) do

{$ENDREGION}

{$REGION 'RPSSubtituido'}
          if Nst(FListaRps.Items[I].getRSP_NRPSUB) <> '' then
          begin
            // pesquisa a RSP que tem que ser substituida, para localizar a nota, a data e hora
            if RPSSubtituir(Nst(FListaRps.Items[I].getRSP_NRPSUB)) then
            begin
               jbRPSSubs := TJSONObject.Create;
               AddPair('RPSSubs', jbRPSSubs);
               With jbRPSSubs do
               begin
                 Hora := FormatDateTime('hh:nn:ss', StrToTime(Nst(T2.qC1['NFS_HORA'])));
                 AddPair('SubsNumero',     TJSONNumber.Create(Nvl(FListaRps.Items[I].getRSP_NRPSUB)));
                 AddPair('SubsSerie',      TJSONString.Create(FListaRps.Items[I].getRps_serie));
                 AddPair('SubsTipo',       TJSONNumber.Create(1));                                   // Tipo 1 = Sempre com RPS
                 AddPair('SubsNFSeNumero', TJSONNumber.Create(Nvl(T2.qC1['PED_NFS'])));
                 AddPair('SubsDEmisNFSe',  TJSONString.Create(FormatDateTime('yyyy-mm-dd', T2.qC1['NFS_EMIS']) + 'T'+Hora));
              end;
            end;
          end;
{$ENDREGION}

{$REGION 'Prestador'}
          jbPrestador := TJSONObject.Create;
          AddPair('Prestador', jbPrestador);
          With jbPrestador do
          begin
            AddPair('CNPJ_prest', TJSONString.Create(StrZero(LimpaNumero(Empresa.getCgcmf), 14)));
            AddPair('xNome',      TJSONString.Create(Empresa.getRazaosoc));
            AddPair('xFant',      TJSONString.Create(Empresa.getFantasia));
            AddPair('IM',         TJSONString.Create(LimpaNumero(Empresa.getInsmun)));
            AddPair('IE',         TJSONString.Create(LimpaNumero(Empresa.getInsest)));

            joEnderPrest := TJSONObject.Create;
            jbPrestador.AddPair('enderPrest', joEnderPrest);
            With joEnderPrest do
            begin
              AddPair('TpEnd',    TJSONString.Create(EmptyStr));
              AddPair('xLgr',     TJSONString.Create(Empresa.getEndereco));
              AddPair('nro',      TJSONString.Create(FormataNroEnd(Empresa.getNumero)));

              ComplEnd := Empresa.getComplto;
              if ComplEnd <> '' then
                AddPair('xCpl',   TJSONString.Create(ComplEnd));

              AddPair('xBairro',  TJSONString.Create(Empresa.getBairro));
              AddPair('cMun',     TJSONNumber.Create(Empresa.getCodcidade));
              AddPair('UF',       TJSONString.Create(Empresa.getEstado));
              AddPair('CEP',      TJSONNumber.Create(LimpaNumero(Empresa.getCep)));
              AddPair('fone',     TJSONString.Create(LimpaNumero(Empresa.getTelefone)));
              AddPair('Email',    TJSONString.Create(Empresa.getEmail));
            end;
          end;
{$ENDREGION}
{$REGION 'Tomador'}
          jbTomador := TJSONObject.Create;
          AddPair('Tomador', jbTomador);
          With jbTomador do
          begin
          {
            obCliente.setCli_codigo(obPedido.getPed_codcli);
            if not obCliente.Consultar then
              Raise Exception.Create('Cliente ' + obPedido.getPed_codcli + ' não encontrado.' + #13 + 'No Pedido ' + obPedido.getPed_nro);

            if Trim(LimpaNumero(obCliente.getCli_cep)) = '' then
              Raise Exception.Create('Cliente ' + obPedido.getPed_codcli + ' Sem CEP.' + #13 + 'No pedido ' + obPedido.getPed_nro);

            obCidade.setMun_codigo(obCliente.getCli_codcid);
            if not obCidade.Consultar then
            begin
              Raise Exception.Create('Cidade do cliente ' + obCliente.getCli_codigo + '-' + obCliente.getCli_nome + ' não encontrada.' + #13 +
                                     'Verifique o cadastro do cliente!' + #13 + 'Pedido ' + obPedido.getPed_nro);
            end;

            obPais.setPai_codigo(obCidade.getMun_codpai);
            if not obPais.Consultar then
            begin
              Raise Exception.Create('País da cidade ' + obCidade.getMun_codigo + '-' + obCidade.getMun_descri + ' não encontrado.' + #13 +
                                     'Verifique o cadastro de municípios!' + #13 + 'Pedido ' + obPedido.getPed_nro);
            end;
           }
            if obCliente.getCli_cgccpf.Length > 11 then
              AddPair('TomaCNPJ',         TJSONString.Create(obCliente.getCli_cgccpf))
            else
              AddPair('TomaCPF',          TJSONString.Create(obCliente.getCli_cgccpf));

            AddPair('TomaIM',             TJSONString.Create(LimpaNumero(obCliente.getCli_insmun)));
            AddPair('TomaIE',             TJSONString.Create(LimpaNumero(obCliente.getCli_insest)));

            if Trim(obPedido.getPed_nomcli) <> '' then
              AddPair('TomaRazaoSocial',  TJSONString.Create(obPedido.getPed_nomcli))
            else
              AddPair('TomaRazaoSocial',  TJSONString.Create(obCliente.getCli_nome));

            AddPair('TomaEndereco',       TJSONString.Create(obCliente.getCli_end));
            AddPair('TomaNumero',         TJSONString.Create(FormataNroEnd(obCliente.getCli_nroend)));

            if obCliente.getCli_endcom <> '' then
              AddPair('TomaComplemento',  TJSONString.Create(obCliente.getCli_endcom));

            AddPair('TomaBairro',         TJSONString.Create(obCliente.getCli_bairro));
            AddPair('TomacMun',           TJSONNumber.Create(obCidade.getMun_codmec));
            AddPair('TomaxMun',           TJSONString.Create(obCidade.getMun_descri));
            AddPair('TomaUF',             TJSONString.Create(obCliente.getCli_uf));
            AddPair('TomaPais',           TJSONString.Create('BR'));
            AddPair('TomaCEP',            TJSONNumber.Create(LimpaNumero(obCliente.getCli_cep)));
            AddPair('TomaTelefone',       TJSONString.Create(LimpaNumero(obCliente.getCli_dddfon) + Trim(Copy(LimpaNumero(obCliente.getCli_fone), 1, 9))));
            AddPair('TomaEmail',          TJSONString.Create(obCliente.getCli_email));
          end;
{$ENDREGION}
{$REGION 'Orgao gerador'}
          // With OrgaoGerador do
          // begin
          // CodigoMunicipio := cMun;
          // UF := xUF;
          // end;
{$ENDREGION}
{$REGION 'Dados da Obra'}
          if (Self.FCFG_SRVCIV) and (Trim(obPedido.getPed_CodObra) <> '') then
          begin
            obObra.setObr_codigo(obPedido.getPed_CodObra);
            if not obObra.Consultar then
              Raise Exception.Create('Obra ' + obPedido.getPed_CodObra + ' não encontrada.');

            obCidade.setMun_codigo(obObra.getObr_codcid);
            if not obCidade.Consultar then
              Raise Exception.Create('Cidade da obra ' + obObra.getObr_codigo + '-' + obObra.getObr_descri + ' não encontrada.' + #13 +
                                     'Verifique o cadastro da obra!' + #13 + 'Pedido ' + obPedido.getPed_nro);

            obPais.setPai_codigo(obCidade.getMun_codpai);
            if not obPais.Consultar then
              Raise Exception.Create('País da cidade ' + obCidade.getMun_codigo + '-' + obCidade.getMun_descri + ' não encontrado.' + #13 +
                                     'Verifique o cadastro de municípios!' + #13 + 'Pedido ' + obPedido.getPed_nro);

            jbConstCivil := TJSONObject.Create;
            AddPair('ConstCivil', jbConstCivil);
            With jbConstCivil do
            begin
              AddPair('CodObra',                TJSONString.Create(obObra.getObr_numcei));
              AddPair('Art',                    TJSONString.Create(obObra.getObr_numart));
              AddPair('ObraLog',                TJSONString.Create(obObra.getObr_end));
              AddPair('ObraCompl',              TJSONString.Create(obObra.getObr_comple));
              AddPair('ObraNumero',             TJSONString.Create(FormataNroEnd(obObra.getObr_endnum)));
              AddPair('ObraBairro',             TJSONString.Create(obObra.getObr_bairro));
              AddPair('ObraMun',                TJSONNumber.Create(obCidade.getMun_codmec));
              AddPair('ObraUF',                 TJSONString.Create(obObra.getObr_uf));
              AddPair('ObraPais',               TJSONString.Create('BR'));
              AddPair('ObraCEI',                TJSONString.Create(obObra.getObr_numcei));
              AddPair('ObraMatricula',          TJSONString.Create(obObra.getObr_matric));
              AddPair('ObraNumEncapsulamento',  TJSONString.Create(obObra.getObr_numpro));

              if LimpaNumero(obObra.getObr_cep) <> '' then
                AddPair('ObraCEP',              TJSONNumber.Create(LimpaNumero(obObra.getObr_cep)));

            end;
          end;
{$ENDREGION}

          // observações que devem ser impressar nos dados acicionais
          AddPair('NFSOutrasinformacoes', TJSONString.Create(Trim(FCFG_OBNFS1+' '+FCFG_OBNFS2+' '+ObsPed)));

        end;
      end;
    end;
  Finally
    obPedido.Free;
    obCliente.Free;
    obProduto.Free;
    obObra.Free;
    obCidade.Free;
    obPais.Free;
    obVenaIps.Free;
  End;
end;

procedure TOperacoesNFSeMigrate.DuplicatasPED(NumFat: String; ScraNfs: TNotasFiscaisFull);
Var
  Nr: String;
  QryDups: TSQLQuery;
  obDuplicatas: TDuplicatas;
begin
  obDuplicatas := TDuplicatas.Create;
  QryDups := TSQLQuery.Create(Nil);
  QryDups.SQLConnection := T2.WsepeDBX;

  try
    With QryDups do
    begin
      Close;
      SQL.Clear;
      SQL.Add('Select DUP_CCUSTO, DUP_CHVEXT, DUP_CLIPAG, DUP_CODCLI, DUP_CODIND, DUP_CODINS, DUP_CODLOC, DUP_CODTPG, DUP_CODVEN, DUP_CONTA, DUP_DATATU, DUP_DESC, DUP_DESDEV, DUP_DESLIM, DUP_DOBCO, DUP_DSPCOB, DUP_DSPFIN, DUP_DTACAR, DUP_DTALIM, DUP_DTCANC,');
      SQL.Add('DUP_DTCONT, DUP_DVDOBC, DUP_EMCART, DUP_EMIS,   DUP_GRUPO,  DUP_HIST,   DUP_IMPBLO, DUP_IMPR,   DUP_JURO,   DUP_LOCAL,  DUP_NROAUT, DUP_NSURED, DUP_NUM, DUP_NUMFAT, DUP_NUMLOT, DUP_NUMNF, DUP_OBS,    DUP_PAGURV, DUP_PGTO,   DUP_QTURV,');
      SQL.Add('DUP_SALDO,  DUP_SERNF,  DUP_STATUS, DUP_TBAIXA, DUP_TRNBCO, DUP_TRNCTB, DUP_USRATU, DUP_VALOR,  DUP_VARMON, DUP_VENC,   DUP_VENESP, DUP_VLREXT, DUP_VLRPAG');
      SQL.Add('FROM SCRADUP');
      SQL.Add('Where Dup_NumFat = :NumFat');
      SQL.Add('and   Dup_SerNf  = ''PD''');
      ParamByName('NumFat').AsString := NumFat;
      Open;
    end;

    if FCFG_GERDPN = 'S' then
      Nr := NumFat
    else
      Nr := ScraNfs.getNfs_num;

    QryDups.First;
    while not QryDups.Eof do
    begin
      obDuplicatas.setDup_num(Nst(QryDups['DUP_NUM']));
      if obDuplicatas.Consultar then
      begin
        obDuplicatas.setDup_SerNF(ScraNfs.getNfs_serie);
        obDuplicatas.setDup_NumFat(Nr);
        obDuplicatas.setDup_NumNF(ScraNfs.getNfs_num);
        obDuplicatas.setDup_Codcli(ScraNfs.getNfs_codcli);
        obDuplicatas.setDup_Emis(ScraNfs.getNfs_emis);
        obDuplicatas.setDup_Codven(ScraNfs.getNfs_codven);
        obDuplicatas.setDup_datatu(Date);
        obDuplicatas.setDup_usratu(Conexao.GetUsuario);
        obDuplicatas.Alterar;
      end;

      QryDups.Next;
    end;
  Finally
    QryDups.Free;
    obDuplicatas.Free;
  end;
end;

procedure TOperacoesNFSeMigrate.GravarDupsNfs(ANroPedido: String; ANota: TNotasFiscaisFull);
Var
  J: Integer;
  NrDuplicata, Numero: String;
  obTipoPgto: TTipopgto;
  obPedido: TPedidovendaFull;
//  ObEcf: TEcf;
  QryPgpd: TSQLQuery;
begin
  QryPgpd := TSQLQuery.Create(Nil);
  QryPgpd.SQLConnection := T2.WsepeDBX;

  obTipoPgto := TTipopgto.Create;
  obPedido := TPedidovendaFull.Create;
//  ObEcf := TEcf.Create;

  try
    obPedido.setPed_nro(ANroPedido);
    obPedido.Consultar;

    With QryPgpd do
    begin
      Close;
      SQL.Clear;
      SQL.Add('Select PG_NROPED, PG_VAR, PG_DATA, PG_VALOR, PG_BCO, PG_USRATU, PG_DATATU, PG_CCUSTO, PG_CONTA,');
      SQL.Add('PG_VENESP, PG_LOCAL, PG_CODTPG, PG_DOBCO, PG_DVDOBCO, PG_VENESP, PG_CODPGN, PG_PRTAXA, PG_VLTAXA, PG_DTCALC, PG_NRODEV');
      SQL.Add('From VenaPgpd');
      SQL.Add('Where PG_NROPED = :PG_NROPED');
      SQL.Add('Order By PG_NROPED,PG_VAR');
      ParamByName('PG_NROPED').AsString := ANroPedido;
      Open;
    end;

    J := 1;
    QryPgpd.First;
    While not QryPgpd.Eof do
    begin
      // Gera movimentação de resgate de pontos(negativa)
      if (FCFG_PTOFID) and (FCFG_PTOGER = 'E') then
      begin
        obTipoPgto.setTpg_codigo(QryPgpd.FieldByName('PG_CODTPG').AsString);
        if (obTipoPgto.Consultar) and (obTipoPgto.getTpg_respto = 'S') then
          SubtraiPontos('NF', ANota.getNfs_serie, ANota.getNfs_num, ANota.getNfs_codcli, ANota.getNfs_emis, QryPgpd.FieldByName('PG_VALOR').AsFloat, True, T2.qC1, T2.cdsC1);
      end;
{
      // precisei fazer isso pra função abaixo
      ObEcf.setEcf_codcli(obPedido.getPed_codcli);
      ObEcf.setEcf_codven(obPedido.getPed_vend);
      ObEcf.setEcf_nomcli(obPedido.getPed_nomcli);

      if (FCFG_NRPRAN = 'N') then
        NrDuplicata := U_SisNFECF.Gravar_Parce(ObEcf, ANota.getNfs_serie, ANota.getNfs_num + StrZero(Nst(J), 2), ANota.getNfs_num, ANota.getNfs_num + ANota.getNfs_serie, ANota.getNfs_serie, QryPgpd.FieldByName('PG_BCO').AsString, QryPgpd.FieldByName('PG_CODTPG').AsString, QryPgpd.FieldByName('PG_DOBCO').AsString, QryPgpd.FieldByName('PG_CODPGN').AsString, QryPgpd.FieldByName('PG_VALOR').AsFloat, QryPgpd.FieldByName('PG_VLTAXA').AsFloat, QryPgpd.FieldByName('PG_PRTAXA').AsFloat, QryPgpd.FieldByName('PG_DATA').AsDateTime, obPedido.getPed_data, T2.qgSepeCfg, QryPgpd.FieldByName('PG_VENESP').AsString, QryPgpd.FieldByName('PG_CONTA').AsString, QryPgpd.FieldByName('PG_CCUSTO').AsString)
      else
        NrDuplicata := U_SisNFECF.Gravar_Parce(ObEcf, ANota.getNfs_serie, ANota.getNfs_num + Letras[J],          ANota.getNfs_num, ANota.getNfs_num + ANota.getNfs_serie, ANota.getNfs_serie, QryPgpd.FieldByName('PG_BCO').AsString, QryPgpd.FieldByName('PG_CODTPG').AsString, QryPgpd.FieldByName('PG_DOBCO').AsString, QryPgpd.FieldByName('PG_CODPGN').AsString, QryPgpd.FieldByName('PG_VALOR').AsFloat, QryPgpd.FieldByName('PG_VLTAXA').AsFloat, QryPgpd.FieldByName('PG_PRTAXA').AsFloat, QryPgpd.FieldByName('PG_DATA').AsDateTime, obPedido.getPed_data, T2.qgSepeCfg, QryPgpd.FieldByName('PG_VENESP').AsString, QryPgpd.FieldByName('PG_CONTA').AsString, QryPgpd.FieldByName('PG_CCUSTO').AsString);
}

      if (FCFG_NRPRAN = 'N') then
         Numero:= ANota.getNfs_num + StrZero(Nst(J), 2)
      else
         Numero:= ANota.getNfs_num + Letras[J];

      NrDuplicata := Gravar_ScraDup(obPedido.getPed_codcli, obPedido.getPed_vend, obPedido.getPed_nomcli,
                                    ANota.getNfs_serie, Numero, ANota.getNfs_num, ANota.getNfs_num + ANota.getNfs_serie,
                                    QryPgpd.FieldByName('PG_BCO').AsString,    QryPgpd.FieldByName('PG_CODTPG').AsString,
                                    QryPgpd.FieldByName('PG_DOBCO').AsString,  QryPgpd.FieldByName('PG_CODPGN').AsString,
                                    QryPgpd.FieldByName('PG_VALOR').AsFloat,   QryPgpd.FieldByName('PG_VLTAXA').AsFloat,
                                    QryPgpd.FieldByName('PG_PRTAXA').AsFloat,  QryPgpd.FieldByName('PG_DATA').AsDateTime,
                                    obPedido.getPed_data, T2.qgSepeCfg,        QryPgpd.FieldByName('PG_VENESP').AsString,
                                    QryPgpd.FieldByName('PG_CONTA').AsString,  QryPgpd.FieldByName('PG_CCUSTO').AsString);
      Inc(J);

      QryPgpd.Next;
    end;
  finally
    obTipoPgto.Free;
//    ObEcf.Free;
    QryPgpd.Free;
  end;
end;

procedure TOperacoesNFSeMigrate.GravarPontos(ANroPedido: String; ANota: TNotasFiscaisFull);
Var
  obTipoPgto: TTipopgto;
  QryPgpd: TSQLQuery;
begin
  if (FCFG_PTOFID = False) OR (FCFG_PTOGER <> 'E') then
    Exit;

  obTipoPgto := TTipopgto.Create;
  QryPgpd := TSQLQuery.Create(Nil);
  QryPgpd.SQLConnection := T2.WsepeDBX;

  try
    With QryPgpd do
    begin
      Close;
      SQL.Clear;
      SQL.Add('Select PG_NROPED, PG_VAR, PG_DATA, PG_VALOR, PG_BCO, PG_USRATU, PG_DATATU,');
      SQL.Add('PG_VENESP, PG_LOCAL, PG_CODTPG, PG_DOBCO, PG_DVDOBCO');
      SQL.Add('From VenaPgpd');
      SQL.Add('Where PG_NROPED = :PG_NROPED');
      SQL.Add('Order By PG_NROPED,PG_VAR');
      ParamByName('PG_NROPED').AsString := ANroPedido;
      Open;
    end;

    QryPgpd.First;
    While not QryPgpd.Eof do
    begin
      // Gera movimentação de resgate de pontos(negativa)
      obTipoPgto.setTpg_codigo(QryPgpd.FieldByName('PG_CODTPG').AsString);
      if (obTipoPgto.Consultar) and (obTipoPgto.getTpg_respto = 'S') then
        SubtraiPontos('NF', ANota.getNfs_serie, ANota.getNfs_num, ANota.getNfs_codcli, ANota.getNfs_emis, QryPgpd.FieldByName('PG_VALOR').AsFloat, True, T2.qC1, T2.cdsC1);

      QryPgpd.Next;
    end;
  finally
    obTipoPgto.Free;
    QryPgpd.Free;
  end;
end;

procedure DecodeAndSave(AConteudo : AnsiString; SaveAs: String);
var
    lStreamDst: TFileStream;
    Buffer: PChar;
begin
    { Cria o novo arquivo vazio }
    lStreamDst := TFileStream.Create(SaveAs, fmCreate);

    { Decodifica o conteúdo }
    AConteudo := DecodeBase64(AConteudo);

    { Grava o conteúdo decodificado no arquivo }
    Buffer := PChar(AConteudo);
    lStreamDst.Write(Buffer^, Length(AConteudo));
    lStreamDst.Free();
end;

procedure TOperacoesNFSeMigrate.GeraNota(ANumeroLote, ANumeroRPS: String);
Var
  DupNum, DirXmlNota, ArqNfse, Retorno: String;
  NMov, Max, I, X, Z, IdServ: Integer;
  NrCorreto: Boolean;
  DataPasta: TDateTime;

  obLoteRps       : TLotenfeFull;
  obRps           : TVenarpsFull;
  obPedido        : TPedidovendaFull;
  obNota          : TNotasFiscaisFull;
  obItem          : TItensNFFull;
  obVenaIps       : TVenaIps;
  obServ          : TScranfls;
  obProduto       : TProdutos;
  obEcmamov       : TMovprodestoque;
  obImprimirNFSe  : TImprimirNFSe;
  obEnviaEmailNFSe: TEnviaEmailNFSe;
  obGeraImpBol    : TGeraImpBoleto;
  obEnviaSms      : TEnviaSMS;
begin
  Max             := 3;
  obLoteRps       := TLotenfeFull.Create;
  obRps           := TVenarpsFull.Create;
  obPedido        := TPedidovendaFull.Create;
  obNota          := TNotasFiscaisFull.Create;
  obVenaIps       := TVenaIps.Create;
  obServ          := TScranfls.Create;
  obProduto       := TProdutos.Create;
  obEcmamov       := TMovprodestoque.Create;
  obImprimirNFSe  := TImprimirNFSe.Create;
  obEnviaEmailNFSe:= TEnviaEmailNFSe.Create;
  obGeraImpBol    := TGeraImpBoleto.Create;
  obEnviaSms      := TEnviaSMS.Create;

  FListaNotas.Clear;  // no final do processamento tem uma lista com o numero das notas geradas

  try
    InicioTransacao(T2.WsepeDBX);
    try

      obLoteRps.LimpaObj;
      if ANumeroLote <> '' then  // quando não vem o numero do lote, vem um RPS específico
      begin
         obLoteRps.setLot_nrolote(ANumeroLote);
         obLoteRps.CarregaLotePorNro;
      end;

      obDocs.cdsRetornoLote.First;
      while not obDocs.cdsRetornoLote.Eof do
      begin
        // nota não autorizada
        if obDocs.cdsRetornoLote.FieldByName('DocSitCodigo').AsInteger <> 100 then
        begin
           obDocs.cdsRetornoLote.Next;
           Continue;
        end;

        if ANumeroLote <> '' then  // quando não vem o numero do lote, vem um RPS específico
        begin
          // nao achou o RPS
          if not (obRps.ConsultaRpsPorNumero(StrZero(obDocs.cdsRetornoLote.FieldByName('DocNumero').AsString, 15))) then
          begin
             obDocs.cdsRetornoLote.Next;
             Continue;
          end;
        end
        else
        begin
          if not obRps.ConsultaRpsPorNumero(ANumeroRPS) then
          begin
             obDocs.cdsRetornoLote.Next;
             Continue;
          end;
        end;

        // nao achou o pedido
        obPedido.setPed_nro(obRps.getRps_nroped);
        if not (obPedido.Consultar) then
        begin
           obDocs.cdsRetornoLote.Next;
           Continue;
        end;

        obNota.LimpaObj;
        obNota.ItensNF.Clear;
        obNota.setNfs_serie(FCFG_SERFSE);
        if obDocs.cdsRetornoLote.FieldByName('NFSeNumero').AsInteger > 0 then
           obNota.setNfs_num(StrZero(obDocs.cdsRetornoLote.FieldByName('NFSeNumero').AsString, 9))
        else
        begin
           obNota.setNfs_serie(obDocs.cdsRetornoLote.FieldByName('DocSerie').AsString);   // caso a tag NFSeNumero volte zerada, usa essa tag como numero de nota
           obNota.setNfs_num(StrZero(obDocs.cdsRetornoLote.FieldByName('DocNumero').AsString, 9));
        end;

        if (obNota.Consultar) then
           FListaNotas.Add(obNota.getNfs_serie+'/'+obNota.getNfs_num+' - Nota já existe na base de dados')
        else  // se anota não existir na base de dados grava a nota, gera o XML, e faz os demias procedimentos
        begin
          Progresso('Gravando XML, nota autorizada ' + obNota.getNfs_num, 1, Max);

          // Se retornou corretamente a data de autorização da nota, usa esta para salvar os arquivos XML e PDF,
          // senão usa a data de emissão
          DataPasta:= 0;
          if Trim(obDocs.cdsRetornoLote.FieldByName('DocDhAut').AsString) <> '' then
             DataPasta:= GetDateTime(obDocs.cdsRetornoLote.FieldByName('DocDhAut').AsString);
          if DataPasta = 0 then
             DataPasta:= GetDateTime(obDocs.cdsRetornoLote.FieldByName('NFSeDataEmissao').AsString);

          // grava XML da nota
//          DirXmlNota := FPastaNFSe.CriarDiretoriosPorData(FPastaNFSe.PastaAutorizadas, GetDateTime(obDocs.cdsRetornoLote.FieldByName('NFSeDataEmissao').AsString));
          DirXmlNota := FPastaNFSe.CriarDiretoriosPorData(FPastaNFSe.PastaAutorizadas, DataPasta);
          ArqNfse    := DirXmlNota + '\'+ obDocs.cdsRetornoLote.FieldByName('NFSeCodVerificacao').AsString + '-proNFSe.xml';
          DecodeAndSave(obDocs.cdsRetornoLote.FieldByName('DocXML').AsString, ArqNfse);

          // grava PDF da nota
          ArqNfse    := DirXmlNota + '\'+ obDocs.cdsRetornoLote.FieldByName('NFSeCodVerificacao').AsString + '-DANFSe.pdf';
          DecodeAndSave(obDocs.cdsRetornoLote.FieldByName('DocPDF').AsString, ArqNfse);

          obRps.setRps_status('E'); // Definimos que o rps ficará pendente até que consiga gerar o xml. Assim permitirá que seja possível manda-lo novamente se necessário. E - Enviado
          obRps.setRps_gerxml('S'); // S xml gerado
          obRps.Alterar;

          Progresso('Gerando nota ' + obNota.getNfs_num, 2, Max);

{$REGION 'Cabeçalho da Nota'}
          if FCFG_GERDPN = 'S' then // Gera numero da duplicata diferente do numero da nota
            DupNum := NumeroAutomatico(T2.qC3, 'Sepecfg', 'CFG_DUPNUM', 6)
          else
            DupNum := obNota.getNfs_num;

          // preenche das datas e horarios atuais, se voltoar na API as datas e horarios corretos usa eles
          obNota.setNfs_emis(Date);
          obNota.setNfs_hora(FormatDateTime('hh:nn:ss', Now));
          obNota.setNfs_horger(FormatDateTime('hh:nn:ss',  Now));
          obNota.setNfs_saida(Date);

          if obDocs.cdsRetornoLote.FieldByName('NFSeDataEmissao').AsString <> '' then
          begin
             obNota.setNfs_emis(GetDateTime(obDocs.cdsRetornoLote.FieldByName('NFSeDataEmissao').AsString));
             obNota.setNfs_hora(FormatDateTime('hh:nn:ss', GetDateTime(obDocs.cdsRetornoLote.FieldByName('NFSeDataEmissao').AsString)));
             obNota.setNfs_horger(FormatDateTime('hh:nn:ss', GetDateTime(obDocs.cdsRetornoLote.FieldByName('NFSeDataEmissao').AsString)));
             obNota.setNfs_saida(GetDateTime(obDocs.cdsRetornoLote.FieldByName('NFSeDataEmissao').AsString));
          end
          else
             if obDocs.cdsRetornoLote.FieldByName('DocDataEmissao').AsString <> '' then
             begin
                obNota.setNfs_emis(GetDateTime(obDocs.cdsRetornoLote.FieldByName('DocDataEmissao').AsString));
                obNota.setNfs_hora(FormatDateTime('hh:nn:ss', GetDateTime(obDocs.cdsRetornoLote.FieldByName('DocDataEmissao').AsString)));
                obNota.setNfs_horger(FormatDateTime('hh:nn:ss', GetDateTime(obDocs.cdsRetornoLote.FieldByName('DocDataEmissao').AsString)));
                obNota.setNfs_saida(GetDateTime(obDocs.cdsRetornoLote.FieldByName('DocDataEmissao').AsString));
             end;

          obNota.setNfs_nfeamb(FCFG_NFSAMB);

          obNota.setNfs_nfeopr('1'); // Modlo 1 Normal 2 contingência
          obNota.setNfs_finali('1'); // Finalidade 1 Normal
          obNota.setNfs_nfecha(obDocs.cdsRetornoLote.FieldByName('NFSeCodVerificacao').AsString);

          // data da autorização se não retornar um valor valido usa a data/hora atual
          if (obDocs.cdsRetornoLote.FieldByName('DocDhAut').AsString <> '')                     and
             (copy(obDocs.cdsRetornoLote.FieldByName('DocDhAut').AsString,1,8) <> '0000-00-00') then
          begin
             obNota.setNfs_dtaaut(GetDateTime(obDocs.cdsRetornoLote.FieldByName('DocDhAut').AsString));
             obNota.setNfs_horaut(FormatDateTime('hh:nn:ss', GetDateTime(obDocs.cdsRetornoLote.FieldByName('DocDhAut').AsString)));
          end
          else
          begin
             obNota.setNfs_dtaaut(Date);
             obNota.setNfs_horaut(FormatDateTime('hh:nn:ss', Now));
          end;

          // se não vem protocolo no retorno, usa o protocolo do LOTE / RPS
          if obDocs.cdsRetornoLote.FieldByName('DocProtocolo').AsString <> '' then
             obNota.setNfs_nfeprt(obDocs.cdsRetornoLote.FieldByName('DocProtocolo').AsString)
          else
             obNota.setNfs_nfeprt(obLoteRps.getLot_nrolote);

          obNota.setNfs_nfelot(ANumeroLote); // T2.ACBrNFSe1.NotasFiscais.Items[I].NFSe.NumeroLote vinha em branco
          obNota.setNfs_nfesta('5'); // Autorizada não impressa
          obNota.setNfs_codcli(obPedido.getPed_codcli);
          obNota.setNfs_nomcli(obPedido.getPed_nomcli);
          obNota.setNfs_cnpjcpf(obPedido.getPed_cnpjcpf);
          obNota.setNfs_codven(obPedido.getPed_vend);
          obNota.setNfs_uf(obPedido.obCliente.obCidadePrincipal.getMun_uf);
          obNota.setNfs_codger(obPedido.getPed_ger);
          obNota.setNfs_codpag('');
          obNota.setNfs_hist('');
          obNota.setNfs_avap(obPedido.getPed_avap);
          obNota.setNfs_fretst(obPedido.getPed_frete);
          obNota.setNfs_frete(obPedido.getPed_vlfret);
          obNota.setNfs_codtrs(obPedido.getPed_codtrs);
          obNota.setNfs_ped1(obPedido.getPed_nro);
          obNota.setNfs_numfat(DupNum);
          obNota.setNfs_desc(obPedido.getPed_desc1);
          obNota.setNfs_prdesc(obPedido.getPed_prdesc);
          obNota.setNfs_desfin(obPedido.getPed_acres1);
          obNota.setNfs_vlrsub(obPedido.getPed_vlrsub);
          obNota.setNfs_bassub(obPedido.getPed_bassub);
          obNota.setNfs_dessuf(obPedido.getPed_dessuf);
          obNota.setNfs_suficm(obPedido.getPed_suficm);
          obNota.setNfs_sufpis(obPedido.getPed_sufpis);
          obNota.setNfs_sufcof(obPedido.getPed_sufcof);
          obNota.setNfs_sufipi(obPedido.getPed_sufipi);
          obNota.setNfs_alqirf(obPedido.getPed_alqirf);
          obNota.setNfs_irf(obPedido.getPed_irf);
          obNota.setNfs_retiss(obPedido.getPed_retiss);
          obNota.setNfs_baiss(obPedido.getPed_basiss);
          obNota.setNfs_alqiss(obPedido.getPed_iss);
          obNota.setNfs_iss(obPedido.getPed_vlriss);
          obNota.setNfs_baicm(obPedido.getPed_basicm);
          obNota.setNfs_icm(obPedido.getPed_vlricm);
          obNota.setNfs_opicm2(0);
          obNota.setNfs_opicm3(0);
          obNota.setNfs_bpiscof(obPedido.getPed_bpiscof);
          obNota.setNfs_vlrpis(obPedido.getPed_vlrpis);
          obNota.setNfs_vlrcof(obPedido.getPed_vlrcof);
          obNota.setNfs_srvpis(obPedido.getPed_srvpis);
          obNota.setNfs_srvcof(obPedido.getPed_srvcof);
          obNota.setNfs_prod(obPedido.getPed_totpro);
          obNota.setNfs_total(obPedido.getPed_tot1);
          obNota.setNfs_totsrv(obPedido.getPed_totsrv);
          obNota.setNfs_prsimp(obPedido.getPed_prsimp);
          obNota.setNfs_vlsimp(obPedido.getPed_vlsimp);
          obNota.setNfs_prcom(obPedido.getPed_prcomi);
          obNota.setNfs_prtrib(obPedido.getPed_prtrib);
          obNota.setNfs_vltrib(obPedido.getPed_vltrib);
          obNota.setNfs_datatu(Date);
          obNota.setNfs_usratu(Conexao.GetUsuario);
{$ENDREGION}
{$REGION 'Itens da nota e movimentação do estoque'}
          obPedido.GetItensBD;
          for X := 0 to obPedido.Itens.Count - 1 do
          begin
            obProduto.setPro_codigo(obPedido.Itens[X].getIpd_codpro);
            obProduto.Consultar;

            IdServ := 0;
            obVenaIps.LimpaObj;
            obVenaIps.setIps_id(obPedido.Itens[X].getIpd_ids);
            if (obVenaIps.Consultar) then
            begin
              obServ.LimpaObj; // Linhas da nota dados de serviços
              obServ.setLs_id(obServ.Auto_inc_ls_id(1));
              obServ.setLs_baiss(obVenaIps.getIps_baiss);
              obServ.setLs_priss(obVenaIps.getIps_priss);
              obServ.setLs_vliss(obVenaIps.getIps_vliss);
              obServ.setLs_rdiss(obVenaIps.getIps_rdiss);
              obServ.setLs_retiss(obVenaIps.getIps_retiss);
              obServ.setLs_bainss(obVenaIps.getIps_baiss);
              obServ.setLs_prinss(obVenaIps.getIps_prinss);
              obServ.setLs_vlinss(obVenaIps.getIps_vlinss);
              obServ.setLs_rdinss(obVenaIps.getIps_rdinss);
              obServ.setLs_bairf(obVenaIps.getIps_bairf);
              obServ.setLs_prirf(obVenaIps.getIps_prirf);
              obServ.setLs_vlirf(obVenaIps.getIps_vlirf);
              obServ.setLs_retpis(obVenaIps.getIps_retpis);
              obServ.setLs_usratu(Conexao.GetUsuario);
              obServ.setLs_datatu(Date);
              obServ.Incluir;
              IdServ := obServ.getLs_id;
            end;

            obItem := TItensNFFull.Create;
            obItem.LimpaObj;
            obItem.setLn_numnf(obNota.getNfs_num);
            obItem.setLn_serie(obNota.getNfs_serie);
            obItem.setLn_nro(Ivl(obPedido.Itens[X].getIpd_item));
            obItem.setLn_codproa(obPedido.Itens[X].getIpd_codpro);
            obItem.setLn_descri(obPedido.Itens[X].getIpd_descri);
            obItem.setLn_und(obProduto.getPro_und);
            obItem.setLn_qtde(obPedido.Itens[X].getIpd_qtde);
            obItem.setLn_vlrorg(obPedido.Itens[X].getIpd_vlrorg);
            obItem.setLn_vlorg2(obPedido.Itens[X].getIpd_vlorg2);
            obItem.setLn_vlorg3(obPedido.Itens[X].getIpd_vlorg3);
            obItem.setLn_vlorg4(obPedido.Itens[X].getIpd_vlorg4);
            obItem.setLn_vlrunit(obPedido.Itens[X].getIpd_vlrunt);
            obItem.setLn_codax(obPedido.Itens[X].getIpd_alx);
            obItem.setLn_codclf(obProduto.getPro_clasfi);
            obItem.setLn_tab(obPedido.Itens[X].getIpd_tab);
            obItem.setLn_vlrdesc(obPedido.Itens[X].getIpd_desc);
            obItem.setLn_vlracre(obPedido.Itens[X].getIpd_acres);
            obItem.setLn_natopr(obPedido.Itens[X].getIpd_natopr);
            obItem.setLn_codopr(obPedido.Itens[X].getIpd_codopr);
            obItem.setLn_codtna(obPedido.Itens[X].getIpd_codtna);
            obItem.setLn_vlrlin(obPedido.Itens[X].getIpd_vlrlin);
            obItem.setLn_ratfrt(obPedido.Itens[X].getIpd_ratfrt);
            obItem.setLn_ratacr(obPedido.Itens[X].getIpd_ratacr);
            obItem.setLn_dessuf(obPedido.Itens[X].getIpd_dessuf);
            obItem.setLn_ratdes(obPedido.Itens[X].getIpd_ratdes);
            obItem.setLn_piscst(obPedido.Itens[X].getIpd_piscst);
            obItem.setLn_cofcst(obPedido.Itens[X].getIpd_cofcst);
            obItem.setLn_ipicst(obPedido.Itens[X].getIpd_ipicst);
            obItem.setLn_csosn(obPedido.Itens[X].getIpd_csosn);
            obItem.setLn_bpiscof(obPedido.Itens[X].getIpd_bpiscof);
            obItem.setLn_vlripi(obPedido.Itens[X].getIpd_vlripi);
            obItem.setLn_pisvlr(obPedido.Itens[X].getIpd_pisvlr);
            obItem.setLn_cofvlr(obPedido.Itens[X].getIpd_cofvlr);
            obItem.setLn_vlricm(obPedido.Itens[X].getIpd_vlricm);
            obItem.setLn_alqpis(obPedido.Itens[X].getIpd_alqpis);
            obItem.setLn_alqcof(obPedido.Itens[X].getIpd_alqcof);
            obItem.setLn_prsub(obPedido.Itens[X].getIpd_prsub);
            obItem.setLn_conta(obPedido.Itens[X].getIpd_conta);
            obItem.setLn_ccusto(obPedido.Itens[X].getIpd_ccusto);
            obItem.setLn_alqipi(obPedido.Itens[X].getIpd_ipi);
            obItem.setLn_sitipi(obPedido.Itens[X].getIpd_sitipi);
            obItem.setLn_trnctb('');
            obItem.setLn_cf(obPedido.Itens[X].getIpd_cf);
            obItem.setLn_ipired(0);
            obItem.setLn_pricm(obPedido.Itens[X].getIpd_icm);
            obItem.setLn_prbase(0);
            obItem.setLn_icmred(obPedido.Itens[X].getIpd_icmred);
            obItem.setLn_siticm(obPedido.Itens[X].getIpd_siticm);
            obItem.setLn_opicm1(0);
            obItem.setLn_opicm2(0);
            obItem.setLn_opicm3(0);
            obItem.setLn_opipi1(0);
            obItem.setLn_opipi2(0);
            obItem.setLn_opipi3(0);
            obItem.setLn_movnro(obPedido.Itens[X].getIpd_movnro);
            obItem.setLn_bassub(obPedido.Itens[X].getIpd_bassub);
            obItem.setLn_vlrsub(obPedido.Itens[X].getIpd_vlrsub);
            obItem.setLn_prcomi(0);
            obItem.setLn_movax3(obPedido.Itens[X].getIpd_movax3);
            obItem.setLn_raticm(obPedido.Itens[X].getIpd_raticm);
            obItem.setLn_ratipi(obPedido.Itens[X].getIpd_ratipi);
            obItem.setLn_tab2(obPedido.Itens[X].getIpd_tab2);
            obItem.setLn_devfor(obPedido.Itens[X].getIpd_devfor);
            obItem.setLn_devser(obPedido.Itens[X].getIpd_devser);
            obItem.setLn_devnf(obPedido.Itens[X].getIpd_devnf);
            obItem.setLn_qtddev(obPedido.Itens[X].getIpd_qtddev);
            obItem.setLn_issvlr(obPedido.Itens[X].getIpd_issvlr);
            obItem.setLn_suficm(obPedido.Itens[X].getIpd_suficm);
            obItem.setLn_sufpis(obPedido.Itens[X].getIpd_sufpis);
            obItem.setLn_sufcof(obPedido.Itens[X].getIpd_sufcof);
            obItem.setLn_pradst(obPedido.Itens[X].getIpd_pradst);
            obItem.setLn_dsp01(obPedido.Itens[X].getIpd_dsp01);
            obItem.setLn_dsp02(obPedido.Itens[X].getIpd_dsp02);
            obItem.setLn_dsp03(obPedido.Itens[X].getIpd_dsp03);
            obItem.setLn_dsp04(obPedido.Itens[X].getIpd_dsp04);
            obItem.setLn_ids(IdServ);
            obItem.setLn_devite(obPedido.Itens[X].getIpd_devite);
            obItem.setLn_ratseg(obPedido.Itens[X].getIpd_ratseg);
            obItem.setLn_ratout(obPedido.Itens[X].getIpd_ratout);
            obItem.setLn_sufipi(obPedido.Itens[X].getIpd_sufipi);
            obItem.setLn_retpis(obPedido.Itens[X].getIpd_retpis);
            obItem.setLn_vretpis(obPedido.Itens[X].getIpd_vretpis);
            obItem.setLn_vretcof(obPedido.Itens[X].getIpd_vretcof);
            obItem.setLn_vretcsl(obPedido.Itens[X].getIpd_vretcsl);
            obItem.setLn_vlrirf(obPedido.Itens[X].getIpd_vlrirf);
            obItem.setLn_prtrib(obPedido.Itens[X].getIpd_prtrib);
            obItem.setLn_vltrib(obPedido.Itens[X].getIpd_vltrib);
            obItem.setLn_pedorc(obPedido.Itens[X].getIpd_pedorc);
            obItem.setLn_pedori(obPedido.Itens[X].getIpd_pedori);
            obItem.setLn_tabpta(obPedido.Itens[X].getIpd_tabpta);
            obItem.setLn_pipidev(0);
            obItem.setLn_vipidev(0);
            obItem.setLn_cenq(obPedido.Itens[X].getIpd_cenq);
            obItem.setLn_idicmufn(obPedido.Itens[X].getIpd_idicmufp);
            obItem.setLn_vlrcst(obPedido.Itens[X].getIpd_vlrcst);
            obItem.setLn_devcha(obPedido.Itens[X].getIpd_devcha);
            obItem.setLn_icmstred(obPedido.Itens[X].getIpd_icmstred);
            obItem.setLn_usratu(Conexao.GetUsuario);
            obItem.setLn_datatu(Date);

            obNota.ItensNF.Add(obItem);

            // Movimentação de estoque
            if (Pos(FCFG_ESTPED, 'N') > 0) then
            begin
              if (UpperCase(obProduto.getPro_comest) = 'S') and (FCFG_ATUEST) then
              begin
                NMov := 0;
                NrCorreto := False;
                Z := 0;
                While not NrCorreto and (Z < 99) do
                begin
                  Inc(Z);
                  try
                    NMov := NumeroMovEstoque(obEcmamov);
                    NrCorreto := True;
                  except
                  end;
                end;

                if NMov = 0 then
                  raise Exception.Create('O sistema não conseguiu obter o número do movimento de estoque. Operação cancelada.');

                if not Composicao(obProduto.getPro_codigo) then
                begin
                  obEcmamov.LimpaObj;
                  obEcmamov.setMov_numero(NMov);
                  obEcmamov.setMov_sernf(obItem.getLn_serie);
                  obEcmamov.setMov_numnf(obItem.getLn_numnf);

                  if (Trim(obNota.getNfs_codcli) = '') then
                    obEcmamov.setMov_clifor('C' + '000000') // Cliente consumidor
                  else
                    obEcmamov.setMov_clifor('C' + obNota.getNfs_codcli);

                  obEcmamov.setMov_codpro(obItem.getLn_codproa);
                  obEcmamov.setMov_data(Date);
                  obEcmamov.setMov_qtde(obItem.getLn_qtde);
                  obEcmamov.setMov_tipo('S');
                  obEcmamov.setMov_codalx(obItem.getLn_codax);
                  obEcmamov.setMov_natopr(obItem.getLn_natopr);
                  obEcmamov.setMov_codopr(obItem.getLn_codopr);
                  obEcmamov.setMov_datatu(Date);
                  obEcmamov.setMov_usratu(GetUsuario);
                  obEcmamov.Salvar;

                  if (obProduto.getPro_serial = 'S') and (Copy(FCFG_CONSER, 1, 1) = 'S') then
                  begin
                    With T2.qC1 do
                    begin
                      Close;
                      SQL.Clear;
                      SQL.Add('Update SeraMov Set MOV_SERIE = :MOV_SERIE,MOV_NRODOC = :MOV_NRODOC,MOV_MOVEST = :MOV_MOVEST, MOV_TPODOC = ''NC''');
                      SQL.Add('Where MOV_NROPED = :NroPed');
                      SQL.Add('and   MOV_CODPRO = :CodPro');
                      SQL.Add('and   MOV_CODALX = :CodAlx');
                      ParamByName('MOV_SERIE').AsString := obItem.getLn_serie;
                      ParamByName('MOV_NRODOC').AsString := obItem.getLn_numnf;
                      ParamByName('MOV_MOVEST').AsFloat := NMov;
                      ParamByName('NroPed').AsString := obPedido.getPed_nro;
                      ParamByName('CodPro').AsString := obItem.getLn_codproa;
                      ParamByName('CodAlx').AsString := obItem.getLn_codax;
                      ExecSQL;
                    end;
                  end;

                  // grava o numero do cupom nos serviços
                  if (obProduto.getPro_consrv = 'S') then
                  begin
                    With T2.qC1 do
                    begin
                      Close;
                      SQL.Clear;
                      SQL.Add('Update SrvaMov Set SRV_SERDOC = :SRV_SERDOC,SRV_NRODOC = :SRV_NRODOC,SRV_TEMDOC = ''S''');
                      SQL.Add('Where SRV_NROPED = :NroPed');
                      SQL.Add('and SRV_CODPRO = :CodPro');
                      ParamByName('SRV_SERDOC').AsString := obItem.getLn_serie;
                      ParamByName('SRV_NRODOC').AsString := obItem.getLn_numnf;
                      ParamByName('CodPro').AsString := obItem.getLn_codproa;
                      ParamByName('NroPed').AsString := obPedido.getPed_nro;
                      ExecSQL;
                    end;
                  end;

                  obItem.setLn_movnro(NMov); // atualiza item ,que ainda esta carredado, com o nro do movimento de estoque
                end
                else
                begin
                  BaixaEstoqueComposicao(obProduto.getPro_comest, obProduto.getPro_codigo, obItem.getLn_codax, 'NF', obItem.getLn_natopr,
                    obItem.getLn_codopr, DateToStr(Date), FloatToStr(NMov), obItem.getLn_serie, obItem.getLn_numnf,
                    obNota.getNfs_codcli, obItem.getLn_qtde);
                  obItem.setLn_movnro(NMov); // atualiza item ,que ainda esta carredado, com o nro do movimento de estoque
                end;
              end;
            end;
          end;
{$ENDREGION}
{$REGION 'Inclui Observações'}
          if Length(Trim(Nst(obPedido.getPed_obs1))) > 0 then
          begin
            obItem := TItensNFFull.Create;
            obItem.LimpaObj;
            obItem.setLn_numnf(obNota.getNfs_num);
            obItem.setLn_serie(obNota.getNfs_serie);
            obItem.setLn_nro(997);
            obItem.setLn_descri(Nst(obPedido.getPed_obs1));
            obItem.setLn_datatu(Date);
            obItem.setLn_usratu(Conexao.GetUsuario);
            obNota.ItensNF.Add(obItem);
          end;

          if Length(Trim(Nst(obPedido.getPed_obs3))) > 0 then
          begin
            obItem := TItensNFFull.Create;
            obItem.LimpaObj;
            obItem.setLn_numnf(obNota.getNfs_num);
            obItem.setLn_serie(obNota.getNfs_serie);
            obItem.setLn_nro(998);
            obItem.setLn_descri(Trim(Nst(obPedido.getPed_obs3)));
            obItem.setLn_datatu(Date);
            obItem.setLn_usratu(Conexao.GetUsuario);
            obNota.ItensNF.Add(obItem);
          end;

          if Length(Trim(Nst(obPedido.getPed_obs4))) > 0 then
          begin
            obItem := TItensNFFull.Create;
            obItem.LimpaObj;
            obItem.setLn_numnf(obNota.getNfs_num);
            obItem.setLn_serie(obNota.getNfs_serie);
            obItem.setLn_nro(999);
            obItem.setLn_descri(Trim(Nst(obPedido.getPed_obs4)));
            obItem.setLn_datatu(Date);
            obItem.setLn_usratu(Conexao.GetUsuario);
            obNota.ItensNF.Add(obItem);
          end;
{$ENDREGION}
          obNota.Incluir;
          for Z := 0 to obNota.ItensNF.Count - 1 do
            obNota.ItensNF[Z].Incluir;

{$REGION 'Duplicatas da nota'}
          if not(Pos(FCFG_FINPED, 'VPF') > 0) then // se atualiza financeiro na geração N-nota
            Self.GravarDupsNfs(obPedido.getPed_nro, obNota) // Grava as duplicatas
          else
            Self.GravarPontos(obPedido.getPed_nro, obNota);
{$ENDREGION}
{$REGION 'Atualiza data e valor da ultima venda do cliente'}
          if (Trim(obNota.getNfs_codcli) <> '000000') then
          begin
            With T2.qC4 do // feito assim para ficar mais rápido pois, reclamaram na commcenter
            begin
              Close;
              SQL.Clear;
              SQL.Add('UPDATE SCRACLI SET ');
              SQL.Add('Cli_ultdta = :Cli_ultdta,');
              SQL.Add('Cli_ultvlr = :Cli_ultvlr');
              SQL.Add('Where CLI_CODIGO = :CLI_CODIGO');
              ParamByName('CLI_CODIGO').AsString := obNota.getNfs_codcli;
              ParamByName('Cli_ultdta').AsDate := Date;
              ParamByName('Cli_ultvlr').AsFloat := obNota.getNfs_total;
              ExecSQL;
            end;
          end;
{$ENDREGION}
{$REGION 'Atualiza número e série da nota no pedido e duplicatas'}
          With T2.qC4 do // feito assim para ficar mais rápido pois, reclamaram na commcenter
          begin
            Close;
            SQL.Clear;
            SQL.Add('UPDATE VENAPED SET ');
            SQL.Add('Ped_nfs = :Ped_nfs,');
            SQL.Add('Ped_sernfs = :Ped_sernfs,');
            SQL.Add('Ped_dtanfs = :Ped_dtanfs,');
            SQL.Add('Ped_nfsant = :Ped_nfsant,');
            SQL.Add('Ped_serant = :Ped_serant,');
            SQL.Add('Ped_datatu = :Ped_datatu,');
            SQL.Add('Ped_usratu = :Ped_usratu');
            SQL.Add('Where Ped_nro = :Ped_nro');
            ParamByName('Ped_nro').AsString := obPedido.getPed_nro;
            ParamByName('Ped_nfs').AsString := obNota.getNfs_num;
            ParamByName('Ped_sernfs').AsString := obNota.getNfs_serie;
            ParamByName('Ped_dtanfs').AsDate := obNota.getNfs_saida;
            ParamByName('Ped_nfsant').AsString := obNota.getNfs_num;
            ParamByName('Ped_serant').AsString := obNota.getNfs_serie;
            ParamByName('Ped_datatu').AsDate := Date;
            ParamByName('Ped_usratu').AsString := Conexao.GetUsuario;
            ExecSQL;
          end;

          if (Pos(FCFG_FINPED, 'VPF') > 0) then // Se a geração do financeiro não foi por nota(N) deve atualizar as duplicatas
            DuplicatasPED(obPedido.getPed_numfat, obNota);
{$ENDREGION}

           FListaNotas.Add(obNota.getNfs_serie+'/'+obNota.getNfs_num+' - Gerada com sucesso.');

         // Imprimir notas
          if FCFG_IMPNFS then
             obImprimirNFSe.AddNota(obNota.getNfs_serie, obNota.getNfs_num);

          // Imprimir Boletos
          if FCFG_BOLNFS then
             obGeraImpBol.AddNota(obNota.getNfs_serie, obNota.getNfs_num);

          // Enviar E-mail
          if FCFG_ENVNFS then
             obEnviaEmailNFSe.AddNota(obNota.getNfs_serie, obNota.getNfs_num);

          // Enviar SMS
          if FCFG_SMSSRV then
             obEnviaSms.AddNota(obNota.getNfs_serie, obNota.getNfs_num);
        end;
        Progresso('Finalizando item', 3, Max);

        obDocs.cdsRetornoLote.Next;
        Application.ProcessMessages;
      end;

      FimTransacao(T2.WsepeDBX, True);

      // Imprimir notas
      if FCFG_IMPNFS then
        if (obImprimirNFSe.Notas.Count > 0) then
        begin
          Progresso('Imprimindo notas . . .', 1, 1);
          obImprimirNFSe.Imprimir(tpImprimirPDF, Retorno);
        end;

      // Imprimir Boletos
      if FCFG_BOLNFS then
        if (obGeraImpBol.Notas.Count > 0) then
        begin
          Progresso('Imprimindo boletos . . .', 1, 1);
          obGeraImpBol.ImprimirBoleto;
        end;

      // Enviar E-mail
      if FCFG_ENVNFS then
        if (obEnviaEmailNFSe.Notas.Count > 0) then
        begin
          Max := obEnviaEmailNFSe.Notas.Count;
          for I := 0 to obEnviaEmailNFSe.Notas.Count - 1 do
          begin
            Progresso('Enviando e-mail ' + Nst(I + 1) + ' de ' + Nst(Max), I, Max);
            obEnviaEmailNFSe.EnviaEmailIndividual(obEnviaEmailNFSe.Notas.Items[I], '', Retorno);
            if not Retorno.IsEmpty then
                FListaNotas.Add(Retorno);

          end;
        end;

      // Enviar SMS
      if FCFG_SMSSRV then
        if obEnviaSms.Notas.Count > 0 then
        begin
          Progresso('Enviando SMS . . .', 1, 1);
          obEnviaSms.EnviarSMS(Retorno);
          if (Trim(Retorno) <> '') then
            DL_Msg(Retorno, Application.Title, 'Aviso');
        end;
    Except
      on E: Exception do
      begin
        FimTransacao(T2.WsepeDBX, False);
        DL_Msg('Erro:' + E.Message, Application.Title, 'ERRO');
      end
      else
      begin
        FimTransacao(T2.WsepeDBX, False);
        DL_Msg('Ocorreu erro desconhecido ao incluir nota.', Application.Title, 'ERRO');
      end;
    end;
  finally
    obLoteRps.Free;
    obRps.Free;
    obPedido.Free;
    obNota.Free;
    obProduto.Free;
    obVenaIps.Free;
    obServ.Free;
    obEcmamov.Free;
    obImprimirNFSe.Free;
    obEnviaEmailNFSe.Free;
    obGeraImpBol.Free;
    obEnviaSms.Free;
  end;
end;

procedure TOperacoesNFSeMigrate.Limpar;
begin
  FListaRps.Clear;
  obDocs.Clear;
end;

function TOperacoesNFSeMigrate.EnviaLote: Boolean;
Var
  obLoteRps: TLotenfeFull;
  obRps    : TVenarpsFull;
  I, Max, CtRpsOk   : Integer;
  Alertas, HoraEnv, Status, DirXmlLote: String;
begin
  Max := 5;
  Result := False;

  if (FListaRps.Count = 0) then
    raise Exception.Create('Nenhum RPS para enviar.');

  obLoteRps := TLotenfeFull.Create;
  obRps     := TVenarpsFull.Create;

  try
    try
      Progresso('Aguarde...', 1, Max);
      obLoteRps.LimpaObj;
      obLoteRps.setLot_numero(obLoteRps.Auto_inc_lot_numero(1));
      obLoteRps.setLot_nrolote(StrZero(Nst(obLoteRps.getMaxNroLote + 1), 15));
      obLoteRps.setLot_envdta(Date);
      obLoteRps.setLot_status('1'); // 1 – Não Recebido 2 – Não Processado 3 – Processado com Erro 4 – Processado com Sucesso
      obLoteRps.setLot_data(Date);

      obLoteRps.setLot_nfmode(modelo);
      obLoteRps.setLot_usratu(Conexao.GetUsuario);
      obLoteRps.setLot_datatu(Date);
      obLoteRps.setLot_qtde(FListaRps.Count);
      obLoteRps.Incluir;

      Progresso('Montado lote . . .', 2, Max);
      GeraLoteRps(obLoteRps.getLot_nrolote);

      Progresso('Enviando lote . . .', 3, Max);
      HoraEnv := FormatDateTime('hh:mm:ss', Now);
      obDocs.EnviarDocumentos('EnvioRPS');

      // --- Atualiza Lote ----
      Progresso('Atualizando registro de lote . . .', 4, Max);
      obLoteRps.setLot_envrec(Trim(obDocs.cdsRetornoLote.FieldByName('DocProtocolo').AsString));
      obLoteRps.setLot_envhor(HoraEnv);
      obLoteRps.setLot_retdat(Date);
      obLoteRps.setLot_rethor(FormatDateTime('hh:nn:ss', Now));
      obLoteRps.setLot_status('4');
      obLoteRps.Alterar;

      // ---- processa o retorno do lote ----------
      Alertas := '';
      CtRpsOk := 0;
      obDocs.cdsRetorno.First;
      while not obDocs.cdsRetorno.Eof do
      begin
        if (obDocs.cdsRetorno.FieldByName('CodMsg').AsInteger > 0) then
          Alertas := Alertas + LineBreak + 'RPS ' + obDocs.cdsRetorno.FieldByName('DocNumero').AsString + ' ' + obDocs.cdsRetorno.FieldByName('DscMsg').AsString;

        // 104: Em processamento na prefeitura
        if (obDocs.cdsRetorno.FieldByName('SitCodigo').AsInteger > 0) and (obDocs.cdsRetorno.FieldByName('SitCodigo').AsInteger <> 104) then
          Alertas := Alertas + LineBreak + 'RPS ' + obDocs.cdsRetorno.FieldByName('DocNumero').AsString + ' ' + obDocs.cdsRetorno.FieldByName('SitDescricao').AsString;

        if ((obDocs.cdsRetorno.FieldByName('Codigo').AsString) <> '100') and   // codigo 100, RSP Processada OK
           ((obDocs.cdsRetorno.FieldByName('Codigo').AsString) <> '')    then
          Alertas := Alertas + LineBreak + obDocs.cdsRetorno.FieldByName('Codigo').AsString + ' ' + obDocs.cdsRetorno.FieldByName('Descricao').AsString;

        if (obRps.ConsultaRpsPorNumero(StrZero(obDocs.cdsRetorno.FieldByName('DocNumero').AsString, 15))) then
        begin
          obRps.setRps_nrolote(obLoteRps.getLot_nrolote);

          // N- Não enviado E- Enviado C- Cancelado P - Pendente (enviado mas nota ainda não gerada)
        //  obRps.setRps_status('E');
          if (obDocs.cdsRetornoLote.FieldByName('Codigo').AsString) = '100' then  // codigo 100, RSP Processada OK
          begin
            obRps.setRps_status('P');
            obRps.setRps_nroPro(obDocs.cdsRetornoLote.FieldByName('DocProtocolo').AsString);
            inc(CtRpsOk);
          end
          else
          begin
            // se está 100 - Procesado ou 104 - em processamento,  conta como OK
            if (obDocs.cdsRetorno.FieldByName('SitCodigo').AsInteger = 100) or
               (obDocs.cdsRetorno.FieldByName('SitCodigo').AsInteger = 104) then
              inc(CtRpsOk);
          end;

          obRps.Alterar;
        end;

        Application.ProcessMessages;
        obDocs.cdsRetorno.Next;
      end;

      if CtRpsOk = 0 then
      begin
        DL_Msg('Todos os RPSs do lote com erro:'+sLineBreak+FormatarMsgErro(Alertas),'Lote','Erro');
        exit;
      end;

      Progresso('Consultando lote (5s) . . .', 5, Max);
      // Self.FSilencio := True;  Ademar - tirei pois não estava mostando as mensagens de erro

      Sleep(5000); // aguarda por 5 segundos para fazer a consulta assim, tenta evitar que usuário tenha de executar o processo de consulta
      ConsultaLote(obLoteRps.getLot_nrolote);

      for I:=0 to FListaNotas.Count-1 do
          if not FListaNotas.Strings[I].IsEmpty then
               Alertas:= Alertas + sLineBreak + FListaNotas.Strings[I];

      if not Alertas.IsEmpty then
          DL_Msg('Resumo do envio:' + sLineBreak + FormatarMsgErro(Alertas), Application.Title, 'AVISO');

      Result := True;
    Except
      on E: Exception do
        DL_Msg(E.Message, Application.Title, 'ERRO')
      else
        DL_Msg('Erro desconhecido ao enviar lote.', Application.Title, 'ERRO');
    end;
  finally
    obLoteRps.Free;
    obRps.Free;

    ProgressoClose;
    Self.FSilencio := False;
  end;
end;

function TOperacoesNFSeMigrate.ConsultaLote(ANumeroLote: String): Boolean;
Var
  obLoteRps: TLotenfeFull;
  I, Max: Integer;
  Aux: String;
  Alertas: string;
begin
  Max := 2;
  Result := False;

  obLoteRps := TLotenfeFull.Create;
  try
    obLoteRps.setLot_nrolote(ANumeroLote);
    if (obLoteRps.CarregaLotePorNro) then
    begin
      try
        // Progresso('Consultando situação do lote', 1, Max);
        // if (T2.ACBrNFSe1.WebServices.ConsultaSituacao(obLoteRps.getLot_envrec, ANumeroLote)) then
        // begin
        // obLoteRps.setLot_status(T2.ACBrNFSe1.WebServices.ConsSitLoteRPS.Situacao);
        // obLoteRps.Alterar;
        // end;

        Progresso('Consultando Lote . . .', 2, Max);
        obDocs.ConsultarDocumentos;

        Alertas := '';
        obDocs.cdsRetornoLote.First;
        while not obDocs.cdsRetornoLote.Eof do
        begin
          if (obDocs.cdsRetornoLote.FieldByName('CodMsg').AsInteger > 0) then
            Alertas := Alertas + obDocs.cdsRetornoLote.FieldByName('DscMsg').AsString + LineBreak;

          // 104: Em processamento na prefeitura
          if (obDocs.cdsRetornoLote.FieldByName('SitCodigo').AsInteger > 0) and (obDocs.cdsRetornoLote.FieldByName('SitCodigo').AsInteger <> 104) then
            Alertas := Alertas + obDocs.cdsRetornoLote.FieldByName('SitDescricao').AsString + LineBreak;

          Application.ProcessMessages;
          obDocs.cdsRetornoLote.Next;
        end;

        if obDocs.cdsRetornoLote.FieldByName('DocSitCodigo').AsInteger <> 100 then
          Alertas := Alertas + obDocs.cdsRetornoLote.FieldByName('DocSitDescricao').AsString + LineBreak;

// mostra os alertas depois de tentar processar as notas, pois alguma notas podem ter retornado com erro e outras corretas
//        if Alertas.Trim.IsEmpty then
//        begin
//          //Se não de erro mas também não gerou nota fiscal, então solicita ao usuário o contato com o suporte, pois pode ser uma situação não prevista
//          if obDocs.cdsRetornoLote.FieldByName('NFSeNumero').AsInteger <= 0 then
//          begin
//            Alertas := Alertas + 'Erro desconhecido ao gerar NFS-e. Entre em contato com o suporte do sistema!' + LineBreak;
//          end;
//        end;

//        if (Alertas <> EmptyStr) then
//        begin
//          DL_Msg('Envio contém erros: ' + FormatarMsgErro(Alertas), Application.Title, 'ERRO');
//        end
//        else


        // mesmo que alguma das notas tenha retornado com erro, tenta processar o lote, muitas vezes algumas notas ficam com erro e outras são processados corretamente
        if obDocs.cdsRetornoLote.RecordCount > 0 then
        begin
          GeraNota(ANumeroLote, '');

          Result := True;
          if (not Self.FSilencio) then
          begin
            if not Alertas.IsEmpty then
            begin
              DL_Msg('Lote Situação: 3 - Processado com Erro: ' + sLineBreak + FormatarMsgErro(Alertas), Application.Title, 'AVISO');
              obLoteRps.setLot_status('3');
              Result := False;
            end
            else
            begin
            // se deu certo não precisa mostrar nada
           //   DL_Msg('Lote Situação: 4 - Processado com Sucesso.', Application.Title, 'INFORMACAO');
              obLoteRps.setLot_status('4');
            end;

            obLoteRps.Alterar;
          end;
        end;
      except
        on E: Exception do
        begin
          DL_Msg(E.Message, Application.Title, 'ERRO');
          Result := False;
        end
        else
        begin
          DL_Msg('Erro desconhecido ao consultar lote.', Application.Title, 'ERRO');
          Result := False;
        end;
      end;
    end
    else
      DL_Msg('Lote não encontrado.', Application.Title, 'ERRO');
  finally
    obLoteRps.Free;
    ProgressoClose;
  end;
end;

function TOperacoesNFSeMigrate.MontaConsultaRps(ANumeroRps: String): Boolean;
Var
  obVenaRpsFull: TVenarpsFull;

begin
  obVenaRpsFull:= TVenarpsFull.Create;
  try
      if not obVenaRpsFull.ConsultaRpsPorNumero(ANumeroRps) then
         raise Exception.Create('Não foi encontrado o RSP Nº '+ANumeroRps);

      obDocs.cdsRetorno.EmptyDataSet;
      obDocs.cdsRetorno.Append;
      obDocs.cdsRetorno['DocNumero']:=  obVenaRpsFull.getRps_nrorps;
      obDocs.cdsRetorno['DocSerie'] :=  obVenaRpsFull.getRps_serie;
      obDocs.cdsRetorno.Post;
  finally
    obVenaRpsFull.Free;
  end;
end;

function TOperacoesNFSeMigrate.ConsultaRPS(ARPS, ANumeroLote: String): Boolean;
Var
  I, Max: Integer;
  Alertas: string;

begin
  Max          := 3;
  Result       := False;

  Progresso('Consultando RPS . . .', 1, Max);
  MontaConsultaRps(ARPS);

  try
      obDocs.ConsultarDocumentos;

      //  obDocs.ConsultarDocumentos, retorna o cdsRetornoLote alimentado com os valores que a API retornou
      if obDocs.cdsRetornoLote.RecordCount <= 0 then
      begin
        DL_Msg('Não retornou nenhuma informação', Application.Title, 'ERRO');
        Result := False;
        exit;
      end;

      Alertas := '';
      obDocs.cdsRetornoLote.First;

      if (obDocs.cdsRetornoLote.FieldByName('CodMsg').AsInteger > 0) then
          Alertas := Alertas + obDocs.cdsRetornoLote.FieldByName('DscMsg').AsString + LineBreak;

      // 104: Em processamento na prefeitura
      if (obDocs.cdsRetornoLote.FieldByName('SitCodigo').AsInteger > 0) and (obDocs.cdsRetornoLote.FieldByName('SitCodigo').AsInteger <> 104) then
          Alertas := Alertas + obDocs.cdsRetornoLote.FieldByName('SitDescricao').AsString + LineBreak;

      if obDocs.cdsRetornoLote.FieldByName('DocSitCodigo').AsInteger <> 100 then
        Alertas := Alertas + obDocs.cdsRetornoLote.FieldByName('DocSitDescricao').AsString + LineBreak;

      if not Alertas.IsEmpty then
      begin
        DL_Msg('Erro ao consultar RSP Nº '+ARPS+sLineBreak+FormatarMsgErro(Alertas) , Application.Title, 'ERRO');
        Result := False;
        exit;
      end;

      GeraNota('',ARPS);

      if FListaNotas.Count <= 0 then
         DL_Msg('A consulta não retornou nada.','Pesquisa por RSP','Erro')
      else
      begin
        Alertas := '';
        for i:=0 to FListaNotas.Count-1 do
            Alertas:= Alertas + sLineBreak + FListaNotas.Strings[I];

        DL_Msg('Resultado da pesquisa'+Alertas,'Pesquisa por RPS','Informacao');
      end;

  finally
    ProgressoClose;
  end;
end;

function TOperacoesNFSeMigrate.ProcessarRetornoCancelamento(out AProtocolo, AHora:String; out AData: TdateTime): Boolean;
var
  Alertas, DirXml, Arquivo, Serie, Numero: String;

begin
{$REGION 'modelo JSON Retorno do Cancelamento'}
//
//  {
//    "Codigo": 100,
//    "Descricao": "Documentos processados",
//    "Documentos": [
//      {
//        "DocModelo": "NFSe",
//        "DocNumero": 1851,
//        "DocSerie": "S",
//        "DocChaAcesso": "",
//        "DocProtocolo": "118461",
//        "DocEvenSeq": 0,
//        "DocEveTp": 0,
//       "DocEveId": "",
//        "DocPDFBase64": ""
//        "DocPDFDownload": "https://app.invoicy.com.br/DownloadPDF.aspx?lI1oIMz9Qhs2xRiAMjkH8glBtcOtDfC9KZ3CkrTw2sc=",
//        "DocDhAut": "",
//        "DocDigestValue": "",
//        "DocXMLBase64": ""
//        "DocXMLDownload": "https://app.invoicy.com.br/HNUC002.aspx?lI1oIMz9Qhs2xRiAMjkH8glBtcOtDfC9KZ3CkrTw2sc=,0,0,0",
//        "DocImpressora": "",
//        "Situacao": {
//          "SitCodigo": 101,
//          "SitDescricao": "Cancelado"
//        },
//        "MensagemSefaz": {
//         "CodMsg": 0,
//          "DscMsg": ""
//        },
//        "NFSe": {
//          "NFSeNumero": 1851,
//          "NFSeCodVerificacao": "43300103440001429000S000001851218736215",
//          "NFSeDataEmissao": ""
//        },
//        "DocImpPrefeitura": "",
//        "DocCompleto": ""
//      }
//    ]
//  }
//]
{$ENDREGION'}

  Result:= False;

  // não teve retorno
  if FobDocs.cdsRetorno.RecordCount <= 0 then
     exit;

  Alertas:= '';
  FobDocs.cdsRetorno.First;
  while not FobDocs.cdsRetorno.Eof do  // so deveria ter um registro no CDS, mas faz uma varedura geral
  begin
    if Nst(FobDocs.cdsRetorno['SitCodigo']) <> '101' then
       Alertas:=  Nst(FobDocs.cdsRetorno['SitCodigo']) + ' - '+Nst(FobDocs.cdsRetorno['SitDescricao'])
    else
      if Nst(FobDocs.cdsRetorno['Codigo']) <> '100' then
         Alertas:=  Nst(FobDocs.cdsRetorno['Codigo']) + ' - '+Nst(FobDocs.cdsRetorno['Descricao'])
      else
      begin
        AProtocolo:= FobDocs.cdsRetorno.FieldByName('DocProtocolo').AsString;
        Serie     := FobDocs.cdsRetorno.FieldByName('DocSerie').AsString;
        Numero    := FobDocs.cdsRetorno.FieldByName('DocNumero').AsString;
        AHora     := TimeToStr(now);
        AData     := Date;

        // grava XML do cancelamento
        DirXml := FPastaNFSe.CriarDiretoriosPorData(FPastaNFSe.PastaCanceladas, AData);
        Arquivo:= DirXml + AProtocolo + '-proNFSe.xml';
        DecodeAndSave(FobDocs.cdsRetorno.FieldByName('DocXMLBase64').AsString, Arquivo);

        // Aqui tem que ler o XML para acha o protocolo de cancelamento

        // grava PDF do cancelamento
        Arquivo:= DirXml + AProtocolo + '-Cancelamento.pdf';
        DecodeAndSave(FobDocs.cdsRetorno.FieldByName('DocPDFBase64').AsString, Arquivo);

      end;

    FobDocs.cdsRetorno.Next;
  end;

  if Alertas <> '' then
     DL_Msg(FormatarMsgErro(Alertas),'Cancelamento','Erro')
  else
     Result:= True;

end;

function TOperacoesNFSeMigrate.ExecutaCancelamento(ASerie, ANumero, AProtocolo, AJustificativa:String; out ARetProtocolo, AHora:String; out AData: TdateTime): Boolean;
var
  obDocumento, obEvento: TJSONObject;
  nRps: String;
begin

{$REGION 'modelo JSON Cancelamento'}
//[                                     aqui -> FobDocs.obDocumentos
//  {                                   aqui -> obDocumento
//    "ModeloDocumento": "NFSe",
//    "Versao": 1,
//    "Evento": {                       aqui -> obEvento
//      "CNPJ": "24388580000285",
//      "NFSeNumero": 202000000000233,
//      "RPSNumero": 1,
//      "RPSSerie": "251",
//      "EveTp": 110111,
//      "tpAmb": 2,
//      "EveCodigo": "1",
//      "EveMotivo": "Nota emitida com dados incorretos.",
//      "NFSeCodVerificacao": "",
//      "Protocolo": "",
//      "SituacaoNota": 0,
//      "NumeroLote": 0
//    }
//  }
//]
{$ENDREGION'}

  Result:= False;

  nRPS:= PesquisaRSP_Nota(ASerie, ANumero);
  if nRPS = '' then
    raise Exception.Create('Não foi localizado o RPS da nota.');

  // ---- Cria os objetos -----------

  obDocs.obDocumentos.AddElement(TJSONObject.Create);  // Cria o documento principal, é um array que vai conter todos os demais objetos JSON
  obEvento := TJSONObject.Create;                      // cria objeto um nivel abaixo, Evento
  try

    // ---- inserção dos itens do JSON ------
    obDocumento := TJSONObject(obDocs.obDocumentos.Get(FobDocs.obDocumentos.Size - 1)); // insere no objeto principal o obDocumento que contém a estrutura geral do JSON
    obDocumento.AddPair('ModeloDocumento', TJSONString.Create('NFSe'));
    obDocumento.AddPair('Versao',          TJSONNumber.Create(1));

    // "Evento": {
    obDocumento.AddPair('Evento', obEvento); // insere o objeto obEvento no objeto pai obDocumento
    obEvento.AddPair('CNPJ',              TJSONString.Create(StrZero(LimpaNumero(Empresa.getCgcmf), 14)));
    obEvento.AddPair('NFSeNumero',        TJSONString.Create(ANumero));
    obEvento.AddPair('RPSNumero',         TJSONString.Create(nRPS));
    obEvento.AddPair('RPSSerie',          TJSONString.Create(FCFG_SERRPS));
    obEvento.AddPair('EveTp',             TJSONString.Create('110111'));
    obEvento.AddPair('tpAmb',             TJSONString.Create(FCFG_NFSAMB));
    obEvento.AddPair('EveCodigo',         TJSONString.Create('1'));
    obEvento.AddPair('EveMotivo',         TJSONString.Create(AJustificativa));
    obEvento.AddPair('NFSeCodVerificacao',TJSONString.Create(''));
    obEvento.AddPair('Protocolo',         TJSONString.Create(AProtocolo));
//    obEvento.AddPair('SituacaoNota',      TJSONNumber.Create());
//    obEvento.AddPair('NumeroLote',        TJSONNumber.Create());


    obDocs.EnviarDocumentos('CancelarNFSe');
    Result:= ProcessarRetornoCancelamento(ARetProtocolo, AHora, AData);
  finally
    obEvento.Free;
  end;
end;

function TOperacoesNFSeMigrate.CancelaNFSe(ASerie, ANumero, ACodigoCanc, AMotivo: String): Boolean;
Var
  ObNFSe: TNFSe;
  obNota: TNotasresumidonfe;
  AProtocolo, AHora, DirXml, Arquivo: String;
  AData : TDateTime;

begin
  if (Trim(ASerie) = '') then
    raise Exception.Create('Série da NFS-e não informada.');

  if (Trim(ANumero) = '') then
    raise Exception.Create('Número da NFS-e não informado.');

  obNota := TNotasresumidonfe.Create;
  ObNFSe := TNFSe.Create(Nil);
  try
    obNota.setNfs_serie(ASerie);
    obNota.setNfs_num(ANumero);
    if (obNota.Consultar) then
    begin
      if ExecutaCancelamento(obNota.getNfs_serie, obNota.getNfs_num, obNota.getNfs_nfeprt, AMotivo, AProtocolo, AHora, AData) then
         ObNFSe.GravarCancelamentoBD(ASerie, ANumero, AMotivo, AProtocolo, AData);
    end;
  finally
    obNota.Free;
    ObNFSe.Free;
  end;
end;

function TOperacoesNFSeMigrate.GetDateTime(ADateTimeStr: String): TDateTime;
begin
  Result := GetDataDMAdeAMD(Strtran(ADateTimeStr, 'T', ' '));
end;

function TOperacoesNFSeMigrate.GetMotivosDeCancelamento: TStringList;
Var
  Motivos: TStringList;
begin
  Motivos := TStringList.Create;
  Motivos.Add('1 - Erro na emissão');
  Motivos.Add('2 - Serviço não prestado');
  Motivos.Add('3 - Duplicidade da nota');
  Result := Motivos;
end;

function TOperacoesNFSeMigrate.GetobDocs: TDocumento;
begin
  if not Assigned(FobDocs) then
    FobDocs := TDocumento.Create;

  Result := FobDocs;
end;

function TOperacoesNFSeMigrate.ProcessarRetornoInutilizacao(out AProtocolo, AHora:String; out AData: TdateTime): Boolean;
var
  Alertas, DirXml, Arquivo, Serie, Numero: String;

begin
{$REGION 'modelo JSON Retorno Inutilização'}
//[
//  {
//    "Codigo": 100,
//    "Descricao": "Documentos processados",
//    "Documentos": [
//      {
//        "DocModelo": "NFSE",
//        "DocNumero": 1002,
//        "DocSerie": "251",
//        "DocChaAcesso": "",
//       "DocProtocolo": "",
//        "DocEvenSeq": 0,
//        "DocEveTp": 0,
//        "DocEveId": "",
//        "DocPDFBase64": "",
//        "DocPDFDownload": "",
//        "DocDhAut": "",
//        "DocDigestValue": "",
//        "DocXMLBase64": "",
//        "DocXMLDownload": "",
//       "DocImpressora": "",
//        "Situacao": {
//          "SitCodigo": 102,
//          "SitDescricao": "Inutilizado"
//        },
//        "MensagemSefaz": {
//          "CodMsg": 0,
//          "DscMsg": ""
//        },
//        "NFSe": {
//         "NFSeNumero": 0,
//          "NFSeCodVerificacao": "",
//          "NFSeDataEmissao": ""
//        },
//        "DocImpPrefeitura": "",
//        "DocCompleto": ""
//      }
//    ]
//  }
//]
{$ENDREGION'}

  Result:= False;

  // não teve retorno
  if FobDocs.cdsRetorno.RecordCount <= 0 then
     exit;

  Alertas:= '';
  FobDocs.cdsRetorno.First;
  while not FobDocs.cdsRetorno.Eof do  // so deveria ter um registro no CDS, mas faz uma varedura geral
  begin
    if Nst(FobDocs.cdsRetorno['SitCodigo']) <> '102' then
       Alertas:=  Nst(FobDocs.cdsRetorno['SitCodigo']) + ' - '+Nst(FobDocs.cdsRetorno['SitDescricao'])
    else
      if Nst(FobDocs.cdsRetorno['Codigo']) <> '100' then
         Alertas:=  Nst(FobDocs.cdsRetorno['Codigo']) + ' - '+Nst(FobDocs.cdsRetorno['Descricao'])
      else
      begin
        AProtocolo:= FobDocs.cdsRetorno.FieldByName('DocProtocolo').AsString;
        Serie     := FobDocs.cdsRetorno.FieldByName('DocSerie').AsString;
        Numero    := FobDocs.cdsRetorno.FieldByName('DocNumero').AsString;
        AHora     := TimeToStr(now);
        AData     := Date;
      end;

    FobDocs.cdsRetorno.Next;
  end;

  if Alertas <> '' then
     DL_Msg(FormatarMsgErro(Alertas),'Inutilização','Erro')
  else
     Result:= True;
end;

Procedure TOperacoesNFSeMigrate.GravarInutilizacao(ASerie,ANumeroIni,ANumeroFim,AMotivo, AProtocolo:String);
var
   obNroinutil: TNroinutil;

begin
   obNroinutil:= TNroinutil.Create;
   try
     obNroinutil.setInu_id(obNroinutil.Auto_inc_inu_id(1));
     obNroinutil.setInu_sernf(ASerie);
     obNroinutil.setInu_numini(ANumeroIni);
     obNroinutil.setInu_numfim(ANumeroFim);
     obNroinutil.setInu_modelo('98'); // fixo
     obNroinutil.setInu_jutif(AMotivo);
     obNroinutil.setInu_datatu(Date);
     obNroinutil.setInu_usratu(conexao.GetUsuario);
     obNroinutil.setInu_protoc(AProtocolo);
     obNroinutil.Incluir;
   finally
     obNroinutil.Free;
   end;
end;

function TOperacoesNFSeMigrate.InutilizarNumerosNFSe(ASerie,ANumeroIni,ANumeroFim,AMotivo:String): Boolean;
var
  obDocumento: TJSONObject;
  RetProtocolo, RetHora:String;
  RetData: TdateTime;

begin

{$REGION 'modelo JSON Inutilizacao'}
//[
//	{
//	   "ModeloDocumento": "NFSe",
//	   "Versao": "1.00",
//	   "CnpjEmissor": "24388580000285",
//	   "tpAmb": "2",
//	   "UfEmissor": 43,
//	   "NumeroInicial": "2",
//	   "NumeroFinal": "2",
//	   "Serie": "251",
//	   "Justificativa": "Pulos de numeração."
//	}
//
{$ENDREGION'}

  Result:= False;

  obDocs.obDocumentos.AddElement(TJSONObject.Create);  // Cria o documento principal, é um array que vai conter todos os demais objetos JSON

  // ---- inserção dos itens do JSON ------
  obDocumento := TJSONObject(obDocs.obDocumentos.Get(FobDocs.obDocumentos.Size - 1)); // insere no objeto principal o obDocumento que contém a estrutura geral do JSON
  obDocumento.AddPair('ModeloDocumento', TJSONString.Create('NFSe'));
  obDocumento.AddPair('Versao',          TJSONNumber.Create(1));
  obDocumento.AddPair('CnpjEmissor',     TJSONString.Create(StrZero(LimpaNumero(Empresa.getCgcmf), 14)));
  obDocumento.AddPair('tpAmb',           TJSONString.Create(FCFG_NFSAMB));
  obDocumento.AddPair('UfEmissor',       TJSONNumber.Create(Nvl(CodigoUF(Empresa.getestado))));
  obDocumento.AddPair('NumeroInicial',   TJSONString.Create(ANumeroIni));
  obDocumento.AddPair('NumeroFinal',     TJSONString.Create(ANumeroFim));
  obDocumento.AddPair('Serie',           TJSONString.Create(ASerie));
  obDocumento.AddPair('Justificativa',   TJSONString.Create(AMotivo));

  obDocs.EnviarDocumentos('InutilizarNFSe');
  Result:= ProcessarRetornoInutilizacao(RetProtocolo, RetHora, RetData);
  if Result then
  begin
     GravarInutilizacao(ASerie,ANumeroIni,ANumeroFim,AMotivo,RetProtocolo);
     DL_Msg('Inutilização confimada.','Inutilziar','Informacao' );
  end
  else
     DL_Msg('Inutilização Falou.','Inutilziar','Erro' );
end;

end.

{ Natureza de operação
  1 – Tributação no município;
  2 – Tributação fora do município;
  3 – Isenção;
  4 – Imune;
  5 – Exigibilidade suspensa por decisão judicial;
  6 – Exigibilidade suspensa por procedimento administrativo


  Situação do lote
  1 – Não Recebido
  2 – Não Processado
  3 – Processado com Erro
  4 – Processado com Sucesso

}
