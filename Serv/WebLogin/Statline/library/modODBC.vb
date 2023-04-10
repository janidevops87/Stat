Option Explicit On 

Imports System.Data
Imports System.Data.SqlClient
Imports System.Data.Odbc

Module modODBC

    'This module can maintain as up to 8 (1-8) simultaneous connections. This module assigns
    'the numbers 1-8 as connection values. It is the developer's responsibilty to assign
    'constants to these values if so desired. If no connection value is passed to a function, the function uses a connection value
    'of 1 by default.

    'This module can be modified to accept more than eight connections by increasing the array
    'size of the module connection variables. However, more than eight connections may result in
    'significantly decreased system performance.

    '-----------------------------------------------------------------------
    ' Variables and Constants
    '-----------------------------------------------------------------------

    'Private variables
    Dim Conn%
    'Dim DataSourceName$(1 To 8)
    'Dim User$(1 To 8)
    'Dim Password(1 To 8)
    'Dim Conns(1 To 8) As Connection

    'Public DisplayWarnings As Boolean

    'Public InternetConn$
    'Dim HTTPConn As CInternetHTTP

    'Private constants
    Public Const SQL_ERROR = -1
    Public Const SUCCESS = 0
    Public Const NO_DATA = 100

    Private Const MAX_ROWS = 10000
    Private Const DEFAULT_CONNECTION = 1

    'Public constants
    Public Const NEW_RECORD = 0
    Public Const EXISTING_RECORD = 1
    Public Const DELETE_RECORD = 2

    'Datasource types
    Public Const DS_ACCESS = 1
    Public Const DS_SQL = 2

    'Return codes
    Private Const SQL_NO_DATA = 100

    Public Function Exec(ByVal pvQuery As String, ByVal pvConnection$, ByRef prDataSet As DataSet) As Integer
        'ODBC (DSN) Connection
        Dim dregConn As OdbcConnection
        dregConn = New OdbcConnection("dsn=" & pvConnection & ";uid=" & cnSqlUser & ";pwd=" & cnSqlPW & ";")
        Dim ODBCDA As OdbcDataAdapter = New OdbcDataAdapter(pvQuery, dregConn)
        Dim vDataSet As DataSet = New DataSet()
        vDataSet.EnforceConstraints = False
        ODBCDA.MissingSchemaAction = MissingSchemaAction.AddWithKey
        ODBCDA.Fill(vDataSet)
        prDataSet = vDataSet

    End Function

    'Public Function Exec(ByVal SqlStmt As String, Optional prResults, Optional pvConnection, Optional pvReturnRecordSet, Optional prRecordSet) As Integer

    '        On Error GoTo localError

    '        Dim RS
    '        Dim vBuffer
    '        Dim i%
    '        Dim j%
    '        Dim vDBError As Boolean
    '        Dim TimerStart, TimerEnd, TotalTime

    '        If IsMissing(pvReturnRecordSet) Then
    '            pvReturnRecordSet = False
    '        End If

    '        If SqlStmt = "" Then
    '            Call Err.Raise(-990, "StatTrac", "SqlStmt Empty")
    '        End If

    '        'Check if this is an Internet connection
    '        If InternetConn <> "" Then
    '            Exec = ExecInternet(SqlStmt, prResults, pvReturnRecordSet, prRecordSet)
    '            Exit Function
    '        End If

    '        vDBError = False

    '        'Check to see if a connection string was passed.
    '        If IsMissing(pvConnection) Then
    '            Conn = DEFAULT_CONNECTION
    '        Else
    '            Conn = pvConnection
    '        End If

    '        If IsMissing(prResults) Then

    '            'See if a results array was supplied. If not, assume the query is an
    '            'INSERT, UPDATE, or DELETE and exit the function.
    '            TimerStart = Timer
    '            Call Conns(Conn).Execute(SqlStmt)
    '            TimerEnd = Timer

    '        Else

    '            'Execute a SELECT query
    '            TimerStart = Timer

    '            RS = Conns(Conn).Execute(SqlStmt)

    '            TimerEnd = Timer

    '            If pvReturnRecordSet Then

    '                prRecordSet = RS

    '            Else

    '                If RS.BOF = True And RS.EOF = True Then

    '                    'No data returned
    '                    Exec = NO_DATA
    '                    Exit Function

    '                Else

    '                    vBuffer = RS.GetRows

    '                    'Flip the resulting array into the return array
    '                    If Not modArray.Flip2(vBuffer, prResults) Then
    '                        Call Err.Raise(-1, "StatTrac:modArray.Flip2", SqlStmt)
    '                    End If

    '                End If

    '            End If

    '        End If

    '        RS = Nothing

    '        'Log any excessive query times
    '        TotalTime = TimerEnd - TimerStart
    '        If TotalTime > 10 Then
    '            Call Err.Raise(-995, App.Title, "Duration: " & CLng(TotalTime) & ", SQL: " & SqlStmt)
    '        End If

    '        Exec = SUCCESS

    '        Exit Function

    'localError:

    '        Exec = SQL_ERROR

    '        'Check for db errors which can be handled
    '        If Conns(Conn).Errors.Count > 0 Then

    '            vDBError = True

    '            Select Case Conns(Conn).Errors(i).SQLState

    '                Case "40001"
    '                    'Deadlock error, re-run the command up to 3 times
    '                    If j < 3 Then
    '                        j = j + 1
    '                        'Log the error
    '                        Err.Description = Conns(Conn).Errors(i).SQLState & ", " & App.Title & ", " & Err.Description & ", SQL: " & SqlStmt
    '                        Call modError.LogError("modODBC.Exec, " & AppMain.Connection)
    '                        Conns(Conn).Errors.Clear()
    '                        Resume
    '                    Else
    '                        'Log the retry failure
    '                        Err.Number = -996
    '                        Err.Description = "Retry Failure, " & Conns(Conn).Errors(i).SQLState & ", " & App.Title & ", " & Err.Description & ", SQL: " & SqlStmt
    '                        Call modError.LogError("modODBC.Exec, " & AppMain.Connection)
    '                        Conns(Conn).Errors.Clear()
    '                    End If

    '                Case "S1T00"
    '                    'Timeout error, re-run the command up to 3 times
    '                    If j < 3 Then
    '                        j = j + 1
    '                        'Log the error
    '                        Err.Description = Conns(Conn).Errors(i).SQLState & ", " & App.Title & ", " & Err.Description & ", SQL: " & SqlStmt
    '                        Call modError.LogError("modODBC.Exec")
    '                        Conns(Conn).Errors.Clear()
    '                        Resume
    '                    Else
    '                        'Log the retry failure
    '                        Err.Number = -996
    '                        Err.Description = "Retry Failure, " & Conns(Conn).Errors(i).SQLState & ", " & App.Title & ", " & Err.Description & ", SQL: " & SqlStmt
    '                        Call modError.LogError("modODBC.Exec, " & AppMain.Connection)
    '                        Conns(Conn).Errors.Clear()
    '                    End If

    '                Case "08S01"
    '                    'Connection error, try up to 3 times
    '                    If j < 3 Then
    '                        j = j + 1
    '                        'Log the error
    '                        Err.Description = Conns(Conn).Errors(i).SQLState & ", " & App.Title & ", " & Err.Description & ", SQL: " & SqlStmt
    '                        Call modError.LogError("modODBC.Exec, " & AppMain.Connection)
    '                        Conns(Conn).Errors.Clear()

    '                        'Try to reconnect
    '                        If modODBC.OpenDatabase(DataSourceName(Conn), User(Conn), Password(Conn)) = SUCCESS Then
    '                            Resume
    '                        Else
    '                            Call MsgBox("Your database connection was lost and failed to automatically reconnect. Please exit StatTrac and log in again.", vbOKOnly + vbCritical, "Connection Error - Database")
    '                        End If
    '                    Else
    '                        'Log the retry failure
    '                        Err.Number = -996
    '                        Err.Description = "Retry Failure, " & Conns(Conn).Errors(i).SQLState & ", " & App.Title & ", " & Err.Description & ", SQL: " & SqlStmt
    '                        Call modError.LogError("modODBC.Exec, " & AppMain.Connection)
    '                        Conns(Conn).Errors.Clear()
    '                        Call MsgBox("Your database connection was lost and failed to automatically reconnect. Please exit StatTrac and log in again.", vbOKOnly + vbCritical, "Connection Error - Database")
    '                    End If

    '                Case "37000", "42000"
    '                    'Query syntax error
    '                    'Log the error
    '                    Call modError.LogError("modODBC.Exec, " & AppMain.Connection)
    '                    Conns(Conn).Errors.Clear()
    '                    Call MsgBox("READ !!!! " & vbCrLf & "There was a database error with your record." & vbCrLf & "Your changes may not have been saved! Please check your changes!", vbOKOnly + vbExclamation, "Update Error - Database")

    '                Case Else
    '                    'General error, try up to 3 times to repeat
    '                    If j < 3 Then
    '                        j = j + 1
    '                        'Log the error
    '                        Err.Description = Conns(Conn).Errors(i).SQLState & " " & App.Title & ", " & Err.Description & ", SQL: " & SqlStmt
    '                        Call modError.LogError("modODBC.Exec, " & AppMain.Connection)
    '                        Conns(Conn).Errors.Clear()
    '                        Resume
    '                    Else
    '                        'Log the retry failure
    '                        Err.Number = -996
    '                        Err.Description = "Retry Failure, " & Conns(Conn).Errors(i).SQLState & ", " & App.Title & ", " & Err.Description & ", SQL: " & SqlStmt
    '                        Call modError.LogError("modODBC.Exec, " & AppMain.Connection)
    '                        Conns(Conn).Errors.Clear()
    '                        Call MsgBox("READ !!!! " & vbCrLf & "There has been a general database error. If you were modifying a record, your changes may not have been saved. If you continue to receive this message, Please exit StatTrac and log in again.", vbOKOnly + vbInformation, "General Error - Database")
    '                    End If

    '            End Select

    '        End If

    '        'Log the error if not a db error
    '        If Not vDBError Then

    '            Select Case Err.Number

    '                Case -990

    '                    Call modError.LogError("modODBC.Exec, " & AppMain.Connection & ", " & App.Title & ", SQL: Empty ")

    '                Case -995
    '                    'Log that a query took excessive time to complete
    '                    Call modError.LogError("modODBC.Exec, " & AppMain.Connection & ", " & App.Title)
    '                    Resume Next

    '                Case Else
    '                    Call modError.LogError("modODBC.Exec, " & AppMain.Connection & ", " & App.Title & ", SQL: " & SqlStmt)

    '            End Select

    '        End If

    '        Conns(Conn).Errors.Clear()

    'End Function

    Public Function BuildSQL$(ByVal pvAction, ByVal pParams(), ByVal pFields())

        'Notes
        'Use the optional pFields parameter when building an
        'string that sets a value in the pFields array to a
        'value in the pParams array. When setting fields and
        'parameters, the two arrays must be the same size.

        Dim vSQL$, i%, vBuff$

        On Error GoTo BuildSQL_EH

        If pvAction = NEW_RECORD Then

            'Build an insert string of the format
            'Field(1), ... , Field(i)) VALUES ('Param(1)', ... , 'Param(i)'

            vSQL = ""

            'Build the fields string first
            For i = 0 To UBound(pFields)
                If i = UBound(pFields) Then
                    vSQL = vSQL & pFields(i)
                Else
                    vSQL = vSQL & pFields(i) & ", "
                End If
            Next i

            vSQL = vSQL & ") VALUES ("

            'Build the parameters string next
            For i = 0 To UBound(pParams)

                vSQL = vSQL & modODBC.BuildField(pParams(i)) & ","

            Next i

        ElseIf pvAction = EXISTING_RECORD Then

            vSQL = ""

            If Not (UBound(pParams) = UBound(pFields)) Then
                Exit Function
            End If

            For i = 0 To UBound(pParams)

                vSQL = vSQL & pFields(i) & " = " & modODBC.BuildField(pParams(i)) & ","

            Next i

        End If

