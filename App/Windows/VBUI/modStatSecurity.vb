Option Strict Off
Option Explicit On
Imports Statline.Stattrac.Security
Imports Statline.Stattrac.Constant



Module modStatSecurity





    Public Function GetBitPermission(ByRef pvUserId As Object, ByRef pvSecurityKey As Object) As Boolean
        'drh 07/24/03 - New Function

        On Error Resume Next
        Dim vQuery As String = ""
        Dim vReturn As New Object

        vQuery = "sps_GetPermission " & pvUserId & ", NULL, NULL, '" & pvSecurityKey & "'"

        If modODBC.Exec(vQuery, vReturn) = SUCCESS Then
            If vReturn(0, 0) = -1 Then
                GetBitPermission = True
            Else
                GetBitPermission = False
            End If
        Else
            GetBitPermission = False
        End If

    End Function

    Public Function GetPermission(ByRef pvUserId As Object, ByRef pvSecurityKey As Object) As Boolean
        '************************************************************************************
        'Name: GetPermission
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Queries the database for specific permissions by name
        'Returns: Boolean
        'Params: Item As ListItem
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 5/27/05                          Changed by: Scott Plummer
        'Release #: 8.0                               Task: 416
        'Description:  Added key "AllowCloseReferral"
        '====================================================================================
        'Date Changed: 2/10/2011                          Changed by: ccarroll
        'Release #: 9.2                               Task: 
        'Description:  Changed security to new StatTrac permission rules
        '====================================================================================
        '************************************************************************************
        Dim vQuery As String = ""
        Dim vReturn As New Object

        Dim securityHelper As SecurityHelper

        securityHelper = securityHelper.GetInstance()

        GetPermission = False

        Select Case pvSecurityKey

            Case "AllowCallDelete"
                'Rule: Delete_Call
                GetPermission = securityHelper.Authorized(SecurityRule.Delete_Call.ToString())

            Case "AllowMaintainAccess"
                'Rule: Administration_Access
                GetPermission = securityHelper.Authorized(SecurityRule.Administration_Access.ToString())

            Case "AllowSecurityAccess"
                'Rule: Contact_Permissions
                GetPermission = securityHelper.Authorized(SecurityRule.Contact_Permissions.ToString())

            Case "AllowStopTimerAccess"
                'Rules: Response_Interval
                GetPermission = securityHelper.Authorized(SecurityRule.Response_Interval.ToString())

            Case "AllowIncompleteAccess"
                'Rules: Edit_Exclusive_Calls
                GetPermission = securityHelper.Authorized(SecurityRule.Edit_Exclusive_Calls.ToString())

            Case "AllowScheduleAccess"
                'Rules: Schedule_Changes
                GetPermission = securityHelper.Authorized(SecurityRule.Schedule_Changes.ToString())

            Case "AllowRecoveryAccess"
                'Rules: Enable_Backup
                'GetPermission = securityHelper.Authorized(SecurityRule.Enable_Backup.ToString())
                'TODO: Add rule to new StatTrac if configurable
                GetPermission = False

            Case "AllowInternetAccess"
                'Rules: IntraNet_Access
                'GetPermission = securityHelper.Authorized(SecurityRule.IntraNet_Access.ToString())
                'TODO: Add rule to new StatTrac if configurable
                GetPermission = False

            Case "AllowQAReview"
                'Rules: ST_Update - Update(Case_Review)
                GetPermission = securityHelper.Authorized(SecurityRule.ST_Update.ToString())

            Case "AllowRecycleCase"
                'Rules: Recycled_Cases
                GetPermission = securityHelper.Authorized(SecurityRule.Recycled_Cases.ToString())

            Case "AllowCloseReferral"
                'Rules: 
                'not used in new or old StatTrac
                GetPermission = securityHelper.Authorized(SecurityRule.Unlock_Case.ToString())

            Case "AllowASPSave"
                'Only Admin users allowed to save ASP calls.
                GetPermission = securityHelper.Authorized(SecurityRule.Administration_Access.ToString())
            Case "AllowDeleteLogEvent"
                'Rules: Delete_Events
                'If user has permission to Delete_Events user is allowed to view deleted events.
                GetPermission = securityHelper.Authorized(SecurityRule.Delete_Events.ToString())
            Case "AllowViewDeletedLogEvents"
                'Rules: Delete_Events
                'If user has permission to Delete_Events user is allowed to view deleted events.
                GetPermission = securityHelper.Authorized(SecurityRule.Delete_Events.ToString())

        End Select


        Exit Function
    End Function

    Public Function IsStatTracPerson(ByRef pvForm As FrmPersonProperties) As Object
        'This function checks if the organizationid is a Statline employee by comparing there OrganiztaionID to the
        'STATLINE_ID constant. It also checks if a client is a ASP and has Statline Access.
        'BJK 04/02/02 added check for Statline access vs web access only.
        If pvForm.OrganizationId = STATLINE_ID Or ((STAT_LOGIN And pvForm.LoginType) = STAT_LOGIN And pvForm.fvLeaseOrganization = -1) Then
            IsStatTracPerson = True
        Else
            IsStatTracPerson = False
        End If

    End Function
End Module