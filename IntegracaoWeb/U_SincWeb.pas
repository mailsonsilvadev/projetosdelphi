unit U_SincWeb;

interface

uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, Buttons, StrUtils, ExtCtrls, DBCtrls, Vcl.ComCtrls, DBClient,
  DateUtils, U_WebIntegracaoPais, SOAPHTTPClient,
  U_WebIntegracaoCidade, U_WebIntegracaoProduto, U_WebIntegracaoCliente,
  U_WebIntegracaoPedido, U_WebIntegracaoBanco, U_WebIntegracaoCondPagamento,
  U_WebIntegracaoConvenio, U_WebIntegracaoFeriado, U_WebIntegracaoFonteCli,
  U_WebIntegracaoNcmTributacao, U_WebIntegracaoVendedor,
  U_WebIntegracaoGrupoCli, U_WebIntegracaoGrupoPro, U_WebIntegracaoIcmsUf,
  U_WebIntegracaoCadCfop, U_WebIntegracaoCadOcorrencias,
  U_WebIntegracaoTabPrecoVal, U_WebIntegracaoReferencia, InvokeRegistry,
  U_WebIntegracaoRegiaoCli, U_WebIntegracaoSegmentoCli, wsIntegracao,
  U_WebIntegracaoTabPreco, U_WebIntegracaoCadTna, U_WebIntegracaoTipoPag, U_WebIntegracaoPedidoHist,
  U_WebIntegracaoTransportador, Transacao, U_ListaObjetos, U_FTPArquivos, U_WebIntegracaoSaldoTmp, CParametros;

type
  TSincWeb = class(TObject)
  private
    FMyOwner: TPersistent;
    FDicImportacao: TListaObjetos;
    FWebBd: String;
    FWebUni: Integer;
    FExportados: Integer;
    procedure SelecionarDados;
    procedure SetMyOwner(const Value: TPersistent);
    procedure SetDicImportacao(const Value: TListaObjetos);
    procedure SetWebBd(const Value: String);
    procedure SetWebUni(const Value: Integer);
    procedure SetExportados(const Value: Integer);
  public
    constructor Create(Owner: TPersistent);

    property DicImportacao: TListaObjetos read FDicImportacao write SetDicImportacao;
    property MyOwner: TPersistent read FMyOwner write SetMyOwner;
    property WebBd: String read FWebBd write SetWebBd;
    property WebUni: Integer read FWebUni write SetWebUni;
    property Exportados: Integer read FExportados write SetExportados;

    // Carrega os objetos para importação dos dados
    procedure ImportarDados(AImpClientes, AImpPedidos: Boolean);
    procedure ImportarDadosTabela(ATabela: String);

    // Exportação de dados
    procedure ExportarDadosAtualizados;
    procedure FazExportacao(TipoGouE, NomeObj, ChaveObj: String);
    procedure ExcluirLog(WebLogId: Integer);

    function ExcluirArquivo(AArquivo: String): Boolean;

    procedure RegistrarWebService;
  end;

implementation

uses U_T2, U_SisProc, U_UteisWeb;

{ TSincWeb }

constructor TSincWeb.Create(Owner: TPersistent);
var
  obParametros: TParametros;
begin
  inherited Create();
  MyOwner := Owner;

  DicImportacao := TListaObjetos.Create;
  Exportados := 0;

  obParametros := TParametros.Create();
  try
    WebBd := obParametros.getWebBd;
    WebUni := Ivl(obParametros.getWebUni);
  finally
    obParametros.Free;
  end;
end;

function TSincWeb.ExcluirArquivo(AArquivo: String): Boolean;
var
  obIntegracao: wsIntegracaoPort;
  HTTPRIO1: THTTPRIO;
begin
  HTTPRIO1 := THTTPRIO.Create(T2);
  try
    obIntegracao := GetwsIntegracaoPort(false, '', HTTPRIO1);
    Result := obIntegracao.ExcluirArquivo(AArquivo);
  finally
    obIntegracao := nil;
    HTTPRIO1.Free;
  end;
end;

procedure TSincWeb.ExcluirLog(WebLogId: Integer);
var
  Q: String;
