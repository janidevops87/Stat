Option Strict Off
Option Explicit On
Public Class colGeneralAlerts
    Implements System.Collections.IEnumerable

    'local variable to hold collection
    Private mCol As Collection

    Public Function GetItems() As Short

        On Error GoTo localError

        Dim NewGeneralAlert As New clsGeneralAlert
        Dim vQuery As String = ""
        Dim vResultArray As New Object
        Dim I As Short
        Dim vAnyDeleted As Boolean
        Dim vTimeZoneDif As Short

        vTimeZoneDif = modStatQuery.QueryTimeZoneDif(AppMain.ParentForm.TimeZone)



        'Clear the current collection
        For I = 1 To mCol.Count()
            mCol.Remove(1)
        Next I

        'Get the general alerts
        vQuery = "SELECT GeneralAlertID, DateAdd(hh, " & vTimeZoneDif & ", GeneralAlertExpires), " & "GeneralAlertOrg, GeneralAlertMessage, PersonFirst + ' ' + PersonLast, " & "'' AS 'Spacer','' AS 'Spacer','' AS 'Spacer','' AS 'Spacer', " & "GeneralAlert.OrganizationID " & "FROM GeneralAlert " & "LEFT JOIN Person ON Person.PersonID = GeneralAlert.PersonID "

        'bjk 03/04/2002: if user is LO show only their alerts. if the user is not an lo show all alerts.
        'bjk 05/07/2002: Changed back to limit Alerts for all users. Statline will see their alerts and LOS
        ' will see their alersts.
        'If AppMain.ParentForm.LeaseOrganization <> 0 Then
        vQuery = vQuery & "WHERE GeneralAlert.OrganizationID = " & AppMain.ParentForm.WebUserOrg & " "
        'End If


        'bjk 02/04/2002: add order by back
        vQuery = vQuery & "ORDER BY GeneralAlertExpires DESC "

        GetItems = modODBC.Exec(vQuery, vResultArray)

        If GetItems = SUCCESS Then

            'If there are any expired events, delete them
            vAnyDeleted = False

            For I = 0 To UBound(vResultArray, 1)
                If CDate(vResultArray(I, 1)) < Now Then '02/25/03 removed date add --DateAdd("h", vTimeZoneDif, Now) Then
                    'Delete the alert item from the database
                    vAnyDeleted = True
                    vQuery = "DELETE GeneralAlert WHERE GeneralAlertID = " & modConv.TextToLng(vResultArray(I, 0))
                    GetItems = modODBC.Exec(vQuery)
                End If
            Next I

            If vAnyDeleted = True Then
                'If there were any items deleted, then requery the general alerts table
                vQuery = "SELECT GeneralAlertID, DateAdd(hh, " & vTimeZoneDif & ", GeneralAlertExpires) AS GeneralAlertExpires , " & "GeneralAlertOrg, GeneralAlertMessage, PersonFirst + ' ' + PersonLast " & "FROM GeneralAlert " & "LEFT JOIN Person ON Person.PersonID = GeneralAlert.PersonID " & "ORDER BY GeneralAlertExpires DESC"

                GetItems = modODBC.Exec(vQuery, vResultArray)
            End If

            If GetItems = SUCCESS Then

                'Create the individual items
                For I = 0 To UBound(vResultArray, 1)

                    'Set the properties of the new item
                    NewGeneralAlert.Key = "k" & CStr(vResultArray(I, 0))
                    NewGeneralAlert.ID = vResultArray(I, 0)
                    NewGeneralAlert.Expires = vResultArray(I, 1)
                    NewGeneralAlert.Organization = vResultArray(I, 2)
                    NewGeneralAlert.Message = vResultArray(I, 3)
                    NewGeneralAlert.CreatedBy = vResultArray(I, 4)
                    NewGeneralAlert.OrganizationId = vResultArray(I, 9)

                    'Add each row to the collection
                    Call mCol.Add(NewGeneralAlert, NewGeneralAlert.Key)

                    NewGeneralAlert = New clsGeneralAlert

                Next I

            End If
        End If

        Exit Function

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        GetItems = -1
        Exit Function

    End Function

    Public Function FillListView(ByRef pvListView As Object, Optional ByRef pvForm As Object = Nothing) As Integer

        On Error GoTo localError

        Dim cGeneralAlert As New clsGeneralAlert
        Dim I As Short
        Dim vList As New Object

        'Clear the current list
        Call modControl.ClearListView(pvListView)

        'Fill an array of data
        If mCol.Count() > 0 Then

            ReDim vList(mCol.Count() - 1, 9)

            For I = 0 To mCol.Count() - 1

                cGeneralAlert = mCol.Item(I + 1)

                vList(I, 0) = cGeneralAlert.Key
                vList(I, 1) = VB6.Format(cGeneralAlert.Expires, "mm/dd/yy  hh:mm")
                vList(I, 2) = cGeneralAlert.Organization
                vList(I, 3) = cGeneralAlert.Message
                vList(I, 4) = ""
                vList(I, 5) = ""
                vList(I, 6) = ""
                vList(I, 7) = ""
                vList(I, 8) = ""
                vList(I, 9) = cGeneralAlert.OrganizationId


            Next I

            Call modControl.SetListViewRows(vList, True, pvListView, False, , pvForm)

            FillListView = True

        Else
            FillListView = False
        End If

        Exit Function

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        FillListView = False
        Exit Function

    End Function

    Public Function Add(ByRef Key As String, Optional ByRef sKey As String = "") As clsGeneralAlert

        'create a new object
        Dim objNewMember As clsGeneralAlert
        objNewMember = New clsGeneralAlert

        'set the properties passed into the method
        objNewMember.Key = Key
        objNewMember.Key = Key


        If Len(sKey) = 0 Then
            mCol.Add(objNewMember)
        Else
            mCol.Add(objNewMember, sKey)
        End If

        'return the object created
        Add = objNewMember
        objNewMember = Nothing

    End Function

    Default Public ReadOnly Property Item(ByVal vntIndexKey As Object) As clsGeneralAlert
        Get

            On Error GoTo localError

            'used when referencing an element in the collection
            'vntIndexKey contains either the Index or Key to the collection,
            'this is why it is declared as a Variant
            'Syntax: Set foo = x.Item(xyz) or Set foo = x.Item(5)
            Item = mCol.Item(vntIndexKey)

            Exit Property

