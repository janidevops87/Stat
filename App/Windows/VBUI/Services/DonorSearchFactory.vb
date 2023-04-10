Imports Statline.Common.Utilities
Imports Statline.Stattrac.Networking.RegistryApiClient.Http.Compatibility

''' <summary>
''' This factory simplifies creation of <see cref="DonorSearch"/> where
''' we can't inject dependencies in an elegant way and don't care about hardcoding
''' concrete implementations.
''' </summary>
Friend Class DonorSearchFactory
    Private ReadOnly configurationProvider As IDonorSearchConfigurationProvider

    Sub New(serviceLevelId As Integer)
        Me.New(New DatabaseDonorSearchConfigurationProvider(serviceLevelId))
    End Sub

    Sub New(configurationProvider As IDonorSearchConfigurationProvider)
        Check.NotNull(configurationProvider, NameOf(configurationProvider))
        Me.configurationProvider = configurationProvider
    End Sub

    Friend Function Create() As DonorSearch
        Return New DonorSearch(
            HttpRegistryApiClientFactory.Instance.CreateClient(),
            configurationProvider)
    End Function
End Class
