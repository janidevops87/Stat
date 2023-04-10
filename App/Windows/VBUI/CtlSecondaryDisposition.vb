Imports System.Collections.Generic
Imports Infragistics.Win.UltraWinGrid

Public Class CtlSecondaryDisposition
    Implements System.Collections.Generic.IList(Of DispositionData)

    Private Const GRAY As Integer = 16250613 'RGB(245, 246, 247)
    Private Const YELLOW As Integer = 10878712 'RGB(248, 254, 165)
    Private Const WHITE As Integer = 16777215 'RGB(255, 255, 255)
    Private Const RED As Integer = 14540276 'RGB(244, 221, 221)
    Private HEADER_BACKGROUND As Integer
    Private HEADER_BORDER As Integer
    Private HEADER_FONT As Integer
    Private CELL_BACKGROUND As Integer
    Private CELL_BORDER As Integer
    Private GROUP_BORDER As Integer
    Private GROUP_FONT As System.Drawing.Color = System.Drawing.ColorTranslator.FromWin32(7302504)
    Private GROUP_BACKGROUND As Integer
    Private GROUP1_BACKGROUND As System.Drawing.Color = System.Drawing.ColorTranslator.FromWin32(14606033)'System.Drawing.SystemColors.Control
    Private GROUP2_BACKGROUND As System.Drawing.Color = System.Drawing.ColorTranslator.FromWin32(15592935) ' System.Drawing.SystemColors.ControlLight

    Private mCallID As Integer
    Private mReportErrors As Boolean

    Private arData() As DispositionData
    Private arDataDistinct As DispositionData()
    Private arDataDistinctOrgan As DispositionData()
    Private arrayCounter As Int32

    Private arIndications As Object
    'Private mRowCount As Integer
    'Private mColCount As Integer
    Private mShowAllColumns As Boolean
    Private frmReferralView As FrmReferralView
    Private frmSecondaryDisposition_Conditionals As FrmSecondaryDisposition_Conditionals
    '    Dim cn As New ADODB.Connection
    Dim rollups As New clsSecondaryDisposition_rps
    'bret 09/20/2010
    Private bs As BindingSource
#Region "Control Properties"

    Public Property ButtonsVisible() As Boolean
        Get
            ButtonsVisible = panel.Panel1.IsAccessible()
        End Get
        Set(ByVal Value As Boolean)
            If Value Then
                panel.Panel1.Show()
                panel.Panel1Collapsed = False
            Else
                panel.Panel1.Hide()
                panel.Panel1Collapsed = True
            End If
            'ctlSecondaryDisposition_Resize(Me, New System.EventArgs())
        End Set
    End Property

    Public Property ReportErrors() As Boolean
        Get
            ReportErrors = mReportErrors
        End Get
        Set(ByVal Value As Boolean)
            mReportErrors = Value
        End Set
    End Property


    Public Property CallId() As Integer
        Get
            CallId = mCallID
        End Get
        Set(ByVal Value As Integer)
            mCallID = Value
            'TriageDisposition() = rollups.TriageDisposition(mCallID&, mreporterrors)
            rollups.CallId = mCallID
            UserControl_Initialize()
            'ctlSecondaryDisposition_Resize(Me, New System.EventArgs())
            If CallId > 0 Then
                Verify()
            End If
        End Set
    End Property
#End Region

#Region "IList Implementation"
    Public Function IndexOf(ByVal item As DispositionData) As Integer Implements IList(Of DispositionData).IndexOf
        Dim index As Integer = -1
        index = Array.IndexOf(arData, item)
        item = Nothing
        Return index
    End Function

    Public Sub Insert(ByVal index As Integer, ByVal item As DispositionData) Implements IList(Of DispositionData).Insert
        item = Nothing
        Throw New NotImplementedException()
    End Sub

    Public Sub RemoveAt(ByVal index As Integer) Implements IList(Of DispositionData).RemoveAt
        Throw New NotImplementedException()
    End Sub

    Default Public Property Item(ByVal index As Integer) As DispositionData Implements IList(Of DispositionData).Item
        Get
            Return arData(index)
        End Get
        Set(ByVal value As DispositionData)
            arData(index) = value
            value = Nothing
        End Set
    End Property

    Public Sub Add(ByVal item As DispositionData) Implements ICollection(Of DispositionData).Add
        Dim newIndex As Integer = UBound(arData)
        ReDim arData(newIndex)
        arData(newIndex) = item
        item = Nothing
    End Sub

    Public Sub Clear() Implements ICollection(Of DispositionData).Clear
        If Not IsNothing(arData) Then
            Array.Clear(arData, 0, arData.Length())
        End If

    End Sub

    Public Function Contains(ByVal item As DispositionData) As Boolean Implements ICollection(Of DispositionData).Contains
        Dim result As Boolean = False
        result = arData.Contains(item)
        item = Nothing
        Return result
    End Function

    Public Sub CopyTo(ByVal array As DispositionData(), ByVal arrayIndex As Integer) Implements ICollection(Of DispositionData).CopyTo
        Dim j As Integer = arrayIndex
        For i As Integer = 0 To Count - 1
            array.SetValue(arData(i), j)
            j = j + 1
        Next i

    End Sub

    Public Function Remove(ByVal item As DispositionData) As Boolean Implements ICollection(Of DispositionData).Remove
        Array.Clear(arData, Array.IndexOf(arData, item), 1)
        item = Nothing
    End Function

    Public ReadOnly Property Count() As Integer Implements ICollection(Of DispositionData).Count
        Get
            Return UBound(arData)
        End Get
    End Property

    Public ReadOnly Property IsReadOnly() As Boolean Implements ICollection(Of DispositionData).IsReadOnly
        Get
            Return False
        End Get
    End Property

    Public Function IEnumerable_GetEnumerator() As IEnumerator(Of DispositionData) Implements IEnumerable _
                                                                                               (Of DispositionData).GetEnumerator
        Return arData.GetEnumerator()
    End Function

    Public Function GetEnumerator() As IEnumerator Implements IEnumerable.GetEnumerator
        Return arData.GetEnumerator()
    End Function


#End Region

#Region "Functions"

    Private Sub UserControl_Initialize()

        If (IsNothing(arIndications)) Then
            arIndications = New Object
        End If
        Try
            If mCallID = 0 Then
                Dim closing As Boolean = True
                ClearDispositionData(closing)
            ElseIf mCallID <> 0 Then
                Call LoadArray()
                Call QSDIndications(mCallID, arIndications, mReportErrors)
                'LoadGrid_Prep()

                ''SGGrid1.DataSource = Me
                LoadGrid_Post()
                'Else
                'LoadGrid_Prep()
            End If
        Catch ex As Exception

            modError.LogError("modSecondaryDisposition.UserControl_Initialize " & ex.Message)

            If mReportErrors Then
                MsgBox("MsgBox(Err.Description) " & ex.Message)
                Exit Sub
            End If

            'Select Case ex.nErr.Number
            '    Case 0
            '        Resume exit_Form_Load
            '    Case Else
            '        If mReportErrors Then MsgBox(Err.Description)
            '        Resume exit_Form_Load
            '        Resume
            'End Select

        End Try


    End Sub
    Private Function LoadArray() As Integer


        Dim sql As String = ""
        Dim Result As New Object
        Dim ResultsArray As New Object
        Dim rowLoop As Integer

        'If Ambient.UserMode = False Then
        'bjk 12/30/03 changing sp version to 1
        sql = "exec sps_SecondaryDispositionRetrieveGridForDotNet " & mCallID
        Try
            Result = modODBC.Exec(sql, ResultsArray)
        Catch ex As Exception

            modError.LogError("CtlSecondaryDisposition.LoadArray : " & ex.Message)

        End Try
        ClearDispositionData()

        ReDim arData(UBound(ResultsArray))



        For rowLoop = 0 To UBound(ResultsArray)
            'Dim dispositionData As DispositionData

            'dispositionData = New DispositionData()
            arData(rowLoop) = New DispositionData()

            arData(rowLoop).CallID = ResultsArray(rowLoop, SD_CallID)
            arData(rowLoop).CriteriaID = ResultsArray(rowLoop, SD_CriteriaID)
            arData(rowLoop).DonorCategoryID = ResultsArray(rowLoop, SD_DonorCategoryID)
            arData(rowLoop).DonorCategory = ResultsArray(rowLoop, SD_DonorCategory)

            arData(rowLoop).SubCriteriaID = ResultsArray(rowLoop, SD_SubCriteriaID)
            arData(rowLoop).SubTypeID = ResultsArray(rowLoop, SD_SubTypeID)
            arData(rowLoop).SubTypeName = ResultsArray(rowLoop, SD_SubTypename)
            arData(rowLoop).ProcessorID = ResultsArray(rowLoop, SD_ProcessorID)
            arData(rowLoop).ProcessorName = ResultsArray(rowLoop, SD_ProcessorName)

            arData(rowLoop).Appropriate = ResultsArray(rowLoop, SD_Appropriate)
            arData(rowLoop).Approach = ResultsArray(rowLoop, SD_Approach)
            arData(rowLoop).Consent = ResultsArray(rowLoop, SD_Consent)
            arData(rowLoop).Recovery = ResultsArray(rowLoop, SD_Recovery)

            arData(rowLoop).SLAppropriate = ResultsArray(rowLoop, SD_SLAppropriate)
            arData(rowLoop).SLApproach = ResultsArray(rowLoop, SD_SLApproach)
            arData(rowLoop).SLConsent = ResultsArray(rowLoop, SD_SLConsent)
            arData(rowLoop).SLRecovery = ResultsArray(rowLoop, SD_SLRecovery)

            arData(rowLoop).ARO = ResultsArray(rowLoop, SD_ARO)
            arData(rowLoop).CRO = ResultsArray(rowLoop, SD_CRO)
            arData(rowLoop).PRO = ResultsArray(rowLoop, SD_PRO)
            arData(rowLoop).ProcessorOrder = ResultsArray(rowLoop, SD_ProcessorOrder)

            'arData(rowLoop) = dispositionData
            'dispositionData = Nothing
        Next

        'mRowCount = UBound(ResultsArray, 1)
        'mColCount = UBound(ResultsArray, 2)
        bs = New BindingSource()
        bs.DataSource = arData
        SGGrid1.DataSource = bs.DataSource

        RefreshGrid()


    End Function

    Private Sub ClearDispositionData(Optional ByVal closing As Boolean = False)

        If Not IsNothing(SGGrid1.DataSource) Then
            'SGGrid1.DataBindings.Control.Dispose()
            SGGrid1.DataSource = Nothing
        End If
        If (closing) Then
            'bs.Dispose()
        End If

    End Sub

    Private Sub LoadGrid_Dropdown(ByRef ColName As String, ByRef TableName As String, Optional ByRef WhereClause As String = "")


        Dim sql As String = ""
        Dim I As Integer
        Dim valueList As Infragistics.Win.ValueList

        Dim vQuery As String = ""
        Dim ResultsArray As New Object
        Dim Result As New Object

        If Trim(WhereClause) <> "" Then WhereClause = " WHERE " & TableName & "ID " & WhereClause

        sql = "SELECT " & TableName & "ID, " & TableName & "Name FROM " & TableName & WhereClause & " ORDER BY " & TableName & "Name"
        Try

            Result = modODBC.Exec(sql, ResultsArray)



            If (Not SGGrid1.DisplayLayout.ValueLists.Exists(ColName)) Then
                valueList = SGGrid1.DisplayLayout.ValueLists.Add(ColName)
                For I = 0 To UBound(ResultsArray, 1)
                    valueList.ValueListItems.Add(ResultsArray(I, 0), ResultsArray(I, 1))
                    'H = H + 17
                Next I
            End If

            SGGrid1.DisplayLayout.Bands(0).Columns(ColName).ValueList = SGGrid1.DisplayLayout.ValueLists(ColName)
        Catch ex As Exception

            modError.LogError("modSecondaryDisposition.LoadGrid_Dropdown " & ex.Message)
        End Try




        'SGGrid1.DisplayLayout.Bands(0).Columns(ColName). = va .Control.PopupStyle.TextAlignment = DDSharpGridOLEDB2.sgAlignment.sgAlignLeftTop
        'SGGrid1.DisplayLayout.Bands(0).Columns(ColName).Control.Type = DDSharpGridOLEDB2.sgCellEditorType.sgCellDropDown
        'SGGrid1.DisplayLayout.Bands(0).Columns(ColName).Control.Height = H
        'SGGrid1.DisplayLayout.Bands(0).Columns(ColName).Control.Width = 147
        'SGGrid1.DisplayLayout.Bands(0).Columns(ColName).Control.PopupAlignment = DDSharpGridOLEDB2.sgPopupAlignment.sgPopupLeft
        'SGGrid1.DisplayLayout.Bands(0).Columns(ColName).Control.SortOrder = DDSharpGridOLEDB2.sgSortOrder.sgNoSorting


    End Sub
    Private Sub LoadGrid_Prep()
        On Error GoTo err_LoadGrid_Prep



