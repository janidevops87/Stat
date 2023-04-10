Option Strict Off
Option Explicit On
Friend Class FrmSubtype
	Inherits System.Windows.Forms.Form
	'Bret 1/06/10 add Option explicit for upgrade
	Private Sub CmdCancel_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdCancel.Click
		
		Me.txtSubtypeName.Text = ""
		Me.txtSubtypeDescription.Text = ""
		Me.Hide()
		
	End Sub
	
	Private Sub CmdOK_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdOK.Click
		
		If Trim(Me.txtSubtypeName.Text) = "" Then
			Call MsgBox("Please enter a Subtype Name.", MsgBoxStyle.OKOnly)
			Exit Sub
		Else
			Call modStatSave.SaveSubtype(Me)
			
			Me.txtSubtypeName.Text = ""
			Me.txtSubtypeDescription.Text = ""
			Me.Hide()
		End If
		
	End Sub
End Class