<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmList
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
	Public WithEvents LstSelect As System.Windows.Forms.ListBox
	Public WithEvents Frame As System.Windows.Forms.GroupBox
	Public WithEvents CmdOK As System.Windows.Forms.Button
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
		Dim resources As System.Resources.ResourceManager = New System.Resources.ResourceManager(GetType(FrmList))
		Me.components = New System.ComponentModel.Container()
		Me.ToolTip1 = New System.Windows.Forms.ToolTip(components)
		Me.Frame = New System.Windows.Forms.GroupBox
		Me.LstSelect = New System.Windows.Forms.ListBox
		Me.CmdOK = New System.Windows.Forms.Button
		Me.Frame.SuspendLayout()
		Me.SuspendLayout()
		Me.ToolTip1.Active = True
		Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
		Me.Text = "List"
		Me.ClientSize = New System.Drawing.Size(253, 168)
		Me.Location = New System.Drawing.Point(307, 259)
		Me.Icon = CType(resources.GetObject("FrmList.Icon"), System.Drawing.Icon)
		Me.MaximizeBox = False
		Me.MinimizeBox = False
		Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
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
		Me.Name = "FrmList"
		Me.Frame.Size = New System.Drawing.Size(161, 165)
		Me.Frame.Location = New System.Drawing.Point(2, -2)
		Me.Frame.TabIndex = 2
		Me.Frame.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.Frame.BackColor = System.Drawing.SystemColors.Control
		Me.Frame.Enabled = True
		Me.Frame.ForeColor = System.Drawing.SystemColors.ControlText
		Me.Frame.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.Frame.Visible = True
		Me.Frame.Padding = New System.Windows.Forms.Padding(0)
		Me.Frame.Name = "Frame"
		Me.LstSelect.Size = New System.Drawing.Size(149, 150)
		Me.LstSelect.Location = New System.Drawing.Point(6, 12)
		Me.LstSelect.TabIndex = 0
		Me.LstSelect.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.LstSelect.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.LstSelect.BackColor = System.Drawing.SystemColors.Window
		Me.LstSelect.CausesValidation = True
		Me.LstSelect.Enabled = True
		Me.LstSelect.ForeColor = System.Drawing.SystemColors.WindowText
		Me.LstSelect.IntegralHeight = True
		Me.LstSelect.Cursor = System.Windows.Forms.Cursors.Default
		Me.LstSelect.SelectionMode = System.Windows.Forms.SelectionMode.One
		Me.LstSelect.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.LstSelect.Sorted = False
		Me.LstSelect.TabStop = True
		Me.LstSelect.Visible = True
		Me.LstSelect.MultiColumn = False
		Me.LstSelect.Name = "LstSelect"
		Me.CmdOK.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		Me.CmdOK.Text = "&Select"
		Me.AcceptButton = Me.CmdOK
		Me.CmdOK.Size = New System.Drawing.Size(80, 21)
		Me.CmdOK.Location = New System.Drawing.Point(168, 4)
		Me.CmdOK.TabIndex = 1
		Me.CmdOK.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.CmdOK.BackColor = System.Drawing.SystemColors.Control
		Me.CmdOK.CausesValidation = True
		Me.CmdOK.Enabled = True
		Me.CmdOK.ForeColor = System.Drawing.SystemColors.ControlText
		Me.CmdOK.Cursor = System.Windows.Forms.Cursors.Default
		Me.CmdOK.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.CmdOK.TabStop = True
		Me.CmdOK.Name = "CmdOK"
		Me.Controls.Add(Frame)
		Me.Controls.Add(CmdOK)
		Me.Frame.Controls.Add(LstSelect)
		Me.Frame.ResumeLayout(False)
		Me.ResumeLayout(False)
		Me.PerformLayout()
	End Sub
#End Region 
End Class