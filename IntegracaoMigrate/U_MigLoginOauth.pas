unit U_MigLoginOauth;

interface

uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, DateUtils, U_MigComm,
  Menus, ExtCtrls, ComCtrls, U_Sisproc, stdctrls, Variants,
  {$IFDEF VER340}
  System.JSON,
  {$ELSE}
  DBXJson,
  {$ENDIF}
  System.Actions;

type
  TMigLoginOauth = class(TObject)
  private
    function GerarNovoTokenAcesso: String;
    function GetTokenAcesso(ARefreshValido: Boolean; ATokenRefresh: String): String;
  public
    function GetAccessToken: String;
  end;

implementation

uses U_T2, IdGlobal, U_Hmac, IdHMACSHA1, IdHashMessageDigest;

const
  JwtHeader = '{"alg":"HS256","typ":"JWT"}';

  { TMigLoginOauth }

function TMigLoginOauth.GerarNovoTokenAcesso: String;
var
  TokenParceiro, TokenEmp, TimeStampAtual, TimeStampValidade, JwtPayload, CnpjEmpresa, JwtToSign, JwtSign, TokenJwtParaRefresh, TokenRefresh,
    DataRefStr: String;
  TimeStamp: TTimeStamp;
  I: Integer;
  DataHora: Int64;
  DataHoraGMT: TDateTime;
  RefreshValido: Boolean;
begin
  // São 3 tokens no total: um TOKEN PRINCIPAL para gerar o TOKEN REFRESH - o TOKEN REFRESH utilizado para gerar o último token, o TOKEN DE ACESSO
  TokenEmp := BuscaCFG2(T2.qSepeCfg, 'SEPECFG', 'CFG_TOKEMP', 'TOKEN DA EMPRESA NA MIGRATE', '', 1, 500);
  if TokenEmp.Trim.IsEmpty then
    raise Exception.Create('Configure o Token da empresa nos parâmetros!');

  TokenParceiro := BuscaCFG2(T2.qSepeCfg, 'SEPECFG', 'CFG_TOKPAR', 'Token do parceiro da Migrate', '', 1, 500);
  if TokenParceiro.Trim.IsEmpty then
    raise Exception.Create('Configure o Token do parceiro nos parâmetros!');

  TokenJwtParaRefresh := BuscaCFG2(T2.qSepeCfg, 'SEPECFG', 'CFG_TOKREF', 'Token de refresh da Migrate', '', 1, 500);
  DataRefStr := BuscaCFG2(T2.qSepeCfg, 'SEPECFG', 'CFG_TOKRFD', 'Data e hora de expiração do token de refresh da Migrate', '', 1, 50);
  RefreshValido := not DataRefStr.Trim.IsEmpty;
  if (DataRefStr.Trim.IsEmpty) or (StrToDateTime(DataRefStr) < Now) then
  begin
    RefreshValido := False;

    // Cálcula a Data e hora de inicio da validade do token
    DataHoraGMT := IncHour(Now, 3);
    DataHora := DateTimeToUnix(DataHoraGMT);
    TimeStampAtual := Nst(DataHora);

    // Cálcula a Data e hora da expiração do token
    DataHora := DateTimeToUnix(IncSecond(DataHoraGMT, 120));
    TimeStampValidade := Nst(DataHora);

    CnpjEmpresa := LimpaNumero(BuscaEmpresa(T2.qEmpresa, 'CGCMF'));

    JwtPayload := '{"iat": ' + TimeStampAtual + ', "exp": ' + TimeStampValidade + ', "sub": "' + CnpjEmpresa + '", "partnerKey": "' + TokenParceiro + '"}';

    JwtToSign := EncodeBase64(JwtHeader) + '.' + EncodeBase64(Strtran(JwtPayload, ' ', ''));
    if JwtToSign.Substring(JwtToSign.Length - 1) = '=' then
      JwtToSign := JwtToSign.Substring(0, JwtToSign.Length - 1);

    JwtSign := THMACUtils<TIdHMACSHA256>.HMAC_Base64(TokenEmp, JwtToSign);
    if JwtSign.Substring(JwtSign.Length - 1) = '=' then
      JwtSign := JwtSign.Substring(0, JwtSign.Length - 1);

    // Token utilizado para gerar o token de refresh
    TokenJwtParaRefresh := JwtToSign + '.' + JwtSign;
  end;

  Result := EmptyStr;
  for I := 0 to 4 do  // faz 5 tentativas de conexão
  begin
    Try
      Result := GetTokenAcesso(RefreshValido, TokenJwtParaRefresh);
      if Result <> EmptyStr then
        Break;
    Except
      on E: Exception do
      begin
        if I = 4 then
          raise Exception.Create(E.Message);
      end;
    End;
    Sleep(1000);
  end;
