Public Class FrmLogEventList
    Inherits System.Web.UI.Page
    Protected WithEvents dgPendingEvent As System.Web.UI.WebControls.DataGrid
    Protected WithEvents dgLogEvent As System.Web.UI.WebControls.DataGrid
    Protected Friend TxtEventDesc As System.Web.UI.WebControls.TextBox
    Protected WithEvents Label1 As System.Web.UI.WebControls.Label
    Protected WithEvents Label2 As System.Web.UI.WebControls.Label
    Protected WithEvents cmdNewEvent As System.Web.UI.WebControls.Button


    Public Property DSN&()
        Get
            DSN = AppMain.mainstate.DSN
        End Get
        Set(ByVal vNewValue&)
            AppMain.mainstate.DSN = CStr(vNewValue)
        End Set
    End Property
    Public LogEventTypeList
    Public Property LogEventType&()
        Get
            LogEventType = AppMain.mainstate.LogEventType
        End Get
        Set(ByVal vNewValue&)
            AppMain.mainstate.LogEventType = CStr(vNewValue)
        End Set
    End Property
    Public Property StatEmployeeName&()
        Get
            StatEmployeeName = AppMain.mainstate.StatEmployeeName
        End Get
        Set(ByVal vNewValue&)
            AppMain.mainstate.StatEmployeeName = CStr(vNewValue)
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
    Public Property LogEventId&()
        Get
            LogEventId = AppMain.mainstate.LogEventID
        End Get
        Set(ByVal vNewValue&)
            AppMain.mainstate.LogEventID = CStr(vNewValue)
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
    Public Property CurrentLogEventID&()
        Get
            CurrentLogEventID = AppMain.mainstate.currentLogEventID
        End Get
        Set(ByVal vNewValue&)
            AppMain.mainstate.currentLogEventID = CStr(vNewValue)
        End Set
    End Property

    Public Property WebUserId&()
        Get
            WebUserId = AppMain.mainstate.WebUserID
        End Get
        Set(ByVal vNewValue&)
            AppMain.mainstate.WebUserID = CStr(vNewValue)
        End Set
    End Property
    Public Property WebUserOrganizationId&()
        Get
            WebUserOrganizationId = AppMain.mainstate.WebUserOrganizationID
        End Get
        Set(ByVal vNewValue&)
            AppMain.mainstate.WebUserOrganizationID = CStr(vNewValue)
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


    'Since we don't have Referral form fields, create variables to emulate the fields.
    'Note: the values will be stored in session vars (populate when form is loaded)
    Public Property CboName_Text$()
        Get
            CboName_Text = AppMain.mainstate.CboName_Text
        End Get
        Set(ByVal vNewValue$)
            AppMain.mainstate.CboName_Text = vNewValue
        End Set
    End Property
    Public Property TxtPhone_Text$()
        Get
            TxtPhone_Text = AppMain.mainstate.TxtPhone_Text
        End Get
        Set(ByVal vNewValue$)
            AppMain.mainstate.TxtPhone_Text = vNewValue
        End Set
    End Property
    Public Property CboOrganization_Text$()
        Get
            CboOrganization_Text = AppMain.mainstate.CboOrganization_Text
        End Get
        Set(ByVal vNewValue$)
            AppMain.mainstate.CboOrganization_Text = vNewValue
        End Set
    End Property

    Public Property StatEmployeeId&()
        Get
            StatEmployeeId = AppMain.mainstate.StatEmployeeId
        End Get
        Set(ByVal vNewValue&)
            AppMain.mainstate.StatEmployeeId = CStr(vNewValue)
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
        If Not Page.IsPostBack Then

            Call verifyBrowserCapabilities()

            'Set the Datasource
            AppMain.setDataSource(Request.Form("LogEventDSN"))
            If Request.Form("LogEventDSN") <> "" Then
                AppMain.mainstate.DSN = Request.Form("LogEventDSN")
            End If
            If Request.Form("LogEventDSN") = "" Then
                AppMain.setDataSource(AppMain.mainstate.DSN)
            End If
            'Set CallId (TASK: Move logic to Property stmt above)
            'Me.CallId = IIf(Request.Form("LogEventCallId") <> "", Request.Form("LogEventCallId"), AppMain.mainstate.CallID)
            If Request.Form("LogEventCallID") <> "" Then
                Me.CallId = Request.Form("LogEventCallId")
            ElseIf context.Items.Item("LogEventID") <> "" Then
                Me.CallId = context.Items.Item("LogEventID")

            Else

                Me.CallId = AppMain.mainstate.CallID
            End If
            'Set WebUserId (TASK: Move logic to Property stmt above)
            'Me.WebUserId = IIf(Request.Form("WebUserId") <> "", Request.Form("WebUserId"), AppMain.mainstate.WebUserID)
            If Request.Form("WebUserID") <> "" Then
                Me.WebUserId = Request.Form("WebUserId")
            ElseIf context.Items.Item("WebUserID") <> "" Then
                Me.WebUserId = context.Items.Item("WebUserID")
            Else
                Me.WebUserId = AppMain.mainstate.WebUserID
            End If
            'Set StatEmployee Id/Name
            Me.StatEmployeeId = modStatQuery.QueryStatEmployeeId(Me.WebUserId, 1)
            If Me.StatEmployeeId > 0 Then
                AppMain.mainstate.StatEmployeeId = Me.StatEmployeeId
                AppMain.mainstate.StatEmployeeName = modStatQuery.QueryUserName(Me.WebUserId, 1)
            Else
                Server.Transfer("FrmStart2.aspx")
            End If

            'Set WebUserOrganizationId and Time Zone (TASK: Move logic to Property stmt above)
            'Me.WebUserOrganizationId = IIf(Request.Form("WebUserOrganizationId") <> "", Request.Form("WebUserOrganizationId"), AppMain.mainstate.WebUserOrganizationID)
            If Request.Form("WebUserOrganizationId") <> "" Then
                Me.WebUserOrganizationId = Request.Form("WebUserOrganizationId")
            ElseIf context.Items.Item("WebUserOrgID") <> "" Then
                Me.WebUserOrganizationId = context.Items.Item("WebUserOrgID")
            Else
                Me.WebUserOrganizationId = AppMain.mainstate.WebUserOrganizationID
            End If

            Call QueryOrganizationTimeZone(Me)
            WebUserOrganizationTimeZoneDiff = modStatQuery.QueryTimeZoneDif(Me.WebUserOrganizationTimeZone)

            Dim vReturn As DataSet
            'If QueryReferralInfo(Me, vReturn) <> SUCCESS Then
            'Server.Transfer("FrmStart.aspx")
            'End If

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
        'Session("FrmLogEvent.FormState") = NEW_EVENT
        AppMain.mainstate.FormState = NEW_EVENT
        'Session("FrmLogEvent.CallId") = 0
        'AppMain.mainstate.CallID = 0
        'Session("FrmLogEvent.CallNumber") = ""
        'AppMain.mainstate.CallNumber = ""
        'Session("FrmLogEvent.DefaultContactName") = ""
        'AppMain.mainstate.DefaultContactName = ""
        'Session("FrmLogEvent.DefaultContactPhone") = ""
        ' AppMain.mainstate.DefaultcontactPhone = ""
        'Session("FrmLogEvent.DefaultOrganization") = ""
        'AppMain.mainstate.DefaultOrganization = ""
        'Session("FrmLogEvent.DefaultOrganizationID") = 0
        'AppMain.mainstate.DefaultOrganizationID = 0
        'Session("FrmLogEvent.OrganizationId") = 0
        ' AppMain.mainstate.OrganizationID = 0
        'Session("FrmLogEvent.DefaultContactType") = 0
        'AppMain.mainstate.DefaultContactType = 0
        'Session("FrmLogEvent.LogEventType") = 0
        AppMain.mainstate.LogEventType = 0

        'Session("FrmLogEvent.UpdatePendingEvent") = False
        AppMain.mainstate.UpdatePendingEvent = False
    End Sub

    Private Sub cmdNewEvent_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdNewEvent.Click
        doNewLogEvent()
    End Sub

    Private Sub dgPendingEvent_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles dgPendingEvent.ItemCommand
        If (e.CommandName = "Create Response") Then
            doPendingResponse(e.Item.Cells(0).Text)
        End If
    End Sub

    Private Sub dgLogEvent_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles dgLogEvent.ItemCommand
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

    Private Sub dgLogEvent_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles dgLogEvent.SelectedIndexChanged
        Dim vDescText$
        Call QueryLogEventDesc(dgLogEvent.SelectedItem.Cells(0).Text, vDescText, Me.WebUserOrganizationTimeZoneDiff)
        Me.TxtEventDesc.Text = vDescText
    End Sub

    Private Sub doNewLogEvent(Optional ByVal pvLogEventId = 0)
        Dim vEventTypeList(0)

        'Initialize the variables to be passed to the Log Event Form
        Call initFrmLogEventVars()

        'Pass along local vars
        'Session("FrmLogEvent.FormState") = NEW_EVENT
        AppMain.mainstate.FormState = NEW_EVENT
        'Session("FrmLogEvent.CallId") = Me.CallId
        AppMain.mainstate.CallID = Me.CallId
        'Session("FrmLogEvent.CallNumber") = Me.CallNumber
        AppMain.mainstate.CallNumber = Me.CallNumber

        If pvLogEventId > 0 Then
            Me.CurrentLogEventID = modConv.TextToLng(pvLogEventId)

            'Get the selected event
            Call modStatQuery.QueryLogEvent(Me, New DataSet)
        Else
            'Default fields
            'Session("FrmLogEvent.DefaultContactName") = CboName_Text
            AppMain.mainstate.DefaultContactName = CboName_Text
            'Session("FrmLogEvent.DefaultContactPhone") = TxtPhone_Text
            AppMain.mainstate.DefaultcontactPhone = TxtPhone_Text
            'Session("FrmLogEvent.DefaultOrganization") = CboOrganization_Text
            AppMain.mainstate.DefaultOrganization = CboOrganization_Text
            'Session("FrmLogEvent.DefaultOrganizationID") = Me.OrganizationId
            AppMain.mainstate.DefaultOrganizationID = Me.OrganizationId
            'BJK 03/27/02: adding code to set OrganizationID in FrmLogEvent Defaul OrganizationID
            'is not used but this is not guaranteed.  OrganizationID is save with the logEvent when saved.
            'Session("FrmLogEvent.OrganizationId") = Me.OrganizationId
            AppMain.mainstate.OrganizationID = Me.OrganizationId
            'Session("FrmLogEvent.DefaultContactType") = 0
            AppMain.mainstate.DefaultContactType = 0
        End If

        'Set event types
        vEventTypeList(0) = ALL_TYPES
        'T.t check this later
        'Session("FrmLogEvent.LogEventTypeList") = vEventTypeList

        ''10/8/01 drh
        'TASK: FrmLogEvent.vParentForm = Me

        '04/10/03 drh - Limit types on the web (no Fax or Secondary events)
        'Select Case CInt(Session("FrmLogEvent.DefaultContactType"))
        Select Case CInt(AppMain.mainstate.DefaultContactType)
            Case SECONDARY_PENDING, SECONDARY_RESPONSE, FAX_PENDING, OUTGOING_FAX
                Exit Sub
            Case Else
                context.Items.Add("LogEventID", AppMain.mainstate.CallID)
                context.Items.Add("WebUserID", AppMain.mainstate.WebUserID)
                context.Items.Add("WebUserOrgID", AppMain.mainstate.WebUserOrganizationID)

                Server.Transfer("wfLogEvent.aspx", True)
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
        'Session("FrmLogEvent.FormState") = EXISTING_RECORD
        AppMain.mainstate.FormState = EXISTING_RECORD
        'Set the call id & number of the LogEvent form to
        '0 to indicate table maintenence
        'Session("FrmLogEvent.CallId") = Me.CallId
        AppMain.mainstate.CallID = Me.CallId
        'Session("FrmLogEvent.CallNumber") = Me.CallNumber
        AppMain.mainstate.CallNumber = Me.CallNumber
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
        'Session("FrmLogEvent.LogEventId") = modConv.TextToLng(pvLogEventId)
        AppMain.mainstate.LogEventID = modConv.TextToLng(pvLogEventId)
        'Find the event type
        Call modStatQuery.QueryLogEventTypeID(modConv.TextToLng(pvLogEventId), vLogEventTypeID)

        Select Case vLogEventTypeID

            Case CONSENT_PENDING
                vEventTypeList(0) = CONSENT_RESPONSE
                vEventTypeList(1) = NO_CONSENT_RESPONSE
                'Session("FrmLogEvent.DefaultContactType") = CONSENT_RESPONSE
                AppMain.mainstate.DefaultContactType = CONSENT_RESPONSE
            Case PAGE_PENDING
                vEventTypeList(0) = PAGE_RESPONSE
                vEventTypeList(1) = NO_PAGE_RESPONSE
                'Session("FrmLogEvent.DefaultContactType") = PAGE_RESPONSE
                AppMain.mainstate.DefaultContactType = PAGE_RESPONSE
            Case RECOVERY_PENDING
                vEventTypeList(0) = RECOVERY_RESPONSE
                vEventTypeList(1) = NO_RECOVERY_RESPONSE
                'Session("FrmLogEvent.DefaultContactType") = RECOVERY_RESPONSE
                AppMain.mainstate.DefaultContactType = RECOVERY_RESPONSE
            Case CALLBACK_PENDING
                vEventTypeList(0) = OUTGOING
                vEventTypeList(1) = INCOMING
                'Session("FrmLogEvent.DefaultContactType") = OUTGOING
                AppMain.mainstate.DefaultContactType = OUTGOING
            Case SECONDARY_PENDING
                ReDim vEventTypeList(0)
                vEventTypeList(0) = SECONDARY_RESPONSE
                'Session("FrmLogEvent.DefaultContactType") = SECONDARY_RESPONSE
                AppMain.mainstate.DefaultContactType = SECONDARY_RESPONSE
                'Session("FrmLogEvent.PersonID") = Me.StatEmployeeId
                AppMain.mainstate.PersonID = Me.StatEmployeeId
                '10/8/01 drh
            Case FAX_PENDING
                ReDim vEventTypeList(0)
                vEventTypeList(0) = OUTGOING_FAX
                'Session("FrmLogEvent.DefaultContactType") = OUTGOING_FAX
                AppMain.mainstate.DefaultContactType = OUTGOING_FAX
        End Select
        'T.T check later
        'Session("FrmLogEvent.LogEventTypeList") = vEventTypeList

        'Session("FrmLogEvent.UpdatePendingEvent") = True
        AppMain.mainstate.UpdatePendingEvent = True
        'set default settings
        'Session("FrmLogEvent.DefaultContactName") = Me.CboName_Text
        AppMain.mainstate.DefaultContactName = Me.CboName_Text
        'Session("FrmLogEvent.DefaultContactPhone") = Me.TxtPhone_Text
        AppMain.mainstate.DefaultcontactPhone = Me.TxtPhone_Text
        'Session("FrmLogEvent.DefaultOrganization") = Me.CboOrganization_Text
        AppMain.mainstate.DefaultOrganization = Me.CboOrganization_Text
        'Session("FrmLogEvent.DefaultOrganizationID") = Me.OrganizationId
        AppMain.mainstate.DefaultOrganizationID = Me.OrganizationId
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
        'Session("FrmLogEvent.FormState") = EXISTING_RECORD
        AppMain.mainstate.FormLoad = EXISTING_RECORD
        'Get the ID of the LogEvent to open
        vLogEventID = modConv.TextToLng(modConv.TextToLng(pvLogEventId))
        'Session("FrmLogEvent.LogEventID") = vLogEventID
        AppMain.mainstate.LogEventID = vLogEventID

        'Set the call id & number of the LogEvent form to
        '0 to indicate table maintenence
        'Session("FrmLogEvent.CallId") = Me.CallId
        AppMain.mainstate.CallID = Me.CallId
        'Session("FrmLogEvent.CallNumber") = Me.CallNumber
        AppMain.mainstate.CallNumber = Me.CallNumber
        'uses parent.orgtz instead: Session("FrmLogEvent.OrganizationTimeZone") = Me.OrganizationTimeZone

        'Get the LogEventTypeId
        'If modStatRefQuery.RefQueryLogEventType(vReturn, vLogEventID) = SUCCESS Then
        'AppMain.mainstate.LogEventType = GetReturnID(vReturn)
        'End If

        'Set event types
        vEventTypeList(0) = ALL_TYPES
        'T.T check later
        'Session("FrmLogEvent.LogEventTypeList") = vEventTypeList

        '10/8/01 drh
        'T.T check later
        'Session("FrmLogEvent.vParentForm") = Me

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
End Class
