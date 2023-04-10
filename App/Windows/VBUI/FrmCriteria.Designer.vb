<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmCriteria
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
	Public WithEvents cmdTemp As System.Windows.Forms.Button
	Public WithEvents CmdCancel As System.Windows.Forms.Button
	Public WithEvents CboDonorTracCriteriaGroup As System.Windows.Forms.ComboBox
	Public WithEvents CmdMapCategory As System.Windows.Forms.Button
	Public WithEvents CmdCriteriaGroupDetail As System.Windows.Forms.Button
	Public WithEvents CboCriteriaGroup As System.Windows.Forms.ComboBox
	Public WithEvents CboDonorCategory As System.Windows.Forms.ComboBox
	Public WithEvents Label5 As System.Windows.Forms.Label
	Public WithEvents _Lable_1 As System.Windows.Forms.Label
	Public WithEvents _Lable_0 As System.Windows.Forms.Label
	Public WithEvents _Frame_1 As System.Windows.Forms.GroupBox
	Public WithEvents CmdOK As System.Windows.Forms.Button
	Public WithEvents TxtVerifyMessage As System.Windows.Forms.TextBox
	Public WithEvents _Lable_16 As System.Windows.Forms.Label
	Public WithEvents _Frame_7 As System.Windows.Forms.GroupBox
	Public WithEvents _Pic_1 As System.Windows.Forms.Panel
	Public WithEvents TxtGeneralRuleout As System.Windows.Forms.TextBox
	Public WithEvents _Lable_7 As System.Windows.Forms.Label
	Public WithEvents _Frame_2 As System.Windows.Forms.GroupBox
	Public WithEvents ChkReferNonPotential As System.Windows.Forms.CheckBox
	Public WithEvents TxtLowerWeight As System.Windows.Forms.TextBox
	Public WithEvents TxtUpperWeight As System.Windows.Forms.TextBox
	Public WithEvents TxtFemaleLower As System.Windows.Forms.TextBox
	Public WithEvents TxtMaleLower As System.Windows.Forms.TextBox
	Public WithEvents TxtFemaleUpper As System.Windows.Forms.TextBox
	Public WithEvents TxtMaleUpper As System.Windows.Forms.TextBox
	Public WithEvents _Lable_6 As System.Windows.Forms.Label
	Public WithEvents _Lable_17 As System.Windows.Forms.Label
	Public WithEvents _Lable_18 As System.Windows.Forms.Label
	Public WithEvents _Lable_10 As System.Windows.Forms.Label
	Public WithEvents _Lable_11 As System.Windows.Forms.Label
	Public WithEvents _Lable_14 As System.Windows.Forms.Label
	Public WithEvents _Lable_13 As System.Windows.Forms.Label
	Public WithEvents _Lable_9 As System.Windows.Forms.Label
	Public WithEvents _Lable_12 As System.Windows.Forms.Label
	Public WithEvents _Lable_15 As System.Windows.Forms.Label
	Public WithEvents _Frame_3 As System.Windows.Forms.GroupBox
	Public WithEvents CmdIndicationRemove As System.Windows.Forms.Button
	Public WithEvents CmdIndicationAdd As System.Windows.Forms.Button
	Public WithEvents LstViewIndication As System.Windows.Forms.ListView
	Public WithEvents _Frame_4 As System.Windows.Forms.GroupBox
	Public WithEvents ChkNotAppropriateFemale As System.Windows.Forms.CheckBox
	Public WithEvents ChkNotAppropriateMale As System.Windows.Forms.CheckBox
	Public WithEvents _Frame_6 As System.Windows.Forms.GroupBox
	Public WithEvents _Pic_0 As System.Windows.Forms.Panel
	Public WithEvents _TabCriteria_TabPage0 As System.Windows.Forms.TabPage
	Public WithEvents CmdUnassigned As System.Windows.Forms.Button
	Public WithEvents CmdSelect As System.Windows.Forms.Button
	Public WithEvents CmdDeselect As System.Windows.Forms.Button
	Public WithEvents CboOrganizationType As System.Windows.Forms.ComboBox
	Public WithEvents CmdFind As System.Windows.Forms.Button
	Public WithEvents CboState As System.Windows.Forms.ComboBox
	Public WithEvents LstViewSelectedOrganizations As System.Windows.Forms.ListView
	Public WithEvents LstViewAvailableOrganizations As System.Windows.Forms.ListView
	Public WithEvents _Lable_3 As System.Windows.Forms.Label
	Public WithEvents _Lable_5 As System.Windows.Forms.Label
	Public WithEvents _Lable_2 As System.Windows.Forms.Label
	Public WithEvents _Lable_4 As System.Windows.Forms.Label
	Public WithEvents _Frame_0 As System.Windows.Forms.GroupBox
	Public WithEvents _TabCriteria_TabPage1 As System.Windows.Forms.TabPage
	Public WithEvents CmdAdd As System.Windows.Forms.Button
	Public WithEvents CmdRemove As System.Windows.Forms.Button
	Public WithEvents LstViewSourceCodes As System.Windows.Forms.ListView
	Public WithEvents _Lable_20 As System.Windows.Forms.Label
	Public WithEvents _Lable_19 As System.Windows.Forms.Label
	Public WithEvents _Lable_21 As System.Windows.Forms.Label
	Public WithEvents _Frame_5 As System.Windows.Forms.GroupBox
	Public WithEvents _TabCriteria_TabPage2 As System.Windows.Forms.TabPage
	Public WithEvents chkCoronerOnly As System.Windows.Forms.CheckBox
	Public WithEvents ChkContactOnStatlineConsent As System.Windows.Forms.CheckBox
	Public WithEvents ChkContactOnStatlineSecondary As System.Windows.Forms.CheckBox
	Public WithEvents ChkContactOnCoroner As System.Windows.Forms.CheckBox
	Public WithEvents ChkContactOnHospitalConsent As System.Windows.Forms.CheckBox
	Public WithEvents ChkContactOnConsent As System.Windows.Forms.CheckBox
	Public WithEvents ChkNoContactOnDeny As System.Windows.Forms.CheckBox
	Public WithEvents _Frame_10 As System.Windows.Forms.GroupBox
	Public WithEvents ChkResearch As System.Windows.Forms.CheckBox
	Public WithEvents ChkOrgans As System.Windows.Forms.CheckBox
	Public WithEvents ChkSkin As System.Windows.Forms.CheckBox
	Public WithEvents ChkHeartValves As System.Windows.Forms.CheckBox
	Public WithEvents ChkBone As System.Windows.Forms.CheckBox
	Public WithEvents ChkEyes As System.Windows.Forms.CheckBox
	Public WithEvents ChkSoftTissue As System.Windows.Forms.CheckBox
	Public WithEvents _Frame_9 As System.Windows.Forms.GroupBox
	Public WithEvents CboOrganization As System.Windows.Forms.ComboBox
	Public WithEvents CboScheduleGroup As System.Windows.Forms.ComboBox
	Public WithEvents RemoveSchedule As System.Windows.Forms.Button
	Public WithEvents CmdAddSchedule As System.Windows.Forms.Button
	Public WithEvents LstViewSchedule As System.Windows.Forms.ListView
	Public WithEvents Label1 As System.Windows.Forms.Label
	Public WithEvents _Label_2 As System.Windows.Forms.Label
	Public WithEvents _Label_1 As System.Windows.Forms.Label
	Public WithEvents _Label_0 As System.Windows.Forms.Label
	Public WithEvents _Frame_8 As System.Windows.Forms.GroupBox
	Public WithEvents _TabCriteria_TabPage3 As System.Windows.Forms.TabPage
	Public WithEvents cmdSubtype As System.Windows.Forms.Button
	Public WithEvents cmdRemoveSubtype As System.Windows.Forms.Button
	Public WithEvents cmdAddSubtype As System.Windows.Forms.Button
	Public WithEvents LstViewSelectedSubtypes As System.Windows.Forms.ListView
	Public WithEvents LstViewAvailableSubtypes As System.Windows.Forms.ListView
	Public WithEvents _Lable_23 As System.Windows.Forms.Label
	Public WithEvents _Lable_8 As System.Windows.Forms.Label
	Public WithEvents Label11 As System.Windows.Forms.Label
	Public WithEvents _Frame_11 As System.Windows.Forms.GroupBox
	Public WithEvents _SSTab1_TabPage0 As System.Windows.Forms.TabPage
	Public WithEvents cmdAddProcessor As System.Windows.Forms.Button
	Public WithEvents cmdRemoveProcessor As System.Windows.Forms.Button
	Public WithEvents cboProcessorOrganizationType As System.Windows.Forms.ComboBox
	Public WithEvents cmdProcessorFind As System.Windows.Forms.Button
	Public WithEvents cboProcessorState As System.Windows.Forms.ComboBox
	Public WithEvents LstViewSelectedProcessors As System.Windows.Forms.ListView
	Public WithEvents LstViewAvailableProcessors As System.Windows.Forms.ListView
	Public WithEvents _Lable_22 As System.Windows.Forms.Label
	Public WithEvents _Lable_28 As System.Windows.Forms.Label
	Public WithEvents _Lable_29 As System.Windows.Forms.Label
	Public WithEvents _Lable_30 As System.Windows.Forms.Label
	Public WithEvents _Frame_13 As System.Windows.Forms.GroupBox
	Public WithEvents _SSTab1_TabPage1 As System.Windows.Forms.TabPage
	Public WithEvents cmdNewTemplate As System.Windows.Forms.Button
	Public WithEvents LstViewCriteriaTemplates As System.Windows.Forms.ListView
	Public WithEvents LstViewSubtypeProcessors As System.Windows.Forms.ListView
	Public WithEvents Label4 As System.Windows.Forms.Label
	Public WithEvents Label3 As System.Windows.Forms.Label
	Public WithEvents _Lable_27 As System.Windows.Forms.Label
	Public WithEvents _Lable_26 As System.Windows.Forms.Label
	Public WithEvents Label2 As System.Windows.Forms.Label
	Public WithEvents _Frame_12 As System.Windows.Forms.GroupBox
	Public WithEvents _SSTab1_TabPage2 As System.Windows.Forms.TabPage
	Public WithEvents Label6 As System.Windows.Forms.Label
	Public WithEvents cmdSaveSubCriteria As System.Windows.Forms.Button
	Public WithEvents TxtGeneralRuleoutSub As System.Windows.Forms.TextBox
	Public WithEvents _LableSub_7 As System.Windows.Forms.Label
	Public WithEvents _FrameSub_2 As System.Windows.Forms.GroupBox
	Public WithEvents TxtFemaleLowerWeightSub As System.Windows.Forms.TextBox
	Public WithEvents TxtFemaleUpperWeightSub As System.Windows.Forms.TextBox
	Public WithEvents TxtMaleUpperSub As System.Windows.Forms.TextBox
	Public WithEvents TxtFemaleUpperSub As System.Windows.Forms.TextBox
	Public WithEvents TxtMaleLowerSub As System.Windows.Forms.TextBox
	Public WithEvents TxtFemaleLowerSub As System.Windows.Forms.TextBox
	Public WithEvents TxtUpperWeightSub As System.Windows.Forms.TextBox
	Public WithEvents TxtLowerWeightSub As System.Windows.Forms.TextBox
	Public WithEvents ChkReferNonPotentialSub As System.Windows.Forms.CheckBox
	Public WithEvents _LableSub_20 As System.Windows.Forms.Label
	Public WithEvents _LableSub_21 As System.Windows.Forms.Label
	Public WithEvents _LableSub_19 As System.Windows.Forms.Label
	Public WithEvents _LableSub_15 As System.Windows.Forms.Label
	Public WithEvents _LableSub_12 As System.Windows.Forms.Label
	Public WithEvents _Lable_37 As System.Windows.Forms.Label
	Public WithEvents _LableSub_13 As System.Windows.Forms.Label
	Public WithEvents _LableSub_14 As System.Windows.Forms.Label
	Public WithEvents _LableSub_11 As System.Windows.Forms.Label
	Public WithEvents _LableSub_10 As System.Windows.Forms.Label
	Public WithEvents _LableSub_18 As System.Windows.Forms.Label
	Public WithEvents _LableSub_17 As System.Windows.Forms.Label
	Public WithEvents _LableSub_6 As System.Windows.Forms.Label
	Public WithEvents _FrameSub_3 As System.Windows.Forms.GroupBox
	Public WithEvents ChkNotAppropriateMaleSub As System.Windows.Forms.CheckBox
	Public WithEvents ChkNotAppropriateFemaleSub As System.Windows.Forms.CheckBox
	Public WithEvents _FrameSub_6 As System.Windows.Forms.GroupBox
	Public WithEvents _SSTab2_TabPage0 As System.Windows.Forms.TabPage
	Public WithEvents cmdAddConditional As System.Windows.Forms.Button
	Public WithEvents cmdRemoveConditional As System.Windows.Forms.Button
	Public WithEvents LstViewConditionals As System.Windows.Forms.ListView
	Public WithEvents Label15 As System.Windows.Forms.Label
	Public WithEvents _Frame_17 As System.Windows.Forms.GroupBox
	Public WithEvents Label14 As System.Windows.Forms.Label
	Public WithEvents _SSTab2_TabPage1 As System.Windows.Forms.TabPage
	Public WithEvents SSTab2 As System.Windows.Forms.TabControl
	Public WithEvents _cboSubtypeProcessor_0 As System.Windows.Forms.ComboBox
	Public WithEvents _SSTab1_TabPage3 As System.Windows.Forms.TabPage
	Public WithEvents _cboSubtypeProcessor_1 As System.Windows.Forms.ComboBox
	Public WithEvents chkCoronerOnlySub As System.Windows.Forms.CheckBox
	Public WithEvents ChkContactOnStatlineConsentSub As System.Windows.Forms.CheckBox
	Public WithEvents ChkContactOnStatlineSecondarySub As System.Windows.Forms.CheckBox
	Public WithEvents ChkContactOnCoronerSub As System.Windows.Forms.CheckBox
	Public WithEvents ChkContactOnHospitalConsentSub As System.Windows.Forms.CheckBox
	Public WithEvents ChkContactOnConsentSub As System.Windows.Forms.CheckBox
	Public WithEvents ChkNoContactOnDenySub As System.Windows.Forms.CheckBox
	Public WithEvents _FrameSub_10 As System.Windows.Forms.GroupBox
	Public WithEvents ChkResearchSub As System.Windows.Forms.CheckBox
	Public WithEvents ChkOrgansSub As System.Windows.Forms.CheckBox
	Public WithEvents ChkSkinSub As System.Windows.Forms.CheckBox
	Public WithEvents ChkHeartValvesSub As System.Windows.Forms.CheckBox
	Public WithEvents ChkBoneSub As System.Windows.Forms.CheckBox
	Public WithEvents ChkEyesSub As System.Windows.Forms.CheckBox
	Public WithEvents ChkSoftTissueSub As System.Windows.Forms.CheckBox
	Public WithEvents _FrameSub_9 As System.Windows.Forms.GroupBox
	Public WithEvents cboOrganizationSub As System.Windows.Forms.ComboBox
	Public WithEvents cboScheduleGroupSub As System.Windows.Forms.ComboBox
	Public WithEvents cmdRemoveScheduleSub As System.Windows.Forms.Button
	Public WithEvents cmdAddScheduleSub As System.Windows.Forms.Button
	Public WithEvents LstViewScheduleSub As System.Windows.Forms.ListView
	Public WithEvents Label1Sub As System.Windows.Forms.Label
	Public WithEvents _Label_3 As System.Windows.Forms.Label
	Public WithEvents _Label_4 As System.Windows.Forms.Label
	Public WithEvents _Label_5 As System.Windows.Forms.Label
	Public WithEvents _Frame_19 As System.Windows.Forms.GroupBox
	Public WithEvents Label12 As System.Windows.Forms.Label
	Public WithEvents _SSTab1_TabPage4 As System.Windows.Forms.TabPage
	Public WithEvents SSTab1 As System.Windows.Forms.TabControl
	Public WithEvents Picture1 As System.Windows.Forms.Panel
	Public WithEvents _TabCriteria_TabPage4 As System.Windows.Forms.TabPage
	Public WithEvents TabCriteria As System.Windows.Forms.TabControl
	Public WithEvents Frame As Microsoft.VisualBasic.Compatibility.VB6.GroupBoxArray
	Public WithEvents FrameSub As Microsoft.VisualBasic.Compatibility.VB6.GroupBoxArray
	Public WithEvents Label As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
	Public WithEvents Lable As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
	Public WithEvents LableSub As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
	Public WithEvents Pic As Microsoft.VisualBasic.Compatibility.VB6.PanelArray
	Public WithEvents cboSubtypeProcessor As Microsoft.VisualBasic.Compatibility.VB6.ComboBoxArray
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FrmCriteria))
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.cmdTemp = New System.Windows.Forms.Button
        Me.CmdCancel = New System.Windows.Forms.Button
        Me._Frame_1 = New System.Windows.Forms.GroupBox
        Me.CboDonorTracCriteriaGroup = New System.Windows.Forms.ComboBox
        Me.CmdMapCategory = New System.Windows.Forms.Button
        Me.CmdCriteriaGroupDetail = New System.Windows.Forms.Button
        Me.CboCriteriaGroup = New System.Windows.Forms.ComboBox
        Me.CboDonorCategory = New System.Windows.Forms.ComboBox
        Me.Label5 = New System.Windows.Forms.Label
        Me._Lable_1 = New System.Windows.Forms.Label
        Me._Lable_0 = New System.Windows.Forms.Label
        Me.CmdOK = New System.Windows.Forms.Button
        Me.TabCriteria = New System.Windows.Forms.TabControl
        Me._TabCriteria_TabPage0 = New System.Windows.Forms.TabPage
        Me._Pic_0 = New System.Windows.Forms.Panel
        Me._Frame_2 = New System.Windows.Forms.GroupBox
        Me.TxtGeneralRuleout = New System.Windows.Forms.TextBox
        Me._Lable_7 = New System.Windows.Forms.Label
        Me._Frame_3 = New System.Windows.Forms.GroupBox
        Me.ChkReferNonPotential = New System.Windows.Forms.CheckBox
        Me.TxtLowerWeight = New System.Windows.Forms.TextBox
        Me.TxtUpperWeight = New System.Windows.Forms.TextBox
        Me.TxtFemaleLower = New System.Windows.Forms.TextBox
        Me.TxtMaleLower = New System.Windows.Forms.TextBox
        Me.TxtFemaleUpper = New System.Windows.Forms.TextBox
        Me.TxtMaleUpper = New System.Windows.Forms.TextBox
        Me._Lable_6 = New System.Windows.Forms.Label
        Me._Lable_17 = New System.Windows.Forms.Label
        Me._Lable_18 = New System.Windows.Forms.Label
        Me._Lable_10 = New System.Windows.Forms.Label
        Me._Lable_11 = New System.Windows.Forms.Label
        Me._Lable_14 = New System.Windows.Forms.Label
        Me._Lable_13 = New System.Windows.Forms.Label
        Me._Lable_9 = New System.Windows.Forms.Label
        Me._Lable_12 = New System.Windows.Forms.Label
        Me._Lable_15 = New System.Windows.Forms.Label
        Me._Frame_4 = New System.Windows.Forms.GroupBox
        Me.CmdIndicationRemove = New System.Windows.Forms.Button
        Me.CmdIndicationAdd = New System.Windows.Forms.Button
        Me.LstViewIndication = New System.Windows.Forms.ListView
        Me._Frame_6 = New System.Windows.Forms.GroupBox
        Me.ChkNotAppropriateFemale = New System.Windows.Forms.CheckBox
        Me.ChkNotAppropriateMale = New System.Windows.Forms.CheckBox
        Me._Pic_1 = New System.Windows.Forms.Panel
        Me._Frame_7 = New System.Windows.Forms.GroupBox
        Me.TxtVerifyMessage = New System.Windows.Forms.TextBox
        Me._Lable_16 = New System.Windows.Forms.Label
        Me._TabCriteria_TabPage1 = New System.Windows.Forms.TabPage
        Me._Frame_0 = New System.Windows.Forms.GroupBox
        Me.CmdUnassigned = New System.Windows.Forms.Button
        Me.CmdSelect = New System.Windows.Forms.Button
        Me.CmdDeselect = New System.Windows.Forms.Button
        Me.CboOrganizationType = New System.Windows.Forms.ComboBox
        Me.CmdFind = New System.Windows.Forms.Button
        Me.CboState = New System.Windows.Forms.ComboBox
        Me.LstViewSelectedOrganizations = New System.Windows.Forms.ListView
        Me.LstViewAvailableOrganizations = New System.Windows.Forms.ListView
        Me._Lable_3 = New System.Windows.Forms.Label
        Me._Lable_5 = New System.Windows.Forms.Label
        Me._Lable_2 = New System.Windows.Forms.Label
        Me._Lable_4 = New System.Windows.Forms.Label
        Me._TabCriteria_TabPage2 = New System.Windows.Forms.TabPage
        Me._Frame_5 = New System.Windows.Forms.GroupBox
        Me.CmdAdd = New System.Windows.Forms.Button
        Me.CmdRemove = New System.Windows.Forms.Button
        Me.LstViewSourceCodes = New System.Windows.Forms.ListView
        Me._Lable_20 = New System.Windows.Forms.Label
        Me._Lable_19 = New System.Windows.Forms.Label
        Me._Lable_21 = New System.Windows.Forms.Label
        Me._TabCriteria_TabPage3 = New System.Windows.Forms.TabPage
        Me._Frame_8 = New System.Windows.Forms.GroupBox
        Me._Frame_10 = New System.Windows.Forms.GroupBox
        Me.chkCoronerOnly = New System.Windows.Forms.CheckBox
        Me.ChkContactOnStatlineConsent = New System.Windows.Forms.CheckBox
        Me.ChkContactOnStatlineSecondary = New System.Windows.Forms.CheckBox
        Me.ChkContactOnCoroner = New System.Windows.Forms.CheckBox
        Me.ChkContactOnHospitalConsent = New System.Windows.Forms.CheckBox
        Me.ChkContactOnConsent = New System.Windows.Forms.CheckBox
        Me.ChkNoContactOnDeny = New System.Windows.Forms.CheckBox
        Me._Frame_9 = New System.Windows.Forms.GroupBox
        Me.ChkResearch = New System.Windows.Forms.CheckBox
        Me.ChkOrgans = New System.Windows.Forms.CheckBox
        Me.ChkSkin = New System.Windows.Forms.CheckBox
        Me.ChkHeartValves = New System.Windows.Forms.CheckBox
        Me.ChkBone = New System.Windows.Forms.CheckBox
        Me.ChkEyes = New System.Windows.Forms.CheckBox
        Me.ChkSoftTissue = New System.Windows.Forms.CheckBox
        Me.CboOrganization = New System.Windows.Forms.ComboBox
        Me.CboScheduleGroup = New System.Windows.Forms.ComboBox
        Me.RemoveSchedule = New System.Windows.Forms.Button
        Me.CmdAddSchedule = New System.Windows.Forms.Button
        Me.LstViewSchedule = New System.Windows.Forms.ListView
        Me.Label1 = New System.Windows.Forms.Label
        Me._Label_2 = New System.Windows.Forms.Label
        Me._Label_1 = New System.Windows.Forms.Label
        Me._Label_0 = New System.Windows.Forms.Label
        Me._TabCriteria_TabPage4 = New System.Windows.Forms.TabPage
        Me.Picture1 = New System.Windows.Forms.Panel
        Me.SSTab1 = New System.Windows.Forms.TabControl
        Me._SSTab1_TabPage0 = New System.Windows.Forms.TabPage
        Me._Frame_11 = New System.Windows.Forms.GroupBox
        Me.cmdSubtype = New System.Windows.Forms.Button
        Me.cmdRemoveSubtype = New System.Windows.Forms.Button
        Me.cmdAddSubtype = New System.Windows.Forms.Button
        Me.LstViewSelectedSubtypes = New System.Windows.Forms.ListView
        Me.LstViewAvailableSubtypes = New System.Windows.Forms.ListView
        Me._Lable_23 = New System.Windows.Forms.Label
        Me._Lable_8 = New System.Windows.Forms.Label
        Me.Label11 = New System.Windows.Forms.Label
        Me._SSTab1_TabPage1 = New System.Windows.Forms.TabPage
        Me._Frame_13 = New System.Windows.Forms.GroupBox
        Me.cmdAddProcessor = New System.Windows.Forms.Button
        Me.cmdRemoveProcessor = New System.Windows.Forms.Button
        Me.cboProcessorOrganizationType = New System.Windows.Forms.ComboBox
        Me.cmdProcessorFind = New System.Windows.Forms.Button
        Me.cboProcessorState = New System.Windows.Forms.ComboBox
        Me.LstViewSelectedProcessors = New System.Windows.Forms.ListView
        Me.LstViewAvailableProcessors = New System.Windows.Forms.ListView
        Me._Lable_22 = New System.Windows.Forms.Label
        Me._Lable_28 = New System.Windows.Forms.Label
        Me._Lable_29 = New System.Windows.Forms.Label
        Me._Lable_30 = New System.Windows.Forms.Label
        Me._SSTab1_TabPage2 = New System.Windows.Forms.TabPage
        Me._Frame_12 = New System.Windows.Forms.GroupBox
        Me.cmdNewTemplate = New System.Windows.Forms.Button
        Me.LstViewCriteriaTemplates = New System.Windows.Forms.ListView
        Me.LstViewSubtypeProcessors = New System.Windows.Forms.ListView
        Me.Label4 = New System.Windows.Forms.Label
        Me.Label3 = New System.Windows.Forms.Label
        Me._Lable_27 = New System.Windows.Forms.Label
        Me._Lable_26 = New System.Windows.Forms.Label
        Me.Label2 = New System.Windows.Forms.Label
        Me._SSTab1_TabPage3 = New System.Windows.Forms.TabPage
        Me.Label6 = New System.Windows.Forms.Label
        Me.SSTab2 = New System.Windows.Forms.TabControl
        Me._SSTab2_TabPage0 = New System.Windows.Forms.TabPage
        Me.cmdSaveSubCriteria = New System.Windows.Forms.Button
        Me._FrameSub_2 = New System.Windows.Forms.GroupBox
        Me.TxtGeneralRuleoutSub = New System.Windows.Forms.TextBox
        Me._LableSub_7 = New System.Windows.Forms.Label
        Me._FrameSub_3 = New System.Windows.Forms.GroupBox
        Me.TxtFemaleLowerWeightSub = New System.Windows.Forms.TextBox
        Me.TxtFemaleUpperWeightSub = New System.Windows.Forms.TextBox
        Me.TxtMaleUpperSub = New System.Windows.Forms.TextBox
        Me.TxtFemaleUpperSub = New System.Windows.Forms.TextBox
        Me.TxtMaleLowerSub = New System.Windows.Forms.TextBox
        Me.TxtFemaleLowerSub = New System.Windows.Forms.TextBox
        Me.TxtUpperWeightSub = New System.Windows.Forms.TextBox
        Me.TxtLowerWeightSub = New System.Windows.Forms.TextBox
        Me.ChkReferNonPotentialSub = New System.Windows.Forms.CheckBox
        Me._LableSub_20 = New System.Windows.Forms.Label
        Me._LableSub_21 = New System.Windows.Forms.Label
        Me._LableSub_19 = New System.Windows.Forms.Label
        Me._LableSub_15 = New System.Windows.Forms.Label
        Me._LableSub_12 = New System.Windows.Forms.Label
        Me._Lable_37 = New System.Windows.Forms.Label
        Me._LableSub_13 = New System.Windows.Forms.Label
        Me._LableSub_14 = New System.Windows.Forms.Label
        Me._LableSub_11 = New System.Windows.Forms.Label
        Me._LableSub_10 = New System.Windows.Forms.Label
        Me._LableSub_18 = New System.Windows.Forms.Label
        Me._LableSub_17 = New System.Windows.Forms.Label
        Me._LableSub_6 = New System.Windows.Forms.Label
        Me._FrameSub_6 = New System.Windows.Forms.GroupBox
        Me.ChkNotAppropriateMaleSub = New System.Windows.Forms.CheckBox
        Me.ChkNotAppropriateFemaleSub = New System.Windows.Forms.CheckBox
        Me._SSTab2_TabPage1 = New System.Windows.Forms.TabPage
        Me._Frame_17 = New System.Windows.Forms.GroupBox
        Me.cmdAddConditional = New System.Windows.Forms.Button
        Me.cmdRemoveConditional = New System.Windows.Forms.Button
        Me.LstViewConditionals = New System.Windows.Forms.ListView
        Me.Label15 = New System.Windows.Forms.Label
        Me.Label14 = New System.Windows.Forms.Label
        Me._cboSubtypeProcessor_0 = New System.Windows.Forms.ComboBox
        Me._SSTab1_TabPage4 = New System.Windows.Forms.TabPage
        Me._cboSubtypeProcessor_1 = New System.Windows.Forms.ComboBox
        Me._Frame_19 = New System.Windows.Forms.GroupBox
        Me._FrameSub_10 = New System.Windows.Forms.GroupBox
        Me.chkCoronerOnlySub = New System.Windows.Forms.CheckBox
        Me.ChkContactOnStatlineConsentSub = New System.Windows.Forms.CheckBox
        Me.ChkContactOnStatlineSecondarySub = New System.Windows.Forms.CheckBox
        Me.ChkContactOnCoronerSub = New System.Windows.Forms.CheckBox
        Me.ChkContactOnHospitalConsentSub = New System.Windows.Forms.CheckBox
        Me.ChkContactOnConsentSub = New System.Windows.Forms.CheckBox
        Me.ChkNoContactOnDenySub = New System.Windows.Forms.CheckBox
        Me._FrameSub_9 = New System.Windows.Forms.GroupBox
        Me.ChkResearchSub = New System.Windows.Forms.CheckBox
        Me.ChkOrgansSub = New System.Windows.Forms.CheckBox
        Me.ChkSkinSub = New System.Windows.Forms.CheckBox
        Me.ChkHeartValvesSub = New System.Windows.Forms.CheckBox
        Me.ChkBoneSub = New System.Windows.Forms.CheckBox
        Me.ChkEyesSub = New System.Windows.Forms.CheckBox
        Me.ChkSoftTissueSub = New System.Windows.Forms.CheckBox
        Me.cboOrganizationSub = New System.Windows.Forms.ComboBox
        Me.cboScheduleGroupSub = New System.Windows.Forms.ComboBox
        Me.cmdRemoveScheduleSub = New System.Windows.Forms.Button
        Me.cmdAddScheduleSub = New System.Windows.Forms.Button
        Me.LstViewScheduleSub = New System.Windows.Forms.ListView
        Me.Label1Sub = New System.Windows.Forms.Label
        Me._Label_3 = New System.Windows.Forms.Label
        Me._Label_4 = New System.Windows.Forms.Label
        Me._Label_5 = New System.Windows.Forms.Label
        Me.Label12 = New System.Windows.Forms.Label
        Me.Frame = New Microsoft.VisualBasic.Compatibility.VB6.GroupBoxArray(Me.components)
        Me.FrameSub = New Microsoft.VisualBasic.Compatibility.VB6.GroupBoxArray(Me.components)
        Me.Label = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(Me.components)
        Me.Lable = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(Me.components)
        Me.LableSub = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(Me.components)
        Me.Pic = New Microsoft.VisualBasic.Compatibility.VB6.PanelArray(Me.components)
        Me.cboSubtypeProcessor = New Microsoft.VisualBasic.Compatibility.VB6.ComboBoxArray(Me.components)
        Me._Frame_1.SuspendLayout()
        Me.TabCriteria.SuspendLayout()
        Me._TabCriteria_TabPage0.SuspendLayout()
        Me._Pic_0.SuspendLayout()
        Me._Frame_2.SuspendLayout()
        Me._Frame_3.SuspendLayout()
        Me._Frame_4.SuspendLayout()
        Me._Frame_6.SuspendLayout()
        Me._Pic_1.SuspendLayout()
        Me._Frame_7.SuspendLayout()
        Me._TabCriteria_TabPage1.SuspendLayout()
        Me._Frame_0.SuspendLayout()
        Me._TabCriteria_TabPage2.SuspendLayout()
        Me._Frame_5.SuspendLayout()
        Me._TabCriteria_TabPage3.SuspendLayout()
        Me._Frame_8.SuspendLayout()
        Me._Frame_10.SuspendLayout()
        Me._Frame_9.SuspendLayout()
        Me._TabCriteria_TabPage4.SuspendLayout()
        Me.Picture1.SuspendLayout()
        Me.SSTab1.SuspendLayout()
        Me._SSTab1_TabPage0.SuspendLayout()
        Me._Frame_11.SuspendLayout()
        Me._SSTab1_TabPage1.SuspendLayout()
        Me._Frame_13.SuspendLayout()
        Me._SSTab1_TabPage2.SuspendLayout()
        Me._Frame_12.SuspendLayout()
        Me._SSTab1_TabPage3.SuspendLayout()
        Me.SSTab2.SuspendLayout()
        Me._SSTab2_TabPage0.SuspendLayout()
        Me._FrameSub_2.SuspendLayout()
        Me._FrameSub_3.SuspendLayout()
        Me._FrameSub_6.SuspendLayout()
        Me._SSTab2_TabPage1.SuspendLayout()
        Me._Frame_17.SuspendLayout()
        Me._SSTab1_TabPage4.SuspendLayout()
        Me._Frame_19.SuspendLayout()
        Me._FrameSub_10.SuspendLayout()
        Me._FrameSub_9.SuspendLayout()
        CType(Me.Frame, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.FrameSub, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.Label, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.Lable, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.LableSub, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.Pic, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.cboSubtypeProcessor, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'cmdTemp
        '
        Me.cmdTemp.BackColor = System.Drawing.SystemColors.Control
        Me.cmdTemp.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdTemp.Enabled = False
        Me.cmdTemp.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdTemp.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdTemp.Location = New System.Drawing.Point(696, 56)
        Me.cmdTemp.Name = "cmdTemp"
        Me.cmdTemp.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdTemp.Size = New System.Drawing.Size(81, 17)
        Me.cmdTemp.TabIndex = 183
        Me.cmdTemp.TabStop = False
        Me.cmdTemp.Text = "Test Commit"
        Me.cmdTemp.UseVisualStyleBackColor = False
        Me.cmdTemp.Visible = False
        '
        'CmdCancel
        '
        Me.CmdCancel.BackColor = System.Drawing.SystemColors.Control
        Me.CmdCancel.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdCancel.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdCancel.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdCancel.Location = New System.Drawing.Point(692, 32)
        Me.CmdCancel.Name = "CmdCancel"
        Me.CmdCancel.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdCancel.Size = New System.Drawing.Size(80, 21)
        Me.CmdCancel.TabIndex = 25
        Me.CmdCancel.Text = "&Cancel"
        Me.CmdCancel.UseVisualStyleBackColor = False
        '
        '_Frame_1
        '
        Me._Frame_1.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_1.Controls.Add(Me.CboDonorTracCriteriaGroup)
        Me._Frame_1.Controls.Add(Me.CmdMapCategory)
        Me._Frame_1.Controls.Add(Me.CmdCriteriaGroupDetail)
        Me._Frame_1.Controls.Add(Me.CboCriteriaGroup)
        Me._Frame_1.Controls.Add(Me.CboDonorCategory)
        Me._Frame_1.Controls.Add(Me.Label5)
        Me._Frame_1.Controls.Add(Me._Lable_1)
        Me._Frame_1.Controls.Add(Me._Lable_0)
        Me._Frame_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_1, CType(1, Short))
        Me._Frame_1.Location = New System.Drawing.Point(4, 0)
        Me._Frame_1.Name = "_Frame_1"
        Me._Frame_1.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_1.Size = New System.Drawing.Size(683, 75)
        Me._Frame_1.TabIndex = 0
        Me._Frame_1.TabStop = False
        '
        'CboDonorTracCriteriaGroup
        '
        Me.CboDonorTracCriteriaGroup.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboDonorTracCriteriaGroup.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboDonorTracCriteriaGroup.BackColor = System.Drawing.SystemColors.Window
        Me.CboDonorTracCriteriaGroup.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboDonorTracCriteriaGroup.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboDonorTracCriteriaGroup.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboDonorTracCriteriaGroup.Location = New System.Drawing.Point(504, 40)
        Me.CboDonorTracCriteriaGroup.Name = "CboDonorTracCriteriaGroup"
        Me.CboDonorTracCriteriaGroup.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboDonorTracCriteriaGroup.Size = New System.Drawing.Size(161, 22)
        Me.CboDonorTracCriteriaGroup.TabIndex = 4
        '
        'CmdMapCategory
        '
        Me.CmdMapCategory.BackColor = System.Drawing.SystemColors.Control
        Me.CmdMapCategory.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdMapCategory.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdMapCategory.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdMapCategory.Location = New System.Drawing.Point(232, 15)
        Me.CmdMapCategory.Name = "CmdMapCategory"
        Me.CmdMapCategory.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdMapCategory.Size = New System.Drawing.Size(83, 21)
        Me.CmdMapCategory.TabIndex = 1
        Me.CmdMapCategory.Text = "Category Map"
        Me.CmdMapCategory.UseVisualStyleBackColor = False
        Me.CmdMapCategory.Visible = False
        '
        'CmdCriteriaGroupDetail
        '
        Me.CmdCriteriaGroupDetail.BackColor = System.Drawing.SystemColors.Control
        Me.CmdCriteriaGroupDetail.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdCriteriaGroupDetail.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdCriteriaGroupDetail.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdCriteriaGroupDetail.Location = New System.Drawing.Point(328, 41)
        Me.CmdCriteriaGroupDetail.Name = "CmdCriteriaGroupDetail"
        Me.CmdCriteriaGroupDetail.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdCriteriaGroupDetail.Size = New System.Drawing.Size(17, 21)
        Me.CmdCriteriaGroupDetail.TabIndex = 3
        Me.CmdCriteriaGroupDetail.Text = "..."
        Me.CmdCriteriaGroupDetail.UseVisualStyleBackColor = False
        '
        'CboCriteriaGroup
        '
        Me.CboCriteriaGroup.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboCriteriaGroup.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboCriteriaGroup.BackColor = System.Drawing.SystemColors.Window
        Me.CboCriteriaGroup.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboCriteriaGroup.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboCriteriaGroup.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboCriteriaGroup.Location = New System.Drawing.Point(88, 40)
        Me.CboCriteriaGroup.Name = "CboCriteriaGroup"
        Me.CboCriteriaGroup.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboCriteriaGroup.Size = New System.Drawing.Size(235, 22)
        Me.CboCriteriaGroup.Sorted = True
        Me.CboCriteriaGroup.TabIndex = 2
        '
        'CboDonorCategory
        '
        Me.CboDonorCategory.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboDonorCategory.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboDonorCategory.BackColor = System.Drawing.SystemColors.Window
        Me.CboDonorCategory.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboDonorCategory.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboDonorCategory.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboDonorCategory.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboDonorCategory.Location = New System.Drawing.Point(88, 14)
        Me.CboDonorCategory.Name = "CboDonorCategory"
        Me.CboDonorCategory.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboDonorCategory.Size = New System.Drawing.Size(137, 22)
        Me.CboDonorCategory.TabIndex = 0
        '
        'Label5
        '
        Me.Label5.AutoSize = True
        Me.Label5.BackColor = System.Drawing.SystemColors.Control
        Me.Label5.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label5.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label5.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label5.Location = New System.Drawing.Point(373, 44)
        Me.Label5.Name = "Label5"
        Me.Label5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label5.Size = New System.Drawing.Size(128, 14)
        Me.Label5.TabIndex = 189
        Me.Label5.Text = "DonorTrac Criteria Group"
        '
        '_Lable_1
        '
        Me._Lable_1.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_1, CType(1, Short))
        Me._Lable_1.Location = New System.Drawing.Point(8, 43)
        Me._Lable_1.Name = "_Lable_1"
        Me._Lable_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_1.Size = New System.Drawing.Size(77, 17)
        Me._Lable_1.TabIndex = 28
        Me._Lable_1.Text = "Criteria Group"
        '
        '_Lable_0
        '
        Me._Lable_0.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_0, CType(0, Short))
        Me._Lable_0.Location = New System.Drawing.Point(8, 17)
        Me._Lable_0.Name = "_Lable_0"
        Me._Lable_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_0.Size = New System.Drawing.Size(83, 17)
        Me._Lable_0.TabIndex = 27
        Me._Lable_0.Text = "Donor Category"
        '
        'CmdOK
        '
        Me.CmdOK.BackColor = System.Drawing.SystemColors.Control
        Me.CmdOK.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdOK.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdOK.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdOK.Location = New System.Drawing.Point(692, 6)
        Me.CmdOK.Name = "CmdOK"
        Me.CmdOK.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdOK.Size = New System.Drawing.Size(80, 21)
        Me.CmdOK.TabIndex = 24
        Me.CmdOK.Text = "&Save"
        Me.CmdOK.UseVisualStyleBackColor = False
        '
        'TabCriteria
        '
        Me.TabCriteria.Controls.Add(Me._TabCriteria_TabPage0)
        Me.TabCriteria.Controls.Add(Me._TabCriteria_TabPage1)
        Me.TabCriteria.Controls.Add(Me._TabCriteria_TabPage2)
        Me.TabCriteria.Controls.Add(Me._TabCriteria_TabPage3)
        Me.TabCriteria.Controls.Add(Me._TabCriteria_TabPage4)
        Me.TabCriteria.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TabCriteria.ItemSize = New System.Drawing.Size(42, 18)
        Me.TabCriteria.Location = New System.Drawing.Point(6, 80)
        Me.TabCriteria.Name = "TabCriteria"
        Me.TabCriteria.SelectedIndex = 0
        Me.TabCriteria.Size = New System.Drawing.Size(765, 481)
        Me.TabCriteria.TabIndex = 1
        '
        '_TabCriteria_TabPage0
        '
        Me._TabCriteria_TabPage0.Controls.Add(Me._Pic_0)
        Me._TabCriteria_TabPage0.Controls.Add(Me._Pic_1)
        Me._TabCriteria_TabPage0.Location = New System.Drawing.Point(4, 22)
        Me._TabCriteria_TabPage0.Name = "_TabCriteria_TabPage0"
        Me._TabCriteria_TabPage0.Size = New System.Drawing.Size(757, 455)
        Me._TabCriteria_TabPage0.TabIndex = 0
        Me._TabCriteria_TabPage0.Text = "Donor Criteria"
        '
        '_Pic_0
        '
        Me._Pic_0.BackColor = System.Drawing.SystemColors.Control
        Me._Pic_0.Controls.Add(Me._Frame_2)
        Me._Pic_0.Controls.Add(Me._Frame_3)
        Me._Pic_0.Controls.Add(Me._Frame_4)
        Me._Pic_0.Controls.Add(Me._Frame_6)
        Me._Pic_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._Pic_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Pic_0.ForeColor = System.Drawing.SystemColors.WindowText
        Me.Pic.SetIndex(Me._Pic_0, CType(0, Short))
        Me._Pic_0.Location = New System.Drawing.Point(2, 5)
        Me._Pic_0.Name = "_Pic_0"
        Me._Pic_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Pic_0.Size = New System.Drawing.Size(761, 365)
        Me._Pic_0.TabIndex = 34
        Me._Pic_0.TabStop = True
        '
        '_Frame_2
        '
        Me._Frame_2.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_2.Controls.Add(Me.TxtGeneralRuleout)
        Me._Frame_2.Controls.Add(Me._Lable_7)
        Me._Frame_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_2, CType(2, Short))
        Me._Frame_2.Location = New System.Drawing.Point(4, 240)
        Me._Frame_2.Name = "_Frame_2"
        Me._Frame_2.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_2.Size = New System.Drawing.Size(293, 119)
        Me._Frame_2.TabIndex = 50
        Me._Frame_2.TabStop = False
        Me._Frame_2.Text = "General Conditional Ruleout"
        '
        'TxtGeneralRuleout
        '
        Me.TxtGeneralRuleout.AcceptsReturn = True
        Me.TxtGeneralRuleout.BackColor = System.Drawing.SystemColors.Window
        Me.TxtGeneralRuleout.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtGeneralRuleout.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtGeneralRuleout.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtGeneralRuleout.Location = New System.Drawing.Point(8, 50)
        Me.TxtGeneralRuleout.MaxLength = 0
        Me.TxtGeneralRuleout.Multiline = True
        Me.TxtGeneralRuleout.Name = "TxtGeneralRuleout"
        Me.TxtGeneralRuleout.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtGeneralRuleout.ScrollBars = System.Windows.Forms.ScrollBars.Vertical
        Me.TxtGeneralRuleout.Size = New System.Drawing.Size(275, 59)
        Me.TxtGeneralRuleout.TabIndex = 12
        '
        '_Lable_7
        '
        Me._Lable_7.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_7.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_7.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_7, CType(7, Short))
        Me._Lable_7.Location = New System.Drawing.Point(8, 18)
        Me._Lable_7.Name = "_Lable_7"
        Me._Lable_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_7.Size = New System.Drawing.Size(273, 31)
        Me._Lable_7.TabIndex = 51
        Me._Lable_7.Text = "This message will only appear if the option is eligible or conditionally eligible" & _
            "."
        '
        '_Frame_3
        '
        Me._Frame_3.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_3.Controls.Add(Me.ChkReferNonPotential)
        Me._Frame_3.Controls.Add(Me.TxtLowerWeight)
        Me._Frame_3.Controls.Add(Me.TxtUpperWeight)
        Me._Frame_3.Controls.Add(Me.TxtFemaleLower)
        Me._Frame_3.Controls.Add(Me.TxtMaleLower)
        Me._Frame_3.Controls.Add(Me.TxtFemaleUpper)
        Me._Frame_3.Controls.Add(Me.TxtMaleUpper)
        Me._Frame_3.Controls.Add(Me._Lable_6)
        Me._Frame_3.Controls.Add(Me._Lable_17)
        Me._Frame_3.Controls.Add(Me._Lable_18)
        Me._Frame_3.Controls.Add(Me._Lable_10)
        Me._Frame_3.Controls.Add(Me._Lable_11)
        Me._Frame_3.Controls.Add(Me._Lable_14)
        Me._Frame_3.Controls.Add(Me._Lable_13)
        Me._Frame_3.Controls.Add(Me._Lable_9)
        Me._Frame_3.Controls.Add(Me._Lable_12)
        Me._Frame_3.Controls.Add(Me._Lable_15)
        Me._Frame_3.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_3, CType(3, Short))
        Me._Frame_3.Location = New System.Drawing.Point(4, 46)
        Me._Frame_3.Name = "_Frame_3"
        Me._Frame_3.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_3.Size = New System.Drawing.Size(293, 191)
        Me._Frame_3.TabIndex = 37
        Me._Frame_3.TabStop = False
        Me._Frame_3.Text = "Ruleouts"
        '
        'ChkReferNonPotential
        '
        Me.ChkReferNonPotential.BackColor = System.Drawing.SystemColors.Control
        Me.ChkReferNonPotential.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkReferNonPotential.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkReferNonPotential.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkReferNonPotential.Location = New System.Drawing.Point(12, 126)
        Me.ChkReferNonPotential.Name = "ChkReferNonPotential"
        Me.ChkReferNonPotential.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkReferNonPotential.Size = New System.Drawing.Size(277, 62)
        Me.ChkReferNonPotential.TabIndex = 11
        Me.ChkReferNonPotential.Text = "If checked, refer *all* current vent patients.  If unchecked, only refer vent pat" & _
            "ients with neuro-insult."
        Me.ChkReferNonPotential.UseVisualStyleBackColor = False
        '
        'TxtLowerWeight
        '
        Me.TxtLowerWeight.AcceptsReturn = True
        Me.TxtLowerWeight.BackColor = System.Drawing.SystemColors.Window
        Me.TxtLowerWeight.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtLowerWeight.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtLowerWeight.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtLowerWeight.Location = New System.Drawing.Point(112, 96)
        Me.TxtLowerWeight.MaxLength = 0
        Me.TxtLowerWeight.Name = "TxtLowerWeight"
        Me.TxtLowerWeight.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtLowerWeight.Size = New System.Drawing.Size(31, 20)
        Me.TxtLowerWeight.TabIndex = 9
        '
        'TxtUpperWeight
        '
        Me.TxtUpperWeight.AcceptsReturn = True
        Me.TxtUpperWeight.BackColor = System.Drawing.SystemColors.Window
        Me.TxtUpperWeight.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtUpperWeight.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtUpperWeight.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtUpperWeight.Location = New System.Drawing.Point(222, 96)
        Me.TxtUpperWeight.MaxLength = 0
        Me.TxtUpperWeight.Name = "TxtUpperWeight"
        Me.TxtUpperWeight.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtUpperWeight.Size = New System.Drawing.Size(31, 20)
        Me.TxtUpperWeight.TabIndex = 10
        '
        'TxtFemaleLower
        '
        Me.TxtFemaleLower.AcceptsReturn = True
        Me.TxtFemaleLower.BackColor = System.Drawing.SystemColors.Window
        Me.TxtFemaleLower.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtFemaleLower.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtFemaleLower.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtFemaleLower.Location = New System.Drawing.Point(112, 46)
        Me.TxtFemaleLower.MaxLength = 0
        Me.TxtFemaleLower.Name = "TxtFemaleLower"
        Me.TxtFemaleLower.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtFemaleLower.Size = New System.Drawing.Size(31, 20)
        Me.TxtFemaleLower.TabIndex = 7
        '
        'TxtMaleLower
        '
        Me.TxtMaleLower.AcceptsReturn = True
        Me.TxtMaleLower.BackColor = System.Drawing.SystemColors.Window
        Me.TxtMaleLower.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtMaleLower.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtMaleLower.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtMaleLower.Location = New System.Drawing.Point(112, 22)
        Me.TxtMaleLower.MaxLength = 0
        Me.TxtMaleLower.Name = "TxtMaleLower"
        Me.TxtMaleLower.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtMaleLower.Size = New System.Drawing.Size(31, 20)
        Me.TxtMaleLower.TabIndex = 5
        '
        'TxtFemaleUpper
        '
        Me.TxtFemaleUpper.AcceptsReturn = True
        Me.TxtFemaleUpper.BackColor = System.Drawing.SystemColors.Window
        Me.TxtFemaleUpper.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtFemaleUpper.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtFemaleUpper.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtFemaleUpper.Location = New System.Drawing.Point(222, 46)
        Me.TxtFemaleUpper.MaxLength = 0
        Me.TxtFemaleUpper.Name = "TxtFemaleUpper"
        Me.TxtFemaleUpper.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtFemaleUpper.Size = New System.Drawing.Size(31, 20)
        Me.TxtFemaleUpper.TabIndex = 8
        '
        'TxtMaleUpper
        '
        Me.TxtMaleUpper.AcceptsReturn = True
        Me.TxtMaleUpper.BackColor = System.Drawing.SystemColors.Window
        Me.TxtMaleUpper.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtMaleUpper.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtMaleUpper.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtMaleUpper.Location = New System.Drawing.Point(222, 22)
        Me.TxtMaleUpper.MaxLength = 0
        Me.TxtMaleUpper.Name = "TxtMaleUpper"
        Me.TxtMaleUpper.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtMaleUpper.Size = New System.Drawing.Size(31, 20)
        Me.TxtMaleUpper.TabIndex = 6
        '
        '_Lable_6
        '
        Me._Lable_6.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_6.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_6.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_6, CType(6, Short))
        Me._Lable_6.Location = New System.Drawing.Point(76, 100)
        Me._Lable_6.Name = "_Lable_6"
        Me._Lable_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_6.Size = New System.Drawing.Size(93, 15)
        Me._Lable_6.TabIndex = 54
        Me._Lable_6.Text = "Lower              kg"
        '
        '_Lable_17
        '
        Me._Lable_17.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_17.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_17.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_17.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_17, CType(17, Short))
        Me._Lable_17.Location = New System.Drawing.Point(186, 100)
        Me._Lable_17.Name = "_Lable_17"
        Me._Lable_17.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_17.Size = New System.Drawing.Size(103, 15)
        Me._Lable_17.TabIndex = 53
        Me._Lable_17.Text = "Upper              kg"
        '
        '_Lable_18
        '
        Me._Lable_18.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_18.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_18.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_18.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_18, CType(18, Short))
        Me._Lable_18.Location = New System.Drawing.Point(12, 100)
        Me._Lable_18.Name = "_Lable_18"
        Me._Lable_18.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_18.Size = New System.Drawing.Size(61, 15)
        Me._Lable_18.TabIndex = 52
        Me._Lable_18.Text = "Weight:"
        '
        '_Lable_10
        '
        Me._Lable_10.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_10.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_10.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_10.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_10, CType(10, Short))
        Me._Lable_10.Location = New System.Drawing.Point(76, 26)
        Me._Lable_10.Name = "_Lable_10"
        Me._Lable_10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_10.Size = New System.Drawing.Size(109, 15)
        Me._Lable_10.TabIndex = 44
        Me._Lable_10.Text = "Lower              mos."
        '
        '_Lable_11
        '
        Me._Lable_11.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_11.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_11.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_11.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_11, CType(11, Short))
        Me._Lable_11.Location = New System.Drawing.Point(186, 26)
        Me._Lable_11.Name = "_Lable_11"
        Me._Lable_11.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_11.Size = New System.Drawing.Size(103, 15)
        Me._Lable_11.TabIndex = 43
        Me._Lable_11.Text = "Upper              yrs."
        '
        '_Lable_14
        '
        Me._Lable_14.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_14.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_14.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_14.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_14, CType(14, Short))
        Me._Lable_14.Location = New System.Drawing.Point(12, 48)
        Me._Lable_14.Name = "_Lable_14"
        Me._Lable_14.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_14.Size = New System.Drawing.Size(67, 15)
        Me._Lable_14.TabIndex = 42
        Me._Lable_14.Text = "Age Female:"
        '
        '_Lable_13
        '
        Me._Lable_13.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_13.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_13.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_13.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_13, CType(13, Short))
        Me._Lable_13.Location = New System.Drawing.Point(186, 50)
        Me._Lable_13.Name = "_Lable_13"
        Me._Lable_13.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_13.Size = New System.Drawing.Size(103, 15)
        Me._Lable_13.TabIndex = 41
        Me._Lable_13.Text = "Upper              yrs."
        '
        '_Lable_9
        '
        Me._Lable_9.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_9.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_9.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_9.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_9, CType(9, Short))
        Me._Lable_9.Location = New System.Drawing.Point(186, 70)
        Me._Lable_9.Name = "_Lable_9"
        Me._Lable_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_9.Size = New System.Drawing.Size(85, 15)
        Me._Lable_9.TabIndex = 40
        Me._Lable_9.Text = "* Ages inclusive"
        '
        '_Lable_12
        '
        Me._Lable_12.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_12.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_12.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_12.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_12, CType(12, Short))
        Me._Lable_12.Location = New System.Drawing.Point(12, 26)
        Me._Lable_12.Name = "_Lable_12"
        Me._Lable_12.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_12.Size = New System.Drawing.Size(63, 15)
        Me._Lable_12.TabIndex = 39
        Me._Lable_12.Text = "Age Male:"
        '
        '_Lable_15
        '
        Me._Lable_15.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_15.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_15.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_15.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_15, CType(15, Short))
        Me._Lable_15.Location = New System.Drawing.Point(76, 50)
        Me._Lable_15.Name = "_Lable_15"
        Me._Lable_15.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_15.Size = New System.Drawing.Size(109, 15)
        Me._Lable_15.TabIndex = 38
        Me._Lable_15.Text = "Lower              mos."
        '
        '_Frame_4
        '
        Me._Frame_4.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_4.Controls.Add(Me.CmdIndicationRemove)
        Me._Frame_4.Controls.Add(Me.CmdIndicationAdd)
        Me._Frame_4.Controls.Add(Me.LstViewIndication)
        Me._Frame_4.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_4.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_4, CType(4, Short))
        Me._Frame_4.Location = New System.Drawing.Point(306, 6)
        Me._Frame_4.Name = "_Frame_4"
        Me._Frame_4.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_4.Size = New System.Drawing.Size(449, 353)
        Me._Frame_4.TabIndex = 36
        Me._Frame_4.TabStop = False
        Me._Frame_4.Text = "Non-standard and conditional medical ruleouts"
        '
        'CmdIndicationRemove
        '
        Me.CmdIndicationRemove.BackColor = System.Drawing.SystemColors.Control
        Me.CmdIndicationRemove.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdIndicationRemove.Enabled = False
        Me.CmdIndicationRemove.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdIndicationRemove.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdIndicationRemove.Location = New System.Drawing.Point(84, 22)
        Me.CmdIndicationRemove.Name = "CmdIndicationRemove"
        Me.CmdIndicationRemove.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdIndicationRemove.Size = New System.Drawing.Size(67, 21)
        Me.CmdIndicationRemove.TabIndex = 14
        Me.CmdIndicationRemove.Text = "&Remove"
        Me.CmdIndicationRemove.UseVisualStyleBackColor = False
        '
        'CmdIndicationAdd
        '
        Me.CmdIndicationAdd.BackColor = System.Drawing.SystemColors.Control
        Me.CmdIndicationAdd.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdIndicationAdd.Enabled = False
        Me.CmdIndicationAdd.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdIndicationAdd.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdIndicationAdd.Location = New System.Drawing.Point(10, 22)
        Me.CmdIndicationAdd.Name = "CmdIndicationAdd"
        Me.CmdIndicationAdd.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdIndicationAdd.Size = New System.Drawing.Size(67, 21)
        Me.CmdIndicationAdd.TabIndex = 13
        Me.CmdIndicationAdd.Text = "&Add..."
        Me.CmdIndicationAdd.UseVisualStyleBackColor = False
        '
        'LstViewIndication
        '
        Me.LstViewIndication.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewIndication.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.LstViewIndication.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewIndication.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewIndication.FullRowSelect = True
        Me.LstViewIndication.HideSelection = False
        Me.LstViewIndication.LabelWrap = False
        Me.LstViewIndication.Location = New System.Drawing.Point(8, 48)
        Me.LstViewIndication.Name = "LstViewIndication"
        Me.LstViewIndication.Size = New System.Drawing.Size(429, 295)
        Me.LstViewIndication.TabIndex = 15
        Me.LstViewIndication.TabStop = False
        Me.LstViewIndication.UseCompatibleStateImageBehavior = False
        Me.LstViewIndication.View = System.Windows.Forms.View.Details
        '
        '_Frame_6
        '
        Me._Frame_6.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_6.Controls.Add(Me.ChkNotAppropriateFemale)
        Me._Frame_6.Controls.Add(Me.ChkNotAppropriateMale)
        Me._Frame_6.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_6.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_6, CType(6, Short))
        Me._Frame_6.Location = New System.Drawing.Point(4, 6)
        Me._Frame_6.Name = "_Frame_6"
        Me._Frame_6.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_6.Size = New System.Drawing.Size(293, 37)
        Me._Frame_6.TabIndex = 35
        Me._Frame_6.TabStop = False
        '
        'ChkNotAppropriateFemale
        '
        Me.ChkNotAppropriateFemale.BackColor = System.Drawing.SystemColors.Control
        Me.ChkNotAppropriateFemale.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkNotAppropriateFemale.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkNotAppropriateFemale.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkNotAppropriateFemale.Location = New System.Drawing.Point(146, 13)
        Me.ChkNotAppropriateFemale.Name = "ChkNotAppropriateFemale"
        Me.ChkNotAppropriateFemale.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkNotAppropriateFemale.Size = New System.Drawing.Size(143, 19)
        Me.ChkNotAppropriateFemale.TabIndex = 4
        Me.ChkNotAppropriateFemale.Text = "Female Not Appropriate"
        Me.ChkNotAppropriateFemale.UseVisualStyleBackColor = False
        '
        'ChkNotAppropriateMale
        '
        Me.ChkNotAppropriateMale.BackColor = System.Drawing.SystemColors.Control
        Me.ChkNotAppropriateMale.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkNotAppropriateMale.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkNotAppropriateMale.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkNotAppropriateMale.Location = New System.Drawing.Point(8, 13)
        Me.ChkNotAppropriateMale.Name = "ChkNotAppropriateMale"
        Me.ChkNotAppropriateMale.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkNotAppropriateMale.Size = New System.Drawing.Size(137, 19)
        Me.ChkNotAppropriateMale.TabIndex = 3
        Me.ChkNotAppropriateMale.Text = "Male Not Appropriate"
        Me.ChkNotAppropriateMale.UseVisualStyleBackColor = False
        '
        '_Pic_1
        '
        Me._Pic_1.BackColor = System.Drawing.SystemColors.Control
        Me._Pic_1.Controls.Add(Me._Frame_7)
        Me._Pic_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._Pic_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Pic_1.ForeColor = System.Drawing.SystemColors.WindowText
        Me.Pic.SetIndex(Me._Pic_1, CType(1, Short))
        Me._Pic_1.Location = New System.Drawing.Point(2, 5)
        Me._Pic_1.Name = "_Pic_1"
        Me._Pic_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Pic_1.Size = New System.Drawing.Size(755, 365)
        Me._Pic_1.TabIndex = 45
        Me._Pic_1.TabStop = True
        '
        '_Frame_7
        '
        Me._Frame_7.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_7.Controls.Add(Me.TxtVerifyMessage)
        Me._Frame_7.Controls.Add(Me._Lable_16)
        Me._Frame_7.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_7.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_7, CType(7, Short))
        Me._Frame_7.Location = New System.Drawing.Point(8, 10)
        Me._Frame_7.Name = "_Frame_7"
        Me._Frame_7.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_7.Size = New System.Drawing.Size(293, 157)
        Me._Frame_7.TabIndex = 46
        Me._Frame_7.TabStop = False
        Me._Frame_7.Text = "Verify Message"
        '
        'TxtVerifyMessage
        '
        Me.TxtVerifyMessage.AcceptsReturn = True
        Me.TxtVerifyMessage.BackColor = System.Drawing.SystemColors.Window
        Me.TxtVerifyMessage.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtVerifyMessage.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtVerifyMessage.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtVerifyMessage.Location = New System.Drawing.Point(10, 60)
        Me.TxtVerifyMessage.MaxLength = 200
        Me.TxtVerifyMessage.Multiline = True
        Me.TxtVerifyMessage.Name = "TxtVerifyMessage"
        Me.TxtVerifyMessage.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtVerifyMessage.ScrollBars = System.Windows.Forms.ScrollBars.Vertical
        Me.TxtVerifyMessage.Size = New System.Drawing.Size(271, 85)
        Me.TxtVerifyMessage.TabIndex = 47
        '
        '_Lable_16
        '
        Me._Lable_16.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_16.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_16.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_16.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_16, CType(16, Short))
        Me._Lable_16.Location = New System.Drawing.Point(10, 16)
        Me._Lable_16.Name = "_Lable_16"
        Me._Lable_16.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_16.Size = New System.Drawing.Size(269, 39)
        Me._Lable_16.TabIndex = 48
        Me._Lable_16.Text = "This note will appear when the ""Verify"" button is clicked. It is designed to be u" & _
            "sed as a way of communicating a general message not specific to a donor category" & _
            "."
        '
        '_TabCriteria_TabPage1
        '
        Me._TabCriteria_TabPage1.Controls.Add(Me._Frame_0)
        Me._TabCriteria_TabPage1.Location = New System.Drawing.Point(4, 22)
        Me._TabCriteria_TabPage1.Name = "_TabCriteria_TabPage1"
        Me._TabCriteria_TabPage1.Size = New System.Drawing.Size(757, 455)
        Me._TabCriteria_TabPage1.TabIndex = 1
        Me._TabCriteria_TabPage1.Text = "Applies To"
        '
        '_Frame_0
        '
        Me._Frame_0.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_0.Controls.Add(Me.CmdUnassigned)
        Me._Frame_0.Controls.Add(Me.CmdSelect)
        Me._Frame_0.Controls.Add(Me.CmdDeselect)
        Me._Frame_0.Controls.Add(Me.CboOrganizationType)
        Me._Frame_0.Controls.Add(Me.CmdFind)
        Me._Frame_0.Controls.Add(Me.CboState)
        Me._Frame_0.Controls.Add(Me.LstViewSelectedOrganizations)
        Me._Frame_0.Controls.Add(Me.LstViewAvailableOrganizations)
        Me._Frame_0.Controls.Add(Me._Lable_3)
        Me._Frame_0.Controls.Add(Me._Lable_5)
        Me._Frame_0.Controls.Add(Me._Lable_2)
        Me._Frame_0.Controls.Add(Me._Lable_4)
        Me._Frame_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_0, CType(0, Short))
        Me._Frame_0.Location = New System.Drawing.Point(16, 40)
        Me._Frame_0.Name = "_Frame_0"
        Me._Frame_0.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_0.Size = New System.Drawing.Size(751, 353)
        Me._Frame_0.TabIndex = 29
        Me._Frame_0.TabStop = False
        '
        'CmdUnassigned
        '
        Me.CmdUnassigned.BackColor = System.Drawing.SystemColors.Control
        Me.CmdUnassigned.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdUnassigned.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdUnassigned.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdUnassigned.Location = New System.Drawing.Point(274, 38)
        Me.CmdUnassigned.Name = "CmdUnassigned"
        Me.CmdUnassigned.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdUnassigned.Size = New System.Drawing.Size(69, 21)
        Me.CmdUnassigned.TabIndex = 49
        Me.CmdUnassigned.Text = "&Unassigned"
        Me.CmdUnassigned.UseVisualStyleBackColor = False
        '
        'CmdSelect
        '
        Me.CmdSelect.BackColor = System.Drawing.SystemColors.Control
        Me.CmdSelect.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdSelect.Enabled = False
        Me.CmdSelect.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdSelect.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdSelect.Location = New System.Drawing.Point(350, 168)
        Me.CmdSelect.Name = "CmdSelect"
        Me.CmdSelect.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdSelect.Size = New System.Drawing.Size(53, 21)
        Me.CmdSelect.TabIndex = 21
        Me.CmdSelect.Text = "Add  >>"
        Me.CmdSelect.UseVisualStyleBackColor = False
        '
        'CmdDeselect
        '
        Me.CmdDeselect.BackColor = System.Drawing.SystemColors.Control
        Me.CmdDeselect.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdDeselect.Enabled = False
        Me.CmdDeselect.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdDeselect.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdDeselect.Location = New System.Drawing.Point(350, 194)
        Me.CmdDeselect.Name = "CmdDeselect"
        Me.CmdDeselect.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdDeselect.Size = New System.Drawing.Size(54, 21)
        Me.CmdDeselect.TabIndex = 22
        Me.CmdDeselect.Text = "Remove"
        Me.CmdDeselect.UseVisualStyleBackColor = False
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
        Me.CboOrganizationType.Size = New System.Drawing.Size(141, 22)
        Me.CboOrganizationType.Sorted = True
        Me.CboOrganizationType.TabIndex = 18
        '
        'CmdFind
        '
        Me.CmdFind.BackColor = System.Drawing.SystemColors.Control
        Me.CmdFind.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdFind.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdFind.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdFind.Location = New System.Drawing.Point(274, 16)
        Me.CmdFind.Name = "CmdFind"
        Me.CmdFind.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdFind.Size = New System.Drawing.Size(69, 21)
        Me.CmdFind.TabIndex = 19
        Me.CmdFind.Text = "&Find"
        Me.CmdFind.UseVisualStyleBackColor = False
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
        Me.CboState.Size = New System.Drawing.Size(51, 22)
        Me.CboState.Sorted = True
        Me.CboState.TabIndex = 17
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
        Me.LstViewSelectedOrganizations.TabIndex = 23
        Me.LstViewSelectedOrganizations.UseCompatibleStateImageBehavior = False
        Me.LstViewSelectedOrganizations.View = System.Windows.Forms.View.Details
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
        Me.LstViewAvailableOrganizations.TabIndex = 20
        Me.LstViewAvailableOrganizations.UseCompatibleStateImageBehavior = False
        Me.LstViewAvailableOrganizations.View = System.Windows.Forms.View.Details
        '
        '_Lable_3
        '
        Me._Lable_3.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_3.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_3, CType(3, Short))
        Me._Lable_3.Location = New System.Drawing.Point(410, 46)
        Me._Lable_3.Name = "_Lable_3"
        Me._Lable_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_3.Size = New System.Drawing.Size(137, 17)
        Me._Lable_3.TabIndex = 33
        Me._Lable_3.Text = "Selected Organizations"
        '
        '_Lable_5
        '
        Me._Lable_5.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_5.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_5.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_5, CType(5, Short))
        Me._Lable_5.Location = New System.Drawing.Point(98, 18)
        Me._Lable_5.Name = "_Lable_5"
        Me._Lable_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_5.Size = New System.Drawing.Size(55, 17)
        Me._Lable_5.TabIndex = 32
        Me._Lable_5.Text = "Type"
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
        Me._Lable_2.TabIndex = 31
        Me._Lable_2.Text = "Available Organizations"
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
        Me._Lable_4.TabIndex = 30
        Me._Lable_4.Text = "State"
        '
        '_TabCriteria_TabPage2
        '
        Me._TabCriteria_TabPage2.Controls.Add(Me._Frame_5)
        Me._TabCriteria_TabPage2.Location = New System.Drawing.Point(4, 22)
        Me._TabCriteria_TabPage2.Name = "_TabCriteria_TabPage2"
        Me._TabCriteria_TabPage2.Size = New System.Drawing.Size(757, 455)
        Me._TabCriteria_TabPage2.TabIndex = 2
        Me._TabCriteria_TabPage2.Text = "Source Codes"
        '
        '_Frame_5
        '
        Me._Frame_5.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_5.Controls.Add(Me.CmdAdd)
        Me._Frame_5.Controls.Add(Me.CmdRemove)
        Me._Frame_5.Controls.Add(Me.LstViewSourceCodes)
        Me._Frame_5.Controls.Add(Me._Lable_20)
        Me._Frame_5.Controls.Add(Me._Lable_19)
        Me._Frame_5.Controls.Add(Me._Lable_21)
        Me._Frame_5.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_5.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_5, CType(5, Short))
        Me._Frame_5.Location = New System.Drawing.Point(8, 28)
        Me._Frame_5.Name = "_Frame_5"
        Me._Frame_5.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_5.Size = New System.Drawing.Size(515, 214)
        Me._Frame_5.TabIndex = 55
        Me._Frame_5.TabStop = False
        '
        'CmdAdd
        '
        Me.CmdAdd.BackColor = System.Drawing.SystemColors.Control
        Me.CmdAdd.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdAdd.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdAdd.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdAdd.Location = New System.Drawing.Point(84, 16)
        Me.CmdAdd.Name = "CmdAdd"
        Me.CmdAdd.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdAdd.Size = New System.Drawing.Size(69, 21)
        Me.CmdAdd.TabIndex = 57
        Me.CmdAdd.Text = "Add..."
        Me.CmdAdd.UseVisualStyleBackColor = False
        '
        'CmdRemove
        '
        Me.CmdRemove.BackColor = System.Drawing.SystemColors.Control
        Me.CmdRemove.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdRemove.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdRemove.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdRemove.Location = New System.Drawing.Point(160, 16)
        Me.CmdRemove.Name = "CmdRemove"
        Me.CmdRemove.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdRemove.Size = New System.Drawing.Size(69, 21)
        Me.CmdRemove.TabIndex = 56
        Me.CmdRemove.Text = "Remove"
        Me.CmdRemove.UseVisualStyleBackColor = False
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
        Me.LstViewSourceCodes.Location = New System.Drawing.Point(10, 40)
        Me.LstViewSourceCodes.Name = "LstViewSourceCodes"
        Me.LstViewSourceCodes.Size = New System.Drawing.Size(219, 159)
        Me.LstViewSourceCodes.TabIndex = 58
        Me.LstViewSourceCodes.UseCompatibleStateImageBehavior = False
        Me.LstViewSourceCodes.View = System.Windows.Forms.View.Details
        '
        '_Lable_20
        '
        Me._Lable_20.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_20.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_20.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_20.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_20, CType(20, Short))
        Me._Lable_20.Location = New System.Drawing.Point(238, 143)
        Me._Lable_20.Name = "_Lable_20"
        Me._Lable_20.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_20.Size = New System.Drawing.Size(265, 55)
        Me._Lable_20.TabIndex = 61
        Me._Lable_20.Text = "Therefore, the combination of an ""Applies To"" organization and a source code must" & _
            " be unique.  In other words, the combination can only be used once."
        '
        '_Lable_19
        '
        Me._Lable_19.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_19.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_19.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_19.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_19, CType(19, Short))
        Me._Lable_19.Location = New System.Drawing.Point(238, 40)
        Me._Lable_19.Name = "_Lable_19"
        Me._Lable_19.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_19.Size = New System.Drawing.Size(265, 98)
        Me._Lable_19.TabIndex = 60
        Me._Lable_19.Text = resources.GetString("_Lable_19.Text")
        '
        '_Lable_21
        '
        Me._Lable_21.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_21.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_21.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_21.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_21, CType(21, Short))
        Me._Lable_21.Location = New System.Drawing.Point(10, 18)
        Me._Lable_21.Name = "_Lable_21"
        Me._Lable_21.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_21.Size = New System.Drawing.Size(81, 17)
        Me._Lable_21.TabIndex = 59
        Me._Lable_21.Text = "Source Codes"
        '
        '_TabCriteria_TabPage3
        '
        Me._TabCriteria_TabPage3.Controls.Add(Me._Frame_8)
        Me._TabCriteria_TabPage3.Location = New System.Drawing.Point(4, 22)
        Me._TabCriteria_TabPage3.Name = "_TabCriteria_TabPage3"
        Me._TabCriteria_TabPage3.Size = New System.Drawing.Size(757, 455)
        Me._TabCriteria_TabPage3.TabIndex = 3
        Me._TabCriteria_TabPage3.Text = "Schedule Groups"
        '
        '_Frame_8
        '
        Me._Frame_8.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_8.Controls.Add(Me._Frame_10)
        Me._Frame_8.Controls.Add(Me._Frame_9)
        Me._Frame_8.Controls.Add(Me.CboOrganization)
        Me._Frame_8.Controls.Add(Me.CboScheduleGroup)
        Me._Frame_8.Controls.Add(Me.RemoveSchedule)
        Me._Frame_8.Controls.Add(Me.CmdAddSchedule)
        Me._Frame_8.Controls.Add(Me.LstViewSchedule)
        Me._Frame_8.Controls.Add(Me.Label1)
        Me._Frame_8.Controls.Add(Me._Label_2)
        Me._Frame_8.Controls.Add(Me._Label_1)
        Me._Frame_8.Controls.Add(Me._Label_0)
        Me._Frame_8.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_8.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_8, CType(8, Short))
        Me._Frame_8.Location = New System.Drawing.Point(8, 28)
        Me._Frame_8.Name = "_Frame_8"
        Me._Frame_8.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_8.Size = New System.Drawing.Size(723, 373)
        Me._Frame_8.TabIndex = 62
        Me._Frame_8.TabStop = False
        '
        '_Frame_10
        '
        Me._Frame_10.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_10.Controls.Add(Me.chkCoronerOnly)
        Me._Frame_10.Controls.Add(Me.ChkContactOnStatlineConsent)
        Me._Frame_10.Controls.Add(Me.ChkContactOnStatlineSecondary)
        Me._Frame_10.Controls.Add(Me.ChkContactOnCoroner)
        Me._Frame_10.Controls.Add(Me.ChkContactOnHospitalConsent)
        Me._Frame_10.Controls.Add(Me.ChkContactOnConsent)
        Me._Frame_10.Controls.Add(Me.ChkNoContactOnDeny)
        Me._Frame_10.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_10.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_10, CType(10, Short))
        Me._Frame_10.Location = New System.Drawing.Point(72, 210)
        Me._Frame_10.Name = "_Frame_10"
        Me._Frame_10.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_10.Size = New System.Drawing.Size(567, 146)
        Me._Frame_10.TabIndex = 80
        Me._Frame_10.TabStop = False
        Me._Frame_10.Text = "Contact Rules"
        '
        'chkCoronerOnly
        '
        Me.chkCoronerOnly.BackColor = System.Drawing.SystemColors.Control
        Me.chkCoronerOnly.Cursor = System.Windows.Forms.Cursors.Default
        Me.chkCoronerOnly.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.chkCoronerOnly.ForeColor = System.Drawing.SystemColors.ControlText
        Me.chkCoronerOnly.Location = New System.Drawing.Point(8, 69)
        Me.chkCoronerOnly.Name = "chkCoronerOnly"
        Me.chkCoronerOnly.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.chkCoronerOnly.Size = New System.Drawing.Size(556, 16)
        Me.chkCoronerOnly.TabIndex = 88
        Me.chkCoronerOnly.Text = "Contact group if coroner's case only"
        Me.chkCoronerOnly.UseVisualStyleBackColor = False
        '
        'ChkContactOnStatlineConsent
        '
        Me.ChkContactOnStatlineConsent.BackColor = System.Drawing.SystemColors.Control
        Me.ChkContactOnStatlineConsent.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkContactOnStatlineConsent.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkContactOnStatlineConsent.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkContactOnStatlineConsent.Location = New System.Drawing.Point(8, 120)
        Me.ChkContactOnStatlineConsent.Name = "ChkContactOnStatlineConsent"
        Me.ChkContactOnStatlineConsent.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkContactOnStatlineConsent.Size = New System.Drawing.Size(556, 16)
        Me.ChkContactOnStatlineConsent.TabIndex = 86
        Me.ChkContactOnStatlineConsent.Text = "Do not verify contact until Statline obtains consent (consent pending event creat" & _
            "ed automatically for Statline)"
        Me.ChkContactOnStatlineConsent.UseVisualStyleBackColor = False
        '
        'ChkContactOnStatlineSecondary
        '
        Me.ChkContactOnStatlineSecondary.BackColor = System.Drawing.SystemColors.Control
        Me.ChkContactOnStatlineSecondary.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkContactOnStatlineSecondary.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkContactOnStatlineSecondary.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkContactOnStatlineSecondary.Location = New System.Drawing.Point(8, 103)
        Me.ChkContactOnStatlineSecondary.Name = "ChkContactOnStatlineSecondary"
        Me.ChkContactOnStatlineSecondary.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkContactOnStatlineSecondary.Size = New System.Drawing.Size(556, 16)
        Me.ChkContactOnStatlineSecondary.TabIndex = 85
        Me.ChkContactOnStatlineSecondary.Text = "Do not verify contact until Statline performs secondary screening "
        Me.ChkContactOnStatlineSecondary.UseVisualStyleBackColor = False
        '
        'ChkContactOnCoroner
        '
        Me.ChkContactOnCoroner.BackColor = System.Drawing.SystemColors.Control
        Me.ChkContactOnCoroner.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkContactOnCoroner.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkContactOnCoroner.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkContactOnCoroner.Location = New System.Drawing.Point(8, 52)
        Me.ChkContactOnCoroner.Name = "ChkContactOnCoroner"
        Me.ChkContactOnCoroner.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkContactOnCoroner.Size = New System.Drawing.Size(556, 16)
        Me.ChkContactOnCoroner.TabIndex = 84
        Me.ChkContactOnCoroner.Text = "Contact group if coroner's case and general consent is granted"
        Me.ChkContactOnCoroner.UseVisualStyleBackColor = False
        '
        'ChkContactOnHospitalConsent
        '
        Me.ChkContactOnHospitalConsent.BackColor = System.Drawing.SystemColors.Control
        Me.ChkContactOnHospitalConsent.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkContactOnHospitalConsent.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkContactOnHospitalConsent.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkContactOnHospitalConsent.Location = New System.Drawing.Point(8, 86)
        Me.ChkContactOnHospitalConsent.Name = "ChkContactOnHospitalConsent"
        Me.ChkContactOnHospitalConsent.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkContactOnHospitalConsent.Size = New System.Drawing.Size(556, 16)
        Me.ChkContactOnHospitalConsent.TabIndex = 83
        Me.ChkContactOnHospitalConsent.Text = "Do not verify contact until hospital obtains consent (consent pending event creat" & _
            "ed automatically for hospital)"
        Me.ChkContactOnHospitalConsent.UseVisualStyleBackColor = False
        '
        'ChkContactOnConsent
        '
        Me.ChkContactOnConsent.BackColor = System.Drawing.SystemColors.Control
        Me.ChkContactOnConsent.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkContactOnConsent.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkContactOnConsent.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkContactOnConsent.Location = New System.Drawing.Point(8, 35)
        Me.ChkContactOnConsent.Name = "ChkContactOnConsent"
        Me.ChkContactOnConsent.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkContactOnConsent.Size = New System.Drawing.Size(556, 16)
        Me.ChkContactOnConsent.TabIndex = 82
        Me.ChkContactOnConsent.Text = "Contact group if option is not appropriate, yet general consent is granted"
        Me.ChkContactOnConsent.UseVisualStyleBackColor = False
        '
        'ChkNoContactOnDeny
        '
        Me.ChkNoContactOnDeny.BackColor = System.Drawing.SystemColors.Control
        Me.ChkNoContactOnDeny.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkNoContactOnDeny.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkNoContactOnDeny.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkNoContactOnDeny.Location = New System.Drawing.Point(8, 18)
        Me.ChkNoContactOnDeny.Name = "ChkNoContactOnDeny"
        Me.ChkNoContactOnDeny.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkNoContactOnDeny.Size = New System.Drawing.Size(556, 16)
        Me.ChkNoContactOnDeny.TabIndex = 81
        Me.ChkNoContactOnDeny.Text = "Do not contact group if general consent is denied"
        Me.ChkNoContactOnDeny.UseVisualStyleBackColor = False
        '
        '_Frame_9
        '
        Me._Frame_9.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_9.Controls.Add(Me.ChkResearch)
        Me._Frame_9.Controls.Add(Me.ChkOrgans)
        Me._Frame_9.Controls.Add(Me.ChkSkin)
        Me._Frame_9.Controls.Add(Me.ChkHeartValves)
        Me._Frame_9.Controls.Add(Me.ChkBone)
        Me._Frame_9.Controls.Add(Me.ChkEyes)
        Me._Frame_9.Controls.Add(Me.ChkSoftTissue)
        Me._Frame_9.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_9.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_9, CType(9, Short))
        Me._Frame_9.Location = New System.Drawing.Point(500, 52)
        Me._Frame_9.Name = "_Frame_9"
        Me._Frame_9.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_9.Size = New System.Drawing.Size(139, 155)
        Me._Frame_9.TabIndex = 71
        Me._Frame_9.TabStop = False
        '
        'ChkResearch
        '
        Me.ChkResearch.BackColor = System.Drawing.SystemColors.Control
        Me.ChkResearch.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkResearch.Enabled = False
        Me.ChkResearch.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkResearch.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkResearch.Location = New System.Drawing.Point(10, 134)
        Me.ChkResearch.Name = "ChkResearch"
        Me.ChkResearch.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkResearch.Size = New System.Drawing.Size(99, 15)
        Me.ChkResearch.TabIndex = 78
        Me.ChkResearch.Text = "Research"
        Me.ChkResearch.UseVisualStyleBackColor = False
        '
        'ChkOrgans
        '
        Me.ChkOrgans.BackColor = System.Drawing.SystemColors.Control
        Me.ChkOrgans.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkOrgans.Enabled = False
        Me.ChkOrgans.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkOrgans.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkOrgans.Location = New System.Drawing.Point(10, 14)
        Me.ChkOrgans.Name = "ChkOrgans"
        Me.ChkOrgans.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkOrgans.Size = New System.Drawing.Size(83, 15)
        Me.ChkOrgans.TabIndex = 77
        Me.ChkOrgans.Text = "Organs"
        Me.ChkOrgans.UseVisualStyleBackColor = False
        '
        'ChkSkin
        '
        Me.ChkSkin.BackColor = System.Drawing.SystemColors.Control
        Me.ChkSkin.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkSkin.Enabled = False
        Me.ChkSkin.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkSkin.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkSkin.Location = New System.Drawing.Point(10, 74)
        Me.ChkSkin.Name = "ChkSkin"
        Me.ChkSkin.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkSkin.Size = New System.Drawing.Size(85, 15)
        Me.ChkSkin.TabIndex = 76
        Me.ChkSkin.Text = "Skin"
        Me.ChkSkin.UseVisualStyleBackColor = False
        '
        'ChkHeartValves
        '
        Me.ChkHeartValves.BackColor = System.Drawing.SystemColors.Control
        Me.ChkHeartValves.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkHeartValves.Enabled = False
        Me.ChkHeartValves.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkHeartValves.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkHeartValves.Location = New System.Drawing.Point(10, 94)
        Me.ChkHeartValves.Name = "ChkHeartValves"
        Me.ChkHeartValves.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkHeartValves.Size = New System.Drawing.Size(95, 15)
        Me.ChkHeartValves.TabIndex = 75
        Me.ChkHeartValves.Text = "Heart Valves"
        Me.ChkHeartValves.UseVisualStyleBackColor = False
        '
        'ChkBone
        '
        Me.ChkBone.BackColor = System.Drawing.SystemColors.Control
        Me.ChkBone.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkBone.Enabled = False
        Me.ChkBone.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkBone.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkBone.Location = New System.Drawing.Point(10, 34)
        Me.ChkBone.Name = "ChkBone"
        Me.ChkBone.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkBone.Size = New System.Drawing.Size(97, 15)
        Me.ChkBone.TabIndex = 74
        Me.ChkBone.Text = "Bone"
        Me.ChkBone.UseVisualStyleBackColor = False
        '
        'ChkEyes
        '
        Me.ChkEyes.BackColor = System.Drawing.SystemColors.Control
        Me.ChkEyes.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkEyes.Enabled = False
        Me.ChkEyes.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkEyes.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkEyes.Location = New System.Drawing.Point(10, 114)
        Me.ChkEyes.Name = "ChkEyes"
        Me.ChkEyes.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkEyes.Size = New System.Drawing.Size(95, 15)
        Me.ChkEyes.TabIndex = 73
        Me.ChkEyes.Text = "Eyes"
        Me.ChkEyes.UseVisualStyleBackColor = False
        '
        'ChkSoftTissue
        '
        Me.ChkSoftTissue.BackColor = System.Drawing.SystemColors.Control
        Me.ChkSoftTissue.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkSoftTissue.Enabled = False
        Me.ChkSoftTissue.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkSoftTissue.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkSoftTissue.Location = New System.Drawing.Point(10, 54)
        Me.ChkSoftTissue.Name = "ChkSoftTissue"
        Me.ChkSoftTissue.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkSoftTissue.Size = New System.Drawing.Size(99, 15)
        Me.ChkSoftTissue.TabIndex = 72
        Me.ChkSoftTissue.Text = "Soft Tissue"
        Me.ChkSoftTissue.UseVisualStyleBackColor = False
        '
        'CboOrganization
        '
        Me.CboOrganization.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboOrganization.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboOrganization.BackColor = System.Drawing.SystemColors.Window
        Me.CboOrganization.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboOrganization.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboOrganization.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboOrganization.Location = New System.Drawing.Point(72, 16)
        Me.CboOrganization.Name = "CboOrganization"
        Me.CboOrganization.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboOrganization.Size = New System.Drawing.Size(255, 22)
        Me.CboOrganization.Sorted = True
        Me.CboOrganization.TabIndex = 63
        '
        'CboScheduleGroup
        '
        Me.CboScheduleGroup.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboScheduleGroup.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboScheduleGroup.BackColor = System.Drawing.SystemColors.Window
        Me.CboScheduleGroup.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboScheduleGroup.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboScheduleGroup.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboScheduleGroup.Location = New System.Drawing.Point(72, 38)
        Me.CboScheduleGroup.Name = "CboScheduleGroup"
        Me.CboScheduleGroup.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboScheduleGroup.Size = New System.Drawing.Size(255, 22)
        Me.CboScheduleGroup.Sorted = True
        Me.CboScheduleGroup.TabIndex = 64
        '
        'RemoveSchedule
        '
        Me.RemoveSchedule.BackColor = System.Drawing.SystemColors.Control
        Me.RemoveSchedule.Cursor = System.Windows.Forms.Cursors.Default
        Me.RemoveSchedule.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.RemoveSchedule.ForeColor = System.Drawing.SystemColors.ControlText
        Me.RemoveSchedule.Location = New System.Drawing.Point(148, 64)
        Me.RemoveSchedule.Name = "RemoveSchedule"
        Me.RemoveSchedule.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.RemoveSchedule.Size = New System.Drawing.Size(69, 21)
        Me.RemoveSchedule.TabIndex = 68
        Me.RemoveSchedule.Text = "Remove"
        Me.RemoveSchedule.UseVisualStyleBackColor = False
        '
        'CmdAddSchedule
        '
        Me.CmdAddSchedule.BackColor = System.Drawing.SystemColors.Control
        Me.CmdAddSchedule.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdAddSchedule.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdAddSchedule.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdAddSchedule.Location = New System.Drawing.Point(72, 64)
        Me.CmdAddSchedule.Name = "CmdAddSchedule"
        Me.CmdAddSchedule.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdAddSchedule.Size = New System.Drawing.Size(69, 21)
        Me.CmdAddSchedule.TabIndex = 66
        Me.CmdAddSchedule.Text = "Add"
        Me.CmdAddSchedule.UseVisualStyleBackColor = False
        '
        'LstViewSchedule
        '
        Me.LstViewSchedule.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewSchedule.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.LstViewSchedule.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewSchedule.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewSchedule.FullRowSelect = True
        Me.LstViewSchedule.HideSelection = False
        Me.LstViewSchedule.LabelWrap = False
        Me.LstViewSchedule.Location = New System.Drawing.Point(72, 120)
        Me.LstViewSchedule.Name = "LstViewSchedule"
        Me.LstViewSchedule.Size = New System.Drawing.Size(423, 87)
        Me.LstViewSchedule.TabIndex = 70
        Me.LstViewSchedule.UseCompatibleStateImageBehavior = False
        Me.LstViewSchedule.View = System.Windows.Forms.View.Details
        '
        'Label1
        '
        Me.Label1.BackColor = System.Drawing.SystemColors.Control
        Me.Label1.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label1.Location = New System.Drawing.Point(500, 11)
        Me.Label1.Name = "Label1"
        Me.Label1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label1.Size = New System.Drawing.Size(213, 42)
        Me.Label1.TabIndex = 79
        Me.Label1.Text = "Do not verify schedule group contact or apply contact rules if any of the followi" & _
            "ng options are also appropriate."
        '
        '_Label_2
        '
        Me._Label_2.BackColor = System.Drawing.SystemColors.Control
        Me._Label_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_2, CType(2, Short))
        Me._Label_2.Location = New System.Drawing.Point(72, 90)
        Me._Label_2.Name = "_Label_2"
        Me._Label_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_2.Size = New System.Drawing.Size(293, 31)
        Me._Label_2.TabIndex = 69
        Me._Label_2.Text = "When this option is appropriate, require contact of the following organization sc" & _
            "hedule groups."
        '
        '_Label_1
        '
        Me._Label_1.BackColor = System.Drawing.SystemColors.Control
        Me._Label_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_1, CType(1, Short))
        Me._Label_1.Location = New System.Drawing.Point(8, 42)
        Me._Label_1.Name = "_Label_1"
        Me._Label_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_1.Size = New System.Drawing.Size(69, 17)
        Me._Label_1.TabIndex = 67
        Me._Label_1.Text = "Schedule"
        '
        '_Label_0
        '
        Me._Label_0.BackColor = System.Drawing.SystemColors.Control
        Me._Label_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_0, CType(0, Short))
        Me._Label_0.Location = New System.Drawing.Point(8, 18)
        Me._Label_0.Name = "_Label_0"
        Me._Label_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_0.Size = New System.Drawing.Size(69, 17)
        Me._Label_0.TabIndex = 65
        Me._Label_0.Text = "Organization"
        '
        '_TabCriteria_TabPage4
        '
        Me._TabCriteria_TabPage4.Controls.Add(Me.Picture1)
        Me._TabCriteria_TabPage4.Location = New System.Drawing.Point(4, 22)
        Me._TabCriteria_TabPage4.Name = "_TabCriteria_TabPage4"
        Me._TabCriteria_TabPage4.Size = New System.Drawing.Size(757, 455)
        Me._TabCriteria_TabPage4.TabIndex = 4
        Me._TabCriteria_TabPage4.Text = "SubTypes"
        '
        'Picture1
        '
        Me.Picture1.BackColor = System.Drawing.SystemColors.Control
        Me.Picture1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.Picture1.Controls.Add(Me.SSTab1)
        Me.Picture1.Cursor = System.Windows.Forms.Cursors.Default
        Me.Picture1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Picture1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Picture1.Location = New System.Drawing.Point(8, 5)
        Me.Picture1.Name = "Picture1"
        Me.Picture1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Picture1.Size = New System.Drawing.Size(753, 449)
        Me.Picture1.TabIndex = 89
        Me.Picture1.TabStop = True
        '
        'SSTab1
        '
        Me.SSTab1.Controls.Add(Me._SSTab1_TabPage0)
        Me.SSTab1.Controls.Add(Me._SSTab1_TabPage1)
        Me.SSTab1.Controls.Add(Me._SSTab1_TabPage2)
        Me.SSTab1.Controls.Add(Me._SSTab1_TabPage3)
        Me.SSTab1.Controls.Add(Me._SSTab1_TabPage4)
        Me.SSTab1.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.SSTab1.ItemSize = New System.Drawing.Size(42, 18)
        Me.SSTab1.Location = New System.Drawing.Point(0, 1)
        Me.SSTab1.Name = "SSTab1"
        Me.SSTab1.SelectedIndex = 3
        Me.SSTab1.Size = New System.Drawing.Size(750, 445)
        Me.SSTab1.TabIndex = 90
        '
        '_SSTab1_TabPage0
        '
        Me._SSTab1_TabPage0.Controls.Add(Me._Frame_11)
        Me._SSTab1_TabPage0.Location = New System.Drawing.Point(4, 22)
        Me._SSTab1_TabPage0.Name = "_SSTab1_TabPage0"
        Me._SSTab1_TabPage0.Size = New System.Drawing.Size(742, 419)
        Me._SSTab1_TabPage0.TabIndex = 0
        Me._SSTab1_TabPage0.Text = "SubTypes"
        '
        '_Frame_11
        '
        Me._Frame_11.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_11.Controls.Add(Me.cmdSubtype)
        Me._Frame_11.Controls.Add(Me.cmdRemoveSubtype)
        Me._Frame_11.Controls.Add(Me.cmdAddSubtype)
        Me._Frame_11.Controls.Add(Me.LstViewSelectedSubtypes)
        Me._Frame_11.Controls.Add(Me.LstViewAvailableSubtypes)
        Me._Frame_11.Controls.Add(Me._Lable_23)
        Me._Frame_11.Controls.Add(Me._Lable_8)
        Me._Frame_11.Controls.Add(Me.Label11)
        Me._Frame_11.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_11.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_11, CType(11, Short))
        Me._Frame_11.Location = New System.Drawing.Point(8, 8)
        Me._Frame_11.Name = "_Frame_11"
        Me._Frame_11.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_11.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_11.Size = New System.Drawing.Size(733, 409)
        Me._Frame_11.TabIndex = 169
        Me._Frame_11.TabStop = False
        '
        'cmdSubtype
        '
        Me.cmdSubtype.BackColor = System.Drawing.SystemColors.Control
        Me.cmdSubtype.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdSubtype.Enabled = False
        Me.cmdSubtype.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdSubtype.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdSubtype.Location = New System.Drawing.Point(208, 8)
        Me.cmdSubtype.Name = "cmdSubtype"
        Me.cmdSubtype.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdSubtype.Size = New System.Drawing.Size(113, 25)
        Me.cmdSubtype.TabIndex = 172
        Me.cmdSubtype.Text = "New SubType..."
        Me.cmdSubtype.UseVisualStyleBackColor = False
        '
        'cmdRemoveSubtype
        '
        Me.cmdRemoveSubtype.BackColor = System.Drawing.SystemColors.Control
        Me.cmdRemoveSubtype.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdRemoveSubtype.Enabled = False
        Me.cmdRemoveSubtype.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdRemoveSubtype.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdRemoveSubtype.Location = New System.Drawing.Point(328, 170)
        Me.cmdRemoveSubtype.Name = "cmdRemoveSubtype"
        Me.cmdRemoveSubtype.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdRemoveSubtype.Size = New System.Drawing.Size(57, 21)
        Me.cmdRemoveSubtype.TabIndex = 171
        Me.cmdRemoveSubtype.Text = "Remove"
        Me.cmdRemoveSubtype.UseVisualStyleBackColor = False
        '
        'cmdAddSubtype
        '
        Me.cmdAddSubtype.BackColor = System.Drawing.SystemColors.Control
        Me.cmdAddSubtype.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdAddSubtype.Enabled = False
        Me.cmdAddSubtype.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdAddSubtype.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdAddSubtype.Location = New System.Drawing.Point(328, 144)
        Me.cmdAddSubtype.Name = "cmdAddSubtype"
        Me.cmdAddSubtype.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdAddSubtype.Size = New System.Drawing.Size(57, 21)
        Me.cmdAddSubtype.TabIndex = 170
        Me.cmdAddSubtype.Text = "Add  >>"
        Me.cmdAddSubtype.UseVisualStyleBackColor = False
        '
        'LstViewSelectedSubtypes
        '
        Me.LstViewSelectedSubtypes.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewSelectedSubtypes.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.LstViewSelectedSubtypes.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewSelectedSubtypes.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewSelectedSubtypes.FullRowSelect = True
        Me.LstViewSelectedSubtypes.HideSelection = False
        Me.LstViewSelectedSubtypes.LabelWrap = False
        Me.LstViewSelectedSubtypes.Location = New System.Drawing.Point(392, 40)
        Me.LstViewSelectedSubtypes.Name = "LstViewSelectedSubtypes"
        Me.LstViewSelectedSubtypes.Size = New System.Drawing.Size(335, 369)
        Me.LstViewSelectedSubtypes.TabIndex = 173
        Me.LstViewSelectedSubtypes.UseCompatibleStateImageBehavior = False
        Me.LstViewSelectedSubtypes.View = System.Windows.Forms.View.Details
        '
        'LstViewAvailableSubtypes
        '
        Me.LstViewAvailableSubtypes.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewAvailableSubtypes.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.LstViewAvailableSubtypes.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewAvailableSubtypes.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewAvailableSubtypes.FullRowSelect = True
        Me.LstViewAvailableSubtypes.HideSelection = False
        Me.LstViewAvailableSubtypes.LabelWrap = False
        Me.LstViewAvailableSubtypes.Location = New System.Drawing.Point(2, 38)
        Me.LstViewAvailableSubtypes.Name = "LstViewAvailableSubtypes"
        Me.LstViewAvailableSubtypes.Size = New System.Drawing.Size(319, 369)
        Me.LstViewAvailableSubtypes.TabIndex = 174
        Me.LstViewAvailableSubtypes.UseCompatibleStateImageBehavior = False
        Me.LstViewAvailableSubtypes.View = System.Windows.Forms.View.Details
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
        Me._Lable_23.TabIndex = 177
        Me._Lable_23.Text = "Available SubTypes"
        '
        '_Lable_8
        '
        Me._Lable_8.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_8.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_8.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_8.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_8, CType(8, Short))
        Me._Lable_8.Location = New System.Drawing.Point(392, 20)
        Me._Lable_8.Name = "_Lable_8"
        Me._Lable_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_8.Size = New System.Drawing.Size(105, 17)
        Me._Lable_8.TabIndex = 176
        Me._Lable_8.Text = "Selected SubTypes"
        '
        'Label11
        '
        Me.Label11.BackColor = System.Drawing.SystemColors.Control
        Me.Label11.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label11.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label11.ForeColor = System.Drawing.Color.Red
        Me.Label11.Location = New System.Drawing.Point(512, 20)
        Me.Label11.Name = "Label11"
        Me.Label11.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label11.Size = New System.Drawing.Size(202, 17)
        Me.Label11.TabIndex = 175
        Me.Label11.Text = "Double-click to change Subtype Order"
        '
        '_SSTab1_TabPage1
        '
        Me._SSTab1_TabPage1.Controls.Add(Me._Frame_13)
        Me._SSTab1_TabPage1.Location = New System.Drawing.Point(4, 22)
        Me._SSTab1_TabPage1.Name = "_SSTab1_TabPage1"
        Me._SSTab1_TabPage1.Size = New System.Drawing.Size(742, 419)
        Me._SSTab1_TabPage1.TabIndex = 1
        Me._SSTab1_TabPage1.Text = "Processors"
        '
        '_Frame_13
        '
        Me._Frame_13.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_13.Controls.Add(Me.cmdAddProcessor)
        Me._Frame_13.Controls.Add(Me.cmdRemoveProcessor)
        Me._Frame_13.Controls.Add(Me.cboProcessorOrganizationType)
        Me._Frame_13.Controls.Add(Me.cmdProcessorFind)
        Me._Frame_13.Controls.Add(Me.cboProcessorState)
        Me._Frame_13.Controls.Add(Me.LstViewSelectedProcessors)
        Me._Frame_13.Controls.Add(Me.LstViewAvailableProcessors)
        Me._Frame_13.Controls.Add(Me._Lable_22)
        Me._Frame_13.Controls.Add(Me._Lable_28)
        Me._Frame_13.Controls.Add(Me._Lable_29)
        Me._Frame_13.Controls.Add(Me._Lable_30)
        Me._Frame_13.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_13.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_13, CType(13, Short))
        Me._Frame_13.Location = New System.Drawing.Point(0, 6)
        Me._Frame_13.Name = "_Frame_13"
        Me._Frame_13.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_13.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_13.Size = New System.Drawing.Size(737, 417)
        Me._Frame_13.TabIndex = 157
        Me._Frame_13.TabStop = False
        '
        'cmdAddProcessor
        '
        Me.cmdAddProcessor.BackColor = System.Drawing.SystemColors.Control
        Me.cmdAddProcessor.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdAddProcessor.Enabled = False
        Me.cmdAddProcessor.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdAddProcessor.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdAddProcessor.Location = New System.Drawing.Point(350, 168)
        Me.cmdAddProcessor.Name = "cmdAddProcessor"
        Me.cmdAddProcessor.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdAddProcessor.Size = New System.Drawing.Size(53, 21)
        Me.cmdAddProcessor.TabIndex = 162
        Me.cmdAddProcessor.Text = "Add  >>"
        Me.cmdAddProcessor.UseVisualStyleBackColor = False
        '
        'cmdRemoveProcessor
        '
        Me.cmdRemoveProcessor.BackColor = System.Drawing.SystemColors.Control
        Me.cmdRemoveProcessor.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdRemoveProcessor.Enabled = False
        Me.cmdRemoveProcessor.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdRemoveProcessor.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdRemoveProcessor.Location = New System.Drawing.Point(350, 194)
        Me.cmdRemoveProcessor.Name = "cmdRemoveProcessor"
        Me.cmdRemoveProcessor.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdRemoveProcessor.Size = New System.Drawing.Size(53, 21)
        Me.cmdRemoveProcessor.TabIndex = 161
        Me.cmdRemoveProcessor.Text = "Remove"
        Me.cmdRemoveProcessor.UseVisualStyleBackColor = False
        '
        'cboProcessorOrganizationType
        '
        Me.cboProcessorOrganizationType.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.cboProcessorOrganizationType.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.cboProcessorOrganizationType.BackColor = System.Drawing.SystemColors.Window
        Me.cboProcessorOrganizationType.Cursor = System.Windows.Forms.Cursors.Default
        Me.cboProcessorOrganizationType.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cboProcessorOrganizationType.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cboProcessorOrganizationType.Location = New System.Drawing.Point(128, 14)
        Me.cboProcessorOrganizationType.Name = "cboProcessorOrganizationType"
        Me.cboProcessorOrganizationType.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cboProcessorOrganizationType.Size = New System.Drawing.Size(141, 22)
        Me.cboProcessorOrganizationType.Sorted = True
        Me.cboProcessorOrganizationType.TabIndex = 160
        '
        'cmdProcessorFind
        '
        Me.cmdProcessorFind.BackColor = System.Drawing.SystemColors.Control
        Me.cmdProcessorFind.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdProcessorFind.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdProcessorFind.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdProcessorFind.Location = New System.Drawing.Point(274, 14)
        Me.cmdProcessorFind.Name = "cmdProcessorFind"
        Me.cmdProcessorFind.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdProcessorFind.Size = New System.Drawing.Size(69, 21)
        Me.cmdProcessorFind.TabIndex = 159
        Me.cmdProcessorFind.Text = "&Find"
        Me.cmdProcessorFind.UseVisualStyleBackColor = False
        '
        'cboProcessorState
        '
        Me.cboProcessorState.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.cboProcessorState.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.cboProcessorState.BackColor = System.Drawing.SystemColors.Window
        Me.cboProcessorState.Cursor = System.Windows.Forms.Cursors.Default
        Me.cboProcessorState.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cboProcessorState.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cboProcessorState.Location = New System.Drawing.Point(40, 14)
        Me.cboProcessorState.Name = "cboProcessorState"
        Me.cboProcessorState.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cboProcessorState.Size = New System.Drawing.Size(51, 22)
        Me.cboProcessorState.Sorted = True
        Me.cboProcessorState.TabIndex = 158
        '
        'LstViewSelectedProcessors
        '
        Me.LstViewSelectedProcessors.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewSelectedProcessors.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.LstViewSelectedProcessors.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewSelectedProcessors.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewSelectedProcessors.FullRowSelect = True
        Me.LstViewSelectedProcessors.HideSelection = False
        Me.LstViewSelectedProcessors.LabelWrap = False
        Me.LstViewSelectedProcessors.Location = New System.Drawing.Point(408, 62)
        Me.LstViewSelectedProcessors.Name = "LstViewSelectedProcessors"
        Me.LstViewSelectedProcessors.Size = New System.Drawing.Size(327, 345)
        Me.LstViewSelectedProcessors.TabIndex = 163
        Me.LstViewSelectedProcessors.UseCompatibleStateImageBehavior = False
        Me.LstViewSelectedProcessors.View = System.Windows.Forms.View.Details
        '
        'LstViewAvailableProcessors
        '
        Me.LstViewAvailableProcessors.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewAvailableProcessors.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.LstViewAvailableProcessors.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewAvailableProcessors.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewAvailableProcessors.FullRowSelect = True
        Me.LstViewAvailableProcessors.HideSelection = False
        Me.LstViewAvailableProcessors.LabelWrap = False
        Me.LstViewAvailableProcessors.Location = New System.Drawing.Point(10, 62)
        Me.LstViewAvailableProcessors.Name = "LstViewAvailableProcessors"
        Me.LstViewAvailableProcessors.Size = New System.Drawing.Size(335, 343)
        Me.LstViewAvailableProcessors.TabIndex = 164
        Me.LstViewAvailableProcessors.UseCompatibleStateImageBehavior = False
        Me.LstViewAvailableProcessors.View = System.Windows.Forms.View.Details
        '
        '_Lable_22
        '
        Me._Lable_22.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_22.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_22.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_22.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_22, CType(22, Short))
        Me._Lable_22.Location = New System.Drawing.Point(410, 46)
        Me._Lable_22.Name = "_Lable_22"
        Me._Lable_22.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_22.Size = New System.Drawing.Size(137, 17)
        Me._Lable_22.TabIndex = 168
        Me._Lable_22.Text = "Selected Processors"
        '
        '_Lable_28
        '
        Me._Lable_28.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_28.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_28.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_28.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_28, CType(28, Short))
        Me._Lable_28.Location = New System.Drawing.Point(98, 18)
        Me._Lable_28.Name = "_Lable_28"
        Me._Lable_28.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_28.Size = New System.Drawing.Size(55, 17)
        Me._Lable_28.TabIndex = 167
        Me._Lable_28.Text = "Type"
        '
        '_Lable_29
        '
        Me._Lable_29.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_29.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_29.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_29.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_29, CType(29, Short))
        Me._Lable_29.Location = New System.Drawing.Point(12, 46)
        Me._Lable_29.Name = "_Lable_29"
        Me._Lable_29.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_29.Size = New System.Drawing.Size(201, 17)
        Me._Lable_29.TabIndex = 166
        Me._Lable_29.Text = "Available Processors"
        '
        '_Lable_30
        '
        Me._Lable_30.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_30.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_30.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_30.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_30, CType(30, Short))
        Me._Lable_30.Location = New System.Drawing.Point(12, 18)
        Me._Lable_30.Name = "_Lable_30"
        Me._Lable_30.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_30.Size = New System.Drawing.Size(55, 19)
        Me._Lable_30.TabIndex = 165
        Me._Lable_30.Text = "State"
        '
        '_SSTab1_TabPage2
        '
        Me._SSTab1_TabPage2.Controls.Add(Me._Frame_12)
        Me._SSTab1_TabPage2.Location = New System.Drawing.Point(4, 22)
        Me._SSTab1_TabPage2.Name = "_SSTab1_TabPage2"
        Me._SSTab1_TabPage2.Size = New System.Drawing.Size(742, 419)
        Me._SSTab1_TabPage2.TabIndex = 2
        Me._SSTab1_TabPage2.Text = "Subtype/Processors"
        '
        '_Frame_12
        '
        Me._Frame_12.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_12.Controls.Add(Me.cmdNewTemplate)
        Me._Frame_12.Controls.Add(Me.LstViewCriteriaTemplates)
        Me._Frame_12.Controls.Add(Me.LstViewSubtypeProcessors)
        Me._Frame_12.Controls.Add(Me.Label4)
        Me._Frame_12.Controls.Add(Me.Label3)
        Me._Frame_12.Controls.Add(Me._Lable_27)
        Me._Frame_12.Controls.Add(Me._Lable_26)
        Me._Frame_12.Controls.Add(Me.Label2)
        Me._Frame_12.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_12.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_12, CType(12, Short))
        Me._Frame_12.Location = New System.Drawing.Point(8, 9)
        Me._Frame_12.Name = "_Frame_12"
        Me._Frame_12.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_12.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_12.Size = New System.Drawing.Size(733, 407)
        Me._Frame_12.TabIndex = 151
        Me._Frame_12.TabStop = False
        '
        'cmdNewTemplate
        '
        Me.cmdNewTemplate.BackColor = System.Drawing.SystemColors.Control
        Me.cmdNewTemplate.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdNewTemplate.Enabled = False
        Me.cmdNewTemplate.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdNewTemplate.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdNewTemplate.Location = New System.Drawing.Point(356, 8)
        Me.cmdNewTemplate.Name = "cmdNewTemplate"
        Me.cmdNewTemplate.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdNewTemplate.Size = New System.Drawing.Size(101, 25)
        Me.cmdNewTemplate.TabIndex = 152
        Me.cmdNewTemplate.Text = "New Template..."
        Me.cmdNewTemplate.UseVisualStyleBackColor = False
        '
        'LstViewCriteriaTemplates
        '
        Me.LstViewCriteriaTemplates.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewCriteriaTemplates.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.LstViewCriteriaTemplates.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewCriteriaTemplates.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewCriteriaTemplates.FullRowSelect = True
        Me.LstViewCriteriaTemplates.HideSelection = False
        Me.LstViewCriteriaTemplates.LabelWrap = False
        Me.LstViewCriteriaTemplates.Location = New System.Drawing.Point(0, 36)
        Me.LstViewCriteriaTemplates.Name = "LstViewCriteriaTemplates"
        Me.LstViewCriteriaTemplates.Size = New System.Drawing.Size(459, 308)
        Me.LstViewCriteriaTemplates.TabIndex = 153
        Me.LstViewCriteriaTemplates.UseCompatibleStateImageBehavior = False
        Me.LstViewCriteriaTemplates.View = System.Windows.Forms.View.Details
        '
        'LstViewSubtypeProcessors
        '
        Me.LstViewSubtypeProcessors.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewSubtypeProcessors.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.LstViewSubtypeProcessors.CheckBoxes = True
        Me.LstViewSubtypeProcessors.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewSubtypeProcessors.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewSubtypeProcessors.FullRowSelect = True
        Me.LstViewSubtypeProcessors.Location = New System.Drawing.Point(464, 36)
        Me.LstViewSubtypeProcessors.Name = "LstViewSubtypeProcessors"
        Me.LstViewSubtypeProcessors.Size = New System.Drawing.Size(267, 365)
        Me.LstViewSubtypeProcessors.TabIndex = 180
        Me.LstViewSubtypeProcessors.UseCompatibleStateImageBehavior = False
        Me.LstViewSubtypeProcessors.View = System.Windows.Forms.View.Details
        '
        'Label4
        '
        Me.Label4.BackColor = System.Drawing.SystemColors.Control
        Me.Label4.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label4.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label4.ForeColor = System.Drawing.Color.Red
        Me.Label4.Location = New System.Drawing.Point(152, 16)
        Me.Label4.Name = "Label4"
        Me.Label4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label4.Size = New System.Drawing.Size(198, 17)
        Me.Label4.TabIndex = 182
        Me.Label4.Text = "Double-click a template below to modify"
        '
        'Label3
        '
        Me.Label3.BackColor = System.Drawing.SystemColors.Control
        Me.Label3.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label3.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label3.ForeColor = System.Drawing.Color.Red
        Me.Label3.Location = New System.Drawing.Point(528, 18)
        Me.Label3.Name = "Label3"
        Me.Label3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label3.Size = New System.Drawing.Size(200, 17)
        Me.Label3.TabIndex = 181
        Me.Label3.Text = "Right-click to change Processor Order"
        '
        '_Lable_27
        '
        Me._Lable_27.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_27.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_27.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_27.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_27, CType(27, Short))
        Me._Lable_27.Location = New System.Drawing.Point(3, 16)
        Me._Lable_27.Name = "_Lable_27"
        Me._Lable_27.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_27.Size = New System.Drawing.Size(146, 17)
        Me._Lable_27.TabIndex = 156
        Me._Lable_27.Text = "Processor Criteria Templates"
        '
        '_Lable_26
        '
        Me._Lable_26.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_26.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_26.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_26.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_26, CType(26, Short))
        Me._Lable_26.Location = New System.Drawing.Point(0, 346)
        Me._Lable_26.Name = "_Lable_26"
        Me._Lable_26.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_26.Size = New System.Drawing.Size(461, 57)
        Me._Lable_26.TabIndex = 155
        Me._Lable_26.Text = resources.GetString("_Lable_26.Text")
        '
        'Label2
        '
        Me.Label2.BackColor = System.Drawing.SystemColors.Control
        Me.Label2.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label2.Location = New System.Drawing.Point(468, 18)
        Me.Label2.Name = "Label2"
        Me.Label2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label2.Size = New System.Drawing.Size(57, 13)
        Me.Label2.TabIndex = 154
        Me.Label2.Text = "SubTypes"
        '
        '_SSTab1_TabPage3
        '
        Me._SSTab1_TabPage3.Controls.Add(Me.Label6)
        Me._SSTab1_TabPage3.Controls.Add(Me.SSTab2)
        Me._SSTab1_TabPage3.Controls.Add(Me._cboSubtypeProcessor_0)
        Me._SSTab1_TabPage3.Location = New System.Drawing.Point(4, 22)
        Me._SSTab1_TabPage3.Name = "_SSTab1_TabPage3"
        Me._SSTab1_TabPage3.Size = New System.Drawing.Size(742, 419)
        Me._SSTab1_TabPage3.TabIndex = 3
        Me._SSTab1_TabPage3.Text = "Ruleout Criteria"
        '
        'Label6
        '
        Me.Label6.BackColor = System.Drawing.SystemColors.Control
        Me.Label6.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label6.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label6.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label6.Location = New System.Drawing.Point(8, 12)
        Me.Label6.Name = "Label6"
        Me.Label6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label6.Size = New System.Drawing.Size(103, 17)
        Me.Label6.TabIndex = 179
        Me.Label6.Text = "SubType/Processor"
        '
        'SSTab2
        '
        Me.SSTab2.Controls.Add(Me._SSTab2_TabPage0)
        Me.SSTab2.Controls.Add(Me._SSTab2_TabPage1)
        Me.SSTab2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.SSTab2.ItemSize = New System.Drawing.Size(42, 18)
        Me.SSTab2.Location = New System.Drawing.Point(8, 42)
        Me.SSTab2.Name = "SSTab2"
        Me.SSTab2.SelectedIndex = 0
        Me.SSTab2.Size = New System.Drawing.Size(729, 377)
        Me.SSTab2.TabIndex = 118
        '
        '_SSTab2_TabPage0
        '
        Me._SSTab2_TabPage0.Controls.Add(Me.cmdSaveSubCriteria)
        Me._SSTab2_TabPage0.Controls.Add(Me._FrameSub_2)
        Me._SSTab2_TabPage0.Controls.Add(Me._FrameSub_3)
        Me._SSTab2_TabPage0.Controls.Add(Me._FrameSub_6)
        Me._SSTab2_TabPage0.Location = New System.Drawing.Point(4, 22)
        Me._SSTab2_TabPage0.Name = "_SSTab2_TabPage0"
        Me._SSTab2_TabPage0.Size = New System.Drawing.Size(721, 351)
        Me._SSTab2_TabPage0.TabIndex = 0
        Me._SSTab2_TabPage0.Text = "General"
        '
        'cmdSaveSubCriteria
        '
        Me.cmdSaveSubCriteria.BackColor = System.Drawing.SystemColors.Control
        Me.cmdSaveSubCriteria.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdSaveSubCriteria.Enabled = False
        Me.cmdSaveSubCriteria.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdSaveSubCriteria.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdSaveSubCriteria.Location = New System.Drawing.Point(640, 40)
        Me.cmdSaveSubCriteria.Name = "cmdSaveSubCriteria"
        Me.cmdSaveSubCriteria.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdSaveSubCriteria.Size = New System.Drawing.Size(73, 25)
        Me.cmdSaveSubCriteria.TabIndex = 119
        Me.cmdSaveSubCriteria.Text = "Save"
        Me.cmdSaveSubCriteria.UseVisualStyleBackColor = False
        '
        '_FrameSub_2
        '
        Me._FrameSub_2.BackColor = System.Drawing.SystemColors.Control
        Me._FrameSub_2.Controls.Add(Me.TxtGeneralRuleoutSub)
        Me._FrameSub_2.Controls.Add(Me._LableSub_7)
        Me._FrameSub_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._FrameSub_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.FrameSub.SetIndex(Me._FrameSub_2, CType(2, Short))
        Me._FrameSub_2.Location = New System.Drawing.Point(320, 32)
        Me._FrameSub_2.Name = "_FrameSub_2"
        Me._FrameSub_2.Padding = New System.Windows.Forms.Padding(0)
        Me._FrameSub_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._FrameSub_2.Size = New System.Drawing.Size(309, 223)
        Me._FrameSub_2.TabIndex = 125
        Me._FrameSub_2.TabStop = False
        Me._FrameSub_2.Text = "General Conditional Ruleout"
        '
        'TxtGeneralRuleoutSub
        '
        Me.TxtGeneralRuleoutSub.AcceptsReturn = True
        Me.TxtGeneralRuleoutSub.BackColor = System.Drawing.SystemColors.Window
        Me.TxtGeneralRuleoutSub.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtGeneralRuleoutSub.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtGeneralRuleoutSub.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtGeneralRuleoutSub.Location = New System.Drawing.Point(8, 50)
        Me.TxtGeneralRuleoutSub.MaxLength = 0
        Me.TxtGeneralRuleoutSub.Multiline = True
        Me.TxtGeneralRuleoutSub.Name = "TxtGeneralRuleoutSub"
        Me.TxtGeneralRuleoutSub.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtGeneralRuleoutSub.ScrollBars = System.Windows.Forms.ScrollBars.Vertical
        Me.TxtGeneralRuleoutSub.Size = New System.Drawing.Size(291, 163)
        Me.TxtGeneralRuleoutSub.TabIndex = 126
        '
        '_LableSub_7
        '
        Me._LableSub_7.BackColor = System.Drawing.SystemColors.Control
        Me._LableSub_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._LableSub_7.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LableSub_7.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LableSub.SetIndex(Me._LableSub_7, CType(7, Short))
        Me._LableSub_7.Location = New System.Drawing.Point(8, 18)
        Me._LableSub_7.Name = "_LableSub_7"
        Me._LableSub_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LableSub_7.Size = New System.Drawing.Size(289, 31)
        Me._LableSub_7.TabIndex = 127
        Me._LableSub_7.Text = "This message will only appear if the option is eligible or conditionally eligible" & _
            "."
        '
        '_FrameSub_3
        '
        Me._FrameSub_3.BackColor = System.Drawing.SystemColors.Control
        Me._FrameSub_3.Controls.Add(Me.TxtFemaleLowerWeightSub)
        Me._FrameSub_3.Controls.Add(Me.TxtFemaleUpperWeightSub)
        Me._FrameSub_3.Controls.Add(Me.TxtMaleUpperSub)
        Me._FrameSub_3.Controls.Add(Me.TxtFemaleUpperSub)
        Me._FrameSub_3.Controls.Add(Me.TxtMaleLowerSub)
        Me._FrameSub_3.Controls.Add(Me.TxtFemaleLowerSub)
        Me._FrameSub_3.Controls.Add(Me.TxtUpperWeightSub)
        Me._FrameSub_3.Controls.Add(Me.TxtLowerWeightSub)
        Me._FrameSub_3.Controls.Add(Me.ChkReferNonPotentialSub)
        Me._FrameSub_3.Controls.Add(Me._LableSub_20)
        Me._FrameSub_3.Controls.Add(Me._LableSub_21)
        Me._FrameSub_3.Controls.Add(Me._LableSub_19)
        Me._FrameSub_3.Controls.Add(Me._LableSub_15)
        Me._FrameSub_3.Controls.Add(Me._LableSub_12)
        Me._FrameSub_3.Controls.Add(Me._Lable_37)
        Me._FrameSub_3.Controls.Add(Me._LableSub_13)
        Me._FrameSub_3.Controls.Add(Me._LableSub_14)
        Me._FrameSub_3.Controls.Add(Me._LableSub_11)
        Me._FrameSub_3.Controls.Add(Me._LableSub_10)
        Me._FrameSub_3.Controls.Add(Me._LableSub_18)
        Me._FrameSub_3.Controls.Add(Me._LableSub_17)
        Me._FrameSub_3.Controls.Add(Me._LableSub_6)
        Me._FrameSub_3.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._FrameSub_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me.FrameSub.SetIndex(Me._FrameSub_3, CType(3, Short))
        Me._FrameSub_3.Location = New System.Drawing.Point(8, 72)
        Me._FrameSub_3.Name = "_FrameSub_3"
        Me._FrameSub_3.Padding = New System.Windows.Forms.Padding(0)
        Me._FrameSub_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._FrameSub_3.Size = New System.Drawing.Size(293, 183)
        Me._FrameSub_3.TabIndex = 128
        Me._FrameSub_3.TabStop = False
        Me._FrameSub_3.Text = "Ruleouts"
        '
        'TxtFemaleLowerWeightSub
        '
        Me.TxtFemaleLowerWeightSub.AcceptsReturn = True
        Me.TxtFemaleLowerWeightSub.BackColor = System.Drawing.SystemColors.Window
        Me.TxtFemaleLowerWeightSub.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtFemaleLowerWeightSub.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtFemaleLowerWeightSub.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtFemaleLowerWeightSub.Location = New System.Drawing.Point(112, 120)
        Me.TxtFemaleLowerWeightSub.MaxLength = 0
        Me.TxtFemaleLowerWeightSub.Name = "TxtFemaleLowerWeightSub"
        Me.TxtFemaleLowerWeightSub.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtFemaleLowerWeightSub.Size = New System.Drawing.Size(31, 20)
        Me.TxtFemaleLowerWeightSub.TabIndex = 185
        '
        'TxtFemaleUpperWeightSub
        '
        Me.TxtFemaleUpperWeightSub.AcceptsReturn = True
        Me.TxtFemaleUpperWeightSub.BackColor = System.Drawing.SystemColors.Window
        Me.TxtFemaleUpperWeightSub.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtFemaleUpperWeightSub.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtFemaleUpperWeightSub.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtFemaleUpperWeightSub.Location = New System.Drawing.Point(222, 120)
        Me.TxtFemaleUpperWeightSub.MaxLength = 0
        Me.TxtFemaleUpperWeightSub.Name = "TxtFemaleUpperWeightSub"
        Me.TxtFemaleUpperWeightSub.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtFemaleUpperWeightSub.Size = New System.Drawing.Size(31, 20)
        Me.TxtFemaleUpperWeightSub.TabIndex = 184
        '
        'TxtMaleUpperSub
        '
        Me.TxtMaleUpperSub.AcceptsReturn = True
        Me.TxtMaleUpperSub.BackColor = System.Drawing.SystemColors.Window
        Me.TxtMaleUpperSub.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtMaleUpperSub.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtMaleUpperSub.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtMaleUpperSub.Location = New System.Drawing.Point(222, 22)
        Me.TxtMaleUpperSub.MaxLength = 0
        Me.TxtMaleUpperSub.Name = "TxtMaleUpperSub"
        Me.TxtMaleUpperSub.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtMaleUpperSub.Size = New System.Drawing.Size(31, 20)
        Me.TxtMaleUpperSub.TabIndex = 135
        '
        'TxtFemaleUpperSub
        '
        Me.TxtFemaleUpperSub.AcceptsReturn = True
        Me.TxtFemaleUpperSub.BackColor = System.Drawing.SystemColors.Window
        Me.TxtFemaleUpperSub.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtFemaleUpperSub.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtFemaleUpperSub.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtFemaleUpperSub.Location = New System.Drawing.Point(222, 46)
        Me.TxtFemaleUpperSub.MaxLength = 0
        Me.TxtFemaleUpperSub.Name = "TxtFemaleUpperSub"
        Me.TxtFemaleUpperSub.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtFemaleUpperSub.Size = New System.Drawing.Size(31, 20)
        Me.TxtFemaleUpperSub.TabIndex = 134
        '
        'TxtMaleLowerSub
        '
        Me.TxtMaleLowerSub.AcceptsReturn = True
        Me.TxtMaleLowerSub.BackColor = System.Drawing.SystemColors.Window
        Me.TxtMaleLowerSub.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtMaleLowerSub.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtMaleLowerSub.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtMaleLowerSub.Location = New System.Drawing.Point(112, 22)
        Me.TxtMaleLowerSub.MaxLength = 0
        Me.TxtMaleLowerSub.Name = "TxtMaleLowerSub"
        Me.TxtMaleLowerSub.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtMaleLowerSub.Size = New System.Drawing.Size(31, 20)
        Me.TxtMaleLowerSub.TabIndex = 133
        '
        'TxtFemaleLowerSub
        '
        Me.TxtFemaleLowerSub.AcceptsReturn = True
        Me.TxtFemaleLowerSub.BackColor = System.Drawing.SystemColors.Window
        Me.TxtFemaleLowerSub.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtFemaleLowerSub.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtFemaleLowerSub.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtFemaleLowerSub.Location = New System.Drawing.Point(112, 46)
        Me.TxtFemaleLowerSub.MaxLength = 0
        Me.TxtFemaleLowerSub.Name = "TxtFemaleLowerSub"
        Me.TxtFemaleLowerSub.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtFemaleLowerSub.Size = New System.Drawing.Size(31, 20)
        Me.TxtFemaleLowerSub.TabIndex = 132
        '
        'TxtUpperWeightSub
        '
        Me.TxtUpperWeightSub.AcceptsReturn = True
        Me.TxtUpperWeightSub.BackColor = System.Drawing.SystemColors.Window
        Me.TxtUpperWeightSub.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtUpperWeightSub.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtUpperWeightSub.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtUpperWeightSub.Location = New System.Drawing.Point(222, 96)
        Me.TxtUpperWeightSub.MaxLength = 0
        Me.TxtUpperWeightSub.Name = "TxtUpperWeightSub"
        Me.TxtUpperWeightSub.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtUpperWeightSub.Size = New System.Drawing.Size(31, 20)
        Me.TxtUpperWeightSub.TabIndex = 131
        '
        'TxtLowerWeightSub
        '
        Me.TxtLowerWeightSub.AcceptsReturn = True
        Me.TxtLowerWeightSub.BackColor = System.Drawing.SystemColors.Window
        Me.TxtLowerWeightSub.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtLowerWeightSub.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtLowerWeightSub.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtLowerWeightSub.Location = New System.Drawing.Point(112, 96)
        Me.TxtLowerWeightSub.MaxLength = 0
        Me.TxtLowerWeightSub.Name = "TxtLowerWeightSub"
        Me.TxtLowerWeightSub.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtLowerWeightSub.Size = New System.Drawing.Size(31, 20)
        Me.TxtLowerWeightSub.TabIndex = 130
        '
        'ChkReferNonPotentialSub
        '
        Me.ChkReferNonPotentialSub.BackColor = System.Drawing.SystemColors.Control
        Me.ChkReferNonPotentialSub.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkReferNonPotentialSub.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkReferNonPotentialSub.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkReferNonPotentialSub.Location = New System.Drawing.Point(12, 152)
        Me.ChkReferNonPotentialSub.Name = "ChkReferNonPotentialSub"
        Me.ChkReferNonPotentialSub.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkReferNonPotentialSub.Size = New System.Drawing.Size(277, 27)
        Me.ChkReferNonPotentialSub.TabIndex = 129
        Me.ChkReferNonPotentialSub.Text = "If checked, refer *all* current vent patients.  If unchecked, only refer vent pat" & _
            "ients with neuro-insult."
        Me.ChkReferNonPotentialSub.UseVisualStyleBackColor = False
        '
        '_LableSub_20
        '
        Me._LableSub_20.BackColor = System.Drawing.SystemColors.Control
        Me._LableSub_20.Cursor = System.Windows.Forms.Cursors.Default
        Me._LableSub_20.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LableSub_20.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LableSub.SetIndex(Me._LableSub_20, CType(20, Short))
        Me._LableSub_20.Location = New System.Drawing.Point(76, 124)
        Me._LableSub_20.Name = "_LableSub_20"
        Me._LableSub_20.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LableSub_20.Size = New System.Drawing.Size(93, 15)
        Me._LableSub_20.TabIndex = 188
        Me._LableSub_20.Text = "Lower              kg"
        '
        '_LableSub_21
        '
        Me._LableSub_21.BackColor = System.Drawing.SystemColors.Control
        Me._LableSub_21.Cursor = System.Windows.Forms.Cursors.Default
        Me._LableSub_21.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LableSub_21.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LableSub.SetIndex(Me._LableSub_21, CType(21, Short))
        Me._LableSub_21.Location = New System.Drawing.Point(186, 124)
        Me._LableSub_21.Name = "_LableSub_21"
        Me._LableSub_21.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LableSub_21.Size = New System.Drawing.Size(103, 15)
        Me._LableSub_21.TabIndex = 187
        Me._LableSub_21.Text = "Upper              kg"
        '
        '_LableSub_19
        '
        Me._LableSub_19.BackColor = System.Drawing.SystemColors.Control
        Me._LableSub_19.Cursor = System.Windows.Forms.Cursors.Default
        Me._LableSub_19.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LableSub_19.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LableSub.SetIndex(Me._LableSub_19, CType(19, Short))
        Me._LableSub_19.Location = New System.Drawing.Point(8, 124)
        Me._LableSub_19.Name = "_LableSub_19"
        Me._LableSub_19.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LableSub_19.Size = New System.Drawing.Size(63, 15)
        Me._LableSub_19.TabIndex = 186
        Me._LableSub_19.Text = "Wt. Female:"
        '
        '_LableSub_15
        '
        Me._LableSub_15.BackColor = System.Drawing.SystemColors.Control
        Me._LableSub_15.Cursor = System.Windows.Forms.Cursors.Default
        Me._LableSub_15.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LableSub_15.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LableSub.SetIndex(Me._LableSub_15, CType(15, Short))
        Me._LableSub_15.Location = New System.Drawing.Point(76, 48)
        Me._LableSub_15.Name = "_LableSub_15"
        Me._LableSub_15.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LableSub_15.Size = New System.Drawing.Size(109, 15)
        Me._LableSub_15.TabIndex = 145
        Me._LableSub_15.Text = "Lower              mos."
        '
        '_LableSub_12
        '
        Me._LableSub_12.BackColor = System.Drawing.SystemColors.Control
        Me._LableSub_12.Cursor = System.Windows.Forms.Cursors.Default
        Me._LableSub_12.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LableSub_12.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LableSub.SetIndex(Me._LableSub_12, CType(12, Short))
        Me._LableSub_12.Location = New System.Drawing.Point(12, 26)
        Me._LableSub_12.Name = "_LableSub_12"
        Me._LableSub_12.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LableSub_12.Size = New System.Drawing.Size(63, 15)
        Me._LableSub_12.TabIndex = 144
        Me._LableSub_12.Text = "Age Male:"
        '
        '_Lable_37
        '
        Me._Lable_37.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_37.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_37.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_37.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_37, CType(37, Short))
        Me._Lable_37.Location = New System.Drawing.Point(186, 70)
        Me._Lable_37.Name = "_Lable_37"
        Me._Lable_37.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_37.Size = New System.Drawing.Size(85, 15)
        Me._Lable_37.TabIndex = 143
        Me._Lable_37.Text = "* Ages inclusive"
        '
        '_LableSub_13
        '
        Me._LableSub_13.BackColor = System.Drawing.SystemColors.Control
        Me._LableSub_13.Cursor = System.Windows.Forms.Cursors.Default
        Me._LableSub_13.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LableSub_13.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LableSub.SetIndex(Me._LableSub_13, CType(13, Short))
        Me._LableSub_13.Location = New System.Drawing.Point(186, 50)
        Me._LableSub_13.Name = "_LableSub_13"
        Me._LableSub_13.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LableSub_13.Size = New System.Drawing.Size(97, 15)
        Me._LableSub_13.TabIndex = 142
        Me._LableSub_13.Text = "Upper              yrs."
        '
        '_LableSub_14
        '
        Me._LableSub_14.BackColor = System.Drawing.SystemColors.Control
        Me._LableSub_14.Cursor = System.Windows.Forms.Cursors.Default
        Me._LableSub_14.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LableSub_14.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LableSub.SetIndex(Me._LableSub_14, CType(14, Short))
        Me._LableSub_14.Location = New System.Drawing.Point(12, 50)
        Me._LableSub_14.Name = "_LableSub_14"
        Me._LableSub_14.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LableSub_14.Size = New System.Drawing.Size(67, 15)
        Me._LableSub_14.TabIndex = 141
        Me._LableSub_14.Text = "Age Female:"
        '
        '_LableSub_11
        '
        Me._LableSub_11.BackColor = System.Drawing.SystemColors.Control
        Me._LableSub_11.Cursor = System.Windows.Forms.Cursors.Default
        Me._LableSub_11.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LableSub_11.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LableSub.SetIndex(Me._LableSub_11, CType(11, Short))
        Me._LableSub_11.Location = New System.Drawing.Point(186, 26)
        Me._LableSub_11.Name = "_LableSub_11"
        Me._LableSub_11.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LableSub_11.Size = New System.Drawing.Size(103, 15)
        Me._LableSub_11.TabIndex = 140
        Me._LableSub_11.Text = "Upper              yrs."
        '
        '_LableSub_10
        '
        Me._LableSub_10.BackColor = System.Drawing.SystemColors.Control
        Me._LableSub_10.Cursor = System.Windows.Forms.Cursors.Default
        Me._LableSub_10.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LableSub_10.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LableSub.SetIndex(Me._LableSub_10, CType(10, Short))
        Me._LableSub_10.Location = New System.Drawing.Point(76, 26)
        Me._LableSub_10.Name = "_LableSub_10"
        Me._LableSub_10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LableSub_10.Size = New System.Drawing.Size(109, 15)
        Me._LableSub_10.TabIndex = 139
        Me._LableSub_10.Text = "Lower              mos."
        '
        '_LableSub_18
        '
        Me._LableSub_18.BackColor = System.Drawing.SystemColors.Control
        Me._LableSub_18.Cursor = System.Windows.Forms.Cursors.Default
        Me._LableSub_18.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LableSub_18.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LableSub.SetIndex(Me._LableSub_18, CType(18, Short))
        Me._LableSub_18.Location = New System.Drawing.Point(8, 100)
        Me._LableSub_18.Name = "_LableSub_18"
        Me._LableSub_18.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LableSub_18.Size = New System.Drawing.Size(55, 15)
        Me._LableSub_18.TabIndex = 138
        Me._LableSub_18.Text = "Wt. Male:"
        '
        '_LableSub_17
        '
        Me._LableSub_17.BackColor = System.Drawing.SystemColors.Control
        Me._LableSub_17.Cursor = System.Windows.Forms.Cursors.Default
        Me._LableSub_17.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LableSub_17.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LableSub.SetIndex(Me._LableSub_17, CType(17, Short))
        Me._LableSub_17.Location = New System.Drawing.Point(186, 100)
        Me._LableSub_17.Name = "_LableSub_17"
        Me._LableSub_17.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LableSub_17.Size = New System.Drawing.Size(103, 15)
        Me._LableSub_17.TabIndex = 137
        Me._LableSub_17.Text = "Upper              kg"
        '
        '_LableSub_6
        '
        Me._LableSub_6.BackColor = System.Drawing.SystemColors.Control
        Me._LableSub_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._LableSub_6.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LableSub_6.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LableSub.SetIndex(Me._LableSub_6, CType(6, Short))
        Me._LableSub_6.Location = New System.Drawing.Point(76, 100)
        Me._LableSub_6.Name = "_LableSub_6"
        Me._LableSub_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LableSub_6.Size = New System.Drawing.Size(93, 15)
        Me._LableSub_6.TabIndex = 136
        Me._LableSub_6.Text = "Lower              kg"
        '
        '_FrameSub_6
        '
        Me._FrameSub_6.BackColor = System.Drawing.SystemColors.Control
        Me._FrameSub_6.Controls.Add(Me.ChkNotAppropriateMaleSub)
        Me._FrameSub_6.Controls.Add(Me.ChkNotAppropriateFemaleSub)
        Me._FrameSub_6.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._FrameSub_6.ForeColor = System.Drawing.SystemColors.ControlText
        Me.FrameSub.SetIndex(Me._FrameSub_6, CType(6, Short))
        Me._FrameSub_6.Location = New System.Drawing.Point(8, 32)
        Me._FrameSub_6.Name = "_FrameSub_6"
        Me._FrameSub_6.Padding = New System.Windows.Forms.Padding(0)
        Me._FrameSub_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._FrameSub_6.Size = New System.Drawing.Size(293, 37)
        Me._FrameSub_6.TabIndex = 146
        Me._FrameSub_6.TabStop = False
        '
        'ChkNotAppropriateMaleSub
        '
        Me.ChkNotAppropriateMaleSub.BackColor = System.Drawing.SystemColors.Control
        Me.ChkNotAppropriateMaleSub.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkNotAppropriateMaleSub.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkNotAppropriateMaleSub.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkNotAppropriateMaleSub.Location = New System.Drawing.Point(8, 14)
        Me.ChkNotAppropriateMaleSub.Name = "ChkNotAppropriateMaleSub"
        Me.ChkNotAppropriateMaleSub.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkNotAppropriateMaleSub.Size = New System.Drawing.Size(129, 16)
        Me.ChkNotAppropriateMaleSub.TabIndex = 148
        Me.ChkNotAppropriateMaleSub.Text = "Male Not Appropriate"
        Me.ChkNotAppropriateMaleSub.UseVisualStyleBackColor = False
        '
        'ChkNotAppropriateFemaleSub
        '
        Me.ChkNotAppropriateFemaleSub.BackColor = System.Drawing.SystemColors.Control
        Me.ChkNotAppropriateFemaleSub.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkNotAppropriateFemaleSub.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkNotAppropriateFemaleSub.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkNotAppropriateFemaleSub.Location = New System.Drawing.Point(146, 14)
        Me.ChkNotAppropriateFemaleSub.Name = "ChkNotAppropriateFemaleSub"
        Me.ChkNotAppropriateFemaleSub.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkNotAppropriateFemaleSub.Size = New System.Drawing.Size(143, 16)
        Me.ChkNotAppropriateFemaleSub.TabIndex = 147
        Me.ChkNotAppropriateFemaleSub.Text = "Female Not Appropriate"
        Me.ChkNotAppropriateFemaleSub.UseVisualStyleBackColor = False
        '
        '_SSTab2_TabPage1
        '
        Me._SSTab2_TabPage1.Controls.Add(Me._Frame_17)
        Me._SSTab2_TabPage1.Controls.Add(Me.Label14)
        Me._SSTab2_TabPage1.Location = New System.Drawing.Point(4, 22)
        Me._SSTab2_TabPage1.Name = "_SSTab2_TabPage1"
        Me._SSTab2_TabPage1.Size = New System.Drawing.Size(721, 351)
        Me._SSTab2_TabPage1.TabIndex = 1
        Me._SSTab2_TabPage1.Text = "Conditional"
        '
        '_Frame_17
        '
        Me._Frame_17.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_17.Controls.Add(Me.cmdAddConditional)
        Me._Frame_17.Controls.Add(Me.cmdRemoveConditional)
        Me._Frame_17.Controls.Add(Me.LstViewConditionals)
        Me._Frame_17.Controls.Add(Me.Label15)
        Me._Frame_17.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_17.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_17, CType(17, Short))
        Me._Frame_17.Location = New System.Drawing.Point(8, 32)
        Me._Frame_17.Name = "_Frame_17"
        Me._Frame_17.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_17.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_17.Size = New System.Drawing.Size(705, 309)
        Me._Frame_17.TabIndex = 120
        Me._Frame_17.TabStop = False
        Me._Frame_17.Text = "Non-standard and conditional medical ruleouts"
        '
        'cmdAddConditional
        '
        Me.cmdAddConditional.BackColor = System.Drawing.SystemColors.Control
        Me.cmdAddConditional.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdAddConditional.Enabled = False
        Me.cmdAddConditional.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdAddConditional.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdAddConditional.Location = New System.Drawing.Point(632, 16)
        Me.cmdAddConditional.Name = "cmdAddConditional"
        Me.cmdAddConditional.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdAddConditional.Size = New System.Drawing.Size(67, 21)
        Me.cmdAddConditional.TabIndex = 122
        Me.cmdAddConditional.Text = "&Add..."
        Me.cmdAddConditional.UseVisualStyleBackColor = False
        '
        'cmdRemoveConditional
        '
        Me.cmdRemoveConditional.BackColor = System.Drawing.SystemColors.Control
        Me.cmdRemoveConditional.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdRemoveConditional.Enabled = False
        Me.cmdRemoveConditional.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdRemoveConditional.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdRemoveConditional.Location = New System.Drawing.Point(632, 276)
        Me.cmdRemoveConditional.Name = "cmdRemoveConditional"
        Me.cmdRemoveConditional.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdRemoveConditional.Size = New System.Drawing.Size(67, 21)
        Me.cmdRemoveConditional.TabIndex = 121
        Me.cmdRemoveConditional.Text = "&Remove"
        Me.cmdRemoveConditional.UseVisualStyleBackColor = False
        '
        'LstViewConditionals
        '
        Me.LstViewConditionals.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewConditionals.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.LstViewConditionals.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewConditionals.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewConditionals.FullRowSelect = True
        Me.LstViewConditionals.HideSelection = False
        Me.LstViewConditionals.LabelWrap = False
        Me.LstViewConditionals.Location = New System.Drawing.Point(10, 16)
        Me.LstViewConditionals.Name = "LstViewConditionals"
        Me.LstViewConditionals.Size = New System.Drawing.Size(613, 284)
        Me.LstViewConditionals.TabIndex = 123
        Me.LstViewConditionals.UseCompatibleStateImageBehavior = False
        Me.LstViewConditionals.View = System.Windows.Forms.View.Details
        '
        'Label15
        '
        Me.Label15.BackColor = System.Drawing.SystemColors.Control
        Me.Label15.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label15.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label15.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label15.Location = New System.Drawing.Point(11, 0)
        Me.Label15.Name = "Label15"
        Me.Label15.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label15.Size = New System.Drawing.Size(121, 17)
        Me.Label15.TabIndex = 124
        Me.Label15.Text = "Conditional/Indications"
        '
        'Label14
        '
        Me.Label14.BackColor = System.Drawing.SystemColors.Control
        Me.Label14.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label14.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label14.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label14.Location = New System.Drawing.Point(16, 32)
        Me.Label14.Name = "Label14"
        Me.Label14.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label14.Size = New System.Drawing.Size(161, 17)
        Me.Label14.TabIndex = 149
        Me.Label14.Text = "Conditional/Indications"
        '
        '_cboSubtypeProcessor_0
        '
        Me._cboSubtypeProcessor_0.BackColor = System.Drawing.SystemColors.Window
        Me._cboSubtypeProcessor_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._cboSubtypeProcessor_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._cboSubtypeProcessor_0.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cboSubtypeProcessor.SetIndex(Me._cboSubtypeProcessor_0, CType(0, Short))
        Me._cboSubtypeProcessor_0.Location = New System.Drawing.Point(112, 10)
        Me._cboSubtypeProcessor_0.Name = "_cboSubtypeProcessor_0"
        Me._cboSubtypeProcessor_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cboSubtypeProcessor_0.Size = New System.Drawing.Size(337, 22)
        Me._cboSubtypeProcessor_0.TabIndex = 150
        '
        '_SSTab1_TabPage4
        '
        Me._SSTab1_TabPage4.Controls.Add(Me._cboSubtypeProcessor_1)
        Me._SSTab1_TabPage4.Controls.Add(Me._Frame_19)
        Me._SSTab1_TabPage4.Controls.Add(Me.Label12)
        Me._SSTab1_TabPage4.Location = New System.Drawing.Point(4, 22)
        Me._SSTab1_TabPage4.Name = "_SSTab1_TabPage4"
        Me._SSTab1_TabPage4.Size = New System.Drawing.Size(742, 419)
        Me._SSTab1_TabPage4.TabIndex = 4
        Me._SSTab1_TabPage4.Text = "Schedule Groups"
        '
        '_cboSubtypeProcessor_1
        '
        Me._cboSubtypeProcessor_1.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Suggest
        Me._cboSubtypeProcessor_1.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me._cboSubtypeProcessor_1.BackColor = System.Drawing.SystemColors.Window
        Me._cboSubtypeProcessor_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._cboSubtypeProcessor_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._cboSubtypeProcessor_1.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cboSubtypeProcessor.SetIndex(Me._cboSubtypeProcessor_1, CType(1, Short))
        Me._cboSubtypeProcessor_1.Location = New System.Drawing.Point(112, 12)
        Me._cboSubtypeProcessor_1.Name = "_cboSubtypeProcessor_1"
        Me._cboSubtypeProcessor_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cboSubtypeProcessor_1.Size = New System.Drawing.Size(337, 22)
        Me._cboSubtypeProcessor_1.TabIndex = 117
        '
        '_Frame_19
        '
        Me._Frame_19.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_19.Controls.Add(Me._FrameSub_10)
        Me._Frame_19.Controls.Add(Me._FrameSub_9)
        Me._Frame_19.Controls.Add(Me.cboOrganizationSub)
        Me._Frame_19.Controls.Add(Me.cboScheduleGroupSub)
        Me._Frame_19.Controls.Add(Me.cmdRemoveScheduleSub)
        Me._Frame_19.Controls.Add(Me.cmdAddScheduleSub)
        Me._Frame_19.Controls.Add(Me.LstViewScheduleSub)
        Me._Frame_19.Controls.Add(Me.Label1Sub)
        Me._Frame_19.Controls.Add(Me._Label_3)
        Me._Frame_19.Controls.Add(Me._Label_4)
        Me._Frame_19.Controls.Add(Me._Label_5)
        Me._Frame_19.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_19.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_19, CType(19, Short))
        Me._Frame_19.Location = New System.Drawing.Point(8, 38)
        Me._Frame_19.Name = "_Frame_19"
        Me._Frame_19.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_19.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_19.Size = New System.Drawing.Size(723, 378)
        Me._Frame_19.TabIndex = 91
        Me._Frame_19.TabStop = False
        '
        '_FrameSub_10
        '
        Me._FrameSub_10.BackColor = System.Drawing.SystemColors.Control
        Me._FrameSub_10.Controls.Add(Me.chkCoronerOnlySub)
        Me._FrameSub_10.Controls.Add(Me.ChkContactOnStatlineConsentSub)
        Me._FrameSub_10.Controls.Add(Me.ChkContactOnStatlineSecondarySub)
        Me._FrameSub_10.Controls.Add(Me.ChkContactOnCoronerSub)
        Me._FrameSub_10.Controls.Add(Me.ChkContactOnHospitalConsentSub)
        Me._FrameSub_10.Controls.Add(Me.ChkContactOnConsentSub)
        Me._FrameSub_10.Controls.Add(Me.ChkNoContactOnDenySub)
        Me._FrameSub_10.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._FrameSub_10.ForeColor = System.Drawing.SystemColors.ControlText
        Me.FrameSub.SetIndex(Me._FrameSub_10, CType(10, Short))
        Me._FrameSub_10.Location = New System.Drawing.Point(72, 222)
        Me._FrameSub_10.Name = "_FrameSub_10"
        Me._FrameSub_10.Padding = New System.Windows.Forms.Padding(0)
        Me._FrameSub_10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._FrameSub_10.Size = New System.Drawing.Size(567, 145)
        Me._FrameSub_10.TabIndex = 104
        Me._FrameSub_10.TabStop = False
        Me._FrameSub_10.Text = "Contact Rules"
        '
        'chkCoronerOnlySub
        '
        Me.chkCoronerOnlySub.BackColor = System.Drawing.SystemColors.Control
        Me.chkCoronerOnlySub.Cursor = System.Windows.Forms.Cursors.Default
        Me.chkCoronerOnlySub.Enabled = False
        Me.chkCoronerOnlySub.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.chkCoronerOnlySub.ForeColor = System.Drawing.SystemColors.ControlText
        Me.chkCoronerOnlySub.Location = New System.Drawing.Point(8, 67)
        Me.chkCoronerOnlySub.Name = "chkCoronerOnlySub"
        Me.chkCoronerOnlySub.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.chkCoronerOnlySub.Size = New System.Drawing.Size(334, 18)
        Me.chkCoronerOnlySub.TabIndex = 111
        Me.chkCoronerOnlySub.Text = "Contact group if coroner's case only"
        Me.chkCoronerOnlySub.UseVisualStyleBackColor = False
        '
        'ChkContactOnStatlineConsentSub
        '
        Me.ChkContactOnStatlineConsentSub.BackColor = System.Drawing.SystemColors.Control
        Me.ChkContactOnStatlineConsentSub.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkContactOnStatlineConsentSub.Enabled = False
        Me.ChkContactOnStatlineConsentSub.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkContactOnStatlineConsentSub.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkContactOnStatlineConsentSub.Location = New System.Drawing.Point(8, 118)
        Me.ChkContactOnStatlineConsentSub.Name = "ChkContactOnStatlineConsentSub"
        Me.ChkContactOnStatlineConsentSub.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkContactOnStatlineConsentSub.Size = New System.Drawing.Size(551, 18)
        Me.ChkContactOnStatlineConsentSub.TabIndex = 110
        Me.ChkContactOnStatlineConsentSub.Text = "Do not verify contact until Statline obtains consent (consent pending event creat" & _
            "ed automatically for Statline)"
        Me.ChkContactOnStatlineConsentSub.UseVisualStyleBackColor = False
        '
        'ChkContactOnStatlineSecondarySub
        '
        Me.ChkContactOnStatlineSecondarySub.BackColor = System.Drawing.SystemColors.Control
        Me.ChkContactOnStatlineSecondarySub.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkContactOnStatlineSecondarySub.Enabled = False
        Me.ChkContactOnStatlineSecondarySub.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkContactOnStatlineSecondarySub.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkContactOnStatlineSecondarySub.Location = New System.Drawing.Point(8, 101)
        Me.ChkContactOnStatlineSecondarySub.Name = "ChkContactOnStatlineSecondarySub"
        Me.ChkContactOnStatlineSecondarySub.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkContactOnStatlineSecondarySub.Size = New System.Drawing.Size(551, 18)
        Me.ChkContactOnStatlineSecondarySub.TabIndex = 109
        Me.ChkContactOnStatlineSecondarySub.Text = "Do not verify contact until Statline performs secondary screening "
        Me.ChkContactOnStatlineSecondarySub.UseVisualStyleBackColor = False
        '
        'ChkContactOnCoronerSub
        '
        Me.ChkContactOnCoronerSub.BackColor = System.Drawing.SystemColors.Control
        Me.ChkContactOnCoronerSub.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkContactOnCoronerSub.Enabled = False
        Me.ChkContactOnCoronerSub.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkContactOnCoronerSub.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkContactOnCoronerSub.Location = New System.Drawing.Point(8, 50)
        Me.ChkContactOnCoronerSub.Name = "ChkContactOnCoronerSub"
        Me.ChkContactOnCoronerSub.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkContactOnCoronerSub.Size = New System.Drawing.Size(365, 18)
        Me.ChkContactOnCoronerSub.TabIndex = 108
        Me.ChkContactOnCoronerSub.Text = "Contact group if coroner's case and general consent is granted"
        Me.ChkContactOnCoronerSub.UseVisualStyleBackColor = False
        '
        'ChkContactOnHospitalConsentSub
        '
        Me.ChkContactOnHospitalConsentSub.BackColor = System.Drawing.SystemColors.Control
        Me.ChkContactOnHospitalConsentSub.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkContactOnHospitalConsentSub.Enabled = False
        Me.ChkContactOnHospitalConsentSub.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkContactOnHospitalConsentSub.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkContactOnHospitalConsentSub.Location = New System.Drawing.Point(8, 84)
        Me.ChkContactOnHospitalConsentSub.Name = "ChkContactOnHospitalConsentSub"
        Me.ChkContactOnHospitalConsentSub.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkContactOnHospitalConsentSub.Size = New System.Drawing.Size(551, 18)
        Me.ChkContactOnHospitalConsentSub.TabIndex = 107
        Me.ChkContactOnHospitalConsentSub.Text = "Do not verify contact until hospital obtains consent (consent pending event creat" & _
            "ed automatically for hospital)"
        Me.ChkContactOnHospitalConsentSub.UseVisualStyleBackColor = False
        '
        'ChkContactOnConsentSub
        '
        Me.ChkContactOnConsentSub.BackColor = System.Drawing.SystemColors.Control
        Me.ChkContactOnConsentSub.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkContactOnConsentSub.Enabled = False
        Me.ChkContactOnConsentSub.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkContactOnConsentSub.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkContactOnConsentSub.Location = New System.Drawing.Point(8, 33)
        Me.ChkContactOnConsentSub.Name = "ChkContactOnConsentSub"
        Me.ChkContactOnConsentSub.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkContactOnConsentSub.Size = New System.Drawing.Size(365, 18)
        Me.ChkContactOnConsentSub.TabIndex = 106
        Me.ChkContactOnConsentSub.Text = "Contact group if option is not appropriate, yet general consent is granted"
        Me.ChkContactOnConsentSub.UseVisualStyleBackColor = False
        '
        'ChkNoContactOnDenySub
        '
        Me.ChkNoContactOnDenySub.BackColor = System.Drawing.SystemColors.Control
        Me.ChkNoContactOnDenySub.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkNoContactOnDenySub.Enabled = False
        Me.ChkNoContactOnDenySub.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkNoContactOnDenySub.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkNoContactOnDenySub.Location = New System.Drawing.Point(8, 16)
        Me.ChkNoContactOnDenySub.Name = "ChkNoContactOnDenySub"
        Me.ChkNoContactOnDenySub.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkNoContactOnDenySub.Size = New System.Drawing.Size(331, 18)
        Me.ChkNoContactOnDenySub.TabIndex = 105
        Me.ChkNoContactOnDenySub.Text = "Do not contact group if general consent is denied"
        Me.ChkNoContactOnDenySub.UseVisualStyleBackColor = False
        '
        '_FrameSub_9
        '
        Me._FrameSub_9.BackColor = System.Drawing.SystemColors.Control
        Me._FrameSub_9.Controls.Add(Me.ChkResearchSub)
        Me._FrameSub_9.Controls.Add(Me.ChkOrgansSub)
        Me._FrameSub_9.Controls.Add(Me.ChkSkinSub)
        Me._FrameSub_9.Controls.Add(Me.ChkHeartValvesSub)
        Me._FrameSub_9.Controls.Add(Me.ChkBoneSub)
        Me._FrameSub_9.Controls.Add(Me.ChkEyesSub)
        Me._FrameSub_9.Controls.Add(Me.ChkSoftTissueSub)
        Me._FrameSub_9.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._FrameSub_9.ForeColor = System.Drawing.SystemColors.ControlText
        Me.FrameSub.SetIndex(Me._FrameSub_9, CType(9, Short))
        Me._FrameSub_9.Location = New System.Drawing.Point(500, 61)
        Me._FrameSub_9.Name = "_FrameSub_9"
        Me._FrameSub_9.Padding = New System.Windows.Forms.Padding(0)
        Me._FrameSub_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._FrameSub_9.Size = New System.Drawing.Size(139, 155)
        Me._FrameSub_9.TabIndex = 96
        Me._FrameSub_9.TabStop = False
        '
        'ChkResearchSub
        '
        Me.ChkResearchSub.BackColor = System.Drawing.SystemColors.Control
        Me.ChkResearchSub.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkResearchSub.Enabled = False
        Me.ChkResearchSub.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkResearchSub.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkResearchSub.Location = New System.Drawing.Point(10, 134)
        Me.ChkResearchSub.Name = "ChkResearchSub"
        Me.ChkResearchSub.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkResearchSub.Size = New System.Drawing.Size(99, 16)
        Me.ChkResearchSub.TabIndex = 103
        Me.ChkResearchSub.Text = "Research"
        Me.ChkResearchSub.UseVisualStyleBackColor = False
        '
        'ChkOrgansSub
        '
        Me.ChkOrgansSub.BackColor = System.Drawing.SystemColors.Control
        Me.ChkOrgansSub.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkOrgansSub.Enabled = False
        Me.ChkOrgansSub.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkOrgansSub.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkOrgansSub.Location = New System.Drawing.Point(10, 14)
        Me.ChkOrgansSub.Name = "ChkOrgansSub"
        Me.ChkOrgansSub.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkOrgansSub.Size = New System.Drawing.Size(83, 16)
        Me.ChkOrgansSub.TabIndex = 102
        Me.ChkOrgansSub.Text = "Organs"
        Me.ChkOrgansSub.UseVisualStyleBackColor = False
        '
        'ChkSkinSub
        '
        Me.ChkSkinSub.BackColor = System.Drawing.SystemColors.Control
        Me.ChkSkinSub.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkSkinSub.Enabled = False
        Me.ChkSkinSub.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkSkinSub.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkSkinSub.Location = New System.Drawing.Point(10, 74)
        Me.ChkSkinSub.Name = "ChkSkinSub"
        Me.ChkSkinSub.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkSkinSub.Size = New System.Drawing.Size(85, 16)
        Me.ChkSkinSub.TabIndex = 101
        Me.ChkSkinSub.Text = "Skin"
        Me.ChkSkinSub.UseVisualStyleBackColor = False
        '
        'ChkHeartValvesSub
        '
        Me.ChkHeartValvesSub.BackColor = System.Drawing.SystemColors.Control
        Me.ChkHeartValvesSub.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkHeartValvesSub.Enabled = False
        Me.ChkHeartValvesSub.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkHeartValvesSub.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkHeartValvesSub.Location = New System.Drawing.Point(10, 94)
        Me.ChkHeartValvesSub.Name = "ChkHeartValvesSub"
        Me.ChkHeartValvesSub.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkHeartValvesSub.Size = New System.Drawing.Size(95, 16)
        Me.ChkHeartValvesSub.TabIndex = 100
        Me.ChkHeartValvesSub.Text = "Heart Valves"
        Me.ChkHeartValvesSub.UseVisualStyleBackColor = False
        '
        'ChkBoneSub
        '
        Me.ChkBoneSub.BackColor = System.Drawing.SystemColors.Control
        Me.ChkBoneSub.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkBoneSub.Enabled = False
        Me.ChkBoneSub.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkBoneSub.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkBoneSub.Location = New System.Drawing.Point(10, 34)
        Me.ChkBoneSub.Name = "ChkBoneSub"
        Me.ChkBoneSub.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkBoneSub.Size = New System.Drawing.Size(97, 16)
        Me.ChkBoneSub.TabIndex = 99
        Me.ChkBoneSub.Text = "Bone"
        Me.ChkBoneSub.UseVisualStyleBackColor = False
        '
        'ChkEyesSub
        '
        Me.ChkEyesSub.BackColor = System.Drawing.SystemColors.Control
        Me.ChkEyesSub.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkEyesSub.Enabled = False
        Me.ChkEyesSub.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkEyesSub.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkEyesSub.Location = New System.Drawing.Point(10, 114)
        Me.ChkEyesSub.Name = "ChkEyesSub"
        Me.ChkEyesSub.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkEyesSub.Size = New System.Drawing.Size(95, 16)
        Me.ChkEyesSub.TabIndex = 98
        Me.ChkEyesSub.Text = "Eyes"
        Me.ChkEyesSub.UseVisualStyleBackColor = False
        '
        'ChkSoftTissueSub
        '
        Me.ChkSoftTissueSub.BackColor = System.Drawing.SystemColors.Control
        Me.ChkSoftTissueSub.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkSoftTissueSub.Enabled = False
        Me.ChkSoftTissueSub.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkSoftTissueSub.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkSoftTissueSub.Location = New System.Drawing.Point(10, 54)
        Me.ChkSoftTissueSub.Name = "ChkSoftTissueSub"
        Me.ChkSoftTissueSub.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkSoftTissueSub.Size = New System.Drawing.Size(99, 16)
        Me.ChkSoftTissueSub.TabIndex = 97
        Me.ChkSoftTissueSub.Text = "Soft Tissue"
        Me.ChkSoftTissueSub.UseVisualStyleBackColor = False
        '
        'cboOrganizationSub
        '
        Me.cboOrganizationSub.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.cboOrganizationSub.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.cboOrganizationSub.BackColor = System.Drawing.SystemColors.Window
        Me.cboOrganizationSub.Cursor = System.Windows.Forms.Cursors.Default
        Me.cboOrganizationSub.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cboOrganizationSub.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cboOrganizationSub.Location = New System.Drawing.Point(72, 13)
        Me.cboOrganizationSub.Name = "cboOrganizationSub"
        Me.cboOrganizationSub.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cboOrganizationSub.Size = New System.Drawing.Size(255, 22)
        Me.cboOrganizationSub.Sorted = True
        Me.cboOrganizationSub.TabIndex = 95
        '
        'cboScheduleGroupSub
        '
        Me.cboScheduleGroupSub.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.cboScheduleGroupSub.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.cboScheduleGroupSub.BackColor = System.Drawing.SystemColors.Window
        Me.cboScheduleGroupSub.Cursor = System.Windows.Forms.Cursors.Default
        Me.cboScheduleGroupSub.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cboScheduleGroupSub.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cboScheduleGroupSub.Location = New System.Drawing.Point(72, 37)
        Me.cboScheduleGroupSub.Name = "cboScheduleGroupSub"
        Me.cboScheduleGroupSub.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cboScheduleGroupSub.Size = New System.Drawing.Size(255, 22)
        Me.cboScheduleGroupSub.Sorted = True
        Me.cboScheduleGroupSub.TabIndex = 94
        '
        'cmdRemoveScheduleSub
        '
        Me.cmdRemoveScheduleSub.BackColor = System.Drawing.SystemColors.Control
        Me.cmdRemoveScheduleSub.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdRemoveScheduleSub.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdRemoveScheduleSub.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdRemoveScheduleSub.Location = New System.Drawing.Point(148, 63)
        Me.cmdRemoveScheduleSub.Name = "cmdRemoveScheduleSub"
        Me.cmdRemoveScheduleSub.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdRemoveScheduleSub.Size = New System.Drawing.Size(69, 21)
        Me.cmdRemoveScheduleSub.TabIndex = 93
        Me.cmdRemoveScheduleSub.Text = "Remove"
        Me.cmdRemoveScheduleSub.UseVisualStyleBackColor = False
        '
        'cmdAddScheduleSub
        '
        Me.cmdAddScheduleSub.BackColor = System.Drawing.SystemColors.Control
        Me.cmdAddScheduleSub.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdAddScheduleSub.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdAddScheduleSub.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdAddScheduleSub.Location = New System.Drawing.Point(72, 63)
        Me.cmdAddScheduleSub.Name = "cmdAddScheduleSub"
        Me.cmdAddScheduleSub.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdAddScheduleSub.Size = New System.Drawing.Size(69, 21)
        Me.cmdAddScheduleSub.TabIndex = 92
        Me.cmdAddScheduleSub.Text = "Add"
        Me.cmdAddScheduleSub.UseVisualStyleBackColor = False
        '
        'LstViewScheduleSub
        '
        Me.LstViewScheduleSub.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewScheduleSub.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.LstViewScheduleSub.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewScheduleSub.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewScheduleSub.FullRowSelect = True
        Me.LstViewScheduleSub.HideSelection = False
        Me.LstViewScheduleSub.LabelWrap = False
        Me.LstViewScheduleSub.Location = New System.Drawing.Point(72, 121)
        Me.LstViewScheduleSub.Name = "LstViewScheduleSub"
        Me.LstViewScheduleSub.Size = New System.Drawing.Size(423, 95)
        Me.LstViewScheduleSub.TabIndex = 112
        Me.LstViewScheduleSub.UseCompatibleStateImageBehavior = False
        Me.LstViewScheduleSub.View = System.Windows.Forms.View.Details
        '
        'Label1Sub
        '
        Me.Label1Sub.BackColor = System.Drawing.SystemColors.Control
        Me.Label1Sub.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label1Sub.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label1Sub.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label1Sub.Location = New System.Drawing.Point(500, 13)
        Me.Label1Sub.Name = "Label1Sub"
        Me.Label1Sub.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label1Sub.Size = New System.Drawing.Size(213, 45)
        Me.Label1Sub.TabIndex = 116
        Me.Label1Sub.Text = "Do not verify schedule group contact or apply contact rules if any of the followi" & _
            "ng options are also appropriate."
        '
        '_Label_3
        '
        Me._Label_3.BackColor = System.Drawing.SystemColors.Control
        Me._Label_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_3.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_3, CType(3, Short))
        Me._Label_3.Location = New System.Drawing.Point(72, 89)
        Me._Label_3.Name = "_Label_3"
        Me._Label_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_3.Size = New System.Drawing.Size(293, 31)
        Me._Label_3.TabIndex = 115
        Me._Label_3.Text = "When this option is appropriate, require contact of the following organization sc" & _
            "hedule groups."
        '
        '_Label_4
        '
        Me._Label_4.BackColor = System.Drawing.SystemColors.Control
        Me._Label_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_4.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_4.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_4, CType(4, Short))
        Me._Label_4.Location = New System.Drawing.Point(8, 41)
        Me._Label_4.Name = "_Label_4"
        Me._Label_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_4.Size = New System.Drawing.Size(69, 17)
        Me._Label_4.TabIndex = 114
        Me._Label_4.Text = "Schedule"
        '
        '_Label_5
        '
        Me._Label_5.BackColor = System.Drawing.SystemColors.Control
        Me._Label_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_5.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_5.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_5, CType(5, Short))
        Me._Label_5.Location = New System.Drawing.Point(8, 17)
        Me._Label_5.Name = "_Label_5"
        Me._Label_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_5.Size = New System.Drawing.Size(69, 17)
        Me._Label_5.TabIndex = 113
        Me._Label_5.Text = "Organization"
        '
        'Label12
        '
        Me.Label12.BackColor = System.Drawing.SystemColors.Control
        Me.Label12.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label12.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label12.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label12.Location = New System.Drawing.Point(8, 14)
        Me.Label12.Name = "Label12"
        Me.Label12.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label12.Size = New System.Drawing.Size(97, 17)
        Me.Label12.TabIndex = 178
        Me.Label12.Text = "SubType/Processor"
        '
        'cboSubtypeProcessor
        '
        '
        'FrmCriteria
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 14.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.ClientSize = New System.Drawing.Size(777, 575)
        Me.Controls.Add(Me.cmdTemp)
        Me.Controls.Add(Me.CmdCancel)
        Me.Controls.Add(Me._Frame_1)
        Me.Controls.Add(Me.CmdOK)
        Me.Controls.Add(Me.TabCriteria)
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Location = New System.Drawing.Point(71, 135)
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "FrmCriteria"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Criteria"
        Me._Frame_1.ResumeLayout(False)
        Me._Frame_1.PerformLayout()
        Me.TabCriteria.ResumeLayout(False)
        Me._TabCriteria_TabPage0.ResumeLayout(False)
        Me._Pic_0.ResumeLayout(False)
        Me._Frame_2.ResumeLayout(False)
        Me._Frame_2.PerformLayout()
        Me._Frame_3.ResumeLayout(False)
        Me._Frame_3.PerformLayout()
        Me._Frame_4.ResumeLayout(False)
        Me._Frame_6.ResumeLayout(False)
        Me._Pic_1.ResumeLayout(False)
        Me._Frame_7.ResumeLayout(False)
        Me._Frame_7.PerformLayout()
        Me._TabCriteria_TabPage1.ResumeLayout(False)
        Me._Frame_0.ResumeLayout(False)
        Me._TabCriteria_TabPage2.ResumeLayout(False)
        Me._Frame_5.ResumeLayout(False)
        Me._TabCriteria_TabPage3.ResumeLayout(False)
        Me._Frame_8.ResumeLayout(False)
        Me._Frame_10.ResumeLayout(False)
        Me._Frame_9.ResumeLayout(False)
        Me._TabCriteria_TabPage4.ResumeLayout(False)
        Me.Picture1.ResumeLayout(False)
        Me.SSTab1.ResumeLayout(False)
        Me._SSTab1_TabPage0.ResumeLayout(False)
        Me._Frame_11.ResumeLayout(False)
        Me._SSTab1_TabPage1.ResumeLayout(False)
        Me._Frame_13.ResumeLayout(False)
        Me._SSTab1_TabPage2.ResumeLayout(False)
        Me._Frame_12.ResumeLayout(False)
        Me._SSTab1_TabPage3.ResumeLayout(False)
        Me.SSTab2.ResumeLayout(False)
        Me._SSTab2_TabPage0.ResumeLayout(False)
        Me._FrameSub_2.ResumeLayout(False)
        Me._FrameSub_2.PerformLayout()
        Me._FrameSub_3.ResumeLayout(False)
        Me._FrameSub_3.PerformLayout()
        Me._FrameSub_6.ResumeLayout(False)
        Me._SSTab2_TabPage1.ResumeLayout(False)
        Me._Frame_17.ResumeLayout(False)
        Me._SSTab1_TabPage4.ResumeLayout(False)
        Me._Frame_19.ResumeLayout(False)
        Me._FrameSub_10.ResumeLayout(False)
        Me._FrameSub_9.ResumeLayout(False)
        CType(Me.Frame, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.FrameSub, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.Label, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.Lable, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.LableSub, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.Pic, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.cboSubtypeProcessor, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)

    End Sub
#End Region 
End Class