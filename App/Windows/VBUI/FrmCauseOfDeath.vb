Option Strict Off
Option Explicit On
Friend Class FrmCauseOfDeath
	Inherits System.Windows.Forms.Form
	
	'Form Variables
	Dim fvFormState As Short
	Dim fvCauseOfDeathID As Integer
	Dim fvVerified As Short
	Dim fvSaved As Short
	
	
	Public Property Saved() As Short
		Get
			
			Saved = fvSaved
			
		End Get
		Set(ByVal Value As Short)
			
			fvSaved = Value
			
		End Set
	End Property
	
	Public Property FormState() As Short
		Get
			
			FormState = fvFormState
			
		End Get
		Set(ByVal Value As Short)
			
			fvFormState = Value
			
		End Set
	End Property
	
	
	
	
	Public Property CauseOfDeathID() As String
		Get
			
			CauseOfDeathID = CStr(fvCauseOfDeathID)
			
		End Get
		Set(ByVal Value As String)
			
			fvCauseOfDeathID = CInt(Value)
			
		End Set
	End Property
	
	
	
	Public Property Verified() As Short
		Get
			
			Verified = fvVerified
			
		End Get
		Set(ByVal Value As Short)
			
			fvVerified = modConv.TextToInt(CStr(Value))
			
		End Set
	End Property
	
	
	Public Function Display() As Integer
		
		Me.ShowDialog()
		
		Display = fvCauseOfDeathID
		
	End Function
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
		If Not modStatValidate.CauseOfDeath(Me) Then
			Exit Sub
		End If

        'Create a new record and
        'get the ID
        Me.CauseOfDeathID = modStatSave.SaveCauseOfDeath(Me)
        Me.Saved = True

        Me.Close()

    End Sub


    Private Sub FrmCauseOfDeath_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load

        Call modUtility.CenterForm()

        If Me.FormState = NEW_RECORD Then

            'Just display the form.

        ElseIf Me.FormState = EXISTING_RECORD Then

            'Get the organization record detail
            Call modStatQuery.QueryCauseOfDeath(Me)

        End If



    End Sub








    Private Sub FrmCauseOfDeath_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing

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

    End Sub
End Class