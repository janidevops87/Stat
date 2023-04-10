<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmSubtype
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
	Public WithEvents cmdCancel As System.Windows.Forms.Button
	Public WithEvents cmdOK As System.Windows.Forms.Button
	Public WithEvents txtSubtypeDescription As System.Windows.Forms.TextBox
	Public WithEvents txtSubtypeName As System.Windows.Forms.TextBox
	Public WithEvents Label2 As System.Windows.Forms.Label
	Public WithEvents Label1 As System.Windows.Forms.Label
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.cmdCancel = New System.Windows.Forms.Button
        Me.cmdOK = New System.Windows.Forms.Button
        Me.txtSubtypeDescription = New System.Windows.Forms.TextBox
        Me.txtSubtypeName = New System.Windows.Forms.TextBox
        Me.Label2 = New System.Windows.Forms.Label
        Me.Label1 = New System.Windows.Forms.Label
        Me.SuspendLayout()
        '
        'cmdCancel
        '
        Me.cmdCancel.BackColor = System.Drawing.SystemColors.Control
        Me.cmdCancel.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdCancel.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdCancel.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdCancel.Location = New System.Drawing.Point(320, 104)
        Me.cmdCancel.Name = "cmdCancel"
        Me.cmdCancel.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdCancel.Size = New System.Drawing.Size(81, 25)
        Me.cmdCancel.TabIndex = 5
        Me.cmdCancel.Text = "Cancel"
        Me.cmdCancel.UseVisualStyleBackColor = False
        '
        'cmdOK
        '
        Me.cmdOK.BackColor = System.Drawing.SystemColors.Control
        Me.cmdOK.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdOK.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdOK.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdOK.Location = New System.Drawing.Point(320, 8)
        Me.cmdOK.Name = "cmdOK"
        Me.cmdOK.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdOK.Size = New System.Drawing.Size(81, 25)
        Me.cmdOK.TabIndex = 4
        Me.cmdOK.Text = "Save"
        Me.cmdOK.UseVisualStyleBackColor = False
        '
        'txtSubtypeDescription
        '
        Me.txtSubtypeDescription.AcceptsReturn = True
        Me.txtSubtypeDescription.BackColor = System.Drawing.SystemColors.Window
        Me.txtSubtypeDescription.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtSubtypeDescription.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtSubtypeDescription.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtSubtypeDescription.Location = New System.Drawing.Point(120, 40)
        Me.txtSubtypeDescription.MaxLength = 0
        Me.txtSubtypeDescription.Multiline = True
        Me.txtSubtypeDescription.Name = "txtSubtypeDescription"
        Me.txtSubtypeDescription.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtSubtypeDescription.ScrollBars = System.Windows.Forms.ScrollBars.Vertical
        Me.txtSubtypeDescription.Size = New System.Drawing.Size(193, 89)
        Me.txtSubtypeDescription.TabIndex = 3
        '
        'txtSubtypeName
        '
        Me.txtSubtypeName.AcceptsReturn = True
        Me.txtSubtypeName.BackColor = System.Drawing.SystemColors.Window
        Me.txtSubtypeName.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtSubtypeName.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtSubtypeName.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtSubtypeName.Location = New System.Drawing.Point(120, 8)
        Me.txtSubtypeName.MaxLength = 0
        Me.txtSubtypeName.Name = "txtSubtypeName"
        Me.txtSubtypeName.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtSubtypeName.Size = New System.Drawing.Size(193, 20)
        Me.txtSubtypeName.TabIndex = 2
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.BackColor = System.Drawing.SystemColors.Control
        Me.Label2.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label2.Location = New System.Drawing.Point(5, 40)
        Me.Label2.Name = "Label2"
        Me.Label2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label2.Size = New System.Drawing.Size(107, 14)
        Me.Label2.TabIndex = 1
        Me.Label2.Text = "SubType Description"
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.BackColor = System.Drawing.SystemColors.Control
        Me.Label1.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label1.Location = New System.Drawing.Point(32, 10)
        Me.Label1.Name = "Label1"
        Me.Label1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label1.Size = New System.Drawing.Size(80, 14)
        Me.Label1.TabIndex = 0
        Me.Label1.Text = "SubType Name"
        '
        'FrmSubtype
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 14.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.ClientSize = New System.Drawing.Size(407, 135)
        Me.Controls.Add(Me.cmdCancel)
        Me.Controls.Add(Me.cmdOK)
        Me.Controls.Add(Me.txtSubtypeDescription)
        Me.Controls.Add(Me.txtSubtypeName)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.Label1)
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Location = New System.Drawing.Point(4, 23)
        Me.Name = "FrmSubtype"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.SizeGripStyle = System.Windows.Forms.SizeGripStyle.Hide
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent
        Me.Text = "Create SubType"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
#End Region 
End Class