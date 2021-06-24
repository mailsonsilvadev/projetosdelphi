 unit U_T2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, IniFiles, CParametrosBDIni,
  Db, FMTBcd, SqlExpr, DBClient, Provider, WideStrings, Data.DbxFirebird, ACBrBase, ACBrECF, ACBrNFe, ACBrCTe,
  Xml.xmldom, Xml.XMLIntf, Xml.Win.msxmldom, Xml.XMLDoc, ACBrNFeDANFEFRDM, ACBrNFeDANFEClass, ACBrNFeDANFEFR, ACBrDFe, ACBrNFSe, ACBrDFeReport,
  ACBrDFeDANFeReport, frxClass, frxDBSet, ACBrNFSeDANFSeClass, ACBrNFSeDANFSeFR;

type
  TT2 = class(TDataModule)
    qEmpresa: TSQLQuery;
    qgSepeCfg: TSQLQuery;
    dspgSepeCfg: TDataSetProvider;
    cdsgSepeCfg: TClientDataSet;
    cdsgSepeCfgOPCAO: TStringField;
    cdsgSepeCfgDESCRICAO: TStringField;
    cdsgSepeCfgSIT: TStringField;
    cdsgSepeCfgUSRATU: TStringField;
    cdsgSepeCfgDATATU: TSQLTimeStampField;
    dsgSepeCfg: TDataSource;
    qR145: TSQLQuery;
    qR2: TSQLQuery;
    qaSepeRel: TSQLQuery;
    qaSepeCfg: TSQLQuery;
    Temp: TClientDataSet;
    dspqR1: TDataSetProvider;
    cdsqR1: TClientDataSet;
    dsqR1: TDataSource;
    qR1: TSQLQuery;
    WSepeDBX: TSQLConnection;
    qaSepePar: TSQLQuery;
    qR3: TSQLQuery;
    cdsCadEmp: TClientDataSet;
    qSepe: TSQLQuery;
    dspSepe: TDataSetProvider;
    cdsSepe: TClientDataSet;
    qSepeAces: TSQLQuery;
    dspSepeAces: TDataSetProvider;
    cdsSepeAces: TClientDataSet;
    qC1: TSQLQuery;
    dspC1: TDataSetProvider;
    cdsC1: TClientDataSet;
    dsC1: TDataSource;
    qWeb: TSQLQuery;
    dspWeb: TDataSetProvider;
    cdsWeb: TClientDataSet;
    dsWeb: TDataSource;
    qTemp: TSQLQuery;
    qgWtpedido: TSQLQuery;
    dspgWtpedido: TDataSetProvider;
    cdsgWtpedido: TClientDataSet;
    dsgWtpedido: TDataSource;
    cdsSelecaoTrib: TClientDataSet;
    cdsqC1: TClientDataSet;
    dspqC1: TDataSetProvider;
    qC2: TSQLQuery;
    dspC2: TDataSetProvider;
    cdsC2: TClientDataSet;
    dsC2: TDataSource;
    dspqC2: TDataSetProvider;
    cdsqC2: TClientDataSet;
    cdsTemp: TClientDataSet;
    dsTemp: TDataSource;
    dsTempSrvaMov: TDataSource;
    cdsTempSrvaMov: TClientDataSet;
    qC3: TSQLQuery;
    dspC3: TDataSetProvider;
    cdsC3: TClientDataSet;
    dsC3: TDataSource;
    dspqC3: TDataSetProvider;
    cdsqC3: TClientDataSet;
    qC4: TSQLQuery;
    dspC4: TDataSetProvider;
    cdsC4: TClientDataSet;
    dsC4: TDataSource;
    dspqC4: TDataSetProvider;
    cdsqC4: TClientDataSet;
    qSepeCfg: TSQLQuery;
    ACBrECF1: TACBrECF;
    ACBrNFe1: TACBrNFe;
    qgScraCli: TSQLQuery;
    dspgScraCli: TDataSetProvider;
    cdsgScraCli: TClientDataSet;
    dsgScraCli: TDataSource;
    qSepeRel: TSQLQuery;
    qSepeDic: TSQLQuery;
    cdsTempGexPar: TClientDataSet;
    dsTempGexPar: TDataSource;
    cdsTempGexExt: TClientDataSet;
    dsTempGexExt: TDataSource;
    qSeraInf: TSQLQuery;
    dspSeraInf: TDataSetProvider;
    cdsSeraInf: TClientDataSet;
    dsSeraInf: TDataSource;
    qRel: TSQLQuery;
    dspqRel: TDataSetProvider;
    cdsqRel: TClientDataSet;
    dsqRel: TDataSource;
    cdsECF_Formas: TClientDataSet;
    cdsECF_FormasIndex: TStringField;
    cdsECF_FormasDescricao: TStringField;
    cdsECF_FormasVinculo: TStringField;
    qgScraEcf: TSQLQuery;
    dspgScraEcf: TDataSetProvider;
    cdsgScraEcf: TClientDataSet;
    dsgScraEcf: TDataSource;
    qgScraEcfl: TSQLQuery;
    dspgScraEcfl: TDataSetProvider;
    cdsgScraEcfl: TClientDataSet;
    dsgScraEcfl: TDataSource;
    qgScraDup: TSQLQuery;
    dspgScraDup: TDataSetProvider;
    cdsgScraDup: TClientDataSet;
    dsgScraDup: TDataSource;
    qgFluxo: TSQLQuery;
    dspgFluxo: TDataSetProvider;
    cdsgFluxo: TClientDataSet;
    cdsgFluxoDOCUMENTO: TStringField;
    cdsgFluxoCONTA: TStringField;
    cdsgFluxoCCUSTO: TStringField;
    cdsgFluxoHISTORICO: TStringField;
    cdsgFluxoVALOR: TFMTBCDField;
    cdsgFluxoVALOR_US: TFMTBCDField;
    cdsgFluxoTIPO_MOV: TStringField;
    cdsgFluxoEXEC_TRAN: TStringField;
    cdsgFluxoDOLAR: TFMTBCDField;
    cdsgFluxoBANCO: TStringField;
    cdsgFluxoUSRATU: TStringField;
    cdsgFluxoNRLANC: TFloatField;
    cdsgFluxoDATA: TDateField;
    cdsgFluxoDTCONTAB: TDateField;
    cdsgFluxoDATATU: TDateField;
    dsgFluxo: TDataSource;
    qgVenaIpd: TSQLQuery;
    dspgVenaIpd: TDataSetProvider;
    cdsgVenaIpd: TClientDataSet;
    dsgVenaIpd: TDataSource;
    SQLQuery1: TSQLQuery;
    dspR1: TDataSetProvider;
    cdsR1: TClientDataSet;
    dsR1: TDataSource;
    qItensDvNFE: TSQLQuery;
    dspItensDvNFE: TDataSetProvider;
    cdsItensDvNFE: TClientDataSet;
    dsItensDvNFE: TDataSource;
    qgVenaPed: TSQLQuery;
    dspgVenaPed: TDataSetProvider;
    dsgVenaPed: TDataSource;
    cdsgVenaPed: TClientDataSet;
    ACBrECF2: TACBrECF;
    ACBrCTe1: TACBrCTe;
    qNotas: TSQLQuery;
    dsNotas: TDataSetProvider;
    cdsNotas: TClientDataSet;
    SQLQuery2: TSQLQuery;
    dspEmpresa: TDataSetProvider;
    cdsEmpresa: TClientDataSet;
    DocXML: TXMLDocument;
    qgScranfs: TSQLQuery;
    dspgScraNfs: TDataSetProvider;
    cdsgScraNfs: TClientDataSet;
    dsgScraNfs: TDataSource;
    qCidades: TSQLQuery;
    dspCidades: TDataSetProvider;
    cdsCidades: TClientDataSet;
    qgVenaPgpd: TSQLQuery;
    dspgVenaPgpd: TDataSetProvider;
    dsgVenaPgpd: TDataSource;
    cdsgVenaPgpd: TClientDataSet;
    ACBrNFeDANFEFR1: TACBrNFeDANFEFR;
    Saldos: TSQLQuery;
    dspSaldos: TDataSetProvider;
    cdsSaldos: TClientDataSet;
    qScraNfs: TSQLQuery;
    dspScraNfs: TDataSetProvider;
    cdsScraNfs: TClientDataSet;
    qScpaNfe: TSQLQuery;
    dspScpaNfe: TDataSetProvider;
    cdsScpaNfe: TClientDataSet;
    Fechamento: TSQLQuery;
    dspFechamento: TDataSetProvider;
    cdsFechamento: TClientDataSet;
    qgEstapro: TSQLQuery;
    dspgEstapro: TDataSetProvider;
    cdsgEstapro: TClientDataSet;
    dsgEstapro: TDataSource;
    qgEstaEst: TSQLQuery;
    dspgEstaest: TDataSetProvider;
    cdsgEstaest: TClientDataSet;
    dsgEstaEst: TDataSource;
    Movimentos: TSQLQuery;
    dspMovimentos: TDataSetProvider;
    cdsMovimentos: TClientDataSet;
    qgEcmaAlx: TSQLQuery;
    dspgEcmaAlx: TDataSetProvider;
    cdsgEcmaAlx: TClientDataSet;
    dsgEcmaAlx: TDataSource;
    qItensAnt: TSQLQuery;
    dspItensAnt: TDataSetProvider;
    cdsItensAnt: TClientDataSet;
    cdsItensAntIPD_NRO: TStringField;
    cdsItensAntIPD_ITEM: TLargeintField;
    cdsItensAntIPD_CODPRO: TStringField;
    cdsItensAntIPD_DESCRI: TStringField;
    cdsItensAntIPD_QTDE: TFMTBCDField;
    cdsItensAntIPD_VLRUNT: TFMTBCDField;
    cdsItensAntIPD_VLRLIN: TFMTBCDField;
    cdsItensAntIPD_NATOPR: TStringField;
    cdsItensAntIPD_CODOPR: TStringField;
    cdsItensAntIPD_CODTNA: TStringField;
    cdsItensAntIPD_TAB: TStringField;
    cdsItensAntIPD_ALX: TStringField;
    cdsItensAntIPD_PRACRE: TFMTBCDField;
    cdsItensAntIPD_DESC: TFMTBCDField;
    cdsItensAntIPD_CF: TStringField;
    cdsItensAntIPD_CSOSN: TStringField;
    cdsItensAntIPD_ICM: TFMTBCDField;
    cdsItensAntIPD_ICMRED: TFMTBCDField;
    cdsItensAntIPD_IPI: TFMTBCDField;
    cdsItensAntIPD_ISSVLR: TFMTBCDField;
    cdsItensAntIPD_CODBAR: TStringField;
    cdsItensAntIPD_NAOFAT: TStringField;
    cdsItensAntIPD_PRDESC: TFMTBCDField;
    cdsItensAntIPD_SITICM: TStringField;
    cdsItensAntIPD_SITIPI: TStringField;
    cdsItensAntIPD_VALOR: TFMTBCDField;
    cdsItensAntIPD_VLRICM: TFMTBCDField;
    cdsItensAntIPD_VLRIPI: TFMTBCDField;
    cdsItensAntIPD_VLRIRF: TFMTBCDField;
    cdsItensAntIPD_IPICST: TStringField;
    cdsItensAntIPD_PISCST: TStringField;
    cdsItensAntIPD_COFCST: TStringField;
    cdsItensAntIPD_CODSRV: TStringField;
    cdsItensAntIPD_ACRES: TFMTBCDField;
    dsItensAnt: TDataSource;
    ACBrNFSe1: TACBrNFSe;
    dsgCadObra: TDataSource;
    cdsgCadObra: TClientDataSet;
    dspgCadObra: TDataSetProvider;
    qgCadObra: TSQLQuery;
    qpSepeDic: TSQLQuery;
    dspSepeDic: TDataSetProvider;
    cdsSepeDic: TClientDataSet;
    frxReport1: TfrxReport;
    frxDBDataset1: TfrxDBDataset;
    cdsAbrFec: TClientDataSet;
    ACBrNFeDANFCEFR1: TACBrNFeDANFCEFR;
    qgScraChi: TSQLQuery;
    dspgScraChi: TDataSetProvider;
    cdsgScraChi: TClientDataSet;
    dsgScraChi: TDataSource;
    qgScraPgp: TSQLQuery;
    dspgScraPgp: TDataSetProvider;
    cdsgScraPgp: TClientDataSet;
    dsgScraPgp: TDataSource;
    qFluxo: TSQLQuery;
    dspFluxo: TDataSetProvider;
    cdsFluxo: TClientDataSet;
    dsFluxo: TDataSource;
    qgAintCon: TSQLQuery;
    dspgAintCon: TDataSetProvider;
    cdsgAintCon: TClientDataSet;
    dsgAintCon: TDataSource;
    qgScfaCta: TSQLQuery;
    dspgScfaCta: TDataSetProvider;
    cdsgScfaCta: TClientDataSet;
    cdsgScfaCtaCONTA: TStringField;
    cdsgScfaCtaDESCRI: TStringField;
    cdsgScfaCtaCODEST: TStringField;
    cdsgScfaCtaLANCCUSTO: TStringField;
    cdsgScfaCtaTIPO: TStringField;
    cdsgScfaCtaUSRATU: TStringField;
    cdsgScfaCtaDATATU: TDateField;
    dsgScfaCta: TDataSource;
    qC5: TSQLQuery;
    dspC5: TDataSetProvider;
    cdsC5: TClientDataSet;
    dsC5: TDataSource;
    ACBrNFSeDANFSeFR1: TACBrNFSeDANFSeFR;
  private
    { Private declarations }
  public
    { Public declarations }

    NomeVndUser: String;

    function FazConexao(ComMsg: Boolean = True; AUsuario: String = ''; ASenha: String = ''): Boolean;
  end;

