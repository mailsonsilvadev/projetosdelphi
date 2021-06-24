object F_Sistema: TF_Sistema
  Left = 213
  Top = 240
  BorderStyle = bsDialog
  Caption = 'Sistema'
  ClientHeight = 263
  ClientWidth = 309
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Visible = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 309
    Height = 228
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    ParentColor = True
    TabOrder = 0
    object Bevel1: TBevel
      Left = 0
      Top = 102
      Width = 313
      Height = 122
    end
    object ProgramIcon: TImage
      Left = 10
      Top = 7
      Width = 32
      Height = 32
      AutoSize = True
      Picture.Data = {
        055449636F6E0000010001002020100000000000E80200001600000028000000
        2000000040000000010004000000000080020000000000000000000000000000
        0000000000000000000080000080000000808000800000008000800080800000
        C0C0C000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000
        FFFFFF00000000000000CCCCCCCC000000000000000000000CCCCCCCCCCCCCC0
        000000000000000CCCCCCCCCCCCCCCCCC0000000000000CCCCCCCCCCCCCCCCCC
        CC00000000000CCCCCCCCCCCCCCCCCCCCCC000000000CCCCCCCCCCCCCCCCCCCC
        CCCC0000000CCC000000000000000CCCCCCCC00000CCCCC999999999999900CC
        CCCCCC0000CCCCCCC99999CCC09999CCCCCCCC000CCCCCCCC09999CCCC09999C
        CCCCCCC00CCCCCCCC090000000000000000CCCC00CCCCCCCC099AAAAAAAAAAAA
        AAAACCC0CCCCCCCCC09999AAAAAA09999AAACCCCCCCCCCCCC099990AAAAC0999
        99AACCCCCCCCCCCCC099990AAAAC099999CAACCCCCCCCCCCC099990AAAAC0999
        99CAACCCCCCCCCCCC099990AAAAC099999CCACCCCCCCCCCCC099990AAAAC0999
        99CCCCCCCCCCCCCCC099990AAAAC099999CCCCCCCCCCCCCCC099990AAAAC0999
        9CCCCCCC0CCCCCCCC099990AAAA099999CCCCCC00CCCCCCC0099990AAAA09999
        CCCCCCC00CCCCC000099990AAAA9999CCCCCCCC000CCCCCCC999990AAAA999CC
        CCCCCC0000CCCCC99999999999999CCCCCCCCC00000CCCCCCCCCC00AAAACCCCC
        CCCCC0000000CCCCCCC0000AAAACCCCCCCCC000000000CCCCCCCCCAAAAAACCCC
        CCC00000000000CCCCCCAAAAAAAAAACCCC0000000000000CCCCCCCCCCCCCCCCC
        C0000000000000000CCCCCCCCCCCCCC000000000000000000000CCCCCCCC0000
        00000000FFF00FFFFF8001FFFE00007FFC00003FF800001FF000000FE0000007
        C0000003C0000003800000018000000180000001000000000000000000000000
        0000000000000000000000000000000000000000800000018000000180000001
        C0000003C0000003E0000007F000000FF800001FFC00003FFE00007FFF8001FF
        FFF00FFF}
      Stretch = True
      IsControl = True
    end
    object ProductName: TLabel
      Left = 58
      Top = 5
      Width = 213
      Height = 13
      Caption = 'M'#243'dulo SepeWeb do sistema WSEPE'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      IsControl = True
    end
    object Version: TLabel
      Left = 58
      Top = 29
      Width = 66
      Height = 13
      Caption = 'Vers'#227'o: 5.0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      IsControl = True
    end
    object Copyright: TLabel
      Left = 12
      Top = 52
      Width = 270
      Height = 13
      Caption = 'Todos os direitos reservados para a DataLan Inform'#225'tica.'
      IsControl = True
    end
    object Label1: TLabel
      Left = 108
      Top = 104
      Width = 92
      Height = 13
      Caption = 'Dados da empresa:'
      IsControl = True
    end
    object Label5: TLabel
      Left = 86
      Top = 171
      Width = 137
      Height = 13
      Caption = 'Fone/Fax: (0xx54)3025-8850'
      IsControl = True
    end
    object Label6: TLabel
      Left = 90
      Top = 188
      Width = 35
      Height = 13
      Caption = 'E-Mail: '
      IsControl = True
    end
    object Label7: TLabel
      Left = 69
      Top = 206
      Width = 56
      Height = 13
      Caption = 'HomePage:'
      IsControl = True
    end
    object Label8: TLabel
      Left = 130
      Top = 188
      Width = 107
      Height = 13
      Cursor = crHandPoint
      Caption = 'datalan@datalan.inf.br'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentColor = False
      ParentFont = False
      OnClick = Label8Click
      IsControl = True
    end
    object Label9: TLabel
      Left = 12
      Top = 68
      Width = 284
      Height = 13
      Caption = 'Este sistema tem garantia de 90 dias apartir da data de aqui-'
      IsControl = True
    end
    object Label10: TLabel
      Left = 12
      Top = 84
      Width = 271
      Height = 13
      Caption = 'si'#231#227'o, ou durante a vig'#234'ncia do contrato de manuten'#231#227'o.'
      IsControl = True
    end
    object Bevel2: TBevel
      Left = 0
      Top = 48
      Width = 313
      Height = 54
    end
    object Label2: TLabel
      Left = 30
      Top = 120
      Width = 248
      Height = 13
      Caption = 'Raz'#227'o Social: ACS Tecnologia da Informa'#231#227'o LTDA'
      IsControl = True
    end
    object Label3: TLabel
      Left = 43
      Top = 137
      Width = 222
      Height = 13
      Caption = 'Endere'#231'o: Avenida Rio Branco, 840 - Sala 701'
      IsControl = True
    end
    object Label4: TLabel
      Left = 80
      Top = 154
      Width = 148
      Height = 13
      Caption = '95010-060 - Caxias do Sul - RS'
      IsControl = True
    end
    object Label11: TLabel
      Left = 130
      Top = 204
      Width = 91
      Height = 13
      Cursor = crHandPoint
      Caption = ' www.datalan.inf.br'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentColor = False
      ParentFont = False
      OnClick = Label11Click
      IsControl = True
    end
  end
  object OKButton: TButton
    Left = 1
    Top = 229
    Width = 308
    Height = 33
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
    OnClick = OKButtonClick
  end
end
