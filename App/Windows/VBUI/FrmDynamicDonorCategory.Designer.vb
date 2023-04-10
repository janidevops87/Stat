<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmDynamicDonorCategory
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
	Public WithEvents CmdSave As System.Windows.Forms.Button
	Public WithEvents CmdEditDynamicDonorCategory As System.Windows.Forms.Button
	Public WithEvents CboDynamicCategory As System.Windows.Forms.ComboBox
	Public WithEvents LblDynamicCategory As System.Windows.Forms.Label
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FrmDynamicDonorCategory))
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.CmdCancel = New System.Windows.Forms.Button
        Me.CmdSave = New System.Windows.Forms.Button
        Me.CmdEditDynamicDonorCategory = New System.Windows.Forms.Button
        Me.CboDynamicCategory = New System.Windows.Forms.ComboBox
        Me.LblDynamicCategory = New System.Windows.Forms.Label
        Me.SuspendLayout()
        '
        'CmdCancel
        '
        Me.CmdCancel.BackColor = System.Drawing.SystemColors.Control
        Me.CmdCancel.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdCancel.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdCancel.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdCancel.Location = New System.Drawing.Point(240, 32)
        Me.CmdCancel.Name = "CmdCancel"
        Me.CmdCancel.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdCancel.Size = New System.Drawing.Size(80, 21)
        Me.CmdCancel.TabIndex = 4
        Me.CmdCancel.Text = "C&ancel"
        Me.CmdCancel.UseVisualStyleBackColor = False
        '
        'CmdSave
        '
        Me.CmdSave.BackColor = System.Drawing.SystemColors.Control
        Me.CmdSave.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdSave.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdSave.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdSave.Location = New System.Drawing.Point(240, 7)
        Me.CmdSave.Name = "CmdSave"
        Me.CmdSave.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdSave.Size = New System.Drawing.Size(80, 21)
        Me.CmdSave.TabIndex = 3
        Me.CmdSave.Text = "&Save"
        Me.CmdSave.UseVisualStyleBackColor = False
        '
        'CmdEditDynamicDonorCategory
        '
        Me.CmdEditDynamicDonorCategory.BackColor = System.Drawing.SystemColors.Control
        Me.CmdEditDynamicDonorCategory.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdEditDynamicDonorCategory.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdEditDynamicDonorCategory.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdEditDynamicDonorCategory.Location = New System.Drawing.Point(213, 7)
        Me.CmdEditDynamicDonorCategory.Name = "CmdEditDynamicDonorCategory"
        Me.CmdEditDynamicDonorCategory.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdEditDynamicDonorCategory.Size = New System.Drawing.Size(24, 21)
        Me.CmdEditDynamicDonorCategory.TabIndex = 2
        Me.CmdEditDynamicDonorCategory.Text = "..."
        Me.CmdEditDynamicDonorCategory.UseVisualStyleBackColor = False
        '
        'CboDynamicCategory
        '
        Me.CboDynamicCategory.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboDynamicCategory.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboDynamicCategory.BackColor = System.Drawing.SystemColors.Window
        Me.CboDynamicCategory.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboDynamicCategory.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboDynamicCategory.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboDynamicCategory.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboDynamicCategory.Location = New System.Drawing.Point(73, 6)
        Me.CboDynamicCategory.Name = "CboDynamicCategory"
        Me.CboDynamicCategory.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboDynamicCategory.Size = New System.Drawing.Size(137, 22)
        Me.CboDynamicCategory.TabIndex = 1
        '
        'LblDynamicCategory
        '
        Me.LblDynamicCategory.BackColor = System.Drawing.SystemColors.Control
        Me.LblDynamicCategory.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblDynamicCategory.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblDynamicCategory.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblDynamicCategory.Location = New System.Drawing.Point(8, 7)
        Me.LblDynamicCategory.Name = "LblDynamicCategory"
        Me.LblDynamicCategory.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblDynamicCategory.Size = New System.Drawing.Size(69, 21)
        Me.LblDynamicCategory.TabIndex = 0
        Me.LblDynamicCategory.Text = "Organ"
        '
        'FrmDynamicDonorCategory
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 14.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.ClientSize = New System.Drawing.Size(323, 62)
        Me.Controls.Add(Me.CmdCancel)
        Me.Controls.Add(Me.CmdSave)
        Me.Controls.Add(Me.CmdEditDynamicDonorCategory)
        Me.Controls.Add(Me.CboDynamicCategory)
        Me.Controls.Add(Me.LblDynamicCategory)
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Location = New System.Drawing.Point(167, 222)
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "FrmDynamicDonorCategory"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.StartPosition = System.Windows.Forms.FormStartPosition.Manual
        Me.Text = "Dynamic Donor Category"
        Me.ResumeLayout(False)

    End Sub
#End Region 
End Class