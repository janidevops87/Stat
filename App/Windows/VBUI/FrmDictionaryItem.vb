Option Strict Off
Option Explicit On
Friend Class FrmDictionaryItem
	Inherits System.Windows.Forms.Form
	
	'Form Variables
	Dim fvFormState As Short
	Dim fvDictionaryItemID As Integer
	Dim fvVerified As Short
	Dim fvSaved As Short
	
    Private frmMisspelling As FrmMisspelling
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

    Public Property DictionaryItemID() As Object
        Get

            DictionaryItemID = fvDictionaryItemID

        End Get
        Set(ByVal Value As Object)

            fvDictionaryItemID = Value

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

    Private Sub CmdAdd_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdAdd.Click

        Dim vDictionaryItemMisspellingID As Integer

        On Error Resume Next

        'Determine the state which to open the
        'form.
        frmMisspelling = New FrmMisspelling
        frmMisspelling.FormState = NEW_RECORD
        frmMisspelling.DictionaryItemID = Me.DictionaryItemID
        frmMisspelling.DictionaryItemMisspellingID = 0

        'Get the DictionaryItem id from the DictionaryItem form
        'after the user is done.
        vDictionaryItemMisspellingID = frmMisspelling.Display

        If vDictionaryItemMisspellingID = 0 Then
            'The user cancelled adding a new DictionaryItem
            'so do nothing
        Else
            'Refill the list box with the new (or updated)
            'DictionaryItem id and name
            LstMisspellings.Items.Clear()
            Call modStatQuery.QueryDictionaryItemMisspelling(Me)
        End If

    End Sub

    Private Sub CmdCancel_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdCancel.Click

        Me.Close()

    End Sub

    Private Sub CmdEdit_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdEdit.Click

        Dim vDictionaryItemMisspellingID As Integer
        Dim vReturn As New Object

        On Error Resume Next

        'Determine the state which to open the
        'form.
        frmMisspelling = New FrmMisspelling

        frmMisspelling.FormState = EXISTING_RECORD
        frmMisspelling.DictionaryItemID = Me.DictionaryItemID
        Call modControl.GetSelID(LstMisspellings, vReturn)
        If vReturn(0) < 1 Then
            'Nothing is selected, so don't show the cause of death form
            Exit Sub
        Else
            frmMisspelling.DictionaryItemMisspellingID = vReturn(0)
        End If

        'Get the DictionaryItemMisspelling id from the DictionaryItemMisspelling form
        'after the user is done.
        vDictionaryItemMisspellingID = frmMisspelling.Display

        If vDictionaryItemMisspellingID = 0 Then
            'The user cancelled adding a new DictionaryItemMisspelling
            'so do nothing
        Else
            'Refill the with the new (or updated)
            'DictionaryItemMisspelling id and name
            LstMisspellings.Items.Clear()
            Call modStatQuery.QueryDictionaryItemMisspelling(Me)

        End If

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
        If Not modStatValidate.DictionaryItem(Me) Then
            Exit Sub
        End If

        'Create a new record and
        'get the ID
        Me.DictionaryItemID = modStatSave.SaveDictionaryItem(Me)
        Me.Saved = True

        'Make sure the user wants to close
        vReturn = modMsgForm.FormClose

        If vReturn = MsgBoxResult.No Then
            Me.FormState = EXISTING_RECORD
            CmdAdd.Enabled = True
            cmdEdit.Enabled = True
        Else
            Me.Close()
        End If

        Call modUtility.Done()

    End Sub





    Private Sub cmdTest_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdTest.Click

        Call modStatValidate.ValidateSpelling(TxtCorrect)

    End Sub

    Private Sub FrmDictionaryItem_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load

        Call modUtility.CenterForm()
        Me.Saved = False

        If Me.FormState = NEW_RECORD Then

            CmdAdd.Enabled = False
            cmdEdit.Enabled = False
			
		ElseIf Me.FormState = EXISTING_RECORD Then 
			
			CmdAdd.Enabled = True
			cmdEdit.Enabled = True

            'Get the DictionaryItem record detail
            Call modStatQuery.QueryDictionaryItem(Me)

            'Get the item misspellings
            Call modStatQuery.QueryDictionaryItemMisspelling(Me)

        End If

    End Sub

    Public Function Display() As Integer

        Dim dialogResult As DialogResult = Me.ShowDialog()

        Display = fvDictionaryItemID

    End Function









    Private Sub FrmDictionaryItem_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing

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





    Private Sub LstMisspellings_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstMisspellings.SelectedIndexChanged

        TxtCorrect.Text = modControl.GetText(LstMisspellings)

    End Sub

    Private Sub LstMisspellings_DoubleClick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstMisspellings.DoubleClick
		
		Call CmdEdit_Click(CmdEdit, New System.EventArgs())
		
	End Sub
End Class