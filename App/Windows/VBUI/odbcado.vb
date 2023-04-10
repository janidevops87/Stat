Option Strict Off
Option Explicit On
Imports System.Configuration
Imports System.Data
Imports System.Data.SqlClient
Imports Statline.Stattrac.Framework
Imports VB = Microsoft.VisualBasic
Public Module modODBC
    '************************************************************************************
    'Name: modODBC
    'Date Created: Unknown                          Created by: Unknown
    'Release: Unknown                               Task: Unknown
    'Description: Executes all DB code
    '====================================================================================
    '====================================================================================
    'Date Changed: 06/7/07                       Changed by: Bret KNoll
    'Release #: 8.4                              Task: AuditTrail
    'Description: Add NEW_RECORD_STOREDPROCEDURE CONSTANT
    '
    '====================================================================================
    '************************************************************************************

    '-----------------------------------------------------------------------
    ' Constants
    '-----------------------------------------------------------------------

    'Private constants
    Public Const SQL_ERROR As Short = -1
    Public Const SUCCESS As Short = 0
    Public Const NO_DATA As Short = 100

    'Public constants
    Public Const NEW_RECORD As Short = 0
    Public Const NEW_RECORD_STOREDPROCEDURE As Short = 1
    Public Const QUERY_STOREDPROCEDURE As Short = 1
    Public Const EXISTING_RECORD As Short = 1

    Public Function Exec(ByRef SqlStmt As String, Optional ByRef prResults As Object = Nothing, Optional ByRef pvConnection As Object = Nothing, Optional ByRef pvReturnRecordSet As Object = Nothing, Optional ByRef prRecordSet As Object = Nothing, Optional ByVal pConnectionString As String = Nothing) As Short
        
        If String.IsNullOrEmpty(SqlStmt) Then
            Dim ex As New Exception("StatTrac Error: odbcado.Exec was called with a blank sql statement.")
            StatTracLogger.CreateInstance().Write(ex)
            Exec = SQL_ERROR
            Exit Function
        End If

        'Prepare local variables & objects
        Dim TimerStart, TotalTime As Double
        Dim connectionString As String = ConfigurationManager.ConnectionStrings(AppMain.Connection).ConnectionString
        If pConnectionString IsNot Nothing Then
            connectionString = pConnectionString
        End If        
        Dim longRunningQueryTimeLimit As Single = Single.Parse(ConfigurationSettings.AppSettings("LongRunningQueryTimeLimit"))

        'Check to see if we're doing a select or an insert/update/delete
        If IsNothing(prResults) Then 'Insert/Update/Delete           

            'Start looping so we can retry in the event of a failure
            For queryAttemptNumber As Integer = 1 To QueryAttemptLimit

                'Wait if we're retrying a query
                If queryAttemptNumber > 1 Then
                    Threading.Thread.Sleep(QueryRetryIntervalInSeconds*1000)
                End If

                'Start timer
                TimerStart = VB.Timer()

                Try
                    Using connection As New SqlConnection(connectionString)
                        Dim command As New SqlCommand(SqlStmt, connection)
                        command.CommandTimeout = QueryTimeoutInSeconds
                        command.Connection.Open()
                        command.ExecuteNonQuery()
                    End Using
                    Exec = SUCCESS
                Catch ex As Exception
                    ex.Data.Add("ConnectionString", BaseConnectionSetting.GetMaskedConnectionString(connectionString))
                    ex.Data.Add("SQLStatement", SqlStmt)
                    ex.Data.Add("AttemptNumber", queryAttemptNumber)
                    StatTracLogger.CreateInstance().Write(ex)
                    Exec = SQL_ERROR
                End Try
                
                'End timer and log any excessive query times
                TotalTime = VB.Timer() - TimerStart
                If TotalTime > longRunningQueryTimeLimit Then
                    Dim ex As New Exception("StatTrac Problem: Long Running Query in odbcado.Exec - Duration: " & CInt(TotalTime) & ", SQL Statement: " & SqlStmt)
                    ex.Data.Add("ConnectionString", BaseConnectionSetting.GetMaskedConnectionString(connectionString))
                    ex.Data.Add("SQLStatement", SqlStmt)
                    ex.Data.Add("AttemptNumber", queryAttemptNumber)
                    StatTracLogger.CreateInstance().Write(ex, TraceEventType.Warning)
                End If

                'Exit the for loop if we had a successful query result
                If Exec = SUCCESS Then                    
                    Exit For
                End If

            Next

        Else 'Select

            Dim dataTable As New DataTable()
            Dim rs As Recordset = New Recordset()

            'Start looping so we can retry in the event of a failure
            For queryAttemptNumber As Integer = 1 To QueryAttemptLimit

                'Wait if we're retrying a query
                If queryAttemptNumber > 1 Then
                    Threading.Thread.Sleep(QueryRetryIntervalInSeconds*1000)
                End If

                'Start timer
                TimerStart = VB.Timer()

                Try
                    Dim sqlDataAdapter As SqlDataAdapter = New SqlDataAdapter(SqlStmt, connectionString)
                    sqlDataAdapter.SelectCommand.CommandTimeout = QueryTimeoutInSeconds               
                    sqlDataAdapter.Fill(dataTable)
                    Exec = SUCCESS
                Catch ex As Exception
                    ex.Data.Add("ConnectionString", BaseConnectionSetting.GetMaskedConnectionString(connectionString))
                    ex.Data.Add("SQLStatement", SqlStmt)
                    ex.Data.Add("AttemptNumber", queryAttemptNumber)
                    StatTracLogger.CreateInstance().Write(ex)
                    Exec = SQL_ERROR
                End Try

                'End timer and log any excessive query times
                TotalTime = VB.Timer() - TimerStart
                If TotalTime > longRunningQueryTimeLimit Then
                    Dim ex As New Exception("StatTrac Problem: Long Running Query in odbcado.Exec - Duration: " & CInt(TotalTime) & ", SQL Statement: " & SqlStmt)
                    ex.Data.Add("ConnectionString", BaseConnectionSetting.GetMaskedConnectionString(connectionString))
                    ex.Data.Add("SQLStatement", SqlStmt)
                    ex.Data.Add("AttemptNumber", queryAttemptNumber)
                    StatTracLogger.CreateInstance().Write(ex, TraceEventType.Warning)
                End If
                
                'Convert datatable to a recordset
                If Exec <> SQL_ERROR Then
                    Try
                        rs = ConvertToRecordset(dataTable)
                        Exit For
                    Catch ex As SqlException
                        ex.Data.Add("ConnectionString", BaseConnectionSetting.GetMaskedConnectionString(connectionString))
                        ex.Data.Add("SQLStatement", SqlStmt)
                        ex.Data.Add("AttemptNumber", queryAttemptNumber)
                        StatTracLogger.CreateInstance().Write(ex)
                        Exec = SQL_ERROR
                    End Try
                End If

            Next
            
            If pvReturnRecordSet Then
                prRecordSet = rs
            Else
                'Make sure we got a valid response
                Try
                    Dim isBeginningAvailable As Boolean = rs.BOF
                Catch ex As SqlException
                    Exec = SQL_ERROR
                    Exit Function
                End Try

                'Check to see if we got rows returned 
                If rs.BOF And rs.EOF Then
                    Exec = NO_DATA
                    Exit Function
                Else
                    Dim vBuffer As Object = rs.GetRows()
                    'Flip the resulting array into the return array
                    If Not modArray.Flip2(vBuffer, prResults) Then
                        Dim ex As New Exception("StatTrac Problem: Attempt to flip array failed (with call from odbcado.Exec to StatTrac:modArray.Flip2 - SQL Statement: " & SqlStmt)
                        StatTracLogger.CreateInstance().Write(ex)
                    End If
                End If
            End If

        End If

    End Function

    Public Function BuildSQL(ByRef pvAction As Short, ByRef pParams() As Object, ByRef pFields() As Object) As String

        'Notes
        'Use the optional pFields parameter when building an
        'string that sets a value in the pFields array to a
        'value in the pParams array. When setting fields and
        'parameters, the two arrays must be the same size.

        Dim vSQL, vBuff As String
        Dim I As Short


        'bret 01/26/2010 check the pParams array if any values are nothing set them DBNull
        Dim loopCount As Integer
        For loopCount = 0 To pParams.Length - 1
            If IsNothing(pParams(loopCount)) Then
                pParams(loopCount) = System.DBNull.Value
            End If
        Next loopCount

        If pvAction = NEW_RECORD Then

            'Build an insert string of the format
            'Field(1), ... , Field(i)) VALUES ('Param(1)', ... , 'Param(i)'

            vSQL = ""

            'Build the fields string first
            For I = 0 To UBound(pFields)
                If I = UBound(pFields) Then
                    vSQL = vSQL & pFields(I)
                Else
                    vSQL = vSQL & pFields(I) & ", "
                End If
            Next I

            vSQL = vSQL & ") VALUES ("

            'Build the parameters string next
            For I = 0 To UBound(pParams)

                Try
                    vSQL = vSQL & modODBC.BuildField(pParams(I)) & ","
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                    BuildSQL = Left(vSQL, Len(vSQL) - 1)
                End Try

            Next I

        ElseIf pvAction = EXISTING_RECORD Or NEW_RECORD_STOREDPROCEDURE Then

            vSQL = ""

            If Not (UBound(pParams) = UBound(pFields)) Then
                Exit Function
            End If

            For I = 0 To UBound(pParams)

                Try
                    vSQL = vSQL & pFields(I) & " = " & modODBC.BuildField(pParams(I)) & ","
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                    BuildSQL = Left(vSQL, Len(vSQL) - 1)
                End Try

            Next I

        End If

        If String.IsNullOrEmpty(BuildSQL) Then
            BuildSQL = Left(vSQL, Len(vSQL) - 1)
        End If

    End Function

    Public Function BuildField(ByVal pvField As Object, Optional ByRef pvConnection As Object = Nothing) As String

        Dim vSQL, vBuff As String
        Dim I As Short

        On Error GoTo handleError

        vSQL = " "

        Select Case VarType(pvField)

            Case VariantType.Empty, VariantType.Null
                vSQL = "NULL"
            Case VariantType.Short, VariantType.Integer, VariantType.Long
                vSQL = pvField
            Case VariantType.Single, VariantType.Double
                If InStr(1, modConv.DblToText(pvField), ".") Then
                    vSQL = modConv.DblToText(pvField)
                Else
                    vSQL = modConv.DblToText(pvField) & ".0"
                End If
            Case VariantType.Decimal
                If pvField = "" Then
                    pvField = "NULL"
                    vSQL = pvField
                Else
                    vSQL = "'" & pvField & "'"
                End If
            Case VariantType.String
                If pvField = "" Then
                    pvField = "NULL"
                    vSQL = pvField
                Else
                    vBuff = modString.ReplaceSubString(CStr(pvField), "'", "''")
                    vSQL = "'" & vBuff & "'"
                End If
            Case VariantType.Boolean
                If pvField = True Then
                    pvField = "-1"
                    vSQL = pvField
                Else
                    pvField = "0"
                    vSQL = pvField
                End If
            Case VariantType.Date
                vSQL = "'" & pvField & "'"

        End Select

