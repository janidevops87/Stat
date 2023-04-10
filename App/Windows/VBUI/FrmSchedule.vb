Option Strict Off
Option Explicit On

Imports VB = Microsoft.VisualBasic
Imports System.Drawing.Text
Imports System.Xml
Imports Statline.Stattrac.Windows.CSharpUIMap
Imports Statline.Stattrac.Common
Imports Statline.Stattrac.Constant
Imports Statline.Stattrac.Data.Types
Imports Statline.Stattrac.BusinessRules.Schedule
Imports Statline.Stattrac.BusinessRules.Framework
Imports Infragistics.Win.UltraWinGrid
Imports Statline.Stattrac.Data.Types.Framework


Public Class FrmSchedule
    Inherits System.Windows.Forms.Form

    Public FormState As Short
    Public OrganizationId As Integer
    Public OrganizationName As String
    Public ScheduleGroupID As Integer
    Public CurrentMonth As Short
    Public CurrentYear As Object
    Public CurrentDate As Date
    Public GetScheduleFlag As Boolean
    Public Saved As Short
    Public Loaded As Short

    Public AvailableGridList As Object
    Public AvailableSortOrder As Short
    Public SelectedGridList As Object
    Public SelectedSortOrder As Short
    Public ShiftSortOrder As Short

    Public AvailablePersonList As Object
    Public AvailablePersonSortOrder As Short
    Public SelectedPersonList As Object
    Public SelectedPersonSortOrder As Short
    Public SelectedPersonComboList As String

    Public pvfieldfocus As String

    Public PreviousValue As Object

    Public SourceCodes As New colSourceCodes

    Public ShiftList As Object
    Public SelectedShift As Object
    Public SelectedRow As Object
    Public SelectedBlock As Object
    Public TopRow As Object

    Public ComboSearchString As String
    Private frmScheduleShift As FrmScheduleShift
    Private frmScheduleShiftItem As FrmScheduleShiftItem
    Private frmScheduleSplitShift As FrmScheduleSplitShift
    'bret 02/01/11 
    Private uIMap As UIMap

    'ccarroll 06/13/2011
    Private sourceCodeId As Integer
    Private sourceCodeName As String
    Private sourceCodeCallTypeId As Integer
    Private sourceCodeCallTypeName As String

    Private frmScheduleGroup As FrmScheduleGroup
    '04/2010 Bret
    Const TABSCHEDULE_CALLSCHEDULE As Integer = 0
    Const TABSCHEDULE_ONCALLFOR As Integer = 1
    Const TABSCHEDULE_SHIFTS As Integer = 2
    Const TABSCHEDULE_ONCALLNOTES As Integer = 3
    Const TABSCHEDULE_SOURCECODES As Integer = 4
    Const TABSCHEDULE_SCHEDULE As Integer = 5
    Const TABSCHEDULE_SCHEDULELOG As Integer = 6
    Const TABSCHEDULE_SCHEDULESPEOPLE As Integer = 7
    Public RTF As New clsRTF
    Private tabScheduleTable As Hashtable
    Private scheduleLogBR As ScheduleLogBR
    Private scheduleBR As ScheduleBR
    Private schedulePeopleBR As ListControlBR
    Private grConstant As GeneralConstant

    Private Sub CreateComboBoxList()

        On Error Resume Next

        Dim I As Short

        'Take the selected person array and delimit into a sting which will be used by the
        'a column's combo box list setting

        'Define the string as multi-column list
        SelectedPersonComboList = "|"

        'Define the first column as hidden and the second as primary
        SelectedPersonComboList = SelectedPersonComboList & "H|*" & ControlChars.Tab

        'Loop through the selected person array to create the list of delimited data
        For I = 0 To UBound(SelectedPersonList)
            SelectedPersonComboList = SelectedPersonComboList & SelectedPersonList(I, 0) & "|" & SelectedPersonList(I, 1) & ControlChars.Tab
        Next I


    End Sub
    Private Sub CboMonth_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboMonth.SelectedIndexChanged

        Call Me.ClearAll()

        If Me.Loaded = True Then

            Call Me.GetSchedule()

        End If

    End Sub

    Private Sub CboOrganization_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboOrganization.SelectedIndexChanged

        Dim vReturn As New Object
        Dim vResult As Short

        'Get the ID of the selected location
        Me.OrganizationId = modControl.GetID(CboOrganization)

        'Clear the schedule and on call for lists.
        Call Me.ClearAll()
        TxtReferralNotes.Text = ""
        TxtMessageNotes.Text = ""

        'Fill the schedule group list
        CboScheduleGroup.Items.Clear()
        vResult = modStatRefQuery.RefQueryScheduleGroup(vReturn, , , Me.OrganizationId)
        Call modControl.SetTextID(CboScheduleGroup, vReturn)

        'If there is only one schedule group, then selected it
        If vResult = SUCCESS Then
            If UBound(vReturn) = 0 Then
                Call modControl.SelectFirst(CboScheduleGroup)
            End If
        End If

        'Get the organization notes
        Call modStatQuery.QueryOrganizationProperties(Me)

    End Sub



    Private Sub CboOrganization_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles CboOrganization.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        'Allow the delete key to clear the combo box
        Call modControl.AllowDelete(CboOrganization, KeyAscii)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub CboScheduleGroup_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboScheduleGroup.SelectedIndexChanged

        On Error Resume Next

        Call Me.ClearAll()

        'Get the ID of the selected location
        ScheduleGroupID = modControl.GetID(CboScheduleGroup)

        If Me.ScheduleGroupID = -1 Then
            CmdSelect.Enabled = False
            CmdSelectPerson.Enabled = False
            CmdDeselect.Enabled = False
            CmdDeselectPerson.Enabled = False
            CmdAdd.Enabled = False
            CmdEdit.Enabled = False
            CmdRemove.Enabled = False
            CmdRefresh.Enabled = False
        Else
            CmdSelect.Enabled = True
            CmdSelectPerson.Enabled = True
            CmdDeselect.Enabled = True
            CmdDeselectPerson.Enabled = True
            CmdAdd.Enabled = True
            CmdEdit.Enabled = True
            CmdRemove.Enabled = True
            CmdRefresh.Enabled = True
        End If

        Call Me.GetSchedule()

    End Sub

    Private Sub CboScheduleGroup_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles CboScheduleGroup.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        'Allow the delete key to clear the combo box
        Call modControl.AllowDelete(CboScheduleGroup, KeyAscii)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub CboState_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles CboState.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        'Allow the delete key to clear the combo box
        Call modControl.AllowDelete(CboState, KeyAscii)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub CboYear_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboYear.SelectedIndexChanged

        Call Me.ClearAll()

        If Me.Loaded = True Then

            Call Me.GetSchedule()

        End If

    End Sub

    Private Sub ChkActive_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkActive.CheckStateChanged

        If ChkActive.CheckState = System.Windows.Forms.CheckState.Checked Then
            CmdRefresh.Enabled = False
            CmdRefresh.Text = "Use New Schedule"
            'TabSchedule.Tab = 5
        Else
            CmdRefresh.Enabled = True
            CmdRefresh.Text = "&Get Schedule"
            'TabSchedule.Tab = 0
        End If

    End Sub

    Private Sub CmdAdd_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdAdd.Click

        Dim vScheduleShiftID As Integer
        Dim vReturn() As String

        On Error Resume Next

        'Determine the state which to open the
        'form.
        frmScheduleShift = New FrmScheduleShift
        frmScheduleShift.FormState = NEW_RECORD
        frmScheduleShift.ScheduleShiftID = 0

        'Set the organization id
        frmScheduleShift.ScheduleGroupID = Me.ScheduleGroupID

        'Get the ScheduleShift id from the ScheduleShift form
        'after the user is done.
        vScheduleShiftID = frmScheduleShift.Display

        If vScheduleShiftID = 0 Then
            'The user cancelled adding a new ScheduleShift
            'so do nothing
        Else
            'Remove the current list
            LstViewShifts.Items.Clear()
            LstViewShifts.View = View.Details
            'Refill the grid with the new (or updated) data
            Call modStatQuery.QueryScheduleShifts(Me)
        End If

        CmdAdd.Focus()

    End Sub

    Private Sub CmdAddPerson_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdAddPerson.Click

        'make sure grConstant isn't nothing and we have at least one band available
        If grConstant IsNot Nothing AndAlso ugSchedule.DisplayLayout.Bands.Count > grConstant.FirstRow Then

            'check columns Person6 through Person18 find the first Hidden column and show it. 
            For columnNumber As Integer = 6 To 18
                Dim columnName As String = "Person" + columnNumber.ToString()
                If (ugSchedule.DisplayLayout.Bands(0).Columns(columnName).Hidden) Then
                    ugSchedule.DisplayLayout.Bands(0).Columns(columnName).Hidden = False
                    Exit For
                End If
            Next

        End If

    End Sub

    Private Sub CmdAddSource_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdAddSource.Click

        If uIMap Is Nothing Then
            uIMap = OpenStatTracCSharpForms.CreateInstance()
        End If

        'ccarroll 06/13/2011 
        'Get SourceCode selection from SourceCode Popup
        Me.sourceCodeId = uIMap.Open(AppScreenType.AdministrationSourceCodeEditPopup, Me.sourceCodeCallTypeId)
        Me.sourceCodeName = GeneralConstant.CreateInstance().SourceCodeName
        Me.sourceCodeCallTypeName = GeneralConstant.CreateInstance().SourceCodeCallTypeName

        'Reset value
        If IsNothing(SourceCodes) Then
            SourceCodes = New colSourceCodes()
        End If

        Dim newSourceCode As clsSourceCode = New clsSourceCode()

        'Define new SourceCode properties
        newSourceCode.ID = Me.sourceCodeId
        newSourceCode.Key = "k" & Me.sourceCodeId
        newSourceCode.Name = Me.sourceCodeName
        newSourceCode.CodeTypeName = Me.sourceCodeCallTypeName

        'Add new SourceCode item
        SourceCodes.AddItem(newSourceCode)

        Call SourceCodes.FillListView2(LstViewSourceCodes)

        Call modStatSave.SaveScheduleGroupSourceCodes(Me)

    End Sub

    Private Sub cmdCancel_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdCancel.Click

        Me.Close()

    End Sub


    Private Sub CmdCreateShift_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdCreateShift.Click

        Dim ScheduleItemID As Integer
        Dim LastRow As Short

        'Set ids
        frmScheduleShiftItem = New FrmScheduleShiftItem
        frmScheduleShiftItem.InsertShift = False
        frmScheduleShiftItem.FormState = NEW_RECORD
        frmScheduleShiftItem.ScheduleItemID = 0
        frmScheduleShiftItem.ScheduleGroupID = Me.ScheduleGroupID

        'Set the date defaults
        '-- First Get the last row to determine the Default ShiftName from it
        InitializeScheduleBR()

        InitializeScheduleDS()

        'If the selected row is not a shift gap, then default the start date
        'as the end date of the last row
        If ScheduleDS.Schedule.Rows.Count > 0 Then
            frmScheduleShiftItem.DefaultShiftName = ScheduleDS.Schedule.Last.ScheduleItemName.ToString()
            If Not ugSchedule.ActiveRow().CellAppearance.ForeColor = Drawing.Color.Red Then
                'the currently selected row is not red so grab the last row
                Dim lastEndDateTime As DateTime = DateTime.Parse(ugSchedule.Rows.Last.Cells(ScheduleDS.Schedule.ScheduleEndDateTimeColumn.ColumnName.ToString()).Value)
                frmScheduleShiftItem.DefaultStartDate = lastEndDateTime.ToString("MM/dd/yyyy")
                frmScheduleShiftItem.DefaultStartTime = lastEndDateTime.ToString("HH:mm")
                frmScheduleShiftItem.DefaultEndDate = lastEndDateTime.AddDays(1).ToString("MM/dd/yyyy")
                frmScheduleShiftItem.DefaultEndTime = lastEndDateTime.ToString("HH:mm")

            Else
                'If the selected row is a shift gap (forecolor = red), then default the gap's range
                'Determine if the gap is before or after the current row
                Dim firstSelectedRow As Integer = 0
                Dim lastSelectedRow As Integer = 0
                Dim testIndex As Integer = ugSchedule.ActiveRow.Index - 1

                If testIndex < 0 Then
                    testIndex = 0
                End If

                If ugSchedule.Rows(testIndex).CellAppearance.ForeColor = Drawing.Color.Red Then
                    'The gap is before so default the appropriate dates
                    lastSelectedRow = ugSchedule.ActiveRow.Index
                    firstSelectedRow = lastSelectedRow - 1

                Else
                    'The gap is after so default the appropriate dates
                    firstSelectedRow = ugSchedule.ActiveRow.Index
                    lastSelectedRow = firstSelectedRow + 1
                End If
                testIndex = firstSelectedRow
                If testIndex < 0 Then
                    firstSelectedRow = firstSelectedRow + 1
                    lastSelectedRow = firstSelectedRow + 1

                End If
                Dim firstSelectedDatetime As DateTime = ugSchedule.Rows(firstSelectedRow).Cells(ScheduleDS.Schedule.ScheduleEndDateTimeColumn.ColumnName.ToString()).Value
                Dim lastSelectedDateTime As DateTime = ugSchedule.Rows(lastSelectedRow).Cells(ScheduleDS.Schedule.ScheduleStartDateTimeColumn.ColumnName.ToString()).Value
                frmScheduleShiftItem.DefaultStartDate = firstSelectedDatetime.ToString("MM/dd/yyyy")
                frmScheduleShiftItem.DefaultStartTime = firstSelectedDatetime.ToString("HH:mm")
                frmScheduleShiftItem.DefaultEndDate = lastSelectedDateTime.ToString("MM/dd/yyyy")
                frmScheduleShiftItem.DefaultEndTime = lastSelectedDateTime.ToString("HH:mm")
            End If
        End If

        'Get the ScheduleShift id from the ScheduleShift form
        'after the user is done.
        If AppMain.frmSchedule Is Nothing Then
            AppMain.frmSchedule = Me
        End If
        ScheduleItemID = frmScheduleShiftItem.Display


    End Sub

    Private Sub CmdDeselect_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdDeselect.Click

        On Error Resume Next

        Dim vReturn As New Object

        Call modUtility.Work()

        Call modControl.GetSelListViewID(LstViewSelectedOrganizations, vReturn)

        If IsNothing(vReturn) Then
            Call modUtility.Done()
            Exit Sub
        End If

        'Remove each of the selected rows
        Call modStatSave.DeleteScheduleReferralOrganizations(vReturn)

        'Remove the current list
        LstViewSelectedOrganizations.Items.Clear()
        LstViewSelectedOrganizations.View = View.Details

        'Refill the selected organizations list
        Call modStatQuery.QueryScheduleReferralOrganization(Me)

        Call modUtility.Done()

    End Sub

    Private Sub CmdDeselectPerson_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdDeselectPerson.Click

        On Error Resume Next

        Dim vReturn As New Object
        Dim I As Short

        Call modUtility.Work()

        Call modControl.GetSelListViewID(LstViewSelectedPerson, vReturn)

        If Not (TypeOf vReturn Is Array) Then
            Call modUtility.Done()
            Exit Sub
        End If

        'Remove each of the selected rows
        Call modStatSave.DeleteSchedulePerson(vReturn, ScheduleGroupID)

        'Remove the current list
        LstViewSelectedPerson.Items.Clear()
        LstViewSelectedPerson.View = View.Details

        'Refill the selected list
        If modStatQuery.QuerySchedulePerson(ScheduleGroupID, vReturn) = SUCCESS Then

            Call modControl.SetListViewRows(vReturn, True, LstViewSelectedPerson, False)
            SelectedPersonList = vReturn
            LoadGridSchedulePeople()

        End If

        Call modUtility.Done()

    End Sub

    Private Sub CmdEdit_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdEdit.Click

        Dim vScheduleShiftID As Integer
        Dim vReturn As Object

        On Error Resume Next

        'Determine the state which to open the
        'form.
        frmScheduleShift = New FrmScheduleShift
        frmScheduleShift.FormState = EXISTING_RECORD
        frmScheduleShift.ScheduleShiftID = modConv.TextToLng(LstViewShifts.FocusedItem.Tag)

        If frmScheduleShift.ScheduleShiftID = 0 Then
            Exit Sub
        End If

        'Set the organization id
        frmScheduleShift.ScheduleGroupID = Me.ScheduleGroupID

        'Get the ScheduleShift id from the ScheduleShift form
        'after the user is done.
        vScheduleShiftID = frmScheduleShift.Display

        If vScheduleShiftID = 0 Then
            'The user cancelled adding a new ScheduleShift
            'so do nothing
        Else
            'Remove the current list
            LstViewShifts.Items.Clear()
            LstViewShifts.View = View.Details
            'Refill the grid with the new (or updated) data
            Call modStatQuery.QueryScheduleShifts(Me)
        End If

        CmdEdit.Focus()
    End Sub


    Private Sub CmdEditShift_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdEditShift.Click

        Dim ScheduleItemID As Integer

        'Check if a row is selected
        If ugSchedule.ActiveRow Is Nothing Then
            Exit Sub
        End If

        'Set ids
        frmScheduleShiftItem = New FrmScheduleShiftItem
        frmScheduleShiftItem.FormState = EXISTING_RECORD
        frmScheduleShiftItem.ScheduleItemID = ugSchedule.ActiveRow.Cells(ScheduleDS.Schedule.ScheduleItemIDColumn.ColumnName).Value
        frmScheduleShiftItem.ScheduleGroupID = Me.ScheduleGroupID
        frmScheduleShiftItem.Height = 148 'VB6.TwipsToPixelsY(2220)
        frmScheduleShiftItem.CmdCancel.Top = 96 'VB6.TwipsToPixelsY(1440)

        frmScheduleShiftItem.DefaultShiftName = ugSchedule.ActiveRow.Cells(ScheduleDS.Schedule.ScheduleItemNameColumn.ToString()).Value

        'the currently selected row is not red so grab the last row
        Dim startDateTime As DateTime = DateTime.Parse(ugSchedule.ActiveRow.Cells(ScheduleDS.Schedule.ScheduleStartDateTimeColumn.ColumnName.ToString()).Value)
        Dim endDateTime As DateTime = DateTime.Parse(ugSchedule.ActiveRow.Cells(ScheduleDS.Schedule.ScheduleEndDateTimeColumn.ColumnName.ToString()).Value)
        frmScheduleShiftItem.DefaultStartDate = startDateTime.ToString("MM/dd/yyyy")
        frmScheduleShiftItem.DefaultStartTime = startDateTime.ToString("HH:mm")
        frmScheduleShiftItem.DefaultEndDate = endDateTime.AddDays(1).ToString("MM/dd/yyyy")
        frmScheduleShiftItem.DefaultEndTime = endDateTime.ToString("HH:mm")

        'Get the ScheduleShift id from the ScheduleShift form
        'after the user is done.
        ScheduleItemID = frmScheduleShiftItem.Display

        If ScheduleItemID = 0 Then
            'The user cancelled adding a new ScheduleShift
            'so do nothing
        Else
            'Reset the current list
            CmdGetSchedule_Click(CmdGetSchedule, New System.EventArgs())

            SetFirstActiveRow()

        End If

    End Sub

    Private Sub CmdFind_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdFind.Click

        Call modUtility.Work()

        'Clear the grid
        LstViewAvailableOrganizations.Items.Clear()
        LstViewAvailableOrganizations.View = View.Details

        'Fill Grid
        Call modStatQuery.QueryOpenOrganization(Me)

        Call modUtility.Done()

    End Sub

    Private Sub CmdGetSchedule_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdGetSchedule.Click
        Call modUtility.Work()

        InitializeScheduleBR()
        If grConstant Is Nothing Then
            grConstant = GeneralConstant.CreateInstance()
        End If
        Dim vTimeZoneDif As Short

        ''ccarroll 10/07/2008 ScheduleLock
        ''If Schedule is locked. Exit
        If modStatSave.UpdateScheduleLock(Me, False) = 1 Then
            Call modUtility.Done()
            Exit Sub
        End If

        'Get the users timezone
        vTimeZoneDif = modStatQuery.QueryTimeZoneDif(AppMain.ParentForm.TimeZone)

        'set the default paramaters for the scheduleBR
        scheduleBR.ScheduleGroupID = ScheduleGroupID
        scheduleBR.FromDate = DateTime.Parse(CboFromDate.Value)
        scheduleBR.ToDate = DateTime.Parse(CboToDate.Value)
        scheduleBR.TimeZoneDif = vTimeZoneDif

        'set the grids data source
        ugSchedule.DataSource = scheduleBR.AssociatedDataSet

        LoadGridSchedulePeople()


        '-- load the data
        Try
            scheduleBR.SelectDataSet()
        Catch ex As Exception
            modError.LogError("FrmSchedule.CmdRefresh_Click " & ex.Message)

        End Try


        'check columns 6 through 18 if any value is not null set column to visible
        ScheduleDS = CType(scheduleBR.AssociatedDataSet, Schedule.ScheduleDS)

        For loopCount As Integer = 6 To 18
            Dim columnName As String = "Person" + loopCount.ToString()
            Dim makeVisible As Boolean = ScheduleDS.Schedule.ToList().Any(Function(schedule) (schedule(columnName) IsNot DBNull.Value))
            If makeVisible Then
                ugSchedule.DisplayLayout.Bands(grConstant.FirstRow).Columns(columnName).Hidden = False
            Else
                ugSchedule.DisplayLayout.Bands(grConstant.FirstRow).Columns(columnName).Hidden = True
            End If
        Next

        If ScheduleDS.Schedule.Count = 0 Then
            Call MsgBox("There are no schedule items for the dates selected.", MsgBoxStyle.OkOnly, "No Schedule Items")
            Call modUtility.Done()
        Else
            'Check for gaps and identify
            Call FlagGaps()

            'Select a row if available
            If TypeOf SelectedShift Is Infragistics.Win.UltraWinGrid.UltraGridRow Then
                Dim currentRow As Infragistics.Win.UltraWinGrid.UltraGridRow
                currentRow = ugSchedule.Rows.FirstOrDefault(Function(row) row.Equals(CType(SelectedShift, UltraGridRow)))
                If currentRow IsNot Nothing Then
                    currentRow.Activate()
                End If

            End If
        End If


        Call modUtility.Done()

    End Sub

    Private Sub CmdInsertShift_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdInsertShift.Click

        On Error Resume Next

        Dim ScheduleItemID As Integer

        'Check if a row is selected
        'If GrdSchedule.RowSet.GetSelect(-1) < 0 Then
        '    Exit Sub
        'End If

        'Set ids
        frmScheduleShiftItem = New FrmScheduleShiftItem
        frmScheduleShiftItem.InsertShift = True
        frmScheduleShiftItem.FormState = EXISTING_RECORD
        frmScheduleShiftItem.ScheduleItemID = Me.SelectedShift
        frmScheduleShiftItem.ScheduleGroupID = Me.ScheduleGroupID
        frmScheduleShiftItem.Height = VB6.TwipsToPixelsY(2220)
        frmScheduleShiftItem.CmdCancel.Top = VB6.TwipsToPixelsY(1440)

        'Get the ScheduleShift id from the ScheduleShift form
        'after the user is done.
        ScheduleItemID = frmScheduleShiftItem.Display

        If ScheduleItemID = 0 Then
            'The user cancelled adding a new ScheduleShift
            'so do nothing
        Else

            'Make changes to the people assigned to the shift
            'If a shift is inserted, copy people from the shift being modified to the new shift
            'created on the other side of the shift being inserted
            Call modStatSave.SaveScheduleCopyShiftPerson(Me.SelectedShift, ScheduleItemID)

            'Reset the current list
            CmdGetSchedule_Click(CmdGetSchedule, New System.EventArgs())

            SetFirstActiveRow()

        End If

    End Sub


    Private Sub cmdOK_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdOK.Click

        Dim vReturn As Short

        'Make sure the user wants to save
        vReturn = modMsgForm.FormSave

        If vReturn = MsgBoxResult.Cancel Then
            Exit Sub
        End If

        'Validate the data
        If Not modStatValidate.Schedule(Me) Then
            Exit Sub
        End If

        Call modUtility.Work()

        'Save the Schedule
        SaveSchedule()
        modStatSave.SaveScheduleGroupNotes(Me)
        modStatSave.SaveOrganizationProperties(Me)
        Me.Saved = True


        'ccarroll 10/08/2008 StatTrac release 8.4.7
        'Remove ScheduleLock
        modStatSave.UpdateScheduleLock(Me, True)

        'Make sure the user wants to close
        vReturn = modMsgForm.FormClose

        If vReturn = MsgBoxResult.No Then
            Me.FormState = EXISTING_RECORD
        Else
            Me.Close()
        End If

        Call modUtility.Done()

    End Sub



    Private Sub CmdPrintList_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdPrintList.Click


    End Sub

    Private Sub CmdRefresh_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdRefresh.Click

    End Sub

    Private Sub CmdRefreshLog_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdRefreshLog.Click

        'On Error Resume Next
        Dim vTimeZoneDif As Short

        vTimeZoneDif = modStatQuery.QueryTimeZoneDif(AppMain.ParentForm.TimeZone)

        If scheduleLogBR Is Nothing Then
            scheduleLogBR = New ScheduleLogBR()
        End If

        scheduleLogBR.ScheduleGroupID = ScheduleGroupID
        scheduleLogBR.FromDate = DateTime.Parse(CboLogFromDate.Value.ToString())
        scheduleLogBR.ToDate = DateTime.Parse(CboLogToDate.Value.ToString()).AddHours(23).AddMinutes(59)
        scheduleLogBR.TimeZoneDif = vTimeZoneDif

        Call modUtility.Work()
        ugScheduleLog.DataSource = scheduleLogBR.AssociatedDataSet
        Try
            scheduleLogBR.SelectDataSet()
        Catch ex As Exception
            modError.LogError("FrmSchedule.CmdRefresh_Click " & ex.Message)

        End Try

        Call modUtility.Done()

    End Sub

    Private Sub CmdRemove_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdRemove.Click

        Dim vReturn As New Object

        Call modUtility.Work()

        Call modControl.GetSelListViewID(LstViewShifts, vReturn)

        If IsNothing(vReturn) Then
            Call modUtility.Done()
            Exit Sub
        End If

        'Remove each of the selected rows
        Call modStatSave.DeleteScheduleShift(vReturn)

        'Remove the current list
        LstViewShifts.Items.Clear()
        LstViewShifts.View = View.Details

        'Refill the selected organizations list
        Call modStatQuery.QueryScheduleShifts(Me)

        Call modUtility.Done()

    End Sub

    Private Sub CmdRemoveShift_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdRemoveShift.Click

        On Error Resume Next

        Dim ScheduleItemID As Integer
        Dim SelectRow As Short
        Dim vTimeZoneDif As Short 'BJK add for time conversion 6.2x

        vTimeZoneDif = modStatQuery.QueryTimeZoneDif(AppMain.ParentForm.TimeZone) 'BJK add for time conversion 6.2x


        'Check if a row is selected
        If ugSchedule.Selected.Rows.Count < 1 Then
            Exit Sub
        End If

        If MsgBox("You are about to delete the selected shift(s)! Are you sure?", MsgBoxStyle.OkCancel + MsgBoxStyle.Exclamation + MsgBoxStyle.DefaultButton2, "Delete Shift") = MsgBoxResult.Ok Then

            For Each row As UltraGridRow In ugSchedule.Rows.ToList().Where(Function(rowCheck) rowCheck.Selected())
                'TODO: Confirm this is working .
                Call Me.ScheduleLog("Delete Shift", CDate(row.Cells(ScheduleDS.Schedule.ScheduleItemStartDateColumn.ColumnName).Value).AddHours(-vTimeZoneDif).ToString("mm/dd/yyyy HH:mm ddd") & " " & CDate(row.Cells(ScheduleDS.Schedule.ScheduleItemStartDateColumn.ColumnName).Value).AddHours(-vTimeZoneDif).ToString("mm/dd/yyyy HH:mm ddd"), "Deleted shift.")

                row.Delete()
            Next

            scheduleBR.SaveDataSet()

            'Reset the current list
            CmdGetSchedule_Click(CmdGetSchedule, New System.EventArgs())

            SetFirstActiveRow()
        End If

    End Sub

    Private Sub CmdRemoveSource_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdRemoveSource.Click

        If Me.LstViewSourceCodes.Items.Count > 0 Then

            Call SourceCodes.Remove(Me.LstViewSourceCodes.FocusedItem.Tag)

            Call SourceCodes.FillListView2(LstViewSourceCodes)

            Call modStatSave.SaveScheduleGroupSourceCodes(Me)

        End If

    End Sub

    Private Sub CmdScheduleDetail_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdScheduleDetail.Click


        Dim vScheduleGroupID As Integer
        'Dim vReturn() As String
        Dim vReturn As New Object
        On Error Resume Next

        'Determine the state which to open the
        'form.
        frmScheduleGroup = New FrmScheduleGroup
        If modControl.GetID(CboScheduleGroup) = -1 Then
            frmScheduleGroup.FormState = NEW_RECORD
            frmScheduleGroup.ScheduleGroupID = 0
        Else
            frmScheduleGroup.FormState = EXISTING_RECORD
            frmScheduleGroup.ScheduleGroupID = modControl.GetID(CboScheduleGroup)
        End If

        'Set the organization id
        frmScheduleGroup.OrganizationId = Me.OrganizationId

        'Get the ScheduleGroup id from the ScheduleGroup form
        'after the user is done.
        vScheduleGroupID = frmScheduleGroup.Display

        If vScheduleGroupID = 0 Then
            'The user cancelled adding a new ScheduleGroup
            'so do nothing
        Else
            'Refill the combo box with the new (or updated)
            'ScheduleGroup id and name
            Call modStatRefQuery.RefQueryScheduleGroup(vReturn, , , Me.OrganizationId)
            Call modControl.SetTextID(CboScheduleGroup, vReturn)
            Call modControl.SelectID(CboScheduleGroup, vScheduleGroupID)
        End If

    End Sub

    Private Sub cmdSelect_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdSelect.Click

        On Error Resume Next

        Dim vReturn As Object

        Call modUtility.Work()

        Call modControl.GetSelListViewID(LstViewAvailableOrganizations, vReturn)

        If IsNothing(vReturn) Then
            Call modUtility.Done()
            Exit Sub
        End If

        'Insert each of the new rows in the database
        If modStatSave.SaveScheduleReferralOrganizations(Me, vReturn) = SUCCESS Then

            'Remove the current list
            LstViewSelectedOrganizations.Items.Clear()
            LstViewSelectedOrganizations.View = View.Details

            'Refill the selected organizations list
            Call modStatQuery.QueryScheduleReferralOrganization(Me)

        End If

        Call modUtility.Done()

    End Sub

    Private Sub CmdSelectParentOrg_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdSelectParentOrg.Click

        Dim vParentOrgID As Integer
        Dim vReturn() As String

        On Error Resume Next

        'Get the ParentOrg id from the ParentOrg form
        'after the user is done.
        AppMain.frmQuickLook = New FrmQuickLook
        AppMain.frmQuickLook.CmdClose.Text = "Select"
        AppMain.frmQuickLook.CallingForm = Me.Name
        AppMain.frmQuickLook.TxtPersonFirst.Enabled = False
        AppMain.frmQuickLook.TxtPersonLast.Enabled = False
        AppMain.frmQuickLook.LstPerson.Enabled = False
        AppMain.frmQuickLook.parentForm = Me
        Call AppMain.frmQuickLook.Display()

    End Sub

    Private Sub CmdSelectPerson_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdSelectPerson.Click

        On Error Resume Next

        Dim vReturn As New Object
        Dim I As Short

        Call modUtility.Work()

        Call modControl.GetSelListViewID(LstViewAvailablePerson, vReturn)

        If Not (TypeOf vReturn Is Array) Then
            Call modUtility.Done()
            Exit Sub
        End If

        'Insert each of the new rows in the database
        If modStatSave.SaveSchedulePerson(ScheduleGroupID, vReturn) = SUCCESS Then

            'Remove the current list
            LstViewSelectedPerson.Items.Clear()
            LstViewSelectedPerson.View = View.Details

            'Refill the selected list
            If modStatQuery.QuerySchedulePerson(ScheduleGroupID, vReturn) = SUCCESS Then
                Call modControl.SetListViewRows(vReturn, True, LstViewSelectedPerson, False)
                SelectedPersonList = vReturn

                If ugSchedule.Rows.Count > 0 Then
                    LoadGridSchedulePeople()
                End If

            End If

        End If

        Call modUtility.Done()

    End Sub

    Private Sub CmdSplitShift_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdSplitShift.Click


        Dim ScheduleItemID As Integer

        'Check if a row is selected
        If ugSchedule.ActiveRow Is Nothing Then
            Exit Sub
        End If

        'Set ids
        frmScheduleSplitShift = New FrmScheduleSplitShift
        frmScheduleSplitShift.FormState = NEW_RECORD
        frmScheduleSplitShift.ScheduleItemID = ugSchedule.ActiveRow.Cells(ScheduleDS.Schedule.ScheduleItemIDColumn.ColumnName).Value
        frmScheduleSplitShift.ScheduleGroupID = Me.ScheduleGroupID

        frmScheduleSplitShift.TxtStartName.Text = ugSchedule.ActiveRow.Cells(ScheduleDS.Schedule.ScheduleItemNameColumn.ColumnName).Value
        frmScheduleSplitShift.TxtEndName.Text = ugSchedule.ActiveRow.Cells(ScheduleDS.Schedule.ScheduleItemNameColumn.ColumnName).Value

        frmScheduleSplitShift.LblStartDate.Text = CDate(ugSchedule.ActiveRow.Cells(ScheduleDS.Schedule.ScheduleStartDateTimeColumn.ColumnName).Value).ToString("MM/dd/yyyy")
        frmScheduleSplitShift.LblStart1Day.Text = GetWeekday(CDate(ugSchedule.ActiveRow.Cells(ScheduleDS.Schedule.ScheduleStartDateTimeColumn.ColumnName).Value))
        frmScheduleSplitShift.LblStartTime.Text = CDate(ugSchedule.ActiveRow.Cells(ScheduleDS.Schedule.ScheduleStartDateTimeColumn.ColumnName).Value).ToString("HH:mm")

        frmScheduleSplitShift.DefaultEndTime = CDate(ugSchedule.ActiveRow.Cells(ScheduleDS.Schedule.ScheduleEndDateTimeColumn.ColumnName).Value).ToString("HH:mm")
        frmScheduleSplitShift.DefaultStartTime = CDate(ugSchedule.ActiveRow.Cells(ScheduleDS.Schedule.ScheduleStartDateTimeColumn.ColumnName).Value).ToString("HH:mm")
        frmScheduleSplitShift.CboEndDate.Value = CDate(ugSchedule.ActiveRow.Cells(ScheduleDS.Schedule.ScheduleStartDateTimeColumn.ColumnName).Value).ToString("MM/dd/yyyy")
        frmScheduleSplitShift.LblEnd1Day.Text = GetWeekday(CDate(ugSchedule.ActiveRow.Cells(ScheduleDS.Schedule.ScheduleStartDateTimeColumn.ColumnName).Value))

        Call modControl.SelectText((frmScheduleSplitShift.CboEndTime), frmScheduleSplitShift.LblStartTime.Text)

        frmScheduleSplitShift.LblEndDate.Text = CDate(ugSchedule.ActiveRow.Cells(ScheduleDS.Schedule.ScheduleEndDateTimeColumn.ColumnName).Value).ToString("MM/dd/yyyy")
        frmScheduleSplitShift.LblEnd2Day.Text = GetWeekday(CDate(ugSchedule.ActiveRow.Cells(ScheduleDS.Schedule.ScheduleEndDateTimeColumn.ColumnName).Value))
        frmScheduleSplitShift.LblEndTime.Text = CDate(ugSchedule.ActiveRow.Cells(ScheduleDS.Schedule.ScheduleEndDateTimeColumn.ColumnName).Value).ToString("HH:mm")
        frmScheduleSplitShift.CboStartDate.Value = CDate(ugSchedule.ActiveRow.Cells(ScheduleDS.Schedule.ScheduleStartDateTimeColumn.ColumnName).Value).ToString("MM/dd/yyyy")
        frmScheduleSplitShift.LblStart2Day.Text = GetWeekday(CDate(ugSchedule.ActiveRow.Cells(ScheduleDS.Schedule.ScheduleEndDateTimeColumn.ColumnName).Value))

        Call modControl.SelectText((frmScheduleSplitShift.CboStartTime), frmScheduleSplitShift.LblStartTime.Text)

        'Get the ScheduleShift id from the ScheduleShift form
        'after the user is done.
        ScheduleItemID = frmScheduleSplitShift.Display

        If ScheduleItemID = 0 Then
            'The user cancelled adding a new ScheduleShift
            'so do nothing
        Else

            'Reset the current list
            CmdGetSchedule_Click(CmdGetSchedule, New System.EventArgs())

            SetFirstActiveRow()

        End If

    End Sub



    Private Sub CmdUnassigned_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdUnassigned.Click

        Call modUtility.Work()

        'Clear the grid
        LstViewAvailableOrganizations.Items.Clear()
        LstViewAvailableOrganizations.View = View.Details

        'Fill Grid
        Call modStatQuery.QueryUnassignedScheduleGroupOrganization(Me)

        Call modUtility.Done()

    End Sub

    Private Sub FrmSchedule_Activated(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Activated

        If Me.Loaded = False Then
            Me.Loaded = True
        End If

        If Me.GetScheduleFlag = True Then
            Me.GetSchedule()
            Me.GetScheduleFlag = False

        End If

    End Sub

    Private Sub FrmSchedule_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load

        On Error Resume Next

        Dim intI As Short ' counter

        Call modUtility.CenterForm()

        Me.Saved = False
        Me.Loaded = False

        '4/2010 bret initialize TabSchedule Hashtable
        tabScheduleTable = New Hashtable()
        tabScheduleTable.Add(TABSCHEDULE_CALLSCHEDULE, TabSchedule.TabPages(TABSCHEDULE_CALLSCHEDULE))
        tabScheduleTable.Add(TABSCHEDULE_ONCALLFOR, TabSchedule.TabPages(TABSCHEDULE_ONCALLFOR))
        tabScheduleTable.Add(TABSCHEDULE_SHIFTS, TabSchedule.TabPages(TABSCHEDULE_SHIFTS))
        tabScheduleTable.Add(TABSCHEDULE_ONCALLNOTES, TabSchedule.TabPages(TABSCHEDULE_ONCALLNOTES))
        tabScheduleTable.Add(TABSCHEDULE_SOURCECODES, TabSchedule.TabPages(TABSCHEDULE_SOURCECODES))
        tabScheduleTable.Add(TABSCHEDULE_SCHEDULE, TabSchedule.TabPages(TABSCHEDULE_SCHEDULE))
        tabScheduleTable.Add(TABSCHEDULE_SCHEDULELOG, TabSchedule.TabPages(TABSCHEDULE_SCHEDULELOG))
        tabScheduleTable.Add(TABSCHEDULE_SCHEDULESPEOPLE, TabSchedule.TabPages(TABSCHEDULE_SCHEDULESPEOPLE))

        '*******************************
        'Initialize Schedule Information
        '*******************************

        Call modControl.HighlightListViewRow(LstViewSourceCodes)
        Call LstViewSourceCodes.Columns.Insert(0, "", "Source Code", CInt(VB6.TwipsToPixelsX(1200)))
        Call LstViewSourceCodes.Columns.Insert(1, "", "Source Type", CInt(VB6.TwipsToPixelsX(1200)))

        'If the ogranization ID has not been set, then
        'fill the organization list box with all the organizations
        'that have a schedule. Else, fill the organization list
        'with only the selected organization.
        If Me.OrganizationId = 0 Then
            Call modStatQuery.QueryScheduleOrganizations(Me)
        Else
            CboOrganization.Items.Add(New ValueDescriptionPair(Me.OrganizationId, Me.OrganizationName))
            'Set the organization combo box to the current organization
            Call modControl.SelectID(CboOrganization, Me.OrganizationId)
        End If

        'Default the schedule group
        If Me.ScheduleGroupID <> 0 Then
            Call modControl.SelectID(CboScheduleGroup, Me.ScheduleGroupID)
        End If

        'Default to the current month and year
        Me.CurrentDate = Today
        Call modControl.SelectText(CboYear, CStr(Year(Me.CurrentDate)))
        Call modControl.SelectID(CboMonth, Month(Me.CurrentDate))

        '*******************************
        'Initialize On Call For Information
        '*******************************

        'Initialize the available organizations grid
        Call modControl.HighlightListViewRow(LstViewAvailableOrganizations)
        Call LstViewAvailableOrganizations.Columns.Insert(0, "", "Organization", CInt(VB6.TwipsToPixelsX(2500)))
        Call LstViewAvailableOrganizations.Columns.Insert(1, "", "City", CInt(VB6.TwipsToPixelsX(1100)))
        Call LstViewAvailableOrganizations.Columns.Insert(2, "", "State", CInt(VB6.TwipsToPixelsX(550)))
        Call LstViewAvailableOrganizations.Columns.Insert(3, "", "Organization Type", CInt(VB6.TwipsToPixelsX(1800)))

        'Initialize the selected organizations grid
        Call modControl.HighlightListViewRow(LstViewSelectedOrganizations)
        Call LstViewSelectedOrganizations.Columns.Insert(0, "", "Organization", CInt(VB6.TwipsToPixelsX(2500)))
        Call LstViewSelectedOrganizations.Columns.Insert(1, "", "City", CInt(VB6.TwipsToPixelsX(1100)))
        Call LstViewSelectedOrganizations.Columns.Insert(2, "", "State", CInt(VB6.TwipsToPixelsX(550)))
        Call LstViewSelectedOrganizations.Columns.Insert(3, "", "Organization Type", CInt(VB6.TwipsToPixelsX(1800)))

        'Get the reference data
        Call modStatRefQuery.RefQueryState(CboState, , , , , True)
        Call modStatRefQuery.RefQueryOrganizationType(CboOrganizationType, , , , , True)

        'Set the default types
        Call modControl.SelectID(CboState, ALL_STATES)
        Call modControl.SelectID(CboOrganizationType, ALL_ORG_TYPES)

        ' Get the installed fonts collection.
        Dim installedFonts As New InstalledFontCollection

        ' Get an array of the system's font familiies.
        Dim font_families() As FontFamily = installedFonts.Families()

        ' Display the font families.
        For Each fontFamily As FontFamily In font_families
            cmbfont.Items.Add(fontFamily.Name)
        Next fontFamily

        '' fill size combo
        For intI = 6 To 150
            cmbsize.Items.Add(Str(intI))
        Next intI

        '' set default font to Arial 9pt
        ''
        cmbsize.SelectedIndex = cmbsize.FindStringExact(" 9")
        cmbfont.SelectedIndex = cmbfont.FindStringExact("Arial")

        Me.AvailableSortOrder = ASCENDING_ORDER


        '*******************************
        'Initialize Shift Information
        '*******************************

        'Initialize the shifts grid
        Call modControl.HighlightListViewRow(LstViewShifts)
        Call LstViewShifts.Columns.Insert(0, "", "Shift Name", CInt(VB6.TwipsToPixelsX(1000)))
        Call LstViewShifts.Columns.Insert(1, "", "Day", CInt(VB6.TwipsToPixelsX(1000)))
        Call LstViewShifts.Columns.Insert(2, "", "Start Time", CInt(VB6.TwipsToPixelsX(1000)))
        Call LstViewShifts.Columns.Insert(3, "", "End Time", CInt(VB6.TwipsToPixelsX(1000)))

        'disable obsolete tabs for now ttw 12/20/00
        'TabSchedule.TabVisible(0) = False
        'reactivated 03/27/01
        If (TabSchedule.TabPages.IndexOf(tabScheduleTable(TABSCHEDULE_SHIFTS)) > -1) Then
            TabSchedule.TabPages.Remove(tabScheduleTable(TABSCHEDULE_SHIFTS))
        End If

        If Not modStatSecurity.GetPermission(AppMain.ParentForm.StatEmployeeID, "AllowCallDelete") Then
            CmdSelectParentOrg.Enabled = False
            CmdScheduleDetail.Enabled = False
        End If

        'Hide schedule tabs & buttons if user doesn't have permission
        If Not modStatSecurity.GetPermission(AppMain.ParentForm.StatEmployeeID, "AllowScheduleAccess") Then
            CmdOK.Visible = False

            If (TabSchedule.TabPages.IndexOf(tabScheduleTable(TABSCHEDULE_CALLSCHEDULE)) > -1) Then
                TabSchedule.TabPages.Remove(tabScheduleTable(TABSCHEDULE_CALLSCHEDULE))
            End If
            If (TabSchedule.TabPages.IndexOf(tabScheduleTable(TABSCHEDULE_ONCALLFOR)) > -1) Then
                TabSchedule.TabPages.Remove(tabScheduleTable(TABSCHEDULE_ONCALLFOR))
            End If
            If (TabSchedule.TabPages.IndexOf(tabScheduleTable(TABSCHEDULE_ONCALLNOTES)) > -1) Then
                TabSchedule.TabPages.Remove(tabScheduleTable(TABSCHEDULE_ONCALLNOTES))
            End If
            If (TabSchedule.TabPages.IndexOf(tabScheduleTable(TABSCHEDULE_SOURCECODES)) > -1) Then
                TabSchedule.TabPages.Remove(tabScheduleTable(TABSCHEDULE_SOURCECODES))
            End If
            If (TabSchedule.TabPages.IndexOf(tabScheduleTable(TABSCHEDULE_SCHEDULELOG)) > -1) Then
                TabSchedule.TabPages.Remove(tabScheduleTable(TABSCHEDULE_SCHEDULELOG))
            End If
            If (TabSchedule.TabPages.IndexOf(tabScheduleTable(TABSCHEDULE_SCHEDULESPEOPLE)) > -1) Then
                TabSchedule.TabPages.Remove(tabScheduleTable(TABSCHEDULE_SCHEDULESPEOPLE))
            End If

            CmdCreateShift.Visible = False
            CmdEditShift.Visible = False
            CmdSplitShift.Visible = False
            CmdInsertShift.Visible = False
            CmdRemoveShift.Visible = False
            CmdAddPerson.Visible = False

        End If

        'Initialize the available persons grid
        Call modControl.HighlightListViewRow(LstViewAvailablePerson)
        Call LstViewAvailablePerson.Columns.Insert(0, "", "Available", CInt(VB6.TwipsToPixelsX(1800)))
        Call LstViewAvailablePerson.Columns.Insert(1, "", "Type", CInt(VB6.TwipsToPixelsX(2000)))

        'Initialize the selected persons grid
        Call modControl.HighlightListViewRow(LstViewSelectedPerson)
        Call LstViewSelectedPerson.Columns.Insert(0, "", "Selected", CInt(VB6.TwipsToPixelsX(1800)))
        Call LstViewSelectedPerson.Columns.Insert(1, "", "Type", CInt(VB6.TwipsToPixelsX(2000)))


    End Sub


    Private Sub FrmSchedule_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing

        Dim vReturn As Short

        If Me.Saved = True Then
            'The message was saved so just unload
            eventArgs.Cancel = False

        Else
            'The message was cancelled or closed so confirm cancellation
            vReturn = modMsgForm.FormCancel
            If vReturn = MsgBoxResult.Yes Then
                eventArgs.Cancel = False

            Else
                eventArgs.Cancel = True
                Exit Sub
            End If
        End If

        'ccarroll 12/03/2010 moved Schedule un-lock to this location
        'Remove ScheduleLock
        Call modStatSave.UpdateScheduleLock(Me, True)

        If (Not IsNothing(frmScheduleShift)) Then
            frmScheduleShift = Nothing
        End If
        If Not IsNothing(frmScheduleShiftItem) Then
            frmScheduleShiftItem = Nothing
        End If
        If Not IsNothing(frmScheduleSplitShift) Then
            frmScheduleSplitShift = Nothing
        End If
        If Not IsNothing(frmScheduleGroup) Then
            frmScheduleGroup = Nothing
        End If

        If (Not IsNothing(SourceCodes)) Then

            SourceCodes.Close()
            SourceCodes = Nothing
        End If
        Dispose()
        AppMain.frmSchedule = Nothing


    End Sub


#Region "GrdSchedule"


#End Region

    Private Sub LstViewAvailableOrganizations_ColumnClick(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.ColumnClickEventArgs) Handles LstViewAvailableOrganizations.ColumnClick
        Dim ColumnHeader As System.Windows.Forms.ColumnHeader = LstViewAvailableOrganizations.Columns(eventArgs.Column)

        ' When a ColumnHeader object is clicked, the ListView control is
        ' sorted by the subitems of that column.
        ' Set the SortKey to the Index of the ColumnHeader - 1
        LstViewAvailableOrganizations.Sorting = Me.AvailableSortOrder
        LstViewAvailableOrganizations.ListViewItemSorter = New ListViewItemComparer(eventArgs.Column, Me.AvailableSortOrder)
        ' Set Sorted to True to sort the list.
        LstViewAvailableOrganizations.Sort()

        If Me.AvailableSortOrder = System.Windows.Forms.SortOrder.Ascending Then
            Me.AvailableSortOrder = System.Windows.Forms.SortOrder.Descending
        Else
            Me.AvailableSortOrder = System.Windows.Forms.SortOrder.Ascending
        End If


    End Sub


    Private Sub LstViewAvailableOrganizations_DoubleClick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewAvailableOrganizations.DoubleClick

        Dim organizationID As Integer
        'Get the ID
        organizationID = modConv.TextToLng(LstViewAvailableOrganizations.FocusedItem.Tag)

        If uIMap Is Nothing Then
            uIMap = OpenStatTracCSharpForms.CreateInstance()
        End If
        uIMap.Open(AppScreenType.OrganizationsOrganizationEditPopup, organizationID)

        LstViewAvailableOrganizations.Visible = False
        LstViewSelectedOrganizations.Visible = False
        LstViewAvailableOrganizations.Visible = True
        LstViewSelectedOrganizations.Visible = True

        Me.Activate()

    End Sub


    Private Sub LstViewAvailablePerson_ColumnClick(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.ColumnClickEventArgs) Handles LstViewAvailablePerson.ColumnClick
        Dim ColumnHeader As System.Windows.Forms.ColumnHeader = LstViewAvailablePerson.Columns(eventArgs.Column)

        ' When a ColumnHeader object is clicked, the ListView control is
        ' sorted by the subitems of that column.
        ' Set the SortKey to the Index of the ColumnHeader - 1
        LstViewAvailablePerson.Sorting = Me.AvailablePersonSortOrder
        LstViewAvailablePerson.ListViewItemSorter = New ListViewItemComparer(eventArgs.Column, Me.AvailablePersonSortOrder)

        If Me.AvailablePersonSortOrder = System.Windows.Forms.SortOrder.Ascending Then
            Me.AvailablePersonSortOrder = System.Windows.Forms.SortOrder.Descending
        Else
            Me.AvailablePersonSortOrder = System.Windows.Forms.SortOrder.Ascending
        End If

    End Sub


    Private Sub LstViewAvailablePerson_DoubleClick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewAvailablePerson.DoubleClick

        Call CmdSelectPerson_Click(CmdSelectPerson, New System.EventArgs())

    End Sub

    Private Sub LstViewSelectedOrganizations_ColumnClick(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.ColumnClickEventArgs) Handles LstViewSelectedOrganizations.ColumnClick
        Dim ColumnHeader As System.Windows.Forms.ColumnHeader = LstViewSelectedOrganizations.Columns(eventArgs.Column)

        ' When a ColumnHeader object is clicked, the ListView control is
        ' sorted by the subitems of that column.
        ' Set the SortKey to the Index of the ColumnHeader - 1
        LstViewSelectedOrganizations.Sorting = Me.SelectedSortOrder
        LstViewSelectedOrganizations.ListViewItemSorter = New ListViewItemComparer(eventArgs.Column, Me.SelectedSortOrder)

        If Me.SelectedSortOrder = System.Windows.Forms.SortOrder.Ascending Then
            Me.SelectedSortOrder = System.Windows.Forms.SortOrder.Descending
        Else
            Me.SelectedSortOrder = System.Windows.Forms.SortOrder.Ascending
        End If

    End Sub



    Private Sub LstViewSelectedPerson_ColumnClick(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.ColumnClickEventArgs) Handles LstViewSelectedPerson.ColumnClick
        Dim ColumnHeader As System.Windows.Forms.ColumnHeader = LstViewSelectedPerson.Columns(eventArgs.Column)

        ' When a ColumnHeader object is clicked, the ListView control is
        ' sorted by the subitems of that column.
        ' Set the SortKey to the Index of the ColumnHeader - 1
        LstViewSelectedPerson.Sorting = Me.SelectedPersonSortOrder
        LstViewSelectedPerson.ListViewItemSorter = New ListViewItemComparer(eventArgs.Column, Me.SelectedPersonSortOrder)

        If Me.SelectedPersonSortOrder = System.Windows.Forms.SortOrder.Ascending Then
            Me.SelectedPersonSortOrder = System.Windows.Forms.SortOrder.Descending
        Else
            Me.SelectedPersonSortOrder = System.Windows.Forms.SortOrder.Ascending
        End If

    End Sub


    Private Sub LstViewSelectedPerson_DoubleClick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewSelectedPerson.DoubleClick

        Call CmdDeselectPerson_Click(CmdDeselectPerson, New System.EventArgs())

    End Sub

    Private Sub LstViewShifts_ColumnClick(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.ColumnClickEventArgs) Handles LstViewShifts.ColumnClick
        Dim ColumnHeader As System.Windows.Forms.ColumnHeader = LstViewShifts.Columns(eventArgs.Column)

        ' When a ColumnHeader object is clicked, the ListView control is
        ' sorted by the subitems of that column.
        ' Set the SortKey to the Index of the ColumnHeader - 1
        LstViewShifts.Sorting = Me.AvailableSortOrder
        LstViewShifts.ListViewItemSorter = New ListViewItemComparer(eventArgs.Column, Me.AvailableSortOrder)

        If Me.ShiftSortOrder = System.Windows.Forms.SortOrder.Ascending Then
            Me.ShiftSortOrder = System.Windows.Forms.SortOrder.Descending
        Else
            Me.ShiftSortOrder = System.Windows.Forms.SortOrder.Ascending
        End If

    End Sub

    Private Sub LstViewShifts_DoubleClick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewShifts.DoubleClick

        Call CmdEdit_Click(CmdEdit, New System.EventArgs())

    End Sub

    Public Function Display() As Object

        Dim dialogResult As DialogResult = Me.ShowDialog()

        Dispose()

        Return True

    End Function

    Public Function GetWeekday(ByVal pvDate As Object) As String

        On Error Resume Next

        Dim vWeekdayInt As Short

        vWeekdayInt = 0

        vWeekdayInt = Weekday(pvDate)

        Select Case vWeekdayInt
            Case 0
                GetWeekday = ""
            Case 1
                GetWeekday = "Sun"
            Case 2
                GetWeekday = "Mon"
            Case 3
                GetWeekday = "Tues"
            Case 4
                GetWeekday = "Wed"
            Case 5
                GetWeekday = "Thur"
            Case 6
                GetWeekday = "Fri"
            Case 7
                GetWeekday = "Sat"
            Case Else
                GetWeekday = ""
        End Select

    End Function
    Public Function ClearAll() As Object


        'Clear the on call lists
        LstViewAvailableOrganizations.Items.Clear()
        LstViewAvailableOrganizations.View = View.Details
        LstViewSelectedOrganizations.Items.Clear()
        LstViewSelectedOrganizations.View = View.Details

        LstViewAvailablePerson.Items.Clear()
        LstViewSelectedPerson.Items.Clear()

        LstViewShifts.Items.Clear()
        LstViewShifts.View = View.Details

        TxtScheduleReferralNotes.Text = ""
        TxtScheduleMessageNotes.Text = ""
        ChkActive.CheckState = System.Windows.Forms.CheckState.Unchecked

        SourceCodes = Nothing
        LstViewSourceCodes.Items.Clear()

        If scheduleBR IsNot Nothing Then
            scheduleBR.AssociatedDataSet.Clear()
        End If
        If scheduleLogBR IsNot Nothing Then
            scheduleLogBR.AssociatedDataSet.Clear()
        End If



    End Function


    Public Function GetSchedule() As Object

        On Error Resume Next

        Dim vReturn As New Object

        Call modUtility.Work()

        'Get the current organization ID
        Me.OrganizationId = modControl.GetID(CboOrganization)

        'Get the current month and year ID
        Me.CurrentMonth = modControl.GetID(CboMonth)
        Me.CurrentYear = modControl.GetText(CboYear)

        If Me.CurrentMonth = -1 Or Me.CurrentYear = "" Then
            'Do nothing
        Else

            'Fill the selected organizations grid
            Call modStatQuery.QueryScheduleReferralOrganization(Me)

            'Fill the shift grid
            Call modStatQuery.QueryScheduleShifts(Me)

            'Get the schedule notes
            Call modStatQuery.QueryScheduleGroupNotes(Me)

            'Fill the source codes
            Call modStatQuery.QueryScheduleGroupSourceCode(Me)

            'Fill available persons Grid
            If modStatQuery.QueryOrganizationPersons(OrganizationId, vReturn, False) = SUCCESS Then
                Call modControl.SetListViewRows(vReturn, True, LstViewAvailablePerson, False)
                AvailablePersonList = vReturn
            End If

            'Fill the selected persons grid
            If modStatQuery.QuerySchedulePerson(ScheduleGroupID, vReturn) = SUCCESS Then
                Call modControl.SetListViewRows(vReturn, True, LstViewSelectedPerson, False)
                SelectedPersonList = vReturn
                'Create a combo box delimited list
                Call CreateComboBoxList()
            End If

        End If

        Call modUtility.Done()

    End Function


    Public Sub MnuCreateShift_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MnuCreateShift.Click

        Call CmdCreateShift_Click(CmdCreateShift, New System.EventArgs())

    End Sub

    Public Sub MnuEditShift_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MnuEditShift.Click

        Call CmdEditShift_Click(CmdEditShift, New System.EventArgs())

    End Sub

    Public Sub MnuInsertShift_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MnuInsertShift.Click

        Call CmdInsertShift_Click(CmdInsertShift, New System.EventArgs())

    End Sub

    Public Sub MnuSplitShift_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MnuSplitShift.Click

        Call CmdSplitShift_Click(CmdSplitShift, New System.EventArgs())

    End Sub

    Private Sub OptDates_CheckedChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles OptDates.CheckedChanged

        Dim Index As Short = OptDates.GetIndex(eventSender)

        'On Error Resume Next

        Select Case Index
            Case 0
                CboFromDate.Value = Month(Now) & "/1/" & Year(Now)
                CboToDate.Value = DateAdd(Microsoft.VisualBasic.DateInterval.Day, -1, DateAdd(Microsoft.VisualBasic.DateInterval.Month, 1, CboFromDate.Value))
            Case 1
                CboToDate.Value = VB6.Format(Now, "mm/dd/yyyy")
                CboFromDate.Value = VB6.Format(Now, "mm/dd/yyyy")
        End Select

        CboLogFromDate.Value = CboFromDate.Value
        CboLogToDate.Value = CboToDate.Value


    End Sub

    Private Sub TabSchedule_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TabSchedule.SelectedIndexChanged
        Static PreviousTab As Short = TabSchedule.SelectedIndex()
        If (TabSchedule.TabPages.IndexOf(tabScheduleTable(TABSCHEDULE_SHIFTS)) > -1) Then
            LstViewShifts.Items.Clear()
            'Fill the shift grid
            Call modStatQuery.QueryScheduleShifts(Me)
        End If

        PreviousTab = TabSchedule.SelectedIndex()
    End Sub

    ''' <summary>
    ''' checks for gaps in schedule
    ''' * Sets rows with gap to red
    ''' * Sets current time span to blue
    ''' </summary>
    ''' <remarks></remarks>
    Public Sub FlagGaps()

        Dim previousRow As UltraGridRow

        For Each currentRow As UltraGridRow In ugSchedule.Rows

            If previousRow IsNot Nothing Then

                If (DateTime.Parse(previousRow.Cells(ScheduleDS.Schedule.ScheduleEndDateTimeColumn.ColumnName.ToString()).Value.ToString()) <> DateTime.Parse(currentRow.Cells(ScheduleDS.Schedule.ScheduleStartDateTimeColumn.ColumnName.ToString()).Value.ToString())) Then
                    previousRow.CellAppearance.ForeColor = Drawing.Color.Red
                    currentRow.CellAppearance.ForeColor = Drawing.Color.Red
                End If
            End If

            'Flag the current shift
            If DateTime.Parse(currentRow.Cells(ScheduleDS.Schedule.ScheduleStartDateTimeColumn.ColumnName.ToString()).Value.ToString()) <= Now And DateTime.Parse(currentRow.Cells(ScheduleDS.Schedule.ScheduleEndDateTimeColumn.ColumnName.ToString()).Value.ToString()) > Now Then
                currentRow.CellAppearance.BackColor = Drawing.Color.LightBlue
            End If

            previousRow = currentRow


        Next
    End Sub


    Public Sub ScheduleLog(ByVal pvChangeType As String, ByVal pvShift As String, ByVal pvChangeDesc As String)

        On Error Resume Next

        Dim vValues As String
        Dim vQuery As String
        Dim vResult As Object


        'Get the data
        Dim vParams(5) As Object

        vParams(0) = ScheduleGroupID
        vParams(1) = Now
        vParams(2) = AppMain.ParentForm.PersonID
        vParams(3) = VB.Left(pvChangeType, 20)
        vParams(4) = VB.Left(pvShift, 80)
        vParams(5) = VB.Left(pvChangeDesc, 200)

        'Specify the table fields
        Dim vFields(5) As Object

        vFields(0) = "ScheduleGroupID"
        vFields(1) = "ScheduleLogDateTime"
        vFields(2) = "PersonID"
        vFields(3) = "ScheduleLogType"
        vFields(4) = "ScheduleLogShift"
        vFields(5) = "ScheduleLogChange"

        'Insert record
        vValues = modODBC.BuildSQL(NEW_RECORD, vParams, vFields)

        vQuery = "INSERT INTO ScheduleLog (" & vValues & ")"

        vResult = modODBC.Exec(vQuery)

    End Sub

    Private Sub CmdPrintBrowserList()
        Dim hBrowse As Integer
        Dim vReportParameters As String
        Dim vReportName As String

        On Error GoTo handleError

        'Turn on Hour glass
        Call modUtility.Work()

        'set asp page location
        vReportParameters = "http://www2.statline.com/loginstatline/reports/schedule/Schedule.asp?"


        'From and To Dates
        vReportParameters = vReportParameters & "StartDate=" & CboFromDate.Value & "" & "&EndDate=" & CboToDate.Value & " 23:59:00"



        If modControl.GetID(CboOrganization) <> -1 Then
            vReportParameters = vReportParameters & "&ReportGroupID=" & modControl.GetID(CboOrganization) & ""
        Else
            Exit Sub
        End If

        If modControl.GetID((Me.CboScheduleGroup)) <> -1 Then
            vReportParameters = vReportParameters & "&ScheduleGroupID=" & modControl.GetID((Me.CboScheduleGroup)) & ""
        End If

        'UserID
        vReportParameters = vReportParameters & "&UserID=" & AppMain.ParentForm.WebPersonID & ""

        'UserOrgID
        vReportParameters = vReportParameters & "&UserOrgID=" & AppMain.ParentForm.WebUserOrg & ""



        'Get the report file name
        Select Case AppMain.ConnectionType
            Case PROD_CONN
                vReportParameters = vReportParameters & "&Options=DSN=" & PROD_DATASOURCE
            Case TEST_CONN
                MsgBox("You cannot print from the Test database.")
            Case PROD_BKUP_CONN
                MsgBox("You cannot print from the Backup Production database.")
            Case ARCHIVE
                MsgBox("You cannot print from the Archive database.")

        End Select


        'Call Browswer pass vReportParameters
        hBrowse = modReport.ShellExecute(Me.Handle.ToInt32, "open", vReportParameters, "", "", 1)

        'Turn Off Hour glass
        Call modUtility.Done()

        Exit Sub

handleError:

        If Err.Number = 20504 Or Err.Number = 20997 Then
            Call modMsgForm.MissingReport()
        Else
            MsgBox("There has been a reporting error. Please try again. If the problem continues, contact your system administrator.", , "Reporting Error")
        End If

        Call modUtility.Done()

    End Sub
    Private Sub ContextMenuPopup(ByVal toolStripMenuItem As ToolStripMenuItem, ByVal eventSender As Object, ByVal drawingPostion As Integer)
        Dim drawingPoint As New Point(drawingPostion)
        ContextMenuStrip.Items.Clear()
        ContextMenuStrip.Items.Add(toolStripMenuItem)
        ContextMenuStrip.Show(DirectCast(eventSender, Control), drawingPoint)
    End Sub

    Private Sub cmbsize_PreviewKeyDown(ByVal sender As Object, ByVal e As System.Windows.Forms.PreviewKeyDownEventArgs) Handles cmbsize.PreviewKeyDown

    End Sub

    Private Sub cmbsize_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmbsize.TextChanged
        'If Me.Loaded = True Then
        Select Case pvfieldfocus
            Case "TxtReferralNotes"
                TxtReferralNotes.SelectionFont = VB6.FontChangeSize(TxtReferralNotes.SelectionFont, CDec(cmbsize.Text))
            Case "TxtScheduleReferralNotes"
                TxtScheduleReferralNotes.SelectionFont = VB6.FontChangeSize(TxtScheduleReferralNotes.SelectionFont, CDec(cmbsize.Text))
            Case "TxtMessageNotes"
                TxtMessageNotes.SelectionFont = VB6.FontChangeSize(TxtMessageNotes.SelectionFont, CDec(cmbsize.Text))
            Case "TxtScheduleMessageNotes"
                TxtScheduleMessageNotes.SelectionFont = VB6.FontChangeSize(TxtScheduleMessageNotes.SelectionFont, CDec(cmbsize.Text))
        End Select
        'End If
    End Sub

    Private Sub cmbsize_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmbsize.SelectedIndexChanged
        'If Me.Loaded = True Then
        Select Case pvfieldfocus
            Case "TxtReferralNotes"
                TxtReferralNotes.SelectionFont = VB6.FontChangeSize(TxtReferralNotes.SelectionFont, CDec(cmbsize.Text))
            Case "TxtScheduleReferralNotes"
                TxtScheduleReferralNotes.SelectionFont = VB6.FontChangeSize(TxtScheduleReferralNotes.SelectionFont, CDec(cmbsize.Text))
            Case "TxtMessageNotes"
                TxtMessageNotes.SelectionFont = VB6.FontChangeSize(TxtMessageNotes.SelectionFont, CDec(cmbsize.Text))
            Case "TxtScheduleMessageNotes"
                TxtScheduleMessageNotes.SelectionFont = VB6.FontChangeSize(TxtScheduleMessageNotes.SelectionFont, CDec(cmbsize.Text))
        End Select
        'End If
    End Sub

    Private Sub cmbfont_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmbfont.SelectedIndexChanged
        'If Me.Loaded = True Then
        Select Case pvfieldfocus
            Case "TxtReferralNotes"
                TxtReferralNotes.SelectionFont = VB6.FontChangeName(TxtReferralNotes.SelectionFont, cmbfont.Text)
            Case "TxtScheduleReferralNotes"
                TxtScheduleReferralNotes.SelectionFont = VB6.FontChangeName(TxtScheduleReferralNotes.SelectionFont, cmbfont.Text)
            Case "TxtMessageNotes"
                TxtMessageNotes.SelectionFont = VB6.FontChangeName(TxtMessageNotes.SelectionFont, cmbfont.Text)
            Case "TxtScheduleMessageNotes"
                TxtScheduleMessageNotes.SelectionFont = VB6.FontChangeName(TxtScheduleMessageNotes.SelectionFont, cmbfont.Text)
        End Select
        'End If
    End Sub

    Private Sub cmbfont_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmbfont.TextChanged
        'If Me.Loaded = True Then
        Select Case pvfieldfocus
            Case "TxtReferralNotes"
                TxtReferralNotes.SelectionFont = VB6.FontChangeName(TxtReferralNotes.SelectionFont, cmbfont.Text)
            Case "TxtScheduleReferralNotes"
                TxtScheduleReferralNotes.SelectionFont = VB6.FontChangeName(TxtScheduleReferralNotes.SelectionFont, cmbfont.Text)
            Case "TxtMessageNotes"
                TxtMessageNotes.SelectionFont = VB6.FontChangeName(TxtMessageNotes.SelectionFont, cmbfont.Text)
            Case "TxtScheduleMessageNotes"
                TxtScheduleMessageNotes.SelectionFont = VB6.FontChangeName(TxtScheduleMessageNotes.SelectionFont, cmbfont.Text)
        End Select
        'End If
    End Sub

    Private Sub Toolbar1_ButtonClick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles bold.Click, italic.Click, underline.Click, _Toolbar1_Button4.Click, color.Click, _Toolbar1_Button6.Click, left.Click, center.Click, right.Click, _Toolbar1_Button10.Click, bullet.Click
        Dim Button As System.Windows.Forms.ToolStripItem = CType(eventSender, System.Windows.Forms.ToolStripItem)
        '************************************************************************************
        'Date Changed: 4/28/06                          Changed by: Char Chaput
        'Release #: 8.0                               Task: Unknown
        'Description:  Added for RTF - toolbar functionality
        '====================================================================================
        '************************************************************************************
        Select Case Me.ActiveControl.Name
            Case "TxtReferralNotes"
                Call RTF.ToolbarButtonClick(Button, (Me.Toolbar1), Me.TxtReferralNotes, (Me.cmbfont), (Me.cmbsize), Me.CommonDialog1Color)
            Case "TxtScheduleReferralNotes"
                Call RTF.ToolbarButtonClick(Button, (Me.Toolbar1), Me.TxtScheduleReferralNotes, (Me.cmbfont), (Me.cmbsize), Me.CommonDialog1Color)
            Case "TxtMessageNotes"
                Call RTF.ToolbarButtonClick(Button, (Me.Toolbar1), Me.TxtMessageNotes, (Me.cmbfont), (Me.cmbsize), Me.CommonDialog1Color)
            Case "TxtScheduleMessageNotes"
                Call RTF.ToolbarButtonClick(Button, (Me.Toolbar1), Me.TxtScheduleMessageNotes, (Me.cmbfont), (Me.cmbsize), Me.CommonDialog1Color)
        End Select
        Call RTF.ToolbarButtonClick(Button, (Me.Toolbar1), Me.TxtMessageNotes, (Me.cmbfont), (Me.cmbsize), Me.CommonDialog1Color)
    End Sub

    Private Sub TxtReferralNotes_Enter(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TxtReferralNotes.Enter
        pvfieldfocus = Me.ActiveControl.Name
        Call RTF.UpdateTextInfo((Me.Toolbar1), Me.TxtReferralNotes, (Me.cmbfont), (Me.cmbsize))
    End Sub

    Private Sub TxtScheduleReferralNotes_Enter(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TxtScheduleReferralNotes.Enter
        pvfieldfocus = Me.ActiveControl.Name
        Call RTF.UpdateTextInfo((Me.Toolbar1), Me.TxtScheduleReferralNotes, (Me.cmbfont), (Me.cmbsize))
    End Sub
    Private Sub TxtScheduleMessageNotes_Enter(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TxtScheduleMessageNotes.Enter
        pvfieldfocus = Me.ActiveControl.Name
        Call RTF.UpdateTextInfo((Me.Toolbar1), Me.TxtScheduleMessageNotes, (Me.cmbfont), (Me.cmbsize))
    End Sub

    Private Sub TxtScheduleMessageNotes_SelectionChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TxtScheduleMessageNotes.SelectionChanged
        Call RTF.UpdateTextInfo((Me.Toolbar1), Me.TxtScheduleMessageNotes, (Me.cmbfont), (Me.cmbsize))
    End Sub

    Private Sub TxtScheduleReferralNotes_SelectionChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TxtScheduleReferralNotes.SelectionChanged
        Call RTF.UpdateTextInfo((Me.Toolbar1), Me.TxtScheduleReferralNotes, (Me.cmbfont), (Me.cmbsize))
    End Sub

    Private Sub TxtReferralNotes_SelectionChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TxtReferralNotes.SelectionChanged
        Call RTF.UpdateTextInfo((Me.Toolbar1), Me.TxtReferralNotes, (Me.cmbfont), (Me.cmbsize))
    End Sub

    Private Sub TxtMessageNotes_SelectionChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TxtMessageNotes.SelectionChanged
        Call RTF.UpdateTextInfo((Me.Toolbar1), Me.TxtMessageNotes, (Me.cmbfont), (Me.cmbsize))
    End Sub

    Private Sub TxtMessageNotes_Enter(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TxtMessageNotes.Enter
        pvfieldfocus = Me.ActiveControl.Name
        Call RTF.UpdateTextInfo((Me.Toolbar1), Me.TxtMessageNotes, (Me.cmbfont), (Me.cmbsize))
    End Sub

    Private Sub CboScheduleGroup_Leave(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles CboScheduleGroup.Leave
        Call CboScheduleGroup_SelectedIndexChanged(CboScheduleGroup, New System.EventArgs())
    End Sub

    Private Sub InitializeScheduleBR()
        If (scheduleBR Is Nothing) Then
            scheduleBR = New ScheduleBR()
        End If
    End Sub
    Private Sub InitializeScheduleDS()

        If (scheduleBR IsNot Nothing) Then
            ScheduleDS = CType(scheduleBR.AssociatedDataSet, Schedule.ScheduleDS)
        End If

    End Sub
    Public Function SaveScheduleItem(ByRef scheduleItemPerson As System.Collections.Generic.List(Of ScheduleItemPerson)) As Boolean
        'ByRef ScheduleItemID As Integer, ByVal ScheduleGroupID As Integer, ByVal ShiftName As String, ByVal StartDate As Date, ByVal StartTime As String, ByVal EndDate As Date, ByVal EndTime As String
        scheduleItemPerson.ForEach(Function(Item) SaveScheduleItem(Item.ScheduleItemID, Item.ScheduleGroupID, Item.ShiftName, Item.StartDate, Item.StartTime, Item.EndDate, Item.EndTime, True))

        'row is updated now save the dataset
        SaveSchedule()
        CmdGetSchedule_Click(CmdGetSchedule, New EventArgs)

    End Function
    Public Function SaveScheduleItem(ByRef ScheduleItemID As Integer, ByVal ScheduleGroupID As Integer, ByVal CurrentShiftName As String, ByVal CurrentStartDate As Date, ByVal CurrentStartTime As String, ByVal CurrentEndDate As Date, ByVal CurrentEndTime As String, Optional ByVal delaySave As Boolean = False) As Boolean
        Dim result As Boolean = True
        If scheduleBR.AssociatedDataSet Is Nothing Then
            CmdGetSchedule_Click(New Object, New System.EventArgs)
        End If


        Dim schedule As Schedule.ScheduleDS.ScheduleRow
        Dim localScheduleItemID As Integer = ScheduleItemID
        'see if the row exists
        schedule = ScheduleDS.Schedule.FirstOrDefault(Function(row) row.ScheduleItemID = localScheduleItemID)

        'if the row is noththing the row did not exist and we need create a new row.
        If schedule Is Nothing Then
            ' this a new row
            ScheduleDS.Schedule.ScheduleGroupIDColumn.DefaultValue = ScheduleGroupID
            schedule = ScheduleDS.Schedule.NewScheduleRow()
            ScheduleDS.Schedule.AddScheduleRow(schedule)
        End If

        'now we have a row in the dataset lets update it
        schedule.ScheduleStartDateTime = CDate(CurrentStartDate + " " + CurrentStartTime)
        schedule.ScheduleEndDateTime = CDate(CurrentEndDate + " " + CurrentEndTime)
        schedule.ScheduleItemName = CurrentShiftName

        If Not delaySave Then
            'row is updated now save the dataset
            result = SaveSchedule()
            CmdGetSchedule_Click(CmdGetSchedule, New EventArgs)
        End If

        Return result
    End Function
    Private Function SaveSchedule() As Boolean
        Dim result As Boolean = True
        Try
            scheduleBR.SaveDataSet()
        Catch ex As Exception
            result = False
        End Try
        Return result
    End Function
    ''' <summary>
    ''' Event was added to prevent the grid from prompting for deletion confirmation.
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    ''' <remarks></remarks>
    Private Sub ugSchedule_BeforeRowsDeleted(ByVal sender As System.Object, ByVal e As Infragistics.Win.UltraWinGrid.BeforeRowsDeletedEventArgs) Handles ugSchedule.BeforeRowsDeleted
        e.DisplayPromptMsg = False
    End Sub

    Private Sub CboFromDate_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles CboFromDate.TextChanged
        CboLogFromDate.Value = CboFromDate.Value
    End Sub

    Private Sub CboToDate_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles CboToDate.TextChanged
        CboLogToDate.Value = CboToDate.Value
    End Sub

    Private Sub CboFromDate_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles CboFromDate.Click
        If CboFromDate.Value > CboToDate.Value Then
            CboFromDate.Value = CboToDate.Value
        End If

    End Sub

    Private Sub CboToDate_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles CboToDate.Click
        If CboToDate.Value < CboFromDate.Value Then
            CboToDate.Value = CboFromDate.Value
        End If

    End Sub
    Private Sub SetFirstActiveRow()
        Dim ugScheduleRow As UltraGridRow = ugSchedule.Rows.FirstOrDefault()
        If ugScheduleRow Is Nothing Then
            ugScheduleRow.Activate()
        End If

    End Sub
    Private Sub LoadGridSchedulePeople()
        'load the dropdown list for the grids
        '--set list parameters
        Dim param As New Hashtable()
        param.Add("ScheduleGroupID", ScheduleGroupID)
        schedulePeopleBR = New ListControlBR("ScheduleItemPersonListSelect", param)

        '--create and load the valueList
        Dim valueList As New Infragistics.Win.ValueList()
        schedulePeopleBR.SelectDataSet()
        Dim listControlDS As ListControlDS = CType(schedulePeopleBR.AssociatedDataSet, ListControlDS)

        'ccarroll 07/20/2011 Added option for de-selecting or setting a person to blank. wi:13030
        valueList.ValueListItems.Add(0, " ")

        listControlDS.ListControl.ToList.ForEach(Function(row) valueList.ValueListItems.Add(row.ListId, row.FieldValue))

        '-- assign the Value list to each Person column
        If (valueList.ValueListItems.Count > 0) Then
            '-- for each column set the valueList
            For loopCount As Integer = 1 To 18
                Dim columnName As String = "Person" + loopCount.ToString()
                ugSchedule.DisplayLayout.Bands(grConstant.FirstRow).Columns(columnName).ValueList = valueList
            Next
        Else
            '-- the value list is empty use null
            For loopCount As Integer = 1 To 18
                Dim columnName As String = "Person" + loopCount.ToString()
                ugSchedule.DisplayLayout.Bands(grConstant.FirstRow).Columns(columnName).ValueList = Nothing
                ugSchedule.DisplayLayout.Bands(grConstant.FirstRow).Columns(columnName).CellActivation = Activation.NoEdit
            Next
        End If

        '-- set the each PersonColumn
        For loopCount As Integer = 1 To 18
            Dim columnName As String = "Person" + loopCount.ToString()
            ugSchedule.DisplayLayout.Bands(grConstant.FirstRow).Columns(columnName).Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownList
        Next
    End Sub

    Public Property OptDatesMonth() As Boolean
        Get
            Return OptDates(0).Checked
        End Get
        Set(ByVal value As Boolean)
            OptDates(0).Checked = value
        End Set
    End Property

End Class