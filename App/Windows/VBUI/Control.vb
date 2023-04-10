Option Strict Off
Option Explicit On
Option Compare Text
Imports System.Collections.Generic
Imports Statline.Stattrac.Framework
Module modControl


    Public Const LVM_FIRST As Integer = &H1000
    Public Const LVM_SETEXTENDEDLISTVIEWSTYLE As Decimal = LVM_FIRST + 54
    Public Const LVM_GETEXTENDEDLISTVIEWSTYLE As Decimal = LVM_FIRST + 55
    Public Const LVS_EX_FULLROWSELECT As Integer = &H20
    Public HoldStr As String 'T.T 09/23/2004 string array for Hold on controls
    Public Sub Disable(ByRef pvControl As System.Windows.Forms.Control)

        On Error Resume Next

        pvControl.Enabled = False
        pvControl.BackColor = System.Drawing.SystemColors.Control

    End Sub
    Public Sub Enable(ByRef pvControl As System.Windows.Forms.Control, Optional ByRef vskip As Boolean = False)

        On Error Resume Next

        pvControl.Visible = True
        pvControl.Enabled = True

        If pvControl.Name = "CboPhysician" And vskip = False Then
            Call HoldControl(pvControl)
            Exit Sub
        End If

        If TypeOf pvControl Is System.Windows.Forms.CheckBox Then

            'do nothing to the backcolor

        Else

            pvControl.BackColor = System.Drawing.Color.White

        End If

    End Sub
    Function HoldControl(ByRef pvControl As System.Windows.Forms.ComboBox) As Boolean
        '**************************************************************
        'Created: T.T 09/22/04
        'modControl.HoldControl
        '                       -This procedure changes the tag on a control that tells
        '                       -The user to address the control
        'parameters: pvControl  - Control to be tagged
        'Stored procs: N/A
        '**************************************************************


        If pvControl.Parent.FindForm.Name = "FrmNew" Then
            Dim formTemp As FrmNew = DirectCast(pvControl.Parent.FindForm, FrmNew)
            If pvControl.Name = "CboName" Then
                If formTemp.CboName.Tag.ToString() = "" Then
                    formTemp.CboName.Tag = 0
                End If
                If formTemp.CboName.Tag.ToString() <> "" Then

                    If CDbl(formTemp.CboName.Tag) > 1 Then
                        formTemp.CboName.BackColor = System.Drawing.Color.Yellow
                        formTemp.TxtPersonType.BackColor = System.Drawing.Color.Yellow
                        HoldControl = True
                    End If
                    If CDbl(formTemp.CboName.Tag) = 1 Then
                        formTemp.CboName.BackColor = System.Drawing.Color.White
                        formTemp.TxtPersonType.BackColor = System.Drawing.Color.White
                    End If
                End If
            End If
        End If
        If pvControl.Parent.FindForm.Name = "FrmReferral" Then
            Dim formTemp As FrmReferral = DirectCast(pvControl.Parent.FindForm, FrmReferral)
            If pvControl.Name = "CboApproachedBy" Then

                If formTemp.CboApproachedBy.Tag.ToString() = "" Then
                    formTemp.CboApproachedBy.Tag = 0
                End If

                If formTemp.CboApproachedBy.Tag.ToString() <> "" Then

                    If CDbl(formTemp.CboApproachedBy.Tag) > 1 Then
                        formTemp.CboApproachedBy.BackColor = System.Drawing.Color.Yellow
                        HoldControl = True
                    End If
                    If CDbl(formTemp.CboApproachedBy.Tag) = 1 Then
                        formTemp.CboApproachedBy.BackColor = System.Drawing.Color.White
                    End If
                End If
            End If


            If pvControl.Name = "CboPhysician" Then
                If formTemp.CboPhysician(0).Tag = "" Then
                    formTemp.CboPhysician(0).Tag = 0
                End If
                If formTemp.CboPhysician(1).Tag = "" Then
                    formTemp.CboPhysician(1).Tag = 0
                End If
                If pvControl.Name = "CboPhysician" Then
                    If formTemp.CboPhysician(0).Tag <> "" Then

                        If CDbl(formTemp.CboPhysician(0).Tag) > 1 Then
                            If formTemp.CboPhysician(0).Enabled = True Then
                                formTemp.CboPhysician(0).BackColor = System.Drawing.Color.Yellow
                            Else
                                formTemp.CboPhysician(0).BackColor = System.Drawing.SystemColors.Control
                            End If
                            HoldControl = True

                        End If
                        If CDbl(formTemp.CboPhysician(0).Tag) = 1 Then
                            If formTemp.CboPhysician(0).Enabled = True Then
                                formTemp.CboPhysician(0).BackColor = System.Drawing.Color.White
                            Else
                                formTemp.CboPhysician(0).BackColor = System.Drawing.SystemColors.Control
                            End If
                            HoldControl = False
                        End If
                    End If

                    If formTemp.CboPhysician(1).Tag <> "" Then

                        If CDbl(formTemp.CboPhysician(1).Tag) > 1 Then
                            If formTemp.CboPhysician(1).Enabled = True Then
                                formTemp.CboPhysician(1).BackColor = System.Drawing.Color.Yellow
                            Else
                                formTemp.CboPhysician(1).BackColor = System.Drawing.SystemColors.Control
                            End If
                            HoldControl = True

                        End If
                        If CDbl(formTemp.CboPhysician(1).Tag) = 1 Then
                            If formTemp.CboPhysician(1).Enabled = True Then
                                formTemp.CboPhysician(1).BackColor = System.Drawing.Color.White
                            Else
                                formTemp.CboPhysician(1).BackColor = System.Drawing.SystemColors.Control
                            End If
                            HoldControl = False
                        End If
                    End If
                End If
            End If
        End If

    End Function
    Public Function FillListView3(ByRef pvListView As Object, ByRef vParams As Object, ByRef vParams2 As Object) As Integer

        On Error GoTo localError

        Dim cSourceCode As New clsSourceCode
        Dim I As Short
        Dim vList As New Object

        'Clear the current list
        Call modControl.ClearListView(pvListView)

        'Fill an array of data

        ReDim vList(vParams2(0, 0) - 1, 2)

        For I = 0 To vParams2(0, 0) - 1

            vList(I, 0) = vParams(I, 1)
            vList(I, 1) = vParams(I, 4)
            vList(I, 2) = vParams(I, 2)

        Next I

        Call modControl.SetListViewRows(vList, True, pvListView, False)

        Exit Function

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        FillListView3 = False
        Exit Function

    End Function

    Sub ClearListView(ByRef pcList As Object)

        pcList.Items.Clear()
        pcList.View = View.Details

    End Sub


    Function GetID(ByRef pcList As Object) As Integer

        If (pcList Is Nothing) Then
            GetID = -1
            Exit Function
        End If

        Dim SelectedIndex As Integer = -1
        'Make sure we have a selectable control before looking at the SelectedIndex property
        Dim selectableControls() As String = {"ComboBox", "ListBox", "ListView", "TabControl"}
        If selectableControls.Contains(pcList.GetType().Name) Then
            SelectedIndex = pcList.SelectedIndex
        End If

        'bret 01/14/2010 replaced  .ListIndex  with SelectedIndex
        If SelectedIndex <> -1 Then
            'bret 01/14/2010 replaced .ItemData(pcList.ListIndex) with pcList.SelectedValue
            If TypeOf pcList.Items(SelectedIndex) Is ValueDescriptionPair Then
                GetID = pcList.Items(SelectedIndex).Value
            Else
                GetID = SelectedIndex
            End If

        Else
            GetID = -1
        End If

        Exit Function

    End Function

    Function GetText(ByRef pcList As Object) As String

        On Error GoTo handleError

        If pcList.SelectedIndex <> -1 Then
            GetText = pcList.Text
        Else
            GetText = ""
        End If

        Exit Function

