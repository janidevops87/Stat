Option Strict Off
Option Explicit On
Friend Class FrmVerifySex
	Inherits System.Windows.Forms.Form
	'Bret 1/06/10 add Option explicit for upgrade

    Public modalParent As Object
    Private Sub CboGender_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboGender.TextChanged
        Me.CmdOK.Enabled = True
    End Sub

    Private Sub CboGender_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboGender.SelectedIndexChanged
        Me.CmdOK.Enabled = True
    End Sub

    Private Sub CmdOK_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdOK.Click
        '************************************************************************************
        'Name: VerifySex
        'Date Created: 05/30/2007                         Created by: T.T
        'Release: 8.4                             Task: None
        'Description: verify save
        'Returns:
        'Params:
        'Stored Procedures: None
        '=============================================================================
        Dim vGenderLast As String = ""

        'ccarroll 09/17/2007 added vGenderList to compare change in value
        vGenderLast = modalParent.CboGender.Text

        modalParent.CboGender.SelectedIndex = Me.CboGender.SelectedIndex
        'modalParent.CboGender.SetFocus
        modalParent.vVerifySex = True

        If vGenderLast <> Me.CboGender.Text Then
            modalParent.VerifySexValidate()
        End If

        Me.Close()

    End Sub

    Private Sub FrmVerifySex_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load
        Dim dis As New Object
        Me.CmdOK.Enabled = False
        dis = modCloseBtn.EnableCloseButton(Me.Handle.ToInt32, False)
    End Sub
End Class