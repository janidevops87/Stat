Option Strict On
Option Explicit On
Option Infer On

Imports Statline.Common.Utilities
Imports Statline.Registry.Api.Client.Http.Compatibility
Imports Stattrac.Services.Donor.Registry.RegistryApi

Namespace Services.Donor
    ''' <summary>
    ''' This factory simplifies creation of <see cref="DonorService"/> where
    ''' we can't inject dependencies in an elegant way and don't care about hardcoding
    ''' concrete implementations.
    ''' </summary>
    Friend Class DonorServiceFactory
        Private ReadOnly configurationProvider As IDonorServiceConfigurationProvider

        Sub New(serviceLevelId As Integer)
            Me.New(New LoggingServiceConfigurationProviderDecorator(
                New DatabaseDonorServiceConfigurationProvider(serviceLevelId)))
        End Sub

        Sub New(configurationProvider As IDonorServiceConfigurationProvider)
            Check.NotNull(configurationProvider, NameOf(configurationProvider))
            Me.configurationProvider = configurationProvider
        End Sub

        Friend Function Create() As DonorService
            Return New DonorService(
                New ApiDonorRegistry(HttpRegistryApiClientFactory.Instance.CreateClient()),
                configurationProvider)
        End Function
    End Class

End Namespace