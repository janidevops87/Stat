Module modStatQuery
    Public Function QueryLogEventType%(ByRef pvForm As wfLogEvent, ByRef pvDataSet As DataSet)

        On Error Resume Next

        Dim vQuery
        Dim vResults As DataSet
        Dim vWhere$
        Dim vEventTypeList
        Dim i%
        Dim j%

        'Get the event type list
        vEventTypeList = pvForm.LogEventTypeList

        If vEventTypeList(0) = ALL_TYPES Then

            'Set the query statement
            '04/10/03 drh - Added WHERE Clause to prevent Fax and Secondary events
            vQuery = "SELECT LogEventTypeID, LogEventTypeName FROM LogEventType WHERE LogEventTypeId NOT IN(15,16,18,19) ORDER BY LogEventTypeName;"

        Else

            'Build the where clause
            vWhere = "WHERE LogEventTypeID = "
            If UBound(vEventTypeList) = 0 Then
                vWhere = vWhere & vEventTypeList(0) & ";"
            Else
                For i = 0 To UBound(vEventTypeList) - 1
                    vWhere = vWhere & vEventTypeList(i) & " OR LogEventTypeID = "
                    j = i
                Next i
                vWhere = vWhere & vEventTypeList(j + 1) & ";"
            End If

            'Set the query statement
            vQuery = "SELECT LogEventTypeID, LogEventTypeName FROM LogEventType " & vWhere

        End If

        'Execute the query
        QueryLogEventType = modODBC.Exec(vQuery, AppMain.vDataSource, vResults)

        pvDataSet = vResults

        'Set the data
        Call modControl.SetTextID(pvForm.cboContactEventType, vResults, True, False, IIf(pvForm.FormState = NEW_EVENT, True, False))

    End Function

    Public Function QueryLocationPerson%(ByVal pvForm As wfLogEvent, Optional ByVal DefaultOrgId As Integer = -1)

        On Error Resume Next

        Dim vQuery$
        Dim vResult As DataSet
        Dim vReturnCode%
        Dim vOrgId As Integer

        If DefaultOrgId <= 0 Then
            vOrgId = pvForm.OrganizationId
        Else
            vOrgId = DefaultOrgId
        End If
        'Check if there is a match for the location
        vQuery = "SELECT Person.PersonID, Person.PersonFirst+RTRIM(' '+(ISNULL(PersonMI,'')))+' '+PersonLast "

        vQuery = vQuery & "FROM Person " & _
        "WHERE Person.OrganizationID = " & vOrgId & " AND Person.Inactive <> 1 "

        QueryLocationPerson = modODBC.Exec(vQuery, AppMain.vDataSource, vResult)

        'FSProj drh 6/15/02 - Control depends on form
        'If pvForm.Name = "FrmReferralView" Then
        Call modControl.SetTextID(pvForm.cboName, vResult, True, False, IIf(pvForm.FormState = NEW_EVENT, True, False))
        'Else
        '    Call modControl.SetTextID(pvForm.CboName, vResult)
        'End If

        'If QueryLocationPerson = SUCCESS Then
        'Indicate matching locations were found.
        'Exit Function
        'Else
            'If there is no match
            'then clear the list
            'and set the query to false

            'FSProj drh 6/15/02 - Control depends on form
            'If pvForm.Name = "FrmReferralView" Then
        ' pvForm.cboName.Items.Clear()
            'Else
            '    pvForm.CboName.Clear()
            'End If
        'End If

    End Function

    Public Function QueryUserName$(ByVal UserId&, ByVal UserType As Integer)

        On Error Resume Next

        Dim vQuery$
        Dim vResult As DataSet
        Dim vReturnCode%

        'Build the query
        vQuery = "SELECT p.PersonId, p.PersonFirst+RTRIM(' '+(ISNULL(p.PersonMI,'')))+' '+p.PersonLast " & _
        "FROM Person p "

        Select Case UserType
            Case 1
                'WebPerson
                vQuery = vQuery & "JOIN WebPerson wp ON wp.PersonId = p.PersonId " & _
                "WHERE wp.WebPersonID = " & UserId
            Case 2
                'Person
                vQuery = vQuery & "WHERE p.PersonID = " & UserId
            Case 3
                'StatEmployee
                vQuery = vQuery & "JOIN StatEmployee se ON se.PersonId = p.PersonId " & _
                "WHERE se.WebPersonID = " & UserId
        End Select

        Call modODBC.Exec(vQuery, AppMain.vDataSource, vResult)

        'Get the data
        Dim vTable As DataTable
        Dim vRow As DataRow

        If vResult.Tables.Count > 0 Then
            vTable = vResult.Tables(0)
            If vTable.Rows.Count > 0 Then
                vRow = vTable.Rows(0)
                QueryUserName = vRow(vTable.Columns(1))
            End If
        End If

    End Function

    Public Function QueryStatEmployeeId&(ByVal UserId&, ByVal UserType As Integer)

        On Error Resume Next

        Dim vQuery$
        Dim vResult As DataSet
        Dim vReturnCode%

        'Build the query
        vQuery = "SELECT se.StatEmployeeId FROM StatEmployee se "

        Select Case UserType
            Case 1
                'WebPerson
                vQuery = vQuery & "JOIN Person p ON p.PersonId = se.PersonId " & _
                "JOIN WebPerson wp ON wp.PersonId = p.PersonId " & _
                "WHERE wp.WebPersonID = " & UserId
            Case 2
                'Person
                vQuery = vQuery & "JOIN Person p ON p.PersonId = se.PersonId " & _
                "WHERE p.PersonID = " & UserId
        End Select

        Call modODBC.Exec(vQuery, AppMain.vDataSource, vResult)

        'Get the data
        Dim vTable As DataTable
        Dim vRow As DataRow

        If vResult.Tables.Count > 0 Then
            vTable = vResult.Tables(0)
            If vTable.Rows.Count > 0 Then
                vRow = vTable.Rows(0)
                QueryStatEmployeeId = vRow(vTable.Columns(0))
            End If
        End If

    End Function

    Public Function QueryPendingEventsGrid%(ByRef pvForm As FrmLogEventList, ByRef pvDataSet As DataSet)

        On Error Resume Next

        Dim vQuery$
        Dim vPendingList As DataSet

        'Get the pending page events
        vQuery = "SELECT LogEvent.LogEventID, LogEventType.LogEventTypeName as LogEventTypeName, " & _
        "ISNULL(LogEvent.LogEventOrg,'') + ' - ' + ISNULL(LogEvent.LogEventName,'') as LogEventOrg_Name, LogEvent.LogEventTypeId " & _
        "FROM LogEvent " & _
        "JOIN LogEventType ON LogEventType.LogEventTypeID = LogEvent.LogEventTypeID " & _
        "WHERE LogEvent.LogEventCallbackPending=-1 " & _
        "AND LogEvent.CallID = " & pvForm.CallId & " " & _
        "ORDER BY LogEvent.LogEventDateTime DESC;"

        QueryPendingEventsGrid = modODBC.Exec(vQuery, AppMain.vDataSource, vPendingList)

        'If QueryPendingEventsGrid = SUCCESS Then

        pvDataSet = vPendingList

        'End If

    End Function

    Public Function QueryOpenLogEventGrid%(ByRef pvForm As FrmLogEventList, ByRef pvDataSet As DataSet)

        On Error Resume Next

        Dim vQuery$
        Dim vReturn As DataSet

        vQuery = "SELECT LogEventID, " & _
        "DATEADD(hh, " & pvForm.WebUserOrganizationTimeZoneDiff & ", LogEventDateTime) AS LogEventDateTime, " & _
        "LogEventTypeName, LogEventName, LogEventOrg, " & _
        "PersonFirst + ' ' + PersonLast AS LogEventBy, " & _
        "0 AS RowNumber, " & _
        "'' as DateTimeString, " & _
        "LogEvent.LogEventTypeId " & _
        "FROM LogEvent " & _
        "JOIN LogEventType ON LogEventType.LogEventTypeID = LogEvent.LogEventTypeID " & _
        "JOIN StatEmployee ON LogEvent.StatEmployeeID = StatEmployee.StatEmployeeID " & _
        "JOIN Person ON Person.PersonID = StatEmployee.PersonID " & _
        "WHERE LogEvent.CallID = " & pvForm.CallId & _
        " ORDER BY LogEventDateTime ASC, LogEventTypeName ASC;"

        QueryOpenLogEventGrid = modODBC.Exec(vQuery, AppMain.vDataSource, vReturn)

        'If QueryOpenLogEventGrid = SUCCESS Then
        pvDataSet = vReturn

        'Populate the Dropdown
        'Set the data
        Dim vTable As DataTable
        Dim vRow As DataRow
        Dim vListItem As ListItem
        Dim i%
        Dim vDateTime As Date
        Dim sDateTime$

        i = 1
        For Each vTable In pvDataSet.Tables
            For Each vRow In vTable.Rows
                vTable.Columns("RowNumber").ReadOnly = False
                vRow(vTable.Columns("RowNumber")) = i
                i = i + 1

                vTable.Columns("DateTimeString").ReadOnly = False
                If IsDate(vRow(vTable.Columns("LogEventDateTime"))) Then
                    vDateTime = vRow(vTable.Columns("LogEventDateTime"))
                Else
                    vDateTime = ""
                End If
                sDateTime = Format(vDateTime, "MM/dd/yy    HH:mm")
                vRow(vTable.Columns("DateTimeString")) = sDateTime
            Next
        Next

        'Call modControl.SetListViewRows(vReturn, True, pvForm.LstViewLogEvent, True)
        pvForm.TxtEventDesc.Text = ""
        ' End If

    End Function

    Public Function QueryLogEvent%(ByRef pvForm As Object, ByRef pvDataSet As DataSet)

        On Error Resume Next

        Dim vQuery$
        Dim vParams As DataSet

        'On Error Resume Next
        If pvForm.GetType.Name = "wfLogEvent_aspx" Then

            'Get the record that matches the passed in log event ID
            vQuery = "SELECT LogEvent.LogEventID, " & _
            "DATEADD(hh, " & pvForm.WebUserOrganizationTimeZoneDiff & ", LogEventDateTime) AS 'LogEventDateTime', " & _
            "LogEvent.LogEventTypeID, " & _
            "LogEvent.LogEventName, LogEvent.LogEventPhone, LogEvent.LogEventOrg, LogEvent.LogEventDesc, " & _
            "StatEmployee.StatEmployeeID, LogEvent.LogEventCallbackPending, LogEvent.OrganizationID, " & _
            "LogEvent.ScheduleGroupID, LogEvent.PersonID, LogEvent.PhoneID, LogEventContactConfirmed, " & _
            "DATEADD(hh, " & pvForm.WebUserOrganizationTimeZoneDiff & ", LogEventCalloutDateTime) AS 'LogeEventCalloutDateTime' " & _
            "FROM LogEvent " & _
            "JOIN LogEventType ON LogEventType.LogEventTypeID = LogEvent.LogEventTypeID " & _
            "JOIN StatEmployee ON LogEvent.StatEmployeeID = StatEmployee.StatEmployeeID " & _
            "WHERE LogEvent.LogEventID = " & pvForm.LogEventID & " "

            Call modODBC.Exec(vQuery, AppMain.vDataSource, vParams)

            pvDataSet = vParams

        ElseIf pvForm.GetType.Name = "FrmLogEventList_aspx" Then

            'This query is used to provide a new event that defaults the data
            'of an event the user wishes to duplicate.
            vQuery = "SELECT LogEvent.LogEventTypeID, " & _
            "LogEvent.LogEventName, LogEvent.LogEventPhone, LogEvent.LogEventOrg, LogEvent.OrganizationID, " & _
            "LogEvent.ScheduleGroupID, LogEvent.PersonID, LogEvent.PhoneID " & _
            "FROM LogEvent " & _
            "WHERE LogEvent.LogEventID = " & pvForm.CurrentLogEventID & " "

            Call modODBC.Exec(vQuery, AppMain.vDataSource, vParams)

            'Set the event data
            Dim vTable As DataTable
            Dim vRow As DataRow

            If vParams.Tables.Count > 0 Then
                vTable = vParams.Tables(0)

                If vTable.Rows.Count > 0 Then
                    vRow = vTable.Rows(0)

                    'pvForm.Session("FrmLogEvent.DefaultContactType") = DBNullToText(vRow(vTable.Columns(0)))
                    AppMain.mainstate.DefaultContactType = DBNullToText(vRow(vTable.Columns(0)))
                    'pvForm.Session("FrmLogEvent.DefaultContactName") = DBNullToText(vRow(vTable.Columns(1)))
                    AppMain.mainstate.DefaultContactName = DBNullToText(vRow(vTable.Columns(1)))
                    'pvForm.Session("FrmLogEvent.DefaultContactPhone") = DBNullToText(vRow(vTable.Columns(2)))
                    AppMain.mainstate.DefaultcontactPhone = DBNullToText(vRow(vTable.Columns(2)))
                    'pvForm.Session("FrmLogEvent.DefaultOrganization") = DBNullToText(vRow(vTable.Columns(3)))
                    AppMain.mainstate.DefaultOrganization = DBNullToText(vRow(vTable.Columns(3)))

                    'pvForm.Session("FrmLogEvent.OrganizationId") = DBNullToText(vRow(vTable.Columns(4)))
                    AppMain.mainstate.DefaultOrganizationID = DBNullToText(vRow(vTable.Columns(4)))
                    'pvForm.Session("FrmLogEvent.ScheduleGroupID") = DBNullToText(vRow(vTable.Columns(5)))
                    AppMain.mainstate.ScheduleGroupID = DBNullToText(vRow(vTable.Columns(5)))
                    'pvForm.Session("FrmLogEvent.PersonID") = DBNullToText(vRow(vTable.Columns(6)))
                    AppMain.mainstate.PersonID = DBNullToText(vRow(vTable.Columns(6)))
                    'pvForm.Session("FrmLogEvent.PhoneID") = DBNullToText(vRow(vTable.Columns(7)))
                    AppMain.mainstate.PhoneID = DBNullToText(vRow(vTable.Columns(7)))
                End If
            End If
        End If

    End Function

    Public Function QueryReferralInfo%(ByRef pvForm As FrmLogEventList, ByRef pvDataSet As DataSet)

        On Error Resume Next

        Dim vQuery
        Dim vResults As DataSet

        vQuery = "SELECT c.CallNumber, r.ReferralCallerOrganizationId, o.OrganizationName, p.PersonFirst + ' ' + p.PersonLast as CallerName, '(' + ph.PhoneAreaCode + ') ' + ph.PhonePrefix + '-' + ph.PhoneNumber as CallerPhone " & _
                 "FROM Call c " & _
                 "JOIN Referral r ON c.CallId = r.CallId " & _
                 "LEFT JOIN Person p ON r.ReferralCallerPersonID = p.PersonId " & _
                 "LEFT JOIN Phone ph ON r.ReferralCallerPhoneID = ph.PhoneId " & _
                 "LEFT JOIN Organization o ON r.ReferralCallerOrganizationID = o.OrganizationId " & _
                 "WHERE c.CallId = " & pvForm.CallId & ";"

        'Execute the query
        QueryReferralInfo = modODBC.Exec(vQuery, AppMain.vDataSource, vResults)

        ' If QueryReferralInfo = SUCCESS Then
        pvDataSet = vResults

        'Set the event data
        Dim vTable As DataTable
        Dim vRow As DataRow

        If vResults.Tables.Count > 0 Then
            vTable = vResults.Tables(0)

            If vTable.Rows.Count > 0 Then
                vRow = vTable.Rows(0)

                pvForm.CallNumber = DBNullToText(vRow(vTable.Columns(0)))
                pvForm.OrganizationId = DBNullToLng(vRow(vTable.Columns(1)))
                pvForm.CboOrganization_Text = DBNullToText(vRow(vTable.Columns(2)))
                pvForm.CboName_Text = DBNullToText(vRow(vTable.Columns(3)))
                pvForm.TxtPhone_Text = DBNullToText(vRow(vTable.Columns(4)))
            Else
                QueryReferralInfo = NO_DATA
            End If
        End If
        ' End If

    End Function

    Public Function QueryLogEventTypeID%(ByVal pvLogEventId&, ByRef prLogEventTypeID&)

        On Error Resume Next

        Dim vQuery
        Dim vParams As DataSet

        vQuery = "SELECT LogEventTypeID FROM LogEvent " & _
        "WHERE LogEventID = " & pvLogEventId & ";"

        QueryLogEventTypeID = modODBC.Exec(vQuery, AppMain.vDataSource, vParams)

        'Set the call data
        ' If QueryLogEventTypeID = SUCCESS Then
        'Set the event data
        Dim vTable As DataTable
        Dim vRow As DataRow

        If vParams.Tables.Count > 0 Then
            vTable = vParams.Tables(0)

            If vTable.Rows.Count > 0 Then
                vRow = vTable.Rows(0)

                prLogEventTypeID = DBNullToLng(vRow(vTable.Columns(0)))
            Else
                QueryLogEventTypeID = NO_DATA
            End If
        End If
        'End If

    End Function

    Public Function QueryOrganizationTimeZone%(ByVal pvForm As FrmLogEventList)

        On Error Resume Next

        Dim vQuery
        Dim vParams$()
        Dim vResults As DataSet

        vQuery = "SELECT Organization.OrganizationTimeZone " & _
        "FROM Organization " & _
        "WHERE Organization.OrganizationID = " & pvForm.WebUserOrganizationId & ";"

        QueryOrganizationTimeZone = modODBC.Exec(vQuery, AppMain.vDataSource, vResults)

        'Set the time zone data
        Dim vTable As DataTable
        Dim vRow As DataRow

        If vResults.Tables.Count > 0 Then
            vTable = vResults.Tables(0)

            If vTable.Rows.Count > 0 Then
                vRow = vTable.Rows(0)

                pvForm.WebUserOrganizationTimeZone = DBNullToText(vRow(vTable.Columns(0)))
            Else
                QueryOrganizationTimeZone = NO_DATA
            End If
        End If

    End Function

    Public Function QueryTimeZoneDif%(ByVal timeZoneName$, Optional ByVal setDate As String = "")
        On Error GoTo localError

        Dim vQuery$
        Dim tzDif%
        Dim vParam As DataSet

        vQuery = "spf_StatTZDif " & _
        IIf(Len(timeZoneName) > 0, timeZoneName, "MT")

        If (Len(setDate) > 0) Then
            vQuery = vQuery & ", " & setDate & ";"
        End If

        tzDif = modODBC.Exec(vQuery, AppMain.vDataSource, vParam)

        'Set the time zone data
        Dim vTable As DataTable
        Dim vRow As DataRow

        If vParam.Tables.Count > 0 Then
            vTable = vParam.Tables(0)

            If vTable.Rows.Count > 0 Then
                vRow = vTable.Rows(0)

                QueryTimeZoneDif = DBNullToLng(vRow(vTable.Columns(0)))
            Else
                QueryTimeZoneDif = 0
            End If
        End If

        Exit Function