handleError:

        GetText = ""

    End Function

    Function GetSelID(ByRef pcList As Object, ByRef prResult1 As Object) As Short

        On Error Resume Next

        Dim I, vNumSel As Short
        Dim vTemp As New Object

        ReDim vTemp(pcList.Items.Count - 1)

        For I = 0 To pcList.Items.Count - 1
            If pcList.SelectedIndex = I Then
                vTemp(vNumSel) = pcList.Items(I).Value
                vNumSel = vNumSel + 1
            End If
        Next I

        If vNumSel > 0 Then

            ReDim prResult1(vNumSel - 1)

            For I = 0 To vNumSel - 1
                prResult1(I) = vTemp(I)
            Next I

            GetSelID = vNumSel

        Else
            GetSelID = vNumSel
        End If

    End Function
    Function GetSelListViewID(ByRef pvList As Object, ByRef prResults As Object) As Short

        Dim I As Short
        Dim vNumSel As Short
        Dim vTemp As New Object
        Dim vTriage As New Object
        Dim vFS As New Object

        'Set pvtest = pvList.ListItem.Add
        ReDim vTemp(pvList.Items.Count - 1, 3)

        vNumSel = 0

        For I = 0 To pvList.Items.Count - 1

            If pvList.Items(I).Selected = True Then

                'ccarroll 04/14/2010 added check for DMV selection which uses Text instead of Tag
                If pvList.Name = "LstViewSelectedDSN" Or pvList.Name = "LstViewAvailableDSN" Then
                    vTemp(vNumSel, 0) = pvList.Items(I).Text
                Else
                    vTemp(vNumSel, 0) = pvList.Items(I).Tag
                End If

                If pvList.Name = "LstViewSelectedOrganizations" Or pvList.Name = "LstViewAvailableOrganizations" Then
                    vTemp(vNumSel, 0) = pvList.Items(I).Tag
                End If
                If pvList.Name = "LstViewEnabledLOCalls" Or pvList.Name = "LstViewDisabledLOCalls" Then '*T.T 6/1/2004 added to distinguish LOCallsEnabled and Disabled
                    vTriage = modConv.TextToInt(pvList.Items(I).SubItems.Item(4).Text)
                    vFS = modConv.TextToInt(pvList.Items(I).SubItems.Item(5).Text)
                    vTemp(vNumSel, 1) = vTriage
                    vTemp(vNumSel, 2) = vFS
                    vTemp(vNumSel, 3) = pvList.Items(I).Text
                End If

                vNumSel = vNumSel + 1
            End If
        Next I

        If vNumSel > 0 Then
            ReDim prResults(vNumSel - 1, 3)

            For I = 0 To vNumSel - 1
                prResults(I, 0) = vTemp(I, 0)
                If pvList.Name = "LstViewEnabledLOCalls" Or pvList.Name = "LstViewDisabledLOCalls" Then '*T.T 6/1/2004 added to distinguish LOCallsEnabled and Disabled
                    prResults(I, 1) = vTemp(I, 1)
                    prResults(I, 2) = vTemp(I, 2)
                    prResults(I, 3) = vTemp(I, 3)
                End If
            Next I
        End If

        GetSelListViewID = vNumSel + 1

    End Function

    Function GetUnusedListViewID(ByRef pvForm As Object, ByRef pvList As Object, ByRef prResults As Object, ByRef pvItemUsed As Boolean) As Short
        'FSProj drh 5/15/02 - Get list items that do not have associated SubCriteria

        Dim I As Short
        Dim j As Short
        Dim vNumSel As Short
        Dim vTemp As New Object
        Dim vSubCriteria As New Object
        Dim vAddList As Boolean

        'FSProj drh 5/16/02 - Need to uncomment this line when we roll out v7.0; Add Comment when compiling pre-v7.0 versions
        'Call modStatQuery.QueryAssignedSubtypesProcessors(pvForm, vSubCriteria)

        ReDim vTemp(pvList.Items.Count - 1, 0)

        vNumSel = 0

        For I = 0 To pvList.Items.Count - 1
            vAddList = True

            If pvList.Items(I).Selected = True Then

                'ccarroll 04/09/2010 comment out 
                'If Not IsNothing(vSubCriteria) Then
                If TypeOf vSubCriteria Is Array Then
                    For j = 0 To UBound(vSubCriteria, 1)
                        If pvList.Items(I).SubItems(IIf(pvList.Name = "LstViewSelectedProcessors", 4, 3)) = vSubCriteria(j, IIf(pvList.Name = "LstViewSelectedProcessors", 1, 0)) Then
                            vAddList = False
                            pvItemUsed = True
                            Exit For
                        End If
                    Next j
                End If

                If vAddList Then
                    vTemp(vNumSel, 0) = pvList.Items(I).Tag
                    vNumSel = vNumSel + 1
                End If

            End If
        Next I

        If vNumSel > 0 Then
            ReDim prResults(vNumSel - 1, 0)

            For I = 0 To vNumSel - 1
                prResults(I, 0) = vTemp(I, 0)
            Next I
        End If

        GetUnusedListViewID = vNumSel + 1

    End Function
    Function GetSelListViewSubItems(ByRef pvList As Object, ByRef prResults As Object) As Short

        Dim I As Integer
        Dim j As Short
        Dim vNumSel As Short
        Dim vNumCols As Short
        Dim vTemp As New Object

        vNumSel = 0
        vNumCols = pvList.Columns.Count() - 1
        ReDim vTemp(pvList.Items.Count - 1, vNumCols)

        For I = 0 To pvList.Items.Count - 1

            If pvList.Items(I).Selected = True Then
                For j = 0 To vNumCols
                    vTemp(vNumSel, j) = pvList.Items(I).SubItems(j).Text
                Next j
                vNumSel = vNumSel + 1
            End If
        Next I

        ReDim prResults(vNumSel - 1, vNumCols)

        For I = 0 To vNumSel - 1
            For j = 0 To vNumCols
                prResults(I, j) = vTemp(I, j)
            Next j
        Next I

        GetSelListViewSubItems = vNumSel + 1

    End Function
    Function GetSelListViewItems(ByRef pvList As Object, ByRef prResults As Object) As Short

        On Error Resume Next

        Dim I As Short
        Dim j As Short
        Dim vNumSel As Short
        Dim vTemp As New Object

        vNumSel = 0

        ReDim vTemp(pvList.Items.Count - 1, 0)

        For I = 0 To pvList.Items.Count - 1
            If pvList.Items(I).Selected = True Then
                vTemp(vNumSel, 0) = pvList.Items(I).Text
                vNumSel = vNumSel + 1
            End If
        Next I

        ReDim prResults(vNumSel - 1, 0)

        For I = 0 To vNumSel - 1
            prResults(I, 0) = vTemp(I, 0)
        Next I

        GetSelListViewItems = vNumSel + 1

    End Function
    Function GetListViewRows(ByRef pvList As Object, ByRef prResults As Object) As Short

        Dim I As Short
        Dim j As Short
        Dim vRows As Short
        Dim vCols As Short

        vRows = pvList.Items.Count - 1
        'The number of array columns is one more than
        'the number of column headers because the row ID
        'is stored in the list item tag property
        vCols = pvList.Columns.Count

        ReDim prResults(vRows, vCols)

        'Get the item IDs first
        For I = 0 To vRows
            prResults(I, 0) = pvList.Items(I).Tag
            'Next, get the item text
            prResults(I, 1) = pvList.Items(I).Text
            'Then get the subitems
            For j = 1 To vCols - 1
                prResults(I, j + 1) = pvList.Items(I).SubItems(j)
            Next
        Next I

        GetListViewRows = vRows

    End Function

    Function GetListTextID(ByRef pcList As ComboBox, ByRef prResult2 As Object) As Short

        On Error GoTo handleError

        Dim I, j As Short

        ReDim prResult2(pcList.Items.Count - 1, 1)

        For I = 0 To pcList.Items.Count - 1
            'pcList.Items.Add(New ValueDescriptionPair(prResult2(I, 0), prResult2(I, 1)))
            prResult2(I, 0) = pcList.Items(I).Value
            prResult2(I, 1) = pcList.Items(I).Description

        Next I

        GetListTextID = pcList.Items.Count

        Exit Function

handleError:

        GetListTextID = -1
        Exit Function

    End Function

    Sub SelectFirst(ByRef pcList As Object)

        If pcList.Items.Count > 0 Then
            pcList.SelectedIndex = 0
        Else
            pcList.SelectedIndex = -1
        End If

    End Sub

    Function SelectID(ByRef pcList As System.Windows.Forms.ComboBox, ByVal pID As Integer) As Boolean

        On Error GoTo localError

        Dim I As Short

        SelectID = True

        For I = 0 To pcList.Items.Count - 1
            If pcList.Items(I).Value = pID Then
                pcList.SelectedIndex = I
                SelectID = True
                Exit Function
            End If
        Next I

        pcList.SelectedIndex = -1
        pcList.Text = ""
        SelectID = False

        Exit Function
localError:
        Resume Next
        Resume
    End Function

    Function SelectIDFromObject(ByRef pcList As System.Windows.Forms.ComboBox, ByVal obj As Object) As Boolean

        Dim I As Short

        SelectIDFromObject = True

        'Make sure we have a non-null, numeric value to work with
        If IsDBNull(obj) OrElse Not IsNumeric(obj) Then
            SelectIDFromObject = False
            Exit Function
        End If

        'Select matching item
        For I = 0 To pcList.Items.Count - 1
            If pcList.Items(I).Value = obj Then
                pcList.SelectedIndex = I
                SelectIDFromObject = True
                Exit Function
            End If
        Next I

        pcList.SelectedIndex = -1
        pcList.Text = ""
        SelectIDFromObject = False

    End Function

    Public Function SelectNone(ByRef pcList As System.Windows.Forms.ComboBox) As Object

        On Error Resume Next

        If pcList.Items.Count > 0 Then
            pcList.SelectedIndex = -1
        End If

    End Function


    Function SelectText(ByRef pcList As ComboBox, ByVal pText As String) As Boolean
        '************************************************************************************
        'Name: SelectText
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Compares string pText argument to select an item in a list control.
        'Returns: Nothing
        'Params: None
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 2/23/05                          Changed by: Scott Plummer
        'Release #: 8.0                               Task: None
        'Description:  Trimmed and UCased strings before comparison to eliminate problems
        '              caused by strings with trailing spaces.
        '====================================================================================
        '************************************************************************************

        Dim I As Short

        If TypeOf pcList Is System.Windows.Forms.ComboBox Then
            Select Case pcList.DropDownStyle
                Case 0, 1

                    pcList.Text = pText
                    SelectText = True
                    Exit Function

                Case 2

                    ' Trimmed String before checking for zero-length string.  2/23/05 - SAP
                    If Trim(pText) = "" Then
                        pcList.SelectedIndex = -1
                        SelectText = True
                        Exit Function
                    End If


                    For I = 0 To pcList.Items.Count - 1
                        ' Trimmed and UCased strings before comparison to eliminate problems when an Org name had a trailing space in it.  2/23/05 - SAP
                        If TypeOf pcList.Items(I) Is ValueDescriptionPair Then
                            If Trim(UCase(pcList.Items(I).Description)) = Trim(UCase(pText)) Then
                                pcList.SelectedIndex = I
                                SelectText = True
                                Exit Function
                            End If

                        Else
                            If Trim(UCase(pcList.Items(I))) = Trim(UCase(pText)) Then
                                pcList.SelectedIndex = I
                                SelectText = True
                                Exit Function
                            End If
                        End If
                    Next I

            End Select

            pcList.SelectedIndex = -1
            SelectText = False

        Else
            For I = 0 To pcList.Items.Count - 1
                If pcList.Items(I) = pText Then
                    pcList.SelectedIndex = I
                    'bret 01/19/2010 converted from pcList.Selected(I)
                    pcList.Items(I) = True
                    SelectText = True
                    Exit Function
                End If
            Next I

            pcList.SelectedIndex = -1
            SelectText = False

        End If

    End Function

    Function SetTextID(ByRef pcList As Object, ByRef pText As Object, Optional ByRef pClear As Object = Nothing, Optional ByRef pvAddAllItem As Object = Nothing) As Short

        Dim I, vItems As Short
        Dim vAllItem(0, 1) As Object
        Dim valueDescriptionPair As ValueDescriptionPair
        On Error GoTo SetTextIDEH

        If Not IsNothing(pClear) Then
            If pClear = True Then
                pcList.Items.Clear() 'T.T 8/6/2004 commented out
            End If
        Else
            pcList.Items.Clear() 'T.T 8/6/2004 commented out
        End If
        If (TypeOf pText Is Array) Then

            vItems = UBound(pText, 1)

            For I = 0 To vItems
                If IsNumeric(pText(I, 0)) Then
                    valueDescriptionPair = New ValueDescriptionPair(CInt(pText(I, 0)), pText(I, 1))
                    pcList.Items.Add(valueDescriptionPair)
                End If
            Next I

            SetTextID = vItems + 1
        End If
        If Not IsNothing(pvAddAllItem) Then
            If pvAddAllItem = True Then
                pcList.Items.Add(New ValueDescriptionPair(0, "*All"))
            End If
        End If

        Exit Function

