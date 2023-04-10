<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmNoCall
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
        'bret 1/4/2010 dll conversion Me.MdiParent = AppMain.ParentForm
        'bret 1/4/2010 dll conversion MdiParent.Show()
        'Me.MdiParent = StatTrac.MDIFormStatLine
        'StatTrac.MDIFormStatLine.Show
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
	Public WithEvents ChkExclusive As System.Windows.Forms.CheckBox
	Public WithEvents ChkTemp As System.Windows.Forms.CheckBox
	Public WithEvents CmdNoCallTypeDetail As System.Windows.Forms.Button
	Public WithEvents CboNoCallType As System.Windows.Forms.ComboBox
	Public WithEvents TxtDescription As System.Windows.Forms.RichTextBox
	Public WithEvents _LblCaller_7 As System.Windows.Forms.Label
	Public WithEvents _LblCaller_5 As System.Windows.Forms.Label
	Public WithEvents FraMessage As System.Windows.Forms.GroupBox
	Public WithEvents TimerTotalTime As System.Windows.Forms.Timer
	Public WithEvents CmdOK As System.Windows.Forms.Button
	Public WithEvents CmdCancel As System.Windows.Forms.Button
	Public WithEvents CboCallByEmployee As System.Windows.Forms.ComboBox
	Public WithEvents TxtTotalTimeCounter As System.Windows.Forms.TextBox
	Public WithEvents TxtCallDate As System.Windows.Forms.TextBox
	Public WithEvents LblTotalTime As System.Windows.Forms.Label
	Public WithEvents LblInitialCallDate As System.Windows.Forms.Label
	Public WithEvents LblBy As System.Windows.Forms.Label
	Public WithEvents FraInfo2 As System.Windows.Forms.GroupBox
	Public WithEvents VP_Timer As System.Windows.Forms.Timer
	Public WithEvents LblCaller As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FrmNoCall))
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.ChkExclusive = New System.Windows.Forms.CheckBox()
        Me.ChkTemp = New System.Windows.Forms.CheckBox()
        Me.FraMessage = New System.Windows.Forms.GroupBox()
        Me.CmdNoCallTypeDetail = New System.Windows.Forms.Button()
        Me.CboNoCallType = New System.Windows.Forms.ComboBox()
        Me.TxtDescription = New System.Windows.Forms.RichTextBox()
        Me._LblCaller_7 = New System.Windows.Forms.Label()
        Me._LblCaller_5 = New System.Windows.Forms.Label()
        Me.TimerTotalTime = New System.Windows.Forms.Timer(Me.components)
        Me.CmdOK = New System.Windows.Forms.Button()
        Me.CmdCancel = New System.Windows.Forms.Button()
        Me.FraInfo2 = New System.Windows.Forms.GroupBox()
        Me.CboCallByEmployee = New System.Windows.Forms.ComboBox()
        Me.TxtTotalTimeCounter = New System.Windows.Forms.TextBox()
        Me.TxtCallDate = New System.Windows.Forms.TextBox()
        Me.LblTotalTime = New System.Windows.Forms.Label()
        Me.LblInitialCallDate = New System.Windows.Forms.Label()
        Me.LblBy = New System.Windows.Forms.Label()
        Me.VP_Timer = New System.Windows.Forms.Timer(Me.components)
        Me.LblCaller = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(Me.components)
        Me.FraMessage.SuspendLayout()
        Me.FraInfo2.SuspendLayout()
        CType(Me.LblCaller, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'ChkExclusive
        '
        Me.ChkExclusive.BackColor = System.Drawing.SystemColors.Control
        Me.ChkExclusive.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkExclusive.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkExclusive.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkExclusive.Location = New System.Drawing.Point(432, 54)
        Me.ChkExclusive.Name = "ChkExclusive"
        Me.ChkExclusive.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkExclusive.Size = New System.Drawing.Size(77, 15)
        Me.ChkExclusive.TabIndex = 5
        Me.ChkExclusive.Text = "&Exclusive"
        Me.ChkExclusive.UseVisualStyleBackColor = False
        Me.ChkExclusive.Visible = False
        '
        'ChkTemp
        '
        Me.ChkTemp.BackColor = System.Drawing.SystemColors.Control
        Me.ChkTemp.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkTemp.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkTemp.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkTemp.Location = New System.Drawing.Point(432, 36)
        Me.ChkTemp.Name = "ChkTemp"
        Me.ChkTemp.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkTemp.Size = New System.Drawing.Size(77, 17)
        Me.ChkTemp.TabIndex = 5
        Me.ChkTemp.Text = "&Incomplete"
        Me.ChkTemp.UseVisualStyleBackColor = False
        Me.ChkTemp.Visible = False
        '
        'FraMessage
        '
        Me.FraMessage.BackColor = System.Drawing.SystemColors.Control
        Me.FraMessage.Controls.Add(Me.CmdNoCallTypeDetail)
        Me.FraMessage.Controls.Add(Me.CboNoCallType)
        Me.FraMessage.Controls.Add(Me.TxtDescription)
        Me.FraMessage.Controls.Add(Me._LblCaller_7)
        Me.FraMessage.Controls.Add(Me._LblCaller_5)
        Me.FraMessage.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FraMessage.ForeColor = System.Drawing.SystemColors.ControlText
        Me.FraMessage.Location = New System.Drawing.Point(4, 0)
        Me.FraMessage.Name = "FraMessage"
        Me.FraMessage.Padding = New System.Windows.Forms.Padding(0)
        Me.FraMessage.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.FraMessage.Size = New System.Drawing.Size(423, 151)
        Me.FraMessage.TabIndex = 5
        Me.FraMessage.TabStop = False
        Me.FraMessage.Text = "No Call Information"
        '
        'CmdNoCallTypeDetail
        '
        Me.CmdNoCallTypeDetail.BackColor = System.Drawing.SystemColors.Control
        Me.CmdNoCallTypeDetail.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdNoCallTypeDetail.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdNoCallTypeDetail.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdNoCallTypeDetail.Location = New System.Drawing.Point(286, 22)
        Me.CmdNoCallTypeDetail.Margin = New System.Windows.Forms.Padding(0, 3, 0, 3)
        Me.CmdNoCallTypeDetail.Name = "CmdNoCallTypeDetail"
        Me.CmdNoCallTypeDetail.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdNoCallTypeDetail.Size = New System.Drawing.Size(24, 21)
        Me.CmdNoCallTypeDetail.TabIndex = 1
        Me.CmdNoCallTypeDetail.Text = "..."
        Me.CmdNoCallTypeDetail.UseVisualStyleBackColor = False
        '
        'CboNoCallType
        '
        Me.CboNoCallType.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboNoCallType.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboNoCallType.BackColor = System.Drawing.SystemColors.Window
        Me.CboNoCallType.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboNoCallType.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboNoCallType.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboNoCallType.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboNoCallType.Location = New System.Drawing.Point(82, 22)
        Me.CboNoCallType.Name = "CboNoCallType"
        Me.CboNoCallType.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboNoCallType.Size = New System.Drawing.Size(201, 22)
        Me.CboNoCallType.Sorted = True
        Me.CboNoCallType.TabIndex = 0
        '
        'TxtDescription
        '
        Me.TxtDescription.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtDescription.Location = New System.Drawing.Point(16, 66)
        Me.TxtDescription.MaxLength = 254
        Me.TxtDescription.Name = "TxtDescription"
        Me.TxtDescription.RightMargin = 375
        Me.TxtDescription.ScrollBars = System.Windows.Forms.RichTextBoxScrollBars.Vertical
        Me.TxtDescription.Size = New System.Drawing.Size(397, 75)
        Me.TxtDescription.TabIndex = 2
        Me.TxtDescription.Text = ""
        '
        '_LblCaller_7
        '
        Me._LblCaller_7.BackColor = System.Drawing.SystemColors.Control
        Me._LblCaller_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblCaller_7.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LblCaller_7.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblCaller.SetIndex(Me._LblCaller_7, CType(7, Short))
        Me._LblCaller_7.Location = New System.Drawing.Point(16, 48)
        Me._LblCaller_7.Name = "_LblCaller_7"
        Me._LblCaller_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblCaller_7.Size = New System.Drawing.Size(93, 15)
        Me._LblCaller_7.TabIndex = 7
        Me._LblCaller_7.Text = "Call Description"
        '
        '_LblCaller_5
        '
        Me._LblCaller_5.AutoSize = True
        Me._LblCaller_5.BackColor = System.Drawing.SystemColors.Control
        Me._LblCaller_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblCaller_5.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LblCaller_5.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblCaller.SetIndex(Me._LblCaller_5, CType(5, Short))
        Me._LblCaller_5.Location = New System.Drawing.Point(14, 26)
        Me._LblCaller_5.Name = "_LblCaller_5"
        Me._LblCaller_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblCaller_5.Size = New System.Drawing.Size(66, 14)
        Me._LblCaller_5.TabIndex = 6
        Me._LblCaller_5.Text = "No Call Type"
        '
        'TimerTotalTime
        '
        Me.TimerTotalTime.Enabled = True
        Me.TimerTotalTime.Interval = 1000
        '
        'CmdOK
        '
        Me.CmdOK.BackColor = System.Drawing.SystemColors.Control
        Me.CmdOK.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdOK.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdOK.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdOK.Location = New System.Drawing.Point(432, 8)
        Me.CmdOK.Name = "CmdOK"
        Me.CmdOK.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdOK.Size = New System.Drawing.Size(80, 21)
        Me.CmdOK.TabIndex = 5
        Me.CmdOK.Text = "&Save"
        Me.CmdOK.UseVisualStyleBackColor = False
        '
        'CmdCancel
        '
        Me.CmdCancel.BackColor = System.Drawing.SystemColors.Control
        Me.CmdCancel.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdCancel.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdCancel.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdCancel.Location = New System.Drawing.Point(432, 158)
        Me.CmdCancel.Name = "CmdCancel"
        Me.CmdCancel.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdCancel.Size = New System.Drawing.Size(80, 21)
        Me.CmdCancel.TabIndex = 5
        Me.CmdCancel.Text = "&Cancel"
        Me.CmdCancel.UseVisualStyleBackColor = False
        '
        'FraInfo2
        '
        Me.FraInfo2.BackColor = System.Drawing.SystemColors.Control
        Me.FraInfo2.Controls.Add(Me.CboCallByEmployee)
        Me.FraInfo2.Controls.Add(Me.TxtTotalTimeCounter)
        Me.FraInfo2.Controls.Add(Me.TxtCallDate)
        Me.FraInfo2.Controls.Add(Me.LblTotalTime)
        Me.FraInfo2.Controls.Add(Me.LblInitialCallDate)
        Me.FraInfo2.Controls.Add(Me.LblBy)
        Me.FraInfo2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FraInfo2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.FraInfo2.Location = New System.Drawing.Point(4, 148)
        Me.FraInfo2.Name = "FraInfo2"
        Me.FraInfo2.Padding = New System.Windows.Forms.Padding(0)
        Me.FraInfo2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.FraInfo2.Size = New System.Drawing.Size(423, 34)
        Me.FraInfo2.TabIndex = 8
        Me.FraInfo2.TabStop = False
        '
        'CboCallByEmployee
        '
        Me.CboCallByEmployee.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboCallByEmployee.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboCallByEmployee.BackColor = System.Drawing.Color.FromArgb(CType(CType(192, Byte), Integer), CType(CType(192, Byte), Integer), CType(CType(192, Byte), Integer))
        Me.CboCallByEmployee.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboCallByEmployee.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboCallByEmployee.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboCallByEmployee.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboCallByEmployee.Location = New System.Drawing.Point(170, 10)
        Me.CboCallByEmployee.Name = "CboCallByEmployee"
        Me.CboCallByEmployee.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboCallByEmployee.Size = New System.Drawing.Size(113, 22)
        Me.CboCallByEmployee.TabIndex = 11
        Me.CboCallByEmployee.TabStop = False
        '
        'TxtTotalTimeCounter
        '
        Me.TxtTotalTimeCounter.AcceptsReturn = True
        Me.TxtTotalTimeCounter.BackColor = System.Drawing.Color.FromArgb(CType(CType(192, Byte), Integer), CType(CType(192, Byte), Integer), CType(CType(192, Byte), Integer))
        Me.TxtTotalTimeCounter.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtTotalTimeCounter.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtTotalTimeCounter.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtTotalTimeCounter.Location = New System.Drawing.Point(362, 10)
        Me.TxtTotalTimeCounter.MaxLength = 0
        Me.TxtTotalTimeCounter.Name = "TxtTotalTimeCounter"
        Me.TxtTotalTimeCounter.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtTotalTimeCounter.Size = New System.Drawing.Size(51, 20)
        Me.TxtTotalTimeCounter.TabIndex = 10
        Me.TxtTotalTimeCounter.TabStop = False
        Me.TxtTotalTimeCounter.Text = "00:00:00"
        '
        'TxtCallDate
        '
        Me.TxtCallDate.AcceptsReturn = True
        Me.TxtCallDate.BackColor = System.Drawing.Color.FromArgb(CType(CType(192, Byte), Integer), CType(CType(192, Byte), Integer), CType(CType(192, Byte), Integer))
        Me.TxtCallDate.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtCallDate.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtCallDate.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtCallDate.Location = New System.Drawing.Point(58, 10)
        Me.TxtCallDate.MaxLength = 0
        Me.TxtCallDate.Name = "TxtCallDate"
        Me.TxtCallDate.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtCallDate.Size = New System.Drawing.Size(87, 20)
        Me.TxtCallDate.TabIndex = 9
        Me.TxtCallDate.TabStop = False
        Me.TxtCallDate.Text = "00/00/00  00:00"
        '
        'LblTotalTime
        '
        Me.LblTotalTime.AutoSize = True
        Me.LblTotalTime.BackColor = System.Drawing.SystemColors.Control
        Me.LblTotalTime.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblTotalTime.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblTotalTime.ForeColor = System.Drawing.Color.Black
        Me.LblTotalTime.Location = New System.Drawing.Point(288, 13)
        Me.LblTotalTime.Name = "LblTotalTime"
        Me.LblTotalTime.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblTotalTime.Size = New System.Drawing.Size(74, 14)
        Me.LblTotalTime.TabIndex = 14
        Me.LblTotalTime.Text = "Total Call Time"
        '
        'LblInitialCallDate
        '
        Me.LblInitialCallDate.AutoSize = True
        Me.LblInitialCallDate.BackColor = System.Drawing.SystemColors.Control
        Me.LblInitialCallDate.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblInitialCallDate.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblInitialCallDate.ForeColor = System.Drawing.Color.Black
        Me.LblInitialCallDate.Location = New System.Drawing.Point(10, 13)
        Me.LblInitialCallDate.Name = "LblInitialCallDate"
        Me.LblInitialCallDate.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblInitialCallDate.Size = New System.Drawing.Size(49, 14)
        Me.LblInitialCallDate.TabIndex = 13
        Me.LblInitialCallDate.Text = "Call Date"
        '
        'LblBy
        '
        Me.LblBy.AutoSize = True
        Me.LblBy.BackColor = System.Drawing.SystemColors.Control
        Me.LblBy.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblBy.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblBy.ForeColor = System.Drawing.Color.Black
        Me.LblBy.Location = New System.Drawing.Point(152, 13)
        Me.LblBy.Name = "LblBy"
        Me.LblBy.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblBy.Size = New System.Drawing.Size(20, 14)
        Me.LblBy.TabIndex = 12
        Me.LblBy.Text = "By"
        '
        'VP_Timer
        '
        Me.VP_Timer.Interval = 30000
        '
        'FrmNoCall
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 14.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.ClientSize = New System.Drawing.Size(515, 186)
        Me.Controls.Add(Me.ChkExclusive)
        Me.Controls.Add(Me.ChkTemp)
        Me.Controls.Add(Me.FraMessage)
        Me.Controls.Add(Me.CmdOK)
        Me.Controls.Add(Me.CmdCancel)
        Me.Controls.Add(Me.FraInfo2)
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Location = New System.Drawing.Point(149, 199)
        Me.MaximizeBox = False
        Me.Name = "FrmNoCall"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "No Call - Call #"
        Me.FraMessage.ResumeLayout(False)
        Me.FraMessage.PerformLayout()
        Me.FraInfo2.ResumeLayout(False)
        Me.FraInfo2.PerformLayout()
        CType(Me.LblCaller, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)

    End Sub
#End Region
End Class