handleError:

        BuildField = Left(vSQL, Len(vSQL))

    End Function

    Public Function BuildConnectionString(ByVal server As String, ByVal database As String) As String

        Dim connectionString As String = String.Empty

        If (Not String.IsNullOrEmpty(server)) _
            And (Not String.IsNullOrEmpty(database)) _
            And (Not String.IsNullOrEmpty(cnSqlUser)) _
            And (Not String.IsNullOrEmpty(cnSqlPW)) Then
            connectionString =
                "Data Source=" + server +
                ";Initial Catalog=" + database +
                ";User ID=" + cnSqlUser +
                ";Password=" + cnSqlPW + ";"
        End If

        BuildConnectionString = connectionString

    End Function

    Public Function ConvertToRecordset(ByVal inTable As DataTable) As Recordset
        Dim result As Recordset = New Recordset()
        'result.CursorLocation = CursorLocationEnum.adUseServer ' CursorLocationEnum.adUseClient
        result.LockType = LockTypeEnum.adLockReadOnly
        Dim resultFields As Fields = result.Fields
        Dim inColumns As System.Data.DataColumnCollection = inTable.Columns
        For Each inColumn As DataColumn In inColumns
            resultFields.Append(inColumn.ColumnName, TranslateType(inColumn.DataType), inColumn.MaxLength, If(inColumn.AllowDBNull, FieldAttributeEnum.adFldIsNullable, FieldAttributeEnum.adFldUnspecified), Nothing)
        Next

        result.Open(System.Reflection.Missing.Value, Reflection.Missing.Value, CursorTypeEnum.adOpenStatic, LockTypeEnum.adLockOptimistic, 0)
        For Each dr As DataRow In inTable.Rows
            result.AddNew(Reflection.Missing.Value, Reflection.Missing.Value)
            For columnIndex As Integer = 0 To inColumns.Count - 1
                resultFields(columnIndex).Value = dr(columnIndex)
            Next
        Next

        If result.RecordCount > 0 Then
            result.MoveFirst()
        End If
        Return result
    End Function

    Private Function TranslateType(ByVal columnType As Type) As DataTypeEnum
        Select Case columnType.UnderlyingSystemType.ToString()
            Case "System.Boolean"
                Return DataTypeEnum.adBoolean
            Case "System.Byte"
                Return DataTypeEnum.adUnsignedTinyInt
            Case "System.Char"
                Return DataTypeEnum.adChar
            Case "System.DateTime"
                Return DataTypeEnum.adDate
            Case "System.Decimal"
                Return DataTypeEnum.adCurrency
            Case "System.Double"
                Return DataTypeEnum.adDouble
            Case "System.Int16"
                Return DataTypeEnum.adSmallInt
            Case "System.Int32"
                Return DataTypeEnum.adInteger
            Case "System.Int64"
                Return DataTypeEnum.adBigInt
            Case "System.SByte"
                Return DataTypeEnum.adTinyInt
            Case "System.Single"
                Return DataTypeEnum.adSingle
            Case "System.UInt16"
                Return DataTypeEnum.adUnsignedSmallInt
            Case "System.UInt32"
                Return DataTypeEnum.adUnsignedInt
            Case "System.UInt64"
                Return DataTypeEnum.adUnsignedBigInt
            Case Else
                Return DataTypeEnum.adVarChar
        End Select
    End Function

End Module