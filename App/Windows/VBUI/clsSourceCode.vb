Option Strict Off
Option Explicit On
Public Class clsSourceCode

    'Persistent
    Public Key As String
    Public ID As Integer
    Public Name As String
    Public Description As String
    Public CodeType As Integer
    Public CodeTypeName As String
    Public DefaultAlert As String
    Public LineCheckInstructions As String
    Public LineCheckInterval As Integer
    Public Organizations As New colOrganizations
    Public Parent As Object
    'Added for 7.7.2 to allow display of entire, unabbreviated
    'Source Code name.  12/8/04 - SAP
    Public NameUnAbbrev As String

    'Values equivalent to days of week starting
    'with Sunday (e.g. Sunday = 1, Monday = 2, etc.)
    Public LineActiveStart1 As Object
    Public LineActiveStart2 As Object
    Public LineActiveStart3 As Object
    Public LineActiveStart4 As Object
    Public LineActiveStart5 As Object
    Public LineActiveStart6 As Object
    Public LineActiveStart7 As Object
    Public LineActiveEnd1 As Object
    Public LineActiveEnd2 As Object
    Public LineActiveEnd3 As Object
    Public LineActiveEnd4 As Object
    Public LineActiveEnd5 As Object
    Public LineActiveEnd6 As Object
    Public LineActiveEnd7 As Object
    'T.T 01/22/07 added for DonorTrac client tracking
    Public SourcecodeDonorTracClient As Short

    'T.T 01/05/2005 Rotating sourceCodes
    Public SourceCodeRotationActive As Short
    Public SourceCodeRotationTrue As Short
    Public SourceCodeRotationAlias As String


    'Transiant
    Public LineInactive As Boolean

    Public WebReportGroupAccessOrgans As Short
    Public WebReportGroupAccessBone As Short
    Public WebReportGroupAccessTissue As Short
    Public WebReportGroupAccessSkin As Short
    Public WebReportGroupAccessValves As Short
    Public WebReportGroupAccessEyes As Short
    Public WebReportGroupAccessResearch As Short

    Public WebReportGroupAccessOrgansUpdate As Short
    Public WebReportGroupAccessBoneUpdate As Short
    Public WebReportGroupAccessTissueUpdate As Short
    Public WebReportGroupAccessSkinUpdate As Short
    Public WebReportGroupAccessValvesUpdate As Short
    Public WebReportGroupAccessEyesUpdate As Short
    Public WebReportGroupAccessResearchUpdate As Short


    Public WebReportGroupAccessTypeOTE As Short
    Public WebReportGroupAccessTypeTE As Short
    Public WebReportGroupAccessTypeEyeOnly As Short
    Public WebReportGroupAccessTypeRuleout As Short
    Public Function GetItem(Optional ByRef pvID As Object = Nothing, Optional ByRef pvName As Object = Nothing, Optional ByRef pvTypeID As Object = Nothing) As Short
        '************************************************************************************
        'Name: GetItem
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Retrieves SourceCode info from database and populates object's variables
        'Returns: Integer
        'Params: pvID, pvName, pvTypeId
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 12/8/04                          Changed by: Scott Plummer
        'Release #: 7.7.2                               Task: 312
        'Description:  Populate new variable, NameUnAbbrev, from DB
        '====================================================================================
        '************************************************************************************
        On Error GoTo localError

        Dim vQuery As String = ""
        Dim vReturn As Short
        Dim vResultArray As New Object
        Dim I As Short

        vQuery = "GetSourceCode "

        'Determine Parameters to pass
        If IsNothing(pvName) And IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get all items
            vQuery = vQuery & "GetSourceCode  "

        ElseIf IsNothing(pvName) And IsNothing(pvID) Then

            'Get the item specified by the item type id
            vQuery = vQuery & "@SourceCodeType = " & pvTypeID & ", "

        ElseIf IsNothing(pvName) And IsNothing(pvTypeID) Then

            'Get the item specified by the item id
            vQuery = vQuery & "@SourceCodeID = " & pvID & ", "

        ElseIf IsNothing(pvID) And IsNothing(pvTypeID) Then

            'Get the item specified by the item name
            vQuery = vQuery & "@SourceCodeName = " & modODBC.BuildField(pvName) & ", "

        ElseIf IsNothing(pvID) And Not IsNothing(pvTypeID) And Not IsNothing(pvName) Then

            vQuery = vQuery & "@SourceCodeName = " & modODBC.BuildField(pvName) & ", " & "@SourceCodeType = " & modODBC.BuildField(pvTypeID) & ", "

        End If

        'Added bjk 06/2001: Lease Organization
        'Check if LeaseOrganization 
        If AppMain.ParentForm.LeaseOrganization <> 0 Then
            vQuery = vQuery & "@SourceCodeLeaseOrganizationID = " & AppMain.ParentForm.LeaseOrganization & ", "
            vQuery = vQuery.Replace("GetSourceCode", "GetSourceCodeLO")
        End If

        'replace trailing ', '
        vQuery = vQuery.Substring(0, vQuery.Length - 2)

        GetItem = modODBC.Exec(vQuery, vResultArray)
        'T.T 01/04/05 Added to create new source code identifyer
        'jth 5/10 comment out...no need for code and field is never -1
        'If GetItem = SUCCESS Then
        '    If UBound(vResultArray, 1) >= 1 Then
        '        vQuery = vQuery & " and SourceCodeRotationActive = -1"
        '        GetItem = modODBC.Exec(vQuery, vResultArray)
        '    End If
        'End If

        If GetItem = SUCCESS Then

            'Set the properties of the new item
            Me.Key = "k" & CStr(vResultArray(0, 0))
            Me.ID = vResultArray(0, 0)
            Me.Name = vResultArray(0, 1)
            Me.Description = vResultArray(0, 2)
            '04/21/2011 ccarroll - Added OASIS to case statement for SourceCode report group type
            Me.CodeType = vResultArray(0, 3)
            Select Case Me.CodeType
                Case REFERRAL
                    Me.CodeTypeName = "Referral"
                Case Message
                    Me.CodeTypeName = "Message"
                Case IMPORT
                    Me.CodeTypeName = "Import"
                Case OASIS
                    Me.CodeTypeName = "OASIS"
            End Select
            Me.DefaultAlert = vResultArray(0, 4)
            Me.LineCheckInstructions = vResultArray(0, 5)
            Me.LineCheckInterval = vResultArray(0, 6)

            Me.LineActiveStart1 = vResultArray(0, 7)
            Me.LineActiveStart2 = vResultArray(0, 8)
            Me.LineActiveStart3 = vResultArray(0, 9)
            Me.LineActiveStart4 = vResultArray(0, 10)
            Me.LineActiveStart5 = vResultArray(0, 11)
            Me.LineActiveStart6 = vResultArray(0, 12)
            Me.LineActiveStart7 = vResultArray(0, 13)

            Me.LineActiveEnd1 = vResultArray(0, 14)
            Me.LineActiveEnd2 = vResultArray(0, 15)
            Me.LineActiveEnd3 = vResultArray(0, 16)
            Me.LineActiveEnd4 = vResultArray(0, 17)
            Me.LineActiveEnd5 = vResultArray(0, 18)
            Me.LineActiveEnd6 = vResultArray(0, 19)
            Me.LineActiveEnd7 = vResultArray(0, 20)
            'Added for 7.7.2 to allow display of entire, unabbreviated
            'Source Code name.  12/8/04 - SAP
            'If no unabbreviated name exists, put short name in here.
            If vResultArray(0, 21) > "" Then
                Me.NameUnAbbrev = vResultArray(0, 21)
            Else
                Me.NameUnAbbrev = Me.Name
            End If

        End If
        Exit Function
