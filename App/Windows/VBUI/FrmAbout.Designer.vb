<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmAbout
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
        'bret 1/4/2010 dll conversion Me.MdiParent = AppMain.ParentForm 'StatTrac.MDIFormStatLine
        'bret 1/4/2010 dll conversion MdiParent.Show()
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
	Public WithEvents Picture1 As System.Windows.Forms.PictureBox
	Public WithEvents Command1 As System.Windows.Forms.Button
	Public WithEvents lblComment As System.Windows.Forms.Label
	Public WithEvents LblVersion As System.Windows.Forms.Label
	Public WithEvents _Label1_3 As System.Windows.Forms.Label
	Public WithEvents _Label2_1 As System.Windows.Forms.Label
	Public WithEvents LblCopyright As System.Windows.Forms.Label
	Public WithEvents _Label1_2 As System.Windows.Forms.Label
	Public WithEvents _Label1_1 As System.Windows.Forms.Label
	Public WithEvents _Label1_0 As System.Windows.Forms.Label
	Public WithEvents Label1 As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
	Public WithEvents Label2 As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FrmAbout))
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.Picture1 = New System.Windows.Forms.PictureBox()
        Me.Command1 = New System.Windows.Forms.Button()
        Me.lblComment = New System.Windows.Forms.Label()
        Me.LblVersion = New System.Windows.Forms.Label()
        Me._Label1_3 = New System.Windows.Forms.Label()
        Me._Label2_1 = New System.Windows.Forms.Label()
        Me.LblCopyright = New System.Windows.Forms.Label()
        Me._Label1_2 = New System.Windows.Forms.Label()
        Me._Label1_1 = New System.Windows.Forms.Label()
        Me._Label1_0 = New System.Windows.Forms.Label()
        Me.Label1 = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(Me.components)
        Me.Label2 = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(Me.components)
        CType(Me.Picture1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.Label1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.Label2, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'Picture1
        '
        Me.Picture1.BackColor = System.Drawing.SystemColors.Control
        Me.Picture1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.Picture1.Cursor = System.Windows.Forms.Cursors.Default
        Me.Picture1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Picture1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Picture1.Image = CType(resources.GetObject("Picture1.Image"), System.Drawing.Image)
        Me.Picture1.Location = New System.Drawing.Point(146, 10)
        Me.Picture1.Name = "Picture1"
        Me.Picture1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Picture1.Size = New System.Drawing.Size(190, 61)
        Me.Picture1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.AutoSize
        Me.Picture1.TabIndex = 6
        Me.Picture1.TabStop = False
        '
        'Command1
        '
        Me.Command1.BackColor = System.Drawing.SystemColors.Control
        Me.Command1.Cursor = System.Windows.Forms.Cursors.Default
        Me.Command1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Command1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Command1.Location = New System.Drawing.Point(12, 205)
        Me.Command1.Name = "Command1"
        Me.Command1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Command1.Size = New System.Drawing.Size(79, 23)
        Me.Command1.TabIndex = 5
        Me.Command1.Text = "&OK"
        Me.Command1.UseVisualStyleBackColor = False
        '
        'lblComment
        '
        Me.lblComment.BackColor = System.Drawing.SystemColors.Control
        Me.lblComment.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblComment.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblComment.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblComment.Location = New System.Drawing.Point(8, 184)
        Me.lblComment.Name = "lblComment"
        Me.lblComment.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblComment.Size = New System.Drawing.Size(177, 17)
        Me.lblComment.TabIndex = 9
        Me.lblComment.TextAlign = System.Drawing.ContentAlignment.TopCenter
        Me.lblComment.Visible = False
        '
        'LblVersion
        '
        Me.LblVersion.BackColor = System.Drawing.SystemColors.Control
        Me.LblVersion.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblVersion.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblVersion.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblVersion.Location = New System.Drawing.Point(54, 154)
        Me.LblVersion.Name = "LblVersion"
        Me.LblVersion.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblVersion.Size = New System.Drawing.Size(135, 15)
        Me.LblVersion.TabIndex = 8
        '
        '_Label1_3
        '
        Me._Label1_3.BackColor = System.Drawing.SystemColors.Control
        Me._Label1_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label1_3.Font = New System.Drawing.Font("Arial Narrow", 14.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label1_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label1.SetIndex(Me._Label1_3, CType(3, Short))
        Me._Label1_3.Location = New System.Drawing.Point(8, 54)
        Me._Label1_3.Name = "_Label1_3"
        Me._Label1_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label1_3.Size = New System.Drawing.Size(133, 21)
        Me._Label1_3.TabIndex = 7
        Me._Label1_3.Text = "Procurement &&"
        '
        '_Label2_1
        '
        Me._Label2_1.BackColor = System.Drawing.SystemColors.Control
        Me._Label2_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label2_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label2_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label2.SetIndex(Me._Label2_1, CType(1, Short))
        Me._Label2_1.Location = New System.Drawing.Point(8, 154)
        Me._Label2_1.Name = "_Label2_1"
        Me._Label2_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label2_1.Size = New System.Drawing.Size(47, 15)
        Me._Label2_1.TabIndex = 4
        Me._Label2_1.Text = "Version:"
        '
        'LblCopyright
        '
        Me.LblCopyright.BackColor = System.Drawing.SystemColors.Control
        Me.LblCopyright.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblCopyright.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblCopyright.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label2.SetIndex(Me.LblCopyright, CType(0, Short))
        Me.LblCopyright.Location = New System.Drawing.Point(8, 136)
        Me.LblCopyright.Name = "LblCopyright"
        Me.LblCopyright.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblCopyright.Size = New System.Drawing.Size(235, 15)
        Me.LblCopyright.TabIndex = 3
        Me.LblCopyright.Text = "COPYRIGHT"
        '
        '_Label1_2
        '
        Me._Label1_2.BackColor = System.Drawing.SystemColors.Control
        Me._Label1_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label1_2.Font = New System.Drawing.Font("Arial Narrow", 14.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label1_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label1.SetIndex(Me._Label1_2, CType(2, Short))
        Me._Label1_2.Location = New System.Drawing.Point(8, 96)
        Me._Label1_2.Name = "_Label1_2"
        Me._Label1_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label1_2.Size = New System.Drawing.Size(133, 27)
        Me._Label1_2.TabIndex = 2
        Me._Label1_2.Text = "Triage"
        '
        '_Label1_1
        '
        Me._Label1_1.BackColor = System.Drawing.SystemColors.Control
        Me._Label1_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label1_1.Font = New System.Drawing.Font("Arial Narrow", 14.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label1_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label1.SetIndex(Me._Label1_1, CType(1, Short))
        Me._Label1_1.Location = New System.Drawing.Point(8, 74)
        Me._Label1_1.Name = "_Label1_1"
        Me._Label1_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label1_1.Size = New System.Drawing.Size(133, 23)
        Me._Label1_1.TabIndex = 1
        Me._Label1_1.Text = "Transplant"
        '
        '_Label1_0
        '
        Me._Label1_0.BackColor = System.Drawing.SystemColors.Control
        Me._Label1_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label1_0.Font = New System.Drawing.Font("Arial", 14.25!, CType((System.Drawing.FontStyle.Bold Or System.Drawing.FontStyle.Italic), System.Drawing.FontStyle), System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label1_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label1.SetIndex(Me._Label1_0, CType(0, Short))
        Me._Label1_0.Location = New System.Drawing.Point(8, 18)
        Me._Label1_0.Name = "_Label1_0"
        Me._Label1_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label1_0.Size = New System.Drawing.Size(133, 21)
        Me._Label1_0.TabIndex = 0
        Me._Label1_0.Text = "StatTrac:"
        '
        'FrmAbout
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 14.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.ClientSize = New System.Drawing.Size(339, 240)
        Me.Controls.Add(Me.Picture1)
        Me.Controls.Add(Me.Command1)
        Me.Controls.Add(Me.lblComment)
        Me.Controls.Add(Me.LblVersion)
        Me.Controls.Add(Me._Label1_3)
        Me.Controls.Add(Me._Label2_1)
        Me.Controls.Add(Me.LblCopyright)
        Me.Controls.Add(Me._Label1_2)
        Me.Controls.Add(Me._Label1_1)
        Me.Controls.Add(Me._Label1_0)
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Location = New System.Drawing.Point(297, 333)
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "FrmAbout"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent
        Me.Text = "About "
        CType(Me.Picture1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.Label1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.Label2, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
#End Region
End Class