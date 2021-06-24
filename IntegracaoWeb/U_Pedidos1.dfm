object F_Pedidos1: TF_Pedidos1
  Left = 114
  Top = 129
  Caption = #39#39#39#39
  ClientHeight = 664
  ClientWidth = 984
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 629
    Width = 984
    Height = 35
    Align = alBottom
    Padding.Left = 7
    Padding.Top = 1
    Padding.Right = 7
    Padding.Bottom = 2
    TabOrder = 2
    object fechar: TSpeedButton
      Left = 891
      Top = 2
      Width = 85
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
      ExplicitLeft = 820
      ExplicitHeight = 28
    end
    object lblAviso: TLabel
      Left = 398
      Top = 1
      Width = 73
      Height = 33
      Caption = 'Aviso'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -27
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object Visualizar: TDBNavigator
      Left = 8
      Top = 2
      Width = 156
      Height = 30
      DataSource = T2.dsgWtpedido
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
      Align = alLeft
      TabOrder = 0
      OnClick = VisualizarClick
    end
    object Imprimir: TBitBtn
      Left = 164
      Top = 2
      Width = 85
      Height = 30
      Align = alLeft
      Caption = '&Imprimir'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000010000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        0003377777777777777308888888888888807F33333333333337088888888888
        88807FFFFFFFFFFFFFF7000000000000000077777777777777770F8F8F8F8F8F
        8F807F333333333333F708F8F8F8F8F8F9F07F333333333337370F8F8F8F8F8F
        8F807FFFFFFFFFFFFFF7000000000000000077777777777777773330FFFFFFFF
        03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
        03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
        33333337F3F37F3733333330F08F0F0333333337F7337F7333333330FFFF0033
        33333337FFFF7733333333300000033333333337777773333333}
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
      Visible = False
    end
    object btGravar: TBitBtn
      Left = 721
      Top = 2
      Width = 85
      Height = 30
      Align = alRight
      Caption = '&Gravar'
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
      TabOrder = 2
      OnClick = btGravarClick
    end
    object btExcluir: TBitBtn
      Left = 806
      Top = 2
      Width = 85
      Height = 30
      Align = alRight
      Caption = '&Excluir'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00500005000555
        555557777F777555F55500000000555055557777777755F75555005500055055
        555577F5777F57555555005550055555555577FF577F5FF55555500550050055
        5555577FF77577FF555555005050110555555577F757777FF555555505099910
        555555FF75777777FF555005550999910555577F5F77777775F5500505509990
        3055577F75F77777575F55005055090B030555775755777575755555555550B0
        B03055555F555757575755550555550B0B335555755555757555555555555550
        BBB35555F55555575F555550555555550BBB55575555555575F5555555555555
        50BB555555555555575F555555555555550B5555555555555575}
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 3
      Visible = False
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 984
    Height = 194
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 91
      Top = 8
      Width = 47
      Height = 13
      Caption = 'N'#250'mero:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 429
      Top = 8
      Width = 30
      Height = 13
      Caption = 'Data:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 482
      Top = 78
      Width = 99
      Height = 13
      Caption = 'Cond.Pagamento:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 46
      Top = 100
      Width = 92
      Height = 13
      Caption = 'Transportadora:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 81
      Top = 123
      Width = 57
      Height = 13
      Caption = 'Vendedor:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 788
      Top = 100
      Width = 65
      Height = 13
      Caption = 'Valor Frete:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label19: TLabel
      Left = 83
      Top = 54
      Width = 55
      Height = 13
      Caption = 'Endere'#231'o:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label18: TLabel
      Left = 46
      Top = 146
      Width = 92
      Height = 13
      Caption = 'Observa'#231#245'es NF:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LbContato: TLabel
      Left = 90
      Top = 77
      Width = 48
      Height = 13
      Caption = 'Contato:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label83: TLabel
      Left = 746
      Top = 54
      Width = 30
      Height = 13
      Caption = 'Fone:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label40: TLabel
      Left = 606
      Top = 100
      Width = 33
      Height = 13
      Alignment = taCenter
      Caption = 'Frete:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnDadosCli: TSpeedButton
      Left = 67
      Top = 26
      Width = 74
      Height = 23
      Hint = 'Incluir ou alterar cliente'
      Caption = 'Cliente:'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Glyph.Data = {
        E6040000424DE604000000000000360000002800000014000000140000000100
        180000000000B004000000000000000000000000000000000000FFFFFFFFFFFF
        FCFCFCF8F8F6EDEDE7E1E2DBCCCCCDB9B9C6AEAFC2A3A3BFA4A5BFAFAEC3AAB5
        BD5BB46C38B34A34B44785CC91FBFCFAFFFFFFFFFFFFFFFFFFF1F1F1D1D1CEB0
        B1BB696AAC3D3CAB2B2BAA2320B01916B5130EB9120EAD170E9A21249D229455
        11C81C02C11455AE65D9DADBFDFAFCFFFFFFFEFEFDDFDFDEA1A1A93631AB1903
        D62509E22A0CE62A0DE52C0EE62C0FE62D13D74223DA3727CE1F8F5B14CE1F0D
        C71B196E5C8F92A8E4E4E3FCFEFCFDFDFDF6F6F4C1C2D33E32C34514FD4316F6
        4316F64317F64414F73929D6265F84247D621E7B6012B22C12D31712D01B0E8B
        433491595FBE6D6AC479FFFFFFFFFFFFDDDDF24C3FD04F1EFF4A1CFF4C1DFF4B
        1DFF3D18EC2F36B529B6401AFE0013F60012EE0012E10A14D71611D1190ACA17
        04C41419B12DFFFFFFFFFFFFE7E7F55048CD5939FF4C2DFF4827FF4124F32112
        CE182CAA34B45033FF0C27FC091AF50313EB0212E10A14D71818CF2318CC2521
        B535FFFFFFFFFFFFFAFAFC7B7AD5574EE95C50FA4F42FC342AE01509C72429C2
        559C9060CD6F53C36B39E4331BF50210EC0026C6346DD8777CDE8661C771FFFF
        FFFFFFFFFFFFFFDEDFF47F7FD86F6DE35352E22C21D0220FD03E44CC6E92D96A
        92D64C5AC642B55F25FB060EEF004FB36BE8EFEEF7FBF8E8F5EBFFFFFFFFFFFF
        FFFFFFFFFFFFF7F7FBBDBDE67E7DD4372AC6403BD27A9EDB93CAEE82C0EA5176
        C538AF572CFA0A14F20076D27DFEFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFE6E5F19D9DDA8097DA9AC8E699CAEA99CBED87B8DA75CB8E
        71ED6360EB538FD895FAFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFEFEFDEFF1F0BCD1DB96C1DD9DCFEF9ED4F4A1D6F7A4D9F5ADD5DBD2E8DBD9
        F0DBD8EFDCFDFEFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFC
        D0DBE1689DB77BB4D7A2D7F8A0D7F795CCEE9BD0F2ACD0ECE7ECF4FFFEFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEF8F6F5B1C7D259
        98B88FC4E6A6DAFAA7DAF993C8EB98CCEFABCFEAE4EBF1FFFFFEFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEE8EBED86AFC2438EB280BB
        DDA8DBF9ADDFFC9ED2F19FD2F3ADD0EAE5EBF1FEFFFEFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFCFCD3DEE35A96B23588AE74B4D5ABDDF9
        AEDEFAAADBF6A8D9F7AED1E9E6ECF2FFFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFDFCC3D5DD3C86A8408EB381BBD9ABD8F3A9D4EEAA
        D5EDA9D4EFB2CFE6EAEEF3FFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFEC8DAE23E88AB4390B375AFCD8BBDD977B1CD64A3C35599
        BB699DBAD5E1E7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFDAE7ED5899B83488AE4290B34492B64498BC489DC14195BA287DA4
        8EB7C9F6F9FAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFF8FBFCABCBDA418DB12D83A93488AD3F93B9459CC13D94BB287FA886B2C7F3
        F7F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFEDCE9F0A3C7D775AAC25A9AB560A0BC8AB9D0C0D9E5F2F6F8FFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF}
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = btnDadosCliClick
    end
    object Tipo: TLabel
      Left = 746
      Top = 31
      Width = 85
      Height = 13
      Caption = 'F'#237'sica / jur'#237'dica'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label31: TLabel
      Left = 587
      Top = 123
      Width = 52
      Height = 13
      Alignment = taCenter
      Caption = 'Situa'#231#227'o:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label32: TLabel
      Left = 746
      Top = 8
      Width = 45
      Height = 13
      Caption = 'Ped/OC:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label35: TLabel
      Left = 10
      Top = 170
      Width = 128
      Height = 13
      Caption = 'Observa'#231#245'es Internas:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtId: TEdit
      Left = 144
      Top = 5
      Width = 80
      Height = 21
      TabStop = False
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 7
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object Data: TMaskEdit
      Left = 465
      Top = 5
      Width = 73
      Height = 21
      TabStop = False
      EditMask = '99/99/9999;1;'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
      OnExit = DataExit
      OnKeyDown = DataKeyDown
    end
    object Ped_CODCLI: TEdit
      Left = 144
      Top = 28
      Width = 80
      Height = 21
      MaxLength = 6
      TabOrder = 3
      OnChange = Ped_CODCLIChange
      OnExit = Ped_CODCLIExit
      OnKeyDown = Ped_CODCLIKeyDown
    end
    object NomeCli: TEdit
      Left = 226
      Top = 28
      Width = 496
      Height = 21
      TabStop = False
      Color = clInfoBk
      ReadOnly = True
      TabOrder = 4
    end
    object CODPAG: TEdit
      Left = 587
      Top = 74
      Width = 37
      Height = 21
      MaxLength = 3
      TabOrder = 10
      OnChange = CODPAGChange
      OnExit = CODPAGExit
      OnKeyDown = CODPAGKeyDown
    end
    object CODPAGD: TEdit
      Left = 626
      Top = 74
      Width = 312
      Height = 21
      TabStop = False
      Color = clInfoBk
      ReadOnly = True
      TabOrder = 11
    end
    object CODTRS: TEdit
      Left = 144
      Top = 97
      Width = 80
      Height = 21
      MaxLength = 5
      TabOrder = 12
      OnChange = CODTRSChange
      OnExit = CODTRSExit
      OnKeyDown = CODTRSKeyDown
    end
    object CODTRSD: TEdit
      Left = 226
      Top = 97
      Width = 340
      Height = 21
      TabStop = False
      Color = clInfoBk
      ReadOnly = True
      TabOrder = 13
    end
    object CODVEN: TEdit
      Left = 144
      Top = 120
      Width = 80
      Height = 21
      MaxLength = 5
      TabOrder = 16
      OnChange = CODVENChange
      OnExit = CODVENExit
      OnKeyDown = CODVENKeyDown
    end
    object CODVEND: TEdit
      Left = 226
      Top = 120
      Width = 340
      Height = 21
      TabStop = False
      Color = clInfoBk
      ReadOnly = True
      TabOrder = 17
    end
    object VlrFrete: TEdit
      Left = 858
      Top = 97
      Width = 80
      Height = 21
      Alignment = taRightJustify
      TabOrder = 15
      Text = '0,00'
      OnEnter = VlrFreteEnter
      OnExit = VlrFreteExit
      OnKeyPress = VlrFreteKeyPress
    end
    object Cidade: TEdit
      Left = 466
      Top = 51
      Width = 221
      Height = 21
      TabStop = False
      Color = clInfoBk
      ReadOnly = True
      TabOrder = 6
    end
    object uf: TEdit
      Left = 693
      Top = 51
      Width = 29
      Height = 21
      TabStop = False
      Color = clInfoBk
      ReadOnly = True
      TabOrder = 7
    end
    object Obs: TMemo
      Left = 144
      Top = 143
      Width = 794
      Height = 21
      MaxLength = 400
      TabOrder = 19
      OnEnter = ObsEnter
      OnExit = ObsExit
    end
    object Contato: TComboBox
      Left = 144
      Top = 74
      Width = 316
      Height = 21
      AutoDropDown = True
      CharCase = ecUpperCase
      Ctl3D = False
      DropDownCount = 20
      ParentCtl3D = False
      TabOrder = 9
    end
    object Fone: TEdit
      Left = 782
      Top = 51
      Width = 156
      Height = 21
      TabStop = False
      Color = clInfoBk
      Ctl3D = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 8
    end
    object Ender: TEdit
      Left = 144
      Top = 51
      Width = 316
      Height = 21
      TabStop = False
      Color = clInfoBk
      ReadOnly = True
      TabOrder = 5
    end
    object Frete: TComboBox
      Left = 645
      Top = 97
      Width = 96
      Height = 21
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemIndex = 0
      ParentFont = False
      TabOrder = 14
      Text = 'Emitente'
      Items.Strings = (
        'Emitente'
        'Destinat'#225'rio'
        'Terceiros'
        'Sem Frete')
    end
    object edtSituacao: TEdit
      Left = 645
      Top = 120
      Width = 293
      Height = 21
      TabStop = False
      Color = clInfoBk
      ReadOnly = True
      TabOrder = 18
    end
    object edtOrdemCompra: TEdit
      Left = 797
      Top = 5
      Width = 141
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 30
      TabOrder = 2
    end
    object ObsInt: TMemo
      Left = 144
      Top = 166
      Width = 794
      Height = 21
      MaxLength = 400
      TabOrder = 20
      OnEnter = ObsEnter
      OnExit = ObsExit
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 194
    Width = 984
    Height = 158
    Align = alTop
    TabOrder = 1
    object Label8: TLabel
      Left = 55
      Top = 9
      Width = 48
      Height = 13
      Caption = 'Produto:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label10: TLabel
      Left = 62
      Top = 59
      Width = 41
      Height = 13
      Caption = 'Tabela:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label11: TLabel
      Left = 569
      Top = 59
      Width = 80
      Height = 13
      Caption = 'Valor Unit'#225'rio:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label12: TLabel
      Left = 291
      Top = 59
      Width = 68
      Height = 13
      Caption = 'Quantidade:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label13: TLabel
      Left = 585
      Top = 84
      Width = 64
      Height = 13
      Caption = 'Valor Total:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label85: TLabel
      Left = 46
      Top = 34
      Width = 57
      Height = 13
      Caption = 'Opera'#231#227'o:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label14: TLabel
      Left = 366
      Top = 34
      Width = 31
      Height = 13
      Caption = 'CFOP:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label20: TLabel
      Left = 271
      Top = 84
      Width = 88
      Height = 13
      Caption = 'Valor Desconto:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label23: TLabel
      Left = 31
      Top = 83
      Width = 72
      Height = 13
      Caption = '% Desconto:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label33: TLabel
      Left = 33
      Top = 107
      Width = 70
      Height = 13
      Caption = 'Observa'#231#227'o:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object CODPRO: TEdit
      Left = 109
      Top = 6
      Width = 80
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 10
      TabOrder = 0
      OnExit = CODPROExit
      OnKeyDown = CODPROKeyDown
    end
    object CODPROD: TEdit
      Left = 191
      Top = 6
      Width = 508
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 1
    end
    object CODTAB: TEdit
      Left = 109
      Top = 56
      Width = 35
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 3
      TabOrder = 8
      OnEnter = CODTABEnter
      OnExit = CODTABExit
      OnKeyDown = CODTABKeyDown
    end
    object VlrUnt: TEdit
      Left = 655
      Top = 56
      Width = 83
      Height = 21
      MaxLength = 15
      TabOrder = 10
      Text = '                 0,00'
      OnEnter = VlrUntEnter
      OnExit = VlrUntExit
      OnKeyDown = VlrUntKeyDown
      OnKeyPress = VlrUntKeyPress
    end
    object Qtde: TEdit
      Left = 365
      Top = 56
      Width = 80
      Height = 21
      MaxLength = 15
      TabOrder = 9
      Text = '                 0,00'
      OnEnter = QtdeEnter
      OnExit = QtdeExit
      OnKeyPress = QtdeKeyPress
    end
    object VlrTot: TEdit
      Left = 655
      Top = 81
      Width = 83
      Height = 21
      TabStop = False
      Color = clInfoBk
      ReadOnly = True
      TabOrder = 13
      Text = '                  0,00'
    end
    object Panel5: TPanel
      Left = 1
      Top = 130
      Width = 982
      Height = 27
      Align = alBottom
      TabOrder = 15
      object btExcItem: TSpeedButton
        Left = 889
        Top = 1
        Width = 92
        Height = 25
        Align = alRight
        Caption = 'Excluir Item'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
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
        OnClick = btExcItemClick
        ExplicitLeft = 807
      end
      object btConfItem: TBitBtn
        Left = 752
        Top = 1
        Width = 137
        Height = 25
        Align = alRight
        Caption = 'Incluir Item'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
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
        OnClick = btConfItemClick
      end
    end
    object UNDPRO: TEdit
      Left = 705
      Top = 6
      Width = 33
      Height = 21
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 2
    end
    object CodTna: TEdit
      Left = 109
      Top = 31
      Width = 42
      Height = 21
      HelpContext = 1270
      Ctl3D = True
      MaxLength = 4
      ParentCtl3D = False
      TabOrder = 3
      OnChange = CodTnaChange
      OnExit = CodTnaExit
      OnKeyDown = CodTnaKeyDown
    end
    object CodTnaD: TEdit
      Left = 153
      Top = 31
      Width = 205
      Height = 21
      TabStop = False
      Color = clInfoBk
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 4
    end
    object NatOprD: TEdit
      Left = 474
      Top = 31
      Width = 264
      Height = 21
      TabStop = False
      Color = clInfoBk
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 7
    end
    object NATOPR: TEdit
      Left = 403
      Top = 31
      Width = 42
      Height = 21
      HelpContext = 1270
      Ctl3D = True
      MaxLength = 4
      ParentCtl3D = False
      TabOrder = 5
      OnExit = NATOPRExit
      OnKeyDown = NATOPRKeyDown
    end
    object CODOPR: TEdit
      Left = 447
      Top = 31
      Width = 25
      Height = 21
      Ctl3D = True
      MaxLength = 2
      ParentCtl3D = False
      TabOrder = 6
      OnChange = CODOPRChange
      OnExit = CODOPRExit
      OnKeyDown = NATOPRKeyDown
    end
    object ProNcm: TEdit
      Left = 508
      Top = 57
      Width = 17
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 10
      TabOrder = 16
      Visible = False
    end
    object SitICM: TEdit
      Left = 531
      Top = 57
      Width = 20
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 10
      TabOrder = 17
      Visible = False
    end
    object SitIpi: TEdit
      Left = 517
      Top = 68
      Width = 20
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 10
      TabOrder = 18
      Visible = False
    end
    object VlrDesc: TEdit
      Left = 365
      Top = 81
      Width = 80
      Height = 21
      MaxLength = 15
      TabOrder = 12
      Text = '                 0,00'
      OnEnter = VlrUntEnter
      OnExit = VlrDescExit
      OnKeyDown = VlrUntKeyDown
      OnKeyPress = VlrUntKeyPress
    end
    object PercDesc: TEdit
      Left = 109
      Top = 80
      Width = 83
      Height = 21
      MaxLength = 15
      TabOrder = 11
      Text = '                 0,00'
      OnEnter = VlrUntEnter
      OnExit = PercDescExit
      OnKeyPress = VlrUntKeyPress
    end
    object GroupBox3: TGroupBox
      Left = 744
      Top = 0
      Width = 84
      Height = 103
      Caption = 'C'#243'digos CST'
      Color = clBtnFace
      ParentBackground = False
      ParentColor = False
      TabOrder = 19
      object Label64: TLabel
        Left = 19
        Top = 16
        Width = 29
        Height = 13
        Caption = 'ICMS:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label76: TLabel
        Left = 28
        Top = 58
        Width = 20
        Height = 13
        Caption = 'PIS:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label77: TLabel
        Left = 6
        Top = 37
        Width = 42
        Height = 13
        Caption = 'COFINS:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label78: TLabel
        Left = 30
        Top = 79
        Width = 18
        Height = 13
        Caption = 'IPI:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object CODCST: TEdit
        Left = 54
        Top = 13
        Width = 26
        Height = 21
        HelpContext = 1360
        TabStop = False
        Color = clInfoBk
        Ctl3D = True
        MaxLength = 3
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 0
      end
      object edCstPis: TEdit
        Left = 54
        Top = 55
        Width = 26
        Height = 21
        HelpContext = 1360
        TabStop = False
        Color = clInfoBk
        Ctl3D = True
        MaxLength = 2
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 1
      end
      object edCstCof: TEdit
        Left = 54
        Top = 34
        Width = 26
        Height = 21
        HelpContext = 1360
        TabStop = False
        Color = clInfoBk
        Ctl3D = True
        MaxLength = 2
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 2
      end
      object EdCstIPI: TEdit
        Left = 54
        Top = 76
        Width = 26
        Height = 21
        HelpContext = 1360
        TabStop = False
        Color = clInfoBk
        Ctl3D = True
        MaxLength = 2
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 3
      end
      object edCSOSN: TEdit
        Left = 84
        Top = 38
        Width = 11
        Height = 19
        HelpContext = 1360
        TabStop = False
        Color = clCream
        Ctl3D = False
        MaxLength = 3
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 4
        Visible = False
      end
    end
    object GroupBox6: TGroupBox
      Left = 829
      Top = 0
      Width = 94
      Height = 103
      Caption = 'Percentuais'
      Color = clBtnFace
      ParentBackground = False
      ParentColor = False
      TabOrder = 20
      object Label79: TLabel
        Left = 5
        Top = 16
        Width = 32
        Height = 13
        Caption = ' ICMS:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label80: TLabel
        Left = 19
        Top = 79
        Width = 18
        Height = 13
        Caption = 'IPI:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label86: TLabel
        Left = 10
        Top = 37
        Width = 27
        Height = 13
        Caption = 'Red.:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label22: TLabel
        Left = 12
        Top = 58
        Width = 25
        Height = 13
        Caption = 'MVA:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object prIcm: TEdit
        Left = 43
        Top = 13
        Width = 46
        Height = 21
        HelpContext = 1360
        TabStop = False
        Color = clInfoBk
        Ctl3D = True
        MaxLength = 2
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 0
      end
      object prIPI: TEdit
        Left = 43
        Top = 76
        Width = 46
        Height = 21
        HelpContext = 1360
        TabStop = False
        Color = clInfoBk
        Ctl3D = True
        MaxLength = 2
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 1
      end
      object prRedICM: TEdit
        Left = 43
        Top = 34
        Width = 46
        Height = 21
        HelpContext = 1360
        TabStop = False
        Color = clInfoBk
        Ctl3D = True
        MaxLength = 2
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 2
      end
      object prMVA: TEdit
        Left = 43
        Top = 55
        Width = 46
        Height = 21
        HelpContext = 1360
        TabStop = False
        Color = clInfoBk
        Ctl3D = True
        MaxLength = 2
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 3
      end
    end
    object edtIdItem: TEdit
      Left = 505
      Top = 80
      Width = 20
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 10
      TabOrder = 21
      Visible = False
    end
    object edtPrIcmsSt: TEdit
      Left = 531
      Top = 77
      Width = 20
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 10
      TabOrder = 22
      Visible = False
    end
    object edtObservacao: TEdit
      Left = 109
      Top = 104
      Width = 809
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 300
      TabOrder = 14
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 352
    Width = 984
    Height = 177
    Align = alClient
    DataSource = dsItens
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDrawColumnCell = DBGrid1DrawColumnCell
    OnDblClick = DBGrid1DblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'NRITEM'
        ImeName = 'Item'
        Title.Caption = 'Item'
        Width = 30
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODPRO'
        Title.Caption = 'Produto'
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BARRAS'
        Title.Caption = 'C'#243'd. Barra'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'DESCRI'
        Title.Caption = 'Descri'#231#227'o'
        Width = 362
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TAB'
        Title.Caption = 'Tab'
        Width = 25
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'QTDE'
        Title.Caption = 'Qtde.'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VLRUNT'
        Title.Caption = 'Unit'#225'rio'
        Width = 50
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'PERDES'
        Title.Caption = '% Desc.'
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'VLRDES'
        Title.Caption = 'Desconto'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VLRTOT'
        Title.Caption = 'Valor Total'
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NATOPR'
        Title.Caption = 'Natureza'
        Width = 51
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODOPR'
        Title.Caption = 'Op.'
        Width = 31
        Visible = True
      end>
  end
  object Panel4: TPanel
    Left = 0
    Top = 529
    Width = 984
    Height = 100
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 4
    object lbItens: TLabel
      Left = 605
      Top = 74
      Width = 60
      Height = 19
      Caption = '0 - Itens'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label16: TLabel
      Left = 827
      Top = 74
      Width = 42
      Height = 19
      Caption = 'Total:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label46: TLabel
      Left = 171
      Top = 56
      Width = 82
      Height = 13
      Caption = 'Base ICMS S.T:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label45: TLabel
      Left = 171
      Top = 79
      Width = 84
      Height = 13
      Caption = 'Valor ICMS S.T:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label36: TLabel
      Left = 346
      Top = 56
      Width = 50
      Height = 13
      Caption = 'Base IPI:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label26: TLabel
      Left = 346
      Top = 79
      Width = 52
      Height = 13
      Caption = 'Valor IPI:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label27: TLabel
      Left = 15
      Top = 56
      Width = 62
      Height = 13
      Caption = 'Base ICMS:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label28: TLabel
      Left = 15
      Top = 79
      Width = 64
      Height = 13
      Caption = 'Valor ICMS:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label25: TLabel
      Left = 489
      Top = 79
      Width = 22
      Height = 13
      Caption = 'IRF:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label34: TLabel
      Left = 781
      Top = 50
      Width = 88
      Height = 13
      Caption = 'Valor Desconto:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object TotalOrc: TEdit
      Left = 872
      Top = 71
      Width = 101
      Height = 27
      TabStop = False
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
      Text = '0,00'
      OnEnter = TotalOrcEnter
      OnKeyPress = TotalOrcKeyPress
    end
    object gbRetencoes: TGroupBox
      Left = 6
      Top = 6
      Width = 466
      Height = 41
      Caption = 'Reten'#231#245'es:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Label6: TLabel
        Left = 9
        Top = 18
        Width = 22
        Height = 13
        Caption = 'PIS:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label9: TLabel
        Left = 120
        Top = 17
        Width = 43
        Height = 13
        Caption = 'COFINS:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label15: TLabel
        Left = 363
        Top = 18
        Width = 23
        Height = 13
        Caption = 'CSL:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label17: TLabel
        Left = 253
        Top = 17
        Width = 22
        Height = 13
        Caption = 'ISS:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object gbSuframa: TGroupBox
      Left = 500
      Top = 6
      Width = 473
      Height = 41
      Caption = 'SUFRAMA:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object Label21: TLabel
        Left = 369
        Top = 18
        Width = 22
        Height = 13
        Caption = 'PIS:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label24: TLabel
        Left = 239
        Top = 17
        Width = 43
        Height = 13
        Caption = 'COFINS:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label29: TLabel
        Left = 10
        Top = 18
        Width = 32
        Height = 13
        Caption = 'ICMS:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label30: TLabel
        Left = 130
        Top = 18
        Width = 20
        Height = 13
        Caption = 'IPI:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object edtVlrDes: TEdit
      Left = 872
      Top = 47
      Width = 101
      Height = 21
      Alignment = taRightJustify
      TabOrder = 3
      Text = '0,00'
      OnEnter = VlrFreteEnter
      OnExit = VlrFreteExit
      OnKeyPress = VlrFreteKeyPress
    end
  end
  object cdsItens: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspItens'
    Left = 80
    Top = 384
  end
  object dsItens: TDataSource
    DataSet = cdsItens
    Left = 48
    Top = 384
  end
  object cdsServicos: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 19
    Top = 384
  end
end
