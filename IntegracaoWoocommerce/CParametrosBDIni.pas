unit CParametrosBDIni;

interface

uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ExtCtrls, ComCtrls, U_Sisproc, stdctrls, Variants, System.Actions, IniFiles;

type
  TPropEnveio = class(TObject)
  private
    FDirEnviados: String;
    FDirNaoEnviados: String;
    FWeService: String;
    FTitulos: String;
    FSenha: String;
    FUsuario: String;
    procedure SetDirEnviados(const Value: String);
    procedure SetDirNaoEnviados(const Value: String);
    procedure SetTitulos(const Value: String);
    procedure SetWeService(const Value: String);
    procedure SetSenha(const Value: String);
    procedure SetUsuario(const Value: String);
  public
    property DirNaoEnviados: String read FDirNaoEnviados write SetDirNaoEnviados;
    property DirEnviados: String read FDirEnviados write SetDirEnviados;
    property WeService: String read FWeService write SetWeService;
    property Usuario: String read FUsuario write SetUsuario;
    property Senha: String read FSenha write SetSenha;
    property Titulos: String read FTitulos write SetTitulos;
  end;

  TPropRecebimento = class(TObject)
  private
    FDirProcess: String;
    FWebService: String;
    FDataUltimo: TDateTime;
    FDirNaoProcess: String;
    FIdUltimo: String;
    procedure SetDataUltimo(const Value: TDateTime);
    procedure SetDirNaoProcess(const Value: String);
    procedure SetDirProcess(const Value: String);
    procedure SetIdUltimo(const Value: String);
    procedure SetWebService(const Value: String);
  public
    property IdUltimo: String read FIdUltimo write SetIdUltimo;
    property DataUltimo: TDateTime read FDataUltimo write SetDataUltimo;
    property DirNaoProcess: String read FDirNaoProcess write SetDirNaoProcess;
    property DirProcess: String read FDirProcess write SetDirProcess;
    property WebService: String read FWebService write SetWebService;
  end;

  TPropIntegracao = class(TObject)
  private
    FArquivoIni: String;
    FIntervalo: String;
    FToken: String;
    FHoraFim: String;
    FHoraInicio: String;
    procedure SetArquivoIni(const Value: String);
    procedure SetIntervalo(const Value: String);
    procedure SetToken(const Value: String);
    procedure SetHoraFim(const Value: String);
    procedure SetHoraInicio(const Value: String);
  public
    property ArquivoIni: String read FArquivoIni write SetArquivoIni;
    property Intervalo: String read FIntervalo write SetIntervalo;
    property HoraInicio: String read FHoraInicio write SetHoraInicio;
    property HoraFim: String read FHoraFim write SetHoraFim;
    property Token: String read FToken write SetToken;
  end;

  TPropConexao = class(TObject)
  private
    FErroFile: String;
    FTrimChar: String;
    FDriver: String;
    FLocalCode: String;
    FCommitRetain: String;
    FTransIsolation: String;
    FCharSet: String;
    FWaitLocks: String;
    FBlobSize: String;
    FRole: String;
    FDialect: String;
    FSenha: String;
    FBase: String;
    FUsuario: String;
    procedure SetBlobSize(const Value: String);
    procedure SetCharSet(const Value: String);
    procedure SetCommitRetain(const Value: String);
    procedure SetDialect(const Value: String);
    procedure SetDriver(const Value: String);
    procedure SetErroFile(const Value: String);
    procedure SetLocalCode(const Value: String);
    procedure SetRole(const Value: String);
    procedure SetTransIsolation(const Value: String);
    procedure SetTrimChar(const Value: String);
    procedure SetWaitLocks(const Value: String);
    procedure SetBase(const Value: String);
    procedure SetSenha(const Value: String);
    procedure SetUsuario(const Value: String);

  public
    property Usuario: String read FUsuario write SetUsuario;
    property Senha: String read FSenha write SetSenha;
    property Base: String read FBase write SetBase;
    property Driver: String read FDriver write SetDriver;
    property Role: String read FRole write SetRole;
    property CharSet: String read FCharSet write SetCharSet;
    property Dialect: String read FDialect write SetDialect;
    property ErroFile: String read FErroFile write SetErroFile;
    property LocalCode: String read FLocalCode write SetLocalCode;
    property BlobSize: String read FBlobSize write SetBlobSize;
    property CommitRetain: String read FCommitRetain write SetCommitRetain;
    property WaitLocks: String read FWaitLocks write SetWaitLocks;
    property TransIsolation: String read FTransIsolation write SetTransIsolation;
    property TrimChar: String read FTrimChar write SetTrimChar;
  end;

  TParametrosBDIni = class(TObject)
  private
    FConexao: TPropConexao;
    FIntegracao: TPropIntegracao;
    FRecebimento: TPropRecebimento;
    FEnvio: TPropEnveio;
    procedure SetConexao(const Value: TPropConexao);
    procedure SetIntegracao(const Value: TPropIntegracao);
    procedure SetRecebimento(const Value: TPropRecebimento);
    procedure SetEnvio(const Value: TPropEnveio);

  public
    constructor Create();
    procedure Free();

    // Conexão com base de dados
    property Conexao: TPropConexao read FConexao write SetConexao;

    // Integração
    property Integracao: TPropIntegracao read FIntegracao write SetIntegracao;

    // Recebimento
    property Recebimento: TPropRecebimento read FRecebimento write SetRecebimento;

    // Envio
    property Envio: TPropEnveio read FEnvio write SetEnvio;

    function getCaminhoIniDef: String;
    function CarregarConfiguracao: Boolean;
    function SalvarConfiguracao: Boolean;
  end;

