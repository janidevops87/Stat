Option Strict Off
Option Explicit On
Friend Class FrmServiceLevelGroup
    Inherits System.Windows.Forms.Form

    Public ServiceLevel As clsServiceLevel

    Private Sub CmdCancel_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdCancel.Click

        Me.Close()

    End Sub


    Private Sub CmdOK_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdOK.Click

        On Error GoTo localError

        Dim vReturn As Short

        'Make sure the user wants to save

        vReturn = modMsgForm.FormSave

        If vReturn = MsgBoxResult.Cancel Then
            Exit Sub
        End If

        'Validate the data
        If Not modStatValidate.ServiceLevelGroup(Me) Then
            Exit Sub
        End If

        Call Me.GetData()
        Me.ServiceLevel.CheckDupName = True
        Call ServiceLevel.Save()

        Me.Close()

        Exit Sub

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        Resume Next

    End Sub

    Private Sub FrmServiceLevelGroup_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load

        Call modUtility.CenterForm()

        Me.TxtName.Text = Me.ServiceLevel.Name

    End Sub






    Private Sub FrmServiceLevelGroup_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing



    End Sub




    Public Sub GetData()

        On Error GoTo localError

        Me.ServiceLevel.Name = Me.TxtName.Text

        '10/15/01 drh
        If Me.ServiceLevel.ID = -1 Then
            Me.ServiceLevel.CheckRegistryMode = CheckRegistryMode.NoRegistry
        End If

        Exit Sub

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        Resume Next

    End Sub

    Public Function Display(ByRef ServiceLevel As clsServiceLevel) As Object

        Me.ServiceLevel = ServiceLevel

        Me.ShowDialog()

    End Function
End Class