begin
  Q := 'Delete From WebLog Where ID = ' + Nst(WebLogId);

  T2.qTemp.Close;
  T2.qTemp.SQL.Clear;
  T2.qTemp.SQL.Add(Q);
  // T2.qTemp.ParamByName('ID').AsInteger := WebLogId; Retirado devido a um bug no Delphi
  T2.qTemp.ExecSQL();
end;

procedure TSincWeb.ExportarDadosAtualizados;
var
  cdsDados: TClientDataSet;
begin
  // Seleciona os registros atualizados que serão exportados
  SelecionarDados;

  cdsDados := TClientDataSet.Create(T2);
  try
    AlimentaRelCds('', T2.cdsWeb, cdsDados);

    cdsDados.First;
    while not cdsDados.Eof do
    begin
      // Gera o json do objeto atualizado
      FazExportacao(Nst(cdsDados['Tipo']), Nst(cdsDados['Objeto']), Nst(cdsDados.FieldByName('Chave').AsString));

      // Exclui o registro do log, para não realizar nova exportação
      ExcluirLog(Ivl(cdsDados['ID']));

      Inc(FExportados);

      Application.ProcessMessages;
      cdsDados.Next;
    end;
  finally
    cdsDados.Free;
  end;
end;

procedure TSincWeb.FazExportacao(TipoGouE, NomeObj, ChaveObj: String);
var
  obPais: TWebIntegracaoPais;
  obCidade: TWebIntegracaoCidade;
  obProduto: TWebIntegracaoProduto;
  obCliente: TWebIntegracaoCliente;
  obPedido: TWebIntegracaoPedido;
  obPedidoHist: TWebIntegracaoPedidoHist;
  obBanco: TWebIntegracaoBanco;
  obCondPagto: TWebIntegracaoCondPagamento;
  obConvenio: TWebIntegracaoConvenio;
  obFeriado: TWebIntegracaoFeriado;
  obFonteCli: TWebIntegracaoFonteCli;
  obNcmTrib: TWebIntegracaoNcmTributacao;
  obVendedor: TWebIntegracaoVendedor;
  obGrupoCli: TWebIntegracaoGrupoCli;
  obGrupoPro: TWebIntegracaoGrupoPro;
  obIcmsUf: TWebIntegracaoIcmsUf;
  obCfop: TWebIntegracaoCadCfop;
  obOcorre: TWebIntegracaoCadOcorrencias;
  obPreco: TWebIntegracaoTabPrecoVal;
  obReferencia: TWebIntegracaoReferencia;
  obRegiao: TWebIntegracaoRegiaoCli;
  obSegmento: TWebIntegracaoSegmentoCli;
  obTabPreco: TWebIntegracaoTabPreco;
  obCadTna: TWebIntegracaoCadTna;
  obTipoPag: TWebIntegracaoTipoPag;
  obTransportador: TWebIntegracaoTransportador;
  obSaldoTmp: TWebIntegracaoSaldoTmp;
  strLogChave: TStringList;
  I: Integer;
  DataStr: String;
