unit U_WooDadosProduto;

interface

uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Data.DBXJSON,
  Menus, ExtCtrls, ComCtrls, U_Sisproc, stdctrls, Variants, System.Actions, CTamanhoFull, System.Generics.Collections;

type
  TWooDadosProduto = class(TObject)
  private
    FSkuCodigo: String;
    FName: String;
    FCor: string;
    FShortDescription: String;
    FSlug: String;
    FDescription: String;
    FStockQuantity: Integer;
    FWeight: string;
    FSalePrice: String;
    FRegularPrice: String;
    FTamanho: string;
    FAtivo: Boolean;
    FIdWeb: Integer;
    FisVariacao: Boolean;
    FAltura: String;
    FLargura: String;
    FComprimento: String;
    FExcluir: Boolean;
    FIdWebLog: Integer;
    procedure SetCor(const Value: string);
    procedure SetDescription(const Value: String);
    procedure SetName(const Value: String);
    procedure SetRegularPrice(const Value: String);
    procedure SetSalePrice(const Value: String);
    procedure SetShortDescription(const Value: String);
    procedure SetSkuCodigo(const Value: String);
    procedure SetSlug(const Value: String);
    procedure SetStockQuantity(const Value: Integer);
    procedure SetTamanho(const Value: string);
    procedure SetWeight(const Value: string);
    procedure SetAtivo(const Value: Boolean);
    procedure SetIdWeb(const Value: Integer);
    procedure SetisVariacao(const Value: Boolean);
    function GetAtributoCor(): String;
    function GetAtributoTamanho(): String;
    function GetAtributos: String;
    procedure SetAltura(const Value: String);
    procedure SetComprimento(const Value: String);
    procedure SetLargura(const Value: String);
    procedure SetExcluir(const Value: Boolean);
    procedure SetIdWebLog(const Value: Integer);
  public
    constructor Create;

    property IdWeb: Integer read FIdWeb write SetIdWeb;
    property Name: String read FName write SetName;
    property Slug: String read FSlug write SetSlug;
    property Description: String read FDescription write SetDescription;
    property ShortDescription: String read FShortDescription write SetShortDescription;
    property SkuCodigo: String read FSkuCodigo write SetSkuCodigo;
    property RegularPrice: String read FRegularPrice write SetRegularPrice;
    property SalePrice: String read FSalePrice write SetSalePrice;
    property StockQuantity: Integer read FStockQuantity write SetStockQuantity;
    property Weight: string read FWeight write SetWeight;
    property Cor: string read FCor write SetCor; // Quando mais que um separa por com pipe. Ex: x1|x2|x3
    property Tamanho: string read FTamanho write SetTamanho; // Quando mais que um separa por com pipe. Ex: x1|x2|x3
    property isVariacao: Boolean read FisVariacao write SetisVariacao;
    property Ativo: Boolean read FAtivo write SetAtivo;
    property Excluir: Boolean read FExcluir write SetExcluir;
    property IdWebLog: Integer read FIdWebLog write SetIdWebLog;
    property Altura: String read FAltura write SetAltura;
    property Largura: String read FLargura write SetLargura;
    property Comprimento: String read FComprimento write SetComprimento;

    function GetJson: String;
  end;

implementation

{ TWooDadosProduto }

constructor TWooDadosProduto.Create;
begin
  inherited Create;
  FExcluir := False;
end;

function TWooDadosProduto.GetAtributoCor: String;
var
  obJson: TJSONObject;
  Cores: String;
begin
  obJson := TJSONObject.Create;
  Try
    obJson.AddPair('id', TJSONNumber.Create(2));
    obJson.AddPair('name', TJSONString.Create('Cores'));

    if not isVariacao then
    begin
      obJson.AddPair('position', TJSONNumber.Create(0));
      obJson.AddPair('visible', TJSONTrue.Create());
      obJson.AddPair('variation', TJSONTrue.Create());

      Cores := '["' + Strtran(FCor, '|', '", "') + '"]';
      obJson.AddPair('options', TJSONNumber.Create(Cores));
    end
    else
    begin
      obJson.AddPair('option', TJSONString.Create(FCor));
    end;

    Result := obJson.ToString;
  Finally
    obJson.Free;
  End;
