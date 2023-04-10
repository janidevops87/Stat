Option Strict Off
Option Explicit On
Public Class clsRotation

    'Persistent
    Public Key As String
    Public ID As Integer


    Public AlertID As Short 'AlertID
    Public AlertName As String 'AlertName
    Public AlertType As Short 'AlertType - Referrals ect..
    Public AlertID2 As Short 'AlertID2
    Public AlertName2 As String 'AlertName
    Public AlertType2 As Short 'AlertType2 - Referrals ect..
    Public SourceCodeID As Short 'SourceCodeID
    Public SourceCodeName As String 'SourceCodeName
    Public SourceCodeType As Short 'SourceCodeType
    Public ReportGroupID As Short 'ReportGroupID
    Public ReportGroupName As String 'ReportGroupName
    Public ReportGroupType As Short 'ReportGroupType
    Public ReportGroupTypeName As String 'Reporttypename
    Public ScheduleGroupID As Short 'ScheduleGroupID
    Public ScheduleGroupName As String 'ScheduleGroupName
    Public ScheduleGroupType As Short 'ScheduleGroupType
    Public ScheduleGroupTypeName As String 'SchedulegroupTypeName
    Public Saved As Short 'Saved form
    Public Loaded As Short 'Loaded form
    Public CriteriaStatusID As Short 'CriteriaStatusID
    Public CriteriaGroupName As String 'CriteriaGroupName
    Public CriteriaGroupID As Integer 'GroupID
    Public CriteriaType As Short 'CriteriaType
    Public DonorCategoryID As Short 'DonorCategoryID
    Public Organizationscheduleid As Short 'OrganizationScheduleID
    Public Organizationscheduleid2 As Short 'OrganizationScheduleID2
    Public RotationOne As Short 'Current RotationID
    Public RotationNext As Short 'Next RotationID
    Public RotationOneName As String 'Name of Rotation
    Public RotationNextName As String 'Name of Rotation
    Public RotationGroupID As Object 'Group RotationID
    Public RotationServiceLevelID As Object 'Group ServiceLevelID
    Public RotationServiceLevelName As Object 'Group ServiceLevelName
    Const Alerts As Short = 1
    Const Criteria As Short = 2
    Const ServiceLevel As Short = 3
    Const SourceCodes As Short = 4
    Const ReportGroups As Short = 5
    Const Schedules As Short = 6
    Const MSFlex1 As Short = 1
    Const MSFlex2 As Short = 2
    Const MSFlex3 As Short = 3
    Public Function FillMsFlex3() As Boolean



        '*********************************************************************************
        'Name: FillMsFlex3
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function fills the flexgrid1
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        Dim lngWidth As Object
        Dim vRS As ADODB.Recordset
        Dim count As Object
        Dim I As Object
        Dim RotationName As String
        Const Scroll_Bar_Width As Short = 300
        'Fill Flexgrid
        With AppMain.frmRotateOrganization.MSFlexGrid3
            .Clear()
            lngWidth = VB6.PixelsToTwipsX(.Width) - Scroll_Bar_Width
            .Cols = 6
            .Rows = 1
            .WordWrap = True

            .set_ColWidth(0, VB6.PixelsToTwipsX(.Width) / 5)
            .set_ColWidth(1, VB6.PixelsToTwipsX(.Width) / 3)
            .set_ColWidth(2, VB6.PixelsToTwipsX(.Width) / 3)
            .set_ColWidth(3, VB6.PixelsToTwipsX(.Width) / 5)
            .set_ColWidth(4, VB6.PixelsToTwipsX(.Width) / 3)
            .set_ColWidth(5, VB6.PixelsToTwipsX(.Width) / 3)

            .set_TextMatrix(0, 0, "Sequence")
            .set_TextMatrix(0, 1, "RotationName")
            .set_TextMatrix(0, 2, "ServiceLevel")
            .set_TextMatrix(0, 3, "RotationID")
            .set_TextMatrix(0, 4, "LastRotation")
            .set_TextMatrix(0, 5, "NextRotation")

            vRS = modStatQuery.QueryRotationSequenceMatrix((Me.RotationGroupID))
            count = 1

            Do While vRS.EOF = False
                .Rows = count + 1
                If vRS.Fields("RotationSequence").Value > 0 Then
                    .set_TextMatrix(count, 0, vRS.Fields("RotationSequence").Value)
                End If


                If count = Me.RotationOne Then
                    For I = 0 To 3
                        .Row = count
                        .Col = I
                        .CellBackColor = System.Drawing.Color.Yellow
                    Next I
                End If
                If vRS.Fields("RotationName").Value <> "" Then
                    .set_TextMatrix(count, 1, vRS.Fields("RotationName").Value)
                End If
                If Not IsDBNull(vRS.Fields("ServiceLevelName").Value) Then

                    If vRS.Fields("ServiceLevelName").Value <> "" Then
                        .set_TextMatrix(count, 2, vRS.Fields("ServiceLevelName").Value)
                    End If
                End If
                .set_TextMatrix(count, 3, vRS.Fields("RotationID").Value)
                If IsDate(vRS.Fields("RotationLastRun").Value) Then
                    .set_TextMatrix(count, 4, vRS.Fields("RotationLastRun").Value)
                End If
                If IsDate(vRS.Fields("RotationNextRun").Value) Then
                    .set_TextMatrix(count, 5, vRS.Fields("RotationNextRun").Value)
                End If


                vRS.MoveNext()
                count = count + 1
            Loop

        End With
        vRS = Nothing
    End Function
    Public Function FillMsFlex2() As Boolean


        '*********************************************************************************
        'Name: FillMsFlex2
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function fills the flexgrid1
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        Dim lngWidth As Object
        Dim vRS As ADODB.Recordset
        Dim count As Object
        Dim RotationName As String
        Const Scroll_Bar_Width As Short = 300
        'Fill Flexgrid
        With AppMain.frmRotateOrganization.MSFlexGrid2
            .Clear()
            lngWidth = VB6.PixelsToTwipsX(.Width) - Scroll_Bar_Width
            .Cols = 4
            .Rows = 1
            .WordWrap = True

            .set_ColWidth(0, VB6.PixelsToTwipsX(.Width) / 3)
            .set_ColWidth(1, VB6.PixelsToTwipsX(.Width) / 3)
            .set_ColWidth(2, VB6.PixelsToTwipsX(.Width) / 2)
            .set_ColWidth(3, VB6.PixelsToTwipsX(.Width) / 4)

            .set_TextMatrix(0, 0, "Maintain")
            .set_TextMatrix(0, 1, "Type")
            .set_TextMatrix(0, 2, "Group")
            .set_TextMatrix(0, 3, "ID")
            'Get RotationName**********************************************************
            RotationName = modStatQuery.QueryRotationName((Me.RotationNext), (Me.RotationGroupID))
            AppMain.frmRotateOrganization.lblRotationName2.Text = RotationName
            'Get Alerts************************************************************************
            count = 1
            vRS = modStatQuery.QueryRotationAlerts((Me.RotationGroupID), (Me.RotationNext))

            Do While vRS.EOF = False
                .Rows = count + 1

                'Maintain
                .set_TextMatrix(count, 0, "Alerts")

                'AlertType
                Select Case vRS.Fields("AlertType").Value
                    Case Is = 1
                        .set_TextMatrix(count, 1, "Referral")
                    Case Is = 2
                        .set_TextMatrix(count, 1, "Message")
                    Case Is = 4
                        .set_TextMatrix(count, 1, "Imports")
                End Select
                'GroupName
                .set_TextMatrix(count, 2, vRS.Fields("AlertGroupName").Value)

                'RowData
                .set_TextMatrix(count, 3, vRS.Fields("AlertID").Value)

                count = count + 1
                vRS.MoveNext()
            Loop
            vRS = Nothing
            'End Get Alerts****************************************************************
            'Get Criteria******************************************************************

            vRS = modStatQuery.QueryRotationCriteria((Me.RotationGroupID), (Me.RotationNext))
            Do While vRS.EOF = False
                .Rows = count + 1

                'Maintain
                .set_TextMatrix(count, 0, "Criteria")

                'AlertType
                Select Case vRS.Fields("CriteriaType").Value
                    Case Is = 1
                        .set_TextMatrix(count, 1, "Organs")
                    Case Is = 2
                        .set_TextMatrix(count, 1, "Bone")
                    Case Is = 3
                        .set_TextMatrix(count, 1, "SoftTissue")
                    Case Is = 4
                        .set_TextMatrix(count, 1, "Skin")
                    Case Is = 5
                        .set_TextMatrix(count, 1, "Valves")
                    Case Is = 6
                        .set_TextMatrix(count, 1, "Eyes")
                    Case Is = 7
                        .set_TextMatrix(count, 1, "Other")
                End Select
                'GroupName
                .set_TextMatrix(count, 2, vRS.Fields("CriteriaGroupName").Value)

                'RowData
                .set_TextMatrix(count, 3, vRS.Fields("CriteriaGroupID").Value)

                count = count + 1
                vRS.MoveNext()
            Loop

            vRS = Nothing
            'Get Criteria End******************************************************************
            'Get ServiceLevel**************************************************************
            vRS = modStatQuery.QueryRotationServiceLevel((Me.RotationGroupID), (Me.RotationNext))

            Do While vRS.EOF = False
                If Not IsDBNull(vRS.Fields("ServiceLevelID").Value) Then

                    If vRS.Fields("ServiceLevelID").Value > 0 Then
                        .Rows = count + 1

                        'Maintain
                        .set_TextMatrix(count, 0, "ServiceLevel")

                        'GroupName
                        .set_TextMatrix(count, 2, vRS.Fields("ServiceLevelName").Value)

                        'RowData
                        .set_TextMatrix(count, 3, vRS.Fields("ServiceLevelID").Value)

                        count = count + 1

                    End If
                End If
                vRS.MoveNext()

            Loop
            vRS = Nothing
            'Get SourceCode********************************************************************
            vRS = modStatQuery.QueryRotationSourceCodes((Me.RotationGroupID), (Me.RotationNext))
            Do While vRS.EOF = False
                .Rows = count + 1

                'Maintain
                .set_TextMatrix(count, 0, "SourceCode")

                'SourceCode
                Select Case vRS.Fields("RotationSourceCodeType").Value
                    Case Is = 1
                        .set_TextMatrix(count, 1, "Referral")
                    Case Is = 2
                        .set_TextMatrix(count, 1, "Messages")
                    Case Is = 4
                        .set_TextMatrix(count, 1, "Imports")
                    Case Is = 5
                        .set_TextMatrix(count, 1, "Information")
                End Select
                'GroupName
                .set_TextMatrix(count, 2, vRS.Fields("RotationSourcecodeName").Value)

                'RowData
                .set_TextMatrix(count, 3, vRS.Fields("RotationSourceCodeID").Value)

                count = count + 1
                vRS.MoveNext()

            Loop
            'Get Sourcecode End******************************************************************
            'Get ReportGroups********************************************************************
            vRS = modStatQuery.QueryRotationReportGroups((Me.RotationGroupID), (Me.RotationNext))
            Do While vRS.EOF = False
                .Rows = count + 1

                'Maintain
                .set_TextMatrix(count, 0, "ReportGroups")

                'ReportGroups
                .set_TextMatrix(count, 1, vRS.Fields("RotationReportGroupTypeName").Value)

                'GroupName
                .set_TextMatrix(count, 2, vRS.Fields("RotationReportGroupName").Value)

                'RowData
                .set_TextMatrix(count, 3, vRS.Fields("RotationReportGroupID").Value)
                .set_RowData(count, vRS.Fields("RotationReportGroupType").Value)
                count = count + 1
                vRS.MoveNext()

            Loop
            vRS = Nothing
            'Get ReportGroups End*****************************************************************
            'Get ScheduleGroups********************************************************************
            vRS = modStatQuery.QueryRotationScheduleGroups((Me.RotationGroupID), (Me.RotationNext))
            Do While vRS.EOF = False
                .Rows = count + 1

                'Maintain
                .set_TextMatrix(count, 0, "ScheduleGroups")

                'ReportGroups
                .set_TextMatrix(count, 1, vRS.Fields("RotationScheduleGroupTypeName").Value)

                'GroupName
                .set_TextMatrix(count, 2, vRS.Fields("RotationScheduleGroupName").Value)

                'RowData
                .set_TextMatrix(count, 3, vRS.Fields("RotationScheduleGroupID").Value)
                .set_RowData(count, vRS.Fields("RotationScheduleGroupType").Value)
                count = count + 1
                vRS.MoveNext()

            Loop
            vRS = Nothing
        End With
    End Function
    Public Function FillMsFlex1() As Boolean
        '*********************************************************************************
        'Name: FillMsFlex
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function fills the flexgrid1
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        Dim lngWidth As Object
        Dim vRS As ADODB.Recordset
        Dim count As Object
        Dim RotationName As String
        Const Scroll_Bar_Width As Short = 300
        'Fill Flexgrid

        With AppMain.frmRotateOrganization.MSFlexGrid1
            .Clear()
            lngWidth = VB6.PixelsToTwipsX(.Width) - Scroll_Bar_Width
            .Cols = 4
            .Rows = 1
            .WordWrap = True

            .set_ColWidth(0, VB6.PixelsToTwipsX(.Width) / 3)
            .set_ColWidth(1, VB6.PixelsToTwipsX(.Width) / 3)
            .set_ColWidth(2, VB6.PixelsToTwipsX(.Width) / 2)
            .set_ColWidth(3, VB6.PixelsToTwipsX(.Width) / 4)




            .set_TextMatrix(0, 0, "Maintain")
            .set_TextMatrix(0, 1, "Type")
            .set_TextMatrix(0, 2, "Group")
            .set_TextMatrix(0, 3, "ID")

            'Get RotationName**********************************************************
            RotationName = modStatQuery.QueryRotationName((Me.RotationOne), (Me.RotationGroupID))
            AppMain.frmRotateOrganization.lblRotationName.Text = RotationName
            'Get Alerts****************************************************************
            count = 1
            vRS = modStatQuery.QueryRotationAlerts((Me.RotationGroupID), (Me.RotationOne))
            Do While vRS.EOF = False
                .Rows = count + 1

                'Maintain
                .set_TextMatrix(count, 0, "Alerts")

                'AlertType
                Select Case vRS.Fields("AlertType").Value
                    Case Is = 1
                        .set_TextMatrix(count, 1, "Referral")
                    Case Is = 2
                        .set_TextMatrix(count, 1, "Message")
                    Case Is = 4
                        .set_TextMatrix(count, 1, "Imports")
                End Select
                'GroupName
                .set_TextMatrix(count, 2, vRS.Fields("AlertGroupName").Value)

                'RowData
                .set_TextMatrix(count, 3, vRS.Fields("AlertID").Value)

                count = count + 1
                vRS.MoveNext()
            Loop
            vRS = Nothing
            'End Get Alerts****************************************************************
            'Get Criteria******************************************************************

            vRS = modStatQuery.QueryRotationCriteria((Me.RotationGroupID), (Me.RotationOne))
            Do While vRS.EOF = False
                .Rows = count + 1

                'Maintain
                .set_TextMatrix(count, 0, "Criteria")

                'Criteria
                Select Case vRS.Fields("CriteriaType").Value
                    Case Is = 1
                        .set_TextMatrix(count, 1, "Organs")
                    Case Is = 2
                        .set_TextMatrix(count, 1, "Bone")
                    Case Is = 3
                        .set_TextMatrix(count, 1, "SoftTissue")
                    Case Is = 4
                        .set_TextMatrix(count, 1, "Skin")
                    Case Is = 5
                        .set_TextMatrix(count, 1, "Valves")
                    Case Is = 6
                        .set_TextMatrix(count, 1, "Eyes")
                    Case Is = 7
                        .set_TextMatrix(count, 1, "Other")
                End Select
                'GroupName
                .set_TextMatrix(count, 2, vRS.Fields("CriteriaGroupName").Value)

                'RowData
                .set_TextMatrix(count, 3, vRS.Fields("CriteriaGroupID").Value)

                count = count + 1
                vRS.MoveNext()

            Loop
            vRS = Nothing
            'Get Criteria End******************************************************************
            'Get ServiceLevel**************************************************************
            vRS = modStatQuery.QueryRotationServiceLevel((Me.RotationGroupID), (Me.RotationOne))
            Do While vRS.EOF = False
                If Not IsDBNull(vRS.Fields("ServiceLevelID").Value) Then


                    If vRS.Fields("ServiceLevelID").Value > 0 Then
                        .Rows = count + 1

                        'Maintain
                        .set_TextMatrix(count, 0, "ServiceLevel")

                        'GroupName
                        .set_TextMatrix(count, 2, vRS.Fields("ServiceLevelName").Value)

                        'RowData
                        .set_TextMatrix(count, 3, vRS.Fields("ServiceLevelID").Value)

                        count = count + 1
                    End If
                End If
                vRS.MoveNext()

            Loop
            vRS = Nothing
            'Get ServiceLevel End**************************************************************
            'Get SourceCode********************************************************************
            vRS = modStatQuery.QueryRotationSourceCodes((Me.RotationGroupID), (Me.RotationOne))
            Do While vRS.EOF = False
                .Rows = count + 1

                'Maintain
                .set_TextMatrix(count, 0, "SourceCode")

                'SourceCode
                Select Case vRS.Fields("RotationSourceCodeType").Value
                    Case Is = 1
                        .set_TextMatrix(count, 1, "Referral")
                    Case Is = 2
                        .set_TextMatrix(count, 1, "Messages")
                    Case Is = 4
                        .set_TextMatrix(count, 1, "Imports")
                    Case Is = 5
                        .set_TextMatrix(count, 1, "Information")
                End Select
                'GroupName
                .set_TextMatrix(count, 2, vRS.Fields("RotationSourcecodeName").Value)

                'RowData
                .set_TextMatrix(count, 3, vRS.Fields("RotationSourceCodeID").Value)

                count = count + 1
                vRS.MoveNext()

            Loop
            vRS = Nothing
            'SourceCode End**********************************************************
            'Get ReportGroups********************************************************************
            vRS = modStatQuery.QueryRotationReportGroups((Me.RotationGroupID), (Me.RotationOne))
            Do While vRS.EOF = False
                .Rows = count + 1

                'Maintain
                .set_TextMatrix(count, 0, "ReportGroups")

                'ReportGroups
                .set_TextMatrix(count, 1, vRS.Fields("RotationReportGroupTypeName").Value)

                'GroupName
                .set_TextMatrix(count, 2, vRS.Fields("RotationReportGroupName").Value)

                'RowData
                .set_TextMatrix(count, 3, vRS.Fields("RotationReportGroupID").Value)
                .set_RowData(count, vRS.Fields("RotationReportGroupType").Value)
                count = count + 1
                vRS.MoveNext()

            Loop
            vRS = Nothing
            'Get ReportGroups End*****************************************************************
            'Get ScheduleGroups********************************************************************
            vRS = modStatQuery.QueryRotationScheduleGroups((Me.RotationGroupID), (Me.RotationOne))
            Do While vRS.EOF = False
                .Rows = count + 1

                'Maintain
                .set_TextMatrix(count, 0, "ScheduleGroups")

                'ReportGroups
                .set_TextMatrix(count, 1, vRS.Fields("RotationScheduleGroupTypeName").Value)

                'GroupName
                .set_TextMatrix(count, 2, vRS.Fields("RotationScheduleGroupName").Value)

                'RowData
                .set_TextMatrix(count, 3, vRS.Fields("RotationScheduleGroupID").Value)
                .set_RowData(count, vRS.Fields("RotationScheduleGroupType").Value)
                count = count + 1
                vRS.MoveNext()

            Loop
            vRS = Nothing
        End With

    End Function
    Public Function AddScheduleGroup() As Boolean
        '*********************************************************************************
        'Name: AddScheduleGroup
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function will add a schedule group to the Rotationschedulegroup table
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        'Add ScheduleGroup
        On Error GoTo localError
        Dim vQuery As String
        vQuery = "Insert into RotationscheduleGroup (RotationGroupID,RotationID,RotationScheduleGroupID,RotationScheduleGroupName,RotationScheduleGroupType,RotationScheduleGroupTypeName) values (" & Me.RotationGroupID & "," & Me.RotationOne & "," & Me.ScheduleGroupID & ",'" & Me.ScheduleGroupName & "'," & Me.ScheduleGroupType & ",'" & Me.ScheduleGroupTypeName & "')"
        Call modODBC.Exec(vQuery)

        Exit Function
