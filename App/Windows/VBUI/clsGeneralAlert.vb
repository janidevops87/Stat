Option Strict Off
Option Explicit On
Public Class clsGeneralAlert

    'Persistent
    Public Key As String
    Public ID As Integer
    Public Expires As Date
    Public Organization As String
    Public Message As String
    Public CreatedByID As Integer
    Public CreatedBy As String
    Public OrganizationId As Short

    'Class Enumerations
    Public Enum AttributeName
        gaExpires = 0
        gaOrganization = 1
        gaMessage = 2
    End Enum


    Public Function Delete() As Boolean

        On Error GoTo localError

        Dim vQuery As String = ""
        Dim vReturn As Short

        'Delete from the GeneralAlert table
        vQuery = "DELETE GeneralAlert WHERE GeneralAlertID = " & Me.ID

        vReturn = modODBC.Exec(vQuery)

        If vReturn Then
            Delete = True
        Else
            Delete = False
        End If

        Exit Function

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        Delete = False

    End Function
    Public Function Save() As Boolean

        On Error GoTo localError

        Dim vQuery As String = ""
        Dim vValues As String = ""
        Dim vResultArray(,) As String
        Dim vResult As Short

        'Set the field values
        Dim vParams(4) As Object

        vParams(0) = Me.Expires
        vParams(1) = Me.Organization
        vParams(2) = Me.Message
        vParams(3) = Me.CreatedByID
        vParams(4) = Me.OrganizationId

        'Specify the table fields
        Dim vFields(4) As Object

        vFields(0) = "GeneralAlertExpires"
        vFields(1) = "GeneralAlertOrg"
        vFields(2) = "GeneralAlertMessage"
        vFields(3) = "PersonID"
        vFields(4) = "OrganizationID"



        If Me.ID = 0 Then
            'Build and execute the query
            vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)
            vQuery = "INSERT INTO GeneralAlert (" & vValues & ")"
            vResult = modODBC.Exec(vQuery, vResultArray)
            Me.ID = CInt(CStr(vResultArray(0, 0)))
            Me.Key = "k" & CStr(Me.ID)
        Else
            'Build and execute the query
            vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)
            vQuery = "UPDATE GeneralAlert SET " & vValues & " WHERE GeneralAlertID = " & Me.ID
            vResult = modODBC.Exec(vQuery)
        End If



        If vResult = SUCCESS Then
            Save = True
        Else
            Save = False
        End If

        Exit Function

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        Save = False
        Exit Function

    End Function

    Public Function Validate(ByRef prAttribute As AttributeName) As Boolean

        On Error GoTo localError

        'Validate there is an expiration date
        If Me.Expires = System.DateTime.FromOADate(0) Then
            prAttribute = AttributeName.gaExpires
            Validate = False
            Exit Function
        End If

        Validate = True

        Exit Function

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        Validate = False
        Exit Function

    End Function
End Class