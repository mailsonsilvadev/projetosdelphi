object F_Pedidos2Gerar: TF_Pedidos2Gerar
  Left = 219
  Top = 192
  Caption = 'F_Pedidos2Gerar'
  ClientHeight = 499
  ClientWidth = 961
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 961
    Height = 97
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 47
      Top = 14
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
      Left = 228
      Top = 14
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
    object Label6: TLabel
      Left = 52
      Top = 39
      Width = 42
      Height = 13
      Caption = 'Cliente:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 33
      Top = 64
      Width = 61
      Height = 13
      Caption = 'Cond. Pag.:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object OrcNro: TEdit
      Left = 100
      Top = 11
      Width = 78
      Height = 21
      TabStop = False
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      MaxLength = 7
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object Data: TMaskEdit
      Left = 264
      Top = 11
      Width = 73
      Height = 21
      TabStop = False
      Color = clBtnFace
      EditMask = '99/99/9999;1;'
      MaxLength = 10
      ReadOnly = True
      TabOrder = 1
      Text = '  /  /    '
    end
    object CODCLID: TEdit
      Left = 182
      Top = 36
      Width = 552
      Height = 21
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 2
    end
    object CODCLI: TEdit
      Left = 100
      Top = 36
      Width = 80
      Height = 21
      TabStop = False
      Color = clBtnFace
      MaxLength = 6
      ReadOnly = True
      TabOrder = 3
      OnChange = CODCLIChange
    end
    object CODPAG: TEdit
      Left = 100
      Top = 61
      Width = 34
      Height = 21
      MaxLength = 3
      TabOrder = 4
      OnChange = CODPAGChange
      OnExit = CODPAGExit
      OnKeyDown = CODPAGKeyDown
    end
    object CODPAGD: TEdit
      Left = 136
      Top = 61
      Width = 598
      Height = 21
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 5
    end
  end
  object GridItens: TDBGrid
    Left = 0
    Top = 97
    Width = 961
    Height = 329
    Align = alClient
    DataSource = dsItens
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgCancelOnExit]
    ParentFont = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDrawColumnCell = GridItensDrawColumnCell
    Columns = <
      item
        Color = clWindow
        Expanded = False
        FieldName = 'ITEM'
        ImeName = 'Item'
        Title.Caption = 'Item'
        Width = 30
        Visible = True
      end
      item
        Color = clWindow
        Expanded = False
        FieldName = 'CODPRO'
        Title.Caption = 'Produto'
        Width = 55
        Visible = True
      end
      item
        Color = clWindow
        Expanded = False
        FieldName = 'DESCRI'
        Title.Caption = 'Descri'#231#227'o'
        Width = 303
        Visible = True
      end
      item
        Color = clWindow
        Expanded = False
        FieldName = 'CODALX'
        Title.Caption = 'Alx'
        Width = 25
        Visible = True
      end
      item
        Color = clWindow
        Expanded = False
        FieldName = 'CODTAB'
        Title.Caption = 'Tab'
        Width = 25
        Visible = True
      end
      item
        Color = clWindow
        Expanded = False
        FieldName = 'VLRUNI'
        Title.Caption = 'Unit'#225'rio'
        Width = 50
        Visible = True
      end
      item
        Color = clWindow
        Expanded = False
        FieldName = 'PERDES'
        Title.Caption = '% Desc.'
        Visible = True
      end
      item
        Color = clWindow
        Expanded = False
        FieldName = 'VLRDES'
        Title.Caption = 'Desconto'
        Visible = True
      end
      item
        Color = clWindow
        Expanded = False
        FieldName = 'QTDE'
        Title.Caption = 'Qtde.Orc.'
        Width = 55
        Visible = True
      end
      item
        Color = clWindow
        Expanded = False
        FieldName = 'VLRTOT'
        Title.Caption = 'Valor Total'
        Width = 65
        Visible = True
      end
      item
        Color = clWindow
        Expanded = False
        FieldName = 'VlrSub'
        Title.Caption = 'Valor ST'
        Visible = True
      end
      item
        Color = clWindow
        Expanded = False
        FieldName = 'VlrIpi'
        Title.Caption = 'Valor IPI'
        Visible = True
      end
      item
        Color = clWindow
        Expanded = False
        FieldName = 'NATOPR'
        Title.Caption = 'Natureza'
        Width = 51
        Visible = True
      end
      item
        Color = clWindow
        Expanded = False
        FieldName = 'CODOPR'
        Title.Caption = 'Op.'
        Width = 29
        Visible = True
      end>
  end
  object Panel4: TPanel
    Left = 0
    Top = 426
    Width = 961
    Height = 38
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object Label16: TLabel
      Left = 728
      Top = 8
      Width = 118
      Height = 19
      Caption = 'Total do Pedido:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 7
      Top = 9
      Width = 94
      Height = 19
      Caption = 'Quantidades:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbQuant: TLabel
      Left = 107
      Top = 9
      Width = 27
      Height = 19
      Caption = '000'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 528
      Top = 8
      Width = 71
      Height = 19
      Caption = 'Desconto:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 367
      Top = 8
      Width = 41
      Height = 19
      Caption = 'Frete:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object TotalPed: TEdit
      Left = 852
      Top = 8
      Width = 101
      Height = 24
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
      Text = '0,00'
    end
    object edtDesconto: TEdit
      Left = 604
      Top = 8
      Width = 101
      Height = 24
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      Text = '0,00'
    end
    object edtFrete: TEdit
      Left = 412
      Top = 8
      Width = 101
      Height = 24
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      Text = '0,00'
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 464
    Width = 961
    Height = 35
    Align = alBottom
    Padding.Left = 7
    Padding.Top = 1
    Padding.Right = 7
    Padding.Bottom = 2
    TabOrder = 3
    object Fechar: TSpeedButton
      Left = 868
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
      OnClick = FecharClick
      ExplicitLeft = 653
      ExplicitTop = -1
      ExplicitHeight = 25
    end
    object Confirmar: TBitBtn
      Left = 778
      Top = 2
      Width = 90
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
  end
  object dsItens: TDataSource
    DataSet = cdsItens
    Left = 256
    Top = 344
  end
  object cdsItens: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspItens'
    Left = 288
    Top = 344
  end
end
