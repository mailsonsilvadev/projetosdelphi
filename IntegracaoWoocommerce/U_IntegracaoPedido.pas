unit U_IntegracaoPedido;

interface

uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, CPedidoControl, COrcamentocst, COrcaPag,
  Menus, ExtCtrls, ComCtrls, U_Sisproc, stdctrls, Variants, System.Actions, Data.DBXJSON, CClientesFull, CItensorccst;

type
  TIntegracaoPedido = class(TObject)
  private
    FobPedido: TPedidoControl;
    FArquivoJsonPedido: String;
    FobJson: TJsonObject;
    procedure SetobPedido(const Value: TPedidoControl);
    procedure SetArquivoJsonPedido(const Value: String);
    procedure SetobJson(const Value: TJsonObject);
    function GetCidade(ANomeCidade: String): String;
    function SalvarCliente: String;
    procedure SalvarPedido(ACodCli: String);
    procedure SalvarPagamento(APedido: String);
    procedure SalvarItens(APedido, ACodCli: String);
    procedure ExcluiItens(Orc: String);
    function FormatarValor(AValor: String): Real;
    function LocalizarCondicao(AParcelas: String): String;
  public
    constructor Create;

    property obPedido: TPedidoControl read FobPedido write SetobPedido;
    property ArquivoJsonPedido: String read FArquivoJsonPedido write SetArquivoJsonPedido;
    property obJson: TJsonObject read FobJson write SetobJson;

    function ImportarPedido: Boolean;
  end;

implementation

uses U_T2;

{ TIntegracaoPedido }

constructor TIntegracaoPedido.Create;
begin
  inherited Create;
  obPedido := TPedidoControl.Create;
end;

