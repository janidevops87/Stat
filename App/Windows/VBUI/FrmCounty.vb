Option Strict Off
Option Explicit On
Friend Class FrmCounty
	Inherits System.Windows.Forms.Form
	
	'Form Variables
	Dim fvFormState As Short
	Dim fvCountyID As Integer
	Dim fvVerified As Short
	Dim fvSaved As Short
	
	Dim fvDefaultState As Integer
	
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
	
	
	
	
	Public Property CountyID() As Short
		Get
			
			CountyID = fvCountyID
			
		End Get
		Set(ByVal Value As Short)
			
			fvCountyID = Value
			
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
	
	
	Public Property DefaultState() As Short
		Get
			
			DefaultState = fvDefaultState
			
		End Get
		Set(ByVal Value As Short)
			
			fvDefaultState = Value
			
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
		If Not modStatValidate.County(Me) Then
			Exit Sub
		End If
		
		'Create a new record and
		'get the ID
		Me.CountyID = modStatSave.SaveCounty(Me)
		Me.Saved = True
		
		Me.Close()
		
	End Sub
	
	
	
	
	Private Sub FrmCounty_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load
		
		Call modUtility.CenterForm()
		Me.Saved = False
		
		Call modStatRefQuery.RefQueryState(CboState)
		
		If Me.FormState = NEW_RECORD Then
			
			'Set the state list to the default
			Call modControl.SelectID(CboState, Me.DefaultState)
			
		ElseIf Me.FormState = EXISTING_RECORD Then 
			
			'Get the County record detail
			Call modStatQuery.QueryCounty(Me)
			
		End If
		
		
		
	End Sub
	
	Public Function Display() As Integer
		
        Dim dialogResult As DialogResult = Me.ShowDialog()
		
		Display = fvCountyID
		
	End Function
	
	
	
    Private Sub FrmCounty_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing

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
        'Dispose()
    End Sub
End Class
