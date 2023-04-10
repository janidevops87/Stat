Option Strict Off
Option Explicit On
Imports Statline.Stattrac.Windows.UI

Module modMsgForm

    Public Function DuplicateName() As Object

        Dim vText As String = ""

        vText = "This name already exists for this organization. You may not save this person."

        DuplicateName = MsgBox(vText, MsgBoxStyle.Exclamation, "Duplicate Name")

    End Function

    Public Function DuplicateUser() As Object

        Dim vText As String = ""

        vText = "This UserId already exists. You may not save this person."

        DuplicateUser = MsgBox(vText, MsgBoxStyle.Exclamation, "Duplicate UserId")

    End Function
    Public Function LoginFail() As Object

        Dim vText As String = ""

        vText = "The login failed. Please check your user ID and password."

        LoginFail = MsgBox(vText, MsgBoxStyle.Exclamation, "Login Failed")

    End Function

    Public Function FormSave() As Short

        'FormSave = MsgBox("Are you sure you want to Save?", vbOKCancel + vbExclamation, "Save")
        FormSave = MsgBoxResult.Ok 'bret 01/06/10 vbOK

    End Function

    Public Function FormCancel() As Object

        FormCancel = BaseMessageBox.ShowYesNo("Are you sure you want to Cancel?", "Cancel")

    End Function


    Public Function FormClose() As Object

        FormClose = MsgBox("Do you want to Close the form?", MsgBoxStyle.YesNo + MsgBoxStyle.Question, "Close")

    End Function



    Public Function FormValidate(ByRef pvField As String, Optional ByRef pvControl As Object = Nothing) As Object

        On Error Resume Next

        Dim vText As String = ""

        vText = "Please enter a valid value for the field:  " & pvField

        If Not IsNothing(pvControl) Then
            pvControl.SetFocus()
        End If

        FormValidate = MsgBox(vText, MsgBoxStyle.Exclamation, "Validation Error")

    End Function



    Public Function MissingReport() As Object

        Dim vText As String = ""

        vText = "The the report directory has not been set or the selected report is missing from the directory.  " & Chr(13) & "Please set the report directory or contact the system administrator to locate the report.  "

        MissingReport = MsgBox(vText, MsgBoxStyle.Exclamation + MsgBoxStyle.OKOnly, "Missing Report File")

    End Function

    Public Function InvalidHeartBeatVentCombo() As Object

        InvalidHeartBeatVentCombo = MsgBox("If NO Heartbeat, Vent Status CANNOT be Currently. Reverify status with caller.", MsgBoxStyle.Exclamation, "Confirm Values")

    End Function
End Module