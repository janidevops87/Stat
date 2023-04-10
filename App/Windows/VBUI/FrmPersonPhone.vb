Option Strict Off
Option Explicit On
Friend Class FrmPersonPhone
	Inherits System.Windows.Forms.Form
	
	'Form Variables
	Dim fvFormState As Short
	Dim fvPhoneID As Integer
	Dim fvPersonID As Integer
	Dim fvSaved As Short
	Public Property FormState() As Object
		Get

            FormState = fvFormState

        End Get
        Set(ByVal Value As Object)

            fvFormState = Value

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

    Public Property PhoneID() As Object
        Get

            PhoneID = fvPhoneID

        End Get
        Set(ByVal Value As Object)

            fvPhoneID = Value

        End Set
    End Property


    Public Property PersonID() As Object
        Get

            PersonID = fvPersonID

        End Get
        Set(ByVal Value As Object)

            fvPersonID = Value

        End Set
    End Property


    Private Sub CboPhoneType_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboPhoneType.SelectedIndexChanged
        '************************************************************************************
        'Name: CboPhoneType_Click
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Updates controls depending on content of CboPhoneType
        'Returns: Nothing
        'Params: None
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 11/26/04                         Changed by: Scott Plummer
        'Release #: 7.7.2                               Task: 312
        'Description:  Added Email type to combo box (added in dbo.PhoneType)
        '====================================================================================
        '************************************************************************************

        'If an alpha pager enable the alpha pager fields,
        'otherwise disable them.
        If modControl.GetID(CboPhoneType) = 7 Then
            LblAlpha.Enabled = True
            TxtAlpha.Enabled = True
        ElseIf modControl.GetID(CboPhoneType) = 8 Then  'mjd 05/28/2002 Page-AutoResponse
            LblAlpha.Enabled = True 'mjd 05/28/2002 Page-AutoResponse
            TxtAlpha.Enabled = True 'mjd 05/28/2002 Page-AutoResponse
        ElseIf modControl.GetID(CboPhoneType) = 11 Then  'Added Email type (Id = 11) 11/26/04 - SAP
            LblAlpha.Enabled = True
            TxtAlpha.Enabled = True
        Else
            LblAlpha.Enabled = False
            TxtAlpha.Enabled = False
            TxtAlpha.Text = ""
        End If


    End Sub

    Private Sub CboPhoneType_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles CboPhoneType.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        'Allow the delete key to clear the combo box
        Call modControl.AllowDelete(CboPhoneType, KeyAscii)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub
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

        'Validate the data
        If Not modStatValidate.Phone(Me) Then
            Exit Sub
        End If

        'Save the Phone information
        Me.PhoneID = modStatSave.SavePersonPhone(Me)

        Me.Saved = True

        Me.Close()

    End Sub
    Private Sub FrmPersonPhone_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load

        Call modUtility.CenterForm()

        Me.Saved = False

        Call modStatRefQuery.ListRefQueryPhoneType(CboPhoneType)

        If Me.FormState = NEW_RECORD Then

            'Show the form

        ElseIf Me.FormState = EXISTING_RECORD Then

            'Set the values
            Call modStatQuery.QueryPersonPhone(Me)

        End If



    End Sub
    Public Function Display() As Object

        Dim dialoResult As DialogResult = Me.ShowDialog()

        Display = Me.PhoneID

    End Function
    Private Sub FrmPersonPhone_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing

        Dim vReturn As Short

        If Me.Saved = True Then
            'The phone was saved so just unload
            eventArgs.Cancel = False

        Else
            'The phone was cancelled or closed so confirm
            vReturn = modMsgForm.FormCancel

            If vReturn = MsgBoxResult.Yes Then

                'Set the first element to nothing
                'to indicate the user cancelled
                Dim fvPhoneRow(0) As Object
                fvPhoneRow(0) = ""

                eventArgs.Cancel = False


            Else
                eventArgs.Cancel = True
                Exit Sub
            End If

        End If
        'Dispose()
    End Sub

    Private Sub TxtPhone_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtPhone.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub

    Private Sub TxtPhone_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtPhone.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        KeyAscii = modMask.PhoneMask(KeyAscii, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtPIN_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtPIN.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        KeyAscii = modMask.NumMask(KeyAscii, 10, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
		If KeyAscii = 0 Then
			eventArgs.Handled = True
		End If
	End Sub
End Class