SetTextIDEH:

        pcList.Items.Clear()
        SetTextID = -1
        Exit Function
        Resume
    End Function

    Function SetAutoCompleteTextID(ByRef pcList As Object, ByRef pText As Object) As Short

        Dim I, vItems As Short
        Dim valueDescriptionPair As ValueDescriptionPair
        Dim dctAutoCompleteItems As Dictionary(Of Integer, String) = New Dictionary(Of Integer, String)()

        pcList.DropDownStyle = ComboBoxStyle.DropDown
        pcList.AutoCompleteSource = AutoCompleteSource.ListItems
        pcList.AutoCompleteMode = AutoCompleteMode.Suggest
        pcList.Items.Clear()
        pcList.AutoCompleteCustomSource.Clear()

        If (Validater.ObjectIsValidArray(pText, 2, 1)) Then

            vItems = UBound(pText, 1)

            For I = 0 To vItems
                If IsNumeric(pText(I, 0)) Then
                    valueDescriptionPair = New ValueDescriptionPair(pText(I, 0), pText(I, 1))
                    pcList.Items.Add(valueDescriptionPair)
                    dctAutoCompleteItems.Add(pText(I, 0), pText(I, 1))
                End If
            Next I

            SetAutoCompleteTextID = vItems + 1
        End If

    End Function

    Function SetTextIDItem(ByRef pcList As Object, ByRef pID As Object, ByRef pText As Object) As Boolean

        On Error GoTo localError

        DirectCast(pcList, ComboBox).Items.Add(New ValueDescriptionPair(pID, pText))

        SetTextIDItem = True

        Exit Function

localError:

        SetTextIDItem = False
        Exit Function

    End Function


    Function SetTextID2(ByRef pcList As Object, ByRef pText As Object, Optional ByRef pClear As Object = Nothing, Optional ByRef pvAddAllItem As Object = Nothing) As Short

        Dim I, vItems As Short
        Dim vAllItem(0, 1) As Object

        On Error GoTo SetTextID2EH

        If Not IsNothing(pClear) Then
            If pClear = True Then
                pcList.Clear()
            End If
        Else
            pcList.Clear()
        End If

        vItems = UBound(pText, 2)

        For I = 0 To vItems
            pcList.Items.Add(New ValueDescriptionPair(pText(1, I), modConv.TextToLng(pText(0, I))))
            pcList.ItemData(pcList.NewIndex) = modConv.TextToLng(pText(0, I))
        Next I

        SetTextID2 = vItems + 1

        If Not IsNothing(pvAddAllItem) Then
            If pvAddAllItem = True Then
                pcList.Items.Add(New ValueDescriptionPair(0, "*All"))
            End If
        End If

        Exit Function

SetTextID2EH:

        pcList.Clear()
        SetTextID2 = -1
        Exit Function

    End Function

    Function ADOSetTextID(ByRef pcList As Object, ByRef pText As Object, Optional ByRef pClear As Object = Nothing, Optional ByRef pvAddAllItem As Object = Nothing) As Short

        Dim I, vItems As Short
        Dim vAllItem(0, 1) As Object

        On Error GoTo SetTextIDEH

        If Not IsNothing(pClear) Then
            If pClear = True Then
                pcList.Clear()
            End If
        Else
            pcList.Clear()
        End If

        vItems = UBound(pText, 2)

        For I = 0 To vItems
            pcList.Items.Add(New ValueDescriptionPair(modConv.TextToLng(pText(0, I)), pText(1, I)))

        Next I

        ADOSetTextID = vItems + 1

        If Not IsNothing(pvAddAllItem) Then
            If pvAddAllItem = True Then
                pcList.Items.Add(New ValueDescriptionPair(0, "*All"))
            End If
        End If

        Exit Function

