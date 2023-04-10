<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmQuickLook
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
	Public WithEvents CmdClose As System.Windows.Forms.Button
	Public WithEvents TxtPersonLast As System.Windows.Forms.TextBox
	Public WithEvents TxtPersonFirst As System.Windows.Forms.TextBox
	Public WithEvents TxtOrganization As System.Windows.Forms.TextBox
	Public WithEvents Label3 As System.Windows.Forms.Label
	Public WithEvents Label2 As System.Windows.Forms.Label
	Public WithEvents Label1 As System.Windows.Forms.Label
	Public WithEvents Frame1 As System.Windows.Forms.GroupBox
	Public WithEvents LstPerson As System.Windows.Forms.ListBox
	Public WithEvents LstOrganization As System.Windows.Forms.ListBox
	Public WithEvents Frame2 As System.Windows.Forms.GroupBox
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
		Dim resources As System.Resources.ResourceManager = New System.Resources.ResourceManager(GetType(FrmQuickLook))
		Me.components = New System.ComponentModel.Container()
		Me.ToolTip1 = New System.Windows.Forms.ToolTip(components)
		Me.CmdClose = New System.Windows.Forms.Button
		Me.Frame1 = New System.Windows.Forms.GroupBox
		Me.TxtPersonLast = New System.Windows.Forms.TextBox
		Me.TxtPersonFirst = New System.Windows.Forms.TextBox
		Me.TxtOrganization = New System.Windows.Forms.TextBox
		Me.Label3 = New System.Windows.Forms.Label
		Me.Label2 = New System.Windows.Forms.Label
		Me.Label1 = New System.Windows.Forms.Label
		Me.Frame2 = New System.Windows.Forms.GroupBox
		Me.LstPerson = New System.Windows.Forms.ListBox
		Me.LstOrganization = New System.Windows.Forms.ListBox
		Me.Frame1.SuspendLayout()
		Me.Frame2.SuspendLayout()
		Me.SuspendLayout()
		Me.ToolTip1.Active = True
		Me.StartPosition = System.Windows.Forms.FormStartPosition.Manual
		Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
		Me.Text = "Quick Lookup"
		Me.ClientSize = New System.Drawing.Size(521, 237)
		Me.Location = New System.Drawing.Point(269, 240)
		Me.Icon = CType(resources.GetObject("FrmQuickLook.Icon"), System.Drawing.Icon)
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
		Me.Name = "FrmQuickLook"
		Me.CmdClose.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		Me.CmdClose.Text = "&Close"
		Me.CmdClose.Size = New System.Drawing.Size(79, 23)
		Me.CmdClose.Location = New System.Drawing.Point(438, 10)
		Me.CmdClose.TabIndex = 5
		Me.CmdClose.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.CmdClose.BackColor = System.Drawing.SystemColors.Control
		Me.CmdClose.CausesValidation = True
		Me.CmdClose.Enabled = True
		Me.CmdClose.ForeColor = System.Drawing.SystemColors.ControlText
		Me.CmdClose.Cursor = System.Windows.Forms.Cursors.Default
		Me.CmdClose.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.CmdClose.TabStop = True
		Me.CmdClose.Name = "CmdClose"
		Me.Frame1.Size = New System.Drawing.Size(431, 55)
		Me.Frame1.Location = New System.Drawing.Point(2, 2)
		Me.Frame1.TabIndex = 6
		Me.Frame1.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.Frame1.BackColor = System.Drawing.SystemColors.Control
		Me.Frame1.Enabled = True
		Me.Frame1.ForeColor = System.Drawing.SystemColors.ControlText
		Me.Frame1.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.Frame1.Visible = True
		Me.Frame1.Padding = New System.Windows.Forms.Padding(0)
		Me.Frame1.Name = "Frame1"
		Me.TxtPersonLast.AutoSize = False
		Me.TxtPersonLast.Size = New System.Drawing.Size(87, 21)
		Me.TxtPersonLast.Location = New System.Drawing.Point(338, 26)
		Me.TxtPersonLast.TabIndex = 3
		Me.TxtPersonLast.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.TxtPersonLast.AcceptsReturn = True
		Me.TxtPersonLast.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me.TxtPersonLast.BackColor = System.Drawing.SystemColors.Window
		Me.TxtPersonLast.CausesValidation = True
		Me.TxtPersonLast.Enabled = True
		Me.TxtPersonLast.ForeColor = System.Drawing.SystemColors.WindowText
		Me.TxtPersonLast.HideSelection = True
		Me.TxtPersonLast.ReadOnly = False
		Me.TxtPersonLast.Maxlength = 0
		Me.TxtPersonLast.Cursor = System.Windows.Forms.Cursors.IBeam
		Me.TxtPersonLast.MultiLine = False
		Me.TxtPersonLast.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.TxtPersonLast.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me.TxtPersonLast.TabStop = True
		Me.TxtPersonLast.Visible = True
		Me.TxtPersonLast.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.TxtPersonLast.Name = "TxtPersonLast"
		Me.TxtPersonFirst.AutoSize = False
		Me.TxtPersonFirst.Size = New System.Drawing.Size(87, 21)
		Me.TxtPersonFirst.Location = New System.Drawing.Point(248, 26)
		Me.TxtPersonFirst.TabIndex = 2
		Me.TxtPersonFirst.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.TxtPersonFirst.AcceptsReturn = True
		Me.TxtPersonFirst.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me.TxtPersonFirst.BackColor = System.Drawing.SystemColors.Window
		Me.TxtPersonFirst.CausesValidation = True
		Me.TxtPersonFirst.Enabled = True
		Me.TxtPersonFirst.ForeColor = System.Drawing.SystemColors.WindowText
		Me.TxtPersonFirst.HideSelection = True
		Me.TxtPersonFirst.ReadOnly = False
		Me.TxtPersonFirst.Maxlength = 0
		Me.TxtPersonFirst.Cursor = System.Windows.Forms.Cursors.IBeam
		Me.TxtPersonFirst.MultiLine = False
		Me.TxtPersonFirst.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.TxtPersonFirst.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me.TxtPersonFirst.TabStop = True
		Me.TxtPersonFirst.Visible = True
		Me.TxtPersonFirst.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.TxtPersonFirst.Name = "TxtPersonFirst"
		Me.TxtOrganization.AutoSize = False
		Me.TxtOrganization.Size = New System.Drawing.Size(233, 21)
		Me.TxtOrganization.Location = New System.Drawing.Point(10, 26)
		Me.TxtOrganization.TabIndex = 0
		Me.TxtOrganization.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.TxtOrganization.AcceptsReturn = True
		Me.TxtOrganization.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me.TxtOrganization.BackColor = System.Drawing.SystemColors.Window
		Me.TxtOrganization.CausesValidation = True
		Me.TxtOrganization.Enabled = True
		Me.TxtOrganization.ForeColor = System.Drawing.SystemColors.WindowText
		Me.TxtOrganization.HideSelection = True
		Me.TxtOrganization.ReadOnly = False
		Me.TxtOrganization.Maxlength = 0
		Me.TxtOrganization.Cursor = System.Windows.Forms.Cursors.IBeam
		Me.TxtOrganization.MultiLine = False
		Me.TxtOrganization.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.TxtOrganization.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me.TxtOrganization.TabStop = True
		Me.TxtOrganization.Visible = True
		Me.TxtOrganization.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.TxtOrganization.Name = "TxtOrganization"
		Me.Label3.Text = "Last"
		Me.Label3.Size = New System.Drawing.Size(87, 15)
		Me.Label3.Location = New System.Drawing.Point(338, 10)
		Me.Label3.TabIndex = 10
		Me.Label3.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.Label3.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me.Label3.BackColor = System.Drawing.SystemColors.Control
		Me.Label3.Enabled = True
		Me.Label3.ForeColor = System.Drawing.SystemColors.ControlText
		Me.Label3.Cursor = System.Windows.Forms.Cursors.Default
		Me.Label3.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.Label3.UseMnemonic = True
		Me.Label3.Visible = True
		Me.Label3.AutoSize = False
		Me.Label3.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.Label3.Name = "Label3"
		Me.Label2.Text = "Person First"
		Me.Label2.Size = New System.Drawing.Size(91, 15)
		Me.Label2.Location = New System.Drawing.Point(248, 10)
		Me.Label2.TabIndex = 9
		Me.Label2.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.Label2.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me.Label2.BackColor = System.Drawing.SystemColors.Control
		Me.Label2.Enabled = True
		Me.Label2.ForeColor = System.Drawing.SystemColors.ControlText
		Me.Label2.Cursor = System.Windows.Forms.Cursors.Default
		Me.Label2.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.Label2.UseMnemonic = True
		Me.Label2.Visible = True
		Me.Label2.AutoSize = False
		Me.Label2.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.Label2.Name = "Label2"
		Me.Label1.Text = "Organization"
		Me.Label1.Size = New System.Drawing.Size(123, 15)
		Me.Label1.Location = New System.Drawing.Point(10, 10)
		Me.Label1.TabIndex = 8
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
		Me.Frame2.Size = New System.Drawing.Size(431, 185)
		Me.Frame2.Location = New System.Drawing.Point(2, 48)
		Me.Frame2.TabIndex = 7
		Me.Frame2.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.Frame2.BackColor = System.Drawing.SystemColors.Control
		Me.Frame2.Enabled = True
		Me.Frame2.ForeColor = System.Drawing.SystemColors.ControlText
		Me.Frame2.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.Frame2.Visible = True
		Me.Frame2.Padding = New System.Windows.Forms.Padding(0)
		Me.Frame2.Name = "Frame2"
		Me.LstPerson.Size = New System.Drawing.Size(177, 163)
		Me.LstPerson.Location = New System.Drawing.Point(248, 16)
		Me.LstPerson.Sorted = True
		Me.LstPerson.TabIndex = 4
		Me.LstPerson.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.LstPerson.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.LstPerson.BackColor = System.Drawing.SystemColors.Window
		Me.LstPerson.CausesValidation = True
		Me.LstPerson.Enabled = True
		Me.LstPerson.ForeColor = System.Drawing.SystemColors.WindowText
		Me.LstPerson.IntegralHeight = True
		Me.LstPerson.Cursor = System.Windows.Forms.Cursors.Default
		Me.LstPerson.SelectionMode = System.Windows.Forms.SelectionMode.One
		Me.LstPerson.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.LstPerson.TabStop = True
		Me.LstPerson.Visible = True
		Me.LstPerson.MultiColumn = False
		Me.LstPerson.Name = "LstPerson"
		Me.LstOrganization.Size = New System.Drawing.Size(233, 163)
		Me.LstOrganization.Location = New System.Drawing.Point(10, 16)
		Me.LstOrganization.TabIndex = 1
		Me.LstOrganization.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.LstOrganization.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.LstOrganization.BackColor = System.Drawing.SystemColors.Window
		Me.LstOrganization.CausesValidation = True
		Me.LstOrganization.Enabled = True
		Me.LstOrganization.ForeColor = System.Drawing.SystemColors.WindowText
		Me.LstOrganization.IntegralHeight = True
		Me.LstOrganization.Cursor = System.Windows.Forms.Cursors.Default
		Me.LstOrganization.SelectionMode = System.Windows.Forms.SelectionMode.One
		Me.LstOrganization.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.LstOrganization.Sorted = False
		Me.LstOrganization.TabStop = True
		Me.LstOrganization.Visible = True
		Me.LstOrganization.MultiColumn = False
		Me.LstOrganization.Name = "LstOrganization"
		Me.Controls.Add(CmdClose)
		Me.Controls.Add(Frame1)
		Me.Controls.Add(Frame2)
		Me.Frame1.Controls.Add(TxtPersonLast)
		Me.Frame1.Controls.Add(TxtPersonFirst)
		Me.Frame1.Controls.Add(TxtOrganization)
		Me.Frame1.Controls.Add(Label3)
		Me.Frame1.Controls.Add(Label2)
		Me.Frame1.Controls.Add(Label1)
		Me.Frame2.Controls.Add(LstPerson)
		Me.Frame2.Controls.Add(LstOrganization)
		Me.Frame1.ResumeLayout(False)
		Me.Frame2.ResumeLayout(False)
		Me.ResumeLayout(False)
		Me.PerformLayout()
	End Sub
#End Region 
End Class