exit_LoadGrid_Prep:
        Exit Sub

err_LoadGrid_Prep:
        Select Case Err.Number
            Case 0
                Resume exit_LoadGrid_Prep
            Case Else
                If mReportErrors Then MsgBox(Err.Description)
                Resume exit_LoadGrid_Prep
        End Select

    End Sub
    Private Sub LoadGrid_Post()

        LoadGrid_Dropdown("Appropriate", "FSAppropriate")
        LoadGrid_Dropdown("Approach", IIf(Me.CallId > SEC_DISPO_CUTOFF_CALLID, "FSApproach", "Approach"), "NOT IN (12,13)" & IIf(Me.CallId > SEC_DISPO_CUTOFF_CALLID, " AND Inactive <> -1", "")) 'drh FSMOD 05/20/03 Changed to FSApproach
        LoadGrid_Dropdown("Consent", IIf(Me.CallId > SEC_DISPO_CUTOFF_CALLID, "FSConsent", "Consent"), "NOT IN (7,8)" & IIf(Me.CallId > SEC_DISPO_CUTOFF_CALLID, " AND Inactive <> -1", "")) 'drh FSMOD 05/20/03 Changed to FSConsent
        LoadGrid_Dropdown("Recovery", IIf(Me.CallId > SEC_DISPO_CUTOFF_CALLID, "FSConversion", "Conversion"), IIf(Me.CallId > SEC_DISPO_CUTOFF_CALLID, "NOT IN (-20) AND Inactive <> -1", "")) 'drh FSMOD 05/20/03 Changed to FSConversion


    End Sub
    Public Sub Save()
        On Error GoTo err_cmdSave_Click

        Dim vQuery As String = ""
        Dim ResultsArray As New Object
        Dim Result As New Object

        Dim CallId As String = ""
        Dim SubCriteriaID As String = ""
        Dim Appropriate As String = ""
        Dim Approach As String = ""
        Dim CONSENT As String = ""
        Dim Conversion_Renamed As String
        Dim ConditionalRuleout As String = "" '1/10/03 drh
        Dim I As Integer

        'ccarroll 10/27/2010 - wi8200, Disposition values not saving in FS
        'removed -1 from array Count because not all items in array were being saved 
        For I = 0 To Count
            CallId = FormatParam_int(arData(I).CallID)
            SubCriteriaID = FormatParam_int(arData(I).SubCriteriaID)
            Appropriate = FormatParam_int(arData(I).Appropriate)
            Approach = FormatParam_int(arData(I).Approach)
            CONSENT = FormatParam_int(arData(I).Consent)
            Conversion_Renamed = FormatParam_int(arData(I).Recovery)
            ConditionalRuleout = FormatParam_int(arData(I).CRO) '1/10/03 drh

            vQuery = "EXEC spu_SecondaryDisposition " & CallId & ", " & SubCriteriaID & ", " & Appropriate & ", " & Approach & ", " & CONSENT & ", " & Conversion_Renamed & ", " & ConditionalRuleout & ", " & modConv.TextToLng(AppMain.ParentForm.StatEmployeeID)
            '8/28/02 drh - Removed ResultsArray parameter since there's no return value
            'Result = modODBC.Exec(vQuery, ResultsArray)
            Result = modODBC.Exec(vQuery)
        Next I

        Call rollups.SaveTriageDisposition()

exit_cmdSave_Click:
        Exit Sub

