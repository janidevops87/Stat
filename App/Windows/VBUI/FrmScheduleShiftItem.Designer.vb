<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmScheduleShiftItem
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
	Public WithEvents CboStartTime As System.Windows.Forms.ComboBox
	Public WithEvents CboEndTime As System.Windows.Forms.ComboBox
    Public WithEvents CboEndDate As Infragistics.Win.UltraWinSchedule.UltraCalendarCombo
    Public WithEvents CboStartDate As Infragistics.Win.UltraWinSchedule.UltraCalendarCombo
	Public WithEvents LblEndDay As System.Windows.Forms.Label
	Public WithEvents LblStartDay As System.Windows.Forms.Label
	Public WithEvents _Lable_7 As System.Windows.Forms.Label
	Public WithEvents _Lable_6 As System.Windows.Forms.Label
	Public WithEvents _Lable_1 As System.Windows.Forms.Label
	Public WithEvents _Lable_2 As System.Windows.Forms.Label
	Public WithEvents _Lable_3 As System.Windows.Forms.Label
	Public WithEvents _Lable_4 As System.Windows.Forms.Label
	Public WithEvents FraSingle As System.Windows.Forms.GroupBox
	Public WithEvents ChkRepeat As System.Windows.Forms.CheckBox
	Public WithEvents _ChkDay_1 As System.Windows.Forms.CheckBox
	Public WithEvents _ChkDay_7 As System.Windows.Forms.CheckBox
	Public WithEvents _ChkDay_6 As System.Windows.Forms.CheckBox
	Public WithEvents _ChkDay_5 As System.Windows.Forms.CheckBox
	Public WithEvents _ChkDay_4 As System.Windows.Forms.CheckBox
	Public WithEvents _ChkDay_3 As System.Windows.Forms.CheckBox
	Public WithEvents _ChkDay_2 As System.Windows.Forms.CheckBox
    Public WithEvents CboRepeatTo As Infragistics.Win.UltraWinSchedule.UltraCalendarCombo
	Public WithEvents LblRepeat As System.Windows.Forms.Label
	Public WithEvents FraRecurring As System.Windows.Forms.GroupBox
	Public WithEvents CmdOK As System.Windows.Forms.Button
	Public WithEvents CmdCancel As System.Windows.Forms.Button
	Public WithEvents ChkDay As Microsoft.VisualBasic.Compatibility.VB6.CheckBoxArray
	Public WithEvents Lable As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FrmScheduleShiftItem))
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.FraSingle = New System.Windows.Forms.GroupBox
        Me.TxtName = New System.Windows.Forms.TextBox
        Me.CboStartTime = New System.Windows.Forms.ComboBox
        Me.CboEndTime = New System.Windows.Forms.ComboBox
        Me.CboEndDate = New Infragistics.Win.UltraWinSchedule.UltraCalendarCombo
        Me.CboStartDate = New Infragistics.Win.UltraWinSchedule.UltraCalendarCombo
        Me.LblEndDay = New System.Windows.Forms.Label
        Me.LblStartDay = New System.Windows.Forms.Label
        Me._Lable_7 = New System.Windows.Forms.Label
        Me._Lable_6 = New System.Windows.Forms.Label
        Me._Lable_1 = New System.Windows.Forms.Label
        Me._Lable_2 = New System.Windows.Forms.Label
        Me._Lable_3 = New System.Windows.Forms.Label
        Me._Lable_4 = New System.Windows.Forms.Label
        Me.FraRecurring = New System.Windows.Forms.GroupBox
        Me.ChkRepeat = New System.Windows.Forms.CheckBox
        Me._ChkDay_1 = New System.Windows.Forms.CheckBox
        Me._ChkDay_7 = New System.Windows.Forms.CheckBox
        Me._ChkDay_6 = New System.Windows.Forms.CheckBox
        Me._ChkDay_5 = New System.Windows.Forms.CheckBox
        Me._ChkDay_4 = New System.Windows.Forms.CheckBox
        Me._ChkDay_3 = New System.Windows.Forms.CheckBox
        Me._ChkDay_2 = New System.Windows.Forms.CheckBox
        Me.CboRepeatTo = New Infragistics.Win.UltraWinSchedule.UltraCalendarCombo()
        Me.LblRepeat = New System.Windows.Forms.Label
        Me.CmdOK = New System.Windows.Forms.Button
        Me.CmdCancel = New System.Windows.Forms.Button
        Me.ChkDay = New Microsoft.VisualBasic.Compatibility.VB6.CheckBoxArray(Me.components)
        Me.Lable = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(Me.components)
        Me.FraSingle.SuspendLayout()
        CType(Me.CboEndDate, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.CboStartDate, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.FraRecurring.SuspendLayout()
        CType(Me.ChkDay, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.Lable, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'FraSingle
        '
        Me.FraSingle.BackColor = System.Drawing.SystemColors.Control
        Me.FraSingle.Controls.Add(Me.TxtName)
        Me.FraSingle.Controls.Add(Me.CboStartTime)
        Me.FraSingle.Controls.Add(Me.CboEndTime)
        Me.FraSingle.Controls.Add(Me.CboEndDate)
        Me.FraSingle.Controls.Add(Me.CboStartDate)
        Me.FraSingle.Controls.Add(Me.LblEndDay)
        Me.FraSingle.Controls.Add(Me.LblStartDay)
        Me.FraSingle.Controls.Add(Me._Lable_7)
        Me.FraSingle.Controls.Add(Me._Lable_6)
        Me.FraSingle.Controls.Add(Me._Lable_1)
        Me.FraSingle.Controls.Add(Me._Lable_2)
        Me.FraSingle.Controls.Add(Me._Lable_3)
        Me.FraSingle.Controls.Add(Me._Lable_4)
        Me.FraSingle.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FraSingle.ForeColor = System.Drawing.SystemColors.ControlText
        Me.FraSingle.Location = New System.Drawing.Point(2, 2)
        Me.FraSingle.Name = "FraSingle"
        Me.FraSingle.Padding = New System.Windows.Forms.Padding(0)
        Me.FraSingle.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.FraSingle.Size = New System.Drawing.Size(293, 115)
        Me.FraSingle.TabIndex = 17
        Me.FraSingle.TabStop = False
        Me.FraSingle.Text = "Shift"
        '
        'TxtName
        '
        Me.TxtName.AcceptsReturn = True
        Me.TxtName.BackColor = System.Drawing.SystemColors.Window
        Me.TxtName.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtName.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtName.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtName.Location = New System.Drawing.Point(60, 20)
        Me.TxtName.MaxLength = 10
        Me.TxtName.Name = "TxtName"
        Me.TxtName.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtName.Size = New System.Drawing.Size(90, 20)
        Me.TxtName.TabIndex = 0
        '
        'CboStartTime
        '
        Me.CboStartTime.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboStartTime.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboStartTime.BackColor = System.Drawing.SystemColors.Window
        Me.CboStartTime.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboStartTime.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboStartTime.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboStartTime.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboStartTime.Location = New System.Drawing.Point(154, 44)
        Me.CboStartTime.Name = "CboStartTime"
        Me.CboStartTime.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboStartTime.Size = New System.Drawing.Size(61, 22)
        Me.CboStartTime.Sorted = True
        Me.CboStartTime.TabIndex = 2
        '
        'CboEndTime
        '
        Me.CboEndTime.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboEndTime.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboEndTime.BackColor = System.Drawing.SystemColors.Window
        Me.CboEndTime.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboEndTime.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboEndTime.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboEndTime.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboEndTime.Location = New System.Drawing.Point(154, 70)
        Me.CboEndTime.Name = "CboEndTime"
        Me.CboEndTime.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboEndTime.Size = New System.Drawing.Size(61, 22)
        Me.CboEndTime.Sorted = True
        Me.CboEndTime.TabIndex = 4
        '
        'CboEndDate
        '
        Me.CboEndDate.Location = New System.Drawing.Point(60, 70)
        Me.CboEndDate.Name = "CboEndDate"
        Me.CboEndDate.NonAutoSizeHeight = 21
        Me.CboEndDate.Size = New System.Drawing.Size(91, 21)
        Me.CboEndDate.TabIndex = 3
        Me.CboEndDate.Value = New Date(2011, 6, 3, 0, 0, 0, 0)
        '
        'CboStartDate
        '
        Me.CboStartDate.Location = New System.Drawing.Point(60, 44)
        Me.CboStartDate.Name = "CboStartDate"
        Me.CboStartDate.NonAutoSizeHeight = 21
        Me.CboStartDate.Size = New System.Drawing.Size(91, 21)
        Me.CboStartDate.TabIndex = 1
        Me.CboStartDate.Value = New Date(2011, 6, 3, 0, 0, 0, 0)
        '
        'LblEndDay
        '
        Me.LblEndDay.BackColor = System.Drawing.SystemColors.Control
        Me.LblEndDay.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblEndDay.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblEndDay.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblEndDay.Location = New System.Drawing.Point(242, 74)
        Me.LblEndDay.Name = "LblEndDay"
        Me.LblEndDay.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblEndDay.Size = New System.Drawing.Size(37, 17)
        Me.LblEndDay.TabIndex = 26
        Me.LblEndDay.Text = "Day"
        '
        'LblStartDay
        '
        Me.LblStartDay.BackColor = System.Drawing.SystemColors.Control
        Me.LblStartDay.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblStartDay.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblStartDay.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblStartDay.Location = New System.Drawing.Point(242, 48)
        Me.LblStartDay.Name = "LblStartDay"
        Me.LblStartDay.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblStartDay.Size = New System.Drawing.Size(37, 17)
        Me.LblStartDay.TabIndex = 25
        Me.LblStartDay.Text = "Day"
        '
        '_Lable_7
        '
        Me._Lable_7.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_7.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_7.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_7, CType(7, Short))
        Me._Lable_7.Location = New System.Drawing.Point(218, 68)
        Me._Lable_7.Name = "_Lable_7"
        Me._Lable_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_7.Size = New System.Drawing.Size(15, 15)
        Me._Lable_7.TabIndex = 23
        Me._Lable_7.Text = "*"
        '
        '_Lable_6
        '
        Me._Lable_6.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_6.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_6.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_6, CType(6, Short))
        Me._Lable_6.Location = New System.Drawing.Point(218, 42)
        Me._Lable_6.Name = "_Lable_6"
        Me._Lable_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_6.Size = New System.Drawing.Size(15, 15)
        Me._Lable_6.TabIndex = 22
        Me._Lable_6.Text = "*"
        '
        '_Lable_1
        '
        Me._Lable_1.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_1, CType(1, Short))
        Me._Lable_1.Location = New System.Drawing.Point(8, 24)
        Me._Lable_1.Name = "_Lable_1"
        Me._Lable_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_1.Size = New System.Drawing.Size(41, 15)
        Me._Lable_1.TabIndex = 21
        Me._Lable_1.Text = "Name"
        '
        '_Lable_2
        '
        Me._Lable_2.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_2, CType(2, Short))
        Me._Lable_2.Location = New System.Drawing.Point(8, 48)
        Me._Lable_2.Name = "_Lable_2"
        Me._Lable_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_2.Size = New System.Drawing.Size(41, 15)
        Me._Lable_2.TabIndex = 20
        Me._Lable_2.Text = "Start"
        '
        '_Lable_3
        '
        Me._Lable_3.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_3.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_3, CType(3, Short))
        Me._Lable_3.Location = New System.Drawing.Point(8, 74)
        Me._Lable_3.Name = "_Lable_3"
        Me._Lable_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_3.Size = New System.Drawing.Size(33, 15)
        Me._Lable_3.TabIndex = 19
        Me._Lable_3.Text = "End"
        '
        '_Lable_4
        '
        Me._Lable_4.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_4.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_4.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_4, CType(4, Short))
        Me._Lable_4.Location = New System.Drawing.Point(60, 94)
        Me._Lable_4.Name = "_Lable_4"
        Me._Lable_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_4.Size = New System.Drawing.Size(171, 15)
        Me._Lable_4.TabIndex = 18
        Me._Lable_4.Text = "Run Time Text"
        '
        'FraRecurring
        '
        Me.FraRecurring.BackColor = System.Drawing.SystemColors.Control
        Me.FraRecurring.Controls.Add(Me.ChkRepeat)
        Me.FraRecurring.Controls.Add(Me._ChkDay_1)
        Me.FraRecurring.Controls.Add(Me._ChkDay_7)
        Me.FraRecurring.Controls.Add(Me._ChkDay_6)
        Me.FraRecurring.Controls.Add(Me._ChkDay_5)
        Me.FraRecurring.Controls.Add(Me._ChkDay_4)
        Me.FraRecurring.Controls.Add(Me._ChkDay_3)
        Me.FraRecurring.Controls.Add(Me._ChkDay_2)
        Me.FraRecurring.Controls.Add(Me.CboRepeatTo)
        Me.FraRecurring.Controls.Add(Me.LblRepeat)
        Me.FraRecurring.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FraRecurring.ForeColor = System.Drawing.SystemColors.ControlText
        Me.FraRecurring.Location = New System.Drawing.Point(2, 118)
        Me.FraRecurring.Name = "FraRecurring"
        Me.FraRecurring.Padding = New System.Windows.Forms.Padding(0)
        Me.FraRecurring.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.FraRecurring.Size = New System.Drawing.Size(293, 149)
        Me.FraRecurring.TabIndex = 16
        Me.FraRecurring.TabStop = False
        '
        'ChkRepeat
        '
        Me.ChkRepeat.BackColor = System.Drawing.SystemColors.Control
        Me.ChkRepeat.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkRepeat.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkRepeat.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkRepeat.Location = New System.Drawing.Point(8, 16)
        Me.ChkRepeat.Name = "ChkRepeat"
        Me.ChkRepeat.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkRepeat.Size = New System.Drawing.Size(114, 17)
        Me.ChkRepeat.TabIndex = 5
        Me.ChkRepeat.Text = "Repeat Shift"
        Me.ChkRepeat.UseVisualStyleBackColor = False
        '
        '_ChkDay_1
        '
        Me._ChkDay_1.BackColor = System.Drawing.SystemColors.Control
        Me._ChkDay_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._ChkDay_1.Enabled = False
        Me._ChkDay_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._ChkDay_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkDay.SetIndex(Me._ChkDay_1, CType(1, Short))
        Me._ChkDay_1.Location = New System.Drawing.Point(100, 104)
        Me._ChkDay_1.Name = "_ChkDay_1"
        Me._ChkDay_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._ChkDay_1.Size = New System.Drawing.Size(100, 17)
        Me._ChkDay_1.TabIndex = 12
        Me._ChkDay_1.Text = "Sunday"
        Me._ChkDay_1.UseVisualStyleBackColor = False
        '
        '_ChkDay_7
        '
        Me._ChkDay_7.BackColor = System.Drawing.SystemColors.Control
        Me._ChkDay_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._ChkDay_7.Enabled = False
        Me._ChkDay_7.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._ChkDay_7.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkDay.SetIndex(Me._ChkDay_7, CType(7, Short))
        Me._ChkDay_7.Location = New System.Drawing.Point(100, 86)
        Me._ChkDay_7.Name = "_ChkDay_7"
        Me._ChkDay_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._ChkDay_7.Size = New System.Drawing.Size(104, 17)
        Me._ChkDay_7.TabIndex = 11
        Me._ChkDay_7.Text = "Saturday"
        Me._ChkDay_7.UseVisualStyleBackColor = False
        '
        '_ChkDay_6
        '
        Me._ChkDay_6.BackColor = System.Drawing.SystemColors.Control
        Me._ChkDay_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._ChkDay_6.Enabled = False
        Me._ChkDay_6.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._ChkDay_6.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkDay.SetIndex(Me._ChkDay_6, CType(6, Short))
        Me._ChkDay_6.Location = New System.Drawing.Point(100, 68)
        Me._ChkDay_6.Name = "_ChkDay_6"
        Me._ChkDay_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._ChkDay_6.Size = New System.Drawing.Size(76, 17)
        Me._ChkDay_6.TabIndex = 10
        Me._ChkDay_6.Text = "Friday"
        Me._ChkDay_6.UseVisualStyleBackColor = False
        '
        '_ChkDay_5
        '
        Me._ChkDay_5.BackColor = System.Drawing.SystemColors.Control
        Me._ChkDay_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._ChkDay_5.Enabled = False
        Me._ChkDay_5.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._ChkDay_5.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkDay.SetIndex(Me._ChkDay_5, CType(5, Short))
        Me._ChkDay_5.Location = New System.Drawing.Point(8, 122)
        Me._ChkDay_5.Name = "_ChkDay_5"
        Me._ChkDay_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._ChkDay_5.Size = New System.Drawing.Size(76, 17)
        Me._ChkDay_5.TabIndex = 9
        Me._ChkDay_5.Text = "Thursday"
        Me._ChkDay_5.UseVisualStyleBackColor = False
        '
        '_ChkDay_4
        '
        Me._ChkDay_4.BackColor = System.Drawing.SystemColors.Control
        Me._ChkDay_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._ChkDay_4.Enabled = False
        Me._ChkDay_4.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._ChkDay_4.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkDay.SetIndex(Me._ChkDay_4, CType(4, Short))
        Me._ChkDay_4.Location = New System.Drawing.Point(8, 104)
        Me._ChkDay_4.Name = "_ChkDay_4"
        Me._ChkDay_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._ChkDay_4.Size = New System.Drawing.Size(84, 17)
        Me._ChkDay_4.TabIndex = 8
        Me._ChkDay_4.Text = "Wednesday"
        Me._ChkDay_4.UseVisualStyleBackColor = False
        '
        '_ChkDay_3
        '
        Me._ChkDay_3.BackColor = System.Drawing.SystemColors.Control
        Me._ChkDay_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._ChkDay_3.Enabled = False
        Me._ChkDay_3.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._ChkDay_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkDay.SetIndex(Me._ChkDay_3, CType(3, Short))
        Me._ChkDay_3.Location = New System.Drawing.Point(8, 86)
        Me._ChkDay_3.Name = "_ChkDay_3"
        Me._ChkDay_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._ChkDay_3.Size = New System.Drawing.Size(76, 17)
        Me._ChkDay_3.TabIndex = 7
        Me._ChkDay_3.Text = "Tuesday"
        Me._ChkDay_3.UseVisualStyleBackColor = False
        '
        '_ChkDay_2
        '
        Me._ChkDay_2.BackColor = System.Drawing.SystemColors.Control
        Me._ChkDay_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._ChkDay_2.Enabled = False
        Me._ChkDay_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._ChkDay_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkDay.SetIndex(Me._ChkDay_2, CType(2, Short))
        Me._ChkDay_2.Location = New System.Drawing.Point(8, 68)
        Me._ChkDay_2.Name = "_ChkDay_2"
        Me._ChkDay_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._ChkDay_2.Size = New System.Drawing.Size(76, 17)
        Me._ChkDay_2.TabIndex = 6
        Me._ChkDay_2.Text = "Monday"
        Me._ChkDay_2.UseVisualStyleBackColor = False
        '
        'CboRepeatTo
        '
        Me.CboRepeatTo.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboRepeatTo.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboRepeatTo.Location = New System.Drawing.Point(194, 40)
        Me.CboRepeatTo.Name = "CboRepeatTo"
        Me.CboRepeatTo.Size = New System.Drawing.Size(91, 22)
        Me.CboRepeatTo.TabIndex = 13
        '
        'LblRepeat
        '
        Me.LblRepeat.AutoSize = True
        Me.LblRepeat.BackColor = System.Drawing.SystemColors.Control
        Me.LblRepeat.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblRepeat.Enabled = False
        Me.LblRepeat.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblRepeat.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblRepeat.Location = New System.Drawing.Point(6, 44)
        Me.LblRepeat.Name = "LblRepeat"
        Me.LblRepeat.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblRepeat.Size = New System.Drawing.Size(190, 14)
        Me.LblRepeat.TabIndex = 24
        Me.LblRepeat.Text = "Repeat for each selected day through"
        '
        'CmdOK
        '
        Me.CmdOK.BackColor = System.Drawing.SystemColors.Control
        Me.CmdOK.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdOK.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdOK.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdOK.Location = New System.Drawing.Point(300, 8)
        Me.CmdOK.Name = "CmdOK"
        Me.CmdOK.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdOK.Size = New System.Drawing.Size(80, 21)
        Me.CmdOK.TabIndex = 14
        Me.CmdOK.Text = "&Save"
        Me.CmdOK.UseVisualStyleBackColor = False
        '
        'CmdCancel
        '
        Me.CmdCancel.BackColor = System.Drawing.SystemColors.Control
        Me.CmdCancel.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdCancel.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdCancel.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdCancel.Location = New System.Drawing.Point(300, 246)
        Me.CmdCancel.Name = "CmdCancel"
        Me.CmdCancel.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdCancel.Size = New System.Drawing.Size(80, 21)
        Me.CmdCancel.TabIndex = 15
        Me.CmdCancel.Text = "C&ancel"
        Me.CmdCancel.UseVisualStyleBackColor = False
        '
        'FrmScheduleShiftItem
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 14.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.ClientSize = New System.Drawing.Size(383, 271)
        Me.Controls.Add(Me.FraSingle)
        Me.Controls.Add(Me.FraRecurring)
        Me.Controls.Add(Me.CmdOK)
        Me.Controls.Add(Me.CmdCancel)
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Location = New System.Drawing.Point(294, 155)
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "FrmScheduleShiftItem"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.StartPosition = System.Windows.Forms.FormStartPosition.Manual
        Me.Text = "Shift"
        Me.FraSingle.ResumeLayout(False)
        Me.FraSingle.PerformLayout()
        CType(Me.CboEndDate, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.CboStartDate, System.ComponentModel.ISupportInitialize).EndInit()
        Me.FraRecurring.ResumeLayout(False)
        Me.FraRecurring.PerformLayout()
        CType(Me.ChkDay, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.Lable, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)

    End Sub
#End Region 
End Class