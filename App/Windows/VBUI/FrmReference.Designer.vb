<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmReference
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
	Public WithEvents _LblName_0 As System.Windows.Forms.Label
	Public WithEvents Frame As System.Windows.Forms.GroupBox
	Public WithEvents CmdCancel As System.Windows.Forms.Button
	Public WithEvents CmdOK As System.Windows.Forms.Button
	Public WithEvents LblName As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FrmReference))
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.Frame = New System.Windows.Forms.GroupBox
        Me.TxtName = New System.Windows.Forms.TextBox
        Me._LblName_0 = New System.Windows.Forms.Label
        Me.CmdCancel = New System.Windows.Forms.Button
        Me.CmdOK = New System.Windows.Forms.Button
        Me.LblName = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(Me.components)
        Me.Frame.SuspendLayout()
        CType(Me.LblName, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'Frame
        '
        Me.Frame.BackColor = System.Drawing.SystemColors.Control
        Me.Frame.Controls.Add(Me.TxtName)
        Me.Frame.Controls.Add(Me._LblName_0)
        Me.Frame.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Frame.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.Location = New System.Drawing.Point(2, -1)
        Me.Frame.Name = "Frame"
        Me.Frame.Padding = New System.Windows.Forms.Padding(0)
        Me.Frame.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame.Size = New System.Drawing.Size(291, 54)
        Me.Frame.TabIndex = 0
        Me.Frame.TabStop = False
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
        '_LblName_0
        '
        Me._LblName_0.BackColor = System.Drawing.SystemColors.Control
        Me._LblName_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblName_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LblName_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblName.SetIndex(Me._LblName_0, CType(0, Short))
        Me._LblName_0.Location = New System.Drawing.Point(16, 24)
        Me._LblName_0.Name = "_LblName_0"
        Me._LblName_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblName_0.Size = New System.Drawing.Size(93, 15)
        Me._LblName_0.TabIndex = 4
        Me._LblName_0.Text = "Text"
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
        'FrmReference
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 14.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.ClientSize = New System.Drawing.Size(381, 58)
        Me.Controls.Add(Me.Frame)
        Me.Controls.Add(Me.CmdCancel)
        Me.Controls.Add(Me.CmdOK)
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Location = New System.Drawing.Point(313, 356)
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "FrmReference"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.StartPosition = System.Windows.Forms.FormStartPosition.Manual
        Me.Text = "Reference"
        Me.Frame.ResumeLayout(False)
        CType(Me.LblName, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)

    End Sub
#End Region 
End Class