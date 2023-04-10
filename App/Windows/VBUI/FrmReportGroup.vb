Option Strict Off
Option Explicit On
Friend Class FrmReportGroup
	Inherits System.Windows.Forms.Form
	
	'Form Variables
	Public FormState As Short
	Public ReportGroupID As Integer
	Public Verified As Short
	Public Saved As Short
	
	Public ReportID As Integer
	Public ParentOrgID As Integer
	
    Public Function ValidateReportGroup(ByRef pvForm As FrmReportGroup) As Object

        'Validate key fields for values
        If pvForm.TxtName.Text = "" Then
            Call modMsgForm.FormValidate("Name", pvForm.TxtName)
        Else
            ValidateReportGroup = True
            Exit Function
        End If

        ValidateReportGroup = False

    End Function


    Public Function Display() As Integer

        Me.ShowDialog()

        Display = ReportGroupID

    End Function
    Private Sub CmdCancel_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdCancel.Click

        Me.Close()

    End Sub


    Private Sub CmdOK_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdOK.Click

        Dim vReturn As Short

        'Make sure the user wants to save
        vReturn = modMsgForm.FormSave

        If vReturn = MsgBoxResult.Cancel Then
            Exit Sub
        End If

        'Set the data to unverified
        Me.Verified = False

        'Validate the data
        If Not ValidateReportGroup(Me) Then
            Exit Sub
        End If

        'Create a new record and
        'get the ID
        Me.ReportGroupID = modReport.SaveWebReportGroup(Me)

        If Me.ReportGroupID = 0 Then
            Me.Saved = False
            Exit Sub
        End If

        Me.Saved = True

        Me.Close()

    End Sub

    Private Sub FrmReportGroup_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load

        Call modUtility.CenterForm()

        If Me.FormState = NEW_RECORD Then

            'Just display the form.

        ElseIf Me.FormState = EXISTING_RECORD Then

            'Get the Report record detail
            Call modReport.QueryWebReportGroup(Me)

            'Disable save if master list item
            If Me.ChkMaster.CheckState = System.Windows.Forms.CheckState.Checked And Me.ParentOrgID = 194 Then
                Me.CmdOK.Enabled = False
                Me.TxtName.Enabled = False
            End If

        End If

        If Me.ParentOrgID = 194 Then
            Me.ChkMaster.Enabled = False
        End If

    End Sub









    Private Sub FrmReportGroup_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing

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

        'Me.Dispose()
    End Sub
End Class