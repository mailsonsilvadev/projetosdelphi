unit U_HistoricoPedido;

interface

uses CVenaPdh, SysUtils;

type
  THistoricoPedido = class(TObject)
  private

  public
    function GravarHistorico(ANroPed, AObservacao, ATipo: String): Boolean;
  end;

implementation

uses Conexao;

{ THistoricoPedido }

function THistoricoPedido.GravarHistorico(ANroPed, AObservacao, ATipo: String): Boolean;
var
  obHistorico: TVenapdh;
begin
  obHistorico := TVenapdh.Create;
  Try
    obHistorico.setPdh_id(obHistorico.Auto_inc_pdh_id(1));
    obHistorico.setPdh_nroped(ANroPed);
    obHistorico.setPdh_ocrhor(FormatDateTime('hh:mm:ii', Now));
    obHistorico.setPdh_ocrdat(Date);
    obHistorico.setPdh_obs(AObservacao);
    obHistorico.setPdh_datatu(Date);
    obHistorico.setPdh_usratu(GetUsuario);

    if ATipo = 'INT' then
      obHistorico.setPdh_codocr('I');
    obHistorico.Incluir
  Finally
    obHistorico.Free;
  End;
end;

end.
