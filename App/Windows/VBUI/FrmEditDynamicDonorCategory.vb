Option Strict Off
Option Explicit On
Friend Class FrmEditDynamicDonorCategory
	Inherits System.Windows.Forms.Form
	
	'Form Variables
	Dim fvDynamicDonorCategoryID As Integer
    Dim fvDonorCategoryName As String = ""
	Dim fvVerified As Short
	Dim fvSaved As Short
	
	
	Private Sub CmdCancel_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdCancel.Click
		Me.Close()
	End Sub
	
	Private Sub cmdSave_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdSave.Click
		Dim vReturn As Short
		
		'Make sure the user wants to save
		vReturn = modMsgForm.FormSave
		
		If vReturn = MsgBoxResult.Cancel Then
			Exit Sub
		End If
		
		'Set the data to unverified
		Me.Verified = False
		
		'Validate the data
		If Not modStatValidate.CriteriaGroup(Me) Then
			Exit Sub
		End If

        'Create a new record and
        'get the ID
        Me.DynamicDonorCategoryID = modStatSave.SaveDynamicDonorCategory(Me)
        Me.Saved = True

        Me.Close()
    End Sub

    Private Sub FrmEditDynamicDonorCategory_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load

        Call modUtility.CenterForm()

        If fvDynamicDonorCategoryID = NEW_RECORD Then

            'Just display the form.

        ElseIf fvDynamicDonorCategoryID >= EXISTING_RECORD Then

            'Get the organization record detail
            Call modStatQuery.QueryDynamicDonorCriteriaGroup(Me)

        End If

    End Sub
    Public Property DonorCategoryName() As Object
        Get

            DonorCategoryName = fvDonorCategoryName

        End Get
        Set(ByVal Value As Object)

            fvDonorCategoryName = Value

        End Set
    End Property
    Public Property DynamicDonorCategoryID() As Object
        Get

            DynamicDonorCategoryID = fvDynamicDonorCategoryID

        End Get
        Set(ByVal Value As Object)

            fvDynamicDonorCategoryID = Value

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

    Public Property Saved() As Object
        Get

            Saved = fvSaved

        End Get
        Set(ByVal Value As Object)

            fvSaved = Value

        End Set
    End Property
    Public Function Display() As Integer

        Dim dialogResult As DialogResult = Me.ShowDialog()

        Display = fvDynamicDonorCategoryID
    End Function

    Private Sub FrmEditDynamicDonorCategory_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing
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
	
	Private Sub TxtName_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtName.KeyPress
		Dim KeyAscii As Short = Asc(eventArgs.KeyChar)
		If KeyAscii = 13 Then
			cmdSave_Click(cmdSave, New System.EventArgs())
		End If
		eventArgs.KeyChar = Chr(KeyAscii)
		If KeyAscii = 0 Then
			eventArgs.Handled = True
		End If
	End Sub
End Class