<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmVerifySex
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
	Public WithEvents cmdTest As System.Windows.Forms.Button
	Public WithEvents CboGender As System.Windows.Forms.ComboBox
	Public WithEvents cmdOK As System.Windows.Forms.Button
	Public WithEvents Label2 As System.Windows.Forms.Label
	Public WithEvents Label1 As System.Windows.Forms.Label
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.cmdTest = New System.Windows.Forms.Button
        Me.CboGender = New System.Windows.Forms.ComboBox
        Me.cmdOK = New System.Windows.Forms.Button
        Me.Label2 = New System.Windows.Forms.Label
        Me.Label1 = New System.Windows.Forms.Label
        Me.SuspendLayout()
        '
        'cmdTest
        '
        Me.cmdTest.BackColor = System.Drawing.SystemColors.Control
        Me.cmdTest.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdTest.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdTest.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdTest.Location = New System.Drawing.Point(16, 152)
        Me.cmdTest.Name = "cmdTest"
        Me.cmdTest.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdTest.Size = New System.Drawing.Size(57, 25)
        Me.cmdTest.TabIndex = 4
        Me.cmdTest.Text = "test"
        Me.cmdTest.UseVisualStyleBackColor = False
        Me.cmdTest.Visible = False
        '
        'CboGender
        '
        Me.CboGender.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboGender.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboGender.BackColor = System.Drawing.SystemColors.Window
        Me.CboGender.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboGender.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboGender.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboGender.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboGender.Items.AddRange(New Object() {"F", "M"})
        Me.CboGender.Location = New System.Drawing.Point(120, 112)
        Me.CboGender.Name = "CboGender"
        Me.CboGender.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboGender.Size = New System.Drawing.Size(37, 22)
        Me.CboGender.Sorted = True
        Me.CboGender.TabIndex = 3
        '
        'cmdOK
        '
        Me.cmdOK.BackColor = System.Drawing.SystemColors.Control
        Me.cmdOK.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdOK.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdOK.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdOK.Location = New System.Drawing.Point(216, 152)
        Me.cmdOK.Name = "cmdOK"
        Me.cmdOK.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdOK.Size = New System.Drawing.Size(65, 25)
        Me.cmdOK.TabIndex = 1
        Me.cmdOK.Text = "Save"
        Me.cmdOK.UseVisualStyleBackColor = False
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.BackColor = System.Drawing.SystemColors.Control
        Me.Label2.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label2.Location = New System.Drawing.Point(88, 115)
        Me.Label2.Name = "Label2"
        Me.Label2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label2.Size = New System.Drawing.Size(26, 14)
        Me.Label2.TabIndex = 2
        Me.Label2.Text = "Sex"
        '
        'Label1
        '
        Me.Label1.BackColor = System.Drawing.SystemColors.Control
        Me.Label1.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label1.Location = New System.Drawing.Point(40, 32)
        Me.Label1.Name = "Label1"
        Me.Label1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label1.Size = New System.Drawing.Size(233, 41)
        Me.Label1.TabIndex = 0
        Me.Label1.Text = "Information entered has ruled out this referral. Please re-enter the following da" & _
            "ta."
        '
        'FrmVerifySex
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 14.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.ClientSize = New System.Drawing.Size(312, 206)
        Me.Controls.Add(Me.cmdTest)
        Me.Controls.Add(Me.CboGender)
        Me.Controls.Add(Me.cmdOK)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.Label1)
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Location = New System.Drawing.Point(4, 30)
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "FrmVerifySex"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Verify Sex"
        Me.ResumeLayout(False)
        Me.PerformLayout()

End Sub
#End Region 
End Class