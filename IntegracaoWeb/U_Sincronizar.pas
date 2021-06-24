unit U_Sincronizar;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, Buttons, ExtCtrls, DBCtrls, Vcl.ComCtrls, U_WebIntegracaoPais,
  U_WebIntegracaoCidade, U_WebIntegracaoProduto, U_WebIntegracaoCliente,
  U_WebIntegracaoPedido, U_WebIntegracaoBanco, U_WebIntegracaoCondPagamento,
  U_WebIntegracaoConvenio, U_WebIntegracaoFeriado, U_WebIntegracaoFonteCli,
  U_WebIntegracaoNcmTributacao, U_WebIntegracaoVendedor,
  U_WebIntegracaoGrupoCli, U_WebIntegracaoGrupoPro, U_WebIntegracaoIcmsUf,
  U_WebIntegracaoCadCfop, U_WebIntegracaoCadOcorrencias,
  U_WebIntegracaoTabPrecoVal, U_WebIntegracaoReferencia,
  U_WebIntegracaoRegiaoCli, U_WebIntegracaoSegmentoCli, U_WebIntegracaoPedidoHist,
  U_WebIntegracaoTabPreco, U_WebIntegracaoCadTna, U_WebIntegracaoTipoPag,
  U_WebIntegracaoTransportador, U_WebIntegracaoSaldoTmp, U_SincWeb, U_SincImportacao;

type
  TF_Sincronizar = class(TForm)
    Panel1: TPanel;
    Confirmar: TBitBtn;
    fechar: TSpeedButton;
    gbExportarTodos: TGroupBox;
    gbProdutos: TGroupBox;
    ckProdutos: TCheckBox;
    ckREFPRO: TCheckBox;
    ckTABPRECOS: TCheckBox;
    ckGRUPRO: TCheckBox;
    ckPrecosProdutos: TCheckBox;
    gbGerais: TGroupBox;
    ckTIPOSNAT: TCheckBox;
    ckNaturezas: TCheckBox;
    ckTributacoesNCM: TCheckBox;
    ckICMSUF: TCheckBox;
    ckCONDPAGTO: TCheckBox;
    ckTIPOSPAG: TCheckBox;
    ckBancos: TCheckBox;
    ckTransportadores: TCheckBox;
    ckVendedores: TCheckBox;
    ckFeriados: TCheckBox;
    ckPaises: TCheckBox;
    ckCidades: TCheckBox;
    gbPedidos: TGroupBox;
    ckPedidos: TCheckBox;
    ckOCORPED: TCheckBox;
    gbClientes: TGroupBox;
    ckClientes: TCheckBox;
    ckCONVCLI: TCheckBox;
    ckGRUCLI: TCheckBox;
    ckFontesClientes: TCheckBox;
    ckSEGCLI: TCheckBox;
    ckREGCLI: TCheckBox;
    gbSincronizar: TGroupBox;
    ckImportar: TCheckBox;
    ckExportar: TCheckBox;
    lblAguarde: TLabel;
    pbProcesso: TProgressBar;
    btMarcaDesmarca: TSpeedButton;
    cktsaldotmp: TCheckBox;
    cktpedidohist: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure fecharClick(Sender: TObject);
    procedure ConfirmarClick(Sender: TObject);
    procedure btMarcaDesmarcaClick(Sender: TObject);
  private
    { Private declarations }
    procedure HabilitarForm(Habilitar: Boolean);
    procedure ExportarDadosGeral;
    procedure ExportarDadosAtualizados;
    procedure ExportarDados;
    procedure ImportarDados;
  public
    { Public declarations }
  end;

var
  F_Sincronizar: TF_Sincronizar;

implementation

uses U_Sisproc, U_T2;

{$R *.DFM}

procedure TF_Sincronizar.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := Cafree;
  F_Sincronizar := nil;
end;

procedure TF_Sincronizar.FormKeyPress(Sender: TObject; var Key: Char);
begin
  NextControl(self, Key);
end;

