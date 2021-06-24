inherited F_MetaDados1: TF_MetaDados1
  ActiveControl = edtDado
  Caption = 'F_MetaDados1'
  ClientHeight = 173
  ClientWidth = 573
  OnCreate = FormCreate
  ExplicitWidth = 589
  ExplicitHeight = 212
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel [0]
    Left = 35
    Top = 24
    Width = 58
    Height = 13
    Caption = 'Descri'#231#227'o:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  inherited Panel1: TPanel
    Top = 138
    Width = 573
    TabOrder = 2
    ExplicitTop = 138
    ExplicitWidth = 573
    inherited Fechar: TSpeedButton
      Left = 480
      ExplicitLeft = 340
    end
    inherited Visualizar: TDBNavigator
      DataSource = T2.dsMetaDados
      Hints.Strings = ()
      OnClick = VisualizarClick
    end
    inherited btGravar: TBitBtn
      Left = 310
      OnClick = btGravarClick
      ExplicitLeft = 310
    end
    inherited btExcluir: TBitBtn
      Left = 395
      OnClick = btExcluirClick
      ExplicitLeft = 395
    end
  end
  object edtDado: TEdit
    Left = 99
    Top = 21
    Width = 445
    Height = 21
    TabStop = False
    Color = clWhite
    MaxLength = 100
    TabOrder = 0
  end
  object gbTipo: TGroupBox
    Left = 17
    Top = 48
    Width = 537
    Height = 73
    Caption = 'Tipo da Informa'#231#227'o:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object sbTipo: TSpeedButton
      Left = 200
      Top = 19
      Width = 23
      Height = 22
      Enabled = False
      Glyph.Data = {
        8E020000424D8E0200000000000036000000280000000D0000000F0000000100
        180000000000580200000000000000000000000000000000000099A8AC99A8AC
        99A8AC99A8AC99A8AC99A8AC99A8AC99A8AC99A8AC99A8AC99A8AC99A8AC99A8
        AC00D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC
        D8E9ECD8E9ECD8E9EC00D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8
        E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC00D8E9ECD8E9ECD8E9ECD8E9ECD8E9
        ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC00D8E9ECD8E9EC
        D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9
        EC00D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC000000D8E9ECD8E9ECD8E9EC
        D8E9ECD8E9ECD8E9EC00D8E9ECD8E9ECD8E9ECD8E9ECD8E9EC00000000000000
        0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9EC00D8E9ECD8E9ECD8E9ECD8E9EC0000
        00000000000000000000000000D8E9ECD8E9ECD8E9ECD8E9EC00D8E9ECD8E9EC
        D8E9EC000000000000000000000000000000000000000000D8E9ECD8E9ECD8E9
        EC00D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC
        D8E9ECD8E9ECD8E9EC00D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8
        E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC00D8E9ECD8E9ECD8E9ECD8E9ECD8E9
        ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC00D8E9ECD8E9EC
        D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9
        EC00D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC
        D8E9ECD8E9ECD8E9EC00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00}
      OnClick = sbTipoClick
    end
    object sbBanco: TSpeedButton
      Left = 200
      Top = 43
      Width = 23
      Height = 22
      Enabled = False
      Glyph.Data = {
        8E020000424D8E0200000000000036000000280000000D0000000F0000000100
        180000000000580200000000000000000000000000000000000099A8AC99A8AC
        99A8AC99A8AC99A8AC99A8AC99A8AC99A8AC99A8AC99A8AC99A8AC99A8AC99A8
        AC00D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC
        D8E9ECD8E9ECD8E9EC00D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8
        E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC00D8E9ECD8E9ECD8E9ECD8E9ECD8E9
        ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC00D8E9ECD8E9EC
        D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9
        EC00D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC000000D8E9ECD8E9ECD8E9EC
        D8E9ECD8E9ECD8E9EC00D8E9ECD8E9ECD8E9ECD8E9ECD8E9EC00000000000000
        0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9EC00D8E9ECD8E9ECD8E9ECD8E9EC0000
        00000000000000000000000000D8E9ECD8E9ECD8E9ECD8E9EC00D8E9ECD8E9EC
        D8E9EC000000000000000000000000000000000000000000D8E9ECD8E9ECD8E9
        EC00D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC
        D8E9ECD8E9ECD8E9EC00D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8
        E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC00D8E9ECD8E9ECD8E9ECD8E9ECD8E9
        ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC00D8E9ECD8E9EC
        D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9
        EC00D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC
        D8E9ECD8E9ECD8E9EC00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00}
      OnClick = sbBancoClick
    end
    object edtTipoD: TEdit
      Left = 224
      Top = 20
      Width = 303
      Height = 21
      TabStop = False
      Color = clBtnFace
      Enabled = False
      MaxLength = 40
      ReadOnly = True
      TabOrder = 2
    end
    object edtTipo: TEdit
      Left = 144
      Top = 20
      Width = 55
      Height = 21
      CharCase = ecUpperCase
      Enabled = False
      MaxLength = 40
      TabOrder = 1
      OnChange = edtTipoChange
      OnExit = edtTipoExit
      OnKeyDown = edtTipoKeyDown
    end
    object edtBancoD: TEdit
      Left = 224
      Top = 44
      Width = 303
      Height = 21
      TabStop = False
      Color = clBtnFace
      Enabled = False
      MaxLength = 40
      ReadOnly = True
      TabOrder = 5
    end
    object edtBanco: TEdit
      Left = 144
      Top = 44
      Width = 55
      Height = 21
      CharCase = ecUpperCase
      Enabled = False
      MaxLength = 40
      TabOrder = 4
      OnChange = edtBancoChange
      OnExit = edtBancoExit
      OnKeyDown = edtBancoKeyDown
    end
    object ckTipoPag: TCheckBox
      Left = 10
      Top = 22
      Width = 133
      Height = 17
      Caption = 'Tipo de Pagamento:'
      TabOrder = 0
      OnClick = ckTipoPagClick
    end
    object ckBanco: TCheckBox
      Left = 10
      Top = 46
      Width = 133
      Height = 17
      Caption = 'Banco:'
      TabOrder = 3
      OnClick = ckTipoPagClick
    end
  end
end
