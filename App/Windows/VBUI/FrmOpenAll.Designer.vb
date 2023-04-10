<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmOpenAll
#Region "Windows Form Designer generated code "
	<System.Diagnostics.DebuggerNonUserCode()> Public Sub New()
		MyBase.New()
		'This call is required by the Windows Form Designer.
		InitializeComponent()
		'This form is an MDI child.
		'This code simulates the VB6 
		' functionality of automatically
		' loading and showing an MDI
        ' child's parent.
        'bret 1/4/2010 dll conversion Me.MdiParent = AppMain.ParentForm
        'bret 1/4/2010 dll conversion MdiParent.Show()
        'Me.MDIParent = StatTrac.MDIFormStatLine
        'StatTrac.MDIFormStatLine.Show
	End Sub
	'Form overrides dispose to clean up the component list.
	<System.Diagnostics.DebuggerNonUserCode()> Protected Overloads Overrides Sub Dispose(ByVal Disposing As Boolean)
		If Disposing Then
			If Not components Is Nothing Then
				components.Dispose()
			End If
		End If
		MyBase.Dispose(Disposing)
	End Sub
	'Required by the Windows Form Designer
	Private components As System.ComponentModel.IContainer
	Public ToolTip1 As System.Windows.Forms.ToolTip
	Public WithEvents TimerCounter As System.Windows.Forms.Timer
    'Public WithEvents LstViewPendingPage As System.Windows.Forms.ListView
    Public WithEvents LstViewPendingPage As Stattrac.ListView
	Public WithEvents LstViewGeneralAlert As System.Windows.Forms.ListView
	Public WithEvents CmdClearFilters As System.Windows.Forms.Button
	Public WithEvents CmdLineCheck As System.Windows.Forms.Button
	Public WithEvents CmdNewCall As System.Windows.Forms.Button
	Public WithEvents CmdRefresh As System.Windows.Forms.Button
	Public WithEvents LblCountRef As System.Windows.Forms.Label
	Public WithEvents _Label_0 As System.Windows.Forms.Label
    Public WithEvents TxtCallNumberRef As System.Windows.Forms.TextBox
	Public WithEvents TxtFromDateRef As System.Windows.Forms.TextBox
	Public WithEvents TxtToDateRef As System.Windows.Forms.TextBox
	Public WithEvents TxtPatientFirstRef As System.Windows.Forms.TextBox
	Public WithEvents TxtPatientLastRef As System.Windows.Forms.TextBox
	Public WithEvents TxtLocationRef As System.Windows.Forms.TextBox
	Public WithEvents TxtStateRef As System.Windows.Forms.TextBox
	Public WithEvents TxtReferralType As System.Windows.Forms.TextBox
	Public WithEvents TxtRefSource As System.Windows.Forms.TextBox
	Public WithEvents LstViewOpenReferral As System.Windows.Forms.ListView
	Public WithEvents CmdDeleteRef As System.Windows.Forms.Button
	Public WithEvents TxtFromTimeRef As System.Windows.Forms.TextBox
	Public WithEvents TxtToTimeRef As System.Windows.Forms.TextBox
	Public WithEvents Command1 As System.Windows.Forms.Button
	Public WithEvents txtPreRefType As System.Windows.Forms.TextBox
	Public WithEvents txtTcNameRef As System.Windows.Forms.TextBox
	Public WithEvents _TabCallType_TabPage0 As System.Windows.Forms.TabPage
	Public WithEvents LblCountMsg As System.Windows.Forms.Label
	Public WithEvents _Label_1 As System.Windows.Forms.Label
	Public WithEvents TxtCallNumberMsg As System.Windows.Forms.TextBox
	Public WithEvents TxtFromDateMsg As System.Windows.Forms.TextBox
	Public WithEvents TxtToDateMsg As System.Windows.Forms.TextBox
	Public WithEvents TxtForPersonFirst As System.Windows.Forms.TextBox
	Public WithEvents TxtForPersonLast As System.Windows.Forms.TextBox
	Public WithEvents TxtLocationMsg As System.Windows.Forms.TextBox
	Public WithEvents TxtStateMsg As System.Windows.Forms.TextBox
	Public WithEvents TxtMessageType As System.Windows.Forms.TextBox
	Public WithEvents TxtMsgSource As System.Windows.Forms.TextBox
	Public WithEvents LstViewOpenMessage As System.Windows.Forms.ListView
	Public WithEvents TxtMsgFrom As System.Windows.Forms.TextBox
	Public WithEvents CmdDeleteMsg As System.Windows.Forms.Button
	Public WithEvents TxtMsgTx As System.Windows.Forms.TextBox
	Public WithEvents _TabCallType_TabPage1 As System.Windows.Forms.TabPage
	Public WithEvents CmdDeleteNC As System.Windows.Forms.Button
	Public WithEvents LstViewOpenNoCall As System.Windows.Forms.ListView
	Public WithEvents TxtNoCallSource As System.Windows.Forms.TextBox
	Public WithEvents TxtDescription As System.Windows.Forms.TextBox
	Public WithEvents TxtNoCallType As System.Windows.Forms.TextBox
	Public WithEvents TxtToDateNC As System.Windows.Forms.TextBox
	Public WithEvents TxtFromDateNC As System.Windows.Forms.TextBox
	Public WithEvents TxtCallNumberNC As System.Windows.Forms.TextBox
	Public WithEvents _Label_2 As System.Windows.Forms.Label
	Public WithEvents LblCountNoCall As System.Windows.Forms.Label
	Public WithEvents _TabCallType_TabPage2 As System.Windows.Forms.TabPage
	Public WithEvents _Label_3 As System.Windows.Forms.Label
	Public WithEvents LblCountConsent As System.Windows.Forms.Label
	Public WithEvents TxtCallNumber As System.Windows.Forms.TextBox
	Public WithEvents TxtFromDate As System.Windows.Forms.TextBox
	Public WithEvents TxtToDate As System.Windows.Forms.TextBox
	Public WithEvents TxtLocation As System.Windows.Forms.TextBox
	Public WithEvents TxtState As System.Windows.Forms.TextBox
	Public WithEvents TxtPatientFirst As System.Windows.Forms.TextBox
	Public WithEvents TxtPatientLast As System.Windows.Forms.TextBox
	Public WithEvents TxtOrg As System.Windows.Forms.TextBox
	Public WithEvents TxtOrgPerson As System.Windows.Forms.TextBox
	Public WithEvents TxtConsentSource As System.Windows.Forms.TextBox
	Public WithEvents TxtType As System.Windows.Forms.TextBox
	Public WithEvents LstViewPendingConsent As System.Windows.Forms.ListView
	Public WithEvents _TabCallType_TabPage3 As System.Windows.Forms.TabPage
	Public WithEvents LstViewSecondaryAlert As System.Windows.Forms.ListView
    Public WithEvents LstViewCallouts As Stattrac.ListView
	Public WithEvents LstViewSecondary As System.Windows.Forms.ListView
	Public WithEvents _TabCallType_TabPage4 As System.Windows.Forms.TabPage
	Public WithEvents TxtCallNumberInfo As System.Windows.Forms.TextBox
	Public WithEvents TxtFromDateInfo As System.Windows.Forms.TextBox
	Public WithEvents TxtToDateInfo As System.Windows.Forms.TextBox
	Public WithEvents TxtFirstNameInfo As System.Windows.Forms.TextBox
	Public WithEvents TxtLastNameInfo As System.Windows.Forms.TextBox
	Public WithEvents TxtCoalitionInfo As System.Windows.Forms.TextBox
	Public WithEvents TxtStateInfo As System.Windows.Forms.TextBox
	Public WithEvents TxtSourceInfo As System.Windows.Forms.TextBox
	Public WithEvents LstViewOpenInformation As System.Windows.Forms.ListView
	Public WithEvents _TabCallType_TabPage5 As System.Windows.Forms.TabPage
	Public WithEvents LstViewOpenUpdate As System.Windows.Forms.ListView
	Public WithEvents txtTcNameUpdate As System.Windows.Forms.TextBox
	Public WithEvents txtPreRefTypeUpdate As System.Windows.Forms.TextBox
	Public WithEvents txtToTimeUpdate As System.Windows.Forms.TextBox
	Public WithEvents txtFromTimeUpdate As System.Windows.Forms.TextBox
	Public WithEvents txtRefSourceUpdate As System.Windows.Forms.TextBox
	Public WithEvents txtReferralTypeUpdate As System.Windows.Forms.TextBox
	Public WithEvents txtStateUpdate As System.Windows.Forms.TextBox
	Public WithEvents txtLocationUpdate As System.Windows.Forms.TextBox
	Public WithEvents txtPatientLastUpdate As System.Windows.Forms.TextBox
	Public WithEvents txtPatientFirstUpdate As System.Windows.Forms.TextBox
	Public WithEvents txtToDateUpdate As System.Windows.Forms.TextBox
	Public WithEvents txtFromDateUpdate As System.Windows.Forms.TextBox
	Public WithEvents txtCallNumberUpdate As System.Windows.Forms.TextBox
	Public WithEvents _TabCallType_TabPage6 As System.Windows.Forms.TabPage
	Public WithEvents txtMsgTxRecycle As System.Windows.Forms.TextBox
	Public WithEvents cmdRestoreMessage As System.Windows.Forms.Button
	Public WithEvents txtCallNumberMsgRecycle As System.Windows.Forms.TextBox
	Public WithEvents txtFromDateMsgRecycle As System.Windows.Forms.TextBox
	Public WithEvents txtToDateMsgRecycle As System.Windows.Forms.TextBox
	Public WithEvents txtForPersonFirstRecycle As System.Windows.Forms.TextBox
	Public WithEvents txtForPersonLastRecycle As System.Windows.Forms.TextBox
	Public WithEvents txtLocationMsgRecycle As System.Windows.Forms.TextBox
	Public WithEvents txtStateMsgRecycle As System.Windows.Forms.TextBox
	Public WithEvents txtMessageTypeRecycle As System.Windows.Forms.TextBox
	Public WithEvents txtMsgSourceRecycle As System.Windows.Forms.TextBox
	Public WithEvents txtMsgFromRecycle As System.Windows.Forms.TextBox
	Public WithEvents CmdRestoreReferral As System.Windows.Forms.Button
	Public WithEvents txtTcNameRecycle As System.Windows.Forms.TextBox
	Public WithEvents txtPreRefTypeRecycle As System.Windows.Forms.TextBox
	Public WithEvents txtToTimeRecycle As System.Windows.Forms.TextBox
	Public WithEvents txtFromTimeRecycle As System.Windows.Forms.TextBox
	Public WithEvents txtRefSourceRecycle As System.Windows.Forms.TextBox
	Public WithEvents txtReferralTypeRecycle As System.Windows.Forms.TextBox
	Public WithEvents txtStateRecycle As System.Windows.Forms.TextBox
	Public WithEvents txtLocationRecycle As System.Windows.Forms.TextBox
	Public WithEvents txtPatientLastRecycle As System.Windows.Forms.TextBox
	Public WithEvents txtPatientFirstRecycle As System.Windows.Forms.TextBox
	Public WithEvents txtToDateRecycle As System.Windows.Forms.TextBox
	Public WithEvents txtFromDateRecycle As System.Windows.Forms.TextBox
	Public WithEvents txtCallNumberRecycle As System.Windows.Forms.TextBox
	Public WithEvents LstViewOpenRecycle As System.Windows.Forms.ListView
	Public WithEvents LstViewOpenMsgRecycle As System.Windows.Forms.ListView
	Public WithEvents _TabCallType_TabPage7 As System.Windows.Forms.TabPage
	Public WithEvents TabCallType As System.Windows.Forms.TabControl
	Public WithEvents Timer_Renamed As System.Windows.Forms.Timer
	Public WithEvents LstViewIncompletes As System.Windows.Forms.ListView
	Public WithEvents ImageList1 As System.Windows.Forms.ImageList
	Public WithEvents ImageList2 As System.Windows.Forms.ImageList
	Public WithEvents Label As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FrmOpenAll))
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.TimerCounter = New System.Windows.Forms.Timer(Me.components)
        Me.LstViewPendingPage = New Stattrac.ListView
        Me.ImageList1 = New System.Windows.Forms.ImageList(Me.components)
        Me.LstViewGeneralAlert = New System.Windows.Forms.ListView
        Me.CmdClearFilters = New System.Windows.Forms.Button
        Me.CmdLineCheck = New System.Windows.Forms.Button
        Me.CmdNewCall = New System.Windows.Forms.Button
        Me.CmdRefresh = New System.Windows.Forms.Button
        Me.TabCallType = New System.Windows.Forms.TabControl
        Me._TabCallType_TabPage0 = New System.Windows.Forms.TabPage
        Me.LblCountRef = New System.Windows.Forms.Label
        Me._Label_0 = New System.Windows.Forms.Label
        Me.TxtCallNumberRef = New System.Windows.Forms.TextBox
        Me.TxtFromDateRef = New System.Windows.Forms.TextBox
        Me.TxtToDateRef = New System.Windows.Forms.TextBox
        Me.TxtPatientFirstRef = New System.Windows.Forms.TextBox
        Me.TxtPatientLastRef = New System.Windows.Forms.TextBox
        Me.TxtLocationRef = New System.Windows.Forms.TextBox
        Me.TxtStateRef = New System.Windows.Forms.TextBox
        Me.TxtReferralType = New System.Windows.Forms.TextBox
        Me.TxtRefSource = New System.Windows.Forms.TextBox
        Me.LstViewOpenReferral = New System.Windows.Forms.ListView
        Me.CmdDeleteRef = New System.Windows.Forms.Button
        Me.TxtFromTimeRef = New System.Windows.Forms.TextBox
        Me.TxtToTimeRef = New System.Windows.Forms.TextBox
        Me.Command1 = New System.Windows.Forms.Button
        Me.txtPreRefType = New System.Windows.Forms.TextBox
        Me.txtTcNameRef = New System.Windows.Forms.TextBox
        Me._TabCallType_TabPage1 = New System.Windows.Forms.TabPage
        Me.LblCountMsg = New System.Windows.Forms.Label
        Me._Label_1 = New System.Windows.Forms.Label
        Me.TxtCallNumberMsg = New System.Windows.Forms.TextBox
        Me.TxtFromDateMsg = New System.Windows.Forms.TextBox
        Me.TxtToDateMsg = New System.Windows.Forms.TextBox
        Me.TxtForPersonFirst = New System.Windows.Forms.TextBox
        Me.TxtForPersonLast = New System.Windows.Forms.TextBox
        Me.TxtLocationMsg = New System.Windows.Forms.TextBox
        Me.TxtStateMsg = New System.Windows.Forms.TextBox
        Me.TxtMessageType = New System.Windows.Forms.TextBox
        Me.TxtMsgSource = New System.Windows.Forms.TextBox
        Me.LstViewOpenMessage = New System.Windows.Forms.ListView
        Me.TxtMsgFrom = New System.Windows.Forms.TextBox
        Me.CmdDeleteMsg = New System.Windows.Forms.Button
        Me.TxtMsgTx = New System.Windows.Forms.TextBox
        Me._TabCallType_TabPage2 = New System.Windows.Forms.TabPage
        Me.CmdDeleteNC = New System.Windows.Forms.Button
        Me.LstViewOpenNoCall = New System.Windows.Forms.ListView
        Me.TxtNoCallSource = New System.Windows.Forms.TextBox
        Me.TxtDescription = New System.Windows.Forms.TextBox
        Me.TxtNoCallType = New System.Windows.Forms.TextBox
        Me.TxtToDateNC = New System.Windows.Forms.TextBox
        Me.TxtFromDateNC = New System.Windows.Forms.TextBox
        Me.TxtCallNumberNC = New System.Windows.Forms.TextBox
        Me._Label_2 = New System.Windows.Forms.Label
        Me.LblCountNoCall = New System.Windows.Forms.Label
        Me._TabCallType_TabPage3 = New System.Windows.Forms.TabPage
        Me._Label_3 = New System.Windows.Forms.Label
        Me.LblCountConsent = New System.Windows.Forms.Label
        Me.TxtCallNumber = New System.Windows.Forms.TextBox
        Me.TxtFromDate = New System.Windows.Forms.TextBox
        Me.TxtToDate = New System.Windows.Forms.TextBox
        Me.TxtLocation = New System.Windows.Forms.TextBox
        Me.TxtState = New System.Windows.Forms.TextBox
        Me.TxtPatientFirst = New System.Windows.Forms.TextBox
        Me.TxtPatientLast = New System.Windows.Forms.TextBox
        Me.TxtOrg = New System.Windows.Forms.TextBox
        Me.TxtOrgPerson = New System.Windows.Forms.TextBox
        Me.TxtConsentSource = New System.Windows.Forms.TextBox
        Me.TxtType = New System.Windows.Forms.TextBox
        Me.LstViewPendingConsent = New System.Windows.Forms.ListView
        Me._TabCallType_TabPage4 = New System.Windows.Forms.TabPage
        Me.LstViewSecondaryAlert = New System.Windows.Forms.ListView
        Me.LstViewCallouts = New Stattrac.ListView
        Me.LstViewSecondary = New System.Windows.Forms.ListView
        Me._TabCallType_TabPage5 = New System.Windows.Forms.TabPage
        Me.TxtCallNumberInfo = New System.Windows.Forms.TextBox
        Me.TxtFromDateInfo = New System.Windows.Forms.TextBox
        Me.TxtToDateInfo = New System.Windows.Forms.TextBox
        Me.TxtFirstNameInfo = New System.Windows.Forms.TextBox
        Me.TxtLastNameInfo = New System.Windows.Forms.TextBox
        Me.TxtCoalitionInfo = New System.Windows.Forms.TextBox
        Me.TxtStateInfo = New System.Windows.Forms.TextBox
        Me.TxtSourceInfo = New System.Windows.Forms.TextBox
        Me.LstViewOpenInformation = New System.Windows.Forms.ListView
        Me._TabCallType_TabPage6 = New System.Windows.Forms.TabPage
        Me.LstViewOpenUpdate = New System.Windows.Forms.ListView
        Me.txtTcNameUpdate = New System.Windows.Forms.TextBox
        Me.txtPreRefTypeUpdate = New System.Windows.Forms.TextBox
        Me.txtToTimeUpdate = New System.Windows.Forms.TextBox
        Me.txtFromTimeUpdate = New System.Windows.Forms.TextBox
        Me.txtRefSourceUpdate = New System.Windows.Forms.TextBox
        Me.txtReferralTypeUpdate = New System.Windows.Forms.TextBox
        Me.txtStateUpdate = New System.Windows.Forms.TextBox
        Me.txtLocationUpdate = New System.Windows.Forms.TextBox
        Me.txtPatientLastUpdate = New System.Windows.Forms.TextBox
        Me.txtPatientFirstUpdate = New System.Windows.Forms.TextBox
        Me.txtToDateUpdate = New System.Windows.Forms.TextBox
        Me.txtFromDateUpdate = New System.Windows.Forms.TextBox
        Me.txtCallNumberUpdate = New System.Windows.Forms.TextBox
        Me._TabCallType_TabPage7 = New System.Windows.Forms.TabPage
        Me.txtMsgTxRecycle = New System.Windows.Forms.TextBox
        Me.cmdRestoreMessage = New System.Windows.Forms.Button
        Me.txtCallNumberMsgRecycle = New System.Windows.Forms.TextBox
        Me.txtFromDateMsgRecycle = New System.Windows.Forms.TextBox
        Me.txtToDateMsgRecycle = New System.Windows.Forms.TextBox
        Me.txtForPersonFirstRecycle = New System.Windows.Forms.TextBox
        Me.txtForPersonLastRecycle = New System.Windows.Forms.TextBox
        Me.txtLocationMsgRecycle = New System.Windows.Forms.TextBox
        Me.txtStateMsgRecycle = New System.Windows.Forms.TextBox
        Me.txtMessageTypeRecycle = New System.Windows.Forms.TextBox
        Me.txtMsgSourceRecycle = New System.Windows.Forms.TextBox
        Me.txtMsgFromRecycle = New System.Windows.Forms.TextBox
        Me.CmdRestoreReferral = New System.Windows.Forms.Button
        Me.txtTcNameRecycle = New System.Windows.Forms.TextBox
        Me.txtPreRefTypeRecycle = New System.Windows.Forms.TextBox
        Me.txtToTimeRecycle = New System.Windows.Forms.TextBox
        Me.txtFromTimeRecycle = New System.Windows.Forms.TextBox
        Me.txtRefSourceRecycle = New System.Windows.Forms.TextBox
        Me.txtReferralTypeRecycle = New System.Windows.Forms.TextBox
        Me.txtStateRecycle = New System.Windows.Forms.TextBox
        Me.txtLocationRecycle = New System.Windows.Forms.TextBox
        Me.txtPatientLastRecycle = New System.Windows.Forms.TextBox
        Me.txtPatientFirstRecycle = New System.Windows.Forms.TextBox
        Me.txtToDateRecycle = New System.Windows.Forms.TextBox
        Me.txtFromDateRecycle = New System.Windows.Forms.TextBox
        Me.txtCallNumberRecycle = New System.Windows.Forms.TextBox
        Me.LstViewOpenRecycle = New System.Windows.Forms.ListView
        Me.LstViewOpenMsgRecycle = New System.Windows.Forms.ListView
        Me.Timer_Renamed = New System.Windows.Forms.Timer(Me.components)
        Me.LstViewIncompletes = New System.Windows.Forms.ListView
        Me.ImageList2 = New System.Windows.Forms.ImageList(Me.components)
        Me.Label = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(Me.components)
        Me.contextMenuStrip = New System.Windows.Forms.ContextMenuStrip(Me.components)
        Me.Panel1 = New System.Windows.Forms.FlowLayoutPanel
        Me.TabCallType.SuspendLayout()
        Me._TabCallType_TabPage0.SuspendLayout()
        Me._TabCallType_TabPage1.SuspendLayout()
        Me._TabCallType_TabPage2.SuspendLayout()
        Me._TabCallType_TabPage3.SuspendLayout()
        Me._TabCallType_TabPage4.SuspendLayout()
        Me._TabCallType_TabPage5.SuspendLayout()
        Me._TabCallType_TabPage6.SuspendLayout()
        Me._TabCallType_TabPage7.SuspendLayout()
        CType(Me.Label, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.Panel1.SuspendLayout()
        Me.SuspendLayout()
        '
        'TimerCounter
        '
        Me.TimerCounter.Interval = 500
        '
        'LstViewPendingPage
        '
        Me.LstViewPendingPage.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewPendingPage.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.LstViewPendingPage.Dock = System.Windows.Forms.DockStyle.Left
        Me.LstViewPendingPage.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewPendingPage.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewPendingPage.FullRowSelect = True
        Me.LstViewPendingPage.LabelWrap = False
        Me.LstViewPendingPage.Location = New System.Drawing.Point(3, 3)
        Me.LstViewPendingPage.MaximumSize = New System.Drawing.Size(700, 209)
        Me.LstViewPendingPage.MinimumSize = New System.Drawing.Size(250, 209)
        Me.LstViewPendingPage.Name = "LstViewPendingPage"
        Me.LstViewPendingPage.Size = New System.Drawing.Size(500, 209)
        Me.LstViewPendingPage.SmallImageList = Me.ImageList1
        Me.LstViewPendingPage.TabIndex = 30
        Me.LstViewPendingPage.TabStop = False
        Me.LstViewPendingPage.UseCompatibleStateImageBehavior = False
        Me.LstViewPendingPage.View = System.Windows.Forms.View.Details
        '
        'ImageList1
        '
        Me.ImageList1.ImageStream = CType(resources.GetObject("ImageList1.ImageStream"), System.Windows.Forms.ImageListStreamer)
        Me.ImageList1.TransparentColor = System.Drawing.Color.FromArgb(CType(CType(0, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(0, Byte), Integer))
        Me.ImageList1.Images.SetKeyName(0, "Status1 Small.bmp")
        Me.ImageList1.Images.SetKeyName(1, "Status2 Small.bmp")
        Me.ImageList1.Images.SetKeyName(2, "")
        Me.ImageList1.Images.SetKeyName(3, "")
        Me.ImageList1.Images.SetKeyName(4, "")
        Me.ImageList1.Images.SetKeyName(5, "NoIcon.bmp")
        '
        'LstViewGeneralAlert
        '
        Me.LstViewGeneralAlert.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewGeneralAlert.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.LstViewGeneralAlert.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewGeneralAlert.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewGeneralAlert.FullRowSelect = True
        Me.LstViewGeneralAlert.LabelWrap = False
        Me.LstViewGeneralAlert.Location = New System.Drawing.Point(0, 0)
        Me.LstViewGeneralAlert.Name = "LstViewGeneralAlert"
        Me.LstViewGeneralAlert.Size = New System.Drawing.Size(1184, 97)
        Me.LstViewGeneralAlert.TabIndex = 35
        Me.LstViewGeneralAlert.TabStop = False
        Me.LstViewGeneralAlert.UseCompatibleStateImageBehavior = False
        Me.LstViewGeneralAlert.View = System.Windows.Forms.View.Details
        '
        'CmdClearFilters
        '
        Me.CmdClearFilters.BackColor = System.Drawing.SystemColors.Control
        Me.CmdClearFilters.CausesValidation = False
        Me.CmdClearFilters.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdClearFilters.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdClearFilters.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdClearFilters.Location = New System.Drawing.Point(817, 315)
        Me.CmdClearFilters.Name = "CmdClearFilters"
        Me.CmdClearFilters.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdClearFilters.Size = New System.Drawing.Size(71, 21)
        Me.CmdClearFilters.TabIndex = 34
        Me.CmdClearFilters.TabStop = False
        Me.CmdClearFilters.Text = "&Clear Filters"
        Me.CmdClearFilters.UseVisualStyleBackColor = False
        '
        'CmdLineCheck
        '
        Me.CmdLineCheck.BackColor = System.Drawing.SystemColors.Control
        Me.CmdLineCheck.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdLineCheck.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdLineCheck.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdLineCheck.Location = New System.Drawing.Point(891, 315)
        Me.CmdLineCheck.Name = "CmdLineCheck"
        Me.CmdLineCheck.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdLineCheck.Size = New System.Drawing.Size(71, 21)
        Me.CmdLineCheck.TabIndex = 119
        Me.CmdLineCheck.Text = "&Line Check"
        Me.CmdLineCheck.UseVisualStyleBackColor = False
        Me.CmdLineCheck.Visible = False
        '
        'CmdNewCall
        '
        Me.CmdNewCall.BackColor = System.Drawing.SystemColors.Control
        Me.CmdNewCall.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdNewCall.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdNewCall.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdNewCall.Location = New System.Drawing.Point(742, 315)
        Me.CmdNewCall.Name = "CmdNewCall"
        Me.CmdNewCall.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdNewCall.Size = New System.Drawing.Size(71, 21)
        Me.CmdNewCall.TabIndex = 33
        Me.CmdNewCall.TabStop = False
        Me.CmdNewCall.Text = "&New Call"
        Me.CmdNewCall.UseVisualStyleBackColor = False
        '
        'CmdRefresh
        '
        Me.CmdRefresh.BackColor = System.Drawing.SystemColors.Control
        Me.CmdRefresh.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdRefresh.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdRefresh.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdRefresh.Location = New System.Drawing.Point(668, 315)
        Me.CmdRefresh.Name = "CmdRefresh"
        Me.CmdRefresh.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdRefresh.Size = New System.Drawing.Size(71, 21)
        Me.CmdRefresh.TabIndex = 32
        Me.CmdRefresh.TabStop = False
        Me.CmdRefresh.Text = "&Refresh"
        Me.CmdRefresh.UseVisualStyleBackColor = False
        '
        'TabCallType
        '
        Me.TabCallType.Controls.Add(Me._TabCallType_TabPage0)
        Me.TabCallType.Controls.Add(Me._TabCallType_TabPage1)
        Me.TabCallType.Controls.Add(Me._TabCallType_TabPage2)
        Me.TabCallType.Controls.Add(Me._TabCallType_TabPage3)
        Me.TabCallType.Controls.Add(Me._TabCallType_TabPage4)
        Me.TabCallType.Controls.Add(Me._TabCallType_TabPage5)
        Me.TabCallType.Controls.Add(Me._TabCallType_TabPage6)
        Me.TabCallType.Controls.Add(Me._TabCallType_TabPage7)
        Me.TabCallType.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TabCallType.ItemSize = New System.Drawing.Size(42, 21)
        Me.TabCallType.Location = New System.Drawing.Point(0, 312)
        Me.TabCallType.Name = "TabCallType"
        Me.TabCallType.SelectedIndex = 6
        Me.TabCallType.Size = New System.Drawing.Size(1083, 263)
        Me.TabCallType.TabIndex = 31
        '
        '_TabCallType_TabPage0
        '
        Me._TabCallType_TabPage0.Controls.Add(Me.LblCountRef)
        Me._TabCallType_TabPage0.Controls.Add(Me._Label_0)
        Me._TabCallType_TabPage0.Controls.Add(Me.TxtCallNumberRef)
        Me._TabCallType_TabPage0.Controls.Add(Me.TxtFromDateRef)
        Me._TabCallType_TabPage0.Controls.Add(Me.TxtToDateRef)
        Me._TabCallType_TabPage0.Controls.Add(Me.TxtPatientFirstRef)
        Me._TabCallType_TabPage0.Controls.Add(Me.TxtPatientLastRef)
        Me._TabCallType_TabPage0.Controls.Add(Me.TxtLocationRef)
        Me._TabCallType_TabPage0.Controls.Add(Me.TxtStateRef)
        Me._TabCallType_TabPage0.Controls.Add(Me.TxtReferralType)
        Me._TabCallType_TabPage0.Controls.Add(Me.TxtRefSource)
        Me._TabCallType_TabPage0.Controls.Add(Me.LstViewOpenReferral)
        Me._TabCallType_TabPage0.Controls.Add(Me.CmdDeleteRef)
        Me._TabCallType_TabPage0.Controls.Add(Me.TxtFromTimeRef)
        Me._TabCallType_TabPage0.Controls.Add(Me.TxtToTimeRef)
        Me._TabCallType_TabPage0.Controls.Add(Me.Command1)
        Me._TabCallType_TabPage0.Controls.Add(Me.txtPreRefType)
        Me._TabCallType_TabPage0.Controls.Add(Me.txtTcNameRef)
        Me._TabCallType_TabPage0.Location = New System.Drawing.Point(4, 25)
        Me._TabCallType_TabPage0.Name = "_TabCallType_TabPage0"
        Me._TabCallType_TabPage0.Size = New System.Drawing.Size(1075, 234)
        Me._TabCallType_TabPage0.TabIndex = 0
        Me._TabCallType_TabPage0.Text = "Referrals (F1) "
        '
        'LblCountRef
        '
        Me.LblCountRef.BackColor = System.Drawing.SystemColors.Control
        Me.LblCountRef.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblCountRef.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblCountRef.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblCountRef.Location = New System.Drawing.Point(1040, 26)
        Me.LblCountRef.Name = "LblCountRef"
        Me.LblCountRef.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblCountRef.Size = New System.Drawing.Size(35, 17)
        Me.LblCountRef.TabIndex = 50
        Me.LblCountRef.Text = "00000"
        '
        '_Label_0
        '
        Me._Label_0.BackColor = System.Drawing.SystemColors.Control
        Me._Label_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_0, CType(0, Short))
        Me._Label_0.Location = New System.Drawing.Point(1000, 26)
        Me._Label_0.Name = "_Label_0"
        Me._Label_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_0.Size = New System.Drawing.Size(35, 13)
        Me._Label_0.TabIndex = 51
        Me._Label_0.Text = "Count:"
        '
        'TxtCallNumberRef
        '
        Me.TxtCallNumberRef.AcceptsReturn = True
        Me.TxtCallNumberRef.BackColor = System.Drawing.SystemColors.Window
        Me.TxtCallNumberRef.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtCallNumberRef.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtCallNumberRef.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtCallNumberRef.Location = New System.Drawing.Point(2, 25)
        Me.TxtCallNumberRef.MaxLength = 0
        Me.TxtCallNumberRef.Name = "TxtCallNumberRef"
        Me.TxtCallNumberRef.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtCallNumberRef.Size = New System.Drawing.Size(83, 20)
        Me.TxtCallNumberRef.TabIndex = 0
        '
        'TxtFromDateRef
        '
        Me.TxtFromDateRef.AcceptsReturn = True
        Me.TxtFromDateRef.BackColor = System.Drawing.SystemColors.Window
        Me.TxtFromDateRef.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtFromDateRef.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtFromDateRef.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtFromDateRef.Location = New System.Drawing.Point(85, 25)
        Me.TxtFromDateRef.MaxLength = 0
        Me.TxtFromDateRef.Name = "TxtFromDateRef"
        Me.TxtFromDateRef.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtFromDateRef.Size = New System.Drawing.Size(57, 20)
        Me.TxtFromDateRef.TabIndex = 1
        '
        'TxtToDateRef
        '
        Me.TxtToDateRef.AcceptsReturn = True
        Me.TxtToDateRef.BackColor = System.Drawing.SystemColors.Window
        Me.TxtToDateRef.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtToDateRef.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtToDateRef.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtToDateRef.Location = New System.Drawing.Point(177, 25)
        Me.TxtToDateRef.MaxLength = 0
        Me.TxtToDateRef.Name = "TxtToDateRef"
        Me.TxtToDateRef.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtToDateRef.Size = New System.Drawing.Size(55, 20)
        Me.TxtToDateRef.TabIndex = 2
        '
        'TxtPatientFirstRef
        '
        Me.TxtPatientFirstRef.AcceptsReturn = True
        Me.TxtPatientFirstRef.BackColor = System.Drawing.SystemColors.Window
        Me.TxtPatientFirstRef.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtPatientFirstRef.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtPatientFirstRef.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtPatientFirstRef.Location = New System.Drawing.Point(266, 25)
        Me.TxtPatientFirstRef.MaxLength = 0
        Me.TxtPatientFirstRef.Name = "TxtPatientFirstRef"
        Me.TxtPatientFirstRef.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtPatientFirstRef.Size = New System.Drawing.Size(55, 20)
        Me.TxtPatientFirstRef.TabIndex = 3
        '
        'TxtPatientLastRef
        '
        Me.TxtPatientLastRef.AcceptsReturn = True
        Me.TxtPatientLastRef.BackColor = System.Drawing.SystemColors.Window
        Me.TxtPatientLastRef.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtPatientLastRef.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtPatientLastRef.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtPatientLastRef.Location = New System.Drawing.Point(321, 25)
        Me.TxtPatientLastRef.MaxLength = 0
        Me.TxtPatientLastRef.Name = "TxtPatientLastRef"
        Me.TxtPatientLastRef.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtPatientLastRef.Size = New System.Drawing.Size(55, 20)
        Me.TxtPatientLastRef.TabIndex = 4
        '
        'TxtLocationRef
        '
        Me.TxtLocationRef.AcceptsReturn = True
        Me.TxtLocationRef.BackColor = System.Drawing.SystemColors.Window
        Me.TxtLocationRef.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtLocationRef.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtLocationRef.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtLocationRef.Location = New System.Drawing.Point(376, 25)
        Me.TxtLocationRef.MaxLength = 0
        Me.TxtLocationRef.Name = "TxtLocationRef"
        Me.TxtLocationRef.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtLocationRef.Size = New System.Drawing.Size(134, 20)
        Me.TxtLocationRef.TabIndex = 5
        '
        'TxtStateRef
        '
        Me.TxtStateRef.AcceptsReturn = True
        Me.TxtStateRef.BackColor = System.Drawing.SystemColors.Window
        Me.TxtStateRef.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtStateRef.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtStateRef.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtStateRef.Location = New System.Drawing.Point(509, 25)
        Me.TxtStateRef.MaxLength = 0
        Me.TxtStateRef.Name = "TxtStateRef"
        Me.TxtStateRef.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtStateRef.Size = New System.Drawing.Size(24, 20)
        Me.TxtStateRef.TabIndex = 6
        '
        'TxtReferralType
        '
        Me.TxtReferralType.AcceptsReturn = True
        Me.TxtReferralType.BackColor = System.Drawing.SystemColors.Window
        Me.TxtReferralType.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtReferralType.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtReferralType.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtReferralType.Location = New System.Drawing.Point(619, 25)
        Me.TxtReferralType.MaxLength = 0
        Me.TxtReferralType.Name = "TxtReferralType"
        Me.TxtReferralType.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtReferralType.Size = New System.Drawing.Size(67, 20)
        Me.TxtReferralType.TabIndex = 8
        '
        'TxtRefSource
        '
        Me.TxtRefSource.AcceptsReturn = True
        Me.TxtRefSource.BackColor = System.Drawing.SystemColors.Window
        Me.TxtRefSource.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtRefSource.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtRefSource.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtRefSource.Location = New System.Drawing.Point(686, 25)
        Me.TxtRefSource.MaxLength = 0
        Me.TxtRefSource.Name = "TxtRefSource"
        Me.TxtRefSource.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtRefSource.Size = New System.Drawing.Size(54, 20)
        Me.TxtRefSource.TabIndex = 9
        '
        'LstViewOpenReferral
        '
        Me.LstViewOpenReferral.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewOpenReferral.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.LstViewOpenReferral.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewOpenReferral.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewOpenReferral.FullRowSelect = True
        Me.LstViewOpenReferral.LabelWrap = False
        Me.LstViewOpenReferral.Location = New System.Drawing.Point(0, 47)
        Me.LstViewOpenReferral.Name = "LstViewOpenReferral"
        Me.LstViewOpenReferral.Size = New System.Drawing.Size(839, 187)
        Me.LstViewOpenReferral.TabIndex = 11
        Me.LstViewOpenReferral.UseCompatibleStateImageBehavior = False
        Me.LstViewOpenReferral.View = System.Windows.Forms.View.Details
        '
        'CmdDeleteRef
        '
        Me.CmdDeleteRef.BackColor = System.Drawing.SystemColors.Control
        Me.CmdDeleteRef.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdDeleteRef.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdDeleteRef.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdDeleteRef.Location = New System.Drawing.Point(920, 25)
        Me.CmdDeleteRef.Name = "CmdDeleteRef"
        Me.CmdDeleteRef.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdDeleteRef.Size = New System.Drawing.Size(81, 19)
        Me.CmdDeleteRef.TabIndex = 49
        Me.CmdDeleteRef.TabStop = False
        Me.CmdDeleteRef.Text = "Delete Call"
        Me.CmdDeleteRef.UseVisualStyleBackColor = False
        '
        'TxtFromTimeRef
        '
        Me.TxtFromTimeRef.AcceptsReturn = True
        Me.TxtFromTimeRef.BackColor = System.Drawing.SystemColors.Window
        Me.TxtFromTimeRef.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtFromTimeRef.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtFromTimeRef.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtFromTimeRef.Location = New System.Drawing.Point(142, 25)
        Me.TxtFromTimeRef.MaxLength = 0
        Me.TxtFromTimeRef.Name = "TxtFromTimeRef"
        Me.TxtFromTimeRef.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtFromTimeRef.Size = New System.Drawing.Size(35, 20)
        Me.TxtFromTimeRef.TabIndex = 63
        '
        'TxtToTimeRef
        '
        Me.TxtToTimeRef.AcceptsReturn = True
        Me.TxtToTimeRef.BackColor = System.Drawing.SystemColors.Window
        Me.TxtToTimeRef.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtToTimeRef.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtToTimeRef.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtToTimeRef.Location = New System.Drawing.Point(232, 25)
        Me.TxtToTimeRef.MaxLength = 0
        Me.TxtToTimeRef.Name = "TxtToTimeRef"
        Me.TxtToTimeRef.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtToTimeRef.Size = New System.Drawing.Size(35, 20)
        Me.TxtToTimeRef.TabIndex = 64
        '
        'Command1
        '
        Me.Command1.BackColor = System.Drawing.SystemColors.Control
        Me.Command1.Cursor = System.Windows.Forms.Cursors.Default
        Me.Command1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Command1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Command1.Location = New System.Drawing.Point(845, 19)
        Me.Command1.Name = "Command1"
        Me.Command1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Command1.Size = New System.Drawing.Size(81, 25)
        Me.Command1.TabIndex = 65
        Me.Command1.Text = "Disposition"
        Me.Command1.UseVisualStyleBackColor = False
        Me.Command1.Visible = False
        '
        'txtPreRefType
        '
        Me.txtPreRefType.AcceptsReturn = True
        Me.txtPreRefType.BackColor = System.Drawing.SystemColors.Window
        Me.txtPreRefType.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtPreRefType.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtPreRefType.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtPreRefType.Location = New System.Drawing.Point(533, 25)
        Me.txtPreRefType.MaxLength = 0
        Me.txtPreRefType.Name = "txtPreRefType"
        Me.txtPreRefType.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtPreRefType.Size = New System.Drawing.Size(87, 20)
        Me.txtPreRefType.TabIndex = 7
        '
        'txtTcNameRef
        '
        Me.txtTcNameRef.AcceptsReturn = True
        Me.txtTcNameRef.BackColor = System.Drawing.SystemColors.Window
        Me.txtTcNameRef.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtTcNameRef.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtTcNameRef.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtTcNameRef.Location = New System.Drawing.Point(739, 25)
        Me.txtTcNameRef.MaxLength = 0
        Me.txtTcNameRef.Name = "txtTcNameRef"
        Me.txtTcNameRef.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtTcNameRef.Size = New System.Drawing.Size(100, 20)
        Me.txtTcNameRef.TabIndex = 10
        '
        '_TabCallType_TabPage1
        '
        Me._TabCallType_TabPage1.Controls.Add(Me.LblCountMsg)
        Me._TabCallType_TabPage1.Controls.Add(Me._Label_1)
        Me._TabCallType_TabPage1.Controls.Add(Me.TxtCallNumberMsg)
        Me._TabCallType_TabPage1.Controls.Add(Me.TxtFromDateMsg)
        Me._TabCallType_TabPage1.Controls.Add(Me.TxtToDateMsg)
        Me._TabCallType_TabPage1.Controls.Add(Me.TxtForPersonFirst)
        Me._TabCallType_TabPage1.Controls.Add(Me.TxtForPersonLast)
        Me._TabCallType_TabPage1.Controls.Add(Me.TxtLocationMsg)
        Me._TabCallType_TabPage1.Controls.Add(Me.TxtStateMsg)
        Me._TabCallType_TabPage1.Controls.Add(Me.TxtMessageType)
        Me._TabCallType_TabPage1.Controls.Add(Me.TxtMsgSource)
        Me._TabCallType_TabPage1.Controls.Add(Me.LstViewOpenMessage)
        Me._TabCallType_TabPage1.Controls.Add(Me.TxtMsgFrom)
        Me._TabCallType_TabPage1.Controls.Add(Me.CmdDeleteMsg)
        Me._TabCallType_TabPage1.Controls.Add(Me.TxtMsgTx)
        Me._TabCallType_TabPage1.Location = New System.Drawing.Point(4, 25)
        Me._TabCallType_TabPage1.Name = "_TabCallType_TabPage1"
        Me._TabCallType_TabPage1.Size = New System.Drawing.Size(1075, 234)
        Me._TabCallType_TabPage1.TabIndex = 1
        Me._TabCallType_TabPage1.Text = "Msgs (F2) "
        '
        'LblCountMsg
        '
        Me.LblCountMsg.BackColor = System.Drawing.SystemColors.Control
        Me.LblCountMsg.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblCountMsg.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblCountMsg.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblCountMsg.Location = New System.Drawing.Point(1040, 26)
        Me.LblCountMsg.Name = "LblCountMsg"
        Me.LblCountMsg.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblCountMsg.Size = New System.Drawing.Size(33, 17)
        Me.LblCountMsg.TabIndex = 53
        Me.LblCountMsg.Text = "00000"
        '
        '_Label_1
        '
        Me._Label_1.BackColor = System.Drawing.SystemColors.Control
        Me._Label_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_1, CType(1, Short))
        Me._Label_1.Location = New System.Drawing.Point(1000, 26)
        Me._Label_1.Name = "_Label_1"
        Me._Label_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_1.Size = New System.Drawing.Size(35, 13)
        Me._Label_1.TabIndex = 54
        Me._Label_1.Text = "Count:"
        '
        'TxtCallNumberMsg
        '
        Me.TxtCallNumberMsg.AcceptsReturn = True
        Me.TxtCallNumberMsg.BackColor = System.Drawing.SystemColors.Window
        Me.TxtCallNumberMsg.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtCallNumberMsg.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtCallNumberMsg.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtCallNumberMsg.Location = New System.Drawing.Point(2, 25)
        Me.TxtCallNumberMsg.MaxLength = 0
        Me.TxtCallNumberMsg.Name = "TxtCallNumberMsg"
        Me.TxtCallNumberMsg.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtCallNumberMsg.Size = New System.Drawing.Size(79, 20)
        Me.TxtCallNumberMsg.TabIndex = 12
        '
        'TxtFromDateMsg
        '
        Me.TxtFromDateMsg.AcceptsReturn = True
        Me.TxtFromDateMsg.BackColor = System.Drawing.SystemColors.Window
        Me.TxtFromDateMsg.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtFromDateMsg.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtFromDateMsg.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtFromDateMsg.Location = New System.Drawing.Point(80, 25)
        Me.TxtFromDateMsg.MaxLength = 0
        Me.TxtFromDateMsg.Name = "TxtFromDateMsg"
        Me.TxtFromDateMsg.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtFromDateMsg.Size = New System.Drawing.Size(57, 20)
        Me.TxtFromDateMsg.TabIndex = 13
        '
        'TxtToDateMsg
        '
        Me.TxtToDateMsg.AcceptsReturn = True
        Me.TxtToDateMsg.BackColor = System.Drawing.SystemColors.Window
        Me.TxtToDateMsg.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtToDateMsg.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtToDateMsg.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtToDateMsg.Location = New System.Drawing.Point(134, 25)
        Me.TxtToDateMsg.MaxLength = 0
        Me.TxtToDateMsg.Name = "TxtToDateMsg"
        Me.TxtToDateMsg.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtToDateMsg.Size = New System.Drawing.Size(55, 20)
        Me.TxtToDateMsg.TabIndex = 14
        '
        'TxtForPersonFirst
        '
        Me.TxtForPersonFirst.AcceptsReturn = True
        Me.TxtForPersonFirst.BackColor = System.Drawing.SystemColors.Window
        Me.TxtForPersonFirst.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtForPersonFirst.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtForPersonFirst.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtForPersonFirst.Location = New System.Drawing.Point(187, 25)
        Me.TxtForPersonFirst.MaxLength = 0
        Me.TxtForPersonFirst.Name = "TxtForPersonFirst"
        Me.TxtForPersonFirst.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtForPersonFirst.Size = New System.Drawing.Size(55, 20)
        Me.TxtForPersonFirst.TabIndex = 15
        '
        'TxtForPersonLast
        '
        Me.TxtForPersonLast.AcceptsReturn = True
        Me.TxtForPersonLast.BackColor = System.Drawing.SystemColors.Window
        Me.TxtForPersonLast.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtForPersonLast.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtForPersonLast.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtForPersonLast.Location = New System.Drawing.Point(240, 25)
        Me.TxtForPersonLast.MaxLength = 0
        Me.TxtForPersonLast.Name = "TxtForPersonLast"
        Me.TxtForPersonLast.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtForPersonLast.Size = New System.Drawing.Size(55, 20)
        Me.TxtForPersonLast.TabIndex = 16
        '
        'TxtLocationMsg
        '
        Me.TxtLocationMsg.AcceptsReturn = True
        Me.TxtLocationMsg.BackColor = System.Drawing.SystemColors.Window
        Me.TxtLocationMsg.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtLocationMsg.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtLocationMsg.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtLocationMsg.Location = New System.Drawing.Point(292, 25)
        Me.TxtLocationMsg.MaxLength = 0
        Me.TxtLocationMsg.Name = "TxtLocationMsg"
        Me.TxtLocationMsg.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtLocationMsg.Size = New System.Drawing.Size(201, 20)
        Me.TxtLocationMsg.TabIndex = 17
        '
        'TxtStateMsg
        '
        Me.TxtStateMsg.AcceptsReturn = True
        Me.TxtStateMsg.BackColor = System.Drawing.SystemColors.Window
        Me.TxtStateMsg.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtStateMsg.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtStateMsg.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtStateMsg.Location = New System.Drawing.Point(490, 25)
        Me.TxtStateMsg.MaxLength = 0
        Me.TxtStateMsg.Name = "TxtStateMsg"
        Me.TxtStateMsg.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtStateMsg.Size = New System.Drawing.Size(29, 20)
        Me.TxtStateMsg.TabIndex = 18
        '
        'TxtMessageType
        '
        Me.TxtMessageType.AcceptsReturn = True
        Me.TxtMessageType.BackColor = System.Drawing.SystemColors.Window
        Me.TxtMessageType.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtMessageType.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtMessageType.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtMessageType.Location = New System.Drawing.Point(516, 25)
        Me.TxtMessageType.MaxLength = 0
        Me.TxtMessageType.Name = "TxtMessageType"
        Me.TxtMessageType.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtMessageType.Size = New System.Drawing.Size(109, 20)
        Me.TxtMessageType.TabIndex = 19
        '
        'TxtMsgSource
        '
        Me.TxtMsgSource.AcceptsReturn = True
        Me.TxtMsgSource.BackColor = System.Drawing.SystemColors.Window
        Me.TxtMsgSource.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtMsgSource.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtMsgSource.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtMsgSource.Location = New System.Drawing.Point(624, 25)
        Me.TxtMsgSource.MaxLength = 0
        Me.TxtMsgSource.Name = "TxtMsgSource"
        Me.TxtMsgSource.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtMsgSource.Size = New System.Drawing.Size(71, 20)
        Me.TxtMsgSource.TabIndex = 20
        '
        'LstViewOpenMessage
        '
        Me.LstViewOpenMessage.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewOpenMessage.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.LstViewOpenMessage.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewOpenMessage.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewOpenMessage.FullRowSelect = True
        Me.LstViewOpenMessage.HideSelection = False
        Me.LstViewOpenMessage.LabelWrap = False
        Me.LstViewOpenMessage.Location = New System.Drawing.Point(2, 47)
        Me.LstViewOpenMessage.Name = "LstViewOpenMessage"
        Me.LstViewOpenMessage.Size = New System.Drawing.Size(795, 187)
        Me.LstViewOpenMessage.SmallImageList = Me.ImageList1
        Me.LstViewOpenMessage.TabIndex = 22
        Me.LstViewOpenMessage.UseCompatibleStateImageBehavior = False
        Me.LstViewOpenMessage.View = System.Windows.Forms.View.Details
        '
        'TxtMsgFrom
        '
        Me.TxtMsgFrom.AcceptsReturn = True
        Me.TxtMsgFrom.BackColor = System.Drawing.SystemColors.Window
        Me.TxtMsgFrom.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtMsgFrom.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtMsgFrom.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtMsgFrom.Location = New System.Drawing.Point(695, 25)
        Me.TxtMsgFrom.MaxLength = 0
        Me.TxtMsgFrom.Name = "TxtMsgFrom"
        Me.TxtMsgFrom.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtMsgFrom.Size = New System.Drawing.Size(51, 20)
        Me.TxtMsgFrom.TabIndex = 21
        '
        'CmdDeleteMsg
        '
        Me.CmdDeleteMsg.BackColor = System.Drawing.SystemColors.Control
        Me.CmdDeleteMsg.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdDeleteMsg.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdDeleteMsg.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdDeleteMsg.Location = New System.Drawing.Point(912, 24)
        Me.CmdDeleteMsg.Name = "CmdDeleteMsg"
        Me.CmdDeleteMsg.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdDeleteMsg.Size = New System.Drawing.Size(81, 19)
        Me.CmdDeleteMsg.TabIndex = 52
        Me.CmdDeleteMsg.TabStop = False
        Me.CmdDeleteMsg.Text = "Delete Call"
        Me.CmdDeleteMsg.UseVisualStyleBackColor = False
        '
        'TxtMsgTx
        '
        Me.TxtMsgTx.AcceptsReturn = True
        Me.TxtMsgTx.BackColor = System.Drawing.SystemColors.Window
        Me.TxtMsgTx.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtMsgTx.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtMsgTx.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtMsgTx.Location = New System.Drawing.Point(746, 25)
        Me.TxtMsgTx.MaxLength = 0
        Me.TxtMsgTx.Name = "TxtMsgTx"
        Me.TxtMsgTx.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtMsgTx.Size = New System.Drawing.Size(51, 20)
        Me.TxtMsgTx.TabIndex = 75
        '
        '_TabCallType_TabPage2
        '
        Me._TabCallType_TabPage2.Controls.Add(Me.CmdDeleteNC)
        Me._TabCallType_TabPage2.Controls.Add(Me.LstViewOpenNoCall)
        Me._TabCallType_TabPage2.Controls.Add(Me.TxtNoCallSource)
        Me._TabCallType_TabPage2.Controls.Add(Me.TxtDescription)
        Me._TabCallType_TabPage2.Controls.Add(Me.TxtNoCallType)
        Me._TabCallType_TabPage2.Controls.Add(Me.TxtToDateNC)
        Me._TabCallType_TabPage2.Controls.Add(Me.TxtFromDateNC)
        Me._TabCallType_TabPage2.Controls.Add(Me.TxtCallNumberNC)
        Me._TabCallType_TabPage2.Controls.Add(Me._Label_2)
        Me._TabCallType_TabPage2.Controls.Add(Me.LblCountNoCall)
        Me._TabCallType_TabPage2.Location = New System.Drawing.Point(4, 25)
        Me._TabCallType_TabPage2.Name = "_TabCallType_TabPage2"
        Me._TabCallType_TabPage2.Size = New System.Drawing.Size(1075, 234)
        Me._TabCallType_TabPage2.TabIndex = 2
        Me._TabCallType_TabPage2.Text = "No Calls (F3) "
        '
        'CmdDeleteNC
        '
        Me.CmdDeleteNC.BackColor = System.Drawing.SystemColors.Control
        Me.CmdDeleteNC.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdDeleteNC.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdDeleteNC.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdDeleteNC.Location = New System.Drawing.Point(912, 24)
        Me.CmdDeleteNC.Name = "CmdDeleteNC"
        Me.CmdDeleteNC.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdDeleteNC.Size = New System.Drawing.Size(81, 19)
        Me.CmdDeleteNC.TabIndex = 55
        Me.CmdDeleteNC.TabStop = False
        Me.CmdDeleteNC.Text = "Delete Call"
        Me.CmdDeleteNC.UseVisualStyleBackColor = False
        '
        'LstViewOpenNoCall
        '
        Me.LstViewOpenNoCall.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewOpenNoCall.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.LstViewOpenNoCall.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewOpenNoCall.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewOpenNoCall.FullRowSelect = True
        Me.LstViewOpenNoCall.LabelWrap = False
        Me.LstViewOpenNoCall.Location = New System.Drawing.Point(2, 47)
        Me.LstViewOpenNoCall.Name = "LstViewOpenNoCall"
        Me.LstViewOpenNoCall.Size = New System.Drawing.Size(781, 187)
        Me.LstViewOpenNoCall.TabIndex = 29
        Me.LstViewOpenNoCall.UseCompatibleStateImageBehavior = False
        Me.LstViewOpenNoCall.View = System.Windows.Forms.View.Details
        '
        'TxtNoCallSource
        '
        Me.TxtNoCallSource.AcceptsReturn = True
        Me.TxtNoCallSource.BackColor = System.Drawing.SystemColors.Window
        Me.TxtNoCallSource.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtNoCallSource.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtNoCallSource.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtNoCallSource.Location = New System.Drawing.Point(524, 25)
        Me.TxtNoCallSource.MaxLength = 0
        Me.TxtNoCallSource.Name = "TxtNoCallSource"
        Me.TxtNoCallSource.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtNoCallSource.Size = New System.Drawing.Size(87, 20)
        Me.TxtNoCallSource.TabIndex = 28
        '
        'TxtDescription
        '
        Me.TxtDescription.AcceptsReturn = True
        Me.TxtDescription.BackColor = System.Drawing.SystemColors.Window
        Me.TxtDescription.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtDescription.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtDescription.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtDescription.Location = New System.Drawing.Point(296, 25)
        Me.TxtDescription.MaxLength = 0
        Me.TxtDescription.Name = "TxtDescription"
        Me.TxtDescription.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtDescription.Size = New System.Drawing.Size(229, 20)
        Me.TxtDescription.TabIndex = 27
        '
        'TxtNoCallType
        '
        Me.TxtNoCallType.AcceptsReturn = True
        Me.TxtNoCallType.BackColor = System.Drawing.SystemColors.Window
        Me.TxtNoCallType.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtNoCallType.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtNoCallType.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtNoCallType.Location = New System.Drawing.Point(191, 25)
        Me.TxtNoCallType.MaxLength = 0
        Me.TxtNoCallType.Name = "TxtNoCallType"
        Me.TxtNoCallType.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtNoCallType.Size = New System.Drawing.Size(107, 20)
        Me.TxtNoCallType.TabIndex = 26
        '
        'TxtToDateNC
        '
        Me.TxtToDateNC.AcceptsReturn = True
        Me.TxtToDateNC.BackColor = System.Drawing.SystemColors.Window
        Me.TxtToDateNC.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtToDateNC.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtToDateNC.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtToDateNC.Location = New System.Drawing.Point(138, 25)
        Me.TxtToDateNC.MaxLength = 0
        Me.TxtToDateNC.Name = "TxtToDateNC"
        Me.TxtToDateNC.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtToDateNC.Size = New System.Drawing.Size(55, 20)
        Me.TxtToDateNC.TabIndex = 25
        '
        'TxtFromDateNC
        '
        Me.TxtFromDateNC.AcceptsReturn = True
        Me.TxtFromDateNC.BackColor = System.Drawing.SystemColors.Window
        Me.TxtFromDateNC.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtFromDateNC.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtFromDateNC.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtFromDateNC.Location = New System.Drawing.Point(84, 25)
        Me.TxtFromDateNC.MaxLength = 0
        Me.TxtFromDateNC.Name = "TxtFromDateNC"
        Me.TxtFromDateNC.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtFromDateNC.Size = New System.Drawing.Size(57, 20)
        Me.TxtFromDateNC.TabIndex = 24
        '
        'TxtCallNumberNC
        '
        Me.TxtCallNumberNC.AcceptsReturn = True
        Me.TxtCallNumberNC.BackColor = System.Drawing.SystemColors.Window
        Me.TxtCallNumberNC.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtCallNumberNC.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtCallNumberNC.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtCallNumberNC.Location = New System.Drawing.Point(2, 25)
        Me.TxtCallNumberNC.MaxLength = 0
        Me.TxtCallNumberNC.Name = "TxtCallNumberNC"
        Me.TxtCallNumberNC.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtCallNumberNC.Size = New System.Drawing.Size(83, 20)
        Me.TxtCallNumberNC.TabIndex = 23
        '
        '_Label_2
        '
        Me._Label_2.BackColor = System.Drawing.SystemColors.Control
        Me._Label_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_2, CType(2, Short))
        Me._Label_2.Location = New System.Drawing.Point(1000, 26)
        Me._Label_2.Name = "_Label_2"
        Me._Label_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_2.Size = New System.Drawing.Size(35, 13)
        Me._Label_2.TabIndex = 57
        Me._Label_2.Text = "Count:"
        '
        'LblCountNoCall
        '
        Me.LblCountNoCall.BackColor = System.Drawing.SystemColors.Control
        Me.LblCountNoCall.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblCountNoCall.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblCountNoCall.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblCountNoCall.Location = New System.Drawing.Point(1040, 26)
        Me.LblCountNoCall.Name = "LblCountNoCall"
        Me.LblCountNoCall.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblCountNoCall.Size = New System.Drawing.Size(35, 13)
        Me.LblCountNoCall.TabIndex = 56
        Me.LblCountNoCall.Text = "00000"
        '
        '_TabCallType_TabPage3
        '
        Me._TabCallType_TabPage3.Controls.Add(Me._Label_3)
        Me._TabCallType_TabPage3.Controls.Add(Me.LblCountConsent)
        Me._TabCallType_TabPage3.Controls.Add(Me.TxtCallNumber)
        Me._TabCallType_TabPage3.Controls.Add(Me.TxtFromDate)
        Me._TabCallType_TabPage3.Controls.Add(Me.TxtToDate)
        Me._TabCallType_TabPage3.Controls.Add(Me.TxtLocation)
        Me._TabCallType_TabPage3.Controls.Add(Me.TxtState)
        Me._TabCallType_TabPage3.Controls.Add(Me.TxtPatientFirst)
        Me._TabCallType_TabPage3.Controls.Add(Me.TxtPatientLast)
        Me._TabCallType_TabPage3.Controls.Add(Me.TxtOrg)
        Me._TabCallType_TabPage3.Controls.Add(Me.TxtOrgPerson)
        Me._TabCallType_TabPage3.Controls.Add(Me.TxtConsentSource)
        Me._TabCallType_TabPage3.Controls.Add(Me.TxtType)
        Me._TabCallType_TabPage3.Controls.Add(Me.LstViewPendingConsent)
        Me._TabCallType_TabPage3.Location = New System.Drawing.Point(4, 25)
        Me._TabCallType_TabPage3.Name = "_TabCallType_TabPage3"
        Me._TabCallType_TabPage3.Size = New System.Drawing.Size(1075, 234)
        Me._TabCallType_TabPage3.TabIndex = 3
        Me._TabCallType_TabPage3.Text = "Consents Pending (F4) "
        '
        '_Label_3
        '
        Me._Label_3.BackColor = System.Drawing.SystemColors.Control
        Me._Label_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_3.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_3, CType(3, Short))
        Me._Label_3.Location = New System.Drawing.Point(886, 26)
        Me._Label_3.Name = "_Label_3"
        Me._Label_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_3.Size = New System.Drawing.Size(35, 13)
        Me._Label_3.TabIndex = 58
        Me._Label_3.Text = "Count:"
        '
        'LblCountConsent
        '
        Me.LblCountConsent.BackColor = System.Drawing.SystemColors.Control
        Me.LblCountConsent.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblCountConsent.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblCountConsent.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblCountConsent.Location = New System.Drawing.Point(922, 26)
        Me.LblCountConsent.Name = "LblCountConsent"
        Me.LblCountConsent.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblCountConsent.Size = New System.Drawing.Size(35, 17)
        Me.LblCountConsent.TabIndex = 59
        Me.LblCountConsent.Text = "00000"
        '
        'TxtCallNumber
        '
        Me.TxtCallNumber.AcceptsReturn = True
        Me.TxtCallNumber.BackColor = System.Drawing.SystemColors.Window
        Me.TxtCallNumber.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtCallNumber.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtCallNumber.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtCallNumber.Location = New System.Drawing.Point(24, 25)
        Me.TxtCallNumber.MaxLength = 0
        Me.TxtCallNumber.Name = "TxtCallNumber"
        Me.TxtCallNumber.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtCallNumber.Size = New System.Drawing.Size(83, 20)
        Me.TxtCallNumber.TabIndex = 46
        '
        'TxtFromDate
        '
        Me.TxtFromDate.AcceptsReturn = True
        Me.TxtFromDate.BackColor = System.Drawing.SystemColors.Window
        Me.TxtFromDate.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtFromDate.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtFromDate.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtFromDate.Location = New System.Drawing.Point(107, 25)
        Me.TxtFromDate.MaxLength = 0
        Me.TxtFromDate.Name = "TxtFromDate"
        Me.TxtFromDate.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtFromDate.Size = New System.Drawing.Size(57, 20)
        Me.TxtFromDate.TabIndex = 45
        '
        'TxtToDate
        '
        Me.TxtToDate.AcceptsReturn = True
        Me.TxtToDate.BackColor = System.Drawing.SystemColors.Window
        Me.TxtToDate.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtToDate.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtToDate.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtToDate.Location = New System.Drawing.Point(164, 25)
        Me.TxtToDate.MaxLength = 0
        Me.TxtToDate.Name = "TxtToDate"
        Me.TxtToDate.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtToDate.Size = New System.Drawing.Size(55, 20)
        Me.TxtToDate.TabIndex = 44
        '
        'TxtLocation
        '
        Me.TxtLocation.AcceptsReturn = True
        Me.TxtLocation.BackColor = System.Drawing.SystemColors.Window
        Me.TxtLocation.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtLocation.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtLocation.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtLocation.Location = New System.Drawing.Point(219, 25)
        Me.TxtLocation.MaxLength = 0
        Me.TxtLocation.Name = "TxtLocation"
        Me.TxtLocation.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtLocation.Size = New System.Drawing.Size(141, 20)
        Me.TxtLocation.TabIndex = 43
        '
        'TxtState
        '
        Me.TxtState.AcceptsReturn = True
        Me.TxtState.BackColor = System.Drawing.SystemColors.Window
        Me.TxtState.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtState.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtState.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtState.Location = New System.Drawing.Point(360, 25)
        Me.TxtState.MaxLength = 0
        Me.TxtState.Name = "TxtState"
        Me.TxtState.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtState.Size = New System.Drawing.Size(29, 20)
        Me.TxtState.TabIndex = 42
        '
        'TxtPatientFirst
        '
        Me.TxtPatientFirst.AcceptsReturn = True
        Me.TxtPatientFirst.BackColor = System.Drawing.SystemColors.Window
        Me.TxtPatientFirst.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtPatientFirst.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtPatientFirst.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtPatientFirst.Location = New System.Drawing.Point(389, 25)
        Me.TxtPatientFirst.MaxLength = 0
        Me.TxtPatientFirst.Name = "TxtPatientFirst"
        Me.TxtPatientFirst.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtPatientFirst.Size = New System.Drawing.Size(55, 20)
        Me.TxtPatientFirst.TabIndex = 41
        '
        'TxtPatientLast
        '
        Me.TxtPatientLast.AcceptsReturn = True
        Me.TxtPatientLast.BackColor = System.Drawing.SystemColors.Window
        Me.TxtPatientLast.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtPatientLast.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtPatientLast.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtPatientLast.Location = New System.Drawing.Point(444, 25)
        Me.TxtPatientLast.MaxLength = 0
        Me.TxtPatientLast.Name = "TxtPatientLast"
        Me.TxtPatientLast.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtPatientLast.Size = New System.Drawing.Size(55, 20)
        Me.TxtPatientLast.TabIndex = 40
        '
        'TxtOrg
        '
        Me.TxtOrg.AcceptsReturn = True
        Me.TxtOrg.BackColor = System.Drawing.SystemColors.Window
        Me.TxtOrg.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtOrg.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtOrg.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtOrg.Location = New System.Drawing.Point(499, 25)
        Me.TxtOrg.MaxLength = 0
        Me.TxtOrg.Name = "TxtOrg"
        Me.TxtOrg.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtOrg.Size = New System.Drawing.Size(194, 20)
        Me.TxtOrg.TabIndex = 39
        '
        'TxtOrgPerson
        '
        Me.TxtOrgPerson.AcceptsReturn = True
        Me.TxtOrgPerson.BackColor = System.Drawing.SystemColors.Window
        Me.TxtOrgPerson.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtOrgPerson.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtOrgPerson.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtOrgPerson.Location = New System.Drawing.Point(693, 25)
        Me.TxtOrgPerson.MaxLength = 0
        Me.TxtOrgPerson.Name = "TxtOrgPerson"
        Me.TxtOrgPerson.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtOrgPerson.Size = New System.Drawing.Size(107, 20)
        Me.TxtOrgPerson.TabIndex = 38
        '
        'TxtConsentSource
        '
        Me.TxtConsentSource.AcceptsReturn = True
        Me.TxtConsentSource.BackColor = System.Drawing.SystemColors.Window
        Me.TxtConsentSource.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtConsentSource.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtConsentSource.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtConsentSource.Location = New System.Drawing.Point(800, 25)
        Me.TxtConsentSource.MaxLength = 0
        Me.TxtConsentSource.Name = "TxtConsentSource"
        Me.TxtConsentSource.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtConsentSource.Size = New System.Drawing.Size(76, 20)
        Me.TxtConsentSource.TabIndex = 37
        '
        'TxtType
        '
        Me.TxtType.AcceptsReturn = True
        Me.TxtType.BackColor = System.Drawing.SystemColors.Window
        Me.TxtType.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtType.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtType.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtType.Location = New System.Drawing.Point(2, 25)
        Me.TxtType.MaxLength = 0
        Me.TxtType.Name = "TxtType"
        Me.TxtType.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtType.Size = New System.Drawing.Size(20, 20)
        Me.TxtType.TabIndex = 36
        '
        'LstViewPendingConsent
        '
        Me.LstViewPendingConsent.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewPendingConsent.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.LstViewPendingConsent.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewPendingConsent.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewPendingConsent.FullRowSelect = True
        Me.LstViewPendingConsent.LabelWrap = False
        Me.LstViewPendingConsent.Location = New System.Drawing.Point(0, 47)
        Me.LstViewPendingConsent.Name = "LstViewPendingConsent"
        Me.LstViewPendingConsent.Size = New System.Drawing.Size(875, 151)
        Me.LstViewPendingConsent.SmallImageList = Me.ImageList1
        Me.LstViewPendingConsent.TabIndex = 47
        Me.LstViewPendingConsent.UseCompatibleStateImageBehavior = False
        Me.LstViewPendingConsent.View = System.Windows.Forms.View.Details
        '
        '_TabCallType_TabPage4
        '
        Me._TabCallType_TabPage4.Controls.Add(Me.LstViewSecondaryAlert)
        Me._TabCallType_TabPage4.Controls.Add(Me.LstViewCallouts)
        Me._TabCallType_TabPage4.Controls.Add(Me.LstViewSecondary)
        Me._TabCallType_TabPage4.Location = New System.Drawing.Point(4, 25)
        Me._TabCallType_TabPage4.Name = "_TabCallType_TabPage4"
        Me._TabCallType_TabPage4.Size = New System.Drawing.Size(1075, 234)
        Me._TabCallType_TabPage4.TabIndex = 4
        Me._TabCallType_TabPage4.Text = "Family Services (F5)"
        '
        'LstViewSecondaryAlert
        '
        Me.LstViewSecondaryAlert.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
                    Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.LstViewSecondaryAlert.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewSecondaryAlert.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.LstViewSecondaryAlert.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewSecondaryAlert.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewSecondaryAlert.FullRowSelect = True
        Me.LstViewSecondaryAlert.LabelWrap = False
        Me.LstViewSecondaryAlert.Location = New System.Drawing.Point(426, 24)
        Me.LstViewSecondaryAlert.Name = "LstViewSecondaryAlert"
        Me.LstViewSecondaryAlert.Size = New System.Drawing.Size(419, 63)
        Me.LstViewSecondaryAlert.SmallImageList = Me.ImageList1
        Me.LstViewSecondaryAlert.TabIndex = 62
        Me.LstViewSecondaryAlert.UseCompatibleStateImageBehavior = False
        Me.LstViewSecondaryAlert.View = System.Windows.Forms.View.Details
        '
        'LstViewCallouts
        '
        Me.LstViewCallouts.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewCallouts.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.LstViewCallouts.Dock = System.Windows.Forms.DockStyle.Left
        Me.LstViewCallouts.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewCallouts.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewCallouts.FullRowSelect = True
        Me.LstViewCallouts.LabelWrap = False
        Me.LstViewCallouts.Location = New System.Drawing.Point(0, 0)
        Me.LstViewCallouts.Name = "LstViewCallouts"
        Me.LstViewCallouts.Size = New System.Drawing.Size(419, 234)
        Me.LstViewCallouts.SmallImageList = Me.ImageList1
        Me.LstViewCallouts.TabIndex = 60
        Me.LstViewCallouts.TabStop = False
        Me.LstViewCallouts.UseCompatibleStateImageBehavior = False
        Me.LstViewCallouts.View = System.Windows.Forms.View.Details
        '
        'LstViewSecondary
        '
        Me.LstViewSecondary.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewSecondary.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.LstViewSecondary.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewSecondary.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewSecondary.FullRowSelect = True
        Me.LstViewSecondary.LabelWrap = False
        Me.LstViewSecondary.Location = New System.Drawing.Point(424, 88)
        Me.LstViewSecondary.Name = "LstViewSecondary"
        Me.LstViewSecondary.Size = New System.Drawing.Size(419, 112)
        Me.LstViewSecondary.SmallImageList = Me.ImageList1
        Me.LstViewSecondary.TabIndex = 61
        Me.LstViewSecondary.TabStop = False
        Me.LstViewSecondary.UseCompatibleStateImageBehavior = False
        Me.LstViewSecondary.View = System.Windows.Forms.View.Details
        '
        '_TabCallType_TabPage5
        '
        Me._TabCallType_TabPage5.Controls.Add(Me.TxtCallNumberInfo)
        Me._TabCallType_TabPage5.Controls.Add(Me.TxtFromDateInfo)
        Me._TabCallType_TabPage5.Controls.Add(Me.TxtToDateInfo)
        Me._TabCallType_TabPage5.Controls.Add(Me.TxtFirstNameInfo)
        Me._TabCallType_TabPage5.Controls.Add(Me.TxtLastNameInfo)
        Me._TabCallType_TabPage5.Controls.Add(Me.TxtCoalitionInfo)
        Me._TabCallType_TabPage5.Controls.Add(Me.TxtStateInfo)
        Me._TabCallType_TabPage5.Controls.Add(Me.TxtSourceInfo)
        Me._TabCallType_TabPage5.Controls.Add(Me.LstViewOpenInformation)
        Me._TabCallType_TabPage5.Location = New System.Drawing.Point(4, 25)
        Me._TabCallType_TabPage5.Name = "_TabCallType_TabPage5"
        Me._TabCallType_TabPage5.Size = New System.Drawing.Size(1075, 234)
        Me._TabCallType_TabPage5.TabIndex = 5
        Me._TabCallType_TabPage5.Text = "Info (F6)"
        '
        'TxtCallNumberInfo
        '
        Me.TxtCallNumberInfo.AcceptsReturn = True
        Me.TxtCallNumberInfo.BackColor = System.Drawing.SystemColors.Window
        Me.TxtCallNumberInfo.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtCallNumberInfo.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtCallNumberInfo.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtCallNumberInfo.Location = New System.Drawing.Point(2, 25)
        Me.TxtCallNumberInfo.MaxLength = 0
        Me.TxtCallNumberInfo.Name = "TxtCallNumberInfo"
        Me.TxtCallNumberInfo.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtCallNumberInfo.Size = New System.Drawing.Size(79, 20)
        Me.TxtCallNumberInfo.TabIndex = 67
        '
        'TxtFromDateInfo
        '
        Me.TxtFromDateInfo.AcceptsReturn = True
        Me.TxtFromDateInfo.BackColor = System.Drawing.SystemColors.Window
        Me.TxtFromDateInfo.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtFromDateInfo.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtFromDateInfo.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtFromDateInfo.Location = New System.Drawing.Point(82, 25)
        Me.TxtFromDateInfo.MaxLength = 0
        Me.TxtFromDateInfo.Name = "TxtFromDateInfo"
        Me.TxtFromDateInfo.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtFromDateInfo.Size = New System.Drawing.Size(57, 20)
        Me.TxtFromDateInfo.TabIndex = 68
        '
        'TxtToDateInfo
        '
        Me.TxtToDateInfo.AcceptsReturn = True
        Me.TxtToDateInfo.BackColor = System.Drawing.SystemColors.Window
        Me.TxtToDateInfo.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtToDateInfo.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtToDateInfo.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtToDateInfo.Location = New System.Drawing.Point(140, 25)
        Me.TxtToDateInfo.MaxLength = 0
        Me.TxtToDateInfo.Name = "TxtToDateInfo"
        Me.TxtToDateInfo.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtToDateInfo.Size = New System.Drawing.Size(57, 20)
        Me.TxtToDateInfo.TabIndex = 69
        '
        'TxtFirstNameInfo
        '
        Me.TxtFirstNameInfo.AcceptsReturn = True
        Me.TxtFirstNameInfo.BackColor = System.Drawing.SystemColors.Window
        Me.TxtFirstNameInfo.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtFirstNameInfo.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtFirstNameInfo.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtFirstNameInfo.Location = New System.Drawing.Point(197, 25)
        Me.TxtFirstNameInfo.MaxLength = 0
        Me.TxtFirstNameInfo.Name = "TxtFirstNameInfo"
        Me.TxtFirstNameInfo.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtFirstNameInfo.Size = New System.Drawing.Size(55, 20)
        Me.TxtFirstNameInfo.TabIndex = 70
        '
        'TxtLastNameInfo
        '
        Me.TxtLastNameInfo.AcceptsReturn = True
        Me.TxtLastNameInfo.BackColor = System.Drawing.SystemColors.Window
        Me.TxtLastNameInfo.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtLastNameInfo.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtLastNameInfo.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtLastNameInfo.Location = New System.Drawing.Point(253, 25)
        Me.TxtLastNameInfo.MaxLength = 0
        Me.TxtLastNameInfo.Name = "TxtLastNameInfo"
        Me.TxtLastNameInfo.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtLastNameInfo.Size = New System.Drawing.Size(55, 20)
        Me.TxtLastNameInfo.TabIndex = 71
        '
        'TxtCoalitionInfo
        '
        Me.TxtCoalitionInfo.AcceptsReturn = True
        Me.TxtCoalitionInfo.BackColor = System.Drawing.SystemColors.Window
        Me.TxtCoalitionInfo.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtCoalitionInfo.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtCoalitionInfo.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtCoalitionInfo.Location = New System.Drawing.Point(338, 25)
        Me.TxtCoalitionInfo.MaxLength = 0
        Me.TxtCoalitionInfo.Name = "TxtCoalitionInfo"
        Me.TxtCoalitionInfo.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtCoalitionInfo.Size = New System.Drawing.Size(365, 20)
        Me.TxtCoalitionInfo.TabIndex = 73
        '
        'TxtStateInfo
        '
        Me.TxtStateInfo.AcceptsReturn = True
        Me.TxtStateInfo.BackColor = System.Drawing.SystemColors.Window
        Me.TxtStateInfo.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtStateInfo.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtStateInfo.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtStateInfo.Location = New System.Drawing.Point(309, 25)
        Me.TxtStateInfo.MaxLength = 0
        Me.TxtStateInfo.Name = "TxtStateInfo"
        Me.TxtStateInfo.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtStateInfo.Size = New System.Drawing.Size(29, 20)
        Me.TxtStateInfo.TabIndex = 72
        '
        'TxtSourceInfo
        '
        Me.TxtSourceInfo.AcceptsReturn = True
        Me.TxtSourceInfo.BackColor = System.Drawing.SystemColors.Window
        Me.TxtSourceInfo.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtSourceInfo.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtSourceInfo.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtSourceInfo.Location = New System.Drawing.Point(704, 25)
        Me.TxtSourceInfo.MaxLength = 0
        Me.TxtSourceInfo.Name = "TxtSourceInfo"
        Me.TxtSourceInfo.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtSourceInfo.Size = New System.Drawing.Size(87, 20)
        Me.TxtSourceInfo.TabIndex = 74
        '
        'LstViewOpenInformation
        '
        Me.LstViewOpenInformation.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewOpenInformation.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.LstViewOpenInformation.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewOpenInformation.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewOpenInformation.FullRowSelect = True
        Me.LstViewOpenInformation.LabelWrap = False
        Me.LstViewOpenInformation.Location = New System.Drawing.Point(2, 47)
        Me.LstViewOpenInformation.Name = "LstViewOpenInformation"
        Me.LstViewOpenInformation.Size = New System.Drawing.Size(789, 187)
        Me.LstViewOpenInformation.TabIndex = 66
        Me.LstViewOpenInformation.UseCompatibleStateImageBehavior = False
        Me.LstViewOpenInformation.View = System.Windows.Forms.View.Details
        '
        '_TabCallType_TabPage6
        '
        Me._TabCallType_TabPage6.Controls.Add(Me.LstViewOpenUpdate)
        Me._TabCallType_TabPage6.Controls.Add(Me.txtTcNameUpdate)
        Me._TabCallType_TabPage6.Controls.Add(Me.txtPreRefTypeUpdate)
        Me._TabCallType_TabPage6.Controls.Add(Me.txtToTimeUpdate)
        Me._TabCallType_TabPage6.Controls.Add(Me.txtFromTimeUpdate)
        Me._TabCallType_TabPage6.Controls.Add(Me.txtRefSourceUpdate)
        Me._TabCallType_TabPage6.Controls.Add(Me.txtReferralTypeUpdate)
        Me._TabCallType_TabPage6.Controls.Add(Me.txtStateUpdate)
        Me._TabCallType_TabPage6.Controls.Add(Me.txtLocationUpdate)
        Me._TabCallType_TabPage6.Controls.Add(Me.txtPatientLastUpdate)
        Me._TabCallType_TabPage6.Controls.Add(Me.txtPatientFirstUpdate)
        Me._TabCallType_TabPage6.Controls.Add(Me.txtToDateUpdate)
        Me._TabCallType_TabPage6.Controls.Add(Me.txtFromDateUpdate)
        Me._TabCallType_TabPage6.Controls.Add(Me.txtCallNumberUpdate)
        Me._TabCallType_TabPage6.Location = New System.Drawing.Point(4, 25)
        Me._TabCallType_TabPage6.Name = "_TabCallType_TabPage6"
        Me._TabCallType_TabPage6.Size = New System.Drawing.Size(1075, 234)
        Me._TabCallType_TabPage6.TabIndex = 6
        Me._TabCallType_TabPage6.Text = "Updates (F7)"
        '
        'LstViewOpenUpdate
        '
        Me.LstViewOpenUpdate.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewOpenUpdate.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.LstViewOpenUpdate.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewOpenUpdate.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewOpenUpdate.FullRowSelect = True
        Me.LstViewOpenUpdate.LabelWrap = False
        Me.LstViewOpenUpdate.Location = New System.Drawing.Point(2, 47)
        Me.LstViewOpenUpdate.Name = "LstViewOpenUpdate"
        Me.LstViewOpenUpdate.Size = New System.Drawing.Size(837, 187)
        Me.LstViewOpenUpdate.TabIndex = 79
        Me.LstViewOpenUpdate.UseCompatibleStateImageBehavior = False
        Me.LstViewOpenUpdate.View = System.Windows.Forms.View.Details
        '
        'txtTcNameUpdate
        '
        Me.txtTcNameUpdate.AcceptsReturn = True
        Me.txtTcNameUpdate.BackColor = System.Drawing.SystemColors.Window
        Me.txtTcNameUpdate.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtTcNameUpdate.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtTcNameUpdate.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtTcNameUpdate.Location = New System.Drawing.Point(739, 25)
        Me.txtTcNameUpdate.MaxLength = 0
        Me.txtTcNameUpdate.Name = "txtTcNameUpdate"
        Me.txtTcNameUpdate.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtTcNameUpdate.Size = New System.Drawing.Size(100, 20)
        Me.txtTcNameUpdate.TabIndex = 112
        '
        'txtPreRefTypeUpdate
        '
        Me.txtPreRefTypeUpdate.AcceptsReturn = True
        Me.txtPreRefTypeUpdate.BackColor = System.Drawing.SystemColors.Window
        Me.txtPreRefTypeUpdate.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtPreRefTypeUpdate.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtPreRefTypeUpdate.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtPreRefTypeUpdate.Location = New System.Drawing.Point(533, 25)
        Me.txtPreRefTypeUpdate.MaxLength = 0
        Me.txtPreRefTypeUpdate.Name = "txtPreRefTypeUpdate"
        Me.txtPreRefTypeUpdate.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtPreRefTypeUpdate.Size = New System.Drawing.Size(87, 20)
        Me.txtPreRefTypeUpdate.TabIndex = 108
        '
        'txtToTimeUpdate
        '
        Me.txtToTimeUpdate.AcceptsReturn = True
        Me.txtToTimeUpdate.BackColor = System.Drawing.SystemColors.Window
        Me.txtToTimeUpdate.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtToTimeUpdate.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtToTimeUpdate.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtToTimeUpdate.Location = New System.Drawing.Point(232, 25)
        Me.txtToTimeUpdate.MaxLength = 0
        Me.txtToTimeUpdate.Name = "txtToTimeUpdate"
        Me.txtToTimeUpdate.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtToTimeUpdate.Size = New System.Drawing.Size(35, 20)
        Me.txtToTimeUpdate.TabIndex = 77
        '
        'txtFromTimeUpdate
        '
        Me.txtFromTimeUpdate.AcceptsReturn = True
        Me.txtFromTimeUpdate.BackColor = System.Drawing.SystemColors.Window
        Me.txtFromTimeUpdate.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtFromTimeUpdate.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtFromTimeUpdate.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtFromTimeUpdate.Location = New System.Drawing.Point(142, 25)
        Me.txtFromTimeUpdate.MaxLength = 0
        Me.txtFromTimeUpdate.Name = "txtFromTimeUpdate"
        Me.txtFromTimeUpdate.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtFromTimeUpdate.Size = New System.Drawing.Size(35, 20)
        Me.txtFromTimeUpdate.TabIndex = 78
        '
        'txtRefSourceUpdate
        '
        Me.txtRefSourceUpdate.AcceptsReturn = True
        Me.txtRefSourceUpdate.BackColor = System.Drawing.SystemColors.Window
        Me.txtRefSourceUpdate.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtRefSourceUpdate.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtRefSourceUpdate.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtRefSourceUpdate.Location = New System.Drawing.Point(686, 25)
        Me.txtRefSourceUpdate.MaxLength = 0
        Me.txtRefSourceUpdate.Name = "txtRefSourceUpdate"
        Me.txtRefSourceUpdate.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtRefSourceUpdate.Size = New System.Drawing.Size(54, 20)
        Me.txtRefSourceUpdate.TabIndex = 110
        '
        'txtReferralTypeUpdate
        '
        Me.txtReferralTypeUpdate.AcceptsReturn = True
        Me.txtReferralTypeUpdate.BackColor = System.Drawing.SystemColors.Window
        Me.txtReferralTypeUpdate.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtReferralTypeUpdate.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtReferralTypeUpdate.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtReferralTypeUpdate.Location = New System.Drawing.Point(619, 25)
        Me.txtReferralTypeUpdate.MaxLength = 0
        Me.txtReferralTypeUpdate.Name = "txtReferralTypeUpdate"
        Me.txtReferralTypeUpdate.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtReferralTypeUpdate.Size = New System.Drawing.Size(67, 20)
        Me.txtReferralTypeUpdate.TabIndex = 109
        '
        'txtStateUpdate
        '
        Me.txtStateUpdate.AcceptsReturn = True
        Me.txtStateUpdate.BackColor = System.Drawing.SystemColors.Window
        Me.txtStateUpdate.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtStateUpdate.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtStateUpdate.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtStateUpdate.Location = New System.Drawing.Point(509, 25)
        Me.txtStateUpdate.MaxLength = 0
        Me.txtStateUpdate.Name = "txtStateUpdate"
        Me.txtStateUpdate.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtStateUpdate.Size = New System.Drawing.Size(24, 20)
        Me.txtStateUpdate.TabIndex = 107
        '
        'txtLocationUpdate
        '
        Me.txtLocationUpdate.AcceptsReturn = True
        Me.txtLocationUpdate.BackColor = System.Drawing.SystemColors.Window
        Me.txtLocationUpdate.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtLocationUpdate.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtLocationUpdate.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtLocationUpdate.Location = New System.Drawing.Point(376, 25)
        Me.txtLocationUpdate.MaxLength = 0
        Me.txtLocationUpdate.Name = "txtLocationUpdate"
        Me.txtLocationUpdate.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtLocationUpdate.Size = New System.Drawing.Size(134, 20)
        Me.txtLocationUpdate.TabIndex = 106
        '
        'txtPatientLastUpdate
        '
        Me.txtPatientLastUpdate.AcceptsReturn = True
        Me.txtPatientLastUpdate.BackColor = System.Drawing.SystemColors.Window
        Me.txtPatientLastUpdate.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtPatientLastUpdate.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtPatientLastUpdate.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtPatientLastUpdate.Location = New System.Drawing.Point(321, 25)
        Me.txtPatientLastUpdate.MaxLength = 0
        Me.txtPatientLastUpdate.Name = "txtPatientLastUpdate"
        Me.txtPatientLastUpdate.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtPatientLastUpdate.Size = New System.Drawing.Size(55, 20)
        Me.txtPatientLastUpdate.TabIndex = 105
        '
        'txtPatientFirstUpdate
        '
        Me.txtPatientFirstUpdate.AcceptsReturn = True
        Me.txtPatientFirstUpdate.BackColor = System.Drawing.SystemColors.Window
        Me.txtPatientFirstUpdate.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtPatientFirstUpdate.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtPatientFirstUpdate.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtPatientFirstUpdate.Location = New System.Drawing.Point(266, 25)
        Me.txtPatientFirstUpdate.MaxLength = 0
        Me.txtPatientFirstUpdate.Name = "txtPatientFirstUpdate"
        Me.txtPatientFirstUpdate.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtPatientFirstUpdate.Size = New System.Drawing.Size(55, 20)
        Me.txtPatientFirstUpdate.TabIndex = 104
        '
        'txtToDateUpdate
        '
        Me.txtToDateUpdate.AcceptsReturn = True
        Me.txtToDateUpdate.BackColor = System.Drawing.SystemColors.Window
        Me.txtToDateUpdate.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtToDateUpdate.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtToDateUpdate.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtToDateUpdate.Location = New System.Drawing.Point(177, 25)
        Me.txtToDateUpdate.MaxLength = 0
        Me.txtToDateUpdate.Name = "txtToDateUpdate"
        Me.txtToDateUpdate.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtToDateUpdate.Size = New System.Drawing.Size(55, 20)
        Me.txtToDateUpdate.TabIndex = 103
        '
        'txtFromDateUpdate
        '
        Me.txtFromDateUpdate.AcceptsReturn = True
        Me.txtFromDateUpdate.BackColor = System.Drawing.SystemColors.Window
        Me.txtFromDateUpdate.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtFromDateUpdate.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtFromDateUpdate.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtFromDateUpdate.Location = New System.Drawing.Point(85, 25)
        Me.txtFromDateUpdate.MaxLength = 0
        Me.txtFromDateUpdate.Name = "txtFromDateUpdate"
        Me.txtFromDateUpdate.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtFromDateUpdate.Size = New System.Drawing.Size(57, 20)
        Me.txtFromDateUpdate.TabIndex = 102
        '
        'txtCallNumberUpdate
        '
        Me.txtCallNumberUpdate.AcceptsReturn = True
        Me.txtCallNumberUpdate.BackColor = System.Drawing.SystemColors.Window
        Me.txtCallNumberUpdate.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtCallNumberUpdate.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtCallNumberUpdate.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtCallNumberUpdate.Location = New System.Drawing.Point(2, 25)
        Me.txtCallNumberUpdate.MaxLength = 0
        Me.txtCallNumberUpdate.Name = "txtCallNumberUpdate"
        Me.txtCallNumberUpdate.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtCallNumberUpdate.Size = New System.Drawing.Size(83, 20)
        Me.txtCallNumberUpdate.TabIndex = 80
        '
        '_TabCallType_TabPage7
        '
        Me._TabCallType_TabPage7.Controls.Add(Me.txtMsgTxRecycle)
        Me._TabCallType_TabPage7.Controls.Add(Me.cmdRestoreMessage)
        Me._TabCallType_TabPage7.Controls.Add(Me.txtCallNumberMsgRecycle)
        Me._TabCallType_TabPage7.Controls.Add(Me.txtFromDateMsgRecycle)
        Me._TabCallType_TabPage7.Controls.Add(Me.txtToDateMsgRecycle)
        Me._TabCallType_TabPage7.Controls.Add(Me.txtForPersonFirstRecycle)
        Me._TabCallType_TabPage7.Controls.Add(Me.txtForPersonLastRecycle)
        Me._TabCallType_TabPage7.Controls.Add(Me.txtLocationMsgRecycle)
        Me._TabCallType_TabPage7.Controls.Add(Me.txtStateMsgRecycle)
        Me._TabCallType_TabPage7.Controls.Add(Me.txtMessageTypeRecycle)
        Me._TabCallType_TabPage7.Controls.Add(Me.txtMsgSourceRecycle)
        Me._TabCallType_TabPage7.Controls.Add(Me.txtMsgFromRecycle)
        Me._TabCallType_TabPage7.Controls.Add(Me.CmdRestoreReferral)
        Me._TabCallType_TabPage7.Controls.Add(Me.txtTcNameRecycle)
        Me._TabCallType_TabPage7.Controls.Add(Me.txtPreRefTypeRecycle)
        Me._TabCallType_TabPage7.Controls.Add(Me.txtToTimeRecycle)
        Me._TabCallType_TabPage7.Controls.Add(Me.txtFromTimeRecycle)
        Me._TabCallType_TabPage7.Controls.Add(Me.txtRefSourceRecycle)
        Me._TabCallType_TabPage7.Controls.Add(Me.txtReferralTypeRecycle)
        Me._TabCallType_TabPage7.Controls.Add(Me.txtStateRecycle)
        Me._TabCallType_TabPage7.Controls.Add(Me.txtLocationRecycle)
        Me._TabCallType_TabPage7.Controls.Add(Me.txtPatientLastRecycle)
        Me._TabCallType_TabPage7.Controls.Add(Me.txtPatientFirstRecycle)
        Me._TabCallType_TabPage7.Controls.Add(Me.txtToDateRecycle)
        Me._TabCallType_TabPage7.Controls.Add(Me.txtFromDateRecycle)
        Me._TabCallType_TabPage7.Controls.Add(Me.txtCallNumberRecycle)
        Me._TabCallType_TabPage7.Controls.Add(Me.LstViewOpenRecycle)
        Me._TabCallType_TabPage7.Controls.Add(Me.LstViewOpenMsgRecycle)
        Me._TabCallType_TabPage7.Location = New System.Drawing.Point(4, 25)
        Me._TabCallType_TabPage7.Name = "_TabCallType_TabPage7"
        Me._TabCallType_TabPage7.Size = New System.Drawing.Size(1075, 234)
        Me._TabCallType_TabPage7.TabIndex = 7
        Me._TabCallType_TabPage7.Text = "Recycle (F8)"
        '
        'txtMsgTxRecycle
        '
        Me.txtMsgTxRecycle.AcceptsReturn = True
        Me.txtMsgTxRecycle.BackColor = System.Drawing.SystemColors.Window
        Me.txtMsgTxRecycle.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtMsgTxRecycle.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtMsgTxRecycle.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtMsgTxRecycle.Location = New System.Drawing.Point(761, 136)
        Me.txtMsgTxRecycle.MaxLength = 0
        Me.txtMsgTxRecycle.Name = "txtMsgTxRecycle"
        Me.txtMsgTxRecycle.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtMsgTxRecycle.Size = New System.Drawing.Size(51, 20)
        Me.txtMsgTxRecycle.TabIndex = 118
        Me.txtMsgTxRecycle.Visible = False
        '
        'cmdRestoreMessage
        '
        Me.cmdRestoreMessage.BackColor = System.Drawing.SystemColors.Control
        Me.cmdRestoreMessage.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdRestoreMessage.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdRestoreMessage.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdRestoreMessage.Location = New System.Drawing.Point(984, 136)
        Me.cmdRestoreMessage.Name = "cmdRestoreMessage"
        Me.cmdRestoreMessage.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdRestoreMessage.Size = New System.Drawing.Size(97, 19)
        Me.cmdRestoreMessage.TabIndex = 117
        Me.cmdRestoreMessage.Text = "Restore Me&ssage"
        Me.cmdRestoreMessage.UseVisualStyleBackColor = False
        '
        'txtCallNumberMsgRecycle
        '
        Me.txtCallNumberMsgRecycle.AcceptsReturn = True
        Me.txtCallNumberMsgRecycle.BackColor = System.Drawing.SystemColors.Window
        Me.txtCallNumberMsgRecycle.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtCallNumberMsgRecycle.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtCallNumberMsgRecycle.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtCallNumberMsgRecycle.Location = New System.Drawing.Point(2, 136)
        Me.txtCallNumberMsgRecycle.MaxLength = 0
        Me.txtCallNumberMsgRecycle.Name = "txtCallNumberMsgRecycle"
        Me.txtCallNumberMsgRecycle.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtCallNumberMsgRecycle.Size = New System.Drawing.Size(79, 20)
        Me.txtCallNumberMsgRecycle.TabIndex = 92
        '
        'txtFromDateMsgRecycle
        '
        Me.txtFromDateMsgRecycle.AcceptsReturn = True
        Me.txtFromDateMsgRecycle.BackColor = System.Drawing.SystemColors.Window
        Me.txtFromDateMsgRecycle.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtFromDateMsgRecycle.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtFromDateMsgRecycle.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtFromDateMsgRecycle.Location = New System.Drawing.Point(80, 136)
        Me.txtFromDateMsgRecycle.MaxLength = 0
        Me.txtFromDateMsgRecycle.Name = "txtFromDateMsgRecycle"
        Me.txtFromDateMsgRecycle.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtFromDateMsgRecycle.Size = New System.Drawing.Size(57, 20)
        Me.txtFromDateMsgRecycle.TabIndex = 93
        '
        'txtToDateMsgRecycle
        '
        Me.txtToDateMsgRecycle.AcceptsReturn = True
        Me.txtToDateMsgRecycle.BackColor = System.Drawing.SystemColors.Window
        Me.txtToDateMsgRecycle.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtToDateMsgRecycle.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtToDateMsgRecycle.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtToDateMsgRecycle.Location = New System.Drawing.Point(137, 136)
        Me.txtToDateMsgRecycle.MaxLength = 0
        Me.txtToDateMsgRecycle.Name = "txtToDateMsgRecycle"
        Me.txtToDateMsgRecycle.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtToDateMsgRecycle.Size = New System.Drawing.Size(55, 20)
        Me.txtToDateMsgRecycle.TabIndex = 94
        '
        'txtForPersonFirstRecycle
        '
        Me.txtForPersonFirstRecycle.AcceptsReturn = True
        Me.txtForPersonFirstRecycle.BackColor = System.Drawing.SystemColors.Window
        Me.txtForPersonFirstRecycle.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtForPersonFirstRecycle.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtForPersonFirstRecycle.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtForPersonFirstRecycle.Location = New System.Drawing.Point(192, 136)
        Me.txtForPersonFirstRecycle.MaxLength = 0
        Me.txtForPersonFirstRecycle.Name = "txtForPersonFirstRecycle"
        Me.txtForPersonFirstRecycle.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtForPersonFirstRecycle.Size = New System.Drawing.Size(55, 20)
        Me.txtForPersonFirstRecycle.TabIndex = 95
        '
        'txtForPersonLastRecycle
        '
        Me.txtForPersonLastRecycle.AcceptsReturn = True
        Me.txtForPersonLastRecycle.BackColor = System.Drawing.SystemColors.Window
        Me.txtForPersonLastRecycle.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtForPersonLastRecycle.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtForPersonLastRecycle.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtForPersonLastRecycle.Location = New System.Drawing.Point(246, 136)
        Me.txtForPersonLastRecycle.MaxLength = 0
        Me.txtForPersonLastRecycle.Name = "txtForPersonLastRecycle"
        Me.txtForPersonLastRecycle.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtForPersonLastRecycle.Size = New System.Drawing.Size(55, 20)
        Me.txtForPersonLastRecycle.TabIndex = 96
        '
        'txtLocationMsgRecycle
        '
        Me.txtLocationMsgRecycle.AcceptsReturn = True
        Me.txtLocationMsgRecycle.BackColor = System.Drawing.SystemColors.Window
        Me.txtLocationMsgRecycle.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtLocationMsgRecycle.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtLocationMsgRecycle.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtLocationMsgRecycle.Location = New System.Drawing.Point(301, 136)
        Me.txtLocationMsgRecycle.MaxLength = 0
        Me.txtLocationMsgRecycle.Name = "txtLocationMsgRecycle"
        Me.txtLocationMsgRecycle.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtLocationMsgRecycle.Size = New System.Drawing.Size(201, 20)
        Me.txtLocationMsgRecycle.TabIndex = 97
        '
        'txtStateMsgRecycle
        '
        Me.txtStateMsgRecycle.AcceptsReturn = True
        Me.txtStateMsgRecycle.BackColor = System.Drawing.SystemColors.Window
        Me.txtStateMsgRecycle.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtStateMsgRecycle.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtStateMsgRecycle.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtStateMsgRecycle.Location = New System.Drawing.Point(502, 136)
        Me.txtStateMsgRecycle.MaxLength = 0
        Me.txtStateMsgRecycle.Name = "txtStateMsgRecycle"
        Me.txtStateMsgRecycle.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtStateMsgRecycle.Size = New System.Drawing.Size(29, 20)
        Me.txtStateMsgRecycle.TabIndex = 98
        '
        'txtMessageTypeRecycle
        '
        Me.txtMessageTypeRecycle.AcceptsReturn = True
        Me.txtMessageTypeRecycle.BackColor = System.Drawing.SystemColors.Window
        Me.txtMessageTypeRecycle.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtMessageTypeRecycle.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtMessageTypeRecycle.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtMessageTypeRecycle.Location = New System.Drawing.Point(531, 136)
        Me.txtMessageTypeRecycle.MaxLength = 0
        Me.txtMessageTypeRecycle.Name = "txtMessageTypeRecycle"
        Me.txtMessageTypeRecycle.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtMessageTypeRecycle.Size = New System.Drawing.Size(109, 20)
        Me.txtMessageTypeRecycle.TabIndex = 99
        '
        'txtMsgSourceRecycle
        '
        Me.txtMsgSourceRecycle.AcceptsReturn = True
        Me.txtMsgSourceRecycle.BackColor = System.Drawing.SystemColors.Window
        Me.txtMsgSourceRecycle.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtMsgSourceRecycle.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtMsgSourceRecycle.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtMsgSourceRecycle.Location = New System.Drawing.Point(640, 136)
        Me.txtMsgSourceRecycle.MaxLength = 0
        Me.txtMsgSourceRecycle.Name = "txtMsgSourceRecycle"
        Me.txtMsgSourceRecycle.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtMsgSourceRecycle.Size = New System.Drawing.Size(71, 20)
        Me.txtMsgSourceRecycle.TabIndex = 100
        '
        'txtMsgFromRecycle
        '
        Me.txtMsgFromRecycle.AcceptsReturn = True
        Me.txtMsgFromRecycle.BackColor = System.Drawing.SystemColors.Window
        Me.txtMsgFromRecycle.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtMsgFromRecycle.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtMsgFromRecycle.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtMsgFromRecycle.Location = New System.Drawing.Point(710, 136)
        Me.txtMsgFromRecycle.MaxLength = 0
        Me.txtMsgFromRecycle.Name = "txtMsgFromRecycle"
        Me.txtMsgFromRecycle.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtMsgFromRecycle.Size = New System.Drawing.Size(51, 20)
        Me.txtMsgFromRecycle.TabIndex = 101
        '
        'CmdRestoreReferral
        '
        Me.CmdRestoreReferral.BackColor = System.Drawing.SystemColors.Control
        Me.CmdRestoreReferral.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdRestoreReferral.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdRestoreReferral.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdRestoreReferral.Location = New System.Drawing.Point(984, 25)
        Me.CmdRestoreReferral.Name = "CmdRestoreReferral"
        Me.CmdRestoreReferral.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdRestoreReferral.Size = New System.Drawing.Size(97, 19)
        Me.CmdRestoreReferral.TabIndex = 115
        Me.CmdRestoreReferral.Text = "Restore Re&ferral"
        Me.CmdRestoreReferral.UseVisualStyleBackColor = False
        '
        'txtTcNameRecycle
        '
        Me.txtTcNameRecycle.AcceptsReturn = True
        Me.txtTcNameRecycle.BackColor = System.Drawing.SystemColors.Window
        Me.txtTcNameRecycle.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtTcNameRecycle.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtTcNameRecycle.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtTcNameRecycle.Location = New System.Drawing.Point(739, 25)
        Me.txtTcNameRecycle.MaxLength = 0
        Me.txtTcNameRecycle.Name = "txtTcNameRecycle"
        Me.txtTcNameRecycle.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtTcNameRecycle.Size = New System.Drawing.Size(100, 20)
        Me.txtTcNameRecycle.TabIndex = 91
        '
        'txtPreRefTypeRecycle
        '
        Me.txtPreRefTypeRecycle.AcceptsReturn = True
        Me.txtPreRefTypeRecycle.BackColor = System.Drawing.SystemColors.Window
        Me.txtPreRefTypeRecycle.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtPreRefTypeRecycle.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtPreRefTypeRecycle.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtPreRefTypeRecycle.Location = New System.Drawing.Point(533, 25)
        Me.txtPreRefTypeRecycle.MaxLength = 0
        Me.txtPreRefTypeRecycle.Name = "txtPreRefTypeRecycle"
        Me.txtPreRefTypeRecycle.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtPreRefTypeRecycle.Size = New System.Drawing.Size(87, 20)
        Me.txtPreRefTypeRecycle.TabIndex = 88
        '
        'txtToTimeRecycle
        '
        Me.txtToTimeRecycle.AcceptsReturn = True
        Me.txtToTimeRecycle.BackColor = System.Drawing.SystemColors.Window
        Me.txtToTimeRecycle.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtToTimeRecycle.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtToTimeRecycle.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtToTimeRecycle.Location = New System.Drawing.Point(232, 25)
        Me.txtToTimeRecycle.MaxLength = 0
        Me.txtToTimeRecycle.Name = "txtToTimeRecycle"
        Me.txtToTimeRecycle.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtToTimeRecycle.Size = New System.Drawing.Size(35, 20)
        Me.txtToTimeRecycle.TabIndex = 113
        '
        'txtFromTimeRecycle
        '
        Me.txtFromTimeRecycle.AcceptsReturn = True
        Me.txtFromTimeRecycle.BackColor = System.Drawing.SystemColors.Window
        Me.txtFromTimeRecycle.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtFromTimeRecycle.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtFromTimeRecycle.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtFromTimeRecycle.Location = New System.Drawing.Point(142, 25)
        Me.txtFromTimeRecycle.MaxLength = 0
        Me.txtFromTimeRecycle.Name = "txtFromTimeRecycle"
        Me.txtFromTimeRecycle.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtFromTimeRecycle.Size = New System.Drawing.Size(35, 20)
        Me.txtFromTimeRecycle.TabIndex = 111
        '
        'txtRefSourceRecycle
        '
        Me.txtRefSourceRecycle.AcceptsReturn = True
        Me.txtRefSourceRecycle.BackColor = System.Drawing.SystemColors.Window
        Me.txtRefSourceRecycle.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtRefSourceRecycle.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtRefSourceRecycle.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtRefSourceRecycle.Location = New System.Drawing.Point(686, 25)
        Me.txtRefSourceRecycle.MaxLength = 0
        Me.txtRefSourceRecycle.Name = "txtRefSourceRecycle"
        Me.txtRefSourceRecycle.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtRefSourceRecycle.Size = New System.Drawing.Size(54, 20)
        Me.txtRefSourceRecycle.TabIndex = 90
        '
        'txtReferralTypeRecycle
        '
        Me.txtReferralTypeRecycle.AcceptsReturn = True
        Me.txtReferralTypeRecycle.BackColor = System.Drawing.SystemColors.Window
        Me.txtReferralTypeRecycle.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtReferralTypeRecycle.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtReferralTypeRecycle.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtReferralTypeRecycle.Location = New System.Drawing.Point(619, 25)
        Me.txtReferralTypeRecycle.MaxLength = 0
        Me.txtReferralTypeRecycle.Name = "txtReferralTypeRecycle"
        Me.txtReferralTypeRecycle.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtReferralTypeRecycle.Size = New System.Drawing.Size(67, 20)
        Me.txtReferralTypeRecycle.TabIndex = 89
        '
        'txtStateRecycle
        '
        Me.txtStateRecycle.AcceptsReturn = True
        Me.txtStateRecycle.BackColor = System.Drawing.SystemColors.Window
        Me.txtStateRecycle.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtStateRecycle.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtStateRecycle.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtStateRecycle.Location = New System.Drawing.Point(509, 25)
        Me.txtStateRecycle.MaxLength = 0
        Me.txtStateRecycle.Name = "txtStateRecycle"
        Me.txtStateRecycle.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtStateRecycle.Size = New System.Drawing.Size(24, 20)
        Me.txtStateRecycle.TabIndex = 87
        '
        'txtLocationRecycle
        '
        Me.txtLocationRecycle.AcceptsReturn = True
        Me.txtLocationRecycle.BackColor = System.Drawing.SystemColors.Window
        Me.txtLocationRecycle.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtLocationRecycle.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtLocationRecycle.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtLocationRecycle.Location = New System.Drawing.Point(376, 25)
        Me.txtLocationRecycle.MaxLength = 0
        Me.txtLocationRecycle.Name = "txtLocationRecycle"
        Me.txtLocationRecycle.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtLocationRecycle.Size = New System.Drawing.Size(134, 20)
        Me.txtLocationRecycle.TabIndex = 86
        '
        'txtPatientLastRecycle
        '
        Me.txtPatientLastRecycle.AcceptsReturn = True
        Me.txtPatientLastRecycle.BackColor = System.Drawing.SystemColors.Window
        Me.txtPatientLastRecycle.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtPatientLastRecycle.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtPatientLastRecycle.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtPatientLastRecycle.Location = New System.Drawing.Point(321, 25)
        Me.txtPatientLastRecycle.MaxLength = 0
        Me.txtPatientLastRecycle.Name = "txtPatientLastRecycle"
        Me.txtPatientLastRecycle.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtPatientLastRecycle.Size = New System.Drawing.Size(55, 20)
        Me.txtPatientLastRecycle.TabIndex = 85
        '
        'txtPatientFirstRecycle
        '
        Me.txtPatientFirstRecycle.AcceptsReturn = True
        Me.txtPatientFirstRecycle.BackColor = System.Drawing.SystemColors.Window
        Me.txtPatientFirstRecycle.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtPatientFirstRecycle.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtPatientFirstRecycle.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtPatientFirstRecycle.Location = New System.Drawing.Point(266, 25)
        Me.txtPatientFirstRecycle.MaxLength = 0
        Me.txtPatientFirstRecycle.Name = "txtPatientFirstRecycle"
        Me.txtPatientFirstRecycle.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtPatientFirstRecycle.Size = New System.Drawing.Size(55, 20)
        Me.txtPatientFirstRecycle.TabIndex = 84
        '
        'txtToDateRecycle
        '
        Me.txtToDateRecycle.AcceptsReturn = True
        Me.txtToDateRecycle.BackColor = System.Drawing.SystemColors.Window
        Me.txtToDateRecycle.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtToDateRecycle.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtToDateRecycle.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtToDateRecycle.Location = New System.Drawing.Point(177, 25)
        Me.txtToDateRecycle.MaxLength = 0
        Me.txtToDateRecycle.Name = "txtToDateRecycle"
        Me.txtToDateRecycle.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtToDateRecycle.Size = New System.Drawing.Size(55, 20)
        Me.txtToDateRecycle.TabIndex = 83
        '
        'txtFromDateRecycle
        '
        Me.txtFromDateRecycle.AcceptsReturn = True
        Me.txtFromDateRecycle.BackColor = System.Drawing.SystemColors.Window
        Me.txtFromDateRecycle.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtFromDateRecycle.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtFromDateRecycle.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtFromDateRecycle.Location = New System.Drawing.Point(85, 25)
        Me.txtFromDateRecycle.MaxLength = 0
        Me.txtFromDateRecycle.Name = "txtFromDateRecycle"
        Me.txtFromDateRecycle.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtFromDateRecycle.Size = New System.Drawing.Size(57, 20)
        Me.txtFromDateRecycle.TabIndex = 82
        '
        'txtCallNumberRecycle
        '
        Me.txtCallNumberRecycle.AcceptsReturn = True
        Me.txtCallNumberRecycle.BackColor = System.Drawing.SystemColors.Window
        Me.txtCallNumberRecycle.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtCallNumberRecycle.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtCallNumberRecycle.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtCallNumberRecycle.Location = New System.Drawing.Point(2, 25)
        Me.txtCallNumberRecycle.MaxLength = 0
        Me.txtCallNumberRecycle.Name = "txtCallNumberRecycle"
        Me.txtCallNumberRecycle.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtCallNumberRecycle.Size = New System.Drawing.Size(83, 20)
        Me.txtCallNumberRecycle.TabIndex = 81
        '
        'LstViewOpenRecycle
        '
        Me.LstViewOpenRecycle.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewOpenRecycle.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.LstViewOpenRecycle.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewOpenRecycle.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewOpenRecycle.FullRowSelect = True
        Me.LstViewOpenRecycle.LabelWrap = False
        Me.LstViewOpenRecycle.Location = New System.Drawing.Point(2, 47)
        Me.LstViewOpenRecycle.Name = "LstViewOpenRecycle"
        Me.LstViewOpenRecycle.Size = New System.Drawing.Size(837, 58)
        Me.LstViewOpenRecycle.TabIndex = 114
        Me.LstViewOpenRecycle.UseCompatibleStateImageBehavior = False
        Me.LstViewOpenRecycle.View = System.Windows.Forms.View.Details
        '
        'LstViewOpenMsgRecycle
        '
        Me.LstViewOpenMsgRecycle.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewOpenMsgRecycle.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.LstViewOpenMsgRecycle.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewOpenMsgRecycle.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewOpenMsgRecycle.FullRowSelect = True
        Me.LstViewOpenMsgRecycle.LabelWrap = False
        Me.LstViewOpenMsgRecycle.Location = New System.Drawing.Point(2, 176)
        Me.LstViewOpenMsgRecycle.Name = "LstViewOpenMsgRecycle"
        Me.LstViewOpenMsgRecycle.Size = New System.Drawing.Size(810, 58)
        Me.LstViewOpenMsgRecycle.TabIndex = 116
        Me.LstViewOpenMsgRecycle.UseCompatibleStateImageBehavior = False
        Me.LstViewOpenMsgRecycle.View = System.Windows.Forms.View.Details
        '
        'Timer_Renamed
        '
        Me.Timer_Renamed.Enabled = True
        Me.Timer_Renamed.Interval = 60000
        '
        'LstViewIncompletes
        '
        Me.LstViewIncompletes.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewIncompletes.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.LstViewIncompletes.Dock = System.Windows.Forms.DockStyle.Right
        Me.LstViewIncompletes.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewIncompletes.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewIncompletes.FullRowSelect = True
        Me.LstViewIncompletes.LabelWrap = False
        Me.LstViewIncompletes.Location = New System.Drawing.Point(509, 3)
        Me.LstViewIncompletes.MaximumSize = New System.Drawing.Size(700, 209)
        Me.LstViewIncompletes.MinimumSize = New System.Drawing.Size(250, 209)
        Me.LstViewIncompletes.Name = "LstViewIncompletes"
        Me.LstViewIncompletes.Size = New System.Drawing.Size(500, 209)
        Me.LstViewIncompletes.SmallImageList = Me.ImageList1
        Me.LstViewIncompletes.TabIndex = 48
        Me.LstViewIncompletes.TabStop = False
        Me.LstViewIncompletes.UseCompatibleStateImageBehavior = False
        Me.LstViewIncompletes.View = System.Windows.Forms.View.Details
        '
        'ImageList2
        '
        Me.ImageList2.ImageStream = CType(resources.GetObject("ImageList2.ImageStream"), System.Windows.Forms.ImageListStreamer)
        Me.ImageList2.TransparentColor = System.Drawing.Color.FromArgb(CType(CType(192, Byte), Integer), CType(CType(192, Byte), Integer), CType(CType(192, Byte), Integer))
        Me.ImageList2.Images.SetKeyName(0, "image_blue")
        Me.ImageList2.Images.SetKeyName(1, "status_red")
        Me.ImageList2.Images.SetKeyName(2, "status_green")
        Me.ImageList2.Images.SetKeyName(3, "image_a")
        Me.ImageList2.Images.SetKeyName(4, "image_b")
        Me.ImageList2.Images.SetKeyName(5, "image_bell")
        '
        'contextMenuStrip
        '
        Me.contextMenuStrip.Name = "contextMenuStrip"
        Me.contextMenuStrip.Size = New System.Drawing.Size(61, 4)
        '
        'Panel1
        '
        Me.Panel1.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
                    Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.Panel1.AutoSize = True
        Me.Panel1.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink
        Me.Panel1.Controls.Add(Me.LstViewPendingPage)
        Me.Panel1.Controls.Add(Me.LstViewIncompletes)
        Me.Panel1.Location = New System.Drawing.Point(0, 97)
        Me.Panel1.Name = "Panel1"
        Me.Panel1.Size = New System.Drawing.Size(1012, 215)
        Me.Panel1.TabIndex = 120
        Me.Panel1.WrapContents = False
        '
        'FrmOpenAll
        '
        Me.AcceptButton = Me.CmdRefresh
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 14.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.ClientSize = New System.Drawing.Size(1184, 596)
        Me.ControlBox = False
        Me.Controls.Add(Me.Panel1)
        Me.Controls.Add(Me.LstViewGeneralAlert)
        Me.Controls.Add(Me.CmdClearFilters)
        Me.Controls.Add(Me.CmdLineCheck)
        Me.Controls.Add(Me.CmdNewCall)
        Me.Controls.Add(Me.CmdRefresh)
        Me.Controls.Add(Me.TabCallType)
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.SizableToolWindow
        Me.KeyPreview = True
        Me.Location = New System.Drawing.Point(24, 35)
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "FrmOpenAll"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ShowInTaskbar = False
        Me.StartPosition = System.Windows.Forms.FormStartPosition.WindowsDefaultBounds
        Me.TabCallType.ResumeLayout(False)
        Me._TabCallType_TabPage0.ResumeLayout(False)
        Me._TabCallType_TabPage0.PerformLayout()
        Me._TabCallType_TabPage1.ResumeLayout(False)
        Me._TabCallType_TabPage1.PerformLayout()
        Me._TabCallType_TabPage2.ResumeLayout(False)
        Me._TabCallType_TabPage2.PerformLayout()
        Me._TabCallType_TabPage3.ResumeLayout(False)
        Me._TabCallType_TabPage3.PerformLayout()
        Me._TabCallType_TabPage4.ResumeLayout(False)
        Me._TabCallType_TabPage5.ResumeLayout(False)
        Me._TabCallType_TabPage5.PerformLayout()
        Me._TabCallType_TabPage6.ResumeLayout(False)
        Me._TabCallType_TabPage6.PerformLayout()
        Me._TabCallType_TabPage7.ResumeLayout(False)
        Me._TabCallType_TabPage7.PerformLayout()
        CType(Me.Label, System.ComponentModel.ISupportInitialize).EndInit()
        Me.Panel1.ResumeLayout(False)
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents contextMenuStrip As System.Windows.Forms.ContextMenuStrip
    Friend WithEvents Panel1 As System.Windows.Forms.FlowLayoutPanel
#End Region
End Class