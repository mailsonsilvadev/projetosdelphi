unit U_Preferencias;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, CAlmoxarifado, CTabelaprecosFull, CFormaPgnto, CTransportadoras,
  StdCtrls, Mask, Buttons, ExtCtrls, DBCtrls, CSepeCfg, AlignEdit, Conexao, CParametros, CCadaTna, CNaturezaOpr, CVendedores;

type
  TF_Preferencias = class(TForm)
    Panel1: TPanel;
    Confirmar: TBitBtn;
    fechar: TSpeedButton;
    rgAlxSaldo: TGroupBox;
    edtCodAlx: TEdit;
    gbPadrao: TGroupBox;
    edtTabPadrao: TEdit;
    lbltabela: TLabel;
    Label85: TLabel;
    edtCodTna: TEdit;
    edtCodTnaD: TEdit;
    Label14: TLabel;
    edtNatOprPadrao: TEdit;
    edtCodOprPadrao: TEdit;
    edtNatOprPadraoD: TEdit;
    Label1: TLabel;
    edtAlxPadrao: TEdit;
    edtAlxPadraoD: TEdit;
    edtTabPadraoD: TEdit;
    Label2: TLabel;
    edtNatOprInter: TEdit;
    edtCodOprInter: TEdit;
    edtNatDescriInter: TEdit;
    Label3: TLabel;
    edtCodPag: TEdit;
    edtCodPagD: TEdit;
    Label15: TLabel;
    CODREP: TEdit;
    CODREPE: TEdit;
    CODVENE: TEdit;
    CODVEN: TEdit;
    Label5: TLabel;
    Label17: TLabel;
    CODGER: TEdit;
    CODGERE: TEdit;
    CODTRSD: TEdit;
    CODTRS: TEdit;
    Label4: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure fecharClick(Sender: TObject);
    procedure ConfirmarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCodAlxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCodTnaChange(Sender: TObject);
    procedure edtCodTnaExit(Sender: TObject);
    procedure edtCodTnaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtTabPadraoExit(Sender: TObject);
    procedure edtTabPadraoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtNatOprPadraoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCodOprPadraoChange(Sender: TObject);
    procedure edtAlxPadraoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtTabPadraoChange(Sender: TObject);
    procedure edtNatOprInterKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCodOprInterChange(Sender: TObject);
    procedure edtCodPagChange(Sender: TObject);
    procedure edtCodPagExit(Sender: TObject);
    procedure edtCodPagKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CODREPChange(Sender: TObject);
    procedure CODREPExit(Sender: TObject);
    procedure CODREPKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CODTRSChange(Sender: TObject);
    procedure CODTRSExit(Sender: TObject);
    procedure CODTRSKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }

    obConfig: TSepecfg;
    obAlx: TAlmoxarifado;
    obCadaTna: TCadatna;
    obTabela: TTabelaPrecosFull;
    obNatureza: TNaturezaopr;
    obFormaPgnto: TFormapgnto;
    obVendedor: TVendedores;
    obTransportadora: TTransportadoras;
  public
    { Public declarations }
  end;

var
  F_Preferencias: TF_Preferencias;

implementation

uses U_Sisproc, U_T2, Consulta;

{$R *.DFM}

procedure TF_Preferencias.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  obConfig.Free;
  obAlx.Free;
  obCadaTna.Free;
  obTabela.Free;
  obNatureza.Free;
  obFormaPgnto.Free;
  obVendedor.Free;
  obTransportadora.Free;

  Action := Cafree;
  F_Preferencias := nil;
end;

