Option Strict Off
Option Explicit On
Imports Statline.Stattrac.Framework
Public Class clsOrganization

    'Persistent
    Public Key As String
    Public ID As Integer
    Public Name As String
    Public Address1 As String
    Public Address2 As String
    Public City As String
    Public County As String
    Public State As String
    Public ZipCode As String
    Public OrgType As String
    Public Parent As New colOrganizations
    Public ConsentInterval As Short
    Public ServiceLevel As New clsServiceLevel
    Public SourceCodes As New colSourceCodes
    Public Function Save() As Boolean

        On Error GoTo localError

        Dim vQuery As String = ""
        Dim vValues As String = ""
        Dim vResult As Short
        Dim vParams() As Object
        Dim vFields() As Object
        Dim CurrentParent As New Object

        CurrentParent = Me.Parent.Parent

        If CurrentParent Is Nothing Then
            Save = False
            Exit Function
        End If

        If TypeOf CurrentParent Is clsSourceCode Then

            'Set the field values
            ReDim vParams(1)

            vParams(0) = Me.ID
            vParams(1) = CurrentParent.ID

            'Specify the table fields
            ReDim vFields(1)

            vFields(0) = "OrganizationID"
            vFields(1) = "SourceCodeID"

            'Build and execute the query
            vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)
            vQuery = "INSERT INTO SourceCodeOrganization (" & vValues & ")"
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

    Public Function UpdateConsentInterval() As Boolean

        On Error GoTo localError

        Dim vQuery As String = ""
        Dim vValues As String = ""
        Dim vResult As Short
        Dim vParams() As Object
        Dim vFields() As Object

        'Set the field values
        ReDim vParams(0)

        vParams(0) = Me.ConsentInterval

        'Specify the table fields
        ReDim vFields(0)

        vFields(0) = "OrganizationConsentInterval"

        'Build and execute the query
        vValues = modODBC.BuildSQL(EXISTING_RECORD, vParams, vFields)
        vQuery = "UPDATE Organization SET " & vValues & " " & "WHERE OrganizationID = " & Me.ID
        vResult = modODBC.Exec(vQuery)


        If vResult = SUCCESS Then
            UpdateConsentInterval = True
        Else
            UpdateConsentInterval = False
        End If

        Exit Function

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        UpdateConsentInterval = False
        Exit Function

    End Function

    Public Function Delete() As Boolean

        On Error GoTo localError

        Dim vQuery As String = ""
        Dim vResult As Short
        Dim CurrentParent As New Object

        CurrentParent = Me.Parent.Parent

        If CurrentParent Is Nothing Then
            Delete = False
            Exit Function
        End If

        If TypeOf CurrentParent Is clsSourceCode Then
            vQuery = "DELETE SourceCodeOrganization " & "WHERE OrganizationID = " & Me.ID & "AND SourceCodeID = " & CurrentParent.ID

            vResult = modODBC.Exec(vQuery)
        End If


        If vResult = SUCCESS Then
            Delete = True
        Else
            Delete = False
        End If

        Exit Function

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        Delete = False
        Exit Function

    End Function

    Public Function GetServiceLevel(ByVal pvSourceCodeID As Integer, ByVal pvServiceLevelStatusID As Integer, Optional ByRef pvServiceLevelId As Integer = 0) As Object

        Dim Query As String = ""
        Dim ResultsArray As New Object

        'FSProj drh 5/3/02 - If ServiceLevelId parameter exists and its value is not zero, query by Id; otherwise, use SC and ServiceLevelStatus
        If pvServiceLevelId <> 0 Then
            Query = "SELECT DISTINCT ServiceLevelID FROM ServiceLevel WHERE ServiceLevelID = " & pvServiceLevelId
        Else
            'FSProj drh 5/2/02 - Added ServiceLevel table JOIN so we can add ServiceLevelStatus to the WHERE clause below
            Query = "SELECT DISTINCT ServiceLevel30Organization.ServiceLevelID " & "FROM ServiceLevel30Organization " & "JOIN ServiceLevel ON ServiceLevel.ServiceLevelID = ServiceLevel30Organization.ServiceLevelID " & "JOIN ServiceLevelSourceCode ON ServiceLevelSourceCode.ServiceLevelID = ServiceLevel30Organization.ServiceLevelID " & "WHERE OrganizationID = " & Me.ID & " " & "AND ServiceLevelSourceCode.SourceCodeID = " & pvSourceCodeID

            'FSProj drh 5/2/02 - Only return ServiceLevels of the correct Status (ServiceLevelStatus)
            Query = Query & " AND ServiceLevelStatus = " & pvServiceLevelStatusID

            'FSProj drh 5/3/02 - Added END IF
        End If

        Try
            GetServiceLevel = modODBC.Exec(Query, ResultsArray)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        If GetServiceLevel = SUCCESS Then
            ServiceLevel.ID = ResultsArray(0, 0)
            ServiceLevel.GetData()
        Else
            ServiceLevel.ID = -1
        End If

        Exit Function

    End Function

    Public Function GetSourceCodes() As Object

        On Error GoTo localError

        Dim Query As String = ""
        Dim ResultsArray As New Object
        Dim I As Short
        Dim NewSourceCode As New clsSourceCode

        Query = "SELECT DISTINCT SourceCodeID " & "FROM SourceCodeOrganization " & "WHERE OrganizationID = " & Me.ID

        GetSourceCodes = modODBC.Exec(Query, ResultsArray)

        If GetSourceCodes = SUCCESS Then

            For I = 0 To UBound(ResultsArray, 1)

                Call NewSourceCode.GetItem(ResultsArray(I, 0))
                Call SourceCodes.AddItem(NewSourceCode)
                NewSourceCode = Nothing

            Next I

        End If

        Exit Function

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        Resume Next

    End Function

    Private Sub Class_Initialize_Renamed()

        Me.SourceCodes.Parent = Me
        Me.ServiceLevel.Parent = Me

    End Sub
    Public Sub New()
        MyBase.New()
        Class_Initialize_Renamed()
    End Sub
    Public Sub New(ByRef iD As Object, ByRef name As Object, ByRef address1 As Object, ByRef address2 As Object, ByRef city As Object, ByRef county As Object, ByRef state As Object, ByRef zipCode As Object, ByRef orgType As Object, ByRef consentInterval As Object)
        Me.Key = String.Format("k{0}", CStr(iD))
        Me.ID = CInt(iD)
        Me.Name = CStr(name)
        Me.Address1 = CStr(address1)
        Me.Address2 = CStr(address2)
        Me.City = CStr(city)
        Me.County = CStr(county)
        Me.State = CStr(state)
        Me.ZipCode = CStr(zipCode)
        Me.OrgType = CStr(orgType)
        Me.ConsentInterval = CShort(consentInterval)

    End Sub

    Public Sub New(ByRef iD As Integer, ByRef name As String, ByRef address1 As String, ByRef address2 As String, ByRef city As String, ByRef county As String, ByRef state As String, ByRef zipCode As String, ByRef orgType As String, ByRef consentInterval As Short, ByRef parent As colOrganizations)
        Me.Key = String.Format("k{0}", CStr(iD))
        Me.ID = iD
        Me.Name = name
        Me.Address1 = address1
        Me.Address2 = address2
        Me.City = city
        Me.County = county
        Me.State = state
        Me.ZipCode = zipCode
        Me.OrgType = orgType
        Me.ConsentInterval = consentInterval
        Me.Parent = parent
    End Sub
End Class