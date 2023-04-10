<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmDonorIntent
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
	Public WithEvents cmdCancel As System.Windows.Forms.Button
	Public WithEvents cmdContinue As System.Windows.Forms.Button
	Public WithEvents CboState As System.Windows.Forms.ComboBox
	Public WithEvents TxtNOKCity As System.Windows.Forms.TextBox
	Public WithEvents TxtNOKLastName As System.Windows.Forms.TextBox
	Public WithEvents TxtNOKPhone As System.Windows.Forms.TextBox
	Public WithEvents CmdFamilyContact As System.Windows.Forms.Button
	Public WithEvents TxtNOKZip As System.Windows.Forms.TextBox
	Public WithEvents TxtNOKFirstName As System.Windows.Forms.TextBox
	Public WithEvents CboRelation As System.Windows.Forms.ComboBox
	Public WithEvents TxtNOKAddress As System.Windows.Forms.TextBox
	Public WithEvents txtNurseScript As System.Windows.Forms.TextBox
	Public WithEvents LblRelation As System.Windows.Forms.Label
	Public WithEvents LblAddress As System.Windows.Forms.Label
	Public WithEvents LblFN As System.Windows.Forms.Label
	Public WithEvents LblZip As System.Windows.Forms.Label
	Public WithEvents LblState As System.Windows.Forms.Label
	Public WithEvents LblCity As System.Windows.Forms.Label
	Public WithEvents LblPhone As System.Windows.Forms.Label
	Public WithEvents LblLN As System.Windows.Forms.Label
	Public WithEvents lblRegType As System.Windows.Forms.Label
	Public WithEvents Frame2 As System.Windows.Forms.GroupBox
	Public WithEvents txtoldNurseScript As System.Windows.Forms.TextBox
	Public WithEvents TxtOldAddress As System.Windows.Forms.TextBox
	Public WithEvents CboOldRelation As System.Windows.Forms.ComboBox
	Public WithEvents TxtNOK As System.Windows.Forms.TextBox
	Public WithEvents TxtOldPhone As System.Windows.Forms.TextBox
	Public WithEvents LblOldAddress As System.Windows.Forms.Label
	Public WithEvents LblOldRelation As System.Windows.Forms.Label
	Public WithEvents LblNOK As System.Windows.Forms.Label
	Public WithEvents lbloldRegType As System.Windows.Forms.Label
	Public WithEvents Frame1 As System.Windows.Forms.GroupBox
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.cmdCancel = New System.Windows.Forms.Button
        Me.cmdContinue = New System.Windows.Forms.Button
        Me.Frame2 = New System.Windows.Forms.GroupBox
        Me.CboState = New System.Windows.Forms.ComboBox
        Me.TxtNOKCity = New System.Windows.Forms.TextBox
        Me.TxtNOKLastName = New System.Windows.Forms.TextBox
        Me.TxtNOKPhone = New System.Windows.Forms.TextBox
        Me.CmdFamilyContact = New System.Windows.Forms.Button
        Me.TxtNOKZip = New System.Windows.Forms.TextBox
        Me.TxtNOKFirstName = New System.Windows.Forms.TextBox
        Me.CboRelation = New System.Windows.Forms.ComboBox
        Me.TxtNOKAddress = New System.Windows.Forms.TextBox
        Me.txtNurseScript = New System.Windows.Forms.TextBox
        Me.LblRelation = New System.Windows.Forms.Label
        Me.LblAddress = New System.Windows.Forms.Label
        Me.LblFN = New System.Windows.Forms.Label
        Me.LblZip = New System.Windows.Forms.Label
        Me.LblState = New System.Windows.Forms.Label
        Me.LblCity = New System.Windows.Forms.Label
        Me.LblPhone = New System.Windows.Forms.Label
        Me.LblLN = New System.Windows.Forms.Label
        Me.lblRegType = New System.Windows.Forms.Label
        Me.Frame1 = New System.Windows.Forms.GroupBox
        Me.txtoldNurseScript = New System.Windows.Forms.TextBox
        Me.TxtOldAddress = New System.Windows.Forms.TextBox
        Me.CboOldRelation = New System.Windows.Forms.ComboBox
        Me.TxtNOK = New System.Windows.Forms.TextBox
        Me.TxtOldPhone = New System.Windows.Forms.TextBox
        Me.LblOldAddress = New System.Windows.Forms.Label
        Me.LblOldRelation = New System.Windows.Forms.Label
        Me.LblNOK = New System.Windows.Forms.Label
        Me.lbloldRegType = New System.Windows.Forms.Label
        Me.Frame2.SuspendLayout()
        Me.Frame1.SuspendLayout()
        Me.SuspendLayout()
        '
        'cmdCancel
        '
        Me.cmdCancel.BackColor = System.Drawing.SystemColors.Control
        Me.cmdCancel.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdCancel.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdCancel.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdCancel.Location = New System.Drawing.Point(406, 236)
        Me.cmdCancel.Name = "cmdCancel"
        Me.cmdCancel.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdCancel.Size = New System.Drawing.Size(81, 25)
        Me.cmdCancel.TabIndex = 11
        Me.cmdCancel.Text = "Cancel"
        Me.cmdCancel.UseVisualStyleBackColor = False
        '
        'cmdContinue
        '
        Me.cmdContinue.BackColor = System.Drawing.SystemColors.Control
        Me.cmdContinue.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdContinue.Enabled = False
        Me.cmdContinue.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdContinue.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdContinue.Location = New System.Drawing.Point(408, 10)
        Me.cmdContinue.Name = "cmdContinue"
        Me.cmdContinue.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdContinue.Size = New System.Drawing.Size(81, 25)
        Me.cmdContinue.TabIndex = 10
        Me.cmdContinue.Text = "Save"
        Me.cmdContinue.UseVisualStyleBackColor = False
        '
        'Frame2
        '
        Me.Frame2.BackColor = System.Drawing.SystemColors.Control
        Me.Frame2.Controls.Add(Me.CboState)
        Me.Frame2.Controls.Add(Me.TxtNOKCity)
        Me.Frame2.Controls.Add(Me.TxtNOKLastName)
        Me.Frame2.Controls.Add(Me.TxtNOKPhone)
        Me.Frame2.Controls.Add(Me.CmdFamilyContact)
        Me.Frame2.Controls.Add(Me.TxtNOKZip)
        Me.Frame2.Controls.Add(Me.TxtNOKFirstName)
        Me.Frame2.Controls.Add(Me.CboRelation)
        Me.Frame2.Controls.Add(Me.TxtNOKAddress)
        Me.Frame2.Controls.Add(Me.txtNurseScript)
        Me.Frame2.Controls.Add(Me.LblRelation)
        Me.Frame2.Controls.Add(Me.LblAddress)
        Me.Frame2.Controls.Add(Me.LblFN)
        Me.Frame2.Controls.Add(Me.LblZip)
        Me.Frame2.Controls.Add(Me.LblState)
        Me.Frame2.Controls.Add(Me.LblCity)
        Me.Frame2.Controls.Add(Me.LblPhone)
        Me.Frame2.Controls.Add(Me.LblLN)
        Me.Frame2.Controls.Add(Me.lblRegType)
        Me.Frame2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Frame2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame2.Location = New System.Drawing.Point(4, 2)
        Me.Frame2.Name = "Frame2"
        Me.Frame2.Padding = New System.Windows.Forms.Padding(0)
        Me.Frame2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame2.Size = New System.Drawing.Size(399, 259)
        Me.Frame2.TabIndex = 0
        Me.Frame2.TabStop = False
        '
        'CboState
        '
        Me.CboState.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboState.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboState.BackColor = System.Drawing.SystemColors.Window
        Me.CboState.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboState.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboState.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboState.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboState.Location = New System.Drawing.Point(224, 228)
        Me.CboState.Name = "CboState"
        Me.CboState.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboState.Size = New System.Drawing.Size(59, 22)
        Me.CboState.Sorted = True
        Me.CboState.TabIndex = 8
        '
        'TxtNOKCity
        '
        Me.TxtNOKCity.AcceptsReturn = True
        Me.TxtNOKCity.BackColor = System.Drawing.SystemColors.Window
        Me.TxtNOKCity.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtNOKCity.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtNOKCity.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtNOKCity.Location = New System.Drawing.Point(62, 229)
        Me.TxtNOKCity.MaxLength = 50
        Me.TxtNOKCity.Name = "TxtNOKCity"
        Me.TxtNOKCity.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtNOKCity.Size = New System.Drawing.Size(119, 20)
        Me.TxtNOKCity.TabIndex = 7
        '
        'TxtNOKLastName
        '
        Me.TxtNOKLastName.AcceptsReturn = True
        Me.TxtNOKLastName.BackColor = System.Drawing.SystemColors.Window
        Me.TxtNOKLastName.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtNOKLastName.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtNOKLastName.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtNOKLastName.Location = New System.Drawing.Point(244, 113)
        Me.TxtNOKLastName.MaxLength = 50
        Me.TxtNOKLastName.Name = "TxtNOKLastName"
        Me.TxtNOKLastName.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtNOKLastName.Size = New System.Drawing.Size(129, 20)
        Me.TxtNOKLastName.TabIndex = 2
        '
        'TxtNOKPhone
        '
        Me.TxtNOKPhone.AcceptsReturn = True
        Me.TxtNOKPhone.BackColor = System.Drawing.Color.White
        Me.TxtNOKPhone.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtNOKPhone.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtNOKPhone.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtNOKPhone.Location = New System.Drawing.Point(244, 139)
        Me.TxtNOKPhone.MaxLength = 14
        Me.TxtNOKPhone.Name = "TxtNOKPhone"
        Me.TxtNOKPhone.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtNOKPhone.Size = New System.Drawing.Size(129, 20)
        Me.TxtNOKPhone.TabIndex = 4
        '
        'CmdFamilyContact
        '
        Me.CmdFamilyContact.BackColor = System.Drawing.SystemColors.Control
        Me.CmdFamilyContact.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdFamilyContact.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdFamilyContact.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdFamilyContact.Location = New System.Drawing.Point(314, 164)
        Me.CmdFamilyContact.Name = "CmdFamilyContact"
        Me.CmdFamilyContact.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdFamilyContact.Size = New System.Drawing.Size(59, 21)
        Me.CmdFamilyContact.TabIndex = 6
        Me.CmdFamilyContact.Text = "Contact"
        Me.CmdFamilyContact.UseVisualStyleBackColor = False
        '
        'TxtNOKZip
        '
        Me.TxtNOKZip.AcceptsReturn = True
        Me.TxtNOKZip.BackColor = System.Drawing.SystemColors.Window
        Me.TxtNOKZip.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtNOKZip.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtNOKZip.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtNOKZip.Location = New System.Drawing.Point(310, 229)
        Me.TxtNOKZip.MaxLength = 10
        Me.TxtNOKZip.Name = "TxtNOKZip"
        Me.TxtNOKZip.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtNOKZip.Size = New System.Drawing.Size(63, 20)
        Me.TxtNOKZip.TabIndex = 9
        '
        'TxtNOKFirstName
        '
        Me.TxtNOKFirstName.AcceptsReturn = True
        Me.TxtNOKFirstName.BackColor = System.Drawing.Color.White
        Me.TxtNOKFirstName.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtNOKFirstName.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtNOKFirstName.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtNOKFirstName.Location = New System.Drawing.Point(62, 113)
        Me.TxtNOKFirstName.MaxLength = 50
        Me.TxtNOKFirstName.Name = "TxtNOKFirstName"
        Me.TxtNOKFirstName.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtNOKFirstName.Size = New System.Drawing.Size(111, 20)
        Me.TxtNOKFirstName.TabIndex = 1
        '
        'CboRelation
        '
        Me.CboRelation.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboRelation.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboRelation.BackColor = System.Drawing.Color.White
        Me.CboRelation.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboRelation.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboRelation.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboRelation.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboRelation.Items.AddRange(New Object() {"Adult Child", "Adult Sibling", "Guardian", "Other", "Parent", "Representative", "Spouse", "Unknown"})
        Me.CboRelation.Location = New System.Drawing.Point(62, 138)
        Me.CboRelation.Name = "CboRelation"
        Me.CboRelation.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboRelation.Size = New System.Drawing.Size(111, 22)
        Me.CboRelation.Sorted = True
        Me.CboRelation.TabIndex = 3
        '
        'TxtNOKAddress
        '
        Me.TxtNOKAddress.AcceptsReturn = True
        Me.TxtNOKAddress.BackColor = System.Drawing.Color.White
        Me.TxtNOKAddress.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtNOKAddress.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtNOKAddress.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtNOKAddress.Location = New System.Drawing.Point(62, 164)
        Me.TxtNOKAddress.MaxLength = 255
        Me.TxtNOKAddress.Multiline = True
        Me.TxtNOKAddress.Name = "TxtNOKAddress"
        Me.TxtNOKAddress.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtNOKAddress.Size = New System.Drawing.Size(247, 59)
        Me.TxtNOKAddress.TabIndex = 5
        '
        'txtNurseScript
        '
        Me.txtNurseScript.AcceptsReturn = True
        Me.txtNurseScript.BackColor = System.Drawing.Color.White
        Me.txtNurseScript.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtNurseScript.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtNurseScript.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtNurseScript.Location = New System.Drawing.Point(8, 24)
        Me.txtNurseScript.MaxLength = 0
        Me.txtNurseScript.Multiline = True
        Me.txtNurseScript.Name = "txtNurseScript"
        Me.txtNurseScript.ReadOnly = True
        Me.txtNurseScript.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtNurseScript.ScrollBars = System.Windows.Forms.ScrollBars.Vertical
        Me.txtNurseScript.Size = New System.Drawing.Size(365, 81)
        Me.txtNurseScript.TabIndex = 0
        Me.txtNurseScript.TabStop = False
        '
        'LblRelation
        '
        Me.LblRelation.BackColor = System.Drawing.SystemColors.Control
        Me.LblRelation.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblRelation.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblRelation.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblRelation.Location = New System.Drawing.Point(16, 142)
        Me.LblRelation.Name = "LblRelation"
        Me.LblRelation.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblRelation.Size = New System.Drawing.Size(45, 15)
        Me.LblRelation.TabIndex = 21
        Me.LblRelation.Text = "Relation"
        '
        'LblAddress
        '
        Me.LblAddress.BackColor = System.Drawing.SystemColors.Control
        Me.LblAddress.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblAddress.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblAddress.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblAddress.Location = New System.Drawing.Point(12, 166)
        Me.LblAddress.Name = "LblAddress"
        Me.LblAddress.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblAddress.Size = New System.Drawing.Size(49, 11)
        Me.LblAddress.TabIndex = 20
        Me.LblAddress.Text = "Address"
        '
        'LblFN
        '
        Me.LblFN.BackColor = System.Drawing.SystemColors.Control
        Me.LblFN.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblFN.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblFN.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblFN.Location = New System.Drawing.Point(3, 114)
        Me.LblFN.Name = "LblFN"
        Me.LblFN.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblFN.Size = New System.Drawing.Size(58, 19)
        Me.LblFN.TabIndex = 19
        Me.LblFN.Text = "First Name"
        '
        'LblZip
        '
        Me.LblZip.BackColor = System.Drawing.SystemColors.Control
        Me.LblZip.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblZip.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblZip.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblZip.Location = New System.Drawing.Point(288, 232)
        Me.LblZip.Name = "LblZip"
        Me.LblZip.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblZip.Size = New System.Drawing.Size(22, 15)
        Me.LblZip.TabIndex = 18
        Me.LblZip.Text = "Zip"
        '
        'LblState
        '
        Me.LblState.BackColor = System.Drawing.SystemColors.Control
        Me.LblState.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblState.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblState.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblState.Location = New System.Drawing.Point(194, 232)
        Me.LblState.Name = "LblState"
        Me.LblState.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblState.Size = New System.Drawing.Size(32, 15)
        Me.LblState.TabIndex = 17
        Me.LblState.Text = "State"
        '
        'LblCity
        '
        Me.LblCity.BackColor = System.Drawing.SystemColors.Control
        Me.LblCity.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblCity.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblCity.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblCity.Location = New System.Drawing.Point(36, 232)
        Me.LblCity.Name = "LblCity"
        Me.LblCity.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblCity.Size = New System.Drawing.Size(25, 15)
        Me.LblCity.TabIndex = 16
        Me.LblCity.Text = "City"
        '
        'LblPhone
        '
        Me.LblPhone.BackColor = System.Drawing.SystemColors.Control
        Me.LblPhone.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblPhone.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblPhone.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblPhone.Location = New System.Drawing.Point(206, 140)
        Me.LblPhone.Name = "LblPhone"
        Me.LblPhone.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblPhone.Size = New System.Drawing.Size(37, 19)
        Me.LblPhone.TabIndex = 15
        Me.LblPhone.Text = "Phone"
        '
        'LblLN
        '
        Me.LblLN.BackColor = System.Drawing.SystemColors.Control
        Me.LblLN.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblLN.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblLN.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblLN.Location = New System.Drawing.Point(185, 118)
        Me.LblLN.Name = "LblLN"
        Me.LblLN.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblLN.Size = New System.Drawing.Size(58, 11)
        Me.LblLN.TabIndex = 14
        Me.LblLN.Text = "Last Name"
        '
        'lblRegType
        '
        Me.lblRegType.BackColor = System.Drawing.SystemColors.Control
        Me.lblRegType.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblRegType.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblRegType.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblRegType.Location = New System.Drawing.Point(8, 8)
        Me.lblRegType.Name = "lblRegType"
        Me.lblRegType.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblRegType.Size = New System.Drawing.Size(241, 17)
        Me.lblRegType.TabIndex = 13
        Me.lblRegType.Text = "Patient registered as donor in Donor Registry"
        Me.lblRegType.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        'Frame1
        '
        Me.Frame1.BackColor = System.Drawing.SystemColors.Control
        Me.Frame1.Controls.Add(Me.txtoldNurseScript)
        Me.Frame1.Controls.Add(Me.TxtOldAddress)
        Me.Frame1.Controls.Add(Me.CboOldRelation)
        Me.Frame1.Controls.Add(Me.TxtNOK)
        Me.Frame1.Controls.Add(Me.TxtOldPhone)
        Me.Frame1.Controls.Add(Me.LblOldAddress)
        Me.Frame1.Controls.Add(Me.LblOldRelation)
        Me.Frame1.Controls.Add(Me.LblNOK)
        Me.Frame1.Controls.Add(Me.lbloldRegType)
        Me.Frame1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Frame1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame1.Location = New System.Drawing.Point(4, 2)
        Me.Frame1.Name = "Frame1"
        Me.Frame1.Padding = New System.Windows.Forms.Padding(0)
        Me.Frame1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame1.Size = New System.Drawing.Size(257, 223)
        Me.Frame1.TabIndex = 22
        Me.Frame1.TabStop = False
        '
        'txtoldNurseScript
        '
        Me.txtoldNurseScript.AcceptsReturn = True
        Me.txtoldNurseScript.BackColor = System.Drawing.Color.White
        Me.txtoldNurseScript.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtoldNurseScript.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtoldNurseScript.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtoldNurseScript.Location = New System.Drawing.Point(8, 24)
        Me.txtoldNurseScript.MaxLength = 0
        Me.txtoldNurseScript.Multiline = True
        Me.txtoldNurseScript.Name = "txtoldNurseScript"
        Me.txtoldNurseScript.ReadOnly = True
        Me.txtoldNurseScript.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtoldNurseScript.ScrollBars = System.Windows.Forms.ScrollBars.Vertical
        Me.txtoldNurseScript.Size = New System.Drawing.Size(241, 81)
        Me.txtoldNurseScript.TabIndex = 27
        Me.txtoldNurseScript.TabStop = False
        '
        'TxtOldAddress
        '
        Me.TxtOldAddress.AcceptsReturn = True
        Me.TxtOldAddress.BackColor = System.Drawing.Color.White
        Me.TxtOldAddress.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtOldAddress.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtOldAddress.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtOldAddress.Location = New System.Drawing.Point(70, 159)
        Me.TxtOldAddress.MaxLength = 50
        Me.TxtOldAddress.Multiline = True
        Me.TxtOldAddress.Name = "TxtOldAddress"
        Me.TxtOldAddress.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtOldAddress.Size = New System.Drawing.Size(177, 59)
        Me.TxtOldAddress.TabIndex = 26
        '
        'CboOldRelation
        '
        Me.CboOldRelation.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboOldRelation.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboOldRelation.BackColor = System.Drawing.Color.White
        Me.CboOldRelation.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboOldRelation.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboOldRelation.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboOldRelation.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboOldRelation.Items.AddRange(New Object() {"Adult Child", "Adult Sibling", "Guardian", "Other", "Parent", "Representative", "Spouse", "Unknown"})
        Me.CboOldRelation.Location = New System.Drawing.Point(70, 135)
        Me.CboOldRelation.Name = "CboOldRelation"
        Me.CboOldRelation.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboOldRelation.Size = New System.Drawing.Size(81, 22)
        Me.CboOldRelation.Sorted = True
        Me.CboOldRelation.TabIndex = 25
        '
        'TxtNOK
        '
        Me.TxtNOK.AcceptsReturn = True
        Me.TxtNOK.BackColor = System.Drawing.Color.White
        Me.TxtNOK.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtNOK.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtNOK.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtNOK.Location = New System.Drawing.Point(70, 112)
        Me.TxtNOK.MaxLength = 0
        Me.TxtNOK.Name = "TxtNOK"
        Me.TxtNOK.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtNOK.Size = New System.Drawing.Size(177, 20)
        Me.TxtNOK.TabIndex = 24
        '
        'TxtOldPhone
        '
        Me.TxtOldPhone.AcceptsReturn = True
        Me.TxtOldPhone.BackColor = System.Drawing.Color.White
        Me.TxtOldPhone.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtOldPhone.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtOldPhone.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtOldPhone.Location = New System.Drawing.Point(166, 135)
        Me.TxtOldPhone.MaxLength = 0
        Me.TxtOldPhone.Name = "TxtOldPhone"
        Me.TxtOldPhone.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtOldPhone.Size = New System.Drawing.Size(81, 20)
        Me.TxtOldPhone.TabIndex = 23
        '
        'LblOldAddress
        '
        Me.LblOldAddress.BackColor = System.Drawing.SystemColors.Control
        Me.LblOldAddress.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblOldAddress.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblOldAddress.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblOldAddress.Location = New System.Drawing.Point(10, 162)
        Me.LblOldAddress.Name = "LblOldAddress"
        Me.LblOldAddress.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblOldAddress.Size = New System.Drawing.Size(43, 15)
        Me.LblOldAddress.TabIndex = 31
        Me.LblOldAddress.Text = "Address"
        '
        'LblOldRelation
        '
        Me.LblOldRelation.BackColor = System.Drawing.SystemColors.Control
        Me.LblOldRelation.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblOldRelation.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblOldRelation.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblOldRelation.Location = New System.Drawing.Point(10, 140)
        Me.LblOldRelation.Name = "LblOldRelation"
        Me.LblOldRelation.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblOldRelation.Size = New System.Drawing.Size(61, 15)
        Me.LblOldRelation.TabIndex = 30
        Me.LblOldRelation.Text = "Relation"
        '
        'LblNOK
        '
        Me.LblNOK.BackColor = System.Drawing.SystemColors.Control
        Me.LblNOK.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblNOK.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblNOK.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblNOK.Location = New System.Drawing.Point(10, 116)
        Me.LblNOK.Name = "LblNOK"
        Me.LblNOK.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblNOK.Size = New System.Drawing.Size(59, 17)
        Me.LblNOK.TabIndex = 29
        Me.LblNOK.Text = "Next of Kin"
        '
        'lbloldRegType
        '
        Me.lbloldRegType.BackColor = System.Drawing.SystemColors.Control
        Me.lbloldRegType.Cursor = System.Windows.Forms.Cursors.Default
        Me.lbloldRegType.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lbloldRegType.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lbloldRegType.Location = New System.Drawing.Point(14, 10)
        Me.lbloldRegType.Name = "lbloldRegType"
        Me.lbloldRegType.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lbloldRegType.Size = New System.Drawing.Size(241, 17)
        Me.lbloldRegType.TabIndex = 28
        Me.lbloldRegType.Text = "Patient registered as donor in Donor Registry"
        Me.lbloldRegType.TextAlign = System.Drawing.ContentAlignment.TopCenter
        '
        'FrmDonorIntent
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 14.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.ClientSize = New System.Drawing.Size(494, 265)
        Me.ControlBox = False
        Me.Controls.Add(Me.cmdCancel)
        Me.Controls.Add(Me.cmdContinue)
        Me.Controls.Add(Me.Frame2)
        Me.Controls.Add(Me.Frame1)
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.Location = New System.Drawing.Point(47, 62)
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "FrmDonorIntent"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Next of Kin"
        Me.Frame2.ResumeLayout(False)
        Me.Frame2.PerformLayout()
        Me.Frame1.ResumeLayout(False)
        Me.Frame1.PerformLayout()
        Me.ResumeLayout(False)

    End Sub
#End Region 
End Class