implementation

{ TParametrosBDIni }

function TParametrosBDIni.CarregarConfiguracao: Boolean;
var
  Ini: TIniFile;
begin
  Result := False;

  if FIntegracao.ArquivoIni.IsEmpty then
    FIntegracao.ArquivoIni := Self.getCaminhoIniDef;
  Ini := TIniFile.Create(FIntegracao.ArquivoIni);

  try
    FConexao.Driver := Ini.ReadString('CONEXAO', 'DriverName', 'Firebird');
    FConexao.Role := Ini.ReadString('CONEXAO', 'RoleName', '');
    FConexao.CharSet := Ini.ReadString('CONEXAO', 'ServerCharSet', '');
    FConexao.Dialect := Ini.ReadString('CONEXAO', 'SQLDialect', '3');
    FConexao.ErroFile := Ini.ReadString('CONEXAO', 'ErrorResourceFile', '');
    FConexao.LocalCode := Ini.ReadString('CONEXAO', 'LocaleCode', '0000');
    FConexao.BlobSize := Ini.ReadString('CONEXAO', 'BlobSize', '-1');
    FConexao.CommitRetain := Ini.ReadString('CONEXAO', 'CommitRetain', 'False');
    FConexao.WaitLocks := Ini.ReadString('CONEXAO', 'WaitOnLocks', 'True');
    FConexao.TrimChar := Ini.ReadString('CONEXAO', 'Trim Char', 'False');

    FConexao.Usuario := Ini.ReadString('CONEXAO', 'User_Name', '');
    FConexao.Senha := DescriptaSenha(Ini.ReadString('CONEXAO', 'Password', ''));
    FConexao.Base := Ini.ReadString('CONEXAO', 'Database', '');

    FIntegracao.Intervalo := Ini.ReadString('INTEGRACAO', 'Intervalo', '00:30:00');
    FIntegracao.HoraInicio := Ini.ReadString('INTEGRACAO', 'HoraInicio', '07:30:00');
    FIntegracao.HoraFim := Ini.ReadString('INTEGRACAO', 'HoraFim', '18:30:00');
    FIntegracao.Token := Ini.ReadString('INTEGRACAO', 'Token', '');

    FRecebimento.DirNaoProcess := Ini.ReadString('INTEGRACAO', 'NProcess', '');
    FRecebimento.DirProcess := Ini.ReadString('INTEGRACAO', 'Process', '');
    FRecebimento.WebService := Ini.ReadString('INTEGRACAO', 'WebImp', '');
    FRecebimento.IdUltimo := Ini.ReadString('INTEGRACAO', 'Identificador', '');

    FEnvio.DirNaoEnviados := Ini.ReadString('INTEGRACAO', 'NEnviados', '');
    FEnvio.DirEnviados := Ini.ReadString('INTEGRACAO', 'Enviados', '');
    FEnvio.WeService := Ini.ReadString('INTEGRACAO', 'WebExp', '');
    FEnvio.Usuario := Ini.ReadString('INTEGRACAO', 'Usuario', '');
    FEnvio.Senha := Ini.ReadString('INTEGRACAO', 'Senha', '');

    FRecebimento.DataUltimo := StrToDateTimeDef(Ini.ReadString('INTEGRACAO', 'UltimaImp', ''), 0);

    FEnvio.Titulos := Ini.ReadString('INTEGRACAO', 'Titulos', 'N');

    Result := True;
  finally
    Ini.Free;
  end;
