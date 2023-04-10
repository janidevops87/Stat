<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmAlphaMsg
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
	Public WithEvents CmdCancel As System.Windows.Forms.Button
	Public WithEvents TxtAlpha As System.Windows.Forms.TextBox
	Public WithEvents CmdSend As System.Windows.Forms.Button
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
		Dim resources As System.Resources.ResourceManager = New System.Resources.ResourceManager(GetType(FrmAlphaMsg))
		Me.components = New System.ComponentModel.Container()
		Me.ToolTip1 = New System.Windows.Forms.ToolTip(components)
		Me.CmdCancel = New System.Windows.Forms.Button
		Me.TxtAlpha = New System.Windows.Forms.TextBox
		Me.CmdSend = New System.Windows.Forms.Button
		Me.SuspendLayout()
		Me.ToolTip1.Active = True
		Me.StartPosition = System.Windows.Forms.FormStartPosition.Manual
		Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
		Me.Text = "Alpha Message"
		Me.ClientSize = New System.Drawing.Size(360, 93)
		Me.Location = New System.Drawing.Point(261, 345)
		Me.Icon = CType(resources.GetObject("FrmAlphaMsg.Icon"), System.Drawing.Icon)
		Me.MaximizeBox = False
		Me.MinimizeBox = False
		Me.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
		Me.BackColor = System.Drawing.SystemColors.Control
		Me.ControlBox = True
		Me.Enabled = True
		Me.KeyPreview = False
		Me.Cursor = System.Windows.Forms.Cursors.Default
		Me.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.ShowInTaskbar = True
		Me.HelpButton = False
		Me.WindowState = System.Windows.Forms.FormWindowState.Normal
		Me.Name = "FrmAlphaMsg"
		Me.CmdCancel.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		Me.CmdCancel.Text = "&Cancel"
		Me.CmdCancel.Size = New System.Drawing.Size(80, 21)
		Me.CmdCancel.Location = New System.Drawing.Point(276, 68)
		Me.CmdCancel.TabIndex = 2
		Me.CmdCancel.TabStop = False
		Me.CmdCancel.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.CmdCancel.BackColor = System.Drawing.SystemColors.Control
		Me.CmdCancel.CausesValidation = True
		Me.CmdCancel.Enabled = True
		Me.CmdCancel.ForeColor = System.Drawing.SystemColors.ControlText
		Me.CmdCancel.Cursor = System.Windows.Forms.Cursors.Default
		Me.CmdCancel.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.CmdCancel.Name = "CmdCancel"
		Me.TxtAlpha.AutoSize = False
		Me.TxtAlpha.Size = New System.Drawing.Size(273, 87)
		Me.TxtAlpha.Location = New System.Drawing.Point(0, 2)
		Me.TxtAlpha.Maxlength = 240
		Me.TxtAlpha.MultiLine = True
		Me.TxtAlpha.TabIndex = 0
		Me.TxtAlpha.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.TxtAlpha.AcceptsReturn = True
		Me.TxtAlpha.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me.TxtAlpha.BackColor = System.Drawing.SystemColors.Window
		Me.TxtAlpha.CausesValidation = True
		Me.TxtAlpha.Enabled = True
		Me.TxtAlpha.ForeColor = System.Drawing.SystemColors.WindowText
		Me.TxtAlpha.HideSelection = True
		Me.TxtAlpha.ReadOnly = False
		Me.TxtAlpha.Cursor = System.Windows.Forms.Cursors.IBeam
		Me.TxtAlpha.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.TxtAlpha.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me.TxtAlpha.TabStop = True
		Me.TxtAlpha.Visible = True
		Me.TxtAlpha.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.TxtAlpha.Name = "TxtAlpha"
		Me.CmdSend.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		Me.CmdSend.Text = "&Send"
		Me.CmdSend.Size = New System.Drawing.Size(80, 21)
		Me.CmdSend.Location = New System.Drawing.Point(276, 2)
		Me.CmdSend.TabIndex = 1
		Me.CmdSend.TabStop = False
		Me.CmdSend.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.CmdSend.BackColor = System.Drawing.SystemColors.Control
		Me.CmdSend.CausesValidation = True
		Me.CmdSend.Enabled = True
		Me.CmdSend.ForeColor = System.Drawing.SystemColors.ControlText
		Me.CmdSend.Cursor = System.Windows.Forms.Cursors.Default
		Me.CmdSend.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.CmdSend.Name = "CmdSend"
		Me.Controls.Add(CmdCancel)
		Me.Controls.Add(TxtAlpha)
		Me.Controls.Add(CmdSend)
		Me.ResumeLayout(False)
		Me.PerformLayout()
	End Sub
#End Region 
End Class