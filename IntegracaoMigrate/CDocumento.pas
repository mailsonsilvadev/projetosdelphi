unit CDocumento;

interface

uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, U_MigComm, DBClient,
  Menus, ExtCtrls,
  {$IFDEF VER340}
  System.JSON,
  {$ELSE}
  DBXJson,
  {$ENDIF}
  ComCtrls, U_Sisproc, stdctrls, Variants, System.Actions, Data.DB;

type
  TDocumento = class(TObject)
  private
    FobDocumentos: TJSONArray;
    FRetornoJson: String;
    FcdsRetorno: TClientDataSet;
    FcdsRetornoLote: TClientDataSet;
    procedure SetobDocumentos(const Value: TJSONArray);

    function  AddDocto: TJSONArray;
    procedure SetRetornoJson(const Value: String);
    procedure SetcdsRetorno(const Value: TClientDataSet);
    function  GetcdsRetorno: TClientDataSet;
    procedure CriarCdsRetorno(AcdsRetorno: TClientDataSet);
    procedure InterpretarRetorno(AcdsRetorno: TClientDataSet);
    procedure SetcdsRetornoLote(const Value: TClientDataSet);
    function  GetcdsRetornoLote: TClientDataSet;
  public
    constructor Create;
    procedure Clear;

    function AddRps: TJSONObject;

    //function EnviarDocumentos: String;
    function EnviarDocumentos(ATipo: String): String;
    function ConsultarDocumentos: Boolean;

    property obDocumentos: TJSONArray read FobDocumentos write SetobDocumentos;
    property RetornoJson: String read FRetornoJson write SetRetornoJson;
    property cdsRetorno: TClientDataSet read GetcdsRetorno write SetcdsRetorno;
    property cdsRetornoLote: TClientDataSet read GetcdsRetornoLote write SetcdsRetornoLote;
  end;

implementation

uses U_T2;

{ TDocumento }

function TDocumento.AddDocto: TJSONArray;
var
  obDocumento, obDocPropriedades: TJSONObject;
  obRpss: TJSONArray;
begin
  FobDocumentos.AddElement(TJSONObject.Create);

  try
    obDocumento := TJSONObject(FobDocumentos.Get(FobDocumentos.Size - 1));
  except
    obDocumento := nil;
  end;

  obDocPropriedades := TJSONObject.Create;
  obDocumento.AddPair('Documento', obDocPropriedades);

  obDocPropriedades.AddPair('ModeloDocumento', TJSONString.Create('NFSE'));
  obDocPropriedades.AddPair('Versao', TJSONNumber.Create('1.00'));

  obRpss := TJSONArray.Create;
  obDocPropriedades.AddPair('RPS', obRpss);

  Result := obRpss;
end;

function TDocumento.AddRps: TJSONObject;
var
  AobRpss: TJSONArray;
begin
  AobRpss := AddDocto;

  AobRpss.AddElement(TJSONObject.Create);
  try
    Result := TJSONObject(AobRpss.Get(AobRpss.Size - 1));
  except
    Result := nil;
  end;
end;

procedure TDocumento.Clear;
begin
  while FobDocumentos.Size > 0 do
    FobDocumentos.Remove(0);
end;

function TDocumento.ConsultarDocumentos: Boolean;
var
  obComm: TMigComm;
