Option Strict Off
Option Explicit On
Imports Statline.Stattrac.Windows.UI
Imports Stattrac.Services.Donor

Friend Class FrmDonorIntentFax
    Inherits System.Windows.Forms.Form
    'Bret 1/06/10 add Option explicit for upgrade

    '10/3/01 drh
    Public vParentForm As Object
    Public ServiceLevel As clsServiceLevel
    Public vRetries As Short

    Public OrganizationId As Integer
    Public vFaxNum As String
    Public vFaxEmail As String
    Public vPerson As String
    Public vOrganization As String
    Public vDocumentName As String
    Public vPersonID As Integer 'drh 06/12/03



    Public Function Display() As Integer

        Dim dialogResult As DialogResult = Me.ShowDialog()

    End Function

    Private Sub cmbFaxNumber_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles cmbFaxNumber.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        'UPGRADE_WARNING: Couldn't resolve default property of object modMask.PhoneMask(). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        KeyAscii = modMask.PhoneMask(KeyAscii, cmbFaxNumber)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub cmbFaxNumber_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmbFaxNumber.Leave

        'ccarroll 08/26/2008 StatTrac 8.4.6 release
        'Requirements 3.10 prevent faxing to 303-695-1026
        ' - Future desgin to include lookup table of restricted fax numbers
        '   or numbers which are no-longer in use.

        If Me.cmbFaxNumber.Text = "(303) 695-1026" Or Me.cmbFaxNumber.Text = "Can not fax to that number" Then
            Me.cmbFaxNumber.Text = "Can not fax to that number"
            Me.cmbFaxNumber.Focus()
        End If


    End Sub

    Private Sub cmbFaxNumber_TextChanged(sender As Object, e As EventArgs) Handles cmbFaxNumber.TextChanged
        ' Fax number and Email fields are mutually exclusive and 
        ' can't be edited simultaneously.
        Dim expectedFaxEmailEnabledState As Boolean = String.IsNullOrEmpty(cmbFaxNumber.Text)

        If txtFaxEmail.Enabled <> expectedFaxEmailEnabledState Then
            txtFaxEmail.Enabled = expectedFaxEmailEnabledState
            lblFaxEmail.Enabled = expectedFaxEmailEnabledState
        End If

    End Sub

    Private Sub txtFaxEmail_TextChanged(sender As Object, e As EventArgs) Handles txtFaxEmail.TextChanged
        ' Fax number and Email fields are mutually exclusive and 
        ' can't be edited simultaneously.
        Dim expectedFaxNumberEnabledState As Boolean = String.IsNullOrEmpty(txtFaxEmail.Text)

        If cmbFaxNumber.Enabled <> expectedFaxNumberEnabledState Then
            cmbFaxNumber.Enabled = expectedFaxNumberEnabledState
            lblFaxNumber.Enabled = expectedFaxNumberEnabledState
        End If
    End Sub

    'UPGRADE_WARNING: Event cmbOrganization.SelectedIndexChanged may fire when form is initialized. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="88B12AE1-6DE0-48A0-86F1-60C0686C026A"'
    Private Sub cmbOrganization_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmbOrganization.SelectedIndexChanged

        If Me.cmbOrganization.SelectedIndex <> -1 Then
            Me.cmbFaxNumber.Items.Clear()
            Call ServiceLevel.GetOrgFaxNumbers((Me.cmbFaxNumber), modControl.GetID(Me.cmbOrganization))
        End If

    End Sub

    Private Sub CmdCancel_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdCancel.Click

        Me.Hide()
        Me.Close()

    End Sub

    Private Sub CmdSend_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdSend.Click
        'Reset from previous values.
        vFaxNum = Nothing
        vFaxEmail = Nothing

        Dim vQuery As String = ""

        vPerson = cmbPerson.Text
        vOrganization = cmbOrganization.Text
        vDocumentName = txtDocumentName.Text

        If String.IsNullOrEmpty(cmbFaxNumber.Text) And
           String.IsNullOrEmpty(txtFaxEmail.Text) Then
            ShowError("Please enter either a fax number or an email address.", "Invalid Fax or Email")
            Exit Sub
        ElseIf cmbFaxNumber.Enabled Then

            vFaxNum = cmbFaxNumber.Text

            'Validate Fax Number
            If Len(vFaxNum) <> 14 Then
                ShowError("Please enter a valid fax number.", "Invalid Fax")
                Exit Sub
            Else
                vFaxNum = StripChars(vFaxNum, "(")
                vFaxNum = StripChars(vFaxNum, " ")
                vFaxNum = StripChars(vFaxNum, "-")
                vFaxNum = StripChars(vFaxNum, ")")

                If InStr(1, vFaxNum, "303") = 0 And InStr(1, vFaxNum, "720") = 0 Then
                    vFaxNum = "1" & vFaxNum
                End If
            End If
        Else
            vFaxEmail = txtFaxEmail.Text

            Const MaxEmailLength As Integer = 100

            If vFaxEmail.Length > MaxEmailLength Then
                ShowError($"The email address must be no longer than {MaxEmailLength} characters.", "Invalid email address")
                Exit Sub
            End If

            Try
                'The simplest way to check if an email address is valid.
                'This also strips out the display name in case user entered it
                'to ensure the address is in a consistent format.
                vFaxEmail = New Net.Mail.MailAddress(vFaxEmail).Address
            Catch ex As ArgumentException
                ' We shouldn't get here as we validate fax first, but just in case.
                ShowError("Please enter an email address.", "Invalid email address")
                Exit Sub
            Catch ex As FormatException
                ShowError("Please enter a valid email address.", "Invalid email address")
                Exit Sub
            End Try
        End If


        'Validate Person
        If Len(vPerson) < 2 Then
            ShowError("Please enter a valid Person.", "Invalid Person")
            Exit Sub
        Else
            vPerson = StripChars(vPerson, "'")
        End If

        'Validate Organization
        If Len(vOrganization) < 2 Then
            ShowError("Please enter a valid Organization.", "Invalid Organization")
            Exit Sub
        Else
            vOrganization = StripChars(vOrganization, "'")
        End If

        'Validate Document Name
        If Len(vDocumentName) < 6 Then
            ShowError("Please enter a valid Document Name.", "Invalid Document Name")
            Exit Sub
        Else
            vDocumentName = StripChars(vDocumentName, "'")

            If InStr(1, vDocumentName, ".doc") = 0 Then
                ShowError("Please enter a valid Document Name.", "Invalid Document Name")
                Exit Sub
            End If
        End If


        'Add record to FaxQueue table
        Call modStatSave.SaveDocumentRequestQueue(Me)


        'Insert Ougoing Fax Event
        Dim logeventdesc As String = "" '03/13/03 bjk broke logeventdesc to add additional information withmodStatQuery.QueryDonorRegistryInformation
        Dim vTempLogEventId As Integer 'Need Non-variant variable to pass as argument
        'UPGRADE_ISSUE: Control DonorDMVId could not be resolved because it was within the generic namespace Form. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="084D22AD-ECB1-400F-B4C7-418ECEC5E36E"'
        'UPGRADE_ISSUE: Control DonorRegId could not be resolved because it was within the generic namespace Form. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="084D22AD-ECB1-400F-B4C7-418ECEC5E36E"'

        Dim donorInfo As String = QueryDonorRegistryInformation()

        logeventdesc =
            $"{donorInfo}{Environment.NewLine}" &
            $"Donor Registry Id: {vParentForm.DonorSearchState.DonorRegId}{Environment.NewLine}" &
            $"Donor DMV Id: {vParentForm.DonorSearchState.DonorDMVId}{Environment.NewLine}" &
            $"{If(vFaxNum Is Nothing, "Email: ", "Fax#: ")}{If(vFaxNum, vFaxEmail)}"

        vTempLogEventId = modStatSave.SaveLogEvent(Me, Verification_Form_Sent, logeventdesc)

        'Update Fax Sent flag
        vParentForm.DonorFaxSent = -1


        'Hide the form
        Me.Hide()
        Me.Close()

    End Sub

    Private Function QueryDonorRegistryInformation() As String
        Dim donorService As DonorService = New DonorServiceFactory(
            CType(vParentForm.CallerOrg.ServiceLevel.ID, Integer)).Create()

        Dim donorInfo As String =
            donorService.GetFormattedDonorDetailsAsync(vParentForm).GetAwaiter().GetResult()

        Return donorInfo
    End Function

    Private Sub FrmDonorIntentFax_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load

        'UPGRADE_ISSUE: Control CallerOrg could not be resolved because it was within the generic namespace Form. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="084D22AD-ECB1-400F-B4C7-418ECEC5E36E"'
        ServiceLevel = vParentForm.CallerOrg.ServiceLevel
        Call ServiceLevel.GetAssignedOrgs(Me.cmbOrganization)
        Call ServiceLevel.GetDonorIntentPeople((Me.cmbPerson), (ServiceLevel.ID))
        Call Me.SetData()
    End Sub

    Public Sub SetData()

        Me.txtDocumentName.Text = ServiceLevel.DocumentName
        Me.vRetries = ServiceLevel.Retries
        'Me.Txtsentto = FrmOnCallEvent.TxtContactName 'T.T 11/17/2004 removed because it was opening the form oncallevent.
    End Sub

    Private Sub FrmDonorIntentFax_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing

        '10/24/01 drh Set Global form reference to Nothing


    End Sub

    Private Sub ShowError(message As String, caption As String)
        BaseMessageBox.ShowError(message, caption, owner:=Me)
    End Sub

End Class