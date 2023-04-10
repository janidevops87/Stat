Option Strict Off
Option Explicit On
Public Class colSourceCodes
    Implements System.Collections.IEnumerable

    'local variable to hold collection
    Private mCol As Collection

    Public Parent As Object
    Public Function AddItem(ByVal SourceCode As clsSourceCode) As Short

        On Error GoTo localError

        Dim NewSourceCode As New clsSourceCode

        NewSourceCode = SourceCode

        'Add item to the collection
        NewSourceCode.Parent = Me

        Call mCol.Add(NewSourceCode, NewSourceCode.Key)

        Exit Function

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        AddItem = -1
        Exit Function

    End Function
    Public Function GetItems(Optional ByVal pvType As Object = Nothing) As Short
        '************************************************************************************
        'Name: GetItems
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Retrieves SourceCodes info from database and populates collection of object's variables
        'Returns: Integer
        'Params: pvType
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 12/8/04                          Changed by: Scott Plummer
        'Release #: 7.7.2                               Task: 312
        'Description:  Populate new variable, NameUnAbbrev, from DB
        '====================================================================================
        'Date Changed: 01/22/2007                          Changed by: Thien Ta
        'Release #: 8.3                                     Task:
        'Description:  added flag to track donortrac clients in source code
        '====================================================================================
        '************************************************************************************

        On Error GoTo localError

        Dim NewSourceCode As New clsSourceCode
        Dim vQuery As String = ""
        Dim vResultArray As New Object
        Dim I As Short
        Dim j As Short

        'Clear the current collection
        For I = 1 To mCol.Count()
            mCol.Remove(1)
        Next I

        vQuery = "SELECT DISTINCT SourceCodeID, SourceCodeName, SourceCodeDescription, SourceCodeType, SourceCodeDefaultAlert, SourceCodeLineCheckInstruc, SourceCodeLineCheckInterval, "

        For I = 1 To 7
            vQuery = vQuery & "SourceCode" & I & "Start, "
        Next I

        For I = 1 To 6
            vQuery = vQuery & "SourceCode" & I & "End, "
        Next I

        vQuery = vQuery & "SourceCode7End, "
        'Added for 7.7.2 to allow display of entire, unabbreviated
        'Source Code name.  12/8/04 - SAP
        vQuery = vQuery & "SourceCodeNameUnAbbrev "
        'T.T 01/05/2005 Rotation sourcecode
        vQuery = vQuery & " ,SourceCodeRotationActive, SourceCodeRotationTrue, SourceCodeRotationAlias "
        'T.T 01/22/2007 flag for DonorTrac Client
        vQuery = vQuery & ",SourceCodeDonorTracClient "
        If Not IsNothing(pvType) Then

            'Get the items by type
            vQuery = vQuery & "FROM SourceCode " & "WHERE SourceCodeType = " & pvType & " "

        Else

            'Get all items
            vQuery = vQuery & "FROM SourceCode "

        End If

        'Check if LeaseOrganization and to where clause if it is
        If AppMain.ParentForm.LeaseOrganization <> 0 Then
            If InStr(1, vQuery, "WHERE", CompareMethod.Text) = 0 Then
                vQuery = vQuery & "WHERE "
            Else
                vQuery = vQuery & "AND "
            End If
            vQuery = vQuery & "SourceCodeName IN (SELECT DISTINCT SourceCode.SourceCodeName FROM " & "SourceCodeOrganization LEFT JOIN SourceCode ON SourceCode.SourceCodeID = SourceCodeOrganization.SourceCodeID " & "Where (SourceCodeType = 2 Or SourceCodeType = 4) AND SourceCodeOrganization.OrganizationID = " & AppMain.ParentForm.LeaseOrganization & ") "
        End If

        vQuery = vQuery & "ORDER BY SourceCodeName; "

        GetItems = modODBC.Exec(vQuery, vResultArray)

        If GetItems = SUCCESS Then

            'Create the individual items
            For I = 0 To UBound(vResultArray, 1)
                If vResultArray(I, 23) = "-1" Then
                    NewSourceCode.Key = "k" & CStr(vResultArray(I, 0))
                    NewSourceCode.ID = vResultArray(I, 0)
                    NewSourceCode.Name = vResultArray(I, 1) & vResultArray(I, 24)
                    NewSourceCode.SourceCodeRotationActive = vResultArray(I, 22)
                    NewSourceCode.SourceCodeRotationTrue = vResultArray(I, 23)
                    NewSourceCode.SourceCodeRotationAlias = vResultArray(I, 24)
                    NewSourceCode.Description = vResultArray(I, 2)
                    NewSourceCode.CodeType = vResultArray(I, 3)

                Else
                    'Set the properties of the new item
                    NewSourceCode.Key = "k" & CStr(vResultArray(I, 0))
                    NewSourceCode.ID = vResultArray(I, 0)
                    NewSourceCode.Name = vResultArray(I, 1)
                    NewSourceCode.Description = vResultArray(I, 2)
                    NewSourceCode.CodeType = vResultArray(I, 3)
                    NewSourceCode.SourcecodeDonorTracClient = vResultArray(I, 25)

                End If
                Select Case NewSourceCode.CodeType
                    Case REFERRAL
                        NewSourceCode.CodeTypeName = "Referral"
                    Case Message
                        NewSourceCode.CodeTypeName = "Message"
                    Case IMPORT
                        NewSourceCode.CodeTypeName = "Import"
                End Select
                NewSourceCode.DefaultAlert = vResultArray(I, 4)
                NewSourceCode.LineCheckInstructions = vResultArray(I, 5)
                NewSourceCode.LineCheckInterval = modConv.TextToLng(vResultArray(I, 6))

                NewSourceCode.LineActiveStart1 = vResultArray(I, 7)
                NewSourceCode.LineActiveStart2 = vResultArray(I, 8)
                NewSourceCode.LineActiveStart3 = vResultArray(I, 9)
                NewSourceCode.LineActiveStart4 = vResultArray(I, 10)
                NewSourceCode.LineActiveStart5 = vResultArray(I, 11)
                NewSourceCode.LineActiveStart6 = vResultArray(I, 12)
                NewSourceCode.LineActiveStart7 = vResultArray(I, 13)

                NewSourceCode.LineActiveEnd1 = vResultArray(I, 14)
                NewSourceCode.LineActiveEnd2 = vResultArray(I, 15)
                NewSourceCode.LineActiveEnd3 = vResultArray(I, 16)
                NewSourceCode.LineActiveEnd4 = vResultArray(I, 17)
                NewSourceCode.LineActiveEnd5 = vResultArray(I, 18)
                NewSourceCode.LineActiveEnd6 = vResultArray(I, 19)
                NewSourceCode.LineActiveEnd7 = vResultArray(I, 20)
                'Added for 7.7.2 to allow display of entire, unabbreviated
                'Source Code name.  12/8/04 - SAP
                NewSourceCode.NameUnAbbrev = vResultArray(I, 21)
                NewSourceCode.SourcecodeDonorTracClient = vResultArray(I, 25)

                'Add each row to the collection
                Call mCol.Add(NewSourceCode, NewSourceCode.Key)

                NewSourceCode = New clsSourceCode

            Next I

        End If

        Exit Function

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())

        GetItems = -1
        Exit Function
        Resume
    End Function

    Public Function FillListView(ByRef pvListView As Object) As Integer

        On Error GoTo localError

        Dim cSourceCode As New clsSourceCode
        Dim I As Short
        Dim vList As New Object

        'Clear the current list
        Call modControl.ClearListView(pvListView)

        'Fill an array of data
        If mCol.Count() > 0 Then

            ReDim vList(mCol.Count() - 1, 2)

            For I = 0 To mCol.Count() - 1

                cSourceCode = mCol.Item(I + 1)

                vList(I, 0) = cSourceCode.Key
                vList(I, 1) = cSourceCode.Name
                vList(I, 2) = cSourceCode.Description

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
    Public Function FillListView2(ByRef pvListView As Object) As Integer

        On Error GoTo localError

        Dim cSourceCode As New clsSourceCode
        Dim I As Short
        Dim vList As New Object

        'Clear the current list
        Call modControl.ClearListView(pvListView)

        'Fill an array of data
        If mCol.Count() > 0 Then

            ReDim vList(mCol.Count() - 1, 2)

            For I = 0 To mCol.Count() - 1

                cSourceCode = mCol.Item(I + 1)

                vList(I, 0) = cSourceCode.Key
                vList(I, 1) = cSourceCode.Name
                vList(I, 2) = cSourceCode.CodeTypeName

            Next I

            Call modControl.SetListViewRows(vList, True, pvListView, False)

            FillListView2 = True

        Else
            FillListView2 = False
        End If

        Exit Function

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        FillListView2 = False
        Exit Function

    End Function

    Public Function FillListViewLineCheck(ByRef pvListView As Object) As Integer

        On Error GoTo localError

        Dim cSourceCode As New clsSourceCode
        Dim I As Short
        Dim vList As New Object

        'Clear the current list
        Call modControl.ClearListView(pvListView)

        'Fill an array of data
        If mCol.Count() > 0 Then

            ReDim vList(mCol.Count() - 1, 2)

            For I = 0 To mCol.Count() - 1

                cSourceCode = mCol.Item(I + 1)

                vList(I, 0) = cSourceCode.Key
                vList(I, 1) = cSourceCode.Name
                vList(I, 2) = cSourceCode.LineCheckInstructions

            Next I

            Call modControl.SetListViewRows(vList, True, pvListView, False)

            FillListViewLineCheck = True

        Else
            FillListViewLineCheck = False
        End If

        Exit Function

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        FillListViewLineCheck = False
        Exit Function

    End Function
    Public Function FillListBox(ByRef pvListBox As Object) As Integer

        On Error GoTo localError

        Dim cSourceCode As New clsSourceCode
        Dim I As Short
        Dim vList As New Object

        If (TypeOf pvListBox Is ComboBox) Then
            pvListBox.Items.Clear()
        Else
            pvListBox.Clear()
        End If


        'Fill an array of data
        If mCol.Count() > 0 Then

            ReDim vList(mCol.Count() - 1, 2)

            For I = 0 To mCol.Count() - 1

                cSourceCode = mCol.Item(I + 1)

                vList(I, 0) = cSourceCode.ID
                vList(I, 1) = cSourceCode.Name

            Next I

            Call modControl.SetTextID(pvListBox, vList, True)

            FillListBox = True

        Else
            FillListBox = False
        End If

        Exit Function

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())

        FillListBox = False

        Exit Function
        Resume
    End Function


    Public Function Add(ByRef Key As String, Optional ByRef sKey As String = "") As clsSourceCode

        'create a new object
        Dim objNewMember As clsSourceCode
        objNewMember = New clsSourceCode

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

    Default Public ReadOnly Property Item(ByVal vntIndexKey As Object) As clsSourceCode
        Get

            On Error GoTo localError

            'used when referencing an element in the collection
            'vntIndexKey contains either the Index or Key to the collection,
            'this is why it is declared as a Variant
            'Syntax: Set foo = x.Item(xyz) or Set foo = x.Item(5)
            Item = mCol.Item(vntIndexKey)

            Exit Property

localError:

            Dim EmptyItem As New clsSourceCode

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

        ' TODO: This is better than returning Nothing and get NullReferenceExceptions 
        ' in calling code, but should have real implementation.
        Return Enumerable.Empty(Of colSourceCodes)().GetEnumerator()
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
    Public Sub Close()
        mCol.Clear()
        Finalize()

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