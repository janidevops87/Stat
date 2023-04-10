Option Strict Off
Option Explicit On
Public Class clsReferralSecondary

    Public ID As Integer


    Public SecondaryNote As String

    Public Function GetData() As Object

        On Error GoTo localError

        Dim Query As String = ""
        Dim ReturnArray As New Object

        If Me.ID = -1 Then
            GetData = NO_DATA
            Exit Function
        End If

        Query = "SELECT * " & "FROM ReferralSecondaryData " & "WHERE ReferralID = " & Me.ID

        GetData = modODBC.Exec(Query, ReturnArray)

        If GetData = NO_DATA Then
            Exit Function
        End If

        SecondaryNote = ReturnArray(0, 1)


        Exit Function

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        Resume Next

    End Function

    Public Function SaveData() As Object

        On Error GoTo localError

        Dim Values As String = ""
        Dim Query As String = ""
        Dim ResultArray As New Object
        Dim QueryResult As Short
        Dim vExist As Boolean

        Dim Params(7) As Object

        Params(0) = ID
        Params(1) = SecondaryNote
        Params(2) = modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)

        Dim Fields(7) As Object

        Fields(0) = "@ReferralID"
        Fields(1) = "@ReferralSecondaryHistory"
        Fields(2) = "@LastStatEmployeeID"
        Fields(3) = "@hdColloid_List"
        Fields(4) = "@hdCrystalloid_List"
        Fields(5) = "@hdQuest3_2a"
        Fields(6) = "@hdQuest3_3a"
        Fields(7) = "@hdQuest3_4a"

        'Check if custom fields have been saved
        Query = "SELECT ReferralID, hdColloid_List, hdCrystalloid_List, hdQuest3_2a, hdQuest3_3a, hdQuest3_4a " & "FROM ReferralSecondaryData " & "WHERE ReferralID = " & modODBC.BuildField(Me.ID)

        QueryResult = modODBC.Exec(Query, ResultArray)

        If QueryResult = SUCCESS Then
            'This name already exists for this Organization
            vExist = True
        ElseIf QueryResult = NO_DATA Then
            vExist = False
        Else
            SaveData = QueryResult
        End If


        'Build and execute the query
        If vExist = False Then
            'First check if the fields have to be saved.
            'If they are all blank, then don't save a record
            If SecondaryNote = "" Then
                Exit Function
            End If

            Params(3) = System.DBNull.Value
            Params(4) = System.DBNull.Value
            Params(5) = System.DBNull.Value
            Params(6) = System.DBNull.Value
            Params(7) = System.DBNull.Value

            'The record is new and should be inserted.
            Values = modODBC.BuildSQL(NEW_RECORD_STOREDPROCEDURE, Params, Fields)
            Query = "EXEC InsertReferralSecondaryData " & Values

            QueryResult = modODBC.Exec(Query)

        Else

            Params(3) = ResultArray(0, 1)
            Params(4) = ResultArray(0, 2)
            Params(5) = ResultArray(0, 3)
            Params(6) = ResultArray(0, 4)
            Params(7) = ResultArray(0, 5)

            'The record exists and should be updated.
            Values = modODBC.BuildSQL(EXISTING_RECORD, Params, Fields)

            Query = "EXEC UpdateReferralSecondaryData " & Values

            QueryResult = modODBC.Exec(Query)

        End If

        Exit Function

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        Resume Next

    End Function
End Class