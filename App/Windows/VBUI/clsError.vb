Option Strict Off
Option Explicit On
Public Class clsError

    Dim Number As Integer
    Dim Source As String = ""
    Dim Description As String = ""

    Dim NumberLocal As Integer
    Dim SourceLocal As String = ""
    Dim DescriptionLocal As String = ""

    Public Function LogError(ByVal pvLocation As String) As Object

        'Capture the error values
        Number = Err.Number
        Source = Err.Source
        Description = Err.Description

        On Error GoTo localError

        Dim ErrorConn As New ADODB.Connection

        Dim ConnectionString As String = ""
        Dim vQuery As String = ""
        Dim Params(5) As Object
        Dim ComputerName As New Object
        Dim DSN As New Object

        'Get the computer name
        ComputerName = Environment.MachineName.ToString()

        '11/14/01 drh Fix: Added if to default UserId and Password for MDAC 2.70
        If AppMain.DBUserID = "" And AppMain.DBPassword = "" Then
            'Build the connection string
            ConnectionString = "DSN=ErrorLog;" & "UID=" & cnSqlUser & ";" & "PWD=" & cnSqlPW & ";" & "APP=" & My.Application.Info.Title
        Else
            'Build the connection string
            ConnectionString = "DSN=ErrorLog;" & "UID=" & cnSqlUser & ";" & "PWD=" & cnSqlPW & ";" & "APP=" & My.Application.Info.Title
        End If

        'Open the connection
        Call ErrorConn.Open(ConnectionString)

        'Build the stored procedure
        Params(0) = Now
        Params(1) = Number
        Params(2) = ComputerName
        Params(3) = IIf(Source.Length < 1, Application.ProductName, "")
        Params(4) = Left(pvLocation, 100)
        Params(5) = Left(Description, 8000) '1/30/03 drh - Changed length to 8k from 255

        vQuery = BuildSP("EXEC spi_Error1", Params) '1/30/03 drh - Use the new sp

        'Execute
        Call ErrorConn.Execute(vQuery)

        'Clear the error values
        Number = 0
        Source = ""
        Description = ""

        Exit Function

localError:

        'There has been some sort of error writing to the database so
        'write the error to the local application directory.
        Call LogErrorLocal(pvLocation)

    End Function
    Public Function BuildSP(ByVal pSP As String, ByVal pParams As Object) As String

        Dim vSQL, vBuff As String
        Dim I As Short

        On Error GoTo BuildSP_EH

        vSQL = pSP & " "

        For I = 0 To UBound(pParams)
            Select Case VarType(pParams(I))
                Case VariantType.Empty, VariantType.Null
                    vSQL = vSQL & "NULL" & ","
                Case VariantType.Short, VariantType.Integer
                    vSQL = vSQL & pParams(I) & ","
                Case VariantType.Single, VariantType.Double
                    If InStr(1, modConv.DblToText(pParams(I)), ".") Then
                        vSQL = vSQL & modConv.DblToText(pParams(I)) & ","
                    Else
                        vSQL = vSQL & modConv.DblToText(pParams(I)) & ".0,"
                    End If
                Case VariantType.Decimal, VariantType.Date
                    If pParams(I).ToString() = "" Then
                        pParams(I) = "NULL"
                        vSQL = vSQL & pParams(I) & ","
                    Else
                        vSQL = vSQL & "'" & pParams(I) & "',"
                    End If
                Case VariantType.String
                    If pParams(I).ToString() = "" Then
                        pParams(I) = "NULL"
                        vSQL = vSQL & pParams(I) & ","
                    Else
                        vBuff = ReplaceSubString(CStr(pParams(I)), "'", "''")
                        vSQL = vSQL & "'" & vBuff & "',"
                    End If
                Case VariantType.Boolean
                    If pParams(I) = True Then
                        pParams(I) = "-1"
                        vSQL = vSQL & pParams(I) & ","
                    Else
                        pParams(I) = "0"
                        vSQL = vSQL & pParams(I) & ","
                    End If
            End Select
        Next I

