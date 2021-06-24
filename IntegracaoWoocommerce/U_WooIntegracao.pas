unit U_WooIntegracao;

interface

uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, IdHTTP, IdMultipartFormData,
  Menus, ExtCtrls, ComCtrls, U_Sisproc, stdctrls, Variants, System.Actions, CParametrosBDIni, Conexao;

type
  TWooRegistro = (wrNenhum, wrProduto, wrCliente, wrPedido, wrVariacao);

type
  TWooIntegracao = class(TObject)
  private
    FDados: String;
    FRegistro: TWooRegistro;
    FSenha: String;
    FHost: String;
    FUsuario: String;
    FWebService: String;
    FIDN1: Integer;
    FIdN2: Integer;
    FSku: String;
    procedure SetDados(const Value: String);
    procedure SetHost(const Value: String);
    procedure SetRegistro(const Value: TWooRegistro);
    procedure SetSenha(const Value: String);
    procedure SetUsuario(const Value: String);
    procedure SetWebService(const Value: String);
    procedure SetIDN1(const Value: Integer);
    procedure SetIdN2(const Value: Integer);
    procedure SetSku(const Value: String);
    function GetDelimitador: String;

  public
    property WebService: String read FWebService write SetWebService;
    property Host: String read FHost write SetHost;
    property Usuario: String read FUsuario write SetUsuario;
    property Senha: String read FSenha write SetSenha;
    property Registro: TWooRegistro read FRegistro write SetRegistro;
    property Dados: String read FDados write SetDados;
    property IDN1: Integer read FIDN1 write SetIDN1;
    property IdN2: Integer read FIdN2 write SetIdN2;
    property Sku: String read FSku write SetSku;

    function Post: Integer;
    function GetWs: String;
    function Delete: String;
    function GetJsonWs: TStrings;
  end;

implementation

uses U_T2;

{ TWooIntegracao }

function TWooIntegracao.Delete: String;
var
  Params: TStringList;
  FIdHTTP: TIdHTTP;
  Arquivo: TIdMultipartFormDataStream;
  Response: TStringStream;
  Versao, ObjetoTxt, Parametros: string;
  Txt: TextFile;
  obConfig: TParametrosBDIni;
begin
  Result := EmptyStr;

  if (FIDN1 = 0) or (FIdN2 = 0) then
    Exit;

  FIdHTTP := TIdHTTP.Create(T2);
  Params := TStringList.Create;
  Arquivo := TIdMultipartFormDataStream.Create;
  Response := TStringStream.Create('');
  obConfig := TParametrosBDIni.Create;
  try
    FIdHTTP.Request.CustomHeaders.Clear;
    FIdHTTP.Request.Clear;

    Arquivo.AddFormField('host', FHost);
    Arquivo.AddFormField('usuario', FUsuario);
    Arquivo.AddFormField('senha', FSenha);

    case FRegistro of
      wrProduto:
        ObjetoTxt := 'products';
      wrCliente:
        ObjetoTxt := 'custumers';
      wrPedido:
        ObjetoTxt := 'orders';
      wrVariacao:
        ObjetoTxt := 'products/' + IntToStr(IDN1) + '/variations'
    else
      ObjetoTxt := '';
    end;

    if (FRegistro <> wrVariacao) then
      ObjetoTxt := ObjetoTxt + '/' + IntToStr(IDN1)
    else
      ObjetoTxt := ObjetoTxt + '/' + IntToStr(IdN2);

    Parametros := 'metodo=delete&objeto=' + ObjetoTxt + '&host=' + FHost + '&usuario=' + FUsuario + '&senha=' + FSenha;

    FIdHTTP.ReadTimeout := 180000; // foi alterado para evitar erro de time out quando há gargalos no servidor do demander pois, a média de resposta estava ficando alta
    //FIdHTTP.Request.ContentEncoding := 'multipart/form-data';
    FIdHTTP.Request.Charset := 'utf-8';
    FIdHTTP.Request.Referer := FWebService;
    FIdHTTP.Get(FWebService + '?' + Parametros, Response);

    try
      Result := Response.DataString;
    except
      Raise Exception.Create(Response.DataString);
    end;
  finally
    Response.Free;
    Params.Free;
    FIdHTTP.Free;
    Arquivo.Free;
    obConfig.Free;
  end;
end;

function TWooIntegracao.GetDelimitador: String;
begin
  Result := '*|*';
end;

