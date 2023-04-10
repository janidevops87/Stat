Option Strict On
Option Explicit On
Option Infer On
Imports System.Collections.Generic
Imports Statline.Stattrac.Framework

Partial Module modStatQuery
    Public Class DataSourceInfo
        Public Property Id As Short
        Public Property Name As String
        Public Property StateId As Byte?
        Public Property Odbc As String
        Public Property ServerName As String
        Public Property DbName As String
        Public Property WebServiceEnable As Integer?
        Public Property WebServiceOrder As Integer?

        Public Overrides Function ToString() As String
            Return $"Name: {Name}, DB: {DbName}"
        End Function

    End Class

    Public Function GetDataSourceListV3(
        serviceLevelID As Integer,
        Optional stateId As String = Nothing) As IEnumerable(Of DataSourceInfo)

        Return GetDataSourceList(
            storedProcedureVersion:=3,
            Function(Fields) New DataSourceInfo With
            {
                .Id = CShort(Fields("DRDSNID").Value),
                .Name = CType(Fields("DRDSNName").Value, String),
                .Odbc = CType(Fields("DRDSNODBC").Value, String),
                .StateId = CType(DBNullToNothing(Fields("DRDSNStateID").Value), Byte?),
                .ServerName = CType(Fields("DRDSNServerName").Value, String),
                .DbName = CType(Fields("DRDSNDBName").Value, String),
                .WebServiceEnable = CType(DBNullToNothing(Fields("WebServiceEnable").Value), Integer?),
                .WebServiceOrder = CType(DBNullToNothing(Fields("WebServiceOrder").Value), Integer?)
            },
            serviceLevelID,
            stateId)
    End Function

    Public Function GetDataSourceListV2(
        serviceLevelID As Integer,
        Optional stateId As String = Nothing) As IEnumerable(Of DataSourceInfo)

        Return GetDataSourceList(
            storedProcedureVersion:=2,
            Function(Fields) New DataSourceInfo With
            {
                .Id = CShort(Fields("DRDSNID").Value),
                .Name = CType(Fields("DRDSNName").Value, String),
                .Odbc = CType(Fields("DRDSNODBC").Value, String),
                .StateId = CType(DBNullToNothing(Fields("DRDSNStateID").Value), Byte?),
                .ServerName = CType(Fields("DRDSNServerName").Value, String),
                .DbName = CType(Fields("DRDSNDBName").Value, String)
            },
            serviceLevelID,
            stateId)
    End Function

    Public Function GetDataSourceList(Of TItem)(
        storedProcedureVersion As Byte,
        itemSelector As Func(Of Fields, TItem),
        serviceLevelID As Integer,
        Optional stateId As String = Nothing) As IEnumerable(Of TItem)

        Dim vResult As New Object
        Dim dataSourceRecordSet As Object

        '08/30/2004 T.T add sps_getDSN to get a list of registries to check.
        Dim query = $"EXEC sps_GetDSNv{storedProcedureVersion} " & serviceLevelID

        If Not String.IsNullOrEmpty(stateId) Then
            query = query & $", '{stateId}'"
        End If

        Try
            Call modODBC.Exec(query, vResult, , True, dataSourceRecordSet)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
            Throw
        End Try

        Return CType(dataSourceRecordSet, ADODB.Recordset).ToEnumerable(itemSelector)

    End Function

    Private Function DBNullToNothing(obj As Object) As Object
        Return If(System.Convert.IsDBNull(obj), Nothing, obj)
    End Function

End Module