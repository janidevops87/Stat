Public Class FrmLogEventList
    Inherits System.Web.UI.Page
    Public AuditLogId&
    Public WithEvents dgPendingEvent As System.Web.UI.WebControls.DataGrid
    Public WithEvents dgLogEvent As System.Web.UI.WebControls.DataGrid
    Public WithEvents TxtEventDesc As System.Web.UI.WebControls.TextBox
    Public WithEvents Label1 As System.Web.UI.WebControls.Label
    Public WithEvents Label2 As System.Web.UI.WebControls.Label
    Public WithEvents cmdNewEvent As System.Web.UI.WebControls.Button
    Public WithEvents chkConfirmed As System.Web.UI.WebControls.CheckBox
    Public WithEvents cmdValidationMsg As System.Web.UI.WebControls.Button
    Public WithEvents Label5 As System.Web.UI.WebControls.Label
    Public WithEvents cboKeyCode As System.Web.UI.WebControls.DropDownList
    Public WithEvents cmdOtherNameCancel As System.Web.UI.WebControls.Button
    Public WithEvents spacer9 As System.Web.UI.WebControls.Label
    Public WithEvents cmdOtherName As System.Web.UI.WebControls.Button
    Public WithEvents spacer4 As System.Web.UI.WebControls.Label
    Public WithEvents txtOtherName As System.Web.UI.WebControls.TextBox
    Public WithEvents Label6 As System.Web.UI.WebControls.Label
    Public WithEvents spacer3 As System.Web.UI.WebControls.Label
    Public WithEvents Label4 As System.Web.UI.WebControls.Label
    Public WithEvents pnlOtherName As System.Web.UI.WebControls.Panel
    Public WithEvents Label3 As System.Web.UI.WebControls.Label
    Public WithEvents lblCallout As System.Web.UI.WebControls.Label
    Public WithEvents txtCalloutDate As System.Web.UI.WebControls.TextBox
    Public WithEvents lblCalloutUnits As System.Web.UI.WebControls.Label
    Public WithEvents txtCalloutMins As System.Web.UI.WebControls.TextBox
    Public WithEvents txtContactPhone As System.Web.UI.WebControls.TextBox
    Public WithEvents lblContactPhone As System.Web.UI.WebControls.Label
    Public WithEvents txtContactOrg As System.Web.UI.WebControls.TextBox
    Public WithEvents lblContactOrg As System.Web.UI.WebControls.Label
    Public WithEvents cboName As System.Web.UI.WebControls.DropDownList
    Public WithEvents lblContactName As System.Web.UI.WebControls.Label
    Public WithEvents Label7 As System.Web.UI.WebControls.Label
    Public WithEvents lblEventType As System.Web.UI.WebControls.Label
    Public WithEvents cboContactEventType As System.Web.UI.WebControls.DropDownList
    Public WithEvents cmdOK As System.Web.UI.WebControls.Button
    Public WithEvents txtContactDesc As System.Web.UI.WebControls.TextBox
    Public WithEvents txtContactDate As System.Web.UI.WebControls.TextBox
    Public WithEvents cmdCancel As System.Web.UI.WebControls.Button
    Public WithEvents cmdOK2 As System.Web.UI.WebControls.Button
    Public WithEvents chkConfirmed2 As System.Web.UI.WebControls.CheckBox
    Public WithEvents cmdValidationMsg2 As System.Web.UI.WebControls.Button
    Public WithEvents txtContactDesc2 As System.Web.UI.WebControls.TextBox
    Public WithEvents cboContactEventType2 As System.Web.UI.WebControls.DropDownList
    Public WithEvents cboKeyCode2 As System.Web.UI.WebControls.DropDownList
    Public WithEvents cmdOtherNameCancel2 As System.Web.UI.WebControls.Button
    Public WithEvents spacer92 As System.Web.UI.WebControls.Label
    Public WithEvents cmdOtherName2 As System.Web.UI.WebControls.Button
    Public WithEvents spacer42 As System.Web.UI.WebControls.Label
    Public WithEvents txtOtherName2 As System.Web.UI.WebControls.TextBox
    Public WithEvents Label62 As System.Web.UI.WebControls.Label
    Public WithEvents spacer32 As System.Web.UI.WebControls.Label
    Public WithEvents Label42 As System.Web.UI.WebControls.Label
    Public WithEvents pnlOtherName2 As System.Web.UI.WebControls.Panel
    Public WithEvents cboName2 As System.Web.UI.WebControls.DropDownList
    Public WithEvents lblContactName2 As System.Web.UI.WebControls.Label
    Public WithEvents lblContactOrg2 As System.Web.UI.WebControls.Label
    Public WithEvents txtContactOrg2 As System.Web.UI.WebControls.TextBox
    Public WithEvents txtContactPhone2 As System.Web.UI.WebControls.TextBox
    Public WithEvents lblContactPhone2 As System.Web.UI.WebControls.Label
    Public WithEvents lblCallout2 As System.Web.UI.WebControls.Label
    Public WithEvents txtCalloutMins2 As System.Web.UI.WebControls.TextBox
    Public WithEvents lblCalloutUnits2 As System.Web.UI.WebControls.Label
    Public WithEvents txtCalloutDate2 As System.Web.UI.WebControls.TextBox
    Public WithEvents Label8 As System.Web.UI.WebControls.Label
    Public WithEvents txtContactDate2 As System.Web.UI.WebControls.TextBox
    Public fvContactLogEventDate As Date
    Public LogEventTypeList
    Public Property Saved%()
        Get
            Saved = CLng(Session("FrmLogEvent.Saved"))
        End Get
        Set(ByVal vNewValue%)
            Session("FrmLogEvent.Saved") = CStr(vNewValue)
        End Set
    End Property
    Public Property UpdatePendingEvent() As Boolean
        Get
            UpdatePendingEvent = CBool(Session("FrmLogEvent.UpdatePendingEvent"))
        End Get
        Set(ByVal vNewValue As Boolean)
            Session("FrmLogEvent.UpdatePendingEvent") = CStr(vNewValue)
        End Set
    End Property
    Public Property OldCalloutMins() As String
        Get
            OldCalloutMins = Session("OldCalloutMins")
        End Get
        Set(ByVal vNewValue As String)
            Session("OldCalloutMins") = vNewValue
        End Set
    End Property
    Public Property ScheduleGroupID&()
        Get
            ScheduleGroupID = CLng(Session("FrmLogEvent.ScheduleGroupID"))
        End Get
        Set(ByVal vNewValue&)
            Session("FrmLogEvent.ScheduleGroupID") = CStr(vNewValue)
        End Set
    End Property
    Public Property PersonID&()
        Get
            PersonID = CLng(Session("FrmLogEvent.PersonID"))
        End Get
        Set(ByVal vNewValue&)
            Session("FrmLogEvent.PersonID") = CStr(vNewValue)
        End Set
    End Property
    Public Property PhoneID&()
        Get
            PhoneID = CLng(Session("FrmLogEvent.PhoneID"))
        End Get
        Set(ByVal vNewValue&)
            Session("FrmLogEvent.PhoneID") = CStr(vNewValue)
        End Set
    End Property
    Public Property ContactLogEventID&()
        Get
            ContactLogEventID = CLng(Session("FrmLogEvent.ContactLogEventID"))
        End Get
        Set(ByVal vNewValue&)
            Session("FrmLogEvent.ContactLogEventID") = CStr(vNewValue)
        End Set
    End Property
    Public Property CallbackPending%()
        Get
            CallbackPending = CLng(Session("FrmLogEvent.CallbackPending"))
        End Get
        Set(ByVal vNewValue%)
            Session("FrmLogEvent.CallbackPending") = CStr(vNewValue)
        End Set
    End Property
    Public Property ContactEmployeeID&()
        Get
            ContactEmployeeID = CLng(Session("FrmLogEvent.ContactEmployeeID"))
        End Get
        Set(ByVal vNewValue&)
            Session("FrmLogEvent.ContactEmployeeID") = CStr(vNewValue)
        End Set
    End Property
    Public Property DefaultContactDesc$()
        Get
            DefaultContactDesc = Session("FrmLogEvent.DefaultContactDesc")
        End Get
        Set(ByVal vNewValue$)
            Session("FrmLogEvent.DefaultContactDesc") = vNewValue
        End Set
    End Property
    Public Property DefaultContactName$()
        Get
            DefaultContactName = Session("FrmLogEvent.DefaultContactName")
        End Get
        Set(ByVal vNewValue$)
            Session("FrmLogEvent.DefaultContactName") = vNewValue
        End Set
    End Property
    Public Property DefaultContactPhone$()
        Get
            DefaultContactPhone = Session("FrmLogEvent.DefaultContactPhone")
        End Get
        Set(ByVal vNewValue$)
            Session("FrmLogEvent.DefaultContactPhone") = vNewValue
        End Set
    End Property
    Public Property DefaultOrganization$()
        Get
            DefaultOrganization = Session("FrmLogEvent.DefaultOrganization")
        End Get
        Set(ByVal vNewValue$)
            Session("FrmLogEvent.DefaultOrganization") = vNewValue
        End Set
    End Property
    Public Property DefaultOrganizationID%()
        Get
            DefaultOrganizationID = CInt(Session("FrmLogEvent.DefaultOrganizationID"))
        End Get
        Set(ByVal vNewValue%)
            Session("FrmLogEvent.DefaultOrganizationID") = CStr(vNewValue)
        End Set
    End Property
    Public Property DefaultContactType%()
        Get
            DefaultContactType = CInt(Session("FrmLogEvent.DefaultContactType"))
        End Get
        Set(ByVal vNewValue%)
            Session("FrmLogEvent.DefaultContactType") = CStr(vNewValue)
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
    Public Property ContactLogEventTypeID&()
        Get
            ContactLogEventTypeID = CLng(Session("FrmLogEvent.ContactLogEventTypeID"))
        End Get
        Set(ByVal vNewValue&)
            Session("FrmLogEvent.ContactLogEventTypeID") = CStr(vNewValue)
        End Set
    End Property

    'Public PassedForm As Form

    '10/8/01 drh
    'Public vParentForm As Form

    Public Property FormState%()
        Get
            FormState = CInt(Session("FrmLogEvent.FormState"))
        End Get
        Set(ByVal vNewValue%)
            Session("FrmLogEvent.FormState") = CStr(vNewValue)
        End Set
    End Property
    Public Property CallId&()
        Get
            CallId = CLng(Session("FrmLogEventList.CallId"))
        End Get
        Set(ByVal vNewValue&)
            Session("FrmLogEventList.CallId") = CStr(vNewValue)
        End Set
    End Property
    Public Property CallNumber$()
        Get
            CallNumber = Session("CallNumber")
        End Get
        Set(ByVal vNewValue$)
            Session("CallNumber") = vNewValue
        End Set
    End Property
    Public Property LogEventId&()
        Get
            LogEventId = CLng(Session("LogEventId"))
        End Get
        Set(ByVal vNewValue&)
            Session("LogEventId") = CStr(vNewValue)
        End Set
    End Property
    Public Property OrganizationId&()
        Get
            OrganizationId = CLng(Session("OrganizationId"))
        End Get
        Set(ByVal vNewValue&)
            Session("OrganizationId") = CStr(vNewValue)
        End Set
    End Property
    Public Property CurrentLogEventID&()
        Get
            CurrentLogEventID = CLng(Session("CurrentLogEventID"))
        End Get
        Set(ByVal vNewValue&)
            Session("CurrentLogEventID") = CStr(vNewValue)
        End Set
    End Property

    Public Property WebUserId&()
        Get
            WebUserId = CLng(Session("ParentForm.WebUserId"))
        End Get
        Set(ByVal vNewValue&)
            Session("ParentForm.WebUserId") = CStr(vNewValue)
        End Set
    End Property
    Public Property WebUserOrganizationId&()
        Get
            WebUserOrganizationId = CLng(Session("ParentForm.WebUserOrganizationId"))
        End Get
        Set(ByVal vNewValue&)
            Session("ParentForm.WebUserOrganizationId") = CStr(vNewValue)
        End Set
    End Property
    Public Property WebUserOrganizationTimeZone$()
        Get
            WebUserOrganizationTimeZone = Session("ParentForm.WebUserOrganizationTimeZone")
        End Get
        Set(ByVal vNewValue$)
            Session("ParentForm.WebUserOrganizationTimeZone") = vNewValue
        End Set
    End Property
    Public Property WebUserOrganizationTimeZoneDiff%()
        Get
            WebUserOrganizationTimeZoneDiff = CInt(Session("ParentForm.WebUserOrganizationTimeZoneDiff"))
        End Get
        Set(ByVal vNewValue%)
            Session("ParentForm.WebUserOrganizationTimeZoneDiff") = CStr(vNewValue)
        End Set
    End Property


    'Since we don't have Referral form fields, create variables to emulate the fields.
    'Note: the values will be stored in session vars (populate when form is loaded)
    Public Property CboName_Text$()
        Get
            CboName_Text = Session("CboName_Text")
        End Get
        Set(ByVal vNewValue$)
            Session("CboName_Text") = vNewValue
        End Set
    End Property
    Public Property TxtPhone_Text$()
        Get
            TxtPhone_Text = Session("TxtPhone_Text")
        End Get
        Set(ByVal vNewValue$)
            Session("TxtPhone_Text") = vNewValue
        End Set
    End Property
    Public Property CboOrganization_Text$()
        Get
            CboOrganization_Text = Session("CboOrganization_Text")
        End Get
        Set(ByVal vNewValue$)
            Session("CboOrganization_Text") = vNewValue
        End Set
    End Property

    Public Property StatEmployeeId&()
        Get
            StatEmployeeId = CLng(Session("FrmLogEventList.StatEmployeeId"))
        End Get
        Set(ByVal vNewValue&)
            Session("FrmLogEventList.StatEmployeeId") = CStr(vNewValue)
        End Set
    End Property