begin
  NomeObj := UpperCaseAcentuado(NomeObj);
  strLogChave := TStringList.Create;
{$REGION 'Faz a exportação conforme o objeto'}
  try
    strLogChave.Delimiter := '|';
    strLogChave.DelimitedText := UpperCaseAcentuado(ChaveObj);
    strLogChave.NameValueSeparator := '=';

    if NomeObj = 'TPAIS' then
    begin
      obPais := TWebIntegracaoPais.Create;
      try
        obPais.FazExportacao(TipoGouE, strLogChave.Values['PAI_CODIGO']);
      finally
        obPais.Free;
      end;
    end;

    if NomeObj = 'TCIDADE' then
    begin
      obCidade := TWebIntegracaoCidade.Create;
      try
        obCidade.FazExportacao(TipoGouE, strLogChave.Values['MUN_CODIGO']);
      finally
        obCidade.Free;
      end;
    end;

    if NomeObj = 'TBANCO' then
    begin
      obBanco := TWebIntegracaoBanco.Create(MyOwner);
      try
        obBanco.FazExportacao(TipoGouE, strLogChave.Values['LOC_CODIGO']);
      finally
        obBanco.Free;
      end;
    end;

    if NomeObj = 'TCONDPAGAMENTO' then
    begin
      obCondPagto := TWebIntegracaoCondPagamento.Create();
      try
        obCondPagto.FazExportacao(TipoGouE, strLogChave.Values['PGNF_COD']);
      finally
        obCondPagto.Free;
      end;
    end;

    if NomeObj = 'TCONVENIO' then
    begin
      obConvenio := TWebIntegracaoConvenio.Create(MyOwner);
      try
        obConvenio.FazExportacao(TipoGouE, strLogChave.Values['CNV_CODIGO']);
      finally
        obConvenio.Free;
      end;
    end;

    if NomeObj = 'TFERIADO' then
    begin
      obFeriado := TWebIntegracaoFeriado.Create();
      try
        obFeriado.FazExportacao(TipoGouE, StrYmdToDate(strLogChave.Values['FER_DTAFER']));
      finally
        obFeriado.Free;
      end;
    end;

    if NomeObj = 'TFONTECLI' then
    begin
      obFonteCli := TWebIntegracaoFonteCli.Create();
      try
        obFonteCli.FazExportacao(TipoGouE, strLogChave.Values['FON_CODIGO']);
      finally
        obFonteCli.Free;
      end;
    end;

    if NomeObj = 'TVENDEDOR' then
    begin
      obVendedor := TWebIntegracaoVendedor.Create(MyOwner);
      try
        obVendedor.FazExportacao(TipoGouE, strLogChave.Values['FUN_CODIGO']);
      finally
        obVendedor.Free;
      end;
    end;

    if NomeObj = 'TGRUPOCLI' then
    begin
      obGrupoCli := TWebIntegracaoGrupoCli.Create();
      try
        obGrupoCli.FazExportacao(TipoGouE, strLogChave.Values['GRP_CODIGO']);
      finally
        obGrupoCli.Free;
      end;
    end;

    if NomeObj = 'TGRUPOPRO' then
    begin
      obGrupoPro := TWebIntegracaoGrupoPro.Create();
      try
        obGrupoPro.FazExportacao(TipoGouE, strLogChave.Values['GRU_CODIGO']);
      finally
        obGrupoPro.Free;
      end;
    end;

    if NomeObj = 'TICMSUF' then
    begin
      obIcmsUf := TWebIntegracaoIcmsUf.Create();
      try
        obIcmsUf.FazExportacao(TipoGouE, strLogChave.Values['ICMS_UF'], strLogChave.Values['ICMS_PROD'], strLogChave.Values['ICMS_CLI'], Nvl(strLogChave.Values['ICMS_ALIQ']));
      finally
        obIcmsUf.Free;
      end;
    end;

    if NomeObj = 'TCADCFOP' then
    begin
      obCfop := TWebIntegracaoCadCfop.Create();
      try
        obCfop.FazExportacao(TipoGouE, strLogChave.Values['NT_CFO'], strLogChave.Values['NT_OPC']);
      finally
        obCfop.Free;
      end;
    end;

    if NomeObj = 'TREFERENCIA' then
    begin
      obReferencia := TWebIntegracaoReferencia.Create();
      try
        obReferencia.FazExportacao(TipoGouE, strLogChave.Values['REF_CODIGO']);
      finally
        obReferencia.Free;
      end;
    end;

    if NomeObj = 'TREGIAOCLI' then
    begin
      obRegiao := TWebIntegracaoRegiaoCli.Create();
      try
        obRegiao.FazExportacao(TipoGouE, strLogChave.Values['REG_CODIGO']);
      finally
        obRegiao.Free;
      end;
    end;

    if NomeObj = 'TSEGMENTOCLI' then
    begin
      obSegmento := TWebIntegracaoSegmentoCli.Create();
      try
        obSegmento.FazExportacao(TipoGouE, strLogChave.Values['SEG_CODIGO']);
      finally
        obSegmento.Free;
      end;
    end;

    if NomeObj = 'TCADTNA' then
    begin
      obCadTna := TWebIntegracaoCadTna.Create();
      try
        obCadTna.FazExportacao(TipoGouE, strLogChave.Values['TNA_CODIGO']);
      finally
        obCadTna.Free;
      end;
    end;

    if NomeObj = 'TTIPOPAG' then
    begin
      obTipoPag := TWebIntegracaoTipoPag.Create(MyOwner);
      try
        obTipoPag.FazExportacao(TipoGouE, strLogChave.Values['TPG_CODIGO']);
      finally
        obTipoPag.Free;
      end;
    end;

    if NomeObj = 'TTRANSPORTADOR' then
    begin
      obTransportador := TWebIntegracaoTransportador.Create(MyOwner);
      try
        obTransportador.FazExportacao(TipoGouE, strLogChave.Values['TRS_CODIGO']);
      finally
        obTransportador.Free;
      end;
    end;

    if NomeObj = 'TPRODUTO' then
    begin
      obProduto := TWebIntegracaoProduto.Create;
      try
        obProduto.FazExportacao(TipoGouE, strLogChave.Values['PRO_CODIGO']);
      finally
        obProduto.Free;
      end;

      obPreco := TWebIntegracaoTabPrecoVal.Create();
      try
        obPreco.FazExportacao(TipoGouE, strLogChave.Values['PRO_CODIGO']);
      finally
        obPreco.Free;
      end;
    end;

    if NomeObj = 'TCLIENTE' then
    begin
      obCliente := TWebIntegracaoCliente.Create(MyOwner);
      try
        case AnsiIndexStr(strLogChave.Values['TABELA'], ['SCRACLI', 'SCRACLIV', 'SCRACLIJ', 'CADACTN']) of
          0:
            obCliente.FazExportacao(TipoGouE, strLogChave.Values['CLI_CODIGO']);
          1, 2:
            obCliente.FazExportacao(TipoGouE, strLogChave.Values['CLICODIGO']);
          3:
            obCliente.FazExportacao(TipoGouE, strLogChave.Values['CTN_CODIGO']);
        end;
      finally
        obCliente.Free;
      end;
    end;

    if NomeObj = 'TPEDIDO' then
    begin
      obPedido := TWebIntegracaoPedido.Create(MyOwner);
      try
        case AnsiIndexStr(strLogChave.Values['TABELA'], ['WTPEDIDO', 'WTPEDIDOHIST']) of
          0:
            obPedido.FazExportacao(TipoGouE, strLogChave.Values['ID']);
          1:
            obPedido.FazExportacao(TipoGouE, strLogChave.Values['IDTPEDIDO']);
        end;
      finally
        obPedido.Free;
      end;
    end;

    if NomeObj = 'TPEDIDOHIST' then
    begin
      obPedidoHist := TWebIntegracaoPedidoHist.Create;
      try
        obPedidoHist.FazExportacao(TipoGouE, StrToInt(strLogChave.Values['PDH_ID']));
      finally
        obPedidoHist.Free;
      end;
    end;

    if NomeObj = 'TNCMTRIBUTACAO' then
    begin
      obNcmTrib := TWebIntegracaoNcmTributacao.Create();
      try
        obNcmTrib.FazExportacao(TipoGouE, strLogChave.Values['NCM_ID']);
      finally
        obNcmTrib.Free;
      end;
    end;

    if NomeObj = 'TCADOCORRENCIAS' then
    begin
      obOcorre := TWebIntegracaoCadOcorrencias.Create();
      try
        obOcorre.FazExportacao(TipoGouE, strLogChave.Values['OCR_CODIGO']);
      finally
        obOcorre.Free;
      end;
    end;

    if NomeObj = 'TTABPRECOVAL' then
    begin
      obPreco := TWebIntegracaoTabPrecoVal.Create();
      try
        obPreco.FazExportacao(TipoGouE, strLogChave.Values['TAB_CODPRO'], strLogChave.Values['TAB_NRO']);
      finally
        obPreco.Free;
      end;
    end;

    if NomeObj = 'TTABPRECO' then
    begin
      obTabPreco := TWebIntegracaoTabPreco.Create();
      try
        obTabPreco.FazExportacao(TipoGouE, strLogChave.Values['TBC_CODIGO']);
      finally
        obTabPreco.Free;
      end;
    end;

    if NomeObj = 'TSALDOTMP' then
    begin
      obSaldoTmp := TWebIntegracaoSaldoTmp.Create();
      try
        obSaldoTmp.FazExportacao(TipoGouE, strLogChave.Values['ALX_CODPRO'], strLogChave.Values['ALX_CODALX']);
      finally
        obSaldoTmp.Free;
      end;
    end;
  finally
    strLogChave.Free;
  end;
{$ENDREGION}
end;

