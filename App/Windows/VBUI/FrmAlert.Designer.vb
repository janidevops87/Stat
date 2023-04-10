<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmAlert
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
	Public WithEvents CmdOK As System.Windows.Forms.Button
	Public WithEvents CmdCancel As System.Windows.Forms.Button
	Public WithEvents ImageList1 As System.Windows.Forms.ImageList
	Public WithEvents CboType As System.Windows.Forms.ComboBox
	Public CommonDialog1Open As System.Windows.Forms.OpenFileDialog
	Public CommonDialog1Save As System.Windows.Forms.SaveFileDialog
	Public CommonDialog1Font As System.Windows.Forms.FontDialog
	Public CommonDialog1Color As System.Windows.Forms.ColorDialog
	Public CommonDialog1Print As System.Windows.Forms.PrintDialog
	Public WithEvents CmdPrintList As System.Windows.Forms.Button
	Public WithEvents CmdAlertGroupDetail As System.Windows.Forms.Button
	Public WithEvents CboAlertGroup As System.Windows.Forms.ComboBox
	Public WithEvents _Lable_0 As System.Windows.Forms.Label
	Public WithEvents _Lable_1 As System.Windows.Forms.Label
	Public WithEvents _Frame_3 As System.Windows.Forms.GroupBox
    Public WithEvents bold As System.Windows.Forms.ToolStripButton
    Public WithEvents italic As System.Windows.Forms.ToolStripButton
    Public WithEvents underline As System.Windows.Forms.ToolStripButton
    Public WithEvents _Toolbar1_Button4 As System.Windows.Forms.ToolStripSeparator
    Public WithEvents color As System.Windows.Forms.ToolStripButton
    Public WithEvents _Toolbar1_Button6 As System.Windows.Forms.ToolStripSeparator
    Public WithEvents left As System.Windows.Forms.ToolStripButton
    Public WithEvents center As System.Windows.Forms.ToolStripButton
    Public WithEvents _Toolbar1_Button10 As System.Windows.Forms.ToolStripSeparator
    Public WithEvents bullet As System.Windows.Forms.ToolStripDropDownButton
    Public WithEvents Toolbar1 As System.Windows.Forms.ToolStrip
    Public WithEvents cmbsize As System.Windows.Forms.ComboBox
    Public WithEvents cmbfont As System.Windows.Forms.ComboBox
    Public WithEvents Frame1 As System.Windows.Forms.GroupBox
    Public WithEvents _TxtAlerts_0 As System.Windows.Forms.RichTextBox
    Public WithEvents _TxtAlerts_1 As System.Windows.Forms.RichTextBox
    Public WithEvents LblAlert1 As System.Windows.Forms.Label
    Public WithEvents _Label_1 As System.Windows.Forms.Label
    Public WithEvents _Label_0 As System.Windows.Forms.Label
    Public WithEvents LblAlert2 As System.Windows.Forms.Label
    Public WithEvents _Frame_1 As System.Windows.Forms.GroupBox
    Public WithEvents _TxtAlerts_2 As System.Windows.Forms.RichTextBox
    Public WithEvents _Label_10 As System.Windows.Forms.Label
    Public WithEvents _Frame_4 As System.Windows.Forms.GroupBox
    Public WithEvents _TxtAlerts_3 As System.Windows.Forms.RichTextBox
    Public WithEvents _TxtAlerts_4 As System.Windows.Forms.RichTextBox
    Public WithEvents _Label_3 As System.Windows.Forms.Label
    Public WithEvents _Label_2 As System.Windows.Forms.Label
    Public WithEvents _Frame_5 As System.Windows.Forms.GroupBox
    Public WithEvents _TabServiceLevel_TabPage0 As System.Windows.Forms.TabPage
    Public WithEvents CmdUnassigned As System.Windows.Forms.Button
    Public WithEvents CboState As System.Windows.Forms.ComboBox
    Public WithEvents CmdFind As System.Windows.Forms.Button
    Public WithEvents CboOrganizationType As System.Windows.Forms.ComboBox
    Public WithEvents CmdDeselect As System.Windows.Forms.Button
    Public WithEvents CmdSelect As System.Windows.Forms.Button
    Public WithEvents LstViewAvailableOrganizations As System.Windows.Forms.ListView
    Public WithEvents LstViewSelectedOrganizations As System.Windows.Forms.ListView
    Public WithEvents _Lable_2 As System.Windows.Forms.Label
    Public WithEvents _Lable_5 As System.Windows.Forms.Label
    Public WithEvents _Lable_3 As System.Windows.Forms.Label
    Public WithEvents _Lable_4 As System.Windows.Forms.Label
    Public WithEvents _Frame_2 As System.Windows.Forms.GroupBox
    Public WithEvents _TabServiceLevel_TabPage1 As System.Windows.Forms.TabPage
    Public WithEvents CmdAdd As System.Windows.Forms.Button
    Public WithEvents CmdRemove As System.Windows.Forms.Button
    Public WithEvents LstViewSourceCodes As System.Windows.Forms.ListView
    Public WithEvents _Lable_8 As System.Windows.Forms.Label
    Public WithEvents _Lable_7 As System.Windows.Forms.Label
    Public WithEvents _Lable_6 As System.Windows.Forms.Label
    Public WithEvents _Frame_0 As System.Windows.Forms.GroupBox
    Public WithEvents _TabServiceLevel_TabPage2 As System.Windows.Forms.TabPage
    Public WithEvents TabServiceLevel As System.Windows.Forms.TabControl
    Public WithEvents Frame As Microsoft.VisualBasic.Compatibility.VB6.GroupBoxArray
    Public WithEvents Label As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
    Public WithEvents Lable As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
    Public WithEvents TxtAlerts As Microsoft.VisualBasic.Compatibility.VB6.RichTextBoxArray
    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FrmAlert))
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.CmdOK = New System.Windows.Forms.Button
        Me.CmdCancel = New System.Windows.Forms.Button
        Me._Frame_3 = New System.Windows.Forms.GroupBox
        Me.CboType = New System.Windows.Forms.ComboBox
        Me.CmdPrintList = New System.Windows.Forms.Button
        Me.CmdAlertGroupDetail = New System.Windows.Forms.Button
        Me.CboAlertGroup = New System.Windows.Forms.ComboBox
        Me._Lable_0 = New System.Windows.Forms.Label
        Me._Lable_1 = New System.Windows.Forms.Label
        Me.ImageList1 = New System.Windows.Forms.ImageList(Me.components)
        Me.CommonDialog1Open = New System.Windows.Forms.OpenFileDialog
        Me.CommonDialog1Save = New System.Windows.Forms.SaveFileDialog
        Me.CommonDialog1Font = New System.Windows.Forms.FontDialog
        Me.CommonDialog1Color = New System.Windows.Forms.ColorDialog
        Me.CommonDialog1Print = New System.Windows.Forms.PrintDialog
        Me.TabServiceLevel = New System.Windows.Forms.TabControl
        Me._TabServiceLevel_TabPage0 = New System.Windows.Forms.TabPage
        Me.Frame1 = New System.Windows.Forms.GroupBox
        Me.Toolbar1 = New System.Windows.Forms.ToolStrip
        Me.bold = New System.Windows.Forms.ToolStripButton
        Me.italic = New System.Windows.Forms.ToolStripButton
        Me._Toolbar1_Button4 = New System.Windows.Forms.ToolStripSeparator
        Me.underline = New System.Windows.Forms.ToolStripButton
        Me.color = New System.Windows.Forms.ToolStripButton
        Me._Toolbar1_Button6 = New System.Windows.Forms.ToolStripSeparator
        Me.left = New System.Windows.Forms.ToolStripButton
        Me.center = New System.Windows.Forms.ToolStripButton
        Me.right = New System.Windows.Forms.ToolStripButton
        Me._Toolbar1_Button10 = New System.Windows.Forms.ToolStripSeparator
        Me.bullet = New System.Windows.Forms.ToolStripDropDownButton
        Me.cmbsize = New System.Windows.Forms.ComboBox
        Me.cmbfont = New System.Windows.Forms.ComboBox
        Me._Frame_1 = New System.Windows.Forms.GroupBox
        Me._TxtAlerts_0 = New System.Windows.Forms.RichTextBox
        Me._TxtAlerts_1 = New System.Windows.Forms.RichTextBox
        Me.LblAlert1 = New System.Windows.Forms.Label
        Me._Label_1 = New System.Windows.Forms.Label
        Me._Label_0 = New System.Windows.Forms.Label
        Me.LblAlert2 = New System.Windows.Forms.Label
        Me._Frame_4 = New System.Windows.Forms.GroupBox
        Me._TxtAlerts_2 = New System.Windows.Forms.RichTextBox
        Me._Label_10 = New System.Windows.Forms.Label
        Me._Frame_5 = New System.Windows.Forms.GroupBox
        Me._TxtAlerts_3 = New System.Windows.Forms.RichTextBox
        Me._TxtAlerts_4 = New System.Windows.Forms.RichTextBox
        Me._Label_3 = New System.Windows.Forms.Label
        Me._Label_2 = New System.Windows.Forms.Label
        Me._TabServiceLevel_TabPage1 = New System.Windows.Forms.TabPage
        Me._Frame_2 = New System.Windows.Forms.GroupBox
        Me.CmdUnassigned = New System.Windows.Forms.Button
        Me.CboState = New System.Windows.Forms.ComboBox
        Me.CmdFind = New System.Windows.Forms.Button
        Me.CboOrganizationType = New System.Windows.Forms.ComboBox
        Me.CmdDeselect = New System.Windows.Forms.Button
        Me.CmdSelect = New System.Windows.Forms.Button
        Me.LstViewAvailableOrganizations = New System.Windows.Forms.ListView
        Me.LstViewSelectedOrganizations = New System.Windows.Forms.ListView
        Me._Lable_2 = New System.Windows.Forms.Label
        Me._Lable_5 = New System.Windows.Forms.Label
        Me._Lable_3 = New System.Windows.Forms.Label
        Me._Lable_4 = New System.Windows.Forms.Label
        Me._TabServiceLevel_TabPage2 = New System.Windows.Forms.TabPage
        Me._Frame_0 = New System.Windows.Forms.GroupBox
        Me.CmdAdd = New System.Windows.Forms.Button
        Me.CmdRemove = New System.Windows.Forms.Button
        Me.LstViewSourceCodes = New System.Windows.Forms.ListView
        Me._Lable_8 = New System.Windows.Forms.Label
        Me._Lable_7 = New System.Windows.Forms.Label
        Me._Lable_6 = New System.Windows.Forms.Label
        Me.Frame = New Microsoft.VisualBasic.Compatibility.VB6.GroupBoxArray(Me.components)
        Me.Label = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(Me.components)
        Me.Lable = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(Me.components)
        Me.TxtAlerts = New Microsoft.VisualBasic.Compatibility.VB6.RichTextBoxArray(Me.components)
        Me._Frame_3.SuspendLayout()
        Me.TabServiceLevel.SuspendLayout()
        Me._TabServiceLevel_TabPage0.SuspendLayout()
        Me.Frame1.SuspendLayout()
        Me.Toolbar1.SuspendLayout()
        Me._Frame_1.SuspendLayout()
        Me._Frame_4.SuspendLayout()
        Me._Frame_5.SuspendLayout()
        Me._TabServiceLevel_TabPage1.SuspendLayout()
        Me._Frame_2.SuspendLayout()
        Me._TabServiceLevel_TabPage2.SuspendLayout()
        Me._Frame_0.SuspendLayout()
        CType(Me.Frame, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.Label, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.Lable, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.TxtAlerts, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'CmdOK
        '
        Me.CmdOK.BackColor = System.Drawing.SystemColors.Control
        Me.CmdOK.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdOK.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdOK.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdOK.Location = New System.Drawing.Point(692, 6)
        Me.CmdOK.Name = "CmdOK"
        Me.CmdOK.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdOK.Size = New System.Drawing.Size(80, 21)
        Me.CmdOK.TabIndex = 10
        Me.CmdOK.Text = "&Save"
        Me.CmdOK.UseVisualStyleBackColor = False
        '
        'CmdCancel
        '
        Me.CmdCancel.BackColor = System.Drawing.SystemColors.Control
        Me.CmdCancel.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdCancel.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdCancel.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdCancel.Location = New System.Drawing.Point(692, 32)
        Me.CmdCancel.Name = "CmdCancel"
        Me.CmdCancel.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdCancel.Size = New System.Drawing.Size(80, 21)
        Me.CmdCancel.TabIndex = 11
        Me.CmdCancel.Text = "&Cancel"
        Me.CmdCancel.UseVisualStyleBackColor = False
        '
        '_Frame_3
        '
        Me._Frame_3.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_3.Controls.Add(Me.CboType)
        Me._Frame_3.Controls.Add(Me.CmdPrintList)
        Me._Frame_3.Controls.Add(Me.CmdAlertGroupDetail)
        Me._Frame_3.Controls.Add(Me.CboAlertGroup)
        Me._Frame_3.Controls.Add(Me._Lable_0)
        Me._Frame_3.Controls.Add(Me._Lable_1)
        Me._Frame_3.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me._Frame_3.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_3, CType(3, Short))
        Me._Frame_3.Location = New System.Drawing.Point(0, 0)
        Me._Frame_3.Name = "_Frame_3"
        Me._Frame_3.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_3.Size = New System.Drawing.Size(683, 73)
        Me._Frame_3.TabIndex = 12
        Me._Frame_3.TabStop = False
        '
        'CboType
        '
        Me.CboType.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboType.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboType.BackColor = System.Drawing.SystemColors.Window
        Me.CboType.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboType.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboType.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboType.Location = New System.Drawing.Point(73, 16)
        Me.CboType.Name = "CboType"
        Me.CboType.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboType.Size = New System.Drawing.Size(105, 22)
        Me.CboType.TabIndex = 44
        '
        'CmdPrintList
        '
        Me.CmdPrintList.BackColor = System.Drawing.SystemColors.Control
        Me.CmdPrintList.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdPrintList.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdPrintList.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdPrintList.Location = New System.Drawing.Point(180, 15)
        Me.CmdPrintList.Name = "CmdPrintList"
        Me.CmdPrintList.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdPrintList.Size = New System.Drawing.Size(55, 21)
        Me.CmdPrintList.TabIndex = 38
        Me.CmdPrintList.Text = "&Print"
        Me.CmdPrintList.UseVisualStyleBackColor = False
        Me.CmdPrintList.Visible = False
        '
        'CmdAlertGroupDetail
        '
        Me.CmdAlertGroupDetail.BackColor = System.Drawing.SystemColors.Control
        Me.CmdAlertGroupDetail.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdAlertGroupDetail.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdAlertGroupDetail.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdAlertGroupDetail.Location = New System.Drawing.Point(316, 39)
        Me.CmdAlertGroupDetail.Name = "CmdAlertGroupDetail"
        Me.CmdAlertGroupDetail.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdAlertGroupDetail.Size = New System.Drawing.Size(24, 21)
        Me.CmdAlertGroupDetail.TabIndex = 1
        Me.CmdAlertGroupDetail.Text = "..."
        Me.CmdAlertGroupDetail.UseVisualStyleBackColor = False
        '
        'CboAlertGroup
        '
        Me.CboAlertGroup.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboAlertGroup.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboAlertGroup.BackColor = System.Drawing.SystemColors.Window
        Me.CboAlertGroup.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboAlertGroup.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboAlertGroup.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboAlertGroup.Location = New System.Drawing.Point(73, 40)
        Me.CboAlertGroup.Name = "CboAlertGroup"
        Me.CboAlertGroup.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboAlertGroup.Size = New System.Drawing.Size(241, 22)
        Me.CboAlertGroup.Sorted = True
        Me.CboAlertGroup.TabIndex = 0
        '
        '_Lable_0
        '
        Me._Lable_0.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_0, CType(0, Short))
        Me._Lable_0.Location = New System.Drawing.Point(10, 20)
        Me._Lable_0.Name = "_Lable_0"
        Me._Lable_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_0.Size = New System.Drawing.Size(77, 17)
        Me._Lable_0.TabIndex = 29
        Me._Lable_0.Text = "Alert Type"
        '
        '_Lable_1
        '
        Me._Lable_1.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_1, CType(1, Short))
        Me._Lable_1.Location = New System.Drawing.Point(10, 46)
        Me._Lable_1.Name = "_Lable_1"
        Me._Lable_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_1.Size = New System.Drawing.Size(67, 17)
        Me._Lable_1.TabIndex = 13
        Me._Lable_1.Text = "Alert Group"
        '
        'ImageList1
        '
        Me.ImageList1.ImageStream = CType(resources.GetObject("ImageList1.ImageStream"), System.Windows.Forms.ImageListStreamer)
        Me.ImageList1.TransparentColor = System.Drawing.Color.FromArgb(CType(CType(192, Byte), Integer), CType(CType(192, Byte), Integer), CType(CType(192, Byte), Integer))
        Me.ImageList1.Images.SetKeyName(0, "")
        Me.ImageList1.Images.SetKeyName(1, "")
        Me.ImageList1.Images.SetKeyName(2, "")
        Me.ImageList1.Images.SetKeyName(3, "")
        Me.ImageList1.Images.SetKeyName(4, "")
        Me.ImageList1.Images.SetKeyName(5, "")
        Me.ImageList1.Images.SetKeyName(6, "")
        Me.ImageList1.Images.SetKeyName(7, "")
        '
        'TabServiceLevel
        '
        Me.TabServiceLevel.Controls.Add(Me._TabServiceLevel_TabPage0)
        Me.TabServiceLevel.Controls.Add(Me._TabServiceLevel_TabPage1)
        Me.TabServiceLevel.Controls.Add(Me._TabServiceLevel_TabPage2)
        Me.TabServiceLevel.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TabServiceLevel.ItemSize = New System.Drawing.Size(42, 18)
        Me.TabServiceLevel.Location = New System.Drawing.Point(0, 75)
        Me.TabServiceLevel.Name = "TabServiceLevel"
        Me.TabServiceLevel.SelectedIndex = 0
        Me.TabServiceLevel.Size = New System.Drawing.Size(771, 634)
        Me.TabServiceLevel.TabIndex = 2
        '
        '_TabServiceLevel_TabPage0
        '
        Me._TabServiceLevel_TabPage0.Controls.Add(Me.Frame1)
        Me._TabServiceLevel_TabPage0.Controls.Add(Me._Frame_1)
        Me._TabServiceLevel_TabPage0.Controls.Add(Me._Frame_4)
        Me._TabServiceLevel_TabPage0.Controls.Add(Me._Frame_5)
        Me._TabServiceLevel_TabPage0.Location = New System.Drawing.Point(4, 22)
        Me._TabServiceLevel_TabPage0.Name = "_TabServiceLevel_TabPage0"
        Me._TabServiceLevel_TabPage0.Size = New System.Drawing.Size(763, 608)
        Me._TabServiceLevel_TabPage0.TabIndex = 0
        Me._TabServiceLevel_TabPage0.Text = "Alert Settings"
        '
        'Frame1
        '
        Me.Frame1.BackColor = System.Drawing.SystemColors.Control
        Me.Frame1.Controls.Add(Me.Toolbar1)
        Me.Frame1.Controls.Add(Me.cmbsize)
        Me.Frame1.Controls.Add(Me.cmbfont)
        Me.Frame1.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me.Frame1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Frame1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame1.Location = New System.Drawing.Point(3, -5)
        Me.Frame1.Margin = New System.Windows.Forms.Padding(10, 3, 3, 3)
        Me.Frame1.Name = "Frame1"
        Me.Frame1.Padding = New System.Windows.Forms.Padding(0)
        Me.Frame1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame1.Size = New System.Drawing.Size(481, 45)
        Me.Frame1.TabIndex = 45
        Me.Frame1.TabStop = False
        '
        'Toolbar1
        '
        Me.Toolbar1.Anchor = System.Windows.Forms.AnchorStyles.None
        Me.Toolbar1.AutoSize = False
        Me.Toolbar1.Dock = System.Windows.Forms.DockStyle.None
        Me.Toolbar1.ImageList = Me.ImageList1
        Me.Toolbar1.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.bold, Me.italic, Me._Toolbar1_Button4, Me.underline, Me.color, Me._Toolbar1_Button6, Me.left, Me.center, Me.right, Me._Toolbar1_Button10, Me.bullet})
        Me.Toolbar1.LayoutStyle = System.Windows.Forms.ToolStripLayoutStyle.Flow
        Me.Toolbar1.Location = New System.Drawing.Point(229, 11)
        Me.Toolbar1.Name = "Toolbar1"
        Me.Toolbar1.RenderMode = System.Windows.Forms.ToolStripRenderMode.System
        Me.Toolbar1.Size = New System.Drawing.Size(245, 26)
        Me.Toolbar1.TabIndex = 48
        '
        'bold
        '
        Me.bold.AutoSize = False
        Me.bold.ImageIndex = 0
        Me.bold.Name = "bold"
        Me.bold.Size = New System.Drawing.Size(24, 22)
        Me.bold.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.bold.ToolTipText = "Bold"
        '
        'italic
        '
        Me.italic.AutoSize = False
        Me.italic.ImageIndex = 1
        Me.italic.Name = "italic"
        Me.italic.Size = New System.Drawing.Size(24, 22)
        Me.italic.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.italic.ToolTipText = "Italic"
        '
        '_Toolbar1_Button4
        '
        Me._Toolbar1_Button4.AutoSize = False
        Me._Toolbar1_Button4.Name = "_Toolbar1_Button4"
        Me._Toolbar1_Button4.Size = New System.Drawing.Size(10, 22)
        '
        'underline
        '
        Me.underline.AutoSize = False
        Me.underline.Font = New System.Drawing.Font("Tahoma", 5.0!)
        Me.underline.ImageIndex = 2
        Me.underline.Name = "underline"
        Me.underline.Size = New System.Drawing.Size(24, 22)
        Me.underline.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.underline.ToolTipText = "Underline"
        '
        'color
        '
        Me.color.AutoSize = False
        Me.color.ImageIndex = 3
        Me.color.Name = "color"
        Me.color.Size = New System.Drawing.Size(24, 22)
        Me.color.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.color.ToolTipText = "Font Color"
        '
        '_Toolbar1_Button6
        '
        Me._Toolbar1_Button6.AutoSize = False
        Me._Toolbar1_Button6.Name = "_Toolbar1_Button6"
        Me._Toolbar1_Button6.Size = New System.Drawing.Size(10, 22)
        '
        'left
        '
        Me.left.AutoSize = False
        Me.left.ImageIndex = 4
        Me.left.Name = "left"
        Me.left.Size = New System.Drawing.Size(24, 22)
        Me.left.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.left.ToolTipText = "Align Left"
        '
        'center
        '
        Me.center.AutoSize = False
        Me.center.ImageIndex = 5
        Me.center.Name = "center"
        Me.center.Size = New System.Drawing.Size(24, 22)
        Me.center.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.center.ToolTipText = "Center"
        '
        'right
        '
        Me.right.AutoSize = False
        Me.right.ImageIndex = 6
        Me.right.Name = "right"
        Me.right.Size = New System.Drawing.Size(24, 22)
        Me.right.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.right.ToolTipText = "Align Right"
        '
        '_Toolbar1_Button10
        '
        Me._Toolbar1_Button10.AutoSize = False
        Me._Toolbar1_Button10.Name = "_Toolbar1_Button10"
        Me._Toolbar1_Button10.Size = New System.Drawing.Size(10, 22)
        '
        'bullet
        '
        Me.bullet.AutoSize = False
        Me.bullet.ImageIndex = 7
        Me.bullet.Name = "bullet"
        Me.bullet.ShowDropDownArrow = False
        Me.bullet.Size = New System.Drawing.Size(37, 22)
        Me.bullet.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.bullet.ToolTipText = "Bullet"
        '
        'cmbsize
        '
        Me.cmbsize.BackColor = System.Drawing.SystemColors.Window
        Me.cmbsize.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmbsize.Dock = System.Windows.Forms.DockStyle.Left
        Me.cmbsize.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cmbsize.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmbsize.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cmbsize.Location = New System.Drawing.Point(138, 13)
        Me.cmbsize.Margin = New System.Windows.Forms.Padding(3, 3, 10, 3)
        Me.cmbsize.Name = "cmbsize"
        Me.cmbsize.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmbsize.Size = New System.Drawing.Size(71, 22)
        Me.cmbsize.TabIndex = 47
        '
        'cmbfont
        '
        Me.cmbfont.BackColor = System.Drawing.SystemColors.Window
        Me.cmbfont.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmbfont.Dock = System.Windows.Forms.DockStyle.Left
        Me.cmbfont.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cmbfont.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmbfont.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cmbfont.Location = New System.Drawing.Point(0, 13)
        Me.cmbfont.Name = "cmbfont"
        Me.cmbfont.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmbfont.Size = New System.Drawing.Size(138, 22)
        Me.cmbfont.Sorted = True
        Me.cmbfont.TabIndex = 46
        '
        '_Frame_1
        '
        Me._Frame_1.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_1.Controls.Add(Me._TxtAlerts_0)
        Me._Frame_1.Controls.Add(Me._TxtAlerts_1)
        Me._Frame_1.Controls.Add(Me.LblAlert1)
        Me._Frame_1.Controls.Add(Me._Label_1)
        Me._Frame_1.Controls.Add(Me._Label_0)
        Me._Frame_1.Controls.Add(Me.LblAlert2)
        Me._Frame_1.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me._Frame_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_1, CType(1, Short))
        Me._Frame_1.Location = New System.Drawing.Point(3, 38)
        Me._Frame_1.Name = "_Frame_1"
        Me._Frame_1.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_1.Size = New System.Drawing.Size(481, 314)
        Me._Frame_1.TabIndex = 19
        Me._Frame_1.TabStop = False
        Me._Frame_1.Text = "Referral/Message Alerts"
        '
        '_TxtAlerts_0
        '
        Me._TxtAlerts_0.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me._TxtAlerts_0.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtAlerts.SetIndex(Me._TxtAlerts_0, CType(0, Short))
        Me._TxtAlerts_0.Location = New System.Drawing.Point(3, 85)
        Me._TxtAlerts_0.MaxLength = 2000
        Me._TxtAlerts_0.Name = "_TxtAlerts_0"
        Me._TxtAlerts_0.RightMargin = 199
        Me._TxtAlerts_0.ScrollBars = System.Windows.Forms.RichTextBoxScrollBars.Vertical
        Me._TxtAlerts_0.Size = New System.Drawing.Size(234, 223)
        Me._TxtAlerts_0.TabIndex = 26
        Me._TxtAlerts_0.Text = ""
        '
        '_TxtAlerts_1
        '
        Me._TxtAlerts_1.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me._TxtAlerts_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtAlerts.SetIndex(Me._TxtAlerts_1, CType(1, Short))
        Me._TxtAlerts_1.Location = New System.Drawing.Point(240, 85)
        Me._TxtAlerts_1.MaxLength = 2000
        Me._TxtAlerts_1.Name = "_TxtAlerts_1"
        Me._TxtAlerts_1.RightMargin = 199
        Me._TxtAlerts_1.ScrollBars = System.Windows.Forms.RichTextBoxScrollBars.Vertical
        Me._TxtAlerts_1.Size = New System.Drawing.Size(234, 223)
        Me._TxtAlerts_1.TabIndex = 27
        Me._TxtAlerts_1.Text = ""
        '
        'LblAlert1
        '
        Me.LblAlert1.BackColor = System.Drawing.SystemColors.Control
        Me.LblAlert1.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblAlert1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblAlert1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblAlert1.Location = New System.Drawing.Point(12, 26)
        Me.LblAlert1.Name = "LblAlert1"
        Me.LblAlert1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblAlert1.Size = New System.Drawing.Size(221, 56)
        Me.LblAlert1.TabIndex = 22
        Me.LblAlert1.Text = "Alert #1 Message"
        '
        '_Label_1
        '
        Me._Label_1.BackColor = System.Drawing.SystemColors.Control
        Me._Label_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_1, CType(1, Short))
        Me._Label_1.Location = New System.Drawing.Point(249, 13)
        Me._Label_1.Name = "_Label_1"
        Me._Label_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_1.Size = New System.Drawing.Size(67, 15)
        Me._Label_1.TabIndex = 21
        Me._Label_1.Text = "Alert #2:"
        '
        '_Label_0
        '
        Me._Label_0.BackColor = System.Drawing.SystemColors.Control
        Me._Label_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_0, CType(0, Short))
        Me._Label_0.Location = New System.Drawing.Point(12, 13)
        Me._Label_0.Name = "_Label_0"
        Me._Label_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_0.Size = New System.Drawing.Size(49, 15)
        Me._Label_0.TabIndex = 20
        Me._Label_0.Text = "Alert #1:"
        '
        'LblAlert2
        '
        Me.LblAlert2.BackColor = System.Drawing.SystemColors.Control
        Me.LblAlert2.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblAlert2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblAlert2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblAlert2.Location = New System.Drawing.Point(239, 26)
        Me.LblAlert2.Name = "LblAlert2"
        Me.LblAlert2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblAlert2.Size = New System.Drawing.Size(235, 56)
        Me.LblAlert2.TabIndex = 23
        Me.LblAlert2.Text = "Alert #2 Message"
        '
        '_Frame_4
        '
        Me._Frame_4.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_4.Controls.Add(Me._TxtAlerts_2)
        Me._Frame_4.Controls.Add(Me._Label_10)
        Me._Frame_4.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me._Frame_4.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_4.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_4, CType(4, Short))
        Me._Frame_4.Location = New System.Drawing.Point(486, 38)
        Me._Frame_4.Name = "_Frame_4"
        Me._Frame_4.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_4.Size = New System.Drawing.Size(275, 235)
        Me._Frame_4.TabIndex = 24
        Me._Frame_4.TabStop = False
        Me._Frame_4.Text = "Schedule Alert"
        '
        '_TxtAlerts_2
        '
        Me._TxtAlerts_2.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me._TxtAlerts_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtAlerts.SetIndex(Me._TxtAlerts_2, CType(2, Short))
        Me._TxtAlerts_2.Location = New System.Drawing.Point(10, 126)
        Me._TxtAlerts_2.MaxLength = 2000
        Me._TxtAlerts_2.Name = "_TxtAlerts_2"
        Me._TxtAlerts_2.RightMargin = 230
        Me._TxtAlerts_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._TxtAlerts_2.ScrollBars = System.Windows.Forms.RichTextBoxScrollBars.Vertical
        Me._TxtAlerts_2.Size = New System.Drawing.Size(255, 100)
        Me._TxtAlerts_2.TabIndex = 28
        Me._TxtAlerts_2.Text = ""
        '
        '_Label_10
        '
        Me._Label_10.BackColor = System.Drawing.SystemColors.Control
        Me._Label_10.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_10.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_10.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_10, CType(10, Short))
        Me._Label_10.Location = New System.Drawing.Point(10, 30)
        Me._Label_10.Name = "_Label_10"
        Me._Label_10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_10.Size = New System.Drawing.Size(251, 99)
        Me._Label_10.TabIndex = 25
        Me._Label_10.Text = resources.GetString("_Label_10.Text")
        '
        '_Frame_5
        '
        Me._Frame_5.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_5.Controls.Add(Me._TxtAlerts_3)
        Me._Frame_5.Controls.Add(Me._TxtAlerts_4)
        Me._Frame_5.Controls.Add(Me._Label_3)
        Me._Frame_5.Controls.Add(Me._Label_2)
        Me._Frame_5.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me._Frame_5.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_5.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_5, CType(5, Short))
        Me._Frame_5.Location = New System.Drawing.Point(3, 350)
        Me._Frame_5.Name = "_Frame_5"
        Me._Frame_5.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_5.Size = New System.Drawing.Size(481, 258)
        Me._Frame_5.TabIndex = 39
        Me._Frame_5.TabStop = False
        Me._Frame_5.Text = "QA Alert Messages"
        '
        '_TxtAlerts_3
        '
        Me._TxtAlerts_3.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me._TxtAlerts_3.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtAlerts.SetIndex(Me._TxtAlerts_3, CType(3, Short))
        Me._TxtAlerts_3.Location = New System.Drawing.Point(3, 30)
        Me._TxtAlerts_3.MaxLength = 2000
        Me._TxtAlerts_3.Name = "_TxtAlerts_3"
        Me._TxtAlerts_3.RightMargin = 199
        Me._TxtAlerts_3.ScrollBars = System.Windows.Forms.RichTextBoxScrollBars.Vertical
        Me._TxtAlerts_3.Size = New System.Drawing.Size(234, 223)
        Me._TxtAlerts_3.TabIndex = 42
        Me._TxtAlerts_3.Text = ""
        '
        '_TxtAlerts_4
        '
        Me._TxtAlerts_4.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me._TxtAlerts_4.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtAlerts.SetIndex(Me._TxtAlerts_4, CType(4, Short))
        Me._TxtAlerts_4.Location = New System.Drawing.Point(240, 30)
        Me._TxtAlerts_4.MaxLength = 2000
        Me._TxtAlerts_4.Name = "_TxtAlerts_4"
        Me._TxtAlerts_4.RightMargin = 199
        Me._TxtAlerts_4.ScrollBars = System.Windows.Forms.RichTextBoxScrollBars.Vertical
        Me._TxtAlerts_4.Size = New System.Drawing.Size(234, 223)
        Me._TxtAlerts_4.TabIndex = 43
        Me._TxtAlerts_4.Text = ""
        '
        '_Label_3
        '
        Me._Label_3.BackColor = System.Drawing.SystemColors.Control
        Me._Label_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_3.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_3, CType(3, Short))
        Me._Label_3.Location = New System.Drawing.Point(236, 16)
        Me._Label_3.Name = "_Label_3"
        Me._Label_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_3.Size = New System.Drawing.Size(67, 15)
        Me._Label_3.TabIndex = 41
        Me._Label_3.Text = "Alert #2:"
        '
        '_Label_2
        '
        Me._Label_2.BackColor = System.Drawing.SystemColors.Control
        Me._Label_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_2, CType(2, Short))
        Me._Label_2.Location = New System.Drawing.Point(12, 16)
        Me._Label_2.Name = "_Label_2"
        Me._Label_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_2.Size = New System.Drawing.Size(49, 15)
        Me._Label_2.TabIndex = 40
        Me._Label_2.Text = "Alert #1:"
        '
        '_TabServiceLevel_TabPage1
        '
        Me._TabServiceLevel_TabPage1.Controls.Add(Me._Frame_2)
        Me._TabServiceLevel_TabPage1.Location = New System.Drawing.Point(4, 22)
        Me._TabServiceLevel_TabPage1.Name = "_TabServiceLevel_TabPage1"
        Me._TabServiceLevel_TabPage1.Size = New System.Drawing.Size(763, 608)
        Me._TabServiceLevel_TabPage1.TabIndex = 1
        Me._TabServiceLevel_TabPage1.Text = "Applies To"
        '
        '_Frame_2
        '
        Me._Frame_2.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_2.Controls.Add(Me.CmdUnassigned)
        Me._Frame_2.Controls.Add(Me.CboState)
        Me._Frame_2.Controls.Add(Me.CmdFind)
        Me._Frame_2.Controls.Add(Me.CboOrganizationType)
        Me._Frame_2.Controls.Add(Me.CmdDeselect)
        Me._Frame_2.Controls.Add(Me.CmdSelect)
        Me._Frame_2.Controls.Add(Me.LstViewAvailableOrganizations)
        Me._Frame_2.Controls.Add(Me.LstViewSelectedOrganizations)
        Me._Frame_2.Controls.Add(Me._Lable_2)
        Me._Frame_2.Controls.Add(Me._Lable_5)
        Me._Frame_2.Controls.Add(Me._Lable_3)
        Me._Frame_2.Controls.Add(Me._Lable_4)
        Me._Frame_2.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me._Frame_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_2, CType(2, Short))
        Me._Frame_2.Location = New System.Drawing.Point(6, 8)
        Me._Frame_2.Name = "_Frame_2"
        Me._Frame_2.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_2.Size = New System.Drawing.Size(751, 431)
        Me._Frame_2.TabIndex = 14
        Me._Frame_2.TabStop = False
        '
        'CmdUnassigned
        '
        Me.CmdUnassigned.BackColor = System.Drawing.SystemColors.Control
        Me.CmdUnassigned.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdUnassigned.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdUnassigned.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdUnassigned.Location = New System.Drawing.Point(270, 38)
        Me.CmdUnassigned.Name = "CmdUnassigned"
        Me.CmdUnassigned.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdUnassigned.Size = New System.Drawing.Size(77, 21)
        Me.CmdUnassigned.TabIndex = 37
        Me.CmdUnassigned.Text = "&Unassigned"
        Me.CmdUnassigned.UseVisualStyleBackColor = False
        '
        'CboState
        '
        Me.CboState.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboState.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboState.BackColor = System.Drawing.SystemColors.Window
        Me.CboState.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboState.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboState.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboState.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboState.Location = New System.Drawing.Point(42, 14)
        Me.CboState.Name = "CboState"
        Me.CboState.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboState.Size = New System.Drawing.Size(51, 22)
        Me.CboState.Sorted = True
        Me.CboState.TabIndex = 3
        '
        'CmdFind
        '
        Me.CmdFind.BackColor = System.Drawing.SystemColors.Control
        Me.CmdFind.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdFind.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdFind.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdFind.Location = New System.Drawing.Point(270, 14)
        Me.CmdFind.Name = "CmdFind"
        Me.CmdFind.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdFind.Size = New System.Drawing.Size(77, 21)
        Me.CmdFind.TabIndex = 5
        Me.CmdFind.Text = "&Find"
        Me.CmdFind.UseVisualStyleBackColor = False
        '
        'CboOrganizationType
        '
        Me.CboOrganizationType.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboOrganizationType.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboOrganizationType.BackColor = System.Drawing.SystemColors.Window
        Me.CboOrganizationType.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboOrganizationType.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboOrganizationType.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboOrganizationType.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboOrganizationType.Location = New System.Drawing.Point(128, 14)
        Me.CboOrganizationType.Name = "CboOrganizationType"
        Me.CboOrganizationType.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboOrganizationType.Size = New System.Drawing.Size(141, 22)
        Me.CboOrganizationType.Sorted = True
        Me.CboOrganizationType.TabIndex = 4
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
        Me.CmdDeselect.TabIndex = 8
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
        Me.CmdSelect.Size = New System.Drawing.Size(53, 21)
        Me.CmdSelect.TabIndex = 7
        Me.CmdSelect.Text = "Add  >>"
        Me.CmdSelect.UseVisualStyleBackColor = False
        '
        'LstViewAvailableOrganizations
        '
        Me.LstViewAvailableOrganizations.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewAvailableOrganizations.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.LstViewAvailableOrganizations.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewAvailableOrganizations.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewAvailableOrganizations.FullRowSelect = True
        Me.LstViewAvailableOrganizations.HideSelection = False
        Me.LstViewAvailableOrganizations.LabelWrap = False
        Me.LstViewAvailableOrganizations.Location = New System.Drawing.Point(10, 62)
        Me.LstViewAvailableOrganizations.Name = "LstViewAvailableOrganizations"
        Me.LstViewAvailableOrganizations.Size = New System.Drawing.Size(335, 361)
        Me.LstViewAvailableOrganizations.TabIndex = 6
        Me.LstViewAvailableOrganizations.UseCompatibleStateImageBehavior = False
        Me.LstViewAvailableOrganizations.View = System.Windows.Forms.View.Details
        '
        'LstViewSelectedOrganizations
        '
        Me.LstViewSelectedOrganizations.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewSelectedOrganizations.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.LstViewSelectedOrganizations.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewSelectedOrganizations.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewSelectedOrganizations.FullRowSelect = True
        Me.LstViewSelectedOrganizations.HideSelection = False
        Me.LstViewSelectedOrganizations.LabelWrap = False
        Me.LstViewSelectedOrganizations.Location = New System.Drawing.Point(408, 62)
        Me.LstViewSelectedOrganizations.Name = "LstViewSelectedOrganizations"
        Me.LstViewSelectedOrganizations.Size = New System.Drawing.Size(335, 361)
        Me.LstViewSelectedOrganizations.TabIndex = 9
        Me.LstViewSelectedOrganizations.UseCompatibleStateImageBehavior = False
        Me.LstViewSelectedOrganizations.View = System.Windows.Forms.View.Details
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
        Me._Lable_2.TabIndex = 18
        Me._Lable_2.Text = "Available Organizations"
        '
        '_Lable_5
        '
        Me._Lable_5.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_5.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_5.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_5, CType(5, Short))
        Me._Lable_5.Location = New System.Drawing.Point(100, 18)
        Me._Lable_5.Name = "_Lable_5"
        Me._Lable_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_5.Size = New System.Drawing.Size(55, 17)
        Me._Lable_5.TabIndex = 17
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
        Me._Lable_3.TabIndex = 16
        Me._Lable_3.Text = "Selected Organizations"
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
        Me._Lable_4.TabIndex = 15
        Me._Lable_4.Text = "State"
        '
        '_TabServiceLevel_TabPage2
        '
        Me._TabServiceLevel_TabPage2.Controls.Add(Me._Frame_0)
        Me._TabServiceLevel_TabPage2.Location = New System.Drawing.Point(4, 22)
        Me._TabServiceLevel_TabPage2.Name = "_TabServiceLevel_TabPage2"
        Me._TabServiceLevel_TabPage2.Size = New System.Drawing.Size(763, 608)
        Me._TabServiceLevel_TabPage2.TabIndex = 2
        Me._TabServiceLevel_TabPage2.Text = "Source Codes"
        '
        '_Frame_0
        '
        Me._Frame_0.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_0.Controls.Add(Me.CmdAdd)
        Me._Frame_0.Controls.Add(Me.CmdRemove)
        Me._Frame_0.Controls.Add(Me.LstViewSourceCodes)
        Me._Frame_0.Controls.Add(Me._Lable_8)
        Me._Frame_0.Controls.Add(Me._Lable_7)
        Me._Frame_0.Controls.Add(Me._Lable_6)
        Me._Frame_0.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me._Frame_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_0, CType(0, Short))
        Me._Frame_0.Location = New System.Drawing.Point(6, 4)
        Me._Frame_0.Name = "_Frame_0"
        Me._Frame_0.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_0.Size = New System.Drawing.Size(515, 234)
        Me._Frame_0.TabIndex = 30
        Me._Frame_0.TabStop = False
        '
        'CmdAdd
        '
        Me.CmdAdd.BackColor = System.Drawing.SystemColors.Control
        Me.CmdAdd.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdAdd.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdAdd.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdAdd.Location = New System.Drawing.Point(84, 16)
        Me.CmdAdd.Name = "CmdAdd"
        Me.CmdAdd.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdAdd.Size = New System.Drawing.Size(69, 21)
        Me.CmdAdd.TabIndex = 33
        Me.CmdAdd.Text = "Add..."
        Me.CmdAdd.UseVisualStyleBackColor = False
        '
        'CmdRemove
        '
        Me.CmdRemove.BackColor = System.Drawing.SystemColors.Control
        Me.CmdRemove.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdRemove.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdRemove.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdRemove.Location = New System.Drawing.Point(160, 16)
        Me.CmdRemove.Name = "CmdRemove"
        Me.CmdRemove.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdRemove.Size = New System.Drawing.Size(69, 21)
        Me.CmdRemove.TabIndex = 32
        Me.CmdRemove.Text = "Remove"
        Me.CmdRemove.UseVisualStyleBackColor = False
        '
        'LstViewSourceCodes
        '
        Me.LstViewSourceCodes.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewSourceCodes.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.LstViewSourceCodes.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewSourceCodes.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewSourceCodes.FullRowSelect = True
        Me.LstViewSourceCodes.LabelWrap = False
        Me.LstViewSourceCodes.Location = New System.Drawing.Point(8, 42)
        Me.LstViewSourceCodes.Name = "LstViewSourceCodes"
        Me.LstViewSourceCodes.Size = New System.Drawing.Size(219, 176)
        Me.LstViewSourceCodes.TabIndex = 36
        Me.LstViewSourceCodes.UseCompatibleStateImageBehavior = False
        Me.LstViewSourceCodes.View = System.Windows.Forms.View.Details
        '
        '_Lable_8
        '
        Me._Lable_8.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_8.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_8.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_8.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_8, CType(8, Short))
        Me._Lable_8.Location = New System.Drawing.Point(242, 160)
        Me._Lable_8.Name = "_Lable_8"
        Me._Lable_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_8.Size = New System.Drawing.Size(261, 58)
        Me._Lable_8.TabIndex = 35
        Me._Lable_8.Text = "Therefore, the combination of an ""Applies To"" organization and a source code must" & _
            " be unique.  In other words, the combination can only be used once."
        '
        '_Lable_7
        '
        Me._Lable_7.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_7.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_7.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_7, CType(7, Short))
        Me._Lable_7.Location = New System.Drawing.Point(242, 40)
        Me._Lable_7.Name = "_Lable_7"
        Me._Lable_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_7.Size = New System.Drawing.Size(261, 115)
        Me._Lable_7.TabIndex = 34
        Me._Lable_7.Text = resources.GetString("_Lable_7.Text")
        '
        '_Lable_6
        '
        Me._Lable_6.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_6.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_6.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_6, CType(6, Short))
        Me._Lable_6.Location = New System.Drawing.Point(10, 20)
        Me._Lable_6.Name = "_Lable_6"
        Me._Lable_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_6.Size = New System.Drawing.Size(81, 17)
        Me._Lable_6.TabIndex = 31
        Me._Lable_6.Text = "Source Codes"
        '
        'TxtAlerts
        '
        '
        'FrmAlert
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 14.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.BackgroundImage = CType(resources.GetObject("$this.BackgroundImage"), System.Drawing.Image)
        Me.BackgroundImageLayout = System.Windows.Forms.ImageLayout.None
        Me.ClientSize = New System.Drawing.Size(773, 710)
        Me.Controls.Add(Me.CmdOK)
        Me.Controls.Add(Me.CmdCancel)
        Me.Controls.Add(Me._Frame_3)
        Me.Controls.Add(Me.TabServiceLevel)
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Location = New System.Drawing.Point(56, 46)
        Me.MaximizeBox = False
        Me.Name = "FrmAlert"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Alert"
        Me._Frame_3.ResumeLayout(False)
        Me.TabServiceLevel.ResumeLayout(False)
        Me._TabServiceLevel_TabPage0.ResumeLayout(False)
        Me.Frame1.ResumeLayout(False)
        Me.Toolbar1.ResumeLayout(False)
        Me.Toolbar1.PerformLayout()
        Me._Frame_1.ResumeLayout(False)
        Me._Frame_4.ResumeLayout(False)
        Me._Frame_5.ResumeLayout(False)
        Me._TabServiceLevel_TabPage1.ResumeLayout(False)
        Me._Frame_2.ResumeLayout(False)
        Me._TabServiceLevel_TabPage2.ResumeLayout(False)
        Me._Frame_0.ResumeLayout(False)
        CType(Me.Frame, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.Label, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.Lable, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.TxtAlerts, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)

    End Sub
    Public WithEvents right As System.Windows.Forms.ToolStripButton
#End Region 
End Class