#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Start PageLoad for wfLogEvent

        'Fill reference data
        Dim vresults1 As DataSet
        Call modStatQuery.QueryKeyCodes(Me, vresults1)

        'Fill reference data
        Dim vresults As DataSet
        Call modStatQuery.QueryLogEventType(Me, vresults)


        If Me.FormState = NEW_EVENT Then

            'Get the date/time
            '04/16/02 bjk do not need to change time
            '12/19/01 bjk added DateAdd
            Me.ContactLogEventDate = DateAdd("h", Me.WebUserOrganizationTimeZoneDiff, Now)
            txtContactDate2.Text = Me.ContactLogEventDate

            'Default the contact type
            Call modControl.SelectID(cboContactEventType, Me.DefaultContactType)

            '04/08/03 drh - Added because there's no click event for cboContactEventType
            If modControl.GetID(cboContactEventType) <> -1 Then
                Call updateFormControlState()
            End If

            'Default the contact fields
            Call modStatQuery.QueryLocationPerson(Me, Me.DefaultOrganizationID)
            If Me.DefaultContactName <> "" Then
                'Added: 05/25/01 ttw
                'Added: 07/2001 bjk - If statment
                If Me.DefaultContactName = "" Then
                    UpdateCboNameText(Session("ParentForm.StatEmployeeName"))
                Else
                    UpdateCboNameText(Me.DefaultContactName)
                End If
            End If
            'TxtContactName.Text = Me.DefaultContactName
            txtContactPhone2.Text = Me.DefaultContactPhone
            txtContactOrg2.Text = Me.DefaultOrganization
            txtContactDesc2.Text = Me.DefaultContactDesc

            Me.ContactEmployeeID = Session("ParentForm.StatEmployeeId")

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
                    Me.txtContactDate2.Text = Me.ContactLogEventDate

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
                    Me.txtContactPhone2.Text = Me.DefaultContactPhone
                    Me.DefaultOrganization = DBNullToText(vRow(vTable.Columns(5)))
                    Me.txtContactOrg2.Text = Me.DefaultOrganization
                    Me.txtContactDesc2.Text = DBNullToText(vRow(vTable.Columns(6)))
                    If Me.UpdatePendingEvent = False Then
                        Me.ContactEmployeeID = DBNullToLng(vRow(vTable.Columns(7)))
                    Else
                        Me.ContactEmployeeID = Me.Session("ParentForm.StatEmployeeID")
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
                        Me.txtCalloutMins.Text = DateDiff("n", Me.txtContactDate2.Text, Me.txtCalloutDate.Text)
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
                'txtContactDate2.Text = Format(DateAdd("h", vTimeZoneDif, Now), "mm/dd/yy  hh:mm")
                txtContactDate2.Text = Format(DateAdd("h", Me.WebUserOrganizationTimeZoneDiff, Now), "MM/dd/yy  HH:mm")

                'Clear appropriate fields
                txtContactDesc2.Text = ""
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
                        UpdateCboNameText(Session("ParentForm.StatEmployeeName"))
                    End If
                End If


            End If

        End If

        If Not Page.IsPostBack Then

            Call verifyBrowserCapabilities()

            'Set the Datasource
            AppMain.setDataSource(Request.Form("LogEventDSN"))

            'Set CallId (TASK: Move logic to Property stmt above)
            Me.CallId = IIf(Request.Form("LogEventCallId") <> "", Request.Form("LogEventCallId"), Session("FrmLogEventList.CallId"))

            'Set WebUserId (TASK: Move logic to Property stmt above)
            Me.WebUserId = IIf(Request.Form("WebUserId") <> "", Request.Form("WebUserId"), Session("ParentForm.WebUserId"))

            'Set StatEmployee Id/Name

            Me.StatEmployeeId = modStatQuery.QueryStatEmployeeId(Me.WebUserId, 1)
            If Me.StatEmployeeId > 0 Then
                Session("ParentForm.StatEmployeeId") = Me.StatEmployeeId
                Session("ParentForm.StatEmployeeName") = modStatQuery.QueryUserName(Me.WebUserId, 1)
            Else
                Server.Transfer("FrmStart2.aspx")
            End If

            'Set WebUserOrganizationId and Time Zone (TASK: Move logic to Property stmt above)
            Me.WebUserOrganizationId = IIf(Request.Form("WebUserOrganizationId") <> "", Request.Form("WebUserOrganizationId"), Session("ParentForm.WebUserOrganizationId"))
            Call QueryOrganizationTimeZone(Me)
            WebUserOrganizationTimeZoneDiff = modStatQuery.QueryTimeZoneDif(Me.WebUserOrganizationTimeZone)

            Dim vReturn As DataSet
            If QueryReferralInfo(Me, vReturn) <> SUCCESS Then
                Server.Transfer("FrmStart.aspx")
            End If

            'Get data and process grids
            Call populateOpenLogEvents(dgLogEvent.CurrentPageIndex, True)
            Call populatePendingLogEvents(dgPendingEvent.CurrentPageIndex, True)

        End If

    End Sub

    Private Sub populateOpenLogEvents(ByVal vPageIdx%, Optional ByVal vGetData As Boolean = False)
        If vGetData Then
            Dim vresults2 As DataSet
            Call modStatQuery.QueryOpenLogEventGrid(Me, vresults2)
            dgLogEvent.CurrentPageIndex = vPageIdx
            dgLogEvent.DataSource = vresults2
            dgLogEvent.DataBind()
        End If

        Dim i%
        For i = 0 To dgLogEvent.Items.Count - 1
            '04/10/03 drh - Limit types on the web (no Fax or Secondary events)
            Select Case CInt(dgLogEvent.Items(i).Cells(9).Text)
                Case SECONDARY_PENDING, SECONDARY_RESPONSE, FAX_PENDING, OUTGOING_FAX
                    dgLogEvent.Items(i).Cells(8).Controls.RemoveAt(0)
                    Dim vLabel As New Label
                    vLabel.Text = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
                    dgLogEvent.Items(i).Cells(8).Controls.AddAt(0, vLabel)
                Case Else
                    'Do nothing
            End Select
        Next
    End Sub

    Private Sub populatePendingLogEvents(ByVal vPageIdx%, Optional ByVal vGetData As Boolean = False)
        If vGetData Then
            Dim vresults As DataSet
            Call modStatQuery.QueryPendingEventsGrid(Me, vresults)
            dgPendingEvent.CurrentPageIndex = vPageIdx
            dgPendingEvent.DataSource = vresults
            dgPendingEvent.DataBind()
        End If

        Dim i%
        For i = 0 To dgPendingEvent.Items.Count - 1
            '04/10/03 drh - Limit types on the web (no Fax or Secondary events)
            Select Case CInt(dgPendingEvent.Items(i).Cells(4).Text)
                Case SECONDARY_PENDING, SECONDARY_RESPONSE, FAX_PENDING, OUTGOING_FAX
                    dgPendingEvent.Items(i).Cells(3).Controls.RemoveAt(0)
                    Dim vLabel As New Label
                    vLabel.Text = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
                    dgPendingEvent.Items(i).Cells(3).Controls.AddAt(0, vLabel)
                Case Else
                    'Do nothing
            End Select
        Next
    End Sub

    Private Sub initFrmLogEventVars()
        'Initialize the session vars
        Session("FrmLogEvent.FormState") = NEW_EVENT
        Session("FrmLogEvent.CallId") = 0
        Session("FrmLogEvent.CallNumber") = ""
        Session("FrmLogEvent.DefaultContactName") = ""
        Session("FrmLogEvent.DefaultContactPhone") = ""
        Session("FrmLogEvent.DefaultOrganization") = ""
        Session("FrmLogEvent.DefaultOrganizationID") = 0
        Session("FrmLogEvent.OrganizationId") = 0
        Session("FrmLogEvent.DefaultContactType") = 0
        Session("FrmLogEvent.LogEventType") = 0
        Session("FrmLogEvent.UpdatePendingEvent") = False
    End Sub

    Private Sub cmdNewEvent_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        doNewLogEvent()
    End Sub

    Private Sub dgPendingEvent_ItemCommand(ByVal source As System.Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs)
        If (e.CommandName = "Create Response") Then
            doPendingResponse(e.Item.Cells(0).Text)
        End If
    End Sub

    Private Sub dgLogEvent_ItemCommand(ByVal source As System.Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs)
        If (e.CommandName = "New Event") Then
            doNewLogEvent(e.Item.Cells(0).Text)
        End If
    End Sub

    Sub dgLogEvent_Paged(ByVal sender As Object, ByVal e As DataGridPageChangedEventArgs)
        'Get data and process grid
        Call populateOpenLogEvents(e.NewPageIndex, True)

        'Process grid, but don't get data
        Call populatePendingLogEvents(dgPendingEvent.CurrentPageIndex)
    End Sub

    Sub dgPendingEvent_Paged(ByVal sender As Object, ByVal e As DataGridPageChangedEventArgs)
        'Get data and process grid
        populatePendingLogEvents(e.NewPageIndex, True)

        'Process grid, but don't get data
        Call populateOpenLogEvents(dgLogEvent.CurrentPageIndex)
    End Sub

    Private Sub dgLogEvent_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs)
        Dim vDescText$
        Call QueryLogEventDesc(dgLogEvent.SelectedItem.Cells(0).Text, vDescText, Me.WebUserOrganizationTimeZoneDiff)
        Me.TxtEventDesc.Text = vDescText
    End Sub

    Private Sub doNewLogEvent(Optional ByVal pvLogEventId = 0)
        Dim vEventTypeList(0)

        'Initialize the variables to be passed to the Log Event Form
        Call initFrmLogEventVars()

        'Pass along local vars
        Session("FrmLogEvent.FormState") = NEW_EVENT
        Session("FrmLogEvent.CallId") = Me.CallId
        Session("FrmLogEvent.CallNumber") = Me.CallNumber

        If pvLogEventId > 0 Then
            Me.CurrentLogEventID = modConv.TextToLng(pvLogEventId)

            'Get the selected event
            Call modStatQuery.QueryLogEvent(Me, New DataSet)
        Else
            'Default fields
            Session("FrmLogEvent.DefaultContactName") = CboName_Text
            Session("FrmLogEvent.DefaultContactPhone") = TxtPhone_Text
            Session("FrmLogEvent.DefaultOrganization") = CboOrganization_Text
            Session("FrmLogEvent.DefaultOrganizationID") = Me.OrganizationId
            'BJK 03/27/02: adding code to set OrganizationID in FrmLogEvent Defaul OrganizationID
            'is not used but this is not guaranteed.  OrganizationID is save with the logEvent when saved.
            Session("FrmLogEvent.OrganizationId") = Me.OrganizationId
            Session("FrmLogEvent.DefaultContactType") = 0
        End If

        'Set event types
        vEventTypeList(0) = ALL_TYPES
        Session("FrmLogEvent.LogEventTypeList") = vEventTypeList

        ''10/8/01 drh
        'TASK: FrmLogEvent.vParentForm = Me

        '04/10/03 drh - Limit types on the web (no Fax or Secondary events)
        Select Case CInt(Session("FrmLogEvent.DefaultContactType"))
            Case SECONDARY_PENDING, SECONDARY_RESPONSE, FAX_PENDING, OUTGOING_FAX
                Exit Sub
            Case Else
                Server.Transfer("wfLogEvent.aspx")
        End Select

    End Sub

    Private Sub doPendingResponse(ByVal pvLogEventId$)
        On Error Resume Next

        Dim vEventTypeList()
        Dim vLogEventTypeID&
        Dim vOrganizationId&
        Dim vScheduleGroupID&
        Dim vPosition%

        '***********************
        'Then open the log event
        '***********************

        'Get the call ID and set the values to be passed
        Session("FrmLogEvent.FormState") = EXISTING_RECORD

        'Set the call id & number of the LogEvent form to
        '0 to indicate table maintenence
        Session("FrmLogEvent.CallId") = Me.CallId
        Session("FrmLogEvent.CallNumber") = Me.CallNumber

        'If InStr(1, LstViewPending.SelectedItem.Tag, "|") <> 0 Then
        '    'The pending event is a pending contact so open the oncall event form

        '    ReDim vEventTypeList(2)

        '    'Get the position of the second pipe
        '    vPosition = InStr(2, LstViewPending.SelectedItem.Tag, "|")

        '    'Get the organization ID from the selected item
        '    vOrganizationId = Mid(LstViewPending.SelectedItem.Tag, 2, vPosition - 2)

        '    'Get the schedulegroupid from the selected item
        '    vScheduleGroupID = Mid(LstViewPending.SelectedItem.Tag, vPosition + 1, Len(LstViewPending.SelectedItem.Tag))

        '    'Set the call id & number of the form
        '    Session("FrmOnCallEvent.CallId") = Me.CallId
        '    Session("FrmOnCallEvent.CallNumber") = Me.CallNumber
        '    Session("FrmOnCallEvent.CurrentDate") = Date
        '    Session("FrmOnCallEvent.DefaultContactType") = PAGE_PENDING
        '    Session("FrmOnCallEvent.ReferralOrganizationID") = Me.OrganizationId
        '    Session("FrmOnCallEvent.OrganizationId") = vOrganizationId
        '    Session("FrmOnCallEvent.ScheduleGroupID") = vScheduleGroupID

        '    'Set event types
        '    vEventTypeList(0) = INCOMING
        '    vEventTypeList(1) = OUTGOING
        '    vEventTypeList(2) = PAGE_PENDING

        '    Session("FrmOnCallEvent.SourceCode") = Me.SourceCode
        '    Session("FrmOnCallEvent.LogEventTypeList") = vEventTypeList

        '    Session("FrmOnCallEvent.OnCallType") = REFERRAL
        '    Session("FrmOnCallEvent.TxtAlert.Text") = Me.ScheduleAlert
        '    Session("FrmOnCallEvent.AlphaMsg") = modStatValidate.SetRefAlpha(Me)

        '    '10/8/01 drh
        '    Session("FrmOnCallEvent.vParentForm") = Me

        '    Call FrmOnCallEvent.Display()

        'Else
        'The pending event is a log event
        ReDim vEventTypeList(1)

        'Get the ID of the LogEvent to open
        Session("FrmLogEvent.LogEventId") = modConv.TextToLng(pvLogEventId)

        'Find the event type
        Call modStatQuery.QueryLogEventTypeID(modConv.TextToLng(pvLogEventId), vLogEventTypeID)

        Select Case vLogEventTypeID

            Case CONSENT_PENDING
                vEventTypeList(0) = CONSENT_RESPONSE
                vEventTypeList(1) = NO_CONSENT_RESPONSE
                Session("FrmLogEvent.DefaultContactType") = CONSENT_RESPONSE
            Case PAGE_PENDING
                vEventTypeList(0) = PAGE_RESPONSE
                vEventTypeList(1) = NO_PAGE_RESPONSE
                Session("FrmLogEvent.DefaultContactType") = PAGE_RESPONSE
            Case RECOVERY_PENDING
                vEventTypeList(0) = RECOVERY_RESPONSE
                vEventTypeList(1) = NO_RECOVERY_RESPONSE
                Session("FrmLogEvent.DefaultContactType") = RECOVERY_RESPONSE
            Case CALLBACK_PENDING
                vEventTypeList(0) = OUTGOING
                vEventTypeList(1) = INCOMING
                Session("FrmLogEvent.DefaultContactType") = OUTGOING
            Case SECONDARY_PENDING
                ReDim vEventTypeList(0)
                vEventTypeList(0) = SECONDARY_RESPONSE
                Session("FrmLogEvent.DefaultContactType") = SECONDARY_RESPONSE
                Session("FrmLogEvent.PersonID") = Me.StatEmployeeId
                '10/8/01 drh
            Case FAX_PENDING
                ReDim vEventTypeList(0)
                vEventTypeList(0) = OUTGOING_FAX
                Session("FrmLogEvent.DefaultContactType") = OUTGOING_FAX

        End Select

        Session("FrmLogEvent.LogEventTypeList") = vEventTypeList
        Session("FrmLogEvent.UpdatePendingEvent") = True

        'set default settings
        Session("FrmLogEvent.DefaultContactName") = Me.CboName_Text
        Session("FrmLogEvent.DefaultContactPhone") = Me.TxtPhone_Text
        Session("FrmLogEvent.DefaultOrganization") = Me.CboOrganization_Text
        Session("FrmLogEvent.DefaultOrganizationID") = Me.OrganizationId

        '10/8/01 drh
        'Session("FrmLogEvent.vParentForm") = Me

        '04/10/03 drh - Limit types on the web (no Fax or Secondary events)
        Select Case vLogEventTypeID
            Case SECONDARY_PENDING, SECONDARY_RESPONSE, FAX_PENDING, OUTGOING_FAX
                Exit Sub
            Case Else
                Server.Transfer("wfLogEvent.aspx")
        End Select

        'End If

    End Sub

    Private Sub doUpdateLogEvent(ByVal pvLogEventId)
        'Sub not used, but we may add this in the future, so keep the code

        Dim vLogEventID&
        Dim i%
        Dim vEventTypeList(0)
        Dim vReturn As DataSet

        On Error Resume Next

        'Get the call ID and set the values to be passed
        Session("FrmLogEvent.FormState") = EXISTING_RECORD

        'Get the ID of the LogEvent to open
        vLogEventID = modConv.TextToLng(modConv.TextToLng(pvLogEventId))
        Session("FrmLogEvent.LogEventID") = vLogEventID

        'Set the call id & number of the LogEvent form to
        '0 to indicate table maintenence
        Session("FrmLogEvent.CallId") = Me.CallId
        Session("FrmLogEvent.CallNumber") = Me.CallNumber
        'uses parent.orgtz instead: Session("FrmLogEvent.OrganizationTimeZone") = Me.OrganizationTimeZone

        'Get the LogEventTypeId
        If modStatRefQuery.RefQueryLogEventType(vReturn, vLogEventID) = SUCCESS Then
            Session("FrmLogEvent.LogEventTypeID") = GetReturnID(vReturn)
        End If

        'Set event types
        vEventTypeList(0) = ALL_TYPES
        Session("FrmLogEvent.LogEventTypeList") = vEventTypeList

        '10/8/01 drh
        Session("FrmLogEvent.vParentForm") = Me

        'Get the LogEvent id from the LogEvent form
        'after the user is done.
        Server.Transfer("wfLogEvent.aspx")

    End Sub

    Private Sub verifyBrowserCapabilities()

        'Set object to view browser capabilities
        Dim bc As HttpBrowserCapabilities = Request.Browser

        'Initialize querystring
        Dim vQString$ = "msg.aspx"

        'Verify the browser type and version
        'TASK: Add version-check
        If bc.Browser <> "IE" Then
            vQString = vQString & IIf(vQString = "msg.aspx", "?msg1=true", "&msg1=true")
        ElseIf bc.MajorVersion < 5 Then
            vQString = vQString & IIf(vQString = "msg.aspx", "?msg1=true", "&msg1=true")
        End If

        'Verify Cookies are turned on
        If Not bc.Cookies Then
            vQString = vQString & IIf(vQString = "msg.aspx", "?msg2=true", "&msg2=true")
        End If

        If Not bc.JavaScript Then
            vQString = vQString & IIf(vQString = "msg.aspx", "?msg3=true", "&msg3=true")
        End If

        'If any parameters were added to the querystring, display the message page
        If vQString <> "msg.aspx" Then
            Server.Transfer(vQString)
        End If

        'vCapabilities = "<p>Browser Capabilities:</p>"
        'vCapabilities = vCapabilities & "Type = " & bc.Type & "<br>"
        'vCapabilities = vCapabilities & "Name = " & bc.Browser & "<br>"
        'vCapabilities = vCapabilities & "Version = " & bc.Version & "<br>"
        'vCapabilities = vCapabilities & "Major Version = " &  bc.MajorVersion & "<br>"
        'vCapabilities = vCapabilities & "Minor Version = " & bc.MinorVersion & "<br>"
        'vCapabilities = vCapabilities & "Platform = " & bc.Platform & "<br>"
        'vCapabilities = vCapabilities & "Is Beta = " & bc.Beta & "<br>"
        'vCapabilities = vCapabilities & "Is Crawler = " & bc.Crawler & "<br>"
        'vCapabilities = vCapabilities & "Is AOL = " & bc.AOL & "<br>"
        'vCapabilities = vCapabilities & "Is Win16 = " & bc.Win16 & "<br>"
        'vCapabilities = vCapabilities & "Is Win32 = " & bc.Win32 & "<br>"
        'vCapabilities = vCapabilities & "Supports Frames = " & bc.Frames & "<br>"
        'vCapabilities = vCapabilities & "Supports Tables = " & bc.Tables & "<br>"
        'vCapabilities = vCapabilities & "Supports Cookies = " & bc.Cookies & "<br>"
        'vCapabilities = vCapabilities & "Supports VB Script = " & bc.VBScript & "<br>"
        'vCapabilities = vCapabilities & "Supports JavaScript = " & bc.JavaScript & "<br>"
        'vCapabilities = vCapabilities & "Supports Java Applets = " & bc.JavaApplets & "<br>"
        'vCapabilities = vCapabilities & "Supports ActiveX Controls = " & bc.ActiveXControls & "<br>"
        'vCapabilities = vCapabilities & "CDF = " & bc.CDF & "<br>"

    End Sub



    Private Sub cmdOK_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        '03/26/03 drh - Moved here from StatTrac's txtContactDate2 event handlers since validation is now done on the client
        Me.OldCalloutMins = Page.Request.Form("OldCalloutMins") ' from txtContactDate_GotFocus
        Me.ContactLogEventDate = txtContactDate2.Text       ' from txtContactDate_Validate


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
            Me.txtContactDate2.Text = DateAdd("n", 1, txtContactDate2.Text)
            Me.txtContactDesc2.Text = "Callout after " & txtCalloutDate.Text & "."
            Call modStatSave.SaveLogEvent(Me)
        End If

        Me.Saved = True

        Server.Transfer("FrmLogEventList.aspx")
    End Sub

    Private Sub cboContactEventType_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs)
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

                ctlVisible(txtContactPhone2, False)
                ctlVisible(lblContactPhone, False)
                txtContactPhone2.Text = ""
                ctlVisible(txtContactOrg2, False)
                ctlVisible(lblContactOrg, False)
                txtContactOrg2.Text = ""
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
                ctlVisible(txtContactPhone2, False)
                ctlVisible(lblContactPhone, False)
                txtContactPhone2.Text = ""
                ctlVisible(txtContactOrg2, True)
                ctlVisible(lblContactOrg, True)
                txtContactOrg2.Text = Me.DefaultOrganization
                Me.CallbackPending = 0
                ctlVisible(chkConfirmed, True)
                FraCallout_Visible(False)
            Case CORONER_CASE
                ctlVisible(lblContactName, True)
                ctlVisible(cboName, True)
                UpdateCboNameText(Me.DefaultContactName)
                'TxtContactName.Visible = True
                'TxtContactName.Text = Me.DefaultContactName
                ctlVisible(txtContactPhone2, True)
                ctlVisible(lblContactPhone, True)
                txtContactPhone2.Text = Me.DefaultContactPhone
                ctlVisible(txtContactOrg2, True)
                ctlVisible(lblContactOrg, True)
                txtContactOrg2.Text = Me.DefaultOrganization
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
                ctlVisible(txtContactPhone2, True)
                ctlVisible(lblContactPhone, True)
                txtContactPhone2.Text = Me.DefaultContactPhone
                ctlVisible(txtContactOrg2, True)
                ctlVisible(lblContactOrg, True)
                txtContactOrg2.Text = Me.DefaultOrganization
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
                ctlVisible(txtContactPhone2, True)
                ctlVisible(lblContactPhone, True)
                txtContactPhone2.Text = Me.DefaultContactPhone
                ctlVisible(txtContactOrg2, True)
                ctlVisible(lblContactOrg, True)
                txtContactOrg2.Text = Me.DefaultOrganization
                Me.CallbackPending = -1
                ctlVisible(chkConfirmed, False)
                chkConfirmed.Checked = System.Windows.Forms.CheckState.Unchecked
                FraCallout_Visible(False)
            Case SECONDARY_PENDING
                ctlVisible(txtContactOrg2, True)
                ctlVisible(lblContactOrg, True)
                txtContactOrg2.Text = "Statline"
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
                ctlVisible(txtContactPhone2, True)
                ctlVisible(lblContactPhone, True)
                txtContactPhone2.Text = Me.DefaultContactPhone
                ctlVisible(txtContactOrg2, True)
                ctlVisible(lblContactOrg, True)
                txtContactOrg2.Text = Me.DefaultOrganization
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
                ctlVisible(txtContactPhone2, False)
                ctlVisible(lblContactPhone, False)
                txtContactPhone2.Text = ""
                ctlVisible(txtContactOrg2, True)
                ctlVisible(lblContactOrg, True)
                txtContactOrg2.Text = Me.DefaultOrganization
                Me.CallbackPending = 0
                ctlVisible(chkConfirmed, True)
                FraCallout_Visible(False)
            Case CALLBACK_PENDING
                ctlVisible(lblContactName, True)
                ctlVisible(cboName, True)
                UpdateCboNameText(Me.DefaultContactName)
                'TxtContactName.Visible = True
                'TxtContactName.Text = Me.DefaultContactName
                ctlVisible(txtContactPhone2, True)
                ctlVisible(lblContactPhone, True)
                txtContactPhone2.Text = Me.DefaultContactPhone
                ctlVisible(txtContactOrg2, True)
                ctlVisible(lblContactOrg, True)
                txtContactOrg2.Text = Me.DefaultOrganization
                Me.CallbackPending = -1
                ctlVisible(chkConfirmed, False)
                chkConfirmed.Checked = System.Windows.Forms.CheckState.Unchecked
                FraCallout_Visible(True)
                lblCallout.Text = "Callout"

                cboName.TabIndex = 1
                'TxtContactName.TabIndex = 1
                txtContactOrg2.TabIndex = 2
                txtContactPhone2.TabIndex = 3
                Me.txtCalloutMins.TabIndex = 4
                Me.txtCalloutDate.TabIndex = 5

            Case Else
                ctlVisible(lblContactName, True)
                ctlVisible(cboName, True)
                UpdateCboNameText(Me.DefaultContactName)
                'TxtContactName.Visible = True
                'TxtContactName.Text = Me.DefaultContactName
                ctlVisible(txtContactPhone2, False)
                ctlVisible(lblContactPhone, False)
                txtContactPhone2.Text = ""
                ctlVisible(txtContactOrg2, True)
                ctlVisible(lblContactOrg, True)
                txtContactOrg2.Text = Me.DefaultOrganization
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

    Private Sub chkConfirmed_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'On Error Resume Next

        'If chkConfirmed.Checked _
        'And (modControl.GetID(cboContactEventType) = OUTGOING _
        'Or modControl.GetID(cboContactEventType) = CALLBACK_PENDING) Then
        '    'FraCallout.Visible = False
        '    FraCallout_Visible(False)   '03/05/03 drh - There are no frames in ASP.NET
        '    'Replace the existing date
        '    txtContactDesc2.Text = Replace(txtContactDesc2.Text, "Callout after " & Me.OldCalloutDate, "")
        'ElseIf Not chkConfirmed.Checked _
        'And (modControl.GetID(cboContactEventType) = OUTGOING _
        'Or modControl.GetID(cboContactEventType) = CALLBACK_PENDING) Then
        '    'FraCallout.Visible = True
        '    FraCallout_Visible(True)   '03/05/03 drh - There are no frames in ASP.NET
        '    'Replace the existing date
        '    txtContactDesc2.Text = "Callout after " & txtCalloutDate.Text & " " & txtContactDesc2.Text
        'End If
    End Sub

    Private Sub txtCalloutDate_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs)
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

        '    If txtContactDesc2.Text = "" Then
        '        txtContactDesc2.Text = "Callout after " & txtCalloutDate.Text & "."
        '    Else
        '        'Replace the existing date
        '        txtContactDesc2.Text = Replace(txtContactDesc2.Text, OldCalloutDate, txtCalloutDate.Text)

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
        txtContactOrg2.Attributes.Add("onfocus", "valPrev(this);")
        cboContactEventType.Attributes.Add("onfocus", "valPrev(this);")
        cboName.Attributes.Add("onfocus", "valPrev(this);")
        cmdOK.Attributes.Add("onfocus", "valPrev(this);")
        txtContactDate2.Attributes.Add("onfocus", "valPrev(this);")
        txtContactPhone2.Attributes.Add("onfocus", "valPrev(this);")
        txtCalloutMins.Attributes.Add("onfocus", "valPrev(this);")
        txtContactDesc2.Attributes.Add("onfocus", "valPrev(this);")

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

    Private Sub txtContactDate_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs)
        ''03/14/03 drh - This SubRoutine replaces the "Validate" method from StatTrac

        'On Error Resume Next

        'If Not IsDate(txtContactDate2.Text) Or Len(txtContactDate2.Text) < 15 Then
        '    'Call MsgBox("Date is not valid.", vbExclamation, "Validation Error")
        '    'Cancel = True
        '    PopValidationMessage("txtContactDate2", "Contact Date is not valid.")
        'Else
        '    Me.ContactLogEventDate = txtContactDate2.Text
        'End If
    End Sub

    Private Sub txtCalloutMins_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs)
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

    Private Sub cmdOtherName_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
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

    Private Sub cboName_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs)
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


    Private Sub cmdCancel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        Server.Transfer("FrmLogEventList.aspx")
    End Sub
    Private Sub updateFormControlStatecmb()
        '03/06/03 drh - CODE FROM STATTRAC CLICK/CHANGE EVENTS
        'Set event type
        Me.ContactLogEventTypeID = modControl.GetID(cboContactEventType)

        Call modControl.RemoveID(cboContactEventType, -1)

        Select Case Me.ContactLogEventTypeID
            Case GENERAL
                ctlVisible(lblContactName2, False)
                ctlVisible(cboName2, False)

                'Added: 05/25/01 ttw - to all case lines below
                'UpdateCboNameText Me.DefaultContactName
                'TxtContactName.Visible = False
                'TxtContactName.Text = ""

                'Added: 06/26/01 bjk for notes
                'cboName.Items.Clear()

                ctlVisible(txtContactPhone2, False)
                ctlVisible(lblContactPhone2, False)
                txtContactPhone2.Text = ""
                ctlVisible(txtContactOrg2, False)
                ctlVisible(lblContactOrg2, False)
                txtContactOrg2.Text = ""
                Me.CallbackPending = 0
                ctlVisible(chkConfirmed2, False)
                chkConfirmed2.Checked = System.Windows.Forms.CheckState.Unchecked
                FraCallout_Visible(False)
            Case INCOMING
                ctlVisible(lblContactName2, True)
                ctlVisible(cboName2, True)
                UpdateCboNameText(Me.DefaultContactName)
                'TxtContactName.Visible = True
                'TxtContactName.Text = Me.DefaultContactName
                ctlVisible(txtContactPhone2, False)
                ctlVisible(lblContactPhone2, False)
                txtContactPhone2.Text = ""
                ctlVisible(txtContactOrg2, True)
                ctlVisible(lblContactOrg2, True)
                txtContactOrg2.Text = Me.DefaultOrganization
                Me.CallbackPending = 0
                ctlVisible(chkConfirmed2, True)
                FraCallout_Visible(False)
            Case CORONER_CASE
                ctlVisible(lblContactName2, True)
                ctlVisible(cboName2, True)
                UpdateCboNameText(Me.DefaultContactName)
                'TxtContactName.Visible = True
                'TxtContactName.Text = Me.DefaultContactName
                ctlVisible(txtContactPhone2, True)
                ctlVisible(lblContactPhone2, True)
                txtContactPhone2.Text = Me.DefaultContactPhone
                ctlVisible(txtContactOrg2, True)
                ctlVisible(lblContactOrg2, True)
                txtContactOrg2.Text = Me.DefaultOrganization
                Me.CallbackPending = 0
                ctlVisible(chkConfirmed2, False)
                chkConfirmed2.Checked = System.Windows.Forms.CheckState.Unchecked
                FraCallout_Visible(False)
            Case OUTGOING
                ctlVisible(lblContactName2, True)
                ctlVisible(cboName2, True)
                UpdateCboNameText(Me.DefaultContactName)
                'TxtContactName.Visible = True
                'TxtContactName.Text = Me.DefaultContactName
                ctlVisible(txtContactPhone2, True)
                ctlVisible(lblContactPhone2, True)
                txtContactPhone2.Text = Me.DefaultContactPhone
                ctlVisible(txtContactOrg2, True)
                ctlVisible(lblContactOrg2, True)
                txtContactOrg2.Text = Me.DefaultOrganization
                Me.CallbackPending = 0
                ctlVisible(chkConfirmed2, True)

                If chkConfirmed2.Checked = True Then
                    FraCallout_Visible(False)
                Else
                    FraCallout_Visible(True)
                End If

                lblCallout2.Text = "Callback"

            Case CONSENT_PENDING, RECOVERY_PENDING
                ctlVisible(lblContactName2, True)
                ctlVisible(cboName2, True)
                UpdateCboNameText(Me.DefaultContactName)
                'TxtContactName.Visible = True
                'TxtContactName.Text = Me.DefaultContactName
                ctlVisible(txtContactPhone2, True)
                ctlVisible(lblContactPhone2, True)
                txtContactPhone2.Text = Me.DefaultContactPhone
                ctlVisible(txtContactOrg2, True)
                ctlVisible(lblContactOrg2, True)
                txtContactOrg2.Text = Me.DefaultOrganization
                Me.CallbackPending = -1
                ctlVisible(chkConfirmed2, False)
                chkConfirmed2.Checked = System.Windows.Forms.CheckState.Unchecked
                FraCallout_Visible(False)
            Case SECONDARY_PENDING
                ctlVisible(txtContactOrg2, True)
                ctlVisible(lblContactOrg2, True)
                txtContactOrg2.Text = "Statline"
                Me.CallbackPending = -1
                ctlVisible(chkConfirmed2, False)
                chkConfirmed2.Checked = System.Windows.Forms.CheckState.Unchecked
                FraCallout_Visible(False)
            Case PAGE_PENDING, FAX_PENDING
                ctlVisible(lblContactName2, True)
                ctlVisible(cboName2, True)
                UpdateCboNameText(Me.DefaultContactName)
                'TxtContactName.Visible = True
                'TxtContactName.Text = Me.DefaultContactName
                ctlVisible(txtContactPhone2, True)
                ctlVisible(lblContactPhone2, True)
                txtContactPhone2.Text = Me.DefaultContactPhone
                ctlVisible(txtContactOrg2, True)
                ctlVisible(lblContactOrg2, True)
                txtContactOrg2.Text = Me.DefaultOrganization
                Me.CallbackPending = -1
                ctlVisible(chkConfirmed2, False)
                chkConfirmed2.Checked = System.Windows.Forms.CheckState.Unchecked
                FraCallout_Visible(False)
            Case PAGE_RESPONSE
                ctlVisible(lblContactName2, True)
                ctlVisible(cboName2, True)
                UpdateCboNameText(Me.DefaultContactName)
                'TxtContactName.Visible = True
                'TxtContactName.Text = Me.DefaultContactName
                ctlVisible(txtContactPhone2, False)
                ctlVisible(lblContactPhone2, False)
                txtContactPhone2.Text = ""
                ctlVisible(txtContactOrg2, True)
                ctlVisible(lblContactOrg2, True)
                txtContactOrg2.Text = Me.DefaultOrganization
                Me.CallbackPending = 0
                ctlVisible(chkConfirmed2, True)
                FraCallout_Visible(False)
            Case CALLBACK_PENDING
                ctlVisible(lblContactName2, True)
                ctlVisible(cboName2, True)
                UpdateCboNameText(Me.DefaultContactName)
                'TxtContactName.Visible = True
                'TxtContactName.Text = Me.DefaultContactName
                ctlVisible(txtContactPhone2, True)
                ctlVisible(lblContactPhone2, True)
                txtContactPhone2.Text = Me.DefaultContactPhone
                ctlVisible(txtContactOrg2, True)
                ctlVisible(lblContactOrg2, True)
                txtContactOrg2.Text = Me.DefaultOrganization
                Me.CallbackPending = -1
                ctlVisible(chkConfirmed2, False)
                chkConfirmed2.Checked = System.Windows.Forms.CheckState.Unchecked
                FraCallout_Visible(True)
                lblCallout.Text = "Callout"

                cboName2.TabIndex = 1
                'TxtContactName.TabIndex = 1
                txtContactOrg2.TabIndex = 2
                txtContactPhone2.TabIndex = 3
                Me.txtCalloutMins2.TabIndex = 4
                Me.txtCalloutDate2.TabIndex = 5

            Case Else
                ctlVisible(lblContactName2, True)
                ctlVisible(cboName2, True)
                UpdateCboNameText(Me.DefaultContactName)
                'TxtContactName.Visible = True
                'TxtContactName.Text = Me.DefaultContactName
                ctlVisible(txtContactPhone2, False)
                ctlVisible(lblContactPhone2, False)
                txtContactPhone2.Text = ""
                ctlVisible(txtContactOrg2, True)
                ctlVisible(lblContactOrg2, True)
                txtContactOrg2.Text = Me.DefaultOrganization
                Me.CallbackPending = 0
                ctlVisible(chkConfirmed2, False)
                chkConfirmed2.Checked = System.Windows.Forms.CheckState.Unchecked
                FraCallout_Visible(False)
        End Select
    End Sub
End Class