procedure TF_Preferencias.FormCreate(Sender: TObject);
begin
  obConfig := TSepecfg.Create;
  obAlx := TAlmoxarifado.Create;
  obCadaTna := TCadatna.Create;
  obTabela := TTabelaPrecosFull.Create;
  obNatureza := TNaturezaopr.Create;
  obFormaPgnto := TFormapgnto.Create;
  obVendedor := TVendedores.Create;
  obTransportadora := TTransportadoras.Create;

  edtCodAlx.Text := TParametros.getDmdAlx;

  edtTabPadrao.Text := LeSepeRel('Ecommerce', 'edtTabPadrao', T2.qSepeCfg);
  edtCodTna.Text := LeSepeRel('Ecommerce', 'edtCodTna', T2.qSepeCfg);
  edtNatOprPadrao.Text := LeSepeRel('Ecommerce', 'edtNatOprPadrao', T2.qSepeCfg);
  edtCodOprPadrao.Text := LeSepeRel('Ecommerce', 'edtCodOprPadrao', T2.qSepeCfg);
  edtNatOprInter.Text := LeSepeRel('Ecommerce', 'edtNatOprInter', T2.qSepeCfg);
  edtCodOprInter.Text := LeSepeRel('Ecommerce', 'edtCodOprInter', T2.qSepeCfg);
  edtAlxPadrao.Text := LeSepeRel('Ecommerce', 'edtAlxPadrao', T2.qSepeCfg);
  edtCodPag.Text := LeSepeRel('Ecommerce', 'edtCodPag', T2.qSepeCfg);

  CODREP.Text := LeSepeRel('Ecommerce', 'CODREP', T2.qSepeCfg);
  CODVEN.Text := LeSepeRel('Ecommerce', 'CODVEN', T2.qSepeCfg);
  CODGER.Text := LeSepeRel('Ecommerce', 'CODGER', T2.qSepeCfg);
  CODTRS.Text := LeSepeRel('Ecommerce', 'CODTRS', T2.qSepeCfg);
end;

procedure TF_Preferencias.FormKeyPress(Sender: TObject; var Key: Char);
begin
  NextControl(self, Key);
end;

procedure TF_Preferencias.edtNatOprInterKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Q: String;
begin
  if Key = VK_F4 then
  begin
    Q := 'Select Nt_Cfo Cfo,Nt_Opc Opc,Nt_Descfo Descricao, Nt_AtuEst Est, Nt_GerDup Dup, Nt_Cst Cst ';
    Q := Q + #13 + 'From SlFanto';
    Q := Q + #13 + 'Where NT_Ativo  = ''S'' ';
    Q := Q + #13 + 'and   Nt_Cfo    > ''6000''';
    Q := Q + #13 + 'and   Nt_CodTna = ' + #39 + edtCodTna.Text + #39;

    if ConsultaDl(T2.WsepeDBX, Q, 'Cfo;Opc', 'Consulta de Naturezas') then
    begin
      edtNatOprInter.Text := Consulta.getValor('Cfo');
      edtCodOprInter.Text := Consulta.getValor('Opc');
      edtNatDescriInter.Text := Consulta.getValor('Descricao');
    end;
  end;
end;

procedure TF_Preferencias.edtNatOprPadraoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Q: String;
begin
  if Key = VK_F4 then
  begin
    Q := 'Select Nt_Cfo Cfo,Nt_Opc Opc,Nt_Descfo Descricao, Nt_AtuEst Est, Nt_GerDup Dup, Nt_Cst Cst ';
    Q := Q + #13 + 'From SlFanto';
    Q := Q + #13 + 'Where NT_Ativo  = ''S'' ';
    Q := Q + #13 + 'and   Nt_Cfo    > ''500''';
    Q := Q + #13 + 'and   Nt_CodTna = ' + #39 + edtCodTna.Text + #39;

    if ConsultaDl(T2.WsepeDBX, Q, 'Cfo;Opc', 'Consulta de Naturezas') then
    begin
      edtNatOprPadrao.Text := Consulta.getValor('Cfo');
      edtCodOprPadrao.Text := Consulta.getValor('Opc');
      edtNatOprPadraoD.Text := Consulta.getValor('Descricao');
    end;
  end;
end;

