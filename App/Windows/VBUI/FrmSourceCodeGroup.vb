Option Strict Off
Option Explicit On
Imports VB = Microsoft.VisualBasic
Public Class FrmSourceCodeGroup
    Inherits System.Windows.Forms.Form

    Dim SourceCode As clsSourceCode


    Private Sub CmdCancel_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdCancel.Click

        Me.Close()

    End Sub

    Private Sub CmdFrom_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdFrom.Click

        Dim I As Short

        For I = 1 To 6
            TxtFrom(I).Text = TxtFrom(0).Text
        Next I

    End Sub

    Private Sub CmdOK_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdOK.Click
        '************************************************************************************
        'Name: cmdOK_Click
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Saves SourceCode variables from form to DB
        'Returns: None
        'Params: None
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 12/8/04                          Changed by: Scott Plummer
        'Release #: 7.7.2                               Task: 312
        'Description:  Save new variable, NameUnAbbrev, to SourceCode object
        '====================================================================================
        '************************************************************************************
        On Error Resume Next

        Dim vReturn As Short

        If CmdOK.Text = "&Close" Then
            Me.Close()
        End If

        'Make sure the user wants to save
        vReturn = modMsgForm.FormSave

        If vReturn = MsgBoxResult.Cancel Then
            Exit Sub
        End If

        'Set the values of the object to the values of the form
        SourceCode.Name = TxtName.Text
        SourceCode.Description = TxtNote.Text
        SourceCode.DefaultAlert = TxtAlerts(0).Text
        SourceCode.LineCheckInstructions = TxtLineCheck.Text
        SourceCode.LineCheckInterval = CInt(TxtLineCheckInterval.Text)

        SourceCode.LineActiveStart1 = Me.TxtFrom(1).Text
        SourceCode.LineActiveStart2 = Me.TxtFrom(2).Text
        SourceCode.LineActiveStart3 = Me.TxtFrom(3).Text
        SourceCode.LineActiveStart4 = Me.TxtFrom(4).Text
        SourceCode.LineActiveStart5 = Me.TxtFrom(5).Text
        SourceCode.LineActiveStart6 = Me.TxtFrom(6).Text
        SourceCode.LineActiveStart7 = Me.TxtFrom(7).Text

        SourceCode.LineActiveEnd1 = Me.TxtTo(1).Text
        SourceCode.LineActiveEnd2 = Me.TxtTo(2).Text
        SourceCode.LineActiveEnd3 = Me.TxtTo(3).Text
        SourceCode.LineActiveEnd4 = Me.TxtTo(4).Text
        SourceCode.LineActiveEnd5 = Me.TxtTo(5).Text
        SourceCode.LineActiveEnd6 = Me.TxtTo(6).Text
        SourceCode.LineActiveEnd7 = Me.TxtTo(7).Text

        'Added for 7.7.2 to allow display of entire, unabbreviated
        'Source Code name.  12/8/04 - SAP
        SourceCode.NameUnAbbrev = Me.txtNameUnAbbrev.Text
        'T.T 01/04/2004 added to allow for Rotationsource codes
        SourceCode.SourceCodeRotationActive = 0
        SourceCode.SourceCodeRotationTrue = modConv.ChkValueToDBTrueValue(Me.chkRotating.CheckState)
        SourceCode.SourceCodeRotationAlias = Me.txtRotateExt.Text

        'Save the item
        Call SourceCode.Save()

        Me.Close()

    End Sub




    Private Sub CmdTo_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdTo.Click

        Dim I As Short

        For I = 1 To 6
            TxtTo(I).Text = TxtTo(0).Text
        Next I

    End Sub

    Private Sub FrmSourceCodeGroup_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load
        '************************************************************************************
        'Name: Form_Load
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Loads frmSourceCodeGroup
        'Returns: None
        'Params: None
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 12/8/04                          Changed by: Scott Plummer
        'Release #: 7.7.2                               Task: 312
        'Description:  Retrieve new variable, NameUnAbbrev, from SourceCode object
        '====================================================================================
        '************************************************************************************

        Call modUtility.CenterForm()

        'Set the form fields to the values of the object
        Me.TxtName.Text = SourceCode.Name
        'T.T 01/07/2005 removes string extension from sourcecode Name
        If SourceCode.SourceCodeRotationTrue = -1 Then
            Me.TxtName.Text = VB.Left(SourceCode.Name, InStr(1, SourceCode.Name, SourceCode.SourceCodeRotationAlias) - 1)
        End If
        Me.TxtNote.Text = SourceCode.Description
        Me.TxtAlerts(0).Text = SourceCode.DefaultAlert
        Me.TxtLineCheck.Text = SourceCode.LineCheckInstructions
        Me.TxtLineCheckInterval.Text = CStr(SourceCode.LineCheckInterval)

        Me.TxtFrom(1).Text = SourceCode.LineActiveStart1
        Me.TxtFrom(2).Text = SourceCode.LineActiveStart2
        Me.TxtFrom(3).Text = SourceCode.LineActiveStart3
        Me.TxtFrom(4).Text = SourceCode.LineActiveStart4
        Me.TxtFrom(5).Text = SourceCode.LineActiveStart5
        Me.TxtFrom(6).Text = SourceCode.LineActiveStart6
        Me.TxtFrom(7).Text = SourceCode.LineActiveStart7

        Me.TxtTo(1).Text = SourceCode.LineActiveEnd1
        Me.TxtTo(2).Text = SourceCode.LineActiveEnd2
        Me.TxtTo(3).Text = SourceCode.LineActiveEnd3
        Me.TxtTo(4).Text = SourceCode.LineActiveEnd4
        Me.TxtTo(5).Text = SourceCode.LineActiveEnd5
        Me.TxtTo(6).Text = SourceCode.LineActiveEnd6
        Me.TxtTo(7).Text = SourceCode.LineActiveEnd7

        'Added for 7.7.2 to allow display of entire, unabbreviated
        'Source Code name.  12/8/04 - SAP
        Me.txtNameUnAbbrev.Text = SourceCode.NameUnAbbrev
        'T.T 01/06/2005 to fill in the rotation info
        Me.chkRotating.CheckState = modConv.DBTrueValueToChkValue(SourceCode.SourceCodeRotationTrue)
        Me.txtRotateExt.Text = SourceCode.SourceCodeRotationAlias

    End Sub

    Public Function Display(Optional ByRef pvSourceCode As clsSourceCode = Nothing, Optional ByRef pvReadOnly As Boolean = False) As Object

        SourceCode = pvSourceCode

        If Not IsNothing(pvReadOnly) Then
            If pvReadOnly Then
                CmdOK.Text = "&Close"
                CmdCancel.Visible = False
                TxtName.ReadOnly = True
                TxtNote.ReadOnly = True
            End If
        End If

        Me.ShowDialog()

    End Function


    Private Sub FrmSourceCodeGroup_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing
        Dim vFrmSourceCode As FrmSourceCode = New FrmSourceCode
        vFrmSourceCode = Nothing

    End Sub








    Private Sub TxtLineCheckInterval_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtLineCheckInterval.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        KeyAscii = modMask.NumMask(KeyAscii, 8, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtLineCheckInterval_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtLineCheckInterval.Leave

        Dim I As Short

        If CDbl(TxtLineCheckInterval.Text) = 0 Or TxtLineCheckInterval.Text = "" Then

            'Clear and disable the acitivity period controls
            For I = 1 To 7
                TxtFrom(I).Text = ""
                TxtFrom(I).Enabled = False
                TxtTo(I).Text = ""
                TxtTo(I).Enabled = False
            Next I

            For I = 14 To 34
                Lable(I).Enabled = False
            Next I

            CmdFrom.Enabled = False
            CmdTo.Enabled = False

        Else

            'Clear and disable the acitivity period controls
            For I = 1 To 7
                TxtFrom(I).Text = ""
                TxtFrom(I).Enabled = True
                TxtTo(I).Text = ""
                TxtTo(I).Enabled = True
            Next I

            For I = 14 To 34
                Lable(I).Enabled = True
            Next I

            CmdFrom.Enabled = True
            CmdTo.Enabled = True

        End If

    End Sub


    Private Sub TxtName_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtName.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub
End Class