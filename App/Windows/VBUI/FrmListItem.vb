Option Strict Off
Option Explicit On
Friend Class FrmListItem
	Inherits System.Windows.Forms.Form
	
	Dim ItemName As String
	
	
	Public Function Display(ByRef vItemName As String) As Object
		
		ItemName = vItemName
		
        Dim dialogResult As DialogResult = Me.ShowDialog()
		
		vItemName = ItemName
		
	End Function
	Private Sub CmdCancel_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdCancel.Click
		
		Me.Close()
		
	End Sub
	
	
	Private Sub CmdOK_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdOK.Click
		
		ItemName = TxtName.Text
		
		Me.Close()
		
	End Sub
	
	Private Sub FrmListItem_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load
		
		Call modUtility.CenterForm()
		
		TxtName.Text = ItemName
		
	End Sub
	
	
	
	
	
	
    Private Sub FrmListItem_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing



    End Sub
End Class