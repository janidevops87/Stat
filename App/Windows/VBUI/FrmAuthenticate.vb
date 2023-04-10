Option Strict Off
Option Explicit On
Friend Class FrmAuthenticate
	Inherits System.Windows.Forms.Form
    'Bret 1/06/10 add Option explicit for upgrade

    Private Sub FrmAuthenticate_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load

        'drh 09/24/03 Integrated Logon: Set the variable in the Main routine
        AppMain.Authorized = False
        Me.Close()

    End Sub
End Class