begin
  obComm := TMigComm.Create;
  try
    cdsRetornoLote.EmptyDataSet;

    cdsRetorno.First;
    while not cdsRetorno.Eof do
    begin
      obComm.DocJson := EmptyStr;

      obComm.UrlAdicional := '&CnpjEmissor=94008323000175' +
        '&NumeroInicial='    + Nst(cdsRetorno.FieldByName('DocNumero').AsInteger) +
        '&NumeroFinal='      + Nst(cdsRetorno.FieldByName('DocNumero').AsInteger) +
        '&Serie='            + Nst(cdsRetorno.FieldByName('DocSerie').AsString) +
        '&Versao=4.00'       +
        '&CnpjEmpresa='      + LimpaNumero(BuscaEmpresa(T2.qEmpresa, 'CGCMF')) +
        '&tpAmb='            + BuscaCFG2(T2.qgSepeCfg, 'SepeCFG', 'CFG_NFSAMB', 'NFSe -> Ambiente 1-Produção / 2-Homologação', '1', 1, 1) +
        '&ParmXMLLink=S'     +
        '&ParmXMLCompleto=S' +
        '&ParmPDFBase64=S'   +
        '&ParmPDFLink=S'     +
        '&ParmEventos=N'     +
        '&ParmSituacao=S'    +
        '&ParmTipoImpressao';

      obComm.TipoRequisicao := TTipoRequisicao.trConsulta;

      FRetornoJson := obComm.Enviar;
      InterpretarRetorno(cdsRetornoLote);

      Application.ProcessMessages;
      cdsRetorno.Next;
    end;

    Result := True;
  finally
    obComm.Free;
  end;
end;

constructor TDocumento.Create;
begin
  FobDocumentos := TJSONArray.Create;
end;

procedure TDocumento.CriarCdsRetorno(AcdsRetorno: TClientDataSet);
begin
  if AcdsRetorno.Active then
  begin
    AcdsRetorno.EmptyDataSet;
    Exit;
  end;

  AcdsRetorno.Close;
  with AcdsRetorno.FieldDefs do
  begin
    Clear;

    Add('Codigo',             ftInteger,  0, false);
    Add('Descricao',          ftString, 500, false);

    Add('DocModelo',          ftString, 10, false);
    Add('DocNumero',          ftInteger, 0, false);
    Add('DocSerie',           ftString, 10, false);

    Add('DocProtocolo',       ftString,  100, false);
    Add('DocSitCodigo',       ftString,   10, false);
    Add('DocSitDescricao',    ftString, 5000, false);
    Add('DocChaAcesso',       ftString,  100, false);

    Add('DocPDFBase64',       ftWideMemo, 100000, false);
    Add('DocXMLBase64',       ftWideMemo, 100000, false);

    Add('DocXML',             ftWideMemo, 100000, false);
    Add('DocPDF',             ftWideMemo, 100000, false);

    Add('SitCodigo',          ftInteger,  0, false);
    Add('SitDescricao',       ftString, 500, false);

    Add('CodMsg',             ftInteger,   0, false);
    Add('DscMsg',             ftString, 5000, false);

    Add('NFSeNumero',         ftInteger,   0, false);
    Add('NFSeCodVerificacao', ftString,  500, false);
    Add('NFSeDataEmissao',    ftString,  500, false);

    Add('DocDhAut',           ftString,   20, false);

  end;

  AcdsRetorno.CreateDataSet;
  AcdsRetorno.IndexFieldNames := 'Codigo;Descricao;DocSerie;DocNumero';
  AcdsRetorno.Open;
end;

function TDocumento.EnviarDocumentos(ATipo: String): String;
var
  obComm : TMigComm;
  ATipoTr: TTipoRequisicao;
begin
  if LowerCase(ATipo) = 'enviorps' then
     ATipoTr:= TTipoRequisicao.trEnvio;

  if LowerCase(ATipo) = 'cancelarnfse' then
     ATipoTr:= TTipoRequisicao.trEvento;

  if LowerCase(ATipo) = 'inutilizarnfse' then
     ATipoTr:= TTipoRequisicao.trInutilizacao;

  obComm := TMigComm.Create;
  try
    cdsRetorno.EmptyDataSet;

    obComm.DocJson        := obDocumentos.ToString;
    obComm.UrlAdicional   := EmptyStr;
    obComm.TipoRequisicao := ATipoTr; //TTipoRequisicao.trEnvio;
    FRetornoJson          := obComm.Enviar;
    Result                := FRetornoJson;

    InterpretarRetorno(cdsRetorno);
  finally
    obComm.Free;
  end;
end;

function TDocumento.GetcdsRetorno: TClientDataSet;
begin
  if not Assigned(FcdsRetorno) then
  begin
    FcdsRetorno := TClientDataSet.Create(T2);
    CriarCdsRetorno(FcdsRetorno);
  end;

  Result := FcdsRetorno;
