Option Strict Off
Option Explicit On
Friend Class FrmFSCondition
	Inherits System.Windows.Forms.Form
	'Bret 1/06/10 add Option explicit for upgrade
	
	Private Sub CmdCancel_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdCancel.Click
		
		Me.Close()
		
	End Sub
	
	Private Sub CmdOK_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdOK.Click
		
		If Trim(Me.txtCondition.Text) = "" Then
			Call MsgBox("Please enter a Condition.", MsgBoxStyle.OKOnly)
			Exit Sub
		Else
			Call modStatSave.SaveFSCondition(Me)
			
			Me.txtCondition.Text = ""
			Me.Close()
		End If
		
	End Sub
End Class