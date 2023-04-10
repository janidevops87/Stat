<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmConditional
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
	Public WithEvents Label4 As System.Windows.Forms.Label
	Public WithEvents Frame2 As System.Windows.Forms.GroupBox
	Public WithEvents cmdCancel As System.Windows.Forms.Button
	Public WithEvents cmdSelect As System.Windows.Forms.Button
	Public WithEvents cmdNewCondition As System.Windows.Forms.Button
	Public WithEvents cmdNewCriteria As System.Windows.Forms.Button
	Public WithEvents LstViewReason As System.Windows.Forms.ListView
	Public WithEvents LstViewCriteria As System.Windows.Forms.ListView
	Public WithEvents LstViewCondition As System.Windows.Forms.ListView
	Public WithEvents Label3 As System.Windows.Forms.Label
	Public WithEvents Label2 As System.Windows.Forms.Label
	Public WithEvents Label1 As System.Windows.Forms.Label
	Public WithEvents Frame1 As System.Windows.Forms.GroupBox
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
		Dim resources As System.Resources.ResourceManager = New System.Resources.ResourceManager(GetType(FrmConditional))
		Me.components = New System.ComponentModel.Container()
		Me.ToolTip1 = New System.Windows.Forms.ToolTip(components)
		Me.Frame2 = New System.Windows.Forms.GroupBox
		Me.Label4 = New System.Windows.Forms.Label
		Me.cmdCancel = New System.Windows.Forms.Button
		Me.cmdSelect = New System.Windows.Forms.Button
		Me.Frame1 = New System.Windows.Forms.GroupBox
		Me.cmdNewCondition = New System.Windows.Forms.Button
		Me.cmdNewCriteria = New System.Windows.Forms.Button
		Me.LstViewReason = New System.Windows.Forms.ListView
		Me.LstViewCriteria = New System.Windows.Forms.ListView
		Me.LstViewCondition = New System.Windows.Forms.ListView
		Me.Label3 = New System.Windows.Forms.Label
		Me.Label2 = New System.Windows.Forms.Label
		Me.Label1 = New System.Windows.Forms.Label
		Me.Frame2.SuspendLayout()
		Me.Frame1.SuspendLayout()
		Me.SuspendLayout()
		Me.ToolTip1.Active = True
		Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
		Me.Text = "Condition/Indication"
		Me.ClientSize = New System.Drawing.Size(688, 406)
		Me.Location = New System.Drawing.Point(3, 22)
		Me.MaximizeBox = False
		Me.MinimizeBox = False
		Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent
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
		Me.Name = "FrmConditional"
		Me.Frame2.Text = "Instructions"
		Me.Frame2.Size = New System.Drawing.Size(609, 57)
		Me.Frame2.Location = New System.Drawing.Point(0, 0)
		Me.Frame2.TabIndex = 11
		Me.Frame2.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.Frame2.BackColor = System.Drawing.SystemColors.Control
		Me.Frame2.Enabled = True
		Me.Frame2.ForeColor = System.Drawing.SystemColors.ControlText
		Me.Frame2.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.Frame2.Visible = True
		Me.Frame2.Padding = New System.Windows.Forms.Padding(0)
		Me.Frame2.Name = "Frame2"
		Me.Label4.Text = "Please select an Indication, R/O Reason, and Condition.  Click ""Select"" at the right to add to Criteria or Criteria Template.   You may add new Indications or Conditions by clicking the button to the right of each."
		Me.Label4.Size = New System.Drawing.Size(585, 33)
		Me.Label4.Location = New System.Drawing.Point(16, 16)
		Me.Label4.TabIndex = 12
		Me.Label4.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.Label4.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me.Label4.BackColor = System.Drawing.SystemColors.Control
		Me.Label4.Enabled = True
		Me.Label4.ForeColor = System.Drawing.SystemColors.ControlText
		Me.Label4.Cursor = System.Windows.Forms.Cursors.Default
		Me.Label4.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.Label4.UseMnemonic = True
		Me.Label4.Visible = True
		Me.Label4.AutoSize = False
		Me.Label4.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.Label4.Name = "Label4"
		Me.cmdCancel.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		Me.cmdCancel.Text = "Cancel"
		Me.cmdCancel.Size = New System.Drawing.Size(65, 25)
		Me.cmdCancel.Location = New System.Drawing.Point(616, 376)
		Me.cmdCancel.TabIndex = 5
		Me.cmdCancel.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.cmdCancel.BackColor = System.Drawing.SystemColors.Control
		Me.cmdCancel.CausesValidation = True
		Me.cmdCancel.Enabled = True
		Me.cmdCancel.ForeColor = System.Drawing.SystemColors.ControlText
		Me.cmdCancel.Cursor = System.Windows.Forms.Cursors.Default
		Me.cmdCancel.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.cmdCancel.TabStop = True
		Me.cmdCancel.Name = "cmdCancel"
		Me.cmdSelect.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		Me.cmdSelect.Text = "Select"
		Me.cmdSelect.Size = New System.Drawing.Size(65, 25)
		Me.cmdSelect.Location = New System.Drawing.Point(616, 8)
		Me.cmdSelect.TabIndex = 4
		Me.cmdSelect.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.cmdSelect.BackColor = System.Drawing.SystemColors.Control
		Me.cmdSelect.CausesValidation = True
		Me.cmdSelect.Enabled = True
		Me.cmdSelect.ForeColor = System.Drawing.SystemColors.ControlText
		Me.cmdSelect.Cursor = System.Windows.Forms.Cursors.Default
		Me.cmdSelect.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.cmdSelect.TabStop = True
		Me.cmdSelect.Name = "cmdSelect"
		Me.Frame1.Text = "Selections"
		Me.Frame1.Size = New System.Drawing.Size(609, 337)
		Me.Frame1.Location = New System.Drawing.Point(0, 64)
		Me.Frame1.TabIndex = 0
		Me.Frame1.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.Frame1.BackColor = System.Drawing.SystemColors.Control
		Me.Frame1.Enabled = True
		Me.Frame1.ForeColor = System.Drawing.SystemColors.ControlText
		Me.Frame1.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.Frame1.Visible = True
		Me.Frame1.Padding = New System.Windows.Forms.Padding(0)
		Me.Frame1.Name = "Frame1"
		Me.cmdNewCondition.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		Me.cmdNewCondition.Text = "..."
		Me.cmdNewCondition.Size = New System.Drawing.Size(41, 17)
		Me.cmdNewCondition.Location = New System.Drawing.Point(80, 183)
		Me.cmdNewCondition.TabIndex = 9
		Me.cmdNewCondition.TabStop = False
		Me.cmdNewCondition.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.cmdNewCondition.BackColor = System.Drawing.SystemColors.Control
		Me.cmdNewCondition.CausesValidation = True
		Me.cmdNewCondition.Enabled = True
		Me.cmdNewCondition.ForeColor = System.Drawing.SystemColors.ControlText
		Me.cmdNewCondition.Cursor = System.Windows.Forms.Cursors.Default
		Me.cmdNewCondition.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.cmdNewCondition.Name = "cmdNewCondition"
		Me.cmdNewCriteria.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		Me.cmdNewCriteria.Text = "..."
		Me.cmdNewCriteria.Size = New System.Drawing.Size(41, 17)
		Me.cmdNewCriteria.Location = New System.Drawing.Point(80, 23)
		Me.cmdNewCriteria.TabIndex = 8
		Me.cmdNewCriteria.TabStop = False
		Me.cmdNewCriteria.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.cmdNewCriteria.BackColor = System.Drawing.SystemColors.Control
		Me.cmdNewCriteria.CausesValidation = True
		Me.cmdNewCriteria.Enabled = True
		Me.cmdNewCriteria.ForeColor = System.Drawing.SystemColors.ControlText
		Me.cmdNewCriteria.Cursor = System.Windows.Forms.Cursors.Default
		Me.cmdNewCriteria.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.cmdNewCriteria.Name = "cmdNewCriteria"
		Me.LstViewReason.Size = New System.Drawing.Size(209, 129)
		Me.LstViewReason.Location = New System.Drawing.Point(392, 40)
		Me.LstViewReason.TabIndex = 2
		Me.LstViewReason.View = System.Windows.Forms.View.Details
		Me.LstViewReason.LabelEdit = False
		Me.LstViewReason.LabelWrap = False
		Me.LstViewReason.HideSelection = False
		Me.LstViewReason.ForeColor = System.Drawing.SystemColors.WindowText
		Me.LstViewReason.BackColor = System.Drawing.SystemColors.Window
		Me.LstViewReason.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.LstViewReason.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.LstViewReason.Name = "LstViewReason"
        Me.LstViewReason.FullRowSelect = True

        Me.LstViewCriteria.Size = New System.Drawing.Size(377, 129)
		Me.LstViewCriteria.Location = New System.Drawing.Point(8, 40)
		Me.LstViewCriteria.TabIndex = 1
		Me.LstViewCriteria.View = System.Windows.Forms.View.Details
		Me.LstViewCriteria.LabelEdit = False
		Me.LstViewCriteria.LabelWrap = False
		Me.LstViewCriteria.HideSelection = False
		Me.LstViewCriteria.ForeColor = System.Drawing.SystemColors.WindowText
		Me.LstViewCriteria.BackColor = System.Drawing.SystemColors.Window
		Me.LstViewCriteria.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.LstViewCriteria.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.LstViewCriteria.Name = "LstViewCriteria"
        Me.LstViewCriteria.FullRowSelect = True

		Me.LstViewCondition.Size = New System.Drawing.Size(593, 129)
		Me.LstViewCondition.Location = New System.Drawing.Point(8, 200)
		Me.LstViewCondition.TabIndex = 3
		Me.LstViewCondition.View = System.Windows.Forms.View.Details
		Me.LstViewCondition.LabelEdit = False
		Me.LstViewCondition.LabelWrap = False
		Me.LstViewCondition.HideSelection = False
		Me.LstViewCondition.ForeColor = System.Drawing.SystemColors.WindowText
		Me.LstViewCondition.BackColor = System.Drawing.SystemColors.Window
		Me.LstViewCondition.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.LstViewCondition.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.LstViewCondition.Name = "LstViewCondition"
        Me.LstViewCondition.FullRowSelect = True

		Me.Label3.Text = "2. R/O Reason"
		Me.Label3.Size = New System.Drawing.Size(145, 17)
		Me.Label3.Location = New System.Drawing.Point(392, 24)
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
		Me.Label2.Text = "1. Indication"
		Me.Label2.Size = New System.Drawing.Size(65, 17)
		Me.Label2.Location = New System.Drawing.Point(8, 24)
		Me.Label2.TabIndex = 7
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
		Me.Label1.Text = "3. Condition"
		Me.Label1.Size = New System.Drawing.Size(65, 17)
		Me.Label1.Location = New System.Drawing.Point(16, 184)
		Me.Label1.TabIndex = 6
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
		Me.Controls.Add(Frame2)
		Me.Controls.Add(cmdCancel)
		Me.Controls.Add(cmdSelect)
		Me.Controls.Add(Frame1)
		Me.Frame2.Controls.Add(Label4)
		Me.Frame1.Controls.Add(cmdNewCondition)
		Me.Frame1.Controls.Add(cmdNewCriteria)
		Me.Frame1.Controls.Add(LstViewReason)
		Me.Frame1.Controls.Add(LstViewCriteria)
		Me.Frame1.Controls.Add(LstViewCondition)
		Me.Frame1.Controls.Add(Label3)
		Me.Frame1.Controls.Add(Label2)
		Me.Frame1.Controls.Add(Label1)
		Me.Frame2.ResumeLayout(False)
		Me.Frame1.ResumeLayout(False)
		Me.ResumeLayout(False)
		Me.PerformLayout()
	End Sub
#End Region 
End Class