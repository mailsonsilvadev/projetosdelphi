unit U_WsepeEsepe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ImgList, ExtCtrls, ToolWin, QRExport, Menus, Jpeg,
  QRWebFilt, QRXMLSFilt, QRPDFFilt, XPStyleActnCtrls, ActnList, ActnMan,
  ActnCtrls, ActnMenus, CustomizeDlg, U_IdentifUsr, System.Actions, frxExportODF,
  frxExportMail, frxExportCSV, frxExportText, frxExportImage, frxExportRTF, frxExportXML,
  frxExportXLS, frxExportHTML, frxClass, frxExportPDF, U_SincWeb, frxExportBaseDialog, MidasLib, System.ImageList;

type
  TF_WsepeEsepe = class(TForm)
    QRHTMLFilter1: TQRHTMLFilter;
    QRCSVFilter1: TQRCSVFilter;
    QRTextFilter1: TQRTextFilter;
    StatusBar1: TStatusBar;
    ImageList1: TImageList;
    Calendario: TMonthCalendar;
    ImgDataLan: TImage;
    ImgEmp: TImage;
    QRPDFFilter1: TQRPDFFilter;
    QRXMLSFilter1: TQRXMLSFilter;
    QRExcelFilter1: TQRExcelFilter;
    QRRTFFilter1: TQRRTFFilter;
    QRWMFFilter1: TQRWMFFilter;
    ActionManager1: TActionManager;
    FER_Editor: TAction;
    FER_Calendario: TAction;
    FER_Calculadora: TAction;
    FER_Email: TAction;
    FER_Sair: TAction;
    ActionMainMenuBar1: TActionMainMenuBar;
    ActionToolBar1: TActionToolBar;
    PopupMenu1: TPopupMenu;
    Preferencias1: TMenuItem;
    MenuItem1: TMenuItem;
    Configuraooriginal1: TMenuItem;
    CustomizeDlg1: TCustomizeDlg;
    Salvar1: TMenuItem;
    Action1: TAction;
    frxPDFExport1: TfrxPDFExport;
    frxHTMLExport1: TfrxHTMLExport;
    frxXLSExport1: TfrxXLSExport;
    frxXMLExport1: TfrxXMLExport;
    frxRTFExport1: TfrxRTFExport;
    frxBMPExport1: TfrxBMPExport;
    frxJPEGExport1: TfrxJPEGExport;
    frxTIFFExport1: TfrxTIFFExport;
    frxGIFExport1: TfrxGIFExport;
    frxSimpleTextExport1: TfrxSimpleTextExport;
    frxCSVExport1: TfrxCSVExport;
    frxMailExport1: TfrxMailExport;
    frxODSExport1: TfrxODSExport;
    frxODTExport1: TfrxODTExport;
    Par_Configurarobjetos: TAction;
    Action3: TAction;
    Par_Configuraes: TAction;
    PEd_PedidosWEB: TAction;
    Par_ConfiguraesWeb: TAction;
    Action2: TAction;
    Rel_RelaodePedidos: TAction;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure FER_SairExecute(Sender: TObject);
    procedure FER_EditorExecute(Sender: TObject);
    procedure FER_CalendarioExecute(Sender: TObject);
    procedure FER_CalculadoraExecute(Sender: TObject);
    procedure FER_EmailExecute(Sender: TObject);
    procedure Preferencias1Click(Sender: TObject);
    procedure Configuraooriginal1Click(Sender: TObject);
    procedure Salvar1Click(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure Par_ConfigurarobjetosExecute(Sender: TObject);
    procedure Action3Execute(Sender: TObject);
    procedure Par_ConfiguraesExecute(Sender: TObject);
    procedure PEd_PedidosWEBExecute(Sender: TObject);
    procedure Par_ConfiguraesWebExecute(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
    procedure Rel_RelaodePedidosExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_WsepeEsepe: TF_WsepeEsepe;

  Cont_Forms: Integer;

implementation

uses U_T2, U_Sisproc, Conexao, U_AcessoSistema, Abertura,
  CSepecfg, CLog, U_Editor, CEmail, U_ConsultaEmp, U_ConfigObjetos, U_Sincronizar, U_Parametros, U_Pedidos, U_ParametrosBD,
  U_Sistema, U_RelPedidosWeb;

{$R *.dfm}

procedure TF_WsepeEsepe.Action1Execute(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TF_WsepeEsepe.Action2Execute(Sender: TObject);
begin
  try F_Sistema.Show; except Application.CreateForm(TF_Sistema, F_Sistema) end;
  F_Sistema.ProductName.Caption:= 'Módulo de Pedidos Esepe';
  F_Sistema.Version.Caption    := 'Versão: ' + MostraVersao(Application.ExeName);
end;

procedure TF_WsepeEsepe.Action3Execute(Sender: TObject);
begin
  Application.CreateForm(TF_Sincronizar, F_Sincronizar);
  F_Sincronizar.ShowModal;
end;

procedure TF_WsepeEsepe.Configuraooriginal1Click(Sender: TObject);
var
  I: Integer;
begin
  // PARA RESETAR A CONFIGURAÇÃO DO USUÁRIO E VOLTAR O ORIGINAL
  ActionManager1.FileName := '';

  if FileExists('MNU' + '\' + Self.Name + '_' + GetUsuario + '.MNU') then
    DeleteFile('MNU' + '\' + Self.Name + '_' + GetUsuario + '.MNU');

  for I := 0 to ActionManager1.ActionBars.Count - 1 do
    ActionManager1.ResetActionBar(I);
end;

procedure TF_WsepeEsepe.FER_CalculadoraExecute(Sender: TObject);
begin
  ExecuteFile('calc', '', '', SW_Show);
end;

procedure TF_WsepeEsepe.FER_CalendarioExecute(Sender: TObject);
begin
  Calendario.Visible := not Calendario.Visible;
  FER_Calendario.Checked := Calendario.Visible;
  Calendario.Date := Date;
end;

procedure TF_WsepeEsepe.FER_EditorExecute(Sender: TObject);
begin
  Application.CreateForm(TF_Editor, F_Editor);
  F_Editor.RichEdit1.Lines.Clear;
  F_Editor.Alterado := False;
  F_Editor.ControlaAlteracao := True;
  F_Editor.ShowModal;
end;

procedure TF_WsepeEsepe.FER_EmailExecute(Sender: TObject);
begin
  sendMail('endereco', '', 'Assunto', 'Sua Mensagem', '', True);
end;

procedure TF_WsepeEsepe.FER_SairExecute(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TF_WsepeEsepe.FormActivate(Sender: TObject);
var
  AliasDbx, Arq: string;
  obSincWeb: TSincWeb;
begin
  Application.ProcessMessages;
  if Cont_Forms = 1 then
  begin

    TestaResolucao(1024, 768);
    LigaQuery_TSQLConection(T2.WsepeDBX, T2);

    if not Le_Identif(F_WsepeEsepe) then
      Application.Terminate
    else
    begin
   //   EsperaAnimada(Animate1, True);

      AliasDbx := GetAliasDBX;

      Application.ProcessMessages;
      Cont_Forms := 0;

      // verifica se o sistema esta dentro da validade,
      // se nao estiver encerra a aplicacao
      try
        T2.qEmpresa.Close;
        T2.qEmpresa.SQL.Clear;
        T2.qEmpresa.SQL.Add('Select * from Empresa');
        T2.qEmpresa.Open;
        if not VerAcessoSistema(T2.qEmpresa, T2.WsepeDBX) then
          Application.Terminate
      except
        on E: Exception do
        begin
          showMessage('Ocorreu um erro: ' + #13#10 + E.message);
          Application.Terminate;
        end;
        else
        begin
          showMessage('Ocorreu um erro na abertura do sistema.');
          Application.Terminate;
        end;
      end;

      // Faz Abertura do sistema, passa como parâmetro nome do usuário
      if not AbreSis(GetUsuario, T2.qgSepeCfg) then
        Application.Terminate;

      obSincWeb := TSincWeb.Create(Self);
      try
        obSincWeb.RegistrarWebService;
      finally
        obSincWeb.Free;
      end;
    end;

    StatusBar1.Panels.Items[1].Text := Nst(T2.cdsSepe['Login']);
    StatusBar1.Panels.Items[2].Text := AliasDbx;
    StatusBar1.Panels.Items[3].Text := 'IP:' + GetIp;
    StatusBar1.Panels.Items[4].Text:=  'V ' + MostraVersao(Application.ExeName);

    //ToolBar1.Free;

    Arq := ExtractFilePath(Application.ExeName) + 'MNU' + '\' + Self.Name + '_' + GetUsuario + '.MNU';
    if FileExists(Arq) then
    begin
      ActionToolBar1.ActionManager.FileName := Arq;
      ActionToolBar1.ActionManager.LoadFromFile(Arq);
    end;
    ActionToolBar1.ColorMap.Color := clWhite;
  end;

 // EsperaAnimada(Animate1, False);
end;

procedure TF_WsepeEsepe.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  F_WsepeEsepe := Nil;
  Action := Cafree;
end;

procedure TF_WsepeEsepe.FormCreate(Sender: TObject);
begin
  // formata a data
  ConfigurarAmbiente('Data', 'DD/MM/YYYY');

  Cont_Forms := 1;

  ImgDataLan.Left := Screen.Width - 200; // 280;
  ImgDataLan.Top := Screen.Height - 280; // 300;

  if FileExists(ExtractFilePath(Application.ExeName) + 'ImgDataLan.Jpg') // logo DataLan
  then
    ImgDataLan.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'ImgDataLan.Jpg');

  // logo empresa
  if FileExists(ExtractFilePath(Application.ExeName) + 'ImgEmp.Bmp') then
    ImgEmp.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'ImgEmp.Bmp');

  if FileExists(ExtractFilePath(Application.ExeName) + 'ImgEmp.Jpg') then
    ImgEmp.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'ImgEmp.Jpg');

  ActionToolBar1.ColorMap.Color := clWhite;
end;

procedure TF_WsepeEsepe.Par_ConfiguraesExecute(Sender: TObject);
begin
  Try
    F_Parametros.Show
  Except
    Application.CreateForm(TF_Parametros, F_Parametros);
  End;
end;

procedure TF_WsepeEsepe.Par_ConfiguraesWebExecute(Sender: TObject);
begin
  Application.CreateForm(TF_ParametrosBD, F_ParametrosBD);
  F_ParametrosBD.ShowModal;
end;

procedure TF_WsepeEsepe.Par_ConfigurarobjetosExecute(Sender: TObject);
begin
  Try
    F_ConfigObjetos.Show
  Except
    Application.CreateForm(TF_ConfigObjetos, F_ConfigObjetos);
  End;
end;

procedure TF_WsepeEsepe.PEd_PedidosWEBExecute(Sender: TObject);
begin
  Try
    F_Pedidos.Show;
  Except
    Application.CreateForm(TF_Pedidos, F_Pedidos);
  End;
end;

procedure TF_WsepeEsepe.Preferencias1Click(Sender: TObject);
begin
  // ATIVA A CONFIGURAÇÃO DA BARRA DE FERRAMENTAS
  CustomizeDlg1.Show;
  CustomizeDlg1.StayOnTop := True;
end;

procedure TF_WsepeEsepe.Rel_RelaodePedidosExecute(Sender: TObject);
begin
  try F_RelPedidosWeb.Show; except Application.CreateForm(TF_RelPedidosWeb, F_RelPedidosWeb) end;
end;

procedure TF_WsepeEsepe.Sair1Click(Sender: TObject);
begin
  Close;
end;

procedure TF_WsepeEsepe.Salvar1Click(Sender: TObject);
var
  Arq: String;
begin
  Arq := ExtractFilePath(Application.ExeName) + 'MNU';
  if not DirectoryExists(Arq) then
    if not CreateDir(Arq) then
    begin
      showMessage('Não foi possível criar a pasta ' + Arq + '.' + #13 + 'A pasta deve ser criada manualmente.');
      Application.Terminate;
    end;

  Arq := Arq + '\' + Self.Name + '_' + GetUsuario + '.MNU';
  ActionToolBar1.ActionManager.FileName := Arq;
  ActionToolBar1.ActionManager.SaveToFile(Arq);
end;

end.
