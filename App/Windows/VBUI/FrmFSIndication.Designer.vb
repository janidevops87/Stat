<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmFSIndication
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
	Public WithEvents txtIndication As System.Windows.Forms.TextBox
	Public WithEvents cmdOK As System.Windows.Forms.Button
	Public WithEvents cmdCancel As System.Windows.Forms.Button
	Public WithEvents Label2 As System.Windows.Forms.Label
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.txtIndication = New System.Windows.Forms.TextBox
        Me.cmdOK = New System.Windows.Forms.Button
        Me.cmdCancel = New System.Windows.Forms.Button
        Me.Label2 = New System.Windows.Forms.Label
        Me.SuspendLayout()
        '
        'txtIndication
        '
        Me.txtIndication.AcceptsReturn = True
        Me.txtIndication.BackColor = System.Drawing.SystemColors.Window
        Me.txtIndication.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtIndication.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtIndication.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtIndication.Location = New System.Drawing.Point(56, 8)
        Me.txtIndication.MaxLength = 0
        Me.txtIndication.Name = "txtIndication"
        Me.txtIndication.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtIndication.ScrollBars = System.Windows.Forms.ScrollBars.Vertical
        Me.txtIndication.Size = New System.Drawing.Size(321, 21)
        Me.txtIndication.TabIndex = 2
        '
        'cmdOK
        '
        Me.cmdOK.BackColor = System.Drawing.SystemColors.Control
        Me.cmdOK.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdOK.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdOK.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdOK.Location = New System.Drawing.Point(56, 40)
        Me.cmdOK.Name = "cmdOK"
        Me.cmdOK.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdOK.Size = New System.Drawing.Size(81, 25)
        Me.cmdOK.TabIndex = 1
        Me.cmdOK.Text = "Save"
        Me.cmdOK.UseVisualStyleBackColor = False
        '
        'cmdCancel
        '
        Me.cmdCancel.BackColor = System.Drawing.SystemColors.Control
        Me.cmdCancel.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdCancel.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdCancel.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdCancel.Location = New System.Drawing.Point(296, 40)
        Me.cmdCancel.Name = "cmdCancel"
        Me.cmdCancel.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdCancel.Size = New System.Drawing.Size(81, 25)
        Me.cmdCancel.TabIndex = 0
        Me.cmdCancel.Text = "Cancel"
        Me.cmdCancel.UseVisualStyleBackColor = False
        '
        'Label2
        '
        Me.Label2.BackColor = System.Drawing.SystemColors.Control
        Me.Label2.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label2.ImageAlign = System.Drawing.ContentAlignment.MiddleRight
        Me.Label2.Location = New System.Drawing.Point(8, 10)
        Me.Label2.Name = "Label2"
        Me.Label2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label2.Size = New System.Drawing.Size(52, 17)
        Me.Label2.TabIndex = 3
        Me.Label2.Text = "Indication"
        '
        'FrmFSIndication
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 14.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.ClientSize = New System.Drawing.Size(384, 71)
        Me.Controls.Add(Me.txtIndication)
        Me.Controls.Add(Me.cmdOK)
        Me.Controls.Add(Me.cmdCancel)
        Me.Controls.Add(Me.Label2)
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.Location = New System.Drawing.Point(3, 22)
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "FrmFSIndication"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent
        Me.Text = "Indication"
        Me.ResumeLayout(False)

    End Sub
#End Region 
End Class