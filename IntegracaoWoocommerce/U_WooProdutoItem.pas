unit U_WooProdutoItem;

interface

uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ExtCtrls, ComCtrls, U_Sisproc, stdctrls, Variants, System.Actions, U_WooDadosProduto;

type
  TWooProdutoItem = class(TObject)
  private
    FProduto: TWooDadosProduto;
    procedure SetProduto(const Value: TWooDadosProduto);
    function GetProduto: TWooDadosProduto;

  public
    constructor Create;
    procedure Free;

    property Produto: TWooDadosProduto read GetProduto write SetProduto;
  end;

implementation

{ TWooProdutoItem }

constructor TWooProdutoItem.Create;
begin
  inherited Create;
  FProduto := TWooDadosProduto.Create;
end;

procedure TWooProdutoItem.Free;
begin
  Produto.Free;
  inherited Free;
end;

function TWooProdutoItem.GetProduto: TWooDadosProduto;
begin
  if not Assigned(FProduto) then
    FProduto := TWooDadosProduto.Create;

  Result := FProduto;
end;

procedure TWooProdutoItem.SetProduto(const Value: TWooDadosProduto);
begin
  FProduto := Value;
end;

end.
