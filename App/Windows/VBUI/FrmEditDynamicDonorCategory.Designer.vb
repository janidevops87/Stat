<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmEditDynamicDonorCategory
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
	Public WithEvents CmdSave As System.Windows.Forms.Button
	Public WithEvents TxtName As System.Windows.Forms.TextBox
	Public WithEvents Label1 As System.Windows.Forms.Label
	Public WithEvents Frame1 As System.Windows.Forms.GroupBox
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
		Dim resources As System.Resources.ResourceManager = New System.Resources.ResourceManager(GetType(FrmEditDynamicDonorCategory))
		Me.components = New System.ComponentModel.Container()
		Me.ToolTip1 = New System.Windows.Forms.ToolTip(components)
		Me.CmdCancel = New System.Windows.Forms.Button
		Me.CmdSave = New System.Windows.Forms.Button
		Me.Frame1 = New System.Windows.Forms.GroupBox
		Me.TxtName = New System.Windows.Forms.TextBox
		Me.Label1 = New System.Windows.Forms.Label
		Me.Frame1.SuspendLayout()
		Me.SuspendLayout()
		Me.ToolTip1.Active = True
		Me.StartPosition = System.Windows.Forms.FormStartPosition.Manual
		Me.Text = "Edit Dynamic Donor Category"
		Me.ClientSize = New System.Drawing.Size(381, 62)
		Me.Location = New System.Drawing.Point(131, 342)
		Me.Icon = CType(resources.GetObject("FrmEditDynamicDonorCategory.Icon"), System.Drawing.Icon)
		Me.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
		Me.BackColor = System.Drawing.SystemColors.Control
		Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.Sizable
		Me.ControlBox = True
		Me.Enabled = True
		Me.KeyPreview = False
		Me.MaximizeBox = True
		Me.MinimizeBox = True
		Me.Cursor = System.Windows.Forms.Cursors.Default
		Me.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.ShowInTaskbar = True
		Me.HelpButton = False
		Me.WindowState = System.Windows.Forms.FormWindowState.Normal
		Me.Name = "FrmEditDynamicDonorCategory"
		Me.CmdCancel.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		Me.CmdCancel.Text = "C&ancel"
		Me.CmdCancel.Size = New System.Drawing.Size(80, 21)
		Me.CmdCancel.Location = New System.Drawing.Point(296, 32)
		Me.CmdCancel.TabIndex = 4
		Me.CmdCancel.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.CmdCancel.BackColor = System.Drawing.SystemColors.Control
		Me.CmdCancel.CausesValidation = True
		Me.CmdCancel.Enabled = True
		Me.CmdCancel.ForeColor = System.Drawing.SystemColors.ControlText
		Me.CmdCancel.Cursor = System.Windows.Forms.Cursors.Default
		Me.CmdCancel.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.CmdCancel.TabStop = True
		Me.CmdCancel.Name = "CmdCancel"
		Me.CmdSave.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		Me.CmdSave.Text = "&Save"
		Me.CmdSave.Size = New System.Drawing.Size(80, 21)
		Me.CmdSave.Location = New System.Drawing.Point(296, 8)
		Me.CmdSave.TabIndex = 3
		Me.CmdSave.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.CmdSave.BackColor = System.Drawing.SystemColors.Control
		Me.CmdSave.CausesValidation = True
		Me.CmdSave.Enabled = True
		Me.CmdSave.ForeColor = System.Drawing.SystemColors.ControlText
		Me.CmdSave.Cursor = System.Windows.Forms.Cursors.Default
		Me.CmdSave.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.CmdSave.TabStop = True
		Me.CmdSave.Name = "CmdSave"
		Me.Frame1.Size = New System.Drawing.Size(281, 49)
		Me.Frame1.Location = New System.Drawing.Point(8, 8)
		Me.Frame1.TabIndex = 0
		Me.Frame1.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.Frame1.BackColor = System.Drawing.SystemColors.Control
		Me.Frame1.Enabled = True
		Me.Frame1.ForeColor = System.Drawing.SystemColors.ControlText
		Me.Frame1.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.Frame1.Visible = True
		Me.Frame1.Padding = New System.Windows.Forms.Padding(0)
		Me.Frame1.Name = "Frame1"
		Me.TxtName.AutoSize = False
		Me.TxtName.Size = New System.Drawing.Size(223, 21)
		Me.TxtName.Location = New System.Drawing.Point(48, 16)
		Me.TxtName.TabIndex = 2
		Me.TxtName.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.TxtName.AcceptsReturn = True
		Me.TxtName.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me.TxtName.BackColor = System.Drawing.SystemColors.Window
		Me.TxtName.CausesValidation = True
		Me.TxtName.Enabled = True
		Me.TxtName.ForeColor = System.Drawing.SystemColors.WindowText
		Me.TxtName.HideSelection = True
		Me.TxtName.ReadOnly = False
		Me.TxtName.Maxlength = 0
		Me.TxtName.Cursor = System.Windows.Forms.Cursors.IBeam
		Me.TxtName.MultiLine = False
		Me.TxtName.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.TxtName.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me.TxtName.TabStop = True
		Me.TxtName.Visible = True
		Me.TxtName.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.TxtName.Name = "TxtName"
		Me.Label1.Text = "Name"
		Me.Label1.Size = New System.Drawing.Size(73, 15)
		Me.Label1.Location = New System.Drawing.Point(16, 19)
		Me.Label1.TabIndex = 1
		Me.Label1.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.Label1.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me.Label1.BackColor = System.Drawing.SystemColors.Control
		Me.Label1.Enabled = True
		Me.Label1.ForeColor = System.Drawing.SystemColors.ControlText
		Me.Label1.Cursor = System.Windows.Forms.Cursors.Default
		Me.Label1.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.Label1.UseMnemonic = True
		Me.Label1.Visible = True
		Me.Label1.AutoSize = False
		Me.Label1.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.Label1.Name = "Label1"
		Me.Controls.Add(CmdCancel)
		Me.Controls.Add(CmdSave)
		Me.Controls.Add(Frame1)
		Me.Frame1.Controls.Add(TxtName)
		Me.Frame1.Controls.Add(Label1)
		Me.Frame1.ResumeLayout(False)
		Me.ResumeLayout(False)
		Me.PerformLayout()
	End Sub
#End Region 
End Class