localError:
        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
    End Function
    Public Function AddScheduleGroup2() As Boolean
        '*********************************************************************************
        'Name: AddScheduleGroup
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function will add a schedule group to the Rotationschedulegroup table
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        'Add ScheduleGroup
        On Error GoTo localError
        Dim vQuery As String
        vQuery = "Insert into RotationscheduleGroup (RotationGroupID,RotationID,RotationScheduleGroupID,RotationScheduleGroupName,RotationScheduleGroupType,RotationScheduleGroupTypeName) values (" & Me.RotationGroupID & "," & Me.RotationNext & "," & Me.ScheduleGroupID & ",'" & Me.ScheduleGroupName & "'," & Me.ScheduleGroupType & ",'" & Me.ScheduleGroupTypeName & "')"
        Call modODBC.Exec(vQuery)

        Exit Function
localError:
        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
    End Function
    Public Function AddReportGroup() As Boolean
        '*********************************************************************************
        'Name: AddReportGroup
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function will add a schedule group to the RotationReportGroup table
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        'Add ReportGroup
        On Error GoTo localError
        Dim vQuery As String
        vQuery = "Insert into RotationReportGroup (RotationGroupID,RotationID,RotationReportGroupID,RotationReportGroupName,RotationReportGroupType,RotationReportGroupTypeName) values (" & Me.RotationGroupID & "," & Me.RotationOne & "," & Me.ReportGroupID & ",'" & Me.ReportGroupName & "'," & Me.ReportGroupType & ",'" & Me.ReportGroupTypeName & "')"
        Call modODBC.Exec(vQuery)
        Exit Function
