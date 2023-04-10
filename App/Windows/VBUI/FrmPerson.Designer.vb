<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmPerson
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
	Public WithEvents ChkInactive As System.Windows.Forms.CheckBox
	Public WithEvents CmdProperties As System.Windows.Forms.Button
	Public WithEvents CmdDelete As System.Windows.Forms.Button
	Public WithEvents TxtBusyUntil As System.Windows.Forms.TextBox
	Public WithEvents ChkBusy As System.Windows.Forms.CheckBox
	Public WithEvents CmdOpen As System.Windows.Forms.Button
	Public WithEvents CmdNew As System.Windows.Forms.Button
	Public WithEvents LstViewPhone As System.Windows.Forms.ListView
	Public WithEvents FraContactInfo As System.Windows.Forms.GroupBox
	Public WithEvents CmdOK As System.Windows.Forms.Button
	Public WithEvents CmdCancel As System.Windows.Forms.Button
	Public WithEvents TxtTempExpires As System.Windows.Forms.TextBox
	Public WithEvents TxtTempNotes As System.Windows.Forms.TextBox
	Public WithEvents ChkTempNote As System.Windows.Forms.CheckBox
	Public WithEvents _SSTab1_TabPage0 As System.Windows.Forms.TabPage
	Public WithEvents _Label_0 As System.Windows.Forms.Label
	Public WithEvents TxtNotes As System.Windows.Forms.TextBox
	Public WithEvents _SSTab1_TabPage1 As System.Windows.Forms.TabPage
	Public WithEvents SSTab1 As System.Windows.Forms.TabControl
	Public WithEvents TxtMI As System.Windows.Forms.TextBox
	Public WithEvents CmdOrganizationDetail As System.Windows.Forms.Button
	Public WithEvents CboOrganization As System.Windows.Forms.ComboBox
	Public WithEvents CboPersonType As System.Windows.Forms.ComboBox
	Public WithEvents TxtLast As System.Windows.Forms.TextBox
	Public WithEvents TxtFirst As System.Windows.Forms.TextBox
	Public WithEvents _LblOrganization_2 As System.Windows.Forms.Label
	Public WithEvents _LblOrganization_8 As System.Windows.Forms.Label
	Public WithEvents _LblOrganization_7 As System.Windows.Forms.Label
	Public WithEvents _LblOrganization_1 As System.Windows.Forms.Label
	Public WithEvents _LblOrganization_0 As System.Windows.Forms.Label
	Public WithEvents FraInformation As System.Windows.Forms.GroupBox
	Public WithEvents Label As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
	Public WithEvents LblOrganization As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FrmPerson))
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.ChkInactive = New System.Windows.Forms.CheckBox
        Me.CmdProperties = New System.Windows.Forms.Button
        Me.FraContactInfo = New System.Windows.Forms.GroupBox
        Me.CmdDelete = New System.Windows.Forms.Button
        Me.TxtBusyUntil = New System.Windows.Forms.TextBox
        Me.ChkBusy = New System.Windows.Forms.CheckBox
        Me.CmdOpen = New System.Windows.Forms.Button
        Me.CmdNew = New System.Windows.Forms.Button
        Me.LstViewPhone = New System.Windows.Forms.ListView
        Me.CmdOK = New System.Windows.Forms.Button
        Me.CmdCancel = New System.Windows.Forms.Button
        Me.FraInformation = New System.Windows.Forms.GroupBox
        Me.SSTab1 = New System.Windows.Forms.TabControl
        Me._SSTab1_TabPage0 = New System.Windows.Forms.TabPage
        Me.TxtTempExpires = New System.Windows.Forms.TextBox
        Me.TxtTempNotes = New System.Windows.Forms.TextBox
        Me.ChkTempNote = New System.Windows.Forms.CheckBox
        Me._SSTab1_TabPage1 = New System.Windows.Forms.TabPage
        Me._Label_0 = New System.Windows.Forms.Label
        Me.TxtNotes = New System.Windows.Forms.TextBox
        Me.TxtMI = New System.Windows.Forms.TextBox
        Me.CmdOrganizationDetail = New System.Windows.Forms.Button
        Me.CboOrganization = New System.Windows.Forms.ComboBox
        Me.CboPersonType = New System.Windows.Forms.ComboBox
        Me.TxtLast = New System.Windows.Forms.TextBox
        Me.TxtFirst = New System.Windows.Forms.TextBox
        Me._LblOrganization_2 = New System.Windows.Forms.Label
        Me._LblOrganization_8 = New System.Windows.Forms.Label
        Me._LblOrganization_7 = New System.Windows.Forms.Label
        Me._LblOrganization_1 = New System.Windows.Forms.Label
        Me._LblOrganization_0 = New System.Windows.Forms.Label
        Me.Label = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(Me.components)
        Me.LblOrganization = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(Me.components)
        Me.FraContactInfo.SuspendLayout()
        Me.FraInformation.SuspendLayout()
        Me.SSTab1.SuspendLayout()
        Me._SSTab1_TabPage0.SuspendLayout()
        Me._SSTab1_TabPage1.SuspendLayout()
        CType(Me.Label, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.LblOrganization, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'ChkInactive
        '
        Me.ChkInactive.BackColor = System.Drawing.SystemColors.Control
        Me.ChkInactive.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkInactive.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkInactive.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkInactive.Location = New System.Drawing.Point(696, 54)
        Me.ChkInactive.Name = "ChkInactive"
        Me.ChkInactive.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkInactive.Size = New System.Drawing.Size(77, 19)
        Me.ChkInactive.TabIndex = 20
        Me.ChkInactive.Text = "Inactive"
        Me.ChkInactive.UseVisualStyleBackColor = False
        '
        'CmdProperties
        '
        Me.CmdProperties.BackColor = System.Drawing.SystemColors.Control
        Me.CmdProperties.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdProperties.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdProperties.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdProperties.Location = New System.Drawing.Point(694, 116)
        Me.CmdProperties.Name = "CmdProperties"
        Me.CmdProperties.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdProperties.Size = New System.Drawing.Size(80, 21)
        Me.CmdProperties.TabIndex = 21
        Me.CmdProperties.Text = "&Properties..."
        Me.CmdProperties.UseVisualStyleBackColor = False
        '
        'FraContactInfo
        '
        Me.FraContactInfo.BackColor = System.Drawing.SystemColors.Control
        Me.FraContactInfo.Controls.Add(Me.CmdDelete)
        Me.FraContactInfo.Controls.Add(Me.TxtBusyUntil)
        Me.FraContactInfo.Controls.Add(Me.ChkBusy)
        Me.FraContactInfo.Controls.Add(Me.CmdOpen)
        Me.FraContactInfo.Controls.Add(Me.CmdNew)
        Me.FraContactInfo.Controls.Add(Me.LstViewPhone)
        Me.FraContactInfo.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FraContactInfo.ForeColor = System.Drawing.SystemColors.ControlText
        Me.FraContactInfo.Location = New System.Drawing.Point(348, 4)
        Me.FraContactInfo.Name = "FraContactInfo"
        Me.FraContactInfo.Padding = New System.Windows.Forms.Padding(0)
        Me.FraContactInfo.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.FraContactInfo.Size = New System.Drawing.Size(341, 255)
        Me.FraContactInfo.TabIndex = 18
        Me.FraContactInfo.TabStop = False
        Me.FraContactInfo.Text = "Contact Numbers"
        '
        'CmdDelete
        '
        Me.CmdDelete.BackColor = System.Drawing.SystemColors.Control
        Me.CmdDelete.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdDelete.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdDelete.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdDelete.Location = New System.Drawing.Point(16, 227)
        Me.CmdDelete.Name = "CmdDelete"
        Me.CmdDelete.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdDelete.Size = New System.Drawing.Size(80, 21)
        Me.CmdDelete.TabIndex = 5
        Me.CmdDelete.Text = "&Delete"
        Me.CmdDelete.UseVisualStyleBackColor = False
        '
        'TxtBusyUntil
        '
        Me.TxtBusyUntil.AcceptsReturn = True
        Me.TxtBusyUntil.BackColor = System.Drawing.SystemColors.Window
        Me.TxtBusyUntil.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtBusyUntil.Enabled = False
        Me.TxtBusyUntil.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtBusyUntil.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtBusyUntil.Location = New System.Drawing.Point(240, 26)
        Me.TxtBusyUntil.MaxLength = 0
        Me.TxtBusyUntil.Name = "TxtBusyUntil"
        Me.TxtBusyUntil.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtBusyUntil.Size = New System.Drawing.Size(91, 20)
        Me.TxtBusyUntil.TabIndex = 3
        '
        'ChkBusy
        '
        Me.ChkBusy.BackColor = System.Drawing.SystemColors.Control
        Me.ChkBusy.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkBusy.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkBusy.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkBusy.Location = New System.Drawing.Point(240, 9)
        Me.ChkBusy.Name = "ChkBusy"
        Me.ChkBusy.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkBusy.Size = New System.Drawing.Size(89, 18)
        Me.ChkBusy.TabIndex = 0
        Me.ChkBusy.Text = "Is Busy Until"
        Me.ChkBusy.UseVisualStyleBackColor = False
        '
        'CmdOpen
        '
        Me.CmdOpen.BackColor = System.Drawing.SystemColors.Control
        Me.CmdOpen.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdOpen.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdOpen.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdOpen.Location = New System.Drawing.Point(18, 26)
        Me.CmdOpen.Name = "CmdOpen"
        Me.CmdOpen.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdOpen.Size = New System.Drawing.Size(80, 21)
        Me.CmdOpen.TabIndex = 1
        Me.CmdOpen.Text = "O&pen..."
        Me.CmdOpen.UseVisualStyleBackColor = False
        '
        'CmdNew
        '
        Me.CmdNew.BackColor = System.Drawing.SystemColors.Control
        Me.CmdNew.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdNew.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdNew.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdNew.Location = New System.Drawing.Point(102, 26)
        Me.CmdNew.Name = "CmdNew"
        Me.CmdNew.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdNew.Size = New System.Drawing.Size(80, 21)
        Me.CmdNew.TabIndex = 2
        Me.CmdNew.Text = "&New"
        Me.CmdNew.UseVisualStyleBackColor = False
        '
        'LstViewPhone
        '
        Me.LstViewPhone.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewPhone.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.LstViewPhone.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewPhone.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewPhone.FullRowSelect = True
        Me.LstViewPhone.HideSelection = False
        Me.LstViewPhone.LabelWrap = False
        Me.LstViewPhone.Location = New System.Drawing.Point(18, 52)
        Me.LstViewPhone.Name = "LstViewPhone"
        Me.LstViewPhone.Size = New System.Drawing.Size(313, 171)
        Me.LstViewPhone.TabIndex = 4
        Me.LstViewPhone.UseCompatibleStateImageBehavior = False
        Me.LstViewPhone.View = System.Windows.Forms.View.Details
        '
        'CmdOK
        '
        Me.CmdOK.BackColor = System.Drawing.SystemColors.Control
        Me.CmdOK.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdOK.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdOK.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdOK.Location = New System.Drawing.Point(694, 10)
        Me.CmdOK.Name = "CmdOK"
        Me.CmdOK.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdOK.Size = New System.Drawing.Size(80, 21)
        Me.CmdOK.TabIndex = 19
        Me.CmdOK.Text = "&Save"
        Me.CmdOK.UseVisualStyleBackColor = False
        '
        'CmdCancel
        '
        Me.CmdCancel.BackColor = System.Drawing.SystemColors.Control
        Me.CmdCancel.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdCancel.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdCancel.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdCancel.Location = New System.Drawing.Point(694, 238)
        Me.CmdCancel.Name = "CmdCancel"
        Me.CmdCancel.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdCancel.Size = New System.Drawing.Size(80, 21)
        Me.CmdCancel.TabIndex = 22
        Me.CmdCancel.Text = "C&ancel"
        Me.CmdCancel.UseVisualStyleBackColor = False
        '
        'FraInformation
        '
        Me.FraInformation.BackColor = System.Drawing.SystemColors.Control
        Me.FraInformation.Controls.Add(Me.SSTab1)
        Me.FraInformation.Controls.Add(Me.TxtMI)
        Me.FraInformation.Controls.Add(Me.CmdOrganizationDetail)
        Me.FraInformation.Controls.Add(Me.CboOrganization)
        Me.FraInformation.Controls.Add(Me.CboPersonType)
        Me.FraInformation.Controls.Add(Me.TxtLast)
        Me.FraInformation.Controls.Add(Me.TxtFirst)
        Me.FraInformation.Controls.Add(Me._LblOrganization_2)
        Me.FraInformation.Controls.Add(Me._LblOrganization_8)
        Me.FraInformation.Controls.Add(Me._LblOrganization_7)
        Me.FraInformation.Controls.Add(Me._LblOrganization_1)
        Me.FraInformation.Controls.Add(Me._LblOrganization_0)
        Me.FraInformation.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FraInformation.ForeColor = System.Drawing.SystemColors.ControlText
        Me.FraInformation.Location = New System.Drawing.Point(4, 4)
        Me.FraInformation.Name = "FraInformation"
        Me.FraInformation.Padding = New System.Windows.Forms.Padding(0)
        Me.FraInformation.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.FraInformation.Size = New System.Drawing.Size(341, 255)
        Me.FraInformation.TabIndex = 13
        Me.FraInformation.TabStop = False
        Me.FraInformation.Text = "Information"
        '
        'SSTab1
        '
        Me.SSTab1.Alignment = System.Windows.Forms.TabAlignment.Left
        Me.SSTab1.Controls.Add(Me._SSTab1_TabPage0)
        Me.SSTab1.Controls.Add(Me._SSTab1_TabPage1)
        Me.SSTab1.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.SSTab1.ItemSize = New System.Drawing.Size(42, 18)
        Me.SSTab1.Location = New System.Drawing.Point(59, 120)
        Me.SSTab1.Multiline = True
        Me.SSTab1.Name = "SSTab1"
        Me.SSTab1.SelectedIndex = 0
        Me.SSTab1.Size = New System.Drawing.Size(279, 132)
        Me.SSTab1.TabIndex = 21
        Me.SSTab1.TabStop = False
        '
        '_SSTab1_TabPage0
        '
        Me._SSTab1_TabPage0.Controls.Add(Me.TxtTempExpires)
        Me._SSTab1_TabPage0.Controls.Add(Me.TxtTempNotes)
        Me._SSTab1_TabPage0.Controls.Add(Me.ChkTempNote)
        Me._SSTab1_TabPage0.Location = New System.Drawing.Point(22, 4)
        Me._SSTab1_TabPage0.Name = "_SSTab1_TabPage0"
        Me._SSTab1_TabPage0.Size = New System.Drawing.Size(253, 124)
        Me._SSTab1_TabPage0.TabIndex = 0
        Me._SSTab1_TabPage0.Text = "Temporary"
        '
        'TxtTempExpires
        '
        Me.TxtTempExpires.AcceptsReturn = True
        Me.TxtTempExpires.BackColor = System.Drawing.SystemColors.Window
        Me.TxtTempExpires.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtTempExpires.Enabled = False
        Me.TxtTempExpires.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtTempExpires.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtTempExpires.Location = New System.Drawing.Point(153, 1)
        Me.TxtTempExpires.MaxLength = 0
        Me.TxtTempExpires.Name = "TxtTempExpires"
        Me.TxtTempExpires.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtTempExpires.Size = New System.Drawing.Size(91, 20)
        Me.TxtTempExpires.TabIndex = 1
        '
        'TxtTempNotes
        '
        Me.TxtTempNotes.AcceptsReturn = True
        Me.TxtTempNotes.BackColor = System.Drawing.SystemColors.Window
        Me.TxtTempNotes.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtTempNotes.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtTempNotes.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtTempNotes.Location = New System.Drawing.Point(4, 22)
        Me.TxtTempNotes.MaxLength = 255
        Me.TxtTempNotes.Multiline = True
        Me.TxtTempNotes.Name = "TxtTempNotes"
        Me.TxtTempNotes.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtTempNotes.Size = New System.Drawing.Size(247, 99)
        Me.TxtTempNotes.TabIndex = 2
        '
        'ChkTempNote
        '
        Me.ChkTempNote.AutoSize = True
        Me.ChkTempNote.BackColor = System.Drawing.SystemColors.Control
        Me.ChkTempNote.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkTempNote.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkTempNote.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkTempNote.Location = New System.Drawing.Point(6, 2)
        Me.ChkTempNote.Name = "ChkTempNote"
        Me.ChkTempNote.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkTempNote.Size = New System.Drawing.Size(142, 18)
        Me.ChkTempNote.TabIndex = 0
        Me.ChkTempNote.Text = "Temporary Note Expires"
        Me.ChkTempNote.UseVisualStyleBackColor = False
        '
        '_SSTab1_TabPage1
        '
        Me._SSTab1_TabPage1.Controls.Add(Me._Label_0)
        Me._SSTab1_TabPage1.Controls.Add(Me.TxtNotes)
        Me._SSTab1_TabPage1.Location = New System.Drawing.Point(22, 4)
        Me._SSTab1_TabPage1.Name = "_SSTab1_TabPage1"
        Me._SSTab1_TabPage1.Size = New System.Drawing.Size(253, 124)
        Me._SSTab1_TabPage1.TabIndex = 1
        Me._SSTab1_TabPage1.Text = "Notes"
        '
        '_Label_0
        '
        Me._Label_0.BackColor = System.Drawing.SystemColors.Control
        Me._Label_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_0, CType(0, Short))
        Me._Label_0.Location = New System.Drawing.Point(6, 6)
        Me._Label_0.Name = "_Label_0"
        Me._Label_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_0.Size = New System.Drawing.Size(121, 15)
        Me._Label_0.TabIndex = 25
        Me._Label_0.Text = "Permanent Notes"
        '
        'TxtNotes
        '
        Me.TxtNotes.AcceptsReturn = True
        Me.TxtNotes.BackColor = System.Drawing.SystemColors.Window
        Me.TxtNotes.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtNotes.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtNotes.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtNotes.Location = New System.Drawing.Point(4, 24)
        Me.TxtNotes.MaxLength = 255
        Me.TxtNotes.Multiline = True
        Me.TxtNotes.Name = "TxtNotes"
        Me.TxtNotes.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtNotes.Size = New System.Drawing.Size(247, 99)
        Me.TxtNotes.TabIndex = 24
        '
        'TxtMI
        '
        Me.TxtMI.AcceptsReturn = True
        Me.TxtMI.BackColor = System.Drawing.SystemColors.Window
        Me.TxtMI.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtMI.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtMI.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtMI.Location = New System.Drawing.Point(230, 25)
        Me.TxtMI.MaxLength = 1
        Me.TxtMI.Name = "TxtMI"
        Me.TxtMI.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtMI.Size = New System.Drawing.Size(20, 20)
        Me.TxtMI.TabIndex = 1
        '
        'CmdOrganizationDetail
        '
        Me.CmdOrganizationDetail.BackColor = System.Drawing.SystemColors.Control
        Me.CmdOrganizationDetail.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdOrganizationDetail.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdOrganizationDetail.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdOrganizationDetail.Location = New System.Drawing.Point(315, 96)
        Me.CmdOrganizationDetail.Name = "CmdOrganizationDetail"
        Me.CmdOrganizationDetail.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdOrganizationDetail.Size = New System.Drawing.Size(17, 21)
        Me.CmdOrganizationDetail.TabIndex = 5
        Me.CmdOrganizationDetail.Text = "..."
        Me.CmdOrganizationDetail.UseVisualStyleBackColor = False
        '
        'CboOrganization
        '
        Me.CboOrganization.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboOrganization.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboOrganization.BackColor = System.Drawing.SystemColors.Window
        Me.CboOrganization.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboOrganization.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboOrganization.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboOrganization.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboOrganization.Location = New System.Drawing.Point(85, 96)
        Me.CboOrganization.Name = "CboOrganization"
        Me.CboOrganization.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboOrganization.Size = New System.Drawing.Size(226, 22)
        Me.CboOrganization.Sorted = True
        Me.CboOrganization.TabIndex = 4
        '
        'CboPersonType
        '
        Me.CboPersonType.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboPersonType.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboPersonType.BackColor = System.Drawing.SystemColors.Window
        Me.CboPersonType.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboPersonType.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboPersonType.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboPersonType.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboPersonType.Location = New System.Drawing.Point(85, 72)
        Me.CboPersonType.Name = "CboPersonType"
        Me.CboPersonType.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboPersonType.Size = New System.Drawing.Size(166, 22)
        Me.CboPersonType.Sorted = True
        Me.CboPersonType.TabIndex = 3
        '
        'TxtLast
        '
        Me.TxtLast.AcceptsReturn = True
        Me.TxtLast.BackColor = System.Drawing.SystemColors.Window
        Me.TxtLast.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtLast.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtLast.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtLast.Location = New System.Drawing.Point(85, 48)
        Me.TxtLast.MaxLength = 0
        Me.TxtLast.Name = "TxtLast"
        Me.TxtLast.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtLast.Size = New System.Drawing.Size(165, 20)
        Me.TxtLast.TabIndex = 2
        '
        'TxtFirst
        '
        Me.TxtFirst.AcceptsReturn = True
        Me.TxtFirst.BackColor = System.Drawing.SystemColors.Window
        Me.TxtFirst.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtFirst.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtFirst.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtFirst.Location = New System.Drawing.Point(85, 25)
        Me.TxtFirst.MaxLength = 0
        Me.TxtFirst.Name = "TxtFirst"
        Me.TxtFirst.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtFirst.Size = New System.Drawing.Size(120, 20)
        Me.TxtFirst.TabIndex = 0
        '
        '_LblOrganization_2
        '
        Me._LblOrganization_2.AutoSize = True
        Me._LblOrganization_2.BackColor = System.Drawing.SystemColors.Control
        Me._LblOrganization_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblOrganization_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LblOrganization_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblOrganization.SetIndex(Me._LblOrganization_2, CType(2, Short))
        Me._LblOrganization_2.Location = New System.Drawing.Point(214, 28)
        Me._LblOrganization_2.Name = "_LblOrganization_2"
        Me._LblOrganization_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblOrganization_2.Size = New System.Drawing.Size(17, 14)
        Me._LblOrganization_2.TabIndex = 12
        Me._LblOrganization_2.Text = "MI"
        '
        '_LblOrganization_8
        '
        Me._LblOrganization_8.AutoSize = True
        Me._LblOrganization_8.BackColor = System.Drawing.SystemColors.Control
        Me._LblOrganization_8.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblOrganization_8.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LblOrganization_8.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblOrganization.SetIndex(Me._LblOrganization_8, CType(8, Short))
        Me._LblOrganization_8.Location = New System.Drawing.Point(14, 100)
        Me._LblOrganization_8.Name = "_LblOrganization_8"
        Me._LblOrganization_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblOrganization_8.Size = New System.Drawing.Size(68, 14)
        Me._LblOrganization_8.TabIndex = 17
        Me._LblOrganization_8.Text = "Organization"
        '
        '_LblOrganization_7
        '
        Me._LblOrganization_7.AutoSize = True
        Me._LblOrganization_7.BackColor = System.Drawing.SystemColors.Control
        Me._LblOrganization_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblOrganization_7.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LblOrganization_7.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblOrganization.SetIndex(Me._LblOrganization_7, CType(7, Short))
        Me._LblOrganization_7.Location = New System.Drawing.Point(54, 76)
        Me._LblOrganization_7.Name = "_LblOrganization_7"
        Me._LblOrganization_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblOrganization_7.Size = New System.Drawing.Size(28, 14)
        Me._LblOrganization_7.TabIndex = 16
        Me._LblOrganization_7.Text = "Role"
        '
        '_LblOrganization_1
        '
        Me._LblOrganization_1.AutoSize = True
        Me._LblOrganization_1.BackColor = System.Drawing.SystemColors.Control
        Me._LblOrganization_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblOrganization_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LblOrganization_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblOrganization.SetIndex(Me._LblOrganization_1, CType(1, Short))
        Me._LblOrganization_1.Location = New System.Drawing.Point(54, 51)
        Me._LblOrganization_1.Name = "_LblOrganization_1"
        Me._LblOrganization_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblOrganization_1.Size = New System.Drawing.Size(28, 14)
        Me._LblOrganization_1.TabIndex = 15
        Me._LblOrganization_1.Text = "Last"
        '
        '_LblOrganization_0
        '
        Me._LblOrganization_0.AutoSize = True
        Me._LblOrganization_0.BackColor = System.Drawing.SystemColors.Control
        Me._LblOrganization_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblOrganization_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LblOrganization_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblOrganization.SetIndex(Me._LblOrganization_0, CType(0, Short))
        Me._LblOrganization_0.Location = New System.Drawing.Point(54, 28)
        Me._LblOrganization_0.Name = "_LblOrganization_0"
        Me._LblOrganization_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblOrganization_0.Size = New System.Drawing.Size(28, 14)
        Me._LblOrganization_0.TabIndex = 14
        Me._LblOrganization_0.Text = "First"
        '
        'FrmPerson
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 14.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.ClientSize = New System.Drawing.Size(779, 264)
        Me.Controls.Add(Me.ChkInactive)
        Me.Controls.Add(Me.CmdProperties)
        Me.Controls.Add(Me.FraContactInfo)
        Me.Controls.Add(Me.CmdOK)
        Me.Controls.Add(Me.CmdCancel)
        Me.Controls.Add(Me.FraInformation)
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Location = New System.Drawing.Point(41, 244)
        Me.MaximizeBox = False
        Me.Name = "FrmPerson"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Person"
        Me.FraContactInfo.ResumeLayout(False)
        Me.FraContactInfo.PerformLayout()
        Me.FraInformation.ResumeLayout(False)
        Me.FraInformation.PerformLayout()
        Me.SSTab1.ResumeLayout(False)
        Me._SSTab1_TabPage0.ResumeLayout(False)
        Me._SSTab1_TabPage0.PerformLayout()
        Me._SSTab1_TabPage1.ResumeLayout(False)
        Me._SSTab1_TabPage1.PerformLayout()
        CType(Me.Label, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.LblOrganization, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)

    End Sub
#End Region 
End Class