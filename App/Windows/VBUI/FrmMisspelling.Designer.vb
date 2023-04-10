<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmMisspelling
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
	Public WithEvents TxtName As System.Windows.Forms.TextBox
	Public WithEvents _LblOrganization_0 As System.Windows.Forms.Label
	Public WithEvents FraOrgInfo As System.Windows.Forms.GroupBox
	Public WithEvents CmdCancel As System.Windows.Forms.Button
	Public WithEvents CmdOK As System.Windows.Forms.Button
	Public WithEvents LblOrganization As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FrmMisspelling))
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.FraOrgInfo = New System.Windows.Forms.GroupBox
        Me.TxtName = New System.Windows.Forms.TextBox
        Me._LblOrganization_0 = New System.Windows.Forms.Label
        Me.CmdCancel = New System.Windows.Forms.Button
        Me.CmdOK = New System.Windows.Forms.Button
        Me.LblOrganization = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(Me.components)
        Me.FraOrgInfo.SuspendLayout()
        CType(Me.LblOrganization, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'FraOrgInfo
        '
        Me.FraOrgInfo.BackColor = System.Drawing.SystemColors.Control
        Me.FraOrgInfo.Controls.Add(Me.TxtName)
        Me.FraOrgInfo.Controls.Add(Me._LblOrganization_0)
        Me.FraOrgInfo.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FraOrgInfo.ForeColor = System.Drawing.SystemColors.ControlText
        Me.FraOrgInfo.Location = New System.Drawing.Point(2, 0)
        Me.FraOrgInfo.Name = "FraOrgInfo"
        Me.FraOrgInfo.Padding = New System.Windows.Forms.Padding(0)
        Me.FraOrgInfo.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.FraOrgInfo.Size = New System.Drawing.Size(291, 54)
        Me.FraOrgInfo.TabIndex = 3
        Me.FraOrgInfo.TabStop = False
        '
        'TxtName
        '
        Me.TxtName.AcceptsReturn = True
        Me.TxtName.BackColor = System.Drawing.SystemColors.Window
        Me.TxtName.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtName.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtName.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtName.Location = New System.Drawing.Point(54, 20)
        Me.TxtName.MaxLength = 0
        Me.TxtName.Name = "TxtName"
        Me.TxtName.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtName.Size = New System.Drawing.Size(223, 21)
        Me.TxtName.TabIndex = 0
        '
        '_LblOrganization_0
        '
        Me._LblOrganization_0.AutoSize = True
        Me._LblOrganization_0.BackColor = System.Drawing.SystemColors.Control
        Me._LblOrganization_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblOrganization_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LblOrganization_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblOrganization.SetIndex(Me._LblOrganization_0, CType(0, Short))
        Me._LblOrganization_0.Location = New System.Drawing.Point(16, 24)
        Me._LblOrganization_0.Name = "_LblOrganization_0"
        Me._LblOrganization_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblOrganization_0.Size = New System.Drawing.Size(34, 14)
        Me._LblOrganization_0.TabIndex = 4
        Me._LblOrganization_0.Text = "Name"
        '
        'CmdCancel
        '
        Me.CmdCancel.BackColor = System.Drawing.SystemColors.Control
        Me.CmdCancel.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdCancel.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdCancel.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdCancel.Location = New System.Drawing.Point(298, 31)
        Me.CmdCancel.Name = "CmdCancel"
        Me.CmdCancel.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdCancel.Size = New System.Drawing.Size(80, 21)
        Me.CmdCancel.TabIndex = 2
        Me.CmdCancel.Text = "C&ancel"
        Me.CmdCancel.UseVisualStyleBackColor = False
        '
        'CmdOK
        '
        Me.CmdOK.BackColor = System.Drawing.SystemColors.Control
        Me.CmdOK.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdOK.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdOK.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdOK.Location = New System.Drawing.Point(298, 5)
        Me.CmdOK.Name = "CmdOK"
        Me.CmdOK.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdOK.Size = New System.Drawing.Size(80, 21)
        Me.CmdOK.TabIndex = 1
        Me.CmdOK.Text = "&Save"
        Me.CmdOK.UseVisualStyleBackColor = False
        '
        'FrmMisspelling
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 14.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.ClientSize = New System.Drawing.Size(383, 58)
        Me.Controls.Add(Me.FraOrgInfo)
        Me.Controls.Add(Me.CmdCancel)
        Me.Controls.Add(Me.CmdOK)
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Location = New System.Drawing.Point(222, 133)
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "FrmMisspelling"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.StartPosition = System.Windows.Forms.FormStartPosition.Manual
        Me.Text = "Misspelling"
        Me.FraOrgInfo.ResumeLayout(False)
        Me.FraOrgInfo.PerformLayout()
        CType(Me.LblOrganization, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)

    End Sub
#End Region 
End Class