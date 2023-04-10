<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmOrganization
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
	Public WithEvents ChkVerified As System.Windows.Forms.CheckBox
	Public WithEvents CmdProperties As System.Windows.Forms.Button
	Public WithEvents CmdDelete As System.Windows.Forms.Button
	Public WithEvents _OptActive_1 As System.Windows.Forms.RadioButton
	Public WithEvents _OptActive_0 As System.Windows.Forms.RadioButton
	Public WithEvents CmdPrintList As System.Windows.Forms.Button
	Public WithEvents CmdNew As System.Windows.Forms.Button
	Public WithEvents CmdOpen As System.Windows.Forms.Button
	Public WithEvents LstViewPerson As System.Windows.Forms.ListView
	Public WithEvents FraContactInfo As System.Windows.Forms.GroupBox
	Public WithEvents CmdOK As System.Windows.Forms.Button
	Public WithEvents CmdCancel As System.Windows.Forms.Button
	Public WithEvents TxtCode As System.Windows.Forms.TextBox
	Public WithEvents CboTimeZone As System.Windows.Forms.ComboBox
	Public WithEvents TxtNotes As System.Windows.Forms.TextBox
	Public WithEvents CmdCountyDetail As System.Windows.Forms.Button
	Public WithEvents CboCounty As System.Windows.Forms.ComboBox
	Public WithEvents CmdOrganizationTypeDetail As System.Windows.Forms.Button
	Public WithEvents TxtZipCode As System.Windows.Forms.TextBox
	Public WithEvents TxtCentralPhone As System.Windows.Forms.TextBox
	Public WithEvents CboOrganizationType As System.Windows.Forms.ComboBox
	Public WithEvents CboState As System.Windows.Forms.ComboBox
	Public WithEvents TxtCity As System.Windows.Forms.TextBox
	Public WithEvents TxtAddress2 As System.Windows.Forms.TextBox
	Public WithEvents TxtAddress1 As System.Windows.Forms.TextBox
	Public WithEvents TxtName As System.Windows.Forms.TextBox
	Public WithEvents _LblOrganization_9 As System.Windows.Forms.Label
	Public WithEvents _LblOrganization_8 As System.Windows.Forms.Label
	Public WithEvents _LblOrganization_11 As System.Windows.Forms.Label
	Public WithEvents _LblOrganization_10 As System.Windows.Forms.Label
	Public WithEvents _LblOrganization_7 As System.Windows.Forms.Label
	Public WithEvents _LblOrganization_6 As System.Windows.Forms.Label
	Public WithEvents _LblOrganization_5 As System.Windows.Forms.Label
	Public WithEvents _LblOrganization_4 As System.Windows.Forms.Label
	Public WithEvents _LblOrganization_3 As System.Windows.Forms.Label
	Public WithEvents _LblOrganization_2 As System.Windows.Forms.Label
	Public WithEvents _LblOrganization_1 As System.Windows.Forms.Label
	Public WithEvents _LblOrganization_0 As System.Windows.Forms.Label
	Public WithEvents FraOrgInfo As System.Windows.Forms.GroupBox
	Public WithEvents LblOrganization As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
	Public WithEvents OptActive As Microsoft.VisualBasic.Compatibility.VB6.RadioButtonArray
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FrmOrganization))
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.ChkVerified = New System.Windows.Forms.CheckBox
        Me.CmdProperties = New System.Windows.Forms.Button
        Me.FraContactInfo = New System.Windows.Forms.GroupBox
        Me.CmdDelete = New System.Windows.Forms.Button
        Me._OptActive_1 = New System.Windows.Forms.RadioButton
        Me._OptActive_0 = New System.Windows.Forms.RadioButton
        Me.CmdPrintList = New System.Windows.Forms.Button
        Me.CmdNew = New System.Windows.Forms.Button
        Me.CmdOpen = New System.Windows.Forms.Button
        Me.LstViewPerson = New System.Windows.Forms.ListView
        Me.CmdOK = New System.Windows.Forms.Button
        Me.CmdCancel = New System.Windows.Forms.Button
        Me.FraOrgInfo = New System.Windows.Forms.GroupBox
        Me.TxtCode = New System.Windows.Forms.TextBox
        Me.CboTimeZone = New System.Windows.Forms.ComboBox
        Me.TxtNotes = New System.Windows.Forms.TextBox
        Me.CmdCountyDetail = New System.Windows.Forms.Button
        Me.CboCounty = New System.Windows.Forms.ComboBox
        Me.CmdOrganizationTypeDetail = New System.Windows.Forms.Button
        Me.TxtZipCode = New System.Windows.Forms.TextBox
        Me.TxtCentralPhone = New System.Windows.Forms.TextBox
        Me.CboOrganizationType = New System.Windows.Forms.ComboBox
        Me.CboState = New System.Windows.Forms.ComboBox
        Me.TxtCity = New System.Windows.Forms.TextBox
        Me.TxtAddress2 = New System.Windows.Forms.TextBox
        Me.TxtAddress1 = New System.Windows.Forms.TextBox
        Me.TxtName = New System.Windows.Forms.TextBox
        Me._LblOrganization_9 = New System.Windows.Forms.Label
        Me._LblOrganization_8 = New System.Windows.Forms.Label
        Me._LblOrganization_11 = New System.Windows.Forms.Label
        Me._LblOrganization_10 = New System.Windows.Forms.Label
        Me._LblOrganization_7 = New System.Windows.Forms.Label
        Me._LblOrganization_6 = New System.Windows.Forms.Label
        Me._LblOrganization_5 = New System.Windows.Forms.Label
        Me._LblOrganization_4 = New System.Windows.Forms.Label
        Me._LblOrganization_3 = New System.Windows.Forms.Label
        Me._LblOrganization_2 = New System.Windows.Forms.Label
        Me._LblOrganization_1 = New System.Windows.Forms.Label
        Me._LblOrganization_0 = New System.Windows.Forms.Label
        Me.LblOrganization = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(Me.components)
        Me.OptActive = New Microsoft.VisualBasic.Compatibility.VB6.RadioButtonArray(Me.components)
        Me.FraContactInfo.SuspendLayout()
        Me.FraOrgInfo.SuspendLayout()
        CType(Me.LblOrganization, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.OptActive, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'ChkVerified
        '
        Me.ChkVerified.BackColor = System.Drawing.SystemColors.Control
        Me.ChkVerified.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkVerified.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkVerified.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkVerified.Location = New System.Drawing.Point(694, 74)
        Me.ChkVerified.Name = "ChkVerified"
        Me.ChkVerified.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkVerified.Size = New System.Drawing.Size(81, 17)
        Me.ChkVerified.TabIndex = 33
        Me.ChkVerified.Text = "Verified"
        Me.ChkVerified.UseVisualStyleBackColor = False
        '
        'CmdProperties
        '
        Me.CmdProperties.BackColor = System.Drawing.SystemColors.Control
        Me.CmdProperties.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdProperties.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdProperties.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdProperties.Location = New System.Drawing.Point(696, 156)
        Me.CmdProperties.Name = "CmdProperties"
        Me.CmdProperties.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdProperties.Size = New System.Drawing.Size(84, 21)
        Me.CmdProperties.TabIndex = 34
        Me.CmdProperties.Text = "&Properties..."
        Me.CmdProperties.UseVisualStyleBackColor = False
        '
        'FraContactInfo
        '
        Me.FraContactInfo.BackColor = System.Drawing.SystemColors.Control
        Me.FraContactInfo.Controls.Add(Me.CmdDelete)
        Me.FraContactInfo.Controls.Add(Me._OptActive_1)
        Me.FraContactInfo.Controls.Add(Me._OptActive_0)
        Me.FraContactInfo.Controls.Add(Me.CmdPrintList)
        Me.FraContactInfo.Controls.Add(Me.CmdNew)
        Me.FraContactInfo.Controls.Add(Me.CmdOpen)
        Me.FraContactInfo.Controls.Add(Me.LstViewPerson)
        Me.FraContactInfo.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FraContactInfo.ForeColor = System.Drawing.SystemColors.ControlText
        Me.FraContactInfo.Location = New System.Drawing.Point(348, 4)
        Me.FraContactInfo.Name = "FraContactInfo"
        Me.FraContactInfo.Padding = New System.Windows.Forms.Padding(0)
        Me.FraContactInfo.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.FraContactInfo.Size = New System.Drawing.Size(341, 315)
        Me.FraContactInfo.TabIndex = 31
        Me.FraContactInfo.TabStop = False
        Me.FraContactInfo.Text = "Organization People"
        '
        'CmdDelete
        '
        Me.CmdDelete.BackColor = System.Drawing.SystemColors.Control
        Me.CmdDelete.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdDelete.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdDelete.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdDelete.Location = New System.Drawing.Point(16, 288)
        Me.CmdDelete.Name = "CmdDelete"
        Me.CmdDelete.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdDelete.Size = New System.Drawing.Size(79, 21)
        Me.CmdDelete.TabIndex = 18
        Me.CmdDelete.Text = "&Delete"
        Me.CmdDelete.UseVisualStyleBackColor = False
        '
        '_OptActive_1
        '
        Me._OptActive_1.BackColor = System.Drawing.SystemColors.Control
        Me._OptActive_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._OptActive_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._OptActive_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.OptActive.SetIndex(Me._OptActive_1, CType(1, Short))
        Me._OptActive_1.Location = New System.Drawing.Point(78, 50)
        Me._OptActive_1.Name = "_OptActive_1"
        Me._OptActive_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._OptActive_1.Size = New System.Drawing.Size(63, 15)
        Me._OptActive_1.TabIndex = 16
        Me._OptActive_1.TabStop = True
        Me._OptActive_1.Text = "Inactive"
        Me._OptActive_1.UseVisualStyleBackColor = False
        '
        '_OptActive_0
        '
        Me._OptActive_0.BackColor = System.Drawing.SystemColors.Control
        Me._OptActive_0.Checked = True
        Me._OptActive_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._OptActive_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._OptActive_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.OptActive.SetIndex(Me._OptActive_0, CType(0, Short))
        Me._OptActive_0.Location = New System.Drawing.Point(18, 50)
        Me._OptActive_0.Name = "_OptActive_0"
        Me._OptActive_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._OptActive_0.Size = New System.Drawing.Size(63, 15)
        Me._OptActive_0.TabIndex = 15
        Me._OptActive_0.TabStop = True
        Me._OptActive_0.Text = "Active"
        Me._OptActive_0.UseVisualStyleBackColor = False
        '
        'CmdPrintList
        '
        Me.CmdPrintList.BackColor = System.Drawing.SystemColors.Control
        Me.CmdPrintList.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdPrintList.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdPrintList.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdPrintList.Location = New System.Drawing.Point(252, 22)
        Me.CmdPrintList.Name = "CmdPrintList"
        Me.CmdPrintList.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdPrintList.Size = New System.Drawing.Size(79, 21)
        Me.CmdPrintList.TabIndex = 19
        Me.CmdPrintList.Text = "&Print"
        Me.CmdPrintList.UseVisualStyleBackColor = False
        '
        'CmdNew
        '
        Me.CmdNew.BackColor = System.Drawing.SystemColors.Control
        Me.CmdNew.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdNew.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdNew.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdNew.Location = New System.Drawing.Point(102, 22)
        Me.CmdNew.Name = "CmdNew"
        Me.CmdNew.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdNew.Size = New System.Drawing.Size(80, 21)
        Me.CmdNew.TabIndex = 14
        Me.CmdNew.Text = "&New"
        Me.CmdNew.UseVisualStyleBackColor = False
        '
        'CmdOpen
        '
        Me.CmdOpen.BackColor = System.Drawing.SystemColors.Control
        Me.CmdOpen.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdOpen.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdOpen.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdOpen.Location = New System.Drawing.Point(18, 22)
        Me.CmdOpen.Name = "CmdOpen"
        Me.CmdOpen.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdOpen.Size = New System.Drawing.Size(80, 21)
        Me.CmdOpen.TabIndex = 13
        Me.CmdOpen.Text = "O&pen..."
        Me.CmdOpen.UseVisualStyleBackColor = False
        '
        'LstViewPerson
        '
        Me.LstViewPerson.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewPerson.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.LstViewPerson.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewPerson.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewPerson.FullRowSelect = True
        Me.LstViewPerson.HideSelection = False
        Me.LstViewPerson.LabelEdit = True
        Me.LstViewPerson.LabelWrap = False
        Me.LstViewPerson.Location = New System.Drawing.Point(18, 70)
        Me.LstViewPerson.Name = "LstViewPerson"
        Me.LstViewPerson.Size = New System.Drawing.Size(313, 211)
        Me.LstViewPerson.TabIndex = 17
        Me.LstViewPerson.UseCompatibleStateImageBehavior = False
        Me.LstViewPerson.View = System.Windows.Forms.View.Details
        '
        'CmdOK
        '
        Me.CmdOK.BackColor = System.Drawing.SystemColors.Control
        Me.CmdOK.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdOK.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdOK.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdOK.Location = New System.Drawing.Point(696, 8)
        Me.CmdOK.Name = "CmdOK"
        Me.CmdOK.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdOK.Size = New System.Drawing.Size(84, 21)
        Me.CmdOK.TabIndex = 32
        Me.CmdOK.Text = "&Save"
        Me.CmdOK.UseVisualStyleBackColor = False
        '
        'CmdCancel
        '
        Me.CmdCancel.BackColor = System.Drawing.SystemColors.Control
        Me.CmdCancel.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdCancel.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdCancel.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdCancel.Location = New System.Drawing.Point(696, 298)
        Me.CmdCancel.Name = "CmdCancel"
        Me.CmdCancel.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdCancel.Size = New System.Drawing.Size(84, 21)
        Me.CmdCancel.TabIndex = 35
        Me.CmdCancel.Text = "C&ancel"
        Me.CmdCancel.UseVisualStyleBackColor = False
        '
        'FraOrgInfo
        '
        Me.FraOrgInfo.BackColor = System.Drawing.SystemColors.Control
        Me.FraOrgInfo.Controls.Add(Me.TxtCode)
        Me.FraOrgInfo.Controls.Add(Me.CboTimeZone)
        Me.FraOrgInfo.Controls.Add(Me.TxtNotes)
        Me.FraOrgInfo.Controls.Add(Me.CmdCountyDetail)
        Me.FraOrgInfo.Controls.Add(Me.CboCounty)
        Me.FraOrgInfo.Controls.Add(Me.CmdOrganizationTypeDetail)
        Me.FraOrgInfo.Controls.Add(Me.TxtZipCode)
        Me.FraOrgInfo.Controls.Add(Me.TxtCentralPhone)
        Me.FraOrgInfo.Controls.Add(Me.CboOrganizationType)
        Me.FraOrgInfo.Controls.Add(Me.CboState)
        Me.FraOrgInfo.Controls.Add(Me.TxtCity)
        Me.FraOrgInfo.Controls.Add(Me.TxtAddress2)
        Me.FraOrgInfo.Controls.Add(Me.TxtAddress1)
        Me.FraOrgInfo.Controls.Add(Me.TxtName)
        Me.FraOrgInfo.Controls.Add(Me._LblOrganization_9)
        Me.FraOrgInfo.Controls.Add(Me._LblOrganization_8)
        Me.FraOrgInfo.Controls.Add(Me._LblOrganization_11)
        Me.FraOrgInfo.Controls.Add(Me._LblOrganization_10)
        Me.FraOrgInfo.Controls.Add(Me._LblOrganization_7)
        Me.FraOrgInfo.Controls.Add(Me._LblOrganization_6)
        Me.FraOrgInfo.Controls.Add(Me._LblOrganization_5)
        Me.FraOrgInfo.Controls.Add(Me._LblOrganization_4)
        Me.FraOrgInfo.Controls.Add(Me._LblOrganization_3)
        Me.FraOrgInfo.Controls.Add(Me._LblOrganization_2)
        Me.FraOrgInfo.Controls.Add(Me._LblOrganization_1)
        Me.FraOrgInfo.Controls.Add(Me._LblOrganization_0)
        Me.FraOrgInfo.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FraOrgInfo.ForeColor = System.Drawing.SystemColors.ControlText
        Me.FraOrgInfo.Location = New System.Drawing.Point(4, 4)
        Me.FraOrgInfo.Name = "FraOrgInfo"
        Me.FraOrgInfo.Padding = New System.Windows.Forms.Padding(0)
        Me.FraOrgInfo.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.FraOrgInfo.Size = New System.Drawing.Size(341, 315)
        Me.FraOrgInfo.TabIndex = 21
        Me.FraOrgInfo.TabStop = False
        Me.FraOrgInfo.Text = "Information"
        '
        'TxtCode
        '
        Me.TxtCode.AcceptsReturn = True
        Me.TxtCode.BackColor = System.Drawing.SystemColors.Window
        Me.TxtCode.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtCode.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtCode.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtCode.Location = New System.Drawing.Point(82, 190)
        Me.TxtCode.MaxLength = 0
        Me.TxtCode.Name = "TxtCode"
        Me.TxtCode.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtCode.Size = New System.Drawing.Size(120, 20)
        Me.TxtCode.TabIndex = 12
        '
        'CboTimeZone
        '
        Me.CboTimeZone.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboTimeZone.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboTimeZone.BackColor = System.Drawing.SystemColors.Window
        Me.CboTimeZone.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboTimeZone.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboTimeZone.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboTimeZone.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboTimeZone.Items.AddRange(New Object() {"AS", "AT", "ES", "ET", "CS", "CT", "MS", "MT", "PS", "PT", "KS", "KT", "HS", "HT", "SS", "ST"})
        Me.CboTimeZone.Location = New System.Drawing.Point(274, 142)
        Me.CboTimeZone.Name = "CboTimeZone"
        Me.CboTimeZone.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboTimeZone.Size = New System.Drawing.Size(59, 22)
        Me.CboTimeZone.TabIndex = 9
        '
        'TxtNotes
        '
        Me.TxtNotes.AcceptsReturn = True
        Me.TxtNotes.BackColor = System.Drawing.SystemColors.Window
        Me.TxtNotes.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtNotes.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtNotes.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtNotes.Location = New System.Drawing.Point(83, 214)
        Me.TxtNotes.MaxLength = 255
        Me.TxtNotes.Multiline = True
        Me.TxtNotes.Name = "TxtNotes"
        Me.TxtNotes.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtNotes.ScrollBars = System.Windows.Forms.ScrollBars.Vertical
        Me.TxtNotes.Size = New System.Drawing.Size(249, 93)
        Me.TxtNotes.TabIndex = 13
        '
        'CmdCountyDetail
        '
        Me.CmdCountyDetail.BackColor = System.Drawing.SystemColors.Control
        Me.CmdCountyDetail.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdCountyDetail.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdCountyDetail.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdCountyDetail.Location = New System.Drawing.Point(206, 119)
        Me.CmdCountyDetail.Name = "CmdCountyDetail"
        Me.CmdCountyDetail.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdCountyDetail.Size = New System.Drawing.Size(17, 21)
        Me.CmdCountyDetail.TabIndex = 6
        Me.CmdCountyDetail.Text = "..."
        Me.CmdCountyDetail.UseVisualStyleBackColor = False
        '
        'CboCounty
        '
        Me.CboCounty.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboCounty.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboCounty.BackColor = System.Drawing.SystemColors.Window
        Me.CboCounty.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboCounty.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboCounty.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboCounty.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboCounty.Location = New System.Drawing.Point(83, 118)
        Me.CboCounty.Name = "CboCounty"
        Me.CboCounty.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboCounty.Size = New System.Drawing.Size(120, 22)
        Me.CboCounty.Sorted = True
        Me.CboCounty.TabIndex = 5
        '
        'CmdOrganizationTypeDetail
        '
        Me.CmdOrganizationTypeDetail.BackColor = System.Drawing.SystemColors.Control
        Me.CmdOrganizationTypeDetail.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdOrganizationTypeDetail.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdOrganizationTypeDetail.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdOrganizationTypeDetail.Location = New System.Drawing.Point(315, 166)
        Me.CmdOrganizationTypeDetail.Name = "CmdOrganizationTypeDetail"
        Me.CmdOrganizationTypeDetail.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdOrganizationTypeDetail.Size = New System.Drawing.Size(17, 21)
        Me.CmdOrganizationTypeDetail.TabIndex = 11
        Me.CmdOrganizationTypeDetail.Text = "..."
        Me.CmdOrganizationTypeDetail.UseVisualStyleBackColor = False
        '
        'TxtZipCode
        '
        Me.TxtZipCode.AcceptsReturn = True
        Me.TxtZipCode.BackColor = System.Drawing.SystemColors.Window
        Me.TxtZipCode.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtZipCode.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtZipCode.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtZipCode.Location = New System.Drawing.Point(273, 119)
        Me.TxtZipCode.MaxLength = 6
        Me.TxtZipCode.Name = "TxtZipCode"
        Me.TxtZipCode.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtZipCode.Size = New System.Drawing.Size(59, 20)
        Me.TxtZipCode.TabIndex = 7
        '
        'TxtCentralPhone
        '
        Me.TxtCentralPhone.AcceptsReturn = True
        Me.TxtCentralPhone.BackColor = System.Drawing.SystemColors.Window
        Me.TxtCentralPhone.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtCentralPhone.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtCentralPhone.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtCentralPhone.Location = New System.Drawing.Point(83, 142)
        Me.TxtCentralPhone.MaxLength = 0
        Me.TxtCentralPhone.Name = "TxtCentralPhone"
        Me.TxtCentralPhone.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtCentralPhone.Size = New System.Drawing.Size(120, 20)
        Me.TxtCentralPhone.TabIndex = 8
        '
        'CboOrganizationType
        '
        Me.CboOrganizationType.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboOrganizationType.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboOrganizationType.BackColor = System.Drawing.SystemColors.Window
        Me.CboOrganizationType.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboOrganizationType.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboOrganizationType.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboOrganizationType.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboOrganizationType.Location = New System.Drawing.Point(83, 166)
        Me.CboOrganizationType.Name = "CboOrganizationType"
        Me.CboOrganizationType.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboOrganizationType.Size = New System.Drawing.Size(229, 22)
        Me.CboOrganizationType.Sorted = True
        Me.CboOrganizationType.TabIndex = 10
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
        Me.CboState.Location = New System.Drawing.Point(273, 93)
        Me.CboState.Name = "CboState"
        Me.CboState.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboState.Size = New System.Drawing.Size(59, 22)
        Me.CboState.Sorted = True
        Me.CboState.TabIndex = 4
        '
        'TxtCity
        '
        Me.TxtCity.AcceptsReturn = True
        Me.TxtCity.BackColor = System.Drawing.SystemColors.Window
        Me.TxtCity.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtCity.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtCity.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtCity.Location = New System.Drawing.Point(83, 94)
        Me.TxtCity.MaxLength = 0
        Me.TxtCity.Name = "TxtCity"
        Me.TxtCity.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtCity.Size = New System.Drawing.Size(140, 20)
        Me.TxtCity.TabIndex = 3
        '
        'TxtAddress2
        '
        Me.TxtAddress2.AcceptsReturn = True
        Me.TxtAddress2.BackColor = System.Drawing.SystemColors.Window
        Me.TxtAddress2.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtAddress2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtAddress2.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtAddress2.Location = New System.Drawing.Point(83, 70)
        Me.TxtAddress2.MaxLength = 0
        Me.TxtAddress2.Name = "TxtAddress2"
        Me.TxtAddress2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtAddress2.Size = New System.Drawing.Size(249, 20)
        Me.TxtAddress2.TabIndex = 2
        '
        'TxtAddress1
        '
        Me.TxtAddress1.AcceptsReturn = True
        Me.TxtAddress1.BackColor = System.Drawing.SystemColors.Window
        Me.TxtAddress1.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtAddress1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtAddress1.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtAddress1.Location = New System.Drawing.Point(83, 46)
        Me.TxtAddress1.MaxLength = 0
        Me.TxtAddress1.Name = "TxtAddress1"
        Me.TxtAddress1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtAddress1.Size = New System.Drawing.Size(249, 20)
        Me.TxtAddress1.TabIndex = 1
        '
        'TxtName
        '
        Me.TxtName.AcceptsReturn = True
        Me.TxtName.BackColor = System.Drawing.SystemColors.Window
        Me.TxtName.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtName.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtName.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtName.Location = New System.Drawing.Point(83, 22)
        Me.TxtName.MaxLength = 0
        Me.TxtName.Name = "TxtName"
        Me.TxtName.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtName.Size = New System.Drawing.Size(249, 20)
        Me.TxtName.TabIndex = 0
        '
        '_LblOrganization_9
        '
        Me._LblOrganization_9.AutoSize = True
        Me._LblOrganization_9.BackColor = System.Drawing.SystemColors.Control
        Me._LblOrganization_9.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblOrganization_9.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LblOrganization_9.ForeColor = System.Drawing.SystemColors.ControlText
        Me._LblOrganization_9.ImageAlign = System.Drawing.ContentAlignment.MiddleRight
        Me.LblOrganization.SetIndex(Me._LblOrganization_9, CType(9, Short))
        Me._LblOrganization_9.Location = New System.Drawing.Point(13, 193)
        Me._LblOrganization_9.Name = "_LblOrganization_9"
        Me._LblOrganization_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblOrganization_9.Size = New System.Drawing.Size(65, 14)
        Me._LblOrganization_9.TabIndex = 34
        Me._LblOrganization_9.Text = "Code/Abbrv"
        '
        '_LblOrganization_8
        '
        Me._LblOrganization_8.AutoSize = True
        Me._LblOrganization_8.BackColor = System.Drawing.SystemColors.Control
        Me._LblOrganization_8.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblOrganization_8.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LblOrganization_8.ForeColor = System.Drawing.SystemColors.ControlText
        Me._LblOrganization_8.ImageAlign = System.Drawing.ContentAlignment.MiddleRight
        Me.LblOrganization.SetIndex(Me._LblOrganization_8, CType(8, Short))
        Me._LblOrganization_8.Location = New System.Drawing.Point(217, 146)
        Me._LblOrganization_8.Name = "_LblOrganization_8"
        Me._LblOrganization_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblOrganization_8.Size = New System.Drawing.Size(57, 14)
        Me._LblOrganization_8.TabIndex = 32
        Me._LblOrganization_8.Text = "Time Zone"
        '
        '_LblOrganization_11
        '
        Me._LblOrganization_11.AutoSize = True
        Me._LblOrganization_11.BackColor = System.Drawing.SystemColors.Control
        Me._LblOrganization_11.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblOrganization_11.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LblOrganization_11.ForeColor = System.Drawing.SystemColors.ControlText
        Me._LblOrganization_11.ImageAlign = System.Drawing.ContentAlignment.MiddleRight
        Me.LblOrganization.SetIndex(Me._LblOrganization_11, CType(11, Short))
        Me._LblOrganization_11.Location = New System.Drawing.Point(5, 214)
        Me._LblOrganization_11.Name = "_LblOrganization_11"
        Me._LblOrganization_11.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblOrganization_11.Size = New System.Drawing.Size(73, 14)
        Me._LblOrganization_11.TabIndex = 30
        Me._LblOrganization_11.Text = "Special Notes"
        '
        '_LblOrganization_10
        '
        Me._LblOrganization_10.AutoSize = True
        Me._LblOrganization_10.BackColor = System.Drawing.SystemColors.Control
        Me._LblOrganization_10.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblOrganization_10.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LblOrganization_10.ForeColor = System.Drawing.SystemColors.ControlText
        Me._LblOrganization_10.ImageAlign = System.Drawing.ContentAlignment.MiddleRight
        Me.LblOrganization.SetIndex(Me._LblOrganization_10, CType(10, Short))
        Me._LblOrganization_10.Location = New System.Drawing.Point(37, 122)
        Me._LblOrganization_10.Name = "_LblOrganization_10"
        Me._LblOrganization_10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblOrganization_10.Size = New System.Drawing.Size(41, 14)
        Me._LblOrganization_10.TabIndex = 29
        Me._LblOrganization_10.Text = "County"
        '
        '_LblOrganization_7
        '
        Me._LblOrganization_7.AutoSize = True
        Me._LblOrganization_7.BackColor = System.Drawing.SystemColors.Control
        Me._LblOrganization_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblOrganization_7.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LblOrganization_7.ForeColor = System.Drawing.SystemColors.ControlText
        Me._LblOrganization_7.ImageAlign = System.Drawing.ContentAlignment.MiddleRight
        Me.LblOrganization.SetIndex(Me._LblOrganization_7, CType(7, Short))
        Me._LblOrganization_7.Location = New System.Drawing.Point(23, 170)
        Me._LblOrganization_7.Name = "_LblOrganization_7"
        Me._LblOrganization_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblOrganization_7.Size = New System.Drawing.Size(55, 14)
        Me._LblOrganization_7.TabIndex = 28
        Me._LblOrganization_7.Text = "Org. Type"
        '
        '_LblOrganization_6
        '
        Me._LblOrganization_6.AutoSize = True
        Me._LblOrganization_6.BackColor = System.Drawing.SystemColors.Control
        Me._LblOrganization_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblOrganization_6.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LblOrganization_6.ForeColor = System.Drawing.SystemColors.ControlText
        Me._LblOrganization_6.ImageAlign = System.Drawing.ContentAlignment.MiddleRight
        Me.LblOrganization.SetIndex(Me._LblOrganization_6, CType(6, Short))
        Me._LblOrganization_6.Location = New System.Drawing.Point(28, 145)
        Me._LblOrganization_6.Name = "_LblOrganization_6"
        Me._LblOrganization_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblOrganization_6.Size = New System.Drawing.Size(50, 14)
        Me._LblOrganization_6.TabIndex = 27
        Me._LblOrganization_6.Text = "Central #"
        '
        '_LblOrganization_5
        '
        Me._LblOrganization_5.AutoSize = True
        Me._LblOrganization_5.BackColor = System.Drawing.SystemColors.Control
        Me._LblOrganization_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblOrganization_5.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LblOrganization_5.ForeColor = System.Drawing.SystemColors.ControlText
        Me._LblOrganization_5.ImageAlign = System.Drawing.ContentAlignment.MiddleRight
        Me.LblOrganization.SetIndex(Me._LblOrganization_5, CType(5, Short))
        Me._LblOrganization_5.Location = New System.Drawing.Point(252, 122)
        Me._LblOrganization_5.Name = "_LblOrganization_5"
        Me._LblOrganization_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblOrganization_5.Size = New System.Drawing.Size(22, 14)
        Me._LblOrganization_5.TabIndex = 26
        Me._LblOrganization_5.Text = "Zip"
        '
        '_LblOrganization_4
        '
        Me._LblOrganization_4.AutoSize = True
        Me._LblOrganization_4.BackColor = System.Drawing.SystemColors.Control
        Me._LblOrganization_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblOrganization_4.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LblOrganization_4.ForeColor = System.Drawing.SystemColors.ControlText
        Me._LblOrganization_4.ImageAlign = System.Drawing.ContentAlignment.MiddleRight
        Me.LblOrganization.SetIndex(Me._LblOrganization_4, CType(4, Short))
        Me._LblOrganization_4.Location = New System.Drawing.Point(242, 97)
        Me._LblOrganization_4.Name = "_LblOrganization_4"
        Me._LblOrganization_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblOrganization_4.Size = New System.Drawing.Size(32, 14)
        Me._LblOrganization_4.TabIndex = 20
        Me._LblOrganization_4.Text = "State"
        '
        '_LblOrganization_3
        '
        Me._LblOrganization_3.AutoSize = True
        Me._LblOrganization_3.BackColor = System.Drawing.SystemColors.Control
        Me._LblOrganization_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblOrganization_3.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LblOrganization_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me._LblOrganization_3.ImageAlign = System.Drawing.ContentAlignment.MiddleRight
        Me.LblOrganization.SetIndex(Me._LblOrganization_3, CType(3, Short))
        Me._LblOrganization_3.Location = New System.Drawing.Point(53, 97)
        Me._LblOrganization_3.Name = "_LblOrganization_3"
        Me._LblOrganization_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblOrganization_3.Size = New System.Drawing.Size(25, 14)
        Me._LblOrganization_3.TabIndex = 25
        Me._LblOrganization_3.Text = "City"
        '
        '_LblOrganization_2
        '
        Me._LblOrganization_2.AutoSize = True
        Me._LblOrganization_2.BackColor = System.Drawing.SystemColors.Control
        Me._LblOrganization_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblOrganization_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LblOrganization_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me._LblOrganization_2.ImageAlign = System.Drawing.ContentAlignment.MiddleRight
        Me.LblOrganization.SetIndex(Me._LblOrganization_2, CType(2, Short))
        Me._LblOrganization_2.Location = New System.Drawing.Point(20, 73)
        Me._LblOrganization_2.Name = "_LblOrganization_2"
        Me._LblOrganization_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblOrganization_2.Size = New System.Drawing.Size(58, 14)
        Me._LblOrganization_2.TabIndex = 24
        Me._LblOrganization_2.Text = "Address 2"
        '
        '_LblOrganization_1
        '
        Me._LblOrganization_1.AutoSize = True
        Me._LblOrganization_1.BackColor = System.Drawing.SystemColors.Control
        Me._LblOrganization_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblOrganization_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LblOrganization_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me._LblOrganization_1.ImageAlign = System.Drawing.ContentAlignment.MiddleRight
        Me.LblOrganization.SetIndex(Me._LblOrganization_1, CType(1, Short))
        Me._LblOrganization_1.Location = New System.Drawing.Point(20, 49)
        Me._LblOrganization_1.Name = "_LblOrganization_1"
        Me._LblOrganization_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblOrganization_1.Size = New System.Drawing.Size(58, 14)
        Me._LblOrganization_1.TabIndex = 23
        Me._LblOrganization_1.Text = "Address 1"
        '
        '_LblOrganization_0
        '
        Me._LblOrganization_0.AutoSize = True
        Me._LblOrganization_0.BackColor = System.Drawing.SystemColors.Control
        Me._LblOrganization_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblOrganization_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LblOrganization_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me._LblOrganization_0.ImageAlign = System.Drawing.ContentAlignment.MiddleRight
        Me.LblOrganization.SetIndex(Me._LblOrganization_0, CType(0, Short))
        Me._LblOrganization_0.Location = New System.Drawing.Point(44, 25)
        Me._LblOrganization_0.Name = "_LblOrganization_0"
        Me._LblOrganization_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblOrganization_0.Size = New System.Drawing.Size(34, 14)
        Me._LblOrganization_0.TabIndex = 22
        Me._LblOrganization_0.Text = "Name"
        '
        'OptActive
        '
        '
        'FrmOrganization
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 14.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.ClientSize = New System.Drawing.Size(781, 323)
        Me.Controls.Add(Me.ChkVerified)
        Me.Controls.Add(Me.CmdProperties)
        Me.Controls.Add(Me.FraContactInfo)
        Me.Controls.Add(Me.CmdOK)
        Me.Controls.Add(Me.CmdCancel)
        Me.Controls.Add(Me.FraOrgInfo)
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Location = New System.Drawing.Point(93, 295)
        Me.MaximizeBox = False
        Me.Name = "FrmOrganization"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Organization"
        Me.FraContactInfo.ResumeLayout(False)
        Me.FraOrgInfo.ResumeLayout(False)
        Me.FraOrgInfo.PerformLayout()
        CType(Me.LblOrganization, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.OptActive, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)

    End Sub
#End Region 
End Class