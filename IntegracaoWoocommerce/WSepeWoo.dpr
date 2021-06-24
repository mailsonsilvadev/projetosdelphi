program WSepeWoo;

uses
  Forms,
  Windows,
  Dialogs,
  U_WSepeWoo in 'U_WSepeWoo.pas' {F_WSepeWoo},
  U_SisProc in '..\unitdatalan\U_SisProc.pas',
  Conexao in '..\unitdatalan\Conexao.pas',
  Transacao in '..\unitdatalan\Transacao.pas',
  U_ParametrosBD in 'U_ParametrosBD.pas' {F_ParametrosBD},
  U_MensagemTimer in '..\unitdatalan\U_MensagemTimer.pas' {F_MensagemTimer},
  U_T2 in 'U_T2.pas' {T2: TDataModule},
  U_Tributacao in '..\unitdatalan\U_Tributacao.pas',
  CParametrosBDIni in 'CParametrosBDIni.pas',
  CProdutos in '..\classes\CProdutos.pas',
  U_TribNCM in '..\regras\U_TribNCM.pas',
  U_ValidarVendedor in '..\SepeEcf\U_ValidarVendedor.pas',
  U_SenhaDesconto in '..\SepeVen\U_SenhaDesconto.pas' {F_SenhaDesconto},
  U_Constantes in '..\SepeLoja\U_Constantes.pas',
  U_RotinaFidelidade in '..\SepeEcf\U_RotinaFidelidade.pas',
  U_CliInadim in '..\SepeVen\U_CliInadim.pas',
  U_ConversaoQuantidade in '..\SepeVen\U_ConversaoQuantidade.pas',
  CTabelaprecosFull in '..\classesfull\CTabelaprecosFull.pas',
  U_ConfigObjetos in '..\SepeEsepe\U_ConfigObjetos.pas' {F_ConfigObjetos},
  U_GerarObjetos in '..\SepeEsepe\U_GerarObjetos.pas',
  U_Script in '..\SepeEsepe\U_Script.pas',
  U_Parametros in '..\SepeEsepe\U_Parametros.pas' {F_Parametros},
  U_ExportarDados in 'U_ExportarDados.pas' {F_ExportarDados},
  U_Editor in '..\unitdatalan\U_Editor.pas' {F_Editor},
  U_WooProduto in 'U_WooProduto.pas',
  U_WooProdutoItem in 'U_WooProdutoItem.pas',
  U_WooControl in 'U_WooControl.pas',
  U_WooDadosProduto in 'U_WooDadosProduto.pas',
  U_WooIntegracao in 'U_WooIntegracao.pas',
  U_IntegracaoPedido in 'U_IntegracaoPedido.pas',
  U_OcrPedLiberacao in '..\SepeVen\U_OcrPedLiberacao.pas',
  U_Preferencias in 'U_Preferencias.pas' {F_Preferencias},
  CTamanho in '..\classes\CTamanho.pas',
  CTamanhoFull in '..\classesfull\CTamanhoFull.pas';

{$R *.res}

var
  MutexHandle: THandle;

begin

  { Verifica se já possui outra instância do programa rodando }
  MutexHandle := CreateMutex(nil, True, 'WSepeWoo');
  if (MutexHandle <> 0) then
  begin
    if (GetLastError = ERROR_ALREADY_EXISTS) then // se já está rodando fecha o executavel
    begin
      CloseHandle(MutexHandle);
      Exit;
    end;
  end;

  Application.Initialize;
  Application.Title := 'Integração e-Commerce';
  Application.CreateForm(TT2, T2);
  Application.CreateForm(TF_WSepeWoo, F_WSepeWoo);
  Application.CreateForm(TF_Preferencias, F_Preferencias);
  Application.ShowMainForm := True;
  if (ParamCount > 0) then
    if (ParamStr(1) = 'AUTO') then
    begin
      Application.Terminate;
    end;

  Application.Run;
end.
