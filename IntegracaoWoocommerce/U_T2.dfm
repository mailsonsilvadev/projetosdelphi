object T2: TT2
  OldCreateOrder = False
  Height = 457
  Width = 861
  object qC1: TSQLQuery
    MaxBlobSize = -1
    ParamCheck = False
    Params = <>
    Left = 328
    Top = 4
  end
  object dspC1: TDataSetProvider
    DataSet = qC1
    Left = 328
    Top = 20
  end
  object cdsC1: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspC1'
    Left = 328
    Top = 36
  end
  object qC2: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    Left = 328
    Top = 84
  end
  object dspC2: TDataSetProvider
    DataSet = qC2
    Left = 328
    Top = 100
  end
  object cdsC2: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspC2'
    Left = 328
    Top = 116
  end
  object WSepeDBX: TSQLConnection
    DriverName = 'Firebird'
    LoginPrompt = False
    Params.Strings = (
      'DriverUnit=Data.DBXFirebird'
      
        'DriverPackageLoader=TDBXDynalinkDriverLoader,DbxCommonDriver190.' +
        'bpl'
      
        'DriverAssemblyLoader=Borland.Data.TDBXDynalinkDriverLoader,Borla' +
        'nd.Data.DbxCommonDriver,Version=19.0.0.0,Culture=neutral,PublicK' +
        'eyToken=91d62ebb5b0d1b1b'
      
        'MetaDataPackageLoader=TDBXFirebirdMetaDataCommandFactory,DbxFire' +
        'birdDriver190.bpl'
      
        'MetaDataAssemblyLoader=Borland.Data.TDBXFirebirdMetaDataCommandF' +
        'actory,Borland.Data.DbxFirebirdDriver,Version=19.0.0.0,Culture=n' +
        'eutral,PublicKeyToken=91d62ebb5b0d1b1b'
      'GetDriverFunc=getSQLDriverINTERBASE'
      'LibraryName=dbxfb.dll'
      'LibraryNameOsx=libsqlfb.dylib'
      'VendorLib=fbclient.dll'
      'VendorLibWin64=fbclient.dll'
      'VendorLibOsx=/Library/Frameworks/Firebird.framework/Firebird'
      'Database=database.fdb'
      'User_Name=sysdba'
      'Password=masterkey'
      'Role=RoleName'
      'MaxBlobSize=-1'
      'LocaleCode=0000'
      'IsolationLevel=ReadCommitted'
      'SQLDialect=3'
      'CommitRetain=False'
      'WaitOnLocks=True'
      'TrimChar=False'
      'BlobSize=-1'
      'ErrorResourceFile='
      'RoleName=RoleName'
      'ServerCharSet='
      'Trim Char=False')
    Left = 32
    Top = 24
  end
  object qEmpresa: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    Left = 96
    Top = 8
  end
  object qgSepeCfg: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      '')
    Left = 21
    Top = 71
  end
  object dspgSepeCfg: TDataSetProvider
    DataSet = qgSepeCfg
    Left = 29
    Top = 87
  end
  object cdsgSepeCfg: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspgSepeCfg'
    Left = 37
    Top = 103
    object cdsgSepeCfgOPCAO: TStringField
      FieldName = 'OPCAO'
      Required = True
      Size = 10
    end
    object cdsgSepeCfgDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 60
    end
    object cdsgSepeCfgSIT: TStringField
      FieldName = 'SIT'
      Size = 132
    end
    object cdsgSepeCfgUSRATU: TStringField
      FieldName = 'USRATU'
      Size = 10
    end
    object cdsgSepeCfgDATATU: TSQLTimeStampField
      FieldName = 'DATATU'
    end
  end
  object dsgSepeCfg: TDataSource
    DataSet = cdsgSepeCfg
    Left = 45
    Top = 119
  end
  object qCadEmp: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    Left = 24
    Top = 170
  end
  object dspCadEmp: TDataSetProvider
    DataSet = qCadEmp
    Left = 24
    Top = 186
  end
  object cdsCadEmp: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspCadEmp'
    Left = 24
    Top = 202
  end
  object dsCademp: TDataSource
    DataSet = cdsCadEmp
    Left = 27
    Top = 225
  end
  object qSepe: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    Left = 122
    Top = 86
  end
  object dspSepe: TDataSetProvider
    DataSet = qSepe
    Left = 122
    Top = 102
  end
  object cdsSepe: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspSepe'
    Left = 122
    Top = 118
  end
  object qSepeAces: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    Left = 210
    Top = 86
  end
  object dspSepeAces: TDataSetProvider
    DataSet = qSepeAces
    Left = 210
    Top = 102
  end
  object cdsSepeAces: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspSepeAces'
    Left = 210
    Top = 118
  end
  object qTemp: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    Left = 176
    Top = 8
  end
  object qWeb: TSQLQuery
    Params = <>
    Left = 264
    Top = 12
  end
  object dspWeb: TDataSetProvider
    DataSet = qWeb
    Left = 264
    Top = 28
  end
  object cdsWeb: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspWeb'
    Left = 264
    Top = 44
  end
  object dsWeb: TDataSource
    DataSet = cdsWeb
    Left = 264
    Top = 60
  end
  object qSepeCfg: TSQLQuery
    Params = <>
    Left = 24
    Top = 282
  end
  object cdsSelecaoTrib: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 176
    Top = 177
  end
  object cdsqC1: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspqC1'
    Left = 93
    Top = 297
  end
  object dspqC1: TDataSetProvider
    DataSet = qC1
    Left = 93
    Top = 273
  end
  object RESTClient1: TRESTClient
    Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Params = <>
    HandleRedirects = True
    Left = 424
    Top = 32
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <>
    Response = RESTResponse1
    Left = 424
    Top = 80
  end
  object RESTResponse1: TRESTResponse
    Left = 424
    Top = 128
  end
  object qC4: TSQLQuery
    Params = <>
    Left = 264
    Top = 188
  end
  object dspC4: TDataSetProvider
    DataSet = qC4
    Left = 264
    Top = 204
  end
  object cdsC4: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspC4'
    Left = 264
    Top = 220
  end
  object dsC4: TDataSource
    DataSet = cdsC4
    Left = 264
    Top = 236
  end
  object qC3: TSQLQuery
    Params = <>
    Left = 184
    Top = 252
  end
  object dspC3: TDataSetProvider
    DataSet = qC3
    Left = 184
    Top = 268
  end
  object cdsC3: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspC3'
    Left = 184
    Top = 284
  end
  object dsC3: TDataSource
    DataSet = cdsC3
    Left = 184
    Top = 300
  end
  object qSepeDic: TSQLQuery
    Params = <>
    Left = 32
    Top = 338
  end
end
