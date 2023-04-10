Option Strict Off
Option Explicit On
Option Infer On

Imports Statline.Common.Utilities
Imports Stattrac.Services.Donor.Registry.Model
Imports System.Collections.Generic
Imports System.Collections.Immutable

Friend Class DatabaseDataSourceLookup
    Implements IDataSourceLookup

    Private ReadOnly serviceLevelId As Integer

    Private byStateLookupDictionary As ImmutableDictionary(Of String, DataSourceInfo)
    Private byIdLookupDictionary As ImmutableDictionary(Of Short, DataSourceInfo)

    Private Const DlaPseudoState As String = "DLA"

    Public Sub New(serviceLevelId As Integer)
        Me.serviceLevelId = serviceLevelId
    End Sub

    Public Function GetDataSource(dataSourceId As Integer) As DataSourceInfo Implements IDataSourceLookup.GetDataSource

        Check.BiggerOrEqual(dataSourceId, 0, NameOf(dataSourceId))

        EnsureLookupDictionary()

        Try
            Return byIdLookupDictionary(dataSourceId)
        Catch ex As KeyNotFoundException
            ThrowCantFindError(dataSourceId, ex)
        End Try

    End Function

    Public Function GetDataSource(
        registryType As DonorRegistryType,
        state As String) As DataSourceInfo Implements IDataSourceLookup.GetDataSource
        Check.NotEmpty(registryType, NameOf(registryType))

        EnsureLookupDictionary()

        Try
            If registryType = DonorRegistryType.Dla Then
                Return byStateLookupDictionary(DlaPseudoState)
            End If

            If state Is Nothing Then
                ThrowCantFindError(registryType, state)
            End If

            Return byStateLookupDictionary(state)
        Catch ex As KeyNotFoundException
            ThrowCantFindError(registryType, state, ex)
        End Try

    End Function

    Private Shared Sub ThrowCantFindError(
        dataSourceId As Integer,
        Optional innerException As Exception = Nothing)
        Throw New InvalidOperationException(
            $"Can't find data source information for source id '{dataSourceId}'", innerException)
    End Sub

    Private Shared Sub ThrowCantFindError(
        registryType As DonorRegistryType,
        state As String,
        Optional innerException As Exception = Nothing)
        Throw New InvalidOperationException(
            $"Can't find data source information for registry '{registryType}', state '{state}'", innerException)
    End Sub

    Private Sub EnsureLookupDictionary()
        If byStateLookupDictionary Is Nothing Then
            Dim dataSourcesList = modStatQuery.GetDataSourceListV3(serviceLevelId)

            byStateLookupDictionary = dataSourcesList.ToImmutableDictionary(
                Function(ds) If(ds.Name = "DLA Registry", DlaPseudoState, ds.DbName.Replace("DMV_", "")))

            byIdLookupDictionary = dataSourcesList.ToImmutableDictionary(Function(ds) ds.Id)
        End If
    End Sub
End Class
