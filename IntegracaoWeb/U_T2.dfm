object T2: TT2
  OldCreateOrder = False
  Height = 711
  Width = 950
  object qEmpresa: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    Left = 96
    Top = 8
  end
  object qgSepeCfg: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      '')
    Left = 21
    Top = 71
  end
  object dspgSepeCfg: TDataSetProvider
    DataSet = qgSepeCfg
    Left = 29
    Top = 87
  end
  object cdsgSepeCfg: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspgSepeCfg'
    Left = 37
    Top = 103
    object cdsgSepeCfgOPCAO: TStringField
      FieldName = 'OPCAO'
      Required = True
      Size = 10
    end
    object cdsgSepeCfgDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 60
    end
    object cdsgSepeCfgSIT: TStringField
      FieldName = 'SIT'
      Size = 132
    end
    object cdsgSepeCfgUSRATU: TStringField
      FieldName = 'USRATU'
      Size = 10
    end
    object cdsgSepeCfgDATATU: TSQLTimeStampField
      FieldName = 'DATATU'
    end
  end
  object dsgSepeCfg: TDataSource
    DataSet = cdsgSepeCfg
    Left = 45
    Top = 119
  end
  object qR145: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    Left = 192
    Top = 8
  end
  object qR2: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    Left = 192
    Top = 80
  end
  object qaSepeRel: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    Left = 440
    Top = 24
  end
  object qaSepeCfg: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    Left = 248
    Top = 8
  end
  object Temp: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 152
    Top = 8
  end
  object dspqR1: TDataSetProvider
    DataSet = qR1
    Left = 125
    Top = 87
  end
  object cdsqR1: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspqR1'
    Left = 133
    Top = 103
  end
  object dsqR1: TDataSource
    DataSet = cdsqR1
    Left = 141
    Top = 119
  end
  object qR1: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    Left = 117
    Top = 80
  end
  object WSepeDBX: TSQLConnection
    ConnectionName = 'FBConnection'
    DriverName = 'Firebird'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=Firebird'
      'Database=database.fdb'
      'RoleName=RoleName'
      'User_Name=sysdba'
      'Password=masterkey'
      'ServerCharSet='
      'SQLDialect=3'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'BlobSize=-1'
      'CommitRetain=False'
      'WaitOnLocks=True'
      'IsolationLevel=ReadCommitted'
      'Trim Char=False')
    Left = 24
    Top = 8
  end
  object qaSepePar: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    Left = 440
    Top = 72
  end
  object qR3: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    Left = 208
    Top = 144
  end
  object cdsCadEmp: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 416
    Top = 152
  end
  object qSepe: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = WSepeDBX
    Left = 40
    Top = 184
  end
  object dspSepe: TDataSetProvider
    DataSet = qSepe
    Left = 40
    Top = 200
  end
  object cdsSepe: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspSepe'
    Left = 40
    Top = 216
  end
  object qSepeAces: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = WSepeDBX
    Left = 104
    Top = 184
  end
  object dspSepeAces: TDataSetProvider
    DataSet = qSepeAces
    Left = 104
    Top = 200
  end
  object cdsSepeAces: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspSepeAces'
    Left = 104
    Top = 216
  end
  object qC1: TSQLQuery
    Params = <>
    Left = 344
    Top = 60
  end
  object dspC1: TDataSetProvider
    DataSet = qC1
    Left = 344
    Top = 76
  end
  object cdsC1: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspC1'
    Left = 344
    Top = 92
  end
  object dsC1: TDataSource
    DataSet = cdsC1
    Left = 344
    Top = 108
  end
  object qWeb: TSQLQuery
    Params = <>
    Left = 264
    Top = 68
  end
  object dspWeb: TDataSetProvider
    DataSet = qWeb
    Left = 264
    Top = 84
  end
  object cdsWeb: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspWeb'
    Left = 264
    Top = 100
  end
  object dsWeb: TDataSource
    DataSet = cdsWeb
    Left = 264
    Top = 116
  end
  object qTemp: TSQLQuery
    Params = <>
    Left = 304
    Top = 12
  end
  object qgWtpedido: TSQLQuery
    Params = <>
    Left = 240
    Top = 188
  end
  object dspgWtpedido: TDataSetProvider
    DataSet = qgWtpedido
    Left = 240
    Top = 204
  end
  object cdsgWtpedido: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspgWtpedido'
    Left = 240
    Top = 220
  end
  object dsgWtpedido: TDataSource
    DataSet = cdsgWtpedido
    Left = 240
    Top = 236
  end
  object cdsSelecaoTrib: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 404
    Top = 208
  end
  object cdsqC1: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspC1'
    Left = 384
    Top = 76
  end
  object dspqC1: TDataSetProvider
    DataSet = qC1
    Left = 384
    Top = 60
  end
  object qC2: TSQLQuery
    Params = <>
    Left = 502
    Top = 12
  end
  object dspC2: TDataSetProvider
    DataSet = qC2
    Left = 502
    Top = 28
  end
  object cdsC2: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspC2'
    Left = 502
    Top = 44
  end
  object dsC2: TDataSource
    DataSet = cdsC2
    Left = 502
    Top = 60
  end
  object dspqC2: TDataSetProvider
    DataSet = qC2
    Left = 544
    Top = 20
  end
  object cdsqC2: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspqC2'
    Left = 544
    Top = 36
  end
  object cdsTemp: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 176
    Top = 208
  end
  object dsTemp: TDataSource
    DataSet = cdsTemp
    Left = 176
    Top = 232
  end
  object dsTempSrvaMov: TDataSource
    DataSet = cdsTempSrvaMov
    Left = 320
    Top = 192
  end
  object cdsTempSrvaMov: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 320
    Top = 168
  end
  object qC3: TSQLQuery
    Params = <>
    Left = 501
    Top = 124
  end
  object dspC3: TDataSetProvider
    DataSet = qC3
    Left = 501
    Top = 140
  end
  object cdsC3: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspC3'
    Left = 501
    Top = 156
  end
  object dsC3: TDataSource
    DataSet = cdsC3
    Left = 501
    Top = 172
  end
  object dspqC3: TDataSetProvider
    DataSet = qC3
    Left = 533
    Top = 140
  end
  object cdsqC3: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspqC3'
    Left = 533
    Top = 156
  end
  object qC4: TSQLQuery
    Params = <>
    Left = 509
    Top = 228
  end
  object dspC4: TDataSetProvider
    DataSet = qC4
    Left = 509
    Top = 244
  end
  object cdsC4: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspC4'
    Left = 509
    Top = 260
  end
  object dsC4: TDataSource
    DataSet = cdsC4
    Left = 509
    Top = 276
  end
  object dspqC4: TDataSetProvider
    DataSet = qC4
    Left = 541
    Top = 244
  end
  object cdsqC4: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspqC4'
    Left = 541
    Top = 260
  end
  object qSepeCfg: TSQLQuery
    Params = <>
    Left = 24
    Top = 282
  end
  object ACBrECF1: TACBrECF
    QuebraLinhaRodape = False
    Porta = 'procurar'
    ReTentar = False
    DescricaoGrande = True
    MsgAguarde = 'Aguardando a resposta da Impressora: %d segundos'
    MsgTrabalhando = 'Impressora est'#225' trabalhando'
    MsgRelatorio = 'Imprimindo %s  %d'#170' Via '
    MsgPausaRelatorio = 'Destaque a %d'#170' via, <ENTER> proxima, %d seg.'
    PaginaDeCodigo = 0
    DecimaisPreco = 2
    MemoParams.Strings = (
      '[Cabecalho]'
      'LIN000=<center><b>Nome da Empresa</b></center>'
      'LIN001=<center>Nome da Rua , 1234  -  Bairro</center>'
      'LIN002=<center>Cidade  -  UF  -  99999-999</center>'
      
        'LIN003=<center>CNPJ: 01.234.567/0001-22    IE: 012.345.678.90</c' +
        'enter>'
      
        'LIN004=<table width=100%><tr><td align=left><code>Data</code> <c' +
        'ode>Hora</code></td><td align=right>COO: <b><code>NumCupom</code' +
        '></b></td></tr></table>'
      'LIN005=<hr>'
      ''
      '[Cabecalho_Item]'
      'LIN000=ITEM   CODIGO     DESCRICAO'
      'LIN001=QTD         x UNITARIO       Aliq     VALOR (R$)'
      'LIN002=<hr>'
      
        'MascaraItem=III CCCCCCCCCCCCC DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDQQQQ' +
        'QQQQ UU x VVVVVVVVVVVVV AAAAAA TTTTTTTTTTTTT'
      ''
      '[Rodape]'
      'LIN000=<hr>'
      
        'LIN001=<table width=100%><tr><td align=left><code>Data</code> <c' +
        'ode>Hora</code></td><td align=right>Projeto ACBr: <b><code>ACBR<' +
        '/code></b></td></tr></table>'
      'LIN002=<center>Obrigado Volte Sempre</center>'
      'LIN003=<hr>'
      ''
      '[Formato]'
      'Colunas=48'
      'HTML=1'
      'HTML_Title_Size=4'
      'HTML_Font=<font size="5" face="Lucida Console">')
    ArqLOG = 'acbrlog.txt'
    ConfigBarras.MostrarCodigo = True
    ConfigBarras.LarguraLinha = 3
    ConfigBarras.Altura = 10
    ConfigBarras.Margem = 0
    InfoRodapeCupom.Imposto.ModoCompacto = False
    Left = 342
    Top = 265
  end
  object ACBrNFe1: TACBrNFe
    Configuracoes.Geral.SSLLib = libCapicom
    Configuracoes.Geral.SSLCryptLib = cryCapicom
    Configuracoes.Geral.SSLHttpLib = httpWinINet
    Configuracoes.Geral.SSLXmlSignLib = xsMsXmlCapicom
    Configuracoes.Geral.FormatoAlerta = 'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.'
    Configuracoes.Geral.ValidarDigest = False
    Configuracoes.Geral.VersaoDF = ve200
    Configuracoes.Geral.VersaoQRCode = veqr000
    Configuracoes.Arquivos.OrdenacaoPath = <>
    Configuracoes.WebServices.UF = 'SP'
    Configuracoes.WebServices.AguardarConsultaRet = 0
    Configuracoes.WebServices.QuebradeLinha = '|'
    Configuracoes.RespTec.IdCSRT = 0
    DANFE = ACBrNFeDANFEFR1
    Left = 398
    Top = 266
  end
  object qgScraCli: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    Left = 105
    Top = 276
  end
  object dspgScraCli: TDataSetProvider
    DataSet = qgScraCli
    Left = 105
    Top = 292
  end
  object cdsgScraCli: TClientDataSet
    Aggregates = <>
    PacketRecords = 1000
    Params = <>
    ProviderName = 'dspgScraCli'
    Left = 105
    Top = 308
  end
  object dsgScraCli: TDataSource
    DataSet = cdsgScraCli
    Left = 105
    Top = 324
  end
  object qSepeRel: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    Left = 216
    Top = 322
  end
  object qSepeDic: TSQLQuery
    Params = <>
    Left = 168
    Top = 290
  end
  object cdsTempGexPar: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 288
    Top = 307
  end
  object dsTempGexPar: TDataSource
    DataSet = cdsTempGexPar
    Left = 288
    Top = 324
  end
  object cdsTempGexExt: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 376
    Top = 314
  end
  object dsTempGexExt: TDataSource
    DataSet = cdsTempGexExt
    Left = 376
    Top = 330
  end
  object qSeraInf: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    Left = 456
    Top = 266
  end
  object dspSeraInf: TDataSetProvider
    DataSet = qSeraInf
    Left = 456
    Top = 298
  end
  object cdsSeraInf: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspSeraInf'
    Left = 456
    Top = 282
  end
  object dsSeraInf: TDataSource
    DataSet = cdsSeraInf
    Left = 456
    Top = 322
  end
  object qRel: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    Left = 592
    Top = 20
  end
  object dspqRel: TDataSetProvider
    DataSet = qRel
    Left = 592
    Top = 36
  end
  object cdsqRel: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspqRel'
    Left = 592
    Top = 52
  end
  object dsqRel: TDataSource
    DataSet = cdsqRel
    Left = 592
    Top = 68
  end
  object cdsECF_Formas: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 544
    Top = 330
    object cdsECF_FormasIndex: TStringField
      FieldName = 'Index'
      Size = 2
    end
    object cdsECF_FormasDescricao: TStringField
      FieldName = 'Descricao'
      Size = 35
    end
    object cdsECF_FormasVinculo: TStringField
      FieldName = 'Vinculo'
      Size = 1
    end
  end
  object qgScraEcf: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    Left = 610
    Top = 244
  end
  object dspgScraEcf: TDataSetProvider
    DataSet = qgScraEcf
    Left = 610
    Top = 260
  end
  object cdsgScraEcf: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspgScraEcf'
    Left = 610
    Top = 276
  end
  object dsgScraEcf: TDataSource
    DataSet = cdsgScraEcf
    Left = 610
    Top = 292
  end
  object qgScraEcfl: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = WSepeDBX
    Left = 592
    Top = 120
  end
  object dspgScraEcfl: TDataSetProvider
    DataSet = qgScraEcfl
    Left = 592
    Top = 140
  end
  object cdsgScraEcfl: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspgScraEcf'
    Left = 592
    Top = 160
  end
  object dsgScraEcfl: TDataSource
    DataSet = cdsgScraEcfl
    Left = 592
    Top = 180
  end
  object qgScraDup: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = WSepeDBX
    Left = 648
    Top = 16
  end
  object dspgScraDup: TDataSetProvider
    DataSet = qgScraDup
    Left = 648
    Top = 40
  end
  object cdsgScraDup: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspgScraDup'
    Left = 648
    Top = 64
  end
  object dsgScraDup: TDataSource
    DataSet = cdsgScraDup
    Left = 648
    Top = 88
  end
  object qgFluxo: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = WSepeDBX
    Left = 656
    Top = 136
  end
  object dspgFluxo: TDataSetProvider
    DataSet = qgFluxo
    Left = 656
    Top = 152
  end
  object cdsgFluxo: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspgFluxo'
    Left = 656
    Top = 176
    object cdsgFluxoDOCUMENTO: TStringField
      FieldName = 'DOCUMENTO'
    end
    object cdsgFluxoCONTA: TStringField
      FieldName = 'CONTA'
      Size = 11
    end
    object cdsgFluxoCCUSTO: TStringField
      FieldName = 'CCUSTO'
      Size = 4
    end
    object cdsgFluxoHISTORICO: TStringField
      FieldName = 'HISTORICO'
      Size = 120
    end
    object cdsgFluxoVALOR: TFMTBCDField
      FieldName = 'VALOR'
      Precision = 15
      Size = 2
    end
    object cdsgFluxoVALOR_US: TFMTBCDField
      FieldName = 'VALOR_US'
      Precision = 15
      Size = 2
    end
    object cdsgFluxoTIPO_MOV: TStringField
      FieldName = 'TIPO_MOV'
      Size = 1
    end
    object cdsgFluxoEXEC_TRAN: TStringField
      FieldName = 'EXEC_TRAN'
      Size = 1
    end
    object cdsgFluxoDOLAR: TFMTBCDField
      FieldName = 'DOLAR'
      Precision = 15
      Size = 2
    end
    object cdsgFluxoBANCO: TStringField
      FieldName = 'BANCO'
      Size = 3
    end
    object cdsgFluxoUSRATU: TStringField
      FieldName = 'USRATU'
      Size = 10
    end
    object cdsgFluxoNRLANC: TFloatField
      FieldName = 'NRLANC'
    end
    object cdsgFluxoDATA: TDateField
      FieldName = 'DATA'
    end
    object cdsgFluxoDTCONTAB: TDateField
      FieldName = 'DTCONTAB'
    end
    object cdsgFluxoDATATU: TDateField
      FieldName = 'DATATU'
    end
  end
  object dsgFluxo: TDataSource
    DataSet = cdsgFluxo
    Left = 656
    Top = 200
  end
  object qgVenaIpd: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = WSepeDBX
    Left = 672
    Top = 264
  end
  object dspgVenaIpd: TDataSetProvider
    DataSet = qgVenaIpd
    Left = 672
    Top = 288
  end
  object cdsgVenaIpd: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspgVenaIpd'
    Left = 672
    Top = 312
  end
  object dsgVenaIpd: TDataSource
    DataSet = cdsgVenaIpd
    Left = 672
    Top = 336
  end
  object SQLQuery1: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = WSepeDBX
    Left = 24
    Top = 336
  end
  object dspR1: TDataSetProvider
    DataSet = SQLQuery1
    Left = 24
    Top = 356
  end
  object cdsR1: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspR1'
    Left = 24
    Top = 372
  end
  object dsR1: TDataSource
    DataSet = cdsR1
    Left = 24
    Top = 388
  end
  object qItensDvNFE: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      '')
    Left = 162
    Top = 352
  end
  object dspItensDvNFE: TDataSetProvider
    DataSet = qItensDvNFE
    Left = 162
    Top = 372
  end
  object cdsItensDvNFE: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspItensDvNFE'
    Left = 162
    Top = 388
  end
  object dsItensDvNFE: TDataSource
    DataSet = cdsItensDvNFE
    Left = 162
    Top = 409
  end
  object qgVenaPed: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = WSepeDBX
    Left = 240
    Top = 377
  end
  object dspgVenaPed: TDataSetProvider
    DataSet = qgVenaPed
    Left = 240
    Top = 401
  end
  object dsgVenaPed: TDataSource
    DataSet = cdsgVenaPed
    Left = 240
    Top = 439
  end
  object cdsgVenaPed: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspgVenaPed'
    Left = 240
    Top = 424
  end
  object ACBrECF2: TACBrECF
    QuebraLinhaRodape = False
    Porta = 'COM1'
    MsgAguarde = 'Aguardando a resposta da Impressora: %d segundos'
    MsgTrabalhando = 'Impressora est'#225' trabalhando'
    MsgRelatorio = 'Imprimindo %s  %d'#170' Via '
    MsgPausaRelatorio = 'Destaque a %d'#170' via, <ENTER> proxima, %d seg.'
    PaginaDeCodigo = 0
    MemoParams.Strings = (
      '[Cabecalho]'
      'LIN000=<center><b>Nome da Empresa</b></center>'
      'LIN001=<center>Nome da Rua , 1234  -  Bairro</center>'
      'LIN002=<center>Cidade  -  UF  -  99999-999</center>'
      
        'LIN003=<center>CNPJ: 01.234.567/0001-22    IE: 012.345.678.90</c' +
        'enter>'
      
        'LIN004=<table width=100%><tr><td align=left><code>Data</code> <c' +
        'ode>Hora</code></td><td align=right>COO: <b><code>NumCupom</code' +
        '></b></td></tr></table>'
      'LIN005=<hr>'
      ' '
      '[Cabecalho_Item]'
      'LIN000=ITEM   CODIGO      DESCRICAO'
      'LIN001=QTD         x UNITARIO       Aliq     VALOR (R$)'
      'LIN002=<hr>'
      
        'MascaraItem=III CCCCCCCCCCCCCC DDDDDDDDDDDDDDDDDDDDDDDDDDDDDQQQQ' +
        'QQQQ UU x VVVVVVVVVVVVV AAAAAA TTTTTTTTTTTTT'
      ' '
      '[Rodape]'
      'LIN000=<hr>'
      
        'LIN001=<table width=100%><tr><td align=left><code>Data</code> <c' +
        'ode>Hora</code></td><td align=right>Projeto ACBr: <b><code>ACBR<' +
        '/code></b></td></tr></table>'
      'LIN002=<center>Obrigado Volte Sempre</center>'
      'LIN003=<hr>'
      ' '
      '[Formato]'
      'Colunas=48'
      'HTML=1'
      'HTML_Title_Size=2'
      'HTML_Font=<font size="2" face="Lucida Console">')
    ConfigBarras.MostrarCodigo = True
    ConfigBarras.LarguraLinha = 3
    ConfigBarras.Altura = 10
    ConfigBarras.Margem = 0
    InfoRodapeCupom.Imposto.ModoCompacto = False
    Left = 320
    Top = 384
  end
  object ACBrCTe1: TACBrCTe
    Configuracoes.Geral.SSLLib = libCapicom
    Configuracoes.Geral.SSLCryptLib = cryCapicom
    Configuracoes.Geral.SSLHttpLib = httpWinINet
    Configuracoes.Geral.SSLXmlSignLib = xsMsXmlCapicom
    Configuracoes.Geral.FormatoAlerta = 'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.'
    Configuracoes.Geral.ValidarDigest = False
    Configuracoes.Arquivos.OrdenacaoPath = <>
    Configuracoes.WebServices.UF = 'SP'
    Configuracoes.WebServices.AguardarConsultaRet = 0
    Configuracoes.WebServices.QuebradeLinha = '|'
    Configuracoes.RespTec.IdCSRT = 0
    Left = 320
    Top = 440
  end
  object qNotas: TSQLQuery
    Params = <>
    Left = 88
    Top = 388
  end
  object dsNotas: TDataSetProvider
    DataSet = qNotas
    Left = 88
    Top = 404
  end
  object cdsNotas: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dsNotas'
    Left = 88
    Top = 405
  end
  object SQLQuery2: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'Select * From Empresa')
    SQLConnection = WSepeDBX
    Left = 382
    Top = 404
  end
  object dspEmpresa: TDataSetProvider
    DataSet = SQLQuery2
    Left = 382
    Top = 405
  end
  object cdsEmpresa: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspEmpresa'
    Left = 382
    Top = 389
  end
  object DocXML: TXMLDocument
    Left = 384
    Top = 456
    DOMVendorDesc = 'MSXML'
  end
  object qgScranfs: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select * from scranfs, scracli'
      'where nfs_codcli = cli_codigo'
      'and cli_codigo = '#39'io'#39)
    SQLConnection = WSepeDBX
    Left = 456
    Top = 376
  end
  object dspgScraNfs: TDataSetProvider
    DataSet = qgScranfs
    Left = 456
    Top = 400
  end
  object cdsgScraNfs: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspgScraNfs'
    Left = 456
    Top = 424
  end
  object dsgScraNfs: TDataSource
    DataSet = cdsgScraNfs
    Left = 456
    Top = 446
  end
  object qCidades: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    Left = 520
    Top = 394
  end
  object dspCidades: TDataSetProvider
    DataSet = qCidades
    Left = 520
    Top = 410
  end
  object cdsCidades: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspCidades'
    Left = 520
    Top = 421
  end
  object qgVenaPgpd: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = WSepeDBX
    Left = 592
    Top = 376
  end
  object dspgVenaPgpd: TDataSetProvider
    DataSet = qgVenaPgpd
    Left = 592
    Top = 400
  end
  object dsgVenaPgpd: TDataSource
    DataSet = cdsgVenaPgpd
    Left = 592
    Top = 448
  end
  object cdsgVenaPgpd: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspgVenaPgpd'
    Left = 592
    Top = 424
  end
  object ACBrNFeDANFEFR1: TACBrNFeDANFEFR
    PathPDF = 'C:\Program Files (x86)\CodeGear\RAD Studio\5.0\bin\'
    Sistema = 'Projeto ACBr - www.projetoacbr.com.br'
    MargemInferior = 0.800000000000000000
    MargemSuperior = 0.800000000000000000
    MargemEsquerda = 0.600000000000000000
    MargemDireita = 0.510000000000000000
    ExpandeLogoMarcaConfig.Altura = 0
    ExpandeLogoMarcaConfig.Esquerda = 0
    ExpandeLogoMarcaConfig.Topo = 0
    ExpandeLogoMarcaConfig.Largura = 0
    ExpandeLogoMarcaConfig.Dimensionar = False
    ExpandeLogoMarcaConfig.Esticar = True
    CasasDecimais.Formato = tdetInteger
    CasasDecimais.qCom = 2
    CasasDecimais.vUnCom = 2
    CasasDecimais.MaskqCom = ',0.00'
    CasasDecimais.MaskvUnCom = ',0.00'
    ACBrNFe = ACBrNFe1
    TipoDANFE = tiSemGeracao
    EspessuraBorda = 1
    BorderIcon = [biSystemMenu, biMinimize, biMaximize]
    Left = 672
    Top = 407
  end
  object Saldos: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      '')
    Left = 718
    Top = 32
  end
  object dspSaldos: TDataSetProvider
    DataSet = Saldos
    Left = 718
    Top = 52
  end
  object cdsSaldos: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspSaldos'
    Left = 718
    Top = 80
  end
  object qScraNfs: TSQLQuery
    Params = <>
    Left = 710
    Top = 136
  end
  object dspScraNfs: TDataSetProvider
    DataSet = qScraNfs
    Left = 710
    Top = 156
  end
  object cdsScraNfs: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspScraNfs'
    Left = 710
    Top = 176
  end
  object qScpaNfe: TSQLQuery
    Params = <>
    Left = 742
    Top = 240
  end
  object dspScpaNfe: TDataSetProvider
    DataSet = qScpaNfe
    Left = 742
    Top = 260
  end
  object cdsScpaNfe: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspScpaNfe'
    Left = 742
    Top = 280
  end
  object Fechamento: TSQLQuery
    Params = <>
    Left = 742
    Top = 336
  end
  object dspFechamento: TDataSetProvider
    DataSet = Fechamento
    Left = 742
    Top = 356
  end
  object cdsFechamento: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspFechamento'
    Left = 742
    Top = 376
  end
  object qgEstapro: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      '')
    Left = 774
    Top = 80
  end
  object dspgEstapro: TDataSetProvider
    DataSet = qgEstapro
    Left = 774
    Top = 100
  end
  object cdsgEstapro: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspgEstapro'
    Left = 774
    Top = 128
  end
  object dsgEstapro: TDataSource
    DataSet = cdsgEstapro
    Left = 774
    Top = 140
  end
  object qgEstaEst: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      '')
    Left = 798
    Top = 196
  end
  object dspgEstaest: TDataSetProvider
    DataSet = qgEstaEst
    Left = 798
    Top = 216
  end
  object cdsgEstaest: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspgEstaest'
    Left = 798
    Top = 236
  end
  object dsgEstaEst: TDataSource
    DataSet = cdsgEstaest
    Left = 798
    Top = 256
  end
  object Movimentos: TSQLQuery
    Params = <>
    Left = 814
    Top = 308
  end
  object dspMovimentos: TDataSetProvider
    DataSet = Movimentos
    Left = 814
    Top = 328
  end
  object cdsMovimentos: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspMovimentos'
    Left = 814
    Top = 348
  end
  object qgEcmaAlx: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      '')
    Left = 832
    Top = 24
  end
  object dspgEcmaAlx: TDataSetProvider
    DataSet = qgEcmaAlx
    Left = 832
    Top = 44
  end
  object cdsgEcmaAlx: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspgEcmaAlx'
    Left = 832
    Top = 64
  end
  object dsgEcmaAlx: TDataSource
    DataSet = cdsgEcmaAlx
    Left = 832
    Top = 84
  end
  object qItensAnt: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      
        'Select IPD_NRO,    IPD_ITEM,   IPD_ACRES,  IPD_PRACRE,  IPD_ALX,' +
        '    IPD_CF,'
      
        'IPD_CODPRO, IPD_CODSRV, IPD_CODTNA, IPD_COFCST,  IPD_DESC,   IPD' +
        '_DESCRI,'
      
        'IPD_ICM,    IPD_ICMRED, IPD_IPI,    IPD_IPICST,  IPD_ISSVLR, IPD' +
        '_CODBAR,'
      
        'IPD_NAOFAT, IPD_NATOPR, IPD_PISCST, IPD_PRDESC,  IPD_QTDE,   IPD' +
        '_SITICM,'
      
        'IPD_SITIPI, IPD_TAB,    IPD_VALOR,  IPD_VLRICM,  IPD_VLRIPI, IPD' +
        '_VLRIRF,'
      'IPD_CODOPR, IPD_VLRLIN, IPD_VLRUNT, IPD_CSOSN'
      'FROM VENAIPD')
    Left = 862
    Top = 148
  end
  object dspItensAnt: TDataSetProvider
    DataSet = qItensAnt
    Left = 862
    Top = 168
  end
  object cdsItensAnt: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspItensAnt'
    Left = 862
    Top = 188
    object cdsItensAntIPD_NRO: TStringField
      DisplayLabel = 'Nro'
      FieldName = 'IPD_NRO'
      Required = True
      Size = 7
    end
    object cdsItensAntIPD_ITEM: TLargeintField
      DisplayLabel = 'Item'
      FieldName = 'IPD_ITEM'
      Required = True
    end
    object cdsItensAntIPD_CODPRO: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'IPD_CODPRO'
      Required = True
      Size = 10
    end
    object cdsItensAntIPD_DESCRI: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'IPD_DESCRI'
      Size = 120
    end
    object cdsItensAntIPD_QTDE: TFMTBCDField
      DisplayLabel = 'Qtde'
      FieldName = 'IPD_QTDE'
      Precision = 18
      Size = 4
    end
    object cdsItensAntIPD_VLRUNT: TFMTBCDField
      DisplayLabel = 'Unit'#225'rio'
      FieldName = 'IPD_VLRUNT'
      DisplayFormat = '###,###,##0.00'
      Precision = 18
      Size = 4
    end
    object cdsItensAntIPD_VLRLIN: TFMTBCDField
      DisplayLabel = 'Valor Item'
      FieldName = 'IPD_VLRLIN'
      DisplayFormat = '###,###,##0.00'
      Precision = 18
      Size = 4
    end
    object cdsItensAntIPD_NATOPR: TStringField
      DisplayLabel = 'CFOP'
      FieldName = 'IPD_NATOPR'
      Size = 4
    end
    object cdsItensAntIPD_CODOPR: TStringField
      DisplayLabel = 'Var'
      FieldName = 'IPD_CODOPR'
      Size = 2
    end
    object cdsItensAntIPD_CODTNA: TStringField
      DisplayLabel = 'Cod.CFOP'
      FieldName = 'IPD_CODTNA'
      Size = 3
    end
    object cdsItensAntIPD_TAB: TStringField
      DisplayLabel = 'Tab'
      FieldName = 'IPD_TAB'
      Size = 4
    end
    object cdsItensAntIPD_ALX: TStringField
      DisplayLabel = 'ALX'
      FieldName = 'IPD_ALX'
      Size = 3
    end
    object cdsItensAntIPD_PRACRE: TFMTBCDField
      DisplayLabel = '%Acres'
      FieldName = 'IPD_PRACRE'
      Precision = 18
      Size = 6
    end
    object cdsItensAntIPD_DESC: TFMTBCDField
      DisplayLabel = '%Desc'
      FieldName = 'IPD_DESC'
      Precision = 18
      Size = 2
    end
    object cdsItensAntIPD_CF: TStringField
      DisplayLabel = 'CST ICMS'
      FieldName = 'IPD_CF'
      Size = 3
    end
    object cdsItensAntIPD_CSOSN: TStringField
      DisplayLabel = 'CSOSN'
      FieldName = 'IPD_CSOSN'
      Size = 3
    end
    object cdsItensAntIPD_ICM: TFMTBCDField
      DisplayLabel = '%Red.ICMS'
      FieldName = 'IPD_ICMRED'
      Precision = 18
      Size = 2
    end
    object cdsItensAntIPD_ICMRED: TFMTBCDField
      DisplayLabel = '%ICMS'
      FieldName = 'IPD_ICM'
      Precision = 18
      Size = 4
    end
    object cdsItensAntIPD_IPI: TFMTBCDField
      DisplayLabel = 'IPI'
      FieldName = 'IPD_IPI'
      Precision = 18
      Size = 2
    end
    object cdsItensAntIPD_ISSVLR: TFMTBCDField
      DisplayLabel = 'V.ISSQN'
      FieldName = 'IPD_ISSVLR'
      Precision = 18
      Size = 2
    end
    object cdsItensAntIPD_CODBAR: TStringField
      DisplayLabel = 'Barras'
      FieldName = 'IPD_CODBAR'
      Size = 13
    end
    object cdsItensAntIPD_NAOFAT: TStringField
      DisplayLabel = 'N'#227'o fat'
      FieldName = 'IPD_NAOFAT'
      Size = 1
    end
    object cdsItensAntIPD_PRDESC: TFMTBCDField
      DisplayLabel = '%Desc'
      FieldName = 'IPD_PRDESC'
      Precision = 18
      Size = 6
    end
    object cdsItensAntIPD_SITICM: TStringField
      DisplayLabel = 'SITICM'
      FieldName = 'IPD_SITICM'
      Size = 1
    end
    object cdsItensAntIPD_SITIPI: TStringField
      DisplayLabel = 'SITIPI'
      FieldName = 'IPD_SITIPI'
      Size = 1
    end
    object cdsItensAntIPD_VALOR: TFMTBCDField
      DisplayLabel = 'VALOR'
      FieldName = 'IPD_VALOR'
      Precision = 18
      Size = 4
    end
    object cdsItensAntIPD_VLRICM: TFMTBCDField
      DisplayLabel = 'Vlr.ICMS'
      FieldName = 'IPD_VLRICM'
      Precision = 18
      Size = 2
    end
    object cdsItensAntIPD_VLRIPI: TFMTBCDField
      DisplayLabel = 'Vlr.IPI'
      FieldName = 'IPD_VLRIPI'
      Precision = 18
      Size = 2
    end
    object cdsItensAntIPD_VLRIRF: TFMTBCDField
      DisplayLabel = 'VlrIRF'
      FieldName = 'IPD_VLRIRF'
      Precision = 18
      Size = 2
    end
    object cdsItensAntIPD_IPICST: TStringField
      DisplayLabel = 'CST IPI'
      FieldName = 'IPD_IPICST'
      Size = 2
    end
    object cdsItensAntIPD_PISCST: TStringField
      DisplayLabel = 'CST PIS'
      FieldName = 'IPD_PISCST'
      Size = 2
    end
    object cdsItensAntIPD_COFCST: TStringField
      DisplayLabel = 'CST COFINS'
      FieldName = 'IPD_COFCST'
      Size = 2
    end
    object cdsItensAntIPD_CODSRV: TStringField
      FieldName = 'IPD_CODSRV'
      Size = 10
    end
    object cdsItensAntIPD_ACRES: TFMTBCDField
      DisplayLabel = 'V.Acres'
      FieldName = 'IPD_ACRES'
      Precision = 18
      Size = 2
    end
  end
  object dsItensAnt: TDataSource
    DataSet = cdsItensAnt
    Left = 862
    Top = 208
  end
  object ACBrNFSe1: TACBrNFSe
    Configuracoes.Geral.SSLLib = libCapicomDelphiSoap
    Configuracoes.Geral.SSLCryptLib = cryCapicom
    Configuracoes.Geral.SSLHttpLib = httpIndy
    Configuracoes.Geral.SSLXmlSignLib = xsMsXmlCapicom
    Configuracoes.Geral.FormatoAlerta = 'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.'
    Configuracoes.Geral.CodigoMunicipio = 0
    Configuracoes.Geral.ConsultaLoteAposEnvio = False
    Configuracoes.Geral.Emitente.DadosSenhaParams = <>
    Configuracoes.Arquivos.OrdenacaoPath = <>
    Configuracoes.WebServices.UF = 'SP'
    Configuracoes.WebServices.AguardarConsultaRet = 0
    Configuracoes.WebServices.QuebradeLinha = '|'
    Left = 888
    Top = 288
  end
  object dsgCadObra: TDataSource
    DataSet = cdsgCadObra
    Left = 752
    Top = 439
  end
  object cdsgCadObra: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspgCadObra'
    Left = 760
    Top = 439
  end
  object dspgCadObra: TDataSetProvider
    DataSet = qgCadObra
    Left = 768
    Top = 439
  end
  object qgCadObra: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    Left = 776
    Top = 439
  end
  object qpSepeDic: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    Left = 464
    Top = 113
  end
  object dspSepeDic: TDataSetProvider
    DataSet = qpSepeDic
    Left = 464
    Top = 129
  end
  object cdsSepeDic: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspSepeDic'
    Left = 464
    Top = 144
  end
  object frxReport1: TfrxReport
    Version = '6.4'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick, pbCopy, pbSelection]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43724.450153622680000000
    ReportOptions.LastChange = 43724.450153622680000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 840
    Top = 416
    Datasets = <>
    Variables = <>
    Style = <>
  end
  object frxDBDataset1: TfrxDBDataset
    UserName = 'frxDBDataset1'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 896
    Top = 376
  end
  object cdsAbrFec: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspWeb'
    Left = 376
    Top = 12
  end
  object ACBrNFeDANFCEFR1: TACBrNFeDANFCEFR
    Sistema = 'Projeto ACBr - www.projetoacbr.com.br'
    MargemInferior = 0.800000000000000000
    MargemSuperior = 0.800000000000000000
    MargemEsquerda = 0.600000000000000000
    MargemDireita = 0.510000000000000000
    ExpandeLogoMarcaConfig.Altura = 0
    ExpandeLogoMarcaConfig.Esquerda = 0
    ExpandeLogoMarcaConfig.Topo = 0
    ExpandeLogoMarcaConfig.Largura = 0
    ExpandeLogoMarcaConfig.Dimensionar = False
    ExpandeLogoMarcaConfig.Esticar = True
    CasasDecimais.Formato = tdetInteger
    CasasDecimais.qCom = 2
    CasasDecimais.vUnCom = 2
    CasasDecimais.MaskqCom = ',0.00'
    CasasDecimais.MaskvUnCom = ',0.00'
    BorderIcon = [biSystemMenu, biMinimize, biMaximize]
    Left = 472
    Top = 520
  end
  object qgScraChi: TSQLQuery
    Params = <>
    Left = 32
    Top = 448
  end
  object dspgScraChi: TDataSetProvider
    DataSet = qgScraChi
    Left = 32
    Top = 464
  end
  object cdsgScraChi: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspgScraChi'
    Left = 32
    Top = 480
  end
  object dsgScraChi: TDataSource
    DataSet = cdsgScraChi
    Left = 32
    Top = 496
  end
  object qgScraPgp: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    Left = 112
    Top = 472
  end
  object dspgScraPgp: TDataSetProvider
    DataSet = qgScraPgp
    Left = 112
    Top = 488
  end
  object cdsgScraPgp: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspgScraPgp'
    Left = 112
    Top = 504
  end
  object dsgScraPgp: TDataSource
    DataSet = cdsgScraPgp
    Left = 112
    Top = 520
  end
  object qFluxo: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    Left = 176
    Top = 480
  end
  object dspFluxo: TDataSetProvider
    DataSet = qFluxo
    Left = 176
    Top = 504
  end
  object cdsFluxo: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspFluxo'
    Left = 176
    Top = 520
  end
  object dsFluxo: TDataSource
    DataSet = cdsFluxo
    Left = 176
    Top = 536
  end
  object qgAintCon: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    Left = 248
    Top = 488
  end
  object dspgAintCon: TDataSetProvider
    DataSet = qgAintCon
    Left = 248
    Top = 504
  end
  object cdsgAintCon: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspgAintCon'
    Left = 248
    Top = 520
  end
  object dsgAintCon: TDataSource
    DataSet = cdsgAintCon
    Left = 248
    Top = 536
  end
  object qgScfaCta: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    Left = 320
    Top = 496
  end
  object dspgScfaCta: TDataSetProvider
    DataSet = qgScfaCta
    Left = 320
    Top = 512
  end
  object cdsgScfaCta: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspgScfaCta'
    Left = 320
    Top = 528
    object cdsgScfaCtaCONTA: TStringField
      DisplayLabel = 'Conta'
      FieldName = 'CONTA'
      Required = True
      Size = 11
    end
    object cdsgScfaCtaDESCRI: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESCRI'
      Size = 60
    end
    object cdsgScfaCtaCODEST: TStringField
      DisplayLabel = 'Estrutura'
      FieldName = 'CODEST'
      Size = 15
    end
    object cdsgScfaCtaLANCCUSTO: TStringField
      DisplayLabel = 'Exige CC'
      FieldName = 'LANCCUSTO'
      Size = 1
    end
    object cdsgScfaCtaTIPO: TStringField
      FieldName = 'TIPO'
      Visible = False
      Size = 1
    end
    object cdsgScfaCtaUSRATU: TStringField
      FieldName = 'USRATU'
      Visible = False
      Size = 10
    end
    object cdsgScfaCtaDATATU: TDateField
      FieldName = 'DATATU'
    end
  end
  object dsgScfaCta: TDataSource
    DataSet = cdsgScfaCta
    Left = 320
    Top = 544
  end
  object qC5: TSQLQuery
    Params = <>
    Left = 384
    Top = 512
  end
  object dspC5: TDataSetProvider
    DataSet = qC5
    Left = 384
    Top = 528
  end
  object cdsC5: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspC5'
    Left = 384
    Top = 536
  end
  object dsC5: TDataSource
    DataSet = cdsC5
    Left = 384
    Top = 552
  end
  object ACBrNFSeDANFSeFR1: TACBrNFSeDANFSeFR
    Sistema = 'Projeto ACBr - www.projetoacbr.com.br'
    MargemInferior = 8.000000000000000000
    MargemSuperior = 8.000000000000000000
    MargemEsquerda = 6.000000000000000000
    MargemDireita = 5.100000000000000000
    ExpandeLogoMarcaConfig.Altura = 0
    ExpandeLogoMarcaConfig.Esquerda = 0
    ExpandeLogoMarcaConfig.Topo = 0
    ExpandeLogoMarcaConfig.Largura = 0
    ExpandeLogoMarcaConfig.Dimensionar = False
    ExpandeLogoMarcaConfig.Esticar = True
    CasasDecimais.Formato = tdetInteger
    CasasDecimais.qCom = 2
    CasasDecimais.vUnCom = 2
    CasasDecimais.MaskqCom = ',0.00'
    CasasDecimais.MaskvUnCom = ',0.00'
    Cancelada = False
    Provedor = proNenhum
    TamanhoFonte = 6
    FormatarNumeroDocumentoNFSe = True
    EspessuraBorda = 1
    Left = 584
    Top = 528
  end
end
