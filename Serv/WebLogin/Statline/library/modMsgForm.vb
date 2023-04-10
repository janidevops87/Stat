Module modMsgForm
    Public Function FormValidate(ByVal pvField$) As String

        On Error Resume Next

        FormValidate = "Please enter a valid value for the field:  " & pvField

    End Function
End Module