localError:
        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
    End Function

    Public Function AddReportGroup2() As Boolean
        '*********************************************************************************
        'Name: AddReportGroup
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function will add a schedule group to the RotationReportGroup table
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        'Add ReportGroup
        On Error GoTo localError
        Dim vQuery As String
        vQuery = "Insert into RotationReportGroup (RotationGroupID,RotationID,RotationReportGroupID,RotationReportGroupName,RotationReportGroupType,RotationReportGroupTypeName) values (" & Me.RotationGroupID & "," & Me.RotationNext & "," & Me.ReportGroupID & ",'" & Me.ReportGroupName & "'," & Me.ReportGroupType & ",'" & Me.ReportGroupTypeName & "')"
        Call modODBC.Exec(vQuery)
        Exit Function
localError:
        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
    End Function
    Public Function AddSourceCode() As Boolean
        '*********************************************************************************
        'Name: AddSourceCode
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function will add a schedule group to the RotationSourceCode table
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        'Add SourceCode to Rotation
        On Error GoTo localError
        Dim vQuery As String
        vQuery = "Insert into RotationSourceCode (RotationGroupID,RotationID,RotationSourceCodeID,RotationSourceCodeName,RotationSourcecodeType) values (" & Me.RotationGroupID & "," & Me.RotationOne & "," & Me.SourceCodeID & ",'" & Me.SourceCodeName & "'," & Me.SourceCodeType & ")"
        Call modODBC.Exec(vQuery)

        Exit Function
