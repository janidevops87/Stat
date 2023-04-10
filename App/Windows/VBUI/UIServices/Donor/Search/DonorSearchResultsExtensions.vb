Imports System.Runtime.CompilerServices
Imports Stattrac.Services.Donor.Registry.Model

Namespace UIServices.Donor.Search

    Module DonorSearchResultsExtensions
        <Extension>
        Public Function ToDonorSearchFormState(
            searchResult As DonorSearchResult,
            serviceLevelId As Integer) As DonorSearchFormState

            'TODO: Find better place for this operation.
            Dim dataSourceLookup = New DatabaseDataSourceLookup(serviceLevelId)

            Dim dataSource = dataSourceLookup.GetDataSource(
                searchResult.Registry.Type,
                searchResult.Registry.OwnerState)

            Select Case searchResult.Registry.Type
                Case DonorRegistryType.Web
                    Return DonorSearchFormState.CreateFoundInWebRegistry(searchResult.Id, dataSource.Id)
                Case DonorRegistryType.Dmv
                    Return DonorSearchFormState.CreateFoundInStateRegistry(searchResult.Id, dataSource.Id)
                Case DonorRegistryType.Dla
                    Return DonorSearchFormState.CreateFoundInDlaRegistry(searchResult.Id, dataSource.Id)
            End Select

        End Function
    End Module
End Namespace
