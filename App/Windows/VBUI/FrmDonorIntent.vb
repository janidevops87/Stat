Option Strict Off
Option Explicit On
Friend Class FrmDonorIntent
	Inherits System.Windows.Forms.Form
	'Bret 1/06/10 add Option explicit for upgrade

    Public vNOKID As Integer 'T.T 09/08/2006 changed to Long so that this will no longer bomb
    Public vNOK As String
    Public vNOKAdded As Short
    Public NOKStateID As Short
    Public vReturn As Short

    Public FormState As Short
    Public Saved As Short
    Public modalParent As Object
    Dim frmLogEvent As FrmLogEvent
    Public Function Display() As Integer



        'C.Chaput Check to see if NOK Data exists on NOK Table with corresponding NOKID
        'If it does then it is after release 8.0 so display before the name was split out.
        vNOKID = modalParent.NOKID
        'the following check is for a new referral, donorintent is clicked and
        'then click on NOK before before the initial save of a referral.
        'NOK does not get saved unitl the referral does.
        vNOKAdded = Len(modalParent.NOKFirstName & modalParent.NOKLastName)
        'Now check if NOK was ever entered for referral before 8.0 if not then
        'use new display
        vNOK = modalParent.NOK


        If vNOKID > 0 Or vNOK = "" Or IsDBNull(vNOKID) Then 'No new NOK and no old NOK
            If modalParent.NOKData = True Then
                Me.Frame2.Visible = True
                Me.Frame1.Visible = False
                Me.Height = VB6.TwipsToPixelsY(3000)
                Me.Width = VB6.TwipsToPixelsX(7500)
                Me.Frame2.Height = VB6.TwipsToPixelsY(2400)
                Me.txtNurseScript.Visible = False
                Me.lblRegType.Visible = False
                Me.LblFN.Top = VB6.TwipsToPixelsY(160)
                Me.TxtNOKFirstName.Top = VB6.TwipsToPixelsY(160)
                Me.LblLN.Top = VB6.TwipsToPixelsY(160)
                Me.TxtNOKLastName.Top = VB6.TwipsToPixelsY(160)
                Me.LblRelation.Top = VB6.TwipsToPixelsY(560)
                Me.CboRelation.Top = VB6.TwipsToPixelsY(560)
                Me.LblPhone.Top = VB6.TwipsToPixelsY(560)
                Me.TxtNOKPhone.Top = VB6.TwipsToPixelsY(560)
                Me.TxtNOKPhone.MaxLength = 14
                Me.LblAddress.Top = VB6.TwipsToPixelsY(960)
                Me.TxtNOKAddress.Top = VB6.TwipsToPixelsY(960)
                Me.CmdFamilyContact.Top = VB6.TwipsToPixelsY(960)
                Me.LblCity.Top = VB6.TwipsToPixelsY(1960)
                Me.TxtNOKCity.Top = VB6.TwipsToPixelsY(1960)
                Me.LblState.Top = VB6.TwipsToPixelsY(1960)
                Me.CboState.Top = VB6.TwipsToPixelsY(1960)
                Me.LblZip.Top = VB6.TwipsToPixelsY(1960)
                Me.TxtNOKZip.Top = VB6.TwipsToPixelsY(1960)
                Me.cmdCancel.Top = VB6.TwipsToPixelsY(2000)
                Me.cmdContinue.Text = "&OK"
            Else
                'load normally
                Me.cmdContinue.Text = "Continue..."
            End If
        Else 'NOK old exists display the old way
            If modalParent.NOKData = True Then
                Me.Frame1.Visible = True
                Me.Frame2.Visible = False
                Me.txtoldNurseScript.Visible = False
                Me.lbloldRegType.Visible = False
                Me.Height = VB6.TwipsToPixelsY(2545)
                Me.Width = VB6.TwipsToPixelsX(5500)
                Me.Frame1.Height = VB6.TwipsToPixelsY(1985)
                Me.LblNOK.Top = VB6.TwipsToPixelsY(160)
                Me.TxtNOK.Top = VB6.TwipsToPixelsY(160)
                Me.LblOldRelation.Top = VB6.TwipsToPixelsY(560)
                Me.CboOldRelation.Top = VB6.TwipsToPixelsY(560)
                Me.TxtOldPhone.Top = VB6.TwipsToPixelsY(560)
                Me.TxtOldPhone.MaxLength = 14
                Me.LblOldAddress.Top = VB6.TwipsToPixelsY(960)
                Me.TxtOldAddress.Top = VB6.TwipsToPixelsY(960)
                Me.cmdCancel.Top = VB6.TwipsToPixelsY(1600)
                Me.cmdCancel.Left = VB6.TwipsToPixelsX(4090)
                Me.cmdContinue.Top = VB6.TwipsToPixelsY(120)
                Me.cmdContinue.Text = "&OK"
                Me.cmdContinue.Left = VB6.TwipsToPixelsX(4090)
            Else
                Me.Frame1.Visible = True
                Me.Frame2.Visible = False
                Me.txtoldNurseScript.Visible = True
                Me.lbloldRegType.Visible = True
                Me.txtoldNurseScript.Top = VB6.TwipsToPixelsY(150)
                Me.lbloldRegType.Top = VB6.TwipsToPixelsY(360)
                Me.Height = VB6.TwipsToPixelsY(3745)
                Me.Width = VB6.TwipsToPixelsX(5500)
                Me.Frame1.Height = VB6.TwipsToPixelsY(3145)
                Me.LblNOK.Top = VB6.TwipsToPixelsY(1440)
                Me.TxtNOK.Top = VB6.TwipsToPixelsY(1440)
                Me.LblOldRelation.Top = VB6.TwipsToPixelsY(1800)
                Me.CboOldRelation.Top = VB6.TwipsToPixelsY(1800)
                Me.TxtOldPhone.Top = VB6.TwipsToPixelsY(1800)
                Me.TxtOldPhone.MaxLength = 14
                Me.LblOldAddress.Top = VB6.TwipsToPixelsY(2130)
                Me.TxtOldAddress.Top = VB6.TwipsToPixelsY(2130)
                Me.cmdCancel.Top = VB6.TwipsToPixelsY(2530)
                Me.cmdCancel.Left = VB6.TwipsToPixelsX(4090)
                Me.cmdContinue.Text = "Continue..."
                Me.cmdContinue.Top = VB6.TwipsToPixelsY(120)
                Me.cmdContinue.Left = VB6.TwipsToPixelsX(4090)
            End If
        End If

        'End If

        ShowDialog()

        Display = vNOKID

    End Function

    Private Sub CboRelation_KeyDown(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles CboRelation.KeyDown
        Dim KeyCode As Short = eventArgs.KeyCode
        Dim Shift As Short = eventArgs.KeyData \ &H10000

        If KeyCode = System.Windows.Forms.Keys.Delete Then
            Call CboRelation_KeyPress(CboRelation, New System.Windows.Forms.KeyPressEventArgs(Chr(8)))
        End If

    End Sub

    Private Sub CboRelation_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles CboRelation.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        'Allow the delete key to clear the combo box
        Call modControl.AllowDelete(CboRelation, KeyAscii)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub
    Private Sub CboOldRelation_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboOldRelation.SelectedIndexChanged

        If TxtNOKFirstName.Text <> "" And TxtNOKLastName.Text <> "" And Len(TxtNOKPhone.Text) = 14 And TxtNOKAddress.Text <> "" And CboRelation.Text <> "" Then
            cmdContinue.Enabled = True
        Else
            cmdContinue.Enabled = True
        End If

    End Sub

    Private Sub CmdCancel_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdCancel.Click

        Me.Close()

    End Sub

    Private Sub cmdContinue_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdContinue.Click

        On Error Resume Next

        'Make sure the user wants to save
        vReturn = modMsgForm.FormSave

        If vReturn = MsgBoxResult.Cancel Then
            Exit Sub
        End If

        If vNOK <> "" And modalParent.FormState = EXISTING_RECORD And vNOKID = 0 Then
            '10/2/01 drh
            modalParent.NOK = Me.TxtNOK.Text
            modalParent.NOKPhone = Me.TxtOldPhone.Text
            modalParent.NOKRefAddress = Me.TxtOldAddress.Text
            modalParent.NOKRelation = Me.CboOldRelation.Text
        Else
            modalParent.NOKFirstName = Me.TxtNOKFirstName.Text
            modalParent.NOKLastName = Me.TxtNOKLastName.Text
            modalParent.NOKRefPhone = Me.TxtNOKPhone.Text
            modalParent.NOKRefAddress = Me.TxtNOKAddress.Text
            modalParent.NOKCity = Me.TxtNOKCity.Text
            modalParent.NOKStateID = modControl.GetID((Me.CboState))
            modalParent.NOKZip = Me.TxtNOKZip.Text
            modalParent.NOKApproachRelation = Me.CboRelation.Text

        End If

        If modalParent.NOKData = False Then
            'Set Donor Intent Done flag
            modalParent.DonorIntentDone = -1
        End If

        'Determine the state of this form so that when the referral is saved and
        'modstatsave.SaveNOK is called you can add to the DB in correct state.
        If vNOKID > 0 Or Me.TxtNOKFirstName.Text > "" Or Me.TxtNOKLastName.Text > "" Or Me.CboRelation.Text > "" Then
            If Me.FormState = EXISTING_RECORD Then
                modalParent.ModNOK = True
            Else
                modalParent.AddNOK = True
            End If
        End If

        Me.Saved = True

        Me.Close()

    End Sub

    Private Sub CmdFamilyContact_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdFamilyContact.Click

        On Error Resume Next

        Dim vLogEventID As Integer
        Dim vReturn As New Object
        Dim I As Short
        Dim vEventTypeList(1) As Object
        Dim vSubItemsList As New Object

        'Set the correct LogEvent state
        If (IsNothing(frmLogEvent)) Then
            frmLogEvent = New FrmLogEvent()
        End If

        frmLogEvent.FormState = NEW_RECORD

        'Set the call id and number of the Details form
        frmLogEvent.CallId = modalParent.CallId
        frmLogEvent.CallNumber = modalParent.CallNumber

        'Default fields
        frmLogEvent.DefaultContactName = TxtNOKFirstName.Text & " " & TxtNOKLastName.Text
        frmLogEvent.DefaultContactPhone = TxtNOKPhone.Text
        frmLogEvent.DefaultOrganization = "Next of kin."
        frmLogEvent.DefaultContactType = OUTGOING

        'Set event types
        vEventTypeList(0) = OUTGOING
        vEventTypeList(1) = CALLBACK_PENDING
        frmLogEvent.LogEventTypeList = VB6.CopyArray(vEventTypeList)

        '10/22/01 drh
        frmLogEvent.vParentForm = Me

        'Get the Details id from the Details form
        'after the user is done.
        Call frmLogEvent.Display()

        modalParent.TabDonor.SelectedIndex = 3
    End Sub

    Private Sub FrmDonorIntent_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load

        On Error Resume Next

        'Call modUtility.CenterForm()

        'C.Chaput Check to see if NOK Data exists on NOK Table with corresponding NOKID
        'If it does then it is after release 8.0 so display before the name was split out.
        vNOKID = modalParent.NOKID
        'the following check is for a new referral, donorintent is clicked and
        'then click on NOK before before the initial save of a referral.
        'NOK does not get saved unitl the referral does.
        vNOKAdded = Len(modalParent.NOKFirstName & modalParent.NOKLastName)
        'Now check if NOK was ever entered for referral before 8.0 if not then
        'use new display
        vNOK = modalParent.NOK


        Call modControl.Disable((Me.TxtNOKLastName))
        Call modControl.Disable((Me.TxtNOKPhone))
        Call modControl.Disable((Me.TxtNOKAddress))
        Call modControl.Disable((Me.TxtNOKCity))
        Call modControl.Disable((Me.CboState))
        Call modControl.Disable((Me.TxtNOKZip))
        Call modControl.Disable((Me.CboRelation))

        'Get the reference data
        Call modStatRefQuery.RefQueryState(CboState)
        'T.T 09/022/04 added to enable and disable nok based on service level
        If modalParent.CallerOrg.ServiceLevel.NOKRegistration Then
            If Not modalParent.DonorSearchState.HasDonor Then
                If modalParent.CallerOrg.ServiceLevel.NOKName = -1 Then
                    Call modControl.Enable((Me.TxtNOKFirstName))
                    Call modControl.Enable((Me.TxtNOKLastName))
                End If
                If modalParent.CallerOrg.ServiceLevel.NOKPhone = -1 Then
                    Call modControl.Enable((Me.TxtNOKPhone))
                End If
                If modalParent.CallerOrg.ServiceLevel.NOKAddress = -1 Then
                    Call modControl.Enable((Me.TxtNOKAddress))
                    Call modControl.Enable((Me.TxtNOKCity))
                    Call modControl.Enable((Me.CboState))
                    Call modControl.Enable((Me.TxtNOKZip))
                End If
                If modalParent.CallerOrg.ServiceLevel.NOKRelation = -1 Then
                    Call modControl.Enable((Me.CboRelation))
                End If

                If vNOKID <> 0 Or vNOKAdded > 0 Then
                    Me.TxtNOKFirstName.Text = modalParent.NOKFirstName
                    Me.TxtNOKLastName.Text = modalParent.NOKLastName
                    Me.TxtNOKPhone.Text = modalParent.NOKRefPhone
                    Me.TxtNOKAddress.Text = modalParent.NOKRefAddress
                    Me.TxtNOKCity.Text = modalParent.NOKCity
                    Call modControl.SelectID((Me.CboState), modalParent.NOKStateID)
                    Me.TxtNOKZip.Text = modalParent.NOKZip
                    Call modControl.SelectText(CboRelation, modalParent.NOKApproachRelation)
                Else
                    If vNOK > "" Then
                        'vParentForm
                        TxtNOK.Text = modalParent.NOK
                        Call modControl.SelectText(CboOldRelation, modalParent.NOKRelation)
                        TxtOldPhone.Text = modalParent.NOKPhone
                        TxtOldAddress.Text = modalParent.NOKRefAddress

                    End If
                End If
            Else
                Call modControl.Disable((Me.TxtNOKFirstName))
                Call modControl.Disable((Me.TxtNOKLastName))
                Call modControl.Disable((Me.TxtNOKPhone))
                Call modControl.Disable((Me.TxtNOKAddress))
                Call modControl.Disable((Me.TxtNOKCity))
                Call modControl.Disable((Me.CboState))
                Call modControl.Disable((Me.TxtNOKZip))
                Call modControl.Disable((Me.CboRelation))
                cmdContinue.Enabled = True
            End If
        Else
            'Get the reference data
            Call modStatRefQuery.RefQueryState(CboState)

            If vNOKID <> 0 Or vNOKAdded > 0 Then
                Me.TxtNOKFirstName.Text = modalParent.NOKFirstName
                Me.TxtNOKLastName.Text = modalParent.NOKLastName
                Me.TxtNOKPhone.Text = modalParent.NOKRefPhone
                Me.TxtNOKAddress.Text = modalParent.NOKRefAddress
                Me.TxtNOKCity.Text = modalParent.NOKCity
                Call modControl.SelectID((Me.CboState), modalParent.NOKStateID)
                Me.TxtNOKZip.Text = modalParent.NOKZip
                Call modControl.SelectText(CboRelation, modalParent.NOKApproachRelation)
            Else
                If vNOK > "" Then
                    'vParentForm
                    TxtNOK.Text = modalParent.NOK
                    Call modControl.SelectText(CboOldRelation, modalParent.NOKRelation)
                    TxtOldPhone.Text = modalParent.NOKPhone
                    TxtOldAddress.Text = modalParent.NOKRefAddress

                End If
            End If

            'collect NOK upon consent
            If modalParent.CallerOrg.ServiceLevel.NOKRelation Then
                'Call modControl.Enable(modalParent.CboRelation)
                Call modControl.Enable((Me.CboRelation))
            End If
            If modalParent.CallerOrg.ServiceLevel.NOKPhone Then
                'Call modControl.Enable(modalParent.TxtNOKPhone)
                Call modControl.Enable((Me.TxtNOKPhone))
            End If
            If modalParent.CallerOrg.ServiceLevel.NOKAddress Then
                'Call modControl.Enable(modalParent.TxtNOKAddress)
                Call modControl.Enable((Me.TxtNOKAddress))
                Call modControl.Enable((Me.TxtNOKCity))
                Call modControl.Enable((Me.CboState))
                Call modControl.Enable((Me.TxtNOKZip))
            End If

            'T.T 09/22/04  added to enable nok on referral form next of kin popup window
            If modalParent.CallerOrg.ServiceLevel.NOKName Then
                Call modControl.Enable((Me.TxtNOKFirstName))
                Call modControl.Enable((Me.TxtNOKLastName))
            Else
                Me.TxtNOKFirstName.Enabled = False
                Me.TxtNOKFirstName.BackColor = System.Drawing.SystemColors.Control
            End If

            cmdContinue.Enabled = True
        End If

        Dim val_Renamed As Object
        If modalParent.CallerOrg.ServiceLevel.NOKConsent Then
            val_Renamed = modControl.GetID((modalParent.CboGeneralConsent))
            If Not modalParent.DonorSearchState.HasDonor Then
                If val_Renamed = 1 Or val_Renamed = 2 Or val_Renamed = -1 Then
                    If modalParent.CallerOrg.ServiceLevel.NOKName = -1 Then
                        Call modControl.Enable((Me.TxtNOKFirstName))
                        Call modControl.Enable((Me.TxtNOKLastName))
                    End If
                    If modalParent.CallerOrg.ServiceLevel.NOKPhone = -1 Then
                        Call modControl.Enable((Me.TxtNOKPhone))
                    End If
                    If modalParent.CallerOrg.ServiceLevel.NOKAddress = -1 Then
                        Call modControl.Enable((Me.TxtNOKAddress))
                        Call modControl.Enable((Me.TxtNOKCity))
                        Call modControl.Enable((Me.CboState))
                        Call modControl.Enable((Me.TxtNOKZip))
                    End If
                    If modalParent.CallerOrg.ServiceLevel.NOKRelation = -1 Then
                        Call modControl.Enable((Me.CboRelation))
                    End If

                    cmdContinue.Enabled = True
                Else
                    Call modControl.Disable((Me.TxtNOKFirstName))
                    Call modControl.Disable((Me.TxtNOKLastName))
                    Call modControl.Disable((Me.TxtNOKPhone))
                    Call modControl.Disable((Me.TxtNOKAddress))
                    Call modControl.Disable((Me.TxtNOKCity))
                    Call modControl.Disable((Me.CboState))
                    Call modControl.Disable((Me.TxtNOKZip))
                    Call modControl.Disable((Me.CboRelation))
                    cmdContinue.Enabled = True
                End If
            Else
                'This overrides if both consent and don't collect are checked
                If modalParent.CallerOrg.ServiceLevel.NOKRegistration Or val_Renamed = 3 Then
                    Call modControl.Disable((Me.TxtNOKFirstName))
                    Call modControl.Disable((Me.TxtNOKLastName))
                    Call modControl.Disable((Me.TxtNOKPhone))
                    Call modControl.Disable((Me.TxtNOKAddress))
                    Call modControl.Disable((Me.TxtNOKCity))
                    Call modControl.Disable((Me.CboState))
                    Call modControl.Disable((Me.TxtNOKZip))
                    Call modControl.Disable((Me.CboRelation))
                    cmdContinue.Enabled = True
                End If
            End If
            'Else
            'Call modControl.Disable(Me.TxtNOKFirstName)
            'Call modControl.Disable(Me.TxtNOKLastName)
            'Call modControl.Disable(Me.TxtNOKPhone)
            'Call modControl.Disable(Me.TxtNOKAddress)
            'Call modControl.Disable(Me.TxtNOKCity)
            'Call modControl.Disable(Me.CboState)
            'Call modControl.Disable(Me.TxtNOKZip)
            'Call modControl.Disable(Me.CboRelation)
            'cmdContinue.Enabled = True
        End If
        cmdContinue.Enabled = True
    End Sub

    Private Sub FrmDonorIntent_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing

        If Me.Saved <> True Then
            'The message was cancelled or closed so confirm cancellation
            vReturn = modMsgForm.FormCancel
            If vReturn = MsgBoxResult.Yes Then
                Me.Visible = False
                eventArgs.Cancel = False

            Else
                eventArgs.Cancel = True
            End If
        Else

            Hide()
            '10/24/01 drh Set Global form reference to Nothing

        End If
        If Not IsNothing(frmLogEvent) Then
            frmLogEvent = Nothing
        End If
    End Sub


    Private Sub TxtNOK_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtNOK.TextChanged
        If TxtNOK.Text <> "" And Len(TxtNOKPhone.Text) = 14 And TxtNOKAddress.Text <> "" And CboRelation.Text <> "" Then
            cmdContinue.Enabled = True
        Else
            cmdContinue.Enabled = True
        End If

    End Sub


    Private Sub TxtNOKAddress_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtNOKAddress.TextChanged

        If TxtNOKFirstName.Text <> "" And TxtNOKLastName.Text <> "" And Len(TxtNOKPhone.Text) = 14 And TxtNOKAddress.Text <> "" And CboRelation.Text <> "" Then
            cmdContinue.Enabled = True
        Else
            cmdContinue.Enabled = True
        End If

    End Sub


    Private Sub TxtNOKPhone_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtNOKPhone.TextChanged

        If TxtNOKFirstName.Text <> "" And TxtNOKLastName.Text <> "" And Len(TxtNOKPhone.Text) = 14 And TxtNOKAddress.Text <> "" And CboRelation.Text <> "" Then
            cmdContinue.Enabled = True
        Else
            cmdContinue.Enabled = True
        End If

    End Sub


    Private Sub TxtNOKPhone_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtNOKPhone.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        KeyAscii = modMask.PhoneMask(KeyAscii, TxtNOKPhone)

        eventArgs.KeyChar = Chr(KeyAscii)
		If KeyAscii = 0 Then
			eventArgs.Handled = True
		End If
	End Sub
	
	
	Private Sub TxtNOKPhone_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles TxtNOKPhone.Validating
		Dim Cancel As Boolean = eventArgs.Cancel
		'Check to see if there is a contact phone and extention to lookup
		'or if the contact phone or extention has changed.
		If Len(TxtNOKPhone.Text) < 14 And Len(TxtNOKPhone.Text) > 0 Then
			
			'Validate there is a phone number
			Call modMsgForm.FormValidate("Contact Phone #", ActiveControl)
			Cancel = True
			GoTo EventExitSub
		End If
EventExitSub: 
		eventArgs.Cancel = Cancel
	End Sub
End Class