Option Strict Off
Option Explicit On
Public Class FrmAbout
    Inherits System.Windows.Forms.Form
    'Bret 1/06/10 add Option explicit for upgrade

    Private Sub Command1_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles Command1.Click

        Me.Close()
        AppMain.frmAbout = Nothing
    End Sub

    Private Sub FrmAbout_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load

        Call modUtility.CenterForm(ParentForm)

        LblVersion.Text = GetVersion()
        LblCopyright.Text = "© 1996 - " & Now.Year.ToString() & " by Statline, A Division of MTF"

        lblComment.Text = My.Application.Info.Description
    End Sub
    Public Function Display() As Object

        Me.Show()

    End Function
    Private Sub Frm_Close(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.FormClosing
        AppMain.frmAbout = Nothing
        'Me.Dispose()
    End Sub


End Class