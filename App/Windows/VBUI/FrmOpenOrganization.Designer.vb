<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmOpenOrganization
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
        'Me.MdiParent = StatTrac.MDIFormStatLine
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
	Public WithEvents CmdDelete As System.Windows.Forms.Button
	Public WithEvents LstViewOrganization As System.Windows.Forms.ListView
	Public WithEvents Frame1 As System.Windows.Forms.GroupBox
	Public WithEvents CmdFind As System.Windows.Forms.Button
	Public WithEvents CmdNew As System.Windows.Forms.Button
	Public WithEvents CmdPrintList As System.Windows.Forms.Button
	Public WithEvents CboPrint As System.Windows.Forms.ComboBox
	Public WithEvents CboState As System.Windows.Forms.ComboBox
	Public WithEvents CboOrganizationType As System.Windows.Forms.ComboBox
	Public WithEvents _LblOpenOrg_2 As System.Windows.Forms.Label
	Public WithEvents _LblOpenOrg_1 As System.Windows.Forms.Label
	Public WithEvents _LblOpenOrg_0 As System.Windows.Forms.Label
	Public WithEvents FraFilter As System.Windows.Forms.GroupBox
	Public WithEvents CmdOpen As System.Windows.Forms.Button
	Public WithEvents CmdClose As System.Windows.Forms.Button
	Public WithEvents LblOpenOrg As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FrmOpenOrganization))
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.CmdDelete = New System.Windows.Forms.Button
        Me.Frame1 = New System.Windows.Forms.GroupBox
        Me.LstViewOrganization = New System.Windows.Forms.ListView
        Me.CmdFind = New System.Windows.Forms.Button
        Me.CmdNew = New System.Windows.Forms.Button
        Me.FraFilter = New System.Windows.Forms.GroupBox
        Me.CmdPrintList = New System.Windows.Forms.Button
        Me.CboPrint = New System.Windows.Forms.ComboBox
        Me.CboState = New System.Windows.Forms.ComboBox
        Me.CboOrganizationType = New System.Windows.Forms.ComboBox
        Me._LblOpenOrg_2 = New System.Windows.Forms.Label
        Me._LblOpenOrg_1 = New System.Windows.Forms.Label
        Me._LblOpenOrg_0 = New System.Windows.Forms.Label
        Me.CmdOpen = New System.Windows.Forms.Button
        Me.CmdClose = New System.Windows.Forms.Button
        Me.LblOpenOrg = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(Me.components)
        Me.Frame1.SuspendLayout()
        Me.FraFilter.SuspendLayout()
        CType(Me.LblOpenOrg, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'CmdDelete
        '
        Me.CmdDelete.BackColor = System.Drawing.SystemColors.Control
        Me.CmdDelete.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdDelete.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdDelete.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdDelete.Location = New System.Drawing.Point(572, 324)
        Me.CmdDelete.Name = "CmdDelete"
        Me.CmdDelete.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdDelete.Size = New System.Drawing.Size(79, 21)
        Me.CmdDelete.TabIndex = 9
        Me.CmdDelete.Text = "Delete"
        Me.CmdDelete.UseVisualStyleBackColor = False
        '
        'Frame1
        '
        Me.Frame1.BackColor = System.Drawing.SystemColors.Control
        Me.Frame1.Controls.Add(Me.LstViewOrganization)
        Me.Frame1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Frame1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame1.Location = New System.Drawing.Point(4, 54)
        Me.Frame1.Name = "Frame1"
        Me.Frame1.Padding = New System.Windows.Forms.Padding(0)
        Me.Frame1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame1.Size = New System.Drawing.Size(563, 367)
        Me.Frame1.TabIndex = 9
        Me.Frame1.TabStop = False
        '
        'LstViewOrganization
        '
        Me.LstViewOrganization.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewOrganization.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewOrganization.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewOrganization.FullRowSelect = True
        Me.LstViewOrganization.HideSelection = False
        Me.LstViewOrganization.LabelEdit = True
        Me.LstViewOrganization.Location = New System.Drawing.Point(6, 12)
        Me.LstViewOrganization.Name = "LstViewOrganization"
        Me.LstViewOrganization.Size = New System.Drawing.Size(551, 349)
        Me.LstViewOrganization.TabIndex = 10
        Me.LstViewOrganization.TabStop = False
        Me.LstViewOrganization.UseCompatibleStateImageBehavior = False
        Me.LstViewOrganization.View = System.Windows.Forms.View.Details
        '
        'CmdFind
        '
        Me.CmdFind.BackColor = System.Drawing.SystemColors.Control
        Me.CmdFind.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdFind.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdFind.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdFind.Location = New System.Drawing.Point(572, 64)
        Me.CmdFind.Name = "CmdFind"
        Me.CmdFind.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdFind.Size = New System.Drawing.Size(79, 21)
        Me.CmdFind.TabIndex = 8
        Me.CmdFind.Text = "&Find"
        Me.CmdFind.UseVisualStyleBackColor = False
        '
        'CmdNew
        '
        Me.CmdNew.BackColor = System.Drawing.SystemColors.Control
        Me.CmdNew.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdNew.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdNew.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdNew.Location = New System.Drawing.Point(572, 36)
        Me.CmdNew.Name = "CmdNew"
        Me.CmdNew.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdNew.Size = New System.Drawing.Size(79, 21)
        Me.CmdNew.TabIndex = 7
        Me.CmdNew.Text = "&New..."
        Me.CmdNew.UseVisualStyleBackColor = False
        '
        'FraFilter
        '
        Me.FraFilter.BackColor = System.Drawing.SystemColors.Control
        Me.FraFilter.Controls.Add(Me.CmdPrintList)
        Me.FraFilter.Controls.Add(Me.CboPrint)
        Me.FraFilter.Controls.Add(Me.CboState)
        Me.FraFilter.Controls.Add(Me.CboOrganizationType)
        Me.FraFilter.Controls.Add(Me._LblOpenOrg_2)
        Me.FraFilter.Controls.Add(Me._LblOpenOrg_1)
        Me.FraFilter.Controls.Add(Me._LblOpenOrg_0)
        Me.FraFilter.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FraFilter.ForeColor = System.Drawing.SystemColors.ControlText
        Me.FraFilter.Location = New System.Drawing.Point(4, 4)
        Me.FraFilter.Name = "FraFilter"
        Me.FraFilter.Padding = New System.Windows.Forms.Padding(0)
        Me.FraFilter.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.FraFilter.Size = New System.Drawing.Size(563, 49)
        Me.FraFilter.TabIndex = 5
        Me.FraFilter.TabStop = False
        Me.FraFilter.Text = "Filter"
        '
        'CmdPrintList
        '
        Me.CmdPrintList.BackColor = System.Drawing.SystemColors.Control
        Me.CmdPrintList.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdPrintList.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdPrintList.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdPrintList.Location = New System.Drawing.Point(478, 18)
        Me.CmdPrintList.Name = "CmdPrintList"
        Me.CmdPrintList.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdPrintList.Size = New System.Drawing.Size(79, 21)
        Me.CmdPrintList.TabIndex = 14
        Me.CmdPrintList.Text = "Print"
        Me.CmdPrintList.UseVisualStyleBackColor = False
        '
        'CboPrint
        '
        Me.CboPrint.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboPrint.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboPrint.BackColor = System.Drawing.SystemColors.Window
        Me.CboPrint.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboPrint.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboPrint.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboPrint.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboPrint.Items.AddRange(New Object() {"Detail List", "Assignments 1", "Assignments 1 (SC)", "Alert/Criteria", "Alert/Criteria (SC)"})
        Me.CboPrint.Location = New System.Drawing.Point(344, 18)
        Me.CboPrint.Name = "CboPrint"
        Me.CboPrint.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboPrint.Size = New System.Drawing.Size(129, 22)
        Me.CboPrint.TabIndex = 12
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
        Me.CboState.Location = New System.Drawing.Point(40, 18)
        Me.CboState.Name = "CboState"
        Me.CboState.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboState.Size = New System.Drawing.Size(51, 22)
        Me.CboState.Sorted = True
        Me.CboState.TabIndex = 0
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
        Me.CboOrganizationType.Location = New System.Drawing.Point(128, 18)
        Me.CboOrganizationType.Name = "CboOrganizationType"
        Me.CboOrganizationType.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboOrganizationType.Size = New System.Drawing.Size(185, 22)
        Me.CboOrganizationType.Sorted = True
        Me.CboOrganizationType.TabIndex = 1
        '
        '_LblOpenOrg_2
        '
        Me._LblOpenOrg_2.BackColor = System.Drawing.SystemColors.Control
        Me._LblOpenOrg_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblOpenOrg_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LblOpenOrg_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblOpenOrg.SetIndex(Me._LblOpenOrg_2, CType(2, Short))
        Me._LblOpenOrg_2.Location = New System.Drawing.Point(318, 22)
        Me._LblOpenOrg_2.Name = "_LblOpenOrg_2"
        Me._LblOpenOrg_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblOpenOrg_2.Size = New System.Drawing.Size(61, 17)
        Me._LblOpenOrg_2.TabIndex = 13
        Me._LblOpenOrg_2.Text = "Print"
        '
        '_LblOpenOrg_1
        '
        Me._LblOpenOrg_1.BackColor = System.Drawing.SystemColors.Control
        Me._LblOpenOrg_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblOpenOrg_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LblOpenOrg_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblOpenOrg.SetIndex(Me._LblOpenOrg_1, CType(1, Short))
        Me._LblOpenOrg_1.Location = New System.Drawing.Point(8, 22)
        Me._LblOpenOrg_1.Name = "_LblOpenOrg_1"
        Me._LblOpenOrg_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblOpenOrg_1.Size = New System.Drawing.Size(55, 19)
        Me._LblOpenOrg_1.TabIndex = 7
        Me._LblOpenOrg_1.Text = "State"
        '
        '_LblOpenOrg_0
        '
        Me._LblOpenOrg_0.BackColor = System.Drawing.SystemColors.Control
        Me._LblOpenOrg_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblOpenOrg_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LblOpenOrg_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblOpenOrg.SetIndex(Me._LblOpenOrg_0, CType(0, Short))
        Me._LblOpenOrg_0.Location = New System.Drawing.Point(98, 22)
        Me._LblOpenOrg_0.Name = "_LblOpenOrg_0"
        Me._LblOpenOrg_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblOpenOrg_0.Size = New System.Drawing.Size(61, 17)
        Me._LblOpenOrg_0.TabIndex = 6
        Me._LblOpenOrg_0.Text = "Type"
        '
        'CmdOpen
        '
        Me.CmdOpen.BackColor = System.Drawing.SystemColors.Control
        Me.CmdOpen.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdOpen.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdOpen.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdOpen.Location = New System.Drawing.Point(572, 10)
        Me.CmdOpen.Name = "CmdOpen"
        Me.CmdOpen.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdOpen.Size = New System.Drawing.Size(79, 21)
        Me.CmdOpen.TabIndex = 6
        Me.CmdOpen.Text = "O&pen..."
        Me.CmdOpen.UseVisualStyleBackColor = False
        '
        'CmdClose
        '
        Me.CmdClose.BackColor = System.Drawing.SystemColors.Control
        Me.CmdClose.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdClose.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdClose.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdClose.Location = New System.Drawing.Point(572, 400)
        Me.CmdClose.Name = "CmdClose"
        Me.CmdClose.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdClose.Size = New System.Drawing.Size(79, 21)
        Me.CmdClose.TabIndex = 10
        Me.CmdClose.Text = "&Close"
        Me.CmdClose.UseVisualStyleBackColor = False
        '
        'FrmOpenOrganization
        '
        Me.AcceptButton = Me.CmdFind
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 14.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.ClientSize = New System.Drawing.Size(655, 425)
        Me.Controls.Add(Me.CmdDelete)
        Me.Controls.Add(Me.Frame1)
        Me.Controls.Add(Me.CmdFind)
        Me.Controls.Add(Me.CmdNew)
        Me.Controls.Add(Me.FraFilter)
        Me.Controls.Add(Me.CmdOpen)
        Me.Controls.Add(Me.CmdClose)
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Location = New System.Drawing.Point(166, 236)
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "FrmOpenOrganization"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Organizations"
        Me.Frame1.ResumeLayout(False)
        Me.FraFilter.ResumeLayout(False)
        CType(Me.LblOpenOrg, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)

    End Sub
#End Region 
End Class