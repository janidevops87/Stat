<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmNDRICallSheet
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
	Public WithEvents CmdCancel As System.Windows.Forms.Button
	Public WithEvents CmdOK As System.Windows.Forms.Button
	Public WithEvents txtTOD As System.Windows.Forms.TextBox
	Public WithEvents txtCallTime As System.Windows.Forms.TextBox
	Public WithEvents cboRace As System.Windows.Forms.ComboBox
	Public WithEvents txtCoordName As System.Windows.Forms.TextBox
	Public WithEvents cboGender As System.Windows.Forms.ComboBox
	Public WithEvents txtOtherDiseases As System.Windows.Forms.TextBox
	Public WithEvents txtViralLoad As System.Windows.Forms.TextBox
	Public WithEvents txtCD4 As System.Windows.Forms.TextBox
	Public WithEvents txtDOD As System.Windows.Forms.TextBox
	Public WithEvents cboCOD_S As System.Windows.Forms.ComboBox
	Public WithEvents cboABO_Rh As System.Windows.Forms.ComboBox
	Public WithEvents cboAgeUnit As System.Windows.Forms.ComboBox
	Public WithEvents txtAge As System.Windows.Forms.TextBox
	Public WithEvents txtSource As System.Windows.Forms.TextBox
	Public WithEvents TxtSourcePhone As System.Windows.Forms.TextBox
	Public WithEvents TxtDonorNumber As System.Windows.Forms.TextBox
	Public WithEvents TxtCallDate As System.Windows.Forms.TextBox
	Public WithEvents LblCallTime As System.Windows.Forms.Label
	Public WithEvents _LblDOD_1 As System.Windows.Forms.Label
	Public WithEvents lblRace As System.Windows.Forms.Label
	Public WithEvents lblOtherKnownDiseases As System.Windows.Forms.Label
	Public WithEvents lblVL As System.Windows.Forms.Label
	Public WithEvents lblCD4 As System.Windows.Forms.Label
	Public WithEvents _LblDOD_0 As System.Windows.Forms.Label
	Public WithEvents lblCOD_S As System.Windows.Forms.Label
	Public WithEvents lblABO_Rh As System.Windows.Forms.Label
	Public WithEvents lblSex As System.Windows.Forms.Label
	Public WithEvents lblAge As System.Windows.Forms.Label
	Public WithEvents lblSource As System.Windows.Forms.Label
	Public WithEvents LblSourcePhone As System.Windows.Forms.Label
	Public WithEvents LblCoordName As System.Windows.Forms.Label
	Public WithEvents LblDonorNumber As System.Windows.Forms.Label
	Public WithEvents LblCallDate As System.Windows.Forms.Label
	Public WithEvents FraGeneral As System.Windows.Forms.GroupBox
	Public WithEvents _tabNDRI_TabPage0 As System.Windows.Forms.TabPage
	Public WithEvents txtMedHxOther As System.Windows.Forms.TextBox
	Public WithEvents cboSubstanceAbuse As System.Windows.Forms.ComboBox
	Public WithEvents cboRadiation As System.Windows.Forms.ComboBox
	Public WithEvents cboChemotherapy As System.Windows.Forms.ComboBox
	Public WithEvents cboSepsis As System.Windows.Forms.ComboBox
	Public WithEvents ctlNDRIMedications As ctlItemList
	Public WithEvents lblInfo As System.Windows.Forms.Label
	Public WithEvents lblMedHxOther As System.Windows.Forms.Label
	Public WithEvents lblSubstanceAbuse As System.Windows.Forms.Label
	Public WithEvents lblRadiation As System.Windows.Forms.Label
	Public WithEvents lblChemotherapy As System.Windows.Forms.Label
	Public WithEvents lblSepsis As System.Windows.Forms.Label
	Public WithEvents FraMedical As System.Windows.Forms.GroupBox
	Public WithEvents _tabNDRI_TabPage1 As System.Windows.Forms.TabPage
	Public WithEvents txtAdditionalComments As System.Windows.Forms.TextBox
	Public WithEvents cboFamilyKnowsStatus As System.Windows.Forms.ComboBox
	Public WithEvents cboFamilyAtHospital As System.Windows.Forms.ComboBox
	Public WithEvents txtFuneralHome As System.Windows.Forms.TextBox
	Public WithEvents txtAttendingPhone As System.Windows.Forms.TextBox
	Public WithEvents txtAttendingPhysician As System.Windows.Forms.TextBox
	Public WithEvents txtAttendingNurse As System.Windows.Forms.TextBox
	Public WithEvents txtAttendingHospital As System.Windows.Forms.TextBox
	Public WithEvents lblAdditionalComments As System.Windows.Forms.Label
	Public WithEvents lblFamilyKnowsStatus As System.Windows.Forms.Label
	Public WithEvents lblFamilyAtHospital As System.Windows.Forms.Label
	Public WithEvents lblFuneralHome As System.Windows.Forms.Label
	Public WithEvents lblAttendingPhysicianPhone As System.Windows.Forms.Label
	Public WithEvents lblAttendingPhysician As System.Windows.Forms.Label
	Public WithEvents lblAttendingNurse As System.Windows.Forms.Label
	Public WithEvents lblAttendingHospital As System.Windows.Forms.Label
	Public WithEvents FraOther As System.Windows.Forms.GroupBox
	Public WithEvents _tabNDRI_TabPage2 As System.Windows.Forms.TabPage
	Public WithEvents tabNDRI As System.Windows.Forms.TabControl
	Public WithEvents LblDOD As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
		Dim resources As System.Resources.ResourceManager = New System.Resources.ResourceManager(GetType(FrmNDRICallSheet))
		Me.components = New System.ComponentModel.Container()
		Me.ToolTip1 = New System.Windows.Forms.ToolTip(components)
		Me.CmdCancel = New System.Windows.Forms.Button
		Me.CmdOK = New System.Windows.Forms.Button
		Me.tabNDRI = New System.Windows.Forms.TabControl
		Me._tabNDRI_TabPage0 = New System.Windows.Forms.TabPage
		Me.FraGeneral = New System.Windows.Forms.GroupBox
		Me.txtTOD = New System.Windows.Forms.TextBox
		Me.txtCallTime = New System.Windows.Forms.TextBox
		Me.cboRace = New System.Windows.Forms.ComboBox
		Me.txtCoordName = New System.Windows.Forms.TextBox
		Me.cboGender = New System.Windows.Forms.ComboBox
		Me.txtOtherDiseases = New System.Windows.Forms.TextBox
		Me.txtViralLoad = New System.Windows.Forms.TextBox
		Me.txtCD4 = New System.Windows.Forms.TextBox
		Me.txtDOD = New System.Windows.Forms.TextBox
		Me.cboCOD_S = New System.Windows.Forms.ComboBox
		Me.cboABO_Rh = New System.Windows.Forms.ComboBox
		Me.cboAgeUnit = New System.Windows.Forms.ComboBox
		Me.txtAge = New System.Windows.Forms.TextBox
		Me.txtSource = New System.Windows.Forms.TextBox
		Me.TxtSourcePhone = New System.Windows.Forms.TextBox
		Me.TxtDonorNumber = New System.Windows.Forms.TextBox
		Me.TxtCallDate = New System.Windows.Forms.TextBox
		Me.LblCallTime = New System.Windows.Forms.Label
		Me._LblDOD_1 = New System.Windows.Forms.Label
		Me.lblRace = New System.Windows.Forms.Label
		Me.lblOtherKnownDiseases = New System.Windows.Forms.Label
		Me.lblVL = New System.Windows.Forms.Label
		Me.lblCD4 = New System.Windows.Forms.Label
		Me._LblDOD_0 = New System.Windows.Forms.Label
		Me.lblCOD_S = New System.Windows.Forms.Label
		Me.lblABO_Rh = New System.Windows.Forms.Label
		Me.lblSex = New System.Windows.Forms.Label
		Me.lblAge = New System.Windows.Forms.Label
		Me.lblSource = New System.Windows.Forms.Label
		Me.LblSourcePhone = New System.Windows.Forms.Label
		Me.LblCoordName = New System.Windows.Forms.Label
		Me.LblDonorNumber = New System.Windows.Forms.Label
		Me.LblCallDate = New System.Windows.Forms.Label
		Me._tabNDRI_TabPage1 = New System.Windows.Forms.TabPage
		Me.FraMedical = New System.Windows.Forms.GroupBox
		Me.txtMedHxOther = New System.Windows.Forms.TextBox
		Me.cboSubstanceAbuse = New System.Windows.Forms.ComboBox
		Me.cboRadiation = New System.Windows.Forms.ComboBox
		Me.cboChemotherapy = New System.Windows.Forms.ComboBox
		Me.cboSepsis = New System.Windows.Forms.ComboBox
		Me.ctlNDRIMedications = New ctlItemList
		Me.lblInfo = New System.Windows.Forms.Label
		Me.lblMedHxOther = New System.Windows.Forms.Label
		Me.lblSubstanceAbuse = New System.Windows.Forms.Label
		Me.lblRadiation = New System.Windows.Forms.Label
		Me.lblChemotherapy = New System.Windows.Forms.Label
		Me.lblSepsis = New System.Windows.Forms.Label
		Me._tabNDRI_TabPage2 = New System.Windows.Forms.TabPage
		Me.FraOther = New System.Windows.Forms.GroupBox
		Me.txtAdditionalComments = New System.Windows.Forms.TextBox
		Me.cboFamilyKnowsStatus = New System.Windows.Forms.ComboBox
		Me.cboFamilyAtHospital = New System.Windows.Forms.ComboBox
		Me.txtFuneralHome = New System.Windows.Forms.TextBox
		Me.txtAttendingPhone = New System.Windows.Forms.TextBox
		Me.txtAttendingPhysician = New System.Windows.Forms.TextBox
		Me.txtAttendingNurse = New System.Windows.Forms.TextBox
		Me.txtAttendingHospital = New System.Windows.Forms.TextBox
		Me.lblAdditionalComments = New System.Windows.Forms.Label
		Me.lblFamilyKnowsStatus = New System.Windows.Forms.Label
		Me.lblFamilyAtHospital = New System.Windows.Forms.Label
		Me.lblFuneralHome = New System.Windows.Forms.Label
		Me.lblAttendingPhysicianPhone = New System.Windows.Forms.Label
		Me.lblAttendingPhysician = New System.Windows.Forms.Label
		Me.lblAttendingNurse = New System.Windows.Forms.Label
		Me.lblAttendingHospital = New System.Windows.Forms.Label
		Me.LblDOD = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(components)
		Me.tabNDRI.SuspendLayout()
		Me._tabNDRI_TabPage0.SuspendLayout()
		Me.FraGeneral.SuspendLayout()
		Me._tabNDRI_TabPage1.SuspendLayout()
		Me.FraMedical.SuspendLayout()
		Me._tabNDRI_TabPage2.SuspendLayout()
		Me.FraOther.SuspendLayout()
		Me.SuspendLayout()
		Me.ToolTip1.Active = True
		CType(Me.LblDOD, System.ComponentModel.ISupportInitialize).BeginInit()
		Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
		Me.Text = "NDRI Call Sheet - "
		Me.ClientSize = New System.Drawing.Size(569, 475)
		Me.Location = New System.Drawing.Point(148, 214)
		Me.ControlBox = False
		Me.Icon = CType(resources.GetObject("FrmNDRICallSheet.Icon"), System.Drawing.Icon)
		Me.MaximizeBox = False
		Me.MinimizeBox = False
		Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent
		Me.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
		Me.BackColor = System.Drawing.SystemColors.Control
		Me.Enabled = True
		Me.KeyPreview = False
		Me.Cursor = System.Windows.Forms.Cursors.Default
		Me.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.ShowInTaskbar = True
		Me.HelpButton = False
		Me.WindowState = System.Windows.Forms.FormWindowState.Normal
		Me.Name = "FrmNDRICallSheet"
		Me.CmdCancel.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		Me.CmdCancel.Text = "&Cancel"
		Me.CmdCancel.Size = New System.Drawing.Size(80, 21)
		Me.CmdCancel.Location = New System.Drawing.Point(488, 448)
		Me.CmdCancel.TabIndex = 32
		Me.CmdCancel.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.CmdCancel.BackColor = System.Drawing.SystemColors.Control
		Me.CmdCancel.CausesValidation = True
		Me.CmdCancel.Enabled = True
		Me.CmdCancel.ForeColor = System.Drawing.SystemColors.ControlText
		Me.CmdCancel.Cursor = System.Windows.Forms.Cursors.Default
		Me.CmdCancel.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.CmdCancel.TabStop = True
		Me.CmdCancel.Name = "CmdCancel"
		Me.CmdOK.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		Me.CmdOK.Text = "&Save"
		Me.CmdOK.Size = New System.Drawing.Size(80, 21)
		Me.CmdOK.Location = New System.Drawing.Point(486, 4)
		Me.CmdOK.TabIndex = 31
		Me.CmdOK.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.CmdOK.BackColor = System.Drawing.SystemColors.Control
		Me.CmdOK.CausesValidation = True
		Me.CmdOK.Enabled = True
		Me.CmdOK.ForeColor = System.Drawing.SystemColors.ControlText
		Me.CmdOK.Cursor = System.Windows.Forms.Cursors.Default
		Me.CmdOK.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.CmdOK.TabStop = True
		Me.CmdOK.Name = "CmdOK"
		Me.tabNDRI.Size = New System.Drawing.Size(481, 473)
		Me.tabNDRI.Location = New System.Drawing.Point(0, 0)
		Me.tabNDRI.TabIndex = 33
		Me.tabNDRI.ItemSize = New System.Drawing.Size(42, 18)
		Me.tabNDRI.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.tabNDRI.Name = "tabNDRI"
		Me._tabNDRI_TabPage0.Text = "General"
		Me.FraGeneral.Size = New System.Drawing.Size(463, 385)
		Me.FraGeneral.Location = New System.Drawing.Point(8, 24)
		Me.FraGeneral.TabIndex = 34
		Me.FraGeneral.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.FraGeneral.BackColor = System.Drawing.SystemColors.Control
		Me.FraGeneral.Enabled = True
		Me.FraGeneral.ForeColor = System.Drawing.SystemColors.ControlText
		Me.FraGeneral.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.FraGeneral.Visible = True
		Me.FraGeneral.Padding = New System.Windows.Forms.Padding(0)
		Me.FraGeneral.Name = "FraGeneral"
		Me.txtTOD.AutoSize = False
		Me.txtTOD.Size = New System.Drawing.Size(57, 21)
		Me.txtTOD.Location = New System.Drawing.Point(174, 256)
		Me.txtTOD.Maxlength = 10
		Me.txtTOD.TabIndex = 13
		Me.ToolTip1.SetToolTip(Me.txtTOD, "Death Time")
		Me.txtTOD.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.txtTOD.AcceptsReturn = True
		Me.txtTOD.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me.txtTOD.BackColor = System.Drawing.SystemColors.Window
		Me.txtTOD.CausesValidation = True
		Me.txtTOD.Enabled = True
		Me.txtTOD.ForeColor = System.Drawing.SystemColors.WindowText
		Me.txtTOD.HideSelection = True
		Me.txtTOD.ReadOnly = False
		Me.txtTOD.Cursor = System.Windows.Forms.Cursors.IBeam
		Me.txtTOD.MultiLine = False
		Me.txtTOD.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.txtTOD.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me.txtTOD.TabStop = True
		Me.txtTOD.Visible = True
		Me.txtTOD.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.txtTOD.Name = "txtTOD"
		Me.txtCallTime.AutoSize = False
		Me.txtCallTime.Size = New System.Drawing.Size(57, 21)
		Me.txtCallTime.Location = New System.Drawing.Point(174, 16)
		Me.txtCallTime.TabIndex = 1
		Me.ToolTip1.SetToolTip(Me.txtCallTime, "Call Time")
		Me.txtCallTime.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.txtCallTime.AcceptsReturn = True
		Me.txtCallTime.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me.txtCallTime.BackColor = System.Drawing.SystemColors.Window
		Me.txtCallTime.CausesValidation = True
		Me.txtCallTime.Enabled = True
		Me.txtCallTime.ForeColor = System.Drawing.SystemColors.WindowText
		Me.txtCallTime.HideSelection = True
		Me.txtCallTime.ReadOnly = False
		Me.txtCallTime.Maxlength = 0
		Me.txtCallTime.Cursor = System.Windows.Forms.Cursors.IBeam
		Me.txtCallTime.MultiLine = False
		Me.txtCallTime.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.txtCallTime.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me.txtCallTime.TabStop = True
		Me.txtCallTime.Visible = True
		Me.txtCallTime.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.txtCallTime.Name = "txtCallTime"
        Me.cboRace.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.cboRace.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.cboRace.Size = New System.Drawing.Size(123, 21)
		Me.cboRace.Location = New System.Drawing.Point(80, 160)
		Me.cboRace.Items.AddRange(New Object(){"Days", "Months", "Years"})
		Me.cboRace.Sorted = True
		Me.cboRace.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
		Me.cboRace.TabIndex = 8
		Me.ToolTip1.SetToolTip(Me.cboRace, "Race")
		Me.cboRace.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.cboRace.BackColor = System.Drawing.SystemColors.Window
		Me.cboRace.CausesValidation = True
		Me.cboRace.Enabled = True
		Me.cboRace.ForeColor = System.Drawing.SystemColors.WindowText
		Me.cboRace.IntegralHeight = True
		Me.cboRace.Cursor = System.Windows.Forms.Cursors.Default
		Me.cboRace.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.cboRace.TabStop = True
		Me.cboRace.Visible = True
		Me.cboRace.Name = "cboRace"
		Me.txtCoordName.AutoSize = False
		Me.txtCoordName.Size = New System.Drawing.Size(323, 21)
		Me.txtCoordName.Location = New System.Drawing.Point(80, 62)
		Me.txtCoordName.Maxlength = 101
		Me.txtCoordName.TabIndex = 3
		Me.ToolTip1.SetToolTip(Me.txtCoordName, "Approacher")
		Me.txtCoordName.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.txtCoordName.AcceptsReturn = True
		Me.txtCoordName.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me.txtCoordName.BackColor = System.Drawing.SystemColors.Window
		Me.txtCoordName.CausesValidation = True
		Me.txtCoordName.Enabled = True
		Me.txtCoordName.ForeColor = System.Drawing.SystemColors.WindowText
		Me.txtCoordName.HideSelection = True
		Me.txtCoordName.ReadOnly = False
		Me.txtCoordName.Cursor = System.Windows.Forms.Cursors.IBeam
		Me.txtCoordName.MultiLine = False
		Me.txtCoordName.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.txtCoordName.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me.txtCoordName.TabStop = True
		Me.txtCoordName.Visible = True
		Me.txtCoordName.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.txtCoordName.Name = "txtCoordName"
        Me.cboGender.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.cboGender.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.cboGender.Size = New System.Drawing.Size(51, 21)
		Me.cboGender.Location = New System.Drawing.Point(80, 184)
		Me.cboGender.Items.AddRange(New Object(){"F", "M"})
		Me.cboGender.Sorted = True
		Me.cboGender.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
		Me.cboGender.TabIndex = 9
		Me.ToolTip1.SetToolTip(Me.cboGender, "Sex")
		Me.cboGender.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.cboGender.BackColor = System.Drawing.SystemColors.Window
		Me.cboGender.CausesValidation = True
		Me.cboGender.Enabled = True
		Me.cboGender.ForeColor = System.Drawing.SystemColors.WindowText
		Me.cboGender.IntegralHeight = True
		Me.cboGender.Cursor = System.Windows.Forms.Cursors.Default
		Me.cboGender.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.cboGender.TabStop = True
		Me.cboGender.Visible = True
		Me.cboGender.Name = "cboGender"
		Me.txtOtherDiseases.AutoSize = False
		Me.txtOtherDiseases.Size = New System.Drawing.Size(323, 45)
		Me.txtOtherDiseases.Location = New System.Drawing.Point(80, 328)
		Me.txtOtherDiseases.Maxlength = 1000
		Me.txtOtherDiseases.MultiLine = True
		Me.txtOtherDiseases.ScrollBars = System.Windows.Forms.ScrollBars.Vertical
		Me.txtOtherDiseases.TabIndex = 16
		Me.ToolTip1.SetToolTip(Me.txtOtherDiseases, "Other Diseases")
		Me.txtOtherDiseases.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.txtOtherDiseases.AcceptsReturn = True
		Me.txtOtherDiseases.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me.txtOtherDiseases.BackColor = System.Drawing.SystemColors.Window
		Me.txtOtherDiseases.CausesValidation = True
		Me.txtOtherDiseases.Enabled = True
		Me.txtOtherDiseases.ForeColor = System.Drawing.SystemColors.WindowText
		Me.txtOtherDiseases.HideSelection = True
		Me.txtOtherDiseases.ReadOnly = False
		Me.txtOtherDiseases.Cursor = System.Windows.Forms.Cursors.IBeam
		Me.txtOtherDiseases.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.txtOtherDiseases.TabStop = True
		Me.txtOtherDiseases.Visible = True
		Me.txtOtherDiseases.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.txtOtherDiseases.Name = "txtOtherDiseases"
		Me.txtViralLoad.AutoSize = False
		Me.txtViralLoad.Size = New System.Drawing.Size(323, 21)
		Me.txtViralLoad.Location = New System.Drawing.Point(80, 304)
		Me.txtViralLoad.Maxlength = 50
		Me.txtViralLoad.TabIndex = 15
		Me.ToolTip1.SetToolTip(Me.txtViralLoad, "Viral Load")
		Me.txtViralLoad.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.txtViralLoad.AcceptsReturn = True
		Me.txtViralLoad.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me.txtViralLoad.BackColor = System.Drawing.SystemColors.Window
		Me.txtViralLoad.CausesValidation = True
		Me.txtViralLoad.Enabled = True
		Me.txtViralLoad.ForeColor = System.Drawing.SystemColors.WindowText
		Me.txtViralLoad.HideSelection = True
		Me.txtViralLoad.ReadOnly = False
		Me.txtViralLoad.Cursor = System.Windows.Forms.Cursors.IBeam
		Me.txtViralLoad.MultiLine = False
		Me.txtViralLoad.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.txtViralLoad.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me.txtViralLoad.TabStop = True
		Me.txtViralLoad.Visible = True
		Me.txtViralLoad.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.txtViralLoad.Name = "txtViralLoad"
		Me.txtCD4.AutoSize = False
		Me.txtCD4.Size = New System.Drawing.Size(323, 21)
		Me.txtCD4.Location = New System.Drawing.Point(80, 280)
		Me.txtCD4.Maxlength = 50
		Me.txtCD4.TabIndex = 14
		Me.ToolTip1.SetToolTip(Me.txtCD4, "T-Cell Count")
		Me.txtCD4.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.txtCD4.AcceptsReturn = True
		Me.txtCD4.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me.txtCD4.BackColor = System.Drawing.SystemColors.Window
		Me.txtCD4.CausesValidation = True
		Me.txtCD4.Enabled = True
		Me.txtCD4.ForeColor = System.Drawing.SystemColors.WindowText
		Me.txtCD4.HideSelection = True
		Me.txtCD4.ReadOnly = False
		Me.txtCD4.Cursor = System.Windows.Forms.Cursors.IBeam
		Me.txtCD4.MultiLine = False
		Me.txtCD4.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.txtCD4.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me.txtCD4.TabStop = True
		Me.txtCD4.Visible = True
		Me.txtCD4.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.txtCD4.Name = "txtCD4"
		Me.txtDOD.AutoSize = False
		Me.txtDOD.Size = New System.Drawing.Size(57, 21)
		Me.txtDOD.Location = New System.Drawing.Point(80, 256)
		Me.txtDOD.Maxlength = 8
		Me.txtDOD.TabIndex = 12
		Me.ToolTip1.SetToolTip(Me.txtDOD, "Death Date")
		Me.txtDOD.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.txtDOD.AcceptsReturn = True
		Me.txtDOD.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me.txtDOD.BackColor = System.Drawing.SystemColors.Window
		Me.txtDOD.CausesValidation = True
		Me.txtDOD.Enabled = True
		Me.txtDOD.ForeColor = System.Drawing.SystemColors.WindowText
		Me.txtDOD.HideSelection = True
		Me.txtDOD.ReadOnly = False
		Me.txtDOD.Cursor = System.Windows.Forms.Cursors.IBeam
		Me.txtDOD.MultiLine = False
		Me.txtDOD.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.txtDOD.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me.txtDOD.TabStop = True
		Me.txtDOD.Visible = True
		Me.txtDOD.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.txtDOD.Name = "txtDOD"
        Me.cboCOD_S.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.cboCOD_S.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.cboCOD_S.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cboCOD_S.Size = New System.Drawing.Size(323, 21)
		Me.cboCOD_S.Location = New System.Drawing.Point(80, 232)
		Me.cboCOD_S.Sorted = True
		Me.cboCOD_S.TabIndex = 11
		Me.cboCOD_S.Text = "cboCOD_S"
		Me.ToolTip1.SetToolTip(Me.cboCOD_S, "Cause of Death")
		Me.cboCOD_S.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.cboCOD_S.BackColor = System.Drawing.SystemColors.Window
		Me.cboCOD_S.CausesValidation = True
		Me.cboCOD_S.Enabled = True
		Me.cboCOD_S.ForeColor = System.Drawing.SystemColors.WindowText
		Me.cboCOD_S.IntegralHeight = True
		Me.cboCOD_S.Cursor = System.Windows.Forms.Cursors.Default
		Me.cboCOD_S.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cboCOD_S.TabStop = True
		Me.cboCOD_S.Visible = True
		Me.cboCOD_S.Name = "cboCOD_S"
        Me.cboABO_Rh.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.cboABO_Rh.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.cboABO_Rh.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cboABO_Rh.Size = New System.Drawing.Size(75, 21)
		Me.cboABO_Rh.Location = New System.Drawing.Point(80, 208)
		Me.cboABO_Rh.Sorted = True
        Me.cboABO_Rh.TabIndex = 10
		Me.ToolTip1.SetToolTip(Me.cboABO_Rh, "Blood Type")
		Me.cboABO_Rh.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.cboABO_Rh.BackColor = System.Drawing.SystemColors.Window
		Me.cboABO_Rh.CausesValidation = True
		Me.cboABO_Rh.Enabled = True
		Me.cboABO_Rh.ForeColor = System.Drawing.SystemColors.WindowText
		Me.cboABO_Rh.IntegralHeight = True
		Me.cboABO_Rh.Cursor = System.Windows.Forms.Cursors.Default
		Me.cboABO_Rh.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.cboABO_Rh.TabStop = True
		Me.cboABO_Rh.Visible = True
		Me.cboABO_Rh.Name = "cboABO_Rh"
        Me.cboAgeUnit.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.cboAgeUnit.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.cboAgeUnit.Size = New System.Drawing.Size(77, 21)
		Me.cboAgeUnit.Location = New System.Drawing.Point(126, 134)
		Me.cboAgeUnit.Items.AddRange(New Object(){"Days", "Months", "Years"})
		Me.cboAgeUnit.Sorted = True
		Me.cboAgeUnit.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
		Me.cboAgeUnit.TabIndex = 7
		Me.ToolTip1.SetToolTip(Me.cboAgeUnit, "Age Unit")
		Me.cboAgeUnit.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.cboAgeUnit.BackColor = System.Drawing.SystemColors.Window
		Me.cboAgeUnit.CausesValidation = True
		Me.cboAgeUnit.Enabled = True
		Me.cboAgeUnit.ForeColor = System.Drawing.SystemColors.WindowText
		Me.cboAgeUnit.IntegralHeight = True
		Me.cboAgeUnit.Cursor = System.Windows.Forms.Cursors.Default
		Me.cboAgeUnit.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.cboAgeUnit.TabStop = True
		Me.cboAgeUnit.Visible = True
		Me.cboAgeUnit.Name = "cboAgeUnit"
		Me.txtAge.AutoSize = False
		Me.txtAge.Size = New System.Drawing.Size(43, 21)
		Me.txtAge.Location = New System.Drawing.Point(80, 134)
		Me.txtAge.Maxlength = 4
		Me.txtAge.TabIndex = 6
		Me.ToolTip1.SetToolTip(Me.txtAge, "Age")
		Me.txtAge.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.txtAge.AcceptsReturn = True
		Me.txtAge.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me.txtAge.BackColor = System.Drawing.SystemColors.Window
		Me.txtAge.CausesValidation = True
		Me.txtAge.Enabled = True
		Me.txtAge.ForeColor = System.Drawing.SystemColors.WindowText
		Me.txtAge.HideSelection = True
		Me.txtAge.ReadOnly = False
		Me.txtAge.Cursor = System.Windows.Forms.Cursors.IBeam
		Me.txtAge.MultiLine = False
		Me.txtAge.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.txtAge.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me.txtAge.TabStop = True
		Me.txtAge.Visible = True
		Me.txtAge.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.txtAge.Name = "txtAge"
		Me.txtSource.AutoSize = False
		Me.txtSource.Size = New System.Drawing.Size(323, 21)
		Me.txtSource.Location = New System.Drawing.Point(80, 86)
		Me.txtSource.Maxlength = 50
		Me.txtSource.TabIndex = 4
		Me.ToolTip1.SetToolTip(Me.txtSource, "OPO Name")
		Me.txtSource.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.txtSource.AcceptsReturn = True
		Me.txtSource.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me.txtSource.BackColor = System.Drawing.SystemColors.Window
		Me.txtSource.CausesValidation = True
		Me.txtSource.Enabled = True
		Me.txtSource.ForeColor = System.Drawing.SystemColors.WindowText
		Me.txtSource.HideSelection = True
		Me.txtSource.ReadOnly = False
		Me.txtSource.Cursor = System.Windows.Forms.Cursors.IBeam
		Me.txtSource.MultiLine = False
		Me.txtSource.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.txtSource.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me.txtSource.TabStop = True
		Me.txtSource.Visible = True
		Me.txtSource.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.txtSource.Name = "txtSource"
		Me.TxtSourcePhone.AutoSize = False
		Me.TxtSourcePhone.Size = New System.Drawing.Size(83, 21)
		Me.TxtSourcePhone.Location = New System.Drawing.Point(80, 110)
		Me.TxtSourcePhone.Maxlength = 14
		Me.TxtSourcePhone.TabIndex = 5
		Me.ToolTip1.SetToolTip(Me.TxtSourcePhone, "OPO Phone")
		Me.TxtSourcePhone.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.TxtSourcePhone.AcceptsReturn = True
		Me.TxtSourcePhone.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me.TxtSourcePhone.BackColor = System.Drawing.SystemColors.Window
		Me.TxtSourcePhone.CausesValidation = True
		Me.TxtSourcePhone.Enabled = True
		Me.TxtSourcePhone.ForeColor = System.Drawing.SystemColors.WindowText
		Me.TxtSourcePhone.HideSelection = True
		Me.TxtSourcePhone.ReadOnly = False
		Me.TxtSourcePhone.Cursor = System.Windows.Forms.Cursors.IBeam
		Me.TxtSourcePhone.MultiLine = False
		Me.TxtSourcePhone.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.TxtSourcePhone.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me.TxtSourcePhone.TabStop = True
		Me.TxtSourcePhone.Visible = True
		Me.TxtSourcePhone.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.TxtSourcePhone.Name = "TxtSourcePhone"
		Me.TxtDonorNumber.AutoSize = False
		Me.TxtDonorNumber.Size = New System.Drawing.Size(323, 21)
		Me.TxtDonorNumber.Location = New System.Drawing.Point(80, 38)
		Me.TxtDonorNumber.Maxlength = 50
		Me.TxtDonorNumber.TabIndex = 2
		Me.ToolTip1.SetToolTip(Me.TxtDonorNumber, "NDRI Provided")
		Me.TxtDonorNumber.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.TxtDonorNumber.AcceptsReturn = True
		Me.TxtDonorNumber.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me.TxtDonorNumber.BackColor = System.Drawing.SystemColors.Window
		Me.TxtDonorNumber.CausesValidation = True
		Me.TxtDonorNumber.Enabled = True
		Me.TxtDonorNumber.ForeColor = System.Drawing.SystemColors.WindowText
		Me.TxtDonorNumber.HideSelection = True
		Me.TxtDonorNumber.ReadOnly = False
		Me.TxtDonorNumber.Cursor = System.Windows.Forms.Cursors.IBeam
		Me.TxtDonorNumber.MultiLine = False
		Me.TxtDonorNumber.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.TxtDonorNumber.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me.TxtDonorNumber.TabStop = True
		Me.TxtDonorNumber.Visible = True
		Me.TxtDonorNumber.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.TxtDonorNumber.Name = "TxtDonorNumber"
		Me.TxtCallDate.AutoSize = False
		Me.TxtCallDate.Size = New System.Drawing.Size(57, 21)
		Me.TxtCallDate.Location = New System.Drawing.Point(80, 16)
		Me.TxtCallDate.TabIndex = 0
		Me.ToolTip1.SetToolTip(Me.TxtCallDate, "Call Date")
		Me.TxtCallDate.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.TxtCallDate.AcceptsReturn = True
		Me.TxtCallDate.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me.TxtCallDate.BackColor = System.Drawing.SystemColors.Window
		Me.TxtCallDate.CausesValidation = True
		Me.TxtCallDate.Enabled = True
		Me.TxtCallDate.ForeColor = System.Drawing.SystemColors.WindowText
		Me.TxtCallDate.HideSelection = True
		Me.TxtCallDate.ReadOnly = False
		Me.TxtCallDate.Maxlength = 0
		Me.TxtCallDate.Cursor = System.Windows.Forms.Cursors.IBeam
		Me.TxtCallDate.MultiLine = False
		Me.TxtCallDate.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.TxtCallDate.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me.TxtCallDate.TabStop = True
		Me.TxtCallDate.Visible = True
		Me.TxtCallDate.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.TxtCallDate.Name = "TxtCallDate"
		Me.LblCallTime.Text = "Time"
		Me.LblCallTime.ForeColor = System.Drawing.Color.Black
		Me.LblCallTime.Size = New System.Drawing.Size(23, 13)
		Me.LblCallTime.Location = New System.Drawing.Point(144, 21)
		Me.LblCallTime.TabIndex = 66
		Me.ToolTip1.SetToolTip(Me.LblCallTime, "Call Time")
		Me.LblCallTime.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.LblCallTime.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me.LblCallTime.BackColor = System.Drawing.SystemColors.Control
		Me.LblCallTime.Enabled = True
		Me.LblCallTime.Cursor = System.Windows.Forms.Cursors.Default
		Me.LblCallTime.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.LblCallTime.UseMnemonic = True
		Me.LblCallTime.Visible = True
		Me.LblCallTime.AutoSize = True
		Me.LblCallTime.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.LblCallTime.Name = "LblCallTime"
		Me._LblDOD_1.Text = "Time"
		Me._LblDOD_1.ForeColor = System.Drawing.Color.Black
		Me._LblDOD_1.Size = New System.Drawing.Size(23, 13)
		Me._LblDOD_1.Location = New System.Drawing.Point(144, 259)
		Me._LblDOD_1.TabIndex = 65
		Me.ToolTip1.SetToolTip(Me._LblDOD_1, "Death Time")
		Me._LblDOD_1.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me._LblDOD_1.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me._LblDOD_1.BackColor = System.Drawing.SystemColors.Control
		Me._LblDOD_1.Enabled = True
		Me._LblDOD_1.Cursor = System.Windows.Forms.Cursors.Default
		Me._LblDOD_1.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me._LblDOD_1.UseMnemonic = True
		Me._LblDOD_1.Visible = True
		Me._LblDOD_1.AutoSize = True
		Me._LblDOD_1.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me._LblDOD_1.Name = "_LblDOD_1"
		Me.lblRace.Text = "Race"
		Me.lblRace.Size = New System.Drawing.Size(33, 15)
		Me.lblRace.Location = New System.Drawing.Point(48, 160)
		Me.lblRace.TabIndex = 64
		Me.ToolTip1.SetToolTip(Me.lblRace, "Race")
		Me.lblRace.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblRace.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me.lblRace.BackColor = System.Drawing.SystemColors.Control
		Me.lblRace.Enabled = True
		Me.lblRace.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblRace.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblRace.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblRace.UseMnemonic = True
		Me.lblRace.Visible = True
		Me.lblRace.AutoSize = False
		Me.lblRace.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblRace.Name = "lblRace"
		Me.lblOtherKnownDiseases.Text = "Other Known Diseases"
		Me.lblOtherKnownDiseases.Size = New System.Drawing.Size(65, 31)
		Me.lblOtherKnownDiseases.Location = New System.Drawing.Point(16, 328)
		Me.lblOtherKnownDiseases.TabIndex = 49
		Me.ToolTip1.SetToolTip(Me.lblOtherKnownDiseases, "Other Diseases")
		Me.lblOtherKnownDiseases.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblOtherKnownDiseases.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me.lblOtherKnownDiseases.BackColor = System.Drawing.SystemColors.Control
		Me.lblOtherKnownDiseases.Enabled = True
		Me.lblOtherKnownDiseases.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblOtherKnownDiseases.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblOtherKnownDiseases.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblOtherKnownDiseases.UseMnemonic = True
		Me.lblOtherKnownDiseases.Visible = True
		Me.lblOtherKnownDiseases.AutoSize = False
		Me.lblOtherKnownDiseases.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblOtherKnownDiseases.Name = "lblOtherKnownDiseases"
		Me.lblVL.Text = "Viral Load"
		Me.lblVL.Size = New System.Drawing.Size(49, 15)
		Me.lblVL.Location = New System.Drawing.Point(25, 308)
		Me.lblVL.TabIndex = 48
		Me.ToolTip1.SetToolTip(Me.lblVL, "Viral Load")
		Me.lblVL.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblVL.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me.lblVL.BackColor = System.Drawing.SystemColors.Control
		Me.lblVL.Enabled = True
		Me.lblVL.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblVL.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblVL.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblVL.UseMnemonic = True
		Me.lblVL.Visible = True
		Me.lblVL.AutoSize = False
		Me.lblVL.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblVL.Name = "lblVL"
		Me.lblCD4.Text = "CD4"
		Me.lblCD4.Size = New System.Drawing.Size(33, 15)
		Me.lblCD4.Location = New System.Drawing.Point(53, 284)
		Me.lblCD4.TabIndex = 47
		Me.ToolTip1.SetToolTip(Me.lblCD4, "T-Cell Count")
		Me.lblCD4.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblCD4.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me.lblCD4.BackColor = System.Drawing.SystemColors.Control
		Me.lblCD4.Enabled = True
		Me.lblCD4.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblCD4.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblCD4.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblCD4.UseMnemonic = True
		Me.lblCD4.Visible = True
		Me.lblCD4.AutoSize = False
		Me.lblCD4.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblCD4.Name = "lblCD4"
		Me._LblDOD_0.Text = "Death Date"
		Me._LblDOD_0.ForeColor = System.Drawing.Color.Black
		Me._LblDOD_0.Size = New System.Drawing.Size(55, 13)
		Me._LblDOD_0.Location = New System.Drawing.Point(21, 259)
		Me._LblDOD_0.TabIndex = 46
		Me.ToolTip1.SetToolTip(Me._LblDOD_0, "Death Date")
		Me._LblDOD_0.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me._LblDOD_0.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me._LblDOD_0.BackColor = System.Drawing.SystemColors.Control
		Me._LblDOD_0.Enabled = True
		Me._LblDOD_0.Cursor = System.Windows.Forms.Cursors.Default
		Me._LblDOD_0.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me._LblDOD_0.UseMnemonic = True
		Me._LblDOD_0.Visible = True
		Me._LblDOD_0.AutoSize = True
		Me._LblDOD_0.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me._LblDOD_0.Name = "_LblDOD_0"
		Me.lblCOD_S.Text = "COD/S"
		Me.lblCOD_S.Size = New System.Drawing.Size(41, 15)
		Me.lblCOD_S.Location = New System.Drawing.Point(40, 238)
		Me.lblCOD_S.TabIndex = 45
		Me.ToolTip1.SetToolTip(Me.lblCOD_S, "Cause of Death")
		Me.lblCOD_S.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblCOD_S.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me.lblCOD_S.BackColor = System.Drawing.SystemColors.Control
		Me.lblCOD_S.Enabled = True
		Me.lblCOD_S.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblCOD_S.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblCOD_S.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblCOD_S.UseMnemonic = True
		Me.lblCOD_S.Visible = True
		Me.lblCOD_S.AutoSize = False
		Me.lblCOD_S.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblCOD_S.Name = "lblCOD_S"
		Me.lblABO_Rh.Text = "ABO/Rh"
		Me.lblABO_Rh.Size = New System.Drawing.Size(41, 15)
		Me.lblABO_Rh.Location = New System.Drawing.Point(32, 214)
		Me.lblABO_Rh.TabIndex = 44
		Me.ToolTip1.SetToolTip(Me.lblABO_Rh, "Blood Type")
		Me.lblABO_Rh.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblABO_Rh.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me.lblABO_Rh.BackColor = System.Drawing.SystemColors.Control
		Me.lblABO_Rh.Enabled = True
		Me.lblABO_Rh.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblABO_Rh.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblABO_Rh.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblABO_Rh.UseMnemonic = True
		Me.lblABO_Rh.Visible = True
		Me.lblABO_Rh.AutoSize = False
		Me.lblABO_Rh.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblABO_Rh.Name = "lblABO_Rh"
		Me.lblSex.Text = "Sex"
		Me.lblSex.Size = New System.Drawing.Size(25, 15)
		Me.lblSex.Location = New System.Drawing.Point(56, 186)
		Me.lblSex.TabIndex = 41
		Me.ToolTip1.SetToolTip(Me.lblSex, "Sex")
		Me.lblSex.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblSex.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me.lblSex.BackColor = System.Drawing.SystemColors.Control
		Me.lblSex.Enabled = True
		Me.lblSex.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblSex.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblSex.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblSex.UseMnemonic = True
		Me.lblSex.Visible = True
		Me.lblSex.AutoSize = False
		Me.lblSex.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblSex.Name = "lblSex"
		Me.lblAge.Text = "Age"
		Me.lblAge.Size = New System.Drawing.Size(25, 15)
		Me.lblAge.Location = New System.Drawing.Point(56, 136)
		Me.lblAge.TabIndex = 40
		Me.ToolTip1.SetToolTip(Me.lblAge, "Age")
		Me.lblAge.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblAge.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me.lblAge.BackColor = System.Drawing.SystemColors.Control
		Me.lblAge.Enabled = True
		Me.lblAge.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblAge.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblAge.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblAge.UseMnemonic = True
		Me.lblAge.Visible = True
		Me.lblAge.AutoSize = False
		Me.lblAge.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblAge.Name = "lblAge"
		Me.lblSource.Text = "Source"
		Me.lblSource.Size = New System.Drawing.Size(41, 15)
		Me.lblSource.Location = New System.Drawing.Point(40, 90)
		Me.lblSource.TabIndex = 39
		Me.ToolTip1.SetToolTip(Me.lblSource, "OPO Name")
		Me.lblSource.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblSource.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me.lblSource.BackColor = System.Drawing.SystemColors.Control
		Me.lblSource.Enabled = True
		Me.lblSource.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblSource.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblSource.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblSource.UseMnemonic = True
		Me.lblSource.Visible = True
		Me.lblSource.AutoSize = False
		Me.lblSource.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblSource.Name = "lblSource"
		Me.LblSourcePhone.Text = "Phone"
		Me.LblSourcePhone.Size = New System.Drawing.Size(31, 13)
		Me.LblSourcePhone.Location = New System.Drawing.Point(45, 112)
		Me.LblSourcePhone.TabIndex = 38
		Me.ToolTip1.SetToolTip(Me.LblSourcePhone, "OPO Phone")
		Me.LblSourcePhone.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.LblSourcePhone.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me.LblSourcePhone.BackColor = System.Drawing.SystemColors.Control
		Me.LblSourcePhone.Enabled = True
		Me.LblSourcePhone.ForeColor = System.Drawing.SystemColors.ControlText
		Me.LblSourcePhone.Cursor = System.Windows.Forms.Cursors.Default
		Me.LblSourcePhone.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.LblSourcePhone.UseMnemonic = True
		Me.LblSourcePhone.Visible = True
		Me.LblSourcePhone.AutoSize = True
		Me.LblSourcePhone.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.LblSourcePhone.Name = "LblSourcePhone"
		Me.LblCoordName.Text = "Coord Name"
		Me.LblCoordName.Size = New System.Drawing.Size(65, 15)
		Me.LblCoordName.Location = New System.Drawing.Point(16, 67)
		Me.LblCoordName.TabIndex = 37
		Me.ToolTip1.SetToolTip(Me.LblCoordName, "Approacher")
		Me.LblCoordName.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.LblCoordName.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me.LblCoordName.BackColor = System.Drawing.SystemColors.Control
		Me.LblCoordName.Enabled = True
		Me.LblCoordName.ForeColor = System.Drawing.SystemColors.ControlText
		Me.LblCoordName.Cursor = System.Windows.Forms.Cursors.Default
		Me.LblCoordName.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.LblCoordName.UseMnemonic = True
		Me.LblCoordName.Visible = True
		Me.LblCoordName.AutoSize = False
		Me.LblCoordName.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.LblCoordName.Name = "LblCoordName"
		Me.LblDonorNumber.Text = "Donor #"
		Me.LblDonorNumber.Size = New System.Drawing.Size(41, 15)
		Me.LblDonorNumber.Location = New System.Drawing.Point(32, 41)
		Me.LblDonorNumber.TabIndex = 36
		Me.ToolTip1.SetToolTip(Me.LblDonorNumber, "NDRI Provided")
		Me.LblDonorNumber.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.LblDonorNumber.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me.LblDonorNumber.BackColor = System.Drawing.SystemColors.Control
		Me.LblDonorNumber.Enabled = True
		Me.LblDonorNumber.ForeColor = System.Drawing.SystemColors.ControlText
		Me.LblDonorNumber.Cursor = System.Windows.Forms.Cursors.Default
		Me.LblDonorNumber.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.LblDonorNumber.UseMnemonic = True
		Me.LblDonorNumber.Visible = True
		Me.LblDonorNumber.AutoSize = False
		Me.LblDonorNumber.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.LblDonorNumber.Name = "LblDonorNumber"
		Me.LblCallDate.Text = "Call Date"
		Me.LblCallDate.ForeColor = System.Drawing.Color.Black
		Me.LblCallDate.Size = New System.Drawing.Size(43, 13)
		Me.LblCallDate.Location = New System.Drawing.Point(24, 21)
		Me.LblCallDate.TabIndex = 35
		Me.ToolTip1.SetToolTip(Me.LblCallDate, "Call Date")
		Me.LblCallDate.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.LblCallDate.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me.LblCallDate.BackColor = System.Drawing.SystemColors.Control
		Me.LblCallDate.Enabled = True
		Me.LblCallDate.Cursor = System.Windows.Forms.Cursors.Default
		Me.LblCallDate.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.LblCallDate.UseMnemonic = True
		Me.LblCallDate.Visible = True
		Me.LblCallDate.AutoSize = True
		Me.LblCallDate.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.LblCallDate.Name = "LblCallDate"
		Me._tabNDRI_TabPage1.Text = "Medical"
		Me.FraMedical.Size = New System.Drawing.Size(465, 441)
		Me.FraMedical.Location = New System.Drawing.Point(8, 24)
		Me.FraMedical.TabIndex = 42
		Me.FraMedical.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.FraMedical.BackColor = System.Drawing.SystemColors.Control
		Me.FraMedical.Enabled = True
		Me.FraMedical.ForeColor = System.Drawing.SystemColors.ControlText
		Me.FraMedical.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.FraMedical.Visible = True
		Me.FraMedical.Padding = New System.Windows.Forms.Padding(0)
		Me.FraMedical.Name = "FraMedical"
		Me.txtMedHxOther.AutoSize = False
		Me.txtMedHxOther.Size = New System.Drawing.Size(325, 61)
		Me.txtMedHxOther.Location = New System.Drawing.Point(112, 80)
		Me.txtMedHxOther.Maxlength = 500
		Me.txtMedHxOther.MultiLine = True
		Me.txtMedHxOther.ScrollBars = System.Windows.Forms.ScrollBars.Vertical
		Me.txtMedHxOther.TabIndex = 21
		Me.ToolTip1.SetToolTip(Me.txtMedHxOther, "Other Med Hx")
		Me.txtMedHxOther.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.txtMedHxOther.AcceptsReturn = True
		Me.txtMedHxOther.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me.txtMedHxOther.BackColor = System.Drawing.SystemColors.Window
		Me.txtMedHxOther.CausesValidation = True
		Me.txtMedHxOther.Enabled = True
		Me.txtMedHxOther.ForeColor = System.Drawing.SystemColors.WindowText
		Me.txtMedHxOther.HideSelection = True
		Me.txtMedHxOther.ReadOnly = False
		Me.txtMedHxOther.Cursor = System.Windows.Forms.Cursors.IBeam
		Me.txtMedHxOther.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.txtMedHxOther.TabStop = True
		Me.txtMedHxOther.Visible = True
		Me.txtMedHxOther.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.txtMedHxOther.Name = "txtMedHxOther"
        Me.cboSubstanceAbuse.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.cboSubstanceAbuse.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.cboSubstanceAbuse.Size = New System.Drawing.Size(75, 21)
		Me.cboSubstanceAbuse.Location = New System.Drawing.Point(256, 40)
		Me.cboSubstanceAbuse.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
		Me.cboSubstanceAbuse.TabIndex = 20
		Me.ToolTip1.SetToolTip(Me.cboSubstanceAbuse, "Substance Abuse")
		Me.cboSubstanceAbuse.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.cboSubstanceAbuse.BackColor = System.Drawing.SystemColors.Window
		Me.cboSubstanceAbuse.CausesValidation = True
		Me.cboSubstanceAbuse.Enabled = True
		Me.cboSubstanceAbuse.ForeColor = System.Drawing.SystemColors.WindowText
		Me.cboSubstanceAbuse.IntegralHeight = True
		Me.cboSubstanceAbuse.Cursor = System.Windows.Forms.Cursors.Default
		Me.cboSubstanceAbuse.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.cboSubstanceAbuse.Sorted = False
		Me.cboSubstanceAbuse.TabStop = True
		Me.cboSubstanceAbuse.Visible = True
		Me.cboSubstanceAbuse.Name = "cboSubstanceAbuse"
        Me.cboRadiation.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.cboRadiation.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.cboRadiation.Size = New System.Drawing.Size(75, 21)
		Me.cboRadiation.Location = New System.Drawing.Point(64, 40)
		Me.cboRadiation.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
		Me.cboRadiation.TabIndex = 18
		Me.ToolTip1.SetToolTip(Me.cboRadiation, "Radiation")
		Me.cboRadiation.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.cboRadiation.BackColor = System.Drawing.SystemColors.Window
		Me.cboRadiation.CausesValidation = True
		Me.cboRadiation.Enabled = True
		Me.cboRadiation.ForeColor = System.Drawing.SystemColors.WindowText
		Me.cboRadiation.IntegralHeight = True
		Me.cboRadiation.Cursor = System.Windows.Forms.Cursors.Default
		Me.cboRadiation.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.cboRadiation.Sorted = False
		Me.cboRadiation.TabStop = True
		Me.cboRadiation.Visible = True
        Me.cboRadiation.Name = "cboRadiation"
        Me.cboChemotherapy.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.cboChemotherapy.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.cboChemotherapy.Size = New System.Drawing.Size(75, 21)
		Me.cboChemotherapy.Location = New System.Drawing.Point(256, 16)
		Me.cboChemotherapy.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
		Me.cboChemotherapy.TabIndex = 19
		Me.ToolTip1.SetToolTip(Me.cboChemotherapy, "Chemotherapy")
		Me.cboChemotherapy.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.cboChemotherapy.BackColor = System.Drawing.SystemColors.Window
		Me.cboChemotherapy.CausesValidation = True
		Me.cboChemotherapy.Enabled = True
		Me.cboChemotherapy.ForeColor = System.Drawing.SystemColors.WindowText
		Me.cboChemotherapy.IntegralHeight = True
		Me.cboChemotherapy.Cursor = System.Windows.Forms.Cursors.Default
		Me.cboChemotherapy.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.cboChemotherapy.Sorted = False
		Me.cboChemotherapy.TabStop = True
		Me.cboChemotherapy.Visible = True
		Me.cboChemotherapy.Name = "cboChemotherapy"
        Me.cboSepsis.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.cboSepsis.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.cboSepsis.Size = New System.Drawing.Size(75, 21)
		Me.cboSepsis.Location = New System.Drawing.Point(64, 16)
		Me.cboSepsis.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
		Me.cboSepsis.TabIndex = 17
		Me.ToolTip1.SetToolTip(Me.cboSepsis, "Sepsis")
		Me.cboSepsis.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.cboSepsis.BackColor = System.Drawing.SystemColors.Window
		Me.cboSepsis.CausesValidation = True
		Me.cboSepsis.Enabled = True
		Me.cboSepsis.ForeColor = System.Drawing.SystemColors.WindowText
		Me.cboSepsis.IntegralHeight = True
		Me.cboSepsis.Cursor = System.Windows.Forms.Cursors.Default
		Me.cboSepsis.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.cboSepsis.Sorted = False
		Me.cboSepsis.TabStop = True
		Me.cboSepsis.Visible = True
		Me.cboSepsis.Name = "cboSepsis"
		Me.ctlNDRIMedications.Size = New System.Drawing.Size(433, 265)
		Me.ctlNDRIMedications.Location = New System.Drawing.Point(16, 168)
		Me.ctlNDRIMedications.TabIndex = 22
		Me.ctlNDRIMedications.Tag = "SecondaryAntibioticList"
		Me.ToolTip1.SetToolTip(Me.ctlNDRIMedications, "Medications")
		Me.ctlNDRIMedications.Name = "ctlNDRIMedications"
		Me.lblInfo.Text = "Medications (If known, please indicate dose, Start/End Date)"
		Me.lblInfo.Size = New System.Drawing.Size(305, 17)
		Me.lblInfo.Location = New System.Drawing.Point(16, 152)
		Me.lblInfo.TabIndex = 63
		Me.ToolTip1.SetToolTip(Me.lblInfo, "Medications")
		Me.lblInfo.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblInfo.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me.lblInfo.BackColor = System.Drawing.SystemColors.Control
		Me.lblInfo.Enabled = True
		Me.lblInfo.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblInfo.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblInfo.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblInfo.UseMnemonic = True
		Me.lblInfo.Visible = True
		Me.lblInfo.AutoSize = False
		Me.lblInfo.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblInfo.Name = "lblInfo"
		Me.lblMedHxOther.Text = "Other Medical Hx"
		Me.lblMedHxOther.Size = New System.Drawing.Size(97, 23)
		Me.lblMedHxOther.Location = New System.Drawing.Point(16, 84)
		Me.lblMedHxOther.TabIndex = 54
		Me.ToolTip1.SetToolTip(Me.lblMedHxOther, "Other Med Hx")
		Me.lblMedHxOther.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblMedHxOther.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me.lblMedHxOther.BackColor = System.Drawing.SystemColors.Control
		Me.lblMedHxOther.Enabled = True
		Me.lblMedHxOther.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblMedHxOther.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblMedHxOther.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblMedHxOther.UseMnemonic = True
		Me.lblMedHxOther.Visible = True
		Me.lblMedHxOther.AutoSize = False
		Me.lblMedHxOther.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblMedHxOther.Name = "lblMedHxOther"
		Me.lblSubstanceAbuse.Text = "Substance Abuse"
		Me.lblSubstanceAbuse.Size = New System.Drawing.Size(89, 15)
		Me.lblSubstanceAbuse.Location = New System.Drawing.Point(168, 46)
		Me.lblSubstanceAbuse.TabIndex = 53
		Me.ToolTip1.SetToolTip(Me.lblSubstanceAbuse, "Substance Abuse")
		Me.lblSubstanceAbuse.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblSubstanceAbuse.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me.lblSubstanceAbuse.BackColor = System.Drawing.SystemColors.Control
		Me.lblSubstanceAbuse.Enabled = True
		Me.lblSubstanceAbuse.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblSubstanceAbuse.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblSubstanceAbuse.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblSubstanceAbuse.UseMnemonic = True
		Me.lblSubstanceAbuse.Visible = True
		Me.lblSubstanceAbuse.AutoSize = False
		Me.lblSubstanceAbuse.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblSubstanceAbuse.Name = "lblSubstanceAbuse"
		Me.lblRadiation.Text = "Radiation"
		Me.lblRadiation.Size = New System.Drawing.Size(49, 15)
		Me.lblRadiation.Location = New System.Drawing.Point(16, 46)
		Me.lblRadiation.TabIndex = 52
		Me.ToolTip1.SetToolTip(Me.lblRadiation, "Radiation")
		Me.lblRadiation.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblRadiation.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me.lblRadiation.BackColor = System.Drawing.SystemColors.Control
		Me.lblRadiation.Enabled = True
		Me.lblRadiation.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblRadiation.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblRadiation.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblRadiation.UseMnemonic = True
		Me.lblRadiation.Visible = True
		Me.lblRadiation.AutoSize = False
		Me.lblRadiation.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblRadiation.Name = "lblRadiation"
		Me.lblChemotherapy.Text = "Chemotherapy"
		Me.lblChemotherapy.Size = New System.Drawing.Size(73, 15)
		Me.lblChemotherapy.Location = New System.Drawing.Point(184, 22)
		Me.lblChemotherapy.TabIndex = 51
		Me.ToolTip1.SetToolTip(Me.lblChemotherapy, "Chemotherapy")
		Me.lblChemotherapy.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblChemotherapy.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me.lblChemotherapy.BackColor = System.Drawing.SystemColors.Control
		Me.lblChemotherapy.Enabled = True
		Me.lblChemotherapy.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblChemotherapy.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblChemotherapy.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblChemotherapy.UseMnemonic = True
		Me.lblChemotherapy.Visible = True
		Me.lblChemotherapy.AutoSize = False
		Me.lblChemotherapy.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblChemotherapy.Name = "lblChemotherapy"
		Me.lblSepsis.Text = "Sepsis"
		Me.lblSepsis.Size = New System.Drawing.Size(41, 15)
		Me.lblSepsis.Location = New System.Drawing.Point(24, 22)
		Me.lblSepsis.TabIndex = 50
		Me.ToolTip1.SetToolTip(Me.lblSepsis, "Sepsis")
		Me.lblSepsis.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblSepsis.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me.lblSepsis.BackColor = System.Drawing.SystemColors.Control
		Me.lblSepsis.Enabled = True
		Me.lblSepsis.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblSepsis.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblSepsis.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblSepsis.UseMnemonic = True
		Me.lblSepsis.Visible = True
		Me.lblSepsis.AutoSize = False
		Me.lblSepsis.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblSepsis.Name = "lblSepsis"
		Me._tabNDRI_TabPage2.Text = "Other"
		Me.FraOther.Size = New System.Drawing.Size(465, 257)
		Me.FraOther.Location = New System.Drawing.Point(8, 24)
		Me.FraOther.TabIndex = 43
		Me.FraOther.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.FraOther.BackColor = System.Drawing.SystemColors.Control
		Me.FraOther.Enabled = True
		Me.FraOther.ForeColor = System.Drawing.SystemColors.ControlText
		Me.FraOther.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.FraOther.Visible = True
		Me.FraOther.Padding = New System.Windows.Forms.Padding(0)
		Me.FraOther.Name = "FraOther"
		Me.txtAdditionalComments.AutoSize = False
		Me.txtAdditionalComments.Size = New System.Drawing.Size(291, 61)
		Me.txtAdditionalComments.Location = New System.Drawing.Point(136, 184)
		Me.txtAdditionalComments.Maxlength = 500
		Me.txtAdditionalComments.MultiLine = True
		Me.txtAdditionalComments.ScrollBars = System.Windows.Forms.ScrollBars.Vertical
		Me.txtAdditionalComments.TabIndex = 30
		Me.ToolTip1.SetToolTip(Me.txtAdditionalComments, "Additional Comments")
		Me.txtAdditionalComments.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.txtAdditionalComments.AcceptsReturn = True
		Me.txtAdditionalComments.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me.txtAdditionalComments.BackColor = System.Drawing.SystemColors.Window
		Me.txtAdditionalComments.CausesValidation = True
		Me.txtAdditionalComments.Enabled = True
		Me.txtAdditionalComments.ForeColor = System.Drawing.SystemColors.WindowText
		Me.txtAdditionalComments.HideSelection = True
		Me.txtAdditionalComments.ReadOnly = False
		Me.txtAdditionalComments.Cursor = System.Windows.Forms.Cursors.IBeam
		Me.txtAdditionalComments.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.txtAdditionalComments.TabStop = True
		Me.txtAdditionalComments.Visible = True
		Me.txtAdditionalComments.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.txtAdditionalComments.Name = "txtAdditionalComments"
        Me.cboFamilyKnowsStatus.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.cboFamilyKnowsStatus.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.cboFamilyKnowsStatus.Size = New System.Drawing.Size(67, 21)
		Me.cboFamilyKnowsStatus.Location = New System.Drawing.Point(136, 136)
		Me.cboFamilyKnowsStatus.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
		Me.cboFamilyKnowsStatus.TabIndex = 28
		Me.ToolTip1.SetToolTip(Me.cboFamilyKnowsStatus, "Does family know of HIV status?")
		Me.cboFamilyKnowsStatus.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.cboFamilyKnowsStatus.BackColor = System.Drawing.SystemColors.Window
		Me.cboFamilyKnowsStatus.CausesValidation = True
		Me.cboFamilyKnowsStatus.Enabled = True
		Me.cboFamilyKnowsStatus.ForeColor = System.Drawing.SystemColors.WindowText
		Me.cboFamilyKnowsStatus.IntegralHeight = True
		Me.cboFamilyKnowsStatus.Cursor = System.Windows.Forms.Cursors.Default
		Me.cboFamilyKnowsStatus.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.cboFamilyKnowsStatus.Sorted = False
		Me.cboFamilyKnowsStatus.TabStop = True
		Me.cboFamilyKnowsStatus.Visible = True
		Me.cboFamilyKnowsStatus.Name = "cboFamilyKnowsStatus"
        Me.cboFamilyAtHospital.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.cboFamilyAtHospital.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.cboFamilyAtHospital.Size = New System.Drawing.Size(67, 21)
		Me.cboFamilyAtHospital.Location = New System.Drawing.Point(136, 112)
		Me.cboFamilyAtHospital.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
		Me.cboFamilyAtHospital.TabIndex = 27
		Me.ToolTip1.SetToolTip(Me.cboFamilyAtHospital, "Family currently at hospital?")
		Me.cboFamilyAtHospital.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.cboFamilyAtHospital.BackColor = System.Drawing.SystemColors.Window
		Me.cboFamilyAtHospital.CausesValidation = True
		Me.cboFamilyAtHospital.Enabled = True
		Me.cboFamilyAtHospital.ForeColor = System.Drawing.SystemColors.WindowText
		Me.cboFamilyAtHospital.IntegralHeight = True
		Me.cboFamilyAtHospital.Cursor = System.Windows.Forms.Cursors.Default
		Me.cboFamilyAtHospital.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.cboFamilyAtHospital.Sorted = False
		Me.cboFamilyAtHospital.TabStop = True
		Me.cboFamilyAtHospital.Visible = True
		Me.cboFamilyAtHospital.Name = "cboFamilyAtHospital"
		Me.txtFuneralHome.AutoSize = False
		Me.txtFuneralHome.Size = New System.Drawing.Size(291, 21)
		Me.txtFuneralHome.Location = New System.Drawing.Point(136, 160)
		Me.txtFuneralHome.Maxlength = 80
		Me.txtFuneralHome.TabIndex = 29
		Me.ToolTip1.SetToolTip(Me.txtFuneralHome, "Funeral Home (if known)")
		Me.txtFuneralHome.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.txtFuneralHome.AcceptsReturn = True
		Me.txtFuneralHome.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me.txtFuneralHome.BackColor = System.Drawing.SystemColors.Window
		Me.txtFuneralHome.CausesValidation = True
		Me.txtFuneralHome.Enabled = True
		Me.txtFuneralHome.ForeColor = System.Drawing.SystemColors.WindowText
		Me.txtFuneralHome.HideSelection = True
		Me.txtFuneralHome.ReadOnly = False
		Me.txtFuneralHome.Cursor = System.Windows.Forms.Cursors.IBeam
		Me.txtFuneralHome.MultiLine = False
		Me.txtFuneralHome.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.txtFuneralHome.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me.txtFuneralHome.TabStop = True
		Me.txtFuneralHome.Visible = True
		Me.txtFuneralHome.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.txtFuneralHome.Name = "txtFuneralHome"
		Me.txtAttendingPhone.AutoSize = False
		Me.txtAttendingPhone.Size = New System.Drawing.Size(83, 21)
		Me.txtAttendingPhone.Location = New System.Drawing.Point(136, 88)
		Me.txtAttendingPhone.Maxlength = 14
		Me.txtAttendingPhone.TabIndex = 26
		Me.ToolTip1.SetToolTip(Me.txtAttendingPhone, "Attending Physician Phone")
		Me.txtAttendingPhone.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.txtAttendingPhone.AcceptsReturn = True
		Me.txtAttendingPhone.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me.txtAttendingPhone.BackColor = System.Drawing.SystemColors.Window
		Me.txtAttendingPhone.CausesValidation = True
		Me.txtAttendingPhone.Enabled = True
		Me.txtAttendingPhone.ForeColor = System.Drawing.SystemColors.WindowText
		Me.txtAttendingPhone.HideSelection = True
		Me.txtAttendingPhone.ReadOnly = False
		Me.txtAttendingPhone.Cursor = System.Windows.Forms.Cursors.IBeam
		Me.txtAttendingPhone.MultiLine = False
		Me.txtAttendingPhone.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.txtAttendingPhone.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me.txtAttendingPhone.TabStop = True
		Me.txtAttendingPhone.Visible = True
		Me.txtAttendingPhone.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.txtAttendingPhone.Name = "txtAttendingPhone"
		Me.txtAttendingPhysician.AutoSize = False
		Me.txtAttendingPhysician.Size = New System.Drawing.Size(291, 21)
		Me.txtAttendingPhysician.Location = New System.Drawing.Point(136, 64)
		Me.txtAttendingPhysician.Maxlength = 101
		Me.txtAttendingPhysician.TabIndex = 25
		Me.ToolTip1.SetToolTip(Me.txtAttendingPhysician, "Attending Physician")
		Me.txtAttendingPhysician.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.txtAttendingPhysician.AcceptsReturn = True
		Me.txtAttendingPhysician.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me.txtAttendingPhysician.BackColor = System.Drawing.SystemColors.Window
		Me.txtAttendingPhysician.CausesValidation = True
		Me.txtAttendingPhysician.Enabled = True
		Me.txtAttendingPhysician.ForeColor = System.Drawing.SystemColors.WindowText
		Me.txtAttendingPhysician.HideSelection = True
		Me.txtAttendingPhysician.ReadOnly = False
		Me.txtAttendingPhysician.Cursor = System.Windows.Forms.Cursors.IBeam
		Me.txtAttendingPhysician.MultiLine = False
		Me.txtAttendingPhysician.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.txtAttendingPhysician.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me.txtAttendingPhysician.TabStop = True
		Me.txtAttendingPhysician.Visible = True
		Me.txtAttendingPhysician.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.txtAttendingPhysician.Name = "txtAttendingPhysician"
		Me.txtAttendingNurse.AutoSize = False
		Me.txtAttendingNurse.Size = New System.Drawing.Size(291, 21)
		Me.txtAttendingNurse.Location = New System.Drawing.Point(136, 40)
		Me.txtAttendingNurse.Maxlength = 101
		Me.txtAttendingNurse.TabIndex = 24
		Me.ToolTip1.SetToolTip(Me.txtAttendingNurse, "Nurse currently attending")
		Me.txtAttendingNurse.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.txtAttendingNurse.AcceptsReturn = True
		Me.txtAttendingNurse.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me.txtAttendingNurse.BackColor = System.Drawing.SystemColors.Window
		Me.txtAttendingNurse.CausesValidation = True
		Me.txtAttendingNurse.Enabled = True
		Me.txtAttendingNurse.ForeColor = System.Drawing.SystemColors.WindowText
		Me.txtAttendingNurse.HideSelection = True
		Me.txtAttendingNurse.ReadOnly = False
		Me.txtAttendingNurse.Cursor = System.Windows.Forms.Cursors.IBeam
		Me.txtAttendingNurse.MultiLine = False
		Me.txtAttendingNurse.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.txtAttendingNurse.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me.txtAttendingNurse.TabStop = True
		Me.txtAttendingNurse.Visible = True
		Me.txtAttendingNurse.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.txtAttendingNurse.Name = "txtAttendingNurse"
		Me.txtAttendingHospital.AutoSize = False
		Me.txtAttendingHospital.Size = New System.Drawing.Size(291, 21)
		Me.txtAttendingHospital.Location = New System.Drawing.Point(136, 16)
		Me.txtAttendingHospital.Maxlength = 80
		Me.txtAttendingHospital.TabIndex = 23
		Me.ToolTip1.SetToolTip(Me.txtAttendingHospital, "Hospital where patient is currently attended")
		Me.txtAttendingHospital.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.txtAttendingHospital.AcceptsReturn = True
		Me.txtAttendingHospital.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me.txtAttendingHospital.BackColor = System.Drawing.SystemColors.Window
		Me.txtAttendingHospital.CausesValidation = True
		Me.txtAttendingHospital.Enabled = True
		Me.txtAttendingHospital.ForeColor = System.Drawing.SystemColors.WindowText
		Me.txtAttendingHospital.HideSelection = True
		Me.txtAttendingHospital.ReadOnly = False
		Me.txtAttendingHospital.Cursor = System.Windows.Forms.Cursors.IBeam
		Me.txtAttendingHospital.MultiLine = False
		Me.txtAttendingHospital.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.txtAttendingHospital.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me.txtAttendingHospital.TabStop = True
		Me.txtAttendingHospital.Visible = True
		Me.txtAttendingHospital.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.txtAttendingHospital.Name = "txtAttendingHospital"
		Me.lblAdditionalComments.Text = "Additional Comments"
		Me.lblAdditionalComments.Size = New System.Drawing.Size(57, 31)
		Me.lblAdditionalComments.Location = New System.Drawing.Point(80, 184)
		Me.lblAdditionalComments.TabIndex = 62
		Me.ToolTip1.SetToolTip(Me.lblAdditionalComments, "Additional Comments")
		Me.lblAdditionalComments.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblAdditionalComments.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me.lblAdditionalComments.BackColor = System.Drawing.SystemColors.Control
		Me.lblAdditionalComments.Enabled = True
		Me.lblAdditionalComments.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblAdditionalComments.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblAdditionalComments.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblAdditionalComments.UseMnemonic = True
		Me.lblAdditionalComments.Visible = True
		Me.lblAdditionalComments.AutoSize = False
		Me.lblAdditionalComments.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblAdditionalComments.Name = "lblAdditionalComments"
		Me.lblFamilyKnowsStatus.Text = "Family Knows HIV Status"
		Me.lblFamilyKnowsStatus.Size = New System.Drawing.Size(121, 15)
		Me.lblFamilyKnowsStatus.Location = New System.Drawing.Point(8, 142)
		Me.lblFamilyKnowsStatus.TabIndex = 61
		Me.ToolTip1.SetToolTip(Me.lblFamilyKnowsStatus, "Does family know of HIV status?")
		Me.lblFamilyKnowsStatus.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblFamilyKnowsStatus.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me.lblFamilyKnowsStatus.BackColor = System.Drawing.SystemColors.Control
		Me.lblFamilyKnowsStatus.Enabled = True
		Me.lblFamilyKnowsStatus.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblFamilyKnowsStatus.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblFamilyKnowsStatus.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblFamilyKnowsStatus.UseMnemonic = True
		Me.lblFamilyKnowsStatus.Visible = True
		Me.lblFamilyKnowsStatus.AutoSize = False
		Me.lblFamilyKnowsStatus.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblFamilyKnowsStatus.Name = "lblFamilyKnowsStatus"
		Me.lblFamilyAtHospital.Text = "Family At Hospital"
		Me.lblFamilyAtHospital.Size = New System.Drawing.Size(89, 15)
		Me.lblFamilyAtHospital.Location = New System.Drawing.Point(48, 117)
		Me.lblFamilyAtHospital.TabIndex = 60
		Me.ToolTip1.SetToolTip(Me.lblFamilyAtHospital, "Family currently at hospital?")
		Me.lblFamilyAtHospital.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblFamilyAtHospital.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me.lblFamilyAtHospital.BackColor = System.Drawing.SystemColors.Control
		Me.lblFamilyAtHospital.Enabled = True
		Me.lblFamilyAtHospital.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblFamilyAtHospital.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblFamilyAtHospital.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblFamilyAtHospital.UseMnemonic = True
		Me.lblFamilyAtHospital.Visible = True
		Me.lblFamilyAtHospital.AutoSize = False
		Me.lblFamilyAtHospital.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblFamilyAtHospital.Name = "lblFamilyAtHospital"
		Me.lblFuneralHome.Text = "Funeral Home"
		Me.lblFuneralHome.Size = New System.Drawing.Size(73, 17)
		Me.lblFuneralHome.Location = New System.Drawing.Point(64, 160)
		Me.lblFuneralHome.TabIndex = 59
		Me.ToolTip1.SetToolTip(Me.lblFuneralHome, "Funeral Home (if known)")
		Me.lblFuneralHome.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblFuneralHome.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me.lblFuneralHome.BackColor = System.Drawing.SystemColors.Control
		Me.lblFuneralHome.Enabled = True
		Me.lblFuneralHome.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblFuneralHome.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblFuneralHome.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblFuneralHome.UseMnemonic = True
		Me.lblFuneralHome.Visible = True
		Me.lblFuneralHome.AutoSize = False
		Me.lblFuneralHome.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblFuneralHome.Name = "lblFuneralHome"
		Me.lblAttendingPhysicianPhone.Text = "Attending Phone"
		Me.lblAttendingPhysicianPhone.Size = New System.Drawing.Size(81, 17)
		Me.lblAttendingPhysicianPhone.Location = New System.Drawing.Point(48, 90)
		Me.lblAttendingPhysicianPhone.TabIndex = 58
		Me.ToolTip1.SetToolTip(Me.lblAttendingPhysicianPhone, "Attending Physician Phone")
		Me.lblAttendingPhysicianPhone.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblAttendingPhysicianPhone.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me.lblAttendingPhysicianPhone.BackColor = System.Drawing.SystemColors.Control
		Me.lblAttendingPhysicianPhone.Enabled = True
		Me.lblAttendingPhysicianPhone.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblAttendingPhysicianPhone.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblAttendingPhysicianPhone.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblAttendingPhysicianPhone.UseMnemonic = True
		Me.lblAttendingPhysicianPhone.Visible = True
		Me.lblAttendingPhysicianPhone.AutoSize = False
		Me.lblAttendingPhysicianPhone.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblAttendingPhysicianPhone.Name = "lblAttendingPhysicianPhone"
		Me.lblAttendingPhysician.Text = "Attending Physician"
		Me.lblAttendingPhysician.Size = New System.Drawing.Size(97, 17)
		Me.lblAttendingPhysician.Location = New System.Drawing.Point(35, 67)
		Me.lblAttendingPhysician.TabIndex = 57
		Me.ToolTip1.SetToolTip(Me.lblAttendingPhysician, "Attending Physician")
		Me.lblAttendingPhysician.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblAttendingPhysician.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me.lblAttendingPhysician.BackColor = System.Drawing.SystemColors.Control
		Me.lblAttendingPhysician.Enabled = True
		Me.lblAttendingPhysician.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblAttendingPhysician.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblAttendingPhysician.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblAttendingPhysician.UseMnemonic = True
		Me.lblAttendingPhysician.Visible = True
		Me.lblAttendingPhysician.AutoSize = False
		Me.lblAttendingPhysician.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblAttendingPhysician.Name = "lblAttendingPhysician"
		Me.lblAttendingNurse.Text = "Nurse"
		Me.lblAttendingNurse.Size = New System.Drawing.Size(33, 17)
		Me.lblAttendingNurse.Location = New System.Drawing.Point(96, 43)
		Me.lblAttendingNurse.TabIndex = 56
		Me.ToolTip1.SetToolTip(Me.lblAttendingNurse, "Nurse currently attending")
		Me.lblAttendingNurse.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblAttendingNurse.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me.lblAttendingNurse.BackColor = System.Drawing.SystemColors.Control
		Me.lblAttendingNurse.Enabled = True
		Me.lblAttendingNurse.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblAttendingNurse.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblAttendingNurse.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblAttendingNurse.UseMnemonic = True
		Me.lblAttendingNurse.Visible = True
		Me.lblAttendingNurse.AutoSize = False
		Me.lblAttendingNurse.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblAttendingNurse.Name = "lblAttendingNurse"
		Me.lblAttendingHospital.Text = "Hospital"
		Me.lblAttendingHospital.Size = New System.Drawing.Size(41, 17)
		Me.lblAttendingHospital.Location = New System.Drawing.Point(88, 19)
		Me.lblAttendingHospital.TabIndex = 55
		Me.ToolTip1.SetToolTip(Me.lblAttendingHospital, "Hospital where patient is currently attended")
		Me.lblAttendingHospital.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblAttendingHospital.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me.lblAttendingHospital.BackColor = System.Drawing.SystemColors.Control
		Me.lblAttendingHospital.Enabled = True
		Me.lblAttendingHospital.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblAttendingHospital.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblAttendingHospital.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblAttendingHospital.UseMnemonic = True
		Me.lblAttendingHospital.Visible = True
		Me.lblAttendingHospital.AutoSize = False
		Me.lblAttendingHospital.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblAttendingHospital.Name = "lblAttendingHospital"
		Me.Controls.Add(CmdCancel)
		Me.Controls.Add(CmdOK)
		Me.Controls.Add(tabNDRI)
		Me.tabNDRI.Controls.Add(_tabNDRI_TabPage0)
		Me.tabNDRI.Controls.Add(_tabNDRI_TabPage1)
		Me.tabNDRI.Controls.Add(_tabNDRI_TabPage2)
		Me._tabNDRI_TabPage0.Controls.Add(FraGeneral)
		Me.FraGeneral.Controls.Add(txtTOD)
		Me.FraGeneral.Controls.Add(txtCallTime)
		Me.FraGeneral.Controls.Add(cboRace)
		Me.FraGeneral.Controls.Add(txtCoordName)
		Me.FraGeneral.Controls.Add(cboGender)
		Me.FraGeneral.Controls.Add(txtOtherDiseases)
		Me.FraGeneral.Controls.Add(txtViralLoad)
		Me.FraGeneral.Controls.Add(txtCD4)
		Me.FraGeneral.Controls.Add(txtDOD)
		Me.FraGeneral.Controls.Add(cboCOD_S)
		Me.FraGeneral.Controls.Add(cboABO_Rh)
		Me.FraGeneral.Controls.Add(cboAgeUnit)
		Me.FraGeneral.Controls.Add(txtAge)
		Me.FraGeneral.Controls.Add(txtSource)
		Me.FraGeneral.Controls.Add(TxtSourcePhone)
		Me.FraGeneral.Controls.Add(TxtDonorNumber)
		Me.FraGeneral.Controls.Add(TxtCallDate)
		Me.FraGeneral.Controls.Add(LblCallTime)
		Me.FraGeneral.Controls.Add(_LblDOD_1)
		Me.FraGeneral.Controls.Add(lblRace)
		Me.FraGeneral.Controls.Add(lblOtherKnownDiseases)
		Me.FraGeneral.Controls.Add(lblVL)
		Me.FraGeneral.Controls.Add(lblCD4)
		Me.FraGeneral.Controls.Add(_LblDOD_0)
		Me.FraGeneral.Controls.Add(lblCOD_S)
		Me.FraGeneral.Controls.Add(lblABO_Rh)
		Me.FraGeneral.Controls.Add(lblSex)
		Me.FraGeneral.Controls.Add(lblAge)
		Me.FraGeneral.Controls.Add(lblSource)
		Me.FraGeneral.Controls.Add(LblSourcePhone)
		Me.FraGeneral.Controls.Add(LblCoordName)
		Me.FraGeneral.Controls.Add(LblDonorNumber)
		Me.FraGeneral.Controls.Add(LblCallDate)
		Me._tabNDRI_TabPage1.Controls.Add(FraMedical)
		Me.FraMedical.Controls.Add(txtMedHxOther)
		Me.FraMedical.Controls.Add(cboSubstanceAbuse)
		Me.FraMedical.Controls.Add(cboRadiation)
		Me.FraMedical.Controls.Add(cboChemotherapy)
		Me.FraMedical.Controls.Add(cboSepsis)
		Me.FraMedical.Controls.Add(ctlNDRIMedications)
		Me.FraMedical.Controls.Add(lblInfo)
		Me.FraMedical.Controls.Add(lblMedHxOther)
		Me.FraMedical.Controls.Add(lblSubstanceAbuse)
		Me.FraMedical.Controls.Add(lblRadiation)
		Me.FraMedical.Controls.Add(lblChemotherapy)
		Me.FraMedical.Controls.Add(lblSepsis)
		Me._tabNDRI_TabPage2.Controls.Add(FraOther)
		Me.FraOther.Controls.Add(txtAdditionalComments)
		Me.FraOther.Controls.Add(cboFamilyKnowsStatus)
		Me.FraOther.Controls.Add(cboFamilyAtHospital)
		Me.FraOther.Controls.Add(txtFuneralHome)
		Me.FraOther.Controls.Add(txtAttendingPhone)
		Me.FraOther.Controls.Add(txtAttendingPhysician)
		Me.FraOther.Controls.Add(txtAttendingNurse)
		Me.FraOther.Controls.Add(txtAttendingHospital)
		Me.FraOther.Controls.Add(lblAdditionalComments)
		Me.FraOther.Controls.Add(lblFamilyKnowsStatus)
		Me.FraOther.Controls.Add(lblFamilyAtHospital)
		Me.FraOther.Controls.Add(lblFuneralHome)
		Me.FraOther.Controls.Add(lblAttendingPhysicianPhone)
		Me.FraOther.Controls.Add(lblAttendingPhysician)
		Me.FraOther.Controls.Add(lblAttendingNurse)
		Me.FraOther.Controls.Add(lblAttendingHospital)
		Me.LblDOD.SetIndex(_LblDOD_1, CType(1, Short))
		Me.LblDOD.SetIndex(_LblDOD_0, CType(0, Short))
		CType(Me.LblDOD, System.ComponentModel.ISupportInitialize).EndInit()
		Me.tabNDRI.ResumeLayout(False)
		Me._tabNDRI_TabPage0.ResumeLayout(False)
		Me.FraGeneral.ResumeLayout(False)
		Me._tabNDRI_TabPage1.ResumeLayout(False)
		Me.FraMedical.ResumeLayout(False)
		Me._tabNDRI_TabPage2.ResumeLayout(False)
		Me.FraOther.ResumeLayout(False)
		Me.ResumeLayout(False)
		Me.PerformLayout()
	End Sub
#End Region 
End Class