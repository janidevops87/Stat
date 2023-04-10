Option Strict Off
Option Explicit On
Imports VB = Microsoft.VisualBasic
Friend Class MDIFormStatLine
    Inherits System.Windows.Forms.Form

    'Const
    'bret 01/07/10 added for new toolbar button
    Const OPENDASHBOARDBUTTON As Short = 6

    'Variables
    Public StatEmployeeID As Integer
    Public StatEmployeeName As String
    Public CallId As Integer
    Public WebUserOrg As Integer
    Public WebPersonID As Integer
    Public StatEmployeeEmail As String
    Public PersonID As Integer
    '7/6/01 drh added PersonTypeId
    Public PersonTypeID As Integer
    'added 06/2001 bjk: Lease Organization
    Public LeaseOrganization As Short
    'added 05/06/2004 T.T Lease Organization Type
    Public LeaseOrganizationType As Object
    '12/12/01 bjk: TimeZone name
    Public TimeZone As String
    '02/21/03 bjk: SystemTimeZone is the time zone of the machine the user is on.
    'SystemTimeZone is used to correctly set the Times for Pacific, Mountain, Central and Eastern
    Public SystemTimeZone As String


    Private Sub MDIFormStatLine_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load

        Call Timer_Renamed_Tick(Timer_Renamed, New System.EventArgs())

        '8/18/03 drh - Added Exit Sub and localError:
        Exit Sub

