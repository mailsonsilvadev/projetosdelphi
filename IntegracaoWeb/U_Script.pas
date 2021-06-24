unit U_Script;

interface

uses SqlExpr, SysUtils;

Type
  TScript = class(TObject)
  private
    { private declarations }
  public
    { public declarations }
    Procedure CriaTabelaLog;
    Procedure CriaTabelasConfig;
    Procedure AtualizarTabelas;
  end;

implementation

uses U_T2, U_SisProc;

Function CampoExisteTabela(NomeTabela, NomeCampo: String): Boolean;
begin
  Result := SetKeyDl(T2.qC1, 'RDB$RELATION_FIELDS',
    ['RDB$RELATION_NAME', 'RDB$FIELD_NAME'], [NomeTabela, NomeCampo],
    'RDB$FIELD_NAME')
end;

Function TabelaExiste(NomeTab: string): Boolean;
begin
  Result := SetKeyDl(T2.qC1, 'rdb$relations', ['rdb$relation_name'], [NomeTab],
    'rdb$relation_name')
end;

Procedure ExecutaComando(S: string);
begin
  T2.qTemp.Close;
  T2.qTemp.SQL.Clear;
  T2.qTemp.SQL.Add(S);
  T2.qTemp.ParamCheck := False;
  T2.qTemp.ExecSQL();
end;

procedure CriaCampoTabela(NomeTabela, NomeCampo, Tipo: String;
  Tamanho, Decimais: Integer);
var
  S: String;
begin
  S := 'ALTER TABLE ' + NomeTabela + ' ADD ';
  if Tipo = 'N' then
    S := S + #10 + NomeCampo + ' NUMERIC(' + IntToStr(Tamanho) + ',' +
      IntToStr(Decimais) + ')';
  if Tipo = 'C' then
    S := S + #10 + NomeCampo + ' VARCHAR(' + IntToStr(Tamanho) + ')';
  if Tipo = 'D' then
    S := S + #10 + NomeCampo + ' DATE)';

  ExecutaComando(S);
end;

procedure CriaTabelaWebObjeto;
var
  S: String;
begin
  S := 'CREATE TABLE WEBOBJETO(';
  S := S + #10 + ' ID      NUMERIC(10,0) NOT NULL,';
  S := S + #10 + ' OBJETO  VARCHAR(30),';
  S := S + #10 + ' USUARIO VARCHAR(30),';
  S := S + #10 + ' DATA    DATE,       ';
  S := S + #10 + ' HORA    VARCHAR(8)';
  S := S + #10 + ');';
  ExecutaComando(S);

  S := 'ALTER TABLE WEBOBJETO ADD PRIMARY KEY (ID);';
  ExecutaComando(S);

  S := 'CREATE SEQUENCE WEBOBJETO_ID;';
  ExecutaComando(S);

  S := 'ALTER SEQUENCE WEBOBJETO_ID RESTART WITH 0;';
  ExecutaComando(S);

  S := 'CREATE OR ALTER PROCEDURE AUTO_WEBOBJETO_ID (';
  S := S + #10 + '    incr integer)';
  S := S + #10 + 'returns (';
  S := S + #10 + '    codigo integer)';
  S := S + #10 + 'as';
  S := S + #10 + 'begin';
  S := S + #10 + '  CODIGO = gen_id(WEBOBJETO_ID, Incr);';
  S := S + #10 + '  suspend;';
  S := S + #10 + 'end';
  ExecutaComando(S);
end;

procedure CriaTabelaWebLog;
var
  S: String;
begin
  S := 'CREATE TABLE WEBLOG (';
  S := S + #10 + '    ID       NUMERIC(10,0) NOT NULL,';
  S := S + #10 + '    OBJETO   VARCHAR(15),';
  S := S + #10 + '    CHAVE    BLOB SUB_TYPE 1 SEGMENT SIZE 4096,';
  S := S + #10 + '    TIPO     VARCHAR(1), '; // G de gravação ou E de exclusão
  S := S + #10 + '    USUARIO  VARCHAR(30),';
  S := S + #10 + '    DATA     DATE,       ';
  S := S + #10 + '    HORA     VARCHAR(20)';
  S := S + #10 + ');';
  ExecutaComando(S);

  S := 'ALTER TABLE WEBLOG ADD PRIMARY KEY (ID);';
  ExecutaComando(S);

  S := 'CREATE SEQUENCE WEBLOG_ID;';
  ExecutaComando(S);

  S := 'ALTER SEQUENCE WEBLOG_ID RESTART WITH 0;';
  ExecutaComando(S);

  S := 'CREATE OR ALTER PROCEDURE AUTO_WEBLOG_ID (';
  S := S + #10 + '    incr integer)';
  S := S + #10 + 'returns (';
  S := S + #10 + '    codigo integer)';
  S := S + #10 + 'as';
  S := S + #10 + 'begin';
  S := S + #10 + '  CODIGO = gen_id(WEBLOG_ID, Incr);';
  S := S + #10 + '  suspend;';
  S := S + #10 + 'end';
  ExecutaComando(S);
end;

Procedure TScript.CriaTabelaLog;
begin
  if not TabelaExiste('WEBLOG') then
    CriaTabelaWebLog;
end;

Procedure TScript.CriaTabelasConfig;
begin
  if not TabelaExiste('WEBOBJETO') then
    CriaTabelaWebObjeto;
end;

Procedure TScript.AtualizarTabelas;
begin
  // Verifica se os campos existem nas tabelas do sistema de Integração WEB
  // Por enquanto não precisa ser utilizado, mas poderá ser necessário no futuro
  // if not CampoExisteTabela('TABELA','CAMPO')
  // then CriaCampoTabela('TABELA','CAMPO','C',1,0);
end;

end.