end;

function TMigLoginOauth.GetAccessToken: String;
var
  DataToken: TDateTime;
  DataStr: String;
  TokenExpirado: Boolean;
begin
  Result := EmptyStr;
  DataStr := BuscaCFG2(T2.qSepeCfg, 'SEPECFG', 'CFG_TOKDTA', 'Data e hora de expiração do token de acesso da Migrate', '', 1, 50);

  TokenExpirado := False;
  if not DataStr.Trim.IsEmpty then
  begin
    DataToken := StrToDateTime(DataStr);

    if DataToken < Now then
    begin
      // O token da Migrate expira a cada 120 segundos, portanto gera um novo a cada 110 segundos mantendo 10 segundos de segurança
      // if SecondsBetween(DataToken, Now) > 110 then
      TokenExpirado := True;
    end;
  end
  else
    TokenExpirado := True;

  // Sempre busca o último token para criar a configuração caso ela ainda não exista
  Result := BuscaCFG2(T2.qSepeCfg, 'SEPECFG', 'CFG_TOKULT', 'Ultimo token de acesso da Migrate', '', 1, 1000);
  if TokenExpirado then
    Result := '';

  // Gera um novo token se ele expirou ou nunca foi gerado
  if Result.Trim.IsEmpty then
    Result := GerarNovoTokenAcesso;
end;

function TMigLoginOauth.GetTokenAcesso(ARefreshValido: Boolean; ATokenRefresh: String): String;
var
  obComm: TMigComm;
  RecJson: String;
  obJson: TJSONObject;
begin
  obComm := TMigComm.Create;
  try
    if ARefreshValido then
      obComm.DocJson := '{"refreshToken": "' + ATokenRefresh + '"}'
    else
      obComm.DocJson := '{"token": "' + ATokenRefresh + '"}';

    obComm.UrlAdicional := EmptyStr;
    obComm.TipoRequisicao := TTipoRequisicao.trAutenticacao;

    RecJson := obComm.Enviar;

    obJson := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(RecJson), 0) as TJSONObject;

    if obJson = nil then
      raise Exception.Create('Não foi possível formatar o retorno com o token de acesso!');

    GravaCfg(T2.qSepeCfg, 'CFG_TOKDTA', DateTimeToStr(IncHour(UnixToDateTime(Ivl(obJson.GetValue('accessTokenExpireAt').Value)), -3)));
    GravaCfg(T2.qSepeCfg, 'CFG_TOKULT', Nst(obJson.GetValue('accessToken').Value));

    GravaCfg(T2.qSepeCfg, 'CFG_TOKRFD', DateTimeToStr(IncHour(UnixToDateTime(Ivl(obJson.GetValue('refreshTokenExpireAt').Value)), -3)));
    GravaCfg(T2.qSepeCfg, 'CFG_TOKREF', Nst(obJson.GetValue('refreshToken').Value));

    Result := Nst(obJson.GetValue('accessToken').Value);
  finally
    obComm.Free;
  end;
end;

end.
