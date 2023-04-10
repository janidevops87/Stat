Option Strict Off
Option Explicit On
Friend Class FrmFax
	Inherits System.Windows.Forms.Form
	'Bret 1/06/10 add Option explicit for upgrade
	Public vFaxId As Integer
	Public vOrganizationId As Integer
	
	Private Sub CmdCancel_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdCancel.Click
		
		Me.Hide()
		Me.Close()
		
	End Sub
	
	Private Sub cmdSave_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdSave.Click
		
        Dim vFaxText As String = ""
		vFaxText = txtFaxNumber.Text
		
		If Len(vFaxText) = 14 Then
			Call modStatSave.SaveFax(vFaxId, vFaxText, vOrganizationId)
			Me.Hide()
			Me.Close()
		End If
		
	End Sub
	
    Private Sub FrmFax_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing

        'Dispose()
    End Sub
	
	Private Sub txtFaxNumber_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles txtFaxNumber.KeyPress
		Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        KeyAscii = modMask.PhoneMask(KeyAscii, txtFaxNumber)

        eventArgs.KeyChar = Chr(KeyAscii)
		If KeyAscii = 0 Then
			eventArgs.Handled = True
		End If
	End Sub
	
	Public Function Display() As Integer
		
        Dim showDialog As DialogResult = Me.ShowDialog()

	End Function
End Class
