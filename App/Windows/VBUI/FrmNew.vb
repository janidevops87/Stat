Option Strict Off
Option Explicit On
Imports Statline.Stattrac.Windows.CSharpUIMap
Imports Statline.Stattrac.Common
Imports Statline.Stattrac.Constant

Public Class FrmNew
    Inherits System.Windows.Forms.Form

    'Form Variables
    Public vOldTextCboOrganization As String
    Public vOriginalOrgId As Integer
    Public vOriginalSC As String
    Public vOriginalCallType As Short
    Public vNewCallType As Short
    Public HoldCount As Short
    Public HoldCountCboName As Short
    Public vNoteChange As String
    Public vResultArray As Object
    Public vReturn As Short
    Public sc_validation As Boolean
    Public RecycledNC As Boolean
    Public Cancel As Boolean

    Public CallType As Short
    Public CallId As Integer
    Public ReferralId As Integer
    Public ContactLogEventID As Integer '7/11/07 bjk stores the logevenid
    '10/02/02 drh
    Public AuditLogId As Integer
    Public CallComplete As Boolean

    Public LOCallID As Integer
    Public CallNumber As String
    Public fvCallDate As Date
    Public fvCallTotalTime As Date
    Public fvLOCallTotalTime As Date
    Public TimeSnapshot As Date
    Public SortOrder As Short
    Public CallOpenByID As Integer

    Public CallPhoneNumberID As Integer
    Public OrganizationId As Integer
    Public CallerOrganizationID As Integer
    Public CallerOrganizationName As String
    Public CheckCallerOrganizationName As String
    Public CallerNameID As Integer
    Public CallerName As String
    Public CheckCallerName As String
    Public OrganizationName As String
    Public OrganizationTimeZone As String
    Public OrganizationCountyID As Integer
    Public OrganizationStateID As Integer
    Public CallPhoneNumber As String
    Public CallPhoneExtension As String
    Public SubLocationID As Integer
    Public SubLocation As String
    Public SubLocationLevel As String
    Public PersonID As Integer
    Public Person As String
    Public PersonType As String
    Public ChkTemp As String
    Public ChkExclusive As String
    Public MessageTypeID As Integer
    Public OrgPhoneAreaCode As String
    Public OrgPhonePrefix As String
    Public OrgPhoneNumber As String

    Public LastPhone As String
    Public SourceCodeValidationCount As Integer

    Public Saved As Short
    Public FormLoad As Short
    Public FormState As Short
    Public FormInitialLoadComplete As Boolean


    Public CancelClicked As Boolean

    Public CallerOrg As New clsOrganization
    Public SourceCode As New clsSourceCode
    Public ReferralCall As New clsCall
    Public vParentForm As Object
    Private generalConstant As GeneralConstant = generalConstant.CreateInstance()
    '04/2010 bret
    'CboOrganization.SelectedIndexChange will not disable
    'disableCboOrganizationSelectedIndexChange is used to prevent the SelectedIndexChange code from running
    'newCboOrganizationSelectedIndex is to determine if the index value changes. 
    'if the value changes the CboOrganization_SelectedIndexChange is called manually
    'both disableCboOrganizationSelectedIndexChange and newCboOrganizationSelectedIndex are used in CboOrganization_Enter,CboOrganization_SelectedIndexChanged and  CboOrganization_Leave
    Private disableCboOrganizationSelectedIndexChange As Boolean
    Private newCboOrganizationSelectedIndex As Integer
    'move to constants
    Public RTF As String = "{\rtf1"

    Private Sub TxtCallerName_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtCallerName.Leave
        If Me.CallId <= 0 And Me.TxtCallerName.Text > "" Then
            Me.AutoSave()
        End If

        Me.CallerNameID = modControl.GetID(TxtCallerName)
    End Sub

#Region "TxtCallerOrganization"

    Private Sub TxtCallerOrganization_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtCallerOrganization.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        Call modControl.ComboSearch(TxtCallerOrganization, KeyAscii, , 7)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub
    Private Sub TxtCallerOrganization_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtCallerOrganization.Leave
        If Me.CallId <= 0 And Me.TxtCallerOrganization.Text > "" Then
            Me.AutoSave()
        End If


        Me.CallerOrganizationID = modControl.GetID(TxtCallerOrganization)

    End Sub
