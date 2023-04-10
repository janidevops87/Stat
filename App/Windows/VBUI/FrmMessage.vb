Option Strict Off
Option Explicit On
Option Compare Text
Imports Statline.Stattrac.Framework

Public Class FrmMessage
    Inherits System.Windows.Forms.Form

    'Form Variables
    Public FormState As Short
    Public FormLoad As Boolean
    Public CallType As Short
    Public CallId As Integer
    Public ReferralId As Integer
    Public CallNumber As String
    Public vOldTextLblOrganization As String
    Public vOriginalOrgId As Integer
    Public vOriginalSC As Integer
    Dim fvCallDate As Date
    Dim fvCallTotalTime As Date
    Public TimeSnapshot As Date
    Public SortOrder As Short
    Public CallOpenByID As Integer
    Public CallFSCase As Boolean
    Public CallExclusive As Boolean
    Public CallPending As Boolean
    Public CallComplete As Boolean
    Public Cancel As Boolean

    Public OrganizationTimeZone As String
    Public OrganizationId As Integer
    Public CallerOrganizationID As Integer
    Public CallerNameID As Integer
    Public OrganizationName As String
    Public MessageCallerOrganization As String
    Public CallPhoneNumber As String
    Public CallPhoneExtension As String
    Public MessageTypeID As Integer
    Public PersonID As Integer
    Public Person As String
    Public PersonType As String
    Public Saved As Short
    Public AuditLogId As Integer
    Public pvalue As String
    'Char Chaput 04/25/06 Added this flag to determine if cancelled from New Call screen
    'This is checked in FrmOpenAll
    Public RecycledNC As Boolean
    Public vReturnSC As Short 'bret 07/13/07 8.4.3.8 AuditTrail

    Public CurrentLogEventID As Integer
    Public ShiftKey As Boolean
    Public ScheduleAlert As String
    Public AlertType As Short
    Public SourceCode As New clsSourceCode
    Public CallerOrg As New clsOrganization

    'Private frmNewEvent As FrmNewEvent
    Private frmLogEvent As FrmLogEvent
    Private frmOnCallEvent As FrmOnCallEvent

    Public vOldValue As Object
    Public RTF As String = "{\rtf1"

    Public Property CallDate() As Object
        Get

            CallDate = VB6.Format(fvCallDate, "mm/dd/yy  hh:mm")

        End Get
        Set(ByVal Value As Object)

            fvCallDate = CDate(VB6.Format(Value, "mm/dd/yy  hh:mm"))

        End Set
    End Property

    Public Property CallTotalTime() As Object
        Get

            CallTotalTime = VB6.Format(fvCallTotalTime, "hh:mm:ss")

        End Get
        Set(ByVal Value As Object)

            fvCallTotalTime = CDate(VB6.Format(Value, "hh:mm:ss"))

        End Set
    End Property


    Public Function Display() As Object

        Me.Show()

    End Function

    Private Sub CboName_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboName.TextChanged

        'Clear the title if multiple names or no match
        If CboName.SelectedIndex = -1 Then
            TxtPersonType.Text = ""
        End If

    End Sub

    Private Sub CboName_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboName.SelectedIndexChanged

        'Get the PersonType of the selected person
        Me.PersonID = modControl.GetID(CboName)
        Call modStatQuery.QueryPersonPersonType(Me)

    End Sub


    Private Sub CboName_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles CboName.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        'Allow the delete key to clear the combo box
        If KeyAscii = 8 Then

            Call modControl.AllowDelete(CboName, KeyAscii)

            'Clear the PersonType box
            TxtPersonType.Text = ""

        End If
        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub CboName_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboName.Leave

        'Get the ID of the selected person
        Me.PersonID = modControl.GetID(CboName)

    End Sub
    
    Private Sub CboOrganization_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboOrganization.TextChanged

        'Clear the name if multiple Organizations or no match
        If CboOrganization.SelectedIndex = -1 Then
            Call modControl.SelectNone(CboName)
        End If

    End Sub


    Private Sub CboOrganization_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboOrganization.SelectedIndexChanged

        'Get the ID of the selected Organization
        Me.OrganizationId = modControl.GetID(CboOrganization)
        Me.OrganizationName = modControl.GetText(CboOrganization)

        'Get the time zone of the organization
        Call modStatQuery.QueryOrganizationTimeZone(Me)

        'Find the names that match the selected Organization or
        'if there are no names for the Organization
        Call modStatQuery.QueryOrganizationPerson(Me)

        'Clear the title if multiple names or no match
        If CboName.SelectedIndex = -1 Then
            TxtPersonType.Text = ""
            Call modControl.SelectNone(CboName)
        End If

        'Find any alerts assigned to the organization
        If Me.OrganizationId <> -1 Then
            Call modStatQuery.QueryOrganizationAlert(Me)
            Me.CmdOnCall.Enabled = True
            Me.CmdOnCallMain.Enabled = True
        Else
            'Clear the name if multiple Organizations or no match
            Call CboName.Items.Clear()
            Me.TxtAlerts(0).Text = Me.SourceCode.Description
            Me.TxtAlerts(1).Text = ""
            Me.CmdOnCall.Enabled = False
            Me.CmdOnCallMain.Enabled = False
        End If

        If Not IsNothing(Me.ScheduleAlert) Then
            modControl.SetRTFText(rtbScheduleAlert, Me.ScheduleAlert)
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

    Private Sub CboOrganization_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboOrganization.Leave

        'Get the ID of the selected Organization
        Me.OrganizationId = modControl.GetID(CboOrganization)

    End Sub


    Private Sub CboMessageType_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboMessageType.SelectedIndexChanged

        Me.MessageTypeID = modControl.GetID(CboMessageType)
        If Me.MessageTypeID = 2 Then

            Me.AlertType = IMPORT

            'Display import fields
            Me.LblImportCenter.Visible = True
            Me.TxtImportCenter.Visible = True
            Me.LblImportPatient.Visible = True
            Me.TxtImportPatient.Visible = True
            Me.LblUNOSID.Visible = True
            Me.TxtUNOSID.Visible = True

            'Set message box position
            LblMessage.Top = VB6.TwipsToPixelsY(930)
            TxtMessage.Top = VB6.TwipsToPixelsY(930)
            TxtMessage.Height = VB6.TwipsToPixelsY(975)

        Else
            Me.AlertType = Message

            'Hide import fields
            Me.LblImportCenter.Visible = False
            Me.TxtImportCenter.Visible = False
            Me.LblImportPatient.Visible = False
            Me.TxtImportPatient.Visible = False
            Me.LblUNOSID.Visible = False
            Me.TxtUNOSID.Visible = False

            'Set message box position
            LblMessage.Top = VB6.TwipsToPixelsY(570)
            TxtMessage.Top = VB6.TwipsToPixelsY(570)
            TxtMessage.Height = VB6.TwipsToPixelsY(1335)

        End If

    End Sub


    Private Sub CboMessageType_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles CboMessageType.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        'Allow the delete key to clear the combo box
        Call modControl.AllowDelete(CboMessageType, KeyAscii)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub CboMessageType_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboMessageType.Leave

        'Get the ID of the selected Organization
        Me.MessageTypeID = modControl.GetID(CboMessageType)

    End Sub

    Private Sub ChkTemp_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkTemp.CheckStateChanged

        If ChkTemp.CheckState = System.Windows.Forms.CheckState.Checked Then
            ChkExclusive.Visible = True
            ChkExclusive.CheckState = System.Windows.Forms.CheckState.Checked
        Else
            ChkExclusive.Visible = False
            ChkExclusive.CheckState = System.Windows.Forms.CheckState.Unchecked
            CallComplete = True
        End If


    End Sub

    Private Sub chkViewLogEventDeleted_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles chkViewLogEventDeleted.CheckStateChanged
        'Clear the grid
        LstViewLogEvent.Items.Clear()
        'Fill Grid
        Call modStatQuery.QueryOpenLogEvent(Me)
        'Me.chkViewLogEventDeleted

    End Sub

    Private Sub CmdCancel_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdCancel.Click

        Me.Close()

    End Sub



    Private Sub CmdChangeSource_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdChangeSource.Click

        Dim vReturn As String = ""
        Dim vReturnquery As String = ""
        Dim vQuery As String = ""
        Dim vParams As New Object

        vOriginalSC = Me.SourceCode.ID
        Me.SendToBack()
        vReturn = InputBox("Please select a new source code.", "Change Source Code", Me.SourceCode.Name).Trim()
        Me.BringToFront()

        If Trim(vReturn) = "" Then
            MsgBox("The source code entered is not valid. Please enter a valid source code.")
            Call CmdChangeSource_Click(CmdChangeSource, New System.EventArgs())

            Exit Sub

        ElseIf Trim(vReturn) <> "" Then

            vQuery = "SELECT * FROM SourceCode WHERE SourceCodeName = " & modODBC.BuildField(vReturn) & " And SourceCodeType = 2 "

            'Check if LeaseOrganization adnd to where clause if it is
            If AppMain.ParentForm.LeaseOrganization <> 0 Then
                vQuery = vQuery & "AND "
                vQuery = vQuery & "SourceCodeName IN (SELECT DISTINCT SourceCode.SourceCodeName FROM " & "SourceCodeOrganization LEFT JOIN SourceCode ON SourceCode.SourceCodeID = SourceCodeOrganization.SourceCodeID " & "Where (SourceCodeType = 2 Or SourceCodeType = 4) AND SourceCodeOrganization.OrganizationID = " & AppMain.ParentForm.LeaseOrganization & "); "
            End If

            vReturnquery = CStr(modODBC.Exec(vQuery, vParams))

            If CDbl(vReturnquery) = NO_DATA Then
                MsgBox("The source code entered is not valid. Please enter a valid source code.")
                Call CmdChangeSource_Click(CmdChangeSource, New System.EventArgs())
                Exit Sub
            Else
                'Me.SourceCode = Nothing
                Call Me.SourceCode.GetItem(, vReturn, Me.AlertType)
                Me.SourceCode.ID = vParams(0, 0)
                'Get only the organizations associated with the lookup code.
                'Lookup code associations are created using the alert screen.
                Call Me.SourceCode.Organizations.GetItems()
                Call Me.SourceCode.Organizations.FillListBox(CboOrganization)
                Me.CboName.Items.Clear()
                Me.TxtPersonType.Text = ""

                'Get DefaultAlert
                If Me.SourceCode.DefaultAlert IsNot Nothing Then
                    If (Me.SourceCode.DefaultAlert.Contains(RTF)) Then
                        Me.TxtAlerts(0).Rtf = Me.SourceCode.DefaultAlert
                    Else
                        Me.TxtAlerts(0).Text = Me.SourceCode.DefaultAlert
                    End If
                End If
                Me.TxtAlerts(1).Text = ""
                Me.TxtAlerts(1).Rtf = ""
                'Set the combo box
                Call modControl.SelectID((Me.CboOrganization), Me.OrganizationId)
                Call modControl.SelectID((Me.CboName), Me.PersonID)

                Me.Text = "# " & Me.CallId & "    " & Me.SourceCode.Name
            End If
        End If

    End Sub

    Private Sub CmdColorKey_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdColorKey.Click
        Dim frmColorKey As New FrmColorKey
        Dim dialogResult As DialogResult = frmColorKey.ShowDialog()
        frmColorKey.Close()
    End Sub

    Private Sub CmdDelete_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdDelete.Click
        '************************************************************************************
        'Name: CmdDelete_Click
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: checks if the event can be deleted and calls the delete method
        'Returns: n/a
        'Params: n/a
        '
        '
        'Stored Procedures: n/a
        '====================================================================================
        '====================================================================================
        'Date Changed: 06/13/07                       Changed by: Bret Knoll
        'Release #: 8.4.3.9                            Task: LogEvent Delete
        'Description:
        '   Prevent Deleted from being deleted
        '   fix index numbers for existing code
        '====================================================================================

        Dim vLogEventID As Integer
        Dim I As Short
        Dim vRow As Short        

        'Confirm user wants to delete
        Dim vReturn As Short = MsgBox("Are you sure you want to delete this event?", MsgBoxStyle.OkCancel + MsgBoxStyle.DefaultButton2, "Delete Event")
        If vReturn = MsgBoxResult.Cancel Then
            Exit Sub
        End If

        'Make sure user selected an event to delete
        If IsNothing(LstViewLogEvent.FocusedItem) Then
            Call MsgBox("Please select an event before clicking the 'Delete Event' button.")
            Exit Sub
        End If

        'T.T 05/20/2006 do not allow recycle notes to delete
        If LstViewLogEvent.FocusedItem.SubItems(1).Text = "Recycled Call" Then
            Call MsgBox("You may not delete the Recycle Note Event.")
            Exit Sub
        End If

        'T.T 04/10/2007 do not allow DonorNet events to be deleted
        If LstViewLogEvent.FocusedItem.SubItems(2).Text = "DonorNet" Then
            Exit Sub
        End If

        'bret 06/11/2007 8.4.3.9 edit deleted event
        'SubItems(1) = Event Type
        If LstViewLogEvent.FocusedItem.SubItems(1).Text = "DELETED EVENT" Then
            Call MsgBox("You may not delete a Deleted Event.")
            Exit Sub
        End If

        'Do not allow the deletion of the original incoming call event
        ' subItem 1 is Event Type
        'bret 06/11/2007 if the list is sorted this statement does not work.
        'subItem 6 is LogEvent Order Number
        If CDbl(LstViewLogEvent.FocusedItem.SubItems(6).Text) = 1 And LstViewLogEvent.FocusedItem.SubItems(1).Text = "Incoming Call" Then
            Call MsgBox("You may not delete the original incoming call event.")
            Exit Sub
        End If

        'Get the ID of the LogEvent to open
        Me.CurrentLogEventID = modConv.TextToLng(LstViewLogEvent.FocusedItem.Tag)

        'Delete the event
        Try
            Call modStatSave.DeleteLogEvent(Me)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        'Clear the grid
        LstViewLogEvent.Items.Clear()
        LstViewLogEvent.View = View.Details

        'Fill Grid
        Try
            Call modStatQuery.QueryOpenLogEvent(Me)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        'Clear the grid
        LstViewPending.Items.Clear()
        Try
            Call modStatQuery.QueryPendingEvents(Me)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Sub

    Private Sub CmdFind_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdFind.Click

        AppMain.frmQuickLook = New FrmQuickLook
        AppMain.frmQuickLook.CmdClose.Text = "Close"

        AppMain.frmQuickLook.Display()
        If (AppMain.frmQuickLook IsNot Nothing)
            AppMain.frmQuickLook.Close()
        End If

    End Sub

    Private Sub CmdModify_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdModify.Click

        Dim vReturn As New Object
        Dim vResultArray As New Object

        If (AppMain.frmNew Is Nothing) Then
            AppMain.frmNew = New FrmNew()

            'Determine the form state which to open the
            'New form to modify source code and contact info.
            'Store the OrgId before the change
            vOriginalSC = Me.SourceCode.ID
            vOriginalOrgId = Me.CallerOrganizationID

            If Me.CallerOrganizationID = -1 And Me.LblOrganization.Text = "" Then
                AppMain.frmNew.OrganizationId = 0
            Else
                'If modControl.GetText(CboCallType) = "Message/RFI" Then
                pvalue = "Message/RFI"
                'ElseIf modControl.GetText(CboCallType) = "Import" Then
                'pvalue = "IMPORT"
                'End If

                Call modControl.SelectText((AppMain.frmNew.CboCallType), pvalue)

                'ccarroll 07/14/2011 - wi:13011
                AppMain.frmNew.vOriginalCallType = Message

                AppMain.frmNew.SourceCode.Name = Me.SourceCode.Name
                AppMain.frmNew.SourceCode.ID = Me.SourceCode.ID
                AppMain.frmNew.CallId = Me.CallId
                AppMain.frmNew.CallerName = Me.LblName.Text
                AppMain.frmNew.CallerOrganizationName = Me.LblOrganization.Text

                AppMain.frmNew.TxtPhone.Text = Me.LblPhone.Text
                AppMain.frmNew.TxtExtension.Text = Me.LblExtension.Text

                'set the person type combo box
                AppMain.frmNew.PersonID = Me.PersonID
                Call modControl.SelectID((AppMain.frmNew.CboName), AppMain.frmNew.PersonID)

            End If

            'Get the Organization id from the NewCall form
            'after the user is done.
            AppMain.frmMessage.SendToBack()
            AppMain.frmNew.vParentForm = Me
            Me.BringToFront()
            Me.CallerOrganizationID = AppMain.frmNew.Display

            If (AppMain.frmNew IsNot Nothing)
                AppMain.frmNew.CboCallType.SelectedItem = pvalue
            End If

            'AppMain.frmNew = Nothing
        End If

        Exit Sub
    End Sub

    Private Sub CmdNewEvent_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdNewEvent.Click

        Dim vLogEventID As Integer
        Dim vReturn As New Object
        Dim I As Short
        Dim vEventTypeList(10) As Object
        frmLogEvent = New FrmLogEvent()

        'Set the correct LogEvent state
        frmLogEvent.FormState = NEW_RECORD

        'Set the call id and number of the Details form
        frmLogEvent.CallId = Me.CallId
        frmLogEvent.CallNumber = Me.CallNumber

        If Me.ShiftKey Then
            'Make sure we have a selected event
            If LstViewLogEvent.FocusedItem Is Nothing Then
                Call MsgBox("Please select an event before clicking the 'New Event' button.")
                Me.ShiftKey = False
                Exit Sub
            End If

            Me.CurrentLogEventID = modConv.TextToLng(LstViewLogEvent.FocusedItem.Tag)
            'Get the selected event
            Try
                Call modStatQuery.QueryLogEvent(Me, frmLogEvent)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
            Me.ShiftKey = False
        Else
            'Default fields
            frmLogEvent.DefaultContactName = LblName.Text
            frmLogEvent.DefaultContactPhone = LblPhone.Text
            frmLogEvent.DefaultOrganization = LblOrganization.Text
            frmLogEvent.DefaultContactType = -1
        End If

        'Set the call number of the Details form
        frmLogEvent.CallNumber = Me.CallNumber

        'Set event types
        vEventTypeList(0) = INCOMING
        vEventTypeList(1) = OUTGOING
        vEventTypeList(2) = GENERAL
        vEventTypeList(3) = PAGE_PENDING
        vEventTypeList(4) = PAGE_RESPONSE
        vEventTypeList(5) = CALLBACK_PENDING
        vEventTypeList(6) = EMAIL_PENDING
        vEventTypeList(7) = Case_Update
        vEventTypeList(8) = CASE_HAND_OFF
        vEventTypeList(9) = EMAIL_SENT
        vEventTypeList(10) = PAGE_SENT
        frmLogEvent.LogEventTypeList = VB6.CopyArray(vEventTypeList)

        '10/22/01 drh
        frmLogEvent.vParentForm = Me

        'Get the Details id from the Details form
        'after the user is done.
        Me.SendToBack()
        vLogEventID = frmLogEvent.Display
        'frmLogEvent.Activate()
        'Dim frmResult As DialogResult = frmLogEvent.ShowDialog(Me)
        frmLogEvent.Close()
        'Clear the grid
        LstViewLogEvent.Items.Clear()
        LstViewLogEvent.View = View.Details

        'Fill Grid
        Try
            Call modStatQuery.QueryOpenLogEvent(Me)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        'Clear the grid
        LstViewPending.Items.Clear()
        Try
            Call modStatQuery.QueryPendingEvents(Me)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Sub


    Private Sub CmdOK_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdOK.Click

        Dim vReturn As Short

        'Make sure the user wants to save
        vReturn = modMsgForm.FormSave

        If vReturn = MsgBoxResult.Cancel Then
            Exit Sub
        End If

        'Validate the data
        If ChkTemp.CheckState = System.Windows.Forms.CheckState.Unchecked Then
            If Not modStatValidate.MessageVal(Me) Then
                Exit Sub
            End If
        End If

        If Me.RecycledNC = True Then
            Me.RecycledNC = False
            Me.Cancel = False
        End If


        Me.Saved = True

        '06/09/07 bret 8.4.3.8 set CallOpenbyID
        Me.CallOpenByID = -1

        'Save the Message
        Call modStatSave.SaveCall(Me, Me.CallId)
        If vReturnSC = -1 Then 'clicked no on savecall msgbox
            Me.Saved = False
            Me.Close()
            Exit Sub
        ElseIf vReturnSC = 2 Then  'clicked cancel on savecall msgbox
            Call modUtility.Done()
            Exit Sub
        End If


        Call modStatSave.SaveMessage(Me)



        Me.Saved = True

        Me.Close()

    End Sub

    Private Sub CmdOnCall_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdOnCall.Click
        '************************************************************************************
        'Name: CmdOnCall_Click
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Loads FrmOnCallEvent, along with associated variables
        'Returns: Nothing
        'Params: None
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 12/8/04                          Changed by: Scott Plummer
        'Release #: 7.7.2                               Task: 312
        'Description:  Added filling of variables to store email text and subject
        '====================================================================================
        '====================================================================================
        'Date Changed: 12/21/04                          Changed by: Scott Plummer
        'Release #: 7.7.2                               Task: 312
        'Description:  Populate FrmOnCallEvent.MsgType from frmMessage.CboMessageType
        '              to prevent sending emails on Imports
        '====================================================================================
        '************************************************************************************

        Dim vEventTypeList(8) As Object
        Dim frmOnCallEvent As New FrmOnCallEvent

        'Set the call id & number of the form
        frmOnCallEvent.CallId = Me.CallId
        frmOnCallEvent.CallNumber = Me.CallNumber
        frmOnCallEvent.ReferralOrganizationID = Me.OrganizationId
        frmOnCallEvent.CurrentDate = Today
        frmOnCallEvent.DefaultContactType = PAGE_PENDING

        'Set event types
        vEventTypeList(0) = INCOMING
        vEventTypeList(1) = OUTGOING
        vEventTypeList(2) = GENERAL
        vEventTypeList(3) = PAGE_PENDING
        vEventTypeList(4) = CALLBACK_PENDING
        vEventTypeList(5) = EMAIL_PENDING
        vEventTypeList(6) = CASE_HAND_OFF     
        vEventTypeList(7) = EMAIL_SENT
        vEventTypeList(8) = PAGE_SENT

        frmOnCallEvent.SourceCode = Me.SourceCode
        frmOnCallEvent.LogEventTypeList = VB6.CopyArray(vEventTypeList)

        frmOnCallEvent.OnCallType = Message
        'Char Chaput 04/28/06 modify .Text to TextRTF so that rich text will display
        modControl.SetRTFText(frmOnCallEvent.TxtAlert, Me.ScheduleAlert)
        'T.T 02/15/2007 added callID to front
        frmOnCallEvent.AlphaMsg = "#" & frmOnCallEvent.CallId & " - " & "Confirm To Tel: " & AppMain.Queue & " x" & AppMain.Extension & "  Tel: "

        frmOnCallEvent.AlphaMsg = frmOnCallEvent.AlphaMsg & Me.LblPhone.Text

        If Me.LblExtension.Text <> "" Then
            frmOnCallEvent.AlphaMsg = frmOnCallEvent.AlphaMsg & " x" & Me.LblExtension.Text & ", "
        Else
            frmOnCallEvent.AlphaMsg = frmOnCallEvent.AlphaMsg & ", "
        End If

        frmOnCallEvent.AlphaMsg = frmOnCallEvent.AlphaMsg & Me.LblName.Text & ", " & Me.LblOrganization.Text & ", "

        If Me.MessageTypeID = 2 Then
            frmOnCallEvent.AlphaMsg = frmOnCallEvent.AlphaMsg & Me.TxtImportCenter.Text & ", " & Me.TxtImportPatient.Text & ", " & Me.TxtUNOSID.Text & ", " & Me.TxtMessage.Text
        Else
            frmOnCallEvent.AlphaMsg = frmOnCallEvent.AlphaMsg & Me.TxtMessage.Text
        End If

        frmOnCallEvent.AutoResponseMsg = frmOnCallEvent.AlphaMsg 'mjd 07/05/2002 Page-AutoResponse

        'Added ability to send info in email.  11/30/04 - SAP
        frmOnCallEvent.EmailMsg = modStatValidate.SetMessageEmail(Me)
        frmOnCallEvent.EmailSbj = modStatValidate.SetMessageEmailSbj(Me)

        'Populate the AlertType variable to prevent sending emails to Imports.  12/21/04 - SAP
        frmOnCallEvent.AlertType = Me.AlertType

        '10/22/01 drh
        frmOnCallEvent.vParentForm = Me

        Me.SendToBack()
        Call frmOnCallEvent.Display()

        'Clear the grid
        LstViewLogEvent.Items.Clear()
        LstViewLogEvent.View = View.Details
        'Fill Grid
        Try
            Call modStatQuery.QueryOpenLogEvent(Me)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        'Clear the grid
        LstViewPending.Items.Clear()
        Try
            Call modStatQuery.QueryPendingEvents(Me)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Sub

    Private Sub CmdOnCallMain_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdOnCallMain.Click
        '************************************************************************************
        'Name: CmdOnCallMain_Click
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Loads FrmOnCallEvent, along with associated variables
        'Returns: Nothing
        'Params: None
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 12/9/04                          Changed by: Scott Plummer
        'Release #: 7.7.2                               Task: 312
        'Description:  Added Email Pending event type
        '====================================================================================
        '====================================================================================
        'Date Changed: 12/21/04                         Changed by: Scott Plummer
        'Release #: 7.7.2                               Task: 312
        'Description:  Populate FrmOnCallEvent.MsgType from frmMessage.CboMessageType
        '              to prevent sending emails on Imports
        '              Fixed bug to ensure messages are fully populated in frmOnCallEvent.
        '====================================================================================
        '************************************************************************************
        Dim vEventTypeList(8) As Object
        Dim frmOnCallEvent As New FrmOnCallEvent

        'Set the call id & number of the form
        frmOnCallEvent.SourceCode = Me.SourceCode
        frmOnCallEvent.CallId = Me.CallId
        frmOnCallEvent.CallNumber = Me.CallNumber
        frmOnCallEvent.ReferralOrganizationID = Me.OrganizationId
        frmOnCallEvent.CurrentDate = Today
        frmOnCallEvent.DefaultContactType = PAGE_PENDING

        'Set event types
        vEventTypeList(0) = INCOMING
        vEventTypeList(1) = OUTGOING
        vEventTypeList(2) = GENERAL
        vEventTypeList(3) = PAGE_PENDING
        vEventTypeList(4) = CALLBACK_PENDING
        vEventTypeList(5) = EMAIL_PENDING
        vEventTypeList(6) = CASE_HAND_OFF           
        vEventTypeList(7) = EMAIL_SENT
        vEventTypeList(8) = PAGE_SENT

        frmOnCallEvent.LogEventTypeList = VB6.CopyArray(vEventTypeList)

        frmOnCallEvent.OnCallType = Message
        'Char Chaput 04/28/06 modify .Text to TextRTF so that rich text will display
        modControl.SetRTFText(frmOnCallEvent.TxtAlert, Me.ScheduleAlert)
        'T.T 02/15/2007 added callID
        frmOnCallEvent.AlphaMsg = "#" & frmOnCallEvent.CallId & " - " & "Confirm To Tel: " & AppMain.Queue & " x" & AppMain.Extension & "  Tel: "

        frmOnCallEvent.AlphaMsg = frmOnCallEvent.AlphaMsg & Me.LblPhone.Text

        If Me.LblExtension.Text <> "" Then
            frmOnCallEvent.AlphaMsg = frmOnCallEvent.AlphaMsg & " x" & Me.LblExtension.Text & ", "
        Else
            frmOnCallEvent.AlphaMsg = frmOnCallEvent.AlphaMsg & ", "
        End If

        frmOnCallEvent.AlphaMsg = frmOnCallEvent.AlphaMsg & Me.LblName.Text & ", " & Me.LblOrganization.Text & ", "

        If Me.MessageTypeID = 2 Then
            frmOnCallEvent.AlphaMsg = frmOnCallEvent.AlphaMsg & Me.TxtImportCenter.Text & ", " & Me.TxtImportPatient.Text & ", " & Me.TxtUNOSID.Text & ", " & Me.TxtMessage.Text
        Else
            frmOnCallEvent.AlphaMsg = frmOnCallEvent.AlphaMsg & Me.TxtMessage.Text
        End If

        'Bug fix: Added code here to make sure Auto Response pager message works the same on both On Call Buttons.  12/21/04 - SAP
        frmOnCallEvent.AutoResponseMsg = frmOnCallEvent.AlphaMsg

        '10/22/01 drh
        frmOnCallEvent.vParentForm = Me

        'Added ability to send info in email.  11/30/04 - SAP
        frmOnCallEvent.EmailMsg = modStatValidate.SetMessageEmail(Me)
        frmOnCallEvent.EmailSbj = modStatValidate.SetMessageEmailSbj(Me)

        'Populate the AlertType variable to prevent sending emails to Imports. 12/21/04 - SAP
        frmOnCallEvent.AlertType = Me.AlertType

        'Show the referral form
        Me.SendToBack()
        Call frmOnCallEvent.Display()

        'frmOnCallEvent.ShowDialog()

        'Set the name combo box to the value selected in the log event
        Call modControl.SelectID(CboName, Me.PersonID)

        'Clear the grid
        LstViewLogEvent.Items.Clear()
        LstViewLogEvent.View = View.Details
        'Fill Grid
        Try
            Call modStatQuery.QueryOpenLogEvent(Me)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        'Clear the grid
        LstViewPending.Items.Clear()
        Try
            Call modStatQuery.QueryPendingEvents(Me)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Sub

    Private Sub FrmMessage_Activated(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Activated

        'Clear the grid
        LstViewPending.Items.Clear()
        Call modStatQuery.QueryPendingEvents(Me)

    End Sub

    Private Sub FrmMessage_KeyDown(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles MyBase.KeyDown
        Dim KeyCode As Short = eventArgs.KeyCode
        Dim Shift As Short = eventArgs.KeyData \ &H10000

        If Shift > 0 Then
            Me.ShiftKey = True
        Else
            Me.ShiftKey = False
        End If

        Select Case KeyCode

            Case System.Windows.Forms.Keys.F1
                TabMessage.SelectedIndex = 0
                CboOrganization.Focus()
            Case System.Windows.Forms.Keys.F2
                TabMessage.SelectedIndex = 1
                LstViewPending.Focus()

        End Select


    End Sub

    Private Sub FrmMessage_KeyUp(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles MyBase.KeyUp
        Dim KeyCode As Short = eventArgs.KeyCode
        Dim Shift As Short = eventArgs.KeyData \ &H10000

        If Shift > 0 Then
            Me.ShiftKey = True
        Else
            Me.ShiftKey = False
        End If

    End Sub

    Private Sub FrmMessage_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load
        '************************************************************************************
        'Name: Form_Load
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Loads FrmReferral
        'Returns: Nothing
        'Params: None
        'Stored Procedures: None
        '************************************************************************************
        '====================================================================================
        'Date Changed: 12/28/05                           Changed by: Char Chaput
        'Release #: 7.7.36                                Task: 484
        'Description:  Stattrac was allowing multiple people into a referral. Added a transaction
        'on the record in modStatSave.SaveCallOpenBy when hit at the same time along with
        'set callopenbyid equal to person in this instance of stattrac when the form is loaded
        '====================================================================================
        'Date Changed: 5/01/06                          Changed by: Char Chaput
        'Release #: 8.0                              Release 8.0
        'Description:  Mods for release 8.0 and added code in multiple places for autosave from New Call
        'screen to Referral screen and in Referral screen
        '====================================================================================
        'Date Changed: 6/13/07                       Changed by: Bret Knoll
        'Release #: 8.4                              Task 8.4.3.9
        'Description:  added save to eventlog incoming call
        '   changed the order of the columns.
        '====================================================================================
        '************************************************************************************

        Dim vReturn As New Object
        Call modUtility.CenterForm(ParentForm)

        'Set the call type
        'Me.CallType = Message
        'ccarroll 05/19/2011 - Removed hardcode for Message
        'CallType now dynamic - Message, Import being sent from FrmNew

        Me.Saved = False
        Me.CmdOnCall.Enabled = False
        Me.CmdOnCallMain.Enabled = False
        AppMain.frmOpenAll.TypeEvent = 0 'T.T 11/01/2004 added to know what event referral or message
        'Fill all reference data
        Call modStatRefQuery.ListRefQueryStatEmployee(CboCallByEmployee)

        If Me.FormState = NEW_RECORD Then

            Call modStatRefQuery.ListRefQueryMessageType(CboMessageType, Me.AlertType)

            Call modControl.SelectFirst(CboMessageType)

            'Initialize the call by
            Call modControl.SelectID(CboCallByEmployee, AppMain.ParentForm.StatEmployeeID)

            'Initialize the total call time
            'Me.CallTotalTime = Format(0, "hh:mm:ss")
            Me.TimeSnapshot = Now

            'Initialize the call date
            Me.CallDate = VB6.Format(Now, "mm/dd/yy  hh:mm")

            'Set the call date
            TxtCallDate.Text = Me.CallDate

            'Char Chaput 04/17/06 Save the call record to start the
            'timer for the call
            'For a new record set the callopenby id to person in statrac
            Me.CallOpenByID = AppMain.ParentForm.StatEmployeeID

            Call modStatSave.SaveCall(Me, Me.CallId)

            'Set the contact information
            Me.LblOrganization.Text = Me.MessageCallerOrganization
            Me.LblName.Text = Me.Person
            Me.LblPhone.Text = Me.CallPhoneNumber
            Me.LblExtension.Text = Me.CallPhoneExtension

            'Get the CallerOrganizationID for the record.
            If Me.CallerOrganizationID > 0 Then
                Call modStatRefQuery.RefQueryReference(vReturn, , Me.LblOrganization.Text)
                Me.CallerOrganizationID = CInt(vReturn(0, 0))
            End If

            'Get the CallerOrganizationID for the record.
            If Me.CallerNameID > 0 Then
                Call modStatRefQuery.RefQueryReference(vReturn, , Me.LblName.Text)
                Me.CallerNameID = CInt(vReturn(0, 0))
            End If

            'Get only the organizations associated with the lookup code.
            'Lookup code associations are created using the alert screen.
            Call Me.SourceCode.Organizations.GetItems()
            Call Me.SourceCode.Organizations.FillListBox(CboOrganization)

            'Get DefaultAlert
            If Me.SourceCode.DefaultAlert IsNot Nothing Then
                If (Me.SourceCode.DefaultAlert.Contains(RTF)) Then
                    Me.TxtAlerts(0).Rtf = Me.SourceCode.DefaultAlert
                Else
                    Me.TxtAlerts(0).Text = Me.SourceCode.DefaultAlert
                End If
            End If
            Me.TxtAlerts(1).Text = ""
            Me.TxtAlerts(1).Rtf = ""

        ElseIf Me.FormState = EXISTING_RECORD Then

            '11/16/05 C.Chaput set callopenbyid for this for equal to person in this instance of stattrac
            Me.CallOpenByID = AppMain.ParentForm.StatEmployeeID

            Call modStatRefQuery.ListRefQueryMessageType(CboMessageType)

            '01/05/05 check to see if is exclusive, fscase or pending
            Call modStatQuery.QueryCallAccess(Me)

            'Get the call record
            Call modStatQuery.QueryCall(Me)

            'Set the call date
            TxtCallDate.Text = Me.CallDate

            'Get the Message record
            Call modStatQuery.QueryMessage(Me)

            'Get the CallerOrganizationID for the record.
            If Me.CallerOrganizationID > 0 Then
                Call modStatRefQuery.RefQueryReference(vReturn, , Me.LblOrganization.Text)
                Me.CallerOrganizationID = CInt(vReturn(0, 0))
            End If

            'Get the CallerNameID for the record.
            If Me.CallerNameID > 0 Then
                Call modStatRefQuery.RefQueryReference(vReturn, , Me.LblName.Text)
                Me.CallerNameID = CInt(vReturn(0, 0))
            End If

            If CboOrganization.Text = "" Then
                'Get only the organizations associated with the lookup code.
                'Lookup code associations are created using the alert screen.
                Call Me.SourceCode.Organizations.GetItems()
                Call Me.SourceCode.Organizations.FillListBox(CboOrganization)
                Me.CboName.Items.Clear()
                Me.TxtPersonType.Text = ""

                'Get DefaultAlert
                If Me.SourceCode.DefaultAlert IsNot Nothing Then
                    If (Me.SourceCode.DefaultAlert.Contains(RTF)) Then
                        Me.TxtAlerts(0).Rtf = Me.SourceCode.DefaultAlert
                    Else
                        Me.TxtAlerts(0).Text = Me.SourceCode.DefaultAlert
                    End If
                End If
                Me.TxtAlerts(1).Text = ""
                Me.TxtAlerts(1).Rtf = ""

                'Set the combo box
                Call modControl.SelectID((Me.CboOrganization), Me.OrganizationId)
                Call modControl.SelectID((Me.CboName), Me.PersonID)
            End If

        End If

        'set default from recycled
        If Me.RecycledNC = True Then
            '07/23/07 bret removed for empirix 6708
            'Me.ChkUrgent = vbUnchecked
            Me.ChkTemp.CheckState = System.Windows.Forms.CheckState.Checked
        End If
        Me.Text = "# " & Me.CallId & "    " & Me.SourceCode.Name

        'Log Event Info
        'Initialize the grid
        Call modControl.HighlightListViewRow(LstViewLogEvent)
        Call LstViewLogEvent.Columns.Insert(0, "", "Date           Time", CInt(VB6.TwipsToPixelsX(1400)))
        Call LstViewLogEvent.Columns.Insert(1, "", "Event Type", CInt(VB6.TwipsToPixelsX(1700)))
        Call LstViewLogEvent.Columns.Insert(2, "", "From/To", CInt(VB6.TwipsToPixelsX(1450)))
        Call LstViewLogEvent.Columns.Insert(3, "", "Organization", CInt(VB6.TwipsToPixelsX(2500)))
        Call LstViewLogEvent.Columns.Insert(4, "", "By", CInt(VB6.TwipsToPixelsX(1500)))
        Call LstViewLogEvent.Columns.Insert(5, "", "Description", CInt(VB6.TwipsToPixelsX(4500)))
        Call LstViewLogEvent.Columns.Insert(6, "", "#", CInt(VB6.TwipsToPixelsX(500)))

        'Fill Grid
        Call modStatQuery.QueryOpenLogEvent(Me)

        'Pending Event Info
        'Initialize the grid
        Call modControl.HighlightListViewRow(LstViewPending)
        Call LstViewPending.Columns.Insert(0, "", "Type", CInt(VB6.TwipsToPixelsX(1300)))
        Call LstViewPending.Columns.Insert(1, "", "Organization", CInt(VB6.TwipsToPixelsX(6500)))

        If modStatSecurity.GetPermission(AppMain.ParentForm.StatEmployeeID, "AllowDeleteLogEvent") Then
            Me.CmdDelete.Visible = True
        Else
            Me.CmdDelete.Visible = False
        End If

        'bret 6/11/07 8.4.3.9 LogEventDeleted
        If modStatSecurity.GetPermission(AppMain.ParentForm.StatEmployeeID, "AllowViewDeletedLogEvents") Then
            Me.chkViewLogEventDeleted.Visible = True
        Else
            Me.chkViewLogEventDeleted.Visible = False
        End If

        '5/17/2004 T.T added disable of save button for Lease Organizations
        If AppMain.ParentForm.LeaseOrganizationType = "FamilyServices" Then
            Me.CmdOK.Enabled = False
        End If


        'ccarroll 03/24/2010
        Me.CboMessageType.Focus()
        BringToFront()
        Me.Activate()

        'Reversed the order of two ListView columns to avoid a potentially breaking
        'change to the order of items returned by StoredProcedure: GetLogEventList
        LstViewLogEvent.Columns(5).DisplayIndex = 4
        LstViewLogEvent.Columns(4).DisplayIndex = 5
        
        If Not IsNothing(Me.ScheduleAlert) Then
            modControl.SetRTFText(rtbScheduleAlert, Me.ScheduleAlert)
        End If

    End Sub

    Private Sub FrmMessage_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing
        '====================================================================================
        'Date Changed: 12/28/05                           Changed by: Char Chaput
        'Release #: 7.7.36                                Task: 484
        'Description:  Stattrac was allowing multiple people into a referral. Added a transaction
        'on the record in modStatSave.SaveCallOpenBy when hit at the same time and
        'set callopenbyid = -1 when the form is unloaded if the person have save ability only
        '====================================================================================

        Dim vReferralID As Integer
        Dim vCallOpenByID As Short
        Dim vReturns As New Object
        Dim NoteText As String = ""
        Dim vReturn As Short

        If Me.Saved = True Then

            eventArgs.Cancel = False
            
        Else

            'ccarroll 12/12/2008 StatTrac 8.4.7 - added check for CallOpenByID
            'so that redundant pop-up can be eliminated.
            'The message was can celled or closed so confirm cancellation
            If Me.CallOpenByID = -1 Then 'User has answered exit question
                vReturn = MsgBoxResult.Yes
            Else
                vReturn = modMsgForm.FormCancel
            End If


            If vReturn = MsgBoxResult.Yes Then

                If Me.FormState = NEW_RECORD Then
                    'Save the call first, using same logic as cmdOk
                    Call modStatSave.SaveCall(Me, Me.CallId)
                    vReferralID = modStatSave.SaveMessage(Me)
                    If vReferralID = SQL_ERROR Then
                        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Nothing, "No referralid on callid lookup, callid: " & Me.CallId)
                    End If
                    'Char Chaput 05/12/06 added for 8.0 to add event of who/when cancelled out of the note
                    NoteText = "Case deleted by " & AppMain.ParentForm.StatEmployeeName & " on " & Today & " at " & TimeOfDay
                    Call modStatSave.SaveLogEvent(Me, 17, NoteText)
                    'A new call was created but not saved.
                    'Remove the call record
                    Call modStatSave.DeleteCall(Me.CallId)
                    'And unload
                    eventArgs.Cancel = False
                    
                ElseIf Me.FormState = EXISTING_RECORD Then
                    eventArgs.Cancel = False

                    'check to see if user has access or has callopen by
                    If modStatRefQuery.RefQueryCall(vReturns, Me.CallId) = SUCCESS Then
                        vCallOpenByID = CShort(vReturns(0, 5))

                        If vCallOpenByID > 0 And vCallOpenByID = AppMain.ParentForm.StatEmployeeID Then
                            'Char Chaput 12/27/05
                            'Update call open by only if have save ability and callopenbyid = AppMain.ParentForm.StatEmployeeID
                            If Me.CmdOK.Enabled Then
                                Me.CallOpenByID = -1
                                If Me.RecycledNC = True Then
                                    eventArgs.Cancel = False
                                End If
                                'bret 06/08/07 use new save routine
                                Call modStatSave.SaveCallCancel(Me)
                            End If
                        Else
                            Me.CallOpenByID = 0
                            'bret 06/08/07 use new save routine
                            Call modStatSave.SaveCallCancel(Me)

                        End If
                    End If
                    
                End If
            Else
                eventArgs.Cancel = True
                Exit Sub
            End If

            'Close related windows
            If Not IsNothing(frmLogEvent) Then
                frmLogEvent.Close()
                frmLogEvent = Nothing
            End If
            If Not IsNothing(frmOnCallEvent) Then
                frmOnCallEvent.Close()
                frmOnCallEvent = Nothing

            End If

        End If
        Me.Dispose()
        AppMain.frmMessage = Nothing
    End Sub

    Private Sub LstViewLogEvent_ColumnClick(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.ColumnClickEventArgs) Handles LstViewLogEvent.ColumnClick
        Dim ColumnHeader As System.Windows.Forms.ColumnHeader = LstViewLogEvent.Columns(eventArgs.Column)
        Dim sort As String
        If Me.SortOrder = System.Windows.Forms.SortOrder.Ascending Then
            Me.SortOrder = System.Windows.Forms.SortOrder.Descending
            sort = "DESC"
        Else
            Me.SortOrder = System.Windows.Forms.SortOrder.Ascending
            sort = "ASC"
        End If

        LstViewLogEvent.Items.Clear()

        Try
            Call modStatQuery.QueryOpenLogEvent(Me, ColumnHeader.Text, sort)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Sub
    Private Sub LstViewLogEvent_DoubleClick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewLogEvent.DoubleClick
        '************************************************************************************
        'Name: LstViewLogEvent_DblClick
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: checks if the event can be edited anc calls the edit form
        'Returns: n/a
        'Params: n/a
        '
        '
        'Stored Procedures: n/a
        '====================================================================================
        '====================================================================================
        'Date Changed: 06/13/07                       Changed by: Bret Knoll
        'Release #: 8.4.3.9                            Task: LogEvent Delete
        'Description:
        '   Prevent Deleted from being edited
        '
        '====================================================================================

        Dim vLogEventID As Integer
        Dim I As Short
        Dim vEventTypeList(12) As Object
        Dim vReturn As New Object
        frmLogEvent = New FrmLogEvent

        'bret 06/11/2007 8.4.3.9 edit deleted event
        'SubItems(1) = Event Type
        If LstViewLogEvent.FocusedItem.SubItems(1).Text = "DELETED EVENT" Then
            Call MsgBox("You may not edit a Deleted Event.")
            Exit Sub            
        ElseIf String.IsNullOrWhiteSpace(LstViewLogEvent.FocusedItem.Text) Then
            Exit Sub
        End If

        'Get the call ID and set the values to be passed
        frmLogEvent.FormState = EXISTING_RECORD

        'Set the call id & number of the LogEvent form to
        '0 to indicate table maintenence
        frmLogEvent.CallId = Me.CallId
        frmLogEvent.CallNumber = Me.CallNumber
        frmLogEvent.OrganizationTimeZone = Me.OrganizationTimeZone

        'Get the ID of the LogEvent to open
        frmLogEvent.LogEventID = modConv.TextToLng(LstViewLogEvent.FocusedItem.Tag)
        Try
            If modStatRefQuery.RefQueryLogEventType(vReturn, frmLogEvent.LogEventID) = SUCCESS Then
                frmLogEvent.LogEventTypeID = vReturn(0, 0)
            End If
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        'Set event types
        vEventTypeList(0) = INCOMING
        vEventTypeList(1) = OUTGOING
        vEventTypeList(2) = GENERAL
        vEventTypeList(3) = PAGE_PENDING
        vEventTypeList(4) = PAGE_RESPONSE
        vEventTypeList(5) = CALLBACK_PENDING
        vEventTypeList(6) = NO_PAGE_RESPONSE
        vEventTypeList(7) = EMAIL_PENDING
        vEventTypeList(8) = EMAIL_RESPONSE
        vEventTypeList(9) = CASE_HAND_OFF
        vEventTypeList(10) = Case_Update
        vEventTypeList(11) = EMAIL_SENT
        vEventTypeList(12) = PAGE_SENT


        frmLogEvent.LogEventTypeList = VB6.CopyArray(vEventTypeList)

        '10/22/01 drh
        frmLogEvent.vParentForm = Me

        'Get the LogEvent id from the LogEvent form
        'after the user is done.
        Me.SendToBack()
        Call frmLogEvent.Display()

        'Clear the grid
        LstViewLogEvent.Items.Clear()
        LstViewLogEvent.View = View.Details
        'Fill Grid
        Try
            Call modStatQuery.QueryOpenLogEvent(Me)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        'Clear the grid
        LstViewPending.Items.Clear()
        Try
            Call modStatQuery.QueryPendingEvents(Me)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        Me.Activate()

    End Sub


    Private Sub LstViewPending_DoubleClick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewPending.DoubleClick
        '************************************************************************************
        'Name: LstViewPending_DblClick
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Loads FrmOnCallEvent, along with associated variables
        'Returns: Nothing
        'Params: None
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 12/16/04                         Changed by: Scott Plummer
        'Release #: 7.7.2                               Task: 312
        'Description:  Added Email Pending event type, ability to populate email variables.
        '====================================================================================
        '************************************************************************************

        frmLogEvent = New FrmLogEvent
        frmOnCallEvent = New FrmOnCallEvent
        Dim vEventTypeList(1) As Object
        Dim vLogEventTypeID As Integer

        '***********************
        'Then open the log event
        '***********************

        'Get the call ID and set the values to be passed
        frmLogEvent.FormState = EXISTING_RECORD

        'Set the call id & number of the LogEvent form to
        '0 to indicate table maintenence
        frmLogEvent.CallId = Me.CallId
        frmLogEvent.CallNumber = Me.CallNumber

        'Get the ID of the LogEvent to open
        frmLogEvent.LogEventID = modConv.TextToLng(LstViewPending.FocusedItem.Tag)

        'Find the event type
        Try
            Call modStatQuery.QueryLogEventTypeID((frmLogEvent.LogEventID), vLogEventTypeID)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        Select Case vLogEventTypeID

            Case PAGE_PENDING
                vEventTypeList(0) = PAGE_RESPONSE
                vEventTypeList(1) = NO_PAGE_RESPONSE
                frmLogEvent.DefaultContactType = PAGE_RESPONSE

            Case EMAIL_PENDING
                vEventTypeList(0) = EMAIL_RESPONSE
                vEventTypeList(1) = NO_PAGE_RESPONSE
                frmLogEvent.DefaultContactType = EMAIL_RESPONSE

            Case CALLBACK_PENDING
                vEventTypeList(0) = INCOMING
                vEventTypeList(1) = OUTGOING
                frmLogEvent.DefaultContactType = OUTGOING
        End Select

        frmLogEvent.LogEventTypeList = VB6.CopyArray(vEventTypeList)
        frmLogEvent.UpdatePendingEvent = True

        'Added ability to send info in email.  12/16/04 - SAP
        Try
            frmOnCallEvent.EmailMsg = modStatValidate.SetMessageEmail(Me)
            frmOnCallEvent.EmailSbj = modStatValidate.SetMessageEmailSbj(Me)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        '10/22/01 drh
        frmLogEvent.vParentForm = Me

        'Get the LogEvent id from the LogEvent form
        'after the user is done.
        Me.SendToBack()
        Call frmLogEvent.Display()

        'Clear the grid
        LstViewLogEvent.Items.Clear()
        LstViewLogEvent.View = View.Details
        'Fill Grid
        Try
            Call modStatQuery.QueryOpenLogEvent(Me)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        'Clear the grid
        LstViewPending.Items.Clear()
        Try
            Call modStatQuery.QueryPendingEvents(Me)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        Me.Activate()

    End Sub


    Private Sub TimerTotalTime_Tick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TimerTotalTime.Tick

        Dim vTimeDiff As New Object

        vTimeDiff = DateDiff(Microsoft.VisualBasic.DateInterval.Second, Me.TimeSnapshot, Now)

        TxtTotalTimeCounter.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Second, vTimeDiff, Me.CallTotalTime), "hh:mm:ss")
        Me.CallTotalTime = TxtTotalTimeCounter.Text

        'Take a snap shot of the time
        Me.TimeSnapshot = Now

    End Sub

    Private Sub TxtCallDate_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtCallDate.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        KeyAscii = modMask.DateTimeMask(KeyAscii, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtCallDate_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtCallDate.Leave

        Me.CallDate = TxtCallDate.Text

    End Sub

    Private Sub TxtCallerPhone_GotFocus()

        Call modControl.HighlightText(ActiveControl)

    End Sub

    Private Sub TxtCallerPhone_KeyPress(ByRef KeyAscii As Short)

        KeyAscii = modMask.PhoneMask(KeyAscii, ActiveControl)

    End Sub

    Private Sub TxtExtension_GotFocus()

        Call modControl.HighlightText(ActiveControl)

        vOldValue = ActiveControl.Text

    End Sub


    Private Sub TxtExtension_KeyPress(ByRef KeyAscii As Short)

        KeyAscii = modMask.NumMask(KeyAscii, 5, ActiveControl)

    End Sub


    Private Sub TxtExtension_Validate(ByRef Cancel As Boolean)

        If vOldValue <> ActiveControl.Text Then

            'Save the new value

        End If

    End Sub

    Private Sub TxtLastName_GotFocus()

        Call modControl.HighlightText(ActiveControl)

        vOldValue = ActiveControl.Text

    End Sub


    Private Sub TxtLastName_Validate(ByRef Cancel As Boolean)

        If vOldValue <> ActiveControl.Text Then

            'Save the new value

        End If

    End Sub


    Private Sub TxtImportCenter_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtImportCenter.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtMessage_KeyDown(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles TxtMessage.KeyDown
        Dim KeyCode As Short = eventArgs.KeyCode
        Dim Shift As Short = eventArgs.KeyData \ &H10000

        If Shift = 2 Then
            KeyCode = IIf(KeyCode = System.Windows.Forms.Keys.Tab, 0, KeyCode)
        End If

        KeyCode = IIf(KeyCode = System.Windows.Forms.Keys.Return, 0, KeyCode)

    End Sub

    Private Sub TxtMessage_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtMessage.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        Call modStatQuery.QueryKeyCodePhrase(TxtMessage, KeyAscii)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtMessage_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtMessage.Leave

        Call modStatValidate.ValidateSpelling(TxtMessage)

    End Sub


    Private Sub TxtPersonType_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtPersonType.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub

    Private Sub TxtTotalTimeCounter_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtTotalTimeCounter.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        KeyAscii = 0
        'KeyAscii = modMask.TimerMask(KeyAscii, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtUNOSID_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtUNOSID.Enter

        Call modControl.HighlightText(ActiveControl)

        vOldValue = ActiveControl.Text

    End Sub


    Private Sub TxtUNOSID_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtUNOSID.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtUNOSID_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles TxtUNOSID.Validating
        Dim Cancel As Boolean = eventArgs.Cancel

        If vOldValue <> ActiveControl.Text Then

            'Save the new value

        End If

        eventArgs.Cancel = Cancel
    End Sub

    Private Sub VP_Timer_Tick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles VP_Timer.Tick


    End Sub

End Class
