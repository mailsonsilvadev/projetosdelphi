unit U_WooControl;

interface

uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, DBClient, DB, U_WooProdutoItem, U_IntegracaoPedido,
  Menus, ExtCtrls, ComCtrls, U_Sisproc, stdctrls, Variants, System.Actions, U_WooProduto, CReferencia, CReferenciaCruzada;

type
  TWooControl = class(TObject)
  private
    FDataUltima: TDateTime;
    FcdsWebLog: TClientDataSet;
    FAlxSaldo: String;
    FStrLogChave: TStringList;
    FProdutos: TArray<TWooProduto>;
    procedure SetDataUltima(const Value: TDateTime);
    procedure SetcdsWebLog(const Value: TClientDataSet);

    procedure CarregarWebLog;
    function CarregarProdutos(ATipo: String): Boolean;
    procedure SetAlxSaldo(const Value: String);
    procedure SetStrLogChave(const Value: TStringList);
    function GetStrLogChave: TStringList;
    procedure SetProdutos(const Value: TArray<TWooProduto>);
    function ExportarProdutos: Boolean;
//    procedure LimparLogs;
    procedure EnviarReferencias;
    procedure EnviarVariacoes;
    procedure GravarLog(AMsg: String);
    procedure GravarWebLogErro(AChave: String);
    procedure ImportarPedidos;
    procedure SalvarListaPedidos(ALstPedidos: TStringList);
    procedure CarregarListaPedidos(ALstPedidos: TStringList);

    function GetDiretorioPedidos: String;
  public
    constructor Create;
    procedure Free;

    function GetLog: String;

    function AddProduto(AIndex: Integer): TWooProduto;
    function LocalizarProduto(ACodigo: String): TWooProduto;

    procedure SetUltimaSincronizacao(AData: TDate);
    function GetUltimaSincronizacao: TDate;
    function FazExportacao: Boolean;
    function FazImportacao: Boolean;

    procedure AjustarReferencias;

    property DataUltima: TDateTime read FDataUltima write SetDataUltima;
    property cdsWebLog: TClientDataSet read FcdsWebLog write SetcdsWebLog;
    property AlxSaldo: String read FAlxSaldo write SetAlxSaldo;
    property StrLogChave: TStringList read GetStrLogChave write SetStrLogChave;
    property Produtos: TArray<TWooProduto> read FProdutos write SetProdutos;
  end;

implementation

uses U_T2, U_WooIntegracao, CParametrosBDIni;

{ TWooControl }

function TWooControl.AddProduto(AIndex: Integer): TWooProduto;
begin
  SetLength(FProdutos, AIndex + 1);
  FProdutos[AIndex] := TWooProduto.Create;
  FProdutos[AIndex].Produto.isVariacao := False;
  Result := FProdutos[AIndex];
end;

procedure TWooControl.AjustarReferencias;
var
  Q: String;
  I: Integer;
  ltCor, ltTan: TStrings;
