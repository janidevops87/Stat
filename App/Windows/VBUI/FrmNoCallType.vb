Option Strict Off
Option Explicit On
Friend Class FrmNoCallType
	Inherits System.Windows.Forms.Form
	
	'Form Variables
	Dim fvFormState As Short
	Dim fvNoCallTypeID As Integer
	Dim fvVerified As Short
	Dim fvSaved As Short
	
	
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




    Public Property NoCallTypeID() As Object
        Get

            NoCallTypeID = fvNoCallTypeID

        End Get
        Set(ByVal Value As Object)

            fvNoCallTypeID = Value

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


    Public Function Display() As Integer

        Dim dialogResult As DialogResult = Me.ShowDialog()

        Display = fvNoCallTypeID

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
        If Not modStatValidate.NoCallType(Me) Then
            Exit Sub
        End If

        'Insert or update the record
        Me.NoCallTypeID = modStatSave.SaveNoCallType(Me)
        Me.Saved = True

        Me.Close()

    End Sub


    Private Sub FrmNoCallType_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load

        Call modUtility.CenterForm()
        Me.Saved = False

        If Me.FormState = NEW_RECORD Then

            'Just display the form.

        ElseIf Me.FormState = EXISTING_RECORD Then

            'Get the organization record detail
            Call modStatQuery.QueryNoCallType(Me)

        End If



    End Sub







    Private Sub FrmNoCallType_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing

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

        'Me.Dispose()
    End Sub
End Class