BuildSQL_EH:

        BuildSQL$ = Left$(vSQL, Len(vSQL) - 1)

    End Function

    Public Function BuildField$(ByVal pvField)

        Dim vSQL$, i%, vBuff$

        On Error GoTo handleError

        vSQL = " "

        Select Case VarType(pvField)

            Case vbEmpty, vbNull
                vSQL = "NULL"
            Case vbInteger, vbLong
                vSQL = pvField
            Case vbSingle, vbDouble
                If InStr(1, modConv.DblToText$(pvField), ".") Then
                    vSQL = modConv.DblToText$(pvField)
                Else
                    vSQL = modConv.DblToText$(pvField) & ".0"
                End If
            Case vbCurrency
                If pvField = "" Then
                    pvField = "NULL"
                    vSQL = pvField
                Else
                    vSQL = "'" & pvField & "'"
                End If
            Case vbString
                If pvField = "" Then
                    pvField = "NULL"
                    vSQL = pvField
                Else
                    vBuff$ = modString.ReplaceSubString$(CStr(pvField), "'", "''")
                    vSQL = "'" & vBuff$ & "'"
                End If
            Case vbBoolean
                If pvField = True Then
                    pvField = "-1"
                    vSQL = pvField
                Else
                    pvField = "0"
                    vSQL = pvField
                End If
            Case vbDate
                vSQL = "'" & pvField & "'"

        End Select

handleError:

        BuildField$ = Left$(vSQL, Len(vSQL))

    End Function
End Module
