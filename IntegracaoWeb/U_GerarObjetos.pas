unit U_GerarObjetos;

interface

uses Forms, U_Sisproc, DBClient, SysUtils, StrUtils;

type
  TGerarObjetos = class(TObject)
  private
    FCfgWebUsu: String;
    procedure ExcluirTriggers;
    procedure CriarTriggers(Objeto: String); overload;
    procedure AddTrigger(IncAltExc, Objeto, Tabela, Tipo: String; ChaveTabela: array of string);
    procedure SetCfgWebUsu(const Value: String);
  public
    constructor Create;

    property CfgWebUsu: String read FCfgWebUsu write SetCfgWebUsu;

    procedure CriarTriggers; overload;
  end;

implementation

{ TGerarObjetos }

uses U_T2;

constructor TGerarObjetos.Create;
begin
  inherited Create;
  CfgWebUsu := BuscaCFG2(T2.qgSepeCfg, 'SEPECFG', 'CFG_WEBUSU', 'Usuário padrão de importação WEB', '', 1, 200);
end;

procedure TGerarObjetos.CriarTriggers;
var
  Q: String;
  cdsObjetos: TClientDataSet;
begin
  // Exclui todas as triggers de exportação web
  ExcluirTriggers;

  // Seleção de todos os objetos configurados para serem exportados
  Q := 'Select Objeto From WebObjeto';

  T2.cdsC1.Active := False;
  T2.qC1.Close;
  T2.qC1.SQL.Clear;
  T2.qC1.SQL.Add(Q);
  T2.cdsC1.Active := True;

  cdsObjetos := TClientDataSet.Create(T2);
  Try
    AlimentaRelCds('', T2.cdsC1, cdsObjetos);
    cdsObjetos.First;
    while not cdsObjetos.Eof do
    begin
      // Cria as triggers de Insert, Update e Delete de cada objeto
      CriarTriggers(Nst(cdsObjetos['Objeto']));

      Application.ProcessMessages;
      cdsObjetos.Next;
    end;
  Finally
    cdsObjetos.Free;
  End;
end;

procedure TGerarObjetos.CriarTriggers(Objeto: String);
var
  CamposChave: Array of String;