localError:
        'TASK: Add Error-logging: Call modError.LogError("modStatQuery.QueryTimeZoneDif")
        Resume Next


    End Function

    Public Function QueryKeyCodes%(ByRef pvForm As wfLogEvent, ByRef pvDataSet As DataSet)

        On Error Resume Next

        Dim vQuery
        Dim vResults As DataSet
        Dim vWhere$
        Dim vEventTypeList
        Dim i%
        Dim j%



        'Set the query statement
        '04/10/03 drh - Added WHERE Clause to prevent Fax and Secondary events
        vQuery = "SELECT KeyCodeName, KeyCodeNote FROM KeyCode;"

        'Execute the query
        QueryKeyCodes = modODBC.Exec(vQuery, AppMain.vDataSource, vResults)

        pvDataSet = vResults

        'Set the data
        Call modControl.SetTextID(pvForm.cboKeyCode, vResults, True, False, False)

    End Function

    Public Function QueryLogEventDesc%(ByVal pvLogEventId, ByRef prLogEventDesc, ByVal pvTimeZoneDiff)

        On Error Resume Next

        Dim vQuery$
        Dim vParams As DataSet
        Dim vReturn%

        On Error Resume Next

        'The selected record is a non-response event type so get the record
        'that matches the passed in log event ID
        vQuery = "SELECT LogEvent.LogEventDesc, LogEventCalloutDateTime " & _
        "FROM LogEvent " & _
        "WHERE LogEvent.LogEventID = " & pvLogEventId & ";"

        QueryLogEventDesc = modODBC.Exec(vQuery, AppMain.vDataSource, vParams)

        'If QueryLogEventDesc = SUCCESS Then

        'Set the event data
        Dim vTable As DataTable
        Dim vRow As DataRow
        Dim vDateTime As Date
        Dim sDateTime$

        If vParams.Tables.Count > 0 Then
            vTable = vParams.Tables(0)

            If vTable.Rows.Count > 0 Then
                vRow = vTable.Rows(0)
                prLogEventDesc = DBNullToText(vRow(vTable.Columns(0)))

                If prLogEventDesc <> "" And IsDate(vRow(vTable.Columns("LogEventCalloutDateTime"))) Then
                    vDateTime = vRow(vTable.Columns("LogEventCalloutDateTime"))
                Else
                    vDateTime = ""
                End If
                sDateTime = Format(vDateTime, "MM/dd/yy  HH:mm")
                prLogEventDesc = Replace(prLogEventDesc, sDateTime, Format(DateAdd("h", pvTimeZoneDiff, sDateTime), "MM/dd/yy  HH:mm"))

            End If
        End If

        'End If

    End Function
End Module
