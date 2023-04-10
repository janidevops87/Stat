<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmSystemAlert
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
        'bret 1/4/2010 dll conversion Me.MdiParent = New StatTrac.MDIFormStatLine
        'bret 1/4/2010 dll conversion MdiParent.Show()
        'StatTrac.MDIFormStatLine.Show()
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
	Public WithEvents CmdUnresolved As System.Windows.Forms.Button
	Public WithEvents _OptState_2 As System.Windows.Forms.RadioButton
	Public WithEvents _OptState_1 As System.Windows.Forms.RadioButton
	Public WithEvents _OptState_0 As System.Windows.Forms.RadioButton
	Public WithEvents CmdDelete As System.Windows.Forms.Button
	Public WithEvents CmdResolve As System.Windows.Forms.Button
	Public WithEvents CmdCancel As System.Windows.Forms.Button
	Public WithEvents TxtAlertMessage As System.Windows.Forms.TextBox
	Public WithEvents LstViewAlerts As System.Windows.Forms.ListView
	Public WithEvents _Frame_0 As System.Windows.Forms.GroupBox
	Public WithEvents Frame As Microsoft.VisualBasic.Compatibility.VB6.GroupBoxArray
	Public WithEvents OptState As Microsoft.VisualBasic.Compatibility.VB6.RadioButtonArray
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FrmSystemAlert))
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.CmdUnresolved = New System.Windows.Forms.Button
        Me._OptState_2 = New System.Windows.Forms.RadioButton
        Me._OptState_1 = New System.Windows.Forms.RadioButton
        Me._OptState_0 = New System.Windows.Forms.RadioButton
        Me.CmdDelete = New System.Windows.Forms.Button
        Me.CmdResolve = New System.Windows.Forms.Button
        Me.CmdCancel = New System.Windows.Forms.Button
        Me._Frame_0 = New System.Windows.Forms.GroupBox
        Me.TxtAlertMessage = New System.Windows.Forms.TextBox
        Me.LstViewAlerts = New System.Windows.Forms.ListView
        Me.Frame = New Microsoft.VisualBasic.Compatibility.VB6.GroupBoxArray(Me.components)
        Me.OptState = New Microsoft.VisualBasic.Compatibility.VB6.RadioButtonArray(Me.components)
        Me._Frame_0.SuspendLayout()
        CType(Me.Frame, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.OptState, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'CmdUnresolved
        '
        Me.CmdUnresolved.BackColor = System.Drawing.SystemColors.Control
        Me.CmdUnresolved.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdUnresolved.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdUnresolved.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdUnresolved.Location = New System.Drawing.Point(472, 30)
        Me.CmdUnresolved.Name = "CmdUnresolved"
        Me.CmdUnresolved.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdUnresolved.Size = New System.Drawing.Size(80, 21)
        Me.CmdUnresolved.TabIndex = 9
        Me.CmdUnresolved.Text = "&Unresolved"
        Me.CmdUnresolved.UseVisualStyleBackColor = False
        '
        '_OptState_2
        '
        Me._OptState_2.BackColor = System.Drawing.SystemColors.Control
        Me._OptState_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._OptState_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._OptState_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.OptState.SetIndex(Me._OptState_2, CType(2, Short))
        Me._OptState_2.Location = New System.Drawing.Point(471, 80)
        Me._OptState_2.Name = "_OptState_2"
        Me._OptState_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._OptState_2.Size = New System.Drawing.Size(80, 21)
        Me._OptState_2.TabIndex = 8
        Me._OptState_2.TabStop = True
        Me._OptState_2.Text = "Resolved"
        Me._OptState_2.UseVisualStyleBackColor = False
        '
        '_OptState_1
        '
        Me._OptState_1.BackColor = System.Drawing.SystemColors.Control
        Me._OptState_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._OptState_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._OptState_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.OptState.SetIndex(Me._OptState_1, CType(1, Short))
        Me._OptState_1.Location = New System.Drawing.Point(471, 58)
        Me._OptState_1.Name = "_OptState_1"
        Me._OptState_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._OptState_1.Size = New System.Drawing.Size(80, 21)
        Me._OptState_1.TabIndex = 7
        Me._OptState_1.TabStop = True
        Me._OptState_1.Text = "Unresolved"
        Me._OptState_1.UseVisualStyleBackColor = False
        '
        '_OptState_0
        '
        Me._OptState_0.BackColor = System.Drawing.SystemColors.Control
        Me._OptState_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._OptState_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._OptState_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.OptState.SetIndex(Me._OptState_0, CType(0, Short))
        Me._OptState_0.Location = New System.Drawing.Point(471, 102)
        Me._OptState_0.Name = "_OptState_0"
        Me._OptState_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._OptState_0.Size = New System.Drawing.Size(80, 21)
        Me._OptState_0.TabIndex = 6
        Me._OptState_0.TabStop = True
        Me._OptState_0.Text = "All Alerts"
        Me._OptState_0.UseVisualStyleBackColor = False
        '
        'CmdDelete
        '
        Me.CmdDelete.BackColor = System.Drawing.SystemColors.Control
        Me.CmdDelete.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdDelete.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdDelete.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdDelete.Location = New System.Drawing.Point(472, 128)
        Me.CmdDelete.Name = "CmdDelete"
        Me.CmdDelete.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdDelete.Size = New System.Drawing.Size(80, 21)
        Me.CmdDelete.TabIndex = 5
        Me.CmdDelete.Text = "&Delete"
        Me.CmdDelete.UseVisualStyleBackColor = False
        '
        'CmdResolve
        '
        Me.CmdResolve.BackColor = System.Drawing.SystemColors.Control
        Me.CmdResolve.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdResolve.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdResolve.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdResolve.Location = New System.Drawing.Point(472, 6)
        Me.CmdResolve.Name = "CmdResolve"
        Me.CmdResolve.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdResolve.Size = New System.Drawing.Size(80, 21)
        Me.CmdResolve.TabIndex = 4
        Me.CmdResolve.Text = "&Resolved"
        Me.CmdResolve.UseVisualStyleBackColor = False
        '
        'CmdCancel
        '
        Me.CmdCancel.BackColor = System.Drawing.SystemColors.Control
        Me.CmdCancel.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdCancel.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdCancel.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdCancel.Location = New System.Drawing.Point(472, 278)
        Me.CmdCancel.Name = "CmdCancel"
        Me.CmdCancel.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdCancel.Size = New System.Drawing.Size(80, 21)
        Me.CmdCancel.TabIndex = 1
        Me.CmdCancel.Text = "&Close"
        Me.CmdCancel.UseVisualStyleBackColor = False
        '
        '_Frame_0
        '
        Me._Frame_0.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_0.Controls.Add(Me.TxtAlertMessage)
        Me._Frame_0.Controls.Add(Me.LstViewAlerts)
        Me._Frame_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_0, CType(0, Short))
        Me._Frame_0.Location = New System.Drawing.Point(2, 0)
        Me._Frame_0.Name = "_Frame_0"
        Me._Frame_0.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_0.Size = New System.Drawing.Size(465, 299)
        Me._Frame_0.TabIndex = 0
        Me._Frame_0.TabStop = False
        '
        'TxtAlertMessage
        '
        Me.TxtAlertMessage.AcceptsReturn = True
        Me.TxtAlertMessage.BackColor = System.Drawing.SystemColors.Window
        Me.TxtAlertMessage.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtAlertMessage.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtAlertMessage.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtAlertMessage.Location = New System.Drawing.Point(6, 12)
        Me.TxtAlertMessage.MaxLength = 0
        Me.TxtAlertMessage.Multiline = True
        Me.TxtAlertMessage.Name = "TxtAlertMessage"
        Me.TxtAlertMessage.ReadOnly = True
        Me.TxtAlertMessage.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtAlertMessage.Size = New System.Drawing.Size(453, 57)
        Me.TxtAlertMessage.TabIndex = 3
        Me.TxtAlertMessage.TabStop = False
        '
        'LstViewAlerts
        '
        Me.LstViewAlerts.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewAlerts.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.LstViewAlerts.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewAlerts.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewAlerts.FullRowSelect = True
        Me.LstViewAlerts.HideSelection = False
        Me.LstViewAlerts.LabelWrap = False
        Me.LstViewAlerts.Location = New System.Drawing.Point(6, 72)
        Me.LstViewAlerts.Name = "LstViewAlerts"
        Me.LstViewAlerts.Size = New System.Drawing.Size(453, 221)
        Me.LstViewAlerts.TabIndex = 2
        Me.LstViewAlerts.TabStop = False
        Me.LstViewAlerts.UseCompatibleStateImageBehavior = False
        Me.LstViewAlerts.View = System.Windows.Forms.View.Details
        '
        'OptState
        '
        '
        'FrmSystemAlert
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 14.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.ClientSize = New System.Drawing.Size(555, 304)
        Me.Controls.Add(Me.CmdUnresolved)
        Me.Controls.Add(Me._OptState_2)
        Me.Controls.Add(Me._OptState_1)
        Me.Controls.Add(Me._OptState_0)
        Me.Controls.Add(Me.CmdDelete)
        Me.Controls.Add(Me.CmdResolve)
        Me.Controls.Add(Me.CmdCancel)
        Me.Controls.Add(Me._Frame_0)
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Location = New System.Drawing.Point(130, 152)
        Me.MaximizeBox = False
        Me.Name = "FrmSystemAlert"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.StartPosition = System.Windows.Forms.FormStartPosition.WindowsDefaultBounds
        Me.Text = "System Alerts"
        Me._Frame_0.ResumeLayout(False)
        Me._Frame_0.PerformLayout()
        CType(Me.Frame, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.OptState, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)

    End Sub
#End Region 
End Class