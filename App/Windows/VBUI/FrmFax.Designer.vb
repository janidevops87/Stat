<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmFax
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
	Public WithEvents cmdSave As System.Windows.Forms.Button
	Public WithEvents txtFaxNumber As System.Windows.Forms.TextBox
	Public WithEvents lblFaxNumber As System.Windows.Forms.Label
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.cmdCancel = New System.Windows.Forms.Button
        Me.cmdSave = New System.Windows.Forms.Button
        Me.txtFaxNumber = New System.Windows.Forms.TextBox
        Me.lblFaxNumber = New System.Windows.Forms.Label
        Me.SuspendLayout()
        '
        'cmdCancel
        '
        Me.cmdCancel.BackColor = System.Drawing.SystemColors.Control
        Me.cmdCancel.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdCancel.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdCancel.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdCancel.Location = New System.Drawing.Point(88, 40)
        Me.cmdCancel.Name = "cmdCancel"
        Me.cmdCancel.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdCancel.Size = New System.Drawing.Size(73, 25)
        Me.cmdCancel.TabIndex = 3
        Me.cmdCancel.Text = "Cancel"
        Me.cmdCancel.UseVisualStyleBackColor = False
        '
        'cmdSave
        '
        Me.cmdSave.BackColor = System.Drawing.SystemColors.Control
        Me.cmdSave.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdSave.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdSave.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdSave.Location = New System.Drawing.Point(8, 40)
        Me.cmdSave.Name = "cmdSave"
        Me.cmdSave.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdSave.Size = New System.Drawing.Size(73, 25)
        Me.cmdSave.TabIndex = 2
        Me.cmdSave.Text = "Save"
        Me.cmdSave.UseVisualStyleBackColor = False
        '
        'txtFaxNumber
        '
        Me.txtFaxNumber.AcceptsReturn = True
        Me.txtFaxNumber.BackColor = System.Drawing.SystemColors.Window
        Me.txtFaxNumber.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtFaxNumber.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtFaxNumber.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtFaxNumber.Location = New System.Drawing.Point(80, 8)
        Me.txtFaxNumber.MaxLength = 0
        Me.txtFaxNumber.Name = "txtFaxNumber"
        Me.txtFaxNumber.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtFaxNumber.Size = New System.Drawing.Size(81, 25)
        Me.txtFaxNumber.TabIndex = 1
        '
        'lblFaxNumber
        '
        Me.lblFaxNumber.BackColor = System.Drawing.SystemColors.Control
        Me.lblFaxNumber.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblFaxNumber.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblFaxNumber.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblFaxNumber.Location = New System.Drawing.Point(8, 12)
        Me.lblFaxNumber.Name = "lblFaxNumber"
        Me.lblFaxNumber.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblFaxNumber.Size = New System.Drawing.Size(68, 17)
        Me.lblFaxNumber.TabIndex = 0
        Me.lblFaxNumber.Text = "Fax Number:"
        '
        'FrmFax
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 14.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.ClientSize = New System.Drawing.Size(170, 72)
        Me.Controls.Add(Me.cmdCancel)
        Me.Controls.Add(Me.cmdSave)
        Me.Controls.Add(Me.txtFaxNumber)
        Me.Controls.Add(Me.lblFaxNumber)
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Location = New System.Drawing.Point(4, 23)
        Me.Name = "FrmFax"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Fax"
        Me.ResumeLayout(False)

    End Sub
#End Region 
End Class