Option Strict Off
Option Explicit On
Imports Statline.Stattrac.Framework
Public Class clsCall

    Public ID As Integer
    Public Number As String
    Public CallType As Integer
    Public EmployeeID As Integer
    Public TotalTime As String
    Public TotalSeconds As String

    Public CustomField1 As String
    Public CustomField2 As String
    Public CustomField3 As String
    Public CustomField4 As String
    Public CustomField5 As String
    Public CustomField6 As String
    Public CustomField7 As String
    Public CustomField8 As String
    Public CustomField9 As String
    Public CustomField10 As String
    Public CustomField11 As String
    Public CustomField12 As String
    Public CustomField13 As String
    Public CustomField14 As String
    Public CustomField15 As String
    Public CustomField16 As String
    Public Function GetCustom() As Object

        Dim Query As String = ""
        Dim ReturnArray As New Object

        If Me.ID = -1 Then
            GetCustom = NO_DATA
            Exit Function
        End If

        Query = "SELECT * " & "FROM CallCustomField " & "WHERE CallID = " & Me.ID

        Try
            GetCustom = modODBC.Exec(Query, ReturnArray)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If GetCustom = NO_DATA Then
            Exit Function
        End If

        Me.CustomField1 = ReturnArray(0, 1)
        Me.CustomField2 = ReturnArray(0, 2)
        Me.CustomField3 = ReturnArray(0, 3)
        Me.CustomField4 = ReturnArray(0, 4)
        Me.CustomField5 = ReturnArray(0, 5)
        Me.CustomField6 = ReturnArray(0, 6)
        Me.CustomField7 = ReturnArray(0, 7)
        Me.CustomField8 = ReturnArray(0, 8)
        Me.CustomField9 = ReturnArray(0, 9)
        Me.CustomField10 = ReturnArray(0, 10)
        Me.CustomField11 = ReturnArray(0, 11)
        Me.CustomField12 = ReturnArray(0, 12)
        Me.CustomField13 = ReturnArray(0, 13)
        Me.CustomField14 = ReturnArray(0, 14)
        Me.CustomField15 = ReturnArray(0, 15)
        Me.CustomField16 = ReturnArray(0, 16)

        Exit Function

    End Function

    Public Function SaveCustom() As Object

        Dim Values As String = ""
        Dim Query As String = ""
        Dim ResultArray As New Object
        Dim QueryResult As Short
        Dim CustomFieldsExist As Boolean

        'First check if the custome fields have to be saved.
        'If they are all blank, then don't save a record
        If Me.CustomField1 = "" And Me.CustomField2 = "" And Me.CustomField3 = "" And Me.CustomField4 = "" And Me.CustomField5 = "" And Me.CustomField6 = "" And Me.CustomField7 = "" And Me.CustomField8 = "" And Me.CustomField9 = "" And Me.CustomField10 = "" And Me.CustomField11 = "" And Me.CustomField12 = "" And Me.CustomField13 = "" And Me.CustomField14 = "" And Me.CustomField15 = "" And Me.CustomField16 = "" Then
            Exit Function
        End If

        Dim Params(17) As Object 'bret 06/06/07 add 1 for LastStatEmployeeID

        Params(0) = Me.ID
        Params(1) = Me.CustomField1
        Params(2) = Me.CustomField2
        Params(3) = Me.CustomField3
        Params(4) = Me.CustomField4
        Params(5) = Me.CustomField5
        Params(6) = Me.CustomField6
        Params(7) = Me.CustomField7
        Params(8) = Me.CustomField8
        Params(9) = Me.CustomField9
        Params(10) = Me.CustomField10
        Params(11) = Me.CustomField11
        Params(12) = Me.CustomField12
        Params(13) = Me.CustomField13
        Params(14) = Me.CustomField14
        Params(15) = Me.CustomField15
        Params(16) = Me.CustomField16
        Params(17) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)

        Dim Fields(17) As Object 'bret 06/06/07 add 1 for LastStatEmployeeID

        Fields(0) = "@CallID"
        Fields(1) = "@CallCustomField1"
        Fields(2) = "@CallCustomField2"
        Fields(3) = "@CallCustomField3"
        Fields(4) = "@CallCustomField4"
        Fields(5) = "@CallCustomField5"
        Fields(6) = "@CallCustomField6"
        Fields(7) = "@CallCustomField7"
        Fields(8) = "@CallCustomField8"
        Fields(9) = "@CallCustomField9"
        Fields(10) = "@CallCustomField10"
        Fields(11) = "@CallCustomField11"
        Fields(12) = "@CallCustomField12"
        Fields(13) = "@CallCustomField13"
        Fields(14) = "@CallCustomField14"
        Fields(15) = "@CallCustomField15"
        Fields(16) = "@CallCustomField16"
        Fields(17) = "@LastStatEmployeeID"

        'Check if custom fields have been saved
        Query = "SELECT CallID " & "FROM CallCustomField " & "WHERE CallID = " & modODBC.BuildField(Me.ID)

        Try
            QueryResult = modODBC.Exec(Query, ResultArray)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If QueryResult = SUCCESS Then
            'This name already exists for this Organization
            CustomFieldsExist = True
        ElseIf QueryResult = NO_DATA Then
            CustomFieldsExist = False
        Else
            SaveCustom = QueryResult
        End If


        'Build and execute the query
        If CustomFieldsExist = False Then
            'The record is new and should be inserted.
            Values = modODBC.BuildSQL(NEW_RECORD_STOREDPROCEDURE, Params, Fields)
            Query = "EXEC INSERTCallCustomField " & Values

            Try
                QueryResult = modODBC.Exec(Query)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

        Else
            'The record exists and should be updated.
            Values = modODBC.BuildSQL(EXISTING_RECORD, Params, Fields)

            Query = "EXEC UPDATECallCustomField " & Values


            Try
                QueryResult = modODBC.Exec(Query)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try

        End If

        Exit Function

    End Function
End Class