localError:
        Resume Next
        Resume

    End Function

    Public Function Delete() As Boolean

        On Error GoTo localError

        Dim vQuery As String = ""
        Dim vReturn As Short

        'Delete from the SourceCode table
        vQuery = "DELETE SourceCode WHERE SourceCodeID = " & Me.ID

        vReturn = modODBC.Exec(vQuery)

        If vReturn Then
            Delete = True
        Else
            Delete = False
        End If

        Exit Function

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        Delete = False

    End Function
    Public Function CheckLineActivity() As Boolean

        On Error GoTo localError

        Dim vQuery As String = ""
        Dim vReturn As Short
        Dim vResultArray As New Object
        Dim vWeekDay As Short
        Dim vStartDateTime As Date
        Dim vEndDateTime As Date

        If Me.LineCheckInterval = 0 Then
            'If  the line check interval is 0, then do not check for
            'activity and set line inactive property to false
            Me.LineInactive = False
            CheckLineActivity = True
            Exit Function
        Else

            If GetActivityPeriod(vStartDateTime, vEndDateTime) = SUCCESS Then

                If Now >= vStartDateTime And Now <= vEndDateTime Then
                    'Check activity because it is within an activity check period
                    vQuery = "SELECT CallDateTime FROM Call " & "WHERE SourceCodeID = " & Me.ID & " " & "AND CallDateTime >= " & modODBC.BuildField(DateAdd(Microsoft.VisualBasic.DateInterval.Minute, -Me.LineCheckInterval, Now))

                    vReturn = modODBC.Exec(vQuery, vResultArray)

                    If vReturn = SUCCESS Then
                        Me.LineInactive = False
                        CheckLineActivity = True
                    ElseIf vReturn = NO_DATA Then
                        Me.LineInactive = True
                        CheckLineActivity = True
                    Else
                        Me.LineInactive = True
                        CheckLineActivity = False
                    End If
                Else
                    'Current time is outside of activity check period, so
                    'no need to check for activity
                    Me.LineInactive = False
                    CheckLineActivity = True
                End If

            Else
                Me.LineInactive = True
                CheckLineActivity = False
                Exit Function
            End If

        End If

        Exit Function

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        CheckLineActivity = False

    End Function

    Public Function Save() As Boolean
        '************************************************************************************
        'Name: Save
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Save values of SourceCode variables into database
        'Returns: Boolean
        'Params: None
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 12/8/04                          Changed by: Scott Plummer
        'Release #: 7.7.2                               Task: 312
        'Description:  Save new variable, NameUnAbbrev to DB
        '====================================================================================
        '************************************************************************************

        On Error GoTo localError

        Dim vQuery As String = ""
        Dim vValues As String = ""
        Dim vResultArray As New Object
        Dim vResult As Short
        Dim I As Short

        'Set the field values
        Dim vParams(24) As Object

        vParams(0) = Me.Name
        vParams(1) = Me.Description
        vParams(2) = Me.CodeType
        vParams(3) = Me.DefaultAlert
        vParams(4) = Me.LineCheckInstructions
        vParams(5) = Me.LineCheckInterval

        vParams(6) = Me.LineActiveStart1
        vParams(7) = Me.LineActiveStart2
        vParams(8) = Me.LineActiveStart3
        vParams(9) = Me.LineActiveStart4
        vParams(10) = Me.LineActiveStart5
        vParams(11) = Me.LineActiveStart6
        vParams(12) = Me.LineActiveStart7

        vParams(13) = Me.LineActiveEnd1
        vParams(14) = Me.LineActiveEnd2
        vParams(15) = Me.LineActiveEnd3
        vParams(16) = Me.LineActiveEnd4
        vParams(17) = Me.LineActiveEnd5
        vParams(18) = Me.LineActiveEnd6
        vParams(19) = Me.LineActiveEnd7
        'Added for 7.7.2 to allow display of entire, unabbreviated
        'Source Code name.  12/8/04 - SAP
        vParams(20) = Me.NameUnAbbrev
        'T.T 01/04/05 added for RotationSourceCodes
        vParams(21) = 0
        vParams(22) = Me.SourceCodeRotationTrue
        vParams(23) = Me.SourceCodeRotationAlias
        'T.T 01/22/07 DonorTrac client tracking
        vParams(24) = Me.SourcecodeDonorTracClient



        'Specify the table fields
        Dim vFields(24) As Object

        vFields(0) = "SourceCodeName"
        vFields(1) = "SourceCodeDescription"
        vFields(2) = "SourceCodeType"
        vFields(3) = "SourceCodeDefaultAlert"
        vFields(4) = "SourceCodeLineCheckInstruc"
        vFields(5) = "SourceCodeLineCheckInterval"
        For I = 1 To 7
            vFields(5 + I) = "SourceCode" & I & "Start"
        Next I
        For I = 1 To 7
            vFields(12 + I) = "SourceCode" & I & "End"
        Next I
        'Added for 7.7.2 to allow display of entire, unabbreviated
        'Source Code name.  12/8/04 - SAP
        vFields(20) = "SourceCodeNameUnAbbrev"
        vFields(21) = "SourceCodeRotationActive"
        vFields(22) = "SourceCodeRotationTrue"
        vFields(23) = "SourceCodeRotationAlias"
        vFields(24) = "SourcecodeDonorTracClient"



        If Me.ID = -1 Then
            'Build and execute the query
            vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)
            vQuery = "INSERT INTO SourceCode (" & vValues & ")"
            vResult = modODBC.Exec(vQuery, vResultArray)
            Me.ID = CInt(CStr(vResultArray(0, 0)))
            Me.Key = "k" & CStr(Me.ID)
        Else
            'Build and execute the query
            vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)
            vQuery = "UPDATE SourceCode SET " & vValues & " WHERE SourceCodeID = " & Me.ID
            vResult = modODBC.Exec(vQuery)
        End If


        If vResult = SUCCESS Then
            Save = True
        Else
            Save = False
        End If

        Exit Function

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        Save = False
        Exit Function

    End Function





    Private Sub Class_Initialize_Renamed()

        Me.Organizations.Parent = Me

    End Sub
    Public Sub New()
        MyBase.New()
        Class_Initialize_Renamed()
    End Sub



    Private Function GetActivityPeriod(ByRef prStartDateTime As Object, ByRef prEndDateTime As Object) As Object

        Dim vResultArray As New Object
        Dim vStartTime As String = ""
        Dim vEndTime As String = ""
        Dim vQuery As String = ""
        Dim vReturn As Short


        'Check if line activity should be checked.
        vQuery = "SELECT " & "SourceCode" & Weekday(Now) & "Start, " & "SourceCode" & Weekday(Now) & "End " & "FROM SourceCode WHERE SourceCodeID = " & Me.ID

        vReturn = modODBC.Exec(vQuery, vResultArray)

        If vReturn = SUCCESS Then

            vStartTime = vResultArray(0, 0)
            vEndTime = vResultArray(0, 1)

            'Check shifts that don't cross midnight
            If vEndTime > vStartTime Then

                If CStr(VB6.Format(TimeOfDay, "hh:mm")) > vStartTime And CStr(VB6.Format(TimeOfDay, "hh:mm")) < vEndTime Then

                    'Set the data
                    prStartDateTime = VB6.Format(Now, "mm/dd/yy") & " " & vStartTime
                    prEndDateTime = VB6.Format(Now, "mm/dd/yy") & " " & vEndTime

                End If

                'Check shifts that cross midnight
            ElseIf vStartTime >= vEndTime Then

                If (CStr(VB6.Format(TimeOfDay, "hh:mm")) > vStartTime And CStr(VB6.Format(TimeOfDay, "hh:mm")) <= "23:59") Then

                    'Set the data
                    prStartDateTime = VB6.Format(Now, "mm/dd/yy") & " " & vStartTime
                    prEndDateTime = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Day, 1, Now), "mm/dd/yy") & " " & vEndTime

                ElseIf (CStr(VB6.Format(TimeOfDay, "hh:mm")) > "00:00" And CStr(VB6.Format(TimeOfDay, "hh:mm")) <= vEndTime) Then

                    'If after midnight, get the previous day
                    prStartDateTime = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Day, -1, Now), "mm/dd/yy") & " " & vStartTime
                    prEndDateTime = VB6.Format(Now, "mm/dd/yy") & " " & vEndTime

                End If

            End If

            GetActivityPeriod = SUCCESS

        Else
            GetActivityPeriod = SQL_ERROR
        End If



    End Function
End Class