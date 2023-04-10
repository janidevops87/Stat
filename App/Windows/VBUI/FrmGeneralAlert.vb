Option Strict Off
Option Explicit On
Public Class FrmGeneralAlert
    Inherits System.Windows.Forms.Form

    Dim GeneralAlert As clsGeneralAlert


    Private Sub CmdCancel_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdCancel.Click

        Me.Close()

    End Sub

    Private Sub CmdOK_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdOK.Click

        On Error Resume Next

        Dim vReturn As Short
        Dim vAttribute As clsGeneralAlert.AttributeName
        Dim vTimeZoneDif As Short

        vTimeZoneDif = modStatQuery.QueryTimeZoneDif(AppMain.ParentForm.TimeZone)

        If CmdOK.Text = "&Close" Then
            Me.Close()
            Exit Sub
        End If

        'Make sure the user wants to save
        vReturn = modMsgForm.FormSave

        If vReturn = MsgBoxResult.Cancel Then
            Exit Sub
        End If

        'Set the values of the object to the values of the form
        GeneralAlert.Expires = DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, modConv.TextToDate(TxtExpires.Text))
        GeneralAlert.Organization = TxtName.Text
        GeneralAlert.Message = TxtNote.Text
        GeneralAlert.CreatedByID = AppMain.ParentForm.PersonID
        GeneralAlert.OrganizationId = AppMain.ParentForm.WebUserOrg


        'Validate the data
        If Not GeneralAlert.Validate(vAttribute) Then
            Select Case vAttribute
                Case clsGeneralAlert.AttributeName.gaExpires
                    MsgBox("Please enter a valid date.")
                    Call TxtExpires.Focus()
            End Select
            Exit Sub
        End If

        'Save the item
        Call GeneralAlert.Save()

        Me.Close()

    End Sub
    Private Sub FrmGeneralAlert_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load


        Call modUtility.CenterForm()

        'bjk 05/07/02 removed declaration of vTimeZone and call to TimeZone Function.
        'bjk 07/15/02
        'Dim vTimeZoneDif%
        'vTimeZoneDif = modStatQuery.QueryTimeZoneDif(AppMain.ParentForm.TimeZone)


        If GeneralAlert.ID = 0 Then
            'Default the date a now
            GeneralAlert.Expires = DateAdd(Microsoft.VisualBasic.DateInterval.Hour, 8, Now)
        End If

        'Set the form fields to the values of the object
        'bjk 05/07/02 removed adjustment for time zone
        'Me.TxtExpires.Text = Format(DateAdd("h", vTimeZoneDif, GeneralAlert.Expires), "mm/dd/yy hh:mm")
        Me.TxtExpires.Text = VB6.Format(GeneralAlert.Expires, "mm/dd/yy hh:mm")
        Me.TxtName.Text = GeneralAlert.Organization
        Me.TxtNote.Text = GeneralAlert.Message
        'Me.LblCreatedBy.Text = GeneralAlert.CreatedBy
        If GeneralAlert.CreatedBy = Nothing Then
            Me.LblCreatedBy.Text = AppMain.ParentForm.StatEmployeeName
        Else
            Me.LblCreatedBy.Text = GeneralAlert.CreatedBy
        End If

    End Sub


    Public Function Display(Optional ByRef pvGeneralAlert As clsGeneralAlert = Nothing, Optional ByRef pvReadOnly As Boolean = False) As Object

        GeneralAlert = pvGeneralAlert
        If Not IsNothing(pvReadOnly) Then
            If pvReadOnly Then
                CmdOK.Text = "&Close"
                CmdCancel.Visible = False
                TxtExpires.ReadOnly = True
                TxtName.ReadOnly = True
                TxtNote.ReadOnly = True
                LblCreatedBy.Text = GeneralAlert.CreatedBy
            Else
                LblCreatedBy.Text = AppMain.ParentForm.StatEmployeeName
            End If
        End If

        Me.ShowDialog()

    End Function






    Private Sub FrmGeneralAlert_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing

        Me.GeneralAlert = Nothing
        AppMain.frmGeneralAlert = Nothing
        'Me.Dispose()

    End Sub





    Private Sub TxtExpires_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtExpires.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtExpires_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtExpires.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        KeyAscii = modMask.DateTimeMask(KeyAscii, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtName_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtName.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub
End Class