unit U_WSepeWoo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, U_SisProc, IdHTTP, IdMultipartFormData,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, Buttons, Menus, DB, DBClient, U_WooControl, CParametros,
  ImgList, Vcl.ToolWin, Vcl.ActnMan, Vcl.ActnCtrls, Vcl.ActnMenus, System.Actions, Vcl.ActnList, Vcl.PlatformDefaultStyleActnCtrls,
  Vcl.ComCtrls, DateUtils, Vcl.CustomizeDlg, Vcl.XPStyleActnCtrls, CEmail, U_Sistema;

type
  TF_WSepeWoo = class(TForm)
    ActionMainMenuBar1: TActionMainMenuBar;
    StatusBar1: TStatusBar;
    ActionToolBar1: TActionToolBar;
    ImageList1: TImageList;
    ActionManager1: TActionManager;
    Sistema: TAction;
    Fer_btSair: TAction;
    Fer_btEditor: TAction;
    Fer_btCalendario: TAction;
    Fer_btCalculadora: TAction;
    Fer_btEmail: TAction;
    Fer_Sair: TAction;
    Exp_Exportao: TAction;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    Salvar1: TMenuItem;
    Configuraooriginal1: TMenuItem;
    CustomizeDlg1: TCustomizeDlg;
    Calendario: TMonthCalendar;
    Arq_Configuraes: TAction;
    Action4: TAction;
    Action6: TAction;
    Action7: TAction;
    Action8: TAction;
    Con_Preferncias: TAction;
    Imp_Importacao: TAction;
    procedure btMinimizarClick(Sender: TObject);
    procedure Exibir1Click(Sender: TObject);
    procedure TrayIcon1DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Arq_ConfiguraesExecute(Sender: TObject);
    procedure Arq_VerLogExecute(Sender: TObject);
    procedure Arq_RegrasparaExportaoExecute(Sender: TObject);
    procedure Arq_ConfigurarUsuriosExecute(Sender: TObject);
    procedure Fer_btSairExecute(Sender: TObject);
    procedure SistemaExecute(Sender: TObject);
    procedure Fer_btEditorExecute(Sender: TObject);
    procedure Fer_btCalendarioExecute(Sender: TObject);
    procedure Fer_btCalculadoraExecute(Sender: TObject);
    procedure Fer_btEmailExecute(Sender: TObject);
    procedure Fer_SairExecute(Sender: TObject);
    procedure Action6Execute(Sender: TObject);
    procedure Exp_ExportaoExecute(Sender: TObject);
    procedure Con_PrefernciasExecute(Sender: TObject);
    procedure Imp_ImportacaoExecute(Sender: TObject);
  private
    { Private declarations }

    IntSin, HoraIni, HoraFim, ProxConsulta: TDateTime;
    Inicializando: Boolean;
    FLogErrosPath: String;

    procedure SetLogErrosPath(const Value: String);
    procedure GravarLog(ATextoLog: String; AComData: Boolean = True);
    procedure FazExportacao;
    procedure FazImportacao;
  public
    { Public declarations }
    property LogErrosPath: String read FLogErrosPath write SetLogErrosPath;
  end;

var
  F_WSepeWoo: TF_WSepeWoo;

implementation

uses U_T2, Conexao, U_ParametrosBD, U_Parametros, U_ConfigObjetos, U_Editor, U_AlterarSincronizacao, U_Preferencias, U_ExportarDados;

{$R *.dfm}

procedure TF_WSepeWoo.Exp_ExportaoExecute(Sender: TObject);
begin
  if (ParamCount > 0) then
  begin
    if (ParamStr(1) = 'AUTO') then
    begin
      FazExportacao;
      FazImportacao;
    end;
  end
  else
  begin
    Application.CreateForm(TF_ExportarDados, F_ExportarDados);
    F_ExportarDados.ShowModal;
  end;
end;

procedure TF_WSepeWoo.Imp_ImportacaoExecute(Sender: TObject);
begin
  if (ParamCount > 0) then
  begin
    if (ParamStr(1) = 'AUTO') then
      FazImportacao;
  end
  else
    FazImportacao;
end;

procedure TF_WSepeWoo.Action6Execute(Sender: TObject);
begin
  Application.CreateForm(TF_AlterarSincronizacao, F_AlterarSincronizacao);
  F_AlterarSincronizacao.ShowModal;
end;

procedure TF_WSepeWoo.Arq_ConfiguraesExecute(Sender: TObject);
begin
  Application.CreateForm(TF_ParametrosBD, F_ParametrosBD);
  F_ParametrosBD.ShowModal;
end;

procedure TF_WSepeWoo.Arq_ConfigurarUsuriosExecute(Sender: TObject);
begin
  Application.CreateForm(TF_Parametros, F_Parametros);
  F_Parametros.Visible := False;
  F_Parametros.ShowModal;
end;