procedure TSincWeb.ImportarDados(AImpClientes, AImpPedidos: Boolean);
var
  ListaArqs: TStringList;
begin

  ListaArqs := TStringList.Create;
  try
    if AImpClientes then
      ImportarDadosTabela('tcliente');

    if AImpPedidos then
      ImportarDadosTabela('tpedido');
  finally
    ListaArqs.Free;
  end;
end;

procedure TSincWeb.ImportarDadosTabela(ATabela: String);
var
  I, IndiceLista: Integer;
  obIntegracao: wsIntegracaoPort;
  HTTPRIO1: THTTPRIO;
  objetos: TArray<string>;
  Teste: String;
begin
  if ATabela.IsEmpty then
    raise Exception.Create('Tabela de importação não informada!');

  HTTPRIO1 := THTTPRIO.Create(T2);
  try
    obIntegracao := GetwsIntegracaoPort(false, '', HTTPRIO1);
    objetos := obIntegracao.getJson(FWebBd, FWebUni, ATabela);
    for I := 0 to Length(objetos) - 1 do
    begin
      if ATabela = 'tcliente' then
      begin
        IndiceLista := FDicImportacao.Lista.Add(TWebIntegracaoCliente.Create(MyOwner));
        TWebIntegracaoCliente(FDicImportacao.Lista.Items[IndiceLista]).FazImportacao(objetos[I]);
      end
      else if ATabela = 'tpedido' then
      begin
        IndiceLista := FDicImportacao.Lista.Add(TWebIntegracaoPedido.Create(MyOwner));
        TWebIntegracaoPedido(FDicImportacao.Lista.Items[IndiceLista]).FazImportacao(objetos[I]);
      end;
    end;
  finally
    obIntegracao := nil;
    HTTPRIO1.Free;
  end;