#End Region
    Private Sub CboCallType_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboCallType.Leave

        If modControl.GetText(CboCallType) = "No Call" Or modControl.GetText(CboCallType) = "Information" Then
            Me.Frame(2).Visible = False
            Me.Frame(1).Visible = False
            Me.Height = 175
            Me.CmdCancel.Top = VB6.TwipsToPixelsY(1485)

        ElseIf modControl.GetText(CboCallType) = "Message/RFI" Or modControl.GetText(CboCallType) = "Import" Then
            Me.CmdChangeSource.Visible = False
            Me.LblLocation(1).Visible = False
            Me.CboOrganization.Visible = False
            Me.CboSubLocation.Visible = False
            Me.TxtLevel.Visible = False
            Me.CboName.Visible = False
            Me.TxtPersonType.Visible = False
            Me.CmdDirectionsNote.Visible = False
            Me.CmdLocationDetail.Visible = False
            Me.CmdNameDetail.Visible = False
            Me.Lable(5).Visible = False
            Me.TxtCallerName.Visible = True

            Me.Lable(4).Text = "Name"
            Me.Lable(4).Size = New System.Drawing.Size(66, 22)
            Me.Lable(4).Location = New System.Drawing.Point(63, 37)

            Me.TxtCallerName.Size = New System.Drawing.Size(226, 22)
            Me.TxtCallerName.Location = New System.Drawing.Point(100, 37)

            Me.Lable(2).Visible = True
            Me.Lable(2).Text = "From"
            Me.Lable(2).Size = New System.Drawing.Size(66, 22)
            Me.Lable(2).Location = New System.Drawing.Point(63, 64)


            Me.CmdReference1.Visible = False
            Me.CmdReference1.Size = New System.Drawing.Size(20, 22)
            Me.CmdReference1.Location = New System.Drawing.Point(325, 37)


            Me.TxtCallerOrganization.Visible = True
            Me.TxtCallerOrganization.Location = New System.Drawing.Point(100, 64)
            Me.TxtCallerOrganization.Size = New System.Drawing.Size(227, 22)

            Me.CmdReference2.Location = New System.Drawing.Point(325, 64)
            Me.CmdReference2.Size = New System.Drawing.Size(20, 22)
            Me.CmdReference2.Visible = True

            Me.TxtSourceCode.TabIndex = 0
            Me.CboCallType.TabIndex = 1
            Me.TxtPhone.TabIndex = 2
            Me.TxtExtension.TabIndex = 3
            Me.TxtCallerName.TabIndex = 4
            Me.TxtCallerName.TabStop = True
            Me.CmdReference1.TabIndex = 5
            Me.TxtCallerOrganization.TabIndex = 6
            Me.TxtCallerOrganization.TabStop = True
            Me.CmdReference2.TabIndex = 7
            Me.CmdReference2.TabIndex = 7
            Me.CmdNew.TabIndex = 8
            Me.CmdCancel.TabIndex = 9

            Me.Frame(2).Visible = True
            Me.Frame(1).Visible = True
            Me.Height = 475 'VB6.TwipsToPixelsY(6640)
            Me.CmdCancel.Top = VB6.TwipsToPixelsY(5760)

        ElseIf modControl.GetText(CboCallType) = "Referral" Then
            Me.TxtCallerName.Visible = False
            Me.TxtCallerOrganization.Visible = False
            Me.CmdReference2.Visible = False
            Me.CmdReference1.Visible = False

            Me.TxtSourceCode.TabIndex = 0
            Me.CboCallType.TabIndex = 1
            Me.TxtPhone.TabIndex = 2
            Me.TxtExtension.TabIndex = 3
            Me.CmdChangeSource.TabIndex = 4
            Me.CboOrganization.TabIndex = 5
            Me.CmdLocationDetail.TabIndex = 6
            Me.CboSubLocation.TabIndex = 7
            Me.TxtLevel.TabIndex = 8
            Me.CmdDirectionsNote.TabIndex = 9
            Me.CboName.TabIndex = 10
            Me.CmdNameDetail.TabIndex = 11
            Me.CmdNew.TabIndex = 12
            Me.CmdCancel.TabIndex = 13

            Me.CmdChangeSource.Text = "Referral Facility"
            Me.CmdChangeSource.Visible = True
            Me.CboOrganization.Visible = True
            Me.CmdLocationDetail.Visible = True

            Me.CmdLocationDetail.Location = New System.Drawing.Point(328, 39)
            Me.CmdLocationDetail.Size = New System.Drawing.Size(20, 21)

            Me.CmdChangeSource.Location = New System.Drawing.Point(3, 37)
            Me.CmdChangeSource.Size = New System.Drawing.Size(94, 24)

            Me.CboOrganization.Location = New System.Drawing.Point(100, 39)
            Me.CboOrganization.Size = New System.Drawing.Size(227, 22)

            Me.Lable(2).Visible = True
            Me.Lable(2).Location = New System.Drawing.Point(33, 70)
            Me.Lable(2).Size = New System.Drawing.Size(66, 14)
            Me.Lable(2).Text = "Hospital Unit"
            Me.CboSubLocation.Visible = True
            Me.CboSubLocation.Location = New System.Drawing.Point(100, 66)
            Me.CboSubLocation.Size = New System.Drawing.Size(167, 22)

            Me.TxtLevel.Visible = True
            Me.TxtLevel.Location = New System.Drawing.Point(270, 66)
            Me.TxtLevel.Size = New System.Drawing.Size(57, 22)

            Me.CmdDirectionsNote.Visible = True
            Me.CmdDirectionsNote.Location = New System.Drawing.Point(328, 66)
            Me.CmdDirectionsNote.Size = New System.Drawing.Size(20, 21)

            Me.Lable(4).Visible = True
            Me.Lable(4).Text = "Referral Person"
            Me.Lable(4).Location = New System.Drawing.Point(16, 96)
            Me.Lable(4).Size = New System.Drawing.Size(83, 14)

            Me.CboName.Visible = True
            Me.CboName.Location = New System.Drawing.Point(100, 93)
            Me.CboName.Size = New System.Drawing.Size(226, 22)

            Me.CmdNameDetail.Visible = True
            Me.CmdNameDetail.Location = New System.Drawing.Point(328, 93)
            Me.CmdNameDetail.Size = New System.Drawing.Size(20, 21)

            Me.Lable(5).Visible = True
            Me.TxtPersonType.Visible = True
            Me.Frame(2).Visible = True
            Me.Frame(1).Visible = True
            Me.Size = New System.Drawing.Size(468, 475)
            Me.CmdCancel.Top = VB6.TwipsToPixelsY(5760)

        Else
            Me.Frame(2).Visible = True
            Me.Frame(1).Visible = True
            Me.Height = VB6.TwipsToPixelsY(6630)
            Me.CmdCancel.Top = VB6.TwipsToPixelsY(5760)
        End If

    End Sub

    Private Sub CboCallType_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboCallType.SelectedIndexChanged

        'Store the OrgSC before the change
        Dim vOrgSC As Integer
        Dim vNewSC As Integer
        vOrgSC = Me.SourceCode.ID

        TxtGreeting.Text = ""
        'SourceCode = Nothing
        'SourceCode = New clsSourceCode

        Call SourceCode.GetItem(, TxtSourceCode.Text, modControl.GetID(CboCallType))

        'Store the original calltype
        vOriginalCallType = Me.CallType

        'Get the call type selected
        Me.CallType = modControl.GetID(CboCallType)
        vNewCallType = Me.CallType

        vNewSC = Me.SourceCode.ID

        'ccarroll 05/18/2011 Need to re-validate the source code if the default call type changes.
        'This also re-loads the organizations for the newly selected source code.
        'Added FormInitialLoadComplete to prevent firing on form load. 
        If Me.FormInitialLoadComplete Then
            If Not ValidateSourceCode() Then
                TxtSourceCode.Focus()
                Exit Sub
            End If
        End If

        'Changed the call type will need to recycle current call and reset all values
        If vOriginalCallType <> Me.CallType And Me.ReferralId > 0 Then

            'recycle call
            If vOriginalCallType = 1 Then
                'Reset calltype and sourcecodeid to original so will save type properly
                Me.CallType = vOriginalCallType
                Me.SourceCode.ID = vOrgSC
                Call modStatSave.SaveCall(Me, Me.CallId)
                'Default the incoming call event
                Me.FormState = NEW_RECORD
                Call modStatSave.SaveLogEvent(Me, , , "REFERRAL")
                Me.FormState = EXISTING_RECORD
                'bret 01/18/2010 not needed
                'Call modStatAudit.AuditReferralSave(Me, AUDIT_CREATE)
                'Call modStatAudit.AuditReferralDelete((Me.CallId), AUDIT_DELETE)
                Call modStatSave.DeleteCall(Me.CallId)
                'Reset calltype to new call type after save
                Me.CallType = vNewCallType
                Me.SourceCode.ID = vNewSC

            ElseIf vOriginalCallType = 2 Then
                'Set default for message screen so the recycle will work
                'when cancel from newcall screen
                'Reset calltype to original so will save type properly
                Me.CallType = vOriginalCallType
                Me.SourceCode.ID = vOrgSC
                Call modStatSave.SaveCall(Me, Me.CallId)
                Me.MessageTypeID = 3
                Call modStatSave.SaveMessage(Me)
                'Default the incoming call event
                Me.FormState = NEW_RECORD
                Call modStatSave.SaveLogEvent(Me, , , "Message/RFI")
                Me.FormState = EXISTING_RECORD
                Call modStatSave.DeleteCall(Me.CallId)
                'Reset calltype to new call type after save
                Me.CallType = vNewCallType
                Me.SourceCode.ID = vNewSC

            ElseIf vOriginalCallType = 4 Then
                'Set default for message screen so the recycle will work
                'when cancel from newcall screen
                'Reset calltype to original so will save type properly
                Me.CallType = vOriginalCallType
                Me.SourceCode.ID = vOrgSC
                Call modStatSave.SaveCall(Me, Me.CallId)
                Me.MessageTypeID = 2
                Call modStatSave.SaveMessage(Me)
                'Default the incoming call event
                Me.FormState = NEW_RECORD
                Call modStatSave.SaveLogEvent(Me, , , "Message/RFI")
                Me.FormState = EXISTING_RECORD
                Call modStatSave.DeleteCall(Me.CallId)
                'Reset calltype to new call type after save
                Me.CallType = vNewCallType
                Me.SourceCode.ID = vNewSC

            End If

            'reset all values
            CallId = 0
            ReferralId = 0
            CallPhoneNumberID = 0
            OrganizationId = 0
            CallerOrganizationID = 0
            CallerNameID = 0
            OrganizationName = ""
            OrganizationTimeZone = ""
            OrganizationCountyID = 0
            OrganizationStateID = 0
            CallPhoneNumber = ""
            CallPhoneExtension = ""
            SubLocationID = 0
            SubLocation = ""
            SubLocationLevel = ""
            PersonID = 0
            Person = ""
            PersonType = ""
            ChkTemp = ""
            ChkExclusive = ""
            MessageTypeID = 0
            Me.Saved = False
            Me.FormLoad = False

            'Reset Referral # and Source code to screen title
            Me.Text = "#    " & Me.SourceCode.Name

        End If



        TxtGreeting.Text = SourceCode.Description

        'Get DefaultAlert
        If Me.SourceCode.DefaultAlert IsNot Nothing Then
            If (Me.SourceCode.DefaultAlert.Contains(RTF)) Then
                Me.TxtDefaultAlert.Rtf = Me.SourceCode.DefaultAlert
            Else
                Me.TxtDefaultAlert.Text = Me.SourceCode.DefaultAlert
            End If
        End If

    End Sub

    Private Sub CboCallType_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboCallType.Enter
        If sc_validation = False Then
            Me.TxtSourceCode.Focus()
        Else
            Me.CboCallType.Focus()
        End If

    End Sub

    Private Sub CboName_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboName.SelectedIndexChanged

        'Get the PersonType of the selected person
        Me.PersonID = modControl.GetID(CboName)
        Call modStatQuery.QueryPersonPersonType(Me)

        'Clear the title if multiple names or no match
        If CboName.SelectedIndex = -1 Then
            TxtPersonType.Text = ""
        End If

    End Sub

    Private Sub CboName_KeyDown(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles CboName.KeyDown
        Dim KeyCode As Short = eventArgs.KeyCode
        Dim Shift As Short = eventArgs.KeyData \ &H10000

        If KeyCode = System.Windows.Forms.Keys.Delete Then
            Call CboName_KeyPress(CboName, New System.Windows.Forms.KeyPressEventArgs(Chr(8)))
        End If

    End Sub
    Private Sub CboName_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles CboName.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        'Allow the delete key to clear the combo box
        If KeyAscii = 8 Then

            Call modControl.AllowDelete(CboName, KeyAscii)

            'Clear the PersonType box
            TxtPersonType.Text = ""
            Me.PersonID = -1

        End If



        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub
    Private Sub CboName_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboName.Leave

        'Get the ID of the selected person
        Me.PersonID = modControl.GetID(CboName)
        Me.CboName.Tag = 1 'T.T 09/22/04 set tag to 1 to not hold cbobox
        Call modControl.HoldControl((Me.CboName)) 'T.T 09/22/04 added to track data erasing
        If Me.PersonID = -1 And Me.TxtPersonType.Text = "" Then
            Me.CboName.BackColor = System.Drawing.Color.Yellow
            Me.TxtPersonType.BackColor = System.Drawing.Color.Yellow
        End If
    End Sub
#Region "ReplacedCode"

#End Region

#Region "CboOrganization"

    Private Sub CboOrganization_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboOrganization.Enter
        vOldTextCboOrganization = Me.CboOrganization.Text

    End Sub
    Private Sub CboOrganization_KeyDown(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles CboOrganization.KeyDown
        Dim KeyCode As Short = eventArgs.KeyCode
        Dim Shift As Short = eventArgs.KeyData \ &H10000
        vOriginalOrgId = Me.OrganizationId
        'Allow the delete key to clear the combo box
        If KeyCode = System.Windows.Forms.Keys.Delete Then
            Call CboOrganization_KeyPress(CboOrganization, New System.Windows.Forms.KeyPressEventArgs(Chr(8)))
        End If
    End Sub

    Private Sub CboOrganization_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles CboOrganization.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        'Allow the delete key to clear the combo box
        Call modControl.AllowDelete(CboOrganization, KeyAscii)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub CboOrganization_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboOrganization.SelectedIndexChanged
        CboOrganizationIndexChange()
    End Sub
    Private Sub CboOrganization_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboOrganization.Leave

        'T.T 09/22/04 added to track data erasing
        If Me.vOldTextCboOrganization <> Me.CboOrganization.Text Then
            HoldCount = HoldCount + 2

            If Me.CboName.Enabled = True Then
                Me.CboName.Tag = HoldCount
                TxtPersonType.Tag = HoldCount
                Call modControl.HoldControl((Me.CboName))
            End If

        End If

    End Sub

    Private Sub CboOrganization_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles CboOrganization.Validating
        Dim Cancel As Boolean = eventArgs.Cancel

        If Me.FormLoad = False Then
            If vOldTextCboOrganization <> CboOrganization.Text Then 'T.T 10/11/2004 added to skip reloading data when org does not change
                'Get the ID of the selected location
                Me.OrganizationId = modControl.GetID(CboOrganization)
                CallerOrg.ID = Me.OrganizationId

                If CallerOrg.ID > 0 Then
                    'Check the properties of the location
                    Call modStatQuery.QueryOrganizationProperties(Me)

                    'Get the county and state ids
                    Call modStatQuery.QueryOrganizationCountyID(Me)

                End If
            End If

        End If


        If Me.OrganizationId > 0 And Me.CallId <= 0 Then
            Me.AutoSave()
        End If

        eventArgs.Cancel = Cancel
    End Sub
    Private Sub CboOrganizationIndexChange()

        Dim count As Short 'T.T 09/22/04 count variable
        On Error GoTo localError

        'FSProj drh 5/3/02 - Store the OrgId before the change

        vOriginalOrgId = Me.OrganizationId

        'Get the ID of the selected location
        Me.OrganizationId = modControl.GetID(CboOrganization)
        Me.OrganizationName = modControl.GetText(CboOrganization)

        'Get the time zone of the organization
        Call modStatQuery.QueryOrganizationTimeZone(Me)

        If Me.FormLoad = False Then

            'First find the county & state of the current referral location
            Call modStatQuery.QueryOrganizationCountyID(Me)
            If Me.vOldTextCboOrganization <> Me.CboOrganization.Text Then
                'Find the names that match the selected location
                Call modStatQuery.QueryLocationPerson(Me)
                Call modStatQuery.QueryLocationApproachPerson(Me)
            End If

            'Clear the title if multiple names or no match
            If CboName.SelectedIndex = -1 Then
                TxtPersonType.Text = ""
            End If

            'Clear the name if multiple locations or no match
            If CboOrganization.SelectedIndex = -1 Then
                Call modControl.SelectNone(CboName)
                Call modControl.SelectNone(CboSubLocation)
            End If
        End If
        Return
localError:
        Resume Next
        Resume
    End Sub
#End Region

    Private Sub CboSubLocation_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboSubLocation.SelectedIndexChanged

        'Get the ID of the selected sublocation
        Me.SubLocationID = modControl.GetID(CboSubLocation)
        Me.SubLocation = modControl.GetText(CboSubLocation)

    End Sub

    Private Sub CboSubLocation_KeyDown(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles CboSubLocation.KeyDown
        Dim KeyCode As Short = eventArgs.KeyCode
        Dim Shift As Short = eventArgs.KeyData \ &H10000

        If KeyCode = System.Windows.Forms.Keys.Delete Then
            Call CboSubLocation_KeyPress(CboSubLocation, New System.Windows.Forms.KeyPressEventArgs(Chr(8)))
        End If

    End Sub

    Private Sub CboSubLocation_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboSubLocation.Leave

        'Get the ID of the selected sublocation
        Me.SubLocationID = modControl.GetID(CboSubLocation)
        Me.SubLocation = modControl.GetText(CboSubLocation)

    End Sub

    Private Sub CmdCancel_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdCancel.Click

        'Get the ID of the location before the user cancelled so that if they
        'select modify on referral screen the orgid associated with the referral
        'populates new call correctly.
        CancelClicked = True

        If Me.Name = "FrmReferral" Then
            If Me.OrganizationId <> vOriginalOrgId Then
                Me.OrganizationId = vOriginalOrgId
            End If
        End If

        If TxtPhone.Text.Length < 14 Then
            TxtPhone.Text = ""
        End If

        If Me.TxtSourceCode.Text = "" And Me.OrganizationId = 0 Then
            Me.Close()
            Exit Sub 'allow exit they didn't enter any data
        ElseIf ValidateSourceCode() = True And Me.OrganizationId = 0 And Me.CallType = 1 Then
            Me.Close()
            Exit Sub
        End If
        If ValidateSourceCode() = False Then
            Exit Sub
        End If

        If Me.CallType = 1 Then
            If Me.OrganizationId <= 0 Then
                Call modMsgForm.FormValidate("Location", Me.CboOrganization)
                Call modUtility.Done()
                Exit Sub
            End If
        ElseIf Me.CallType = 2 Or Me.CallType = 4 Then
            If Me.CallId <= 0 Then
                'bret 6/30/07 8.4.3.9 set the CallOpenByID = to -1
                'The user has clicked cancel, the call will be closed so they are no longer in the case
                Me.CallOpenByID = -1
                AutoSave()
            End If
        End If

        Me.Close()

    End Sub

    Private Sub CboSubLocation_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles CboSubLocation.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        'Allow the delete key to clear the combo box
        Call modControl.AllowDelete(CboSubLocation, KeyAscii)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub CmdChangeSource_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdChangeSource.Click

        Dim vReturn As String = ""

        vReturn = InputBox("Please select a new source code.", "Change Source Code", Me.SourceCode.Name).Trim()

        If vReturn <> "" Then
            'set the text field to entered source code
            Me.TxtSourceCode.Text = UCase(vReturn)
        End If

        Dim vOriginalSC As Integer
        If vReturn <> "" Then

            'FSProj drh 5/3/02 - Store the OrgId before the change
            vOriginalSC = Me.SourceCode.ID

            'validate the source code entered
            If Not ValidateSourceCode() Then
                Exit Sub
            End If

            Me.SourceCode = Nothing
            Me.SourceCode = New clsSourceCode()
            Call Me.SourceCode.GetItem(, vReturn, REFERRAL)

            'FSProj drh 5/3/02 - If SC is different, reset the ServiceLevel and Criteria
            If Me.SourceCode.ID <> vOriginalSC Then
                Me.TxtSourceCode.Text = UCase(vReturn)
                TxtGreeting.Text = SourceCode.Description

                'Get DefaultAlert
                If Me.SourceCode.DefaultAlert IsNot Nothing Then
                    If (Me.SourceCode.DefaultAlert.Contains(RTF)) Then
                        Me.TxtDefaultAlert.Rtf = Me.SourceCode.DefaultAlert
                    Else
                        Me.TxtDefaultAlert.Text = Me.SourceCode.DefaultAlert
                    End If
                End If


            End If

            'Get only the organizations associated with the lookup code.
            'Lookup code associations are created using the alert screen.
            Call Me.SourceCode.Organizations.GetItems()
            Call Me.SourceCode.Organizations.FillListBox(CboOrganization)


            'Set the combo box
            Call modControl.SelectID((Me.CboOrganization), Me.OrganizationId)

            '10/14/02 drh - Set the alerts & service level
            If Me.vOldTextCboOrganization <> Me.CboOrganization.Text Then
                Call CboOrganization_Validating(CboOrganization, New System.ComponentModel.CancelEventArgs(False))
            End If

            Call modControl.SelectID((Me.CboName), Me.PersonID)
            Me.Activate()
        End If
    End Sub
    Private Sub CmdDirectionsNote_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdDirectionsNote.Click


        Dim vLogEventID As Integer
        Dim vReturn As New Object
        Dim I As Short
        Dim vEventTypeList(0) As Object
        Dim vSubItemsList As New Object
        Dim frmLogEvent As New FrmLogEvent

        On Error Resume Next

        'Set the correct LogEvent state
        frmLogEvent.FormState = NEW_RECORD

        'Set the call id and number of the Details form
        frmLogEvent.CallId = Me.CallId
        frmLogEvent.CallNumber = Me.CallNumber

        'Default fields
        frmLogEvent.DefaultContactType = GENERAL

        'Set the call number of the Details form
        frmLogEvent.CallNumber = Me.CallNumber

        'confirm the initial call was created
        Call CreateDefaultIncomingCall()

        'Set event types
        vEventTypeList(0) = GENERAL
        frmLogEvent.LogEventTypeList = VB6.CopyArray(vEventTypeList)

        '10/22/01 drh
        frmLogEvent.vParentForm = Me

        'Get the Details id from the Details form
        'after the user is done.
        Me.SendToBack()
        Call frmLogEvent.Display()
        frmLogEvent.Close()

        'Clear events and refresh
        'FrmReferral.LstViewLogEvent.Items.Clear
        'Call modStatQuery.QueryOpenLogEvent(FrmReferral)

    End Sub


    Private Sub CmdLocationDetail_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdLocationDetail.Click

        Dim uIMap As UIMap = OpenStatTracCSharpForms.CreateInstance()
        'bret 01/26/2011 set the SourceCodeID
        generalConstant.CreateInstance().SourceCodeId = Me.SourceCode.ID
        generalConstant.CreateInstance().SourceCodeName = TxtSourceCode.Text
        Me.OrganizationId = uIMap.Open(AppScreenType.OrganizationsOrganizationEditPopup, Me.OrganizationId)
        'bret 01/26/2011 reset the 
        generalConstant.CreateInstance().SourceCodeId = Int32.MinValue
        generalConstant.CreateInstance().SourceCodeName = ""

        CallerOrg.ID = Me.OrganizationId

        If Me.OrganizationId = 0 Then
            'The user cancelled adding a new organization
            'so do nothing
        Else
            'Refill the location combo box with the new (or updated)
            'organization id and name
            'Get all the organizations that have a central phone number
            'area code that matches the entered area code
            Call Me.SourceCode.Organizations.GetItems()
            Call Me.SourceCode.Organizations.FillListBox(CboOrganization)

            'Get the organization name
            Dim vResultArray As New Object
            Call modStatRefQuery.RefQueryOrganization(vResultArray, Me.OrganizationId)
            'Set the Location combo box
            Call modControl.SetTextID((Me.CboOrganization), vResultArray, True)


            'Changed 07/2001 BJK: Moved 6 lines of text down 3 lines of code.
            ' Call Me.ServiceLevel was resetting CboPhysician
            'Reset Values
            Call modControl.SelectID(CboOrganization, Me.OrganizationId)

            '10/14/02 drh - Set the alerts & service level
            Call CboOrganization_Validating(CboOrganization, New System.ComponentModel.CancelEventArgs(False))

            Call modControl.SelectID(CboName, Me.PersonID)
            Call modControl.SelectID(CboSubLocation, Me.SubLocationID)

        End If

    End Sub

    Private Sub cmdNameDetail_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdNameDetail.Click


        Dim uIMap As UIMap = OpenStatTracCSharpForms.CreateInstance()
        'bret 01/26/2011 set the SourceCodeID
        generalConstant.CreateInstance().SourceCodeId = Me.SourceCode.ID
        generalConstant.CreateInstance().OrganizationId = Me.OrganizationId
        Me.PersonID = (modControl.GetID(CboName))
        Me.PersonID = uIMap.Open(AppScreenType.OrganizationsOrganizationContactsContactPropertiesEditPopup, Me.PersonID)
        'bret 01/26/2011 reset the 
        generalConstant.CreateInstance().SourceCodeId = Int32.MinValue


        If Me.PersonID = 0 Then
            'The user cancelled adding a new Person
            'so do nothing
        Else
            'Refill the combo boxes with the new (or updated) names
            Call modStatQuery.QueryLocationPerson(Me)
            Call modControl.SelectID(CboName, Me.PersonID)
            Me.CboName.BackColor = System.Drawing.Color.White
            Me.TxtPersonType.BackColor = System.Drawing.Color.White
        End If

    End Sub

    Private Sub CmdNew_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdNew.Click

        'Add error handler in-case we reach an error in saving a referral/call/message
        On Error GoTo handleError

        'Check to see if the souced code is valid. If it is not cancel this command by exiting the function
        If Not ValidateSourceCode() Then
            TxtSourceCode.Focus()
            Exit Sub
        End If

        Call modUtility.Work()

        If modControl.GetText(CboCallType) = "Referral" Then

            If modControl.GetID((Me.CboOrganization)) = -1 Then
                Call modMsgForm.FormValidate("Location", Me.CboOrganization)
                Call modUtility.Done()
                Exit Sub
            Else
                'ccarroll 02/05/2009 - added autosave to get CallID if it does not exist
                If Me.CallId <= 0 Then
                    AutoSave()
                End If
            End If


            'ccarroll 02/05/2009 - added additional check: Or modControl.GetID(Me.CboName) = -1
            If System.Drawing.ColorTranslator.ToOle(Me.CboName.BackColor) = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.Yellow) Or modControl.GetID((Me.CboName)) = -1 Then
                'Me.CboName.BackColor = vbYellow
                Call modMsgForm.FormValidate("Referral Person", Me.CboName)
                Call modUtility.Done()
                Exit Sub
            End If
            'rese values
            Me.OrganizationId = modControl.GetID((Me.CboOrganization))
            Me.SubLocationID = modControl.GetID((Me.CboSubLocation))
            Me.SubLocationLevel = Me.TxtLevel.Text

            modStatSave.SaveOrganizationPhone(Me.OrganizationId, Me.SubLocationID, Me.SubLocationLevel, Me.TxtPhone.Text)
            modStatSave.SaveReferral(Me)
        ElseIf modControl.GetText(CboCallType) = "Message/RFI" Or modControl.GetText(CboCallType) = "Import" Then
            If modControl.GetID((Me.TxtCallerOrganization)) = -1 And Trim(Me.TxtCallerOrganization.Text) = "" Then
                Call modMsgForm.FormValidate("From", Me.TxtCallerOrganization)
                Call modUtility.Done()
                Exit Sub
            End If

            If modControl.GetID((Me.TxtCallerName)) = -1 And Trim(Me.TxtCallerName.Text) = "" Then
                Call modMsgForm.FormValidate("Name", Me.TxtCallerName)
                Call modUtility.Done()
                Exit Sub
            End If

            If Me.TxtPhone.Text = "" Then
                Call modMsgForm.FormValidate("Phone", Me.TxtPhone.Text)
                Call modUtility.Done()
                Exit Sub
            End If

            If Me.CallId <= 0 Then
                AutoSave()
            End If

        End If

        'ccarroll 08/10/2010 added check to see if SourceCode has changed. During normal process,
        'the source code will be validated twice. Once when entered and once when the cmdNew button is pressed.
        'If the user changes the source code the new source code value will now be recorded in audit trail.
        'HS 24561, WI 7661
        If Me.SourceCodeValidationCount > 2 Then
            modStatSave.SaveCall(Me, Me.CallId)
        End If

        If CmdNew.Text = "&Save" Then

            If System.Drawing.ColorTranslator.ToOle(Me.CboName.BackColor) = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.Yellow) Then
                MsgBox("Please fill out the Name field", MsgBoxStyle.Information, "System Message")
                Call modUtility.Done()
                Exit Sub
            End If

            Me.Saved = True

            Select Case modControl.GetText(CboCallType)
                Case "Referral"

                    vParentForm.OrganizationId = Me.OrganizationId
                    vParentForm.LblOrganization.Text = Me.OrganizationName
                    vParentForm.LblPhone.Text = Me.TxtPhone.Text
                    vParentForm.LblExtension.Text = Me.TxtExtension.Text
                    vParentForm.SubLocationID = Me.SubLocationID
                    vParentForm.LblSubLocation.Text = Me.CboSubLocation.Text
                    vParentForm.SubLocationLevel = Me.TxtLevel.Text
                    vParentForm.LblLevel.Text = Me.TxtLevel.Text
                    vParentForm.PersonID = Me.PersonID
                    vParentForm.SourceCode.ID = Me.SourceCode.ID
                    vParentForm.LblName.Text = Me.CboName.Text
                    vParentForm.SourceCode.Name = Me.TxtSourceCode.Text
                    vParentForm.LblPersonType.Text = Me.TxtPersonType.Text
                    If vParentForm.vOriginalOrgId <> vParentForm.OrganizationId Or vParentForm.vOriginalSC <> vParentForm.SourceCode.ID Then
                        vParentForm.CallerOrg.ID = vParentForm.OrganizationId

                        Call modStatQuery.QueryOrganizationAlert(vParentForm)

                        'reset servicelevel since new org or new source code
                        vParentForm.ServiceLevelId = 0
                        'Set New Organization
                        Call vParentForm.SetOrganization()

                        Call vParentForm.SetServiceLevel(vParentForm)

                        If vParentForm.vOriginalVent = False Then

                            'Repopulate list with only "Never" and "Current"
                            vParentForm.CboVent.Items.Add(New ValueDescriptionPair(2, "Currently"))
                            vParentForm.CboVent.Items.Add(New ValueDescriptionPair(0, "Never"))
                            If vParentForm.CallerOrg.ServiceLevel.ExcludePrevVent = False Then
                                vParentForm.CboVent.Items.Add(New ValueDescriptionPair(1, "Previously"))
                            End If

                            vParentForm.CboVent.Text = "Currently"
                            vParentForm.CboVentChanged = False
                            vParentForm.CboVent.BackColor = System.Drawing.Color.Yellow '&HFFFF&
                        End If

                        If vParentForm.vOriginalHB = False And vParentForm.CboHeartBeat.Enabled = True And vParentForm.FormState = EXISTING_RECORD Then


                            vParentForm.CboHeartBeat.Items.Add(New ValueDescriptionPair(1, "Yes"))
                            vParentForm.CboHeartBeat.Items.Add(New ValueDescriptionPair(0, "No"))


                            vParentForm.CboHeartBeat.Text = "Yes"
                            vParentForm.CboHeartBeatChanged = False
                            vParentForm.CboHeartBeat.BackColor = System.Drawing.Color.Yellow
                        Else
                            If vParentForm.CboHeartBeat.Text = "" Then
                                vParentForm.CboHeartBeat.Text = "Yes"
                                vParentForm.CboHeartBeatChanged = False
                                vParentForm.CboHeartBeat.BackColor = System.Drawing.Color.Yellow
                            End If
                        End If

                        vParentForm.HoldCount = vParentForm.HoldCount + 2
                        If vParentForm.CboPhysician(0).Enabled = True Then
                            vParentForm.CboPhysician(0).Tag = HoldCount
                            Call modControl.HoldControl(vParentForm.CboPhysician(0))
                        End If

                        If vParentForm.CboPhysician(1).Enabled = True Then
                            vParentForm.CboPhysician(1).Tag = HoldCount
                            Call modControl.HoldControl(vParentForm.CboPhysician(1))
                        End If

                        If vParentForm.CboApproachedBy.Enabled = True Then
                            vParentForm.CboApproachedBy.Tag = HoldCount
                            Call modControl.HoldControl((vParentForm.CboApproachedBy))
                        End If



                    End If
                    AppMain.frmNew = Nothing
                    'Update changes to forms title bar
                    vParentForm.UpdateFormCaption()

                    vParentForm.CboHeartBeat.Focus()


                Case "Message/RFI", "IMPORT"
                    vParentForm.OrganizationId = Me.OrganizationId
                    vParentForm.CallerOrganizationID = Me.CallerOrganizationID
                    vParentForm.LblOrganization.Text = Me.TxtCallerOrganization.Text
                    vParentForm.LblPhone.Text = Me.TxtPhone.Text
                    vParentForm.LblExtension.Text = Me.TxtExtension.Text
                    vParentForm.PersonID = Me.PersonID
                    vParentForm.SourceCode.ID = Me.SourceCode.ID
                    'ccarroll 05/19/2011 Added CallType
                    vParentForm.CallType = Me.CallType
                    vParentForm.LblName.Text = Me.TxtCallerName.Text
                    vParentForm.SourceCode.Name = Me.TxtSourceCode.Text

                    If vParentForm.vOriginalOrgId <> vParentForm.CallerOrganizationID Then
                        vParentForm.CallerOrg.ID = vParentForm.CallerOrganizationID

                    End If

                    vParentForm.CboMessageType.Focus()

            End Select


            Call modUtility.Done()

            Me.Close()

            Exit Sub

        End If

        Select Case modControl.GetID(CboCallType)

            Case REFERRAL
                If Not modUtility.ChkOpenForm("AppMain.frmReferral") Then
                    AppMain.frmReferral = New FrmReferral()


                    AppMain.frmReferral.AlertType = REFERRAL
                    AppMain.frmReferral.FormState = NEW_RECORD
                    AppMain.frmReferral.OrganizationId = Me.OrganizationId
                    AppMain.frmReferral.OrganizationName = Me.OrganizationName
                    AppMain.frmReferral.CallPhoneNumber = Me.TxtPhone.Text
                    AppMain.frmReferral.CallPhoneExtension = Me.TxtExtension.Text
                    AppMain.frmReferral.SubLocationID = Me.SubLocationID
                    AppMain.frmReferral.SubLocation = Me.CboSubLocation.Text
                    AppMain.frmReferral.SubLocationLevel = Me.TxtLevel.Text
                    AppMain.frmReferral.PersonID = Me.PersonID
                    AppMain.frmReferral.Person = Me.CboName.Text
                    AppMain.frmReferral.PersonType = Me.TxtPersonType.Text
                    AppMain.frmReferral.CallId = Me.CallId
                    AppMain.frmReferral.CallNumber = Me.CallNumber
                    AppMain.frmReferral.AuditLogId = Me.CallId
                    AppMain.frmReferral.CallTotalTime = Me.TxtTotalTimeCounter.Text
                    AppMain.frmReferral.ReferralId = Me.ReferralId
                    Call AppMain.frmReferral.SourceCode.GetItem(, Me.TxtSourceCode.Text, REFERRAL)
                    Me.Saved = True
                    Me.Close()
                    AppMain.frmReferral.TabDonor.SelectedIndex = 0
                    AppMain.frmReferral.Show()
                    If AppMain.frmReferral.CboHeartBeat.Enabled = True Then
                        AppMain.frmReferral.CboHeartBeat.Focus()
                    Else
                        AppMain.frmReferral.TxtDonorLastName.Focus()
                    End If

                End If
            Case Message
                If Not modUtility.ChkOpenForm("AppMain.frmMessage") Then
                    AppMain.frmMessage = New FrmMessage()

                    AppMain.frmMessage.AlertType = Message
                    AppMain.frmMessage.FormState = NEW_RECORD
                    AppMain.frmMessage.MessageCallerOrganization = Me.TxtCallerOrganization.Text
                    AppMain.frmMessage.CallerOrganizationID = Me.CallerOrganizationID
                    AppMain.frmMessage.CallerNameID = Me.CallerNameID
                    AppMain.frmMessage.CallNumber = Me.CallNumber
                    AppMain.frmMessage.CallPhoneNumber = Me.TxtPhone.Text
                    AppMain.frmMessage.CallPhoneExtension = Me.TxtExtension.Text
                    AppMain.frmMessage.PersonID = Me.PersonID
                    AppMain.frmMessage.Person = Me.TxtCallerName.Text
                    AppMain.frmMessage.PersonType = Me.TxtPersonType.Text
                    AppMain.frmMessage.CallId = Me.CallId
                    AppMain.frmMessage.AuditLogId = Me.CallId
                    AppMain.frmMessage.CallTotalTime = Me.TxtTotalTimeCounter.Text
                    AppMain.frmMessage.ReferralId = Me.ReferralId
                    AppMain.frmMessage.CallType = Me.CallType
                    Call AppMain.frmMessage.SourceCode.GetItem(, Me.TxtSourceCode.Text, Message)
                    Me.Saved = True
                    Me.Close()

                    AppMain.frmMessage.Show()
                    AppMain.frmMessage.TabMessage.SelectedIndex = 0
                End If
            Case IMPORT
                If Not modUtility.ChkOpenForm("AppMain.frmMessage") Then
                    AppMain.frmMessage = New FrmMessage()

                    AppMain.frmMessage.AlertType = IMPORT
                    AppMain.frmMessage.FormState = NEW_RECORD
                    AppMain.frmMessage.MessageCallerOrganization = Me.TxtCallerOrganization.Text
                    AppMain.frmMessage.CallerOrganizationID = Me.CallerOrganizationID
                    AppMain.frmMessage.CallerNameID = Me.CallerNameID
                    AppMain.frmMessage.CallNumber = Me.CallNumber
                    AppMain.frmMessage.CallPhoneNumber = Me.TxtPhone.Text
                    AppMain.frmMessage.CallPhoneExtension = Me.TxtExtension.Text
                    AppMain.frmMessage.PersonID = Me.PersonID
                    AppMain.frmMessage.Person = Me.TxtCallerName.Text
                    AppMain.frmMessage.PersonType = Me.TxtPersonType.Text
                    AppMain.frmMessage.CallId = Me.CallId
                    AppMain.frmMessage.AuditLogId = Me.CallId
                    AppMain.frmMessage.CallTotalTime = Me.TxtTotalTimeCounter.Text
                    AppMain.frmMessage.ReferralId = Me.ReferralId
                    AppMain.frmMessage.CallType = Me.CallType
                    Call AppMain.frmMessage.SourceCode.GetItem(, Me.TxtSourceCode.Text, IMPORT)
                    Me.Saved = True
                    Me.Close()
                    AppMain.frmMessage.Show()
                    AppMain.frmMessage.TabMessage.SelectedIndex = 0

                End If
            Case NOCALL
                If Not modUtility.ChkOpenForm("Appmain.frmNoCall") Then
                    AppMain.frmNoCall = New FrmNoCall()
                    AppMain.frmNoCall.FormState = NEW_RECORD
                    Call AppMain.frmNoCall.SourceCode.GetItem(, Me.TxtSourceCode.Text, Message)
                    Call AppMain.frmNoCall.Display()
                    Me.Close()
                End If
                'mds 10/13/03: added case for INFORMATION call types
                'This form is Not longer used
                '' ''Case INFORMATION_Renamed
                '' ''    If Not modUtility.ChkOpenForm("FrmCoalitionOnDonation") Then
                '' ''        FrmCoalitionOnDonation.AlertType = INFORMATION_Renamed
                '' ''        FrmCoalitionOnDonation.FormState = NEW_RECORD
                '' ''        Call FrmCoalitionOnDonation.SourceCode.GetItem(, Me.TxtSourceCode.Text, INFORMATION_Renamed)
                '' ''        Me.Close()
                '' ''        FrmCoalitionOnDonation.Show()
                '' ''    End If

        End Select

        Call modUtility.Done()
        Exit Sub ' Exit to avoid error handler



        'Handle any errors found when attempting to save a referral/call/message
handleError:

        'Log a detailed message when an attempt to save a referral/call/message fails
        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err(), "(saving a referral/call/message)")
        Resume Next
        Resume

    End Sub

    Private Sub CmdReference1_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdReference1.Click
        Dim vReferenceID As Integer
        Dim frmReference As New FrmReference

        On Error Resume Next

        'Determine the form state which to open the
        'Reference form.
        If modControl.GetID(TxtCallerName) = -1 Then
            frmReference.FormState = NEW_RECORD
            frmReference.ReferenceID = 0
        Else
            frmReference.FormState = EXISTING_RECORD
            frmReference.ReferenceID = modControl.GetID(TxtCallerName)
        End If

        'Set the type of the Reference form
        frmReference.ReferenceTypeID = REF_MSG_NAME

        'Get the Reference id from the Reference form
        'after the user is done.

        Me.SendToBack()
        vReferenceID = frmReference.Display
        Me.BringToFront()


        frmReference.Close()
    End Sub

    Private Sub CmdReference2_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdReference2.Click
        Dim vReferenceID As Integer
        Dim frmReference As New FrmReference
        On Error Resume Next

        'Determine the form state which to open the
        'Reference form.
        If modControl.GetID(TxtCallerOrganization) = -1 Then
            frmReference.FormState = NEW_RECORD
            frmReference.ReferenceID = 0
        Else
            frmReference.FormState = EXISTING_RECORD
            frmReference.ReferenceID = modControl.GetID(TxtCallerOrganization)
        End If

        'Set the type of the Reference form
        frmReference.ReferenceTypeID = REF_MSG_ORG

        'Get the Reference id from the Reference form
        'after the user is done.
        Me.SendToBack()
        vReferenceID = frmReference.Display
        Me.BringToFront()

        If vReferenceID = 0 Then
            'The user cancelled adding a new Reference
            'so do nothing
        Else
            'Refill the combo boxes with the new (or updated) References
            Call modStatRefQuery.ListRefQueryReference(TxtCallerOrganization, REF_MSG_ORG)
            Call modControl.SelectID(TxtCallerOrganization, vReferenceID)
        End If
        frmReference.Close()
    End Sub

    Private Sub FrmNew_Activated(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Activated
        Me.FrameTimer.Enabled = True

        Call TimerTotalTime_Tick(TimerTotalTime, New System.EventArgs())
        Me.FormInitialLoadComplete = True
    End Sub

    Private Sub FrmNew_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load

        Call modUtility.CenterForm()

        If Me.SourceCode.ID = 0 Then
            Call modControl.SelectID(CboCallType, REFERRAL)
            'BRET 03/08/11
            'CHECK FOR AutoDispalySourcecode.
            If generalConstant.AutoDisplaySourceCode.Trim().Length > 0 Then
                TxtSourceCode.Text = generalConstant.AutoDisplaySourceCode.Trim()
            End If
        End If

        'CancelClicked = False


        Me.Saved = False
        Me.FormLoad = False
        CallComplete = False

        'The Contact information is disabled on load until a
        'valid source code is entered
        If (TxtSourceCode.Text = "") Then
            Me.TxtPhone.Enabled = False
            Me.TxtExtension.Enabled = False
            Me.CboOrganization.Enabled = False
            Me.CboSubLocation.Enabled = False
            Me.TxtLevel.Enabled = False
            Me.CboName.Enabled = False
            Me.TxtPersonType.Enabled = False
            Me.CmdChangeSource.Enabled = False
            Me.CmdLocationDetail.Enabled = False
            Me.CmdDirectionsNote.Enabled = False
            Me.CmdNameDetail.Enabled = False
            Me.ChkTemp = CStr(0)
            Me.ChkExclusive = CStr(0)
        End If
        'mds 11/13/03 Added to prevent Information type from being displayed
        If AppMain.ParentForm.LeaseOrganization <> 0 Then
            CboCallType.Items.RemoveAt((1))
        End If

        'Fill all reference data
        Call modStatRefQuery.ListRefQuerySubLocation(CboSubLocation)

        'Set the Sub Location combo box
        Call modControl.SelectID((CboSubLocation), SubLocationID)


        'Get only the organizations associated with the lookup code.
        'Lookup code associations are created using the alert screen.
        Call Me.SourceCode.Organizations.GetItems()
        Call Me.SourceCode.Organizations.FillListBox(CboOrganization)
        Call modControl.SelectID(CboOrganization, OrganizationId)
        Call modControl.SelectID(CboName, PersonID)

        'Bret 08/24/10
        Me.TimeSnapshot = Now

        'SET THE START CONTROL
        If TxtSourceCode.Visible Then
            TxtSourceCode.Select()
        Else
            TxtPhone.Select()
        End If
        If generalConstant.AutoDisplaySourceCode.Trim().Length > 0 And Me.SourceCode.ID Then
            CboCallType.Select()
        End If

    End Sub
    Public Function Display() As Integer

        If modControl.GetText(CboCallType) = "No Call" Or modControl.GetText(CboCallType) = "Information" Then
            Me.Frame(2).Visible = False
            Me.Frame(1).Visible = False
            Me.Height = VB6.TwipsToPixelsY(2485)
            Me.CmdCancel.Top = VB6.TwipsToPixelsY(1485)
            If (Me.Visible = False) Then
                Me.ShowDialog()
            End If
        ElseIf modControl.GetText(CboCallType) = "Message/RFI" Or modControl.GetText(CboCallType) = "Import" Then
            If Me.OrganizationId = 0 And Me.CallerName = "" And Me.CallId = 0 Then
                If (Me.Visible = False) Then
                    Me.ShowDialog()
                End If
            Else
                Me.Frame(0).Visible = False
                Me.Height = 350 'VB6.TwipsToPixelsY(6640)
                Me.Frame(2).Top = Me.Frame(0).Top
                Me.Frame(1).Top = VB6.TwipsToPixelsY(1890)
                Me.CmdNew.Location = New Point(375, 10)
                Me.CmdNew.TabIndex = 0

                Me.CmdCancel.Location = New Point(375, 285)

                Me.CmdNew.Text = "&Save"
                Me.Text = "Caller Organization Information"
                Me.CmdChangeSource.Visible = False
                Me.LblLocation(1).Visible = False
                Me.CboOrganization.Visible = False
                Me.CboSubLocation.Visible = False
                Me.TxtLevel.Visible = False
                Me.CboName.Visible = False
                Me.TxtPersonType.Visible = False
                Me.CmdDirectionsNote.Visible = False
                Me.CmdLocationDetail.Visible = False
                Me.CmdNameDetail.Visible = False
                Me.Lable(5).Visible = False
                Me.FrameTimer.Enabled = False
                Me.FrameTimer.Visible = False
                Me.LblReferral(28).Enabled = False
                Me.LblReferral(28).Visible = False
                Me.TxtTotalTimeCounter.Enabled = False
                Me.TxtTotalTimeCounter.Visible = False

                Me.TxtPhone.Visible = True
                Me.TxtPhone.Enabled = True
                Me.TxtExtension.Visible = True
                Me.TxtExtension.Enabled = True
                Me.TxtCallerName.Visible = True

                Me.Lable(4).Text = "Name"
                Me.Lable(4).Size = New System.Drawing.Size(66, 24)
                Me.Lable(4).Location = New System.Drawing.Point(60, 37)

                Me.TxtCallerName.Location = New System.Drawing.Point(100, 37)
                Me.TxtCallerName.Size = New System.Drawing.Size(226, 22)
                Me.TxtCallerName.TabIndex = 6

                Me.CmdReference1.Visible = False
                Me.CmdReference1.Location = New System.Drawing.Point(327, 37)
                Me.CmdReference1.Size = New System.Drawing.Size(20, 21)
                Me.CmdReference1.TabIndex = 7

                Me.Lable(2).Visible = True
                Me.Lable(2).Text = "From"
                Me.Lable(2).Size = New System.Drawing.Size(66, 24)
                Me.Lable(2).Location = New System.Drawing.Point(60, 70)

                Me.TxtCallerOrganization.Location = New System.Drawing.Point(100, 65)
                Me.TxtCallerOrganization.Size = New System.Drawing.Size(227, 22)
                Me.TxtCallerOrganization.Visible = True

                Me.TxtCallerOrganization.TabIndex = 8
                Me.CmdReference2.Location = New System.Drawing.Point(327, 65)
                Me.CmdReference2.Size = New System.Drawing.Size(20, 21)
                Me.CmdReference2.TabIndex = 9
                Me.CmdReference2.Visible = True
                Me.TxtSourceCode.Text = Me.SourceCode.Name

                Me.TxtSourceCode.TabIndex = 0
                Me.CboCallType.TabIndex = 1
                Me.TxtPhone.TabIndex = 2
                Me.TxtExtension.TabIndex = 3
                Me.TxtCallerName.TabIndex = 4
                Me.TxtCallerName.TabStop = True
                Me.CmdReference1.TabIndex = 5
                Me.TxtCallerOrganization.TabIndex = 6
                Me.TxtCallerOrganization.TabStop = True
                Me.CmdReference2.TabIndex = 7
                Me.CmdReference2.TabIndex = 7
                Me.CmdNew.TabIndex = 8
                Me.CmdCancel.TabIndex = 9


                Call SourceCode.GetItem(, TxtSourceCode.Text, modControl.GetID(CboCallType))

                'Get DefaultAlert
                If Me.SourceCode.DefaultAlert IsNot Nothing Then
                    If (Me.SourceCode.DefaultAlert.Contains(RTF)) Then
                        Me.TxtDefaultAlert.Rtf = Me.SourceCode.DefaultAlert
                    Else
                        Me.TxtDefaultAlert.Text = Me.SourceCode.DefaultAlert
                    End If
                End If


                'Set callerorgid
                If Me.CallerOrganizationID > 0 Then
                    Call modControl.SelectID((Me.TxtCallerOrganization), Me.CallerOrganizationID)
                Else
                    Me.TxtCallerOrganization.Text = Me.CallerOrganizationName
                End If
                Me.TxtCallerName.Text = Me.CallerName

                If (Me.Visible = False) Then
                    Me.ShowDialog()
                End If
                Display = Me.CallerOrganizationID

            End If

        ElseIf modControl.GetText(CboCallType) = "Referral" Or modControl.GetText(CboCallType) = "" Then
            If Me.OrganizationId = 0 And Me.TxtPhone.Text = "" Then
                If (Me.Visible = False) Then
                    Me.ShowDialog()
                End If

            Else
                Me.Frame(0).Visible = False
                Me.FrameTimer.Enabled = False
                Me.FrameTimer.Visible = False
                Me.LblReferral(28).Enabled = False
                Me.LblReferral(28).Visible = False
                Me.TxtTotalTimeCounter.Enabled = False
                Me.TxtTotalTimeCounter.Visible = False
                Me.Height = 350
                Me.Frame(2).Top = Me.Frame(0).Top
                Me.Frame(1).Top = VB6.TwipsToPixelsY(1890)

                Me.CmdNew.Location = New System.Drawing.Point(378, 8)

                'Me.CmdNew.TabIndex = 0
                Me.CmdCancel.Location = New System.Drawing.Point(375, 285)

                Me.CmdNew.Text = "&Save"
                Me.Text = "Referral Facility Information"
                Me.TxtPhone.Enabled = True
                Me.TxtExtension.Enabled = True
                Me.CboOrganization.Enabled = True
                Me.CboSubLocation.Enabled = True
                Me.TxtLevel.Enabled = True
                Me.CboName.Enabled = True
                Me.TxtPersonType.Enabled = True
                Me.CmdChangeSource.Enabled = True
                Me.CmdLocationDetail.Enabled = True
                Me.CmdDirectionsNote.Enabled = True
                Me.CmdNameDetail.Enabled = True
                Me.TxtSourceCode.Text = Me.SourceCode.Name

                Call SourceCode.GetItem(, TxtSourceCode.Text, modControl.GetID(CboCallType))

                'Get DefaultAlert
                If Me.SourceCode.DefaultAlert IsNot Nothing Then
                    If (Me.SourceCode.DefaultAlert.Contains(RTF)) Then
                        Me.TxtDefaultAlert.Rtf = Me.SourceCode.DefaultAlert
                    Else
                        Me.TxtDefaultAlert.Text = Me.SourceCode.DefaultAlert
                    End If
                End If



                If (Me.Visible = False) Then
                    Me.ShowDialog()
                End If
                Display = Me.OrganizationId
            End If
        End If


    End Function

    Private Sub FrmNew_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing
        '************************************************************************************
        'Name: Form_Unload
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: closes out the New Form
        '
        '====================================================================================
        'Date Changed: 05/16/05                       Changed by: Char Chaput
        'Release #:                                   Task: Unknown
        'Description:   Modified the unload of the form so that the instance could not
        '               be retained in memory.
        '====================================================================================
        'Date Changed: 07/11/07                       Changed by: Bret Knoll
        'Release #:                                   Task: Unknown
        'Description:   Modified code so Incoming call is created during the formNew
        '               Add a call to CreateDefaultIncomingCall
        '====================================================================================



        Dim NoteText As String = ""

        If Me.CmdNew.Text = "&Save" And Me.Saved <> True Then
            'The message was cancelled or closed so confirm cancellation
            vReturn = modMsgForm.FormCancel
            If vReturn = MsgBoxResult.Yes Then
                Me.Visible = False
                'reset the values back to original in case they changed
                vParentForm.OrganizationId = vParentForm.vOriginalOrgId
                vParentForm.SourceCode.ID = vParentForm.vOriginalSC
                Me.OrganizationId = vParentForm.OrganizationId
                Me.SourceCode.ID = vParentForm.SourceCode.ID

                eventArgs.Cancel = False

            Else
                eventArgs.Cancel = True
                Exit Sub
            End If
        ElseIf Me.CmdNew.Text = "&New" And Me.Saved <> True Then
            If modControl.GetText(CboCallType) = "Referral" Or modControl.GetText(CboCallType) = "Message/RFI" Or modControl.GetText(CboCallType) = "Import" Then
                'The message was cancelled or closed so confirm cancellation
                vReturn = modMsgForm.FormCancel
                If vReturn = MsgBoxResult.Yes Then
                    Me.Visible = False

                    'A new call was created but not saved.
                    'Save the referral first, using same logic as cmdOk for FrmReferral
                    If Me.CallId > 0 Then
                        Me.RecycledNC = True
                        'Update call open by with cancel out
                        If Me.CallOpenByID = AppMain.ParentForm.StatEmployeeID Then
                            Me.CallOpenByID = -1
                        End If
                        Call modStatSave.SaveCall(Me, Me.CallId)

                        If modControl.GetText(CboCallType) = "Referral" Then
                            Call modStatSave.SaveReferral(Me)

                            'Default the incoming call event
                            Call CreateDefaultIncomingCall()

                            Me.FormState = NEW_RECORD

                            'Char Chaput 05/12/06 added for 8.0 to add event of who/when cancelled out of the note
                            'reset the LogEventID so a new event is created.
                            Me.ContactLogEventID = 0
                            NoteText = "Referral deleted by " & AppMain.ParentForm.StatEmployeeName & " on " & Today & " at " & TimeOfDay
                            Call modStatSave.SaveLogEvent(Me, 17, NoteText, "REFERRAL")

                            Me.FormState = EXISTING_RECORD

                        ElseIf modControl.GetText(CboCallType) = "Message/RFI" Then
                            'Set default for message screen so the recycle will work
                            'when cancel from newcall screen
                            Me.MessageTypeID = 3
                            Call modStatSave.SaveMessage(Me)

                            'Default the incoming call event
                            Call CreateDefaultIncomingCall()

                            Me.FormState = NEW_RECORD

                            'Char Chaput 05/12/06 added for 8.0 to add event of who/when cancelled out of the note
                            'reset the LogEventID so a new event is created.
                            Me.ContactLogEventID = 0
                            NoteText = "Message deleted by " & AppMain.ParentForm.StatEmployeeName & " on " & Today & " at " & TimeOfDay
                            Call modStatSave.SaveLogEvent(Me, 17, NoteText, "Message/RFI")
                            Me.FormState = EXISTING_RECORD
                        ElseIf modControl.GetText(CboCallType) = "Import" Then
                            'Set default for message screen so the recycle will work
                            'when cancel from newcall screen
                            Me.MessageTypeID = 2
                            Call modStatSave.SaveMessage(Me)

                            'Default the incoming call event
                            Call CreateDefaultIncomingCall()

                            Me.FormState = NEW_RECORD


                            'Char Chaput 05/12/06 added for 8.0 to add event of who/when cancelled out of the note
                            'reset the LogEventID so a new event is created.
                            Me.ContactLogEventID = 0
                            NoteText = "Import deleted by " & AppMain.ParentForm.StatEmployeeName & " on " & Today & " at " & TimeOfDay
                            Call modStatSave.SaveLogEvent(Me, 17, NoteText, "Import")
                            Me.FormState = EXISTING_RECORD
                        End If

                        'New Call was cancelled so delete and place in the holding tank which
                        'is the recycle tab on the dashboard.
                        Call modStatSave.DeleteCall(Me.CallId)

                        eventArgs.Cancel = False

                    Else
                        eventArgs.Cancel = False

                    End If
                Else
                    eventArgs.Cancel = True
                    Exit Sub
                End If
            Else
                'Call type is No Call or Information so close the form

            End If
        ElseIf Me.CmdNew.Text = "&New" And Me.Saved = True Then
            'Default the incoming call event
            Call CreateDefaultIncomingCall()

        Else

        End If

        'Me.Dispose()
        '2/10/10 bjk clearing the reference to the form
        AppMain.frmNew = Nothing
    End Sub

    Private Sub Frame_MouseDown(ByRef Index As Short, ByRef Button As Short, ByRef Shift As Short, ByRef x As Single, ByRef y As Single)
        If CmdNew.Text = "&New" Then
            If Not ValidateSourceCode() Then
                'Keep the Contact information disabled until a
                'valid source code is entered
                Me.TxtPhone.Enabled = False
                Me.TxtExtension.Enabled = False
                Me.CboOrganization.Enabled = False
                Me.CboSubLocation.Enabled = False
                Me.TxtLevel.Enabled = False
                Me.CboName.Enabled = False
                Me.TxtPersonType.Enabled = False
                Me.CmdChangeSource.Enabled = False
                Me.CmdLocationDetail.Enabled = False
                Me.CmdDirectionsNote.Enabled = False
                Me.CmdNameDetail.Enabled = False
            Else
                Me.TxtPhone.Enabled = True
                Me.TxtExtension.Enabled = True
                Me.CboOrganization.Enabled = True
                Me.CboSubLocation.Enabled = True
                Me.TxtLevel.Enabled = True
                Me.CboName.Enabled = True
                Me.TxtPersonType.Enabled = True
                Me.CmdChangeSource.Enabled = True
                Me.CmdLocationDetail.Enabled = True
                Me.CmdDirectionsNote.Enabled = True
                Me.CmdNameDetail.Enabled = True
            End If
        End If
    End Sub
    Private Sub ChkStopTimer_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkStopTimer.CheckStateChanged

        If ChkStopTimer.CheckState = 1 Then
            'Disable the timer
            TimerTotalTime.Enabled = False
        Else
            TimerTotalTime.Enabled = True
        End If

    End Sub

    Private Sub TimerTotalTime_Tick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TimerTotalTime.Tick

        Dim vTimeDiff As New Object

        If (TimeSnapshot = "12:00:00 AM") Then
            Me.TimeSnapshot = Now
        End If
        vTimeDiff = DateDiff(Microsoft.VisualBasic.DateInterval.Second, Me.TimeSnapshot, Now)



        'Add if statement to determine if TxtTotalTimeCounter.txt is set by me.CallTotalTime or
        'me.LOCallTotalTime
        Me.CallTotalTime = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Second, vTimeDiff, Me.CallTotalTime), "hh:mm:ss")
        Me.LOCallTotalTime = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Second, vTimeDiff, Me.LOCallTotalTime), "hh:mm:ss")

        If AppMain.ParentForm.LeaseOrganization <> 0 Then
            If Me.CallNumber > "" Then
                TxtTotalTimeCounter.Text = Me.LOCallTotalTime
            End If
        Else
            If Me.CallNumber > "" Then
                TxtTotalTimeCounter.Text = Me.CallTotalTime
            End If
        End If

        'Take a snap shot of the time
        Me.TimeSnapshot = Now

        'If CmdCustomData.ForeColor = vbBlue Then
        'CmdCustomData.ForeColor = vbBlack
        'Else
        '    CmdCustomData.ForeColor = vbBlue
        ' End If

    End Sub

    Private Sub TxtSourceCode_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtSourceCode.TextChanged
        Dim callType As Integer = 0

        TxtGreeting.Text = ""
        SourceCode = Nothing
        SourceCode = New clsSourceCode

        Call SourceCode.GetItem(, TxtSourceCode.Text, modControl.GetID(CboCallType))

        TxtGreeting.Text = SourceCode.Description

        'Get DefaultAlert
        If Me.SourceCode.DefaultAlert IsNot Nothing Then
            If (Me.SourceCode.DefaultAlert.Contains(RTF)) Then
                Me.TxtDefaultAlert.Rtf = Me.SourceCode.DefaultAlert
            Else
                Me.TxtDefaultAlert.Text = Me.SourceCode.DefaultAlert
            End If
        End If
        'ccarroll 07/14/2011 = vOriginalCallType will have value if FrmNew
        'opened by FrmMessage of FrmReferral wi:13011
        If Me.vOriginalCallType = 0 Then
            'vParentForm.Name <> "FrmMessage"
            callType = QuerySourceCodeDefaultCallType(TxtSourceCode.Text.ToString())
            If callType > 0 Then
                modControl.SelectID(CboCallType, callType)
            Else
                'reset to referral
                modControl.SelectID(CboCallType, REFERRAL)
            End If
        End If
    End Sub

    Private Sub TxtSourceCode_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles TxtSourceCode.Validating
        Dim Cancel As Boolean = eventArgs.Cancel
        sc_validation = True

        If Not ValidateSourceCode() Then
            Cancel = False
            'Keep the Contact information disabled until a
            'valid source code is entered
            Me.TxtPhone.Enabled = False
            Me.TxtExtension.Enabled = False
            Me.CboOrganization.Enabled = False
            Me.CboSubLocation.Enabled = False
            Me.TxtLevel.Enabled = False
            Me.CboName.Enabled = False
            Me.TxtPersonType.Enabled = False
            Me.CmdChangeSource.Enabled = False
            Me.CmdLocationDetail.Enabled = False
            Me.CmdDirectionsNote.Enabled = False
            Me.CmdNameDetail.Enabled = False
            sc_validation = False
        Else
            Me.TxtPhone.Enabled = True
            Me.TxtExtension.Enabled = True
            Me.CboOrganization.Enabled = True
            Me.CboSubLocation.Enabled = True
            Me.TxtLevel.Enabled = True
            Me.CboName.Enabled = True
            Me.TxtPersonType.Enabled = True
            Me.CmdChangeSource.Enabled = True
            Me.CmdLocationDetail.Enabled = True
            Me.CmdDirectionsNote.Enabled = True
            Me.CmdNameDetail.Enabled = True

            sc_validation = True
        End If

        eventArgs.Cancel = Cancel
    End Sub

    Private Sub TxtTotalTimeCounter_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtTotalTimeCounter.TextChanged

        Dim I As Integer

        I = I + 1

    End Sub

    Private Sub TxtExtension_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtExtension.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub

    Private Sub TxtExtension_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtExtension.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        KeyAscii = modMask.NumMask(KeyAscii, 5, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub
    Private Sub TxtPersonType_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtPersonType.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub

    Private Sub TxtPhone_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtPhone.Enter
        Call modControl.HighlightText(TxtPhone)
        LastPhone = TxtPhone.Text
    End Sub
    Private Sub TxtPhone_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtPhone.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        KeyAscii = modMask.PhoneMask(KeyAscii, TxtPhone)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub
    Private Sub TxtPhone_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles TxtPhone.Validating
        Dim Cancel As Boolean = eventArgs.Cancel

        On Error Resume Next

        Dim vReturn As New Object
        Dim vPhoneID As Integer


        If Me.FormLoad = False Then

            'Check to see if there is a contact phone and extention to lookup
            'or if the contact phone or extention has changed.
            If Len(TxtPhone.Text) < 14 And Len(TxtPhone.Text) > 0 Then

                'Validate there is a phone number
                Call modMsgForm.FormValidate("Contact Phone #", TxtPhone)
                Cancel = True
                GoTo EventExitSub
            End If


            If modControl.GetText(CboCallType) = "Referral" Then

                'ccarroll 06/27/2011 Added for phone zero length wi: 12941
                If TxtPhone.Text = LastPhone Or Len(TxtPhone.Text) = 0 Then

                    'Don't lookup locations

                Else

                    'Find the primary locations that match the contact phone
                    If modStatQuery.QueryPhoneOrganization(Me) = SUCCESS Then

                        'Select the location item
                        Call modControl.SelectID(CboOrganization, Me.OrganizationId)

                        'Set the alerts & service level
                        Call CboOrganization_Validating(CboOrganization, New System.ComponentModel.CancelEventArgs(False))
                        Call modControl.SelectID(CboSubLocation, Me.SubLocationID)
                        TxtLevel.Text = Me.SubLocationLevel

                        'Find the sublocation that matches the phone.
                        If Me.SubLocationID = 0 Then
                            If modStatQuery.QueryPhoneSubLocation(Me) = SUCCESS Then
                                'If there is single match, select the correct sublocation
                                Call modControl.SelectID(CboSubLocation, Me.SubLocationID)
                            End If
                        End If
                    End If

                End If

            End If
        End If

        'If Me.CallId <= 0 And Me.TxtPhone.Text > "" Then
        If Me.CallId <= 0 And Me.OrganizationId > 0 Then
            Me.AutoSave()
        End If

EventExitSub:
        eventArgs.Cancel = Cancel
    End Sub

    Private Sub TxtSourceCode_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtSourceCode.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))


        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    'Private Sub TxtSourceCode_KeyUp(KeyCode As Integer, Shift As Integer)

    'TxtGreeting.Text = ""
    'Set SourceCode = Nothing

    'Call SourceCode.GetItem(, TxtSourceCode.Text, modControl.GetID(CboCallType))

    'TxtGreeting.Text = SourceCode.Description

    'End Sub
    Private Function ValidateSourceCode() As Boolean
        Dim vQuery As String = ""
        Dim vReturn As Short
        Dim vParams As New Object

        'ccarroll 05/20/2011
        'If SourceCode = "" and CancelClicked = True Then 'don't do validation
        If TxtSourceCode.Text = "" Then
            If CancelClicked Then
                Exit Function
            End If
            MsgBox("The source code entered is not valid. Please enter a valid source code.")
            Me.TxtSourceCode.Focus()
            Me.TxtDefaultAlert.Text = ""
            Me.TxtDefaultAlert.Rtf = ""

            Exit Function
        End If
        If TxtSourceCode.Text <> "" Then

            If Me.CallType = 1 Then

                'Check if the source code is valid
                vQuery = "SELECT SourceCodeId FROM SourceCode WHERE SourceCodeName = " & modODBC.BuildField(TxtSourceCode.Text) & " And SourceCodeType = 1 "
                vReturn = modODBC.Exec(vQuery, vParams)

                If vReturn = 100 Then
                    vQuery = "SELECT SourceCodeId FROM SourceCode WHERE SourceCodeName = " & modODBC.BuildField(TxtSourceCode.Text) & " And SourceCodeType = 2 "

                End If

            ElseIf Me.CallType = 2 Then
                vQuery = "SELECT SourceCodeId FROM SourceCode WHERE SourceCodeName = " & modODBC.BuildField(TxtSourceCode.Text) & " And SourceCodeType = 2 "
            Else
                'Check if the source code is valid
                vQuery = "SELECT SourceCodeId FROM SourceCode WHERE SourceCodeName = " & modODBC.BuildField(TxtSourceCode.Text) & " "
            End If

            'SourceCode must be active
            vQuery = vQuery & "AND IsNull(Inactive, 0) = 0 "


            'Added bjk 06/2001: Lease Organization
            'Check if LeaseOrganization adnd to where clause if it is
            If AppMain.ParentForm.LeaseOrganization <> 0 Then
                vQuery = vQuery & "AND "
                vQuery = vQuery & "SourceCodeName IN (SELECT SourceCode.SourceCodeName FROM " & "SourceCodeOrganization LEFT JOIN SourceCode ON SourceCode.SourceCodeID = SourceCodeOrganization.SourceCodeID " & "Where (SourceCodeType = 2 Or SourceCodeType = 4) AND SourceCodeOrganization.OrganizationID = " & AppMain.ParentForm.LeaseOrganization & "); "
            End If


            vReturn = modODBC.Exec(vQuery, vParams)

            If vReturn = NO_DATA Then
                MsgBox("The source code entered is not valid. Please enter a valid source code.")
                If CmdNew.Text = "&New" Then
                    'ccarroll 05/20/2011
                    'Reset SourceCode text
                    Me.TxtSourceCode.Text = ""
                    Me.TxtSourceCode.Select(0, 0) ' Focus()

                Else
                    Call CmdChangeSource_Click(CmdChangeSource, New System.EventArgs())
                End If
                ValidateSourceCode = False
                Exit Function
            End If
        End If

        Me.SourceCode.ID = vParams(0, 0)
        ValidateSourceCode = True

        'ccarroll 08/10/2010 - record source code validation
        'HS 24561, WI 7661
        Me.SourceCodeValidationCount = Me.SourceCodeValidationCount + 1


        'Get only the organizations associated with the lookup code.
        'Lookup code associations are created using the alert screen.
        If CboOrganization.Text = "" Then
            If sc_validation = True Then
                Call SourceCode.Organizations.GetItems()
                Call SourceCode.Organizations.FillListBox(CboOrganization)
            End If

            'Get DefaultAlert
            If Me.SourceCode.DefaultAlert IsNot Nothing Then
                If (Me.SourceCode.DefaultAlert.Contains(RTF)) Then
                    Me.TxtDefaultAlert.Rtf = Me.SourceCode.DefaultAlert
                Else
                    Me.TxtDefaultAlert.Text = Me.SourceCode.DefaultAlert
                End If
            End If


        End If
        'End If

    End Function


    Public Property CallTotalTime() As Object
        Get

            CallTotalTime = VB6.Format(fvCallTotalTime, "hh:mm:ss")

        End Get
        Set(ByVal Value As Object)

            fvCallTotalTime = CDate(VB6.Format(TimeValue(Value), "hh:mm:ss"))

        End Set
    End Property

    Public Property CallDate() As Object
        Get

            CallDate = VB6.Format(fvCallDate, "mm/dd/yy  hh:mm")

        End Get
        Set(ByVal Value As Object)

            fvCallDate = CDate(VB6.Format(Value, "mm/dd/yy  hh:mm"))

        End Set
    End Property
    Public Property LOCallTotalTime() As Object
        Get

            LOCallTotalTime = VB6.Format(fvLOCallTotalTime, "hh:mm:ss")

        End Get
        Set(ByVal Value As Object)

            fvLOCallTotalTime = CDate(VB6.Format(TimeValue(Value), "hh:mm:ss"))

        End Set
    End Property

    Public Function AutoSave() As Object
        '************************************************************************************
        'Name: AutoSave
        'Date Created: 04/13/06                         Created by: Char Chaput
        'Release: 8.0                                   Task: Unknown
        'Description: Create the Call when have either phone number or facility
        'Returns: Nothing
        'Params: None
        'Stored Procedures: None
        '************************************************************************************

        'Char Chaput 04/13/06 Create the Call when have either phone number or facility
        'Added for release 8.0
        'Initialize the call date
        Me.CallDate = VB6.Format(Now, "mm/dd/yy  hh:mm")
        Me.CallType = modControl.GetID(CboCallType)

        'Initialize the total call time
        Me.CallTotalTime = VB6.Format(0, "hh:mm:ss")
        Me.TimeSnapshot = Now

        'Save the call record and get the new call id
        If Me.CallId = 0 Then
            Me.CallId = modStatSave.SaveCall(Me)
            'remove extra save of CallOpenBy
            If Me.CallId > 0 Then
                Me.ReferralCall.ID = Me.CallId
                Select Case Me.CallType
                    Case REFERRAL
                        ReferralId = modStatSave.SaveReferral(Me)
                    Case Message, IMPORT
                        ReferralId = modStatSave.SaveMessage(Me)
                End Select
                Me.FormState = EXISTING_RECORD

            End If
        End If


        If Me.CallId > 0 And ReferralId > 0 Then
            'Add the Referral # and Source code to screen title
            Me.Text = "# " & Me.CallId & "    " & Me.SourceCode.Name
        Else

            Call MsgBox("StatTrac was unable to create a new record. Please restart StatTrac.", MsgBoxStyle.Critical, "Warning Database Error")

            On Error GoTo localError

            'Raise error so we can log message
            LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Nothing, "StatTrac was unable to create a call record callid:" & Me.CallId & " | Referral or Message ID: " & ReferralId)

        End If


        Exit Function

