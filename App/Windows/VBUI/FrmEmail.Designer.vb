<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmEmail
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
	Public WithEvents txtAddendum As System.Windows.Forms.TextBox
	Public WithEvents CmdCancel As System.Windows.Forms.Button
	Public WithEvents TxtEmail As System.Windows.Forms.TextBox
	Public WithEvents CmdSend As System.Windows.Forms.Button
	Public WithEvents lblAddendum As System.Windows.Forms.Label
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
		Dim resources As System.Resources.ResourceManager = New System.Resources.ResourceManager(GetType(FrmEmail))
		Me.components = New System.ComponentModel.Container()
		Me.ToolTip1 = New System.Windows.Forms.ToolTip(components)
		Me.txtAddendum = New System.Windows.Forms.TextBox
		Me.CmdCancel = New System.Windows.Forms.Button
		Me.TxtEmail = New System.Windows.Forms.TextBox
		Me.CmdSend = New System.Windows.Forms.Button
		Me.lblAddendum = New System.Windows.Forms.Label
		Me.SuspendLayout()
		Me.ToolTip1.Active = True
		Me.StartPosition = System.Windows.Forms.FormStartPosition.Manual
		Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
		Me.Text = "Email Message"
		Me.ClientSize = New System.Drawing.Size(683, 551)
		Me.Location = New System.Drawing.Point(261, 345)
		Me.Icon = CType(resources.GetObject("FrmEmail.Icon"), System.Drawing.Icon)
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
		Me.Name = "FrmEmail"
		Me.txtAddendum.AutoSize = False
		Me.txtAddendum.Size = New System.Drawing.Size(593, 105)
		Me.txtAddendum.Location = New System.Drawing.Point(0, 440)
		Me.txtAddendum.Maxlength = 240
		Me.txtAddendum.MultiLine = True
		Me.txtAddendum.ScrollBars = System.Windows.Forms.ScrollBars.Vertical
		Me.txtAddendum.TabIndex = 4
		Me.txtAddendum.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.txtAddendum.AcceptsReturn = True
		Me.txtAddendum.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me.txtAddendum.BackColor = System.Drawing.SystemColors.Window
		Me.txtAddendum.CausesValidation = True
		Me.txtAddendum.Enabled = True
		Me.txtAddendum.ForeColor = System.Drawing.SystemColors.WindowText
		Me.txtAddendum.HideSelection = True
		Me.txtAddendum.ReadOnly = False
		Me.txtAddendum.Cursor = System.Windows.Forms.Cursors.IBeam
		Me.txtAddendum.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.txtAddendum.TabStop = True
		Me.txtAddendum.Visible = True
		Me.txtAddendum.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.txtAddendum.Name = "txtAddendum"
		Me.CmdCancel.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		Me.CmdCancel.Text = "&Cancel"
		Me.CmdCancel.Size = New System.Drawing.Size(80, 21)
		Me.CmdCancel.Location = New System.Drawing.Point(600, 520)
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
		Me.TxtEmail.AutoSize = False
		Me.TxtEmail.Size = New System.Drawing.Size(593, 407)
		Me.TxtEmail.Location = New System.Drawing.Point(0, 2)
		Me.TxtEmail.Maxlength = 1000
		Me.TxtEmail.MultiLine = True
		Me.TxtEmail.ScrollBars = System.Windows.Forms.ScrollBars.Vertical
		Me.TxtEmail.TabIndex = 0
		Me.TxtEmail.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.TxtEmail.AcceptsReturn = True
		Me.TxtEmail.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me.TxtEmail.BackColor = System.Drawing.SystemColors.Window
		Me.TxtEmail.CausesValidation = True
		Me.TxtEmail.Enabled = True
		Me.TxtEmail.ForeColor = System.Drawing.SystemColors.WindowText
		Me.TxtEmail.HideSelection = True
		Me.TxtEmail.ReadOnly = False
		Me.TxtEmail.Cursor = System.Windows.Forms.Cursors.IBeam
		Me.TxtEmail.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.TxtEmail.TabStop = True
		Me.TxtEmail.Visible = True
		Me.TxtEmail.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.TxtEmail.Name = "TxtEmail"
		Me.CmdSend.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		Me.CmdSend.Text = "&Send"
		Me.CmdSend.Size = New System.Drawing.Size(80, 21)
		Me.CmdSend.Location = New System.Drawing.Point(596, 10)
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
		Me.lblAddendum.Text = "Please enter any additional information that you would like to append to the email below:"
		Me.lblAddendum.Size = New System.Drawing.Size(577, 17)
		Me.lblAddendum.Location = New System.Drawing.Point(0, 416)
		Me.lblAddendum.TabIndex = 3
		Me.lblAddendum.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblAddendum.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me.lblAddendum.BackColor = System.Drawing.SystemColors.Control
		Me.lblAddendum.Enabled = True
		Me.lblAddendum.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblAddendum.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblAddendum.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblAddendum.UseMnemonic = True
		Me.lblAddendum.Visible = True
		Me.lblAddendum.AutoSize = False
		Me.lblAddendum.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblAddendum.Name = "lblAddendum"
		Me.Controls.Add(txtAddendum)
		Me.Controls.Add(CmdCancel)
		Me.Controls.Add(TxtEmail)
		Me.Controls.Add(CmdSend)
		Me.Controls.Add(lblAddendum)
		Me.ResumeLayout(False)
		Me.PerformLayout()
	End Sub
#End Region 
End Class