var
  T2: TT2;

implementation

uses U_SisProc, Conexao;

{$R *.DFM}

function TT2.FazConexao(ComMsg: Boolean = True; AUsuario: String = ''; ASenha: String = ''): Boolean;
var
  obConfig: TParametrosBDIni;
begin
  Result := True;

  T2.WSepeDBX.Connected := False;

  obConfig := TParametrosBDIni.Create;
  Try
    obConfig.CarregarConfiguracao;

    T2.WSepeDBX.Params.Clear;
    T2.WSepeDBX.Params.Add('DriverName=' + obConfig.Conexao.Driver);
    T2.WSepeDBX.Params.Add('Database=' + obConfig.Conexao.Base);
    T2.WSepeDBX.Params.Add('RoleName=' + obConfig.Conexao.Role);

    if AUsuario.IsEmpty then
    begin
      T2.WSepeDBX.Params.Add('User_Name=' + obConfig.Conexao.Usuario);
      T2.WSepeDBX.Params.Add('Password=' + '&!' + Copy(obConfig.Conexao.Senha, 3, 100));
    end
    else
    begin
      T2.WSepeDBX.Params.Add('User_Name=' + AUsuario);
      T2.WSepeDBX.Params.Add('Password=' + ASenha);
    end;

    T2.WSepeDBX.Params.Add('ServerCharSet=' + obConfig.Conexao.CharSet);
    T2.WSepeDBX.Params.Add('SQLDialect=' + obConfig.Conexao.Dialect);
    T2.WSepeDBX.Params.Add('ErrorResourceFile=' + obConfig.Conexao.ErroFile);
    T2.WSepeDBX.Params.Add('LocaleCode=' + obConfig.Conexao.LocalCode);
    T2.WSepeDBX.Params.Add('BlobSize=' + obConfig.Conexao.BlobSize);
    T2.WSepeDBX.Params.Add('CommitRetain=' + obConfig.Conexao.CommitRetain);
    T2.WSepeDBX.Params.Add('WaitOnLocks=' + obConfig.Conexao.WaitLocks);
    T2.WSepeDBX.Params.Add('TransIsolation=' + obConfig.Conexao.TransIsolation);
    T2.WSepeDBX.Params.Add('Trim Char=' + obConfig.Conexao.TrimChar);

    SetUsuario(obConfig.Conexao.Usuario);
    SetSenha(obConfig.Conexao.Senha);
  Finally
    obConfig.Free;
  End;

  try
    T2.WSepeDBX.Connected := True;
  except
    on E: Exception do
    begin
      if ComMsg then
        DL_Msg('Erro de conexão: ' + E.Message, 'Erro', 'ERRO')
      else
        Raise Exception.Create('Erro de conexão: ' + E.Message);
      Result := False;
    end;
    else
    begin
      if ComMsg then
        DL_Msg('Erro de conexão!', 'Erro', 'ERRO')
      else
        Raise Exception.Create('Erro de conexão!');

      Result := False;
    end;

  end;
end;

end.
