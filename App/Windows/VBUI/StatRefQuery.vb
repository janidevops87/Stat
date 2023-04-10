Option Strict Off
Option Explicit On
Imports Statline.Stattrac.Framework

Module modStatRefQuery
    Public Function GetExpiredEventTime() As Short
        Dim vReturn As New Object
        Dim vQuery As String = ""
        vReturn = New Object()
        vQuery = "Select parameterValueint from stattracparameters where ParameterName = 'FamilyServicesExpiredEvents'"
        Call modODBC.Exec(vQuery, vReturn)
        GetExpiredEventTime = CShort(vReturn(0, 0))

    End Function

    Public Function ListRefQueryWebReportGroup(ByRef pcList As System.Windows.Forms.Control, Optional ByRef pvType As Object = Nothing) As Object

        Dim vReturn As New Object

        If IsNothing(pvType) Then
            Call modStatRefQuery.RefQueryWebReportGroup(vReturn)
        Else
            Call modStatRefQuery.RefQueryWebReportGroup(vReturn, , , pvType)
        End If

        Call modControl.SetTextID(pcList, vReturn)

    End Function


    Public Function ListRefQueryAlertGroup(ByRef pcList As System.Windows.Forms.Control, Optional ByRef pvType As Object = Nothing) As Object

        Dim vReturn As New Object

        If IsNothing(pvType) Then
            Call modStatRefQuery.RefQueryAlertGroup(vReturn)
        Else
            Call modStatRefQuery.RefQueryAlertGroup(vReturn, , , pvType)
        End If

        Call modControl.SetTextID(pcList, vReturn)

    End Function


    Public Function RefQueryWebReportGroup(ByRef prParams As Object, Optional ByRef pvID As Object = Nothing, Optional ByRef pvName As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing) As Short

        On Error Resume Next

        Dim vQuery As String = ""


        'Determine how to build the query

        If IsNothing(pvName) And IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get all items
            vQuery = "SELECT DISTINCT " & "WebReportGroupID, " & "WebReportGroupName " & "FROM WebReportGroup;"

        ElseIf IsNothing(pvName) And IsNothing(pvID) Then

            If pvTypeID = 194 Then
                vQuery = "SELECT DISTINCT WebReportGroupID, WebReportGroupName AS ReportGroupName " & "INTO #TempReportGroup1 " & "FROM WebReportGroup " & "WHERE OrgHierarchyParentID = " & pvTypeID & " "

                RefQueryWebReportGroup = modODBC.Exec(vQuery)

                If RefQueryWebReportGroup <> SUCCESS And RefQueryWebReportGroup <> NO_DATA Then
                    vQuery = "DROP TABLE #TempReportGroup1 "

                    RefQueryWebReportGroup = modODBC.Exec(vQuery)
                    Exit Function
                End If

                vQuery = "SELECT DISTINCT WebReportGroupID, OrganizationName + ' (' + WebReportGroupName + ') ' AS ReportGroupName " & "INTO #TempReportGroup2 " & "FROM WebReportGroup " & "JOIN Organization ON Organization.OrganizationID = WebReportGroup.OrgHierarchyParentID " & "WHERE WebReportGroupMaster = 1 "

                RefQueryWebReportGroup = modODBC.Exec(vQuery)

                If RefQueryWebReportGroup <> SUCCESS And RefQueryWebReportGroup <> NO_DATA Then
                    vQuery = "DROP TABLE #TempReportGroup2 "

                    RefQueryWebReportGroup = modODBC.Exec(vQuery)
                    Exit Function
                End If

                vQuery = "SELECT * " & "FROM #TempReportGroup1 " & "UNION " & "SELECT * " & "FROM #TempReportGroup2 " & "ORDER BY ReportGroupName "

                'Fill the return parameter array
                RefQueryWebReportGroup = modODBC.Exec(vQuery, prParams)

                If RefQueryWebReportGroup = SUCCESS Or RefQueryWebReportGroup = NO_DATA Then
                    RefQueryWebReportGroup = modODBC.Exec("DROP TABLE #TempReportGroup1 ")
                    RefQueryWebReportGroup = modODBC.Exec("DROP TABLE #TempReportGroup2 ")
                End If

                Exit Function

            Else

                'Get all items of a certain item type
                vQuery = "SELECT DISTINCT " & "WebReportGroupID, " & "WebReportGroupName " & "FROM WebReportGroup " & "WHERE OrgHierarchyParentID = " & pvTypeID & " "

            End If

        ElseIf IsNothing(pvName) And IsNothing(pvTypeID) Then

            'Get the item specified by the item id
            vQuery = "SELECT DISTINCT " & "WebReportGroupID, " & "WebReportGroupName " & "FROM WebReportGroup " & "WHERE WebReportGroupID = " & pvID & ";"

        ElseIf IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get the item specified by the item name
            vQuery = "SELECT DISTINCT " & "WebReportGroupID, " & "WebReportGroupName " & "FROM WebReportGroup " & "WHERE WebReportGroupName = " & modODBC.BuildField(pvName) & ";"

        ElseIf IsNothing(pvID) And Not IsNothing(pvTypeID) Then

            'Get the item specified by the item name
            vQuery = "SELECT DISTINCT " & "WebReportGroupID, " & "WebReportGroupName " & "FROM WebReportGroup " & "WHERE WebReportGroupName = " & modODBC.BuildField(pvName) & " " & "AND OrgHierarchyParentID = " & pvTypeID & ";"

        End If


        'Fill the return parameter array
        RefQueryWebReportGroup = modODBC.Exec(vQuery, prParams)

    End Function


    Public Function RefQueryServiceLevelGroup(Optional ByRef pcList As Object = Nothing, Optional ByRef prParams As Object = Nothing, Optional ByRef pvID As Object = Nothing, Optional ByRef pvName As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing, Optional ByRef pvServiceLevelStatusID As Short = 0) As Short

        On Error Resume Next

        Dim vQuery As String = ""
        Dim ResultsArray As New Object

        'Determine how to build the query

        If IsNothing(pvName) And IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get all items
            vQuery = "SELECT DISTINCT " & "ServiceLevelID, " & "ServiceLevelGroupName " & "FROM ServiceLevel "

        ElseIf IsNothing(pvName) And IsNothing(pvID) Then


        ElseIf IsNothing(pvName) And IsNothing(pvTypeID) Then

            'Get the item specified by the item id
            vQuery = "SELECT DISTINCT " & "ServiceLevelID, " & "ServiceLevelGroupName " & "FROM ServiceLevel " & "WHERE ServiceLevelID = " & pvID

        ElseIf IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get the item specified by the item name
            vQuery = "SELECT DISTINCT " & "ServiceLevelID, " & "ServiceLevelGroupName " & "FROM ServiceLevel " & "WHERE ServiceLevelGroupName = " & modODBC.BuildField(pvName)

        ElseIf IsNothing(pvID) And Not IsNothing(pvTypeID) Then


        End If

        'FSProj drh 5/2/02 - Only return the correct Historical ServiceLevel type (ServiceLevelStatus)
        If InStr(1, vQuery, "WHERE", CompareMethod.Text) = 0 Then
            vQuery = vQuery & "WHERE ServiceLevelStatus = " & pvServiceLevelStatusID
        Else
            vQuery = vQuery & "AND ServiceLevelStatus = " & pvServiceLevelStatusID
        End If

        'Fill the return parameter array
        RefQueryServiceLevelGroup = modODBC.Exec(vQuery, ResultsArray)

        If Not IsNothing(pcList) Then
            Call modControl.SetTextID(pcList, ResultsArray)
        End If

        If Not IsNothing(prParams) Then
            prParams = ResultsArray
        End If

    End Function

    Public Function RefQueryAlertGroup(ByRef prParams As Object, Optional ByRef pvID As Object = Nothing, Optional ByRef pvName As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing) As Short

        On Error Resume Next

        Dim vQuery As String = ""

        'Build initial Select statment
        vQuery = "SELECT DISTINCT " & "Alert.AlertID, " & "Alert.AlertGroupName " & "FROM Alert "

        'Added bjk 06/2001: Lease Organization
        'Check if LeaseOrganization and to where clause if it is
        If AppMain.ParentForm.LeaseOrganization <> 0 Then
            vQuery = vQuery & "LEFT JOIN AlertSourceCode ON AlertSourceCode.AlertID = Alert.AlertID " & "LEFT JOIN SourceCode ON SourceCode.SourceCodeID = AlertSourceCode.SourceCodeID "
        End If

        'Determine how to build the query

        If IsNothing(pvName) And IsNothing(pvID) And IsNothing(pvTypeID) Then
            'Do not build a where clause

        ElseIf IsNothing(pvName) And IsNothing(pvID) Then

            'Get the item specified by the item type id
            vQuery = vQuery & "WHERE AlertTypeID = " & pvTypeID & " "

        ElseIf IsNothing(pvName) And IsNothing(pvTypeID) Then

            'Get the item specified by the item id
            vQuery = vQuery & "WHERE AlertID = " & pvID & " "

        ElseIf IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get the item specified by the item name
            vQuery = vQuery & "WHERE AlertGroupName = " & modODBC.BuildField(pvName) & " "

        ElseIf IsNothing(pvID) And Not IsNothing(pvTypeID) Then


        End If

        'Added bjk 06/2001: Lease Organization
        'Check if LeaseOrganization and to where clause if it is
        If AppMain.ParentForm.LeaseOrganization <> 0 Then
            If InStr(1, vQuery, "WHERE", CompareMethod.Text) = 0 Then
                vQuery = vQuery & "WHERE "
            Else
                vQuery = vQuery & "AND "
            End If

            vQuery = vQuery & "SourceCodeName IN (SELECT DISTINCT SourceCode.SourceCodeName FROM " & "SourceCodeOrganization LEFT JOIN SourceCode ON SourceCode.SourceCodeID = SourceCodeOrganization.SourceCodeID " & "Where (SourceCodeType = 2 Or SourceCodeType = 4) AND SourceCodeOrganization.OrganizationID = " & AppMain.ParentForm.LeaseOrganization & "); "
        End If

        'Fill the return parameter array
        RefQueryAlertGroup = modODBC.Exec(vQuery, prParams)


    End Function
    Public Function RefQueryPerson(ByRef prParams As Object, Optional ByRef pvID As Object = Nothing, Optional ByRef pvFirst As Object = Nothing, Optional ByRef pvMI As Object = Nothing, Optional ByRef pvLast As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing) As Short

        On Error Resume Next

        Dim vQuery As String = ""
        Dim vReturn As New Object


        'Determine how to build the query

        If IsNothing(pvFirst) And IsNothing(pvMI) And IsNothing(pvLast) And IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get all items
            vQuery = "SELECT " & "Person.PersonID, " & "CASE WHEN Person.Inactive = 1 " & "THEN Person.PersonFirst+RTRIM(' '+(ISNULL(PersonMI,'')))+' '+PersonLast + ' (Inactive)' " & "ELSE Person.PersonFirst+RTRIM(' '+(ISNULL(PersonMI,'')))+' '+PersonLast " & "END  AS Person "

            vQuery = vQuery & "FROM Person;"

        ElseIf IsNothing(pvFirst) And IsNothing(pvMI) And IsNothing(pvLast) And IsNothing(pvID) Then

            'Get all items of a certain item type
            vQuery = "SELECT " & "Person.PersonID, " & "CASE WHEN Person.Inactive = 1 " & "THEN Person.PersonFirst+RTRIM(' '+(ISNULL(PersonMI,'')))+' '+PersonLast + ' (Inactive)' " & "ELSE Person.PersonFirst+RTRIM(' '+(ISNULL(PersonMI,'')))+' '+PersonLast " & "END  AS Person "

            vQuery = vQuery & "FROM Person " & "WHERE PersonTypeID = " & pvTypeID & ";"

        ElseIf IsNothing(pvFirst) And IsNothing(pvMI) And IsNothing(pvLast) And IsNothing(pvTypeID) Then

            'Get the item specified by the item id
            vQuery = "SELECT " & "Person.PersonID, " & "CASE WHEN Person.Inactive = 1 " & "THEN Person.PersonFirst+RTRIM(' '+(ISNULL(PersonMI,'')))+' '+PersonLast + ' (Inactive)' " & "ELSE Person.PersonFirst+RTRIM(' '+(ISNULL(PersonMI,'')))+' '+PersonLast " & "END  AS Person "

            vQuery = vQuery & "FROM Person " & "WHERE PersonID = " & pvID & ";"

        ElseIf IsNothing(pvID) And IsNothing(pvTypeID) Then

            vQuery = "SELECT DISTINCT " & "Person.PersonID, " & "CASE WHEN Person.Inactive = 1 " & "THEN Person.PersonFirst+RTRIM(' '+(ISNULL(PersonMI,'')))+' '+PersonLast + ' (Inactive)' " & "ELSE Person.PersonFirst+RTRIM(' '+(ISNULL(PersonMI,'')))+' '+PersonLast " & "END  AS Person "

            vQuery = vQuery & "FROM Person " & "WHERE PersonFirst = " & modODBC.BuildField(pvFirst) & " " & "AND PersonLast = " & modODBC.BuildField(pvLast) & " " & "ORDER BY Person.PersonID DESC;"

        End If

        'Fill the return parameter array
        RefQueryPerson = modODBC.Exec(vQuery, prParams)

    End Function

    Public Function RefQueryStatEmployee(ByRef prParams As Object, Optional ByRef pvID As Object = Nothing, Optional ByRef pvFirst As Object = Nothing, Optional ByRef pvLast As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing, Optional ByRef pvPersonID As Object = Nothing) As Short

        'Build Initial Query String
        Dim vQuery As String = "EXEC SelectRefQueryStatEmployee"

        'Determine which parameters to add
        If IsNothing(pvFirst) And IsNothing(pvLast) And IsNothing(pvID) And IsNothing(pvTypeID) And IsNothing(pvPersonID) Then

            'Get all items
            vQuery = vQuery & ";"

        ElseIf IsNothing(pvFirst) And IsNothing(pvLast) And IsNothing(pvTypeID) And IsNothing(pvPersonID) Then

            'Get the item specified by the item id
            vQuery = vQuery & " @StatEmployeeID = " & pvID & ";"

        ElseIf IsNothing(pvID) And IsNothing(pvTypeID) And IsNothing(pvPersonID) Then

            'Get the item specified by the item name
            vQuery = vQuery & " @PersonFirst = " & modODBC.BuildField(pvFirst) & ", @PersonLast = " & modODBC.BuildField(pvLast) & ";"

        ElseIf Not IsNothing(pvPersonID) Then

            'Get the item specified by the personID
            vQuery = vQuery & " @PersonID = " & pvPersonID & ";"

        Else

            vQuery = vQuery & ";"

        End If

        'Fill the return parameter array
        Try
            RefQueryStatEmployee = modODBC.Exec(vQuery, prParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function

    Public Function RefQueryStatEmployeeActiveOnly(ByRef prParams As Object, Optional ByRef pvID As Object = Nothing, Optional ByRef pvFirst As Object = Nothing, Optional ByRef pvLast As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing, Optional ByRef pvPersonID As Object = Nothing) As Short

        'Build Initial Query String
        Dim vQuery As String = "EXEC SelectRefQueryStatEmployee @DisplayInactive = 0"

        'Determine which parameters to add
        If IsNothing(pvFirst) And IsNothing(pvLast) And IsNothing(pvID) And IsNothing(pvTypeID) And IsNothing(pvPersonID) Then

            'Get all items
            vQuery = vQuery & ";"

        ElseIf IsNothing(pvFirst) And IsNothing(pvLast) And IsNothing(pvTypeID) And IsNothing(pvPersonID) Then

            'Get the item specified by the item id
            vQuery = vQuery & ", @StatEmployeeID = " & pvID & ";"

        ElseIf IsNothing(pvID) And IsNothing(pvTypeID) And IsNothing(pvPersonID) Then

            'Get the item specified by the item name
            vQuery = vQuery & ", @PersonFirst = " & modODBC.BuildField(pvFirst) & ", @PersonLast = " & modODBC.BuildField(pvLast) & ";"

        ElseIf Not IsNothing(pvPersonID) Then

            'Get the item specified by the personID
            vQuery = vQuery & ", @PersonID = " & pvPersonID & ";"

        Else

            vQuery = vQuery & ";"

        End If

        'Fill the return parameter array
        Try
            RefQueryStatEmployeeActiveOnly = modODBC.Exec(vQuery, prParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function

    Public Function RefQueryPhone(ByRef prParams As Object, Optional ByRef pvID As Object = Nothing, Optional ByRef pvNumber As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing) As Short

        On Error Resume Next

        Dim vQuery As String = ""
        Dim vAreaCode As String = ""
        Dim vPrefix As String = ""
        Dim vNumber As String = ""
        Dim vPIN As String = ""

        If Not IsNothing(pvNumber) Then
            'Strip out the components of the phone number
            vAreaCode = Mid(pvNumber, 2, 3)
            vPrefix = Mid(pvNumber, 7, 3)
            vNumber = Mid(pvNumber, 11, 4)
            vPIN = Mid(pvNumber, 13, 10)
        End If

        'Determine how to build the query

        If IsNothing(pvNumber) And IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get all items
            vQuery = "SELECT DISTINCT " & "Phone.PhoneID, " & "Phone.PhoneAreaCode, " & "Phone.PhonePrefix, " & "Phone.PhoneNumber, " & "Phone.PhonePIN, " & "Phone.PhoneTypeID " & "FROM Phone;"

        ElseIf IsNothing(pvNumber) And IsNothing(pvID) Then

            'Get all items of a certain item type
            'N/A

        ElseIf IsNothing(pvNumber) And IsNothing(pvTypeID) Then

            'Get the item specified by the item id
            vQuery = "SELECT DISTINCT " & "Phone.PhoneID, " & "Phone.PhoneAreaCode, " & "Phone.PhonePrefix, " & "Phone.PhoneNumber, " & "Phone.PhonePIN, " & "Phone.PhoneTypeID " & "FROM Phone " & "WHERE PhoneID = " & pvID & ";"

        ElseIf IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get the item specified by the item name
            vQuery = "SELECT DISTINCT Phone.PhoneID, Phone.PhoneAreaCode, " & "Phone.PhonePrefix, " & "Phone.PhoneNumber, " & "Phone.PhonePIN, " & "Phone.PhoneTypeID " & "FROM Phone " & "WHERE Phone.PhoneAreaCode = " & modODBC.BuildField(vAreaCode) & " AND Phone.PhonePrefix = " & modODBC.BuildField(vPrefix) & " AND Phone.PhoneNumber = " & modODBC.BuildField(vNumber) & ";"
        ElseIf IsNothing(pvID) Then  'BJK 06/27/02 added final elseif to catch when phonenumber and type is known,
            'but not PhoneID
            'Get the item specified by the item name
            vQuery = "SELECT DISTINCT Phone.PhoneID, Phone.PhoneAreaCode, " & "Phone.PhonePrefix, " & "Phone.PhoneNumber, " & "Phone.PhonePIN, " & "Phone.PhoneTypeID " & "FROM Phone " & "WHERE Phone.PhoneAreaCode = " & modODBC.BuildField(vAreaCode) & " AND Phone.PhonePrefix = " & modODBC.BuildField(vPrefix) & " AND Phone.PhoneNumber = " & modODBC.BuildField(vNumber) & " AND Phone.PhoneTypeID = " & modODBC.BuildField(pvTypeID) & ";"
        End If


        'Fill the return parameter array
        RefQueryPhone = modODBC.Exec(vQuery, prParams)

    End Function


    Public Function RefQueryRace(ByRef prParams As Object, Optional ByRef pvID As Object = Nothing, Optional ByRef pvName As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing) As Short

        Dim vQuery As String = ""


        'Determine how to build the query

        If IsNothing(pvName) And IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get all items
            vQuery = "SELECT DISTINCT " & "Race.RaceID, " & "Race.RaceName " & "FROM Race;"

        ElseIf IsNothing(pvName) And IsNothing(pvID) Then

            'Get all items of a certain item type
            'N/A

        ElseIf IsNothing(pvName) And IsNothing(pvTypeID) Then

            'Get the item specified by the item id
            vQuery = "SELECT DISTINCT " & "Race.RaceID, " & "Race.RaceName " & "FROM Race " & "WHERE RaceID = " & pvID & ";"

        ElseIf IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get the item specified by the item name
            vQuery = "SELECT DISTINCT " & "Race.RaceID, " & "Race.RaceName " & "FROM Race " & "WHERE RaceName = " & modODBC.BuildField(pvName) & ";"

        End If

        'Fill the return parameter array
        Try
            RefQueryRace = modODBC.Exec(vQuery, prParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function

    Public Function RefQueryPersonType(ByRef prParams As Object, Optional ByRef pvID As Object = Nothing, Optional ByRef pvName As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing) As Short

        On Error Resume Next

        Dim vQuery As String = ""


        'Determine how to build the query

        If IsNothing(pvName) And IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get all items
            vQuery = "SELECT DISTINCT " & "PersonType.PersonTypeID, " & "PersonType.PersonTypeName " & "FROM PersonType;"

        ElseIf IsNothing(pvName) And IsNothing(pvID) Then

            'Get all items of a certain item type
            'N/A

        ElseIf IsNothing(pvName) And IsNothing(pvTypeID) Then

            'Get the item specified by the item id
            vQuery = "SELECT DISTINCT " & "PersonType.PersonTypeID, " & "PersonType.PersonTypeName " & "FROM PersonType " & "WHERE PersonTypeID = " & pvID & ";"

        ElseIf IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get the item specified by the item name
            vQuery = "SELECT DISTINCT " & "PersonType.PersonTypeID, " & "PersonType.PersonTypeName " & "FROM PersonType " & "WHERE PersonTypeName = " & modODBC.BuildField(pvName) & ";"

        End If

        'Fill the return parameter array
        RefQueryPersonType = modODBC.Exec(vQuery, prParams)


    End Function

    Public Function RefQueryPhoneType(ByRef prParams As Object, Optional ByRef pvID As Object = Nothing, Optional ByRef pvName As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing) As Short

        On Error Resume Next

        Dim vQuery As String = ""


        'Determine how to build the query

        If IsNothing(pvName) And IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get all items
            vQuery = "SELECT DISTINCT " & "PhoneType.PhoneTypeID, " & "PhoneType.PhoneTypeName " & "FROM PhoneType;"

        ElseIf IsNothing(pvName) And IsNothing(pvID) Then

            'Get all items of a certain item type
            'N/A

        ElseIf IsNothing(pvName) And IsNothing(pvTypeID) Then

            'Get the item specified by the item id
            vQuery = "SELECT DISTINCT " & "PhoneType.PhoneTypeID, " & "PhoneType.PhoneTypeName " & "FROM PhoneType " & "WHERE PhoneTypeID = " & pvID & ";"

        ElseIf IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get the item specified by the item name
            vQuery = "SELECT DISTINCT " & "PhoneType.PhoneTypeID, " & "PhoneType.PhoneTypeName " & "FROM PhoneType " & "WHERE PhoneTypeName = " & modODBC.BuildField(pvName) & ";"

        End If

        'Fill the return parameter array
        RefQueryPhoneType = modODBC.Exec(vQuery, prParams)

    End Function


    Public Function RefQueryOrganizationType(Optional ByRef pcList As Object = Nothing, Optional ByRef prParams As Object = Nothing, Optional ByRef pvID As Object = Nothing, Optional ByRef pvName As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing, Optional ByRef pvAddAllItem As Object = Nothing) As Short

        On Error GoTo localError

        Dim vQuery As String = ""
        Dim ResultsArray As New Object


        'Determine how to build the query

        If IsNothing(pvName) And IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get all items
            vQuery = "SELECT DISTINCT " & "OrganizationType.OrganizationTypeID, " & "OrganizationType.OrganizationTypeName " & "FROM OrganizationType;"

        ElseIf IsNothing(pvName) And IsNothing(pvID) Then

            'Get all items of a certain item type
            'N/A

        ElseIf IsNothing(pvName) And IsNothing(pvTypeID) Then

            'Get the item specified by the item id
            vQuery = "SELECT DISTINCT " & "OrganizationType.OrganizationTypeID, " & "OrganizationType.OrganizationTypeName " & "FROM OrganizationType " & "WHERE OrganizationTypeID = " & pvID & ";"

        ElseIf IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get the item specified by the item name
            vQuery = "SELECT DISTINCT " & "OrganizationType.OrganizationTypeID, " & "OrganizationType.OrganizationTypeName " & "FROM OrganizationType " & "WHERE OrganizationTypeName = " & modODBC.BuildField(pvName) & ";"

        End If

        'Fill the return parameter array
        RefQueryOrganizationType = modODBC.Exec(vQuery, ResultsArray)

        If Not IsNothing(pcList) Then
            If IsNothing(pvAddAllItem) Then
                Call modControl.SetTextID(pcList, ResultsArray)
            Else
                Call modControl.SetTextID(pcList, ResultsArray, True, True)
            End If
        End If

        If Not IsNothing(prParams) Then
            prParams = ResultsArray
        End If

        Exit Function

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        Resume Next
        Resume
    End Function

    Public Function RefQueryMessageType(ByRef prParams As Object, Optional ByRef pvID As Object = Nothing, Optional ByRef pvName As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing) As Short

        On Error Resume Next

        Dim vQuery As String = ""


        'Determine how to build the query

        If IsNothing(pvName) And IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get all items
            vQuery = "SELECT DISTINCT " & "MessageType.MessageTypeID, " & "MessageType.MessageTypeName " & "FROM MessageType;"

        ElseIf IsNothing(pvName) And IsNothing(pvID) Then

            'Get all items of a certain item type
            Select Case pvTypeID
                Case Message
                    vQuery = "SELECT DISTINCT " & "MessageType.MessageTypeID, " & "MessageType.MessageTypeName " & "FROM MessageType " & "WHERE MessageTypeID <> 2"
                Case IMPORT
                    vQuery = "SELECT DISTINCT " & "MessageType.MessageTypeID, " & "MessageType.MessageTypeName " & "FROM MessageType " & "WHERE MessageTypeID = 2"
            End Select


        ElseIf IsNothing(pvName) And IsNothing(pvTypeID) Then

            'Get the item specified by the item id
            vQuery = "SELECT DISTINCT " & "MessageType.MessageTypeID, " & "MessageType.MessageTypeName " & "FROM MessageType " & "WHERE MessageTypeID = " & pvID & ";"

        ElseIf IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get the item specified by the item name
            vQuery = "SELECT DISTINCT " & "MessageType.MessageTypeID, " & "MessageType.MessageTypeName " & "FROM MessageType " & "WHERE MessageTypeName = " & modODBC.BuildField(pvName) & ";"

        End If

        'Fill the return parameter array
        RefQueryMessageType = modODBC.Exec(vQuery, prParams)

    End Function
    Public Function RefQueryNoCallType(ByRef prParams As Object, Optional ByRef pvID As Object = Nothing, Optional ByRef pvName As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing) As Short

        On Error Resume Next

        Dim vQuery As String = ""


        'Determine how to build the query

        If IsNothing(pvName) And IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get all items
            vQuery = "SELECT DISTINCT " & "NoCallType.NoCallTypeID, " & "NoCallType.NoCallTypeName " & "FROM NoCallType;"

        ElseIf IsNothing(pvName) And IsNothing(pvID) Then

            'Get all items of a certain item type
            'N/A

        ElseIf IsNothing(pvName) And IsNothing(pvTypeID) Then

            'Get the item specified by the item id
            vQuery = "SELECT DISTINCT " & "NoCallType.NoCallTypeID, " & "NoCallType.NoCallTypeName " & "FROM NoCallType " & "WHERE NoCallTypeID = " & pvID & ";"

        ElseIf IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get the item specified by the item name
            vQuery = "SELECT DISTINCT " & "NoCallType.NoCallTypeID, " & "NoCallType.NoCallTypeName " & "FROM NoCallType " & "WHERE NoCallTypeName = " & modODBC.BuildField(pvName) & ";"

        End If

        'Fill the return parameter array
        RefQueryNoCallType = modODBC.Exec(vQuery, prParams)

    End Function

    Public Function RefQueryCounty(ByRef prParams As Object, Optional ByRef pvID As Object = Nothing, Optional ByRef pvName As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing) As Short

        On Error Resume Next

        Dim vQuery As String = ""


        'Determine how to build the query

        If IsNothing(pvName) And IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get all items
            vQuery = "SELECT DISTINCT " & "County.CountyID, " & "County.CountyName " & "FROM County;"

        ElseIf IsNothing(pvName) And IsNothing(pvID) Then

            'Get all items of a certain item type
            'N/A

        ElseIf IsNothing(pvName) And IsNothing(pvTypeID) Then

            'Get the item specified by the item id
            vQuery = "SELECT DISTINCT " & "County.CountyID, " & "County.CountyName " & "FROM County " & "WHERE CountyID = " & pvID & ";"

        ElseIf IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get the item specified by the item name
            vQuery = "SELECT DISTINCT " & "County.CountyID, " & "County.CountyName " & "FROM County " & "WHERE CountyName = " & modODBC.BuildField(pvName) & ";"

        End If

        'Fill the return parameter array
        RefQueryCounty = modODBC.Exec(vQuery, prParams)

    End Function


    Public Function RefQueryConsent(ByRef prParams As Object, Optional ByRef pvID As Object = Nothing, Optional ByRef pvName As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing) As Short

        Dim vQuery As String = ""
        Dim vSourceCodeId As New Object

        If IsNothing(pvID) Then pvID = "Null"
        If IsNothing(pvName) Then pvName = "Null"
        If IsNothing(pvTypeID) Then pvTypeID = "Null"


        'ccarroll 11/27/2006 - changed to stored procedure: sps_RefQueryConsent
        'added SourceCode option to allow customized listbox selection. Removed old code.

        'Get SourceCodeID for customized listbox items
        vSourceCodeId = AppMain.frmReferral.SourceCode.ID

        vQuery = "sps_RefQueryConsent " & vSourceCodeId & "," & pvID & "," & pvName & "," & pvTypeID & ";"

        Try
            RefQueryConsent = modODBC.Exec(vQuery, prParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function
    Public Function RefQueryApproach(ByRef prParams As Object, Optional ByRef pvID As Object = Nothing, Optional ByRef pvName As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing) As Short

        Dim vQuery As String = ""
        Dim vSourceCodeId As New Object

        If IsNothing(pvID) Then pvID = "Null"
        If IsNothing(pvName) Then pvName = "Null"
        If IsNothing(pvTypeID) Then pvTypeID = "Null"


        'ccarroll 11/27/2006 - changed to stored procedure: sps_RefQueryApproach
        'added SourceCode option to allow customized listbox selection.  Removed old code.

        'Get SourceCodeID for customized listbox items
        vSourceCodeId = AppMain.frmReferral.SourceCode.ID

        vQuery = "sps_RefQueryApproach " & vSourceCodeId & "," & pvID & "," & pvName & "," & pvTypeID & ";"

        Try
            RefQueryApproach = modODBC.Exec(vQuery, prParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function

    Public Function RefQueryAppropriate(ByRef prParams As Object, Optional ByRef pvID As Object = Nothing, Optional ByRef pvName As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing) As Short

        Dim vQuery As String = ""
        Dim vSourceCodeId As New Object

        If IsNothing(pvID) Then pvID = "Null"
        If IsNothing(pvName) Then pvName = "Null"
        If IsNothing(pvTypeID) Then pvTypeID = "Null"


        'ccarroll 11/14/2006 - changed to stored procedure: sps_RefQueryAppropriate
        'added SourceCode option to allow customized listbox selection. Removed old code.

        'Get SourceCodeID for customized listbox items
        vSourceCodeId = AppMain.frmReferral.SourceCode.ID

        vQuery = "sps_RefQueryAppropriate " & vSourceCodeId & "," & pvID & "," & pvName & "," & pvTypeID & ";"

        Try
            RefQueryAppropriate = modODBC.Exec(vQuery, prParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function

    Public Function SecQueryMedication(ByRef prParams As Object, Optional ByRef pvID As Object = Nothing, Optional ByRef pvName As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing) As Short

        On Error Resume Next

        Dim vQuery As String = ""


        'Determine how to build the query

        If IsNothing(pvName) And IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get all items
            vQuery = "SELECT DISTINCT " & "Medication.MedicationID, " & "Medication.MedicationName " & "FROM Medication " & "WHERE MedicationTypeUse <> 'antibiotic';"

        ElseIf IsNothing(pvName) And IsNothing(pvID) Then

            'Get all items of a certain item type
            'N/A

        ElseIf IsNothing(pvName) And IsNothing(pvTypeID) Then

            'Get the item specified by the item id
            vQuery = "SELECT DISTINCT " & "Medication.MedicationID, " & "Medication.MedicationName " & "FROM Medication " & "WHERE MedicationTypeUse <> 'antibiotic' " & "AND MedicationID = " & pvID & ";"

        ElseIf IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get the item specified by the item name
            vQuery = "SELECT DISTINCT " & "Medication.MedicationID, " & "Medication.MedicationName " & "FROM Medication " & "WHERE MedicationTypeUse <> 'antibiotic' " & "AND MedicationName = " & modODBC.BuildField(pvName) & ";"

        End If

        'Fill the return parameter array
        SecQueryMedication = modODBC.Exec(vQuery, prParams)

    End Function

    Public Function SecQueryAvailableMedication(ByRef pvForm As FrmReferralView) As Short
        'FSProj drh 7/8/02

        On Error Resume Next

        Dim vQuery As String = ""
        Dim vParams As New Object
        Dim I As Integer

        'Get all items
        'drh 1/1/04 - NDRI: Added ndri_med clause
        vQuery = "SELECT DISTINCT " & "Medication.MedicationID, " & "Medication.MedicationName " & "FROM Medication " & "WHERE MedicationTypeUse <> 'antibiotic' " & "AND MedicationTypeUse <> 'steroid' " & "AND MedicationTypeUse <> 'ndri_medication' " & "AND MedicationId NOT IN(SELECT MedicationId " & "FROM SecondaryMedication " & "WHERE CallId = " & pvForm.CallId & ") " & "ORDER BY Medication.MedicationName;"

        'Fill the return parameter array
        SecQueryAvailableMedication = modODBC.Exec(vQuery, vParams)

        If Not IsNothing(vParams) Then
            For I = 0 To UBound(vParams, 1)
                'Call pvForm.lstAvailableMeds.Items.Insert(vParams(I, 0), vParams(I, 1))
                pvForm.lstAvailableMeds.Items.Add(New ValueDescriptionPair(vParams(I, 0), vParams(I, 1)))
            Next I
        End If

    End Function

    Public Function SecQueryCurrentlyAvailableMedication(ByRef pvForm As FrmReferralView) As Short
        'drh FSMod 06/17/03 - New Function

        On Error Resume Next

        Dim vQuery As String = ""
        Dim vParams As New Object
        Dim I As Integer
        Dim vIdList As String = ""

        For I = 0 To pvForm.lstSelectedMeds.Items.Count - 1
            If vIdList = "" Then
                vIdList = vIdList & pvForm.lstSelectedMeds.Items(I)
            Else
                vIdList = vIdList & "," & pvForm.lstSelectedMeds.Items(I)
            End If
        Next I


        'Get all items
        'drh 1/1/04 - NDRI: Added ndri_med clause
        vQuery = "SELECT DISTINCT " & "Medication.MedicationID, " & "Medication.MedicationName " & "FROM Medication " & "WHERE MedicationTypeUse <> 'antibiotic' " & "AND MedicationTypeUse <> 'steroid' " & "AND MedicationTypeUse <> 'ndri_medication' "

        vQuery = IIf(vIdList <> "", vQuery & "AND MedicationId NOT IN(" & vIdList & ") ", vQuery)
        vQuery = vQuery & "ORDER BY Medication.MedicationName;"

        'Fill the return parameter array
        SecQueryCurrentlyAvailableMedication = modODBC.Exec(vQuery, vParams)

        If Not IsNothing(vParams) Then
            Call pvForm.lstAvailableMeds.Items.Clear()

            For I = 0 To UBound(vParams, 1)
                pvForm.lstAvailableMeds.Items.Insert(vParams(I, 0), vParams(I, 1))
                'Call pvForm.lstAvailableMeds.AddItem(vParams(I, 1), I)
                'pvForm.lstAvailableMeds.ItemData(I) = vParams(I, 0)
            Next I
        End If

    End Function

    Public Function SecQuerySelectedMedication(ByRef pvForm As FrmReferralView) As Short
        'FSProj drh 7/8/02

        On Error Resume Next

        Dim vQuery As String = ""
        Dim vParams As New Object
        Dim I As Integer

        'Get all items
        vQuery = "SELECT DISTINCT " & "sm.MedicationID, " & "m.MedicationName " & "FROM SecondaryMedication sm " & "LEFT JOIN Medication m ON sm.MedicationId = m.MedicationId " & "WHERE sm.CallId = " & pvForm.CallId & " " & "ORDER BY m.MedicationName;"

        'Fill the return parameter array
        SecQuerySelectedMedication = modODBC.Exec(vQuery, vParams)

        If Not IsNothing(vParams) Then
            For I = 0 To UBound(vParams, 1)
                'Call pvForm.lstSelectedMeds.Items.Add(New ValueDescriptionPair(vParams(I, 0), vParams(I, 1)))

                pvForm.lstSelectedMeds.Items.Add(New ValueDescriptionPair(vParams(I, 0), vParams(I, 1)))
            Next I
        End If

    End Function

    Public Function SecQueryServiceLevel(ByRef pvForm As Object) As Short
        'drh FSMod 06/23/03 - New Function

        On Error Resume Next

        Dim vQuery As String = ""
        Dim vParams As New Object
        Dim I As Integer

        'Get all items
        vQuery = "SELECT " & "s.ServiceLevelEyeCareReminder " & "FROM ServiceLevel s " & "JOIN CallCriteria cc ON s.ServiceLevelId = cc.ServiceLevelId " & "WHERE cc.CallId = " & pvForm.CallId

        'Fill the return parameter array
        SecQueryServiceLevel = modODBC.Exec(vQuery, vParams)

        If Not IsNothing(vParams) Then
            modControl.SetRTFText(pvForm.rtfClientEyeCareReminder, modConv.NullToText(vParams(0, 0)))
        End If

    End Function

    Public Function SecQueryAntibiotic(ByRef prParams As Object, Optional ByRef pvID As Object = Nothing, Optional ByRef pvName As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing) As Short

        On Error Resume Next

        Dim vQuery As String = ""


        'Determine how to build the query
        If IsNothing(pvName) And IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get all items
            vQuery = "SELECT DISTINCT " & "Medication.MedicationID, " & "Medication.MedicationName " & "FROM Medication " & "WHERE MedicationTypeUse = 'antibiotic' " & "OR MedicationTypeUse = 'steroid';"

        ElseIf IsNothing(pvName) And IsNothing(pvID) Then

            'Get all items of a certain item type
            'N/A

        ElseIf IsNothing(pvName) And IsNothing(pvTypeID) Then

            'Get the item specified by the item id
            vQuery = "SELECT DISTINCT " & "Medication.MedicationID, " & "Medication.MedicationName " & "FROM Medication " & "WHERE MedicationTypeUse = 'antibiotic' " & "OR MedicationTypeUse = 'steroid' " & "AND MedicationID = " & pvID & ";"

        ElseIf IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get the item specified by the item name
            vQuery = "SELECT DISTINCT " & "Medication.MedicationID, " & "Medication.MedicationName " & "FROM Medication " & "WHERE MedicationTypeUse = 'antibiotic' " & "OR MedicationTypeUse = 'steroid' " & "AND MedicationName = " & modODBC.BuildField(pvName) & ";"

        End If

        'Fill the return parameter array
        SecQueryAntibiotic = modODBC.Exec(vQuery, prParams)

    End Function

    Public Function SecQuerySteroid(ByRef prParams As Object, Optional ByRef pvID As Object = Nothing, Optional ByRef pvName As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing) As Short
        'drh FSMod 06/09/03 - New Function

        On Error Resume Next

        Dim vQuery As String = ""


        'Determine how to build the query
        If IsNothing(pvName) And IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get all items
            vQuery = "SELECT DISTINCT " & "Medication.MedicationID, " & "Medication.MedicationName " & "FROM Medication " & "WHERE MedicationTypeUse = 'steroid';"

        ElseIf IsNothing(pvName) And IsNothing(pvID) Then

            'Get all items of a certain item type
            'N/A

        ElseIf IsNothing(pvName) And IsNothing(pvTypeID) Then

            'Get the item specified by the item id
            vQuery = "SELECT DISTINCT " & "Medication.MedicationID, " & "Medication.MedicationName " & "FROM Medication " & "WHERE MedicationTypeUse = 'steroid' " & "AND MedicationID = " & pvID & ";"

        ElseIf IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get the item specified by the item name
            vQuery = "SELECT DISTINCT " & "Medication.MedicationID, " & "Medication.MedicationName " & "FROM Medication " & "WHERE MedicationTypeUse = 'steroid' " & "AND MedicationName = " & modODBC.BuildField(pvName) & ";"

        End If

        'Fill the return parameter array
        SecQuerySteroid = modODBC.Exec(vQuery, prParams)

    End Function

    Public Function SecQueryCulture(ByRef prParams As Object, Optional ByRef pvID As Object = Nothing, Optional ByRef pvName As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing) As Short

        On Error Resume Next

        Dim vQuery As String = ""


        'Determine how to build the query

        If IsNothing(pvName) And IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get all items
            vQuery = "SELECT DISTINCT " & "Culture.CultureID, " & "Culture.CultureName " & "FROM Culture;"

        ElseIf IsNothing(pvName) And IsNothing(pvID) Then

            'Get all items of a certain item type
            'N/A

        ElseIf IsNothing(pvName) And IsNothing(pvTypeID) Then

            'Get the item specified by the item id
            vQuery = "SELECT DISTINCT " & "Culture.CultureID, " & "Culture.CultureName " & "FROM Culture " & "WHERE CultureID = " & pvID & ";"

        ElseIf IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get the item specified by the item name
            vQuery = "SELECT DISTINCT " & "Culture.CultureID, " & "Culture.CultureName " & "FROM Culture " & "WHERE CultureName = " & modODBC.BuildField(pvName) & ";"

        End If

        'Fill the return parameter array
        SecQueryCulture = modODBC.Exec(vQuery, prParams)

    End Function

    Public Function SecQueryCauseOfDeath(ByRef prParams As Object, Optional ByRef pvID As Object = Nothing, Optional ByRef pvName As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing) As Short

        On Error Resume Next

        Dim vQuery As String = ""

        'Determine how to build the query
        If IsNothing(pvName) And IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get all items
            vQuery = "SELECT DISTINCT " & "FS_CauseOfDeath.FS_CauseOfDeathID, " & "FS_CauseOfDeath.FS_CauseOfDeathName " & "FROM FS_CauseOfDeath " & "ORDER BY FS_CauseOfDeath.FS_CauseOfDeathName;"

        ElseIf IsNothing(pvName) And IsNothing(pvID) Then

            'Get all items of a certain item type
            'N/A

        ElseIf IsNothing(pvName) And IsNothing(pvTypeID) Then

            'Get the item specified by the item id
            vQuery = "SELECT DISTINCT " & "FS_CauseOfDeath.FS_CauseOfDeathID, " & "FS_CauseOfDeath.FS_CauseOfDeathName " & "FROM FS_CauseOfDeath " & "WHERE FS_CauseOfDeathID = " & pvID & " " & "ORDER BY FS_CauseOfDeathName;"

        ElseIf IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get the item specified by the item name
            vQuery = "SELECT DISTINCT " & "FS_CauseOfDeath.FS_CauseOfDeathID, " & "FS_CauseOfDeath.FS_CauseOfDeathName " & "FROM FS_CauseOfDeath " & "WHERE FS_CauseOfDeathName = " & modODBC.BuildField(pvName) & " " & "ORDER BY FS_CauseOfDeath.FS_CauseOfDeathName;"

        End If

        'Fill the return parameter array
        SecQueryCauseOfDeath = modODBC.Exec(vQuery, prParams)

    End Function

    Public Function SecQueryRace(ByRef prParams As Object, Optional ByRef pvID As Object = Nothing, Optional ByRef pvName As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing) As Short

        On Error Resume Next

        Dim vQuery As String = ""

        'Determine how to build the query
        If IsNothing(pvName) And IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get all items
            vQuery = "SELECT DISTINCT " & "Race.RaceID, " & "Race.RaceName " & "FROM Race;"

        ElseIf IsNothing(pvName) And IsNothing(pvID) Then

            'Get all items of a certain item type
            'N/A

        ElseIf IsNothing(pvName) And IsNothing(pvTypeID) Then

            'Get the item specified by the item id
            vQuery = "SELECT DISTINCT " & "Race.RaceID, " & "Race.RaceName " & "FROM Race " & "WHERE RaceID = " & pvID & ";"

        ElseIf IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get the item specified by the item name
            vQuery = "SELECT DISTINCT " & "Race.RaceID, " & "Race.RaceName " & "FROM Race " & "WHERE RaceName = " & modODBC.BuildField(pvName) & ";"

        End If

        'Fill the return parameter array
        SecQueryRace = modODBC.Exec(vQuery, prParams)

    End Function

    Public Function SecQueryState(ByRef prParams As Object, Optional ByRef pvID As Object = Nothing, Optional ByRef pvName As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing) As Short

        On Error Resume Next

        Dim vQuery As String = ""

        'Determine how to build the query
        If IsNothing(pvName) And IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get all items
            vQuery = "SELECT DISTINCT " & "State.StateID, " & "State.StateAbbrv " & "FROM State;"

        ElseIf IsNothing(pvName) And IsNothing(pvID) Then

            'Get all items of a certain item type
            'N/A

        ElseIf IsNothing(pvName) And IsNothing(pvTypeID) Then

            'Get the item specified by the item id
            vQuery = "SELECT DISTINCT " & "State.StateID, " & "State.StateAbbrv " & "FROM State " & "WHERE StateID = " & pvID & ";"

        ElseIf IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get the item specified by the item name
            vQuery = "SELECT DISTINCT " & "State.StateID, " & "State.StateAbbrv " & "FROM State " & "WHERE StateAbbrv = " & modODBC.BuildField(pvName) & ";"

        End If

        'Fill the return parameter array
        SecQueryState = modODBC.Exec(vQuery, prParams)

    End Function

    Public Function SecQueryUnit(ByRef prParams As Object, Optional ByRef pvID As Object = Nothing, Optional ByRef pvName As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing) As Short

        On Error Resume Next

        Dim vQuery As String = ""

        'Determine how to build the query
        If IsNothing(pvName) And IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get all items
            vQuery = "SELECT DISTINCT " & "SubLocation.SubLocationID, " & "SubLocation.SubLocationName " & "FROM SubLocation;"

        ElseIf IsNothing(pvName) And IsNothing(pvID) Then

            'Get all items of a certain item type
            'N/A

        ElseIf IsNothing(pvName) And IsNothing(pvTypeID) Then

            'Get the item specified by the item id
            vQuery = "SELECT DISTINCT " & "SubLocation.SubLocationID, " & "SubLocation.SubLocationName " & "FROM SubLocation " & "WHERE SubLocationID = " & pvID & ";"

        ElseIf IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get the item specified by the item name
            vQuery = "SELECT DISTINCT " & "SubLocation.SubLocationID, " & "SubLocation.SubLocationName " & "FROM SubLocation " & "WHERE SubLocationName = " & modODBC.BuildField(pvName) & ";"

        End If

        'Fill the return parameter array
        SecQueryUnit = modODBC.Exec(vQuery, prParams)

    End Function

    Public Function SecQueryBloodProduct(ByRef prParams As Object, Optional ByRef pvID As Object = Nothing, Optional ByRef pvName As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing) As Short

        On Error Resume Next

        Dim vQuery As String = ""

        'Determine how to build the query
        If IsNothing(pvName) And IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get all items
            vQuery = "SELECT DISTINCT " & "BloodProduct.BloodProductID, " & "BloodProduct.BloodProductName " & "FROM BloodProduct " & "WHERE BloodProductType = 'Blood products';"

        ElseIf IsNothing(pvName) And IsNothing(pvID) Then

            'Get all items of a certain item type
            'N/A

        ElseIf IsNothing(pvName) And IsNothing(pvTypeID) Then

            'Get the item specified by the item id
            vQuery = "SELECT DISTINCT " & "BloodProduct.BloodProductID, " & "BloodProduct.BloodProductName " & "FROM BloodProduct " & "WHERE BloodProductType = 'Blood products' " & "AND BloodProductID = " & pvID & ";"

        ElseIf IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get the item specified by the item name
            vQuery = "SELECT DISTINCT " & "BloodProduct.BloodProductID, " & "BloodProduct.BloodProductName " & "FROM BloodProduct " & "WHERE BloodProductType = 'Blood products' " & "AND BloodProductName = " & modODBC.BuildField(pvName) & ";"

        End If

        'Fill the return parameter array
        SecQueryBloodProduct = modODBC.Exec(vQuery, prParams)

    End Function

    Public Function SecQueryColloid(ByRef prParams As Object, Optional ByRef pvID As Object = Nothing, Optional ByRef pvName As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing, Optional ByRef pvFormName As Object = Nothing) As Short

        On Error Resume Next

        Dim vQuery As String = ""

        'Determine how to build the query
        If IsNothing(pvName) And IsNothing(pvID) And IsNothing(pvTypeID) Then

            'colloid switch time T.T 03/20/2007
            If (AppMain.frmReferralView.CallDate < modStatConstant.ColloidTime) Then
                vQuery = "SELECT DISTINCT " & "BloodProduct.BloodProductID, " & "BloodProduct.BloodProductName " & "FROM BloodProduct " & "WHERE BloodProductType = 'Colloids'"
            Else
                'Get all items
                vQuery = "SELECT DISTINCT " & "BloodProduct.BloodProductID, " & "BloodProduct.BloodProductName " & "FROM BloodProduct " & "WHERE BloodProductType = 'Colloids' and bloodproductID <> 17;"
            End If

        ElseIf IsNothing(pvName) And IsNothing(pvID) Then

            'Get all items of a certain item type
            'N/A

        ElseIf IsNothing(pvName) And IsNothing(pvTypeID) Then

            'colloid switch time T.T 03/20/2007
            If AppMain.frmReferralView.CallDate < modStatConstant.ColloidTime Then
                vQuery = "SELECT DISTINCT " & "BloodProduct.BloodProductID, " & "BloodProduct.BloodProductName " & "FROM BloodProduct " & "WHERE BloodProductType = 'Colloids' " & "AND BloodProductID = " & pvID & ";"
            Else
                'Get the item specified by the item id
                vQuery = "SELECT DISTINCT " & "BloodProduct.BloodProductID, " & "BloodProduct.BloodProductName " & "FROM BloodProduct " & "WHERE BloodProductType = 'Colloids' " & "AND BloodProductID = " & pvID & " and bloodproductID <> 17;"
            End If

        ElseIf IsNothing(pvID) And IsNothing(pvTypeID) Then
            'colloid switch time T.T 03/20/2007
            If AppMain.frmReferralView.CallDate < modStatConstant.ColloidTime Then
                vQuery = "SELECT DISTINCT " & "BloodProduct.BloodProductID, " & "BloodProduct.BloodProductName " & "FROM BloodProduct " & "WHERE BloodProductType = 'Colloids' " & "AND BloodProductName = " & modODBC.BuildField(pvName) & ";"
            Else
                'Get the item specified by the item name
                vQuery = "SELECT DISTINCT " & "BloodProduct.BloodProductID, " & "BloodProduct.BloodProductName " & "FROM BloodProduct " & "WHERE BloodProductType = 'Colloids' " & "AND BloodProductName = " & modODBC.BuildField(pvName) & " and bloodproductID <> 17;"
            End If
        End If

        'Fill the return parameter array
        SecQueryColloid = modODBC.Exec(vQuery, prParams)

    End Function

    Public Function SecQueryCrystalloid(ByRef prParams As Object, Optional ByRef pvID As Object = Nothing, Optional ByRef pvName As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing) As Short

        On Error Resume Next

        Dim vQuery As String = ""

        'Determine how to build the query
        If IsNothing(pvName) And IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get all items
            vQuery = "SELECT DISTINCT " & "BloodProduct.BloodProductID, " & "BloodProduct.BloodProductName " & "FROM BloodProduct " & "WHERE BloodProductType = 'crystalloids';"

        ElseIf IsNothing(pvName) And IsNothing(pvID) Then

            'Get all items of a certain item type
            'N/A

        ElseIf IsNothing(pvName) And IsNothing(pvTypeID) Then

            'Get the item specified by the item id
            vQuery = "SELECT DISTINCT " & "BloodProduct.BloodProductID, " & "BloodProduct.BloodProductName " & "FROM BloodProduct " & "WHERE BloodProductType = 'crystalloids' " & "AND BloodProductID = " & pvID & ";"

        ElseIf IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get the item specified by the item name
            vQuery = "SELECT DISTINCT " & "BloodProduct.BloodProductID, " & "BloodProduct.BloodProductName " & "FROM BloodProduct " & "WHERE BloodProductType = 'crystalloids' " & "AND BloodProductName = " & modODBC.BuildField(pvName) & ";"

        End If

        'Fill the return parameter array
        SecQueryCrystalloid = modODBC.Exec(vQuery, prParams)

    End Function

    Public Function SecQueryYesNo(ByRef prParams As Object, Optional ByRef pvID As Object = Nothing, Optional ByRef pvName As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing) As Short

        On Error Resume Next

        Dim vQuery As String = ""

        'Determine how to build the query
        If IsNothing(pvName) And IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get all items
            vQuery = "SELECT DISTINCT " & "YesNoNa_Ref.YesNoNa_RefID, " & "YesNoNa_Ref.YesNoNa_RefName " & "FROM YesNoNa_Ref;"

        ElseIf IsNothing(pvName) And IsNothing(pvID) Then

            'Get all items of a certain item type
            'N/A

        ElseIf IsNothing(pvName) And IsNothing(pvTypeID) Then

            'Get the item specified by the item id
            vQuery = "SELECT DISTINCT " & "YesNoNa_Ref.YesNoNa_RefID, " & "YesNoNa_Ref.YesNoNa_RefName " & "FROM YesNoNa_Ref " & "WHERE YesNoNa_RefID = " & pvID & ";"

        ElseIf IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get the item specified by the item name
            vQuery = "SELECT DISTINCT " & "YesNoNa_Ref.YesNoNa_RefID, " & "YesNoNa_Ref.YesNoNa_RefName " & "FROM YesNoNa_Ref " & "WHERE YesNoNa_RefName = " & modODBC.BuildField(pvName) & ";"

        End If

        'Fill the return parameter array
        SecQueryYesNo = modODBC.Exec(vQuery, prParams)

    End Function

    Public Function RefQueryDonorCategory(ByRef prParams As Object, Optional ByRef pvID As Object = Nothing, Optional ByRef pvName As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing) As Short

        On Error Resume Next

        Dim vQuery As String = ""


        'Determine how to build the query

        If IsNothing(pvName) And IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get all items
            vQuery = "SELECT DISTINCT " & "DonorCategory.DonorCategoryID, " & "DonorCategory.DonorCategoryName " & "FROM DonorCategory;"

        ElseIf IsNothing(pvName) And IsNothing(pvID) Then

            'Get all items of a certain item type
            'N/A

        ElseIf IsNothing(pvName) And IsNothing(pvTypeID) Then

            'Get the item specified by the item id
            vQuery = "SELECT DISTINCT " & "DonorCategory.DonorCategoryID, " & "DonorCategory.DonorCategoryName " & "FROM DonorCategory " & "WHERE DonorCategoryID = " & pvID & ";"

        ElseIf IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get the item specified by the item name
            vQuery = "SELECT DISTINCT " & "DonorCategory.DonorCategoryID, " & "DonorCategory.DonorCategoryName " & "FROM DonorCategory " & "WHERE DonorCategoryName = " & modODBC.BuildField(pvName) & ";"
        End If


        'Fill the return parameter array
        RefQueryDonorCategory = modODBC.Exec(vQuery, prParams)

    End Function
    Public Function RefDonorTracQueryDonorCategory(ByRef prParams As Object, Optional ByRef pvID As Object = Nothing, Optional ByRef pvName As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing) As Short

        '*********************************************************************************
        'Name: RefDonorTracQueryDonorCategory
        'Date Created: 11/30/2004                          Created By: T.T 08/19/2005
        'Release #: [Release Sub Was Created For  ex: 7.7.35]    Task: [Task created for]
        'Description: This subroutine will query for donortrac combo criteria
        'Returns: N/A
        'Params: pvForm - frmCritera
        'Stored Procedures: N/A
        '=================================================================================
        On Error Resume Next

        Dim vQuery As String = ""


        'Determine how to build the query

        If IsNothing(pvName) And IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get all items
            vQuery = "SELECT DISTINCT " & "DonorTracCategory.DonorCategoryID, " & "DonorTracCategory.DonorCategoryName " & "FROM  DonorTracCategory;"

        ElseIf IsNothing(pvName) And IsNothing(pvID) Then

            'Get all items of a certain item type
            'N/A

        ElseIf IsNothing(pvName) And IsNothing(pvTypeID) Then

            'Get the item specified by the item id
            vQuery = "SELECT DISTINCT " & "DonorTracCategory.DonorCategoryID, " & "DonorTracCategory.DonorCategoryName " & "FROM DonorTracCategoryCategory " & "WHERE DonorTracCategoryCategoryID = " & pvID & ";"

        ElseIf IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get the item specified by the item name
            vQuery = "SELECT DISTINCT " & "DonorTracCategory.DonorCategoryID, " & "DonorTracCategory.DonorCategoryName " & "FROM DonorTracCategory  " & "WHERE DonorTracCategory  = " & modODBC.BuildField(pvName) & ";"
        End If


        'Fill the return parameter array
        RefDonorTracQueryDonorCategory = modODBC.Exec(vQuery, prParams)

    End Function
    Public Function RefQueryDynamicDonorCategory(ByRef prParams As Object, Optional ByRef pvID As Object = Nothing, Optional ByRef pvName As Object = Nothing, Optional ByRef pvDynamicDonorCategoryID As Object = Nothing) As Short

        On Error Resume Next

        Dim vQuery As String = ""


        'Determine how to build the query

        If IsNothing(pvID) And IsNothing(pvName) And IsNothing(pvDynamicDonorCategoryID) Then

            'Get all items
            vQuery = "sps_DynamicDonorCategory ;"

        ElseIf IsNothing(pvName) And IsNothing(pvDynamicDonorCategoryID) Then

            'Get items for specified Criteria ID
            vQuery = "sps_DynamicDonorCategory " & pvID

        ElseIf IsNothing(pvID) And IsNothing(pvDynamicDonorCategoryID) Then
            'Get items for specified Criteria ID
            vQuery = "sps_DynamicDonorCategory null, " & Chr(39) & pvName & Chr(39)
        ElseIf IsNothing(pvID) And IsNothing(pvName) Then
            vQuery = "sps_DynamicDonorCategory null, null, " & pvDynamicDonorCategoryID
        End If

        'Fill the return parameter array
        RefQueryDynamicDonorCategory = modODBC.Exec(vQuery, prParams)

    End Function




    Public Function RefQueryConversion(ByRef prParams As Object, Optional ByRef pvID As Object = Nothing, Optional ByRef pvName As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing) As Short

        Dim vQuery As String = ""
        Dim vSourceCodeId As New Object

        If IsNothing(pvID) Then pvID = "Null"
        If IsNothing(pvName) Then pvName = "Null"
        If IsNothing(pvTypeID) Then pvTypeID = "Null"


        'ccarroll 11/27/2006 - changed to stored procedure: sps_RefQueryConversion
        'added SourceCode option to allow customized listbox selection. Removed old code.

        'Get SourceCodeID for customized listbox items
        vSourceCodeId = AppMain.frmReferral.SourceCode.ID

        vQuery = "sps_RefQueryConversion " & vSourceCodeId & "," & pvID & "," & pvName & "," & pvTypeID & ";"

        Try
            RefQueryConversion = modODBC.Exec(vQuery, prParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function

    Public Function RefQueryApproachType(ByRef prParams As Object, Optional ByRef pvID As Object = Nothing, Optional ByRef pvName As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing) As Short

        On Error Resume Next

        Dim vQuery As String = ""


        'Determine how to build the query

        If IsNothing(pvName) And IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get all items
            vQuery = "SELECT DISTINCT " & "ApproachType.ApproachTypeID, " & "ApproachType.ApproachTypeName " & "FROM ApproachType "

        ElseIf IsNothing(pvName) And IsNothing(pvID) Then

            'Get all items of a certain item type
            If pvTypeID = 0 Then

                vQuery = "SELECT DISTINCT " & "ApproachType.ApproachTypeID, " & "ApproachType.ApproachTypeName " & "FROM ApproachType " & "WHERE ApproachTypeID = " & NOT_APPROACHED & " " & "OR ApproachTypeID = " & PREREF_COUPLED & " " & "OR ApproachTypeID = " & PREREF_DECOUPLED & " " & "OR ApproachTypeID = " & FAMILY_INITIATED & " " & "OR ApproachTypeID = 8" & " "

            Else

                vQuery = "SELECT DISTINCT " & "ApproachType.ApproachTypeID, " & "ApproachType.ApproachTypeName " & "FROM ApproachType " & "WHERE ApproachTypeID = " & UNKNOWN & " " & "OR ApproachTypeID = " & PREREF_COUPLED & " " & "OR ApproachTypeID = " & PREREF_DECOUPLED & " " & "OR ApproachTypeID = " & FAMILY_INITIATED & " " & "OR ApproachTypeID = 8" & " "

            End If


        ElseIf IsNothing(pvName) And IsNothing(pvTypeID) Then

            'Get the item specified by the item id
            vQuery = "SELECT DISTINCT " & "ApproachType.ApproachTypeID, " & "ApproachType.ApproachTypeName " & "FROM ApproachType " & "WHERE ApproachTypeID = " & pvID

        ElseIf IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get the item specified by the item name
            vQuery = "SELECT DISTINCT " & "ApproachType.ApproachTypeID, " & "ApproachType.ApproachTypeName " & "FROM ApproachType " & "WHERE ApproachTypeName = " & modODBC.BuildField(pvName)

        End If

        'Fill the return parameter array
        RefQueryApproachType = modODBC.Exec(vQuery, prParams)

    End Function

    Public Function SecQueryApproachType(ByRef prParams As Object, Optional ByRef pvID As Object = Nothing, Optional ByRef pvName As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing) As Short

        On Error Resume Next

        Dim vQuery As String = ""


        'Determine how to build the query

        If IsNothing(pvName) And IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get all items
            vQuery = "SELECT DISTINCT " & "FSApproachType.FSApproachTypeID, " & "FSApproachType.FSApproachTypeName " & "FROM FSApproachType "

        ElseIf IsNothing(pvName) And IsNothing(pvID) Then

            'Get all items of a certain item type
            If pvTypeID = 0 Then

                vQuery = "SELECT DISTINCT " & "FSApproachType.FSApproachTypeID, " & "FSApproachType.FSApproachTypeName " & "FROM ApproachType " & "WHERE FSApproachTypeID = " & NOT_APPROACHED & " " & "OR FSApproachTypeID = " & PREREF_COUPLED & " " & "OR FSApproachTypeID = " & PREREF_DECOUPLED & " " & "OR FSApproachTypeID = " & FAMILY_INITIATED & " " & "OR FSApproachTypeID = 8" & " "

            Else

                vQuery = "SELECT DISTINCT " & "FSApproachType.FSApproachTypeID, " & "FSApproachType.FSApproachTypeName " & "FROM FSApproachType " & "WHERE FSApproachTypeID = " & UNKNOWN & " " & "OR FSApproachTypeID = " & PREREF_COUPLED & " " & "OR FSApproachTypeID = " & PREREF_DECOUPLED & " " & "OR FSApproachTypeID = " & FAMILY_INITIATED & " " & "OR FSApproachTypeID = 8" & " "

            End If


        ElseIf IsNothing(pvName) And IsNothing(pvTypeID) Then

            'Get the item specified by the item id
            vQuery = "SELECT DISTINCT " & "FSApproachType.FSApproachTypeID, " & "FSApproachType.FSApproachTypeName " & "FROM FSApproachType " & "WHERE FSApproachTypeID = " & pvID

        ElseIf IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get the item specified by the item name
            vQuery = "SELECT DISTINCT " & "FSApproachType.FSApproachTypeID, " & "FSApproachType.FSApproachTypeName " & "FROM FSApproachType " & "WHERE FSApproachTypeName = " & modODBC.BuildField(pvName)

        End If

        'Fill the return parameter array
        SecQueryApproachType = modODBC.Exec(vQuery, prParams)

    End Function

    Public Function SecQueryFuneralPlan(ByRef prParams As Object) As Short
        'drh FSMod 05/28/03 - Added function

        On Error Resume Next

        Dim vQuery As String = ""

        'Get all items
        vQuery = "SELECT DISTINCT " & "FuneralPlan.FuneralPlanID, " & "FuneralPlan.FuneralPlanName " & "FROM FuneralPlan "

        'Fill the return parameter array
        SecQueryFuneralPlan = modODBC.Exec(vQuery, prParams)

    End Function

    Public Function SecQueryABORef(ByRef prParams As Object) As Short
        'drh FSMod 06/13/03 - Added function

        On Error Resume Next

        Dim vQuery As String = ""

        'Get all items
        vQuery = "SELECT DISTINCT " & "ABORef.ABORefID, " & "ABORef.ABORefName " & "FROM ABORef "

        'Fill the return parameter array
        SecQueryABORef = modODBC.Exec(vQuery, prParams)

    End Function

    Public Function SecQueryRhythm(ByRef prParams As Object) As Short
        'drh FSMod 06/13/03 - Added function

        On Error Resume Next

        Dim vQuery As String = ""

        'Get all items
        vQuery = "SELECT DISTINCT " & "Rhythm.RhythmID, " & "Rhythm.RhythmName " & "FROM Rhythm "

        'Fill the return parameter array
        SecQueryRhythm = modODBC.Exec(vQuery, prParams)

    End Function
    Public Function SecQueryApproachReason(ByRef prParams As Object) As Short
        'drh FSMod 05/28/03 - Added function

        On Error Resume Next

        Dim vQuery As String = ""

        'Get all items
        vQuery = "SELECT DISTINCT " & "FSApproach.FSApproachID, " & "FSApproach.FSApproachName " & "FROM FSApproach " & "WHERE Inactive <> -1 " & "ORDER BY FSApproachName"

        'Fill the return parameter array
        SecQueryApproachReason = modODBC.Exec(vQuery, prParams)

    End Function







    Public Function RefQueryCallType(ByRef prParams() As String, Optional ByRef pvID As Object = Nothing, Optional ByRef pvName As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing) As Short

        On Error Resume Next

        Dim vQuery As String = ""


        'Determine how to build the query

        If IsNothing(pvName) And IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get all items
            vQuery = "SELECT DISTINCT " & "CallType.CallTypeID, " & "CallType.CallTypeName " & "FROM CallType;"

        ElseIf IsNothing(pvName) And IsNothing(pvID) Then

            'Get all items of a certain item type
            'N/A

        ElseIf IsNothing(pvName) And IsNothing(pvTypeID) Then

            'Get the item specified by the item id
            vQuery = "SELECT DISTINCT " & "CallType.CallTypeID, " & "CallType.CallTypeName " & "FROM CallType " & "WHERE CallTypeID = " & pvID & ";"

        ElseIf IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get the item specified by the item name
            vQuery = "SELECT DISTINCT " & "CallType.CallTypeID, " & "CallType.CallTypeName " & "FROM CallType " & "WHERE CallTypeName = " & modODBC.BuildField(pvName) & ";"

        End If

        'Fill the return parameter array
        RefQueryCallType = modODBC.Exec(vQuery, prParams)

    End Function









    Public Function RefQueryReferralType(ByRef prParams As Object, Optional ByRef pvID As Object = Nothing, Optional ByRef pvName As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing) As Short

        Dim vQuery As String = ""


        'Determine how to build the query

        If IsNothing(pvName) And IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get all items
            vQuery = "SELECT DISTINCT " & "ReferralType.ReferralTypeID, " & "ReferralType.ReferralTypeName " & "FROM ReferralType;"

        ElseIf IsNothing(pvName) And IsNothing(pvID) Then

            'Get all items of a certain item type
            'N/A

        ElseIf IsNothing(pvName) And IsNothing(pvTypeID) Then

            'Get the item specified by the item id
            vQuery = "SELECT DISTINCT " & "ReferralType.ReferralTypeID, " & "ReferralType.ReferralTypeName " & "FROM ReferralType " & "WHERE ReferralTypeID = " & pvID & ";"

        ElseIf IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get the item specified by the item name
            vQuery = "SELECT DISTINCT " & "ReferralType.ReferralTypeID, " & "ReferralType.ReferralTypeName " & "FROM ReferralType " & "WHERE ReferralTypeName = " & modODBC.BuildField(pvName) & ";"

        End If

        'Fill the return parameter array
        Try
            RefQueryReferralType = modODBC.Exec(vQuery, prParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function

    Public Function RefQueryLogEventType(ByRef prParams As Object, Optional ByRef pvID As Object = Nothing, Optional ByRef pvName As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing) As Short

        Dim vQuery As String = ""


        'Determine how to build the query

        If IsNothing(pvName) And IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get all items
            vQuery = "SELECT DISTINCT " & "LogEventType.LogEventTypeID, " & "LogEventType.LogEventTypeName " & "FROM LogEventType " & "ORDER BY LogEventType.LogEventTypeID DESC;"

        ElseIf IsNothing(pvName) And IsNothing(pvID) Then

            'Get all items of a certain item type
            vQuery = "SELECT DISTINCT " & "LogEventType.LogEventTypeID, " & "LogEventType.LogEventTypeName " & "FROM LogEventType " & "WHERE LogEventCallbackResponseType = " & modODBC.BuildField(pvTypeID) & " ORDER BY LogEventType.LogEventTypeID DESC;"

        ElseIf IsNothing(pvName) And IsNothing(pvTypeID) Then

            'Get the item specified by the item id
            vQuery = "SELECT DISTINCT " & "LogEventType.LogEventTypeID, " & "LogEventType.LogEventTypeName " & "FROM LogEventType " & "WHERE LogEventTypeID = " & pvID & " ORDER BY LogEventType.LogEventTypeID DESC;"

        ElseIf IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get the item specified by the item name
            vQuery = "SELECT DISTINCT " & "LogEventType.LogEventTypeID, " & "LogEventType.LogEventTypeName " & "FROM LogEventType " & "WHERE LogEventTypeConstant = " & modODBC.BuildField(pvName) & " ORDER BY LogEventType.LogEventTypeID DESC;"

        End If

        'Fill the return parameter array
        Try
            RefQueryLogEventType = modODBC.Exec(vQuery, prParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function


    Public Function RefQueryIndication(ByRef prParams As Object, Optional ByRef pvID As Object = Nothing, Optional ByRef pvName As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing) As Short

        On Error Resume Next

        Dim vQuery As String = ""


        'Determine how to build the query

        If IsNothing(pvName) And IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get all items
            vQuery = "SELECT DISTINCT " & "Indication.IndicationID, " & "Indication.IndicationName " & "FROM Indication " & "ORDER BY Indication.IndicationID DESC;"

        ElseIf IsNothing(pvName) And IsNothing(pvID) Then

            'Get all items of a certain item type
            vQuery = "SELECT DISTINCT " & "Indication.IndicationID, " & "Indication.IndicationName " & "FROM Indication " & "WHERE IndicationTypeID = " & modODBC.BuildField(pvTypeID) & " ORDER BY Indication.IndicationID DESC;"

        ElseIf IsNothing(pvName) And IsNothing(pvTypeID) Then

            'Get the item specified by the item id
            vQuery = "SELECT DISTINCT " & "Indication.IndicationID, " & "Indication.IndicationName " & "FROM Indication " & "WHERE IndicationID = " & pvID & " ORDER BY Indication.IndicationID DESC;"

        ElseIf IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get the item specified by the item name
            vQuery = "SELECT DISTINCT " & "Indication.IndicationID, " & "Indication.IndicationName " & "FROM Indication " & "WHERE IndicationName = " & modODBC.BuildField(pvName) & " ORDER BY Indication.IndicationID DESC;"

        End If

        'Fill the return parameter array
        RefQueryIndication = modODBC.Exec(vQuery, prParams)

    End Function

    Public Function RefQueryKeyCode(ByRef prParams As Object, Optional ByRef pvID As Object = Nothing, Optional ByRef pvName As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing) As Short

        On Error Resume Next

        Dim vQuery As String = ""


        'Determine how to build the query

        If IsNothing(pvName) And IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get all items
            vQuery = "SELECT DISTINCT " & "KeyCode.KeyCodeID, " & "KeyCode.KeyCodeName " & "FROM KeyCode " & "ORDER BY KeyCode.KeyCodeID DESC;"

        ElseIf IsNothing(pvName) And IsNothing(pvID) Then

            'Get all items of a certain item type
            vQuery = "SELECT DISTINCT " & "KeyCode.KeyCodeID, " & "KeyCode.KeyCodeName " & "FROM KeyCode " & "WHERE KeyCodeTypeID = " & modODBC.BuildField(pvTypeID) & " ORDER BY KeyCode.KeyCodeID DESC;"

        ElseIf IsNothing(pvName) And IsNothing(pvTypeID) Then

            'Get the item specified by the item id
            vQuery = "SELECT DISTINCT " & "KeyCode.KeyCodeID, " & "KeyCode.KeyCodeName " & "FROM KeyCode " & "WHERE KeyCodeID = " & pvID & " ORDER BY KeyCode.KeyCodeID DESC;"

        ElseIf IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get the item specified by the item name
            vQuery = "SELECT DISTINCT " & "KeyCode.KeyCodeID, " & "KeyCode.KeyCodeName " & "FROM KeyCode " & "WHERE KeyCodeName = " & modODBC.BuildField(pvName) & " ORDER BY KeyCode.KeyCodeID DESC;"

        End If

        'Fill the return parameter array
        RefQueryKeyCode = modODBC.Exec(vQuery, prParams)

    End Function



    Public Function RefQueryDictionaryItem(ByRef prParams As Object, Optional ByRef pvID As Object = Nothing, Optional ByRef pvName As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing) As Short

        On Error Resume Next

        Dim vQuery As String = ""


        'Determine how to build the query

        If IsNothing(pvName) And IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get all items
            vQuery = "SELECT DISTINCT " & "DictionaryItem.DictionaryItemID, " & "DictionaryItem.DictionaryItemName " & "FROM DictionaryItem " & "ORDER BY DictionaryItem.DictionaryItemID DESC;"

        ElseIf IsNothing(pvName) And IsNothing(pvID) Then

            'Get all items of a certain item type
            vQuery = "SELECT DISTINCT " & "DictionaryItem.DictionaryItemID, " & "DictionaryItem.DictionaryItemName " & "FROM DictionaryItem " & "WHERE DictionaryItemTypeID = " & modODBC.BuildField(pvTypeID) & " ORDER BY DictionaryItem.DictionaryItemID DESC;"

        ElseIf IsNothing(pvName) And IsNothing(pvTypeID) Then

            'Get the item specified by the item id
            vQuery = "SELECT DISTINCT " & "DictionaryItem.DictionaryItemID, " & "DictionaryItem.DictionaryItemName " & "FROM DictionaryItem " & "WHERE DictionaryItemID = " & pvID & " ORDER BY DictionaryItem.DictionaryItemID DESC;"

        ElseIf IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get the item specified by the item name
            vQuery = "SELECT DISTINCT " & "DictionaryItem.DictionaryItemID, " & "DictionaryItem.DictionaryItemName " & "FROM DictionaryItem " & "WHERE DictionaryItemName = " & modODBC.BuildField(pvName) & " ORDER BY DictionaryItem.DictionaryItemID DESC;"

        End If

        'Fill the return parameter array
        RefQueryDictionaryItem = modODBC.Exec(vQuery, prParams)

    End Function



    Public Function RefQuerySubLocation(ByRef prParams As Object, Optional ByRef pvID As Object = Nothing, Optional ByRef pvName As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing) As Short

        On Error Resume Next

        Dim vQuery As String = ""

        'Determine how to build the query

        If IsNothing(pvName) And IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get all items
            vQuery = "SELECT DISTINCT " & "SubLocation.SubLocationID, " & "SubLocation.SubLocationName " & "FROM SubLocation;"

        ElseIf IsNothing(pvName) And IsNothing(pvID) Then

            'Get all items of a certain item type
            'N/A

        ElseIf IsNothing(pvName) And IsNothing(pvTypeID) Then

            'Get the item specified by the item id
            vQuery = "SELECT DISTINCT " & "SubLocation.SubLocationID, " & "SubLocation.SubLocationName " & "FROM SubLocation " & "WHERE SubLocationID = " & pvID & ";"

        ElseIf IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get the item specified by the item name
            vQuery = "SELECT DISTINCT " & "SubLocation.SubLocationID, " & "SubLocation.SubLocationName " & "FROM SubLocation " & "WHERE SubLocationName = " & modODBC.BuildField(pvName) & ";"

        End If

        'Fill the return parameter array
        RefQuerySubLocation = modODBC.Exec(vQuery, prParams)

    End Function

    Public Function RefQuerySubLocationLevel(ByRef prParams As Object, Optional ByRef pvID As Object = Nothing, Optional ByRef pvName As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing) As Short

        On Error Resume Next

        Dim vQuery As String = ""

        'Determine how to build the query

        If IsNothing(pvName) And IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get all items
            vQuery = "SELECT DISTINCT " & "SubLocationLevel.SubLocationLevelID, " & "SubLocationLevel.SubLocationLevelName " & "FROM SubLocationLevel;"

        ElseIf IsNothing(pvName) And IsNothing(pvID) Then

            'Get all items of a certain item type
            'N/A

        ElseIf IsNothing(pvName) And IsNothing(pvTypeID) Then

            'Get the item specified by the item id
            vQuery = "SELECT DISTINCT " & "SubLocationLevel.SubLocationLevelID, " & "SubLocationLevel.SubLocationLevelName " & "FROM SubLocationLevel " & "WHERE SubLocationLevelID = " & pvID & ";"

        ElseIf IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get the item specified by the item name
            vQuery = "SELECT DISTINCT " & "SubLocationLevel.SubLocationLevelID, " & "SubLocationLevel.SubLocationLevelName " & "FROM SubLocationLevel " & "WHERE SubLocationLevelName = " & modODBC.BuildField(pvName) & ";"

        End If

        'Fill the return parameter array
        RefQuerySubLocationLevel = modODBC.Exec(vQuery, prParams)

    End Function

    Public Function RefQueryWeekday(ByRef prParams() As String, Optional ByRef pvID As Object = Nothing, Optional ByRef pvName As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing) As Short

        On Error Resume Next

        Dim vQuery As String = ""

        'Determine how to build the query

        If IsNothing(pvName) And IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get all items
            vQuery = "SELECT DISTINCT " & "Weekday.WeekdayID, " & "Weekday.WeekdayName " & "FROM Weekday;"

        ElseIf IsNothing(pvName) And IsNothing(pvID) Then

            'Get all items of a certain item type
            'N/A

        ElseIf IsNothing(pvName) And IsNothing(pvTypeID) Then

            'Get the item specified by the item id
            vQuery = "SELECT DISTINCT " & "Weekday.WeekdayID, " & "Weekday.WeekdayName " & "FROM Weekday " & "WHERE WeekdayID = " & pvID & ";"

        ElseIf IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get the item specified by the item name
            vQuery = "SELECT DISTINCT " & "Weekday.WeekdayID, " & "Weekday.WeekdayName " & "FROM Weekday " & "WHERE WeekdayName = " & modODBC.BuildField(pvName) & ";"

        End If

        'Fill the return parameter array
        RefQueryWeekday = modODBC.Exec(vQuery, prParams)

    End Function


    Public Function RefQueryTimeSegment(ByRef prParams As Object) As Short

        On Error Resume Next

        Dim vQuery As String = ""

        'Get all items
        vQuery = "SELECT TimeSegmentID, TimeSegmentName FROM TimeSegment "

        'Fill the return parameter array
        RefQueryTimeSegment = modODBC.Exec(vQuery, prParams)

    End Function

    Public Function RefQueryCauseOfDeath(ByRef prParams As Object, Optional ByRef pvID As Object = Nothing, Optional ByRef pvName As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing) As Short

        Dim vQuery As String = ""


        'Determine how to build the query

        If IsNothing(pvName) And IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get all items
            vQuery = "SELECT DISTINCT " & "CauseOfDeath.CauseOfDeathID, " & "CauseOfDeath.CauseOfDeathName " & "FROM CauseOfDeath;"

        ElseIf IsNothing(pvName) And IsNothing(pvID) Then

            'Get all items of a certain item type
            'N/A

        ElseIf IsNothing(pvName) And IsNothing(pvTypeID) Then

            'Get the item specified by the item id
            vQuery = "SELECT DISTINCT " & "CauseOfDeath.CauseOfDeathID, " & "CauseOfDeath.CauseOfDeathName " & "FROM CauseOfDeath " & "WHERE CauseOfDeathID = " & pvID & ";"

        ElseIf IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get the item specified by the item name
            vQuery = "SELECT DISTINCT " & "CauseOfDeath.CauseOfDeathID, " & "CauseOfDeath.CauseOfDeathName " & "FROM CauseOfDeath " & "WHERE CauseOfDeathName = " & modODBC.BuildField(pvName) & ";"

        End If


        'Fill the return parameter array
        Try
            RefQueryCauseOfDeath = modODBC.Exec(vQuery, prParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try


    End Function

    Public Function RefQueryDictionaryItemMisspelling(ByRef prParams As Object, Optional ByRef pvID As Object = Nothing, Optional ByRef pvName As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing) As Short

        On Error Resume Next

        Dim vQuery As String = ""


        'Determine how to build the query

        If IsNothing(pvName) And IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get all items
            vQuery = "SELECT DISTINCT " & "DictionaryItemMisspelling.DictionaryItemMisspellingID, " & "DictionaryItemMisspelling.DictionaryItemMisspellingName " & "FROM DictionaryItemMisspelling;"

        ElseIf IsNothing(pvName) And IsNothing(pvID) Then

            'Get all items of a certain item type
            'N/A

        ElseIf IsNothing(pvName) And IsNothing(pvTypeID) Then

            'Get the item specified by the item id
            vQuery = "SELECT DISTINCT " & "DictionaryItemMisspelling.DictionaryItemMisspellingID, " & "DictionaryItemMisspelling.DictionaryItemMisspellingName " & "FROM DictionaryItemMisspelling " & "WHERE DictionaryItemMisspellingID = " & pvID & ";"

        ElseIf IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get the item specified by the item name
            vQuery = "SELECT DISTINCT " & "DictionaryItemMisspelling.DictionaryItemMisspellingID, " & "DictionaryItemMisspelling.DictionaryItemMisspellingName " & "FROM DictionaryItemMisspelling " & "WHERE DictionaryItemMisspellingName = " & modODBC.BuildField(pvName) & ";"

        End If


        'Fill the return parameter array
        RefQueryDictionaryItemMisspelling = modODBC.Exec(vQuery, prParams)


    End Function


    Public Function RefQueryScheduleGroup(ByRef prParams As Object, Optional ByRef pvID As Object = Nothing, Optional ByRef pvName As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing) As Short

        On Error Resume Next

        Dim vQuery As String = ""


        'Determine how to build the query

        If IsNothing(pvName) And IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get all items
            vQuery = "SELECT DISTINCT ScheduleGroup.ScheduleGroupID, ScheduleGroup.ScheduleGroupName FROM ScheduleGroup;"

        ElseIf IsNothing(pvName) And IsNothing(pvID) Then

            'Get all items of a certain item type
            vQuery = "SELECT DISTINCT ScheduleGroup.ScheduleGroupID, ScheduleGroup.ScheduleGroupName FROM ScheduleGroup WHERE OrganizationID = " & pvTypeID & ";"

        ElseIf IsNothing(pvName) And IsNothing(pvTypeID) Then

            'Get the item specified by the item id
            vQuery = "SELECT DISTINCT ScheduleGroup.ScheduleGroupID, ScheduleGroup.ScheduleGroupName FROM ScheduleGroup WHERE ScheduleGroupID = " & pvID & ";"

        ElseIf IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get the item specified by the item name
            vQuery = "SELECT DISTINCT ScheduleGroup.ScheduleGroupID, ScheduleGroup.ScheduleGroupName FROM ScheduleGroup WHERE ScheduleGroupName = " & modODBC.BuildField(pvName) & ";"

        ElseIf Not IsNothing(pvName) And Not IsNothing(pvTypeID) Then

            'Get the item specified by the item name and item type
            vQuery = "SELECT DISTINCT ScheduleGroup.ScheduleGroupID, ScheduleGroup.ScheduleGroupName FROM ScheduleGroup WHERE ScheduleGroupName = " & modODBC.BuildField(pvName) & " " & "AND OrganizationID = " & pvTypeID & ";"

        End If


        'Fill the return parameter array
        RefQueryScheduleGroup = modODBC.Exec(vQuery, prParams)


    End Function



    Public Function RefQueryCriteriaGroup(ByRef prParams As Object, Optional ByRef pvID As Object = Nothing, Optional ByRef pvName As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing, Optional ByRef pvCriteriaStatusID As Object = Nothing) As Short

        'FSProj drh 4/29/02 - Added optional pvCriteriaStatusID parameter

        On Error Resume Next

        Dim vQuery As String = ""

        'Build initial Select Statment
        vQuery = vQuery & "SELECT DISTINCT " & "Criteria.CriteriaID, " & "Criteria.CriteriaGroupName " & "FROM Criteria "

        'Added bjk 06/2001: Lease Organization
        'Check if LeaseOrganization and to where clause if it is
        If AppMain.ParentForm.LeaseOrganization <> 0 Then
            vQuery = vQuery & "LEFT JOIN CriteriaSourceCode ON CriteriaSourceCode.CriteriaID = Criteria.CriteriaID " & "LEFT JOIN SourceCode ON SourceCode.SourceCodeID = CriteriaSourceCode.SourceCodeID "
        End If


        'Determine how to build the query
        If IsNothing(pvName) And IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get all items
            'DO NOTHING

        ElseIf IsNothing(pvName) And IsNothing(pvID) Then

            'Get all items of a certain item type
            vQuery = vQuery & "WHERE DonorCategoryID = " & pvTypeID & " "

        ElseIf IsNothing(pvName) And IsNothing(pvTypeID) Then

            'Get the item specified by the item id
            vQuery = vQuery & "WHERE CriteriaID = " & pvID & " "

        ElseIf IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get the item specified by the item name
            vQuery = vQuery & "WHERE CriteriaGroupName = " & modODBC.BuildField(pvName) & " "

        ElseIf Not IsNothing(pvName) And Not IsNothing(pvTypeID) Then

            'Get the item specified by the item name and item type
            vQuery = vQuery & "WHERE CriteriaGroupName = " & modODBC.BuildField(pvName) & " " & "AND DonorCategoryID = " & pvTypeID & " "

        End If

        'Added bjk 06/2001: Lease Organization
        'Check if LeaseOrganization and to where clause if it is
        If AppMain.ParentForm.LeaseOrganization <> 0 Then
            If InStr(1, vQuery, "WHERE", CompareMethod.Text) = 0 Then
                vQuery = vQuery & "WHERE "
            Else
                vQuery = vQuery & "AND "
            End If

            vQuery = vQuery & "SourceCodeName IN (SELECT DISTINCT SourceCode.SourceCodeName FROM " & "SourceCodeOrganization LEFT JOIN SourceCode ON SourceCode.SourceCodeID = SourceCodeOrganization.SourceCodeID " & "Where (SourceCodeType = 2 Or SourceCodeType = 4) AND SourceCodeOrganization.OrganizationID = " & AppMain.ParentForm.LeaseOrganization & ") "
            'FSProj drh 4/29/02 - Removed semi-colon so we can add another WHERE clause below
        End If

        'FSProj drh 4/25/02 - Only return the correct Historical Criteria type (CriteriaStatus)
        If InStr(1, vQuery, "WHERE", CompareMethod.Text) = 0 Then
            vQuery = vQuery & "WHERE CriteriaStatus = " & pvCriteriaStatusID
        Else
            vQuery = vQuery & "AND CriteriaStatus = " & pvCriteriaStatusID
        End If

        'Fill the return parameter array
        RefQueryCriteriaGroup = modODBC.Exec(vQuery, prParams)


    End Function


    Public Function RefQueryScheduleShift(ByRef prParams() As String, Optional ByRef pvID As Object = Nothing, Optional ByRef pvName As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing) As Short

        On Error Resume Next

        Dim vQuery As String = ""


        'Determine how to build the query

        If IsNothing(pvName) And IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get all items
            vQuery = "SELECT " & "ScheduleShift.ScheduleShiftID, " & "ScheduleShift.ScheduleShiftName " & "FROM ScheduleShift " & "ORDER BY LastModified DESC "

        ElseIf IsNothing(pvName) And IsNothing(pvID) Then

            'Get all items of a certain item type
            vQuery = "SELECT " & "ScheduleShift.ScheduleShiftID, " & "ScheduleShift.ScheduleShiftName " & "FROM ScheduleShift " & "WHERE ScheduleGroupID = " & pvTypeID & " " & "ORDER BY LastModified DESC "

        ElseIf IsNothing(pvName) And IsNothing(pvTypeID) Then

            'Get the item specified by the item id
            vQuery = "SELECT " & "ScheduleShift.ScheduleShiftID, " & "ScheduleShift.ScheduleShiftName " & "FROM ScheduleShift " & "WHERE ScheduleShiftID = " & pvID & " " & "ORDER BY LastModified DESC "

        ElseIf IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get the item specified by the item name
            vQuery = "SELECT " & "ScheduleShift.ScheduleShiftID, " & "ScheduleShift.ScheduleShiftName " & "FROM ScheduleShift " & "WHERE ScheduleShiftName = " & modODBC.BuildField(pvName) & " " & "ORDER BY LastModified DESC "

        ElseIf Not IsNothing(pvName) And Not IsNothing(pvTypeID) Then

            'Get the item specified by the item name and item type
            vQuery = "SELECT " & "ScheduleShift.ScheduleShiftID, " & "ScheduleShift.ScheduleShiftName " & "FROM ScheduleShift " & "WHERE ScheduleShiftName = " & modODBC.BuildField(pvName) & " " & "AND ScheduleGroupID = " & pvTypeID & " " & "ORDER BY LastModified DESC "

        End If


        'Fill the return parameter array
        RefQueryScheduleShift = modODBC.Exec(vQuery, prParams)


    End Function

    Public Function ListRefQueryCauseOfDeath(ByRef pcList As System.Windows.Forms.Control) As Object

        Dim vReturn As New Object

        Try
            Call RefQueryCauseOfDeath(vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        Call modControl.SetAutoCompleteTextID(pcList, vReturn)

    End Function



    '	Public Function ListRefQueryScheduleGroup(ByRef pcList As System.Windows.Forms.Control) As Object

    '		Dim vReturn As New Object

    '		Call RefQueryScheduleGroup(vReturn)

    '		Call modControl.SetTextID(pcList, vReturn)

    '	End Function


    '	Public Function ListRefQueryCriteriaGroup(ByRef pcList As System.Windows.Forms.Control, ByRef pvCriteriaStatusID As Object) As Object

    '		Dim vReturn As New Object

    '		Call RefQueryCriteriaGroup(vReturn,  ,  , pvCriteriaStatusID)

    '		Call modControl.SetTextID(pcList, vReturn)

    '	End Function


    Public Function ListRefQueryRace(ByRef pcList As System.Windows.Forms.Control) As Object

        Dim vReturn As New Object

        Try
            Call RefQueryRace(vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        Call modControl.SetTextID(pcList, vReturn)

    End Function


    '	Public Function ListRefQueryDenyReason(ByRef pcList As System.Windows.Forms.Control) As Object

    '		Dim vReturn As New Object

    '		Call modStatRefQuery.RefQueryDenyReason(vReturn)

    '		Call modControl.SetTextID(pcList, vReturn)

    '	End Function



    Public Function ListRefQueryMessageType(ByRef pcList As ComboBox, Optional ByRef pvType As Object = Nothing) As Object

        Dim vReturn As New Object

        If IsNothing(pvType) Then
            Call modStatRefQuery.RefQueryMessageType(vReturn)
        Else
            Call modStatRefQuery.RefQueryMessageType(vReturn, , , pvType)
        End If

        Call modControl.SetTextID(pcList, vReturn)

    End Function

    Public Function ListRefQueryReference(ByRef pcList As ComboBox, ByRef pvType As Object) As Object

        Dim vReturn As New Object
        ReDim vReturn(1, 1)
        Call modStatRefQuery.RefQueryReference(vReturn, , , pvType)

        Call modControl.SetTextID(pcList, vReturn)

    End Function



    Public Function ListRefQueryDictionaryItem(ByRef pcList As ListBox) As Object

        Dim vReturn As New Object

        Call modStatRefQuery.RefQueryDictionaryItem(vReturn)

        Call modControl.SetTextID(pcList, vReturn)

    End Function



    Public Function ListRefQueryNoCallType(ByRef pcList As System.Windows.Forms.Control) As Object

        Dim vReturn As New Object

        Call modStatRefQuery.RefQueryNoCallType(vReturn)

        Call modControl.SetTextID(pcList, vReturn)

    End Function

    '	Public Function ListRefQueryCounty(ByRef pcList As System.Windows.Forms.Control) As Object

    '		Dim vReturn As New Object

    '		Call modStatRefQuery.RefQueryCounty(vReturn)

    '		Call modControl.SetTextID(pcList, vReturn)

    '	End Function
    Public Function ListRefQueryConversion(ByRef pcList As System.Windows.Forms.Control) As Object

        Dim vReturn As New Object

        Try
            Call modStatRefQuery.RefQueryConversion(vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        Call modControl.SetTextID(pcList, vReturn)

    End Function

    Public Function ListRefQueryConsent(ByRef pcList As System.Windows.Forms.Control) As Object

        Dim vReturn As New Object

        Try
            Call modStatRefQuery.RefQueryConsent(vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        Call modControl.SetTextID(pcList, vReturn)

    End Function
    Public Function ListRefQueryAppropriate(ByRef pcList As System.Windows.Forms.Control) As Object

        Dim vReturn As New Object

        Try
            Call modStatRefQuery.RefQueryAppropriate(vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        Call modControl.SetTextID(pcList, vReturn)

    End Function

    Public Function ListRefQueryApproach(ByRef pcList As System.Windows.Forms.Control) As Object

        Dim vReturn As New Object

        Try
            Call modStatRefQuery.RefQueryApproach(vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        Call modControl.SetTextID(pcList, vReturn)

    End Function

    Public Function ListRefQueryDonorCategory(ByRef pcList As System.Windows.Forms.Control) As Object

        Dim vReturn As New Object

        Call modStatRefQuery.RefQueryDonorCategory(vReturn)

        Call modControl.SetTextID(pcList, vReturn)

    End Function
    Public Function ListDonorTracRefQueryDonorCategory(ByRef pcList As System.Windows.Forms.Control) As Object
        'T.T 08/19/2005 donor criteria mapping
        Dim vReturn As New Object

        Call modStatRefQuery.RefDonorTracQueryDonorCategory(vReturn)

        Call modControl.SetTextID(pcList, vReturn)

    End Function
    Public Function ListRefQueryDynamicDonorCategory(ByRef pcList As System.Windows.Forms.Control) As Object

        Dim vReturn As New Object

        Call modStatRefQuery.RefQueryDynamicDonorCategory(vReturn)

        Call modControl.SetTextID(pcList, vReturn)

    End Function

    '	Public Function ListRefQueryConsentCategory(ByRef pcList As System.Windows.Forms.Control) As Object

    '		Dim vReturn As New Object

    '		Call modStatRefQuery.RefQueryConsentCategory(vReturn)

    '		Call modControl.SetTextID(pcList, vReturn)

    '	End Function

    '	Public Function ListRefQueryRecoveryCategory(ByRef pcList As System.Windows.Forms.Control) As Object

    '		Dim vReturn As New Object

    '		Call modStatRefQuery.RefQueryRecoveryCategory(vReturn)

    '		Call modControl.SetTextID(pcList, vReturn)

    '	End Function

    Public Function ListSecFuneralPlan(ByRef pcList As ComboBox, Optional ByRef pvType As Object = Nothing) As Object
        'drh FSMod 05/28/03 - Added function

        Dim vReturn As New Object

        Call modStatRefQuery.SecQueryFuneralPlan(vReturn)

        Call modControl.SetTextID(pcList, vReturn, False)

    End Function

    Public Function ListSecRhythm(ByRef pcList As ComboBox, Optional ByRef pvType As Object = Nothing) As Object
        'drh FSMod 06/17/03 - Added function

        Dim vReturn As New Object

        Call modStatRefQuery.SecQueryRhythm(vReturn)

        Call modControl.SetTextID(pcList, vReturn, False)

    End Function

    Public Function ListSecABORef(ByRef pcList As ComboBox, Optional ByRef pvType As Object = Nothing) As Object
        'drh FSMod 06/13/03 - Added function

        Dim vReturn As New Object

        Call modStatRefQuery.SecQueryABORef(vReturn)

        Call modControl.SetTextID(pcList, vReturn, False)

    End Function
    Public Function ListSecApproachReason(ByRef pcList As ComboBox, Optional ByRef pvType As Object = Nothing) As Object
        'drh FSMod 05/28/03 - Added function

        Dim vReturn As New Object

        Call modStatRefQuery.SecQueryApproachReason(vReturn)

        Call modControl.SetTextID(pcList, vReturn, False)

    End Function
    Public Function ListSecQueryApproachType(ByRef pcList As ComboBox, Optional ByRef pvType As Object = Nothing) As Object

        Dim vReturn As New Object

        Call modStatRefQuery.SecQueryApproachType(vReturn, , , pvType)

        'drh FSMod 06/03/03 - Added pClear parameter value
        Call modControl.SetTextID(pcList, vReturn, False)

    End Function

    Public Function ListRefQueryApproachType(ByRef pcList As System.Windows.Forms.Control, Optional ByRef pvType As Object = Nothing) As Object

        Dim vReturn As New Object

        Try
            Call modStatRefQuery.RefQueryApproachType(vReturn, , , pvType)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        'drh FSMod 06/03/03 - Added IIf function & pClear parameter value
        Call modControl.SetTextID(pcList, vReturn, IIf(pcList.FindForm.Name = "FrmReferralView", False, True))

    End Function


    '	Public Function ListRefQueryReport(ByRef pcList As System.Windows.Forms.Control) As Object

    '		Dim vReturn As New Object

    '		Call modStatRefQuery.RefQueryReport(vReturn)

    '		Call modControl.SetTextID(pcList, vReturn)

    '	End Function




    '	Public Function ListRefQueryCallType(ByRef pcList As System.Windows.Forms.Control) As Object

    '		Dim vReturn As New Object

    '		Call modStatRefQuery.RefQueryCallType(vReturn)

    '		Call modControl.SetTextID(pcList, vReturn)

    '	End Function

    Public Function ListRefQueryReferralType(ByRef pcList As System.Windows.Forms.Control) As Object

        Dim vReturn As New Object

        Try
            Call modStatRefQuery.RefQueryReferralType(vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        Call modControl.SetTextID(pcList, vReturn)

    End Function

    '	Public Function ListRefQueryPerson(ByRef pcList As System.Windows.Forms.Control) As Object

    '		Dim vReturn As New Object

    '		Call RefQueryPerson(vReturn)

    '		Call modControl.SetTextID(pcList, vReturn)

    '	End Function
    Public Function ListRefQueryPersonType(ByRef pcList As ComboBox) As Object

        Dim vReturn As New Object

        Call RefQueryPersonType(vReturn)

        Call modControl.SetTextID(pcList, vReturn)

    End Function

    '	Public Function ListRefQueryPhone(ByRef pcList As System.Windows.Forms.Control) As Object

    '		Dim vReturn As New Object

    '		Call RefQueryPhone(vReturn)

    '		Call modControl.SetTextID(pcList, vReturn)

    '	End Function
    Public Function ListRefQuerySubLocation(ByRef pcList As ComboBox) As Object

        Dim vReturn As New Object

        Call RefQuerySubLocation(vReturn)

        Call modControl.SetTextID(pcList, vReturn)

    End Function
    Public Function ListRefQuerySubLocationLevel(ByRef pcList As ComboBox) As Object

        Dim vReturn As New Object

        Call RefQuerySubLocationLevel(vReturn)

        Call modControl.SetTextID(pcList, vReturn)

    End Function
    Public Function ListRefQueryWeekday(ByRef pcList As ComboBox) As Object

        Dim vReturn As New Object

        Call RefQueryWeekday(vReturn)

        Call modControl.SetTextID(pcList, vReturn)

    End Function


    Public Function ListRefQueryStatEmployee(ByRef pcList As ComboBox) As Object

        Dim vReturn As New Object

        Try
            Call RefQueryStatEmployee(vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        Call modControl.SetTextID(pcList, vReturn)

    End Function

    Public Function ListRefQueryStatEmployeeActiveOnly(ByRef pcList As ComboBox) As Object

        Dim vReturn As New Object

        Try
            Call RefQueryStatEmployeeActiveOnly(vReturn)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        Call modControl.SetTextID(pcList, vReturn)

    End Function
    Public Function ListRefQueryPhoneType(ByRef pcList As ComboBox) As Object

        Dim vReturn As New Object

        Call RefQueryPhoneType(vReturn)

        Call modControl.SetTextID(pcList, vReturn)

    End Function

    '	Public Function ListRefQueryOrganization(ByRef pcList As System.Windows.Forms.Control, Optional ByRef pvAddAllItem As Object = Nothing) As Object

    '		Dim vReturn As New Object

    '		Call RefQueryOrganization(vReturn)

    '		If IsNothing(pvAddAllItem) Then
    '			Call modControl.SetTextID(pcList, vReturn)
    '		Else
    '			Call modControl.SetTextID(pcList, vReturn, True, True)
    '		End If

    '	End Function
    Public Function RefQueryOrganization(ByRef prParams As Object, Optional ByRef pvID As Object = Nothing, Optional ByRef pvName As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing) As Short

        Dim vQuery As String = ""

        'Determine how to build the query
        If IsNothing(pvName) And IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get all items
            vQuery = "EXEC SelectRefQueryOrganization;"

        ElseIf IsNothing(pvName) And IsNothing(pvID) Then

            'Get all items of a certain item type
            vQuery = "EXEC SelectRefQueryOrganization @OrganizationTypeID = " & pvTypeID & ";"

        ElseIf IsNothing(pvName) And IsNothing(pvTypeID) Then

            'Get the item specified by the item id
            vQuery = "EXEC SelectRefQueryOrganization @OrganizationID = " & pvID & ";"

        ElseIf IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get the item specified by the item name
            vQuery = "EXEC SelectRefQueryOrganization @OrganizationName = " & modODBC.BuildField(pvName) & ";"

        ElseIf IsNothing(pvID) And Not IsNothing(pvName) And Not IsNothing(pvTypeID) Then

            'Get the item specified by the item name
            vQuery = "EXEC SelectRefQueryOrganization @OrganizationName = " & modODBC.BuildField(pvName) & ", " & "@OrganizationTypeID = " & pvTypeID & ";"

        End If

        'Fill a return parameter array
        Try
            RefQueryOrganization = modODBC.Exec(vQuery, prParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

    End Function


    Public Function RefQueryCall(ByRef prParams As Object, Optional ByRef pvID As Object = Nothing, Optional ByRef pvName As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing) As Short

        '************************************************************************************
        'Name: Form_Load
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Loads FrmReferral
        'Returns: Nothing
        'Params: None
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 4/25/06                          Changed by: Char Chaput
        'Release #: 8.0                              Release 8.0
        'Description:  Added checking if was save from the New Call screen by including
        'fields RecycledNC in the query. This returns back to FrmOpenAll
        'so that you can determine querys for FrmReferral if opened from the recycle bin.
        '====================================================================================
        'Date Changed: 8/22/06                          Changed by: Char Chaput
        'Release #: 8.2                              Release 8.2
        'Description:  Added CallOpenByID field to check if someone is in the call so that a
        'message can be displayed to a user saving a referral whom may have been overridden by
        'another user.
        '====================================================================================
        'Date Changed: 02/22/08                         Changed by: ccarroll
        'Release #: 8.4.5
        'Description:  Moved dynamic SQL to sproc. Deleted code which (possibly) caused referral information
        'to be combined with another. Ref: HelpStar 11308. Added Raise Error.
        'Keyword Search: HS 11308, HS11308, DataMerge CombinedReferrals
        '====================================================================================
        Dim vQuery As String = ""

        If IsNothing(pvName) And IsNothing(pvID) And IsNothing(pvTypeID) Then

            'ccarroll 02/22/2008
            'Rase Error: StatTrac needs to close because of low system resources.
            'parameters are missing because of memory loss.
            MsgBox("StatTrac needs to close because of low system resources." & Environment.NewLine & "Please record existing information and exit StatTrac.", MsgBoxStyle.Exclamation, "System Message")

            Err.Description = "Memory Loss: pvName, pvID and pvTypeID values are Null"
            LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())

        Else
            vQuery = "Exec GetCallInformation " & pvID & ";"

        End If
        Try
            RefQueryCall = modODBC.Exec(vQuery, prParams)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
            RefQueryCall = SQL_ERROR
        End Try

    End Function
    Public Function RefQueryStatEmployeePersonID(ByRef prParams As Object, Optional ByRef pvStatID As Object = Nothing) As Short

        On Error Resume Next

        Dim vQuery As String = ""
        Dim vReturn As New Object

        'ccarroll 06/08/06 StatTrac 8.0 Release
        'Get PersonID From StatEmployeeID in the StatEmployee Table
        'for Security check.
        vQuery = "SELECT " & "StatEmployee.PersonID " & "FROM StatEmployee " & "WHERE StatEmployee.StatEmployeeID = " & pvStatID & ";"



        'Fill the return parameter array
        RefQueryStatEmployeePersonID = modODBC.Exec(vQuery, prParams)

    End Function
    Public Function RefQueryReference(ByRef prParams As Object, Optional ByRef pvID As Object = Nothing, Optional ByRef pvName As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing) As Short

        On Error Resume Next

        Dim vQuery As String = ""


        'Determine how to build the query

        If IsNothing(pvName) And IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get all items
            vQuery = "SELECT DISTINCT Reference.ReferenceID, Reference.ReferenceText FROM Reference;"

        ElseIf IsNothing(pvName) And IsNothing(pvID) Then

            'Get all items of a certain item type
            vQuery = "SELECT DISTINCT Reference.ReferenceID, Reference.ReferenceText  FROM Reference WHERE ReferenceTypeID = " & pvTypeID & " ;"

        ElseIf IsNothing(pvName) And IsNothing(pvTypeID) Then

            'Get the item specified by the item id
            vQuery = "SELECT DISTINCT Reference.ReferenceID, Reference.ReferenceText FROM Reference WHERE ReferenceID = " & pvID & " ;"

        ElseIf IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get the item specified by the item name
            vQuery = "SELECT DISTINCT Reference.ReferenceID, Reference.ReferenceText FROM Reference WHERE ReferenceText = " & modODBC.BuildField(pvName) & " ;"

        ElseIf IsNothing(pvID) And Not IsNothing(pvTypeID) And Not IsNothing(pvName) Then

            'Get the item specified by the item name
            vQuery = "SELECT DISTINCT Reference.ReferenceID, Reference.ReferenceText FROM Reference WHERE ReferenceText = " & modODBC.BuildField(pvName) & " " & "AND ReferenceTypeID = " & pvTypeID & " ;"

        End If

        'Fill a return parameter array
        RefQueryReference = modODBC.Exec(vQuery, prParams)

    End Function


    Public Function RefQueryState(Optional ByRef pcList As Object = Nothing, Optional ByRef prParams As Object = Nothing, Optional ByRef pvID As Object = Nothing, Optional ByRef pvName As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing, Optional ByRef pvAddAllItem As Object = Nothing) As Short

        Dim vQuery As String = ""
        Dim ResultsArray As New Object

        'Determine how to build the query
        If IsNothing(pvName) And IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get all items
            vQuery = "SELECT DISTINCT State.StateID, State.StateAbbrv FROM State Order by StateAbbrv;" 'T.T 5/25/2005 put in Order by state to alphabitize the states in cbobox

        ElseIf IsNothing(pvName) And IsNothing(pvID) Then

            'Get all items of a certain item type
            'N/A

        ElseIf IsNothing(pvName) And IsNothing(pvTypeID) Then

            'Get the item specified by the item id
            vQuery = "SELECT DISTINCT State.StateID, State.StateAbbrv FROM State WHERE StateID = " & pvID & ";"

        ElseIf IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get the item specified by the item name
            vQuery = "SELECT DISTINCT State.StateID, State.StateAbbrv FROM State WHERE StateAbbrv = " & modODBC.BuildField(pvName) & ";"
        End If

        'Fill a return parameter array
        Try
            RefQueryState = modODBC.Exec(vQuery, ResultsArray)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If Not IsNothing(pcList) Then
            If IsNothing(pvAddAllItem) Then
                Call modControl.SetTextID(pcList, ResultsArray)
            Else
                Call modControl.SetTextID(pcList, ResultsArray, True, True)
            End If
        End If

        If Not IsNothing(prParams) Then
            prParams = ResultsArray
        End If

        Exit Function

    End Function
End Module