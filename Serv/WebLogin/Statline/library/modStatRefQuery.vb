Module modStatRefQuery
    Public Function RefQueryLogEventType%(ByVal prParams As DataSet, _
    Optional ByVal pvID& = 0, _
    Optional ByVal pvName$ = "", _
    Optional ByVal pvTypeID& = 0)

        On Error Resume Next

        Dim vQuery$


        'Determine how to build the query

        If pvName = "" _
        And pvID = 0 _
        And pvTypeID = 0 Then

            'Get all items
            vQuery = _
                "SELECT DISTINCT " & _
                "LogEventType.LogEventTypeID, " & _
                "LogEventType.LogEventTypeName " & _
                "FROM LogEventType " & _
                "ORDER BY LogEventType.LogEventTypeID DESC;"

        ElseIf pvName = "" _
        And pvID = 0 Then

            'Get all items of a certain item type
            vQuery = _
                "SELECT DISTINCT " & _
                "LogEventType.LogEventTypeID, " & _
                "LogEventType.LogEventTypeName " & _
                "FROM LogEventType " & _
                "WHERE LogEventCallbackResponseType = " & modODBC.BuildField(pvTypeID) & _
                " ORDER BY LogEventType.LogEventTypeID DESC;"

        ElseIf pvName = "" _
        And pvTypeID = 0 Then

            'Get the item specified by the item id
            vQuery = _
                "SELECT DISTINCT " & _
                "LogEventType.LogEventTypeID, " & _
                "LogEventType.LogEventTypeName " & _
                "FROM LogEventType " & _
                "WHERE LogEventTypeID = " & pvID & _
                " ORDER BY LogEventType.LogEventTypeID DESC;"

        ElseIf pvID = 0 _
        And pvTypeID = 0 Then

            'Get the item specified by the item name
            vQuery = _
                "SELECT DISTINCT " & _
                "LogEventType.LogEventTypeID, " & _
                "LogEventType.LogEventTypeName " & _
                "FROM LogEventType " & _
                "WHERE LogEventTypeConstant = " & modODBC.BuildField(pvName) & _
                " ORDER BY LogEventType.LogEventTypeID DESC;"

        End If

        'Fill the return parameter array
        RefQueryLogEventType = modODBC.Exec(vQuery, AppMain.vDataSource, prParams)

    End Function
End Module
