Option Strict Off
Option Explicit On
Friend Class FrmPerson
	Inherits System.Windows.Forms.Form
	
	Public vOldTextFirst As String
	Public vOldTextLast As String
	Public vConfirmChange As Short
	Public fvPhysician As String
    Public originalTxtNote As String
    Public originalTempNote As String
    Public modalParent As Object
	'Form Variables
	Dim fvFormState As Short
	Dim fvPersonID As Integer
	Dim fvSortOrder As Short
	Dim fvVerified As Short
	Dim fvSaved As Short
	
	
	Dim fvDefaultOrganizationID As Integer
    Dim fvDefaultOrganizationName As String = ""
    Dim fvLeaseOrganization As Short
    '03/2010 bret add Form References
    Private frmPersonPhone As FrmPersonPhone
    Private frmOrganization As FrmOrganization
    Private frmPersonProperties As FrmPersonProperties

	Public Property LeaseOrganization() As Object
		Get
            LeaseOrganization = fvLeaseOrganization
        End Get
        Set(ByVal Value As Object)
            fvLeaseOrganization = Value

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

    Public Property FormState() As Object
        Get

            FormState = fvFormState

        End Get
        Set(ByVal Value As Object)

            fvFormState = Value

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


    Public Property Verified() As Object
        Get

            Verified = fvVerified

        End Get
        Set(ByVal Value As Object)

            fvVerified = modConv.TextToInt(Value)

        End Set
    End Property






    Public Property DefaultOrganizationID() As Object
        Get

            DefaultOrganizationID = fvDefaultOrganizationID

        End Get
        Set(ByVal Value As Object)

            fvDefaultOrganizationID = Value

        End Set
    End Property







    Public Property DefaultOrganizationName() As Object
        Get

            DefaultOrganizationName = fvDefaultOrganizationName

        End Get
        Set(ByVal Value As Object)

            fvDefaultOrganizationName = Value

        End Set
    End Property


    Public Property SortOrder() As Object
        Get

            SortOrder = fvSortOrder

        End Get
        Set(ByVal Value As Object)

            fvSortOrder = Value

        End Set
    End Property

    Private Sub CboOrganization_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles CboOrganization.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        'Allow the delete key to clear the combo box
        Call modControl.AllowDelete(CboOrganization, KeyAscii)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub CboPersonType_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles CboPersonType.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        'Allow the delete key to clear the combo box
        Call modControl.AllowDelete(CboPersonType, KeyAscii)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub Check1_Click()

    End Sub

    Private Sub ChkAlpha_Click()


    End Sub

    Private Sub ChkBusy_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkBusy.CheckStateChanged
        'bjk 07/24/02 removed TimeZone changes
        'Dim vTimeZoneDif%
        'vTimeZoneDif = modStatQuery.QueryTimeZoneDif(AppMain.ParentForm.TimeZone)

        If ChkBusy.CheckState = 1 Then
            'TxtBusyUntil.Text = Format(DateAdd("h", 8, DateAdd("h", -vTimeZoneDif, Now)), "mm/dd/yy  hh:mm")
            TxtBusyUntil.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, 8, Now), "mm/dd/yy  hh:mm")
            TxtBusyUntil.Enabled = True
        Else
            TxtBusyUntil.Text = ""
            TxtBusyUntil.Enabled = False
        End If

    End Sub

    Private Sub ChkTempNote_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkTempNote.CheckStateChanged
        'bjk 05/16/02
        'Dim vTimeZoneDif%
        'vTimeZoneDif = modStatQuery.QueryTimeZoneDif(AppMain.ParentForm.TimeZone)


        If ChkTempNote.CheckState = 1 Then
            'bjk 5/16/02
            'TxtTempExpires.Text = Format(DateAdd("h", 8, DateAdd("h", vTimeZoneDif, Now)), "mm/dd/yy  hh:mm")
            TxtTempExpires.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, 8, Now), "mm/dd/yy  hh:mm")
            TxtTempExpires.Enabled = True
            TxtTempNotes.Text = TxtNotes.Text
            TxtTempNotes.Enabled = True
        Else
            TxtTempExpires.Text = ""
            TxtTempExpires.Enabled = False
            TxtTempNotes.Text = ""
            TxtTempNotes.Enabled = False
        End If

    End Sub

    Private Sub CmdCancel_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdCancel.Click

        Me.Close()

    End Sub

    Private Sub CmdDelete_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdDelete.Click
        Dim vResult As Short

        vResult = MsgBox("You are about to delete a person's phone number. This action cannot be undone!!! Are you sure you want to continue?", MsgBoxStyle.YesNo + MsgBoxStyle.DefaultButton2, "Delete Person's Phone")

        Select Case vResult
            Case MsgBoxResult.Yes


                vResult = MsgBox("You are *really* sure you want to delete a person's phone number. Once it's gone, it's gone. This is your last chance. With this in mind, are you *positive* you want to continue?", MsgBoxStyle.YesNo + MsgBoxStyle.DefaultButton2, "Delete Person's phone")
                If vResult = MsgBoxResult.Yes Then
                    'Delete the PersonPhone
                    Call modStatSave.DeletePersonPhone(Me)

                    'Clear the list
                    LstViewPhone.Items.Clear()
                    LstViewPhone.View = View.Details

                    'Update the row data
                    If modStatQuery.QueryPersonPhone(Me) = NO_DATA Then
                        CmdOpen.Enabled = False
                    Else
                        CmdOpen.Enabled = True
                    End If
                Else
                    Exit Sub
                End If
            Case MsgBoxResult.No
                Exit Sub
        End Select

    End Sub

    Private Sub CmdNew_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdNew.Click

        Dim vPhoneID As Integer

        On Error Resume Next

        frmPersonPhone = New FrmPersonPhone()
        'Determine the state which to open the
        'form.
        frmPersonPhone.FormState = NEW_RECORD
        frmPersonPhone.PhoneID = 0
        frmPersonPhone.PersonID = Me.PersonID

        'Get the Phone id from the Phone form
        'after the user is done.
        vPhoneID = frmPersonPhone.Display
        frmPersonPhone = Nothing

        If vPhoneID = 0 Then
            'The user cancel adding a new row,
            'so do nothing
        Else
            'Clear the list
            LstViewPhone.Items.Clear()
            LstViewPhone.View = View.Details

            'Update the row data
            If modStatQuery.QueryPersonPhone(Me) = NO_DATA Then
                CmdOpen.Enabled = False
            Else
                CmdOpen.Enabled = True
            End If

        End If

    End Sub

    Private Sub CmdOK_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdOK.Click
        '====================================================================================
        'Date Changed: 12/28/05                           Changed by: Char Chaput
        'Release #: 7.7.36
        'Description:  Added a message box display when the name changes so
        'Notification to the user shall appear when a persons name has changed
        '====================================================================================

        Dim vReturn As Short
        Dim vText As New Object

        If Len(TxtNotes.Text) = 0 And originalTxtNote <> TxtNotes.Text Then
            TxtNotes.Text = " "
        End If
        If Len(TxtTempNotes.Text) = 0 And originalTempNote <> TxtTempNotes.Text Then
            TxtTempNotes.Text = " "
        End If
        'Char Chaput 05/03/06 this is set from FrmReferral just send back the phone number and
        'unload frmperson
        If Me.CmdOK.Text = "Add Phone # to Referral" Then
            If Me.LstViewPhone.Items.Count > 0 Then
                Me.LstViewPhone.Select()
                If Me.fvPhysician = "Attending" Then
                    modalParent.TxtAttendingPhone.Text = Me.LstViewPhone.FocusedItem.Text
                Else
                    modalParent.TxtPronouncingPhone.Text = Me.LstViewPhone.FocusedItem.Text
                End If
            End If
            Me.Saved = True
            Me.Close()
            Exit Sub
        End If


        'Make sure the user wants to save
        vReturn = modMsgForm.FormSave

        If vReturn = MsgBoxResult.Cancel Then 'return to form if cancel is pressed
            Exit Sub
        End If

        'Set the data to unverified
        Me.Verified = False

        'Validate the data
        ''Validates FirstName, LastName, Organization, PersonType
        If Not modStatValidate.Person(Me) Then
            Exit Sub
        End If

        If Me.FormState = NEW_RECORD Then
            'Create a new record and
            'get the ID
            Me.PersonID = modStatSave.SavePerson(Me)
            Me.Saved = True
        Else

            'Char Chaput 12/14/2005 Display a person change message requesting the change confirmation
            'to the user Release 7.7.36
            If vOldTextLast <> Me.TxtLast.Text Or vOldTextFirst <> Me.TxtFirst.Text Then

                vText = "You have changed the Person name from " & Chr(13) & Chr(13) & vOldTextFirst & " " & vOldTextLast & Chr(13) & "to" & Chr(13) & Me.TxtFirst.Text & " " & Me.TxtLast.Text & Chr(13) & Chr(13) & "Do you wish to change this name? Selecting Yes will save the name change."

                vConfirmChange = MsgBox(vText, MsgBoxStyle.Information + MsgBoxStyle.YesNoCancel, "Confirmation of Person Name Change")

            End If

            'Char Chaput 12/14/2005 User clicked yes to confirm the change or there was no change
            If vConfirmChange = MsgBoxResult.Yes Or vOldTextLast = Me.TxtLast.Text And vOldTextFirst = Me.TxtFirst.Text Then
                'Create a new record and
                'get the ID
                Me.PersonID = modStatSave.SavePerson(Me)
                Me.Saved = True
                'The person change message was cancelled so confirm cancellation
            ElseIf vConfirmChange = MsgBoxResult.Cancel Then
                vReturn = modMsgForm.FormCancel
            End If
        End If

        'Make sure the user wants to close
        vReturn = modMsgForm.FormClose

        If vReturn = MsgBoxResult.No Then
            Me.FormState = EXISTING_RECORD
            CmdNew.Enabled = True
            CmdProperties.Enabled = True

            If Me.Saved = True Then
                vOldTextLast = Me.TxtLast.Text
                vOldTextFirst = Me.TxtFirst.Text
                originalTxtNote = TxtNotes.Text
                originalTempNote = TxtTempNotes.Text
                Me.Saved = False
            End If
        Else
            Me.Close()
        End If


    End Sub


    Private Sub CmdOpen_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdOpen.Click

        Dim vPhoneID As Integer
        Dim vReturn As New Object

        On Error Resume Next
        frmPersonPhone = New FrmPersonPhone

        'Determine the state which to open the
        'form.
        frmPersonPhone.FormState = EXISTING_RECORD

        'Check that there is a good Person ID to get
        Call modControl.GetSelListViewID(LstViewPhone, vReturn)

        If IsNothing(vReturn) Then
            Exit Sub
        End If

        frmPersonPhone.PhoneID = modConv.TextToLng(vReturn(0, 0))
        frmPersonPhone.PersonID = Me.PersonID

        'Pass the data to the form and
        'get the updated data back
        LstViewPhone.Items.Clear()
        vPhoneID = frmPersonPhone.Display
        frmPersonPhone = Nothing
        If vPhoneID = 0 Then
            'The user cancelled updating the row,
            'so do nothing
        Else
            'Clear the list
            'LstViewPhone.Items.Clear
            LstViewPhone.View = View.Details

            'Update the row data
            If modStatQuery.QueryPersonPhone(Me) = NO_DATA Then
                CmdOpen.Enabled = False
            Else
                CmdOpen.Enabled = True
            End If

        End If

        Me.Activate()

    End Sub

    Private Sub CmdOrganizationDetail_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdOrganizationDetail.Click

        Dim vOrganizationId As Integer
        Dim vReturn As New Object

        On Error Resume Next

        frmOrganization = New FrmOrganization()
        'Determine the state which to open the
        'Organization form.
        If modControl.GetID(CboOrganization) = -1 Then
            frmOrganization.FormState = NEW_RECORD
            frmOrganization.OrganizationId = 0
        Else
            frmOrganization.FormState = EXISTING_RECORD
            frmOrganization.OrganizationId = modControl.GetID(CboOrganization)
        End If

        'Get the organization id from the organization form
        'after the user is done.
        vOrganizationId = frmOrganization.Display
        frmOrganization = Nothing
        If vOrganizationId = 0 Then
            'The user cancelled adding a new organization
            'so do nothing
        Else
            'Refill the location combo box with the new (or updated)
            'organization id and name
            Call modStatRefQuery.RefQueryOrganization(vReturn, vOrganizationId)
            Call modControl.SetTextID(CboOrganization, vReturn)
            Call modControl.SelectID(CboOrganization, vOrganizationId)
        End If

    End Sub


    Private Sub CmdProperties_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdProperties.Click
        frmPersonProperties = New FrmPersonProperties()

        frmPersonProperties.PersonFirst = TxtFirst.Text
        frmPersonProperties.PersonLast = TxtLast.Text
        frmPersonProperties.OrganizationId = modControl.GetID(CboOrganization)
        frmPersonProperties.PersonID = Me.PersonID
        frmPersonProperties.fvLeaseOrganization = Me.LeaseOrganization
        frmPersonProperties.Display()
        frmPersonProperties = Nothing

    End Sub

    Private Sub FrmPerson_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load
        '====================================================================================
        'Date Changed: 12/28/05                           Changed by: Char Chaput
        'Release #: 7.7.36
        'Description:  Added a message box display when the name changes so
        'Notification to the user shall appear when a persons name has changed
        '====================================================================================

        Call modUtility.CenterForm()
        Me.Saved = False

        'Initialize the phone grid
        LstViewPhone.Items.Clear()
        Call modControl.HighlightListViewRow(LstViewPhone)
        Call LstViewPhone.Columns.Insert(0, "", "Contact #", CInt(VB6.TwipsToPixelsX(2200)))
        Call LstViewPhone.Columns.Insert(1, "", "Type", CInt(VB6.TwipsToPixelsX(1550)))

        Call modStatRefQuery.ListRefQueryPersonType(CboPersonType)

        If Me.FormState = NEW_RECORD Then

            'Set the organization list to the default
            'CboOrganization.Items.Add(New ValueDescriptionPair(Me.DefaultOrganizationID, "Hello"))
            If (Me.DefaultOrganizationID > 0 And Len(Me.DefaultOrganizationName) > 0) Then

                CboOrganization.Items.Add(New ValueDescriptionPair(Me.DefaultOrganizationID, Me.DefaultOrganizationName))

            End If

            'Set the organization combo box to the current organization
            Call modControl.SelectID(CboOrganization, Me.DefaultOrganizationID)
            'Call modStatQuery.QueryPerson(Me)
            'Disable the Open & New buttons
            Me.CmdOpen.Enabled = False
            Me.CmdNew.Enabled = False
            Me.CmdProperties.Enabled = False

        ElseIf Me.FormState = EXISTING_RECORD Then

            'Get the Person record detail
            Call modStatQuery.QueryPerson(Me)

            vOldTextLast = Me.TxtLast.Text
            vOldTextFirst = Me.TxtFirst.Text

            'Get the Person Phone detail
            If modStatQuery.QueryPersonPhone(Me) = NO_DATA Then
                CmdOpen.Enabled = False
            End If

            'Set scurity options

            CmdNew.Enabled = True
            CmdOK.Enabled = True
            ChkBusy.Enabled = True
            If modStatSecurity.GetPermission(AppMain.ParentForm.StatEmployeeID, "AllowCallDelete") Then
                TxtBusyUntil.Enabled = True
                ChkInactive.Enabled = True
                CmdDelete.Enabled = True
                LstViewPhone.Enabled = True
                TxtFirst.Enabled = True
                TxtMI.Enabled = True
                TxtLast.Enabled = True
                CboPersonType.Enabled = True
                CboOrganization.Enabled = True
                CmdOrganizationDetail.Enabled = True
                ChkTempNote.Enabled = True
                TxtTempExpires.Enabled = True
            Else
                CmdNew.Enabled = False
                CmdOK.Enabled = False
                ChkBusy.Enabled = False
                TxtBusyUntil.Enabled = False
                ChkInactive.Enabled = False
                CmdDelete.Enabled = False
                LstViewPhone.Enabled = False
                TxtFirst.Enabled = False
                TxtMI.Enabled = False
                TxtLast.Enabled = False
                CboPersonType.Enabled = False
                CboOrganization.Enabled = False
                CmdOrganizationDetail.Enabled = False
                ChkTempNote.Enabled = False
                TxtTempExpires.Enabled = False
            End If
        End If

        If modStatSecurity.GetPermission(AppMain.ParentForm.StatEmployeeID, "AllowSecurityAccess") Then
            CmdProperties.Visible = True
        Else
            CmdProperties.Visible = False
        End If

        originalTxtNote = TxtNotes.Text
        originalTempNote = TxtTempNotes.Text

    End Sub

    Public Function Display() As Integer

        'Me.Show vbModal

        'C.Chaput only display contact frame when initialized from frmreferral for Release 8.0
        If Not IsNothing(modalParent) Then

            If modalParent.Name = "FrmReferral" Then
                If modalParent.MDPhone = True Then
                    Me.FraInformation.Visible = False
                    Me.FraContactInfo.Top = VB6.TwipsToPixelsY(60)
                    Me.FraContactInfo.Left = VB6.TwipsToPixelsX(60)
                    Me.ChkBusy.Visible = False
                    Me.TxtBusyUntil.Visible = False
                    Me.Width = VB6.TwipsToPixelsX(6650)
                    Me.CmdCancel.Left = VB6.TwipsToPixelsX(5275)
                    Me.CmdProperties.Visible = False
                    Me.ChkInactive.Visible = False
                    Me.CmdOK.Visible = True
                    Me.CmdOK.Left = VB6.TwipsToPixelsX(5275)
                    Me.CmdOK.Text = "Add Phone # to Referral"
                    CmdOK.Enabled = True

                    Me.CmdOK.Height = VB6.TwipsToPixelsY(500)


                End If
            End If
        End If
        'Call modUtility.CenterForm
        Dim dialogResult As DialogResult = Me.ShowDialog()


        Display = fvPersonID

    End Function


    Private Sub FrmPerson_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing
        '====================================================================================
        'Date Changed: 12/28/05                           Changed by: Char Chaput
        'Release #: 7.7.36
        'Description:  Added a message box display when the name changes so
        'Notification to the user shall appear when a persons name has changed
        '====================================================================================

        Dim vReturn As Short

        If Me.Saved = True Then
            'The message was saved so just unload
            eventArgs.Cancel = False

        Else
            'Char Chaput 12/15/2005 Release 7.7.36 change person message
            'The message was cancelled from the cmdOK button so get of form without asking for cancel again.
            If vConfirmChange = MsgBoxResult.Cancel Or vConfirmChange = MsgBoxResult.No Then
                eventArgs.Cancel = False

            Else
                vReturn = modMsgForm.FormCancel
                If vReturn = MsgBoxResult.Yes Then
                    eventArgs.Cancel = False

                Else
                    eventArgs.Cancel = True
                    Exit Sub
                End If
            End If

        End If
        frmOrganization = Nothing
        frmPersonPhone = Nothing
        frmPersonProperties = Nothing

    End Sub


    Private Sub LstViewPhone_ColumnClick(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.ColumnClickEventArgs) Handles LstViewPhone.ColumnClick
        Dim ColumnHeader As System.Windows.Forms.ColumnHeader = LstViewPhone.Columns(eventArgs.Column)

        ' When a ColumnHeader object is clicked, the ListView control is
        ' sorted by the subitems of that column.
        ' Set the SortKey to the Index of the ColumnHeader - 1
        LstViewPhone.Sorting = Me.SortOrder
        LstViewPhone.ListViewItemSorter = New ListViewItemComparer(eventArgs.Column, Me.SortOrder)

        If Me.SortOrder = System.Windows.Forms.SortOrder.Ascending Then
            Me.SortOrder = System.Windows.Forms.SortOrder.Descending
        Else
            Me.SortOrder = System.Windows.Forms.SortOrder.Ascending
        End If

    End Sub


    Private Sub LstViewPhone_DoubleClick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewPhone.DoubleClick

        CmdOpen_Click(CmdOpen, New System.EventArgs())

    End Sub

    Private Sub TxtBusyUntil_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtBusyUntil.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub

    Private Sub TxtBusyUntil_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtBusyUntil.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        KeyAscii = modMask.DateTimeMask(KeyAscii, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtBusyUntil_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtBusyUntil.Leave

        On Error Resume Next

        If Not IsDate(TxtBusyUntil.Text) Or Len(TxtBusyUntil.Text) < 15 Then
            Call MsgBox("Date is not valid.", MsgBoxStyle.Exclamation, "Validation Error")
            TxtBusyUntil.Focus()
        End If

    End Sub

    Private Sub TxtFirst_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtFirst.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtLast_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtLast.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtMI_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtMI.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub

    Private Sub TxtTempExpires_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtTempExpires.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtTempExpires_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtTempExpires.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        KeyAscii = modMask.DateTimeMask(KeyAscii, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
		If KeyAscii = 0 Then
			eventArgs.Handled = True
		End If
	End Sub

    Private Sub LstViewPhone_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles LstViewPhone.Click
        Call modControl.HighlightListViewRowNew(LstViewPhone)
    End Sub
End Class