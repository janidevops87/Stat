<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmAlertGroup
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
	Public WithEvents _Lable_0 As System.Windows.Forms.Label
	Public WithEvents FraOrgInfo As System.Windows.Forms.GroupBox
	Public WithEvents CmdCancel As System.Windows.Forms.Button
	Public WithEvents CmdOK As System.Windows.Forms.Button
	Public WithEvents Lable As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
		Dim resources As System.Resources.ResourceManager = New System.Resources.ResourceManager(GetType(FrmAlertGroup))
		Me.components = New System.ComponentModel.Container()
		Me.ToolTip1 = New System.Windows.Forms.ToolTip(components)
		Me.FraOrgInfo = New System.Windows.Forms.GroupBox
		Me.TxtName = New System.Windows.Forms.TextBox
		Me._Lable_0 = New System.Windows.Forms.Label
		Me.CmdCancel = New System.Windows.Forms.Button
		Me.CmdOK = New System.Windows.Forms.Button
		Me.Lable = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(components)
		Me.FraOrgInfo.SuspendLayout()
		Me.SuspendLayout()
		Me.ToolTip1.Active = True
		CType(Me.Lable, System.ComponentModel.ISupportInitialize).BeginInit()
		Me.StartPosition = System.Windows.Forms.FormStartPosition.Manual
		Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
		Me.Text = "Alert Group"
		Me.ClientSize = New System.Drawing.Size(381, 58)
		Me.Location = New System.Drawing.Point(297, 132)
		Me.Icon = CType(resources.GetObject("FrmAlertGroup.Icon"), System.Drawing.Icon)
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
		Me.Name = "FrmAlertGroup"
		Me.FraOrgInfo.Size = New System.Drawing.Size(291, 54)
		Me.FraOrgInfo.Location = New System.Drawing.Point(2, 0)
		Me.FraOrgInfo.TabIndex = 3
		Me.FraOrgInfo.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.FraOrgInfo.BackColor = System.Drawing.SystemColors.Control
		Me.FraOrgInfo.Enabled = True
		Me.FraOrgInfo.ForeColor = System.Drawing.SystemColors.ControlText
		Me.FraOrgInfo.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.FraOrgInfo.Visible = True
		Me.FraOrgInfo.Padding = New System.Windows.Forms.Padding(0)
		Me.FraOrgInfo.Name = "FraOrgInfo"
		Me.TxtName.AutoSize = False
		Me.TxtName.Size = New System.Drawing.Size(223, 21)
		Me.TxtName.Location = New System.Drawing.Point(54, 20)
		Me.TxtName.Maxlength = 80
		Me.TxtName.TabIndex = 0
		Me.TxtName.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.TxtName.AcceptsReturn = True
		Me.TxtName.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me.TxtName.BackColor = System.Drawing.SystemColors.Window
		Me.TxtName.CausesValidation = True
		Me.TxtName.Enabled = True
		Me.TxtName.ForeColor = System.Drawing.SystemColors.WindowText
		Me.TxtName.HideSelection = True
		Me.TxtName.ReadOnly = False
		Me.TxtName.Cursor = System.Windows.Forms.Cursors.IBeam
		Me.TxtName.MultiLine = False
		Me.TxtName.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.TxtName.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me.TxtName.TabStop = True
		Me.TxtName.Visible = True
		Me.TxtName.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.TxtName.Name = "TxtName"
		Me._Lable_0.Text = "Name"
		Me._Lable_0.Size = New System.Drawing.Size(93, 15)
		Me._Lable_0.Location = New System.Drawing.Point(16, 24)
		Me._Lable_0.TabIndex = 4
		Me._Lable_0.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me._Lable_0.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me._Lable_0.BackColor = System.Drawing.SystemColors.Control
		Me._Lable_0.Enabled = True
		Me._Lable_0.ForeColor = System.Drawing.SystemColors.ControlText
		Me._Lable_0.Cursor = System.Windows.Forms.Cursors.Default
		Me._Lable_0.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me._Lable_0.UseMnemonic = True
		Me._Lable_0.Visible = True
		Me._Lable_0.AutoSize = False
		Me._Lable_0.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me._Lable_0.Name = "_Lable_0"
		Me.CmdCancel.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		Me.CmdCancel.Text = "C&ancel"
		Me.CmdCancel.Size = New System.Drawing.Size(80, 21)
		Me.CmdCancel.Location = New System.Drawing.Point(298, 31)
		Me.CmdCancel.TabIndex = 2
		Me.CmdCancel.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.CmdCancel.BackColor = System.Drawing.SystemColors.Control
		Me.CmdCancel.CausesValidation = True
		Me.CmdCancel.Enabled = True
		Me.CmdCancel.ForeColor = System.Drawing.SystemColors.ControlText
		Me.CmdCancel.Cursor = System.Windows.Forms.Cursors.Default
		Me.CmdCancel.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.CmdCancel.TabStop = True
		Me.CmdCancel.Name = "CmdCancel"
		Me.CmdOK.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		Me.CmdOK.Text = "&Save"
		Me.CmdOK.Size = New System.Drawing.Size(80, 21)
		Me.CmdOK.Location = New System.Drawing.Point(298, 5)
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
		Me.Controls.Add(FraOrgInfo)
		Me.Controls.Add(CmdCancel)
		Me.Controls.Add(CmdOK)
		Me.FraOrgInfo.Controls.Add(TxtName)
		Me.FraOrgInfo.Controls.Add(_Lable_0)
		Me.Lable.SetIndex(_Lable_0, CType(0, Short))
		CType(Me.Lable, System.ComponentModel.ISupportInitialize).EndInit()
		Me.FraOrgInfo.ResumeLayout(False)
		Me.ResumeLayout(False)
		Me.PerformLayout()
	End Sub
#End Region 
End Class