localError:

        'Log a detailed message when an attempt to to save a referral/call/message record fails
        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err, "StatTrac was unable to create a referral/call/message record callid:" & Me.CallId & " | Referral or Message ID: " & ReferralId)
        Me.Hide()


    End Function
    Public Function CreateDefaultIncomingCall() As Object
        '************************************************************************************
        'Name: CreateDefaultIncomingCall
        'Date Created: 07/11/07                         Created by: Bret Knoll
        'Release: 8.4                                   Task: 8.4.3.8
        'Description: creates the default incoming call
        '
        '====================================================================================
        Dim eventLogList As New Object

        modStatQuery.QueryLogEventList(eventLogList, Me.CallId, False)
        If TypeOf eventLogList Is Array Then
            Exit Function
        End If
        If Me.CmdNew.Text = "&New" Then

            Me.FormState = NEW_RECORD
            If modControl.GetText(CboCallType) = "Referral" Then
                'Default the incoming call event
                ContactLogEventID = modStatSave.SaveLogEvent(Me, , , "REFERRAL")
            ElseIf modControl.GetText(CboCallType) = "Message/RFI" Then
                'Default the incoming call event
                ContactLogEventID = modStatSave.SaveLogEvent(Me, , , "Message/RFI")
            ElseIf modControl.GetText(CboCallType) = "Import" Then
                'Default the incoming call event
                ContactLogEventID = modStatSave.SaveLogEvent(Me, , , "Import")
            End If
            Me.FormState = EXISTING_RECORD
        End If


    End Function
    Public Function CboCallType_Initialize() As Boolean
        CboCallType.Items.Add(New ValueDescriptionPair(IMPORT, "Import"))
        CboCallType.Items.Add(New ValueDescriptionPair(INFORMATION_Renamed, "Information"))
        CboCallType.Items.Add(New ValueDescriptionPair(Message, "Message/RFI"))
        CboCallType.Items.Add(New ValueDescriptionPair(NOCALL, "No Call"))
        CboCallType.Items.Add(New ValueDescriptionPair(REFERRAL, "Referral"))
        Return True
    End Function

    Private Sub FrmNew_LocationChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.LocationChanged

    End Sub
End Class