localError:
        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
    End Function

    Public Function AddSourceCode2() As Boolean
        '*********************************************************************************
        'Name: AddSourceCode
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function will add a schedule group to the RotationSourceCode table
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        'Add SourceCode to Rotation
        On Error GoTo localError
        Dim vQuery As String
        vQuery = "Insert into RotationSourceCode (RotationGroupID,RotationID,RotationSourceCodeID,RotationSourceCodeName,RotationSourcecodeType) values (" & Me.RotationGroupID & "," & Me.RotationNext & "," & Me.SourceCodeID & ",'" & Me.SourceCodeName & "'," & Me.SourceCodeType & ")"
        Call modODBC.Exec(vQuery)

        Exit Function
localError:
        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
    End Function

    Public Function GetCurrentRotation() As Short
        '*********************************************************************************
        'Name: GetCurrent Rotation
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function will Get the current Rotation for the given GroupRotationID
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        'Get current rotation for Group
        On Error GoTo localError
        Dim vQuery As String
        Dim vResults As New Object
        Dim vRS As New Object
        vQuery = "Select RotationID,RotationName from Rotation where RotationGroupID = " & Me.RotationGroupID & " and RotationRemediate = -1"
        Call modODBC.Exec(vQuery, vResults)
        If vResults(0, 0) Is System.DBNull.Value Then
            GetCurrentRotation = 0
        Else
            GetCurrentRotation = vResults(0, 0)
        End If
        Exit Function