procedure TF_Sincronizar.ExportarDados;
begin
  if ckExportar.Checked then
    ExportarDadosAtualizados;

  // Verifica os dados gerais a serem exportados
  ExportarDadosGeral;
end;

procedure TF_Sincronizar.ExportarDadosAtualizados;
var
  obSincWeb: TSincWeb;
begin
  obSincWeb := TSincWeb.Create(self);
  try
    obSincWeb.ExportarDadosAtualizados;
  finally
    obSincWeb.Free;
  end;
end;

procedure TF_Sincronizar.ExportarDadosGeral;
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
  CountPocesso: Integer;
  TotalProcessos: String;
begin
  // Faz a exportação conforme seleção
  TotalProcessos := '27';
  Inc(CountPocesso);
  lblAguarde.Caption := 'Aguarde... Processo ' + IntToStr(CountPocesso) + '/' + TotalProcessos + ': Países';
  Application.ProcessMessages;
  if ckPaises.Checked then
  begin
    obPais := TWebIntegracaoPais.Create;
    try
      obPais.FazExportacao('G');
      ckPaises.Checked := False;
    finally
      obPais.Free;
    end;
  end;

  Inc(CountPocesso);
  lblAguarde.Caption := 'Aguarde... Processo ' + IntToStr(CountPocesso) + '/' + TotalProcessos + ': Cidades';
  Application.ProcessMessages;
  if ckCidades.Checked then
  begin
    obCidade := TWebIntegracaoCidade.Create;
    try
      obCidade.FazExportacao('G');
      ckCidades.Checked := False;
    finally
      obCidade.Free;
    end;
  end;

  Inc(CountPocesso);
  lblAguarde.Caption := 'Aguarde... Processo ' + IntToStr(CountPocesso) + '/' + TotalProcessos + ': Bancos';
  Application.ProcessMessages;
  if ckBancos.Checked then
  begin
    obBanco := TWebIntegracaoBanco.Create(self);
    try
      obBanco.FazExportacao('G');
      ckBancos.Checked := False;
    finally
      obBanco.Free;
    end;
  end;

  Inc(CountPocesso);
  lblAguarde.Caption := 'Aguarde... Processo ' + IntToStr(CountPocesso) + '/' + TotalProcessos + ': Cond. Pagamento';
  Application.ProcessMessages;
  if ckCONDPAGTO.Checked then
  begin
    obCondPagto := TWebIntegracaoCondPagamento.Create();
    try
      obCondPagto.FazExportacao('G');
      ckCONDPAGTO.Checked := False;
    finally
      obCondPagto.Free;
    end;
  end;

  Inc(CountPocesso);
  lblAguarde.Caption := 'Aguarde... Processo ' + IntToStr(CountPocesso) + '/' + TotalProcessos + ': Convênios';
  Application.ProcessMessages;
  if ckCONVCLI.Checked then
  begin
    obConvenio := TWebIntegracaoConvenio.Create(self);
    try
      obConvenio.FazExportacao('G');
      ckCONVCLI.Checked := False;
    finally
      obConvenio.Free;
    end;
  end;

  Inc(CountPocesso);
  lblAguarde.Caption := 'Aguarde... Processo ' + IntToStr(CountPocesso) + '/' + TotalProcessos + ': Feriados';
  Application.ProcessMessages;
  if ckFeriados.Checked then
  begin
    obFeriado := TWebIntegracaoFeriado.Create();
    try
      obFeriado.FazExportacao('G');
      ckFeriados.Checked := False;
    finally
      obFeriado.Free;
    end;
  end;

  Inc(CountPocesso);
  lblAguarde.Caption := 'Aguarde... Processo ' + IntToStr(CountPocesso) + '/' + TotalProcessos + ': Fontes';
  Application.ProcessMessages;
  if ckFontesClientes.Checked then
  begin
    obFonteCli := TWebIntegracaoFonteCli.Create();
    try
      obFonteCli.FazExportacao('G');
      ckFontesClientes.Checked := False;
    finally
      obFonteCli.Free;
    end;
  end;

  Inc(CountPocesso);
  lblAguarde.Caption := 'Aguarde... Processo ' + IntToStr(CountPocesso) + '/' + TotalProcessos + ': Vendedores';
  Application.ProcessMessages;
  if ckVendedores.Checked then
  begin
    obVendedor := TWebIntegracaoVendedor.Create(self);
    try
      obVendedor.FazExportacao('G');
      ckVendedores.Checked := False;
    finally
      obVendedor.Free;
    end;
  end;

  Inc(CountPocesso);
  lblAguarde.Caption := 'Aguarde... Processo ' + IntToStr(CountPocesso) + '/' + TotalProcessos + ': Grupos Clientes';
  Application.ProcessMessages;
  if ckGRUCLI.Checked then
  begin
    obGrupoCli := TWebIntegracaoGrupoCli.Create();
    try
      obGrupoCli.FazExportacao('G');
      ckGRUCLI.Checked := False;
    finally
      obGrupoCli.Free;
    end;
  end;

  Inc(CountPocesso);
  lblAguarde.Caption := 'Aguarde... Processo ' + IntToStr(CountPocesso) + '/' + TotalProcessos + ': Grupo Produtos';
  Application.ProcessMessages;
  if ckGRUPRO.Checked then
  begin
    obGrupoPro := TWebIntegracaoGrupoPro.Create();
    try
      obGrupoPro.FazExportacao('G');
      ckGRUPRO.Checked := False;
    finally
      obGrupoPro.Free;
    end;
  end;

  Inc(CountPocesso);
  lblAguarde.Caption := 'Aguarde... Processo ' + IntToStr(CountPocesso) + '/' + TotalProcessos + ': ICMS por UF';
  Application.ProcessMessages;
  if ckICMSUF.Checked then
  begin
    obIcmsUf := TWebIntegracaoIcmsUf.Create();
    try
      obIcmsUf.FazExportacao('G');
      ckICMSUF.Checked := False;
    finally
      obIcmsUf.Free;
    end;
  end;

  Inc(CountPocesso);
  lblAguarde.Caption := 'Aguarde... Processo ' + IntToStr(CountPocesso) + '/' + TotalProcessos + ': Naturezas';
  Application.ProcessMessages;
  if ckNaturezas.Checked then
  begin
    obCfop := TWebIntegracaoCadCfop.Create();
    try
      obCfop.FazExportacao('G');
      ckNaturezas.Checked := False;
    finally
      obCfop.Free;
    end;
  end;

  Inc(CountPocesso);
  lblAguarde.Caption := 'Aguarde... Processo ' + IntToStr(CountPocesso) + '/' + TotalProcessos + ': Referências';
  Application.ProcessMessages;
  if ckREFPRO.Checked then
  begin
    obReferencia := TWebIntegracaoReferencia.Create();
    try
      obReferencia.FazExportacao('G');
      ckREFPRO.Checked := False;
    finally
      obReferencia.Free;
    end;
  end;

  Inc(CountPocesso);
  lblAguarde.Caption := 'Aguarde... Processo ' + IntToStr(CountPocesso) + '/' + TotalProcessos + ': Regiões';
  Application.ProcessMessages;
  if ckREGCLI.Checked then
  begin
    obRegiao := TWebIntegracaoRegiaoCli.Create();
    try
      obRegiao.FazExportacao('G');
      ckREGCLI.Checked := False;
    finally
      obRegiao.Free;
    end;
  end;

  Inc(CountPocesso);
  lblAguarde.Caption := 'Aguarde... Processo ' + IntToStr(CountPocesso) + '/' + TotalProcessos + ': Segmentos';
  Application.ProcessMessages;
  if ckSEGCLI.Checked then
  begin
    obSegmento := TWebIntegracaoSegmentoCli.Create();
    try
      obSegmento.FazExportacao('G');
      ckSEGCLI.Checked := False;
    finally
      obSegmento.Free;
    end;
  end;

  Inc(CountPocesso);
  lblAguarde.Caption := 'Aguarde... Processo ' + IntToStr(CountPocesso) + '/' + TotalProcessos + ': Tabelas';
  Application.ProcessMessages;
  if ckTABPRECOS.Checked then
  begin
    obTabPreco := TWebIntegracaoTabPreco.Create();
    try
      obTabPreco.FazExportacao('G');
      ckTABPRECOS.Checked := False;
    finally
      obTabPreco.Free;
    end;
  end;

  Inc(CountPocesso);
  lblAguarde.Caption := 'Aguarde... Processo ' + IntToStr(CountPocesso) + '/' + TotalProcessos + ': Tipos Natureza';
  Application.ProcessMessages;
  if ckTIPOSNAT.Checked then
  begin
    obCadTna := TWebIntegracaoCadTna.Create();
    try
      obCadTna.FazExportacao('G');
      ckTIPOSNAT.Checked := False;
    finally
      obCadTna.Free;
    end;
  end;

  Inc(CountPocesso);
  lblAguarde.Caption := 'Aguarde... Processo ' + IntToStr(CountPocesso) + '/' + TotalProcessos + ': Tipos Pagto';
  Application.ProcessMessages;
  if ckTIPOSPAG.Checked then
  begin
    obTipoPag := TWebIntegracaoTipoPag.Create(self);
    try
      obTipoPag.FazExportacao('G');
      ckTIPOSPAG.Checked := False;
    finally
      obTipoPag.Free;
    end;
  end;

  Inc(CountPocesso);
  lblAguarde.Caption := 'Aguarde... Processo ' + IntToStr(CountPocesso) + '/' + TotalProcessos + ': Transportadores';
  Application.ProcessMessages;
  if ckTransportadores.Checked then
  begin
    obTransportador := TWebIntegracaoTransportador.Create(self);
    try
      obTransportador.FazExportacao('G');
      ckTransportadores.Checked := False;
    finally
      obTransportador.Free;
    end;
  end;

  Inc(CountPocesso);
  lblAguarde.Caption := 'Aguarde... Processo ' + IntToStr(CountPocesso) + '/' + TotalProcessos + ': Saldos';
  Application.ProcessMessages;
  if cktsaldotmp.Checked then
  begin
    obSaldoTmp := TWebIntegracaoSaldoTmp.Create();
    try
      obSaldoTmp.FazExportacao('G');
      cktsaldotmp.Checked := False;
    finally
      obSaldoTmp.Free;
    end;
  end;

  Inc(CountPocesso);
  lblAguarde.Caption := 'Aguarde... Processo ' + IntToStr(CountPocesso) + '/' + TotalProcessos + ': Produtos';
  Application.ProcessMessages;
  if ckProdutos.Checked then
  begin
    obProduto := TWebIntegracaoProduto.Create;
    try
      obProduto.FazExportacao('G');
      ckProdutos.Checked := False;
    finally
      obProduto.Free;
    end;
  end;

  Inc(CountPocesso);
  lblAguarde.Caption := 'Aguarde... Processo ' + IntToStr(CountPocesso) + '/' + TotalProcessos + ': Clientes';
  Application.ProcessMessages;
  if ckClientes.Checked then
  begin
    obCliente := TWebIntegracaoCliente.Create(self);
    try
      obCliente.FazExportacao('G');
      ckClientes.Checked := False;
    finally
      obCliente.Free;
    end;
  end;

  Inc(CountPocesso);
  lblAguarde.Caption := 'Aguarde... Processo ' + IntToStr(CountPocesso) + '/' + TotalProcessos + ': Pedidos';
  Application.ProcessMessages;
  if ckPedidos.Checked then
  begin
    obPedido := TWebIntegracaoPedido.Create(self);
    try
      obPedido.FazExportacao('G');
      ckPedidos.Checked := False;
    finally
      obPedido.Free;
    end;
  end;

  Inc(CountPocesso);
  lblAguarde.Caption := 'Aguarde... Processo ' + IntToStr(CountPocesso) + '/' + TotalProcessos + ': Históricos';
  Application.ProcessMessages;
  if cktpedidohist.Checked then
  begin
    obPedidoHist := TWebIntegracaoPedidoHist.Create;
    try
      obPedidoHist.FazExportacao('G');
      cktpedidohist.Checked := False;
    finally
      obPedidoHist.Free;
    end;
  end;

  Inc(CountPocesso);
  lblAguarde.Caption := 'Aguarde... Processo ' + IntToStr(CountPocesso) + '/' + TotalProcessos + ': Tributações';
  Application.ProcessMessages;
  if ckTributacoesNCM.Checked then
  begin
    obNcmTrib := TWebIntegracaoNcmTributacao.Create();
    try
      obNcmTrib.FazExportacao('G');
      ckTributacoesNCM.Checked := False;
    finally
      obNcmTrib.Free;
    end;
  end;

  Inc(CountPocesso);
  lblAguarde.Caption := 'Aguarde... Processo ' + IntToStr(CountPocesso) + '/' + TotalProcessos + ': Ocorrências';
  Application.ProcessMessages;
  if ckOCORPED.Checked then
  begin
    obOcorre := TWebIntegracaoCadOcorrencias.Create();
    try
      obOcorre.FazExportacao('G');
      ckOCORPED.Checked := False;
    finally
      obOcorre.Free;
    end;
  end;

  Inc(CountPocesso);
  lblAguarde.Caption := 'Aguarde... Processo ' + IntToStr(CountPocesso) + '/' + TotalProcessos + ': Preços';
  Application.ProcessMessages;
  if ckPrecosProdutos.Checked then
  begin
    obPreco := TWebIntegracaoTabPrecoVal.Create();
    try
      obPreco.FazExportacao('G');
      ckPrecosProdutos.Checked := False;
    finally
      obPreco.Free;
    end;
  end;
