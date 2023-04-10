Option Strict Off
Option Explicit On
Friend Class FrmScheduleShiftItem
	Inherits System.Windows.Forms.Form
	
	'Form Variables
	Public FormState As Short
	Public ScheduleItemID As Integer
	Public Saved As Short
	Public ScheduleGroupID As Integer
	Public Verified As Short
	
	Public DefaultShiftName As String
	Public DefaultStartDate As String
	Public DefaultStartTime As String
	Public DefaultEndDate As String
	Public DefaultEndTime As String
	
	Public CurrentShiftName As String
	Public CurrentStartDate As String
	Public CurrentStartTime As String
	Public CurrentEndDate As String
	Public CurrentEndTime As String
	
	Public InsertShift As Boolean


	Private Sub CboEndDate_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboEndDate.Enter
		
        'Call modControl.HighlightText(ActiveControl)
		
	End Sub
	
	Private Sub CboEndDate_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles CboEndDate.Validating
		Dim Cancel As Boolean = eventArgs.Cancel
		
		'Update the day of week lable
		LblEndDay.Text = GetWeekday(CboEndDate.Value)
		
		eventArgs.Cancel = Cancel
	End Sub
	
	Private Sub CboRepeatTo_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles CboRepeatTo.Validating
		Dim Cancel As Boolean = eventArgs.Cancel
		
		On Error Resume Next
		
		'Limit the repeat to no more than 3 months in advance
        If DateDiff(Microsoft.VisualBasic.DateInterval.Month, CboStartDate.Value, CDate(CboRepeatTo.Text)) > 3 Then
            Call MsgBox("You may not repeat a shift for a period greater than 3 months.", MsgBoxStyle.OkOnly, "Date Interval")
            CboRepeatTo.Focus()
            Cancel = True
        End If
		
		eventArgs.Cancel = Cancel
	End Sub

	Private Sub CboStartDate_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboStartDate.Enter
		
        'Call modControl.HighlightText(ActiveControl)
		
	End Sub
	
	Private Sub CboStartDate_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles CboStartDate.Validating
		Dim Cancel As Boolean = eventArgs.Cancel
		
        'Update the day of week lable
        'not sure why this was here, but was causing an error when the shift overlaped 5/10 jth
        'LblEndDay.Text = GetWeekday(CboEndDate.Value)
		
		eventArgs.Cancel = Cancel
	End Sub
	
    Private Sub ChkRepeat_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkRepeat.CheckStateChanged

        On Error Resume Next

        Dim I As Short

        If ChkRepeat.CheckState = System.Windows.Forms.CheckState.Checked Then
            LblRepeat.Enabled = True
            CboRepeatTo.Enabled = True
            For I = 1 To 7
                ChkDay(I).Enabled = True
            Next I
        Else
            LblRepeat.Enabled = False
            CboRepeatTo.Enabled = False
            For I = 1 To 7
                ChkDay(I).Enabled = False
            Next I
        End If

    End Sub
	
	Private Sub CmdCancel_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdCancel.Click
		
		Me.Close()
		
	End Sub
	
	Private Sub CmdOK_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdOK.Click

		Dim vReturn As Short
		
		'Limit the repeat to no more than 3 months in advance
        If DateDiff(Microsoft.VisualBasic.DateInterval.Month, CboStartDate.Value, CDate(CboRepeatTo.Text)) > 3 Then
            Call MsgBox("You may not repeat a shift for a period greater than 3 months.", MsgBoxStyle.OkOnly, "Date Interval")
            CboRepeatTo.Focus()
            Exit Sub
        End If
		
		'Make sure the user wants to save
		vReturn = modMsgForm.FormSave
		
		If vReturn = MsgBoxResult.Cancel Then
			Exit Sub
		End If
		
		'Set the data to unverified
		Me.Verified = False
		
		'Validate the data
		If Not modStatValidate.ScheduleShiftItem(Me) Then
			Exit Sub
		End If
		
		CurrentShiftName = TxtName.Text
        CurrentStartDate = CboStartDate.Value
		CurrentStartTime = CboStartTime.Text
        CurrentEndDate = CboEndDate.Value
		CurrentEndTime = CboEndTime.Text
		
		'Check if the start date/time is before the end date/time
		If CDate(CurrentStartDate & " " & CurrentStartTime) >= CDate(CurrentEndDate & " " & CurrentEndTime) Then
			Call MsgBox("The end date/time for this shift is before the start date/time.", MsgBoxStyle.OKOnly, "Invalid Shift Dates")
			CboStartDate.Focus()
			Exit Sub
		End If
		
		If InsertShift Then
			'Check if the date/times are within the original shift
			If CDate(CurrentStartDate & " " & CurrentStartTime) <= CDate(DefaultStartDate & " " & DefaultStartTime) Then
				Call MsgBox("The start date/time of the inserted shift must be after the start date/time of the selected shift.", MsgBoxStyle.OKOnly, "Invalid Start Date/Time")
				CboStartDate.Focus()
				Exit Sub
			End If
			If CDate(CurrentEndDate & " " & CurrentEndTime) >= CDate(DefaultEndDate & " " & DefaultEndTime) Then
				Call MsgBox("The end date/time of the inserted shift must be before the end date/time of the selected shift.", MsgBoxStyle.OKOnly, "Invalid Start Date/Time")
				CboEndDate.Focus()
				Exit Sub
			End If
			
			Call modUtility.Work()
            'What is the difference between CreateShifts and InsertShifts
            Call InsertShifts()
		Else
            Call modUtility.Work()
            'What is the difference between CreateShifts and InsertShifts
			Call CreateShifts()
		End If
		
		Call modUtility.Done()
		
		Me.Close()
		
	End Sub
	
	
	
	
	Private Sub FrmScheduleShiftItem_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load
		
		On Error Resume Next
		
        Dim TimeSegments As New Object
		
		Call modUtility.CenterForm()
		Me.Left = VB6.TwipsToPixelsX(VB6.PixelsToTwipsX(Me.Left) + 1400)
		Me.Saved = False
		
		'Fill reference data
		If modStatRefQuery.RefQueryTimeSegment(TimeSegments) = SUCCESS Then
			Call modControl.SetTextID(CboStartTime, TimeSegments)
			Call modControl.SetTextID(CboEndTime, TimeSegments)
		End If
		
		If Me.FormState = NEW_RECORD Then
			
			'Set defaults
			If DefaultShiftName <> "" Then
				TxtName.Text = DefaultShiftName
			End If
			If DefaultStartDate <> "" Then
				CboStartDate.Value = DefaultStartDate
				'Update the day of week lable
				LblStartDay.Text = GetWeekday(CboStartDate.Value)
			Else
				CboStartDate.Value = VB6.Format(Today, "mm/dd/yy")
				'Update the day of week lable
				LblStartDay.Text = GetWeekday(CboStartDate.Value)
			End If
			If DefaultStartTime <> "" Then
				Call modControl.SelectText(CboStartTime, DefaultStartTime)
			End If
			If DefaultEndDate <> "" Then
				CboEndDate.Value = DefaultEndDate
				'Update the day of week lable
				LblEndDay.Text = GetWeekday(CboEndDate.Value)
			Else
				CboEndDate.Value = DateAdd(Microsoft.VisualBasic.DateInterval.Day, 1, CboStartDate.Value)
				'Update the day of week lable
				LblEndDay.Text = GetWeekday(CboEndDate.Value)
			End If
			If DefaultEndTime <> "" Then
				Call modControl.SelectText(CboEndTime, DefaultEndTime)
			End If
			
            CboRepeatTo.Text = DateTime.Today.ToString("MM/dd/yyyy")
            CboRepeatTo.Enabled = False
			
		ElseIf Me.FormState = EXISTING_RECORD Then 
			
			'Get the ScheduleShift record detail
			Call modStatQuery.QueryScheduleShiftItem(Me)
			
			DefaultShiftName = TxtName.Text
            DefaultStartDate = CboStartDate.Value
			'Update the day of week lable
			LblStartDay.Text = GetWeekday(CboStartDate.Value)
			DefaultStartTime = CboStartTime.Text
            DefaultEndDate = CboEndDate.Value
			'Update the day of week lable
			LblEndDay.Text = GetWeekday(CboEndDate.Value)
			DefaultEndTime = CboEndTime.Text
			
		End If
		
		'BJK 1/16/01 add run time text for time zone
        Lable(4).Text = "All Times (" & AppMain.ParentForm.TimeZone & ")"
		
	End Sub

	Public Function Display() As Integer
		
        Dim dialogResult As DialogResult = Me.ShowDialog()
		
		Display = ScheduleItemID
		
	End Function
	
    Private Sub FrmScheduleShiftItem_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing

        Dim vReturn As Short

        If Me.Saved = True Then
            'The message was saved so just unload
            eventArgs.Cancel = False
        End If
        Dispose()
    End Sub
    Private Sub TxtName_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtName.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub
	
    ''' <summary>
    ''' 
    ''' </summary>
    ''' <remarks></remarks>
	Public Sub CreateShifts()
		
		On Error Resume Next
		
		Dim OverlapError As Boolean
        Dim LocScheduleShiftID As Integer 'ccarroll 12/21/2010 - was Object
		Dim vDayString As String
		Dim I As Short
		Dim vTimeZoneDif As Short 'BJK add for time conversion 6.2x
		
        vTimeZoneDif = modStatQuery.QueryTimeZoneDif(AppMain.ParentForm.TimeZone) 'BJK add for time conversion 6.2x


        If ChkRepeat.CheckState = System.Windows.Forms.CheckState.Unchecked Then

            'If the shift does not repeat, then simply save it.

            'Check if the start date/time overlaps any schedule shifts before it.
            If modStatQuery.QueryScheduleOverlap(ScheduleGroupID, ScheduleItemID, CurrentStartDate & " " & CurrentStartTime, CurrentEndDate & " " & CurrentEndTime) = SUCCESS Then
                Call MsgBox("This shift overlaps an existing shift. Please change the start and/or end date and time so that it does not overlap an existing shift.", MsgBoxStyle.OKOnly, "Shift Overlap")
                CboStartDate.Focus()
                Exit Sub
            End If

            'Create a new record and
            'get the ID
            If AppMain.frmSchedule.SaveScheduleItem(ScheduleItemID, ScheduleGroupID, CurrentShiftName, CDate(CurrentStartDate), CurrentStartTime, CDate(CurrentEndDate), CurrentEndTime, False) Then

                'If modStatSave.SaveScheduleItem(Me, LocScheduleShiftID) = SUCCESS Then
                If Me.FormState = NEW_RECORD Then
                    'log the change
                    'BJK add for time conversion 6.2x
                    Call AppMain.frmSchedule.ScheduleLog("Create Shift", VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(CurrentStartDate & " " & CurrentStartTime)), "mm/dd/yy hh:mm") & " " & GetWeekday(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(CurrentStartDate))) & ", " & VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(CurrentEndDate & " " & CurrentEndTime)), "mm/dd/yy hh:mm") & " " & GetWeekday(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(CurrentEndDate))), "Created single shift.")
                Else
                    'log the change
                    'BJK add for time conversion 6.2x
                    Call AppMain.frmSchedule.ScheduleLog("Edit Shift", VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(CurrentStartDate & " " & CurrentStartTime)), "mm/dd/yy hh:mm") & " " & GetWeekday(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(CurrentStartDate))) & ", " & VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(CurrentEndDate & " " & CurrentEndTime)), "mm/dd/yy hh:mm") & " " & GetWeekday(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(CurrentEndDate))), "Edited shift from " & VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(DefaultStartDate & " " & DefaultStartTime)), "mm/dd/yy hh:mm") & " " & GetWeekday(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(DefaultStartDate))) & ", " & VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(DefaultEndDate & " " & DefaultEndTime)), "mm/dd/yy hh:mm") & " " & GetWeekday(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(DefaultEndDate))) & " to " & VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(CurrentStartDate & " " & CurrentStartTime)), "mm/dd/yy hh:mm") & " " & GetWeekday(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(CurrentStartDate))) & ", " & VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(CurrentEndDate & " " & CurrentEndTime)), "mm/dd/yy hh:mm") & " " & GetWeekday(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(CurrentEndDate))) & ".")
                End If
                Me.ScheduleItemID = ScheduleItemID
            End If

            Me.Saved = True

        Else

            OverlapError = False

            'First save the original shift

            'Check if the start date/time overlaps any schedule shifts before it.
            If modStatQuery.QueryScheduleOverlap(ScheduleGroupID, ScheduleItemID, CurrentStartDate & " " & CurrentStartTime, CurrentEndDate & " " & CurrentEndTime) = SUCCESS Then
                OverlapError = True
            End If

            'Create a string representing the selected days of the week
            For I = 1 To 7
                If ChkDay(I).CheckState = System.Windows.Forms.CheckState.Checked Then
                    If vDayString = "" Then
                        vDayString = GetWeekdayByInt(I)
                    Else
                        vDayString = vDayString & ", " & GetWeekdayByInt(I)
                    End If
                End If
            Next I

            'Create a new record and get the ID
            If modStatSave.SaveScheduleItem(Me, LocScheduleShiftID) = SUCCESS Then
                'log the change
                'BJK add for time conversion 6.2x
                Call AppMain.frmSchedule.ScheduleLog("Create Shift", VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(CurrentStartDate & " " & CurrentStartTime)), "mm/dd/yy hh:mm") & " " & GetWeekday(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(CurrentStartDate))) & ", " & VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(CurrentEndDate & " " & CurrentEndTime)), "mm/dd/yy hh:mm") & " " & GetWeekday(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(CurrentEndDate))), "Created multiple shifts through " & Int32.Parse(CboRepeatTo.Text) & " for the days " & vDayString & ".")

                Me.ScheduleItemID = LocScheduleShiftID
            End If

            'Save repeating shifts until the start date is greater than the repeat to date
            Do Until CDate(CurrentStartDate) >= CDate(CboRepeatTo.Text.ToString())

                'Increment the start and end date by 1 day
                CurrentStartDate = CStr(DateAdd(Microsoft.VisualBasic.DateInterval.Day, 1, CDate(CurrentStartDate)))
                CurrentEndDate = CStr(DateAdd(Microsoft.VisualBasic.DateInterval.Day, 1, CDate(CurrentEndDate)))

                'Check if the new start day name is checked
                'If so then save the shift
                If ChkDay(Weekday(CDate(CurrentStartDate))).CheckState = System.Windows.Forms.CheckState.Checked Then
                    'Check if the start date/time overlaps any schedule shifts before it.
                    If modStatQuery.QueryScheduleOverlap(ScheduleGroupID, ScheduleItemID, CurrentStartDate & " " & CurrentStartTime, CurrentEndDate & " " & CurrentEndTime) = SUCCESS Then
                        OverlapError = True
                    Else
                        'Create a new record and get the ID
                        If modStatSave.SaveScheduleItem(Me, LocScheduleShiftID) = SUCCESS Then
                            Me.ScheduleItemID = LocScheduleShiftID
                        End If
                    End If
                End If

            Loop

            If OverlapError = True Then
                Call MsgBox("At least one repeated shift overlapped an existing shift. Any repeated shift overlapping an existing shift was not saved. Please check to ensure your shifts were saved correctly.", MsgBoxStyle.OkOnly, "Shift Overlap")
            End If

            Me.Saved = True

        End If

    End Sub
    Public Sub InsertShifts()

        On Error Resume Next

        Dim InsertShiftName As String
        Dim InsertShiftAbbrv As String
        Dim InsertStartDate As String
        Dim InsertStartTime As String
        Dim InsertEndDate As String
        Dim InsertEndTime As String
        Dim LocScheduleShiftID As Integer
        Dim vTimeZoneDif As Short 'BJK add for time conversion 6.2x

        vTimeZoneDif = modStatQuery.QueryTimeZoneDif(AppMain.ParentForm.TimeZone) 'BJK add for time conversion 6.2x

        'To insert a shift, the existing (selected) shift must be modified and
        'then two new shifts must be created

        'Save the current field values
        InsertShiftName = CurrentShiftName
        InsertStartDate = CurrentStartDate
        InsertStartTime = CurrentStartTime
        InsertEndDate = CurrentEndDate
        InsertEndTime = CurrentEndTime

        'Modify the end date of the existing record
        CurrentShiftName = DefaultShiftName
        CurrentStartDate = DefaultStartDate
        CurrentStartTime = DefaultStartTime
        CurrentEndDate = InsertStartDate
        CurrentEndTime = InsertStartTime
        Me.FormState = EXISTING_RECORD
        If modStatSave.SaveScheduleItem(Me, LocScheduleShiftID) = SUCCESS Then
            Me.ScheduleItemID = LocScheduleShiftID
        End If

        'Create the inserted shift
        CurrentShiftName = InsertShiftName
        CurrentStartDate = InsertStartDate
        CurrentStartTime = InsertStartTime
        CurrentEndDate = InsertEndDate
        CurrentEndTime = InsertEndTime
        Me.FormState = NEW_RECORD

        If modStatSave.SaveScheduleItem(Me, LocScheduleShiftID) = SUCCESS Then
            'log the change
            'BJK add for time conversion 6.2x
            Call AppMain.frmSchedule.ScheduleLog("Insert Shift", VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(CurrentStartDate & " " & CurrentStartTime)), "mm/dd/yy hh:mm") & " " & GetWeekday(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(CurrentStartDate))) & ", " & VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(CurrentEndDate & " " & CurrentEndTime)), "mm/dd/yy hh:mm") & " " & GetWeekday(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(CurrentEndDate))), "Inserted shift between " & VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(DefaultStartDate & " " & DefaultStartTime)), "mm/dd/yy hh:mm") & " " & GetWeekday(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(DefaultStartDate))) & " and " & VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(DefaultEndDate & " " & DefaultEndTime)), "mm/dd/yy hh:mm") & " " & GetWeekday(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -vTimeZoneDif, CDate(DefaultEndDate))) & ".")
            Me.ScheduleItemID = LocScheduleShiftID
        End If

        'Create the remaining portion of the existing shift
        CurrentShiftName = DefaultShiftName
        CurrentStartDate = InsertEndDate
        CurrentStartTime = InsertEndTime
        CurrentEndDate = DefaultEndDate
        CurrentEndTime = DefaultEndTime
        Me.FormState = NEW_RECORD
        If modStatSave.SaveScheduleItem(Me, LocScheduleShiftID) = SUCCESS Then
            Me.ScheduleItemID = LocScheduleShiftID
        End If

        'Get the people of the existing record and save the same people
        'for the remaining portion of the existing shift

        Me.Saved = True

    End Sub
	
	
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
	Public Function GetWeekdayByInt(ByVal pvWeekdayInt As Short) As String
		
		Select Case pvWeekdayInt
			Case 1
				GetWeekdayByInt = "Sun"
			Case 2
				GetWeekdayByInt = "Mon"
			Case 3
				GetWeekdayByInt = "Tues"
			Case 4
				GetWeekdayByInt = "Wed"
			Case 5
				GetWeekdayByInt = "Thur"
			Case 6
				GetWeekdayByInt = "Fri"
			Case 7
				GetWeekdayByInt = "Sat"
			Case Else
				GetWeekdayByInt = ""
		End Select
		
	End Function

    Private Sub CboStartDate_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles CboStartDate.TextChanged

        'Update the day of week lable
        LblStartDay.Text = GetWeekday(CboStartDate.Value)


    End Sub

    Private Sub CboEndDate_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles CboEndDate.TextChanged

        'Update the day of week lable
        LblEndDay.Text = GetWeekday(CboEndDate.Value)

    End Sub
End Class