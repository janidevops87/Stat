<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmServiceLevel
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
	Public WithEvents cmdTest As System.Windows.Forms.Button
	Public WithEvents CmdServiceLevelGroupDetail As System.Windows.Forms.Button
	Public WithEvents CboServiceLevelGroup As System.Windows.Forms.ComboBox
	Public WithEvents _Lable_1 As System.Windows.Forms.Label
	Public WithEvents _Frame_3 As System.Windows.Forms.GroupBox
	Public WithEvents _OptOTEHistory_0 As System.Windows.Forms.RadioButton
	Public WithEvents _OptOTEHistory_1 As System.Windows.Forms.RadioButton
	Public WithEvents _OptOTEHistory_2 As System.Windows.Forms.RadioButton
	Public WithEvents _Picture_7 As System.Windows.Forms.Panel
	Public WithEvents _OptTEHistory_2 As System.Windows.Forms.RadioButton
	Public WithEvents _OptTEHistory_1 As System.Windows.Forms.RadioButton
	Public WithEvents _OptTEHistory_0 As System.Windows.Forms.RadioButton
	Public WithEvents _Picture_6 As System.Windows.Forms.Panel
	Public WithEvents _OptEHistory_2 As System.Windows.Forms.RadioButton
	Public WithEvents _OptEHistory_1 As System.Windows.Forms.RadioButton
	Public WithEvents _OptEHistory_0 As System.Windows.Forms.RadioButton
	Public WithEvents _Picture_5 As System.Windows.Forms.Panel
	Public WithEvents CboTriageLevel As System.Windows.Forms.ComboBox
	Public WithEvents _LabelPrompt_7 As System.Windows.Forms.Label
	Public WithEvents _LabelPrompt_6 As System.Windows.Forms.Label
	Public WithEvents _LabelPrompt_5 As System.Windows.Forms.Label
	Public WithEvents _Label_0 As System.Windows.Forms.Label
	Public WithEvents _Frame_1 As System.Windows.Forms.GroupBox
	Public WithEvents ChkDOBILB As System.Windows.Forms.CheckBox
	Public WithEvents ChkSpecificCOD As System.Windows.Forms.CheckBox
	Public WithEvents ChkAdmitTime As System.Windows.Forms.CheckBox
	Public WithEvents TxtWeightAgeLimit As System.Windows.Forms.TextBox
	Public WithEvents ChkDeathDate As System.Windows.Forms.CheckBox
	Public WithEvents ChkSSN As System.Windows.Forms.CheckBox
	Public WithEvents ChkMI As System.Windows.Forms.CheckBox
	Public WithEvents ChkBrainDeathDate As System.Windows.Forms.CheckBox
	Public WithEvents ChkBrainDeathTime As System.Windows.Forms.CheckBox
	Public WithEvents ChkHeartBeat As System.Windows.Forms.CheckBox
	Public WithEvents ChkExcludePrevVent As System.Windows.Forms.CheckBox
	Public WithEvents ChkDOB As System.Windows.Forms.CheckBox
	Public WithEvents ChkDOA As System.Windows.Forms.CheckBox
	Public WithEvents _OptPrevVent_0 As System.Windows.Forms.RadioButton
	Public WithEvents _OptPrevVent_1 As System.Windows.Forms.RadioButton
	Public WithEvents ChkCOD As System.Windows.Forms.CheckBox
	Public WithEvents ChkAdmitDate As System.Windows.Forms.CheckBox
	Public WithEvents ChkDeathTime As System.Windows.Forms.CheckBox
	Public WithEvents ChkVent As System.Windows.Forms.CheckBox
	Public WithEvents ChkRace As System.Windows.Forms.CheckBox
	Public WithEvents ChkWeight As System.Windows.Forms.CheckBox
	Public WithEvents ChkAge As System.Windows.Forms.CheckBox
	Public WithEvents ChkGender As System.Windows.Forms.CheckBox
	Public WithEvents ChkRecNum As System.Windows.Forms.CheckBox
	Public WithEvents ChkFirstName As System.Windows.Forms.CheckBox
	Public WithEvents ChkLastName As System.Windows.Forms.CheckBox
	Public WithEvents LblWeightAgeLimit As System.Windows.Forms.Label
	Public WithEvents _Frame_0 As System.Windows.Forms.GroupBox
	Public WithEvents RadioDisplayMultiple As System.Windows.Forms.RadioButton
	Public WithEvents RadioDisplaySearch As System.Windows.Forms.RadioButton
	Public WithEvents RegistryData As System.Windows.Forms.GroupBox
	Public WithEvents chkDisableSave As System.Windows.Forms.CheckBox
	Public WithEvents ChkAttendingPhone As System.Windows.Forms.CheckBox
	Public WithEvents ChkAttending As System.Windows.Forms.CheckBox
	Public WithEvents ChkPronouncingPhone As System.Windows.Forms.CheckBox
	Public WithEvents chkEmailDisposition As System.Windows.Forms.CheckBox
	Public WithEvents _OptPronouncing_0 As System.Windows.Forms.RadioButton
	Public WithEvents _OptPronouncing_1 As System.Windows.Forms.RadioButton
    Public WithEvents _OptAttending_1 As System.Windows.Forms.RadioButton
	Public WithEvents _OptAttending_0 As System.Windows.Forms.RadioButton
    Public WithEvents ChkPronouncing As System.Windows.Forms.CheckBox
	Public WithEvents ChkPhysicianInfo As System.Windows.Forms.CheckBox
	Public WithEvents ChkCoronerInfo As System.Windows.Forms.CheckBox
	Public WithEvents _Frame_5 As System.Windows.Forms.GroupBox
	Public WithEvents ChkNOKRegistered As System.Windows.Forms.CheckBox
	Public WithEvents ChkNOKConsent As System.Windows.Forms.CheckBox
	Public WithEvents NOK As System.Windows.Forms.GroupBox
	Public WithEvents _OptROPrompt_0 As System.Windows.Forms.RadioButton
	Public WithEvents _OptROPrompt_1 As System.Windows.Forms.RadioButton
	Public WithEvents _Picture_3 As System.Windows.Forms.Panel
	Public WithEvents _OptEPrompt_0 As System.Windows.Forms.RadioButton
	Public WithEvents _OptEPrompt_1 As System.Windows.Forms.RadioButton
	Public WithEvents _Picture_2 As System.Windows.Forms.Panel
	Public WithEvents _OptTEPrompt_0 As System.Windows.Forms.RadioButton
	Public WithEvents _OptTEPrompt_1 As System.Windows.Forms.RadioButton
	Public WithEvents _Picture_1 As System.Windows.Forms.Panel
	Public WithEvents _OptOTEPrompt_1 As System.Windows.Forms.RadioButton
	Public WithEvents _OptOTEPrompt_0 As System.Windows.Forms.RadioButton
	Public WithEvents _Picture_0 As System.Windows.Forms.Panel
	Public WithEvents _LabelPrompt_3 As System.Windows.Forms.Label
	Public WithEvents _LabelPrompt_2 As System.Windows.Forms.Label
	Public WithEvents _LabelPrompt_1 As System.Windows.Forms.Label
	Public WithEvents _LabelPrompt_0 As System.Windows.Forms.Label
	Public WithEvents _Frame_11 As System.Windows.Forms.GroupBox
	Public WithEvents ChkNOKAddress As System.Windows.Forms.CheckBox
	Public WithEvents ChkNOKPhone As System.Windows.Forms.CheckBox
	Public WithEvents ChkNOKRelation As System.Windows.Forms.CheckBox
	Public WithEvents ChkNOKName As System.Windows.Forms.CheckBox
	Public WithEvents ChkApproachBy As System.Windows.Forms.CheckBox
	Public WithEvents ChkApproachMethod As System.Windows.Forms.CheckBox
	Public WithEvents _Frame_7 As System.Windows.Forms.GroupBox
	Public WithEvents ChkConsentEyes As System.Windows.Forms.CheckBox
	Public WithEvents ChkConsentValves As System.Windows.Forms.CheckBox
	Public WithEvents ChkConsentSkin As System.Windows.Forms.CheckBox
	Public WithEvents ChkConsentTissue As System.Windows.Forms.CheckBox
	Public WithEvents ChkConsentBone As System.Windows.Forms.CheckBox
	Public WithEvents ChkConsentOrgan As System.Windows.Forms.CheckBox
	Public WithEvents ChkConsentResearch As System.Windows.Forms.CheckBox
	Public WithEvents _Frame_8 As System.Windows.Forms.GroupBox
	Public WithEvents ChkRecoveryEyes As System.Windows.Forms.CheckBox
	Public WithEvents ChkRecoveryValves As System.Windows.Forms.CheckBox
	Public WithEvents ChkRecoverySkin As System.Windows.Forms.CheckBox
	Public WithEvents ChkRecoveryTissue As System.Windows.Forms.CheckBox
	Public WithEvents ChkRecoveryBone As System.Windows.Forms.CheckBox
	Public WithEvents ChkRecoveryOrgan As System.Windows.Forms.CheckBox
	Public WithEvents ChkRecoveryResearch As System.Windows.Forms.CheckBox
	Public WithEvents _Frame_9 As System.Windows.Forms.GroupBox
	Public WithEvents ChkAppropriateResearch As System.Windows.Forms.CheckBox
	Public WithEvents ChkAppropriateOrgan As System.Windows.Forms.CheckBox
	Public WithEvents ChkAppropriateBone As System.Windows.Forms.CheckBox
	Public WithEvents ChkAppropriateTissue As System.Windows.Forms.CheckBox
	Public WithEvents ChkAppropriateSkin As System.Windows.Forms.CheckBox
	Public WithEvents ChkAppropriateValves As System.Windows.Forms.CheckBox
	Public WithEvents ChkAppropriateEyes As System.Windows.Forms.CheckBox
	Public WithEvents _Frame_4 As System.Windows.Forms.GroupBox
	Public WithEvents ChkApproachResearch As System.Windows.Forms.CheckBox
	Public WithEvents ChkApproachOrgan As System.Windows.Forms.CheckBox
	Public WithEvents ChkApproachBone As System.Windows.Forms.CheckBox
	Public WithEvents ChkApproachTissue As System.Windows.Forms.CheckBox
	Public WithEvents ChkApproachSkin As System.Windows.Forms.CheckBox
	Public WithEvents ChkApproachValves As System.Windows.Forms.CheckBox
	Public WithEvents ChkApproachEyes As System.Windows.Forms.CheckBox
	Public WithEvents _Frame_10 As System.Windows.Forms.GroupBox
	Public WithEvents _DD_2 As System.Windows.Forms.RadioButton
	Public WithEvents _DD_1 As System.Windows.Forms.RadioButton
	Public WithEvents _DD_0 As System.Windows.Forms.RadioButton
	Public WithEvents Disposition As System.Windows.Forms.GroupBox
	Public WithEvents chkVerifySex As System.Windows.Forms.CheckBox
	Public WithEvents chkVerifyWeight As System.Windows.Forms.CheckBox
	Public WithEvents Frame5 As System.Windows.Forms.GroupBox
	Public WithEvents _TabServiceLevel_TabPage0 As System.Windows.Forms.TabPage
	Public WithEvents CboState As System.Windows.Forms.ComboBox
	Public WithEvents CmdFind As System.Windows.Forms.Button
	Public WithEvents CboOrganizationType As System.Windows.Forms.ComboBox
	Public WithEvents CmdDeselect As System.Windows.Forms.Button
	Public WithEvents CmdSelect As System.Windows.Forms.Button
	Public WithEvents CmdUnassigned As System.Windows.Forms.Button
	Public WithEvents LstViewAvailableOrganizations As System.Windows.Forms.ListView
	Public WithEvents LstViewSelectedOrganizations As System.Windows.Forms.ListView
	Public WithEvents _Lable_2 As System.Windows.Forms.Label
	Public WithEvents _Lable_5 As System.Windows.Forms.Label
	Public WithEvents _Lable_3 As System.Windows.Forms.Label
	Public WithEvents _Lable_4 As System.Windows.Forms.Label
	Public WithEvents _Frame_2 As System.Windows.Forms.GroupBox
	Public WithEvents _TabServiceLevel_TabPage1 As System.Windows.Forms.TabPage
	Public WithEvents CmdRemove As System.Windows.Forms.Button
	Public WithEvents CmdAddSource As System.Windows.Forms.Button
	Public WithEvents LstViewSourceCodes As System.Windows.Forms.ListView
	Public WithEvents _Lable_8 As System.Windows.Forms.Label
	Public WithEvents _Lable_19 As System.Windows.Forms.Label
	Public WithEvents _Lable_20 As System.Windows.Forms.Label
	Public WithEvents _Frame_6 As System.Windows.Forms.GroupBox
	Public WithEvents _TabServiceLevel_TabPage2 As System.Windows.Forms.TabPage
	Public WithEvents ChkPrompt As System.Windows.Forms.CheckBox
	Public WithEvents _Frame_12 As System.Windows.Forms.GroupBox
	Public WithEvents _TxtLabel_8 As System.Windows.Forms.TextBox
	Public WithEvents _TxtLabel_7 As System.Windows.Forms.TextBox
	Public WithEvents _TxtLabel_6 As System.Windows.Forms.TextBox
	Public WithEvents _TxtLabel_5 As System.Windows.Forms.TextBox
	Public WithEvents _TxtLabel_4 As System.Windows.Forms.TextBox
	Public WithEvents _TxtLabel_3 As System.Windows.Forms.TextBox
	Public WithEvents _TxtLabel_2 As System.Windows.Forms.TextBox
	Public WithEvents _TxtLabel_1 As System.Windows.Forms.TextBox
	Public WithEvents _TxtAlert_0 As System.Windows.Forms.RichTextBox
	Public WithEvents _Label_18 As System.Windows.Forms.Label
	Public WithEvents _Label_17 As System.Windows.Forms.Label
	Public WithEvents _Label_16 As System.Windows.Forms.Label
	Public WithEvents _Label_15 As System.Windows.Forms.Label
	Public WithEvents _Label_14 As System.Windows.Forms.Label
	Public WithEvents _Label_13 As System.Windows.Forms.Label
	Public WithEvents _Label_12 As System.Windows.Forms.Label
	Public WithEvents _Label_10 As System.Windows.Forms.Label
	Public WithEvents _Label_9 As System.Windows.Forms.Label
	Public WithEvents _Label_8 As System.Windows.Forms.Label
	Public WithEvents _Label_7 As System.Windows.Forms.Label
	Public WithEvents _Label_6 As System.Windows.Forms.Label
	Public WithEvents _Label_5 As System.Windows.Forms.Label
	Public WithEvents _Label_4 As System.Windows.Forms.Label
	Public WithEvents _Label_3 As System.Windows.Forms.Label
	Public WithEvents _Label_11 As System.Windows.Forms.Label
	Public WithEvents _Label_2 As System.Windows.Forms.Label
	Public WithEvents _Frame_13 As System.Windows.Forms.GroupBox
	Public WithEvents _CmdDelete_16 As System.Windows.Forms.Button
	Public WithEvents _CmdDelete_15 As System.Windows.Forms.Button
	Public WithEvents _CmdDelete_14 As System.Windows.Forms.Button
	Public WithEvents _CmdDelete_13 As System.Windows.Forms.Button
	Public WithEvents _CmdDelete_12 As System.Windows.Forms.Button
	Public WithEvents _CmdDelete_11 As System.Windows.Forms.Button
	Public WithEvents _CmdDelete_10 As System.Windows.Forms.Button
	Public WithEvents _CmdDelete_9 As System.Windows.Forms.Button
	Public WithEvents _CboField_16 As System.Windows.Forms.ComboBox
	Public WithEvents _CmdAdd_16 As System.Windows.Forms.Button
	Public WithEvents _CboField_15 As System.Windows.Forms.ComboBox
	Public WithEvents _CmdAdd_15 As System.Windows.Forms.Button
	Public WithEvents _CboField_14 As System.Windows.Forms.ComboBox
	Public WithEvents _CmdAdd_14 As System.Windows.Forms.Button
	Public WithEvents _CboField_13 As System.Windows.Forms.ComboBox
	Public WithEvents _CmdAdd_13 As System.Windows.Forms.Button
	Public WithEvents _CboField_12 As System.Windows.Forms.ComboBox
	Public WithEvents _CmdAdd_12 As System.Windows.Forms.Button
	Public WithEvents _CboField_11 As System.Windows.Forms.ComboBox
	Public WithEvents _CmdAdd_11 As System.Windows.Forms.Button
	Public WithEvents _CboField_10 As System.Windows.Forms.ComboBox
	Public WithEvents _CmdAdd_10 As System.Windows.Forms.Button
	Public WithEvents _CboField_9 As System.Windows.Forms.ComboBox
	Public WithEvents _CmdAdd_9 As System.Windows.Forms.Button
	Public WithEvents _TxtLabel_16 As System.Windows.Forms.TextBox
	Public WithEvents _TxtLabel_15 As System.Windows.Forms.TextBox
	Public WithEvents _TxtLabel_14 As System.Windows.Forms.TextBox
	Public WithEvents _TxtLabel_13 As System.Windows.Forms.TextBox
	Public WithEvents _TxtLabel_12 As System.Windows.Forms.TextBox
	Public WithEvents _TxtLabel_11 As System.Windows.Forms.TextBox
	Public WithEvents _TxtLabel_10 As System.Windows.Forms.TextBox
	Public WithEvents _TxtLabel_9 As System.Windows.Forms.TextBox
	Public WithEvents _TxtAlert_1 As System.Windows.Forms.RichTextBox
	Public WithEvents _Label_27 As System.Windows.Forms.Label
	Public WithEvents _Label_26 As System.Windows.Forms.Label
	Public WithEvents _Label_25 As System.Windows.Forms.Label
	Public WithEvents _Label_24 As System.Windows.Forms.Label
	Public WithEvents _Label_23 As System.Windows.Forms.Label
	Public WithEvents _Label_22 As System.Windows.Forms.Label
	Public WithEvents _Label_21 As System.Windows.Forms.Label
	Public WithEvents _Label_20 As System.Windows.Forms.Label
	Public WithEvents _Label_19 As System.Windows.Forms.Label
	Public WithEvents _Frame_14 As System.Windows.Forms.GroupBox
	Public WithEvents _TabServiceLevel_TabPage3 As System.Windows.Forms.TabPage
	Public WithEvents Command14 As System.Windows.Forms.Button
	Public WithEvents Command13 As System.Windows.Forms.Button
	Public WithEvents Combo6 As System.Windows.Forms.ComboBox
	Public WithEvents Combo5 As System.Windows.Forms.ComboBox
	Public WithEvents _ChkSoftTissue_1 As System.Windows.Forms.CheckBox
	Public WithEvents _ChkEyes_1 As System.Windows.Forms.CheckBox
	Public WithEvents _ChkBone_1 As System.Windows.Forms.CheckBox
	Public WithEvents _ChkHeartValves_1 As System.Windows.Forms.CheckBox
	Public WithEvents _ChkSkin_1 As System.Windows.Forms.CheckBox
	Public WithEvents _ChkOrgans_4 As System.Windows.Forms.CheckBox
	Public WithEvents _ChkResearch_1 As System.Windows.Forms.CheckBox
	Public WithEvents _Frame_24 As System.Windows.Forms.GroupBox
	Public WithEvents Check10 As System.Windows.Forms.CheckBox
	Public WithEvents Check9 As System.Windows.Forms.CheckBox
	Public WithEvents Check8 As System.Windows.Forms.CheckBox
	Public WithEvents Check7 As System.Windows.Forms.CheckBox
	Public WithEvents Check6 As System.Windows.Forms.CheckBox
	Public WithEvents Check5 As System.Windows.Forms.CheckBox
	Public WithEvents Check4 As System.Windows.Forms.CheckBox
	Public WithEvents _Frame_23 As System.Windows.Forms.GroupBox
	Public WithEvents ListView7 As System.Windows.Forms.ListView
	Public WithEvents _Label_30 As System.Windows.Forms.Label
	Public WithEvents _Label_28 As System.Windows.Forms.Label
	Public WithEvents _Label_29 As System.Windows.Forms.Label
	Public WithEvents Label13 As System.Windows.Forms.Label
	Public WithEvents _Frame_22 As System.Windows.Forms.GroupBox
	Public WithEvents Command10 As System.Windows.Forms.Button
	Public WithEvents Command5 As System.Windows.Forms.Button
	Public WithEvents SubType As System.Windows.Forms.Button
	Public WithEvents VScroll1 As System.Windows.Forms.VScrollBar
	Public WithEvents Text2 As System.Windows.Forms.TextBox
	Public WithEvents Text9 As System.Windows.Forms.TextBox
	Public WithEvents Text8 As System.Windows.Forms.TextBox
	Public WithEvents Text7 As System.Windows.Forms.TextBox
	Public WithEvents Text6 As System.Windows.Forms.TextBox
	Public WithEvents Text5 As System.Windows.Forms.TextBox
	Public WithEvents Command6 As System.Windows.Forms.Button
	Public WithEvents _ChkOrgans_17 As System.Windows.Forms.CheckBox
	Public WithEvents Frame17 As System.Windows.Forms.GroupBox
	Public WithEvents _ChkOrgans_13 As System.Windows.Forms.CheckBox
	Public WithEvents Frame13 As System.Windows.Forms.GroupBox
	Public WithEvents _ChkOrgans_3 As System.Windows.Forms.CheckBox
	Public WithEvents Frame3 As System.Windows.Forms.GroupBox
	Public WithEvents _ChkOrgans_1 As System.Windows.Forms.CheckBox
	Public WithEvents Frame2 As System.Windows.Forms.GroupBox
	Public WithEvents _ChkOrgans_15 As System.Windows.Forms.CheckBox
	Public WithEvents Frame15 As System.Windows.Forms.GroupBox
	Public WithEvents _ChkOrgans_14 As System.Windows.Forms.CheckBox
	Public WithEvents Frame14 As System.Windows.Forms.GroupBox
	Public WithEvents _ChkOrgans_2 As System.Windows.Forms.CheckBox
	Public WithEvents Frame4 As System.Windows.Forms.GroupBox
	Public WithEvents Text3 As System.Windows.Forms.TextBox
	Public WithEvents Label4 As System.Windows.Forms.Label
	Public WithEvents Label5 As System.Windows.Forms.Label
	Public WithEvents Label10 As System.Windows.Forms.Label
	Public WithEvents Label9 As System.Windows.Forms.Label
	Public WithEvents Label8 As System.Windows.Forms.Label
	Public WithEvents Label7 As System.Windows.Forms.Label
	Public WithEvents Label3 As System.Windows.Forms.Label
	Public WithEvents _Frame_28 As System.Windows.Forms.GroupBox
	Public WithEvents Picture2 As System.Windows.Forms.Panel
	Public WithEvents Command4 As System.Windows.Forms.Button
	Public WithEvents ListView3 As System.Windows.Forms.ListView
	Public WithEvents Label2 As System.Windows.Forms.Label
	Public WithEvents _Lable_26 As System.Windows.Forms.Label
	Public WithEvents _Lable_27 As System.Windows.Forms.Label
	Public WithEvents _Frame_27 As System.Windows.Forms.GroupBox
	Public WithEvents Command2 As System.Windows.Forms.Button
	Public WithEvents Command3 As System.Windows.Forms.Button
	Public WithEvents Command1 As System.Windows.Forms.Button
	Public WithEvents ListView1 As System.Windows.Forms.ListView
	Public WithEvents ListView2 As System.Windows.Forms.ListView
	Public WithEvents Label11 As System.Windows.Forms.Label
	Public WithEvents _Lable_0 As System.Windows.Forms.Label
	Public WithEvents _Lable_23 As System.Windows.Forms.Label
	Public WithEvents _Frame_30 As System.Windows.Forms.GroupBox
	Public WithEvents Label12 As System.Windows.Forms.Label
	Public WithEvents Label6 As System.Windows.Forms.Label
	Public WithEvents txtEyeCareReminder As System.Windows.Forms.TextBox
	Public WithEvents lblEyCareReminder As System.Windows.Forms.Label
	Public WithEvents fmEyeCareReminder As System.Windows.Forms.GroupBox
    Public WithEvents TxtTBIPrefix As System.Windows.Forms.TextBox
	Public WithEvents ChkHemodilution As System.Windows.Forms.CheckBox
	Public WithEvents ChkSecondaryNote As System.Windows.Forms.CheckBox
	Public WithEvents TxtSecondaryAlert As System.Windows.Forms.RichTextBox
	Public WithEvents LblTBIPrefix As System.Windows.Forms.Label
	Public WithEvents _Label_43 As System.Windows.Forms.Label
	Public WithEvents _Frame_15 As System.Windows.Forms.GroupBox
	Public WithEvents ChkSecondary As System.Windows.Forms.CheckBox
	Public WithEvents _Frame_16 As System.Windows.Forms.GroupBox
	Public WithEvents _SSTab1_TabPage0 As System.Windows.Forms.TabPage
	Public WithEvents tvwTree As System.Windows.Forms.TreeView
	Public WithEvents cmdExpandAll As System.Windows.Forms.Button
	Public WithEvents chkRecurseChecks As System.Windows.Forms.CheckBox
	Public WithEvents _SSTab1_TabPage1 As System.Windows.Forms.TabPage
	Public WithEvents SSTab1 As System.Windows.Forms.TabControl
	Public WithEvents _Picture1_2 As System.Windows.Forms.Panel
	Public WithEvents _TabServiceLevel_TabPage4 As System.Windows.Forms.TabPage
	Public WithEvents _rbtnIntent_0 As System.Windows.Forms.RadioButton
	Public WithEvents _rbtnIntent_1 As System.Windows.Forms.RadioButton
	Public WithEvents _Frame_17 As System.Windows.Forms.GroupBox
	Public WithEvents txtDocumentName As System.Windows.Forms.TextBox
	Public WithEvents txtRetries As System.Windows.Forms.TextBox
	Public WithEvents cmbFaxNumber As System.Windows.Forms.ComboBox
	Public WithEvents cmbOrganization As System.Windows.Forms.ComboBox
	Public WithEvents cmbPerson As System.Windows.Forms.ComboBox
	Public WithEvents chkFax As System.Windows.Forms.CheckBox
	Public WithEvents lblDocumentName As System.Windows.Forms.Label
	Public WithEvents lblRetries As System.Windows.Forms.Label
	Public WithEvents lblFaxNumber As System.Windows.Forms.Label
	Public WithEvents lblOrganization As System.Windows.Forms.Label
	Public WithEvents lblPerson As System.Windows.Forms.Label
	Public WithEvents _Frame_19 As System.Windows.Forms.GroupBox
	Public WithEvents txtNurseScript As System.Windows.Forms.TextBox
	Public WithEvents _Lable_7 As System.Windows.Forms.Label
	Public WithEvents lblNurseScript As System.Windows.Forms.Label
	Public WithEvents _Frame_18 As System.Windows.Forms.GroupBox
	Public WithEvents chkCheckRegistry As System.Windows.Forms.CheckBox
	Public WithEvents Frame1 As System.Windows.Forms.GroupBox
	Public WithEvents cmdRemoveDSN As System.Windows.Forms.Button
	Public WithEvents cmdAddDSN As System.Windows.Forms.Button
	Public WithEvents LstViewAvailableDSN As System.Windows.Forms.ListView
	Public WithEvents LstViewSelectedDSN As System.Windows.Forms.ListView
	Public WithEvents lblNote As System.Windows.Forms.Label
	Public WithEvents lblAvailableDSN As System.Windows.Forms.Label
	Public WithEvents lblSelectedDSN As System.Windows.Forms.Label
	Public WithEvents fmDataSource As System.Windows.Forms.GroupBox
	Public WithEvents _TabServiceLevel_TabPage5 As System.Windows.Forms.TabPage
	Public WithEvents TabServiceLevel As System.Windows.Forms.TabControl
	Public WithEvents ImageList1 As System.Windows.Forms.ImageList
	Public WithEvents CboField As Microsoft.VisualBasic.Compatibility.VB6.ComboBoxArray
	Public WithEvents ChkBone As Microsoft.VisualBasic.Compatibility.VB6.CheckBoxArray
	Public WithEvents ChkEyes As Microsoft.VisualBasic.Compatibility.VB6.CheckBoxArray
	Public WithEvents ChkHeartValves As Microsoft.VisualBasic.Compatibility.VB6.CheckBoxArray
	Public WithEvents ChkOrgans As Microsoft.VisualBasic.Compatibility.VB6.CheckBoxArray
	Public WithEvents ChkResearch As Microsoft.VisualBasic.Compatibility.VB6.CheckBoxArray
	Public WithEvents ChkSkin As Microsoft.VisualBasic.Compatibility.VB6.CheckBoxArray
	Public WithEvents ChkSoftTissue As Microsoft.VisualBasic.Compatibility.VB6.CheckBoxArray
	Public WithEvents CmdAdd As Microsoft.VisualBasic.Compatibility.VB6.ButtonArray
	Public WithEvents CmdDelete As Microsoft.VisualBasic.Compatibility.VB6.ButtonArray
	Public WithEvents DD As Microsoft.VisualBasic.Compatibility.VB6.RadioButtonArray
	Public WithEvents Frame As Microsoft.VisualBasic.Compatibility.VB6.GroupBoxArray
	Public WithEvents Label As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
	Public WithEvents LabelPrompt As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
	Public WithEvents Lable As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
	Public WithEvents OptAttending As Microsoft.VisualBasic.Compatibility.VB6.RadioButtonArray
	Public WithEvents OptEHistory As Microsoft.VisualBasic.Compatibility.VB6.RadioButtonArray
	Public WithEvents OptEPrompt As Microsoft.VisualBasic.Compatibility.VB6.RadioButtonArray
	Public WithEvents OptOTEHistory As Microsoft.VisualBasic.Compatibility.VB6.RadioButtonArray
	Public WithEvents OptOTEPrompt As Microsoft.VisualBasic.Compatibility.VB6.RadioButtonArray
	Public WithEvents OptPrevVent As Microsoft.VisualBasic.Compatibility.VB6.RadioButtonArray
	Public WithEvents OptPronouncing As Microsoft.VisualBasic.Compatibility.VB6.RadioButtonArray
	Public WithEvents OptROPrompt As Microsoft.VisualBasic.Compatibility.VB6.RadioButtonArray
	Public WithEvents OptTEHistory As Microsoft.VisualBasic.Compatibility.VB6.RadioButtonArray
	Public WithEvents OptTEPrompt As Microsoft.VisualBasic.Compatibility.VB6.RadioButtonArray
	Public WithEvents Picture As Microsoft.VisualBasic.Compatibility.VB6.PanelArray
	Public WithEvents Picture1 As Microsoft.VisualBasic.Compatibility.VB6.PanelArray
	Public WithEvents TxtAlert As Microsoft.VisualBasic.Compatibility.VB6.RichTextBoxArray
	Public WithEvents TxtLabel As Microsoft.VisualBasic.Compatibility.VB6.TextBoxArray
	Public WithEvents rbtnIntent As Microsoft.VisualBasic.Compatibility.VB6.RadioButtonArray
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FrmServiceLevel))
        Dim TreeNode1 As System.Windows.Forms.TreeNode = New System.Windows.Forms.TreeNode("Node0")
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.CmdOK = New System.Windows.Forms.Button()
        Me.CmdCancel = New System.Windows.Forms.Button()
        Me._Frame_3 = New System.Windows.Forms.GroupBox()
        Me.cmdTest = New System.Windows.Forms.Button()
        Me.CmdServiceLevelGroupDetail = New System.Windows.Forms.Button()
        Me.CboServiceLevelGroup = New System.Windows.Forms.ComboBox()
        Me._Lable_1 = New System.Windows.Forms.Label()
        Me.TabServiceLevel = New System.Windows.Forms.TabControl()
        Me._TabServiceLevel_TabPage0 = New System.Windows.Forms.TabPage()
        Me._Frame_1 = New System.Windows.Forms.GroupBox()
        Me._Picture_7 = New System.Windows.Forms.Panel()
        Me._OptOTEHistory_0 = New System.Windows.Forms.RadioButton()
        Me._OptOTEHistory_1 = New System.Windows.Forms.RadioButton()
        Me._OptOTEHistory_2 = New System.Windows.Forms.RadioButton()
        Me._Picture_6 = New System.Windows.Forms.Panel()
        Me._OptTEHistory_2 = New System.Windows.Forms.RadioButton()
        Me._OptTEHistory_1 = New System.Windows.Forms.RadioButton()
        Me._OptTEHistory_0 = New System.Windows.Forms.RadioButton()
        Me._Picture_5 = New System.Windows.Forms.Panel()
        Me._OptEHistory_2 = New System.Windows.Forms.RadioButton()
        Me._OptEHistory_1 = New System.Windows.Forms.RadioButton()
        Me._OptEHistory_0 = New System.Windows.Forms.RadioButton()
        Me.CboTriageLevel = New System.Windows.Forms.ComboBox()
        Me._LabelPrompt_7 = New System.Windows.Forms.Label()
        Me._LabelPrompt_6 = New System.Windows.Forms.Label()
        Me._LabelPrompt_5 = New System.Windows.Forms.Label()
        Me._Label_0 = New System.Windows.Forms.Label()
        Me._Frame_0 = New System.Windows.Forms.GroupBox()
        Me.ChkDOBILB = New System.Windows.Forms.CheckBox()
        Me.ChkSpecificCOD = New System.Windows.Forms.CheckBox()
        Me.ChkAdmitTime = New System.Windows.Forms.CheckBox()
        Me.TxtWeightAgeLimit = New System.Windows.Forms.TextBox()
        Me.ChkDeathDate = New System.Windows.Forms.CheckBox()
        Me.ChkSSN = New System.Windows.Forms.CheckBox()
        Me.ChkMI = New System.Windows.Forms.CheckBox()
        Me.ChkBrainDeathDate = New System.Windows.Forms.CheckBox()
        Me.ChkBrainDeathTime = New System.Windows.Forms.CheckBox()
        Me.ChkHeartBeat = New System.Windows.Forms.CheckBox()
        Me.ChkExcludePrevVent = New System.Windows.Forms.CheckBox()
        Me.ChkDOB = New System.Windows.Forms.CheckBox()
        Me.ChkDOA = New System.Windows.Forms.CheckBox()
        Me._OptPrevVent_0 = New System.Windows.Forms.RadioButton()
        Me._OptPrevVent_1 = New System.Windows.Forms.RadioButton()
        Me.ChkCOD = New System.Windows.Forms.CheckBox()
        Me.ChkAdmitDate = New System.Windows.Forms.CheckBox()
        Me.ChkDeathTime = New System.Windows.Forms.CheckBox()
        Me.ChkVent = New System.Windows.Forms.CheckBox()
        Me.ChkRace = New System.Windows.Forms.CheckBox()
        Me.ChkWeight = New System.Windows.Forms.CheckBox()
        Me.ChkAge = New System.Windows.Forms.CheckBox()
        Me.ChkGender = New System.Windows.Forms.CheckBox()
        Me.ChkRecNum = New System.Windows.Forms.CheckBox()
        Me.ChkFirstName = New System.Windows.Forms.CheckBox()
        Me.ChkLastName = New System.Windows.Forms.CheckBox()
        Me.LblWeightAgeLimit = New System.Windows.Forms.Label()
        Me._Frame_5 = New System.Windows.Forms.GroupBox()
        Me.ChkDCDPotentialMessageEnabled = New System.Windows.Forms.CheckBox()
        Me.ChkPNEAllowSaveWithoutContactRequired = New System.Windows.Forms.CheckBox()
        Me._OptAttending_0 = New System.Windows.Forms.RadioButton()
        Me.ChkPronouncingPhone = New System.Windows.Forms.CheckBox()
        Me.RegistryData = New System.Windows.Forms.GroupBox()
        Me.RadioDisplayMultiple = New System.Windows.Forms.RadioButton()
        Me.RadioDisplaySearch = New System.Windows.Forms.RadioButton()
        Me._OptAttending_1 = New System.Windows.Forms.RadioButton()
        Me.chkDisableSave = New System.Windows.Forms.CheckBox()
        Me.ChkAttendingPhone = New System.Windows.Forms.CheckBox()
        Me.ChkAttending = New System.Windows.Forms.CheckBox()
        Me.chkEmailDisposition = New System.Windows.Forms.CheckBox()
        Me.ChkPronouncing = New System.Windows.Forms.CheckBox()
        Me.ChkPhysicianInfo = New System.Windows.Forms.CheckBox()
        Me.ChkCoronerInfo = New System.Windows.Forms.CheckBox()
        Me.PronouncingData = New System.Windows.Forms.GroupBox()
        Me._OptPronouncing_0 = New System.Windows.Forms.RadioButton()
        Me._OptPronouncing_1 = New System.Windows.Forms.RadioButton()
        Me._Frame_7 = New System.Windows.Forms.GroupBox()
        Me.NOK = New System.Windows.Forms.GroupBox()
        Me.ChkNOKRegistered = New System.Windows.Forms.CheckBox()
        Me.ChkNOKConsent = New System.Windows.Forms.CheckBox()
        Me._Frame_11 = New System.Windows.Forms.GroupBox()
        Me._Picture_3 = New System.Windows.Forms.Panel()
        Me._OptROPrompt_0 = New System.Windows.Forms.RadioButton()
        Me._OptROPrompt_1 = New System.Windows.Forms.RadioButton()
        Me._Picture_2 = New System.Windows.Forms.Panel()
        Me._OptEPrompt_0 = New System.Windows.Forms.RadioButton()
        Me._OptEPrompt_1 = New System.Windows.Forms.RadioButton()
        Me._Picture_1 = New System.Windows.Forms.Panel()
        Me._OptTEPrompt_0 = New System.Windows.Forms.RadioButton()
        Me._OptTEPrompt_1 = New System.Windows.Forms.RadioButton()
        Me._Picture_0 = New System.Windows.Forms.Panel()
        Me._OptOTEPrompt_1 = New System.Windows.Forms.RadioButton()
        Me._OptOTEPrompt_0 = New System.Windows.Forms.RadioButton()
        Me._LabelPrompt_3 = New System.Windows.Forms.Label()
        Me._LabelPrompt_2 = New System.Windows.Forms.Label()
        Me._LabelPrompt_1 = New System.Windows.Forms.Label()
        Me._LabelPrompt_0 = New System.Windows.Forms.Label()
        Me.ChkNOKAddress = New System.Windows.Forms.CheckBox()
        Me.ChkNOKPhone = New System.Windows.Forms.CheckBox()
        Me.ChkNOKRelation = New System.Windows.Forms.CheckBox()
        Me.ChkNOKName = New System.Windows.Forms.CheckBox()
        Me.ChkApproachBy = New System.Windows.Forms.CheckBox()
        Me.ChkApproachMethod = New System.Windows.Forms.CheckBox()
        Me._Frame_8 = New System.Windows.Forms.GroupBox()
        Me.ChkConsentEyes = New System.Windows.Forms.CheckBox()
        Me.ChkConsentValves = New System.Windows.Forms.CheckBox()
        Me.ChkConsentSkin = New System.Windows.Forms.CheckBox()
        Me.ChkConsentTissue = New System.Windows.Forms.CheckBox()
        Me.ChkConsentBone = New System.Windows.Forms.CheckBox()
        Me.ChkConsentOrgan = New System.Windows.Forms.CheckBox()
        Me.ChkConsentResearch = New System.Windows.Forms.CheckBox()
        Me._Frame_9 = New System.Windows.Forms.GroupBox()
        Me.ChkRecoveryEyes = New System.Windows.Forms.CheckBox()
        Me.ChkRecoveryValves = New System.Windows.Forms.CheckBox()
        Me.ChkRecoverySkin = New System.Windows.Forms.CheckBox()
        Me.ChkRecoveryTissue = New System.Windows.Forms.CheckBox()
        Me.ChkRecoveryBone = New System.Windows.Forms.CheckBox()
        Me.ChkRecoveryOrgan = New System.Windows.Forms.CheckBox()
        Me.ChkRecoveryResearch = New System.Windows.Forms.CheckBox()
        Me._Frame_4 = New System.Windows.Forms.GroupBox()
        Me.ChkAppropriateResearch = New System.Windows.Forms.CheckBox()
        Me.ChkAppropriateOrgan = New System.Windows.Forms.CheckBox()
        Me.ChkAppropriateBone = New System.Windows.Forms.CheckBox()
        Me.ChkAppropriateTissue = New System.Windows.Forms.CheckBox()
        Me.ChkAppropriateSkin = New System.Windows.Forms.CheckBox()
        Me.ChkAppropriateValves = New System.Windows.Forms.CheckBox()
        Me.ChkAppropriateEyes = New System.Windows.Forms.CheckBox()
        Me._Frame_10 = New System.Windows.Forms.GroupBox()
        Me.ChkApproachResearch = New System.Windows.Forms.CheckBox()
        Me.ChkApproachOrgan = New System.Windows.Forms.CheckBox()
        Me.ChkApproachBone = New System.Windows.Forms.CheckBox()
        Me.ChkApproachTissue = New System.Windows.Forms.CheckBox()
        Me.ChkApproachSkin = New System.Windows.Forms.CheckBox()
        Me.ChkApproachValves = New System.Windows.Forms.CheckBox()
        Me.ChkApproachEyes = New System.Windows.Forms.CheckBox()
        Me.Disposition = New System.Windows.Forms.GroupBox()
        Me._DD_2 = New System.Windows.Forms.RadioButton()
        Me._DD_1 = New System.Windows.Forms.RadioButton()
        Me._DD_0 = New System.Windows.Forms.RadioButton()
        Me.Frame5 = New System.Windows.Forms.GroupBox()
        Me.chkVerifySex = New System.Windows.Forms.CheckBox()
        Me.chkVerifyWeight = New System.Windows.Forms.CheckBox()
        Me._TabServiceLevel_TabPage1 = New System.Windows.Forms.TabPage()
        Me._Frame_2 = New System.Windows.Forms.GroupBox()
        Me.CboState = New System.Windows.Forms.ComboBox()
        Me.CmdFind = New System.Windows.Forms.Button()
        Me.CboOrganizationType = New System.Windows.Forms.ComboBox()
        Me.CmdDeselect = New System.Windows.Forms.Button()
        Me.CmdSelect = New System.Windows.Forms.Button()
        Me.CmdUnassigned = New System.Windows.Forms.Button()
        Me.LstViewAvailableOrganizations = New System.Windows.Forms.ListView()
        Me.LstViewSelectedOrganizations = New System.Windows.Forms.ListView()
        Me._Lable_2 = New System.Windows.Forms.Label()
        Me._Lable_5 = New System.Windows.Forms.Label()
        Me._Lable_3 = New System.Windows.Forms.Label()
        Me._Lable_4 = New System.Windows.Forms.Label()
        Me._TabServiceLevel_TabPage2 = New System.Windows.Forms.TabPage()
        Me._Frame_6 = New System.Windows.Forms.GroupBox()
        Me.CmdRemove = New System.Windows.Forms.Button()
        Me.CmdAddSource = New System.Windows.Forms.Button()
        Me.LstViewSourceCodes = New System.Windows.Forms.ListView()
        Me._Lable_8 = New System.Windows.Forms.Label()
        Me._Lable_19 = New System.Windows.Forms.Label()
        Me._Lable_20 = New System.Windows.Forms.Label()
        Me._TabServiceLevel_TabPage3 = New System.Windows.Forms.TabPage()
        Me._Frame_12 = New System.Windows.Forms.GroupBox()
        Me.ChkPrompt = New System.Windows.Forms.CheckBox()
        Me._Frame_13 = New System.Windows.Forms.GroupBox()
        Me._TxtLabel_8 = New System.Windows.Forms.TextBox()
        Me._TxtLabel_7 = New System.Windows.Forms.TextBox()
        Me._TxtLabel_6 = New System.Windows.Forms.TextBox()
        Me._TxtLabel_5 = New System.Windows.Forms.TextBox()
        Me._TxtLabel_4 = New System.Windows.Forms.TextBox()
        Me._TxtLabel_3 = New System.Windows.Forms.TextBox()
        Me._TxtLabel_2 = New System.Windows.Forms.TextBox()
        Me._TxtLabel_1 = New System.Windows.Forms.TextBox()
        Me._TxtAlert_0 = New System.Windows.Forms.RichTextBox()
        Me._Label_18 = New System.Windows.Forms.Label()
        Me._Label_17 = New System.Windows.Forms.Label()
        Me._Label_16 = New System.Windows.Forms.Label()
        Me._Label_15 = New System.Windows.Forms.Label()
        Me._Label_14 = New System.Windows.Forms.Label()
        Me._Label_13 = New System.Windows.Forms.Label()
        Me._Label_12 = New System.Windows.Forms.Label()
        Me._Label_10 = New System.Windows.Forms.Label()
        Me._Label_9 = New System.Windows.Forms.Label()
        Me._Label_8 = New System.Windows.Forms.Label()
        Me._Label_7 = New System.Windows.Forms.Label()
        Me._Label_6 = New System.Windows.Forms.Label()
        Me._Label_5 = New System.Windows.Forms.Label()
        Me._Label_4 = New System.Windows.Forms.Label()
        Me._Label_3 = New System.Windows.Forms.Label()
        Me._Label_11 = New System.Windows.Forms.Label()
        Me._Label_2 = New System.Windows.Forms.Label()
        Me._Frame_14 = New System.Windows.Forms.GroupBox()
        Me._CmdDelete_16 = New System.Windows.Forms.Button()
        Me._CmdDelete_15 = New System.Windows.Forms.Button()
        Me._CmdDelete_14 = New System.Windows.Forms.Button()
        Me._CmdDelete_13 = New System.Windows.Forms.Button()
        Me._CmdDelete_12 = New System.Windows.Forms.Button()
        Me._CmdDelete_11 = New System.Windows.Forms.Button()
        Me._CmdDelete_10 = New System.Windows.Forms.Button()
        Me._CmdDelete_9 = New System.Windows.Forms.Button()
        Me._CboField_16 = New System.Windows.Forms.ComboBox()
        Me._CmdAdd_16 = New System.Windows.Forms.Button()
        Me._CboField_15 = New System.Windows.Forms.ComboBox()
        Me._CmdAdd_15 = New System.Windows.Forms.Button()
        Me._CboField_14 = New System.Windows.Forms.ComboBox()
        Me._CmdAdd_14 = New System.Windows.Forms.Button()
        Me._CboField_13 = New System.Windows.Forms.ComboBox()
        Me._CmdAdd_13 = New System.Windows.Forms.Button()
        Me._CboField_12 = New System.Windows.Forms.ComboBox()
        Me._CmdAdd_12 = New System.Windows.Forms.Button()
        Me._CboField_11 = New System.Windows.Forms.ComboBox()
        Me._CmdAdd_11 = New System.Windows.Forms.Button()
        Me._CboField_10 = New System.Windows.Forms.ComboBox()
        Me._CmdAdd_10 = New System.Windows.Forms.Button()
        Me._CboField_9 = New System.Windows.Forms.ComboBox()
        Me._CmdAdd_9 = New System.Windows.Forms.Button()
        Me._TxtLabel_16 = New System.Windows.Forms.TextBox()
        Me._TxtLabel_15 = New System.Windows.Forms.TextBox()
        Me._TxtLabel_14 = New System.Windows.Forms.TextBox()
        Me._TxtLabel_13 = New System.Windows.Forms.TextBox()
        Me._TxtLabel_12 = New System.Windows.Forms.TextBox()
        Me._TxtLabel_11 = New System.Windows.Forms.TextBox()
        Me._TxtLabel_10 = New System.Windows.Forms.TextBox()
        Me._TxtLabel_9 = New System.Windows.Forms.TextBox()
        Me._TxtAlert_1 = New System.Windows.Forms.RichTextBox()
        Me._Label_27 = New System.Windows.Forms.Label()
        Me._Label_26 = New System.Windows.Forms.Label()
        Me._Label_25 = New System.Windows.Forms.Label()
        Me._Label_24 = New System.Windows.Forms.Label()
        Me._Label_23 = New System.Windows.Forms.Label()
        Me._Label_22 = New System.Windows.Forms.Label()
        Me._Label_21 = New System.Windows.Forms.Label()
        Me._Label_20 = New System.Windows.Forms.Label()
        Me._Label_19 = New System.Windows.Forms.Label()
        Me._TabServiceLevel_TabPage4 = New System.Windows.Forms.TabPage()
        Me._Picture1_2 = New System.Windows.Forms.Panel()
        Me.SSTab1 = New System.Windows.Forms.TabControl()
        Me._SSTab1_TabPage0 = New System.Windows.Forms.TabPage()
        Me.fmEyeCareReminder = New System.Windows.Forms.GroupBox()
        Me.txtEyeCareReminder = New System.Windows.Forms.TextBox()
        Me.lblEyCareReminder = New System.Windows.Forms.Label()
        Me._Frame_15 = New System.Windows.Forms.GroupBox()
        Me.TxtTBIPrefix = New System.Windows.Forms.TextBox()
        Me.ChkHemodilution = New System.Windows.Forms.CheckBox()
        Me.ChkSecondaryNote = New System.Windows.Forms.CheckBox()
        Me.TxtSecondaryAlert = New System.Windows.Forms.RichTextBox()
        Me.LblTBIPrefix = New System.Windows.Forms.Label()
        Me._Label_43 = New System.Windows.Forms.Label()
        Me._Frame_16 = New System.Windows.Forms.GroupBox()
        Me.ChkSecondary = New System.Windows.Forms.CheckBox()
        Me._SSTab1_TabPage1 = New System.Windows.Forms.TabPage()
        Me.tvwTree = New System.Windows.Forms.TreeView()
        Me.cmdExpandAll = New System.Windows.Forms.Button()
        Me.chkRecurseChecks = New System.Windows.Forms.CheckBox()
        Me._TabServiceLevel_TabPage5 = New System.Windows.Forms.TabPage()
        Me._Frame_17 = New System.Windows.Forms.GroupBox()
        Me._rbtnIntent_0 = New System.Windows.Forms.RadioButton()
        Me._rbtnIntent_1 = New System.Windows.Forms.RadioButton()
        Me._Frame_18 = New System.Windows.Forms.GroupBox()
        Me._Frame_19 = New System.Windows.Forms.GroupBox()
        Me.txtDocumentName = New System.Windows.Forms.TextBox()
        Me.txtRetries = New System.Windows.Forms.TextBox()
        Me.cmbFaxNumber = New System.Windows.Forms.ComboBox()
        Me.cmbOrganization = New System.Windows.Forms.ComboBox()
        Me.cmbPerson = New System.Windows.Forms.ComboBox()
        Me.chkFax = New System.Windows.Forms.CheckBox()
        Me.lblDocumentName = New System.Windows.Forms.Label()
        Me.lblRetries = New System.Windows.Forms.Label()
        Me.lblFaxNumber = New System.Windows.Forms.Label()
        Me.lblOrganization = New System.Windows.Forms.Label()
        Me.lblPerson = New System.Windows.Forms.Label()
        Me.txtNurseScript = New System.Windows.Forms.TextBox()
        Me._Lable_7 = New System.Windows.Forms.Label()
        Me.lblNurseScript = New System.Windows.Forms.Label()
        Me.Frame1 = New System.Windows.Forms.GroupBox()
        Me.chkCheckRegistry = New System.Windows.Forms.CheckBox()
        Me.fmDataSource = New System.Windows.Forms.GroupBox()
        Me.cmdRemoveDSN = New System.Windows.Forms.Button()
        Me.cmdAddDSN = New System.Windows.Forms.Button()
        Me.LstViewAvailableDSN = New System.Windows.Forms.ListView()
        Me.LstViewSelectedDSN = New System.Windows.Forms.ListView()
        Me.lblNote = New System.Windows.Forms.Label()
        Me.lblAvailableDSN = New System.Windows.Forms.Label()
        Me.lblSelectedDSN = New System.Windows.Forms.Label()
        Me._Frame_22 = New System.Windows.Forms.GroupBox()
        Me.Command14 = New System.Windows.Forms.Button()
        Me.Command13 = New System.Windows.Forms.Button()
        Me.Combo6 = New System.Windows.Forms.ComboBox()
        Me.Combo5 = New System.Windows.Forms.ComboBox()
        Me._Frame_24 = New System.Windows.Forms.GroupBox()
        Me._ChkSoftTissue_1 = New System.Windows.Forms.CheckBox()
        Me._ChkEyes_1 = New System.Windows.Forms.CheckBox()
        Me._ChkBone_1 = New System.Windows.Forms.CheckBox()
        Me._ChkHeartValves_1 = New System.Windows.Forms.CheckBox()
        Me._ChkSkin_1 = New System.Windows.Forms.CheckBox()
        Me._ChkOrgans_4 = New System.Windows.Forms.CheckBox()
        Me._ChkResearch_1 = New System.Windows.Forms.CheckBox()
        Me._Frame_23 = New System.Windows.Forms.GroupBox()
        Me.Check10 = New System.Windows.Forms.CheckBox()
        Me.Check9 = New System.Windows.Forms.CheckBox()
        Me.Check8 = New System.Windows.Forms.CheckBox()
        Me.Check7 = New System.Windows.Forms.CheckBox()
        Me.Check6 = New System.Windows.Forms.CheckBox()
        Me.Check5 = New System.Windows.Forms.CheckBox()
        Me.Check4 = New System.Windows.Forms.CheckBox()
        Me.ListView7 = New System.Windows.Forms.ListView()
        Me._Label_30 = New System.Windows.Forms.Label()
        Me._Label_28 = New System.Windows.Forms.Label()
        Me._Label_29 = New System.Windows.Forms.Label()
        Me.Label13 = New System.Windows.Forms.Label()
        Me._Frame_27 = New System.Windows.Forms.GroupBox()
        Me.Picture2 = New System.Windows.Forms.Panel()
        Me.Command10 = New System.Windows.Forms.Button()
        Me.Command5 = New System.Windows.Forms.Button()
        Me.SubType = New System.Windows.Forms.Button()
        Me._Frame_28 = New System.Windows.Forms.GroupBox()
        Me.VScroll1 = New System.Windows.Forms.VScrollBar()
        Me.Text2 = New System.Windows.Forms.TextBox()
        Me.Text9 = New System.Windows.Forms.TextBox()
        Me.Text8 = New System.Windows.Forms.TextBox()
        Me.Text7 = New System.Windows.Forms.TextBox()
        Me.Text6 = New System.Windows.Forms.TextBox()
        Me.Text5 = New System.Windows.Forms.TextBox()
        Me.Command6 = New System.Windows.Forms.Button()
        Me.Frame17 = New System.Windows.Forms.GroupBox()
        Me._ChkOrgans_17 = New System.Windows.Forms.CheckBox()
        Me.Frame13 = New System.Windows.Forms.GroupBox()
        Me._ChkOrgans_13 = New System.Windows.Forms.CheckBox()
        Me.Frame3 = New System.Windows.Forms.GroupBox()
        Me._ChkOrgans_3 = New System.Windows.Forms.CheckBox()
        Me.Frame2 = New System.Windows.Forms.GroupBox()
        Me._ChkOrgans_1 = New System.Windows.Forms.CheckBox()
        Me.Frame15 = New System.Windows.Forms.GroupBox()
        Me._ChkOrgans_15 = New System.Windows.Forms.CheckBox()
        Me.Frame14 = New System.Windows.Forms.GroupBox()
        Me._ChkOrgans_14 = New System.Windows.Forms.CheckBox()
        Me.Frame4 = New System.Windows.Forms.GroupBox()
        Me._ChkOrgans_2 = New System.Windows.Forms.CheckBox()
        Me.Text3 = New System.Windows.Forms.TextBox()
        Me.Label4 = New System.Windows.Forms.Label()
        Me.Label5 = New System.Windows.Forms.Label()
        Me.Label10 = New System.Windows.Forms.Label()
        Me.Label9 = New System.Windows.Forms.Label()
        Me.Label8 = New System.Windows.Forms.Label()
        Me.Label7 = New System.Windows.Forms.Label()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.Command4 = New System.Windows.Forms.Button()
        Me.ListView3 = New System.Windows.Forms.ListView()
        Me.Label2 = New System.Windows.Forms.Label()
        Me._Lable_26 = New System.Windows.Forms.Label()
        Me._Lable_27 = New System.Windows.Forms.Label()
        Me._Frame_30 = New System.Windows.Forms.GroupBox()
        Me.Command2 = New System.Windows.Forms.Button()
        Me.Command3 = New System.Windows.Forms.Button()
        Me.Command1 = New System.Windows.Forms.Button()
        Me.ListView1 = New System.Windows.Forms.ListView()
        Me.ListView2 = New System.Windows.Forms.ListView()
        Me.Label11 = New System.Windows.Forms.Label()
        Me._Lable_0 = New System.Windows.Forms.Label()
        Me._Lable_23 = New System.Windows.Forms.Label()
        Me.Label12 = New System.Windows.Forms.Label()
        Me.Label6 = New System.Windows.Forms.Label()
        Me.ImageList1 = New System.Windows.Forms.ImageList(Me.components)
        Me.CboField = New Microsoft.VisualBasic.Compatibility.VB6.ComboBoxArray(Me.components)
        Me.ChkBone = New Microsoft.VisualBasic.Compatibility.VB6.CheckBoxArray(Me.components)
        Me.ChkEyes = New Microsoft.VisualBasic.Compatibility.VB6.CheckBoxArray(Me.components)
        Me.ChkHeartValves = New Microsoft.VisualBasic.Compatibility.VB6.CheckBoxArray(Me.components)
        Me.ChkOrgans = New Microsoft.VisualBasic.Compatibility.VB6.CheckBoxArray(Me.components)
        Me.ChkResearch = New Microsoft.VisualBasic.Compatibility.VB6.CheckBoxArray(Me.components)
        Me.ChkSkin = New Microsoft.VisualBasic.Compatibility.VB6.CheckBoxArray(Me.components)
        Me.ChkSoftTissue = New Microsoft.VisualBasic.Compatibility.VB6.CheckBoxArray(Me.components)
        Me.CmdAdd = New Microsoft.VisualBasic.Compatibility.VB6.ButtonArray(Me.components)
        Me.CmdDelete = New Microsoft.VisualBasic.Compatibility.VB6.ButtonArray(Me.components)
        Me.DD = New Microsoft.VisualBasic.Compatibility.VB6.RadioButtonArray(Me.components)
        Me.Frame = New Microsoft.VisualBasic.Compatibility.VB6.GroupBoxArray(Me.components)
        Me.Label = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(Me.components)
        Me.LabelPrompt = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(Me.components)
        Me.Lable = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(Me.components)
        Me.OptAttending = New Microsoft.VisualBasic.Compatibility.VB6.RadioButtonArray(Me.components)
        Me.OptEHistory = New Microsoft.VisualBasic.Compatibility.VB6.RadioButtonArray(Me.components)
        Me.OptEPrompt = New Microsoft.VisualBasic.Compatibility.VB6.RadioButtonArray(Me.components)
        Me.OptOTEHistory = New Microsoft.VisualBasic.Compatibility.VB6.RadioButtonArray(Me.components)
        Me.OptOTEPrompt = New Microsoft.VisualBasic.Compatibility.VB6.RadioButtonArray(Me.components)
        Me.OptPrevVent = New Microsoft.VisualBasic.Compatibility.VB6.RadioButtonArray(Me.components)
        Me.OptPronouncing = New Microsoft.VisualBasic.Compatibility.VB6.RadioButtonArray(Me.components)
        Me.OptROPrompt = New Microsoft.VisualBasic.Compatibility.VB6.RadioButtonArray(Me.components)
        Me.OptTEHistory = New Microsoft.VisualBasic.Compatibility.VB6.RadioButtonArray(Me.components)
        Me.OptTEPrompt = New Microsoft.VisualBasic.Compatibility.VB6.RadioButtonArray(Me.components)
        Me.Picture = New Microsoft.VisualBasic.Compatibility.VB6.PanelArray(Me.components)
        Me.Picture1 = New Microsoft.VisualBasic.Compatibility.VB6.PanelArray(Me.components)
        Me.TxtAlert = New Microsoft.VisualBasic.Compatibility.VB6.RichTextBoxArray(Me.components)
        Me.TxtLabel = New Microsoft.VisualBasic.Compatibility.VB6.TextBoxArray(Me.components)
        Me.rbtnIntent = New Microsoft.VisualBasic.Compatibility.VB6.RadioButtonArray(Me.components)
        Me.ChkPendingCase = New System.Windows.Forms.CheckBox()
        Me._Frame_3.SuspendLayout()
        Me.TabServiceLevel.SuspendLayout()
        Me._TabServiceLevel_TabPage0.SuspendLayout()
        Me._Frame_1.SuspendLayout()
        Me._Picture_7.SuspendLayout()
        Me._Picture_6.SuspendLayout()
        Me._Picture_5.SuspendLayout()
        Me._Frame_0.SuspendLayout()
        Me._Frame_5.SuspendLayout()
        Me.RegistryData.SuspendLayout()
        Me.PronouncingData.SuspendLayout()
        Me._Frame_7.SuspendLayout()
        Me.NOK.SuspendLayout()
        Me._Frame_11.SuspendLayout()
        Me._Picture_3.SuspendLayout()
        Me._Picture_2.SuspendLayout()
        Me._Picture_1.SuspendLayout()
        Me._Picture_0.SuspendLayout()
        Me._Frame_8.SuspendLayout()
        Me._Frame_9.SuspendLayout()
        Me._Frame_4.SuspendLayout()
        Me._Frame_10.SuspendLayout()
        Me.Disposition.SuspendLayout()
        Me.Frame5.SuspendLayout()
        Me._TabServiceLevel_TabPage1.SuspendLayout()
        Me._Frame_2.SuspendLayout()
        Me._TabServiceLevel_TabPage2.SuspendLayout()
        Me._Frame_6.SuspendLayout()
        Me._TabServiceLevel_TabPage3.SuspendLayout()
        Me._Frame_12.SuspendLayout()
        Me._Frame_13.SuspendLayout()
        Me._Frame_14.SuspendLayout()
        Me._TabServiceLevel_TabPage4.SuspendLayout()
        Me._Picture1_2.SuspendLayout()
        Me.SSTab1.SuspendLayout()
        Me._SSTab1_TabPage0.SuspendLayout()
        Me.fmEyeCareReminder.SuspendLayout()
        Me._Frame_15.SuspendLayout()
        Me._Frame_16.SuspendLayout()
        Me._SSTab1_TabPage1.SuspendLayout()
        Me._TabServiceLevel_TabPage5.SuspendLayout()
        Me._Frame_17.SuspendLayout()
        Me._Frame_18.SuspendLayout()
        Me._Frame_19.SuspendLayout()
        Me.Frame1.SuspendLayout()
        Me.fmDataSource.SuspendLayout()
        Me._Frame_22.SuspendLayout()
        Me._Frame_24.SuspendLayout()
        Me._Frame_23.SuspendLayout()
        Me._Frame_27.SuspendLayout()
        Me.Picture2.SuspendLayout()
        Me._Frame_28.SuspendLayout()
        Me.Frame17.SuspendLayout()
        Me.Frame13.SuspendLayout()
        Me.Frame3.SuspendLayout()
        Me.Frame2.SuspendLayout()
        Me.Frame15.SuspendLayout()
        Me.Frame14.SuspendLayout()
        Me.Frame4.SuspendLayout()
        Me._Frame_30.SuspendLayout()
        CType(Me.CboField, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.ChkBone, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.ChkEyes, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.ChkHeartValves, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.ChkOrgans, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.ChkResearch, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.ChkSkin, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.ChkSoftTissue, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.CmdAdd, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.CmdDelete, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.DD, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.Frame, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.Label, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.LabelPrompt, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.Lable, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.OptAttending, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.OptEHistory, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.OptEPrompt, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.OptOTEHistory, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.OptOTEPrompt, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.OptPrevVent, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.OptPronouncing, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.OptROPrompt, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.OptTEHistory, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.OptTEPrompt, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.Picture, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.Picture1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.TxtAlert, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.TxtLabel, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.rbtnIntent, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'CmdOK
        '
        Me.CmdOK.BackColor = System.Drawing.SystemColors.Control
        Me.CmdOK.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdOK.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdOK.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdOK.Location = New System.Drawing.Point(782, 6)
        Me.CmdOK.Name = "CmdOK"
        Me.CmdOK.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdOK.Size = New System.Drawing.Size(80, 21)
        Me.CmdOK.TabIndex = 125
        Me.CmdOK.Text = "&Save"
        Me.CmdOK.UseVisualStyleBackColor = False
        '
        'CmdCancel
        '
        Me.CmdCancel.BackColor = System.Drawing.SystemColors.Control
        Me.CmdCancel.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdCancel.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdCancel.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdCancel.Location = New System.Drawing.Point(782, 30)
        Me.CmdCancel.Name = "CmdCancel"
        Me.CmdCancel.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdCancel.Size = New System.Drawing.Size(80, 21)
        Me.CmdCancel.TabIndex = 121
        Me.CmdCancel.Text = "&Cancel"
        Me.CmdCancel.UseVisualStyleBackColor = False
        '
        '_Frame_3
        '
        Me._Frame_3.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_3.Controls.Add(Me.cmdTest)
        Me._Frame_3.Controls.Add(Me.CmdServiceLevelGroupDetail)
        Me._Frame_3.Controls.Add(Me.CboServiceLevelGroup)
        Me._Frame_3.Controls.Add(Me._Lable_1)
        Me._Frame_3.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me._Frame_3.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_3, CType(3, Short))
        Me._Frame_3.Location = New System.Drawing.Point(0, 0)
        Me._Frame_3.Name = "_Frame_3"
        Me._Frame_3.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_3.Size = New System.Drawing.Size(773, 51)
        Me._Frame_3.TabIndex = 122
        Me._Frame_3.TabStop = False
        '
        'cmdTest
        '
        Me.cmdTest.BackColor = System.Drawing.SystemColors.Control
        Me.cmdTest.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdTest.Enabled = False
        Me.cmdTest.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdTest.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdTest.Location = New System.Drawing.Point(688, 16)
        Me.cmdTest.Name = "cmdTest"
        Me.cmdTest.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdTest.Size = New System.Drawing.Size(73, 22)
        Me.cmdTest.TabIndex = 311
        Me.cmdTest.Text = "Test Commit"
        Me.cmdTest.UseVisualStyleBackColor = False
        Me.cmdTest.Visible = False
        '
        'CmdServiceLevelGroupDetail
        '
        Me.CmdServiceLevelGroupDetail.BackColor = System.Drawing.SystemColors.Control
        Me.CmdServiceLevelGroupDetail.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdServiceLevelGroupDetail.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdServiceLevelGroupDetail.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdServiceLevelGroupDetail.Location = New System.Drawing.Point(306, 18)
        Me.CmdServiceLevelGroupDetail.Name = "CmdServiceLevelGroupDetail"
        Me.CmdServiceLevelGroupDetail.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdServiceLevelGroupDetail.Size = New System.Drawing.Size(17, 21)
        Me.CmdServiceLevelGroupDetail.TabIndex = 124
        Me.CmdServiceLevelGroupDetail.Text = "..."
        Me.CmdServiceLevelGroupDetail.UseVisualStyleBackColor = False
        '
        'CboServiceLevelGroup
        '
        Me.CboServiceLevelGroup.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboServiceLevelGroup.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboServiceLevelGroup.BackColor = System.Drawing.SystemColors.Window
        Me.CboServiceLevelGroup.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboServiceLevelGroup.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboServiceLevelGroup.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboServiceLevelGroup.Location = New System.Drawing.Point(90, 18)
        Me.CboServiceLevelGroup.Name = "CboServiceLevelGroup"
        Me.CboServiceLevelGroup.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboServiceLevelGroup.Size = New System.Drawing.Size(211, 24)
        Me.CboServiceLevelGroup.Sorted = True
        Me.CboServiceLevelGroup.TabIndex = 0
        '
        '_Lable_1
        '
        Me._Lable_1.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_1, CType(1, Short))
        Me._Lable_1.Location = New System.Drawing.Point(10, 22)
        Me._Lable_1.Name = "_Lable_1"
        Me._Lable_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_1.Size = New System.Drawing.Size(77, 17)
        Me._Lable_1.TabIndex = 123
        Me._Lable_1.Text = "Service Level"
        '
        'TabServiceLevel
        '
        Me.TabServiceLevel.Controls.Add(Me._TabServiceLevel_TabPage0)
        Me.TabServiceLevel.Controls.Add(Me._TabServiceLevel_TabPage1)
        Me.TabServiceLevel.Controls.Add(Me._TabServiceLevel_TabPage2)
        Me.TabServiceLevel.Controls.Add(Me._TabServiceLevel_TabPage3)
        Me.TabServiceLevel.Controls.Add(Me._TabServiceLevel_TabPage4)
        Me.TabServiceLevel.Controls.Add(Me._TabServiceLevel_TabPage5)
        Me.TabServiceLevel.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TabServiceLevel.ItemSize = New System.Drawing.Size(42, 18)
        Me.TabServiceLevel.Location = New System.Drawing.Point(0, 50)
        Me.TabServiceLevel.Name = "TabServiceLevel"
        Me.TabServiceLevel.SelectedIndex = 5
        Me.TabServiceLevel.Size = New System.Drawing.Size(879, 538)
        Me.TabServiceLevel.TabIndex = 120
        '
        '_TabServiceLevel_TabPage0
        '
        Me._TabServiceLevel_TabPage0.Controls.Add(Me._Frame_1)
        Me._TabServiceLevel_TabPage0.Controls.Add(Me._Frame_0)
        Me._TabServiceLevel_TabPage0.Controls.Add(Me._Frame_5)
        Me._TabServiceLevel_TabPage0.Controls.Add(Me._Frame_7)
        Me._TabServiceLevel_TabPage0.Controls.Add(Me._Frame_8)
        Me._TabServiceLevel_TabPage0.Controls.Add(Me._Frame_9)
        Me._TabServiceLevel_TabPage0.Controls.Add(Me._Frame_4)
        Me._TabServiceLevel_TabPage0.Controls.Add(Me._Frame_10)
        Me._TabServiceLevel_TabPage0.Controls.Add(Me.Disposition)
        Me._TabServiceLevel_TabPage0.Controls.Add(Me.Frame5)
        Me._TabServiceLevel_TabPage0.Location = New System.Drawing.Point(4, 22)
        Me._TabServiceLevel_TabPage0.Name = "_TabServiceLevel_TabPage0"
        Me._TabServiceLevel_TabPage0.Size = New System.Drawing.Size(871, 512)
        Me._TabServiceLevel_TabPage0.TabIndex = 0
        Me._TabServiceLevel_TabPage0.Text = "Screening && Data"
        '
        '_Frame_1
        '
        Me._Frame_1.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_1.Controls.Add(Me._Picture_7)
        Me._Frame_1.Controls.Add(Me._Picture_6)
        Me._Frame_1.Controls.Add(Me._Picture_5)
        Me._Frame_1.Controls.Add(Me.CboTriageLevel)
        Me._Frame_1.Controls.Add(Me._LabelPrompt_7)
        Me._Frame_1.Controls.Add(Me._LabelPrompt_6)
        Me._Frame_1.Controls.Add(Me._LabelPrompt_5)
        Me._Frame_1.Controls.Add(Me._Label_0)
        Me._Frame_1.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me._Frame_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_1, CType(1, Short))
        Me._Frame_1.Location = New System.Drawing.Point(6, 5)
        Me._Frame_1.Name = "_Frame_1"
        Me._Frame_1.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_1.Size = New System.Drawing.Size(391, 97)
        Me._Frame_1.TabIndex = 126
        Me._Frame_1.TabStop = False
        Me._Frame_1.Text = "Triage && Medical History Screening"
        '
        '_Picture_7
        '
        Me._Picture_7.BackColor = System.Drawing.SystemColors.Control
        Me._Picture_7.Controls.Add(Me._OptOTEHistory_0)
        Me._Picture_7.Controls.Add(Me._OptOTEHistory_1)
        Me._Picture_7.Controls.Add(Me._OptOTEHistory_2)
        Me._Picture_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._Picture_7.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Picture_7.ForeColor = System.Drawing.SystemColors.WindowText
        Me.Picture.SetIndex(Me._Picture_7, CType(7, Short))
        Me._Picture_7.Location = New System.Drawing.Point(114, 44)
        Me._Picture_7.Name = "_Picture_7"
        Me._Picture_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Picture_7.Size = New System.Drawing.Size(209, 15)
        Me._Picture_7.TabIndex = 197
        Me._Picture_7.TabStop = True
        '
        '_OptOTEHistory_0
        '
        Me._OptOTEHistory_0.BackColor = System.Drawing.SystemColors.Control
        Me._OptOTEHistory_0.Checked = True
        Me._OptOTEHistory_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._OptOTEHistory_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._OptOTEHistory_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.OptOTEHistory.SetIndex(Me._OptOTEHistory_0, CType(0, Short))
        Me._OptOTEHistory_0.Location = New System.Drawing.Point(0, 0)
        Me._OptOTEHistory_0.Name = "_OptOTEHistory_0"
        Me._OptOTEHistory_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._OptOTEHistory_0.Size = New System.Drawing.Size(75, 15)
        Me._OptOTEHistory_0.TabIndex = 2
        Me._OptOTEHistory_0.TabStop = True
        Me._OptOTEHistory_0.Text = "Advanced"
        Me._OptOTEHistory_0.UseVisualStyleBackColor = False
        '
        '_OptOTEHistory_1
        '
        Me._OptOTEHistory_1.BackColor = System.Drawing.SystemColors.Control
        Me._OptOTEHistory_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._OptOTEHistory_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._OptOTEHistory_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.OptOTEHistory.SetIndex(Me._OptOTEHistory_1, CType(1, Short))
        Me._OptOTEHistory_1.Location = New System.Drawing.Point(76, 0)
        Me._OptOTEHistory_1.Name = "_OptOTEHistory_1"
        Me._OptOTEHistory_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._OptOTEHistory_1.Size = New System.Drawing.Size(75, 15)
        Me._OptOTEHistory_1.TabIndex = 3
        Me._OptOTEHistory_1.TabStop = True
        Me._OptOTEHistory_1.Text = "Standard"
        Me._OptOTEHistory_1.UseVisualStyleBackColor = False
        '
        '_OptOTEHistory_2
        '
        Me._OptOTEHistory_2.BackColor = System.Drawing.SystemColors.Control
        Me._OptOTEHistory_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._OptOTEHistory_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._OptOTEHistory_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.OptOTEHistory.SetIndex(Me._OptOTEHistory_2, CType(2, Short))
        Me._OptOTEHistory_2.Location = New System.Drawing.Point(150, 0)
        Me._OptOTEHistory_2.Name = "_OptOTEHistory_2"
        Me._OptOTEHistory_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._OptOTEHistory_2.Size = New System.Drawing.Size(56, 15)
        Me._OptOTEHistory_2.TabIndex = 4
        Me._OptOTEHistory_2.TabStop = True
        Me._OptOTEHistory_2.Text = "None"
        Me._OptOTEHistory_2.UseVisualStyleBackColor = False
        '
        '_Picture_6
        '
        Me._Picture_6.BackColor = System.Drawing.SystemColors.Control
        Me._Picture_6.Controls.Add(Me._OptTEHistory_2)
        Me._Picture_6.Controls.Add(Me._OptTEHistory_1)
        Me._Picture_6.Controls.Add(Me._OptTEHistory_0)
        Me._Picture_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._Picture_6.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Picture_6.ForeColor = System.Drawing.SystemColors.WindowText
        Me.Picture.SetIndex(Me._Picture_6, CType(6, Short))
        Me._Picture_6.Location = New System.Drawing.Point(114, 60)
        Me._Picture_6.Name = "_Picture_6"
        Me._Picture_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Picture_6.Size = New System.Drawing.Size(209, 15)
        Me._Picture_6.TabIndex = 196
        Me._Picture_6.TabStop = True
        '
        '_OptTEHistory_2
        '
        Me._OptTEHistory_2.BackColor = System.Drawing.SystemColors.Control
        Me._OptTEHistory_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._OptTEHistory_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._OptTEHistory_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.OptTEHistory.SetIndex(Me._OptTEHistory_2, CType(2, Short))
        Me._OptTEHistory_2.Location = New System.Drawing.Point(150, 0)
        Me._OptTEHistory_2.Name = "_OptTEHistory_2"
        Me._OptTEHistory_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._OptTEHistory_2.Size = New System.Drawing.Size(77, 15)
        Me._OptTEHistory_2.TabIndex = 7
        Me._OptTEHistory_2.TabStop = True
        Me._OptTEHistory_2.Text = "None"
        Me._OptTEHistory_2.UseVisualStyleBackColor = False
        '
        '_OptTEHistory_1
        '
        Me._OptTEHistory_1.BackColor = System.Drawing.SystemColors.Control
        Me._OptTEHistory_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._OptTEHistory_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._OptTEHistory_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.OptTEHistory.SetIndex(Me._OptTEHistory_1, CType(1, Short))
        Me._OptTEHistory_1.Location = New System.Drawing.Point(76, 0)
        Me._OptTEHistory_1.Name = "_OptTEHistory_1"
        Me._OptTEHistory_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._OptTEHistory_1.Size = New System.Drawing.Size(77, 15)
        Me._OptTEHistory_1.TabIndex = 6
        Me._OptTEHistory_1.TabStop = True
        Me._OptTEHistory_1.Text = "Standard"
        Me._OptTEHistory_1.UseVisualStyleBackColor = False
        '
        '_OptTEHistory_0
        '
        Me._OptTEHistory_0.BackColor = System.Drawing.SystemColors.Control
        Me._OptTEHistory_0.Checked = True
        Me._OptTEHistory_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._OptTEHistory_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._OptTEHistory_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.OptTEHistory.SetIndex(Me._OptTEHistory_0, CType(0, Short))
        Me._OptTEHistory_0.Location = New System.Drawing.Point(0, 0)
        Me._OptTEHistory_0.Name = "_OptTEHistory_0"
        Me._OptTEHistory_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._OptTEHistory_0.Size = New System.Drawing.Size(77, 15)
        Me._OptTEHistory_0.TabIndex = 5
        Me._OptTEHistory_0.TabStop = True
        Me._OptTEHistory_0.Text = "Advanced"
        Me._OptTEHistory_0.UseVisualStyleBackColor = False
        '
        '_Picture_5
        '
        Me._Picture_5.BackColor = System.Drawing.SystemColors.Control
        Me._Picture_5.Controls.Add(Me._OptEHistory_2)
        Me._Picture_5.Controls.Add(Me._OptEHistory_1)
        Me._Picture_5.Controls.Add(Me._OptEHistory_0)
        Me._Picture_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._Picture_5.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Picture_5.ForeColor = System.Drawing.SystemColors.WindowText
        Me.Picture.SetIndex(Me._Picture_5, CType(5, Short))
        Me._Picture_5.Location = New System.Drawing.Point(114, 76)
        Me._Picture_5.Name = "_Picture_5"
        Me._Picture_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Picture_5.Size = New System.Drawing.Size(219, 15)
        Me._Picture_5.TabIndex = 195
        Me._Picture_5.TabStop = True
        '
        '_OptEHistory_2
        '
        Me._OptEHistory_2.BackColor = System.Drawing.SystemColors.Control
        Me._OptEHistory_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._OptEHistory_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._OptEHistory_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.OptEHistory.SetIndex(Me._OptEHistory_2, CType(2, Short))
        Me._OptEHistory_2.Location = New System.Drawing.Point(150, 0)
        Me._OptEHistory_2.Name = "_OptEHistory_2"
        Me._OptEHistory_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._OptEHistory_2.Size = New System.Drawing.Size(77, 15)
        Me._OptEHistory_2.TabIndex = 10
        Me._OptEHistory_2.TabStop = True
        Me._OptEHistory_2.Text = "None"
        Me._OptEHistory_2.UseVisualStyleBackColor = False
        '
        '_OptEHistory_1
        '
        Me._OptEHistory_1.BackColor = System.Drawing.SystemColors.Control
        Me._OptEHistory_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._OptEHistory_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._OptEHistory_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.OptEHistory.SetIndex(Me._OptEHistory_1, CType(1, Short))
        Me._OptEHistory_1.Location = New System.Drawing.Point(76, 0)
        Me._OptEHistory_1.Name = "_OptEHistory_1"
        Me._OptEHistory_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._OptEHistory_1.Size = New System.Drawing.Size(77, 15)
        Me._OptEHistory_1.TabIndex = 9
        Me._OptEHistory_1.TabStop = True
        Me._OptEHistory_1.Text = "Standard"
        Me._OptEHistory_1.UseVisualStyleBackColor = False
        '
        '_OptEHistory_0
        '
        Me._OptEHistory_0.BackColor = System.Drawing.SystemColors.Control
        Me._OptEHistory_0.Checked = True
        Me._OptEHistory_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._OptEHistory_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._OptEHistory_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.OptEHistory.SetIndex(Me._OptEHistory_0, CType(0, Short))
        Me._OptEHistory_0.Location = New System.Drawing.Point(0, 0)
        Me._OptEHistory_0.Name = "_OptEHistory_0"
        Me._OptEHistory_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._OptEHistory_0.Size = New System.Drawing.Size(77, 15)
        Me._OptEHistory_0.TabIndex = 8
        Me._OptEHistory_0.TabStop = True
        Me._OptEHistory_0.Text = "Advanced"
        Me._OptEHistory_0.UseVisualStyleBackColor = False
        '
        'CboTriageLevel
        '
        Me.CboTriageLevel.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboTriageLevel.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboTriageLevel.BackColor = System.Drawing.SystemColors.Window
        Me.CboTriageLevel.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboTriageLevel.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboTriageLevel.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboTriageLevel.Location = New System.Drawing.Point(114, 16)
        Me.CboTriageLevel.Name = "CboTriageLevel"
        Me.CboTriageLevel.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboTriageLevel.Size = New System.Drawing.Size(115, 24)
        Me.CboTriageLevel.TabIndex = 1
        '
        '_LabelPrompt_7
        '
        Me._LabelPrompt_7.BackColor = System.Drawing.SystemColors.Control
        Me._LabelPrompt_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._LabelPrompt_7.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LabelPrompt_7.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LabelPrompt.SetIndex(Me._LabelPrompt_7, CType(7, Short))
        Me._LabelPrompt_7.Location = New System.Drawing.Point(14, 44)
        Me._LabelPrompt_7.Name = "_LabelPrompt_7"
        Me._LabelPrompt_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LabelPrompt_7.Size = New System.Drawing.Size(97, 15)
        Me._LabelPrompt_7.TabIndex = 200
        Me._LabelPrompt_7.Text = "Organ/Tissue/Eye"
        '
        '_LabelPrompt_6
        '
        Me._LabelPrompt_6.BackColor = System.Drawing.SystemColors.Control
        Me._LabelPrompt_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._LabelPrompt_6.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LabelPrompt_6.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LabelPrompt.SetIndex(Me._LabelPrompt_6, CType(6, Short))
        Me._LabelPrompt_6.Location = New System.Drawing.Point(14, 60)
        Me._LabelPrompt_6.Name = "_LabelPrompt_6"
        Me._LabelPrompt_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LabelPrompt_6.Size = New System.Drawing.Size(81, 15)
        Me._LabelPrompt_6.TabIndex = 199
        Me._LabelPrompt_6.Text = "Tissue/Eye"
        '
        '_LabelPrompt_5
        '
        Me._LabelPrompt_5.BackColor = System.Drawing.SystemColors.Control
        Me._LabelPrompt_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._LabelPrompt_5.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LabelPrompt_5.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LabelPrompt.SetIndex(Me._LabelPrompt_5, CType(5, Short))
        Me._LabelPrompt_5.Location = New System.Drawing.Point(14, 76)
        Me._LabelPrompt_5.Name = "_LabelPrompt_5"
        Me._LabelPrompt_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LabelPrompt_5.Size = New System.Drawing.Size(89, 15)
        Me._LabelPrompt_5.TabIndex = 198
        Me._LabelPrompt_5.Text = "Eye Only"
        '
        '_Label_0
        '
        Me._Label_0.BackColor = System.Drawing.SystemColors.Control
        Me._Label_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_0, CType(0, Short))
        Me._Label_0.Location = New System.Drawing.Point(14, 20)
        Me._Label_0.Name = "_Label_0"
        Me._Label_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_0.Size = New System.Drawing.Size(83, 15)
        Me._Label_0.TabIndex = 127
        Me._Label_0.Text = "Triage Level"
        '
        '_Frame_0
        '
        Me._Frame_0.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_0.Controls.Add(Me.ChkDOBILB)
        Me._Frame_0.Controls.Add(Me.ChkSpecificCOD)
        Me._Frame_0.Controls.Add(Me.ChkAdmitTime)
        Me._Frame_0.Controls.Add(Me.TxtWeightAgeLimit)
        Me._Frame_0.Controls.Add(Me.ChkDeathDate)
        Me._Frame_0.Controls.Add(Me.ChkSSN)
        Me._Frame_0.Controls.Add(Me.ChkMI)
        Me._Frame_0.Controls.Add(Me.ChkBrainDeathDate)
        Me._Frame_0.Controls.Add(Me.ChkBrainDeathTime)
        Me._Frame_0.Controls.Add(Me.ChkHeartBeat)
        Me._Frame_0.Controls.Add(Me.ChkExcludePrevVent)
        Me._Frame_0.Controls.Add(Me.ChkDOB)
        Me._Frame_0.Controls.Add(Me.ChkDOA)
        Me._Frame_0.Controls.Add(Me._OptPrevVent_0)
        Me._Frame_0.Controls.Add(Me._OptPrevVent_1)
        Me._Frame_0.Controls.Add(Me.ChkCOD)
        Me._Frame_0.Controls.Add(Me.ChkAdmitDate)
        Me._Frame_0.Controls.Add(Me.ChkDeathTime)
        Me._Frame_0.Controls.Add(Me.ChkVent)
        Me._Frame_0.Controls.Add(Me.ChkRace)
        Me._Frame_0.Controls.Add(Me.ChkWeight)
        Me._Frame_0.Controls.Add(Me.ChkAge)
        Me._Frame_0.Controls.Add(Me.ChkGender)
        Me._Frame_0.Controls.Add(Me.ChkRecNum)
        Me._Frame_0.Controls.Add(Me.ChkFirstName)
        Me._Frame_0.Controls.Add(Me.ChkLastName)
        Me._Frame_0.Controls.Add(Me.LblWeightAgeLimit)
        Me._Frame_0.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me._Frame_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_0, CType(0, Short))
        Me._Frame_0.Location = New System.Drawing.Point(6, 105)
        Me._Frame_0.Name = "_Frame_0"
        Me._Frame_0.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_0.Size = New System.Drawing.Size(389, 229)
        Me._Frame_0.TabIndex = 128
        Me._Frame_0.TabStop = False
        Me._Frame_0.Text = "Patient Fields"
        '
        'ChkDOBILB
        '
        Me.ChkDOBILB.BackColor = System.Drawing.SystemColors.Control
        Me.ChkDOBILB.Checked = True
        Me.ChkDOBILB.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkDOBILB.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkDOBILB.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkDOBILB.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkDOBILB.Location = New System.Drawing.Point(62, 141)
        Me.ChkDOBILB.Name = "ChkDOBILB"
        Me.ChkDOBILB.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkDOBILB.Size = New System.Drawing.Size(49, 16)
        Me.ChkDOBILB.TabIndex = 340
        Me.ChkDOBILB.Text = "ILB"
        Me.ChkDOBILB.UseVisualStyleBackColor = False
        '
        'ChkSpecificCOD
        '
        Me.ChkSpecificCOD.BackColor = System.Drawing.SystemColors.Control
        Me.ChkSpecificCOD.Checked = True
        Me.ChkSpecificCOD.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkSpecificCOD.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkSpecificCOD.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkSpecificCOD.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkSpecificCOD.Location = New System.Drawing.Point(174, 192)
        Me.ChkSpecificCOD.Name = "ChkSpecificCOD"
        Me.ChkSpecificCOD.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkSpecificCOD.Size = New System.Drawing.Size(153, 15)
        Me.ChkSpecificCOD.TabIndex = 339
        Me.ChkSpecificCOD.Text = "Specific Cause of Death"
        Me.ChkSpecificCOD.UseVisualStyleBackColor = False
        '
        'ChkAdmitTime
        '
        Me.ChkAdmitTime.BackColor = System.Drawing.SystemColors.Control
        Me.ChkAdmitTime.Checked = True
        Me.ChkAdmitTime.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkAdmitTime.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkAdmitTime.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkAdmitTime.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkAdmitTime.Location = New System.Drawing.Point(174, 172)
        Me.ChkAdmitTime.Name = "ChkAdmitTime"
        Me.ChkAdmitTime.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkAdmitTime.Size = New System.Drawing.Size(117, 21)
        Me.ChkAdmitTime.TabIndex = 334
        Me.ChkAdmitTime.Text = "Time of Admission"
        Me.ChkAdmitTime.UseVisualStyleBackColor = False
        '
        'TxtWeightAgeLimit
        '
        Me.TxtWeightAgeLimit.AcceptsReturn = True
        Me.TxtWeightAgeLimit.BackColor = System.Drawing.SystemColors.Window
        Me.TxtWeightAgeLimit.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtWeightAgeLimit.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtWeightAgeLimit.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtWeightAgeLimit.Location = New System.Drawing.Point(64, 170)
        Me.TxtWeightAgeLimit.MaxLength = 0
        Me.TxtWeightAgeLimit.Name = "TxtWeightAgeLimit"
        Me.TxtWeightAgeLimit.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtWeightAgeLimit.Size = New System.Drawing.Size(23, 23)
        Me.TxtWeightAgeLimit.TabIndex = 333
        '
        'ChkDeathDate
        '
        Me.ChkDeathDate.BackColor = System.Drawing.SystemColors.Control
        Me.ChkDeathDate.Checked = True
        Me.ChkDeathDate.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkDeathDate.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkDeathDate.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkDeathDate.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkDeathDate.Location = New System.Drawing.Point(174, 86)
        Me.ChkDeathDate.Name = "ChkDeathDate"
        Me.ChkDeathDate.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkDeathDate.Size = New System.Drawing.Size(159, 17)
        Me.ChkDeathDate.TabIndex = 332
        Me.ChkDeathDate.Text = "Declared CTOD Date"
        Me.ChkDeathDate.UseVisualStyleBackColor = False
        '
        'ChkSSN
        '
        Me.ChkSSN.BackColor = System.Drawing.SystemColors.Control
        Me.ChkSSN.Checked = True
        Me.ChkSSN.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkSSN.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkSSN.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkSSN.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkSSN.Location = New System.Drawing.Point(8, 86)
        Me.ChkSSN.Name = "ChkSSN"
        Me.ChkSSN.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkSSN.Size = New System.Drawing.Size(113, 17)
        Me.ChkSSN.TabIndex = 331
        Me.ChkSSN.Text = "Social Security #"
        Me.ChkSSN.UseVisualStyleBackColor = False
        '
        'ChkMI
        '
        Me.ChkMI.BackColor = System.Drawing.SystemColors.Control
        Me.ChkMI.Checked = True
        Me.ChkMI.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkMI.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkMI.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkMI.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkMI.Location = New System.Drawing.Point(8, 34)
        Me.ChkMI.Name = "ChkMI"
        Me.ChkMI.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkMI.Size = New System.Drawing.Size(111, 17)
        Me.ChkMI.TabIndex = 330
        Me.ChkMI.Text = "MI"
        Me.ChkMI.UseVisualStyleBackColor = False
        '
        'ChkBrainDeathDate
        '
        Me.ChkBrainDeathDate.BackColor = System.Drawing.SystemColors.Control
        Me.ChkBrainDeathDate.Checked = True
        Me.ChkBrainDeathDate.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkBrainDeathDate.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkBrainDeathDate.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkBrainDeathDate.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkBrainDeathDate.Location = New System.Drawing.Point(174, 121)
        Me.ChkBrainDeathDate.Name = "ChkBrainDeathDate"
        Me.ChkBrainDeathDate.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkBrainDeathDate.Size = New System.Drawing.Size(137, 17)
        Me.ChkBrainDeathDate.TabIndex = 329
        Me.ChkBrainDeathDate.Text = "Brain Date of Death"
        Me.ChkBrainDeathDate.UseVisualStyleBackColor = False
        '
        'ChkBrainDeathTime
        '
        Me.ChkBrainDeathTime.BackColor = System.Drawing.SystemColors.Control
        Me.ChkBrainDeathTime.Checked = True
        Me.ChkBrainDeathTime.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkBrainDeathTime.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkBrainDeathTime.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkBrainDeathTime.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkBrainDeathTime.Location = New System.Drawing.Point(174, 139)
        Me.ChkBrainDeathTime.Name = "ChkBrainDeathTime"
        Me.ChkBrainDeathTime.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkBrainDeathTime.Size = New System.Drawing.Size(137, 15)
        Me.ChkBrainDeathTime.TabIndex = 328
        Me.ChkBrainDeathTime.Text = "Brain Time of Death"
        Me.ChkBrainDeathTime.UseVisualStyleBackColor = False
        '
        'ChkHeartBeat
        '
        Me.ChkHeartBeat.BackColor = System.Drawing.SystemColors.Control
        Me.ChkHeartBeat.Checked = True
        Me.ChkHeartBeat.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkHeartBeat.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkHeartBeat.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkHeartBeat.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkHeartBeat.Location = New System.Drawing.Point(174, 14)
        Me.ChkHeartBeat.Name = "ChkHeartBeat"
        Me.ChkHeartBeat.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkHeartBeat.Size = New System.Drawing.Size(89, 17)
        Me.ChkHeartBeat.TabIndex = 19
        Me.ChkHeartBeat.Text = "Heartbeat"
        Me.ChkHeartBeat.UseVisualStyleBackColor = False
        '
        'ChkExcludePrevVent
        '
        Me.ChkExcludePrevVent.BackColor = System.Drawing.SystemColors.Control
        Me.ChkExcludePrevVent.Checked = True
        Me.ChkExcludePrevVent.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkExcludePrevVent.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkExcludePrevVent.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkExcludePrevVent.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkExcludePrevVent.Location = New System.Drawing.Point(192, 44)
        Me.ChkExcludePrevVent.Name = "ChkExcludePrevVent"
        Me.ChkExcludePrevVent.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkExcludePrevVent.Size = New System.Drawing.Size(149, 17)
        Me.ChkExcludePrevVent.TabIndex = 22
        Me.ChkExcludePrevVent.Text = "Exclude Previous Vent"
        Me.ChkExcludePrevVent.UseVisualStyleBackColor = False
        '
        'ChkDOB
        '
        Me.ChkDOB.BackColor = System.Drawing.SystemColors.Control
        Me.ChkDOB.Checked = True
        Me.ChkDOB.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkDOB.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkDOB.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkDOB.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkDOB.Location = New System.Drawing.Point(8, 156)
        Me.ChkDOB.Name = "ChkDOB"
        Me.ChkDOB.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkDOB.Size = New System.Drawing.Size(92, 17)
        Me.ChkDOB.TabIndex = 16
        Me.ChkDOB.Text = "Date of Birth"
        Me.ChkDOB.UseVisualStyleBackColor = False
        '
        'ChkDOA
        '
        Me.ChkDOA.BackColor = System.Drawing.SystemColors.Control
        Me.ChkDOA.Checked = True
        Me.ChkDOA.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkDOA.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkDOA.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkDOA.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkDOA.Location = New System.Drawing.Point(8, 205)
        Me.ChkDOA.Name = "ChkDOA"
        Me.ChkDOA.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkDOA.Size = New System.Drawing.Size(111, 17)
        Me.ChkDOA.TabIndex = 18
        Me.ChkDOA.Text = "Dead on Arrival"
        Me.ChkDOA.UseVisualStyleBackColor = False
        '
        '_OptPrevVent_0
        '
        Me._OptPrevVent_0.BackColor = System.Drawing.SystemColors.Control
        Me._OptPrevVent_0.Checked = True
        Me._OptPrevVent_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._OptPrevVent_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._OptPrevVent_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.OptPrevVent.SetIndex(Me._OptPrevVent_0, CType(0, Short))
        Me._OptPrevVent_0.Location = New System.Drawing.Point(192, 58)
        Me._OptPrevVent_0.Name = "_OptPrevVent_0"
        Me._OptPrevVent_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._OptPrevVent_0.Size = New System.Drawing.Size(119, 17)
        Me._OptPrevVent_0.TabIndex = 23
        Me._OptPrevVent_0.TabStop = True
        Me._OptPrevVent_0.Text = "Prev Vent as O/T/E"
        Me._OptPrevVent_0.UseVisualStyleBackColor = False
        '
        '_OptPrevVent_1
        '
        Me._OptPrevVent_1.BackColor = System.Drawing.SystemColors.Control
        Me._OptPrevVent_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._OptPrevVent_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._OptPrevVent_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.OptPrevVent.SetIndex(Me._OptPrevVent_1, CType(1, Short))
        Me._OptPrevVent_1.Location = New System.Drawing.Point(192, 72)
        Me._OptPrevVent_1.Name = "_OptPrevVent_1"
        Me._OptPrevVent_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._OptPrevVent_1.Size = New System.Drawing.Size(182, 21)
        Me._OptPrevVent_1.TabIndex = 24
        Me._OptPrevVent_1.TabStop = True
        Me._OptPrevVent_1.Text = "Prev Vent as actual disposition"
        Me._OptPrevVent_1.UseVisualStyleBackColor = False
        '
        'ChkCOD
        '
        Me.ChkCOD.BackColor = System.Drawing.SystemColors.Control
        Me.ChkCOD.Checked = True
        Me.ChkCOD.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkCOD.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkCOD.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkCOD.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkCOD.Location = New System.Drawing.Point(176, 208)
        Me.ChkCOD.Name = "ChkCOD"
        Me.ChkCOD.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkCOD.Size = New System.Drawing.Size(111, 17)
        Me.ChkCOD.TabIndex = 27
        Me.ChkCOD.Text = "Cause of Death"
        Me.ChkCOD.UseVisualStyleBackColor = False
        Me.ChkCOD.Visible = False
        '
        'ChkAdmitDate
        '
        Me.ChkAdmitDate.BackColor = System.Drawing.SystemColors.Control
        Me.ChkAdmitDate.Checked = True
        Me.ChkAdmitDate.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkAdmitDate.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkAdmitDate.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkAdmitDate.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkAdmitDate.Location = New System.Drawing.Point(174, 156)
        Me.ChkAdmitDate.Name = "ChkAdmitDate"
        Me.ChkAdmitDate.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkAdmitDate.Size = New System.Drawing.Size(137, 17)
        Me.ChkAdmitDate.TabIndex = 26
        Me.ChkAdmitDate.Text = "Date of Admission"
        Me.ChkAdmitDate.UseVisualStyleBackColor = False
        '
        'ChkDeathTime
        '
        Me.ChkDeathTime.BackColor = System.Drawing.SystemColors.Control
        Me.ChkDeathTime.Checked = True
        Me.ChkDeathTime.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkDeathTime.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkDeathTime.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkDeathTime.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkDeathTime.Location = New System.Drawing.Point(174, 104)
        Me.ChkDeathTime.Name = "ChkDeathTime"
        Me.ChkDeathTime.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkDeathTime.Size = New System.Drawing.Size(146, 17)
        Me.ChkDeathTime.TabIndex = 25
        Me.ChkDeathTime.Text = "Declared CTOD Time"
        Me.ChkDeathTime.UseVisualStyleBackColor = False
        '
        'ChkVent
        '
        Me.ChkVent.BackColor = System.Drawing.SystemColors.Control
        Me.ChkVent.Checked = True
        Me.ChkVent.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkVent.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkVent.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkVent.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkVent.Location = New System.Drawing.Point(174, 30)
        Me.ChkVent.Name = "ChkVent"
        Me.ChkVent.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkVent.Size = New System.Drawing.Size(113, 16)
        Me.ChkVent.TabIndex = 21
        Me.ChkVent.Text = "Vent Status"
        Me.ChkVent.UseVisualStyleBackColor = False
        '
        'ChkRace
        '
        Me.ChkRace.BackColor = System.Drawing.SystemColors.Control
        Me.ChkRace.Checked = True
        Me.ChkRace.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkRace.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkRace.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkRace.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkRace.Location = New System.Drawing.Point(8, 121)
        Me.ChkRace.Name = "ChkRace"
        Me.ChkRace.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkRace.Size = New System.Drawing.Size(111, 17)
        Me.ChkRace.TabIndex = 20
        Me.ChkRace.Text = "Race"
        Me.ChkRace.UseVisualStyleBackColor = False
        '
        'ChkWeight
        '
        Me.ChkWeight.BackColor = System.Drawing.SystemColors.Control
        Me.ChkWeight.Checked = True
        Me.ChkWeight.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkWeight.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkWeight.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkWeight.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkWeight.Location = New System.Drawing.Point(8, 173)
        Me.ChkWeight.Name = "ChkWeight"
        Me.ChkWeight.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkWeight.Size = New System.Drawing.Size(111, 17)
        Me.ChkWeight.TabIndex = 17
        Me.ChkWeight.Text = "Weight"
        Me.ChkWeight.UseVisualStyleBackColor = False
        '
        'ChkAge
        '
        Me.ChkAge.BackColor = System.Drawing.SystemColors.Control
        Me.ChkAge.Checked = True
        Me.ChkAge.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkAge.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkAge.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkAge.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkAge.Location = New System.Drawing.Point(8, 139)
        Me.ChkAge.Name = "ChkAge"
        Me.ChkAge.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkAge.Size = New System.Drawing.Size(48, 18)
        Me.ChkAge.TabIndex = 15
        Me.ChkAge.Text = "Age"
        Me.ChkAge.UseVisualStyleBackColor = False
        '
        'ChkGender
        '
        Me.ChkGender.BackColor = System.Drawing.SystemColors.Control
        Me.ChkGender.Checked = True
        Me.ChkGender.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkGender.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkGender.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkGender.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkGender.Location = New System.Drawing.Point(8, 104)
        Me.ChkGender.Name = "ChkGender"
        Me.ChkGender.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkGender.Size = New System.Drawing.Size(111, 17)
        Me.ChkGender.TabIndex = 14
        Me.ChkGender.Text = "Gender"
        Me.ChkGender.UseVisualStyleBackColor = False
        '
        'ChkRecNum
        '
        Me.ChkRecNum.BackColor = System.Drawing.SystemColors.Control
        Me.ChkRecNum.Checked = True
        Me.ChkRecNum.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkRecNum.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkRecNum.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkRecNum.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkRecNum.Location = New System.Drawing.Point(8, 69)
        Me.ChkRecNum.Name = "ChkRecNum"
        Me.ChkRecNum.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkRecNum.Size = New System.Drawing.Size(113, 17)
        Me.ChkRecNum.TabIndex = 13
        Me.ChkRecNum.Text = "Medical Record #"
        Me.ChkRecNum.UseVisualStyleBackColor = False
        '
        'ChkFirstName
        '
        Me.ChkFirstName.BackColor = System.Drawing.SystemColors.Control
        Me.ChkFirstName.Checked = True
        Me.ChkFirstName.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkFirstName.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkFirstName.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkFirstName.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkFirstName.Location = New System.Drawing.Point(8, 14)
        Me.ChkFirstName.Name = "ChkFirstName"
        Me.ChkFirstName.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkFirstName.Size = New System.Drawing.Size(111, 17)
        Me.ChkFirstName.TabIndex = 12
        Me.ChkFirstName.Text = "First Name"
        Me.ChkFirstName.UseVisualStyleBackColor = False
        '
        'ChkLastName
        '
        Me.ChkLastName.BackColor = System.Drawing.SystemColors.Control
        Me.ChkLastName.Checked = True
        Me.ChkLastName.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkLastName.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkLastName.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkLastName.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkLastName.Location = New System.Drawing.Point(8, 51)
        Me.ChkLastName.Name = "ChkLastName"
        Me.ChkLastName.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkLastName.Size = New System.Drawing.Size(111, 17)
        Me.ChkLastName.TabIndex = 11
        Me.ChkLastName.Text = "Last Name"
        Me.ChkLastName.UseVisualStyleBackColor = False
        '
        'LblWeightAgeLimit
        '
        Me.LblWeightAgeLimit.BackColor = System.Drawing.SystemColors.Control
        Me.LblWeightAgeLimit.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblWeightAgeLimit.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblWeightAgeLimit.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblWeightAgeLimit.Location = New System.Drawing.Point(24, 189)
        Me.LblWeightAgeLimit.Name = "LblWeightAgeLimit"
        Me.LblWeightAgeLimit.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblWeightAgeLimit.Size = New System.Drawing.Size(117, 20)
        Me.LblWeightAgeLimit.TabIndex = 335
        Me.LblWeightAgeLimit.Text = "If under           years."
        '
        '_Frame_5
        '
        Me._Frame_5.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_5.Controls.Add(Me.ChkPendingCase)
        Me._Frame_5.Controls.Add(Me.ChkDCDPotentialMessageEnabled)
        Me._Frame_5.Controls.Add(Me.ChkPNEAllowSaveWithoutContactRequired)
        Me._Frame_5.Controls.Add(Me._OptAttending_0)
        Me._Frame_5.Controls.Add(Me.ChkPronouncingPhone)
        Me._Frame_5.Controls.Add(Me.RegistryData)
        Me._Frame_5.Controls.Add(Me._OptAttending_1)
        Me._Frame_5.Controls.Add(Me.chkDisableSave)
        Me._Frame_5.Controls.Add(Me.ChkAttendingPhone)
        Me._Frame_5.Controls.Add(Me.ChkAttending)
        Me._Frame_5.Controls.Add(Me.chkEmailDisposition)
        Me._Frame_5.Controls.Add(Me.ChkPronouncing)
        Me._Frame_5.Controls.Add(Me.ChkPhysicianInfo)
        Me._Frame_5.Controls.Add(Me.ChkCoronerInfo)
        Me._Frame_5.Controls.Add(Me.PronouncingData)
        Me._Frame_5.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me._Frame_5.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_5.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_5, CType(5, Short))
        Me._Frame_5.Location = New System.Drawing.Point(6, 335)
        Me._Frame_5.Name = "_Frame_5"
        Me._Frame_5.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_5.Size = New System.Drawing.Size(391, 174)
        Me._Frame_5.TabIndex = 129
        Me._Frame_5.TabStop = False
        Me._Frame_5.Text = "Misc Info"
        '
        'ChkDCDPotentialMessageEnabled
        '
        Me.ChkDCDPotentialMessageEnabled.AutoSize = True
        Me.ChkDCDPotentialMessageEnabled.Location = New System.Drawing.Point(6, 153)
        Me.ChkDCDPotentialMessageEnabled.Name = "ChkDCDPotentialMessageEnabled"
        Me.ChkDCDPotentialMessageEnabled.Size = New System.Drawing.Size(236, 20)
        Me.ChkDCDPotentialMessageEnabled.TabIndex = 349
        Me.ChkDCDPotentialMessageEnabled.Text = "DCD Potential Message Enabled"
        Me.ChkDCDPotentialMessageEnabled.UseVisualStyleBackColor = True
        '
        'ChkPNEAllowSaveWithoutContactRequired
        '
        Me.ChkPNEAllowSaveWithoutContactRequired.AutoSize = True
        Me.ChkPNEAllowSaveWithoutContactRequired.Location = New System.Drawing.Point(6, 135)
        Me.ChkPNEAllowSaveWithoutContactRequired.Name = "ChkPNEAllowSaveWithoutContactRequired"
        Me.ChkPNEAllowSaveWithoutContactRequired.Size = New System.Drawing.Size(433, 20)
        Me.ChkPNEAllowSaveWithoutContactRequired.TabIndex = 337
        Me.ChkPNEAllowSaveWithoutContactRequired.Text = "PNE – Allow Saving wthout Addressing Contact Required Events"
        Me.ChkPNEAllowSaveWithoutContactRequired.UseVisualStyleBackColor = True
        '
        '_OptAttending_0
        '
        Me._OptAttending_0.AutoSize = True
        Me._OptAttending_0.BackColor = System.Drawing.SystemColors.Control
        Me._OptAttending_0.Checked = True
        Me._OptAttending_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._OptAttending_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._OptAttending_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.OptAttending.SetIndex(Me._OptAttending_0, CType(0, Short))
        Me._OptAttending_0.Location = New System.Drawing.Point(153, 78)
        Me._OptAttending_0.Name = "_OptAttending_0"
        Me._OptAttending_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._OptAttending_0.Size = New System.Drawing.Size(72, 20)
        Me._OptAttending_0.TabIndex = 30
        Me._OptAttending_0.TabStop = True
        Me._OptAttending_0.Text = "Always"
        Me._OptAttending_0.UseVisualStyleBackColor = False
        '
        'ChkPronouncingPhone
        '
        Me.ChkPronouncingPhone.AutoSize = True
        Me.ChkPronouncingPhone.BackColor = System.Drawing.SystemColors.Control
        Me.ChkPronouncingPhone.Checked = True
        Me.ChkPronouncingPhone.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkPronouncingPhone.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkPronouncingPhone.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkPronouncingPhone.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkPronouncingPhone.Location = New System.Drawing.Point(97, 93)
        Me.ChkPronouncingPhone.Name = "ChkPronouncingPhone"
        Me.ChkPronouncingPhone.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkPronouncingPhone.Size = New System.Drawing.Size(71, 20)
        Me.ChkPronouncingPhone.TabIndex = 336
        Me.ChkPronouncingPhone.Text = "Phone"
        Me.ChkPronouncingPhone.UseVisualStyleBackColor = False
        '
        'RegistryData
        '
        Me.RegistryData.BackColor = System.Drawing.SystemColors.Control
        Me.RegistryData.Controls.Add(Me.RadioDisplayMultiple)
        Me.RegistryData.Controls.Add(Me.RadioDisplaySearch)
        Me.RegistryData.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.RegistryData.ForeColor = System.Drawing.SystemColors.ControlText
        Me.RegistryData.Location = New System.Drawing.Point(157, 16)
        Me.RegistryData.Name = "RegistryData"
        Me.RegistryData.Padding = New System.Windows.Forms.Padding(0)
        Me.RegistryData.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.RegistryData.Size = New System.Drawing.Size(225, 57)
        Me.RegistryData.TabIndex = 346
        Me.RegistryData.TabStop = False
        Me.RegistryData.Text = "RegistryData"
        '
        'RadioDisplayMultiple
        '
        Me.RadioDisplayMultiple.BackColor = System.Drawing.SystemColors.Control
        Me.RadioDisplayMultiple.Cursor = System.Windows.Forms.Cursors.Default
        Me.RadioDisplayMultiple.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.RadioDisplayMultiple.ForeColor = System.Drawing.SystemColors.ControlText
        Me.RadioDisplayMultiple.Location = New System.Drawing.Point(8, 32)
        Me.RadioDisplayMultiple.Name = "RadioDisplayMultiple"
        Me.RadioDisplayMultiple.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.RadioDisplayMultiple.Size = New System.Drawing.Size(209, 17)
        Me.RadioDisplayMultiple.TabIndex = 348
        Me.RadioDisplayMultiple.TabStop = True
        Me.RadioDisplayMultiple.Text = "Only Display if Multiple People Found"
        Me.RadioDisplayMultiple.UseVisualStyleBackColor = False
        '
        'RadioDisplaySearch
        '
        Me.RadioDisplaySearch.BackColor = System.Drawing.SystemColors.Control
        Me.RadioDisplaySearch.Cursor = System.Windows.Forms.Cursors.Default
        Me.RadioDisplaySearch.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.RadioDisplaySearch.ForeColor = System.Drawing.SystemColors.ControlText
        Me.RadioDisplaySearch.Location = New System.Drawing.Point(8, 16)
        Me.RadioDisplaySearch.Name = "RadioDisplaySearch"
        Me.RadioDisplaySearch.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.RadioDisplaySearch.Size = New System.Drawing.Size(209, 17)
        Me.RadioDisplaySearch.TabIndex = 347
        Me.RadioDisplaySearch.TabStop = True
        Me.RadioDisplaySearch.Text = "Always Display Registry Search"
        Me.RadioDisplaySearch.UseVisualStyleBackColor = False
        '
        '_OptAttending_1
        '
        Me._OptAttending_1.AutoSize = True
        Me._OptAttending_1.BackColor = System.Drawing.SystemColors.Control
        Me._OptAttending_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._OptAttending_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._OptAttending_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.OptAttending.SetIndex(Me._OptAttending_1, CType(1, Short))
        Me._OptAttending_1.Location = New System.Drawing.Point(214, 79)
        Me._OptAttending_1.Name = "_OptAttending_1"
        Me._OptAttending_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._OptAttending_1.Size = New System.Drawing.Size(224, 20)
        Me._OptAttending_1.TabIndex = 31
        Me._OptAttending_1.TabStop = True
        Me._OptAttending_1.Text = "Only if current or previous vent"
        Me._OptAttending_1.UseVisualStyleBackColor = False
        '
        'chkDisableSave
        '
        Me.chkDisableSave.BackColor = System.Drawing.SystemColors.Control
        Me.chkDisableSave.Cursor = System.Windows.Forms.Cursors.Default
        Me.chkDisableSave.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.chkDisableSave.ForeColor = System.Drawing.SystemColors.ControlText
        Me.chkDisableSave.Location = New System.Drawing.Point(8, 26)
        Me.chkDisableSave.Name = "chkDisableSave"
        Me.chkDisableSave.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.chkDisableSave.Size = New System.Drawing.Size(145, 17)
        Me.chkDisableSave.TabIndex = 345
        Me.chkDisableSave.Text = "Disable Asp Save"
        Me.chkDisableSave.UseVisualStyleBackColor = False
        '
        'ChkAttendingPhone
        '
        Me.ChkAttendingPhone.AutoSize = True
        Me.ChkAttendingPhone.BackColor = System.Drawing.SystemColors.Control
        Me.ChkAttendingPhone.Checked = True
        Me.ChkAttendingPhone.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkAttendingPhone.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkAttendingPhone.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkAttendingPhone.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkAttendingPhone.Location = New System.Drawing.Point(97, 77)
        Me.ChkAttendingPhone.Name = "ChkAttendingPhone"
        Me.ChkAttendingPhone.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkAttendingPhone.Size = New System.Drawing.Size(71, 20)
        Me.ChkAttendingPhone.TabIndex = 338
        Me.ChkAttendingPhone.Text = "Phone"
        Me.ChkAttendingPhone.UseVisualStyleBackColor = False
        '
        'ChkAttending
        '
        Me.ChkAttending.AutoSize = True
        Me.ChkAttending.BackColor = System.Drawing.SystemColors.Control
        Me.ChkAttending.Checked = True
        Me.ChkAttending.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkAttending.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkAttending.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkAttending.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkAttending.Location = New System.Drawing.Point(8, 77)
        Me.ChkAttending.Name = "ChkAttending"
        Me.ChkAttending.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkAttending.Size = New System.Drawing.Size(90, 20)
        Me.ChkAttending.TabIndex = 337
        Me.ChkAttending.Text = "Attending"
        Me.ChkAttending.UseVisualStyleBackColor = False
        '
        'chkEmailDisposition
        '
        Me.chkEmailDisposition.BackColor = System.Drawing.SystemColors.Control
        Me.chkEmailDisposition.Checked = True
        Me.chkEmailDisposition.CheckState = System.Windows.Forms.CheckState.Checked
        Me.chkEmailDisposition.Cursor = System.Windows.Forms.Cursors.Default
        Me.chkEmailDisposition.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.chkEmailDisposition.ForeColor = System.Drawing.SystemColors.ControlText
        Me.chkEmailDisposition.Location = New System.Drawing.Point(8, 12)
        Me.chkEmailDisposition.Name = "chkEmailDisposition"
        Me.chkEmailDisposition.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.chkEmailDisposition.Size = New System.Drawing.Size(169, 17)
        Me.chkEmailDisposition.TabIndex = 327
        Me.chkEmailDisposition.Text = "Include disposition in email"
        Me.chkEmailDisposition.UseVisualStyleBackColor = False
        '
        'ChkPronouncing
        '
        Me.ChkPronouncing.AutoSize = True
        Me.ChkPronouncing.BackColor = System.Drawing.SystemColors.Control
        Me.ChkPronouncing.Checked = True
        Me.ChkPronouncing.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkPronouncing.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkPronouncing.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkPronouncing.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkPronouncing.Location = New System.Drawing.Point(8, 93)
        Me.ChkPronouncing.Name = "ChkPronouncing"
        Me.ChkPronouncing.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkPronouncing.Size = New System.Drawing.Size(110, 20)
        Me.ChkPronouncing.TabIndex = 32
        Me.ChkPronouncing.Text = "Pronouncing"
        Me.ChkPronouncing.UseVisualStyleBackColor = False
        '
        'ChkPhysicianInfo
        '
        Me.ChkPhysicianInfo.BackColor = System.Drawing.SystemColors.Control
        Me.ChkPhysicianInfo.Checked = True
        Me.ChkPhysicianInfo.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkPhysicianInfo.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkPhysicianInfo.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkPhysicianInfo.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkPhysicianInfo.Location = New System.Drawing.Point(8, 55)
        Me.ChkPhysicianInfo.Name = "ChkPhysicianInfo"
        Me.ChkPhysicianInfo.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkPhysicianInfo.Size = New System.Drawing.Size(121, 17)
        Me.ChkPhysicianInfo.TabIndex = 29
        Me.ChkPhysicianInfo.Text = "Physician Info"
        Me.ChkPhysicianInfo.UseVisualStyleBackColor = False
        '
        'ChkCoronerInfo
        '
        Me.ChkCoronerInfo.BackColor = System.Drawing.SystemColors.Control
        Me.ChkCoronerInfo.Checked = True
        Me.ChkCoronerInfo.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkCoronerInfo.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkCoronerInfo.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkCoronerInfo.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkCoronerInfo.Location = New System.Drawing.Point(8, 40)
        Me.ChkCoronerInfo.Name = "ChkCoronerInfo"
        Me.ChkCoronerInfo.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkCoronerInfo.Size = New System.Drawing.Size(121, 17)
        Me.ChkCoronerInfo.TabIndex = 28
        Me.ChkCoronerInfo.Text = "Coroner Case Info"
        Me.ChkCoronerInfo.UseVisualStyleBackColor = False
        '
        'PronouncingData
        '
        Me.PronouncingData.Controls.Add(Me._OptPronouncing_0)
        Me.PronouncingData.Controls.Add(Me._OptPronouncing_1)
        Me.PronouncingData.ForeColor = System.Drawing.SystemColors.Control
        Me.PronouncingData.Location = New System.Drawing.Point(150, 98)
        Me.PronouncingData.Margin = New System.Windows.Forms.Padding(0)
        Me.PronouncingData.Name = "PronouncingData"
        Me.PronouncingData.Padding = New System.Windows.Forms.Padding(0)
        Me.PronouncingData.Size = New System.Drawing.Size(239, 30)
        Me.PronouncingData.TabIndex = 348
        Me.PronouncingData.TabStop = False
        '
        '_OptPronouncing_0
        '
        Me._OptPronouncing_0.AutoSize = True
        Me._OptPronouncing_0.BackColor = System.Drawing.SystemColors.Control
        Me._OptPronouncing_0.Checked = True
        Me._OptPronouncing_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._OptPronouncing_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._OptPronouncing_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.OptPronouncing.SetIndex(Me._OptPronouncing_0, CType(0, Short))
        Me._OptPronouncing_0.Location = New System.Drawing.Point(3, -3)
        Me._OptPronouncing_0.Name = "_OptPronouncing_0"
        Me._OptPronouncing_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._OptPronouncing_0.Size = New System.Drawing.Size(72, 20)
        Me._OptPronouncing_0.TabIndex = 33
        Me._OptPronouncing_0.TabStop = True
        Me._OptPronouncing_0.Text = "Always"
        Me._OptPronouncing_0.UseVisualStyleBackColor = False
        '
        '_OptPronouncing_1
        '
        Me._OptPronouncing_1.AutoSize = True
        Me._OptPronouncing_1.BackColor = System.Drawing.SystemColors.Control
        Me._OptPronouncing_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._OptPronouncing_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._OptPronouncing_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.OptPronouncing.SetIndex(Me._OptPronouncing_1, CType(1, Short))
        Me._OptPronouncing_1.Location = New System.Drawing.Point(64, -2)
        Me._OptPronouncing_1.Name = "_OptPronouncing_1"
        Me._OptPronouncing_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._OptPronouncing_1.Size = New System.Drawing.Size(224, 20)
        Me._OptPronouncing_1.TabIndex = 34
        Me._OptPronouncing_1.TabStop = True
        Me._OptPronouncing_1.Text = "Only if current or previous vent"
        Me._OptPronouncing_1.UseVisualStyleBackColor = False
        '
        '_Frame_7
        '
        Me._Frame_7.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_7.Controls.Add(Me.NOK)
        Me._Frame_7.Controls.Add(Me._Frame_11)
        Me._Frame_7.Controls.Add(Me.ChkNOKAddress)
        Me._Frame_7.Controls.Add(Me.ChkNOKPhone)
        Me._Frame_7.Controls.Add(Me.ChkNOKRelation)
        Me._Frame_7.Controls.Add(Me.ChkNOKName)
        Me._Frame_7.Controls.Add(Me.ChkApproachBy)
        Me._Frame_7.Controls.Add(Me.ChkApproachMethod)
        Me._Frame_7.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me._Frame_7.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_7.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_7, CType(7, Short))
        Me._Frame_7.Location = New System.Drawing.Point(400, 223)
        Me._Frame_7.Name = "_Frame_7"
        Me._Frame_7.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_7.Size = New System.Drawing.Size(471, 207)
        Me._Frame_7.TabIndex = 130
        Me._Frame_7.TabStop = False
        Me._Frame_7.Text = "Approach Type Data"
        '
        'NOK
        '
        Me.NOK.BackColor = System.Drawing.SystemColors.Control
        Me.NOK.Controls.Add(Me.ChkNOKRegistered)
        Me.NOK.Controls.Add(Me.ChkNOKConsent)
        Me.NOK.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.NOK.ForeColor = System.Drawing.SystemColors.ControlText
        Me.NOK.Location = New System.Drawing.Point(8, 128)
        Me.NOK.Name = "NOK"
        Me.NOK.Padding = New System.Windows.Forms.Padding(0)
        Me.NOK.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.NOK.Size = New System.Drawing.Size(453, 65)
        Me.NOK.TabIndex = 324
        Me.NOK.TabStop = False
        Me.NOK.Text = "NOK Retrieval"
        '
        'ChkNOKRegistered
        '
        Me.ChkNOKRegistered.BackColor = System.Drawing.SystemColors.Control
        Me.ChkNOKRegistered.Checked = True
        Me.ChkNOKRegistered.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkNOKRegistered.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkNOKRegistered.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkNOKRegistered.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkNOKRegistered.Location = New System.Drawing.Point(8, 40)
        Me.ChkNOKRegistered.Name = "ChkNOKRegistered"
        Me.ChkNOKRegistered.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkNOKRegistered.Size = New System.Drawing.Size(245, 17)
        Me.ChkNOKRegistered.TabIndex = 326
        Me.ChkNOKRegistered.Text = "Do Not Collect NOK if Registered"
        Me.ChkNOKRegistered.UseVisualStyleBackColor = False
        '
        'ChkNOKConsent
        '
        Me.ChkNOKConsent.BackColor = System.Drawing.SystemColors.Control
        Me.ChkNOKConsent.Checked = True
        Me.ChkNOKConsent.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkNOKConsent.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkNOKConsent.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkNOKConsent.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkNOKConsent.Location = New System.Drawing.Point(8, 16)
        Me.ChkNOKConsent.Name = "ChkNOKConsent"
        Me.ChkNOKConsent.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkNOKConsent.Size = New System.Drawing.Size(189, 17)
        Me.ChkNOKConsent.TabIndex = 325
        Me.ChkNOKConsent.Text = "Collect NOK Upon Consent"
        Me.ChkNOKConsent.UseVisualStyleBackColor = False
        '
        '_Frame_11
        '
        Me._Frame_11.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_11.Controls.Add(Me._Picture_3)
        Me._Frame_11.Controls.Add(Me._Picture_2)
        Me._Frame_11.Controls.Add(Me._Picture_1)
        Me._Frame_11.Controls.Add(Me._Picture_0)
        Me._Frame_11.Controls.Add(Me._LabelPrompt_3)
        Me._Frame_11.Controls.Add(Me._LabelPrompt_2)
        Me._Frame_11.Controls.Add(Me._LabelPrompt_1)
        Me._Frame_11.Controls.Add(Me._LabelPrompt_0)
        Me._Frame_11.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me._Frame_11.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_11.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_11, CType(11, Short))
        Me._Frame_11.Location = New System.Drawing.Point(166, 22)
        Me._Frame_11.Name = "_Frame_11"
        Me._Frame_11.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_11.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_11.Size = New System.Drawing.Size(295, 103)
        Me._Frame_11.TabIndex = 186
        Me._Frame_11.TabStop = False
        Me._Frame_11.Text = "Prompt caller for approach information"
        '
        '_Picture_3
        '
        Me._Picture_3.BackColor = System.Drawing.SystemColors.Control
        Me._Picture_3.Controls.Add(Me._OptROPrompt_0)
        Me._Picture_3.Controls.Add(Me._OptROPrompt_1)
        Me._Picture_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._Picture_3.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Picture_3.ForeColor = System.Drawing.SystemColors.WindowText
        Me.Picture.SetIndex(Me._Picture_3, CType(3, Short))
        Me._Picture_3.Location = New System.Drawing.Point(112, 70)
        Me._Picture_3.Name = "_Picture_3"
        Me._Picture_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Picture_3.Size = New System.Drawing.Size(165, 15)
        Me._Picture_3.TabIndex = 194
        Me._Picture_3.TabStop = True
        '
        '_OptROPrompt_0
        '
        Me._OptROPrompt_0.BackColor = System.Drawing.SystemColors.Control
        Me._OptROPrompt_0.Checked = True
        Me._OptROPrompt_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._OptROPrompt_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._OptROPrompt_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.OptROPrompt.SetIndex(Me._OptROPrompt_0, CType(0, Short))
        Me._OptROPrompt_0.Location = New System.Drawing.Point(0, 0)
        Me._OptROPrompt_0.Name = "_OptROPrompt_0"
        Me._OptROPrompt_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._OptROPrompt_0.Size = New System.Drawing.Size(59, 15)
        Me._OptROPrompt_0.TabIndex = 70
        Me._OptROPrompt_0.TabStop = True
        Me._OptROPrompt_0.Text = "Prompt"
        Me._OptROPrompt_0.UseVisualStyleBackColor = False
        '
        '_OptROPrompt_1
        '
        Me._OptROPrompt_1.BackColor = System.Drawing.SystemColors.Control
        Me._OptROPrompt_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._OptROPrompt_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._OptROPrompt_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.OptROPrompt.SetIndex(Me._OptROPrompt_1, CType(1, Short))
        Me._OptROPrompt_1.Location = New System.Drawing.Point(60, 0)
        Me._OptROPrompt_1.Name = "_OptROPrompt_1"
        Me._OptROPrompt_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._OptROPrompt_1.Size = New System.Drawing.Size(102, 19)
        Me._OptROPrompt_1.TabIndex = 71
        Me._OptROPrompt_1.TabStop = True
        Me._OptROPrompt_1.Text = "Do Not Prompt"
        Me._OptROPrompt_1.UseVisualStyleBackColor = False
        '
        '_Picture_2
        '
        Me._Picture_2.BackColor = System.Drawing.SystemColors.Control
        Me._Picture_2.Controls.Add(Me._OptEPrompt_0)
        Me._Picture_2.Controls.Add(Me._OptEPrompt_1)
        Me._Picture_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._Picture_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Picture_2.ForeColor = System.Drawing.SystemColors.WindowText
        Me.Picture.SetIndex(Me._Picture_2, CType(2, Short))
        Me._Picture_2.Location = New System.Drawing.Point(112, 54)
        Me._Picture_2.Name = "_Picture_2"
        Me._Picture_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Picture_2.Size = New System.Drawing.Size(165, 15)
        Me._Picture_2.TabIndex = 193
        Me._Picture_2.TabStop = True
        '
        '_OptEPrompt_0
        '
        Me._OptEPrompt_0.BackColor = System.Drawing.SystemColors.Control
        Me._OptEPrompt_0.Checked = True
        Me._OptEPrompt_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._OptEPrompt_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._OptEPrompt_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.OptEPrompt.SetIndex(Me._OptEPrompt_0, CType(0, Short))
        Me._OptEPrompt_0.Location = New System.Drawing.Point(0, 0)
        Me._OptEPrompt_0.Name = "_OptEPrompt_0"
        Me._OptEPrompt_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._OptEPrompt_0.Size = New System.Drawing.Size(61, 15)
        Me._OptEPrompt_0.TabIndex = 68
        Me._OptEPrompt_0.TabStop = True
        Me._OptEPrompt_0.Text = "Prompt"
        Me._OptEPrompt_0.UseVisualStyleBackColor = False
        '
        '_OptEPrompt_1
        '
        Me._OptEPrompt_1.BackColor = System.Drawing.SystemColors.Control
        Me._OptEPrompt_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._OptEPrompt_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._OptEPrompt_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.OptEPrompt.SetIndex(Me._OptEPrompt_1, CType(1, Short))
        Me._OptEPrompt_1.Location = New System.Drawing.Point(60, 0)
        Me._OptEPrompt_1.Name = "_OptEPrompt_1"
        Me._OptEPrompt_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._OptEPrompt_1.Size = New System.Drawing.Size(102, 15)
        Me._OptEPrompt_1.TabIndex = 69
        Me._OptEPrompt_1.TabStop = True
        Me._OptEPrompt_1.Text = "Do Not Prompt"
        Me._OptEPrompt_1.UseVisualStyleBackColor = False
        '
        '_Picture_1
        '
        Me._Picture_1.BackColor = System.Drawing.SystemColors.Control
        Me._Picture_1.Controls.Add(Me._OptTEPrompt_0)
        Me._Picture_1.Controls.Add(Me._OptTEPrompt_1)
        Me._Picture_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._Picture_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Picture_1.ForeColor = System.Drawing.SystemColors.WindowText
        Me.Picture.SetIndex(Me._Picture_1, CType(1, Short))
        Me._Picture_1.Location = New System.Drawing.Point(112, 38)
        Me._Picture_1.Name = "_Picture_1"
        Me._Picture_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Picture_1.Size = New System.Drawing.Size(165, 15)
        Me._Picture_1.TabIndex = 192
        Me._Picture_1.TabStop = True
        '
        '_OptTEPrompt_0
        '
        Me._OptTEPrompt_0.BackColor = System.Drawing.SystemColors.Control
        Me._OptTEPrompt_0.Checked = True
        Me._OptTEPrompt_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._OptTEPrompt_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._OptTEPrompt_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.OptTEPrompt.SetIndex(Me._OptTEPrompt_0, CType(0, Short))
        Me._OptTEPrompt_0.Location = New System.Drawing.Point(0, 0)
        Me._OptTEPrompt_0.Name = "_OptTEPrompt_0"
        Me._OptTEPrompt_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._OptTEPrompt_0.Size = New System.Drawing.Size(59, 15)
        Me._OptTEPrompt_0.TabIndex = 66
        Me._OptTEPrompt_0.TabStop = True
        Me._OptTEPrompt_0.Text = "Prompt"
        Me._OptTEPrompt_0.UseVisualStyleBackColor = False
        '
        '_OptTEPrompt_1
        '
        Me._OptTEPrompt_1.BackColor = System.Drawing.SystemColors.Control
        Me._OptTEPrompt_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._OptTEPrompt_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._OptTEPrompt_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.OptTEPrompt.SetIndex(Me._OptTEPrompt_1, CType(1, Short))
        Me._OptTEPrompt_1.Location = New System.Drawing.Point(60, 0)
        Me._OptTEPrompt_1.Name = "_OptTEPrompt_1"
        Me._OptTEPrompt_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._OptTEPrompt_1.Size = New System.Drawing.Size(102, 15)
        Me._OptTEPrompt_1.TabIndex = 67
        Me._OptTEPrompt_1.TabStop = True
        Me._OptTEPrompt_1.Text = "Do Not Prompt"
        Me._OptTEPrompt_1.UseVisualStyleBackColor = False
        '
        '_Picture_0
        '
        Me._Picture_0.BackColor = System.Drawing.SystemColors.Control
        Me._Picture_0.Controls.Add(Me._OptOTEPrompt_1)
        Me._Picture_0.Controls.Add(Me._OptOTEPrompt_0)
        Me._Picture_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._Picture_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Picture_0.ForeColor = System.Drawing.SystemColors.WindowText
        Me.Picture.SetIndex(Me._Picture_0, CType(0, Short))
        Me._Picture_0.Location = New System.Drawing.Point(112, 22)
        Me._Picture_0.Name = "_Picture_0"
        Me._Picture_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Picture_0.Size = New System.Drawing.Size(165, 15)
        Me._Picture_0.TabIndex = 191
        Me._Picture_0.TabStop = True
        '
        '_OptOTEPrompt_1
        '
        Me._OptOTEPrompt_1.BackColor = System.Drawing.SystemColors.Control
        Me._OptOTEPrompt_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._OptOTEPrompt_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._OptOTEPrompt_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.OptOTEPrompt.SetIndex(Me._OptOTEPrompt_1, CType(1, Short))
        Me._OptOTEPrompt_1.Location = New System.Drawing.Point(60, 0)
        Me._OptOTEPrompt_1.Name = "_OptOTEPrompt_1"
        Me._OptOTEPrompt_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._OptOTEPrompt_1.Size = New System.Drawing.Size(102, 15)
        Me._OptOTEPrompt_1.TabIndex = 65
        Me._OptOTEPrompt_1.TabStop = True
        Me._OptOTEPrompt_1.Text = "Do Not Prompt"
        Me._OptOTEPrompt_1.UseVisualStyleBackColor = False
        '
        '_OptOTEPrompt_0
        '
        Me._OptOTEPrompt_0.BackColor = System.Drawing.SystemColors.Control
        Me._OptOTEPrompt_0.Checked = True
        Me._OptOTEPrompt_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._OptOTEPrompt_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._OptOTEPrompt_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.OptOTEPrompt.SetIndex(Me._OptOTEPrompt_0, CType(0, Short))
        Me._OptOTEPrompt_0.Location = New System.Drawing.Point(0, 0)
        Me._OptOTEPrompt_0.Name = "_OptOTEPrompt_0"
        Me._OptOTEPrompt_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._OptOTEPrompt_0.Size = New System.Drawing.Size(59, 15)
        Me._OptOTEPrompt_0.TabIndex = 64
        Me._OptOTEPrompt_0.TabStop = True
        Me._OptOTEPrompt_0.Text = "Prompt"
        Me._OptOTEPrompt_0.UseVisualStyleBackColor = False
        '
        '_LabelPrompt_3
        '
        Me._LabelPrompt_3.BackColor = System.Drawing.SystemColors.Control
        Me._LabelPrompt_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._LabelPrompt_3.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LabelPrompt_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LabelPrompt.SetIndex(Me._LabelPrompt_3, CType(3, Short))
        Me._LabelPrompt_3.Location = New System.Drawing.Point(18, 70)
        Me._LabelPrompt_3.Name = "_LabelPrompt_3"
        Me._LabelPrompt_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LabelPrompt_3.Size = New System.Drawing.Size(65, 15)
        Me._LabelPrompt_3.TabIndex = 190
        Me._LabelPrompt_3.Text = "Ruleout"
        '
        '_LabelPrompt_2
        '
        Me._LabelPrompt_2.BackColor = System.Drawing.SystemColors.Control
        Me._LabelPrompt_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._LabelPrompt_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LabelPrompt_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LabelPrompt.SetIndex(Me._LabelPrompt_2, CType(2, Short))
        Me._LabelPrompt_2.Location = New System.Drawing.Point(18, 54)
        Me._LabelPrompt_2.Name = "_LabelPrompt_2"
        Me._LabelPrompt_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LabelPrompt_2.Size = New System.Drawing.Size(89, 15)
        Me._LabelPrompt_2.TabIndex = 189
        Me._LabelPrompt_2.Text = "Eye Only"
        '
        '_LabelPrompt_1
        '
        Me._LabelPrompt_1.BackColor = System.Drawing.SystemColors.Control
        Me._LabelPrompt_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._LabelPrompt_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LabelPrompt_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LabelPrompt.SetIndex(Me._LabelPrompt_1, CType(1, Short))
        Me._LabelPrompt_1.Location = New System.Drawing.Point(16, 38)
        Me._LabelPrompt_1.Name = "_LabelPrompt_1"
        Me._LabelPrompt_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LabelPrompt_1.Size = New System.Drawing.Size(81, 15)
        Me._LabelPrompt_1.TabIndex = 188
        Me._LabelPrompt_1.Text = "Tissue/Eye"
        '
        '_LabelPrompt_0
        '
        Me._LabelPrompt_0.BackColor = System.Drawing.SystemColors.Control
        Me._LabelPrompt_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._LabelPrompt_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LabelPrompt_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LabelPrompt.SetIndex(Me._LabelPrompt_0, CType(0, Short))
        Me._LabelPrompt_0.Location = New System.Drawing.Point(16, 22)
        Me._LabelPrompt_0.Name = "_LabelPrompt_0"
        Me._LabelPrompt_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LabelPrompt_0.Size = New System.Drawing.Size(97, 15)
        Me._LabelPrompt_0.TabIndex = 187
        Me._LabelPrompt_0.Text = "Organ/Tissue/Eye"
        '
        'ChkNOKAddress
        '
        Me.ChkNOKAddress.BackColor = System.Drawing.SystemColors.Control
        Me.ChkNOKAddress.Checked = True
        Me.ChkNOKAddress.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkNOKAddress.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkNOKAddress.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkNOKAddress.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkNOKAddress.Location = New System.Drawing.Point(10, 102)
        Me.ChkNOKAddress.Name = "ChkNOKAddress"
        Me.ChkNOKAddress.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkNOKAddress.Size = New System.Drawing.Size(117, 17)
        Me.ChkNOKAddress.TabIndex = 76
        Me.ChkNOKAddress.Text = "NOK Address"
        Me.ChkNOKAddress.UseVisualStyleBackColor = False
        '
        'ChkNOKPhone
        '
        Me.ChkNOKPhone.BackColor = System.Drawing.SystemColors.Control
        Me.ChkNOKPhone.Checked = True
        Me.ChkNOKPhone.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkNOKPhone.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkNOKPhone.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkNOKPhone.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkNOKPhone.Location = New System.Drawing.Point(10, 86)
        Me.ChkNOKPhone.Name = "ChkNOKPhone"
        Me.ChkNOKPhone.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkNOKPhone.Size = New System.Drawing.Size(117, 17)
        Me.ChkNOKPhone.TabIndex = 75
        Me.ChkNOKPhone.Text = "NOK Phone"
        Me.ChkNOKPhone.UseVisualStyleBackColor = False
        '
        'ChkNOKRelation
        '
        Me.ChkNOKRelation.BackColor = System.Drawing.SystemColors.Control
        Me.ChkNOKRelation.Checked = True
        Me.ChkNOKRelation.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkNOKRelation.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkNOKRelation.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkNOKRelation.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkNOKRelation.Location = New System.Drawing.Point(10, 70)
        Me.ChkNOKRelation.Name = "ChkNOKRelation"
        Me.ChkNOKRelation.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkNOKRelation.Size = New System.Drawing.Size(135, 19)
        Me.ChkNOKRelation.TabIndex = 74
        Me.ChkNOKRelation.Text = "NOK Relationship"
        Me.ChkNOKRelation.UseVisualStyleBackColor = False
        '
        'ChkNOKName
        '
        Me.ChkNOKName.BackColor = System.Drawing.SystemColors.Control
        Me.ChkNOKName.Checked = True
        Me.ChkNOKName.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkNOKName.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkNOKName.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkNOKName.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkNOKName.Location = New System.Drawing.Point(10, 54)
        Me.ChkNOKName.Name = "ChkNOKName"
        Me.ChkNOKName.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkNOKName.Size = New System.Drawing.Size(117, 17)
        Me.ChkNOKName.TabIndex = 73
        Me.ChkNOKName.Text = "Next of Kin"
        Me.ChkNOKName.UseVisualStyleBackColor = False
        '
        'ChkApproachBy
        '
        Me.ChkApproachBy.BackColor = System.Drawing.SystemColors.Control
        Me.ChkApproachBy.Checked = True
        Me.ChkApproachBy.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkApproachBy.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkApproachBy.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkApproachBy.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkApproachBy.Location = New System.Drawing.Point(10, 38)
        Me.ChkApproachBy.Name = "ChkApproachBy"
        Me.ChkApproachBy.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkApproachBy.Size = New System.Drawing.Size(117, 17)
        Me.ChkApproachBy.TabIndex = 72
        Me.ChkApproachBy.Text = "Approacher"
        Me.ChkApproachBy.UseVisualStyleBackColor = False
        '
        'ChkApproachMethod
        '
        Me.ChkApproachMethod.BackColor = System.Drawing.SystemColors.Control
        Me.ChkApproachMethod.Checked = True
        Me.ChkApproachMethod.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkApproachMethod.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkApproachMethod.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkApproachMethod.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkApproachMethod.Location = New System.Drawing.Point(10, 22)
        Me.ChkApproachMethod.Name = "ChkApproachMethod"
        Me.ChkApproachMethod.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkApproachMethod.Size = New System.Drawing.Size(150, 17)
        Me.ChkApproachMethod.TabIndex = 63
        Me.ChkApproachMethod.Text = "Method of Approach"
        Me.ChkApproachMethod.UseVisualStyleBackColor = False
        '
        '_Frame_8
        '
        Me._Frame_8.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_8.Controls.Add(Me.ChkConsentEyes)
        Me._Frame_8.Controls.Add(Me.ChkConsentValves)
        Me._Frame_8.Controls.Add(Me.ChkConsentSkin)
        Me._Frame_8.Controls.Add(Me.ChkConsentTissue)
        Me._Frame_8.Controls.Add(Me.ChkConsentBone)
        Me._Frame_8.Controls.Add(Me.ChkConsentOrgan)
        Me._Frame_8.Controls.Add(Me.ChkConsentResearch)
        Me._Frame_8.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me._Frame_8.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_8.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_8, CType(8, Short))
        Me._Frame_8.Location = New System.Drawing.Point(640, 79)
        Me._Frame_8.Name = "_Frame_8"
        Me._Frame_8.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_8.Size = New System.Drawing.Size(113, 145)
        Me._Frame_8.TabIndex = 131
        Me._Frame_8.TabStop = False
        Me._Frame_8.Text = "Consent Data"
        '
        'ChkConsentEyes
        '
        Me.ChkConsentEyes.BackColor = System.Drawing.SystemColors.Control
        Me.ChkConsentEyes.Checked = True
        Me.ChkConsentEyes.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkConsentEyes.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkConsentEyes.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkConsentEyes.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkConsentEyes.Location = New System.Drawing.Point(10, 102)
        Me.ChkConsentEyes.Name = "ChkConsentEyes"
        Me.ChkConsentEyes.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkConsentEyes.Size = New System.Drawing.Size(99, 17)
        Me.ChkConsentEyes.TabIndex = 54
        Me.ChkConsentEyes.Text = "Eyes"
        Me.ChkConsentEyes.UseVisualStyleBackColor = False
        '
        'ChkConsentValves
        '
        Me.ChkConsentValves.BackColor = System.Drawing.SystemColors.Control
        Me.ChkConsentValves.Checked = True
        Me.ChkConsentValves.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkConsentValves.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkConsentValves.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkConsentValves.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkConsentValves.Location = New System.Drawing.Point(10, 86)
        Me.ChkConsentValves.Name = "ChkConsentValves"
        Me.ChkConsentValves.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkConsentValves.Size = New System.Drawing.Size(99, 17)
        Me.ChkConsentValves.TabIndex = 53
        Me.ChkConsentValves.Text = "Heart Valves"
        Me.ChkConsentValves.UseVisualStyleBackColor = False
        '
        'ChkConsentSkin
        '
        Me.ChkConsentSkin.BackColor = System.Drawing.SystemColors.Control
        Me.ChkConsentSkin.Checked = True
        Me.ChkConsentSkin.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkConsentSkin.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkConsentSkin.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkConsentSkin.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkConsentSkin.Location = New System.Drawing.Point(10, 70)
        Me.ChkConsentSkin.Name = "ChkConsentSkin"
        Me.ChkConsentSkin.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkConsentSkin.Size = New System.Drawing.Size(99, 17)
        Me.ChkConsentSkin.TabIndex = 52
        Me.ChkConsentSkin.Text = "Skin"
        Me.ChkConsentSkin.UseVisualStyleBackColor = False
        '
        'ChkConsentTissue
        '
        Me.ChkConsentTissue.BackColor = System.Drawing.SystemColors.Control
        Me.ChkConsentTissue.Checked = True
        Me.ChkConsentTissue.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkConsentTissue.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkConsentTissue.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkConsentTissue.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkConsentTissue.Location = New System.Drawing.Point(10, 54)
        Me.ChkConsentTissue.Name = "ChkConsentTissue"
        Me.ChkConsentTissue.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkConsentTissue.Size = New System.Drawing.Size(99, 17)
        Me.ChkConsentTissue.TabIndex = 51
        Me.ChkConsentTissue.Text = "Soft Tissue"
        Me.ChkConsentTissue.UseVisualStyleBackColor = False
        '
        'ChkConsentBone
        '
        Me.ChkConsentBone.BackColor = System.Drawing.SystemColors.Control
        Me.ChkConsentBone.Checked = True
        Me.ChkConsentBone.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkConsentBone.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkConsentBone.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkConsentBone.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkConsentBone.Location = New System.Drawing.Point(10, 38)
        Me.ChkConsentBone.Name = "ChkConsentBone"
        Me.ChkConsentBone.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkConsentBone.Size = New System.Drawing.Size(99, 17)
        Me.ChkConsentBone.TabIndex = 50
        Me.ChkConsentBone.Text = "Bone"
        Me.ChkConsentBone.UseVisualStyleBackColor = False
        '
        'ChkConsentOrgan
        '
        Me.ChkConsentOrgan.BackColor = System.Drawing.SystemColors.Control
        Me.ChkConsentOrgan.Checked = True
        Me.ChkConsentOrgan.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkConsentOrgan.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkConsentOrgan.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkConsentOrgan.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkConsentOrgan.Location = New System.Drawing.Point(10, 22)
        Me.ChkConsentOrgan.Name = "ChkConsentOrgan"
        Me.ChkConsentOrgan.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkConsentOrgan.Size = New System.Drawing.Size(99, 17)
        Me.ChkConsentOrgan.TabIndex = 49
        Me.ChkConsentOrgan.Text = "Organ"
        Me.ChkConsentOrgan.UseVisualStyleBackColor = False
        '
        'ChkConsentResearch
        '
        Me.ChkConsentResearch.BackColor = System.Drawing.SystemColors.Control
        Me.ChkConsentResearch.Checked = True
        Me.ChkConsentResearch.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkConsentResearch.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkConsentResearch.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkConsentResearch.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkConsentResearch.Location = New System.Drawing.Point(10, 118)
        Me.ChkConsentResearch.Name = "ChkConsentResearch"
        Me.ChkConsentResearch.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkConsentResearch.Size = New System.Drawing.Size(99, 17)
        Me.ChkConsentResearch.TabIndex = 55
        Me.ChkConsentResearch.Text = "Research"
        Me.ChkConsentResearch.UseVisualStyleBackColor = False
        '
        '_Frame_9
        '
        Me._Frame_9.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_9.Controls.Add(Me.ChkRecoveryEyes)
        Me._Frame_9.Controls.Add(Me.ChkRecoveryValves)
        Me._Frame_9.Controls.Add(Me.ChkRecoverySkin)
        Me._Frame_9.Controls.Add(Me.ChkRecoveryTissue)
        Me._Frame_9.Controls.Add(Me.ChkRecoveryBone)
        Me._Frame_9.Controls.Add(Me.ChkRecoveryOrgan)
        Me._Frame_9.Controls.Add(Me.ChkRecoveryResearch)
        Me._Frame_9.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me._Frame_9.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_9.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_9, CType(9, Short))
        Me._Frame_9.Location = New System.Drawing.Point(758, 79)
        Me._Frame_9.Name = "_Frame_9"
        Me._Frame_9.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_9.Size = New System.Drawing.Size(103, 145)
        Me._Frame_9.TabIndex = 132
        Me._Frame_9.TabStop = False
        Me._Frame_9.Text = "Recovery Data"
        '
        'ChkRecoveryEyes
        '
        Me.ChkRecoveryEyes.AutoSize = True
        Me.ChkRecoveryEyes.BackColor = System.Drawing.SystemColors.Control
        Me.ChkRecoveryEyes.Checked = True
        Me.ChkRecoveryEyes.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkRecoveryEyes.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkRecoveryEyes.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkRecoveryEyes.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkRecoveryEyes.Location = New System.Drawing.Point(10, 102)
        Me.ChkRecoveryEyes.Name = "ChkRecoveryEyes"
        Me.ChkRecoveryEyes.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkRecoveryEyes.Size = New System.Drawing.Size(61, 20)
        Me.ChkRecoveryEyes.TabIndex = 61
        Me.ChkRecoveryEyes.Text = "Eyes"
        Me.ChkRecoveryEyes.UseVisualStyleBackColor = False
        '
        'ChkRecoveryValves
        '
        Me.ChkRecoveryValves.AutoSize = True
        Me.ChkRecoveryValves.BackColor = System.Drawing.SystemColors.Control
        Me.ChkRecoveryValves.Checked = True
        Me.ChkRecoveryValves.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkRecoveryValves.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkRecoveryValves.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkRecoveryValves.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkRecoveryValves.Location = New System.Drawing.Point(10, 86)
        Me.ChkRecoveryValves.Name = "ChkRecoveryValves"
        Me.ChkRecoveryValves.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkRecoveryValves.Size = New System.Drawing.Size(109, 20)
        Me.ChkRecoveryValves.TabIndex = 60
        Me.ChkRecoveryValves.Text = "Heart Valves"
        Me.ChkRecoveryValves.UseVisualStyleBackColor = False
        '
        'ChkRecoverySkin
        '
        Me.ChkRecoverySkin.AutoSize = True
        Me.ChkRecoverySkin.BackColor = System.Drawing.SystemColors.Control
        Me.ChkRecoverySkin.Checked = True
        Me.ChkRecoverySkin.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkRecoverySkin.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkRecoverySkin.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkRecoverySkin.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkRecoverySkin.Location = New System.Drawing.Point(10, 70)
        Me.ChkRecoverySkin.Name = "ChkRecoverySkin"
        Me.ChkRecoverySkin.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkRecoverySkin.Size = New System.Drawing.Size(57, 20)
        Me.ChkRecoverySkin.TabIndex = 59
        Me.ChkRecoverySkin.Text = "Skin"
        Me.ChkRecoverySkin.UseVisualStyleBackColor = False
        '
        'ChkRecoveryTissue
        '
        Me.ChkRecoveryTissue.AutoSize = True
        Me.ChkRecoveryTissue.BackColor = System.Drawing.SystemColors.Control
        Me.ChkRecoveryTissue.Checked = True
        Me.ChkRecoveryTissue.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkRecoveryTissue.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkRecoveryTissue.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkRecoveryTissue.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkRecoveryTissue.Location = New System.Drawing.Point(10, 54)
        Me.ChkRecoveryTissue.Name = "ChkRecoveryTissue"
        Me.ChkRecoveryTissue.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkRecoveryTissue.Size = New System.Drawing.Size(100, 20)
        Me.ChkRecoveryTissue.TabIndex = 58
        Me.ChkRecoveryTissue.Text = "Soft Tissue"
        Me.ChkRecoveryTissue.UseVisualStyleBackColor = False
        '
        'ChkRecoveryBone
        '
        Me.ChkRecoveryBone.AutoSize = True
        Me.ChkRecoveryBone.BackColor = System.Drawing.SystemColors.Control
        Me.ChkRecoveryBone.Checked = True
        Me.ChkRecoveryBone.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkRecoveryBone.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkRecoveryBone.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkRecoveryBone.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkRecoveryBone.Location = New System.Drawing.Point(10, 38)
        Me.ChkRecoveryBone.Name = "ChkRecoveryBone"
        Me.ChkRecoveryBone.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkRecoveryBone.Size = New System.Drawing.Size(63, 20)
        Me.ChkRecoveryBone.TabIndex = 57
        Me.ChkRecoveryBone.Text = "Bone"
        Me.ChkRecoveryBone.UseVisualStyleBackColor = False
        '
        'ChkRecoveryOrgan
        '
        Me.ChkRecoveryOrgan.AutoSize = True
        Me.ChkRecoveryOrgan.BackColor = System.Drawing.SystemColors.Control
        Me.ChkRecoveryOrgan.Checked = True
        Me.ChkRecoveryOrgan.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkRecoveryOrgan.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkRecoveryOrgan.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkRecoveryOrgan.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkRecoveryOrgan.Location = New System.Drawing.Point(10, 22)
        Me.ChkRecoveryOrgan.Name = "ChkRecoveryOrgan"
        Me.ChkRecoveryOrgan.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkRecoveryOrgan.Size = New System.Drawing.Size(70, 20)
        Me.ChkRecoveryOrgan.TabIndex = 56
        Me.ChkRecoveryOrgan.Text = "Organ"
        Me.ChkRecoveryOrgan.UseVisualStyleBackColor = False
        '
        'ChkRecoveryResearch
        '
        Me.ChkRecoveryResearch.AutoSize = True
        Me.ChkRecoveryResearch.BackColor = System.Drawing.SystemColors.Control
        Me.ChkRecoveryResearch.Checked = True
        Me.ChkRecoveryResearch.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkRecoveryResearch.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkRecoveryResearch.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkRecoveryResearch.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkRecoveryResearch.Location = New System.Drawing.Point(10, 118)
        Me.ChkRecoveryResearch.Name = "ChkRecoveryResearch"
        Me.ChkRecoveryResearch.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkRecoveryResearch.Size = New System.Drawing.Size(91, 20)
        Me.ChkRecoveryResearch.TabIndex = 62
        Me.ChkRecoveryResearch.Text = "Research"
        Me.ChkRecoveryResearch.UseVisualStyleBackColor = False
        '
        '_Frame_4
        '
        Me._Frame_4.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_4.Controls.Add(Me.ChkAppropriateResearch)
        Me._Frame_4.Controls.Add(Me.ChkAppropriateOrgan)
        Me._Frame_4.Controls.Add(Me.ChkAppropriateBone)
        Me._Frame_4.Controls.Add(Me.ChkAppropriateTissue)
        Me._Frame_4.Controls.Add(Me.ChkAppropriateSkin)
        Me._Frame_4.Controls.Add(Me.ChkAppropriateValves)
        Me._Frame_4.Controls.Add(Me.ChkAppropriateEyes)
        Me._Frame_4.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me._Frame_4.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_4.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_4, CType(4, Short))
        Me._Frame_4.Location = New System.Drawing.Point(400, 79)
        Me._Frame_4.Name = "_Frame_4"
        Me._Frame_4.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_4.Size = New System.Drawing.Size(113, 145)
        Me._Frame_4.TabIndex = 146
        Me._Frame_4.TabStop = False
        Me._Frame_4.Text = "Appropriate Data"
        '
        'ChkAppropriateResearch
        '
        Me.ChkAppropriateResearch.BackColor = System.Drawing.SystemColors.Control
        Me.ChkAppropriateResearch.Checked = True
        Me.ChkAppropriateResearch.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkAppropriateResearch.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkAppropriateResearch.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkAppropriateResearch.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkAppropriateResearch.Location = New System.Drawing.Point(10, 118)
        Me.ChkAppropriateResearch.Name = "ChkAppropriateResearch"
        Me.ChkAppropriateResearch.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkAppropriateResearch.Size = New System.Drawing.Size(99, 17)
        Me.ChkAppropriateResearch.TabIndex = 41
        Me.ChkAppropriateResearch.Text = "Research"
        Me.ChkAppropriateResearch.UseVisualStyleBackColor = False
        '
        'ChkAppropriateOrgan
        '
        Me.ChkAppropriateOrgan.BackColor = System.Drawing.SystemColors.Control
        Me.ChkAppropriateOrgan.Checked = True
        Me.ChkAppropriateOrgan.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkAppropriateOrgan.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkAppropriateOrgan.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkAppropriateOrgan.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkAppropriateOrgan.Location = New System.Drawing.Point(10, 22)
        Me.ChkAppropriateOrgan.Name = "ChkAppropriateOrgan"
        Me.ChkAppropriateOrgan.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkAppropriateOrgan.Size = New System.Drawing.Size(99, 17)
        Me.ChkAppropriateOrgan.TabIndex = 35
        Me.ChkAppropriateOrgan.Text = "Organ"
        Me.ChkAppropriateOrgan.UseVisualStyleBackColor = False
        '
        'ChkAppropriateBone
        '
        Me.ChkAppropriateBone.BackColor = System.Drawing.SystemColors.Control
        Me.ChkAppropriateBone.Checked = True
        Me.ChkAppropriateBone.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkAppropriateBone.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkAppropriateBone.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkAppropriateBone.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkAppropriateBone.Location = New System.Drawing.Point(10, 38)
        Me.ChkAppropriateBone.Name = "ChkAppropriateBone"
        Me.ChkAppropriateBone.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkAppropriateBone.Size = New System.Drawing.Size(99, 17)
        Me.ChkAppropriateBone.TabIndex = 36
        Me.ChkAppropriateBone.Text = "Bone"
        Me.ChkAppropriateBone.UseVisualStyleBackColor = False
        '
        'ChkAppropriateTissue
        '
        Me.ChkAppropriateTissue.BackColor = System.Drawing.SystemColors.Control
        Me.ChkAppropriateTissue.Checked = True
        Me.ChkAppropriateTissue.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkAppropriateTissue.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkAppropriateTissue.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkAppropriateTissue.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkAppropriateTissue.Location = New System.Drawing.Point(10, 54)
        Me.ChkAppropriateTissue.Name = "ChkAppropriateTissue"
        Me.ChkAppropriateTissue.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkAppropriateTissue.Size = New System.Drawing.Size(99, 17)
        Me.ChkAppropriateTissue.TabIndex = 37
        Me.ChkAppropriateTissue.Text = "Soft Tissue"
        Me.ChkAppropriateTissue.UseVisualStyleBackColor = False
        '
        'ChkAppropriateSkin
        '
        Me.ChkAppropriateSkin.BackColor = System.Drawing.SystemColors.Control
        Me.ChkAppropriateSkin.Checked = True
        Me.ChkAppropriateSkin.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkAppropriateSkin.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkAppropriateSkin.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkAppropriateSkin.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkAppropriateSkin.Location = New System.Drawing.Point(10, 70)
        Me.ChkAppropriateSkin.Name = "ChkAppropriateSkin"
        Me.ChkAppropriateSkin.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkAppropriateSkin.Size = New System.Drawing.Size(99, 17)
        Me.ChkAppropriateSkin.TabIndex = 38
        Me.ChkAppropriateSkin.Text = "Skin"
        Me.ChkAppropriateSkin.UseVisualStyleBackColor = False
        '
        'ChkAppropriateValves
        '
        Me.ChkAppropriateValves.BackColor = System.Drawing.SystemColors.Control
        Me.ChkAppropriateValves.Checked = True
        Me.ChkAppropriateValves.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkAppropriateValves.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkAppropriateValves.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkAppropriateValves.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkAppropriateValves.Location = New System.Drawing.Point(10, 86)
        Me.ChkAppropriateValves.Name = "ChkAppropriateValves"
        Me.ChkAppropriateValves.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkAppropriateValves.Size = New System.Drawing.Size(99, 17)
        Me.ChkAppropriateValves.TabIndex = 39
        Me.ChkAppropriateValves.Text = "Heart Valves"
        Me.ChkAppropriateValves.UseVisualStyleBackColor = False
        '
        'ChkAppropriateEyes
        '
        Me.ChkAppropriateEyes.BackColor = System.Drawing.SystemColors.Control
        Me.ChkAppropriateEyes.Checked = True
        Me.ChkAppropriateEyes.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkAppropriateEyes.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkAppropriateEyes.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkAppropriateEyes.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkAppropriateEyes.Location = New System.Drawing.Point(10, 102)
        Me.ChkAppropriateEyes.Name = "ChkAppropriateEyes"
        Me.ChkAppropriateEyes.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkAppropriateEyes.Size = New System.Drawing.Size(99, 17)
        Me.ChkAppropriateEyes.TabIndex = 40
        Me.ChkAppropriateEyes.Text = "Eyes"
        Me.ChkAppropriateEyes.UseVisualStyleBackColor = False
        '
        '_Frame_10
        '
        Me._Frame_10.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_10.Controls.Add(Me.ChkApproachResearch)
        Me._Frame_10.Controls.Add(Me.ChkApproachOrgan)
        Me._Frame_10.Controls.Add(Me.ChkApproachBone)
        Me._Frame_10.Controls.Add(Me.ChkApproachTissue)
        Me._Frame_10.Controls.Add(Me.ChkApproachSkin)
        Me._Frame_10.Controls.Add(Me.ChkApproachValves)
        Me._Frame_10.Controls.Add(Me.ChkApproachEyes)
        Me._Frame_10.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me._Frame_10.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_10.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_10, CType(10, Short))
        Me._Frame_10.Location = New System.Drawing.Point(520, 79)
        Me._Frame_10.Name = "_Frame_10"
        Me._Frame_10.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_10.Size = New System.Drawing.Size(115, 145)
        Me._Frame_10.TabIndex = 156
        Me._Frame_10.TabStop = False
        Me._Frame_10.Text = "Approach Data"
        '
        'ChkApproachResearch
        '
        Me.ChkApproachResearch.BackColor = System.Drawing.SystemColors.Control
        Me.ChkApproachResearch.Checked = True
        Me.ChkApproachResearch.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkApproachResearch.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkApproachResearch.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkApproachResearch.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkApproachResearch.Location = New System.Drawing.Point(10, 118)
        Me.ChkApproachResearch.Name = "ChkApproachResearch"
        Me.ChkApproachResearch.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkApproachResearch.Size = New System.Drawing.Size(95, 17)
        Me.ChkApproachResearch.TabIndex = 48
        Me.ChkApproachResearch.Text = "Research"
        Me.ChkApproachResearch.UseVisualStyleBackColor = False
        '
        'ChkApproachOrgan
        '
        Me.ChkApproachOrgan.BackColor = System.Drawing.SystemColors.Control
        Me.ChkApproachOrgan.Checked = True
        Me.ChkApproachOrgan.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkApproachOrgan.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkApproachOrgan.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkApproachOrgan.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkApproachOrgan.Location = New System.Drawing.Point(10, 22)
        Me.ChkApproachOrgan.Name = "ChkApproachOrgan"
        Me.ChkApproachOrgan.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkApproachOrgan.Size = New System.Drawing.Size(95, 17)
        Me.ChkApproachOrgan.TabIndex = 42
        Me.ChkApproachOrgan.Text = "Organ"
        Me.ChkApproachOrgan.UseVisualStyleBackColor = False
        '
        'ChkApproachBone
        '
        Me.ChkApproachBone.BackColor = System.Drawing.SystemColors.Control
        Me.ChkApproachBone.Checked = True
        Me.ChkApproachBone.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkApproachBone.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkApproachBone.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkApproachBone.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkApproachBone.Location = New System.Drawing.Point(10, 38)
        Me.ChkApproachBone.Name = "ChkApproachBone"
        Me.ChkApproachBone.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkApproachBone.Size = New System.Drawing.Size(95, 17)
        Me.ChkApproachBone.TabIndex = 43
        Me.ChkApproachBone.Text = "Bone"
        Me.ChkApproachBone.UseVisualStyleBackColor = False
        '
        'ChkApproachTissue
        '
        Me.ChkApproachTissue.BackColor = System.Drawing.SystemColors.Control
        Me.ChkApproachTissue.Checked = True
        Me.ChkApproachTissue.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkApproachTissue.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkApproachTissue.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkApproachTissue.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkApproachTissue.Location = New System.Drawing.Point(10, 54)
        Me.ChkApproachTissue.Name = "ChkApproachTissue"
        Me.ChkApproachTissue.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkApproachTissue.Size = New System.Drawing.Size(95, 17)
        Me.ChkApproachTissue.TabIndex = 44
        Me.ChkApproachTissue.Text = "Soft Tissue"
        Me.ChkApproachTissue.UseVisualStyleBackColor = False
        '
        'ChkApproachSkin
        '
        Me.ChkApproachSkin.BackColor = System.Drawing.SystemColors.Control
        Me.ChkApproachSkin.Checked = True
        Me.ChkApproachSkin.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkApproachSkin.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkApproachSkin.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkApproachSkin.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkApproachSkin.Location = New System.Drawing.Point(10, 70)
        Me.ChkApproachSkin.Name = "ChkApproachSkin"
        Me.ChkApproachSkin.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkApproachSkin.Size = New System.Drawing.Size(95, 17)
        Me.ChkApproachSkin.TabIndex = 45
        Me.ChkApproachSkin.Text = "Skin"
        Me.ChkApproachSkin.UseVisualStyleBackColor = False
        '
        'ChkApproachValves
        '
        Me.ChkApproachValves.BackColor = System.Drawing.SystemColors.Control
        Me.ChkApproachValves.Checked = True
        Me.ChkApproachValves.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkApproachValves.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkApproachValves.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkApproachValves.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkApproachValves.Location = New System.Drawing.Point(10, 86)
        Me.ChkApproachValves.Name = "ChkApproachValves"
        Me.ChkApproachValves.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkApproachValves.Size = New System.Drawing.Size(95, 17)
        Me.ChkApproachValves.TabIndex = 46
        Me.ChkApproachValves.Text = "Heart Valves"
        Me.ChkApproachValves.UseVisualStyleBackColor = False
        '
        'ChkApproachEyes
        '
        Me.ChkApproachEyes.BackColor = System.Drawing.SystemColors.Control
        Me.ChkApproachEyes.Checked = True
        Me.ChkApproachEyes.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkApproachEyes.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkApproachEyes.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkApproachEyes.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkApproachEyes.Location = New System.Drawing.Point(10, 102)
        Me.ChkApproachEyes.Name = "ChkApproachEyes"
        Me.ChkApproachEyes.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkApproachEyes.Size = New System.Drawing.Size(95, 17)
        Me.ChkApproachEyes.TabIndex = 47
        Me.ChkApproachEyes.Text = "Eyes"
        Me.ChkApproachEyes.UseVisualStyleBackColor = False
        '
        'Disposition
        '
        Me.Disposition.BackColor = System.Drawing.SystemColors.Control
        Me.Disposition.Controls.Add(Me._DD_2)
        Me.Disposition.Controls.Add(Me._DD_1)
        Me.Disposition.Controls.Add(Me._DD_0)
        Me.Disposition.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me.Disposition.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Disposition.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Disposition.Location = New System.Drawing.Point(400, 7)
        Me.Disposition.Name = "Disposition"
        Me.Disposition.Padding = New System.Windows.Forms.Padding(0)
        Me.Disposition.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Disposition.Size = New System.Drawing.Size(377, 73)
        Me.Disposition.TabIndex = 341
        Me.Disposition.TabStop = False
        Me.Disposition.Text = "Disposition"
        '
        '_DD_2
        '
        Me._DD_2.BackColor = System.Drawing.SystemColors.Control
        Me._DD_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._DD_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DD_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DD.SetIndex(Me._DD_2, CType(2, Short))
        Me._DD_2.Location = New System.Drawing.Point(8, 48)
        Me._DD_2.Name = "_DD_2"
        Me._DD_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DD_2.Size = New System.Drawing.Size(313, 17)
        Me._DD_2.TabIndex = 344
        Me._DD_2.TabStop = True
        Me._DD_2.Text = "Only Display Disposition if below fields are set to display"
        Me._DD_2.UseVisualStyleBackColor = False
        '
        '_DD_1
        '
        Me._DD_1.BackColor = System.Drawing.SystemColors.Control
        Me._DD_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._DD_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DD_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DD.SetIndex(Me._DD_1, CType(1, Short))
        Me._DD_1.Location = New System.Drawing.Point(8, 32)
        Me._DD_1.Name = "_DD_1"
        Me._DD_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DD_1.Size = New System.Drawing.Size(177, 17)
        Me._DD_1.TabIndex = 343
        Me._DD_1.TabStop = True
        Me._DD_1.Text = "Never Display Disposition"
        Me._DD_1.UseVisualStyleBackColor = False
        '
        '_DD_0
        '
        Me._DD_0.BackColor = System.Drawing.SystemColors.Control
        Me._DD_0.Checked = True
        Me._DD_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._DD_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DD_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DD.SetIndex(Me._DD_0, CType(0, Short))
        Me._DD_0.Location = New System.Drawing.Point(8, 16)
        Me._DD_0.Name = "_DD_0"
        Me._DD_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DD_0.Size = New System.Drawing.Size(185, 17)
        Me._DD_0.TabIndex = 342
        Me._DD_0.TabStop = True
        Me._DD_0.Text = "Always Display Disposition"
        Me._DD_0.UseVisualStyleBackColor = False
        '
        'Frame5
        '
        Me.Frame5.BackColor = System.Drawing.SystemColors.Control
        Me.Frame5.Controls.Add(Me.chkVerifySex)
        Me.Frame5.Controls.Add(Me.chkVerifyWeight)
        Me.Frame5.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me.Frame5.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Frame5.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame5.Location = New System.Drawing.Point(400, 431)
        Me.Frame5.Name = "Frame5"
        Me.Frame5.Padding = New System.Windows.Forms.Padding(0)
        Me.Frame5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame5.Size = New System.Drawing.Size(471, 65)
        Me.Frame5.TabIndex = 351
        Me.Frame5.TabStop = False
        Me.Frame5.Text = "Verify Data"
        '
        'chkVerifySex
        '
        Me.chkVerifySex.BackColor = System.Drawing.SystemColors.Control
        Me.chkVerifySex.Cursor = System.Windows.Forms.Cursors.Default
        Me.chkVerifySex.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.chkVerifySex.ForeColor = System.Drawing.SystemColors.ControlText
        Me.chkVerifySex.Location = New System.Drawing.Point(16, 40)
        Me.chkVerifySex.Name = "chkVerifySex"
        Me.chkVerifySex.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.chkVerifySex.Size = New System.Drawing.Size(153, 17)
        Me.chkVerifySex.TabIndex = 353
        Me.chkVerifySex.Text = "Verify Gender if Age R/O"
        Me.chkVerifySex.UseVisualStyleBackColor = False
        '
        'chkVerifyWeight
        '
        Me.chkVerifyWeight.BackColor = System.Drawing.SystemColors.Control
        Me.chkVerifyWeight.Cursor = System.Windows.Forms.Cursors.Default
        Me.chkVerifyWeight.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.chkVerifyWeight.ForeColor = System.Drawing.SystemColors.ControlText
        Me.chkVerifyWeight.Location = New System.Drawing.Point(16, 16)
        Me.chkVerifyWeight.Name = "chkVerifyWeight"
        Me.chkVerifyWeight.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.chkVerifyWeight.Size = New System.Drawing.Size(129, 17)
        Me.chkVerifyWeight.TabIndex = 352
        Me.chkVerifyWeight.Text = "Verify Weight If R/O"
        Me.chkVerifyWeight.UseVisualStyleBackColor = False
        '
        '_TabServiceLevel_TabPage1
        '
        Me._TabServiceLevel_TabPage1.Controls.Add(Me._Frame_2)
        Me._TabServiceLevel_TabPage1.Location = New System.Drawing.Point(4, 22)
        Me._TabServiceLevel_TabPage1.Name = "_TabServiceLevel_TabPage1"
        Me._TabServiceLevel_TabPage1.Size = New System.Drawing.Size(871, 512)
        Me._TabServiceLevel_TabPage1.TabIndex = 1
        Me._TabServiceLevel_TabPage1.Text = "Applies To"
        '
        '_Frame_2
        '
        Me._Frame_2.BackColor = System.Drawing.Color.FromArgb(CType(CType(192, Byte), Integer), CType(CType(192, Byte), Integer), CType(CType(192, Byte), Integer))
        Me._Frame_2.Controls.Add(Me.CboState)
        Me._Frame_2.Controls.Add(Me.CmdFind)
        Me._Frame_2.Controls.Add(Me.CboOrganizationType)
        Me._Frame_2.Controls.Add(Me.CmdDeselect)
        Me._Frame_2.Controls.Add(Me.CmdSelect)
        Me._Frame_2.Controls.Add(Me.CmdUnassigned)
        Me._Frame_2.Controls.Add(Me.LstViewAvailableOrganizations)
        Me._Frame_2.Controls.Add(Me.LstViewSelectedOrganizations)
        Me._Frame_2.Controls.Add(Me._Lable_2)
        Me._Frame_2.Controls.Add(Me._Lable_5)
        Me._Frame_2.Controls.Add(Me._Lable_3)
        Me._Frame_2.Controls.Add(Me._Lable_4)
        Me._Frame_2.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me._Frame_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_2, CType(2, Short))
        Me._Frame_2.Location = New System.Drawing.Point(6, 26)
        Me._Frame_2.Name = "_Frame_2"
        Me._Frame_2.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_2.Size = New System.Drawing.Size(751, 353)
        Me._Frame_2.TabIndex = 133
        Me._Frame_2.TabStop = False
        '
        'CboState
        '
        Me.CboState.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboState.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboState.BackColor = System.Drawing.SystemColors.Window
        Me.CboState.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboState.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboState.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboState.Location = New System.Drawing.Point(42, 14)
        Me.CboState.Name = "CboState"
        Me.CboState.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboState.Size = New System.Drawing.Size(51, 24)
        Me.CboState.Sorted = True
        Me.CboState.TabIndex = 139
        '
        'CmdFind
        '
        Me.CmdFind.BackColor = System.Drawing.SystemColors.Control
        Me.CmdFind.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdFind.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdFind.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdFind.Location = New System.Drawing.Point(271, 14)
        Me.CmdFind.Name = "CmdFind"
        Me.CmdFind.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdFind.Size = New System.Drawing.Size(76, 21)
        Me.CmdFind.TabIndex = 138
        Me.CmdFind.Text = "&Find"
        Me.CmdFind.UseVisualStyleBackColor = False
        '
        'CboOrganizationType
        '
        Me.CboOrganizationType.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboOrganizationType.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboOrganizationType.BackColor = System.Drawing.SystemColors.Window
        Me.CboOrganizationType.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboOrganizationType.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboOrganizationType.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboOrganizationType.Location = New System.Drawing.Point(128, 14)
        Me.CboOrganizationType.Name = "CboOrganizationType"
        Me.CboOrganizationType.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboOrganizationType.Size = New System.Drawing.Size(141, 24)
        Me.CboOrganizationType.Sorted = True
        Me.CboOrganizationType.TabIndex = 137
        '
        'CmdDeselect
        '
        Me.CmdDeselect.BackColor = System.Drawing.SystemColors.Control
        Me.CmdDeselect.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdDeselect.Enabled = False
        Me.CmdDeselect.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdDeselect.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdDeselect.Location = New System.Drawing.Point(349, 194)
        Me.CmdDeselect.Name = "CmdDeselect"
        Me.CmdDeselect.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdDeselect.Size = New System.Drawing.Size(55, 21)
        Me.CmdDeselect.TabIndex = 136
        Me.CmdDeselect.Text = "Remove"
        Me.CmdDeselect.UseVisualStyleBackColor = False
        '
        'CmdSelect
        '
        Me.CmdSelect.BackColor = System.Drawing.SystemColors.Control
        Me.CmdSelect.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdSelect.Enabled = False
        Me.CmdSelect.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdSelect.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdSelect.Location = New System.Drawing.Point(349, 168)
        Me.CmdSelect.Name = "CmdSelect"
        Me.CmdSelect.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdSelect.Size = New System.Drawing.Size(55, 21)
        Me.CmdSelect.TabIndex = 135
        Me.CmdSelect.Text = "Add  >>"
        Me.CmdSelect.UseVisualStyleBackColor = False
        '
        'CmdUnassigned
        '
        Me.CmdUnassigned.BackColor = System.Drawing.SystemColors.Control
        Me.CmdUnassigned.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdUnassigned.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdUnassigned.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdUnassigned.Location = New System.Drawing.Point(271, 37)
        Me.CmdUnassigned.Margin = New System.Windows.Forms.Padding(2)
        Me.CmdUnassigned.Name = "CmdUnassigned"
        Me.CmdUnassigned.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdUnassigned.Size = New System.Drawing.Size(76, 20)
        Me.CmdUnassigned.TabIndex = 134
        Me.CmdUnassigned.Text = "&Unassigned"
        Me.CmdUnassigned.UseVisualStyleBackColor = False
        '
        'LstViewAvailableOrganizations
        '
        Me.LstViewAvailableOrganizations.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewAvailableOrganizations.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.LstViewAvailableOrganizations.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewAvailableOrganizations.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewAvailableOrganizations.FullRowSelect = True
        Me.LstViewAvailableOrganizations.HideSelection = False
        Me.LstViewAvailableOrganizations.LabelWrap = False
        Me.LstViewAvailableOrganizations.Location = New System.Drawing.Point(10, 62)
        Me.LstViewAvailableOrganizations.Name = "LstViewAvailableOrganizations"
        Me.LstViewAvailableOrganizations.Size = New System.Drawing.Size(335, 281)
        Me.LstViewAvailableOrganizations.TabIndex = 140
        Me.LstViewAvailableOrganizations.UseCompatibleStateImageBehavior = False
        Me.LstViewAvailableOrganizations.View = System.Windows.Forms.View.Details
        '
        'LstViewSelectedOrganizations
        '
        Me.LstViewSelectedOrganizations.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewSelectedOrganizations.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.LstViewSelectedOrganizations.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewSelectedOrganizations.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewSelectedOrganizations.FullRowSelect = True
        Me.LstViewSelectedOrganizations.HideSelection = False
        Me.LstViewSelectedOrganizations.LabelWrap = False
        Me.LstViewSelectedOrganizations.Location = New System.Drawing.Point(408, 62)
        Me.LstViewSelectedOrganizations.Name = "LstViewSelectedOrganizations"
        Me.LstViewSelectedOrganizations.Size = New System.Drawing.Size(335, 281)
        Me.LstViewSelectedOrganizations.TabIndex = 141
        Me.LstViewSelectedOrganizations.UseCompatibleStateImageBehavior = False
        Me.LstViewSelectedOrganizations.View = System.Windows.Forms.View.Details
        '
        '_Lable_2
        '
        Me._Lable_2.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_2, CType(2, Short))
        Me._Lable_2.Location = New System.Drawing.Point(12, 46)
        Me._Lable_2.Name = "_Lable_2"
        Me._Lable_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_2.Size = New System.Drawing.Size(137, 17)
        Me._Lable_2.TabIndex = 145
        Me._Lable_2.Text = "Available Organizations"
        '
        '_Lable_5
        '
        Me._Lable_5.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_5.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_5.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_5, CType(5, Short))
        Me._Lable_5.Location = New System.Drawing.Point(100, 18)
        Me._Lable_5.Name = "_Lable_5"
        Me._Lable_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_5.Size = New System.Drawing.Size(55, 17)
        Me._Lable_5.TabIndex = 144
        Me._Lable_5.Text = "Type"
        '
        '_Lable_3
        '
        Me._Lable_3.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_3.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_3, CType(3, Short))
        Me._Lable_3.Location = New System.Drawing.Point(408, 46)
        Me._Lable_3.Name = "_Lable_3"
        Me._Lable_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_3.Size = New System.Drawing.Size(137, 17)
        Me._Lable_3.TabIndex = 143
        Me._Lable_3.Text = "Selected Organizations"
        '
        '_Lable_4
        '
        Me._Lable_4.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_4.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_4.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_4, CType(4, Short))
        Me._Lable_4.Location = New System.Drawing.Point(12, 18)
        Me._Lable_4.Name = "_Lable_4"
        Me._Lable_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_4.Size = New System.Drawing.Size(55, 19)
        Me._Lable_4.TabIndex = 142
        Me._Lable_4.Text = "State"
        '
        '_TabServiceLevel_TabPage2
        '
        Me._TabServiceLevel_TabPage2.Controls.Add(Me._Frame_6)
        Me._TabServiceLevel_TabPage2.Location = New System.Drawing.Point(4, 22)
        Me._TabServiceLevel_TabPage2.Name = "_TabServiceLevel_TabPage2"
        Me._TabServiceLevel_TabPage2.Size = New System.Drawing.Size(871, 512)
        Me._TabServiceLevel_TabPage2.TabIndex = 2
        Me._TabServiceLevel_TabPage2.Text = "Source Codes"
        '
        '_Frame_6
        '
        Me._Frame_6.BackColor = System.Drawing.Color.FromArgb(CType(CType(192, Byte), Integer), CType(CType(192, Byte), Integer), CType(CType(192, Byte), Integer))
        Me._Frame_6.Controls.Add(Me.CmdRemove)
        Me._Frame_6.Controls.Add(Me.CmdAddSource)
        Me._Frame_6.Controls.Add(Me.LstViewSourceCodes)
        Me._Frame_6.Controls.Add(Me._Lable_8)
        Me._Frame_6.Controls.Add(Me._Lable_19)
        Me._Frame_6.Controls.Add(Me._Lable_20)
        Me._Frame_6.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me._Frame_6.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_6.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_6, CType(6, Short))
        Me._Frame_6.Location = New System.Drawing.Point(6, 26)
        Me._Frame_6.Name = "_Frame_6"
        Me._Frame_6.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_6.Size = New System.Drawing.Size(515, 242)
        Me._Frame_6.TabIndex = 149
        Me._Frame_6.TabStop = False
        '
        'CmdRemove
        '
        Me.CmdRemove.BackColor = System.Drawing.SystemColors.Control
        Me.CmdRemove.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdRemove.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdRemove.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdRemove.Location = New System.Drawing.Point(160, 18)
        Me.CmdRemove.Name = "CmdRemove"
        Me.CmdRemove.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdRemove.Size = New System.Drawing.Size(69, 21)
        Me.CmdRemove.TabIndex = 151
        Me.CmdRemove.Text = "Remove"
        Me.CmdRemove.UseVisualStyleBackColor = False
        '
        'CmdAddSource
        '
        Me.CmdAddSource.BackColor = System.Drawing.SystemColors.Control
        Me.CmdAddSource.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdAddSource.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdAddSource.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdAddSource.Location = New System.Drawing.Point(84, 18)
        Me.CmdAddSource.Name = "CmdAddSource"
        Me.CmdAddSource.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdAddSource.Size = New System.Drawing.Size(69, 21)
        Me.CmdAddSource.TabIndex = 150
        Me.CmdAddSource.Text = "Add..."
        Me.CmdAddSource.UseVisualStyleBackColor = False
        '
        'LstViewSourceCodes
        '
        Me.LstViewSourceCodes.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewSourceCodes.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.LstViewSourceCodes.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewSourceCodes.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewSourceCodes.FullRowSelect = True
        Me.LstViewSourceCodes.HideSelection = False
        Me.LstViewSourceCodes.LabelWrap = False
        Me.LstViewSourceCodes.Location = New System.Drawing.Point(10, 42)
        Me.LstViewSourceCodes.Name = "LstViewSourceCodes"
        Me.LstViewSourceCodes.Size = New System.Drawing.Size(219, 179)
        Me.LstViewSourceCodes.TabIndex = 155
        Me.LstViewSourceCodes.UseCompatibleStateImageBehavior = False
        Me.LstViewSourceCodes.View = System.Windows.Forms.View.Details
        '
        '_Lable_8
        '
        Me._Lable_8.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_8.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_8.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_8.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_8, CType(8, Short))
        Me._Lable_8.Location = New System.Drawing.Point(10, 20)
        Me._Lable_8.Name = "_Lable_8"
        Me._Lable_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_8.Size = New System.Drawing.Size(81, 17)
        Me._Lable_8.TabIndex = 154
        Me._Lable_8.Text = "Source Codes"
        '
        '_Lable_19
        '
        Me._Lable_19.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_19.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_19.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_19.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_19, CType(19, Short))
        Me._Lable_19.Location = New System.Drawing.Point(242, 42)
        Me._Lable_19.Name = "_Lable_19"
        Me._Lable_19.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_19.Size = New System.Drawing.Size(262, 114)
        Me._Lable_19.TabIndex = 153
        Me._Lable_19.Text = resources.GetString("_Lable_19.Text")
        '
        '_Lable_20
        '
        Me._Lable_20.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_20.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_20.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_20.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_20, CType(20, Short))
        Me._Lable_20.Location = New System.Drawing.Point(242, 164)
        Me._Lable_20.Name = "_Lable_20"
        Me._Lable_20.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_20.Size = New System.Drawing.Size(262, 57)
        Me._Lable_20.TabIndex = 152
        Me._Lable_20.Text = "Therefore, the combination of an ""Applies To"" organization and a source code must" &
    " be unique.  In other words, the combination can only be used once."
        '
        '_TabServiceLevel_TabPage3
        '
        Me._TabServiceLevel_TabPage3.Controls.Add(Me._Frame_12)
        Me._TabServiceLevel_TabPage3.Controls.Add(Me._Frame_13)
        Me._TabServiceLevel_TabPage3.Controls.Add(Me._Frame_14)
        Me._TabServiceLevel_TabPage3.Location = New System.Drawing.Point(4, 22)
        Me._TabServiceLevel_TabPage3.Name = "_TabServiceLevel_TabPage3"
        Me._TabServiceLevel_TabPage3.Size = New System.Drawing.Size(871, 512)
        Me._TabServiceLevel_TabPage3.TabIndex = 3
        Me._TabServiceLevel_TabPage3.Text = "Custom Fields"
        '
        '_Frame_12
        '
        Me._Frame_12.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_12.Controls.Add(Me.ChkPrompt)
        Me._Frame_12.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me._Frame_12.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_12.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_12, CType(12, Short))
        Me._Frame_12.Location = New System.Drawing.Point(6, 26)
        Me._Frame_12.Name = "_Frame_12"
        Me._Frame_12.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_12.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_12.Size = New System.Drawing.Size(355, 47)
        Me._Frame_12.TabIndex = 157
        Me._Frame_12.TabStop = False
        '
        'ChkPrompt
        '
        Me.ChkPrompt.BackColor = System.Drawing.SystemColors.Control
        Me.ChkPrompt.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkPrompt.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkPrompt.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkPrompt.Location = New System.Drawing.Point(10, 12)
        Me.ChkPrompt.Name = "ChkPrompt"
        Me.ChkPrompt.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkPrompt.Size = New System.Drawing.Size(327, 27)
        Me.ChkPrompt.TabIndex = 77
        Me.ChkPrompt.Text = "Prompt for Fields  (*Fields are only available when selected)"
        Me.ChkPrompt.UseVisualStyleBackColor = False
        '
        '_Frame_13
        '
        Me._Frame_13.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_13.Controls.Add(Me._TxtLabel_8)
        Me._Frame_13.Controls.Add(Me._TxtLabel_7)
        Me._Frame_13.Controls.Add(Me._TxtLabel_6)
        Me._Frame_13.Controls.Add(Me._TxtLabel_5)
        Me._Frame_13.Controls.Add(Me._TxtLabel_4)
        Me._Frame_13.Controls.Add(Me._TxtLabel_3)
        Me._Frame_13.Controls.Add(Me._TxtLabel_2)
        Me._Frame_13.Controls.Add(Me._TxtLabel_1)
        Me._Frame_13.Controls.Add(Me._TxtAlert_0)
        Me._Frame_13.Controls.Add(Me._Label_18)
        Me._Frame_13.Controls.Add(Me._Label_17)
        Me._Frame_13.Controls.Add(Me._Label_16)
        Me._Frame_13.Controls.Add(Me._Label_15)
        Me._Frame_13.Controls.Add(Me._Label_14)
        Me._Frame_13.Controls.Add(Me._Label_13)
        Me._Frame_13.Controls.Add(Me._Label_12)
        Me._Frame_13.Controls.Add(Me._Label_10)
        Me._Frame_13.Controls.Add(Me._Label_9)
        Me._Frame_13.Controls.Add(Me._Label_8)
        Me._Frame_13.Controls.Add(Me._Label_7)
        Me._Frame_13.Controls.Add(Me._Label_6)
        Me._Frame_13.Controls.Add(Me._Label_5)
        Me._Frame_13.Controls.Add(Me._Label_4)
        Me._Frame_13.Controls.Add(Me._Label_3)
        Me._Frame_13.Controls.Add(Me._Label_11)
        Me._Frame_13.Controls.Add(Me._Label_2)
        Me._Frame_13.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me._Frame_13.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_13.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_13, CType(13, Short))
        Me._Frame_13.Location = New System.Drawing.Point(6, 80)
        Me._Frame_13.Name = "_Frame_13"
        Me._Frame_13.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_13.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_13.Size = New System.Drawing.Size(355, 327)
        Me._Frame_13.TabIndex = 158
        Me._Frame_13.TabStop = False
        Me._Frame_13.Text = "Text Fields"
        '
        '_TxtLabel_8
        '
        Me._TxtLabel_8.AcceptsReturn = True
        Me._TxtLabel_8.BackColor = System.Drawing.SystemColors.Window
        Me._TxtLabel_8.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._TxtLabel_8.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._TxtLabel_8.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtLabel.SetIndex(Me._TxtLabel_8, CType(8, Short))
        Me._TxtLabel_8.Location = New System.Drawing.Point(66, 298)
        Me._TxtLabel_8.MaxLength = 20
        Me._TxtLabel_8.Name = "_TxtLabel_8"
        Me._TxtLabel_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._TxtLabel_8.Size = New System.Drawing.Size(125, 23)
        Me._TxtLabel_8.TabIndex = 86
        '
        '_TxtLabel_7
        '
        Me._TxtLabel_7.AcceptsReturn = True
        Me._TxtLabel_7.BackColor = System.Drawing.SystemColors.Window
        Me._TxtLabel_7.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._TxtLabel_7.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._TxtLabel_7.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtLabel.SetIndex(Me._TxtLabel_7, CType(7, Short))
        Me._TxtLabel_7.Location = New System.Drawing.Point(66, 274)
        Me._TxtLabel_7.MaxLength = 20
        Me._TxtLabel_7.Name = "_TxtLabel_7"
        Me._TxtLabel_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._TxtLabel_7.Size = New System.Drawing.Size(125, 23)
        Me._TxtLabel_7.TabIndex = 85
        '
        '_TxtLabel_6
        '
        Me._TxtLabel_6.AcceptsReturn = True
        Me._TxtLabel_6.BackColor = System.Drawing.SystemColors.Window
        Me._TxtLabel_6.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._TxtLabel_6.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._TxtLabel_6.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtLabel.SetIndex(Me._TxtLabel_6, CType(6, Short))
        Me._TxtLabel_6.Location = New System.Drawing.Point(66, 250)
        Me._TxtLabel_6.MaxLength = 20
        Me._TxtLabel_6.Name = "_TxtLabel_6"
        Me._TxtLabel_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._TxtLabel_6.Size = New System.Drawing.Size(125, 23)
        Me._TxtLabel_6.TabIndex = 84
        '
        '_TxtLabel_5
        '
        Me._TxtLabel_5.AcceptsReturn = True
        Me._TxtLabel_5.BackColor = System.Drawing.SystemColors.Window
        Me._TxtLabel_5.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._TxtLabel_5.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._TxtLabel_5.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtLabel.SetIndex(Me._TxtLabel_5, CType(5, Short))
        Me._TxtLabel_5.Location = New System.Drawing.Point(66, 226)
        Me._TxtLabel_5.MaxLength = 20
        Me._TxtLabel_5.Name = "_TxtLabel_5"
        Me._TxtLabel_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._TxtLabel_5.Size = New System.Drawing.Size(125, 23)
        Me._TxtLabel_5.TabIndex = 83
        '
        '_TxtLabel_4
        '
        Me._TxtLabel_4.AcceptsReturn = True
        Me._TxtLabel_4.BackColor = System.Drawing.SystemColors.Window
        Me._TxtLabel_4.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._TxtLabel_4.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._TxtLabel_4.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtLabel.SetIndex(Me._TxtLabel_4, CType(4, Short))
        Me._TxtLabel_4.Location = New System.Drawing.Point(66, 202)
        Me._TxtLabel_4.MaxLength = 20
        Me._TxtLabel_4.Name = "_TxtLabel_4"
        Me._TxtLabel_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._TxtLabel_4.Size = New System.Drawing.Size(125, 23)
        Me._TxtLabel_4.TabIndex = 82
        '
        '_TxtLabel_3
        '
        Me._TxtLabel_3.AcceptsReturn = True
        Me._TxtLabel_3.BackColor = System.Drawing.SystemColors.Window
        Me._TxtLabel_3.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._TxtLabel_3.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._TxtLabel_3.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtLabel.SetIndex(Me._TxtLabel_3, CType(3, Short))
        Me._TxtLabel_3.Location = New System.Drawing.Point(66, 178)
        Me._TxtLabel_3.MaxLength = 20
        Me._TxtLabel_3.Name = "_TxtLabel_3"
        Me._TxtLabel_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._TxtLabel_3.Size = New System.Drawing.Size(125, 23)
        Me._TxtLabel_3.TabIndex = 81
        '
        '_TxtLabel_2
        '
        Me._TxtLabel_2.AcceptsReturn = True
        Me._TxtLabel_2.BackColor = System.Drawing.SystemColors.Window
        Me._TxtLabel_2.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._TxtLabel_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._TxtLabel_2.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtLabel.SetIndex(Me._TxtLabel_2, CType(2, Short))
        Me._TxtLabel_2.Location = New System.Drawing.Point(66, 154)
        Me._TxtLabel_2.MaxLength = 20
        Me._TxtLabel_2.Name = "_TxtLabel_2"
        Me._TxtLabel_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._TxtLabel_2.Size = New System.Drawing.Size(125, 23)
        Me._TxtLabel_2.TabIndex = 80
        '
        '_TxtLabel_1
        '
        Me._TxtLabel_1.AcceptsReturn = True
        Me._TxtLabel_1.BackColor = System.Drawing.SystemColors.Window
        Me._TxtLabel_1.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._TxtLabel_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._TxtLabel_1.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtLabel.SetIndex(Me._TxtLabel_1, CType(1, Short))
        Me._TxtLabel_1.Location = New System.Drawing.Point(66, 130)
        Me._TxtLabel_1.MaxLength = 20
        Me._TxtLabel_1.Name = "_TxtLabel_1"
        Me._TxtLabel_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._TxtLabel_1.Size = New System.Drawing.Size(125, 23)
        Me._TxtLabel_1.TabIndex = 79
        '
        '_TxtAlert_0
        '
        Me._TxtAlert_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtAlert.SetIndex(Me._TxtAlert_0, CType(0, Short))
        Me._TxtAlert_0.Location = New System.Drawing.Point(66, 18)
        Me._TxtAlert_0.MaxLength = 255
        Me._TxtAlert_0.Name = "_TxtAlert_0"
        Me._TxtAlert_0.RightMargin = 260
        Me._TxtAlert_0.Size = New System.Drawing.Size(281, 107)
        Me._TxtAlert_0.TabIndex = 78
        Me._TxtAlert_0.Text = ""
        '
        '_Label_18
        '
        Me._Label_18.BackColor = System.Drawing.SystemColors.Control
        Me._Label_18.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_18.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_18.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_18, CType(18, Short))
        Me._Label_18.Location = New System.Drawing.Point(12, 302)
        Me._Label_18.Name = "_Label_18"
        Me._Label_18.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_18.Size = New System.Drawing.Size(59, 13)
        Me._Label_18.TabIndex = 176
        Me._Label_18.Text = "Label 8"
        '
        '_Label_17
        '
        Me._Label_17.BackColor = System.Drawing.SystemColors.Control
        Me._Label_17.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_17.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_17.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_17, CType(17, Short))
        Me._Label_17.Location = New System.Drawing.Point(12, 278)
        Me._Label_17.Name = "_Label_17"
        Me._Label_17.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_17.Size = New System.Drawing.Size(59, 13)
        Me._Label_17.TabIndex = 175
        Me._Label_17.Text = "Label 7"
        '
        '_Label_16
        '
        Me._Label_16.BackColor = System.Drawing.SystemColors.Control
        Me._Label_16.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_16.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_16.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_16, CType(16, Short))
        Me._Label_16.Location = New System.Drawing.Point(12, 254)
        Me._Label_16.Name = "_Label_16"
        Me._Label_16.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_16.Size = New System.Drawing.Size(59, 13)
        Me._Label_16.TabIndex = 174
        Me._Label_16.Text = "Label 6"
        '
        '_Label_15
        '
        Me._Label_15.BackColor = System.Drawing.SystemColors.Control
        Me._Label_15.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_15.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_15.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_15, CType(15, Short))
        Me._Label_15.Location = New System.Drawing.Point(12, 230)
        Me._Label_15.Name = "_Label_15"
        Me._Label_15.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_15.Size = New System.Drawing.Size(59, 13)
        Me._Label_15.TabIndex = 173
        Me._Label_15.Text = "Label 5"
        '
        '_Label_14
        '
        Me._Label_14.BackColor = System.Drawing.SystemColors.Control
        Me._Label_14.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_14.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_14.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_14, CType(14, Short))
        Me._Label_14.Location = New System.Drawing.Point(12, 206)
        Me._Label_14.Name = "_Label_14"
        Me._Label_14.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_14.Size = New System.Drawing.Size(59, 13)
        Me._Label_14.TabIndex = 172
        Me._Label_14.Text = "Label 4"
        '
        '_Label_13
        '
        Me._Label_13.BackColor = System.Drawing.SystemColors.Control
        Me._Label_13.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_13.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_13.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_13, CType(13, Short))
        Me._Label_13.Location = New System.Drawing.Point(12, 182)
        Me._Label_13.Name = "_Label_13"
        Me._Label_13.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_13.Size = New System.Drawing.Size(59, 13)
        Me._Label_13.TabIndex = 171
        Me._Label_13.Text = "Label 3"
        '
        '_Label_12
        '
        Me._Label_12.BackColor = System.Drawing.SystemColors.Control
        Me._Label_12.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_12.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_12.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_12, CType(12, Short))
        Me._Label_12.Location = New System.Drawing.Point(12, 158)
        Me._Label_12.Name = "_Label_12"
        Me._Label_12.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_12.Size = New System.Drawing.Size(59, 13)
        Me._Label_12.TabIndex = 170
        Me._Label_12.Text = "Label 2"
        '
        '_Label_10
        '
        Me._Label_10.BackColor = System.Drawing.SystemColors.Control
        Me._Label_10.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_10.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_10.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_10, CType(10, Short))
        Me._Label_10.Location = New System.Drawing.Point(12, 134)
        Me._Label_10.Name = "_Label_10"
        Me._Label_10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_10.Size = New System.Drawing.Size(59, 13)
        Me._Label_10.TabIndex = 169
        Me._Label_10.Text = "Label 1"
        '
        '_Label_9
        '
        Me._Label_9.BackColor = System.Drawing.SystemColors.Control
        Me._Label_9.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_9.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_9.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_9, CType(9, Short))
        Me._Label_9.Location = New System.Drawing.Point(200, 304)
        Me._Label_9.Name = "_Label_9"
        Me._Label_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_9.Size = New System.Drawing.Size(137, 13)
        Me._Label_9.TabIndex = 168
        Me._Label_9.Text = "(Max Size: 255, Multi-line)"
        '
        '_Label_8
        '
        Me._Label_8.BackColor = System.Drawing.SystemColors.Control
        Me._Label_8.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_8.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_8.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_8, CType(8, Short))
        Me._Label_8.Location = New System.Drawing.Point(200, 280)
        Me._Label_8.Name = "_Label_8"
        Me._Label_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_8.Size = New System.Drawing.Size(137, 13)
        Me._Label_8.TabIndex = 167
        Me._Label_8.Text = "(Max Size: 255, Multi-line)"
        '
        '_Label_7
        '
        Me._Label_7.BackColor = System.Drawing.SystemColors.Control
        Me._Label_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_7.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_7.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_7, CType(7, Short))
        Me._Label_7.Location = New System.Drawing.Point(200, 256)
        Me._Label_7.Name = "_Label_7"
        Me._Label_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_7.Size = New System.Drawing.Size(137, 13)
        Me._Label_7.TabIndex = 166
        Me._Label_7.Text = "(Max Size: 40, Single Line)"
        '
        '_Label_6
        '
        Me._Label_6.BackColor = System.Drawing.SystemColors.Control
        Me._Label_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_6.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_6.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_6, CType(6, Short))
        Me._Label_6.Location = New System.Drawing.Point(200, 232)
        Me._Label_6.Name = "_Label_6"
        Me._Label_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_6.Size = New System.Drawing.Size(137, 13)
        Me._Label_6.TabIndex = 165
        Me._Label_6.Text = "(Max Size: 40, Single Line)"
        '
        '_Label_5
        '
        Me._Label_5.BackColor = System.Drawing.SystemColors.Control
        Me._Label_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_5.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_5.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_5, CType(5, Short))
        Me._Label_5.Location = New System.Drawing.Point(200, 208)
        Me._Label_5.Name = "_Label_5"
        Me._Label_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_5.Size = New System.Drawing.Size(137, 13)
        Me._Label_5.TabIndex = 164
        Me._Label_5.Text = "(Max Size: 40, Single Line)"
        '
        '_Label_4
        '
        Me._Label_4.BackColor = System.Drawing.SystemColors.Control
        Me._Label_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_4.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_4.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_4, CType(4, Short))
        Me._Label_4.Location = New System.Drawing.Point(200, 184)
        Me._Label_4.Name = "_Label_4"
        Me._Label_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_4.Size = New System.Drawing.Size(137, 13)
        Me._Label_4.TabIndex = 163
        Me._Label_4.Text = "(Max Size: 40, Single Line)"
        '
        '_Label_3
        '
        Me._Label_3.BackColor = System.Drawing.SystemColors.Control
        Me._Label_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_3.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_3, CType(3, Short))
        Me._Label_3.Location = New System.Drawing.Point(200, 160)
        Me._Label_3.Name = "_Label_3"
        Me._Label_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_3.Size = New System.Drawing.Size(137, 13)
        Me._Label_3.TabIndex = 162
        Me._Label_3.Text = "(Max Size: 40, Single Line)"
        '
        '_Label_11
        '
        Me._Label_11.BackColor = System.Drawing.SystemColors.Control
        Me._Label_11.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_11.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_11.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_11, CType(11, Short))
        Me._Label_11.Location = New System.Drawing.Point(200, 136)
        Me._Label_11.Name = "_Label_11"
        Me._Label_11.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_11.Size = New System.Drawing.Size(137, 13)
        Me._Label_11.TabIndex = 161
        Me._Label_11.Text = "(Max Size: 40, Single Line)"
        '
        '_Label_2
        '
        Me._Label_2.BackColor = System.Drawing.SystemColors.Control
        Me._Label_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_2, CType(2, Short))
        Me._Label_2.Location = New System.Drawing.Point(10, 20)
        Me._Label_2.Name = "_Label_2"
        Me._Label_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_2.Size = New System.Drawing.Size(45, 35)
        Me._Label_2.TabIndex = 160
        Me._Label_2.Text = "Alert Field 1"
        '
        '_Frame_14
        '
        Me._Frame_14.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_14.Controls.Add(Me._CmdDelete_16)
        Me._Frame_14.Controls.Add(Me._CmdDelete_15)
        Me._Frame_14.Controls.Add(Me._CmdDelete_14)
        Me._Frame_14.Controls.Add(Me._CmdDelete_13)
        Me._Frame_14.Controls.Add(Me._CmdDelete_12)
        Me._Frame_14.Controls.Add(Me._CmdDelete_11)
        Me._Frame_14.Controls.Add(Me._CmdDelete_10)
        Me._Frame_14.Controls.Add(Me._CmdDelete_9)
        Me._Frame_14.Controls.Add(Me._CboField_16)
        Me._Frame_14.Controls.Add(Me._CmdAdd_16)
        Me._Frame_14.Controls.Add(Me._CboField_15)
        Me._Frame_14.Controls.Add(Me._CmdAdd_15)
        Me._Frame_14.Controls.Add(Me._CboField_14)
        Me._Frame_14.Controls.Add(Me._CmdAdd_14)
        Me._Frame_14.Controls.Add(Me._CboField_13)
        Me._Frame_14.Controls.Add(Me._CmdAdd_13)
        Me._Frame_14.Controls.Add(Me._CboField_12)
        Me._Frame_14.Controls.Add(Me._CmdAdd_12)
        Me._Frame_14.Controls.Add(Me._CboField_11)
        Me._Frame_14.Controls.Add(Me._CmdAdd_11)
        Me._Frame_14.Controls.Add(Me._CboField_10)
        Me._Frame_14.Controls.Add(Me._CmdAdd_10)
        Me._Frame_14.Controls.Add(Me._CboField_9)
        Me._Frame_14.Controls.Add(Me._CmdAdd_9)
        Me._Frame_14.Controls.Add(Me._TxtLabel_16)
        Me._Frame_14.Controls.Add(Me._TxtLabel_15)
        Me._Frame_14.Controls.Add(Me._TxtLabel_14)
        Me._Frame_14.Controls.Add(Me._TxtLabel_13)
        Me._Frame_14.Controls.Add(Me._TxtLabel_12)
        Me._Frame_14.Controls.Add(Me._TxtLabel_11)
        Me._Frame_14.Controls.Add(Me._TxtLabel_10)
        Me._Frame_14.Controls.Add(Me._TxtLabel_9)
        Me._Frame_14.Controls.Add(Me._TxtAlert_1)
        Me._Frame_14.Controls.Add(Me._Label_27)
        Me._Frame_14.Controls.Add(Me._Label_26)
        Me._Frame_14.Controls.Add(Me._Label_25)
        Me._Frame_14.Controls.Add(Me._Label_24)
        Me._Frame_14.Controls.Add(Me._Label_23)
        Me._Frame_14.Controls.Add(Me._Label_22)
        Me._Frame_14.Controls.Add(Me._Label_21)
        Me._Frame_14.Controls.Add(Me._Label_20)
        Me._Frame_14.Controls.Add(Me._Label_19)
        Me._Frame_14.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me._Frame_14.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_14.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_14, CType(14, Short))
        Me._Frame_14.Location = New System.Drawing.Point(364, 80)
        Me._Frame_14.Name = "_Frame_14"
        Me._Frame_14.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_14.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_14.Size = New System.Drawing.Size(487, 327)
        Me._Frame_14.TabIndex = 159
        Me._Frame_14.TabStop = False
        Me._Frame_14.Text = "List Fields"
        '
        '_CmdDelete_16
        '
        Me._CmdDelete_16.BackColor = System.Drawing.SystemColors.Control
        Me._CmdDelete_16.Cursor = System.Windows.Forms.Cursors.Default
        Me._CmdDelete_16.Enabled = False
        Me._CmdDelete_16.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CmdDelete_16.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdDelete.SetIndex(Me._CmdDelete_16, CType(16, Short))
        Me._CmdDelete_16.Location = New System.Drawing.Point(464, 298)
        Me._CmdDelete_16.Name = "_CmdDelete_16"
        Me._CmdDelete_16.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CmdDelete_16.Size = New System.Drawing.Size(17, 21)
        Me._CmdDelete_16.TabIndex = 119
        Me._CmdDelete_16.Text = "X"
        Me._CmdDelete_16.UseVisualStyleBackColor = False
        '
        '_CmdDelete_15
        '
        Me._CmdDelete_15.BackColor = System.Drawing.SystemColors.Control
        Me._CmdDelete_15.Cursor = System.Windows.Forms.Cursors.Default
        Me._CmdDelete_15.Enabled = False
        Me._CmdDelete_15.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CmdDelete_15.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdDelete.SetIndex(Me._CmdDelete_15, CType(15, Short))
        Me._CmdDelete_15.Location = New System.Drawing.Point(464, 274)
        Me._CmdDelete_15.Name = "_CmdDelete_15"
        Me._CmdDelete_15.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CmdDelete_15.Size = New System.Drawing.Size(17, 21)
        Me._CmdDelete_15.TabIndex = 115
        Me._CmdDelete_15.Text = "X"
        Me._CmdDelete_15.UseVisualStyleBackColor = False
        '
        '_CmdDelete_14
        '
        Me._CmdDelete_14.BackColor = System.Drawing.SystemColors.Control
        Me._CmdDelete_14.Cursor = System.Windows.Forms.Cursors.Default
        Me._CmdDelete_14.Enabled = False
        Me._CmdDelete_14.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CmdDelete_14.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdDelete.SetIndex(Me._CmdDelete_14, CType(14, Short))
        Me._CmdDelete_14.Location = New System.Drawing.Point(464, 250)
        Me._CmdDelete_14.Name = "_CmdDelete_14"
        Me._CmdDelete_14.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CmdDelete_14.Size = New System.Drawing.Size(17, 21)
        Me._CmdDelete_14.TabIndex = 111
        Me._CmdDelete_14.Text = "X"
        Me._CmdDelete_14.UseVisualStyleBackColor = False
        '
        '_CmdDelete_13
        '
        Me._CmdDelete_13.BackColor = System.Drawing.SystemColors.Control
        Me._CmdDelete_13.Cursor = System.Windows.Forms.Cursors.Default
        Me._CmdDelete_13.Enabled = False
        Me._CmdDelete_13.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CmdDelete_13.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdDelete.SetIndex(Me._CmdDelete_13, CType(13, Short))
        Me._CmdDelete_13.Location = New System.Drawing.Point(464, 226)
        Me._CmdDelete_13.Name = "_CmdDelete_13"
        Me._CmdDelete_13.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CmdDelete_13.Size = New System.Drawing.Size(17, 21)
        Me._CmdDelete_13.TabIndex = 107
        Me._CmdDelete_13.Text = "X"
        Me._CmdDelete_13.UseVisualStyleBackColor = False
        '
        '_CmdDelete_12
        '
        Me._CmdDelete_12.BackColor = System.Drawing.SystemColors.Control
        Me._CmdDelete_12.Cursor = System.Windows.Forms.Cursors.Default
        Me._CmdDelete_12.Enabled = False
        Me._CmdDelete_12.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CmdDelete_12.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdDelete.SetIndex(Me._CmdDelete_12, CType(12, Short))
        Me._CmdDelete_12.Location = New System.Drawing.Point(464, 202)
        Me._CmdDelete_12.Name = "_CmdDelete_12"
        Me._CmdDelete_12.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CmdDelete_12.Size = New System.Drawing.Size(17, 21)
        Me._CmdDelete_12.TabIndex = 103
        Me._CmdDelete_12.Text = "X"
        Me._CmdDelete_12.UseVisualStyleBackColor = False
        '
        '_CmdDelete_11
        '
        Me._CmdDelete_11.BackColor = System.Drawing.SystemColors.Control
        Me._CmdDelete_11.Cursor = System.Windows.Forms.Cursors.Default
        Me._CmdDelete_11.Enabled = False
        Me._CmdDelete_11.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CmdDelete_11.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdDelete.SetIndex(Me._CmdDelete_11, CType(11, Short))
        Me._CmdDelete_11.Location = New System.Drawing.Point(464, 178)
        Me._CmdDelete_11.Name = "_CmdDelete_11"
        Me._CmdDelete_11.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CmdDelete_11.Size = New System.Drawing.Size(17, 21)
        Me._CmdDelete_11.TabIndex = 99
        Me._CmdDelete_11.Text = "X"
        Me._CmdDelete_11.UseVisualStyleBackColor = False
        '
        '_CmdDelete_10
        '
        Me._CmdDelete_10.BackColor = System.Drawing.SystemColors.Control
        Me._CmdDelete_10.Cursor = System.Windows.Forms.Cursors.Default
        Me._CmdDelete_10.Enabled = False
        Me._CmdDelete_10.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CmdDelete_10.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdDelete.SetIndex(Me._CmdDelete_10, CType(10, Short))
        Me._CmdDelete_10.Location = New System.Drawing.Point(464, 154)
        Me._CmdDelete_10.Name = "_CmdDelete_10"
        Me._CmdDelete_10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CmdDelete_10.Size = New System.Drawing.Size(17, 21)
        Me._CmdDelete_10.TabIndex = 95
        Me._CmdDelete_10.Text = "X"
        Me._CmdDelete_10.UseVisualStyleBackColor = False
        '
        '_CmdDelete_9
        '
        Me._CmdDelete_9.BackColor = System.Drawing.SystemColors.Control
        Me._CmdDelete_9.Cursor = System.Windows.Forms.Cursors.Default
        Me._CmdDelete_9.Enabled = False
        Me._CmdDelete_9.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CmdDelete_9.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdDelete.SetIndex(Me._CmdDelete_9, CType(9, Short))
        Me._CmdDelete_9.Location = New System.Drawing.Point(464, 130)
        Me._CmdDelete_9.Name = "_CmdDelete_9"
        Me._CmdDelete_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CmdDelete_9.Size = New System.Drawing.Size(17, 21)
        Me._CmdDelete_9.TabIndex = 91
        Me._CmdDelete_9.Text = "X"
        Me._CmdDelete_9.UseVisualStyleBackColor = False
        '
        '_CboField_16
        '
        Me._CboField_16.BackColor = System.Drawing.SystemColors.Window
        Me._CboField_16.Cursor = System.Windows.Forms.Cursors.Default
        Me._CboField_16.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._CboField_16.Enabled = False
        Me._CboField_16.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CboField_16.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboField.SetIndex(Me._CboField_16, CType(16, Short))
        Me._CboField_16.Location = New System.Drawing.Point(194, 298)
        Me._CboField_16.Name = "_CboField_16"
        Me._CboField_16.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CboField_16.Size = New System.Drawing.Size(247, 24)
        Me._CboField_16.Sorted = True
        Me._CboField_16.TabIndex = 117
        '
        '_CmdAdd_16
        '
        Me._CmdAdd_16.BackColor = System.Drawing.SystemColors.Control
        Me._CmdAdd_16.Cursor = System.Windows.Forms.Cursors.Default
        Me._CmdAdd_16.Enabled = False
        Me._CmdAdd_16.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CmdAdd_16.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdAdd.SetIndex(Me._CmdAdd_16, CType(16, Short))
        Me._CmdAdd_16.Location = New System.Drawing.Point(444, 298)
        Me._CmdAdd_16.Name = "_CmdAdd_16"
        Me._CmdAdd_16.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CmdAdd_16.Size = New System.Drawing.Size(17, 21)
        Me._CmdAdd_16.TabIndex = 118
        Me._CmdAdd_16.Text = "..."
        Me._CmdAdd_16.UseVisualStyleBackColor = False
        '
        '_CboField_15
        '
        Me._CboField_15.BackColor = System.Drawing.SystemColors.Window
        Me._CboField_15.Cursor = System.Windows.Forms.Cursors.Default
        Me._CboField_15.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._CboField_15.Enabled = False
        Me._CboField_15.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CboField_15.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboField.SetIndex(Me._CboField_15, CType(15, Short))
        Me._CboField_15.Location = New System.Drawing.Point(194, 274)
        Me._CboField_15.Name = "_CboField_15"
        Me._CboField_15.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CboField_15.Size = New System.Drawing.Size(247, 24)
        Me._CboField_15.Sorted = True
        Me._CboField_15.TabIndex = 113
        '
        '_CmdAdd_15
        '
        Me._CmdAdd_15.BackColor = System.Drawing.SystemColors.Control
        Me._CmdAdd_15.Cursor = System.Windows.Forms.Cursors.Default
        Me._CmdAdd_15.Enabled = False
        Me._CmdAdd_15.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CmdAdd_15.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdAdd.SetIndex(Me._CmdAdd_15, CType(15, Short))
        Me._CmdAdd_15.Location = New System.Drawing.Point(444, 274)
        Me._CmdAdd_15.Name = "_CmdAdd_15"
        Me._CmdAdd_15.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CmdAdd_15.Size = New System.Drawing.Size(17, 21)
        Me._CmdAdd_15.TabIndex = 114
        Me._CmdAdd_15.Text = "..."
        Me._CmdAdd_15.UseVisualStyleBackColor = False
        '
        '_CboField_14
        '
        Me._CboField_14.BackColor = System.Drawing.SystemColors.Window
        Me._CboField_14.Cursor = System.Windows.Forms.Cursors.Default
        Me._CboField_14.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._CboField_14.Enabled = False
        Me._CboField_14.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CboField_14.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboField.SetIndex(Me._CboField_14, CType(14, Short))
        Me._CboField_14.Location = New System.Drawing.Point(194, 250)
        Me._CboField_14.Name = "_CboField_14"
        Me._CboField_14.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CboField_14.Size = New System.Drawing.Size(247, 24)
        Me._CboField_14.Sorted = True
        Me._CboField_14.TabIndex = 109
        '
        '_CmdAdd_14
        '
        Me._CmdAdd_14.BackColor = System.Drawing.SystemColors.Control
        Me._CmdAdd_14.Cursor = System.Windows.Forms.Cursors.Default
        Me._CmdAdd_14.Enabled = False
        Me._CmdAdd_14.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CmdAdd_14.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdAdd.SetIndex(Me._CmdAdd_14, CType(14, Short))
        Me._CmdAdd_14.Location = New System.Drawing.Point(444, 250)
        Me._CmdAdd_14.Name = "_CmdAdd_14"
        Me._CmdAdd_14.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CmdAdd_14.Size = New System.Drawing.Size(17, 21)
        Me._CmdAdd_14.TabIndex = 110
        Me._CmdAdd_14.Text = "..."
        Me._CmdAdd_14.UseVisualStyleBackColor = False
        '
        '_CboField_13
        '
        Me._CboField_13.BackColor = System.Drawing.SystemColors.Window
        Me._CboField_13.Cursor = System.Windows.Forms.Cursors.Default
        Me._CboField_13.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._CboField_13.Enabled = False
        Me._CboField_13.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CboField_13.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboField.SetIndex(Me._CboField_13, CType(13, Short))
        Me._CboField_13.Location = New System.Drawing.Point(194, 226)
        Me._CboField_13.Name = "_CboField_13"
        Me._CboField_13.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CboField_13.Size = New System.Drawing.Size(247, 24)
        Me._CboField_13.Sorted = True
        Me._CboField_13.TabIndex = 105
        '
        '_CmdAdd_13
        '
        Me._CmdAdd_13.BackColor = System.Drawing.SystemColors.Control
        Me._CmdAdd_13.Cursor = System.Windows.Forms.Cursors.Default
        Me._CmdAdd_13.Enabled = False
        Me._CmdAdd_13.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CmdAdd_13.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdAdd.SetIndex(Me._CmdAdd_13, CType(13, Short))
        Me._CmdAdd_13.Location = New System.Drawing.Point(444, 226)
        Me._CmdAdd_13.Name = "_CmdAdd_13"
        Me._CmdAdd_13.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CmdAdd_13.Size = New System.Drawing.Size(17, 21)
        Me._CmdAdd_13.TabIndex = 106
        Me._CmdAdd_13.Text = "..."
        Me._CmdAdd_13.UseVisualStyleBackColor = False
        '
        '_CboField_12
        '
        Me._CboField_12.BackColor = System.Drawing.SystemColors.Window
        Me._CboField_12.Cursor = System.Windows.Forms.Cursors.Default
        Me._CboField_12.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._CboField_12.Enabled = False
        Me._CboField_12.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CboField_12.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboField.SetIndex(Me._CboField_12, CType(12, Short))
        Me._CboField_12.Location = New System.Drawing.Point(194, 202)
        Me._CboField_12.Name = "_CboField_12"
        Me._CboField_12.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CboField_12.Size = New System.Drawing.Size(247, 24)
        Me._CboField_12.Sorted = True
        Me._CboField_12.TabIndex = 101
        '
        '_CmdAdd_12
        '
        Me._CmdAdd_12.BackColor = System.Drawing.SystemColors.Control
        Me._CmdAdd_12.Cursor = System.Windows.Forms.Cursors.Default
        Me._CmdAdd_12.Enabled = False
        Me._CmdAdd_12.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CmdAdd_12.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdAdd.SetIndex(Me._CmdAdd_12, CType(12, Short))
        Me._CmdAdd_12.Location = New System.Drawing.Point(444, 202)
        Me._CmdAdd_12.Name = "_CmdAdd_12"
        Me._CmdAdd_12.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CmdAdd_12.Size = New System.Drawing.Size(17, 21)
        Me._CmdAdd_12.TabIndex = 102
        Me._CmdAdd_12.Text = "..."
        Me._CmdAdd_12.UseVisualStyleBackColor = False
        '
        '_CboField_11
        '
        Me._CboField_11.BackColor = System.Drawing.SystemColors.Window
        Me._CboField_11.Cursor = System.Windows.Forms.Cursors.Default
        Me._CboField_11.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._CboField_11.Enabled = False
        Me._CboField_11.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CboField_11.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboField.SetIndex(Me._CboField_11, CType(11, Short))
        Me._CboField_11.Location = New System.Drawing.Point(194, 178)
        Me._CboField_11.Name = "_CboField_11"
        Me._CboField_11.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CboField_11.Size = New System.Drawing.Size(247, 24)
        Me._CboField_11.Sorted = True
        Me._CboField_11.TabIndex = 97
        '
        '_CmdAdd_11
        '
        Me._CmdAdd_11.BackColor = System.Drawing.SystemColors.Control
        Me._CmdAdd_11.Cursor = System.Windows.Forms.Cursors.Default
        Me._CmdAdd_11.Enabled = False
        Me._CmdAdd_11.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CmdAdd_11.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdAdd.SetIndex(Me._CmdAdd_11, CType(11, Short))
        Me._CmdAdd_11.Location = New System.Drawing.Point(444, 178)
        Me._CmdAdd_11.Name = "_CmdAdd_11"
        Me._CmdAdd_11.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CmdAdd_11.Size = New System.Drawing.Size(17, 21)
        Me._CmdAdd_11.TabIndex = 98
        Me._CmdAdd_11.Text = "..."
        Me._CmdAdd_11.UseVisualStyleBackColor = False
        '
        '_CboField_10
        '
        Me._CboField_10.BackColor = System.Drawing.SystemColors.Window
        Me._CboField_10.Cursor = System.Windows.Forms.Cursors.Default
        Me._CboField_10.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._CboField_10.Enabled = False
        Me._CboField_10.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CboField_10.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboField.SetIndex(Me._CboField_10, CType(10, Short))
        Me._CboField_10.Location = New System.Drawing.Point(194, 154)
        Me._CboField_10.Name = "_CboField_10"
        Me._CboField_10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CboField_10.Size = New System.Drawing.Size(247, 24)
        Me._CboField_10.Sorted = True
        Me._CboField_10.TabIndex = 93
        '
        '_CmdAdd_10
        '
        Me._CmdAdd_10.BackColor = System.Drawing.SystemColors.Control
        Me._CmdAdd_10.Cursor = System.Windows.Forms.Cursors.Default
        Me._CmdAdd_10.Enabled = False
        Me._CmdAdd_10.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CmdAdd_10.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdAdd.SetIndex(Me._CmdAdd_10, CType(10, Short))
        Me._CmdAdd_10.Location = New System.Drawing.Point(444, 154)
        Me._CmdAdd_10.Name = "_CmdAdd_10"
        Me._CmdAdd_10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CmdAdd_10.Size = New System.Drawing.Size(17, 21)
        Me._CmdAdd_10.TabIndex = 94
        Me._CmdAdd_10.Text = "..."
        Me._CmdAdd_10.UseVisualStyleBackColor = False
        '
        '_CboField_9
        '
        Me._CboField_9.BackColor = System.Drawing.SystemColors.Window
        Me._CboField_9.Cursor = System.Windows.Forms.Cursors.Default
        Me._CboField_9.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._CboField_9.Enabled = False
        Me._CboField_9.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CboField_9.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboField.SetIndex(Me._CboField_9, CType(9, Short))
        Me._CboField_9.Location = New System.Drawing.Point(194, 130)
        Me._CboField_9.Name = "_CboField_9"
        Me._CboField_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CboField_9.Size = New System.Drawing.Size(247, 24)
        Me._CboField_9.Sorted = True
        Me._CboField_9.TabIndex = 89
        '
        '_CmdAdd_9
        '
        Me._CmdAdd_9.BackColor = System.Drawing.SystemColors.Control
        Me._CmdAdd_9.Cursor = System.Windows.Forms.Cursors.Default
        Me._CmdAdd_9.Enabled = False
        Me._CmdAdd_9.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CmdAdd_9.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdAdd.SetIndex(Me._CmdAdd_9, CType(9, Short))
        Me._CmdAdd_9.Location = New System.Drawing.Point(444, 130)
        Me._CmdAdd_9.Name = "_CmdAdd_9"
        Me._CmdAdd_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CmdAdd_9.Size = New System.Drawing.Size(17, 21)
        Me._CmdAdd_9.TabIndex = 90
        Me._CmdAdd_9.Text = "..."
        Me._CmdAdd_9.UseVisualStyleBackColor = False
        '
        '_TxtLabel_16
        '
        Me._TxtLabel_16.AcceptsReturn = True
        Me._TxtLabel_16.BackColor = System.Drawing.SystemColors.Window
        Me._TxtLabel_16.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._TxtLabel_16.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._TxtLabel_16.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtLabel.SetIndex(Me._TxtLabel_16, CType(16, Short))
        Me._TxtLabel_16.Location = New System.Drawing.Point(64, 298)
        Me._TxtLabel_16.MaxLength = 20
        Me._TxtLabel_16.Name = "_TxtLabel_16"
        Me._TxtLabel_16.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._TxtLabel_16.Size = New System.Drawing.Size(125, 23)
        Me._TxtLabel_16.TabIndex = 116
        '
        '_TxtLabel_15
        '
        Me._TxtLabel_15.AcceptsReturn = True
        Me._TxtLabel_15.BackColor = System.Drawing.SystemColors.Window
        Me._TxtLabel_15.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._TxtLabel_15.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._TxtLabel_15.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtLabel.SetIndex(Me._TxtLabel_15, CType(15, Short))
        Me._TxtLabel_15.Location = New System.Drawing.Point(64, 274)
        Me._TxtLabel_15.MaxLength = 20
        Me._TxtLabel_15.Name = "_TxtLabel_15"
        Me._TxtLabel_15.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._TxtLabel_15.Size = New System.Drawing.Size(125, 23)
        Me._TxtLabel_15.TabIndex = 112
        '
        '_TxtLabel_14
        '
        Me._TxtLabel_14.AcceptsReturn = True
        Me._TxtLabel_14.BackColor = System.Drawing.SystemColors.Window
        Me._TxtLabel_14.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._TxtLabel_14.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._TxtLabel_14.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtLabel.SetIndex(Me._TxtLabel_14, CType(14, Short))
        Me._TxtLabel_14.Location = New System.Drawing.Point(64, 250)
        Me._TxtLabel_14.MaxLength = 20
        Me._TxtLabel_14.Name = "_TxtLabel_14"
        Me._TxtLabel_14.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._TxtLabel_14.Size = New System.Drawing.Size(125, 23)
        Me._TxtLabel_14.TabIndex = 108
        '
        '_TxtLabel_13
        '
        Me._TxtLabel_13.AcceptsReturn = True
        Me._TxtLabel_13.BackColor = System.Drawing.SystemColors.Window
        Me._TxtLabel_13.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._TxtLabel_13.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._TxtLabel_13.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtLabel.SetIndex(Me._TxtLabel_13, CType(13, Short))
        Me._TxtLabel_13.Location = New System.Drawing.Point(64, 226)
        Me._TxtLabel_13.MaxLength = 20
        Me._TxtLabel_13.Name = "_TxtLabel_13"
        Me._TxtLabel_13.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._TxtLabel_13.Size = New System.Drawing.Size(125, 23)
        Me._TxtLabel_13.TabIndex = 104
        '
        '_TxtLabel_12
        '
        Me._TxtLabel_12.AcceptsReturn = True
        Me._TxtLabel_12.BackColor = System.Drawing.SystemColors.Window
        Me._TxtLabel_12.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._TxtLabel_12.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._TxtLabel_12.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtLabel.SetIndex(Me._TxtLabel_12, CType(12, Short))
        Me._TxtLabel_12.Location = New System.Drawing.Point(64, 202)
        Me._TxtLabel_12.MaxLength = 20
        Me._TxtLabel_12.Name = "_TxtLabel_12"
        Me._TxtLabel_12.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._TxtLabel_12.Size = New System.Drawing.Size(125, 23)
        Me._TxtLabel_12.TabIndex = 100
        '
        '_TxtLabel_11
        '
        Me._TxtLabel_11.AcceptsReturn = True
        Me._TxtLabel_11.BackColor = System.Drawing.SystemColors.Window
        Me._TxtLabel_11.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._TxtLabel_11.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._TxtLabel_11.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtLabel.SetIndex(Me._TxtLabel_11, CType(11, Short))
        Me._TxtLabel_11.Location = New System.Drawing.Point(64, 178)
        Me._TxtLabel_11.MaxLength = 20
        Me._TxtLabel_11.Name = "_TxtLabel_11"
        Me._TxtLabel_11.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._TxtLabel_11.Size = New System.Drawing.Size(125, 23)
        Me._TxtLabel_11.TabIndex = 96
        '
        '_TxtLabel_10
        '
        Me._TxtLabel_10.AcceptsReturn = True
        Me._TxtLabel_10.BackColor = System.Drawing.SystemColors.Window
        Me._TxtLabel_10.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._TxtLabel_10.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._TxtLabel_10.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtLabel.SetIndex(Me._TxtLabel_10, CType(10, Short))
        Me._TxtLabel_10.Location = New System.Drawing.Point(64, 154)
        Me._TxtLabel_10.MaxLength = 20
        Me._TxtLabel_10.Name = "_TxtLabel_10"
        Me._TxtLabel_10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._TxtLabel_10.Size = New System.Drawing.Size(125, 23)
        Me._TxtLabel_10.TabIndex = 92
        '
        '_TxtLabel_9
        '
        Me._TxtLabel_9.AcceptsReturn = True
        Me._TxtLabel_9.BackColor = System.Drawing.SystemColors.Window
        Me._TxtLabel_9.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._TxtLabel_9.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._TxtLabel_9.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtLabel.SetIndex(Me._TxtLabel_9, CType(9, Short))
        Me._TxtLabel_9.Location = New System.Drawing.Point(64, 130)
        Me._TxtLabel_9.MaxLength = 20
        Me._TxtLabel_9.Name = "_TxtLabel_9"
        Me._TxtLabel_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._TxtLabel_9.Size = New System.Drawing.Size(125, 23)
        Me._TxtLabel_9.TabIndex = 88
        '
        '_TxtAlert_1
        '
        Me._TxtAlert_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtAlert.SetIndex(Me._TxtAlert_1, CType(1, Short))
        Me._TxtAlert_1.Location = New System.Drawing.Point(64, 18)
        Me._TxtAlert_1.MaxLength = 255
        Me._TxtAlert_1.Name = "_TxtAlert_1"
        Me._TxtAlert_1.RightMargin = 260
        Me._TxtAlert_1.Size = New System.Drawing.Size(281, 107)
        Me._TxtAlert_1.TabIndex = 87
        Me._TxtAlert_1.Text = ""
        '
        '_Label_27
        '
        Me._Label_27.BackColor = System.Drawing.SystemColors.Control
        Me._Label_27.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_27.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_27.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_27, CType(27, Short))
        Me._Label_27.Location = New System.Drawing.Point(10, 302)
        Me._Label_27.Name = "_Label_27"
        Me._Label_27.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_27.Size = New System.Drawing.Size(59, 13)
        Me._Label_27.TabIndex = 185
        Me._Label_27.Text = "Label 16"
        '
        '_Label_26
        '
        Me._Label_26.BackColor = System.Drawing.SystemColors.Control
        Me._Label_26.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_26.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_26.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_26, CType(26, Short))
        Me._Label_26.Location = New System.Drawing.Point(10, 278)
        Me._Label_26.Name = "_Label_26"
        Me._Label_26.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_26.Size = New System.Drawing.Size(59, 13)
        Me._Label_26.TabIndex = 184
        Me._Label_26.Text = "Label 15"
        '
        '_Label_25
        '
        Me._Label_25.BackColor = System.Drawing.SystemColors.Control
        Me._Label_25.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_25.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_25.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_25, CType(25, Short))
        Me._Label_25.Location = New System.Drawing.Point(10, 254)
        Me._Label_25.Name = "_Label_25"
        Me._Label_25.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_25.Size = New System.Drawing.Size(59, 13)
        Me._Label_25.TabIndex = 183
        Me._Label_25.Text = "Label 14"
        '
        '_Label_24
        '
        Me._Label_24.BackColor = System.Drawing.SystemColors.Control
        Me._Label_24.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_24.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_24.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_24, CType(24, Short))
        Me._Label_24.Location = New System.Drawing.Point(10, 230)
        Me._Label_24.Name = "_Label_24"
        Me._Label_24.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_24.Size = New System.Drawing.Size(59, 13)
        Me._Label_24.TabIndex = 182
        Me._Label_24.Text = "Label 13"
        '
        '_Label_23
        '
        Me._Label_23.BackColor = System.Drawing.SystemColors.Control
        Me._Label_23.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_23.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_23.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_23, CType(23, Short))
        Me._Label_23.Location = New System.Drawing.Point(10, 206)
        Me._Label_23.Name = "_Label_23"
        Me._Label_23.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_23.Size = New System.Drawing.Size(59, 13)
        Me._Label_23.TabIndex = 181
        Me._Label_23.Text = "Label 12"
        '
        '_Label_22
        '
        Me._Label_22.BackColor = System.Drawing.SystemColors.Control
        Me._Label_22.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_22.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_22.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_22, CType(22, Short))
        Me._Label_22.Location = New System.Drawing.Point(10, 182)
        Me._Label_22.Name = "_Label_22"
        Me._Label_22.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_22.Size = New System.Drawing.Size(59, 13)
        Me._Label_22.TabIndex = 180
        Me._Label_22.Text = "Label 11"
        '
        '_Label_21
        '
        Me._Label_21.BackColor = System.Drawing.SystemColors.Control
        Me._Label_21.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_21.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_21.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_21, CType(21, Short))
        Me._Label_21.Location = New System.Drawing.Point(10, 158)
        Me._Label_21.Name = "_Label_21"
        Me._Label_21.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_21.Size = New System.Drawing.Size(59, 13)
        Me._Label_21.TabIndex = 179
        Me._Label_21.Text = "Label 10"
        '
        '_Label_20
        '
        Me._Label_20.BackColor = System.Drawing.SystemColors.Control
        Me._Label_20.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_20.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_20.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_20, CType(20, Short))
        Me._Label_20.Location = New System.Drawing.Point(10, 134)
        Me._Label_20.Name = "_Label_20"
        Me._Label_20.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_20.Size = New System.Drawing.Size(59, 13)
        Me._Label_20.TabIndex = 178
        Me._Label_20.Text = "Label 9"
        '
        '_Label_19
        '
        Me._Label_19.BackColor = System.Drawing.SystemColors.Control
        Me._Label_19.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_19.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_19.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_19, CType(19, Short))
        Me._Label_19.Location = New System.Drawing.Point(8, 20)
        Me._Label_19.Name = "_Label_19"
        Me._Label_19.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_19.Size = New System.Drawing.Size(45, 35)
        Me._Label_19.TabIndex = 177
        Me._Label_19.Text = "Alert Field 2"
        '
        '_TabServiceLevel_TabPage4
        '
        Me._TabServiceLevel_TabPage4.Controls.Add(Me._Picture1_2)
        Me._TabServiceLevel_TabPage4.Location = New System.Drawing.Point(4, 22)
        Me._TabServiceLevel_TabPage4.Name = "_TabServiceLevel_TabPage4"
        Me._TabServiceLevel_TabPage4.Size = New System.Drawing.Size(871, 512)
        Me._TabServiceLevel_TabPage4.TabIndex = 4
        Me._TabServiceLevel_TabPage4.Text = "Secondary Data"
        '
        '_Picture1_2
        '
        Me._Picture1_2.BackColor = System.Drawing.SystemColors.Control
        Me._Picture1_2.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me._Picture1_2.Controls.Add(Me.SSTab1)
        Me._Picture1_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._Picture1_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Picture1_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Picture1.SetIndex(Me._Picture1_2, CType(2, Short))
        Me._Picture1_2.Location = New System.Drawing.Point(8, 24)
        Me._Picture1_2.Name = "_Picture1_2"
        Me._Picture1_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Picture1_2.Size = New System.Drawing.Size(841, 385)
        Me._Picture1_2.TabIndex = 221
        Me._Picture1_2.TabStop = True
        '
        'SSTab1
        '
        Me.SSTab1.Controls.Add(Me._SSTab1_TabPage0)
        Me.SSTab1.Controls.Add(Me._SSTab1_TabPage1)
        Me.SSTab1.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.SSTab1.ItemSize = New System.Drawing.Size(42, 18)
        Me.SSTab1.Location = New System.Drawing.Point(0, 0)
        Me.SSTab1.Name = "SSTab1"
        Me.SSTab1.SelectedIndex = 1
        Me.SSTab1.Size = New System.Drawing.Size(838, 381)
        Me.SSTab1.TabIndex = 222
        '
        '_SSTab1_TabPage0
        '
        Me._SSTab1_TabPage0.Controls.Add(Me.fmEyeCareReminder)
        Me._SSTab1_TabPage0.Controls.Add(Me._Frame_15)
        Me._SSTab1_TabPage0.Controls.Add(Me._Frame_16)
        Me._SSTab1_TabPage0.Location = New System.Drawing.Point(4, 22)
        Me._SSTab1_TabPage0.Name = "_SSTab1_TabPage0"
        Me._SSTab1_TabPage0.Size = New System.Drawing.Size(830, 355)
        Me._SSTab1_TabPage0.TabIndex = 0
        Me._SSTab1_TabPage0.Text = "General"
        '
        'fmEyeCareReminder
        '
        Me.fmEyeCareReminder.BackColor = System.Drawing.SystemColors.Control
        Me.fmEyeCareReminder.Controls.Add(Me.txtEyeCareReminder)
        Me.fmEyeCareReminder.Controls.Add(Me.lblEyCareReminder)
        Me.fmEyeCareReminder.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.fmEyeCareReminder.ForeColor = System.Drawing.SystemColors.ControlText
        Me.fmEyeCareReminder.Location = New System.Drawing.Point(496, 63)
        Me.fmEyeCareReminder.Name = "fmEyeCareReminder"
        Me.fmEyeCareReminder.Padding = New System.Windows.Forms.Padding(0)
        Me.fmEyeCareReminder.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.fmEyeCareReminder.Size = New System.Drawing.Size(329, 273)
        Me.fmEyeCareReminder.TabIndex = 321
        Me.fmEyeCareReminder.TabStop = False
        '
        'txtEyeCareReminder
        '
        Me.txtEyeCareReminder.AcceptsReturn = True
        Me.txtEyeCareReminder.BackColor = System.Drawing.SystemColors.Window
        Me.txtEyeCareReminder.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtEyeCareReminder.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtEyeCareReminder.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtEyeCareReminder.Location = New System.Drawing.Point(8, 32)
        Me.txtEyeCareReminder.MaxLength = 255
        Me.txtEyeCareReminder.Multiline = True
        Me.txtEyeCareReminder.Name = "txtEyeCareReminder"
        Me.txtEyeCareReminder.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtEyeCareReminder.ScrollBars = System.Windows.Forms.ScrollBars.Vertical
        Me.txtEyeCareReminder.Size = New System.Drawing.Size(313, 81)
        Me.txtEyeCareReminder.TabIndex = 323
        '
        'lblEyCareReminder
        '
        Me.lblEyCareReminder.BackColor = System.Drawing.SystemColors.Control
        Me.lblEyCareReminder.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblEyCareReminder.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblEyCareReminder.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblEyCareReminder.Location = New System.Drawing.Point(8, 16)
        Me.lblEyCareReminder.Name = "lblEyCareReminder"
        Me.lblEyCareReminder.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblEyCareReminder.Size = New System.Drawing.Size(201, 17)
        Me.lblEyCareReminder.TabIndex = 322
        Me.lblEyCareReminder.Text = "Eye Care Reminder"
        '
        '_Frame_15
        '
        Me._Frame_15.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_15.Controls.Add(Me.TxtTBIPrefix)
        Me._Frame_15.Controls.Add(Me.ChkHemodilution)
        Me._Frame_15.Controls.Add(Me.ChkSecondaryNote)
        Me._Frame_15.Controls.Add(Me.TxtSecondaryAlert)
        Me._Frame_15.Controls.Add(Me.LblTBIPrefix)
        Me._Frame_15.Controls.Add(Me._Label_43)
        Me._Frame_15.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me._Frame_15.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_15.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_15, CType(15, Short))
        Me._Frame_15.Location = New System.Drawing.Point(8, 63)
        Me._Frame_15.Name = "_Frame_15"
        Me._Frame_15.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_15.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_15.Size = New System.Drawing.Size(475, 277)
        Me._Frame_15.TabIndex = 304
        Me._Frame_15.TabStop = False
        '
        'TxtTBIPrefix
        '
        Me.TxtTBIPrefix.AcceptsReturn = True
        Me.TxtTBIPrefix.BackColor = System.Drawing.SystemColors.Window
        Me.TxtTBIPrefix.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtTBIPrefix.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtTBIPrefix.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtTBIPrefix.Location = New System.Drawing.Point(378, 83)
        Me.TxtTBIPrefix.MaxLength = 2
        Me.TxtTBIPrefix.Name = "TxtTBIPrefix"
        Me.TxtTBIPrefix.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtTBIPrefix.Size = New System.Drawing.Size(39, 23)
        Me.TxtTBIPrefix.TabIndex = 349
        '
        'ChkHemodilution
        '
        Me.ChkHemodilution.BackColor = System.Drawing.SystemColors.Control
        Me.ChkHemodilution.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkHemodilution.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkHemodilution.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkHemodilution.Location = New System.Drawing.Point(298, 50)
        Me.ChkHemodilution.Name = "ChkHemodilution"
        Me.ChkHemodilution.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkHemodilution.Size = New System.Drawing.Size(165, 17)
        Me.ChkHemodilution.TabIndex = 306
        Me.ChkHemodilution.Text = "Hemodilution Calculation"
        Me.ChkHemodilution.UseVisualStyleBackColor = False
        '
        'ChkSecondaryNote
        '
        Me.ChkSecondaryNote.BackColor = System.Drawing.SystemColors.Control
        Me.ChkSecondaryNote.Checked = True
        Me.ChkSecondaryNote.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkSecondaryNote.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkSecondaryNote.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkSecondaryNote.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkSecondaryNote.Location = New System.Drawing.Point(298, 34)
        Me.ChkSecondaryNote.Name = "ChkSecondaryNote"
        Me.ChkSecondaryNote.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkSecondaryNote.Size = New System.Drawing.Size(171, 17)
        Me.ChkSecondaryNote.TabIndex = 305
        Me.ChkSecondaryNote.Text = "Secondary Screening History"
        Me.ChkSecondaryNote.UseVisualStyleBackColor = False
        '
        'TxtSecondaryAlert
        '
        Me.TxtSecondaryAlert.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtSecondaryAlert.Location = New System.Drawing.Point(8, 34)
        Me.TxtSecondaryAlert.MaxLength = 749
        Me.TxtSecondaryAlert.Name = "TxtSecondaryAlert"
        Me.TxtSecondaryAlert.RightMargin = 260
        Me.TxtSecondaryAlert.Size = New System.Drawing.Size(281, 231)
        Me.TxtSecondaryAlert.TabIndex = 307
        Me.TxtSecondaryAlert.TabStop = False
        Me.TxtSecondaryAlert.Text = ""
        '
        'LblTBIPrefix
        '
        Me.LblTBIPrefix.BackColor = System.Drawing.SystemColors.Control
        Me.LblTBIPrefix.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblTBIPrefix.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblTBIPrefix.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblTBIPrefix.Location = New System.Drawing.Point(304, 85)
        Me.LblTBIPrefix.Name = "LblTBIPrefix"
        Me.LblTBIPrefix.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblTBIPrefix.Size = New System.Drawing.Size(71, 21)
        Me.LblTBIPrefix.TabIndex = 350
        Me.LblTBIPrefix.Text = "CTDN # Prefix"
        '
        '_Label_43
        '
        Me._Label_43.AutoSize = True
        Me._Label_43.BackColor = System.Drawing.SystemColors.Control
        Me._Label_43.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_43.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_43.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_43, CType(43, Short))
        Me._Label_43.Location = New System.Drawing.Point(10, 16)
        Me._Label_43.Name = "_Label_43"
        Me._Label_43.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_43.Size = New System.Drawing.Size(108, 16)
        Me._Label_43.TabIndex = 308
        Me._Label_43.Text = "Secondary Alert"
        '
        '_Frame_16
        '
        Me._Frame_16.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_16.Controls.Add(Me.ChkSecondary)
        Me._Frame_16.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me._Frame_16.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_16.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_16, CType(16, Short))
        Me._Frame_16.Location = New System.Drawing.Point(8, 15)
        Me._Frame_16.Name = "_Frame_16"
        Me._Frame_16.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_16.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_16.Size = New System.Drawing.Size(299, 47)
        Me._Frame_16.TabIndex = 302
        Me._Frame_16.TabStop = False
        '
        'ChkSecondary
        '
        Me.ChkSecondary.BackColor = System.Drawing.SystemColors.Control
        Me.ChkSecondary.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkSecondary.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkSecondary.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkSecondary.Location = New System.Drawing.Point(10, 12)
        Me.ChkSecondary.Name = "ChkSecondary"
        Me.ChkSecondary.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkSecondary.Size = New System.Drawing.Size(281, 27)
        Me.ChkSecondary.TabIndex = 303
        Me.ChkSecondary.Text = "Enable Secondary Tab"
        Me.ChkSecondary.UseVisualStyleBackColor = False
        '
        '_SSTab1_TabPage1
        '
        Me._SSTab1_TabPage1.Controls.Add(Me.tvwTree)
        Me._SSTab1_TabPage1.Controls.Add(Me.cmdExpandAll)
        Me._SSTab1_TabPage1.Controls.Add(Me.chkRecurseChecks)
        Me._SSTab1_TabPage1.Location = New System.Drawing.Point(4, 22)
        Me._SSTab1_TabPage1.Name = "_SSTab1_TabPage1"
        Me._SSTab1_TabPage1.Size = New System.Drawing.Size(830, 355)
        Me._SSTab1_TabPage1.TabIndex = 1
        Me._SSTab1_TabPage1.Text = "Data Field Availability"
        '
        'tvwTree
        '
        Me.tvwTree.CheckBoxes = True
        Me.tvwTree.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.tvwTree.LabelEdit = True
        Me.tvwTree.Location = New System.Drawing.Point(8, 11)
        Me.tvwTree.Name = "tvwTree"
        TreeNode1.Name = "Node0"
        TreeNode1.Text = "Node0"
        Me.tvwTree.Nodes.AddRange(New System.Windows.Forms.TreeNode() {TreeNode1})
        Me.tvwTree.Size = New System.Drawing.Size(281, 336)
        Me.tvwTree.TabIndex = 299
        '
        'cmdExpandAll
        '
        Me.cmdExpandAll.BackColor = System.Drawing.SystemColors.Control
        Me.cmdExpandAll.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdExpandAll.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdExpandAll.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdExpandAll.Location = New System.Drawing.Point(304, 32)
        Me.cmdExpandAll.Name = "cmdExpandAll"
        Me.cmdExpandAll.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdExpandAll.Size = New System.Drawing.Size(81, 25)
        Me.cmdExpandAll.TabIndex = 309
        Me.cmdExpandAll.Text = "Expand All"
        Me.cmdExpandAll.UseVisualStyleBackColor = False
        '
        'chkRecurseChecks
        '
        Me.chkRecurseChecks.BackColor = System.Drawing.SystemColors.Control
        Me.chkRecurseChecks.Cursor = System.Windows.Forms.Cursors.Default
        Me.chkRecurseChecks.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.chkRecurseChecks.ForeColor = System.Drawing.SystemColors.ControlText
        Me.chkRecurseChecks.Location = New System.Drawing.Point(304, 72)
        Me.chkRecurseChecks.Name = "chkRecurseChecks"
        Me.chkRecurseChecks.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.chkRecurseChecks.Size = New System.Drawing.Size(109, 17)
        Me.chkRecurseChecks.TabIndex = 310
        Me.chkRecurseChecks.Text = "Recurse Checks"
        Me.chkRecurseChecks.UseVisualStyleBackColor = False
        '
        '_TabServiceLevel_TabPage5
        '
        Me._TabServiceLevel_TabPage5.Controls.Add(Me._Frame_17)
        Me._TabServiceLevel_TabPage5.Controls.Add(Me._Frame_18)
        Me._TabServiceLevel_TabPage5.Controls.Add(Me.Frame1)
        Me._TabServiceLevel_TabPage5.Controls.Add(Me.fmDataSource)
        Me._TabServiceLevel_TabPage5.Location = New System.Drawing.Point(4, 22)
        Me._TabServiceLevel_TabPage5.Name = "_TabServiceLevel_TabPage5"
        Me._TabServiceLevel_TabPage5.Size = New System.Drawing.Size(871, 512)
        Me._TabServiceLevel_TabPage5.TabIndex = 5
        Me._TabServiceLevel_TabPage5.Text = "Donor Registry"
        '
        '_Frame_17
        '
        Me._Frame_17.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_17.Controls.Add(Me._rbtnIntent_0)
        Me._Frame_17.Controls.Add(Me._rbtnIntent_1)
        Me._Frame_17.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me._Frame_17.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_17.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_17, CType(17, Short))
        Me._Frame_17.Location = New System.Drawing.Point(8, 32)
        Me._Frame_17.Name = "_Frame_17"
        Me._Frame_17.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_17.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_17.Size = New System.Drawing.Size(105, 65)
        Me._Frame_17.TabIndex = 201
        Me._Frame_17.TabStop = False
        Me._Frame_17.Text = "Verification Type"
        '
        '_rbtnIntent_0
        '
        Me._rbtnIntent_0.BackColor = System.Drawing.SystemColors.Control
        Me._rbtnIntent_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._rbtnIntent_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._rbtnIntent_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.rbtnIntent.SetIndex(Me._rbtnIntent_0, CType(0, Short))
        Me._rbtnIntent_0.Location = New System.Drawing.Point(8, 40)
        Me._rbtnIntent_0.Name = "_rbtnIntent_0"
        Me._rbtnIntent_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._rbtnIntent_0.Size = New System.Drawing.Size(89, 20)
        Me._rbtnIntent_0.TabIndex = 203
        Me._rbtnIntent_0.TabStop = True
        Me._rbtnIntent_0.Text = "Donor Intent"
        Me._rbtnIntent_0.UseVisualStyleBackColor = False
        '
        '_rbtnIntent_1
        '
        Me._rbtnIntent_1.BackColor = System.Drawing.SystemColors.Control
        Me._rbtnIntent_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._rbtnIntent_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._rbtnIntent_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.rbtnIntent.SetIndex(Me._rbtnIntent_1, CType(1, Short))
        Me._rbtnIntent_1.Location = New System.Drawing.Point(8, 16)
        Me._rbtnIntent_1.Name = "_rbtnIntent_1"
        Me._rbtnIntent_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._rbtnIntent_1.Size = New System.Drawing.Size(89, 17)
        Me._rbtnIntent_1.TabIndex = 202
        Me._rbtnIntent_1.TabStop = True
        Me._rbtnIntent_1.Text = "No Registry"
        Me._rbtnIntent_1.UseVisualStyleBackColor = False
        '
        '_Frame_18
        '
        Me._Frame_18.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_18.Controls.Add(Me._Frame_19)
        Me._Frame_18.Controls.Add(Me.txtNurseScript)
        Me._Frame_18.Controls.Add(Me._Lable_7)
        Me._Frame_18.Controls.Add(Me.lblNurseScript)
        Me._Frame_18.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me._Frame_18.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_18.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_18, CType(18, Short))
        Me._Frame_18.Location = New System.Drawing.Point(120, 32)
        Me._Frame_18.Name = "_Frame_18"
        Me._Frame_18.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_18.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_18.Size = New System.Drawing.Size(281, 385)
        Me._Frame_18.TabIndex = 204
        Me._Frame_18.TabStop = False
        Me._Frame_18.Text = "Donor Intent"
        '
        '_Frame_19
        '
        Me._Frame_19.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_19.Controls.Add(Me.txtDocumentName)
        Me._Frame_19.Controls.Add(Me.txtRetries)
        Me._Frame_19.Controls.Add(Me.cmbFaxNumber)
        Me._Frame_19.Controls.Add(Me.cmbOrganization)
        Me._Frame_19.Controls.Add(Me.cmbPerson)
        Me._Frame_19.Controls.Add(Me.chkFax)
        Me._Frame_19.Controls.Add(Me.lblDocumentName)
        Me._Frame_19.Controls.Add(Me.lblRetries)
        Me._Frame_19.Controls.Add(Me.lblFaxNumber)
        Me._Frame_19.Controls.Add(Me.lblOrganization)
        Me._Frame_19.Controls.Add(Me.lblPerson)
        Me._Frame_19.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me._Frame_19.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_19.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_19, CType(19, Short))
        Me._Frame_19.Location = New System.Drawing.Point(8, 128)
        Me._Frame_19.Name = "_Frame_19"
        Me._Frame_19.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_19.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_19.Size = New System.Drawing.Size(265, 249)
        Me._Frame_19.TabIndex = 207
        Me._Frame_19.TabStop = False
        Me._Frame_19.Text = "Fax"
        '
        'txtDocumentName
        '
        Me.txtDocumentName.AcceptsReturn = True
        Me.txtDocumentName.BackColor = System.Drawing.SystemColors.Window
        Me.txtDocumentName.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtDocumentName.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtDocumentName.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtDocumentName.Location = New System.Drawing.Point(60, 152)
        Me.txtDocumentName.MaxLength = 0
        Me.txtDocumentName.Name = "txtDocumentName"
        Me.txtDocumentName.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtDocumentName.Size = New System.Drawing.Size(193, 23)
        Me.txtDocumentName.TabIndex = 218
        '
        'txtRetries
        '
        Me.txtRetries.AcceptsReturn = True
        Me.txtRetries.BackColor = System.Drawing.SystemColors.Window
        Me.txtRetries.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtRetries.Enabled = False
        Me.txtRetries.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtRetries.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtRetries.Location = New System.Drawing.Point(60, 184)
        Me.txtRetries.MaxLength = 0
        Me.txtRetries.Name = "txtRetries"
        Me.txtRetries.ReadOnly = True
        Me.txtRetries.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtRetries.Size = New System.Drawing.Size(33, 23)
        Me.txtRetries.TabIndex = 217
        Me.txtRetries.Text = "5"
        '
        'cmbFaxNumber
        '
        Me.cmbFaxNumber.BackColor = System.Drawing.SystemColors.Window
        Me.cmbFaxNumber.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmbFaxNumber.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cmbFaxNumber.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmbFaxNumber.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cmbFaxNumber.Location = New System.Drawing.Point(60, 120)
        Me.cmbFaxNumber.Name = "cmbFaxNumber"
        Me.cmbFaxNumber.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmbFaxNumber.Size = New System.Drawing.Size(169, 24)
        Me.cmbFaxNumber.TabIndex = 214
        '
        'cmbOrganization
        '
        Me.cmbOrganization.BackColor = System.Drawing.SystemColors.Window
        Me.cmbOrganization.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmbOrganization.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cmbOrganization.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmbOrganization.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cmbOrganization.Location = New System.Drawing.Point(60, 88)
        Me.cmbOrganization.Name = "cmbOrganization"
        Me.cmbOrganization.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmbOrganization.Size = New System.Drawing.Size(201, 24)
        Me.cmbOrganization.TabIndex = 212
        '
        'cmbPerson
        '
        Me.cmbPerson.BackColor = System.Drawing.SystemColors.Window
        Me.cmbPerson.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmbPerson.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cmbPerson.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmbPerson.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cmbPerson.Location = New System.Drawing.Point(60, 56)
        Me.cmbPerson.Name = "cmbPerson"
        Me.cmbPerson.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmbPerson.Size = New System.Drawing.Size(201, 24)
        Me.cmbPerson.TabIndex = 209
        '
        'chkFax
        '
        Me.chkFax.BackColor = System.Drawing.SystemColors.Control
        Me.chkFax.Cursor = System.Windows.Forms.Cursors.Default
        Me.chkFax.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.chkFax.ForeColor = System.Drawing.SystemColors.ControlText
        Me.chkFax.Location = New System.Drawing.Point(17, 24)
        Me.chkFax.Name = "chkFax"
        Me.chkFax.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.chkFax.Size = New System.Drawing.Size(44, 17)
        Me.chkFax.TabIndex = 208
        Me.chkFax.Text = "Fax"
        Me.chkFax.UseVisualStyleBackColor = False
        '
        'lblDocumentName
        '
        Me.lblDocumentName.AutoSize = True
        Me.lblDocumentName.BackColor = System.Drawing.SystemColors.Control
        Me.lblDocumentName.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblDocumentName.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblDocumentName.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblDocumentName.Location = New System.Drawing.Point(3, 155)
        Me.lblDocumentName.Name = "lblDocumentName"
        Me.lblDocumentName.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblDocumentName.Size = New System.Drawing.Size(76, 16)
        Me.lblDocumentName.TabIndex = 216
        Me.lblDocumentName.Text = "Document:"
        Me.lblDocumentName.TextAlign = System.Drawing.ContentAlignment.TopRight
        '
        'lblRetries
        '
        Me.lblRetries.AutoSize = True
        Me.lblRetries.BackColor = System.Drawing.SystemColors.Control
        Me.lblRetries.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblRetries.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblRetries.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblRetries.Location = New System.Drawing.Point(8, 186)
        Me.lblRetries.Name = "lblRetries"
        Me.lblRetries.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblRetries.Size = New System.Drawing.Size(69, 16)
        Me.lblRetries.TabIndex = 215
        Me.lblRetries.Text = "# Retries:"
        Me.lblRetries.TextAlign = System.Drawing.ContentAlignment.TopRight
        '
        'lblFaxNumber
        '
        Me.lblFaxNumber.AutoSize = True
        Me.lblFaxNumber.BackColor = System.Drawing.SystemColors.Control
        Me.lblFaxNumber.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblFaxNumber.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblFaxNumber.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblFaxNumber.Location = New System.Drawing.Point(24, 124)
        Me.lblFaxNumber.Name = "lblFaxNumber"
        Me.lblFaxNumber.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblFaxNumber.Size = New System.Drawing.Size(47, 16)
        Me.lblFaxNumber.TabIndex = 213
        Me.lblFaxNumber.Text = "Fax #:"
        Me.lblFaxNumber.TextAlign = System.Drawing.ContentAlignment.TopRight
        '
        'lblOrganization
        '
        Me.lblOrganization.AutoSize = True
        Me.lblOrganization.BackColor = System.Drawing.SystemColors.Control
        Me.lblOrganization.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblOrganization.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblOrganization.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblOrganization.Location = New System.Drawing.Point(33, 92)
        Me.lblOrganization.Name = "lblOrganization"
        Me.lblOrganization.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblOrganization.Size = New System.Drawing.Size(36, 16)
        Me.lblOrganization.TabIndex = 211
        Me.lblOrganization.Text = "Org:"
        Me.lblOrganization.TextAlign = System.Drawing.ContentAlignment.TopRight
        '
        'lblPerson
        '
        Me.lblPerson.AutoSize = True
        Me.lblPerson.BackColor = System.Drawing.SystemColors.Control
        Me.lblPerson.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblPerson.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblPerson.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblPerson.Location = New System.Drawing.Point(17, 60)
        Me.lblPerson.Name = "lblPerson"
        Me.lblPerson.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblPerson.Size = New System.Drawing.Size(57, 16)
        Me.lblPerson.TabIndex = 210
        Me.lblPerson.Text = "Person:"
        Me.lblPerson.TextAlign = System.Drawing.ContentAlignment.TopRight
        '
        'txtNurseScript
        '
        Me.txtNurseScript.AcceptsReturn = True
        Me.txtNurseScript.BackColor = System.Drawing.SystemColors.Window
        Me.txtNurseScript.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtNurseScript.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtNurseScript.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtNurseScript.Location = New System.Drawing.Point(8, 40)
        Me.txtNurseScript.MaxLength = 0
        Me.txtNurseScript.Multiline = True
        Me.txtNurseScript.Name = "txtNurseScript"
        Me.txtNurseScript.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtNurseScript.ScrollBars = System.Windows.Forms.ScrollBars.Vertical
        Me.txtNurseScript.Size = New System.Drawing.Size(265, 81)
        Me.txtNurseScript.TabIndex = 206
        '
        '_Lable_7
        '
        Me._Lable_7.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_7.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_7.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_7, CType(7, Short))
        Me._Lable_7.Location = New System.Drawing.Point(880, 8)
        Me._Lable_7.Name = "_Lable_7"
        Me._Lable_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_7.Size = New System.Drawing.Size(137, 17)
        Me._Lable_7.TabIndex = 312
        Me._Lable_7.Text = "Selected Organizations"
        '
        'lblNurseScript
        '
        Me.lblNurseScript.BackColor = System.Drawing.SystemColors.Control
        Me.lblNurseScript.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblNurseScript.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblNurseScript.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblNurseScript.Location = New System.Drawing.Point(8, 24)
        Me.lblNurseScript.Name = "lblNurseScript"
        Me.lblNurseScript.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblNurseScript.Size = New System.Drawing.Size(65, 17)
        Me.lblNurseScript.TabIndex = 205
        Me.lblNurseScript.Text = "Nurse Script"
        '
        'Frame1
        '
        Me.Frame1.BackColor = System.Drawing.SystemColors.Control
        Me.Frame1.Controls.Add(Me.chkCheckRegistry)
        Me.Frame1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Frame1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame1.Location = New System.Drawing.Point(8, 104)
        Me.Frame1.Name = "Frame1"
        Me.Frame1.Padding = New System.Windows.Forms.Padding(0)
        Me.Frame1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame1.Size = New System.Drawing.Size(105, 41)
        Me.Frame1.TabIndex = 219
        Me.Frame1.TabStop = False
        Me.Frame1.Text = "Registry"
        Me.Frame1.Visible = False
        '
        'chkCheckRegistry
        '
        Me.chkCheckRegistry.BackColor = System.Drawing.SystemColors.Control
        Me.chkCheckRegistry.Cursor = System.Windows.Forms.Cursors.Default
        Me.chkCheckRegistry.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.chkCheckRegistry.ForeColor = System.Drawing.SystemColors.ControlText
        Me.chkCheckRegistry.Location = New System.Drawing.Point(8, 16)
        Me.chkCheckRegistry.Name = "chkCheckRegistry"
        Me.chkCheckRegistry.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.chkCheckRegistry.Size = New System.Drawing.Size(93, 17)
        Me.chkCheckRegistry.TabIndex = 220
        Me.chkCheckRegistry.Text = "Check Registry"
        Me.chkCheckRegistry.UseVisualStyleBackColor = False
        Me.chkCheckRegistry.Visible = False
        '
        'fmDataSource
        '
        Me.fmDataSource.BackColor = System.Drawing.SystemColors.Control
        Me.fmDataSource.Controls.Add(Me.cmdRemoveDSN)
        Me.fmDataSource.Controls.Add(Me.cmdAddDSN)
        Me.fmDataSource.Controls.Add(Me.LstViewAvailableDSN)
        Me.fmDataSource.Controls.Add(Me.LstViewSelectedDSN)
        Me.fmDataSource.Controls.Add(Me.lblNote)
        Me.fmDataSource.Controls.Add(Me.lblAvailableDSN)
        Me.fmDataSource.Controls.Add(Me.lblSelectedDSN)
        Me.fmDataSource.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.fmDataSource.ForeColor = System.Drawing.SystemColors.ControlText
        Me.fmDataSource.Location = New System.Drawing.Point(416, 32)
        Me.fmDataSource.Name = "fmDataSource"
        Me.fmDataSource.Padding = New System.Windows.Forms.Padding(0)
        Me.fmDataSource.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.fmDataSource.Size = New System.Drawing.Size(433, 385)
        Me.fmDataSource.TabIndex = 313
        Me.fmDataSource.TabStop = False
        Me.fmDataSource.Text = "Data Sources"
        '
        'cmdRemoveDSN
        '
        Me.cmdRemoveDSN.BackColor = System.Drawing.SystemColors.Control
        Me.cmdRemoveDSN.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdRemoveDSN.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdRemoveDSN.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdRemoveDSN.Location = New System.Drawing.Point(187, 156)
        Me.cmdRemoveDSN.Name = "cmdRemoveDSN"
        Me.cmdRemoveDSN.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdRemoveDSN.Size = New System.Drawing.Size(55, 21)
        Me.cmdRemoveDSN.TabIndex = 315
        Me.cmdRemoveDSN.Text = "Remove"
        Me.cmdRemoveDSN.UseVisualStyleBackColor = False
        '
        'cmdAddDSN
        '
        Me.cmdAddDSN.BackColor = System.Drawing.SystemColors.Control
        Me.cmdAddDSN.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdAddDSN.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdAddDSN.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdAddDSN.Location = New System.Drawing.Point(187, 130)
        Me.cmdAddDSN.Name = "cmdAddDSN"
        Me.cmdAddDSN.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdAddDSN.Size = New System.Drawing.Size(55, 21)
        Me.cmdAddDSN.TabIndex = 314
        Me.cmdAddDSN.Text = "Add  >>"
        Me.cmdAddDSN.UseVisualStyleBackColor = False
        '
        'LstViewAvailableDSN
        '
        Me.LstViewAvailableDSN.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewAvailableDSN.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.LstViewAvailableDSN.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewAvailableDSN.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewAvailableDSN.FullRowSelect = True
        Me.LstViewAvailableDSN.HideSelection = False
        Me.LstViewAvailableDSN.LabelWrap = False
        Me.LstViewAvailableDSN.Location = New System.Drawing.Point(8, 32)
        Me.LstViewAvailableDSN.Name = "LstViewAvailableDSN"
        Me.LstViewAvailableDSN.Size = New System.Drawing.Size(167, 281)
        Me.LstViewAvailableDSN.TabIndex = 316
        Me.LstViewAvailableDSN.UseCompatibleStateImageBehavior = False
        Me.LstViewAvailableDSN.View = System.Windows.Forms.View.Details
        '
        'LstViewSelectedDSN
        '
        Me.LstViewSelectedDSN.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewSelectedDSN.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.LstViewSelectedDSN.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewSelectedDSN.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewSelectedDSN.FullRowSelect = True
        Me.LstViewSelectedDSN.HideSelection = False
        Me.LstViewSelectedDSN.LabelWrap = False
        Me.LstViewSelectedDSN.Location = New System.Drawing.Point(256, 32)
        Me.LstViewSelectedDSN.Name = "LstViewSelectedDSN"
        Me.LstViewSelectedDSN.Size = New System.Drawing.Size(167, 281)
        Me.LstViewSelectedDSN.TabIndex = 317
        Me.LstViewSelectedDSN.UseCompatibleStateImageBehavior = False
        Me.LstViewSelectedDSN.View = System.Windows.Forms.View.Details
        '
        'lblNote
        '
        Me.lblNote.BackColor = System.Drawing.SystemColors.Control
        Me.lblNote.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblNote.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblNote.ForeColor = System.Drawing.Color.Red
        Me.lblNote.Location = New System.Drawing.Point(16, 320)
        Me.lblNote.Name = "lblNote"
        Me.lblNote.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblNote.Size = New System.Drawing.Size(401, 57)
        Me.lblNote.TabIndex = 320
        Me.lblNote.Text = resources.GetString("lblNote.Text")
        '
        'lblAvailableDSN
        '
        Me.lblAvailableDSN.BackColor = System.Drawing.SystemColors.Control
        Me.lblAvailableDSN.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblAvailableDSN.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblAvailableDSN.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblAvailableDSN.Location = New System.Drawing.Point(8, 16)
        Me.lblAvailableDSN.Name = "lblAvailableDSN"
        Me.lblAvailableDSN.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblAvailableDSN.Size = New System.Drawing.Size(137, 17)
        Me.lblAvailableDSN.TabIndex = 319
        Me.lblAvailableDSN.Text = "Available DSN's"
        '
        'lblSelectedDSN
        '
        Me.lblSelectedDSN.BackColor = System.Drawing.SystemColors.Control
        Me.lblSelectedDSN.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblSelectedDSN.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblSelectedDSN.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblSelectedDSN.Location = New System.Drawing.Point(256, 16)
        Me.lblSelectedDSN.Name = "lblSelectedDSN"
        Me.lblSelectedDSN.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblSelectedDSN.Size = New System.Drawing.Size(89, 17)
        Me.lblSelectedDSN.TabIndex = 318
        Me.lblSelectedDSN.Text = "Selected DSN's"
        '
        '_Frame_22
        '
        Me._Frame_22.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_22.Controls.Add(Me.Command14)
        Me._Frame_22.Controls.Add(Me.Command13)
        Me._Frame_22.Controls.Add(Me.Combo6)
        Me._Frame_22.Controls.Add(Me.Combo5)
        Me._Frame_22.Controls.Add(Me._Frame_24)
        Me._Frame_22.Controls.Add(Me._Frame_23)
        Me._Frame_22.Controls.Add(Me.ListView7)
        Me._Frame_22.Controls.Add(Me._Label_30)
        Me._Frame_22.Controls.Add(Me._Label_28)
        Me._Frame_22.Controls.Add(Me._Label_29)
        Me._Frame_22.Controls.Add(Me.Label13)
        Me._Frame_22.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me._Frame_22.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_22.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_22, CType(22, Short))
        Me._Frame_22.Location = New System.Drawing.Point(-4992, 56)
        Me._Frame_22.Name = "_Frame_22"
        Me._Frame_22.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_22.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_22.Size = New System.Drawing.Size(723, 363)
        Me._Frame_22.TabIndex = 273
        Me._Frame_22.TabStop = False
        '
        'Command14
        '
        Me.Command14.BackColor = System.Drawing.SystemColors.Control
        Me.Command14.Cursor = System.Windows.Forms.Cursors.Default
        Me.Command14.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Command14.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Command14.Location = New System.Drawing.Point(72, 64)
        Me.Command14.Name = "Command14"
        Me.Command14.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Command14.Size = New System.Drawing.Size(69, 21)
        Me.Command14.TabIndex = 293
        Me.Command14.Text = "Add"
        Me.Command14.UseVisualStyleBackColor = False
        '
        'Command13
        '
        Me.Command13.BackColor = System.Drawing.SystemColors.Control
        Me.Command13.Cursor = System.Windows.Forms.Cursors.Default
        Me.Command13.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Command13.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Command13.Location = New System.Drawing.Point(148, 64)
        Me.Command13.Name = "Command13"
        Me.Command13.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Command13.Size = New System.Drawing.Size(69, 21)
        Me.Command13.TabIndex = 292
        Me.Command13.Text = "Remove"
        Me.Command13.UseVisualStyleBackColor = False
        '
        'Combo6
        '
        Me.Combo6.BackColor = System.Drawing.SystemColors.Window
        Me.Combo6.Cursor = System.Windows.Forms.Cursors.Default
        Me.Combo6.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.Combo6.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Combo6.ForeColor = System.Drawing.SystemColors.WindowText
        Me.Combo6.Location = New System.Drawing.Point(72, 38)
        Me.Combo6.Name = "Combo6"
        Me.Combo6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Combo6.Size = New System.Drawing.Size(255, 24)
        Me.Combo6.Sorted = True
        Me.Combo6.TabIndex = 291
        '
        'Combo5
        '
        Me.Combo5.BackColor = System.Drawing.SystemColors.Window
        Me.Combo5.Cursor = System.Windows.Forms.Cursors.Default
        Me.Combo5.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.Combo5.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Combo5.ForeColor = System.Drawing.SystemColors.WindowText
        Me.Combo5.Location = New System.Drawing.Point(72, 14)
        Me.Combo5.Name = "Combo5"
        Me.Combo5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Combo5.Size = New System.Drawing.Size(255, 24)
        Me.Combo5.Sorted = True
        Me.Combo5.TabIndex = 290
        '
        '_Frame_24
        '
        Me._Frame_24.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_24.Controls.Add(Me._ChkSoftTissue_1)
        Me._Frame_24.Controls.Add(Me._ChkEyes_1)
        Me._Frame_24.Controls.Add(Me._ChkBone_1)
        Me._Frame_24.Controls.Add(Me._ChkHeartValves_1)
        Me._Frame_24.Controls.Add(Me._ChkSkin_1)
        Me._Frame_24.Controls.Add(Me._ChkOrgans_4)
        Me._Frame_24.Controls.Add(Me._ChkResearch_1)
        Me._Frame_24.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me._Frame_24.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_24.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_24, CType(24, Short))
        Me._Frame_24.Location = New System.Drawing.Point(500, 52)
        Me._Frame_24.Name = "_Frame_24"
        Me._Frame_24.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_24.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_24.Size = New System.Drawing.Size(139, 155)
        Me._Frame_24.TabIndex = 282
        Me._Frame_24.TabStop = False
        '
        '_ChkSoftTissue_1
        '
        Me._ChkSoftTissue_1.BackColor = System.Drawing.SystemColors.Control
        Me._ChkSoftTissue_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._ChkSoftTissue_1.Enabled = False
        Me._ChkSoftTissue_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._ChkSoftTissue_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkSoftTissue.SetIndex(Me._ChkSoftTissue_1, CType(1, Short))
        Me._ChkSoftTissue_1.Location = New System.Drawing.Point(10, 54)
        Me._ChkSoftTissue_1.Name = "_ChkSoftTissue_1"
        Me._ChkSoftTissue_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._ChkSoftTissue_1.Size = New System.Drawing.Size(99, 13)
        Me._ChkSoftTissue_1.TabIndex = 289
        Me._ChkSoftTissue_1.Text = "Soft Tissue"
        Me._ChkSoftTissue_1.UseVisualStyleBackColor = False
        '
        '_ChkEyes_1
        '
        Me._ChkEyes_1.BackColor = System.Drawing.SystemColors.Control
        Me._ChkEyes_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._ChkEyes_1.Enabled = False
        Me._ChkEyes_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._ChkEyes_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkEyes.SetIndex(Me._ChkEyes_1, CType(1, Short))
        Me._ChkEyes_1.Location = New System.Drawing.Point(10, 114)
        Me._ChkEyes_1.Name = "_ChkEyes_1"
        Me._ChkEyes_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._ChkEyes_1.Size = New System.Drawing.Size(95, 13)
        Me._ChkEyes_1.TabIndex = 288
        Me._ChkEyes_1.Text = "Eyes"
        Me._ChkEyes_1.UseVisualStyleBackColor = False
        '
        '_ChkBone_1
        '
        Me._ChkBone_1.BackColor = System.Drawing.SystemColors.Control
        Me._ChkBone_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._ChkBone_1.Enabled = False
        Me._ChkBone_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._ChkBone_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkBone.SetIndex(Me._ChkBone_1, CType(1, Short))
        Me._ChkBone_1.Location = New System.Drawing.Point(10, 34)
        Me._ChkBone_1.Name = "_ChkBone_1"
        Me._ChkBone_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._ChkBone_1.Size = New System.Drawing.Size(97, 13)
        Me._ChkBone_1.TabIndex = 287
        Me._ChkBone_1.Text = "Bone"
        Me._ChkBone_1.UseVisualStyleBackColor = False
        '
        '_ChkHeartValves_1
        '
        Me._ChkHeartValves_1.BackColor = System.Drawing.SystemColors.Control
        Me._ChkHeartValves_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._ChkHeartValves_1.Enabled = False
        Me._ChkHeartValves_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._ChkHeartValves_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkHeartValves.SetIndex(Me._ChkHeartValves_1, CType(1, Short))
        Me._ChkHeartValves_1.Location = New System.Drawing.Point(10, 94)
        Me._ChkHeartValves_1.Name = "_ChkHeartValves_1"
        Me._ChkHeartValves_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._ChkHeartValves_1.Size = New System.Drawing.Size(95, 13)
        Me._ChkHeartValves_1.TabIndex = 286
        Me._ChkHeartValves_1.Text = "Heart Valves"
        Me._ChkHeartValves_1.UseVisualStyleBackColor = False
        '
        '_ChkSkin_1
        '
        Me._ChkSkin_1.BackColor = System.Drawing.SystemColors.Control
        Me._ChkSkin_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._ChkSkin_1.Enabled = False
        Me._ChkSkin_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._ChkSkin_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkSkin.SetIndex(Me._ChkSkin_1, CType(1, Short))
        Me._ChkSkin_1.Location = New System.Drawing.Point(10, 74)
        Me._ChkSkin_1.Name = "_ChkSkin_1"
        Me._ChkSkin_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._ChkSkin_1.Size = New System.Drawing.Size(85, 13)
        Me._ChkSkin_1.TabIndex = 285
        Me._ChkSkin_1.Text = "Skin"
        Me._ChkSkin_1.UseVisualStyleBackColor = False
        '
        '_ChkOrgans_4
        '
        Me._ChkOrgans_4.BackColor = System.Drawing.SystemColors.Control
        Me._ChkOrgans_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._ChkOrgans_4.Enabled = False
        Me._ChkOrgans_4.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._ChkOrgans_4.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkOrgans.SetIndex(Me._ChkOrgans_4, CType(4, Short))
        Me._ChkOrgans_4.Location = New System.Drawing.Point(10, 14)
        Me._ChkOrgans_4.Name = "_ChkOrgans_4"
        Me._ChkOrgans_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._ChkOrgans_4.Size = New System.Drawing.Size(83, 13)
        Me._ChkOrgans_4.TabIndex = 284
        Me._ChkOrgans_4.Text = "Organs"
        Me._ChkOrgans_4.UseVisualStyleBackColor = False
        '
        '_ChkResearch_1
        '
        Me._ChkResearch_1.BackColor = System.Drawing.SystemColors.Control
        Me._ChkResearch_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._ChkResearch_1.Enabled = False
        Me._ChkResearch_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._ChkResearch_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkResearch.SetIndex(Me._ChkResearch_1, CType(1, Short))
        Me._ChkResearch_1.Location = New System.Drawing.Point(10, 134)
        Me._ChkResearch_1.Name = "_ChkResearch_1"
        Me._ChkResearch_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._ChkResearch_1.Size = New System.Drawing.Size(99, 13)
        Me._ChkResearch_1.TabIndex = 283
        Me._ChkResearch_1.Text = "Research"
        Me._ChkResearch_1.UseVisualStyleBackColor = False
        '
        '_Frame_23
        '
        Me._Frame_23.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_23.Controls.Add(Me.Check10)
        Me._Frame_23.Controls.Add(Me.Check9)
        Me._Frame_23.Controls.Add(Me.Check8)
        Me._Frame_23.Controls.Add(Me.Check7)
        Me._Frame_23.Controls.Add(Me.Check6)
        Me._Frame_23.Controls.Add(Me.Check5)
        Me._Frame_23.Controls.Add(Me.Check4)
        Me._Frame_23.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me._Frame_23.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_23.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_23, CType(23, Short))
        Me._Frame_23.Location = New System.Drawing.Point(72, 210)
        Me._Frame_23.Name = "_Frame_23"
        Me._Frame_23.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_23.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_23.Size = New System.Drawing.Size(567, 145)
        Me._Frame_23.TabIndex = 274
        Me._Frame_23.TabStop = False
        Me._Frame_23.Text = "Contact Rules"
        '
        'Check10
        '
        Me.Check10.BackColor = System.Drawing.SystemColors.Control
        Me.Check10.Cursor = System.Windows.Forms.Cursors.Default
        Me.Check10.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Check10.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Check10.Location = New System.Drawing.Point(8, 18)
        Me.Check10.Name = "Check10"
        Me.Check10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Check10.Size = New System.Drawing.Size(331, 13)
        Me.Check10.TabIndex = 281
        Me.Check10.Text = "Do not contact group if general consent is denied"
        Me.Check10.UseVisualStyleBackColor = False
        '
        'Check9
        '
        Me.Check9.BackColor = System.Drawing.SystemColors.Control
        Me.Check9.Cursor = System.Windows.Forms.Cursors.Default
        Me.Check9.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Check9.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Check9.Location = New System.Drawing.Point(8, 36)
        Me.Check9.Name = "Check9"
        Me.Check9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Check9.Size = New System.Drawing.Size(365, 13)
        Me.Check9.TabIndex = 280
        Me.Check9.Text = "Contact group if option is not appropriate, yet general consent is granted"
        Me.Check9.UseVisualStyleBackColor = False
        '
        'Check8
        '
        Me.Check8.BackColor = System.Drawing.SystemColors.Control
        Me.Check8.Cursor = System.Windows.Forms.Cursors.Default
        Me.Check8.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Check8.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Check8.Location = New System.Drawing.Point(8, 88)
        Me.Check8.Name = "Check8"
        Me.Check8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Check8.Size = New System.Drawing.Size(551, 13)
        Me.Check8.TabIndex = 279
        Me.Check8.Text = "Do not verify contact until hospital obtains consent (consent pending event creat" &
    "ed automatically for hospital)"
        Me.Check8.UseVisualStyleBackColor = False
        '
        'Check7
        '
        Me.Check7.BackColor = System.Drawing.SystemColors.Control
        Me.Check7.Cursor = System.Windows.Forms.Cursors.Default
        Me.Check7.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Check7.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Check7.Location = New System.Drawing.Point(8, 54)
        Me.Check7.Name = "Check7"
        Me.Check7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Check7.Size = New System.Drawing.Size(365, 13)
        Me.Check7.TabIndex = 278
        Me.Check7.Text = "Contact group if coroner's case and general consent is granted"
        Me.Check7.UseVisualStyleBackColor = False
        '
        'Check6
        '
        Me.Check6.BackColor = System.Drawing.SystemColors.Control
        Me.Check6.Cursor = System.Windows.Forms.Cursors.Default
        Me.Check6.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Check6.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Check6.Location = New System.Drawing.Point(8, 106)
        Me.Check6.Name = "Check6"
        Me.Check6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Check6.Size = New System.Drawing.Size(551, 13)
        Me.Check6.TabIndex = 277
        Me.Check6.Text = "Do not verify contact until Statline performs secondary screening "
        Me.Check6.UseVisualStyleBackColor = False
        '
        'Check5
        '
        Me.Check5.BackColor = System.Drawing.SystemColors.Control
        Me.Check5.Cursor = System.Windows.Forms.Cursors.Default
        Me.Check5.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Check5.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Check5.Location = New System.Drawing.Point(8, 124)
        Me.Check5.Name = "Check5"
        Me.Check5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Check5.Size = New System.Drawing.Size(551, 13)
        Me.Check5.TabIndex = 276
        Me.Check5.Text = "Do not verify contact until Statline obtains consent (consent pending event creat" &
    "ed automatically for Statline)"
        Me.Check5.UseVisualStyleBackColor = False
        '
        'Check4
        '
        Me.Check4.BackColor = System.Drawing.SystemColors.Control
        Me.Check4.Cursor = System.Windows.Forms.Cursors.Default
        Me.Check4.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Check4.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Check4.Location = New System.Drawing.Point(8, 72)
        Me.Check4.Name = "Check4"
        Me.Check4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Check4.Size = New System.Drawing.Size(334, 13)
        Me.Check4.TabIndex = 275
        Me.Check4.Text = "Contact group if coroner's case only"
        Me.Check4.UseVisualStyleBackColor = False
        '
        'ListView7
        '
        Me.ListView7.BackColor = System.Drawing.SystemColors.Window
        Me.ListView7.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.ListView7.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ListView7.ForeColor = System.Drawing.SystemColors.WindowText
        Me.ListView7.HideSelection = False
        Me.ListView7.LabelWrap = False
        Me.ListView7.Location = New System.Drawing.Point(72, 120)
        Me.ListView7.Name = "ListView7"
        Me.ListView7.Size = New System.Drawing.Size(423, 87)
        Me.ListView7.TabIndex = 294
        Me.ListView7.UseCompatibleStateImageBehavior = False
        Me.ListView7.View = System.Windows.Forms.View.Details
        '
        '_Label_30
        '
        Me._Label_30.BackColor = System.Drawing.SystemColors.Control
        Me._Label_30.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_30.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_30.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_30, CType(30, Short))
        Me._Label_30.Location = New System.Drawing.Point(8, 18)
        Me._Label_30.Name = "_Label_30"
        Me._Label_30.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_30.Size = New System.Drawing.Size(69, 17)
        Me._Label_30.TabIndex = 298
        Me._Label_30.Text = "Organization"
        '
        '_Label_28
        '
        Me._Label_28.BackColor = System.Drawing.SystemColors.Control
        Me._Label_28.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_28.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_28.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_28, CType(28, Short))
        Me._Label_28.Location = New System.Drawing.Point(8, 42)
        Me._Label_28.Name = "_Label_28"
        Me._Label_28.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_28.Size = New System.Drawing.Size(69, 17)
        Me._Label_28.TabIndex = 297
        Me._Label_28.Text = "Schedule"
        '
        '_Label_29
        '
        Me._Label_29.BackColor = System.Drawing.SystemColors.Control
        Me._Label_29.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_29.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_29.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_29, CType(29, Short))
        Me._Label_29.Location = New System.Drawing.Point(72, 90)
        Me._Label_29.Name = "_Label_29"
        Me._Label_29.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_29.Size = New System.Drawing.Size(293, 31)
        Me._Label_29.TabIndex = 296
        Me._Label_29.Text = "When this option is appropriate, require contact of the following organization sc" &
    "hedule groups."
        '
        'Label13
        '
        Me.Label13.BackColor = System.Drawing.SystemColors.Control
        Me.Label13.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label13.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label13.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label13.Location = New System.Drawing.Point(500, 14)
        Me.Label13.Name = "Label13"
        Me.Label13.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label13.Size = New System.Drawing.Size(213, 39)
        Me.Label13.TabIndex = 295
        Me.Label13.Text = "Do not verify schedule group contact or apply contact rules if any of the followi" &
    "ng options are also appropriate."
        '
        '_Frame_27
        '
        Me._Frame_27.BackColor = System.Drawing.SystemColors.Menu
        Me._Frame_27.Controls.Add(Me.Picture2)
        Me._Frame_27.Controls.Add(Me.Command4)
        Me._Frame_27.Controls.Add(Me.ListView3)
        Me._Frame_27.Controls.Add(Me.Label2)
        Me._Frame_27.Controls.Add(Me._Lable_26)
        Me._Frame_27.Controls.Add(Me._Lable_27)
        Me._Frame_27.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me._Frame_27.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_27.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_27, CType(27, Short))
        Me._Frame_27.Location = New System.Drawing.Point(-4992, 24)
        Me._Frame_27.Name = "_Frame_27"
        Me._Frame_27.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_27.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_27.Size = New System.Drawing.Size(725, 407)
        Me._Frame_27.TabIndex = 232
        Me._Frame_27.TabStop = False
        '
        'Picture2
        '
        Me.Picture2.BackColor = System.Drawing.SystemColors.ActiveCaptionText
        Me.Picture2.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.Picture2.Controls.Add(Me.Command10)
        Me.Picture2.Controls.Add(Me.Command5)
        Me.Picture2.Controls.Add(Me.SubType)
        Me.Picture2.Controls.Add(Me._Frame_28)
        Me.Picture2.Cursor = System.Windows.Forms.Cursors.Default
        Me.Picture2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Picture2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Picture2.Location = New System.Drawing.Point(248, 40)
        Me.Picture2.Name = "Picture2"
        Me.Picture2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Picture2.Size = New System.Drawing.Size(220, 361)
        Me.Picture2.TabIndex = 234
        Me.Picture2.TabStop = True
        '
        'Command10
        '
        Me.Command10.BackColor = System.Drawing.SystemColors.Control
        Me.Command10.Cursor = System.Windows.Forms.Cursors.Default
        Me.Command10.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Command10.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Command10.Location = New System.Drawing.Point(200, 0)
        Me.Command10.Name = "Command10"
        Me.Command10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Command10.Size = New System.Drawing.Size(17, 17)
        Me.Command10.TabIndex = 268
        Me.Command10.UseVisualStyleBackColor = False
        '
        'Command5
        '
        Me.Command5.BackColor = System.Drawing.SystemColors.Control
        Me.Command5.Cursor = System.Windows.Forms.Cursors.Default
        Me.Command5.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Command5.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Command5.Location = New System.Drawing.Point(72, 0)
        Me.Command5.Name = "Command5"
        Me.Command5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Command5.Size = New System.Drawing.Size(57, 17)
        Me.Command5.TabIndex = 267
        Me.Command5.Text = "Assigned"
        Me.Command5.UseVisualStyleBackColor = False
        '
        'SubType
        '
        Me.SubType.BackColor = System.Drawing.SystemColors.Control
        Me.SubType.Cursor = System.Windows.Forms.Cursors.Default
        Me.SubType.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.SubType.ForeColor = System.Drawing.SystemColors.ControlText
        Me.SubType.Location = New System.Drawing.Point(0, 0)
        Me.SubType.Name = "SubType"
        Me.SubType.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.SubType.Size = New System.Drawing.Size(73, 17)
        Me.SubType.TabIndex = 266
        Me.SubType.Text = "SubType"
        Me.SubType.UseVisualStyleBackColor = False
        '
        '_Frame_28
        '
        Me._Frame_28.BackColor = System.Drawing.SystemColors.ActiveCaptionText
        Me._Frame_28.Controls.Add(Me.VScroll1)
        Me._Frame_28.Controls.Add(Me.Text2)
        Me._Frame_28.Controls.Add(Me.Text9)
        Me._Frame_28.Controls.Add(Me.Text8)
        Me._Frame_28.Controls.Add(Me.Text7)
        Me._Frame_28.Controls.Add(Me.Text6)
        Me._Frame_28.Controls.Add(Me.Text5)
        Me._Frame_28.Controls.Add(Me.Command6)
        Me._Frame_28.Controls.Add(Me.Frame17)
        Me._Frame_28.Controls.Add(Me.Frame13)
        Me._Frame_28.Controls.Add(Me.Frame3)
        Me._Frame_28.Controls.Add(Me.Frame2)
        Me._Frame_28.Controls.Add(Me.Frame15)
        Me._Frame_28.Controls.Add(Me.Frame14)
        Me._Frame_28.Controls.Add(Me.Frame4)
        Me._Frame_28.Controls.Add(Me.Text3)
        Me._Frame_28.Controls.Add(Me.Label4)
        Me._Frame_28.Controls.Add(Me.Label5)
        Me._Frame_28.Controls.Add(Me.Label10)
        Me._Frame_28.Controls.Add(Me.Label9)
        Me._Frame_28.Controls.Add(Me.Label8)
        Me._Frame_28.Controls.Add(Me.Label7)
        Me._Frame_28.Controls.Add(Me.Label3)
        Me._Frame_28.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me._Frame_28.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_28.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_28, CType(28, Short))
        Me._Frame_28.Location = New System.Drawing.Point(0, -8)
        Me._Frame_28.Name = "_Frame_28"
        Me._Frame_28.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_28.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_28.Size = New System.Drawing.Size(223, 365)
        Me._Frame_28.TabIndex = 235
        Me._Frame_28.TabStop = False
        '
        'VScroll1
        '
        Me.VScroll1.Cursor = System.Windows.Forms.Cursors.Default
        Me.VScroll1.LargeChange = 1
        Me.VScroll1.Location = New System.Drawing.Point(200, 24)
        Me.VScroll1.Maximum = 32767
        Me.VScroll1.Name = "VScroll1"
        Me.VScroll1.Size = New System.Drawing.Size(17, 339)
        Me.VScroll1.TabIndex = 258
        Me.VScroll1.TabStop = True
        '
        'Text2
        '
        Me.Text2.AcceptsReturn = True
        Me.Text2.BackColor = System.Drawing.SystemColors.Window
        Me.Text2.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.Text2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Text2.ForeColor = System.Drawing.SystemColors.WindowText
        Me.Text2.Location = New System.Drawing.Point(128, 24)
        Me.Text2.MaxLength = 0
        Me.Text2.Name = "Text2"
        Me.Text2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Text2.Size = New System.Drawing.Size(73, 23)
        Me.Text2.TabIndex = 257
        Me.Text2.Text = "1"
        '
        'Text9
        '
        Me.Text9.AcceptsReturn = True
        Me.Text9.BackColor = System.Drawing.SystemColors.Window
        Me.Text9.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.Text9.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Text9.ForeColor = System.Drawing.SystemColors.WindowText
        Me.Text9.Location = New System.Drawing.Point(128, 56)
        Me.Text9.MaxLength = 0
        Me.Text9.Name = "Text9"
        Me.Text9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Text9.Size = New System.Drawing.Size(73, 23)
        Me.Text9.TabIndex = 256
        Me.Text9.Text = "3"
        '
        'Text8
        '
        Me.Text8.AcceptsReturn = True
        Me.Text8.BackColor = System.Drawing.SystemColors.Window
        Me.Text8.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.Text8.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Text8.ForeColor = System.Drawing.SystemColors.WindowText
        Me.Text8.Location = New System.Drawing.Point(128, 72)
        Me.Text8.MaxLength = 0
        Me.Text8.Name = "Text8"
        Me.Text8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Text8.Size = New System.Drawing.Size(73, 23)
        Me.Text8.TabIndex = 255
        Me.Text8.Text = "4"
        '
        'Text7
        '
        Me.Text7.AcceptsReturn = True
        Me.Text7.BackColor = System.Drawing.SystemColors.Window
        Me.Text7.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.Text7.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Text7.ForeColor = System.Drawing.SystemColors.WindowText
        Me.Text7.Location = New System.Drawing.Point(128, 88)
        Me.Text7.MaxLength = 0
        Me.Text7.Name = "Text7"
        Me.Text7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Text7.Size = New System.Drawing.Size(73, 23)
        Me.Text7.TabIndex = 254
        Me.Text7.Text = "5"
        '
        'Text6
        '
        Me.Text6.AcceptsReturn = True
        Me.Text6.BackColor = System.Drawing.SystemColors.Window
        Me.Text6.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.Text6.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Text6.ForeColor = System.Drawing.SystemColors.WindowText
        Me.Text6.Location = New System.Drawing.Point(128, 104)
        Me.Text6.MaxLength = 0
        Me.Text6.Name = "Text6"
        Me.Text6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Text6.Size = New System.Drawing.Size(73, 23)
        Me.Text6.TabIndex = 253
        Me.Text6.Text = "6"
        '
        'Text5
        '
        Me.Text5.AcceptsReturn = True
        Me.Text5.BackColor = System.Drawing.SystemColors.Window
        Me.Text5.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.Text5.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Text5.ForeColor = System.Drawing.SystemColors.WindowText
        Me.Text5.Location = New System.Drawing.Point(128, 120)
        Me.Text5.MaxLength = 0
        Me.Text5.Name = "Text5"
        Me.Text5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Text5.Size = New System.Drawing.Size(73, 23)
        Me.Text5.TabIndex = 252
        Me.Text5.Text = "7"
        '
        'Command6
        '
        Me.Command6.BackColor = System.Drawing.SystemColors.Control
        Me.Command6.Cursor = System.Windows.Forms.Cursors.Default
        Me.Command6.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Command6.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Command6.Location = New System.Drawing.Point(128, 8)
        Me.Command6.Name = "Command6"
        Me.Command6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Command6.Size = New System.Drawing.Size(73, 17)
        Me.Command6.TabIndex = 251
        Me.Command6.Text = "Precedence"
        Me.Command6.UseVisualStyleBackColor = False
        '
        'Frame17
        '
        Me.Frame17.BackColor = System.Drawing.SystemColors.ActiveCaptionText
        Me.Frame17.Controls.Add(Me._ChkOrgans_17)
        Me.Frame17.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Frame17.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame17.Location = New System.Drawing.Point(72, 16)
        Me.Frame17.Name = "Frame17"
        Me.Frame17.Padding = New System.Windows.Forms.Padding(0)
        Me.Frame17.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame17.Size = New System.Drawing.Size(57, 25)
        Me.Frame17.TabIndex = 249
        Me.Frame17.TabStop = False
        '
        '_ChkOrgans_17
        '
        Me._ChkOrgans_17.BackColor = System.Drawing.SystemColors.ActiveCaptionText
        Me._ChkOrgans_17.Cursor = System.Windows.Forms.Cursors.Default
        Me._ChkOrgans_17.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._ChkOrgans_17.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkOrgans.SetIndex(Me._ChkOrgans_17, CType(17, Short))
        Me._ChkOrgans_17.Location = New System.Drawing.Point(20, 8)
        Me._ChkOrgans_17.Name = "_ChkOrgans_17"
        Me._ChkOrgans_17.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._ChkOrgans_17.Size = New System.Drawing.Size(19, 13)
        Me._ChkOrgans_17.TabIndex = 250
        Me._ChkOrgans_17.UseVisualStyleBackColor = False
        '
        'Frame13
        '
        Me.Frame13.BackColor = System.Drawing.SystemColors.ActiveCaptionText
        Me.Frame13.Controls.Add(Me._ChkOrgans_13)
        Me.Frame13.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Frame13.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame13.Location = New System.Drawing.Point(72, 32)
        Me.Frame13.Name = "Frame13"
        Me.Frame13.Padding = New System.Windows.Forms.Padding(0)
        Me.Frame13.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame13.Size = New System.Drawing.Size(57, 25)
        Me.Frame13.TabIndex = 247
        Me.Frame13.TabStop = False
        '
        '_ChkOrgans_13
        '
        Me._ChkOrgans_13.BackColor = System.Drawing.SystemColors.ActiveCaptionText
        Me._ChkOrgans_13.Cursor = System.Windows.Forms.Cursors.Default
        Me._ChkOrgans_13.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._ChkOrgans_13.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkOrgans.SetIndex(Me._ChkOrgans_13, CType(13, Short))
        Me._ChkOrgans_13.Location = New System.Drawing.Point(20, 8)
        Me._ChkOrgans_13.Name = "_ChkOrgans_13"
        Me._ChkOrgans_13.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._ChkOrgans_13.Size = New System.Drawing.Size(19, 13)
        Me._ChkOrgans_13.TabIndex = 248
        Me._ChkOrgans_13.UseVisualStyleBackColor = False
        '
        'Frame3
        '
        Me.Frame3.BackColor = System.Drawing.SystemColors.ActiveCaptionText
        Me.Frame3.Controls.Add(Me._ChkOrgans_3)
        Me.Frame3.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Frame3.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame3.Location = New System.Drawing.Point(72, 48)
        Me.Frame3.Name = "Frame3"
        Me.Frame3.Padding = New System.Windows.Forms.Padding(0)
        Me.Frame3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame3.Size = New System.Drawing.Size(57, 25)
        Me.Frame3.TabIndex = 245
        Me.Frame3.TabStop = False
        '
        '_ChkOrgans_3
        '
        Me._ChkOrgans_3.BackColor = System.Drawing.SystemColors.ActiveCaptionText
        Me._ChkOrgans_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._ChkOrgans_3.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._ChkOrgans_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkOrgans.SetIndex(Me._ChkOrgans_3, CType(3, Short))
        Me._ChkOrgans_3.Location = New System.Drawing.Point(20, 8)
        Me._ChkOrgans_3.Name = "_ChkOrgans_3"
        Me._ChkOrgans_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._ChkOrgans_3.Size = New System.Drawing.Size(19, 13)
        Me._ChkOrgans_3.TabIndex = 246
        Me._ChkOrgans_3.UseVisualStyleBackColor = False
        '
        'Frame2
        '
        Me.Frame2.BackColor = System.Drawing.SystemColors.ActiveCaptionText
        Me.Frame2.Controls.Add(Me._ChkOrgans_1)
        Me.Frame2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Frame2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame2.Location = New System.Drawing.Point(72, 64)
        Me.Frame2.Name = "Frame2"
        Me.Frame2.Padding = New System.Windows.Forms.Padding(0)
        Me.Frame2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame2.Size = New System.Drawing.Size(57, 25)
        Me.Frame2.TabIndex = 243
        Me.Frame2.TabStop = False
        '
        '_ChkOrgans_1
        '
        Me._ChkOrgans_1.BackColor = System.Drawing.SystemColors.ActiveCaptionText
        Me._ChkOrgans_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._ChkOrgans_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._ChkOrgans_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkOrgans.SetIndex(Me._ChkOrgans_1, CType(1, Short))
        Me._ChkOrgans_1.Location = New System.Drawing.Point(20, 8)
        Me._ChkOrgans_1.Name = "_ChkOrgans_1"
        Me._ChkOrgans_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._ChkOrgans_1.Size = New System.Drawing.Size(19, 13)
        Me._ChkOrgans_1.TabIndex = 244
        Me._ChkOrgans_1.UseVisualStyleBackColor = False
        '
        'Frame15
        '
        Me.Frame15.BackColor = System.Drawing.SystemColors.ActiveCaptionText
        Me.Frame15.Controls.Add(Me._ChkOrgans_15)
        Me.Frame15.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Frame15.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame15.Location = New System.Drawing.Point(72, 80)
        Me.Frame15.Name = "Frame15"
        Me.Frame15.Padding = New System.Windows.Forms.Padding(0)
        Me.Frame15.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame15.Size = New System.Drawing.Size(57, 25)
        Me.Frame15.TabIndex = 241
        Me.Frame15.TabStop = False
        '
        '_ChkOrgans_15
        '
        Me._ChkOrgans_15.BackColor = System.Drawing.SystemColors.ActiveCaptionText
        Me._ChkOrgans_15.Cursor = System.Windows.Forms.Cursors.Default
        Me._ChkOrgans_15.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._ChkOrgans_15.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkOrgans.SetIndex(Me._ChkOrgans_15, CType(15, Short))
        Me._ChkOrgans_15.Location = New System.Drawing.Point(20, 8)
        Me._ChkOrgans_15.Name = "_ChkOrgans_15"
        Me._ChkOrgans_15.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._ChkOrgans_15.Size = New System.Drawing.Size(19, 13)
        Me._ChkOrgans_15.TabIndex = 242
        Me._ChkOrgans_15.UseVisualStyleBackColor = False
        '
        'Frame14
        '
        Me.Frame14.BackColor = System.Drawing.SystemColors.ActiveCaptionText
        Me.Frame14.Controls.Add(Me._ChkOrgans_14)
        Me.Frame14.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Frame14.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame14.Location = New System.Drawing.Point(72, 96)
        Me.Frame14.Name = "Frame14"
        Me.Frame14.Padding = New System.Windows.Forms.Padding(0)
        Me.Frame14.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame14.Size = New System.Drawing.Size(57, 25)
        Me.Frame14.TabIndex = 239
        Me.Frame14.TabStop = False
        '
        '_ChkOrgans_14
        '
        Me._ChkOrgans_14.BackColor = System.Drawing.SystemColors.ActiveCaptionText
        Me._ChkOrgans_14.Cursor = System.Windows.Forms.Cursors.Default
        Me._ChkOrgans_14.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._ChkOrgans_14.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkOrgans.SetIndex(Me._ChkOrgans_14, CType(14, Short))
        Me._ChkOrgans_14.Location = New System.Drawing.Point(20, 8)
        Me._ChkOrgans_14.Name = "_ChkOrgans_14"
        Me._ChkOrgans_14.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._ChkOrgans_14.Size = New System.Drawing.Size(19, 13)
        Me._ChkOrgans_14.TabIndex = 240
        Me._ChkOrgans_14.UseVisualStyleBackColor = False
        '
        'Frame4
        '
        Me.Frame4.BackColor = System.Drawing.SystemColors.ActiveCaptionText
        Me.Frame4.Controls.Add(Me._ChkOrgans_2)
        Me.Frame4.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Frame4.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame4.Location = New System.Drawing.Point(72, 112)
        Me.Frame4.Name = "Frame4"
        Me.Frame4.Padding = New System.Windows.Forms.Padding(0)
        Me.Frame4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame4.Size = New System.Drawing.Size(57, 25)
        Me.Frame4.TabIndex = 237
        Me.Frame4.TabStop = False
        '
        '_ChkOrgans_2
        '
        Me._ChkOrgans_2.BackColor = System.Drawing.SystemColors.ActiveCaptionText
        Me._ChkOrgans_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._ChkOrgans_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._ChkOrgans_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkOrgans.SetIndex(Me._ChkOrgans_2, CType(2, Short))
        Me._ChkOrgans_2.Location = New System.Drawing.Point(20, 8)
        Me._ChkOrgans_2.Name = "_ChkOrgans_2"
        Me._ChkOrgans_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._ChkOrgans_2.Size = New System.Drawing.Size(19, 13)
        Me._ChkOrgans_2.TabIndex = 238
        Me._ChkOrgans_2.UseVisualStyleBackColor = False
        '
        'Text3
        '
        Me.Text3.AcceptsReturn = True
        Me.Text3.BackColor = System.Drawing.SystemColors.Window
        Me.Text3.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.Text3.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Text3.ForeColor = System.Drawing.SystemColors.WindowText
        Me.Text3.Location = New System.Drawing.Point(128, 40)
        Me.Text3.MaxLength = 0
        Me.Text3.Name = "Text3"
        Me.Text3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Text3.Size = New System.Drawing.Size(73, 23)
        Me.Text3.TabIndex = 236
        Me.Text3.Text = "2"
        '
        'Label4
        '
        Me.Label4.BackColor = System.Drawing.SystemColors.ActiveCaptionText
        Me.Label4.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.Label4.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label4.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label4.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label4.Location = New System.Drawing.Point(0, 24)
        Me.Label4.Name = "Label4"
        Me.Label4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label4.Size = New System.Drawing.Size(73, 17)
        Me.Label4.TabIndex = 265
        Me.Label4.Text = "Heart"
        '
        'Label5
        '
        Me.Label5.BackColor = System.Drawing.SystemColors.ActiveCaptionText
        Me.Label5.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.Label5.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label5.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label5.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label5.Location = New System.Drawing.Point(0, 120)
        Me.Label5.Name = "Label5"
        Me.Label5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label5.Size = New System.Drawing.Size(73, 17)
        Me.Label5.TabIndex = 264
        Me.Label5.Text = "etc..."
        '
        'Label10
        '
        Me.Label10.BackColor = System.Drawing.SystemColors.ActiveCaptionText
        Me.Label10.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.Label10.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label10.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label10.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label10.Location = New System.Drawing.Point(0, 56)
        Me.Label10.Name = "Label10"
        Me.Label10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label10.Size = New System.Drawing.Size(73, 17)
        Me.Label10.TabIndex = 263
        Me.Label10.Text = "Kidney"
        '
        'Label9
        '
        Me.Label9.BackColor = System.Drawing.SystemColors.ActiveCaptionText
        Me.Label9.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.Label9.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label9.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label9.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label9.Location = New System.Drawing.Point(0, 72)
        Me.Label9.Name = "Label9"
        Me.Label9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label9.Size = New System.Drawing.Size(73, 17)
        Me.Label9.TabIndex = 262
        Me.Label9.Text = "Upper Bone"
        '
        'Label8
        '
        Me.Label8.BackColor = System.Drawing.SystemColors.ActiveCaptionText
        Me.Label8.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.Label8.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label8.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label8.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label8.Location = New System.Drawing.Point(0, 88)
        Me.Label8.Name = "Label8"
        Me.Label8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label8.Size = New System.Drawing.Size(73, 17)
        Me.Label8.TabIndex = 261
        Me.Label8.Text = "etc..."
        '
        'Label7
        '
        Me.Label7.BackColor = System.Drawing.SystemColors.ActiveCaptionText
        Me.Label7.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.Label7.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label7.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label7.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label7.Location = New System.Drawing.Point(0, 104)
        Me.Label7.Name = "Label7"
        Me.Label7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label7.Size = New System.Drawing.Size(73, 17)
        Me.Label7.TabIndex = 260
        Me.Label7.Text = "etc..."
        '
        'Label3
        '
        Me.Label3.BackColor = System.Drawing.SystemColors.ActiveCaptionText
        Me.Label3.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.Label3.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label3.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label3.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label3.Location = New System.Drawing.Point(0, 40)
        Me.Label3.Name = "Label3"
        Me.Label3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label3.Size = New System.Drawing.Size(73, 17)
        Me.Label3.TabIndex = 259
        Me.Label3.Text = "Liva"
        '
        'Command4
        '
        Me.Command4.BackColor = System.Drawing.SystemColors.Control
        Me.Command4.Cursor = System.Windows.Forms.Cursors.Default
        Me.Command4.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Command4.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Command4.Location = New System.Drawing.Point(144, 8)
        Me.Command4.Name = "Command4"
        Me.Command4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Command4.Size = New System.Drawing.Size(89, 25)
        Me.Command4.TabIndex = 233
        Me.Command4.Text = "New Template..."
        Me.Command4.UseVisualStyleBackColor = False
        '
        'ListView3
        '
        Me.ListView3.BackColor = System.Drawing.SystemColors.Window
        Me.ListView3.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.ListView3.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ListView3.ForeColor = System.Drawing.SystemColors.WindowText
        Me.ListView3.HideSelection = False
        Me.ListView3.LabelWrap = False
        Me.ListView3.Location = New System.Drawing.Point(0, 36)
        Me.ListView3.Name = "ListView3"
        Me.ListView3.Size = New System.Drawing.Size(235, 261)
        Me.ListView3.TabIndex = 269
        Me.ListView3.UseCompatibleStateImageBehavior = False
        Me.ListView3.View = System.Windows.Forms.View.Details
        '
        'Label2
        '
        Me.Label2.BackColor = System.Drawing.SystemColors.Control
        Me.Label2.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label2.Location = New System.Drawing.Point(248, 18)
        Me.Label2.Name = "Label2"
        Me.Label2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label2.Size = New System.Drawing.Size(57, 13)
        Me.Label2.TabIndex = 272
        Me.Label2.Text = "SubTypes"
        '
        '_Lable_26
        '
        Me._Lable_26.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_26.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_26.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_26.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_26, CType(26, Short))
        Me._Lable_26.Location = New System.Drawing.Point(0, 304)
        Me._Lable_26.Name = "_Lable_26"
        Me._Lable_26.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_26.Size = New System.Drawing.Size(229, 97)
        Me._Lable_26.TabIndex = 271
        Me._Lable_26.Text = resources.GetString("_Lable_26.Text")
        '
        '_Lable_27
        '
        Me._Lable_27.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_27.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_27.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_27.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_27, CType(27, Short))
        Me._Lable_27.Location = New System.Drawing.Point(0, 16)
        Me._Lable_27.Name = "_Lable_27"
        Me._Lable_27.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_27.Size = New System.Drawing.Size(137, 17)
        Me._Lable_27.TabIndex = 270
        Me._Lable_27.Text = "Processor Criteria Templates"
        '
        '_Frame_30
        '
        Me._Frame_30.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_30.Controls.Add(Me.Command2)
        Me._Frame_30.Controls.Add(Me.Command3)
        Me._Frame_30.Controls.Add(Me.Command1)
        Me._Frame_30.Controls.Add(Me.ListView1)
        Me._Frame_30.Controls.Add(Me.ListView2)
        Me._Frame_30.Controls.Add(Me.Label11)
        Me._Frame_30.Controls.Add(Me._Lable_0)
        Me._Frame_30.Controls.Add(Me._Lable_23)
        Me._Frame_30.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me._Frame_30.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_30.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_30, CType(30, Short))
        Me._Frame_30.Location = New System.Drawing.Point(-4992, 24)
        Me._Frame_30.Name = "_Frame_30"
        Me._Frame_30.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_30.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_30.Size = New System.Drawing.Size(733, 409)
        Me._Frame_30.TabIndex = 223
        Me._Frame_30.TabStop = False
        '
        'Command2
        '
        Me.Command2.BackColor = System.Drawing.SystemColors.Control
        Me.Command2.Cursor = System.Windows.Forms.Cursors.Default
        Me.Command2.Enabled = False
        Me.Command2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Command2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Command2.Location = New System.Drawing.Point(328, 144)
        Me.Command2.Name = "Command2"
        Me.Command2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Command2.Size = New System.Drawing.Size(53, 21)
        Me.Command2.TabIndex = 226
        Me.Command2.Text = "Add  >>"
        Me.Command2.UseVisualStyleBackColor = False
        '
        'Command3
        '
        Me.Command3.BackColor = System.Drawing.SystemColors.Control
        Me.Command3.Cursor = System.Windows.Forms.Cursors.Default
        Me.Command3.Enabled = False
        Me.Command3.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Command3.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Command3.Location = New System.Drawing.Point(328, 170)
        Me.Command3.Name = "Command3"
        Me.Command3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Command3.Size = New System.Drawing.Size(53, 21)
        Me.Command3.TabIndex = 225
        Me.Command3.Text = "Remove"
        Me.Command3.UseVisualStyleBackColor = False
        '
        'Command1
        '
        Me.Command1.BackColor = System.Drawing.SystemColors.Control
        Me.Command1.Cursor = System.Windows.Forms.Cursors.Default
        Me.Command1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Command1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Command1.Location = New System.Drawing.Point(208, 8)
        Me.Command1.Name = "Command1"
        Me.Command1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Command1.Size = New System.Drawing.Size(113, 25)
        Me.Command1.TabIndex = 224
        Me.Command1.Text = "New SubType..."
        Me.Command1.UseVisualStyleBackColor = False
        '
        'ListView1
        '
        Me.ListView1.BackColor = System.Drawing.SystemColors.Window
        Me.ListView1.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.ListView1.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ListView1.ForeColor = System.Drawing.SystemColors.WindowText
        Me.ListView1.HideSelection = False
        Me.ListView1.LabelWrap = False
        Me.ListView1.Location = New System.Drawing.Point(392, 40)
        Me.ListView1.Name = "ListView1"
        Me.ListView1.Size = New System.Drawing.Size(335, 369)
        Me.ListView1.TabIndex = 227
        Me.ListView1.UseCompatibleStateImageBehavior = False
        Me.ListView1.View = System.Windows.Forms.View.Details
        '
        'ListView2
        '
        Me.ListView2.BackColor = System.Drawing.SystemColors.Window
        Me.ListView2.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.ListView2.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ListView2.ForeColor = System.Drawing.SystemColors.WindowText
        Me.ListView2.HideSelection = False
        Me.ListView2.LabelWrap = False
        Me.ListView2.Location = New System.Drawing.Point(2, 38)
        Me.ListView2.Name = "ListView2"
        Me.ListView2.Size = New System.Drawing.Size(319, 369)
        Me.ListView2.TabIndex = 228
        Me.ListView2.UseCompatibleStateImageBehavior = False
        Me.ListView2.View = System.Windows.Forms.View.Details
        '
        'Label11
        '
        Me.Label11.BackColor = System.Drawing.SystemColors.Control
        Me.Label11.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label11.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label11.ForeColor = System.Drawing.Color.Red
        Me.Label11.Location = New System.Drawing.Point(544, 8)
        Me.Label11.Name = "Label11"
        Me.Label11.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label11.Size = New System.Drawing.Size(73, 25)
        Me.Label11.TabIndex = 231
        Me.Label11.Text = "Double-click for Precedence"
        '
        '_Lable_0
        '
        Me._Lable_0.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_0, CType(0, Short))
        Me._Lable_0.Location = New System.Drawing.Point(392, 20)
        Me._Lable_0.Name = "_Lable_0"
        Me._Lable_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_0.Size = New System.Drawing.Size(137, 17)
        Me._Lable_0.TabIndex = 230
        Me._Lable_0.Text = "Selected SubTypes"
        '
        '_Lable_23
        '
        Me._Lable_23.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_23.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_23.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_23.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_23, CType(23, Short))
        Me._Lable_23.Location = New System.Drawing.Point(4, 20)
        Me._Lable_23.Name = "_Lable_23"
        Me._Lable_23.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_23.Size = New System.Drawing.Size(137, 17)
        Me._Lable_23.TabIndex = 229
        Me._Lable_23.Text = "Available SubTypes"
        '
        'Label12
        '
        Me.Label12.BackColor = System.Drawing.SystemColors.Control
        Me.Label12.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label12.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label12.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label12.Location = New System.Drawing.Point(-4992, 32)
        Me.Label12.Name = "Label12"
        Me.Label12.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label12.Size = New System.Drawing.Size(97, 17)
        Me.Label12.TabIndex = 301
        Me.Label12.Text = "SubType/Processor"
        '
        'Label6
        '
        Me.Label6.BackColor = System.Drawing.SystemColors.Control
        Me.Label6.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label6.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label6.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label6.Location = New System.Drawing.Point(-4992, 32)
        Me.Label6.Name = "Label6"
        Me.Label6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label6.Size = New System.Drawing.Size(97, 17)
        Me.Label6.TabIndex = 300
        Me.Label6.Text = "SubType/Processor"
        '
        'ImageList1
        '
        Me.ImageList1.ImageStream = CType(resources.GetObject("ImageList1.ImageStream"), System.Windows.Forms.ImageListStreamer)
        Me.ImageList1.TransparentColor = System.Drawing.Color.FromArgb(CType(CType(192, Byte), Integer), CType(CType(192, Byte), Integer), CType(CType(192, Byte), Integer))
        Me.ImageList1.Images.SetKeyName(0, "image_blue")
        Me.ImageList1.Images.SetKeyName(1, "status_red")
        Me.ImageList1.Images.SetKeyName(2, "status_green")
        Me.ImageList1.Images.SetKeyName(3, "image_a")
        Me.ImageList1.Images.SetKeyName(4, "image_b")
        Me.ImageList1.Images.SetKeyName(5, "image_bell")
        Me.ChkPendingCase.AutoSize = True
        Me.ChkPendingCase.Location = New System.Drawing.Point(6, 116)
        Me.ChkPendingCase.Name = "ChkPendingCase"
        Me.ChkPendingCase.Size = New System.Drawing.Size(119, 20)
        Me.ChkPendingCase.TabIndex = 350
        Me.ChkPendingCase.Text = "Pending Case"
        Me.ChkPendingCase.UseVisualStyleBackColor = True
        '
        'FrmServiceLevel
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(7.0!, 16.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.ClientSize = New System.Drawing.Size(889, 590)
        Me.Controls.Add(Me.CmdOK)
        Me.Controls.Add(Me.CmdCancel)
        Me.Controls.Add(Me._Frame_3)
        Me.Controls.Add(Me.TabServiceLevel)
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.Icon = CType(resources.GetObject("$this.Icon"),System.Drawing.Icon)
        Me.Location = New System.Drawing.Point(66, 175)
        Me.MaximizeBox = false
        Me.Name = "FrmServiceLevel"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Service Level"
        Me._Frame_3.ResumeLayout(false)
        Me.TabServiceLevel.ResumeLayout(false)
        Me._TabServiceLevel_TabPage0.ResumeLayout(false)
        Me._Frame_1.ResumeLayout(false)
        Me._Picture_7.ResumeLayout(false)
        Me._Picture_6.ResumeLayout(false)
        Me._Picture_5.ResumeLayout(false)
        Me._Frame_0.ResumeLayout(false)
        Me._Frame_0.PerformLayout
        Me._Frame_5.ResumeLayout(false)
        Me._Frame_5.PerformLayout
        Me.RegistryData.ResumeLayout(false)
        Me.PronouncingData.ResumeLayout(false)
        Me.PronouncingData.PerformLayout
        Me._Frame_7.ResumeLayout(false)
        Me.NOK.ResumeLayout(false)
        Me._Frame_11.ResumeLayout(false)
        Me._Picture_3.ResumeLayout(false)
        Me._Picture_2.ResumeLayout(false)
        Me._Picture_1.ResumeLayout(false)
        Me._Picture_0.ResumeLayout(false)
        Me._Frame_8.ResumeLayout(false)
        Me._Frame_9.ResumeLayout(false)
        Me._Frame_9.PerformLayout
        Me._Frame_4.ResumeLayout(false)
        Me._Frame_10.ResumeLayout(false)
        Me.Disposition.ResumeLayout(false)
        Me.Frame5.ResumeLayout(false)
        Me._TabServiceLevel_TabPage1.ResumeLayout(false)
        Me._Frame_2.ResumeLayout(false)
        Me._TabServiceLevel_TabPage2.ResumeLayout(false)
        Me._Frame_6.ResumeLayout(false)
        Me._TabServiceLevel_TabPage3.ResumeLayout(false)
        Me._Frame_12.ResumeLayout(false)
        Me._Frame_13.ResumeLayout(false)
        Me._Frame_13.PerformLayout
        Me._Frame_14.ResumeLayout(false)
        Me._Frame_14.PerformLayout
        Me._TabServiceLevel_TabPage4.ResumeLayout(false)
        Me._Picture1_2.ResumeLayout(false)
        Me.SSTab1.ResumeLayout(false)
        Me._SSTab1_TabPage0.ResumeLayout(false)
        Me.fmEyeCareReminder.ResumeLayout(false)
        Me.fmEyeCareReminder.PerformLayout
        Me._Frame_15.ResumeLayout(false)
        Me._Frame_15.PerformLayout
        Me._Frame_16.ResumeLayout(false)
        Me._SSTab1_TabPage1.ResumeLayout(false)
        Me._TabServiceLevel_TabPage5.ResumeLayout(false)
        Me._Frame_17.ResumeLayout(false)
        Me._Frame_18.ResumeLayout(false)
        Me._Frame_18.PerformLayout
        Me._Frame_19.ResumeLayout(false)
        Me._Frame_19.PerformLayout
        Me.Frame1.ResumeLayout(false)
        Me.fmDataSource.ResumeLayout(false)
        Me._Frame_22.ResumeLayout(false)
        Me._Frame_24.ResumeLayout(false)
        Me._Frame_23.ResumeLayout(false)
        Me._Frame_27.ResumeLayout(false)
        Me.Picture2.ResumeLayout(false)
        Me._Frame_28.ResumeLayout(false)
        Me._Frame_28.PerformLayout
        Me.Frame17.ResumeLayout(false)
        Me.Frame13.ResumeLayout(false)
        Me.Frame3.ResumeLayout(false)
        Me.Frame2.ResumeLayout(false)
        Me.Frame15.ResumeLayout(false)
        Me.Frame14.ResumeLayout(false)
        Me.Frame4.ResumeLayout(false)
        Me._Frame_30.ResumeLayout(false)
        CType(Me.CboField,System.ComponentModel.ISupportInitialize).EndInit
        CType(Me.ChkBone,System.ComponentModel.ISupportInitialize).EndInit
        CType(Me.ChkEyes,System.ComponentModel.ISupportInitialize).EndInit
        CType(Me.ChkHeartValves,System.ComponentModel.ISupportInitialize).EndInit
        CType(Me.ChkOrgans,System.ComponentModel.ISupportInitialize).EndInit
        CType(Me.ChkResearch,System.ComponentModel.ISupportInitialize).EndInit
        CType(Me.ChkSkin,System.ComponentModel.ISupportInitialize).EndInit
        CType(Me.ChkSoftTissue,System.ComponentModel.ISupportInitialize).EndInit
        CType(Me.CmdAdd,System.ComponentModel.ISupportInitialize).EndInit
        CType(Me.CmdDelete,System.ComponentModel.ISupportInitialize).EndInit
        CType(Me.DD,System.ComponentModel.ISupportInitialize).EndInit
        CType(Me.Frame,System.ComponentModel.ISupportInitialize).EndInit
        CType(Me.Label,System.ComponentModel.ISupportInitialize).EndInit
        CType(Me.LabelPrompt,System.ComponentModel.ISupportInitialize).EndInit
        CType(Me.Lable,System.ComponentModel.ISupportInitialize).EndInit
        CType(Me.OptAttending,System.ComponentModel.ISupportInitialize).EndInit
        CType(Me.OptEHistory,System.ComponentModel.ISupportInitialize).EndInit
        CType(Me.OptEPrompt,System.ComponentModel.ISupportInitialize).EndInit
        CType(Me.OptOTEHistory,System.ComponentModel.ISupportInitialize).EndInit
        CType(Me.OptOTEPrompt,System.ComponentModel.ISupportInitialize).EndInit
        CType(Me.OptPrevVent,System.ComponentModel.ISupportInitialize).EndInit
        CType(Me.OptPronouncing,System.ComponentModel.ISupportInitialize).EndInit
        CType(Me.OptROPrompt,System.ComponentModel.ISupportInitialize).EndInit
        CType(Me.OptTEHistory,System.ComponentModel.ISupportInitialize).EndInit
        CType(Me.OptTEPrompt,System.ComponentModel.ISupportInitialize).EndInit
        CType(Me.Picture,System.ComponentModel.ISupportInitialize).EndInit
        CType(Me.Picture1,System.ComponentModel.ISupportInitialize).EndInit
        CType(Me.TxtAlert,System.ComponentModel.ISupportInitialize).EndInit
        CType(Me.TxtLabel,System.ComponentModel.ISupportInitialize).EndInit
        CType(Me.rbtnIntent,System.ComponentModel.ISupportInitialize).EndInit
        Me.ResumeLayout(false)

End Sub
    Friend WithEvents PronouncingData As System.Windows.Forms.GroupBox
    Public WithEvents ChkPNEAllowSaveWithoutContactRequired As System.Windows.Forms.CheckBox
    Public WithEvents ChkDCDPotentialMessageEnabled As CheckBox
    Public WithEvents ChkPendingCase As CheckBox
#End Region
End Class
