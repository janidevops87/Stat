Option Strict Off
Option Explicit On
Option Infer On

Imports System.Collections.Generic
Imports System.Collections.Immutable
Imports System.Threading.Tasks
Imports Stattrac.Services.Donor.Registry.Model

Namespace Services.Donor
    Public Class DatabaseDonorServiceConfigurationProvider
        Implements IDonorServiceConfigurationProvider

        Private ReadOnly serviceLevelID As Integer

        Sub New(serviceLevelID As Integer)
            Me.serviceLevelID = serviceLevelID
        End Sub

        Public Function GetConfigurationAsync() As Task(Of DonorServiceConfiguration) Implements IDonorServiceConfigurationProvider.GetConfigurationAsync

            Dim searchConfig = GetDonorSearchConfiguration()
            Dim dmvStateMappingConfiguration = GetDmvStateMappingConfiguration()

            Dim donorServiceConfiguration As New DonorServiceConfiguration(
                searchConfig,
                dmvStateMappingConfiguration)

            Return Task.FromResult(donorServiceConfiguration)

        End Function

        Private Function GetDmvStateMappingConfiguration() As DmvStateMappingConfiguration
            Dim dataSourcesList = modStatQuery.GetDataSourceListV3(serviceLevelID)

            Dim stateByIdLookupDictionary = dataSourcesList.
                Where(Function(ds) ds.DbName.StartsWith("DMV_")).
                ToImmutableDictionary(
                    Function(ds) ds.Id,
                    Function(ds) ds.DbName.Replace("DMV_", ""))

            Return New DmvStateMappingConfiguration(stateByIdLookupDictionary)
        End Function

        Private Function GetDonorSearchConfiguration() As DonorSearchConfiguration
            Dim searchConfig = GetSearchConfig(serviceLevelID)
            Dim registryOwnerIds = GetServiceLevelRegistryOwnerIds(serviceLevelID)

            Dim configuration = New DonorSearchConfiguration(
                searchConfig.IncludeDlaDonors,
                searchConfig.States,
                registryOwnerIds)
            Return configuration
        End Function

        Private Shared Function GetSearchConfig(serviceLevelID As Integer) As (IncludeDlaDonors As Boolean, States As IEnumerable(Of String))

            Dim statesList = GetServiceLevelStatesList(serviceLevelID)

            Const DlaPseudoState As String = "DLA"

            Dim includedStates = From state In statesList
                                 Where state <> DlaPseudoState
                                 Select state

            Return (IncludeDlaDonors:=statesList.Contains(DlaPseudoState),
                States:=includedStates)
        End Function

        Private Shared Function GetServiceLevelStatesList(serviceLevelID As Integer) As IEnumerable(Of String)
            ' We need any assigned value as a sign of select operation
            Dim statesList(,) As Object = New Object(,) {}

            Dim query = "EXEC sps_GetDonorSearchConfiguration " & serviceLevelID

            modODBC.Exec(
            query,
            prResults:=statesList,
            pvReturnRecordSet:=False)

            Return statesList.Cast(Of String)

        End Function

        Friend Shared Function GetServiceLevelRegistryOwnerIds(serviceLevelID As Integer) As IEnumerable(Of Integer)
            ' We need any assigned value as a sign of select operation
            Dim idList(,) As Object = New Object(,) {}

            Dim query = "EXEC sps_GetRegistryOwnerIds " & serviceLevelID

            modODBC.Exec(
            query,
            prResults:=idList,
            pvReturnRecordSet:=False)

            'For some reason modODBC.Exec always returns collection of String 
            'element type, so have to do conversion.
            Return idList.Cast(Of String).Select(Function(id) Integer.Parse(id))
        End Function
    End Class
End Namespace