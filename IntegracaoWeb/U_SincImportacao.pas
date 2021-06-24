unit U_SincImportacao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, Buttons, ExtCtrls, DBCtrls, Vcl.Grids, U_ListaObjetos,
  Vcl.DBGrids, Data.DB, Datasnap.DBClient, U_WebIntegracaoCliente, StrUtils,
  U_WebIntegracaoPedido, Transacao, U_SincWeb;

type
  TF_SincImportacao = class(TForm)
    Panel1: TPanel;
    Confirmar: TBitBtn;
    fechar: TSpeedButton;
    dsImportacao: TDataSource;
    cdsImportacao: TClientDataSet;
    DBGrid1: TDBGrid;
    pnTotais: TPanel;
    lblTotErros: TLabel;
    lblTotAlterados: TLabel;
    lblTotNovos: TLabel;
    lblTotExcluidos: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure fecharClick(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure ConfirmarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FDicImportacao: TListaObjetos;
    FCfgWebUsu: String;
    FCfgWebSen: String;
    procedure SetDicImportacao(const Value: TListaObjetos);
    procedure CriarCds;
    procedure AddCds(AArquivo, ASit, ADescri, ARegDic: String; ASob, ADes, AIgn: Integer);
    procedure MarcouCampo(ACampo: String; AValorAtual: Integer);
    procedure HabilitarForm(AHabilitar: Boolean);
    procedure ExecutarProcesso;
    procedure ValidarSelecao;
    procedure FazImportacao;
    procedure SetCfgWebSen(const Value: String);
    procedure SetCfgWebUsu(const Value: String);
  public
    { Public declarations }
    property CfgWebUsu: String read FCfgWebUsu write SetCfgWebUsu;
    property CfgWebSen: String read FCfgWebSen write SetCfgWebSen;
    property DicImportacao: TListaObjetos read FDicImportacao write SetDicImportacao;

    procedure MostrarResumoImportação;
  end;

var
  F_SincImportacao: TF_SincImportacao;

implementation

uses U_Sisproc, U_T2, U_IdentifUsr, Conexao;

{$R *.DFM}

procedure TF_SincImportacao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := Cafree;
  F_SincImportacao := nil;
end;

procedure TF_SincImportacao.FormCreate(Sender: TObject);
begin
  CfgWebUsu := BuscaCFG2(T2.qgSepeCfg, 'SEPECFG', 'CFG_WEBUSU', 'Usuário padrão de importação WEB', '', 1, 200);
  CfgWebSen := DescriptaSenha(Copy(BuscaCFG2(T2.qgSepeCfg, 'SEPECFG', 'CFG_WEBSEN', 'Senha do usuário padrão de importação WEB', '', 1, 200), 8));
end;

procedure TF_SincImportacao.FormKeyPress(Sender: TObject; var Key: Char);
begin
  NextControl(self, Key);
end;

procedure TF_SincImportacao.HabilitarForm(AHabilitar: Boolean);
begin
  if AHabilitar then
  begin
    cdsImportacao.EnableControls;
  end
  else
    cdsImportacao.DisableControls;

  Confirmar.Enabled := AHabilitar;
end;

procedure TF_SincImportacao.MarcouCampo(ACampo: String; AValorAtual: Integer);
begin
  // Atualiza o valor do campo
  if AValorAtual = 1 then
    AValorAtual := 0
  else
    AValorAtual := 1;

  cdsImportacao.Edit;
  cdsImportacao['Sob'] := 0;
  cdsImportacao['Des'] := 0;
  cdsImportacao['Ign'] := 0;

  // Não libera o atualização para registros com erro
  if (Nst(cdsImportacao['Sit']) <> 'ERRO') or (ACampo <> 'Sob') then
    cdsImportacao[ACampo] := AValorAtual;

  cdsImportacao.Post;
end;

procedure TF_SincImportacao.MostrarResumoImportação;
var
  MsgImp, Status: String;
  obCliente: TWebIntegracaoCliente;
  obPedido: TWebIntegracaoPedido;
  TotErros, TotAlterados, TotNovos, TotExcluidos, I: Integer;
begin
  CriarCds;

  TotErros := 0;
  TotAlterados := 0;
  TotExcluidos := 0;
  TotNovos := 0;
  for I := 0 to FDicImportacao.Lista.Count - 1 do
  begin
    if FDicImportacao.Lista.Items[I].ClassType = TWebIntegracaoCliente then
    begin
      obCliente := TWebIntegracaoCliente(FDicImportacao.Lista.Items[I]);
      MsgImp := obCliente.tcliente.ValidarImportacao;

      if MsgImp <> '' then
      begin
        Status := 'ERRO';
        Inc(TotErros);
      end
      else
      begin
        // Montangem da mensagem de importação sem erros
        MsgImp := 'Cliente ';
        if obCliente.tcliente.CodigoInt <> '' then
        begin
          MsgImp := MsgImp + obCliente.tcliente.CodigoInt + ' ';

          if obCliente.tcliente.TipoOpr = 'GRAVAR' then
          begin
            Status := 'ALTERADO';
            Inc(TotAlterados);
          end
          else
          begin
            Status := 'EXCLUÍDO';
            Inc(TotExcluidos);
          end;
        end
        else
        begin
          Status := 'NOVO';
          Inc(TotNovos);
        end;

        MsgImp := MsgImp + obCliente.tcliente.tpessoa.Nome;
      end;

      AddCds(obCliente.tcliente.ArquivoImp, Status, MsgImp, Nst(I), 0, 0, 0);
    end
    else if FDicImportacao.Lista.Items[I].ClassType = TWebIntegracaoPedido then
    begin
      obPedido := TWebIntegracaoPedido(FDicImportacao.Lista.Items[I]);
      MsgImp := obPedido.tpedido.ValidarImportacao;

      if MsgImp <> '' then
      begin
        Status := 'ERRO';
        Inc(TotErros);
      end
      else
      begin
        // Montangem da mensagem de importação sem erros
        MsgImp := 'Pedido ';
        if obPedido.tpedido.id > 0 then
        begin
          MsgImp := MsgImp + Nst(obPedido.tpedido.id) + ' ';
          if obPedido.tpedido.TipoOpr = 'GRAVAR' then
          begin
            Status := 'ALTERADO';
            Inc(TotAlterados);
          end
          else
          begin
            Status := 'EXCLUÍDO';
            Inc(TotExcluidos);
          end;
        end
        else
        begin
          Status := 'NOVO';
          Inc(TotNovos);
        end;

        MsgImp := MsgImp + 'emitido em ' + FormatDateTime('dd/mm/yyyy', obPedido.tpedido.Emissao);
      end;

      AddCds(obPedido.tpedido.ArquivoImp, Status, MsgImp, Nst(I), 0, 0, 0);
    end;
  end;

  lblTotErros.Caption := 'Erros: ' + Nst(TotErros);
  lblTotAlterados.Caption := 'Alterações: ' + Nst(TotAlterados);
  lblTotExcluidos.Caption := 'Exclusões: ' + Nst(TotExcluidos);
  lblTotNovos.Caption := 'Novos: ' + Nst(TotNovos);

  cdsImportacao.First;
end;

procedure TF_SincImportacao.SetCfgWebSen(const Value: String);
begin
  FCfgWebSen := Value;
end;

procedure TF_SincImportacao.SetCfgWebUsu(const Value: String);
begin
  FCfgWebUsu := Value;
end;

procedure TF_SincImportacao.SetDicImportacao(const Value: TListaObjetos);
begin
  FDicImportacao := Value;
end;

procedure TF_SincImportacao.ValidarSelecao;
begin
  cdsImportacao.DisableControls;
  try
    cdsImportacao.First;
    while not cdsImportacao.Eof do
    begin
      if (Ivl(cdsImportacao['Sob']) < 1) and (Ivl(cdsImportacao['Des']) < 1) and (Ivl(cdsImportacao['Ign']) < 1) then
        raise Exception.Create('Nenhuma ação selecionada para o registro: ' + sLineBreak + ' - ' + Nst(cdsImportacao['Descri']) + '!');

      Application.ProcessMessages;
      cdsImportacao.Next;
    end;
  finally
    cdsImportacao.EnableControls;
  end;
end;

procedure TF_SincImportacao.AddCds(AArquivo, ASit, ADescri, ARegDic: String; ASob, ADes, AIgn: Integer);
begin
  if cdsImportacao.Locate('Arquivo', AArquivo, []) then
    cdsImportacao.Edit
  else
    cdsImportacao.Append;

  cdsImportacao['Arquivo'] := AArquivo;
  cdsImportacao['Sit'] := ASit;
  cdsImportacao['Sob'] := ASob;
  cdsImportacao['Des'] := ADes;
  cdsImportacao['Ign'] := AIgn;
  cdsImportacao['Descri'] := ADescri;
  cdsImportacao['RegDic'] := ARegDic;
  cdsImportacao.Post;
end;

procedure TF_SincImportacao.ConfirmarClick(Sender: TObject);
begin
  HabilitarForm(False);
  try
    ExecutarProcesso;
  finally
    HabilitarForm(True);
  end;
end;

procedure TF_SincImportacao.CriarCds;
begin
  if cdsImportacao.Active then
  begin
    cdsImportacao.EmptyDataSet;
    Exit;
  end;

  cdsImportacao.Close;
  with cdsImportacao.FieldDefs do
  begin
    Clear;

    Add('Arquivo', ftString, 250, False);
    Add('Sit', ftString, 20, False);
    Add('Sob', ftInteger, 0, False);
    Add('Des', ftInteger, 0, False);
    Add('Ign', ftInteger, 0, False);
    Add('Descri', ftString, 250, False);
    Add('RegDic', ftString, 50, False);
  end;

  cdsImportacao.CreateDataSet;
  cdsImportacao.IndexFieldNames := 'Sit;Arquivo';
  cdsImportacao.Open;
end;

procedure TF_SincImportacao.DBGrid1CellClick(Column: TColumn);
begin
  if AnsiIndexText(Column.FieldName, ['Sob', 'Des', 'Ign']) < 0 then
    Exit;

  MarcouCampo(Column.FieldName, Ivl(cdsImportacao.FieldByName(Column.FieldName).AsInteger));
end;

procedure TF_SincImportacao.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  Checked: Integer;
  RectTemp: TRect;
begin
  DbgridZebra(cdsImportacao, DBGrid1, Rect, DataCol, Column, State);

  if Nst(cdsImportacao['Sit']) = 'ERRO' then
  begin
    DBGrid1.Canvas.Font.Color := clRed;
  end;

  if Pos('ALTERA', Nst(cdsImportacao['Sit'])) > 0 then
  begin
    DBGrid1.Canvas.Font.Color := clGreen;
  end;

  if Pos('NOVO', Nst(cdsImportacao['Sit'])) > 0 then
  begin
    DBGrid1.Canvas.Font.Color := clBlue;
  end;

  if Pos('EXC', Nst(cdsImportacao['Sit'])) > 0 then
  begin
    DBGrid1.Canvas.Font.Color := clMaroon;
  end;

  DBGrid1.Canvas.FillRect(Rect);
  DBGrid1.DefaultDrawDataCell(Rect, Column.Field, State);

  if AnsiIndexText(Column.FieldName, ['Sob', 'Des', 'Ign']) < 0 then
    Exit;

  DBGrid1.Canvas.FillRect(Rect);
  if Ivl(cdsImportacao.FieldByName(Column.FieldName).AsInteger) = 1 then
    Checked := DFCS_CHECKED
  else
    Checked := 0;

  RectTemp := Rect;
  InflateRect(RectTemp, -1, -1);

  DrawFrameControl(DBGrid1.Canvas.Handle, RectTemp, DFC_BUTTON, DFCS_BUTTONCHECK or Checked);
end;

procedure TF_SincImportacao.DBGrid1TitleClick(Column: TColumn);
var
  AValorAtual: Integer;
  Bmk: TBookmark;
begin
  if AnsiIndexText(Column.FieldName, ['Sob', 'Des', 'Ign']) < 0 then
    Exit;

  // Adiciona o valor inverso ao registro selecionado para todos os campos da coluna atual
  Bmk := cdsImportacao.GetBookmark;
  HabilitarForm(False);
  try
    AValorAtual := Ivl(cdsImportacao[Column.FieldName]);

    cdsImportacao.First;
    while not cdsImportacao.Eof do
    begin
      MarcouCampo(Column.FieldName, AValorAtual);

      Application.ProcessMessages;
      cdsImportacao.Next;
    end;
  finally
    cdsImportacao.GotoBookmark(Bmk);
    HabilitarForm(True);
  end;
end;

procedure TF_SincImportacao.ExecutarProcesso;
begin
  Try
    ValidarSelecao;
    FazImportacao;

    ModalResult := mrOk;
  Except
    on E: Exception do
    begin
      DL_Msg('Ocorreu um erro: ' + E.Message, Application.Title, 'ERRO');
      Abort;
    end
    else
    begin
      DL_Msg('Ocorreu um erro!', Application.Title, 'ERRO');
      Abort;
    end;
  End;
end;

procedure TF_SincImportacao.FazImportacao;
var
  obCliente: TWebIntegracaoCliente;
  obPedido: TWebIntegracaoPedido;
  ArquivoJson, UsuIni, SenhaIni: String;
  obSincWeb: TSincWeb;
begin
  cdsImportacao.DisableControls;
  obSincWeb := TSincWeb.Create(self);
  try
    // Guarda a senha padrão
    UsuIni := GetUsuario;
    SenhaIni := GetSenha;

    // Conexão com o usuário padrão para não dispara as triggers
    ConectaBase(T2.WSepeDBX, T2.WSepeDBX.ConnectionName, GetEmpresa, CfgWebUsu, CfgWebSen, '');

    // Percorre a coleção de objetos a serem importados
    cdsImportacao.First;
    while not cdsImportacao.Eof do
    begin
      ArquivoJson := '';

      // Atualiza registros a novos ou alterados
      InicioTransacao(T2.WSepeDBX);
      try
        if (Ivl(cdsImportacao['Sob']) > 0) or (Ivl(cdsImportacao['Des']) > 0) then
        begin
          // Faz a gravação ou exclusão do registro de Clientes
          if FDicImportacao.Lista.Items[Ivl(cdsImportacao['RegDic'])].ClassType = TWebIntegracaoCliente then
          begin
            obCliente := TWebIntegracaoCliente(FDicImportacao.Lista.Items[Ivl(cdsImportacao['RegDic'])]);

            // Guarda o arquivo para sua posterior exclusão
            ArquivoJson := obCliente.tcliente.ArquivoImp;

            // Atualiza o registro do sistema conforme arquivo de importação
            if Ivl(cdsImportacao['Sob']) > 0 then
              obCliente.tcliente.ExecutarOperacao;
          end;

          // Faz a gravação ou exclusão do registro de Pedidos
          if FDicImportacao.Lista.Items[Ivl(cdsImportacao['RegDic'])].ClassType = TWebIntegracaoPedido then
          begin
            obPedido := TWebIntegracaoPedido(FDicImportacao.Lista.Items[Ivl(cdsImportacao['RegDic'])]);

            // Guarda o arquivo para sua posterior exclusão
            ArquivoJson := obPedido.tpedido.ArquivoImp;

            // Atualiza o registro do sistema conforme arquivo de importação
            if Ivl(cdsImportacao['Sob']) > 0 then
              obPedido.tpedido.ExecutarOperacao;
          end;
        end;

        // Quando sobrescrever ou descarta precisa excluir o arquivo de importação
        if (Ivl(cdsImportacao['Sob']) > 0) or (Ivl(cdsImportacao['Des']) > 0) then
        begin
          if ArquivoJson <> '' then
            if not obSincWeb.ExcluirArquivo(ArquivoJson) then
              raise Exception.Create('Não foi possível excluir arquivo de importação no servidor: ' + ArquivoJson + '!');
        end;

        FimTransacao(T2.WSepeDBX, True);
      Except
        on E: Exception do
        begin
          FimTransacao(T2.WSepeDBX, False);
          raise Exception.Create(E.Message);
        end
        else
        begin
          FimTransacao(T2.WSepeDBX, False);
          raise Exception.Create('Erro desconhecido!');
        end;
      End;

      Application.ProcessMessages;
      cdsImportacao.Next;
    end;
  finally
    cdsImportacao.EnableControls;
    obSincWeb.Free;
    ConectaBase(T2.WSepeDBX, T2.WSepeDBX.ConnectionName, GetEmpresa, UsuIni, SenhaIni);
  end;
end;

procedure TF_SincImportacao.fecharClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

end.