end;

function TWooDadosProduto.GetAtributos: String;
begin
  Result := GetAtributoCor;
  if not Result.IsEmpty then
    Result := Result + ', ';

  Result := '[' + Result + GetAtributoTamanho + ']';
end;

function TWooDadosProduto.GetAtributoTamanho: String;
var
  obJson: TJSONObject;
  Tamanhos: String;
begin
  obJson := TJSONObject.Create;
  Try
    obJson.AddPair('id', TJSONNumber.Create(1));
    obJson.AddPair('name', TJSONString.Create('Tamanho'));

    if not isVariacao then
    begin
      obJson.AddPair('position', TJSONNumber.Create(1));
      obJson.AddPair('visible', TJSONTrue.Create());
      obJson.AddPair('variation', TJSONTrue.Create());

      Tamanhos := '["' + Strtran(Tamanho, '|', '", "') + '"]';
      obJson.AddPair('options', TJSONNumber.Create(Tamanhos));
    end
    else
      obJson.AddPair('option', TJSONString.Create(FTamanho));

    Result := obJson.ToString;
  Finally
    obJson.Free;
  End;
end;

function TWooDadosProduto.GetJson: String;
var
  obJson: TJSONObject;
  Dimensoes: String;
  obTamanho:TTamanhoFull;
  ltAux:TStrings;
  Seqs : TList<Integer>;
  Dic: TDictionary<Integer, String>;
  I: Integer;
begin
  Try
    obJson := TJSONObject.Create;
    obJson.AddPair('name', TJSONString.Create(FName));
    obJson.AddPair('slug', TJSONString.Create(FSlug));

    if not isVariacao then
    begin
      obJson.AddPair('type', TJSONString.Create('variable'));
    end
    else
    begin
      obJson.AddPair('manage_stock', TJSONTrue.Create);

      Dimensoes := EmptyStr;
      if not FComprimento.IsEmpty then
        Dimensoes := Dimensoes + '"length":"' + FComprimento + '"';

      if not FLargura.IsEmpty then
      begin
        if not Dimensoes.IsEmpty then
          Dimensoes := Dimensoes + ',';

        Dimensoes := Dimensoes + '"width":"' + FLargura + '"';
      end;

      if not FAltura.IsEmpty then
      begin
        if not Dimensoes.IsEmpty then
          Dimensoes := Dimensoes + ',';

        Dimensoes := Dimensoes + '"height":"' + FAltura + '"';
      end;

      if not Dimensoes.IsEmpty then
      begin
        Dimensoes := '{' + Dimensoes + '}';
        // Deve ser preenchido manualmente conforme solicitado pela Ana da Oldoni
        // obJson.AddPair('dimensions', TJSONNumber.Create(Dimensoes));
      end;
      // obJson.AddPair('default_attributes', TJSONNumber.Create(GetAtributos));
    end;

    //Não deve sincronizar as descrições de produtos, a pedido da Ana da Oldoni e do pessoal do ecommerce através do whatsapp
    //obJson.AddPair('description', TJSONString.Create(FDescription));
    //obJson.AddPair('short_description', TJSONString.Create(FShortDescription));
    obJson.AddPair('sku', TJSONString.Create(FSkuCodigo));
    obJson.AddPair('price', TJSONString.Create(FSalePrice));
    obJson.AddPair('regular_price', TJSONString.Create(FRegularPrice));
    obJson.AddPair('sale_price', TJSONString.Create(FSalePrice));
    obJson.AddPair('stock_quantity', TJSONNumber.Create(FStockQuantity));

    if FAtivo = False then
    begin
      obJson.AddPair('status', TJSONString.Create('private'));
      obJson.AddPair('purchasable', TJSONFalse.Create);
    end
    else
    begin
      obJson.AddPair('purchasable', TJSONTrue.Create);
      //Se estiver alterando não pode mais mandar este atributo. Solicição do Ademar. a idéia é não ativar o
      //produto novamente e caso seja ativado no sistema produto que estava inativo não vai ativar no site
      if(FIdWeb = 0)then //Na inclusão
        obJson.AddPair('status', TJSONString.Create('publish'));
    end;

    // Deve ser preenchido manualmente conforme solicitado pela Ana da Oldoni
    // obJson.AddPair('weight', TJSONString.Create(FWeight));

    if not isVariacao then //Ordena os tamanhos conforme a sequência antes de motar o Par atributos
    begin
      try
        Seqs := TList<Integer>.Create;
        Dic := TDictionary<Integer, String>.Create;
        obTamanho := TTamanhoFull.Create;
        ltAux := Explode(Tamanho,'|');
        for I := 0 to ltAux.Count - 1 do
        begin
          obTamanho.setTam_descri(ltAux.Strings[I]);
          if(obTamanho.ConsultaPorDescricao)then
          begin
            Dic.Add(Ivl(obTamanho.getTam_sequen),ltAux.Strings[I]);
            Seqs.Add(Ivl(obTamanho.getTam_sequen));
          end;
        end;

        Seqs.Sort;

        Tamanho := '';
        for I in Seqs do
        begin
          if not Tamanho.IsEmpty then
            Tamanho := Tamanho + '|';
          Tamanho := Tamanho + Dic.Items[I];
        end;
      finally
        FreeAndNil(obTamanho);
        FreeAndNil(ltAux);
        FreeAndNil(Seqs);
        FreeAndNil(Dic);
      end;
    end;

    obJson.AddPair('attributes', TJSONNumber.Create(GetAtributos));

    if isVariacao then //manda a ordem da variação
    begin
      obTamanho := TTamanhoFull.Create;
      obTamanho.setTam_descri(Tamanho);
      if(obTamanho.ConsultaPorDescricao)then
        obJson.AddPair('menu_order', TJSONNumber.Create(obTamanho.getTam_sequen));
      FreeAndNil(obTamanho);
    end;

    // Exporta para JSON
    Result := obJson.ToString;
  Finally
    obJson.Free;
  End;
