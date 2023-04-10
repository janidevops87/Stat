<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmIndicationSelect
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
	Public WithEvents CmdEdit As System.Windows.Forms.Button
	Public WithEvents CmdAdd As System.Windows.Forms.Button
	Public WithEvents CmdOK As System.Windows.Forms.Button
	Public WithEvents CmdCancel As System.Windows.Forms.Button
	Public WithEvents LstViewIndication As System.Windows.Forms.ListView
	Public WithEvents Frame As System.Windows.Forms.GroupBox
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FrmIndicationSelect))
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.CmdEdit = New System.Windows.Forms.Button
        Me.CmdAdd = New System.Windows.Forms.Button
        Me.CmdOK = New System.Windows.Forms.Button
        Me.CmdCancel = New System.Windows.Forms.Button
        Me.Frame = New System.Windows.Forms.GroupBox
        Me.LstViewIndication = New System.Windows.Forms.ListView
        Me.Frame.SuspendLayout()
        Me.SuspendLayout()
        '
        'CmdEdit
        '
        Me.CmdEdit.BackColor = System.Drawing.SystemColors.Control
        Me.CmdEdit.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdEdit.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdEdit.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdEdit.Location = New System.Drawing.Point(308, 148)
        Me.CmdEdit.Name = "CmdEdit"
        Me.CmdEdit.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdEdit.Size = New System.Drawing.Size(80, 21)
        Me.CmdEdit.TabIndex = 2
        Me.CmdEdit.Text = "&Edit..."
        Me.CmdEdit.UseVisualStyleBackColor = False
        '
        'CmdAdd
        '
        Me.CmdAdd.BackColor = System.Drawing.SystemColors.Control
        Me.CmdAdd.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdAdd.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdAdd.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdAdd.Location = New System.Drawing.Point(308, 122)
        Me.CmdAdd.Name = "CmdAdd"
        Me.CmdAdd.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdAdd.Size = New System.Drawing.Size(80, 21)
        Me.CmdAdd.TabIndex = 1
        Me.CmdAdd.Text = "&Add..."
        Me.CmdAdd.UseVisualStyleBackColor = False
        '
        'CmdOK
        '
        Me.CmdOK.BackColor = System.Drawing.SystemColors.Control
        Me.CmdOK.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdOK.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdOK.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdOK.Location = New System.Drawing.Point(308, 7)
        Me.CmdOK.Name = "CmdOK"
        Me.CmdOK.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdOK.Size = New System.Drawing.Size(80, 21)
        Me.CmdOK.TabIndex = 0
        Me.CmdOK.Text = "&Select"
        Me.CmdOK.UseVisualStyleBackColor = False
        '
        'CmdCancel
        '
        Me.CmdCancel.BackColor = System.Drawing.SystemColors.Control
        Me.CmdCancel.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdCancel.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdCancel.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdCancel.Location = New System.Drawing.Point(310, 268)
        Me.CmdCancel.Name = "CmdCancel"
        Me.CmdCancel.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdCancel.Size = New System.Drawing.Size(80, 21)
        Me.CmdCancel.TabIndex = 3
        Me.CmdCancel.Text = "&Close"
        Me.CmdCancel.UseVisualStyleBackColor = False
        '
        'Frame
        '
        Me.Frame.BackColor = System.Drawing.SystemColors.Control
        Me.Frame.Controls.Add(Me.LstViewIndication)
        Me.Frame.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Frame.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.Location = New System.Drawing.Point(2, 0)
        Me.Frame.Name = "Frame"
        Me.Frame.Padding = New System.Windows.Forms.Padding(0)
        Me.Frame.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame.Size = New System.Drawing.Size(301, 289)
        Me.Frame.TabIndex = 4
        Me.Frame.TabStop = False
        '
        'LstViewIndication
        '
        Me.LstViewIndication.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewIndication.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewIndication.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewIndication.FullRowSelect = True
        Me.LstViewIndication.HideSelection = False
        Me.LstViewIndication.LabelWrap = False
        Me.LstViewIndication.Location = New System.Drawing.Point(8, 16)
        Me.LstViewIndication.Name = "LstViewIndication"
        Me.LstViewIndication.Size = New System.Drawing.Size(285, 265)
        Me.LstViewIndication.TabIndex = 5
        Me.LstViewIndication.UseCompatibleStateImageBehavior = False
        Me.LstViewIndication.View = System.Windows.Forms.View.Details
        '
        'FrmIndicationSelect
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 14.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.ClientSize = New System.Drawing.Size(392, 294)
        Me.Controls.Add(Me.CmdEdit)
        Me.Controls.Add(Me.CmdAdd)
        Me.Controls.Add(Me.CmdOK)
        Me.Controls.Add(Me.CmdCancel)
        Me.Controls.Add(Me.Frame)
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Location = New System.Drawing.Point(168, 217)
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "FrmIndicationSelect"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.StartPosition = System.Windows.Forms.FormStartPosition.Manual
        Me.Text = "Select Medical Ruleout"
        Me.Frame.ResumeLayout(False)
        Me.ResumeLayout(False)

    End Sub
#End Region 
End Class