begin
  // Percorre as referências atualizando as informações do Cruzamento de Cor e Tamanho
  for I := Low(FProdutos) to High(FProdutos) do
  begin
    Q := 'Select Cor_Descri, Tam_Descri, Ref_Codigo, Ref_Descri, Ref_Ativo';
    Q := Q + sLineBreak + 'From SpraRct';

    Q := Q + #10#13 + 'Inner Join SpraCor on Rct_CodCor = Cor_Codigo';
    Q := Q + #10#13 + 'Inner Join SpraTam on Rct_CodTam = Tam_Codigo';
    Q := Q + #10#13 + 'Inner Join SpraRef on Rct_CodRef = Ref_Codigo';

    Q := Q + #10#13 + 'Where Ref_Codigo = ''' + FProdutos[I].Produto.SkuCodigo + '''';

    T2.cdsC1.Active := False;
    T2.qC1.Close;
    T2.qC1.SQL.Clear;
    T2.qC1.SQL.Add(Q);
    T2.cdsC1.Active := True;

    T2.cdsC1.First;
    while not T2.cdsC1.Eof do
    begin
      with FProdutos[I].Produto do
      begin
        Ativo := T2.cdsC1.FieldByName('Ref_Ativo').AsString <> 'N';

        ltCor := Explode(Cor, '|'); // foi alterado pois algumas cores tinha duas ex. marrom/cru
        if (ltCor.IndexOf(T2.cdsC1.FieldByName('Cor_Descri').AsString) < 0) then
        begin
          if not Cor.IsEmpty then
            Cor := Cor + '|';

          Cor := Cor + T2.cdsC1.FieldByName('Cor_Descri').AsString;
        end;

        ltTan := Explode(Tamanho, '|');
        if (ltTan.IndexOf(Trim(T2.cdsC1.FieldByName('Tam_Descri').AsString)) < 0) then
        begin
          if not Tamanho.IsEmpty then
            Tamanho := Tamanho + '|';

          Tamanho := Tamanho + T2.cdsC1.FieldByName('Tam_Descri').AsString;
        end;
      end;

      FreeAndNil(ltCor);
      FreeAndNil(ltTan);
      Application.ProcessMessages;
      T2.cdsC1.Next;
    end;
  end;
end;

procedure TWooControl.CarregarListaPedidos(ALstPedidos: TStringList);
begin
  CriaListaArq(ALstPedidos, GetDiretorioPedidos, '*.json', True, False);
end;

function TWooControl.CarregarProdutos(ATipo: String): Boolean;
var
  Q, AlxSelecao, CodRef: String;
  Referencia: TWooProduto;
  ltCor, ltTan: TStrings;
