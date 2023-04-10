Option Strict Off
Option Explicit On
Friend Class FrmScheduleSplitShift
	Inherits System.Windows.Forms.Form
	
	'Form Variables
	Public FormState As Short
	Public ScheduleItemID As Integer
	Public Saved As Short
	Public ScheduleGroupID As Integer
    Public Verified As Short
    Public DefaultStartTime As String
    Public DefaultEndTime As String

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

	
	Private Sub CboEndDate_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboEndDate.Enter
		
        'Call modControl.HighlightText(ActiveControl)
		
	End Sub
	
	Private Sub CboEndDate_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles CboEndDate.Validating
		Dim Cancel As Boolean = eventArgs.Cancel
		
		'Update the day of week lable
		LblEnd1Day.Text = GetWeekday(CboEndDate.Value)
		'Update the day of week lable
		LblStart2Day.Text = GetWeekday(CboStartDate.Value)
		
		eventArgs.Cancel = Cancel
	End Sub
	
    Private Sub CboEndTime_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboEndTime.SelectedIndexChanged

        Call modControl.SelectText(CboStartTime, CboEndTime.Text)

    End Sub
	

	Private Sub CboStartDate_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboStartDate.Enter
		
        'Call modControl.HighlightText(ActiveControl)
		
	End Sub
	
	Private Sub CboStartDate_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles CboStartDate.Validating
		Dim Cancel As Boolean = eventArgs.Cancel
		
		'Update the day of week lable
		LblEnd1Day.Text = GetWeekday(CboEndDate.Value)
		'Update the day of week lable
		LblStart2Day.Text = GetWeekday(CboStartDate.Value)
		
		eventArgs.Cancel = Cancel
	End Sub
	
	Private Sub CmdCancel_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdCancel.Click
		
		Me.Close()
		
	End Sub
	
	Private Sub CmdOK_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdOK.Click
		
		On Error Resume Next
		Dim vTimeZoneDif As Short 'BJK add for time conversion 6.2x
        Dim scheduleItemPersonList As New System.Collections.Generic.List(Of ScheduleItemPerson)
        vTimeZoneDif = modStatQuery.QueryTimeZoneDif(AppMain.ParentForm.TimeZone) 'BJK add for time conversion 6.2x
		
		Dim vReturn As Short
		
		'Make sure the user wants to save
		vReturn = modMsgForm.FormSave
		
		If vReturn = MsgBoxResult.Cancel Then
			Exit Sub
		End If
		
		'Set the data to unverified
		Me.Verified = False
		
        'Validate the data
        'TODO: add validation back in. This was removed during Iteration 1 upgrade
        'If Not modStatValidate.ScheduleShift(Me) Then
        '    Exit Sub
        'End If

        'Check if the start date/time is before the end date/time
        'for the 1st shift
        If CDate(LblStartDate.Text & " " & LblStartTime.Text) >= CDate(CboEndDate.Value & " " & CboEndTime.Text) Then
            Call MsgBox("The end date/time for this shift is before the start date/time.", MsgBoxStyle.OkOnly, "Invalid Shift Dates")
            CboEndDate.Focus()
            Exit Sub
        End If

        'Check if the start date/time is before the end date/time
        'for the 2nd shift
        If CDate(CboStartDate.Value & " " & CboStartTime.Text) >= CDate(LblEndDate.Text & " " & LblEndTime.Text) Then
            Call MsgBox("The end date/time for this shift is before the start date/time.", MsgBoxStyle.OkOnly, "Invalid Shift Dates")
            CboStartDate.Focus()
            Exit Sub
        End If

        'Check if the start date/time is before the end date/time
        'for the 2nd shift
        If CDate(CboStartDate.Value & " " & CboStartTime.Text) < CDate(CboEndDate.Value & " " & CboEndTime.Text) Then
            Call MsgBox("The end date/time for the second shift is before the start date/time of the first shift.", MsgBoxStyle.OkOnly, "Invalid Shift Dates")
            CboStartDate.Focus()
            Exit Sub
        End If


        'Create a new record and
        'get the ID
        Dim scheduleItemA As New ScheduleItemPerson()
        scheduleItemA.ShiftName = TxtStartName.Text
        scheduleItemA.StartDate = LblStartDate.Text
        scheduleItemA.StartTime = LblStartTime.Text
        scheduleItemA.EndDate = CboEndDate.Text
        scheduleItemA.EndTime = CboEndTime.Text
        scheduleItemA.ScheduleItemID = ScheduleItemID
        scheduleItemA.ScheduleGroupID = ScheduleGroupID

        Dim scheduleItemB As New ScheduleItemPerson()
        scheduleItemB.ShiftName = TxtEndName.Text
        scheduleItemB.ScheduleGroupID = ScheduleGroupID
        scheduleItemB.ScheduleItemID = -1
        scheduleItemB.StartDate = CboStartDate.Text
        scheduleItemB.StartTime = CboStartTime.Text
        scheduleItemB.EndDate = LblEndDate.Text
        scheduleItemB.EndTime = LblEndTime.Text


        scheduleItemPersonList.Add(scheduleItemA)
        scheduleItemPersonList.Add(scheduleItemB)

        If AppMain.frmSchedule.SaveScheduleItem(scheduleItemPersonList) = SUCCESS Then
            'log the change
            'BJK add DateAdds for LO Time modifications v6.2x
            Call AppMain.frmSchedule.ScheduleLog("Split Shift", VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(LblStartDate.Text & " " & LblStartTime.Text)), "mm/dd/yy hh:mm") & " " & GetWeekday(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(LblStartDate.Text))) & ", " & VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(LblEndDate.Text & " " & LblEndTime.Text)), "mm/dd/yy hh:mm") & " " & GetWeekday(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(LblEndDate.Text))), "Split shift into " & VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(LblStartDate.Text & " " & LblStartTime.Text)), "mm/dd/yy hh:mm") & " " & GetWeekday(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(LblStartDate.Text))) & ", " & VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(CboEndDate.Value & " " & CboEndTime.Text)), "mm/dd/yy hh:mm") & " " & GetWeekday(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CboEndDate.Value)) & " and " & VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(CboStartDate.Value & " " & CboStartTime.Text)), "mm/dd/yy hh:mm") & " " & GetWeekday(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CboStartDate.Value)) & ", " & VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(LblEndDate.Text & " " & LblEndTime.Text)), "mm/dd/yy hh:mm") & " " & GetWeekday(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(LblEndDate.Text))) & ".")
        End If

        Me.Saved = True

        Me.Close()

    End Sub

	
	Private Sub FrmScheduleSplitShift_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load
		
        On Error GoTo localError
		
        Dim TimeSegments As New Object
		
        'Call modUtility.CenterForm()
		Me.Saved = False
		
		'Fill reference data
		If modStatRefQuery.RefQueryTimeSegment(TimeSegments) = SUCCESS Then
			Call modControl.SetTextID(CboStartTime, TimeSegments)
			Call modControl.SetTextID(CboEndTime, TimeSegments)
		End If
		
		'bjk 1/7/01 added runtime text
        '"* Times must be mountain time (" & AppMain.ParentForm.TimeZone & ")."
        Lable(4).Text = "All Times (" & AppMain.ParentForm.TimeZone & ")"
        Lable(12).Text = "All Times (" & AppMain.ParentForm.TimeZone & ")"
        Call modControl.SelectText(CboStartTime, DefaultStartTime)
        Call modControl.SelectText(CboEndTime, DefaultEndTime)
