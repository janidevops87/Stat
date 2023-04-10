<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmConsentInterval
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
        '''bret 1/4/2010 dll conversion Me.MdiParent = AppMain.ParentForm
        ''If Not (AppMain.ParentForm.Visible) Then
        ''    AppMain.ParentForm.Display()
        ''End If

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
	Public WithEvents CboConsentInterval As System.Windows.Forms.ComboBox
	Public WithEvents _Lable_0 As System.Windows.Forms.Label
	Public WithEvents _Lable_1 As System.Windows.Forms.Label
	Public WithEvents _Frame_1 As System.Windows.Forms.GroupBox
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
	Public WithEvents TabReport As System.Windows.Forms.TabControl
	Public WithEvents Frame As Microsoft.VisualBasic.Compatibility.VB6.GroupBoxArray
	Public WithEvents Lable As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FrmConsentInterval))
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.CmdCancel = New System.Windows.Forms.Button
        Me._Frame_1 = New System.Windows.Forms.GroupBox
        Me.CboConsentInterval = New System.Windows.Forms.ComboBox
        Me._Lable_0 = New System.Windows.Forms.Label
        Me._Lable_1 = New System.Windows.Forms.Label
        Me.TabReport = New System.Windows.Forms.TabControl
        Me._TabReport_TabPage0 = New System.Windows.Forms.TabPage
        Me._Frame_0 = New System.Windows.Forms.GroupBox
        Me.LstViewSelectedOrganizations = New System.Windows.Forms.ListView
        Me.LstViewAvailableOrganizations = New System.Windows.Forms.ListView
        Me.CboState = New System.Windows.Forms.ComboBox
        Me.CmdFind = New System.Windows.Forms.Button
        Me.CboOrganizationType = New System.Windows.Forms.ComboBox
        Me.CmdDeselect = New System.Windows.Forms.Button
        Me.CmdSelect = New System.Windows.Forms.Button
        Me._Lable_4 = New System.Windows.Forms.Label
        Me._Lable_2 = New System.Windows.Forms.Label
        Me._Lable_5 = New System.Windows.Forms.Label
        Me._Lable_3 = New System.Windows.Forms.Label
        Me.Frame = New Microsoft.VisualBasic.Compatibility.VB6.GroupBoxArray(Me.components)
        Me.Lable = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(Me.components)
        Me._Frame_1.SuspendLayout()
        Me.TabReport.SuspendLayout()
        Me._TabReport_TabPage0.SuspendLayout()
        Me._Frame_0.SuspendLayout()
        CType(Me.Frame, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.Lable, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'CmdCancel
        '
        Me.CmdCancel.BackColor = System.Drawing.SystemColors.Control
        Me.CmdCancel.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdCancel.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdCancel.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdCancel.Location = New System.Drawing.Point(684, 12)
        Me.CmdCancel.Name = "CmdCancel"
        Me.CmdCancel.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdCancel.Size = New System.Drawing.Size(80, 21)
        Me.CmdCancel.TabIndex = 9
        Me.CmdCancel.Text = "&Close"
        Me.CmdCancel.UseVisualStyleBackColor = False
        '
        '_Frame_1
        '
        Me._Frame_1.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_1.Controls.Add(Me.CboConsentInterval)
        Me._Frame_1.Controls.Add(Me._Lable_0)
        Me._Frame_1.Controls.Add(Me._Lable_1)
        Me._Frame_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_1, CType(1, Short))
        Me._Frame_1.Location = New System.Drawing.Point(4, 0)
        Me._Frame_1.Name = "_Frame_1"
        Me._Frame_1.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_1.Size = New System.Drawing.Size(667, 43)
        Me._Frame_1.TabIndex = 10
        Me._Frame_1.TabStop = False
        '
        'CboConsentInterval
        '
        Me.CboConsentInterval.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboConsentInterval.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboConsentInterval.BackColor = System.Drawing.SystemColors.Window
        Me.CboConsentInterval.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboConsentInterval.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboConsentInterval.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboConsentInterval.Location = New System.Drawing.Point(99, 14)
        Me.CboConsentInterval.Name = "CboConsentInterval"
        Me.CboConsentInterval.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboConsentInterval.Size = New System.Drawing.Size(89, 22)
        Me.CboConsentInterval.Sorted = True
        Me.CboConsentInterval.TabIndex = 0
        '
        '_Lable_0
        '
        Me._Lable_0.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_0, CType(0, Short))
        Me._Lable_0.Location = New System.Drawing.Point(191, 18)
        Me._Lable_0.Name = "_Lable_0"
        Me._Lable_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_0.Size = New System.Drawing.Size(77, 17)
        Me._Lable_0.TabIndex = 17
        Me._Lable_0.Text = "Minutes"
        '
        '_Lable_1
        '
        Me._Lable_1.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_1, CType(1, Short))
        Me._Lable_1.Location = New System.Drawing.Point(10, 18)
        Me._Lable_1.Name = "_Lable_1"
        Me._Lable_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_1.Size = New System.Drawing.Size(86, 17)
        Me._Lable_1.TabIndex = 11
        Me._Lable_1.Text = "Consent Interval"
        '
        'TabReport
        '
        Me.TabReport.Controls.Add(Me._TabReport_TabPage0)
        Me.TabReport.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TabReport.ItemSize = New System.Drawing.Size(42, 18)
        Me.TabReport.Location = New System.Drawing.Point(6, 48)
        Me.TabReport.Name = "TabReport"
        Me.TabReport.SelectedIndex = 0
        Me.TabReport.Size = New System.Drawing.Size(765, 385)
        Me.TabReport.TabIndex = 1
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
        Me._Frame_0.Location = New System.Drawing.Point(3, 3)
        Me._Frame_0.Name = "_Frame_0"
        Me._Frame_0.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_0.Size = New System.Drawing.Size(751, 348)
        Me._Frame_0.TabIndex = 12
        Me._Frame_0.TabStop = False
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
        Me.LstViewSelectedOrganizations.TabIndex = 8
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
        Me.LstViewAvailableOrganizations.TabIndex = 5
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
        Me.CboState.TabIndex = 2
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
        Me.CmdFind.TabIndex = 4
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
        Me.CboOrganizationType.TabIndex = 3
        '
        'CmdDeselect
        '
        Me.CmdDeselect.BackColor = System.Drawing.SystemColors.Control
        Me.CmdDeselect.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdDeselect.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdDeselect.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdDeselect.Location = New System.Drawing.Point(350, 194)
        Me.CmdDeselect.Name = "CmdDeselect"
        Me.CmdDeselect.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdDeselect.Size = New System.Drawing.Size(54, 21)
        Me.CmdDeselect.TabIndex = 7
        Me.CmdDeselect.Text = "Remove"
        Me.CmdDeselect.UseVisualStyleBackColor = False
        '
        'CmdSelect
        '
        Me.CmdSelect.BackColor = System.Drawing.SystemColors.Control
        Me.CmdSelect.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdSelect.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdSelect.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdSelect.Location = New System.Drawing.Point(350, 168)
        Me.CmdSelect.Name = "CmdSelect"
        Me.CmdSelect.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdSelect.Size = New System.Drawing.Size(53, 21)
        Me.CmdSelect.TabIndex = 6
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
        Me._Lable_4.TabIndex = 16
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
        Me._Lable_2.TabIndex = 15
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
        Me._Lable_5.TabIndex = 14
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
        Me._Lable_3.TabIndex = 13
        Me._Lable_3.Text = "Selected Organizations"
        '
        'FrmConsentInterval
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 14.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.ClientSize = New System.Drawing.Size(775, 438)
        Me.Controls.Add(Me.CmdCancel)
        Me.Controls.Add(Me._Frame_1)
        Me.Controls.Add(Me.TabReport)
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Location = New System.Drawing.Point(32, 292)
        Me.MaximizeBox = False
        Me.Name = "FrmConsentInterval"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent
        Me.Text = "Consent Intervals"
        Me._Frame_1.ResumeLayout(False)
        Me.TabReport.ResumeLayout(False)
        Me._TabReport_TabPage0.ResumeLayout(False)
        Me._Frame_0.ResumeLayout(False)
        CType(Me.Frame, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.Lable, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)

    End Sub
#End Region 
End Class