end;

constructor TParametrosBDIni.Create;
begin
  inherited Create;
  FConexao := TPropConexao.Create;
  FIntegracao := TPropIntegracao.Create;
  FRecebimento := TPropRecebimento.Create;
  FEnvio := TPropEnveio.Create;
end;

procedure TParametrosBDIni.Free;
begin
  inherited Free;
  FConexao.Free;
  FIntegracao.Free;
  FRecebimento.Free;
  FEnvio.Free;
end;

function TParametrosBDIni.getCaminhoIniDef: String;
begin
  Result := ExtractFilePath(Application.ExeName) + 'SepeWoo.ini';
end;

function TParametrosBDIni.SalvarConfiguracao: Boolean;
var
  Ini: TIniFile;
begin
  Result := False;

  if FIntegracao.ArquivoIni.IsEmpty then
    FIntegracao.ArquivoIni := Self.getCaminhoIniDef;

  Ini := TIniFile.Create(FIntegracao.ArquivoIni);
  try
    // Cria a configuração padrão
    Ini.WriteString('CONEXAO', 'DriverName', FConexao.Driver);
    Ini.WriteString('CONEXAO', 'RoleName', FConexao.Role);
    Ini.WriteString('CONEXAO', 'ServerCharSet', FConexao.CharSet);
    Ini.WriteString('CONEXAO', 'SQLDialect', FConexao.Dialect);
    Ini.WriteString('CONEXAO', 'ErrorResourceFile', FConexao.ErroFile);
    Ini.WriteString('CONEXAO', 'LocaleCode', FConexao.LocalCode);
    Ini.WriteString('CONEXAO', 'BlobSize', FConexao.BlobSize);
    Ini.WriteString('CONEXAO', 'CommitRetain', FConexao.CommitRetain);
    Ini.WriteString('CONEXAO', 'WaitOnLocks', FConexao.WaitLocks);
    Ini.WriteString('CONEXAO', 'Trim Char', FConexao.TrimChar);

    Ini.WriteString('CONEXAO', 'Database', FConexao.Base);
    Ini.WriteString('CONEXAO', 'User_Name', FConexao.Usuario);
    Ini.WriteString('CONEXAO', 'Password', EncriptaSenha(FConexao.Senha));

    Ini.WriteString('INTEGRACAO', 'Intervalo', FIntegracao.Intervalo);
    Ini.WriteString('INTEGRACAO', 'HoraInicio', FIntegracao.HoraInicio);
    Ini.WriteString('INTEGRACAO', 'HoraFim', FIntegracao.HoraFim);
    Ini.WriteString('INTEGRACAO', 'Token', FIntegracao.Token);

    Ini.WriteString('INTEGRACAO', 'NProcess', FRecebimento.DirNaoProcess);
    Ini.WriteString('INTEGRACAO', 'Process', FRecebimento.DirProcess);
    Ini.WriteString('INTEGRACAO', 'WebImp', FRecebimento.WebService);
    Ini.WriteString('INTEGRACAO', 'UltimaImp', FormatDateTime('dd/mm/yyyy hh:nn:ss', FRecebimento.DataUltimo));
    Ini.WriteString('INTEGRACAO', 'Identificador', FRecebimento.IdUltimo);
    Ini.WriteString('INTEGRACAO', 'NEnviados', FEnvio.DirNaoEnviados);
    Ini.WriteString('INTEGRACAO', 'Enviados', FEnvio.DirEnviados);
    Ini.WriteString('INTEGRACAO', 'WebExp', FEnvio.WeService);
    Ini.WriteString('INTEGRACAO', 'Usuario', FEnvio.Usuario);
    Ini.WriteString('INTEGRACAO', 'Senha', FEnvio.Senha);
    Ini.WriteString('INTEGRACAO', 'Titulos', FEnvio.Titulos);
  finally
    Ini.Free;
  end;

  Result := True;
