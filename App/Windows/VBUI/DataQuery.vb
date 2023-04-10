Option Strict Off
Option Explicit On
Imports Statline.Stattrac.Framework

Module modDataQuery

    '************************************************************************************
    'Name: modDataQuery
    'Date Created: 06/01/2020
    'Created by: Mike Berenson
    'Description: Class that queries the database for data needed by the ui using
    '               updated patterns & practices
    '************************************************************************************

    'TODO: Move this class (and copy exec from modODBC) to Statline.Stattrac.Framework

    Public Function GetOrganizationCallStatusList(organizationID As Short, organizationLOEnabled As Boolean) As Object

        '************************************************************************************
        'Name: GetOrganizationCallStatusList
        'Date Created: 06/01/2020
        'Created by: Mike Berenson
        'Description: Queries the database for a list of Organizations with Call Status information.
        'Returns: Return a list of Organizations with Call Status information
        'Params: organizationID(short) & organizationLOEnabled(boolean)
        'Stored Procedures: sps_OrganizationCallStatusList
        '************************************************************************************

        Dim vQuerySqlStatement As String
        Dim vQueryResultCode As Short
        Dim vQueryResultData As New Object 'TODO: Return a collection of strongly typed objects instead of an array
        Dim vOrganizationLOEnabled As Short = IIf(organizationLOEnabled, -1, 0)

        vQuerySqlStatement = $"EXEC sps_OrganizationCallStatusList @OrganizationID = {organizationID}, @OrganizationLOEnabled = {vOrganizationLOEnabled};"

        Try
            vQueryResultCode = modODBC.Exec(vQuerySqlStatement, vQueryResultData)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        'Make sure query was successful and that it returned a valid array
        If vQueryResultCode = SUCCESS And Validater.ObjectIsValidArray(vQueryResultData, 2, 0, 0) Then
            'TODO: Get Validater.ObjectIsValidArray under test
            Return vQueryResultData
        Else
            Return Nothing
        End If

    End Function

End Module
