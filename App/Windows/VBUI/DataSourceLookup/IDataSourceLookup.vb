Option Strict On
Option Explicit On
Option Infer On

Imports Stattrac.Services.Donor.Registry.Model

Friend Interface IDataSourceLookup
    Function GetDataSource(registryType As DonorRegistryType, state As String) As DataSourceInfo
    Function GetDataSource(dataSourceId As Integer) As DataSourceInfo
End Interface
