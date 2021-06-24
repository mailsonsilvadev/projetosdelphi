unit U_WooProduto;

interface

uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, U_WooProdutoItem, CParametrosBDIni,
  Menus, ExtCtrls, ComCtrls, U_Sisproc, stdctrls, Variants, System.Actions, U_WooDadosProduto, U_WooIntegracao;

type
  TWooProduto = class(TObject)
  private
    FProduto: TWooDadosProduto;
    FVariacoes: TArray<TWooProdutoItem>;
    procedure SetProduto(const Value: TWooDadosProduto);
    function GetProduto: TWooDadosProduto;
    procedure SetItems(const Value: TArray<TWooProdutoItem>);

  public
    constructor Create;
    procedure Free;

    function AddVariacao(AIndex: Integer): TWooProdutoItem;

    property Produto: TWooDadosProduto read GetProduto write SetProduto;
    property Variacoes: TArray<TWooProdutoItem> read FVariacoes write SetItems;
  end;

implementation

{ TWooProduto }

function TWooProduto.AddVariacao(AIndex: Integer): TWooProdutoItem;
begin
  SetLength(FVariacoes, AIndex + 1);
  Variacoes[AIndex] := TWooProdutoItem.Create;
  Variacoes[AIndex].Produto.isVariacao := True;
  Result := Variacoes[AIndex];
end;

constructor TWooProduto.Create;
begin
  inherited Create;
  FProduto := TWooDadosProduto.Create;
end;

procedure TWooProduto.Free;
begin
  Produto.Free;
  inherited Free;
end;

function TWooProduto.GetProduto: TWooDadosProduto;
begin
  if not Assigned(FProduto) then
    FProduto := TWooDadosProduto.Create;

  Result := FProduto;
end;

procedure TWooProduto.SetItems(const Value: TArray<TWooProdutoItem>);
begin
  FVariacoes := Value;
end;

procedure TWooProduto.SetProduto(const Value: TWooDadosProduto);
begin
  FProduto := Value;
end;

end.
