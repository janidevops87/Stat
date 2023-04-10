Option Strict Off
Option Explicit On
Imports VB = Microsoft.VisualBasic
Public Class FrmOpenAll
    Inherits System.Windows.Forms.Form

    Dim PageSortOrder As Short
    Dim IncompleteSortOrder As Short
    Dim CalloutSortOrder As Short
    Dim SecondarySortOrder As Short

    Public fvCallDate As Date
    '6/27/01 drh Added variable for Secondary Alert sort order
    Dim SecondaryAlertSortOrder As Short
    Public vRecycledNC As Object

    Dim ConsentSortOrder As Short
    Dim RecoverySortOrder As Short
    Dim ReferralSortOrder As Short
    Dim MessageSortOrder As Short
    'mds 10/21/03 added InformationSortOrder% variable
    Dim InformationSortOrder As Short
    Dim NoCallSortOrder As Short
    Dim LastSortColumn As Short
    Dim CurrentDate As String = ""
    Public CallId As Integer
    Public DonorName As String
    Dim AllowDelete As Boolean
    Public TypeEvent As Short
    Public GeneralAlerts As New colGeneralAlerts
    Public SourceCodes As New colSourceCodes
    Public ExitReferral As Boolean 'T.T 08/28/2006 exit referral load
    Private TabCallTypeTable As Hashtable
    '6/27/01 drh Added function for switching between Family Services
    'and other Call Type tabs
    Private Sub switchFSCallType()

        If IsNothing(TabCallTypeTable) Then
            Return
        End If
        If Me.TabCallType.SelectedIndex = Me.TabCallType.TabPages.IndexOf(TabCallTypeTable(DASHBOARD_TAB_FAMILY_SERVICES)) Then
            TabCallType.Height = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(Me.ClientRectangle.Height) - (VB6.PixelsToTwipsY(LstViewGeneralAlert.Height)) - 120)
            TabCallType.Top = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(Me.ClientRectangle.Height) - VB6.PixelsToTwipsY(TabCallType.Height))
        Else
            TabCallType.Height = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(Me.ClientRectangle.Height) - (VB6.PixelsToTwipsY(LstViewPendingPage.Height) + VB6.PixelsToTwipsY(LstViewGeneralAlert.Height)) - 120)
            TabCallType.Top = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(Me.ClientRectangle.Height) - VB6.PixelsToTwipsY(TabCallType.Height))
        End If

    End Sub


    Private Sub CmdClearFilters_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdClearFilters.Click
        '************************************************************************************
        'Name: CmdClearFilters_Click
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Clears the input text boxes used to filter dashboard searches
        'Returns: Nothing
        'Params: None
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 5/24/05                          Changed by: Scott Plummer
        'Release #: 8.0                               Task: 416
        'Description:  Added handling for new Updates and Recycle tabs, also changed numeric
        '              values to constants.
        '************************************************************************************
        Dim vTimeZoneDif As Short

        vTimeZoneDif = modStatQuery.QueryTimeZoneDif(AppMain.ParentForm.TimeZone)
        'reset sorting to default if clear filters clicked
        LstViewOpenReferral.Sorting = 0

        Select Case TabCallType.SelectedTab.Name

            Case TabCallTypeTable(DASHBOARD_TAB_REFERRAL).Name
                TxtCallNumberRef.Text = ""
                TxtFromDateRef.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -12, DateAdd(Microsoft.VisualBasic.DateInterval.Hour, vTimeZoneDif, Now)), "mm/dd/yy")
                TxtFromTimeRef.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -12, DateAdd(Microsoft.VisualBasic.DateInterval.Hour, vTimeZoneDif, Now)), "hh:mm")
                TxtToDateRef.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, 12, DateAdd(Microsoft.VisualBasic.DateInterval.Hour, vTimeZoneDif, Now)), "mm/dd/yy")
                TxtToTimeRef.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, 12, DateAdd(Microsoft.VisualBasic.DateInterval.Hour, vTimeZoneDif, Now)), "hh:mm")

                TxtLocationRef.Text = ""
                TxtStateRef.Text = ""
                TxtPatientFirstRef.Text = ""
                TxtPatientLastRef.Text = ""
                TxtReferralType.Text = ""
                TxtRefSource.Text = ""
                ' Added two new text boxes for v. 8.0.  5/24/05 - SAP
                txtPreRefType.Text = ""
                txtTcNameRef.Text = ""

            Case TabCallTypeTable(DASHBOARD_TAB_MESSAGES).Name
                TxtCallNumberMsg.Text = ""
                TxtToDateMsg.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, vTimeZoneDif, Now), "mm/dd/yy")
                TxtFromDateMsg.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Day, -1, DateAdd(Microsoft.VisualBasic.DateInterval.Hour, vTimeZoneDif, Now)), "mm/dd/yy")
                TxtLocationMsg.Text = ""
                TxtStateMsg.Text = ""
                TxtForPersonFirst.Text = ""
                TxtForPersonLast.Text = ""
                TxtMessageType.Text = ""
                TxtMsgSource.Text = ""
                TxtMsgFrom.Text = ""
                TxtMsgTx.Text = "" 'T.T 05/26/2006 clear txt

            Case TabCallTypeTable(DASHBOARD_TAB_NO_CALLS).Name
                TxtCallNumberNC.Text = ""
                TxtToDateNC.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, vTimeZoneDif, Now), "mm/dd/yy")
                TxtFromDateNC.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Day, -1, DateAdd(Microsoft.VisualBasic.DateInterval.Hour, vTimeZoneDif, Now)), "mm/dd/yy")
                TxtMessageType.Text = ""
                ' Bug fix, added TxtNoCallType to list of cleared text boxes.  5/24/05 - SAP
                TxtNoCallType.Text = ""
                TxtDescription.Text = ""
                TxtNoCallSource.Text = ""

            Case TabCallTypeTable(DASHBOARD_TAB_CONSENTS_PENDING).Name
                TxtType.Text = ""
                TxtCallNumber.Text = ""
                TxtToDate.Text = ""
                TxtFromDate.Text = ""
                TxtLocation.Text = ""
                TxtState.Text = ""
                TxtPatientFirst.Text = ""
                TxtPatientLast.Text = ""
                TxtOrg.Text = ""
                TxtOrgPerson.Text = ""
                TxtConsentSource.Text = ""

                'mds 10/21/03 Added clears for Information tab
            Case TabCallTypeTable(DASHBOARD_TAB_INFO).Name
                TxtCallNumberInfo.Text = ""
                TxtFromDateInfo.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Day, -1, DateAdd(Microsoft.VisualBasic.DateInterval.Hour, vTimeZoneDif, Now)), "mm/dd/yy")
                TxtToDateInfo.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, vTimeZoneDif, Now), "mm/dd/yy")
                TxtFirstNameInfo.Text = ""
                TxtLastNameInfo.Text = ""
                TxtCoalitionInfo.Text = ""
                TxtStateInfo.Text = ""
                TxtSourceInfo.Text = ""

                ' Added Updates tab, v. 8.0, 5/24/05 - SAP
                'ccarroll 06/13/2006 Changed default time settings to match Referral tab
            Case TabCallTypeTable(DASHBOARD_TAB_UPDATES).Name
                txtCallNumberUpdate.Text = ""
                txtFromDateUpdate.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -12, DateAdd(Microsoft.VisualBasic.DateInterval.Hour, vTimeZoneDif, Now)), "mm/dd/yy")
                txtFromTimeUpdate.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -12, DateAdd(Microsoft.VisualBasic.DateInterval.Hour, vTimeZoneDif, Now)), "hh:mm")
                txtToDateUpdate.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, 12, DateAdd(Microsoft.VisualBasic.DateInterval.Hour, vTimeZoneDif, Now)), "mm/dd/yy")
                txtToTimeUpdate.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, 12, DateAdd(Microsoft.VisualBasic.DateInterval.Hour, vTimeZoneDif, Now)), "hh:mm")
                txtLocationUpdate.Text = ""
                txtStateUpdate.Text = ""
                txtPatientFirstUpdate.Text = ""
                txtPatientLastUpdate.Text = ""
                txtReferralTypeUpdate.Text = ""
                txtRefSourceUpdate.Text = ""
                txtPreRefTypeUpdate.Text = ""
                txtTcNameUpdate.Text = ""

                ' Added Updates tab, v. 8.0, 5/24/05 - SAP
            Case TabCallTypeTable(DASHBOARD_TAB_RECYCLE).Name
                'Input params for Referrals
                txtCallNumberRecycle.Text = ""
                txtFromDateRecycle.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Day, -1, DateAdd(Microsoft.VisualBasic.DateInterval.Hour, vTimeZoneDif, Now)), "mm/dd/yy")
                txtFromTimeRecycle.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Day, -1, DateAdd(Microsoft.VisualBasic.DateInterval.Hour, vTimeZoneDif, Now)), "hh:mm")
                txtToDateRecycle.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, 12, DateAdd(Microsoft.VisualBasic.DateInterval.Hour, vTimeZoneDif, Now)), "mm/dd/yy")
                txtToTimeRecycle.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, 12, DateAdd(Microsoft.VisualBasic.DateInterval.Hour, vTimeZoneDif, Now)), "hh:mm")
                txtLocationRecycle.Text = ""
                txtStateRecycle.Text = ""
                txtPatientFirstRecycle.Text = ""
                txtPatientLastRecycle.Text = ""
                txtReferralTypeRecycle.Text = ""
                txtRefSourceRecycle.Text = ""
                txtPreRefTypeRecycle.Text = ""
                txtTcNameRecycle.Text = ""
                'Input params for Messages
                txtCallNumberMsgRecycle.Text = ""
                txtFromDateMsgRecycle.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Day, -1, DateAdd(Microsoft.VisualBasic.DateInterval.Hour, vTimeZoneDif, Now)), "mm/dd/yy")
                txtToDateMsgRecycle.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, vTimeZoneDif, Now), "mm/dd/yy")
                txtForPersonFirstRecycle.Text = ""
                txtForPersonLastRecycle.Text = ""
                txtLocationMsgRecycle.Text = ""
                txtStateMsgRecycle.Text = ""
                txtMessageTypeRecycle.Text = ""
                txtMsgSourceRecycle.Text = ""
                txtMsgFromRecycle.Text = ""
                txtMsgTxRecycle.Text = ""

        End Select

        '11/28/01 drh Refresh Referrals
        'Bret 06/05/07 8.3.4.1 Call CmdRefesh_click() instead of Referesh referrals
        Call CmdRefresh_Click(CmdRefresh, New System.EventArgs())


    End Sub

    Private Sub CmdClearFilters_MouseDown(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.MouseEventArgs) Handles CmdClearFilters.MouseDown
        Dim Button As Short = eventArgs.Button \ &H100000
        Dim Shift As Short = System.Windows.Forms.Control.ModifierKeys \ &H10000
        Dim x As Single = VB6.PixelsToTwipsX(eventArgs.X)
        Dim y As Single = VB6.PixelsToTwipsY(eventArgs.Y)
        '************************************************************************************
        'Name: CmdClearFilters_MouseDown
        'Date Created: 06/5/07                          Created by: Bret Knoll
        'Release: 8.3.4.1                               Task: Check for ValidateDate
        'Description: Fixes the date if invalid
        'Returns: Nothing
        'Params: None
        'Stored Procedures: None
        '====================================================================================
        ' This should be a shortterm fix
        '************************************************************************************
        On Error Resume Next

        'modUtility.Work

        'Get the other lists depending on which list is displayed
        Select Case TabCallType.SelectedIndex
            Case DASHBOARD_TAB_REFERRAL
                TxtFromDateRef.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -12, Now), "mm/dd/yy")
                TxtToDateRef.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, 12, Now), "mm/dd/yy")
            Case DASHBOARD_TAB_MESSAGES
                TxtFromDateMsg.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -12, Now), "mm/dd/yy")
                TxtToDateMsg.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, 12, Now), "mm/dd/yy")
            Case DASHBOARD_TAB_NO_CALLS
                TxtFromDateNC.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -12, Now), "mm/dd/yy")
                TxtToDateNC.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, 12, Now), "mm/dd/yy")
            Case DASHBOARD_TAB_INFO
                TxtFromDateInfo.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -12, Now), "mm/dd/yy")
                TxtToDateInfo.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, 12, Now), "mm/dd/yy")
            Case DASHBOARD_TAB_UPDATES
                txtFromDateUpdate.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -12, Now), "mm/dd/yy")
                txtToDateUpdate.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, 12, Now), "mm/dd/yy")
            Case DASHBOARD_TAB_RECYCLE
                txtFromDateRecycle.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -12, Now), "mm/dd/yy")
                txtToDateRecycle.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, 12, Now), "mm/dd/yy")
                txtFromDateMsgRecycle.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -12, Now), "mm/dd/yy")
                txtToDateMsgRecycle.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, 12, Now), "mm/dd/yy")
        End Select

        'modUtility.Done

    End Sub

    Private Sub CmdDeleteMsg_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdDeleteMsg.Click
        '************************************************************************************
        'Name: CmdDeleteMsg_Click
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Warns user, then deletes message
        'Returns: Nothing
        'Params: None
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 5/26/05                          Changed by: Scott Plummer
        'Release #: 8.0                               Task: 416
        'Description:  Reduced scariness of msgbox, added information about recycle bin.
        '************************************************************************************
        On Error Resume Next

        Dim vReturn As New Object
        Dim NoteText As String = ""

        'Check who has focus
        If Not LstViewOpenMessage.FocusedItem.Selected Then
            Exit Sub
        End If

        If Me.LstViewOpenMessage.Items.Count > 0 Then


            vReturn = MsgBox("You are about to delete message # " & LstViewOpenMessage.FocusedItem.Tag & "." & Chr(10) & Chr(13) & "This will place this message in the recycle bin." & Chr(10) & Chr(13) & "If you wish to restore it, use the Recycle tab. " & Chr(10) & Chr(13) & "Do you wish to continue?", MsgBoxStyle.YesNo + MsgBoxStyle.DefaultButton2, "Delete Call")

            Select Case vReturn
                Case MsgBoxResult.Yes

                    'Get the call id
                    Me.CallId = modConv.TextToLng(LstViewOpenMessage.FocusedItem.Tag)

                    'Char Chaput 05/12/06 added for 8.0 to add event of who/when cancelled out of the note
                    NoteText = "Case deleted by " & AppMain.ParentForm.StatEmployeeName & " on " & Today & " at " & TimeOfDay
                    Me.fvCallDate = CDate(VB6.Format(Now, "mm/dd/yy  hh:mm"))
                    Call modStatSave.SaveLogEvent(Me, 17, NoteText)

                    'Delete the call id
                    Call modStatSave.DeleteCall(Me.CallId)

                    'Fill Grid
                    Call CmdRefresh_Click(CmdRefresh, New System.EventArgs())

                Case MsgBoxResult.No
                    Exit Sub
            End Select

        End If

    End Sub

    Private Sub CmdDeleteNC_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdDeleteNC.Click

        On Error Resume Next

        Dim vReturn As New Object

        'Check who has focus
        If Not LstViewOpenNoCall.FocusedItem.Selected Then
            Exit Sub
        End If

        If Me.LstViewOpenNoCall.Items.Count > 0 Then

            vReturn = MsgBox("You are about to delete a call # " & LstViewOpenNoCall.FocusedItem.Tag & "." & Chr(10) & Chr(13) & "This action cannot be undone!!! Are you sure you want to continue?", MsgBoxStyle.YesNo + MsgBoxStyle.DefaultButton2, "Delete Call")

            Select Case vReturn
                Case MsgBoxResult.Yes

                    vReturn = MsgBox("You are *really* sure you want to delete a call # " & LstViewOpenNoCall.FocusedItem.Tag & "." & Chr(10) & Chr(13) & "Once it's gone, it's gone. This is your last chance. With this in mind, are you *positive* you want to continue?", MsgBoxStyle.YesNo + MsgBoxStyle.DefaultButton2, "Delete Call")

                    If vReturn = MsgBoxResult.Yes Then

                        'Get the call id
                        Me.CallId = modConv.TextToLng(LstViewOpenNoCall.FocusedItem.Tag)

                        'Delete the call id
                        Call modStatSave.DeleteCall(Me.CallId)

                        'Fill Grid
                        Call CmdRefresh_Click(CmdRefresh, New System.EventArgs())

                    Else
                        Exit Sub
                    End If

                Case MsgBoxResult.No
                    Exit Sub
            End Select

        End If

    End Sub

    Private Sub CmdDeleteRef_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdDeleteRef.Click
        '************************************************************************************
        'Name: CmdDeleteRef_Click
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Warns user, then deletes referral
        'Returns: Nothing
        'Params: None
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 5/25/05                          Changed by: Scott Plummer
        'Release #: 8.0                               Task: 416
        'Description:  Reduced scariness of message, added information about recycle bin.
        '************************************************************************************
        Dim vReturn As New Object
        Dim NoteText As String = ""

        On Error Resume Next

        'Check who has focus
        If Not LstViewOpenReferral.FocusedItem.Selected Then
            Exit Sub
        End If

        Dim vResults As Object
        vResults = New Object()
        If Me.LstViewOpenReferral.Items.Count > 0 Then

            ' Reduced scariness of message, inform about how to restore.  5/25/05 - SAP
            vReturn = MsgBox("You are about to delete referral # " & LstViewOpenReferral.FocusedItem.Tag & "." & Chr(10) & Chr(13) & "This will place this referral in the recycle bin." & Chr(10) & Chr(13) & "If you wish to restore it, use the Recycle tab. " & Chr(10) & Chr(13) & "Do you wish to continue?", MsgBoxStyle.YesNo + MsgBoxStyle.DefaultButton2, "Delete Call")

            Select Case vReturn
                Case MsgBoxResult.Yes
                    ' Removed second warning.  5/25/05 - SAP

                    'Get the call id
                    Me.CallId = modConv.TextToLng(LstViewOpenReferral.FocusedItem.Tag)

                    '7/9/01 drh TC's cannot delete Family Service Calls
                    Call modStatQuery.QueryFSCase(Me, vResults)
                    If TypeOf vResults Is Array Then
                        'If Not IsNothing(vResults) Then
                        If AppMain.ParentForm.PersonTypeID = TRIAGE_COORDINATOR Then
                            Call MsgBox("Sorry, you don't have permissions to delete a Family Services call.", MsgBoxStyle.OkOnly)
                            Exit Sub
                        End If
                    End If

                    'Char Chaput 05/12/06 added for 8.0 to add event of who/when cancelled out of the note
                    NoteText = "Referral deleted by " & AppMain.ParentForm.StatEmployeeName & " on " & Today & " at " & TimeOfDay
                    fvCallDate = CDate(VB6.Format(Now, "mm/dd/yy  hh:mm"))
                    Call modStatSave.SaveLogEvent(Me, 17, NoteText)

                    'Delete the call id
                    Call modStatSave.DeleteCall(Me.CallId)

                    'Fill Grid
                    Call CmdRefresh_Click(CmdRefresh, New System.EventArgs())

                Case MsgBoxResult.No
                    Exit Sub
            End Select

        End If

    End Sub
    Private Sub cmdFormView_Click()
        AppMain.frmReferralView = New FrmReferralView()
        AppMain.frmReferralView.Show()
    End Sub

    Private Sub CmdLineCheck_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdLineCheck.Click

        ' FrmLineCheckList.Display()

    End Sub

    Private Sub CmdNewCall_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdNewCall.Click
        '************************************************************************************
        'Name: CmdNewCall_Click
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: create a new call open AppMain.frmNew
        '
        '
        'Stored Procedures: na
        '====================================================================================

        'Commented out and using display function so that the object can be destroyed

        'ccarroll 04/19/2010 create new instance of frmNew
        AppMain.OpenFormNew()

    End Sub


    Private Sub CmdRefresh_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdRefresh.Click
        '************************************************************************************
        'Name: CmdRefresh_Click
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Refreshes data in listview on tab
        'Returns: Nothing
        'Params: None
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 5/24/05                          Changed by: Scott Plummer
        'Release #: 8.0                               Task: 416
        'Description:  Added handling for new Updates and Recycle tabs, also changed numeric
        '              values to constants.
        '====================================================================================
        'Date Changed: 6/14/05                        Changed by: Bret Knoll
        'Release #: 8.4                               Task: 8.4.3.3
        'Description:
        '      add a call to new method CheckSearchParameters. if true is returned continue the search.
        '       if false is returned exit the sub.
        '      added the Family Services section to Case statement
        '************************************************************************************

        On Error GoTo localError

        modUtility.Work()
        Dim fromDateCancel As Boolean 'used to validate the fromDateCancel
        Dim toDateCancel As Boolean 'used to validate the toDateCancel
        Dim test As Boolean

        Call Me.RefreshLists()

        'bret 06/14/07 8.4.3.3 prevent delays
        If (Not CheckSearchParameters()) Then
            modUtility.Done()
            Exit Sub

        End If

        'Get the other lists depending on which list is displayed
        Select Case TabCallType.TabPages.Item(TabCallType.SelectedIndex).Name ' TabCallType.TabPages.IndexOf(TabCallType.SelectedTab)
            Case TabCallTypeTable(DASHBOARD_TAB_REFERRAL).Name
                Call TxtFromDateRef_Validating(TxtFromDateRef, New System.ComponentModel.CancelEventArgs(fromDateCancel))
                Call TxtToDateRef_Validating(TxtToDateRef, New System.ComponentModel.CancelEventArgs(toDateCancel))
                If Not (fromDateCancel Or toDateCancel) Then
                    Call modStatQuery.QuerySearchOpenReferral(Me)
                End If
            Case TabCallTypeTable(DASHBOARD_TAB_MESSAGES).Name
                Call TxtFromDateMsg_Validating(TxtFromDateMsg, New System.ComponentModel.CancelEventArgs(fromDateCancel))
                Call TxtToDateMsg_Validating(TxtToDateMsg, New System.ComponentModel.CancelEventArgs(toDateCancel))
                If Not (fromDateCancel Or toDateCancel) Then
                    Call modStatQuery.QuerySearchOpenMessage(Me)
                End If
            Case TabCallTypeTable(DASHBOARD_TAB_NO_CALLS).Name
                Call TxtFromDateNC_Validating(TxtFromDateNC, New System.ComponentModel.CancelEventArgs(fromDateCancel))
                Call TxtToDateNC_Validating(TxtToDateNC, New System.ComponentModel.CancelEventArgs(toDateCancel))
                If Not (fromDateCancel Or toDateCancel) Then
                    Call modStatQuery.QuerySearchOpenNoCall(Me)
                End If
            Case TabCallTypeTable(DASHBOARD_TAB_FAMILY_SERVICES).Name


            Case TabCallTypeTable(DASHBOARD_TAB_CONSENTS_PENDING).Name
                Call modStatQuery.QuerySearchConsentPending(Me)
                ConsentSortOrder = System.Windows.Forms.SortOrder.Ascending
                Call LstViewPendingConsent_ColumnClick(LstViewPendingConsent, New System.Windows.Forms.ColumnClickEventArgs(LstViewPendingConsent.Columns.Item(1).Index))
                'mds 10/21/03 Added for information call lookups
            Case TabCallTypeTable(DASHBOARD_TAB_INFO).Name
                Call TxtFromDateInfo_Validating(TxtFromDateInfo, New System.ComponentModel.CancelEventArgs(fromDateCancel))
                Call TxtToDateInfo_Validating(TxtToDateInfo, New System.ComponentModel.CancelEventArgs(toDateCancel))
                If Not (fromDateCancel Or toDateCancel) Then
                    Call modStatQuery.QuerySearchOpenInformation(Me)
                End If
                ' Added for v. 8.0.  5/24/05 - SAP
            Case TabCallTypeTable(DASHBOARD_TAB_UPDATES).Name
                Call txtFromDateUpdate_Validating(txtFromDateUpdate, New System.ComponentModel.CancelEventArgs(fromDateCancel))
                Call txtToDateUpdate_Validating(txtToDateUpdate, New System.ComponentModel.CancelEventArgs(toDateCancel))
                If Not (fromDateCancel Or toDateCancel) Then
                    Call modStatQuery.QuerySearchOpenUpdate(Me)
                End If
            Case TabCallTypeTable(DASHBOARD_TAB_RECYCLE).Name
                CmdRestoreReferral.Enabled = False
                cmdRestoreMessage.Enabled = False
                Call txtFromDateRecycle_Validating(txtFromDateRecycle, New System.ComponentModel.CancelEventArgs(fromDateCancel))
                Call txtToDateRecycle_Validating(txtToDateRecycle, New System.ComponentModel.CancelEventArgs(toDateCancel))

                If Not (fromDateCancel Or toDateCancel) Then
                    Call modStatQuery.QuerySearchOpenRecycle(Me)
                End If

                Call txtFromDateMsgRecycle_Validating(txtFromDateMsgRecycle, New System.ComponentModel.CancelEventArgs(fromDateCancel))
                Call txtToDateMsgRecycle_Validating(txtToDateMsgRecycle, New System.ComponentModel.CancelEventArgs(toDateCancel))
                If Not (fromDateCancel Or toDateCancel) Then
                    Call modStatQuery.QuerySearchOpenMsgRecycle(Me)
                End If
        End Select

        modUtility.Done()


        Exit Sub
