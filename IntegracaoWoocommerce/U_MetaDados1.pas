unit U_MetaDados1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, CBancos, CTipoPgto,
  Dialogs, U_PadraoManu, StdCtrls, Buttons, DBCtrls, ExtCtrls, AlignEdit, CMetaDados, CDado;

type
  TF_MetaDados1 = class(TF_PadraoManu)
    Label1: TLabel;
    edtDado: TEdit;
    gbTipo: TGroupBox;
    edtTipoD: TEdit;
    sbTipo: TSpeedButton;
    edtTipo: TEdit;
    edtBancoD: TEdit;
    sbBanco: TSpeedButton;
    edtBanco: TEdit;
    ckTipoPag: TCheckBox;
    ckBanco: TCheckBox;
    procedure btGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btExcluirClick(Sender: TObject);
    procedure VisualizarClick(Sender: TObject; Button: TNavigateBtn);
    procedure edtTipoChange(Sender: TObject);
    procedure edtTipoExit(Sender: TObject);
    procedure sbTipoClick(Sender: TObject);
    procedure edtTipoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtBancoChange(Sender: TObject);
    procedure edtBancoExit(Sender: TObject);
    procedure edtBancoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sbBancoClick(Sender: TObject);
    procedure ckTipoPagClick(Sender: TObject);
  private
    { Private declarations }
    obBancos: TBancos;
    obTipo: TTipopgto;
    obMetaDados: TMetaDados;

    function TestaDadosTela: Boolean;
    procedure Gravar;
  public
    { Public declarations }

    procedure Mostra;
    procedure ValoresDefault;
  end;

var
  F_MetaDados1: TF_MetaDados1;

implementation

{$R *.dfm}

uses U_SisProc, Conexao, U_T2, Consulta;

procedure TF_MetaDados1.btExcluirClick(Sender: TObject);
begin
  inherited;

  if DL_Pergunta('Deseja excluir este registro?', 'Excluir Registro', 4 + MB_DEFBUTTON2) = 6 then
  begin
    T2.cdsMetaDados.Delete;
    obMetaDados.SalvarDados;
    Close;
  end;
end;

procedure TF_MetaDados1.btGravarClick(Sender: TObject);
begin
  inherited;

  if not TestaDadosTela then
    Exit;

  btGravar.Enabled := False;
  btExcluir.Enabled := False;

  Try
    Gravar;
  finally
    btGravar.Enabled := True;
    btExcluir.Enabled := True;
  end;

  ShowMessageTimer();
end;

procedure TF_MetaDados1.ckTipoPagClick(Sender: TObject);
begin
  if (Sender as TCheckBox).Name = 'ckBanco' then
  begin
    if ckBanco.Checked then
      ckTipoPag.Checked := False
  end
  else if ckTipoPag.Checked then
    ckBanco.Checked := False;

  if not ckBanco.Checked then
  begin
    edtBanco.Clear;
    edtBancoD.Clear;
  end;

  if not ckTipoPag.Checked then
  begin
    edtTipo.Clear;
    edtTipoD.Clear;
  end;

  edtTipo.Enabled := ckTipoPag.Checked;
  edtTipoD.Enabled := ckTipoPag.Checked;
  sbTipo.Enabled := ckTipoPag.Checked;

  edtBancoD.Enabled := ckBanco.Checked;
  edtBanco.Enabled := ckBanco.Checked;
  sbBanco.Enabled := ckBanco.Checked;
end;