err_cmdSave_Click:
        Select Case Err.Number
            Case 0
                Resume exit_cmdSave_Click
            Case Else
                If mReportErrors Then MsgBox(Err.Description)
                Resume exit_cmdSave_Click
        End Select
    End Sub
    Private Function FormatParam_int(ByRef v As Object) As String
        Try


            'bret 01/07/10 seperated the IsNull check from the is empty ("") check.
            ' This was required because Trim was changed from Trim() Trim$() returning a string instead of variant
            If IsDBNull(v) Then
                FormatParam_int = "NULL"
                Exit Function

            End If

            If Trim(v) = "" Then
                FormatParam_int = "NULL"
                Exit Function
            Else
                FormatParam_int = CStr(CInt(v))
                Exit Function
            End If
        Catch ex As Exception

            If mReportErrors Then
                MsgBox("CtlSecondaryDisposition.FormatParam_int " & ex.Message)
            End If
        End Try


    End Function
    Private Sub RefreshGrid(Optional ByRef Row As Integer = 0)
        VerifyArray()




    End Sub
    Private Sub VerifyArray()

        Dim I As Integer
        If Not TypeOf arData Is Array Then
            Exit Sub

        End If
        'ccarroll 11/01/2010 - wi8200, Removed Count - 1
        For I = 0 To Count '- 1
            If (Not IsDBNull(arData(I).Appropriate)) Then
                If Trim(arData(I).Appropriate) = "" Then arData(I).Appropriate = System.DBNull.Value
            End If

            If (Not IsDBNull(arData(I).Approach)) Then
                If Trim(arData(I).Approach) = "" Then arData(I).Approach = System.DBNull.Value
            End If

            If (Not IsDBNull(arData(I).Consent)) Then
                If Trim(arData(I).Consent) = "" Then arData(I).Consent = System.DBNull.Value
            End If

            If (Not IsDBNull(arData(I).Recovery)) Then
                If Trim(arData(I).Recovery) = "" Then arData(I).Recovery = System.DBNull.Value
            End If

        Next I

        For I = 1 To Count - 1
            'If (ReadCell(arData(), i& - 1, SD_Appropriate, False) = APPROP_YES Or ReadCell(arData(), i& - 1, SD_Appropriate, False) = 0)
            If Not isRO(1, ReadCell(arData, I - 1, SD_Appropriate, False), mReportErrors) And _
            (ReadCell(arData, I, SD_SubTypeID, False) = ReadCell(arData, I - 1, SD_SubTypeID, False)) And _
            Not modSecondaryDisposition.ArrayDeadEnd(arData(I - 1).Appropriate, arData(I - 1).Approach, arData(I - 1).Consent, arData(I - 1).Recovery) Then
                arData(I).PRO = TriState.True
                arData(I).Appropriate = System.DBNull.Value
                arData(I).Approach = System.DBNull.Value
                arData(I).Consent = System.DBNull.Value
                arData(I).Recovery = System.DBNull.Value
            Else
                arData(I).PRO = TriState.False
            End If

        Next I
        'ccarroll 11/01/2010 - wi8200, Removed Count - 1
        For I = 0 To Count '- 1
            If Not isYES(1, arData(I).Appropriate, mReportErrors) Then arData(I).Approach = System.DBNull.Value
            If Not isYES(2, arData(I).Approach, mReportErrors) Then arData(I).Consent = System.DBNull.Value
            If Not isYES(3, arData(I).Consent, mReportErrors) Then arData(I).Recovery = System.DBNull.Value
        Next I


    End Sub
    Private Sub FormatGrid()




    End Sub
    Public Sub CollapseGroups()

    End Sub
    ''' <summary>
    ''' User this to loop through each of the SubType and format the grid
    ''' </summary>
    ''' <remarks></remarks>
    Public Sub CheckEachRow()
        If IsNothing(arData) Then
            Exit Sub
        End If
        Dim subTypeID As Integer = -1
        For Each ultraGridRow As UltraGridRow In SGGrid1.Rows.GetFilteredInNonGroupByRows
            '            If ultraGridRow.Cells("SubTypeID").Value.ToString.Length > 0 Then
            DisableCell(ultraGridRow, "Appropriate", ultraGridRow.Cells("SLAppropriate").Value, ultraGridRow.Cells("ARO").Value, ultraGridRow.Cells("CRO").Value, ultraGridRow.Cells("PRO").Value, TriState.True)
            DisableCell(ultraGridRow, "Approach", ultraGridRow.Cells("SLApproach").Value, ultraGridRow.Cells("ARO").Value, TriState.False, ultraGridRow.Cells("PRO").Value, isYES(1, ultraGridRow.Cells("Appropriate").Value, mReportErrors))
            DisableCell(ultraGridRow, "Consent", ultraGridRow.Cells("SLConsent").Value, ultraGridRow.Cells("ARO").Value, TriState.False, ultraGridRow.Cells("PRO").Value, isYES(2, ultraGridRow.Cells("Approach").Value, mReportErrors))
            DisableCell(ultraGridRow, "Recovery", ultraGridRow.Cells("SLRecovery").Value, ultraGridRow.Cells("ARO").Value, TriState.False, ultraGridRow.Cells("PRO").Value, isYES(3, ultraGridRow.Cells("Consent").Value, mReportErrors))
            '           End If
        Next



    End Sub
    Public Sub CheckEachRow(ByVal subTypeID As Integer)
        If IsNothing(SGGrid1.Rows) Then
            Return
        End If
        For Each ultraGridRow As UltraGridRow In SGGrid1.Rows
            If ultraGridRow.IsGroupByRow Then
                Dim ultraGridGroupByRow As UltraGridGroupByRow = DirectCast(ultraGridRow, UltraGridGroupByRow)
                CheckEachRow(subTypeID, ultraGridGroupByRow)
            End If
        Next
    End Sub
    Public Sub CheckEachRow(ByVal subTypeID As Integer, ByRef groupHeaderRows As UltraGridGroupByRow)
        Try

            For Each ultraGridChildBand As UltraGridChildBand In groupHeaderRows.ChildBands
                CheckEachRow(subTypeID, ultraGridChildBand.Rows)

            Next
        Catch ex As Exception

        End Try

    End Sub
    Private Sub CheckEachRow(ByVal subTypeID As Integer, ByRef groupHeaderRows As RowsCollection)

        'logic
        'loop through the child records until the child contains no data
        Try
            For Each ultraGridRow As UltraGridRow In groupHeaderRows
                If TypeOf ultraGridRow Is UltraGridGroupByRow Then

                    CheckEachRow(subTypeID, ultraGridRow)

                Else
                    DisableCell(ultraGridRow)
                End If


            Next
        Catch ex As Exception

        End Try
    End Sub

    Public Sub Verify(Optional ByVal verifyAllData As Boolean = False)
        'Dim startTime As Date
        'Dim endTime As Date

        modUtility.Work()
        'System.Console.WriteLine("Start")
        modSecondaryDisposition.CheckCriteria(MyBase.FindForm, arData, True, True, True, mReportErrors)

        VerifyArray()

        SetRowHeaders()
        CheckEachRow()
        SGGrid1.Refresh()
        modUtility.Done()



    End Sub
    ''' <summary>
    ''' Finds all instances of the first Group By Column
    ''' </summary>
    ''' <remarks></remarks>
    Private Sub SetRowHeaders()
        Dim groupIndex As Integer
        Dim backupColor As System.Drawing.Color
        Dim ultraGridGroupByRow As UltraGridGroupByRow

        If IsNothing(SGGrid1.Rows) Then
            Return
        End If

        'bret 10/04/10 added in to account for new way of calculating header values.
        CalculateRowHeaderData()

        For Each ultraGridRow As UltraGridRow In SGGrid1.Rows
            If ultraGridRow.IsGroupByRow Then
                UltraGridGroupByRow = DirectCast(ultraGridRow, UltraGridGroupByRow)
                GroupLevelConfigure(UltraGridGroupByRow.Column.Key, groupIndex, backupColor)
                'ultraGridGroupByRow.Description = 
                UltraGridGroupByRow.Description = rollups.RollupText(SGGrid1, mCallID, groupIndex, UltraGridGroupByRow, ReportErrors, arDataDistinct, arDataDistinctOrgan)
                SetRowHeaders(ultraGridGroupByRow)
            End If
        Next

    End Sub
    ''' <summary>
    ''' Finds all instances of the sub Group By Columns
    ''' </summary>
    ''' <param name="groupHeaderRows"></param>
    ''' <remarks></remarks>
    Private Sub SetRowHeaders(ByRef groupHeaderRows As UltraGridGroupByRow)

        For Each ultraGridChildBand As UltraGridChildBand In groupHeaderRows.ChildBands
            SetRowHeaders(ultraGridChildBand.Rows)
        Next

    End Sub
    Private Sub SetRowHeaders(ByRef groupHeaderRows As RowsCollection)
        'fix steps bret:
        ' 1. get donorCategoryID of children all categories should be the same, find fist and return it
        ' 2. do the same for the subCriteriaID
        ' 3. Appropriate, Approach, Consent, Recovery
        ' 4. Also include cells 7 - 12
        ' should be able to use the same code for both groups
        Dim ultraGridGroupByRow As UltraGridGroupByRow
        Dim groupIndex As Integer
        Dim backupColor As System.Drawing.Color

        'logic
        'loop through the child records until the child contains no data
        For Each ultraGridRow As UltraGridRow In groupHeaderRows
            If TypeOf ultraGridRow Is UltraGridGroupByRow Then
                ultraGridGroupByRow = DirectCast(ultraGridRow, UltraGridGroupByRow)
                GroupLevelConfigure(ultraGridGroupByRow.Column.Key, groupIndex, backupColor)
                'ultraGridGroupByRow.Description = 
                ultraGridGroupByRow.Description = rollups.RollupText(SGGrid1, mCallID, groupIndex, ultraGridGroupByRow, ReportErrors, arDataDistinct, arDataDistinctOrgan)
            End If
        Next

    End Sub
    Private Sub GroupLevelConfigure(ByVal columnName As String, ByRef groupIndex As Integer, ByRef groupBackColor As System.Drawing.Color)
        If columnName = "SubTypeName" Then 'GROUP_BACKGROUND_CURRENT = GROUP1_BACKGROUND Then
            groupBackColor = GROUP2_BACKGROUND
            groupIndex = 1
            Return
        Else
            groupBackColor = GROUP1_BACKGROUND
            groupIndex = 0
            Return
        End If

    End Sub
    Private Sub DisableCell(ByRef row As UltraGridRow, ByRef ColName As String, ByRef SL As Object, ByRef ARO As Object, ByRef CRO As Object, ByRef PRO As Object, ByRef APPROP As Object)

        Dim appropriateValue As Integer = 0
        row.Cells(ColName).Appearance.BackColor = System.Drawing.Color.Gray
        row.Cells(ColName).Activation = Activation.NoEdit

        If IsDBNull(Enabled) Then
            Enabled = 0
        End If

        If IsDBNull(SL) Then
            SL = 0
            Return
        End If

        If IsDBNull(APPROP) Then
            APPROP = 0
            Return
        End If
        If IsDBNull(row.Cells("Appropriate").Value) Then
            appropriateValue = 0

        Else
            appropriateValue = modConv.TextToInt(row.Cells("Appropriate").Value)
        End If

        If CBool(SL) And Not CBool(ARO) And Not CBool(CRO) And Not CBool(PRO) And CBool(APPROP) Then

            If ColName = "Appropriate" And appropriateValue = 1 And modSecondaryDisposition.CheckIndications(MyBase.FindForm, IIf(row.Cells("SubCriteriaID").Value = "", 0, row.Cells("SubCriteriaID").Value), arIndications, mReportErrors) Then
                row.Cells(ColName).Appearance.BackColor = System.Drawing.Color.Red
                'bret 01/07/10 broke out the single else if checking both null and empty string into two if statements
            ElseIf IsDBNull(row.Cells(ColName).Value) Then
                row.Cells(ColName).Appearance.BackColor = System.Drawing.Color.Yellow
            ElseIf Trim(row.Cells(ColName).Value) = "" Then
                row.Cells(ColName).Appearance.BackColor = System.Drawing.Color.Yellow
            Else
                row.Cells(ColName).Appearance.BackColor = System.Drawing.Color.White
            End If
            row.Cells(ColName).Activation = Activation.AllowEdit
        End If

        Return

    End Sub

    Private Sub DisableCell(ByRef ultraGridRow As UltraGridRow)


        If Not TypeOf ultraGridRow Is UltraGridGroupByRow Then

            DisableCell(ultraGridRow, "Appropriate", ultraGridRow.Cells("SLAppropriate").Value, ultraGridRow.Cells("ARO").Value, ultraGridRow.Cells("CRO").Value, ultraGridRow.Cells("PRO").Value, TriState.True)
            DisableCell(ultraGridRow, "Approach", ultraGridRow.Cells("SLApproach").Value, ultraGridRow.Cells("ARO").Value, TriState.False, ultraGridRow.Cells("PRO").Value, isYES(1, ultraGridRow.Cells("Appropriate").Value, mReportErrors))
            DisableCell(ultraGridRow, "Consent", ultraGridRow.Cells("SLConsent").Value, ultraGridRow.Cells("ARO").Value, TriState.False, ultraGridRow.Cells("PRO").Value, isYES(2, ultraGridRow.Cells("Approach").Value, mReportErrors))
            DisableCell(ultraGridRow, "Recovery", ultraGridRow.Cells("SLRecovery").Value, ultraGridRow.Cells("ARO").Value, TriState.False, ultraGridRow.Cells("PRO").Value, isYES(3, ultraGridRow.Cells("Consent").Value, mReportErrors))
        End If


    End Sub

#End Region

    Private Sub cmdVerify_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdVerify.Click
        Call Me.Verify()
    End Sub

    Private Sub cmdSave_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdSave.Click
        Save()
    End Sub

    Private Sub SGGrid1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles SGGrid1.ClickCell
        Conditionals(1)
    End Sub


    Private Sub SGGrid1_InitializeLayout(ByVal sender As System.Object, ByVal e As Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs) Handles SGGrid1.InitializeLayout
        e.Layout.ViewStyleBand = ViewStyleBand.OutlookGroupBy


        ' Get the ProductName column. 
        Dim columnDonorCategory As UltraGridColumn = e.Layout.Bands(0).Columns("DonorCategory")
        Dim columnSubTypeName As UltraGridColumn = e.Layout.Bands(0).Columns("SubTypeName")
        Dim columnProcessorOrder As UltraGridColumn = e.Layout.Bands(0).Columns("ProcessorOrder")
        ' Set the GroupByEvaluator on the column to an instance of MyGroupByEvaluator 
        columnDonorCategory.GroupByEvaluator = New GroupByDonorCategoryID()
        columnSubTypeName.GroupByEvaluator = New GroupByDonorCategoryID()
        columnProcessorOrder.GroupByEvaluator = New GroupByDonorCategoryID()

        If (e.Layout.Bands(0).SortedColumns.Count > 0) Then
            e.Layout.Bands(0).SortedColumns.Clear()
        End If


        e.Layout.Bands(0).SortedColumns.Add(columnDonorCategory, False, True)
        e.Layout.Bands(0).SortedColumns.Add(columnSubTypeName, False, True)

        e.Layout.Bands(0).SortedColumns.Add(columnProcessorOrder, False, False)

        e.Layout.Override.HeaderPlacement = HeaderPlacement.FixedOnTop
        e.Layout.Bands(0).Columns("ProcessorOrder").Hidden = True

        Dim autoCompleteModeSetting As Infragistics.Win.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append
        e.Layout.Bands(0).Columns("Appropriate").AutoCompleteMode = autoCompleteModeSetting
        e.Layout.Bands(0).Columns("Approach").AutoCompleteMode = autoCompleteModeSetting
        e.Layout.Bands(0).Columns("Consent").AutoCompleteMode = autoCompleteModeSetting
        e.Layout.Bands(0).Columns("Recovery").AutoCompleteMode = autoCompleteModeSetting
        e.Layout.Bands(0).Columns("ProcessorName").CellActivation = Activation.NoEdit

        'Dim grp As New UltraGridGroup()
        'grp.Columns.Add(e.Layout.Bands(0).Columns("DonorCategory"))

        'e.Layout.Bands(0).SortedColumns.RefreshSort(True)
        'SGGrid1.Rows.ExpandAll(True)

        'LoadGrid_AddGroup("DonorCategory", DDSharpGridOLEDB2.sgSortOrder.sgNoSorting, Fals
        'LoadGrid_AddGroup("SubTypeName", DDSharpGridOLEDB2.sgSortOrder.sgNoSorting, False)

    End Sub

    Private Sub SGGrid1_InitializeGroupByRow(ByVal sender As System.Object, ByVal e As Infragistics.Win.UltraWinGrid.InitializeGroupByRowEventArgs) Handles SGGrid1.InitializeGroupByRow

        Dim groupIndex As Integer
        Dim backupColor As System.Drawing.Color

        Me.GroupLevelConfigure(e.Row.Column.Key, groupIndex, backupColor)
        e.Row.Appearance.BackColor = BackColor
        e.Row.Appearance.ForeColor = GROUP_FONT
        'e.Row.Expanded = Truee.Row.Description = 
        'e.Row.Description = rollups.RollupTextStripCharacters(e.Row.Description)
        'e.Row.Description = rollups.RollupText(SGGrid1, mCallID, groupIndex, e.Row, ReportErrors)

    End Sub

    'Private Sub SGGrid1_CellChange(ByVal sender As System.Object, ByVal e As Infragistics.Win.UltraWinGrid.CellEventArgs) Handles SGGrid1.CellChange



    'End Sub


    Private Sub SGGrid1_InitializeRow(ByVal sender As System.Object, ByVal e As Infragistics.Win.UltraWinGrid.InitializeRowEventArgs) Handles SGGrid1.InitializeRow
        DisableCell(e.Row)

    End Sub

    Private Sub SGGrid1_ClickCellButton(ByVal sender As System.Object, ByVal e As Infragistics.Win.UltraWinGrid.CellEventArgs) Handles SGGrid1.ClickCellButton
        modUtility.Work()
        Select Case e.Cell.Column.Key
            Case SGGrid1.DisplayLayout.Bands(0).Columns("btnCriteria").Key
                Dim criteriaID As Integer = e.Cell.Row.Cells("CriteriaID").Value
                Dim donorCategoryID As Integer = e.Cell.Row.Cells("DonorCategoryID").Value
                If e.Cell.Row.Cells("SubCriteriaID").Value = "" Then
                    Exit Sub
                End If
                Dim SubCriteriaID As Integer = e.Cell.Row.Cells("SubCriteriaID").Value
                Dim callID As Integer = e.Cell.Row.Cells("CallID").Value

                frmReferralView = ParentForm

                frmReferralView.DisplayCriteria(callID, criteriaID, donorCategoryID, SubCriteriaID)


            Case SGGrid1.DisplayLayout.Bands(0).Columns("btnStrike").Key
                LightningStrike(e.Cell.Row)
        End Select
        SGGrid1.Selected.Cells.Clear()
        SGGrid1.ActiveCell.Selected = False
        SGGrid1.ActiveCell = Nothing

        SGGrid1.Refresh()
        modUtility.Done()

    End Sub
    Public Sub LightningStrike(ByVal row As Infragistics.Win.UltraWinGrid.UltraGridRow)
        On Error GoTo err_LightningStrike

        Const MSG As String = "Overwrite current disposition with results of current row for this Donor Category?  Press Cancel to go back."
        Const MSGTITLE As String = "Overwrite - Cancel to go back"

        Dim DonorCategoryID, ProcessorID As Integer
        Dim ARO, CONSENT, Appropriate, Approach, Recovery, CRO As Object

        Select Case MsgBox(MSG, MsgBoxStyle.OkCancel, MSGTITLE)
            Case MsgBoxResult.Ok
            Case Else : Exit Sub
        End Select

        DonorCategoryID = row.Cells("DonorCategoryID").Value
        ProcessorID = row.Cells("ProcessorID").Value
        Appropriate = row.Cells("Appropriate").Value
        Approach = row.Cells("Approach").Value
        CONSENT = row.Cells("Consent").Value
        Recovery = row.Cells("Recovery").Value
        ARO = row.Cells("ARO").Value
        CRO = row.Cells("CRO").Value
        Call modSecondaryDisposition.Discharge(arData, DonorCategoryID, ProcessorID, Appropriate, Approach, CONSENT, Recovery, ARO, CRO, mReportErrors)
        RefreshGrid()

exit_LightningStrike:
        Exit Sub

err_LightningStrike:
        Select Case Err.Number
            Case 0
                Resume exit_LightningStrike
            Case Else
                If mReportErrors Then MsgBox(Err.Description)
                Resume exit_LightningStrike
                Resume
        End Select

    End Sub

    Private Sub CtlSecondaryDisposition_KeyDown(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles MyBase.KeyDown
        Dim KeyCode As Short = e.KeyCode
        Dim Shift As Short = e.KeyData \ &H10000

        'If KeyCode = 112 Then Call Conditionals(1, 2) : KeyCode = 0
        'ccarroll 05-11-2011 removed conditional for F2 (1, 2) see above
        'This was causing FrmCriteria to launch, which in turn lost focus of controls
        'and generated host of errors.
        If KeyCode = 112 Then Call Conditionals(1) : KeyCode = 0

        If KeyCode = 113 Then Call Conditionals(2) : KeyCode = 0
        If KeyCode = 85 Then Call UnlockCurrentRow() : KeyCode = 0
        If KeyCode = 75 And Shift = 3 Then Me.ButtonsVisible = Not ButtonsVisible : KeyCode = 0
        'If KeyCode = 69 And Shift = 3 Then cmdExpandColumns_Click(cmdExpandColumns, New System.EventArgs()) : KeyCode = 0
        If KeyCode = 49 Then Call LightningStrike(SGGrid1.Selected.Cells(0).Row) : KeyCode = 0

    End Sub
    Private Sub Conditionals(ByRef Click_Renamed As Integer, Optional ByRef Key As Integer = 0)
        On Error GoTo err_Conditionals

        Const F1 As Short = 1
        Const F2 As Short = 2
        Const F3 As Short = 3
        Const cBTN1 As String = "btnCriteria"
        Const cBTN2 As String = "btnStrike"
        Const cCALLID As String = "CallID"
        Const cCRITERIAID As String = "CriteriaID"
        Const cSUBCRITERIAID As String = "SubCriteriaID"
        Const cDONORCATEGORYID As String = "DonorCategoryID"
        Const cPROCESSOR As String = "ProcessorName"

        If IsNothing(SGGrid1.ActiveCell) Then
            Exit Sub
        End If
        If SGGrid1.ActiveCell.Column.Key = cBTN1 Or Key = F2 Then
            Dim frmReferralView As FrmReferralView = MyBase.FindForm
            'Call frmReferralView.DisplayCriteria(SGGrid1.get_Cell(SGGrid1.CurrentCell.RowKey, cCALLID).Value, SGGrid1.get_Cell(SGGrid1.CurrentCell.RowKey, cCRITERIAID).Value, SGGrid1.get_Cell(SGGrid1.CurrentCell.RowKey, cDONORCATEGORYID).Value, SGGrid1.get_Cell(SGGrid1.CurrentCell.RowKey, cSUBCRITERIAID).Value)
            Call frmReferralView.DisplayCriteria(SGGrid1.ActiveCell.Row.Cells(cCALLID).Value, SGGrid1.ActiveCell.Row.Cells(cCRITERIAID).Value, SGGrid1.ActiveCell.Row.Cells(cDONORCATEGORYID).Value, SGGrid1.ActiveCell.Row.Cells(cSUBCRITERIAID).Value)

        ElseIf SGGrid1.ActiveCell.Column.Key = cBTN2 Or Key = F3 Then
            Call LightningStrike(SGGrid1.ActiveCell.Row)
        ElseIf Click_Renamed = 2 Or Key = F1 Then
            frmSecondaryDisposition_Conditionals = New FrmSecondaryDisposition_Conditionals
            frmSecondaryDisposition_Conditionals.ReportErrors = mReportErrors
            If SGGrid1.ActiveCell.Column.Key = cPROCESSOR Then frmSecondaryDisposition_Conditionals.chkCriteriaAll.CheckState = System.Windows.Forms.CheckState.Checked
            frmSecondaryDisposition_Conditionals.ReferringForm = MyBase.FindForm
            frmSecondaryDisposition_Conditionals.DonorCategory = SGGrid1.ActiveCell.Row.Cells("DonorCategory").Value
            frmSecondaryDisposition_Conditionals.SubTypename = SGGrid1.ActiveCell.Row.Cells("SubTypeName").Value
            frmSecondaryDisposition_Conditionals.ProcessorName = SGGrid1.ActiveCell.Row.Cells("ProcessorName").Value
            frmSecondaryDisposition_Conditionals.SubCriteriaID = SGGrid1.ActiveCell.Row.Cells("SubCriteriaID").Value
            frmSecondaryDisposition_Conditionals.ShowDialog()
        End If

exit_Conditionals:
        Exit Sub

err_Conditionals:
        Select Case Err.Number
            Case 0
                Resume exit_Conditionals
            Case 13
                Resume exit_Conditionals 'Group Row of Grid
            Case Else
                If mReportErrors Then MsgBox(Err.Description)
                Resume exit_Conditionals
                Resume
        End Select

    End Sub
    Public Sub UnlockCurrentRow()

        Const msgARO As String = "Cannot unlock current row because it was Ruled-Out in Triage"
        Dim SubCriteriaID, I As Integer
        Dim ARO As New Object

        SubCriteriaID = SGGrid1.ActiveRow.Cells(0).Row.Cells("SubCriteriaID").Value
        ARO = SGGrid1.ActiveRow.Cells(0).Row.Cells("ARO").Value

        If ARO = TriState.True Then
            MsgBox(msgARO)
        Else
            For I = 0 To UBound(arData, 1)
                Dim arDataSubCriteriaID As String = IIf(Len(arData(I)(SD_SubCriteriaID)) > 0, arData(I)(SD_SubCriteriaID), "0")
                If arDataSubCriteriaID = SubCriteriaID Then
                    arData(I)(SD_CRO) = 0
                    arData(I)(SD_PRO) = 0
                End If
            Next I
        End If

        RefreshGrid()

    End Sub

    Private Sub SGGrid1_DoubleClick(ByVal sender As Object, ByVal e As System.EventArgs) Handles SGGrid1.DoubleClickCell
        Conditionals(2)
    End Sub

    Private Sub SGGrid1_KeyDown(ByVal sender As System.Object, ByVal EventArgs As System.Windows.Forms.KeyEventArgs) Handles SGGrid1.KeyDown

        Select Case EventArgs.KeyValue
            Case Keys.Delete

                If (SGGrid1.ActiveCell.Column.Key = "Appropriate" Or SGGrid1.ActiveCell.Column.Key = "Approach" Or SGGrid1.ActiveCell.Column.Key = "Consent" Or SGGrid1.ActiveCell.Column.Key = "Recovery") Then
                    If SGGrid1.ActiveCell.Activation = Activation.AllowEdit Then
                        SGGrid1.ActiveCell.Value = System.DBNull.Value
                    End If

                End If

        End Select
    End Sub
    Private Sub SGGrid1_KeyPress(ByVal sender As System.Object, ByVal EventArgs As System.Windows.Forms.KeyPressEventArgs) Handles SGGrid1.KeyPress

        Dim KeyCode As Short = Asc(EventArgs.KeyChar)
        'Dim Shift As Short =  '. .KeyCha \ &H10000
        'ChrW(112) = p
        'ChrW(113) = q
        'ChrW(85) = U
        'ChrW(75) = k
        'ChrW(49) = 1
        'If KeyCode = 112 Then Call Conditionals(1, 2) : KeyCode = 0
        'ccarroll 05-11-2011 removed conditional for F2 (1, 2) see above
        'This was causing FrmCriteria to launch, which in turn lost focus of controls
        'and generated host of errors.
        If KeyCode = 112 Then Call Conditionals(1) : KeyCode = 0
        If KeyCode = 113 Then Call Conditionals(2) : KeyCode = 0
        If KeyCode = 85 Then Call UnlockCurrentRow() : KeyCode = 0
        If KeyCode = 75 And ((Control.ModifierKeys And Keys.Shift) = Keys.Shift) Then Me.ButtonsVisible = Not ButtonsVisible : KeyCode = 0
        'If KeyCode = 69 And Shift = 3 Then e  cmdExpandColumns_Click(cmdExpandColumns, New System.EventArgs()) : KeyCode = 0
        If KeyCode = 49 Then Call LightningStrike(SGGrid1.ActiveRow) : KeyCode = 0
    End Sub

    Private Sub SGGrid1_AfterCellUpdate(ByVal sender As System.Object, ByVal e As Infragistics.Win.UltraWinGrid.CellEventArgs) Handles SGGrid1.AfterCellUpdate
        If IsNothing(SGGrid1.ActiveCell) Then
            Exit Sub
        End If
        If (SGGrid1.ActiveCell.Row.IsGroupByRow) Then
            Exit Sub
        End If

        RemoveHandler SGGrid1.AfterCellUpdate, AddressOf SGGrid1_AfterCellUpdate
        'DisableCell(SGGrid1.ActiveCell.Row)
        VerifyArray()
        CheckEachRow()
        'SetRowHeaders()
        AddHandler SGGrid1.AfterCellUpdate, AddressOf SGGrid1_AfterCellUpdate
        SetRowHeaders()

    End Sub
    Private Sub CalculateRowHeaderData()
        ' 1 load distinct data into subType DispositionData array
        ' 2 load distinct data into organ DispositionData array
        ' 3 initialize by setting all disposition header values to -1 
        ' 4 Check for Yes values
        ' 5 check for blanks
        ' 6 find the ruleout value
        ' 7 if Organ Appropriate is yes and all of the sub Types are RO then Approach is Secondary RO

        '1 create a distinct list of Disposition Data based on SubType
        ReDim arDataDistinct(arData.ToList.Distinct(New DispositionDataDistinctOrganSubTypeComparer).ToArray().Length - 1)
        arrayCounter = 0
        arData.ToList.Distinct(New DispositionDataDistinctOrganSubTypeComparer).ToList.ForEach(AddressOf CreatearDataDistinctNewArray)

        '2 create a distinct list of Dispositin Data based on Organ
        ReDim arDataDistinctOrgan(arData.ToList.Distinct(New DispositionDataDistinctOrganComparer).ToArray().Length - 1)
        arrayCounter = 0
        arData.ToList.Distinct(New DispositionDataDistinctOrganComparer).ToList.ForEach(AddressOf CreatearDataDistinctOrganNewArray)


        '3 initialize all values by setting values to 0
        arDataDistinct.ToList.ForEach(AddressOf InitializeDispositionDataHeadersSubType)
        arDataDistinctOrgan.ToList.ForEach(AddressOf InitializeDispositionDataHeadersOrgan)


        '4 check for Yes
        ' set subtype values
        ' loop through arDataDistinct
        arDataDistinct.ToList.ForEach(AddressOf CheckForYesSubType)
        arDataDistinctOrgan.ToList.ForEach(AddressOf CheckForYesOrgan)

        '5 check for blank or empty values
        arDataDistinct.ToList.ForEach(AddressOf CheckForDbNullSubType)
        arDataDistinctOrgan.ToList.ForEach(AddressOf CheckForDbNullOrgan)

        '6 find the ruleout value
        arDataDistinct.ToList.ForEach(AddressOf CheckForRoReasonSubType)
        arDataDistinctOrgan.ToList.ForEach(AddressOf CheckForRoReasonOrgan)


        '7  
        arDataDistinctOrgan.ToList.ForEach(AddressOf CheckForSecondaryRO)

    End Sub
#Region "Delegates"
    Private Function FindSubTypeName(ByVal dispositionData As DispositionData) As Boolean
        Dim isEqual As Boolean = False
        Return isEqual

    End Function

    Private Sub CheckForSecondaryRO(ByVal dispositionData As DispositionData)
        Dim yesOrNullExists As Boolean = False
        If dispositionData.Appropriate.ToString().Length = 0 Then
            Return
        End If
        If dispositionData.Appropriate > APPROP_YES Then
            For Each dispo As DispositionData In arDataDistinct.ToList.Where(Function(d) d.DonorCategoryID = dispositionData.DonorCategoryID).ToList()
                If dispo.Appropriate.ToString.Length > 0 Then
                    If dispo.Appropriate = APPROP_YES Then
                        yesOrNullExists = True
                        Exit For
                    End If
                Else
                    yesOrNullExists = True
                    Exit For
                End If
            Next
            If Not yesOrNullExists Then
                dispositionData.Approach = APPRCH_SECONDARY_RO
            End If
        End If
    End Sub
    ''' <summary>
    ''' 
    ''' </summary>
    ''' <param name="dispositionData"></param>
    ''' <remarks></remarks>
    Private Sub CheckForRoReasonOrgan(ByVal dispositionData As DispositionData)
        If (dispositionData.SubTypeID.ToString.Length = 0) Then
            Return
        End If

        Dim appropriateRo As Integer = -1
        Dim approachRo As Integer = -1
        Dim consentRo As Integer = -1
        Dim recoveryRo As Integer = -1
        For Each dispo As DispositionData In arData
            'ccarroll 10/19/2010 changed If to look for string length
            'was Not IsDBNull
            If dispo.SubTypeID.ToString.Length > 0 Then
                If dispo.DonorCategoryID = dispositionData.DonorCategoryID Then '

                    If dispositionData.Appropriate.ToString.Length > 0 Then ' value is not yes and is not dbnulll
                        If Math.Abs(dispositionData.Appropriate) <> 1 Then
                            If dispo.Appropriate.ToString.Length > 0 Then
                                If dispo.Appropriate > 1 And dispo.DonorCategoryID = dispositionData.DonorCategoryID Then
                                    appropriateRo = dispo.Appropriate
                                End If
                            End If
                        End If
                    End If

                    If dispositionData.Approach.ToString.Length > 0 Then ' not null and not empty string
                        If Math.Abs(dispositionData.Approach) <> 1 Then
                            If dispo.Appropriate.ToString.Length > 0 And dispo.Approach.ToString.Length > 0 Then
                                If dispo.Appropriate = 1 And dispo.Approach > 1 And dispo.DonorCategoryID = dispositionData.DonorCategoryID Then
                                    approachRo = dispo.Approach
                                End If
                            End If
                        End If
                    End If


                    If dispositionData.Consent.ToString.Length > 0 Then ' not null and not empty string
                        If Math.Abs(dispositionData.Consent) <> 1 Then
                            If dispo.Appropriate.ToString.Length > 0 And dispo.Approach.ToString.Length > 0 And dispo.Consent.ToString.Length > 0 Then ' value is greater than 1(yes) 
                                If dispo.Appropriate = 1 And dispo.Approach = 1 And dispo.Consent > 1 And dispo.DonorCategoryID = dispositionData.DonorCategoryID Then
                                    consentRo = CONSENT_UNKNOWN ' 5 'dispo.Consent
                                End If
                            End If
                        End If
                    End If
                    If dispositionData.Recovery.ToString.Length > 0 Then
                        If Math.Abs(dispositionData.Recovery) <> 1 Then
                            If dispo.Appropriate.ToString.Length > 0 And dispo.Approach.ToString.Length > 0 And dispo.Consent.ToString.Length > 0 And dispo.Recovery.ToString.Length > 0 Then
                                If dispo.Appropriate = 1 And dispo.Approach = 1 And dispo.Consent = 1 And dispo.Recovery > 1 And dispo.DonorCategoryID = dispositionData.DonorCategoryID Then
                                    recoveryRo = RECOVER_CNR
                                End If
                            End If
                        End If
                    End If
                End If
            End If
        Next

        If appropriateRo > 1 Then
            dispositionData.Appropriate = appropriateRo
        End If
        If approachRo > 1 Then
            dispositionData.Approach = approachRo
        End If
        If consentRo > 1 Then
            dispositionData.Consent = consentRo
        End If
        If recoveryRo > 1 Then
            dispositionData.Recovery = recoveryRo
        End If
    End Sub
    ''' <summary>
    ''' Check each record in arData to determine if there is a ruleout
    ''' </summary>
    ''' <param name="dispositionData"></param>
    ''' <remarks></remarks>
    Private Sub CheckForRoReasonSubType(ByVal dispositionData As DispositionData)
        If (dispositionData.SubTypeID.ToString.Length = 0) Then
            Return
        End If

        Dim appropriateRo As Integer = -1
        Dim approachRo As Integer = -1
        Dim consentRo As Integer = -1
        Dim recoveryRo As Integer = -1
        For Each dispo As DispositionData In arData
            'ccarroll 10/19/2010 changed If to look for string length

            If dispo.SubTypeID.ToString.Length > 0 Then

                If dispo.DonorCategoryID = dispositionData.DonorCategoryID And dispo.SubTypeID = dispositionData.SubTypeID Then
                    'if the value is not Yes and not DbNulls
                    If dispositionData.Appropriate.ToString.Length > 0 Then
                        If dispositionData.Appropriate <> 1 Then
                            If dispo.Appropriate.ToString.Length > 0 Then
                                If dispo.Appropriate > 1 And dispo.DonorCategoryID = dispositionData.DonorCategoryID And dispo.SubTypeID = dispositionData.SubTypeID Then
                                    appropriateRo = dispo.Appropriate
                                Else
                                    'reset the value. not all values are assigned
                                    appropriateRo = -1
                                End If
                            End If
                        End If
                    End If

                    If dispositionData.Approach.ToString.Length > 0 Then
                        If dispositionData.Approach <> 1 Then
                            If dispo.Approach.ToString.Length > 0 Then
                                If dispo.Approach > 1 And dispo.DonorCategoryID = dispositionData.DonorCategoryID And dispo.SubTypeID = dispositionData.SubTypeID Then
                                    approachRo = dispo.Approach
                                Else
                                    approachRo = -1
                                End If
                            Else
                                'reset the value. not all values are assigned
                                approachRo = -1
                            End If
                        End If
                    End If

                    If dispositionData.Consent.ToString.Length > 0 Then
                        If dispositionData.Consent <> 1 Then
                            If dispo.Consent.ToString.Length > 0 Then
                                If dispo.Consent > 1 And dispo.DonorCategoryID = dispositionData.DonorCategoryID And dispo.SubTypeID = dispositionData.SubTypeID Then
                                    consentRo = dispo.Consent
                                Else
                                    'reset the value. not all values are assigned
                                    consentRo = -1
                                End If
                            Else
                                'reset the value. not all values are assigned
                                consentRo = -1
                            End If
                        End If
                    End If
                    If dispositionData.Recovery.ToString.Length > 0 Then
                        If dispositionData.Recovery <> 1 Then
                            If dispo.Recovery.ToString.Length > 0 Then
                                If dispo.Recovery > 1 And dispo.DonorCategoryID = dispositionData.DonorCategoryID And dispo.SubTypeID = dispositionData.SubTypeID Then
                                    recoveryRo = dispo.Recovery
                                Else
                                    'reset the value. not all values are assigned
                                    recoveryRo = -1
                                End If
                            Else
                                'reset the value. not all values are assigned
                                recoveryRo = -1
                            End If
                        End If
                    End If
                End If
            End If
        Next

        If appropriateRo > 1 Then
            dispositionData.Appropriate = appropriateRo
        End If
        If approachRo > 1 Then
            dispositionData.Approach = approachRo
        End If
        If consentRo > 1 Then
            dispositionData.Consent = consentRo
        End If
        If recoveryRo > 1 Then
            dispositionData.Recovery = recoveryRo
        End If
    End Sub
    ''' <summary>
    ''' Check each record in arData to determine if a DBNull exists. Do not include where value is yes
    ''' Organ
    ''' </summary>
    ''' <param name="dispositionData"></param>
    ''' <remarks></remarks>
    Private Sub CheckForDbNullOrgan(ByVal dispositionData As DispositionData)
        If (dispositionData.SubTypeID.ToString.Length = 0) Then
            Return
        End If

        Dim appropriateIsDbNull As Boolean = False
        Dim approachIsDbNull As Boolean = False
        Dim consentIsDbNull As Boolean = False
        Dim recoveryIsDbNull As Boolean = False
        For Each dispo As DispositionData In arData
            'ccarroll 10/19/2010 changed If to look for string length

            'if the value is not Yes then check for DNulls
            If dispositionData.Appropriate.ToString.Length > 0 Then
                'If dispositionData.Appropriate.ToString.Length > 0 Then
                If dispositionData.Appropriate <> 1 Then
                    If IsDBNull(dispo.Appropriate) And dispo.DonorCategoryID = dispositionData.DonorCategoryID Then
                        appropriateIsDbNull = True
                    End If
                End If
                'End If
            End If
            If dispositionData.Approach.ToString.Length > 0 Then
                'If dispositionData.Approach.ToString.Length > 0 Then
                If dispositionData.Approach <> 1 Then
                    If dispo.Appropriate.ToString.Length > 0 Then
                        If IsDBNull(dispo.Approach) And dispo.Appropriate = "1" And dispo.DonorCategoryID = dispositionData.DonorCategoryID Then
                            approachIsDbNull = True
                        End If
                    End If
                End If
                'End If
            End If
            If dispositionData.Consent.ToString.Length > 0 Then
                'If dispositionData.Consent.ToString.Length > 0 Then
                If dispositionData.Consent <> 1 Then
                    If dispo.Appropriate.ToString.Length > 0 And dispo.Approach.ToString.Length > 0 Then
                        If IsDBNull(dispo.Consent) And dispo.Appropriate = "1" And dispo.Approach = "1" And dispo.DonorCategoryID = dispositionData.DonorCategoryID Then
                            consentIsDbNull = True
                        End If
                    End If
                End If
                'End If
            End If
            If dispositionData.Recovery.ToString.Length > 0 Then
                'If dispositionData.Recovery.ToString.Length > 0 Then
                If dispositionData.Recovery <> 1 Then
                    If dispo.Appropriate.ToString.Length > 0 And dispo.Approach.ToString.Length > 0 And dispo.Consent.ToString.Length > 0 Then
                        If IsDBNull(dispo.Recovery) And dispo.Appropriate = "1" And dispo.Approach = "1" And dispo.Consent = "1" And dispo.DonorCategoryID = dispositionData.DonorCategoryID Then
                            recoveryIsDbNull = True
                        End If
                    End If
                End If
                'End If
            End If

            If appropriateIsDbNull And approachIsDbNull And consentIsDbNull And recoveryIsDbNull Then
                Exit For
            End If

        Next

        If appropriateIsDbNull Then
            dispositionData.Appropriate = -1
        End If
        If approachIsDbNull Then
            dispositionData.Approach = -1
        End If

        If consentIsDbNull Then
            dispositionData.Consent = -1
        End If

        If recoveryIsDbNull Then
            dispositionData.Recovery = -1
        End If
    End Sub
    ''' <summary>
    ''' Check each record in arData to determine if a DBNull exists. Do not include where value is yes
    ''' SubType
    ''' </summary>
    ''' <param name="dispositionData"></param>
    ''' <remarks></remarks>
    Private Sub CheckForDbNullSubType(ByVal dispositionData As DispositionData)
        If (dispositionData.SubTypeID.ToString.Length = 0) Then
            Return
        End If

        Dim appropriateIsDbNull As Boolean = False
        Dim approachIsDbNull As Boolean = False
        Dim consentIsDbNull As Boolean = False
        Dim recoveryIsDbNull As Boolean = False
        For Each dispo As DispositionData In arData
            'ccarroll 10/19/2010 changed If to look for string length

            If dispo.SubTypeID.ToString.Length > 0 Then

                'if the value is not Yes then check for DNulls
                If dispositionData.Appropriate <> 1 Then
                    If IsDBNull(dispo.Appropriate) And dispo.DonorCategoryID = dispositionData.DonorCategoryID And dispo.SubTypeID = dispositionData.SubTypeID Then
                        appropriateIsDbNull = True
                    End If
                End If

                If dispositionData.Approach <> 1 Then
                    If dispo.Appropriate.ToString.Length > 0 Then
                        If IsDBNull(dispo.Approach) And dispo.Appropriate = "1" And dispo.DonorCategoryID = dispositionData.DonorCategoryID And dispo.SubTypeID = dispositionData.SubTypeID Then
                            approachIsDbNull = True
                        End If
                    End If
                End If
                If dispositionData.Consent <> 1 Then
                    If dispo.Appropriate.ToString.Length > 0 And dispo.Approach.ToString.Length > 0 Then
                        If IsDBNull(dispo.Consent) And dispo.Appropriate = "1" And dispo.Approach = "1" And dispo.DonorCategoryID = dispositionData.DonorCategoryID And dispo.SubTypeID = dispositionData.SubTypeID Then
                            consentIsDbNull = True
                        End If
                    End If
                End If
                If dispositionData.Recovery <> 1 Then
                    If dispo.Appropriate.ToString.Length > 0 And dispo.Approach.ToString.Length > 0 And dispo.Consent.ToString.Length > 0 Then
                        If IsDBNull(dispo.Recovery) And dispo.Appropriate = "1" And dispo.Approach = "1" And dispo.Consent = "1" And dispo.DonorCategoryID = dispositionData.DonorCategoryID And dispo.SubTypeID = dispositionData.SubTypeID Then
                            recoveryIsDbNull = True
                        End If
                    End If
                End If
                If appropriateIsDbNull And approachIsDbNull And consentIsDbNull And recoveryIsDbNull Then
                    Exit For
                End If
            End If

        Next

        If appropriateIsDbNull Then
            dispositionData.Appropriate = -1
        End If
        If approachIsDbNull Then
            dispositionData.Approach = -1
        End If

        If consentIsDbNull Then
            dispositionData.Consent = -1
        End If

        If recoveryIsDbNull Then
            dispositionData.Recovery = -1
        End If
    End Sub

    ''' <summary>
    ''' Check each record in arData to determine if an Yes exists for each of the four status Appropriate, Approach, Consent and Recovery.
    ''' Organ
    ''' </summary>
    ''' <param name="dispositionData"></param>
    ''' <remarks></remarks>
    Private Sub CheckForYesOrgan(ByVal dispositionData As DispositionData)
        If (dispositionData.SubTypeID.ToString.Length = 0) Then
            Return
        End If

        Dim appropriateExists As Boolean = False
        Dim approachExists As Boolean = False
        Dim consentExists As Boolean = False
        Dim recoveryExists As Boolean = False
        For Each dispo As DispositionData In arData
            'ccarroll 10/19/2010 changed If to look for string length

            If dispo.Appropriate.ToString.Length > 0 Then
                'If dispo.Appropriate.ToString.Length > 0 Then
                If dispo.Appropriate = 1 And dispo.DonorCategoryID = dispositionData.DonorCategoryID Then
                    appropriateExists = True
                End If
                'End If
            End If
            If dispo.Approach.ToString.Length > 0 Then
                'If dispo.Approach.ToString.Length > 0 Then
                If dispo.Approach = 1 And dispo.DonorCategoryID = dispositionData.DonorCategoryID Then
                    approachExists = True
                End If
                'End If
            End If
            If dispo.Consent.ToString.Length > 0 Then
                'If dispo.Consent.ToString.Length > 0 Then
                If dispo.Consent = 1 And dispo.DonorCategoryID = dispositionData.DonorCategoryID Then
                    consentExists = True
                End If
                'End If
            End If
            If dispo.Recovery.ToString.Length > 0 Then
                'If dispo.Recovery.ToString.Length > 0 Then
                If dispo.Recovery = 1 And dispo.DonorCategoryID = dispositionData.DonorCategoryID Then
                    recoveryExists = True
                End If
                'End If
            End If

            If approachExists And appropriateExists And consentExists And recoveryExists Then
                Exit For
            End If

        Next

        If appropriateExists Then
            dispositionData.Appropriate = 1
        End If
        If approachExists Then
            dispositionData.Approach = 1
        End If

        If consentExists Then
            dispositionData.Consent = 1
        End If

        If recoveryExists Then
            dispositionData.Recovery = 1
        End If


    End Sub
    ''' <summary>
    ''' Check each record in arData to determine if an Yes exists for each of the four status Appropriate, Approach, Consent and Recovery.
    ''' SubType
    ''' </summary>
    ''' <param name="dispositionData"></param>
    ''' <remarks></remarks>
    Private Sub CheckForYesSubType(ByVal dispositionData As DispositionData)
        If (dispositionData.SubTypeID.ToString.Length = 0) Then
            Return
        End If
        If dispositionData.SubTypeID.ToString.Length = 0 Then
            Return
        End If
        Dim appropriateExists As Boolean = False
        Dim approachExists As Boolean = False
        Dim consentExists As Boolean = False
        Dim recoveryExists As Boolean = False
        'ccarroll 10/19/2010 changed If to look for string length
        'remove unused if statments

        For Each dispo As DispositionData In arData

            If dispo.SubTypeID.ToString.Length > 0 Then
                If dispo.Appropriate.ToString.Length > 0 Then
                    If dispo.Appropriate = 1 And dispo.DonorCategoryID = dispositionData.DonorCategoryID And dispo.SubTypeID = dispositionData.SubTypeID Then
                        appropriateExists = True
                    End If
                End If
                If dispo.Approach.ToString.Length > 0 Then
                    If dispo.Approach = 1 And dispo.DonorCategoryID = dispositionData.DonorCategoryID And dispo.SubTypeID = dispositionData.SubTypeID Then
                        approachExists = True
                    End If
                End If
                If dispo.Consent.ToString.Length > 0 Then
                    If dispo.Consent = 1 And dispo.DonorCategoryID = dispositionData.DonorCategoryID And dispo.SubTypeID = dispositionData.SubTypeID Then
                        consentExists = True
                    End If
                End If
                If dispo.Recovery.ToString.Length > 0 Then
                    If dispo.Recovery = 1 And dispo.DonorCategoryID = dispositionData.DonorCategoryID And dispo.SubTypeID = dispositionData.SubTypeID Then
                        recoveryExists = True
                    End If
                End If

                If approachExists And appropriateExists And consentExists And recoveryExists Then
                    Exit For
                End If
            End If

        Next

        If appropriateExists Then
            dispositionData.Appropriate = 1
        End If
        If approachExists Then
            dispositionData.Approach = 1
        End If

        If consentExists Then
            dispositionData.Consent = 1
        End If

        If recoveryExists Then
            dispositionData.Recovery = 1
        End If


    End Sub
    ''' <summary>
    ''' The distinct value arrays will be a reference to the orignial values if Array.CopyTo or the array is assigned to the new array.
    ''' Use CreateNewArray to build new arrays without the object reference.
    ''' </summary>
    ''' <param name="dispositionData"></param>
    ''' <param name="dispositionArray"></param>
    ''' <remarks></remarks>
    Private Sub CreateNewArray(ByVal dispositionData As DispositionData, ByRef dispositionArray As DispositionData())



        If arrayCounter > dispositionArray.Length - 1 Then
            Return
        End If
        Dim dispositionCopy As New DispositionData()

        For count As Integer = 0 To 22
            If count <> 15 Then
                dispositionCopy(count) = dispositionData(count)
            End If

        Next

        dispositionArray(arrayCounter) = dispositionCopy
        arrayCounter = arrayCounter + 1
    End Sub
    ''' <summary>
    ''' Used to disinguish between arDataDistinct and arDataDistinctOrgan
    ''' </summary>
    ''' <param name="dispositionData"></param>
    ''' <remarks></remarks>
    Private Sub CreatearDataDistinctNewArray(ByVal dispositionData As DispositionData)
        CreateNewArray(dispositionData, arDataDistinct)

    End Sub
    Private Sub CreatearDataDistinctOrganNewArray(ByVal dispositionData As DispositionData)
        CreateNewArray(dispositionData, arDataDistinctOrgan)
    End Sub

    ''' <summary>
    ''' used to set the Appropriate, Approach, Consent and Recovery values to -1.
    ''' </summary>
    ''' <param name="dispostionData"></param>
    ''' <remarks></remarks>
    Private Sub InitializeDispositionDataHeadersSubType(ByVal dispostionData As DispositionData)
        InitializeDispositionDataHeaders(dispostionData, True)
    End Sub
    Private Sub InitializeDispositionDataHeadersOrgan(ByVal dispostionData As DispositionData)
        InitializeDispositionDataHeaders(dispostionData, False)


    End Sub
    Private Sub InitializeDispositionDataHeaders(ByVal dispostionData As DispositionData, Optional ByVal setAppropriate As Boolean = True)
        If IsNothing(dispostionData) Then
            Return
        End If

        If setAppropriate Then
            dispostionData.Appropriate = 0
        End If

        dispostionData.Approach = 0
        dispostionData.Consent = 0
        dispostionData.Recovery = 0

    End Sub