localError:
        Resume Next
        Resume
		
	End Sub
	
    Public Function Display() As Integer

        Dim dialogResult As DialogResult = Me.ShowDialog()

        Display = ScheduleItemID

    End Function

    Private Sub FrmScheduleSplitShift_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing

        If Me.Saved = True Then
            'The message was saved so just unload
            eventArgs.Cancel = False

        End If
        Dispose()
    End Sub
    Private Sub TxtEndName_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtEndName.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub
	
	Private Sub TxtStartName_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtStartName.Enter
		
		Call modControl.HighlightText(ActiveControl)
		
	End Sub

  
    Private Sub CboEndDate_TabStopChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles CboEndDate.TabStopChanged
        On Error Resume Next

        CboStartDate.Value = CboEndDate.Value
        'Update the day of week lable
        LblEnd1Day.Text = GetWeekday(CboEndDate.Value)
        'Update the day of week lable
        LblStart2Day.Text = GetWeekday(CboStartDate.Value)
    End Sub

    Private Sub CboStartDate_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles CboStartDate.TextChanged
        'Update the day of week lable
        LblStart2Day.Text = GetWeekday(CboStartDate.Value)

    End Sub

    Private Sub CboEndDate_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles CboEndDate.Click

        CboStartDate.Value = CboEndDate.Value

    End Sub
End Class