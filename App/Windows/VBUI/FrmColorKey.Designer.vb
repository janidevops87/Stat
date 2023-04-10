<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmColorKey
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
	Public WithEvents TxtQAE As System.Windows.Forms.TextBox
	Public WithEvents txtUE As System.Windows.Forms.TextBox
	Public WithEvents txtPE As System.Windows.Forms.TextBox
	Public WithEvents txtOE As System.Windows.Forms.TextBox
	Public WithEvents _labelQAE_1 As System.Windows.Forms.Label
	Public WithEvents _labelUE_0 As System.Windows.Forms.Label
	Public WithEvents Label2 As System.Windows.Forms.Label
	Public WithEvents Label1 As System.Windows.Forms.Label
	Public WithEvents Frame1 As System.Windows.Forms.GroupBox
	Public WithEvents labelQAE As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
	Public WithEvents labelUE As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.Frame2 = New System.Windows.Forms.GroupBox
        Me.Label4 = New System.Windows.Forms.Label
        Me.Frame1 = New System.Windows.Forms.GroupBox
        Me.TxtQAE = New System.Windows.Forms.TextBox
        Me.txtUE = New System.Windows.Forms.TextBox
        Me.txtPE = New System.Windows.Forms.TextBox
        Me.txtOE = New System.Windows.Forms.TextBox
        Me._labelQAE_1 = New System.Windows.Forms.Label
        Me._labelUE_0 = New System.Windows.Forms.Label
        Me.Label2 = New System.Windows.Forms.Label
        Me.Label1 = New System.Windows.Forms.Label
        Me.labelQAE = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(Me.components)
        Me.labelUE = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(Me.components)
        Me.Frame2.SuspendLayout()
        Me.Frame1.SuspendLayout()
        CType(Me.labelQAE, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.labelUE, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'Frame2
        '
        Me.Frame2.BackColor = System.Drawing.SystemColors.Control
        Me.Frame2.Controls.Add(Me.Label4)
        Me.Frame2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Frame2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame2.Location = New System.Drawing.Point(24, 160)
        Me.Frame2.Name = "Frame2"
        Me.Frame2.Padding = New System.Windows.Forms.Padding(0)
        Me.Frame2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame2.Size = New System.Drawing.Size(249, 57)
        Me.Frame2.TabIndex = 7
        Me.Frame2.TabStop = False
        Me.Frame2.Text = "Word Style"
        '
        'Label4
        '
        Me.Label4.BackColor = System.Drawing.SystemColors.Control
        Me.Label4.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label4.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label4.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label4.Location = New System.Drawing.Point(16, 24)
        Me.Label4.Name = "Label4"
        Me.Label4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label4.Size = New System.Drawing.Size(217, 17)
        Me.Label4.TabIndex = 8
        Me.Label4.Text = "Bold - Less than 24 hours old"
        '
        'Frame1
        '
        Me.Frame1.BackColor = System.Drawing.SystemColors.Control
        Me.Frame1.Controls.Add(Me.TxtQAE)
        Me.Frame1.Controls.Add(Me.txtUE)
        Me.Frame1.Controls.Add(Me.txtPE)
        Me.Frame1.Controls.Add(Me.txtOE)
        Me.Frame1.Controls.Add(Me._labelQAE_1)
        Me.Frame1.Controls.Add(Me._labelUE_0)
        Me.Frame1.Controls.Add(Me.Label2)
        Me.Frame1.Controls.Add(Me.Label1)
        Me.Frame1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Frame1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame1.Location = New System.Drawing.Point(24, 16)
        Me.Frame1.Name = "Frame1"
        Me.Frame1.Padding = New System.Windows.Forms.Padding(0)
        Me.Frame1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame1.Size = New System.Drawing.Size(249, 137)
        Me.Frame1.TabIndex = 0
        Me.Frame1.TabStop = False
        Me.Frame1.Text = "Word Coloring"
        '
        'TxtQAE
        '
        Me.TxtQAE.AcceptsReturn = True
        Me.TxtQAE.BackColor = System.Drawing.Color.FromArgb(CType(CType(255, Byte), Integer), CType(CType(128, Byte), Integer), CType(CType(0, Byte), Integer))
        Me.TxtQAE.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtQAE.Enabled = False
        Me.TxtQAE.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtQAE.ForeColor = System.Drawing.Color.FromArgb(CType(CType(128, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(128, Byte), Integer))
        Me.TxtQAE.Location = New System.Drawing.Point(16, 96)
        Me.TxtQAE.MaxLength = 0
        Me.TxtQAE.Name = "TxtQAE"
        Me.TxtQAE.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtQAE.Size = New System.Drawing.Size(17, 19)
        Me.TxtQAE.TabIndex = 9
        '
        'txtUE
        '
        Me.txtUE.AcceptsReturn = True
        Me.txtUE.BackColor = System.Drawing.Color.FromArgb(CType(CType(0, Byte), Integer), CType(CType(192, Byte), Integer), CType(CType(0, Byte), Integer))
        Me.txtUE.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtUE.Enabled = False
        Me.txtUE.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtUE.ForeColor = System.Drawing.Color.FromArgb(CType(CType(128, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(128, Byte), Integer))
        Me.txtUE.Location = New System.Drawing.Point(16, 72)
        Me.txtUE.MaxLength = 0
        Me.txtUE.Name = "txtUE"
        Me.txtUE.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtUE.Size = New System.Drawing.Size(17, 19)
        Me.txtUE.TabIndex = 5
        '
        'txtPE
        '
        Me.txtPE.AcceptsReturn = True
        Me.txtPE.BackColor = System.Drawing.Color.White
        Me.txtPE.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtPE.Enabled = False
        Me.txtPE.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtPE.ForeColor = System.Drawing.Color.FromArgb(CType(CType(128, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(128, Byte), Integer))
        Me.txtPE.Location = New System.Drawing.Point(16, 24)
        Me.txtPE.MaxLength = 0
        Me.txtPE.Name = "txtPE"
        Me.txtPE.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtPE.Size = New System.Drawing.Size(17, 19)
        Me.txtPE.TabIndex = 3
        '
        'txtOE
        '
        Me.txtOE.AcceptsReturn = True
        Me.txtOE.BackColor = System.Drawing.Color.FromArgb(CType(CType(128, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(128, Byte), Integer))
        Me.txtOE.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtOE.Enabled = False
        Me.txtOE.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtOE.ForeColor = System.Drawing.Color.FromArgb(CType(CType(128, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(128, Byte), Integer))
        Me.txtOE.Location = New System.Drawing.Point(16, 48)
        Me.txtOE.MaxLength = 0
        Me.txtOE.Name = "txtOE"
        Me.txtOE.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtOE.Size = New System.Drawing.Size(17, 19)
        Me.txtOE.TabIndex = 1
        '
        '_labelQAE_1
        '
        Me._labelQAE_1.BackColor = System.Drawing.SystemColors.Control
        Me._labelQAE_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._labelQAE_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._labelQAE_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.labelQAE.SetIndex(Me._labelQAE_1, CType(1, Short))
        Me._labelQAE_1.Location = New System.Drawing.Point(40, 96)
        Me._labelQAE_1.Name = "_labelQAE_1"
        Me._labelQAE_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._labelQAE_1.Size = New System.Drawing.Size(169, 17)
        Me._labelQAE_1.TabIndex = 10
        Me._labelQAE_1.Text = "QA Review (QA)"
        '
        '_labelUE_0
        '
        Me._labelUE_0.BackColor = System.Drawing.SystemColors.Control
        Me._labelUE_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._labelUE_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._labelUE_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.labelUE.SetIndex(Me._labelUE_0, CType(0, Short))
        Me._labelUE_0.Location = New System.Drawing.Point(40, 72)
        Me._labelUE_0.Name = "_labelUE_0"
        Me._labelUE_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._labelUE_0.Size = New System.Drawing.Size(169, 17)
        Me._labelUE_0.TabIndex = 6
        Me._labelUE_0.Text = "CaseUpdate Event (U)"
        '
        'Label2
        '
        Me.Label2.BackColor = System.Drawing.SystemColors.Control
        Me.Label2.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label2.Location = New System.Drawing.Point(40, 24)
        Me.Label2.Name = "Label2"
        Me.Label2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label2.Size = New System.Drawing.Size(97, 17)
        Me.Label2.TabIndex = 4
        Me.Label2.Text = "Pending Event (P)"
        '
        'Label1
        '
        Me.Label1.BackColor = System.Drawing.SystemColors.Control
        Me.Label1.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label1.Location = New System.Drawing.Point(40, 48)
        Me.Label1.Name = "Label1"
        Me.Label1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label1.Size = New System.Drawing.Size(137, 17)
        Me.Label1.TabIndex = 2
        Me.Label1.Text = "OutCome Event (O)"
        '
        'FrmColorKey
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 14.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.ClientSize = New System.Drawing.Size(285, 233)
        Me.Controls.Add(Me.Frame2)
        Me.Controls.Add(Me.Frame1)
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Location = New System.Drawing.Point(4, 23)
        Me.Name = "FrmColorKey"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Text = "Event Log Color Key"
        Me.Frame2.ResumeLayout(False)
        Me.Frame1.ResumeLayout(False)
        CType(Me.labelQAE, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.labelUE, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)

    End Sub
#End Region 
End Class