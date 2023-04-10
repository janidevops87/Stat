<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmScheduleShift
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
	Public WithEvents TxtEnd As System.Windows.Forms.TextBox
	Public WithEvents TxtStart As System.Windows.Forms.TextBox
	Public WithEvents TxtName As System.Windows.Forms.TextBox
	Public WithEvents CboDay As System.Windows.Forms.ComboBox
	Public WithEvents _Lable_4 As System.Windows.Forms.Label
	Public WithEvents _Lable_3 As System.Windows.Forms.Label
	Public WithEvents _Lable_2 As System.Windows.Forms.Label
	Public WithEvents _Lable_1 As System.Windows.Forms.Label
	Public WithEvents _Lable_0 As System.Windows.Forms.Label
	Public WithEvents Frame As System.Windows.Forms.GroupBox
	Public WithEvents CmdOK As System.Windows.Forms.Button
	Public WithEvents CmdCancel As System.Windows.Forms.Button
	Public WithEvents Lable As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FrmScheduleShift))
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.Frame = New System.Windows.Forms.GroupBox
        Me.TxtEnd = New System.Windows.Forms.TextBox
        Me.TxtStart = New System.Windows.Forms.TextBox
        Me.TxtName = New System.Windows.Forms.TextBox
        Me.CboDay = New System.Windows.Forms.ComboBox
        Me._Lable_4 = New System.Windows.Forms.Label
        Me._Lable_3 = New System.Windows.Forms.Label
        Me._Lable_2 = New System.Windows.Forms.Label
        Me._Lable_1 = New System.Windows.Forms.Label
        Me._Lable_0 = New System.Windows.Forms.Label
        Me.CmdOK = New System.Windows.Forms.Button
        Me.CmdCancel = New System.Windows.Forms.Button
        Me.Lable = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(Me.components)
        Me.Frame.SuspendLayout()
        CType(Me.Lable, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'Frame
        '
        Me.Frame.BackColor = System.Drawing.SystemColors.Control
        Me.Frame.Controls.Add(Me.TxtEnd)
        Me.Frame.Controls.Add(Me.TxtStart)
        Me.Frame.Controls.Add(Me.TxtName)
        Me.Frame.Controls.Add(Me.CboDay)
        Me.Frame.Controls.Add(Me._Lable_4)
        Me.Frame.Controls.Add(Me._Lable_3)
        Me.Frame.Controls.Add(Me._Lable_2)
        Me.Frame.Controls.Add(Me._Lable_1)
        Me.Frame.Controls.Add(Me._Lable_0)
        Me.Frame.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Frame.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.Location = New System.Drawing.Point(2, 0)
        Me.Frame.Name = "Frame"
        Me.Frame.Padding = New System.Windows.Forms.Padding(0)
        Me.Frame.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame.Size = New System.Drawing.Size(225, 115)
        Me.Frame.TabIndex = 6
        Me.Frame.TabStop = False
        '
        'TxtEnd
        '
        Me.TxtEnd.AcceptsReturn = True
        Me.TxtEnd.BackColor = System.Drawing.SystemColors.Window
        Me.TxtEnd.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtEnd.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtEnd.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtEnd.Location = New System.Drawing.Point(153, 66)
        Me.TxtEnd.MaxLength = 0
        Me.TxtEnd.Name = "TxtEnd"
        Me.TxtEnd.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtEnd.Size = New System.Drawing.Size(61, 21)
        Me.TxtEnd.TabIndex = 3
        '
        'TxtStart
        '
        Me.TxtStart.AcceptsReturn = True
        Me.TxtStart.BackColor = System.Drawing.SystemColors.Window
        Me.TxtStart.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtStart.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtStart.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtStart.Location = New System.Drawing.Point(51, 66)
        Me.TxtStart.MaxLength = 0
        Me.TxtStart.Name = "TxtStart"
        Me.TxtStart.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtStart.Size = New System.Drawing.Size(61, 21)
        Me.TxtStart.TabIndex = 2
        '
        'TxtName
        '
        Me.TxtName.AcceptsReturn = True
        Me.TxtName.BackColor = System.Drawing.SystemColors.Window
        Me.TxtName.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtName.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtName.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtName.Location = New System.Drawing.Point(51, 18)
        Me.TxtName.MaxLength = 50
        Me.TxtName.Name = "TxtName"
        Me.TxtName.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtName.Size = New System.Drawing.Size(164, 21)
        Me.TxtName.TabIndex = 0
        '
        'CboDay
        '
        Me.CboDay.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboDay.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboDay.BackColor = System.Drawing.SystemColors.Window
        Me.CboDay.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboDay.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboDay.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboDay.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboDay.Items.AddRange(New Object() {"Friday", "Monday", "Saturday", "Sunday", "Thursday", "Tuesday", "Wednesday"})
        Me.CboDay.Location = New System.Drawing.Point(51, 42)
        Me.CboDay.Name = "CboDay"
        Me.CboDay.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboDay.Size = New System.Drawing.Size(164, 22)
        Me.CboDay.TabIndex = 1
        '
        '_Lable_4
        '
        Me._Lable_4.AutoSize = True
        Me._Lable_4.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_4.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_4.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_4, CType(4, Short))
        Me._Lable_4.Location = New System.Drawing.Point(42, 92)
        Me._Lable_4.Name = "_Lable_4"
        Me._Lable_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_4.Size = New System.Drawing.Size(75, 14)
        Me._Lable_4.TabIndex = 11
        Me._Lable_4.Text = "Run Time Text"
        '
        '_Lable_3
        '
        Me._Lable_3.AutoSize = True
        Me._Lable_3.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_3.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_3, CType(3, Short))
        Me._Lable_3.Location = New System.Drawing.Point(126, 70)
        Me._Lable_3.Name = "_Lable_3"
        Me._Lable_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_3.Size = New System.Drawing.Size(25, 14)
        Me._Lable_3.TabIndex = 10
        Me._Lable_3.Text = "End"
        '
        '_Lable_2
        '
        Me._Lable_2.AutoSize = True
        Me._Lable_2.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_2, CType(2, Short))
        Me._Lable_2.Location = New System.Drawing.Point(18, 70)
        Me._Lable_2.Name = "_Lable_2"
        Me._Lable_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_2.Size = New System.Drawing.Size(30, 14)
        Me._Lable_2.TabIndex = 9
        Me._Lable_2.Text = "Start"
        '
        '_Lable_1
        '
        Me._Lable_1.AutoSize = True
        Me._Lable_1.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_1, CType(1, Short))
        Me._Lable_1.Location = New System.Drawing.Point(18, 22)
        Me._Lable_1.Name = "_Lable_1"
        Me._Lable_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_1.Size = New System.Drawing.Size(34, 14)
        Me._Lable_1.TabIndex = 8
        Me._Lable_1.Text = "Name"
        '
        '_Lable_0
        '
        Me._Lable_0.AutoSize = True
        Me._Lable_0.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_0, CType(0, Short))
        Me._Lable_0.Location = New System.Drawing.Point(18, 46)
        Me._Lable_0.Name = "_Lable_0"
        Me._Lable_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_0.Size = New System.Drawing.Size(26, 14)
        Me._Lable_0.TabIndex = 7
        Me._Lable_0.Text = "Day"
        '
        'CmdOK
        '
        Me.CmdOK.BackColor = System.Drawing.SystemColors.Control
        Me.CmdOK.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdOK.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdOK.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdOK.Location = New System.Drawing.Point(232, 8)
        Me.CmdOK.Name = "CmdOK"
        Me.CmdOK.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdOK.Size = New System.Drawing.Size(80, 21)
        Me.CmdOK.TabIndex = 4
        Me.CmdOK.Text = "&Save"
        Me.CmdOK.UseVisualStyleBackColor = False
        '
        'CmdCancel
        '
        Me.CmdCancel.BackColor = System.Drawing.SystemColors.Control
        Me.CmdCancel.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdCancel.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdCancel.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdCancel.Location = New System.Drawing.Point(232, 94)
        Me.CmdCancel.Name = "CmdCancel"
        Me.CmdCancel.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdCancel.Size = New System.Drawing.Size(80, 21)
        Me.CmdCancel.TabIndex = 5
        Me.CmdCancel.Text = "C&ancel"
        Me.CmdCancel.UseVisualStyleBackColor = False
        '
        'FrmScheduleShift
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 14.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.ClientSize = New System.Drawing.Size(315, 120)
        Me.Controls.Add(Me.Frame)
        Me.Controls.Add(Me.CmdOK)
        Me.Controls.Add(Me.CmdCancel)
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Location = New System.Drawing.Point(266, 445)
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "FrmScheduleShift"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.StartPosition = System.Windows.Forms.FormStartPosition.Manual
        Me.Text = "Shift"
        Me.Frame.ResumeLayout(False)
        Me.Frame.PerformLayout()
        CType(Me.Lable, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)

    End Sub
#End Region 
End Class