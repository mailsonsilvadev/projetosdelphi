unit U_ExportarDados;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, Buttons, ExtCtrls, DBCtrls, U_WooControl, Vcl.ComCtrls, CParametros;

type
  TF_ExportarDados = class(TForm)
    Panel1: TPanel;
    btGravar: TBitBtn;
    Fechar: TSpeedButton;
    pbProcesso: TProgressBar;
    ckTudo: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FecharClick(Sender: TObject);
    procedure btGravarClick(Sender: TObject);
    procedure edtDtaUltExit(Sender: TObject);
    procedure edtDtaUltKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure CarregarDataInicial;
  public
    { Public declarations }
  end;

var
  F_ExportarDados: TF_ExportarDados;

implementation

uses U_Sisproc;

{$R *.DFM}

procedure TF_ExportarDados.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := Cafree;
  F_ExportarDados := nil;
end;

procedure TF_ExportarDados.FormCreate(Sender: TObject);
begin
  CarregarDataInicial;
end;

procedure TF_ExportarDados.FormKeyPress(Sender: TObject; var Key: Char);
begin
  NextControl(Self, Key);
end;

procedure TF_ExportarDados.btGravarClick(Sender: TObject);
var
  obControl: TWooControl;
begin
  btGravar.Enabled := False;
  obControl := TWooControl.Create;
  pbProcesso.Visible := True;
  try
    if ckTudo.Checked then
      obControl.SetUltimaSincronizacao(StrToDate('01/01/1990'))
    else
      obControl.SetUltimaSincronizacao(Date);

    obControl.AlxSaldo := TParametros.getDmdAlx;
    obControl.DataUltima := obControl.GetUltimaSincronizacao;
    obControl.FazExportacao;
    obControl.FazImportacao;

    pbProcesso.Visible := False;

    if FileExists(obControl.getLog) then
      VerErros(obControl.getLog)
    else
      ShowMessageTimer();

    CarregarDataInicial;
  finally
    pbProcesso.Visible := False;
    btGravar.Enabled := True;
    obControl.Free;
  end;
end;

procedure TF_ExportarDados.CarregarDataInicial;
var
  obControl: TWooControl;
begin
  obControl := TWooControl.Create();
  try
    if obControl.GetUltimaSincronizacao <= StrToDate('01/01/1990') then
      ckTudo.Checked := True
    else
      ckTudo.Checked := False;
  finally
    obControl.Free;
  end;
end;

procedure TF_ExportarDados.edtDtaUltExit(Sender: TObject);
begin
  If ((Sender as TMaskEdit).Text) = '  /  /    ' Then
  begin
    (Sender as TMaskEdit).Clear;
    Exit;
  end;

  If Not VerData((Sender as TMaskEdit).Text) Then
  Begin
    (Sender as TMaskEdit).SetFocus;
    Exit;
  End;
  (Sender as TMaskEdit).Text := FormatDateTime('dd/mm/yyyy', StrToDateTime((Sender as TMaskEdit).Text));
end;

procedure TF_ExportarDados.edtDtaUltKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 72 then
    (Sender as TMaskEdit).Text := FormatDateTime('dd/mm/yyyy', Date); { 72 = H = Hoje }
end;

procedure TF_ExportarDados.FecharClick(Sender: TObject);
begin
  Close;
end;

end.
