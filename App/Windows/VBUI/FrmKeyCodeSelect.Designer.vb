<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmKeyCodeSelect
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
	Public WithEvents CmdRemove As System.Windows.Forms.Button
	Public WithEvents CmdEdit As System.Windows.Forms.Button
	Public WithEvents CmdAdd As System.Windows.Forms.Button
	Public WithEvents CmdCancel As System.Windows.Forms.Button
	Public WithEvents LstViewKeyCode As System.Windows.Forms.ListView
	Public WithEvents Frame As System.Windows.Forms.GroupBox
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FrmKeyCodeSelect))
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.CmdRemove = New System.Windows.Forms.Button
        Me.CmdEdit = New System.Windows.Forms.Button
        Me.CmdAdd = New System.Windows.Forms.Button
        Me.CmdCancel = New System.Windows.Forms.Button
        Me.Frame = New System.Windows.Forms.GroupBox
        Me.LstViewKeyCode = New System.Windows.Forms.ListView
        Me.Frame.SuspendLayout()
        Me.SuspendLayout()
        '
        'CmdRemove
        '
        Me.CmdRemove.BackColor = System.Drawing.SystemColors.Control
        Me.CmdRemove.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdRemove.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdRemove.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdRemove.Location = New System.Drawing.Point(308, 58)
        Me.CmdRemove.Name = "CmdRemove"
        Me.CmdRemove.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdRemove.Size = New System.Drawing.Size(80, 21)
        Me.CmdRemove.TabIndex = 5
        Me.CmdRemove.Text = "&Remove"
        Me.CmdRemove.UseVisualStyleBackColor = False
        '
        'CmdEdit
        '
        Me.CmdEdit.BackColor = System.Drawing.SystemColors.Control
        Me.CmdEdit.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdEdit.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdEdit.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdEdit.Location = New System.Drawing.Point(308, 32)
        Me.CmdEdit.Name = "CmdEdit"
        Me.CmdEdit.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdEdit.Size = New System.Drawing.Size(80, 21)
        Me.CmdEdit.TabIndex = 1
        Me.CmdEdit.Text = "&Edit..."
        Me.CmdEdit.UseVisualStyleBackColor = False
        '
        'CmdAdd
        '
        Me.CmdAdd.BackColor = System.Drawing.SystemColors.Control
        Me.CmdAdd.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdAdd.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdAdd.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdAdd.Location = New System.Drawing.Point(308, 6)
        Me.CmdAdd.Name = "CmdAdd"
        Me.CmdAdd.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdAdd.Size = New System.Drawing.Size(80, 21)
        Me.CmdAdd.TabIndex = 0
        Me.CmdAdd.Text = "&Add..."
        Me.CmdAdd.UseVisualStyleBackColor = False
        '
        'CmdCancel
        '
        Me.CmdCancel.BackColor = System.Drawing.SystemColors.Control
        Me.CmdCancel.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdCancel.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdCancel.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdCancel.Location = New System.Drawing.Point(310, 268)
        Me.CmdCancel.Name = "CmdCancel"
        Me.CmdCancel.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdCancel.Size = New System.Drawing.Size(80, 21)
        Me.CmdCancel.TabIndex = 2
        Me.CmdCancel.Text = "&Close"
        Me.CmdCancel.UseVisualStyleBackColor = False
        '
        'Frame
        '
        Me.Frame.BackColor = System.Drawing.SystemColors.Control
        Me.Frame.Controls.Add(Me.LstViewKeyCode)
        Me.Frame.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Frame.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.Location = New System.Drawing.Point(2, 0)
        Me.Frame.Name = "Frame"
        Me.Frame.Padding = New System.Windows.Forms.Padding(0)
        Me.Frame.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame.Size = New System.Drawing.Size(301, 289)
        Me.Frame.TabIndex = 3
        Me.Frame.TabStop = False
        '
        'LstViewKeyCode
        '
        Me.LstViewKeyCode.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewKeyCode.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewKeyCode.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewKeyCode.FullRowSelect = True
        Me.LstViewKeyCode.HideSelection = False
        Me.LstViewKeyCode.LabelWrap = False
        Me.LstViewKeyCode.Location = New System.Drawing.Point(8, 16)
        Me.LstViewKeyCode.Name = "LstViewKeyCode"
        Me.LstViewKeyCode.Size = New System.Drawing.Size(285, 265)
        Me.LstViewKeyCode.TabIndex = 4
        Me.LstViewKeyCode.UseCompatibleStateImageBehavior = False
        Me.LstViewKeyCode.View = System.Windows.Forms.View.Details
        '
        'FrmKeyCodeSelect
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 14.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.ClientSize = New System.Drawing.Size(392, 294)
        Me.Controls.Add(Me.CmdRemove)
        Me.Controls.Add(Me.CmdEdit)
        Me.Controls.Add(Me.CmdAdd)
        Me.Controls.Add(Me.CmdCancel)
        Me.Controls.Add(Me.Frame)
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Location = New System.Drawing.Point(182, 112)
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "FrmKeyCodeSelect"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.StartPosition = System.Windows.Forms.FormStartPosition.Manual
        Me.Text = "Select Key Code"
        Me.Frame.ResumeLayout(False)
        Me.ResumeLayout(False)

    End Sub
#End Region 
End Class