localError:
        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
    End Function

    Public Function GetNextRotation() As Short
        '*********************************************************************************
        'Name: GetNextRotation
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function will Get the Next Rotation for the given GroupRotationID
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        'Get current rotation for Group
        On Error GoTo localError
        Dim vQuery As String
        Dim vResults As Object
        Dim vRS As Object
        vQuery = "Select RotationID from RotationSequence where RotationGroupID = " & Me.RotationGroupID & " and RotationRemediate = -1"
        Call modODBC.Exec(vQuery, vResults, , vRS)
        If vResults(0, 0) Is System.DBNull.Value Then
            GetNextRotation = 0
        Else
            GetNextRotation = vResults(0, 0) + 1
        End If
        Exit Function
localError:
        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
    End Function

    Public Function AddServiceLevel() As Boolean
        '*********************************************************************************
        'Name: AddServiceLevel
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function will Update the Rotation table with the new servicelevelID
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        'Add ServiceLevel to Rotation
        On Error GoTo localError
        Dim vQuery As String
        vQuery = "Update Rotation Set ServiceLevelID = " & Me.RotationServiceLevelID & ",  ServiceLevelName = '" & Me.RotationServiceLevelName & "' Where RotationGroupID = " & Me.RotationGroupID & " and RotationID = " & Me.RotationOne
        Call modODBC.Exec(vQuery)

        Exit Function
