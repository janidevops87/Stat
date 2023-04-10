<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmLineCheckList
#Region "Windows Form Designer generated code "
	<System.Diagnostics.DebuggerNonUserCode()> Public Sub New()
		MyBase.New()
		'This call is required by the Windows Form Designer.
		InitializeComponent()
		'This form is an MDI child.
		'This code simulates the VB6 
		' functionality of automatically
		' loading and showing an MDI
		' child's parent.
        'bret 1/4/2010 dll conversion Me.MdiParent = New StatTrac.MDIFormStatLine
        'bret 1/4/2010 dll conversion MdiParent.Show()
        'StatTrac.MDIFormStatLine.Show()
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
	Public WithEvents CmdRefresh As System.Windows.Forms.Button
	Public WithEvents CmdCancel As System.Windows.Forms.Button
	Public WithEvents TxtMessage As System.Windows.Forms.TextBox
	Public WithEvents LstViewLineCheck As System.Windows.Forms.ListView
	Public WithEvents _Frame_0 As System.Windows.Forms.GroupBox
	Public WithEvents Frame As Microsoft.VisualBasic.Compatibility.VB6.GroupBoxArray
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
		Dim resources As System.Resources.ResourceManager = New System.Resources.ResourceManager(GetType(FrmLineCheckList))
		Me.components = New System.ComponentModel.Container()
		Me.ToolTip1 = New System.Windows.Forms.ToolTip(components)
		Me.CmdRefresh = New System.Windows.Forms.Button
		Me.CmdCancel = New System.Windows.Forms.Button
		Me._Frame_0 = New System.Windows.Forms.GroupBox
		Me.TxtMessage = New System.Windows.Forms.TextBox
		Me.LstViewLineCheck = New System.Windows.Forms.ListView
		Me.Frame = New Microsoft.VisualBasic.Compatibility.VB6.GroupBoxArray(components)
		Me._Frame_0.SuspendLayout()
		Me.SuspendLayout()
		Me.ToolTip1.Active = True
		CType(Me.Frame, System.ComponentModel.ISupportInitialize).BeginInit()
		Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
		Me.Text = "Line Check List"
		Me.ClientSize = New System.Drawing.Size(555, 273)
		Me.Location = New System.Drawing.Point(178, 271)
		Me.Icon = CType(resources.GetObject("FrmLineCheckList.Icon"), System.Drawing.Icon)
		Me.MaximizeBox = False
		Me.StartPosition = System.Windows.Forms.FormStartPosition.WindowsDefaultBounds
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
		Me.Name = "FrmLineCheckList"
		Me.CmdRefresh.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		Me.CmdRefresh.Text = "&Refresh"
		Me.CmdRefresh.Size = New System.Drawing.Size(80, 21)
		Me.CmdRefresh.Location = New System.Drawing.Point(472, 6)
		Me.CmdRefresh.TabIndex = 4
		Me.CmdRefresh.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.CmdRefresh.BackColor = System.Drawing.SystemColors.Control
		Me.CmdRefresh.CausesValidation = True
		Me.CmdRefresh.Enabled = True
		Me.CmdRefresh.ForeColor = System.Drawing.SystemColors.ControlText
		Me.CmdRefresh.Cursor = System.Windows.Forms.Cursors.Default
		Me.CmdRefresh.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.CmdRefresh.TabStop = True
		Me.CmdRefresh.Name = "CmdRefresh"
		Me.CmdCancel.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		Me.CmdCancel.Text = "&Close"
		Me.CmdCancel.Size = New System.Drawing.Size(80, 21)
		Me.CmdCancel.Location = New System.Drawing.Point(472, 32)
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
		Me._Frame_0.Size = New System.Drawing.Size(465, 269)
		Me._Frame_0.Location = New System.Drawing.Point(2, 0)
		Me._Frame_0.TabIndex = 0
		Me._Frame_0.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me._Frame_0.BackColor = System.Drawing.SystemColors.Control
		Me._Frame_0.Enabled = True
		Me._Frame_0.ForeColor = System.Drawing.SystemColors.ControlText
		Me._Frame_0.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me._Frame_0.Visible = True
		Me._Frame_0.Padding = New System.Windows.Forms.Padding(0)
		Me._Frame_0.Name = "_Frame_0"
		Me.TxtMessage.AutoSize = False
		Me.TxtMessage.Size = New System.Drawing.Size(453, 135)
		Me.TxtMessage.Location = New System.Drawing.Point(6, 128)
		Me.TxtMessage.ReadOnly = True
		Me.TxtMessage.MultiLine = True
		Me.TxtMessage.TabIndex = 3
		Me.TxtMessage.TabStop = False
		Me.TxtMessage.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.TxtMessage.AcceptsReturn = True
		Me.TxtMessage.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me.TxtMessage.BackColor = System.Drawing.SystemColors.Window
		Me.TxtMessage.CausesValidation = True
		Me.TxtMessage.Enabled = True
		Me.TxtMessage.ForeColor = System.Drawing.SystemColors.WindowText
		Me.TxtMessage.HideSelection = True
		Me.TxtMessage.Maxlength = 0
		Me.TxtMessage.Cursor = System.Windows.Forms.Cursors.IBeam
		Me.TxtMessage.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.TxtMessage.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me.TxtMessage.Visible = True
		Me.TxtMessage.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.TxtMessage.Name = "TxtMessage"
		Me.LstViewLineCheck.Size = New System.Drawing.Size(453, 113)
		Me.LstViewLineCheck.Location = New System.Drawing.Point(6, 12)
		Me.LstViewLineCheck.TabIndex = 2
		Me.LstViewLineCheck.TabStop = 0
		Me.LstViewLineCheck.View = System.Windows.Forms.View.Details
		Me.LstViewLineCheck.LabelEdit = False
		Me.LstViewLineCheck.LabelWrap = False
		Me.LstViewLineCheck.HideSelection = False
		Me.LstViewLineCheck.ForeColor = System.Drawing.SystemColors.WindowText
		Me.LstViewLineCheck.BackColor = System.Drawing.SystemColors.Window
		Me.LstViewLineCheck.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.LstViewLineCheck.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.LstViewLineCheck.Name = "LstViewLineCheck"
        Me.LstViewLineCheck.FullRowSelect = True

        Me.Frame.SetIndex(_Frame_0, CType(0, Short))
		CType(Me.Frame, System.ComponentModel.ISupportInitialize).EndInit()
		Me.Controls.Add(CmdRefresh)
		Me.Controls.Add(CmdCancel)
		Me.Controls.Add(_Frame_0)
		Me._Frame_0.Controls.Add(TxtMessage)
		Me._Frame_0.Controls.Add(LstViewLineCheck)
		Me._Frame_0.ResumeLayout(False)
		Me.ResumeLayout(False)
		Me.PerformLayout()
	End Sub
#End Region 
End Class