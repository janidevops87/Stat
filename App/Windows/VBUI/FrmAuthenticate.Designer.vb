<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmAuthenticate
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
	Public WithEvents pbrAuthenticate As System.Windows.Forms.ProgressBar
	Public WithEvents tmr_Authenticate As System.Windows.Forms.Timer
	Public WithEvents lblAuthenticate As System.Windows.Forms.Label
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
		Dim resources As System.Resources.ResourceManager = New System.Resources.ResourceManager(GetType(FrmAuthenticate))
		Me.components = New System.ComponentModel.Container()
		Me.ToolTip1 = New System.Windows.Forms.ToolTip(components)
		Me.pbrAuthenticate = New System.Windows.Forms.ProgressBar
		Me.tmr_Authenticate = New System.Windows.Forms.Timer(components)
		Me.lblAuthenticate = New System.Windows.Forms.Label
		Me.SuspendLayout()
		Me.ToolTip1.Active = True
		Me.Text = "Authenticate"
		Me.ClientSize = New System.Drawing.Size(163, 57)
		Me.Location = New System.Drawing.Point(4, 23)
		Me.ControlBox = False
		Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent
		Me.Visible = False
		Me.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
		Me.BackColor = System.Drawing.SystemColors.Control
		Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.Sizable
		Me.Enabled = True
		Me.KeyPreview = False
		Me.MaximizeBox = True
		Me.MinimizeBox = True
		Me.Cursor = System.Windows.Forms.Cursors.Default
		Me.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.ShowInTaskbar = True
		Me.HelpButton = False
		Me.WindowState = System.Windows.Forms.FormWindowState.Normal
		Me.Name = "FrmAuthenticate"
		Me.pbrAuthenticate.Size = New System.Drawing.Size(145, 17)
		Me.pbrAuthenticate.Location = New System.Drawing.Point(8, 32)
		Me.pbrAuthenticate.TabIndex = 0
		Me.pbrAuthenticate.Maximum = 5000
		Me.pbrAuthenticate.Name = "pbrAuthenticate"
		Me.tmr_Authenticate.Interval = 50
		Me.tmr_Authenticate.Enabled = True
		Me.lblAuthenticate.Text = "Authenticating..."
		Me.lblAuthenticate.Size = New System.Drawing.Size(129, 17)
		Me.lblAuthenticate.Location = New System.Drawing.Point(8, 8)
		Me.lblAuthenticate.TabIndex = 1
		Me.lblAuthenticate.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblAuthenticate.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me.lblAuthenticate.BackColor = System.Drawing.SystemColors.Control
		Me.lblAuthenticate.Enabled = True
		Me.lblAuthenticate.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblAuthenticate.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblAuthenticate.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblAuthenticate.UseMnemonic = True
		Me.lblAuthenticate.Visible = True
		Me.lblAuthenticate.AutoSize = False
		Me.lblAuthenticate.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblAuthenticate.Name = "lblAuthenticate"
		Me.Controls.Add(pbrAuthenticate)
		Me.Controls.Add(lblAuthenticate)
		Me.ResumeLayout(False)
		Me.PerformLayout()
	End Sub
#End Region 
End Class