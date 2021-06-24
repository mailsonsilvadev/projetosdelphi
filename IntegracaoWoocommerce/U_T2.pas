unit U_T2;

interface

uses
  SysUtils, Classes, WideStrings, FMTBcd, DB, DBClient, Provider, SqlExpr, DbxFirebird, Forms, CParametrosBdIni, IPPeerClient, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, Conexao;

type
  TT2 = class(TDataModule)
    qC1: TSQLQuery;
    dspC1: TDataSetProvider;
    cdsC1: TClientDataSet;
    qC2: TSQLQuery;
    dspC2: TDataSetProvider;
    cdsC2: TClientDataSet;
    WSepeDBX: TSQLConnection;
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
    qCadEmp: TSQLQuery;
    dspCadEmp: TDataSetProvider;
    cdsCadEmp: TClientDataSet;
    dsCademp: TDataSource;
    qSepe: TSQLQuery;
    dspSepe: TDataSetProvider;
    cdsSepe: TClientDataSet;
    qSepeAces: TSQLQuery;
    dspSepeAces: TDataSetProvider;
    cdsSepeAces: TClientDataSet;
    qTemp: TSQLQuery;
    qWeb: TSQLQuery;
    dspWeb: TDataSetProvider;
    cdsWeb: TClientDataSet;
    dsWeb: TDataSource;
    qSepeCfg: TSQLQuery;
    cdsSelecaoTrib: TClientDataSet;
    cdsqC1: TClientDataSet;
    dspqC1: TDataSetProvider;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    qC4: TSQLQuery;
    dspC4: TDataSetProvider;
    cdsC4: TClientDataSet;
    dsC4: TDataSource;
    qC3: TSQLQuery;
    dspC3: TDataSetProvider;
    cdsC3: TClientDataSet;
    dsC3: TDataSource;
    qSepeDic: TSQLQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    function FazConexao(ComMsg: Boolean = True; AUsuario: String = ''; ASenha: String = ''): Boolean;
  end;

var
  T2: TT2;

implementation

uses U_SisProc;

{$R *.dfm}
{ TT2 }

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