procedure TIntegracaoPedido.ExcluiItens(Orc: String);
begin
  T2.qC3.SQL.Clear;
  T2.qC3.SQL.Add('Delete From ORCAITE Where ITE_ORCNRO = ' + #39 + Orc + #39);
  T2.qC3.ExecSQL;
end;

function TIntegracaoPedido.FormatarValor(AValor: String): Real;
begin
  Result := Nvl(Strtran(AValor, '.', ','));
end;

function TIntegracaoPedido.GetCidade(ANomeCidade: String): String;
var
  Q: String;
begin
  Q := 'Select Mun_Codigo';
  Q := Q + #10#13 + 'From CadaMun';
  Q := Q + #10#13 + 'Where Mun_Descri = :Descri';

  T2.cdsC1.Active := False;
  T2.qC1.Close;
  T2.qC1.SQL.Clear;
  T2.qC1.SQL.Add(Q);
  T2.qC1.ParamByName('Descri').AsString := UpperCase(Remove_Acentos(ANomeCidade));
  T2.cdsC1.Active := True;

  // Se não localiza a cidade pelo nome SEM ACENTO então tenta COM ACENTO. No Wsepe o padrão é sem acento
  if T2.cdsC1.IsEmpty then
  begin
    T2.cdsC1.Active := False;
    T2.qC1.Close;
    T2.qC1.SQL.Clear;
    T2.qC1.SQL.Add(Q);
    T2.qC1.ParamByName('Descri').AsString := UpperCaseAcentuado(ANomeCidade);
    T2.cdsC1.Active := True;
  end;

  Result := T2.cdsC1.FieldByName('Mun_Codigo').AsString;
end;

function TIntegracaoPedido.ImportarPedido: Boolean;
var
  Txt: TextFile;
  TextoJson: String;
  CodCli: string;
begin
  Result := False;
  try
    AssignFile(Txt, FArquivoJsonPedido);
    Reset(Txt);
    Readln(Txt, TextoJson);

    if TextoJson.Trim = EmptyStr then
      raise Exception.Create('Arquivo JSON está vazio!');

    obJson := TJsonObject.ParseJSONValue(TEncoding.UTF8.GetBytes(TextoJson), 0) as TJsonObject;
    if obJson = nil then
      raise Exception.Create('Erro ao converter arquivo JSON em objeto!');

    { Salva apenas pedidos pagos }
    if obJson.GetValue('status').Value = 'processing' then
    begin
      CodCli := SalvarCliente;
      SalvarPedido(CodCli);
      Result := True;
    end;
  finally
  
    Flush(Txt);
    CloseFile(Txt);
  end;
end;

function TIntegracaoPedido.LocalizarCondicao(AParcelas: String): String;
var
  Condicao, Q: String;
  Parcelas: Integer;
  I: Integer;
begin
  Parcelas := StrToIntDef(AParcelas, 0);
  if Parcelas = 0 then
    Condicao := '''00'', ''0'', ''A VISTA'''
  else
  begin
    for I := 1 to Parcelas do
    begin
      if not Condicao.IsEmpty then
        Condicao := Condicao + '/';

      Condicao := Condicao + IntToStr(I * 30);
    end;

    Condicao := '''' + Condicao + '''';
  end;

  Q := 'Select Pgnf_Cod From ScraPgnf';
  Q := Q + #10#13 + 'Where Pgnf_Ativo = ''S''';
  Q := Q + #10#13 + 'and Pgnf_Cond in (' + Condicao + ')';

  T2.cdsC1.Active := False;
  T2.qC1.Close;
  T2.qC1.SQL.Clear;
  T2.qC1.SQL.Add(Q);
  T2.cdsC1.Active := True;

  T2.cdsC1.First;
  Result := T2.cdsC1.FieldByName('Pgnf_Cod').AsString;
end;

procedure TIntegracaoPedido.SetobJson(const Value: TJsonObject);
begin
  FobJson := Value;
end;

procedure TIntegracaoPedido.SetobPedido(const Value: TPedidoControl);
begin
  FobPedido := Value;
end;

function TIntegracaoPedido.SalvarCliente: String;
var
  obJsonCliente: TJsonObject;
  obCliente: TClientesFull;
begin
  obJsonCliente := TJsonObject(obJson.GetValue('billing'));
  if not Assigned(obJsonCliente) then
    Raise Exception.Create('Cliente do faturamento não encontrado!');

  obCliente := TClientesFull.Create();
  try
    if obJsonCliente.GetValue('cnpj').Value.Trim.IsEmpty then
      obCliente.Consultar(obJsonCliente.GetValue('cpf').Value)
    else
      obCliente.Consultar(obJsonCliente.GetValue('cnpj').Value);

    if obCliente.getCli_codigo.IsEmpty then
    begin
      obCliente.setCli_codigo(NumeroAutomatico(T2.qgSepeCfg, 'SepeCFG', 'CFG_CODCLI', 6));
      obCliente.setCli_dig(Calc_Dig(obCliente.getCli_codigo));
    end;

    obCliente.setCli_nome(obJsonCliente.GetValue('first_name').Value + ' ' + obJsonCliente.GetValue('last_name').Value);
    obCliente.setCli_fantas(obJsonCliente.GetValue('company').Value);

    obCliente.setCli_end(obJsonCliente.GetValue('address_1').Value);
    obCliente.setCli_entend(obJsonCliente.GetValue('address_1').Value);
    obCliente.setCli_cobrar(obJsonCliente.GetValue('address_1').Value);

    obCliente.setCli_endcom(obJsonCliente.GetValue('address_2').Value);
    obCliente.setCli_entcom(obJsonCliente.GetValue('address_2').Value);
    obCliente.setCli_cobcom(obJsonCliente.GetValue('address_2').Value);

    obCliente.setCli_codcid(GetCidade(obJsonCliente.GetValue('city').Value));
    obCliente.setCli_entccd(obCliente.getCli_codcid);
    obCliente.setCli_cobccd(obCliente.getCli_codcid);

    obCliente.setCli_uf(obJsonCliente.GetValue('state').Value);
    obCliente.setCli_entuf(obCliente.getCli_uf);
    obCliente.setCli_cobuf(obCliente.getCli_uf);

    obCliente.setCli_cep(LimpaNumero(obJsonCliente.GetValue('postcode').Value));
    obCliente.setCli_entcep(obCliente.getCli_cep);
    obCliente.setCli_cobcep(obCliente.getCli_cep);

    obCliente.setCli_nroend(LimpaNumero(obJsonCliente.GetValue('number').Value));
    obCliente.setCli_entnro(obCliente.getCli_nroend);
    obCliente.setCli_cobnro(obCliente.getCli_nroend);

    obCliente.setCli_bairro(obJsonCliente.GetValue('neighborhood').Value);
    obCliente.setCli_entbai(obCliente.getCli_bairro);
    obCliente.setCli_cobbai(obCliente.getCli_bairro);

    obCliente.setCli_email(obJsonCliente.GetValue('email').Value);
    obCliente.setCli_dddfon(Copy(obJsonCliente.GetValue('phone').Value, 1, 2));
    obCliente.setCli_fone(Copy(obJsonCliente.GetValue('phone').Value, 3, 10));

    if (obJsonCliente.GetValue('persontype').Value = 'J') or (obCliente.getCli_cgccpf.Length > 11) then
      obCliente.setCli_tipo('1')
    else
      obCliente.setCli_tipo('2');

    obCliente.setCli_insest(obJsonCliente.GetValue('ie').Value);
    obCliente.setCli_celula(obJsonCliente.GetValue('cellphone').Value);

    obCliente.setCli_dtaatu(Date);
    obCliente.setCli_datatu(Date);
    obCliente.setCli_data(Date);
    obCliente.setCli_usratu('ECOMMERCE');

    obCliente.setCli_Frete('');
    obCliente.setCli_ConRev('C');
    obCliente.setCli_TpoTrb('0');
    obCliente.setCli_Public('N');
    obCliente.setCli_Sit('1');

    obCliente.setCli_bloini(0);
    obCliente.setCli_blofim(0);

    obCliente.Salvar;

    Result := obCliente.getCli_codigo;
  finally
    obCliente.Free;
  end;
end;

procedure TIntegracaoPedido.SalvarItens(APedido, ACodCli: String);
var
  obItemOrcamento: TItensorccst;
  obJsonItemValue: TJSONValue;
  obJsonItem: TJsonObject;
  obJsonArray: TJSONArray;
  obCliente: TClientesFull;
  NrItem: Integer;
begin
  obItemOrcamento := TItensorccst.Create;
  obCliente := TClientesFull.Create;
  try
    ExcluiItens(Trim(APedido));

    NrItem := 0;

    // Carrega o cliente para diferenciar as CFOPs de dentro e fora do estado
    obCliente.setCli_codigo(ACodCli);
    obCliente.Consultar();

    obJsonArray := obJson.GetValue('line_items') as TJSONArray;
    for obJsonItemValue in obJsonArray do
    begin
      Inc(NrItem);
      obJsonItem := obJsonItemValue as TJsonObject;
      obItemOrcamento.setIte_orcnro(APedido);
      obItemOrcamento.setIte_nroite(StrZero(Nst(NrItem), 4));
      obItemOrcamento.setIte_codtab(Nst(LeSepeRel('Ecommerce', 'edtTabPadrao', T2.qSepeCfg)));

      if UpperCaseAcentuado(obCliente.getCli_uf) = BuscaEmpresa(T2.qC1, 'ESTADO') then
      begin
        // Dentro do estado
        obItemOrcamento.setIte_natopr(Nst(LeSepeRel('Ecommerce', 'edtNatOprPadrao', T2.qSepeCfg)));
        obItemOrcamento.setIte_codopr(Nst(LeSepeRel('Ecommerce', 'edtCodOprPadrao', T2.qSepeCfg)));
      end
      else
      begin
        // Fora do estado
        obItemOrcamento.setIte_natopr(Nst(LeSepeRel('Ecommerce', 'edtNatOprInter', T2.qSepeCfg)));
        obItemOrcamento.setIte_codopr(Nst(LeSepeRel('Ecommerce', 'edtCodOprInter', T2.qSepeCfg)));
      end;

      obItemOrcamento.setIte_codalx(Nst(LeSepeRel('Ecommerce', 'edtAlxPadrao', T2.qSepeCfg)));
      obItemOrcamento.setIte_codtna(Nst(LeSepeRel('Ecommerce', 'edtCodTna', T2.qSepeCfg)));
      obItemOrcamento.setIte_codpro(Nst(obJsonItem.GetValue('sku').Value));
      obItemOrcamento.setIte_qtde(FormatarValor(obJsonItem.GetValue('quantity').Value));
      obItemOrcamento.setIte_qtdsld(FormatarValor(obJsonItem.GetValue('quantity').Value));
      obItemOrcamento.setIte_vlrunt(FormatarValor(obJsonItem.GetValue('price').Value));
      obItemOrcamento.setIte_vlrtot(FormatarValor(obJsonItem.GetValue('total').Value));
      obItemOrcamento.setIte_vlrdes(0);
      obItemOrcamento.setIte_prdes(0);
      obItemOrcamento.setIte_usratu('ECOMMERCE');
      obItemOrcamento.setIte_datatu(Date);
      obItemOrcamento.Incluir;
    end;
  finally
    obItemOrcamento.Free;
    obCliente.Free;
  end;
end;

procedure TIntegracaoPedido.SalvarPagamento(APedido: String);
var
  obPagamento: TOrcaPag;
  obJsonItemValue: TJSONValue;
  obJsonItem: TJsonObject;
  obJsonArray: TJSONArray;
  Banco, TipoPagamento, Parcelas, CodParc: String;
  obOrcamento: TOrcamentocst;
begin
  obOrcamento := TOrcamentocst.Create();
  obPagamento := TOrcaPag.Create;
  try
    T2.qC3.SQL.Clear;
    T2.qC3.SQL.Add('Delete From ORCAPAG Where PAG_ORCNRO = ' + #39 + APedido + #39);
    T2.qC3.ExecSQL;

    obJsonArray := obJson.GetValue('meta_data') as TJSONArray;
    for obJsonItemValue in obJsonArray do
    begin
      obJsonItem := obJsonItemValue as TJsonObject;

      if UpperCaseAcentuado(obJsonItem.GetValue('key').Value) = 'TIPO DE PAGAMENTO' then
        TipoPagamento := obJsonItem.GetValue('value').Value;

      if UpperCaseAcentuado(obJsonItem.GetValue('key').Value) = 'PARCELAS' then
        Parcelas := obJsonItem.GetValue('value').Value;
    end;

    Banco := 'PAGSEGURO';

    obPagamento.setPag_id(obPagamento.Auto_inc_pag_id(1));
    obPagamento.setPag_orcnro(APedido);
    obPagamento.setPag_tipo(TipoPagamento);
    obPagamento.setPag_banco(Banco);
    obPagamento.setPag_cond(Parcelas);
    obPagamento.setPag_usratu('ECOMMERCE');
    obPagamento.setPag_datatu(Date);
    obPagamento.Incluir;

    // Prioriza a condição de pagamento padrão, para casos de pagseguro onde o cliente pode parcelar a compra mas o vendedor recebe a vista
    if LeSepeRel('Ecommerce', 'edtCodPag', T2.qSepeCfg).Trim.IsEmpty then
    begin
      CodParc := LocalizarCondicao(Parcelas);
      if not CodParc.IsEmpty then
      begin
        obOrcamento.setCab_orcnro(APedido);
        if obOrcamento.Consultar then
        begin
          obOrcamento.setCab_codpag(CodParc);
          obOrcamento.Alterar;
        end;
      end;
    end;
  finally
    obPagamento.Free;
    obOrcamento.Free;
  end;
end;

procedure TIntegracaoPedido.SalvarPedido(ACodCli: String);
var
  obOrcamento: TOrcamentocst;
begin
  obOrcamento := TOrcamentocst.Create();
  try
    obOrcamento.setCab_orcnro('W' + StrZero(obJson.GetValue('id').Value, 6));
    obOrcamento.Consultar;
    Try
      obOrcamento.setCab_data(StrToDate(Copy(obJson.GetValue('date_created').Value, 9, 2) + '/' + Copy(obJson.GetValue('date_created').Value, 6, 2) + '/' + Copy(obJson.GetValue('date_created').Value, 1, 4)));
    except
      obOrcamento.setCab_data(0);
    end;
    obOrcamento.setCab_codcli(ACodCli);
    obOrcamento.setCab_codpag(LeSepeRel('Ecommerce', 'edtCodPag', T2.qSepeCfg));
    obOrcamento.setCab_codtrs(LeSepeRel('Ecommerce', 'CODTRS', T2.qSepeCfg));
    obOrcamento.setCab_codven(LeSepeRel('Ecommerce', 'CODVEN', T2.qSepeCfg));
    obOrcamento.setCab_codger(LeSepeRel('Ecommerce', 'CODGER', T2.qSepeCfg));
    obOrcamento.setCab_codsup(LeSepeRel('Ecommerce', 'CODREP', T2.qSepeCfg));
    // obOrcamento.setCab_obs(CabObs.Text);

    obOrcamento.setCab_vlrfre(FormatarValor(obJson.GetValue('shipping_total').Value));
    if obOrcamento.getCab_vlrfre = 0 then
      obOrcamento.setCab_tpofre('2')
    else
      obOrcamento.setCab_tpofre('1');
      
    obOrcamento.setCab_total(FormatarValor(obJson.GetValue('total').Value));

    obOrcamento.setCab_pedorc(obJson.GetValue('id').Value);
    obOrcamento.setCab_usratu('ECOMMERCE');
    obOrcamento.setCab_datatu(Date);
    obOrcamento.Salvar;
    SalvarItens(obOrcamento.getCab_orcnro, ACodCli);
    SalvarPagamento(obOrcamento.getCab_orcnro);
  finally
    obOrcamento.Free;
  end;
end;

procedure TIntegracaoPedido.SetArquivoJsonPedido(const Value: String);
begin
  FArquivoJsonPedido := Value;
end;

end.
