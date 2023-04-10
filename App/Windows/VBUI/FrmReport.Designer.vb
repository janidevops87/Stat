<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmReport
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
	Public WithEvents CmdCancel As System.Windows.Forms.Button
	Public WithEvents CboReportParent As System.Windows.Forms.ComboBox
	Public WithEvents CmdSelectParentOrg As System.Windows.Forms.Button
	Public WithEvents cmdDeleteGroup As System.Windows.Forms.Button
	Public WithEvents CmdReportGroupDetail As System.Windows.Forms.Button
	Public WithEvents CboReportGroup As System.Windows.Forms.ComboBox
	Public WithEvents _Lable_0 As System.Windows.Forms.Label
	Public WithEvents _Lable_1 As System.Windows.Forms.Label
	Public WithEvents _Frame_1 As System.Windows.Forms.GroupBox
	Public WithEvents CmdUnassigned As System.Windows.Forms.Button
	Public WithEvents LstViewSelectedOrganizations As System.Windows.Forms.ListView
	Public WithEvents LstViewAvailableOrganizations As System.Windows.Forms.ListView
	Public WithEvents CboState As System.Windows.Forms.ComboBox
	Public WithEvents CmdFind As System.Windows.Forms.Button
	Public WithEvents CboOrganizationType As System.Windows.Forms.ComboBox
	Public WithEvents CmdDeselect As System.Windows.Forms.Button
	Public WithEvents CmdSelect As System.Windows.Forms.Button
	Public WithEvents _Lable_4 As System.Windows.Forms.Label
	Public WithEvents _Lable_2 As System.Windows.Forms.Label
	Public WithEvents _Lable_5 As System.Windows.Forms.Label
	Public WithEvents _Lable_3 As System.Windows.Forms.Label
	Public WithEvents _Frame_0 As System.Windows.Forms.GroupBox
	Public WithEvents _TabReport_TabPage0 As System.Windows.Forms.TabPage
	Public WithEvents ChkOTE As System.Windows.Forms.CheckBox
	Public WithEvents ChkRuleout As System.Windows.Forms.CheckBox
	Public WithEvents ChkTE As System.Windows.Forms.CheckBox
	Public WithEvents ChkEyeOnly As System.Windows.Forms.CheckBox
	Public WithEvents _Lable_10 As System.Windows.Forms.Label
	Public WithEvents _Frame_5 As System.Windows.Forms.GroupBox
	Public WithEvents TxtEndActive As System.Windows.Forms.TextBox
	Public WithEvents CmdAddAccess As System.Windows.Forms.Button
	Public WithEvents CmdRemoveAccess As System.Windows.Forms.Button
	Public WithEvents TxtStartActive As System.Windows.Forms.TextBox
	Public WithEvents _ChkResearch_1 As System.Windows.Forms.CheckBox
	Public WithEvents _ChkOrgans_1 As System.Windows.Forms.CheckBox
	Public WithEvents _ChkSkin_1 As System.Windows.Forms.CheckBox
	Public WithEvents _ChkHeartValves_1 As System.Windows.Forms.CheckBox
	Public WithEvents _ChkBone_1 As System.Windows.Forms.CheckBox
	Public WithEvents _ChkEyes_1 As System.Windows.Forms.CheckBox
	Public WithEvents _ChkSoftTissue_1 As System.Windows.Forms.CheckBox
	Public WithEvents _Frame_4 As System.Windows.Forms.GroupBox
	Public WithEvents _ChkSoftTissue_0 As System.Windows.Forms.CheckBox
	Public WithEvents _ChkEyes_0 As System.Windows.Forms.CheckBox
	Public WithEvents _ChkBone_0 As System.Windows.Forms.CheckBox
	Public WithEvents _ChkHeartValves_0 As System.Windows.Forms.CheckBox
	Public WithEvents _ChkSkin_0 As System.Windows.Forms.CheckBox
	Public WithEvents _ChkOrgans_0 As System.Windows.Forms.CheckBox
	Public WithEvents _ChkResearch_0 As System.Windows.Forms.CheckBox
	Public WithEvents _Frame_3 As System.Windows.Forms.GroupBox
	Public WithEvents CmdRemove As System.Windows.Forms.Button
	Public WithEvents CmdAdd As System.Windows.Forms.Button
	Public WithEvents LstViewSourceCodes As System.Windows.Forms.ListView
	Public WithEvents LstViewDateAccess As System.Windows.Forms.ListView
	Public WithEvents _Lable_9 As System.Windows.Forms.Label
	Public WithEvents _Lable_8 As System.Windows.Forms.Label
	Public WithEvents _Label_1 As System.Windows.Forms.Label
	Public WithEvents _Label_0 As System.Windows.Forms.Label
	Public WithEvents Label1 As System.Windows.Forms.Label
	Public WithEvents _Lable_7 As System.Windows.Forms.Label
	Public WithEvents _Lable_6 As System.Windows.Forms.Label
	Public WithEvents _Frame_2 As System.Windows.Forms.GroupBox
	Public WithEvents _TabReport_TabPage1 As System.Windows.Forms.TabPage
	Public WithEvents TabReport As System.Windows.Forms.TabControl
	Public WithEvents ChkBone As Microsoft.VisualBasic.Compatibility.VB6.CheckBoxArray
	Public WithEvents ChkEyes As Microsoft.VisualBasic.Compatibility.VB6.CheckBoxArray
	Public WithEvents ChkHeartValves As Microsoft.VisualBasic.Compatibility.VB6.CheckBoxArray
	Public WithEvents ChkOrgans As Microsoft.VisualBasic.Compatibility.VB6.CheckBoxArray
	Public WithEvents ChkResearch As Microsoft.VisualBasic.Compatibility.VB6.CheckBoxArray
	Public WithEvents ChkSkin As Microsoft.VisualBasic.Compatibility.VB6.CheckBoxArray
	Public WithEvents ChkSoftTissue As Microsoft.VisualBasic.Compatibility.VB6.CheckBoxArray
	Public WithEvents Frame As Microsoft.VisualBasic.Compatibility.VB6.GroupBoxArray
	Public WithEvents Label As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
	Public WithEvents Lable As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FrmReport))
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.CmdCancel = New System.Windows.Forms.Button()
        Me._Frame_1 = New System.Windows.Forms.GroupBox()
        Me.CboReportParent = New System.Windows.Forms.ComboBox()
        Me.CmdSelectParentOrg = New System.Windows.Forms.Button()
        Me.cmdDeleteGroup = New System.Windows.Forms.Button()
        Me.CmdReportGroupDetail = New System.Windows.Forms.Button()
        Me.CboReportGroup = New System.Windows.Forms.ComboBox()
        Me._Lable_0 = New System.Windows.Forms.Label()
        Me._Lable_1 = New System.Windows.Forms.Label()
        Me.TabReport = New System.Windows.Forms.TabControl()
        Me._TabReport_TabPage0 = New System.Windows.Forms.TabPage()
        Me._Frame_0 = New System.Windows.Forms.GroupBox()
        Me.CmdUnassigned = New System.Windows.Forms.Button()
        Me.LstViewSelectedOrganizations = New System.Windows.Forms.ListView()
        Me.LstViewAvailableOrganizations = New System.Windows.Forms.ListView()
        Me.CboState = New System.Windows.Forms.ComboBox()
        Me.CmdFind = New System.Windows.Forms.Button()
        Me.CboOrganizationType = New System.Windows.Forms.ComboBox()
        Me.CmdDeselect = New System.Windows.Forms.Button()
        Me.CmdSelect = New System.Windows.Forms.Button()
        Me._Lable_4 = New System.Windows.Forms.Label()
        Me._Lable_2 = New System.Windows.Forms.Label()
        Me._Lable_5 = New System.Windows.Forms.Label()
        Me._Lable_3 = New System.Windows.Forms.Label()
        Me._TabReport_TabPage1 = New System.Windows.Forms.TabPage()
        Me._Frame_2 = New System.Windows.Forms.GroupBox()
        Me._Frame_5 = New System.Windows.Forms.GroupBox()
        Me.ChkOTE = New System.Windows.Forms.CheckBox()
        Me.ChkRuleout = New System.Windows.Forms.CheckBox()
        Me.ChkTE = New System.Windows.Forms.CheckBox()
        Me.ChkEyeOnly = New System.Windows.Forms.CheckBox()
        Me._Lable_10 = New System.Windows.Forms.Label()
        Me.TxtEndActive = New System.Windows.Forms.TextBox()
        Me.CmdAddAccess = New System.Windows.Forms.Button()
        Me.CmdRemoveAccess = New System.Windows.Forms.Button()
        Me.TxtStartActive = New System.Windows.Forms.TextBox()
        Me._Frame_4 = New System.Windows.Forms.GroupBox()
        Me._ChkResearch_1 = New System.Windows.Forms.CheckBox()
        Me._ChkOrgans_1 = New System.Windows.Forms.CheckBox()
        Me._ChkSkin_1 = New System.Windows.Forms.CheckBox()
        Me._ChkHeartValves_1 = New System.Windows.Forms.CheckBox()
        Me._ChkBone_1 = New System.Windows.Forms.CheckBox()
        Me._ChkEyes_1 = New System.Windows.Forms.CheckBox()
        Me._ChkSoftTissue_1 = New System.Windows.Forms.CheckBox()
        Me._Frame_3 = New System.Windows.Forms.GroupBox()
        Me._ChkSoftTissue_0 = New System.Windows.Forms.CheckBox()
        Me._ChkEyes_0 = New System.Windows.Forms.CheckBox()
        Me._ChkBone_0 = New System.Windows.Forms.CheckBox()
        Me._ChkHeartValves_0 = New System.Windows.Forms.CheckBox()
        Me._ChkSkin_0 = New System.Windows.Forms.CheckBox()
        Me._ChkOrgans_0 = New System.Windows.Forms.CheckBox()
        Me._ChkResearch_0 = New System.Windows.Forms.CheckBox()
        Me.CmdRemove = New System.Windows.Forms.Button()
        Me.CmdAdd = New System.Windows.Forms.Button()
        Me.LstViewSourceCodes = New System.Windows.Forms.ListView()
        Me.LstViewDateAccess = New System.Windows.Forms.ListView()
        Me._Lable_9 = New System.Windows.Forms.Label()
        Me._Lable_8 = New System.Windows.Forms.Label()
        Me._Label_1 = New System.Windows.Forms.Label()
        Me._Label_0 = New System.Windows.Forms.Label()
        Me.Label1 = New System.Windows.Forms.Label()
        Me._Lable_7 = New System.Windows.Forms.Label()
        Me._Lable_6 = New System.Windows.Forms.Label()
        Me.ChkBone = New Microsoft.VisualBasic.Compatibility.VB6.CheckBoxArray(Me.components)
        Me.ChkEyes = New Microsoft.VisualBasic.Compatibility.VB6.CheckBoxArray(Me.components)
        Me.ChkHeartValves = New Microsoft.VisualBasic.Compatibility.VB6.CheckBoxArray(Me.components)
        Me.ChkOrgans = New Microsoft.VisualBasic.Compatibility.VB6.CheckBoxArray(Me.components)
        Me.ChkResearch = New Microsoft.VisualBasic.Compatibility.VB6.CheckBoxArray(Me.components)
        Me.ChkSkin = New Microsoft.VisualBasic.Compatibility.VB6.CheckBoxArray(Me.components)
        Me.ChkSoftTissue = New Microsoft.VisualBasic.Compatibility.VB6.CheckBoxArray(Me.components)
        Me.Frame = New Microsoft.VisualBasic.Compatibility.VB6.GroupBoxArray(Me.components)
        Me.Label = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(Me.components)
        Me.Lable = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(Me.components)
        Me._Frame_1.SuspendLayout()
        Me.TabReport.SuspendLayout()
        Me._TabReport_TabPage0.SuspendLayout()
        Me._Frame_0.SuspendLayout()
        Me._TabReport_TabPage1.SuspendLayout()
        Me._Frame_2.SuspendLayout()
        Me._Frame_5.SuspendLayout()
        Me._Frame_4.SuspendLayout()
        Me._Frame_3.SuspendLayout()
        CType(Me.ChkBone, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.ChkEyes, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.ChkHeartValves, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.ChkOrgans, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.ChkResearch, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.ChkSkin, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.ChkSoftTissue, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.Frame, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.Label, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.Lable, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'CmdCancel
        '
        Me.CmdCancel.BackColor = System.Drawing.SystemColors.Control
        Me.CmdCancel.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdCancel.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdCancel.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdCancel.Location = New System.Drawing.Point(682, 8)
        Me.CmdCancel.Name = "CmdCancel"
        Me.CmdCancel.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdCancel.Size = New System.Drawing.Size(80, 21)
        Me.CmdCancel.TabIndex = 13
        Me.CmdCancel.Text = "&Close"
        Me.CmdCancel.UseVisualStyleBackColor = False
        '
        '_Frame_1
        '
        Me._Frame_1.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_1.Controls.Add(Me.CboReportParent)
        Me._Frame_1.Controls.Add(Me.CmdSelectParentOrg)
        Me._Frame_1.Controls.Add(Me.cmdDeleteGroup)
        Me._Frame_1.Controls.Add(Me.CmdReportGroupDetail)
        Me._Frame_1.Controls.Add(Me.CboReportGroup)
        Me._Frame_1.Controls.Add(Me._Lable_0)
        Me._Frame_1.Controls.Add(Me._Lable_1)
        Me._Frame_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_1, CType(1, Short))
        Me._Frame_1.Location = New System.Drawing.Point(4, 0)
        Me._Frame_1.Name = "_Frame_1"
        Me._Frame_1.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_1.Size = New System.Drawing.Size(667, 79)
        Me._Frame_1.TabIndex = 14
        Me._Frame_1.TabStop = False
        '
        'CboReportParent
        '
        Me.CboReportParent.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboReportParent.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboReportParent.BackColor = System.Drawing.SystemColors.Window
        Me.CboReportParent.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboReportParent.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboReportParent.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboReportParent.Location = New System.Drawing.Point(88, 18)
        Me.CboReportParent.Name = "CboReportParent"
        Me.CboReportParent.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboReportParent.Size = New System.Drawing.Size(235, 22)
        Me.CboReportParent.Sorted = True
        Me.CboReportParent.TabIndex = 0
        '
        'CmdSelectParentOrg
        '
        Me.CmdSelectParentOrg.BackColor = System.Drawing.SystemColors.Control
        Me.CmdSelectParentOrg.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdSelectParentOrg.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdSelectParentOrg.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdSelectParentOrg.Location = New System.Drawing.Point(328, 20)
        Me.CmdSelectParentOrg.Name = "CmdSelectParentOrg"
        Me.CmdSelectParentOrg.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdSelectParentOrg.Size = New System.Drawing.Size(22, 19)
        Me.CmdSelectParentOrg.TabIndex = 1
        Me.CmdSelectParentOrg.Text = "..."
        Me.CmdSelectParentOrg.UseVisualStyleBackColor = False
        '
        'cmdDeleteGroup
        '
        Me.cmdDeleteGroup.BackColor = System.Drawing.SystemColors.Control
        Me.cmdDeleteGroup.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdDeleteGroup.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdDeleteGroup.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdDeleteGroup.Location = New System.Drawing.Point(364, 44)
        Me.cmdDeleteGroup.Name = "cmdDeleteGroup"
        Me.cmdDeleteGroup.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdDeleteGroup.Size = New System.Drawing.Size(101, 21)
        Me.cmdDeleteGroup.TabIndex = 21
        Me.cmdDeleteGroup.Text = "Delete Group"
        Me.cmdDeleteGroup.UseVisualStyleBackColor = False
        '
        'CmdReportGroupDetail
        '
        Me.CmdReportGroupDetail.BackColor = System.Drawing.SystemColors.Control
        Me.CmdReportGroupDetail.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdReportGroupDetail.Enabled = False
        Me.CmdReportGroupDetail.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdReportGroupDetail.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdReportGroupDetail.Location = New System.Drawing.Point(328, 46)
        Me.CmdReportGroupDetail.Name = "CmdReportGroupDetail"
        Me.CmdReportGroupDetail.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdReportGroupDetail.Size = New System.Drawing.Size(22, 19)
        Me.CmdReportGroupDetail.TabIndex = 3
        Me.CmdReportGroupDetail.Text = "..."
        Me.CmdReportGroupDetail.UseVisualStyleBackColor = False
        '
        'CboReportGroup
        '
        Me.CboReportGroup.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboReportGroup.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboReportGroup.BackColor = System.Drawing.SystemColors.Window
        Me.CboReportGroup.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboReportGroup.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboReportGroup.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboReportGroup.Location = New System.Drawing.Point(88, 44)
        Me.CboReportGroup.Name = "CboReportGroup"
        Me.CboReportGroup.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboReportGroup.Size = New System.Drawing.Size(235, 22)
        Me.CboReportGroup.Sorted = True
        Me.CboReportGroup.TabIndex = 2
        '
        '_Lable_0
        '
        Me._Lable_0.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_0, CType(0, Short))
        Me._Lable_0.Location = New System.Drawing.Point(10, 22)
        Me._Lable_0.Name = "_Lable_0"
        Me._Lable_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_0.Size = New System.Drawing.Size(74, 17)
        Me._Lable_0.TabIndex = 22
        Me._Lable_0.Text = "Group Owner"
        '
        '_Lable_1
        '
        Me._Lable_1.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_1, CType(1, Short))
        Me._Lable_1.Location = New System.Drawing.Point(10, 48)
        Me._Lable_1.Name = "_Lable_1"
        Me._Lable_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_1.Size = New System.Drawing.Size(77, 17)
        Me._Lable_1.TabIndex = 15
        Me._Lable_1.Text = "Report Group"
        '
        'TabReport
        '
        Me.TabReport.Controls.Add(Me._TabReport_TabPage0)
        Me.TabReport.Controls.Add(Me._TabReport_TabPage1)
        Me.TabReport.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TabReport.ItemSize = New System.Drawing.Size(42, 18)
        Me.TabReport.Location = New System.Drawing.Point(6, 84)
        Me.TabReport.Name = "TabReport"
        Me.TabReport.SelectedIndex = 1
        Me.TabReport.Size = New System.Drawing.Size(765, 385)
        Me.TabReport.TabIndex = 4
        '
        '_TabReport_TabPage0
        '
        Me._TabReport_TabPage0.Controls.Add(Me._Frame_0)
        Me._TabReport_TabPage0.Location = New System.Drawing.Point(4, 22)
        Me._TabReport_TabPage0.Name = "_TabReport_TabPage0"
        Me._TabReport_TabPage0.Size = New System.Drawing.Size(757, 359)
        Me._TabReport_TabPage0.TabIndex = 0
        Me._TabReport_TabPage0.Text = "Applies To"
        '
        '_Frame_0
        '
        Me._Frame_0.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_0.Controls.Add(Me.CmdUnassigned)
        Me._Frame_0.Controls.Add(Me.LstViewSelectedOrganizations)
        Me._Frame_0.Controls.Add(Me.LstViewAvailableOrganizations)
        Me._Frame_0.Controls.Add(Me.CboState)
        Me._Frame_0.Controls.Add(Me.CmdFind)
        Me._Frame_0.Controls.Add(Me.CboOrganizationType)
        Me._Frame_0.Controls.Add(Me.CmdDeselect)
        Me._Frame_0.Controls.Add(Me.CmdSelect)
        Me._Frame_0.Controls.Add(Me._Lable_4)
        Me._Frame_0.Controls.Add(Me._Lable_2)
        Me._Frame_0.Controls.Add(Me._Lable_5)
        Me._Frame_0.Controls.Add(Me._Lable_3)
        Me._Frame_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_0, CType(0, Short))
        Me._Frame_0.Location = New System.Drawing.Point(6, 9)
        Me._Frame_0.Name = "_Frame_0"
        Me._Frame_0.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_0.Size = New System.Drawing.Size(751, 353)
        Me._Frame_0.TabIndex = 16
        Me._Frame_0.TabStop = False
        '
        'CmdUnassigned
        '
        Me.CmdUnassigned.BackColor = System.Drawing.SystemColors.Control
        Me.CmdUnassigned.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdUnassigned.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdUnassigned.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdUnassigned.Location = New System.Drawing.Point(274, 38)
        Me.CmdUnassigned.Name = "CmdUnassigned"
        Me.CmdUnassigned.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdUnassigned.Size = New System.Drawing.Size(69, 21)
        Me.CmdUnassigned.TabIndex = 8
        Me.CmdUnassigned.Text = "&Unassigned"
        Me.CmdUnassigned.UseVisualStyleBackColor = False
        '
        'LstViewSelectedOrganizations
        '
        Me.LstViewSelectedOrganizations.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewSelectedOrganizations.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewSelectedOrganizations.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewSelectedOrganizations.FullRowSelect = True
        Me.LstViewSelectedOrganizations.HideSelection = False
        Me.LstViewSelectedOrganizations.LabelWrap = False
        Me.LstViewSelectedOrganizations.Location = New System.Drawing.Point(408, 62)
        Me.LstViewSelectedOrganizations.Name = "LstViewSelectedOrganizations"
        Me.LstViewSelectedOrganizations.Size = New System.Drawing.Size(335, 281)
        Me.LstViewSelectedOrganizations.TabIndex = 12
        Me.LstViewSelectedOrganizations.UseCompatibleStateImageBehavior = False
        Me.LstViewSelectedOrganizations.View = System.Windows.Forms.View.Details
        '
        'LstViewAvailableOrganizations
        '
        Me.LstViewAvailableOrganizations.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewAvailableOrganizations.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewAvailableOrganizations.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewAvailableOrganizations.FullRowSelect = True
        Me.LstViewAvailableOrganizations.HideSelection = False
        Me.LstViewAvailableOrganizations.LabelWrap = False
        Me.LstViewAvailableOrganizations.Location = New System.Drawing.Point(10, 62)
        Me.LstViewAvailableOrganizations.Name = "LstViewAvailableOrganizations"
        Me.LstViewAvailableOrganizations.Size = New System.Drawing.Size(335, 281)
        Me.LstViewAvailableOrganizations.TabIndex = 9
        Me.LstViewAvailableOrganizations.UseCompatibleStateImageBehavior = False
        Me.LstViewAvailableOrganizations.View = System.Windows.Forms.View.Details
        '
        'CboState
        '
        Me.CboState.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboState.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboState.BackColor = System.Drawing.SystemColors.Window
        Me.CboState.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboState.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboState.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboState.Location = New System.Drawing.Point(42, 14)
        Me.CboState.Name = "CboState"
        Me.CboState.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboState.Size = New System.Drawing.Size(51, 22)
        Me.CboState.Sorted = True
        Me.CboState.TabIndex = 5
        '
        'CmdFind
        '
        Me.CmdFind.BackColor = System.Drawing.SystemColors.Control
        Me.CmdFind.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdFind.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdFind.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdFind.Location = New System.Drawing.Point(274, 14)
        Me.CmdFind.Name = "CmdFind"
        Me.CmdFind.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdFind.Size = New System.Drawing.Size(69, 21)
        Me.CmdFind.TabIndex = 7
        Me.CmdFind.Text = "&Find"
        Me.CmdFind.UseVisualStyleBackColor = False
        '
        'CboOrganizationType
        '
        Me.CboOrganizationType.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboOrganizationType.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboOrganizationType.BackColor = System.Drawing.SystemColors.Window
        Me.CboOrganizationType.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboOrganizationType.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboOrganizationType.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboOrganizationType.Location = New System.Drawing.Point(128, 14)
        Me.CboOrganizationType.Name = "CboOrganizationType"
        Me.CboOrganizationType.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboOrganizationType.Size = New System.Drawing.Size(141, 22)
        Me.CboOrganizationType.Sorted = True
        Me.CboOrganizationType.TabIndex = 6
        '
        'CmdDeselect
        '
        Me.CmdDeselect.BackColor = System.Drawing.SystemColors.Control
        Me.CmdDeselect.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdDeselect.Enabled = False
        Me.CmdDeselect.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdDeselect.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdDeselect.Location = New System.Drawing.Point(350, 194)
        Me.CmdDeselect.Name = "CmdDeselect"
        Me.CmdDeselect.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdDeselect.Size = New System.Drawing.Size(54, 21)
        Me.CmdDeselect.TabIndex = 11
        Me.CmdDeselect.Text = "Remove"
        Me.CmdDeselect.UseVisualStyleBackColor = False
        '
        'CmdSelect
        '
        Me.CmdSelect.BackColor = System.Drawing.SystemColors.Control
        Me.CmdSelect.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdSelect.Enabled = False
        Me.CmdSelect.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdSelect.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdSelect.Location = New System.Drawing.Point(350, 168)
        Me.CmdSelect.Name = "CmdSelect"
        Me.CmdSelect.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdSelect.Size = New System.Drawing.Size(54, 21)
        Me.CmdSelect.TabIndex = 10
        Me.CmdSelect.Text = "Add  >>"
        Me.CmdSelect.UseVisualStyleBackColor = False
        '
        '_Lable_4
        '
        Me._Lable_4.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_4.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_4.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_4, CType(4, Short))
        Me._Lable_4.Location = New System.Drawing.Point(12, 18)
        Me._Lable_4.Name = "_Lable_4"
        Me._Lable_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_4.Size = New System.Drawing.Size(55, 19)
        Me._Lable_4.TabIndex = 20
        Me._Lable_4.Text = "State"
        '
        '_Lable_2
        '
        Me._Lable_2.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_2, CType(2, Short))
        Me._Lable_2.Location = New System.Drawing.Point(12, 46)
        Me._Lable_2.Name = "_Lable_2"
        Me._Lable_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_2.Size = New System.Drawing.Size(137, 17)
        Me._Lable_2.TabIndex = 19
        Me._Lable_2.Text = "Available Organizations"
        '
        '_Lable_5
        '
        Me._Lable_5.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_5.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_5.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_5, CType(5, Short))
        Me._Lable_5.Location = New System.Drawing.Point(98, 18)
        Me._Lable_5.Name = "_Lable_5"
        Me._Lable_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_5.Size = New System.Drawing.Size(55, 17)
        Me._Lable_5.TabIndex = 18
        Me._Lable_5.Text = "Type"
        '
        '_Lable_3
        '
        Me._Lable_3.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_3.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_3, CType(3, Short))
        Me._Lable_3.Location = New System.Drawing.Point(408, 46)
        Me._Lable_3.Name = "_Lable_3"
        Me._Lable_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_3.Size = New System.Drawing.Size(137, 17)
        Me._Lable_3.TabIndex = 17
        Me._Lable_3.Text = "Selected Organizations"
        '
        '_TabReport_TabPage1
        '
        Me._TabReport_TabPage1.Controls.Add(Me._Frame_2)
        Me._TabReport_TabPage1.Location = New System.Drawing.Point(4, 22)
        Me._TabReport_TabPage1.Name = "_TabReport_TabPage1"
        Me._TabReport_TabPage1.Size = New System.Drawing.Size(757, 359)
        Me._TabReport_TabPage1.TabIndex = 1
        Me._TabReport_TabPage1.Text = "Source Codes"
        '
        '_Frame_2
        '
        Me._Frame_2.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_2.Controls.Add(Me._Frame_5)
        Me._Frame_2.Controls.Add(Me.TxtEndActive)
        Me._Frame_2.Controls.Add(Me.CmdAddAccess)
        Me._Frame_2.Controls.Add(Me.CmdRemoveAccess)
        Me._Frame_2.Controls.Add(Me.TxtStartActive)
        Me._Frame_2.Controls.Add(Me._Frame_4)
        Me._Frame_2.Controls.Add(Me._Frame_3)
        Me._Frame_2.Controls.Add(Me.CmdRemove)
        Me._Frame_2.Controls.Add(Me.CmdAdd)
        Me._Frame_2.Controls.Add(Me.LstViewSourceCodes)
        Me._Frame_2.Controls.Add(Me.LstViewDateAccess)
        Me._Frame_2.Controls.Add(Me._Lable_9)
        Me._Frame_2.Controls.Add(Me._Lable_8)
        Me._Frame_2.Controls.Add(Me._Label_1)
        Me._Frame_2.Controls.Add(Me._Label_0)
        Me._Frame_2.Controls.Add(Me.Label1)
        Me._Frame_2.Controls.Add(Me._Lable_7)
        Me._Frame_2.Controls.Add(Me._Lable_6)
        Me._Frame_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_2, CType(2, Short))
        Me._Frame_2.Location = New System.Drawing.Point(6, 6)
        Me._Frame_2.Name = "_Frame_2"
        Me._Frame_2.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_2.Size = New System.Drawing.Size(751, 351)
        Me._Frame_2.TabIndex = 23
        Me._Frame_2.TabStop = False
        '
        '_Frame_5
        '
        Me._Frame_5.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_5.Controls.Add(Me.ChkOTE)
        Me._Frame_5.Controls.Add(Me.ChkRuleout)
        Me._Frame_5.Controls.Add(Me.ChkTE)
        Me._Frame_5.Controls.Add(Me.ChkEyeOnly)
        Me._Frame_5.Controls.Add(Me._Lable_10)
        Me._Frame_5.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_5.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_5, CType(5, Short))
        Me._Frame_5.Location = New System.Drawing.Point(240, 208)
        Me._Frame_5.Name = "_Frame_5"
        Me._Frame_5.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_5.Size = New System.Drawing.Size(111, 137)
        Me._Frame_5.TabIndex = 59
        Me._Frame_5.TabStop = False
        Me._Frame_5.Text = "View by Ref Type"
        '
        'ChkOTE
        '
        Me.ChkOTE.BackColor = System.Drawing.SystemColors.Control
        Me.ChkOTE.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkOTE.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkOTE.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkOTE.Location = New System.Drawing.Point(10, 22)
        Me.ChkOTE.Name = "ChkOTE"
        Me.ChkOTE.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkOTE.Size = New System.Drawing.Size(83, 18)
        Me.ChkOTE.TabIndex = 34
        Me.ChkOTE.Text = "O/T/E"
        Me.ChkOTE.UseVisualStyleBackColor = False
        '
        'ChkRuleout
        '
        Me.ChkRuleout.BackColor = System.Drawing.SystemColors.Control
        Me.ChkRuleout.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkRuleout.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkRuleout.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkRuleout.Location = New System.Drawing.Point(10, 82)
        Me.ChkRuleout.Name = "ChkRuleout"
        Me.ChkRuleout.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkRuleout.Size = New System.Drawing.Size(85, 18)
        Me.ChkRuleout.TabIndex = 37
        Me.ChkRuleout.Text = "Ruleout"
        Me.ChkRuleout.UseVisualStyleBackColor = False
        '
        'ChkTE
        '
        Me.ChkTE.BackColor = System.Drawing.SystemColors.Control
        Me.ChkTE.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkTE.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkTE.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkTE.Location = New System.Drawing.Point(10, 42)
        Me.ChkTE.Name = "ChkTE"
        Me.ChkTE.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkTE.Size = New System.Drawing.Size(87, 18)
        Me.ChkTE.TabIndex = 35
        Me.ChkTE.Text = "Tissue/Eye"
        Me.ChkTE.UseVisualStyleBackColor = False
        '
        'ChkEyeOnly
        '
        Me.ChkEyeOnly.BackColor = System.Drawing.SystemColors.Control
        Me.ChkEyeOnly.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkEyeOnly.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkEyeOnly.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkEyeOnly.Location = New System.Drawing.Point(10, 62)
        Me.ChkEyeOnly.Name = "ChkEyeOnly"
        Me.ChkEyeOnly.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkEyeOnly.Size = New System.Drawing.Size(89, 18)
        Me.ChkEyeOnly.TabIndex = 36
        Me.ChkEyeOnly.Text = "Eye Only"
        Me.ChkEyeOnly.UseVisualStyleBackColor = False
        '
        '_Lable_10
        '
        Me._Lable_10.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_10.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_10.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_10.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_10, CType(10, Short))
        Me._Lable_10.Location = New System.Drawing.Point(6, 104)
        Me._Lable_10.Name = "_Lable_10"
        Me._Lable_10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_10.Size = New System.Drawing.Size(99, 27)
        Me._Lable_10.TabIndex = 60
        Me._Lable_10.Text = "* Valid only with Master Report Group"
        '
        'TxtEndActive
        '
        Me.TxtEndActive.AcceptsReturn = True
        Me.TxtEndActive.BackColor = System.Drawing.SystemColors.Window
        Me.TxtEndActive.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtEndActive.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtEndActive.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtEndActive.Location = New System.Drawing.Point(620, 42)
        Me.TxtEndActive.MaxLength = 0
        Me.TxtEndActive.Name = "TxtEndActive"
        Me.TxtEndActive.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtEndActive.Size = New System.Drawing.Size(71, 20)
        Me.TxtEndActive.TabIndex = 48
        '
        'CmdAddAccess
        '
        Me.CmdAddAccess.BackColor = System.Drawing.SystemColors.Control
        Me.CmdAddAccess.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdAddAccess.Enabled = False
        Me.CmdAddAccess.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdAddAccess.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdAddAccess.Location = New System.Drawing.Point(542, 16)
        Me.CmdAddAccess.Name = "CmdAddAccess"
        Me.CmdAddAccess.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdAddAccess.Size = New System.Drawing.Size(69, 21)
        Me.CmdAddAccess.TabIndex = 45
        Me.CmdAddAccess.Text = "Add..."
        Me.CmdAddAccess.UseVisualStyleBackColor = False
        '
        'CmdRemoveAccess
        '
        Me.CmdRemoveAccess.BackColor = System.Drawing.SystemColors.Control
        Me.CmdRemoveAccess.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdRemoveAccess.Enabled = False
        Me.CmdRemoveAccess.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdRemoveAccess.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdRemoveAccess.Location = New System.Drawing.Point(616, 16)
        Me.CmdRemoveAccess.Name = "CmdRemoveAccess"
        Me.CmdRemoveAccess.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdRemoveAccess.Size = New System.Drawing.Size(69, 21)
        Me.CmdRemoveAccess.TabIndex = 46
        Me.CmdRemoveAccess.Text = "Remove"
        Me.CmdRemoveAccess.UseVisualStyleBackColor = False
        '
        'TxtStartActive
        '
        Me.TxtStartActive.AcceptsReturn = True
        Me.TxtStartActive.BackColor = System.Drawing.SystemColors.Window
        Me.TxtStartActive.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtStartActive.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtStartActive.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtStartActive.Location = New System.Drawing.Point(508, 42)
        Me.TxtStartActive.MaxLength = 0
        Me.TxtStartActive.Name = "TxtStartActive"
        Me.TxtStartActive.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtStartActive.Size = New System.Drawing.Size(71, 20)
        Me.TxtStartActive.TabIndex = 47
        '
        '_Frame_4
        '
        Me._Frame_4.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_4.Controls.Add(Me._ChkResearch_1)
        Me._Frame_4.Controls.Add(Me._ChkOrgans_1)
        Me._Frame_4.Controls.Add(Me._ChkSkin_1)
        Me._Frame_4.Controls.Add(Me._ChkHeartValves_1)
        Me._Frame_4.Controls.Add(Me._ChkBone_1)
        Me._Frame_4.Controls.Add(Me._ChkEyes_1)
        Me._Frame_4.Controls.Add(Me._ChkSoftTissue_1)
        Me._Frame_4.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_4.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_4, CType(4, Short))
        Me._Frame_4.Location = New System.Drawing.Point(356, 36)
        Me._Frame_4.Name = "_Frame_4"
        Me._Frame_4.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_4.Size = New System.Drawing.Size(109, 165)
        Me._Frame_4.TabIndex = 54
        Me._Frame_4.TabStop = False
        Me._Frame_4.Text = "Update"
        '
        '_ChkResearch_1
        '
        Me._ChkResearch_1.BackColor = System.Drawing.SystemColors.Control
        Me._ChkResearch_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._ChkResearch_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._ChkResearch_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkResearch.SetIndex(Me._ChkResearch_1, CType(1, Short))
        Me._ChkResearch_1.Location = New System.Drawing.Point(10, 142)
        Me._ChkResearch_1.Name = "_ChkResearch_1"
        Me._ChkResearch_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._ChkResearch_1.Size = New System.Drawing.Size(91, 18)
        Me._ChkResearch_1.TabIndex = 44
        Me._ChkResearch_1.Text = "Other"
        Me._ChkResearch_1.UseVisualStyleBackColor = False
        '
        '_ChkOrgans_1
        '
        Me._ChkOrgans_1.BackColor = System.Drawing.SystemColors.Control
        Me._ChkOrgans_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._ChkOrgans_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._ChkOrgans_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkOrgans.SetIndex(Me._ChkOrgans_1, CType(1, Short))
        Me._ChkOrgans_1.Location = New System.Drawing.Point(10, 22)
        Me._ChkOrgans_1.Name = "_ChkOrgans_1"
        Me._ChkOrgans_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._ChkOrgans_1.Size = New System.Drawing.Size(83, 18)
        Me._ChkOrgans_1.TabIndex = 38
        Me._ChkOrgans_1.Text = "Organs"
        Me._ChkOrgans_1.UseVisualStyleBackColor = False
        '
        '_ChkSkin_1
        '
        Me._ChkSkin_1.BackColor = System.Drawing.SystemColors.Control
        Me._ChkSkin_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._ChkSkin_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._ChkSkin_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkSkin.SetIndex(Me._ChkSkin_1, CType(1, Short))
        Me._ChkSkin_1.Location = New System.Drawing.Point(10, 82)
        Me._ChkSkin_1.Name = "_ChkSkin_1"
        Me._ChkSkin_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._ChkSkin_1.Size = New System.Drawing.Size(85, 18)
        Me._ChkSkin_1.TabIndex = 41
        Me._ChkSkin_1.Text = "Skin"
        Me._ChkSkin_1.UseVisualStyleBackColor = False
        '
        '_ChkHeartValves_1
        '
        Me._ChkHeartValves_1.BackColor = System.Drawing.SystemColors.Control
        Me._ChkHeartValves_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._ChkHeartValves_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._ChkHeartValves_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkHeartValves.SetIndex(Me._ChkHeartValves_1, CType(1, Short))
        Me._ChkHeartValves_1.Location = New System.Drawing.Point(10, 102)
        Me._ChkHeartValves_1.Name = "_ChkHeartValves_1"
        Me._ChkHeartValves_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._ChkHeartValves_1.Size = New System.Drawing.Size(95, 18)
        Me._ChkHeartValves_1.TabIndex = 42
        Me._ChkHeartValves_1.Text = "Heart Valves"
        Me._ChkHeartValves_1.UseVisualStyleBackColor = False
        '
        '_ChkBone_1
        '
        Me._ChkBone_1.BackColor = System.Drawing.SystemColors.Control
        Me._ChkBone_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._ChkBone_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._ChkBone_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkBone.SetIndex(Me._ChkBone_1, CType(1, Short))
        Me._ChkBone_1.Location = New System.Drawing.Point(10, 42)
        Me._ChkBone_1.Name = "_ChkBone_1"
        Me._ChkBone_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._ChkBone_1.Size = New System.Drawing.Size(89, 18)
        Me._ChkBone_1.TabIndex = 39
        Me._ChkBone_1.Text = "Bone"
        Me._ChkBone_1.UseVisualStyleBackColor = False
        '
        '_ChkEyes_1
        '
        Me._ChkEyes_1.BackColor = System.Drawing.SystemColors.Control
        Me._ChkEyes_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._ChkEyes_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._ChkEyes_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkEyes.SetIndex(Me._ChkEyes_1, CType(1, Short))
        Me._ChkEyes_1.Location = New System.Drawing.Point(10, 122)
        Me._ChkEyes_1.Name = "_ChkEyes_1"
        Me._ChkEyes_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._ChkEyes_1.Size = New System.Drawing.Size(95, 18)
        Me._ChkEyes_1.TabIndex = 43
        Me._ChkEyes_1.Text = "Eyes"
        Me._ChkEyes_1.UseVisualStyleBackColor = False
        '
        '_ChkSoftTissue_1
        '
        Me._ChkSoftTissue_1.BackColor = System.Drawing.SystemColors.Control
        Me._ChkSoftTissue_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._ChkSoftTissue_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._ChkSoftTissue_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkSoftTissue.SetIndex(Me._ChkSoftTissue_1, CType(1, Short))
        Me._ChkSoftTissue_1.Location = New System.Drawing.Point(10, 62)
        Me._ChkSoftTissue_1.Name = "_ChkSoftTissue_1"
        Me._ChkSoftTissue_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._ChkSoftTissue_1.Size = New System.Drawing.Size(91, 18)
        Me._ChkSoftTissue_1.TabIndex = 40
        Me._ChkSoftTissue_1.Text = "Soft Tissue"
        Me._ChkSoftTissue_1.UseVisualStyleBackColor = False
        '
        '_Frame_3
        '
        Me._Frame_3.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_3.Controls.Add(Me._ChkSoftTissue_0)
        Me._Frame_3.Controls.Add(Me._ChkEyes_0)
        Me._Frame_3.Controls.Add(Me._ChkBone_0)
        Me._Frame_3.Controls.Add(Me._ChkHeartValves_0)
        Me._Frame_3.Controls.Add(Me._ChkSkin_0)
        Me._Frame_3.Controls.Add(Me._ChkOrgans_0)
        Me._Frame_3.Controls.Add(Me._ChkResearch_0)
        Me._Frame_3.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_3, CType(3, Short))
        Me._Frame_3.Location = New System.Drawing.Point(240, 36)
        Me._Frame_3.Name = "_Frame_3"
        Me._Frame_3.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_3.Size = New System.Drawing.Size(111, 165)
        Me._Frame_3.TabIndex = 51
        Me._Frame_3.TabStop = False
        Me._Frame_3.Text = "View by Option"
        '
        '_ChkSoftTissue_0
        '
        Me._ChkSoftTissue_0.BackColor = System.Drawing.SystemColors.Control
        Me._ChkSoftTissue_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._ChkSoftTissue_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._ChkSoftTissue_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkSoftTissue.SetIndex(Me._ChkSoftTissue_0, CType(0, Short))
        Me._ChkSoftTissue_0.Location = New System.Drawing.Point(10, 62)
        Me._ChkSoftTissue_0.Name = "_ChkSoftTissue_0"
        Me._ChkSoftTissue_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._ChkSoftTissue_0.Size = New System.Drawing.Size(89, 17)
        Me._ChkSoftTissue_0.TabIndex = 29
        Me._ChkSoftTissue_0.Text = "Soft Tissue"
        Me._ChkSoftTissue_0.UseVisualStyleBackColor = False
        '
        '_ChkEyes_0
        '
        Me._ChkEyes_0.BackColor = System.Drawing.SystemColors.Control
        Me._ChkEyes_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._ChkEyes_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._ChkEyes_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkEyes.SetIndex(Me._ChkEyes_0, CType(0, Short))
        Me._ChkEyes_0.Location = New System.Drawing.Point(10, 122)
        Me._ChkEyes_0.Name = "_ChkEyes_0"
        Me._ChkEyes_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._ChkEyes_0.Size = New System.Drawing.Size(95, 17)
        Me._ChkEyes_0.TabIndex = 32
        Me._ChkEyes_0.Text = "Eyes"
        Me._ChkEyes_0.UseVisualStyleBackColor = False
        '
        '_ChkBone_0
        '
        Me._ChkBone_0.BackColor = System.Drawing.SystemColors.Control
        Me._ChkBone_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._ChkBone_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._ChkBone_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkBone.SetIndex(Me._ChkBone_0, CType(0, Short))
        Me._ChkBone_0.Location = New System.Drawing.Point(10, 42)
        Me._ChkBone_0.Name = "_ChkBone_0"
        Me._ChkBone_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._ChkBone_0.Size = New System.Drawing.Size(87, 17)
        Me._ChkBone_0.TabIndex = 28
        Me._ChkBone_0.Text = "Bone"
        Me._ChkBone_0.UseVisualStyleBackColor = False
        '
        '_ChkHeartValves_0
        '
        Me._ChkHeartValves_0.BackColor = System.Drawing.SystemColors.Control
        Me._ChkHeartValves_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._ChkHeartValves_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._ChkHeartValves_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkHeartValves.SetIndex(Me._ChkHeartValves_0, CType(0, Short))
        Me._ChkHeartValves_0.Location = New System.Drawing.Point(10, 102)
        Me._ChkHeartValves_0.Name = "_ChkHeartValves_0"
        Me._ChkHeartValves_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._ChkHeartValves_0.Size = New System.Drawing.Size(95, 17)
        Me._ChkHeartValves_0.TabIndex = 31
        Me._ChkHeartValves_0.Text = "Heart Valves"
        Me._ChkHeartValves_0.UseVisualStyleBackColor = False
        '
        '_ChkSkin_0
        '
        Me._ChkSkin_0.BackColor = System.Drawing.SystemColors.Control
        Me._ChkSkin_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._ChkSkin_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._ChkSkin_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkSkin.SetIndex(Me._ChkSkin_0, CType(0, Short))
        Me._ChkSkin_0.Location = New System.Drawing.Point(10, 82)
        Me._ChkSkin_0.Name = "_ChkSkin_0"
        Me._ChkSkin_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._ChkSkin_0.Size = New System.Drawing.Size(85, 17)
        Me._ChkSkin_0.TabIndex = 30
        Me._ChkSkin_0.Text = "Skin"
        Me._ChkSkin_0.UseVisualStyleBackColor = False
        '
        '_ChkOrgans_0
        '
        Me._ChkOrgans_0.BackColor = System.Drawing.SystemColors.Control
        Me._ChkOrgans_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._ChkOrgans_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._ChkOrgans_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkOrgans.SetIndex(Me._ChkOrgans_0, CType(0, Short))
        Me._ChkOrgans_0.Location = New System.Drawing.Point(10, 22)
        Me._ChkOrgans_0.Name = "_ChkOrgans_0"
        Me._ChkOrgans_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._ChkOrgans_0.Size = New System.Drawing.Size(83, 17)
        Me._ChkOrgans_0.TabIndex = 27
        Me._ChkOrgans_0.Text = "Organs"
        Me._ChkOrgans_0.UseVisualStyleBackColor = False
        '
        '_ChkResearch_0
        '
        Me._ChkResearch_0.BackColor = System.Drawing.SystemColors.Control
        Me._ChkResearch_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._ChkResearch_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._ChkResearch_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkResearch.SetIndex(Me._ChkResearch_0, CType(0, Short))
        Me._ChkResearch_0.Location = New System.Drawing.Point(10, 142)
        Me._ChkResearch_0.Name = "_ChkResearch_0"
        Me._ChkResearch_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._ChkResearch_0.Size = New System.Drawing.Size(89, 17)
        Me._ChkResearch_0.TabIndex = 33
        Me._ChkResearch_0.Text = "Other"
        Me._ChkResearch_0.UseVisualStyleBackColor = False
        '
        'CmdRemove
        '
        Me.CmdRemove.BackColor = System.Drawing.SystemColors.Control
        Me.CmdRemove.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdRemove.Enabled = False
        Me.CmdRemove.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdRemove.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdRemove.Location = New System.Drawing.Point(160, 16)
        Me.CmdRemove.Name = "CmdRemove"
        Me.CmdRemove.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdRemove.Size = New System.Drawing.Size(69, 21)
        Me.CmdRemove.TabIndex = 25
        Me.CmdRemove.Text = "Remove"
        Me.CmdRemove.UseVisualStyleBackColor = False
        '
        'CmdAdd
        '
        Me.CmdAdd.BackColor = System.Drawing.SystemColors.Control
        Me.CmdAdd.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdAdd.Enabled = False
        Me.CmdAdd.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdAdd.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdAdd.Location = New System.Drawing.Point(84, 16)
        Me.CmdAdd.Name = "CmdAdd"
        Me.CmdAdd.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdAdd.Size = New System.Drawing.Size(69, 21)
        Me.CmdAdd.TabIndex = 24
        Me.CmdAdd.Text = "Add..."
        Me.CmdAdd.UseVisualStyleBackColor = False
        '
        'LstViewSourceCodes
        '
        Me.LstViewSourceCodes.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewSourceCodes.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewSourceCodes.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewSourceCodes.FullRowSelect = True
        Me.LstViewSourceCodes.HideSelection = False
        Me.LstViewSourceCodes.LabelWrap = False
        Me.LstViewSourceCodes.Location = New System.Drawing.Point(10, 42)
        Me.LstViewSourceCodes.Name = "LstViewSourceCodes"
        Me.LstViewSourceCodes.Size = New System.Drawing.Size(219, 159)
        Me.LstViewSourceCodes.TabIndex = 26
        Me.LstViewSourceCodes.UseCompatibleStateImageBehavior = False
        Me.LstViewSourceCodes.View = System.Windows.Forms.View.Details
        '
        'LstViewDateAccess
        '
        Me.LstViewDateAccess.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewDateAccess.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewDateAccess.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewDateAccess.FullRowSelect = True
        Me.LstViewDateAccess.HideSelection = False
        Me.LstViewDateAccess.LabelWrap = False
        Me.LstViewDateAccess.Location = New System.Drawing.Point(472, 68)
        Me.LstViewDateAccess.Name = "LstViewDateAccess"
        Me.LstViewDateAccess.Size = New System.Drawing.Size(219, 133)
        Me.LstViewDateAccess.TabIndex = 49
        Me.LstViewDateAccess.UseCompatibleStateImageBehavior = False
        Me.LstViewDateAccess.View = System.Windows.Forms.View.Details
        '
        '_Lable_9
        '
        Me._Lable_9.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_9.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_9.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_9.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_9, CType(9, Short))
        Me._Lable_9.Location = New System.Drawing.Point(470, 18)
        Me._Lable_9.Name = "_Lable_9"
        Me._Lable_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_9.Size = New System.Drawing.Size(81, 17)
        Me._Lable_9.TabIndex = 58
        Me._Lable_9.Text = "Access Dates"
        '
        '_Lable_8
        '
        Me._Lable_8.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_8.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_8.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_8.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_8, CType(8, Short))
        Me._Lable_8.Location = New System.Drawing.Point(474, 208)
        Me._Lable_8.Name = "_Lable_8"
        Me._Lable_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_8.Size = New System.Drawing.Size(219, 89)
        Me._Lable_8.TabIndex = 57
        Me._Lable_8.Text = "The list above should indicate the range of dates for which the report group has " & _
    "access to data. If no date range is listed, access is available for all dates."
        '
        '_Label_1
        '
        Me._Label_1.BackColor = System.Drawing.SystemColors.Control
        Me._Label_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_1, CType(1, Short))
        Me._Label_1.Location = New System.Drawing.Point(586, 46)
        Me._Label_1.Name = "_Label_1"
        Me._Label_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_1.Size = New System.Drawing.Size(61, 17)
        Me._Label_1.TabIndex = 56
        Me._Label_1.Text = "End"
        '
        '_Label_0
        '
        Me._Label_0.BackColor = System.Drawing.SystemColors.Control
        Me._Label_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_0, CType(0, Short))
        Me._Label_0.Location = New System.Drawing.Point(472, 46)
        Me._Label_0.Name = "_Label_0"
        Me._Label_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_0.Size = New System.Drawing.Size(61, 17)
        Me._Label_0.TabIndex = 55
        Me._Label_0.Text = "Begin"
        '
        'Label1
        '
        Me.Label1.BackColor = System.Drawing.SystemColors.Control
        Me.Label1.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label1.Location = New System.Drawing.Point(240, 18)
        Me.Label1.Name = "Label1"
        Me.Label1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label1.Size = New System.Drawing.Size(137, 29)
        Me.Label1.TabIndex = 53
        Me.Label1.Text = "Source Code Data Access"
        '
        '_Lable_7
        '
        Me._Lable_7.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_7.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_7.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_7, CType(7, Short))
        Me._Lable_7.Location = New System.Drawing.Point(10, 212)
        Me._Lable_7.Name = "_Lable_7"
        Me._Lable_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_7.Size = New System.Drawing.Size(219, 85)
        Me._Lable_7.TabIndex = 52
        Me._Lable_7.Text = resources.GetString("_Lable_7.Text")
        '
        '_Lable_6
        '
        Me._Lable_6.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_6.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_6.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_6, CType(6, Short))
        Me._Lable_6.Location = New System.Drawing.Point(10, 18)
        Me._Lable_6.Name = "_Lable_6"
        Me._Lable_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_6.Size = New System.Drawing.Size(81, 17)
        Me._Lable_6.TabIndex = 50
        Me._Lable_6.Text = "Source Codes"
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 14.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.ClientSize = New System.Drawing.Size(775, 472)
        Me.Controls.Add(Me.CmdCancel)
        Me.Controls.Add(Me._Frame_1)
        Me.Controls.Add(Me.TabReport)
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Location = New System.Drawing.Point(139, 137)
        Me.MaximizeBox = False
        Me.Name = "FrmReport"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.StartPosition = System.Windows.Forms.FormStartPosition.Manual
        Me.Text = "Report Groups"
        Me._Frame_1.ResumeLayout(False)
        Me.TabReport.ResumeLayout(False)
        Me._TabReport_TabPage0.ResumeLayout(False)
        Me._Frame_0.ResumeLayout(False)
        Me._TabReport_TabPage1.ResumeLayout(False)
        Me._Frame_2.ResumeLayout(False)
        Me._Frame_2.PerformLayout()
        Me._Frame_5.ResumeLayout(False)
        Me._Frame_4.ResumeLayout(False)
        Me._Frame_3.ResumeLayout(False)
        CType(Me.ChkBone, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.ChkEyes, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.ChkHeartValves, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.ChkOrgans, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.ChkResearch, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.ChkSkin, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.ChkSoftTissue, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.Frame, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.Label, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.Lable, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)

    End Sub
#End Region 
End Class