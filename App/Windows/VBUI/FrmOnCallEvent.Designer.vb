<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmOnCallEvent
#Region "Windows Form Designer generated code "
	<System.Diagnostics.DebuggerNonUserCode()> Public Sub New()
		MyBase.New()
		'This call is required by the Windows Form Designer.
		InitializeComponent()
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
	Public WithEvents ChkConfirmed As System.Windows.Forms.CheckBox
	Public WithEvents ChkShowAll As System.Windows.Forms.CheckBox
	Public WithEvents CmdOK As System.Windows.Forms.Button
	Public WithEvents CmdCancel As System.Windows.Forms.Button
	Public WithEvents CboScheduleGroup As System.Windows.Forms.ComboBox
	Public WithEvents CboOrganization As System.Windows.Forms.ComboBox
	Public WithEvents TxtPersonNotes As System.Windows.Forms.TextBox
	Public WithEvents LstViewContact As System.Windows.Forms.ListView
	Public WithEvents LstViewPerson As System.Windows.Forms.ListView
	Public WithEvents TxtAlert As System.Windows.Forms.RichTextBox
	Public WithEvents _label_2 As System.Windows.Forms.Label
	Public WithEvents _TabNotes_TabPage0 As System.Windows.Forms.TabPage
    Public WithEvents TxtReferralNotes As System.Windows.Forms.RichTextBox
	Public WithEvents _TabNotes_TabPage1 As System.Windows.Forms.TabPage
	Public WithEvents txtScheduleMessageNotes As System.Windows.Forms.RichTextBox
	Public WithEvents txtScheduleReferralNotes As System.Windows.Forms.RichTextBox
    Public WithEvents _TabNotes_TabPage2 As System.Windows.Forms.TabPage
	Public WithEvents TabNotes As System.Windows.Forms.TabControl
	Public WithEvents LblShift As System.Windows.Forms.Label
	Public WithEvents _label_0 As System.Windows.Forms.Label
	Public WithEvents _FraReferral_0 As System.Windows.Forms.GroupBox
	Public WithEvents txtEmail As System.Windows.Forms.TextBox
	Public WithEvents TxtCalloutMins As System.Windows.Forms.TextBox
	Public WithEvents TxtCalloutDate As System.Windows.Forms.TextBox
	Public WithEvents _LblCallout_0 As System.Windows.Forms.Label
	Public WithEvents _label_5 As System.Windows.Forms.Label
	Public WithEvents _LblCallout_1 As System.Windows.Forms.Label
	Public WithEvents FraCallout As System.Windows.Forms.Panel
	Public WithEvents TxtContactName As System.Windows.Forms.TextBox
	Public WithEvents TxtContactPhone As System.Windows.Forms.TextBox
	Public WithEvents CboContactEventType As System.Windows.Forms.ComboBox
	Public WithEvents TxtContactDate As System.Windows.Forms.TextBox
	Public WithEvents TxtContactOrg As System.Windows.Forms.TextBox
	Public WithEvents TxtContactDesc As System.Windows.Forms.RichTextBox
	Public WithEvents lblEmail As System.Windows.Forms.Label
	Public WithEvents LblContactName As System.Windows.Forms.Label
	Public WithEvents LblContactPhone As System.Windows.Forms.Label
	Public WithEvents _LblContact_3 As System.Windows.Forms.Label
	Public WithEvents _LblContact_2 As System.Windows.Forms.Label
	Public WithEvents LblContactOrg As System.Windows.Forms.Label
	Public WithEvents FraContact As System.Windows.Forms.GroupBox
	Public WithEvents FraReferral As Microsoft.VisualBasic.Compatibility.VB6.GroupBoxArray
	Public WithEvents LblCallout As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
	Public WithEvents LblContact As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
	Public WithEvents label As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FrmOnCallEvent))
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.ChkConfirmed = New System.Windows.Forms.CheckBox()
        Me.ChkShowAll = New System.Windows.Forms.CheckBox()
        Me.CmdOK = New System.Windows.Forms.Button()
        Me.CmdCancel = New System.Windows.Forms.Button()
        Me._FraReferral_0 = New System.Windows.Forms.GroupBox()
        Me.CboScheduleGroup = New System.Windows.Forms.ComboBox()
        Me._label_2 = New System.Windows.Forms.Label()
        Me.CboOrganization = New System.Windows.Forms.ComboBox()
        Me.TxtPersonNotes = New System.Windows.Forms.TextBox()
        Me.LstViewContact = New System.Windows.Forms.ListView()
        Me.LstViewPerson = New System.Windows.Forms.ListView()
        Me.TabNotes = New System.Windows.Forms.TabControl()
        Me._TabNotes_TabPage0 = New System.Windows.Forms.TabPage()
        Me.TxtAlert = New System.Windows.Forms.RichTextBox()
        Me._TabNotes_TabPage1 = New System.Windows.Forms.TabPage()
        Me.txtMessageNotes = New System.Windows.Forms.RichTextBox()
        Me.TxtReferralNotes = New System.Windows.Forms.RichTextBox()
        Me._TabNotes_TabPage2 = New System.Windows.Forms.TabPage()
        Me.txtScheduleMessageNotes = New System.Windows.Forms.RichTextBox()
        Me.txtScheduleReferralNotes = New System.Windows.Forms.RichTextBox()
        Me.LblShift = New System.Windows.Forms.Label()
        Me._label_0 = New System.Windows.Forms.Label()
        Me.FraContact = New System.Windows.Forms.GroupBox()
        Me.txtEmail = New System.Windows.Forms.TextBox()
        Me.FraCallout = New System.Windows.Forms.Panel()
        Me.TxtCalloutMins = New System.Windows.Forms.TextBox()
        Me.TxtCalloutDate = New System.Windows.Forms.TextBox()
        Me._LblCallout_0 = New System.Windows.Forms.Label()
        Me._label_5 = New System.Windows.Forms.Label()
        Me._LblCallout_1 = New System.Windows.Forms.Label()
        Me.TxtContactName = New System.Windows.Forms.TextBox()
        Me.TxtContactPhone = New System.Windows.Forms.TextBox()
        Me.TxtContactDate = New System.Windows.Forms.TextBox()
        Me.TxtContactOrg = New System.Windows.Forms.TextBox()
        Me.lblEmail = New System.Windows.Forms.Label()
        Me.LblContactName = New System.Windows.Forms.Label()
        Me.LblContactPhone = New System.Windows.Forms.Label()
        Me._LblContact_2 = New System.Windows.Forms.Label()
        Me.LblContactOrg = New System.Windows.Forms.Label()
        Me.CboContactEventType = New System.Windows.Forms.ComboBox()
        Me.TxtContactDesc = New System.Windows.Forms.RichTextBox()
        Me._LblContact_3 = New System.Windows.Forms.Label()
        Me.FraReferral = New Microsoft.VisualBasic.Compatibility.VB6.GroupBoxArray(Me.components)
        Me.LblCallout = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(Me.components)
        Me.LblContact = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(Me.components)
        Me.label = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(Me.components)
        Me._FraReferral_0.SuspendLayout
        Me.TabNotes.SuspendLayout
        Me._TabNotes_TabPage0.SuspendLayout
        Me._TabNotes_TabPage1.SuspendLayout
        Me._TabNotes_TabPage2.SuspendLayout
        Me.FraContact.SuspendLayout
        Me.FraCallout.SuspendLayout
        CType(Me.FraReferral,System.ComponentModel.ISupportInitialize).BeginInit
        CType(Me.LblCallout,System.ComponentModel.ISupportInitialize).BeginInit
        CType(Me.LblContact,System.ComponentModel.ISupportInitialize).BeginInit
        CType(Me.label,System.ComponentModel.ISupportInitialize).BeginInit
        Me.SuspendLayout
        '
        'ChkConfirmed
        '
        Me.ChkConfirmed.BackColor = System.Drawing.SystemColors.Control
        Me.ChkConfirmed.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkConfirmed.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.ChkConfirmed.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkConfirmed.Location = New System.Drawing.Point(561, 472)
        Me.ChkConfirmed.Name = "ChkConfirmed"
        Me.ChkConfirmed.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkConfirmed.Size = New System.Drawing.Size(81, 39)
        Me.ChkConfirmed.TabIndex = 6
        Me.ChkConfirmed.Text = "Contact Confirmed"
        Me.ChkConfirmed.UseVisualStyleBackColor = false
        Me.ChkConfirmed.Visible = false
        '
        'ChkShowAll
        '
        Me.ChkShowAll.BackColor = System.Drawing.SystemColors.Control
        Me.ChkShowAll.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkShowAll.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.ChkShowAll.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkShowAll.Location = New System.Drawing.Point(562, 96)
        Me.ChkShowAll.Name = "ChkShowAll"
        Me.ChkShowAll.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkShowAll.Size = New System.Drawing.Size(71, 25)
        Me.ChkShowAll.TabIndex = 23
        Me.ChkShowAll.TabStop = false
        Me.ChkShowAll.Text = "Show All"
        Me.ChkShowAll.UseVisualStyleBackColor = false
        '
        'CmdOK
        '
        Me.CmdOK.BackColor = System.Drawing.SystemColors.Control
        Me.CmdOK.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdOK.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.CmdOK.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdOK.Location = New System.Drawing.Point(562, 8)
        Me.CmdOK.Name = "CmdOK"
        Me.CmdOK.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdOK.Size = New System.Drawing.Size(80, 21)
        Me.CmdOK.TabIndex = 8
        Me.CmdOK.Text = "&Save"
        Me.CmdOK.UseVisualStyleBackColor = false
        '
        'CmdCancel
        '
        Me.CmdCancel.BackColor = System.Drawing.SystemColors.Control
        Me.CmdCancel.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdCancel.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.CmdCancel.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdCancel.Location = New System.Drawing.Point(561, 590)
        Me.CmdCancel.Name = "CmdCancel"
        Me.CmdCancel.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdCancel.Size = New System.Drawing.Size(80, 21)
        Me.CmdCancel.TabIndex = 9
        Me.CmdCancel.Text = "&Cancel"
        Me.CmdCancel.UseVisualStyleBackColor = false
        '
        '_FraReferral_0
        '
        Me._FraReferral_0.BackColor = System.Drawing.SystemColors.Control
        Me._FraReferral_0.Controls.Add(Me.CboScheduleGroup)
        Me._FraReferral_0.Controls.Add(Me._label_2)
        Me._FraReferral_0.Controls.Add(Me.CboOrganization)
        Me._FraReferral_0.Controls.Add(Me.TxtPersonNotes)
        Me._FraReferral_0.Controls.Add(Me.LstViewContact)
        Me._FraReferral_0.Controls.Add(Me.LstViewPerson)
        Me._FraReferral_0.Controls.Add(Me.TabNotes)
        Me._FraReferral_0.Controls.Add(Me.LblShift)
        Me._FraReferral_0.Controls.Add(Me._label_0)
        Me._FraReferral_0.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me._FraReferral_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.FraReferral.SetIndex(Me._FraReferral_0, CType(0,Short))
        Me._FraReferral_0.Location = New System.Drawing.Point(2, 2)
        Me._FraReferral_0.Name = "_FraReferral_0"
        Me._FraReferral_0.Padding = New System.Windows.Forms.Padding(0)
        Me._FraReferral_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._FraReferral_0.Size = New System.Drawing.Size(553, 462)
        Me._FraReferral_0.TabIndex = 0
        Me._FraReferral_0.TabStop = false
        '
        'CboScheduleGroup
        '
        Me.CboScheduleGroup.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboScheduleGroup.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboScheduleGroup.BackColor = System.Drawing.SystemColors.Window
        Me.CboScheduleGroup.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboScheduleGroup.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboScheduleGroup.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.CboScheduleGroup.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboScheduleGroup.Location = New System.Drawing.Point(330, 38)
        Me.CboScheduleGroup.Name = "CboScheduleGroup"
        Me.CboScheduleGroup.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboScheduleGroup.Size = New System.Drawing.Size(213, 22)
        Me.CboScheduleGroup.Sorted = true
        Me.CboScheduleGroup.TabIndex = 1
        '
        '_label_2
        '
        Me._label_2.BackColor = System.Drawing.SystemColors.Control
        Me._label_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._label_2.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me._label_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.label.SetIndex(Me._label_2, CType(2,Short))
        Me._label_2.Location = New System.Drawing.Point(279, 41)
        Me._label_2.Name = "_label_2"
        Me._label_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._label_2.Size = New System.Drawing.Size(52, 17)
        Me._label_2.TabIndex = 26
        Me._label_2.Text = "Schedule"
        '
        'CboOrganization
        '
        Me.CboOrganization.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboOrganization.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboOrganization.BackColor = System.Drawing.SystemColors.Window
        Me.CboOrganization.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboOrganization.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboOrganization.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.CboOrganization.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboOrganization.Location = New System.Drawing.Point(330, 14)
        Me.CboOrganization.Name = "CboOrganization"
        Me.CboOrganization.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboOrganization.Size = New System.Drawing.Size(213, 22)
        Me.CboOrganization.Sorted = true
        Me.CboOrganization.TabIndex = 0
        '
        'TxtPersonNotes
        '
        Me.TxtPersonNotes.AcceptsReturn = true
        Me.TxtPersonNotes.BackColor = System.Drawing.SystemColors.Window
        Me.TxtPersonNotes.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtPersonNotes.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.TxtPersonNotes.ForeColor = System.Drawing.Color.Black
        Me.TxtPersonNotes.Location = New System.Drawing.Point(272, 264)
        Me.TxtPersonNotes.MaxLength = 0
        Me.TxtPersonNotes.Multiline = true
        Me.TxtPersonNotes.Name = "TxtPersonNotes"
        Me.TxtPersonNotes.ReadOnly = true
        Me.TxtPersonNotes.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtPersonNotes.Size = New System.Drawing.Size(271, 89)
        Me.TxtPersonNotes.TabIndex = 16
        Me.TxtPersonNotes.TabStop = false
        '
        'LstViewContact
        '
        Me.LstViewContact.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewContact.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.LstViewContact.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.LstViewContact.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewContact.FullRowSelect = true
        Me.LstViewContact.HeaderStyle = System.Windows.Forms.ColumnHeaderStyle.None
        Me.LstViewContact.LabelWrap = false
        Me.LstViewContact.Location = New System.Drawing.Point(272, 360)
        Me.LstViewContact.Name = "LstViewContact"
        Me.LstViewContact.Size = New System.Drawing.Size(271, 89)
        Me.LstViewContact.TabIndex = 3
        Me.LstViewContact.UseCompatibleStateImageBehavior = false
        Me.LstViewContact.View = System.Windows.Forms.View.Details
        '
        'LstViewPerson
        '
        Me.LstViewPerson.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewPerson.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.LstViewPerson.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.LstViewPerson.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewPerson.FullRowSelect = true
        Me.LstViewPerson.HeaderStyle = System.Windows.Forms.ColumnHeaderStyle.None
        Me.LstViewPerson.Location = New System.Drawing.Point(272, 64)
        Me.LstViewPerson.Name = "LstViewPerson"
        Me.LstViewPerson.Size = New System.Drawing.Size(271, 193)
        Me.LstViewPerson.TabIndex = 2
        Me.LstViewPerson.UseCompatibleStateImageBehavior = false
        Me.LstViewPerson.View = System.Windows.Forms.View.Details
        '
        'TabNotes
        '
        Me.TabNotes.Controls.Add(Me._TabNotes_TabPage0)
        Me.TabNotes.Controls.Add(Me._TabNotes_TabPage1)
        Me.TabNotes.Controls.Add(Me._TabNotes_TabPage2)
        Me.TabNotes.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.TabNotes.ItemSize = New System.Drawing.Size(42, 18)
        Me.TabNotes.Location = New System.Drawing.Point(6, 40)
        Me.TabNotes.Name = "TabNotes"
        Me.TabNotes.SelectedIndex = 1
        Me.TabNotes.Size = New System.Drawing.Size(261, 409)
        Me.TabNotes.TabIndex = 24
        Me.TabNotes.TabStop = false
        '
        '_TabNotes_TabPage0
        '
        Me._TabNotes_TabPage0.Controls.Add(Me.TxtAlert)
        Me._TabNotes_TabPage0.Location = New System.Drawing.Point(4, 22)
        Me._TabNotes_TabPage0.Name = "_TabNotes_TabPage0"
        Me._TabNotes_TabPage0.Size = New System.Drawing.Size(253, 383)
        Me._TabNotes_TabPage0.TabIndex = 0
        Me._TabNotes_TabPage0.Text = "Contact Alert"
        '
        'TxtAlert
        '
        Me.TxtAlert.BackColor = System.Drawing.SystemColors.Window
        Me.TxtAlert.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.TxtAlert.Dock = System.Windows.Forms.DockStyle.Fill
        Me.TxtAlert.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.TxtAlert.Location = New System.Drawing.Point(0, 0)
        Me.TxtAlert.MaxLength = 2000
        Me.TxtAlert.Name = "TxtAlert"
        Me.TxtAlert.ReadOnly = true
        Me.TxtAlert.ScrollBars = System.Windows.Forms.RichTextBoxScrollBars.Vertical
        Me.TxtAlert.Size = New System.Drawing.Size(253, 383)
        Me.TxtAlert.TabIndex = 29
        Me.TxtAlert.TabStop = false
        Me.TxtAlert.Text = ""
        '
        '_TabNotes_TabPage1
        '
        Me._TabNotes_TabPage1.Controls.Add(Me.txtMessageNotes)
        Me._TabNotes_TabPage1.Controls.Add(Me.TxtReferralNotes)
        Me._TabNotes_TabPage1.Location = New System.Drawing.Point(4, 22)
        Me._TabNotes_TabPage1.Name = "_TabNotes_TabPage1"
        Me._TabNotes_TabPage1.Size = New System.Drawing.Size(253, 383)
        Me._TabNotes_TabPage1.TabIndex = 1
        Me._TabNotes_TabPage1.Text = "Organization"
        '
        'txtMessageNotes
        '
        Me.txtMessageNotes.BackColor = System.Drawing.SystemColors.Window
        Me.txtMessageNotes.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.txtMessageNotes.Dock = System.Windows.Forms.DockStyle.Fill
        Me.txtMessageNotes.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.txtMessageNotes.Location = New System.Drawing.Point(0, 0)
        Me.txtMessageNotes.MaxLength = 2000
        Me.txtMessageNotes.Name = "txtMessageNotes"
        Me.txtMessageNotes.ReadOnly = true
        Me.txtMessageNotes.ScrollBars = System.Windows.Forms.RichTextBoxScrollBars.Vertical
        Me.txtMessageNotes.Size = New System.Drawing.Size(253, 383)
        Me.txtMessageNotes.TabIndex = 39
        Me.txtMessageNotes.TabStop = false
        Me.txtMessageNotes.Text = ""
        '
        'TxtReferralNotes
        '
        Me.TxtReferralNotes.BackColor = System.Drawing.SystemColors.Window
        Me.TxtReferralNotes.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.TxtReferralNotes.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.TxtReferralNotes.Location = New System.Drawing.Point(0, 0)
        Me.TxtReferralNotes.MaxLength = 2000
        Me.TxtReferralNotes.Name = "TxtReferralNotes"
        Me.TxtReferralNotes.ReadOnly = true
        Me.TxtReferralNotes.ScrollBars = System.Windows.Forms.RichTextBoxScrollBars.Vertical
        Me.TxtReferralNotes.Size = New System.Drawing.Size(253, 383)
        Me.TxtReferralNotes.TabIndex = 38
        Me.TxtReferralNotes.TabStop = false
        Me.TxtReferralNotes.Text = ""
        '
        '_TabNotes_TabPage2
        '
        Me._TabNotes_TabPage2.Controls.Add(Me.txtScheduleMessageNotes)
        Me._TabNotes_TabPage2.Controls.Add(Me.txtScheduleReferralNotes)
        Me._TabNotes_TabPage2.Location = New System.Drawing.Point(4, 22)
        Me._TabNotes_TabPage2.Name = "_TabNotes_TabPage2"
        Me._TabNotes_TabPage2.Size = New System.Drawing.Size(253, 383)
        Me._TabNotes_TabPage2.TabIndex = 2
        Me._TabNotes_TabPage2.Text = "Schedule"
        '
        'txtScheduleMessageNotes
        '
        Me.txtScheduleMessageNotes.BackColor = System.Drawing.SystemColors.Window
        Me.txtScheduleMessageNotes.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.txtScheduleMessageNotes.Dock = System.Windows.Forms.DockStyle.Fill
        Me.txtScheduleMessageNotes.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.txtScheduleMessageNotes.Location = New System.Drawing.Point(0, 0)
        Me.txtScheduleMessageNotes.MaxLength = 2000
        Me.txtScheduleMessageNotes.Name = "txtScheduleMessageNotes"
        Me.txtScheduleMessageNotes.ReadOnly = true
        Me.txtScheduleMessageNotes.ScrollBars = System.Windows.Forms.RichTextBoxScrollBars.Vertical
        Me.txtScheduleMessageNotes.Size = New System.Drawing.Size(253, 383)
        Me.txtScheduleMessageNotes.TabIndex = 40
        Me.txtScheduleMessageNotes.TabStop = false
        Me.txtScheduleMessageNotes.Text = ""
        '
        'txtScheduleReferralNotes
        '
        Me.txtScheduleReferralNotes.BackColor = System.Drawing.SystemColors.Window
        Me.txtScheduleReferralNotes.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.txtScheduleReferralNotes.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.txtScheduleReferralNotes.Location = New System.Drawing.Point(0, 0)
        Me.txtScheduleReferralNotes.MaxLength = 2000
        Me.txtScheduleReferralNotes.Name = "txtScheduleReferralNotes"
        Me.txtScheduleReferralNotes.ReadOnly = true
        Me.txtScheduleReferralNotes.ScrollBars = System.Windows.Forms.RichTextBoxScrollBars.Vertical
        Me.txtScheduleReferralNotes.Size = New System.Drawing.Size(253, 383)
        Me.txtScheduleReferralNotes.TabIndex = 41
        Me.txtScheduleReferralNotes.TabStop = false
        Me.txtScheduleReferralNotes.Text = ""
        '
        'LblShift
        '
        Me.LblShift.BackColor = System.Drawing.SystemColors.Control
        Me.LblShift.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblShift.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.LblShift.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblShift.Location = New System.Drawing.Point(10, 16)
        Me.LblShift.Name = "LblShift"
        Me.LblShift.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblShift.Size = New System.Drawing.Size(195, 13)
        Me.LblShift.TabIndex = 25
        Me.LblShift.Text = "00:00 - 00:00"
        '
        '_label_0
        '
        Me._label_0.BackColor = System.Drawing.SystemColors.Control
        Me._label_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._label_0.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me._label_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.label.SetIndex(Me._label_0, CType(0,Short))
        Me._label_0.Location = New System.Drawing.Point(263, 17)
        Me._label_0.Name = "_label_0"
        Me._label_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._label_0.Size = New System.Drawing.Size(68, 17)
        Me._label_0.TabIndex = 15
        Me._label_0.Text = "Organization"
        '
        'FraContact
        '
        Me.FraContact.BackColor = System.Drawing.SystemColors.Control
        Me.FraContact.Controls.Add(Me.txtEmail)
        Me.FraContact.Controls.Add(Me.FraCallout)
        Me.FraContact.Controls.Add(Me.TxtContactName)
        Me.FraContact.Controls.Add(Me.TxtContactPhone)
        Me.FraContact.Controls.Add(Me.TxtContactDate)
        Me.FraContact.Controls.Add(Me.TxtContactOrg)
        Me.FraContact.Controls.Add(Me.lblEmail)
        Me.FraContact.Controls.Add(Me.LblContactName)
        Me.FraContact.Controls.Add(Me.LblContactPhone)
        Me.FraContact.Controls.Add(Me._LblContact_2)
        Me.FraContact.Controls.Add(Me.LblContactOrg)
        Me.FraContact.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.FraContact.ForeColor = System.Drawing.SystemColors.ControlText
        Me.FraContact.Location = New System.Drawing.Point(3, 468)
        Me.FraContact.Name = "FraContact"
        Me.FraContact.Padding = New System.Windows.Forms.Padding(0)
        Me.FraContact.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.FraContact.Size = New System.Drawing.Size(279, 145)
        Me.FraContact.TabIndex = 15
        Me.FraContact.TabStop = false
        '
        'txtEmail
        '
        Me.txtEmail.AcceptsReturn = true
        Me.txtEmail.BackColor = System.Drawing.SystemColors.Window
        Me.txtEmail.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtEmail.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.txtEmail.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtEmail.Location = New System.Drawing.Point(50, 94)
        Me.txtEmail.MaxLength = 0
        Me.txtEmail.Name = "txtEmail"
        Me.txtEmail.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtEmail.Size = New System.Drawing.Size(221, 20)
        Me.txtEmail.TabIndex = 37
        '
        'FraCallout
        '
        Me.FraCallout.BackColor = System.Drawing.SystemColors.Control
        Me.FraCallout.Controls.Add(Me.TxtCalloutMins)
        Me.FraCallout.Controls.Add(Me.TxtCalloutDate)
        Me.FraCallout.Controls.Add(Me._LblCallout_0)
        Me.FraCallout.Controls.Add(Me._label_5)
        Me.FraCallout.Controls.Add(Me._LblCallout_1)
        Me.FraCallout.Cursor = System.Windows.Forms.Cursors.Default
        Me.FraCallout.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.FraCallout.ForeColor = System.Drawing.SystemColors.ControlText
        Me.FraCallout.Location = New System.Drawing.Point(6, 118)
        Me.FraCallout.Name = "FraCallout"
        Me.FraCallout.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.FraCallout.Size = New System.Drawing.Size(267, 21)
        Me.FraCallout.TabIndex = 30
        Me.FraCallout.Visible = false
        '
        'TxtCalloutMins
        '
        Me.TxtCalloutMins.AcceptsReturn = true
        Me.TxtCalloutMins.BackColor = System.Drawing.SystemColors.Window
        Me.TxtCalloutMins.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtCalloutMins.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.TxtCalloutMins.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtCalloutMins.Location = New System.Drawing.Point(44, 0)
        Me.TxtCalloutMins.MaxLength = 0
        Me.TxtCalloutMins.Name = "TxtCalloutMins"
        Me.TxtCalloutMins.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtCalloutMins.Size = New System.Drawing.Size(39, 20)
        Me.TxtCalloutMins.TabIndex = 32
        '
        'TxtCalloutDate
        '
        Me.TxtCalloutDate.AcceptsReturn = true
        Me.TxtCalloutDate.BackColor = System.Drawing.SystemColors.Window
        Me.TxtCalloutDate.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtCalloutDate.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.TxtCalloutDate.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtCalloutDate.Location = New System.Drawing.Point(150, 0)
        Me.TxtCalloutDate.MaxLength = 0
        Me.TxtCalloutDate.Name = "TxtCalloutDate"
        Me.TxtCalloutDate.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtCalloutDate.Size = New System.Drawing.Size(114, 20)
        Me.TxtCalloutDate.TabIndex = 31
        '
        '_LblCallout_0
        '
        Me._LblCallout_0.AutoSize = true
        Me._LblCallout_0.BackColor = System.Drawing.SystemColors.Control
        Me._LblCallout_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblCallout_0.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me._LblCallout_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblCallout.SetIndex(Me._LblCallout_0, CType(0,Short))
        Me._LblCallout_0.Location = New System.Drawing.Point(0, 4)
        Me._LblCallout_0.Name = "_LblCallout_0"
        Me._LblCallout_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblCallout_0.Size = New System.Drawing.Size(47, 14)
        Me._LblCallout_0.TabIndex = 35
        Me._LblCallout_0.Text = "Callback"
        '
        '_label_5
        '
        Me._label_5.AutoSize = true
        Me._label_5.BackColor = System.Drawing.SystemColors.Control
        Me._label_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._label_5.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me._label_5.ForeColor = System.Drawing.SystemColors.ControlText
        Me.label.SetIndex(Me._label_5, CType(5,Short))
        Me._label_5.Location = New System.Drawing.Point(86, 4)
        Me._label_5.Name = "_label_5"
        Me._label_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._label_5.Size = New System.Drawing.Size(68, 14)
        Me._label_5.TabIndex = 34
        Me._label_5.Text = "min.  or after"
        '
        '_LblCallout_1
        '
        Me._LblCallout_1.AutoSize = true
        Me._LblCallout_1.BackColor = System.Drawing.SystemColors.Control
        Me._LblCallout_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblCallout_1.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me._LblCallout_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblCallout.SetIndex(Me._LblCallout_1, CType(1,Short))
        Me._LblCallout_1.Location = New System.Drawing.Point(0, 4)
        Me._LblCallout_1.Name = "_LblCallout_1"
        Me._LblCallout_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblCallout_1.Size = New System.Drawing.Size(39, 14)
        Me._LblCallout_1.TabIndex = 33
        Me._LblCallout_1.Text = "Callout"
        '
        'TxtContactName
        '
        Me.TxtContactName.AcceptsReturn = true
        Me.TxtContactName.BackColor = System.Drawing.SystemColors.Window
        Me.TxtContactName.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtContactName.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.TxtContactName.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtContactName.Location = New System.Drawing.Point(50, 46)
        Me.TxtContactName.MaxLength = 0
        Me.TxtContactName.Name = "TxtContactName"
        Me.TxtContactName.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtContactName.Size = New System.Drawing.Size(221, 20)
        Me.TxtContactName.TabIndex = 11
        '
        'TxtContactPhone
        '
        Me.TxtContactPhone.AcceptsReturn = true
        Me.TxtContactPhone.BackColor = System.Drawing.SystemColors.Window
        Me.TxtContactPhone.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtContactPhone.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.TxtContactPhone.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtContactPhone.Location = New System.Drawing.Point(50, 94)
        Me.TxtContactPhone.MaxLength = 0
        Me.TxtContactPhone.Name = "TxtContactPhone"
        Me.TxtContactPhone.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtContactPhone.Size = New System.Drawing.Size(221, 20)
        Me.TxtContactPhone.TabIndex = 13
        '
        'TxtContactDate
        '
        Me.TxtContactDate.AcceptsReturn = true
        Me.TxtContactDate.BackColor = System.Drawing.SystemColors.Window
        Me.TxtContactDate.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtContactDate.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.TxtContactDate.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtContactDate.Location = New System.Drawing.Point(50, 16)
        Me.TxtContactDate.MaxLength = 0
        Me.TxtContactDate.Name = "TxtContactDate"
        Me.TxtContactDate.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtContactDate.Size = New System.Drawing.Size(91, 20)
        Me.TxtContactDate.TabIndex = 10
        Me.TxtContactDate.Text = "00/00/00  00:00"
        '
        'TxtContactOrg
        '
        Me.TxtContactOrg.AcceptsReturn = true
        Me.TxtContactOrg.BackColor = System.Drawing.SystemColors.Window
        Me.TxtContactOrg.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtContactOrg.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.TxtContactOrg.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtContactOrg.Location = New System.Drawing.Point(50, 70)
        Me.TxtContactOrg.MaxLength = 0
        Me.TxtContactOrg.Name = "TxtContactOrg"
        Me.TxtContactOrg.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtContactOrg.Size = New System.Drawing.Size(221, 20)
        Me.TxtContactOrg.TabIndex = 12
        '
        'lblEmail
        '
        Me.lblEmail.AutoSize = true
        Me.lblEmail.BackColor = System.Drawing.SystemColors.Control
        Me.lblEmail.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblEmail.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.lblEmail.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblEmail.Location = New System.Drawing.Point(6, 98)
        Me.lblEmail.Name = "lblEmail"
        Me.lblEmail.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblEmail.Size = New System.Drawing.Size(40, 14)
        Me.lblEmail.TabIndex = 36
        Me.lblEmail.Text = "Email   "
        Me.lblEmail.Visible = false
        '
        'LblContactName
        '
        Me.LblContactName.BackColor = System.Drawing.SystemColors.Control
        Me.LblContactName.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblContactName.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.LblContactName.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblContactName.Location = New System.Drawing.Point(6, 50)
        Me.LblContactName.Name = "LblContactName"
        Me.LblContactName.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblContactName.Size = New System.Drawing.Size(41, 15)
        Me.LblContactName.TabIndex = 22
        Me.LblContactName.Text = "Name"
        '
        'LblContactPhone
        '
        Me.LblContactPhone.AutoSize = true
        Me.LblContactPhone.BackColor = System.Drawing.SystemColors.Control
        Me.LblContactPhone.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblContactPhone.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.LblContactPhone.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblContactPhone.Location = New System.Drawing.Point(6, 98)
        Me.LblContactPhone.Name = "LblContactPhone"
        Me.LblContactPhone.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblContactPhone.Size = New System.Drawing.Size(37, 14)
        Me.LblContactPhone.TabIndex = 21
        Me.LblContactPhone.Text = "Phone"
        '
        '_LblContact_2
        '
        Me._LblContact_2.AutoSize = true
        Me._LblContact_2.BackColor = System.Drawing.SystemColors.Control
        Me._LblContact_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblContact_2.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me._LblContact_2.ForeColor = System.Drawing.Color.Black
        Me.LblContact.SetIndex(Me._LblContact_2, CType(2,Short))
        Me._LblContact_2.Location = New System.Drawing.Point(6, 20)
        Me._LblContact_2.Name = "_LblContact_2"
        Me._LblContact_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblContact_2.Size = New System.Drawing.Size(29, 14)
        Me._LblContact_2.TabIndex = 19
        Me._LblContact_2.Text = "Date"
        '
        'LblContactOrg
        '
        Me.LblContactOrg.BackColor = System.Drawing.SystemColors.Control
        Me.LblContactOrg.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblContactOrg.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.LblContactOrg.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblContactOrg.Location = New System.Drawing.Point(6, 74)
        Me.LblContactOrg.Name = "LblContactOrg"
        Me.LblContactOrg.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblContactOrg.Size = New System.Drawing.Size(41, 15)
        Me.LblContactOrg.TabIndex = 18
        Me.LblContactOrg.Text = "Org."
        '
        'CboContactEventType
        '
        Me.CboContactEventType.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboContactEventType.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboContactEventType.BackColor = System.Drawing.SystemColors.Window
        Me.CboContactEventType.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboContactEventType.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboContactEventType.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.CboContactEventType.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboContactEventType.Location = New System.Drawing.Point(346, 480)
        Me.CboContactEventType.Name = "CboContactEventType"
        Me.CboContactEventType.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboContactEventType.Size = New System.Drawing.Size(209, 22)
        Me.CboContactEventType.TabIndex = 4
        '
        'TxtContactDesc
        '
        Me.TxtContactDesc.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.TxtContactDesc.Location = New System.Drawing.Point(288, 518)
        Me.TxtContactDesc.MaxLength = 999
        Me.TxtContactDesc.Name = "TxtContactDesc"
        Me.TxtContactDesc.RightMargin = 245
        Me.TxtContactDesc.ScrollBars = System.Windows.Forms.RichTextBoxScrollBars.Vertical
        Me.TxtContactDesc.Size = New System.Drawing.Size(267, 93)
        Me.TxtContactDesc.TabIndex = 5
        Me.TxtContactDesc.Text = ""
        '
        '_LblContact_3
        '
        Me._LblContact_3.AutoSize = true
        Me._LblContact_3.BackColor = System.Drawing.SystemColors.Control
        Me._LblContact_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblContact_3.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me._LblContact_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblContact.SetIndex(Me._LblContact_3, CType(3,Short))
        Me._LblContact_3.Location = New System.Drawing.Point(286, 480)
        Me._LblContact_3.Name = "_LblContact_3"
        Me._LblContact_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblContact_3.Size = New System.Drawing.Size(60, 14)
        Me._LblContact_3.TabIndex = 20
        Me._LblContact_3.Text = "Event Type"
        '
        'FrmOnCallEvent
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6!, 14!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.ClientSize = New System.Drawing.Size(644, 617)
        Me.ControlBox = false
        Me.Controls.Add(Me.ChkConfirmed)
        Me.Controls.Add(Me.ChkShowAll)
        Me.Controls.Add(Me.CmdOK)
        Me.Controls.Add(Me.CboContactEventType)
        Me.Controls.Add(Me.CmdCancel)
        Me.Controls.Add(Me.TxtContactDesc)
        Me.Controls.Add(Me._FraReferral_0)
        Me.Controls.Add(Me.FraContact)
        Me.Controls.Add(Me._LblContact_3)
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.Icon = CType(resources.GetObject("$this.Icon"),System.Drawing.Icon)
        Me.Location = New System.Drawing.Point(163, 277)
        Me.MaximizeBox = false
        Me.Name = "FrmOnCallEvent"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "On Call"
        Me._FraReferral_0.ResumeLayout(false)
        Me._FraReferral_0.PerformLayout
        Me.TabNotes.ResumeLayout(false)
        Me._TabNotes_TabPage0.ResumeLayout(false)
        Me._TabNotes_TabPage1.ResumeLayout(false)
        Me._TabNotes_TabPage2.ResumeLayout(false)
        Me.FraContact.ResumeLayout(false)
        Me.FraContact.PerformLayout
        Me.FraCallout.ResumeLayout(false)
        Me.FraCallout.PerformLayout
        CType(Me.FraReferral,System.ComponentModel.ISupportInitialize).EndInit
        CType(Me.LblCallout,System.ComponentModel.ISupportInitialize).EndInit
        CType(Me.LblContact,System.ComponentModel.ISupportInitialize).EndInit
        CType(Me.label,System.ComponentModel.ISupportInitialize).EndInit
        Me.ResumeLayout(false)
        Me.PerformLayout

End Sub
    Public WithEvents txtMessageNotes As System.Windows.Forms.RichTextBox
#End Region 
End Class