begin
  if ATipo = 'E' then
  begin // Exclusão de produto
    // Produtos não devem ser excluídos a partir do Wsepe, pois podem existir pedidos no e-commerce
    Referencia := LocalizarProduto(StrLogChave.Values['Pro_CodRef']);
    if Referencia = nil then
    begin
      Referencia := AddProduto(High(FProdutos) + 1);
    end;

    with Referencia do
    begin
      // Só seta o código para buscar o id. Sem a descrição, a referência não é postada
      Produto.SkuCodigo := StrLogChave.Values['Pro_CodRef'];

      with Referencia.AddVariacao(High(Referencia.Variacoes) + 1).Produto do
      begin
        Name := StrLogChave.Values['Pro_Codigo'];
        Slug := StrLogChave.Values['Pro_Codigo'];
        Description := StrLogChave.Values['Pro_Codigo'];
        ShortDescription := StrLogChave.Values['Pro_Codigo'];
        SkuCodigo := StrLogChave.Values['Pro_Codigo'];
        RegularPrice := '0,00';
        SalePrice := '0,00';
        StockQuantity := 0;
        Weight := '0,00';
        Cor := '';
        Tamanho := '';
        Ativo := False;
        Excluir := True;
        IdWebLog := cdsWebLog.FieldByName('ID').AsInteger;
      end;
    end;
  end
  else // Alteração ou inclusão de produto
  begin
    Try
      AlxSelecao := AlxSelecao.Join(#39 + ', ' + #39, FAlxSaldo);
      AlxSelecao := #39 + AlxSelecao + #39;
    Except
      AlxSelecao := '''''';
    End;

    Q := 'Select Pro_Codigo, Pro_CodOrg, Pro_PrDesc, Pro_CodGru, Pro_Descri, Pro_PesoL, Pro_Und, Pro_Ativo, 0 as Tab_QtdMin, Pro_CodRef, Pro_ClasFi, Pro_Obs1,';
    Q := Q + sLineBreak + '(Select Sum(Alx_Quant) From EcmaAlx Where Alx_CodPro = Pro_Codigo and Alx_CodAlx in (' + AlxSelecao + ')) as Alx_Quant,';
    Q := Q + sLineBreak + 'Tab_Preco, Cor_Descri, Tam_Descri, Ref_Codigo, Ref_Descri, Ref_Obs1, Ref_Ativo, Ref_PesoL, Ref_IdExt, Rct_IdExt,';
    Q := Q + sLineBreak + 'Pro_DimAlt, Pro_DimLar, Pro_DimPrf';
    Q := Q + sLineBreak + 'From EstaPro';

    // Somente produtos com referência
    Q := Q + #10#13 + 'Inner Join SpraRct on Rct_CodPro = Pro_Codigo';
    Q := Q + #10#13 + 'Inner Join SpraCor on Rct_CodCor = Cor_Codigo';
    Q := Q + #10#13 + 'Inner Join SpraTam on Rct_CodTam = Tam_Codigo';
    Q := Q + #10#13 + 'Inner Join SpraRef on Rct_CodRef = Ref_Codigo';

    // Somente produtos cadastrados em pelo menos uma tabela de preço utilizada na web
    Q := Q + #10#13 + 'Inner Join VenaTab on Tab_CodPro = Pro_Codigo';
    Q := Q + #10#13 + 'Inner Join VenaTbc on Tbc_Codigo = Tab_Nro and Tbc_WebMob = ''S''';

    if not StrLogChave.Values['Pro_Codigo'].IsEmpty then
      Q := Q + #10#13 + 'Where Pro_Codigo = ''' + StrLogChave.Values['Pro_Codigo'] + ''''
    else
    begin
      // No envio geral, somente produtos para VENDA e ATIVOS
      Q := Q + sLineBreak + 'Where Pro_ProVen = ''S''';
      Q := Q + sLineBreak + 'and Pro_Ativo = ''S''';
    end;

    Q := Q + #10#13 + 'Order by Ref_Codigo, Pro_Codigo';

    T2.cdsC1.Active := False;
    T2.qC1.Close;
    T2.qC1.SQL.Clear;
    T2.qC1.SQL.Add(Q);
    T2.cdsC1.Active := True;

    CodRef := EmptyStr;

    T2.cdsC1.First;
    while not T2.cdsC1.Eof do
    begin
      if CodRef <> T2.cdsC1.FieldByName('Ref_Codigo').AsString then
      begin
        CodRef := T2.cdsC1.FieldByName('Ref_Codigo').AsString;

        // Dados da Referência, considerado no Woocommerce como Produto
        Referencia := LocalizarProduto(CodRef);
        if Referencia = nil then
        begin
          Referencia := AddProduto(High(FProdutos) + 1);
        end;

        with Referencia.Produto do
        begin
          IdWeb := T2.cdsC1.FieldByName('Ref_IdExt').AsInteger;
          Name := Nst(T2.cdsC1['Ref_Descri']);
          Slug := Nst(T2.cdsC1['Ref_Descri']);
          Description := Nst(T2.cdsC1['Ref_Obs1']);
          ShortDescription := Nst(T2.cdsC1['Ref_Descri']);
          SkuCodigo := Nst(T2.cdsC1['Ref_Codigo']);
          RegularPrice := '0,00';
          SalePrice := '0,00';
          StockQuantity := 0;
          Weight := '0,00';
          Cor := '';
          Tamanho := '';
          Ativo := Nst(T2.cdsC1['Ref_Ativo']) = 'S';
          IdWebLog := cdsWebLog.FieldByName('ID').AsInteger;
        end;
      end;

      // Atualizando valores comuns na referência
      with Referencia.Produto do
      begin
        ltCor := Explode(Cor, '|'); // foi alterado pois algumas cores tinha duas ex. marrom/cru
        if (ltCor.IndexOf(Trim(T2.cdsC1.FieldByName('Cor_Descri').AsString)) < 0) then
        begin
          if not Cor.IsEmpty then
            Cor := Cor + '|';

          Cor := Cor + T2.cdsC1.FieldByName('Cor_Descri').AsString;
        end;

        ltTan := Explode(Tamanho, '|');
        if (ltTan.IndexOf(Trim(T2.cdsC1.FieldByName('Tam_Descri').AsString)) < 0) then
        begin
          if not Tamanho.IsEmpty then
            Tamanho := Tamanho + '|';

          Tamanho := Tamanho + T2.cdsC1.FieldByName('Tam_Descri').AsString;
        end;
      end;
      FreeAndNil(ltCor);
      FreeAndNil(ltTan);

      // Dados do Produto, considerado no Woocommerce como Variações do Produto
      with Referencia.AddVariacao(High(Referencia.Variacoes) + 1).Produto do
      begin
        IdWeb := T2.cdsC1.FieldByName('Rct_IdExt').AsInteger;
        Name := Nst(T2.cdsC1['Pro_Descri']);
        Slug := Nst(T2.cdsC1['Pro_Descri']);
        Description := Nst(T2.cdsC1['Pro_Obs1']);
        ShortDescription := Nst(T2.cdsC1['Pro_Descri']);
        SkuCodigo := Nst(T2.cdsC1['Pro_Codigo']);
        RegularPrice := Str(Nvl(T2.cdsC1['Tab_Preco']), 2);
        SalePrice := Str(Nvl(T2.cdsC1['Tab_Preco']), 2);
        StockQuantity := Ivl(T2.cdsC1['Alx_Quant']);
        Weight := Str(Nvl(T2.cdsC1['Pro_PesoL']), 2);
        Cor := T2.cdsC1.FieldByName('Cor_Descri').AsString;
        Tamanho := T2.cdsC1.FieldByName('Tam_Descri').AsString;
        Largura := T2.cdsC1.FieldByName('Pro_DimLar').AsString;
        Altura := T2.cdsC1.FieldByName('Pro_DimAlt').AsString;
        Comprimento := T2.cdsC1.FieldByName('Pro_DimPrf').AsString;
        Ativo := Nst(T2.cdsC1['Pro_Ativo']) = 'S';
        IdWebLog := cdsWebLog.FieldByName('ID').AsInteger;
      end;

      Application.ProcessMessages;
      T2.cdsC1.Next;
    end;
  end;

  Result := T2.cdsC1.RecordCount > 0;
end;

procedure TWooControl.CarregarWebLog;
var
  Q: String;
begin
  Q := 'Select Id, Objeto, Cast(Chave as varchar(200)) as Chave, Tipo, Cast(''N'' as varchar(1)) as ERRO';
  Q := Q + #10#13 + 'From WebLog';

  T2.cdsC1.Active := False;
  T2.qC1.Close;
  T2.qC1.SQL.Clear;
  T2.qC1.SQL.Add(Q);
  T2.cdsC1.Active := True;

  AlimentaRelCds('', T2.cdsC1, FcdsWebLog, True);
  FcdsWebLog.Filter := '';
  FcdsWebLog.Filtered := False;
end;

constructor TWooControl.Create;
begin
  inherited Create;
  FcdsWebLog := TClientDataSet.Create(T2);
end;

procedure TWooControl.EnviarVariacoes;
var
  AReferencia: TWooProduto;
  AVariacao: TWooProdutoItem;
  obIntegracao: TWooIntegracao;
  obConfig: TParametrosBDIni;
  ARetWs, IdWebNoWsepe: Integer;
  obRefCruzada: TReferenciacruzada;
begin
  obIntegracao := TWooIntegracao.Create;
  obConfig := TParametrosBDIni.Create;
  obRefCruzada := TReferenciacruzada.Create;
  try
    if obConfig.CarregarConfiguracao then
    begin
      obIntegracao.Host := obConfig.Integracao.Token;
      obIntegracao.WebService := obConfig.Envio.WeService;
      obIntegracao.Usuario := obConfig.Envio.Usuario;
      obIntegracao.Senha := obConfig.Envio.Senha;
    end;

    for AReferencia in FProdutos do
    begin
      for AVariacao in AReferencia.Variacoes do
      begin
        Application.ProcessMessages;
        Try
          IdWebNoWsepe := AVariacao.Produto.IdWeb;

          obIntegracao.IDN1 := AReferencia.Produto.IdWeb;
          obIntegracao.IdN2 := AVariacao.Produto.IdWeb;
          obIntegracao.Registro := TWooRegistro.wrVariacao;
          obIntegracao.Dados := AVariacao.Produto.GetJson;

          if AVariacao.Produto.IdWeb = 0 then
          begin
            // Caso a referência não possua IDWeb, tem que tentar localizar no e-commerce
            obIntegracao.Sku := AVariacao.Produto.SkuCodigo;
            AVariacao.Produto.IdWeb := StrToIntDef(obIntegracao.GetWs, 0);
            obIntegracao.IdN2 := AVariacao.Produto.IdWeb;
          end;

          if AVariacao.Produto.Excluir then
          begin
            obIntegracao.Delete;
          end
          else
          begin
            // Tem que dar um get para pegar o ID caso o registro já exista no e-commerce
            ARetWs := obIntegracao.Post;

            // Se não tinha gravado na base de dados o IDWEB do registro no Wsepe então atualiza conforme gerado pelo Woocommerce
            if IdWebNoWsepe = 0 then
            begin
              AVariacao.Produto.IdWeb := ARetWs;
              obRefCruzada.setRct_codpro(AVariacao.Produto.SkuCodigo);
              if obRefCruzada.Consultar then
              begin
                obRefCruzada.setRct_idext(AVariacao.Produto.IdWeb);
                obRefCruzada.Alterar;
              end;
            end;
          end;

          T2.cdsC1.Active := False;
          T2.qC1.Close;
          T2.qC1.SQL.Clear;
          T2.qC1.SQL.Add('Delete From WebLog');
          T2.qC1.SQL.Add('Where Id = ' + Nst(AVariacao.Produto.IdWebLog));
          T2.qC1.ExecSQL();
        Except
          on E: Exception do
          begin
            GravarLog('Erro ao enviar Produto ' + AVariacao.Produto.SkuCodigo + ' - ' + E.Message);
            GravarWebLogErro('Tabela=ESTAPRO|PRO_CODIGO=' + AVariacao.Produto.SkuCodigo);
          end
          else
          begin
            GravarLog('Erro ao enviar Produto ' + AVariacao.Produto.SkuCodigo + ' - Erro desconhecido!');
            GravarWebLogErro('Tabela=ESTAPRO|PRO_CODIGO=' + AVariacao.Produto.SkuCodigo);
          end;
        End;
      end;
    end;
  finally
    obIntegracao.Free;
    obConfig.Free;
    obRefCruzada.Free;
  end;
end;

procedure TWooControl.EnviarReferencias;
var
  AReferencia: TWooProduto;
  obIntegracao: TWooIntegracao;
  obConfig: TParametrosBDIni;
  ARetWs, IdWebNoWsepe: Integer;
  obReferencia: TReferencia;
begin
  obIntegracao := TWooIntegracao.Create;
  obConfig := TParametrosBDIni.Create;
  obReferencia := TReferencia.Create;
  try
    if obConfig.CarregarConfiguracao then
    begin
      obIntegracao.Host := obConfig.Integracao.Token;
      obIntegracao.WebService := obConfig.Envio.WeService;
      obIntegracao.Usuario := obConfig.Envio.Usuario;
      obIntegracao.Senha := obConfig.Envio.Senha;
    end;

    for AReferencia in FProdutos do
    begin
      Try
        Application.ProcessMessages;
        IdWebNoWsepe := AReferencia.Produto.IdWeb;

        obIntegracao.Registro := TWooRegistro.wrProduto;
        obIntegracao.Sku := EmptyStr;
        obIntegracao.IDN1 := AReferencia.Produto.IdWeb;
        obIntegracao.IdN2 := 0;

        if AReferencia.Produto.IdWeb = 0 then
        begin
          // Caso a referência não possua IDWeb, tem que tentar localizar no e-commerce
          obIntegracao.Sku := AReferencia.Produto.SkuCodigo;
          AReferencia.Produto.IdWeb := StrToIntDef(obIntegracao.GetWs, 0);
          obIntegracao.IDN1 := AReferencia.Produto.IdWeb;
        end;

        obIntegracao.Dados := AReferencia.Produto.GetJson;
        ARetWs := obIntegracao.Post;

        // Se não tinha gravado na base de dados o IDWEB da Referencia no Wsepe então atualiza conforme gerado pelo Woocommerce
        if IdWebNoWsepe = 0 then
        begin
          AReferencia.Produto.IdWeb := ARetWs;
          obReferencia.setRef_codigo(AReferencia.Produto.SkuCodigo);
          if obReferencia.Consultar then
          begin
            obReferencia.setRef_idext(AReferencia.Produto.IdWeb);
            obReferencia.Alterar;
          end;
        end;
      Except
        on E: Exception do
        begin
          GravarLog('Erro ao enviar Referência ' + AReferencia.Produto.SkuCodigo + ' - ' + E.Message);
        end
        else
        begin
          GravarLog('Erro ao enviar Referência ' + AReferencia.Produto.SkuCodigo + ' - Erro desconhecido!');
        end;
      End;
    end;
  finally
    obIntegracao.Free;
    obConfig.Free;
    obReferencia.Free;
  end;
end;

function TWooControl.ExportarProdutos: Boolean;
var
  Tipo: String;
begin
  if cdsWebLog.Active then
  begin
    FcdsWebLog.Filtered := False;
    FcdsWebLog.Filter := '(OBJETO = ''TPRODUTO'') or (OBJETO = ''TSALDOTMP'') or (OBJETO = ''TTABPRECOVAL'')';
    FcdsWebLog.Filtered := True;
  end;

  if FDataUltima = 0 then
  begin
    if CarregarProdutos('G') then
      Result := True;
  end
  else
  begin
    FcdsWebLog.First;
    while not FcdsWebLog.Eof do
    begin
      Tipo := 'G';
      StrLogChave.DelimitedText := UpperCaseAcentuado(FcdsWebLog.FieldByName('CHAVE').AsString);

      if FcdsWebLog.FieldByName('Objeto').AsString = 'TPRODUTO' then
        Tipo := FcdsWebLog.FieldByName('TIPO').AsString
      else if FcdsWebLog.FieldByName('Objeto').AsString = 'TSALDOTMP' then
        StrLogChave.DelimitedText := 'Pro_Codigo=' + StrLogChave.Values['Alx_CodPro']
      else if FcdsWebLog.FieldByName('Objeto').AsString = 'TTABPRECOVAL' then
        StrLogChave.DelimitedText := 'Pro_Codigo=' + StrLogChave.Values['Tab_CodPro'];

      CarregarProdutos(Tipo);

      Application.ProcessMessages;
      FcdsWebLog.Next;
    end;

    AjustarReferencias;

    Result := True;
  end;

  EnviarReferencias;
  EnviarVariacoes;

  // Retirei porque os logs são excluidos após o envio de cada variação
  // LimparLogs;
end;

function TWooControl.FazExportacao: Boolean;
begin
  Result := False;

  try
    if FileExists(GetLog) then
      DeleteFile(GetLog);

    if FcdsWebLog.Active then
      FcdsWebLog.EmptyDataSet;

    CarregarWebLog;
    if FDataUltima = 0 then
      FcdsWebLog.EmptyDataSet;

    StrLogChave.Delimiter := '|';
    StrLogChave.NameValueSeparator := '=';
    StrLogChave.DelimitedText := EmptyStr;

    if ExportarProdutos then
      Result := True;

    SetUltimaSincronizacao(Date);
  finally
    FcdsWebLog.Filter := '';
    FcdsWebLog.Filtered := False;
    FcdsWebLog.First;
  end;
end;

function TWooControl.FazImportacao: Boolean;
begin
  ImportarPedidos;
end;

procedure TWooControl.Free;
begin
  FcdsWebLog.Free;
  inherited Free;
end;

function TWooControl.GetDiretorioPedidos: String;
begin
  Result := ExtractFilePath(Application.ExeName) + 'Ecommerce';
  VerificaCriaPasta(Result);

  Result := Result + '\Pedido';
  VerificaCriaPasta(Result);

  Result := Result + '\';
end;

function TWooControl.GetLog: String;
begin
  Result := ExtractFilePath(Application.ExeName) + '\Log\Log_SepeWoo_' + FormatDateTime('mm_dd', Now) + '.log';
end;

function TWooControl.GetStrLogChave: TStringList;
begin
  if not Assigned(FStrLogChave) then
    FStrLogChave := TStringList.Create;

  Result := FStrLogChave;
end;

function TWooControl.GetUltimaSincronizacao: TDate;
begin
  Result := StrToDateDef(BuscaCFG2(T2.qC1, 'SepeCfg', 'CFG_WOOSIN', 'Data da última sincronização com Woocommerce', '01/01/1990', 1, 10), StrToDate('01/01/1990'));
  if Result <= StrToDate('01/01/1990') then
    Result := 0;
end;

procedure TWooControl.GravarLog(AMsg: String);
begin
  GravaLog(GetLog, FormatDateTime('dd/mm/yyyy hh:nn:ss', Now) + ': ' + AMsg);
end;

procedure TWooControl.GravarWebLogErro(AChave: String);
begin
  if cdsWebLog.Locate('Chave', AChave, []) then
  begin
    cdsWebLog.Edit;
  end; {
    else
    begin
    cdsWebLog.Append;
    cdsWebLog.FieldByName('ID').AsInteger := 0;
    cdsWebLog.FieldByName('Chave').AsString := AChave;
    cdsWebLog.FieldByName('Tipo').AsString := 'G';

    if Pertence('ESTAPRO', UpperCase(AChave)) then
    cdsWebLog.FieldByName('Objeto').AsString := 'TPRODUTO';
    end;

    cdsWebLog.FieldByName('Erro').AsString := 'S';
    cdsWebLog.Post; }
end;

procedure TWooControl.ImportarPedidos;
var
  obIntegracao: TWooIntegracao;
  obConfig: TParametrosBDIni;
  ARetWs, IdWebNoWsepe: Integer;
  LstPedidos: TStringList;
  I: Integer;
  obPedido: TIntegracaoPedido;
begin
  obIntegracao := TWooIntegracao.Create;
  obConfig := TParametrosBDIni.Create;
  try
    try
      if obConfig.CarregarConfiguracao then
      begin
        obIntegracao.Host := obConfig.Integracao.Token;
        obIntegracao.WebService := obConfig.Envio.WeService;
        obIntegracao.Usuario := obConfig.Envio.Usuario;
        obIntegracao.Senha := obConfig.Envio.Senha;
      end;

      Application.ProcessMessages;

      LstPedidos := TStringList.Create;
      obIntegracao.Registro := TWooRegistro.wrPedido;
      LstPedidos := TStringList(obIntegracao.GetJsonWs);

      // Salva em arquivo os pedidos
      SalvarListaPedidos(LstPedidos);

      LstPedidos.Clear;

      // Recarrega a lista de todos os pedidos, inclusive importados em momentos diferente, para os casos em que o processo tenha sido interrompido
      CarregarListaPedidos(LstPedidos);
      for I := 0 to LstPedidos.Count - 1 do
      begin
        try
          obPedido := TIntegracaoPedido.Create;
          try
            obPedido.ArquivoJsonPedido := LstPedidos.Strings[I];

            if obPedido.ImportarPedido then
              DeleteFile(LstPedidos.Strings[I]);
          finally
            obPedido.Free;
          end;
        Except
          on E: Exception do
            GravarLog('Erro ao importar pedido - ' + E.Message);
          else
            GravarLog('Erro ao importar pedido - Erro desconhecido!');
        End; // try
      end; // for I := 0 to LstPedidos.Count - 1 do
    Except
      on E: Exception do
      begin
        GravarLog('Erro ao enviar Referência - ' + E.Message);
      end
      else
      begin
        GravarLog('Erro ao enviar Referência - Erro desconhecido!');
      end;
    End;

  finally
    obIntegracao.Free;
    obConfig.Free;
  end;
end;

// procedure TWooControl.LimparLogs;
// begin
// FcdsWebLog.First;
// while not FcdsWebLog.Eof do
// begin
// if cdsWebLog.FieldByName('Erro').AsString <> 'S' then
// begin
// T2.cdsC1.Active := False;
// T2.qC1.Close;
// T2.qC1.SQL.Clear;
// T2.qC1.SQL.Add('Delete From WebLog');
// T2.qC1.SQL.Add('Where Id = ' + FcdsWebLog.FieldByName('Id').AsString);
// T2.qC1.ExecSQL();
// end;
//
// Application.ProcessMessages;
// FcdsWebLog.Next;
// end;
// end;

function TWooControl.LocalizarProduto(ACodigo: String): TWooProduto;
var
  AProduto: TWooProduto;
begin
  Result := nil;

  for AProduto in FProdutos do
  begin
    Application.ProcessMessages;
    if AProduto.Produto.SkuCodigo = ACodigo then
    begin
      Result := AProduto;
      break;
    end;
  end;
end;

procedure TWooControl.SalvarListaPedidos(ALstPedidos: TStringList);
var
  I: Integer;
  Txt: TextFile;
  Arquivo: String;
begin
  // Salva todos os pedidos em forma de arquivo para garantir que sejam lidos
  for I := 0 to ALstPedidos.Count - 1 do
  begin
    // Gera um nome único para o arquivo
    Arquivo := GetDiretorioPedidos + '/' + FormatDateTime('yyyyddmm_hhnnss', Now) + '_' + IntToStr(Random(99999999)) + '.json';
    while FileExists(Arquivo) do
      Arquivo := GetDiretorioPedidos + '/' + FormatDateTime('yyyyddmm_hhnnss', Now) + '_' + IntToStr(Random(99999999)) + '.json';

    try
      Assign(Txt, Arquivo);
      Rewrite(Txt);
      Writeln(Txt, ALstPedidos.Strings[I]);
    finally
      Flush(Txt);
      CloseFile(Txt);
    end;
  end;
end;

procedure TWooControl.SetAlxSaldo(const Value: String);
begin
  FAlxSaldo := Value;
end;

procedure TWooControl.SetcdsWebLog(const Value: TClientDataSet);
begin
  FcdsWebLog := Value;
end;

procedure TWooControl.SetDataUltima(const Value: TDateTime);
begin
  FDataUltima := Value;
end;

procedure TWooControl.SetProdutos(const Value: TArray<TWooProduto>);
begin
  FProdutos := Value;
end;

procedure TWooControl.SetStrLogChave(const Value: TStringList);
begin
  FStrLogChave := Value;
end;

procedure TWooControl.SetUltimaSincronizacao(AData: TDate);
begin
  GravaCfg(T2.qC1, 'CFG_WOOSIN', FormatDateTime('dd/mm/yyyy', AData));
end;

end.
