Option Strict Off
Option Explicit On
Friend Class FrmCustom1
    Inherits System.Windows.Forms.Form

    Public ServiceLevel As clsServiceLevel
    Public CurrentCall As clsCall

    Public CallingForm As String
    Public modalParent As Object
    Private Sub CboField_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles CboField.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)
        Dim Index As Short = CboField.GetIndex(eventSender)

        'Allow the delete key to clear the combo box
        Call modControl.AllowDelete(CboField(Index), KeyAscii)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub CmdCancel_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdCancel.Click

        Me.Close()

    End Sub

    Private Sub CmdOK_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdOK.Click

        Me.Hide()
        modalParent.Focus()

        If modalParent.Name = "FrmReferral" Or modalParent.Name = "FrmReferralView" Then

            modalParent.ReferralCall.CustomField1 = New String(TxtField(1).Text)
            modalParent.ReferralCall.CustomField2 = New String(TxtField(2).Text)
            modalParent.ReferralCall.CustomField3 = New String(TxtField(3).Text)
            modalParent.ReferralCall.CustomField4 = New String(TxtField(4).Text)
            modalParent.ReferralCall.CustomField5 = New String(TxtField(5).Text)
            modalParent.ReferralCall.CustomField6 = New String(TxtField(6).Text)
            modalParent.ReferralCall.CustomField7 = New String(TxtField(7).Text)
            modalParent.ReferralCall.CustomField8 = New String(TxtField(8).Text)
            modalParent.ReferralCall.CustomField9 = New String(CboField(9).Text)
            modalParent.ReferralCall.CustomField10 = New String(CboField(10).Text)
            modalParent.ReferralCall.CustomField11 = New String(CboField(11).Text)
            modalParent.ReferralCall.CustomField12 = New String(CboField(12).Text)
            modalParent.ReferralCall.CustomField13 = New String(CboField(13).Text)
            modalParent.ReferralCall.CustomField14 = New String(CboField(14).Text)
            modalParent.ReferralCall.CustomField15 = New String(CboField(15).Text)
            modalParent.ReferralCall.CustomField16 = New String(CboField(16).Text)
        End If
        Me.Close()

    End Sub

    Private Function NothingCheck(obj As Object) As String
        If obj Is Nothing Then
            NothingCheck = ""
        Else
            NothingCheck = obj.ToString()
        End If
    End Function


    Private Sub FrmCustom1_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load

        Dim vMaxTop As Short,
            vControl As System.Windows.Forms.Control,
            vAnyLeftVisible As Boolean = False,
            vAnyRightVisible As Boolean = False,
            fieldIndex As Integer

        'Set the alerts
        If ServiceLevel.AlertField1 <> "" Then
            modControl.SetRTFText(TxtAlert(0), ServiceLevel.AlertField1)
            vAnyLeftVisible = True
        Else
            Label(0).Visible = False
            TxtAlert(0).Visible = False
        End If

        If ServiceLevel.AlertField2 <> "" Then
            modControl.SetRTFText(TxtAlert(1), ServiceLevel.AlertField2)
            vAnyRightVisible = True
        Else
            Label(1).Visible = False
            TxtAlert(1).Visible = False
        End If

        'Load FieldLabel array
        Dim FieldLabel() As String = {
                                        String.Empty, 'add empty string for index of 0
                                        NothingCheck(ServiceLevel.FieldLabel1),
                                        NothingCheck(ServiceLevel.FieldLabel2),
                                        NothingCheck(ServiceLevel.FieldLabel3),
                                        NothingCheck(ServiceLevel.FieldLabel4),
                                        NothingCheck(ServiceLevel.FieldLabel5),
                                        NothingCheck(ServiceLevel.FieldLabel6),
                                        NothingCheck(ServiceLevel.FieldLabel7),
                                        NothingCheck(ServiceLevel.FieldLabel8),
                                        NothingCheck(ServiceLevel.FieldLabel9),
                                        NothingCheck(ServiceLevel.FieldLabel10),
                                        NothingCheck(ServiceLevel.FieldLabel11),
                                        NothingCheck(ServiceLevel.FieldLabel12),
                                        NothingCheck(ServiceLevel.FieldLabel13),
                                        NothingCheck(ServiceLevel.FieldLabel14),
                                        NothingCheck(ServiceLevel.FieldLabel15),
                                        NothingCheck(ServiceLevel.FieldLabel16)
                                    }
        'Load CustomField array
        Dim CustomField() As String = {
                                            String.Empty, 'add empty string for index of 0
                                            NothingCheck(CurrentCall.CustomField1),
                                            NothingCheck(CurrentCall.CustomField2),
                                            NothingCheck(CurrentCall.CustomField3),
                                            NothingCheck(CurrentCall.CustomField4),
                                            NothingCheck(CurrentCall.CustomField5),
                                            NothingCheck(CurrentCall.CustomField6),
                                            NothingCheck(CurrentCall.CustomField7),
                                            NothingCheck(CurrentCall.CustomField8),
                                            NothingCheck(CurrentCall.CustomField9),
                                            NothingCheck(CurrentCall.CustomField10),
                                            NothingCheck(CurrentCall.CustomField11),
                                            NothingCheck(CurrentCall.CustomField12),
                                            NothingCheck(CurrentCall.CustomField13),
                                            NothingCheck(CurrentCall.CustomField14),
                                            NothingCheck(CurrentCall.CustomField15),
                                            NothingCheck(CurrentCall.CustomField16)
                                        }
        'Load ListField array
        Dim ListField As Object() = New Object(16) {}
        If ServiceLevel.ListField9 IsNot Nothing Then
            ListField(9) = ServiceLevel.ListField9
        End If
        If ServiceLevel.ListField10 IsNot Nothing Then
            ListField(10) = ServiceLevel.ListField10
        End If
        If ServiceLevel.ListField11 IsNot Nothing Then
            ListField(11) = ServiceLevel.ListField11
        End If
        If ServiceLevel.ListField12 IsNot Nothing Then
            ListField(12) = ServiceLevel.ListField12
        End If
        If ServiceLevel.ListField13 IsNot Nothing Then
            ListField(13) = ServiceLevel.ListField13
        End If
        If ServiceLevel.ListField14 IsNot Nothing Then
            ListField(14) = ServiceLevel.ListField14
        End If
        If ServiceLevel.ListField15 IsNot Nothing Then
            ListField(15) = ServiceLevel.ListField15
        End If
        If ServiceLevel.ListField16 IsNot Nothing Then
            ListField(16) = ServiceLevel.ListField16
        End If

        'Set fields 1-8 (left column)
        For fieldIndex = 1 To 8

            'Make sure this array item exists and that it has the controls we need
            If FieldLabel.Count >= fieldIndex _
                And TxtField.Count >= fieldIndex _
                AndAlso LblField(fieldIndex) IsNot Nothing _
                And TxtField(fieldIndex) IsNot Nothing Then

                If FieldLabel(fieldIndex) = "" Then
                    LblField(fieldIndex).Visible = False
                    TxtField(fieldIndex).Visible = False
                Else
                    LblField(fieldIndex).Text = FieldLabel(fieldIndex)
                    TxtField(fieldIndex).Text = CustomField(fieldIndex)
                    vAnyLeftVisible = True
                End If

            End If
        Next

        'Set fields 9-16 (right column)
        For fieldIndex = 9 To 16

            'Make sure this array item exists and that it has the controls we need
            If FieldLabel(fieldIndex) IsNot Nothing _
                And LblField(fieldIndex) IsNot Nothing _
                And CboField(fieldIndex) IsNot Nothing _
                And ListField(fieldIndex) IsNot Nothing Then

                If FieldLabel(fieldIndex) = "" Then
                    LblField(fieldIndex).Visible = False
                    CboField(fieldIndex).Visible = False
                Else
                    LblField(fieldIndex).Text = FieldLabel(fieldIndex)
                    Call modControl.SetTextID(CboField(fieldIndex), ListField(fieldIndex))
                    If Not modControl.SelectText(CboField(fieldIndex), CustomField(fieldIndex)) Then
                        'Add the item to the current list
                        Call CboField(fieldIndex).Items.Add(CustomField(fieldIndex))
                    End If
                    vAnyRightVisible = True
                End If

            End If
        Next

        'Set the depth of the form
        'Find the visible control the farthest from the top
        For Each vControl In Controls
            If vControl.Visible = True Then
                If VB6.PixelsToTwipsY(vControl.Top) > vMaxTop Then
                    vMaxTop = VB6.PixelsToTwipsY(vControl.Top)
                End If
            End If
        Next vControl

        'Reset the form sizes
        Me.Height = VB6.TwipsToPixelsY(vMaxTop + 1050)
        CmdCancel.Top = VB6.TwipsToPixelsY(vMaxTop + 100)
        FrameLeft.Height = VB6.TwipsToPixelsY(vMaxTop + 400)
        FrameRight.Height = VB6.TwipsToPixelsY(vMaxTop + 400)

        'Check frame visibility
        If vAnyLeftVisible = False Then
            'Move everything right
            FrameLeft.Visible = False
            FrameRight.Left = VB6.TwipsToPixelsX(30)
            CmdOK.Left = VB6.TwipsToPixelsX(5970)
            CmdCancel.Left = VB6.TwipsToPixelsX(5970)
            Me.Width = VB6.TwipsToPixelsX(7450)
        End If

        If vAnyRightVisible = False Then
            'Move everything right
            FrameRight.Visible = False
            CmdOK.Left = VB6.TwipsToPixelsX(5970)
            CmdCancel.Left = VB6.TwipsToPixelsX(5970)
            Me.Width = VB6.TwipsToPixelsX(7450)
        End If

        Call modUtility.CenterForm()

    End Sub


    Public Function Display() As Integer

        Dim dialogResult As DialogResult = Me.ShowDialog()

    End Function


    Private Sub FrmCustom1_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing


        'Me.Dispose()
    End Sub
End Class