localError:
        modError.LogError(String.Format("CmdRefresh.Click: {0}", Err.ToString()))
        Resume Next
        Resume
    End Sub

    Private Sub CmdRestoreReferral_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdRestoreReferral.Click
        '************************************************************************************
        'Name: CmdRestoreReferral_Click
        'Date Created: 5/25/05                          Created by: Scott Plummer
        'Release: 8.0                                 Task: 416
        'Description: Restores referrals in the recycle bin.
        'Returns: Nothing
        'Params: None
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 4/25/06                          Changed by: Char Chaput
        'Release #: 8.0                              Release 8.0
        'Description:  Added checking if was save from the New Call screen by including
        'fields CallTotalTime in the query. This determines
        'querys for FrmReferral if opened from the recycle bin.
        '====================================================================================
        '************************************************************************************
        Dim vReturn As New Object
        Dim vCallID As New Object
        Dim vCallNumber As New Object
        Dim vCallTypeID As New Object
        Dim vCallEmployeeID As New Object
        Dim vSourceCodeId As Object

        vReturn = New Object()
        On Error Resume Next

        'Check who has focus
        If Not LstViewOpenRecycle.FocusedItem.Selected Then
            Exit Sub
        End If

        If Me.LstViewOpenRecycle.Items.Count > 0 Then

            Me.CallId = modConv.TextToLng(LstViewOpenRecycle.FocusedItem.Tag)

            'Delete the call id
            Call modStatSave.RestoreCall(Me)

            'Fill Grid
            Call CmdRefresh_Click(CmdRefresh, New System.EventArgs())

            'Char Chaput 04/26/06 Get Recycled from NC
            If modStatRefQuery.RefQueryCall(vReturn, Me.CallId) = SUCCESS Then
                vCallID = vReturn(0, 0)
                vCallNumber = vReturn(0, 1)
                vCallTypeID = vReturn(0, 2)
                vCallEmployeeID = vReturn(0, 3)
                vRecycledNC = vReturn(0, 4)
            End If

            Select Case vCallTypeID
                Case 1 'Referral

                    ' Allow restorer to open referral immediately.  5/25/05 - SAP
                    vReturn = MsgBox("Referral # " & Me.CallId & "." & Chr(10) & Chr(13) & "has been restored.  Do you wish to open it?", MsgBoxStyle.YesNo + MsgBoxStyle.DefaultButton2, "Delete Call")

                    Select Case vReturn
                        Case MsgBoxResult.Yes
                            ' If restorer answers yes, open referral directly.
                            If Not modUtility.ChkOpenForm("FrmReferral") Then
                                Call modUtility.Work()
                                'Char Chaput 04/25/06 if the referral was recycled from
                                'FrmNew when cancel was clicked flag the referral
                                AppMain.frmReferral = New FrmReferral()
                                If vRecycledNC = 1 Then
                                    AppMain.frmReferral.RecycledNC = True
                                    AppMain.frmReferral.RecycledNCType = 1
                                ElseIf vRecycledNC = 2 Then
                                    AppMain.frmReferral.RecycledNC = True
                                    AppMain.frmReferral.RecycledNCType = 2
                                ElseIf vRecycledNC = 3 Then
                                    AppMain.frmReferral.RecycledNC = True
                                    AppMain.frmReferral.RecycledNCType = 3
                                Else
                                    AppMain.frmReferral.RecycledNC = True
                                End If
                                AppMain.frmReferral.FormState = EXISTING_RECORD
                                AppMain.frmReferral.CallId = Me.CallId
                                AppMain.frmReferral.SourceCode.GetItem(, vSourceCodeId, REFERRAL)
                                AppMain.frmReferral.Show()
                                AppMain.frmReferral.TabDonor.SelectedIndex = 0

                                Call modUtility.Done()
                            End If

                        Case MsgBoxResult.No
                            Call modStatSave.SaveCall(Me, Me.CallId)
                            Exit Sub
                    End Select

                Case 2 'Message

                    ' Allow restorer to open Message immediately.  5/25/05 - SAP
                    vReturn = MsgBox("Message # " & Me.CallId & "." & Chr(10) & Chr(13) & "has been restored.  Do you wish to open it?", MsgBoxStyle.YesNo + MsgBoxStyle.DefaultButton2, "Delete Call")


                    Select Case vReturn
                        Case MsgBoxResult.Yes
                            ' If restorer answers yes, open referral directly.
                            If Not modUtility.ChkOpenForm("FrmMessage") Then
                                Call modUtility.Work()
                                'Char Chaput 04/25/06 if the referral was recycled from
                                'FrmNew when cancel was clicked flag the referral
                                AppMain.frmMessage = New FrmMessage()
                                If vRecycledNC = 1 Then
                                    AppMain.frmMessage.RecycledNC = True
                                End If
                                AppMain.frmMessage.FormState = EXISTING_RECORD
                                AppMain.frmMessage.CallId = Me.CallId
                                Call AppMain.frmMessage.SourceCode.GetItem(, vSourceCodeId, REFERRAL)
                                AppMain.frmMessage.Show()
                                Call modUtility.Done()
                            End If

                        Case MsgBoxResult.No
                            Exit Sub
                    End Select
            End Select


            CmdRestoreReferral.Enabled = False

        End If

    End Sub

    Private Sub CmdRestoreMessage_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdRestoreMessage.Click
        '************************************************************************************
        'Name: CmdRestoreMessage_Click
        'Date Created: 5/26/05                          Created by: Scott Plummer
        'Release: 8.0                                 Task: 416
        'Description: Restores messages/import offers in the recycle bin.
        'Returns: Nothing
        'Params: None
        'Stored Procedures: None
        '************************************************************************************
        Dim vReturn As New Object
        Dim vCallID As New Object
        Dim vCallNumber As New Object
        Dim vCallTypeID As New Object
        Dim vCallEmployeeID As New Object
        Dim vRecycledNC As New Object
        Dim vSourceCodeId As New Object

        On Error Resume Next

        'Check who has focus
        If Not LstViewOpenMsgRecycle.FocusedItem.Selected Then
            Exit Sub
        End If

        If Me.LstViewOpenMsgRecycle.Items.Count > 0 Then

            Me.CallId = modConv.TextToLng(LstViewOpenMsgRecycle.FocusedItem.Tag)

            'Delete the call id
            Call modStatSave.RestoreCall(Me)

            'Fill Grid
            Call CmdRefresh_Click(CmdRefresh, New System.EventArgs())

            'Char Chaput 04/26/06 Get Recycled from NC
            If modStatRefQuery.RefQueryCall(vReturn, Me.CallId) = SUCCESS Then
                vCallID = vReturn(0, 0)
                vCallNumber = vReturn(0, 1)
                vCallTypeID = vReturn(0, 2)
                vCallEmployeeID = vReturn(0, 3)
                vRecycledNC = vReturn(0, 4)
            End If

            ' Allow restorer to open referral immediately.  5/25/05 - SAP
            vReturn = MsgBox("Message # " & Me.CallId & "." & Chr(10) & Chr(13) & "has been restored.  Do you wish to open it?", MsgBoxStyle.YesNo + MsgBoxStyle.DefaultButton2, "Delete Call")

            Select Case vReturn
                Case MsgBoxResult.Yes

                    ' If restorer answers yes, open message directly.
                    If Not modUtility.ChkOpenForm("FrmReferral") Then
                        Call modUtility.Work()
                        If Not modUtility.ChkOpenForm("FrmMessage") Then
                            'Char Chaput 04/25/06 if the referral was recycled from
                            'FrmNew when cancel was clicked flag the referral
                            AppMain.frmMessage = New FrmMessage()
                            If vRecycledNC = 1 Then
                                AppMain.frmMessage.RecycledNC = True
                            Else
                                AppMain.frmMessage.RecycledNC = True
                            End If
                            AppMain.frmMessage.FormState = EXISTING_RECORD
                            AppMain.frmMessage.CallId = Me.CallId
                            AppMain.frmMessage.Display()
                        End If
                        Call modUtility.Done()
                    End If

                Case MsgBoxResult.No
                    Call modStatSave.SaveCall(Me, Me.CallId)
                    Exit Sub
            End Select

            CmdRestoreReferral.Enabled = False

        End If

    End Sub


    Private Sub Command1_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles Command1.Click

        'AppMain.frmTEST.Show

    End Sub

    Private Sub Command2_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs)
        AppMain.frmRotateOrganization = New FrmRotateOrganization
        AppMain.frmRotateOrganization.Show()
    End Sub

    Private Sub FrmOpenAll_Activated(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Activated

        'Hide Line Check from LO
        If AppMain.ParentForm.LeaseOrganization <> 0 Then
            CmdLineCheck.Visible = False
        End If

        'Get the initial lists
        Call Me.RefreshLists()


        '02/12/03 drh - Check Command Line parameters
        '02/20/21 bjk - put a check for tab 4 visibility
        If Me.TabCallType.TabPages.IndexOf(TabCallTypeTable(DASHBOARD_TAB_FAMILY_SERVICES)) > -1 Then
            If InStr(1, VB.Command(), "fs") > 0 Then
                TabCallType.SelectedIndex = 4
                Call CmdRefresh_Click(CmdRefresh, New System.EventArgs())
            End If
        End If

        'T.T 05/11/2004 added to disable the save button for family services asp.
        If AppMain.ParentForm.LeaseOrganizationType = "FamilyServices" Then
            Me.CmdNewCall.Enabled = False
        End If

    End Sub

    Private Sub FrmOpenAll_KeyDown(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles MyBase.KeyDown
        Dim KeyCode As Short = eventArgs.KeyCode
        Dim Shift As Short = eventArgs.KeyData \ &H10000
        '************************************************************************************
        'Name: Form_KeyDown
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Offers a function key shortcut to each tab
        'Returns: Nothing
        'Params: KeyCode, Shift
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 5/25/05                          Changed by: Scott Plummer
        'Release #: 8.0                               Task: 416
        'Description:  Added handling for update and recycle tabs, added constants.
        '====================================================================================
        '************************************************************************************
        Select Case KeyCode

            Case System.Windows.Forms.Keys.F1
                TabCallType.SelectedIndex = Me.TabCallType.TabPages.IndexOf(TabCallTypeTable(DASHBOARD_TAB_REFERRAL))
            Case System.Windows.Forms.Keys.F2
                TabCallType.SelectedIndex = Me.TabCallType.TabPages.IndexOf(TabCallTypeTable(DASHBOARD_TAB_MESSAGES))
            Case System.Windows.Forms.Keys.F3
                TabCallType.SelectedIndex = Me.TabCallType.TabPages.IndexOf(TabCallTypeTable(DASHBOARD_TAB_NO_CALLS))
            Case System.Windows.Forms.Keys.F4
                TabCallType.SelectedIndex = Me.TabCallType.TabPages.IndexOf(TabCallTypeTable(DASHBOARD_TAB_CONSENTS_PENDING))
            Case System.Windows.Forms.Keys.F5
                If Me.TabCallType.TabPages.IndexOf(TabCallTypeTable(DASHBOARD_TAB_FAMILY_SERVICES)) > -1 Then
                    TabCallType.SelectedIndex = Me.TabCallType.TabPages.IndexOf(TabCallTypeTable(DASHBOARD_TAB_FAMILY_SERVICES))
                End If
                'mds 10/30/03 - Added F6 key functionality for Information tab
                'mds 11/13/03 - Added If statement
            Case System.Windows.Forms.Keys.F6
                If Me.TabCallType.TabPages.IndexOf(TabCallTypeTable(DASHBOARD_TAB_INFO)) > -1 Then
                    TabCallType.SelectedIndex = Me.TabCallType.TabPages.IndexOf(TabCallTypeTable(DASHBOARD_TAB_INFO))
                End If
                'Added update and recycle tabs.  5/25/05 - SAP
            Case System.Windows.Forms.Keys.F7
                If Me.TabCallType.TabPages.IndexOf(TabCallTypeTable(DASHBOARD_TAB_UPDATES)) > -1 Then
                    TabCallType.SelectedIndex = Me.TabCallType.TabPages.IndexOf(TabCallTypeTable(DASHBOARD_TAB_UPDATES))
                End If
            Case System.Windows.Forms.Keys.F8
                'T.T 05/20/2006 check to see if tab is available
                If Me.TabCallType.TabPages.IndexOf(TabCallTypeTable(DASHBOARD_TAB_RECYCLE)) > -1 Then
                    TabCallType.SelectedIndex = Me.TabCallType.TabPages.IndexOf(TabCallTypeTable(DASHBOARD_TAB_RECYCLE))
                End If
        End Select

    End Sub


    Private Sub FrmOpenAll_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load

        On Error Resume Next

        Dim I As Short
        Dim vTimeZoneDif As Short

        'initialize TabCallTypeTable
        TabCallTypeTable = New Hashtable
        TabCallTypeTable.Add(DASHBOARD_TAB_REFERRAL, TabCallType.TabPages.Item(DASHBOARD_TAB_REFERRAL))
        TabCallTypeTable.Add(DASHBOARD_TAB_MESSAGES, TabCallType.TabPages.Item(DASHBOARD_TAB_MESSAGES))
        TabCallTypeTable.Add(DASHBOARD_TAB_NO_CALLS, TabCallType.TabPages.Item(DASHBOARD_TAB_NO_CALLS))
        TabCallTypeTable.Add(DASHBOARD_TAB_CONSENTS_PENDING, TabCallType.TabPages.Item(DASHBOARD_TAB_CONSENTS_PENDING))

        TabCallTypeTable.Add(DASHBOARD_TAB_FAMILY_SERVICES, TabCallType.TabPages.Item(DASHBOARD_TAB_FAMILY_SERVICES))
        TabCallTypeTable.Add(DASHBOARD_TAB_INFO, TabCallType.TabPages.Item(DASHBOARD_TAB_INFO))
        TabCallTypeTable.Add(DASHBOARD_TAB_UPDATES, TabCallType.TabPages.Item(DASHBOARD_TAB_UPDATES))
        TabCallTypeTable.Add(DASHBOARD_TAB_RECYCLE, TabCallType.TabPages.Item(DASHBOARD_TAB_RECYCLE))


        vTimeZoneDif = modStatQuery.QueryTimeZoneDif(AppMain.ParentForm.TimeZone)

        Me.Height = AppMain.ParentForm.ClientRectangle.Height
        Me.Width = AppMain.ParentForm.ClientRectangle.Width
        Me.Top = 0
        Me.Left = 0

        'Initialize the page list
        Call modControl.HighlightListViewRow(LstViewPendingPage)
        Call LstViewPendingPage.Columns.Insert(0, "", "", 20)
        Call LstViewPendingPage.Columns.Insert(1, "", "Call #", CInt(VB6.TwipsToPixelsX(1250)))
        Call LstViewPendingPage.Columns.Insert(2, "", "Time", CInt(VB6.TwipsToPixelsX(600)))
        Call LstViewPendingPage.Columns.Insert(3, "", "Paged/Fax To", CInt(VB6.TwipsToPixelsX(1700)))
        Call LstViewPendingPage.Columns.Insert(4, "", "Organization", CInt(VB6.TwipsToPixelsX(2450)))
        Call LstViewPendingPage.Columns.Insert(5, "", "By", CInt(VB6.TwipsToPixelsX(1000)))

        'Initialize the incomplete list
        Call modControl.HighlightListViewRow(LstViewIncompletes)
        Call LstViewIncompletes.Columns.Insert(0, "", "", 20)
        Call LstViewIncompletes.Columns.Insert(1, "", "Call #", CInt(VB6.TwipsToPixelsX(1250)))
        Call LstViewIncompletes.Columns.Insert(2, "", "Date           Time", CInt(VB6.TwipsToPixelsX(1500)))
        Call LstViewIncompletes.Columns.Insert(3, "", "Organization", CInt(VB6.TwipsToPixelsX(3000)))
        Call LstViewIncompletes.Columns.Insert(4, "", "Saved By", CInt(VB6.TwipsToPixelsX(1000)))

        'Initialize the alert list
        Call modControl.HighlightListViewRow(LstViewGeneralAlert)
        Call LstViewGeneralAlert.Columns.Insert(0, "Expires", CInt(VB6.TwipsToPixelsX(1700)), System.Windows.Forms.HorizontalAlignment.Left)
        Call LstViewGeneralAlert.Columns.Insert(1, "", "Org", CInt(VB6.TwipsToPixelsX(1900)))
        Call LstViewGeneralAlert.Columns.Insert(2, "", "Alert", CInt(VB6.TwipsToPixelsX(4000)))
        LstViewGeneralAlert.Columns.Item(2).Width = VB6.TwipsToPixelsX(VB6.PixelsToTwipsX(Me.ClientRectangle.Width) - 5000)

        'Initialize the consent list
        Call modControl.HighlightListViewRow(LstViewPendingConsent)
        Call LstViewPendingConsent.Columns.Insert(0, "", "", Me.TxtType.Width)
        Call LstViewPendingConsent.Columns.Insert(1, "", "Call #", Me.TxtCallNumber.Width)
        Call LstViewPendingConsent.Columns.Insert(2, "", "Date           Time", Me.TxtFromDate.Width + Me.TxtToDate.Width)
        Call LstViewPendingConsent.Columns.Insert(3, "", "Patient Location", Me.TxtLocation.Width + Me.TxtState.Width)
        Call LstViewPendingConsent.Columns.Insert(4, "", "Patient", Me.TxtPatientFirst.Width + Me.TxtPatientLast.Width)
        Call LstViewPendingConsent.Columns.Insert(5, "", "Consent Organization", Me.TxtOrg.Width)
        Call LstViewPendingConsent.Columns.Insert(6, "", "Consent From", Me.TxtOrgPerson.Width)
        Call LstViewPendingConsent.Columns.Insert(7, "", "Source Code", Me.TxtConsentSource.Width)

        'Initialize the referral list
        Call modControl.HighlightListViewRow(LstViewOpenReferral)

        Call LstViewOpenReferral.Columns.Insert(0, "", "Call #", TxtCallNumberRef.Width)
        Call LstViewOpenReferral.Columns.Insert(1, "", "Date           Time", TxtFromDateRef.Width + TxtFromTimeRef.Width + TxtToDateRef.Width + TxtToTimeRef.Width)
        Call LstViewOpenReferral.Columns.Insert(2, "", "Patient Name", TxtPatientFirstRef.Width + TxtPatientLastRef.Width)
        Call LstViewOpenReferral.Columns.Insert(3, "", "Patient Location", TxtLocationRef.Width + TxtStateRef.Width)
        ' Added column for Previous Referral Type.  5/23/05 - SAP
        Call LstViewOpenReferral.Columns.Insert(4, "", "Pre. Ref. Type", txtPreRefType.Width)
        Call LstViewOpenReferral.Columns.Insert(5, "", "Ref. Type", TxtReferralType.Width)
        Call LstViewOpenReferral.Columns.Insert(6, "", "Source Code", TxtRefSource.Width)
        ' Added column for TC Name.  5/23/05 - SAP
        Call LstViewOpenReferral.Columns.Insert(7, "", "TC Name", txtTcNameRef.Width + 50)

        TxtFromDateRef.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -12, DateAdd(Microsoft.VisualBasic.DateInterval.Hour, vTimeZoneDif, Now)), "mm/dd/yy")
        TxtFromTimeRef.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -12, DateAdd(Microsoft.VisualBasic.DateInterval.Hour, vTimeZoneDif, Now)), "hh:mm")
        TxtToDateRef.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, 12, DateAdd(Microsoft.VisualBasic.DateInterval.Hour, vTimeZoneDif, Now)), "mm/dd/yy")
        TxtToTimeRef.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, 12, DateAdd(Microsoft.VisualBasic.DateInterval.Hour, vTimeZoneDif, Now)), "hh:mm")

        'Initialize the referral list
        Call modControl.HighlightListViewRow(LstViewOpenMessage)
        Call LstViewOpenMessage.Columns.Insert(0, "", "Call #", TxtCallNumberMsg.Width + 10)
        Call LstViewOpenMessage.Columns.Insert(1, "", "Date           Time", Me.TxtFromDateMsg.Width + Me.TxtToDateMsg.Width - 5)
        Call LstViewOpenMessage.Columns.Insert(2, "", "Message For", Me.TxtForPersonFirst.Width + Me.TxtForPersonLast.Width - 5)
        Call LstViewOpenMessage.Columns.Insert(3, "", "Organization", Me.TxtLocationMsg.Width + Me.TxtStateMsg.Width - 5)
        Call LstViewOpenMessage.Columns.Insert(4, "", "Message Type", Me.TxtMessageType.Width)
        Call LstViewOpenMessage.Columns.Insert(5, "", "Source Code", Me.TxtMsgSource.Width)
        Call LstViewOpenMessage.Columns.Insert(6, "", "From", CInt(VB6.TwipsToPixelsX(4000)))

        TxtFromDateMsg.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Day, -1, DateAdd(Microsoft.VisualBasic.DateInterval.Hour, vTimeZoneDif, Now)), "mm/dd/yy")
        TxtToDateMsg.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, vTimeZoneDif, Now), "mm/dd/yy")

        'mds 10/21/03 Initialize the information list
        Call modControl.HighlightListViewRow(LstViewOpenInformation)
        Call LstViewOpenInformation.Columns.Insert(0, "", "Call #", TxtCallNumberMsg.Width)
        Call LstViewOpenInformation.Columns.Insert(1, "", "Date           Time", Me.TxtFromDateInfo.Width + Me.TxtToDateInfo.Width)
        Call LstViewOpenInformation.Columns.Insert(2, "", "Caller Name", Me.TxtFirstNameInfo.Width + Me.TxtLastNameInfo.Width)
        Call LstViewOpenInformation.Columns.Insert(3, "", "State", Me.TxtStateInfo.Width)
        Call LstViewOpenInformation.Columns.Insert(4, "", "Organization", Me.TxtCoalitionInfo.Width)
        Call LstViewOpenInformation.Columns.Insert(5, "", "Source Code", Me.TxtSourceInfo.Width + 50)

        TxtFromDateInfo.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Day, -1, DateAdd(Microsoft.VisualBasic.DateInterval.Hour, vTimeZoneDif, Now)), "mm/dd/yy")
        TxtToDateInfo.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, vTimeZoneDif, Now), "mm/dd/yy")

        'Initialize the referral list
        Call modControl.HighlightListViewRow(LstViewOpenNoCall)
        Call LstViewOpenNoCall.Columns.Insert(0, "", "Call #", Me.TxtCallNumberNC.Width)
        Call LstViewOpenNoCall.Columns.Insert(1, "", "Date           Time", Me.TxtFromDateNC.Width + Me.TxtToDateNC.Width)
        Call LstViewOpenNoCall.Columns.Insert(2, "", "No Call Type", Me.TxtNoCallType.Width)
        Call LstViewOpenNoCall.Columns.Insert(3, "", "Description", Me.TxtDescription.Width)
        Call LstViewOpenNoCall.Columns.Insert(4, "", "Source Code", Me.TxtNoCallSource.Width + 50)

        TxtFromDateNC.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Day, -1, DateAdd(Microsoft.VisualBasic.DateInterval.Hour, vTimeZoneDif, Now)), "mm/dd/yy")
        TxtToDateNC.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, vTimeZoneDif, Now), "mm/dd/yy")

        'Initialize the callback list
        Call modControl.HighlightListViewRow(LstViewCallouts)
        Call LstViewCallouts.Columns.Insert(0, "", "", CInt(VB6.TwipsToPixelsX(300)))
        Call LstViewCallouts.Columns.Insert(1, "", "Call #", CInt(VB6.TwipsToPixelsX(1250)))
        Call LstViewCallouts.Columns.Insert(2, "", "Callout/Paged Time", CInt(VB6.TwipsToPixelsX(1750)))
        'ccarroll 11/16/2006 added column per Steve Barron for 8.2 release
        Call LstViewCallouts.Columns.Insert(3, "", "Source", CInt(VB6.TwipsToPixelsX(800)))

        Call LstViewCallouts.Columns.Insert(4, "", "Callout/Paged", CInt(VB6.TwipsToPixelsX(2850)))
        Call LstViewCallouts.Columns.Insert(5, "", "Created By", CInt(VB6.TwipsToPixelsX(1000)))
        Call LstViewCallouts.Columns.Insert(6, "", "", CInt(VB6.TwipsToPixelsX(0)))
        Call LstViewCallouts.Columns.Insert(7, "", "", CInt(VB6.TwipsToPixelsX(0)))
        Call LstViewCallouts.Columns.Insert(8, "", "", CInt(VB6.TwipsToPixelsX(0)))
        Call LstViewCallouts.Columns.Insert(9, "", "", CInt(VB6.TwipsToPixelsX(0)))
        Call LstViewCallouts.Columns.Insert(10, "", "", CInt(VB6.TwipsToPixelsX(0)))
        Call LstViewCallouts.Columns.Insert(11, "", "O", CInt(VB6.TwipsToPixelsX(300)))
        Call LstViewCallouts.Columns.Insert(12, "", "E", CInt(VB6.TwipsToPixelsX(300)))
        Call LstViewCallouts.Columns.Insert(13, "", "S", CInt(VB6.TwipsToPixelsX(300)))
        Call LstViewCallouts.Columns.Insert(14, "", "A", CInt(VB6.TwipsToPixelsX(300)))


        'Initialize the secondary list
        Call modControl.HighlightListViewRow(LstViewSecondary)
        Call LstViewSecondary.Columns.Insert(0, "", "", CInt(VB6.TwipsToPixelsX(300)))
        Call LstViewSecondary.Columns.Insert(1, "", "Call #", CInt(VB6.TwipsToPixelsX(1250)))
        Call LstViewSecondary.Columns.Insert(2, "", "Date           Time", CInt(VB6.TwipsToPixelsX(1500)))
        Call LstViewSecondary.Columns.Insert(3, "", "Organization", CInt(VB6.TwipsToPixelsX(2000)))
        Call LstViewSecondary.Columns.Insert(4, "", "Primary By", CInt(VB6.TwipsToPixelsX(1000)))
        Call LstViewSecondary.Columns.Insert(5, "", "", CInt(VB6.TwipsToPixelsX(0)))
        Call LstViewSecondary.Columns.Insert(6, "", "", CInt(VB6.TwipsToPixelsX(0)))
        Call LstViewSecondary.Columns.Insert(7, "", "", CInt(VB6.TwipsToPixelsX(0)))
        Call LstViewSecondary.Columns.Insert(8, "", "", CInt(VB6.TwipsToPixelsX(0)))
        Call LstViewSecondary.Columns.Insert(9, "", "O", CInt(VB6.TwipsToPixelsX(300)))
        Call LstViewSecondary.Columns.Insert(10, "", "E", CInt(VB6.TwipsToPixelsX(300)))
        Call LstViewSecondary.Columns.Insert(11, "", "S", CInt(VB6.TwipsToPixelsX(300)))
        Call LstViewSecondary.Columns.Insert(12, "", "A", CInt(VB6.TwipsToPixelsX(300)))

        '6/27/01 drh Initialize the secondary alert list
        Call modControl.HighlightListViewRow(LstViewSecondaryAlert)
        Call LstViewSecondaryAlert.Columns.Insert(0, "", "", CInt(VB6.TwipsToPixelsX(300)))
        Call LstViewSecondaryAlert.Columns.Insert(1, "", "Call #", CInt(VB6.TwipsToPixelsX(1250)))
        Call LstViewSecondaryAlert.Columns.Insert(2, "", "Date           Time", CInt(VB6.TwipsToPixelsX(1500)))
        Call LstViewSecondaryAlert.Columns.Insert(3, "", "Organization", CInt(VB6.TwipsToPixelsX(3000)))
        Call LstViewSecondaryAlert.Columns.Insert(4, "", "Primary By", CInt(VB6.TwipsToPixelsX(1000)))
        'ccarroll 11/14/2006 added column per Steve Barron for 8.2 release
        Call LstViewSecondaryAlert.Columns.Insert(5, "", "Source", CInt(VB6.TwipsToPixelsX(800)))

        'Initialize the Update list - Added 5/24/05 - SAP
        Call modControl.HighlightListViewRow(LstViewOpenUpdate)
        Call LstViewOpenUpdate.Columns.Insert(0, "", "Call #", txtCallNumberUpdate.Width)
        Call LstViewOpenUpdate.Columns.Insert(1, "", "Date           Time  (Updated)", txtFromDateUpdate.Width + txtFromTimeUpdate.Width + txtToDateUpdate.Width + txtToTimeUpdate.Width)
        Call LstViewOpenUpdate.Columns.Insert(2, "", "Patient Name", txtPatientFirstUpdate.Width + txtPatientLastUpdate.Width)
        Call LstViewOpenUpdate.Columns.Insert(3, "", "Patient Location", txtLocationUpdate.Width + txtStateUpdate.Width)
        Call LstViewOpenUpdate.Columns.Insert(4, "", "Pre. Ref. Type", txtPreRefTypeUpdate.Width)
        Call LstViewOpenUpdate.Columns.Insert(5, "", "Ref. Type", txtReferralTypeUpdate.Width)
        Call LstViewOpenUpdate.Columns.Insert(6, "", "Source Code", txtRefSourceUpdate.Width)
        Call LstViewOpenUpdate.Columns.Insert(7, "", "TC Name", txtTcNameUpdate.Width + 50)
        ' Set default times 1 hour before and after present time.  5/24/05 - SAP
        'ccarroll 06/13/2006 Changed default time to match referral tab
        txtFromDateUpdate.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -12, DateAdd(Microsoft.VisualBasic.DateInterval.Hour, vTimeZoneDif, Now)), "mm/dd/yy")
        txtFromTimeUpdate.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -12, DateAdd(Microsoft.VisualBasic.DateInterval.Hour, vTimeZoneDif, Now)), "hh:mm")
        txtToDateUpdate.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, 12, DateAdd(Microsoft.VisualBasic.DateInterval.Hour, vTimeZoneDif, Now)), "mm/dd/yy")
        txtToTimeUpdate.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, 12, DateAdd(Microsoft.VisualBasic.DateInterval.Hour, vTimeZoneDif, Now)), "hh:mm")

        'Initialize the Referral Recycle list - Added 5/24/05 - SAP
        Call modControl.HighlightListViewRow(LstViewOpenRecycle)
        Call LstViewOpenRecycle.Columns.Insert(0, "", "Call #", txtCallNumberRecycle.Width)
        Call LstViewOpenRecycle.Columns.Insert(1, "", "Date           Time  (Recycled)", txtFromDateRecycle.Width + txtFromTimeRecycle.Width + txtToDateRecycle.Width + txtToTimeRecycle.Width)
        Call LstViewOpenRecycle.Columns.Insert(2, "", "Patient Name", txtPatientFirstRecycle.Width + txtPatientLastRecycle.Width)
        Call LstViewOpenRecycle.Columns.Insert(3, "", "Patient Location", txtLocationRecycle.Width + txtStateRecycle.Width)
        Call LstViewOpenRecycle.Columns.Insert(4, "", "Pre. Ref. Type", txtPreRefTypeRecycle.Width)
        Call LstViewOpenRecycle.Columns.Insert(5, "", "Ref. Type", txtReferralTypeRecycle.Width)
        Call LstViewOpenRecycle.Columns.Insert(6, "", "Source Code", txtRefSourceRecycle.Width)
        Call LstViewOpenRecycle.Columns.Insert(7, "", "TC Name", txtTcNameRecycle.Width + 50)
        ' Set default times 1 hour before and after present time.  5/24/05 - SAP
        txtFromDateRecycle.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Day, -1, DateAdd(Microsoft.VisualBasic.DateInterval.Hour, vTimeZoneDif, Now)), "mm/dd/yy")
        txtFromTimeRecycle.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Day, -1, DateAdd(Microsoft.VisualBasic.DateInterval.Hour, vTimeZoneDif, Now)), "hh:mm")
        txtToDateRecycle.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, 12, DateAdd(Microsoft.VisualBasic.DateInterval.Hour, vTimeZoneDif, Now)), "mm/dd/yy")
        txtToTimeRecycle.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, 12, DateAdd(Microsoft.VisualBasic.DateInterval.Hour, vTimeZoneDif, Now)), "hh:mm")

        ' Initialize the Message Recycle List
        Call modControl.HighlightListViewRow(LstViewOpenMsgRecycle)
        Call LstViewOpenMsgRecycle.Columns.Insert(0, "", "Call #", TxtCallNumberMsg.Width)
        Call LstViewOpenMsgRecycle.Columns.Insert(1, "", "Date (Recycled)", txtFromDateMsgRecycle.Width + txtToDateMsgRecycle.Width)
        Call LstViewOpenMsgRecycle.Columns.Insert(2, "", "Message For", Me.txtForPersonFirstRecycle.Width + Me.txtForPersonLastRecycle.Width)
        Call LstViewOpenMsgRecycle.Columns.Insert(3, "", "Organization", Me.txtLocationMsgRecycle.Width + Me.txtStateMsgRecycle.Width)
        Call LstViewOpenMsgRecycle.Columns.Insert(4, "", "Message Type", Me.txtMessageTypeRecycle.Width)
        Call LstViewOpenMsgRecycle.Columns.Insert(5, "", "Source Code", Me.txtMsgSourceRecycle.Width)
        Call LstViewOpenMsgRecycle.Columns.Insert(6, "", "From", txtMsgFromRecycle.Width + 50)

        txtFromDateMsgRecycle.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Day, -1, DateAdd(Microsoft.VisualBasic.DateInterval.Hour, vTimeZoneDif, Now)), "mm/dd/yy")
        txtToDateMsgRecycle.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, vTimeZoneDif, Now), "mm/dd/yy")

        'Set security options
        If modStatSecurity.GetPermission(AppMain.ParentForm.StatEmployeeID, "AllowCallDelete") Then
            Me.CmdDeleteRef.Visible = True
            Me.CmdDeleteMsg.Visible = True
            Me.CmdDeleteNC.Visible = True
            AllowDelete = True
        Else
            Me.CmdDeleteRef.Visible = False
            Me.CmdDeleteMsg.Visible = False
            Me.CmdDeleteNC.Visible = False
            AllowDelete = False
        End If

        '7/9/01 drh Make sure active tab is Referral on load
        Me.TabCallType.SelectedIndex = DASHBOARD_TAB_REFERRAL

        Me.SetTabs()

        '    '2/28/2002 bjk Hide Family Services Tab from LOs
        '    '4/28/2003 bjk removed code for testing.
        '    'NEED TO MODIFY TO CHECK WHEN A LO HAS ACCESS TO FS
        '    If AppMain.ParentForm.LeaseOrganization > 0 Then
        '        Me.TabCallType.TabVisible(4) = False
        '
        '        'mds 10/21/03 hide information call tab
        '        Me.TabCallType.TabVisible(5) = False
        '
        '    End If
        'T.T 05/17/2006 added for recycle tab
        If Not modStatSecurity.GetPermission(AppMain.ParentForm.StatEmployeeID, "AllowRecycleCase") Then
            Me.TabCallType.TabPages.RemoveAt(Me.TabCallType.TabPages.IndexOf(TabCallTypeTable(DASHBOARD_TAB_RECYCLE)))
        End If

        If AppMain.ParentForm.PersonTypeID = TRIAGE_COORDINATOR Then
            Me.TabCallType.TabPages.RemoveAt(Me.TabCallType.TabPages.IndexOf(TabCallTypeTable(DASHBOARD_TAB_FAMILY_SERVICES)))
        End If

        '****************************************************************
        '3/11/04 drh FSASP: Temporarily replaced code above for demo purposes;
        'need to re-do when LO access functionality is fleshed out more
        '****************************************************************
        If Not IsNothing(AppMain.ParentForm.LeaseOrganizationType) Then
            If AppMain.ParentForm.LeaseOrganizationType = "Triage" Then 'And AppMain.ParentForm.WebUserOrg <> 2309 And AppMain.ParentForm.WebUserOrg <> 9796 Then  ' T.T 4/5/2004 commented out for development. put into class
                Me.TabCallType.TabPages.RemoveAt(Me.TabCallType.TabPages.IndexOf(TabCallTypeTable(DASHBOARD_TAB_INFO)))
                Me.TabCallType.TabPages.RemoveAt(Me.TabCallType.TabPages.IndexOf(TabCallTypeTable(DASHBOARD_TAB_FAMILY_SERVICES)))

            End If
            If AppMain.ParentForm.LeaseOrganizationType = "FamilyServices" Then
                Me.TabCallType.TabPages.RemoveAt(Me.TabCallType.TabPages.IndexOf(TabCallTypeTable(DASHBOARD_TAB_INFO)))
                Me.TabCallType.TabPages.RemoveAt(Me.TabCallType.TabPages.IndexOf(TabCallTypeTable(DASHBOARD_TAB_CONSENTS_PENDING)))
            End If
            If AppMain.ParentForm.LeaseOrganizationType = "TriageFamilyServices" Then
                Me.TabCallType.TabPages.RemoveAt(Me.TabCallType.TabPages.IndexOf(TabCallTypeTable(DASHBOARD_TAB_UPDATES)))
            End If

        End If



        'If AppMain.ParentForm.LeaseOrganization > 0 Then
        'mds 10/21/03 hide information call tab
        'T.T 5/10/2004 took out for development, will put everyhthing into LO class
        'Me.TabCallType.TabVisible(5) = False
        'End If
        '****************************************************************
        '3/11/04 drh FSASP: End temporary demo code
        '****************************************************************

        'Fill the source codes collection
        Call SourceCodes.GetItems()


    End Sub

    Private Sub FrmOpenAll_Resize(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Resize
        '************************************************************************************
        'Name: Form_Resize
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Adjusts controls when the form is resized
        'Returns: Nothing
        'Params: None
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 5/25/05                          Changed by: Scott Plummer
        'Release #: 8.0                               Task: 416
        'Description:  Added handling for update and referral tabs and recycle button.
        '************************************************************************************
        On Error Resume Next

        Dim I As Short

        '6/27/01 drh Added variable for Secondary Alert list view scaling (see use below)
        Dim lvh As Short

        'Me.Width = AppMain.ParentForm.ClientRectangle.Width
        'Me.Height = AppMain.ParentForm.ClientRectangle.Height

        TabCallType.Width = Me.ClientRectangle.Width

        'Me.Top = 0
        'Me.Left = 0

        '6/27/01 drh Wrapped CallTypeTab resize into switchFSCallType function
        Call switchFSCallType()

        ' LstViewGeneralAlert.Width = VB6.TwipsToPixelsX(VB6.PixelsToTwipsX(Me.ClientRectangle.Width) - 30)

        'LstViewPendingPage.Width = (Me.ClientRectangle.Width / 2) - 150

        'LstViewIncompletes.Width = (Me.ClientRectangle.Width / 2) - 150

        LstViewCallouts.Width = VB6.TwipsToPixelsX((VB6.PixelsToTwipsX(Me.TabCallType.Width) / 2) - 120)
        LstViewSecondary.Width = VB6.TwipsToPixelsX((VB6.PixelsToTwipsX(Me.TabCallType.Width) / 2) - 30)

        'LstViewIncompletes.Left = VB6.TwipsToPixelsX(VB6.PixelsToTwipsX(LstViewPendingPage.Width) + 30)
        LstViewSecondary.Left = VB6.TwipsToPixelsX(VB6.PixelsToTwipsX(LstViewCallouts.Width) + 90)

        '6/27/01 drh Modified resizing for Secondary and added
        'resizing for Secondary Alert
        LstViewSecondaryAlert.Width = VB6.TwipsToPixelsX((VB6.PixelsToTwipsX(Me.TabCallType.Width) / 2) - 30)
        LstViewSecondaryAlert.Left = VB6.TwipsToPixelsX(VB6.PixelsToTwipsX(LstViewCallouts.Width) + 90)
        LstViewCallouts.Height = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(TabCallType.Height) - 470)
        lvh = VB6.PixelsToTwipsY(LstViewCallouts.Height)
        LstViewSecondaryAlert.Height = VB6.TwipsToPixelsY((lvh / 3) - 10)
        LstViewSecondary.Height = VB6.TwipsToPixelsY(lvh * (2 / 3) - 20)
        LstViewSecondary.Top = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(LstViewSecondaryAlert.Top) + VB6.PixelsToTwipsY(LstViewSecondaryAlert.Height) + 10)

        LstViewPendingConsent.Width = VB6.TwipsToPixelsX(VB6.PixelsToTwipsX(TabCallType.Width) - 30)
        LstViewPendingConsent.Height = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(TabCallType.Height) - 800)

        LstViewOpenReferral.Width = TabCallType.Width - 15
        LstViewOpenReferral.Height = TabCallType.Height - 100
        LstViewOpenMessage.Width = TabCallType.Width - 15
        LstViewOpenMessage.Height = TabCallType.Height - 100
        ' Added Update tab.  v. 8.0. 5/24/05 - SAP
        LstViewOpenUpdate.Width = VB6.TwipsToPixelsX(VB6.PixelsToTwipsX(TabCallType.Width) - 30)
        LstViewOpenUpdate.Height = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(TabCallType.Height) - 800)

        ' Added Recycle tab.  v. 8.0. 5/24/05 - SAP
        LstViewOpenRecycle.Width = VB6.TwipsToPixelsX(VB6.PixelsToTwipsX(TabCallType.Width) - 30)
        LstViewOpenRecycle.Height = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(TabCallType.Height) * 0.4)
        ' adjust tops of input param boxes for Message recycling
        txtCallNumberMsgRecycle.Top = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(LstViewOpenRecycle.Top) + VB6.PixelsToTwipsY(LstViewOpenRecycle.Height) + 100)
        txtFromDateMsgRecycle.Top = txtCallNumberMsgRecycle.Top
        txtToDateMsgRecycle.Top = txtCallNumberMsgRecycle.Top
        txtForPersonFirstRecycle.Top = txtCallNumberMsgRecycle.Top
        txtForPersonLastRecycle.Top = txtCallNumberMsgRecycle.Top
        txtLocationMsgRecycle.Top = txtCallNumberMsgRecycle.Top
        txtStateMsgRecycle.Top = txtCallNumberMsgRecycle.Top
        txtMessageTypeRecycle.Top = txtCallNumberMsgRecycle.Top
        txtMsgSourceRecycle.Top = txtCallNumberMsgRecycle.Top
        txtMsgFromRecycle.Top = txtCallNumberMsgRecycle.Top
        'txtMsgTxRecycle.Top = txtCallNumberMsgRecycle.Top
        cmdRestoreMessage.Top = txtCallNumberMsgRecycle.Top
        LstViewOpenMsgRecycle.Top = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(txtCallNumberMsgRecycle.Top) + 300)
        LstViewOpenMsgRecycle.Height = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(LstViewOpenMessage.Height) + VB6.PixelsToTwipsY(LstViewOpenMessage.Top) - VB6.PixelsToTwipsY(LstViewOpenMsgRecycle.Top))
        LstViewOpenMsgRecycle.Width = VB6.TwipsToPixelsX(VB6.PixelsToTwipsX(TabCallType.Width) - 30)



        LstViewOpenNoCall.Width = VB6.TwipsToPixelsX(VB6.PixelsToTwipsX(TabCallType.Width) - 30)
        LstViewOpenNoCall.Height = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(TabCallType.Height) - 800)

        'mds 10/21/03 Added information tab dimensions
        LstViewOpenInformation.Width = VB6.TwipsToPixelsX(VB6.PixelsToTwipsX(TabCallType.Width) - 30)
        LstViewOpenInformation.Height = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(TabCallType.Height) - 800)


        'Set the delete and count controls
        LblCountRef.Left = VB6.TwipsToPixelsX(VB6.PixelsToTwipsX(TabCallType.Width) - 615)
        LblCountMsg.Left = VB6.TwipsToPixelsX(VB6.PixelsToTwipsX(TabCallType.Width) - 615)
        LblCountNoCall.Left = VB6.TwipsToPixelsX(VB6.PixelsToTwipsX(TabCallType.Width) - 615)
        LblCountConsent.Left = VB6.TwipsToPixelsX(VB6.PixelsToTwipsX(TabCallType.Width) - 615)

        For I = 0 To 3
            Label(I).Left = VB6.TwipsToPixelsX(VB6.PixelsToTwipsX(TabCallType.Width) - 1155)
        Next I

        CmdDeleteRef.Left = VB6.TwipsToPixelsX(VB6.PixelsToTwipsX(TabCallType.Width) - 2505)
        CmdDeleteMsg.Left = VB6.TwipsToPixelsX(VB6.PixelsToTwipsX(TabCallType.Width) - 2505)
        CmdDeleteNC.Left = VB6.TwipsToPixelsX(VB6.PixelsToTwipsX(TabCallType.Width) - 2505)
        ' Added Recycle button.  5/25/05 - SAP
        CmdRestoreReferral.Left = VB6.TwipsToPixelsX(VB6.PixelsToTwipsX(TabCallType.Width) - 2505)
        cmdRestoreMessage.Left = VB6.TwipsToPixelsX(VB6.PixelsToTwipsX(TabCallType.Width) - 2505)

    End Sub

    Private Sub FrmOpenAll_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing



    End Sub

    Private Sub lblRecyleReferralCheckSearchParameters_Click(ByRef Index As Short)

    End Sub

    Private Sub lblRecyleMsgCheckSearchParameters_Click(ByRef Index As Short)
    End Sub

    Private Sub LstViewCallouts_ColumnClick(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.ColumnClickEventArgs) Handles LstViewCallouts.ColumnClick
        Dim ColumnHeader As System.Windows.Forms.ColumnHeader = LstViewCallouts.Columns(eventArgs.Column)

        ' When a ColumnHeader object is clicked, the ListView control is
        ' sorted by the subitems of that column.
        ' Set the SortKey to the Index of the ColumnHeader - 1

        '7/24/01 drh Always keep Events grouped by Pending type

        LstViewCallouts.Sorting = CalloutSortOrder
        LstViewCallouts.ListViewItemSorter = New ListViewItemComparer(eventArgs.Column, Me.CalloutSortOrder)

        If CalloutSortOrder = System.Windows.Forms.SortOrder.Ascending Then
            CalloutSortOrder = System.Windows.Forms.SortOrder.Descending
        Else
            CalloutSortOrder = System.Windows.Forms.SortOrder.Ascending
        End If

    End Sub


    Private Sub LstViewCallouts_DoubleClick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewCallouts.DoubleClick

        Dim vCallID As Integer
        Dim vCallTypeID As Short
        Dim vCallNumber As String = ""
        Dim vCallEmployeeID As Short
        Dim vReturn As New Object
        Dim vReturn2 As New Object

        On Error GoTo localError

        '*******************
        'Open the call first
        '*******************

        Call modUtility.Work()

        vCallID = modConv.TextToLng(LstViewCallouts.FocusedItem.Tag)

        If modStatRefQuery.RefQueryCall(vReturn, vCallID) = SUCCESS Then
            vCallID = vReturn(0, 0)
            vCallNumber = vReturn(0, 1)
            vCallTypeID = vReturn(0, 2)
            vCallEmployeeID = vReturn(0, 3)
        End If

        Select Case vCallTypeID

            Case REFERRAL

                If modStatQuery.QueryReferralID(vCallID) = SUCCESS Then

                    'FSProj drh 6/15/02 If Secondary record exists, open FS Referral View; else open Triage Referral View
                    If modStatQuery.QuerySecondaryExists(vCallID) = SUCCESS Then
                        If Not modUtility.ChkOpenForm("FrmReferralView") Then
                            Call modUtility.Work()
                            AppMain.frmReferralView = New FrmReferralView()
                            AppMain.frmReferralView.FormState = EXISTING_RECORD
                            AppMain.frmReferralView.CallId = vCallID
                            AppMain.frmReferralView.Show()
                            AppMain.frmReferralView.TabDonor.SelectedIndex = 1
                        Else
                            Call modUtility.Done()
                            Exit Sub
                        End If
                    Else
                        If Not modUtility.ChkOpenForm("FrmReferral") Then
                            Call modUtility.Work()
                            AppMain.frmReferral = New FrmReferral()
                            AppMain.frmReferral.FormState = EXISTING_RECORD
                            AppMain.frmReferral.CallId = vCallID
                            AppMain.frmReferral.Show()
                            AppMain.frmReferral.TabDonor.SelectedIndex = 0
                            AppMain.frmReferral.TabDonor.SelectedIndex = 2
                        Else
                            Call modUtility.Done()
                            Exit Sub
                        End If
                    End If

                Else
                    If modStatRefQuery.RefQueryStatEmployee(vReturn2, vCallEmployeeID) = SUCCESS Then
                        MsgBox("You cannot open this referral because the original has not yet been saved by " & Chr(10) & vReturn2(0, 1) & "." & Chr(10) & "Transfer the caller to " & vReturn2(0, 1) & ".")
                    Else
                        MsgBox("You cannot open this referral because the original has not yet been saved.")
                    End If
                    Call modUtility.Done()
                    Exit Sub
                End If

            Case Message
                If modStatQuery.QueryMessageID(vCallID) = SUCCESS Then
                    If Not modUtility.ChkOpenForm("FrmMessage") Then
                        AppMain.frmMessage = New FrmMessage()
                        AppMain.frmMessage.FormState = EXISTING_RECORD
                        AppMain.frmMessage.CallId = vCallID
                        AppMain.frmMessage.Display()
                        AppMain.frmMessage.TabMessage.SelectedIndex = 1
                    Else
                        Call modUtility.Done()
                        Exit Sub
                    End If
                Else
                    If modStatRefQuery.RefQueryStatEmployee(vReturn2, vCallEmployeeID) = SUCCESS Then
                        MsgBox("You cannot open this message because the original has not yet been saved by " & Chr(10) & vReturn2(0, 1) & "." & Chr(10) & "Transfer the caller to " & vReturn2(0, 1) & ".")
                    Else
                        MsgBox("You cannot open this message because the original has not yet been saved.")
                    End If
                    Call modUtility.Done()
                    Exit Sub
                End If
            Case NOCALL
                If modStatQuery.QueryNoCallID(vCallID) = SUCCESS Then
                    If Not modUtility.ChkOpenForm("FrmNoCall") Then
                        AppMain.frmNoCall = New FrmNoCall()
                        AppMain.frmNoCall.FormState = EXISTING_RECORD
                        AppMain.frmNoCall.CallId = vCallID
                        Call AppMain.frmNoCall.Display()
                    Else
                        Call modUtility.Done()
                        Exit Sub
                    End If
                Else
                    If modStatRefQuery.RefQueryStatEmployee(vReturn2, vCallEmployeeID) = SUCCESS Then
                        MsgBox("You cannot open this message because the original has not yet been saved by " & Chr(10) & vReturn2(0, 1) & "." & Chr(10) & "Transfer the caller to " & vReturn2(0, 1) & ".")
                    Else
                        MsgBox("You cannot open this message because the original has not yet been saved.")
                    End If
                    Call modUtility.Done()
                    Exit Sub
                End If

        End Select

        Call modUtility.Done()

        Exit Sub

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        Resume Next

    End Sub

    Private Sub LstViewGeneralAlert_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LstViewGeneralAlert.Click

    End Sub


    Private Sub LstViewGeneralAlert_DoubleClick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewGeneralAlert.DoubleClick


        If LstViewGeneralAlert.Items.Count = 0 Then
            Exit Sub
        End If

        AppMain.OpenFrmGeneralAlert("DoubleClick")


    End Sub

    Private Sub LstViewGeneralAlert_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewGeneralAlert.Enter

        CmdDeleteRef.Enabled = False
        CmdDeleteMsg.Enabled = False
        CmdDeleteNC.Enabled = False

    End Sub

    Private Sub LstViewGeneralAlert_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewGeneralAlert.Leave

        CmdDeleteRef.Enabled = True
        CmdDeleteMsg.Enabled = True
        CmdDeleteNC.Enabled = True

    End Sub

    Private Sub LstViewGeneralAlert_MouseUp(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.MouseEventArgs) Handles LstViewGeneralAlert.MouseUp
        Dim Button As Short = eventArgs.Button \ &H100000
        Dim Shift As Short = System.Windows.Forms.Control.ModifierKeys \ &H10000
        Dim x As Integer = eventArgs.X ' VB6.PixelsToTwipsX(eventArgs.X)
        Dim y As Integer = eventArgs.Y ' eVB6.PixelsToTwipsY(eventArgs.Y)

        If Button = 2 Then
            AppMain.ParentForm.MnuGeneralAlert1.Visible = True
            ContextMenuPopup(AppMain.ParentForm.MnuGeneralAlert1, eventSender, x, y)

        End If

    End Sub

    Private Sub ContextMenuPopup(ByVal toolStripMenuItem As ToolStripMenuItem, ByVal eventSender As Object, ByVal x As Integer, ByVal y As Integer)

        contextMenuStrip.Items.Clear()
        contextMenuStrip.Items.Add(toolStripMenuItem)
        contextMenuStrip.Show(DirectCast(eventSender, Control), x, y)
    End Sub

    Private Sub LstViewIncompletes_ColumnClick(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.ColumnClickEventArgs) Handles LstViewIncompletes.ColumnClick
        Dim ColumnHeader As System.Windows.Forms.ColumnHeader = LstViewIncompletes.Columns(eventArgs.Column)

        ' When a ColumnHeader object is clicked, the ListView control is
        ' sorted by the subitems of that column.
        ' Set the SortKey to the Index of the ColumnHeader - 1
        LstViewIncompletes.Sorting = IncompleteSortOrder
        LstViewIncompletes.ListViewItemSorter = New ListViewItemComparer(eventArgs.Column, Me.IncompleteSortOrder)

        If IncompleteSortOrder = System.Windows.Forms.SortOrder.Ascending Then
            IncompleteSortOrder = System.Windows.Forms.SortOrder.Descending
        Else
            IncompleteSortOrder = System.Windows.Forms.SortOrder.Ascending
        End If


    End Sub


    Private Sub LstViewIncompletes_DoubleClick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewIncompletes.DoubleClick
        '************************************************************************************
        'Name: LstViewIncompletes_DblClick
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: open an incomplete call
        '
        '
        'Stored Procedures: na
        '====================================================================================

        Dim vCallID As Integer
        Dim vCallTypeID As Short
        Dim vCallNumber As String = ""
        Dim vCallEmployeeID As Short
        Dim vReturn As New Object
        Dim vReturn2 As New Object

        On Error GoTo localError

        '*******************
        'Open the call first
        '*******************

        Call modUtility.Work()

        vCallID = modConv.TextToLng(LstViewIncompletes.FocusedItem.Tag)

        If modStatRefQuery.RefQueryCall(vReturn, vCallID) = SUCCESS Then
            vCallID = vReturn(0, 0)
            vCallNumber = vReturn(0, 1)
            vCallTypeID = vReturn(0, 2)
            vCallEmployeeID = vReturn(0, 3)
        End If

        Select Case vCallTypeID

            Case REFERRAL
                If modStatQuery.QueryReferralID(vCallID) = SUCCESS Then

                    If Not modUtility.ChkOpenForm("FrmReferral") Then
                        Call modUtility.Work()
                        AppMain.frmReferral = New FrmReferral
                        AppMain.frmReferral.FormState = EXISTING_RECORD
                        AppMain.frmReferral.CallId = vCallID
                        AppMain.frmReferral.Show()
                        AppMain.frmReferral.TabDonor.SelectedIndex = 0
                        'ccarroll 06/08/2010 added check for Secondary tab 
                        If AppMain.frmReferral.TabDonor.TabPages.Count > 2 Then
                            'If modStatQuery.QuerySecondaryExists(vCallID) = SUCCESS OR AppMain.frmReferral.TabDonor[2].Enabled = true Then
                            AppMain.frmReferral.TabDonor.SelectedIndex = 2
                        Else
                            AppMain.frmReferral.TabDonor.SelectedIndex = 1
                        End If
                    Else
                        Call modUtility.Done()
                        Exit Sub
                    End If
                Else
                    If modStatRefQuery.RefQueryStatEmployee(vReturn2, vCallEmployeeID) = SUCCESS Then
                        MsgBox("You cannot open this referral because the original has not yet been saved by " & Chr(10) & vReturn2(0, 1) & "." & Chr(10) & "Transfer the caller to " & vReturn2(0, 1) & ".")
                    Else
                        MsgBox("You cannot open this referral because the original has not yet been saved.")
                    End If
                    Call modUtility.Done()
                    Exit Sub
                End If

            Case Message
                If modStatQuery.QueryMessageID(vCallID) = SUCCESS Then
                    If Not modUtility.ChkOpenForm("FrmMessage") Then
                        AppMain.frmMessage = New FrmMessage()
                        AppMain.frmMessage.FormState = EXISTING_RECORD
                        AppMain.frmMessage.CallId = vCallID
                        AppMain.frmMessage.Display()
                        AppMain.frmMessage.TabMessage.SelectedIndex = 1
                    Else
                        Call modUtility.Done()
                        Exit Sub
                    End If
                Else
                    If modStatRefQuery.RefQueryStatEmployee(vReturn2, vCallEmployeeID) = SUCCESS Then
                        MsgBox("You cannot open this message because the original has not yet been saved by " & Chr(10) & vReturn2(0, 1) & "." & Chr(10) & "Transfer the caller to " & vReturn2(0, 1) & ".")
                    Else
                        MsgBox("You cannot open this message because the original has not yet been saved.")
                    End If
                    Call modUtility.Done()
                    Exit Sub
                End If
            Case NOCALL
                If modStatQuery.QueryNoCallID(vCallID) = SUCCESS Then
                    If Not modUtility.ChkOpenForm("FrmNoCall") Then
                        AppMain.frmNoCall = New FrmNoCall()
                        AppMain.frmNoCall.FormState = EXISTING_RECORD
                        AppMain.frmNoCall.CallId = vCallID
                        Call AppMain.frmNoCall.Display()
                    Else
                        Call modUtility.Done()
                        Exit Sub
                    End If
                Else
                    If modStatRefQuery.RefQueryStatEmployee(vReturn2, vCallEmployeeID) = SUCCESS Then
                        MsgBox("You cannot open this message because the original has not yet been saved by " & Chr(10) & vReturn2(0, 1) & "." & Chr(10) & "Transfer the caller to " & vReturn2(0, 1) & ".")
                    Else
                        MsgBox("You cannot open this message because the original has not yet been saved.")
                    End If
                    Call modUtility.Done()
                    Exit Sub
                End If

        End Select

        Call modUtility.Done()

        Exit Sub

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        Call MsgBox("Err", MsgBoxStyle.OkOnly, "Err")
        Resume Next

    End Sub


    Private Sub LstViewIncompletes_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewIncompletes.Enter

        CmdDeleteRef.Enabled = False
        CmdDeleteMsg.Enabled = False
        CmdDeleteNC.Enabled = False

    End Sub

    Private Sub LstViewIncompletes_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewIncompletes.Leave

        CmdDeleteRef.Enabled = True
        CmdDeleteMsg.Enabled = True
        CmdDeleteNC.Enabled = True

    End Sub

    Private Sub LstViewIncompletes_MouseUp(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.MouseEventArgs) Handles LstViewIncompletes.MouseUp
        Dim Button As Short = eventArgs.Button \ &H100000
        Dim Shift As Short = System.Windows.Forms.Control.ModifierKeys \ &H10000
        Dim x As Integer = eventArgs.X 'VB6.PixelsToTwipsX(eventArgs.X)
        Dim y As Integer = eventArgs.Y 'VB6.PixelsToTwipsY(eventArgs.Y)

        On Error Resume Next

        If Button = 2 Then
            If modStatSecurity.GetPermission(AppMain.ParentForm.StatEmployeeID, "AllowCallDelete") Then

                'ContextMenuPopup(AppMain.ParentForm.MnuGeneralAlert, eventSender, x, y)
                ContextMenuPopup(AppMain.ParentForm.MnuDeletePending, eventSender, x, y)
            End If
            'had to comment this out because it would fire right after right click and not allow row to get focus
            'Refresh Grid 
            'Call modStatQuery.QueryIncompletes(Me)

            'IncompleteSortOrder = System.Windows.Forms.SortOrder.Ascending
            'Call LstViewIncompletes_ColumnClick(LstViewIncompletes, New System.Windows.Forms.ColumnClickEventArgs(LstViewIncompletes.Columns.Item(1).Index))

            'Me.SendToBack()
            'End If
        End If

    End Sub

    Private Sub LstViewOpenInformation_ColumnClick(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.ColumnClickEventArgs) Handles LstViewOpenInformation.ColumnClick
        Dim ColumnHeader As System.Windows.Forms.ColumnHeader = LstViewOpenInformation.Columns(eventArgs.Column)

        'mds 10/21/03 Added for information calls

        ' When a ColumnHeader object is clicked, the ListView control is
        ' sorted by the subitems of that column.
        ' Set the SortKey to the Index of the ColumnHeader - 1
        LstViewOpenInformation.Sorting = InformationSortOrder
        LstViewOpenInformation.ListViewItemSorter = New ListViewItemComparer(eventArgs.Column, Me.InformationSortOrder)

        If InformationSortOrder = System.Windows.Forms.SortOrder.Ascending Then
            InformationSortOrder = System.Windows.Forms.SortOrder.Descending
        Else
            InformationSortOrder = System.Windows.Forms.SortOrder.Ascending
        End If
    End Sub

    Private Sub LstViewOpenInformation_DoubleClick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewOpenInformation.DoubleClick


    End Sub

    Private Sub LstViewOpenMessage_ColumnClick(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.ColumnClickEventArgs) Handles LstViewOpenMessage.ColumnClick
        Dim ColumnHeader As System.Windows.Forms.ColumnHeader = LstViewOpenMessage.Columns(eventArgs.Column)

        ' When a ColumnHeader object is clicked, the ListView control is
        ' sorted by the subitems of that column.
        ' Set the SortKey to the Index of the ColumnHeader - 1
        LstViewOpenMessage.Sorting = MessageSortOrder
        LstViewOpenMessage.ListViewItemSorter = New ListViewItemComparer(eventArgs.Column, Me.MessageSortOrder)

        If MessageSortOrder = System.Windows.Forms.SortOrder.Ascending Then
            MessageSortOrder = System.Windows.Forms.SortOrder.Descending
        Else
            MessageSortOrder = System.Windows.Forms.SortOrder.Ascending
        End If

    End Sub


    Private Sub LstViewOpenMessage_DoubleClick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewOpenMessage.DoubleClick
        '************************************************************************************
        'Name: LstViewOpenMessage_DblClick
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: opens a message
        '
        '
        'Stored Procedures: na
        '====================================================================================

        If LstViewOpenMessage.Items.Count = 0 Then
            Exit Sub
        End If

        Call modUtility.Work()

        'Get the call ID
        Me.CallId = modConv.TextToLng(LstViewOpenMessage.FocusedItem.Tag)

        If Not modUtility.ChkOpenForm("FrmMessage") Then
            AppMain.frmMessage = New FrmMessage()
            AppMain.frmMessage.FormState = EXISTING_RECORD
            AppMain.frmMessage.CallId = Me.CallId
            AppMain.frmMessage.Display()
        End If

        Call modUtility.Done()

    End Sub


    Private Sub LstViewOpenMessage_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewOpenMessage.Enter

        CmdDeleteMsg.Enabled = True

    End Sub



    Private Sub LstViewOpenNoCall_ColumnClick(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.ColumnClickEventArgs) Handles LstViewOpenNoCall.ColumnClick
        Dim ColumnHeader As System.Windows.Forms.ColumnHeader = LstViewOpenNoCall.Columns(eventArgs.Column)

        ' When a ColumnHeader object is clicked, the ListView control is
        ' sorted by the subitems of that column.
        ' Set the SortKey to the Index of the ColumnHeader - 1
        LstViewOpenNoCall.Sorting = NoCallSortOrder
        LstViewOpenNoCall.ListViewItemSorter = New ListViewItemComparer(eventArgs.Column, Me.NoCallSortOrder)

        If NoCallSortOrder = System.Windows.Forms.SortOrder.Ascending Then
            NoCallSortOrder = System.Windows.Forms.SortOrder.Descending
        Else
            NoCallSortOrder = System.Windows.Forms.SortOrder.Ascending
        End If

    End Sub


    Private Sub LstViewOpenNoCall_DoubleClick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewOpenNoCall.DoubleClick

        If LstViewOpenNoCall.Items.Count = 0 Then
            Exit Sub
        End If

        Call modUtility.Work()

        'Get the call ID
        Me.CallId = modConv.TextToLng(LstViewOpenNoCall.FocusedItem.Tag)

        If Not modUtility.ChkOpenForm("FrmNoCall") Then
            AppMain.frmNoCall = New FrmNoCall()
            AppMain.frmNoCall.FormState = EXISTING_RECORD
            AppMain.frmNoCall.CallId = Me.CallId
            Call AppMain.frmNoCall.Display()
        End If

        Call modUtility.Done()

    End Sub

    Private Sub LstViewOpenNoCall_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewOpenNoCall.Enter

        CmdDeleteNC.Enabled = True

    End Sub

    Private Sub LstViewOpenReferral_ColumnClick(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.ColumnClickEventArgs) Handles LstViewOpenReferral.ColumnClick
        Dim ColumnHeader As System.Windows.Forms.ColumnHeader = LstViewOpenReferral.Columns(eventArgs.Column)

        ' When a ColumnHeader object is clicked, the ListView control is
        ' sorted by the subitems of that column.
        ' Set the SortKey to the Index of the ColumnHeader - 1
        LstViewOpenReferral.Sorting = ReferralSortOrder
        LstViewOpenReferral.ListViewItemSorter = New ListViewItemComparer(eventArgs.Column, Me.ReferralSortOrder)

        If ReferralSortOrder = System.Windows.Forms.SortOrder.Ascending Then
            ReferralSortOrder = System.Windows.Forms.SortOrder.Descending
        Else
            ReferralSortOrder = System.Windows.Forms.SortOrder.Ascending
        End If

    End Sub


    Private Sub LstViewOpenReferral_DoubleClick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewOpenReferral.DoubleClick
        '====================================================================================
        'Date Changed: 4/25/06                          Changed by: Char Chaput
        'Release #: 8.0                              Release 8.0
        'Description:  Added checking if was cancelled from the New Call screen by including
        'fields CallTotalTime in the query. This determines
        'querys for FrmReferral if opened from the recycle bin.
        '====================================================================================
        '************************************************************************************

        On Error Resume Next

        Dim vReturn As New Object
        Dim vCallID As New Object
        Dim vCallNumber As New Object
        Dim vCallTypeID As New Object
        Dim vCallEmployeeID As New Object
        Dim vRecycledNC As New Object
        Dim vSourceCodeId As New Object

        If LstViewOpenReferral.Items.Count = 0 Then
            Exit Sub
        End If

        Call modUtility.Work()

        'Get the call ID
        Me.CallId = modConv.TextToLng(LstViewOpenReferral.FocusedItem.Tag)

        'Char Chaput 04/26/06 Get CallTotalTime
        If modStatRefQuery.RefQueryCall(vReturn, Me.CallId) = SUCCESS Then
            vCallID = vReturn(0, 0)
            vCallNumber = vReturn(0, 1)
            vCallTypeID = vReturn(0, 2)
            vCallEmployeeID = vReturn(0, 3)
            vRecycledNC = vReturn(0, 4)

            '10/8/07 bret moved within if statement
            If Not modUtility.ChkOpenForm("FrmReferral") Then
                Call modUtility.Work()
                'Char Chaput 04/25/06 if the referral was recycled from
                'FrmNew when cancel was clicked flag the referral
                AppMain.frmReferral = New FrmReferral()
                If vRecycledNC = 1 Then

                    AppMain.frmReferral.RecycledNC = True
                    AppMain.frmReferral.RecycledNCType = 1
                ElseIf vRecycledNC = 3 Then
                    AppMain.frmReferral.RecycledNCType = 3
                End If
                AppMain.frmReferral.FormState = EXISTING_RECORD
                AppMain.frmReferral.CallId = Me.CallId

                AppMain.frmReferral.TabDonor.SelectedIndex = 0
                AppMain.frmReferral.Show()
                AppMain.frmReferral.CmdCancel.Focus()
            End If
        End If





        Call modUtility.Done()

    End Sub


    Private Sub LstViewOpenReferral_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewOpenReferral.Enter

        CmdDeleteRef.Enabled = True

    End Sub


    Private Sub LstViewPendingConsent_ColumnClick(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.ColumnClickEventArgs) Handles LstViewPendingConsent.ColumnClick
        Dim ColumnHeader As System.Windows.Forms.ColumnHeader = LstViewPendingConsent.Columns(eventArgs.Column)

        ' When a ColumnHeader object is clicked, the ListView control is
        ' sorted by the subitems of that column.
        ' Set the SortKey to the Index of the ColumnHeader - 1
        LstViewPendingConsent.Sorting = ConsentSortOrder
        LstViewPendingConsent.ListViewItemSorter = New ListViewItemComparer(eventArgs.Column, Me.ConsentSortOrder)

        If ConsentSortOrder = System.Windows.Forms.SortOrder.Ascending Then
            ConsentSortOrder = System.Windows.Forms.SortOrder.Descending
        Else
            ConsentSortOrder = System.Windows.Forms.SortOrder.Ascending
        End If

    End Sub

    Private Sub LstViewPendingConsent_DoubleClick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewPendingConsent.DoubleClick

        Dim vEventTypeList(1) As Object

        Dim vLogEventID As Integer
        Dim I As Short
        Dim vCallID As Integer
        Dim vCallTypeID As Short
        Dim vCallNumber As String = ""
        Dim vReturn As New Object
        Dim vReturn2 As New Object
        Dim vCallEmployeeID As Short

        On Error Resume Next

        '*******************
        'Open the call first
        '*******************
        Call modUtility.Work()

        vLogEventID = modConv.TextToLng(LstViewPendingConsent.FocusedItem.Tag)

        'Get the call number info
        If modStatQuery.QueryLogEventCall(vLogEventID, vReturn) = SUCCESS Then
            vCallID = vReturn(0, 0)
            vCallNumber = vReturn(0, 1)
            vCallTypeID = vReturn(0, 2)
            vCallEmployeeID = vReturn(0, 4)
        Else
            Exit Sub
        End If


        Select Case vCallTypeID

            Case REFERRAL
                If modStatQuery.QueryReferralID(vCallID) = SUCCESS Then
                    If Not modUtility.ChkOpenForm("FrmReferral") Then
                        Call modUtility.Work()
                        AppMain.frmReferral = New FrmReferral()
                        AppMain.frmReferral.FormState = EXISTING_RECORD
                        AppMain.frmReferral.CallId = vCallID
                        AppMain.frmReferral.Show()
                        AppMain.frmReferral.TabDonor.SelectedIndex = 0
                        AppMain.frmReferral.TabDonor.SelectedIndex = 2
                        'AppMain.frmReferral.Show()
                        Call modUtility.Done()
                    Else
                        Exit Sub
                    End If
                Else
                    If modStatRefQuery.RefQueryStatEmployee(vReturn2, vCallEmployeeID) = SUCCESS Then
                        MsgBox("You cannot open this referral because the original has not yet been saved by " & Chr(10) & vReturn2(0, 1) & "." & Chr(10) & "Transfer the caller to " & vReturn2(0, 1) & ".")
                    Else
                        MsgBox("You cannot open this referral because the original has not yet been saved.")
                    End If

                    Exit Sub
                End If

            Case Message
                If modStatQuery.QueryMessageID(vCallID) = SUCCESS Then
                    If Not modUtility.ChkOpenForm("FrmMessage") Then
                        AppMain.frmMessage = New FrmMessage()
                        AppMain.frmMessage.FormState = EXISTING_RECORD
                        AppMain.frmMessage.CallId = vCallID
                        AppMain.frmMessage.Display()
                    Else
                        Exit Sub
                    End If
                Else
                    If modStatRefQuery.RefQueryStatEmployee(vReturn2, vCallEmployeeID) = SUCCESS Then
                        MsgBox("You cannot open this message because the original has not yet been saved by " & Chr(10) & vReturn2(0, 1) & "." & Chr(10) & "Transfer the caller to " & vReturn2(0, 1) & ".")
                    Else
                        MsgBox("You cannot open this message because the original has not yet been saved.")
                    End If

                    Exit Sub
                End If
        End Select

        Call modUtility.Done()

    End Sub


    Private Sub LstViewPendingConsent_DragDrop(ByRef Source As System.Windows.Forms.Control, ByRef x As Single, ByRef y As Single)

        'ImageDivider.Top = y + LstViewPendingPage.Height
        'LstViewPendingPage.Height = ImageDivider.Top - 15
        'LstViewPendingConsent.Top = ImageDivider.Top + 15
        LstViewPendingConsent.Height = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(Me.ClientRectangle.Height) - VB6.PixelsToTwipsY(LstViewPendingPage.Height))

    End Sub

    Private Sub LstViewPendingConsent_MouseMove(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.MouseEventArgs) Handles LstViewPendingConsent.MouseMove
        Dim Button As Short = eventArgs.Button \ &H100000
        Dim Shift As Short = System.Windows.Forms.Control.ModifierKeys \ &H10000
        Dim x As Single = VB6.PixelsToTwipsX(eventArgs.X)
        Dim y As Single = VB6.PixelsToTwipsY(eventArgs.Y)

        System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.Default

    End Sub

    Private Sub LstViewPendingPage_ColumnClick(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.ColumnClickEventArgs) Handles LstViewPendingPage.ColumnClick
        Dim ColumnHeader As System.Windows.Forms.ColumnHeader = LstViewPendingPage.Columns(eventArgs.Column)

        ' When a ColumnHeader object is clicked, the ListView control is
        ' sorted by the subitems of that column.
        ' Set the SortKey to the Index of the ColumnHeader - 1
        LstViewPendingPage.Sorting = PageSortOrder
        LstViewPendingPage.ListViewItemSorter = New ListViewItemComparer(eventArgs.Column, Me.PageSortOrder)

        If PageSortOrder = System.Windows.Forms.SortOrder.Ascending Then
            PageSortOrder = System.Windows.Forms.SortOrder.Descending
        Else
            PageSortOrder = System.Windows.Forms.SortOrder.Ascending
        End If

    End Sub

    Private Sub LstViewPendingPage_DoubleClick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewPendingPage.DoubleClick
        '************************************************************************************
        'Name: LstViewPendingPage_DblClick
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: open an pending call
        '
        '
        'Stored Procedures: na
        '====================================================================================
        Dim vLogEventID As Integer
        Dim vCallID As Integer
        Dim vCallTypeID As Short
        Dim vCallNumber As String = ""
        Dim vCallEmployeeID As Short
        Dim vReturn As New Object
        Dim vReturn2 As Object = New Object()


        On Error GoTo localError

        '*******************
        'Open the call first
        '*******************

        Call modUtility.Work()

        vLogEventID = modConv.TextToLng(LstViewPendingPage.FocusedItem.Tag)

        'Get the call number info
        If modStatQuery.QueryLogEventCall(vLogEventID, vReturn) = SUCCESS Then
            vCallID = vReturn(0, 0)
            vCallNumber = vReturn(0, 1)
            vCallTypeID = vReturn(0, 2)
            vCallEmployeeID = vReturn(0, 4)
        Else
            Call modUtility.Done()
            Exit Sub
        End If

        Select Case vCallTypeID

            Case REFERRAL
                If modStatQuery.QueryReferralID(vCallID) = SUCCESS Then
                    If Not modUtility.ChkOpenForm("FrmReferral") Then
                        Call modUtility.Work()
                        AppMain.frmReferral = New FrmReferral()
                        AppMain.frmReferral.FormState = EXISTING_RECORD
                        AppMain.frmReferral.CallId = vCallID
                        AppMain.frmReferral.Show()

                        'ccarroll 04/21/2010 changed SelectedIndex from 2 to 1
                        AppMain.frmReferral.TabDonor.SelectedIndex = 0

                        'ccarroll 06/08/2010 added check for Secondary tab 
                        If AppMain.frmReferral.TabDonor.TabPages.Count > 2 Then
                            'If modStatQuery.QuerySecondaryExists(vCallID) = SUCCESS OR AppMain.frmReferral.TabDonor[2].Enabled = true Then
                            AppMain.frmReferral.TabDonor.SelectedIndex = 2
                        Else
                            AppMain.frmReferral.TabDonor.SelectedIndex = 1
                        End If

                    Else
                        Call modUtility.Done()
                        Exit Sub
                    End If
                Else
                    If modStatRefQuery.RefQueryStatEmployee(vReturn2, vCallEmployeeID) = SUCCESS Then
                        MsgBox("You cannot open this referral because the original has not yet been saved by " & Chr(10) & vReturn2(0, 1) & "." & Chr(10) & "Transfer the caller to " & vReturn2(0, 1) & ".")
                    Else
                        MsgBox("You cannot open this referral because the original has not yet been saved.")
                    End If
                    Call modUtility.Done()
                    Exit Sub
                End If

            Case Message
                If modStatQuery.QueryMessageID(vCallID) = SUCCESS Then
                    If Not modUtility.ChkOpenForm("FrmMessage") Then
                        AppMain.frmMessage = New FrmMessage()
                        AppMain.frmMessage.FormState = EXISTING_RECORD
                        AppMain.frmMessage.CallId = vCallID
                        AppMain.frmMessage.TabMessage.SelectedIndex = 1
                        AppMain.frmMessage.Display()
                    Else
                        Call modUtility.Done()
                        Exit Sub
                    End If
                Else
                    If modStatRefQuery.RefQueryStatEmployee(vReturn2, vCallEmployeeID) = SUCCESS Then
                        MsgBox("You cannot open this message because the original has not yet been saved by " & Chr(10) & vReturn2(0, 1) & "." & Chr(10) & "Transfer the caller to " & vReturn2(0, 1) & ".")
                    Else
                        MsgBox("You cannot open this message because the original has not yet been saved.")
                    End If
                    Call modUtility.Done()
                    Exit Sub
                End If
            Case NOCALL
                If modStatQuery.QueryNoCallID(vCallID) = SUCCESS Then
                    If Not modUtility.ChkOpenForm("FrmNoCall") Then
                        AppMain.frmNoCall = New FrmNoCall()
                        AppMain.frmNoCall.FormState = EXISTING_RECORD
                        AppMain.frmNoCall.CallId = vCallID
                        Call AppMain.frmNoCall.Display()
                    Else
                        Call modUtility.Done()
                        Exit Sub
                    End If
                Else
                    If modStatRefQuery.RefQueryStatEmployee(vReturn2, vCallEmployeeID) = SUCCESS Then
                        MsgBox("You cannot open this message because the original has not yet been saved by " & Chr(10) & vReturn2(0, 1) & "." & Chr(10) & "Transfer the caller to " & vReturn2(0, 1) & ".")
                    Else
                        MsgBox("You cannot open this message because the original has not yet been saved.")
                    End If
                    Call modUtility.Done()
                    Exit Sub
                End If

        End Select

        Call modUtility.Done()

        Exit Sub

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        Resume Next

    End Sub

    Public Function Display() As Object

        Me.Show()
        'Me.Width = AppMain.ParentForm.ClientRectangle.Width
        'Me.Height = AppMain.ParentForm.ClientRectangle.Height
        Me.Dock = DockStyle.Fill
        FrmOpenAll_Resize(Me, New EventArgs())
    End Function




    Public Function RefreshLists() As Object
        '************************************************************************************
        'Name: RefreshLists
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Refreshes Pending and Incomplete calls
        'Returns: NA
        'Params: NA
        '
        'Stored Procedures: None
        '====================================================================================
        '====================================================================================
        'Date Changed: 06/29/07                       Changed by: Bret Knoll
        'Release #: 8.4                              Task: 8.4.3.3 performance initiative
        'Description:   Removed the query for FS data and placed it in the method with the rest of the tabs
        '               Added a if statment to not refresh Pending and incomplete calls when the family services
        '                   tab is selected
        '====================================================================================
        If IsNothing(TabCallTypeTable) Then
            Exit Function
        End If

        '6/29/07 bret 8.4.3.3 do not refresh when viewing the family services tab
        If TabCallType.SelectedTab.Name <> TabCallTypeTable(DASHBOARD_TAB_FAMILY_SERVICES).Name Then
            'Get the page pending list
            Call modStatQuery.QueryPendingPage(Me)
            PageSortOrder = System.Windows.Forms.SortOrder.Descending
            'Call LstViewPendingPage_ColumnClick(LstViewPendingPage, New System.Windows.Forms.ColumnClickEventArgs(LstViewPendingPage.Columns.Item(1).Index))

            'Bret 07/14/2010 create two arrays for sorting 1st array is to list columns, second is to list sorting direction for each column in first array. 
            Dim columns(1) As Integer
            Dim sortOrders(1) As SortOrder
            columns(0) = LstViewPendingPage.Columns.Item(0).Index
            columns(1) = LstViewPendingPage.Columns.Item(1).Index

            sortOrders(0) = System.Windows.Forms.SortOrder.Ascending
            sortOrders(1) = System.Windows.Forms.SortOrder.Descending

            LstViewPendingPage.Sort(columns, sortOrders)
            'Get the incompletes list
            Call modStatQuery.QueryIncompletes(Me)
            IncompleteSortOrder = System.Windows.Forms.SortOrder.Ascending
            Call LstViewIncompletes_ColumnClick(LstViewIncompletes, New System.Windows.Forms.ColumnClickEventArgs(LstViewIncompletes.Columns.Item(0).Index))

        Else
            Call modStatQuery.QueryPendingCallout(Me)
            CalloutSortOrder = System.Windows.Forms.SortOrder.Descending

            'Dim columns(1) As Integer
            'Dim sortOrders(1) As SortOrder
            'columns(0) = LstViewPendingPage.Columns.Item(0).Index
            'columns(1) = LstViewPendingPage.Columns.Item(2).Index

            'sortOrders(0) = System.Windows.Forms.SortOrder.Descending
            'sortOrders(1) = System.Windows.Forms.SortOrder.Ascending
            'LstViewCallouts.Sort(columns, sortOrders)
            Call LstViewCallouts_ColumnClick(LstViewCallouts, New System.Windows.Forms.ColumnClickEventArgs(LstViewCallouts.Columns.Item(0).Index))

            'Get the secondary pending list
            Call modStatQuery.QueryPendingSecondary(Me)
            SecondarySortOrder = System.Windows.Forms.SortOrder.Descending
            Call LstViewSecondary_ColumnClick(LstViewSecondary, New System.Windows.Forms.ColumnClickEventArgs(LstViewSecondary.Columns.Item(0).Index))

            'Get the SecondaryAlerts
            Call modStatQuery.QueryPendingSecondaryAlert(Me)
            SecondaryAlertSortOrder = System.Windows.Forms.SortOrder.Descending
            Call LstViewSecondaryAlert_ColumnClick(LstViewSecondaryAlert, New System.Windows.Forms.ColumnClickEventArgs(LstViewSecondaryAlert.Columns.Item(0).Index))

        End If

        'Get the general alerts list
        Call GeneralAlerts.GetItems()
        Call GeneralAlerts.FillListView(LstViewGeneralAlert, Me)

        If GeneralAlerts.count > 0 Then

            AppMain.ParentForm.MnuEditGeneralAlert.Enabled = True
            AppMain.ParentForm.MnuDeleteGeneralAlert.Enabled = True
            AppMain.ParentForm.MnuEditGeneralAlert1.Enabled = True
            AppMain.ParentForm.MnuDeleteGeneralAlert1.Enabled = True
        Else
            AppMain.ParentForm.MnuEditGeneralAlert.Enabled = False
            AppMain.ParentForm.MnuDeleteGeneralAlert.Enabled = False
            AppMain.ParentForm.MnuEditGeneralAlert1.Enabled = False
            AppMain.ParentForm.MnuDeleteGeneralAlert1.Enabled = False
        End If

    End Function







    Private Sub LstViewPendingPage_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewPendingPage.Enter

        CmdDeleteRef.Enabled = False
        CmdDeleteMsg.Enabled = False
        CmdDeleteNC.Enabled = False

    End Sub

    Private Sub LstViewPendingPage_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewPendingPage.Leave

        CmdDeleteRef.Enabled = True
        CmdDeleteMsg.Enabled = True
        CmdDeleteNC.Enabled = True

    End Sub

    Private Sub LstViewSecondary_ColumnClick(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.ColumnClickEventArgs) Handles LstViewSecondary.ColumnClick
        Dim ColumnHeader As System.Windows.Forms.ColumnHeader = LstViewSecondary.Columns(eventArgs.Column)

        ' When a ColumnHeader object is clicked, the ListView control is
        ' sorted by the subitems of that column.
        ' Set the SortKey to the Index of the ColumnHeader - 1
        LstViewSecondary.Sorting = SecondarySortOrder
        LstViewSecondary.ListViewItemSorter = New ListViewItemComparer(eventArgs.Column, Me.SecondarySortOrder)

        If SecondarySortOrder = System.Windows.Forms.SortOrder.Ascending Then
            SecondarySortOrder = System.Windows.Forms.SortOrder.Descending
        Else
            SecondarySortOrder = System.Windows.Forms.SortOrder.Ascending
        End If

    End Sub

    Private Sub LstViewSecondary_DoubleClick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewSecondary.DoubleClick
        '************************************************************************************
        'Name: LstViewSecondary_DblClick
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: create a new call open AppMain.frmNew
        '
        '
        'Stored Procedures: na
        '====================================================================================

        Dim vCallID As Integer
        Dim vCallTypeID As Short
        Dim vCallNumber As String = ""
        Dim vCallEmployeeID As Short
        Dim vReturn As New Object
        Dim vReturn2 As New Object

        On Error GoTo localError

        '*******************
        'Open the call first
        '*******************

        Call modUtility.Work()

        vCallID = modConv.TextToLng(LstViewSecondary.FocusedItem.Tag)

        If modStatRefQuery.RefQueryCall(vReturn, vCallID) = SUCCESS Then
            vCallID = vReturn(0, 0)
            vCallNumber = vReturn(0, 1)
            vCallTypeID = vReturn(0, 2)
            vCallEmployeeID = vReturn(0, 3)
        End If

        Select Case vCallTypeID

            Case REFERRAL
                If modStatQuery.QueryReferralID(vCallID) = SUCCESS Then

                    'FSProj drh 6/15/02 If Secondary record exists, open FS Referral View; else open Triage Referral View
                    If modStatQuery.QuerySecondaryExists(vCallID) = SUCCESS Then
                        If Not modUtility.ChkOpenForm("FrmReferralView") Then
                            Call modUtility.Work()
                            AppMain.frmReferralView = New FrmReferralView()
                            AppMain.frmReferralView.FormState = EXISTING_RECORD
                            AppMain.frmReferralView.CallId = vCallID
                            AppMain.frmReferralView.Show()
                            AppMain.frmReferralView.TabDonor.SelectedTab.TabIndex = 0
                        Else
                            Call modUtility.Done()
                            Exit Sub
                        End If
                    Else
                        If Not modUtility.ChkOpenForm("FrmReferral") Then
                            Call modUtility.Work()
                            AppMain.frmReferral = New FrmReferral()
                            AppMain.frmReferral.FormState = EXISTING_RECORD
                            AppMain.frmReferral.CallId = vCallID
                            AppMain.frmReferral.Show()
                            AppMain.frmReferral.TabDonor.SelectedIndex = 0
                            AppMain.frmReferral.TabDonor.SelectedIndex = 2
                        Else
                            Call modUtility.Done()
                            Exit Sub
                        End If
                    End If
                Else
                    If modStatRefQuery.RefQueryStatEmployee(vReturn2, vCallEmployeeID) = SUCCESS Then
                        MsgBox("You cannot open this referral because the original has not yet been saved by " & Chr(10) & vReturn2(0, 1) & "." & Chr(10) & "Transfer the caller to " & vReturn2(0, 1) & ".")
                    Else
                        MsgBox("You cannot open this referral because the original has not yet been saved.")
                    End If
                    Call modUtility.Done()
                    Exit Sub
                End If

            Case Message
                If modStatQuery.QueryMessageID(vCallID) = SUCCESS Then
                    If Not modUtility.ChkOpenForm("FrmMessage") Then
                        AppMain.frmMessage = New FrmMessage()
                        AppMain.frmMessage.FormState = EXISTING_RECORD
                        AppMain.frmMessage.CallId = vCallID
                        AppMain.frmMessage.Display()
                        AppMain.frmMessage.TabMessage.SelectedIndex = 1
                    Else
                        Call modUtility.Done()
                        Exit Sub
                    End If
                Else
                    If modStatRefQuery.RefQueryStatEmployee(vReturn2, vCallEmployeeID) = SUCCESS Then
                        MsgBox("You cannot open this message because the original has not yet been saved by " & Chr(10) & vReturn2(0, 1) & "." & Chr(10) & "Transfer the caller to " & vReturn2(0, 1) & ".")
                    Else
                        MsgBox("You cannot open this message because the original has not yet been saved.")
                    End If
                    Call modUtility.Done()
                    Exit Sub
                End If
            Case NOCALL
                If modStatQuery.QueryNoCallID(vCallID) = SUCCESS Then
                    If Not modUtility.ChkOpenForm("FrmNoCall") Then
                        AppMain.frmNoCall = New FrmNoCall()
                        AppMain.frmNoCall.FormState = EXISTING_RECORD
                        AppMain.frmNoCall.CallId = vCallID
                        Call AppMain.frmNoCall.Display()
                    Else
                        Call modUtility.Done()
                        Exit Sub
                    End If
                Else
                    If modStatRefQuery.RefQueryStatEmployee(vReturn2, vCallEmployeeID) = SUCCESS Then
                        MsgBox("You cannot open this message because the original has not yet been saved by " & Chr(10) & vReturn2(0, 1) & "." & Chr(10) & "Transfer the caller to " & vReturn2(0, 1) & ".")
                    Else
                        MsgBox("You cannot open this message because the original has not yet been saved.")
                    End If
                    Call modUtility.Done()
                    Exit Sub
                End If

        End Select

        Call modUtility.Done()

        Exit Sub

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        Resume Next

    End Sub


    Private Sub LstViewSecondaryAlert_ColumnClick(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.ColumnClickEventArgs) Handles LstViewSecondaryAlert.ColumnClick
        Dim ColumnHeader As System.Windows.Forms.ColumnHeader = LstViewSecondaryAlert.Columns(eventArgs.Column)

        '6/27/01 drh Added LstViewSecondaryAlert and this Event Handler
        ' When a ColumnHeader object is clicked, the ListView control is
        ' sorted by the subitems of that column.
        ' Set the SortKey to the Index of the ColumnHeader - 1
        LstViewSecondaryAlert.Sorting = SecondaryAlertSortOrder
        LstViewSecondaryAlert.ListViewItemSorter = New ListViewItemComparer(eventArgs.Column, Me.SecondaryAlertSortOrder)

        If SecondaryAlertSortOrder = System.Windows.Forms.SortOrder.Ascending Then
            SecondaryAlertSortOrder = System.Windows.Forms.SortOrder.Descending
        Else
            SecondaryAlertSortOrder = System.Windows.Forms.SortOrder.Ascending
        End If

    End Sub


    Private Sub LstViewSecondaryAlert_DoubleClick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewSecondaryAlert.DoubleClick

        Dim vCallID As Integer
        Dim vCallTypeID As Short
        Dim vCallNumber As String = ""
        Dim vCallEmployeeID As Short
        Dim vReturn As New Object
        Dim vReturn2 As New Object

        On Error GoTo localError

        '*******************
        'Open the call first
        '*******************

        Call modUtility.Work()

        vCallID = modConv.TextToLng(LstViewSecondaryAlert.FocusedItem.Tag)

        If modStatRefQuery.RefQueryCall(vReturn, vCallID) = SUCCESS Then
            vCallID = vReturn(0, 0)
            vCallNumber = vReturn(0, 1)
            vCallTypeID = vReturn(0, 2)
            vCallEmployeeID = vReturn(0, 3)
        End If

        Select Case vCallTypeID

            Case REFERRAL
                If modStatQuery.QueryReferralID(vCallID) = SUCCESS Then

                    'FSProj drh 6/15/02 If Secondary record exists, open FS Referral View; else open Triage Referral View
                    If modStatQuery.QuerySecondaryExists(vCallID) = SUCCESS Then
                        If Not modUtility.ChkOpenForm("FrmReferralView") Then
                            Call modUtility.Work()
                            AppMain.frmReferralView = New FrmReferralView()
                            AppMain.frmReferralView.FormState = EXISTING_RECORD
                            AppMain.frmReferralView.CallId = vCallID
                            'T.T 8/28/2006 exit added to referrals with same call number
                            If Me.ExitReferral = True Then
                                Call modUtility.Done()
                                Exit Sub
                            End If
                            AppMain.frmReferralView.Show()
                            AppMain.frmReferralView.TabDonor.SelectedIndex = 0
                        Else
                            Call modUtility.Done()
                            Exit Sub
                        End If
                    Else
                        If Not modUtility.ChkOpenForm("FrmReferral") Then
                            Call modUtility.Work()
                            AppMain.frmReferral = New FrmReferral()
                            AppMain.frmReferral.FormState = EXISTING_RECORD
                            AppMain.frmReferral.CallId = vCallID
                            'T.T 8/28/2006 exit added to referrals with same call number
                            If Me.ExitReferral = True Then
                                Call modUtility.Done()
                                Exit Sub
                            End If
                            AppMain.frmReferral.Show()
                            AppMain.frmReferral.TabDonor.SelectedIndex = 0
                            AppMain.frmReferral.TabDonor.SelectedIndex = 2
                        Else
                            Call modUtility.Done()
                            Exit Sub
                        End If
                    End If

                Else
                    If modStatRefQuery.RefQueryStatEmployee(vReturn2, vCallEmployeeID) = SUCCESS Then
                        MsgBox("You cannot open this referral because the original has not yet been saved by " & Chr(10) & vReturn2(0, 1) & "." & Chr(10) & "Transfer the caller to " & vReturn2(0, 1) & ".")
                    Else
                        MsgBox("You cannot open this referral because the original has not yet been saved.")
                    End If
                    Call modUtility.Done()
                    Exit Sub
                End If

            Case Message
                If modStatQuery.QueryMessageID(vCallID) = SUCCESS Then
                    If Not modUtility.ChkOpenForm("FrmMessage") Then
                        AppMain.frmMessage = New FrmMessage()
                        AppMain.frmMessage.FormState = EXISTING_RECORD
                        AppMain.frmMessage.CallId = vCallID
                        AppMain.frmMessage.Display()
                        AppMain.frmMessage.TabMessage.SelectedIndex = 1
                    Else
                        Call modUtility.Done()
                        Exit Sub
                    End If
                Else
                    If modStatRefQuery.RefQueryStatEmployee(vReturn2, vCallEmployeeID) = SUCCESS Then
                        MsgBox("You cannot open this message because the original has not yet been saved by " & Chr(10) & vReturn2(0, 1) & "." & Chr(10) & "Transfer the caller to " & vReturn2(0, 1) & ".")
                    Else
                        MsgBox("You cannot open this message because the original has not yet been saved.")
                    End If
                    Call modUtility.Done()
                    Exit Sub
                End If
            Case NOCALL
                If modStatQuery.QueryNoCallID(vCallID) = SUCCESS Then
                    If Not modUtility.ChkOpenForm("FrmNoCall") Then
                        AppMain.frmNoCall = New FrmNoCall()
                        AppMain.frmNoCall.FormState = EXISTING_RECORD
                        AppMain.frmNoCall.CallId = vCallID
                        Call AppMain.frmNoCall.Display()
                    Else
                        Call modUtility.Done()
                        Exit Sub
                    End If
                Else
                    If modStatRefQuery.RefQueryStatEmployee(vReturn2, vCallEmployeeID) = SUCCESS Then
                        MsgBox("You cannot open this message because the original has not yet been saved by " & Chr(10) & vReturn2(0, 1) & "." & Chr(10) & "Transfer the caller to " & vReturn2(0, 1) & ".")
                    Else
                        MsgBox("You cannot open this message because the original has not yet been saved.")
                    End If
                    Call modUtility.Done()
                    Exit Sub
                End If

        End Select

        Call modUtility.Done()

        Exit Sub

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        Resume Next

    End Sub


    Private Sub TabCallType_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TabCallType.SelectedIndexChanged
        Static PreviousTab As Short = TabCallType.SelectedIndex()

        If TabCallType.SelectedIndex = Me.TabCallType.TabPages.IndexOf(TabCallTypeTable(DASHBOARD_TAB_FAMILY_SERVICES)) Then
            If AppMain.ParentForm.PersonTypeID = TRIAGE_COORDINATOR Then
                '    Call MsgBox("Sorry, you do not have access to this tab.", vbOKOnly)
                '   TabCallType.TabIndex= PreviousTab
                '  Exit Sub
                Call Me.SetTabs() 'T.T 5/25/2004 added to give Triage access to family services tab
            Else
                Call Me.SetTabs()
            End If
        Else
            Call Me.SetTabs()
        End If

        PreviousTab = TabCallType.SelectedIndex()
    End Sub


    Private Sub Timer_Renamed_Tick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles Timer_Renamed.Tick
        '************************************************************************************
        'Name: Timer_Timer
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: refreshes the dashboards on reguralarly scheduled interval
        '
        '====================================================================================
        'Date Changed: 7/03/07                       Changed by: Bret Knoll
        'Release #: 8.4                              Task: 8.4.3.3 Performance
        'Description:   Removed call for Consent Pending and Refreshlist and added call to cmd_refreshlist
        '
        '====================================================================================
        On Error Resume Next

        Dim I As Short

        If Application.OpenForms.Count > 3 Then
            Exit Sub
        End If


        modUtility.Work()

        Call Me.RefreshLists()

        modUtility.Done()

        'Check for inactive source codes
        For Each sourceCode As clsSourceCode In SourceCodes
            sourceCode.CheckLineActivity()
            If sourceCode.LineInactive = True Then
                CmdLineCheck.BackColor = System.Drawing.Color.Red
                Exit For
            Else
                CmdLineCheck.BackColor = System.Drawing.ColorTranslator.FromOle(&H8000000F)
            End If
        Next


    End Sub




    Public Function SetIcons(ByRef pvGridValues As Object, ByRef pvCurrentRow As Object, Optional ByRef pvSwitch As Object = Nothing) As Object
        '************************************************************************************
        'Name: SetIcons
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: sets the events icons
        'Returns: Nothing
        'Params: None
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 04/03/09                         Changed by: Bret Knoll
        'Release #: 8.4.8                               Task: added Acknowledge_to_Evaluate Labs_pending
        'Description:  Chaned icons for Acknowledge_to_Evaluate
        '====================================================================================
        '************************************************************************************
        Dim vLogEventOrganization As New Object
        Dim vPageInterval As New Object
        Dim vConsentInterval As Object = 0
        Dim vReturn As New Object
        Dim vResultArray As New Object

        On Error GoTo localError

        Dim vFSDateIndex As New Object
        Dim vFSPri1 As Object
        Dim vFSPri2 As Object
        If Not IsNothing(pvSwitch) Then
            Select Case pvSwitch

                Case PAGE_PENDING

                    vLogEventOrganization = pvGridValues(pvCurrentRow, 5)

                    If modStatQuery.QueryPageInterval(vLogEventOrganization, vReturn) = SUCCESS Then

                        If vReturn(0, 0) = "" Or vReturn(0, 0) = "0" Then
                            vPageInterval = 8
                        Else
                            vPageInterval = CShort(vReturn(0, 0))
                        End If



                        '0-vPageInterval minutes since event = Priority 3
                        If CDate(pvGridValues(pvCurrentRow, 7)) > DateAdd(Microsoft.VisualBasic.DateInterval.Minute, -(vPageInterval), Now) Then

                            pvGridValues(pvCurrentRow, 1) = 3
                            SetIcons = 2

                            'T.T PageInterval
                            If pvGridValues(pvCurrentRow, 4) = "Import" Then
                                pvGridValues(pvCurrentRow, 1) = ""
                                SetIcons = 0
                            End If

                            '> vPageInterval minutes since event = Priority 1
                        Else

                            pvGridValues(pvCurrentRow, 1) = ""
                            SetIcons = 0

                            'T.T PageInterval
                            If pvGridValues(pvCurrentRow, 4) = "Import" Then
                                pvGridValues(pvCurrentRow, 1) = ""
                                SetIcons = 0
                            End If
                        End If

                    Else
                        pvGridValues(pvCurrentRow, 1) = ""
                        SetIcons = 0

                    End If

                Case CONSENT_PENDING

                    vLogEventOrganization = pvGridValues(pvCurrentRow, 6)

                    If modStatQuery.QueryConsentInterval(vLogEventOrganization, vReturn) = SUCCESS Then
                        If vReturn(0, 0) = "" Or vReturn(0, 0) = "0" Then
                            vConsentInterval = 240
                        Else
                            vConsentInterval = CShort(vReturn(0, 0))
                        End If
                    End If

                    'Check the organization type, if procurement org, the set priority 1 as yellow
                    'if not procurement org, set priority 1 as red
                    If modConv.TextToInt(pvGridValues(pvCurrentRow, 1)) = PROCUREMENT_ORG Then
                        '0 - vConsentInterval since event = Priority 3
                        If CDate(pvGridValues(pvCurrentRow, 3)) > DateAdd(Microsoft.VisualBasic.DateInterval.Minute, -vConsentInterval, Now) Then
                            pvGridValues(pvCurrentRow, 1) = 3
                            SetIcons = 2
                            '> vConsentInterval since event = Priority 2
                        Else
                            pvGridValues(pvCurrentRow, 1) = 2
                            SetIcons = 1
                        End If
                    Else
                        '0 - vConsentInterval since event = Priority 3
                        If CDate(pvGridValues(pvCurrentRow, 3)) > DateAdd(Microsoft.VisualBasic.DateInterval.Minute, -vConsentInterval, Now) Then
                            pvGridValues(pvCurrentRow, 1) = 3
                            SetIcons = 2
                            '> vConsentInterval since event = Priority 1
                        Else
                            pvGridValues(pvCurrentRow, 1) = 1
                            SetIcons = 0
                        End If
                    End If

                Case RECOVERY_PENDING

                    '0-24 hours since event = Priority 3
                    If CDate(pvGridValues(pvCurrentRow, 3)) > DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -24, Now) Then
                        pvGridValues(pvCurrentRow, 1) = 3
                        SetIcons = 2

                        '24-48 hours since event = Priority 2
                    ElseIf CDate(pvGridValues(pvCurrentRow, 3)) < DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -24, Now) And CDate(pvGridValues(pvCurrentRow, 3)) > DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -48, Now) Then
                        pvGridValues(pvCurrentRow, 1) = 2
                        SetIcons = 1

                        '> 48 hours since event = Priority 1
                    Else
                        pvGridValues(pvCurrentRow, 1) = 1
                        SetIcons = 0

                    End If

                Case INCOMPLETES

                    'If the incomplete is exclusive, then set as priority 2, else priority 1
                    If pvGridValues(pvCurrentRow, 1) = -1 Then

                        pvGridValues(pvCurrentRow, 1) = 2
                        SetIcons = 1

                        'Else priority 1
                    Else

                        pvGridValues(pvCurrentRow, 1) = 1
                        SetIcons = 0

                    End If

                Case CALLBACK_PENDING

                    '10 minutes before callout datetime = Priority 2
                    If Now > DateAdd(Microsoft.VisualBasic.DateInterval.Minute, -10, CDate(pvGridValues(pvCurrentRow, 3))) And Now < CDate(pvGridValues(pvCurrentRow, 3)) Then
                        pvGridValues(pvCurrentRow, 1) = 2
                        SetIcons = 1

                        'After callout datetime = Priority 1
                    ElseIf Now > CDate(pvGridValues(pvCurrentRow, 3)) Then
                        pvGridValues(pvCurrentRow, 1) = 1
                        SetIcons = 0

                        'Before callout datetime = Priority 3
                    Else
                        pvGridValues(pvCurrentRow, 1) = 3
                        SetIcons = 2

                    End If
                Case Labs_Pending
                    'After callout datetime = Priority 1
                    If Now > CDate(pvGridValues(pvCurrentRow, 11)) Then
                        pvGridValues(pvCurrentRow, 1) = 1
                        SetIcons = 0

                        'Before callout datetime = Priority 3
                    Else
                        pvGridValues(pvCurrentRow, 1) = 3
                        SetIcons = 2

                    End If

                Case SECONDARY_PENDING

                    '< 10 minutes since event = Priority 3
                    If CDate(pvGridValues(pvCurrentRow, 3)) > DateAdd(Microsoft.VisualBasic.DateInterval.Minute, -10, Now) Then
                        pvGridValues(pvCurrentRow, 1) = 3
                        SetIcons = 0

                        '> 10 minutes since event = Priority 1
                    Else
                        pvGridValues(pvCurrentRow, 1) = 1
                        SetIcons = 2

                    End If

                    '7/6/01 drh FS Secondary Alert Window
                Case SECONDARY_ALERT

                    '< 10 minutes since event = Priority 3
                    'green Icon
                    If CDate(pvGridValues(pvCurrentRow, 3)) > DateAdd(Microsoft.VisualBasic.DateInterval.Minute, -10, Now) Then
                        pvGridValues(pvCurrentRow, 1) = 2
                        SetIcons = 2

                        '> 10 minutes since event = Priority 1
                        'alarm clock Icon
                    ElseIf DateAdd(Microsoft.VisualBasic.DateInterval.Minute, AppMain.ExpiredEventTime, pvGridValues(pvCurrentRow, 3)) < DateAdd(Microsoft.VisualBasic.DateInterval.Minute, 0, Now) Then
                        pvGridValues(pvCurrentRow, 1) = 4
                        SetIcons = 4

                    Else
                        pvGridValues(pvCurrentRow, 1) = 3
                        SetIcons = 0

                    End If

                    '7/6/01 drh FS Secondary Work in Progress Window
                Case SECONDARY_WIP

                    If pvGridValues(pvCurrentRow, 13) = "X" Then
                        vFSDateIndex = 18
                        vFSPri1 = FS_APPROACH_PRI1
                        vFSPri2 = FS_APPROACH_PRI2
                    Else
                        If pvGridValues(pvCurrentRow, 12) = "X" Then
                            vFSDateIndex = 17
                            vFSPri1 = FS_SECCOMP_PRI1
                            vFSPri2 = FS_SECCOMP_PRI2
                        Else
                            If pvGridValues(pvCurrentRow, 11) = "X" Then
                                vFSDateIndex = 16
                                vFSPri1 = FS_SYSEVENT_PRI1
                                vFSPri2 = FS_SYSEVENT_PRI2
                            Else
                                If pvGridValues(pvCurrentRow, 10) = "X" Then
                                    vFSDateIndex = 15
                                    vFSPri1 = FS_OPEN_PRI1
                                    vFSPri2 = FS_OPEN_PRI2
                                End If
                            End If
                        End If
                    End If

                    '20 minutes past stage = Priority 1
                    ' red icon
                    If Now >= DateAdd(Microsoft.VisualBasic.DateInterval.Minute, vFSPri1, CDate(pvGridValues(pvCurrentRow, vFSDateIndex))) Then
                        pvGridValues(pvCurrentRow, 1) = 3
                        SetIcons = 0

                        '10 minutes past stage = Priority 2
                        'yellow Icon
                    ElseIf Now >= DateAdd(Microsoft.VisualBasic.DateInterval.Minute, vFSPri2, CDate(pvGridValues(pvCurrentRow, vFSDateIndex))) Then
                        pvGridValues(pvCurrentRow, 1) = 2
                        SetIcons = 1

                        'Before callout datetime = Priority 3
                        'green Icon
                    Else
                        pvGridValues(pvCurrentRow, 1) = 1
                        SetIcons = 2

                    End If

                    '7/6/01 drh FS Secondary Activity Window
                Case SECONDARY_ACTIVITY

                    'What type is this Event?
                    'Page Pending
                    If pvGridValues(pvCurrentRow, 10) = "6" Then
                        'It's a Page Pending
                        vLogEventOrganization = pvGridValues(pvCurrentRow, 17) 'T.T 12/15/2006 changed to fit new sps_PendingSeondaryActivity2v from 16 to 17

                        If modStatQuery.QueryPageInterval(vLogEventOrganization, vReturn) = SUCCESS Then
                            If vReturn(0, 0) = "" Or vReturn(0, 0) = "0" Then
                                vPageInterval = 8
                            Else
                                vPageInterval = CShort(vReturn(0, 0))
                            End If

                        End If

                        '0-vPageInterval minutes since event = Priority 3
                        'green Icon
                        If CDate(pvGridValues(pvCurrentRow, 3)) > DateAdd(Microsoft.VisualBasic.DateInterval.Minute, -(vPageInterval), Now) Then
                            pvGridValues(pvCurrentRow, 1) = 1 '3
                            SetIcons = 2

                            '> vPageInterval minutes since event = Priority 1
                        Else
                            'alarm clock
                            If DateAdd(Microsoft.VisualBasic.DateInterval.Minute, AppMain.ExpiredEventTime, pvGridValues(pvCurrentRow, 3)) < DateAdd(Microsoft.VisualBasic.DateInterval.Minute, 0, Now) Then
                                pvGridValues(pvCurrentRow, 1) = 4 '1
                                SetIcons = 4

                            Else
                                'red icon
                                pvGridValues(pvCurrentRow, 1) = 3 '1
                                SetIcons = 0
                            End If
                        End If
                    Else
                        'It's a Callout Pending
                        '10 minutes before callout datetime = Priority 2
                        'yellow triangle icon
                        If Now > DateAdd(Microsoft.VisualBasic.DateInterval.Minute, -10, CDate(pvGridValues(pvCurrentRow, 3))) And Now < CDate(pvGridValues(pvCurrentRow, 3)) Then
                            pvGridValues(pvCurrentRow, 1) = 2 ' 1 ' 2
                            SetIcons = 1

                            'After callout datetime = Priority 1
                            'Over Expired or alarm clock icon

                        ElseIf DateAdd(Microsoft.VisualBasic.DateInterval.Minute, AppMain.ExpiredEventTime, pvGridValues(pvCurrentRow, 3)) < DateAdd(Microsoft.VisualBasic.DateInterval.Minute, 0, Now) Then
                            pvGridValues(pvCurrentRow, 1) = 6 '4 '1
                            SetIcons = 4

                        ElseIf Now > CDate(pvGridValues(pvCurrentRow, 3)) Then

                            pvGridValues(pvCurrentRow, 1) = 5 '4 '1
                            SetIcons = 0

                            'Before callout datetime = Priority 3
                            'green Icon
                        Else
                            pvGridValues(pvCurrentRow, 1) = 1 '2 '3
                            SetIcons = 2

                        End If
                    End If
                    '04/03/09 StatTRac 8.4.8 Added Changed icons for Acknowledge_to_Evaluate
                Case Acknowledge_to_Evaluate
                    SetIcons = 0
            End Select
        End If
        Return SetIcons