end;

function TDocumento.GetcdsRetornoLote: TClientDataSet;
begin
  if not Assigned(FcdsRetornoLote) then
  begin
    FcdsRetornoLote := TClientDataSet.Create(T2);
    CriarCdsRetorno(FcdsRetornoLote);
  end;

  Result := FcdsRetornoLote;
end;

procedure TDocumento.InterpretarRetorno(AcdsRetorno: TClientDataSet);
var
  SeqList: Integer;
  obJsonArray, obDocsAr: TJSONArray;
  obJson, obDoc, obSit, obMsg, obNfse, obResumo: TJSONObject;
  ItemDoc, Item: Integer;

  txt: TextFile;
begin
  Item := 0;

  obJsonArray := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(FRetornoJson), Item) as TJSONArray;

  if obJsonArray = nil then
    raise Exception.Create('Não foi possível ler retorno do processamento: ' + FRetornoJson);

  try
    obJson := obJsonArray.Get(Item) as TJSONObject;
  except
    obJson := nil;
  end;

  while obJson <> nil do
  begin
    Try
      ItemDoc := 0;
      obDocsAr := TJSONArray(obJson.GetValue('Documentos'));
      obDoc := obDocsAr.Get(ItemDoc) as TJSONObject;
    Except
      obDoc := nil;

      // quando volta um JSON sem a parte 'Documentos', tem que ter pelo menos o código do erro e a descrição
      AcdsRetorno.Append;
      Try
        AcdsRetorno.FieldByName('Codigo').AsInteger := Ivl(obJson.GetValue('Codigo').Value);
      Except
        AcdsRetorno.FieldByName('Codigo').AsInteger := 0;
      End;

      Try
        AcdsRetorno.FieldByName('Descricao').AsString := Nst(obJson.GetValue('Descricao').Value);
      Except
        AcdsRetorno.FieldByName('Descricao').AsString := '';
      End;
      AcdsRetorno.Post;
    End;

    while obDoc <> nil do
    begin
      AcdsRetorno.Append;

      Try
        AcdsRetorno.FieldByName('Codigo').AsInteger := Ivl(obJson.GetValue('Codigo').Value);
      Except
        AcdsRetorno.FieldByName('Codigo').AsInteger := 0;
      End;

      Try
        AcdsRetorno.FieldByName('Descricao').AsString := Nst(obJson.GetValue('Descricao').Value);
//        AcdsRetorno.FieldByName('Descricao').AsString := Utf8ToAnsi(obJson.GetValue('Descricao').Value);
      Except
        AcdsRetorno.FieldByName('Descricao').AsString := '';
      End;

      Try
        AcdsRetorno.FieldByName('DocModelo').AsString := Nst(obDoc.GetValue('DocModelo').Value);
      Except
      End;
      Try
        AcdsRetorno.FieldByName('DocNumero').AsString := Nst(obDoc.GetValue('DocNumero').Value);
      Except
      End;
      Try
        AcdsRetorno.FieldByName('DocSerie').AsString := Nst(obDoc.GetValue('DocSerie').Value);
      Except
      End;
      Try
        AcdsRetorno.FieldByName('DocProtocolo').AsString := Nst(obDoc.GetValue('DocProtocolo').Value);
      Except
      End;
      Try
        AcdsRetorno.FieldByName('DocSitCodigo').AsString := Nst(obDoc.GetValue('DocSitCodigo').Value);
      Except
      End;
      Try
        AcdsRetorno.FieldByName('DocSitDescricao').AsString := Utf8ToAnsi(obDoc.GetValue('DocSitDescricao').Value);
