Option Strict Off
Option Explicit On
Imports VB = Microsoft.VisualBasic
Imports System.Deployment.Application
Friend Class FrmLogin
	Inherits System.Windows.Forms.Form
	'Bret 1/06/10 add Option explicit for upgrade

	Private Sub CmdExit_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdExit.Click
		

	End Sub
	
	
	
	Private Sub CmdLogin_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdLogin.Click
		
		On Error Resume Next
		
		AppMain.UserID = TxtUserID.Text
		AppMain.Password = TxtPassword.Text
		AppMain.ConnectionType = modControl.GetID(CboConnect)
		
		
		'bjk 4/15/02
		'TxtExtension.Text = GetSetting("Statline", "Extension", "Number", "")
		
		If TxtExtension.Text = "" Then
			MsgBox("Please enter your extension number.")
			TxtExtension.Focus()
			TxtExtension.Enabled = True
			Exit Sub
		Else
			AppMain.Extension = CShort(TxtExtension.Text)
		End If
		
		'Removed by Bret Knoll may 2001
		'Delete before release
		'If CboQueue.Text = "" Then
		'    MsgBox "Please enter your primary call queue."
		'    Exit Sub
		'Else
		'    AppMain.Queue = CboQueue.Text
		'End If
		
        If AppMain.Main_Renamed() Then

            AppMain.ParentForm.Show()
            Me.Hide()

        End If
		
		
	End Sub
	
	
	
	Private Sub FrmLogin_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load
		
        '3/2010 bret add functionality to pass arguments using clickOnce
        'created isDev Boolean to check for dev command line argument from either ClickOnce or normal deployment
        'if -dev is passed in from either direction then IsDev is set to true kicking off the functionality
        AppMain.isDev = False
        AppMain.isDev = False
        'First if is clickonce method
        Dim getArguments() As String = Me.GetArguments()
        If getArguments.Contains("dev") Or getArguments.Contains("-dev") Then
            AppMain.isDev = True
            'SendIf is regualr method
        ElseIf InStr(1, VB.Command(), "dev") > 0 Then
            AppMain.isDev = True
        End If
        If getArguments.Contains("auth") Or getArguments.Contains("-auth") Then
            AppMain.isAuth = True
            'SendIf is regualr method
        ElseIf InStr(1, VB.Command(), "auth") > 0 Then
            AppMain.isAuth = True
        End If
        '1/13/03 drh - Command line arg for development (adds "D-evelopment" database to connection list)
        If AppMain.isDev Then
            CboConnect.Items.Add(New ValueDescriptionPair(DEVELOPMENT, "Development DB"))
            'modControl.SelectText(CboConnect, "Development DB") 'CboConnect.SelectedIndex = DEVELOPMENT
            modControl.SelectID(CboConnect, DEVELOPMENT)
        Else
            'Default to the first item in connect list
            Call modControl.SelectFirst(CboConnect)

        End If

        'drh 09/24/03 - Integrated Logon: Set form controls based on authentication method
        If isAuth Then
            Me.TxtUserID.ReadOnly = False
            Me.TxtPassword.ReadOnly = False
            Me.TxtUserID.TabStop = True
            Me.TxtPassword.TabStop = True
        Else
            Me.TxtUserID.ReadOnly = True
            Me.TxtPassword.ReadOnly = False
            Me.TxtUserID.TabStop = False
            Me.TxtPassword.TabStop = False
            Me.TxtPassword.Text = "password"

            'drh 09/23/03 - Integrated Logon: Get the NT UserId
            Me.TxtUserID.Text = modLogon.GetThreadUserName
        End If

        If TxtExtension.Text = "" Then
            TxtExtension.Enabled = True
        Else
            TxtExtension.Enabled = False
        End If

        Me.Text = GetVersion()

    End Sub
	
	
	
    Private Sub FrmLogin_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing



    End Sub

    Private Sub TxtExtension_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtExtension.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        'bjk 04/15/02 changed second paramter from 3 to 4 to allow 4 digit extension.
        KeyAscii = modMask.NumMask(KeyAscii, 4, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtPassword_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtPassword.TextChanged

        If TxtUserID.Text <> "" And TxtPassword.Text <> "" Then
            CmdLogin.Enabled = True
        Else
            CmdLogin.Enabled = False
        End If

    End Sub

    Private Sub TxtPassword_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtPassword.Enter

        Call modControl.HighlightText(TxtPassword)

    End Sub


    Private Sub TxtUserId_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtUserId.TextChanged

        If TxtUserID.Text <> "" And TxtPassword.Text <> "" Then
            CmdLogin.Enabled = True
        Else
            CmdLogin.Enabled = False
        End If

    End Sub


    Private Sub TxtUserID_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtUserID.Enter
		
		Call modControl.HighlightText(ActiveControl)
		
	End Sub
	
	Private Sub TxtUserID_KeyUp(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles TxtUserID.KeyUp
		Dim KeyCode As Short = eventArgs.KeyCode
		Dim Shift As Short = eventArgs.KeyData \ &H10000
		'************************************************************************************
		'Name: TxtUserID_KeyUp
		'Date Created: 4/22/05                          Created by: Scott Plummer
		'Release: 7.7.33                                Task: None
		'Description: Allows user to log in as anyone if they press Ctrl+F12.
		'             KEEP THIS SECRET!!!
		'Returns: Nothing
		'Params: KeyCode, Shift
		'Stored Procedures: None
		'************************************************************************************
		' If the -dev flag is used, allow the user to hit CTRL+F12 to log in
		' as anyone.  4/22/05 - SAP

        If KeyCode = System.Windows.Forms.Keys.F12 And Shift = VB6.ShiftConstants.CtrlMask Then
            Me.TxtUserID.ReadOnly = False
            Me.TxtPassword.ReadOnly = False
            Me.TxtUserID.Focus()
        End If

		
		
		
		
	End Sub

    Private Sub CboConnect_Initialize()

        CboConnect.Items.Add(New ValueDescriptionPair(PROD_CONN, "Production(Database)"))
        CboConnect.Items.Add(New ValueDescriptionPair(TEST_CONN, "Test(Database)"))
        CboConnect.Items.Add(New ValueDescriptionPair(TRAINING_CONN, "Training(Database)"))
        CboConnect.Items.Add(New ValueDescriptionPair(PROD_BKUP_CONN, "Backup(Database)"))
        CboConnect.Items.Add(New ValueDescriptionPair(ARCHIVE, "ProductionArchive"))

    End Sub
    Private Function GetArguments() As String()




        If (ApplicationDeployment.IsNetworkDeployed) Then
            If Not IsNothing(ApplicationDeployment.CurrentDeployment.ActivationUri) Then


                Dim query As String = System.Web.HttpUtility.UrlDecode(ApplicationDeployment.CurrentDeployment.ActivationUri.Query)

                If (Not String.IsNullOrEmpty(query) And query.StartsWith("?")) Then


                    Dim arguments As String() = query.Substring(1).Split(" ")

                    Dim commandLineArgs() As String
                    ReDim commandLineArgs(arguments.Length + 1)
                    commandLineArgs(0) = Environment.GetCommandLineArgs()(0)

                    arguments.CopyTo(commandLineArgs, 1)

                    Return commandLineArgs
                End If
            ElseIf (Not IsNothing(AppDomain.CurrentDomain.SetupInformation.ActivationArguments.ActivationData)) Then
                Dim activationData() As String = AppDomain.CurrentDomain.SetupInformation.ActivationArguments.ActivationData

                Return activationData

            End If

        End If
        Return Environment.GetCommandLineArgs()

    End Function
End Class