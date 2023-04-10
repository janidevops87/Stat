Imports System.Runtime.CompilerServices
Imports System.Threading.Tasks

Namespace Services.Donor
    Module DonorServiceExtensions
        <Extension>
        Public Async Function GetFormattedDonorDetailsAsync(
               donorService As DonorService,
               parentForm As BaseFormReferralData) As Task(Of String)

            Return Await donorService.GetFormattedDonorDetailsAsync(
                parentForm.DonorSearchState.DonorRegId,
                parentForm.DonorSearchState.DonorDMVId,
                parentForm.DonorSearchState.DonorDSNID).ConfigureAwait(False)

        End Function
    End Module
End Namespace
