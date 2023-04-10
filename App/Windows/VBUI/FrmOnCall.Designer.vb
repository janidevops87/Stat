<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmOnCall
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
        ''StatTrac.MDIFormStatLine.Show
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
	Public WithEvents CmdAlpha As System.Windows.Forms.Button
	Public WithEvents CmdSchedule As System.Windows.Forms.Button
	Public WithEvents ChkShowAll As System.Windows.Forms.CheckBox
	Public WithEvents CmdCancel As System.Windows.Forms.Button
	Public WithEvents CboScheduleGroup As System.Windows.Forms.ComboBox
	Public WithEvents CboOrganization As System.Windows.Forms.ComboBox
	Public WithEvents TxtPersonNotes As System.Windows.Forms.TextBox
	Public WithEvents LstViewContact As System.Windows.Forms.ListView
	Public WithEvents LstViewPerson As System.Windows.Forms.ListView
    Public WithEvents _TabNotes_TabPage0 As System.Windows.Forms.TabPage
    Public WithEvents _Label_4 As System.Windows.Forms.Label
    Public WithEvents _TabNotes_TabPage1 As System.Windows.Forms.TabPage
    Public WithEvents TxtScheduleReferralNotes As System.Windows.Forms.TextBox
    Public WithEvents _TabNotes_TabPage2 As System.Windows.Forms.TabPage
    Public WithEvents TxtScheduleMessageNotes As System.Windows.Forms.TextBox
    Public WithEvents _TabNotes_TabPage3 As System.Windows.Forms.TabPage
    Public WithEvents TabNotes As System.Windows.Forms.TabControl
    Public WithEvents LblShift As System.Windows.Forms.Label
    Public WithEvents _Label_0 As System.Windows.Forms.Label
    Public WithEvents _FraReferral_0 As System.Windows.Forms.GroupBox
    Public WithEvents FraReferral As Microsoft.VisualBasic.Compatibility.VB6.GroupBoxArray
    Public WithEvents Label As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FrmOnCall))
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.CmdAlpha = New System.Windows.Forms.Button()
        Me.CmdSchedule = New System.Windows.Forms.Button()
        Me.ChkShowAll = New System.Windows.Forms.CheckBox()
        Me.CmdCancel = New System.Windows.Forms.Button()
        Me._FraReferral_0 = New System.Windows.Forms.GroupBox()
        Me.lblBusy = New System.Windows.Forms.Label()
        Me.FlowLayoutPanel1 = New System.Windows.Forms.FlowLayoutPanel()
        Me.TabNotes = New System.Windows.Forms.TabControl()
        Me._TabNotes_TabPage0 = New System.Windows.Forms.TabPage()
        Me._TabNotes_TabPage1 = New System.Windows.Forms.TabPage()
        Me._TabNotes_TabPage2 = New System.Windows.Forms.TabPage()
        Me.TxtScheduleReferralNotes = New System.Windows.Forms.TextBox()
        Me._TabNotes_TabPage3 = New System.Windows.Forms.TabPage()
        Me.TxtScheduleMessageNotes = New System.Windows.Forms.TextBox()
        Me.LstViewPerson = New System.Windows.Forms.ListView()
        Me.TxtPersonNotes = New System.Windows.Forms.TextBox()
        Me.LstViewContact = New System.Windows.Forms.ListView()
        Me.CboScheduleGroup = New System.Windows.Forms.ComboBox()
        Me.CboOrganization = New System.Windows.Forms.ComboBox()
        Me.LblShift = New System.Windows.Forms.Label()
        Me._Label_4 = New System.Windows.Forms.Label()
        Me._Label_0 = New System.Windows.Forms.Label()
        Me.FraReferral = New Microsoft.VisualBasic.Compatibility.VB6.GroupBoxArray(Me.components)
        Me.Label = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(Me.components)
        Me.TxtMessageNotes = New Statline.Stattrac.Windows.Forms.RichTextBox()
        Me.TxtReferralNotes = New Statline.Stattrac.Windows.Forms.RichTextBox()
        Me._FraReferral_0.SuspendLayout()
        Me.FlowLayoutPanel1.SuspendLayout()
        Me.TabNotes.SuspendLayout()
        Me._TabNotes_TabPage0.SuspendLayout()
        Me._TabNotes_TabPage1.SuspendLayout()
        Me._TabNotes_TabPage2.SuspendLayout()
        Me._TabNotes_TabPage3.SuspendLayout()
        CType(Me.FraReferral, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.Label, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'CmdAlpha
        '
        Me.CmdAlpha.BackColor = System.Drawing.SystemColors.Control
        Me.CmdAlpha.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdAlpha.Enabled = False
        Me.CmdAlpha.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdAlpha.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdAlpha.Location = New System.Drawing.Point(605, 184)
        Me.CmdAlpha.Name = "CmdAlpha"
        Me.CmdAlpha.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdAlpha.Size = New System.Drawing.Size(80, 21)
        Me.CmdAlpha.TabIndex = 103
        Me.CmdAlpha.TabStop = False
        Me.CmdAlpha.Text = "Send &Alpha..."
        Me.CmdAlpha.UseVisualStyleBackColor = False
        '
        'CmdSchedule
        '
        Me.CmdSchedule.BackColor = System.Drawing.SystemColors.Control
        Me.CmdSchedule.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdSchedule.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdSchedule.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdSchedule.Location = New System.Drawing.Point(605, 10)
        Me.CmdSchedule.Name = "CmdSchedule"
        Me.CmdSchedule.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdSchedule.Size = New System.Drawing.Size(80, 21)
        Me.CmdSchedule.TabIndex = 101
        Me.CmdSchedule.TabStop = False
        Me.CmdSchedule.Text = "&Schedule..."
        Me.CmdSchedule.UseVisualStyleBackColor = False
        '
        'ChkShowAll
        '
        Me.ChkShowAll.BackColor = System.Drawing.SystemColors.Control
        Me.ChkShowAll.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkShowAll.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkShowAll.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkShowAll.Location = New System.Drawing.Point(607, 94)
        Me.ChkShowAll.Name = "ChkShowAll"
        Me.ChkShowAll.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkShowAll.Size = New System.Drawing.Size(71, 25)
        Me.ChkShowAll.TabIndex = 102
        Me.ChkShowAll.TabStop = False
        Me.ChkShowAll.Text = "Show All"
        Me.ChkShowAll.UseVisualStyleBackColor = False
        '
        'CmdCancel
        '
        Me.CmdCancel.BackColor = System.Drawing.SystemColors.Control
        Me.CmdCancel.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdCancel.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdCancel.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdCancel.Location = New System.Drawing.Point(605, 414)
        Me.CmdCancel.Name = "CmdCancel"
        Me.CmdCancel.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdCancel.Size = New System.Drawing.Size(80, 21)
        Me.CmdCancel.TabIndex = 105
        Me.CmdCancel.Text = "&Close"
        Me.CmdCancel.UseVisualStyleBackColor = False
        '
        '_FraReferral_0
        '
        Me._FraReferral_0.BackColor = System.Drawing.SystemColors.Control
        Me._FraReferral_0.Controls.Add(Me.lblBusy)
        Me._FraReferral_0.Controls.Add(Me.FlowLayoutPanel1)
        Me._FraReferral_0.Controls.Add(Me.CboScheduleGroup)
        Me._FraReferral_0.Controls.Add(Me.CboOrganization)
        Me._FraReferral_0.Controls.Add(Me.LblShift)
        Me._FraReferral_0.Controls.Add(Me._Label_4)
        Me._FraReferral_0.Controls.Add(Me._Label_0)
        Me._FraReferral_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._FraReferral_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.FraReferral.SetIndex(Me._FraReferral_0, CType(0, Short))
        Me._FraReferral_0.Location = New System.Drawing.Point(2, 2)
        Me._FraReferral_0.Name = "_FraReferral_0"
        Me._FraReferral_0.Padding = New System.Windows.Forms.Padding(0)
        Me._FraReferral_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._FraReferral_0.Size = New System.Drawing.Size(597, 433)
        Me._FraReferral_0.TabIndex = 1
        Me._FraReferral_0.TabStop = False
        '
        'lblBusy
        '
        Me.lblBusy.BackColor = System.Drawing.SystemColors.Control
        Me.lblBusy.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblBusy.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblBusy.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblBusy.Location = New System.Drawing.Point(8, 38)
        Me.lblBusy.Name = "lblBusy"
        Me.lblBusy.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblBusy.Size = New System.Drawing.Size(199, 13)
        Me.lblBusy.TabIndex = 16
        Me.lblBusy.Visible = False
        '
        'FlowLayoutPanel1
        '
        Me.FlowLayoutPanel1.Controls.Add(Me.TabNotes)
        Me.FlowLayoutPanel1.Controls.Add(Me.LstViewPerson)
        Me.FlowLayoutPanel1.Controls.Add(Me.TxtPersonNotes)
        Me.FlowLayoutPanel1.Controls.Add(Me.LstViewContact)
        Me.FlowLayoutPanel1.Location = New System.Drawing.Point(4, 61)
        Me.FlowLayoutPanel1.Name = "FlowLayoutPanel1"
        Me.FlowLayoutPanel1.Size = New System.Drawing.Size(589, 367)
        Me.FlowLayoutPanel1.TabIndex = 10
        '
        'TabNotes
        '
        Me.TabNotes.Controls.Add(Me._TabNotes_TabPage0)
        Me.TabNotes.Controls.Add(Me._TabNotes_TabPage1)
        Me.TabNotes.Controls.Add(Me._TabNotes_TabPage2)
        Me.TabNotes.Controls.Add(Me._TabNotes_TabPage3)
        Me.TabNotes.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TabNotes.ItemSize = New System.Drawing.Size(42, 18)
        Me.TabNotes.Location = New System.Drawing.Point(3, 3)
        Me.TabNotes.Name = "TabNotes"
        Me.TabNotes.SelectedIndex = 1
        Me.TabNotes.Size = New System.Drawing.Size(286, 194)
        Me.TabNotes.TabIndex = 200
        Me.TabNotes.TabStop = False
        '
        '_TabNotes_TabPage0
        '
        Me._TabNotes_TabPage0.CausesValidation = False
        Me._TabNotes_TabPage0.Controls.Add(Me.TxtReferralNotes)
        Me._TabNotes_TabPage0.Location = New System.Drawing.Point(4, 22)
        Me._TabNotes_TabPage0.Name = "_TabNotes_TabPage0"
        Me._TabNotes_TabPage0.Size = New System.Drawing.Size(278, 168)
        Me._TabNotes_TabPage0.TabIndex = 0
        Me._TabNotes_TabPage0.Text = "Org-Ref"
        Me._TabNotes_TabPage0.UseVisualStyleBackColor = True
        '
        '_TabNotes_TabPage1
        '
        Me._TabNotes_TabPage1.CausesValidation = False
        Me._TabNotes_TabPage1.Controls.Add(Me.TxtMessageNotes)
        Me._TabNotes_TabPage1.Location = New System.Drawing.Point(4, 22)
        Me._TabNotes_TabPage1.Name = "_TabNotes_TabPage1"
        Me._TabNotes_TabPage1.Size = New System.Drawing.Size(278, 168)
        Me._TabNotes_TabPage1.TabIndex = 1
        Me._TabNotes_TabPage1.Text = "Org-Msg"
        Me._TabNotes_TabPage1.UseVisualStyleBackColor = True
        '
        '_TabNotes_TabPage2
        '
        Me._TabNotes_TabPage2.CausesValidation = False
        Me._TabNotes_TabPage2.Controls.Add(Me.TxtScheduleReferralNotes)
        Me._TabNotes_TabPage2.Location = New System.Drawing.Point(4, 22)
        Me._TabNotes_TabPage2.Name = "_TabNotes_TabPage2"
        Me._TabNotes_TabPage2.Size = New System.Drawing.Size(278, 168)
        Me._TabNotes_TabPage2.TabIndex = 2
        Me._TabNotes_TabPage2.Text = "Sch-Ref"
        Me._TabNotes_TabPage2.UseVisualStyleBackColor = True
        '
        'TxtScheduleReferralNotes
        '
        Me.TxtScheduleReferralNotes.AcceptsReturn = True
        Me.TxtScheduleReferralNotes.BackColor = System.Drawing.Color.White
        Me.TxtScheduleReferralNotes.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtScheduleReferralNotes.Dock = System.Windows.Forms.DockStyle.Fill
        Me.TxtScheduleReferralNotes.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtScheduleReferralNotes.ForeColor = System.Drawing.Color.Black
        Me.TxtScheduleReferralNotes.Location = New System.Drawing.Point(0, 0)
        Me.TxtScheduleReferralNotes.MaxLength = 0
        Me.TxtScheduleReferralNotes.Multiline = True
        Me.TxtScheduleReferralNotes.Name = "TxtScheduleReferralNotes"
        Me.TxtScheduleReferralNotes.ReadOnly = True
        Me.TxtScheduleReferralNotes.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtScheduleReferralNotes.Size = New System.Drawing.Size(278, 168)
        Me.TxtScheduleReferralNotes.TabIndex = 16
        Me.TxtScheduleReferralNotes.TabStop = False
        '
        '_TabNotes_TabPage3
        '
        Me._TabNotes_TabPage3.CausesValidation = False
        Me._TabNotes_TabPage3.Controls.Add(Me.TxtScheduleMessageNotes)
        Me._TabNotes_TabPage3.Location = New System.Drawing.Point(4, 22)
        Me._TabNotes_TabPage3.Name = "_TabNotes_TabPage3"
        Me._TabNotes_TabPage3.Size = New System.Drawing.Size(278, 168)
        Me._TabNotes_TabPage3.TabIndex = 3
        Me._TabNotes_TabPage3.Text = "Sch-Msg"
        Me._TabNotes_TabPage3.UseVisualStyleBackColor = True
        '
        'TxtScheduleMessageNotes
        '
        Me.TxtScheduleMessageNotes.AcceptsReturn = True
        Me.TxtScheduleMessageNotes.BackColor = System.Drawing.Color.White
        Me.TxtScheduleMessageNotes.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtScheduleMessageNotes.Dock = System.Windows.Forms.DockStyle.Fill
        Me.TxtScheduleMessageNotes.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtScheduleMessageNotes.ForeColor = System.Drawing.Color.Black
        Me.TxtScheduleMessageNotes.Location = New System.Drawing.Point(0, 0)
        Me.TxtScheduleMessageNotes.MaxLength = 0
        Me.TxtScheduleMessageNotes.Multiline = True
        Me.TxtScheduleMessageNotes.Name = "TxtScheduleMessageNotes"
        Me.TxtScheduleMessageNotes.ReadOnly = True
        Me.TxtScheduleMessageNotes.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtScheduleMessageNotes.Size = New System.Drawing.Size(278, 168)
        Me.TxtScheduleMessageNotes.TabIndex = 18
        Me.TxtScheduleMessageNotes.TabStop = False
        '
        'LstViewPerson
        '
        Me.LstViewPerson.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewPerson.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.LstViewPerson.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewPerson.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewPerson.FullRowSelect = True
        Me.LstViewPerson.LabelWrap = False
        Me.LstViewPerson.Location = New System.Drawing.Point(295, 3)
        Me.LstViewPerson.Name = "LstViewPerson"
        Me.LstViewPerson.Size = New System.Drawing.Size(286, 194)
        Me.LstViewPerson.TabIndex = 11
        Me.LstViewPerson.UseCompatibleStateImageBehavior = False
        Me.LstViewPerson.View = System.Windows.Forms.View.Details
        '
        'TxtPersonNotes
        '
        Me.TxtPersonNotes.AcceptsReturn = True
        Me.TxtPersonNotes.BackColor = System.Drawing.Color.White
        Me.TxtPersonNotes.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtPersonNotes.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtPersonNotes.ForeColor = System.Drawing.Color.Black
        Me.TxtPersonNotes.Location = New System.Drawing.Point(3, 203)
        Me.TxtPersonNotes.MaxLength = 0
        Me.TxtPersonNotes.Multiline = True
        Me.TxtPersonNotes.Name = "TxtPersonNotes"
        Me.TxtPersonNotes.ReadOnly = True
        Me.TxtPersonNotes.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtPersonNotes.Size = New System.Drawing.Size(286, 158)
        Me.TxtPersonNotes.TabIndex = 0
        Me.TxtPersonNotes.TabStop = False
        '
        'LstViewContact
        '
        Me.LstViewContact.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewContact.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.LstViewContact.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewContact.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewContact.FullRowSelect = True
        Me.LstViewContact.LabelWrap = False
        Me.LstViewContact.Location = New System.Drawing.Point(295, 203)
        Me.LstViewContact.Name = "LstViewContact"
        Me.LstViewContact.Size = New System.Drawing.Size(286, 158)
        Me.LstViewContact.TabIndex = 12
        Me.LstViewContact.UseCompatibleStateImageBehavior = False
        Me.LstViewContact.View = System.Windows.Forms.View.Details
        '
        'CboScheduleGroup
        '
        Me.CboScheduleGroup.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboScheduleGroup.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboScheduleGroup.BackColor = System.Drawing.SystemColors.Window
        Me.CboScheduleGroup.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboScheduleGroup.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboScheduleGroup.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboScheduleGroup.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboScheduleGroup.Location = New System.Drawing.Point(374, 38)
        Me.CboScheduleGroup.Name = "CboScheduleGroup"
        Me.CboScheduleGroup.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboScheduleGroup.Size = New System.Drawing.Size(213, 22)
        Me.CboScheduleGroup.Sorted = True
        Me.CboScheduleGroup.TabIndex = 3
        '
        'CboOrganization
        '
        Me.CboOrganization.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboOrganization.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboOrganization.BackColor = System.Drawing.SystemColors.Window
        Me.CboOrganization.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboOrganization.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboOrganization.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboOrganization.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboOrganization.Location = New System.Drawing.Point(374, 14)
        Me.CboOrganization.Name = "CboOrganization"
        Me.CboOrganization.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboOrganization.Size = New System.Drawing.Size(213, 22)
        Me.CboOrganization.Sorted = True
        Me.CboOrganization.TabIndex = 2
        '
        'LblShift
        '
        Me.LblShift.BackColor = System.Drawing.SystemColors.Control
        Me.LblShift.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblShift.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblShift.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblShift.Location = New System.Drawing.Point(8, 18)
        Me.LblShift.Name = "LblShift"
        Me.LblShift.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblShift.Size = New System.Drawing.Size(199, 13)
        Me.LblShift.TabIndex = 15
        Me.LblShift.Text = "00:00 - 00:00"
        '
        '_Label_4
        '
        Me._Label_4.AutoSize = True
        Me._Label_4.BackColor = System.Drawing.SystemColors.Control
        Me._Label_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_4.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_4.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_4, CType(4, Short))
        Me._Label_4.Location = New System.Drawing.Point(324, 41)
        Me._Label_4.Name = "_Label_4"
        Me._Label_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_4.Size = New System.Drawing.Size(52, 14)
        Me._Label_4.TabIndex = 14
        Me._Label_4.Text = "Schedule"
        '
        '_Label_0
        '
        Me._Label_0.AutoSize = True
        Me._Label_0.BackColor = System.Drawing.SystemColors.Control
        Me._Label_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_0, CType(0, Short))
        Me._Label_0.Location = New System.Drawing.Point(308, 18)
        Me._Label_0.Name = "_Label_0"
        Me._Label_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_0.Size = New System.Drawing.Size(68, 14)
        Me._Label_0.TabIndex = 6
        Me._Label_0.Text = "Organization"
        '
        'TxtMessageNotes
        '
        Me.TxtMessageNotes.Location = New System.Drawing.Point(0, 0)
        Me.TxtMessageNotes.Name = "TxtMessageNotes"
        Me.TxtMessageNotes.Required = False
        Me.TxtMessageNotes.Size = New System.Drawing.Size(278, 168)
        Me.TxtMessageNotes.SpellCheckEnabled = False
        Me.TxtMessageNotes.TabIndex = 0
        Me.TxtMessageNotes.Text = ""
        '
        'TxtReferralNotes
        '
        Me.TxtReferralNotes.Location = New System.Drawing.Point(0, 0)
        Me.TxtReferralNotes.Name = "TxtReferralNotes"
        Me.TxtReferralNotes.Required = False
        Me.TxtReferralNotes.Size = New System.Drawing.Size(278, 168)
        Me.TxtReferralNotes.SpellCheckEnabled = False
        Me.TxtReferralNotes.TabIndex = 0
        Me.TxtReferralNotes.Text = ""
        '
        'FrmOnCall
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 14.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.ClientSize = New System.Drawing.Size(706, 437)
        Me.Controls.Add(Me.CmdAlpha)
        Me.Controls.Add(Me.CmdSchedule)
        Me.Controls.Add(Me.ChkShowAll)
        Me.Controls.Add(Me.CmdCancel)
        Me.Controls.Add(Me._FraReferral_0)
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Location = New System.Drawing.Point(95, 178)
        Me.MaximizeBox = False
        Me.Name = "FrmOnCall"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent
        Me.Text = "On Call"
        Me._FraReferral_0.ResumeLayout(False)
        Me._FraReferral_0.PerformLayout()
        Me.FlowLayoutPanel1.ResumeLayout(False)
        Me.FlowLayoutPanel1.PerformLayout()
        Me.TabNotes.ResumeLayout(False)
        Me._TabNotes_TabPage0.ResumeLayout(False)
        Me._TabNotes_TabPage1.ResumeLayout(False)
        Me._TabNotes_TabPage2.ResumeLayout(False)
        Me._TabNotes_TabPage2.PerformLayout()
        Me._TabNotes_TabPage3.ResumeLayout(False)
        Me._TabNotes_TabPage3.PerformLayout()
        CType(Me.FraReferral, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.Label, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)

    End Sub
    Friend WithEvents FlowLayoutPanel1 As System.Windows.Forms.FlowLayoutPanel
    Public WithEvents lblBusy As System.Windows.Forms.Label
    Public WithEvents TxtReferralNotes As Statline.Stattrac.Windows.Forms.RichTextBox
    Public WithEvents TxtMessageNotes As Statline.Stattrac.Windows.Forms.RichTextBox
#End Region
End Class