localError:
        Err.Source = "StatTrac"
        Err.Description = IIf(Err.Number = 429, Err.Description & ": Please verify VPClient.dll is installed and registered.", Err.Description)
        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())

    End Sub

    Private Sub MDIFormStatLine_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing

    End Sub


    Public Sub MnuAbout_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MnuAbout.Click

        AppMain.frmAbout = New FrmAbout() 'FrmAbout(FrmAbout = New FrmAbout())
        AppMain.frmAbout.Display()

    End Sub


    Public Sub MnuAlerts_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MnuAlerts.Click

        AppMain.frmAlert = New FrmAlert()
        AppMain.frmAlert.Display()

    End Sub

    Public Sub MnuCommitClientChanges_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MnuCommitClientChanges.Click
        '11/22/02 drh - Added menu item to run Historical Update Job
        Call modStatSave.CommitClientChanges()
    End Sub


    Public Sub MnuConsentInterval_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MnuConsentInterval.Click

        AppMain.frmConsentInterval = New FrmConsentInterval()

        AppMain.frmConsentInterval.Display()
        'AppMain.frmConsentInterval.Close()
        'AppMain.frmConsentInterval = Nothing

    End Sub

    Public Sub MnuDeleteGeneralAlert_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MnuDeleteGeneralAlert.Click, MnuDeleteGeneralAlert1.Click

        Dim GeneralAlert As clsGeneralAlert
        'Get the selected item  3/10 fixed...method wasn't explicit enough and added test if item selected
        If Not IsNothing(AppMain.frmOpenAll.LstViewGeneralAlert.FocusedItem) Then
            GeneralAlert = AppMain.frmOpenAll.GeneralAlerts.Item(AppMain.frmOpenAll.LstViewGeneralAlert.FocusedItem.Tag)
            'GeneralAlert = AppMain.frmOpenAll.GeneralAlerts.Item(FrmOpenAll.LstViewGeneralAlert.FocusedItem.Tag)
            'Display the selected item
            Call GeneralAlert.Delete()
        End If

        Call AppMain.frmOpenAll.RefreshLists()

    End Sub

    Public Sub MnuDeletePending_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MnuDeletePending.Click

        Dim vCallID As Integer
        Dim vResult As Short

        On Error Resume Next

        Me.CallId = modConv.TextToLng(AppMain.frmOpenAll.LstViewIncompletes.FocusedItem.Tag)

        vResult = MsgBox("You are about to delete a call. This action cannot be undone!!! Are you sure you want to continue?", MsgBoxStyle.YesNo + MsgBoxStyle.DefaultButton2, "Delete Call")

        Select Case vResult
            Case MsgBoxResult.Yes
                vResult = MsgBox("You are *really* sure you want to delete a call. Once it's gone, it's gone. This is your last chance. With this in mind, are you *positive* you want to continue?", MsgBoxStyle.YesNo + MsgBoxStyle.DefaultButton2, "Delete Call")
                If vResult = MsgBoxResult.Yes Then
                    'Delete the call id
                    Call modStatSave.DeleteCall(Me.CallId)
                Else
                    Exit Sub
                End If
            Case MsgBoxResult.No
                Exit Sub
        End Select
        'Refresh Grid moved from frmopenall because it was causing a loss of focus on the row
        'Call modStatQuery.QueryIncompletes(Me)
        'calling this method to be consistent with method above
        Call AppMain.frmOpenAll.RefreshLists()


    End Sub

    Public Sub MnuDonorCriteria_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MnuDonorCriteria.Click

        AppMain.frmCriteria = New FrmCriteria
        AppMain.frmCriteria.DonorCategoryID = 0
        AppMain.frmCriteria.Display()

    End Sub

    Public Sub MnuEditGeneralAlert_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MnuEditGeneralAlert.Click, MnuEditGeneralAlert1.Click
        AppMain.OpenFrmGeneralAlert("RightClick")
    End Sub


    Public Sub MnuEnableBackup_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MnuEnableBackup.Click

        On Error Resume Next

        Dim vResult As Short


        'Call the class method to change the backup database from
        'read-only to read/write
        vResult = SUCCESS

        'Alert user of success
        If vResult = SUCCESS Then
            Call MsgBox("Backup Database Enable Success!" & Chr(10) & Chr(13) & "The backup database is now enabled!", MsgBoxStyle.Information, "SUCCESS")
        Else
            Call MsgBox("Backup Database Enable Failed!!" & Chr(10) & Chr(13) & "The backup database failed to initialize. You may continue to view information, but you may not save any data. Please contact the manager on call immeadiately!", MsgBoxStyle.Critical, "FAIL")
        End If

    End Sub

    Public Sub MnuExit_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MnuExit.Click

        Me.Close()

    End Sub


    Public Sub MnuIndications_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MnuIndications.Click

        AppMain.frmIndicationSelect = New FrmIndicationSelect
        AppMain.frmIndicationSelect.CmdOK.Visible = False
        AppMain.frmIndicationSelect.Text = "Ruleout Indications"

        AppMain.frmIndicationSelect.Display()

    End Sub

    Public Sub MnuKeyCodes_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MnuKeyCodes.Click
        AppMain.frmKeyCodeSelect = New FrmKeyCodeSelect
        AppMain.frmKeyCodeSelect.Display()

    End Sub


    Public Sub MnuLOCalls_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MnuLOCalls.Click
        AppMain.frmLeaseOrganizationCalls = New FrmLeaseOrganizationCalls
        AppMain.frmLeaseOrganizationCalls.Show()
    End Sub

    Public Sub MnuMilitaryCentral_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MnuMilitaryCentral.Click

        If MnuMilitaryCentral.Checked = True Then
            MnuMilitaryCentral.Checked = False
        Else
            MnuMilitaryCentral.Checked = True
        End If

        Call Timer_Renamed_Tick(Timer_Renamed, New System.EventArgs())

    End Sub

    Public Sub MnuMilitaryEastern_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MnuMilitaryEastern.Click

        If MnuMilitaryEastern.Checked = True Then
            MnuMilitaryEastern.Checked = False
        Else
            MnuMilitaryEastern.Checked = True
        End If

        Call Timer_Renamed_Tick(Timer_Renamed, New System.EventArgs())

    End Sub


    Public Sub MnuMilitaryMountain_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MnuMilitaryMountain.Click

        If MnuMilitaryMountain.Checked = True Then
            MnuMilitaryMountain.Checked = False
        Else
            MnuMilitaryMountain.Checked = True
        End If

        Call Timer_Renamed_Tick(Timer_Renamed, New System.EventArgs())

    End Sub

    Public Sub MnuMilitaryPacific_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MnuMilitaryPacific.Click

        If MnuMilitaryPacific.Checked = True Then
            MnuMilitaryPacific.Checked = False
        Else
            MnuMilitaryPacific.Checked = True
        End If

        Call Timer_Renamed_Tick(Timer_Renamed, New System.EventArgs())

    End Sub

    Public Sub MnuMisspellings_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MnuMisspellings.Click
        AppMain.frmDictionaryItemSelect = New FrmDictionaryItemSelect
        AppMain.frmDictionaryItemSelect.Display()

    End Sub

    Public Sub MnuNewCall_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MnuNewCall.Click
        'T.T 05/11/2004 added to disable the save button for family services asp.
        If AppMain.ParentForm.LeaseOrganizationType = "FamilyServices" Then
            Exit Sub
        Else
            Call Toolbar1_ButtonClick(Toolbar1.Items.Item("NewCall"), New System.EventArgs())
        End If
    End Sub





    Public Sub MnuNewGeneralAlert_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MnuNewGeneralAlert.Click, MnuNewGeneralAlert1.Click

        AppMain.frmGeneralAlert = New FrmGeneralAlert
        AppMain.frmGeneralAlert.Display(New clsGeneralAlert())

        Call AppMain.frmOpenAll.RefreshLists()

    End Sub

    Public Sub MnuOnCall_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MnuOnCall.Click

        Call Toolbar1_ButtonClick(Toolbar1.Items.Item("OnCall"), New System.EventArgs())

    End Sub

    Public Sub MnuOnCallSchedule_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MnuOnCallSchedule.Click
        AppMain.frmSchedule = New FrmSchedule()
        AppMain.frmSchedule.OrganizationId = 0
        AppMain.frmSchedule.CurrentDate = Today
        AppMain.frmSchedule.Display()

    End Sub


    Public Sub MnuOpenCall_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MnuOpenCall.Click

        Call Toolbar1_ButtonClick(Toolbar1.Items.Item(1), New System.EventArgs())

    End Sub






    Public Sub MnuOpenOrganization_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MnuOpenOrganization.Click

        Call Toolbar1_ButtonClick(Toolbar1.Items.Item("Organizations"), New System.EventArgs())

    End Sub



    Public Sub MnuProductionDB_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MnuProductionDB.Click
        '************************************************************************************
        'Name: MnuProductionDB_Click
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Menu item click to select Production DB.
        'Returns: Nothing
        'Params: None
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 5/9/05                           Changed by: Scott Plummer
        'Release #: 7.7.34                              Task: 420
        'Description:  Added TRAINING_CONN to function.
        '====================================================================================
        '************************************************************************************

        On Error Resume Next

        Dim I As Short

        'Check to see if the current connection is the production database
        'Production database should be connection # 1
        If AppMain.ConnectionType = TEST_CONN Or AppMain.ConnectionType = TRAINING_CONN Then
            For I = 1 To Application.OpenForms.Count - 1
                Application.OpenForms(I).Hide()
            Next I
            'Close any open forms
            'While Application.OpenForms.Count > 1
            '    Application.OpenForms(Application.OpenForms.Count - 1).Close()
            'End While

            Call Toolbar1_ButtonClick(Toolbar1.Items.Item(OPENDASHBOARDBUTTON), New System.EventArgs())

            'Set the current connection to production
            AppMain.ConnectionType = PROD_CONN

            Call AppMain.Main_Renamed()

        ElseIf AppMain.ConnectionType = PROD_CONN Then

            Call MsgBox("You are already connected to the production database.", 64, "Production Database")

        ElseIf AppMain.ConnectionType = INTERNET Then

            Call MsgBox("You cannot change databases when logged in via the Internet.", 64, "Internet Connection")

        Else

            Call MsgBox("You cannot change databases when logged in the the production backup database.", 64, "Backup Production Database")

        End If

    End Sub




    Public Sub MnuQuickLook_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MnuQuickLook.Click

        Call Toolbar1_ButtonClick(Toolbar1.Items.Item("QuickLookup"), New System.EventArgs())

    End Sub


    Public Sub MnuReportGroups_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MnuReportGroups.Click
        AppMain.frmReport = New FrmReport
        AppMain.frmReport.Display()

    End Sub

    Public Sub mnuRotate_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles mnuRotate.Click
        AppMain.frmRotateOrganization = New FrmRotateOrganization
        AppMain.frmRotateOrganization.Show()
    End Sub

    Public Sub MnuSelectReport_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MnuSelectReport.Click

        'Call Toolbar1_ButtonClick(Toolbar1.Buttons("SelectReport"))

    End Sub



    Public Sub MnuServiceLevels_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MnuServiceLevels.Click
        AppMain.frmServiceLevel = New FrmServiceLevel
        AppMain.frmServiceLevel.Display()

    End Sub

    Public Sub MnuSourceCodes_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MnuSourceCodes.Click
        AppMain.frmSourceCode = New FrmSourceCode
        AppMain.frmSourceCode.Display()

    End Sub

    Public Sub MnuSystemAlerts_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MnuSystemAlerts.Click
        AppMain.frmSystemAlert = New FrmSystemAlert
        AppMain.frmSystemAlert.Display()

    End Sub

    Public Sub MnuTestDB_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MnuTestDB.Click
        '************************************************************************************
        'Name: MnuTestDB_Click
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Menu item click to select Test DB.
        'Returns: Nothing
        'Params: None
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 5/9/05                           Changed by: Scott Plummer
        'Release #: 7.7.34                              Task: 420
        'Description:  Added TRAINING_CONN to function.
        '====================================================================================
        '************************************************************************************

        On Error Resume Next

        Dim I As Short

        'Check if there is already a connection to the test database
        'The connection to the test database should be connection number 2
        If AppMain.ConnectionType = PROD_CONN Or AppMain.ConnectionType = TRAINING_CONN Then

            'Close any open forms
            For I = 1 To Application.OpenForms.Count - 1
                Application.OpenForms(I).Hide()
            Next I

            Call Toolbar1_ButtonClick(Toolbar1.Items.Item(OPENDASHBOARDBUTTON), New System.EventArgs())

            'Set the current connection to test
            AppMain.ConnectionType = TEST_CONN

            Call AppMain.Main_Renamed()

        ElseIf AppMain.ConnectionType = TEST_CONN Then

            Call MsgBox("You are already connected to the test database.", 64, "Test Database")

        ElseIf AppMain.ConnectionType = INTERNET Then

            Call MsgBox("You cannot change databases when logged in via the Internet.", 64, "Internet Connection")

        Else

            Call MsgBox("You cannot change databases when logged in the the production backup database.", 64, "Backup Production Database")

        End If

    End Sub

    Public Sub MnuTrainingDb_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MnuTrainingDb.Click
        '************************************************************************************
        'Name: MnuTrainingDb_Click
        'Date Created: 5/5/05                           Created by: Scott Plummer
        'Release: 7.7.34                                Task: 420
        'Description: Logs into the Training DB
        'Returns: Nothing
        'Params: None
        'Stored Procedures: None
        '************************************************************************************
        On Error Resume Next

        Dim I As Short

        'Check to see if the current connection is the production database
        'Production database should be connection # 1
        If AppMain.ConnectionType = TEST_CONN Or AppMain.ConnectionType = PROD_CONN Then
            For I = 1 To Application.OpenForms.Count - 1
                Application.OpenForms(I).Hide()
            Next I
            'Close any open forms
            'While Application.OpenForms.Count > 1
            '    Application.OpenForms(Application.OpenForms.Count - 1).Close()
            'End While

            Call Toolbar1_ButtonClick(Toolbar1.Items.Item(OPENDASHBOARDBUTTON), New System.EventArgs())

            'Set the current connection to Training
            AppMain.ConnectionType = TRAINING_CONN

            Call AppMain.Main_Renamed()

        ElseIf AppMain.ConnectionType = TRAINING_CONN Then

            Call MsgBox("You are already connected to the Training database.", 64, "Production Database")

        ElseIf AppMain.ConnectionType = INTERNET Then

            Call MsgBox("You cannot change databases when logged in via the Internet.", 64, "Internet Connection")

        Else

            Call MsgBox("You cannot change databases when logged in to the production backup database.", 64, "Backup Production Database")

        End If


    End Sub

    Private Sub Timer_Renamed_Tick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles Timer_Renamed.Tick

        Dim vDaylightSavings As Short

        '02/21/03 bjk: use vTimeZoneDif to get the difference between the current time zone and MT set the panel
        ' times by adjusting according to MT time
        Dim vTimeZoneDif As Short
        vTimeZoneDif = modStatQuery.QueryTimeZoneDif(AppMain.ParentForm.SystemTimeZone)

        StatusBar.Items.Item(4).Text = Format(TimeOfDay, "HH:mm")
        StatusBar.Items.Item(3).Text = Format(Today, "MM/dd/yy")

        If MnuMilitaryPacific.Checked = True Then
            StatusTimes.Items.Item(0).Text = Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -1, DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, Now)), "HH:mm")
        Else
            StatusTimes.Items.Item(0).Text = Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -1, DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, Now)), "h:mm tt")
        End If

        If MnuMilitaryMountain.Checked = True Then
            StatusTimes.Items.Item(1).Text = Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, Now), "HH:mm")
        Else
            StatusTimes.Items.Item(1).Text = Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, Now), "h:mm tt")
        End If

        If MnuMilitaryCentral.Checked = True Then
            StatusTimes.Items.Item(2).Text = Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, 1, DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, Now)), "HH:mm")
        Else
            StatusTimes.Items.Item(2).Text = Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, 1, DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, Now)), "h:mm tt")
        End If

        If MnuMilitaryEastern.Checked = True Then
            StatusTimes.Items.Item(3).Text = Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, 2, DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, Now)), "HH:mm")
        Else
            StatusTimes.Items.Item(3).Text = Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, 2, DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, Now)), "h:mm tt")

        End If


        'Check time lables
        Dim startDateValue As Date
        Dim endDateValue As Date
        startDateValue = New Date(Year(Today), 4, 6, 1, 0, 0) 'DateValue("04/06/" & Year(Today) & " 1:00:00 AM")
        endDateValue = New Date(Year(Today), 10, 26, 1, 0, 0) 'DateValue("10/26/" & Year(Today) & " 1:00:00 AM") 

        If Now > startDateValue And Today < endDateValue Then
            vDaylightSavings = True
        Else
            vDaylightSavings = False
        End If


        If vDaylightSavings Then
            MnuMountain.Text = "Mountain"
            MnuPacific.Text = "Pacific/AZ"
            MnuBlank1.Text = "                                                                                      "
            MnuBlank2.Text = "  "
            MnuBlank3.Text = "   "
            MnuBlank4.Text = "     "
        Else
            MnuMountain.Text = "Mountain/AZ"
            MnuPacific.Text = "Pacific"
            MnuBlank1.Text = "                                                                                         "
            MnuBlank2.Text = "  "
            MnuBlank3.Text = ""
            MnuBlank4.Text = "     "
        End If

    End Sub

    Private Sub Toolbar1_ButtonClick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles NewCall.Click, _Toolbar1_Button2.Click, QuickLookup.Click, Organizations.Click, OnCall.Click, _Toolbar1_Button6.Click, OpenDashboard.Click
        Dim Button As System.Windows.Forms.ToolStripItem = CType(eventSender, System.Windows.Forms.ToolStripItem)

        Select Case Button.Name
            Case "NewCall"
                'Dim FrmNew As New FrmNew
                'Load(FrmNew)
                AppMain.OpenFormNew()

            Case "QuickLookup"

                AppMain.frmQuickLook = New FrmQuickLook()
                AppMain.frmQuickLook.Display()
            Case "Organizations"
                AppMain.frmOpenOrganization = New FrmOpenOrganization()
                AppMain.frmOpenOrganization.Display()
                'FrmOpenOrganization.Display()
            Case "OnCall"
                If Not IsLoaded("FrmOnCall") Then
                    AppMain.frmOnCall = New FrmOnCall()
                    AppMain.frmOnCall.OrganizationId = 0
                    AppMain.frmOnCall.CurrentDate = Today
                    AppMain.frmOnCall.Display()
                End If
            Case "OpenDashboard"
                If Not AppMain.frmOpenAll.Visible Then
                    If Not IsLoaded("FrmReferral") Then
                        AppMain.frmOpenAll.Display()
                    End If
                Else
                    AppMain.frmOpenAll.Hide()
                End If
        End Select

    End Sub

    Public Function Display() As Object

        Me.Show()

    End Function

    Private Sub VP_Timer_Tick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles VP_Timer.Tick

    End Sub
    Public Sub LoadFrmOpenAll()
        '02/12/03 drh - Check Command Line parameters
        If AppMain.isDev Then
            'bret 01/07/10 cmdButton was removed
            Call Toolbar1_ButtonClick(Toolbar1.Items.Item(OPENDASHBOARDBUTTON), New System.EventArgs())

        End If
    End Sub

    Private Sub MnuBlank1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MnuBlank1.Click

    End Sub

End Class