procedure TF_WSepeWoo.Arq_RegrasparaExportaoExecute(Sender: TObject);
begin
  Try
    F_ConfigObjetos.Show
  Except
    Application.CreateForm(TF_ConfigObjetos, F_ConfigObjetos);
  End;
end;

procedure TF_WSepeWoo.Arq_VerLogExecute(Sender: TObject);
begin
  VerErros(FLogErrosPath);
end;

procedure TF_WSepeWoo.btMinimizarClick(Sender: TObject);
begin
  F_WSepeWoo.Hide;
end;

procedure TF_WSepeWoo.Con_PrefernciasExecute(Sender: TObject);
begin
  Application.CreateForm(TF_Preferencias, F_Preferencias);
  F_Preferencias.Visible := False;
  F_Preferencias.ShowModal;
end;

procedure TF_WSepeWoo.Exibir1Click(Sender: TObject);
begin
  F_WSepeWoo.Show;
end;

procedure TF_WSepeWoo.FazExportacao;
var
  obControl: TWooControl;
begin
  obControl := TWooControl.Create;
  try
    obControl.AlxSaldo := TParametros.getDmdAlx;
    obControl.DataUltima := obControl.GetUltimaSincronizacao;
    obControl.FazExportacao;
  finally
    obControl.Free;
  end;
end;

procedure TF_WSepeWoo.FazImportacao;
var
  obControl: TWooControl;
begin
  obControl := TWooControl.Create;
  try
    obControl.FazImportacao;
  finally
    obControl.Free;
  end;
end;

procedure TF_WSepeWoo.Fer_btCalculadoraExecute(Sender: TObject);
begin
  ExecuteFile('calc', '', '', SW_Show);
end;

procedure TF_WSepeWoo.Fer_btCalendarioExecute(Sender: TObject);
begin
  Calendario.Visible := not Calendario.Visible;
  Fer_btCalendario.Checked := Calendario.Visible;
  Calendario.Date := Date;
end;

procedure TF_WSepeWoo.Fer_btEditorExecute(Sender: TObject);
begin
  Application.CreateForm(TF_Editor, F_Editor);
  F_Editor.RichEdit1.Lines.Clear;
  F_Editor.Alterado := False;
  F_Editor.ControlaAlteracao := True;
  F_Editor.ShowModal;
end;

procedure TF_WSepeWoo.Fer_btEmailExecute(Sender: TObject);
begin
  sendMail('endereco', '', 'Assunto', 'Sua Mensagem', '', True);
end;

procedure TF_WSepeWoo.Fer_btSairExecute(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TF_WSepeWoo.Fer_SairExecute(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TF_WSepeWoo.FormCreate(Sender: TObject);
begin
  Inicializando := True;

  // Conexão com a base de dados
  if Inicializando then
  begin
    Inicializando := False;

    if not FileExists(ExtractFilePath(Application.ExeName) + 'SepeWoo.ini') then
    begin
      Arq_ConfiguraesExecute(Arq_Configuraes);
      Application.Terminate;
      Exit;
    end;

    LigaQuery_TSQLConection(T2.WSepeDBX, T2);
    if not T2.FazConexao then
      Application.Terminate;

    StatusBar1.Panels.Items[1].Text := 'IP: ' + GetIP;
    StatusBar1.Panels.Items[2].Text := 'V ' + MostraVersao(Application.ExeName);

    FLogErrosPath := ExtractFilePath(Application.ExeName) + '\LogWoo\';
    VerificaCriaPasta(FLogErrosPath);
    FLogErrosPath := FLogErrosPath + 'LogWooSinc_' + FormatDateTime('yyyy_mm', Date) + '.txt';

    if (ParamCount > 0) then
      if (ParamStr(1) = 'AUTO') then
        Exp_ExportaoExecute(Exp_Exportao);
  end;
end;

procedure TF_WSepeWoo.GravarLog(ATextoLog: String; AComData: Boolean);
begin
  if AComData then
    ATextoLog := FormatDateTime('dd/mm/yyyy hh:nn:ss', Now) + ': ' + ATextoLog;

  gravaLog(FLogErrosPath, ATextoLog);
end;

procedure TF_WSepeWoo.SetLogErrosPath(const Value: String);
begin
  FLogErrosPath := Value;
end;

procedure TF_WSepeWoo.SistemaExecute(Sender: TObject);
begin
  try
    F_Sistema.Show;
  except
    Application.CreateForm(TF_Sistema, F_Sistema);
    F_Sistema.Show;
  end;
  F_Sistema.ProductName.Caption := 'Módulo de Integração com Woocommerce';
  F_Sistema.Version.Caption := 'Versão: ' + MostraVersao(Application.ExeName);
end;

procedure TF_WSepeWoo.TrayIcon1DblClick(Sender: TObject);
begin
  F_WSepeWoo.Show;
end;

end.
