<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmLeaseOrganizationCalls
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
	Public WithEvents CmdClose As System.Windows.Forms.Button
	Public WithEvents CmdDisable As System.Windows.Forms.Button
	Public WithEvents CmdEnable As System.Windows.Forms.Button
	Public WithEvents LstViewDisabledLOCalls As System.Windows.Forms.ListView
	Public WithEvents LstViewEnabledLOCalls As System.Windows.Forms.ListView
	Public WithEvents Label2 As System.Windows.Forms.Label
	Public WithEvents Label1 As System.Windows.Forms.Label
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FrmLeaseOrganizationCalls))
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.CmdClose = New System.Windows.Forms.Button
        Me.CmdDisable = New System.Windows.Forms.Button
        Me.CmdEnable = New System.Windows.Forms.Button
        Me.LstViewDisabledLOCalls = New System.Windows.Forms.ListView
        Me.LstViewEnabledLOCalls = New System.Windows.Forms.ListView
        Me.Label2 = New System.Windows.Forms.Label
        Me.Label1 = New System.Windows.Forms.Label
        Me.SuspendLayout()
        '
        'CmdClose
        '
        Me.CmdClose.BackColor = System.Drawing.SystemColors.Control
        Me.CmdClose.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdClose.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdClose.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdClose.Location = New System.Drawing.Point(480, 16)
        Me.CmdClose.Name = "CmdClose"
        Me.CmdClose.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdClose.Size = New System.Drawing.Size(65, 25)
        Me.CmdClose.TabIndex = 6
        Me.CmdClose.Text = "Close"
        Me.CmdClose.UseVisualStyleBackColor = False
        '
        'CmdDisable
        '
        Me.CmdDisable.BackColor = System.Drawing.SystemColors.Control
        Me.CmdDisable.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdDisable.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdDisable.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdDisable.Location = New System.Drawing.Point(232, 176)
        Me.CmdDisable.Name = "CmdDisable"
        Me.CmdDisable.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdDisable.Size = New System.Drawing.Size(81, 25)
        Me.CmdDisable.TabIndex = 5
        Me.CmdDisable.Text = "---->"
        Me.CmdDisable.UseVisualStyleBackColor = False
        '
        'CmdEnable
        '
        Me.CmdEnable.BackColor = System.Drawing.SystemColors.Control
        Me.CmdEnable.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdEnable.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdEnable.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdEnable.Location = New System.Drawing.Point(232, 136)
        Me.CmdEnable.Name = "CmdEnable"
        Me.CmdEnable.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdEnable.Size = New System.Drawing.Size(81, 25)
        Me.CmdEnable.TabIndex = 4
        Me.CmdEnable.Text = "<----"
        Me.CmdEnable.UseVisualStyleBackColor = False
        '
        'LstViewDisabledLOCalls
        '
        Me.LstViewDisabledLOCalls.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewDisabledLOCalls.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewDisabledLOCalls.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewDisabledLOCalls.FullRowSelect = True
        Me.LstViewDisabledLOCalls.HideSelection = False
        Me.LstViewDisabledLOCalls.LabelWrap = False
        Me.LstViewDisabledLOCalls.Location = New System.Drawing.Point(320, 80)
        Me.LstViewDisabledLOCalls.Name = "LstViewDisabledLOCalls"
        Me.LstViewDisabledLOCalls.Size = New System.Drawing.Size(217, 217)
        Me.LstViewDisabledLOCalls.TabIndex = 1
        Me.LstViewDisabledLOCalls.UseCompatibleStateImageBehavior = False
        Me.LstViewDisabledLOCalls.View = System.Windows.Forms.View.Details
        '
        'LstViewEnabledLOCalls
        '
        Me.LstViewEnabledLOCalls.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewEnabledLOCalls.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewEnabledLOCalls.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewEnabledLOCalls.FullRowSelect = True
        Me.LstViewEnabledLOCalls.HideSelection = False
        Me.LstViewEnabledLOCalls.LabelWrap = False
        Me.LstViewEnabledLOCalls.Location = New System.Drawing.Point(8, 80)
        Me.LstViewEnabledLOCalls.Name = "LstViewEnabledLOCalls"
        Me.LstViewEnabledLOCalls.Size = New System.Drawing.Size(217, 217)
        Me.LstViewEnabledLOCalls.TabIndex = 0
        Me.LstViewEnabledLOCalls.UseCompatibleStateImageBehavior = False
        Me.LstViewEnabledLOCalls.View = System.Windows.Forms.View.Details
        '
        'Label2
        '
        Me.Label2.BackColor = System.Drawing.SystemColors.Control
        Me.Label2.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label2.Location = New System.Drawing.Point(320, 64)
        Me.Label2.Name = "Label2"
        Me.Label2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label2.Size = New System.Drawing.Size(209, 17)
        Me.Label2.TabIndex = 3
        Me.Label2.Text = "Statline Taking Calls"
        '
        'Label1
        '
        Me.Label1.BackColor = System.Drawing.SystemColors.Control
        Me.Label1.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label1.Location = New System.Drawing.Point(8, 64)
        Me.Label1.Name = "Label1"
        Me.Label1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label1.Size = New System.Drawing.Size(177, 17)
        Me.Label1.TabIndex = 2
        Me.Label1.Text = "Lease Organization Taking Calls"
        '
        'FrmLeaseOrganizationCalls
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 14.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.ClientSize = New System.Drawing.Size(552, 304)
        Me.Controls.Add(Me.CmdClose)
        Me.Controls.Add(Me.CmdDisable)
        Me.Controls.Add(Me.CmdEnable)
        Me.Controls.Add(Me.LstViewDisabledLOCalls)
        Me.Controls.Add(Me.LstViewEnabledLOCalls)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.Label1)
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Location = New System.Drawing.Point(149, 240)
        Me.MaximizeBox = False
        Me.Name = "FrmLeaseOrganizationCalls"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.StartPosition = System.Windows.Forms.FormStartPosition.Manual
        Me.Text = "Organization Call Status"
        Me.ResumeLayout(False)

    End Sub
#End Region 
End Class