function TWooIntegracao.GetJsonWs: TStrings;
var
  FIdHTTP: TIdHTTP;
  Arquivo: TIdMultipartFormDataStream;
  Response: TStringStream;
  Versao, ObjetoTxt, Parametros: string;
  Txt: TextFile;
  obConfig: TParametrosBDIni;
begin
  FIdHTTP := TIdHTTP.Create(T2);
  Arquivo := TIdMultipartFormDataStream.Create;
  Response := TStringStream.Create('');
  obConfig := TParametrosBDIni.Create;
  try
    FIdHTTP.Request.CustomHeaders.Clear;
    FIdHTTP.Request.Clear;

    Arquivo.AddFormField('host', FHost);
    Arquivo.AddFormField('usuario', FUsuario);
    Arquivo.AddFormField('senha', FSenha);

    case FRegistro of
      wrProduto:
        ObjetoTxt := 'produto';
      wrCliente:
        ObjetoTxt := 'cliente';
      wrPedido:
        ObjetoTxt := 'pedido';
    else
      ObjetoTxt := '';
    end;

    Parametros := 'metodo=getjson&objeto=' + ObjetoTxt + '&host=' + FHost + '&usuario=' + FUsuario + '&senha=' + FSenha + '&empresa=' + LimpaNumero(BuscaEmpresa(T2.qC1, 'CGCMF'));

    FIdHTTP.ReadTimeout := 180000; // foi alterado para evitar erro de time out quando há gargalos no servidor do demander pois, a média de resposta estava ficando alta
    FIdHTTP.Request.Charset := 'utf-8';
    FIdHTTP.Request.Referer := FWebService;
    FIdHTTP.Get(FWebService + '?' + Parametros, Response);

    try
      Result := TStringList(Explode(Response.DataString, GetDelimitador));
    except
      Raise Exception.Create(Response.DataString);
    end;
  finally
    Response.Free;
    FIdHTTP.Free;
    Arquivo.Free;
    obConfig.Free;
  end;
end;

function TWooIntegracao.GetWs: String;
var
  Params: TStringList;
  FIdHTTP: TIdHTTP;
  Arquivo: TIdMultipartFormDataStream;
  Response: TStringStream;
  Versao, ObjetoTxt, Parametros: string;
  Txt: TextFile;
  obConfig: TParametrosBDIni;
begin
  Result := EmptyStr;

  { AArquivo := ExtractFilePath(Application.ExeName) + '\Temp';
    VerificaCriaPasta(AArquivo);
    AArquivo := AArquivo + '\' + Conexao.GetUsuario + '_' + FormatDateTime('ddmmyyyyhhnnss', Date) + '.json';
    if FileExists(AArquivo) then
    DeleteFile(AArquivo);

    try
    AssignFile(Txt, AArquivo);
    ReWrite(Txt);
    Write(Txt, FDados);
    finally
    Flush(Txt);
    CloseFile(Txt);
    end; }

  FIdHTTP := TIdHTTP.Create(T2);
  Params := TStringList.Create;
  Arquivo := TIdMultipartFormDataStream.Create;
  Response := TStringStream.Create('');
  obConfig := TParametrosBDIni.Create;
  try
    FIdHTTP.Request.CustomHeaders.Clear;
    FIdHTTP.Request.Clear;

    Arquivo.AddFormField('host', FHost);
    Arquivo.AddFormField('usuario', FUsuario);
    Arquivo.AddFormField('senha', FSenha);

    case FRegistro of
      wrProduto:
        ObjetoTxt := 'products';
      wrCliente:
        ObjetoTxt := 'custumers';
      wrPedido:
        ObjetoTxt := 'orders';
      wrVariacao:
        ObjetoTxt := 'products/' + IntToStr(IDN1) + '/variations'
    else
      ObjetoTxt := '';
    end;

    if (IDN1 > 0) and (FRegistro <> wrVariacao) then
      ObjetoTxt := ObjetoTxt + '/' + IntToStr(IDN1);

    Parametros := 'metodo=get&objeto=' + ObjetoTxt + '&host=' + FHost + '&usuario=' + FUsuario + '&senha=' + FSenha;

    //Consulta por código
    if not FSku.IsEmpty then
      Parametros := 'sku=' + FSku + '&' + Parametros;

    FIdHTTP.ReadTimeout := 180000; // foi alterado para evitar erro de time out quando há gargalos no servidor do demander pois, a média de resposta estava ficando alta
    //FIdHTTP.Request.ContentEncoding := 'multipart/form-data';
    FIdHTTP.Request.Charset := 'utf-8';
    FIdHTTP.Request.Referer := FWebService;
    FIdHTTP.Get(FWebService + '?' + Parametros, Response);

    try
      Result := Response.DataString;
    except
      Raise Exception.Create(Response.DataString);
    end;
  finally
    Response.Free;
    Params.Free;
    FIdHTTP.Free;
    Arquivo.Free;
    obConfig.Free;
  end;
