Option Strict Off
Option Explicit On
Friend Class FrmRotationCreate
    Inherits System.Windows.Forms.Form
    Public RotationName As String
    Public ModalParent As Object
    Public Function Display() As Object

        Dim dialogResult As DialogResult = Me.ShowDialog()

    End Function

    Private Sub CmdCancel_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdCancel.Click
        Me.Close()
    End Sub

    Private Sub CmdOK_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdOK.Click
        '*********************************************************************************
        'Name: cmdOK_Click
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.3]    Task: [Task created for]
        'Description: This function is the ok button to create a new rotation
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        Dim vQuery As String

        If Me.TxtRotationName.Text <> "" Then
            Me.RotationName = Me.TxtRotationName.Text
            vQuery = "SPI_NewRotation " & "'" & Me.RotationName & "'"
            Call modODBC.Exec(vQuery)

            Me.Close()
        End If

        ModalParent.ReloadRotationGroups()

    End Sub

    Private Sub frmRotationCreate_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load
        Call modUtility.CenterForm()
    End Sub
End Class