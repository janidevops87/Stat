<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmCounty
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
	Public WithEvents CboState As System.Windows.Forms.ComboBox
	Public WithEvents _LblOrganization_0 As System.Windows.Forms.Label
	Public WithEvents _LblOrganization_7 As System.Windows.Forms.Label
	Public WithEvents Frame As System.Windows.Forms.GroupBox
	Public WithEvents CmdOK As System.Windows.Forms.Button
	Public WithEvents CmdCancel As System.Windows.Forms.Button
	Public WithEvents LblOrganization As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
		Dim resources As System.Resources.ResourceManager = New System.Resources.ResourceManager(GetType(FrmCounty))
		Me.components = New System.ComponentModel.Container()
		Me.ToolTip1 = New System.Windows.Forms.ToolTip(components)
		Me.Frame = New System.Windows.Forms.GroupBox
		Me.TxtName = New System.Windows.Forms.TextBox
		Me.CboState = New System.Windows.Forms.ComboBox
		Me._LblOrganization_0 = New System.Windows.Forms.Label
		Me._LblOrganization_7 = New System.Windows.Forms.Label
		Me.CmdOK = New System.Windows.Forms.Button
		Me.CmdCancel = New System.Windows.Forms.Button
		Me.LblOrganization = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(components)
		Me.Frame.SuspendLayout()
		Me.SuspendLayout()
		Me.ToolTip1.Active = True
		CType(Me.LblOrganization, System.ComponentModel.ISupportInitialize).BeginInit()
		Me.StartPosition = System.Windows.Forms.FormStartPosition.Manual
		Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
		Me.Text = "County"
		Me.ClientSize = New System.Drawing.Size(380, 79)
		Me.Location = New System.Drawing.Point(79, 263)
		Me.Icon = CType(resources.GetObject("FrmCounty.Icon"), System.Drawing.Icon)
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
		Me.Name = "FrmCounty"
		Me.Frame.Size = New System.Drawing.Size(289, 75)
		Me.Frame.Location = New System.Drawing.Point(2, 0)
		Me.Frame.TabIndex = 2
		Me.Frame.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.Frame.BackColor = System.Drawing.SystemColors.Control
		Me.Frame.Enabled = True
		Me.Frame.ForeColor = System.Drawing.SystemColors.ControlText
		Me.Frame.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.Frame.Visible = True
		Me.Frame.Padding = New System.Windows.Forms.Padding(0)
		Me.Frame.Name = "Frame"
		Me.TxtName.AutoSize = False
		Me.TxtName.Size = New System.Drawing.Size(223, 21)
		Me.TxtName.Location = New System.Drawing.Point(51, 18)
		Me.TxtName.TabIndex = 4
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
        Me.CboState.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboState.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboState.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboState.Size = New System.Drawing.Size(57, 21)
		Me.CboState.Location = New System.Drawing.Point(51, 42)
		Me.CboState.Sorted = True
        Me.CboState.TabIndex = 3
		Me.CboState.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.CboState.BackColor = System.Drawing.SystemColors.Window
		Me.CboState.CausesValidation = True
		Me.CboState.Enabled = True
		Me.CboState.ForeColor = System.Drawing.SystemColors.WindowText
		Me.CboState.IntegralHeight = True
		Me.CboState.Cursor = System.Windows.Forms.Cursors.Default
		Me.CboState.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.CboState.TabStop = True
		Me.CboState.Visible = True
		Me.CboState.Name = "CboState"
		Me._LblOrganization_0.Text = "Name"
		Me._LblOrganization_0.Size = New System.Drawing.Size(41, 15)
		Me._LblOrganization_0.Location = New System.Drawing.Point(18, 22)
		Me._LblOrganization_0.TabIndex = 6
		Me._LblOrganization_0.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me._LblOrganization_0.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me._LblOrganization_0.BackColor = System.Drawing.SystemColors.Control
		Me._LblOrganization_0.Enabled = True
		Me._LblOrganization_0.ForeColor = System.Drawing.SystemColors.ControlText
		Me._LblOrganization_0.Cursor = System.Windows.Forms.Cursors.Default
		Me._LblOrganization_0.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me._LblOrganization_0.UseMnemonic = True
		Me._LblOrganization_0.Visible = True
		Me._LblOrganization_0.AutoSize = False
		Me._LblOrganization_0.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me._LblOrganization_0.Name = "_LblOrganization_0"
		Me._LblOrganization_7.Text = "State"
		Me._LblOrganization_7.Size = New System.Drawing.Size(103, 15)
		Me._LblOrganization_7.Location = New System.Drawing.Point(18, 46)
		Me._LblOrganization_7.TabIndex = 5
		Me._LblOrganization_7.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me._LblOrganization_7.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me._LblOrganization_7.BackColor = System.Drawing.SystemColors.Control
		Me._LblOrganization_7.Enabled = True
		Me._LblOrganization_7.ForeColor = System.Drawing.SystemColors.ControlText
		Me._LblOrganization_7.Cursor = System.Windows.Forms.Cursors.Default
		Me._LblOrganization_7.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me._LblOrganization_7.UseMnemonic = True
		Me._LblOrganization_7.Visible = True
		Me._LblOrganization_7.AutoSize = False
		Me._LblOrganization_7.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me._LblOrganization_7.Name = "_LblOrganization_7"
		Me.CmdOK.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		Me.CmdOK.Text = "&Save"
		Me.CmdOK.Size = New System.Drawing.Size(80, 21)
		Me.CmdOK.Location = New System.Drawing.Point(296, 6)
		Me.CmdOK.TabIndex = 0
		Me.CmdOK.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.CmdOK.BackColor = System.Drawing.SystemColors.Control
		Me.CmdOK.CausesValidation = True
		Me.CmdOK.Enabled = True
		Me.CmdOK.ForeColor = System.Drawing.SystemColors.ControlText
		Me.CmdOK.Cursor = System.Windows.Forms.Cursors.Default
		Me.CmdOK.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.CmdOK.TabStop = True
		Me.CmdOK.Name = "CmdOK"
		Me.CmdCancel.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		Me.CmdCancel.Text = "C&ancel"
		Me.CmdCancel.Size = New System.Drawing.Size(80, 21)
		Me.CmdCancel.Location = New System.Drawing.Point(296, 54)
		Me.CmdCancel.TabIndex = 1
		Me.CmdCancel.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.CmdCancel.BackColor = System.Drawing.SystemColors.Control
		Me.CmdCancel.CausesValidation = True
		Me.CmdCancel.Enabled = True
		Me.CmdCancel.ForeColor = System.Drawing.SystemColors.ControlText
		Me.CmdCancel.Cursor = System.Windows.Forms.Cursors.Default
		Me.CmdCancel.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.CmdCancel.TabStop = True
		Me.CmdCancel.Name = "CmdCancel"
		Me.Controls.Add(Frame)
		Me.Controls.Add(CmdOK)
		Me.Controls.Add(CmdCancel)
		Me.Frame.Controls.Add(TxtName)
		Me.Frame.Controls.Add(CboState)
		Me.Frame.Controls.Add(_LblOrganization_0)
		Me.Frame.Controls.Add(_LblOrganization_7)
		Me.LblOrganization.SetIndex(_LblOrganization_0, CType(0, Short))
		Me.LblOrganization.SetIndex(_LblOrganization_7, CType(7, Short))
		CType(Me.LblOrganization, System.ComponentModel.ISupportInitialize).EndInit()
		Me.Frame.ResumeLayout(False)
		Me.ResumeLayout(False)
		Me.PerformLayout()
	End Sub
#End Region 
End Class