SetTextIDEH:

        pcList.Clear()
        ADOSetTextID = -1
        Exit Function

    End Function
    Function SetListViewRows(ByRef pvValues As Object, ByRef pvUseTag As Boolean, ByRef pcListView As Object, ByRef pvNumberRows As Object, Optional ByRef pvSetIcons As Object = Nothing, Optional ByRef pvForm As Object = Nothing, Optional ByRef pvSetIconsSwitch As Object = Nothing, Optional ByRef pvCheckboxCol As Object = Nothing) As Short
        '************************************************************************************
        'Name: SetListViewRows
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Builds the ListView Detail
        'Returns: N/A
        'Params:
        '   pvValues array of data
        '   pvUserTag
        '   pcListView control to fill
        '   pvNumberRows boolean value to determine if method should add a autogenerated row number
        '   pvSetIcons
        '   pvForm
        '   pvSetIconsSwitch
        '   pvCheckBoxCol
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 06/10/07                       Changed by: Thien TA
        'Release #: 8.4                           Task: requirement 3.5
        'Description:Over expired event in dashboard shall be highlighted
        '====================================================================================
        'Date Changed: 06/13/07                       Changed by: Bret Knoll
        'Release #: 8.4.3.9                           Task: LogEvent AutoNumber and Deleted
        'Description:
        '   Do not use row numbers
        '   Change default order of columns
        '   move Rownumber to before Code
        '====================================================================================
        'Date Changed: 04/03/09                       Changed by: Bret Knoll
        'Release #: 8.4.8                             Task: Labs_pending and Acknowledge_to_Evaluate
        'Description:
        '   Allow Labs_pending and Acknowledge_to_Evaluate to expire
        '====================================================================================

        'FSProj drh 5/14/02 - Added optional pvCheckboxCol for Listviews with checkboxes

        On Error GoTo localError

        'This function fills a list view control with an
        'array of values. If the pvUseTag variable is true,
        'then this function assumes the first item
        'of the input array is to be assigned to the list item
        'tag property. This is most commonly used to store a
        'row ID.

        Dim vItems As Integer
        Dim vRowColor As Double
        Dim vSubItemCols As Short
        Dim vRowItem As System.Windows.Forms.ListViewItem
        Dim vDescLen As Short 'T.T 04/26/2006 description length
        Dim vDescCount As Short
        Dim vDescSpaceLocation As Short
        Dim vListSubItemDesc As String = ""
        Dim vRowCode As String = ""

        Dim vListSubItem As System.Windows.Forms.ListViewItem.ListViewSubItem

        'bret 06/13/07 8.4.3.9 moved up.
        Dim LessTime24 As Boolean
        Dim SecondTime As String = ""
        Dim Pen As Boolean

        Const LOGEVENT_CODE As Short = 8
        Const LOGEVENT_COLOR As Short = 9
        Const LOGEVENT_PENDING As Short = 10
        Const LOGEVENT_TYPE As Short = 2
        Const LOGEVENT_COLOR_BLACK As Short = 0
        Const LOGEVENT_DESCRIPTION As Short = 6
        'drh 12/16/03 - Changed to a Long
        Dim I As Integer
        Dim j As Short

        'Get the number of array rows
        vItems = UBound(pvValues, 1)

        'Get the number of array columns and reduce by 2 by assuming
        'the first column is the tag item and the second column is the
        'primary list item.

        If pvUseTag = True Then
            vSubItemCols = UBound(pvValues, 2) - 2
        Else
            vSubItemCols = UBound(pvValues, 2) - 1
        End If

        '*T.T 5/28/2004 change subItemCols to accomidate the Loease Org Type
        If pcListView.Name = "LstViewEnabledLOCalls" Or pcListView.Name = "LstViewDisabledLOCalls" Then
            vSubItemCols = UBound(pvValues, 2)
        End If

        For I = 0 To vItems
            'Add a new row
            vRowColor = 0
            'bret 01/18/2010 moved SetIcons to vRowItem Create
            'Check if icons should be set
            If Not IsNothing(pvSetIcons) Then
                If pvSetIcons = True Then
                    If IsNothing(pvSetIconsSwitch) Then
                        vRowItem = pcListView.Items.Add("", pvForm.SetIcons(pvValues, I))
                        'vRowItem.ForeColor = Color.White
                        ', pvForm.SetIcons(pvValues, I)
                    Else
                        If UBound(pvValues, 2) > 9 Then
                            'bjk 3/10/10 add if to prevent error
                            If IsNumeric(pvValues(I, 10)) Then
                                If (pvValues(I, 10) = Labs_Pending Or pvValues(I, 10) = Acknowledge_to_Evaluate) Then
                                    vRowItem = pcListView.Items.Add("", pvForm.SetIcons(pvValues, I, pvValues(I, 10)))
                                Else
                                    vRowItem = pcListView.Items.Add("", pvForm.SetIcons(pvValues, I, pvSetIconsSwitch))
                                End If
                            Else
                                vRowItem = pcListView.Items.Add("", pvForm.SetIcons(pvValues, I, pvSetIconsSwitch))
                            End If
                        Else
                            vRowItem = pcListView.Items.Add("", pvForm.SetIcons(pvValues, I, pvSetIconsSwitch))
                        End If
                    End If
                Else
                    vRowItem = pcListView.Items.Add("")
                End If
            Else
                ''If (IsNothing(pcListView.SmallImageList) And IsNothing(pcListView.LargeImageList) And Not IsNothing(pvForm.ImageList1)) Then
                ''    pcListView.SmallImageList = pvForm.ImageList1
                ''End If

                vRowItem = pcListView.Items.Add("")

            End If


            'Set the first column of the array to the List Item tag property
            If pvUseTag = True Then
                vRowItem.Tag = pvValues(I, 0)

            End If

            'FSProj drh 5/14/02 - See if we need to add a checkmark to the listview
            If Not IsNothing(pvCheckboxCol) Then
                If pvValues(I, pvCheckboxCol) = 1 Then
                    vRowItem.Checked = True
                End If
            End If

            'Check to see is the rows should be numbered
            If pvNumberRows = False Then

                If pvUseTag = True Then
                    'Set the second column as the primary list item
                    vRowItem.Text = pvValues(I, 1)
                Else
                    'Set the first column as the primary list item
                    vRowItem.Text = pvValues(I, 0)
                End If


                'Mark first column
                'Change the text color blue for LOs and black for Statline
                '7/6/01 drh Check if this is the FS Activity ListView
                If pcListView.Name = "LstViewCallouts" Then
                    vRowColor = modControl.SetCallColor(pvValues(I, 10), 194, pvForm.Name, "FrmOpenAll", pcListView.Name)
                    'ElseIf pcListView.Name = "LstViewSecondary" Or pcListView.Name = "LstViewSecondaryAlert" Then               '*T.T 05/18/2004 added for Family Services LO Keep Row color normal
                    'vRowColor = modControl.SetCallColor(pvValues(I, 10), 194, pvForm.Name, "FrmOpenAll", pcListView.Name)


                Else
                    'bjk 03/10/10 do not run for certain lstViewLogEvents

                    If (pcListView.Name <> "LstViewIncompletes" And pcListView.Name <> "LstViewLogEvent" And pcListView.Name <> "LstViewLogEventdesc" And pcListView.Name <> "LstViewPending" And Not IsNothing(pvForm)) Then
                        vRowColor = modControl.SetCallColor(pvValues(I, 9), 194, pvForm.Name, "FrmOpenAll", , pvValues(I, 1))
                    End If

                End If

                If (UBound(pvValues, 2) > 4) Then
                    If pvValues(I, 5) = "DonorNet" Then
                        vRowColor = modControl.SetCallColor(pvValues(I, 9), 194, "FrmOpenAll", , , , pvValues(I, 5))
                    End If
                End If

                '10/11/01 drh If it's a fax pending, change color to green
                If pcListView.Name = "LstViewPendingPage" Then
                    If pvValues(I, 10) = 18 Then
                        vRowColor = &H8000
                    End If
                End If

                vRowItem.ForeColor = System.Drawing.ColorTranslator.FromOle(vRowColor)

                If pvUseTag = True Then
                    'Set the remaining array columns as subitems
                    For j = 0 To vSubItemCols
                        vListSubItem = vRowItem.SubItems.Add("")

                        If (pcListView.Name = "LstViewDisabledLOCalls" Or pcListView.Name = "LstViewEnabledLOCalls") Then
                            vListSubItem.Text = pvValues(I, j)
                        Else
                            vListSubItem.Text = pvValues(I, j + 2)
                        End If


                        'T.T 06/04/2007 Get Family Services Expired Time requirement 3.5
                        If AppMain.frmOpenAll.TabCallType.SelectedTab.Text = "Family Services (F5)" And (pcListView.Name = "LstViewCallouts" Or pcListView.Name = "LstViewSecondaryAlert") Then
                            If DateAdd(Microsoft.VisualBasic.DateInterval.Minute, AppMain.ExpiredEventTime, pvValues(I, 3)) < DateAdd(Microsoft.VisualBasic.DateInterval.Minute, 0, Now) Then
                                ' ''vRowItem.SmallIcon = 5
                                pvValues(I, 5) = "EXPIRED EVENT"
                                vListSubItem.Font = VB6.FontChangeBold(vListSubItem.Font, True)
                                vRowItem.Font = VB6.FontChangeBold(vRowItem.Font, True)
                            End If
                        End If



                        If pcListView.Name = "LstViewLogEvent" Or pcListView.Name = "LstViewLogEventDesc" Then

                            If j = 0 Then
                                LessTime24 = False
                                SecondTime = pvValues(I, j + 1)
                                'BJK 8/01/06 Replace ModStatQuery.QueryLessThanADay with modstatUtil.LessThanADay
                                LessTime24 = modUtility.LessThanADay(VB6.Format(Now, "mm/dd/yy hh:mm"), SecondTime)

                            End If
                            Dim newRowColor As Double
                            If Double.TryParse(pvValues(I, LOGEVENT_COLOR), newRowColor) Then
                                vRowColor = newRowColor
                            End If

                            Select Case pvValues(I, LOGEVENT_TYPE)
                                'BJK 03/30/09 StatTrac 8.4.8 added "Labs Pending", "Acknowledge to Evaluate"
                                'ccarroll 09/21/2011 CCRST151
                                'ccarroll 07/28/2014 CCRST175 - Added Organ Med RO Pending
                                Case "Recovery Pending", "Secondary Pending", "Approach Pending", "Callout Pending", "Consent Pending", "Email Pending", "Fax Pending", "Page Pending", "Online Review Pending", "Declared CTOD Pending", "Organ Med RO Pending", "Labs Pending", "Acknowledge to Evaluate", "Pending E-Referral"
                                    'BJK 08/01/06 replace call to modStatQuery.QueryEventPending with call from existing results
                                    Pen = pvValues(I, LOGEVENT_PENDING)

                                    If Pen = False Then
                                        vRowColor = LOGEVENT_COLOR_BLACK
                                    End If
                            End Select

                            vListSubItem.ForeColor = System.Drawing.ColorTranslator.FromOle(vRowColor)
                            vRowItem.ForeColor = System.Drawing.ColorTranslator.FromOle(vRowColor)
                            If LessTime24 = True Then
                                vListSubItem.Font = VB6.FontChangeBold(vListSubItem.Font, True)
                                vRowItem.Font = VB6.FontChangeBold(vRowItem.Font, True)
                            End If
                            ''moved this if statment to within the previous if
                            If j = 5 Then ' 5 is LogEventNumber

                                If CDbl(vListSubItem.Text) < 10 Then
                                    vListSubItem.Text = " " & vListSubItem.Text
                                End If
                                If CDbl(vListSubItem.Text) < 100 Then
                                    vListSubItem.Text = " " & vListSubItem.Text
                                End If
                            End If
                        End If
                        If pcListView.Name = "LstViewLogEvent" Or pcListView.Name = "LstViewLogEventDesc" Then
                            If j = 6 Then

                                'BJK 08/01/06 replace call to modControl.SetCallCode by pulling value from existing query
                                vRowCode = pvValues(I, LOGEVENT_CODE)

                                vListSubItem.Text = vRowCode

                                'T.T This section determines if event is still pending and removes code
                                'BJK 08/01/06 replace call to modStatQuery.QueryEventPending with call from existing results
                                Pen = pvValues(I, LOGEVENT_PENDING)

                                If vRowCode = "P" Then
                                    If Pen = False Then
                                        vRowCode = ""
                                        vListSubItem.Text = vRowCode
                                    End If
                                End If

                            ElseIf j = LOGEVENT_DESCRIPTION - 2 Then
                                Dim logEventDescriptionValue As Object = pvValues(I, LOGEVENT_DESCRIPTION)
                                FormatEventDescription(vListSubItem, pcListView, logEventDescriptionValue, vRowColor, LessTime24)
                            End If

                        Else
                            'Change the text color blue for LOs and black for Statline
                            vListSubItem.ForeColor = System.Drawing.ColorTranslator.FromOle(vRowColor)
                        End If
                    Next j
                Else
                    'Set the remaining array columns as subitems
                    For j = 0 To vSubItemCols
                        vListSubItem = vRowItem.SubItems.Add("")
                        vListSubItem.Text = pvValues(I, j + 1)

                        'ccarroll 10/25/2007 - change result criteria color to blue for General items
                        If pcListView.Name = "LstViewVerify" Then
                            If vRowItem.SubItems(1).Text = "General" Then
                                vRowItem.ForeColor = System.Drawing.Color.Blue
                                vListSubItem.ForeColor = System.Drawing.Color.Blue
                            Else
                                vRowItem.ForeColor = System.Drawing.Color.Red
                                vListSubItem.ForeColor = System.Drawing.Color.Red
                            End If
                        End If


                    Next j
                End If

            ElseIf pvNumberRows = True Then
                'Set the second column as the row number
                vRowItem.Text = CStr(I + 1)

                If pvUseTag = True Then

                    'Set the remaining array columns as subitems
                    For j = 0 To vSubItemCols + 2
                        If (UBound(pvValues, 2) >= j + 1) Then
                            vListSubItem = vRowItem.SubItems.Add("")
                            vListSubItem.Text = pvValues(I, j + 1)
                        End If
                    Next j
                Else
                    'Set the remaining array columns as subitems
                    For j = 0 To vSubItemCols
                        vListSubItem = vRowItem.SubItems.Add("")
                        'T.T 04/27/2006 change subitem row color
                        vListSubItem.ForeColor = System.Drawing.ColorTranslator.FromOle(vRowColor)
                        vListSubItem.Text = pvValues(I, j + 1)

                    Next j
                End If

            End If



        Next I
        Exit Function

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        Resume Next
        Resume
    End Function

    Public Function HighlightText(ByRef pvTextbox As System.Windows.Forms.TextBox) As Object


        On Error GoTo handleError

        pvTextbox.SelectionStart = 0
        pvTextbox.SelectionLength = Len(pvTextbox.Text)

        HighlightText = True

        Exit Function

