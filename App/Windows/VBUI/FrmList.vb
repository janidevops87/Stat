Option Strict Off
Option Explicit On
Friend Class FrmList
	Inherits System.Windows.Forms.Form
	
	Dim pItemID As Integer
	
	Private Sub CmdOK_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdOK.Click
		
		Me.Close()
		
	End Sub

    Private Sub FrmList_Activated(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Activated

        Call modControl.SelectFirst(LstSelect)

    End Sub

    Private Sub FrmList_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load

        Call modControl.SelectFirst(LstSelect)

    End Sub



    Public Function Display() As Object

        Me.ShowDialog()

        Display = Me.ItemID

    End Function


    Public Property ItemID() As Object
        Get

            ItemID = pItemID

        End Get
        Set(ByVal Value As Object)

            pItemID = Value

        End Set
    End Property

    Private Sub FrmList_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing



    End Sub


    Private Sub LstSelect_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstSelect.SelectedIndexChanged

        Me.ItemID = modControl.GetID(LstSelect)

    End Sub
End Class