localError:
        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
    End Function

    Public Function AddServiceLevel2() As Boolean
        '*********************************************************************************
        'Name: AddServiceLevel
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function will Update the Rotation table with the new servicelevelID
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        'Add ServiceLevel to Rotation
        On Error GoTo localError
        Dim vQuery As String
        vQuery = "Update Rotation Set ServiceLevelID = " & Me.RotationServiceLevelID & ",  ServiceLevelName = '" & Me.RotationServiceLevelName & "' Where RotationGroupID = " & Me.RotationGroupID & " and RotationID = " & Me.RotationNext
        Call modODBC.Exec(vQuery)

        Exit Function
localError:
        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
    End Function
    Public Function AddAlerts() As Boolean
        '*********************************************************************************
        'Name: AddAlerts
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function will Add alerts to the RotationAlerts Table
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        'Add Alert To Rotation
        On Error GoTo localError
        Dim vQuery As String
        vQuery = " Insert into RotationAlerts (RotationGroupID,RotationID,AlertID,AlertType,AlertGroupName) Values (" & Me.RotationGroupID & "," & Me.RotationOne & "," & Me.AlertID & "," & Me.AlertType & "," & "'" & Me.AlertName & "')"
        Call modODBC.Exec(vQuery)
        Exit Function
localError:
        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
    End Function

    Public Function AddAlerts2() As Boolean
        '*********************************************************************************
        'Name: AddAlerts
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function will Add alerts to the RotationAlerts Table
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        'Add Alert To Rotation
        On Error GoTo localError
        Dim vQuery As String
        vQuery = " Insert into RotationAlerts (RotationGroupID,RotationID,AlertID,AlertType,AlertGroupName) Values (" & Me.RotationGroupID & "," & Me.RotationNext & "," & Me.AlertID & "," & Me.AlertType & "," & "'" & Me.AlertName & "')"
        Call modODBC.Exec(vQuery)

        Exit Function
