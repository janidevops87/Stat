<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class ctlItemList
#Region "Windows Form Designer generated code "
	<System.Diagnostics.DebuggerNonUserCode()> Public Sub New()
		MyBase.New()
		'This call is required by the Windows Form Designer.
		InitializeComponent()
		UserControl_Initialize()
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
    Friend WithEvents cmdAdd As System.Windows.Forms.Button
	Friend WithEvents cmdClear As System.Windows.Forms.Button
	Friend WithEvents txtEndDate As System.Windows.Forms.TextBox
	Friend WithEvents txtStartDate As System.Windows.Forms.TextBox
	Friend WithEvents txtDose As System.Windows.Forms.TextBox
	Friend WithEvents cboAvailable As System.Windows.Forms.ComboBox
	Friend WithEvents cmdRemove As System.Windows.Forms.Button
	Friend WithEvents cmdCreate As System.Windows.Forms.Button
	Friend WithEvents lvwSelected As System.Windows.Forms.ListView
	Friend WithEvents Label5 As System.Windows.Forms.Label
	Friend WithEvents Label4 As System.Windows.Forms.Label
	Friend WithEvents Label3 As System.Windows.Forms.Label
	Friend WithEvents Label2 As System.Windows.Forms.Label
	Friend WithEvents fmBorder As System.Windows.Forms.GroupBox
	Friend WithEvents Label1 As System.Windows.Forms.Label
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.fmBorder = New System.Windows.Forms.GroupBox
        Me.cmdAdd = New System.Windows.Forms.Button
        Me.cmdClear = New System.Windows.Forms.Button
        Me.txtEndDate = New System.Windows.Forms.TextBox
        Me.txtStartDate = New System.Windows.Forms.TextBox
        Me.txtDose = New System.Windows.Forms.TextBox
        Me.cboAvailable = New System.Windows.Forms.ComboBox
        Me.cmdRemove = New System.Windows.Forms.Button
        Me.cmdCreate = New System.Windows.Forms.Button
        Me.lvwSelected = New System.Windows.Forms.ListView
        Me.Label5 = New System.Windows.Forms.Label
        Me.Label4 = New System.Windows.Forms.Label
        Me.Label3 = New System.Windows.Forms.Label
        Me.Label2 = New System.Windows.Forms.Label
        Me.Label1 = New System.Windows.Forms.Label
        Me.fmBorder.SuspendLayout()
        Me.SuspendLayout()
        '
        'fmBorder
        '
        Me.fmBorder.BackColor = System.Drawing.SystemColors.Control
        Me.fmBorder.Controls.Add(Me.cmdAdd)
        Me.fmBorder.Controls.Add(Me.cmdClear)
        Me.fmBorder.Controls.Add(Me.txtEndDate)
        Me.fmBorder.Controls.Add(Me.txtStartDate)
        Me.fmBorder.Controls.Add(Me.txtDose)
        Me.fmBorder.Controls.Add(Me.cboAvailable)
        Me.fmBorder.Controls.Add(Me.cmdRemove)
        Me.fmBorder.Controls.Add(Me.cmdCreate)
        Me.fmBorder.Controls.Add(Me.lvwSelected)
        Me.fmBorder.Controls.Add(Me.Label5)
        Me.fmBorder.Controls.Add(Me.Label4)
        Me.fmBorder.Controls.Add(Me.Label3)
        Me.fmBorder.Controls.Add(Me.Label2)
        Me.fmBorder.Enabled = False
        Me.fmBorder.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.fmBorder.ForeColor = System.Drawing.SystemColors.ControlText
        Me.fmBorder.Location = New System.Drawing.Point(0, 0)
        Me.fmBorder.Name = "fmBorder"
        Me.fmBorder.Padding = New System.Windows.Forms.Padding(0)
        Me.fmBorder.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.fmBorder.Size = New System.Drawing.Size(431, 257)
        Me.fmBorder.TabIndex = 7
        Me.fmBorder.TabStop = False
        '
        'cmdAdd
        '
        Me.cmdAdd.Location = New System.Drawing.Point(366, 56)
        Me.cmdAdd.Name = "cmdAdd"
        Me.cmdAdd.Size = New System.Drawing.Size(60, 25)
        Me.cmdAdd.TabIndex = 4
        Me.cmdAdd.Text = "Add"
        '
        'cmdClear
        '
        Me.cmdClear.BackColor = System.Drawing.SystemColors.Control
        Me.cmdClear.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdClear.Enabled = False
        Me.cmdClear.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdClear.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdClear.Location = New System.Drawing.Point(366, 88)
        Me.cmdClear.Name = "cmdClear"
        Me.cmdClear.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdClear.Size = New System.Drawing.Size(60, 25)
        Me.cmdClear.TabIndex = 14
        Me.cmdClear.TabStop = False
        Me.cmdClear.Text = "Clear"
        Me.cmdClear.UseVisualStyleBackColor = False
        '
        'txtEndDate
        '
        Me.txtEndDate.AcceptsReturn = True
        Me.txtEndDate.BackColor = System.Drawing.SystemColors.Window
        Me.txtEndDate.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtEndDate.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtEndDate.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtEndDate.Location = New System.Drawing.Point(367, 32)
        Me.txtEndDate.MaxLength = 0
        Me.txtEndDate.Name = "txtEndDate"
        Me.txtEndDate.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtEndDate.Size = New System.Drawing.Size(57, 20)
        Me.txtEndDate.TabIndex = 3
        '
        'txtStartDate
        '
        Me.txtStartDate.AcceptsReturn = True
        Me.txtStartDate.BackColor = System.Drawing.SystemColors.Window
        Me.txtStartDate.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtStartDate.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtStartDate.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtStartDate.Location = New System.Drawing.Point(310, 32)
        Me.txtStartDate.MaxLength = 0
        Me.txtStartDate.Name = "txtStartDate"
        Me.txtStartDate.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtStartDate.Size = New System.Drawing.Size(57, 20)
        Me.txtStartDate.TabIndex = 2
        '
        'txtDose
        '
        Me.txtDose.AcceptsReturn = True
        Me.txtDose.BackColor = System.Drawing.SystemColors.Window
        Me.txtDose.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtDose.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtDose.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtDose.Location = New System.Drawing.Point(197, 32)
        Me.txtDose.MaxLength = 0
        Me.txtDose.Name = "txtDose"
        Me.txtDose.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtDose.Size = New System.Drawing.Size(113, 20)
        Me.txtDose.TabIndex = 1
        '
        'cboAvailable
        '
        Me.cboAvailable.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.cboAvailable.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.cboAvailable.BackColor = System.Drawing.SystemColors.Window
        Me.cboAvailable.Cursor = System.Windows.Forms.Cursors.Default
        Me.cboAvailable.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cboAvailable.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cboAvailable.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cboAvailable.Location = New System.Drawing.Point(8, 32)
        Me.cboAvailable.Name = "cboAvailable"
        Me.cboAvailable.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cboAvailable.Size = New System.Drawing.Size(190, 22)
        Me.cboAvailable.TabIndex = 0
        '
        'cmdRemove
        '
        Me.cmdRemove.BackColor = System.Drawing.SystemColors.Control
        Me.cmdRemove.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdRemove.Enabled = False
        Me.cmdRemove.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdRemove.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdRemove.Location = New System.Drawing.Point(366, 120)
        Me.cmdRemove.Name = "cmdRemove"
        Me.cmdRemove.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdRemove.Size = New System.Drawing.Size(60, 25)
        Me.cmdRemove.TabIndex = 5
        Me.cmdRemove.TabStop = False
        Me.cmdRemove.Text = "Remove"
        Me.cmdRemove.UseVisualStyleBackColor = False
        '
        'cmdCreate
        '
        Me.cmdCreate.BackColor = System.Drawing.SystemColors.Control
        Me.cmdCreate.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdCreate.Enabled = False
        Me.cmdCreate.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdCreate.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdCreate.Location = New System.Drawing.Point(366, 152)
        Me.cmdCreate.Name = "cmdCreate"
        Me.cmdCreate.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdCreate.Size = New System.Drawing.Size(60, 25)
        Me.cmdCreate.TabIndex = 6
        Me.cmdCreate.TabStop = False
        Me.cmdCreate.Text = "Create"
        Me.cmdCreate.UseVisualStyleBackColor = False
        Me.cmdCreate.Visible = False
        '
        'lvwSelected
        '
        Me.lvwSelected.BackColor = System.Drawing.SystemColors.Window
        Me.lvwSelected.Enabled = False
        Me.lvwSelected.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lvwSelected.ForeColor = System.Drawing.SystemColors.WindowText
        Me.lvwSelected.FullRowSelect = True
        Me.lvwSelected.HideSelection = False
        Me.lvwSelected.Location = New System.Drawing.Point(8, 56)
        Me.lvwSelected.Name = "lvwSelected"
        Me.lvwSelected.Size = New System.Drawing.Size(353, 193)
        Me.lvwSelected.TabIndex = 8
        Me.lvwSelected.TabStop = False
        Me.lvwSelected.UseCompatibleStateImageBehavior = False
        Me.lvwSelected.View = System.Windows.Forms.View.Details
        '
        'Label5
        '
        Me.Label5.BackColor = System.Drawing.SystemColors.Control
        Me.Label5.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label5.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label5.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label5.Location = New System.Drawing.Point(364, 16)
        Me.Label5.Name = "Label5"
        Me.Label5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label5.Size = New System.Drawing.Size(49, 17)
        Me.Label5.TabIndex = 13
        Me.Label5.Text = "End Date"
        '
        'Label4
        '
        Me.Label4.BackColor = System.Drawing.SystemColors.Control
        Me.Label4.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label4.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label4.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label4.Location = New System.Drawing.Point(310, 16)
        Me.Label4.Name = "Label4"
        Me.Label4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label4.Size = New System.Drawing.Size(49, 17)
        Me.Label4.TabIndex = 12
        Me.Label4.Text = "Start Date"
        '
        'Label3
        '
        Me.Label3.BackColor = System.Drawing.SystemColors.Control
        Me.Label3.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label3.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label3.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label3.Location = New System.Drawing.Point(199, 16)
        Me.Label3.Name = "Label3"
        Me.Label3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label3.Size = New System.Drawing.Size(33, 17)
        Me.Label3.TabIndex = 11
        Me.Label3.Text = "Dose"
        '
        'Label2
        '
        Me.Label2.BackColor = System.Drawing.SystemColors.Control
        Me.Label2.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label2.Location = New System.Drawing.Point(8, 16)
        Me.Label2.Name = "Label2"
        Me.Label2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label2.Size = New System.Drawing.Size(73, 17)
        Me.Label2.TabIndex = 10
        Me.Label2.Text = "Name"
        '
        'Label1
        '
        Me.Label1.BackColor = System.Drawing.Color.Red
        Me.Label1.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label1.Location = New System.Drawing.Point(32, 16)
        Me.Label1.Name = "Label1"
        Me.Label1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label1.Size = New System.Drawing.Size(145, 17)
        Me.Label1.TabIndex = 9
        Me.Label1.Text = "List 2"
        '
        'ctlItemList
        '
        Me.Controls.Add(Me.fmBorder)
        Me.Controls.Add(Me.Label1)
        Me.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Name = "ctlItemList"
        Me.Size = New System.Drawing.Size(446, 265)
        Me.fmBorder.ResumeLayout(False)
        Me.fmBorder.PerformLayout()
        Me.ResumeLayout(False)

    End Sub
#End Region 
End Class