begin
  // Inclusão no objeto pai gera JSON de GRAVAÇÃO
  // Exclusão no objeto pai gera JSON de EXCLUSÃO
  // Inclusão ou Exclusão em objetos filhos gera JSON de GRAVAÇÃO
  Objeto := UpperCase(Objeto);

  if Objeto = 'TBANCO' then
  begin
    // Objeto Pai
    SetLength(CamposChave, 1);
    CamposChave[0] := 'LOC_CODIGO';
    AddTrigger('I', Objeto, 'SCRALOC', 'G', CamposChave);
    AddTrigger('E', Objeto, 'SCRALOC', 'E', CamposChave);
  end;

  if Objeto = 'TTITULO' then
  begin
    // Objeto Pai
    SetLength(CamposChave, 1);
    CamposChave[0] := 'DUP_NUM';
    AddTrigger('I', Objeto, 'SCRADUP', 'G', CamposChave);
    AddTrigger('E', Objeto, 'SCRADUP', 'E', CamposChave);
  end;

  if Objeto = 'TTIPOATEND' then
  begin
    // Objeto Pai
    SetLength(CamposChave, 1);
    CamposChave[0] := 'TAT_CODIGO';
    AddTrigger('I', Objeto, 'CADTPAT', 'G', CamposChave);
    AddTrigger('E', Objeto, 'CADTPAT', 'E', CamposChave);
  end;

  if Objeto = 'TEMPRESA' then
  begin
    // Objeto Pai
    SetLength(CamposChave, 1);
    CamposChave[0] := 'CODIGO';
    AddTrigger('I', Objeto, 'EMPRESA', 'G', CamposChave);
    AddTrigger('E', Objeto, 'EMPRESA', 'E', CamposChave);
  end;

  if Objeto = 'TCIDADE' then
  begin
    // Objeto Pai
    SetLength(CamposChave, 1);
    CamposChave[0] := 'MUN_CODIGO';
    AddTrigger('I', Objeto, 'CADAMUN', 'G', CamposChave);
    AddTrigger('E', Objeto, 'CADAMUN', 'E', CamposChave);
  end;

  if Objeto = 'TCLIENTE' then
  begin
    // Cria controle de objeto para ScraCli
    SetLength(CamposChave, 1);
    CamposChave[0] := 'CLI_CODIGO';
    AddTrigger('I', Objeto, 'SCRACLI', 'G', CamposChave);
    AddTrigger('E', Objeto, 'SCRACLI', 'E', CamposChave);

    // Objetos filhos
    // Cria controle de objeto para ScraCliV
    SetLength(CamposChave, 1);
    CamposChave[0] := 'CLICODIGO';
    AddTrigger('I', Objeto, 'SCRACLIV', 'G', CamposChave);
    AddTrigger('E', Objeto, 'SCRACLIV', 'G', CamposChave);

    // Cria controle de objeto para ScraCliJ
    SetLength(CamposChave, 1);
    CamposChave[0] := 'CLICODIGO';
    AddTrigger('I', Objeto, 'SCRACLIJ', 'G', CamposChave);
    AddTrigger('E', Objeto, 'SCRACLIJ', 'G', CamposChave);

    // Cria controle de objeto para CadaCtn
    SetLength(CamposChave, 1);
    CamposChave[0] := 'CTN_CODIGO';
    AddTrigger('I', Objeto, 'CADACTN', 'G', CamposChave);
    AddTrigger('E', Objeto, 'CADACTN', 'G', CamposChave);
  end;

  if Objeto = 'TCONDPAGAMENTO' then
  begin
    // Objeto Pai
    SetLength(CamposChave, 1);
    CamposChave[0] := 'PGNF_COD';
    AddTrigger('I', Objeto, 'SCRAPGNF', 'G', CamposChave); // Encurta o nome
    AddTrigger('E', Objeto, 'SCRAPGNF', 'E', CamposChave);
  end;

  if Objeto = 'TCONVENIO' then
  begin
    // Objeto Pai
    SetLength(CamposChave, 1);
    CamposChave[0] := 'CNV_CODIGO';
    AddTrigger('I', Objeto, 'DENACNV', 'G', CamposChave);
    AddTrigger('E', Objeto, 'DENACNV', 'E', CamposChave);
  end;

  if Objeto = 'TFERIADO' then
  begin
    // Objeto Pai
    SetLength(CamposChave, 1);
    CamposChave[0] := 'FER_DTAFER';
    AddTrigger('I', Objeto, 'CADAFER', 'G', CamposChave);
    AddTrigger('E', Objeto, 'CADAFER', 'E', CamposChave);
  end;

  if Objeto = 'TFONTECLI' then
  begin
    // Objeto Pai
    SetLength(CamposChave, 1);
    CamposChave[0] := 'FON_CODIGO';
    AddTrigger('I', Objeto, 'CADAFON', 'G', CamposChave);
    AddTrigger('E', Objeto, 'CADAFON', 'E', CamposChave);
  end;

  if Objeto = 'TGRUPOCLI' then
  begin
    // Objeto Pai
    SetLength(CamposChave, 1);
    CamposChave[0] := 'GRP_CODIGO';
    AddTrigger('I', Objeto, 'SCRAGRP', 'G', CamposChave);
    AddTrigger('E', Objeto, 'SCRAGRP', 'E', CamposChave);
  end;

  if Objeto = 'TGRUPOPRO' then
  begin
    // Objeto Pai
    SetLength(CamposChave, 1);
    CamposChave[0] := 'GRU_CODIGO';
    AddTrigger('I', Objeto, 'ESTAGRU', 'G', CamposChave);
    AddTrigger('E', Objeto, 'ESTAGRU', 'E', CamposChave);
  end;

  if Objeto = 'TICMSUF' then
  begin
    // Objeto Pai
    SetLength(CamposChave, 4);
    CamposChave[0] := 'ICMS_UF';
    CamposChave[1] := 'ICMS_PROD';
    CamposChave[2] := 'ICMS_CLI';
    CamposChave[3] := 'ICMS_ALIQ';
    AddTrigger('I', Objeto, 'SLFAICMS', 'G', CamposChave);
    AddTrigger('E', Objeto, 'SLFAICMS', 'E', CamposChave);
  end;

  if Objeto = 'TCADCFOP' then
  begin
    // Objeto Pai
    SetLength(CamposChave, 2);
    CamposChave[0] := 'NT_OPC';
    CamposChave[1] := 'NT_CFO';
    AddTrigger('I', Objeto, 'SLFANTO', 'G', CamposChave);
    AddTrigger('E', Objeto, 'SLFANTO', 'E', CamposChave);
  end;

  if Objeto = 'TCADOCORRENCIAS' then
  begin
    // Objeto Pai
    SetLength(CamposChave, 1);
    CamposChave[0] := 'OCR_CODIGO';
    AddTrigger('I', Objeto, 'VENAOCR', 'G', CamposChave);
    AddTrigger('E', Objeto, 'VENAOCR', 'E', CamposChave);
  end;

  if Objeto = 'TPAIS' then
  begin
    // Objeto Pai
    SetLength(CamposChave, 1);
    CamposChave[0] := 'PAI_CODIGO';
    AddTrigger('I', Objeto, 'CADPAIS', 'G', CamposChave);
    AddTrigger('E', Objeto, 'CADPAIS', 'E', CamposChave);
  end;

  if Objeto = 'TPEDIDO' then
  begin
    // Objeto Pai
    SetLength(CamposChave, 1);
    CamposChave[0] := 'ID';
    AddTrigger('I', Objeto, 'WTPEDIDO', 'G', CamposChave);
    AddTrigger('E', Objeto, 'WTPEDIDO', 'E', CamposChave);

    if Application.Title = 'Integração Demander' then
    begin
      SetLength(CamposChave, 1);
      CamposChave[0] := 'PED_NRO';
      AddTrigger('I', Objeto, 'VENAPED', 'G', CamposChave);
      AddTrigger('E', Objeto, 'VENAPED', 'E', CamposChave);
    end;

    // Objetos Filhos
    SetLength(CamposChave, 1);
    CamposChave[0] := 'ID';
    AddTrigger('I', Objeto, 'WTPEDIDOHIST', 'G', CamposChave);
    AddTrigger('E', Objeto, 'WTPEDIDOHIST', 'E', CamposChave);
  end;

  if Objeto = 'TPEDIDOHIST' then
  begin
    // Objeto Pai
    SetLength(CamposChave, 1);
    CamposChave[0] := 'PDH_ID';
    AddTrigger('I', Objeto, 'VENAPDH', 'G', CamposChave);
    AddTrigger('E', Objeto, 'VENAPDH', 'E', CamposChave);
  end;

  if Objeto = 'TTABPRECOVAL' then
  begin
    // Objeto Pai
    SetLength(CamposChave, 2);
    CamposChave[0] := 'TAB_NRO';
    CamposChave[1] := 'TAB_CODPRO';
    AddTrigger('I', Objeto, 'VENATAB', 'G', CamposChave);
    AddTrigger('E', Objeto, 'VENATAB', 'E', CamposChave);
  end;

  if Objeto = 'TPRODUTO' then
  begin
    // Objeto Pai
    SetLength(CamposChave, 1);
    CamposChave[0] := 'PRO_CODIGO';

    if Application.Title = 'Integração e-Commerce' then
    begin
      SetLength(CamposChave, 2);
      CamposChave[1] := 'PRO_CODREF';
    end;

    AddTrigger('I', Objeto, 'ESTAPRO', 'G', CamposChave);
    AddTrigger('E', Objeto, 'ESTAPRO', 'E', CamposChave);
  end;

  if Objeto = 'TSALDOTMP' then
  begin
    // Objetos Filhos
    SetLength(CamposChave, 2);
    CamposChave[0] := 'ALX_CODALX';
    CamposChave[1] := 'ALX_CODPRO';
    AddTrigger('I', Objeto, 'ECMAALX', 'G', CamposChave);
    AddTrigger('E', Objeto, 'ECMAALX', 'E', CamposChave);
  end;

  if Objeto = 'TREFERENCIA' then
  begin
    // Objeto Pai
    SetLength(CamposChave, 1);
    CamposChave[0] := 'REF_CODIGO';
    AddTrigger('I', Objeto, 'SPRAREF', 'G', CamposChave);
    AddTrigger('E', Objeto, 'SPRAREF', 'E', CamposChave);
  end;

  if Objeto = 'TREGIAOCLI' then
  begin
    // Objeto Pai
    SetLength(CamposChave, 1);
    CamposChave[0] := 'REG_CODIGO';
    AddTrigger('I', Objeto, 'SCRAREG', 'G', CamposChave);
    AddTrigger('E', Objeto, 'SCRAREG', 'E', CamposChave);
  end;

  if Objeto = 'TSEGMENTOCLI' then
  begin
    // Objeto Pai
    SetLength(CamposChave, 1);
    CamposChave[0] := 'SEG_CODIGO';
    AddTrigger('I', Objeto, 'CADASEG', 'G', CamposChave);
    AddTrigger('E', Objeto, 'CADASEG', 'E', CamposChave);
  end;

  if Objeto = 'TTABPRECO' then
  begin
    // Objeto Pai
    SetLength(CamposChave, 1);
    CamposChave[0] := 'TBC_CODIGO';
    AddTrigger('I', Objeto, 'VENATBC', 'G', CamposChave);
    AddTrigger('E', Objeto, 'VENATBC', 'E', CamposChave);
  end;

  if Objeto = 'TCADTNA' then
  begin
    // Objeto Pai
    SetLength(CamposChave, 1);
    CamposChave[0] := 'TNA_CODIGO';
    AddTrigger('I', Objeto, 'CADATNA', 'G', CamposChave);
    AddTrigger('E', Objeto, 'CADATNA', 'E', CamposChave);
  end;

  if Objeto = 'TTIPOPAG' then
  begin
    // Objeto Pai
    SetLength(CamposChave, 1);
    CamposChave[0] := 'TPG_CODIGO';
    AddTrigger('I', Objeto, 'SCRATPG', 'G', CamposChave);
    AddTrigger('E', Objeto, 'SCRATPG', 'E', CamposChave);
  end;

  if Objeto = 'TTRANSPORTADOR' then
  begin
    // Objeto Pai
    SetLength(CamposChave, 1);
    CamposChave[0] := 'TRS_CODIGO';
    AddTrigger('I', Objeto, 'SCRATRS', 'G', CamposChave);
    AddTrigger('E', Objeto, 'SCRATRS', 'E', CamposChave);
  end;

  if Objeto = 'TNCMTRIBUTACAO' then
  begin
    // Objeto Pai
    SetLength(CamposChave, 1);
    CamposChave[0] := 'NCM_ID';
    AddTrigger('I', Objeto, 'NCMXTRB', 'G', CamposChave);
    AddTrigger('E', Objeto, 'NCMXTRB', 'E', CamposChave);
  end;

  if Objeto = 'TVENDEDOR' then
  begin
    // Objeto Pai
    SetLength(CamposChave, 1);
    CamposChave[0] := 'FUN_CODIGO';
    AddTrigger('I', Objeto, 'VENAFUN', 'G', CamposChave);
    AddTrigger('E', Objeto, 'VENAFUN', 'E', CamposChave);
  end;
