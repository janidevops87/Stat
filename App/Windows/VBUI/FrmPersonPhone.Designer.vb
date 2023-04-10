<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmPersonPhone
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
	Public WithEvents TxtAlpha As System.Windows.Forms.TextBox
	Public WithEvents TxtPIN As System.Windows.Forms.TextBox
	Public WithEvents TxtPhone As System.Windows.Forms.TextBox
	Public WithEvents CboPhoneType As System.Windows.Forms.ComboBox
	Public WithEvents LblAlpha As System.Windows.Forms.Label
	Public WithEvents _LblOrganization_1 As System.Windows.Forms.Label
	Public WithEvents _LblOrganization_7 As System.Windows.Forms.Label
	Public WithEvents _LblOrganization_0 As System.Windows.Forms.Label
	Public WithEvents FraInformation As System.Windows.Forms.GroupBox
	Public WithEvents LblOrganization As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FrmPersonPhone))
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.CmdOK = New System.Windows.Forms.Button
        Me.CmdCancel = New System.Windows.Forms.Button
        Me.FraInformation = New System.Windows.Forms.GroupBox
        Me.TxtAlpha = New System.Windows.Forms.TextBox
        Me.TxtPIN = New System.Windows.Forms.TextBox
        Me.TxtPhone = New System.Windows.Forms.TextBox
        Me.CboPhoneType = New System.Windows.Forms.ComboBox
        Me.LblAlpha = New System.Windows.Forms.Label
        Me._LblOrganization_1 = New System.Windows.Forms.Label
        Me._LblOrganization_7 = New System.Windows.Forms.Label
        Me._LblOrganization_0 = New System.Windows.Forms.Label
        Me.LblOrganization = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(Me.components)
        Me.FraInformation.SuspendLayout()
        CType(Me.LblOrganization, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'CmdOK
        '
        Me.CmdOK.BackColor = System.Drawing.SystemColors.Control
        Me.CmdOK.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdOK.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdOK.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdOK.Location = New System.Drawing.Point(344, 6)
        Me.CmdOK.Name = "CmdOK"
        Me.CmdOK.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdOK.Size = New System.Drawing.Size(80, 21)
        Me.CmdOK.TabIndex = 7
        Me.CmdOK.Text = "&Save"
        Me.CmdOK.UseVisualStyleBackColor = False
        '
        'CmdCancel
        '
        Me.CmdCancel.BackColor = System.Drawing.SystemColors.Control
        Me.CmdCancel.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdCancel.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdCancel.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdCancel.Location = New System.Drawing.Point(344, 86)
        Me.CmdCancel.Name = "CmdCancel"
        Me.CmdCancel.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdCancel.Size = New System.Drawing.Size(80, 21)
        Me.CmdCancel.TabIndex = 8
        Me.CmdCancel.Text = "C&ancel"
        Me.CmdCancel.UseVisualStyleBackColor = False
        '
        'FraInformation
        '
        Me.FraInformation.BackColor = System.Drawing.SystemColors.Control
        Me.FraInformation.Controls.Add(Me.TxtAlpha)
        Me.FraInformation.Controls.Add(Me.TxtPIN)
        Me.FraInformation.Controls.Add(Me.TxtPhone)
        Me.FraInformation.Controls.Add(Me.CboPhoneType)
        Me.FraInformation.Controls.Add(Me.LblAlpha)
        Me.FraInformation.Controls.Add(Me._LblOrganization_1)
        Me.FraInformation.Controls.Add(Me._LblOrganization_7)
        Me.FraInformation.Controls.Add(Me._LblOrganization_0)
        Me.FraInformation.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FraInformation.ForeColor = System.Drawing.SystemColors.ControlText
        Me.FraInformation.Location = New System.Drawing.Point(2, 0)
        Me.FraInformation.Name = "FraInformation"
        Me.FraInformation.Padding = New System.Windows.Forms.Padding(0)
        Me.FraInformation.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.FraInformation.Size = New System.Drawing.Size(337, 107)
        Me.FraInformation.TabIndex = 6
        Me.FraInformation.TabStop = False
        '
        'TxtAlpha
        '
        Me.TxtAlpha.AcceptsReturn = True
        Me.TxtAlpha.BackColor = System.Drawing.SystemColors.Window
        Me.TxtAlpha.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtAlpha.Enabled = False
        Me.TxtAlpha.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtAlpha.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtAlpha.Location = New System.Drawing.Point(80, 76)
        Me.TxtAlpha.MaxLength = 0
        Me.TxtAlpha.Name = "TxtAlpha"
        Me.TxtAlpha.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtAlpha.Size = New System.Drawing.Size(249, 20)
        Me.TxtAlpha.TabIndex = 3
        '
        'TxtPIN
        '
        Me.TxtPIN.AcceptsReturn = True
        Me.TxtPIN.BackColor = System.Drawing.SystemColors.Window
        Me.TxtPIN.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtPIN.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtPIN.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtPIN.Location = New System.Drawing.Point(80, 48)
        Me.TxtPIN.MaxLength = 0
        Me.TxtPIN.Name = "TxtPIN"
        Me.TxtPIN.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtPIN.Size = New System.Drawing.Size(119, 20)
        Me.TxtPIN.TabIndex = 2
        '
        'TxtPhone
        '
        Me.TxtPhone.AcceptsReturn = True
        Me.TxtPhone.BackColor = System.Drawing.SystemColors.Window
        Me.TxtPhone.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtPhone.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtPhone.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtPhone.Location = New System.Drawing.Point(80, 20)
        Me.TxtPhone.MaxLength = 0
        Me.TxtPhone.Name = "TxtPhone"
        Me.TxtPhone.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtPhone.Size = New System.Drawing.Size(119, 20)
        Me.TxtPhone.TabIndex = 0
        '
        'CboPhoneType
        '
        Me.CboPhoneType.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboPhoneType.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboPhoneType.BackColor = System.Drawing.SystemColors.Window
        Me.CboPhoneType.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboPhoneType.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboPhoneType.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboPhoneType.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboPhoneType.Location = New System.Drawing.Point(232, 20)
        Me.CboPhoneType.Name = "CboPhoneType"
        Me.CboPhoneType.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboPhoneType.Size = New System.Drawing.Size(98, 22)
        Me.CboPhoneType.TabIndex = 1
        '
        'LblAlpha
        '
        Me.LblAlpha.BackColor = System.Drawing.SystemColors.Control
        Me.LblAlpha.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblAlpha.Enabled = False
        Me.LblAlpha.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblAlpha.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblAlpha.Location = New System.Drawing.Point(3, 72)
        Me.LblAlpha.Name = "LblAlpha"
        Me.LblAlpha.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblAlpha.Size = New System.Drawing.Size(76, 33)
        Me.LblAlpha.TabIndex = 10
        Me.LblAlpha.Text = "Alpha Pager Email Address"
        '
        '_LblOrganization_1
        '
        Me._LblOrganization_1.AutoSize = True
        Me._LblOrganization_1.BackColor = System.Drawing.SystemColors.Control
        Me._LblOrganization_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblOrganization_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LblOrganization_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblOrganization.SetIndex(Me._LblOrganization_1, CType(1, Short))
        Me._LblOrganization_1.Location = New System.Drawing.Point(43, 51)
        Me._LblOrganization_1.Name = "_LblOrganization_1"
        Me._LblOrganization_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblOrganization_1.Size = New System.Drawing.Size(31, 14)
        Me._LblOrganization_1.TabIndex = 9
        Me._LblOrganization_1.Text = "PIN #"
        '
        '_LblOrganization_7
        '
        Me._LblOrganization_7.BackColor = System.Drawing.SystemColors.Control
        Me._LblOrganization_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblOrganization_7.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LblOrganization_7.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblOrganization.SetIndex(Me._LblOrganization_7, CType(7, Short))
        Me._LblOrganization_7.Location = New System.Drawing.Point(202, 24)
        Me._LblOrganization_7.Name = "_LblOrganization_7"
        Me._LblOrganization_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblOrganization_7.Size = New System.Drawing.Size(35, 15)
        Me._LblOrganization_7.TabIndex = 8
        Me._LblOrganization_7.Text = "Type"
        '
        '_LblOrganization_0
        '
        Me._LblOrganization_0.AutoSize = True
        Me._LblOrganization_0.BackColor = System.Drawing.SystemColors.Control
        Me._LblOrganization_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblOrganization_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LblOrganization_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblOrganization.SetIndex(Me._LblOrganization_0, CType(0, Short))
        Me._LblOrganization_0.Location = New System.Drawing.Point(28, 24)
        Me._LblOrganization_0.Name = "_LblOrganization_0"
        Me._LblOrganization_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblOrganization_0.Size = New System.Drawing.Size(46, 14)
        Me._LblOrganization_0.TabIndex = 7
        Me._LblOrganization_0.Text = "Phone #"
        '
        'FrmPersonPhone
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 14.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.ClientSize = New System.Drawing.Size(428, 112)
        Me.Controls.Add(Me.CmdOK)
        Me.Controls.Add(Me.CmdCancel)
        Me.Controls.Add(Me.FraInformation)
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Location = New System.Drawing.Point(226, 185)
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "FrmPersonPhone"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Person Phone"
        Me.FraInformation.ResumeLayout(False)
        Me.FraInformation.PerformLayout()
        CType(Me.LblOrganization, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)

    End Sub
#End Region 
End Class