end;

procedure TParametrosBDIni.SetConexao(const Value: TPropConexao);
begin
  FConexao := Value;
end;

procedure TParametrosBDIni.SetEnvio(const Value: TPropEnveio);
begin
  FEnvio := Value;
end;

procedure TParametrosBDIni.SetIntegracao(const Value: TPropIntegracao);
begin
  FIntegracao := Value;
end;

procedure TParametrosBDIni.SetRecebimento(const Value: TPropRecebimento);
begin
  FRecebimento := Value;
end;

{ TPropConexao }

procedure TPropConexao.SetBase(const Value: String);
begin
  FBase := Value;
end;

procedure TPropConexao.SetBlobSize(const Value: String);
begin
  FBlobSize := Value;
end;

procedure TPropConexao.SetCharSet(const Value: String);
begin
  FCharSet := Value;
end;

procedure TPropConexao.SetCommitRetain(const Value: String);
begin
  FCommitRetain := Value;
end;

procedure TPropConexao.SetDialect(const Value: String);
begin
  FDialect := Value;
end;

procedure TPropConexao.SetDriver(const Value: String);
begin
  FDriver := Value;
end;

procedure TPropConexao.SetErroFile(const Value: String);
begin
  FErroFile := Value;
end;

procedure TPropConexao.SetLocalCode(const Value: String);
begin
  FLocalCode := Value;
end;

procedure TPropConexao.SetRole(const Value: String);
begin
  FRole := Value;
end;

procedure TPropConexao.SetSenha(const Value: String);
begin
  FSenha := Value;
end;

procedure TPropConexao.SetTransIsolation(const Value: String);
begin
  FTransIsolation := Value;
end;

procedure TPropConexao.SetTrimChar(const Value: String);
begin
  FTrimChar := Value;
end;

procedure TPropConexao.SetUsuario(const Value: String);
begin
  FUsuario := Value;
end;

procedure TPropConexao.SetWaitLocks(const Value: String);
begin
  FWaitLocks := Value;
end;

{ TPropIntegracao }

procedure TPropIntegracao.SetArquivoIni(const Value: String);
begin
  FArquivoIni := Value;
end;

procedure TPropIntegracao.SetHoraFim(const Value: String);
begin
  FHoraFim := Value;
end;

procedure TPropIntegracao.SetHoraInicio(const Value: String);
begin
  FHoraInicio := Value;
end;

procedure TPropIntegracao.SetIntervalo(const Value: String);
begin
  FIntervalo := Value;
end;

procedure TPropIntegracao.SetToken(const Value: String);
begin
  FToken := Value;
end;

{ TPropRecebimento }

procedure TPropRecebimento.SetDataUltimo(const Value: TDateTime);
begin
  FDataUltimo := Value;
end;

procedure TPropRecebimento.SetDirNaoProcess(const Value: String);
begin
  FDirNaoProcess := Value;
end;

procedure TPropRecebimento.SetDirProcess(const Value: String);
begin
  FDirProcess := Value;
end;

procedure TPropRecebimento.SetIdUltimo(const Value: String);
begin
  FIdUltimo := Value;
end;

procedure TPropRecebimento.SetWebService(const Value: String);
begin
  FWebService := Value;
end;

{ TPropEnveio }

procedure TPropEnveio.SetDirEnviados(const Value: String);
begin
  FDirEnviados := Value;
end;

procedure TPropEnveio.SetDirNaoEnviados(const Value: String);
begin
  FDirNaoEnviados := Value;
end;

procedure TPropEnveio.SetSenha(const Value: String);
begin
  FSenha := Value;
end;

procedure TPropEnveio.SetTitulos(const Value: String);
begin
  FTitulos := Value;
end;

procedure TPropEnveio.SetUsuario(const Value: String);
begin
  FUsuario := Value;
end;

procedure TPropEnveio.SetWeService(const Value: String);
begin
  FWeService := Value;
end;

end.
