Module modStatSave
    Public Function SaveLogEvent&(ByVal pvForm As wfLogEvent) ', Optional pvOther, Optional pvNote)

        On Error Resume Next

        Dim vValues$
        Dim vQuery
        Dim vReturn%
        Dim vLogEventID$
        Dim vResults As DataSet
        Dim vTimeZoneDif%
        Dim vArraySize%


        'vTimeZoneDif = modStatQuery.QueryTimeZoneDif(ParentForm.TimeZone)

        On Error Resume Next

        'Get the log data
        Dim vParams(14)
        Dim vFields(14)


        vParams(0) = pvForm.CallId
        vParams(1) = pvForm.ContactLogEventTypeID
        vParams(2) = pvForm.cboName.SelectedItem.Text
        vParams(3) = pvForm.txtContactPhone.Text
        vParams(4) = pvForm.txtContactOrg.Text
        vParams(5) = pvForm.txtContactDesc.Text
        vParams(5) = Replace(pvForm.txtContactDesc.Text, pvForm.txtCalloutDate.Text, Format(DateAdd("h", -pvForm.WebUserOrganizationTimeZoneDiff, pvForm.txtCalloutDate.Text), "MM/dd/yy  HH:mm"))
        vParams(6) = modConv.TextToLng(pvForm.ContactEmployeeID)
        If IsDate(pvForm.txtContactDate.Text) Then
            vParams(7) = DateAdd("h", -pvForm.WebUserOrganizationTimeZoneDiff, pvForm.txtContactDate.Text)
        Else
            vParams(7) = ""
        End If
        vParams(8) = pvForm.CallbackPending
        vParams(9) = pvForm.OrganizationId
        vParams(10) = pvForm.ScheduleGroupID
        vParams(11) = pvForm.PersonID
        vParams(12) = pvForm.PhoneID
        If pvForm.chkConfirmed.Checked Then
            vParams(13) = 1
        Else
            vParams(13) = pvForm.chkConfirmed.Checked()
        End If
        If IsDate(pvForm.txtCalloutDate.Text) Then
            vParams(14) = DateAdd("h", -pvForm.WebUserOrganizationTimeZoneDiff, pvForm.txtCalloutDate.Text)
        Else
            vParams(14) = ""
        End If



        'Specify the field names
        vFields(0) = "CallID"
        vFields(1) = "LogEventTypeID"
        vFields(2) = "LogEventName"
        vFields(3) = "LogEventPhone"
        vFields(4) = "LogEventOrg"
        vFields(5) = "LogEventDesc"
        vFields(6) = "StatEmployeeID"
        vFields(7) = "LogEventDateTime"
        vFields(8) = "LogEventCallbackPending"
        vFields(9) = "OrganizationID"
        vFields(10) = "ScheduleGroupID"
        vFields(11) = "PersonID"
        vFields(12) = "PhoneID"
        vFields(13) = "LogEventContactConfirmed"
        vFields(14) = "LogEventCalloutDateTime"

        'Build and execute the query

        'The record is new and should be inserted.
        vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)

        vQuery = "INSERT INTO LogEvent (" & vValues & ")"

        vReturn = modODBC.Exec(vQuery, AppMain.vDataSource, vResults)

        'If vReturn = SUCCESS Then

        SaveLogEvent = modUtility.GetReturnID(vResults)

        'TASK: 10/03/02 drh - Save Referral Audit Info
        'Dim vTempLogEventId&    'Need Non-variant variable to pass as argument
        'vTempLogEventId = vResults(0, 0)
        'Call modStatAudit.AuditLogEventSave(SaveLogEvent, pvForm.CallId, AUDIT_CREATE, pvForm.ContactEmployeeID)
        'Else
        'SaveLogEvent = SQL_ERROR
        'End If

    End Function

    Public Function SavePendingEvent(ByVal pvForm As wfLogEvent)

        On Error Resume Next

        Dim vValues$
        Dim vQuery$
        Dim vResults As DataSet

        'Get the call data
        Dim vParams(0)

        vParams(0) = pvForm.CallbackPending

        'Specify the field names
        Dim vFields(0)

        vFields(0) = "LogEventCallbackPending"

        'Build and execute the query
        vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

        vQuery = "UPDATE LogEvent SET " & _
        vValues & " WHERE " & _
        "LogEvent.LogEventID = " & pvForm.LogEventID

        Call modODBC.Exec(vQuery, AppMain.vDataSource, vResults)

        'TASK: 10/03/02 drh - Save Log Event Audit Info
        Call modStatAudit.AuditLogEventSave(pvForm.LogEventID, pvForm.CallId, AUDIT_MODIFY, pvForm.ContactEmployeeID, pvForm.AuditLogId)


    End Function

End Module
