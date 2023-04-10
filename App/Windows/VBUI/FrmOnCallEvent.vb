Option Strict Off
Option Explicit On
Imports Statline.Stattrac.Windows.CSharpUIMap
Imports Statline.Stattrac.Common
Imports Statline.Stattrac.Constant
Imports Statline.Stattrac.Framework.Validater
Imports System.Collections.Generic
Imports Statline.Stattrac.Framework

Friend Class FrmOnCallEvent
    Inherits Form

    Public FormState As Short
    Public CallId As Integer
    Public CallNumber As String
    Public OrganizationId As Integer
    Public OrganizationName As String
    Public ScheduleGroupID As Integer
    Public PersonID As Integer
    Public ReferralOrganizationID As Integer
    Public ContactLogEventTypeID As Integer
    Public CallbackPending As Short
    Public LogEventTypeList As Object
    Public PhoneID As Integer
    Public DefaultContactName As String
    Public DefaultContactPhone As String
    Public DefaultOrganization As String
    Public DefaultContactType As Short
    Public DefaultContactDesc As String
    Public DefaultContactPhoneType As String
    Public ContactEmployeeID As Integer
    Public CurrentDate As Date
    Public ScheduleShiftID As Integer
    Public NoDateClick As Object
    Public Loaded As Short
    Public Saved As Short
    Public OnCallType As Short
    Public SourceCode As clsSourceCode
    Public AlphaMsg As String
    Public AutoResponseMsg As String
    Public AutoResponseSbj As String
    Public EmailMsg As String
    Public EmailSbj As String
    Public LogEventNumber As Integer
    Public AlertType As Short
    Public OldCalloutDate As String
    Public OldCalloutMins As String
    Public UseOldSchedule As Boolean
    Public vParentForm As Object
    Public AutoResponseCode As Integer
    Public AutoResonseCodeCount As Integer
    Dim vLogEventDate As String = ""
    Private uIMap As UIMap
    Public LogEventDescription As String

    Private Enum EventTypeFilter As Integer
        All = 0
        Safe = 1
        Email = 2
        Page = 3
    End Enum

    Private Sub CboContactEventType_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles CboContactEventType.TextChanged
        '************************************************************************************
        'Name: CboContactEventType_Change
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Updates controls depending on content of CboContactEventType
        'Returns: Nothing
        'Params: Item As ListItem
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 12/13/04                         Changed by: Scott Plummer
        'Release #: 7.7.2                               Task: 312
        'Description:  Added Case EMAIL_PENDING and changes to email controls
        '====================================================================================
        '************************************************************************************

        CmdOK.Enabled = True

        'Set event type
        ContactLogEventTypeID = GetID(CboContactEventType)

        Select Case ContactLogEventTypeID
            Case GENERAL, CASE_HAND_OFF
                LblContactName.Visible = False
                TxtContactName.Visible = False
                TxtContactName.Text = ""
                TxtContactPhone.Visible = False
                LblContactPhone.Visible = False
                TxtContactPhone.Text = ""
                TxtContactOrg.Visible = False
                LblContactOrg.Visible = False
                TxtContactOrg.Text = ""
                CallbackPending = 0
                ChkConfirmed.Visible = False
                ChkConfirmed.CheckState = CheckState.Unchecked
                FraCallout.Visible = False
                lblEmail.Visible = False
                txtEmail.Visible = False
            Case INCOMING
                LblContactName.Visible = True
                TxtContactName.Visible = True
                TxtContactName.Text = DefaultContactName
                TxtContactPhone.Visible = False
                LblContactPhone.Visible = False
                TxtContactPhone.Text = ""
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                TxtContactOrg.Text = DefaultOrganization
                CallbackPending = 0
                ChkConfirmed.Visible = True
                FraCallout.Visible = False
                lblEmail.Visible = False
                txtEmail.Visible = False
            Case CORONER_CASE
                LblContactName.Visible = True
                TxtContactName.Visible = True
                TxtContactName.Text = DefaultContactName
                TxtContactPhone.Visible = True
                LblContactPhone.Visible = True
                TxtContactPhone.Text = DefaultContactPhone
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                TxtContactOrg.Text = DefaultOrganization
                CallbackPending = 0
                ChkConfirmed.Visible = False
                ChkConfirmed.CheckState = CheckState.Unchecked
                FraCallout.Visible = False
                lblEmail.Visible = False
                txtEmail.Visible = False
            Case OUTGOING
                LblContactName.Visible = True
                TxtContactName.Visible = True
                TxtContactName.Text = DefaultContactName
                TxtContactPhone.Visible = True
                LblContactPhone.Visible = True
                TxtContactPhone.Text = DefaultContactPhone
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                TxtContactOrg.Text = DefaultOrganization
                CallbackPending = 0
                ChkConfirmed.Visible = True
                FraCallout.Visible = False
                LblCallout(0).Visible = True
                LblCallout(1).Visible = False
                lblEmail.Visible = False
                txtEmail.Visible = False
            Case CONSENT_PENDING, RECOVERY_PENDING
                LblContactName.Visible = True
                TxtContactName.Visible = True
                TxtContactName.Text = DefaultContactName
                TxtContactPhone.Visible = True
                LblContactPhone.Visible = True
                TxtContactPhone.Text = DefaultContactPhone
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                TxtContactOrg.Text = DefaultOrganization
                CallbackPending = -1
                ChkConfirmed.Visible = False
                ChkConfirmed.CheckState = CheckState.Unchecked
                FraCallout.Visible = False
                lblEmail.Visible = False
                txtEmail.Visible = False
            Case PAGE_PENDING
                LblContactName.Visible = True
                TxtContactName.Visible = True
                TxtContactName.Text = DefaultContactName
                TxtContactPhone.Visible = True
                LblContactPhone.Visible = True
                TxtContactPhone.Text = DefaultContactPhone
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                TxtContactOrg.Text = DefaultOrganization
                CallbackPending = -1
                ChkConfirmed.Visible = False
                ChkConfirmed.CheckState = CheckState.Unchecked
                FraCallout.Visible = False
                lblEmail.Visible = False
                txtEmail.Visible = False
            Case PAGE_SENT
                LblContactName.Visible = True
                TxtContactName.Visible = True
                TxtContactName.Text = DefaultContactName
                TxtContactPhone.Visible = True
                LblContactPhone.Visible = True
                TxtContactPhone.Text = DefaultContactPhone
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                TxtContactOrg.Text = DefaultOrganization
                CallbackPending = 0
                ChkConfirmed.Visible = False
                ChkConfirmed.CheckState = CheckState.Unchecked
                FraCallout.Visible = False
                lblEmail.Visible = False
                txtEmail.Visible = False
            Case PAGE_RESPONSE, ONLINE_REVIEW_PENDING, DECLARED_CTOD_PENDING, ORGAN_MED_RO_PENDING
                LblContactName.Visible = True
                TxtContactName.Visible = True
                TxtContactName.Text = DefaultContactName
                TxtContactPhone.Visible = False
                LblContactPhone.Visible = False
                TxtContactPhone.Text = ""
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                TxtContactOrg.Text = DefaultOrganization
                CallbackPending = 0
                ChkConfirmed.Visible = True
                FraCallout.Visible = False
                lblEmail.Visible = False
                txtEmail.Visible = False
            Case CALLBACK_PENDING
                LblContactName.Visible = True
                TxtContactName.Visible = True
                TxtContactName.Text = DefaultContactName
                TxtContactPhone.Visible = True
                LblContactPhone.Visible = True
                TxtContactPhone.Text = DefaultContactPhone
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                TxtContactOrg.Text = DefaultOrganization
                CallbackPending = -1
                ChkConfirmed.Visible = False
                ChkConfirmed.CheckState = CheckState.Unchecked
                FraCallout.Visible = True
                LblCallout(0).Visible = False
                LblCallout(1).Visible = True
                lblEmail.Visible = False
                txtEmail.Visible = False
                TxtCalloutMins.TabIndex = 5
                TxtCalloutDate.TabIndex = 6
            Case EMAIL_PENDING
                LblContactName.Visible = True
                TxtContactName.Visible = True
                TxtContactName.Text = DefaultContactName
                txtEmail.Text = DefaultContactPhone
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                TxtContactOrg.Text = DefaultOrganization
                CallbackPending = -1
                ChkConfirmed.Visible = False
                ChkConfirmed.CheckState = CheckState.Unchecked
                FraCallout.Visible = False
                LblContactPhone.Visible = False
                TxtContactPhone.Visible = False
                lblEmail.Visible = True
                txtEmail.Visible = True
            Case EMAIL_SENT
                LblContactName.Visible = True
                TxtContactName.Visible = True
                TxtContactName.Text = DefaultContactName
                txtEmail.Text = DefaultContactPhone
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                TxtContactOrg.Text = DefaultOrganization
                CallbackPending = 0
                ChkConfirmed.Visible = False
                ChkConfirmed.CheckState = CheckState.Unchecked
                FraCallout.Visible = False
                LblContactPhone.Visible = False
                TxtContactPhone.Visible = False
                lblEmail.Visible = True
                txtEmail.Visible = True
            Case Else
                LblContactName.Visible = True
                TxtContactName.Visible = True
                TxtContactName.Text = DefaultContactName
                TxtContactPhone.Visible = False
                LblContactPhone.Visible = False
                TxtContactPhone.Text = ""
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                TxtContactOrg.Text = DefaultOrganization
                CallbackPending = 0
                ChkConfirmed.Visible = False
                ChkConfirmed.CheckState = CheckState.Unchecked
                FraCallout.Visible = False
                lblEmail.Visible = False
                txtEmail.Visible = False
        End Select
    End Sub

    Private Sub CboContactEventType_SelectedIndexChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles CboContactEventType.SelectedIndexChanged
        '************************************************************************************
        'Name: CboContactEventType_Click
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Updates controls depending on content of CboContactEventType
        'Returns: Nothing
        'Params: Item As ListItem
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 12/13/04                         Changed by: Scott Plummer
        'Release #: 7.7.2                               Task: 312
        'Description:  Added Case EMAIL_PENDING and changes to email controls
        '====================================================================================
        '************************************************************************************

        'Set event type
        ContactLogEventTypeID = GetID(CboContactEventType)

        Select Case ContactLogEventTypeID
            Case GENERAL, Donor_Card, CASE_HAND_OFF
                LblContactName.Visible = False
                TxtContactName.Visible = False
                TxtContactName.Text = ""
                TxtContactPhone.Visible = False
                LblContactPhone.Visible = False
                TxtContactPhone.Text = ""
                TxtContactOrg.Visible = False
                LblContactOrg.Visible = False
                TxtContactOrg.Text = ""
                CallbackPending = 0
                ChkConfirmed.Visible = False
                ChkConfirmed.CheckState = CheckState.Unchecked
                FraCallout.Visible = False
                lblEmail.Visible = False
                txtEmail.Visible = False
            Case INCOMING
                LblContactName.Visible = True
                TxtContactName.Visible = True
                TxtContactName.Text = DefaultContactName
                TxtContactPhone.Visible = False
                LblContactPhone.Visible = False
                TxtContactPhone.Text = ""
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                TxtContactOrg.Text = DefaultOrganization
                CallbackPending = 0
                ChkConfirmed.Visible = True
                FraCallout.Visible = False
                lblEmail.Visible = False
                txtEmail.Visible = False
            Case CORONER_CASE
                LblContactName.Visible = True
                TxtContactName.Visible = True
                TxtContactName.Text = DefaultContactName
                TxtContactPhone.Visible = True
                LblContactPhone.Visible = True
                TxtContactPhone.Text = DefaultContactPhone
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                TxtContactOrg.Text = DefaultOrganization
                CallbackPending = 0
                ChkConfirmed.Visible = False
                ChkConfirmed.CheckState = CheckState.Unchecked
                FraCallout.Visible = False
                lblEmail.Visible = False
                txtEmail.Visible = False
            Case OUTGOING
                LblContactName.Visible = True
                TxtContactName.Visible = True
                TxtContactName.Text = DefaultContactName
                TxtContactPhone.Visible = True
                LblContactPhone.Visible = True
                TxtContactPhone.Text = DefaultContactPhone
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                TxtContactOrg.Text = DefaultOrganization
                CallbackPending = 0
                ChkConfirmed.Visible = True
                FraCallout.Visible = False
                LblCallout(0).Visible = True
                LblCallout(1).Visible = False
                lblEmail.Visible = False
                txtEmail.Visible = False
            Case CONSENT_PENDING, RECOVERY_PENDING
                LblContactName.Visible = True
                TxtContactName.Visible = True
                TxtContactName.Text = DefaultContactName
                TxtContactPhone.Visible = True
                LblContactPhone.Visible = True
                TxtContactPhone.Text = DefaultContactPhone
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                TxtContactOrg.Text = DefaultOrganization
                CallbackPending = -1
                ChkConfirmed.Visible = False
                ChkConfirmed.CheckState = CheckState.Unchecked
                FraCallout.Visible = False
                lblEmail.Visible = False
                txtEmail.Visible = False
            Case SECONDARY_PENDING
                LblContactName.Visible = True
                TxtContactName.Visible = True
                TxtContactName.Text = DefaultContactName
                TxtContactPhone.Visible = True
                LblContactPhone.Visible = True
                TxtContactPhone.Text = DefaultContactPhone
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                TxtContactOrg.Text = DefaultOrganization
                CallbackPending = -1
                ChkConfirmed.Visible = False
                ChkConfirmed.CheckState = CheckState.Unchecked
                FraCallout.Visible = False
                lblEmail.Visible = False
                txtEmail.Visible = False
            Case PAGE_PENDING
                LblContactName.Visible = True
                TxtContactName.Visible = True
                TxtContactName.Text = DefaultContactName
                TxtContactPhone.Visible = True
                LblContactPhone.Visible = True
                TxtContactPhone.Text = DefaultContactPhone
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                TxtContactOrg.Text = DefaultOrganization
                CallbackPending = -1
                ChkConfirmed.Visible = False
                ChkConfirmed.CheckState = CheckState.Unchecked
                FraCallout.Visible = False
                lblEmail.Visible = False
                txtEmail.Visible = False
            Case PAGE_SENT
                LblContactName.Visible = True
                TxtContactName.Visible = True
                TxtContactName.Text = DefaultContactName
                TxtContactPhone.Visible = True
                LblContactPhone.Visible = True
                TxtContactPhone.Text = DefaultContactPhone
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                TxtContactOrg.Text = DefaultOrganization
                CallbackPending = 0
                ChkConfirmed.Visible = False
                ChkConfirmed.CheckState = CheckState.Unchecked
                FraCallout.Visible = False
                lblEmail.Visible = False
                txtEmail.Visible = False
            Case PAGE_RESPONSE, ONLINE_REVIEW_RESPONSE, DonorNet_Acceptance, DonorNet_Decline, Labs_Received, No_Labs_Received, DECLARED_CTOD_CONFIRMED, ORGAN_MED_RO_CONFIRMED
                LblContactName.Visible = True
                TxtContactName.Visible = True
                TxtContactName.Text = DefaultContactName
                TxtContactPhone.Visible = False
                LblContactPhone.Visible = False
                TxtContactPhone.Text = ""
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                TxtContactOrg.Text = DefaultOrganization
                CallbackPending = 0
                ChkConfirmed.Visible = True
                FraCallout.Visible = False
                lblEmail.Visible = False
                txtEmail.Visible = False
            Case CALLBACK_PENDING
                LblContactName.Visible = True
                TxtContactName.Visible = True
                TxtContactName.Text = DefaultContactName
                TxtContactPhone.Visible = True
                LblContactPhone.Visible = True
                TxtContactPhone.Text = DefaultContactPhone
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                TxtContactOrg.Text = DefaultOrganization
                CallbackPending = -1
                ChkConfirmed.Visible = False
                ChkConfirmed.CheckState = CheckState.Unchecked
                FraCallout.Visible = True
                LblCallout(0).Visible = False
                LblCallout(1).Visible = True
                lblEmail.Visible = False
                txtEmail.Visible = False
                TxtCalloutMins.TabIndex = 5
                TxtCalloutDate.TabIndex = 6
            Case Labs_Pending
                LblContactName.Visible = True
                TxtContactName.Visible = True
                TxtContactName.Text = ""
                TxtContactPhone.Visible = True
                LblContactPhone.Visible = True
                TxtContactPhone.Text = ""
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                TxtContactOrg.Text = ""
                CallbackPending = -1
                ChkConfirmed.Visible = False
                ChkConfirmed.CheckState = CheckState.Unchecked
                FraCallout.Visible = True
                LblCallout(0).Visible = False
                LblCallout(1).Visible = True
                lblEmail.Visible = False
                txtEmail.Visible = False
                TxtCalloutMins.TabIndex = 5
                TxtCalloutDate.TabIndex = 6
            Case EMAIL_PENDING
                LblContactName.Visible = True
                TxtContactName.Visible = True
                TxtContactName.Text = DefaultContactName
                txtEmail.Text = DefaultContactPhone
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                TxtContactOrg.Text = DefaultOrganization
                CallbackPending = -1
                ChkConfirmed.Visible = False
                ChkConfirmed.CheckState = CheckState.Unchecked
                FraCallout.Visible = False
                LblContactPhone.Visible = False
                TxtContactPhone.Visible = False
                lblEmail.Visible = True
                txtEmail.Visible = True
            Case EMAIL_SENT
                LblContactName.Visible = True
                TxtContactName.Visible = True
                TxtContactName.Text = DefaultContactName
                txtEmail.Text = DefaultContactPhone
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                TxtContactOrg.Text = DefaultOrganization
                CallbackPending = 0
                ChkConfirmed.Visible = False
                ChkConfirmed.CheckState = CheckState.Unchecked
                FraCallout.Visible = False
                LblContactPhone.Visible = False
                TxtContactPhone.Visible = False
                lblEmail.Visible = True
                txtEmail.Visible = True
            Case Acknowledge_to_Evaluate
                LblContactName.Visible = True
                TxtContactName.Visible = True
                TxtContactName.Text = ""
                TxtContactPhone.Visible = True
                LblContactPhone.Visible = True
                TxtContactPhone.Text = ""
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                TxtContactOrg.Text = ""
                CallbackPending = -1
                ChkConfirmed.Visible = False
                ChkConfirmed.CheckState = CheckState.Unchecked
                FraCallout.Visible = False
                lblEmail.Visible = False
                txtEmail.Visible = False
            Case Else
                LblContactName.Visible = True
                TxtContactName.Visible = True
                TxtContactName.Text = DefaultContactName
                TxtContactPhone.Visible = False
                LblContactPhone.Visible = False
                TxtContactPhone.Text = ""
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                TxtContactOrg.Text = DefaultOrganization
                CallbackPending = 0
                ChkConfirmed.Visible = False
                ChkConfirmed.CheckState = CheckState.Unchecked
                FraCallout.Visible = False
                lblEmail.Visible = False
                txtEmail.Visible = False
        End Select
    End Sub


    Private Sub TxtCalloutDate_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles TxtCalloutDate.Enter

        OldCalloutDate = TxtCalloutDate.Text

        Call HighlightText(ActiveControl)

    End Sub


    Private Sub TxtCalloutDate_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles TxtCalloutDate.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        KeyAscii = DateTimeMask(KeyAscii, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub



    Private Sub TxtCalloutDate_Validating(ByVal eventSender As Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles TxtCalloutDate.Validating
        Dim Cancel As Boolean = eventArgs.Cancel

        On Error Resume Next

        Dim MsgResponse As Short

        If OldCalloutDate <> TxtCalloutDate.Text And TxtCalloutDate.Text <> "" Then

            'Check if valid date
            If Not IsDate(TxtCalloutDate.Text) Or Len(TxtCalloutDate.Text) < 15 Then
                Call MsgBox("Date is not valid.", MsgBoxStyle.Exclamation, "Validation Error")
                TxtCalloutDate.Focus()
                Cancel = True
                GoTo EventExitSub
            End If

            'Check if the date/time is before now
            If DateDiff(DateInterval.Minute, Now, CDate(TxtCalloutDate.Text)) < 0 Then
                Call MsgBox("Date/time is before now.", MsgBoxStyle.Exclamation, "Validation Error")
                TxtCalloutDate.Focus()
                Cancel = True
                GoTo EventExitSub
            End If

            'Warn if date/time is greater than one day
            If DateDiff(DateInterval.Day, Now, CDate(TxtCalloutDate.Text)) > 1 Then

                MsgResponse = MsgBox("You have set a callout greater than a 1 day from now. Is this correct?", MsgBoxStyle.Exclamation + MsgBoxStyle.DefaultButton2 + MsgBoxStyle.YesNo, "Validation Error")

                If MsgResponse = MsgBoxResult.No Then
                    TxtCalloutDate.Focus()
                    Cancel = True
                    GoTo EventExitSub
                End If

            End If

            TxtCalloutMins.Text = CStr(DateDiff(DateInterval.Minute, Now, CDate(TxtCalloutDate.Text)))

            If TxtContactDesc.Text = "" Then
                TxtContactDesc.Text = "Callout after " & TxtCalloutDate.Text & "."
            Else
                'Replace the existing date
                TxtContactDesc.Text = Replace(TxtContactDesc.Text, OldCalloutDate, TxtCalloutDate.Text)

            End If
        End If

EventExitSub:
        eventArgs.Cancel = Cancel
    End Sub
    Private Sub TxtCalloutMins_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles TxtCalloutMins.Enter

        OldCalloutMins = TxtCalloutMins.Text

        Call HighlightText(ActiveControl)

    End Sub

    Private Sub TxtCalloutMins_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles TxtCalloutMins.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        KeyAscii = NumMask(KeyAscii, 5, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtCalloutMins_Validating(ByVal eventSender As Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles TxtCalloutMins.Validating
        Dim Cancel As Boolean = eventArgs.Cancel

        On Error Resume Next

        If TxtCalloutMins.Text <> OldCalloutMins Then

            TxtCalloutDate.Text = VB6.Format(DateAdd(DateInterval.Minute, CDbl(TxtCalloutMins.Text), Now), "mm/dd/yy  hh:nn")
            Call TxtCalloutDate_Validating(TxtCalloutDate, New ComponentModel.CancelEventArgs(False))

        End If

        eventArgs.Cancel = Cancel
    End Sub

    Private Sub CboOrganization_SelectedIndexChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles CboOrganization.SelectedIndexChanged

        Dim vReturn As New Object

        'Clear any previous settings

        'Get the ID of the selected location
        OrganizationId = GetID(CboOrganization)
        OrganizationName = GetText(CboOrganization)

        'Get the organization notes
        Call QueryOrganizationNotes(Me)

        'Set the Organization field
        DefaultOrganization = GetText(CboOrganization)
        TxtContactOrg.Text = DefaultOrganization

        TabNotes.SelectedIndex = 1

        'Fill the schedule group list
        Call SelectNone(CboScheduleGroup)
        CboScheduleGroup.Items.Clear()

        'If there no referral organization, then get all the schedule groups
        'that belong to the selected organization
        If ReferralOrganizationID = 0 Then
            If RefQueryScheduleGroup(vReturn, , , OrganizationId) = SUCCESS Then
                Call modControl.SetTextID(CboScheduleGroup, vReturn)

                'If there is only one item, select and display it.
                If UBound(vReturn, 1) = 0 Then
                    Call SelectFirst(CboScheduleGroup)
                End If
            End If

            'Else, get only the schedule groups that are on call for the
            'referral organization
        Else

            Call QueryScheduleGroupsOnCall(Me)

        End If

        'Reset EventTypes & Save Button
        CmdOK.Text = "&Save"
        ShowFilteredEventTypes(EventTypeFilter.Safe)
        If CboContactEventType.SelectedItem Is Nothing OrElse CboContactEventType.SelectedItem.ToString() <> "Outgoing Call" Then
            modControl.SelectID(CboContactEventType, PAGE_PENDING)
        End If

    End Sub

    Private Sub CboScheduleGroup_SelectedIndexChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles CboScheduleGroup.SelectedIndexChanged

        On Error Resume Next

        'Clear the lists
        ChkShowAll.CheckState = CheckState.Unchecked
        LstViewPerson.Items.Clear()
        LstViewContact.Items.Clear()
        TxtPersonNotes.Text = ""
        txtScheduleReferralNotes.Text = ""
        txtScheduleMessageNotes.Text = ""

        UseOldSchedule = False

        'Get the ID of the selected location
        ScheduleGroupID = GetID(CboScheduleGroup)

        'Get the shift cutover time
        Call QueryScheduleShift(Me, UseOldSchedule)

        If UseOldSchedule Then
            Call QueryScheduleShift3(Me)
        End If

        'Get the schedule notes
        Call QueryScheduleGroupNotes(Me)

        'Fill the person grid
        If UseOldSchedule Then
            Call QueryOrganizationSchedulePerson(Me)
        Else
            Call QueryOrganizationNewSchedulePerson(Me)
        End If

        TabNotes.SelectedIndex = 2

        Call HighlightListViewRowNew(LstViewPerson)
        Call HighlightListViewRowNew(LstViewContact)


        'Reset EventTypes & Save Button
        CmdOK.Text = "&Save"
        ShowFilteredEventTypes(EventTypeFilter.Safe)
        If CboContactEventType.SelectedItem Is Nothing OrElse CboContactEventType.SelectedItem.ToString() <> "Outgoing Call" Then
            modControl.SelectID(CboContactEventType, PAGE_PENDING)
        End If

    End Sub

    Private Sub CboScheduleGroup_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles CboScheduleGroup.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        'Allow the delete key to clear the combo box
        Call AllowDelete(CboScheduleGroup, KeyAscii)

        If KeyAscii = 8 Then
            TabNotes.SelectedIndex = 1
        End If

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub ChkShowAll_CheckStateChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles ChkShowAll.CheckStateChanged

        If ChkShowAll.CheckState = 1 Then
            'Find all people belonging to the organization
            'Clear the lists
            LstViewPerson.Items.Clear()
            LstViewPerson.View = View.Details
            TxtPersonNotes.Text = ""
            Call QueryOrganizationPerson(Me)
        Else
            'Refill with on call people
            Call CboScheduleGroup_SelectedIndexChanged(CboScheduleGroup, New EventArgs())
        End If

    End Sub

    Private Sub CmdCancel_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles CmdCancel.Click
        isOnCallEventCancel = True
        Close()

    End Sub

    Private Sub CmdOK_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles CmdOK.Click

        Save()

    End Sub

    Private Sub FrmOnCallEvent_Activated(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Activated

        On Error Resume Next

        If OnCallType = REFERRAL Then
            txtMessageNotes.Visible = False
            TxtReferralNotes.Visible = True
            txtScheduleMessageNotes.Visible = False
            txtScheduleReferralNotes.Visible = True
        ElseIf OnCallType = Message Then
            txtMessageNotes.Visible = True
            TxtReferralNotes.Visible = False
            txtScheduleMessageNotes.Visible = True
            txtScheduleReferralNotes.Visible = False
        End If

        txtMessageNotes.Left = VB6.TwipsToPixelsX(60)
        TxtReferralNotes.Left = VB6.TwipsToPixelsX(60)
        txtScheduleMessageNotes.Left = VB6.TwipsToPixelsX(60)
        txtScheduleReferralNotes.Left = VB6.TwipsToPixelsX(60)

        If CmdOK.Text = "Send &Email" Then
            LstViewContact.Select()
        ElseIf CboOrganization.Items.Count = 1 Then
            TabNotes.SelectedIndex = 0
            TabNotes.SelectedIndex = 1
            CboScheduleGroup.Focus()
        Else
            TabNotes.SelectedIndex = 1
            TabNotes.SelectedIndex = 0
            CboOrganization.Focus()
        End If

    End Sub

    Private Sub FrmOnCallEvent_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load

        '********************************************
        'Initialize On Call Section
        '********************************************
        On Error Resume Next
        Dim vQuery As New Object
        Dim vParams As New Object
        Dim RS As New Object
        Saved = False
        Loaded = False

        'Initialize the organization grid
        Call HighlightListViewRow(LstViewPerson)
        Call LstViewPerson.Columns.Insert(0, "", "#", CInt(VB6.TwipsToPixelsX(400)))
        Call LstViewPerson.Columns.Insert(1, "", "Name", CInt(VB6.TwipsToPixelsX(1850)))
        Call LstViewPerson.Columns.Insert(2, "", "Type", CInt(VB6.TwipsToPixelsX(2050)))

        'Initialize the phone grid
        Call HighlightListViewRow(LstViewContact)
        Call LstViewContact.Columns.Insert(0, "", "#", CInt(VB6.TwipsToPixelsX(400)))
        Call LstViewContact.Columns.Insert(1, "", "Contact #", CInt(VB6.TwipsToPixelsX(1900)))
        Call LstViewContact.Columns.Insert(2, "", "Type", CInt(VB6.TwipsToPixelsX(2050)))

        vLogEventDate = TxtContactDate.Text

        If OrganizationId = 0 And ReferralOrganizationID = 0 Then

            LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Nothing, Trim(ReferralOrganizationID))
            If AppMain.frmOpenAll.TypeEvent = 1 Then
                vQuery = "select * from organization where organizationName = " & "'" & vParentForm.LblOrganization.Text & "'"
            Else
                vQuery = "Select * from organization where organizationname = " & "'" & vParentForm.CboOrganization.Text & "'"
            End If

            Call Exec(vQuery, vParams)
            ReferralOrganizationID = vParams(0, 0)

            LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Nothing, Trim(ReferralOrganizationID))


        End If
        'If the organization ID has not been set and the referral
        'organization ID has not been set, then fill the organization
        'list box with all the organizations that have a schedule.
        If OrganizationId = 0 And ReferralOrganizationID = 0 Then

            Call QueryScheduleOrganizations(Me)
            If CboOrganization.Items.Count > 1 Then
                Call SelectFirst(CboOrganization)
            End If

            'Else if the organization ID has been set, but the
            'referral organization ID has not been set, then
            'fill the organization list with only the selected organization.
        ElseIf OrganizationId <> 0 And ReferralOrganizationID = 0 Then
            CboOrganization.Items.Add(New ValueDescriptionPair(OrganizationId, OrganizationName))
            'Set the organization combo box to the current organization
            Call modControl.SelectID(CboOrganization, OrganizationId)

            'Else if the referral organization ID has been set, then
            'find all the organizations that are on call for the
            'referral organization
        ElseIf ReferralOrganizationID <> 0 Then
            Call QueryScheduleOrganizationsOnCall(Me)
            If CboOrganization.Items.Count = 1 Then
                Call SelectFirst(CboOrganization)
            End If

        End If

        'Default the date
        CurrentDate = CDate(VB6.Format(Now, "mm/dd/yy"))
        Text = Text & " Schedule For: " & CurrentDate


        '********************************************
        'Initialize On Call Section
        '********************************************

        'Fill reference data
        Call QueryLogEventType(Me)

        'Get the date/time
        TxtContactDate.Text = VB6.Format(Now, "mm/dd/yy  hh:mm")

        'Get the employee name
        ContactEmployeeID = AppMain.ParentForm.StatEmployeeID

        'Default the contact type
        Call modControl.SelectID(CboContactEventType, DefaultContactType)

        'Default the contact fields
        TxtContactName.Text = DefaultContactName
        TxtContactPhone.Text = DefaultContactPhone
        TxtContactOrg.Text = DefaultOrganization
        TxtContactDesc.Text = DefaultContactDesc

        'Default the organization
        If OrganizationId <> 0 Then
            Call modControl.SelectID(CboOrganization, OrganizationId)
        End If

        'Default then schedule group
        If ScheduleGroupID <> 0 Then
            Call modControl.SelectID(CboScheduleGroup, ScheduleGroupID)
        End If

        Loaded = True

    End Sub

    Public Function Display() As Object
        ShowDialog()
    End Function

    Private Sub FrmOnCallEvent_FormClosing(ByVal eventSender As Object, ByVal eventArgs As FormClosingEventArgs) Handles MyBase.FormClosing

        Dim vReturn As Short

        If Saved = True Then
            'The message was saved so just unload
            eventArgs.Cancel = False

        ElseIf eventSender.ActiveControl.Text = "Send &Email" Then
            'The email was just sent so let this parent form close
            eventArgs.Cancel = False

        ElseIf eventSender.ActiveControl.Text = "Send &Alpha" Then
            'The page was just sent so let this parent form close
            eventArgs.Cancel = False

        Else
            'The message was cancelled or closed so confirm cancellation
            vReturn = FormCancel()

            If vReturn = MsgBoxResult.Yes Then
                eventArgs.Cancel = False

            Else
                eventArgs.Cancel = True
            End If
        End If

    End Sub

    Private Sub LstViewContact_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles LstViewContact.DoubleClick

        On Error Resume Next

        Dim vPhoneID As Integer
        Dim vReturn As New Object
        On Error Resume Next
        If uIMap Is Nothing Then
            uIMap = OpenStatTracCSharpForms.CreateInstance()
        End If


        'Check that there is a good Peson ID to get

        'Pass the data to the form and
        'get the updated data back
        vPhoneID = uIMap.Open(AppScreenType.OrganizationsOrganizationContactsPhoneEditPopup, PersonID)

        If vPhoneID = 0 Then
            'The user cancelled updating the row,
            'so do nothing
        Else
            'Clear the list
            LstViewContact.Items.Clear()
            LstViewContact.View = View.Details

            'Update the row data
            Call QueryPersonPhone(Me)

        End If

        Activate()

    End Sub

    Private Sub LstViewContact_ItemClick(ByVal Item As ListViewItem)
        '************************************************************************************
        'Name: LstViewContact_ItemClick
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Updates controls depending on content of LstViewContact
        'Returns: Nothing
        'Params: Item As ListItem
        'Stored Procedures: None
        '************************************************************************************

        Dim vReturn As New Object
        Dim I As Short


        'Transfer the person name to the contact fields
        Call GetSelListViewSubItems(LstViewContact, vReturn)

        If (Not ObjectIsValidArray(vReturn, 0, 2)) Then
            Exit Sub
        End If
        DefaultContactPhone = vReturn(0, 1)
        DefaultContactPhoneType = vReturn(0, 2)
        TxtContactPhone.Text = DefaultContactPhone
        lblEmail.Visible = False
        txtEmail.Visible = False
        LblContactPhone.Visible = True
        TxtContactPhone.Visible = True

        Dim AutoResponse As Boolean
        If Not IsNothing(Item.SubItems) _
            AndAlso Item.SubItems.Count > 3 _
            AndAlso Item.SubItems(3).Text IsNot Nothing Then
            AutoResponse = Item.SubItems(3).Text.Equals("True")
        End If

        Call HighlightListViewRowNew(LstViewContact)
        Call HighlightListViewRowNew(LstViewContact)
        If InStr(1, DefaultContactPhoneType, "Alpha") Or InStr(1, DefaultContactPhoneType, "AutoResponse") Then
            CmdOK.Text = "Send &Alpha"
            ShowFilteredEventTypes(EventTypeFilter.Page)
            If AutoResponse Then
                modControl.SelectID(CboContactEventType, PAGE_PENDING)
            Else
                modControl.SelectID(CboContactEventType, PAGE_SENT)
            End If
        ElseIf InStr(1, DefaultContactPhoneType, "Email") Then
            CmdOK.Text = "Send &Email"
            lblEmail.Visible = True
            txtEmail.Visible = True
            LblContactPhone.Visible = False
            txtEmail.Text = DefaultContactPhone
            ShowFilteredEventTypes(EventTypeFilter.Email)
            If AutoResponse Then
                modControl.SelectID(CboContactEventType, EMAIL_PENDING)
            Else
                modControl.SelectID(CboContactEventType, EMAIL_SENT)
            End If
        Else
            CmdOK.Text = "&Save"
            'Make sure we don't reset CboContactEventType when we have a FamilyServicesAlert
            If CboContactEventType.SelectedItem Is Nothing OrElse CboContactEventType.SelectedItem.Value <> FAMILY_SERVICES_ALERT Then
                ShowFilteredEventTypes(EventTypeFilter.Safe)
                modControl.SelectID(CboContactEventType, PAGE_PENDING)
            End If
        End If
        Call HighlightListViewRowNew(LstViewContact)
        Exit Sub

    End Sub

    Private Sub ShowFilteredEventTypes(eventTypeFilter As EventTypeFilter)

        'Repopulate CboContactEventType if necessary
        If CboContactEventType.Items.Count <= 5 Then
            QueryLogEventType(Me)
        End If

        'Identify needed event types
        Dim selectedEventTypes As New List(Of String)
        If eventTypeFilter = EventTypeFilter.Email Then
            selectedEventTypes.Add("Email Pending")
            selectedEventTypes.Add("Email Sent")
        ElseIf eventTypeFilter = EventTypeFilter.Page Then
            selectedEventTypes.Add("Page Pending")
            selectedEventTypes.Add("Page Sent")
        ElseIf eventTypeFilter = EventTypeFilter.Safe Then
            selectedEventTypes.Add("Email Pending")
            selectedEventTypes.Add("Email Sent")
        End If

        'Remove unneeded items
        If selectedEventTypes.Count > 0 Then
            For x As Integer = CboContactEventType.Items.Count - 1 To 0 Step -1
                Dim thisItem As ValueDescriptionPair = CboContactEventType.Items(x)

                If eventTypeFilter = EventTypeFilter.Safe Then

                    'For the standard filter, show all but selected items
                    If selectedEventTypes.Contains(thisItem.Description) Then
                        CboContactEventType.Items.RemoveAt(x)
                    End If

                ElseIf eventTypeFilter = EventTypeFilter.Email Or eventTypeFilter = EventTypeFilter.Page Then

                    'For Email and Page filters, show only selected items
                    If Not selectedEventTypes.Contains(thisItem.Description) Then
                        CboContactEventType.Items.RemoveAt(x)
                    End If

                End If
            Next
        End If

    End Sub


    Private Sub LstViewPerson_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles LstViewPerson.DoubleClick

        On Error Resume Next

        Dim vReturn As New Object

        'Check that there is a good Person ID to get
        PersonID = TextToLng(LstViewPerson.FocusedItem.Tag)

        If PersonID = 0 Or PersonID = -1 Then
            'Do nothing
        Else

            If uIMap Is Nothing Then
                uIMap = OpenStatTracCSharpForms.CreateInstance()
            End If


            'Get the Person id from the Person form
            'after the user is done.
            PersonID = uIMap.Open(AppScreenType.OrganizationsOrganizationContactsContactPropertiesEditPopup, PersonID)

            'Clear the grid
            LstViewPerson.Items.Clear()
            LstViewPerson.View = View.Details

            'Select grid item
            Call CboScheduleGroup_SelectedIndexChanged(CboScheduleGroup, New EventArgs())

        End If

        Activate()

    End Sub


    Private Sub LstViewPerson_ItemClick(ByVal Item As ListViewItem)

        On Error Resume Next

        Dim vReturn As New Object
        Dim I As Short

        'Check that there is a good Person ID to get
        Call GetSelListViewID(LstViewPerson, vReturn)

        If Not TypeOf vReturn Is Array Then
            Exit Sub
        End If

        PersonID = vReturn(0, 0)

        If PersonID = 0 Or PersonID = -1 Then
            'Clear the contact grid
            LstViewContact.Items.Clear()
            LstViewContact.View = View.Details
        Else
            'Clear the contact grid
            LstViewContact.Items.Clear()
            LstViewContact.View = View.Details

            'Get the Person Phone detail
            Call QueryPersonPhone(Me)

            'Get the Person notes
            Call QueryPersonNotes(Me)

        End If


        'Transfer the person name to the contact fields
        Call GetSelListViewSubItems(LstViewPerson, vReturn)
        DefaultContactName = vReturn(0, 1)
        TxtContactName.Text = DefaultContactName

        'Clear the contact phone field
        DefaultContactPhone = ""
        TxtContactPhone.Text = DefaultContactPhone

        lblEmail.Visible = False
        txtEmail.Visible = False

        'Set the person Id of the message form
        For I = 0 To Application.OpenForms.Count - 1
            If Application.OpenForms.Item(I).Name = "FrmMessage" Then
                vParentForm.PersonID = PersonID
            End If
        Next I

        Call HighlightListViewRowNew(LstViewPerson)
        Call HighlightListViewRowNew(LstViewContact)
        If LstViewPerson.FocusedItem.SubItems(2).Text = "FSC" Then
            If CboContactEventType.FindString("Family Services Alert") = -1 Then
                CboContactEventType.Items.Add(New ValueDescriptionPair(FAMILY_SERVICES_ALERT, "Family Services Alert"))
                CboContactEventType.SelectedIndex = CboContactEventType.FindString("Family Services Alert")
            End If
        Else
            If CboContactEventType.FindString("Family Services Alert") > 0 Then
                CboContactEventType.Items.RemoveAt((CboContactEventType.FindString("Family Services Alert")))
            End If
        End If

    End Sub

    Private Sub TabNotes_SelectedIndexChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles TabNotes.SelectedIndexChanged
        Static PreviousTab As Short = TabNotes.SelectedIndex()

        Select Case TabNotes.SelectedIndex

            Case 0
                TxtAlert.Visible = True
                TxtReferralNotes.Visible = False
                txtMessageNotes.Visible = False
                txtScheduleReferralNotes.Visible = False
                txtScheduleMessageNotes.Visible = False
            Case 1
                TxtAlert.Visible = False
                txtScheduleReferralNotes.Visible = False
                txtScheduleMessageNotes.Visible = False

                Select Case OnCallType

                    Case REFERRAL
                        TxtReferralNotes.Visible = True
                    Case Message
                        txtMessageNotes.Visible = True

                End Select

            Case 2
                TxtAlert.Visible = False
                TxtReferralNotes.Visible = False
                txtMessageNotes.Visible = False

                Select Case OnCallType

                    Case REFERRAL
                        txtScheduleReferralNotes.Visible = True
                    Case Message
                        txtScheduleMessageNotes.Visible = True

                End Select

        End Select

        PreviousTab = TabNotes.SelectedIndex()
    End Sub

    Private Sub TxtContactDate_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles TxtContactDate.Enter

        Call HighlightText(ActiveControl)

    End Sub


    Private Sub TxtContactDate_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles TxtContactDate.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        KeyAscii = DateTimeMask(KeyAscii, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub




    Private Sub TxtContactDate_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles TxtContactDate.Leave

        On Error Resume Next

        If Not IsDate(TxtContactDate.Text) Or Len(TxtContactDate.Text) < 15 Then
            Call MsgBox("Date is not valid.", MsgBoxStyle.Exclamation, "Validation Error")
            TxtContactDate.Focus()
        End If

    End Sub

    Private Sub TxtContactDesc_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles TxtContactDesc.KeyDown
        Dim KeyCode As Short = eventArgs.KeyCode
        Dim Shift As Short = eventArgs.KeyData \ &H10000

        If Shift = 2 Then
            KeyCode = IIf(KeyCode = Keys.Tab, 0, KeyCode)
        End If

    End Sub

    Private Sub TxtContactDesc_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles TxtContactDesc.KeyPress, CboOrganization.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        Call QueryKeyCodePhrase(TxtContactDesc, KeyAscii)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtContactDesc_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles TxtContactDesc.Leave

        Dim Message As New Object

        RemoveHandler Activated, AddressOf FrmOnCallEvent_Activated

        ValidateSpelling(TxtContactDesc)

        CmdOK.Enabled = True
        If CboContactEventType.Text = "Outgoing Call" Then
            If InStr(1, UCase(TxtContactDesc.Text), "DPS") > 0 Then
                Message = MsgBox("Please change the event type or description of the event to save", MsgBoxStyle.Critical, "Digital Page")
                CmdOK.Enabled = False
                Exit Sub
            Else
                CmdOK.Enabled = True
            End If

            If InStr(1, UCase(TxtContactDesc.Text), "DIGITAL PAGE SENT") > 0 Then
                Message = MsgBox("Please change the event type or description of the event to save", MsgBoxStyle.Critical, "Digital Page")
                CmdOK.Enabled = False
                Exit Sub
            Else
                CmdOK.Enabled = True
            End If

            If InStr(1, UCase(TxtContactDesc.Text), "DIGITAL") > 0 Then
                Message = MsgBox("Please change the event type or description of the event to save", MsgBoxStyle.Critical, "Digital Page")
                CmdOK.Enabled = False
                Exit Sub
            Else
                CmdOK.Enabled = True
            End If
        End If
        AddHandler Activated, AddressOf FrmOnCallEvent_Activated
    End Sub

    Private Sub TxtContactPhone_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles TxtContactPhone.Enter

        Call HighlightText(ActiveControl)

    End Sub

    Private Sub TxtContactPhone_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles TxtContactPhone.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        KeyAscii = PhoneMask(KeyAscii, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Public Function SetLogEventCode() As String
        '************************************************************************************
        'Name: SetLogEventCode
        'Date Created: 12/13/04                         Created by: Scott Plummer
        'Release: 7.7.2                                 Task: 312
        'Description: Generates text of Log Event Code to be included in emails and auto-response
        '             pages so they can be read by the separate email monitoring application
        '             called PgrRspnse.EXE.
        'Returns: String containing the message ID, followed by the following four pipe-delimited
        '             values: LogEventId, DSN, CallId, and LogEventTypeId
        '             Sample string:  "LogEvent: 9571571|T|4145899|21|
        'Params: None
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 12/16/04                         Changed by: Scott Plummer
        'Release #: 7.7.2                               Task: 312
        'Description:  Create a random number to identify individual emails within
        '              the LogEventNumer field in the DB.
        '====================================================================================
        'Date Changed: 07/17/2007                       Changed by: Bret Knoll
        'Release #: 8.4                                 Task: 8.4.3.9
        'Description:  Save the unique code value generated for this logevent to the global variable
        '               AutoResponseCode. This variable will be used to save to the table AutoResponseCode.
        '               The new table will replace the code being saved the logevent table.
        '====================================================================================
        '************************************************************************************
        On Error GoTo ERR_HANDLER

        Dim sLogEventCode As String = ""

        Const EVENT_DELIMITER As String = "|"

        sLogEventCode = "LogEvent: "
        ' Add the event code for the Log Event

        ' To ensure that the LogEvent generated here will be matched to the one in
        ' the DB, generate a random number to be placed into the otherwise unused
        ' LogEventNumber field.  This is done because the actual LogEventId is not
        ' generated until after the email is sent.  Modifications also made in
        ' modStatSave.SaveLogEvent to handle this.  12/16/04 - SAP
        LogEventNumber = SetLogEventNumber()
        sLogEventCode = sLogEventCode & LogEventNumber & EVENT_DELIMITER
        AutoResponseCode = CInt(CStr(LogEventNumber))
        AutoResonseCodeCount = AutoResonseCodeCount + 1
        ' Add a one=character abbreviation for the DSN
        ' T = Test, P = Production, B = Production Backup, D = Development, I = Issues
        Select Case ConnectionType
            Case PROD_CONN
                sLogEventCode = sLogEventCode & "P" & EVENT_DELIMITER

            Case TEST_CONN
                sLogEventCode = sLogEventCode & "T" & EVENT_DELIMITER

            Case PROD_BKUP_CONN
                sLogEventCode = sLogEventCode & "B" & EVENT_DELIMITER

            Case DEVELOPMENT
                sLogEventCode = sLogEventCode & "D" & EVENT_DELIMITER

            Case ISSUES
                sLogEventCode = sLogEventCode & "I" & EVENT_DELIMITER

        End Select
        ' Add the CallId
        sLogEventCode = sLogEventCode & CallId & EVENT_DELIMITER
        ' Add the LogEventType
        sLogEventCode = sLogEventCode & ContactLogEventTypeID & EVENT_DELIMITER

        SetLogEventCode = sLogEventCode
        Exit Function

ERR_HANDLER:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err, "Process Error, Call #: " & CallId)

    End Function

    Private Sub LstViewPerson_Click(ByVal sender As Object, ByVal e As EventArgs) Handles LstViewPerson.Click, LstViewPerson.SelectedIndexChanged
        Dim lstView As ListViewItem
        If sender.SelectedItems.Count > 0 Then
            lstView = sender.SelectedItems(0)
            ShowFilteredEventTypes(EventTypeFilter.Safe)
            LstViewPerson_ItemClick(lstView) 'Logic may add Family Services Alert
            CmdOK.Text = "&Save"

            'Make sure we don't reset CboContactEventType when we have a FamilyServicesAlert
            If CboContactEventType.SelectedItem Is Nothing OrElse CboContactEventType.SelectedItem.Value <> FAMILY_SERVICES_ALERT Then
                modControl.SelectID(CboContactEventType, PAGE_PENDING)
            End If
        End If



    End Sub

    Private Sub LstViewContact_Click(ByVal sender As Object, ByVal e As EventArgs) Handles LstViewContact.Click, LstViewContact.SelectedIndexChanged
        Dim lstView As ListViewItem
        If sender.SelectedItems.Count > 0 Then
            lstView = sender.SelectedItems(0)
            LstViewContact_ItemClick(lstView)
        End If


    End Sub



    Private Sub LstViewPerson_KeyDown(ByVal sender As Object, ByVal e As KeyEventArgs) Handles LstViewPerson.KeyDown
        If e.KeyCode = Keys.Space Then
            Dim lstView As ListViewItem
            If sender.SelectedItems.Count > 0 Then
                lstView = sender.SelectedItems(0)
                LstViewPerson_ItemClick(lstView)
            End If
        End If

    End Sub

    Private Sub LstViewContact_KeyDown(ByVal sender As Object, ByVal e As KeyEventArgs) Handles LstViewContact.KeyDown

        If e.KeyCode = Keys.Space Then
            Dim lstView As ListViewItem
            If sender.SelectedItems.Count > 0 Then
                lstView = sender.SelectedItems(0)
                LstViewContact_ItemClick(lstView)
            End If
        End If
    End Sub

    Private Sub LstViewPerson_DrawSubItem(ByVal sender As Object, ByVal e As DrawListViewSubItemEventArgs) Handles LstViewPerson.DrawSubItem
        Dim sf As New StringFormat()

        e.Graphics.DrawString(e.SubItem.Text, LstViewPerson.Font, Brushes.Red, e.Bounds, sf)

    End Sub

    Private Sub Save()

        Dim vFSAlert As Boolean
        Dim I As Short
        Dim vSecondaryStatus As Short
        Dim vLogEventID As Integer
        Dim Message As New Object
        Dim selectedIndex As Integer

        If Not IsNothing(LstViewPerson.FocusedItem) Then
            selectedIndex = LstViewPerson.FocusedItem.Index
        End If

        'make sure the user wants to save
        If FormSave() = MsgBoxResult.Cancel Then
            Exit Sub
        End If

        'look at TxtContactDesc.Text for OutgoingCalls
        If CboContactEventType.Text = "Outgoing Call" Then
            If InStr(1, UCase(TxtContactDesc.Text), "DPS") > 0 _
                Or InStr(1, UCase(TxtContactDesc.Text), "DIGITAL PAGE SENT") > 0 _
                Or InStr(1, UCase(TxtContactDesc.Text), "DIGITAL") > 0 Then
                Message = MsgBox("Please change the event type or description of the event to save", MsgBoxStyle.Critical, "Digital Page")
                CmdOK.Enabled = False
                Exit Sub
            Else
                CmdOK.Enabled = True
            End If
        End If

        If GetID(CboContactEventType) = INCOMING _
            Or GetID(CboContactEventType) = CONSENT_RESPONSE _
            Or GetID(CboContactEventType) = RECOVERY_RESPONSE _
            Or GetID(CboContactEventType) = Case_Update Then

            'Set referralQAReviewComplete flag
            If AppMain.ParentForm.LeaseOrganization = 0 Then
                vQAResetSwitch = 1 'Allows the referral to show under the Update Tab Statline users
            Else
                vQAResetSwitch = 2 'Allows the ASP referral to show under the Update Tab for ASP users
            End If

            Call UpdateReferralQAComplete(Me)

        ElseIf GetID(CboContactEventType) = FAMILY_SERVICES_ALERT Then

            vFSAlert = True

            'Make sure CboContactEventType has OutgoingCall available as one of it's items
            If CboContactEventType.FindString("Outgoing Call") = -1 Then
                CboContactEventType.Items.Add(New ValueDescriptionPair(OUTGOING, "Outgoing Call"))

                'Log a detailed message when app tries to select Outgoing Call in the EventType combobox.
                Dim newEx = New Exception("FrmOnCallEvent.Save Error: Tried to select Outgoing Call from the EventType combobox but it wasn't in the list.")
                StatTracLogger.CreateInstance().Write(newEx)
            End If
            modControl.SelectID(CboContactEventType, OUTGOING)

            'Set Contact Confirmed to yes
            ChkConfirmed.CheckState = CheckState.Checked

        Else
            vFSAlert = False
        End If

        'Validate the data
        If Not LogEvent(Me) Then

            If vFSAlert = True Then
                CboContactEventType.SelectedIndex = 0
            End If

            Exit Sub
        End If

        If GetID(CboContactEventType) = CONSENT_RESPONSE Or GetID(CboContactEventType) = RECOVERY_RESPONSE Then
            Call MsgBox("Please update disposition data on the main referral form.", MsgBoxStyle.Exclamation, "Update Disposition")
        End If

        'Check to see if we need to send a message
        If Not CmdOK.Text.Equals("&Save") Then

            'Send message and exit save sub if message fails
            If SendMessage() = False Then
                Exit Sub
            End If

        End If

        'Save the event
        Call SaveLogEvent(Me)

        Dim fsResults As New Object
        If vFSAlert = True Then

            'Check if a Secondary pending for Statline already exists, if not then create one
            vSecondaryStatus = QueryCreateSecondaryPending(Me)
            If vSecondaryStatus = CREATE_SECONDARY_PENDING Then

                'Set form fields for Secondary Pending event
                ContactLogEventTypeID = 15
                TxtContactName.Text = ""
                TxtContactPhone.Text = ""
                TxtContactOrg.Text = "Statline"
                If TxtContactDesc.Text.Length = 0 Then
                    TxtContactDesc.Text = "Waiting for secondary medical screening."
                End If
                CallbackPending = -1
                modControl.SelectID(CboOrganization, 194)
                If (IsNothing(CboOrganization.SelectedItem)) Then
                    CboOrganization.Items.Add(New ValueDescriptionPair(194, "Statline"))
                    modControl.SelectID(CboOrganization, 194)
                End If

                If CboScheduleGroup.SelectedIndex = -1 Then
                    SelectFirst(CboScheduleGroup)
                End If
                If IsNothing(LstViewPerson.FocusedItem) And LstViewPerson.Items.Count > 0 Then
                    LstViewPerson.Items.Item(selectedIndex).Selected = True
                End If
                If Not IsNothing(LstViewPerson.FocusedItem) Then
                    LstViewPerson.FocusedItem.Tag = CStr(-1)
                End If

                ChkConfirmed.CheckState = CheckState.Unchecked
                TxtCalloutDate.Text = ""

                'Create a Secondary pending event
                vLogEventID = SaveLogEvent(Me, SECONDARY_PENDING)

                If QueryFSCase(Me, fsResults) Then
                    Call SaveFSLogEvent(Me, fsResults)
                End If

                vParentForm.FSAlert = True
            End If
        End If

        Saved = True
        Close()

    End Sub

    Private Function SendMessage() As Boolean

        Const errorMessage As String = "There is no pager email address associated with this pager. No page was sent."
        Dim frmAlphaMsg As New FrmAlphaMsg
        Dim frmEmail As New FrmEmail
        Dim vQuery As String = ""
        Dim vResultArray As New Object
        Dim vReturn As Short
        Dim MaxLength As Short
        Dim messageSentSuccessful As Boolean = False
        Dim messageSentCancelled As Boolean = False

        SendMessage = False
        vQuery = String.Format("SELECT p.PhoneTypeID, pp.PhoneAlphaPagerEmail FROM PersonPhone pp, Phone p WHERE pp.PhoneID = p.PhoneID AND pp.PhoneID = {0} AND pp.PersonID = {1}", TextToLng(LstViewContact.FocusedItem.Tag), PersonID)
        vReturn = Exec(vQuery, vResultArray)

        If vReturn = SUCCESS AndAlso ObjectIsValidArray(vResultArray, 0, 1) AndAlso vResultArray(0, 1) <> "" Then

            Select Case vResultArray(0, 0)
                Case PHONE_TYPE_PAGER_ALPHA
                    frmAlphaMsg.Recipient = vResultArray(0, 1)
                    frmAlphaMsg.AlphaMsg = AlphaMsg
                    frmAlphaMsg.CallId = CallId
                    frmAlphaMsg.FormParent = Application.OpenForms(Application.OpenForms.Count - 1)
                    frmAlphaMsg.ShowDialog()
                    frmAlphaMsg.Recipient = ""
                    frmAlphaMsg.CallId = 0
                    messageSentSuccessful = True
                    messageSentCancelled = frmAlphaMsg.MessageSentCancelled
                    LogEventDescription = frmAlphaMsg.MessageBody
                Case PHONE_TYPE_PAGER_AUTORESPONSE
                    MaxLength = frmAlphaMsg.TxtAlpha.MaxLength
                    frmAlphaMsg.TxtAlpha.MaxLength = 0
                    frmAlphaMsg.Recipient = vResultArray(0, 1)
                    frmAlphaMsg.MessageSubject = AutoResponseSbj
                    frmAlphaMsg.Sender = "PgrRspnse@Statline.com"
                    frmAlphaMsg.AlphaMsg = AutoResponseMsg
                    frmAlphaMsg.LogEventCode = SetLogEventCode()
                    frmAlphaMsg.AutoPage = True
                    frmAlphaMsg.CallId = CallId
                    frmAlphaMsg.FormParent = Application.OpenForms(Application.OpenForms.Count - 1)
                    frmAlphaMsg.ShowDialog()
                    frmAlphaMsg.Recipient = ""
                    frmAlphaMsg.MessageSubject = ""
                    frmAlphaMsg.Sender = ""
                    frmAlphaMsg.CallId = 0
                    frmAlphaMsg.TxtAlpha.MaxLength = MaxLength
                    frmAlphaMsg.AutoPage = False
                    messageSentSuccessful = True
                    messageSentCancelled = frmAlphaMsg.MessageSentCancelled
                    LogEventDescription = frmAlphaMsg.MessageBody
                Case PHONE_TYPE_EMAIL
                    frmEmail.TxtEmail.MaxLength = 0
                    frmEmail.Recipient = txtEmail.Text
                    frmEmail.MessageSubject = EmailSbj
                    frmEmail.Sender = "PgrRspnse@Statline.com"
                    frmEmail.EmailMsg = EmailMsg
                    frmEmail.LogEventCode = SetLogEventCode()
                    frmEmail.CallId = CallId
                    frmEmail.FormParent = Application.OpenForms(Application.OpenForms.Count - 1)
                    frmEmail.ShowDialog()
                    frmEmail.CallId = 0
                    frmEmail.Recipient = ""
                    messageSentSuccessful = True
                    messageSentCancelled = frmEmail.MessageSentCancelled
                    LogEventDescription = frmEmail.EmailAddendum
            End Select

        End If

        If messageSentCancelled Then
            SendMessage = False
        ElseIf messageSentSuccessful Then
            SendMessage = True
        Else
            SendMessage = False
            MsgBox(errorMessage)

            'Log an exception
            Dim newException As New Exception("Message failed from FrmOnCallEvent.SendMessage")
            StatTracLogger.CreateInstance().Write(newException)

        End If

    End Function

    Private Sub FrmOnCallEvent_Shown(sender As Object, e As EventArgs) Handles MyBase.Shown
        Me.BringToFront()
    End Sub
End Class