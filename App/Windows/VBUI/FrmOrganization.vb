Option Strict Off
Option Explicit On
Friend Class FrmOrganization
	Inherits System.Windows.Forms.Form
	
	
	'Form Variables
	Public FormState As Short
	Public OrganizationId As Integer
	Public SortOrder As Short
	Public Verified As Boolean
	Public Saved As Short
	Public vOldTextOrganization As String
	Public vConfirmChange As Short
	Public PersonName As String
	Public PersonID As Integer
	Public originalNotesValue As String
	
    Public SourceCode As clsSourceCode
    '03/2010 bret add form references
    Private frmCounty As FrmCounty
    Private frmPerson As FrmPerson
    Private frmOrganizationType As FrmOrganizationType
    Private frmOrganizationProperties As FrmOrganizationProperties

	Private Sub CboCounty_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles CboCounty.KeyPress
		Dim KeyAscii As Short = Asc(eventArgs.KeyChar)
		
		'Allow the delete key to clear the combo box
        Call modControl.AllowDelete(CboCounty, KeyAscii)
		
		eventArgs.KeyChar = Chr(KeyAscii)
		If KeyAscii = 0 Then
			eventArgs.Handled = True
		End If
	End Sub
	
	
	
	
	Private Sub CboOrganizationType_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles CboOrganizationType.KeyPress
		Dim KeyAscii As Short = Asc(eventArgs.KeyChar)
		
		'Allow the delete key to clear the combo box
        Call modControl.AllowDelete(CboOrganizationType, KeyAscii)
		
		eventArgs.KeyChar = Chr(KeyAscii)
		If KeyAscii = 0 Then
			eventArgs.Handled = True
		End If
	End Sub

    Private Sub CboState_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboState.SelectedIndexChanged

        If Not CboState.SelectedIndex = -1 Then
            'Based on the selected state,
            'fill the county selection list
            Call modStatQuery.QueryStateCounty(modControl.GetID(CboState), CboCounty)
        End If

    End Sub


    Private Sub ChkVerified_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkVerified.CheckStateChanged

        If ChkVerified.CheckState = 1 Then
            Me.Verified = 1
        Else
            Me.Verified = 0
        End If

    End Sub

    Private Sub CmdCancel_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdCancel.Click

        Me.Close()

    End Sub

    Private Sub CmdCountyDetail_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdCountyDetail.Click

        Dim vCountyID As Integer

        On Error Resume Next
        frmCounty = New FrmCounty()

        'Determine the state which to open the
        'form.
        If modControl.GetID(CboCounty) = -1 Then
            frmCounty.FormState = NEW_RECORD
            frmCounty.CountyID = 0
        Else
            frmCounty.FormState = EXISTING_RECORD
            frmCounty.CountyID = modControl.GetID(CboCounty)
        End If

        'Set the default state of the county form
        frmCounty.DefaultState = modControl.GetID(CboState)

        'Get the County id from the County form
        'after the user is done.
        vCountyID = frmCounty.Display
        frmCounty = Nothing

        If vCountyID = 0 Then
            'The user cancelled adding a new County
            'so do nothing
        Else
            'Refill the county combo box with the new (or updated)
            'County id and name
            Call modStatQuery.QueryStateCounty(modControl.GetID(CboState), CboCounty)
            Call modControl.SelectID(CboCounty, vCountyID)
        End If

    End Sub

    Private Sub CmdDelete_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdDelete.Click

        Dim vPersonID As Integer
        Dim vReturn As Short
        Dim vResultArray As New Object
        Dim vPersonResults As New Object
        Dim vQuery As String = ""
        Dim vMsgText As String = ""
        Dim I As Short

        vReturn = MsgBox("You are about to delete an person. A person may only be deleted if they are not associated with a referral, message, schedule, or web login. This action cannot be undone!!! Are you sure you want to continue?", MsgBoxStyle.YesNo, "Delete Person")

        Select Case vReturn
            Case MsgBoxResult.Yes
                'Get the selected person's id

                'bret 07/23 set the LstViewPerson as an active control

                LstViewPerson.Select()
                vPersonID = LstViewPerson.FocusedItem.Tag
                Me.PersonID = vPersonID

                'Get the Person Name to display the name in the name change message box
                Call modStatRefQuery.RefQueryPerson(vPersonResults, vPersonID)
                Me.PersonName = vPersonResults(0, 1)


                'First check if there are any associations to callers on referrals
                vQuery = "SELECT CallNumber FROM Call " & "JOIN Referral ON Referral.CallID = Call.CallID " & "WHERE ReferralCallerPersonID = " & vPersonID
                vReturn = modODBC.Exec(vQuery, vResultArray)
                If vReturn <> NO_DATA Then
                    If IsNothing(vResultArray) Then
                        MsgBox("There was a problem deleting this person. The person was not deleted.")
                    Else
                        vMsgText = "This person is associated with a referral and cannot be deleted." & Chr(10) & Chr(13)
                        For I = 0 To UBound(vResultArray)
                            vMsgText = vMsgText & "Call #:  " & vResultArray(I, 0) & " " & Chr(10) & Chr(13)
                        Next I
                        MsgBox(vMsgText)
                    End If
                    Exit Sub
                End If

                'Check if there are any associations to approach by persons on referrals
                vQuery = "SELECT CallNumber FROM Call " & "JOIN Referral ON Referral.CallID = Call.CallID " & "WHERE ReferralApproachedByPersonID = " & vPersonID
                vReturn = modODBC.Exec(vQuery, vResultArray)
                If vReturn <> NO_DATA Then
                    If IsNothing(vResultArray) Then
                        MsgBox("There was a problem deleting this person. The person was not deleted.")
                    Else
                        vMsgText = "This person is associated with a referral and cannot be deleted." & Chr(10) & Chr(13)
                        For I = 0 To UBound(vResultArray)
                            vMsgText = vMsgText & "Call #:  " & vResultArray(I, 0) & " " & Chr(10) & Chr(13)
                        Next I
                        MsgBox(vMsgText)
                    End If
                    Exit Sub
                End If

                'Check if there are any associations to messages
                vQuery = "SELECT CallNumber FROM Call " & "JOIN Message ON Message.CallID = Call.CallID " & "WHERE Message.PersonID = " & vPersonID
                vReturn = modODBC.Exec(vQuery, vResultArray)
                If vReturn <> NO_DATA Then
                    If IsNothing(vResultArray) Then
                        MsgBox("There was a problem deleting this person. The person was not deleted.")
                    Else
                        vMsgText = "This person is associated with a message and cannot be deleted." & Chr(10) & Chr(13)
                        For I = 0 To UBound(vResultArray)
                            vMsgText = vMsgText & "Call #:  " & vResultArray(I, 0) & " " & Chr(10) & Chr(13)
                        Next I
                        MsgBox(vMsgText)
                    End If
                    Exit Sub
                End If

                'Check if there are any associations to schedules
                vQuery = "SELECT OrganizationName, ScheduleGroupName FROM Schedule " & "JOIN ScheduleGroup ON ScheduleGroup.ScheduleGroupID = Schedule.ScheduleGroupID " & "JOIN Organization ON Organization.OrganizationID = Schedule.OrganizationID " & "WHERE ScheduleCall1PersonID = " & vPersonID & " " & "OR ScheduleCall1PersonID = " & vPersonID & " " & "OR ScheduleCall2PersonID = " & vPersonID & " " & "OR ScheduleCall3PersonID = " & vPersonID & " " & "OR ScheduleCall4PersonID = " & vPersonID & " " & "OR ScheduleCall5PersonID = " & vPersonID & " " & "OR ScheduleCall6PersonID = " & vPersonID & " "
                vReturn = modODBC.Exec(vQuery, vResultArray)
                If vReturn <> NO_DATA Then
                    If IsNothing(vResultArray) Then
                        MsgBox("There was a problem deleting this person. The person was not deleted.")
                    Else
                        vMsgText = "This person is associated with a schedules and cannot be deleted." & Chr(10) & Chr(13)
                        For I = 0 To UBound(vResultArray)
                            vMsgText = vMsgText & "Organization:  " & vResultArray(I, 0) & " " & Chr(10) & Chr(13) & "Schedule Group:  " & vResultArray(I, 1) & " " & Chr(10) & Chr(13)
                        Next I
                        MsgBox(vMsgText)
                    End If
                    Exit Sub
                End If

                'Check if there are any associations to web persons
                vQuery = "SELECT PersonID FROM WebPerson " & "WHERE PersonID = " & vPersonID
                vReturn = modODBC.Exec(vQuery, vResultArray)
                If vReturn <> NO_DATA Then
                    If IsNothing(vResultArray) Then
                        MsgBox("There was a problem deleting this person. The person was not deleted.")
                    Else
                        MsgBox("This person is associated with web access and cannot be deleted.")
                    End If
                    Exit Sub
                End If

                'Char Chaput 12/21/05
                'Check if there are any associations to archive database
                vQuery = "SELECT ISNULL(PersonArchive,0) FROM Person " & "WHERE PersonID = " & vPersonID
                vReturn = modODBC.Exec(vQuery, vResultArray)

                If vReturn <> NO_DATA Then
                    If vResultArray(0, 0) = 1 Then
                        MsgBox("This person is associated with referrals in the Archive Database and cannot be deleted.")
                        Exit Sub
                    End If
                End If


                'If the function hasn't exited, delete the person.
                vReturn = MsgBox("You are *really* sure you want to delete this person. Once the person is gone, you must re-enter it. This is your last chance. With this in mind, are you *positive* you want to continue?", MsgBoxStyle.YesNo, "Delete Organization")

                If vReturn = MsgBoxResult.Yes Then
                    Call modStatSave.DeletePerson(Me)
                    LstViewPerson_Load()
                Else
                    Exit Sub
                End If

            Case MsgBoxResult.No
                Exit Sub
        End Select

    End Sub

    Private Sub cmdLeaseOrg_Click()

    End Sub

    Private Sub CmdNew_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdNew.Click

        Dim vPersonID As Integer

        On Error Resume Next
        frmPerson = New FrmPerson()

        'Get the call ID and set the values to be passed
        frmPerson.FormState = NEW_RECORD

        'Set the id number of the organization form to
        '0 to indicate a new record
        frmPerson.PersonID = 0

        'Set the default organization
        frmPerson.DefaultOrganizationID = Me.OrganizationId
        frmPerson.DefaultOrganizationName = TxtName.Text

        'Get the Person id from the Person form
        'after the user is done.
        vPersonID = frmPerson.Display
        frmPerson = Nothing

        If vPersonID = 0 Then
            'The user cancelled adding a new Person
            'so do nothing
        Else
            'Clear the list
            LstViewPerson.Items.Clear()
            LstViewPerson.View = View.Details

            'Update the row data
            If modStatQuery.QueryOrganizationPerson(Me) = NO_DATA Then
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
        'Notification to the user shall appear when an organizations name has changed
        '====================================================================================
        'Date Changed: 09/25/07                      Changed by: Bret Knoll
        'Release #: 8.4                              Task: AuditTrail
        'Description:   Check the Special Notes. If the notese are blank add a space
        '====================================================================================

        On Error Resume Next

        Dim vReturn As Short
        Dim vMsg As String = ""
        Dim vText As New Object
        Dim vParams(0, 1) As Object

        'Check the Special Notes section and add a blank
        If Len(TxtNotes.Text) = 0 And originalNotesValue <> TxtNotes.Text Then
            TxtNotes.Text = " "
        End If
        'Make sure the user wants to save
        vReturn = modMsgForm.FormSave

        If vReturn = MsgBoxResult.Cancel Then
            Exit Sub
        End If

        'Validate the data
        If Not modStatValidate.Organization(Me) Then
            Exit Sub
        End If

        If Me.Verified = False Then

            'Alert user to unverified status
            vReturn = MsgBox("You are about to save an unverified organization." & Chr(13) & "" & Chr(10) & "" & Chr(13) & "" & Chr(10) & "Contact a maintenance manager to ensure the automatic group assignments are correct.", MsgBoxStyle.Exclamation + MsgBoxStyle.OKCancel + MsgBoxStyle.DefaultButton2, "Unverified Organization")

            Select Case vReturn

                Case MsgBoxResult.OK

                    'First create a new record and get the ID
                    Me.OrganizationId = modStatSave.SaveOrganization(Me)
                    Me.Saved = True

                    If Me.FormState = NEW_RECORD Then

                        'Save the unverified organization as a system alert
                        vMsg = "Unverified organization created:  " & TxtName.Text & " - " & CboState.Text
                        Call modStatSave.SaveSystemAlert(vMsg, 1)

                        If Me.ChkVerified.Visible = False Then
                            'Next, assign the unverified organization to criteria groups, on call groups, and report groups
                            If modStatSave.SaveOrganizationAssociations(Me) <> SUCCESS Then
                                'Display an error
                                MsgBox("There were no similar organizations matching either the city, county, area code, or state. " & Chr(13) & "" & Chr(10) & "" & Chr(13) & "" & Chr(10) & "The organization cannot be saved until there are similar organizations assigned to criteria, on call, and report groups." & Chr(13) & "" & Chr(10) & "" & Chr(13) & "" & Chr(10) & "Check you information and try again.", MsgBoxStyle.DefaultButton1 + MsgBoxStyle.ApplicationModal + MsgBoxStyle.Critical + MsgBoxStyle.OKOnly, "Invalid Organization")
                                'Delete the saved organization
                                Call modStatSave.DeleteOrganization(Me.OrganizationId)
                                Me.Saved = False
                                Exit Sub
                            Else
                                Me.Close()
                            End If
                        End If

                    Else
                        If vOldTextOrganization <> TxtName.Text Then

                            vText = "You have changed the Ogranization name from " & Chr(13) & Chr(13) & vOldTextOrganization & Chr(13) & "to" & Chr(13) & TxtName.Text & Chr(13) & Chr(13) & "Do you wish to change this name? Selecting Yes will save the name change."

                            vConfirmChange = MsgBox(vText, MsgBoxStyle.Information + MsgBoxStyle.YesNoCancel, "Confirmation of Organization Name Change")

                        End If
                        Me.Close()
                    End If

                Case MsgBoxResult.Cancel

                    Exit Sub

            End Select

        Else

            'Char Chaput 12/14/2005 Display a person change message requesting the change confirmation
            'to the user Release 7.7.36
            If vOldTextOrganization > "" Then
                If vOldTextOrganization <> TxtName.Text Then

                    vText = "You have changed the Ogranization name from " & Chr(13) & Chr(13) & vOldTextOrganization & Chr(13) & "to" & Chr(13) & TxtName.Text & Chr(13) & Chr(13) & "Do you wish to change this name? Selecting Yes will save the name change."

                    vConfirmChange = MsgBox(vText, MsgBoxStyle.Information + MsgBoxStyle.YesNoCancel, "Confirmation of Organization Name Change")

                End If
            End If
            'Char Chaput 12/14/2005 User clicked yes to confirm the change or there was no change
            If vConfirmChange = MsgBoxResult.Yes Or vOldTextOrganization = TxtName.Text Or vOldTextOrganization = "" Then
                'Save the record and get the ID
                Me.OrganizationId = modStatSave.SaveOrganization(Me)

                Me.Saved = True
                'The person change message was cancelled so confirm cancellation
            ElseIf vConfirmChange = MsgBoxResult.Cancel Then
                vReturn = modMsgForm.FormCancel
            End If


            'Make sure the user wants to close
            vReturn = modMsgForm.FormClose

            If vReturn = MsgBoxResult.No Then
                Me.FormState = EXISTING_RECORD
                CmdOpen.Enabled = True
                CmdNew.Enabled = True
                CmdProperties.Enabled = True
                If Me.Saved = True Then
                    vOldTextOrganization = Me.TxtName.Text
                    originalNotesValue = TxtNotes.Text
                    Me.Saved = False
                End If
            Else
                Me.Close()
            End If

        End If

    End Sub


    Private Sub CmdOpen_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdOpen.Click

        Dim vResult() As String
        Dim vPersonID As Integer
        Dim vReturn As New Object

        On Error Resume Next
        frmPerson = New FrmPerson()
        'Get the call ID and set the values to be passed
        frmPerson.FormState = EXISTING_RECORD

        'Get the ID of the Person to open
        Call modControl.GetSelListViewID(LstViewPerson, vReturn)

        If IsNothing(vReturn) Then
            Exit Sub
        End If

        frmPerson.PersonID = vReturn(0, 0)

        'Get the Person id from the Person form
        'after the user is done.
        vPersonID = frmPerson.Display

        If vPersonID = 0 Then
            'The user cancelled adding a new Person
            'so do nothing
        Else
            'Clear the list
            LstViewPerson.Items.Clear()
            LstViewPerson.View = View.Details

            'Update the row data
            If modStatQuery.QueryOrganizationPerson(Me) = NO_DATA Then
                CmdOpen.Enabled = False
            Else
                CmdOpen.Enabled = True
            End If

        End If

        frmPerson = Nothing
        Me.Activate()

    End Sub


    Private Sub CmdOrganizationTypeDetail_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdOrganizationTypeDetail.Click

        Dim vOrganizationTypeID As Integer

        On Error Resume Next
        frmOrganizationType = New FrmOrganizationType()

        'Determine the state which to open the
        'form.
        If modControl.GetID(CboOrganizationType) = -1 Then
            frmOrganizationType.FormState = NEW_RECORD
            frmOrganizationType.OrganizationTypeID = 0
        Else
            frmOrganizationType.FormState = EXISTING_RECORD
            frmOrganizationType.OrganizationTypeID = modControl.GetID(CboOrganizationType)
        End If

        'Get the organization id from the organization form
        'after the user is done.
        vOrganizationTypeID = frmOrganizationType.Display
        frmOrganizationType = Nothing

        If vOrganizationTypeID = 0 Then
            'The user cancelled adding a new organization
            'so do nothing
        Else
            'Refill the location combo box with the new (or updated)
            'organization id and name
            Call modStatRefQuery.RefQueryOrganizationType(CboOrganizationType)
            Call modControl.SelectID(CboOrganizationType, vOrganizationTypeID)
        End If

    End Sub

    Private Sub CmdPrintList_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdPrintList.Click



    End Sub

    Private Sub CmdProperties_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdProperties.Click

        frmOrganizationProperties = New FrmOrganizationProperties()

        frmOrganizationProperties.OrganizationId = Me.OrganizationId
        frmOrganizationProperties.OrganizationName = Me.TxtName.Text 'T.T 4/17/2004 added for organization name
        frmOrganizationProperties.Display()
        frmOrganizationProperties = Nothing

    End Sub

    Private Sub FrmOrganization_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load
        '====================================================================================
        'Date Changed: 12/28/05                           Changed by: Char Chaput
        'Release #: 7.7.36
        'Description:  Added a message box display when the name changes so
        'Notification to the user shall appear when an organizations name has changed
        '====================================================================================

        'Call modUtility.CenterForm()
        Me.Saved = False

        'Initialize the organization grid
        Call modControl.HighlightListViewRow(LstViewPerson)
        'Call modControl.HighlightListViewRowNew(LstViewPerson)
        Call LstViewPerson.Columns.Insert(0, "", "Name", CInt(VB6.TwipsToPixelsX(1700)))
        Call LstViewPerson.Columns.Insert(1, "", "Type", CInt(VB6.TwipsToPixelsX(2050)))

        'initialize OptActive
        OptActive.Container.Add(_OptActive_0)
        OptActive.Container.Add(_OptActive_1)

        'Get the reference data
        Call modStatRefQuery.RefQueryState(CboState)
        Call modStatRefQuery.RefQueryOrganizationType(CboOrganizationType)

        If Me.FormState = NEW_RECORD Then

            'Set verified to false
            Me.ChkVerified.CheckState = System.Windows.Forms.CheckState.Unchecked

            'Disable the Open & New buttons
            CmdOpen.Enabled = False
            CmdNew.Enabled = False
            CmdProperties.Enabled = False

        ElseIf Me.FormState = EXISTING_RECORD Then

            'Get the organization record detail
            Call modStatQuery.QueryOrganization(Me)

            'Get the Organization Person
            Call modStatQuery.QueryOrganizationPerson(Me)

            'Char Chaput 12/2805 check for name change
            vOldTextOrganization = Me.TxtName.Text
            LstViewPerson_Load()


        End If

        'Set scurity options
        If modStatSecurity.GetPermission(AppMain.ParentForm.StatEmployeeID, "AllowCallDelete") Then
            FraOrgInfo.Enabled = True
            CmdNew.Enabled = True
            OptActive(0).Enabled = True
            OptActive(1).Enabled = True
            CmdDelete.Enabled = True
            CmdOK.Enabled = True
            ChkVerified.Enabled = True
        Else
            FraOrgInfo.Enabled = False
            CmdNew.Enabled = False
            OptActive(0).Enabled = False
            OptActive(1).Enabled = False
            CmdDelete.Enabled = False
            CmdOK.Enabled = False
            ChkVerified.Enabled = False
        End If

        'set the text on open
        originalNotesValue = TxtNotes.Text
    End Sub

    Private Sub LstViewPerson_Load()

        'bret 9/2010 moved LstViewPersonLoad here
        'Clear the grid
        LstViewPerson.Items.Clear()
        LstViewPerson.View = View.Details

        'Fill Grid
        Call modStatQuery.QueryOrganizationPerson(Me)
    End Sub


    Private Sub FrmOrganization_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing
        '====================================================================================
        'Date Changed: 12/28/05                           Changed by: Char Chaput
        'Release #: 7.7.36
        'Description:  Added a message box display when the name changes so
        'Notification to the user shall appear when an organizations name has changed
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
                frmPerson = Nothing
            Else
                'The message was cancelled or closed so confirm cancellation
                vReturn = MsgBox("Are you sure you want to Cancel?", MsgBoxStyle.YesNo + MsgBoxStyle.Question, "Cancel")

                If vReturn = MsgBoxResult.Yes Then
                    eventArgs.Cancel = False

                Else
                    eventArgs.Cancel = True
                    Exit Sub
                End If
            End If
        End If

        'set original value
        originalNotesValue = TxtNotes.Text
        frmOrganizationProperties = Nothing
        frmOrganizationType = Nothing
        frmPerson = Nothing
        frmCounty = Nothing

        'Me.Dispose()
    End Sub


    Private Sub LstViewPerson_ColumnClick(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.ColumnClickEventArgs) Handles LstViewPerson.ColumnClick
        Dim ColumnHeader As System.Windows.Forms.ColumnHeader = LstViewPerson.Columns(eventArgs.Column)

        ' When a ColumnHeader object is clicked, the ListView control is
        ' sorted by the subitems of that column.
        ' Set the SortKey to the Index of the ColumnHeader - 1
        LstViewPerson.Sorting = Me.SortOrder
        LstViewPerson.ListViewItemSorter = New ListViewItemComparer(eventArgs.Column, Me.SortOrder)

        If Me.SortOrder = System.Windows.Forms.SortOrder.Ascending Then
            Me.SortOrder = System.Windows.Forms.SortOrder.Descending
        Else
            Me.SortOrder = System.Windows.Forms.SortOrder.Ascending
        End If

    End Sub


    Private Sub LstViewPerson_DoubleClick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewPerson.DoubleClick

        Call CmdOpen_Click(CmdOpen, New System.EventArgs())

    End Sub


    Private Sub OptActive_CheckedChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles OptActive.CheckedChanged
        If (OptActive.Count = 1) Then
            Exit Sub
        End If
        If eventSender.Checked Then
            Dim Index As Short = OptActive.GetIndex(eventSender)

            LstViewPerson_Load()
        End If
    End Sub

    Private Sub TxtAddress1_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtAddress1.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub

    Private Sub TxtAddress2_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtAddress2.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub

    Private Sub TxtCentralPhone_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtCentralPhone.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub

    Private Sub TxtCentralPhone_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtCentralPhone.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        KeyAscii = modMask.PhoneMask(KeyAscii, TxtCentralPhone)

        eventArgs.KeyChar = Chr(KeyAscii)
		If KeyAscii = 0 Then
			eventArgs.Handled = True
		End If
	End Sub
	
	
	Private Sub TxtCity_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtCity.Enter
		
		Call modControl.HighlightText(ActiveControl)
		
	End Sub
	
	Private Sub TxtName_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtName.Enter
		
		Call modControl.HighlightText(ActiveControl)
		
	End Sub
	
	
	
	Private Sub TxtZipCode_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtZipCode.Enter
		
		Call modControl.HighlightText(ActiveControl)
		
	End Sub
	
	Public Function Display() As Integer
		
		On Error Resume Next
		
        Dim dialogResult As DialogResult = Me.ShowDialog()
		
		Display = OrganizationId
		
	End Function

    Private Sub LstViewPerson_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles LstViewPerson.Click
        Call modControl.HighlightListViewRowNew(LstViewPerson)
    End Sub
End Class