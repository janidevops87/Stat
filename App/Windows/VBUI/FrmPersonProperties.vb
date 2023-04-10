Option Strict Off
Option Explicit On
Friend Class FrmPersonProperties
	Inherits System.Windows.Forms.Form
	
	'Form Variables
	Public OrganizationId As Integer
	Public PersonID As Integer
	Public WebPersonID As Integer
	Public FormState As Short
	Public Saved As Short
	Public SortOrder As Short
	
	Public PersonFirst As String
	Public PersonLast As String
	Public fvLeaseOrganization As Object
	Public LoginType As Short
	
	
	
	Private Sub CmdCancel_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdCancel.Click
		
		Me.Close()
		
	End Sub
	
	
	Private Sub CmdLoginType_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdLoginType.Click
		'BJK 04/01/02
		'this sub converts between a StatTrac Login setup screen weblogin setup screen
		
		If (LoginType And WEB_LOGIN) = WEB_LOGIN Then 'change from WebLogin to StatLogin
			LoginType = STAT_LOGIN
			Call ResetFormFields()
			FrmPersonProperties_Load(Me, New System.EventArgs())
			CmdLoginType.Text = "Web Login"
		ElseIf (LoginType And STAT_LOGIN) = STAT_LOGIN Then  ' change from StatLogin to WebLogin
			LoginType = WEB_LOGIN
			Call ResetFormFields()
			FrmPersonProperties_Load(Me, New System.EventArgs())
			CmdLoginType.Text = "StatTrac Login"
		End If
	End Sub
	
	Private Sub CmdOK_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdOK.Click
		
		Dim vReturn As Short
		
		'Make sure the user wants to save
		vReturn = modMsgForm.FormSave
		
		If vReturn = MsgBoxResult.Cancel Then
			Exit Sub
		End If
		
		'Validate the data
		If Not modStatValidate.PersonProperties(Me) Then
			Exit Sub
		End If
		
		'Create a new record and
		'get the ID
		Call modStatSave.SavePersonProperties(Me)
		Me.Saved = True
		
		Me.Close()
		
	End Sub
	
	
	Private Sub FrmPersonProperties_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load
		'set LoginType
		If LoginType = 0 Then
			LoginType = WEB_LOGIN
		End If
		'Get the properites for the organization
		Call modUtility.CenterForm()
		
		Me.Saved = False

        'BJK 04/02/02 disable login button if not ASP Org.
        If fvLeaseOrganization = -1 Then
            Me.CmdLoginType.Visible = True
        Else
            Me.CmdLoginType.Visible = False
        End If

        'if person is not StatTrac or is an ASP CLient with web access only disable the
        'detailed security options
        If IsStatTracPerson(Me) Then
            Me.Frame(1).Visible = True
        Else
            Me.Frame(1).Visible = False
        End If

        'Get the properties properties detail
        If modStatQuery.QueryPersonProperties(Me) = NO_DATA Then
            Me.FormState = NEW_RECORD
        Else
            Me.FormState = EXISTING_RECORD
        End If

        'Check if LO if not lO show ChkAllowMaintain
        'if user is LO do nothing
        If AppMain.ParentForm.LeaseOrganization = 0 Then
            ChkAllowMaintain.Visible = True
        End If


    End Sub





    Public Function Display() As Integer

        Dim dialogResults As DialogResult = Me.ShowDialog()

    End Function




    Private Sub FrmPersonProperties_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing

        Dim vReturn As Short

        If Me.Saved = True Then
            'The message was saved so just unload
            eventArgs.Cancel = False

        Else
            'The message was cancelled or closed so confirm cancellation
            vReturn = modMsgForm.FormCancel
            If vReturn = MsgBoxResult.Yes Then
                eventArgs.Cancel = False

            Else
                eventArgs.Cancel = True
                Exit Sub
            End If
        End If
        'Dispose()
    End Sub
	
	Private Sub TxtConfirm_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtConfirm.Enter
		
		Call modControl.HighlightText(ActiveControl)
		
	End Sub
	
	Private Sub TxtConfirm_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtConfirm.Leave
		
		If TxtPassword.Text <> TxtConfirm.Text Then
			MsgBox("The confirmed password does not match the password you typed. Please enter your password again.", MsgBoxStyle.OKOnly, "Password")
			TxtConfirm.Text = ""
			TxtPassword.Text = ""
			TxtPassword.Focus()
		End If
		
	End Sub
	
	
	Private Sub TxtPassword_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtPassword.Enter
		
		Call modControl.HighlightText(ActiveControl)
		
	End Sub
	
	Private Sub TxtPassword_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtPassword.Leave
		
		TxtConfirm.Focus()
		
	End Sub
	
	
	Private Sub TxtUserID_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtUserID.Enter
		
		Call modControl.HighlightText(ActiveControl)
		
	End Sub
	
	Public Function ResetFormFields() As Object
		'This function resets all fields
		'BJK 04/01/02
		TxtUserID.Text = ""
		TxtPassword.Text = ""
		TxtConfirm.Text = ""
		TxtEmail.Text = ""
		ChkAllowDeleteCall.CheckState = System.Windows.Forms.CheckState.Unchecked
		ChkAllowIncomplete.CheckState = System.Windows.Forms.CheckState.Unchecked
		ChkAllowInternetAccess.CheckState = System.Windows.Forms.CheckState.Unchecked
		ChkAllowMaintain.CheckState = System.Windows.Forms.CheckState.Unchecked
		ChkAllowRecovery.CheckState = System.Windows.Forms.CheckState.Unchecked
		ChkAllowScheduleAccess.CheckState = System.Windows.Forms.CheckState.Unchecked
		ChkAllowSecurityAccess.CheckState = System.Windows.Forms.CheckState.Unchecked
		ChkAllowStopTimer.CheckState = System.Windows.Forms.CheckState.Unchecked
		
		
		
	End Function
End Class