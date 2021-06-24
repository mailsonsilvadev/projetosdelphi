unit U_UteisWeb;

interface

uses SysUtils, Windows, Forms;

// Transforma um arquivo JSON em um texto
function JsonToString(CaminhoArqJson: String): String;
function StrYmdToDate(DataYmd: string): TDateTime;
function StrYmdToDateTime(DataYmd: string): TDateTime;

procedure GerarArqIniSinc;
procedure DeletarArqIniSinc;
function TemArqIniSinc: Boolean;

procedure GerarArqFimImportacao;
procedure DeletarArqFimImportacao;
function TemArqFimImportacao: Boolean;
function RemoverCharInvalidos(_Str: String): String;

implementation

uses U_SisProc, Conexao;

Const
  ArqInicioSinc = 'Sinc\ArqInicioSincronizacao.snc';
  ArqFimImportacao = 'Sinc\ArqFimImportacao.snc';

function JsonToString(CaminhoArqJson: String): String;
var
  ArqTxt: TextFile;
  TextoJson, LinhaJson: String;
begin
  Result := '';

  if not FileExists(CaminhoArqJson) then
    Exit;

  TextoJson := '';
  AssignFile(ArqTxt, CaminhoArqJson);
  Try
    Reset(ArqTxt);
    while not Eof(ArqTxt) do
    begin
      Read(ArqTxt, LinhaJson);
      TextoJson := TextoJson + LinhaJson;
    end;
  Finally
    CloseFile(ArqTxt);
  End;

  Result := TextoJson;
end;

function StrYmdToDate(DataYmd: string): TDateTime;
var
  FormatoData: TFormatSettings;
begin
  try
    FormatoData.ShortDateFormat := 'yyyy-mm-dd';
    FormatoData.DateSeparator := '-';

    Result := StrToDate(DataYmd, FormatoData);
  except
    Result := 0;
  end;
end;

function StrYmdToDateTime(DataYmd: string): TDateTime;
var
  FormatoData: TFormatSettings;
begin
  try
    FormatoData.ShortDateFormat := 'yyyy-mm-dd';
    FormatoData.DateSeparator := '-';
    FormatoData.ShortTimeFormat := 'hh:nn:ss';
    FormatoData.TimeSeparator := ':';

    Result := StrToDateTime(DataYmd, FormatoData);
  except
    Result := 0;
  end;
end;

procedure GerarArqIniSinc;
begin
  DeletarArqIniSinc;
  GravaLog(ExtractFilePath(Application.ExeName) + ArqInicioSinc, GetUsuario + ' ' + FormatDateTime('dd/mm/yyyy hh:mm:ss', now));
end;

procedure DeletarArqIniSinc;
begin
  if FileExists(ExtractFilePath(Application.ExeName) + ArqInicioSinc) then
    DeleteFile(PWideChar(ExtractFilePath(Application.ExeName) + ArqInicioSinc));

  DeletarArqFimImportacao;
end;

function TemArqIniSinc: Boolean;
begin
  Result := FileExists(ExtractFilePath(Application.ExeName) + ArqInicioSinc);
end;

procedure GerarArqFimImportacao;
begin
  DeletarArqFimImportacao;
  GravaLog(ExtractFilePath(Application.ExeName) + ArqFimImportacao, FormatDateTime('dd/mm/yyyy hh:mm:ss', now));
end;

procedure DeletarArqFimImportacao;
begin
  if FileExists(ExtractFilePath(Application.ExeName) + ArqFimImportacao) then
    DeleteFile(PWideChar(ExtractFilePath(Application.ExeName) + ArqFimImportacao));
end;

function TemArqFimImportacao: Boolean;
begin
  Result := FileExists(ExtractFilePath(Application.ExeName) + ArqFimImportacao);
end;

// substitue char que poder gerar problemas na montagem do JSON por espacos em branco
function RemoverCharInvalidos(_Str: String): String;
begin
  _Str := Strtran(_Str, '\', ' ');
  _Str := Strtran(_Str, '/', ' ');
  _Str := Strtran(_Str, '"', ' ');
  _Str := Strtran(_Str, '''', ' ');

  Result := _Str;
end;


end.