end;

function TWooIntegracao.Post: Integer;
var
  Params: TStringList;
  FIdHTTP: TIdHTTP;
  Arquivo: TIdMultipartFormDataStream;
  Response: TStringStream;
  AArquivo, Versao, ObjetoTxt, Parametros: string;
  Txt: TextFile;
  obConfig: TParametrosBDIni;
  Metodo: string;
begin
  Result := 0;
  if FDados = '' then
    Exit;

  AArquivo := ExtractFilePath(Application.ExeName) + '\Temp';
  VerificaCriaPasta(AArquivo);
  AArquivo := AArquivo + '\' + Conexao.GetUsuario + '_' + FormatDateTime('ddmmyyyyhhnnss', Date)  + '.json';
  if FileExists(AArquivo) then
    DeleteFile(AArquivo);

  try
    AssignFile(Txt, AArquivo);
    ReWrite(Txt);
    Write(Txt, FDados);
  finally
    Flush(Txt);
    CloseFile(Txt);
  end;

  FIdHTTP := TIdHTTP.Create(T2);
  Params := TStringList.Create;
  Response := TStringStream.Create('');
  Arquivo := TIdMultipartFormDataStream.Create;
  obConfig := TParametrosBDIni.Create;
  try
    FIdHTTP.Request.CustomHeaders.Clear;
    FIdHTTP.Request.Clear;

    Arquivo.AddFile('arquivo', AArquivo, 'application/json');
    Arquivo.AddFormField('host', FHost);
    Arquivo.AddFormField('usuario', FUsuario);
    Arquivo.AddFormField('senha', FSenha);

    case FRegistro of
      wrProduto:
        ObjetoTxt := 'products';
      wrCliente:
        ObjetoTxt := 'custumers';
      wrPedido:
        ObjetoTxt := 'orders';
      wrVariacao:
        ObjetoTxt := 'products/' + IntToStr(IDN1) + '/variations'
    else
      ObjetoTxt := '';
    end;

    Metodo := 'post';
    if (IDN1 > 0) and (FRegistro <> wrVariacao) then
    begin
      //Se tem o id inicial então é uma alteração
      Metodo := 'put';
      ObjetoTxt := ObjetoTxt + '/' + IntToStr(IDN1)
    end
    else if (IdN2 > 0) and (FRegistro = wrVariacao) then
      ObjetoTxt := ObjetoTxt + '/' + IntToStr(IdN2);

    Parametros := 'metodo=' + Metodo + '&objeto=' + ObjetoTxt + '&host=' + FHost + '&usuario=' + FUsuario + '&senha=' + FSenha;

    FIdHTTP.ReadTimeout := 180000; // foi alterado para evitar erro de time out quando há gargalos no servidor do demander pois, a média de resposta estava ficando alta
    FIdHTTP.Request.ContentEncoding := 'multipart/form-data';
    FIdHTTP.Request.Charset := 'utf-8';
    FIdHTTP.Request.Referer := FWebService;
    FIdHTTP.Post(FWebService + '?' + Parametros, AArquivo, Response);

    try
      Result := StrToInt(Response.DataString);
    except
      Raise Exception.Create(Response.DataString);
    end;

  finally
    Response.Free;
    Params.Free;
    FIdHTTP.Free;
    Arquivo.Free;
    obConfig.Free;
  end;
end;

procedure TWooIntegracao.SetDados(const Value: String);
begin
  FDados := Value;
end;

procedure TWooIntegracao.SetHost(const Value: String);
begin
  FHost := Value;
end;

procedure TWooIntegracao.SetIDN1(const Value: Integer);
begin
  FIDN1 := Value;
end;

procedure TWooIntegracao.SetIdN2(const Value: Integer);
begin
  FIdN2 := Value;
end;

procedure TWooIntegracao.SetRegistro(const Value: TWooRegistro);
begin
  FRegistro := Value;
end;

procedure TWooIntegracao.SetSenha(const Value: String);
begin
  FSenha := Value;
end;

procedure TWooIntegracao.SetSku(const Value: String);
begin
  FSku := Value;
end;

procedure TWooIntegracao.SetUsuario(const Value: String);
begin
  FUsuario := Value;
end;

procedure TWooIntegracao.SetWebService(const Value: String);
begin
  FWebService := Value;
end;

end.
