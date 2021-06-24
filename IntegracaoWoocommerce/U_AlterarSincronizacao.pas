unit U_AlterarSincronizacao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, Buttons, ExtCtrls, DBCtrls, U_WooControl;

type
  TF_AlterarSincronizacao = class(TForm)
    Panel1: TPanel;
    btGravar: TBitBtn;
    Fechar: TSpeedButton;
    lblDataSinc: TLabel;
    Label1: TLabel;
    edtDtaUlt: TMaskEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FecharClick(Sender: TObject);
    procedure btGravarClick(Sender: TObject);
    procedure edtDtaUltExit(Sender: TObject);
    procedure edtDtaUltKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure Gravar;
  public
    { Public declarations }
  end;

var
  F_AlterarSincronizacao: TF_AlterarSincronizacao;

implementation

uses U_Sisproc;

{$R *.DFM}

procedure TF_AlterarSincronizacao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := Cafree;
  F_AlterarSincronizacao := nil;
end;

procedure TF_AlterarSincronizacao.FormCreate(Sender: TObject);
var
  obControl: TWooControl;
begin
  obControl := TWooControl.Create();
  try
    edtDtaUlt.Text := FormatDateTime('dd/mm/yyyy', obControl.GetUltimaSincronizacao);
  finally
    obControl.Free;
  end;
end;

procedure TF_AlterarSincronizacao.FormKeyPress(Sender: TObject; var Key: Char);
begin
  NextControl(Self, Key);
end;

procedure TF_AlterarSincronizacao.Gravar;
var
  obControl: TWooControl;
begin
  obControl := TWooControl.Create();
  try
    if Trim(edtDtaUlt.Text) = '/  /' then
      obControl.SetUltimaSincronizacao(StrToDate('01/01/1990'))
    else
      obControl.SetUltimaSincronizacao(StrToDate(edtDtaUlt.Text));
  finally
    obControl.Free;
  end;
end;

procedure TF_AlterarSincronizacao.btGravarClick(Sender: TObject);
begin
  btGravar.Enabled := False;
  try
    Gravar;
    ShowMessageTimer();
  finally
    btGravar.Enabled := True;
  end;
end;

procedure TF_AlterarSincronizacao.edtDtaUltExit(Sender: TObject);
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

procedure TF_AlterarSincronizacao.edtDtaUltKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 72 then
    (Sender as TMaskEdit).Text := FormatDateTime('dd/mm/yyyy', Date); { 72 = H = Hoje }
end;

procedure TF_AlterarSincronizacao.FecharClick(Sender: TObject);
begin
  Close;
end;

end.
