Option Strict Off
Option Explicit On
Imports Statline.Stattrac.Windows.CSharpUIMap
Imports Statline.Stattrac.Common
Imports Statline.Stattrac.Constant

Public Class FrmOnCall
    Inherits System.Windows.Forms.Form


    Public OrganizationId As Integer
    Public OrganizationName As String
    Public ScheduleGroupID As Integer
    Public PersonID As Integer
    Public ReferralOrganizationID As Integer
    Public ContactLogEventTypeID As Integer
    Public CallbackPending As Short
    Public LogEventTypeList As Object

    Public DefaultContactName As String
    Public DefaultContactPhone As String
    Public DefaultOrganization As String
    Public DefaultContactType As Short
    Public DefaultContactDesc As String
    Public DefaultContactPhoneType As String

    Public CurrentDate As Date
    Public ScheduleShiftID As Integer

    Public UseOldSchedule As Boolean
    Public parentForm As Object
    Private frmAlphaMsg As FrmAlphaMsg
    'bret 02/01/11 
    Private uIMap As UIMap


    Private Sub CboOrganization_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboOrganization.Leave


    End Sub


    Private Sub CboScheduleGroup_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboScheduleGroup.SelectedIndexChanged

        On Error Resume Next

        'Clear the lists
        ChkShowAll.CheckState = System.Windows.Forms.CheckState.Unchecked
        LstViewPerson.Items.Clear()
        LstViewPerson.View = View.Details
        LstViewContact.Items.Clear()
        LstViewContact.View = View.Details
        TxtPersonNotes.Text = ""
        TxtScheduleReferralNotes.Text = ""
        TxtScheduleMessageNotes.Text = ""
        Me.lblBusy.Visible = False
        Me.lblBusy.Text = ""

        'TabNotes.SelectedIndex = 2
        UseOldSchedule = False

        'Get the ID of the selected location
        Me.ScheduleGroupID = modControl.GetID(CboScheduleGroup)

        'Get the shift cutover time
        Call modStatQuery.QueryScheduleShift(Me, UseOldSchedule)

        If UseOldSchedule Then
            Call modStatQuery.QueryScheduleShift3(Me)
        End If

        'Get the schedule notes
        Call modStatQuery.QueryScheduleGroupNotes(Me)

        'Fill the person grid
        If UseOldSchedule Then
            Call modStatQuery.QueryOrganizationSchedulePerson(Me)
        Else
            Call modStatQuery.QueryOrganizationNewSchedulePerson(Me)
        End If
        Call modControl.HighlightListViewRowNew(LstViewPerson)
        Call modControl.HighlightListViewRowNew(LstViewContact)

    End Sub



















    Private Sub ChkShowAll_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkShowAll.CheckStateChanged

        If ChkShowAll.CheckState = 1 Then
            'Find all people belonging to the organization
            'Clear the lists
            LstViewPerson.Items.Clear()
            LstViewPerson.View = View.Details
            TxtPersonNotes.Text = ""
            Call modStatQuery.QueryOrganizationPerson(Me)
        Else
            'Refill with on call people
            Call CboScheduleGroup_SelectedIndexChanged(CboScheduleGroup, New System.EventArgs())
        End If

    End Sub

    Private Sub CmdAlpha_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdAlpha.Click

        On Error Resume Next

        Const ERR1 As String = "There is no pager email address associated with this pager. No page was sent." 'mjd 05/28/02

        Dim vQuery As String
        Dim vResultArray As New Object
        Dim vReturn As Short

        'Get the alpha email address and Pager Type
        'mjd 05/28/2002 Page-AutoResponse
        vQuery = "SELECT p.PhoneTypeID, pp.PhoneAlphaPagerEmail " & "FROM PersonPhone pp, Phone p " & "WHERE pp.PhoneID = p.PhoneID " & "AND   pp.PhoneID  = " & modConv.TextToLng(LstViewContact.FocusedItem.Tag) & " " & "AND   pp.PersonID = " & Me.PersonID

        vReturn = modODBC.Exec(vQuery, vResultArray)
        If vReturn = SUCCESS Then
            If vResultArray(0, 1) <> "" Then
                Select Case vResultArray(0, 0)
                    Case 7
                        frmAlphaMsg = New FrmAlphaMsg()
                        frmAlphaMsg.Recipient = vResultArray(0, 1)
                        frmAlphaMsg.ShowDialog()
                        frmAlphaMsg.Recipient = ""
                    Case 8 'mjd 05/28/2002 Page-AutoResponse
                        frmAlphaMsg = New FrmAlphaMsg()
                        frmAlphaMsg.Recipient = vResultArray(0, 1) 'mjd 05/28/2002 Page-AutoResponse
                        frmAlphaMsg.ShowDialog() 'mjd 05/28/2002 Page-AutoResponse
                        frmAlphaMsg.Recipient = "" 'mjd 05/28/2002 Page-AutoResponse
                    Case Else
                        MsgBox(ERR1)
                End Select
            Else
                MsgBox(ERR1)
            End If

        Else
            MsgBox(ERR1)
        End If

    End Sub

    Private Sub CmdCancel_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdCancel.Click

        Me.Close()

    End Sub

    Private Sub CmdSchedule_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdSchedule.Click

        AppMain.frmSchedule = New FrmSchedule()
        AppMain.frmSchedule.OrganizationId = Me.OrganizationId
        AppMain.frmSchedule.OrganizationName = Me.OrganizationName
        AppMain.frmSchedule.ScheduleGroupID = Me.ScheduleGroupID
        AppMain.frmSchedule.CurrentDate = Me.CurrentDate
        AppMain.frmSchedule.GetScheduleFlag = True
        AppMain.frmSchedule.OptDates(1).Checked = True
        AppMain.frmSchedule.Display()

        'Select grid item
        Call CboScheduleGroup_SelectedIndexChanged(CboScheduleGroup, New System.EventArgs())

    End Sub

    Private Sub FrmOnCall_Activated(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Activated

        If CboOrganization.Items.Count = 1 Then
            LstViewPerson.Focus()
        End If

    End Sub

    Private Sub FrmOnCall_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load

        '04/16/02 bjk do not need to change time
        'Dim vTimeZoneDif%
        'vTimeZoneDif = modStatQuery.QueryTimeZoneDif(AppMain.ParentForm.TimeZone)

        '********************************************
        'Initialize On Call Section
        '********************************************

        'Initialize the organization grid
        Call modControl.HighlightListViewRow(LstViewPerson)
        Call LstViewPerson.Columns.Insert(0, "", "#", CInt(VB6.TwipsToPixelsX(400)))
        Call LstViewPerson.Columns.Insert(1, "", "Name", CInt(VB6.TwipsToPixelsX(1850)))
        Call LstViewPerson.Columns.Insert(2, "", "Type", CInt(VB6.TwipsToPixelsX(2050)))

        'Initialize the phone grid
        Call modControl.HighlightListViewRow(LstViewContact)
        Call LstViewContact.Columns.Insert(0, "", "#", CInt(VB6.TwipsToPixelsX(400)))
        Call LstViewContact.Columns.Insert(1, "", "Contact #", CInt(VB6.TwipsToPixelsX(1900)))
        Call LstViewContact.Columns.Insert(2, "", "Type", CInt(VB6.TwipsToPixelsX(2050)))

        'If LO  and ReferralOrganizationID = 0 set ReferralOrganizationID& = LO
        'If AppMain.ParentForm.LeaseOrganization <> 0 And ReferralOrganizationID = 0 Then
        '    ReferralOrganizationID = AppMain.ParentForm.LeaseOrganization
        'End If

        'If the organization ID has not been set and the referral
        'organization ID has not been set, then fill the organization
        'list box with all the organizations that have a schedule.
        If Me.OrganizationId = 0 And Me.ReferralOrganizationID = 0 Then
            Call modStatQuery.QueryScheduleOrganizations(Me)

            'Else if the organization ID has been set, but the
            'referral organization ID has not been set, then
            'fill the organization list with only the selected organization.
        ElseIf Me.OrganizationId <> 0 And Me.ReferralOrganizationID = 0 Then
            CboOrganization.Items.Add(New ValueDescriptionPair(Me.OrganizationId, Me.OrganizationName))
            'Set the organization combo box to the current organization
            Call modControl.SelectID(CboOrganization, Me.OrganizationId)

            'Else if the referral organization ID has been set, then
            'find all the organizations that are on call for the
            'referral organization
        ElseIf Me.ReferralOrganizationID <> 0 Then
            Call modStatQuery.QueryScheduleOrganizationsOnCall(Me)
        End If

        'Default the date
        '04/16/02 bjk do not need to change time
        'Me.CurrentDate = Format(DateAdd("h", vTimeZoneDif, Now), "mm/dd/yy")
        Me.CurrentDate = CDate(VB6.Format(Now, "mm/dd/yy"))
        Me.Text = Me.Text & " Schedule For: " & Me.CurrentDate

        Call modUtility.CenterForm()

    End Sub













    Public Function Display() As Object

        Show()
        Return True
    End Function


    Private Sub FrmOnCall_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing

        AppMain.frmOnCall.Dispose()
        AppMain.frmOnCall = Nothing


    End Sub


    Private Sub LstViewContact_DoubleClick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewContact.DoubleClick

        On Error Resume Next

        Dim vPhoneID As Integer
        Dim vReturn As Object

        On Error Resume Next

        'Determine the state which to open the
        'form.
        If uIMap Is Nothing Then
            uIMap = OpenStatTracCSharpForms.CreateInstance()
        End If

        'Check that there is a good Person ID to get
        '//frmPersonPhone.PhoneID = modConv.TextToLng(LstViewContact.FocusedItem.Tag)

        'Pass the data to the form and
        'get the updated data back
        vPhoneID = uIMap.Open(AppScreenType.OrganizationsOrganizationContactsPhoneEditPopup, Me.PersonID)

        If vPhoneID = 0 Then
            'The user cancelled updating the row,
            'so do nothing
        Else
            'Clear the list
            LstViewContact.Items.Clear()
            LstViewContact.View = View.Details

            'Update the row data
            Call modStatQuery.QueryPersonPhone(Me)

        End If

        Me.Activate()

    End Sub

    Private Sub LstViewContact_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles LstViewContact.Click
        On Error Resume Next

        Dim vReturn As New Object

        'Transfer the person name to the contact fields
        Call modControl.GetSelListViewSubItems(LstViewContact, vReturn)
        Me.DefaultContactPhone = vReturn(0, 1)
        Me.DefaultContactPhoneType = vReturn(0, 2)

        If InStr(1, Me.DefaultContactPhoneType, "Alpha") Then
            CmdAlpha.Enabled = True
        Else
            CmdAlpha.Enabled = False
        End If
        Call modControl.HighlightListViewRowNew(LstViewContact)
    End Sub


    Private Sub LstViewPerson_DoubleClick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewPerson.DoubleClick

        On Error Resume Next

        Dim vReturn As Object

        'Check that there is a good Person ID to get
        Me.PersonID = modConv.TextToLng(LstViewPerson.FocusedItem.Tag)

        If Me.PersonID = 0 Or Me.PersonID = -1 Then
            'Do nothing
        Else

            'Set the person ID
            If uIMap Is Nothing Then
                uIMap = OpenStatTracCSharpForms.CreateInstance()
            End If
            uIMap.Open(AppScreenType.OrganizationsOrganizationContactsContactPropertiesEditPopup, Me.PersonID)

            'Clear the grid
            LstViewPerson.Items.Clear()
            LstViewPerson.View = View.Details

            'Select grid item
            Call CboScheduleGroup_SelectedIndexChanged(CboScheduleGroup, New System.EventArgs())

        End If

        Me.Activate()

    End Sub


    Private Sub LstViewPerson_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles LstViewPerson.Click

        On Error Resume Next

        Dim vReturn As New Object
        Dim I As Short

        'Check that there is a good Person ID to get
        Call modControl.GetSelListViewID(LstViewPerson, vReturn)

        If IsNothing(vReturn) Then
            Exit Sub
        End If

        Me.PersonID = vReturn(0, 0)

        If Me.PersonID = 0 Or Me.PersonID = -1 Then
            'Clear the contact grid
            LstViewContact.Items.Clear()

            LstViewContact.View = View.Details
        Else
            'Clear the contact grid
            LstViewContact.Items.Clear()

            LstViewContact.View = View.Details

            'Get the Person Phone detail
            Call modStatQuery.QueryPersonPhone(Me)

            'Get the Person notes
            Call modStatQuery.QueryPersonNotes(Me)

        End If


        'Transfer the person name to the contact fields
        Call modControl.GetSelListViewSubItems(LstViewPerson, vReturn)

        Me.DefaultContactName = vReturn(0, 0)

        'Clear the contact phone field
        Me.DefaultContactPhone = ""

        'Set the person Id of the message form
        For I = 0 To Application.OpenForms.Count - 1
            If parentForm.Name = "FrmMessage" Then
                parentForm.PersonID = Me.PersonID
            End If
        Next I
        Call modControl.HighlightListViewRowNew(LstViewPerson)
        Call modControl.HighlightListViewRowNew(LstViewContact)
    End Sub


    'Private Sub LstViewPerson_KeyDown(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles LstViewPerson.KeyDown
    '    On Error Resume Next
    '    Dim vReturn As New Object
    '    Dim I As Short
    '    Me.PersonID = vReturn(0, 0)
    '    'If e.KeyCode = Keys.Space Then
    '    LstViewPerson_Click(sender, e)
    '    'End If
    'End Sub

    Private Sub CboOrganization_SelectedIndexChanged(ByVal sender As Object, ByVal eventArgs As System.EventArgs) Handles CboOrganization.SelectedIndexChanged
        Dim vReturn As New Object

        'ccarroll  04/20/2010 moved code from CboOrganization.Leave event
        'Get the ID of the selected location
        Me.OrganizationId = modControl.GetID(CboOrganization)
        Me.OrganizationName = modControl.GetText(CboOrganization)
        Me.lblBusy.Visible = False
        Me.lblBusy.Text = ""
        'Fill the schedule group list
        CboScheduleGroup.Items.Clear()

        'If there no referral organization, then get all the schedule groups
        'that belong to the selected organization
        If Me.ReferralOrganizationID = 0 Then
            If modStatRefQuery.RefQueryScheduleGroup(vReturn, , , Me.OrganizationId) = SUCCESS Then
                Call modControl.SetTextID(CboScheduleGroup, vReturn)

                'If there is only one item, select and display it.
                If UBound(vReturn, 1) = 0 Then
                    Call modControl.SelectFirst(CboScheduleGroup)
                End If
            End If

            'Else, get only the schedule groups that are on call for the
            'referral organization
        Else
            Call modStatQuery.QueryScheduleGroupsOnCall(Me)

        End If

        'Get the organization notes
        Call modStatQuery.QueryOrganizationNotes(Me)

        'Set the Organization field
        Me.DefaultOrganization = modControl.GetText(CboOrganization)

        Call CboScheduleGroup_SelectedIndexChanged(CboScheduleGroup, New System.EventArgs())

        'TabNotes.SelectedIndex = 0
    End Sub


    Private Sub LstViewPerson_ItemSelectionChanged(ByVal sender As System.Object, ByVal e As System.Windows.Forms.ListViewItemSelectionChangedEventArgs) Handles LstViewPerson.ItemSelectionChanged
        On Error Resume Next
        Dim vReturn As New Object
        'Dim I As Short
        'Me.PersonID = vReturn(0, 0)
        'If e.KeyCode = Keys.Space Then
        Me.lblBusy.Visible = False
        Me.lblBusy.Text = ""
        LstViewPerson_Click(sender, e)
        'End If
    End Sub

  
End Class