localError:

        Resume Next
        Resume
    End Function

    Private Sub TimerCounter_Tick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TimerCounter.Tick
        If LblCountRef.Visible = True Then
            LblCountRef.Visible = False
        Else
            LblCountRef.Visible = True
        End If
    End Sub

    Private Sub TxtCallNumber_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtCallNumber.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3


    End Sub

    Private Sub TxtCallNumber_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtCallNumber.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtCallNumber_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtCallNumber.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtCallNumberMsg_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtCallNumberMsg.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3

    End Sub


    Private Sub TxtCallNumberMsg_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtCallNumberMsg.Enter
        '************************************************************************************
        'Name: TxtCallNumberMsg_GotFocus
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description:
        '
        '
        'Stored Procedures: na
        '====================================================================================

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtCallNumberMsg_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtCallNumberMsg.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtCallNumberNC_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtCallNumberNC.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3

    End Sub


    Private Sub TxtCallNumberNC_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtCallNumberNC.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtCallNumberNC_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtCallNumberNC.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtCallNumberRef_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtCallNumberRef.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3

    End Sub

    Private Sub TxtCallNumberRef_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtCallNumberRef.Enter
        '************************************************************************************
        'Name: TxtCallNumberRef_GotFocus
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description:
        '
        '
        'Stored Procedures: na
        '====================================================================================

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtCallNumberRef_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtCallNumberRef.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtConsentSource_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtConsentSource.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3

    End Sub

    Private Sub TxtConsentSource_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtConsentSource.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtConsentSource_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtConsentSource.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtDescription_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtDescription.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3

    End Sub

    Private Sub TxtDescription_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtDescription.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtDescription_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtDescription.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtForPersonFirst_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtForPersonFirst.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3

    End Sub

    Private Sub TxtForPersonFirst_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtForPersonFirst.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtForPersonFirst_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtForPersonFirst.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtForPersonLast_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtForPersonLast.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3

    End Sub


    Private Sub TxtForPersonLast_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtForPersonLast.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtForPersonLast_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtForPersonLast.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtFromDate_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtFromDate.Enter

        Call modControl.HighlightText(ActiveControl)

        CurrentDate = TxtFromDate.Text

    End Sub


    Private Sub TxtFromDate_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtFromDate.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        KeyAscii = modMask.DateMask(KeyAscii, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtFromDate_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtFromDate.Leave

        On Error Resume Next

        If CurrentDate <> TxtFromDate.Text Then
            If Not IsDate(TxtFromDate.Text) And TxtFromDate.Text <> "" Then
                Call MsgBox("Invalid Date.", MsgBoxStyle.Exclamation, "Validation Error")
                TxtFromDate.Focus()
            End If
        End If

    End Sub

    Private Sub TxtFromDateInfo_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtFromDateInfo.Enter

        'mds 10/30/03 - added for Information tab
        CurrentDate = TxtFromDateInfo.Text

        Call modControl.HighlightText(ActiveControl)
    End Sub

    Private Sub TxtFromDateInfo_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtFromDateInfo.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        'mds 10/30/03 - added for Information tab
        If TxtFromDateInfo.SelectedText <> "" Then
            TxtFromDateInfo.Text = ""
        End If

        KeyAscii = modMask.DateMask(KeyAscii, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtFromDateInfo_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtFromDateInfo.Leave

        'mds 10/30/03 - added for Information tab
        On Error Resume Next

        'leave as ActiveControl 
        If (ActiveControl.Parent.Name <> TabCallType.TabPages.Item(DASHBOARD_TAB_INFO).Name) Then
            If Not IsDate(TxtFromDateInfo.Text) Then
                CmdClearFilters_Click(TxtFromDateInfo, New EventArgs)

            End If
            Exit Sub
        End If

        If CurrentDate <> TxtFromDateInfo.Text Then
            If Not IsDate(TxtFromDateInfo.Text) And TxtFromDateInfo.Text <> "" Then
                Call MsgBox("Invalid Date.", MsgBoxStyle.Exclamation, "Validation Error")
                TxtFromDateInfo.Focus()
                'Bret 05/29/07 8.4.3.3.4 prevent user from not setting year
            ElseIf Len(TxtFromDateInfo.Text) < 8 Then
                Call MsgBox("Invalid Date.", MsgBoxStyle.Exclamation, "Validation Error")
                TabCallType.SelectedIndex = DASHBOARD_TAB_INFO
                TxtFromDateInfo.Focus()
            ElseIf TxtFromDateInfo.Text = "" Then
                Call MsgBox("Date can not be blank.", MsgBoxStyle.Exclamation, "Validation Error")
                TxtFromDateInfo.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Day, -1, Now), "mm/dd/yy")
                TxtFromDateInfo.Focus()
            End If
        End If

    End Sub

    Private Sub TxtFromDateInfo_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles TxtFromDateInfo.Validating
        Dim Cancel As Boolean = eventArgs.Cancel
        'Bret 05/29/07 8.4.3.3.4 prevent user from not setting year
        If Len(TxtFromDateInfo.Text) < 8 Then
            Call MsgBox("Invalid Date.", MsgBoxStyle.Exclamation, "Validation Error")
            Cancel = True
        End If

        eventArgs.Cancel = Cancel
    End Sub

    Private Sub TxtFromDateMsg_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles TxtFromDateMsg.Validating
        Dim Cancel As Boolean = eventArgs.Cancel
        'Bret 05/29/07 8.4.3.3.4 prevent user from not setting year
        If Len(TxtFromDateMsg.Text) < 8 Then
            Call MsgBox("Invalid Date.", MsgBoxStyle.Exclamation, "Validation Error")
            Cancel = True
        End If
        eventArgs.Cancel = Cancel
    End Sub

    Private Sub txtFromDateMsgRecycle_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles txtFromDateMsgRecycle.Validating
        Dim Cancel As Boolean = eventArgs.Cancel
        'Bret 05/29/07 8.4.3.3.4 prevent user from not setting year
        If Len(txtFromDateMsgRecycle.Text) < 8 Then
            Call MsgBox("Invalid Date.", MsgBoxStyle.Exclamation, "Validation Error")
            Cancel = True
        End If

        eventArgs.Cancel = Cancel
    End Sub

    Private Sub TxtFromDateNC_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles TxtFromDateNC.Validating
        Dim Cancel As Boolean = eventArgs.Cancel
        'Bret 05/29/07 8.4.3.3.4 prevent user from not setting year
        If Len(TxtFromDateNC.Text) < 8 Then
            Call MsgBox("Invalid Date.", MsgBoxStyle.Exclamation, "Validation Error")
            Cancel = True
        End If

        eventArgs.Cancel = Cancel
    End Sub

    Private Sub txtFromDateRecycle_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles txtFromDateRecycle.Validating
        Dim Cancel As Boolean = eventArgs.Cancel
        'Bret 05/29/07 8.4.3.3.4 prevent user from not setting year
        If Len(txtFromDateRecycle.Text) < 8 Then
            Call MsgBox("Invalid Date.", MsgBoxStyle.Exclamation, "Validation Error")
            Cancel = True
        End If

        eventArgs.Cancel = Cancel
    End Sub

    Private Sub TxtFromDateRef_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles TxtFromDateRef.Validating
        Dim Cancel As Boolean = eventArgs.Cancel

        'Bret 05/29/07 8.4.3.3.4 prevent user from not setting year
        If Len(TxtFromDateRef.Text) < 8 Then
            Call MsgBox("Invalid Date.", MsgBoxStyle.Exclamation, "Validation Error")
            Cancel = True
        End If
        eventArgs.Cancel = Cancel
    End Sub

    Private Sub txtFromDateUpdate_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles txtFromDateUpdate.Validating
        Dim Cancel As Boolean = eventArgs.Cancel
        'Bret 05/29/07 8.4.3.3.4 prevent user from not setting year
        If Len(txtFromDateUpdate.Text) < 8 Then
            Call MsgBox("Invalid Date.", MsgBoxStyle.Exclamation, "Validation Error")
            Cancel = True
        End If

        eventArgs.Cancel = Cancel
    End Sub

    Private Sub TxtMsgTx_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtMsgTx.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3
    End Sub

    Private Sub txtPreRefType_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtPreRefType.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3

    End Sub

    Private Sub txtPreRefType_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtPreRefType.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub

    Private Sub txtPreRefType_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles txtPreRefType.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub txtTcNameRef_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtTcNameRef.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3

    End Sub

    Private Sub txtTcNameRef_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtTcNameRef.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub

    Private Sub txtTcNameRef_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles txtTcNameRef.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtToDateInfo_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtToDateInfo.Enter

        'mds 10/30/03 - added for Information tab
        CurrentDate = TxtToDateInfo.Text

        Call modControl.HighlightText(ActiveControl)

    End Sub

    Private Sub TxtToDateInfo_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtToDateInfo.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        'mds 10/30/03 - added for Information tab
        If TxtToDateInfo.SelectedText <> "" Then
            TxtToDateInfo.Text = ""
        End If

        KeyAscii = modMask.DateMask(KeyAscii, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtToDateInfo_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtToDateInfo.Leave

        'mds 10/30/03 - added for Information tab
        On Error Resume Next

        'leave as ActiveControl 
        If (ActiveControl.Parent.Name <> TabCallType.TabPages.Item(DASHBOARD_TAB_INFO).Name) Then
            If Not IsDate(TxtToDateInfo.Text) Then
                CmdClearFilters_Click(TxtToDateInfo, New EventArgs)

            End If
            Exit Sub
        End If

        If CurrentDate <> TxtToDateInfo.Text Then
            If Not IsDate(TxtToDateInfo.Text) And TxtToDateInfo.Text <> "" Then
                Call MsgBox("Invalid Date.", MsgBoxStyle.Exclamation, "Validation Error")
                TxtToDateInfo.Focus()
                'Bret 05/29/07 8.4.3.3.4 prevent user from not setting year
            ElseIf Len(TxtToDateInfo.Text) < 8 Then
                Call MsgBox("Invalid Date.", MsgBoxStyle.Exclamation, "Validation Error")
                TabCallType.SelectedIndex = DASHBOARD_TAB_INFO
                TxtToDateInfo.Focus()
            ElseIf TxtToDateInfo.Text = "" Then
                Call MsgBox("Date can not be blank.", MsgBoxStyle.Exclamation, "Validation Error")
                TxtToDateInfo.Text = VB6.Format(Now, "mm/dd/yy")
                TxtToDateInfo.Focus()
            End If
        End If

    End Sub

    Private Sub TxtFromDateMsg_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtFromDateMsg.Enter

        CurrentDate = TxtFromDateMsg.Text

        Call modControl.HighlightText(ActiveControl)

        TxtFromDateMsg.BackColor = System.Drawing.ColorTranslator.FromOle(&H80000005)
        TxtToDateMsg.BackColor = System.Drawing.ColorTranslator.FromOle(&H80000005)

    End Sub


    Private Sub TxtFromDateMsg_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtFromDateMsg.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)
        If TxtFromDateMsg.SelectedText <> "" Then
            TxtFromDateMsg.Text = ""
        End If

        KeyAscii = modMask.DateMask(KeyAscii, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtFromDateMsg_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtFromDateMsg.Leave

        On Error Resume Next

        'leave as ActiveControl 
        If (ActiveControl.Parent.Name <> TabCallType.TabPages.Item(DASHBOARD_TAB_MESSAGES).Name) Then
            If Not IsDate(TxtFromDateMsg.Text) Then
                CmdClearFilters_Click(TxtFromDateMsg, New EventArgs)

            End If
            Exit Sub
        End If


        If CurrentDate <> TxtFromDateMsg.Text Then
            If Not IsDate(TxtFromDateMsg.Text) And TxtFromDateMsg.Text <> "" Then
                Call MsgBox("Invalid Date.", MsgBoxStyle.Exclamation, "Validation Error")
                TxtFromDateMsg.Focus()
                'Bret 05/29/07 8.4.3.3.4 prevent user from not setting year
            ElseIf Len(TxtFromDateMsg.Text) < 8 Then
                Call MsgBox("Invalid Date.", MsgBoxStyle.Exclamation, "Validation Error")
                TabCallType.SelectedIndex = DASHBOARD_TAB_MESSAGES
                TxtFromDateMsg.Focus()
            ElseIf TxtFromDateMsg.Text = "" Then
                Call MsgBox("Date can not be blank.", MsgBoxStyle.Exclamation, "Validation Error")
                TxtFromDateMsg.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Day, -5, Now), "mm/dd/yy")
                TxtFromDateMsg.Focus()
            End If
        End If

    End Sub

    Private Sub TxtFromDateNC_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtFromDateNC.Enter

        CurrentDate = TxtFromDateNC.Text

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtFromDateNC_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtFromDateNC.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)
        If TxtFromDateNC.SelectedText <> "" Then
            TxtFromDateNC.Text = ""
        End If

        KeyAscii = modMask.DateMask(KeyAscii, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtFromDateNC_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtFromDateNC.Leave

        On Error Resume Next
        'leave as ActiveControl 
        If (ActiveControl.Parent.Name <> TabCallType.TabPages.Item(DASHBOARD_TAB_NO_CALLS).Name) Then
            If Not IsDate(TxtFromDateNC.Text) Then
                CmdClearFilters_Click(TxtFromDateNC, New EventArgs)

            End If
            Exit Sub
        End If



        If CurrentDate <> TxtFromDateNC.Text Then
            If Not IsDate(TxtFromDateNC.Text) And TxtFromDateNC.Text <> "" Then
                Call MsgBox("Invalid Date.", MsgBoxStyle.Exclamation, "Validation Error")
                TxtFromDateNC.Focus()
                'Bret 05/29/07 8.4.3.3.4 prevent user from not setting year
            ElseIf Len(TxtFromDateNC.Text) < 8 Then
                Call MsgBox("Invalid Date.", MsgBoxStyle.Exclamation, "Validation Error")
                TabCallType.SelectedIndex = DASHBOARD_TAB_NO_CALLS
                TxtFromDateNC.Focus()
            ElseIf TxtFromDateNC.Text = "" Then
                Call MsgBox("Date can not be blank.", MsgBoxStyle.Exclamation, "Validation Error")
                TxtFromDateNC.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Day, -5, Now), "mm/dd/yy")
                TxtFromDateNC.Focus()
            End If
        End If

    End Sub


    Private Sub TxtFromDateRef_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtFromDateRef.Enter

        CurrentDate = TxtFromDateRef.Text

        Call modControl.HighlightText(ActiveControl)
        TxtFromDateRef.BackColor = System.Drawing.ColorTranslator.FromOle(&H80000005)
        TxtToDateRef.BackColor = System.Drawing.ColorTranslator.FromOle(&H80000005)


    End Sub


    Private Sub TxtFromDateRef_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtFromDateRef.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)
        If TxtFromDateRef.SelectedText <> "" Then
            TxtFromDateRef.Text = ""
        End If
        KeyAscii = modMask.DateMask(KeyAscii, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtFromDateRef_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtFromDateRef.Leave

        On Error Resume Next

        If (ActiveControl.Parent.Name <> TabCallType.TabPages.Item(DASHBOARD_TAB_REFERRAL).Name) Then
            If Not IsDate(TxtFromDateRef.Text) Then
                CmdClearFilters_Click(CmdClearFilters, New EventArgs)

            End If
            Exit Sub
        End If

        If CurrentDate <> TxtFromDateRef.Text Then
            If Not IsDate(TxtFromDateRef.Text) And TxtFromDateRef.Text <> "" Then
                Call MsgBox("Invalid Date.", MsgBoxStyle.Exclamation, "Validation Error")
                TxtFromDateRef.Focus()
                'Bret 05/29/07 8.4.3.3.4 prevent user from not setting year
            ElseIf Len(TxtFromDateRef.Text) < 8 Then
                Call MsgBox("Invalid Date.", MsgBoxStyle.Exclamation, "Validation Error")
                TabCallType.SelectedIndex = DASHBOARD_TAB_REFERRAL
                TxtFromDateRef.Focus()
            ElseIf TxtFromDateRef.Text = "" Then
                Call MsgBox("Date can not be blank.", MsgBoxStyle.Exclamation, "Validation Error")
                TxtFromDateRef.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Day, -5, Now), "mm/dd/yy")
                TxtFromDateRef.Focus()
            End If
        End If

    End Sub

    Private Sub TxtFromTimeRef_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtFromTimeRef.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub

    Private Sub TxtFromTimeRef_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtFromTimeRef.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        If TxtFromTimeRef.SelectedText <> "" Then
            TxtFromTimeRef.Text = ""
        End If
        KeyAscii = modMask.MilitaryTimeMask(KeyAscii, ActiveControl)


        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtLocation_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtLocation.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3


    End Sub


    Private Sub TxtLocation_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtLocation.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtLocation_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtLocation.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtLocationMsg_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtLocationMsg.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3


    End Sub

    Private Sub TxtLocationMsg_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtLocationMsg.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtLocationMsg_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtLocationMsg.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtLocationRef_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtLocationRef.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3

    End Sub

    Private Sub TxtLocationRef_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtLocationRef.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub

    Private Sub TxtLocationRef_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtLocationRef.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtMessageType_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtMessageType.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3


    End Sub

    Private Sub TxtMessageType_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtMessageType.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtMessageType_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtMessageType.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtMsgFrom_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtMsgFrom.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3

    End Sub

    Private Sub TxtMsgFrom_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtMsgFrom.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtMsgFrom_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtMsgFrom.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtMsgSource_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtMsgSource.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3

    End Sub

    Private Sub TxtMsgSource_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtMsgSource.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtMsgSource_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtMsgSource.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtNoCallSource_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtNoCallSource.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3


    End Sub

    Private Sub TxtNoCallSource_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtNoCallSource.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtNoCallSource_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtNoCallSource.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtNoCallType_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtNoCallType.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3


    End Sub

    Private Sub TxtNoCallType_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtNoCallType.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtNoCallType_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtNoCallType.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtOrg_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtOrg.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3


    End Sub





    Private Sub TxtOrg_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtOrg.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub

    Private Sub TxtOrg_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtOrg.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtOrgPerson_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtOrgPerson.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3


    End Sub

    Private Sub TxtOrgPerson_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtOrgPerson.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub

    Private Sub TxtOrgPerson_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtOrgPerson.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtPatientFirst_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtPatientFirst.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3


    End Sub

    Private Sub TxtPatientFirst_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtPatientFirst.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtPatientFirst_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtPatientFirst.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub
    Private Sub TxtPatientFirstRef_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtPatientFirstRef.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3


    End Sub

    Private Sub TxtPatientFirstRef_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtPatientFirstRef.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtPatientFirstRef_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtPatientFirstRef.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtPatientLast_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtPatientLast.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3


    End Sub

    Private Sub TxtPatientLast_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtPatientLast.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtPatientLast_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtPatientLast.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtPatientLastRef_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtPatientLastRef.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3


    End Sub

    Private Sub TxtPatientLastRef_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtPatientLastRef.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtReferralType_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtReferralType.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3

    End Sub

    Private Sub TxtReferralType_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtReferralType.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub

    Private Sub TxtReferralType_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtReferralType.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtRefSource_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtRefSource.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3

    End Sub

    Private Sub TxtRefSource_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtRefSource.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtRefSource_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtRefSource.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtState_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtState.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3

    End Sub

    Private Sub TxtState_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtState.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtState_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtState.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtStateMsg_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtStateMsg.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3


    End Sub

    Private Sub TxtStateMsg_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtStateMsg.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtStateMsg_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtStateMsg.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtStateRef_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtStateRef.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3

    End Sub

    Private Sub TxtStateRef_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtStateRef.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtStateRef_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtStateRef.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtToDate_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtToDate.Enter

        CurrentDate = TxtToDate.Text

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtToDate_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtToDate.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        KeyAscii = modMask.DateMask(KeyAscii, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtToDate_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtToDate.Leave

        On Error Resume Next

        If CurrentDate <> TxtToDate.Text Then
            If Not IsDate(TxtToDate.Text) And TxtToDate.Text <> "" Then
                Call MsgBox("Invalid Date.", MsgBoxStyle.Exclamation, "Validation Error")
                TxtToDate.Focus()
            End If
        End If

    End Sub


    Private Sub TxtToDateInfo_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles TxtToDateInfo.Validating
        Dim Cancel As Boolean = eventArgs.Cancel
        'Bret 05/29/07 8.4.3.3.4 prevent user from not setting year
        If Len(TxtToDateInfo.Text) < 8 Then
            Call MsgBox("Invalid Date.", MsgBoxStyle.Exclamation, "Validation Error")
            Cancel = True
        End If

        eventArgs.Cancel = Cancel
    End Sub

    Private Sub TxtToDateMsg_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtToDateMsg.Enter

        CurrentDate = TxtToDateMsg.Text

        Call modControl.HighlightText(ActiveControl)

        TxtFromDateMsg.BackColor = System.Drawing.ColorTranslator.FromOle(&H80000005)
        TxtToDateMsg.BackColor = System.Drawing.ColorTranslator.FromOle(&H80000005)


    End Sub


    Private Sub TxtToDateMsg_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtToDateMsg.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)
        If TxtToDateMsg.SelectedText <> "" Then
            TxtToDateMsg.Text = ""
        End If

        KeyAscii = modMask.DateMask(KeyAscii, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtToDateMsg_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtToDateMsg.Leave

        On Error Resume Next

        'leave as ActiveControl 
        If (ActiveControl.Parent.Name <> TabCallType.TabPages.Item(DASHBOARD_TAB_MESSAGES).Name) Then
            If Not IsDate(TxtToDateMsg.Text) Then
                CmdClearFilters_Click(TxtToDateMsg, New EventArgs)

            End If
            Exit Sub
        End If

        If CurrentDate <> TxtToDateMsg.Text Then
            If Not IsDate(TxtToDateMsg.Text) And TxtToDateMsg.Text <> "" Then
                Call MsgBox("Invalid Date.", MsgBoxStyle.Exclamation, "Validation Error")
                TxtToDateMsg.Focus()
                'Bret 05/29/07 8.4.3.3.4 prevent user from not setting year
            ElseIf Len(TxtToDateMsg.Text) < 8 Then
                Call MsgBox("Invalid Date.", MsgBoxStyle.Exclamation, "Validation Error")
                TabCallType.SelectedIndex = DASHBOARD_TAB_MESSAGES
                TxtToDateMsg.Focus()
            ElseIf TxtToDateMsg.Text = "" Then
                Call MsgBox("Date can not be blank.", MsgBoxStyle.Exclamation, "Validation Error")
                TxtToDateMsg.Text = VB6.Format(Now, "mm/dd/yy")
                TxtToDateMsg.Focus()
            End If
        End If

    End Sub

    Private Sub TxtToDateMsg_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles TxtToDateMsg.Validating
        Dim Cancel As Boolean = eventArgs.Cancel
        'Bret 05/29/07 8.4.3.3.4 prevent user from not setting year
        If Len(TxtToDateMsg.Text) < 8 Then
            Call MsgBox("Invalid Date.", MsgBoxStyle.Exclamation, "Validation Error")
            Cancel = True
        End If
        eventArgs.Cancel = Cancel
    End Sub

    Private Sub txtToDateMsgRecycle_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles txtToDateMsgRecycle.Validating
        Dim Cancel As Boolean = eventArgs.Cancel
        'Bret 05/29/07 8.4.3.3.4 prevent user from not setting year
        If Len(txtToDateMsgRecycle.Text) < 8 Then
            Call MsgBox("Invalid Date.", MsgBoxStyle.Exclamation, "Validation Error")
            Cancel = True
        End If

        eventArgs.Cancel = Cancel
    End Sub

    Private Sub TxtToDateNC_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtToDateNC.Enter

        CurrentDate = TxtToDateNC.Text

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtToDateNC_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtToDateNC.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)
        If TxtToDateNC.SelectedText <> "" Then
            TxtToDateNC.Text = ""
        End If

        KeyAscii = modMask.DateMask(KeyAscii, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtToDateNC_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtToDateNC.Leave

        On Error Resume Next

        'leave as ActiveControl 
        If (ActiveControl.Parent.Name <> TabCallType.TabPages.Item(DASHBOARD_TAB_NO_CALLS).Name) Then
            If Not IsDate(TxtToDateNC.Text) Then
                CmdClearFilters_Click(TxtToDateNC, New EventArgs)

            End If
            Exit Sub
        End If


        If CurrentDate <> TxtToDateNC.Text Then
            If Not IsDate(TxtToDateNC.Text) And TxtToDateNC.Text <> "" Then
                Call MsgBox("Invalid Date.", MsgBoxStyle.Exclamation, "Validation Error")
                TxtToDateNC.Focus()
                'Bret 05/29/07 8.4.3.3.4 prevent user from not setting year
            ElseIf Len(TxtToDateNC.Text) < 8 Then
                Call MsgBox("Invalid Date.", MsgBoxStyle.Exclamation, "Validation Error")
                TabCallType.SelectedIndex = DASHBOARD_TAB_NO_CALLS
                TxtToDateNC.Focus()
            ElseIf TxtToDateNC.Text = "" Then
                Call MsgBox("Date can not be blank.", MsgBoxStyle.Exclamation, "Validation Error")
                TxtToDateNC.Text = VB6.Format(Now, "mm/dd/yy")
                TxtToDateNC.Focus()
            End If
        End If

    End Sub


    Private Sub TxtToDateNC_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles TxtToDateNC.Validating
        Dim Cancel As Boolean = eventArgs.Cancel
        'Bret 05/29/07 8.4.3.3.4 prevent user from not setting year
        If Len(TxtToDateNC.Text) < 8 Then
            Call MsgBox("Invalid Date.", MsgBoxStyle.Exclamation, "Validation Error")
            Cancel = True
        End If

        eventArgs.Cancel = Cancel
    End Sub

    Private Sub txtToDateRecycle_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles txtToDateRecycle.Validating
        Dim Cancel As Boolean = eventArgs.Cancel
        'Bret 05/29/07 8.4.3.3.4 prevent user from not setting year
        If Len(txtToDateRecycle.Text) < 8 Then
            Call MsgBox("Invalid Date.", MsgBoxStyle.Exclamation, "Validation Error")
            Cancel = True
        End If

        eventArgs.Cancel = Cancel
    End Sub

    Private Sub TxtToDateRef_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtToDateRef.Enter

        CurrentDate = TxtToDateRef.Text

        Call modControl.HighlightText(ActiveControl)

        TxtFromDateRef.BackColor = System.Drawing.ColorTranslator.FromOle(&H80000005)
        TxtToDateRef.BackColor = System.Drawing.ColorTranslator.FromOle(&H80000005)

    End Sub


    Private Sub TxtToDateRef_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtToDateRef.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)
        If TxtToDateRef.SelectedText <> "" Then
            TxtToDateRef.Text = ""
        End If
        KeyAscii = modMask.DateMask(KeyAscii, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtToDateRef_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtToDateRef.Leave

        On Error Resume Next

        'leave as ActiveControl 
        If (ActiveControl.Parent.Name <> TabCallType.TabPages.Item(DASHBOARD_TAB_REFERRAL).Name) Then
            If Not IsDate(TxtToDateRef.Text) Then
                CmdClearFilters_Click(TxtToDateRef, New EventArgs)

            End If
            Exit Sub
        End If


        If CurrentDate <> TxtToDateRef.Text Then
            If Not IsDate(TxtToDateRef.Text) And TxtToDateRef.Text <> "" Then
                Call MsgBox("Invalid Date.", MsgBoxStyle.Exclamation, "Validation Error")
                TxtToDateRef.Focus()
                'Bret 05/29/07 8.4.3.3.4 prevent user from not setting year
            ElseIf Len(TxtToDateRef.Text) < 8 Then
                Call MsgBox("Invalid Date.", MsgBoxStyle.Exclamation, "Validation Error")
                TabCallType.SelectedIndex = DASHBOARD_TAB_REFERRAL
                TxtToDateRef.Focus()
            ElseIf TxtToDateRef.Text = "" Then
                Call MsgBox("Date can not be blank.", MsgBoxStyle.Exclamation, "Validation Error")
                TxtToDateRef.Text = VB6.Format(Now, "mm/dd/yy")
                TxtToDateRef.Focus()
            End If
        End If

    End Sub

    Public Sub SetTabs()
        '************************************************************************************
        'Name: SetTabs
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Sets tab stops and other settings depending on the tab selected
        'Returns: Nothing
        'Params: None
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 5/25/05                          Changed by: Scott Plummer
        'Release #: 8.0                               Task: 416
        'Description:  Added handling for new Updates and Recycle tabs, also changed numeric
        '              values to constants.
        '************************************************************************************
        On Error Resume Next ' Added to counter fatal resize error.  5/25/05 - SAP

        'Set all tab stops to false
        TxtType.TabStop = False
        TxtCallNumber.TabStop = False
        TxtToDate.TabStop = False
        TxtFromDate.TabStop = False
        TxtLocation.TabStop = False
        TxtState.TabStop = False
        TxtPatientFirst.TabStop = False
        TxtPatientLast.TabStop = False
        TxtOrg.TabStop = False
        TxtOrgPerson.TabStop = False
        TxtConsentSource.TabStop = False
        LstViewPendingConsent.TabStop = False

        TxtCallNumberRef.TabStop = False
        TxtToDateRef.TabStop = False
        TxtFromDateRef.TabStop = False
        TxtLocationRef.TabStop = False
        TxtStateRef.TabStop = False
        TxtPatientFirstRef.TabStop = False
        TxtPatientLastRef.TabStop = False
        TxtReferralType.TabStop = False
        TxtRefSource.TabStop = False
        LstViewOpenReferral.TabStop = False
        'Added for v. 8.0, 5/25/05 - SAP
        txtPreRefType.TabStop = False
        txtTcNameRef.TabStop = False

        TxtCallNumberMsg.TabStop = False
        TxtToDateMsg.TabStop = False
        TxtFromDateMsg.TabStop = False
        TxtLocationMsg.TabStop = False
        TxtStateMsg.TabStop = False
        TxtForPersonFirst.TabStop = False
        TxtForPersonLast.TabStop = False
        TxtMessageType.TabStop = False
        TxtMsgSource.TabStop = False
        LstViewOpenMessage.TabStop = False

        TxtCallNumberNC.TabStop = False
        TxtToDateNC.TabStop = False
        TxtFromDateNC.TabStop = False
        TxtMessageType.TabStop = False
        TxtDescription.TabStop = False
        TxtNoCallSource.TabStop = False
        LstViewOpenNoCall.TabStop = False


        'mds 10/21/03 added tabstops for Information tab
        TxtCallNumberInfo.TabStop = False
        TxtFromDateInfo.TabStop = False
        TxtToDateInfo.TabStop = False
        TxtFirstNameInfo.TabStop = False
        TxtLastNameInfo.TabStop = False
        TxtCoalitionInfo.TabStop = False
        TxtStateInfo.TabStop = False
        TxtSourceInfo.TabStop = False

        ' Added tab stops for Updates tab.  5/25/05 - SAP
        txtCallNumberUpdate.TabStop = False
        txtToDateUpdate.TabStop = False
        txtFromDateUpdate.TabStop = False
        txtLocationUpdate.TabStop = False
        txtStateUpdate.TabStop = False
        txtPatientFirstUpdate.TabStop = False
        txtPatientLastUpdate.TabStop = False
        txtReferralTypeUpdate.TabStop = False
        txtRefSourceUpdate.TabStop = False
        LstViewOpenUpdate.TabStop = False
        txtPreRefTypeUpdate.TabStop = False
        txtTcNameUpdate.TabStop = False

        ' Added tab stops for Recycle tab.  5/25/05 - SAP
        'Referrals input params
        txtCallNumberRecycle.TabStop = False
        txtToDateRecycle.TabStop = False
        txtFromDateRecycle.TabStop = False
        txtLocationRecycle.TabStop = False
        txtStateRecycle.TabStop = False
        txtPatientFirstRecycle.TabStop = False
        txtPatientLastRecycle.TabStop = False
        txtReferralTypeRecycle.TabStop = False
        txtRefSourceRecycle.TabStop = False
        LstViewOpenRecycle.TabStop = False
        txtPreRefTypeRecycle.TabStop = False
        txtTcNameRecycle.TabStop = False
        'Messages input params
        txtCallNumberMsgRecycle.TabStop = False
        txtFromDateMsgRecycle.TabStop = False
        txtToDateMsgRecycle.TabStop = False
        txtForPersonFirstRecycle.TabStop = False
        txtForPersonLastRecycle.TabStop = False
        txtLocationMsgRecycle.TabStop = False
        txtStateMsgRecycle.TabStop = False
        txtMessageTypeRecycle.TabStop = False
        txtMsgSourceRecycle.TabStop = False
        txtMsgFromRecycle.TabStop = False

        'Hide restore button.
        CmdRestoreReferral.Visible = False
        CmdRestoreReferral.Enabled = False
        cmdRestoreMessage.Visible = False
        cmdRestoreMessage.Enabled = False

        'Set selected tab to true
        Dim lvh As Short
        Select Case TabCallType.TabPages.Item(TabCallType.SelectedIndex).Name

            Case TabCallTypeTable(DASHBOARD_TAB_REFERRAL).Name
                TxtCallNumberRef.TabStop = True
                TxtToDateRef.TabStop = True
                TxtFromDateRef.TabStop = True
                TxtLocationRef.TabStop = True
                TxtStateRef.TabStop = True
                TxtPatientFirstRef.TabStop = True
                TxtPatientLastRef.TabStop = True
                TxtReferralType.TabStop = True
                TxtRefSource.TabStop = True
                LstViewOpenReferral.TabStop = True
                'Added for v. 8.0, 5/25/05 - SAP
                txtPreRefType.TabStop = True
                txtTcNameRef.TabStop = True

                If AllowDelete Then
                    CmdDeleteRef.Visible = True
                Else
                    CmdDeleteRef.Visible = False
                End If
                Label(0).Visible = True
                LblCountRef.Visible = True

                CmdDeleteMsg.Visible = False
                Label(1).Visible = False
                LblCountMsg.Visible = False


                CmdDeleteNC.Visible = False
                Label(2).Visible = False
                LblCountNoCall.Visible = False

                Label(3).Visible = True
                LblCountConsent.Visible = False

                LstViewCallouts.Visible = False
                LstViewSecondary.Visible = False

                '6/26/01 drh Added all code through end of this Case
                'for component positioning when switching between
                'Family Services and other Call Type tabs
                'Make Pending and Incompletes visible
                Panel1.Visible = True
                Me.LstViewPendingPage.Visible = True
                Me.LstViewIncompletes.Visible = True
                Me.LstViewSecondaryAlert.Visible = False

                'Adjust SSTab position and size
                Call switchFSCallType()

                'Adjust Callouts position and size
                LstViewCallouts.Height = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(TabCallType.Height) - 470)
                LstViewSecondary.Height = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(TabCallType.Height) - 470)


                'Move command buttons
                Me.CmdRefresh.Top = TabCallType.Top
                Me.CmdNewCall.Top = TabCallType.Top
                Me.CmdClearFilters.Top = TabCallType.Top
                Me.CmdLineCheck.Top = TabCallType.Top

            Case TabCallTypeTable(DASHBOARD_TAB_MESSAGES).Name
                TxtCallNumberMsg.TabStop = True
                TxtToDateMsg.TabStop = True
                TxtFromDateMsg.TabStop = True
                TxtLocationMsg.TabStop = True
                TxtStateMsg.TabStop = True
                TxtForPersonFirst.TabStop = True
                TxtForPersonLast.TabStop = True
                TxtMessageType.TabStop = True
                TxtMsgSource.TabStop = True
                LstViewOpenMessage.TabStop = True

                CmdDeleteRef.Visible = False
                Label(0).Visible = False
                LblCountRef.Visible = False

                If AllowDelete Then
                    CmdDeleteMsg.Visible = True
                Else
                    CmdDeleteMsg.Visible = False
                End If
                Label(1).Visible = True
                LblCountMsg.Visible = True

                CmdDeleteNC.Visible = False
                Label(2).Visible = False
                LblCountNoCall.Visible = False

                Label(3).Visible = False
                LblCountConsent.Visible = False

                LstViewCallouts.Visible = False
                LstViewSecondary.Visible = False

                '6/26/01 drh Added all code through end of this Case
                'for component positioning when switching between
                'Family Services and other Call Type tabs
                'Make Pending and Incompletes visible
                Panel1.Visible = True
                Me.LstViewPendingPage.Visible = True
                Me.LstViewIncompletes.Visible = True
                Me.LstViewSecondaryAlert.Visible = False

                'Adjust SSTab position and size
                Call switchFSCallType()

                'Adjust Callouts position and size
                LstViewCallouts.Height = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(TabCallType.Height) - 470)
                LstViewSecondary.Height = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(TabCallType.Height) - 470)

                'Move command buttons
                Me.CmdRefresh.Top = TabCallType.Top
                Me.CmdNewCall.Top = TabCallType.Top
                Me.CmdClearFilters.Top = TabCallType.Top
                Me.CmdLineCheck.Top = TabCallType.Top

            Case TabCallTypeTable(DASHBOARD_TAB_NO_CALLS).Name
                TxtCallNumberNC.TabStop = True
                TxtToDateNC.TabStop = True
                TxtFromDateNC.TabStop = True
                TxtMessageType.TabStop = True
                TxtDescription.TabStop = True
                TxtNoCallSource.TabStop = True
                LstViewOpenNoCall.TabStop = True

                CmdDeleteRef.Visible = False
                Label(0).Visible = False
                LblCountRef.Visible = False

                CmdDeleteMsg.Visible = False
                Label(1).Visible = False
                LblCountMsg.Visible = False

                If AllowDelete Then
                    CmdDeleteNC.Visible = True
                Else
                    CmdDeleteNC.Visible = False
                End If
                Label(2).Visible = True
                LblCountNoCall.Visible = True

                Label(3).Visible = False
                LblCountConsent.Visible = False

                LstViewCallouts.Visible = False
                LstViewSecondary.Visible = False

                '6/26/01 drh Added all code through end of this Case
                'for component positioning when switching between
                'Family Services and other Call Type tabs
                'Make Pending and Incompletes visible
                Panel1.Visible = True
                Me.LstViewPendingPage.Visible = True
                Me.LstViewIncompletes.Visible = True
                Me.LstViewSecondaryAlert.Visible = False

                'Adjust SSTab position and size
                Call switchFSCallType()

                'Adjust Callouts position and size
                LstViewCallouts.Height = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(TabCallType.Height) - 470)
                LstViewSecondary.Height = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(TabCallType.Height) - 470)

                'Move command buttons
                Me.CmdRefresh.Top = TabCallType.Top
                Me.CmdNewCall.Top = TabCallType.Top
                Me.CmdClearFilters.Top = TabCallType.Top
                Me.CmdLineCheck.Top = TabCallType.Top

            Case TabCallTypeTable(DASHBOARD_TAB_CONSENTS_PENDING).Name
                TxtType.TabStop = True
                TxtCallNumber.TabStop = True
                TxtToDate.TabStop = True
                TxtFromDate.TabStop = True
                TxtLocation.TabStop = True
                TxtState.TabStop = True
                TxtPatientFirst.TabStop = True
                TxtPatientLast.TabStop = True
                TxtOrg.TabStop = True
                TxtOrgPerson.TabStop = True
                TxtConsentSource.TabStop = True
                LstViewPendingConsent.TabStop = True

                CmdDeleteRef.Visible = False
                Label(0).Visible = False
                LblCountRef.Visible = False

                CmdDeleteMsg.Visible = False
                Label(1).Visible = False
                LblCountMsg.Visible = False

                CmdDeleteNC.Visible = False
                Label(2).Visible = False
                LblCountNoCall.Visible = False

                Label(3).Visible = True
                LblCountConsent.Visible = True

                LstViewCallouts.Visible = False
                LstViewSecondary.Visible = False

                '6/26/01 drh Added all code through end of this Case
                'for component positioning when switching between
                'Family Services and other Call Type tabs
                'Make Pending and Incompletes visible
                Panel1.Visible = True
                Me.LstViewPendingPage.Visible = True
                Me.LstViewIncompletes.Visible = True
                Me.LstViewSecondaryAlert.Visible = False

                'Adjust SSTab position and size
                Call switchFSCallType()

                'Adjust Callouts position and size
                LstViewCallouts.Height = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(TabCallType.Height) - 470)
                LstViewSecondary.Height = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(TabCallType.Height) - 470)

                'Move command buttons
                Me.CmdRefresh.Top = TabCallType.Top
                Me.CmdNewCall.Top = TabCallType.Top
                Me.CmdClearFilters.Top = TabCallType.Top
                Me.CmdLineCheck.Top = TabCallType.Top

            Case TabCallTypeTable(DASHBOARD_TAB_FAMILY_SERVICES).Name
                LstViewCallouts.TabStop = True
                LstViewSecondary.TabStop = True

                LstViewCallouts.Visible = True
                LstViewSecondary.Visible = True

                CmdDeleteRef.Visible = False
                Label(0).Visible = False
                LblCountRef.Visible = False

                CmdDeleteMsg.Visible = False
                Label(1).Visible = False
                LblCountMsg.Visible = False

                CmdDeleteNC.Visible = False
                Label(2).Visible = False
                LblCountNoCall.Visible = False

                '6/26/01 drh Added all code through end of this Case
                'for component positioning when switching between
                'Family Services and other Call Type tabs
                'Make Pending and Incompletes visible
                'Hide Pending and Incompletes
                Panel1.Visible = False
                Me.LstViewPendingPage.Visible = False
                Me.LstViewIncompletes.Visible = False
                Me.LstViewSecondaryAlert.Visible = True


                'Adjust SSTab position and size
                Call switchFSCallType()

                'Adjust Callouts position and size
                LstViewCallouts.Height = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(TabCallType.Height) - 470)
                LstViewSecondary.Height = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(TabCallType.Height) - 470)

                lvh = VB6.PixelsToTwipsY(LstViewCallouts.Height)
                LstViewSecondaryAlert.Height = VB6.TwipsToPixelsY((lvh / 3) - 10)
                LstViewSecondary.Height = VB6.TwipsToPixelsY(lvh * (2 / 3) - 20)
                LstViewSecondary.Top = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(LstViewSecondaryAlert.Top) + VB6.PixelsToTwipsY(LstViewSecondaryAlert.Height) + 10)

                'Move command buttons
                Me.CmdRefresh.Top = TabCallType.Top
                Me.CmdNewCall.Top = TabCallType.Top
                Me.CmdClearFilters.Top = TabCallType.Top
                Me.CmdLineCheck.Top = TabCallType.Top

                'mds 10/21/03 added case 5 for Information tab
            Case TabCallTypeTable(DASHBOARD_TAB_INFO).Name
                TxtCallNumberInfo.TabStop = True
                TxtFromDateInfo.TabStop = True
                TxtToDateInfo.TabStop = True
                TxtFirstNameInfo.TabStop = True
                TxtLastNameInfo.TabStop = True
                TxtCoalitionInfo.TabStop = True
                TxtStateInfo.TabStop = True
                TxtSourceInfo.TabStop = True

                CmdDeleteRef.Visible = False
                Label(0).Visible = False
                LblCountRef.Visible = False

                If AllowDelete Then
                    CmdDeleteMsg.Visible = True
                Else
                    CmdDeleteMsg.Visible = False
                End If
                Label(1).Visible = True
                LblCountMsg.Visible = True

                CmdDeleteNC.Visible = False
                Label(2).Visible = False
                LblCountNoCall.Visible = False

                Label(3).Visible = False
                LblCountConsent.Visible = False

                LstViewCallouts.Visible = False
                LstViewSecondary.Visible = False

                '6/26/01 drh Added all code through end of this Case
                'for component positioning when switching between
                'Family Services and other Call Type tabs
                'Make Pending and Incompletes visible
                Panel1.Visible = True
                Me.LstViewPendingPage.Visible = True
                Me.LstViewIncompletes.Visible = True
                Me.LstViewSecondaryAlert.Visible = False

                'Adjust SSTab position and size
                Call switchFSCallType()

                'Adjust Callouts position and size
                LstViewCallouts.Height = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(TabCallType.Height) - 470)
                LstViewSecondary.Height = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(TabCallType.Height) - 470)

                'Move command buttons
                Me.CmdRefresh.Top = TabCallType.Top
                Me.CmdNewCall.Top = TabCallType.Top
                Me.CmdClearFilters.Top = TabCallType.Top
                Me.CmdLineCheck.Top = TabCallType.Top

            Case TabCallTypeTable(DASHBOARD_TAB_UPDATES).Name ' Added 5/25/05 - SAP
                txtCallNumberUpdate.TabStop = True
                txtToDateUpdate.TabStop = True
                txtFromDateUpdate.TabStop = True
                txtLocationUpdate.TabStop = True
                txtStateUpdate.TabStop = True
                txtPatientFirstUpdate.TabStop = True
                txtPatientLastUpdate.TabStop = True
                txtReferralTypeUpdate.TabStop = True
                txtRefSourceUpdate.TabStop = True
                LstViewOpenUpdate.TabStop = True
                txtPreRefTypeUpdate.TabStop = True
                txtTcNameUpdate.TabStop = True

                If AllowDelete Then
                    CmdDeleteRef.Visible = True
                Else
                    CmdDeleteRef.Visible = False
                End If
                Label(0).Visible = False
                LblCountRef.Visible = False

                CmdDeleteMsg.Visible = False
                Label(1).Visible = False
                LblCountMsg.Visible = False

                CmdDeleteNC.Visible = False
                Label(2).Visible = False
                LblCountNoCall.Visible = False

                Label(3).Visible = True
                LblCountConsent.Visible = False

                LstViewCallouts.Visible = False
                LstViewSecondary.Visible = False

                '6/26/01 drh Added all code through end of this Case
                'for component positioning when switching between
                'Family Services and other Call Type tabs
                'Make Pending and Incompletes visible
                Panel1.Visible = True
                Me.LstViewPendingPage.Visible = True
                Me.LstViewIncompletes.Visible = True
                Me.LstViewSecondaryAlert.Visible = False

                'Adjust SSTab position and size
                Call switchFSCallType()

                'Adjust Callouts position and size
                LstViewCallouts.Height = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(TabCallType.Height) - 470)
                LstViewSecondary.Height = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(TabCallType.Height) - 470)

                'Move command buttons
                Me.CmdRefresh.Top = TabCallType.Top
                Me.CmdNewCall.Top = TabCallType.Top
                Me.CmdClearFilters.Top = TabCallType.Top
                Me.CmdLineCheck.Top = TabCallType.Top

            Case TabCallTypeTable(DASHBOARD_TAB_RECYCLE).Name ' Added 5/25/05 - SAP
                'Referral Input params
                txtCallNumberRecycle.TabStop = True
                txtToDateRecycle.TabStop = True
                txtFromDateRecycle.TabStop = True
                txtLocationRecycle.TabStop = True
                txtStateRecycle.TabStop = True
                txtPatientFirstRecycle.TabStop = True
                txtPatientLastRecycle.TabStop = True
                txtReferralTypeRecycle.TabStop = True
                txtRefSourceRecycle.TabStop = True
                LstViewOpenRecycle.TabStop = True
                'Added for v. 8.0, 5/25/05 - SAP
                txtPreRefTypeRecycle.TabStop = True
                txtTcNameRecycle.TabStop = True
                'Message input params
                txtCallNumberMsgRecycle.TabStop = True
                txtFromDateMsgRecycle.TabStop = True
                txtToDateMsgRecycle.TabStop = True
                txtForPersonFirstRecycle.TabStop = True
                txtForPersonLastRecycle.TabStop = True
                txtLocationMsgRecycle.TabStop = True
                txtStateMsgRecycle.TabStop = True
                txtMessageTypeRecycle.TabStop = True
                txtMsgSourceRecycle.TabStop = True
                txtMsgFromRecycle.TabStop = True
                'txtMsgTxRecycle.TabStop = True

                CmdDeleteRef.Visible = False

                Label(0).Visible = False
                LblCountRef.Visible = False

                'Show restore button
                CmdRestoreReferral.Visible = True
                cmdRestoreMessage.Visible = True

                CmdDeleteMsg.Visible = False
                Label(1).Visible = False
                LblCountMsg.Visible = False

                CmdDeleteNC.Visible = False
                Label(2).Visible = False
                LblCountNoCall.Visible = False

                Label(3).Visible = False
                LblCountConsent.Visible = False

                LstViewCallouts.Visible = False
                LstViewSecondary.Visible = False

                '6/26/01 drh Added all code through end of this Case
                'for component positioning when switching between
                'Family Services and other Call Type tabs
                'Make Pending and Incompletes visible
                Panel1.Visible = True
                Me.LstViewPendingPage.Visible = True
                Me.LstViewIncompletes.Visible = True
                Me.LstViewSecondaryAlert.Visible = False

                'Adjust SSTab position and size
                Call switchFSCallType()

                'Adjust Callouts position and size
                LstViewCallouts.Height = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(TabCallType.Height) - 470)
                LstViewSecondary.Height = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(TabCallType.Height) - 470)

                'Move command buttons
                Me.CmdRefresh.Top = TabCallType.Top
                Me.CmdNewCall.Top = TabCallType.Top
                Me.CmdClearFilters.Top = TabCallType.Top
                Me.CmdLineCheck.Top = TabCallType.Top
        End Select

    End Sub

    Private Sub TxtToDateRef_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles TxtToDateRef.Validating
        Dim Cancel As Boolean = eventArgs.Cancel
        'Bret 05/29/07 8.4.3.3.4 prevent user from not setting year
        If Len(TxtToDateRef.Text) < 8 Then
            Call MsgBox("Invalid Date.", MsgBoxStyle.Exclamation, "Validation Error")
            Cancel = True
        End If
        eventArgs.Cancel = Cancel
    End Sub

    Private Sub txtToDateUpdate_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles txtToDateUpdate.Validating
        Dim Cancel As Boolean = eventArgs.Cancel
        'Bret 05/29/07 8.4.3.3.4 prevent user from not setting year
        If Len(txtToDateUpdate.Text) < 8 Then
            Call MsgBox("Invalid Date.", MsgBoxStyle.Exclamation, "Validation Error")
            Cancel = True
        End If

        eventArgs.Cancel = Cancel
    End Sub

    Private Sub TxtToTimeRef_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtToTimeRef.Enter

        Call modControl.HighlightText(ActiveControl)


    End Sub


    Private Sub TxtToTimeRef_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtToTimeRef.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        If TxtToTimeRef.SelectedText <> "" Then
            TxtToTimeRef.Text = ""
        End If
        KeyAscii = modMask.MilitaryTimeMask(KeyAscii, ActiveControl)


        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtType_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtType.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtType_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtType.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtCallNumberUpdate_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtCallNumberUpdate.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3

    End Sub

    Private Sub TxtCallNumberUpdate_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtCallNumberUpdate.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtCallNumberUpdate_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles txtCallNumberUpdate.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtFromDateUpdate_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtFromDateUpdate.Enter

        CurrentDate = txtFromDateUpdate.Text

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtFromDateUpdate_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles txtFromDateUpdate.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)
        If txtFromDateUpdate.SelectedText <> "" Then
            txtFromDateUpdate.Text = ""
        End If
        KeyAscii = modMask.DateMask(KeyAscii, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtFromDateUpdate_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtFromDateUpdate.Leave

        On Error Resume Next

        'leave as ActiveControl 
        If (ActiveControl.Parent.Name <> TabCallType.TabPages.Item(DASHBOARD_TAB_UPDATES).Name) Then
            If Not IsDate(txtFromDateUpdate.Text) Then
                CmdClearFilters_Click(txtFromDateUpdate, New EventArgs)

            End If
            Exit Sub
        End If


        If CurrentDate <> txtFromDateUpdate.Text Then
            If Not IsDate(txtFromDateUpdate.Text) And txtFromDateUpdate.Text <> "" Then
                Call MsgBox("Invalid Date.", MsgBoxStyle.Exclamation, "Validation Error")
                txtFromDateUpdate.Focus()
                'Bret 05/29/07 8.4.3.3.4 prevent user from not setting year
            ElseIf Len(txtFromDateUpdate.Text) < 8 Then
                Call MsgBox("Invalid Date.", MsgBoxStyle.Exclamation, "Validation Error")
                TabCallType.SelectedIndex = DASHBOARD_TAB_UPDATES
                txtFromDateUpdate.Focus()
            ElseIf txtFromDateUpdate.Text = "" Then
                Call MsgBox("Date can not be blank.", MsgBoxStyle.Exclamation, "Validation Error")
                txtFromDateUpdate.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Day, -5, Now), "mm/dd/yy")
                txtFromDateUpdate.Focus()
            End If
        End If

    End Sub

    Private Sub TxtFromTimeUpdate_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtFromTimeUpdate.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub

    Private Sub TxtFromTimeUpdate_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles txtFromTimeUpdate.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        If txtFromTimeUpdate.SelectedText <> "" Then
            txtFromTimeUpdate.Text = ""
        End If
        KeyAscii = modMask.MilitaryTimeMask(KeyAscii, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtToTimeUpdate_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles txtToTimeUpdate.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        If txtToTimeUpdate.SelectedText <> "" Then
            txtToTimeUpdate.Text = ""
        End If
        KeyAscii = modMask.MilitaryTimeMask(KeyAscii, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtToDateUpdate_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtToDateUpdate.Enter

        CurrentDate = txtToDateUpdate.Text

        Call modControl.HighlightText(ActiveControl)

    End Sub

    Private Sub TxtToDateUpdate_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles txtToDateUpdate.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)
        If txtToDateUpdate.SelectedText <> "" Then
            txtToDateUpdate.Text = ""
        End If
        KeyAscii = modMask.DateMask(KeyAscii, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtToDateUpdate_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtToDateUpdate.Leave

        On Error Resume Next

        'leave as ActiveControl 
        If (ActiveControl.Parent.Name <> TabCallType.TabPages.Item(DASHBOARD_TAB_UPDATES).Name) Then
            If Not IsDate(txtToDateUpdate.Text) Then
                CmdClearFilters_Click(txtToDateUpdate, New EventArgs)

            End If
            Exit Sub
        End If


        If CurrentDate <> txtToDateUpdate.Text Then
            If Not IsDate(txtToDateUpdate.Text) And txtToDateUpdate.Text <> "" Then
                Call MsgBox("Invalid Date.", MsgBoxStyle.Exclamation, "Validation Error")
                txtToDateUpdate.Focus()
                'Bret 05/29/07 8.4.3.3.4 prevent user from not setting year
            ElseIf Len(txtToDateUpdate.Text) < 8 Then
                Call MsgBox("Invalid Date.", MsgBoxStyle.Exclamation, "Validation Error")
                TabCallType.SelectedIndex = DASHBOARD_TAB_UPDATES
                txtToDateUpdate.Focus()
            ElseIf TxtToDateRef.Text = "" Then
                Call MsgBox("Date can not be blank.", MsgBoxStyle.Exclamation, "Validation Error")
                txtToDateUpdate.Text = VB6.Format(Now, "mm/dd/yy")
                txtToDateUpdate.Focus()
            End If
        End If

    End Sub

    Private Sub TxtPatientFirstUpdate_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtPatientFirstUpdate.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3

    End Sub

    Private Sub TxtPatientFirstUpdate_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtPatientFirstUpdate.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub

    Private Sub TxtPatientFirstUpdate_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles txtPatientFirstUpdate.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtPatientLastUpdate_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtPatientLastUpdate.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3


    End Sub

    Private Sub TxtPatientLastUpdate_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles txtPatientLastUpdate.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtLocationUpdate_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtLocationUpdate.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3

    End Sub

    Private Sub TxtLocationUpdate_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtLocationUpdate.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtLocationUpdate_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles txtLocationUpdate.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtStateUpdate_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtStateUpdate.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3


    End Sub

    Private Sub TxtStateUpdate_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtStateUpdate.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtStateUpdate_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles txtStateUpdate.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub txtPreRefTypeUpdate_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtPreRefTypeUpdate.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3


    End Sub

    Private Sub txtPreRefTypeUpdate_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtPreRefTypeUpdate.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub

    Private Sub txtPreRefTypeUpdate_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles txtPreRefTypeUpdate.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtReferralTypeUpdate_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtReferralTypeUpdate.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3


    End Sub

    Private Sub TxtReferralTypeUpdate_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtReferralTypeUpdate.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtReferralTypeUpdate_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles txtReferralTypeUpdate.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtRefSourceUpdate_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtRefSourceUpdate.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3


    End Sub

    Private Sub TxtRefSourceUpdate_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtRefSourceUpdate.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtRefSourceUpdate_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles txtRefSourceUpdate.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub txtTcNameUpdate_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtTcNameUpdate.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3


    End Sub

    Private Sub txtTcNameUpdate_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtTcNameUpdate.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub

    Private Sub txtTcNameUpdate_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles txtTcNameUpdate.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub LstViewOpenUpdate_ColumnClick(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.ColumnClickEventArgs) Handles LstViewOpenUpdate.ColumnClick
        Dim ColumnHeader As System.Windows.Forms.ColumnHeader = LstViewOpenUpdate.Columns(eventArgs.Column)

        ' When a ColumnHeader object is clicked, the ListView control is
        ' sorted by the subitems of that column.
        ' Set the SortKey to the Index of the ColumnHeader - 1
        LstViewOpenUpdate.Sorting = ReferralSortOrder
        LstViewOpenUpdate.ListViewItemSorter = New ListViewItemComparer(eventArgs.Column, Me.ReferralSortOrder)

        If ReferralSortOrder = System.Windows.Forms.SortOrder.Ascending Then
            ReferralSortOrder = System.Windows.Forms.SortOrder.Descending
        Else
            ReferralSortOrder = System.Windows.Forms.SortOrder.Ascending
        End If

    End Sub


    Private Sub LstViewOpenUpdate_DoubleClick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewOpenUpdate.DoubleClick

        On Error Resume Next

        If LstViewOpenUpdate.Items.Count = 0 Then
            Exit Sub
        End If

        Call modUtility.Work()

        'Get the call ID
        Me.CallId = modConv.TextToLng(LstViewOpenUpdate.FocusedItem.Tag)

        If Not modUtility.ChkOpenForm("FrmReferral") Then
            Call modUtility.Work()
            AppMain.frmReferral = New FrmReferral()
            AppMain.frmReferral.FormState = EXISTING_RECORD
            AppMain.frmReferral.CallId = Me.CallId
            AppMain.frmReferral.AllowQA = True
            AppMain.frmReferral.Show()
            AppMain.frmReferral.TabDonor.SelectedIndex = 0
            Call modUtility.Done()
        End If

        Call modUtility.Done()

    End Sub

    Private Sub LstViewOpenUpdate_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewOpenUpdate.Enter

        CmdDeleteRef.Enabled = True

    End Sub

    Private Sub TxtCallNumberRecycle_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtCallNumberRecycle.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3

    End Sub

    Private Sub TxtCallNumberRecycle_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtCallNumberRecycle.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtCallNumberRecycle_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles txtCallNumberRecycle.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtFromDateRecycle_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtFromDateRecycle.Enter

        CurrentDate = txtFromDateRecycle.Text

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtFromDateRecycle_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles txtFromDateRecycle.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)
        If txtFromDateRecycle.SelectedText <> "" Then
            txtFromDateRecycle.Text = ""
        End If
        KeyAscii = modMask.DateMask(KeyAscii, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtFromDateRecycle_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtFromDateRecycle.Leave

        On Error Resume Next

        'leave as ActiveControl 
        If (ActiveControl.Parent.Name <> TabCallType.TabPages.Item(DASHBOARD_TAB_RECYCLE).Name) Then
            If Not IsDate(txtFromDateRecycle.Text) Then
                CmdClearFilters_Click(txtFromDateRecycle, New EventArgs)

            End If
            Exit Sub
        End If

        If CurrentDate <> txtFromDateRecycle.Text Then
            If Not IsDate(txtFromDateRecycle.Text) And txtFromDateRecycle.Text <> "" Then
                Call MsgBox("Invalid Date.", MsgBoxStyle.Exclamation, "Validation Error")
                txtFromDateRecycle.Focus()
                'Bret 05/29/07 8.4.3.3.4 prevent user from not setting year
            ElseIf Len(txtFromDateRecycle.Text) < 8 Then
                Call MsgBox("Invalid Date.", MsgBoxStyle.Exclamation, "Validation Error")
                TabCallType.SelectedIndex = DASHBOARD_TAB_RECYCLE
                txtFromDateRecycle.Focus()
            ElseIf txtFromDateRecycle.Text = "" Then
                Call MsgBox("Date can not be blank.", MsgBoxStyle.Exclamation, "Validation Error")
                txtFromDateRecycle.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Day, -5, Now), "mm/dd/yy")
                txtFromDateRecycle.Focus()
            End If
        End If

    End Sub

    Private Sub TxtFromTimeRecycle_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtFromTimeRecycle.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub

    Private Sub TxtFromTimeRecycle_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles txtFromTimeRecycle.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        If txtFromTimeRecycle.SelectedText <> "" Then
            txtFromTimeRecycle.Text = ""
        End If
        KeyAscii = modMask.MilitaryTimeMask(KeyAscii, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtToDateRecycle_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtToDateRecycle.Enter

        CurrentDate = txtToDateRecycle.Text

        Call modControl.HighlightText(ActiveControl)

    End Sub

    Private Sub TxtToDateRecycle_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles txtToDateRecycle.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)
        If txtToDateRecycle.SelectedText <> "" Then
            txtToDateRecycle.Text = ""
        End If
        KeyAscii = modMask.DateMask(KeyAscii, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtToDateRecycle_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtToDateRecycle.Leave

        On Error Resume Next

        'leave as ActiveControl 
        If (ActiveControl.Parent.Name <> TabCallType.TabPages.Item(DASHBOARD_TAB_RECYCLE).Name) Then
            If Not IsDate(txtToDateRecycle.Text) Then
                CmdClearFilters_Click(txtToDateRecycle, New EventArgs)

            End If
            Exit Sub
        End If

        If CurrentDate <> txtToDateRecycle.Text Then
            If Not IsDate(txtToDateRecycle.Text) And txtToDateRecycle.Text <> "" Then
                Call MsgBox("Invalid Date.", MsgBoxStyle.Exclamation, "Validation Error")
                txtToDateRecycle.Focus()
                'Bret 05/29/07 8.4.3.3.4 prevent user from not setting year
            ElseIf Len(txtToDateRecycle.Text) < 8 Then
                Call MsgBox("Invalid Date.", MsgBoxStyle.Exclamation, "Validation Error")
                TabCallType.SelectedIndex = DASHBOARD_TAB_RECYCLE
                txtToDateRecycle.Focus()
            ElseIf TxtToDateRef.Text = "" Then
                Call MsgBox("Date can not be blank.", MsgBoxStyle.Exclamation, "Validation Error")
                txtToDateRecycle.Text = VB6.Format(Now, "mm/dd/yy")
                txtToDateRecycle.Focus()
            End If
        End If

    End Sub

    Private Sub TxtPatientFirstRecycle_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtPatientFirstRecycle.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3
    End Sub

    Private Sub TxtPatientFirstRecycle_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtPatientFirstRecycle.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub

    Private Sub TxtPatientFirstRecycle_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles txtPatientFirstRecycle.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtPatientLastRecycle_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtPatientLastRecycle.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3

    End Sub

    Private Sub TxtPatientLastRecycle_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles txtPatientLastRecycle.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtLocationRecycle_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtLocationRecycle.TextChanged

        '05/25/07 Bret removed db search 8.3.3.2.3

    End Sub

    Private Sub TxtLocationRecycle_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtLocationRecycle.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtLocationRecycle_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles txtLocationRecycle.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtStateRecycle_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtStateRecycle.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3

    End Sub

    Private Sub TxtStateRecycle_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtStateRecycle.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtStateRecycle_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles txtStateRecycle.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub txtPreRefTypeRecycle_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtPreRefTypeRecycle.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3

    End Sub

    Private Sub txtPreRefTypeRecycle_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtPreRefTypeRecycle.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub

    Private Sub txtPreRefTypeRecycle_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles txtPreRefTypeRecycle.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtReferralTypeRecycle_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtReferralTypeRecycle.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3

    End Sub

    Private Sub TxtReferralTypeRecycle_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtReferralTypeRecycle.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtReferralTypeRecycle_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles txtReferralTypeRecycle.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtRefSourceRecycle_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtRefSourceRecycle.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3

    End Sub

    Private Sub TxtRefSourceRecycle_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtRefSourceRecycle.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtRefSourceRecycle_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles txtRefSourceRecycle.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub txtTcNameRecycle_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtTcNameRecycle.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3

    End Sub

    Private Sub txtTcNameRecycle_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtTcNameRecycle.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub

    Private Sub txtTcNameRecycle_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles txtTcNameRecycle.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub LstViewOpenRecycle_ColumnClick(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.ColumnClickEventArgs) Handles LstViewOpenRecycle.ColumnClick
        Dim ColumnHeader As System.Windows.Forms.ColumnHeader = LstViewOpenRecycle.Columns(eventArgs.Column)

        ' When a ColumnHeader object is clicked, the ListView control is
        ' sorted by the subitems of that column.
        ' Set the SortKey to the Index of the ColumnHeader - 1
        LstViewOpenRecycle.Sorting = ReferralSortOrder
        LstViewOpenRecycle.ListViewItemSorter = New ListViewItemComparer(eventArgs.Column, Me.ReferralSortOrder)

        If ReferralSortOrder = System.Windows.Forms.SortOrder.Ascending Then
            ReferralSortOrder = System.Windows.Forms.SortOrder.Descending
        Else
            ReferralSortOrder = System.Windows.Forms.SortOrder.Ascending
        End If

    End Sub

    Private Sub LstViewOpenRecycle_DoubleClick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewOpenRecycle.DoubleClick

        On Error Resume Next

        If LstViewOpenRecycle.Items.Count = 0 Then
            Exit Sub
        End If

        MsgBox("You cannot open a referral directly from the Recycle tab.  You must first restore it.")

    End Sub

    Private Sub LstViewOpenRecycle_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewOpenRecycle.Enter

        CmdRestoreReferral.Enabled = True
        cmdRestoreMessage.Enabled = False

    End Sub

    Private Sub LstViewOpenMsgRecycle_ColumnClick(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.ColumnClickEventArgs) Handles LstViewOpenMsgRecycle.ColumnClick
        Dim ColumnHeader As System.Windows.Forms.ColumnHeader = LstViewOpenMsgRecycle.Columns(eventArgs.Column)

        ' When a ColumnHeader object is clicked, the ListView control is
        ' sorted by the subitems of that column.
        ' Set the SortKey to the Index of the ColumnHeader - 1
        LstViewOpenMsgRecycle.Sorting = ReferralSortOrder
        LstViewOpenMsgRecycle.ListViewItemSorter = New ListViewItemComparer(eventArgs.Column, Me.ReferralSortOrder)

        If ReferralSortOrder = System.Windows.Forms.SortOrder.Ascending Then
            ReferralSortOrder = System.Windows.Forms.SortOrder.Descending
        Else
            ReferralSortOrder = System.Windows.Forms.SortOrder.Ascending
        End If

    End Sub

    Private Sub LstViewOpenMsgRecycle_DoubleClick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewOpenMsgRecycle.DoubleClick

        On Error Resume Next

        If LstViewOpenMsgRecycle.Items.Count = 0 Then
            Exit Sub
        End If

        MsgBox("You cannot open a message directly from the Recycle tab.  You must first restore it.")

    End Sub

    Private Sub LstViewOpenMsgRecycle_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewOpenMsgRecycle.Enter

        cmdRestoreMessage.Enabled = True
        CmdRestoreReferral.Enabled = False

    End Sub

    Private Sub TxtCallNumberMsgRecycle_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtCallNumberMsgRecycle.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3

    End Sub

    Private Sub TxtCallNumberMsgRecycle_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtCallNumberMsgRecycle.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub

    Private Sub TxtCallNumberMsgRecycle_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles txtCallNumberMsgRecycle.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtFromDateMsgRecycle_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtFromDateMsgRecycle.Enter

        CurrentDate = txtFromDateMsgRecycle.Text

        Call modControl.HighlightText(ActiveControl)

    End Sub

    Private Sub TxtFromDateMsgRecycle_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles txtFromDateMsgRecycle.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)
        If txtFromDateMsgRecycle.SelectedText <> "" Then
            txtFromDateMsgRecycle.Text = ""
        End If

        KeyAscii = modMask.DateMask(KeyAscii, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtFromDateMsgRecycle_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtFromDateMsgRecycle.Leave

        On Error Resume Next

        'leave as ActiveControl 
        If (ActiveControl.Parent.Name <> TabCallType.TabPages.Item(DASHBOARD_TAB_RECYCLE).Name) Then
            If Not IsDate(txtFromDateMsgRecycle.Text) Then
                CmdClearFilters_Click(txtFromDateMsgRecycle, New EventArgs)

            End If
            Exit Sub
        End If

        If CurrentDate <> txtFromDateMsgRecycle.Text Then
            If Not IsDate(txtFromDateMsgRecycle.Text) And txtFromDateMsgRecycle.Text <> "" Then
                Call MsgBox("Invalid Date.", MsgBoxStyle.Exclamation, "Validation Error")
                txtFromDateMsgRecycle.Focus()
                'Bret 05/29/07 8.4.3.3.4 prevent user from not setting year
            ElseIf Len(txtFromDateMsgRecycle.Text) < 8 Then
                Call MsgBox("Invalid Date.", MsgBoxStyle.Exclamation, "Validation Error")
                TabCallType.SelectedIndex = DASHBOARD_TAB_RECYCLE
                txtFromDateMsgRecycle.Focus()
            ElseIf txtFromDateMsgRecycle.Text = "" Then
                Call MsgBox("Date can not be blank.", MsgBoxStyle.Exclamation, "Validation Error")
                txtFromDateMsgRecycle.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Day, -5, Now), "mm/dd/yy")
                txtFromDateMsgRecycle.Focus()
            End If
        End If

    End Sub

    Private Sub TxtToDateMsgRecycle_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtToDateMsgRecycle.Enter

        CurrentDate = txtToDateMsgRecycle.Text

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtToDateMsgRecycle_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles txtToDateMsgRecycle.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)
        If txtToDateMsgRecycle.SelectedText <> "" Then
            txtToDateMsgRecycle.Text = ""
        End If

        KeyAscii = modMask.DateMask(KeyAscii, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtToDateMsgRecycle_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtToDateMsgRecycle.Leave

        On Error Resume Next

        'leave as ActiveControl 
        If (ActiveControl.Parent.Name <> TabCallType.TabPages.Item(DASHBOARD_TAB_MESSAGES).Name) Then
            If Not IsDate(txtToDateMsgRecycle.Text) Then
                CmdClearFilters_Click(txtToDateMsgRecycle, New EventArgs)

            End If
            Exit Sub
        End If

        If CurrentDate <> txtToDateMsgRecycle.Text Then
            If Not IsDate(txtToDateMsgRecycle.Text) And txtToDateMsgRecycle.Text <> "" Then
                Call MsgBox("Invalid Date.", MsgBoxStyle.Exclamation, "Validation Error")
                txtToDateMsgRecycle.Focus()
                'Bret 05/29/07 8.4.3.3.4 prevent user from not setting year
            ElseIf Len(txtToDateMsgRecycle.Text) < 8 Then
                Call MsgBox("Invalid Date.", MsgBoxStyle.Exclamation, "Validation Error")
                TabCallType.SelectedIndex = DASHBOARD_TAB_RECYCLE
                txtToDateMsgRecycle.Focus()
            ElseIf txtToDateMsgRecycle.Text = "" Then
                Call MsgBox("Date can not be blank.", MsgBoxStyle.Exclamation, "Validation Error")
                txtToDateMsgRecycle.Text = VB6.Format(Now, "mm/dd/yy")
                txtToDateMsgRecycle.Focus()
            End If
        End If

    End Sub


    Private Sub TxtDescriptionRecycle_KeyPress(ByRef KeyAscii As Short)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

    End Sub

    Private Sub TxtForPersonFirstRecycle_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtForPersonFirstRecycle.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3

    End Sub

    Private Sub TxtForPersonFirstRecycle_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtForPersonFirstRecycle.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtForPersonFirstRecycle_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles txtForPersonFirstRecycle.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtForPersonLastRecycle_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtForPersonLastRecycle.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3

    End Sub


    Private Sub TxtForPersonLastRecycle_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtForPersonLastRecycle.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtForPersonLastRecycle_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles txtForPersonLastRecycle.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtLocationMsgRecycle_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtLocationMsgRecycle.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3

    End Sub

    Private Sub TxtLocationMsgRecycle_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtLocationMsgRecycle.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtLocationMsgRecycle_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles txtLocationMsgRecycle.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtStateMsgRecycle_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtStateMsgRecycle.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3

    End Sub

    Private Sub TxtStateMsgRecycle_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtStateMsgRecycle.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub

    Private Sub TxtStateMsgRecycle_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles txtStateMsgRecycle.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtMessageTypeRecycle_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtMessageTypeRecycle.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3

    End Sub

    Private Sub TxtMessageTypeRecycle_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtMessageTypeRecycle.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub

    Private Sub TxtMessageTypeRecycle_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles txtMessageTypeRecycle.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtMsgSourceRecycle_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtMsgSourceRecycle.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3

    End Sub

    Private Sub TxtMsgSourceRecycle_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtMsgSourceRecycle.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub

    Private Sub TxtMsgSourceRecycle_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles txtMsgSourceRecycle.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtMsgFromRecycle_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtMsgFromRecycle.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3

    End Sub

    Private Sub TxtMsgFromRecycle_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtMsgFromRecycle.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub

    Private Sub TxtMsgFromRecycle_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles txtMsgFromRecycle.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        On Error Resume Next

        KeyAscii = Asc(UCase(Chr(KeyAscii)))

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtMsgTxRecycle_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtMsgTxRecycle.TextChanged
        '05/25/07 Bret removed db search 8.3.3.2.3

    End Sub

    Private Function CheckSearchParameters() As Boolean
        '************************************************************************************
        'Name: CheckSearchParameters
        'Date Created: 6/15/07                          Created by: Bret Knoll
        'Release: 8.4                               Task: 8.4.3.3
        'Description: Checks the parameters of the current tab and limits the date range
        'Returns: true or false
        'Stored Procedures: N/A
        '====================================================================================
        '***********************************************************************************

        Dim fromDateCancel As Boolean
        Dim toDateCancel As Boolean
        Dim allParameterLength As Short
        Dim totalDaysAllowed As Short

        Const MAX_SEARCH_DAYS As Short = 90 'sets the maximum days a query can search
        Const CALL_NUMBER_POWER As Double = 1.5 ' Call number has more power than other params, set the power here
        Const DAY_MULTIPLIER As Short = 7 'set the default number of days to multiply the params against
        Const CALLID_LENGTH As Short = 8 'sets the number of callid values required to search entire record set
        '--> Changed CALLID_LENGTH FROM 6 TO 8 so users can only search 90 days

        'initialize allParameterLength  to 1 to allow 7 days search
        allParameterLength = 1

        CheckSearchParameters = False
        AppMain.ParentForm.StatusBar.Items(2).Text = ""

        'Get the other lists depending on which list is displayed
        ' for each tab determine the total length of all parameters used
        ' for each item allow 7 days on the search screen
        ' allow a maximum of 90 days
        Select Case TabCallType.SelectedIndex
            Case DASHBOARD_TAB_REFERRAL
                'set the label to empty

                'TxtCallNumberRef
                'TxtPatientFirstRef
                'TxtPatientLastRef
                'TxtLocationRef
                'TxtStateRef
                'txtPreRefType
                'TxtReferralType
                'TxtRefSource
                'txtTcNameRef
                TxtFromDateRef.BackColor = System.Drawing.ColorTranslator.FromOle(&H80000005)
                TxtToDateRef.BackColor = System.Drawing.ColorTranslator.FromOle(&H80000005)
                If Len(TxtCallNumberRef.Text) = 7 And InStr(1, TxtCallNumberRef.Text, "-") = 0 Then
                    CheckSearchParameters = True
                    Exit Function
                End If
                If Len(TxtCallNumberRef.Text) < CALLID_LENGTH Then
                    '3 = 3 times give call number 3 times the power, allowing for 3 weeks for every character
                    allParameterLength = allParameterLength + (Len(TxtCallNumberRef.Text) * CALL_NUMBER_POWER) + Len(TxtPatientFirstRef.Text) + Len(TxtPatientLastRef.Text) + Len(TxtLocationRef.Text) + Len(TxtStateRef.Text) + Len(txtPreRefType.Text) + Len(TxtReferralType.Text) + Len(TxtRefSource.Text) + Len(txtTcNameRef.Text)

                    'calculate totalDaysAllowed by multyuplyihg the length in parameters by 7
                    totalDaysAllowed = allParameterLength * DAY_MULTIPLIER

                    'only allow totalDaysAllowed to be a maximum of 90 days
                    totalDaysAllowed = IIf(totalDaysAllowed > MAX_SEARCH_DAYS, MAX_SEARCH_DAYS, totalDaysAllowed)

                    'compare totalDaysAllowed against to and from Dates
                    If (DateDiff(Microsoft.VisualBasic.DateInterval.Day, CDate(TxtFromDateRef.Text), CDate(TxtToDateRef.Text)) > totalDaysAllowed) Then
                        AppMain.ParentForm.StatusBar.Items(2).Text = "Date Range Violation! Maximum: " & totalDaysAllowed & " Days"
                        Call modControl.ClearListView((Me.LstViewOpenReferral))
                        TxtFromDateRef.BackColor = System.Drawing.Color.Red
                        TxtToDateRef.BackColor = System.Drawing.Color.Red
                        Return False
                    End If
                End If
                CheckSearchParameters = True
                Exit Function
                'lblCheckSearchParameters.Top
            Case DASHBOARD_TAB_MESSAGES

                TxtFromDateMsg.BackColor = System.Drawing.ColorTranslator.FromOle(&H80000005)
                TxtToDateMsg.BackColor = System.Drawing.ColorTranslator.FromOle(&H80000005)

                If Len(TxtCallNumberMsg.Text) < CALLID_LENGTH Then
                    allParameterLength = allParameterLength + (Len(TxtCallNumberMsg.Text) * CALL_NUMBER_POWER) + Len(TxtForPersonFirst.Text) + Len(TxtForPersonLast.Text) + Len(TxtLocationMsg.Text) + Len(TxtStateMsg.Text) + Len(TxtMessageType.Text) + Len(TxtMsgSource.Text) + Len(TxtMsgFrom.Text) + Len(TxtMsgTx.Text)

                    'calculate totalDaysAllowed by multyuplyihg the length in parameters by 7
                    totalDaysAllowed = allParameterLength * DAY_MULTIPLIER

                    'only allow totalDaysAllowed to be a maximum of 90 days
                    totalDaysAllowed = IIf(totalDaysAllowed > MAX_SEARCH_DAYS, MAX_SEARCH_DAYS, totalDaysAllowed)

                    'compare totalDaysAllowed against to and from Dates
                    If (DateDiff(Microsoft.VisualBasic.DateInterval.Day, CDate(TxtFromDateMsg.Text), CDate(TxtToDateMsg.Text)) > totalDaysAllowed) Then
                        AppMain.ParentForm.StatusBar.Items(2).Text = "Date Range Violation! Maximum: " & totalDaysAllowed & " Days"
                        Call modControl.ClearListView((Me.LstViewOpenMessage))
                        TxtFromDateMsg.BackColor = System.Drawing.Color.Red
                        TxtToDateMsg.BackColor = System.Drawing.Color.Red
                        Return False
                    End If
                End If
                CheckSearchParameters = True
                Exit Function
            Case DASHBOARD_TAB_FAMILY_SERVICES
                CheckSearchParameters = True
                Exit Function
            Case DASHBOARD_TAB_NO_CALLS

                CheckSearchParameters = True
                Exit Function
            Case DASHBOARD_TAB_CONSENTS_PENDING
                CheckSearchParameters = True
                Exit Function
            Case DASHBOARD_TAB_INFO
                CheckSearchParameters = True
                Exit Function
            Case DASHBOARD_TAB_UPDATES
                txtFromDateUpdate.BackColor = System.Drawing.ColorTranslator.FromOle(&H80000005)
                txtToDateUpdate.BackColor = System.Drawing.ColorTranslator.FromOle(&H80000005)

                If Len(txtCallNumberUpdate.Text) < CALLID_LENGTH Then
                    '3 = 3 times give call number 3 times the power, allowing for 3 weeks for every character
                    allParameterLength = allParameterLength + (Len(txtCallNumberUpdate.Text) * CALL_NUMBER_POWER) + Len(txtPatientFirstUpdate.Text) + Len(txtPatientLastUpdate.Text) + Len(txtLocationUpdate.Text) + Len(txtStateUpdate.Text) + Len(txtPreRefTypeUpdate.Text) + Len(txtReferralTypeUpdate.Text) + Len(txtRefSourceUpdate.Text) + Len(txtTcNameUpdate.Text)

                    'calculate totalDaysAllowed by multyuplyihg the length in parameters by 7
                    totalDaysAllowed = allParameterLength * DAY_MULTIPLIER

                    'only allow totalDaysAllowed to be a maximum of 90 days
                    totalDaysAllowed = IIf(totalDaysAllowed > MAX_SEARCH_DAYS, MAX_SEARCH_DAYS, totalDaysAllowed)

                    'compare totalDaysAllowed against to and from Dates
                    If (DateDiff(Microsoft.VisualBasic.DateInterval.Day, CDate(txtFromDateUpdate.Text), CDate(txtToDateUpdate.Text)) > totalDaysAllowed) Then
                        AppMain.ParentForm.StatusBar.Items(2).Text = "Date Range Violation! Maximum: " & totalDaysAllowed & " Days"
                        Call modControl.ClearListView((Me.LstViewOpenReferral))
                        txtFromDateUpdate.BackColor = System.Drawing.Color.Red
                        txtToDateUpdate.BackColor = System.Drawing.Color.Red
                        Return False
                    End If
                End If
                CheckSearchParameters = True
                Exit Function

            Case DASHBOARD_TAB_RECYCLE

                CheckSearchParameters = True
                Exit Function
        End Select
        'Return
    End Function



    Private Sub LstViewIncompletes_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles LstViewIncompletes.SelectedIndexChanged

    End Sub
End Class