procedure TF_Preferencias.edtCodAlxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Q: String;
begin
  if (Caption = 'Ver') or (Caption = 'Excluir') then
    Exit;

  if Key = VK_F4 then
  begin
    Q := 'Select EST_CODIGO Codigo, EST_ENDER Descricao';
    Q := Q + #10#13 + 'From EstaEst';
    If ConsultaDl(T2.WsepeDBX, Q, 'Descricao', 'Localiza Almoxarifados') Then
    begin
      (Sender as TEdit).Text := Trim((Sender as TEdit).Text + ' ' + Consulta.getValor('Codigo'));
    end;
  end;
end;

procedure TF_Preferencias.edtCodTnaChange(Sender: TObject);
begin
  (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Clear;
  if Length(Trim((Sender as TEdit).Text)) < 3 then
    Exit;

  obCadaTna.setTna_codigo(Trim((Sender as TEdit).Text));
  if obCadaTna.Consultar then
    (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Text := obCadaTna.getTna_descri
  else
    (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Clear;
end;

procedure TF_Preferencias.edtCodTnaExit(Sender: TObject);
begin
  if (Sender as TEdit).Text = '' then
    Exit;

  (Sender as TEdit).Text := Strzero((Sender as TEdit).Text, 3);

  // Tipo de Operacao
  obCadaTna.setTna_codigo((Sender as TEdit).Text);
  if not obCadaTna.Consultar then
  begin
    (Sender as TEdit).SetFocus;
    (Sender as TEdit).SelectAll;
    Raise Exception.Create('Tipo de operação não cadastrada');
  end
  else
    (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Text := obCadaTna.getTna_descri;
end;

procedure TF_Preferencias.edtCodTnaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Q: String;
begin
  if Key = VK_F4 then
  begin
    Q := 'Select TNA_CODIGO Codigo, TNA_DESCRI Descricao';
    Q := Q + #13 + 'From CadaTna';
    Q := Q + #13 + 'Where TNA_OPRES = ''S''';

    if ConsultaDl(T2.WsepeDBX, Q, 'Descricao', 'Consulta de Operações') then
    begin
      (Sender as TEdit).Text := Consulta.getValor('Codigo');
      (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Text := Consulta.getValor('Descricao');
    end;
  end;
end;

procedure TF_Preferencias.edtTabPadraoChange(Sender: TObject);
begin
  (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Clear;
  if Length(Trim((Sender as TEdit).Text)) < 3 then
    Exit;

  obTabela.setTbc_codigo(Trim((Sender as TEdit).Text));
  if obTabela.Consultar then
    (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Text := obTabela.getTbc_descri
  else
    (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Clear;
end;

procedure TF_Preferencias.edtTabPadraoExit(Sender: TObject);
begin
  if Trim((Sender as TEdit).Text) = '' then
    Exit;

  obTabela.setTbc_codigo(Trim((Sender as TEdit).Text));
  if not obTabela.Consultar then
  begin
    (Sender as TEdit).SetFocus;
    (Sender as TEdit).SelectAll;
    Raise Exception.Create('Tabela não Cadastrado!');
  end;
end;

procedure TF_Preferencias.edtTabPadraoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Q: String;
begin
  if (Caption = 'Ver') or (Caption = 'Excluir') then
    Exit;

  if Key = VK_F4 then
  begin
    Q := 'Select TBC_CODIGO Codigo, TBC_DESCRI Descricao';
    Q := Q + #10#13 + 'From VENATBC';
    Q := Q + #10#13 + 'where TBC_TPTAB <> 3';

    If ConsultaDl(T2.WsepeDBX, Q, 'Descricao', 'Localiza Tabela') Then
    begin
      (Sender as TEdit).Text := Consulta.getValor('Codigo');
      (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Text := Consulta.getValor('Descricao');
    end;
  end;
end;

procedure TF_Preferencias.edtCodOprInterChange(Sender: TObject);
begin
  obNatureza.setNt_cfo(edtNatOprInter.Text);
  obNatureza.setNt_opc(edtCodOprInter.Text);
  if obNatureza.Consultar then
  begin
    edtNatDescriInter.Text := obNatureza.getNt_descfo;
  end;
end;

procedure TF_Preferencias.edtCodOprPadraoChange(Sender: TObject);
begin
  obNatureza.setNt_cfo(edtNatOprPadrao.Text);
  obNatureza.setNt_opc(edtCodOprPadrao.Text);
  if obNatureza.Consultar then
  begin
    edtNatOprPadraoD.Text := obNatureza.getNt_descfo;
  end;
end;

procedure TF_Preferencias.edtCodPagChange(Sender: TObject);
begin
  (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Clear;
  if Length(Trim((Sender as TEdit).Text)) < 3 then
    Exit;

  obFormaPgnto.setPgnf_cod(Trim((Sender as TEdit).Text));
  if obFormaPgnto.Consultar then
    (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Text := obFormaPgnto.getPgnf_cond
  else
    (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Clear;
end;

procedure TF_Preferencias.edtCodPagExit(Sender: TObject);
begin
  if Trim((Sender as TEdit).Text) = '' then
    Exit;

  obFormaPgnto.setPgnf_cod(Trim((Sender as TEdit).Text));
  if not obFormaPgnto.Consultar then
  begin
    (Sender as TEdit).SetFocus;
    (Sender as TEdit).SelectAll;
    Raise Exception.Create('Forma de Pagamento não Cadastrado!');
  end
  else
    (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Text := obFormaPgnto.getPgnf_cond;
end;

procedure TF_Preferencias.edtCodPagKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Q: String;
begin
  if (Caption = 'Ver') or (Caption = 'Excluir') then
    Exit;

  if Key = VK_F4 then
  begin
    Q := 'Select PGNF_COD Codigo, PGNF_COND Condicao';
    Q := Q + #10#13 + 'From SCRAPGNF';
    If ConsultaDl(T2.WsepeDBX, Q, 'Condicao', 'Localiza Forma de Pagamento') Then
    begin
      (Sender as TEdit).Text := Consulta.getValor('Codigo');
      (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Text := Consulta.getValor('Condicao');
    end;
  end;
end;

procedure TF_Preferencias.CODREPChange(Sender: TObject);
begin
  (FindComponent((Sender as TEdit).Name + 'E') as TEdit).Clear;
  if Length(Trim((Sender as TEdit).Text)) < 5 then
    Exit;

  obVendedor.setFun_codigo(Trim((Sender as TEdit).Text));
  if obVendedor.Consultar then
    (FindComponent((Sender as TEdit).Name + 'E') as TEdit).Text := obVendedor.getFun_nome
  else
    (FindComponent((Sender as TEdit).Name + 'E') as TEdit).Clear;
end;

procedure TF_Preferencias.CODREPExit(Sender: TObject);
begin
  (FindComponent((Sender as TEdit).Name + 'E') as TEdit).Clear;

  if Trim((Sender as TEdit).Text).IsEmpty then
    Exit;

  (Sender as TEdit).Text := Strzero((Sender as TEdit).Text, 5);

  obVendedor.setFun_codigo(Trim((Sender as TEdit).Text));
  if obVendedor.Consultar then
  begin
    (FindComponent((Sender as TEdit).Name + 'E') as TEdit).Text := obVendedor.getFun_nome;
  end
  else
  begin
    (Sender as TEdit).SetFocus;
    Raise Exception.Create('Funcionário não encontrado!');
  end;
end;

procedure TF_Preferencias.CODREPKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Q: String;
begin
  if Key = VK_F4 then
  begin
    Q := 'Select FUN_CODIGO Codigo, FUN_NOME Nome';
    Q := Q + #10#13 + 'From VenaFun';
    Q := Q + #10#13 + 'Where FUN_ATIVO = ''S''';

    if ConsultaDl(T2.WsepeDBX, Q, 'Nome', 'Vendedores') then
    begin
      (Sender as TEdit).Text := Consulta.getValor('Codigo');
      (FindComponent((Sender as TEdit).Name + 'E') as TEdit).Text := Consulta.getValor('Nome');
    end;
  end;
end;

procedure TF_Preferencias.CODTRSChange(Sender: TObject);
begin
  (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Clear;
  if Length(Trim((Sender as TEdit).Text)) < 5 then
    Exit;

  obTransportadora.setTrs_codigo(Trim((Sender as TEdit).Text));
  if obTransportadora.Consultar then
    (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Text := obTransportadora.getTrs_nome
  else
    (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Clear;
end;

procedure TF_Preferencias.CODTRSExit(Sender: TObject);
begin
  if Trim((Sender as TEdit).Text) = '' then
    Exit;

  obTransportadora.setTrs_codigo(Trim((Sender as TEdit).Text));
  if not obTransportadora.Consultar then
  begin
    (Sender as TEdit).SetFocus;
    (Sender as TEdit).SelectAll;
    Raise Exception.Create('Transportadora não Cadastrado!');
  end
  else
    (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Text := obTransportadora.getTrs_nome;
end;

procedure TF_Preferencias.CODTRSKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Q: String;
begin
  if (Caption = 'Ver') or (Caption = 'Excluir') then
    Exit;

  if Key = VK_F4 then
  begin
    Q := 'Select TRS_CODIGO Codigo, TRS_NOME Nome';
    Q := Q + #10#13 + 'From SCRATRS';
    If ConsultaDl(T2.WsepeDBX, Q, 'Nome', 'Localiza Transportadoras') Then
    begin
      (Sender as TEdit).Text := Consulta.getValor('Codigo');
      (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Text := Consulta.getValor('Nome');
    end;
  end;
end;

procedure TF_Preferencias.ConfirmarClick(Sender: TObject);
begin
  TParametros.setDmdAlx(edtCodAlx.Text);

  GravaSepeRel('Ecommerce', 'edtTabPadrao', edtTabPadrao.Text, T2.qSepeCfg);
  GravaSepeRel('Ecommerce', 'edtCodTna', edtCodTna.Text, T2.qSepeCfg);
  GravaSepeRel('Ecommerce', 'edtNatOprPadrao', edtNatOprPadrao.Text, T2.qSepeCfg);
  GravaSepeRel('Ecommerce', 'edtCodOprPadrao', edtCodOprPadrao.Text, T2.qSepeCfg);
  GravaSepeRel('Ecommerce', 'edtNatOprInter', edtNatOprInter.Text, T2.qSepeCfg);
  GravaSepeRel('Ecommerce', 'edtCodOprInter', edtCodOprInter.Text, T2.qSepeCfg);
  GravaSepeRel('Ecommerce', 'edtAlxPadrao', edtAlxPadrao.Text, T2.qSepeCfg);
  GravaSepeRel('Ecommerce', 'edtCodPag', edtCodPag.Text, T2.qSepeCfg);
  GravaSepeRel('Ecommerce', 'CODREP', CODREP.Text, T2.qSepeCfg);
  GravaSepeRel('Ecommerce', 'CODVEN', CODVEN.Text, T2.qSepeCfg);
  GravaSepeRel('Ecommerce', 'CODGER', CODGER.Text, T2.qSepeCfg);
  GravaSepeRel('Ecommerce', 'CODTRS', CODTRS.Text, T2.qSepeCfg);

  Close;
end;

procedure TF_Preferencias.edtAlxPadraoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Q: String;
begin
  if Key = VK_F4 then
  begin
    Q := 'Select EST_CODIGO Codigo, EST_ENDER Descricao';
    Q := Q + #10#13 + 'From ESTAEST';

    if ConsultaDl(T2.WsepeDBX, Q, 'Descricao', 'Localiza Almoxarifado') Then
    begin
      (Sender as TEdit).Text := Consulta.getValor('Codigo');
      (FindComponent((Sender as TEdit).Name + 'D') as TEdit).Text := Consulta.getValor('Descricao');
    end;
  end;
end;

procedure TF_Preferencias.fecharClick(Sender: TObject);
begin
  Close;
end;

end.
