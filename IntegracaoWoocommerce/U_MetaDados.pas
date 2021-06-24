unit U_MetaDados;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, U_PadraoCad, ImgList, StdCtrls, CheckLst, Grids, DBGrids, ExtCtrls,
  Buttons, ComCtrls, DBCtrls, DB, CMetaDados;

type
  TF_MetaDados = class(TF_PadraoCad)
    procedure edtCodDeExit(Sender: TObject);
    procedure IncluirClick(Sender: TObject);
    procedure btManutencaoClick(Sender: TObject);
    procedure btDuplicarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnAtualizarClick(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }

    obMetaDados: TMetaDados;

    procedure Selecionar; override;
  end;

var
  F_MetaDados: TF_MetaDados;

implementation

uses U_T2, SelecaoAvancada, U_SisProc, Conexao, U_MetaDados1;

{$R *.dfm}

{ TF_Dimensoes }

procedure TF_MetaDados.btDuplicarClick(Sender: TObject);
begin
  inherited;

  Application.CreateForm(TF_MetaDados1, F_MetaDados1);
  with F_MetaDados1 do
  begin
    Visualizar.Visible := False;
    btExcluir.Visible  := False;
    Caption            := 'Incluir';

    Mostra;

    ShowModal;
  end;
end;

procedure TF_MetaDados.btManutencaoClick(Sender: TObject);
begin
  inherited;

  Application.CreateForm(TF_MetaDados1, F_MetaDados1);
  with F_MetaDados1 do
  begin
    Caption:= 'Manutenção';
    Mostra;

    ShowModal;
  end;
end;

procedure TF_MetaDados.btnAtualizarClick(Sender: TObject);
begin
  Selecionar;
end;

procedure TF_MetaDados.edtCodDeExit(Sender: TObject);
begin
  inherited;
  if Trim((Sender as TLabeledEdit).Text) <> '' then
    (Sender as TLabeledEdit).Text := StrZero((Sender as TLabeledEdit).Text, 5);
end;

procedure TF_MetaDados.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  obMetaDados.Free;
end;

procedure TF_MetaDados.FormCreate(Sender: TObject);
begin
  inherited;
  obMetaDados := TMetaDados.Create;
end;

procedure TF_MetaDados.IncluirClick(Sender: TObject);
begin
  inherited;

  Application.CreateForm(TF_MetaDados1, F_MetaDados1);
  with F_MetaDados1 do
  begin
    Caption:= 'Incluir';
    ValoresDefault;
    Visualizar.Visible:= false;

    ShowModal;
  end;  
end;

procedure TF_MetaDados.Selecionar;
begin
  obMetaDados.CarregarDados;

  titPesq.Caption:= 'Descrição:';
  OrdenaGridMultIndex(DBGrid1, T2.cdsMetaDados, 'Descrição do Tipo Pagto / Banco');

  Application.ProcessMessages;
end;

end.
