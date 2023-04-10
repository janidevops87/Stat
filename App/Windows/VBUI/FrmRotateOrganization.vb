Option Strict Off
Option Explicit On
Public Class FrmRotateOrganization
    Inherits System.Windows.Forms.Form
    Dim RotationArrayImplement() As Short 'Rotation array number of Rotations
    Public Rotationcount As Short 'number of rotations in Group
    Public AlertID As Short 'AlertID
    Public AlertName As String 'AlertName
    Public AlertType As Short 'AlertType - Referrals ect..
    Public AlertID2 As Short 'AlertID2
    Public AlertName2 As String 'AlertName
    Public AlertType2 As Short 'AlertType2 - Referrals ect..
    Public Saved As Short 'Saved form
    Public Loaded As Boolean 'Loaded form
    Public CriteriaStatusID As Short 'CriteriaStatusID
    Public DonorCategoryID As Short 'DonorCategoryID
    Public Organizationscheduleid As Short 'OrganizationScheduleID
    Public Organizationscheduleid2 As Object 'OrganizationScheduleID2
    Public RotationOneID As Short 'Current RotationID
    Public RotationNextID As Short 'Next RotationID
    Public RotationGroupID As Object 'Group RotationID
    Public vRS As ADODB.Recordset 'Generic Recordset
    Public Rotation As New clsRotation 'Current Rotation Class
    Public RotationNext As New clsRotation 'Next Rotation Class
    Public RotationFreq As Short 'Rotation Frequency
    Private UsingMouse As Boolean ' Flag for using the Mouse in the Grid.
    Public GridList As Object
    Const Alert As Short = 1
    Const Criteria As Short = 2
    Const ServiceLevel As Short = 3
    Const SourceCode As Short = 4
    Const ReportGroup As Short = 5
    Const Schedule As Short = 6
    Const MSFlex1 As Short = 1
    Const MSFlex2 As Short = 2
    Const MSFlex3 As Short = 3
    Dim SourceCodes As New colSourceCodes 'SourceCodes
    Public AuditLogId As Integer 'Audit ID
    Public AuditNoUpdate As Boolean 'Audit bool

    Public AvailableSortOrder As Short
    Public SelectedGridList As Object
    Public SelectedSortOrder As Short
    Private frmRotationNew As FrmRotationNew
    Private frmRotationCreate As FrmRotationCreate
    Private Sub CboCriteria_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboCriteria.SelectedIndexChanged
        '*********************************************************************************
        'Name: CboCriteria_Click
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function will fill the cbocriteriagroup textbox
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        Dim vReturn As New Object

        'Get the ID of the selected location
        Me.DonorCategoryID = modControl.GetID(CboCriteria)
        Me.CriteriaStatusID = WORKING_CRITERIA

        'Fill the criteria group list
        Call modControl.SelectNone(CboCriteriaGroup)

        'Pass Criteria Status so the Working Criteria will be used
        Call modStatRefQuery.RefQueryCriteriaGroup(vReturn, , , Me.DonorCategoryID, CriteriaStatusID)
        Call modControl.SetTextID(CboCriteriaGroup, vReturn)

    End Sub


    Private Sub CboCriteria2_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboCriteria2.SelectedIndexChanged
        '*********************************************************************************
        'Name: CboCriteria_Click
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function will fill the cbocriteriagroup2 textbox
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        Dim vReturn As New Object

        'Get the ID of the selected location
        Me.DonorCategoryID = modControl.GetID(CboCriteria2)
        Me.CriteriaStatusID = WORKING_CRITERIA


        'Fill the criteria group list
        Call modControl.SelectNone(CboCriteriaGroup2)
        Call modStatRefQuery.RefQueryCriteriaGroup(vReturn, , , Me.DonorCategoryID, CriteriaStatusID)
        Call modControl.SetTextID(CboCriteriaGroup2, vReturn)

    End Sub



    Private Sub CboOrganization_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboOrganization.SelectedIndexChanged
        '*********************************************************************************
        'Name: CboOrganization_Click
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function will fill the cboschedulegroup
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        'T.T 11/30/2004 Fill the schedule group list
        Dim vReturn As New Object
        Dim vResult As New Object
        'Get the ID of the selected location
        Me.Organizationscheduleid = modControl.GetID(CboOrganization)
        Call modControl.SelectNone(CboScheduleGroup)
        vResult = modStatRefQuery.RefQueryScheduleGroup(vReturn, , , Me.Organizationscheduleid)
        Call modControl.SetTextID(CboScheduleGroup, vReturn)
    End Sub

    Private Sub CboOrganization2_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboOrganization2.SelectedIndexChanged
        '*********************************************************************************
        'Name: CboOrganization_Click2
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function will fill the cboschedulegroup2
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        'T.T 11/30/2004 Fill the schedule group list
        Dim vReturn As New Object
        Dim vResult As Object
        'Get the ID of the selected location
        Me.Organizationscheduleid2 = modControl.GetID(CboOrganization2)
        Call modControl.SelectNone(CboScheduleGroup2)

        vResult = modStatRefQuery.RefQueryScheduleGroup(vReturn, , , Me.Organizationscheduleid2)
        Call modControl.SetTextID(CboScheduleGroup2, vReturn)
    End Sub

    Private Sub CboReportParent_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboReportParent.SelectedIndexChanged
        '*********************************************************************************
        'Name: CboReportParent_Click
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function will fill the ReportParent
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        'Get the ReportGroups
        Call modControl.SelectNone(CboReportType)
        Call modStatQuery.QueryWebParentReportGroupsRotation(Me, 0)

    End Sub
    Private Sub CboReportParent2_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboReportParent2.SelectedIndexChanged
        '*********************************************************************************
        'Name: CboReportParent_Click
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function will fill the ReportParent2
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        'Get the report Groups
        Call modControl.SelectNone(CboReportType2)
        Call modStatQuery.QueryWebParentReportGroupsRotation(Me, 1)

    End Sub


    Public Sub CboRotationGroup_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboRotationGroup.SelectedIndexChanged
        Me.Loaded = False
        RotationGroupLoad()

    End Sub

    Private Sub RotationGroupLoad()

        '*********************************************************************************
        'Name: CboRotationGroup_Click
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description:   This function will assign the current Rotation and the next Rotation
        '               values as well as call the functions to fill the flexgrids
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================

        'Assign the Group Rotation ID
        Me.RotationGroupID = modControl.GetID(CboRotationGroup)
        Rotation.RotationGroupID = modControl.GetID(CboRotationGroup)
        RotationNext.RotationGroupID = modControl.GetID(CboRotationGroup)

        'Get Rotation Frequency
        Me.RotationFreq = modStatQuery.QueryGroupRotationFreq((Rotation.RotationGroupID))
        If Me.RotationFreq = -1 Then
            Me.CboRotationTime.SelectedIndex = Me.RotationFreq
        Else
            Me.CboRotationTime.SelectedIndex = Me.RotationFreq - 1
        End If
        Dim cboZoneSelectedIndex As Short = modStatQuery.QueryGroupRotationTimeZone((Rotation.RotationGroupID))
        If cboZoneSelectedIndex = -1 Then
            Me.cbozone.SelectedIndex = cboZoneSelectedIndex
        Else
            Me.cbozone.SelectedIndex = cboZoneSelectedIndex - 1
        End If

        'pcList.ItemData(pcList.ListIndex)
        'Get Rotation Count
        Me.Rotationcount = modStatQuery.QueryGroupRotationcount((Me.RotationGroupID))
        LoadRotationArray()
        'Get the current Rotation ID
        'currentRotation
        Rotation.RotationOne = Rotation.GetCurrentRotation
        'Next Rotation aware of current Rotation
        If Me.Loaded = False Then
            Rotation.RotationNext = Me.AdvanceRotationArray((Rotation.RotationOne))
            Me.lblRotationNext.Text = CStr(Rotation.RotationNext)
        Else
            Rotation.RotationNext = CShort(Me.lblRotationNext.Text)
        End If
        'Current Rotation aware of next rotation
        Rotation.RotationNext = CShort(Me.lblRotationNext.Text)
        'Next rotation
        RotationNext.RotationNext = CShort(Me.lblRotationNext.Text)

        'labels for next and current rotations
        Me.lblRotationNext.Text = CStr(RotationNext.RotationNext)
        Me.lblRotation.Text = CStr(Rotation.RotationOne)
        Rotation.FillMsFlex1()
        RotationNext.FillMsFlex2()
        Rotation.FillMsFlex3()

        Me.Rotationcount = modStatQuery.QueryGroupRotationcount((Me.RotationGroupID))
        '    Set vRS = modStatQuery.QueryGroupRotationarray(Me.RotationGroupID)
        LoadRotationArray()
        Me.Loaded = True

        If Me.RotationGroupID = -1 Then
            CmdSelect.Enabled = False
            CmdDeselect.Enabled = False
        Else
            CmdSelect.Enabled = True
            CmdDeselect.Enabled = True
        End If
        'Remove the current list
        LstViewSelectedOrganizations.Items.Clear()
        LstViewSelectedOrganizations.View = View.Details
        'Get Organizations
        Call modStatQuery.QueryRotationOrganizationselect(Me, (Rotation.RotationGroupID))
        Call modControl.SelectID(CboState, ALL_STATES)
        Call modControl.SelectID(CboOrganizationType, ALL_ORG_TYPES)
    End Sub

    Private Sub LoadRotationArray()
        ReDim RotationArrayImplement(Me.Rotationcount - 1)
        Dim I As Short

        For I = 0 To UBound(RotationArrayImplement)
            RotationArrayImplement(I) = I + 1
        Next I


    End Sub
    Function AdvanceRotationArray(ByRef count As Short) As Short
        '*********************************************************************************
        'Name: AdvanceRotationArray
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.3]    Task: [Task created for]
        'Description: This function will advance the rotation count
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        Dim vAdvance As Short

        'count is more of current rotation, add 1 to advance
        vAdvance = count + 1

        'If vAdvance > RotationArrayImplement.Count Then
        '    Exit Function
        'End If

        If vAdvance > RotationArrayImplement.Count Then
            vAdvance = LBound(RotationArrayImplement) + 1
        End If


        If vAdvance = Rotation.RotationOne Then
            vAdvance = vAdvance + 1
        End If
        AdvanceRotationArray = vAdvance
    End Function
    Function SubTractRotationArray(ByRef count As Short) As Short
        '*********************************************************************************
        'Name: SubTractRotationArray
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.3]    Task: [Task created for]
        'Description: This function will subtract from the rotation count
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        Dim vSubtract As Short

        vSubtract = count - 1

        If vSubtract = Rotation.RotationOne Then
            vSubtract = vSubtract - 1
        End If

        If vSubtract = LBound(RotationArrayImplement) Then
            vSubtract = RotationArrayImplement.Count
        End If
        SubTractRotationArray = vSubtract



    End Function

    Private Sub CboSourceCodeType2_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboSourceCodeType2.SelectedIndexChanged
        '*********************************************************************************
        'Name: CboSourceCodeType2_Click
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function will fill CboSourceCodeGroup2
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        'Fill the list box
        Call modControl.SelectNone(CboSourceCodeGroup2)
        Call SourceCodes.GetItems(modControl.GetID(CboSourceCodeType2))
        Call SourceCodes.FillListBox(CboSourceCodeGroup2)
    End Sub

    Private Sub CboTypeAlert2_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboTypeAlert2.SelectedIndexChanged
        '*********************************************************************************
        'Name: CboTypeAlert2_Click
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function will fill CboAlertGroup2
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================


        Select Case modControl.GetID(CboTypeAlert2)

            Case REFERRAL
                Me.AlertType = REFERRAL
                '            Me.Frame(1).Caption = "Referral Alerts"
                '            Me.LblAlert1.Caption = "This field should be used for medical information."
                '            Me.LblAlert2.Caption = "This field should be used for approach instructions (hospital or agency) and any other miscellaneous info."
            Case Message
                Me.AlertType = Message
                '            Me.Frame(1).Caption = "Message Alerts"
                '            Me.LblAlert2.Caption = "This field should be used for announcements. Things that may change over time."
                '            Me.LblAlert1.Caption = "If this alert applies to multiple organizations, this field should decribe rules for which organization should be contacted. Should be similar to the Alert Schedule Note."
            Case IMPORT
                Me.AlertType = IMPORT
                '            Me.Frame(1).Caption = "Import Alerts"
                '            Me.LblAlert2.Caption = "This field should be used for announcements. Things that may change over time."
                '            Me.LblAlert1.Caption = "If this alert applies to multiple organizations, this field should decribe rules for which organization should be contacted. Should be similar to the Alert Schedule Note."
        End Select

        'Fill the Alert list box
        Call modControl.SelectNone(CboAlertGroup2)
        Call modStatRefQuery.ListRefQueryAlertGroup(CboAlertGroup2, Me.AlertType)
    End Sub
    Private Sub CboTypeAlert_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboTypeAlert.SelectedIndexChanged
        '*********************************************************************************
        'Name: CboTypeAlert_Click
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function will fill CboAlertGroup
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================

        Select Case modControl.GetID(CboTypeAlert)

            Case REFERRAL
                Me.AlertType = REFERRAL
                '            Me.Frame(1).Caption = "Referral Alerts"
                '            Me.LblAlert1.Caption = "This field should be used for medical information."
                '            Me.LblAlert2.Caption = "This field should be used for approach instructions (hospital or agency) and any other miscellaneous info."
            Case Message
                Me.AlertType = Message
                '            Me.Frame(1).Caption = "Message Alerts"
                '            Me.LblAlert2.Caption = "This field should be used for announcements. Things that may change over time."
                '            Me.LblAlert1.Caption = "If this alert applies to multiple organizations, this field should decribe rules for which organization should be contacted. Should be similar to the Alert Schedule Note."
            Case IMPORT
                Me.AlertType = IMPORT
                '            Me.Frame(1).Caption = "Import Alerts"
                '            Me.LblAlert2.Caption = "This field should be used for announcements. Things that may change over time."
                '            Me.LblAlert1.Caption = "If this alert applies to multiple organizations, this field should decribe rules for which organization should be contacted. Should be similar to the Alert Schedule Note."
        End Select

        'Fill the Alert list box
        Call modControl.SelectNone(cboAlertGroup)
        Call modStatRefQuery.ListRefQueryAlertGroup(cboAlertGroup, Me.AlertType)
    End Sub

    Private Sub cmdAddAlerts_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdAddAlerts.Click
        '*********************************************************************************
        'Name: cmdAddAlerts_Click
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function will add Alerts to the RotationAlerts table
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        If Me.Loaded = False Then
            Exit Sub
        End If
        Rotation.AlertType = modControl.GetID((Me.CboTypeAlert))
        Rotation.AlertID = modControl.GetID((Me.cboAlertGroup))
        Rotation.AlertName = Me.cboAlertGroup.Text

        'Add Alert To Rotation
        Rotation.AddAlerts()
        Rotation.FillMsFlex1()
    End Sub

    Private Sub cmdAddAlerts2_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdAddAlerts2.Click
        '*********************************************************************************
        'Name: cmdAddAlerts_Click
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function will add Alerts to the RotationAlerts table
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        If Me.Loaded = False Then
            Exit Sub
        End If
        RotationNext.AlertType = modControl.GetID((Me.CboTypeAlert2))
        RotationNext.AlertID = modControl.GetID((Me.CboAlertGroup2))
        RotationNext.AlertName = Me.CboAlertGroup2.Text

        'Add Alert To Rotation
        RotationNext.AddAlerts2()
        RotationNext.FillMsFlex2()
    End Sub

    Private Sub cmdAddCriteria_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdAddCriteria.Click
        '*********************************************************************************
        'Name: cmdAddCriteria_Click
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function will add Criteria to the RotationCriteria table
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        If Me.Loaded = False Then
            Exit Sub
        End If
        Rotation.CriteriaGroupID = modControl.GetID((Me.CboCriteriaGroup))
        Rotation.CriteriaGroupName = Me.CboCriteriaGroup.Text
        Rotation.CriteriaType = modControl.GetID((Me.CboCriteria))

        'Add Criteria to Rotation
        Rotation.AddCriteria()
        Rotation.FillMsFlex1()
    End Sub

    Private Sub cmdAddRotation_Click()
        '*********************************************************************************
        'Name: cmdAddRotation_Click
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function will determine the max rotation count for a Rotationgroup and
        '             the add a new rotation number to the max count
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        Dim vRS As New Object
        Dim vReturn As New Object
        Dim vQuery As String
        Dim vRot As Object

        vQuery = "select  max (rotationid) from Rotation where RotationGroupID = " & Me.RotationGroupID
        Call modODBC.Exec(vQuery, vReturn, , , vRS)
        If vReturn(0, 0) = "" Then
            'New RotationGroup Detected. add a first Rotation
            vQuery = "Insert into Rotation (rotationID,RotationGroupID) values (1," & Me.RotationGroupID & ")"
            Call modODBC.Exec(vQuery)
            Me.RotationOneID = 1
            lblRotation.Text = CStr(Me.Rotation.RotationOneName)
        Else
            vQuery = "Insert into Rotation(RotationID,RotationGroupID) values(" & vReturn(0, 0) + 1 & "," & Me.RotationGroupID & ")"
            Call modODBC.Exec(vQuery)
            vRot = modConv.TextToInt(vReturn(0, 0))
            vRot = vRot + 1
            Me.RotationOneID = vRot
            lblRotation.Text = CStr(Me.RotationOneID)
        End If

    End Sub

    Private Sub cmdAddCriteria2_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdAddCriteria2.Click
        '*********************************************************************************
        'Name: cmdAddCriteria2_Click
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function will add Criteria to the RotationCriteria table
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        If Me.Loaded = False Then
            Exit Sub
        End If
        RotationNext.CriteriaGroupID = modControl.GetID((Me.CboCriteriaGroup2))
        RotationNext.CriteriaGroupName = Me.CboCriteriaGroup2.Text
        RotationNext.CriteriaType = modControl.GetID((Me.CboCriteria2))

        'Add Criteria to Rotation
        RotationNext.AddCriteria2()
        RotationNext.FillMsFlex2()
    End Sub

    Private Sub cmdAddReportGroups_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdAddReportGroups.Click
        '*********************************************************************************
        'Name: cmdAddReportGroups_Click
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function will add ReportGroups to RotationReportGroups table
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        If Me.Loaded = False Then
            Exit Sub
        End If
        Rotation.ReportGroupID = modControl.GetID((Me.CboReportParent))
        Rotation.ReportGroupName = Me.CboReportParent.Text
        Rotation.ReportGroupType = modControl.GetID((Me.CboReportType))
        Rotation.ReportGroupTypeName = Me.CboReportType.Text
        'Add ReportGroup to Rotation
        Rotation.AddReportGroup()
        Rotation.FillMsFlex1()
    End Sub

    Private Sub cmdAddReportGroups2_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdAddReportGroups2.Click
        '*********************************************************************************
        'Name: cmdAddReportGroups2_Click
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function will add ReportGroups to RotationReportGroups table
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        If Me.Loaded = False Then
            Exit Sub
        End If
        RotationNext.ReportGroupID = modControl.GetID((Me.CboReportParent2))
        RotationNext.ReportGroupName = Me.CboReportParent2.Text
        RotationNext.ReportGroupType = modControl.GetID((Me.CboReportType2))
        RotationNext.ReportGroupTypeName = Me.CboReportType2.Text
        'Add ReportGroup to Rotation
        RotationNext.AddReportGroup2()
        RotationNext.FillMsFlex2()
    End Sub

    Private Sub cmdAddRotation2_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdAddRotation2.Click
        '*********************************************************************************
        'Name: cmdAddRotation2_Click
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: display frmrotationnew
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        If Me.Loaded = False Then
            Exit Sub
        End If

        If IsNothing(frmRotationNew) Then
            frmRotationNew = New FrmRotationNew
            frmRotationNew.ModalParent = Me
        End If

        frmRotationNew.RotationName = ""
        frmRotationNew.Display()

    End Sub


    Private Sub cmdAddSchedules_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdAddSchedules.Click
        '*********************************************************************************
        'Name: cmdAddSchedules_Click
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function will add Schedules to RotationSchedules table
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        If Me.Loaded = False Then
            Exit Sub
        End If
        Rotation.ScheduleGroupID = modControl.GetID((Me.CboOrganization))
        Rotation.ScheduleGroupName = Me.CboOrganization.Text
        Rotation.ScheduleGroupType = modControl.GetID((Me.CboScheduleGroup))
        Rotation.ScheduleGroupTypeName = Me.CboScheduleGroup.Text
        'Add SourceCode
        Rotation.AddScheduleGroup()
        Rotation.FillMsFlex1()
    End Sub

    Private Sub cmdAddSchedules2_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdAddSchedules2.Click
        '*********************************************************************************
        'Name: cmdAddSchedules_Click2
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function will add Schedules to RotationSchedules table
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        If Me.Loaded = False Then
            Exit Sub
        End If
        RotationNext.ScheduleGroupID = modControl.GetID((Me.CboOrganization2))
        RotationNext.ScheduleGroupName = Me.CboOrganization2.Text
        RotationNext.ScheduleGroupType = modControl.GetID((Me.CboScheduleGroup2))
        RotationNext.ScheduleGroupTypeName = Me.CboScheduleGroup2.Text
        'Add SourceCode
        RotationNext.AddScheduleGroup2()
        RotationNext.FillMsFlex2()
    End Sub

    Private Sub cmdAddServiceLevels_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdAddServiceLevels.Click
        '*********************************************************************************
        'Name: cmdAddServiceLevels_Click
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function will Update serviceLevel in the Rotation tables
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        If Me.Loaded = False Then
            Exit Sub
        End If
        Rotation.RotationServiceLevelID = modControl.GetID((Me.CboServiceLevel))
        Rotation.RotationServiceLevelName = Me.CboServiceLevel.Text

        'Add ServiceLevel to Rotation
        Rotation.AddServiceLevel()
        Rotation.FillMsFlex1()
    End Sub

    Private Sub cmdAddServiceLevels2_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdAddServiceLevels2.Click
        '*********************************************************************************
        'Name: cmdAddServiceLevels_Click2
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function will Update serviceLevel in the Rotation tables
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        If Me.Loaded = False Then
            Exit Sub
        End If
        RotationNext.RotationServiceLevelID = modControl.GetID((Me.CboServiceLevel2))
        RotationNext.RotationServiceLevelName = Me.CboServiceLevel2.Text

        'Add ServiceLevel to Rotation
        RotationNext.AddServiceLevel2()
        RotationNext.FillMsFlex2()
    End Sub

    Private Sub cmdAddSourceCodes_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdAddSourceCodes.Click
        '*********************************************************************************
        'Name: cmdAddSourceCodes_Click
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function will add SourceCodes to the RotationTable
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        If Me.Loaded = False Then
            Exit Sub
        End If
        Rotation.SourceCodeID = modControl.GetID((Me.CboSourceCodeGroup))
        Rotation.SourceCodeName = Me.CboSourceCodeGroup.Text
        Rotation.SourceCodeType = modControl.GetID((Me.CboSourceCodeType))

        'Add SourceCode
        Rotation.AddSourceCode()
        Rotation.FillMsFlex1()
    End Sub

    Private Sub cmdAddSourceCodes2_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdAddSourceCodes2.Click

        '*********************************************************************************
        'Name: cmdAddSourceCodes_Click2
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function will add SourceCodes to the RotationTable
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        If Me.Loaded = False Then
            Exit Sub
        End If
        RotationNext.SourceCodeID = modControl.GetID((Me.CboSourceCodeGroup2))
        RotationNext.SourceCodeName = Me.CboSourceCodeGroup2.Text
        RotationNext.SourceCodeType = modControl.GetID((Me.CboSourceCodeType2))

        'Add SourceCode
        RotationNext.AddSourceCode2()
        RotationNext.FillMsFlex2()
    End Sub

    Private Sub CmdClose_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdClose.Click
        Me.Close()
    End Sub

    Private Sub cmdDeleteRotation_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdDeleteRotation.Click
        If Me.Loaded = False Then
            Exit Sub
        End If
    End Sub

    Private Sub CmdDeleteRow_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdDeleteRow.Click
        '*********************************************************************************
        'Name: CmdDeleteRow_Click
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.3]    Task: [Task created for]
        'Description: This function will delete the rotation element from the flexgrid
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        If Me.Loaded = False Then
            Exit Sub
        End If
        Rotation.DeleteRow(MSFlex1)
        Rotation.FillMsFlex1()
    End Sub

    Private Sub cmdDeleteRow2_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdDeleteRow2.Click
        '*********************************************************************************
        'Name: CmdDeleteRow_Click2
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.3]    Task: [Task created for]
        'Description: This function will delete the rotation element from the flexgrid
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        If Me.Loaded = False Then
            Exit Sub
        End If
        Rotation.DeleteRow(MSFlex2)
        Rotation.FillMsFlex2()

    End Sub

    Private Sub CmdDeselect_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdDeselect.Click
        '*********************************************************************************
        'Name: CmdDeselect_Click()
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.3]    Task: [Task created for]
        'Description: This function will remove the organization from the rotation
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        Dim vReturn As New Object
        Dim vResponse As Object
        Dim OrgID As Short

        If Me.Loaded = False Then
            Exit Sub
        End If
        Call modUtility.Work()

        Call modControl.GetSelListViewID(LstViewSelectedOrganizations, vReturn)
        OrgID = vReturn(0, 0)
        If IsNothing(vReturn) Then
            Call modUtility.Done()
            Exit Sub
        End If

        'Remove the organization from the Rotation
        vResponse = modStatQuery.QueryRotationDeleteSelection(Me, vReturn)

        'Remove the current list
        LstViewSelectedOrganizations.Items.Clear()
        LstViewSelectedOrganizations.View = View.Details

        'Refill the selected organizations list
        Call modStatQuery.QueryRotationOrganizationselect(Me, (Rotation.RotationGroupID))
        Call modUtility.Done()
    End Sub

    Private Sub CmdFind_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdFind.Click
        '*********************************************************************************
        'Name: CmdFind_Click()
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.3]    Task: [Task created for]
        'Description: This function will find the organizations based on state
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        Call modUtility.Work()

        'Clear the grid
        LstViewAvailableOrganizations.Items.Clear()
        LstViewAvailableOrganizations.View = View.Details

        'Fill Grid
        Call modStatQuery.QueryOpenOrganization(Me)

        Call modUtility.Done()
    End Sub

    Private Sub CmdRefresh_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdRefresh.Click
        RotationGroupLoad()
    End Sub

    Private Sub cmdRename_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdRename.Click
        '*********************************************************************************
        'Name: cmdRename_Click()
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.3]    Task: [Task created for]
        'Description: This function will Rename the rotation
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        If IsNothing(frmRotationNew) Then
            frmRotationNew = New FrmRotationNew
            frmRotationNew.ModalParent = Me
        End If

        frmRotationNew.RotationName = Me.lblRotationName.Text
        frmRotationNew.RotationID = modConv.TextToInt(Me.lblRotation.Text)
        frmRotationNew.Display()

    End Sub

    Private Sub cmdRename2_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdRename2.Click
        '*********************************************************************************
        'Name: cmdRename_Click2()
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.3]    Task: [Task created for]
        'Description: This function will Rename the rotation
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        If IsNothing(frmRotationNew) Then
            frmRotationNew = New FrmRotationNew
            frmRotationNew.ModalParent = Me
        End If

        frmRotationNew.RotationName = Me.lblRotationName2.Text
        frmRotationNew.RotationID = modConv.TextToInt(Me.lblRotationNext.Text)
        frmRotationNew.Display()
    End Sub

    Private Sub cmdRotationback_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdRotationback.Click
        If Me.Loaded = False Then
            Exit Sub
        End If
        Me.lblRotationNext.Text = CStr(Me.SubTractRotationArray(CShort(Me.lblRotationNext.Text)))
        RotationGroupLoad()
    End Sub

    Private Sub CmdRotationForward_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdRotationForward.Click
        If Me.Loaded = False Then
            Exit Sub
        End If

        Me.lblRotationNext.Text = CStr(Me.AdvanceRotationArray(CShort((Me.lblRotationNext).Text)))
        RotationGroupLoad()
    End Sub

    Private Sub cmdSave_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdSave.Click
        '*********************************************************************************
        'Name: cmdSave_Click()
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.3]    Task: [Task created for]
        'Description: This function will Save the Rotation parameters
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        Dim vFreq As Short
        Dim vZone As Short
        Dim vReturn As Short
        Dim I As Short

        vFreq = modControl.GetID((Me.CboRotationTime))
        vZone = modControl.GetID((Me.cbozone))
        Call modStatQuery.QueryGroupRotationFreqSave((Rotation.RotationGroupID), vFreq, vZone)

        If Me.TabReport.SelectedIndex = 2 Then

            For I = 1 To MSFlexGrid3.Rows - 1
                vReturn = modStatQuery.QueryGroupRotationSave((Rotation.RotationGroupID), modConv.TextToInt(MSFlexGrid3.get_TextMatrix(I, 3)), MSFlexGrid3.get_TextMatrix(I, 5), MSFlexGrid3.get_TextMatrix(I, 4), modConv.TextToInt(MSFlexGrid3.get_TextMatrix(I, 0)))

            Next I

        End If
        'Make sure the user wants to close
        vReturn = modMsgForm.FormClose

        If vReturn = MsgBoxResult.Yes Then
            Me.Close()
        End If
    End Sub

    Private Sub cmdSelect_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdSelect.Click
        '*********************************************************************************
        'Name: cmdSelect_Click()
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.3]    Task: [Task created for]
        'Description: This function will add the selected organizations to the rotation
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        Dim vReturn As New Object
        Dim vReturn2 As New Object
        Dim vResponse As Object

        If Me.Loaded = False Then
            Exit Sub
        End If
        Call modUtility.Work()

        If LstViewAvailableOrganizations.Items.Count > 0 Then
            Call modControl.GetSelListViewID(LstViewAvailableOrganizations, vReturn)
        Else
            Call modUtility.Done()
            Exit Sub
        End If

        'Add Organization to Selected Rotation
        vResponse = modStatQuery.QueryAddRotation(Me, vReturn)

        'Remove the current list
        LstViewSelectedOrganizations.Items.Clear()
        LstViewSelectedOrganizations.View = View.Details

        'Refill the selected organizations list
        Call modStatQuery.QueryRotationOrganizationselect(Me, (Rotation.RotationGroupID))
        Call modUtility.Done()
    End Sub

    Private Sub CmdSelectParentOrg_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdSelectParentOrg.Click
        If IsNothing(frmRotationCreate) Then
            frmRotationCreate = New FrmRotationCreate
            frmRotationCreate.ModalParent = Me
        End If

        frmRotationCreate.Display()
    End Sub
    Public Function Display() As Object

        Me.ShowDialog()

    End Function
    Public Function ReloadRotationGroups() As Object

        '*********************************************************************************
        'Name: ReloadRotationGroups
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This function will Reload the GroupRotation cbobox
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        'Reload the RotationGroups
        Call modStatQuery.QueryRotationGroups(Me)
    End Function

    Private Sub Command2_Click()

    End Sub

    Private Sub CmdUnassigned_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdUnassigned.Click
        Call modUtility.Work()

        'Clear the grid
        LstViewAvailableOrganizations.Items.Clear()
        LstViewAvailableOrganizations.View = View.Details

        'Fill Grid
        Call modStatQuery.QueryUnassignedAlertOrganization(Me)

        Call modUtility.Done()
    End Sub

    Private Sub Command1_Click()

    End Sub

    Private Sub FrmRotateOrganization_FormClosing(ByVal sender As Object, ByVal e As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing
        AppMain.frmRotateOrganization = Nothing
        'Me.Dispose()
    End Sub

    Private Sub FrmRotateOrganization_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load
        '*********************************************************************************
        'Name:Form_Load
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This sub will call all the functions to fill the cboboxes on the form
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        Me.Loaded = False
        Me.cbozone.Items.Add(New ValueDescriptionPair(1, "PT"))
        Me.cbozone.Items.Add(New ValueDescriptionPair(2, "MT"))
        Me.cbozone.Items.Add(New ValueDescriptionPair(3, "CT"))
        Me.cbozone.Items.Add(New ValueDescriptionPair(4, "ET"))
        Me.CboRotationTime.Items.Add(New ValueDescriptionPair(1, "Weekly"))
        Me.CboRotationTime.Items.Add(New ValueDescriptionPair(2, "Monthly"))
        Me.CboRotationTime.Items.Add(New ValueDescriptionPair(2, "Bi-Annual"))
        Me.CboRotationTime.Items.Add(New ValueDescriptionPair(4, "Yearly"))
        Me.CboTypeAlert2.Items.Add(New ValueDescriptionPair(REFERRAL, "Referrals"))
        Me.CboTypeAlert2.Items.Add(New ValueDescriptionPair(Message, "Messages"))
        Me.CboTypeAlert2.Items.Add(New ValueDescriptionPair(IMPORT, "Imports"))
        Me.CboSourceCodeType2.Items.Add(New ValueDescriptionPair(REFERRAL, "Referrals"))
        Me.CboSourceCodeType2.Items.Add(New ValueDescriptionPair(Message, "Messages"))
        Me.CboSourceCodeType2.Items.Add(New ValueDescriptionPair(IMPORT, "Imports"))
        Me.CboSourceCodeType2.Items.Add(New ValueDescriptionPair(INFORMATION_Renamed, "Information"))
        Me.CboTypeAlert.Items.Add(New ValueDescriptionPair(REFERRAL, "Referrals"))
        Me.CboTypeAlert.Items.Add(New ValueDescriptionPair(Message, "Messages"))
        Me.CboTypeAlert.Items.Add(New ValueDescriptionPair(IMPORT, "Imports"))
        Me.CboSourceCodeType.Items.Add(New ValueDescriptionPair(REFERRAL, "Referrals"))
        Me.CboSourceCodeType.Items.Add(New ValueDescriptionPair(Message, "Messages"))
        Me.CboSourceCodeType.Items.Add(New ValueDescriptionPair(IMPORT, "Imports"))
        Me.CboSourceCodeType.Items.Add(New ValueDescriptionPair(INFORMATION_Renamed, "Information"))
        'RotationGroups
        Call modStatQuery.QueryRotationGroups(Me)

        'Alerts Loading cboboxes
        'Call modUtility.CenterForm(ParentForm)
        Call modControl.SelectFirst(CboTypeAlert)
        Call modControl.SelectFirst(CboTypeAlert2)

        'Criteria load
        Call modStatRefQuery.ListRefQueryDonorCategory((Me.CboCriteria))
        Call modStatRefQuery.ListRefQueryDonorCategory((Me.CboCriteria2))

        'Service Level
        Call modStatRefQuery.RefQueryServiceLevelGroup(CboServiceLevel, , , , , WORKING_SERVICELEVEL)
        Call modStatRefQuery.RefQueryServiceLevelGroup(CboServiceLevel2, , , , , WORKING_SERVICELEVEL)

        'SourceCodes
        Call modControl.SelectFirst(CboSourceCodeType)
        Call modControl.SelectFirst(CboSourceCodeType2)

        'ReportGroups
        Call modStatQuery.QueryWebReportParentRotation(Me, 0)
        Call modStatQuery.QueryWebReportParentRotation(Me, 1)

        'Schedule Groups
        Call modStatQuery.QueryScheduleOrganizationsRotation(Me, 0)
        Call modStatQuery.QueryScheduleOrganizationsRotation(Me, 1)

        'Applies to Tab load states
        Call modStatRefQuery.RefQueryState(CboState, , , , , True)
        Call modStatRefQuery.RefQueryOrganizationType(CboOrganizationType, , , , , True)

        'Initialize the available organizations grid
        Call modControl.HighlightListViewRow(LstViewAvailableOrganizations)
        Call LstViewAvailableOrganizations.Columns.Insert(0, "", "Organization", CInt(VB6.TwipsToPixelsX(2500)))
        Call LstViewAvailableOrganizations.Columns.Insert(1, "", "City", CInt(VB6.TwipsToPixelsX(1100)))
        Call LstViewAvailableOrganizations.Columns.Insert(2, "", "State", CInt(VB6.TwipsToPixelsX(550)))
        Call LstViewAvailableOrganizations.Columns.Insert(3, "", "Organization Type", CInt(VB6.TwipsToPixelsX(1800)))

        'Initialize the selected organizations grid
        Call modControl.HighlightListViewRow(LstViewSelectedOrganizations)
        Call LstViewSelectedOrganizations.Columns.Insert(0, "", "Organization", CInt(VB6.TwipsToPixelsX(2500)))
        Call LstViewSelectedOrganizations.Columns.Insert(1, "", "City", CInt(VB6.TwipsToPixelsX(1100)))
        Call LstViewSelectedOrganizations.Columns.Insert(2, "", "State", CInt(VB6.TwipsToPixelsX(550)))
        Call LstViewSelectedOrganizations.Columns.Insert(3, "", "Organization Type", CInt(VB6.TwipsToPixelsX(1800)))
        'Set the default types
        Call modControl.SelectID(CboState, ALL_STATES)
        Call modControl.SelectID(CboOrganizationType, ALL_ORG_TYPES)

        'Me.AvailableSortOrder = lvwAscending
        Me.CboRotationTime.SelectedIndex = 1
        Me.cbozone.SelectedIndex = 1

    End Sub

    Private Sub CbosourcecodeType_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboSourceCodeType.SelectedIndexChanged
        '*********************************************************************************
        'Name:CbosourcecodeType_Click
        'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
        'Release #: [Release Sub Was Created For  ex: 7.7.2]    Task: [Task created for]
        'Description: This sub will fill the sourceCode cbo
        'Returns: N/A
        'Params:
        'Stored Procedures: N/A
        '=================================================================================
        'Fill the list box
        Call modControl.SelectNone(CboSourceCodeGroup)
        Call SourceCodes.GetItems(modControl.GetID(CboSourceCodeType))
        Call SourceCodes.FillListBox(CboSourceCodeGroup)
    End Sub




    Private Sub LstViewAvailableOrganizations_ColumnClick(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.ColumnClickEventArgs) Handles LstViewAvailableOrganizations.ColumnClick
        Dim ColumnHeader As System.Windows.Forms.ColumnHeader = LstViewAvailableOrganizations.Columns(eventArgs.Column)

        ' When a ColumnHeader object is clicked, the ListView control is
        ' sorted by the subitems of that column.
        ' Set the SortKey to the Index of the ColumnHeader - 1
        LstViewAvailableOrganizations.Sorting = Me.AvailableSortOrder
        LstViewAvailableOrganizations.ListViewItemSorter = New ListViewItemComparer(eventArgs.Column, Me.AvailableSortOrder)
        ' Set Sorted to True to sort the list.
        LstViewAvailableOrganizations.Sort()

        If Me.AvailableSortOrder = System.Windows.Forms.SortOrder.Ascending Then
            Me.AvailableSortOrder = System.Windows.Forms.SortOrder.Descending
        Else
            Me.AvailableSortOrder = System.Windows.Forms.SortOrder.Ascending
        End If

    End Sub


    Private Sub LstViewSelectedOrganizations_ColumnClick(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.ColumnClickEventArgs) Handles LstViewSelectedOrganizations.ColumnClick
        Dim ColumnHeader As System.Windows.Forms.ColumnHeader = LstViewSelectedOrganizations.Columns(eventArgs.Column)


        ' When a ColumnHeader object is clicked, the ListView control is
        ' sorted by the subitems of that column.
        ' Set the SortKey to the Index of the ColumnHeader - 1
        LstViewSelectedOrganizations.Sorting = Me.AvailableSortOrder
        LstViewSelectedOrganizations.ListViewItemSorter = New ListViewItemComparer(eventArgs.Column, Me.AvailableSortOrder)
        ' Set Sorted to True to sort the list.
        LstViewSelectedOrganizations.Sort()

        If Me.SelectedSortOrder = System.Windows.Forms.SortOrder.Ascending Then
            Me.SelectedSortOrder = System.Windows.Forms.SortOrder.Descending
        Else
            Me.SelectedSortOrder = System.Windows.Forms.SortOrder.Ascending
        End If


    End Sub

    Private Sub TabReport_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TabReport.SelectedIndexChanged
        Static PreviousTab As Short = TabReport.SelectedIndex()
        Call modStatRefQuery.RefQueryState(CboState, , , , , True)
        PreviousTab = TabReport.SelectedIndex()
    End Sub


    Private Sub Text1_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles Text1.Leave
        MSFlexGrid1.Col = 1
        MSFlexGrid1.Row = 1
        Text1.TabIndex = 1
        Text2.TabIndex = 2
        Text2.BorderStyle = System.Windows.Forms.BorderStyle.None
        Text3.TabIndex = 3
        MSFlexGrid3.TabStop = False
    End Sub

    Private Sub Text2_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles Text2.Enter

        MSFlexGrid3.Text = Text2.Text
        If MSFlexGrid3.Col >= MSFlexGrid3.Cols Then MSFlexGrid3.Col = 1
        ChangeCellText()
    End Sub

    Private Sub MSFlexGrid3_EnterCell(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MSFlexGrid3.EnterCell ' Assign cell value to the textbox

        Text2.Text = MSFlexGrid3.Text
    End Sub

    Private Sub MSFlexGrid3_LeaveCell(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MSFlexGrid3.LeaveCell
        ' Assign textbox value to grid
        If MSFlexGrid3.Col = 1 Or MSFlexGrid3.Col = 2 Or MSFlexGrid3.Col = 3 Or MSFlexGrid3.Col = 0 Then
            Exit Sub
        End If

        MSFlexGrid3.Text = Text2.Text
        Text2.Text = ""
    End Sub

    Private Sub MSFlexGrid3_MouseDownEvent(ByVal eventSender As System.Object, ByVal eventArgs As AxMSFlexGridLib.DMSFlexGridEvents_MouseDownEvent) Handles MSFlexGrid3.MouseDownEvent
        UsingMouse = True
        MSFlexGrid3.Text = Text2.Text
        ChangeCellText()
    End Sub

    Private Sub Text2_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles Text2.Leave
        If MSFlexGrid3.Col = 1 Or MSFlexGrid3.Col = 2 Or MSFlexGrid3.Col = 3 Or MSFlexGrid3.Col = 0 Then
            Exit Sub
        End If
        If UsingMouse = True Then
            UsingMouse = False
            Exit Sub
        End If

        If MSFlexGrid3.Col <= MSFlexGrid3.Cols - 2 Then
            MSFlexGrid3.Col = MSFlexGrid3.Col + 1
            ChangeCellText()
        Else
            If MSFlexGrid3.Row + 1 < MSFlexGrid3.Rows Then
                MSFlexGrid3.Row = MSFlexGrid3.Row + 1
                MSFlexGrid3.Col = 1
                ChangeCellText()
            End If
        End If
    End Sub

    Public Sub ChangeCellText() ' Move Textbox to active cell.
        Text2.SetBounds(VB6.TwipsToPixelsX(VB6.PixelsToTwipsX(MSFlexGrid3.Left) + MSFlexGrid3.CellLeft), VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(MSFlexGrid3.Top) + MSFlexGrid3.CellTop), VB6.TwipsToPixelsX(MSFlexGrid3.CellWidth), VB6.TwipsToPixelsY(MSFlexGrid1.CellHeight))
        Text2.Focus()
        Text2.BringToFront()
    End Sub
End Class