localError:
        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
    End Function
    Public Function AddCriteria() As Boolean
        '*********************************************************************************
        'Name: AddCriteria
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function will Add Criteria to the RotationCriteria Table
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        'Add Criteria To Rotation
        On Error GoTo localError
        Dim vQuery As String
        vQuery = "Insert into RotationCriteria (RotationGroupID,RotationID,CriteriaID,CriteriaType,CriteriaGroupID,CriteriaGroupName) Values (" & Me.RotationGroupID & "," & Me.RotationOne & "," & Me.CriteriaStatusID & "," & Me.CriteriaType & "," & Me.CriteriaGroupID & ",'" & Me.CriteriaGroupName & "')"
        Call modODBC.Exec(vQuery)

        Exit Function
localError:
        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
    End Function

    Public Function AddCriteria2() As Boolean
        '*********************************************************************************
        'Name: AddCriteria
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function will Add Criteria to the RotationCriteria Table
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        'Add Criteria To Rotation
        On Error GoTo localError
        Dim vQuery As String
        vQuery = "Insert into RotationCriteria (RotationGroupID,RotationID,CriteriaID,CriteriaType,CriteriaGroupID,CriteriaGroupName) Values (" & Me.RotationGroupID & "," & Me.RotationNext & "," & Me.CriteriaStatusID & "," & Me.CriteriaType & "," & Me.CriteriaGroupID & ",'" & Me.CriteriaGroupName & "')"
        Call modODBC.Exec(vQuery)

        Exit Function
