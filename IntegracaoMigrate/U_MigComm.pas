unit U_MigComm;

interface

uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ExtCtrls, ComCtrls, U_Sisproc, stdctrls, Variants, System.Actions, IdHTTP, IdSSLOpenSSL, IdSSLOpenSSLHeaders;

type
  TTipoRequisicao = (trIndefinido, trConsulta, trEnvio, trInutilizacao, trAutenticacao, trEvento);

  TMigComm = class(TObject)
  private
    FDocJson: String;
    FAccessToken: String;
    FTipoRequisicao: TTipoRequisicao;
    FUrlAdicional: String;
    function GetLogJson: String;
    procedure SetDocJson(const Value: String);
    procedure SetTipoRequisicao(const Value: TTipoRequisicao);
    procedure SetUrlAdicional(const Value: String);
    function GetToken: String;
  public
    constructor Create;

    property DocJson: String read FDocJson write SetDocJson;
    property AccessToken: String read FAccessToken;
    property UrlAdicional: String read FUrlAdicional write SetUrlAdicional;
    property TipoRequisicao: TTipoRequisicao read FTipoRequisicao write SetTipoRequisicao;

    function Enviar: String;
  end;

implementation

uses U_T2, U_MigLoginOauth;

{ TMigComm }

constructor TMigComm.Create;
begin
  FDocJson := EmptyStr;
  FAccessToken := EmptyStr;
  FUrlAdicional := EmptyStr;
  FTipoRequisicao := TTipoRequisicao.trIndefinido;
end;

function TMigComm.Enviar: String;
var
  URL, ArqLogJson: String;

  IdHTTP: TIdHTTP;
  Response, JsonToSend: TStringStream;
  IdSSLIOHandlerSocket1: TIdSSLIOHandlerSocketOpenSSL;
begin
  ArqLogJson := GetLogJson;

  if Ivl(BuscaCFG2(T2.qgSepeCfg, 'SepeCFG', 'CFG_NFSAMB', 'NFSe -> Ambiente 1-Produção / 2-Homologação', '1', 1, 1)) = 1 then
    URL := 'https://apibr.invoicy.com.br'
  else
    URL := 'https://apibrhomolog.invoicy.com.br';

  case TipoRequisicao of
    trIndefinido:
      raise exception.Create('Tipo de requisição não informado!');
    trConsulta:
      URL := URL + '/senddocuments/nfse?type=Consulta' + FUrlAdicional;
    trEnvio:
      URL := URL + '/senddocuments/nfse?type=Emissao' + FUrlAdicional;
    trInutilizacao:
      URL := URL + '/senddocuments/nfse?type=Inutilizacao' + FUrlAdicional;
    trAutenticacao:
      URL := URL + '/oauth2/invoicy/auth' + FUrlAdicional;
    trEvento:
      URL := URL + '/senddocuments/nfse?type=Evento' + FUrlAdicional;
  end;

  Result := EmptyStr;
  try
    try
      if (ArqLogJson <> '') and (not FDocJson.Trim.IsEmpty) then
      begin
        GravaLog(ArqLogJson, '==============' + TimeToStr(Now) + '================');
        GravaLog(ArqLogJson, URL);
        GravaLog(ArqLogJson, 'Envio: ' + FDocJson);
      end;

      if TipoRequisicao <> TTipoRequisicao.trAutenticacao then
      begin
        //Por algum motivo desconhecido, as vezes ocorria erro de SSL no primeiro processamento do dia, porque ele tentava buscar um novo token e
        //gerava erro. Por isso foi adicionado um sleep
        Sleep(1000);
        FAccessToken := GetToken;
        if FAccessToken.Trim.IsEmpty then
          raise Exception.Create('Erro ao gerar token de acesso!');
      end
      else
        FAccessToken := EmptyStr;

      IdHTTP := TIdHTTP.Create(T2);
      IdSSLIOHandlerSocket1 := TIdSSLIOHandlerSocketOpenSSL.Create(T2);

      Response := TStringStream.Create();

      if not FDocJson.Trim.IsEmpty then
      begin
        JsonToSend := TStringStream.Create(UTF8Encode(Remove_Acentos(Strtran(Strtran(Strtran(FDocJson, #10, ' '), #13, ' '), sLineBreak, ' '))));
        JsonToSend.Position := 0;
      end;

      IdHTTP.IOHandler := IdSSLIOHandlerSocket1;
      IdSSLIOHandlerSocket1.SSLOptions.Method := sslvTLSv1_2;

      IdHTTP.Request.CustomHeaders.Clear;
      IdHTTP.Request.Clear;
      IdHTTP.ReadTimeout := 60000;
      IdHTTP.Request.ContentType := 'application/json';
      // IdHTTP.Request.AcceptCharSet := 'utf-8';
      // IdHTTP.Request.Accept := 'application/json, text/javascript, */*; q=0.01';
      // IdHTTP.Request.ContentEncoding := 'utf-8';
      // IdHTTP.Request.CharSet := 'utf-8';
      // IdHTTP.Request.UserAgent := 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36';

      if not FAccessToken.Trim.IsEmpty then
        IdHTTP.Request.CustomHeaders.Add('Authorization: Bearer ' + FAccessToken);

      IdHTTP.Response.ContentType := 'application/json';
      // IdHTTP.Response.CharSet := 'UTF-8';

      if FTipoRequisicao = TTipoRequisicao.trIndefinido then
        raise exception.Create('Tipo de requisição não informado!')
      else if FTipoRequisicao = TTipoRequisicao.trConsulta then
      begin
        //Sem o sleep estava ocorrendo erro de SSL, deve ser algum bug do Indy 10 que é um Indy antigo, porém é o que tem para o XE5
        Sleep(1000);
        IdHTTP.Get(URL, Response);
        Result := Response.DataString;
      end
      else
      begin
        //Sem o sleep estava ocorrendo erro de SSL, deve ser algum bug do Indy 10 que é um Indy antigo, porém é o que tem para o XE5
        Sleep(1000);
        Result := IdHTTP.Post(URL, JsonToSend);
      end;

      if not Result.Trim.IsEmpty then
      begin
        GravaLog(ArqLogJson, 'Recebido: ' + Result);
      end;
    Except
      on E: EIdHTTPProtocolException do
        raise exception.Create(TEncoding.Unicode.GetString(TEncoding.Unicode.GetBytes(E.ErrorMessage)));
      on E: Exception do
        raise exception.Create(E.Message)
      else
      begin
        raise exception.Create('Erro desconhecido ao tentar conexão SSL!');
      end;
    End;
  finally
    JsonToSend.Free;
    Response.Free;
    IdHTTP.Free;
  end;
end;

function TMigComm.GetLogJson: String;
begin
  Result := '';
  Result := ExtractFilePath(Application.ExeName) + 'Log\';
  VerificaCriaPasta(Result);
  Result := Result + 'LogMigrateJson_' + FormatDateTime('yyyy_mm_dd', Date) + '.txt';
end;

function TMigComm.GetToken: String;
var
  obLogin: TMigLoginOauth;
begin
  obLogin := TMigLoginOauth.Create();
  try
    Result := obLogin.GetAccessToken;
  finally
    obLogin.Free;
  end;
end;

procedure TMigComm.SetDocJson(const Value: String);
begin
  FDocJson := Value;
end;

procedure TMigComm.SetTipoRequisicao(const Value: TTipoRequisicao);
begin
  FTipoRequisicao := Value;
end;

procedure TMigComm.SetUrlAdicional(const Value: String);
begin
  FUrlAdicional := Value;
end;

end.
