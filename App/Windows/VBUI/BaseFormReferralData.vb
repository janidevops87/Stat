Imports Statline.Stattrac.Windows.UI
Imports Stattrac.UIServices.Donor.Search
''' <summary>
''' This form was created to handle passing data between modules.
''' </summary>
''' <remarks></remarks>
Public Class BaseFormReferralData


    Public vNoteChange As String

    'TODO: Consider removing these.
    Public WSCount As Short 'T.T 3/24/2006 WebServices count
    Public DrdsnCount As Short 'T.T 04/12/2006 drdsncount including webservice

    '10/16/01 drh
    Public OrganizationStateID As Short

    Public DonorSearchState As DonorSearchFormState = DonorSearchFormState.NotChecked

    Public DonorLastName As String
    Public DonorFirstName As String
    Public DonorDOB As String

    Public DonorIntentDone As Short
    Public DonorFaxSent As Short
    Public DonorAppropriate As Boolean

    Public Interrupt As Short 'T.T 09/26/2005 added for webservice
    Public escape As Boolean

    Protected Sub ShowError(message As String, caption As String)
        BaseMessageBox.ShowError(message, caption, owner:=Me)
    End Sub

End Class