localError:
        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
    End Function
    Public Function DeleteRow(ByRef pvflexgrid As Short) As Boolean
        '*********************************************************************************
        'Name: DeleteRow
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function will Delete a Row from the msflexgrid and remove it from the Rotation
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        Dim vQuery As String
        Dim FlexGrid As AxMSFlexGridLib.AxMSFlexGrid

        'Select which flexgrid
        Select Case pvflexgrid
            Case MSFlex1
                FlexGrid = AppMain.frmRotateOrganization.MSFlexGrid1
            Case MSFlex2
                FlexGrid = AppMain.frmRotateOrganization.MSFlexGrid2
            Case MSFlex3
                FlexGrid = AppMain.frmRotateOrganization.MSFlexGrid3

        End Select

        With FlexGrid
            Select Case .get_TextMatrix(.RowSel, 0)

                Case "Alerts"
                    If pvflexgrid = MSFlex1 Then
                        vQuery = "Delete From RotationAlerts where (RotationGroupID = " & Me.RotationGroupID & ")" & " and (RotationID = " & Me.RotationOne & ")" & " and (AlertID = " & .get_TextMatrix(.RowSel, 3) & ")"
                    ElseIf pvflexgrid = MSFlex2 Then
                        vQuery = "Delete From RotationAlerts where (RotationGroupID = " & Me.RotationGroupID & ")" & " and (RotationID = " & Me.RotationNext & ")" & " and (AlertID = " & .get_TextMatrix(.RowSel, 3) & ")"
                    Else
                        'Nothing
                    End If
                    Call modODBC.Exec(vQuery)
                Case "Criteria"
                    If pvflexgrid = MSFlex1 Then
                        vQuery = "Delete From RotationCriteria where (RotationGroupID = " & Me.RotationGroupID & ")" & " and (RotationID = " & Me.RotationOne & ")" & " and (CriteriaGroupID = " & .get_TextMatrix(.RowSel, 3) & ")"
                    ElseIf pvflexgrid = MSFlex2 Then
                        vQuery = "Delete From RotationCriteria where (RotationGroupID = " & Me.RotationGroupID & ")" & " and (RotationID = " & Me.RotationNext & ")" & " and (CriteriaGroupID = " & .get_TextMatrix(.RowSel, 3) & ")"
                    Else
                        'Nothing
                    End If
                    Call modODBC.Exec(vQuery)
                Case "ServiceLevel"
                    If pvflexgrid = MSFlex1 Then
                        vQuery = "Update Rotation Set ServiceLevelName = Null, ServiceLevelID = 0 where (RotationGroupID = " & Me.RotationGroupID & ")" & " and (RotationID = " & Me.RotationOne & ")" & " and (ServiceLevelID = " & .get_TextMatrix(.RowSel, 3) & ")"
                    ElseIf pvflexgrid = MSFlex2 Then
                        vQuery = "Update Rotation Set ServiceLevelName = Null, ServiceLevelID = 0 where (RotationGroupID = " & Me.RotationGroupID & ")" & " and (RotationID = " & Me.RotationNext & ")" & " and (ServiceLevelID = " & .get_TextMatrix(.RowSel, 3) & ")"
                    Else
                        'Nothing
                    End If
                    Call modODBC.Exec(vQuery)
                Case "SourceCode"
                    If pvflexgrid = MSFlex1 Then
                        vQuery = "Delete From RotationSourceCode where (RotationGroupID = " & Me.RotationGroupID & ")" & " and (RotationID = " & Me.RotationOne & ")" & " and (RotationSourceCodeID = " & .get_TextMatrix(.RowSel, 3) & ")"
                    ElseIf pvflexgrid = MSFlex2 Then
                        vQuery = "Delete From RotationSourceCode where (RotationGroupID = " & Me.RotationGroupID & ")" & " and (RotationID = " & Me.RotationNext & ")" & " and (RotationSourceCodeID = " & .get_TextMatrix(.RowSel, 3) & ")"
                    Else
                        'Nothing
                    End If
                    Call modODBC.Exec(vQuery)
                Case "ReportGroups"
                    If pvflexgrid = MSFlex1 Then
                        vQuery = "Delete From RotationReportGroup where (RotationGroupID = " & Me.RotationGroupID & ")" & " and (RotationID = " & Me.RotationOne & ")" & " and (RotationReportGroupID = " & .get_TextMatrix(.RowSel, 3) & ") and (RotationReportGroupType = " & .get_RowData(.RowSel) & ")"
                    ElseIf pvflexgrid = MSFlex2 Then
                        vQuery = "Delete From RotationReportGroup where (RotationGroupID = " & Me.RotationGroupID & ")" & " and (RotationID = " & Me.RotationNext & ")" & " and (RotationReportGroupID = " & .get_TextMatrix(.RowSel, 3) & ") and (RotationReportGroupType = " & .get_RowData(.RowSel) & ")"
                    Else
                        'Nothing
                    End If
                    Call modODBC.Exec(vQuery)
                Case "ScheduleGroups"
                    If pvflexgrid = MSFlex1 Then
                        vQuery = "Delete From RotationScheduleGroup where (RotationGroupID = " & Me.RotationGroupID & ")" & " and (RotationID = " & Me.RotationOne & ")" & " and (RotationScheduleGroupID = " & .get_TextMatrix(.RowSel, 3) & ") and (RotationScheduleGroupType = " & .get_RowData(.RowSel) & ")"
                    ElseIf pvflexgrid = MSFlex2 Then
                        vQuery = "Delete From RotationScheduleGroup where (RotationGroupID = " & Me.RotationGroupID & ")" & " and (RotationID = " & Me.RotationNext & ")" & " and (RotationScheduleGroupID = " & .get_TextMatrix(.RowSel, 3) & ") and (RotationScheduleGroupType = " & .get_RowData(.RowSel) & ")"
                    Else
                        'Nothing
                    End If
                    Call modODBC.Exec(vQuery)
            End Select
        End With

    End Function

    Public Function Save() As Boolean

        On Error GoTo localError


        Exit Function
localError:
        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
    End Function

    Public Function UpdateConsentInterval() As Boolean
localError:
        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        UpdateConsentInterval = False
        Exit Function
    End Function

    Public Function Delete() As Boolean


        Exit Function

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        Delete = False
        Exit Function

    End Function

    Public Function GetServiceLevel(ByVal pvSourceCodeID As Integer, ByVal pvServiceLevelStatusID As Integer, Optional ByRef pvServiceLevelId As Integer = 0) As Object


        Exit Function

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        Resume Next

    End Function

    Public Function GetSourceCodes() As Object

        On Error GoTo localError

        Dim Query As String
        Dim ResultsArray As Object
        Dim I As Short
        Dim NewSourceCode As New clsSourceCode


        Exit Function

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        Resume Next

    End Function
End Class