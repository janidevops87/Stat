Public Class wfLogEvent
    Inherits System.Web.UI.Page

    'Public PassedForm As Form

    '10/8/01 drh
    'Public vParentForm As Form

    Public Property FormState%()
        Get
            FormState = AppMain.mainstate.FormState
        End Get
        Set(ByVal vNewValue%)
            AppMain.mainstate.FormState = CStr(vNewValue)
        End Set
    End Property
    Public Property CallId&()
        Get
            CallId = AppMain.mainstate.CallID
        End Get
        Set(ByVal vNewValue&)
            AppMain.mainstate.CallID = CStr(vNewValue)
        End Set
    End Property
    Public Property CallNumber$()
        Get
            CallNumber = AppMain.mainstate.CallNumber
        End Get
        Set(ByVal vNewValue$)
            AppMain.mainstate.CallNumber = vNewValue
        End Set
    End Property

    Public Property LogEventID&()
        Get
            LogEventID = AppMain.mainstate.LogEventID
        End Get
        Set(ByVal vNewValue&)
            AppMain.mainstate.LogEventID = CStr(vNewValue)
        End Set
    End Property
    Public Property LogEventTypeID&()
        Get
            LogEventTypeID = AppMain.mainstate.LogEventID
        End Get
        Set(ByVal vNewValue&)
            AppMain.mainstate.LogEventID = CStr(vNewValue)
        End Set
    End Property
    Public Property CallbackPending%()
        Get
            CallbackPending = AppMain.mainstate.CallbackPending
        End Get
        Set(ByVal vNewValue%)
            AppMain.mainstate.CallbackPending = CStr(vNewValue)
        End Set
    End Property
    Public Property LogEventTypeList()
        Get
            LogEventTypeList = AppMain.mainstate.LogEventTypeList
        End Get
        Set(ByVal vNewValue)
            AppMain.mainstate.LogEventTypeList = vNewValue
        End Set
    End Property

    Public Property ContactLogEventID&()
        Get
            ContactLogEventID = AppMain.mainstate.ContactLogEventID
        End Get
        Set(ByVal vNewValue&)
            AppMain.mainstate.ContactLogEventID = CStr(vNewValue)
        End Set
    End Property
    Public Property ContactLogEventTypeID&()
        Get
            ContactLogEventTypeID = AppMain.mainstate.ContactLogEventTypeID
        End Get
        Set(ByVal vNewValue&)
            AppMain.mainstate.ContactLogEventTypeID = CStr(vNewValue)
        End Set
    End Property
    Public fvContactLogEventDate As Date
    Public Property DefaultContactName$()
        Get
            DefaultContactName = AppMain.mainstate.DefaultContactName
        End Get
        Set(ByVal vNewValue$)
            AppMain.mainstate.DefaultContactName = vNewValue
        End Set
    End Property
    Public Property DefaultContactPhone$()
        Get
            DefaultContactPhone = AppMain.mainstate.DefaultcontactPhone
        End Get
        Set(ByVal vNewValue$)
            AppMain.mainstate.DefaultcontactPhone = vNewValue
        End Set
    End Property
    Public Property DefaultOrganization$()
        Get
            DefaultOrganization = AppMain.mainstate.DefaultOrganization
        End Get
        Set(ByVal vNewValue$)
            AppMain.mainstate.DefaultOrganization = vNewValue
        End Set
    End Property
    Public Property DefaultOrganizationID%()
        Get
            DefaultOrganizationID = AppMain.mainstate.DefaultOrganizationID
        End Get
        Set(ByVal vNewValue%)
            AppMain.mainstate.DefaultOrganizationID = CStr(vNewValue)
        End Set
    End Property
    Public Property DefaultContactType%()
        Get
            DefaultContactType = AppMain.mainstate.DefaultContactType
        End Get
        Set(ByVal vNewValue%)
            AppMain.mainstate.DefaultContactType = CStr(vNewValue)
        End Set
    End Property
    Public Property DefaultContactDesc$()
        Get
            DefaultContactDesc = AppMain.mainstate.DefaultContactDesc
        End Get
        Set(ByVal vNewValue$)
            AppMain.mainstate.DefaultContactDesc = vNewValue
        End Set
    End Property
    Public Property ContactEmployeeID&()
        Get
            ContactEmployeeID = AppMain.mainstate.ContactEmployeeID
        End Get
        Set(ByVal vNewValue&)
            AppMain.mainstate.ContactEmployeeID = CStr(vNewValue)
        End Set
    End Property

    Public Property Saved%()
        Get
            Saved = AppMain.mainstate.Saved
        End Get
        Set(ByVal vNewValue%)
            AppMain.mainstate.Saved = CStr(vNewValue)
        End Set
    End Property
    Public Property UpdatePendingEvent() As Boolean
        Get
            UpdatePendingEvent = AppMain.mainstate.UpdatePendingEvent
        End Get
        Set(ByVal vNewValue As Boolean)
            AppMain.mainstate.UpdatePendingEvent = CStr(vNewValue)
        End Set
    End Property
    Public Property FormLoad%()
        Get
            FormLoad = AppMain.mainstate.FormLoad
        End Get
        Set(ByVal vNewValue%)
            AppMain.mainstate.FormLoad = CStr(vNewValue)
        End Set
    End Property

    Public Property OrganizationId&()
        Get
            OrganizationId = AppMain.mainstate.OrganizationID
        End Get
        Set(ByVal vNewValue&)
            AppMain.mainstate.OrganizationID = CStr(vNewValue)
        End Set
    End Property
    Public Property OrganizationName$()
        Get
            OrganizationName = AppMain.mainstate.OrganizationName
        End Get
        Set(ByVal vNewValue$)
            AppMain.mainstate.OrganizationName = vNewValue
        End Set
    End Property
    Public Property ScheduleGroupID&()
        Get
            ScheduleGroupID = AppMain.mainstate.ScheduleGroupID
        End Get
        Set(ByVal vNewValue&)
            AppMain.mainstate.ScheduleGroupID = CStr(vNewValue)
        End Set
    End Property
    Public Property PersonID&()
        Get
            PersonID = AppMain.mainstate.PersonID
        End Get
        Set(ByVal vNewValue&)
            AppMain.mainstate.PersonID = CStr(vNewValue)
        End Set
    End Property
    Public Property PhoneID&()
        Get
            PhoneID = AppMain.mainstate.PhoneID
        End Get
        Set(ByVal vNewValue&)
            AppMain.mainstate.PhoneID = CStr(vNewValue)
        End Set
    End Property

    Public Property ContactLogEventDate() As String
        Get
            '03/03/03 drh - LangDiff: Note capital "MM"'s for month in .NET
            ContactLogEventDate = Format(fvContactLogEventDate, "MM/dd/yy  HH:mm")
        End Get
        Set(ByVal vNewValue As String)
            Dim vTest
            vTest = IsDate(vNewValue)
            If IsDate(vNewValue) Then
                fvContactLogEventDate = vNewValue
            End If
        End Set
    End Property
    Public Property OldCalloutMins() As String
        Get
            OldCalloutMins = AppMain.mainstate.OldCalloutMins
            'Session("OldCalloutDate") = AppMain.mainstate.OldCalloutMins
        End Get
        Set(ByVal vNewValue As String)
            AppMain.mainstate.OldCalloutMins = vNewValue
            'Session("OldCalloutDate") = AppMain.mainstate.OldCalloutMins
        End Set
    End Property
    Public Property OldCalloutDate() As String
        Get
            OldCalloutDate = AppMain.mainstate.OldCalloutDate
            'Session("OldCalloutMins") = AppMain.mainstate.OldCalloutDate
        End Get
        Set(ByVal vNewValue As String)
            AppMain.mainstate.OldCalloutDate = vNewValue
            'Session("OldCalloutMins") = AppMain.mainstate.OldCalloutDate
        End Set
    End Property

    Public Property WebUserOrganizationTimeZone$()
        Get
            WebUserOrganizationTimeZone = AppMain.mainstate.WebUserOrganizationTimeZone
        End Get
        Set(ByVal vNewValue$)
            AppMain.mainstate.WebUserOrganizationTimeZone = vNewValue
        End Set
    End Property
    Public Property WebUserOrganizationTimeZoneDiff%()
        Get
            WebUserOrganizationTimeZoneDiff = AppMain.mainstate.WebUserOrganizationTimeZoneDiff
        End Get
        Set(ByVal vNewValue%)
            AppMain.mainstate.WebUserOrganizationTimeZoneDiff = CStr(vNewValue)
        End Set
    End Property


    '10/03/02 drh
    Public AuditLogId&
    Protected Friend WithEvents cmdOK As System.Web.UI.WebControls.Button
    Protected Friend WithEvents cmdCancel As System.Web.UI.WebControls.Button
    Protected Friend WithEvents txtContactDesc As System.Web.UI.WebControls.TextBox
    Protected Friend WithEvents txtContactPhone As System.Web.UI.WebControls.TextBox
    Protected Friend WithEvents lblContactPhone As System.Web.UI.WebControls.Label
    Protected Friend WithEvents txtContactOrg As System.Web.UI.WebControls.TextBox
    Protected Friend WithEvents lblContactOrg As System.Web.UI.WebControls.Label
    Protected Friend WithEvents cboName As System.Web.UI.WebControls.DropDownList
    Protected Friend WithEvents lblContactName As System.Web.UI.WebControls.Label
    Protected Friend WithEvents cboContactEventType As System.Web.UI.WebControls.DropDownList
    Protected Friend WithEvents lblEventType As System.Web.UI.WebControls.Label
    Protected Friend WithEvents txtContactDate As System.Web.UI.WebControls.TextBox
    Protected Friend WithEvents Label2 As System.Web.UI.WebControls.Label
    Protected Friend WithEvents txtCalloutDate As System.Web.UI.WebControls.TextBox
    Protected Friend WithEvents txtCalloutMins As System.Web.UI.WebControls.TextBox

    'Public WithEvents Panel2 As System.Web.UI.WebControls.Panel
    Public WithEvents CustomValidator1 As System.Web.UI.WebControls.CustomValidator
    Protected Friend WithEvents cmdValidationMsg As System.Web.UI.WebControls.Button
    Protected WithEvents Label3 As System.Web.UI.WebControls.Label
    Protected WithEvents txtOtherName As System.Web.UI.WebControls.TextBox
    Protected WithEvents pnlOtherName As System.Web.UI.WebControls.Panel
    Protected WithEvents cmdOtherName As System.Web.UI.WebControls.Button
    Protected WithEvents Label4 As System.Web.UI.WebControls.Label
    Protected WithEvents Label6 As System.Web.UI.WebControls.Label
    Protected WithEvents spacer9 As System.Web.UI.WebControls.Label
    Protected WithEvents spacer3 As System.Web.UI.WebControls.Label
    Protected WithEvents spacer4 As System.Web.UI.WebControls.Label
    Protected WithEvents cmdOtherNameCancel As System.Web.UI.WebControls.Button
    Protected WithEvents lblCalloutUnits As System.Web.UI.WebControls.Label
    Protected WithEvents lblCallout As System.Web.UI.WebControls.Label
    Protected Friend WithEvents cboKeyCode As System.Web.UI.WebControls.DropDownList
    Protected WithEvents Label1 As System.Web.UI.WebControls.Label
    Protected Friend WithEvents chkConfirmed As System.Web.UI.WebControls.CheckBox

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()

        Call SetClientEventHandlers()

        'me.vParentForm = Me

    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        If context.Items.Item("LogEventID") <> "" Then
            AppMain.mainstate.CallID = context.Items.Item("LogEventID")
        End If
        If context.Items.Item("WebUserID") <> "" Then
            AppMain.mainstate.WebUserID = context.Items.Item("WebUserID")
        End If
        If context.Items.Item("WebUserOrgID") <> "" Then
            AppMain.mainstate.WebUserOrganizationID = context.Items.Item("WebUserOrgID")
        End If


        'Me.CallId = AppMain.mainstate.CallID
        '02/28/03 drh - If it's a postback, no process is necessary here
        If Page.IsPostBack Then
            'Clear validation message
            PopValidationMessage("", "")
            Exit Sub
        End If

        'Set properties for CSS pop-up form
        Call setPopupProperties()

        'Set control properties
        Call setControlProperties()

        Dim vParams$()
        Dim inpt As String

        Me.Saved = False

        'Fill reference data
        Dim vresults1 As DataSet
        Call modStatQuery.QueryKeyCodes(Me, vresults1)
        ctlVisible(cboKeyCode, False)

        'Fill reference data
        Dim vresults As DataSet
        Call modStatQuery.QueryLogEventType(Me, vresults)

        If Me.FormState = NEW_EVENT Then

            'Get the date/time
            '04/16/02 bjk do not need to change time
            '12/19/01 bjk added DateAdd
            Me.ContactLogEventDate = DateAdd("h", Me.WebUserOrganizationTimeZoneDiff, Now)
            txtContactDate.Text = Me.ContactLogEventDate

            'Default the contact type
            Call modControl.SelectID(cboContactEventType, Me.DefaultContactType)

            '04/08/03 drh - Added because there's no click event for cboContactEventType
            If modControl.GetID(cboContactEventType) <> -1 Then
                Call updateFormControlState()
            End If

            'Default the contact fields
            Call modStatQuery.QueryLocationPerson(Me, AppMain.mainstate.DefaultOrganizationID)
            If Me.DefaultContactName <> "" Then
                'Added: 05/25/01 ttw
                'Added: 07/2001 bjk - If statment
                If Me.DefaultContactName = "" Then
                    UpdateCboNameText(AppMain.mainstate.StatEmployeeName)
                Else
                    UpdateCboNameText(AppMain.mainstate.DefaultContactName)
                End If
            End If
            'TxtContactName.Text = Me.DefaultContactName
            txtContactPhone.Text = Me.DefaultContactPhone
            txtContactOrg.Text = Me.DefaultOrganization
            txtContactDesc.Text = ""

            Me.ContactEmployeeID = AppMain.mainstate.StatEmployeeId

        Else

            'Get the selected event info
            Dim vDataSet As DataSet

            Call modStatQuery.QueryLogEvent(Me, vDataSet)

            'Set the event data
            Dim vTable As DataTable
            Dim vRow As DataRow

            If vDataSet.Tables.Count > 0 Then
                vTable = vDataSet.Tables(0)

                If vTable.Rows.Count > 0 Then
                    vRow = vTable.Rows(0)

                    'Set the event data
                    Me.ContactLogEventID = DBNullToLng(vRow(vTable.Columns(0)))
                    Me.ContactLogEventDate = DBNullToText(vRow(vTable.Columns(1)))
                    Me.txtContactDate.Text = Me.ContactLogEventDate

                    If Me.UpdatePendingEvent = False Then
                        Me.DefaultContactType = DBNullToLng(vRow(vTable.Columns(2)))
                    End If

                    Me.ContactLogEventTypeID = Me.DefaultContactType
                    Call modControl.SelectID(Me.cboContactEventType, Me.ContactLogEventTypeID)

                    '04/08/03 drh - Added because there's no click event for cboContactEventType
                    If modControl.GetID(cboContactEventType) <> -1 Then
                        Call updateFormControlState()
                    End If

                    Me.DefaultContactName = DBNullToText(vRow(vTable.Columns(3)))
                    'changed text to cbo

                    'load Location People and page pending person and sets text
                    Call modStatQuery.QueryLocationPerson(Me)

                    'TODO: Check to if pending page person is in location list.
                    Me.cboName.Items.Add(Me.DefaultContactName)
                    Call modControl.SelectText(Me.cboName, Me.DefaultContactName)

                    Me.DefaultContactPhone = DBNullToText(vRow(vTable.Columns(4)))
                    Me.txtContactPhone.Text = Me.DefaultContactPhone
                    Me.DefaultOrganization = DBNullToText(vRow(vTable.Columns(5)))
                    Me.txtContactOrg.Text = Me.DefaultOrganization
                    Me.txtContactDesc.Text = DBNullToText(vRow(vTable.Columns(6)))
                    If Me.UpdatePendingEvent = False Then
                        Me.ContactEmployeeID = DBNullToLng(vRow(vTable.Columns(7)))
                    Else
                        Me.ContactEmployeeID = AppMain.mainstate.StatEmployeeId
                    End If

                    Me.CallbackPending = DBNullToLng(vRow(vTable.Columns(8)))

                    Me.OrganizationId = DBNullToLng(vRow(vTable.Columns(9)))
                    Me.ScheduleGroupID = DBNullToLng(vRow(vTable.Columns(10)))
                    Me.PersonID = DBNullToLng(vRow(vTable.Columns(11)))
                    Me.PhoneID = DBNullToLng(vRow(vTable.Columns(12)))
                    If DBNullToLng(vRow(vTable.Columns(13))) = -1 Then
                        Me.chkConfirmed.Checked = System.Windows.Forms.CheckState.Checked
                    Else
                        Me.chkConfirmed.Checked = System.Windows.Forms.CheckState.Unchecked
                    End If

                    If DBNullToText(vRow(vTable.Columns(14))) <> "" Then
                        Me.txtCalloutDate.Text = Format(CDate(DBNullToText(vRow(vTable.Columns(14)))), "MM/dd/yy  HH:mm")
                        Me.txtCalloutMins.Text = DateDiff("n", Me.txtContactDate.Text, Me.txtCalloutDate.Text)
                    End If
                End If
            End If

            '10/03/02 drh - Save LogEvent Audit Info
            'Dim vTempAuditLogId& '(Note: Can't pass object properties byRef, so use an intermediate variable)
            'Call modStatAudit.AuditLogEventSave(Me.LogEventID, Me.CallId, AUDIT_UNKNOWN, vTempAuditLogId)
            'Me.AuditLogId = vTempAuditLogId

            If Me.UpdatePendingEvent = True Then
                'Set the date/time
                '04/16/02 bjk do not need to change date
                '12/19/01 bjk added DateAdd
                'TxtContactDate.Text = Format(DateAdd("h", vTimeZoneDif, Now), "mm/dd/yy  hh:mm")
                txtContactDate.Text = Format(DateAdd("h", Me.WebUserOrganizationTimeZoneDiff, Now), "MM/dd/yy  HH:mm")

                'Clear appropriate fields
                txtContactDesc.Text = ""
                txtCalloutDate.Text = ""
                txtCalloutMins.Text = ""

                'Set the form state
                Me.FormState = NEW_RECORD
                Me.CallbackPending = 0

                'Added: 05/21/01 ttw
                'Set default and populate CBO
                Call modStatQuery.QueryLocationPerson(Me)
                Call modControl.SelectID(cboName, Me.PersonID)

                If Me.DefaultContactType = SECONDARY_RESPONSE _
                Or Me.DefaultContactType = OUTGOING _
                Or (Me.DefaultContactType = CONSENT_RESPONSE And Me.OrganizationId = 194) Then
                    'Added: 05/25/01 ttw - to all case lines below
                    UpdateCboNameText(Me.DefaultContactName)
                    'TxtContactName.Text = ParentForm.StatEmployeeName

                    'FSProj drh 7/25/02 - If there's no default specified, use the StatEmployeeName
                    If Me.cboName.SelectedItem.Text = "" Then
                        UpdateCboNameText(AppMain.mainstate.StatEmployeeName)
                    End If
                End If


            End If

        End If

    End Sub

    Private Sub cmdOK_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdOK.Click
        '03/26/03 drh - Moved here from StatTrac's txtContactDate event handlers since validation is now done on the client
        Me.OldCalloutMins = Page.Request.Form("OldCalloutMins") ' from txtContactDate_GotFocus
        Me.ContactLogEventDate = txtContactDate.Text       ' from txtContactDate_Validate


        Dim vReturn$

        '03/24/03 drh - Add client-side code???
        'Make sure the user wants to save
        'vReturn = modMsgForm.FormSave

        If vReturn = vbCancel Then
            Exit Sub
        End If

        'Validate the data
        If Not modStatValidate.LogEvent(Me) Then
            Exit Sub
        End If

        'Update a pending event
        If Me.UpdatePendingEvent = True Then
            'TODO: 05/21 check save function for cboName.text
            Call modStatSave.SavePendingEvent(Me)
        End If

        'Save the event
        '10/8/01 drh If Outgoing Fax and it's a new record, it will be saved from the Fax form, not here
        If modControl.GetID(cboContactEventType) = OUTGOING_FAX Then
            If FormState <> NEW_RECORD Then
                Call modStatSave.SaveLogEvent(Me)
            End If
        Else
            Call modStatSave.SaveLogEvent(Me)
        End If


        'Check if an additional callback pending event needs to be created
        If modControl.GetID(cboContactEventType) = OUTGOING And _
           Me.chkConfirmed.Checked = False And Me.txtCalloutMins.Text <> "" And _
           Me.txtCalloutDate.Text <> "" Then
            Me.ContactLogEventTypeID = CALLBACK_PENDING
            Me.CallbackPending = -1
            Me.txtContactDate.Text = DateAdd("n", 1, txtContactDate.Text)
            Me.txtContactDesc.Text = "Callout after " & txtCalloutDate.Text & "."
            Call modStatSave.SaveLogEvent(Me)
        End If

        Me.Saved = True
        context.Items.Add("LogEventID", AppMain.mainstate.CallID)
        context.Items.Add("WebUserID", AppMain.mainstate.WebUserID)
        context.Items.Add("WebUserOrgID", AppMain.mainstate.WebUserOrganizationID)
        Server.Transfer("FrmLogEventList.aspx", True)
    End Sub

    Private Sub cboContactEventType_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cboContactEventType.SelectedIndexChanged
        Call updateFormControlState()
    End Sub

    Private Sub updateFormControlState()
        '03/06/03 drh - CODE FROM STATTRAC CLICK/CHANGE EVENTS
        'Set event type
        Me.ContactLogEventTypeID = modControl.GetID(cboContactEventType)

        Call modControl.RemoveID(cboContactEventType, -1)

        Select Case Me.ContactLogEventTypeID
            Case GENERAL
                ctlVisible(lblContactName, False)
                ctlVisible(cboName, False)

                'Added: 05/25/01 ttw - to all case lines below
                'UpdateCboNameText Me.DefaultContactName
                'TxtContactName.Visible = False
                'TxtContactName.Text = ""

                'Added: 06/26/01 bjk for notes
                'cboName.Items.Clear()

                ctlVisible(txtContactPhone, False)
                ctlVisible(lblContactPhone, False)
                txtContactPhone.Text = ""
                ctlVisible(txtContactOrg, False)
                ctlVisible(lblContactOrg, False)
                txtContactOrg.Text = ""
                Me.CallbackPending = 0
                ctlVisible(chkConfirmed, False)
                chkConfirmed.Checked = System.Windows.Forms.CheckState.Unchecked
                FraCallout_Visible(False)
            Case INCOMING
                ctlVisible(lblContactName, True)
                ctlVisible(cboName, True)
                UpdateCboNameText(Me.DefaultContactName)
                'TxtContactName.Visible = True
                'TxtContactName.Text = Me.DefaultContactName
                ctlVisible(txtContactPhone, False)
                ctlVisible(lblContactPhone, False)
                txtContactPhone.Text = ""
                ctlVisible(txtContactOrg, True)
                ctlVisible(lblContactOrg, True)
                txtContactOrg.Text = Me.DefaultOrganization
                Me.CallbackPending = 0
                ctlVisible(chkConfirmed, True)
                FraCallout_Visible(False)
            Case CORONER_CASE
                ctlVisible(lblContactName, True)
                ctlVisible(cboName, True)
                UpdateCboNameText(Me.DefaultContactName)
                'TxtContactName.Visible = True
                'TxtContactName.Text = Me.DefaultContactName
                ctlVisible(txtContactPhone, True)
                ctlVisible(lblContactPhone, True)
                txtContactPhone.Text = Me.DefaultContactPhone
                ctlVisible(txtContactOrg, True)
                ctlVisible(lblContactOrg, True)
                txtContactOrg.Text = Me.DefaultOrganization
                Me.CallbackPending = 0
                ctlVisible(chkConfirmed, False)
                chkConfirmed.Checked = System.Windows.Forms.CheckState.Unchecked
                FraCallout_Visible(False)
            Case OUTGOING
                ctlVisible(lblContactName, True)
                ctlVisible(cboName, True)
                UpdateCboNameText(Me.DefaultContactName)
                'TxtContactName.Visible = True
                'TxtContactName.Text = Me.DefaultContactName
                ctlVisible(txtContactPhone, True)
                ctlVisible(lblContactPhone, True)
                txtContactPhone.Text = Me.DefaultContactPhone
                ctlVisible(txtContactOrg, True)
                ctlVisible(lblContactOrg, True)
                txtContactOrg.Text = Me.DefaultOrganization
                Me.CallbackPending = 0
                ctlVisible(chkConfirmed, True)

                If chkConfirmed.Checked = True Then
                    FraCallout_Visible(False)
                Else
                    FraCallout_Visible(True)
                End If

                lblCallout.Text = "Callback"

            Case CONSENT_PENDING, RECOVERY_PENDING
                ctlVisible(lblContactName, True)
                ctlVisible(cboName, True)
                UpdateCboNameText(Me.DefaultContactName)
                'TxtContactName.Visible = True
                'TxtContactName.Text = Me.DefaultContactName
                ctlVisible(txtContactPhone, True)
                ctlVisible(lblContactPhone, True)
                txtContactPhone.Text = Me.DefaultContactPhone
                ctlVisible(txtContactOrg, True)
                ctlVisible(lblContactOrg, True)
                txtContactOrg.Text = Me.DefaultOrganization
                Me.CallbackPending = -1
                ctlVisible(chkConfirmed, False)
                chkConfirmed.Checked = System.Windows.Forms.CheckState.Unchecked
                FraCallout_Visible(False)
            Case SECONDARY_PENDING
                ctlVisible(txtContactOrg, True)
                ctlVisible(lblContactOrg, True)
                txtContactOrg.Text = "Statline"
                Me.CallbackPending = -1
                ctlVisible(chkConfirmed, False)
                chkConfirmed.Checked = System.Windows.Forms.CheckState.Unchecked
                FraCallout_Visible(False)
            Case PAGE_PENDING, FAX_PENDING
                ctlVisible(lblContactName, True)
                ctlVisible(cboName, True)
                UpdateCboNameText(Me.DefaultContactName)
                'TxtContactName.Visible = True
                'TxtContactName.Text = Me.DefaultContactName
                ctlVisible(txtContactPhone, True)
                ctlVisible(lblContactPhone, True)
                txtContactPhone.Text = Me.DefaultContactPhone
                ctlVisible(txtContactOrg, True)
                ctlVisible(lblContactOrg, True)
                txtContactOrg.Text = Me.DefaultOrganization
                Me.CallbackPending = -1
                ctlVisible(chkConfirmed, False)
                chkConfirmed.Checked = System.Windows.Forms.CheckState.Unchecked
                FraCallout_Visible(False)
            Case PAGE_RESPONSE
                ctlVisible(lblContactName, True)
                ctlVisible(cboName, True)
                UpdateCboNameText(Me.DefaultContactName)
                'TxtContactName.Visible = True
                'TxtContactName.Text = Me.DefaultContactName
                ctlVisible(txtContactPhone, False)
                ctlVisible(lblContactPhone, False)
                txtContactPhone.Text = ""
                ctlVisible(txtContactOrg, True)
                ctlVisible(lblContactOrg, True)
                txtContactOrg.Text = Me.DefaultOrganization
                Me.CallbackPending = 0
                ctlVisible(chkConfirmed, True)
                FraCallout_Visible(False)
            Case CALLBACK_PENDING
                ctlVisible(lblContactName, True)
                ctlVisible(cboName, True)
                UpdateCboNameText(Me.DefaultContactName)
                'TxtContactName.Visible = True
                'TxtContactName.Text = Me.DefaultContactName
                ctlVisible(txtContactPhone, True)
                ctlVisible(lblContactPhone, True)
                txtContactPhone.Text = Me.DefaultContactPhone
                ctlVisible(txtContactOrg, True)
                ctlVisible(lblContactOrg, True)
                txtContactOrg.Text = Me.DefaultOrganization
                Me.CallbackPending = -1
                ctlVisible(chkConfirmed, False)
                chkConfirmed.Checked = System.Windows.Forms.CheckState.Unchecked
                FraCallout_Visible(True)
                lblCallout.Text = "Callout"

                cboName.TabIndex = 1
                'TxtContactName.TabIndex = 1
                txtContactOrg.TabIndex = 2
                txtContactPhone.TabIndex = 3
                Me.txtCalloutMins.TabIndex = 4
                Me.txtCalloutDate.TabIndex = 5

            Case Else
                ctlVisible(lblContactName, True)
                ctlVisible(cboName, True)
                UpdateCboNameText(Me.DefaultContactName)
                'TxtContactName.Visible = True
                'TxtContactName.Text = Me.DefaultContactName
                ctlVisible(txtContactPhone, False)
                ctlVisible(lblContactPhone, False)
                txtContactPhone.Text = ""
                ctlVisible(txtContactOrg, True)
                ctlVisible(lblContactOrg, True)
                txtContactOrg.Text = Me.DefaultOrganization
                Me.CallbackPending = 0
                ctlVisible(chkConfirmed, False)
                chkConfirmed.Checked = System.Windows.Forms.CheckState.Unchecked
                FraCallout_Visible(False)
        End Select
    End Sub

    Private Sub UpdateCboNameText(ByVal pvValue As String)
        Dim inpt As String
        Dim intListIndex As Integer

        intListIndex = modControl.SelectText(cboName, pvValue)

        If cboName.SelectedIndex <> -1 Then
            If cboName.SelectedItem.Text <> pvValue Then
                inpt = pvValue
                cboName.Items.Add(inpt)
                Call modControl.SelectText(cboName, inpt)
            End If
        End If
    End Sub

    Public Sub FraCallout_Visible(ByVal pvVisible As Boolean)
        'This function sets the CSS "visibility" style property so the controls are invisible on the client; if they are set to not visible on the server, they are not rendered on the client at all
        'Note: There are no frames in ASP.NET, so this function set visibility for FraCallout frame from StatTrac

        Dim vVisible = IIf(pvVisible, "visible", "hidden")

        lblCallout.Style.Add("VISIBILITY", vVisible)
        lblCalloutUnits.Style.Add("VISIBILITY", vVisible)
        txtCalloutDate.Style.Add("VISIBILITY", vVisible)
        txtCalloutMins.Style.Add("VISIBILITY", vVisible)
    End Sub

    Public Sub ctlVisible(ByRef pvCtl As WebControl, ByVal pvVisible As Boolean)
        'This function sets the CSS "visibility" style property so the controls are invisible on the client; if they are set to not visible on the server, they are not rendered on the client at all

        pvCtl.Style.Add("VISIBILITY", IIf(pvVisible, "visible", "hidden"))
    End Sub

    Private Sub chkConfirmed_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles chkConfirmed.CheckedChanged
        'On Error Resume Next

        'If chkConfirmed.Checked _
        'And (modControl.GetID(cboContactEventType) = OUTGOING _
        'Or modControl.GetID(cboContactEventType) = CALLBACK_PENDING) Then
        '    'FraCallout.Visible = False
        '    FraCallout_Visible(False)   '03/05/03 drh - There are no frames in ASP.NET
        '    'Replace the existing date
        '    txtContactDesc.Text = Replace(txtContactDesc.Text, "Callout after " & Me.OldCalloutDate, "")
        'ElseIf Not chkConfirmed.Checked _
        'And (modControl.GetID(cboContactEventType) = OUTGOING _
        'Or modControl.GetID(cboContactEventType) = CALLBACK_PENDING) Then
        '    'FraCallout.Visible = True
        '    FraCallout_Visible(True)   '03/05/03 drh - There are no frames in ASP.NET
        '    'Replace the existing date
        '    txtContactDesc.Text = "Callout after " & txtCalloutDate.Text & " " & txtContactDesc.Text
        'End If
    End Sub

    Private Sub txtCalloutDate_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtCalloutDate.TextChanged
        ''03/14/03 drh - This SubRoutine combines the "GotFocus" and "Validate" methods from StatTrac

        ''*******START "Validate" code ************************************
        'Dim MsgResponse%

        'If OldCalloutDate <> txtCalloutDate.Text And txtCalloutDate.Text <> "" Then

        '    '03/14/03 drh - Task:Replace with Validator control
        '    'Check if valid date
        '    If Not IsDate(txtCalloutDate.Text) Or Len(txtCalloutDate.Text) < 15 Then
        '        'Call MsgBox("Date is not valid.", vbExclamation, "Validation Error")   '03/20/03 drh Use PopValMsg stmt below
        '        PopValidationMessage("txtCalloutDate", "Callout Date is not valid.")
        '        Me.cboContactEventType.SelectedIndex = Viewstate("cboContactEventType.SelectedIndex")
        '        Exit Sub
        '    End If

        '    'Check if the date/time is before now
        '    If DateDiff("n", Now, txtCalloutDate.Text) < 0 Then
        '        'Call MsgBox("Date/time is before now.", vbExclamation, "Validation Error")   '03/20/03 drh Use PopValMsg stmt below
        '        PopValidationMessage("txtCalloutDate", "Callout Date/time is before now.")
        '        Exit Sub
        '    End If

        '    'Warn if date/time is greater than one day
        '    If DateDiff("d", Now, txtCalloutDate.Text) > 1 Then

        '        'MsgResponse = MsgBox("You have set a callout greater than a 1 day from now. Is this correct?", vbExclamation + vbDefaultButton2 + vbYesNo, "Validation Error")   '03/20/03 drh Use PopValMsg stmt below
        '        PopValidationMessage("txtCalloutDate", "You have set a callout greater than a 1 day from now. Please verify this is correct.", True)

        '        'If MsgResponse = vbNo Then
        '        '    txtCalloutDate.Text = vsOldCalloutDate
        '        '    Exit Sub
        '        'End If

        '    End If

        '    txtCalloutMins.Text = DateDiff("n", Now, txtCalloutDate.Text)

        '    If txtContactDesc.Text = "" Then
        '        txtContactDesc.Text = "Callout after " & txtCalloutDate.Text & "."
        '    Else
        '        'Replace the existing date
        '        txtContactDesc.Text = Replace(txtContactDesc.Text, OldCalloutDate, txtCalloutDate.Text)

        '    End If
        'End If


        ''*******START "GotFocus" code ************************************
        'OldCalloutDate = txtCalloutDate.Text

    End Sub

    Private Sub Val_Msg(ByVal vMsgText$)
        '03/20/03 drh - No longer using, but keep the code for reference
        Dim vCtl As Control
        Dim iCtl As Control
        For Each vCtl In Me.Controls
            For Each iCtl In vCtl.Controls
                ViewState(CStr(iCtl.ID) & "_Visible") = iCtl.Visible
                iCtl.Visible = False
            Next
        Next

        cmdValidationMsg.Visible = True
        cmdValidationMsg.Text = "Date is not valid.  Click here to go back."
    End Sub

    Private Sub ClearVal_Msg()
        '03/20/03 drh - No longer using, but keep the code for reference
        Dim vCtl As Control
        Dim iCtl As Control
        For Each vCtl In Me.Controls
            For Each iCtl In vCtl.Controls
                iCtl.Visible = ViewState(CStr(iCtl.ID) & "_Visible")
            Next
        Next

        cmdValidationMsg.Visible = False
    End Sub

    Private Sub cmdValidationMsg_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        Call ClearVal_Msg()
    End Sub

    Private Sub SetClientEventHandlers()
        txtCalloutDate.Attributes.Add("onfocus", "valPrev(this);")
        txtContactOrg.Attributes.Add("onfocus", "valPrev(this);")
        cboContactEventType.Attributes.Add("onfocus", "valPrev(this);")
        cboName.Attributes.Add("onfocus", "valPrev(this);")
        cmdOK.Attributes.Add("onfocus", "valPrev(this);")
        txtContactDate.Attributes.Add("onfocus", "valPrev(this);")
        txtContactPhone.Attributes.Add("onfocus", "valPrev(this);")
        txtCalloutMins.Attributes.Add("onfocus", "valPrev(this);")
        txtContactDesc.Attributes.Add("onfocus", "valPrev(this);")

        '03/20/03 drh - Microsoft Bug: Applies onfocus handler to the 
        'Span element instead of the input element for checkboxes
        chkConfirmed.Attributes.Add("onclick", "valPrevCSS(this);")
        chkConfirmed.Attributes.Add("onfocus", "valPrevCSS(this);")
        chkConfirmed.Attributes.Add("name", "chkConfirmedSpan")
    End Sub

    Public Sub PopValidationMessage(ByVal vCtlName$, ByVal vValMsg$, Optional ByVal vValDisplayOnce As Boolean = False)
        Session("ValCtl") = vCtlName
        Session("ValMsg") = vValMsg
        Session("ValDisplayOnce") = CStr(vValDisplayOnce)
    End Sub

    Private Sub txtContactDate_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtContactDate.TextChanged
        ''03/14/03 drh - This SubRoutine replaces the "Validate" method from StatTrac

        'On Error Resume Next

        'If Not IsDate(txtContactDate.Text) Or Len(txtContactDate.Text) < 15 Then
        '    'Call MsgBox("Date is not valid.", vbExclamation, "Validation Error")
        '    'Cancel = True
        '    PopValidationMessage("txtContactDate", "Contact Date is not valid.")
        'Else
        '    Me.ContactLogEventDate = txtContactDate.Text
        'End If
    End Sub

    Private Sub txtCalloutMins_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtCalloutMins.TextChanged
        '03/14/03 drh - This SubRoutine combines the "GotFocus" and "Validate" methods from StatTrac

        '*******START "Validate" code ************************************
        'On Error Resume Next

        'If txtCalloutMins.Text <> Me.OldCalloutMins Then

        '    txtCalloutDate.Text = Format(DateAdd(DateInterval.Minute, CDbl(txtCalloutMins.Text), Now), "MM/dd/yy  HH:mm")

        '    Dim vSender As New System.Object()
        '    Dim vE As New System.EventArgs()
        '    Call Me.txtCalloutDate_TextChanged(vSender, vE)

        'End If

        '*******START "GotFocus" code ************************************
        'vsOldCalloutMins = CInt(Request("OldCalloutMins"))
    End Sub

    Private Sub cmdOtherName_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdOtherName.Click
        Dim inpt As String

        inpt = txtOtherName.Text
        Me.DefaultContactName = inpt
        UpdateCboNameText(inpt)
        txtOtherName.Text = ""

    End Sub

    Private Sub setPopupProperties()
        pnlOtherName.BorderStyle = BorderStyle.NotSet
        pnlOtherName.CssClass = "CSSNoPop"
    End Sub

    Private Sub cboName_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cboName.SelectedIndexChanged
        modControl.RemoveID(cboName, -1)

        If Me.ContactLogEventTypeID = OUTGOING Then
            If chkConfirmed.Checked = True Then
                FraCallout_Visible(False)
            Else
                FraCallout_Visible(True)
            End If
        End If
    End Sub

    Private Sub setControlProperties()
        FraCallout_Visible(False)
        ctlVisible(chkConfirmed, False)
    End Sub


    Private Sub cmdCancel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdCancel.Click
        Server.Transfer("FrmLogEventList.aspx")
    End Sub

End Class