end;

procedure TGerarObjetos.ExcluirTriggers;
var
  Q: String;
begin
  // Deleta todas as triggers de exportação WEB
  Q := 'DELETE FROM RDB$TRIGGERS';
  Q := Q + sLineBreak + 'WHERE RDB$TRIGGER_NAME LIKE ''WEB_%''';

  T2.qTemp.Close;
  T2.qTemp.SQL.Clear;
  T2.qTemp.SQL.Add(Q);
  T2.qTemp.ExecSQL();
end;

procedure TGerarObjetos.SetCfgWebUsu(const Value: String);
begin
  FCfgWebUsu := Value;
end;

procedure TGerarObjetos.AddTrigger(IncAltExc, Objeto, Tabela, Tipo: String; ChaveTabela: array of string);
var
  Chave, Msg, TagTrigger, TesteChaves, TestesRedundancia, TesteUsuario: String;
  I: Integer;
begin
  if Tipo = 'E' then
    TagTrigger := 'OLD.'
  else
    TagTrigger := 'NEW.';

  // Montar esquema da chave: tabela=NOMETABELA|Campo=Campo1|Campo=Campo2|Campo=Campo3...
  Chave := '''Tabela=' + Tabela + '''';
  TesteChaves := '';
  for I := 0 to Length(ChaveTabela) - 1 do
  begin
    Chave := Chave + ' || ''|' + ChaveTabela[I] + '='' || ' + TagTrigger + ChaveTabela[I];

    // String com montagem da Condição da chave
    TesteChaves := TesteChaves + ' OR (OLD.' + ChaveTabela[I] + ' is NULL)';
  end;

  T2.qTemp.Close;
  T2.qTemp.SQL.Clear;
  T2.qTemp.ParamCheck := False;

  T2.qTemp.SQL.Add('/* Integracao WEB ' + Objeto + ' */');

  T2.qTemp.SQL.Add('CREATE OR ALTER TRIGGER WEB_' + Tipo + '_' + Objeto + '_' + Tabela + ' FOR ' + Tabela);

  if Tipo = 'E' then // Excluir
    T2.qTemp.SQL.Add('ACTIVE AFTER DELETE POSITION 30000')
  else // Incluir ou Alterar
    T2.qTemp.SQL.Add('ACTIVE AFTER INSERT OR UPDATE POSITION 30000');

  T2.qTemp.SQL.Add('AS');
  T2.qTemp.SQL.Add('declare variable chave varchar(300);');
  T2.qTemp.SQL.Add('begin');

  // Quando pedido deve exportar o status de 'Integrado' assim que importar o pedido, ou seja, sempre exporta pedidos, caso contrário faz o
  // Teste para exportar somente dados importados da WEB que não estejam com seus campos chaves preenchidos e que não sejam exclusões
  if Tabela = 'WTPEDIDO' then
    TesteUsuario := '(current_user <> '''')'
  else
    TesteUsuario := '(current_user <> ''' + CfgWebUsu + ''')';

  TestesRedundancia := '  if (' + TesteUsuario;
  if Tipo <> 'E' then
    TestesRedundancia := TestesRedundancia + TesteChaves;
  TestesRedundancia := TestesRedundancia + ') then';

  T2.qTemp.SQL.Add(TestesRedundancia);
  T2.qTemp.SQL.Add('  begin');
  T2.qTemp.SQL.Add('    chave = ' + Chave + ';');
  T2.qTemp.SQL.Add('    ');
  T2.qTemp.SQL.Add('    /*Mantem somente a ultima acao do objeto e chave*/');
  T2.qTemp.SQL.Add('    delete from WEBLOG where OBJETO = ''' + Objeto + ''' and chave = :chave;');
  T2.qTemp.SQL.Add('  ');
  T2.qTemp.SQL.Add('    insert into WEBLOG (ID, OBJETO, CHAVE, TIPO, USUARIO, DATA, HORA)');
  T2.qTemp.SQL.Add('    values (GEN_ID(WEBLOG_ID,1), ''' + Objeto + ''', :chave, ''' + Tipo + ''', current_user, current_date, current_time);');
  T2.qTemp.SQL.Add('  end');
  T2.qTemp.SQL.Add('end');

  try
    T2.qTemp.ExecSQL;
  except
    on E: Exception do
    begin
      Msg := E.Message + #10#13 + T2.qTemp.SQL.Text;
      Dl_Msg(Msg, 'Erro ao gerar trigger INSERT', 'Erro');
    end
    else
    begin
      Msg := 'Erro Desconhecido' + #10#13 + T2.qTemp.SQL.Text;
      Dl_Msg(Msg, 'Erro ao gerar trigger INSERT', 'Erro');
    end;
  end;
end;

end.