BuildSP_EH:

        BuildSP = Left(vSQL, Len(vSQL) - 1)

    End Function

    Private Function LogDBError() As Object

        On Error GoTo localError
        Dim ErrorConn As New ADODB.Connection
        Dim ConnectionString As String = ""
        Dim vQuery As String = ""
        Dim Params(5) As Object
        Dim ComputerName As New Object

        'Get the computer name
        ComputerName = ""

        '11/14/01 drh Fix: Added if to default UserId and Password for MDAC 2.70
        If AppMain.DBUserID = "" And AppMain.DBPassword = "" Then
            'Build the connection string
            ConnectionString = "DSN=ErrorLog;" & "UID=" & cnSqlUser & ";" & "PWD=" & cnSqlPW & ";" & "APP=" & My.Application.Info.Title
        Else
            'Build the connection string
            ConnectionString = "DSN=ErrorLog;" & "UID=" & cnSqlUser & ";" & "PWD=" & cnSqlPW & ";" & "APP=" & My.Application.Info.Title
        End If

        'Open the connection
        Call ErrorConn.Open(ConnectionString)

        'Build the stored procedure
        Params(0) = Now
        Params(1) = Number
        Params(2) = ComputerName
        Params(3) = Source
        Params(4) = "HandleDBError"
        Params(5) = Left(Description, 8000) '1/30/03 drh - Changed length to 8k from 254

        vQuery = BuildSP("spi_Error1", Params) '1/30/03 drh - Use the new sp

        'Execute
        Call ErrorConn.Execute(vQuery)

        'Clear the error values
        Number = 0
        Source = ""
        Description = ""

        Exit Function

localError:

        'There has been some sort of error writing to the database so
        'write the error to the local application directory.
        Call LogErrorLocal("HandleDBError")

    End Function




    Public Function LogErrorLocal(ByVal pvLocation As String) As Object

        'Capture the error values
        NumberLocal = Err.Number
        SourceLocal = Err.Source
        DescriptionLocal = Err.Description

        On Error Resume Next


        Dim ErrorMsg As String = ""
        Dim vFreeFile As New Object
        Dim ComputerName As New Object

        'Get the computer name
        ComputerName = ""

        'Write both the error encountered when trying to log the error to the DB
        'and the original error
        vFreeFile = FreeFile()

        'Build all error msg text
        ErrorMsg = Now & ControlChars.Tab & NumberLocal & ControlChars.Tab & ComputerName & ControlChars.Tab & SourceLocal & ControlChars.Tab & "clsError.LogError" & ControlChars.Tab & DescriptionLocal & Environment.NewLine
        ErrorMsg = ErrorMsg & Now & ControlChars.Tab & Number & ControlChars.Tab & ComputerName & ControlChars.Tab & Source & ControlChars.Tab & pvLocation & ControlChars.Tab & Description & Environment.NewLine

        'Write the information to an error file
        FileOpen(vFreeFile, My.Application.Info.DirectoryPath & "\ErrorFile.txt", OpenMode.Append)
        PrintLine(vFreeFile, ErrorMsg)
        FileClose(vFreeFile)

        'Clear the error values
        Number = 0
        Source = ""
        Description = ""
        NumberLocal = 0
        SourceLocal = ""
        DescriptionLocal = ""

    End Function


    Public Function HandleDBError(ByRef Conn As ADODB.Connection, ByVal Source As String) As Boolean

        Static j As Short

        'Capture the error values
        Number = Err.Number
        Source = Source
        Description = Err.Description

        'Check for db errors which can be handled
        If Conn.Errors.Count > 0 Then

            On Error Resume Next

            Select Case Conn.Errors(0).SQLState

                Case "40001"

                    'Deadlock error, re-run the command up to 3 times
                    If j < 4 Then
                        j = j + 1
                        'Log the error
                        Description = Conn.Errors(0).SQLState & " " & Description
                        Call LogDBError()
                        Conn.Errors.Clear()
                        HandleDBError = False
                    Else
                        j = 0
                        HandleDBError = True
                    End If

                Case "S1T00"
                    'Timeout error, re-run the command up to 5 times
                    If j < 6 Then
                        j = j + 1
                        'Log the error
                        Description = Conn.Errors(0).SQLState & " " & Description
                        Call LogDBError()
                        Conn.Errors.Clear()
                        HandleDBError = False
                    Else
                        j = 0
                        HandleDBError = True
                    End If

                Case "08S01"

                    Call MsgBox("Your database connection was lost. If you continue to receive this message, please exit and log in again.", MsgBoxStyle.OkOnly + MsgBoxStyle.Critical, "Connection Error - Database")
                    HandleDBError = True

                Case "37000", "42000"

                    'Query syntax error
                    'Log the error
                    Description = Conn.Errors(0).SQLState & " " & Description
                    Call LogDBError()
                    Conn.Errors.Clear()
                    j = 0
                    HandleDBError = True

                Case Else
                    'General error, try up to 3 times to repeat
                    If j < 4 Then
                        j = j + 1
                        'Log the error
                        Description = Conn.Errors(0).SQLState & " " & Description
                        Call LogDBError()
                        Conn.Errors.Clear()
                        HandleDBError = False
                    Else
                        j = 0
                        HandleDBError = True
                    End If

            End Select

        Else
            HandleDBError = True
        End If

    End Function
End Class