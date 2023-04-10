Option Strict Off
Option Explicit On
Public Class colOrganizations
    Implements System.Collections.IEnumerable

    'local variable to hold collection
    Private mCol As Collection

    Public Parent As Object
    Public Function GetItems(ByVal ParamArray pvFilters() As Object) As Short

        'On Error GoTo localError
        Dim vQuery As String = ""
        Dim vResultArray As New Object
        Dim I As Short
        Dim vFROMStatement As String = ""
        Dim vWHEREStatement As String = ""
        Dim CurrentParent As New Object

        'Clear the current collection
        For I = 1 To mCol.Count()
            mCol.Remove(1)
        Next I

        CurrentParent = Me.Parent

        If CurrentParent Is Nothing Then

            'Determine the FROM statement
            vFROMStatement = "FROM Organization "

            'Determine the WHERE statement
            If Not IsNothing(pvFilters) Then

                vWHEREStatement = ""

                I = UBound(pvFilters)

                If I >= 0 Then
                    If modConv.TextToInt(pvFilters(0)) <> ALL_STATES And modConv.TextToInt(pvFilters(0)) <> -1 Then
                        vWHEREStatement = "WHERE State.StateID = " & modConv.TextToLng(pvFilters(0)) & " "
                    End If
                End If

                If I >= 1 Then
                    If modConv.TextToInt(pvFilters(1)) <> ALL_ORG_TYPES And modConv.TextToInt(pvFilters(1)) <> -1 Then
                        If vWHEREStatement = "" Then
                            vWHEREStatement = "WHERE Organization.OrganizationTypeID = " & modConv.TextToLng(pvFilters(1)) & " "
                        Else
                            vWHEREStatement = vWHEREStatement & "AND Organization.OrganizationTypeID = " & modConv.TextToLng(pvFilters(1)) & " "
                        End If
                    End If
                End If

                If I >= 2 Then
                    If modConv.TextToInt(pvFilters(2)) <> -1 Then
                        If vWHEREStatement = "" Then
                            vWHEREStatement = "WHERE Organization.OrganizationConsentInterval = " & modConv.TextToInt(pvFilters(2)) & " "
                        Else
                            vWHEREStatement = vWHEREStatement & "AND Organization.OrganizationConsentInterval = " & modConv.TextToInt(pvFilters(2)) & " "
                        End If
                    End If
                End If

            Else
                vWHEREStatement = ""
            End If

        ElseIf TypeOf CurrentParent Is clsSourceCode Then

            'Determine the FROM statement
            vFROMStatement = "FROM SourceCodeOrganization JOIN Organization ON SourceCodeOrganization.OrganizationID = Organization.OrganizationID "

            'Determine the WHERE statement
            vWHEREStatement = "WHERE SourceCodeOrganization.SourceCodeID = " & Me.Parent.ID & " "

        End If


        'Get the data
        'ccarroll 02/08/2011 Added DISTINCT to prevent duplicate keys from bad data
        vQuery = String.Format("SELECT DISTINCT Organization.OrganizationID, Organization.OrganizationName, Organization.OrganizationAddress1, Organization.OrganizationAddress2, Organization.OrganizationCity, County.CountyName, State.StateAbbrv, Organization.OrganizationZipCode, OrganizationType.OrganizationTypeName, COALESCE(Organization.OrganizationConsentInterval, 0) {0} JOIN OrganizationType ON Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID JOIN County ON Organization.CountyID = County.CountyID JOIN State ON Organization.StateID = State.StateID {1} ORDER BY Organization.OrganizationName ASC ", vFROMStatement, vWHEREStatement)


        GetItems = modODBC.Exec(vQuery, vResultArray)

        If GetItems = SUCCESS Then

            'Create the individual items
            Dim organization As Object
            For I = 0 To UBound(vResultArray, 1)

                Dim tempOrganization As clsOrganization = New clsOrganization(vResultArray(I, 0), vResultArray(I, 1), vResultArray(I, 2), vResultArray(I, 3), vResultArray(I, 4), vResultArray(I, 5), vResultArray(I, 6), vResultArray(I, 7), vResultArray(I, 8), modConv.TextToInt(vResultArray(I, 9)), Me)
                Call mCol.Add(tempOrganization, tempOrganization.Key)

            Next I
        End If


        Exit Function

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        GetItems = -1
        Exit Function

    End Function

    Public Function GetUniqueConsentIntervals(ByRef prResultArray As Object) As Short

        On Error GoTo localError

        Dim vQuery As String = ""
        Dim vResultArray As New Object


        'Get the data
        vQuery = "SELECT DISTINCT Organization.OrganizationConsentInterval, Organization.OrganizationConsentInterval FROM Organization GROUP BY Organization.OrganizationConsentInterval "

        GetUniqueConsentIntervals = modODBC.Exec(vQuery, vResultArray)

        If GetUniqueConsentIntervals = SUCCESS Then

            prResultArray = vResultArray

        End If

        Exit Function

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        GetUniqueConsentIntervals = -1
        Exit Function

    End Function


    Public Function AddItem(ByVal Organization As clsOrganization) As Short

        On Error GoTo localError

        Dim NewOrganization As New clsOrganization

        NewOrganization = Organization

        'Add item to the collection
        NewOrganization.Parent = Me

        Call mCol.Add(NewOrganization, NewOrganization.Key)

        Exit Function

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        AddItem = -1
        Exit Function

    End Function
    Public Function FillListView(ByRef pvListView As Object) As Integer

        On Error GoTo localError

        Dim cOrganization As New clsOrganization
        Dim I As Short
        Dim vList As New Object

        'Clear the current list
        Call modControl.ClearListView(pvListView)

        'Fill an array of data
        If mCol.Count() > 0 Then

            ReDim vList(mCol.Count() - 1, 4)

            For I = 0 To mCol.Count() - 1

                cOrganization = mCol.Item(I + 1)

                vList(I, 0) = cOrganization.Key
                vList(I, 1) = cOrganization.Name
                vList(I, 2) = cOrganization.City
                vList(I, 3) = cOrganization.State
                vList(I, 4) = cOrganization.OrgType

            Next I

            Call modControl.SetListViewRows(vList, True, pvListView, False)

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

    Public Function FillListBox(ByRef pvListBox As ComboBox) As Integer

        On Error GoTo localError

        Dim cOrganization As New clsOrganization
        Dim I As Short
        Dim vList As New Object

        'Clear the current list
        Call pvListBox.Items.Clear()

        'Fill an array of data
        If mCol.Count() > 0 Then

            ReDim vList(mCol.Count() - 1, 1)
            'ReDim vList(mCol.Count(), 1)
            For I = 0 To mCol.Count() - 1

                cOrganization = mCol.Item(I + 1)

                vList(I, 0) = cOrganization.ID
                vList(I, 1) = cOrganization.Name


            Next I

            Call modControl.SetTextID(pvListBox, vList)

            FillListBox = True

        Else
            FillListBox = False
        End If

        Exit Function

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        FillListBox = False
        Exit Function

    End Function


    Public Function Add(ByRef Key As String, Optional ByRef sKey As String = "") As clsOrganization

        'create a new object
        Dim objNewMember As clsOrganization
        objNewMember = New clsOrganization

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

    Default Public ReadOnly Property Item(ByVal vntIndexKey As Object) As clsOrganization
        Get

            On Error GoTo localError

            'used when referencing an element in the collection
            'vntIndexKey contains either the Index or Key to the collection,
            'this is why it is declared as a Variant
            'Syntax: Set foo = x.Item(xyz) or Set foo = x.Item(5)
            Item = mCol.Item(vntIndexKey)

            Exit Property

localError:

            Dim EmptyItem As New clsOrganization

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