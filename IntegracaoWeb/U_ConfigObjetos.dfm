object F_ConfigObjetos: TF_ConfigObjetos
  Left = 386
  Top = 241
  Caption = 'Configurar objetos para exporta'#231#227'o WEB'
  ClientHeight = 216
  ClientWidth = 721
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 181
    Width = 721
    Height = 35
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Padding.Left = 7
    Padding.Top = 1
    Padding.Right = 7
    Padding.Bottom = 2
    ParentFont = False
    TabOrder = 4
    object fechar: TSpeedButton
      Left = 599
      Top = 2
      Width = 114
      Height = 30
      Align = alRight
      Caption = '&Fechar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      ParentFont = False
      OnClick = fecharClick
      ExplicitLeft = 633
      ExplicitTop = 1
      ExplicitHeight = 32
    end
    object btMarcaDesmarca: TSpeedButton
      Left = 8
      Top = 2
      Width = 89
      Height = 30
      Align = alLeft
      Caption = '&Marcar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333FFFFF3333333333999993333333333F77777FFF333333999999999
        3333333777333777FF33339993707399933333773337F3777FF3399933000339
        9933377333777F3377F3399333707333993337733337333337FF993333333333
        399377F33333F333377F993333303333399377F33337FF333373993333707333
        333377F333777F333333993333101333333377F333777F3FFFFF993333000399
        999377FF33777F77777F3993330003399993373FF3777F37777F399933000333
        99933773FF777F3F777F339993707399999333773F373F77777F333999999999
        3393333777333777337333333999993333333333377777333333}
      NumGlyphs = 2
      ParentFont = False
      OnClick = btMarcaDesmarcaClick
      ExplicitLeft = 160
      ExplicitTop = 8
      ExplicitHeight = 22
    end
    object Confirmar: TBitBtn
      Left = 485
      Top = 2
      Width = 114
      Height = 30
      Align = alRight
      Caption = '&Confirmar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      OnClick = ConfirmarClick
    end
    object btnCriarObjetos: TBitBtn
      Left = 371
      Top = 2
      Width = 114
      Height = 30
      Align = alRight
      Caption = 'Criar &objetos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF007B7B
        7B00000000007B7B7B007B7B7B007B7B7B0000000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000BDBDBD007B7B
        7B00000000007B7B7B00000000000000000000000000FF00FF00FF00FF00FF00
        FF00FF00FF007B7B7B00000000007B7B7B00FF00FF0000000000000000000000
        00007B7B7B007B7B7B0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00000000007B7B7B00000000000000000000000000BDBDBD00BDBD
        BD007B7B7B0000000000000000007B7B7B00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF007B7B7B0000000000000000007B7B7B007B7B7B007B7B7B000000
        000000000000000000007B7B7B0000000000FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00000000007B7B7B007B7B7B00000000007B7B7B000000
        0000FF00FF007B7B7B00000000007B7B7B00FF00FF00FF00FF00FF00FF00FF00
        FF00000000000000000000000000BDBDBD00000000007B7B7B00000000000000
        0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00000000007B7B7B007B7B7B00BDBDBD0000000000BDBDBD00FF00FF00FF00
        FF00FF00FF00000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
        FF00000000000000000000000000BDBDBD00000000007B7B7B00000000007B7B
        7B00FF00FF00000000007B7B7B0000000000FF00FF007B7B7B00000000007B7B
        7B00FF00FF00FF00FF00000000007B7B7B00BDBDBD00000000007B7B7B000000
        000000000000000000007B7B7B000000000000000000000000007B7B7B000000
        0000FF00FF007B7B7B0000000000000000007B7B7B00BDBDBD00000000000000
        00007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B0000000000000000007B7B
        7B00FF00FF00000000007B7B7B00000000000000000000000000000000007B7B
        7B007B7B7B000000000000000000000000007B7B7B007B7B7B0000000000FF00
        FF00FF00FF007B7B7B00000000007B7B7B00FF00FF000000000000000000BDBD
        BD00000000007B7B7B007B7B7B007B7B7B00000000007B7B7B00000000000000
        000000000000FF00FF00FF00FF00FF00FF00FF00FF00000000007B7B7B00BDBD
        BD0000000000BDBDBD00000000007B7B7B00000000007B7B7B007B7B7B007B7B
        7B0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000BDBD
        BD00000000007B7B7B00BDBDBD007B7B7B00000000007B7B7B00000000000000
        000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000007B7B
        7B00BDBDBD000000000000000000000000007B7B7B007B7B7B0000000000FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      ParentFont = False
      TabOrder = 1
      OnClick = btnCriarObjetosClick
    end
  end
  object gbGerais: TGroupBox
    Left = 322
    Top = 71
    Width = 391
    Height = 106
    Caption = 'Objetos gerais:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    Padding.Left = 7
    Padding.Top = 1
    Padding.Right = 7
    Padding.Bottom = 2
    ParentFont = False
    TabOrder = 3
    object cktcadtna: TCheckBox
      Left = 8
      Top = 16
      Width = 111
      Height = 17
      Caption = 'Tipos de natureza'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = cktcadtnaClick
    end
    object cktcadcfop: TCheckBox
      Left = 8
      Top = 32
      Width = 111
      Height = 17
      Caption = 'Cadastro de CFOP'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = cktcadtnaClick
    end
    object cktncmtributacao: TCheckBox
      Left = 8
      Top = 48
      Width = 100
      Height = 18
      Caption = 'Tributa'#231#227'o NCM'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = cktcadtnaClick
    end
    object ckticmsuf: TCheckBox
      Left = 8
      Top = 64
      Width = 100
      Height = 17
      Caption = 'ICMS por UF'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = cktcadtnaClick
    end
    object cktcondpagamento: TCheckBox
      Left = 132
      Top = 32
      Width = 149
      Height = 17
      Caption = 'Condi'#231#245'es de pagamento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnClick = cktcadtnaClick
    end
    object ckttipopag: TCheckBox
      Left = 132
      Top = 16
      Width = 149
      Height = 17
      Caption = 'Tipos de pagamento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = cktcadtnaClick
    end
    object cktbanco: TCheckBox
      Left = 132
      Top = 48
      Width = 132
      Height = 17
      Caption = 'Bancos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      OnClick = cktcadtnaClick
    end
    object ckttransportador: TCheckBox
      Left = 132
      Top = 64
      Width = 132
      Height = 17
      Caption = 'Transportadores'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      OnClick = cktcadtnaClick
    end
    object cktvendedor: TCheckBox
      Left = 297
      Top = 16
      Width = 87
      Height = 17
      Caption = 'Vendedores'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      OnClick = cktcadtnaClick
    end
    object cktferiado: TCheckBox
      Left = 297
      Top = 32
      Width = 87
      Height = 17
      Caption = 'Feriados'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 11
      OnClick = cktcadtnaClick
    end
    object cktpais: TCheckBox
      Left = 297
      Top = 64
      Width = 75
      Height = 17
      Caption = 'Pa'#237'ses'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 13
      OnClick = cktcadtnaClick
    end
    object cktcidade: TCheckBox
      Left = 297
      Top = 48
      Width = 75
      Height = 17
      Caption = 'Cidades'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 12
      OnClick = cktcadtnaClick
    end
    object ckttitulo: TCheckBox
      Left = 8
      Top = 80
      Width = 97
      Height = 17
      Caption = 'T'#237'tulos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = cktcadtnaClick
    end
    object ckttipoatend: TCheckBox
      Left = 132
      Top = 80
      Width = 140
      Height = 17
      Caption = 'Tipos de Atendimento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
      OnClick = cktcadtnaClick
    end
    object cktempresa: TCheckBox
      Left = 297
      Top = 80
      Width = 140
      Height = 17
      Caption = 'Empresa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 14
      OnClick = cktcadtnaClick
    end
  end
  object gbProdutos: TGroupBox
    Left = 322
    Top = 8
    Width = 391
    Height = 57
    Caption = 'Produtos:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    Padding.Left = 7
    Padding.Top = 1
    Padding.Right = 7
    Padding.Bottom = 2
    ParentFont = False
    TabOrder = 1
    object cktproduto: TCheckBox
      Left = 8
      Top = 17
      Width = 79
      Height = 17
      Caption = 'Produtos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = cktcadtnaClick
    end
    object cktreferencia: TCheckBox
      Left = 240
      Top = 17
      Width = 77
      Height = 17
      Caption = 'Refer'#234'ncias'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = cktcadtnaClick
    end
    object ckttabpreco: TCheckBox
      Left = 112
      Top = 17
      Width = 105
      Height = 17
      Caption = 'Tabela de pre'#231'os'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = cktcadtnaClick
    end
    object cktgrupopro: TCheckBox
      Left = 8
      Top = 33
      Width = 87
      Height = 17
      Caption = 'Grupos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = cktcadtnaClick
    end
    object ckttabprecoval: TCheckBox
      Left = 112
      Top = 33
      Width = 113
      Height = 17
      Caption = 'Pre'#231'os de produtos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = cktcadtnaClick
    end
    object cktsaldotmp: TCheckBox
      Left = 240
      Top = 32
      Width = 77
      Height = 17
      Caption = 'Saldos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = cktcadtnaClick
    end
  end
  object gbClientes: TGroupBox
    Left = 8
    Top = 8
    Width = 308
    Height = 57
    Caption = 'Clientes:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    Padding.Left = 7
    Padding.Top = 1
    Padding.Right = 7
    Padding.Bottom = 2
    ParentFont = False
    TabOrder = 0
    object cktcliente: TCheckBox
      Left = 8
      Top = 16
      Width = 97
      Height = 17
      Caption = 'Clientes'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = cktcadtnaClick
    end
    object cktconvenio: TCheckBox
      Left = 8
      Top = 32
      Width = 97
      Height = 17
      Caption = 'Convenios'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = cktcadtnaClick
    end
    object cktgrupocli: TCheckBox
      Left = 120
      Top = 16
      Width = 87
      Height = 17
      Caption = 'Grupos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = cktcadtnaClick
    end
    object cktfontecli: TCheckBox
      Left = 120
      Top = 32
      Width = 87
      Height = 17
      Caption = 'Fontes'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = cktcadtnaClick
    end
    object cktsegmentocli: TCheckBox
      Left = 216
      Top = 16
      Width = 75
      Height = 17
      Caption = 'Segmentos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = cktcadtnaClick
    end
    object cktregiaocli: TCheckBox
      Left = 216
      Top = 32
      Width = 75
      Height = 17
      Caption = 'Regi'#245'es'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = cktcadtnaClick
    end
  end
  object gbPedidos: TGroupBox
    Left = 8
    Top = 71
    Width = 308
    Height = 106
    Caption = 'Pedidos:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    Padding.Left = 7
    Padding.Top = 1
    Padding.Right = 7
    Padding.Bottom = 2
    ParentFont = False
    TabOrder = 2
    object cktpedido: TCheckBox
      Left = 8
      Top = 16
      Width = 97
      Height = 17
      Caption = 'Pedidos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = cktcadtnaClick
    end
    object cktcadocorrencias: TCheckBox
      Left = 120
      Top = 16
      Width = 87
      Height = 17
      Caption = 'Ocorrencias'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = cktcadtnaClick
    end
    object cktpedidohist: TCheckBox
      Left = 8
      Top = 32
      Width = 97
      Height = 17
      Caption = 'Hist'#243'ricos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = cktcadtnaClick
    end
  end
end