#End Region


End Class

Public Class DispositionData
#Region "Class Fields"


    Private _CallId As Object
    Private _CriteriaId As Object
    Private _DonorCategoryId As Object
    Private _DonorCategory As Object

    Private _SubCriteriaId As Object
    Private _SubTypeId As Object
    Private _SubTypeName As Object
    Private _ProcessorID As Object
    Private _ProcessorName As Object

    Private _Appropriate As Object
    Private _Approach As Object
    Private _Consent As Object
    Private _Recovery As Object

    Private _SLAppropriate As Object
    Private _SLApproach As Object
    Private _SLConsent As Object
    Private _SLRecovery As Object

    Private _ARO As Object
    Private _CRO As Object
    Private _PRO As Object
    Private _ProcessorOrder As Object

    

#End Region
#Region "Class Properties"
    Default Public Property Item(ByVal index As Integer) As Object
        Get
            Select Case index
                Case SD_CallID
                    Return CallID
                Case SD_CriteriaID
                    Return CriteriaID
                Case SD_DonorCategoryID
                    Return DonorCategoryID
                Case SD_DonorCategory
                    Return DonorCategory
                Case SD_SubCriteriaID
                    Return SubCriteriaID
                Case SD_SubTypeID
                    Return SubTypeID
                Case SD_SubTypename
                    Return SubTypeName
                Case SD_ProcessorID
                    Return ProcessorID
                Case SD_btn1
                    Return ""
                Case SD_btn2
                    Return ""
                Case SD_ProcessorName
                    Return ProcessorName
                Case SD_Appropriate
                    Return Appropriate
                Case SD_Approach
                    Return Approach
                Case SD_Consent
                    Return Consent
                Case SD_Recovery
                    Return Recovery
                Case SD_Buffer
                    Return ""
                Case SD_SLAppropriate
                    Return SLAppropriate
                Case SD_SLApproach
                    Return SLApproach
                Case SD_SLConsent
                    Return SLConsent
                Case SD_SLRecovery
                    Return SLRecovery
                Case SD_ARO
                    Return ARO
                Case SD_CRO
                    Return CRO
                Case SD_PRO
                    Return PRO
                Case SD_ProcessorOrder
                    Return ProcessorOrder
                Case Else
                    Dim exceptionSting As String = String.Format("The index {0} does not exist or is out of bounds.", index)
                    Throw New Exception(exceptionSting)
            End Select


        End Get
        Set(ByVal value As Object)
            Select Case index
                Case SD_CallID
                    CallID = value
                Case SD_CriteriaID
                    CriteriaID = value
                Case SD_DonorCategoryID
                    DonorCategoryID = value
                Case SD_DonorCategory
                    DonorCategory = value
                Case SD_SubCriteriaID
                    SubCriteriaID = value
                Case SD_SubTypeID
                    SubTypeID = value
                Case SD_SubTypename
                    SubTypeName = value
                Case SD_ProcessorID
                    ProcessorID = value
                Case SD_btn1
                Case SD_btn2

                Case SD_ProcessorName
                    ProcessorName = value
                Case SD_Appropriate
                    Appropriate = value
                Case SD_Approach
                    Approach = value
                Case SD_Consent
                    Consent = value
                Case SD_Recovery
                    Recovery = value
                Case SD_SLAppropriate
                    SLAppropriate = value
                Case SD_SLApproach
                    SLApproach = value
                Case SD_SLConsent
                    SLConsent = value
                Case SD_SLRecovery
                    SLRecovery = value
                Case SD_ARO
                    ARO = value
                Case SD_CRO
                    CRO = value
                Case SD_PRO
                    PRO = value
                Case Else
                    Dim exceptionSting As String = String.Format("The index {0} does not exist or is out of bounds.", index)
                    Throw New Exception(exceptionSting)
            End Select
        End Set
    End Property

    Public Property PRO() As Object
        Get
            Return _PRO
        End Get
        Set(ByVal value As Object)
            _PRO = value
        End Set
    End Property

    Public Property CRO() As Object
        Get
            Return _CRO
        End Get
        Set(ByVal value As Object)
            _CRO = value
        End Set
    End Property

    Public Property ARO() As Object
        Get
            Return _ARO
        End Get
        Set(ByVal value As Object)
            _ARO = value
        End Set
    End Property

    Public Property SLRecovery() As Object
        Get
            Return _SLRecovery
        End Get
        Set(ByVal value As Object)
            _SLRecovery = value
        End Set
    End Property

    Public Property SLConsent() As Object
        Get
            Return _SLConsent
        End Get
        Set(ByVal value As Object)
            _SLConsent = value
        End Set
    End Property

    Public Property SLApproach() As Object
        Get
            Return _SLApproach
        End Get
        Set(ByVal value As Object)
            _SLApproach = value
        End Set
    End Property

    Public Property SLAppropriate() As Object
        Get
            Return _SLAppropriate
        End Get
        Set(ByVal value As Object)
            _SLAppropriate = value
        End Set
    End Property

    Public Property buffer() As Object
        Get
            Return ""
        End Get
        Set(ByVal value As Object)
        End Set
    End Property
    Public Property Recovery() As Object
        Get
            Return _Recovery
        End Get
        Set(ByVal value As Object)
            _Recovery = value
        End Set
    End Property

    Public Property Consent() As Object
        Get
            Return _Consent
        End Get
        Set(ByVal value As Object)
            _Consent = value
        End Set
    End Property

    Public Property Approach() As Object
        Get
            Return _Approach
        End Get
        Set(ByVal value As Object)
            _Approach = value
        End Set
    End Property

    Public Property Appropriate() As Object
        Get
            Return _Appropriate
        End Get
        Set(ByVal value As Object)
            _Appropriate = value
        End Set
    End Property

    Public Property ProcessorName() As Object
        Get
            Return _ProcessorName
        End Get
        Set(ByVal value As Object)
            _ProcessorName = value
        End Set
    End Property

    Public Property btnCriteria() As Object
        Get
            Return ""
        End Get
        Set(ByVal value As Object)
        End Set
    End Property
    Public Property btnStrike() As Object
        Get
            Return ""
        End Get
        Set(ByVal value As Object)

        End Set
    End Property
    Public Property ProcessorID() As Object
        Get
            Return _ProcessorID
        End Get
        Set(ByVal value As Object)
            _ProcessorID = value
        End Set
    End Property

    Public Property SubTypeName() As Object
        Get
            Return _SubTypeName
        End Get
        Set(ByVal value As Object)
            _SubTypeName = value
        End Set
    End Property

    Public Property SubTypeID() As Object
        Get
            Return _SubTypeId
        End Get
        Set(ByVal value As Object)
            _SubTypeId = value
        End Set
    End Property

    Public Property SubCriteriaID() As Object
        Get
            Return _SubCriteriaId
        End Get
        Set(ByVal value As Object)
            _SubCriteriaId = value
        End Set
    End Property

    Public Property DonorCategory() As Object
        Get
            Return _DonorCategory
        End Get
        Set(ByVal value As Object)
            _DonorCategory = value
        End Set
    End Property

    Public Property DonorCategoryID() As Object
        Get
            Return _DonorCategoryId
        End Get
        Set(ByVal value As Object)
            _DonorCategoryId = value
        End Set
    End Property

    Public Property CriteriaID() As Object
        Get
            Return _CriteriaId
        End Get
        Set(ByVal value As Object)
            _CriteriaId = value
        End Set
    End Property

    Public Property CallID() As Object
        Get
            Return _CallId
        End Get
        Set(ByVal value As Object)
            _CallId = value
        End Set
    End Property

    Public Property ProcessorOrder() As Object
        Get
            Return _ProcessorOrder
        End Get
        Set(ByVal value As Object)
            _ProcessorOrder = value
        End Set
    End Property