procedure TF_MetaDados1.edtBancoChange(Sender: TObject);
begin
  inherited;
  (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Clear;
  if Length(Trim((Sender as TEdit).Text)) <> 3 then
    Exit;
  obBancos.setLOC_codigo(Trim((Sender as TEdit).Text));
  if obBancos.Consultar then
    (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Text := obBancos.getLOC_Nome
  else
    (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Clear;
end;

procedure TF_MetaDados1.edtBancoExit(Sender: TObject);
begin
  inherited;
  if Trim((Sender as TEdit).Text) = '' then
    Exit
  else
    (Sender as TEdit).Text := StrZero(Trim((Sender as TEdit).Text), 3);

  obBancos.setLOC_codigo(Trim((Sender as TEdit).Text));
  if not obBancos.Consultar then
  begin
    (Sender as TEdit).SetFocus;
    (Sender as TEdit).SelectAll;
    Raise Exception.Create('Banco não Cadastrado!');
  end
  else
  begin

    if obBancos.getLoc_ativo = 'N' then
    begin
      (Sender as TEdit).SetFocus;
      (Sender as TEdit).SelectAll;
      Raise Exception.Create('O banco está marcado como inativo!');
    end;

    (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Text := obBancos.getLOC_Nome;
  end;
end;

procedure TF_MetaDados1.edtBancoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_F4 then
    sbBancoClick(sbBanco);
end;

procedure TF_MetaDados1.edtTipoChange(Sender: TObject);
begin
  inherited;
  (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Clear;
  if Length(Trim((Sender as TEdit).Text)) <> 3 then
    Exit;
  obTipo.setTpg_codigo(Trim((Sender as TEdit).Text));
  if obTipo.Consultar then
    (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Text := obTipo.getTpg_descri
  else
    (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Clear;
end;

procedure TF_MetaDados1.edtTipoExit(Sender: TObject);
begin
  inherited;
  if Trim((Sender as TEdit).Text) = '' then
    Exit
  else
    (Sender as TEdit).Text := StrZero(Trim((Sender as TEdit).Text), 3);

  obTipo.setTpg_codigo(Trim((Sender as TEdit).Text));
  if not obTipo.Consultar then
  begin
    (Sender as TEdit).SetFocus;
    (Sender as TEdit).SelectAll;
    Raise Exception.Create('Tipo de pagamento não Cadastrado!');
  end
  else
    (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Text := obTipo.getTpg_descri;
end;

procedure TF_MetaDados1.edtTipoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_F4 then
    sbTipoClick(sbTipo);
end;

procedure TF_MetaDados1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  obTipo.Free;
  obBancos.Free;
  obMetaDados.Free;

  obMetaDados.CarregarDados;
end;

procedure TF_MetaDados1.FormCreate(Sender: TObject);
begin
  inherited;
  obBancos := TBancos.Create;
  obTipo := TTipopgto.Create;
  obMetaDados := TMetaDados.Create;
end;

procedure TF_MetaDados1.Gravar;
var
  obDado: TDado;
begin
  inherited;
  obDado := TDado.Create;
  try
    obDado.Dado := edtDado.Text;

    if ckBanco.Checked then
    begin
      obDado.Tipo := TTipoDado.tdBanco;
      obDado.Codigo := edtBanco.Text;
      obDado.Descricao := edtBancoD.Text;
    end;

    if ckTipoPag.Checked then
    begin
      obDado.Tipo := TTipoDado.tdTipoPagamento;
      obDado.Codigo := edtTipo.Text;
      obDado.Descricao := edtTipoD.Text;
    end;

    obMetaDados.AddDado(obDado);
    obMetaDados.SalvarDados;
  finally
    obDado.Free;
  end;
end;

procedure TF_MetaDados1.Mostra;
begin
  edtDado.Text := T2.cdsMetaDados.FieldByName('Dado').AsString;

  ckTipoPag.Checked := False;
  ckBanco.Checked := False;
  if T2.cdsMetaDados.FieldByName('Tipo').AsString = obMetaDados.GetTipoDescri(TTipoDado.tdTipoPagamento) then
  begin
    ckTipoPag.Checked := True;

    edtTipo.Text := T2.cdsMetaDados.FieldByName('Codigo').AsString;
    edtTipoChange(edtTipo);
  end
  else if T2.cdsMetaDados.FieldByName('Tipo').AsString = obMetaDados.GetTipoDescri(TTipoDado.tdBanco) then
  begin
    ckBanco.Checked := True;

    edtBanco.Text := T2.cdsMetaDados.FieldByName('Codigo').AsString;
    edtBancoChange(edtBanco);
  end;

  ckTipoPagClick(ckTipoPag);
end;

procedure TF_MetaDados1.sbBancoClick(Sender: TObject);
var
  Q: String;
begin
  Q := 'Select LOC_CODIGO Codigo, LOC_NOME Nome';
  Q := Q + sLineBreak + 'From ScraLoc';
  Q := Q + sLineBreak + 'Where Loc_ativo = ''S''';

  If ConsultaDl(T2.WsepeDBX, Q, 'Nome', 'Localiza Bancos') Then
  begin
    edtBanco.Text := Consulta.getValor('Codigo');
    edtBancoD.Text := Consulta.getValor('Nome');
  end;
end;

procedure TF_MetaDados1.sbTipoClick(Sender: TObject);
var
  Q: String;
begin
  Q := 'Select TPG_CODIGO Codigo, TPG_DESCRI Descricao';
  Q := Q + sLineBreak + 'From ScraTpg';
  Q := Q + sLineBreak + 'Where Tpg_ativo = ''S''';

  If ConsultaDl(T2.WsepeDBX, Q, 'Descricao', 'Localiza Tipos de Pagamento') Then
  begin
    edtTipo.Text := Consulta.getValor('Codigo');
    edtTipoD.Text := Consulta.getValor('Descricao');
  end;
end;

function TF_MetaDados1.TestaDadosTela: Boolean;
begin
  Result := False;

  if Trim(edtDado.Text).IsEmpty then
  begin
    FocarObj(edtDado);
    DL_Msg('Informe a descrição!', Application.Title, 'ERRO');
    Exit;
  end;

  Result := True;
end;

procedure TF_MetaDados1.ValoresDefault;
begin

end;

procedure TF_MetaDados1.VisualizarClick(Sender: TObject; Button: TNavigateBtn);
begin
  inherited;
  Mostra;
end;

end.