end;

procedure TSincWeb.RegistrarWebService;
var
  defURL, eApp: String;
  obParametros: TParametros;
begin
  obParametros := TParametros.Create;
  try
    defURL  := obParametros.getWebSrv;
    eApp := obParametros.getWebApp;
  finally
    obParametros.Free;
  end;

  //Deve registrar todos os WS utilizados uma única vez por aplicação
  InvRegistry.RegisterInterface(TypeInfo(wsIntegracaoPort), defURL + '/' + eApp + '/soap.php?class=wsIntegracao', '');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(wsIntegracaoPort), defURL + '/' + eApp + '/soap.php?class=wsIntegracao#%operationName%');
end;

procedure TSincWeb.SelecionarDados;
var
  Q: String;
begin
  Q := 'Select ID, Objeto, Chave, Tipo';
  Q := Q + sLineBreak + 'From WebLog';
  Q := Q + sLineBreak + 'Order By Data, Hora';

  T2.cdsWeb.Active := false;
  T2.qWeb.Close;
  T2.qWeb.SQL.Clear;
  T2.qWeb.SQL.Add(Q);
  T2.cdsWeb.Active := True;
end;

procedure TSincWeb.SetDicImportacao(const Value: TListaObjetos);
begin
  FDicImportacao := Value;
end;

procedure TSincWeb.SetExportados(const Value: Integer);
begin
  FExportados := Value;
end;

procedure TSincWeb.SetMyOwner(const Value: TPersistent);
begin
  FMyOwner := Value;
end;

procedure TSincWeb.SetWebBd(const Value: String);
begin
  FWebBd := Value;
end;

procedure TSincWeb.SetWebUni(const Value: Integer);
begin
  FWebUni := Value;
end;

end.