#End Region
End Class
Public Class GroupByDonorCategoryID
    Implements IGroupByEvaluator
    Implements IGroupByEvaluatorEx

#Region "IGroupByEvaluator"
    ''' <summary>
    ''' Gets the Group By Value
    ''' </summary>
    ''' <param name="groupByRow"></param>
    ''' <param name="row"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public Function GetGroupByValue(ByVal groupByRow As UltraGridGroupByRow, ByVal row As UltraGridRow) As Object Implements IGroupByEvaluator.GetGroupByValue
        Dim val As String

        ' Get the default value from the groupbyRow. 
        If groupByRow.Value Is Nothing Then
            val = ""
        Else
            val = groupByRow.Value.ToString()
        End If

        Return val
    End Function
    ''' <summary>
    ''' Determines if current Rows has the same group value
    ''' </summary>
    ''' <param name="groupByRow"></param>
    ''' <param name="row"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public Function DoesGroupContainRow(ByVal groupByRow As UltraGridGroupByRow, ByVal row As UltraGridRow) As Boolean Implements IGroupByEvaluator.DoesGroupContainRow

        Dim compareResult As Boolean = False

        compareResult = String.Equals(groupByRow.Value.ToString(), row.Cells(groupByRow.Column).Value.ToString())

        Return compareResult
    End Function



