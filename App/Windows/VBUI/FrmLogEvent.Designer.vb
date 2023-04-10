<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmLogEvent
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
	Public WithEvents ChkConfirmed As System.Windows.Forms.CheckBox
	Public WithEvents TxtContactDate As System.Windows.Forms.TextBox
	Public WithEvents CboContactEventType As System.Windows.Forms.ComboBox
	Public WithEvents TxtContactPhone As System.Windows.Forms.TextBox
	Public WithEvents cmdNameDetail As System.Windows.Forms.Button
	Public WithEvents CboName As System.Windows.Forms.ComboBox
	Public WithEvents TxtCalloutDate As System.Windows.Forms.TextBox
	Public WithEvents TxtCalloutMins As System.Windows.Forms.TextBox
	Public WithEvents _label_1 As System.Windows.Forms.Label
	Public WithEvents _LblCallout_0 As System.Windows.Forms.Label
	Public WithEvents _LblCallout_1 As System.Windows.Forms.Label
	Public WithEvents FraCallout As System.Windows.Forms.Panel
	Public WithEvents TxtContactOrg As System.Windows.Forms.TextBox
	Public WithEvents TxtContactDesc As System.Windows.Forms.RichTextBox
	Public WithEvents LblContactName As System.Windows.Forms.Label
	Public WithEvents LblContactPhone As System.Windows.Forms.Label
	Public WithEvents LblContactOrg As System.Windows.Forms.Label
    Public WithEvents _LblContact_2 As System.Windows.Forms.Label
	Public WithEvents _LblContact_3 As System.Windows.Forms.Label
	Public WithEvents FraContact As System.Windows.Forms.GroupBox
	Public WithEvents CmdCancel As System.Windows.Forms.Button
	Public WithEvents CmdOK As System.Windows.Forms.Button
	Public WithEvents LblCallout As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
	Public WithEvents LblContact As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
	Public WithEvents label As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FrmLogEvent))
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.cmdNameDetail = New System.Windows.Forms.Button
        Me.ChkConfirmed = New System.Windows.Forms.CheckBox
        Me.FraContact = New System.Windows.Forms.GroupBox
        Me.CmdCancel = New System.Windows.Forms.Button
        Me.LblContactName = New System.Windows.Forms.Label
        Me.TxtContactDate = New System.Windows.Forms.TextBox
        Me.FraCallout = New System.Windows.Forms.Panel
        Me._LblCallout_1 = New System.Windows.Forms.Label
        Me.CmdOK = New System.Windows.Forms.Button
        Me.CboContactEventType = New System.Windows.Forms.ComboBox
        Me.TxtContactPhone = New System.Windows.Forms.TextBox
        Me.TxtCalloutDate = New System.Windows.Forms.TextBox
        Me._LblContact_2 = New System.Windows.Forms.Label
        Me.TxtCalloutMins = New System.Windows.Forms.TextBox
        Me._LblContact_3 = New System.Windows.Forms.Label
        Me.CboName = New System.Windows.Forms.ComboBox
        Me._label_1 = New System.Windows.Forms.Label
        Me.LblContactPhone = New System.Windows.Forms.Label
        Me.LblContactOrg = New System.Windows.Forms.Label
        Me._LblCallout_0 = New System.Windows.Forms.Label
        Me.TxtContactDesc = New System.Windows.Forms.RichTextBox
        Me.TxtContactOrg = New System.Windows.Forms.TextBox
        Me.LblCallout = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(Me.components)
        Me.LblContact = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(Me.components)
        Me.label = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(Me.components)
        Me.FraContact.SuspendLayout()
        Me.FraCallout.SuspendLayout()
        CType(Me.LblCallout, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.LblContact, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.label, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'cmdNameDetail
        '
        Me.cmdNameDetail.BackColor = System.Drawing.SystemColors.Control
        Me.cmdNameDetail.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdNameDetail.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdNameDetail.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdNameDetail.Location = New System.Drawing.Point(262, 42)
        Me.cmdNameDetail.Name = "cmdNameDetail"
        Me.cmdNameDetail.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdNameDetail.Size = New System.Drawing.Size(25, 25)
        Me.cmdNameDetail.TabIndex = 9
        Me.cmdNameDetail.Text = "..."
        Me.ToolTip1.SetToolTip(Me.cmdNameDetail, "Detail")
        Me.cmdNameDetail.UseVisualStyleBackColor = False
        '
        'ChkConfirmed
        '
        Me.ChkConfirmed.BackColor = System.Drawing.SystemColors.Control
        Me.ChkConfirmed.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkConfirmed.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkConfirmed.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkConfirmed.Location = New System.Drawing.Point(613, 51)
        Me.ChkConfirmed.Name = "ChkConfirmed"
        Me.ChkConfirmed.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkConfirmed.Size = New System.Drawing.Size(83, 33)
        Me.ChkConfirmed.TabIndex = 3
        Me.ChkConfirmed.Text = "Contact Confirmed"
        Me.ChkConfirmed.UseVisualStyleBackColor = False
        Me.ChkConfirmed.Visible = False
        '
        'FraContact
        '
        Me.FraContact.BackColor = System.Drawing.SystemColors.Control
        Me.FraContact.Controls.Add(Me.ChkConfirmed)
        Me.FraContact.Controls.Add(Me.CmdCancel)
        Me.FraContact.Controls.Add(Me.LblContactName)
        Me.FraContact.Controls.Add(Me.TxtContactDate)
        Me.FraContact.Controls.Add(Me.FraCallout)
        Me.FraContact.Controls.Add(Me.CmdOK)
        Me.FraContact.Controls.Add(Me.CboContactEventType)
        Me.FraContact.Controls.Add(Me.TxtContactPhone)
        Me.FraContact.Controls.Add(Me.TxtCalloutDate)
        Me.FraContact.Controls.Add(Me._LblContact_2)
        Me.FraContact.Controls.Add(Me.TxtCalloutMins)
        Me.FraContact.Controls.Add(Me._LblContact_3)
        Me.FraContact.Controls.Add(Me.CboName)
        Me.FraContact.Controls.Add(Me._label_1)
        Me.FraContact.Controls.Add(Me.LblContactPhone)
        Me.FraContact.Controls.Add(Me.cmdNameDetail)
        Me.FraContact.Controls.Add(Me.LblContactOrg)
        Me.FraContact.Controls.Add(Me._LblCallout_0)
        Me.FraContact.Controls.Add(Me.TxtContactDesc)
        Me.FraContact.Controls.Add(Me.TxtContactOrg)
        Me.FraContact.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FraContact.ForeColor = System.Drawing.SystemColors.ControlText
        Me.FraContact.Location = New System.Drawing.Point(2, 0)
        Me.FraContact.Name = "FraContact"
        Me.FraContact.Padding = New System.Windows.Forms.Padding(0)
        Me.FraContact.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.FraContact.Size = New System.Drawing.Size(703, 143)
        Me.FraContact.TabIndex = 0
        Me.FraContact.TabStop = False
        '
        'CmdCancel
        '
        Me.CmdCancel.BackColor = System.Drawing.SystemColors.Control
        Me.CmdCancel.CausesValidation = False
        Me.CmdCancel.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdCancel.DialogResult = System.Windows.Forms.DialogResult.Cancel
        Me.CmdCancel.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdCancel.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdCancel.Location = New System.Drawing.Point(613, 117)
        Me.CmdCancel.Name = "CmdCancel"
        Me.CmdCancel.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdCancel.Size = New System.Drawing.Size(80, 21)
        Me.CmdCancel.TabIndex = 5
        Me.CmdCancel.Text = "&Cancel"
        Me.CmdCancel.UseVisualStyleBackColor = False
        '
        'LblContactName
        '
        Me.LblContactName.AutoSize = True
        Me.LblContactName.BackColor = System.Drawing.SystemColors.Control
        Me.LblContactName.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblContactName.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblContactName.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblContactName.Location = New System.Drawing.Point(1, 47)
        Me.LblContactName.Name = "LblContactName"
        Me.LblContactName.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblContactName.Size = New System.Drawing.Size(87, 14)
        Me.LblContactName.TabIndex = 16
        Me.LblContactName.Text = "Name of Contact"
        '
        'TxtContactDate
        '
        Me.TxtContactDate.AcceptsReturn = True
        Me.TxtContactDate.BackColor = System.Drawing.SystemColors.Window
        Me.TxtContactDate.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtContactDate.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtContactDate.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtContactDate.Location = New System.Drawing.Point(94, 17)
        Me.TxtContactDate.MaxLength = 0
        Me.TxtContactDate.Name = "TxtContactDate"
        Me.TxtContactDate.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtContactDate.Size = New System.Drawing.Size(103, 20)
        Me.TxtContactDate.TabIndex = 6
        Me.TxtContactDate.Text = "00/00/00  00:00:00"
        '
        'FraCallout
        '
        Me.FraCallout.BackColor = System.Drawing.SystemColors.Control
        Me.FraCallout.Controls.Add(Me._LblCallout_1)
        Me.FraCallout.Cursor = System.Windows.Forms.Cursors.Default
        Me.FraCallout.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FraCallout.ForeColor = System.Drawing.SystemColors.ControlText
        Me.FraCallout.Location = New System.Drawing.Point(45, 153)
        Me.FraCallout.Name = "FraCallout"
        Me.FraCallout.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.FraCallout.Size = New System.Drawing.Size(255, 21)
        Me.FraCallout.TabIndex = 5
        Me.FraCallout.Visible = False
        '
        '_LblCallout_1
        '
        Me._LblCallout_1.AutoSize = True
        Me._LblCallout_1.BackColor = System.Drawing.SystemColors.Control
        Me._LblCallout_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblCallout_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LblCallout_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblCallout.SetIndex(Me._LblCallout_1, CType(1, Short))
        Me._LblCallout_1.Location = New System.Drawing.Point(14, 4)
        Me._LblCallout_1.Name = "_LblCallout_1"
        Me._LblCallout_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblCallout_1.Size = New System.Drawing.Size(39, 14)
        Me._LblCallout_1.TabIndex = 23
        Me._LblCallout_1.Text = "Callout"
        '
        'CmdOK
        '
        Me.CmdOK.BackColor = System.Drawing.SystemColors.Control
        Me.CmdOK.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdOK.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdOK.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdOK.Location = New System.Drawing.Point(613, 17)
        Me.CmdOK.Name = "CmdOK"
        Me.CmdOK.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdOK.Size = New System.Drawing.Size(80, 21)
        Me.CmdOK.TabIndex = 4
        Me.CmdOK.Text = "&Save"
        Me.CmdOK.UseVisualStyleBackColor = False
        Me.CmdOK.Enabled = False
        '
        'CboContactEventType
        '
        Me.CboContactEventType.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboContactEventType.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboContactEventType.BackColor = System.Drawing.SystemColors.Window
        Me.CboContactEventType.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboContactEventType.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboContactEventType.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboContactEventType.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboContactEventType.Location = New System.Drawing.Point(384, 16)
        Me.CboContactEventType.Name = "CboContactEventType"
        Me.CboContactEventType.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboContactEventType.Size = New System.Drawing.Size(213, 22)
        Me.CboContactEventType.TabIndex = 1
        '
        'TxtContactPhone
        '
        Me.TxtContactPhone.AcceptsReturn = True
        Me.TxtContactPhone.BackColor = System.Drawing.SystemColors.Window
        Me.TxtContactPhone.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtContactPhone.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtContactPhone.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtContactPhone.Location = New System.Drawing.Point(94, 94)
        Me.TxtContactPhone.MaxLength = 0
        Me.TxtContactPhone.Name = "TxtContactPhone"
        Me.TxtContactPhone.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtContactPhone.Size = New System.Drawing.Size(195, 20)
        Me.TxtContactPhone.TabIndex = 10
        '
        'TxtCalloutDate
        '
        Me.TxtCalloutDate.AcceptsReturn = True
        Me.TxtCalloutDate.BackColor = System.Drawing.SystemColors.Window
        Me.TxtCalloutDate.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtCalloutDate.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtCalloutDate.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtCalloutDate.Location = New System.Drawing.Point(208, 118)
        Me.TxtCalloutDate.MaxLength = 0
        Me.TxtCalloutDate.Name = "TxtCalloutDate"
        Me.TxtCalloutDate.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtCalloutDate.Size = New System.Drawing.Size(81, 20)
        Me.TxtCalloutDate.TabIndex = 13
        Me.TxtCalloutDate.Visible = False
        '
        '_LblContact_2
        '
        Me._LblContact_2.AutoSize = True
        Me._LblContact_2.BackColor = System.Drawing.SystemColors.Control
        Me._LblContact_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblContact_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LblContact_2.ForeColor = System.Drawing.Color.Black
        Me.LblContact.SetIndex(Me._LblContact_2, CType(2, Short))
        Me._LblContact_2.Location = New System.Drawing.Point(39, 20)
        Me._LblContact_2.Name = "_LblContact_2"
        Me._LblContact_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblContact_2.Size = New System.Drawing.Size(51, 14)
        Me._LblContact_2.TabIndex = 12
        Me._LblContact_2.Text = "Date/time"
        '
        'TxtCalloutMins
        '
        Me.TxtCalloutMins.AcceptsReturn = True
        Me.TxtCalloutMins.BackColor = System.Drawing.SystemColors.Window
        Me.TxtCalloutMins.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtCalloutMins.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtCalloutMins.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtCalloutMins.Location = New System.Drawing.Point(94, 118)
        Me.TxtCalloutMins.MaxLength = 0
        Me.TxtCalloutMins.Name = "TxtCalloutMins"
        Me.TxtCalloutMins.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtCalloutMins.Size = New System.Drawing.Size(45, 20)
        Me.TxtCalloutMins.TabIndex = 11
        Me.TxtCalloutMins.Visible = False
        '
        '_LblContact_3
        '
        Me._LblContact_3.BackColor = System.Drawing.SystemColors.Control
        Me._LblContact_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblContact_3.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LblContact_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblContact.SetIndex(Me._LblContact_3, CType(3, Short))
        Me._LblContact_3.Location = New System.Drawing.Point(320, 20)
        Me._LblContact_3.Name = "_LblContact_3"
        Me._LblContact_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblContact_3.Size = New System.Drawing.Size(61, 15)
        Me._LblContact_3.TabIndex = 11
        Me._LblContact_3.Text = "Event Type"
        '
        'CboName
        '
        Me.CboName.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboName.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboName.BackColor = System.Drawing.SystemColors.Window
        Me.CboName.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboName.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboName.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboName.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboName.Location = New System.Drawing.Point(94, 43)
        Me.CboName.Name = "CboName"
        Me.CboName.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboName.Size = New System.Drawing.Size(163, 22)
        Me.CboName.Sorted = True
        Me.CboName.TabIndex = 8
        '
        '_label_1
        '
        Me._label_1.AutoSize = True
        Me._label_1.BackColor = System.Drawing.SystemColors.Control
        Me._label_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._label_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._label_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.label.SetIndex(Me._label_1, CType(1, Short))
        Me._label_1.Location = New System.Drawing.Point(140, 120)
        Me._label_1.Name = "_label_1"
        Me._label_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._label_1.Size = New System.Drawing.Size(68, 14)
        Me._label_1.TabIndex = 12
        Me._label_1.Text = "min.  or after"
        Me._label_1.Visible = False
        '
        'LblContactPhone
        '
        Me.LblContactPhone.AutoSize = True
        Me.LblContactPhone.BackColor = System.Drawing.SystemColors.Control
        Me.LblContactPhone.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblContactPhone.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblContactPhone.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblContactPhone.Location = New System.Drawing.Point(51, 97)
        Me.LblContactPhone.Name = "LblContactPhone"
        Me.LblContactPhone.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblContactPhone.Size = New System.Drawing.Size(37, 14)
        Me.LblContactPhone.TabIndex = 15
        Me.LblContactPhone.Text = "Phone"
        '
        'LblContactOrg
        '
        Me.LblContactOrg.AutoSize = True
        Me.LblContactOrg.BackColor = System.Drawing.SystemColors.Control
        Me.LblContactOrg.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblContactOrg.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblContactOrg.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblContactOrg.Location = New System.Drawing.Point(20, 73)
        Me.LblContactOrg.Name = "LblContactOrg"
        Me.LblContactOrg.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblContactOrg.Size = New System.Drawing.Size(68, 14)
        Me.LblContactOrg.TabIndex = 14
        Me.LblContactOrg.Text = "Organization"
        '
        '_LblCallout_0
        '
        Me._LblCallout_0.AutoSize = True
        Me._LblCallout_0.BackColor = System.Drawing.SystemColors.Control
        Me._LblCallout_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblCallout_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LblCallout_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblCallout.SetIndex(Me._LblCallout_0, CType(0, Short))
        Me._LblCallout_0.Location = New System.Drawing.Point(42, 121)
        Me._LblCallout_0.Name = "_LblCallout_0"
        Me._LblCallout_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblCallout_0.Size = New System.Drawing.Size(47, 14)
        Me._LblCallout_0.TabIndex = 18
        Me._LblCallout_0.Text = "Callback"
        Me._LblCallout_0.Visible = False
        '
        'TxtContactDesc
        '
        Me.TxtContactDesc.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtContactDesc.Location = New System.Drawing.Point(384, 43)
        Me.TxtContactDesc.MaxLength = 999
        Me.TxtContactDesc.Name = "TxtContactDesc"
        Me.TxtContactDesc.RightMargin = 199
        Me.TxtContactDesc.ScrollBars = System.Windows.Forms.RichTextBoxScrollBars.Vertical
        Me.TxtContactDesc.Size = New System.Drawing.Size(213, 95)
        Me.TxtContactDesc.TabIndex = 2
        Me.TxtContactDesc.Text = ""
        '
        'TxtContactOrg
        '
        Me.TxtContactOrg.AcceptsReturn = True
        Me.TxtContactOrg.BackColor = System.Drawing.SystemColors.Window
        Me.TxtContactOrg.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtContactOrg.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtContactOrg.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtContactOrg.Location = New System.Drawing.Point(94, 70)
        Me.TxtContactOrg.MaxLength = 0
        Me.TxtContactOrg.Name = "TxtContactOrg"
        Me.TxtContactOrg.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtContactOrg.Size = New System.Drawing.Size(195, 20)
        Me.TxtContactOrg.TabIndex = 7
        '
        'FrmLogEvent
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 14.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.CancelButton = Me.CmdCancel
        Me.ClientSize = New System.Drawing.Size(707, 147)
        Me.ControlBox = False
        Me.Controls.Add(Me.FraContact)
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Location = New System.Drawing.Point(148, 214)
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "FrmLogEvent"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Call Log Event"
        Me.FraContact.ResumeLayout(False)
        Me.FraContact.PerformLayout()
        Me.FraCallout.ResumeLayout(False)
        Me.FraCallout.PerformLayout()
        CType(Me.LblCallout, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.LblContact, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.label, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)

    End Sub
#End Region
End Class