handleError:

        HighlightText = False

    End Function

    Public Function AllowDelete(ByRef pvList As System.Windows.Forms.ComboBox, ByVal pvKeyAscii As Short) As Object

        'Allow the delete key to clear the combo box
        If pvKeyAscii = 8 Then
            pvList.SelectedIndex = -1
        End If

    End Function


    Public Function ComboSearch(ByRef pcControl As ComboBox, ByRef pvKeyAscii As Short, Optional ByRef pvLock As Object = Nothing, Optional ByRef pvSearchLead As Object = Nothing) As Object

        On Error Resume Next

        Dim I As Short
        Dim vTextLength As Short
        Dim vTypedText As String = ""
        Dim vCurrentText As New Object
        Dim vCurrentKeyAcsii As New Object
        Dim vCurrentChar As New Object
        Dim itemIndex As Integer

        vCurrentChar = pvKeyAscii

        'pvLock prevents any key value other than a value resulting in
        'a list iem match from displaying. In other words, the field is
        'locked from free form entry.

        'pvSearchLead is the number of characters from the beginning of
        'the field that will be used to search for matches. Any characters
        'after this number an search will no be conducted.

        Select Case pcControl.DropDownStyle

            Case ComboBoxStyle.DropDown, ComboBoxStyle.Simple ' 0, 1


                vCurrentText = pcControl.Text
                vTextLength = pcControl.SelectionStart + 1
                vTypedText = Left(vCurrentText, vTextLength - 1)

                If Not IsNothing(pvSearchLead) Then
                    If vTextLength >= pvSearchLead Then
                        Exit Function
                    End If
                End If

                itemIndex = pcControl.FindString(vTypedText & Chr(vCurrentChar))
                If itemIndex > -1 Then

                    pcControl.SelectedIndex = itemIndex
                    pcControl.SelectionStart = vTextLength
                    pcControl.SelectionLength = 0
                    pvKeyAscii = 0

                Else
                    If IsNothing(pvLock) Then
                        If pvKeyAscii <> 8 Then
                            pcControl.Text = vTypedText
                            pcControl.SelectionStart = vTextLength
                        End If
                    ElseIf pvLock = False Then
                        If pvKeyAscii <> 8 Then
                            pcControl.Text = vTypedText
                            pcControl.SelectionStart = vTextLength
                        End If
                    Else
                        pvKeyAscii = 0
                    End If

                End If

            Case ComboBoxStyle.DropDownList '2
                vCurrentText = pcControl.Text
                vTextLength = pcControl.SelectionStart + 1
                vTypedText = Left(vCurrentText, vTextLength - 1)

                itemIndex = pcControl.FindString(vTypedText & Chr(vCurrentChar))
                If itemIndex > 0 Then
                    pcControl.SelectedIndex = itemIndex
                    pcControl.SelectionStart = vTextLength
                    pcControl.SelectionLength = 1
                    pvKeyAscii = 0
                Else

                    pcControl.SelectionStart = vTextLength
                End If

        End Select

    End Function

    Public Function HighlightListViewRowNew(ByRef pvListView As ListView) As Object

        For I As Short = 0 To pvListView.Items.Count - 1
            pvListView.Items(I).BackColor = SystemColors.Window
        Next

        If pvListView.Focused = True Then
            pvListView.FocusedItem.BackColor = Color.LightGray
        Else
            pvListView.Items(0).BackColor = Color.LightGray
        End If

    End Function

    Public Function HighlightListViewRow(ByRef pvListView As Object) As Object

        'This was causing the listview to only let you click the first column jth 3/10
        'Dim vStyle As Integer

        'vStyle = SendMessage(pvListView.Handle.ToInt32, LVM_GETEXTENDEDLISTVIEWSTYLE, 0, 0)
        'vStyle = vStyle Or LVS_EX_FULLROWSELECT
        'vStyle = SendMessage(pvListView.Handle.ToInt32, LVM_SETEXTENDEDLISTVIEWSTYLE, 0, vStyle)

    End Function

    Public Function SwitchListView(ByRef pvList As Object, ByRef pvCurrentList As System.Windows.Forms.ListView, ByRef pvSwitchedList As System.Windows.Forms.ListView) As Object
        Dim I As Short
        Dim j As Short
        Dim vCurrentIndex As Short
        Dim vSwitchedIndex As Short
        Dim test As String

        'Make sure we had an item selected
        If pvList.GetType().Name.Equals("Object") Then
            Call MsgBox("Please select an Available DSN before clicking the 'Add' button.")
        Else

            For I = 0 To UBound(pvList)
                If pvCurrentList.Name = "LstViewDisabledLOCalls" Or pvCurrentList.Name = "LstViewEnabledLOCalls" Then
                    vCurrentIndex = pvCurrentList.FindItemWithText(pvList(I, 3), True, 0, False).Index 'T.T 6/2/2004 changed from lvwTag, and pvList(I, 0)
                Else
                    'vCurrentIndex = pvCurrentList.FindItemWithText(pvList(I, 0), True, 1, False).Index
                    test = pvList(I, 0)
                    vCurrentIndex = pvCurrentList.FindItemWithText(pvList(I, 0)).Index

                End If


                'Set the new index for the switchedlist and add an item
                vSwitchedIndex = pvSwitchedList.Items.Count ' + 1  don't add one jth 4/10
                pvSwitchedList.Items.Add("")

                If pvCurrentList.Name = "LstViewDisabledLOCalls" Or pvCurrentList.Name = "LstViewEnabledLOCalls" Then
                    For j = 0 To 5 'T.T 5/28/2004 added to move subitems over as well as tag and text
                        pvSwitchedList.Items.Item(vSwitchedIndex).SubItems.Add("")
                    Next j
                End If
                'Set the values in Switchedlist = to the current list and remove the item form the current list
                pvSwitchedList.Items.Item(vSwitchedIndex).Text = pvCurrentList.Items.Item(vCurrentIndex).Text
                pvSwitchedList.Items.Item(vSwitchedIndex).Tag = pvCurrentList.Items.Item(vCurrentIndex).Tag
                pvSwitchedList.Items.Item(vSwitchedIndex).Text = pvCurrentList.Items.Item(vCurrentIndex).Text

                If pvCurrentList.Name = "LstViewDisabledLOCalls" Or pvCurrentList.Name = "LstViewEnabledLOCalls" Then
                    pvSwitchedList.Items.Item(vSwitchedIndex).SubItems.Item(4).Text = pvCurrentList.Items.Item(vCurrentIndex).SubItems.Item(4).Text
                    pvSwitchedList.Items.Item(vSwitchedIndex).SubItems.Item(5).Text = pvCurrentList.Items.Item(vCurrentIndex).SubItems.Item(5).Text
                End If
                pvCurrentList.Items.RemoveAt((vCurrentIndex))

            Next I

        End If
    End Function

    Public Function CheckCallOpen(ByRef pvForm As Object) As Object
        'Name: CheckCallOpen
        'Date Created: 10/18/2006                          Created by: ccarroll
        'Release: 8.0 Iteration 2                          Task:
        'Description: This function is used to check if two users are in a case
        'at the same time and then returns an int giving instructions on how to proceed.
        'Returns: Integer
        'Integer Return Options:
        ' 2 Yes - Save and Exit
        ' 1 No - Don't Save and Exit
        ' 0 Cancel - Don't Save, Don't Exit
        'Note: 2 is the defaut value
        'Params: pvForm
        '====================================================================================
        Dim vCallOpenByID As New Object
        Dim vStatEmployeeID As New Object
        Dim vResponse As New Object
        Dim vCallID As New Object
        Dim vReturn As New Object
        Dim vReturn2 As New Object

        CheckCallOpen = 2 'Save and Exit (default)
        vCallID = pvForm.CallId
        vStatEmployeeID = pvForm.CallOpenByID

        If pvForm.Name <> "FrmNew" And pvForm.FormState <> NEW_RECORD Then
            If modStatRefQuery.RefQueryCall(vReturn, vCallID) = SUCCESS Then
                vCallOpenByID = modConv.TextToInt(vReturn(0, 5))
                If vCallOpenByID > 0 And vCallOpenByID <> vStatEmployeeID Then

                    If modStatRefQuery.RefQueryStatEmployee(vReturn2, modConv.TextToInt(vCallOpenByID)) = SUCCESS Then
                        vResponse = MsgBox("WARNING!" & Chr(10) & Chr(10) & vReturn2(0, 1) & " currently has this call open. To ensure no data is lost, please keep a record of the changes you" & Chr(10) & "made. " & vReturn2(0, 1) & " must first cancel out of the call before you can save your data." & Chr(10) & Chr(10) & "Are you sure you still want to save the call?", MsgBoxStyle.Exclamation + MsgBoxStyle.YesNoCancel, "Saving Call May Result in Lost Data")

                        'Log the 2 people in a case
                        Err.Source = "StatTrac"
                        Err.Description = "LOCKED CASE - 2 USERS: User2(enter while open): " & modConv.IntToText(vCallOpenByID) & " User1(save while open): " & modConv.IntToText(vStatEmployeeID)
                        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())

                        Select Case vResponse
                            Case MsgBoxResult.Yes 'Save case and exit.
                                CheckCallOpen = 2
                            Case MsgBoxResult.No 'Exit case without saving.
                                CheckCallOpen = 1
                            Case Else 'do nothing
                                CheckCallOpen = 0
                        End Select
                    End If
                Else
                    If vCallOpenByID = -1 Then
                        vResponse = MsgBox("WARNING!" & Chr(10) & Chr(10) & "Someone has entered this call while you made changes and saved out of the call. Their changes may be lost" & Chr(10) & "when you save. Are you sure you want to to still save the call?", MsgBoxStyle.Exclamation + MsgBoxStyle.YesNoCancel, "Saving Call May Result in Lost Data")

                        'Log the 2 people in a case
                        Err.Description = "LOCKED CASE - UNLOCKED CASE ON SAVE: User saved after closed by someone else: " & modConv.IntToText(vStatEmployeeID)
                        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())

                        Select Case vResponse
                            Case MsgBoxResult.Yes 'Save case and exit.
                                CheckCallOpen = 2
                            Case MsgBoxResult.No 'Exit case without saving.
                                CheckCallOpen = 1
                            Case Else 'do nothing
                                CheckCallOpen = 0
                        End Select
                    End If

                End If


            End If
        End If

    End Function
    '	'7/6/01 drh Added optional pcListView (Control) argument
    Public Function SetCallColor(ByRef pvArrayValue As Object, ByRef pvMaster As Object, Optional ByRef pvFormName As Object = Nothing, Optional ByRef pvFormNameMaster As Object = Nothing, Optional ByRef pcListViewName As Object = Nothing, Optional ByRef pvArrayValueOnlineHospital As Object = Nothing, Optional ByRef pvArrayValueDonorNet As Object = Nothing) As Double
        '4/11/02 BJK added optional to pvFormName and pvFormNameMaster to allow the default color to be set
        '************************************************************************************
        'Name: SetCallColor
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: sets the call color for referrals
        'Returns: Integer
        'Params: pvArrayValue
        'Stored Procedures:
        '====================================================================================
        'Date Changed: 04/20/2006                         Changed by: Thien Ta
        'Release #: 8.0                               Task:
        'Description:  Changed call color so that it is read from the database.
        '************************************************************************************


        Dim vQuery As New Object
        Dim vResult As New Object
        Dim vRS As New Object
        SetCallColor = 0

        If Not IsNothing(pvArrayValueDonorNet) Then
            If pvArrayValueDonorNet = "DonorNet" Then
                SetCallColor = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.Red)
                Exit Function
            End If
        End If
        '7/6/01 drh Change text color for different Event types in FS Activity ListView,
        'or Lease Org if Not FS Activity
        Dim Pen As New Object
        If Not IsNothing(pcListViewName) Then
            If pcListViewName = "LstViewCallouts" Then
                Select Case Val(pvArrayValue)
                    Case 4
                        SetCallColor = &H80FF 'Consent Pending (Orange)
                    Case 5
                        SetCallColor = &H8000 'Recovery Pending (Green)
                    Case 6, 43 'Page Pending, Online Review Pending
                        SetCallColor = &HC0 'Page Pending (Red)
                    Case 14
                        SetCallColor = &HC00000 'Callout Pending (Blue)
                End Select

                'T.T 04/20/2006 added for new events color scheme
            ElseIf pcListViewName = "LstViewLogEvent" Then
                vQuery = "select LogEventTypeID,LogEventTypeName,EventColor from logeventtype where LogEventTypeName = " & "'" & pvArrayValue & "'"
                Call modODBC.Exec(vQuery, vResult, , True, vRS)
                Dim newCallColor As Double
                If Double.TryParse(vRS("EventColor").Value, newCallColor) Then
                    SetCallColor = newCallColor
                End If

            End If


        Else
            '7/6/01 drh Change text color for Lease Org; This statement already existed per Bret
            SetCallColor = IIf(Val(pvArrayValue) <> pvMaster And pvFormName = pvFormNameMaster, System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.Blue), System.Drawing.ColorTranslator.ToOle(System.Drawing.SystemColors.WindowText))

        End If

        If Not IsNothing(pvArrayValueDonorNet) Then
            If pvArrayValueDonorNet = "DonorNet" Then
                SetCallColor = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.Red)
            End If
        End If


        'T.T 03/28/2005 added to change online hospital
        ' Added IsMissing check for final passed parm - was causing all FS entries in
        ' LstViewCallouts to turn black, due to error.  4/27/08 - SAP
        If Not (IsNothing(pvArrayValueOnlineHospital)) Then
            If Right(pvArrayValueOnlineHospital, 3) = "-88" Then
                SetCallColor = &H80FF ' Online Hospital
            End If
        End If

    End Function

    Public Function LeaseOrgListView(ByRef pvCurrentList As Object, ByRef pvSwitchedList As System.Windows.Forms.ListView) As Object

        '***********************************************************************
        'T.T 06/01/2004
        'Module:modControl.LeaseOrgListView
        'Parameters:    pvCurrentList - current form listview
        '               pvSwitchedList - future form listview
        '
        'Definition:    This Function determines whether the organization is a
        '               Family services or a Triage Organization and adds it to
        '               the appropriate view.
        '***********************************************************************



        Dim I As Short
        Dim j As Short
        Dim k As Short
        Dim vCurrentIndex As Short
        Dim vSwitchedIndex As Short
        Dim vRowItem As System.Windows.Forms.ListViewItem
        Dim vListSubItem As System.Windows.Forms.ListViewItem.ListViewSubItem
        Dim vItemsCount As Short
        Dim vQuery As New Object
        Dim vResult As New Object
        Dim vReturn As New Object
        Dim vTriage As Boolean
        Dim vFS As Boolean


        vItemsCount = pvCurrentList.Items.Count - 1


        For I = 0 To vItemsCount
            'T.T 06/22/2004 Determine what kind of lease ORG it is.
            vQuery = "Exec sps_LeaseOrganizationTypev " & pvCurrentList.Items.Item(0).Tag
            vReturn = modODBC.Exec(vQuery, vResult)
            vTriage = False
            vFS = False

            For k = 0 To UBound(vResult, 1) 'Determine what kind of Lease Organization
                If vResult(k, 0) = "Triage" Then
                    vTriage = True
                End If
                If vResult(k, 0) = "FamilyServices" Then
                    vFS = True
                End If
            Next k

            'T.T 06/22/2004 Triage Enabled
            If vTriage = True Then
                If modConv.TextToInt(pvCurrentList.Items.Item(0).SubItems.Item(6).Text) = -1 Then

                    vRowItem = pvCurrentList.Items.Add("")
                    vListSubItem = vRowItem.SubItems.Add("")
                    For j = 0 To 5
                        vRowItem.SubItems.Add("")
                    Next j

                    vRowItem.Text = "TR-" & pvCurrentList.Items.Item(0).Text
                    vRowItem.Tag = pvCurrentList.Items.Item(0).Tag
                    vRowItem.SubItems.Item(4).Text = pvCurrentList.Items.Item(0).SubItems.Item(4).Text
                    vRowItem.SubItems.Item(5).Text = pvCurrentList.Items.Item(0).SubItems.Item(5).Text
                End If
                'T.T 06/22/2004 Triage Disabled
                If modConv.TextToInt(pvCurrentList.Items.Item(0).SubItems.Item(6).Text) = 0 Then

                    vRowItem = pvSwitchedList.Items.Add("")
                    vListSubItem = vRowItem.SubItems.Add("")
                    For j = 0 To 5
                        vRowItem.SubItems.Add("")
                    Next j

                    vRowItem.Text = "TR-" & pvCurrentList.Items.Item(0).Text
                    vRowItem.Tag = pvCurrentList.Items.Item(0).Tag
                    vRowItem.SubItems.Item(4).Text = pvCurrentList.Items.Item(0).SubItems.Item(4).Text
                    vRowItem.SubItems.Item(5).Text = pvCurrentList.Items.Item(0).SubItems.Item(5).Text
                End If
            End If
            If vFS = True Then
                'T.T 06/22/2004FS enabled
                If modConv.TextToInt(pvCurrentList.Items.Item(0).SubItems.Item(7).Text) = -1 Then
                    vRowItem = pvCurrentList.Items.Add("")
                    vListSubItem = vRowItem.SubItems.Add("")
                    For j = 0 To 5
                        vRowItem.SubItems.Add("")
                    Next j
                    vRowItem.Text = "FS-" & pvCurrentList.Items.Item(0).Text
                    vRowItem.Tag = pvCurrentList.Items.Item(0).Tag
                    vRowItem.SubItems.Item(4).Text = pvCurrentList.Items.Item(0).SubItems.Item(4).Text
                    vRowItem.SubItems.Item(5).Text = pvCurrentList.Items.Item(0).SubItems.Item(5).Text
                End If

                'T.T 06/22/2004 FSDisabled
                If modConv.TextToInt(pvCurrentList.Items.Item(0).SubItems.Item(7).Text) = 0 Then
                    vRowItem = pvSwitchedList.Items.Add("")
                    vListSubItem = vRowItem.SubItems.Add("")
                    For j = 0 To 5
                        vRowItem.SubItems.Add("")
                    Next j
                    vRowItem.Text = "FS-" & pvCurrentList.Items.Item(0).Text
                    vRowItem.Tag = pvCurrentList.Items.Item(0).Tag
                    vRowItem.SubItems.Item(4).Text = pvCurrentList.Items.Item(0).SubItems.Item(4).Text
                    vRowItem.SubItems.Item(5).Text = pvCurrentList.Items.Item(0).SubItems.Item(5).Text
                End If
            End If

            pvCurrentList.Items.RemoveAt((0))
        Next I

    End Function
    Public Function AdjustListView(ByRef pvCurrentList As Object, ByRef pvSwitchedList As System.Windows.Forms.ListView) As Object
        Dim I As Short
        Dim j As Short
        Dim vCurrentIndex As Short
        Dim vSwitchedIndex As Short

        '***********************************************************************
        'T.T 06/01/2004
        'Module:modControl.AdjustListView
        'Parameters:    pvCurrentList - current form listview
        '               pvSwitchedList - future form listview
        '
        'Definition:    This Function determines whether the organization is a
        '               Family services or a Triage Organization and sets the
        '               subitems to 0 or -1 depending whether the Lease Org is on or off
        '***********************************************************************

        For I = 0 To pvCurrentList.Items.Count - 1
            If Left(pvCurrentList.Items.Item(I).Text, 2) = "FS" Then
                pvCurrentList.Items.Item(I).SubItems.Item(5).Text = 0
                pvCurrentList.Items.Item(I).SubItems.Item(4).Text = 0
            End If
            If Left(pvCurrentList.Items.Item(I).Text, 2) = "TR" Then
                pvCurrentList.Items.Item(I).SubItems.Item(4).Text = 0
                pvCurrentList.Items.Item(I).SubItems.Item(5).Text = 0
            End If
        Next I

        For I = 0 To pvSwitchedList.Items.Count - 1
            If Left(pvSwitchedList.Items.Item(I).Text, 2) = "FS" Then
                pvSwitchedList.Items.Item(I).SubItems.Item(5).Text = -1
                pvSwitchedList.Items.Item(I).SubItems.Item(4).Text = 0
            End If
            If Left(pvSwitchedList.Items.Item(I).Text, 2) = "TR" Then
                pvSwitchedList.Items.Item(I).SubItems.Item(4).Text = -1
                pvSwitchedList.Items.Item(I).SubItems.Item(5).Text = 0
            End If

        Next I

    End Function

    Public Function cbofill(ByRef pvControl As System.Windows.Forms.Control, ByRef vFound As String, ByRef setchoice As Boolean, Optional ByRef NewReferral As Boolean = False) As String
        '***********************************************************************
        'T.T 09/01/2004
        'Module:modControl.cbofill
        'Parameters:    PvControl - control Name
        '               vFound    - used to determine wether patient found on reg
        '                            or found on state
        '
        'Definition:    This Function fills a combo box
        '***********************************************************************

        Dim vQuery As String = ""
        Dim vResult As New Object
        Dim vRS As New Object
        Dim vRS2 As New Object
        Dim vIndex As Short
        Dim formTemp As FrmReferral

        If pvControl.Parent.FindForm.Name = "FrmReferral" Then
            formTemp = DirectCast(pvControl.Parent.FindForm, FrmReferral)
            formTemp.cboRegistryStatus.Items.Clear()
        End If

        'formTemp.cmdDonorIntent.Visible = True

        vQuery = "EXEC SelectRegistryStatusType;"
        Try
            Call modODBC.Exec(vQuery, vResult, , True, vRS)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        'Look to see if required resources are available
        Dim isEofAvailable As Boolean = vRS IsNot Nothing AndAlso vRS.GetType().GetProperty("EOF") IsNot Nothing
        Dim isRegistryTypeAvailable As Boolean
        If vRS IsNot Nothing AndAlso vRS.GetType().Name.Equals("RecordsetClass") Then
            Dim i As Integer
            For i = 0 To vRS.Fields.Count - 1
                If vRS.Fields.Item(i).Name.Equals("RegistryType") Then
                    isRegistryTypeAvailable = True
                    Exit For
                End If
            Next
        End If
        Dim areItemsAvailable As Boolean = formTemp IsNot Nothing _
            AndAlso formTemp.GetType().GetProperty("cboRegistryStatus") IsNot Nothing _
            AndAlso formTemp.cboRegistryStatus.GetType().GetProperty("Items") IsNot Nothing _
            AndAlso formTemp.cboRegistryStatus.Items.GetType().GetProperty("Count") IsNot Nothing
        Dim isRegStatusAvailable As Boolean = formTemp.GetType().GetProperty("cboRegistryStatus") IsNot Nothing _
            AndAlso formTemp.cboRegistryStatus.GetType().GetProperty("SelectedIndex") IsNot Nothing

        'Make sure required resources are available before proceeding
        If Not isEofAvailable Or Not isRegistryTypeAvailable Or Not areItemsAvailable Or Not isRegStatusAvailable Then

            'Log the error
            Try
                Dim strMessage As String = "one or more required resources is not available - " +
                    "IsEofAvailable: " + isEofAvailable.ToString() + ", " +
                    "IsRegistryTypeAvailable: " + isRegistryTypeAvailable.ToString() + ", " +
                    "AreItemsAvailable: " + areItemsAvailable.ToString() + ", " +
                    "IsRegStatusAvailable: " + isRegStatusAvailable.ToString() + ", " +
                    "ReferralID: " + formTemp.ReferralId.ToString() + ", " +
                    "CallID: " + formTemp.CallId.ToString()

                Dim ex As New Exception("Resource Access Error In Control.vb.cboFill: " & strMessage)
                StatTracLogger.CreateInstance().Write(ex)

            Catch caughtEx As Exception
                'Swallow error
            End Try

            Exit Function
        End If


        'This is for sourcecodes that don't have a registry search ***Not Checked****
        '******************************************************************************
        formTemp.cmdDonorIntent.Visible = True
        'TODO: After the above statement the below block will never execute,
        'what's the point? Should it be removed?
        If formTemp.cmdDonorIntent.Visible = False Then

            Do While vRS.EOF = False
                If vRS("RegistryType").Value <> "WebRegistry" And vRS("RegistryType").Value <> "StateRegistry" And vRS("RegistryType").Value <> "DLA Registry" Then
                    formTemp.cboRegistryStatus.Items.Add(vRS("RegistryType").Value)

                    If vRS("RegistryType").Value = vFound Then
                        vIndex = formTemp.cboRegistryStatus.Items.Count - 1
                    Else
                        '    vIndex = 2
                    End If



                End If
                vRS.MoveNext()
            Loop

            'formTemp.cboRegistryStatus.ListIndex = 2
            formTemp.cboRegistryStatus.SelectedIndex = vIndex
            'ccarroll 09/28/2007



            Exit Function

        End If


        'This is a new referral
        '********************************************************************************************
        'This is when the referral is new and it is found in State
        If formTemp.FormState = NEW_RECORD Or formTemp.RegMatchClicked = True Then
            If vFound = "State" Then
                Do While vRS.EOF = False
                    If vRS("RegistryType").Value <> "WebRegistry" And vRS("RegistryType").Value <> "DLA Registry" Then
                        If vRS("RegistryType").Value <> "Not Checked" Then
                            formTemp.cboRegistryStatus.Items.Add(vRS("RegistryType").Value)
                        End If
                    End If
                    vRS.MoveNext()
                Loop
                formTemp.cboRegistryStatus.SelectedIndex = 0
                cbofill = ""
                If setchoice = True Then
                    cbofill = "StateChoice"
                End If
            End If

            'This is a new referral where the patient is found on the Web Registry
            If vFound = "Web" Then
                Do While vRS.EOF = False
                    If vRS("RegistryType").Value <> "StateRegistry" And vRS("RegistryType").Value <> "DLA Registry" Then
                        If vRS("RegistryType").Value <> "Not Checked" Then
                            formTemp.cboRegistryStatus.Items.Add(vRS("RegistryType").Value)
                        End If
                    End If
                    vRS.MoveNext()
                Loop
                formTemp.cboRegistryStatus.SelectedIndex = 0
                cbofill = ""
                If setchoice = True Then
                    cbofill = "WebChoice"
                End If
            End If

            'This is a new referral where the patient is found on the DLA Registry
            If vFound = "DLA" Then
                Do While vRS.EOF = False
                    If vRS("RegistryType").Value <> "StateRegistry" And vRS("RegistryType").Value <> "WebRegistry" Then
                        If vRS("RegistryType").Value <> "Not Checked" Then
                            formTemp.cboRegistryStatus.Items.Add(vRS("RegistryType").Value)
                        End If
                    End If
                    vRS.MoveNext()
                Loop
                formTemp.cboRegistryStatus.SelectedIndex = 2
                cbofill = ""
                If setchoice = True Then
                    cbofill = "DLAChoice"
                End If
            End If

            'This is a new referral where the patient is not found
            If vFound = "" Then

                Do While vRS.EOF = False
                    If vRS("RegistryType").Value <> "WebRegistry" And vRS("RegistryType").Value <> "StateRegistry" And vRS("RegistryType").Value <> "DLA Registry" Then
                        formTemp.cboRegistryStatus.Items.Add(vRS("RegistryType").Value)
                    End If
                    vRS.MoveNext()
                Loop
                If formTemp.CallerOrg.ServiceLevel.RegCheckRegistry Then
                    formTemp.cboRegistryStatus.SelectedIndex = 0
                Else
                    formTemp.cboRegistryStatus.SelectedIndex = 2
                End If

                cbofill = ""

            End If

            'This is a new referral where the patient is not checked
            If vFound = "Not Checked" Then

                Do While vRS.EOF = False
                    If vRS("RegistryType").Value <> "WebRegistry" And vRS("RegistryType").Value <> "StateRegistry" And vRS("RegistryType").Value <> "DLA Registry" Then
                        formTemp.cboRegistryStatus.Items.Add(vRS("RegistryType").Value)
                    End If
                    vRS.MoveNext()
                Loop
                If formTemp.CallerOrg.ServiceLevel.RegCheckRegistry Then
                    formTemp.cboRegistryStatus.SelectedIndex = 2
                Else
                    formTemp.cboRegistryStatus.SelectedIndex = 2
                End If

                cbofill = ""
            End If


            'This is when the patient is not Registered
            If vFound = "NotRegistered" Then

                Do While vRS.EOF = False
                    If vRS("RegistryType").Value <> "WebRegistry" And vRS("RegistryType").Value <> "StateRegistry" And vRS("RegistryType").Value <> "DLA Registry" Then
                        formTemp.cboRegistryStatus.Items.Add(vRS("RegistryType").Value)
                    End If
                    vRS.MoveNext()
                Loop

                formTemp.cboRegistryStatus.SelectedIndex = 0

                cbofill = ""
            End If

        End If 'New Record
        '********************************************************************************************

        'This is for old referrals
        '********************************************************************************************
        If formTemp.FormState <> NEW_RECORD Then
            'T.T 09/15/2004 This is when the referral is an old Referral and needs to be reloaded
            If NewReferral = False Then

                If vFound <> "" Then
                    formTemp.cboRegistryStatus.Items.Add(vFound)

                End If

                Do While vRS.EOF = False
                    If vRS("RegistryType").Value <> "WebRegistry" And vRS("RegistryType").Value <> "StateRegistry" And vRS("RegistryType").Value <> "DLA Registry" Then
                        If vRS("RegistryType").Value <> vFound Then
                            formTemp.cboRegistryStatus.Items.Add(vRS("RegistryType").Value)

                        End If
                    End If
                    vRS.MoveNext()
                Loop

                If vFound = "" Then
                    formTemp.cboRegistryStatus.SelectedIndex = 2
                Else
                    formTemp.cboRegistryStatus.SelectedIndex = 0
                End If




                Exit Function
            End If

            'This is when the patient is not found
            If vFound = "NotRegistered" Then

                Do While vRS.EOF = False
                    If vRS("RegistryType").Value <> "WebRegistry" And vRS("RegistryType").Value <> "StateRegistry" And vRS("RegistryType").Value <> "DLA Registry" Then
                        formTemp.cboRegistryStatus.Items.Add(vRS("RegistryType").Value)
                    End If
                    vRS.MoveNext()
                Loop

                formTemp.cboRegistryStatus.SelectedIndex = 0

                cbofill = ""


            End If

            If vFound = "State" Then
                Do While vRS.EOF = False
                    If vRS("RegistryType").Value <> "WebRegistry" And vRS("RegistryType").Value <> "DLA Registry" Then
                        If vRS("RegistryType").Value <> "Not Checked" Then
                            formTemp.cboRegistryStatus.Items.Add(vRS("RegistryType").Value)
                        End If
                    End If
                    vRS.MoveNext()
                Loop
                formTemp.cboRegistryStatus.SelectedIndex = 0
                cbofill = ""
                If setchoice = True Then
                    cbofill = "StateChoice"
                End If
            End If

            'This is a new referral where the patient is found on the Web Registry
            If vFound = "Web" Then
                Do While vRS.EOF = False
                    If vRS("RegistryType").Value <> "StateRegistry" And vRS("RegistryType").Value <> "DLA Registry" Then
                        If vRS("RegistryType").Value <> "Not Checked" Then
                            formTemp.cboRegistryStatus.Items.Add(vRS("RegistryType").Value)
                        End If
                    End If
                    vRS.MoveNext()
                Loop
                formTemp.cboRegistryStatus.SelectedIndex = 0
                cbofill = ""
                If setchoice = True Then
                    cbofill = "WebChoice"
                End If
            End If

            'This is a new referral where the patient is found on the DLA Registry
            If vFound = "DLA" Then
                Do While vRS.EOF = False
                    If vRS("RegistryType").Value <> "WebRegistry" And vRS("RegistryType").Value <> "StateRegistry" Then
                        If vRS("RegistryType").Value <> "Not Checked" Then
                            formTemp.cboRegistryStatus.Items.Add(vRS("RegistryType").Value)
                        End If
                    End If
                    vRS.MoveNext()
                Loop
                formTemp.cboRegistryStatus.SelectedIndex = 2
                cbofill = ""
                If setchoice = True Then
                    cbofill = "DLAChoice"
                End If
            End If

            If vFound = "Not Checked" Then

                Do While vRS.EOF = False
                    If vRS("RegistryType").Value <> "WebRegistry" And vRS("RegistryType").Value <> "StateRegistry" And vRS("RegistryType").Value <> "DLA Registry" Then
                        formTemp.cboRegistryStatus.Items.Add(vRS("RegistryType").Value)
                    End If
                    vRS.MoveNext()
                Loop

                formTemp.cboRegistryStatus.SelectedIndex = 2
            End If

            If vFound = "" Then

                Do While vRS.EOF = False
                    If vRS("RegistryType").Value <> "WebRegistry" And vRS("RegistryType").Value <> "StateRegistry" And vRS("RegistryType").Value <> "DLA Registry" Then
                        formTemp.cboRegistryStatus.Items.Add(vRS("RegistryType").Value)
                    End If
                    vRS.MoveNext()
                Loop


                formTemp.cboRegistryStatus.SelectedIndex = 0
            End If
        End If '********************************************************************************************

    End Function
    Public Function cbofillFS(ByRef pvControl As ComboBox, ByRef vFound As String, ByRef setchoice As Boolean, Optional ByRef NewReferral As Boolean = False) As String
        '***********************************************************************
        'T.T 09/01/2004
        'Module:modControl.cbofill
        'Parameters:    PvControl - control Name
        '               vFound    - used to determine wether patient found on reg
        '                            or found on state
        '
        'Definition:    This Function fills a combo box
        '***********************************************************************

        Dim vQuery As String = ""
        Dim vReturn As String = ""
        Dim vResult As New Object
        Dim vRS As New Object
        Dim vRS2 As Object


        pvControl.Items.Clear()
        vQuery = "EXEC SelectRegistryStatusType;"
        Call modODBC.Exec(vQuery, vResult, , True, vRS)


        'This is a new referral where the patient is found on the State Registry
        If vFound = "State" Then

            Do While vRS.EOF = False
                If vRS("RegistryType").Value <> "WebRegistry" Then
                    If vRS("RegistryType").Value <> "Not Checked" Then
                        pvControl.Items.Add(vRS("RegistryType").Value)
                    End If
                End If
                vRS.MoveNext()
            Loop

            pvControl.SelectedIndex = 0
            cbofillFS = ""

            If setchoice = True Then
                cbofillFS = "StateChoice"
            End If
        End If

        'This is a new referral where the patient is found on the Web Registry
        If vFound = "Web" Then
            Do While vRS.EOF = False
                If vRS("RegistryType").Value <> "StateRegistry" Then
                    If vRS("RegistryType").Value <> "Not Checked" Then
                        pvControl.Items.Add(vRS("RegistryType").Value)
                    End If
                End If
                vRS.MoveNext()
            Loop

            pvControl.SelectedIndex = 0
            cbofillFS = ""

            If setchoice = True Then
                cbofillFS = "WebChoice"
            End If
        End If

        'This is a new referral where the patient is not found
        If vFound = "" Then

            Do While vRS.EOF = False
                If vRS("RegistryType").Value <> "WebRegistry" And vRS("RegistryType").Value <> "StateRegistry" Then
                    pvControl.Items.Add(vRS("RegistryType").Value)
                End If
                vRS.MoveNext()
            Loop

            pvControl.SelectedIndex = 0
            cbofillFS = ""

        End If

        'T.T 09/15/2004 This is when the referral is an old Referral and needs to be reloaded
        If NewReferral = False Then
            pvControl.Items.Clear()
            If vFound <> "" Then
                pvControl.Items.Add(vFound)
                'formTemp.CmdRegMatchFS.Visible = True
            End If

            Do While vRS.EOF = False
                If vRS("RegistryType").Value <> "WebRegistry" And vRS("RegistryType").Value <> "StateRegistry" Then
                    If vRS("RegistryType").Value <> vFound Then
                        pvControl.Items.Add(vRS("RegistryType").Value)
                    End If
                End If
                vRS.MoveNext()
            Loop
            If vFound = "" Then
                pvControl.SelectedIndex = 2
            Else
                pvControl.SelectedIndex = 0
            End If
            Exit Function
        End If

        'This is when the patient is not found
        If vFound = "NotRegistered" Then

            Do While vRS.EOF = False
                If vRS("RegistryType").Value <> "WebRegistry" And vRS("RegistryType").Value <> "StateRegistry" Then
                    pvControl.Items.Add(vRS("RegistryType").Value)
                End If
                vRS.MoveNext()
            Loop

            pvControl.SelectedIndex = 0

            cbofillFS = ""
        End If

    End Function
    Public Sub SetRTFText(ByRef rtfTextBox As RichTextBox, ByVal rtfText As String)
        If rtfText.Contains("rtf") Then

            rtfTextBox.Rtf = rtfText
        Else
            rtfTextBox.Text = rtfText
        End If

    End Sub
    Public Function GetHasTableKey(ByVal searchHastTable As Hashtable, ByVal eventSender As Object) As Short
        Dim Index As Short

        Dim item As DictionaryEntry
        For Each item In searchHastTable
            If item.Value.Equals(eventSender) Then
                Index = item.Key
                Exit For
            End If
        Next
        Return Index


    End Function
    Private Sub FormatEventDescription(
        ByRef listSubItem As ListViewItem.ListViewSubItem,
        ByRef listView As Object,
        ByRef logEventDescriptionValue As Object,
        ByRef rowColor As Double,
        ByRef lessTime24 As Boolean)

        Const MinRowLengthInitial = 37
        Const MinRowLength = 42

        Dim spaceSearchStart As Short = MinRowLengthInitial

        If Len(listSubItem.Text) >= spaceSearchStart Then

            'TODO: These two variables seem to represent identical values. 
            'They are confusingly mixed in the code below. It would
            'likely be sufficient to leave only one of them (as well as corresponding parameter), 
            'and that would make the code much easier to understand. But I'm afraid of breaking some
            'logic which I might be overlooking.
            Dim listSubItemDesc As String = listSubItem.Text.Replace(Environment.NewLine, " ")
            logEventDescriptionValue = logEventDescriptionValue.Replace(Environment.NewLine, " ")

            Dim prevSpaceLocation As Short = 1
            Dim rowItem As ListViewItem
            Dim spaceLocation As Short

            'What we do here is breaking description text into separate rows
            'of some minimal length. Breaking is done on spaces.
            Do Until prevSpaceLocation >= Len(listSubItemDesc)

                'Find next space occurrence. 
                'Note that search starts not from previously found space location,
                'but from MinRowLength after that location. In other words,
                'we ensure the description row has some minimum length and then break the line
                'on first space.
                spaceLocation = InStr(Start:=spaceSearchStart - 1, String1:=listSubItemDesc, String2:=" ", Compare:=CompareMethod.Text)
                If spaceLocation = 0 Then
                    spaceLocation = Len(listSubItemDesc)
                End If

                ' Take text from previous till current space.
                listSubItem.Text = Mid(logEventDescriptionValue, Start:=prevSpaceLocation, Length:=spaceLocation - prevSpaceLocation)
                If spaceLocation = Len(listSubItemDesc) Then
                    listSubItem.Text = Mid(logEventDescriptionValue, Start:=prevSpaceLocation, Length:=spaceLocation - (prevSpaceLocation - 1))
                End If

                FormatDescriptionSubItem(listSubItem, rowColor, lessTime24)

                'Add next row.
                rowItem = listView.Items.Add("")

                'Add sub-items for all columns.
                listSubItem = rowItem.SubItems.Add("")
                listSubItem = rowItem.SubItems.Add("")
                listSubItem = rowItem.SubItems.Add("")
                listSubItem = rowItem.SubItems.Add("")
                listSubItem = rowItem.SubItems.Add("") 'This one is for description.

                'Shift next space search start. 
                'Search for next space at least MinRowLength 
                'chars after current space location.
                spaceSearchStart = spaceLocation + MinRowLength
                prevSpaceLocation = spaceLocation

                If spaceSearchStart >= Len(listSubItemDesc) Then
                    prevSpaceLocation = Len(listSubItemDesc) '05/31/06 ccarroll added Len() to set vDescLen
                    spaceSearchStart = Len(listSubItemDesc)
                End If

                'If we've reached the end of the description
                'take the rest of it as row text.
                If spaceSearchStart = Len(listSubItemDesc) Then
                    listSubItem.Text = Mid(logEventDescriptionValue, Start:=spaceLocation, Length:=Len(listSubItemDesc) - (spaceLocation - 1))
                    FormatDescriptionSubItem(listSubItem, rowColor, lessTime24)
                End If

            Loop
        End If

    End Sub

    Private Sub FormatDescriptionSubItem(
        listSubItem As ListViewItem.ListViewSubItem,
        rowColor As Double,
        lessTime24 As Boolean)

        listSubItem.ForeColor = ColorTranslator.FromOle(rowColor)
        If lessTime24 = True Then
            listSubItem.Font = VB6.FontChangeBold(listSubItem.Font, Bold:=True)
        End If

    End Sub
End Module