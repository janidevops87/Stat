Option Strict Off
Option Explicit On
Imports System.Configuration
Imports VB = Microsoft.VisualBasic
Public Module AppMain

    'Application Constants
    Public Const AppName As String = "StatTrac"
    Public Const ReportDirectory As String = "Z:\Production2\"
    
    'Datasources
    Public Const PROD_DATASOURCE As String = "Production"
    Public Const TEST_DATASOURCE As String = "Test"
    Public Const PROD_BACKUP_DATASOURCE As String = "BackupProduction"
    Public Const INTERNET_DATASOURCE As String = "www2.statline.com/loginstatline/stattrac/a_query.asp?Query="
    Public Const ARCHIVE_DATASOURCE As String = "ProductionArchive"
    Public Const TRAINING_DATASOURCE As String = "Training" ' Added v. 7.7.34 5/5/05 - SAP
    Public Const TRAINING_GREEN As Integer = &H8000

    'Connection Types
    Public Const PROD_CONN As Short = 0
    Public Const TEST_CONN As Short = 1
    Public Const PROD_BKUP_CONN As Short = 2
    Public Const ARCHIVE As Short = 3
    Public Const TRAINING_CONN As Short = 4 ' Added v. 7.7.34 5/5/05 - SAP
    Public Const DEVELOPMENT As Short = 5 '1/13/03 drh
    Public Const ISSUES As Short = 6 '1/13/03 drh
    Public Const INTERNET As Short = 7

    'Person Property Login Types
    Public Const STAT_LOGIN As Short = 1
    Public Const WEB_LOGIN As Short = 2

    'Global Variables
    Friend ParentForm As MDIFormStatLine

    'Variables
    Public UserID As String
    Public Password As String
    Public DBUserID As String
    Public DBPassword As String
    Public Connection As String
    Public ConnectionType As Short
    Public Queue As String
    Public Extension As Short
    Public ExpiredEventTime As Short
    Public QueryTimeoutInSeconds As Short = ConfigurationSettings.AppSettings("Command.Timeout")
    Public QueryRetryIntervalInSeconds As Short = ConfigurationSettings.AppSettings("QueryRetryIntervalInSeconds")
    Public QueryAttemptLimit As Short = ConfigurationSettings.AppSettings("QueryAttemptLimit")


    'ccarroll 06/16/2006 - QA reset switch
    'ccarroll 10/19/2007 - Empirix 7012, 7017. Changed scope of vQAResetSwitch to include values for StatLine(1) and
    '                      ASP users(2). The switch is set to either show or hide referrals in the update tab after
    '                      QA review has completed. Was Boolean. Added QAUserOrg
    Public vQAResetSwitch As Short


    Public modError As New clsError

    'drh 09/24/03 - Integrated Logon: Variable to determine whether NT Authentication succeeded
    Public Authorized As Boolean

    'T.T 9/13/2004 added to allow user to chose registry status
    Public pvregchoice As String
    '2010 bret add frm references
    Public frmAbout As FrmAbout
    Public frmAlert As FrmAlert
    Public frmConsentInterval As FrmConsentInterval
    Public frmCriteria As FrmCriteria
    Public frmDictionaryItemSelect As FrmDictionaryItemSelect
    Public frmGeneralAlert As FrmGeneralAlert
    Public frmIndicationSelect As FrmIndicationSelect
    Public frmKeyCodeSelect As FrmKeyCodeSelect
    Public frmLeaseOrganizationCalls As FrmLeaseOrganizationCalls
    Public frmMessage As FrmMessage
    Public frmNew As FrmNew
    Public frmNoCall As FrmNoCall
    Public frmOpenAll As FrmOpenAll
    Public frmOnCall As FrmOnCall
    Public frmOpenOrganization As FrmOpenOrganization
    Public frmQuickLook As FrmQuickLook
    Public frmReferral As FrmReferral
    Public frmReferralView As FrmReferralView
    Public frmReport As FrmReport
    Public frmRotateOrganization As FrmRotateOrganization
    Public frmSchedule As FrmSchedule
    Public frmServiceLevel As FrmServiceLevel
    Public frmSourceCode As FrmSourceCode
    Public frmSourceCodeGroup As FrmSourceCodeGroup
    Public frmSystemAlert As FrmSystemAlert
    Public frmRefDups As FrmRefDups

    '3/2010 bret add reference to command variables
    Public isDev As Boolean
    Public isAuth As Boolean

    '05/05/2011 ccarroll added to prevent deletion of contact required in FrmReferral
    'bug 10467
    Public isOnCallEventCancel As Boolean

    Public Sub Initialize_GlobalObjects()
        'Set the MDI parent form
        If ParentForm Is Nothing Then
            ParentForm = New MDIFormStatLine
        End If

        If frmOpenAll Is Nothing Then
            frmOpenAll = New FrmOpenAll
        End If



    End Sub
    Public Function Main_Renamed() As Object
        '************************************************************************************
        'Name: Main
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Main startup procedure for StatTrac
        'Returns: Nothing
        'Params: None
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 5/9/05                           Changed by: Scott Plummer
        'Release #: 7.7.34                              Task: 420
        'Description:  Added TRAINING_CONN to function.
        '====================================================================================
        'Date Changed: 06/20/2007                         Changed by: Thien Ta
        'Release #: 8.4                             Task: requirement 2.5
        'Description:  added ExpiredEvents parameter
        '====================================================================================
        '************************************************************************************

        Dim vUserID As String = ""
        Dim vPassword As String = ""
        Dim I As Short
        Dim vLO As String = ""
        Dim vCount As Short
        Dim vResults As New Object
        Dim vResults1 As Object
        Dim vResults2 As Object
        Dim vReturnCode As Short
        Dim vBackup As Short

        Call modUtility.Work()


        vResults = New Object()
        vResults1 = New Object()
        vResults2 = New Object()

        'Initialize the connection information
        Select Case AppMain.ConnectionType

            Case PROD_CONN
                AppMain.Connection = PROD_DATASOURCE

            Case TEST_CONN
                AppMain.Connection = TEST_DATASOURCE

            Case TRAINING_CONN
                ' Added for v. 7.7.34, 5/9/05 - SAP
                AppMain.Connection = TRAINING_DATASOURCE

            Case PROD_BKUP_CONN
                AppMain.Connection = PROD_BACKUP_DATASOURCE

            Case INTERNET
                AppMain.Connection = INTERNET_DATASOURCE
            Case ARCHIVE
                AppMain.Connection = ARCHIVE_DATASOURCE

                '1/13/03 drh - For Development
            Case DEVELOPMENT
                AppMain.Connection = "Development"

                '1/13/03 drh - For Development
            Case ISSUES
                AppMain.Connection = "Issues"

        End Select


        'Lookup the employee id based on the user id and password
        'drh 09/23/03 - Integrated Logon: Don't need password anymore
        'vReturnCode = modStatQuery.QueryEmployeeLogin(AppMain.UserID, AppMain.Password, vResults)
        vReturnCode = modStatQuery.QueryEmployeeLogin_Integrated(AppMain.UserID, vResults)

        If vReturnCode <> SUCCESS Then

            Call modUtility.Done()
            Call modMsgForm.LoginFail()
            Main_Renamed = False

        Else

            Initialize_GlobalObjects()
            AppMain.ParentForm.Hide()

            '02/21/03 bjk: set SystemTimeZone before calling AppMain
            '02/03/10 Bret: Moved to within in Else
            ParentForm.SystemTimeZone = GetSystemTimeZone()

            'bjk 12/20/01 moved statement before setting any ParentForm variables
            'drh 09/23/03 - Integrated Logon: Don't need password anymore
            'vReturnCode = modReport.QueryUserLogin(AppMain.UserID, AppMain.Password, vResults1)
            vReturnCode = modReport.QueryUserLogin_Integrated(AppMain.UserID, vResults1)

            ' bjk 12/20/01 move if statment block above block; Set the employee variables
            ' This was necessary to set the TimeZone before the ParentForm Loads.
            'T.T 05/06/2004 Lease Organization Type Pulls back from bitwise tables
            Try
                vReturnCode = CShort(modStatQuery.LeaseOrganizationType(modConv.TextToInt(vResults1(0, 4)), vResults2))
            Catch ex As Exception
                vReturnCode = SQL_ERROR
            End Try

            If vReturnCode <> SUCCESS Then
                Call modUtility.Done()
                MsgBox("You do not have permissions to run reports. Contact supervisor to add permissions.")
            Else
                ParentForm.WebPersonID = vResults1(0, 0)
                ParentForm.WebUserOrg = vResults1(0, 2)
                ParentForm.StatEmployeeEmail = vResults1(0, 3)
                'added 06/2001 bjk: LeaseOrganization
                ParentForm.LeaseOrganization = vResults1(0, 4)
                Queue = vResults1(0, 5)
                ParentForm.TimeZone = vResults1(0, 6)

                'T.T 5/10/2004 added new array for lease organization fields
                'Creates the LeaseOrganizationType and assigns it to ParentForm.LeaseOrganizationType
                If modConv.TextToInt(vResults1(0, 4)) > 0 Then 'If lease Org then find type.
                    vCount = UBound(vResults2, 1)
                    For I = 0 To vCount
                        vLO = vLO & vResults2(I, 0)
                    Next I
                    ParentForm.LeaseOrganizationType = vLO
                End If

                'T.T 06/20/2007 code to get Expired event Times
                ExpiredEventTime = GetExpiredEventTime()
            End If

            'Set the employee variables
            ParentForm.StatEmployeeID = vResults(0, 0)
            ParentForm.StatEmployeeName = vResults(0, 1)
            ParentForm.StatusBar.Items(1).Text = "Logged In:  " & ParentForm.StatEmployeeName
            ParentForm.PersonID = vResults(0, 2)
            '7/6/01 drh Added so we can lock TC's out of Family Services
            ParentForm.PersonTypeID = vResults(0, 3)


            'Check if an internet connection is allowed
            If AppMain.ConnectionType = INTERNET Then
                If modStatSecurity.GetPermission(ParentForm.StatEmployeeID, "AllowInternetAccess") Then
                    'Do nothing
                Else
                    'Save system alert
                    Call modStatSave.SaveSystemAlert("Failed attempt to login via Internet:  " & ParentForm.StatEmployeeName, 1)

                    Call modUtility.Done()
                    Call modMsgForm.LoginFail()
                    Main_Renamed = False
                    Exit Function
                End If
            End If

            'Set security options
            If modStatSecurity.GetPermission(ParentForm.StatEmployeeID, "AllowMaintainAccess") Then
                ParentForm.MnuMaintain.Visible = True
                ParentForm.MnuPlaceHolder.Visible = False
            Else
                ParentForm.MnuMaintain.Visible = False
                ParentForm.MnuPlaceHolder.Visible = True
            End If

            If modStatSecurity.GetPermission(ParentForm.StatEmployeeID, "AllowRecoveryAccess") And AppMain.ConnectionType = PROD_BKUP_CONN Then
                ParentForm.MnuEnableBackup.Visible = True
                ParentForm.MnuDash6.Visible = True
            Else
                ParentForm.MnuEnableBackup.Visible = False
                ParentForm.MnuDash6.Visible = False
            End If

            AppMain.InitParentForm()

            'Show the parent form
            'ParentForm.Display()
            Main_Renamed = True

            'AppMain.ParentForm.LoadFrmOpenAll()

        End If

        Call modUtility.Done()

        Exit Function



    End Function



    Public Function InitParentForm() As Object
        '************************************************************************************
        'Name: Main
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Sets initial appearance of parent form when switching DBs.
        'Returns: Nothing
        'Params: None
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 5/9/05                           Changed by: Scott Plummer
        'Release #: 7.7.34                              Task: 420
        'Description:  Added TRAINING_CONN to function.
        '====================================================================================
        '************************************************************************************
        'ccarroll 01/18/2010 - PnlTest control was replaced by btnTest(MDIForm).Net conversion

        '1/14/03 drh - If Command line arg for development exists, get DB/Server info
        Dim vDBServerInfo As String = ""
        vDBServerInfo = ""
        If AppMain.isDev Then
            Call QueryDBServerInfo(vDBServerInfo)
        End If

        Select Case AppMain.ConnectionType

            Case PROD_CONN

                ParentForm.StatusBar.Items(0).Text = IIf(vDBServerInfo = "", AppMain.Connection & " Database", vDBServerInfo) '1/14/03 drh
                ParentForm.MnuTestDB.Checked = False
                ParentForm.MnuProductionDB.Checked = True
                ParentForm.MnuTrainingDb.Checked = False
                ParentForm.BackColor = System.Drawing.SystemColors.AppWorkspace
                ParentForm.btnTest.Visible = False

            Case TEST_CONN

                ParentForm.StatusBar.Items(0).Text = IIf(vDBServerInfo = "", AppMain.Connection & " Database", vDBServerInfo) '1/14/03 drh
                ParentForm.MnuTestDB.Checked = True
                ParentForm.MnuProductionDB.Checked = False
                ParentForm.MnuTrainingDb.Checked = False
                ParentForm.BackColor = System.Drawing.Color.Red
                ParentForm.btnTest.BackColor = Color.Red
                ParentForm.btnTest.Text = "TEST DATABASE"
                ParentForm.btnTest.Visible = True

            Case TRAINING_CONN ' Added for 7.7.34 - 5/6/05 - SAP

                ParentForm.StatusBar.Items(0).Text = IIf(vDBServerInfo = "", AppMain.Connection & " Database", vDBServerInfo)
                ParentForm.MnuTestDB.Checked = False
                ParentForm.MnuProductionDB.Checked = False
                ParentForm.MnuTrainingDb.Checked = True
                ParentForm.BackColor = System.Drawing.ColorTranslator.FromOle(TRAINING_GREEN)
                ParentForm.btnTest.BackColor = Color.Green 'bret 01/13/2010 change from TRAINING_GREEN
                ParentForm.btnTest.Text = "TRAINING DATABASE"
                ParentForm.btnTest.Visible = True

            Case PROD_BKUP_CONN

                ParentForm.StatusBar.Items(0).Text = IIf(vDBServerInfo = "", AppMain.Connection & " Database", vDBServerInfo) '1/14/03 drh
                ParentForm.MnuTestDB.Checked = False
                ParentForm.MnuProductionDB.Checked = False
                ParentForm.MnuTrainingDb.Checked = False
                ParentForm.BackColor = System.Drawing.Color.Yellow
                ParentForm.btnTest.BackColor = (System.Drawing.Color.Yellow)
                ParentForm.btnTest.Text = "BACKUP DATABASE"
                ParentForm.btnTest.Visible = True

            Case INTERNET

                ParentForm.StatusBar.Items(0).Text = "Production Database - Internet"
                ParentForm.MnuTestDB.Checked = False
                ParentForm.MnuProductionDB.Checked = True
                ParentForm.MnuTrainingDb.Checked = False
                ParentForm.BackColor = System.Drawing.SystemColors.AppWorkspace
                ParentForm.btnTest.BackColor = (System.Drawing.Color.Blue)
                ParentForm.btnTest.Text = "INTERNET CONNECTION"
                ParentForm.BackColor = System.Drawing.Color.Blue
                ParentForm.btnTest.Visible = True

            Case ARCHIVE
                ParentForm.StatusBar.Items(0).Text = IIf(vDBServerInfo = "", AppMain.Connection & " Database", vDBServerInfo) '1/14/03 drh
                ParentForm.MnuTestDB.Checked = False
                ParentForm.MnuProductionDB.Checked = True
                ParentForm.MnuTrainingDb.Checked = False
                ParentForm.BackColor = System.Drawing.Color.Cyan
                ParentForm.btnTest.BackColor = (System.Drawing.Color.Cyan)
                ParentForm.btnTest.Text = "ARCHIVE CONNECTION"
                ParentForm.BackColor = System.Drawing.Color.Cyan
                ParentForm.btnTest.Visible = True

            Case DEVELOPMENT '1/13/03 drh

                ParentForm.StatusBar.Items(0).Text = IIf(vDBServerInfo = "", AppMain.Connection & " Database", vDBServerInfo)
                ParentForm.StatusBar.Items(0).Visible = True
                ParentForm.MnuTestDB.Checked = True
                ParentForm.MnuProductionDB.Checked = False
                ParentForm.MnuTrainingDb.Checked = False
                ParentForm.BackColor = System.Drawing.Color.Blue
                ParentForm.btnTest.Text = AppMain.Connection & " Database"
                ParentForm.btnTest.BackColor = (System.Drawing.Color.Blue)
                ParentForm.btnTest.Visible = True

            Case ISSUES '1/13/03 drh

                ParentForm.StatusBar.Items(0).Text = IIf(vDBServerInfo = "", AppMain.Connection & " Database", vDBServerInfo)
                ParentForm.StatusBar.Items(0).Visible = True
                ParentForm.MnuTestDB.Checked = True
                ParentForm.MnuProductionDB.Checked = False
                ParentForm.MnuTrainingDb.Checked = False
                ParentForm.BackColor = System.Drawing.Color.Blue
                ParentForm.btnTest.Text = AppMain.Connection & " Database"
                ParentForm.btnTest.BackColor = (System.Drawing.Color.Blue)
                ParentForm.btnTest.Visible = True

        End Select

    End Function

    Public Sub OpenFrmGeneralAlert(Optional ByVal whereFrom As String = "DoubleClick")

        AppMain.frmGeneralAlert = New FrmGeneralAlert
        Dim generalAlert As New clsGeneralAlert
        'if selected item isn't selected, set it to the first one
        If IsNothing(AppMain.frmOpenAll.LstViewGeneralAlert.FocusedItem) Then
            If (AppMain.frmOpenAll.LstViewGeneralAlert.SelectedItems.Count = 0) Then
                AppMain.frmOpenAll.LstViewGeneralAlert.Items.Item(0).Focused = True
            End If
        End If
        'Get the selected item
        If Not IsNothing(AppMain.frmOpenAll.LstViewGeneralAlert.FocusedItem) Then
            generalAlert = AppMain.frmOpenAll.GeneralAlerts.Item(AppMain.frmOpenAll.LstViewGeneralAlert.FocusedItem.Tag)

            'Display the selected item
            'call to alert edit should be with read only if from double click and not otherwise
            If whereFrom = "DoubleClick" Then
                AppMain.frmGeneralAlert.Display(generalAlert, True)
            Else
                AppMain.frmGeneralAlert.Display(generalAlert, False)
            End If
            'AppMain.frmGeneralAlert.Display(generalAlert, False)
            frmGeneralAlert = Nothing
            Call AppMain.frmOpenAll.RefreshLists()
        End If

    End Sub
    Public Function GetVersion() As String
        'If System.Deployment.Application.ApplicationDeployment.IsNetworkDeployed Then
        '    Dim version As System.Version
        '    Dim deployment As System.Deployment.Application.ApplicationDeployment = System.Deployment.Application.ApplicationDeployment.CurrentDeployment
        '    Dim returnString As String = String.Format(" - StatTrac v{0}.{1}.{2}", deployment.CurrentVersion.Major, deployment.CurrentVersion.Minor, deployment.CurrentVersion.Revision)
        '    Return returnString
        'Else
        '    Dim returnString As String = String.Format(" - StatTrac v{0}.{1}.{2}", My.Application.Info.Version.Major, My.Application.Info.Version.Minor, My.Application.Info.Version.Revision)
        '    Return returnString
        'End If
        Dim version As New System.Version(Application.ProductVersion)
        Return version.ToString()

    End Function
    Public Function OpenFormNew() As Boolean
        If IsNothing(AppMain.frmMessage) And IsNothing(AppMain.frmNoCall) And IsNothing(AppMain.frmReferral) And IsNothing(AppMain.frmReferralView) And IsNothing(AppMain.frmNew) Then
            AppMain.frmNew = New FrmNew()
            AppMain.frmNew.Show()

        End If
        If Not IsNothing(AppMain.frmNew) Then
            AppMain.frmNew.Focus()
        End If

    End Function

End Module