end;

procedure TWooDadosProduto.SetAltura(const Value: String);
begin
  FAltura := Value;
end;

procedure TWooDadosProduto.SetAtivo(const Value: Boolean);
begin
  FAtivo := Value;
end;

procedure TWooDadosProduto.SetComprimento(const Value: String);
begin
  FComprimento := Value;
end;

procedure TWooDadosProduto.SetCor(const Value: string);
begin
  FCor := Value;
end;

procedure TWooDadosProduto.SetDescription(const Value: String);
begin
  FDescription := Value;
end;

procedure TWooDadosProduto.SetExcluir(const Value: Boolean);
begin
  FExcluir := Value;
end;

procedure TWooDadosProduto.SetIdWeb(const Value: Integer);
begin
  FIdWeb := Value;
end;

procedure TWooDadosProduto.SetIdWebLog(const Value: Integer);
begin
  FIdWebLog := Value;
end;

procedure TWooDadosProduto.SetisVariacao(const Value: Boolean);
begin
  FisVariacao := Value;
end;

procedure TWooDadosProduto.SetLargura(const Value: String);
begin
  FLargura := Value;
end;

procedure TWooDadosProduto.SetName(const Value: String);
begin
  FName := Value;
end;

procedure TWooDadosProduto.SetRegularPrice(const Value: String);
begin
  FRegularPrice := Value;
end;

procedure TWooDadosProduto.SetSalePrice(const Value: String);
begin
  FSalePrice := Value;
end;

procedure TWooDadosProduto.SetShortDescription(const Value: String);
begin
  FShortDescription := Value;
end;

procedure TWooDadosProduto.SetSkuCodigo(const Value: String);
begin
  FSkuCodigo := Value;
end;

procedure TWooDadosProduto.SetSlug(const Value: String);
begin
  FSlug := Value;
end;

procedure TWooDadosProduto.SetStockQuantity(const Value: Integer);
begin
  FStockQuantity := Value;
end;

procedure TWooDadosProduto.SetTamanho(const Value: string);
begin
  FTamanho := Value;
end;

procedure TWooDadosProduto.SetWeight(const Value: string);
begin
  FWeight := Value;
end;

end.
