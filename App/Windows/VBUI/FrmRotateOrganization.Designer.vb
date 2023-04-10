<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmRotateOrganization
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
    Public WithEvents CmdClose As System.Windows.Forms.Button
    Public WithEvents cbozone As System.Windows.Forms.ComboBox
    Public WithEvents cmdSave As System.Windows.Forms.Button
    Public WithEvents CboRotationTime As System.Windows.Forms.ComboBox
    Public WithEvents CmdSelectParentOrg As System.Windows.Forms.Button
    Public WithEvents CboRotationGroup As System.Windows.Forms.ComboBox
    Public WithEvents Label30 As System.Windows.Forms.Label
    Public WithEvents Label29 As System.Windows.Forms.Label
    Public WithEvents _Lable_0 As System.Windows.Forms.Label
    Public WithEvents _Frame_1 As System.Windows.Forms.GroupBox
    Public WithEvents CmdAdd As System.Windows.Forms.Button
    Public WithEvents CmdRemove As System.Windows.Forms.Button
    Public WithEvents _ChkResearch_0 As System.Windows.Forms.CheckBox
    Public WithEvents _ChkOrgans_0 As System.Windows.Forms.CheckBox
    Public WithEvents _ChkSkin_0 As System.Windows.Forms.CheckBox
    Public WithEvents _ChkHeartValves_0 As System.Windows.Forms.CheckBox
    Public WithEvents _ChkBone_0 As System.Windows.Forms.CheckBox
    Public WithEvents _ChkEyes_0 As System.Windows.Forms.CheckBox
    Public WithEvents _ChkSoftTissue_0 As System.Windows.Forms.CheckBox
    Public WithEvents _Frame_3 As System.Windows.Forms.GroupBox
    Public WithEvents _ChkSoftTissue_1 As System.Windows.Forms.CheckBox
    Public WithEvents _ChkEyes_1 As System.Windows.Forms.CheckBox
    Public WithEvents _ChkBone_1 As System.Windows.Forms.CheckBox
    Public WithEvents _ChkHeartValves_1 As System.Windows.Forms.CheckBox
    Public WithEvents _ChkSkin_1 As System.Windows.Forms.CheckBox
    Public WithEvents _ChkOrgans_1 As System.Windows.Forms.CheckBox
    Public WithEvents _ChkResearch_1 As System.Windows.Forms.CheckBox
    Public WithEvents _Frame_4 As System.Windows.Forms.GroupBox
    Public WithEvents TxtStartActive As System.Windows.Forms.TextBox
    Public WithEvents CmdRemoveAccess As System.Windows.Forms.Button
    Public WithEvents CmdAddAccess As System.Windows.Forms.Button
    Public WithEvents TxtEndActive As System.Windows.Forms.TextBox
    Public WithEvents ChkEyeOnly As System.Windows.Forms.CheckBox
    Public WithEvents ChkTE As System.Windows.Forms.CheckBox
    Public WithEvents ChkRuleout As System.Windows.Forms.CheckBox
    Public WithEvents ChkOTE As System.Windows.Forms.CheckBox
    Public WithEvents _Lable_10 As System.Windows.Forms.Label
    Public WithEvents _Frame_5 As System.Windows.Forms.GroupBox
    Public WithEvents LstViewSourceCodes As System.Windows.Forms.ListView
    Public WithEvents LstViewDateAccess As System.Windows.Forms.ListView
    Public WithEvents _Lable_6 As System.Windows.Forms.Label
    Public WithEvents _Lable_7 As System.Windows.Forms.Label
    Public WithEvents Label1 As System.Windows.Forms.Label
    Public WithEvents _Label_0 As System.Windows.Forms.Label
    Public WithEvents _Label_1 As System.Windows.Forms.Label
    Public WithEvents _Lable_8 As System.Windows.Forms.Label
    Public WithEvents _Lable_9 As System.Windows.Forms.Label
    Public WithEvents _Frame_2 As System.Windows.Forms.GroupBox
    Public WithEvents CboOrganizationType As System.Windows.Forms.ComboBox
    Public WithEvents CmdFind As System.Windows.Forms.Button
    Public WithEvents CboState As System.Windows.Forms.ComboBox
    Public WithEvents CmdUnassigned As System.Windows.Forms.Button
    Public WithEvents LstViewSelectedOrganizations As System.Windows.Forms.ListView
    Public WithEvents LstViewAvailableOrganizations As System.Windows.Forms.ListView
    Public WithEvents Label31 As System.Windows.Forms.Label
    Public WithEvents _Lable_5 As System.Windows.Forms.Label
    Public WithEvents _Lable_2 As System.Windows.Forms.Label
    Public WithEvents _Lable_4 As System.Windows.Forms.Label
    Public WithEvents _Frame_0 As System.Windows.Forms.GroupBox
    Public WithEvents CmdDeselect As System.Windows.Forms.Button
    Public WithEvents CmdSelect As System.Windows.Forms.Button
    Public WithEvents _TabReport_TabPage0 As System.Windows.Forms.TabPage
    Public WithEvents cmdRefresh As System.Windows.Forms.Button
    Public WithEvents cmdRename2 As System.Windows.Forms.Button
    Public WithEvents cmdDeleteRow2 As System.Windows.Forms.Button
    Public WithEvents cmdAddRotation2 As System.Windows.Forms.Button
    Public WithEvents cmdRotationback As System.Windows.Forms.Button
    Public WithEvents CmdRotationForward As System.Windows.Forms.Button
    Public WithEvents cmdDeleteRotation As System.Windows.Forms.Button
    Public WithEvents CboTypeAlert2 As System.Windows.Forms.ComboBox
    Public WithEvents CboAlertGroup2 As System.Windows.Forms.ComboBox
    Public WithEvents cmdAddAlerts2 As System.Windows.Forms.Button
    Public WithEvents Label19 As System.Windows.Forms.Label
    Public WithEvents Label18 As System.Windows.Forms.Label
    Public WithEvents Frame14 As System.Windows.Forms.GroupBox
    Public WithEvents CboOrganization2 As System.Windows.Forms.ComboBox
    Public WithEvents CboScheduleGroup2 As System.Windows.Forms.ComboBox
    Public WithEvents cmdAddSchedules2 As System.Windows.Forms.Button
    Public WithEvents Label28 As System.Windows.Forms.Label
    Public WithEvents Label27 As System.Windows.Forms.Label
    Public WithEvents Frame13 As System.Windows.Forms.GroupBox
    Public WithEvents CboReportParent2 As System.Windows.Forms.ComboBox
    Public WithEvents CboReportType2 As System.Windows.Forms.ComboBox
    Public WithEvents cmdAddReportGroups2 As System.Windows.Forms.Button
    Public WithEvents Label26 As System.Windows.Forms.Label
    Public WithEvents Label25 As System.Windows.Forms.Label
    Public WithEvents Frame12 As System.Windows.Forms.GroupBox
    Public WithEvents CboSourceCodeType2 As System.Windows.Forms.ComboBox
    Public WithEvents CboSourceCodeGroup2 As System.Windows.Forms.ComboBox
    Public WithEvents cmdAddSourceCodes2 As System.Windows.Forms.Button
    Public WithEvents Label24 As System.Windows.Forms.Label
    Public WithEvents Label23 As System.Windows.Forms.Label
    Public WithEvents Frame11 As System.Windows.Forms.GroupBox
    Public WithEvents CboServiceLevel2 As System.Windows.Forms.ComboBox
    Public WithEvents cmdAddServiceLevels2 As System.Windows.Forms.Button
    Public WithEvents Label22 As System.Windows.Forms.Label
    Public WithEvents Frame10 As System.Windows.Forms.GroupBox
    Public WithEvents CboCriteria2 As System.Windows.Forms.ComboBox
    Public WithEvents CboCriteriaGroup2 As System.Windows.Forms.ComboBox
    Public WithEvents cmdAddCriteria2 As System.Windows.Forms.Button
    Public WithEvents Label21 As System.Windows.Forms.Label
    Public WithEvents Label20 As System.Windows.Forms.Label
    Public WithEvents Frame9 As System.Windows.Forms.GroupBox
    Public WithEvents MSFlexGrid2 As AxMSFlexGridLib.AxMSFlexGrid
    Public WithEvents lblRotationName2 As System.Windows.Forms.Label
    Public WithEvents Label6 As System.Windows.Forms.Label
    Public WithEvents lblRotationNext As System.Windows.Forms.Label
    Public WithEvents lblRotation2 As System.Windows.Forms.Label
    Public WithEvents Label3 As System.Windows.Forms.Label
    Public WithEvents Frame2 As System.Windows.Forms.GroupBox
    Public WithEvents cmdRename As System.Windows.Forms.Button
    Public WithEvents CmdDeleteRow As System.Windows.Forms.Button
    Public WithEvents cmdAddAlerts As System.Windows.Forms.Button
    Public WithEvents cboAlertGroup As System.Windows.Forms.ComboBox
    Public WithEvents CboTypeAlert As System.Windows.Forms.ComboBox
    Public WithEvents Label8 As System.Windows.Forms.Label
    Public WithEvents Label4 As System.Windows.Forms.Label
    Public WithEvents Frame8 As System.Windows.Forms.GroupBox
    Public WithEvents cmdAddSchedules As System.Windows.Forms.Button
    Public WithEvents CboScheduleGroup As System.Windows.Forms.ComboBox
    Public WithEvents CboOrganization As System.Windows.Forms.ComboBox
    Public WithEvents Label17 As System.Windows.Forms.Label
    Public WithEvents Label16 As System.Windows.Forms.Label
    Public WithEvents Frame7 As System.Windows.Forms.GroupBox
    Public WithEvents cmdAddReportGroups As System.Windows.Forms.Button
    Public WithEvents CboReportType As System.Windows.Forms.ComboBox
    Public WithEvents CboReportParent As System.Windows.Forms.ComboBox
    Public WithEvents Label15 As System.Windows.Forms.Label
    Public WithEvents Label14 As System.Windows.Forms.Label
    Public WithEvents Frame6 As System.Windows.Forms.GroupBox
    Public WithEvents cmdAddSourceCodes As System.Windows.Forms.Button
    Public WithEvents CboSourceCodeGroup As System.Windows.Forms.ComboBox
    Public WithEvents CboSourceCodeType As System.Windows.Forms.ComboBox
    Public WithEvents Label13 As System.Windows.Forms.Label
    Public WithEvents Label12 As System.Windows.Forms.Label
    Public WithEvents Frame5 As System.Windows.Forms.GroupBox
    Public WithEvents cmdAddServiceLevels As System.Windows.Forms.Button
    Public WithEvents CboServiceLevel As System.Windows.Forms.ComboBox
    Public WithEvents Label11 As System.Windows.Forms.Label
    Public WithEvents Frame4 As System.Windows.Forms.GroupBox
    Public WithEvents cmdAddCriteria As System.Windows.Forms.Button
    Public WithEvents CboCriteriaGroup As System.Windows.Forms.ComboBox
    Public WithEvents CboCriteria As System.Windows.Forms.ComboBox
    Public WithEvents Label9 As System.Windows.Forms.Label
    Public WithEvents Label10 As System.Windows.Forms.Label
    Public WithEvents Frame3 As System.Windows.Forms.GroupBox
    Public WithEvents MSFlexGrid1 As AxMSFlexGridLib.AxMSFlexGrid
    Public WithEvents lblRotationName As System.Windows.Forms.Label
    Public WithEvents Label5 As System.Windows.Forms.Label
    Public WithEvents Label2 As System.Windows.Forms.Label
    Public WithEvents lblone As System.Windows.Forms.Label
    Public WithEvents lblRotation As System.Windows.Forms.Label
    Public WithEvents Frame1 As System.Windows.Forms.GroupBox
    Public WithEvents _TabReport_TabPage1 As System.Windows.Forms.TabPage
    Public WithEvents Text4 As System.Windows.Forms.TextBox
    Public WithEvents Text3 As System.Windows.Forms.TextBox
    Public WithEvents Text2 As System.Windows.Forms.TextBox
    Public WithEvents Text1 As System.Windows.Forms.TextBox
    Public WithEvents MSFlexGrid3 As AxMSFlexGridLib.AxMSFlexGrid
    Public WithEvents Label7 As System.Windows.Forms.Label
    Public WithEvents _TabReport_TabPage2 As System.Windows.Forms.TabPage
    Public WithEvents TabReport As System.Windows.Forms.TabControl
    Public WithEvents ChkBone As Microsoft.VisualBasic.Compatibility.VB6.CheckBoxArray
    Public WithEvents ChkEyes As Microsoft.VisualBasic.Compatibility.VB6.CheckBoxArray
    Public WithEvents ChkHeartValves As Microsoft.VisualBasic.Compatibility.VB6.CheckBoxArray
    Public WithEvents ChkOrgans As Microsoft.VisualBasic.Compatibility.VB6.CheckBoxArray
    Public WithEvents ChkResearch As Microsoft.VisualBasic.Compatibility.VB6.CheckBoxArray
    Public WithEvents ChkSkin As Microsoft.VisualBasic.Compatibility.VB6.CheckBoxArray
    Public WithEvents ChkSoftTissue As Microsoft.VisualBasic.Compatibility.VB6.CheckBoxArray
    Public WithEvents Frame As Microsoft.VisualBasic.Compatibility.VB6.GroupBoxArray
    Public WithEvents Label As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
    Public WithEvents Lable As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FrmRotateOrganization))
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me._Frame_1 = New System.Windows.Forms.GroupBox
        Me.CmdClose = New System.Windows.Forms.Button
        Me.cbozone = New System.Windows.Forms.ComboBox
        Me.cmdSave = New System.Windows.Forms.Button
        Me.CboRotationTime = New System.Windows.Forms.ComboBox
        Me.CmdSelectParentOrg = New System.Windows.Forms.Button
        Me.CboRotationGroup = New System.Windows.Forms.ComboBox
        Me.Label30 = New System.Windows.Forms.Label
        Me.Label29 = New System.Windows.Forms.Label
        Me._Lable_0 = New System.Windows.Forms.Label
        Me.TabReport = New System.Windows.Forms.TabControl
        Me._TabReport_TabPage0 = New System.Windows.Forms.TabPage
        Me.CmdSelect = New System.Windows.Forms.Button
        Me.CmdDeselect = New System.Windows.Forms.Button
        Me._Frame_0 = New System.Windows.Forms.GroupBox
        Me.CboOrganizationType = New System.Windows.Forms.ComboBox
        Me.CmdFind = New System.Windows.Forms.Button
        Me.CboState = New System.Windows.Forms.ComboBox
        Me.CmdUnassigned = New System.Windows.Forms.Button
        Me.LstViewSelectedOrganizations = New System.Windows.Forms.ListView
        Me.LstViewAvailableOrganizations = New System.Windows.Forms.ListView
        Me.Label31 = New System.Windows.Forms.Label
        Me._Lable_5 = New System.Windows.Forms.Label
        Me._Lable_2 = New System.Windows.Forms.Label
        Me._Lable_4 = New System.Windows.Forms.Label
        Me._TabReport_TabPage1 = New System.Windows.Forms.TabPage
        Me.cmdRefresh = New System.Windows.Forms.Button
        Me.Frame2 = New System.Windows.Forms.GroupBox
        Me.cmdRename2 = New System.Windows.Forms.Button
        Me.cmdDeleteRow2 = New System.Windows.Forms.Button
        Me.cmdAddRotation2 = New System.Windows.Forms.Button
        Me.cmdRotationback = New System.Windows.Forms.Button
        Me.CmdRotationForward = New System.Windows.Forms.Button
        Me.cmdDeleteRotation = New System.Windows.Forms.Button
        Me.Frame14 = New System.Windows.Forms.GroupBox
        Me.CboTypeAlert2 = New System.Windows.Forms.ComboBox
        Me.CboAlertGroup2 = New System.Windows.Forms.ComboBox
        Me.cmdAddAlerts2 = New System.Windows.Forms.Button
        Me.Label19 = New System.Windows.Forms.Label
        Me.Label18 = New System.Windows.Forms.Label
        Me.Frame13 = New System.Windows.Forms.GroupBox
        Me.CboOrganization2 = New System.Windows.Forms.ComboBox
        Me.CboScheduleGroup2 = New System.Windows.Forms.ComboBox
        Me.cmdAddSchedules2 = New System.Windows.Forms.Button
        Me.Label28 = New System.Windows.Forms.Label
        Me.Label27 = New System.Windows.Forms.Label
        Me.Frame12 = New System.Windows.Forms.GroupBox
        Me.CboReportParent2 = New System.Windows.Forms.ComboBox
        Me.CboReportType2 = New System.Windows.Forms.ComboBox
        Me.cmdAddReportGroups2 = New System.Windows.Forms.Button
        Me.Label26 = New System.Windows.Forms.Label
        Me.Label25 = New System.Windows.Forms.Label
        Me.Frame11 = New System.Windows.Forms.GroupBox
        Me.CboSourceCodeType2 = New System.Windows.Forms.ComboBox
        Me.CboSourceCodeGroup2 = New System.Windows.Forms.ComboBox
        Me.cmdAddSourceCodes2 = New System.Windows.Forms.Button
        Me.Label24 = New System.Windows.Forms.Label
        Me.Label23 = New System.Windows.Forms.Label
        Me.Frame10 = New System.Windows.Forms.GroupBox
        Me.CboServiceLevel2 = New System.Windows.Forms.ComboBox
        Me.cmdAddServiceLevels2 = New System.Windows.Forms.Button
        Me.Label22 = New System.Windows.Forms.Label
        Me.Frame9 = New System.Windows.Forms.GroupBox
        Me.CboCriteria2 = New System.Windows.Forms.ComboBox
        Me.CboCriteriaGroup2 = New System.Windows.Forms.ComboBox
        Me.cmdAddCriteria2 = New System.Windows.Forms.Button
        Me.Label21 = New System.Windows.Forms.Label
        Me.Label20 = New System.Windows.Forms.Label
        Me.MSFlexGrid2 = New AxMSFlexGridLib.AxMSFlexGrid
        Me.lblRotationName2 = New System.Windows.Forms.Label
        Me.Label6 = New System.Windows.Forms.Label
        Me.lblRotationNext = New System.Windows.Forms.Label
        Me.lblRotation2 = New System.Windows.Forms.Label
        Me.Label3 = New System.Windows.Forms.Label
        Me.Frame1 = New System.Windows.Forms.GroupBox
        Me.cmdRename = New System.Windows.Forms.Button
        Me.CmdDeleteRow = New System.Windows.Forms.Button
        Me.Frame8 = New System.Windows.Forms.GroupBox
        Me.cmdAddAlerts = New System.Windows.Forms.Button
        Me.cboAlertGroup = New System.Windows.Forms.ComboBox
        Me.CboTypeAlert = New System.Windows.Forms.ComboBox
        Me.Label8 = New System.Windows.Forms.Label
        Me.Label4 = New System.Windows.Forms.Label
        Me.Frame7 = New System.Windows.Forms.GroupBox
        Me.cmdAddSchedules = New System.Windows.Forms.Button
        Me.CboScheduleGroup = New System.Windows.Forms.ComboBox
        Me.CboOrganization = New System.Windows.Forms.ComboBox
        Me.Label17 = New System.Windows.Forms.Label
        Me.Label16 = New System.Windows.Forms.Label
        Me.Frame6 = New System.Windows.Forms.GroupBox
        Me.cmdAddReportGroups = New System.Windows.Forms.Button
        Me.CboReportType = New System.Windows.Forms.ComboBox
        Me.CboReportParent = New System.Windows.Forms.ComboBox
        Me.Label15 = New System.Windows.Forms.Label
        Me.Label14 = New System.Windows.Forms.Label
        Me.Frame5 = New System.Windows.Forms.GroupBox
        Me.cmdAddSourceCodes = New System.Windows.Forms.Button
        Me.CboSourceCodeGroup = New System.Windows.Forms.ComboBox
        Me.CboSourceCodeType = New System.Windows.Forms.ComboBox
        Me.Label13 = New System.Windows.Forms.Label
        Me.Label12 = New System.Windows.Forms.Label
        Me.Frame4 = New System.Windows.Forms.GroupBox
        Me.cmdAddServiceLevels = New System.Windows.Forms.Button
        Me.CboServiceLevel = New System.Windows.Forms.ComboBox
        Me.Label11 = New System.Windows.Forms.Label
        Me.Frame3 = New System.Windows.Forms.GroupBox
        Me.cmdAddCriteria = New System.Windows.Forms.Button
        Me.CboCriteriaGroup = New System.Windows.Forms.ComboBox
        Me.CboCriteria = New System.Windows.Forms.ComboBox
        Me.Label9 = New System.Windows.Forms.Label
        Me.Label10 = New System.Windows.Forms.Label
        Me.MSFlexGrid1 = New AxMSFlexGridLib.AxMSFlexGrid
        Me.lblRotationName = New System.Windows.Forms.Label
        Me.Label5 = New System.Windows.Forms.Label
        Me.Label2 = New System.Windows.Forms.Label
        Me.lblone = New System.Windows.Forms.Label
        Me.lblRotation = New System.Windows.Forms.Label
        Me._TabReport_TabPage2 = New System.Windows.Forms.TabPage
        Me.Text4 = New System.Windows.Forms.TextBox
        Me.Text3 = New System.Windows.Forms.TextBox
        Me.Text2 = New System.Windows.Forms.TextBox
        Me.Text1 = New System.Windows.Forms.TextBox
        Me.MSFlexGrid3 = New AxMSFlexGridLib.AxMSFlexGrid
        Me.Label7 = New System.Windows.Forms.Label
        Me._Frame_2 = New System.Windows.Forms.GroupBox
        Me.CmdAdd = New System.Windows.Forms.Button
        Me.CmdRemove = New System.Windows.Forms.Button
        Me._Frame_3 = New System.Windows.Forms.GroupBox
        Me._ChkResearch_0 = New System.Windows.Forms.CheckBox
        Me._ChkOrgans_0 = New System.Windows.Forms.CheckBox
        Me._ChkSkin_0 = New System.Windows.Forms.CheckBox
        Me._ChkHeartValves_0 = New System.Windows.Forms.CheckBox
        Me._ChkBone_0 = New System.Windows.Forms.CheckBox
        Me._ChkEyes_0 = New System.Windows.Forms.CheckBox
        Me._ChkSoftTissue_0 = New System.Windows.Forms.CheckBox
        Me._Frame_4 = New System.Windows.Forms.GroupBox
        Me._ChkSoftTissue_1 = New System.Windows.Forms.CheckBox
        Me._ChkEyes_1 = New System.Windows.Forms.CheckBox
        Me._ChkBone_1 = New System.Windows.Forms.CheckBox
        Me._ChkHeartValves_1 = New System.Windows.Forms.CheckBox
        Me._ChkSkin_1 = New System.Windows.Forms.CheckBox
        Me._ChkOrgans_1 = New System.Windows.Forms.CheckBox
        Me._ChkResearch_1 = New System.Windows.Forms.CheckBox
        Me.TxtStartActive = New System.Windows.Forms.TextBox
        Me.CmdRemoveAccess = New System.Windows.Forms.Button
        Me.CmdAddAccess = New System.Windows.Forms.Button
        Me.TxtEndActive = New System.Windows.Forms.TextBox
        Me._Frame_5 = New System.Windows.Forms.GroupBox
        Me.ChkEyeOnly = New System.Windows.Forms.CheckBox
        Me.ChkTE = New System.Windows.Forms.CheckBox
        Me.ChkRuleout = New System.Windows.Forms.CheckBox
        Me.ChkOTE = New System.Windows.Forms.CheckBox
        Me._Lable_10 = New System.Windows.Forms.Label
        Me.LstViewSourceCodes = New System.Windows.Forms.ListView
        Me.LstViewDateAccess = New System.Windows.Forms.ListView
        Me._Lable_6 = New System.Windows.Forms.Label
        Me._Lable_7 = New System.Windows.Forms.Label
        Me.Label1 = New System.Windows.Forms.Label
        Me._Label_0 = New System.Windows.Forms.Label
        Me._Label_1 = New System.Windows.Forms.Label
        Me._Lable_8 = New System.Windows.Forms.Label
        Me._Lable_9 = New System.Windows.Forms.Label
        Me.ChkBone = New Microsoft.VisualBasic.Compatibility.VB6.CheckBoxArray(Me.components)
        Me.ChkEyes = New Microsoft.VisualBasic.Compatibility.VB6.CheckBoxArray(Me.components)
        Me.ChkHeartValves = New Microsoft.VisualBasic.Compatibility.VB6.CheckBoxArray(Me.components)
        Me.ChkOrgans = New Microsoft.VisualBasic.Compatibility.VB6.CheckBoxArray(Me.components)
        Me.ChkResearch = New Microsoft.VisualBasic.Compatibility.VB6.CheckBoxArray(Me.components)
        Me.ChkSkin = New Microsoft.VisualBasic.Compatibility.VB6.CheckBoxArray(Me.components)
        Me.ChkSoftTissue = New Microsoft.VisualBasic.Compatibility.VB6.CheckBoxArray(Me.components)
        Me.Frame = New Microsoft.VisualBasic.Compatibility.VB6.GroupBoxArray(Me.components)
        Me.Label = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(Me.components)
        Me.Lable = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(Me.components)
        Me._Frame_1.SuspendLayout()
        Me.TabReport.SuspendLayout()
        Me._TabReport_TabPage0.SuspendLayout()
        Me._Frame_0.SuspendLayout()
        Me._TabReport_TabPage1.SuspendLayout()
        Me.Frame2.SuspendLayout()
        Me.Frame14.SuspendLayout()
        Me.Frame13.SuspendLayout()
        Me.Frame12.SuspendLayout()
        Me.Frame11.SuspendLayout()
        Me.Frame10.SuspendLayout()
        Me.Frame9.SuspendLayout()
        CType(Me.MSFlexGrid2, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.Frame1.SuspendLayout()
        Me.Frame8.SuspendLayout()
        Me.Frame7.SuspendLayout()
        Me.Frame6.SuspendLayout()
        Me.Frame5.SuspendLayout()
        Me.Frame4.SuspendLayout()
        Me.Frame3.SuspendLayout()
        CType(Me.MSFlexGrid1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me._TabReport_TabPage2.SuspendLayout()
        CType(Me.MSFlexGrid3, System.ComponentModel.ISupportInitialize).BeginInit()
        Me._Frame_2.SuspendLayout()
        Me._Frame_3.SuspendLayout()
        Me._Frame_4.SuspendLayout()
        Me._Frame_5.SuspendLayout()
        CType(Me.ChkBone, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.ChkEyes, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.ChkHeartValves, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.ChkOrgans, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.ChkResearch, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.ChkSkin, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.ChkSoftTissue, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.Frame, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.Label, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.Lable, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        '_Frame_1
        '
        Me._Frame_1.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_1.Controls.Add(Me.CmdClose)
        Me._Frame_1.Controls.Add(Me.cbozone)
        Me._Frame_1.Controls.Add(Me.cmdSave)
        Me._Frame_1.Controls.Add(Me.CboRotationTime)
        Me._Frame_1.Controls.Add(Me.CmdSelectParentOrg)
        Me._Frame_1.Controls.Add(Me.CboRotationGroup)
        Me._Frame_1.Controls.Add(Me.Label30)
        Me._Frame_1.Controls.Add(Me.Label29)
        Me._Frame_1.Controls.Add(Me._Lable_0)
        Me._Frame_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_1, CType(1, Short))
        Me._Frame_1.Location = New System.Drawing.Point(8, 8)
        Me._Frame_1.Name = "_Frame_1"
        Me._Frame_1.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_1.Size = New System.Drawing.Size(799, 55)
        Me._Frame_1.TabIndex = 48
        Me._Frame_1.TabStop = False
        '
        'CmdClose
        '
        Me.CmdClose.BackColor = System.Drawing.SystemColors.Control
        Me.CmdClose.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdClose.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdClose.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdClose.Location = New System.Drawing.Point(720, 32)
        Me.CmdClose.Name = "CmdClose"
        Me.CmdClose.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdClose.Size = New System.Drawing.Size(65, 19)
        Me.CmdClose.TabIndex = 160
        Me.CmdClose.Text = "Close"
        Me.CmdClose.UseVisualStyleBackColor = False
        '
        'cbozone
        '
        Me.cbozone.BackColor = System.Drawing.SystemColors.Window
        Me.cbozone.Cursor = System.Windows.Forms.Cursors.Default
        Me.cbozone.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cbozone.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cbozone.Location = New System.Drawing.Point(420, 24)
        Me.cbozone.Name = "cbozone"
        Me.cbozone.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cbozone.Size = New System.Drawing.Size(57, 22)
        Me.cbozone.TabIndex = 134
        '
        'cmdSave
        '
        Me.cmdSave.BackColor = System.Drawing.SystemColors.Control
        Me.cmdSave.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdSave.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdSave.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdSave.Location = New System.Drawing.Point(720, 12)
        Me.cmdSave.Name = "cmdSave"
        Me.cmdSave.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdSave.Size = New System.Drawing.Size(65, 19)
        Me.cmdSave.TabIndex = 127
        Me.cmdSave.Text = "Save"
        Me.cmdSave.UseVisualStyleBackColor = False
        '
        'CboRotationTime
        '
        Me.CboRotationTime.BackColor = System.Drawing.SystemColors.Window
        Me.CboRotationTime.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboRotationTime.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboRotationTime.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboRotationTime.Location = New System.Drawing.Point(316, 24)
        Me.CboRotationTime.Name = "CboRotationTime"
        Me.CboRotationTime.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboRotationTime.Size = New System.Drawing.Size(97, 22)
        Me.CboRotationTime.TabIndex = 55
        '
        'CmdSelectParentOrg
        '
        Me.CmdSelectParentOrg.BackColor = System.Drawing.SystemColors.Control
        Me.CmdSelectParentOrg.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdSelectParentOrg.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdSelectParentOrg.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdSelectParentOrg.Location = New System.Drawing.Point(264, 24)
        Me.CmdSelectParentOrg.Name = "CmdSelectParentOrg"
        Me.CmdSelectParentOrg.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdSelectParentOrg.Size = New System.Drawing.Size(24, 21)
        Me.CmdSelectParentOrg.TabIndex = 50
        Me.CmdSelectParentOrg.Text = "..."
        Me.CmdSelectParentOrg.UseVisualStyleBackColor = False
        '
        'CboRotationGroup
        '
        Me.CboRotationGroup.BackColor = System.Drawing.SystemColors.Window
        Me.CboRotationGroup.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboRotationGroup.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboRotationGroup.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboRotationGroup.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboRotationGroup.Location = New System.Drawing.Point(8, 24)
        Me.CboRotationGroup.Name = "CboRotationGroup"
        Me.CboRotationGroup.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboRotationGroup.Size = New System.Drawing.Size(251, 22)
        Me.CboRotationGroup.Sorted = True
        Me.CboRotationGroup.TabIndex = 49
        '
        'Label30
        '
        Me.Label30.BackColor = System.Drawing.SystemColors.Control
        Me.Label30.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label30.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label30.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label30.Location = New System.Drawing.Point(420, 8)
        Me.Label30.Name = "Label30"
        Me.Label30.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label30.Size = New System.Drawing.Size(73, 17)
        Me.Label30.TabIndex = 158
        Me.Label30.Text = "Time Zone"
        '
        'Label29
        '
        Me.Label29.AutoSize = True
        Me.Label29.BackColor = System.Drawing.SystemColors.Control
        Me.Label29.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label29.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label29.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label29.Location = New System.Drawing.Point(316, 8)
        Me.Label29.Name = "Label29"
        Me.Label29.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label29.Size = New System.Drawing.Size(101, 14)
        Me.Label29.TabIndex = 157
        Me.Label29.Text = "Rotation Frequency"
        '
        '_Lable_0
        '
        Me._Lable_0.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_0, CType(0, Short))
        Me._Lable_0.Location = New System.Drawing.Point(8, 8)
        Me._Lable_0.Name = "_Lable_0"
        Me._Lable_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_0.Size = New System.Drawing.Size(65, 17)
        Me._Lable_0.TabIndex = 51
        Me._Lable_0.Text = "Group"
        '
        'TabReport
        '
        Me.TabReport.Controls.Add(Me._TabReport_TabPage0)
        Me.TabReport.Controls.Add(Me._TabReport_TabPage1)
        Me.TabReport.Controls.Add(Me._TabReport_TabPage2)
        Me.TabReport.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TabReport.ItemSize = New System.Drawing.Size(42, 18)
        Me.TabReport.Location = New System.Drawing.Point(8, 64)
        Me.TabReport.Name = "TabReport"
        Me.TabReport.SelectedIndex = 0
        Me.TabReport.Size = New System.Drawing.Size(797, 601)
        Me.TabReport.TabIndex = 0
        '
        '_TabReport_TabPage0
        '
        Me._TabReport_TabPage0.Controls.Add(Me.CmdSelect)
        Me._TabReport_TabPage0.Controls.Add(Me.CmdDeselect)
        Me._TabReport_TabPage0.Controls.Add(Me._Frame_0)
        Me._TabReport_TabPage0.Location = New System.Drawing.Point(4, 22)
        Me._TabReport_TabPage0.Name = "_TabReport_TabPage0"
        Me._TabReport_TabPage0.Size = New System.Drawing.Size(789, 575)
        Me._TabReport_TabPage0.TabIndex = 0
        Me._TabReport_TabPage0.Text = "Applies To"
        '
        'CmdSelect
        '
        Me.CmdSelect.BackColor = System.Drawing.SystemColors.Control
        Me.CmdSelect.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdSelect.Enabled = False
        Me.CmdSelect.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdSelect.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdSelect.Location = New System.Drawing.Point(344, 248)
        Me.CmdSelect.Name = "CmdSelect"
        Me.CmdSelect.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdSelect.Size = New System.Drawing.Size(54, 21)
        Me.CmdSelect.TabIndex = 120
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
        Me.CmdDeselect.Location = New System.Drawing.Point(343, 272)
        Me.CmdDeselect.Name = "CmdDeselect"
        Me.CmdDeselect.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdDeselect.Size = New System.Drawing.Size(54, 21)
        Me.CmdDeselect.TabIndex = 119
        Me.CmdDeselect.Text = "Remove"
        Me.CmdDeselect.UseVisualStyleBackColor = False
        '
        '_Frame_0
        '
        Me._Frame_0.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_0.Controls.Add(Me.CboOrganizationType)
        Me._Frame_0.Controls.Add(Me.CmdFind)
        Me._Frame_0.Controls.Add(Me.CboState)
        Me._Frame_0.Controls.Add(Me.CmdUnassigned)
        Me._Frame_0.Controls.Add(Me.LstViewSelectedOrganizations)
        Me._Frame_0.Controls.Add(Me.LstViewAvailableOrganizations)
        Me._Frame_0.Controls.Add(Me.Label31)
        Me._Frame_0.Controls.Add(Me._Lable_5)
        Me._Frame_0.Controls.Add(Me._Lable_2)
        Me._Frame_0.Controls.Add(Me._Lable_4)
        Me._Frame_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_0, CType(0, Short))
        Me._Frame_0.Location = New System.Drawing.Point(6, 8)
        Me._Frame_0.Name = "_Frame_0"
        Me._Frame_0.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_0.Size = New System.Drawing.Size(759, 449)
        Me._Frame_0.TabIndex = 39
        Me._Frame_0.TabStop = False
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
        Me.CboOrganizationType.TabIndex = 44
        '
        'CmdFind
        '
        Me.CmdFind.BackColor = System.Drawing.SystemColors.Control
        Me.CmdFind.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdFind.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdFind.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdFind.Location = New System.Drawing.Point(274, 14)
        Me.CmdFind.Name = "CmdFind"
        Me.CmdFind.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdFind.Size = New System.Drawing.Size(72, 21)
        Me.CmdFind.TabIndex = 43
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
        Me.CboState.TabIndex = 42
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
        Me.CmdUnassigned.Size = New System.Drawing.Size(72, 21)
        Me.CmdUnassigned.TabIndex = 40
        Me.CmdUnassigned.Text = "&Unassigned"
        Me.CmdUnassigned.UseVisualStyleBackColor = False
        Me.CmdUnassigned.Visible = False
        '
        'LstViewSelectedOrganizations
        '
        Me.LstViewSelectedOrganizations.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewSelectedOrganizations.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewSelectedOrganizations.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewSelectedOrganizations.FullRowSelect = True
        Me.LstViewSelectedOrganizations.HideSelection = False
        Me.LstViewSelectedOrganizations.LabelWrap = False
        Me.LstViewSelectedOrganizations.Location = New System.Drawing.Point(392, 72)
        Me.LstViewSelectedOrganizations.Name = "LstViewSelectedOrganizations"
        Me.LstViewSelectedOrganizations.Size = New System.Drawing.Size(359, 361)
        Me.LstViewSelectedOrganizations.TabIndex = 41
        Me.LstViewSelectedOrganizations.UseCompatibleStateImageBehavior = False
        Me.LstViewSelectedOrganizations.View = System.Windows.Forms.View.Details
        '
        'LstViewAvailableOrganizations
        '
        Me.LstViewAvailableOrganizations.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewAvailableOrganizations.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewAvailableOrganizations.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewAvailableOrganizations.FullRowSelect = True
        Me.LstViewAvailableOrganizations.HideSelection = False
        Me.LstViewAvailableOrganizations.LabelWrap = False
        Me.LstViewAvailableOrganizations.Location = New System.Drawing.Point(8, 72)
        Me.LstViewAvailableOrganizations.Name = "LstViewAvailableOrganizations"
        Me.LstViewAvailableOrganizations.Size = New System.Drawing.Size(327, 361)
        Me.LstViewAvailableOrganizations.TabIndex = 118
        Me.LstViewAvailableOrganizations.UseCompatibleStateImageBehavior = False
        Me.LstViewAvailableOrganizations.View = System.Windows.Forms.View.Details
        '
        'Label31
        '
        Me.Label31.BackColor = System.Drawing.SystemColors.Control
        Me.Label31.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label31.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label31.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label31.Location = New System.Drawing.Point(392, 56)
        Me.Label31.Name = "Label31"
        Me.Label31.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label31.Size = New System.Drawing.Size(173, 21)
        Me.Label31.TabIndex = 159
        Me.Label31.Text = "Selected Organizations"
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
        Me._Lable_5.TabIndex = 47
        Me._Lable_5.Text = "Type"
        '
        '_Lable_2
        '
        Me._Lable_2.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_2, CType(2, Short))
        Me._Lable_2.Location = New System.Drawing.Point(8, 56)
        Me._Lable_2.Name = "_Lable_2"
        Me._Lable_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_2.Size = New System.Drawing.Size(137, 17)
        Me._Lable_2.TabIndex = 46
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
        Me._Lable_4.TabIndex = 45
        Me._Lable_4.Text = "State"
        '
        '_TabReport_TabPage1
        '
        Me._TabReport_TabPage1.Controls.Add(Me.cmdRefresh)
        Me._TabReport_TabPage1.Controls.Add(Me.Frame2)
        Me._TabReport_TabPage1.Controls.Add(Me.Frame1)
        Me._TabReport_TabPage1.Location = New System.Drawing.Point(4, 22)
        Me._TabReport_TabPage1.Name = "_TabReport_TabPage1"
        Me._TabReport_TabPage1.Size = New System.Drawing.Size(789, 575)
        Me._TabReport_TabPage1.TabIndex = 1
        Me._TabReport_TabPage1.Text = "Rotation"
        '
        'cmdRefresh
        '
        Me.cmdRefresh.BackColor = System.Drawing.SystemColors.Control
        Me.cmdRefresh.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdRefresh.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdRefresh.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdRefresh.Location = New System.Drawing.Point(726, 7)
        Me.cmdRefresh.Name = "cmdRefresh"
        Me.cmdRefresh.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdRefresh.Size = New System.Drawing.Size(57, 20)
        Me.cmdRefresh.TabIndex = 130
        Me.cmdRefresh.Text = "Refresh"
        Me.cmdRefresh.UseVisualStyleBackColor = False
        '
        'Frame2
        '
        Me.Frame2.BackColor = System.Drawing.SystemColors.Control
        Me.Frame2.Controls.Add(Me.cmdRename2)
        Me.Frame2.Controls.Add(Me.cmdDeleteRow2)
        Me.Frame2.Controls.Add(Me.cmdAddRotation2)
        Me.Frame2.Controls.Add(Me.cmdRotationback)
        Me.Frame2.Controls.Add(Me.CmdRotationForward)
        Me.Frame2.Controls.Add(Me.cmdDeleteRotation)
        Me.Frame2.Controls.Add(Me.Frame14)
        Me.Frame2.Controls.Add(Me.Frame13)
        Me.Frame2.Controls.Add(Me.Frame12)
        Me.Frame2.Controls.Add(Me.Frame11)
        Me.Frame2.Controls.Add(Me.Frame10)
        Me.Frame2.Controls.Add(Me.Frame9)
        Me.Frame2.Controls.Add(Me.MSFlexGrid2)
        Me.Frame2.Controls.Add(Me.lblRotationName2)
        Me.Frame2.Controls.Add(Me.Label6)
        Me.Frame2.Controls.Add(Me.lblRotationNext)
        Me.Frame2.Controls.Add(Me.lblRotation2)
        Me.Frame2.Controls.Add(Me.Label3)
        Me.Frame2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Frame2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame2.Location = New System.Drawing.Point(398, 23)
        Me.Frame2.Name = "Frame2"
        Me.Frame2.Padding = New System.Windows.Forms.Padding(0)
        Me.Frame2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame2.Size = New System.Drawing.Size(385, 541)
        Me.Frame2.TabIndex = 53
        Me.Frame2.TabStop = False
        Me.Frame2.Text = "Next Rotation"
        '
        'cmdRename2
        '
        Me.cmdRename2.BackColor = System.Drawing.SystemColors.Control
        Me.cmdRename2.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdRename2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdRename2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdRename2.Location = New System.Drawing.Point(208, 68)
        Me.cmdRename2.Name = "cmdRename2"
        Me.cmdRename2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdRename2.Size = New System.Drawing.Size(54, 21)
        Me.cmdRename2.TabIndex = 129
        Me.cmdRename2.Text = "Rename"
        Me.cmdRename2.UseVisualStyleBackColor = False
        '
        'cmdDeleteRow2
        '
        Me.cmdDeleteRow2.BackColor = System.Drawing.SystemColors.Control
        Me.cmdDeleteRow2.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdDeleteRow2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdDeleteRow2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdDeleteRow2.Location = New System.Drawing.Point(312, 192)
        Me.cmdDeleteRow2.Name = "cmdDeleteRow2"
        Me.cmdDeleteRow2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdDeleteRow2.Size = New System.Drawing.Size(65, 20)
        Me.cmdDeleteRow2.TabIndex = 116
        Me.cmdDeleteRow2.Text = "Delete"
        Me.cmdDeleteRow2.UseVisualStyleBackColor = False
        '
        'cmdAddRotation2
        '
        Me.cmdAddRotation2.BackColor = System.Drawing.SystemColors.Control
        Me.cmdAddRotation2.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdAddRotation2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdAddRotation2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdAddRotation2.Location = New System.Drawing.Point(216, 8)
        Me.cmdAddRotation2.Name = "cmdAddRotation2"
        Me.cmdAddRotation2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdAddRotation2.Size = New System.Drawing.Size(84, 20)
        Me.cmdAddRotation2.TabIndex = 109
        Me.cmdAddRotation2.Text = "AddRotation"
        Me.cmdAddRotation2.UseVisualStyleBackColor = False
        '
        'cmdRotationback
        '
        Me.cmdRotationback.BackColor = System.Drawing.SystemColors.Control
        Me.cmdRotationback.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdRotationback.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdRotationback.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdRotationback.Location = New System.Drawing.Point(296, 68)
        Me.cmdRotationback.Name = "cmdRotationback"
        Me.cmdRotationback.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdRotationback.Size = New System.Drawing.Size(42, 21)
        Me.cmdRotationback.TabIndex = 108
        Me.cmdRotationback.Text = "<<"
        Me.cmdRotationback.UseVisualStyleBackColor = False
        '
        'CmdRotationForward
        '
        Me.CmdRotationForward.BackColor = System.Drawing.SystemColors.Control
        Me.CmdRotationForward.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdRotationForward.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdRotationForward.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdRotationForward.Location = New System.Drawing.Point(336, 68)
        Me.CmdRotationForward.Name = "CmdRotationForward"
        Me.CmdRotationForward.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdRotationForward.Size = New System.Drawing.Size(42, 21)
        Me.CmdRotationForward.TabIndex = 107
        Me.CmdRotationForward.Text = ">>"
        Me.CmdRotationForward.UseVisualStyleBackColor = False
        '
        'cmdDeleteRotation
        '
        Me.cmdDeleteRotation.BackColor = System.Drawing.SystemColors.Control
        Me.cmdDeleteRotation.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdDeleteRotation.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdDeleteRotation.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdDeleteRotation.Location = New System.Drawing.Point(296, 8)
        Me.cmdDeleteRotation.Name = "cmdDeleteRotation"
        Me.cmdDeleteRotation.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdDeleteRotation.Size = New System.Drawing.Size(84, 20)
        Me.cmdDeleteRotation.TabIndex = 104
        Me.cmdDeleteRotation.Text = "DeleteRotation"
        Me.cmdDeleteRotation.UseVisualStyleBackColor = False
        '
        'Frame14
        '
        Me.Frame14.BackColor = System.Drawing.SystemColors.Control
        Me.Frame14.Controls.Add(Me.CboTypeAlert2)
        Me.Frame14.Controls.Add(Me.CboAlertGroup2)
        Me.Frame14.Controls.Add(Me.cmdAddAlerts2)
        Me.Frame14.Controls.Add(Me.Label19)
        Me.Frame14.Controls.Add(Me.Label18)
        Me.Frame14.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Frame14.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame14.Location = New System.Drawing.Point(8, 208)
        Me.Frame14.Name = "Frame14"
        Me.Frame14.Padding = New System.Windows.Forms.Padding(0)
        Me.Frame14.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame14.Size = New System.Drawing.Size(369, 57)
        Me.Frame14.TabIndex = 100
        Me.Frame14.TabStop = False
        Me.Frame14.Text = "Alerts"
        '
        'CboTypeAlert2
        '
        Me.CboTypeAlert2.BackColor = System.Drawing.SystemColors.Window
        Me.CboTypeAlert2.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboTypeAlert2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboTypeAlert2.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboTypeAlert2.Location = New System.Drawing.Point(88, 8)
        Me.CboTypeAlert2.Name = "CboTypeAlert2"
        Me.CboTypeAlert2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboTypeAlert2.Size = New System.Drawing.Size(241, 22)
        Me.CboTypeAlert2.TabIndex = 103
        Me.CboTypeAlert2.Text = "CboTypeAlert2"
        '
        'CboAlertGroup2
        '
        Me.CboAlertGroup2.BackColor = System.Drawing.SystemColors.Window
        Me.CboAlertGroup2.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboAlertGroup2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboAlertGroup2.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboAlertGroup2.Location = New System.Drawing.Point(88, 32)
        Me.CboAlertGroup2.Name = "CboAlertGroup2"
        Me.CboAlertGroup2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboAlertGroup2.Size = New System.Drawing.Size(241, 22)
        Me.CboAlertGroup2.Sorted = True
        Me.CboAlertGroup2.TabIndex = 102
        Me.CboAlertGroup2.Text = " "
        '
        'cmdAddAlerts2
        '
        Me.cmdAddAlerts2.BackColor = System.Drawing.SystemColors.Control
        Me.cmdAddAlerts2.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdAddAlerts2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdAddAlerts2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdAddAlerts2.Location = New System.Drawing.Point(331, 32)
        Me.cmdAddAlerts2.Name = "cmdAddAlerts2"
        Me.cmdAddAlerts2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdAddAlerts2.Size = New System.Drawing.Size(35, 20)
        Me.cmdAddAlerts2.TabIndex = 101
        Me.cmdAddAlerts2.Text = "Add"
        Me.cmdAddAlerts2.UseVisualStyleBackColor = False
        '
        'Label19
        '
        Me.Label19.AutoSize = True
        Me.Label19.BackColor = System.Drawing.SystemColors.Control
        Me.Label19.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label19.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label19.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label19.Location = New System.Drawing.Point(22, 36)
        Me.Label19.Name = "Label19"
        Me.Label19.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label19.Size = New System.Drawing.Size(60, 14)
        Me.Label19.TabIndex = 147
        Me.Label19.Text = "AlertGroup"
        '
        'Label18
        '
        Me.Label18.AutoSize = True
        Me.Label18.BackColor = System.Drawing.SystemColors.Control
        Me.Label18.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label18.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label18.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label18.Location = New System.Drawing.Point(28, 16)
        Me.Label18.Name = "Label18"
        Me.Label18.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label18.Size = New System.Drawing.Size(54, 14)
        Me.Label18.TabIndex = 146
        Me.Label18.Text = "AlertType"
        '
        'Frame13
        '
        Me.Frame13.BackColor = System.Drawing.SystemColors.Control
        Me.Frame13.Controls.Add(Me.CboOrganization2)
        Me.Frame13.Controls.Add(Me.CboScheduleGroup2)
        Me.Frame13.Controls.Add(Me.cmdAddSchedules2)
        Me.Frame13.Controls.Add(Me.Label28)
        Me.Frame13.Controls.Add(Me.Label27)
        Me.Frame13.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Frame13.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame13.Location = New System.Drawing.Point(8, 480)
        Me.Frame13.Name = "Frame13"
        Me.Frame13.Padding = New System.Windows.Forms.Padding(0)
        Me.Frame13.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame13.Size = New System.Drawing.Size(369, 57)
        Me.Frame13.TabIndex = 96
        Me.Frame13.TabStop = False
        Me.Frame13.Text = "Schedules"
        '
        'CboOrganization2
        '
        Me.CboOrganization2.BackColor = System.Drawing.SystemColors.Window
        Me.CboOrganization2.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboOrganization2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboOrganization2.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboOrganization2.Location = New System.Drawing.Point(88, 8)
        Me.CboOrganization2.Name = "CboOrganization2"
        Me.CboOrganization2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboOrganization2.Size = New System.Drawing.Size(241, 22)
        Me.CboOrganization2.Sorted = True
        Me.CboOrganization2.TabIndex = 99
        '
        'CboScheduleGroup2
        '
        Me.CboScheduleGroup2.BackColor = System.Drawing.SystemColors.Window
        Me.CboScheduleGroup2.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboScheduleGroup2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboScheduleGroup2.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboScheduleGroup2.Location = New System.Drawing.Point(88, 32)
        Me.CboScheduleGroup2.Name = "CboScheduleGroup2"
        Me.CboScheduleGroup2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboScheduleGroup2.Size = New System.Drawing.Size(241, 22)
        Me.CboScheduleGroup2.Sorted = True
        Me.CboScheduleGroup2.TabIndex = 98
        '
        'cmdAddSchedules2
        '
        Me.cmdAddSchedules2.BackColor = System.Drawing.SystemColors.Control
        Me.cmdAddSchedules2.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdAddSchedules2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdAddSchedules2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdAddSchedules2.Location = New System.Drawing.Point(331, 32)
        Me.cmdAddSchedules2.Name = "cmdAddSchedules2"
        Me.cmdAddSchedules2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdAddSchedules2.Size = New System.Drawing.Size(35, 20)
        Me.cmdAddSchedules2.TabIndex = 97
        Me.cmdAddSchedules2.Text = "Add"
        Me.cmdAddSchedules2.UseVisualStyleBackColor = False
        '
        'Label28
        '
        Me.Label28.AutoSize = True
        Me.Label28.BackColor = System.Drawing.SystemColors.Control
        Me.Label28.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label28.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label28.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label28.Location = New System.Drawing.Point(30, 36)
        Me.Label28.Name = "Label28"
        Me.Label28.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label28.Size = New System.Drawing.Size(52, 14)
        Me.Label28.TabIndex = 156
        Me.Label28.Text = "Schedule"
        '
        'Label27
        '
        Me.Label27.AutoSize = True
        Me.Label27.BackColor = System.Drawing.SystemColors.Control
        Me.Label27.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label27.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label27.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label27.Location = New System.Drawing.Point(14, 16)
        Me.Label27.Name = "Label27"
        Me.Label27.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label27.Size = New System.Drawing.Size(68, 14)
        Me.Label27.TabIndex = 155
        Me.Label27.Text = "Organization"
        '
        'Frame12
        '
        Me.Frame12.BackColor = System.Drawing.SystemColors.Control
        Me.Frame12.Controls.Add(Me.CboReportParent2)
        Me.Frame12.Controls.Add(Me.CboReportType2)
        Me.Frame12.Controls.Add(Me.cmdAddReportGroups2)
        Me.Frame12.Controls.Add(Me.Label26)
        Me.Frame12.Controls.Add(Me.Label25)
        Me.Frame12.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Frame12.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame12.Location = New System.Drawing.Point(8, 424)
        Me.Frame12.Name = "Frame12"
        Me.Frame12.Padding = New System.Windows.Forms.Padding(0)
        Me.Frame12.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame12.Size = New System.Drawing.Size(369, 57)
        Me.Frame12.TabIndex = 92
        Me.Frame12.TabStop = False
        Me.Frame12.Text = "Report Groups"
        '
        'CboReportParent2
        '
        Me.CboReportParent2.BackColor = System.Drawing.SystemColors.Window
        Me.CboReportParent2.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboReportParent2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboReportParent2.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboReportParent2.Location = New System.Drawing.Point(88, 8)
        Me.CboReportParent2.Name = "CboReportParent2"
        Me.CboReportParent2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboReportParent2.Size = New System.Drawing.Size(241, 22)
        Me.CboReportParent2.TabIndex = 95
        '
        'CboReportType2
        '
        Me.CboReportType2.BackColor = System.Drawing.SystemColors.Window
        Me.CboReportType2.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboReportType2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboReportType2.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboReportType2.Location = New System.Drawing.Point(88, 32)
        Me.CboReportType2.Name = "CboReportType2"
        Me.CboReportType2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboReportType2.Size = New System.Drawing.Size(241, 22)
        Me.CboReportType2.Sorted = True
        Me.CboReportType2.TabIndex = 94
        '
        'cmdAddReportGroups2
        '
        Me.cmdAddReportGroups2.BackColor = System.Drawing.SystemColors.Control
        Me.cmdAddReportGroups2.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdAddReportGroups2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdAddReportGroups2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdAddReportGroups2.Location = New System.Drawing.Point(331, 32)
        Me.cmdAddReportGroups2.Name = "cmdAddReportGroups2"
        Me.cmdAddReportGroups2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdAddReportGroups2.Size = New System.Drawing.Size(35, 20)
        Me.cmdAddReportGroups2.TabIndex = 93
        Me.cmdAddReportGroups2.Text = "Add"
        Me.cmdAddReportGroups2.UseVisualStyleBackColor = False
        '
        'Label26
        '
        Me.Label26.AutoSize = True
        Me.Label26.BackColor = System.Drawing.SystemColors.Control
        Me.Label26.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label26.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label26.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label26.Location = New System.Drawing.Point(13, 36)
        Me.Label26.Name = "Label26"
        Me.Label26.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label26.Size = New System.Drawing.Size(69, 14)
        Me.Label26.TabIndex = 154
        Me.Label26.Text = "ReportGroup"
        '
        'Label25
        '
        Me.Label25.AutoSize = True
        Me.Label25.BackColor = System.Drawing.SystemColors.Control
        Me.Label25.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label25.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label25.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label25.Location = New System.Drawing.Point(11, 16)
        Me.Label25.Name = "Label25"
        Me.Label25.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label25.Size = New System.Drawing.Size(71, 14)
        Me.Label25.TabIndex = 153
        Me.Label25.Text = "GroupOwner"
        '
        'Frame11
        '
        Me.Frame11.BackColor = System.Drawing.SystemColors.Control
        Me.Frame11.Controls.Add(Me.CboSourceCodeType2)
        Me.Frame11.Controls.Add(Me.CboSourceCodeGroup2)
        Me.Frame11.Controls.Add(Me.cmdAddSourceCodes2)
        Me.Frame11.Controls.Add(Me.Label24)
        Me.Frame11.Controls.Add(Me.Label23)
        Me.Frame11.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Frame11.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame11.Location = New System.Drawing.Point(8, 368)
        Me.Frame11.Name = "Frame11"
        Me.Frame11.Padding = New System.Windows.Forms.Padding(0)
        Me.Frame11.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame11.Size = New System.Drawing.Size(369, 57)
        Me.Frame11.TabIndex = 88
        Me.Frame11.TabStop = False
        Me.Frame11.Text = "Source Codes"
        '
        'CboSourceCodeType2
        '
        Me.CboSourceCodeType2.BackColor = System.Drawing.SystemColors.Window
        Me.CboSourceCodeType2.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboSourceCodeType2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboSourceCodeType2.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboSourceCodeType2.Location = New System.Drawing.Point(88, 8)
        Me.CboSourceCodeType2.Name = "CboSourceCodeType2"
        Me.CboSourceCodeType2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboSourceCodeType2.Size = New System.Drawing.Size(241, 22)
        Me.CboSourceCodeType2.TabIndex = 91
        '
        'CboSourceCodeGroup2
        '
        Me.CboSourceCodeGroup2.BackColor = System.Drawing.SystemColors.Window
        Me.CboSourceCodeGroup2.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboSourceCodeGroup2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboSourceCodeGroup2.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboSourceCodeGroup2.Location = New System.Drawing.Point(88, 32)
        Me.CboSourceCodeGroup2.Name = "CboSourceCodeGroup2"
        Me.CboSourceCodeGroup2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboSourceCodeGroup2.Size = New System.Drawing.Size(241, 22)
        Me.CboSourceCodeGroup2.Sorted = True
        Me.CboSourceCodeGroup2.TabIndex = 90
        '
        'cmdAddSourceCodes2
        '
        Me.cmdAddSourceCodes2.BackColor = System.Drawing.SystemColors.Control
        Me.cmdAddSourceCodes2.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdAddSourceCodes2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdAddSourceCodes2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdAddSourceCodes2.Location = New System.Drawing.Point(331, 32)
        Me.cmdAddSourceCodes2.Name = "cmdAddSourceCodes2"
        Me.cmdAddSourceCodes2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdAddSourceCodes2.Size = New System.Drawing.Size(35, 20)
        Me.cmdAddSourceCodes2.TabIndex = 89
        Me.cmdAddSourceCodes2.Text = "Add"
        Me.cmdAddSourceCodes2.UseVisualStyleBackColor = False
        '
        'Label24
        '
        Me.Label24.AutoSize = True
        Me.Label24.BackColor = System.Drawing.SystemColors.Control
        Me.Label24.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label24.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label24.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label24.Location = New System.Drawing.Point(15, 36)
        Me.Label24.Name = "Label24"
        Me.Label24.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label24.Size = New System.Drawing.Size(67, 14)
        Me.Label24.TabIndex = 152
        Me.Label24.Text = "SourceCode"
        '
        'Label23
        '
        Me.Label23.AutoSize = True
        Me.Label23.BackColor = System.Drawing.SystemColors.Control
        Me.Label23.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label23.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label23.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label23.Location = New System.Drawing.Point(16, 16)
        Me.Label23.Name = "Label23"
        Me.Label23.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label23.Size = New System.Drawing.Size(66, 14)
        Me.Label23.TabIndex = 151
        Me.Label23.Text = "SourceType"
        '
        'Frame10
        '
        Me.Frame10.BackColor = System.Drawing.SystemColors.Control
        Me.Frame10.Controls.Add(Me.CboServiceLevel2)
        Me.Frame10.Controls.Add(Me.cmdAddServiceLevels2)
        Me.Frame10.Controls.Add(Me.Label22)
        Me.Frame10.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Frame10.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame10.Location = New System.Drawing.Point(8, 320)
        Me.Frame10.Name = "Frame10"
        Me.Frame10.Padding = New System.Windows.Forms.Padding(0)
        Me.Frame10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame10.Size = New System.Drawing.Size(369, 49)
        Me.Frame10.TabIndex = 85
        Me.Frame10.TabStop = False
        Me.Frame10.Text = "Service Levels"
        '
        'CboServiceLevel2
        '
        Me.CboServiceLevel2.BackColor = System.Drawing.SystemColors.Window
        Me.CboServiceLevel2.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboServiceLevel2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboServiceLevel2.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboServiceLevel2.Location = New System.Drawing.Point(88, 16)
        Me.CboServiceLevel2.Name = "CboServiceLevel2"
        Me.CboServiceLevel2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboServiceLevel2.Size = New System.Drawing.Size(241, 22)
        Me.CboServiceLevel2.Sorted = True
        Me.CboServiceLevel2.TabIndex = 87
        '
        'cmdAddServiceLevels2
        '
        Me.cmdAddServiceLevels2.BackColor = System.Drawing.SystemColors.Control
        Me.cmdAddServiceLevels2.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdAddServiceLevels2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdAddServiceLevels2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdAddServiceLevels2.Location = New System.Drawing.Point(331, 16)
        Me.cmdAddServiceLevels2.Name = "cmdAddServiceLevels2"
        Me.cmdAddServiceLevels2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdAddServiceLevels2.Size = New System.Drawing.Size(35, 20)
        Me.cmdAddServiceLevels2.TabIndex = 86
        Me.cmdAddServiceLevels2.Text = "Add"
        Me.cmdAddServiceLevels2.UseVisualStyleBackColor = False
        '
        'Label22
        '
        Me.Label22.AutoSize = True
        Me.Label22.BackColor = System.Drawing.SystemColors.Control
        Me.Label22.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label22.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label22.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label22.Location = New System.Drawing.Point(9, 20)
        Me.Label22.Name = "Label22"
        Me.Label22.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label22.Size = New System.Drawing.Size(73, 14)
        Me.Label22.TabIndex = 150
        Me.Label22.Text = "Service Level"
        '
        'Frame9
        '
        Me.Frame9.BackColor = System.Drawing.SystemColors.Control
        Me.Frame9.Controls.Add(Me.CboCriteria2)
        Me.Frame9.Controls.Add(Me.CboCriteriaGroup2)
        Me.Frame9.Controls.Add(Me.cmdAddCriteria2)
        Me.Frame9.Controls.Add(Me.Label21)
        Me.Frame9.Controls.Add(Me.Label20)
        Me.Frame9.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Frame9.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame9.Location = New System.Drawing.Point(8, 264)
        Me.Frame9.Name = "Frame9"
        Me.Frame9.Padding = New System.Windows.Forms.Padding(0)
        Me.Frame9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame9.Size = New System.Drawing.Size(369, 57)
        Me.Frame9.TabIndex = 81
        Me.Frame9.TabStop = False
        Me.Frame9.Text = "Criteria"
        '
        'CboCriteria2
        '
        Me.CboCriteria2.BackColor = System.Drawing.SystemColors.Window
        Me.CboCriteria2.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboCriteria2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboCriteria2.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboCriteria2.Location = New System.Drawing.Point(88, 8)
        Me.CboCriteria2.Name = "CboCriteria2"
        Me.CboCriteria2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboCriteria2.Size = New System.Drawing.Size(241, 22)
        Me.CboCriteria2.TabIndex = 84
        '
        'CboCriteriaGroup2
        '
        Me.CboCriteriaGroup2.BackColor = System.Drawing.SystemColors.Window
        Me.CboCriteriaGroup2.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboCriteriaGroup2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboCriteriaGroup2.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboCriteriaGroup2.Location = New System.Drawing.Point(88, 32)
        Me.CboCriteriaGroup2.Name = "CboCriteriaGroup2"
        Me.CboCriteriaGroup2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboCriteriaGroup2.Size = New System.Drawing.Size(241, 22)
        Me.CboCriteriaGroup2.Sorted = True
        Me.CboCriteriaGroup2.TabIndex = 83
        '
        'cmdAddCriteria2
        '
        Me.cmdAddCriteria2.BackColor = System.Drawing.SystemColors.Control
        Me.cmdAddCriteria2.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdAddCriteria2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdAddCriteria2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdAddCriteria2.Location = New System.Drawing.Point(331, 32)
        Me.cmdAddCriteria2.Name = "cmdAddCriteria2"
        Me.cmdAddCriteria2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdAddCriteria2.Size = New System.Drawing.Size(35, 20)
        Me.cmdAddCriteria2.TabIndex = 82
        Me.cmdAddCriteria2.Text = "Add"
        Me.cmdAddCriteria2.UseVisualStyleBackColor = False
        '
        'Label21
        '
        Me.Label21.AutoSize = True
        Me.Label21.BackColor = System.Drawing.SystemColors.Control
        Me.Label21.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label21.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label21.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label21.Location = New System.Drawing.Point(8, 36)
        Me.Label21.Name = "Label21"
        Me.Label21.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label21.Size = New System.Drawing.Size(74, 14)
        Me.Label21.TabIndex = 149
        Me.Label21.Text = "Criteria Group"
        '
        'Label20
        '
        Me.Label20.AutoSize = True
        Me.Label20.BackColor = System.Drawing.SystemColors.Control
        Me.Label20.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label20.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label20.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label20.Location = New System.Drawing.Point(2, 16)
        Me.Label20.Name = "Label20"
        Me.Label20.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label20.Size = New System.Drawing.Size(80, 14)
        Me.Label20.TabIndex = 148
        Me.Label20.Text = "DonorCategory"
        '
        'MSFlexGrid2
        '
        Me.MSFlexGrid2.Location = New System.Drawing.Point(8, 88)
        Me.MSFlexGrid2.Name = "MSFlexGrid2"
        Me.MSFlexGrid2.OcxState = CType(resources.GetObject("MSFlexGrid2.OcxState"), System.Windows.Forms.AxHost.State)
        Me.MSFlexGrid2.Size = New System.Drawing.Size(369, 105)
        Me.MSFlexGrid2.TabIndex = 57
        '
        'lblRotationName2
        '
        Me.lblRotationName2.BackColor = System.Drawing.SystemColors.Control
        Me.lblRotationName2.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblRotationName2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblRotationName2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblRotationName2.Location = New System.Drawing.Point(80, 64)
        Me.lblRotationName2.Name = "lblRotationName2"
        Me.lblRotationName2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblRotationName2.Size = New System.Drawing.Size(81, 17)
        Me.lblRotationName2.TabIndex = 124
        '
        'Label6
        '
        Me.Label6.BackColor = System.Drawing.SystemColors.Control
        Me.Label6.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label6.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label6.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label6.Location = New System.Drawing.Point(192, 192)
        Me.Label6.Name = "Label6"
        Me.Label6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label6.Size = New System.Drawing.Size(121, 17)
        Me.Label6.TabIndex = 117
        Me.Label6.Text = "Delete Highlighted Row"
        '
        'lblRotationNext
        '
        Me.lblRotationNext.BackColor = System.Drawing.SystemColors.Control
        Me.lblRotationNext.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblRotationNext.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblRotationNext.ForeColor = System.Drawing.Color.Blue
        Me.lblRotationNext.Location = New System.Drawing.Point(56, 64)
        Me.lblRotationNext.Name = "lblRotationNext"
        Me.lblRotationNext.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblRotationNext.Size = New System.Drawing.Size(25, 17)
        Me.lblRotationNext.TabIndex = 111
        '
        'lblRotation2
        '
        Me.lblRotation2.BackColor = System.Drawing.SystemColors.Control
        Me.lblRotation2.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblRotation2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblRotation2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblRotation2.Location = New System.Drawing.Point(8, 76)
        Me.lblRotation2.Name = "lblRotation2"
        Me.lblRotation2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblRotation2.Size = New System.Drawing.Size(49, 25)
        Me.lblRotation2.TabIndex = 110
        Me.lblRotation2.Text = "Rotation "
        '
        'Label3
        '
        Me.Label3.BackColor = System.Drawing.SystemColors.Control
        Me.Label3.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label3.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label3.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label3.Location = New System.Drawing.Point(8, 32)
        Me.Label3.Name = "Label3"
        Me.Label3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label3.Size = New System.Drawing.Size(361, 33)
        Me.Label3.TabIndex = 54
        Me.Label3.Text = "Select a group and type for each maintain Module. If no group is selected then th" & _
            "at maintain module will not be rotated. Highlight a row to delete it"
        '
        'Frame1
        '
        Me.Frame1.BackColor = System.Drawing.SystemColors.Control
        Me.Frame1.Controls.Add(Me.cmdRename)
        Me.Frame1.Controls.Add(Me.CmdDeleteRow)
        Me.Frame1.Controls.Add(Me.Frame8)
        Me.Frame1.Controls.Add(Me.Frame7)
        Me.Frame1.Controls.Add(Me.Frame6)
        Me.Frame1.Controls.Add(Me.Frame5)
        Me.Frame1.Controls.Add(Me.Frame4)
        Me.Frame1.Controls.Add(Me.Frame3)
        Me.Frame1.Controls.Add(Me.MSFlexGrid1)
        Me.Frame1.Controls.Add(Me.lblRotationName)
        Me.Frame1.Controls.Add(Me.Label5)
        Me.Frame1.Controls.Add(Me.Label2)
        Me.Frame1.Controls.Add(Me.lblone)
        Me.Frame1.Controls.Add(Me.lblRotation)
        Me.Frame1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Frame1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame1.Location = New System.Drawing.Point(6, 23)
        Me.Frame1.Name = "Frame1"
        Me.Frame1.Padding = New System.Windows.Forms.Padding(0)
        Me.Frame1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame1.Size = New System.Drawing.Size(385, 541)
        Me.Frame1.TabIndex = 52
        Me.Frame1.TabStop = False
        Me.Frame1.Text = "Current Rotation"
        '
        'cmdRename
        '
        Me.cmdRename.BackColor = System.Drawing.SystemColors.Control
        Me.cmdRename.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdRename.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdRename.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdRename.Location = New System.Drawing.Point(264, 68)
        Me.cmdRename.Name = "cmdRename"
        Me.cmdRename.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdRename.Size = New System.Drawing.Size(54, 21)
        Me.cmdRename.TabIndex = 128
        Me.cmdRename.Text = "Rename"
        Me.cmdRename.UseVisualStyleBackColor = False
        '
        'CmdDeleteRow
        '
        Me.CmdDeleteRow.BackColor = System.Drawing.SystemColors.Control
        Me.CmdDeleteRow.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdDeleteRow.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdDeleteRow.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdDeleteRow.Location = New System.Drawing.Point(312, 192)
        Me.CmdDeleteRow.Name = "CmdDeleteRow"
        Me.CmdDeleteRow.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdDeleteRow.Size = New System.Drawing.Size(65, 20)
        Me.CmdDeleteRow.TabIndex = 114
        Me.CmdDeleteRow.Text = "Delete"
        Me.CmdDeleteRow.UseVisualStyleBackColor = False
        '
        'Frame8
        '
        Me.Frame8.BackColor = System.Drawing.SystemColors.Control
        Me.Frame8.Controls.Add(Me.cmdAddAlerts)
        Me.Frame8.Controls.Add(Me.cboAlertGroup)
        Me.Frame8.Controls.Add(Me.CboTypeAlert)
        Me.Frame8.Controls.Add(Me.Label8)
        Me.Frame8.Controls.Add(Me.Label4)
        Me.Frame8.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Frame8.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame8.Location = New System.Drawing.Point(8, 208)
        Me.Frame8.Name = "Frame8"
        Me.Frame8.Padding = New System.Windows.Forms.Padding(0)
        Me.Frame8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame8.Size = New System.Drawing.Size(369, 57)
        Me.Frame8.TabIndex = 63
        Me.Frame8.TabStop = False
        Me.Frame8.Text = "Alerts"
        '
        'cmdAddAlerts
        '
        Me.cmdAddAlerts.BackColor = System.Drawing.SystemColors.Control
        Me.cmdAddAlerts.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdAddAlerts.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdAddAlerts.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdAddAlerts.Location = New System.Drawing.Point(326, 32)
        Me.cmdAddAlerts.Name = "cmdAddAlerts"
        Me.cmdAddAlerts.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdAddAlerts.Size = New System.Drawing.Size(35, 20)
        Me.cmdAddAlerts.TabIndex = 66
        Me.cmdAddAlerts.Text = "Add"
        Me.cmdAddAlerts.UseVisualStyleBackColor = False
        '
        'cboAlertGroup
        '
        Me.cboAlertGroup.BackColor = System.Drawing.SystemColors.Window
        Me.cboAlertGroup.Cursor = System.Windows.Forms.Cursors.Default
        Me.cboAlertGroup.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cboAlertGroup.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cboAlertGroup.Location = New System.Drawing.Point(88, 32)
        Me.cboAlertGroup.Name = "cboAlertGroup"
        Me.cboAlertGroup.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cboAlertGroup.Size = New System.Drawing.Size(233, 22)
        Me.cboAlertGroup.Sorted = True
        Me.cboAlertGroup.TabIndex = 65
        '
        'CboTypeAlert
        '
        Me.CboTypeAlert.BackColor = System.Drawing.SystemColors.Window
        Me.CboTypeAlert.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboTypeAlert.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboTypeAlert.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboTypeAlert.Location = New System.Drawing.Point(88, 8)
        Me.CboTypeAlert.Name = "CboTypeAlert"
        Me.CboTypeAlert.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboTypeAlert.Size = New System.Drawing.Size(233, 22)
        Me.CboTypeAlert.TabIndex = 64
        Me.CboTypeAlert.Text = "CboTypeAlert"
        '
        'Label8
        '
        Me.Label8.AutoSize = True
        Me.Label8.BackColor = System.Drawing.SystemColors.Control
        Me.Label8.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label8.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label8.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label8.Location = New System.Drawing.Point(22, 36)
        Me.Label8.Name = "Label8"
        Me.Label8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label8.Size = New System.Drawing.Size(60, 14)
        Me.Label8.TabIndex = 136
        Me.Label8.Text = "AlertGroup"
        '
        'Label4
        '
        Me.Label4.AutoSize = True
        Me.Label4.BackColor = System.Drawing.SystemColors.Control
        Me.Label4.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label4.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label4.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label4.Location = New System.Drawing.Point(28, 16)
        Me.Label4.Name = "Label4"
        Me.Label4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label4.Size = New System.Drawing.Size(54, 14)
        Me.Label4.TabIndex = 135
        Me.Label4.Text = "AlertType"
        '
        'Frame7
        '
        Me.Frame7.BackColor = System.Drawing.SystemColors.Control
        Me.Frame7.Controls.Add(Me.cmdAddSchedules)
        Me.Frame7.Controls.Add(Me.CboScheduleGroup)
        Me.Frame7.Controls.Add(Me.CboOrganization)
        Me.Frame7.Controls.Add(Me.Label17)
        Me.Frame7.Controls.Add(Me.Label16)
        Me.Frame7.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Frame7.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame7.Location = New System.Drawing.Point(8, 480)
        Me.Frame7.Name = "Frame7"
        Me.Frame7.Padding = New System.Windows.Forms.Padding(0)
        Me.Frame7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame7.Size = New System.Drawing.Size(369, 57)
        Me.Frame7.TabIndex = 62
        Me.Frame7.TabStop = False
        Me.Frame7.Text = "Schedules"
        '
        'cmdAddSchedules
        '
        Me.cmdAddSchedules.BackColor = System.Drawing.SystemColors.Control
        Me.cmdAddSchedules.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdAddSchedules.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdAddSchedules.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdAddSchedules.Location = New System.Drawing.Point(326, 32)
        Me.cmdAddSchedules.Name = "cmdAddSchedules"
        Me.cmdAddSchedules.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdAddSchedules.Size = New System.Drawing.Size(35, 20)
        Me.cmdAddSchedules.TabIndex = 80
        Me.cmdAddSchedules.Text = "Add"
        Me.cmdAddSchedules.UseVisualStyleBackColor = False
        '
        'CboScheduleGroup
        '
        Me.CboScheduleGroup.BackColor = System.Drawing.SystemColors.Window
        Me.CboScheduleGroup.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboScheduleGroup.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboScheduleGroup.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboScheduleGroup.Location = New System.Drawing.Point(88, 32)
        Me.CboScheduleGroup.Name = "CboScheduleGroup"
        Me.CboScheduleGroup.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboScheduleGroup.Size = New System.Drawing.Size(233, 22)
        Me.CboScheduleGroup.Sorted = True
        Me.CboScheduleGroup.TabIndex = 79
        '
        'CboOrganization
        '
        Me.CboOrganization.BackColor = System.Drawing.SystemColors.Window
        Me.CboOrganization.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboOrganization.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboOrganization.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboOrganization.Location = New System.Drawing.Point(88, 8)
        Me.CboOrganization.Name = "CboOrganization"
        Me.CboOrganization.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboOrganization.Size = New System.Drawing.Size(233, 22)
        Me.CboOrganization.Sorted = True
        Me.CboOrganization.TabIndex = 78
        '
        'Label17
        '
        Me.Label17.AutoSize = True
        Me.Label17.BackColor = System.Drawing.SystemColors.Control
        Me.Label17.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label17.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label17.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label17.Location = New System.Drawing.Point(30, 36)
        Me.Label17.Name = "Label17"
        Me.Label17.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label17.Size = New System.Drawing.Size(52, 14)
        Me.Label17.TabIndex = 145
        Me.Label17.Text = "Schedule"
        '
        'Label16
        '
        Me.Label16.AutoSize = True
        Me.Label16.BackColor = System.Drawing.SystemColors.Control
        Me.Label16.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label16.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label16.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label16.Location = New System.Drawing.Point(14, 16)
        Me.Label16.Name = "Label16"
        Me.Label16.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label16.Size = New System.Drawing.Size(68, 14)
        Me.Label16.TabIndex = 144
        Me.Label16.Text = "Organization"
        '
        'Frame6
        '
        Me.Frame6.BackColor = System.Drawing.SystemColors.Control
        Me.Frame6.Controls.Add(Me.cmdAddReportGroups)
        Me.Frame6.Controls.Add(Me.CboReportType)
        Me.Frame6.Controls.Add(Me.CboReportParent)
        Me.Frame6.Controls.Add(Me.Label15)
        Me.Frame6.Controls.Add(Me.Label14)
        Me.Frame6.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Frame6.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame6.Location = New System.Drawing.Point(8, 424)
        Me.Frame6.Name = "Frame6"
        Me.Frame6.Padding = New System.Windows.Forms.Padding(0)
        Me.Frame6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame6.Size = New System.Drawing.Size(369, 57)
        Me.Frame6.TabIndex = 61
        Me.Frame6.TabStop = False
        Me.Frame6.Text = "Report Groups"
        '
        'cmdAddReportGroups
        '
        Me.cmdAddReportGroups.BackColor = System.Drawing.SystemColors.Control
        Me.cmdAddReportGroups.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdAddReportGroups.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdAddReportGroups.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdAddReportGroups.Location = New System.Drawing.Point(326, 32)
        Me.cmdAddReportGroups.Name = "cmdAddReportGroups"
        Me.cmdAddReportGroups.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdAddReportGroups.Size = New System.Drawing.Size(35, 20)
        Me.cmdAddReportGroups.TabIndex = 77
        Me.cmdAddReportGroups.Text = "Add"
        Me.cmdAddReportGroups.UseVisualStyleBackColor = False
        '
        'CboReportType
        '
        Me.CboReportType.BackColor = System.Drawing.SystemColors.Window
        Me.CboReportType.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboReportType.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboReportType.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboReportType.Location = New System.Drawing.Point(88, 32)
        Me.CboReportType.Name = "CboReportType"
        Me.CboReportType.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboReportType.Size = New System.Drawing.Size(233, 22)
        Me.CboReportType.Sorted = True
        Me.CboReportType.TabIndex = 76
        '
        'CboReportParent
        '
        Me.CboReportParent.BackColor = System.Drawing.SystemColors.Window
        Me.CboReportParent.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboReportParent.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboReportParent.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboReportParent.Location = New System.Drawing.Point(88, 8)
        Me.CboReportParent.Name = "CboReportParent"
        Me.CboReportParent.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboReportParent.Size = New System.Drawing.Size(233, 22)
        Me.CboReportParent.TabIndex = 75
        '
        'Label15
        '
        Me.Label15.AutoSize = True
        Me.Label15.BackColor = System.Drawing.SystemColors.Control
        Me.Label15.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label15.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label15.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label15.Location = New System.Drawing.Point(13, 36)
        Me.Label15.Name = "Label15"
        Me.Label15.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label15.Size = New System.Drawing.Size(69, 14)
        Me.Label15.TabIndex = 143
        Me.Label15.Text = "ReportGroup"
        '
        'Label14
        '
        Me.Label14.AutoSize = True
        Me.Label14.BackColor = System.Drawing.SystemColors.Control
        Me.Label14.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label14.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label14.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label14.Location = New System.Drawing.Point(11, 16)
        Me.Label14.Name = "Label14"
        Me.Label14.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label14.Size = New System.Drawing.Size(71, 14)
        Me.Label14.TabIndex = 142
        Me.Label14.Text = "GroupOwner"
        '
        'Frame5
        '
        Me.Frame5.BackColor = System.Drawing.SystemColors.Control
        Me.Frame5.Controls.Add(Me.cmdAddSourceCodes)
        Me.Frame5.Controls.Add(Me.CboSourceCodeGroup)
        Me.Frame5.Controls.Add(Me.CboSourceCodeType)
        Me.Frame5.Controls.Add(Me.Label13)
        Me.Frame5.Controls.Add(Me.Label12)
        Me.Frame5.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Frame5.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame5.Location = New System.Drawing.Point(8, 368)
        Me.Frame5.Name = "Frame5"
        Me.Frame5.Padding = New System.Windows.Forms.Padding(0)
        Me.Frame5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame5.Size = New System.Drawing.Size(369, 57)
        Me.Frame5.TabIndex = 60
        Me.Frame5.TabStop = False
        Me.Frame5.Text = "Source Codes"
        '
        'cmdAddSourceCodes
        '
        Me.cmdAddSourceCodes.BackColor = System.Drawing.SystemColors.Control
        Me.cmdAddSourceCodes.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdAddSourceCodes.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdAddSourceCodes.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdAddSourceCodes.Location = New System.Drawing.Point(326, 32)
        Me.cmdAddSourceCodes.Name = "cmdAddSourceCodes"
        Me.cmdAddSourceCodes.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdAddSourceCodes.Size = New System.Drawing.Size(35, 20)
        Me.cmdAddSourceCodes.TabIndex = 74
        Me.cmdAddSourceCodes.Text = "Add"
        Me.cmdAddSourceCodes.UseVisualStyleBackColor = False
        '
        'CboSourceCodeGroup
        '
        Me.CboSourceCodeGroup.BackColor = System.Drawing.SystemColors.Window
        Me.CboSourceCodeGroup.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboSourceCodeGroup.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboSourceCodeGroup.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboSourceCodeGroup.Location = New System.Drawing.Point(88, 32)
        Me.CboSourceCodeGroup.Name = "CboSourceCodeGroup"
        Me.CboSourceCodeGroup.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboSourceCodeGroup.Size = New System.Drawing.Size(233, 22)
        Me.CboSourceCodeGroup.Sorted = True
        Me.CboSourceCodeGroup.TabIndex = 73
        '
        'CboSourceCodeType
        '
        Me.CboSourceCodeType.BackColor = System.Drawing.SystemColors.Window
        Me.CboSourceCodeType.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboSourceCodeType.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboSourceCodeType.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboSourceCodeType.Location = New System.Drawing.Point(88, 8)
        Me.CboSourceCodeType.Name = "CboSourceCodeType"
        Me.CboSourceCodeType.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboSourceCodeType.Size = New System.Drawing.Size(233, 22)
        Me.CboSourceCodeType.TabIndex = 72
        '
        'Label13
        '
        Me.Label13.AutoSize = True
        Me.Label13.BackColor = System.Drawing.SystemColors.Control
        Me.Label13.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label13.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label13.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label13.Location = New System.Drawing.Point(15, 36)
        Me.Label13.Name = "Label13"
        Me.Label13.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label13.Size = New System.Drawing.Size(67, 14)
        Me.Label13.TabIndex = 141
        Me.Label13.Text = "SourceCode"
        '
        'Label12
        '
        Me.Label12.AutoSize = True
        Me.Label12.BackColor = System.Drawing.SystemColors.Control
        Me.Label12.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label12.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label12.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label12.Location = New System.Drawing.Point(16, 16)
        Me.Label12.Name = "Label12"
        Me.Label12.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label12.Size = New System.Drawing.Size(66, 14)
        Me.Label12.TabIndex = 140
        Me.Label12.Text = "SourceType"
        '
        'Frame4
        '
        Me.Frame4.BackColor = System.Drawing.SystemColors.Control
        Me.Frame4.Controls.Add(Me.cmdAddServiceLevels)
        Me.Frame4.Controls.Add(Me.CboServiceLevel)
        Me.Frame4.Controls.Add(Me.Label11)
        Me.Frame4.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Frame4.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame4.Location = New System.Drawing.Point(8, 320)
        Me.Frame4.Name = "Frame4"
        Me.Frame4.Padding = New System.Windows.Forms.Padding(0)
        Me.Frame4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame4.Size = New System.Drawing.Size(369, 49)
        Me.Frame4.TabIndex = 59
        Me.Frame4.TabStop = False
        Me.Frame4.Text = "Service Levels"
        '
        'cmdAddServiceLevels
        '
        Me.cmdAddServiceLevels.BackColor = System.Drawing.SystemColors.Control
        Me.cmdAddServiceLevels.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdAddServiceLevels.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdAddServiceLevels.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdAddServiceLevels.Location = New System.Drawing.Point(326, 16)
        Me.cmdAddServiceLevels.Name = "cmdAddServiceLevels"
        Me.cmdAddServiceLevels.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdAddServiceLevels.Size = New System.Drawing.Size(35, 20)
        Me.cmdAddServiceLevels.TabIndex = 71
        Me.cmdAddServiceLevels.Text = "Add"
        Me.cmdAddServiceLevels.UseVisualStyleBackColor = False
        '
        'CboServiceLevel
        '
        Me.CboServiceLevel.BackColor = System.Drawing.SystemColors.Window
        Me.CboServiceLevel.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboServiceLevel.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboServiceLevel.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboServiceLevel.Location = New System.Drawing.Point(88, 16)
        Me.CboServiceLevel.Name = "CboServiceLevel"
        Me.CboServiceLevel.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboServiceLevel.Size = New System.Drawing.Size(233, 22)
        Me.CboServiceLevel.Sorted = True
        Me.CboServiceLevel.TabIndex = 70
        '
        'Label11
        '
        Me.Label11.AutoSize = True
        Me.Label11.BackColor = System.Drawing.SystemColors.Control
        Me.Label11.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label11.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label11.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label11.Location = New System.Drawing.Point(9, 20)
        Me.Label11.Name = "Label11"
        Me.Label11.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label11.Size = New System.Drawing.Size(73, 14)
        Me.Label11.TabIndex = 139
        Me.Label11.Text = "Service Level"
        '
        'Frame3
        '
        Me.Frame3.BackColor = System.Drawing.SystemColors.Control
        Me.Frame3.Controls.Add(Me.cmdAddCriteria)
        Me.Frame3.Controls.Add(Me.CboCriteriaGroup)
        Me.Frame3.Controls.Add(Me.CboCriteria)
        Me.Frame3.Controls.Add(Me.Label9)
        Me.Frame3.Controls.Add(Me.Label10)
        Me.Frame3.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Frame3.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame3.Location = New System.Drawing.Point(8, 264)
        Me.Frame3.Name = "Frame3"
        Me.Frame3.Padding = New System.Windows.Forms.Padding(0)
        Me.Frame3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame3.Size = New System.Drawing.Size(369, 57)
        Me.Frame3.TabIndex = 58
        Me.Frame3.TabStop = False
        Me.Frame3.Text = "Criteria"
        '
        'cmdAddCriteria
        '
        Me.cmdAddCriteria.BackColor = System.Drawing.SystemColors.Control
        Me.cmdAddCriteria.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdAddCriteria.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdAddCriteria.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdAddCriteria.Location = New System.Drawing.Point(326, 32)
        Me.cmdAddCriteria.Name = "cmdAddCriteria"
        Me.cmdAddCriteria.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdAddCriteria.Size = New System.Drawing.Size(35, 20)
        Me.cmdAddCriteria.TabIndex = 69
        Me.cmdAddCriteria.Text = "Add"
        Me.cmdAddCriteria.UseVisualStyleBackColor = False
        '
        'CboCriteriaGroup
        '
        Me.CboCriteriaGroup.BackColor = System.Drawing.SystemColors.Window
        Me.CboCriteriaGroup.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboCriteriaGroup.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboCriteriaGroup.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboCriteriaGroup.Location = New System.Drawing.Point(88, 32)
        Me.CboCriteriaGroup.Name = "CboCriteriaGroup"
        Me.CboCriteriaGroup.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboCriteriaGroup.Size = New System.Drawing.Size(233, 22)
        Me.CboCriteriaGroup.Sorted = True
        Me.CboCriteriaGroup.TabIndex = 68
        '
        'CboCriteria
        '
        Me.CboCriteria.BackColor = System.Drawing.SystemColors.Window
        Me.CboCriteria.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboCriteria.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboCriteria.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboCriteria.Location = New System.Drawing.Point(88, 8)
        Me.CboCriteria.Name = "CboCriteria"
        Me.CboCriteria.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboCriteria.Size = New System.Drawing.Size(233, 22)
        Me.CboCriteria.TabIndex = 67
        Me.CboCriteria.Text = " "
        '
        'Label9
        '
        Me.Label9.AutoSize = True
        Me.Label9.BackColor = System.Drawing.SystemColors.Control
        Me.Label9.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label9.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label9.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label9.Location = New System.Drawing.Point(2, 16)
        Me.Label9.Name = "Label9"
        Me.Label9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label9.Size = New System.Drawing.Size(80, 14)
        Me.Label9.TabIndex = 137
        Me.Label9.Text = "DonorCategory"
        '
        'Label10
        '
        Me.Label10.AutoSize = True
        Me.Label10.BackColor = System.Drawing.SystemColors.Control
        Me.Label10.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label10.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label10.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label10.Location = New System.Drawing.Point(8, 36)
        Me.Label10.Name = "Label10"
        Me.Label10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label10.Size = New System.Drawing.Size(74, 14)
        Me.Label10.TabIndex = 138
        Me.Label10.Text = "Criteria Group"
        '
        'MSFlexGrid1
        '
        Me.MSFlexGrid1.Location = New System.Drawing.Point(16, 88)
        Me.MSFlexGrid1.Name = "MSFlexGrid1"
        Me.MSFlexGrid1.OcxState = CType(resources.GetObject("MSFlexGrid1.OcxState"), System.Windows.Forms.AxHost.State)
        Me.MSFlexGrid1.Size = New System.Drawing.Size(361, 105)
        Me.MSFlexGrid1.TabIndex = 56
        '
        'lblRotationName
        '
        Me.lblRotationName.BackColor = System.Drawing.SystemColors.Control
        Me.lblRotationName.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblRotationName.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblRotationName.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblRotationName.Location = New System.Drawing.Point(104, 64)
        Me.lblRotationName.Name = "lblRotationName"
        Me.lblRotationName.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblRotationName.Size = New System.Drawing.Size(137, 17)
        Me.lblRotationName.TabIndex = 123
        '
        'Label5
        '
        Me.Label5.BackColor = System.Drawing.SystemColors.Control
        Me.Label5.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label5.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label5.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label5.Location = New System.Drawing.Point(192, 192)
        Me.Label5.Name = "Label5"
        Me.Label5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label5.Size = New System.Drawing.Size(121, 17)
        Me.Label5.TabIndex = 115
        Me.Label5.Text = "Delete Highlighted Row"
        '
        'Label2
        '
        Me.Label2.BackColor = System.Drawing.SystemColors.Control
        Me.Label2.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label2.Location = New System.Drawing.Point(8, 32)
        Me.Label2.Name = "Label2"
        Me.Label2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label2.Size = New System.Drawing.Size(369, 33)
        Me.Label2.TabIndex = 112
        Me.Label2.Text = "Select a group and type for each maintain Module. If no group is selected then th" & _
            "at maintain module will not be rotated. Highlight a row to delete it"
        '
        'lblone
        '
        Me.lblone.BackColor = System.Drawing.SystemColors.Control
        Me.lblone.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblone.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblone.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblone.Location = New System.Drawing.Point(16, 76)
        Me.lblone.Name = "lblone"
        Me.lblone.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblone.Size = New System.Drawing.Size(57, 17)
        Me.lblone.TabIndex = 106
        Me.lblone.Text = "Rotation"
        '
        'lblRotation
        '
        Me.lblRotation.BackColor = System.Drawing.SystemColors.Control
        Me.lblRotation.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblRotation.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblRotation.ForeColor = System.Drawing.Color.Blue
        Me.lblRotation.Location = New System.Drawing.Point(72, 64)
        Me.lblRotation.Name = "lblRotation"
        Me.lblRotation.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblRotation.Size = New System.Drawing.Size(25, 17)
        Me.lblRotation.TabIndex = 105
        '
        '_TabReport_TabPage2
        '
        Me._TabReport_TabPage2.Controls.Add(Me.Text4)
        Me._TabReport_TabPage2.Controls.Add(Me.Text3)
        Me._TabReport_TabPage2.Controls.Add(Me.Text2)
        Me._TabReport_TabPage2.Controls.Add(Me.Text1)
        Me._TabReport_TabPage2.Controls.Add(Me.MSFlexGrid3)
        Me._TabReport_TabPage2.Controls.Add(Me.Label7)
        Me._TabReport_TabPage2.Location = New System.Drawing.Point(4, 22)
        Me._TabReport_TabPage2.Name = "_TabReport_TabPage2"
        Me._TabReport_TabPage2.Size = New System.Drawing.Size(789, 575)
        Me._TabReport_TabPage2.TabIndex = 2
        Me._TabReport_TabPage2.Text = "GroupSequence"
        '
        'Text4
        '
        Me.Text4.AcceptsReturn = True
        Me.Text4.BackColor = System.Drawing.SystemColors.Window
        Me.Text4.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.Text4.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Text4.ForeColor = System.Drawing.SystemColors.WindowText
        Me.Text4.Location = New System.Drawing.Point(400, 32)
        Me.Text4.MaxLength = 0
        Me.Text4.Name = "Text4"
        Me.Text4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Text4.Size = New System.Drawing.Size(65, 20)
        Me.Text4.TabIndex = 133
        Me.Text4.Visible = False
        '
        'Text3
        '
        Me.Text3.AcceptsReturn = True
        Me.Text3.BackColor = System.Drawing.SystemColors.Window
        Me.Text3.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.Text3.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Text3.ForeColor = System.Drawing.SystemColors.WindowText
        Me.Text3.Location = New System.Drawing.Point(344, 32)
        Me.Text3.MaxLength = 0
        Me.Text3.Name = "Text3"
        Me.Text3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Text3.Size = New System.Drawing.Size(57, 20)
        Me.Text3.TabIndex = 132
        Me.Text3.Visible = False
        '
        'Text2
        '
        Me.Text2.AcceptsReturn = True
        Me.Text2.BackColor = System.Drawing.SystemColors.Window
        Me.Text2.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.Text2.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.Text2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Text2.ForeColor = System.Drawing.SystemColors.WindowText
        Me.Text2.Location = New System.Drawing.Point(264, -16)
        Me.Text2.MaxLength = 0
        Me.Text2.Name = "Text2"
        Me.Text2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Text2.Size = New System.Drawing.Size(9, 13)
        Me.Text2.TabIndex = 131
        '
        'Text1
        '
        Me.Text1.AcceptsReturn = True
        Me.Text1.BackColor = System.Drawing.Color.Yellow
        Me.Text1.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.Text1.Enabled = False
        Me.Text1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Text1.ForeColor = System.Drawing.SystemColors.WindowText
        Me.Text1.Location = New System.Drawing.Point(32, 40)
        Me.Text1.MaxLength = 0
        Me.Text1.Name = "Text1"
        Me.Text1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Text1.Size = New System.Drawing.Size(17, 20)
        Me.Text1.TabIndex = 126
        '
        'MSFlexGrid3
        '
        Me.MSFlexGrid3.Location = New System.Drawing.Point(32, 64)
        Me.MSFlexGrid3.Name = "MSFlexGrid3"
        Me.MSFlexGrid3.OcxState = CType(resources.GetObject("MSFlexGrid3.OcxState"), System.Windows.Forms.AxHost.State)
        Me.MSFlexGrid3.Size = New System.Drawing.Size(753, 321)
        Me.MSFlexGrid3.TabIndex = 113
        '
        'Label7
        '
        Me.Label7.BackColor = System.Drawing.SystemColors.Control
        Me.Label7.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label7.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label7.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label7.Location = New System.Drawing.Point(56, 40)
        Me.Label7.Name = "Label7"
        Me.Label7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label7.Size = New System.Drawing.Size(132, 17)
        Me.Label7.TabIndex = 125
        Me.Label7.Text = "Yellow is Current Rotation"
        '
        '_Frame_2
        '
        Me._Frame_2.BackColor = System.Drawing.Color.FromArgb(CType(CType(192, Byte), Integer), CType(CType(192, Byte), Integer), CType(CType(192, Byte), Integer))
        Me._Frame_2.Controls.Add(Me.CmdAdd)
        Me._Frame_2.Controls.Add(Me.CmdRemove)
        Me._Frame_2.Controls.Add(Me._Frame_3)
        Me._Frame_2.Controls.Add(Me._Frame_4)
        Me._Frame_2.Controls.Add(Me.TxtStartActive)
        Me._Frame_2.Controls.Add(Me.CmdRemoveAccess)
        Me._Frame_2.Controls.Add(Me.CmdAddAccess)
        Me._Frame_2.Controls.Add(Me.TxtEndActive)
        Me._Frame_2.Controls.Add(Me._Frame_5)
        Me._Frame_2.Controls.Add(Me.LstViewSourceCodes)
        Me._Frame_2.Controls.Add(Me.LstViewDateAccess)
        Me._Frame_2.Controls.Add(Me._Lable_6)
        Me._Frame_2.Controls.Add(Me._Lable_7)
        Me._Frame_2.Controls.Add(Me.Label1)
        Me._Frame_2.Controls.Add(Me._Label_0)
        Me._Frame_2.Controls.Add(Me._Label_1)
        Me._Frame_2.Controls.Add(Me._Lable_8)
        Me._Frame_2.Controls.Add(Me._Lable_9)
        Me._Frame_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_2, CType(2, Short))
        Me._Frame_2.Location = New System.Drawing.Point(-4994, 24)
        Me._Frame_2.Name = "_Frame_2"
        Me._Frame_2.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_2.Size = New System.Drawing.Size(751, 351)
        Me._Frame_2.TabIndex = 1
        Me._Frame_2.TabStop = False
        '
        'CmdAdd
        '
        Me.CmdAdd.BackColor = System.Drawing.SystemColors.Control
        Me.CmdAdd.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdAdd.Enabled = False
        Me.CmdAdd.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdAdd.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdAdd.Location = New System.Drawing.Point(84, 16)
        Me.CmdAdd.Name = "CmdAdd"
        Me.CmdAdd.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdAdd.Size = New System.Drawing.Size(69, 21)
        Me.CmdAdd.TabIndex = 29
        Me.CmdAdd.Text = "Add..."
        Me.CmdAdd.UseVisualStyleBackColor = False
        '
        'CmdRemove
        '
        Me.CmdRemove.BackColor = System.Drawing.SystemColors.Control
        Me.CmdRemove.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdRemove.Enabled = False
        Me.CmdRemove.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdRemove.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdRemove.Location = New System.Drawing.Point(111, 111)
        Me.CmdRemove.Name = "CmdRemove"
        Me.CmdRemove.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdRemove.Size = New System.Drawing.Size(69, 21)
        Me.CmdRemove.TabIndex = 28
        Me.CmdRemove.Text = "Remove"
        Me.CmdRemove.UseVisualStyleBackColor = False
        '
        '_Frame_3
        '
        Me._Frame_3.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_3.Controls.Add(Me._ChkResearch_0)
        Me._Frame_3.Controls.Add(Me._ChkOrgans_0)
        Me._Frame_3.Controls.Add(Me._ChkSkin_0)
        Me._Frame_3.Controls.Add(Me._ChkHeartValves_0)
        Me._Frame_3.Controls.Add(Me._ChkBone_0)
        Me._Frame_3.Controls.Add(Me._ChkEyes_0)
        Me._Frame_3.Controls.Add(Me._ChkSoftTissue_0)
        Me._Frame_3.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_3, CType(3, Short))
        Me._Frame_3.Location = New System.Drawing.Point(240, 36)
        Me._Frame_3.Name = "_Frame_3"
        Me._Frame_3.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_3.Size = New System.Drawing.Size(111, 165)
        Me._Frame_3.TabIndex = 20
        Me._Frame_3.TabStop = False
        Me._Frame_3.Text = "View by Option"
        '
        '_ChkResearch_0
        '
        Me._ChkResearch_0.BackColor = System.Drawing.SystemColors.Control
        Me._ChkResearch_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._ChkResearch_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._ChkResearch_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkResearch.SetIndex(Me._ChkResearch_0, CType(0, Short))
        Me._ChkResearch_0.Location = New System.Drawing.Point(10, 142)
        Me._ChkResearch_0.Name = "_ChkResearch_0"
        Me._ChkResearch_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._ChkResearch_0.Size = New System.Drawing.Size(89, 13)
        Me._ChkResearch_0.TabIndex = 27
        Me._ChkResearch_0.Text = "Other"
        Me._ChkResearch_0.UseVisualStyleBackColor = False
        '
        '_ChkOrgans_0
        '
        Me._ChkOrgans_0.BackColor = System.Drawing.SystemColors.Control
        Me._ChkOrgans_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._ChkOrgans_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._ChkOrgans_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkOrgans.SetIndex(Me._ChkOrgans_0, CType(0, Short))
        Me._ChkOrgans_0.Location = New System.Drawing.Point(10, 22)
        Me._ChkOrgans_0.Name = "_ChkOrgans_0"
        Me._ChkOrgans_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._ChkOrgans_0.Size = New System.Drawing.Size(83, 13)
        Me._ChkOrgans_0.TabIndex = 26
        Me._ChkOrgans_0.Text = "Organs"
        Me._ChkOrgans_0.UseVisualStyleBackColor = False
        '
        '_ChkSkin_0
        '
        Me._ChkSkin_0.BackColor = System.Drawing.SystemColors.Control
        Me._ChkSkin_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._ChkSkin_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._ChkSkin_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkSkin.SetIndex(Me._ChkSkin_0, CType(0, Short))
        Me._ChkSkin_0.Location = New System.Drawing.Point(10, 82)
        Me._ChkSkin_0.Name = "_ChkSkin_0"
        Me._ChkSkin_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._ChkSkin_0.Size = New System.Drawing.Size(85, 13)
        Me._ChkSkin_0.TabIndex = 25
        Me._ChkSkin_0.Text = "Skin"
        Me._ChkSkin_0.UseVisualStyleBackColor = False
        '
        '_ChkHeartValves_0
        '
        Me._ChkHeartValves_0.BackColor = System.Drawing.SystemColors.Control
        Me._ChkHeartValves_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._ChkHeartValves_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._ChkHeartValves_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkHeartValves.SetIndex(Me._ChkHeartValves_0, CType(0, Short))
        Me._ChkHeartValves_0.Location = New System.Drawing.Point(10, 102)
        Me._ChkHeartValves_0.Name = "_ChkHeartValves_0"
        Me._ChkHeartValves_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._ChkHeartValves_0.Size = New System.Drawing.Size(95, 13)
        Me._ChkHeartValves_0.TabIndex = 24
        Me._ChkHeartValves_0.Text = "Heart Valves"
        Me._ChkHeartValves_0.UseVisualStyleBackColor = False
        '
        '_ChkBone_0
        '
        Me._ChkBone_0.BackColor = System.Drawing.SystemColors.Control
        Me._ChkBone_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._ChkBone_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._ChkBone_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkBone.SetIndex(Me._ChkBone_0, CType(0, Short))
        Me._ChkBone_0.Location = New System.Drawing.Point(10, 42)
        Me._ChkBone_0.Name = "_ChkBone_0"
        Me._ChkBone_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._ChkBone_0.Size = New System.Drawing.Size(87, 13)
        Me._ChkBone_0.TabIndex = 23
        Me._ChkBone_0.Text = "Bone"
        Me._ChkBone_0.UseVisualStyleBackColor = False
        '
        '_ChkEyes_0
        '
        Me._ChkEyes_0.BackColor = System.Drawing.SystemColors.Control
        Me._ChkEyes_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._ChkEyes_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._ChkEyes_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkEyes.SetIndex(Me._ChkEyes_0, CType(0, Short))
        Me._ChkEyes_0.Location = New System.Drawing.Point(10, 122)
        Me._ChkEyes_0.Name = "_ChkEyes_0"
        Me._ChkEyes_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._ChkEyes_0.Size = New System.Drawing.Size(95, 13)
        Me._ChkEyes_0.TabIndex = 22
        Me._ChkEyes_0.Text = "Eyes"
        Me._ChkEyes_0.UseVisualStyleBackColor = False
        '
        '_ChkSoftTissue_0
        '
        Me._ChkSoftTissue_0.BackColor = System.Drawing.SystemColors.Control
        Me._ChkSoftTissue_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._ChkSoftTissue_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._ChkSoftTissue_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkSoftTissue.SetIndex(Me._ChkSoftTissue_0, CType(0, Short))
        Me._ChkSoftTissue_0.Location = New System.Drawing.Point(10, 62)
        Me._ChkSoftTissue_0.Name = "_ChkSoftTissue_0"
        Me._ChkSoftTissue_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._ChkSoftTissue_0.Size = New System.Drawing.Size(89, 13)
        Me._ChkSoftTissue_0.TabIndex = 21
        Me._ChkSoftTissue_0.Text = "Soft Tissue"
        Me._ChkSoftTissue_0.UseVisualStyleBackColor = False
        '
        '_Frame_4
        '
        Me._Frame_4.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_4.Controls.Add(Me._ChkSoftTissue_1)
        Me._Frame_4.Controls.Add(Me._ChkEyes_1)
        Me._Frame_4.Controls.Add(Me._ChkBone_1)
        Me._Frame_4.Controls.Add(Me._ChkHeartValves_1)
        Me._Frame_4.Controls.Add(Me._ChkSkin_1)
        Me._Frame_4.Controls.Add(Me._ChkOrgans_1)
        Me._Frame_4.Controls.Add(Me._ChkResearch_1)
        Me._Frame_4.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_4.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_4, CType(4, Short))
        Me._Frame_4.Location = New System.Drawing.Point(356, 36)
        Me._Frame_4.Name = "_Frame_4"
        Me._Frame_4.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_4.Size = New System.Drawing.Size(109, 165)
        Me._Frame_4.TabIndex = 12
        Me._Frame_4.TabStop = False
        Me._Frame_4.Text = "Update"
        '
        '_ChkSoftTissue_1
        '
        Me._ChkSoftTissue_1.BackColor = System.Drawing.SystemColors.Control
        Me._ChkSoftTissue_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._ChkSoftTissue_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._ChkSoftTissue_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkSoftTissue.SetIndex(Me._ChkSoftTissue_1, CType(1, Short))
        Me._ChkSoftTissue_1.Location = New System.Drawing.Point(10, 62)
        Me._ChkSoftTissue_1.Name = "_ChkSoftTissue_1"
        Me._ChkSoftTissue_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._ChkSoftTissue_1.Size = New System.Drawing.Size(91, 13)
        Me._ChkSoftTissue_1.TabIndex = 19
        Me._ChkSoftTissue_1.Text = "Soft Tissue"
        Me._ChkSoftTissue_1.UseVisualStyleBackColor = False
        '
        '_ChkEyes_1
        '
        Me._ChkEyes_1.BackColor = System.Drawing.SystemColors.Control
        Me._ChkEyes_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._ChkEyes_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._ChkEyes_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkEyes.SetIndex(Me._ChkEyes_1, CType(1, Short))
        Me._ChkEyes_1.Location = New System.Drawing.Point(10, 122)
        Me._ChkEyes_1.Name = "_ChkEyes_1"
        Me._ChkEyes_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._ChkEyes_1.Size = New System.Drawing.Size(95, 13)
        Me._ChkEyes_1.TabIndex = 18
        Me._ChkEyes_1.Text = "Eyes"
        Me._ChkEyes_1.UseVisualStyleBackColor = False
        '
        '_ChkBone_1
        '
        Me._ChkBone_1.BackColor = System.Drawing.SystemColors.Control
        Me._ChkBone_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._ChkBone_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._ChkBone_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkBone.SetIndex(Me._ChkBone_1, CType(1, Short))
        Me._ChkBone_1.Location = New System.Drawing.Point(10, 42)
        Me._ChkBone_1.Name = "_ChkBone_1"
        Me._ChkBone_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._ChkBone_1.Size = New System.Drawing.Size(89, 13)
        Me._ChkBone_1.TabIndex = 17
        Me._ChkBone_1.Text = "Bone"
        Me._ChkBone_1.UseVisualStyleBackColor = False
        '
        '_ChkHeartValves_1
        '
        Me._ChkHeartValves_1.BackColor = System.Drawing.SystemColors.Control
        Me._ChkHeartValves_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._ChkHeartValves_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._ChkHeartValves_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkHeartValves.SetIndex(Me._ChkHeartValves_1, CType(1, Short))
        Me._ChkHeartValves_1.Location = New System.Drawing.Point(10, 102)
        Me._ChkHeartValves_1.Name = "_ChkHeartValves_1"
        Me._ChkHeartValves_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._ChkHeartValves_1.Size = New System.Drawing.Size(95, 13)
        Me._ChkHeartValves_1.TabIndex = 16
        Me._ChkHeartValves_1.Text = "Heart Valves"
        Me._ChkHeartValves_1.UseVisualStyleBackColor = False
        '
        '_ChkSkin_1
        '
        Me._ChkSkin_1.BackColor = System.Drawing.SystemColors.Control
        Me._ChkSkin_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._ChkSkin_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._ChkSkin_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkSkin.SetIndex(Me._ChkSkin_1, CType(1, Short))
        Me._ChkSkin_1.Location = New System.Drawing.Point(10, 82)
        Me._ChkSkin_1.Name = "_ChkSkin_1"
        Me._ChkSkin_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._ChkSkin_1.Size = New System.Drawing.Size(85, 13)
        Me._ChkSkin_1.TabIndex = 15
        Me._ChkSkin_1.Text = "Skin"
        Me._ChkSkin_1.UseVisualStyleBackColor = False
        '
        '_ChkOrgans_1
        '
        Me._ChkOrgans_1.BackColor = System.Drawing.SystemColors.Control
        Me._ChkOrgans_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._ChkOrgans_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._ChkOrgans_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkOrgans.SetIndex(Me._ChkOrgans_1, CType(1, Short))
        Me._ChkOrgans_1.Location = New System.Drawing.Point(10, 22)
        Me._ChkOrgans_1.Name = "_ChkOrgans_1"
        Me._ChkOrgans_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._ChkOrgans_1.Size = New System.Drawing.Size(83, 13)
        Me._ChkOrgans_1.TabIndex = 14
        Me._ChkOrgans_1.Text = "Organs"
        Me._ChkOrgans_1.UseVisualStyleBackColor = False
        '
        '_ChkResearch_1
        '
        Me._ChkResearch_1.BackColor = System.Drawing.SystemColors.Control
        Me._ChkResearch_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._ChkResearch_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._ChkResearch_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkResearch.SetIndex(Me._ChkResearch_1, CType(1, Short))
        Me._ChkResearch_1.Location = New System.Drawing.Point(10, 142)
        Me._ChkResearch_1.Name = "_ChkResearch_1"
        Me._ChkResearch_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._ChkResearch_1.Size = New System.Drawing.Size(91, 13)
        Me._ChkResearch_1.TabIndex = 13
        Me._ChkResearch_1.Text = "Other"
        Me._ChkResearch_1.UseVisualStyleBackColor = False
        '
        'TxtStartActive
        '
        Me.TxtStartActive.AcceptsReturn = True
        Me.TxtStartActive.BackColor = System.Drawing.SystemColors.Window
        Me.TxtStartActive.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtStartActive.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtStartActive.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtStartActive.Location = New System.Drawing.Point(508, 42)
        Me.TxtStartActive.MaxLength = 0
        Me.TxtStartActive.Name = "TxtStartActive"
        Me.TxtStartActive.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtStartActive.Size = New System.Drawing.Size(71, 20)
        Me.TxtStartActive.TabIndex = 11
        '
        'CmdRemoveAccess
        '
        Me.CmdRemoveAccess.BackColor = System.Drawing.SystemColors.Control
        Me.CmdRemoveAccess.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdRemoveAccess.Enabled = False
        Me.CmdRemoveAccess.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdRemoveAccess.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdRemoveAccess.Location = New System.Drawing.Point(616, 16)
        Me.CmdRemoveAccess.Name = "CmdRemoveAccess"
        Me.CmdRemoveAccess.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdRemoveAccess.Size = New System.Drawing.Size(69, 21)
        Me.CmdRemoveAccess.TabIndex = 10
        Me.CmdRemoveAccess.Text = "Remove"
        Me.CmdRemoveAccess.UseVisualStyleBackColor = False
        '
        'CmdAddAccess
        '
        Me.CmdAddAccess.BackColor = System.Drawing.SystemColors.Control
        Me.CmdAddAccess.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdAddAccess.Enabled = False
        Me.CmdAddAccess.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdAddAccess.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdAddAccess.Location = New System.Drawing.Point(540, 16)
        Me.CmdAddAccess.Name = "CmdAddAccess"
        Me.CmdAddAccess.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdAddAccess.Size = New System.Drawing.Size(69, 21)
        Me.CmdAddAccess.TabIndex = 9
        Me.CmdAddAccess.Text = "Add..."
        Me.CmdAddAccess.UseVisualStyleBackColor = False
        '
        'TxtEndActive
        '
        Me.TxtEndActive.AcceptsReturn = True
        Me.TxtEndActive.BackColor = System.Drawing.SystemColors.Window
        Me.TxtEndActive.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtEndActive.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtEndActive.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtEndActive.Location = New System.Drawing.Point(614, 42)
        Me.TxtEndActive.MaxLength = 0
        Me.TxtEndActive.Name = "TxtEndActive"
        Me.TxtEndActive.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtEndActive.Size = New System.Drawing.Size(71, 20)
        Me.TxtEndActive.TabIndex = 8
        '
        '_Frame_5
        '
        Me._Frame_5.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_5.Controls.Add(Me.ChkEyeOnly)
        Me._Frame_5.Controls.Add(Me.ChkTE)
        Me._Frame_5.Controls.Add(Me.ChkRuleout)
        Me._Frame_5.Controls.Add(Me.ChkOTE)
        Me._Frame_5.Controls.Add(Me._Lable_10)
        Me._Frame_5.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_5.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_5, CType(5, Short))
        Me._Frame_5.Location = New System.Drawing.Point(240, 208)
        Me._Frame_5.Name = "_Frame_5"
        Me._Frame_5.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_5.Size = New System.Drawing.Size(111, 137)
        Me._Frame_5.TabIndex = 2
        Me._Frame_5.TabStop = False
        Me._Frame_5.Text = "View by Ref Type"
        '
        'ChkEyeOnly
        '
        Me.ChkEyeOnly.BackColor = System.Drawing.SystemColors.Control
        Me.ChkEyeOnly.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkEyeOnly.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkEyeOnly.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkEyeOnly.Location = New System.Drawing.Point(10, 62)
        Me.ChkEyeOnly.Name = "ChkEyeOnly"
        Me.ChkEyeOnly.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkEyeOnly.Size = New System.Drawing.Size(89, 13)
        Me.ChkEyeOnly.TabIndex = 6
        Me.ChkEyeOnly.Text = "Eye Only"
        Me.ChkEyeOnly.UseVisualStyleBackColor = False
        '
        'ChkTE
        '
        Me.ChkTE.BackColor = System.Drawing.SystemColors.Control
        Me.ChkTE.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkTE.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkTE.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkTE.Location = New System.Drawing.Point(10, 42)
        Me.ChkTE.Name = "ChkTE"
        Me.ChkTE.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkTE.Size = New System.Drawing.Size(87, 13)
        Me.ChkTE.TabIndex = 5
        Me.ChkTE.Text = "Tissue/Eye"
        Me.ChkTE.UseVisualStyleBackColor = False
        '
        'ChkRuleout
        '
        Me.ChkRuleout.BackColor = System.Drawing.SystemColors.Control
        Me.ChkRuleout.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkRuleout.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkRuleout.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkRuleout.Location = New System.Drawing.Point(10, 82)
        Me.ChkRuleout.Name = "ChkRuleout"
        Me.ChkRuleout.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkRuleout.Size = New System.Drawing.Size(85, 13)
        Me.ChkRuleout.TabIndex = 4
        Me.ChkRuleout.Text = "Ruleout"
        Me.ChkRuleout.UseVisualStyleBackColor = False
        '
        'ChkOTE
        '
        Me.ChkOTE.BackColor = System.Drawing.SystemColors.Control
        Me.ChkOTE.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkOTE.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkOTE.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkOTE.Location = New System.Drawing.Point(10, 22)
        Me.ChkOTE.Name = "ChkOTE"
        Me.ChkOTE.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkOTE.Size = New System.Drawing.Size(83, 13)
        Me.ChkOTE.TabIndex = 3
        Me.ChkOTE.Text = "O/T/E"
        Me.ChkOTE.UseVisualStyleBackColor = False
        '
        '_Lable_10
        '
        Me._Lable_10.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_10.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_10.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_10.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_10, CType(10, Short))
        Me._Lable_10.Location = New System.Drawing.Point(6, 104)
        Me._Lable_10.Name = "_Lable_10"
        Me._Lable_10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_10.Size = New System.Drawing.Size(99, 27)
        Me._Lable_10.TabIndex = 7
        Me._Lable_10.Text = "* Valid only with Master Report Group"
        '
        'LstViewSourceCodes
        '
        Me.LstViewSourceCodes.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewSourceCodes.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.LstViewSourceCodes.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewSourceCodes.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewSourceCodes.FullRowSelect = True
        Me.LstViewSourceCodes.HideSelection = False
        Me.LstViewSourceCodes.LabelWrap = False
        Me.LstViewSourceCodes.Location = New System.Drawing.Point(10, 42)
        Me.LstViewSourceCodes.Name = "LstViewSourceCodes"
        Me.LstViewSourceCodes.Size = New System.Drawing.Size(219, 159)
        Me.LstViewSourceCodes.TabIndex = 30
        Me.LstViewSourceCodes.UseCompatibleStateImageBehavior = False
        Me.LstViewSourceCodes.View = System.Windows.Forms.View.Details
        '
        'LstViewDateAccess
        '
        Me.LstViewDateAccess.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewDateAccess.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.LstViewDateAccess.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewDateAccess.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewDateAccess.FullRowSelect = True
        Me.LstViewDateAccess.HideSelection = False
        Me.LstViewDateAccess.LabelWrap = False
        Me.LstViewDateAccess.Location = New System.Drawing.Point(472, 68)
        Me.LstViewDateAccess.Name = "LstViewDateAccess"
        Me.LstViewDateAccess.Size = New System.Drawing.Size(213, 133)
        Me.LstViewDateAccess.TabIndex = 31
        Me.LstViewDateAccess.UseCompatibleStateImageBehavior = False
        Me.LstViewDateAccess.View = System.Windows.Forms.View.Details
        '
        '_Lable_6
        '
        Me._Lable_6.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_6.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_6.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_6, CType(6, Short))
        Me._Lable_6.Location = New System.Drawing.Point(10, 20)
        Me._Lable_6.Name = "_Lable_6"
        Me._Lable_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_6.Size = New System.Drawing.Size(81, 17)
        Me._Lable_6.TabIndex = 38
        Me._Lable_6.Text = "Source Codes"
        '
        '_Lable_7
        '
        Me._Lable_7.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_7.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_7.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_7, CType(7, Short))
        Me._Lable_7.Location = New System.Drawing.Point(10, 212)
        Me._Lable_7.Name = "_Lable_7"
        Me._Lable_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_7.Size = New System.Drawing.Size(213, 85)
        Me._Lable_7.TabIndex = 37
        Me._Lable_7.Text = resources.GetString("_Lable_7.Text")
        '
        'Label1
        '
        Me.Label1.BackColor = System.Drawing.SystemColors.Control
        Me.Label1.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label1.Location = New System.Drawing.Point(240, 18)
        Me.Label1.Name = "Label1"
        Me.Label1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label1.Size = New System.Drawing.Size(137, 29)
        Me.Label1.TabIndex = 36
        Me.Label1.Text = "Source Code Data Access"
        '
        '_Label_0
        '
        Me._Label_0.BackColor = System.Drawing.SystemColors.Control
        Me._Label_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_0, CType(0, Short))
        Me._Label_0.Location = New System.Drawing.Point(472, 46)
        Me._Label_0.Name = "_Label_0"
        Me._Label_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_0.Size = New System.Drawing.Size(61, 17)
        Me._Label_0.TabIndex = 35
        Me._Label_0.Text = "Begin"
        '
        '_Label_1
        '
        Me._Label_1.BackColor = System.Drawing.SystemColors.Control
        Me._Label_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_1, CType(1, Short))
        Me._Label_1.Location = New System.Drawing.Point(586, 46)
        Me._Label_1.Name = "_Label_1"
        Me._Label_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_1.Size = New System.Drawing.Size(61, 17)
        Me._Label_1.TabIndex = 34
        Me._Label_1.Text = "End"
        '
        '_Lable_8
        '
        Me._Lable_8.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_8.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_8.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_8.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_8, CType(8, Short))
        Me._Lable_8.Location = New System.Drawing.Point(474, 208)
        Me._Lable_8.Name = "_Lable_8"
        Me._Lable_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_8.Size = New System.Drawing.Size(263, 39)
        Me._Lable_8.TabIndex = 33
        Me._Lable_8.Text = "The list above should indicate the range of dates for which the report group has " & _
            "access to data. If no date range is listed, access is available for all dates."
        '
        '_Lable_9
        '
        Me._Lable_9.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_9.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_9.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_9.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_9, CType(9, Short))
        Me._Lable_9.Location = New System.Drawing.Point(470, 20)
        Me._Lable_9.Name = "_Lable_9"
        Me._Lable_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_9.Size = New System.Drawing.Size(81, 17)
        Me._Lable_9.TabIndex = 32
        Me._Lable_9.Text = "Access Dates"
        '
        'FrmRotateOrganization
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 14.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.ClientSize = New System.Drawing.Size(813, 668)
        Me.Controls.Add(Me._Frame_1)
        Me.Controls.Add(Me.TabReport)
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Location = New System.Drawing.Point(4, 23)
        Me.Name = "FrmRotateOrganization"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Text = "Facility Rotation"
        Me._Frame_1.ResumeLayout(False)
        Me._Frame_1.PerformLayout()
        Me.TabReport.ResumeLayout(False)
        Me._TabReport_TabPage0.ResumeLayout(False)
        Me._Frame_0.ResumeLayout(False)
        Me._TabReport_TabPage1.ResumeLayout(False)
        Me.Frame2.ResumeLayout(False)
        Me.Frame14.ResumeLayout(False)
        Me.Frame14.PerformLayout()
        Me.Frame13.ResumeLayout(False)
        Me.Frame13.PerformLayout()
        Me.Frame12.ResumeLayout(False)
        Me.Frame12.PerformLayout()
        Me.Frame11.ResumeLayout(False)
        Me.Frame11.PerformLayout()
        Me.Frame10.ResumeLayout(False)
        Me.Frame10.PerformLayout()
        Me.Frame9.ResumeLayout(False)
        Me.Frame9.PerformLayout()
        CType(Me.MSFlexGrid2, System.ComponentModel.ISupportInitialize).EndInit()
        Me.Frame1.ResumeLayout(False)
        Me.Frame8.ResumeLayout(False)
        Me.Frame8.PerformLayout()
        Me.Frame7.ResumeLayout(False)
        Me.Frame7.PerformLayout()
        Me.Frame6.ResumeLayout(False)
        Me.Frame6.PerformLayout()
        Me.Frame5.ResumeLayout(False)
        Me.Frame5.PerformLayout()
        Me.Frame4.ResumeLayout(False)
        Me.Frame4.PerformLayout()
        Me.Frame3.ResumeLayout(False)
        Me.Frame3.PerformLayout()
        CType(Me.MSFlexGrid1, System.ComponentModel.ISupportInitialize).EndInit()
        Me._TabReport_TabPage2.ResumeLayout(False)
        Me._TabReport_TabPage2.PerformLayout()
        CType(Me.MSFlexGrid3, System.ComponentModel.ISupportInitialize).EndInit()
        Me._Frame_2.ResumeLayout(False)
        Me._Frame_2.PerformLayout()
        Me._Frame_3.ResumeLayout(False)
        Me._Frame_4.ResumeLayout(False)
        Me._Frame_5.ResumeLayout(False)
        CType(Me.ChkBone, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.ChkEyes, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.ChkHeartValves, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.ChkOrgans, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.ChkResearch, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.ChkSkin, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.ChkSoftTissue, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.Frame, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.Label, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.Lable, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)

    End Sub
#End Region
End Class