//        AcdsRetorno.FieldByName('DocSitDescricao').AsString := Nst(obDoc.GetValue('DocSitDescricao').Value);
      Except
      End;
      Try
        AcdsRetorno.FieldByName('DocChaAcesso').AsString := Nst(obDoc.GetValue('DocChaAcesso').Value);
      Except
      End;
      Try
        AcdsRetorno['DocPDFBase64'] := obDoc.GetValue('DocPDFBase64').Value;
      Except
      End;
      Try
        AcdsRetorno['DocXMLBase64'] := obDoc.GetValue('DocXMLBase64').Value;
      Except
      End;
      Try
        AcdsRetorno['DocPDF'] := obDoc.GetValue('DocPDF').Value;
      Except
      End;
      Try
        AcdsRetorno['DocXML'] := obDoc.GetValue('DocXML').Value;
      Except
      End;
      Try
        obSit := TJSONObject(obDoc.GetValue('Situacao'));
      Except
      End;
      Try
        AcdsRetorno.FieldByName('SitCodigo').AsInteger := Ivl(obSit.GetValue('SitCodigo').Value);
      Except
      End;
      Try
        AcdsRetorno.FieldByName('SitDescricao').AsString := Nst(obSit.GetValue('SitDescricao').Value);
//        AcdsRetorno.FieldByName('SitDescricao').AsString := Utf8ToAnsi(obSit.GetValue('SitDescricao').Value);
      Except
      End;

      Try
        obMsg := TJSONObject(obDoc.GetValue('MensagemSefaz'));
      Except
      End;
      Try
        AcdsRetorno.FieldByName('CodMsg').AsInteger := Ivl(obMsg.GetValue('CodMsg').Value);
      Except
      End;
      Try
        AcdsRetorno.FieldByName('DscMsg').AsString := Nst(obMsg.GetValue('DscMsg').Value);
      Except
      End;

      Try
        obNfse := TJSONObject(obDoc.GetValue('NFSe'));
      Except
      End;
      Try
        AcdsRetorno.FieldByName('NFSeNumero').AsInteger := Ivl(obNfse.GetValue('NFSeNumero').Value);
      Except
      End;
      Try
        AcdsRetorno.FieldByName('NFSeCodVerificacao').AsString := Nst(obNfse.GetValue('NFSeCodVerificacao').Value);
      Except
      End;
      Try
        AcdsRetorno.FieldByName('NFSeDataEmissao').AsString := Nst(obNfse.GetValue('NFSeDataEmissao').Value);
      Except
      End;
      Try
        AcdsRetorno.FieldByName('DocDhAut').AsString := Nst(obNfse.GetValue('DocDhAut').Value);
      Except
      End;
      if AcdsRetorno.FieldByName('NFSeDataEmissao').AsString.Trim.IsEmpty then
      begin
        Try
          obResumo := TJSONObject(obDoc.GetValue('Resumo'));
        Except
        End;
        Try
          AcdsRetorno.FieldByName('NFSeDataEmissao').AsString := Nst(obResumo.GetValue('DocDataEmissao').Value);
        Except
        End;
      end;

      if AcdsRetorno.FieldByName('SitCodigo').AsInteger = 0 then
      begin
        if Ivl(obDoc.GetValue('DocSitCodigo').Value) = 999 then
        begin
          Try
            AcdsRetorno.FieldByName('SitCodigo').AsInteger := Ivl(obDoc.GetValue('DocSitCodigo').Value);
          Except
          End;
          Try
            AcdsRetorno.FieldByName('SitDescricao').AsString := Utf8ToAnsi(obDoc.GetValue('DocSitDescricao').Value);
          Except
          End;
        end;
      end;

      Inc(ItemDoc);
      try
        obDoc := obDocsAr.Get(ItemDoc) as TJSONObject;
      except
        obDoc := nil;
      end;

      AcdsRetorno.Post;
    end;

    Inc(Item);
    try
      obJson := obJsonArray.Get(Item) as TJSONObject;
    except
      obJson := nil;
    end;
  end;
end;

procedure TDocumento.SetcdsRetorno(const Value: TClientDataSet);
begin
  FcdsRetorno := Value;
end;

procedure TDocumento.SetcdsRetornoLote(const Value: TClientDataSet);
begin
  FcdsRetornoLote := Value;
end;

procedure TDocumento.SetobDocumentos(const Value: TJSONArray);
begin
  FobDocumentos := Value;
end;

procedure TDocumento.SetRetornoJson(const Value: String);
begin
  FRetornoJson := Value;
end;

end.
