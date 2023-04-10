Option Strict On
Option Explicit On
Option Infer On

Imports System.Threading.Tasks
Imports Statline.Common.Utilities
Imports Statline.Stattrac.Framework

Namespace Services.Donor
    Public Class LoggingServiceConfigurationProviderDecorator
        Implements IDonorServiceConfigurationProvider

        Private ReadOnly innerProvider As IDonorServiceConfigurationProvider

        Sub New(innerProvider As IDonorServiceConfigurationProvider)
            Check.NotNull(innerProvider, NameOf(innerProvider))
            Me.innerProvider = innerProvider
        End Sub

        Public Async Function GetConfigurationAsync() As Task(Of DonorServiceConfiguration) Implements IDonorServiceConfigurationProvider.GetConfigurationAsync
            Try
                Return Await innerProvider.GetConfigurationAsync().ConfigureAwait(False)
            Catch ex As Exception
                LogException(ex)
                Throw
            End Try
        End Function

        Private Shared Sub LogException(ByVal ex As Exception)
            Try
                StatTracLogger.CreateInstance().Write(ex)
            Catch
                ' Swallow error
            End Try
        End Sub
    End Class
End Namespace