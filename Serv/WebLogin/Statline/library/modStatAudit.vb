Module modStatAudit
    Public Function AuditLogEventSave(ByVal pvLogEventId&, ByVal pvCallId&, ByVal pvAuditType%, ByVal pvStatEmployeeId&, Optional ByRef pvAuditLogId& = 0)

        On Error Resume Next

        Dim vQuery$
        Dim vReturn As DataSet
        Dim vResult

        vQuery = "EXEC spu_AuditLogEventSave " & _
                pvAuditType & "," & _
                pvLogEventId & "," & _
                pvCallId & "," & _
                pvStatEmployeeId & "," & _
                pvAuditLogId

        vResult = modODBC.Exec(vQuery, "TestTransaction", vReturn)

        'If vResult = SUCCESS Then
        ' If pvAuditType = AUDIT_UNKNOWN Then
        'pvAuditLogId = modUtility.GetReturnID(vReturn)
        'Else
        'pvAuditLogId = 0
        ' End If
        'End If

    End Function
End Module
