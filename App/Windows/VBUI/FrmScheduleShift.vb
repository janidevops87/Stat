Option Strict Off
Option Explicit On
Friend Class FrmScheduleShift
	Inherits System.Windows.Forms.Form
	
	'Form Variables
	Dim fvFormState As Short
	Dim fvScheduleShiftID As Integer
	Dim fvVerified As Short
	Dim fvSaved As Short
	Dim fvScheduleGroupID As Integer
	
	Public Property Saved() As Object
		Get
			
            Saved = fvSaved
			
		End Get
		Set(ByVal Value As Object)
			
            fvSaved = Value
			
		End Set
	End Property
	
	Public Property FormState() As Object
		Get
			
            FormState = fvFormState
			
		End Get
		Set(ByVal Value As Object)
			
            fvFormState = Value
			
		End Set
	End Property
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	Public Property ScheduleShiftID() As Object
		Get

            ScheduleShiftID = fvScheduleShiftID

        End Get
        Set(ByVal Value As Object)

            fvScheduleShiftID = Value

        End Set
    End Property


    Public Property Verified() As Object
        Get

            Verified = fvVerified

        End Get
        Set(ByVal Value As Object)

            fvVerified = modConv.TextToInt(Value)

        End Set
    End Property




    Public Property ScheduleGroupID() As Object
        Get

            ScheduleGroupID = fvScheduleGroupID

        End Get
        Set(ByVal Value As Object)

            fvScheduleGroupID = Value

        End Set
    End Property

    Private Sub CmdCancel_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdCancel.Click

        Me.Close()

    End Sub

    Private Sub CmdOK_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdOK.Click

        Dim vReturn As Short

        'Make sure the user wants to save
        vReturn = modMsgForm.FormSave

        If vReturn = MsgBoxResult.Cancel Then
            Exit Sub
        End If

        'Set the data to unverified
        Me.Verified = False

        'Validate the data
        If Not modStatValidate.ScheduleShift(Me) Then
            Exit Sub
        End If

        'Create a new record and
        'get the ID
        Me.ScheduleShiftID = modStatSave.SaveScheduleShift(Me)
        Me.Saved = True

        Me.Close()

    End Sub




    Private Sub FrmScheduleShift_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load

        Call modUtility.CenterForm()
        Me.Saved = False

        'Fill reference data
        Call modStatRefQuery.ListRefQueryWeekday(CboDay)

        If Me.FormState = NEW_RECORD Then

            'Do nothing

        ElseIf Me.FormState = EXISTING_RECORD Then

            'Get the ScheduleShift record detail
            Call modStatQuery.QueryScheduleShift3(Me)

        End If

        'BJK 01/16/01 add time zone runtime text
        Lable(4).Text = "All Times (" & AppMain.ParentForm.TimeZone & ")"

    End Sub

    Public Function Display() As Integer

        Dim dialogResult As DialogResult = Me.ShowDialog()

        Display = fvScheduleShiftID

    End Function








    Private Sub FrmScheduleShift_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing

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
        Dispose()
    End Sub




    Private Sub TxtEnd_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtEnd.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        KeyAscii = modMask.TimeMask(KeyAscii, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtStart_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtStart.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        KeyAscii = modMask.TimeMask(KeyAscii, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
		If KeyAscii = 0 Then
			eventArgs.Handled = True
		End If
	End Sub
End Class