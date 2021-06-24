unit U_RelPedidosWeb;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, Buttons, ExtCtrls, DBCtrls, DB, DBClient, frxClass,
  frxDBSet, CheckLst, Consulta, Variants;

type
  TF_RelPedidosWeb = class(TForm)
    Panel1: TPanel;
    fechar: TSpeedButton;
    Aguarde: TLabel;
    Ver: TBitBtn;
    Imprimir: TBitBtn;
    frxReport1: TfrxReport;
    frxDBDataset1: TfrxDBDataset;
    cdsRel: TClientDataSet;
    dsRel: TDataSource;
    DataDe: TMaskEdit;
    DataAte: TMaskEdit;
    Label5: TLabel;
    Label2: TLabel;
    rgTpoRel: TRadioGroup;
    rgPedidos: TRadioGroup;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure fecharClick(Sender: TObject);
    procedure VerClick(Sender: TObject);
    procedure ImprimirClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    function frxReport1UserFunction(const MethodName: String; var Params: Variant): Variant;

    procedure DataDeExit2(Sender: TObject);
    procedure DataDeKeyDown2(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    procedure TestaGravaDados;
    procedure Processo(Tipo: String);
    procedure SelecionaDados;
    procedure MontaRelatorio;
  public
    { Public declarations }
  end;

var
  F_RelPedidosWeb: TF_RelPedidosWeb;

implementation

uses U_Sisproc, U_T2;

{$R *.DFM}

procedure TF_RelPedidosWeb.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := Cafree;
  F_RelPedidosWeb := nil;
end;

procedure TF_RelPedidosWeb.FormKeyPress(Sender: TObject; var Key: Char);
begin
  NextControl(self, Key);
end;

procedure TF_RelPedidosWeb.fecharClick(Sender: TObject);
begin
  Close;
end;

procedure TF_RelPedidosWeb.VerClick(Sender: TObject);
begin
  TestaGravaDados;

  Try
    Aguarde.Visible := True;
    Ver.Enabled := False;
    Imprimir.Enabled := False;
    Application.ProcessMessages;

    Processo('V');
  Finally
    Aguarde.Visible := False;
    Ver.Enabled := True;
    Imprimir.Enabled := True;
  End;
end;

procedure TF_RelPedidosWeb.ImprimirClick(Sender: TObject);
begin
  TestaGravaDados;

  Try
    Aguarde.Visible := True;
    Ver.Enabled := False;
    Imprimir.Enabled := False;
    Application.ProcessMessages;

    Processo('I');
  Finally
    Aguarde.Visible := False;
    Ver.Enabled := True;
    Imprimir.Enabled := True;
  End;
end;

procedure TF_RelPedidosWeb.TestaGravaDados;
begin
  if Trim(DataDe.Text) = '/  /' then
  begin
    DataDe.SetFocus;
    Raise Exception.Create('Preencha a data!');
  end;

  if Trim(DataAte.Text) = '/  /' then
  begin
    DataAte.SetFocus;
    Raise Exception.Create('Preencha a data!');
  end;

  GravaSepeRel('RelPedidosWeb', 'DataDe', DataDe.Text, T2.qSepeRel);
  GravaSepeRel('RelPedidosWeb', 'DataAte', DataAte.Text, T2.qSepeRel);
  GravaSepeRel('RelPedidosWeb', 'rgPedidos', Nst(rgPedidos.ItemIndex), T2.qSepeRel);
  GravaSepeRel('RelPedidosWeb', 'rgTpoRel', Nst(rgTpoRel.ItemIndex), T2.qSepeRel);
end;

procedure TF_RelPedidosWeb.Processo(Tipo: String);
var
  Arquivo: String;
begin
  Arquivo := BuscaCFG2(T2.qSepeCfg, 'SepeCFG', 'CFG_IMGREL', 'Pasta com as Imagens dos Relatorios', '', 1, 255) + 'Report\ese\RelPedidosWeb.fr3';
  if not FileExists(Arquivo) then
    Raise Exception.Create('Layout de relatório não encontrado - RelPedidosWeb.fr3!');

  SelecionaDados;

  if T2.cdsC1.IsEmpty then
    Raise Exception.Create('Nada para Imprimir!');

  AlimentaRelCds('Emissao;ID', T2.cdsC1, cdsRel);

  frxReport1.LoadFromFile(Arquivo);
  MontaRelatorio;

  if Tipo = 'V' then
    frxReport1.ShowReport
  else
  begin
    frxReport1.PrepareReport;
    frxReport1.Print;
  end;
end;

procedure TF_RelPedidosWeb.FormActivate(Sender: TObject);
begin
  DataDe.Text := LeSepeRel('RelPedidosWeb', 'DataDe', T2.qSepeRel);
  DataAte.Text := LeSepeRel('RelPedidosWeb', 'DataAte', T2.qSepeRel);
  rgPedidos.ItemIndex := StrToIntDef(LeSepeRel('RelPedidosWeb', 'rgPedidos', T2.qSepeRel), 0);
  rgTpoRel.ItemIndex := StrToIntDef(LeSepeRel('RelPedidosWeb', 'rgTpoRel', T2.qSepeRel), 0);
end;

procedure TF_RelPedidosWeb.SelecionaDados;
var
  Q, SubGrupos: String;
begin
  Q := 'Select WTPedido.ID, WTPedido.CodigoInt, WTPedido.Emissao, WTPedido.CodTCliente, Cli_Codigo, Cli_Nome, WTPedido.TotalPedido,';
  Q := Q + sLineBreak + 'WTPEDIDOITEM.Quantidade, WTPEDIDOITEM.VlrUnitario, WTPEDIDOITEM.TotalProduto, Pro_Codigo, Pro_Descri, Fun_Nome';
  Q := Q + sLineBreak + 'From WTPedido';
  Q := Q + sLineBreak + 'Left Join WTPedidoItem on WTPedidoItem.idTPedido = WTPedido.ID';
  Q := Q + sLineBreak + 'Left Join ScraCli on Cli_Codigo = WTPedido.CodTCliente';
  Q := Q + sLineBreak + 'Left Join EstaPro on Pro_Codigo = WTPedidoItem.CodTProduto';
  Q := Q + sLineBreak + 'Left Join VenaFun on Fun_Codigo = WTPedido.CodTVendedor';

  Q := Q + #10#13 + 'Where WTPedido.Emissao Between :DataDe and :DataAte';

  case rgPedidos.ItemIndex of
    1:
      Q := Q + sLineBreak + 'and WTPedido.CodigoInt <> ''''';
    2:
      Q := Q + sLineBreak + 'and ((WTPedido.CodigoInt = '''') or (WTPedido.CodigoInt is Null))';
  end;

  T2.cdsC1.Active := False;
  T2.qC1.Close;
  T2.qC1.SQL.Clear;
  T2.qC1.SQL.Add(Q);
  T2.qC1.ParamByName('DataDe').AsDate := StrToDate(DataDe.Text);
  T2.qC1.ParamByName('DataAte').AsDate := StrToDate(DataAte.Text);
  T2.cdsC1.Active := True;
end;

function TF_RelPedidosWeb.frxReport1UserFunction(const MethodName: String; var Params: Variant): Variant;
begin
  if MethodName = 'NST' then
    Result := Nst(Params[0]);
end;

procedure TF_RelPedidosWeb.MontaRelatorio;
var
  Param: String;
begin
  TfrxMemoView(frxReport1.FindObject('Empresa')).Memo.Add(BuscaEmpresa(T2.qEmpresa, 'RAZAOSOC'));
  TfrxMemoView(frxReport1.FindObject('Titulo')).Memo.Add('Relação de Pedidos ');

  Param := 'Emissão de: ' + DataDe.Text + ' Até: ' + DataAte.Text + '   ';

  case rgPedidos.ItemIndex of
    1:
      Param := Param + 'Pedidos que geraram venda    ';
    2:
      Param := Param + 'Pedidos que não geraram venda    ';
  end;

  case rgTpoRel.ItemIndex of
    1:
      begin
        TfrxChild(frxReport1.FindObject('Child1')).Visible := False;
        TfrxMasterData(frxReport1.FindObject('MasterData1')).Visible := False;
      end;
  end;

  TfrxMemoView(frxReport1.FindObject('Parametros')).Memo.Add(Param);

  Param := Trim(BuscaCFG2(T2.qgSepeCfg, 'SepeCFG', 'CFG_LOGO', 'Caminho do arquivo com o Logo da empresa para relatorios', '', 1, 200));
  if Trim(Param) <> '' then
    if FileExists(Param) then
      TfrxPictureView(frxReport1.FindObject('logo')).Picture.LoadFromFile(Param);

  frxReport1.AddFunction('function Nst(N : Variant): String;');
end;

procedure TF_RelPedidosWeb.DataDeExit2(Sender: TObject);
begin
  If ((Sender as TMaskEdit).Text) = '  /  /    ' Then
    exit;
  If Not VerData((Sender as TMaskEdit).Text) Then
  Begin
    (Sender as TMaskEdit).SetFocus;
    exit;
  End;
  (Sender as TMaskEdit).Text := FormatDateTime('dd/mm/yyyy', StrToDateTime((Sender as TMaskEdit).Text));

  If ((Sender as TMaskEdit).Name = 'DataDe') then
    If (DataAte.Text = '  /  /    ') or ((StrToDate((Sender as TMaskEdit).Text)) > (StrToDate(DataAte.Text))) then
      DataAte.Text := FormatDateTime('dd/mm/yyyy', StrToDateTime((Sender as TMaskEdit).Text));
end;

procedure TF_RelPedidosWeb.DataDeKeyDown2(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 72 then
    (Sender as TMaskEdit).Text := FormatDateTime('dd/mm/yyyy', Date);
end;

end.
