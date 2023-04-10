Option Strict Off
Option Explicit On
Imports Statline.Stattrac.Framework
Imports VB = Microsoft.VisualBasic
Friend Class FrmLogEvent
    Inherits System.Windows.Forms.Form

    Public PassedForm As System.Windows.Forms.Form

    '10/8/01 drh
    Public vParentForm As Object

    Public FormState As Short
    Public CallId As Integer
    Public CallNumber As String

    Public LogEventID As Integer
    Public LogEventTypeID As Integer
    Public CallbackPending As Short
    Public LogEventTypeList As Object

    Public ContactLogEventID As Integer
    Public ContactLogEventTypeID As Integer
    Dim fvContactLogEventDate As Date

    Dim vLogEventDate As String = ""

    Public OrganizationTimeZone As String

    Public DefaultContactName As String
    Public DefaultContactPhone As String
    Public DefaultOrganization As String
    Public DefaultOrganizationID As Short
    Public DefaultContactType As Short
    Public DefaultContactDesc As String
    Public ContactEmployeeID As Integer

    Public Saved As Short
    Public UpdatePendingEvent As Boolean
    Public FormLoad As Short

    Public OrganizationId As Integer
    Public OrganizationName As String
    Public ScheduleGroupID As Integer
    Public PersonID As Integer
    Public PhoneID As Integer

    Public OldCalloutDate As String
    Public OldCalloutMins As String

    'ccarroll 12/09/2008 StatTrac 8.4.7 release
    'Flag Family Approach when event type changes
    Public FamilyApproachSelected As Boolean
    'Track when form is opened
    Public OriginalContactEventTypeID As Short



    '10/03/02 drh
    Public AuditLogId As Integer

    'sub added 05/25/01 ttw
    Private Sub UpdateCboNameText(ByRef pvValue As String)
        Dim inpt As String = ""

        If IsNothing(pvValue) Then
            Return
        End If

        'ccarroll 11/19/2010 Changed if statement to look for 
        'value description pair.(wi:8425)
        If (modControl.GetText(CboName).Length = 0) Then
            If Not CboName.Items.Contains(pvValue) Then
                inpt = pvValue
                CboName.Items.Add(New ValueDescriptionPair(0, pvValue))
                Call modControl.SelectText(CboName, inpt)
            End If
        End If

    End Sub

    Private Sub CboContactEventType_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboContactEventType.TextChanged
        '************************************************************************************
        'Name: CboContactEventType_Change
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Updates controls depending on content of CboContactEventType
        'Returns: Nothing
        'Params: Item As ListItem
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 12/14/04                         Changed by: Scott Plummer
        'Release #: 7.7.2                               Task: 312
        'Description:  Added settings for LogEventType of EMAIL_PENDING, added email controls
        '====================================================================================
        'Date Changed: 6/16/05                          Changed by: Scott Plummer
        'Release #: 8.0                               Task: 416
        'Description:  Added new LogEvent types (APPROACH_PENDING, APPROACH_ATTEMPTED_NO_OUTCOME,
        '               APPROACH_OUTCOME, SECONDARY_ATTEMPTED_NO_OUTCOME
        '====================================================================================
        'Date Changed: 6/18/2008                          Changed by: ccarroll
        'Release #: 8.4.6                               Task: 8.4.6
        'Description:  Added new LogEvent type: Incoming_Secondary
        '************************************************************************************


        Dim Message As New Object

        SetOkEnabled(True)

        'Set event type
        Try
            Me.ContactLogEventTypeID = modControl.GetID(CboContactEventType)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        'Reset lblContactPhone.  12/14/04 - SAP
        LblContactPhone.Text = "Phone"
        If Me.CboContactEventType.Text = "Outgoing Call" Then
            If InStr(1, UCase(TxtContactDesc.Text), "DPS") > 0 Then
                Message = MsgBox("Please change the event type or description of the event to save", MsgBoxStyle.Critical, "Digital Page")
                SetOkEnabled(False)
                Exit Sub
            Else
                SetOkEnabled(True)
            End If

            If InStr(1, UCase(TxtContactDesc.Text), "DIGITAL PAGE SENT") > 0 Then
                Message = MsgBox("Please change the event type or description of the event to save", MsgBoxStyle.Critical, "Digital Page")
                SetOkEnabled(False)
                Exit Sub
            Else
                SetOkEnabled(True)
            End If

            If InStr(1, UCase(TxtContactDesc.Text), "DIGITAL") > 0 Then
                Message = MsgBox("Please change the event type or description of the event to save", MsgBoxStyle.Critical, "Digital Page")
                SetOkEnabled(False)
                Exit Sub
            Else
                SetOkEnabled(True)
            End If
        End If
        Select Case Me.ContactLogEventTypeID
            Case GENERAL, Manual_Registry_Checked, Consent_Obtained, Paperwork_Completed, Paperwork_Faxed, Family_Approached, CASE_HAND_OFF
                LblContactName.Visible = False
                'replaced txt w/cbo
                CboName.Visible = False
                'Added: 05/25/01 ttw - to all case lines below

                UpdateCboNameText(Me.DefaultContactName)
                'TxtContactName.Visible = False
                'TxtContactName.Text = ""
                TxtContactPhone.Visible = False
                LblContactPhone.Visible = False
                TxtContactPhone.Text = ""
                TxtContactOrg.Visible = False
                LblContactOrg.Visible = False
                TxtContactOrg.Text = ""
                Me.CallbackPending = 0
                ChkConfirmed.Visible = False
                ChkConfirmed.CheckState = System.Windows.Forms.CheckState.Unchecked
                FraCallout.Visible = False

            Case INCOMING
                LblContactName.Visible = True
                CboName.Visible = True
                UpdateCboNameText((Me.DefaultContactName))
                'TxtContactName.Visible = True
                'TxtContactName.Text = Me.DefaultContactName
                TxtContactPhone.Visible = False
                LblContactPhone.Visible = False
                TxtContactPhone.Text = ""
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                SetDefaultOrganization()
                Me.CallbackPending = 0
                ChkConfirmed.Visible = True
                FraCallout.Visible = False
            Case CORONER_CASE
                LblContactName.Visible = True
                CboName.Visible = True
                UpdateCboNameText((Me.DefaultContactName))
                'TxtContactName.Visible = True
                'TxtContactName.Text = Me.DefaultContactName
                TxtContactPhone.Visible = True
                LblContactPhone.Visible = True
                SetDefaultContactPhone()
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                SetDefaultOrganization()
                Me.CallbackPending = 0
                ChkConfirmed.Visible = False
                ChkConfirmed.CheckState = System.Windows.Forms.CheckState.Unchecked
                FraCallout.Visible = False
            Case OUTGOING
                LblContactName.Visible = True
                CboName.Visible = True
                UpdateCboNameText((Me.DefaultContactName))
                'TxtContactName.Visible = True
                'TxtContactName.Text = Me.DefaultContactName
                TxtContactPhone.Visible = True
                LblContactPhone.Visible = True
                SetDefaultContactPhone()
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                SetDefaultOrganization()
                Me.CallbackPending = 0
                ChkConfirmed.Visible = True

                If ChkConfirmed.CheckState = System.Windows.Forms.CheckState.Checked Then
                    FraCallout.Visible = False
                Else
                    FraCallout.Visible = True
                End If

                LblCallout(0).Visible = True
                LblCallout(1).Visible = False
            Case CONSENT_PENDING, RECOVERY_PENDING
                LblContactName.Visible = True
                CboName.Visible = True
                UpdateCboNameText((Me.DefaultContactName))
                'TxtContactName.Visible = True
                'TxtContactName.Text = Me.DefaultContactName
                TxtContactPhone.Visible = True
                LblContactPhone.Visible = True
                SetDefaultContactPhone()
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                SetDefaultOrganization()
                Me.CallbackPending = -1
                ChkConfirmed.Visible = False
                ChkConfirmed.CheckState = System.Windows.Forms.CheckState.Unchecked
                FraCallout.Visible = False
            Case SECONDARY_PENDING
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                TxtContactOrg.Text = "Statline"
                Me.CallbackPending = -1
                ChkConfirmed.Visible = False
                ChkConfirmed.CheckState = System.Windows.Forms.CheckState.Unchecked
                FraCallout.Visible = False
            Case PAGE_PENDING, DonorNet_Acceptance, DonorNet_Decline, Labs_Received, No_Labs_Received, DECLARED_CTOD_PENDING, ORGAN_MED_RO_PENDING
                cmdNameDetail.Visible = True
                LblContactName.Visible = True
                CboName.Visible = True
                UpdateCboNameText((Me.DefaultContactName))
                'TxtContactName.Visible = True
                'TxtContactName.Text = Me.DefaultContactName
                TxtContactPhone.Visible = True
                LblContactPhone.Visible = True
                SetDefaultContactPhone()
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                SetDefaultOrganization()
                Me.CallbackPending = -1
                ChkConfirmed.Visible = False
                ChkConfirmed.CheckState = System.Windows.Forms.CheckState.Unchecked
                FraCallout.Visible = False
            Case PAGE_RESPONSE, ONLINE_REVIEW_PENDING, DECLARED_CTOD_PENDING, ORGAN_MED_RO_PENDING
                LblContactName.Visible = True
                CboName.Visible = True
                UpdateCboNameText((Me.DefaultContactName))
                'TxtContactName.Visible = True
                'TxtContactName.Text = Me.DefaultContactName
                TxtContactPhone.Visible = False
                LblContactPhone.Visible = False
                TxtContactPhone.Text = ""
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                SetDefaultOrganization()
                Me.CallbackPending = 0
                ChkConfirmed.Visible = True
                FraCallout.Visible = False
            Case CALLBACK_PENDING
                LblContactName.Visible = True
                CboName.Visible = True
                UpdateCboNameText((Me.DefaultContactName))
                'TxtContactName.Visible = True
                'TxtContactName.Text = Me.DefaultContactName
                TxtContactPhone.Visible = True
                LblContactPhone.Visible = True
                SetDefaultContactPhone()
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                SetDefaultOrganization()
                Me.CallbackPending = -1
                ChkConfirmed.Visible = False
                ChkConfirmed.CheckState = System.Windows.Forms.CheckState.Unchecked
                FraCallout.Visible = True
                LblCallout(0).Visible = False
                LblCallout(1).Visible = True

                'ccarroll 04/15/2010 replaced tab order
                ' to emulate Old StatTrac
                CboName.TabIndex = 8
                TxtContactOrg.TabIndex = 9
                TxtContactPhone.TabIndex = 10
                Me.TxtCalloutMins.TabIndex = 11
                Me.TxtCalloutDate.TabIndex = 12
                Me.TxtContactDesc.TabIndex = 13
                Me.CmdOK.TabIndex = 14
                Me.CmdCancel.TabIndex = 15
                Me.TxtContactDate.TabIndex = 16
                Me.cmdNameDetail.TabIndex = 17

                'ccarroll  04/28/2011
                'removed EMAIL_RESPONSE wi:12151
                'showing as contact reqired and moved to CASE
            Case EMAIL_PENDING
                LblContactName.Visible = True
                CboName.Visible = True
                UpdateCboNameText((Me.DefaultContactName))
                TxtContactPhone.Visible = True
                LblContactPhone.Text = "Email"
                LblContactPhone.Visible = True
                SetDefaultContactPhone()
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                SetDefaultOrganization()
                Me.CallbackPending = -1
                ChkConfirmed.Visible = True
                ChkConfirmed.CheckState = System.Windows.Forms.CheckState.Unchecked
                FraCallout.Visible = False

            Case EMAIL_RESPONSE
                LblContactName.Visible = True
                CboName.Visible = True
                UpdateCboNameText((Me.DefaultContactName))
                TxtContactPhone.Visible = True
                LblContactPhone.Text = "Email"
                LblContactPhone.Visible = True
                SetDefaultContactPhone()
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                SetDefaultOrganization()
                Me.CallbackPending = 0
                ChkConfirmed.Visible = True
                ChkConfirmed.CheckState = System.Windows.Forms.CheckState.Unchecked
                FraCallout.Visible = False

            Case Incoming_Secondary
                LblContactName.Visible = True
                CboName.Visible = True
                UpdateCboNameText((Me.DefaultContactName))
                TxtContactPhone.Visible = True
                LblContactPhone.Visible = True
                SetDefaultContactPhone()
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                SetDefaultOrganization()
                Me.CallbackPending = 0
                ChkConfirmed.Visible = False
                ChkConfirmed.CheckState = System.Windows.Forms.CheckState.Unchecked
                FraCallout.Visible = False

                ' Added new LogEvent types for v.8.0.  6/16/05 - SAP
                'Case APPROACH_PENDING, APPROACH_ATTEMPTED_NO_OUTCOME, _
                ''   APPROACH_OUTCOME, SECONDARY_ATTEMPTED_NO_OUTCOME
            Case EREFERRAL_RESPONSE
                LblContactName.Visible = True
                CboName.Visible = True
                UpdateCboNameText((AppMain.ParentForm.StatEmployeeName))
                TxtContactPhone.Visible = False
                LblContactPhone.Visible = False
                TxtContactPhone.Text = ""
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                TxtContactOrg.Text = "Statline"
                Me.CallbackPending = 0
                ChkConfirmed.Visible = False
                ChkConfirmed.CheckState = System.Windows.Forms.CheckState.Unchecked
                FraCallout.Visible = False

            Case Else
                LblContactName.Visible = True
                CboName.Visible = True
                UpdateCboNameText((Me.DefaultContactName))
                'TxtContactName.Visible = True
                'TxtContactName.Text = Me.DefaultContactName
                TxtContactPhone.Visible = False
                LblContactPhone.Visible = False
                TxtContactPhone.Text = ""
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                SetDefaultOrganization()
                Me.CallbackPending = 0
                ChkConfirmed.Visible = False
                ChkConfirmed.CheckState = System.Windows.Forms.CheckState.Unchecked
                FraCallout.Visible = False

        End Select
    End Sub

    Private Sub CboContactEventType_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboContactEventType.SelectedIndexChanged
        '************************************************************************************
        'Name: CboContactEventType_Click
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Updates controls depending on content of CboContactEventType
        'Returns: Nothing
        'Params: Item As ListItem
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 12/14/04                         Changed by: Scott Plummer
        'Release #: 7.7.2                               Task: 312
        'Description:  Added settings for LogEventType of EMAIL_PENDING, added email controls
        '====================================================================================
        'Date Changed: 6/16/05                          Changed by: Scott Plummer
        'Release #: 8.0                               Task: 416
        'Description:  Added new LogEvent types (APPROACH_PENDING, APPROACH_ATTEMPTED_NO_OUTCOME,
        '               APPROACH_OUTCOME, SECONDARY_ATTEMPTED_NO_OUTCOME
        '************************************************************************************
        Dim Message As New Object
        'Set event type
        Try
            Me.ContactLogEventTypeID = modControl.GetID(CboContactEventType)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        'Reset lblContactPhone.  12/14/04 - SAP
        LblContactPhone.Text = "Phone"
        If Me.CboContactEventType.Text = "Outgoing Call" Then
            If InStr(1, UCase(TxtContactDesc.Text), "DPS") > 0 Then
                Message = MsgBox("Please change the event type or description of the event to save", MsgBoxStyle.Critical, "Digital Page")
                SetOkEnabled(False)
                Exit Sub
            Else
                SetOkEnabled(True)
            End If

            If InStr(1, UCase(TxtContactDesc.Text), "DIGITAL PAGE SENT") > 0 Then
                Message = MsgBox("Please change the event type or description of the event to save", MsgBoxStyle.Critical, "Digital Page")
                SetOkEnabled(False)
                Exit Sub
            Else
                SetOkEnabled(True)
            End If

            If InStr(1, UCase(TxtContactDesc.Text), "DIGITAL") > 0 Then
                Message = MsgBox("Please change the event type or description of the event to save", MsgBoxStyle.Critical, "Digital Page")
                SetOkEnabled(False)
                Exit Sub
            Else
                SetOkEnabled(True)
            End If
        Else
            'ccarroll 09/18/2007 added to restore CmdOK if no conditions are true
            SetOkEnabled(True)

        End If
        Select Case Me.ContactLogEventTypeID
            Case GENERAL, CASE_HAND_OFF, Manual_Registry_Checked, Consent_Obtained, Paperwork_Completed, Paperwork_Faxed, Donor_Card, Process_Exception
                'displays Date/Time and Description
                LblContactName.Visible = False
                CboName.Visible = False
                'Added: 05/25/01 ttw - to all case lines below
                'UpdateCboNameText Me.DefaultContactName
                'TxtContactName.Visible = False
                'TxtContactName.Text = ""

                'Added: 06/26/01 bjk for notes
                CboName.Items.Clear()
                cmdNameDetail.Visible = False

                TxtContactPhone.Visible = False
                LblContactPhone.Visible = False
                TxtContactPhone.Text = ""
                TxtContactOrg.Visible = False
                LblContactOrg.Visible = False
                TxtContactOrg.Text = ""
                Me.CallbackPending = 0
                ChkConfirmed.Visible = False
                ChkConfirmed.CheckState = System.Windows.Forms.CheckState.Unchecked
                FraCallout.Visible = False

                'ccarroll 04/15/2010 added callout visibility to form
                _LblCallout_0.Visible = False
                TxtCalloutMins.Visible = False
                _label_1.Visible = False
                TxtCalloutDate.Visible = False

            Case INCOMING
                LblContactName.Visible = True
                CboName.Visible = True
                cmdNameDetail.Visible = True
                UpdateCboNameText((Me.DefaultContactName))
                'TxtContactName.Visible = True
                'TxtContactName.Text = Me.DefaultContactName
                TxtContactPhone.Visible = False
                LblContactPhone.Visible = False
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                SetDefaultOrganization()
                Me.CallbackPending = 0
                ChkConfirmed.Visible = True
                FraCallout.Visible = False

                'ccarroll 04/15/2010 added callout visibility to form
                _LblCallout_0.Visible = False
                TxtCalloutMins.Visible = False
                _label_1.Visible = False
                TxtCalloutDate.Visible = False

            Case CORONER_CASE
                LblContactName.Visible = True
                CboName.Visible = True
                cmdNameDetail.Visible = True
                UpdateCboNameText((Me.DefaultContactName))
                'TxtContactName.Visible = True
                'TxtContactName.Text = Me.DefaultContactName
                TxtContactPhone.Visible = True
                LblContactPhone.Visible = True
                SetDefaultContactPhone()
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                SetDefaultOrganization()
                Me.CallbackPending = 0
                ChkConfirmed.Visible = False
                ChkConfirmed.CheckState = System.Windows.Forms.CheckState.Unchecked
                FraCallout.Visible = False

                'ccarroll 04/15/2010 added callout visibility to form
                _LblCallout_0.Visible = False
                TxtCalloutMins.Visible = False
                _label_1.Visible = False
                TxtCalloutDate.Visible = False

            Case OUTGOING
                LblContactName.Visible = True
                CboName.Visible = True
                cmdNameDetail.Visible = True
                UpdateCboNameText((Me.DefaultContactName))
                'TxtContactName.Visible = True
                'TxtContactName.Text = Me.DefaultContactName
                TxtContactPhone.Visible = True
                LblContactPhone.Visible = True
                SetDefaultContactPhone()
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                SetDefaultOrganization()
                Me.CallbackPending = 0
                ChkConfirmed.Visible = True

                If ChkConfirmed.CheckState = System.Windows.Forms.CheckState.Checked Then
                    FraCallout.Visible = False
                Else
                    FraCallout.Visible = True
                End If

                LblCallout(0).Visible = False
                LblCallout(1).Visible = False

                'ccarroll 04/21/2010 removed  visibility for OUTGOING
                _LblCallout_0.Visible = False
                TxtCalloutMins.Visible = False
                _label_1.Visible = False
                TxtCalloutDate.Visible = False

            Case Family_Approached
                LblContactName.Visible = True
                CboName.Visible = True
                cmdNameDetail.Visible = True
                UpdateCboNameText((Me.DefaultContactName))
                'TxtContactName.Visible = True
                'TxtContactName.Text = Me.DefaultContactName
                TxtContactPhone.Visible = True
                LblContactPhone.Visible = True
                SetDefaultContactPhone()
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                SetDefaultOrganization()
                Me.CallbackPending = 0
                ChkConfirmed.Visible = True
                TxtCalloutMins.Visible = False
                Me.TxtCalloutDate.Visible = False
                Me.LblCallout(0).Visible = False
                Me.label(1).Visible = False

                'ccarroll 04/15/2010 added callout visibility to form
                _LblCallout_0.Visible = False
                TxtCalloutMins.Visible = False
                _label_1.Visible = False
                TxtCalloutDate.Visible = False

                'ccarroll 12/09/2008 StatTrac 8.4.7 release
                'Check to see if contact event type changed
                If Me.ContactLogEventTypeID <> Me.OriginalContactEventTypeID And Me.OriginalContactEventTypeID <> 0 Then
                    Me.FamilyApproachSelected = True
                End If

            Case CONSENT_PENDING, RECOVERY_PENDING
                LblContactName.Visible = True
                CboName.Visible = True
                cmdNameDetail.Visible = True
                UpdateCboNameText((Me.DefaultContactName))
                'TxtContactName.Visible = True
                'TxtContactName.Text = Me.DefaultContactName
                TxtContactPhone.Visible = True
                LblContactPhone.Visible = True
                SetDefaultContactPhone()
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                SetDefaultOrganization()
                Me.CallbackPending = -1
                ChkConfirmed.Visible = False
                ChkConfirmed.CheckState = System.Windows.Forms.CheckState.Unchecked
                FraCallout.Visible = False
                'ccarroll 04/15/2010 added callout visibility to form
                _LblCallout_0.Visible = False
                TxtCalloutMins.Visible = False
                _label_1.Visible = False
                TxtCalloutDate.Visible = False

            Case SECONDARY_PENDING
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                TxtContactOrg.Text = "Statline"
                Me.CallbackPending = -1
                ChkConfirmed.Visible = False
                ChkConfirmed.CheckState = System.Windows.Forms.CheckState.Unchecked
                FraCallout.Visible = False
                'ccarroll 04/15/2010 added callout visibility to form
                _LblCallout_0.Visible = False
                TxtCalloutMins.Visible = False
                _label_1.Visible = False
                TxtCalloutDate.Visible = False

            Case PAGE_PENDING, FAX_PENDING, DECLARED_CTOD_PENDING, ORGAN_MED_RO_PENDING
                LblContactName.Visible = True
                CboName.Visible = True
                cmdNameDetail.Visible = True
                UpdateCboNameText((Me.DefaultContactName))
                'TxtContactName.Visible = True
                'TxtContactName.Text = Me.DefaultContactName
                TxtContactPhone.Visible = True
                LblContactPhone.Visible = True
                SetDefaultContactPhone()
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                SetDefaultOrganization()
                Me.CallbackPending = -1
                ChkConfirmed.Visible = False
                ChkConfirmed.CheckState = System.Windows.Forms.CheckState.Unchecked
                FraCallout.Visible = False
                'ccarroll 04/15/2010 added callout visibility to form
                _LblCallout_0.Visible = False
                TxtCalloutMins.Visible = False
                _label_1.Visible = False
                TxtCalloutDate.Visible = False

            Case PAGE_SENT
                LblContactName.Visible = True
                CboName.Visible = True
                cmdNameDetail.Visible = True
                UpdateCboNameText((Me.DefaultContactName))
                'TxtContactName.Visible = True
                'TxtContactName.Text = Me.DefaultContactName
                TxtContactPhone.Visible = True
                LblContactPhone.Visible = True
                SetDefaultContactPhone()
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                SetDefaultOrganization()
                Me.CallbackPending = 0
                ChkConfirmed.Visible = False
                ChkConfirmed.CheckState = System.Windows.Forms.CheckState.Unchecked
                FraCallout.Visible = False
                'ccarroll 04/15/2010 added callout visibility to form
                _LblCallout_0.Visible = False
                TxtCalloutMins.Visible = False
                _label_1.Visible = False
                TxtCalloutDate.Visible = False

            Case PAGE_RESPONSE, ONLINE_REVIEW_RESPONSE, DonorNet_Acceptance, DonorNet_Decline, Labs_Received, No_Labs_Received, DECLARED_CTOD_CONFIRMED, ORGAN_MED_RO_CONFIRMED
                cmdNameDetail.Visible = True
                LblContactName.Visible = True
                CboName.Visible = True
                cmdNameDetail.Visible = True

                'TxtContactName.Visible = True
                'TxtContactName.Text = Me.DefaultContactName
                TxtContactPhone.Visible = False
                LblContactPhone.Visible = False
                TxtContactPhone.Text = ""
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                SetDefaultOrganization()
                Me.CallbackPending = 0
                ChkConfirmed.Visible = True
                FraCallout.Visible = False
                FillCboName()
                UpdateCboNameText((Me.DefaultContactName))
                'ccarroll 04/15/2010 added callout visibility to form
                _LblCallout_0.Visible = False
                TxtCalloutMins.Visible = False
                _label_1.Visible = False
                TxtCalloutDate.Visible = False

            Case CALLBACK_PENDING
                LblContactName.Visible = True
                CboName.Visible = True
                cmdNameDetail.Visible = True
                UpdateCboNameText((Me.DefaultContactName))
                'TxtContactName.Visible = True
                'TxtContactName.Text = Me.DefaultContactName
                TxtContactPhone.Visible = True
                LblContactPhone.Visible = True
                SetDefaultContactPhone()
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                SetDefaultOrganization()
                Me.CallbackPending = -1
                ChkConfirmed.Visible = False
                ChkConfirmed.CheckState = System.Windows.Forms.CheckState.Unchecked
                FraCallout.Visible = True
                LblCallout(0).Visible = False
                LblCallout(1).Visible = True
                'ccarroll 04/15/2010 added callout visibility to form
                Me._LblCallout_0.Visible = True
                Me._label_1.Visible = True
                Me.TxtCalloutMins.Visible = True
                Me.TxtCalloutDate.Visible = True

                'ccarroll 04/15/2010 replaced following tab order
                ' to emulate Old StatTrac
                'CboName.TabIndex = 1
                ''TxtContactName.TabIndex = 1
                'TxtContactOrg.TabIndex = 2
                'TxtContactPhone.TabIndex = 3
                'Me.TxtCalloutMins.TabIndex = 4
                'Me.TxtCalloutDate.TabIndex = 5

                CboName.TabIndex = 8
                TxtContactOrg.TabIndex = 9
                TxtContactPhone.TabIndex = 10
                Me.TxtCalloutMins.TabIndex = 11
                Me.TxtCalloutDate.TabIndex = 12
                Me.TxtContactDesc.TabIndex = 13
                Me.CmdOK.TabIndex = 14
                Me.CmdCancel.TabIndex = 15
                Me.TxtContactDate.TabIndex = 16
                Me.cmdNameDetail.TabIndex = 17

            Case Labs_Pending
                LblContactName.Visible = True
                CboName.Visible = True
                cmdNameDetail.Visible = True
                UpdateCboNameText("")
                'TxtContactName.Visible = True
                'TxtContactName.Text = Me.DefaultContactName
                TxtContactPhone.Visible = True
                LblContactPhone.Visible = True
                TxtContactPhone.Text = ""
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                TxtContactOrg.Text = ""
                Me.CallbackPending = -1
                ChkConfirmed.Visible = False
                ChkConfirmed.CheckState = System.Windows.Forms.CheckState.Unchecked
                FraCallout.Visible = True
                LblCallout(0).Visible = False
                LblCallout(1).Visible = True
                Me._LblCallout_0.Visible = True
                Me._label_1.Visible = True
                Me.TxtCalloutMins.Visible = True
                Me.TxtCalloutDate.Visible = True
                CboName.TabIndex = 1
                'TxtContactName.TabIndex = 1
                TxtContactOrg.TabIndex = 2
                TxtContactPhone.TabIndex = 3
                Me.TxtCalloutMins.TabIndex = 4
                Me.TxtCalloutDate.TabIndex = 5

                'ccarroll  04/28/2011
                'removed EMAIL_RESPONSE wi:12151
                'showing as contact reqired and moved to CASE
            Case EMAIL_PENDING
                LblContactName.Visible = True
                CboName.Visible = True
                cmdNameDetail.Visible = True
                UpdateCboNameText((Me.DefaultContactName))
                TxtContactPhone.Visible = True
                LblContactPhone.Text = "Email"
                LblContactPhone.Visible = True
                TxtContactPhone.Clear()
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                SetDefaultOrganization()
                Me.CallbackPending = -1
                ChkConfirmed.Visible = True
                ChkConfirmed.CheckState = System.Windows.Forms.CheckState.Unchecked
                FraCallout.Visible = False
                'ccarroll 04/15/2010 added callout visibility to form
                _LblCallout_0.Visible = False
                TxtCalloutMins.Visible = False
                _label_1.Visible = False
                TxtCalloutDate.Visible = False

            Case EMAIL_RESPONSE, EMAIL_SENT
                LblContactName.Visible = True
                CboName.Visible = True
                cmdNameDetail.Visible = True
                UpdateCboNameText((Me.DefaultContactName))
                TxtContactPhone.Visible = True
                LblContactPhone.Text = "Email"
                LblContactPhone.Visible = True
                TxtContactPhone.Clear()
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                SetDefaultOrganization()
                Me.CallbackPending = 0
                ChkConfirmed.Visible = True
                ChkConfirmed.CheckState = System.Windows.Forms.CheckState.Unchecked
                FraCallout.Visible = False
                'ccarroll 04/15/2010 added callout visibility to form
                _LblCallout_0.Visible = False
                TxtCalloutMins.Visible = False
                _label_1.Visible = False
                TxtCalloutDate.Visible = False

            Case Incoming_Secondary
                LblContactName.Visible = True
                CboName.Visible = True
                cmdNameDetail.Visible = True
                UpdateCboNameText((Me.DefaultContactName))
                TxtContactPhone.Visible = True
                LblContactPhone.Visible = True
                SetDefaultContactPhone()
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                SetDefaultOrganization()
                Me.CallbackPending = 0
                ChkConfirmed.Visible = False
                ChkConfirmed.CheckState = System.Windows.Forms.CheckState.Unchecked
                FraCallout.Visible = False
                'ccarroll 04/15/2010 added callout visibility to form
                _LblCallout_0.Visible = False
                TxtCalloutMins.Visible = False
                _label_1.Visible = False
                TxtCalloutDate.Visible = False


                ' Added new LogEvent types for v. 8.0.  6/16/05 - T.T
            Case Case_Update 'APPROACH_PENDING, APPROACH_ATTEMPTED_NO_OUTCOME,
                'APPROACH_OUTCOME , SECONDARY_ATTEMPTED_NO_OUTCOME
                LblContactName.Visible = True
                CboName.Visible = True
                cmdNameDetail.Visible = True
                UpdateCboNameText((Me.DefaultContactName))
                'TxtContactName.Visible = True
                'TxtContactName.Text = Me.DefaultContactName
                TxtContactPhone.Visible = False
                LblContactPhone.Visible = False
                TxtContactPhone.Text = ""
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                SetDefaultOrganization()
                Me.CallbackPending = 0
                ChkConfirmed.Visible = False
                ChkConfirmed.CheckState = System.Windows.Forms.CheckState.Unchecked
                FraCallout.Visible = False
                'ccarroll 04/15/2010 added callout visibility to form
                _LblCallout_0.Visible = False
                TxtCalloutMins.Visible = False
                _label_1.Visible = False
                TxtCalloutDate.Visible = False


                'ccarroll 07/30/2008 StatTrac 8.4.6 release
            Case IM_Conversation
                LblContactName.Visible = True
                CboName.Visible = True
                cmdNameDetail.Visible = True
                CboName.SelectedIndex = -1
                'UpdateCboNameText Me.DefaultContactName
                TxtContactPhone.Visible = False
                LblContactPhone.Visible = False
                TxtContactPhone.Text = ""
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                TxtContactOrg.Text = "" 'Me.DefaultOrganization
                Me.CallbackPending = 0
                ChkConfirmed.Visible = False
                ChkConfirmed.CheckState = System.Windows.Forms.CheckState.Unchecked
                FraCallout.Visible = False
                'ccarroll 04/15/2010 added callout visibility to form
                _LblCallout_0.Visible = False
                TxtCalloutMins.Visible = False
                _label_1.Visible = False
                TxtCalloutDate.Visible = False


                'bret 03/12/2009 StatTrac 8.4.8 release
            Case Acknowledge_to_Evaluate ', ONLINE_REVIEW_PENDING
                LblContactName.Visible = True
                CboName.Visible = True
                cmdNameDetail.Visible = True
                CboName.SelectedIndex = -1
                'UpdateCboNameText Me.DefaultContactName
                TxtContactPhone.Visible = True
                LblContactPhone.Visible = True
                TxtContactPhone.Text = ""
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                TxtContactOrg.Text = "" 'Me.DefaultOrganization
                Me.CallbackPending = -1
                ChkConfirmed.Visible = False
                ChkConfirmed.CheckState = System.Windows.Forms.CheckState.Unchecked
                FraCallout.Visible = False
                'ccarroll 04/15/2010 added callout visibility to form
                _LblCallout_0.Visible = False
                TxtCalloutMins.Visible = False
                _label_1.Visible = False
                TxtCalloutDate.Visible = False
            Case EREFERRAL_RESPONSE
                LblContactName.Visible = True
                CboName.Visible = True
                UpdateCboNameText((AppMain.ParentForm.StatEmployeeName))
                TxtContactPhone.Visible = False
                LblContactPhone.Visible = False
                TxtContactPhone.Text = ""
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                TxtContactOrg.Text = "Statline"
                Me.CallbackPending = 0
                ChkConfirmed.Visible = False
                ChkConfirmed.CheckState = System.Windows.Forms.CheckState.Unchecked
                FraCallout.Visible = False
                _LblCallout_0.Visible = False
                TxtCalloutMins.Visible = False
                _label_1.Visible = False
                TxtCalloutDate.Visible = False
            Case Else
                LblContactName.Visible = True
                CboName.Visible = True
                cmdNameDetail.Visible = True
                UpdateCboNameText((Me.DefaultContactName))
                'TxtContactName.Visible = True
                'TxtContactName.Text = Me.DefaultContactName
                TxtContactPhone.Visible = False
                LblContactPhone.Visible = False
                TxtContactPhone.Text = ""
                TxtContactOrg.Visible = True
                LblContactOrg.Visible = True
                SetDefaultOrganization()
                Me.CallbackPending = 0
                ChkConfirmed.Visible = False
                ChkConfirmed.CheckState = System.Windows.Forms.CheckState.Unchecked
                FraCallout.Visible = False
                'ccarroll 04/15/2010 added callout visibility to form
                _LblCallout_0.Visible = False
                TxtCalloutMins.Visible = False
                _label_1.Visible = False
                TxtCalloutDate.Visible = False

        End Select

        'ccarroll 12/09/2008 StatTrac 8.4.7, Capture OriginalContactEventTypeID for Family Approach Billing
        Try
            Me.OriginalContactEventTypeID = modControl.GetID(CboContactEventType)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try


    End Sub
    Private Sub ChkConfirmed_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkConfirmed.CheckStateChanged

        Dim ContactEventTypeId As Integer
        Try
            ContactEventTypeId = modControl.GetID(CboContactEventType)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
            ContactEventTypeId = -1
        End Try

        If ChkConfirmed.CheckState = CheckState.Checked And (ContactEventTypeId = OUTGOING Or ContactEventTypeId = CALLBACK_PENDING) Then
            FraCallout.Visible = False
            'Replace the existing date
            TxtContactDesc.Text = Replace(TxtContactDesc.Text, "Callout after " & Me.OldCalloutDate, "")
        ElseIf ChkConfirmed.CheckState = CheckState.Unchecked And (ContactEventTypeId = OUTGOING Or ContactEventTypeId = CALLBACK_PENDING) Then
            FraCallout.Visible = True
            'Replace the existing date
            TxtContactDesc.Text = Replace(TxtContactDesc.Text, TxtContactDesc.Text, "Callout after " & TxtCalloutDate.Text & " " & TxtContactDesc.Text)
        End If


    End Sub

    Private Sub CmdCancel_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdCancel.Click

        Me.Close()

    End Sub

    'Added: 05/23/01 ttw
    Private Sub cmdNameDetail_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdNameDetail.Click
        Dim inpt As String = ""
        Dim xPos As Integer = Me.Location.X
        Dim yPos As Integer = Me.Location.Y - Me.Height

        If yPos < 0 Then
            yPos = 0
        End If
        inpt = InputBox("Enter person name", "Person Name", XPos:=xPos, YPos:=yPos)

        Me.DefaultContactName = inpt
        CboName.Items.Add((inpt))
        Call modControl.SelectText(CboName, inpt)
    End Sub

    Private Sub CmdOK_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdOK.Click
        '************************************************************************************
        'Name: CmdOK_Click
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Save processes users event create or updae logevents
        '
        '====================================================================================
        'Date Changed: 07/19/07                      Changed by: Bret Knoll
        'Release #: 8.4                              Task: 8.4.3.8 AuditTrail
        'Description:   Changed code to set ContactLogEventID to 0 after saving pending events
        '
        '====================================================================================
        Dim vReturn As String = ""
        Dim Message As New Object
        'Make sure the user wants to save
        vReturn = CStr(modMsgForm.FormSave)

        If vReturn = CStr(MsgBoxResult.Cancel) Then
            Exit Sub
        End If

        'Validate the data
        Dim isValidated As Boolean
        Try
            isValidated = modStatValidate.LogEvent(Me)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
            isValidated = False
        End Try
        If Not isValidated Then
            Exit Sub
        End If


        'T.T 07/10/2007 - disable save if DPS and outgoing call
        If Me.CboContactEventType.Text = "Outgoing Call" Then
            If InStr(1, UCase(TxtContactDesc.Text), "DPS") > 0 Then
                Message = MsgBox("Please change the event type or description of the event to save", MsgBoxStyle.Critical, "Digital Page")
                SetOkEnabled(False)
                Exit Sub
            Else
                SetOkEnabled(True)
            End If

            If InStr(1, UCase(TxtContactDesc.Text), "DIGITAL PAGE SENT") > 0 Then
                Message = MsgBox("Please change the event type or description of the event to save", MsgBoxStyle.Critical, "Digital Page")
                SetOkEnabled(False)
                Exit Sub
            Else
                SetOkEnabled(True)
            End If

            If InStr(1, UCase(TxtContactDesc.Text), "DIGITAL") > 0 Then
                Message = MsgBox("Please change the event type or description of the event to save", MsgBoxStyle.Critical, "Digital Page")
                SetOkEnabled(False)
                Exit Sub
            Else
                SetOkEnabled(True)
            End If
        End If

        'Determine ContactEventTypeId
        Dim ContactEventTypeId As Integer
        Try
            ContactEventTypeId = modControl.GetID(CboContactEventType)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
            ContactEventTypeId = -1
        End Try

        'ccarroll 06/08/06 - Reset the QA review flag to have events appear under Update tab
        'if this is a new record.
        If Me.TxtContactDate.Text = vLogEventDate Then

            If ContactEventTypeId = INCOMING Or ContactEventTypeId = CONSENT_RESPONSE Or ContactEventTypeId = RECOVERY_RESPONSE Or ContactEventTypeId = Case_Update Then
                'Set referralQAReviewComplete flag

                If AppMain.ParentForm.LeaseOrganization = 0 Then
                    vQAResetSwitch = 1 'Allows the referral to show under the Update Tab Statline users
                Else
                    vQAResetSwitch = 2 'Allows the ASP referral to show under the Update Tab for ASP users
                End If

                Try
                    Call modStatSave.UpdateReferralQAComplete(Me)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try
            End If

        End If


        If ContactEventTypeId = CONSENT_RESPONSE Or ContactEventTypeId = RECOVERY_RESPONSE Then
            Call MsgBox("Please update disposition data on the main referral form.", MsgBoxStyle.Exclamation, "Update Disposition")
        End If

        If ContactEventTypeId = SECONDARY_RESPONSE Then
            Call MsgBox("If the patient is medically unsuitable, please update disposition data on the main referral form.", MsgBoxStyle.Exclamation, "Update Disposition")
        End If

        'Update a pending event
        If Me.UpdatePendingEvent = True Then
            'TODO: 05/21 check save function for cboName.text
            Try
                Call modStatSave.SavePendingEvent(Me)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
            '07/19/2007 bret 8.4.3.8 set the LogeventID to zero, the existing event was saved, need to create a new event
            Me.ContactLogEventID = 0
        End If

        'Save the event
        '10/8/01 drh If Outgoing Fax and it's a new record, it will be saved from the Fax form, not here
        If ContactEventTypeId = OUTGOING_FAX Or ContactEventTypeId = Verification_Form_Sent Then
            If FormState <> NEW_RECORD Then
                Try
                    Call modStatSave.SaveLogEvent(Me)
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try
            End If
        Else
            Try
                Call modStatSave.SaveLogEvent(Me)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
        End If

        'ccarroll 06/17/2008 StatTrac 8.4.6
        'Capture Incoming Secondary event
        If vParentForm.Name = "FrmReferralView" Then
            If vParentForm.BillApproachOnly = False Then
                If ContactEventTypeId = Incoming_Secondary Then
                    vParentForm.BillSecondaryFlag = True
                    vParentForm.BillSecondaryComplete = False
                End If
            End If
        End If


        Dim fsResults As New Object
        Dim vRsResult As New ADODB.Recordset
        Dim vQuery As New Object
        Dim vResult As New Object
        Dim fsCase As Short
        Try
            fsCase = modStatQuery.QueryFSCase(Me, fsResults)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try
        If fsCase Then 'Check if FS case
            'ccarroll 05/23/2007 StatTrac 8.4 release
            'Check if Secondary Billable event and set BillSecondaryFlag if True
            If ContactEventTypeId = OUTGOING And vParentForm.Name = "FrmReferralView" Then
                If Me.TxtContactOrg.Text = vParentForm.txtHospitalName.Text And vParentForm.BillSecondaryComplete = False Then
                    'Check last event was Secondary Pending
                    vQuery = "sps_SecondaryAutoBillable " & Me.CallId
                    Try
                        Call modODBC.Exec(vQuery, vResult, , True, vRsResult)
                    Catch ex As Exception
                        StatTracLogger.CreateInstance().Write(ex)
                    End Try
                    If vRsResult.Fields("SPExists").Value = 1 Then
                        vParentForm.BillSecondaryFlag = True
                    End If
                End If
            End If

            'ccarroll 07/30/2008 StatTrac 8.4.6 release
            'Check Family Approach event
            'ccarroll 11/07/2008 StatTrac 8.4.7 release
            'added check for FormState = New_RECORD
            If modControl.GetID(CboContactEventType) = Family_Approached And vParentForm.Name = "FrmReferralView" And (FormState = NEW_RECORD Or Me.FamilyApproachSelected = True) Then
                If vParentForm.BillFamilyApproachManualEnable = False Then
                    Try
                        Call modStatSave.UpdateSecondaryAutoBillFamilyApproach(Me)
                    Catch ex As Exception
                        StatTracLogger.CreateInstance().Write(ex)
                    End Try
                End If
            End If

            '6/29/01 drh If this is a new Log Event
            If FormState = NEW_RECORD Then
                '7/2/01 drh If FS Case or Secondary Pending Event type, execute additional logic
                If TypeOf fsResults Is Array Or ContactLogEventTypeID = SECONDARY_PENDING Then
                    Try
                        Call SaveFSLogEvent(Me, fsResults)
                    Catch ex As Exception
                        StatTracLogger.CreateInstance().Write(ex)
                    End Try
                End If
            End If

        End If




        'Check if an additional callback pending event needs to be created
        If modControl.GetID(CboContactEventType) = OUTGOING And Me.ChkConfirmed.CheckState = System.Windows.Forms.CheckState.Unchecked And Me.TxtCalloutMins.Text <> "" And Me.TxtCalloutDate.Text <> "" Then
            Me.ContactLogEventTypeID = CALLBACK_PENDING
            Me.CallbackPending = -1
            Me.TxtContactDate.Text = CStr(DateAdd(Microsoft.VisualBasic.DateInterval.Minute, 1, CDate(TxtContactDate.Text)))

            'ccarroll 12/09/2008 StatTrac 8.4.7 release
            'Added time zone clarification when ASP. Ref: HS 15832
            Me.TxtContactDesc.Text = "Callout after " & TxtCalloutDate.Text & " " & AppMain.ParentForm.TimeZone & "."
            Try
                Call modStatSave.SaveLogEvent(Me)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try
        End If


        If vParentForm.Name = "FrmReferralView" Then

            'ccarroll 09/20/2007 added folowing condition to Outgoing Fax from FS
            If ContactEventTypeId = OUTGOING_FAX And (vParentForm.cboRegistryStatusFS.Text = "WebRegistry" Or vParentForm.cboRegistryStatusFS.Text = "StateRegistry") Then

                Select Case ContactEventTypeId
                    Case OUTGOING_FAX
                        Dim frmDonorIntentFax As FrmDonorIntentFax = New FrmDonorIntentFax
                        frmDonorIntentFax = New FrmDonorIntentFax
                        frmDonorIntentFax.vParentForm = Me.vParentForm
                        frmDonorIntentFax.OrganizationId = Me.OrganizationId
                        frmDonorIntentFax.Display()
                End Select
            End If
        End If
        '10/8/01 drh
        'Is this a Referral?
        If vParentForm.Name = "FrmReferral" Then
            'Is Donor Intent ON and it's a new record, and it's a Verification_Form_Sent?
            If vParentForm.CallerOrg.ServiceLevel.CheckRegistryMode = CheckRegistryMode.DonorIntent And
                ContactEventTypeId = Verification_Form_Sent And
                FormState = NEW_RECORD Then
                'Is this a Registered Donor and is it appropriate?
                'UPGRADE_ISSUE: Control DonorAppropriate could not be resolved because it was within the generic namespace Form. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="084D22AD-ECB1-400F-B4C7-418ECEC5E36E"'
                'UPGRADE_ISSUE: Control DonorRegistryType could not be resolved because it was within the generic namespace Form. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="084D22AD-ECB1-400F-B4C7-418ECEC5E36E"'
                If vParentForm.DonorSearchState.HasDonor And
                   vParentForm.DonorAppropriate And
                   vParentForm.DonorIntentDone = -1 Then

                    'Set Parent form to FrmReferral so we can get referral data
                    Dim frmDonorIntentFax As FrmDonorIntentFax = New FrmDonorIntentFax
                    frmDonorIntentFax.vParentForm = Me.vParentForm
                    frmDonorIntentFax.OrganizationId = Me.OrganizationId
                    frmDonorIntentFax.Display()
                End If
            End If
        End If


        Me.Saved = True

        Me.Close()

    End Sub

    Private Sub SetDefaultContactPhone()
        If (TxtContactPhone.Text.Length = 0) Then
            TxtContactPhone.Text = Me.DefaultContactPhone
        End If
    End Sub

    Private Sub SetDefaultOrganization()
        If (TxtContactOrg.Text.Length = 0) Then
            TxtContactOrg.Text = Me.DefaultOrganization
        End If
    End Sub

    Private Sub FrmLogEvent_Activated(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Activated
        If Me.FormState = NEW_EVENT Then

            CboContactEventType.Focus()
        End If
    End Sub

    Private Sub FrmLogEvent_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load
        '************************************************************************************
        'Name: Form_Load
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Loads frmLogEvent
        'Returns: Nothing
        'Params: Item As ListItem
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 12/22/04                         Changed by: Scott Plummer
        'Release #: 7.7.2                               Task: 312
        'Description:  Ensure that the chkConfirmed box in unchecked when building a new
        '              Email Response event from an Email Pending one.
        '====================================================================================
        '************************************************************************************

        '04/16/02 bjk do not need to change time
        '12/19/01 bjk for time change
        'Dim vTimeZoneDif%
        'vTimeZoneDif = modStatQuery.QueryTimeZoneDif(AppMain.ParentForm.TimeZone)

        Me.Saved = False

        'Fill reference data
        Try
            Call modStatQuery.QueryLogEventType(Me)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        'Dim vTempAuditLogId As Integer '(Note: Can't pass object properties byRef, so use an intermediate variable)
        If Me.FormState = NEW_EVENT Then

            'Get the date/time
            '04/16/02 bjk do not need to change time
            '12/19/01 bjk added DateAdd
            'Me.ContactLogEventDate = Format(DateAdd("h", vTimeZoneDif, Now), "mm/dd/yy  hh:mm")
            Me.ContactLogEventDate = VB6.Format(Now, "mm/dd/yy  hh:mm")

            TxtContactDate.Text = Me.ContactLogEventDate

            'Default the contact type
            Call modControl.SelectID(CboContactEventType, Me.DefaultContactType)

            'ccarroll 11/30/2010 Added SelectedIndexChange event to establish default LogEvent settings
            'SelectID was not firing event.
            CboContactEventType_SelectedIndexChanged(CboContactEventType, EventArgs.Empty)

            'Default the contact fields
            Call modStatQuery.QueryLocationPerson(Me, Me.DefaultOrganizationID)
            If Me.DefaultContactName <> "" Then
                'Added: 05/25/01 ttw
                'Added: 07/2001 bjk - If statment
                If Me.DefaultContactName = "" Then
                    UpdateCboNameText(AppMain.ParentForm.StatEmployeeName)
                Else
                    UpdateCboNameText((Me.DefaultContactName))
                End If
            End If
            SetDefaultContactPhone()
            SetDefaultOrganization()
            TxtContactDesc.Text = Me.DefaultContactDesc

            Me.ContactEmployeeID = AppMain.ParentForm.StatEmployeeID


        Else

            'Get the selected event
            Try
                Call modStatQuery.QueryLogEvent(Me)
            Catch ex As Exception
                StatTracLogger.CreateInstance().Write(ex)
            End Try



            '10/03/02 drh - Save LogEvent Audit Info
            Me.AuditLogId = 0

            If Me.UpdatePendingEvent = True Then
                'Set the date/time
                '04/16/02 bjk do not need to change date
                '12/19/01 bjk added DateAdd
                'TxtContactDate.Text = Format(DateAdd("h", vTimeZoneDif, Now), "mm/dd/yy  hh:mm")
                TxtContactDate.Text = VB6.Format(Now, "mm/dd/yy  hh:mm")

                'Clear appropriate fields
                TxtContactDesc.Text = ""
                TxtCalloutDate.Text = ""
                TxtCalloutMins.Text = ""

                'Ensure that Email Response events have the Confirmed checkbox unchecked,
                'because they are built from Email Pending, which has the LogEventContactConfirmed
                'value set to 1 by default.  Ver. 7.7.2, 12/22/04 - SAP
                If Me.DefaultContactType = EMAIL_RESPONSE Then
                    Me.ChkConfirmed.CheckState = System.Windows.Forms.CheckState.Unchecked
                End If

                'Set the form state
                Me.FormState = NEW_RECORD
                Me.CallbackPending = 0

                'bjk 4/2/2009 stattrac 8.4.8 replaced code in FillCboName with call to procedure
                Try
                    FillCboName()
                Catch ex As Exception
                    StatTracLogger.CreateInstance().Write(ex)
                End Try

                If Me.DefaultContactType = SECONDARY_RESPONSE Or Me.DefaultContactType = OUTGOING Or (Me.DefaultContactType = CONSENT_RESPONSE And Me.OrganizationId = 194) Then
                    'Added: 05/25/01 ttw - to all case lines below
                    UpdateCboNameText((Me.DefaultContactName))
                    'TxtContactName.Text = AppMain.ParentForm.StatEmployeeName

                    'FSProj drh 7/25/02 - If there's no default specified, use the StatEmployeeName
                    If Me.CboName.Text = "" Then
                        UpdateCboNameText(AppMain.ParentForm.StatEmployeeName)
                    End If
                End If

                'setup ereferral response to default to current statline user
                If Me.DefaultContactType = EREFERRAL_RESPONSE Then
                    UpdateCboNameText((AppMain.ParentForm.StatEmployeeName))
                    TxtContactOrg.Text = "Statline"
                End If

            End If

            End If

        'Set OK initially enabled (but only for supported event types).
        SetOkEnabled(True)

        Me.Text = "Log Event - Call # " & Me.CallNumber

        'Call modUtility.CenterForm()

        'ccarroll 06/16/2006 set contact LogEvent Date/Time
        vLogEventDate = Me.TxtContactDate.Text

        'T.T 05/20/2006 disable when Webservice event
        If VB.Left(Me.TxtContactDesc.Text, 19) = "The Registry search" Then
            CboContactEventType.Enabled = False
            Me.TxtContactDesc.Enabled = False
            SetOkEnabled(False)
            TxtContactDate.Enabled = False
        End If
        If VB.Left(Me.TxtContactDesc.Text, 16) = "Referral deleted" Then
            CboContactEventType.Enabled = False
            Me.TxtContactDesc.Enabled = False
            SetOkEnabled(False)
            TxtContactDate.Enabled = False
        End If

        If Me.TxtContactOrg.Text = "DonorNet" Then
            If Me.CboName.Text = "Import" Then
                SetOkEnabled(False)
            End If
        End If


        If VB.Left(Me.TxtContactDesc.Text, 12) = "Case deleted" Then
            CboContactEventType.Enabled = False
            Me.TxtContactDesc.Enabled = False
            SetOkEnabled(False)
            TxtContactDate.Enabled = False
        End If

        'ccarroll 06/07/2007 StatTrac 8.4 release requirement 3.6
        'ccarroll 01/22/2010 Changed note from TBI to CTDN : Build 8.4.11
        If VB.Left(Me.TxtContactDesc.Text, 16) = "A CTDN number has" Or
        VB.Left(Me.TxtContactDesc.Text, 23) = "The assignment of CTDN #" Or
        VB.Left(Me.TxtContactDesc.Text, 10) = "The CTDN # " Then
            Me.CboContactEventType.Enabled = False
            Me.TxtContactDesc.Enabled = False
            SetOkEnabled(False)
            Me.TxtContactDate.Enabled = False

            Me.TxtContactOrg.Visible = False
            Me.TxtContactPhone.Visible = False
            Me.TxtCalloutDate.Visible = False
            Me.TxtCalloutMins.Visible = False
            Me.CboName.Visible = False
            Me.LblContactName.Visible = False
            Me.LblContactOrg.Visible = False
            Me.LblContactPhone.Visible = False
            Me.cmdNameDetail.Visible = False
        End If


        'ccarroll 06/12/2006 disable QA Review event
        If VB.Left(Me.TxtContactDesc.Text, 26) = "Triage QA Review Completed" Then
            Me.CboContactEventType.Items.Insert(0, "QA Note")
            Me.CboContactEventType.SelectedIndex = 0
            Me.CboContactEventType.Enabled = False
            Me.TxtContactDesc.Enabled = False
            SetOkEnabled(False)
            Me.TxtContactDate.Enabled = False

            Me.TxtContactOrg.Visible = False
            Me.TxtContactPhone.Visible = False
            Me.TxtCalloutDate.Visible = False
            Me.TxtCalloutMins.Visible = False
            Me.CboName.Visible = False
            Me.LblContactName.Visible = False
            Me.LblContactOrg.Visible = False
            Me.LblContactPhone.Visible = False
            Me.cmdNameDetail.Visible = False
        End If

        If Me.FormState = NEW_EVENT Then

            CboContactEventType.Focus()
        Else
            If Me.ContactLogEventTypeID <> OUTGOING_FAX Then
                'If this is an existing event and it's not of
                'an unsupported type then remove the unsupported type 
                'from the list of event types so it's not possible
                'change event type to an unsupported event type.
                Dim outgoingFaxItem = CboContactEventType.Items.
                    Cast(Of ValueDescriptionPair)().
                    FirstOrDefault(Function(p) p.Value = OUTGOING_FAX)
                CboContactEventType.Items.Remove(outgoingFaxItem)
            End If
        End If


    End Sub

    Private Sub SetOkEnabled(enabled As Boolean)
        'Disable editing (saving) existing (historical) 
        'events of unsupported type.
        If enabled And Me.ContactLogEventTypeID = OUTGOING_FAX Then
            Exit Sub
        End If

        Me.CmdOK.Enabled = enabled
    End Sub

    Public Function Display() As Object

        'Dim displayResult As DialogResult = 
        Me.ShowDialog(Me.ParentForm)

        Display = Me.LogEventID
    End Function

    Private Sub FrmLogEvent_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing

        Dim vReturn As Short

        If Me.Saved = True Or CmdCancel.Text = "&Close" Then
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



    Private Sub TxtCalloutDate_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtCalloutDate.Enter

        Me.OldCalloutDate = TxtCalloutDate.Text

        Call modControl.HighlightText(ActiveControl)

    End Sub

    Private Sub TxtCalloutDate_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtCalloutDate.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        KeyAscii = modMask.DateTimeMask(KeyAscii, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtCalloutDate_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles TxtCalloutDate.Validating
        Dim Cancel As Boolean = eventArgs.Cancel

        Dim MsgResponse As Short

        If Me.OldCalloutDate <> TxtCalloutDate.Text And TxtCalloutDate.Text <> "" Then

            'Check if valid date
            If Not IsDate(TxtCalloutDate.Text) Or Len(TxtCalloutDate.Text) < 15 Then
                Call MsgBox("Date is not valid.", MsgBoxStyle.Exclamation, "Validation Error")
                TxtCalloutDate.Focus()
                Cancel = True
                eventArgs.Cancel = Cancel
            End If

            'Check if the date/time is before now
            If DateDiff(Microsoft.VisualBasic.DateInterval.Minute, Now, CDate(TxtCalloutDate.Text)) < 0 Then
                Call MsgBox("Date/time is before now.", MsgBoxStyle.Exclamation, "Validation Error")
                TxtCalloutDate.Focus()
                Cancel = True
                eventArgs.Cancel = Cancel
            End If

            'Warn if date/time is greater than one day
            If DateDiff(Microsoft.VisualBasic.DateInterval.Day, Now, CDate(TxtCalloutDate.Text)) > 1 Then

                MsgResponse = MsgBox("You have set a callout greater than a 1 day from now. Is this correct?", MsgBoxStyle.Exclamation + MsgBoxStyle.DefaultButton2 + MsgBoxStyle.YesNo, "Validation Error")

                If MsgResponse = MsgBoxResult.No Then
                    TxtCalloutDate.Focus()
                    Cancel = True
                    eventArgs.Cancel = Cancel
                End If

            End If

            'TxtCalloutMins.Text = CStr(DateDiff(Microsoft.VisualBasic.DateInterval.Minute, Now, CDate(TxtCalloutDate.Text)))

            ' ccarroll 11/1/2010 (8202)Changed CDate to CLng due to DateDiff returning a long value.
            ' ccarroll 11/5/2010 (8259) (1)changed CLng back to Cdate (2)added If statement for performance
            ' (3) added formatting to Now (minute) was returning hh:mm:nn causing minute calculation to be off by one
            If TxtCalloutMins.Focused = False Then
                TxtCalloutMins.Text = CStr(DateDiff(Microsoft.VisualBasic.DateInterval.Minute, CDate(VB6.Format(Now, "mm/dd/yy  hh:mm")), CDate(TxtCalloutDate.Text)))
            End If


            If TxtContactDesc.Text = "" Then
                'ccarroll 12/09/2008 StatTrac 8.4.7 release
                'Added time zone clarification when ASP. Ref: HS 15832
                TxtContactDesc.Text = "Callout after " & TxtCalloutDate.Text & " " & AppMain.ParentForm.TimeZone & "."
            Else
                'Replace the existing date
                TxtContactDesc.Text = Replace(TxtContactDesc.Text, Me.OldCalloutDate, TxtCalloutDate.Text)

            End If
        End If
    End Sub

    Private Sub TxtCalloutMins_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtCalloutMins.Enter

        Me.OldCalloutMins = TxtCalloutMins.Text

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtCalloutMins_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtCalloutMins.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        KeyAscii = modMask.NumMask(KeyAscii, 5, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtCalloutMins_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles TxtCalloutMins.Validating
        Dim Cancel As Boolean = eventArgs.Cancel

        If TxtCalloutMins.Text <> Me.OldCalloutMins And Not String.IsNullOrEmpty(TxtCalloutMins.Text) Then

            TxtCalloutDate.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Minute, CDbl(TxtCalloutMins.Text), Now), "mm/dd/yy  hh:nn")
            Call TxtCalloutDate_Validating(TxtCalloutDate, New System.ComponentModel.CancelEventArgs(False))

        End If


        eventArgs.Cancel = Cancel
    End Sub


    Private Sub TxtContactDate_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtContactDate.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtContactDate_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtContactDate.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        KeyAscii = modMask.DateTimeMask(KeyAscii, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtContactDate_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles TxtContactDate.Validating
        Dim Cancel As Boolean = eventArgs.Cancel

        If Not IsDate(TxtContactDate.Text) Or Len(TxtContactDate.Text) < 15 Then
            Call MsgBox("Date is not valid.", MsgBoxStyle.Exclamation, "Validation Error")
            Cancel = True
        Else
            Me.ContactLogEventDate = TxtContactDate.Text
        End If

        eventArgs.Cancel = Cancel
    End Sub


    Private Sub TxtContactDesc_KeyDown(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles TxtContactDesc.KeyDown
        Dim KeyCode As Short = eventArgs.KeyCode
        Dim Shift As Short = eventArgs.KeyData \ &H10000

        If Shift = 2 Then
            KeyCode = IIf(KeyCode = System.Windows.Forms.Keys.Tab, 0, KeyCode)
        End If

    End Sub

    Private Sub TxtContactDesc_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtContactDesc.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        Try
            Call modStatQuery.QueryKeyCodePhrase(TxtContactDesc, KeyAscii)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtContactDesc_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtContactDesc.Leave
        '************************************************************************************
        'Name: TxtContactDesc_LostFocus()
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Lostfocus for TxtContact Desc
        'Returns: Nothing
        'Params: Item As ListItem
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 06/10/2007                        Changed by: Thien Ta
        'Release #: 8.4                              Task: req 3.1, 3.1.2, 3.1.3, 3.1.4
        'Description:  added code to search for DPS
        '====================================================================================
        Dim Message As New Object
        Try
            Call modStatValidate.ValidateSpelling(TxtContactDesc)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        SetOkEnabled(True)
        'T.T 05/30/2007 check Description for DPS 8.4 req 3.1
        If Me.CboContactEventType.Text = "Outgoing Call" Then
            If InStr(1, UCase(TxtContactDesc.Text), "DPS") > 0 Then
                Message = MsgBox("Please change the event type or description of the event to save", MsgBoxStyle.Critical, "Digital Page")
                SetOkEnabled(False)
                Exit Sub
            Else
                SetOkEnabled(True)
            End If

            If InStr(1, UCase(TxtContactDesc.Text), "DIGITAL PAGE SENT") > 0 Then
                Message = MsgBox("Please change the event type or description of the event to save", MsgBoxStyle.Critical, "Digital Page")
                SetOkEnabled(False)
                Exit Sub
            Else
                SetOkEnabled(True)
            End If

            If InStr(1, UCase(TxtContactDesc.Text), "DIGITAL") > 0 Then
                Message = MsgBox("Please change the event type or description of the event to save", MsgBoxStyle.Critical, "Digital Page")
                SetOkEnabled(False)
                Exit Sub
            Else
                SetOkEnabled(True)
            End If
        End If



    End Sub


    Private Sub TxtContactName_GotFocus()

        Call modControl.HighlightText(ActiveControl)

    End Sub

    Private Sub TxtContactOrg_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtContactOrg.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub

    Private Sub TxtContactPhone_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtContactPhone.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub

    Private Sub FillCboName()
        '************************************************************************************
        'Name: FillCboName
        'Date Created: 4/2/2009                          Created by: Bret Knoll
        'Release: StatTrac8.4.8                          Task:TS 3293
        'Description: Build the LogEvent Person List and set the current
        'Returns: Nothing
        'Stored Procedures: None
        '************************************************************************************
        'Added: 05/21/01 ttw
        'Set default and populate CBO
        Try
            Call modStatQuery.QueryLocationPerson(Me)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        'bjk 03/31/09
        'if person id = 0 then set the person by name
        If Me.PersonID = 0 Then
            UpdateCboNameText((Me.DefaultContactName))
        Else
            Call modControl.SelectID(CboName, Me.PersonID)
        End If

    End Sub
    Private Sub TxtContactPhone_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtContactPhone.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)
        '************************************************************************************
        'Name: TxtContactPhone_KeyPress
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Applies the Phone mask to phone numbers entered
        'Returns: Nothing
        'Params: Item As ListItem
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 12/14/04                         Changed by: Scott Plummer
        'Release #: 7.7.2                               Task: 312
        'Description:  Enabled free text entry of email address in case of Email Event type.
        '====================================================================================66
        '************************************************************************************

        'Determine ContactEventTypeId
        Dim ContactEventTypeId As Integer
        Try
            ContactEventTypeId = modControl.GetID(CboContactEventType)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
            ContactEventTypeId = -1
        End Try

        ' In case of an Email event type, allow entry of an email address here. Ver. 7.7.2, 12/14/04 - SAP
        If CboContactEventType.SelectedIndex > -1 Then
            If ContactEventTypeId <> EMAIL_PENDING And ContactEventTypeId <> EMAIL_RESPONSE And ContactEventTypeId <> EMAIL_SENT Then
                KeyAscii = modMask.PhoneMask(KeyAscii, ActiveControl)
            End If
        Else
            KeyAscii = modMask.PhoneMask(KeyAscii, ActiveControl)
        End If

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Public Property ContactLogEventDate() As Object
        Get

            ContactLogEventDate = VB6.Format(fvContactLogEventDate, "mm/dd/yy  hh:mm:ss")

        End Get
        Set(ByVal Value As Object)

            fvContactLogEventDate = CDate(VB6.Format(Value, "mm/dd/yy  hh:mm:ss"))

        End Set
    End Property

    Private Sub CboName_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles CboName.SelectedIndexChanged

    End Sub

    Private Sub TxtContactPhone_MouseClick(ByVal sender As System.Object, ByVal e As System.Windows.Forms.MouseEventArgs) Handles TxtContactPhone.MouseClick

        'ccarroll 11/10/2010  wi:8330
        'ccarroll 11/30/2010  wi:8455 - added active control focus
        ActiveControl = Me.TxtContactPhone
        Call modControl.HighlightText(ActiveControl)
    End Sub

    Private Sub TxtContactOrg_MouseClick(ByVal sender As System.Object, ByVal e As System.Windows.Forms.MouseEventArgs) Handles TxtContactOrg.MouseClick
        'ccarroll 11/10/2010  wi:8330
        'ccarroll 11/30/2010  wi:8455 - added active control focus
        ActiveControl = Me.TxtContactOrg
        Call modControl.HighlightText(ActiveControl)
    End Sub

    Private Sub FrmLogEvent_Shown(sender As Object, e As EventArgs) Handles MyBase.Shown
        Me.BringToFront()
    End Sub
End Class