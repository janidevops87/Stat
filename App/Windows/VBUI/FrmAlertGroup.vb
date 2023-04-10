Option Strict Off
Option Explicit On
Friend Class FrmAlertGroup
	Inherits System.Windows.Forms.Form
	
	'Form Variables
	Public FormState As Short
	Public AlertGroupID As Integer
	Public Saved As Short
	Public AlertType As Short
	Public AlertID As Integer
	Public AuditLogId As Integer 'AT2 drh 10/29/03
	
	
	
	Public Function Display() As Integer
		
        Dim dialogResult As DialogResult = Me.ShowDialog()
		
		Display = AlertGroupID
		
	End Function
	Private Sub cmdCancel_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdCancel.Click
		
		Me.Close()
		
	End Sub
	
	
	Private Sub cmdOK_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdOK.Click
		
		Dim vReturn As Short
		
		'Make sure the user wants to save
		vReturn = modMsgForm.FormSave
		
		If vReturn = MsgBoxResult.Cancel Then
			Exit Sub
		End If
		
		'Validate the data
		If Not modStatValidate.AlertGroup(Me) Then
			Exit Sub
		End If

        'Create a new record and
        'get the ID
        Me.AlertGroupID = modStatSave.SaveAlertGroup(Me)

        If Me.AlertGroupID = 0 Then
            Me.Saved = False
            Exit Sub
        End If

        'AT2 drh 10/29/03 - modStatAudit uses AlertID, not AlertGroupID
        Me.AlertID = Me.AlertGroupID

        Me.Saved = True

        Me.Close()

    End Sub

    Private Sub FrmAlertGroup_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load

        Call modUtility.CenterForm()

        If Me.FormState = NEW_RECORD Then

            'Just display the form.

        ElseIf Me.FormState = EXISTING_RECORD Then

            'AT2 drh 10/29/03 - modStatAudit uses AlertID, not AlertGroupID
            Me.AlertID = Me.AlertGroupID


        End If



    End Sub






    Private Sub FrmAlertGroup_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing

        Dim vReturn As Short

        If Me.Saved = True Then
            'The message was saved so just unload
            eventArgs.Cancel = False

        Else
            'The message was cancelled or closed so confirm cancellation
            vReturn = modMsgForm.FormCancel
            If vReturn = MsgBoxResult.Yes Then
                'AT2 drh 10/29/03 - modStatAudit uses AlertID, not AlertGroupID
                Me.AlertID = Me.AlertGroupID

                eventArgs.Cancel = False

            Else
                eventArgs.Cancel = True
                Exit Sub
            End If
        End If

    End Sub
End Class