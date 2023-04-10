Option Strict Off
Option Explicit On
Module modReport
	
	
	
	'Declare ShellExecute to launch browser from vb
	'Added 12/27/99 by Bret Knoll
	
	Public Declare Function ShellExecute Lib "shell32.dll"  Alias "ShellExecuteA"(ByVal hWnd As Integer, ByVal lpOperation As String, ByVal lpFile As String, ByVal lpParameters As String, ByVal lpDirectory As String, ByVal nShowCmd As Integer) As Integer

    Public Function DeleteWebReportGroup(ByRef pvForm As FrmReport) As Short

        On Error Resume Next

        Dim vQuery As String = ""


        pvForm.ReportGroupID = modControl.GetID(pvForm.CboReportGroup)

        vQuery = "DELETE WebReportGroup " & "WHERE OrgHierarchyParentID = " & modControl.GetID(pvForm.CboReportParent) & " " & "AND WebReportGroupID = " & pvForm.ReportGroupID

        DeleteWebReportGroup = modODBC.Exec(vQuery)

    End Function
    Public Function SaveWebReportGroup(ByRef pvForm As FrmReportGroup) As Object

        On Error Resume Next

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vReturn As New Object
        Dim ErrorReturn As New Object
        Dim vText As New Object

        'Get the call data
        Dim vParams(3) As Object

        vParams(0) = pvForm.TxtName.Text
        vParams(1) = pvForm.ParentOrgID
        vParams(2) = pvForm.Verified
        vParams(3) = pvForm.ChkMaster.Checked

        'Specify the table fields
        Dim vFields(3) As Object

        vFields(0) = "WebReportGroupName"
        vFields(1) = "OrgHierarchyParentID"
        vFields(2) = "Verified"
        vFields(3) = "WebReportGroupMaster"

        vQuery = "Select * From WebReportGroup WHERE WebReportGroupName = " & modODBC.BuildField(vParams(0)) & " AND OrgHierarchyParentID = " & vParams(1) & " AND WebReportGroupMaster = " & Math.Abs(CInt(vParams(3)))

        ErrorReturn = modODBC.Exec(vQuery, vReturn)

        If ErrorReturn = SUCCESS Then
            'This name already exists for this Organization
            vText = "This name already exists for this organization. You may not create this Report Group."
            Call MsgBox(vText, MsgBoxStyle.Exclamation, "Duplicate Report Group Name")
            If pvForm.FormState = NEW_RECORD Then
                SaveWebReportGroup = 0
            Else
                SaveWebReportGroup = pvForm.ReportGroupID
            End If
            Exit Function
        End If

        'Build and execute the query
        If pvForm.FormState = NEW_RECORD Then
            'The record is new and should be inserted.
            vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)

            vQuery = "INSERT INTO WebReportGroup (" & vValues & ")"

        Else
            'The record exists and should be updated.
            vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)

            vQuery = "UPDATE WebReportGroup SET " & vValues & " WHERE WebReportGroupID = " & pvForm.ReportGroupID

        End If

        Call modODBC.Exec(vQuery)

        If pvForm.FormState = NEW_RECORD Then
            'Get the ID the the record just inserted.
            Call modStatRefQuery.RefQueryWebReportGroup(vReturn, , pvForm.TxtName.Text, vParams(1))
            SaveWebReportGroup = modConv.TextToLng(vReturn(0, 0))
        Else
            SaveWebReportGroup = pvForm.ReportGroupID
        End If

    End Function



    Public Function DeleteWebReportOrganizations(ByRef pvGridList As Object) As Short

        On Error Resume Next

        Dim vQuery As String = ""
        Dim I As Short

        'Delete each row
        For I = 0 To UBound(pvGridList, 1)
            vQuery = vQuery & "DELETE FROM WebReportGroupOrg WHERE WebReportGroupOrgID = " & pvGridList(I, 0) & "; "
        Next I
        DeleteWebReportOrganizations = modODBC.Exec(vQuery)

    End Function

    Public Function SaveWebReportOrganizations(ByRef pvForm As Object, ByRef vGridList As Object) As Short

        On Error Resume Next

        Dim vValues As String = ""
        Dim vQuery As String = ""
        Dim vReturn As New Object
        Dim I As Short

        On Error Resume Next

        Dim vParams(1) As Object
        Dim vFields(1) As Object

        If pvForm.Name = "FrmReport" Then

            vParams(0) = pvForm.ReportGroupID

            vFields(0) = "WebReportGroupID"
            vFields(1) = "OrganizationID"

            'Get and save each row of the Report group organizations
            For I = 0 To UBound(vGridList, 1)
                vParams(1) = modConv.TextToLng(vGridList(I, 0))
                'Check if the item to be added already exists
                If modReport.QueryWebReportOrganization(pvForm, vParams, vReturn) = NO_DATA Then
                    'The record is new and should be inserted.
                    vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)
                    vQuery = vQuery & "INSERT INTO WebReportGroupOrg (" & vValues & ") "
                End If
            Next I

            If vQuery <> "" Then
                SaveWebReportOrganizations = modODBC.Exec(vQuery)
            Else
                SaveWebReportOrganizations = NO_DATA
            End If

        ElseIf pvForm.Name = "FrmOrganization" Then

            vFields(0) = "ReportGroupID"
            vFields(1) = "OrganizationID"

            'Get and save each row
            For I = 0 To UBound(vGridList, 1)

                vParams(0) = modConv.TextToLng(vGridList(I, 0))
                vParams(1) = modConv.TextToLng(vGridList(I, 1))

                'Insert the record
                vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)

                vQuery = "INSERT INTO ReportGroupOrganization (" & vValues & ")"

                SaveWebReportOrganizations = modODBC.Exec(vQuery)

            Next I

        End If

    End Function




    Public Function QueryWebReportGroup(ByRef pvForm As FrmReportGroup) As Short

        On Error Resume Next

        Dim vQuery As String = ""
        Dim vParams As New Object

        vQuery = "SELECT * FROM WebReportGroup " & "WHERE WebReportGroupID = " & pvForm.ReportGroupID & ";"

        QueryWebReportGroup = modODBC.Exec(vQuery, vParams)

        'Set the call data
        pvForm.ReportGroupID = vParams(0, 0)
        pvForm.TxtName.Text = vParams(0, 1)
        pvForm.Verified = vParams(0, 2)
        pvForm.ChkMaster.Checked = vParams(0, 5)

    End Function


    Public Function QueryWebReportOrganization(ByRef pvForm As Object, Optional ByRef pvParams As Object = Nothing, Optional ByRef pvReturn As Object = Nothing) As Short

        On Error Resume Next

        Dim vQuery As New Object
        Dim vReturn As New Object
        Dim vReportGroupID As Integer

        If IsNothing(pvParams) Then

            'Get the Report group ID
            vReportGroupID = pvForm.ReportGroupID

            If pvForm.Name = "FrmReport" Then

                vQuery = "SELECT WebReportGroupOrg.WebReportGroupOrgID, Organization.OrganizationName, Organization.OrganizationCity, " & "State.StateAbbrv, OrganizationType.OrganizationTypeName " & "FROM WebReportGroup " & "JOIN WebReportGroupOrg ON WebReportGroup.WebReportGroupID = WebReportGroupOrg.WebReportGroupID " & "INNER JOIN ((Organization INNER JOIN OrganizationType ON Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID) " & "INNER JOIN State ON Organization.StateID = State.StateID) ON WebReportGroupOrg.OrganizationID = Organization.OrganizationID " & "WHERE WebReportGroup.WebReportGroupID = " & vReportGroupID & "ORDER BY Organization.OrganizationName ASC"

                QueryWebReportOrganization = modODBC.Exec(vQuery, vReturn)

                If (TypeOf vReturn Is Array) Then
                    Call modControl.SetListViewRows(vReturn, True, pvForm.LstViewSelectedOrganizations, False)
                    pvForm.SelectedGridList = vReturn
                End If

            ElseIf pvForm.Name = "FrmReportParams" Then

                vQuery = "SELECT DISTINCT Organization.OrganizationID, Organization.OrganizationName " & "FROM WebReportGroupOrg " & "JOIN Organization ON Organization.OrganizationID = WebReportGroupOrg.OrganizationID " & "WHERE WebReportGroupOrg.WebReportGroupID = " & vReportGroupID & " " & "ORDER BY Organization.OrganizationName ASC;"

                QueryWebReportOrganization = modODBC.Exec(vQuery, vReturn)

                Call modControl.SetTextID(pvForm.CboOrganization, vReturn)

            End If

        Else

            vQuery = "SELECT DISTINCT Organization.OrganizationID, " & "Organization.OrganizationName, WebReportGroupOrg.WebReportGroupOrgID " & "FROM WebReportGroupOrg INNER JOIN Organization " & "ON WebReportGroupOrg.OrganizationID = Organization.OrganizationID " & "WHERE WebReportGroupOrg.WebReportGroupID = " & pvParams(0) & " " & "AND WebReportGroupOrg.OrganizationID = " & pvParams(1) & ";"

            QueryWebReportOrganization = modODBC.Exec(vQuery, vReturn)

            pvReturn = vReturn

        End If

    End Function
    Public Function QueryUserLogin_Integrated(ByVal pvUserId As String, ByRef prResults As Object) As Short
        On Error Resume Next

        Dim vQuery As String = ""
        'Added 06/26/01 bjk: OrganizationLO field
        '10/15/03 drh - Added StatEmployee JOIN to prevent duplicate WebPersonUserNames w/o corresponding StatEmployeeUserId's from being returned
        vQuery = String.Format("SELECT WebPersonID, CASE WHEN Person.Inactive = 1 THEN Person.PersonFirst+RTRIM(' '+(ISNULL(PersonMI,'')))+' '+PersonLast + ' (Inactive)' ELSE Person.PersonFirst+RTRIM(' '+(ISNULL(PersonMI,'')))+' '+PersonLast END  AS Person, Organization.OrganizationID, WebPersonEmail, CASE OrganizationLO When -1 Then Organization.OrganizationID Else 0 End As OrganizationLO, '(' + ISNULL(Phone.PhoneAreaCode,'') + ')' + ISNULL(Phone.PhonePrefix,'') + '-' + ISNULL(Phone.PhoneNumber,'') AS CallBack , TimeZone.TimeZoneAbbreviation 'OrganizationTimeZone' FROM WebPerson JOIN Person ON Person.PersonID = WebPerson.PersonID JOIN StatEmployee ON StatEmployee.PersonID = WebPerson.PersonID JOIN Organization ON Organization.OrganizationID = Person.OrganizationID LEFT JOIN OrganizationPhone ON Organization.OrganizationID = OrganizationPhone.OrganizationID LEFT JOIN Phone ON OrganizationPhone.PhoneID = Phone.PhoneID AND Phone.PhoneTypeID = 12 /* CALLBACK */ LEFT JOIN TimeZone ON Organization.TimeZoneId = TimeZone.TimeZoneID WHERE WebPersonUserName = {0} order by 6 desc;", modODBC.BuildField(pvUserId))

        QueryUserLogin_Integrated = modODBC.Exec(vQuery, prResults)

    End Function



End Module