#End Region
#Region "IGroupByEvaluatorEx"
    ''' <summary>
    ''' Determines Sort order of groups
    ''' </summary>
    ''' <param name="cell1"></param>
    ''' <param name="cell2"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public Function Compare(ByVal cell1 As UltraGridCell, ByVal cell2 As UltraGridCell) As Integer Implements IGroupByEvaluatorEx.Compare
        Dim compareResult As Integer = 0
        Select Case cell2.Column.Key
            Case "DonorCategory"

                compareResult = cell1.Row.Cells("DonorCategoryID").Value.ToString().CompareTo(cell2.Row.Cells("DonorCategoryID").Value.ToString())
            Case "SubTypeName"
                compareResult = cell1.Row.Cells("SubTypeID").Value.ToString().CompareTo(cell2.Row.Cells("SubTypeID").Value.ToString())
            Case "ProcessorOrder"
                compareResult = cell1.Row.Cells("ProcessorOrder").Value.ToString().CompareTo(cell2.Row.Cells("ProcessorOrder").Value.ToString())
        End Select
        Return compareResult
    End Function
#End Region
    
End Class
Public Class DispositionDataDistinctOrganComparer
    Implements IEqualityComparer(Of DispositionData)

    Public Function Equals1(ByVal x As DispositionData, ByVal y As DispositionData) As Boolean Implements System.Collections.Generic.IEqualityComparer(Of DispositionData).Equals
        ' Check whether the compared objects reference the same data.
        If x Is y Then Return True

        'Check whether any of the compared objects is null.
        If x Is Nothing OrElse y Is Nothing Then Return False

        ' Check whether the products' properties are equal.
        Return (x.DonorCategoryID = y.DonorCategoryID)
    End Function

    Public Function GetHashCode1(ByVal dispositionData As DispositionData) As Integer Implements System.Collections.Generic.IEqualityComparer(Of DispositionData).GetHashCode
        ' Check whether the object is null.
        If dispositionData Is Nothing Then Return 0

        ' Get hash code for the DonorCategoryID field if it is not null.
        Dim hashDonorCategoryID As Int64 = If(dispositionData.DonorCategoryID Is Nothing, 0, dispositionData.DonorCategoryID.GetHashCode())


        ' Calculate the hash code for the product.
        Return hashDonorCategoryID

    End Function
End Class
Public Class DispositionDataDistinctOrganSubTypeComparer
    Implements IEqualityComparer(Of DispositionData)

    Public Function Equals1(ByVal x As DispositionData, ByVal y As DispositionData) As Boolean Implements System.Collections.Generic.IEqualityComparer(Of DispositionData).Equals
        ' Check whether the compared objects reference the same data.
        If x Is y Then Return True

        'Check whether any of the compared objects is null.
        If x Is Nothing OrElse y Is Nothing Then Return False

        ' Check whether the products' properties are equal.
        Return (x.DonorCategoryID = y.DonorCategoryID And x.SubTypeID = y.SubTypeID)
    End Function

    Public Function GetHashCode1(ByVal dispositionData As DispositionData) As Integer Implements System.Collections.Generic.IEqualityComparer(Of DispositionData).GetHashCode
        ' Check whether the object is null.
        If dispositionData Is Nothing Then Return 0

        ' Get hash code for the DonorCategoryID field if it is not null.
        Dim hashDonorCategoryID = If(dispositionData.DonorCategoryID Is Nothing, 0, dispositionData.DonorCategoryID.GetHashCode())

        ' Get hash code for the Code field.
        Dim hashSubTypeID = dispositionData.SubTypeID.GetHashCode()

        ' Calculate the hash code for the product.
        Return hashDonorCategoryID Xor hashSubTypeID
    End Function
End Class
