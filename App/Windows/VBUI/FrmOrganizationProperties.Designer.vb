<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmOrganizationProperties
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
	Public WithEvents CmdOK As System.Windows.Forms.Button
	Public WithEvents CmdCancel As System.Windows.Forms.Button
	Public WithEvents ChkLeaseOrganization As System.Windows.Forms.CheckBox
	Public WithEvents TxtPhone As System.Windows.Forms.TextBox
	Public WithEvents ChkTriageLO As System.Windows.Forms.CheckBox
	Public WithEvents ChkFamilyServicesLO As System.Windows.Forms.CheckBox
	Public WithEvents Label1 As System.Windows.Forms.Label
	Public WithEvents Frame1 As System.Windows.Forms.GroupBox
	Public WithEvents ChkConfCall As System.Windows.Forms.CheckBox
	Public WithEvents _Frame_2 As System.Windows.Forms.GroupBox
	Public WithEvents TxtConsentInterval As System.Windows.Forms.TextBox
	Public WithEvents TxtPageInterval As System.Windows.Forms.TextBox
	Public WithEvents _Label_6 As System.Windows.Forms.Label
	Public WithEvents _Label_5 As System.Windows.Forms.Label
	Public WithEvents _Label_4 As System.Windows.Forms.Label
	Public WithEvents _Label_2 As System.Windows.Forms.Label
	Public WithEvents _Frame_0 As System.Windows.Forms.GroupBox
	Public WithEvents ChkNoMedRecord As System.Windows.Forms.CheckBox
	Public WithEvents ChkNoPatientName As System.Windows.Forms.CheckBox
	Public WithEvents _Frame_1 As System.Windows.Forms.GroupBox
	Public WithEvents _TabProperty_TabPage0 As System.Windows.Forms.TabPage
	Public WithEvents _OptTo_1 As System.Windows.Forms.RadioButton
	Public WithEvents _OptTo_0 As System.Windows.Forms.RadioButton
	Public WithEvents CmdListReferrals As System.Windows.Forms.Button
	Public WithEvents CmdTo As System.Windows.Forms.Button
	Public WithEvents CmdFrom As System.Windows.Forms.Button
	Public WithEvents TxtFrom As System.Windows.Forms.TextBox
	Public WithEvents TxtTo As System.Windows.Forms.TextBox
	Public WithEvents CmdReassign As System.Windows.Forms.Button
	Public WithEvents LstViewPhone As System.Windows.Forms.ListView
	Public WithEvents _Label_1 As System.Windows.Forms.Label
	Public WithEvents _TabProperty_TabPage1 As System.Windows.Forms.TabPage
	Public WithEvents lstFaxNumbers As System.Windows.Forms.ListBox
	Public WithEvents cmdAdd As System.Windows.Forms.Button
	Public WithEvents cmdEdit As System.Windows.Forms.Button
	Public WithEvents cmdDelete As System.Windows.Forms.Button
	Public WithEvents _TabProperty_TabPage2 As System.Windows.Forms.TabPage
	Public WithEvents TabProperty As System.Windows.Forms.TabControl
	Public WithEvents Frame As Microsoft.VisualBasic.Compatibility.VB6.GroupBoxArray
	Public WithEvents Label As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
	Public WithEvents OptTo As Microsoft.VisualBasic.Compatibility.VB6.RadioButtonArray
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FrmOrganizationProperties))
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.CmdOK = New System.Windows.Forms.Button
        Me.CmdCancel = New System.Windows.Forms.Button
        Me.TabProperty = New System.Windows.Forms.TabControl
        Me._TabProperty_TabPage0 = New System.Windows.Forms.TabPage
        Me.Frame1 = New System.Windows.Forms.GroupBox
        Me.ChkLeaseOrganization = New System.Windows.Forms.CheckBox
        Me.TxtPhone = New System.Windows.Forms.TextBox
        Me.ChkTriageLO = New System.Windows.Forms.CheckBox
        Me.ChkFamilyServicesLO = New System.Windows.Forms.CheckBox
        Me.Label1 = New System.Windows.Forms.Label
        Me._Frame_2 = New System.Windows.Forms.GroupBox
        Me.ChkConfCall = New System.Windows.Forms.CheckBox
        Me._Frame_0 = New System.Windows.Forms.GroupBox
        Me.TxtConsentInterval = New System.Windows.Forms.TextBox
        Me.TxtPageInterval = New System.Windows.Forms.TextBox
        Me._Label_6 = New System.Windows.Forms.Label
        Me._Label_5 = New System.Windows.Forms.Label
        Me._Label_4 = New System.Windows.Forms.Label
        Me._Label_2 = New System.Windows.Forms.Label
        Me._Frame_1 = New System.Windows.Forms.GroupBox
        Me.ChkNoMedRecord = New System.Windows.Forms.CheckBox
        Me.ChkNoPatientName = New System.Windows.Forms.CheckBox
        Me._TabProperty_TabPage1 = New System.Windows.Forms.TabPage
        Me._OptTo_1 = New System.Windows.Forms.RadioButton
        Me._OptTo_0 = New System.Windows.Forms.RadioButton
        Me.CmdListReferrals = New System.Windows.Forms.Button
        Me.CmdTo = New System.Windows.Forms.Button
        Me.CmdFrom = New System.Windows.Forms.Button
        Me.TxtFrom = New System.Windows.Forms.TextBox
        Me.TxtTo = New System.Windows.Forms.TextBox
        Me.CmdReassign = New System.Windows.Forms.Button
        Me.LstViewPhone = New System.Windows.Forms.ListView
        Me._Label_1 = New System.Windows.Forms.Label
        Me._TabProperty_TabPage2 = New System.Windows.Forms.TabPage
        Me.lstFaxNumbers = New System.Windows.Forms.ListBox
        Me.cmdAdd = New System.Windows.Forms.Button
        Me.cmdEdit = New System.Windows.Forms.Button
        Me.cmdDelete = New System.Windows.Forms.Button
        Me.Frame = New Microsoft.VisualBasic.Compatibility.VB6.GroupBoxArray(Me.components)
        Me.Label = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(Me.components)
        Me.OptTo = New Microsoft.VisualBasic.Compatibility.VB6.RadioButtonArray(Me.components)
        Me.TabProperty.SuspendLayout()
        Me._TabProperty_TabPage0.SuspendLayout()
        Me.Frame1.SuspendLayout()
        Me._Frame_2.SuspendLayout()
        Me._Frame_0.SuspendLayout()
        Me._Frame_1.SuspendLayout()
        Me._TabProperty_TabPage1.SuspendLayout()
        Me._TabProperty_TabPage2.SuspendLayout()
        CType(Me.Frame, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.Label, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.OptTo, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'CmdOK
        '
        Me.CmdOK.BackColor = System.Drawing.SystemColors.Control
        Me.CmdOK.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdOK.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdOK.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdOK.Location = New System.Drawing.Point(336, 4)
        Me.CmdOK.Name = "CmdOK"
        Me.CmdOK.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdOK.Size = New System.Drawing.Size(76, 21)
        Me.CmdOK.TabIndex = 10
        Me.CmdOK.Text = "&Save"
        Me.CmdOK.UseVisualStyleBackColor = False
        '
        'CmdCancel
        '
        Me.CmdCancel.BackColor = System.Drawing.SystemColors.Control
        Me.CmdCancel.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdCancel.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdCancel.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdCancel.Location = New System.Drawing.Point(336, 270)
        Me.CmdCancel.Name = "CmdCancel"
        Me.CmdCancel.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdCancel.Size = New System.Drawing.Size(76, 21)
        Me.CmdCancel.TabIndex = 11
        Me.CmdCancel.Text = "&Cancel"
        Me.CmdCancel.UseVisualStyleBackColor = False
        '
        'TabProperty
        '
        Me.TabProperty.Controls.Add(Me._TabProperty_TabPage0)
        Me.TabProperty.Controls.Add(Me._TabProperty_TabPage1)
        Me.TabProperty.Controls.Add(Me._TabProperty_TabPage2)
        Me.TabProperty.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TabProperty.ItemSize = New System.Drawing.Size(42, 18)
        Me.TabProperty.Location = New System.Drawing.Point(8, 0)
        Me.TabProperty.Name = "TabProperty"
        Me.TabProperty.SelectedIndex = 2
        Me.TabProperty.Size = New System.Drawing.Size(311, 313)
        Me.TabProperty.TabIndex = 12
        '
        '_TabProperty_TabPage0
        '
        Me._TabProperty_TabPage0.Controls.Add(Me.Frame1)
        Me._TabProperty_TabPage0.Controls.Add(Me._Frame_2)
        Me._TabProperty_TabPage0.Controls.Add(Me._Frame_0)
        Me._TabProperty_TabPage0.Controls.Add(Me._Frame_1)
        Me._TabProperty_TabPage0.Location = New System.Drawing.Point(4, 22)
        Me._TabProperty_TabPage0.Name = "_TabProperty_TabPage0"
        Me._TabProperty_TabPage0.Size = New System.Drawing.Size(303, 287)
        Me._TabProperty_TabPage0.TabIndex = 0
        Me._TabProperty_TabPage0.Text = "Referral"
        '
        'Frame1
        '
        Me.Frame1.BackColor = System.Drawing.SystemColors.Control
        Me.Frame1.Controls.Add(Me.ChkLeaseOrganization)
        Me.Frame1.Controls.Add(Me.TxtPhone)
        Me.Frame1.Controls.Add(Me.ChkTriageLO)
        Me.Frame1.Controls.Add(Me.ChkFamilyServicesLO)
        Me.Frame1.Controls.Add(Me.Label1)
        Me.Frame1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Frame1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame1.Location = New System.Drawing.Point(8, 180)
        Me.Frame1.Name = "Frame1"
        Me.Frame1.Padding = New System.Windows.Forms.Padding(0)
        Me.Frame1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame1.Size = New System.Drawing.Size(273, 105)
        Me.Frame1.TabIndex = 29
        Me.Frame1.TabStop = False
        Me.Frame1.Text = "Lease Organizations"
        '
        'ChkLeaseOrganization
        '
        Me.ChkLeaseOrganization.BackColor = System.Drawing.SystemColors.Control
        Me.ChkLeaseOrganization.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkLeaseOrganization.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkLeaseOrganization.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkLeaseOrganization.Location = New System.Drawing.Point(8, 16)
        Me.ChkLeaseOrganization.Name = "ChkLeaseOrganization"
        Me.ChkLeaseOrganization.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkLeaseOrganization.Size = New System.Drawing.Size(245, 17)
        Me.ChkLeaseOrganization.TabIndex = 30
        Me.ChkLeaseOrganization.Text = "Lease Organization"
        Me.ChkLeaseOrganization.UseVisualStyleBackColor = False
        Me.ChkLeaseOrganization.Visible = False
        '
        'TxtPhone
        '
        Me.TxtPhone.AcceptsReturn = True
        Me.TxtPhone.BackColor = System.Drawing.SystemColors.Window
        Me.TxtPhone.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtPhone.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtPhone.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtPhone.Location = New System.Drawing.Point(8, 80)
        Me.TxtPhone.MaxLength = 0
        Me.TxtPhone.Name = "TxtPhone"
        Me.TxtPhone.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtPhone.Size = New System.Drawing.Size(89, 20)
        Me.TxtPhone.TabIndex = 33
        '
        'ChkTriageLO
        '
        Me.ChkTriageLO.BackColor = System.Drawing.SystemColors.Control
        Me.ChkTriageLO.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkTriageLO.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkTriageLO.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkTriageLO.Location = New System.Drawing.Point(24, 40)
        Me.ChkTriageLO.Name = "ChkTriageLO"
        Me.ChkTriageLO.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkTriageLO.Size = New System.Drawing.Size(105, 17)
        Me.ChkTriageLO.TabIndex = 31
        Me.ChkTriageLO.Text = "Triage LO"
        Me.ChkTriageLO.UseVisualStyleBackColor = False
        '
        'ChkFamilyServicesLO
        '
        Me.ChkFamilyServicesLO.BackColor = System.Drawing.SystemColors.Control
        Me.ChkFamilyServicesLO.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkFamilyServicesLO.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkFamilyServicesLO.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkFamilyServicesLO.Location = New System.Drawing.Point(24, 56)
        Me.ChkFamilyServicesLO.Name = "ChkFamilyServicesLO"
        Me.ChkFamilyServicesLO.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkFamilyServicesLO.Size = New System.Drawing.Size(137, 17)
        Me.ChkFamilyServicesLO.TabIndex = 32
        Me.ChkFamilyServicesLO.Text = "Family Services LO"
        Me.ChkFamilyServicesLO.UseVisualStyleBackColor = False
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.BackColor = System.Drawing.SystemColors.Control
        Me.Label1.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label1.Location = New System.Drawing.Point(104, 83)
        Me.Label1.Name = "Label1"
        Me.Label1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label1.Size = New System.Drawing.Size(60, 14)
        Me.Label1.TabIndex = 34
        Me.Label1.Text = "Call Back #"
        '
        '_Frame_2
        '
        Me._Frame_2.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_2.Controls.Add(Me.ChkConfCall)
        Me._Frame_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_2, CType(2, Short))
        Me._Frame_2.Location = New System.Drawing.Point(8, 140)
        Me._Frame_2.Name = "_Frame_2"
        Me._Frame_2.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_2.Size = New System.Drawing.Size(271, 35)
        Me._Frame_2.TabIndex = 23
        Me._Frame_2.TabStop = False
        Me._Frame_2.Text = "Miscellaneous"
        '
        'ChkConfCall
        '
        Me.ChkConfCall.BackColor = System.Drawing.SystemColors.Control
        Me.ChkConfCall.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkConfCall.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkConfCall.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkConfCall.Location = New System.Drawing.Point(8, 15)
        Me.ChkConfCall.Name = "ChkConfCall"
        Me.ChkConfCall.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkConfCall.Size = New System.Drawing.Size(245, 15)
        Me.ChkConfCall.TabIndex = 24
        Me.ChkConfCall.Text = "Conference Call Customer"
        Me.ChkConfCall.UseVisualStyleBackColor = False
        '
        '_Frame_0
        '
        Me._Frame_0.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_0.Controls.Add(Me.TxtConsentInterval)
        Me._Frame_0.Controls.Add(Me.TxtPageInterval)
        Me._Frame_0.Controls.Add(Me._Label_6)
        Me._Frame_0.Controls.Add(Me._Label_5)
        Me._Frame_0.Controls.Add(Me._Label_4)
        Me._Frame_0.Controls.Add(Me._Label_2)
        Me._Frame_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_0, CType(0, Short))
        Me._Frame_0.Location = New System.Drawing.Point(10, 84)
        Me._Frame_0.Name = "_Frame_0"
        Me._Frame_0.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_0.Size = New System.Drawing.Size(271, 53)
        Me._Frame_0.TabIndex = 14
        Me._Frame_0.TabStop = False
        Me._Frame_0.Text = "Response Intervals"
        '
        'TxtConsentInterval
        '
        Me.TxtConsentInterval.AcceptsReturn = True
        Me.TxtConsentInterval.BackColor = System.Drawing.SystemColors.Window
        Me.TxtConsentInterval.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtConsentInterval.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtConsentInterval.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtConsentInterval.Location = New System.Drawing.Point(182, 20)
        Me.TxtConsentInterval.MaxLength = 0
        Me.TxtConsentInterval.Name = "TxtConsentInterval"
        Me.TxtConsentInterval.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtConsentInterval.Size = New System.Drawing.Size(33, 20)
        Me.TxtConsentInterval.TabIndex = 20
        '
        'TxtPageInterval
        '
        Me.TxtPageInterval.AcceptsReturn = True
        Me.TxtPageInterval.BackColor = System.Drawing.SystemColors.Window
        Me.TxtPageInterval.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtPageInterval.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtPageInterval.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtPageInterval.Location = New System.Drawing.Point(40, 20)
        Me.TxtPageInterval.MaxLength = 0
        Me.TxtPageInterval.Name = "TxtPageInterval"
        Me.TxtPageInterval.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtPageInterval.Size = New System.Drawing.Size(33, 20)
        Me.TxtPageInterval.TabIndex = 2
        '
        '_Label_6
        '
        Me._Label_6.AutoSize = True
        Me._Label_6.BackColor = System.Drawing.SystemColors.Control
        Me._Label_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_6.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_6.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_6, CType(6, Short))
        Me._Label_6.Location = New System.Drawing.Point(138, 24)
        Me._Label_6.Name = "_Label_6"
        Me._Label_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_6.Size = New System.Drawing.Size(47, 14)
        Me._Label_6.TabIndex = 22
        Me._Label_6.Text = "Consent"
        '
        '_Label_5
        '
        Me._Label_5.AutoSize = True
        Me._Label_5.BackColor = System.Drawing.SystemColors.Control
        Me._Label_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_5.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_5.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_5, CType(5, Short))
        Me._Label_5.Location = New System.Drawing.Point(218, 24)
        Me._Label_5.Name = "_Label_5"
        Me._Label_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_5.Size = New System.Drawing.Size(44, 14)
        Me._Label_5.TabIndex = 21
        Me._Label_5.Text = "Minutes"
        '
        '_Label_4
        '
        Me._Label_4.AutoSize = True
        Me._Label_4.BackColor = System.Drawing.SystemColors.Control
        Me._Label_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_4.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_4.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_4, CType(4, Short))
        Me._Label_4.Location = New System.Drawing.Point(10, 24)
        Me._Label_4.Name = "_Label_4"
        Me._Label_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_4.Size = New System.Drawing.Size(31, 14)
        Me._Label_4.TabIndex = 19
        Me._Label_4.Text = "Page"
        '
        '_Label_2
        '
        Me._Label_2.AutoSize = True
        Me._Label_2.BackColor = System.Drawing.SystemColors.Control
        Me._Label_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_2, CType(2, Short))
        Me._Label_2.Location = New System.Drawing.Point(76, 24)
        Me._Label_2.Name = "_Label_2"
        Me._Label_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_2.Size = New System.Drawing.Size(44, 14)
        Me._Label_2.TabIndex = 15
        Me._Label_2.Text = "Minutes"
        '
        '_Frame_1
        '
        Me._Frame_1.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_1.Controls.Add(Me.ChkNoMedRecord)
        Me._Frame_1.Controls.Add(Me.ChkNoPatientName)
        Me._Frame_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_1, CType(1, Short))
        Me._Frame_1.Location = New System.Drawing.Point(10, 4)
        Me._Frame_1.Name = "_Frame_1"
        Me._Frame_1.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_1.Size = New System.Drawing.Size(271, 71)
        Me._Frame_1.TabIndex = 13
        Me._Frame_1.TabStop = False
        Me._Frame_1.Text = "Field Access"
        '
        'ChkNoMedRecord
        '
        Me.ChkNoMedRecord.BackColor = System.Drawing.SystemColors.Control
        Me.ChkNoMedRecord.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkNoMedRecord.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkNoMedRecord.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkNoMedRecord.Location = New System.Drawing.Point(10, 42)
        Me.ChkNoMedRecord.Name = "ChkNoMedRecord"
        Me.ChkNoMedRecord.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkNoMedRecord.Size = New System.Drawing.Size(157, 16)
        Me.ChkNoMedRecord.TabIndex = 1
        Me.ChkNoMedRecord.Text = "No Med. Rec. Number"
        Me.ChkNoMedRecord.UseVisualStyleBackColor = False
        '
        'ChkNoPatientName
        '
        Me.ChkNoPatientName.BackColor = System.Drawing.SystemColors.Control
        Me.ChkNoPatientName.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkNoPatientName.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkNoPatientName.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkNoPatientName.Location = New System.Drawing.Point(10, 22)
        Me.ChkNoPatientName.Name = "ChkNoPatientName"
        Me.ChkNoPatientName.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkNoPatientName.Size = New System.Drawing.Size(115, 16)
        Me.ChkNoPatientName.TabIndex = 0
        Me.ChkNoPatientName.Text = "No Patient Name"
        Me.ChkNoPatientName.UseVisualStyleBackColor = False
        '
        '_TabProperty_TabPage1
        '
        Me._TabProperty_TabPage1.Controls.Add(Me._OptTo_1)
        Me._TabProperty_TabPage1.Controls.Add(Me._OptTo_0)
        Me._TabProperty_TabPage1.Controls.Add(Me.CmdListReferrals)
        Me._TabProperty_TabPage1.Controls.Add(Me.CmdTo)
        Me._TabProperty_TabPage1.Controls.Add(Me.CmdFrom)
        Me._TabProperty_TabPage1.Controls.Add(Me.TxtFrom)
        Me._TabProperty_TabPage1.Controls.Add(Me.TxtTo)
        Me._TabProperty_TabPage1.Controls.Add(Me.CmdReassign)
        Me._TabProperty_TabPage1.Controls.Add(Me.LstViewPhone)
        Me._TabProperty_TabPage1.Controls.Add(Me._Label_1)
        Me._TabProperty_TabPage1.Location = New System.Drawing.Point(4, 22)
        Me._TabProperty_TabPage1.Name = "_TabProperty_TabPage1"
        Me._TabProperty_TabPage1.Size = New System.Drawing.Size(303, 287)
        Me._TabProperty_TabPage1.TabIndex = 1
        Me._TabProperty_TabPage1.Text = "Phone Numbers"
        '
        '_OptTo_1
        '
        Me._OptTo_1.BackColor = System.Drawing.SystemColors.Control
        Me._OptTo_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._OptTo_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._OptTo_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.OptTo.SetIndex(Me._OptTo_1, CType(1, Short))
        Me._OptTo_1.Location = New System.Drawing.Point(188, 210)
        Me._OptTo_1.Name = "_OptTo_1"
        Me._OptTo_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._OptTo_1.Size = New System.Drawing.Size(97, 16)
        Me._OptTo_1.TabIndex = 5
        Me._OptTo_1.TabStop = True
        Me._OptTo_1.Text = "To Another Org."
        Me._OptTo_1.UseVisualStyleBackColor = False
        '
        '_OptTo_0
        '
        Me._OptTo_0.BackColor = System.Drawing.SystemColors.Control
        Me._OptTo_0.Checked = True
        Me._OptTo_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._OptTo_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._OptTo_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.OptTo.SetIndex(Me._OptTo_0, CType(0, Short))
        Me._OptTo_0.Location = New System.Drawing.Point(72, 210)
        Me._OptTo_0.Name = "_OptTo_0"
        Me._OptTo_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._OptTo_0.Size = New System.Drawing.Size(115, 16)
        Me._OptTo_0.TabIndex = 4
        Me._OptTo_0.TabStop = True
        Me._OptTo_0.Text = "Within Current Org."
        Me._OptTo_0.UseVisualStyleBackColor = False
        '
        'CmdListReferrals
        '
        Me.CmdListReferrals.BackColor = System.Drawing.SystemColors.Control
        Me.CmdListReferrals.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdListReferrals.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdListReferrals.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdListReferrals.Location = New System.Drawing.Point(116, 159)
        Me.CmdListReferrals.Name = "CmdListReferrals"
        Me.CmdListReferrals.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdListReferrals.Size = New System.Drawing.Size(83, 21)
        Me.CmdListReferrals.TabIndex = 1
        Me.CmdListReferrals.Text = "List Referrals..."
        Me.CmdListReferrals.UseVisualStyleBackColor = False
        '
        'CmdTo
        '
        Me.CmdTo.BackColor = System.Drawing.SystemColors.Control
        Me.CmdTo.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdTo.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdTo.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdTo.Location = New System.Drawing.Point(10, 231)
        Me.CmdTo.Name = "CmdTo"
        Me.CmdTo.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdTo.Size = New System.Drawing.Size(59, 21)
        Me.CmdTo.TabIndex = 6
        Me.CmdTo.Text = "To"
        Me.CmdTo.UseVisualStyleBackColor = False
        '
        'CmdFrom
        '
        Me.CmdFrom.BackColor = System.Drawing.SystemColors.Control
        Me.CmdFrom.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdFrom.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdFrom.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdFrom.Location = New System.Drawing.Point(10, 183)
        Me.CmdFrom.Name = "CmdFrom"
        Me.CmdFrom.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdFrom.Size = New System.Drawing.Size(59, 21)
        Me.CmdFrom.TabIndex = 3
        Me.CmdFrom.TabStop = False
        Me.CmdFrom.Text = "From"
        Me.CmdFrom.UseVisualStyleBackColor = False
        '
        'TxtFrom
        '
        Me.TxtFrom.AcceptsReturn = True
        Me.TxtFrom.BackColor = System.Drawing.SystemColors.Window
        Me.TxtFrom.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtFrom.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtFrom.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtFrom.Location = New System.Drawing.Point(72, 183)
        Me.TxtFrom.MaxLength = 0
        Me.TxtFrom.Name = "TxtFrom"
        Me.TxtFrom.ReadOnly = True
        Me.TxtFrom.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtFrom.Size = New System.Drawing.Size(217, 20)
        Me.TxtFrom.TabIndex = 3
        Me.TxtFrom.TabStop = False
        '
        'TxtTo
        '
        Me.TxtTo.AcceptsReturn = True
        Me.TxtTo.BackColor = System.Drawing.SystemColors.Window
        Me.TxtTo.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtTo.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtTo.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtTo.Location = New System.Drawing.Point(72, 231)
        Me.TxtTo.MaxLength = 0
        Me.TxtTo.Name = "TxtTo"
        Me.TxtTo.ReadOnly = True
        Me.TxtTo.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtTo.Size = New System.Drawing.Size(217, 20)
        Me.TxtTo.TabIndex = 6
        Me.TxtTo.TabStop = False
        '
        'CmdReassign
        '
        Me.CmdReassign.BackColor = System.Drawing.SystemColors.Control
        Me.CmdReassign.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdReassign.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdReassign.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdReassign.Location = New System.Drawing.Point(206, 159)
        Me.CmdReassign.Name = "CmdReassign"
        Me.CmdReassign.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdReassign.Size = New System.Drawing.Size(83, 21)
        Me.CmdReassign.TabIndex = 2
        Me.CmdReassign.Text = "Reassign"
        Me.CmdReassign.UseVisualStyleBackColor = False
        '
        'LstViewPhone
        '
        Me.LstViewPhone.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewPhone.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.LstViewPhone.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewPhone.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewPhone.FullRowSelect = True
        Me.LstViewPhone.Location = New System.Drawing.Point(10, 21)
        Me.LstViewPhone.Name = "LstViewPhone"
        Me.LstViewPhone.Size = New System.Drawing.Size(279, 135)
        Me.LstViewPhone.TabIndex = 0
        Me.LstViewPhone.UseCompatibleStateImageBehavior = False
        Me.LstViewPhone.View = System.Windows.Forms.View.Details
        '
        '_Label_1
        '
        Me._Label_1.BackColor = System.Drawing.SystemColors.Control
        Me._Label_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_1, CType(1, Short))
        Me._Label_1.Location = New System.Drawing.Point(12, 211)
        Me._Label_1.Name = "_Label_1"
        Me._Label_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_1.Size = New System.Drawing.Size(91, 17)
        Me._Label_1.TabIndex = 18
        Me._Label_1.Text = "Reassign:"
        '
        '_TabProperty_TabPage2
        '
        Me._TabProperty_TabPage2.Controls.Add(Me.lstFaxNumbers)
        Me._TabProperty_TabPage2.Controls.Add(Me.cmdAdd)
        Me._TabProperty_TabPage2.Controls.Add(Me.cmdEdit)
        Me._TabProperty_TabPage2.Controls.Add(Me.cmdDelete)
        Me._TabProperty_TabPage2.Location = New System.Drawing.Point(4, 22)
        Me._TabProperty_TabPage2.Name = "_TabProperty_TabPage2"
        Me._TabProperty_TabPage2.Size = New System.Drawing.Size(303, 287)
        Me._TabProperty_TabPage2.TabIndex = 2
        Me._TabProperty_TabPage2.Text = "Fax Numbers"
        '
        'lstFaxNumbers
        '
        Me.lstFaxNumbers.BackColor = System.Drawing.SystemColors.Window
        Me.lstFaxNumbers.Cursor = System.Windows.Forms.Cursors.Default
        Me.lstFaxNumbers.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lstFaxNumbers.ForeColor = System.Drawing.SystemColors.WindowText
        Me.lstFaxNumbers.ItemHeight = 14
        Me.lstFaxNumbers.Location = New System.Drawing.Point(8, 24)
        Me.lstFaxNumbers.Name = "lstFaxNumbers"
        Me.lstFaxNumbers.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lstFaxNumbers.Size = New System.Drawing.Size(209, 242)
        Me.lstFaxNumbers.TabIndex = 25
        '
        'cmdAdd
        '
        Me.cmdAdd.BackColor = System.Drawing.SystemColors.Control
        Me.cmdAdd.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdAdd.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdAdd.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdAdd.Location = New System.Drawing.Point(224, 24)
        Me.cmdAdd.Name = "cmdAdd"
        Me.cmdAdd.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdAdd.Size = New System.Drawing.Size(73, 25)
        Me.cmdAdd.TabIndex = 26
        Me.cmdAdd.Text = "Add..."
        Me.cmdAdd.UseVisualStyleBackColor = False
        '
        'cmdEdit
        '
        Me.cmdEdit.BackColor = System.Drawing.SystemColors.Control
        Me.cmdEdit.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdEdit.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdEdit.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdEdit.Location = New System.Drawing.Point(224, 56)
        Me.cmdEdit.Name = "cmdEdit"
        Me.cmdEdit.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdEdit.Size = New System.Drawing.Size(73, 25)
        Me.cmdEdit.TabIndex = 27
        Me.cmdEdit.Text = "Edit..."
        Me.cmdEdit.UseVisualStyleBackColor = False
        '
        'cmdDelete
        '
        Me.cmdDelete.BackColor = System.Drawing.SystemColors.Control
        Me.cmdDelete.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdDelete.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdDelete.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdDelete.Location = New System.Drawing.Point(224, 88)
        Me.cmdDelete.Name = "cmdDelete"
        Me.cmdDelete.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdDelete.Size = New System.Drawing.Size(73, 25)
        Me.cmdDelete.TabIndex = 28
        Me.cmdDelete.Text = "Delete..."
        Me.cmdDelete.UseVisualStyleBackColor = False
        '
        'FrmOrganizationProperties
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 14.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.ClientSize = New System.Drawing.Size(419, 323)
        Me.Controls.Add(Me.CmdOK)
        Me.Controls.Add(Me.CmdCancel)
        Me.Controls.Add(Me.TabProperty)
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Location = New System.Drawing.Point(224, 115)
        Me.MaximizeBox = False
        Me.Name = "FrmOrganizationProperties"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.TabProperty.ResumeLayout(False)
        Me._TabProperty_TabPage0.ResumeLayout(False)
        Me.Frame1.ResumeLayout(False)
        Me.Frame1.PerformLayout()
        Me._Frame_2.ResumeLayout(False)
        Me._Frame_0.ResumeLayout(False)
        Me._Frame_0.PerformLayout()
        Me._Frame_1.ResumeLayout(False)
        Me._TabProperty_TabPage1.ResumeLayout(False)
        Me._TabProperty_TabPage1.PerformLayout()
        Me._TabProperty_TabPage2.ResumeLayout(False)
        CType(Me.Frame, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.Label, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.OptTo, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)

    End Sub
#End Region 
End Class