end;

procedure TF_Sincronizar.HabilitarForm(Habilitar: Boolean);
begin
  if Habilitar then
  begin
    HabilitarTela(self);
    btMarcaDesmarca.Enabled := True;
    Confirmar.Enabled := True;
    lblAguarde.Visible := False;
    pbProcesso.Visible := False;
    lblAguarde.Caption := 'Aguarde...';
  end
  else
  begin
    DesabilitarTela(self);
    btMarcaDesmarca.Enabled := False;
    Confirmar.Enabled := False;
    lblAguarde.Visible := True;
    pbProcesso.Visible := True;;
  end;
  Application.ProcessMessages;
end;

procedure TF_Sincronizar.ImportarDados;
var
  obSincWeb: TSincWeb;
begin
  obSincWeb := TSincWeb.Create(self);
  try
    // Carrega os objetos com os dados a serem importados
    obSincWeb.ImportarDados(True, True);

    if obSincWeb.DicImportacao.Lista.Count > 0 then
    begin
      // Mostra um resumo da importação ao usuário e solicita sua confirmação para gravar os dados
      Application.CreateForm(TF_SincImportacao, F_SincImportacao);
      with F_SincImportacao do
      begin
        // Carrega o dicionário com os objetos importados
        DicImportacao := obSincWeb.DicImportacao;

        // Mostra o resumo da importação ao usuário
        MostrarResumoImportação;
      end;

      if F_SincImportacao.ShowModal <> mrOk then
      begin
        DL_Msg('Operação cancelada pelo usuário!', Application.Title, 'AVISO');
        Abort;
      end;
    end;
  finally
    obSincWeb.Free;
  end;
end;

procedure TF_Sincronizar.btMarcaDesmarcaClick(Sender: TObject);
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

procedure TF_Sincronizar.ConfirmarClick(Sender: TObject);
begin
  Try
    HabilitarForm(False);

    // Importação dos dados atualizados JSON
    if ckImportar.Checked then
      ImportarDados;

    // Exportação dos dados geral ou somente dos atualizados
    ExportarDados;

    if T2.cdsgWtpedido.Active = True then
      T2.cdsgWtpedido.Refresh;

    pbProcesso.Visible := False;
    DL_Msg('Processo concluído!', Application.Title, 'INFORMACAO');
    Close;
  Finally
    HabilitarForm(True);
  End;
end;

procedure TF_Sincronizar.fecharClick(Sender: TObject);
begin
  Close;
end;

end.
