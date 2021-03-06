program WsepeEsepe;

uses
  Forms,
  Winapi.Windows,
  U_T2 in 'U_T2.pas' {T2: TDataModule},
  CSepeCFG in '..\Classes\CSepeCFG.pas',
  Consulta in '..\UnitDataLan\Consulta.pas',
  CEmail in '..\UnitDataLan\CEmail.pas',
  Consulta1 in '..\UnitDataLan\Consulta1.pas' {F_Consulta1},
  CExcel in '..\UnitDataLan\CExcel.pas',
  Conexao in '..\UnitDataLan\Conexao.pas',
  U_Editor in '..\UnitDataLan\U_Editor.pas' {F_Editor},
  U_Senha in '..\UnitDataLan\U_Senha.pas' {F_Senha},
  U_AcessoSistema in '..\UnitDataLan\U_AcessoSistema.pas',
  U_AcessoSistema1 in '..\UnitDataLan\U_AcessoSistema1.pas' {F_AcessoSistema1},
  Abertura in '..\UnitDataLan\Abertura.pas',
  U_ConsultaEmp1 in '..\unitdatalan\U_ConsultaEmp1.pas' {F_ConsultaEmp1},
  U_ConsultaEmp in '..\unitdatalan\U_ConsultaEmp.pas',
  CLog in '..\classes\CLog.pas',
  U_IdentifUsr in '..\Unitdatalan\U_IdentifUsr.pas',
  U_WsepeEsepe in 'U_WsepeEsepe.pas' {F_WsepeEsepe},
  CBrOffice in '..\unitdatalan\CBrOffice.pas',
  U_EscolhaPacote in '..\unitdatalan\U_EscolhaPacote.pas' {F_EscolhaPacote},
  U_CadEmpresa in '..\unitdatalan\U_CadEmpresa.pas' {F_CadEmpresa},
  CValorDefault in '..\unitdatalan\CValorDefault.pas',
  CCidades in '..\classes\CCidades.pas',
  CEmpresa in '..\classes\CEmpresa.pas',
  U_PadraoCad in '..\unitdatalan\U_PadraoCad.pas' {F_PadraoCad},
  U_PadraoManu in '..\unitdatalan\U_PadraoManu.pas' {F_PadraoManu},
  U_ConfigGrid in '..\unitdatalan\U_ConfigGrid.pas',
  SelecaoAvancada in '..\unitdatalan\SelecaoAvancada.pas',
  U_SisProc in '..\unitdatalan\U_SisProc.pas',
  SendMailD_XE in '..\unitdatalan\SendMailD_XE.pas',
  Vcl.Themes,
  Vcl.Styles,
  U_Parametros in 'U_Parametros.pas' {F_Parametros},
  U_Script in 'U_Script.pas',
  Transacao in '..\unitdatalan\Transacao.pas',
  U_GerarObjetos in 'U_GerarObjetos.pas',
  U_Sincronizar in 'U_Sincronizar.pas' {F_Sincronizar},
  U_WebBanco in '..\unitsweb\integracao\U_WebBanco.pas',
  U_WebCadCfop in '..\unitsweb\integracao\U_WebCadCfop.pas',
  U_WebCadOcorrencias in '..\unitsweb\integracao\U_WebCadOcorrencias.pas',
  U_WebCadTna in '..\unitsweb\integracao\U_WebCadTna.pas',
  U_WebCidade in '..\unitsweb\integracao\U_WebCidade.pas',
  U_WebCliente in '..\unitsweb\integracao\U_WebCliente.pas',
  U_WebContato in '..\unitsweb\integracao\U_WebContato.pas',
  U_WebContatoItem in '..\unitsweb\integracao\U_WebContatoItem.pas',
  U_WebConvenio in '..\unitsweb\integracao\U_WebConvenio.pas',
  U_WebEndereco in '..\unitsweb\integracao\U_WebEndereco.pas',
  U_WebEnderecoItem in '..\unitsweb\integracao\U_WebEnderecoItem.pas',
  U_WebFonteCli in '..\unitsweb\integracao\U_WebFonteCli.pas',
  U_WebGrupoCli in '..\unitsweb\integracao\U_WebGrupoCli.pas',
  U_WebGrupoPro in '..\unitsweb\integracao\U_WebGrupoPro.pas',
  U_WebIcmsUf in '..\unitsweb\integracao\U_WebIcmsUf.pas',
  U_WebNcmTributacao in '..\unitsweb\integracao\U_WebNcmTributacao.pas',
  U_WebObjeto in '..\unitsweb\integracao\U_WebObjeto.pas',
  U_WebPais in '..\unitsweb\integracao\U_WebPais.pas',
  U_WebPessoa in '..\unitsweb\integracao\U_WebPessoa.pas',
  U_WebPessoaFis in '..\unitsweb\integracao\U_WebPessoaFis.pas',
  U_WebPessoaJur in '..\unitsweb\integracao\U_WebPessoaJur.pas',
  U_WebProduto in '..\unitsweb\integracao\U_WebProduto.pas',
  U_WebReferencia in '..\unitsweb\integracao\U_WebReferencia.pas',
  U_WebRegiaoCli in '..\unitsweb\integracao\U_WebRegiaoCli.pas',
  U_WebSegmentoCli in '..\unitsweb\integracao\U_WebSegmentoCli.pas',
  U_WebTabPreco in '..\unitsweb\integracao\U_WebTabPreco.pas',
  U_WebTipoPag in '..\unitsweb\integracao\U_WebTipoPag.pas',
  U_WebTransportador in '..\unitsweb\integracao\U_WebTransportador.pas',
  U_WebVendedor in '..\unitsweb\integracao\U_WebVendedor.pas',
  U_WebTabPrecoVal in '..\unitsweb\integracao\U_WebTabPrecoVal.pas',
  U_WebPedidoHist in '..\unitsweb\integracao\U_WebPedidoHist.pas',
  U_WebPedidoPagItem in '..\unitsweb\integracao\U_WebPedidoPagItem.pas',
  U_WebPedidoPag in '..\unitsweb\integracao\U_WebPedidoPag.pas',
  U_WebPedidoItemItem in '..\unitsweb\integracao\U_WebPedidoItemItem.pas',
  U_WebPedidoItem in '..\unitsweb\integracao\U_WebPedidoItem.pas',
  U_WebPedido in '..\unitsweb\integracao\U_WebPedido.pas',
  U_WebIntegracaoPedido in '..\unitsweb\integracao\U_WebIntegracaoPedido.pas',
  U_WebIntegracaoProduto in '..\unitsweb\integracao\U_WebIntegracaoProduto.pas',
  U_WebIntegracaoCidade in '..\unitsweb\integracao\U_WebIntegracaoCidade.pas',
  U_WebIntegracaoCliente in '..\unitsweb\integracao\U_WebIntegracaoCliente.pas',
  U_WebIntegracaoPais in '..\unitsweb\integracao\U_WebIntegracaoPais.pas',
  U_WebIntegracaoBanco in '..\unitsweb\integracao\U_WebIntegracaoBanco.pas',
  U_WebCondPagamento in '..\unitsweb\integracao\U_WebCondPagamento.pas',
  U_WebIntegracaoCondPagamento in '..\unitsweb\integracao\U_WebIntegracaoCondPagamento.pas',
  U_WebIntegracaoConvenio in '..\unitsweb\integracao\U_WebIntegracaoConvenio.pas',
  U_WebIntegracaoFonteCli in '..\unitsweb\integracao\U_WebIntegracaoFonteCli.pas',
  U_WebIntegracaoNcmTributacao in '..\unitsweb\integracao\U_WebIntegracaoNcmTributacao.pas',
  U_WebIntegracaoVendedor in '..\unitsweb\integracao\U_WebIntegracaoVendedor.pas',
  U_WebIntegracaoGrupoCli in '..\unitsweb\integracao\U_WebIntegracaoGrupoCli.pas',
  U_WebIntegracaoGrupoPro in '..\unitsweb\integracao\U_WebIntegracaoGrupoPro.pas',
  U_WebIntegracaoIcmsUf in '..\unitsweb\integracao\U_WebIntegracaoIcmsUf.pas',
  U_WebIntegracaoCadCfop in '..\unitsweb\integracao\U_WebIntegracaoCadCfop.pas',
  U_WebIntegracaoCadOcorrencias in '..\unitsweb\integracao\U_WebIntegracaoCadOcorrencias.pas',
  U_WebIntegracaoTabPrecoVal in '..\unitsweb\integracao\U_WebIntegracaoTabPrecoVal.pas',
  U_WebIntegracaoReferencia in '..\unitsweb\integracao\U_WebIntegracaoReferencia.pas',
  U_WebIntegracaoRegiaoCli in '..\unitsweb\integracao\U_WebIntegracaoRegiaoCli.pas',
  U_WebIntegracaoSegmentoCli in '..\unitsweb\integracao\U_WebIntegracaoSegmentoCli.pas',
  U_WebIntegracaoTabPreco in '..\unitsweb\integracao\U_WebIntegracaoTabPreco.pas',
  U_WebIntegracaoCadTna in '..\unitsweb\integracao\U_WebIntegracaoCadTna.pas',
  U_WebIntegracaoTipoPag in '..\unitsweb\integracao\U_WebIntegracaoTipoPag.pas',
  U_WebIntegracaoTransportador in '..\unitsweb\integracao\U_WebIntegracaoTransportador.pas',
  U_SincWeb in 'U_SincWeb.pas',
  U_ConfigObjetos in 'U_ConfigObjetos.pas' {F_ConfigObjetos},
  U_OpenDirectory in '..\unitdatalan\U_OpenDirectory.pas' {F_OpenDirectory},
  U_SincImportacao in 'U_SincImportacao.pas' {F_SincImportacao},
  U_UteisWeb in 'U_UteisWeb.pas',
  CClifisica in '..\classes\CClifisica.pas',
  CCliJuridica in '..\classes\CCliJuridica.pas',
  CCadaCtn in '..\classes\CCadaCtn.pas',
  U_ListaObjetos in '..\unitdatalan\U_ListaObjetos.pas',
  U_FTPArquivos in '..\unitdatalan\U_FTPArquivos.pas',
  CWTPedido in '..\classes\CWTPedido.pas',
  CWTPedidoHist in '..\classes\CWTPedidoHist.pas',
  CWTPedidoItem in '..\classes\CWTPedidoItem.pas',
  CWTPedidoPag in '..\classes\CWTPedidoPag.pas',
  U_Pedidos1 in 'U_Pedidos1.pas' {F_Pedidos1},
  U_Pedidos in 'U_Pedidos.pas' {F_Pedidos},
  CTipopgto in '..\classes\CTipopgto.pas',
  U_RotinaFidelidade in '..\sepeecf\U_RotinaFidelidade.pas',
  CProdutos in '..\classes\CProdutos.pas',
  CTabelaprecos in '..\classes\CTabelaprecos.pas',
  CGrupopro in '..\classes\CGrupopro.pas',
  CMovaPto in '..\classes\CMovaPto.pas',
  CMovaRes in '..\classes\CMovaRes.pas',
  U_CliInadim in '..\sepeven\U_CliInadim.pas',
  CBancos in '..\classes\CBancos.pas',
  CAlmoxarifado in '..\classes\CAlmoxarifado.pas',
  CFormaPgnto in '..\classes\CFormaPgnto.pas',
  CTransportadoras in '..\classes\CTransportadoras.pas',
  CVendedores in '..\classes\CVendedores.pas',
  CPrecos in '..\classes\CPrecos.pas',
  CNaturezaOpr in '..\classes\CNaturezaOpr.pas',
  CCadIndex in '..\classes\CCadIndex.pas',
  CCadaTna in '..\classes\CCadaTna.pas',
  CProxCst in '..\classes\CProxCst.pas',
  CFabricantes in '..\classes\CFabricantes.pas',
  CFornecedor in '..\classes\CFornecedor.pas',
  U_ValoresTrib in '..\unitdatalan\U_ValoresTrib.pas',
  U_TribNCM in '..\regras\U_TribNCM.pas',
  U_ServicoPro in '..\sepeecf\U_ServicoPro.pas' {F_ServicoPro},
  U_ServicoPro1 in '..\sepeecf\U_ServicoPro1.pas' {F_ServicoPro1},
  CServExec in '..\classes\CServExec.pas',
  CTpoServ in '..\classes\CTpoServ.pas',
  CPlanoAtivaServ in '..\classes\CPlanoAtivaServ.pas',
  CSrvaCde in '..\classes\CSrvaCde.pas',
  CBenefServ in '..\classes\CBenefServ.pas',
  U_GeraChaveSrvaMov in '..\sepesrv\U_GeraChaveSrvaMov.pas',
  U_RotinasServico in '..\sepesrv\U_RotinasServico.pas',
  U_ValidarSerial in '..\sepesrv\U_ValidarSerial.pas',
  U_UteisServico in '..\sepesrv\U_UteisServico.pas',
  CMovSer in '..\classes\CMovSer.pas',
  DL2_VariaveisECF in '..\unitsecf\DL2_VariaveisECF.pas',
  U_Clientes1 in '..\sepecad\U_Clientes1.pas' {F_Clientes1},
  CRegioes in '..\classes\CRegioes.pas',
  CGrupoCliFor in '..\classes\CGrupoCliFor.pas',
  CContas in '..\classes\CContas.pas',
  CCNabaIns in '..\classes\CCNabaIns.pas',
  CConvenios in '..\classes\CConvenios.pas',
  CQualificacao in '..\classes\CQualificacao.pas',
  CCadaSeg in '..\classes\CCadaSeg.pas',
  CCadaFon in '..\classes\CCadaFon.pas',
  CInscricaoEstadual in '..\classes\CInscricaoEstadual.pas',
  U_ConsultaCEP in '..\unitcep\U_ConsultaCEP.pas' {F_ConsultaCEP},
  U_AcessoBaseCentral in '..\unitbasecentral\U_AcessoBaseCentral.pas',
  U_WebCam in '..\unitwbcam\U_WebCam.pas' {F_WebCam},
  U_LocalizarMapa in '..\unitdatalan\U_LocalizarMapa.pas' {F_LocalizarMapa},
  U_FuncACBrNFe in '..\sepenfeacbr\U_FuncACBrNFe.pas',
  U_Imagens in '..\unitdatalan\U_Imagens.pas' {F_Imagens},
  U_TCEP in '..\unitcep\U_TCEP.pas' {TCEP: TDataModule},
  U_Tr in '..\unitbasecentral\U_Tr.pas' {Tr: TDataModule},
  U_HistoricoFin in '..\sepecad\U_HistoricoFin.pas' {F_HistoricoFin},
  U_MsgBaseCentral in '..\unitbasecentral\U_MsgBaseCentral.pas' {F_MsgBaseCentral},
  VideoCap in '..\unitwbcam\VideoCap.pas',
  AviCap in '..\unitwbcam\AviCap.pas',
  VideoMci in '..\unitwbcam\VideoMci.pas',
  Vfw in '..\unitwbcam\Vfw.pas',
  U_HistoricoFat in '..\sepecad\U_HistoricoFat.pas' {F_HistoricoFat},
  U_ResumoSitCli in '..\sepecad\U_ResumoSitCli.pas' {F_ResumoSitCli},
  U_ComparaDadosCli in '..\sepecad\U_ComparaDadosCli.pas' {F_ComparaDadosCli},
  U_CNPJRFB in '..\sepecad\U_CNPJRFB.pas' {F_CNPJRFB},
  U_CPFRFB in '..\sepecad\U_CPFRFB.pas' {F_CPFRFB},
  U_HistoricoAss in '..\sepecad\U_HistoricoAss.pas' {F_HistoricoAss},
  CCadMon in '..\classes\CCadMon.pas',
  U_Captura in '..\unitdatalan\U_Captura.pas' {F_Captura},
  CDocaimg in '..\classes\CDocaimg.pas',
  U_DMI in '..\unitdatalan\U_DMI.pas' {DMI: TDataModule},
  U_CapturaDoc in '..\unitdatalan\U_CapturaDoc.pas' {F_CapturaDoc},
  U_CapturaArq in '..\unitdatalan\U_CapturaArq.pas' {F_CapturaArq},
  U_CriaListaCFOP in '..\unitdatalan\U_CriaListaCFOP.pas',
  U_CarregarTributacao in '..\unitdatalan\U_CarregarTributacao.pas',
  U_DescInvalido in '..\sepeven\U_DescInvalido.pas' {F_DescInvalido},
  U_SenhaDesconto in '..\sepeven\U_SenhaDesconto.pas' {F_SenhaDesconto},
  CAcessosUsu in '..\classes\CAcessosUsu.pas',
  CSepe in '..\classes\CSepe.pas',
  U_UteisOrc in '..\sepeorc\U_UteisOrc.pas',
  U_CarregarValoresTrib in '..\unitdatalan\U_CarregarValoresTrib.pas',
  U_Tributacao in '..\unitdatalan\U_Tributacao.pas',
  U_ConverteMoeda in '..\sepeven\U_ConverteMoeda.pas',
  CValIndex in '..\classes\CValIndex.pas',
  CErrosNfe in '..\classes\CErrosNfe.pas',
  U_Pedidos2Gerar in 'U_Pedidos2Gerar.pas' {F_Pedidos2Gerar},
  CPedidovenda in '..\classes\CPedidovenda.pas',
  CItensPedido in '..\classes\CItensPedido.pas',
  U_NroNF in '..\unitdatalan\U_NroNF.pas',
  U_ConfSer in '..\unitdatalan\U_ConfSer.pas' {F_ConfSer},
  CSerieNf in '..\classes\CSerieNf.pas',
  U_InfNum in '..\unitdatalan\U_InfNum.pas' {F_InfNum},
  U_Orcamento1 in '..\sepeven\U_Orcamento1.pas' {F_Orcamento1},
  CCCusto in '..\classes\CCCusto.pas',
  CDispLegais in '..\classes\CDispLegais.pas',
  CPgntopedidosvenda in '..\classes\CPgntopedidosvenda.pas',
  CNotasfiscais in '..\classes\CNotasfiscais.pas',
  CSaldoAlx in '..\classes\CSaldoAlx.pas',
  CItensNF in '..\classes\CItensNF.pas',
  CComisVendedor in '..\classes\CComisVendedor.pas',
  CMovprodestoque in '..\classes\CMovprodestoque.pas',
  CDuplicatas in '..\classes\CDuplicatas.pas',
  CNfent in '..\classes\CNfent.pas',
  U_Mecaf in '..\unitdatalan\U_Mecaf.pas',
  U_ImpNF in '..\unitdatalan\U_ImpNF.pas',
  CConfNotas in '..\classes\CConfNotas.pas',
  U_SisNFECF in '..\unitdatalan\U_SisNFECF.pas',
  U_SisImp in '..\unitdatalan\U_SisImp.pas',
  Imp10 in '..\unitdatalan\Imp10.pas',
  CFluxo in '..\classes\CFluxo.pas',
  CEcf in '..\classes\CEcf.pas',
  CItensnfent in '..\classes\CItensnfent.pas',
  CPagparcial in '..\classes\CPagparcial.pas',
  CECFLinhas in '..\classes\CECFLinhas.pas',
  U_EstFin in '..\unitdatalan\U_EstFin.pas',
  U_CMP in '..\unitdatalan\U_CMP.pas',
  U_NumeroMovEstoque in '..\sepeest\U_NumeroMovEstoque.pas',
  U_GarExt1 in '..\sepeecf\U_GarExt1.pas' {F_GarExt1},
  CParcgarExt in '..\classes\CParcgarExt.pas',
  U_DupAdiantado in '..\sepeven\U_DupAdiantado.pas' {F_DupAdiantado},
  U_GravaFluxo in '..\sepefin\U_GravaFluxo.pas',
  CReferencia in '..\classes\CReferencia.pas',
  CSeriaisInfo in '..\classes\CSeriaisInfo.pas',
  U_RotinasSeriais in '..\sepeser\U_RotinasSeriais.pas',
  U_MovSer in '..\sepeest\U_MovSer.pas' {F_MovSer},
  U_CargaTributaria in '..\unitdatalan\U_CargaTributaria.pas',
  U_ImpECF in '..\unitdatalan\U_ImpECF.pas',
  CReducaoZ in '..\classes\CReducaoZ.pas',
  U_GarExt in '..\sepeecf\U_GarExt.pas' {F_GarExt},
  CPlanos in '..\classes\CPlanos.pas',
  CGarantiasExt in '..\classes\CGarantiasExt.pas',
  U_ReciboCompra1 in '..\sepegex\U_ReciboCompra1.pas' {F_ReciboCompra1},
  U_ContadoresGarantia in '..\sepeecf\U_ContadoresGarantia.pas',
  U_RotinasGarantia in '..\sepegex\U_RotinasGarantia.pas',
  U_ReciboCompra in '..\sepegex\U_ReciboCompra.pas' {F_ReciboCompra},
  U_ReciboCompra2 in '..\sepegex\U_ReciboCompra2.pas' {F_ReciboCompra2},
  U_ImpTermoCancel in '..\sepegex\U_ImpTermoCancel.pas' {F_ImpTermoCancel},
  U_ImpTEF in '..\unitstef\U_ImpTEF.pas' {F_ImpTEF},
  CTef in '..\unitstef\CTef.pas',
  CTefDirecao in '..\unitstef\CTefDirecao.pas',
  U_DPOSDLL in '..\unitstef\U_DPOSDLL.pas',
  CTefDial in '..\unitstef\CTefDial.pas',
  CTefDialReq in '..\unitstef\CTefDialReq.pas',
  CTefDialResp in '..\unitstef\CTefDialResp.pas',
  U_MensagemTEF in '..\unitstef\U_MensagemTEF.pas' {F_MensagemTEF},
  U_CancTefDiscado in '..\sepeecf\U_CancTefDiscado.pas' {F_CancTefDiscado},
  U_AcessoImpFiscal in '..\unitsecf\U_AcessoImpFiscal.pas',
  CDL2Schalter in '..\unitsecf\CDL2Schalter.pas',
  AcessSchalterDll in '..\unitsecf\AcessSchalterDll.pas',
  CDL2Bematech in '..\unitsecf\CDL2Bematech.pas',
  AcessBematechDll in '..\unitsecf\AcessBematechDll.pas',
  U_MsgErroECF in '..\unitsecf\U_MsgErroECF.pas' {F_MsgErroECF},
  CDL2Mecaf in '..\unitsecf\CDL2Mecaf.pas',
  AcessMecafDll in '..\unitsecf\AcessMecafDll.pas',
  CDL2ZPM in '..\unitsecf\CDL2ZPM.pas',
  AcessZPMDll in '..\unitsecf\AcessZPMDll.pas',
  CDL2SWEDA in '..\unitsecf\CDL2SWEDA.pas',
  AcessSWEDADll in '..\unitsecf\AcessSWEDADll.pas',
  U_UteisEcfACBr in '..\unitsecf\U_UteisEcfACBr.pas',
  CDevolucao in '..\classes\CDevolucao.pas',
  U_AcessoDllsCheque in '..\unitdatalan\U_AcessoDllsCheque.pas',
  U_PagamentoTEF in '..\sepeecf\U_PagamentoTEF.pas' {F_PagamentoTEF},
  U_ConsultaChqTEF in '..\sepeecf\U_ConsultaChqTEF.pas' {F_ConsultaChqTEF},
  U_TrataPendentes in '..\unitstef\U_TrataPendentes.pas',
  U_PesqNFS_ECF in '..\sepeecf\U_PesqNFS_ECF.pas',
  U_GeraArqNfs in '..\sepeven\U_GeraArqNfs.pas',
  U_ArqNFTransferencia in '..\sepenfeacbr\U_ArqNFTransferencia.pas',
  U_FormatarSerie in '..\sepeven\U_FormatarSerie.pas',
  CVenaIps in '..\classes\CVenaIps.pas',
  CScraNfls in '..\classes\CScraNfls.pas',
  CProaalx in '..\classes\CProaalx.pas',
  CVenaDes in '..\classes\CVenaDes.pas',
  CTpgxPgn in '..\classes\CTpgxPgn.pas',
  CVenaRps in '..\classes\CVenaRps.pas',
  U_ValidarVendedor in '..\sepeecf\U_ValidarVendedor.pas',
  U_F4Cliente in '..\unitdatalan\U_F4Cliente.pas',
  U_F4Produto in '..\unitdatalan\U_F4Produto.pas',
  U_F4Transportador in '..\unitdatalan\U_F4Transportador.pas',
  U_F4Fornecedor in '..\unitdatalan\U_F4Fornecedor.pas',
  U_DataHoraNF in '..\sepeven\U_DataHoraNF.pas' {F_DataHoraNF},
  U_PartePedido in '..\sepeven\U_PartePedido.pas',
  U_ICMSDevolucao in '..\sepeven\U_ICMSDevolucao.pas' {F_ICMSDevolucao},
  U_IntervaloNFs in '..\unitdatalan\U_IntervaloNFs.pas' {F_IntervaloNFs},
  U_LocEmbarque in '..\sepeven\U_LocEmbarque.pas' {F_LocEmbarque},
  U_ImpGarFabricante in '..\sepeven\U_ImpGarFabricante.pas' {F_ImpGarFabricante},
  U_ImpGarFabricante1 in '..\sepeven\U_ImpGarFabricante1.pas' {F_ImpGarFabricante1},
  CMovProdutos3 in '..\classes\CMovProdutos3.pas',
  CSaldoPro3 in '..\classes\CSaldoPro3.pas',
  U_VenctoFora in '..\unitdatalan\U_VenctoFora.pas',
  U_LibPedido in '..\sepeven\U_LibPedido.pas' {F_LibPedido},
  U_Reserva in '..\unitdatalan\U_Reserva.pas',
  U_PedidoGeral in '..\sepeven\U_PedidoGeral.pas',
  U_ImpPed in '..\unitdatalan\U_ImpPed.pas',
  CConfPedido in '..\classes\CConfPedido.pas',
  U_UteisImpNaoFiscal in '..\sepeecf\U_UteisImpNaoFiscal.pas',
  CGravaIniNaoFiscal in '..\classes\CGravaIniNaoFiscal.pas',
  U_DadosCli in '..\sepefin\U_DadosCli.pas' {F_DadosCli},
  U_DevNfe in '..\sepeven\U_DevNfe.pas' {F_DevNfe},
  U_CadCliIncompleto in '..\sepeven\U_CadCliIncompleto.pas',
  U_EmailDiverg in '..\sepeven\U_EmailDiverg.pas' {F_EmailDiverg},
  U_ValidaProNfe in '..\unitnfe\pl_006\U_ValidaProNfe.pas',
  U_ValidaForNFe in '..\unitnfe\pl_006\U_ValidaForNFe.pas',
  U_ValidaLinhaNFe in '..\unitnfe\pl_006\U_ValidaLinhaNFe.pas',
  U_ValidaTrsNfe in '..\unitnfe\pl_006\U_ValidaTrsNfe.pas',
  U_CadSerieNFe in '..\sepenfeacbr\U_CadSerieNFe.pas',
  U_ConversaoQuantidade in '..\sepeven\U_ConversaoQuantidade.pas',
  U_SituacaoCaixa in '..\unitdatalan\U_SituacaoCaixa.pas',
  U_JustificaPed in '..\sepeven\U_JustificaPed.pas' {F_JustificaPed},
  CVenaOcr in '..\classes\CVenaOcr.pas',
  U_ProcessaNfe in '..\sepenfeacbr\U_ProcessaNfe.pas',
  U_GeraXmlNfe in '..\sepenfeacbr\U_GeraXmlNfe.pas',
  U_GeralNfe in '..\unitnfe\pl_006\U_GeralNfe.pas',
  U_WebBrowseNFe in '..\sepenfeacbr\U_WebBrowseNFe.pas' {F_WebBrowseNFe},
  U_IconesNfe in '..\sepenfeacbr\U_IconesNfe.pas' {F_IconesNfe},
  CLoteNfe in '..\classes\CLoteNfe.pas',
  CNotasresumidonfe in '..\classes\CNotasresumidonfe.pas',
  U_VarNFe in '..\sepenfeacbr\U_VarNFe.pas',
  U_DadosAdicionais in '..\sepenfeacbr\U_DadosAdicionais.pas',
  CPaises in '..\classes\CPaises.pas',
  CNfecont in '..\classes\CNfecont.pas',
  U_TestaValidadeCertificado in '..\sepenfeacbr\U_TestaValidadeCertificado.pas',
  CNfceinf in '..\classes\CNfceinf.pas',
  CCtraCab in '..\classes\CCtraCab.pas',
  U_CteGeral in '..\sepecteacbr\U_CteGeral.pas',
  U_RotinasCancelamento in '..\sepenfeacbr\U_RotinasCancelamento.pas',
  U_NfeSaida2 in '..\sepenfeacbr\U_NfeSaida2.pas' {F_NfeSaida2},
  U_GravaProcNfe in '..\sepenfeacbr\U_GravaProcNfe.pas',
  U_NfeSaida4 in '..\sepenfeacbr\U_NfeSaida4.pas' {F_NfeSaida4},
  U_LerConfEmail in '..\unitdatalan\U_LerConfEmail.pas',
  U_EmailNFe in '..\sepenfeacbr\U_EmailNFe.pas',
  U_EnviarEmail in '..\unitdatalan\U_EnviarEmail.pas',
  U_EnviarEmailAnexos in '..\unitdatalan\U_EnviarEmailAnexos.pas',
  U_Danfe in '..\sepenfeacbr\U_Danfe.pas' {F_Danfe},
  U_DanfeNew in '..\sepenfeacbr\U_DanfeNew.pas' {F_DanfeNew},
  U_ImpBolAposNota in '..\sepenfeacbr\U_ImpBolAposNota.pas',
  U_BloquetoLaser in '..\unitdatalan\U_BloquetoLaser.pas',
  U_AjustaCFOP in '..\unitdatalan\U_AjustaCFOP.pas',
  U_HistoricoPedido in 'U_HistoricoPedido.pas',
  CVenaPdh in '..\classes\CVenaPdh.pas',
  CWebObjeto in '..\unitdatalan\CWebObjeto.pas',
  CClientesFull in '..\classesfull\CClientesFull.pas',
  CClientes in '..\classes\CClientes.pas',
  U_ValidaCliNFe in '..\unitnfe\U_ValidaCliNFe.pas',
  U_CadEmp in '..\unitdatalan\U_CadEmp.pas',
  U_WebFeriado in '..\unitsweb\integracao\U_WebFeriado.pas',
  U_WebIntegracaoFeriado in '..\unitsweb\integracao\U_WebIntegracaoFeriado.pas',
  U_WebIntegracaoSaldoTmp in '..\unitsweb\integracao\U_WebIntegracaoSaldoTmp.pas',
  U_WebSaldoTmp in '..\unitsweb\integracao\U_WebSaldoTmp.pas',
  CParametros in '..\unitdatalan\CParametros.pas',
  CWTPedidoFull in '..\classesfull\CWTPedidoFull.pas',
  U_WebIntegracaoPedidoHist in '..\unitsweb\integracao\U_WebIntegracaoPedidoHist.pas',
  wsIntegracao in '..\SepeEsepeSinc\ws\wsIntegracao.pas',
  U_ParametrosBD in '..\SepeEsepeSinc\U_ParametrosBD.pas' {F_ParametrosBD},
  U_FechamentoECF in '..\SepeEcf\U_FechamentoECF.pas' {F_FechamentoECF},
  U_ConfFecha in '..\SepeEcf\U_ConfFecha.pas',
  U_CustoMedio in '..\SepeEst\U_CustoMedio.pas' {F_CustoMedio},
  U_RotinasEspCustoMedio in '..\SepeEst\U_RotinasEspCustoMedio.pas',
  U_CustoEstrutura in '..\SepeEst\U_CustoEstrutura.pas',
  U_RelFatPorPortador1 in '..\SepeEcf\U_RelFatPorPortador1.pas' {F_RelFatPorPortador1},
  U_RelProtocolo1 in '..\SepeEcf\U_RelProtocolo1.pas' {F_RelProtocolo1},
  U_RelDiarioAux1 in '..\SepeGex\U_RelDiarioAux1.pas' {F_RelDiarioAux1},
  U_RelFecha1 in '..\SepeEcf\U_RelFecha1.pas' {F_RelFecha1},
  U_RelNFFecha in '..\SepeEcf\U_RelNFFecha.pas' {F_RelNFFecha},
  U_RotinasFechamentoServico in '..\SepeEcf\U_RotinasFechamentoServico.pas',
  U_FatPortadorEsp in '..\SepeEcf\U_FatPortadorEsp.pas',
  U_FechamentoCaixa in '..\SepeEcf\U_FechamentoCaixa.pas' {F_FechamentoCaixa},
  U_IPIDevolucao in '..\SepeVen\U_IPIDevolucao.pas' {F_IPIDevolucao},
  U_DadosObra in '..\SepeVen\U_DadosObra.pas' {F_DadosObra},
  U_LiberacaoPedido in '..\SepeVen\U_LiberacaoPedido.pas',
  U_OcrPedLiberacao in '..\SepeVen\U_OcrPedLiberacao.pas',
  U_IconesNFSe in '..\sepeNfse\U_IconesNFSe.pas' {F_IconesNfSe},
  U_NFSe in '..\sepeNfse\U_NFSe.pas',
  U_NfSeGeral in '..\sepeNfse\U_NfSeGeral.pas',
  U_NFSeEmail in '..\sepeNfse\U_NFSeEmail.pas',
  U_NFSeConsulta in '..\sepeNfse\U_NFSeConsulta.pas',
  U_NFSeInutilizacao in '..\sepeNfse\U_NFSeInutilizacao.pas',
  U_HistoricoPed in '..\SepeVen\U_HistoricoPed.pas' {F_HistoricoPed},
  U_FuncImpDanfe in '..\SepeCaixa\U_FuncImpDanfe.pas',
  U_Constantes in '..\SepeLoja\U_Constantes.pas',
  U_NFSeControl in '..\sepeNfse\U_NFSeControl.pas',
  U_NfseCaxias in '..\sepeNfse\U_NfseCaxias.pas',
  U_WebServiceCaxias in '..\sepeNfse\U_WebServiceCaxias.pas',
  U_NFSeRetornoLote in '..\sepeNfse\U_NFSeRetornoLote.pas' {F_NFSeRetornoLote},
  U_CarregarOrc in '..\SepeVen\U_CarregarOrc.pas',
  U_CarregarOrcCabecalho in '..\SepeVen\U_CarregarOrcCabecalho.pas',
  U_CarregarOrcItens in '..\SepeVen\U_CarregarOrcItens.pas',
  U_SelMultiplosPro in '..\SepeVen\U_SelMultiplosPro.pas' {F_SelMultiplosPro},
  U_InfoProCli in '..\SepeVen\U_InfoProCli.pas',
  U_Sistema in '..\unitdatalan\U_Sistema.pas' {F_Sistema},
  U_MensagemTimer in '..\unitdatalan\U_MensagemTimer.pas' {F_MensagemTimer},
  U_MostraGoogleMap in '..\unitdatalan\U_MostraGoogleMap.pas',
  AcessBematechDll_XE5 in '..\unitsecf\AcessBematechDll_XE5.pas',
  U_VerificaDesconto in '..\unitdatalan\U_VerificaDesconto.pas',
  CRetDesconto in '..\unitdatalan\CRetDesconto.pas',
  U_IcmsUF in '..\uniticmsuf\U_IcmsUF.pas',
  StConstantes in '..\unitdatalan\StConstantes.pas',
  U_BloqueiaNovoRegDBGrid in '..\unitdatalan\U_BloqueiaNovoRegDBGrid.pas',
  U_RelPedidosWeb in 'U_RelPedidosWeb.pas' {F_RelPedidosWeb},
  U_Obras1 in '..\SepeCad\U_Obras1.pas' {F_Obras1},
  CCsv in '..\unitdatalan\CCsv.pas',
  U_GravaUsuario in '..\unitdatalan\U_GravaUsuario.pas' {F_GravaUsuario},
  CDuplicatasent in '..\classes\CDuplicatasent.pas',
  CSerieNFFull in '..\classesfull\CSerieNFFull.pas',
  CProdutosFull in '..\classesfull\CProdutosFull.pas',
  CFormapgntoFull in '..\classesfull\CFormapgntoFull.pas',
  CTicmufp in '..\classes\CTicmufp.pas',
  CTicmUfn in '..\classes\CTicmUfn.pas',
  CCadObra in '..\classes\CCadObra.pas',
  CNotasFiscaisFull in '..\classesfull\CNotasFiscaisFull.pas',
  CItensNFFull in '..\classesfull\CItensNFFull.pas',
  CDuplicatasFull in '..\classesfull\CDuplicatasFull.pas',
  CLoteNFeFull in '..\classesfull\CLoteNFeFull.pas',
  CEnvemail in '..\classes\CEnvemail.pas',
  CNroInutil in '..\classes\CNroInutil.pas',
  CImagemCupons in '..\classes\CImagemCupons.pas',
  CAbrFec in '..\classes\CAbrFec.pas',
  CExibeMargem in '..\SepeLoja\CExibeMargem.pas',
  U_ExibeMargem in '..\SepeLoja\U_ExibeMargem.pas' {F_ExibeMargem},
  U_ComandosSMS in '..\wSepeSMS\U_ComandosSMS.pas',
  U_ccontas in '..\wSepeSMS\U_ccontas.pas',
  ServiceSmsLong in '..\wSepeSMS\ServiceSmsLong.pas',
  ServiceSmsShort in '..\wSepeSMS\ServiceSmsShort.pas',
  CParametrosBDIni in '..\SepeDmdSincTrigger\CParametrosBDIni.pas',
  U_SolicitaInfo in '..\SepeCad\U_SolicitaInfo.pas' {F_SolicitaInfo},
  U_RotinasPlanos in '..\SepeVen\U_RotinasPlanos.pas',
  U_MovTerceiros in '..\SepeEst\U_MovTerceiros.pas',
  U_ImpResFechamentoCaixa in '..\SepeLoja\U_ImpResFechamentoCaixa.pas',
  U_AberturaCaixa in '..\SepeEcf\U_AberturaCaixa.pas' {F_AberturaCaixa},
  U_Dup in '..\SepeFin\U_Dup.pas',
  U_DuplicatasR3 in '..\SepeFin\U_DuplicatasR3.pas' {F_DuplicatasR3},
  U_DuplicatasRChq1 in '..\SepeFin\U_DuplicatasRChq1.pas' {F_DuplicatasRChq1},
  U_DuplicatasRChq in '..\SepeFin\U_DuplicatasRChq.pas' {F_DuplicatasRChq},
  U_Consignacao in '..\unitdatalan\U_Consignacao.pas',
  U_ConfACBrNFSe in '..\sepeNfse\U_ConfACBrNFSe.pas',
  U_PastasNFSe in '..\sepeNfse\U_PastasNFSe.pas',
  CPedidoControl in '..\unitpedido\CPedidoControl.pas',
  CPedidoFinEst in '..\unitpedido\CPedidoFinEst.pas' {$R *.res},
  CPedidoPt in '..\unitpedido\CPedidoPt.pas' {$R *.res},
  CPedidoItemPt in '..\unitpedido\CPedidoItemPt.pas' {$R *.res},
  CPedidoItemCabPt in '..\unitpedido\CPedidoItemCabPt.pas',
  CPedidoItemTribPt in '..\unitpedido\CPedidoItemTribPt.pas' {$R *.res},
  CPedidoItemTotPt in '..\unitpedido\CPedidoItemTotPt.pas' {$R *.res},
  CPedidoParcPt in '..\unitpedido\CPedidoParcPt.pas' {$R *.res},
  CPedidoCabPt in '..\unitpedido\CPedidoCabPt.pas' {$R *.res},
  CPedidoTotPt in '..\unitpedido\CPedidoTotPt.pas' {$R *.res},
  CPedidoTranspPt in '..\unitpedido\CPedidoTranspPt.pas' {$R *.res},
  U_AjusteParcelas in '..\SepeVen\U_AjusteParcelas.pas' {$R *.res},
  U_CalcRateios in '..\SepeVen\U_CalcRateios.pas' {$R *.res},
  CConsignacao in '..\unitnotafiscal\CConsignacao.pas';

{$R *.res}

var
  MutexHandle:THandle;
  Modulo :String;
begin

   {Verifica se j? possui outra inst?ncia do programa rodando}
    MutexHandle:=CreateMutex(nil,True,'WSepeEsepe');
    if (MutexHandle<>0) then
    begin
      if (GetLastError=ERROR_ALREADY_EXISTS) then  // se j? est? rodando fecha o executavel
      begin
        Modulo := ModulosSimultaneos('Pedidos Esepe');
        if Modulo = 'N' then
        begin
          ShowMessageTimer('O m?dulo j? est? aberto.','Pedidos Esepe',3000);
          //MessageDlg('O m?dulo de WSepeLoja j? est? aberto.', mtWarning, [mbOK], 0);
          CloseHandle(MutexHandle);
          Exit;
        end;
      end;
    end;

  Application.Initialize;
  Application.Title := 'Pedidos Esepe';
  Application.CreateForm(TT2, T2);
  Application.CreateForm(TF_WsepeEsepe, F_WsepeEsepe);
  Application.Run;
end.
