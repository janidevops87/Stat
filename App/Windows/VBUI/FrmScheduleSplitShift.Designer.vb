<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmScheduleSplitShift
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
	Public WithEvents CboStartTime As System.Windows.Forms.ComboBox
	Public WithEvents TxtEndName As System.Windows.Forms.TextBox
    Public WithEvents CboStartDate As Infragistics.Win.UltraWinSchedule.UltraCalendarCombo
	Public WithEvents LblEnd2Day As System.Windows.Forms.Label
	Public WithEvents LblStart2Day As System.Windows.Forms.Label
	Public WithEvents LblEndTime As System.Windows.Forms.Label
	Public WithEvents LblEndDate As System.Windows.Forms.Label
	Public WithEvents _Lable_12 As System.Windows.Forms.Label
	Public WithEvents _Lable_11 As System.Windows.Forms.Label
	Public WithEvents _Lable_10 As System.Windows.Forms.Label
	Public WithEvents _Lable_9 As System.Windows.Forms.Label
	Public WithEvents _Lable_8 As System.Windows.Forms.Label
	Public WithEvents Frame1 As System.Windows.Forms.GroupBox
	Public WithEvents TxtStartName As System.Windows.Forms.TextBox
	Public WithEvents CboEndTime As System.Windows.Forms.ComboBox
    Public WithEvents CboEndDate As Infragistics.Win.UltraWinSchedule.UltraCalendarCombo
	Public WithEvents LblEnd1Day As System.Windows.Forms.Label
	Public WithEvents LblStart1Day As System.Windows.Forms.Label
	Public WithEvents LblStartTime As System.Windows.Forms.Label
	Public WithEvents LblStartDate As System.Windows.Forms.Label
	Public WithEvents _Lable_7 As System.Windows.Forms.Label
	Public WithEvents _Lable_1 As System.Windows.Forms.Label
	Public WithEvents _Lable_2 As System.Windows.Forms.Label
	Public WithEvents _Lable_3 As System.Windows.Forms.Label
	Public WithEvents _Lable_4 As System.Windows.Forms.Label
	Public WithEvents FraSingle As System.Windows.Forms.GroupBox
	Public WithEvents CmdOK As System.Windows.Forms.Button
	Public WithEvents CmdCancel As System.Windows.Forms.Button
	Public WithEvents Lable As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FrmScheduleSplitShift))
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.Frame1 = New System.Windows.Forms.GroupBox
        Me.CboStartTime = New System.Windows.Forms.ComboBox
        Me.TxtEndName = New System.Windows.Forms.TextBox
        Me.CboStartDate = New Infragistics.Win.UltraWinSchedule.UltraCalendarCombo
        Me.LblEnd2Day = New System.Windows.Forms.Label
        Me.LblStart2Day = New System.Windows.Forms.Label
        Me.LblEndTime = New System.Windows.Forms.Label
        Me.LblEndDate = New System.Windows.Forms.Label
        Me._Lable_12 = New System.Windows.Forms.Label
        Me._Lable_11 = New System.Windows.Forms.Label
        Me._Lable_10 = New System.Windows.Forms.Label
        Me._Lable_9 = New System.Windows.Forms.Label
        Me._Lable_8 = New System.Windows.Forms.Label
        Me.FraSingle = New System.Windows.Forms.GroupBox
        Me.TxtStartName = New System.Windows.Forms.TextBox
        Me.CboEndTime = New System.Windows.Forms.ComboBox
        Me.CboEndDate = New Infragistics.Win.UltraWinSchedule.UltraCalendarCombo
        Me.LblEnd1Day = New System.Windows.Forms.Label
        Me.LblStart1Day = New System.Windows.Forms.Label
        Me.LblStartTime = New System.Windows.Forms.Label
        Me.LblStartDate = New System.Windows.Forms.Label
        Me._Lable_7 = New System.Windows.Forms.Label
        Me._Lable_1 = New System.Windows.Forms.Label
        Me._Lable_2 = New System.Windows.Forms.Label
        Me._Lable_3 = New System.Windows.Forms.Label
        Me._Lable_4 = New System.Windows.Forms.Label
        Me.CmdOK = New System.Windows.Forms.Button
        Me.CmdCancel = New System.Windows.Forms.Button
        Me.Lable = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(Me.components)
        Me.Frame1.SuspendLayout()
        CType(Me.CboStartDate, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.FraSingle.SuspendLayout()
        CType(Me.CboEndDate, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.Lable, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'Frame1
        '
        Me.Frame1.BackColor = System.Drawing.SystemColors.Control
        Me.Frame1.Controls.Add(Me.CboStartTime)
        Me.Frame1.Controls.Add(Me.TxtEndName)
        Me.Frame1.Controls.Add(Me.CboStartDate)
        Me.Frame1.Controls.Add(Me.LblEnd2Day)
        Me.Frame1.Controls.Add(Me.LblStart2Day)
        Me.Frame1.Controls.Add(Me.LblEndTime)
        Me.Frame1.Controls.Add(Me.LblEndDate)
        Me.Frame1.Controls.Add(Me._Lable_12)
        Me.Frame1.Controls.Add(Me._Lable_11)
        Me.Frame1.Controls.Add(Me._Lable_10)
        Me.Frame1.Controls.Add(Me._Lable_9)
        Me.Frame1.Controls.Add(Me._Lable_8)
        Me.Frame1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Frame1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame1.Location = New System.Drawing.Point(2, 126)
        Me.Frame1.Name = "Frame1"
        Me.Frame1.Padding = New System.Windows.Forms.Padding(0)
        Me.Frame1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame1.Size = New System.Drawing.Size(311, 119)
        Me.Frame1.TabIndex = 14
        Me.Frame1.TabStop = False
        Me.Frame1.Text = "End Split"
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
        Me.CboStartTime.Location = New System.Drawing.Point(154, 48)
        Me.CboStartTime.Name = "CboStartTime"
        Me.CboStartTime.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboStartTime.Size = New System.Drawing.Size(61, 22)
        Me.CboStartTime.Sorted = True
        Me.CboStartTime.TabIndex = 5
        '
        'TxtEndName
        '
        Me.TxtEndName.AcceptsReturn = True
        Me.TxtEndName.BackColor = System.Drawing.SystemColors.Window
        Me.TxtEndName.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtEndName.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtEndName.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtEndName.Location = New System.Drawing.Point(60, 20)
        Me.TxtEndName.MaxLength = 50
        Me.TxtEndName.Name = "TxtEndName"
        Me.TxtEndName.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtEndName.Size = New System.Drawing.Size(154, 20)
        Me.TxtEndName.TabIndex = 3
        '
        'CboStartDate
        '
        Me.CboStartDate.Location = New System.Drawing.Point(60, 48)
        Me.CboStartDate.Name = "CboStartDate"
        Me.CboStartDate.NonAutoSizeHeight = 21
        Me.CboStartDate.Size = New System.Drawing.Size(91, 21)
        Me.CboStartDate.TabIndex = 4
        '
        'LblEnd2Day
        '
        Me.LblEnd2Day.BackColor = System.Drawing.SystemColors.Control
        Me.LblEnd2Day.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblEnd2Day.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblEnd2Day.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblEnd2Day.Location = New System.Drawing.Point(250, 78)
        Me.LblEnd2Day.Name = "LblEnd2Day"
        Me.LblEnd2Day.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblEnd2Day.Size = New System.Drawing.Size(37, 17)
        Me.LblEnd2Day.TabIndex = 27
        Me.LblEnd2Day.Text = "Day"
        '
        'LblStart2Day
        '
        Me.LblStart2Day.BackColor = System.Drawing.SystemColors.Control
        Me.LblStart2Day.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblStart2Day.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblStart2Day.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblStart2Day.Location = New System.Drawing.Point(250, 52)
        Me.LblStart2Day.Name = "LblStart2Day"
        Me.LblStart2Day.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblStart2Day.Size = New System.Drawing.Size(37, 17)
        Me.LblStart2Day.TabIndex = 26
        Me.LblStart2Day.Text = "Day"
        '
        'LblEndTime
        '
        Me.LblEndTime.BackColor = System.Drawing.SystemColors.Control
        Me.LblEndTime.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblEndTime.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblEndTime.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblEndTime.Location = New System.Drawing.Point(156, 78)
        Me.LblEndTime.Name = "LblEndTime"
        Me.LblEndTime.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblEndTime.Size = New System.Drawing.Size(67, 21)
        Me.LblEndTime.TabIndex = 23
        Me.LblEndTime.Text = "hh:nn"
        '
        'LblEndDate
        '
        Me.LblEndDate.BackColor = System.Drawing.SystemColors.Control
        Me.LblEndDate.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblEndDate.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblEndDate.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblEndDate.Location = New System.Drawing.Point(60, 78)
        Me.LblEndDate.Name = "LblEndDate"
        Me.LblEndDate.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblEndDate.Size = New System.Drawing.Size(77, 15)
        Me.LblEndDate.TabIndex = 21
        Me.LblEndDate.Text = "mm/dd/yy"
        '
        '_Lable_12
        '
        Me._Lable_12.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_12.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_12.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_12.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_12, CType(12, Short))
        Me._Lable_12.Location = New System.Drawing.Point(60, 96)
        Me._Lable_12.Name = "_Lable_12"
        Me._Lable_12.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_12.Size = New System.Drawing.Size(171, 15)
        Me._Lable_12.TabIndex = 19
        Me._Lable_12.Text = "RunTime Text"
        '
        '_Lable_11
        '
        Me._Lable_11.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_11.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_11.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_11.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_11, CType(11, Short))
        Me._Lable_11.Location = New System.Drawing.Point(8, 78)
        Me._Lable_11.Name = "_Lable_11"
        Me._Lable_11.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_11.Size = New System.Drawing.Size(33, 15)
        Me._Lable_11.TabIndex = 18
        Me._Lable_11.Text = "End"
        '
        '_Lable_10
        '
        Me._Lable_10.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_10.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_10.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_10.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_10, CType(10, Short))
        Me._Lable_10.Location = New System.Drawing.Point(8, 52)
        Me._Lable_10.Name = "_Lable_10"
        Me._Lable_10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_10.Size = New System.Drawing.Size(41, 15)
        Me._Lable_10.TabIndex = 17
        Me._Lable_10.Text = "Start"
        '
        '_Lable_9
        '
        Me._Lable_9.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_9.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_9.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_9.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_9, CType(9, Short))
        Me._Lable_9.Location = New System.Drawing.Point(8, 24)
        Me._Lable_9.Name = "_Lable_9"
        Me._Lable_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_9.Size = New System.Drawing.Size(41, 15)
        Me._Lable_9.TabIndex = 16
        Me._Lable_9.Text = "Name"
        '
        '_Lable_8
        '
        Me._Lable_8.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_8.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_8.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_8.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_8, CType(8, Short))
        Me._Lable_8.Location = New System.Drawing.Point(218, 46)
        Me._Lable_8.Name = "_Lable_8"
        Me._Lable_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_8.Size = New System.Drawing.Size(15, 15)
        Me._Lable_8.TabIndex = 15
        Me._Lable_8.Text = "*"
        '
        'FraSingle
        '
        Me.FraSingle.BackColor = System.Drawing.SystemColors.Control
        Me.FraSingle.Controls.Add(Me.TxtStartName)
        Me.FraSingle.Controls.Add(Me.CboEndTime)
        Me.FraSingle.Controls.Add(Me.CboEndDate)
        Me.FraSingle.Controls.Add(Me.LblEnd1Day)
        Me.FraSingle.Controls.Add(Me.LblStart1Day)
        Me.FraSingle.Controls.Add(Me.LblStartTime)
        Me.FraSingle.Controls.Add(Me.LblStartDate)
        Me.FraSingle.Controls.Add(Me._Lable_7)
        Me.FraSingle.Controls.Add(Me._Lable_1)
        Me.FraSingle.Controls.Add(Me._Lable_2)
        Me.FraSingle.Controls.Add(Me._Lable_3)
        Me.FraSingle.Controls.Add(Me._Lable_4)
        Me.FraSingle.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FraSingle.ForeColor = System.Drawing.SystemColors.ControlText
        Me.FraSingle.Location = New System.Drawing.Point(2, 4)
        Me.FraSingle.Name = "FraSingle"
        Me.FraSingle.Padding = New System.Windows.Forms.Padding(0)
        Me.FraSingle.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.FraSingle.Size = New System.Drawing.Size(311, 119)
        Me.FraSingle.TabIndex = 8
        Me.FraSingle.TabStop = False
        Me.FraSingle.Text = "Start Split"
        '
        'TxtStartName
        '
        Me.TxtStartName.AcceptsReturn = True
        Me.TxtStartName.BackColor = System.Drawing.SystemColors.Window
        Me.TxtStartName.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtStartName.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtStartName.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtStartName.Location = New System.Drawing.Point(60, 20)
        Me.TxtStartName.MaxLength = 50
        Me.TxtStartName.Name = "TxtStartName"
        Me.TxtStartName.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtStartName.Size = New System.Drawing.Size(154, 20)
        Me.TxtStartName.TabIndex = 0
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
        Me.CboEndTime.Location = New System.Drawing.Point(154, 74)
        Me.CboEndTime.Name = "CboEndTime"
        Me.CboEndTime.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboEndTime.Size = New System.Drawing.Size(61, 22)
        Me.CboEndTime.Sorted = True
        Me.CboEndTime.TabIndex = 2
        '
        'CboEndDate
        '
        Me.CboEndDate.Location = New System.Drawing.Point(60, 74)
        Me.CboEndDate.Name = "CboEndDate"
        Me.CboEndDate.NonAutoSizeHeight = 21
        Me.CboEndDate.Size = New System.Drawing.Size(89, 21)
        Me.CboEndDate.TabIndex = 1
        '
        'LblEnd1Day
        '
        Me.LblEnd1Day.BackColor = System.Drawing.SystemColors.Control
        Me.LblEnd1Day.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblEnd1Day.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblEnd1Day.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblEnd1Day.Location = New System.Drawing.Point(250, 78)
        Me.LblEnd1Day.Name = "LblEnd1Day"
        Me.LblEnd1Day.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblEnd1Day.Size = New System.Drawing.Size(37, 17)
        Me.LblEnd1Day.TabIndex = 25
        Me.LblEnd1Day.Text = "Day"
        '
        'LblStart1Day
        '
        Me.LblStart1Day.BackColor = System.Drawing.SystemColors.Control
        Me.LblStart1Day.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblStart1Day.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblStart1Day.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblStart1Day.Location = New System.Drawing.Point(250, 52)
        Me.LblStart1Day.Name = "LblStart1Day"
        Me.LblStart1Day.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblStart1Day.Size = New System.Drawing.Size(37, 17)
        Me.LblStart1Day.TabIndex = 24
        Me.LblStart1Day.Text = "Day"
        '
        'LblStartTime
        '
        Me.LblStartTime.BackColor = System.Drawing.SystemColors.Control
        Me.LblStartTime.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblStartTime.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblStartTime.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblStartTime.Location = New System.Drawing.Point(156, 52)
        Me.LblStartTime.Name = "LblStartTime"
        Me.LblStartTime.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblStartTime.Size = New System.Drawing.Size(67, 21)
        Me.LblStartTime.TabIndex = 22
        Me.LblStartTime.Text = "hh:nn"
        '
        'LblStartDate
        '
        Me.LblStartDate.BackColor = System.Drawing.SystemColors.Control
        Me.LblStartDate.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblStartDate.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblStartDate.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblStartDate.Location = New System.Drawing.Point(60, 52)
        Me.LblStartDate.Name = "LblStartDate"
        Me.LblStartDate.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblStartDate.Size = New System.Drawing.Size(77, 21)
        Me.LblStartDate.TabIndex = 20
        Me.LblStartDate.Text = "mm/dd/yy"
        '
        '_Lable_7
        '
        Me._Lable_7.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_7.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_7.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_7, CType(7, Short))
        Me._Lable_7.Location = New System.Drawing.Point(218, 72)
        Me._Lable_7.Name = "_Lable_7"
        Me._Lable_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_7.Size = New System.Drawing.Size(15, 19)
        Me._Lable_7.TabIndex = 13
        Me._Lable_7.Text = "*"
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
        Me._Lable_1.TabIndex = 12
        Me._Lable_1.Text = "Name"
        '
        '_Lable_2
        '
        Me._Lable_2.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_2, CType(2, Short))
        Me._Lable_2.Location = New System.Drawing.Point(8, 52)
        Me._Lable_2.Name = "_Lable_2"
        Me._Lable_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_2.Size = New System.Drawing.Size(41, 15)
        Me._Lable_2.TabIndex = 11
        Me._Lable_2.Text = "Start"
        '
        '_Lable_3
        '
        Me._Lable_3.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_3.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_3, CType(3, Short))
        Me._Lable_3.Location = New System.Drawing.Point(8, 78)
        Me._Lable_3.Name = "_Lable_3"
        Me._Lable_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_3.Size = New System.Drawing.Size(33, 15)
        Me._Lable_3.TabIndex = 10
        Me._Lable_3.Text = "End"
        '
        '_Lable_4
        '
        Me._Lable_4.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_4.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_4.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_4, CType(4, Short))
        Me._Lable_4.Location = New System.Drawing.Point(60, 98)
        Me._Lable_4.Name = "_Lable_4"
        Me._Lable_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_4.Size = New System.Drawing.Size(171, 15)
        Me._Lable_4.TabIndex = 9
        Me._Lable_4.Text = "RunTime Text"
        '
        'CmdOK
        '
        Me.CmdOK.BackColor = System.Drawing.SystemColors.Control
        Me.CmdOK.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdOK.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdOK.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdOK.Location = New System.Drawing.Point(318, 8)
        Me.CmdOK.Name = "CmdOK"
        Me.CmdOK.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdOK.Size = New System.Drawing.Size(80, 21)
        Me.CmdOK.TabIndex = 6
        Me.CmdOK.Text = "&Save"
        Me.CmdOK.UseVisualStyleBackColor = False
        '
        'CmdCancel
        '
        Me.CmdCancel.BackColor = System.Drawing.SystemColors.Control
        Me.CmdCancel.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdCancel.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdCancel.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdCancel.Location = New System.Drawing.Point(320, 224)
        Me.CmdCancel.Name = "CmdCancel"
        Me.CmdCancel.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdCancel.Size = New System.Drawing.Size(80, 21)
        Me.CmdCancel.TabIndex = 7
        Me.CmdCancel.Text = "C&ancel"
        Me.CmdCancel.UseVisualStyleBackColor = False
        '
        'FrmScheduleSplitShift
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 14.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.ClientSize = New System.Drawing.Size(403, 249)
        Me.Controls.Add(Me.Frame1)
        Me.Controls.Add(Me.FraSingle)
        Me.Controls.Add(Me.CmdOK)
        Me.Controls.Add(Me.CmdCancel)
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Location = New System.Drawing.Point(280, 221)
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "FrmScheduleSplitShift"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Split Shift"
        Me.Frame1.ResumeLayout(False)
        Me.Frame1.PerformLayout()
        CType(Me.CboStartDate, System.ComponentModel.ISupportInitialize).EndInit()
        Me.FraSingle.ResumeLayout(False)
        Me.FraSingle.PerformLayout()
        CType(Me.CboEndDate, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.Lable, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)

    End Sub
#End Region 
End Class