localError:

            Dim EmptyItem As New clsGeneralAlert

            EmptyItem.ID = -1

            Item = EmptyItem

        End Get
    End Property
    Public ReadOnly Property count() As Integer
        Get
            'used when retrieving the number of elements in the
            'collection. Syntax: Debug.Print x.Count
            count = mCol.Count()
        End Get
    End Property


    'Public ReadOnly Property NewEnum() As stdole.IUnknown
    'Get
    'this property allows you to enumerate
    'this collection with the For...Each syntax
    'NewEnum = mCol._NewEnum
    'End Get
    'End Property

    Public Function GetEnumerator() As System.Collections.IEnumerator Implements System.Collections.IEnumerable.GetEnumerator
        'GetEnumerator = mCol.GetEnumerator
    End Function


    Public Sub Remove(ByRef vntIndexKey As Object)
        'used when removing an element from the collection
        'vntIndexKey contains either the Index or Key, which is why
        'it is declared as a Variant
        'Syntax: x.Remove(xyz)
        mCol.Remove(vntIndexKey)
    End Sub


    Private Sub Class_Initialize_Renamed()
        'creates the collection when this class is created
        mCol = New Collection
    End Sub
    Public Sub New()
        MyBase.New()
        Class_Initialize_Renamed()
    End Sub


    Private Sub Class_Terminate_Renamed()
        'destroys collection when this class is terminated
        mCol = Nothing
    End Sub
    Protected Overrides Sub Finalize()
        Class_Terminate_Renamed()
        MyBase.Finalize()
    End Sub
End Class