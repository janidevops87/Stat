<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmReferral
#Region "Windows Form Designer generated code "
    <System.Diagnostics.DebuggerNonUserCode()> Public Sub New()
        MyBase.New()
        'This call is required by the Windows Form Designer.
        InitializeComponent()
        'This form is an MDI child.
        'This code simulates the VB6 
        ' functionality of automatically
        ' loading and showing an MDI
        ' child's parent.
        ''bret 1/4/2010 dll conversion Me.MdiParent = AppMain.ParentForm
        ''bret 1/4/2010 dll conversion MdiParent.Show()
        'Me.MdiParent = StatTrac.MDIFormStatLine
        'StatTrac.MDIFormStatLine.Show
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
    Public WithEvents ChkQAReview As System.Windows.Forms.CheckBox
    Public WithEvents CmdModify As System.Windows.Forms.Button
    Public WithEvents lblFSLabel As System.Windows.Forms.Label
    Public WithEvents LblLevel As System.Windows.Forms.Label
    Public WithEvents LblOrganization As System.Windows.Forms.Label
    Public WithEvents LblSubLocation As System.Windows.Forms.Label
    Public WithEvents LblName As System.Windows.Forms.Label
    Public WithEvents LblPersonType As System.Windows.Forms.Label
    Public WithEvents LblExtension As System.Windows.Forms.Label
    Public WithEvents LblPhone As System.Windows.Forms.Label
    Public WithEvents _Lable_4 As System.Windows.Forms.Label
    Public WithEvents _Lable_3 As System.Windows.Forms.Label
    Public WithEvents lblFSBorderLeft As System.Windows.Forms.Label
    Public WithEvents lblFSBorderRight As System.Windows.Forms.Label
    Public WithEvents _LblReferral_23 As System.Windows.Forms.Label
    Public WithEvents _Lable_0 As System.Windows.Forms.Label
    Public WithEvents _Lable_2 As System.Windows.Forms.Label
    Public WithEvents _Lable_1 As System.Windows.Forms.Label
    Public WithEvents _Frame_1 As System.Windows.Forms.GroupBox
    Public WithEvents CboReferralType As System.Windows.Forms.ComboBox
    Public WithEvents ChkExclusive As System.Windows.Forms.CheckBox
    Public WithEvents ChkTemp As System.Windows.Forms.CheckBox
    Public WithEvents CmdOK As System.Windows.Forms.Button
    Public WithEvents CmdCancel As System.Windows.Forms.Button
    Public WithEvents VP_Timer As System.Windows.Forms.Timer

    Public WithEvents WebServiceTimer1 As System.Windows.Forms.Timer
    Public WithEvents _TxtAlerts_1 As System.Windows.Forms.RichTextBox
    Public WithEvents CmdCustomData As System.Windows.Forms.Button
    Public WithEvents _CboAppropriate_1 As System.Windows.Forms.ComboBox
    Public WithEvents _CboAppropriate_2 As System.Windows.Forms.ComboBox
    Public WithEvents _CboAppropriate_3 As System.Windows.Forms.ComboBox
    Public WithEvents _CboAppropriate_4 As System.Windows.Forms.ComboBox
    Public WithEvents _CboAppropriate_5 As System.Windows.Forms.ComboBox
    Public WithEvents _CboAppropriate_6 As System.Windows.Forms.ComboBox
    Public WithEvents _CboAppropriate_7 As System.Windows.Forms.ComboBox
    Public WithEvents _CmdOption_1 As System.Windows.Forms.Button
    Public WithEvents _CmdOption_2 As System.Windows.Forms.Button
    Public WithEvents _CmdOption_3 As System.Windows.Forms.Button
    Public WithEvents _CmdOption_4 As System.Windows.Forms.Button
    Public WithEvents _CmdOption_5 As System.Windows.Forms.Button
    Public WithEvents _CmdOption_6 As System.Windows.Forms.Button
    Public WithEvents _CmdOption_7 As System.Windows.Forms.Button
    Public WithEvents _LblOption_0 As System.Windows.Forms.Label
    Public WithEvents LblGive As System.Windows.Forms.Label
    Public WithEvents _Picture_2 As System.Windows.Forms.Panel
    Public WithEvents CmdNOK As System.Windows.Forms.Button
    Public WithEvents _LblOption_3 As System.Windows.Forms.Label
    Public WithEvents _LblOption_2 As System.Windows.Forms.Label
    Public WithEvents _LblOption_1 As System.Windows.Forms.Label
    Public WithEvents _CboApproach_7 As System.Windows.Forms.ComboBox
    Public WithEvents _CboRecovery_7 As System.Windows.Forms.ComboBox
    Public WithEvents _CboRecovery_6 As System.Windows.Forms.ComboBox
    Public WithEvents _CboRecovery_5 As System.Windows.Forms.ComboBox
    Public WithEvents _CboRecovery_4 As System.Windows.Forms.ComboBox
    Public WithEvents _CboRecovery_3 As System.Windows.Forms.ComboBox
    Public WithEvents _CboRecovery_2 As System.Windows.Forms.ComboBox
    Public WithEvents _CboConsent_7 As System.Windows.Forms.ComboBox
    Public WithEvents _CboConsent_6 As System.Windows.Forms.ComboBox
    Public WithEvents _CboConsent_5 As System.Windows.Forms.ComboBox
    Public WithEvents _CboConsent_4 As System.Windows.Forms.ComboBox
    Public WithEvents _CboConsent_3 As System.Windows.Forms.ComboBox
    Public WithEvents _CboConsent_2 As System.Windows.Forms.ComboBox
    Public WithEvents _CboApproach_6 As System.Windows.Forms.ComboBox
    Public WithEvents _CboApproach_5 As System.Windows.Forms.ComboBox
    Public WithEvents _CboApproach_4 As System.Windows.Forms.ComboBox
    Public WithEvents _CboApproach_3 As System.Windows.Forms.ComboBox
    Public WithEvents _CboApproach_2 As System.Windows.Forms.ComboBox
    Public WithEvents _CboRecovery_1 As System.Windows.Forms.ComboBox
    Public WithEvents _CboConsent_1 As System.Windows.Forms.ComboBox
    Public WithEvents _CboApproach_1 As System.Windows.Forms.ComboBox
    Public WithEvents _TabDisposition_TabPage0 As System.Windows.Forms.TabPage
    Public WithEvents TxtConditional As System.Windows.Forms.RichTextBox
    Public WithEvents _TabDisposition_TabPage1 As System.Windows.Forms.TabPage
    Public WithEvents _Lable_37 As System.Windows.Forms.Label
    Public WithEvents LblCoronerMsg As System.Windows.Forms.Label
    Public WithEvents _Lable_30 As System.Windows.Forms.Label
    Public WithEvents _Lable_29 As System.Windows.Forms.Label
    Public WithEvents _Lable_28 As System.Windows.Forms.Label
    Public WithEvents _Lable_27 As System.Windows.Forms.Label
    Public WithEvents CmdCoronerName As System.Windows.Forms.Button
    Public WithEvents CboCoronerName As System.Windows.Forms.ComboBox
    Public WithEvents CboState As System.Windows.Forms.ComboBox
    Public WithEvents CmdCoronerDetail As System.Windows.Forms.Button
    Public WithEvents CmdContactCoroner As System.Windows.Forms.Button
    Public WithEvents CboCoronerOrg As System.Windows.Forms.ComboBox
    Public WithEvents TxtCoronerPhone As System.Windows.Forms.TextBox
    Public WithEvents TxtCoronerNote As System.Windows.Forms.TextBox
    Public WithEvents ChkCoronerCase As System.Windows.Forms.CheckBox
    Public WithEvents _TabDisposition_TabPage2 As System.Windows.Forms.TabPage
    Public WithEvents TabDisposition As System.Windows.Forms.TabControl
    Public WithEvents _CmdPhysicianPhone_1 As System.Windows.Forms.Button
    Public WithEvents TxtPronouncingPhone As System.Windows.Forms.TextBox
    Public WithEvents TxtAttendingPhone As System.Windows.Forms.TextBox
    Public WithEvents _CmdPhysicianPhone_0 As System.Windows.Forms.Button
    Public WithEvents _CboPhysician_0 As System.Windows.Forms.ComboBox
    Public WithEvents _CboPhysician_1 As System.Windows.Forms.ComboBox
    Public WithEvents _CmdPhysicianDetail_0 As System.Windows.Forms.Button
    Public WithEvents _CmdPhysicianDetail_1 As System.Windows.Forms.Button
    Public WithEvents _LblPhysician_0 As System.Windows.Forms.Label
    Public WithEvents _LblPhysician_1 As System.Windows.Forms.Label
    Public WithEvents _Frame_5 As System.Windows.Forms.GroupBox
    Public WithEvents Cmdregkill As System.Windows.Forms.Button
    Public WithEvents TimerReg As System.Windows.Forms.Timer
    Public WithEvents CboGeneralConsent As System.Windows.Forms.ComboBox
    Public WithEvents CboApproachedBy As System.Windows.Forms.ComboBox
    Public WithEvents cboRegistryStatus As System.Windows.Forms.ComboBox
    Public WithEvents CboApproachType As System.Windows.Forms.ComboBox
    Public WithEvents TxtSpecificCOD As System.Windows.Forms.TextBox
    Public WithEvents CboCauseOfDeath As System.Windows.Forms.ComboBox
    Public WithEvents CmdApproachedByDetail As System.Windows.Forms.Button
    Public WithEvents cmdDonorIntent As System.Windows.Forms.Button
    Public WithEvents TxtNotesCase As System.Windows.Forms.RichTextBox
    Public WithEvents LblFSConsent As System.Windows.Forms.Label
    Public WithEvents LblFSApproacher As System.Windows.Forms.Label
    Public WithEvents LblFSApproach As System.Windows.Forms.Label
    Public WithEvents LblFinialApproach As System.Windows.Forms.Label
    Public WithEvents LblInitialApproach As System.Windows.Forms.Label
    Public WithEvents _Lable_20 As System.Windows.Forms.Label
    Public WithEvents _Lable_22 As System.Windows.Forms.Label
    Public WithEvents LblSpecificCOD As System.Windows.Forms.Label
    Public WithEvents _Lable_21 As System.Windows.Forms.Label
    Public WithEvents _Lable_18 As System.Windows.Forms.Label
    Public WithEvents LblHistory As System.Windows.Forms.Label
    Public WithEvents Label As System.Windows.Forms.Label
    Public WithEvents LblPromptApproach As System.Windows.Forms.Label
    Public WithEvents RegStatus As System.Windows.Forms.Label
    Public WithEvents Frame1 As System.Windows.Forms.GroupBox
    Public WithEvents CmdVerify As System.Windows.Forms.Button
    Public WithEvents TxtDOB As System.Windows.Forms.TextBox
    Public WithEvents TxtRecNum As System.Windows.Forms.TextBox
    Public WithEvents TxtDeathTime As System.Windows.Forms.TextBox
    Public WithEvents TxtDeathDate As System.Windows.Forms.TextBox
    Public WithEvents TxtDonorLastName As System.Windows.Forms.TextBox
    Public WithEvents CboRace As System.Windows.Forms.ComboBox
    Public WithEvents TxtAdmitTime As System.Windows.Forms.TextBox
    Public WithEvents TxtAdmitDate As System.Windows.Forms.TextBox
    Public WithEvents CboHeartBeat As System.Windows.Forms.ComboBox
    Public WithEvents ChkDOB As System.Windows.Forms.CheckBox
    Public WithEvents TxtBrainDeathDate As System.Windows.Forms.TextBox
    Public WithEvents TxtBrainDeathTime As System.Windows.Forms.TextBox
    Public WithEvents CmdDirectionsNote As System.Windows.Forms.Button
    Public WithEvents TxtDonorMI As System.Windows.Forms.TextBox
    Public WithEvents TxtExtubated As System.Windows.Forms.TextBox
    Public WithEvents TxtSSN As System.Windows.Forms.TextBox
    Public WithEvents ChkDOA As System.Windows.Forms.CheckBox
    Public WithEvents _Picture_0 As System.Windows.Forms.Panel
    Public WithEvents CboVent As System.Windows.Forms.ComboBox
    Public WithEvents TxtWeight As System.Windows.Forms.TextBox
    Public WithEvents CboGender As System.Windows.Forms.ComboBox
    Public WithEvents CboAgeUnit As System.Windows.Forms.ComboBox
    Public WithEvents TxtAge As System.Windows.Forms.TextBox
    Public WithEvents TxtDonorFirstName As System.Windows.Forms.TextBox
    Public WithEvents CmdRegMatch As System.Windows.Forms.Button
    Public WithEvents _Lable_17 As System.Windows.Forms.Label
    Public WithEvents _Lable_15 As System.Windows.Forms.Label
    Public WithEvents _Lable_5 As System.Windows.Forms.Label
    Public WithEvents LblCardiacDate As System.Windows.Forms.Label
    Public WithEvents LblRegistry As System.Windows.Forms.Label
    Public WithEvents _Lable_33 As System.Windows.Forms.Label
    Public WithEvents _Lable_31 As System.Windows.Forms.Label
    Public WithEvents _Lable_12 As System.Windows.Forms.Label
    Public WithEvents _Lable_14 As System.Windows.Forms.Label
    Public WithEvents _Lable_10 As System.Windows.Forms.Label
    Public WithEvents _Lable_8 As System.Windows.Forms.Label
    Public WithEvents _Lable_11 As System.Windows.Forms.Label
    Public WithEvents _Lable_9 As System.Windows.Forms.Label
    Public WithEvents _Lable_7 As System.Windows.Forms.Label
    Public WithEvents _Lable_6 As System.Windows.Forms.Label
    Public WithEvents _Lable_16 As System.Windows.Forms.Label
    Public WithEvents LblWeight As System.Windows.Forms.Label
    Public WithEvents LblDOB_ILB As System.Windows.Forms.Label
    Public WithEvents _Frame_4 As System.Windows.Forms.GroupBox
    Public WithEvents _TxtAlerts_0 As System.Windows.Forms.RichTextBox
    Public WithEvents _TabDonor_TabPage0 As System.Windows.Forms.TabPage
    Public WithEvents txtSecondaryTBIComment As System.Windows.Forms.TextBox
    Public WithEvents cmdGenerateTBI As System.Windows.Forms.Button
    Public WithEvents chkSecondaryTBINotNeeded As System.Windows.Forms.CheckBox
    Public WithEvents txtSecondaryTBINumber As System.Windows.Forms.TextBox
    Public WithEvents lblTBIComment As System.Windows.Forms.Label
    Public WithEvents lblTBINumber As System.Windows.Forms.Label
    Public WithEvents FrameTBINumber As System.Windows.Forms.GroupBox
    Public WithEvents _Picture_3 As System.Windows.Forms.Panel
    Public WithEvents TxtNotesCaseReadOnly As System.Windows.Forms.RichTextBox
    Public WithEvents TxtSecondaryAlert As System.Windows.Forms.RichTextBox
    Public WithEvents TxtSecondaryNote As System.Windows.Forms.RichTextBox
    Public WithEvents _Lable_36 As System.Windows.Forms.Label
    Public WithEvents _Lable_35 As System.Windows.Forms.Label
    Public WithEvents _Lable_34 As System.Windows.Forms.Label
    Public WithEvents _Frame_6 As System.Windows.Forms.GroupBox
    Public WithEvents chkFinal As System.Windows.Forms.CheckBox
    Public WithEvents chkApproached As System.Windows.Forms.CheckBox
    Public WithEvents chkSecondaryComplete As System.Windows.Forms.CheckBox
    Public WithEvents chkSystemEvents As System.Windows.Forms.CheckBox
    Public WithEvents chkCaseOpen As System.Windows.Forms.CheckBox
    Public WithEvents lblFinalPersonDateTime As System.Windows.Forms.Label
    Public WithEvents lblApproachedPersonDateTime As System.Windows.Forms.Label
    Public WithEvents lblSecondaryCompletePersonDateTime As System.Windows.Forms.Label
    Public WithEvents lblSystemEventsPersonDateTime As System.Windows.Forms.Label
    Public WithEvents lblCaseOpenPersonDateTime As System.Windows.Forms.Label
    Public WithEvents _Frame_7 As System.Windows.Forms.GroupBox
    Public WithEvents _TabDonor_TabPage1 As System.Windows.Forms.TabPage
    Public WithEvents chkViewLogEventDeleted As System.Windows.Forms.CheckBox
    Public WithEvents CmdColorKey As System.Windows.Forms.Button
    Public WithEvents CmdNewEvent As System.Windows.Forms.Button
    Public WithEvents CmdDelete As System.Windows.Forms.Button
    Public WithEvents CmdReferral As System.Windows.Forms.Button
    Public WithEvents _Picture_1 As System.Windows.Forms.Panel
    Public WithEvents LstViewLogEvent As System.Windows.Forms.ListView
    Public WithEvents LstViewPending As System.Windows.Forms.ListView
    Public WithEvents _Lable_19 As System.Windows.Forms.Label
    Public WithEvents _Frame_3 As System.Windows.Forms.GroupBox
    Public WithEvents TxtCallDate As System.Windows.Forms.TextBox
    Public WithEvents TxtTotalTimeCounter As System.Windows.Forms.TextBox
    Public WithEvents CboCallByEmployee As System.Windows.Forms.ComboBox
    Public WithEvents _LblReferral_20 As System.Windows.Forms.Label
    Public WithEvents _LblReferral_27 As System.Windows.Forms.Label
    Public WithEvents _LblReferral_28 As System.Windows.Forms.Label
    Public WithEvents _Frame_0 As System.Windows.Forms.GroupBox
    Public WithEvents _TabDonor_TabPage2 As System.Windows.Forms.TabPage
    Public WithEvents TabDonor As System.Windows.Forms.TabControl
    Public WithEvents Label2 As System.Windows.Forms.Label
    Public WithEvents Label3 As System.Windows.Forms.Label


    Public WithEvents Frame As Microsoft.VisualBasic.Compatibility.VB6.GroupBoxArray
    Public WithEvents Lable As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
    Public WithEvents LblOption As Microsoft.VisualBasic.Compatibility.VB6.LabelArray

    Public WithEvents LblReferral As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
    Public WithEvents Picture As Microsoft.VisualBasic.Compatibility.VB6.PanelArray


    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FrmReferral))
        Me.ChkDOB = New System.Windows.Forms.CheckBox()
        Me.chkFinal = New System.Windows.Forms.CheckBox()
        Me.chkApproached = New System.Windows.Forms.CheckBox()
        Me.chkSecondaryComplete = New System.Windows.Forms.CheckBox()
        Me.chkSystemEvents = New System.Windows.Forms.CheckBox()
        Me.chkCaseOpen = New System.Windows.Forms.CheckBox()
        Me.ChkQAReview = New System.Windows.Forms.CheckBox()
        Me._Frame_1 = New System.Windows.Forms.GroupBox()
        Me.LabelEReferral = New System.Windows.Forms.Label()
        Me.lblPNELabel = New System.Windows.Forms.Label()
        Me.lblPNEBorderLeft = New Statline.Stattrac.Windows.Forms.Label()
        Me.lblPNEBorderRight = New Statline.Stattrac.Windows.Forms.Label()
        Me.CmdModify = New System.Windows.Forms.Button()
        Me.lblFSLabel = New System.Windows.Forms.Label()
        Me.LblLevel = New System.Windows.Forms.Label()
        Me.LblOrganization = New System.Windows.Forms.Label()
        Me.LblSubLocation = New System.Windows.Forms.Label()
        Me.LblName = New System.Windows.Forms.Label()
        Me.LblPersonType = New System.Windows.Forms.Label()
        Me.LblExtension = New System.Windows.Forms.Label()
        Me.LblPhone = New System.Windows.Forms.Label()
        Me._Lable_4 = New System.Windows.Forms.Label()
        Me._Lable_3 = New System.Windows.Forms.Label()
        Me.lblFSBorderLeft = New System.Windows.Forms.Label()
        Me.lblFSBorderRight = New System.Windows.Forms.Label()
        Me._LblReferral_23 = New System.Windows.Forms.Label()
        Me._Lable_0 = New System.Windows.Forms.Label()
        Me._Lable_2 = New System.Windows.Forms.Label()
        Me._Lable_1 = New System.Windows.Forms.Label()
        Me.CboReferralType = New System.Windows.Forms.ComboBox()
        Me.ChkExclusive = New System.Windows.Forms.CheckBox()
        Me.ChkTemp = New System.Windows.Forms.CheckBox()
        Me.CmdOK = New System.Windows.Forms.Button()
        Me.CmdCancel = New System.Windows.Forms.Button()
        Me.TabDonor = New System.Windows.Forms.TabControl()
        Me._TabDonor_TabPage0 = New System.Windows.Forms.TabPage()
        Me.cboDCDPotential = New Statline.Stattrac.Windows.Forms.ComboBox()
        Me.CmdDcdPotential = New System.Windows.Forms.Button()
        Me.LowMemoryWarning = New Statline.Stattrac.Windows.Forms.Button()
        Me.CmdVerify = New System.Windows.Forms.Button()
        Me._TxtAlerts_1 = New System.Windows.Forms.RichTextBox()
        Me.CmdCustomData = New System.Windows.Forms.Button()
        Me._Picture_2 = New System.Windows.Forms.Panel()
        Me._CboAppropriate_1 = New System.Windows.Forms.ComboBox()
        Me._CboAppropriate_2 = New System.Windows.Forms.ComboBox()
        Me._CboAppropriate_3 = New System.Windows.Forms.ComboBox()
        Me._CboAppropriate_4 = New System.Windows.Forms.ComboBox()
        Me._CboAppropriate_5 = New System.Windows.Forms.ComboBox()
        Me._CboAppropriate_6 = New System.Windows.Forms.ComboBox()
        Me._CboAppropriate_7 = New System.Windows.Forms.ComboBox()
        Me._CmdOption_1 = New System.Windows.Forms.Button()
        Me._CmdOption_2 = New System.Windows.Forms.Button()
        Me._CmdOption_3 = New System.Windows.Forms.Button()
        Me._CmdOption_4 = New System.Windows.Forms.Button()
        Me._CmdOption_5 = New System.Windows.Forms.Button()
        Me._CmdOption_6 = New System.Windows.Forms.Button()
        Me._CmdOption_7 = New System.Windows.Forms.Button()
        Me._LblOption_0 = New System.Windows.Forms.Label()
        Me.LblGive = New System.Windows.Forms.Label()
        Me.CmdNOK = New System.Windows.Forms.Button()
        Me.TabDisposition = New System.Windows.Forms.TabControl()
        Me._TabDisposition_TabPage0 = New System.Windows.Forms.TabPage()
        Me._LblOption_3 = New System.Windows.Forms.Label()
        Me._LblOption_2 = New System.Windows.Forms.Label()
        Me._LblOption_1 = New System.Windows.Forms.Label()
        Me._CboApproach_7 = New System.Windows.Forms.ComboBox()
        Me._CboRecovery_7 = New System.Windows.Forms.ComboBox()
        Me._CboRecovery_6 = New System.Windows.Forms.ComboBox()
        Me._CboRecovery_5 = New System.Windows.Forms.ComboBox()
        Me._CboRecovery_4 = New System.Windows.Forms.ComboBox()
        Me._CboRecovery_3 = New System.Windows.Forms.ComboBox()
        Me._CboRecovery_2 = New System.Windows.Forms.ComboBox()
        Me._CboConsent_7 = New System.Windows.Forms.ComboBox()
        Me._CboConsent_6 = New System.Windows.Forms.ComboBox()
        Me._CboConsent_5 = New System.Windows.Forms.ComboBox()
        Me._CboConsent_4 = New System.Windows.Forms.ComboBox()
        Me._CboConsent_3 = New System.Windows.Forms.ComboBox()
        Me._CboConsent_2 = New System.Windows.Forms.ComboBox()
        Me._CboApproach_6 = New System.Windows.Forms.ComboBox()
        Me._CboApproach_5 = New System.Windows.Forms.ComboBox()
        Me._CboApproach_4 = New System.Windows.Forms.ComboBox()
        Me._CboApproach_3 = New System.Windows.Forms.ComboBox()
        Me._CboApproach_2 = New System.Windows.Forms.ComboBox()
        Me._CboRecovery_1 = New System.Windows.Forms.ComboBox()
        Me._CboConsent_1 = New System.Windows.Forms.ComboBox()
        Me._CboApproach_1 = New System.Windows.Forms.ComboBox()
        Me._TabDisposition_TabPage1 = New System.Windows.Forms.TabPage()
        Me.TxtConditional = New System.Windows.Forms.RichTextBox()
        Me.LstViewVerify = New System.Windows.Forms.ListView()
        Me._TabDisposition_TabPage2 = New System.Windows.Forms.TabPage()
        Me._Lable_37 = New System.Windows.Forms.Label()
        Me.LblCoronerMsg = New System.Windows.Forms.Label()
        Me._Lable_30 = New System.Windows.Forms.Label()
        Me._Lable_29 = New System.Windows.Forms.Label()
        Me._Lable_28 = New System.Windows.Forms.Label()
        Me._Lable_27 = New System.Windows.Forms.Label()
        Me.CmdCoronerName = New System.Windows.Forms.Button()
        Me.CboCoronerName = New System.Windows.Forms.ComboBox()
        Me.CboState = New System.Windows.Forms.ComboBox()
        Me.CmdCoronerDetail = New System.Windows.Forms.Button()
        Me.CmdContactCoroner = New System.Windows.Forms.Button()
        Me.CboCoronerOrg = New System.Windows.Forms.ComboBox()
        Me.TxtCoronerPhone = New System.Windows.Forms.TextBox()
        Me.TxtCoronerNote = New System.Windows.Forms.TextBox()
        Me.ChkCoronerCase = New System.Windows.Forms.CheckBox()
        Me._Frame_5 = New System.Windows.Forms.GroupBox()
        Me._CmdPhysicianPhone_1 = New System.Windows.Forms.Button()
        Me.TxtPronouncingPhone = New System.Windows.Forms.TextBox()
        Me.TxtAttendingPhone = New System.Windows.Forms.TextBox()
        Me._CmdPhysicianPhone_0 = New System.Windows.Forms.Button()
        Me._CboPhysician_0 = New System.Windows.Forms.ComboBox()
        Me._CboPhysician_1 = New System.Windows.Forms.ComboBox()
        Me._CmdPhysicianDetail_0 = New System.Windows.Forms.Button()
        Me._CmdPhysicianDetail_1 = New System.Windows.Forms.Button()
        Me._LblPhysician_0 = New System.Windows.Forms.Label()
        Me._LblPhysician_1 = New System.Windows.Forms.Label()
        Me._Frame_4 = New System.Windows.Forms.GroupBox()
        Me.rtbSearching = New Statline.Stattrac.Windows.Forms.RichTextBox()
        Me.TxtLSATime = New System.Windows.Forms.TextBox()
        Me.TxtLSADate = New System.Windows.Forms.TextBox()
        Me.LblLSA = New Statline.Stattrac.Windows.Forms.Label()
        Me.TxtDOB = New System.Windows.Forms.TextBox()
        Me.TxtRecNum = New System.Windows.Forms.TextBox()
        Me.TxtDeathTime = New System.Windows.Forms.TextBox()
        Me.TxtDeathDate = New System.Windows.Forms.TextBox()
        Me.TxtDonorLastName = New System.Windows.Forms.TextBox()
        Me.CboRace = New System.Windows.Forms.ComboBox()
        Me.TxtAdmitTime = New System.Windows.Forms.TextBox()
        Me.TxtAdmitDate = New System.Windows.Forms.TextBox()
        Me.CboHeartBeat = New System.Windows.Forms.ComboBox()
        Me.TxtBrainDeathDate = New System.Windows.Forms.TextBox()
        Me.TxtBrainDeathTime = New System.Windows.Forms.TextBox()
        Me.CmdDirectionsNote = New System.Windows.Forms.Button()
        Me.TxtDonorMI = New System.Windows.Forms.TextBox()
        Me.TxtExtubated = New System.Windows.Forms.TextBox()
        Me.TxtSSN = New System.Windows.Forms.TextBox()
        Me.ChkDOA = New System.Windows.Forms.CheckBox()
        Me._Picture_0 = New System.Windows.Forms.Panel()
        Me.CboVent = New System.Windows.Forms.ComboBox()
        Me.TxtWeight = New System.Windows.Forms.TextBox()
        Me.CboGender = New System.Windows.Forms.ComboBox()
        Me.CboAgeUnit = New System.Windows.Forms.ComboBox()
        Me.TxtAge = New System.Windows.Forms.TextBox()
        Me.TxtDonorFirstName = New System.Windows.Forms.TextBox()
        Me.CmdRegMatch = New System.Windows.Forms.Button()
        Me._Lable_17 = New System.Windows.Forms.Label()
        Me._Lable_15 = New System.Windows.Forms.Label()
        Me._Lable_5 = New System.Windows.Forms.Label()
        Me.LblCardiacDate = New System.Windows.Forms.Label()
        Me.LblRegistry = New System.Windows.Forms.Label()
        Me._Lable_33 = New System.Windows.Forms.Label()
        Me._Lable_31 = New System.Windows.Forms.Label()
        Me._Lable_12 = New System.Windows.Forms.Label()
        Me._Lable_14 = New System.Windows.Forms.Label()
        Me._Lable_10 = New System.Windows.Forms.Label()
        Me._Lable_8 = New System.Windows.Forms.Label()
        Me._Lable_11 = New System.Windows.Forms.Label()
        Me._Lable_9 = New System.Windows.Forms.Label()
        Me._Lable_7 = New System.Windows.Forms.Label()
        Me._Lable_6 = New System.Windows.Forms.Label()
        Me._Lable_16 = New System.Windows.Forms.Label()
        Me.LblWeight = New System.Windows.Forms.Label()
        Me.LblDOB_ILB = New System.Windows.Forms.Label()
        Me._TxtAlerts_0 = New System.Windows.Forms.RichTextBox()
        Me.Frame1 = New System.Windows.Forms.GroupBox()
        Me.Cmdregkill = New System.Windows.Forms.Button()
        Me.CboGeneralConsent = New System.Windows.Forms.ComboBox()
        Me.CboApproachedBy = New System.Windows.Forms.ComboBox()
        Me.cboRegistryStatus = New System.Windows.Forms.ComboBox()
        Me.CboApproachType = New System.Windows.Forms.ComboBox()
        Me.TxtSpecificCOD = New System.Windows.Forms.TextBox()
        Me.CboCauseOfDeath = New System.Windows.Forms.ComboBox()
        Me.CmdApproachedByDetail = New System.Windows.Forms.Button()
        Me.cmdDonorIntent = New System.Windows.Forms.Button()
        Me.TxtNotesCase = New System.Windows.Forms.RichTextBox()
        Me.LblFSConsent = New System.Windows.Forms.Label()
        Me.LblFSApproacher = New System.Windows.Forms.Label()
        Me.LblFSApproach = New System.Windows.Forms.Label()
        Me.LblFinialApproach = New System.Windows.Forms.Label()
        Me.LblInitialApproach = New System.Windows.Forms.Label()
        Me._Lable_20 = New System.Windows.Forms.Label()
        Me._Lable_22 = New System.Windows.Forms.Label()
        Me.LblSpecificCOD = New System.Windows.Forms.Label()
        Me._Lable_21 = New System.Windows.Forms.Label()
        Me._Lable_18 = New System.Windows.Forms.Label()
        Me.LblHistory = New System.Windows.Forms.Label()
        Me.Label = New System.Windows.Forms.Label()
        Me.LblPromptApproach = New System.Windows.Forms.Label()
        Me.RegStatus = New System.Windows.Forms.Label()
        Me._TabDonor_TabPage1 = New System.Windows.Forms.TabPage()
        Me.FrameTBINumber = New System.Windows.Forms.GroupBox()
        Me.txtSecondaryTBIComment = New System.Windows.Forms.TextBox()
        Me.cmdGenerateTBI = New System.Windows.Forms.Button()
        Me.chkSecondaryTBINotNeeded = New System.Windows.Forms.CheckBox()
        Me.txtSecondaryTBINumber = New System.Windows.Forms.TextBox()
        Me.lblTBIComment = New System.Windows.Forms.Label()
        Me.lblTBINumber = New System.Windows.Forms.Label()
        Me._Frame_6 = New System.Windows.Forms.GroupBox()
        Me._Picture_3 = New System.Windows.Forms.Panel()
        Me.TxtNotesCaseReadOnly = New System.Windows.Forms.RichTextBox()
        Me.TxtSecondaryAlert = New System.Windows.Forms.RichTextBox()
        Me.TxtSecondaryNote = New System.Windows.Forms.RichTextBox()
        Me._Lable_36 = New System.Windows.Forms.Label()
        Me._Lable_35 = New System.Windows.Forms.Label()
        Me._Lable_34 = New System.Windows.Forms.Label()
        Me._Frame_7 = New System.Windows.Forms.GroupBox()
        Me.lblFinalPersonDateTime = New System.Windows.Forms.Label()
        Me.lblApproachedPersonDateTime = New System.Windows.Forms.Label()
        Me.lblSecondaryCompletePersonDateTime = New System.Windows.Forms.Label()
        Me.lblSystemEventsPersonDateTime = New System.Windows.Forms.Label()
        Me.lblCaseOpenPersonDateTime = New System.Windows.Forms.Label()
        Me._TabDonor_TabPage2 = New System.Windows.Forms.TabPage()
        Me.Label4 = New System.Windows.Forms.Label()
        Me.rtbScheduleAlert = New Statline.Stattrac.Windows.Forms.RichTextBox()
        Me._Frame_3 = New System.Windows.Forms.GroupBox()
        Me.chkViewLogEventDeleted = New System.Windows.Forms.CheckBox()
        Me.CmdColorKey = New System.Windows.Forms.Button()
        Me.GbPendingCase = New Statline.Stattrac.Windows.Forms.GroupBox()
        Me._LblPendingCaseCoordinator = New System.Windows.Forms.Label()
        Me.TxtPendingCaseComment = New System.Windows.Forms.TextBox()
        Me._LblPendingCaseComment = New System.Windows.Forms.Label()
        Me.CboPendingCaseCoordinator = New System.Windows.Forms.ComboBox()
        Me.ChkPendingCase = New System.Windows.Forms.CheckBox()
        Me.CmdNewEvent = New System.Windows.Forms.Button()
        Me.CmdDelete = New System.Windows.Forms.Button()
        Me.CmdReferral = New System.Windows.Forms.Button()
        Me._Picture_1 = New System.Windows.Forms.Panel()
        Me.LstViewLogEvent = New System.Windows.Forms.ListView()
        Me.LstViewPending = New System.Windows.Forms.ListView()
        Me._Lable_19 = New System.Windows.Forms.Label()
        Me._Frame_0 = New System.Windows.Forms.GroupBox()
        Me.TxtCallDate = New System.Windows.Forms.TextBox()
        Me.TxtTotalTimeCounter = New System.Windows.Forms.TextBox()
        Me.CboCallByEmployee = New System.Windows.Forms.ComboBox()
        Me._LblReferral_20 = New System.Windows.Forms.Label()
        Me._LblReferral_27 = New System.Windows.Forms.Label()
        Me._LblReferral_28 = New System.Windows.Forms.Label()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.TimerTotalTime = New System.Windows.Forms.Timer(Me.components)
        Me._Frame_1.SuspendLayout()
        Me.TabDonor.SuspendLayout()
        Me._TabDonor_TabPage0.SuspendLayout()
        Me._Picture_2.SuspendLayout()
        Me.TabDisposition.SuspendLayout()
        Me._TabDisposition_TabPage0.SuspendLayout()
        Me._TabDisposition_TabPage1.SuspendLayout()
        Me._TabDisposition_TabPage2.SuspendLayout()
        Me._Frame_5.SuspendLayout()
        Me._Frame_4.SuspendLayout()
        Me.Frame1.SuspendLayout()
        Me._TabDonor_TabPage1.SuspendLayout()
        Me.FrameTBINumber.SuspendLayout()
        Me._Frame_6.SuspendLayout()
        Me._Frame_7.SuspendLayout()
        Me._TabDonor_TabPage2.SuspendLayout()
        Me._Frame_3.SuspendLayout()
        Me.GbPendingCase.SuspendLayout()
        Me._Frame_0.SuspendLayout()
        Me.SuspendLayout()
        '
        'ChkDOB
        '
        Me.ChkDOB.BackColor = System.Drawing.SystemColors.Control
        Me.ChkDOB.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkDOB.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkDOB.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkDOB.Location = New System.Drawing.Point(174, 57)
        Me.ChkDOB.Name = "ChkDOB"
        Me.ChkDOB.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkDOB.Size = New System.Drawing.Size(11, 13)
        Me.ChkDOB.TabIndex = 7
        Me.ChkDOB.UseVisualStyleBackColor = False
        '
        'chkFinal
        '
        Me.chkFinal.BackColor = System.Drawing.SystemColors.Control
        Me.chkFinal.Cursor = System.Windows.Forms.Cursors.Default
        Me.chkFinal.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.chkFinal.ForeColor = System.Drawing.SystemColors.ControlText
        Me.chkFinal.Location = New System.Drawing.Point(8, 118)
        Me.chkFinal.Name = "chkFinal"
        Me.chkFinal.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.chkFinal.Size = New System.Drawing.Size(121, 17)
        Me.chkFinal.TabIndex = 200
        Me.chkFinal.TabStop = False
        Me.chkFinal.Tag = "5"
        Me.chkFinal.Text = "Final"
        Me.chkFinal.UseVisualStyleBackColor = False
        Me.chkFinal.Visible = False
        '
        'chkApproached
        '
        Me.chkApproached.BackColor = System.Drawing.SystemColors.Control
        Me.chkApproached.Cursor = System.Windows.Forms.Cursors.Default
        Me.chkApproached.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.chkApproached.ForeColor = System.Drawing.SystemColors.ControlText
        Me.chkApproached.Location = New System.Drawing.Point(8, 94)
        Me.chkApproached.Name = "chkApproached"
        Me.chkApproached.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.chkApproached.Size = New System.Drawing.Size(121, 17)
        Me.chkApproached.TabIndex = 200
        Me.chkApproached.TabStop = False
        Me.chkApproached.Tag = "4"
        Me.chkApproached.Text = "Approached"
        Me.chkApproached.UseVisualStyleBackColor = False
        Me.chkApproached.Visible = False
        '
        'chkSecondaryComplete
        '
        Me.chkSecondaryComplete.BackColor = System.Drawing.SystemColors.Control
        Me.chkSecondaryComplete.Cursor = System.Windows.Forms.Cursors.Default
        Me.chkSecondaryComplete.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.chkSecondaryComplete.ForeColor = System.Drawing.SystemColors.ControlText
        Me.chkSecondaryComplete.Location = New System.Drawing.Point(8, 70)
        Me.chkSecondaryComplete.Name = "chkSecondaryComplete"
        Me.chkSecondaryComplete.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.chkSecondaryComplete.Size = New System.Drawing.Size(121, 17)
        Me.chkSecondaryComplete.TabIndex = 200
        Me.chkSecondaryComplete.TabStop = False
        Me.chkSecondaryComplete.Tag = "3"
        Me.chkSecondaryComplete.Text = "Secondary Complete"
        Me.chkSecondaryComplete.UseVisualStyleBackColor = False
        Me.chkSecondaryComplete.Visible = False
        '
        'chkSystemEvents
        '
        Me.chkSystemEvents.BackColor = System.Drawing.SystemColors.Control
        Me.chkSystemEvents.Cursor = System.Windows.Forms.Cursors.Default
        Me.chkSystemEvents.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.chkSystemEvents.ForeColor = System.Drawing.SystemColors.ControlText
        Me.chkSystemEvents.Location = New System.Drawing.Point(8, 46)
        Me.chkSystemEvents.Name = "chkSystemEvents"
        Me.chkSystemEvents.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.chkSystemEvents.Size = New System.Drawing.Size(121, 17)
        Me.chkSystemEvents.TabIndex = 200
        Me.chkSystemEvents.TabStop = False
        Me.chkSystemEvents.Tag = "2"
        Me.chkSystemEvents.Text = "System Events"
        Me.chkSystemEvents.UseVisualStyleBackColor = False
        Me.chkSystemEvents.Visible = False
        '
        'chkCaseOpen
        '
        Me.chkCaseOpen.BackColor = System.Drawing.SystemColors.Control
        Me.chkCaseOpen.Cursor = System.Windows.Forms.Cursors.Default
        Me.chkCaseOpen.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.chkCaseOpen.ForeColor = System.Drawing.SystemColors.ControlText
        Me.chkCaseOpen.Location = New System.Drawing.Point(8, 22)
        Me.chkCaseOpen.Name = "chkCaseOpen"
        Me.chkCaseOpen.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.chkCaseOpen.Size = New System.Drawing.Size(121, 17)
        Me.chkCaseOpen.TabIndex = 200
        Me.chkCaseOpen.TabStop = False
        Me.chkCaseOpen.Tag = "1"
        Me.chkCaseOpen.Text = "Case Open"
        Me.chkCaseOpen.UseVisualStyleBackColor = False
        Me.chkCaseOpen.Visible = False
        '
        'ChkQAReview
        '
        Me.ChkQAReview.BackColor = System.Drawing.SystemColors.Control
        Me.ChkQAReview.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkQAReview.Enabled = False
        Me.ChkQAReview.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkQAReview.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkQAReview.Location = New System.Drawing.Point(1156, 140)
        Me.ChkQAReview.Name = "ChkQAReview"
        Me.ChkQAReview.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkQAReview.Size = New System.Drawing.Size(129, 24)
        Me.ChkQAReview.TabIndex = 200
        Me.ChkQAReview.Text = "QA Review Complete"
        Me.ChkQAReview.UseVisualStyleBackColor = False
        Me.ChkQAReview.Visible = False
        '
        '_Frame_1
        '
        Me._Frame_1.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me._Frame_1.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_1.Controls.Add(Me.LabelEReferral)
        Me._Frame_1.Controls.Add(Me.lblPNELabel)
        Me._Frame_1.Controls.Add(Me.lblPNEBorderLeft)
        Me._Frame_1.Controls.Add(Me.lblPNEBorderRight)
        Me._Frame_1.Controls.Add(Me.CmdModify)
        Me._Frame_1.Controls.Add(Me.lblFSLabel)
        Me._Frame_1.Controls.Add(Me.LblLevel)
        Me._Frame_1.Controls.Add(Me.LblOrganization)
        Me._Frame_1.Controls.Add(Me.LblSubLocation)
        Me._Frame_1.Controls.Add(Me.LblName)
        Me._Frame_1.Controls.Add(Me.LblPersonType)
        Me._Frame_1.Controls.Add(Me.LblExtension)
        Me._Frame_1.Controls.Add(Me.LblPhone)
        Me._Frame_1.Controls.Add(Me._Lable_4)
        Me._Frame_1.Controls.Add(Me._Lable_3)
        Me._Frame_1.Controls.Add(Me.lblFSBorderLeft)
        Me._Frame_1.Controls.Add(Me.lblFSBorderRight)
        Me._Frame_1.Controls.Add(Me._LblReferral_23)
        Me._Frame_1.Controls.Add(Me._Lable_0)
        Me._Frame_1.Controls.Add(Me._Lable_2)
        Me._Frame_1.Controls.Add(Me._Lable_1)
        Me._Frame_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_1.ForeColor = System.Drawing.Color.Black
        Me._Frame_1.Location = New System.Drawing.Point(10, -1)
        Me._Frame_1.Margin = New System.Windows.Forms.Padding(1)
        Me._Frame_1.Name = "_Frame_1"
        Me._Frame_1.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_1.Size = New System.Drawing.Size(1313, 41)
        Me._Frame_1.TabIndex = 200
        Me._Frame_1.TabStop = False
        '
        'LabelEReferral
        '
        Me.LabelEReferral.AutoSize = True
        Me.LabelEReferral.BackColor = System.Drawing.SystemColors.Control
        Me.LabelEReferral.Cursor = System.Windows.Forms.Cursors.Default
        Me.LabelEReferral.Font = New System.Drawing.Font("Arial", 9.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LabelEReferral.ForeColor = System.Drawing.Color.Blue
        Me.LabelEReferral.Location = New System.Drawing.Point(1135, 16)
        Me.LabelEReferral.Name = "LabelEReferral"
        Me.LabelEReferral.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LabelEReferral.Size = New System.Drawing.Size(64, 15)
        Me.LabelEReferral.TabIndex = 204
        Me.LabelEReferral.Text = "E-Referral"
        Me.LabelEReferral.Visible = False
        '
        'lblPNELabel
        '
        Me.lblPNELabel.BackColor = System.Drawing.Color.Black
        Me.lblPNELabel.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblPNELabel.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblPNELabel.ForeColor = System.Drawing.Color.Lime
        Me.lblPNELabel.Location = New System.Drawing.Point(636, -1)
        Me.lblPNELabel.Margin = New System.Windows.Forms.Padding(0)
        Me.lblPNELabel.Name = "lblPNELabel"
        Me.lblPNELabel.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblPNELabel.Size = New System.Drawing.Size(124, 13)
        Me.lblPNELabel.TabIndex = 203
        Me.lblPNELabel.Text = "PATIENT NOT EXPIRED"
        Me.lblPNELabel.TextAlign = System.Drawing.ContentAlignment.TopCenter
        Me.lblPNELabel.Visible = False
        '
        'lblPNEBorderLeft
        '
        Me.lblPNEBorderLeft.BackColor = System.Drawing.Color.Lime
        Me.lblPNEBorderLeft.Font = New System.Drawing.Font("Tahoma", 8.0!)
        Me.lblPNEBorderLeft.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None
        Me.lblPNEBorderLeft.Location = New System.Drawing.Point(462, 1)
        Me.lblPNEBorderLeft.Name = "lblPNEBorderLeft"
        Me.lblPNEBorderLeft.Size = New System.Drawing.Size(174, 5)
        Me.lblPNEBorderLeft.TabIndex = 202
        Me.lblPNEBorderLeft.Visible = False
        '
        'lblPNEBorderRight
        '
        Me.lblPNEBorderRight.BackColor = System.Drawing.Color.Lime
        Me.lblPNEBorderRight.Font = New System.Drawing.Font("Tahoma", 8.0!)
        Me.lblPNEBorderRight.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None
        Me.lblPNEBorderRight.Location = New System.Drawing.Point(760, 0)
        Me.lblPNEBorderRight.Name = "lblPNEBorderRight"
        Me.lblPNEBorderRight.Size = New System.Drawing.Size(220, 5)
        Me.lblPNEBorderRight.TabIndex = 201
        Me.lblPNEBorderRight.Visible = False
        '
        'CmdModify
        '
        Me.CmdModify.BackColor = System.Drawing.SystemColors.Control
        Me.CmdModify.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdModify.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdModify.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdModify.Location = New System.Drawing.Point(1216, 13)
        Me.CmdModify.Name = "CmdModify"
        Me.CmdModify.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdModify.Size = New System.Drawing.Size(47, 21)
        Me.CmdModify.TabIndex = 44
        Me.CmdModify.Text = "Modify"
        Me.CmdModify.UseVisualStyleBackColor = False
        '
        'lblFSLabel
        '
        Me.lblFSLabel.BackColor = System.Drawing.SystemColors.Control
        Me.lblFSLabel.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblFSLabel.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblFSLabel.ForeColor = System.Drawing.Color.Red
        Me.lblFSLabel.Location = New System.Drawing.Point(173, -1)
        Me.lblFSLabel.Name = "lblFSLabel"
        Me.lblFSLabel.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblFSLabel.Size = New System.Drawing.Size(112, 13)
        Me.lblFSLabel.TabIndex = 200
        Me.lblFSLabel.Text = "FAMILY SERVICES"
        Me.lblFSLabel.TextAlign = System.Drawing.ContentAlignment.TopCenter
        Me.lblFSLabel.Visible = False
        '
        'LblLevel
        '
        Me.LblLevel.BackColor = System.Drawing.SystemColors.Control
        Me.LblLevel.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblLevel.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblLevel.ForeColor = System.Drawing.Color.Red
        Me.LblLevel.Location = New System.Drawing.Point(618, 12)
        Me.LblLevel.Name = "LblLevel"
        Me.LblLevel.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblLevel.Size = New System.Drawing.Size(36, 14)
        Me.LblLevel.TabIndex = 200
        '
        'LblOrganization
        '
        Me.LblOrganization.BackColor = System.Drawing.SystemColors.Control
        Me.LblOrganization.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblOrganization.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblOrganization.ForeColor = System.Drawing.Color.Red
        Me.LblOrganization.Location = New System.Drawing.Point(274, 12)
        Me.LblOrganization.Margin = New System.Windows.Forms.Padding(1, 0, 1, 0)
        Me.LblOrganization.Name = "LblOrganization"
        Me.LblOrganization.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblOrganization.Size = New System.Drawing.Size(151, 22)
        Me.LblOrganization.TabIndex = 200
        Me.LblOrganization.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        Me.LblOrganization.UseCompatibleTextRendering = True
        '
        'LblSubLocation
        '
        Me.LblSubLocation.BackColor = System.Drawing.SystemColors.Control
        Me.LblSubLocation.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblSubLocation.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblSubLocation.ForeColor = System.Drawing.Color.Red
        Me.LblSubLocation.Location = New System.Drawing.Point(490, 12)
        Me.LblSubLocation.Name = "LblSubLocation"
        Me.LblSubLocation.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblSubLocation.Size = New System.Drawing.Size(165, 22)
        Me.LblSubLocation.TabIndex = 200
        Me.LblSubLocation.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        Me.LblSubLocation.UseCompatibleTextRendering = True
        '
        'LblName
        '
        Me.LblName.BackColor = System.Drawing.SystemColors.Control
        Me.LblName.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblName.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblName.ForeColor = System.Drawing.Color.Red
        Me.LblName.Location = New System.Drawing.Point(749, 12)
        Me.LblName.Margin = New System.Windows.Forms.Padding(0)
        Me.LblName.Name = "LblName"
        Me.LblName.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblName.Size = New System.Drawing.Size(116, 22)
        Me.LblName.TabIndex = 200
        Me.LblName.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        Me.LblName.UseCompatibleTextRendering = True
        '
        'LblPersonType
        '
        Me.LblPersonType.BackColor = System.Drawing.SystemColors.Control
        Me.LblPersonType.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblPersonType.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblPersonType.ForeColor = System.Drawing.Color.Red
        Me.LblPersonType.Location = New System.Drawing.Point(889, 12)
        Me.LblPersonType.Name = "LblPersonType"
        Me.LblPersonType.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblPersonType.Size = New System.Drawing.Size(129, 22)
        Me.LblPersonType.TabIndex = 200
        Me.LblPersonType.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        'LblExtension
        '
        Me.LblExtension.BackColor = System.Drawing.SystemColors.Control
        Me.LblExtension.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblExtension.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblExtension.ForeColor = System.Drawing.Color.Red
        Me.LblExtension.Location = New System.Drawing.Point(157, 12)
        Me.LblExtension.Name = "LblExtension"
        Me.LblExtension.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblExtension.Size = New System.Drawing.Size(38, 22)
        Me.LblExtension.TabIndex = 200
        Me.LblExtension.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        'LblPhone
        '
        Me.LblPhone.BackColor = System.Drawing.SystemColors.Control
        Me.LblPhone.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblPhone.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblPhone.ForeColor = System.Drawing.Color.Red
        Me.LblPhone.Location = New System.Drawing.Point(55, 12)
        Me.LblPhone.Name = "LblPhone"
        Me.LblPhone.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblPhone.Size = New System.Drawing.Size(82, 22)
        Me.LblPhone.TabIndex = 200
        Me.LblPhone.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        '_Lable_4
        '
        Me._Lable_4.AutoSize = True
        Me._Lable_4.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_4.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_4.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Lable_4.Location = New System.Drawing.Point(668, 17)
        Me._Lable_4.Name = "_Lable_4"
        Me._Lable_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_4.Size = New System.Drawing.Size(86, 14)
        Me._Lable_4.TabIndex = 200
        Me._Lable_4.Text = "Referral Person:"
        '
        '_Lable_3
        '
        Me._Lable_3.AutoSize = True
        Me._Lable_3.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_3.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Lable_3.Location = New System.Drawing.Point(864, 17)
        Me._Lable_3.Name = "_Lable_3"
        Me._Lable_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_3.Size = New System.Drawing.Size(29, 14)
        Me._Lable_3.TabIndex = 200
        Me._Lable_3.Text = "Title:"
        '
        'lblFSBorderLeft
        '
        Me.lblFSBorderLeft.BackColor = System.Drawing.Color.Red
        Me.lblFSBorderLeft.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblFSBorderLeft.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblFSBorderLeft.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblFSBorderLeft.Location = New System.Drawing.Point(0, 1)
        Me.lblFSBorderLeft.Name = "lblFSBorderLeft"
        Me.lblFSBorderLeft.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblFSBorderLeft.Size = New System.Drawing.Size(172, 5)
        Me.lblFSBorderLeft.TabIndex = 200
        Me.lblFSBorderLeft.Visible = False
        '
        'lblFSBorderRight
        '
        Me.lblFSBorderRight.BackColor = System.Drawing.Color.Red
        Me.lblFSBorderRight.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblFSBorderRight.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblFSBorderRight.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblFSBorderRight.Location = New System.Drawing.Point(287, 1)
        Me.lblFSBorderRight.Name = "lblFSBorderRight"
        Me.lblFSBorderRight.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblFSBorderRight.Size = New System.Drawing.Size(180, 5)
        Me.lblFSBorderRight.TabIndex = 200
        Me.lblFSBorderRight.Visible = False
        '
        '_LblReferral_23
        '
        Me._LblReferral_23.AutoSize = True
        Me._LblReferral_23.BackColor = System.Drawing.SystemColors.Control
        Me._LblReferral_23.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblReferral_23.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LblReferral_23.ForeColor = System.Drawing.SystemColors.ControlText
        Me._LblReferral_23.Location = New System.Drawing.Point(136, 17)
        Me._LblReferral_23.Name = "_LblReferral_23"
        Me._LblReferral_23.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblReferral_23.Size = New System.Drawing.Size(28, 14)
        Me._LblReferral_23.TabIndex = 200
        Me._LblReferral_23.Text = "Ext.:"
        '
        '_Lable_0
        '
        Me._Lable_0.AutoSize = True
        Me._Lable_0.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Lable_0.Location = New System.Drawing.Point(19, 17)
        Me._Lable_0.Name = "_Lable_0"
        Me._Lable_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_0.Size = New System.Drawing.Size(40, 14)
        Me._Lable_0.TabIndex = 200
        Me._Lable_0.Text = "Phone:"
        '
        '_Lable_2
        '
        Me._Lable_2.AutoSize = True
        Me._Lable_2.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Lable_2.Location = New System.Drawing.Point(426, 17)
        Me._Lable_2.Name = "_Lable_2"
        Me._Lable_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_2.Size = New System.Drawing.Size(69, 14)
        Me._Lable_2.TabIndex = 200
        Me._Lable_2.Text = "Hospital Unit:"
        '
        '_Lable_1
        '
        Me._Lable_1.AutoSize = True
        Me._Lable_1.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Lable_1.Location = New System.Drawing.Point(194, 17)
        Me._Lable_1.Name = "_Lable_1"
        Me._Lable_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_1.Size = New System.Drawing.Size(85, 14)
        Me._Lable_1.TabIndex = 200
        Me._Lable_1.Text = "Referral Facility:"
        '
        'CboReferralType
        '
        Me.CboReferralType.BackColor = System.Drawing.SystemColors.Window
        Me.CboReferralType.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboReferralType.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboReferralType.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboReferralType.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboReferralType.Location = New System.Drawing.Point(390, 7)
        Me.CboReferralType.Name = "CboReferralType"
        Me.CboReferralType.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboReferralType.Size = New System.Drawing.Size(195, 22)
        Me.CboReferralType.TabIndex = 200
        Me.CboReferralType.TabStop = False
        '
        'ChkExclusive
        '
        Me.ChkExclusive.BackColor = System.Drawing.SystemColors.Control
        Me.ChkExclusive.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkExclusive.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkExclusive.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkExclusive.Location = New System.Drawing.Point(1207, 123)
        Me.ChkExclusive.Name = "ChkExclusive"
        Me.ChkExclusive.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkExclusive.Size = New System.Drawing.Size(72, 18)
        Me.ChkExclusive.TabIndex = 200
        Me.ChkExclusive.TabStop = False
        Me.ChkExclusive.Text = "Exclusive"
        Me.ChkExclusive.UseVisualStyleBackColor = False
        Me.ChkExclusive.Visible = False
        '
        'ChkTemp
        '
        Me.ChkTemp.BackColor = System.Drawing.SystemColors.Control
        Me.ChkTemp.Checked = True
        Me.ChkTemp.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkTemp.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkTemp.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkTemp.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkTemp.Location = New System.Drawing.Point(1207, 102)
        Me.ChkTemp.Margin = New System.Windows.Forms.Padding(0)
        Me.ChkTemp.Name = "ChkTemp"
        Me.ChkTemp.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkTemp.Size = New System.Drawing.Size(77, 18)
        Me.ChkTemp.TabIndex = 200
        Me.ChkTemp.TabStop = False
        Me.ChkTemp.Text = "Incomplete"
        Me.ChkTemp.UseVisualStyleBackColor = False
        '
        'CmdOK
        '
        Me.CmdOK.BackColor = System.Drawing.SystemColors.Control
        Me.CmdOK.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdOK.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdOK.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdOK.Location = New System.Drawing.Point(1222, 70)
        Me.CmdOK.Name = "CmdOK"
        Me.CmdOK.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdOK.Size = New System.Drawing.Size(57, 21)
        Me.CmdOK.TabIndex = 40
        Me.CmdOK.Text = "Save"
        Me.CmdOK.UseVisualStyleBackColor = False
        '
        'CmdCancel
        '
        Me.CmdCancel.BackColor = System.Drawing.SystemColors.Control
        Me.CmdCancel.CausesValidation = False
        Me.CmdCancel.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdCancel.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdCancel.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdCancel.Location = New System.Drawing.Point(1222, 615)
        Me.CmdCancel.Name = "CmdCancel"
        Me.CmdCancel.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdCancel.Size = New System.Drawing.Size(57, 21)
        Me.CmdCancel.TabIndex = 41
        Me.CmdCancel.Text = "Cancel"
        Me.CmdCancel.UseVisualStyleBackColor = False
        '
        'TabDonor
        '
        Me.TabDonor.Alignment = System.Windows.Forms.TabAlignment.Right
        Me.TabDonor.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.TabDonor.Controls.Add(Me._TabDonor_TabPage0)
        Me.TabDonor.Controls.Add(Me._TabDonor_TabPage1)
        Me.TabDonor.Controls.Add(Me._TabDonor_TabPage2)
        Me.TabDonor.Font = New System.Drawing.Font("Arial", 9.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TabDonor.ItemSize = New System.Drawing.Size(42, 30)
        Me.TabDonor.Location = New System.Drawing.Point(10, 50)
        Me.TabDonor.Margin = New System.Windows.Forms.Padding(1)
        Me.TabDonor.Multiline = True
        Me.TabDonor.Name = "TabDonor"
        Me.TabDonor.SelectedIndex = 0
        Me.TabDonor.Size = New System.Drawing.Size(1313, 601)
        Me.TabDonor.TabIndex = 200
        Me.TabDonor.TabStop = False
        '
        '_TabDonor_TabPage0
        '
        Me._TabDonor_TabPage0.BackColor = System.Drawing.SystemColors.Control
        Me._TabDonor_TabPage0.Controls.Add(Me.cboDCDPotential)
        Me._TabDonor_TabPage0.Controls.Add(Me.CmdDcdPotential)
        Me._TabDonor_TabPage0.Controls.Add(Me.LowMemoryWarning)
        Me._TabDonor_TabPage0.Controls.Add(Me.CmdVerify)
        Me._TabDonor_TabPage0.Controls.Add(Me._TxtAlerts_1)
        Me._TabDonor_TabPage0.Controls.Add(Me.CmdCustomData)
        Me._TabDonor_TabPage0.Controls.Add(Me._Picture_2)
        Me._TabDonor_TabPage0.Controls.Add(Me.CmdNOK)
        Me._TabDonor_TabPage0.Controls.Add(Me.TabDisposition)
        Me._TabDonor_TabPage0.Controls.Add(Me._Frame_5)
        Me._TabDonor_TabPage0.Controls.Add(Me._Frame_4)
        Me._TabDonor_TabPage0.Controls.Add(Me._TxtAlerts_0)
        Me._TabDonor_TabPage0.Controls.Add(Me.Frame1)
        Me._TabDonor_TabPage0.Location = New System.Drawing.Point(4, 4)
        Me._TabDonor_TabPage0.Name = "_TabDonor_TabPage0"
        Me._TabDonor_TabPage0.Size = New System.Drawing.Size(1275, 593)
        Me._TabDonor_TabPage0.TabIndex = 200
        Me._TabDonor_TabPage0.Text = "Primary"
        '
        'cboDCDPotential
        '
        Me.cboDCDPotential.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.SuggestAppend
        Me.cboDCDPotential.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.cboDCDPotential.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cboDCDPotential.Font = New System.Drawing.Font("Tahoma", 8.0!)
        Me.cboDCDPotential.FormattingEnabled = True
        Me.cboDCDPotential.Location = New System.Drawing.Point(311, 550)
        Me.cboDCDPotential.Name = "cboDCDPotential"
        Me.cboDCDPotential.Required = False
        Me.cboDCDPotential.Size = New System.Drawing.Size(121, 21)
        Me.cboDCDPotential.TabIndex = 204
        Me.cboDCDPotential.Visible = False
        '
        'CmdDcdPotential
        '
        Me.CmdDcdPotential.BackColor = System.Drawing.SystemColors.Control
        Me.CmdDcdPotential.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdDcdPotential.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdDcdPotential.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdDcdPotential.Location = New System.Drawing.Point(333, 521)
        Me.CmdDcdPotential.Name = "CmdDcdPotential"
        Me.CmdDcdPotential.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdDcdPotential.Size = New System.Drawing.Size(80, 23)
        Me.CmdDcdPotential.TabIndex = 203
        Me.CmdDcdPotential.Text = "DCD Potential"
        Me.CmdDcdPotential.UseVisualStyleBackColor = False
        Me.CmdDcdPotential.Visible = False
        '
        'LowMemoryWarning
        '
        Me.LowMemoryWarning.BackColor = System.Drawing.SystemColors.ControlDark
        Me.LowMemoryWarning.FlatStyle = System.Windows.Forms.FlatStyle.Flat
        Me.LowMemoryWarning.Font = New System.Drawing.Font("Arial", 9.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LowMemoryWarning.ForeColor = System.Drawing.Color.Red
        Me.LowMemoryWarning.Location = New System.Drawing.Point(1193, 457)
        Me.LowMemoryWarning.Name = "LowMemoryWarning"
        Me.LowMemoryWarning.Size = New System.Drawing.Size(71, 58)
        Me.LowMemoryWarning.TabIndex = 202
        Me.LowMemoryWarning.Text = "Warning: Low Memory"
        Me.LowMemoryWarning.UseVisualStyleBackColor = False
        Me.LowMemoryWarning.Visible = False
        '
        'CmdVerify
        '
        Me.CmdVerify.BackColor = System.Drawing.SystemColors.Control
        Me.CmdVerify.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdVerify.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdVerify.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdVerify.Location = New System.Drawing.Point(793, 384)
        Me.CmdVerify.Name = "CmdVerify"
        Me.CmdVerify.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdVerify.Size = New System.Drawing.Size(95, 21)
        Me.CmdVerify.TabIndex = 200
        Me.CmdVerify.TabStop = False
        Me.CmdVerify.Text = "Verify Options"
        Me.CmdVerify.UseVisualStyleBackColor = False
        '
        '_TxtAlerts_1
        '
        Me._TxtAlerts_1.BackColor = System.Drawing.SystemColors.Window
        Me._TxtAlerts_1.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me._TxtAlerts_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._TxtAlerts_1.Location = New System.Drawing.Point(665, 14)
        Me._TxtAlerts_1.MaxLength = 2000
        Me._TxtAlerts_1.Name = "_TxtAlerts_1"
        Me._TxtAlerts_1.ReadOnly = True
        Me._TxtAlerts_1.ScrollBars = System.Windows.Forms.RichTextBoxScrollBars.Vertical
        Me._TxtAlerts_1.Size = New System.Drawing.Size(228, 369)
        Me._TxtAlerts_1.TabIndex = 200
        Me._TxtAlerts_1.TabStop = False
        Me._TxtAlerts_1.Text = ""
        '
        'CmdCustomData
        '
        Me.CmdCustomData.BackColor = System.Drawing.SystemColors.Control
        Me.CmdCustomData.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdCustomData.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdCustomData.ForeColor = System.Drawing.Color.Red
        Me.CmdCustomData.Location = New System.Drawing.Point(333, 490)
        Me.CmdCustomData.Name = "CmdCustomData"
        Me.CmdCustomData.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdCustomData.Size = New System.Drawing.Size(80, 23)
        Me.CmdCustomData.TabIndex = 38
        Me.CmdCustomData.Text = "More Data..."
        Me.CmdCustomData.UseVisualStyleBackColor = False
        Me.CmdCustomData.Visible = False
        '
        '_Picture_2
        '
        Me._Picture_2.BackColor = System.Drawing.SystemColors.Control
        Me._Picture_2.Controls.Add(Me._CboAppropriate_1)
        Me._Picture_2.Controls.Add(Me._CboAppropriate_2)
        Me._Picture_2.Controls.Add(Me._CboAppropriate_3)
        Me._Picture_2.Controls.Add(Me._CboAppropriate_4)
        Me._Picture_2.Controls.Add(Me._CboAppropriate_5)
        Me._Picture_2.Controls.Add(Me._CboAppropriate_6)
        Me._Picture_2.Controls.Add(Me._CboAppropriate_7)
        Me._Picture_2.Controls.Add(Me._CmdOption_1)
        Me._Picture_2.Controls.Add(Me._CmdOption_2)
        Me._Picture_2.Controls.Add(Me._CmdOption_3)
        Me._Picture_2.Controls.Add(Me._CmdOption_4)
        Me._Picture_2.Controls.Add(Me._CmdOption_5)
        Me._Picture_2.Controls.Add(Me._CmdOption_6)
        Me._Picture_2.Controls.Add(Me._CmdOption_7)
        Me._Picture_2.Controls.Add(Me._LblOption_0)
        Me._Picture_2.Controls.Add(Me.LblGive)
        Me._Picture_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._Picture_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Picture_2.ForeColor = System.Drawing.SystemColors.WindowText
        Me._Picture_2.Location = New System.Drawing.Point(10, 427)
        Me._Picture_2.Name = "_Picture_2"
        Me._Picture_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Picture_2.Size = New System.Drawing.Size(292, 158)
        Me._Picture_2.TabIndex = 200
        '
        '_CboAppropriate_1
        '
        Me._CboAppropriate_1.BackColor = System.Drawing.SystemColors.Window
        Me._CboAppropriate_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._CboAppropriate_1.DropDownStyle = System.Windows.Forms.ComboBoxStyle.Simple
        Me._CboAppropriate_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CboAppropriate_1.ForeColor = System.Drawing.SystemColors.WindowText
        Me._CboAppropriate_1.Location = New System.Drawing.Point(138, 15)
        Me._CboAppropriate_1.Name = "_CboAppropriate_1"
        Me._CboAppropriate_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CboAppropriate_1.Size = New System.Drawing.Size(151, 21)
        Me._CboAppropriate_1.Sorted = True
        Me._CboAppropriate_1.TabIndex = 200
        Me._CboAppropriate_1.TabStop = False
        Me._CboAppropriate_1.Text = "CboAppropriate"
        '
        '_CboAppropriate_2
        '
        Me._CboAppropriate_2.BackColor = System.Drawing.SystemColors.Window
        Me._CboAppropriate_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._CboAppropriate_2.DropDownStyle = System.Windows.Forms.ComboBoxStyle.Simple
        Me._CboAppropriate_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CboAppropriate_2.ForeColor = System.Drawing.SystemColors.WindowText
        Me._CboAppropriate_2.Location = New System.Drawing.Point(138, 35)
        Me._CboAppropriate_2.Name = "_CboAppropriate_2"
        Me._CboAppropriate_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CboAppropriate_2.Size = New System.Drawing.Size(151, 21)
        Me._CboAppropriate_2.Sorted = True
        Me._CboAppropriate_2.TabIndex = 200
        Me._CboAppropriate_2.TabStop = False
        Me._CboAppropriate_2.Text = "CboAppropriate"
        '
        '_CboAppropriate_3
        '
        Me._CboAppropriate_3.BackColor = System.Drawing.SystemColors.Window
        Me._CboAppropriate_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._CboAppropriate_3.DropDownStyle = System.Windows.Forms.ComboBoxStyle.Simple
        Me._CboAppropriate_3.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CboAppropriate_3.ForeColor = System.Drawing.SystemColors.WindowText
        Me._CboAppropriate_3.Location = New System.Drawing.Point(138, 55)
        Me._CboAppropriate_3.Name = "_CboAppropriate_3"
        Me._CboAppropriate_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CboAppropriate_3.Size = New System.Drawing.Size(151, 21)
        Me._CboAppropriate_3.Sorted = True
        Me._CboAppropriate_3.TabIndex = 200
        Me._CboAppropriate_3.TabStop = False
        Me._CboAppropriate_3.Text = "CboAppropriate"
        '
        '_CboAppropriate_4
        '
        Me._CboAppropriate_4.BackColor = System.Drawing.SystemColors.Window
        Me._CboAppropriate_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._CboAppropriate_4.DropDownStyle = System.Windows.Forms.ComboBoxStyle.Simple
        Me._CboAppropriate_4.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CboAppropriate_4.ForeColor = System.Drawing.SystemColors.WindowText
        Me._CboAppropriate_4.Location = New System.Drawing.Point(138, 75)
        Me._CboAppropriate_4.Name = "_CboAppropriate_4"
        Me._CboAppropriate_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CboAppropriate_4.Size = New System.Drawing.Size(151, 21)
        Me._CboAppropriate_4.Sorted = True
        Me._CboAppropriate_4.TabIndex = 200
        Me._CboAppropriate_4.TabStop = False
        Me._CboAppropriate_4.Text = "CboAppropriate"
        '
        '_CboAppropriate_5
        '
        Me._CboAppropriate_5.BackColor = System.Drawing.SystemColors.Window
        Me._CboAppropriate_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._CboAppropriate_5.DropDownStyle = System.Windows.Forms.ComboBoxStyle.Simple
        Me._CboAppropriate_5.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CboAppropriate_5.ForeColor = System.Drawing.SystemColors.WindowText
        Me._CboAppropriate_5.Location = New System.Drawing.Point(138, 95)
        Me._CboAppropriate_5.Name = "_CboAppropriate_5"
        Me._CboAppropriate_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CboAppropriate_5.Size = New System.Drawing.Size(151, 21)
        Me._CboAppropriate_5.Sorted = True
        Me._CboAppropriate_5.TabIndex = 200
        Me._CboAppropriate_5.TabStop = False
        Me._CboAppropriate_5.Text = "CboAppropriate"
        '
        '_CboAppropriate_6
        '
        Me._CboAppropriate_6.BackColor = System.Drawing.SystemColors.Window
        Me._CboAppropriate_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._CboAppropriate_6.DropDownStyle = System.Windows.Forms.ComboBoxStyle.Simple
        Me._CboAppropriate_6.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CboAppropriate_6.ForeColor = System.Drawing.SystemColors.WindowText
        Me._CboAppropriate_6.Location = New System.Drawing.Point(138, 115)
        Me._CboAppropriate_6.Name = "_CboAppropriate_6"
        Me._CboAppropriate_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CboAppropriate_6.Size = New System.Drawing.Size(151, 21)
        Me._CboAppropriate_6.Sorted = True
        Me._CboAppropriate_6.TabIndex = 200
        Me._CboAppropriate_6.TabStop = False
        Me._CboAppropriate_6.Text = "CboAppropriate"
        '
        '_CboAppropriate_7
        '
        Me._CboAppropriate_7.BackColor = System.Drawing.SystemColors.Window
        Me._CboAppropriate_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._CboAppropriate_7.DropDownStyle = System.Windows.Forms.ComboBoxStyle.Simple
        Me._CboAppropriate_7.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CboAppropriate_7.ForeColor = System.Drawing.SystemColors.WindowText
        Me._CboAppropriate_7.Location = New System.Drawing.Point(138, 135)
        Me._CboAppropriate_7.Name = "_CboAppropriate_7"
        Me._CboAppropriate_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CboAppropriate_7.Size = New System.Drawing.Size(151, 21)
        Me._CboAppropriate_7.Sorted = True
        Me._CboAppropriate_7.TabIndex = 200
        Me._CboAppropriate_7.TabStop = False
        Me._CboAppropriate_7.Text = "CboAppropriate"
        '
        '_CmdOption_1
        '
        Me._CmdOption_1.BackColor = System.Drawing.SystemColors.Control
        Me._CmdOption_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._CmdOption_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CmdOption_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me._CmdOption_1.Location = New System.Drawing.Point(2, 16)
        Me._CmdOption_1.Name = "_CmdOption_1"
        Me._CmdOption_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CmdOption_1.Size = New System.Drawing.Size(134, 19)
        Me._CmdOption_1.TabIndex = 200
        Me._CmdOption_1.TabStop = False
        Me._CmdOption_1.Text = "Organs"
        Me._CmdOption_1.UseVisualStyleBackColor = False
        '
        '_CmdOption_2
        '
        Me._CmdOption_2.BackColor = System.Drawing.SystemColors.Control
        Me._CmdOption_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._CmdOption_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CmdOption_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me._CmdOption_2.Location = New System.Drawing.Point(2, 36)
        Me._CmdOption_2.Name = "_CmdOption_2"
        Me._CmdOption_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CmdOption_2.Size = New System.Drawing.Size(134, 19)
        Me._CmdOption_2.TabIndex = 200
        Me._CmdOption_2.TabStop = False
        Me._CmdOption_2.Text = "Bone"
        Me._CmdOption_2.UseVisualStyleBackColor = False
        '
        '_CmdOption_3
        '
        Me._CmdOption_3.BackColor = System.Drawing.SystemColors.Control
        Me._CmdOption_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._CmdOption_3.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CmdOption_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me._CmdOption_3.Location = New System.Drawing.Point(2, 56)
        Me._CmdOption_3.Name = "_CmdOption_3"
        Me._CmdOption_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CmdOption_3.Size = New System.Drawing.Size(134, 19)
        Me._CmdOption_3.TabIndex = 200
        Me._CmdOption_3.TabStop = False
        Me._CmdOption_3.Text = "Tissue"
        Me._CmdOption_3.UseVisualStyleBackColor = False
        '
        '_CmdOption_4
        '
        Me._CmdOption_4.BackColor = System.Drawing.SystemColors.Control
        Me._CmdOption_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._CmdOption_4.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CmdOption_4.ForeColor = System.Drawing.SystemColors.ControlText
        Me._CmdOption_4.Location = New System.Drawing.Point(2, 76)
        Me._CmdOption_4.Name = "_CmdOption_4"
        Me._CmdOption_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CmdOption_4.Size = New System.Drawing.Size(134, 19)
        Me._CmdOption_4.TabIndex = 200
        Me._CmdOption_4.TabStop = False
        Me._CmdOption_4.Text = "Skin"
        Me._CmdOption_4.UseVisualStyleBackColor = False
        '
        '_CmdOption_5
        '
        Me._CmdOption_5.BackColor = System.Drawing.SystemColors.Control
        Me._CmdOption_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._CmdOption_5.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CmdOption_5.ForeColor = System.Drawing.SystemColors.ControlText
        Me._CmdOption_5.Location = New System.Drawing.Point(2, 96)
        Me._CmdOption_5.Name = "_CmdOption_5"
        Me._CmdOption_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CmdOption_5.Size = New System.Drawing.Size(134, 19)
        Me._CmdOption_5.TabIndex = 200
        Me._CmdOption_5.TabStop = False
        Me._CmdOption_5.Text = "Valves"
        Me._CmdOption_5.UseVisualStyleBackColor = False
        '
        '_CmdOption_6
        '
        Me._CmdOption_6.BackColor = System.Drawing.SystemColors.Control
        Me._CmdOption_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._CmdOption_6.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CmdOption_6.ForeColor = System.Drawing.SystemColors.ControlText
        Me._CmdOption_6.Location = New System.Drawing.Point(2, 116)
        Me._CmdOption_6.Name = "_CmdOption_6"
        Me._CmdOption_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CmdOption_6.Size = New System.Drawing.Size(134, 19)
        Me._CmdOption_6.TabIndex = 200
        Me._CmdOption_6.TabStop = False
        Me._CmdOption_6.Text = "Eyes"
        Me._CmdOption_6.UseVisualStyleBackColor = False
        '
        '_CmdOption_7
        '
        Me._CmdOption_7.BackColor = System.Drawing.SystemColors.Control
        Me._CmdOption_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._CmdOption_7.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CmdOption_7.ForeColor = System.Drawing.SystemColors.ControlText
        Me._CmdOption_7.Location = New System.Drawing.Point(2, 136)
        Me._CmdOption_7.Name = "_CmdOption_7"
        Me._CmdOption_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CmdOption_7.Size = New System.Drawing.Size(134, 19)
        Me._CmdOption_7.TabIndex = 200
        Me._CmdOption_7.TabStop = False
        Me._CmdOption_7.Text = "Other"
        Me._CmdOption_7.UseVisualStyleBackColor = False
        '
        '_LblOption_0
        '
        Me._LblOption_0.AutoSize = True
        Me._LblOption_0.BackColor = System.Drawing.SystemColors.Control
        Me._LblOption_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblOption_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LblOption_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me._LblOption_0.Location = New System.Drawing.Point(138, 1)
        Me._LblOption_0.Name = "_LblOption_0"
        Me._LblOption_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblOption_0.Size = New System.Drawing.Size(64, 14)
        Me._LblOption_0.TabIndex = 200
        Me._LblOption_0.Text = "Appropriate"
        '
        'LblGive
        '
        Me.LblGive.BackColor = System.Drawing.SystemColors.Control
        Me.LblGive.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblGive.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblGive.ForeColor = System.Drawing.Color.Blue
        Me.LblGive.Location = New System.Drawing.Point(200, 1)
        Me.LblGive.Name = "LblGive"
        Me.LblGive.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblGive.Size = New System.Drawing.Size(69, 13)
        Me.LblGive.TabIndex = 200
        Me.LblGive.Text = "Give Options"
        Me.LblGive.Visible = False
        '
        'CmdNOK
        '
        Me.CmdNOK.BackColor = System.Drawing.SystemColors.Control
        Me.CmdNOK.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdNOK.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdNOK.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdNOK.Location = New System.Drawing.Point(333, 457)
        Me.CmdNOK.Name = "CmdNOK"
        Me.CmdNOK.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdNOK.Size = New System.Drawing.Size(80, 23)
        Me.CmdNOK.TabIndex = 36
        Me.CmdNOK.Text = "Next of Kin"
        Me.CmdNOK.UseVisualStyleBackColor = False
        '
        'TabDisposition
        '
        Me.TabDisposition.Controls.Add(Me._TabDisposition_TabPage0)
        Me.TabDisposition.Controls.Add(Me._TabDisposition_TabPage1)
        Me.TabDisposition.Controls.Add(Me._TabDisposition_TabPage2)
        Me.TabDisposition.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TabDisposition.ItemSize = New System.Drawing.Size(42, 18)
        Me.TabDisposition.Location = New System.Drawing.Point(439, 389)
        Me.TabDisposition.Margin = New System.Windows.Forms.Padding(3, 3, 3, 0)
        Me.TabDisposition.Name = "TabDisposition"
        Me.TabDisposition.SelectedIndex = 3
        Me.TabDisposition.Size = New System.Drawing.Size(453, 196)
        Me.TabDisposition.TabIndex = 39
        '
        '_TabDisposition_TabPage0
        '
        Me._TabDisposition_TabPage0.Controls.Add(Me._LblOption_3)
        Me._TabDisposition_TabPage0.Controls.Add(Me._LblOption_2)
        Me._TabDisposition_TabPage0.Controls.Add(Me._LblOption_1)
        Me._TabDisposition_TabPage0.Controls.Add(Me._CboApproach_7)
        Me._TabDisposition_TabPage0.Controls.Add(Me._CboRecovery_7)
        Me._TabDisposition_TabPage0.Controls.Add(Me._CboRecovery_6)
        Me._TabDisposition_TabPage0.Controls.Add(Me._CboRecovery_5)
        Me._TabDisposition_TabPage0.Controls.Add(Me._CboRecovery_4)
        Me._TabDisposition_TabPage0.Controls.Add(Me._CboRecovery_3)
        Me._TabDisposition_TabPage0.Controls.Add(Me._CboRecovery_2)
        Me._TabDisposition_TabPage0.Controls.Add(Me._CboConsent_7)
        Me._TabDisposition_TabPage0.Controls.Add(Me._CboConsent_6)
        Me._TabDisposition_TabPage0.Controls.Add(Me._CboConsent_5)
        Me._TabDisposition_TabPage0.Controls.Add(Me._CboConsent_4)
        Me._TabDisposition_TabPage0.Controls.Add(Me._CboConsent_3)
        Me._TabDisposition_TabPage0.Controls.Add(Me._CboConsent_2)
        Me._TabDisposition_TabPage0.Controls.Add(Me._CboApproach_6)
        Me._TabDisposition_TabPage0.Controls.Add(Me._CboApproach_5)
        Me._TabDisposition_TabPage0.Controls.Add(Me._CboApproach_4)
        Me._TabDisposition_TabPage0.Controls.Add(Me._CboApproach_3)
        Me._TabDisposition_TabPage0.Controls.Add(Me._CboApproach_2)
        Me._TabDisposition_TabPage0.Controls.Add(Me._CboRecovery_1)
        Me._TabDisposition_TabPage0.Controls.Add(Me._CboConsent_1)
        Me._TabDisposition_TabPage0.Controls.Add(Me._CboApproach_1)
        Me._TabDisposition_TabPage0.Location = New System.Drawing.Point(4, 22)
        Me._TabDisposition_TabPage0.Margin = New System.Windows.Forms.Padding(3, 3, 3, 0)
        Me._TabDisposition_TabPage0.Name = "_TabDisposition_TabPage0"
        Me._TabDisposition_TabPage0.Size = New System.Drawing.Size(445, 170)
        Me._TabDisposition_TabPage0.TabIndex = 200
        Me._TabDisposition_TabPage0.Text = "Disposition"
        '
        '_LblOption_3
        '
        Me._LblOption_3.BackColor = System.Drawing.SystemColors.Control
        Me._LblOption_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblOption_3.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LblOption_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me._LblOption_3.Location = New System.Drawing.Point(280, 13)
        Me._LblOption_3.Name = "_LblOption_3"
        Me._LblOption_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblOption_3.Size = New System.Drawing.Size(73, 15)
        Me._LblOption_3.TabIndex = 200
        Me._LblOption_3.Text = "Recovery"
        '
        '_LblOption_2
        '
        Me._LblOption_2.BackColor = System.Drawing.SystemColors.Control
        Me._LblOption_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblOption_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LblOption_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me._LblOption_2.Location = New System.Drawing.Point(144, 13)
        Me._LblOption_2.Name = "_LblOption_2"
        Me._LblOption_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblOption_2.Size = New System.Drawing.Size(73, 15)
        Me._LblOption_2.TabIndex = 200
        Me._LblOption_2.Text = "Consent"
        '
        '_LblOption_1
        '
        Me._LblOption_1.BackColor = System.Drawing.SystemColors.Control
        Me._LblOption_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblOption_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LblOption_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me._LblOption_1.Location = New System.Drawing.Point(8, 13)
        Me._LblOption_1.Name = "_LblOption_1"
        Me._LblOption_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblOption_1.Size = New System.Drawing.Size(73, 15)
        Me._LblOption_1.TabIndex = 200
        Me._LblOption_1.Text = "Approach"
        '
        '_CboApproach_7
        '
        Me._CboApproach_7.BackColor = System.Drawing.SystemColors.Window
        Me._CboApproach_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._CboApproach_7.DropDownStyle = System.Windows.Forms.ComboBoxStyle.Simple
        Me._CboApproach_7.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CboApproach_7.ForeColor = System.Drawing.SystemColors.WindowText
        Me._CboApproach_7.Location = New System.Drawing.Point(6, 150)
        Me._CboApproach_7.Name = "_CboApproach_7"
        Me._CboApproach_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CboApproach_7.Size = New System.Drawing.Size(137, 21)
        Me._CboApproach_7.TabIndex = 200
        Me._CboApproach_7.TabStop = False
        Me._CboApproach_7.Text = "CboApproach"
        '
        '_CboRecovery_7
        '
        Me._CboRecovery_7.BackColor = System.Drawing.SystemColors.Window
        Me._CboRecovery_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._CboRecovery_7.DropDownStyle = System.Windows.Forms.ComboBoxStyle.Simple
        Me._CboRecovery_7.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CboRecovery_7.ForeColor = System.Drawing.SystemColors.WindowText
        Me._CboRecovery_7.Location = New System.Drawing.Point(280, 150)
        Me._CboRecovery_7.Name = "_CboRecovery_7"
        Me._CboRecovery_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CboRecovery_7.Size = New System.Drawing.Size(135, 21)
        Me._CboRecovery_7.TabIndex = 200
        Me._CboRecovery_7.Text = "CboRecovery"
        '
        '_CboRecovery_6
        '
        Me._CboRecovery_6.BackColor = System.Drawing.SystemColors.Window
        Me._CboRecovery_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._CboRecovery_6.DropDownStyle = System.Windows.Forms.ComboBoxStyle.Simple
        Me._CboRecovery_6.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CboRecovery_6.ForeColor = System.Drawing.SystemColors.WindowText
        Me._CboRecovery_6.Location = New System.Drawing.Point(280, 129)
        Me._CboRecovery_6.Name = "_CboRecovery_6"
        Me._CboRecovery_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CboRecovery_6.Size = New System.Drawing.Size(135, 21)
        Me._CboRecovery_6.TabIndex = 200
        Me._CboRecovery_6.TabStop = False
        Me._CboRecovery_6.Text = "CboRecovery"
        '
        '_CboRecovery_5
        '
        Me._CboRecovery_5.BackColor = System.Drawing.SystemColors.Window
        Me._CboRecovery_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._CboRecovery_5.DropDownStyle = System.Windows.Forms.ComboBoxStyle.Simple
        Me._CboRecovery_5.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CboRecovery_5.ForeColor = System.Drawing.SystemColors.WindowText
        Me._CboRecovery_5.Location = New System.Drawing.Point(280, 109)
        Me._CboRecovery_5.Name = "_CboRecovery_5"
        Me._CboRecovery_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CboRecovery_5.Size = New System.Drawing.Size(135, 21)
        Me._CboRecovery_5.TabIndex = 200
        Me._CboRecovery_5.TabStop = False
        Me._CboRecovery_5.Text = "CboRecovery"
        '
        '_CboRecovery_4
        '
        Me._CboRecovery_4.BackColor = System.Drawing.SystemColors.Window
        Me._CboRecovery_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._CboRecovery_4.DropDownStyle = System.Windows.Forms.ComboBoxStyle.Simple
        Me._CboRecovery_4.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CboRecovery_4.ForeColor = System.Drawing.SystemColors.WindowText
        Me._CboRecovery_4.Location = New System.Drawing.Point(280, 89)
        Me._CboRecovery_4.Name = "_CboRecovery_4"
        Me._CboRecovery_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CboRecovery_4.Size = New System.Drawing.Size(135, 21)
        Me._CboRecovery_4.TabIndex = 200
        Me._CboRecovery_4.TabStop = False
        Me._CboRecovery_4.Text = "CboRecovery"
        '
        '_CboRecovery_3
        '
        Me._CboRecovery_3.BackColor = System.Drawing.SystemColors.Window
        Me._CboRecovery_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._CboRecovery_3.DropDownStyle = System.Windows.Forms.ComboBoxStyle.Simple
        Me._CboRecovery_3.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CboRecovery_3.ForeColor = System.Drawing.SystemColors.WindowText
        Me._CboRecovery_3.Location = New System.Drawing.Point(280, 69)
        Me._CboRecovery_3.Name = "_CboRecovery_3"
        Me._CboRecovery_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CboRecovery_3.Size = New System.Drawing.Size(135, 21)
        Me._CboRecovery_3.TabIndex = 200
        Me._CboRecovery_3.TabStop = False
        Me._CboRecovery_3.Text = "CboRecovery"
        '
        '_CboRecovery_2
        '
        Me._CboRecovery_2.BackColor = System.Drawing.SystemColors.Window
        Me._CboRecovery_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._CboRecovery_2.DropDownStyle = System.Windows.Forms.ComboBoxStyle.Simple
        Me._CboRecovery_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CboRecovery_2.ForeColor = System.Drawing.SystemColors.WindowText
        Me._CboRecovery_2.Location = New System.Drawing.Point(280, 49)
        Me._CboRecovery_2.Name = "_CboRecovery_2"
        Me._CboRecovery_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CboRecovery_2.Size = New System.Drawing.Size(135, 21)
        Me._CboRecovery_2.TabIndex = 200
        Me._CboRecovery_2.TabStop = False
        Me._CboRecovery_2.Text = "CboRecovery"
        '
        '_CboConsent_7
        '
        Me._CboConsent_7.BackColor = System.Drawing.SystemColors.Window
        Me._CboConsent_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._CboConsent_7.DropDownStyle = System.Windows.Forms.ComboBoxStyle.Simple
        Me._CboConsent_7.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CboConsent_7.ForeColor = System.Drawing.SystemColors.WindowText
        Me._CboConsent_7.Location = New System.Drawing.Point(144, 150)
        Me._CboConsent_7.Name = "_CboConsent_7"
        Me._CboConsent_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CboConsent_7.Size = New System.Drawing.Size(135, 21)
        Me._CboConsent_7.TabIndex = 200
        Me._CboConsent_7.TabStop = False
        Me._CboConsent_7.Text = "CboConsent"
        '
        '_CboConsent_6
        '
        Me._CboConsent_6.BackColor = System.Drawing.SystemColors.Window
        Me._CboConsent_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._CboConsent_6.DropDownStyle = System.Windows.Forms.ComboBoxStyle.Simple
        Me._CboConsent_6.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CboConsent_6.ForeColor = System.Drawing.SystemColors.WindowText
        Me._CboConsent_6.Location = New System.Drawing.Point(144, 129)
        Me._CboConsent_6.Name = "_CboConsent_6"
        Me._CboConsent_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CboConsent_6.Size = New System.Drawing.Size(135, 21)
        Me._CboConsent_6.TabIndex = 200
        Me._CboConsent_6.TabStop = False
        Me._CboConsent_6.Text = "CboConsent"
        '
        '_CboConsent_5
        '
        Me._CboConsent_5.BackColor = System.Drawing.SystemColors.Window
        Me._CboConsent_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._CboConsent_5.DropDownStyle = System.Windows.Forms.ComboBoxStyle.Simple
        Me._CboConsent_5.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CboConsent_5.ForeColor = System.Drawing.SystemColors.WindowText
        Me._CboConsent_5.Location = New System.Drawing.Point(144, 109)
        Me._CboConsent_5.Name = "_CboConsent_5"
        Me._CboConsent_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CboConsent_5.Size = New System.Drawing.Size(135, 21)
        Me._CboConsent_5.TabIndex = 200
        Me._CboConsent_5.TabStop = False
        Me._CboConsent_5.Text = "CboConsent"
        '
        '_CboConsent_4
        '
        Me._CboConsent_4.BackColor = System.Drawing.SystemColors.Window
        Me._CboConsent_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._CboConsent_4.DropDownStyle = System.Windows.Forms.ComboBoxStyle.Simple
        Me._CboConsent_4.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CboConsent_4.ForeColor = System.Drawing.SystemColors.WindowText
        Me._CboConsent_4.Location = New System.Drawing.Point(144, 89)
        Me._CboConsent_4.Name = "_CboConsent_4"
        Me._CboConsent_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CboConsent_4.Size = New System.Drawing.Size(135, 21)
        Me._CboConsent_4.TabIndex = 200
        Me._CboConsent_4.TabStop = False
        Me._CboConsent_4.Text = "CboConsent"
        '
        '_CboConsent_3
        '
        Me._CboConsent_3.BackColor = System.Drawing.SystemColors.Window
        Me._CboConsent_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._CboConsent_3.DropDownStyle = System.Windows.Forms.ComboBoxStyle.Simple
        Me._CboConsent_3.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CboConsent_3.ForeColor = System.Drawing.SystemColors.WindowText
        Me._CboConsent_3.Location = New System.Drawing.Point(144, 69)
        Me._CboConsent_3.Name = "_CboConsent_3"
        Me._CboConsent_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CboConsent_3.Size = New System.Drawing.Size(135, 21)
        Me._CboConsent_3.TabIndex = 200
        Me._CboConsent_3.TabStop = False
        Me._CboConsent_3.Text = "CboConsent"
        '
        '_CboConsent_2
        '
        Me._CboConsent_2.BackColor = System.Drawing.SystemColors.Window
        Me._CboConsent_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._CboConsent_2.DropDownStyle = System.Windows.Forms.ComboBoxStyle.Simple
        Me._CboConsent_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CboConsent_2.ForeColor = System.Drawing.SystemColors.WindowText
        Me._CboConsent_2.Location = New System.Drawing.Point(144, 49)
        Me._CboConsent_2.Name = "_CboConsent_2"
        Me._CboConsent_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CboConsent_2.Size = New System.Drawing.Size(135, 21)
        Me._CboConsent_2.TabIndex = 200
        Me._CboConsent_2.TabStop = False
        Me._CboConsent_2.Text = "CboConsent"
        '
        '_CboApproach_6
        '
        Me._CboApproach_6.BackColor = System.Drawing.SystemColors.Window
        Me._CboApproach_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._CboApproach_6.DropDownStyle = System.Windows.Forms.ComboBoxStyle.Simple
        Me._CboApproach_6.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CboApproach_6.ForeColor = System.Drawing.SystemColors.WindowText
        Me._CboApproach_6.Location = New System.Drawing.Point(6, 129)
        Me._CboApproach_6.Name = "_CboApproach_6"
        Me._CboApproach_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CboApproach_6.Size = New System.Drawing.Size(137, 21)
        Me._CboApproach_6.TabIndex = 200
        Me._CboApproach_6.TabStop = False
        Me._CboApproach_6.Text = "CboApproach"
        '
        '_CboApproach_5
        '
        Me._CboApproach_5.BackColor = System.Drawing.SystemColors.Window
        Me._CboApproach_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._CboApproach_5.DropDownStyle = System.Windows.Forms.ComboBoxStyle.Simple
        Me._CboApproach_5.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CboApproach_5.ForeColor = System.Drawing.SystemColors.WindowText
        Me._CboApproach_5.Location = New System.Drawing.Point(6, 109)
        Me._CboApproach_5.Name = "_CboApproach_5"
        Me._CboApproach_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CboApproach_5.Size = New System.Drawing.Size(137, 21)
        Me._CboApproach_5.TabIndex = 200
        Me._CboApproach_5.TabStop = False
        Me._CboApproach_5.Text = "CboApproach"
        '
        '_CboApproach_4
        '
        Me._CboApproach_4.BackColor = System.Drawing.SystemColors.Window
        Me._CboApproach_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._CboApproach_4.DropDownStyle = System.Windows.Forms.ComboBoxStyle.Simple
        Me._CboApproach_4.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CboApproach_4.ForeColor = System.Drawing.SystemColors.WindowText
        Me._CboApproach_4.Location = New System.Drawing.Point(6, 89)
        Me._CboApproach_4.Name = "_CboApproach_4"
        Me._CboApproach_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CboApproach_4.Size = New System.Drawing.Size(137, 21)
        Me._CboApproach_4.TabIndex = 200
        Me._CboApproach_4.TabStop = False
        Me._CboApproach_4.Text = "CboApproach"
        '
        '_CboApproach_3
        '
        Me._CboApproach_3.BackColor = System.Drawing.SystemColors.Window
        Me._CboApproach_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._CboApproach_3.DropDownStyle = System.Windows.Forms.ComboBoxStyle.Simple
        Me._CboApproach_3.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CboApproach_3.ForeColor = System.Drawing.SystemColors.WindowText
        Me._CboApproach_3.Location = New System.Drawing.Point(6, 69)
        Me._CboApproach_3.Name = "_CboApproach_3"
        Me._CboApproach_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CboApproach_3.Size = New System.Drawing.Size(137, 21)
        Me._CboApproach_3.TabIndex = 200
        Me._CboApproach_3.TabStop = False
        Me._CboApproach_3.Text = "CboApproach"
        '
        '_CboApproach_2
        '
        Me._CboApproach_2.BackColor = System.Drawing.SystemColors.Window
        Me._CboApproach_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._CboApproach_2.DropDownStyle = System.Windows.Forms.ComboBoxStyle.Simple
        Me._CboApproach_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CboApproach_2.ForeColor = System.Drawing.SystemColors.WindowText
        Me._CboApproach_2.Location = New System.Drawing.Point(6, 49)
        Me._CboApproach_2.Name = "_CboApproach_2"
        Me._CboApproach_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CboApproach_2.Size = New System.Drawing.Size(137, 21)
        Me._CboApproach_2.TabIndex = 200
        Me._CboApproach_2.TabStop = False
        Me._CboApproach_2.Text = "CboApproach"
        '
        '_CboRecovery_1
        '
        Me._CboRecovery_1.BackColor = System.Drawing.SystemColors.Window
        Me._CboRecovery_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._CboRecovery_1.DropDownStyle = System.Windows.Forms.ComboBoxStyle.Simple
        Me._CboRecovery_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CboRecovery_1.ForeColor = System.Drawing.SystemColors.WindowText
        Me._CboRecovery_1.Location = New System.Drawing.Point(280, 29)
        Me._CboRecovery_1.Name = "_CboRecovery_1"
        Me._CboRecovery_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CboRecovery_1.Size = New System.Drawing.Size(135, 21)
        Me._CboRecovery_1.TabIndex = 200
        Me._CboRecovery_1.TabStop = False
        Me._CboRecovery_1.Text = "CboRecovery"
        '
        '_CboConsent_1
        '
        Me._CboConsent_1.BackColor = System.Drawing.SystemColors.Window
        Me._CboConsent_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._CboConsent_1.DropDownStyle = System.Windows.Forms.ComboBoxStyle.Simple
        Me._CboConsent_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CboConsent_1.ForeColor = System.Drawing.SystemColors.WindowText
        Me._CboConsent_1.Location = New System.Drawing.Point(144, 29)
        Me._CboConsent_1.Name = "_CboConsent_1"
        Me._CboConsent_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CboConsent_1.Size = New System.Drawing.Size(135, 21)
        Me._CboConsent_1.TabIndex = 200
        Me._CboConsent_1.TabStop = False
        Me._CboConsent_1.Text = "CboConsent"
        '
        '_CboApproach_1
        '
        Me._CboApproach_1.BackColor = System.Drawing.SystemColors.Window
        Me._CboApproach_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._CboApproach_1.DropDownStyle = System.Windows.Forms.ComboBoxStyle.Simple
        Me._CboApproach_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CboApproach_1.ForeColor = System.Drawing.SystemColors.WindowText
        Me._CboApproach_1.Location = New System.Drawing.Point(6, 29)
        Me._CboApproach_1.Name = "_CboApproach_1"
        Me._CboApproach_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CboApproach_1.Size = New System.Drawing.Size(137, 21)
        Me._CboApproach_1.TabIndex = 200
        Me._CboApproach_1.TabStop = False
        Me._CboApproach_1.Text = "CboApproach"
        '
        '_TabDisposition_TabPage1
        '
        Me._TabDisposition_TabPage1.Controls.Add(Me.TxtConditional)
        Me._TabDisposition_TabPage1.Controls.Add(Me.LstViewVerify)
        Me._TabDisposition_TabPage1.Location = New System.Drawing.Point(4, 22)
        Me._TabDisposition_TabPage1.Name = "_TabDisposition_TabPage1"
        Me._TabDisposition_TabPage1.Size = New System.Drawing.Size(445, 170)
        Me._TabDisposition_TabPage1.TabIndex = 200
        Me._TabDisposition_TabPage1.Text = "Results"
        '
        'TxtConditional
        '
        Me.TxtConditional.BackColor = System.Drawing.SystemColors.Window
        Me.TxtConditional.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtConditional.Location = New System.Drawing.Point(172, 5)
        Me.TxtConditional.Name = "TxtConditional"
        Me.TxtConditional.ReadOnly = True
        Me.TxtConditional.RightMargin = 254
        Me.TxtConditional.Size = New System.Drawing.Size(268, 160)
        Me.TxtConditional.TabIndex = 200
        Me.TxtConditional.TabStop = False
        Me.TxtConditional.Text = ""
        '
        'LstViewVerify
        '
        Me.LstViewVerify.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewVerify.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.LstViewVerify.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewVerify.ForeColor = System.Drawing.Color.Black
        Me.LstViewVerify.FullRowSelect = True
        Me.LstViewVerify.HideSelection = False
        Me.LstViewVerify.ImeMode = System.Windows.Forms.ImeMode.NoControl
        Me.LstViewVerify.LabelWrap = False
        Me.LstViewVerify.Location = New System.Drawing.Point(5, 5)
        Me.LstViewVerify.Name = "LstViewVerify"
        Me.LstViewVerify.Size = New System.Drawing.Size(161, 160)
        Me.LstViewVerify.TabIndex = 200
        Me.LstViewVerify.TabStop = False
        Me.LstViewVerify.UseCompatibleStateImageBehavior = False
        Me.LstViewVerify.View = System.Windows.Forms.View.Details
        '
        '_TabDisposition_TabPage2
        '
        Me._TabDisposition_TabPage2.Controls.Add(Me._Lable_37)
        Me._TabDisposition_TabPage2.Controls.Add(Me.LblCoronerMsg)
        Me._TabDisposition_TabPage2.Controls.Add(Me._Lable_30)
        Me._TabDisposition_TabPage2.Controls.Add(Me._Lable_29)
        Me._TabDisposition_TabPage2.Controls.Add(Me._Lable_28)
        Me._TabDisposition_TabPage2.Controls.Add(Me._Lable_27)
        Me._TabDisposition_TabPage2.Controls.Add(Me.CmdCoronerName)
        Me._TabDisposition_TabPage2.Controls.Add(Me.CboCoronerName)
        Me._TabDisposition_TabPage2.Controls.Add(Me.CboState)
        Me._TabDisposition_TabPage2.Controls.Add(Me.CmdCoronerDetail)
        Me._TabDisposition_TabPage2.Controls.Add(Me.CmdContactCoroner)
        Me._TabDisposition_TabPage2.Controls.Add(Me.CboCoronerOrg)
        Me._TabDisposition_TabPage2.Controls.Add(Me.TxtCoronerPhone)
        Me._TabDisposition_TabPage2.Controls.Add(Me.TxtCoronerNote)
        Me._TabDisposition_TabPage2.Controls.Add(Me.ChkCoronerCase)
        Me._TabDisposition_TabPage2.Location = New System.Drawing.Point(4, 22)
        Me._TabDisposition_TabPage2.Name = "_TabDisposition_TabPage2"
        Me._TabDisposition_TabPage2.Size = New System.Drawing.Size(445, 170)
        Me._TabDisposition_TabPage2.TabIndex = 200
        Me._TabDisposition_TabPage2.Text = "Coroner/ME"
        '
        '_Lable_37
        '
        Me._Lable_37.AutoSize = True
        Me._Lable_37.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_37.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_37.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_37.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Lable_37.Location = New System.Drawing.Point(13, 44)
        Me._Lable_37.Name = "_Lable_37"
        Me._Lable_37.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_37.Size = New System.Drawing.Size(32, 14)
        Me._Lable_37.TabIndex = 200
        Me._Lable_37.Text = "State"
        '
        'LblCoronerMsg
        '
        Me.LblCoronerMsg.BackColor = System.Drawing.SystemColors.Control
        Me.LblCoronerMsg.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblCoronerMsg.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblCoronerMsg.ForeColor = System.Drawing.Color.Red
        Me.LblCoronerMsg.Location = New System.Drawing.Point(123, 17)
        Me.LblCoronerMsg.Name = "LblCoronerMsg"
        Me.LblCoronerMsg.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblCoronerMsg.Size = New System.Drawing.Size(295, 13)
        Me.LblCoronerMsg.TabIndex = 200
        Me.LblCoronerMsg.Text = "This referral is a potential Coroner/ME case. Please ask caller."
        Me.LblCoronerMsg.Visible = False
        '
        '_Lable_30
        '
        Me._Lable_30.AutoSize = True
        Me._Lable_30.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_30.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_30.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_30.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Lable_30.Location = New System.Drawing.Point(13, 66)
        Me._Lable_30.Name = "_Lable_30"
        Me._Lable_30.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_30.Size = New System.Drawing.Size(68, 14)
        Me._Lable_30.TabIndex = 200
        Me._Lable_30.Text = "Organization"
        '
        '_Lable_29
        '
        Me._Lable_29.AutoSize = True
        Me._Lable_29.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_29.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_29.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_29.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Lable_29.Location = New System.Drawing.Point(13, 88)
        Me._Lable_29.Name = "_Lable_29"
        Me._Lable_29.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_29.Size = New System.Drawing.Size(34, 14)
        Me._Lable_29.TabIndex = 200
        Me._Lable_29.Text = "Name"
        '
        '_Lable_28
        '
        Me._Lable_28.AutoSize = True
        Me._Lable_28.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_28.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_28.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_28.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Lable_28.Location = New System.Drawing.Point(233, 90)
        Me._Lable_28.Name = "_Lable_28"
        Me._Lable_28.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_28.Size = New System.Drawing.Size(37, 14)
        Me._Lable_28.TabIndex = 200
        Me._Lable_28.Text = "Phone"
        '
        '_Lable_27
        '
        Me._Lable_27.AutoSize = True
        Me._Lable_27.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_27.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_27.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_27.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Lable_27.Location = New System.Drawing.Point(13, 112)
        Me._Lable_27.Name = "_Lable_27"
        Me._Lable_27.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_27.Size = New System.Drawing.Size(29, 14)
        Me._Lable_27.TabIndex = 200
        Me._Lable_27.Text = "Note"
        '
        'CmdCoronerName
        '
        Me.CmdCoronerName.BackColor = System.Drawing.SystemColors.Control
        Me.CmdCoronerName.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdCoronerName.Enabled = False
        Me.CmdCoronerName.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdCoronerName.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdCoronerName.Location = New System.Drawing.Point(209, 86)
        Me.CmdCoronerName.Name = "CmdCoronerName"
        Me.CmdCoronerName.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdCoronerName.Size = New System.Drawing.Size(17, 21)
        Me.CmdCoronerName.TabIndex = 14
        Me.CmdCoronerName.Text = "..."
        Me.CmdCoronerName.UseVisualStyleBackColor = False
        '
        'CboCoronerName
        '
        Me.CboCoronerName.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboCoronerName.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboCoronerName.BackColor = System.Drawing.SystemColors.Window
        Me.CboCoronerName.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboCoronerName.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboCoronerName.Enabled = False
        Me.CboCoronerName.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboCoronerName.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboCoronerName.Location = New System.Drawing.Point(83, 86)
        Me.CboCoronerName.Name = "CboCoronerName"
        Me.CboCoronerName.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboCoronerName.Size = New System.Drawing.Size(121, 22)
        Me.CboCoronerName.Sorted = True
        Me.CboCoronerName.TabIndex = 12
        '
        'CboState
        '
        Me.CboState.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboState.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboState.BackColor = System.Drawing.SystemColors.Window
        Me.CboState.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboState.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboState.Enabled = False
        Me.CboState.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboState.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboState.Location = New System.Drawing.Point(83, 38)
        Me.CboState.Name = "CboState"
        Me.CboState.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboState.Size = New System.Drawing.Size(57, 22)
        Me.CboState.Sorted = True
        Me.CboState.TabIndex = 4
        '
        'CmdCoronerDetail
        '
        Me.CmdCoronerDetail.BackColor = System.Drawing.SystemColors.Control
        Me.CmdCoronerDetail.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdCoronerDetail.Enabled = False
        Me.CmdCoronerDetail.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdCoronerDetail.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdCoronerDetail.Location = New System.Drawing.Point(371, 62)
        Me.CmdCoronerDetail.Name = "CmdCoronerDetail"
        Me.CmdCoronerDetail.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdCoronerDetail.Size = New System.Drawing.Size(17, 21)
        Me.CmdCoronerDetail.TabIndex = 10
        Me.CmdCoronerDetail.Text = "..."
        Me.CmdCoronerDetail.UseVisualStyleBackColor = False
        '
        'CmdContactCoroner
        '
        Me.CmdContactCoroner.BackColor = System.Drawing.SystemColors.Control
        Me.CmdContactCoroner.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdContactCoroner.Enabled = False
        Me.CmdContactCoroner.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdContactCoroner.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdContactCoroner.Location = New System.Drawing.Point(305, 36)
        Me.CmdContactCoroner.Name = "CmdContactCoroner"
        Me.CmdContactCoroner.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdContactCoroner.Size = New System.Drawing.Size(59, 21)
        Me.CmdContactCoroner.TabIndex = 6
        Me.CmdContactCoroner.Text = "Contact..."
        Me.CmdContactCoroner.UseVisualStyleBackColor = False
        Me.CmdContactCoroner.Visible = False
        '
        'CboCoronerOrg
        '
        Me.CboCoronerOrg.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboCoronerOrg.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboCoronerOrg.BackColor = System.Drawing.SystemColors.Window
        Me.CboCoronerOrg.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboCoronerOrg.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboCoronerOrg.Enabled = False
        Me.CboCoronerOrg.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboCoronerOrg.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboCoronerOrg.Location = New System.Drawing.Point(83, 62)
        Me.CboCoronerOrg.Name = "CboCoronerOrg"
        Me.CboCoronerOrg.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboCoronerOrg.Size = New System.Drawing.Size(283, 22)
        Me.CboCoronerOrg.Sorted = True
        Me.CboCoronerOrg.TabIndex = 8
        '
        'TxtCoronerPhone
        '
        Me.TxtCoronerPhone.AcceptsReturn = True
        Me.TxtCoronerPhone.BackColor = System.Drawing.Color.White
        Me.TxtCoronerPhone.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtCoronerPhone.Enabled = False
        Me.TxtCoronerPhone.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtCoronerPhone.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtCoronerPhone.Location = New System.Drawing.Point(269, 86)
        Me.TxtCoronerPhone.MaxLength = 0
        Me.TxtCoronerPhone.Name = "TxtCoronerPhone"
        Me.TxtCoronerPhone.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtCoronerPhone.Size = New System.Drawing.Size(97, 20)
        Me.TxtCoronerPhone.TabIndex = 16
        '
        'TxtCoronerNote
        '
        Me.TxtCoronerNote.AcceptsReturn = True
        Me.TxtCoronerNote.BackColor = System.Drawing.Color.White
        Me.TxtCoronerNote.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtCoronerNote.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtCoronerNote.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtCoronerNote.Location = New System.Drawing.Point(83, 110)
        Me.TxtCoronerNote.MaxLength = 254
        Me.TxtCoronerNote.Multiline = True
        Me.TxtCoronerNote.Name = "TxtCoronerNote"
        Me.TxtCoronerNote.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtCoronerNote.ScrollBars = System.Windows.Forms.ScrollBars.Vertical
        Me.TxtCoronerNote.Size = New System.Drawing.Size(283, 55)
        Me.TxtCoronerNote.TabIndex = 18
        '
        'ChkCoronerCase
        '
        Me.ChkCoronerCase.BackColor = System.Drawing.Color.FromArgb(CType(CType(192, Byte), Integer), CType(CType(192, Byte), Integer), CType(CType(192, Byte), Integer))
        Me.ChkCoronerCase.CheckAlign = System.Drawing.ContentAlignment.MiddleRight
        Me.ChkCoronerCase.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkCoronerCase.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkCoronerCase.ForeColor = System.Drawing.Color.Black
        Me.ChkCoronerCase.Location = New System.Drawing.Point(11, 4)
        Me.ChkCoronerCase.Name = "ChkCoronerCase"
        Me.ChkCoronerCase.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkCoronerCase.Size = New System.Drawing.Size(88, 32)
        Me.ChkCoronerCase.TabIndex = 2
        Me.ChkCoronerCase.Text = "Coroner Case"
        Me.ChkCoronerCase.UseVisualStyleBackColor = False
        '
        '_Frame_5
        '
        Me._Frame_5.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_5.Controls.Add(Me._CmdPhysicianPhone_1)
        Me._Frame_5.Controls.Add(Me.TxtPronouncingPhone)
        Me._Frame_5.Controls.Add(Me.TxtAttendingPhone)
        Me._Frame_5.Controls.Add(Me._CmdPhysicianPhone_0)
        Me._Frame_5.Controls.Add(Me._CboPhysician_0)
        Me._Frame_5.Controls.Add(Me._CboPhysician_1)
        Me._Frame_5.Controls.Add(Me._CmdPhysicianDetail_0)
        Me._Frame_5.Controls.Add(Me._CmdPhysicianDetail_1)
        Me._Frame_5.Controls.Add(Me._LblPhysician_0)
        Me._Frame_5.Controls.Add(Me._LblPhysician_1)
        Me._Frame_5.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_5.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Frame_5.Location = New System.Drawing.Point(10, 370)
        Me._Frame_5.Name = "_Frame_5"
        Me._Frame_5.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_5.Size = New System.Drawing.Size(423, 57)
        Me._Frame_5.TabIndex = 3
        Me._Frame_5.TabStop = False
        '
        '_CmdPhysicianPhone_1
        '
        Me._CmdPhysicianPhone_1.BackColor = System.Drawing.SystemColors.Control
        Me._CmdPhysicianPhone_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._CmdPhysicianPhone_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CmdPhysicianPhone_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me._CmdPhysicianPhone_1.Location = New System.Drawing.Point(291, 33)
        Me._CmdPhysicianPhone_1.Name = "_CmdPhysicianPhone_1"
        Me._CmdPhysicianPhone_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CmdPhysicianPhone_1.Size = New System.Drawing.Size(45, 20)
        Me._CmdPhysicianPhone_1.TabIndex = 39
        Me._CmdPhysicianPhone_1.Text = "Phone"
        Me._CmdPhysicianPhone_1.UseVisualStyleBackColor = False
        '
        'TxtPronouncingPhone
        '
        Me.TxtPronouncingPhone.AcceptsReturn = True
        Me.TxtPronouncingPhone.BackColor = System.Drawing.SystemColors.Control
        Me.TxtPronouncingPhone.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtPronouncingPhone.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtPronouncingPhone.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtPronouncingPhone.Location = New System.Drawing.Point(336, 33)
        Me.TxtPronouncingPhone.MaxLength = 0
        Me.TxtPronouncingPhone.Name = "TxtPronouncingPhone"
        Me.TxtPronouncingPhone.ReadOnly = True
        Me.TxtPronouncingPhone.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtPronouncingPhone.Size = New System.Drawing.Size(83, 20)
        Me.TxtPronouncingPhone.TabIndex = 200
        Me.TxtPronouncingPhone.TabStop = False
        '
        'TxtAttendingPhone
        '
        Me.TxtAttendingPhone.AcceptsReturn = True
        Me.TxtAttendingPhone.BackColor = System.Drawing.SystemColors.Control
        Me.TxtAttendingPhone.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtAttendingPhone.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtAttendingPhone.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtAttendingPhone.Location = New System.Drawing.Point(336, 9)
        Me.TxtAttendingPhone.MaxLength = 0
        Me.TxtAttendingPhone.Name = "TxtAttendingPhone"
        Me.TxtAttendingPhone.ReadOnly = True
        Me.TxtAttendingPhone.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtAttendingPhone.Size = New System.Drawing.Size(83, 20)
        Me.TxtAttendingPhone.TabIndex = 200
        Me.TxtAttendingPhone.TabStop = False
        '
        '_CmdPhysicianPhone_0
        '
        Me._CmdPhysicianPhone_0.BackColor = System.Drawing.SystemColors.Control
        Me._CmdPhysicianPhone_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._CmdPhysicianPhone_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CmdPhysicianPhone_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me._CmdPhysicianPhone_0.Location = New System.Drawing.Point(291, 9)
        Me._CmdPhysicianPhone_0.Name = "_CmdPhysicianPhone_0"
        Me._CmdPhysicianPhone_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CmdPhysicianPhone_0.Size = New System.Drawing.Size(45, 20)
        Me._CmdPhysicianPhone_0.TabIndex = 35
        Me._CmdPhysicianPhone_0.Text = "Phone"
        Me._CmdPhysicianPhone_0.UseVisualStyleBackColor = False
        '
        '_CboPhysician_0
        '
        Me._CboPhysician_0.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me._CboPhysician_0.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me._CboPhysician_0.BackColor = System.Drawing.SystemColors.Menu
        Me._CboPhysician_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._CboPhysician_0.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._CboPhysician_0.Enabled = False
        Me._CboPhysician_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CboPhysician_0.ForeColor = System.Drawing.SystemColors.WindowText
        Me._CboPhysician_0.Location = New System.Drawing.Point(109, 8)
        Me._CboPhysician_0.Name = "_CboPhysician_0"
        Me._CboPhysician_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CboPhysician_0.Size = New System.Drawing.Size(157, 22)
        Me._CboPhysician_0.Sorted = True
        Me._CboPhysician_0.TabIndex = 33
        '
        '_CboPhysician_1
        '
        Me._CboPhysician_1.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me._CboPhysician_1.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me._CboPhysician_1.BackColor = System.Drawing.SystemColors.Menu
        Me._CboPhysician_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._CboPhysician_1.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._CboPhysician_1.Enabled = False
        Me._CboPhysician_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CboPhysician_1.ForeColor = System.Drawing.SystemColors.WindowText
        Me._CboPhysician_1.Location = New System.Drawing.Point(109, 32)
        Me._CboPhysician_1.Name = "_CboPhysician_1"
        Me._CboPhysician_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CboPhysician_1.Size = New System.Drawing.Size(157, 22)
        Me._CboPhysician_1.Sorted = True
        Me._CboPhysician_1.TabIndex = 36
        '
        '_CmdPhysicianDetail_0
        '
        Me._CmdPhysicianDetail_0.BackColor = System.Drawing.SystemColors.Control
        Me._CmdPhysicianDetail_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._CmdPhysicianDetail_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CmdPhysicianDetail_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me._CmdPhysicianDetail_0.Location = New System.Drawing.Point(267, 9)
        Me._CmdPhysicianDetail_0.Margin = New System.Windows.Forms.Padding(0)
        Me._CmdPhysicianDetail_0.Name = "_CmdPhysicianDetail_0"
        Me._CmdPhysicianDetail_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CmdPhysicianDetail_0.Size = New System.Drawing.Size(24, 20)
        Me._CmdPhysicianDetail_0.TabIndex = 34
        Me._CmdPhysicianDetail_0.Text = "..."
        Me._CmdPhysicianDetail_0.UseVisualStyleBackColor = False
        '
        '_CmdPhysicianDetail_1
        '
        Me._CmdPhysicianDetail_1.BackColor = System.Drawing.SystemColors.Control
        Me._CmdPhysicianDetail_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._CmdPhysicianDetail_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._CmdPhysicianDetail_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me._CmdPhysicianDetail_1.Location = New System.Drawing.Point(267, 33)
        Me._CmdPhysicianDetail_1.Margin = New System.Windows.Forms.Padding(0)
        Me._CmdPhysicianDetail_1.Name = "_CmdPhysicianDetail_1"
        Me._CmdPhysicianDetail_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CmdPhysicianDetail_1.Size = New System.Drawing.Size(24, 20)
        Me._CmdPhysicianDetail_1.TabIndex = 37
        Me._CmdPhysicianDetail_1.Text = "..."
        Me._CmdPhysicianDetail_1.UseVisualStyleBackColor = False
        '
        '_LblPhysician_0
        '
        Me._LblPhysician_0.AutoSize = True
        Me._LblPhysician_0.BackColor = System.Drawing.SystemColors.Control
        Me._LblPhysician_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblPhysician_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LblPhysician_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me._LblPhysician_0.Location = New System.Drawing.Point(60, 12)
        Me._LblPhysician_0.Name = "_LblPhysician_0"
        Me._LblPhysician_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblPhysician_0.Size = New System.Drawing.Size(53, 14)
        Me._LblPhysician_0.TabIndex = 200
        Me._LblPhysician_0.Text = "Attending"
        '
        '_LblPhysician_1
        '
        Me._LblPhysician_1.AutoSize = True
        Me._LblPhysician_1.BackColor = System.Drawing.SystemColors.Control
        Me._LblPhysician_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblPhysician_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LblPhysician_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me._LblPhysician_1.Location = New System.Drawing.Point(46, 36)
        Me._LblPhysician_1.Name = "_LblPhysician_1"
        Me._LblPhysician_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblPhysician_1.Size = New System.Drawing.Size(67, 14)
        Me._LblPhysician_1.TabIndex = 200
        Me._LblPhysician_1.Text = "Pronouncing"
        '
        '_Frame_4
        '
        Me._Frame_4.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_4.Controls.Add(Me.rtbSearching)
        Me._Frame_4.Controls.Add(Me.TxtLSATime)
        Me._Frame_4.Controls.Add(Me.TxtLSADate)
        Me._Frame_4.Controls.Add(Me.LblLSA)
        Me._Frame_4.Controls.Add(Me.TxtDOB)
        Me._Frame_4.Controls.Add(Me.TxtRecNum)
        Me._Frame_4.Controls.Add(Me.TxtDeathTime)
        Me._Frame_4.Controls.Add(Me.TxtDeathDate)
        Me._Frame_4.Controls.Add(Me.TxtDonorLastName)
        Me._Frame_4.Controls.Add(Me.CboRace)
        Me._Frame_4.Controls.Add(Me.TxtAdmitTime)
        Me._Frame_4.Controls.Add(Me.TxtAdmitDate)
        Me._Frame_4.Controls.Add(Me.CboHeartBeat)
        Me._Frame_4.Controls.Add(Me.ChkDOB)
        Me._Frame_4.Controls.Add(Me.TxtBrainDeathDate)
        Me._Frame_4.Controls.Add(Me.TxtBrainDeathTime)
        Me._Frame_4.Controls.Add(Me.CmdDirectionsNote)
        Me._Frame_4.Controls.Add(Me.TxtDonorMI)
        Me._Frame_4.Controls.Add(Me.TxtExtubated)
        Me._Frame_4.Controls.Add(Me.TxtSSN)
        Me._Frame_4.Controls.Add(Me.ChkDOA)
        Me._Frame_4.Controls.Add(Me._Picture_0)
        Me._Frame_4.Controls.Add(Me.CboVent)
        Me._Frame_4.Controls.Add(Me.TxtWeight)
        Me._Frame_4.Controls.Add(Me.CboGender)
        Me._Frame_4.Controls.Add(Me.CboAgeUnit)
        Me._Frame_4.Controls.Add(Me.TxtAge)
        Me._Frame_4.Controls.Add(Me.TxtDonorFirstName)
        Me._Frame_4.Controls.Add(Me.CmdRegMatch)
        Me._Frame_4.Controls.Add(Me._Lable_17)
        Me._Frame_4.Controls.Add(Me._Lable_15)
        Me._Frame_4.Controls.Add(Me._Lable_5)
        Me._Frame_4.Controls.Add(Me.LblCardiacDate)
        Me._Frame_4.Controls.Add(Me.LblRegistry)
        Me._Frame_4.Controls.Add(Me._Lable_33)
        Me._Frame_4.Controls.Add(Me._Lable_31)
        Me._Frame_4.Controls.Add(Me._Lable_12)
        Me._Frame_4.Controls.Add(Me._Lable_14)
        Me._Frame_4.Controls.Add(Me._Lable_10)
        Me._Frame_4.Controls.Add(Me._Lable_8)
        Me._Frame_4.Controls.Add(Me._Lable_11)
        Me._Frame_4.Controls.Add(Me._Lable_9)
        Me._Frame_4.Controls.Add(Me._Lable_7)
        Me._Frame_4.Controls.Add(Me._Lable_6)
        Me._Frame_4.Controls.Add(Me._Lable_16)
        Me._Frame_4.Controls.Add(Me.LblWeight)
        Me._Frame_4.Controls.Add(Me.LblDOB_ILB)
        Me._Frame_4.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_4.ForeColor = System.Drawing.Color.Black
        Me._Frame_4.Location = New System.Drawing.Point(10, 5)
        Me._Frame_4.Margin = New System.Windows.Forms.Padding(1)
        Me._Frame_4.Name = "_Frame_4"
        Me._Frame_4.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_4.Size = New System.Drawing.Size(424, 179)
        Me._Frame_4.TabIndex = 0
        Me._Frame_4.TabStop = False
        '
        'rtbSearching
        '
        Me.rtbSearching.BackColor = System.Drawing.SystemColors.Control
        Me.rtbSearching.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.rtbSearching.Enabled = False
        Me.rtbSearching.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Italic, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.rtbSearching.ForeColor = System.Drawing.Color.Blue
        Me.rtbSearching.Location = New System.Drawing.Point(227, 139)
        Me.rtbSearching.Name = "rtbSearching"
        Me.rtbSearching.Required = False
        Me.rtbSearching.Size = New System.Drawing.Size(70, 18)
        Me.rtbSearching.SpellCheckEnabled = False
        Me.rtbSearching.TabIndex = 205
        Me.rtbSearching.Text = "Searching..."
        Me.rtbSearching.Visible = False
        '
        'TxtLSATime
        '
        Me.TxtLSATime.Location = New System.Drawing.Point(368, 116)
        Me.TxtLSATime.Margin = New System.Windows.Forms.Padding(1)
        Me.TxtLSATime.Name = "TxtLSATime"
        Me.TxtLSATime.Size = New System.Drawing.Size(50, 20)
        Me.TxtLSATime.TabIndex = 18
        '
        'TxtLSADate
        '
        Me.TxtLSADate.Location = New System.Drawing.Point(312, 116)
        Me.TxtLSADate.Name = "TxtLSADate"
        Me.TxtLSADate.Size = New System.Drawing.Size(52, 20)
        Me.TxtLSADate.TabIndex = 17
        '
        'LblLSA
        '
        Me.LblLSA.AutoSize = True
        Me.LblLSA.Font = New System.Drawing.Font("Tahoma", 8.0!)
        Me.LblLSA.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None
        Me.LblLSA.Location = New System.Drawing.Point(281, 120)
        Me.LblLSA.Name = "LblLSA"
        Me.LblLSA.Size = New System.Drawing.Size(25, 13)
        Me.LblLSA.TabIndex = 203
        Me.LblLSA.Text = "LSA"
        '
        'TxtDOB
        '
        Me.TxtDOB.AcceptsReturn = True
        Me.TxtDOB.BackColor = System.Drawing.SystemColors.Window
        Me.TxtDOB.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtDOB.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtDOB.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtDOB.Location = New System.Drawing.Point(99, 53)
        Me.TxtDOB.MaxLength = 0
        Me.TxtDOB.Name = "TxtDOB"
        Me.TxtDOB.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtDOB.Size = New System.Drawing.Size(71, 20)
        Me.TxtDOB.TabIndex = 6
        '
        'TxtRecNum
        '
        Me.TxtRecNum.AcceptsReturn = True
        Me.TxtRecNum.BackColor = System.Drawing.SystemColors.Window
        Me.TxtRecNum.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtRecNum.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtRecNum.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtRecNum.Location = New System.Drawing.Point(100, 95)
        Me.TxtRecNum.MaxLength = 30
        Me.TxtRecNum.Name = "TxtRecNum"
        Me.TxtRecNum.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtRecNum.Size = New System.Drawing.Size(139, 20)
        Me.TxtRecNum.TabIndex = 13
        '
        'TxtDeathTime
        '
        Me.TxtDeathTime.AcceptsReturn = True
        Me.TxtDeathTime.BackColor = System.Drawing.SystemColors.Window
        Me.TxtDeathTime.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtDeathTime.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtDeathTime.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtDeathTime.Location = New System.Drawing.Point(156, 116)
        Me.TxtDeathTime.Margin = New System.Windows.Forms.Padding(1)
        Me.TxtDeathTime.MaxLength = 0
        Me.TxtDeathTime.Name = "TxtDeathTime"
        Me.TxtDeathTime.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtDeathTime.Size = New System.Drawing.Size(50, 20)
        Me.TxtDeathTime.TabIndex = 16
        '
        'TxtDeathDate
        '
        Me.TxtDeathDate.AcceptsReturn = True
        Me.TxtDeathDate.BackColor = System.Drawing.SystemColors.Window
        Me.TxtDeathDate.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtDeathDate.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtDeathDate.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtDeathDate.Location = New System.Drawing.Point(100, 116)
        Me.TxtDeathDate.MaxLength = 0
        Me.TxtDeathDate.Name = "TxtDeathDate"
        Me.TxtDeathDate.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtDeathDate.Size = New System.Drawing.Size(52, 20)
        Me.TxtDeathDate.TabIndex = 15
        '
        'TxtDonorLastName
        '
        Me.TxtDonorLastName.AcceptsReturn = True
        Me.TxtDonorLastName.BackColor = System.Drawing.SystemColors.Window
        Me.TxtDonorLastName.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtDonorLastName.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtDonorLastName.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtDonorLastName.Location = New System.Drawing.Point(100, 32)
        Me.TxtDonorLastName.MaxLength = 50
        Me.TxtDonorLastName.Name = "TxtDonorLastName"
        Me.TxtDonorLastName.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtDonorLastName.Size = New System.Drawing.Size(123, 20)
        Me.TxtDonorLastName.TabIndex = 3
        '
        'CboRace
        '
        Me.CboRace.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboRace.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboRace.BackColor = System.Drawing.SystemColors.Window
        Me.CboRace.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboRace.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboRace.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboRace.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboRace.Location = New System.Drawing.Point(99, 73)
        Me.CboRace.Name = "CboRace"
        Me.CboRace.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboRace.Size = New System.Drawing.Size(140, 22)
        Me.CboRace.Sorted = True
        Me.CboRace.TabIndex = 10
        '
        'TxtAdmitTime
        '
        Me.TxtAdmitTime.AcceptsReturn = True
        Me.TxtAdmitTime.BackColor = System.Drawing.SystemColors.Window
        Me.TxtAdmitTime.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtAdmitTime.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtAdmitTime.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtAdmitTime.Location = New System.Drawing.Point(156, 157)
        Me.TxtAdmitTime.Margin = New System.Windows.Forms.Padding(1)
        Me.TxtAdmitTime.MaxLength = 0
        Me.TxtAdmitTime.Name = "TxtAdmitTime"
        Me.TxtAdmitTime.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtAdmitTime.Size = New System.Drawing.Size(50, 20)
        Me.TxtAdmitTime.TabIndex = 23
        '
        'TxtAdmitDate
        '
        Me.TxtAdmitDate.AcceptsReturn = True
        Me.TxtAdmitDate.BackColor = System.Drawing.SystemColors.Window
        Me.TxtAdmitDate.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtAdmitDate.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtAdmitDate.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtAdmitDate.Location = New System.Drawing.Point(100, 158)
        Me.TxtAdmitDate.MaxLength = 0
        Me.TxtAdmitDate.Name = "TxtAdmitDate"
        Me.TxtAdmitDate.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtAdmitDate.ShortcutsEnabled = False
        Me.TxtAdmitDate.Size = New System.Drawing.Size(52, 20)
        Me.TxtAdmitDate.TabIndex = 22
        '
        'CboHeartBeat
        '
        Me.CboHeartBeat.BackColor = System.Drawing.SystemColors.Window
        Me.CboHeartBeat.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboHeartBeat.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboHeartBeat.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboHeartBeat.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboHeartBeat.Location = New System.Drawing.Point(100, 9)
        Me.CboHeartBeat.Name = "CboHeartBeat"
        Me.CboHeartBeat.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboHeartBeat.Size = New System.Drawing.Size(61, 22)
        Me.CboHeartBeat.Sorted = True
        Me.CboHeartBeat.TabIndex = 0
        '
        'TxtBrainDeathDate
        '
        Me.TxtBrainDeathDate.AcceptsReturn = True
        Me.TxtBrainDeathDate.BackColor = System.Drawing.SystemColors.Window
        Me.TxtBrainDeathDate.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtBrainDeathDate.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtBrainDeathDate.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtBrainDeathDate.Location = New System.Drawing.Point(100, 137)
        Me.TxtBrainDeathDate.MaxLength = 0
        Me.TxtBrainDeathDate.Name = "TxtBrainDeathDate"
        Me.TxtBrainDeathDate.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtBrainDeathDate.Size = New System.Drawing.Size(52, 20)
        Me.TxtBrainDeathDate.TabIndex = 20
        '
        'TxtBrainDeathTime
        '
        Me.TxtBrainDeathTime.AcceptsReturn = True
        Me.TxtBrainDeathTime.BackColor = System.Drawing.SystemColors.Window
        Me.TxtBrainDeathTime.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtBrainDeathTime.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtBrainDeathTime.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtBrainDeathTime.Location = New System.Drawing.Point(156, 137)
        Me.TxtBrainDeathTime.Margin = New System.Windows.Forms.Padding(1)
        Me.TxtBrainDeathTime.MaxLength = 0
        Me.TxtBrainDeathTime.Name = "TxtBrainDeathTime"
        Me.TxtBrainDeathTime.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtBrainDeathTime.Size = New System.Drawing.Size(50, 20)
        Me.TxtBrainDeathTime.TabIndex = 21
        '
        'CmdDirectionsNote
        '
        Me.CmdDirectionsNote.BackColor = System.Drawing.SystemColors.Control
        Me.CmdDirectionsNote.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdDirectionsNote.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdDirectionsNote.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdDirectionsNote.Image = CType(resources.GetObject("CmdDirectionsNote.Image"), System.Drawing.Image)
        Me.CmdDirectionsNote.Location = New System.Drawing.Point(378, 147)
        Me.CmdDirectionsNote.Name = "CmdDirectionsNote"
        Me.CmdDirectionsNote.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdDirectionsNote.Size = New System.Drawing.Size(28, 23)
        Me.CmdDirectionsNote.TabIndex = 201
        Me.CmdDirectionsNote.TabStop = False
        Me.CmdDirectionsNote.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me.CmdDirectionsNote.UseVisualStyleBackColor = False
        '
        'TxtDonorMI
        '
        Me.TxtDonorMI.AcceptsReturn = True
        Me.TxtDonorMI.BackColor = System.Drawing.SystemColors.Window
        Me.TxtDonorMI.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtDonorMI.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtDonorMI.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtDonorMI.Location = New System.Drawing.Point(393, 32)
        Me.TxtDonorMI.MaxLength = 2
        Me.TxtDonorMI.Name = "TxtDonorMI"
        Me.TxtDonorMI.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtDonorMI.Size = New System.Drawing.Size(25, 20)
        Me.TxtDonorMI.TabIndex = 5
        '
        'TxtExtubated
        '
        Me.TxtExtubated.AcceptsReturn = True
        Me.TxtExtubated.BackColor = System.Drawing.SystemColors.Window
        Me.TxtExtubated.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtExtubated.Enabled = False
        Me.TxtExtubated.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtExtubated.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtExtubated.Location = New System.Drawing.Point(299, 10)
        Me.TxtExtubated.MaxLength = 0
        Me.TxtExtubated.Name = "TxtExtubated"
        Me.TxtExtubated.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtExtubated.Size = New System.Drawing.Size(119, 20)
        Me.TxtExtubated.TabIndex = 2
        '
        'TxtSSN
        '
        Me.TxtSSN.AcceptsReturn = True
        Me.TxtSSN.BackColor = System.Drawing.SystemColors.Window
        Me.TxtSSN.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtSSN.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtSSN.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtSSN.Location = New System.Drawing.Point(335, 95)
        Me.TxtSSN.MaxLength = 0
        Me.TxtSSN.Name = "TxtSSN"
        Me.TxtSSN.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtSSN.Size = New System.Drawing.Size(83, 20)
        Me.TxtSSN.TabIndex = 14
        '
        'ChkDOA
        '
        Me.ChkDOA.AutoSize = True
        Me.ChkDOA.BackColor = System.Drawing.SystemColors.Control
        Me.ChkDOA.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkDOA.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkDOA.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkDOA.Location = New System.Drawing.Point(212, 157)
        Me.ChkDOA.Name = "ChkDOA"
        Me.ChkDOA.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkDOA.Size = New System.Drawing.Size(49, 18)
        Me.ChkDOA.TabIndex = 19
        Me.ChkDOA.Text = "DOA"
        Me.ChkDOA.UseVisualStyleBackColor = False
        '
        '_Picture_0
        '
        Me._Picture_0.BackColor = System.Drawing.SystemColors.Control
        Me._Picture_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._Picture_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Picture_0.ForeColor = System.Drawing.SystemColors.WindowText
        Me._Picture_0.Location = New System.Drawing.Point(658, 8)
        Me._Picture_0.Name = "_Picture_0"
        Me._Picture_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Picture_0.Size = New System.Drawing.Size(9, 59)
        Me._Picture_0.TabIndex = 200
        '
        'CboVent
        '
        Me.CboVent.BackColor = System.Drawing.SystemColors.Window
        Me.CboVent.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboVent.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboVent.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboVent.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboVent.Location = New System.Drawing.Point(211, 9)
        Me.CboVent.Name = "CboVent"
        Me.CboVent.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboVent.Size = New System.Drawing.Size(77, 22)
        Me.CboVent.Sorted = True
        Me.CboVent.TabIndex = 1
        '
        'TxtWeight
        '
        Me.TxtWeight.AcceptsReturn = True
        Me.TxtWeight.BackColor = System.Drawing.SystemColors.Window
        Me.TxtWeight.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtWeight.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtWeight.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtWeight.Location = New System.Drawing.Point(349, 74)
        Me.TxtWeight.MaxLength = 7
        Me.TxtWeight.Name = "TxtWeight"
        Me.TxtWeight.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtWeight.Size = New System.Drawing.Size(51, 20)
        Me.TxtWeight.TabIndex = 12
        '
        'CboGender
        '
        Me.CboGender.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboGender.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboGender.BackColor = System.Drawing.SystemColors.Window
        Me.CboGender.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboGender.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboGender.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboGender.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboGender.Location = New System.Drawing.Point(267, 73)
        Me.CboGender.Name = "CboGender"
        Me.CboGender.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboGender.Size = New System.Drawing.Size(37, 22)
        Me.CboGender.Sorted = True
        Me.CboGender.TabIndex = 11
        '
        'CboAgeUnit
        '
        Me.CboAgeUnit.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboAgeUnit.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboAgeUnit.BackColor = System.Drawing.SystemColors.Window
        Me.CboAgeUnit.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboAgeUnit.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboAgeUnit.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboAgeUnit.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboAgeUnit.Location = New System.Drawing.Point(303, 52)
        Me.CboAgeUnit.Name = "CboAgeUnit"
        Me.CboAgeUnit.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboAgeUnit.Size = New System.Drawing.Size(69, 22)
        Me.CboAgeUnit.Sorted = True
        Me.CboAgeUnit.TabIndex = 9
        '
        'TxtAge
        '
        Me.TxtAge.AcceptsReturn = True
        Me.TxtAge.BackColor = System.Drawing.SystemColors.Window
        Me.TxtAge.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtAge.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtAge.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtAge.Location = New System.Drawing.Point(267, 53)
        Me.TxtAge.MaxLength = 0
        Me.TxtAge.Name = "TxtAge"
        Me.TxtAge.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtAge.Size = New System.Drawing.Size(35, 20)
        Me.TxtAge.TabIndex = 8
        '
        'TxtDonorFirstName
        '
        Me.TxtDonorFirstName.AcceptsReturn = True
        Me.TxtDonorFirstName.BackColor = System.Drawing.SystemColors.Window
        Me.TxtDonorFirstName.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtDonorFirstName.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtDonorFirstName.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtDonorFirstName.Location = New System.Drawing.Point(249, 32)
        Me.TxtDonorFirstName.MaxLength = 50
        Me.TxtDonorFirstName.Name = "TxtDonorFirstName"
        Me.TxtDonorFirstName.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtDonorFirstName.Size = New System.Drawing.Size(127, 20)
        Me.TxtDonorFirstName.TabIndex = 4
        '
        'CmdRegMatch
        '
        Me.CmdRegMatch.BackColor = System.Drawing.SystemColors.Control
        Me.CmdRegMatch.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdRegMatch.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdRegMatch.ForeColor = System.Drawing.Color.Black
        Me.CmdRegMatch.Location = New System.Drawing.Point(297, 138)
        Me.CmdRegMatch.Name = "CmdRegMatch"
        Me.CmdRegMatch.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdRegMatch.Size = New System.Drawing.Size(70, 21)
        Me.CmdRegMatch.TabIndex = 45
        Me.CmdRegMatch.Text = "Reg. Match"
        Me.CmdRegMatch.UseVisualStyleBackColor = False
        Me.CmdRegMatch.Visible = False
        '
        '_Lable_17
        '
        Me._Lable_17.AutoSize = True
        Me._Lable_17.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_17.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_17.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_17.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Lable_17.Location = New System.Drawing.Point(224, 35)
        Me._Lable_17.Name = "_Lable_17"
        Me._Lable_17.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_17.Size = New System.Drawing.Size(28, 14)
        Me._Lable_17.TabIndex = 200
        Me._Lable_17.Text = "First"
        '
        '_Lable_15
        '
        Me._Lable_15.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_15.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_15.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_15.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Lable_15.Location = New System.Drawing.Point(379, 35)
        Me._Lable_15.Name = "_Lable_15"
        Me._Lable_15.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_15.Size = New System.Drawing.Size(17, 15)
        Me._Lable_15.TabIndex = 200
        Me._Lable_15.Text = "MI"
        '
        '_Lable_5
        '
        Me._Lable_5.AutoSize = True
        Me._Lable_5.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_5.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_5.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Lable_5.Location = New System.Drawing.Point(183, 13)
        Me._Lable_5.Name = "_Lable_5"
        Me._Lable_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_5.Size = New System.Drawing.Size(29, 14)
        Me._Lable_5.TabIndex = 200
        Me._Lable_5.Text = "Vent"
        '
        'LblCardiacDate
        '
        Me.LblCardiacDate.AutoSize = True
        Me.LblCardiacDate.BackColor = System.Drawing.SystemColors.Control
        Me.LblCardiacDate.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblCardiacDate.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblCardiacDate.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblCardiacDate.Location = New System.Drawing.Point(13, 120)
        Me.LblCardiacDate.Name = "LblCardiacDate"
        Me.LblCardiacDate.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblCardiacDate.Size = New System.Drawing.Size(81, 14)
        Me.LblCardiacDate.TabIndex = 200
        Me.LblCardiacDate.Text = "Declared CTOD"
        '
        'LblRegistry
        '
        Me.LblRegistry.BackColor = System.Drawing.SystemColors.Control
        Me.LblRegistry.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblRegistry.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblRegistry.ForeColor = System.Drawing.Color.Red
        Me.LblRegistry.Location = New System.Drawing.Point(309, 165)
        Me.LblRegistry.Name = "LblRegistry"
        Me.LblRegistry.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblRegistry.Size = New System.Drawing.Size(51, 13)
        Me.LblRegistry.TabIndex = 200
        Me.LblRegistry.Text = "Registered"
        Me.LblRegistry.Visible = False
        '
        '_Lable_33
        '
        Me._Lable_33.AutoSize = True
        Me._Lable_33.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_33.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_33.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_33.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Lable_33.Location = New System.Drawing.Point(309, 98)
        Me._Lable_33.Name = "_Lable_33"
        Me._Lable_33.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_33.Size = New System.Drawing.Size(28, 14)
        Me._Lable_33.TabIndex = 200
        Me._Lable_33.Text = "SSN"
        '
        '_Lable_31
        '
        Me._Lable_31.AutoSize = True
        Me._Lable_31.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_31.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_31.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_31.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Lable_31.Location = New System.Drawing.Point(73, 56)
        Me._Lable_31.Name = "_Lable_31"
        Me._Lable_31.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_31.Size = New System.Drawing.Size(29, 14)
        Me._Lable_31.TabIndex = 200
        Me._Lable_31.Text = "DOB"
        '
        '_Lable_12
        '
        Me._Lable_12.AutoSize = True
        Me._Lable_12.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_12.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_12.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_12.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Lable_12.Location = New System.Drawing.Point(59, 160)
        Me._Lable_12.Name = "_Lable_12"
        Me._Lable_12.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_12.Size = New System.Drawing.Size(34, 14)
        Me._Lable_12.TabIndex = 200
        Me._Lable_12.Text = "Admit"
        '
        '_Lable_14
        '
        Me._Lable_14.AutoSize = True
        Me._Lable_14.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_14.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_14.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_14.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Lable_14.Location = New System.Drawing.Point(45, 13)
        Me._Lable_14.Name = "_Lable_14"
        Me._Lable_14.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_14.Size = New System.Drawing.Size(57, 14)
        Me._Lable_14.TabIndex = 200
        Me._Lable_14.Text = " Heartbeat"
        '
        '_Lable_10
        '
        Me._Lable_10.AutoSize = True
        Me._Lable_10.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_10.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_10.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_10.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Lable_10.Location = New System.Drawing.Point(304, 77)
        Me._Lable_10.Name = "_Lable_10"
        Me._Lable_10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_10.Size = New System.Drawing.Size(40, 14)
        Me._Lable_10.TabIndex = 200
        Me._Lable_10.Text = "Weight"
        '
        '_Lable_8
        '
        Me._Lable_8.AutoSize = True
        Me._Lable_8.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_8.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_8.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_8.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Lable_8.Location = New System.Drawing.Point(243, 77)
        Me._Lable_8.Name = "_Lable_8"
        Me._Lable_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_8.Size = New System.Drawing.Size(26, 14)
        Me._Lable_8.TabIndex = 200
        Me._Lable_8.Text = "Sex"
        '
        '_Lable_11
        '
        Me._Lable_11.AutoSize = True
        Me._Lable_11.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_11.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_11.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_11.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Lable_11.Location = New System.Drawing.Point(70, 77)
        Me._Lable_11.Name = "_Lable_11"
        Me._Lable_11.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_11.Size = New System.Drawing.Size(32, 14)
        Me._Lable_11.TabIndex = 200
        Me._Lable_11.Text = "Race"
        '
        '_Lable_9
        '
        Me._Lable_9.AutoSize = True
        Me._Lable_9.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_9.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_9.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_9.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Lable_9.Location = New System.Drawing.Point(243, 58)
        Me._Lable_9.Name = "_Lable_9"
        Me._Lable_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_9.Size = New System.Drawing.Size(27, 14)
        Me._Lable_9.TabIndex = 200
        Me._Lable_9.Text = "Age"
        '
        '_Lable_7
        '
        Me._Lable_7.AutoSize = True
        Me._Lable_7.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_7.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_7.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Lable_7.Location = New System.Drawing.Point(44, 98)
        Me._Lable_7.Name = "_Lable_7"
        Me._Lable_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_7.Size = New System.Drawing.Size(58, 14)
        Me._Lable_7.TabIndex = 200
        Me._Lable_7.Text = "Med Rec #"
        '
        '_Lable_6
        '
        Me._Lable_6.AutoSize = True
        Me._Lable_6.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_6.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_6.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Lable_6.Location = New System.Drawing.Point(74, 35)
        Me._Lable_6.Name = "_Lable_6"
        Me._Lable_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_6.Size = New System.Drawing.Size(28, 14)
        Me._Lable_6.TabIndex = 200
        Me._Lable_6.Text = "Last"
        '
        '_Lable_16
        '
        Me._Lable_16.AutoSize = True
        Me._Lable_16.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_16.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_16.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_16.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Lable_16.Location = New System.Drawing.Point(31, 140)
        Me._Lable_16.Name = "_Lable_16"
        Me._Lable_16.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_16.Size = New System.Drawing.Size(63, 14)
        Me._Lable_16.TabIndex = 200
        Me._Lable_16.Text = "Brain Death"
        '
        'LblWeight
        '
        Me.LblWeight.AutoSize = True
        Me.LblWeight.BackColor = System.Drawing.SystemColors.Control
        Me.LblWeight.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblWeight.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblWeight.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblWeight.Location = New System.Drawing.Point(404, 76)
        Me.LblWeight.Name = "LblWeight"
        Me.LblWeight.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblWeight.Size = New System.Drawing.Size(18, 14)
        Me.LblWeight.TabIndex = 200
        Me.LblWeight.Text = "kg"
        '
        'LblDOB_ILB
        '
        Me.LblDOB_ILB.BackColor = System.Drawing.SystemColors.Control
        Me.LblDOB_ILB.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblDOB_ILB.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblDOB_ILB.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblDOB_ILB.Location = New System.Drawing.Point(102, 60)
        Me.LblDOB_ILB.Name = "LblDOB_ILB"
        Me.LblDOB_ILB.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblDOB_ILB.Size = New System.Drawing.Size(67, 11)
        Me.LblDOB_ILB.TabIndex = 200
        Me.LblDOB_ILB.Text = "Unknown"
        '
        '_TxtAlerts_0
        '
        Me._TxtAlerts_0.BackColor = System.Drawing.SystemColors.Window
        Me._TxtAlerts_0.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me._TxtAlerts_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._TxtAlerts_0.Location = New System.Drawing.Point(435, 14)
        Me._TxtAlerts_0.MaxLength = 2000
        Me._TxtAlerts_0.Name = "_TxtAlerts_0"
        Me._TxtAlerts_0.ReadOnly = True
        Me._TxtAlerts_0.ScrollBars = System.Windows.Forms.RichTextBoxScrollBars.Vertical
        Me._TxtAlerts_0.Size = New System.Drawing.Size(228, 369)
        Me._TxtAlerts_0.TabIndex = 200
        Me._TxtAlerts_0.TabStop = False
        Me._TxtAlerts_0.Text = ""
        '
        'Frame1
        '
        Me.Frame1.BackColor = System.Drawing.SystemColors.Control
        Me.Frame1.Controls.Add(Me.Cmdregkill)
        Me.Frame1.Controls.Add(Me.CboGeneralConsent)
        Me.Frame1.Controls.Add(Me.CboApproachedBy)
        Me.Frame1.Controls.Add(Me.cboRegistryStatus)
        Me.Frame1.Controls.Add(Me.CboApproachType)
        Me.Frame1.Controls.Add(Me.TxtSpecificCOD)
        Me.Frame1.Controls.Add(Me.CboCauseOfDeath)
        Me.Frame1.Controls.Add(Me.CmdApproachedByDetail)
        Me.Frame1.Controls.Add(Me.cmdDonorIntent)
        Me.Frame1.Controls.Add(Me.TxtNotesCase)
        Me.Frame1.Controls.Add(Me.LblFSConsent)
        Me.Frame1.Controls.Add(Me.LblFSApproacher)
        Me.Frame1.Controls.Add(Me.LblFSApproach)
        Me.Frame1.Controls.Add(Me.LblFinialApproach)
        Me.Frame1.Controls.Add(Me.LblInitialApproach)
        Me.Frame1.Controls.Add(Me._Lable_20)
        Me.Frame1.Controls.Add(Me._Lable_22)
        Me.Frame1.Controls.Add(Me.LblSpecificCOD)
        Me.Frame1.Controls.Add(Me._Lable_21)
        Me.Frame1.Controls.Add(Me._Lable_18)
        Me.Frame1.Controls.Add(Me.LblHistory)
        Me.Frame1.Controls.Add(Me.Label)
        Me.Frame1.Controls.Add(Me.LblPromptApproach)
        Me.Frame1.Controls.Add(Me.RegStatus)
        Me.Frame1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Frame1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame1.Location = New System.Drawing.Point(10, 182)
        Me.Frame1.Margin = New System.Windows.Forms.Padding(1)
        Me.Frame1.Name = "Frame1"
        Me.Frame1.Padding = New System.Windows.Forms.Padding(0)
        Me.Frame1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame1.Size = New System.Drawing.Size(424, 188)
        Me.Frame1.TabIndex = 2
        Me.Frame1.TabStop = False
        '
        'Cmdregkill
        '
        Me.Cmdregkill.BackColor = System.Drawing.SystemColors.Control
        Me.Cmdregkill.Cursor = System.Windows.Forms.Cursors.Default
        Me.Cmdregkill.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Cmdregkill.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Cmdregkill.Location = New System.Drawing.Point(416, 80)
        Me.Cmdregkill.Name = "Cmdregkill"
        Me.Cmdregkill.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Cmdregkill.Size = New System.Drawing.Size(5, 13)
        Me.Cmdregkill.TabIndex = 200
        Me.Cmdregkill.TabStop = False
        Me.Cmdregkill.Text = "Cmdregkill"
        Me.Cmdregkill.UseVisualStyleBackColor = False
        Me.Cmdregkill.Visible = False
        '
        'CboGeneralConsent
        '
        Me.CboGeneralConsent.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboGeneralConsent.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboGeneralConsent.BackColor = System.Drawing.SystemColors.Control
        Me.CboGeneralConsent.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboGeneralConsent.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboGeneralConsent.Enabled = False
        Me.CboGeneralConsent.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboGeneralConsent.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboGeneralConsent.Location = New System.Drawing.Point(109, 68)
        Me.CboGeneralConsent.Name = "CboGeneralConsent"
        Me.CboGeneralConsent.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboGeneralConsent.Size = New System.Drawing.Size(145, 22)
        Me.CboGeneralConsent.TabIndex = 25
        '
        'CboApproachedBy
        '
        Me.CboApproachedBy.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboApproachedBy.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboApproachedBy.BackColor = System.Drawing.SystemColors.Control
        Me.CboApproachedBy.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboApproachedBy.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboApproachedBy.Enabled = False
        Me.CboApproachedBy.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboApproachedBy.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboApproachedBy.Location = New System.Drawing.Point(109, 46)
        Me.CboApproachedBy.Name = "CboApproachedBy"
        Me.CboApproachedBy.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboApproachedBy.Size = New System.Drawing.Size(145, 22)
        Me.CboApproachedBy.Sorted = True
        Me.CboApproachedBy.TabIndex = 23
        '
        'cboRegistryStatus
        '
        Me.cboRegistryStatus.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.cboRegistryStatus.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.cboRegistryStatus.BackColor = System.Drawing.SystemColors.Control
        Me.cboRegistryStatus.Cursor = System.Windows.Forms.Cursors.Default
        Me.cboRegistryStatus.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cboRegistryStatus.Enabled = False
        Me.cboRegistryStatus.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cboRegistryStatus.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cboRegistryStatus.Location = New System.Drawing.Point(315, 163)
        Me.cboRegistryStatus.Name = "cboRegistryStatus"
        Me.cboRegistryStatus.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cboRegistryStatus.Size = New System.Drawing.Size(105, 22)
        Me.cboRegistryStatus.TabIndex = 200
        Me.cboRegistryStatus.TabStop = False
        '
        'CboApproachType
        '
        Me.CboApproachType.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboApproachType.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboApproachType.BackColor = System.Drawing.SystemColors.Control
        Me.CboApproachType.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboApproachType.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboApproachType.Enabled = False
        Me.CboApproachType.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboApproachType.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboApproachType.Location = New System.Drawing.Point(109, 24)
        Me.CboApproachType.Name = "CboApproachType"
        Me.CboApproachType.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboApproachType.Size = New System.Drawing.Size(165, 22)
        Me.CboApproachType.TabIndex = 22
        '
        'TxtSpecificCOD
        '
        Me.TxtSpecificCOD.AcceptsReturn = True
        Me.TxtSpecificCOD.BackColor = System.Drawing.SystemColors.Window
        Me.TxtSpecificCOD.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtSpecificCOD.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtSpecificCOD.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtSpecificCOD.Location = New System.Drawing.Point(108, 142)
        Me.TxtSpecificCOD.MaxLength = 249
        Me.TxtSpecificCOD.Multiline = True
        Me.TxtSpecificCOD.Name = "TxtSpecificCOD"
        Me.TxtSpecificCOD.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtSpecificCOD.ScrollBars = System.Windows.Forms.ScrollBars.Vertical
        Me.TxtSpecificCOD.Size = New System.Drawing.Size(311, 20)
        Me.TxtSpecificCOD.TabIndex = 29
        '
        'CboCauseOfDeath
        '
        Me.CboCauseOfDeath.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboCauseOfDeath.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboCauseOfDeath.BackColor = System.Drawing.SystemColors.Window
        Me.CboCauseOfDeath.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboCauseOfDeath.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboCauseOfDeath.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboCauseOfDeath.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboCauseOfDeath.Location = New System.Drawing.Point(109, 163)
        Me.CboCauseOfDeath.Name = "CboCauseOfDeath"
        Me.CboCauseOfDeath.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboCauseOfDeath.Size = New System.Drawing.Size(129, 22)
        Me.CboCauseOfDeath.Sorted = True
        Me.CboCauseOfDeath.TabIndex = 30
        '
        'CmdApproachedByDetail
        '
        Me.CmdApproachedByDetail.BackColor = System.Drawing.SystemColors.Control
        Me.CmdApproachedByDetail.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdApproachedByDetail.Enabled = False
        Me.CmdApproachedByDetail.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdApproachedByDetail.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdApproachedByDetail.Location = New System.Drawing.Point(255, 47)
        Me.CmdApproachedByDetail.Name = "CmdApproachedByDetail"
        Me.CmdApproachedByDetail.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdApproachedByDetail.Size = New System.Drawing.Size(24, 20)
        Me.CmdApproachedByDetail.TabIndex = 24
        Me.CmdApproachedByDetail.Text = "..."
        Me.CmdApproachedByDetail.UseVisualStyleBackColor = False
        '
        'cmdDonorIntent
        '
        Me.cmdDonorIntent.BackColor = System.Drawing.SystemColors.Control
        Me.cmdDonorIntent.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdDonorIntent.Enabled = False
        Me.cmdDonorIntent.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdDonorIntent.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdDonorIntent.Location = New System.Drawing.Point(276, 70)
        Me.cmdDonorIntent.Name = "cmdDonorIntent"
        Me.cmdDonorIntent.Size = New System.Drawing.Size(98, 19)
        Me.cmdDonorIntent.TabIndex = 26
        Me.cmdDonorIntent.Text = "Donor Intent"
        Me.cmdDonorIntent.UseVisualStyleBackColor = False
        '
        'TxtNotesCase
        '
        Me.TxtNotesCase.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.TxtNotesCase.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtNotesCase.Location = New System.Drawing.Point(109, 91)
        Me.TxtNotesCase.MaxLength = 399
        Me.TxtNotesCase.Name = "TxtNotesCase"
        Me.TxtNotesCase.RightMargin = 207
        Me.TxtNotesCase.ScrollBars = System.Windows.Forms.RichTextBoxScrollBars.Vertical
        Me.TxtNotesCase.Size = New System.Drawing.Size(311, 49)
        Me.TxtNotesCase.TabIndex = 28
        Me.TxtNotesCase.Text = ""
        '
        'LblFSConsent
        '
        Me.LblFSConsent.BackColor = System.Drawing.SystemColors.Control
        Me.LblFSConsent.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblFSConsent.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblFSConsent.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblFSConsent.Location = New System.Drawing.Point(288, 64)
        Me.LblFSConsent.Name = "LblFSConsent"
        Me.LblFSConsent.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblFSConsent.Size = New System.Drawing.Size(117, 15)
        Me.LblFSConsent.TabIndex = 200
        '
        'LblFSApproacher
        '
        Me.LblFSApproacher.BackColor = System.Drawing.SystemColors.Control
        Me.LblFSApproacher.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblFSApproacher.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblFSApproacher.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblFSApproacher.Location = New System.Drawing.Point(288, 48)
        Me.LblFSApproacher.Name = "LblFSApproacher"
        Me.LblFSApproacher.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblFSApproacher.Size = New System.Drawing.Size(117, 15)
        Me.LblFSApproacher.TabIndex = 200
        '
        'LblFSApproach
        '
        Me.LblFSApproach.BackColor = System.Drawing.SystemColors.Control
        Me.LblFSApproach.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblFSApproach.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblFSApproach.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblFSApproach.Location = New System.Drawing.Point(288, 28)
        Me.LblFSApproach.Name = "LblFSApproach"
        Me.LblFSApproach.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblFSApproach.Size = New System.Drawing.Size(117, 15)
        Me.LblFSApproach.TabIndex = 200
        '
        'LblFinialApproach
        '
        Me.LblFinialApproach.BackColor = System.Drawing.SystemColors.Control
        Me.LblFinialApproach.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblFinialApproach.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblFinialApproach.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblFinialApproach.Location = New System.Drawing.Point(288, 8)
        Me.LblFinialApproach.Name = "LblFinialApproach"
        Me.LblFinialApproach.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblFinialApproach.Size = New System.Drawing.Size(113, 17)
        Me.LblFinialApproach.TabIndex = 200
        Me.LblFinialApproach.Text = "Final Approach"
        '
        'LblInitialApproach
        '
        Me.LblInitialApproach.BackColor = System.Drawing.SystemColors.Control
        Me.LblInitialApproach.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblInitialApproach.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblInitialApproach.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblInitialApproach.Location = New System.Drawing.Point(112, 8)
        Me.LblInitialApproach.Name = "LblInitialApproach"
        Me.LblInitialApproach.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblInitialApproach.Size = New System.Drawing.Size(97, 17)
        Me.LblInitialApproach.TabIndex = 200
        Me.LblInitialApproach.Text = "Initial Approach"
        '
        '_Lable_20
        '
        Me._Lable_20.AutoSize = True
        Me._Lable_20.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_20.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_20.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_20.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Lable_20.Location = New System.Drawing.Point(63, 72)
        Me._Lable_20.Name = "_Lable_20"
        Me._Lable_20.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_20.Size = New System.Drawing.Size(47, 14)
        Me._Lable_20.TabIndex = 200
        Me._Lable_20.Text = "Consent"
        '
        '_Lable_22
        '
        Me._Lable_22.AutoSize = True
        Me._Lable_22.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_22.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_22.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_22.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Lable_22.Location = New System.Drawing.Point(45, 50)
        Me._Lable_22.Name = "_Lable_22"
        Me._Lable_22.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_22.Size = New System.Drawing.Size(65, 14)
        Me._Lable_22.TabIndex = 200
        Me._Lable_22.Text = "Approacher"
        '
        'LblSpecificCOD
        '
        Me.LblSpecificCOD.AutoSize = True
        Me.LblSpecificCOD.BackColor = System.Drawing.SystemColors.Control
        Me.LblSpecificCOD.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblSpecificCOD.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblSpecificCOD.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblSpecificCOD.Location = New System.Drawing.Point(30, 143)
        Me.LblSpecificCOD.Name = "LblSpecificCOD"
        Me.LblSpecificCOD.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblSpecificCOD.Size = New System.Drawing.Size(80, 14)
        Me.LblSpecificCOD.TabIndex = 200
        Me.LblSpecificCOD.Text = "Specific C.O.D."
        '
        '_Lable_21
        '
        Me._Lable_21.AutoSize = True
        Me._Lable_21.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_21.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_21.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_21.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Lable_21.Location = New System.Drawing.Point(4, 28)
        Me._Lable_21.Name = "_Lable_21"
        Me._Lable_21.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_21.Size = New System.Drawing.Size(105, 14)
        Me._Lable_21.TabIndex = 200
        Me._Lable_21.Text = "Method of Approach"
        '
        '_Lable_18
        '
        Me._Lable_18.AutoSize = True
        Me._Lable_18.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_18.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_18.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_18.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Lable_18.Location = New System.Drawing.Point(75, 167)
        Me._Lable_18.Name = "_Lable_18"
        Me._Lable_18.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_18.Size = New System.Drawing.Size(35, 14)
        Me._Lable_18.TabIndex = 200
        Me._Lable_18.Text = "C.O.D"
        '
        'LblHistory
        '
        Me.LblHistory.AutoSize = True
        Me.LblHistory.BackColor = System.Drawing.SystemColors.Control
        Me.LblHistory.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblHistory.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblHistory.ForeColor = System.Drawing.Color.FromArgb(CType(CType(0, Byte), Integer), CType(CType(128, Byte), Integer), CType(CType(0, Byte), Integer))
        Me.LblHistory.Location = New System.Drawing.Point(53, 91)
        Me.LblHistory.Name = "LblHistory"
        Me.LblHistory.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblHistory.Size = New System.Drawing.Size(57, 14)
        Me.LblHistory.TabIndex = 200
        Me.LblHistory.Text = "Advanced"
        '
        'Label
        '
        Me.Label.AutoSize = True
        Me.Label.BackColor = System.Drawing.SystemColors.Control
        Me.Label.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.Location = New System.Drawing.Point(30, 106)
        Me.Label.Name = "Label"
        Me.Label.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label.Size = New System.Drawing.Size(80, 14)
        Me.Label.TabIndex = 200
        Me.Label.Text = "Medical History"
        '
        'LblPromptApproach
        '
        Me.LblPromptApproach.BackColor = System.Drawing.SystemColors.Control
        Me.LblPromptApproach.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblPromptApproach.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblPromptApproach.ForeColor = System.Drawing.Color.Red
        Me.LblPromptApproach.Location = New System.Drawing.Point(285, 77)
        Me.LblPromptApproach.Name = "LblPromptApproach"
        Me.LblPromptApproach.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblPromptApproach.Size = New System.Drawing.Size(85, 13)
        Me.LblPromptApproach.TabIndex = 200
        Me.LblPromptApproach.Text = "Ask / Don't Ask"
        Me.LblPromptApproach.Visible = False
        '
        'RegStatus
        '
        Me.RegStatus.AutoSize = True
        Me.RegStatus.BackColor = System.Drawing.SystemColors.Control
        Me.RegStatus.Cursor = System.Windows.Forms.Cursors.Default
        Me.RegStatus.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.RegStatus.ForeColor = System.Drawing.SystemColors.ControlText
        Me.RegStatus.Location = New System.Drawing.Point(261, 167)
        Me.RegStatus.Name = "RegStatus"
        Me.RegStatus.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.RegStatus.Size = New System.Drawing.Size(57, 14)
        Me.RegStatus.TabIndex = 200
        Me.RegStatus.Text = "RegStatus"
        '
        '_TabDonor_TabPage1
        '
        Me._TabDonor_TabPage1.Controls.Add(Me.FrameTBINumber)
        Me._TabDonor_TabPage1.Controls.Add(Me._Frame_6)
        Me._TabDonor_TabPage1.Controls.Add(Me._Frame_7)
        Me._TabDonor_TabPage1.Location = New System.Drawing.Point(4, 4)
        Me._TabDonor_TabPage1.Name = "_TabDonor_TabPage1"
        Me._TabDonor_TabPage1.Size = New System.Drawing.Size(1275, 593)
        Me._TabDonor_TabPage1.TabIndex = 200
        Me._TabDonor_TabPage1.Text = "Secondary"
        '
        'FrameTBINumber
        '
        Me.FrameTBINumber.BackColor = System.Drawing.SystemColors.Control
        Me.FrameTBINumber.Controls.Add(Me.txtSecondaryTBIComment)
        Me.FrameTBINumber.Controls.Add(Me.cmdGenerateTBI)
        Me.FrameTBINumber.Controls.Add(Me.chkSecondaryTBINotNeeded)
        Me.FrameTBINumber.Controls.Add(Me.txtSecondaryTBINumber)
        Me.FrameTBINumber.Controls.Add(Me.lblTBIComment)
        Me.FrameTBINumber.Controls.Add(Me.lblTBINumber)
        Me.FrameTBINumber.Enabled = False
        Me.FrameTBINumber.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FrameTBINumber.ForeColor = System.Drawing.SystemColors.ControlText
        Me.FrameTBINumber.Location = New System.Drawing.Point(7, 429)
        Me.FrameTBINumber.Name = "FrameTBINumber"
        Me.FrameTBINumber.Padding = New System.Windows.Forms.Padding(0)
        Me.FrameTBINumber.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.FrameTBINumber.Size = New System.Drawing.Size(404, 114)
        Me.FrameTBINumber.TabIndex = 200
        Me.FrameTBINumber.TabStop = False
        Me.FrameTBINumber.Text = "CTDN Number"
        '
        'txtSecondaryTBIComment
        '
        Me.txtSecondaryTBIComment.AcceptsReturn = True
        Me.txtSecondaryTBIComment.BackColor = System.Drawing.SystemColors.Window
        Me.txtSecondaryTBIComment.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtSecondaryTBIComment.Enabled = False
        Me.txtSecondaryTBIComment.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtSecondaryTBIComment.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtSecondaryTBIComment.Location = New System.Drawing.Point(105, 65)
        Me.txtSecondaryTBIComment.MaxLength = 0
        Me.txtSecondaryTBIComment.Name = "txtSecondaryTBIComment"
        Me.txtSecondaryTBIComment.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtSecondaryTBIComment.Size = New System.Drawing.Size(292, 20)
        Me.txtSecondaryTBIComment.TabIndex = 200
        '
        'cmdGenerateTBI
        '
        Me.cmdGenerateTBI.BackColor = System.Drawing.SystemColors.Control
        Me.cmdGenerateTBI.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdGenerateTBI.Enabled = False
        Me.cmdGenerateTBI.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdGenerateTBI.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdGenerateTBI.Location = New System.Drawing.Point(169, 18)
        Me.cmdGenerateTBI.Name = "cmdGenerateTBI"
        Me.cmdGenerateTBI.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdGenerateTBI.Size = New System.Drawing.Size(118, 21)
        Me.cmdGenerateTBI.TabIndex = 200
        Me.cmdGenerateTBI.Text = "Generate CTDN #"
        Me.cmdGenerateTBI.UseVisualStyleBackColor = False
        '
        'chkSecondaryTBINotNeeded
        '
        Me.chkSecondaryTBINotNeeded.BackColor = System.Drawing.SystemColors.Control
        Me.chkSecondaryTBINotNeeded.Cursor = System.Windows.Forms.Cursors.Default
        Me.chkSecondaryTBINotNeeded.Enabled = False
        Me.chkSecondaryTBINotNeeded.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.chkSecondaryTBINotNeeded.ForeColor = System.Drawing.SystemColors.ControlText
        Me.chkSecondaryTBINotNeeded.Location = New System.Drawing.Point(46, 44)
        Me.chkSecondaryTBINotNeeded.Name = "chkSecondaryTBINotNeeded"
        Me.chkSecondaryTBINotNeeded.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.chkSecondaryTBINotNeeded.Size = New System.Drawing.Size(166, 16)
        Me.chkSecondaryTBINotNeeded.TabIndex = 200
        Me.chkSecondaryTBINotNeeded.Text = "CTDN - Assignment Not Needed"
        Me.chkSecondaryTBINotNeeded.UseVisualStyleBackColor = False
        '
        'txtSecondaryTBINumber
        '
        Me.txtSecondaryTBINumber.AcceptsReturn = True
        Me.txtSecondaryTBINumber.BackColor = System.Drawing.SystemColors.Window
        Me.txtSecondaryTBINumber.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtSecondaryTBINumber.Enabled = False
        Me.txtSecondaryTBINumber.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtSecondaryTBINumber.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtSecondaryTBINumber.Location = New System.Drawing.Point(46, 19)
        Me.txtSecondaryTBINumber.MaxLength = 0
        Me.txtSecondaryTBINumber.Name = "txtSecondaryTBINumber"
        Me.txtSecondaryTBINumber.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtSecondaryTBINumber.Size = New System.Drawing.Size(112, 20)
        Me.txtSecondaryTBINumber.TabIndex = 200
        '
        'lblTBIComment
        '
        Me.lblTBIComment.BackColor = System.Drawing.SystemColors.Control
        Me.lblTBIComment.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblTBIComment.Enabled = False
        Me.lblTBIComment.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblTBIComment.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblTBIComment.Location = New System.Drawing.Point(46, 63)
        Me.lblTBIComment.Name = "lblTBIComment"
        Me.lblTBIComment.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblTBIComment.Size = New System.Drawing.Size(51, 16)
        Me.lblTBIComment.TabIndex = 200
        Me.lblTBIComment.Text = "Comment:"
        '
        'lblTBINumber
        '
        Me.lblTBINumber.BackColor = System.Drawing.SystemColors.Control
        Me.lblTBINumber.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblTBINumber.Enabled = False
        Me.lblTBINumber.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblTBINumber.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblTBINumber.Location = New System.Drawing.Point(8, 23)
        Me.lblTBINumber.Name = "lblTBINumber"
        Me.lblTBINumber.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblTBINumber.Size = New System.Drawing.Size(35, 13)
        Me.lblTBINumber.TabIndex = 200
        Me.lblTBINumber.Text = "CTDN #:"
        '
        '_Frame_6
        '
        Me._Frame_6.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_6.Controls.Add(Me._Picture_3)
        Me._Frame_6.Controls.Add(Me.TxtNotesCaseReadOnly)
        Me._Frame_6.Controls.Add(Me.TxtSecondaryAlert)
        Me._Frame_6.Controls.Add(Me.TxtSecondaryNote)
        Me._Frame_6.Controls.Add(Me._Lable_36)
        Me._Frame_6.Controls.Add(Me._Lable_35)
        Me._Frame_6.Controls.Add(Me._Lable_34)
        Me._Frame_6.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_6.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Frame_6.Location = New System.Drawing.Point(-1, -3)
        Me._Frame_6.Name = "_Frame_6"
        Me._Frame_6.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_6.Size = New System.Drawing.Size(665, 273)
        Me._Frame_6.TabIndex = 200
        Me._Frame_6.TabStop = False
        '
        '_Picture_3
        '
        Me._Picture_3.BackColor = System.Drawing.SystemColors.Control
        Me._Picture_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._Picture_3.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Picture_3.ForeColor = System.Drawing.SystemColors.WindowText
        Me._Picture_3.Location = New System.Drawing.Point(648, 66)
        Me._Picture_3.Name = "_Picture_3"
        Me._Picture_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Picture_3.Size = New System.Drawing.Size(9, 73)
        Me._Picture_3.TabIndex = 200
        '
        'TxtNotesCaseReadOnly
        '
        Me.TxtNotesCaseReadOnly.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtNotesCaseReadOnly.Location = New System.Drawing.Point(296, 28)
        Me.TxtNotesCaseReadOnly.MaxLength = 254
        Me.TxtNotesCaseReadOnly.Name = "TxtNotesCaseReadOnly"
        Me.TxtNotesCaseReadOnly.ReadOnly = True
        Me.TxtNotesCaseReadOnly.RightMargin = 207
        Me.TxtNotesCaseReadOnly.ScrollBars = System.Windows.Forms.RichTextBoxScrollBars.Vertical
        Me.TxtNotesCaseReadOnly.Size = New System.Drawing.Size(281, 107)
        Me.TxtNotesCaseReadOnly.TabIndex = 200
        Me.TxtNotesCaseReadOnly.TabStop = False
        Me.TxtNotesCaseReadOnly.Text = ""
        '
        'TxtSecondaryAlert
        '
        Me.TxtSecondaryAlert.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtSecondaryAlert.Location = New System.Drawing.Point(8, 28)
        Me.TxtSecondaryAlert.MaxLength = 749
        Me.TxtSecondaryAlert.Name = "TxtSecondaryAlert"
        Me.TxtSecondaryAlert.ReadOnly = True
        Me.TxtSecondaryAlert.RightMargin = 260
        Me.TxtSecondaryAlert.Size = New System.Drawing.Size(281, 231)
        Me.TxtSecondaryAlert.TabIndex = 200
        Me.TxtSecondaryAlert.TabStop = False
        Me.TxtSecondaryAlert.Text = ""
        '
        'TxtSecondaryNote
        '
        Me.TxtSecondaryNote.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtSecondaryNote.Location = New System.Drawing.Point(296, 152)
        Me.TxtSecondaryNote.MaxLength = 499
        Me.TxtSecondaryNote.Name = "TxtSecondaryNote"
        Me.TxtSecondaryNote.RightMargin = 207
        Me.TxtSecondaryNote.ScrollBars = System.Windows.Forms.RichTextBoxScrollBars.Vertical
        Me.TxtSecondaryNote.Size = New System.Drawing.Size(281, 107)
        Me.TxtSecondaryNote.TabIndex = 200
        Me.TxtSecondaryNote.TabStop = False
        Me.TxtSecondaryNote.Text = ""
        '
        '_Lable_36
        '
        Me._Lable_36.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_36.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_36.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_36.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Lable_36.Location = New System.Drawing.Point(298, 14)
        Me._Lable_36.Name = "_Lable_36"
        Me._Lable_36.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_36.Size = New System.Drawing.Size(177, 15)
        Me._Lable_36.TabIndex = 200
        Me._Lable_36.Text = "Primary Screening History"
        '
        '_Lable_35
        '
        Me._Lable_35.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_35.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_35.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_35.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Lable_35.Location = New System.Drawing.Point(298, 138)
        Me._Lable_35.Name = "_Lable_35"
        Me._Lable_35.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_35.Size = New System.Drawing.Size(177, 15)
        Me._Lable_35.TabIndex = 200
        Me._Lable_35.Text = "Secondary Screening History"
        '
        '_Lable_34
        '
        Me._Lable_34.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_34.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_34.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_34.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Lable_34.Location = New System.Drawing.Point(10, 12)
        Me._Lable_34.Name = "_Lable_34"
        Me._Lable_34.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_34.Size = New System.Drawing.Size(117, 15)
        Me._Lable_34.TabIndex = 200
        Me._Lable_34.Text = "Secondary Alert"
        '
        '_Frame_7
        '
        Me._Frame_7.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_7.Controls.Add(Me.chkFinal)
        Me._Frame_7.Controls.Add(Me.chkApproached)
        Me._Frame_7.Controls.Add(Me.chkSecondaryComplete)
        Me._Frame_7.Controls.Add(Me.chkSystemEvents)
        Me._Frame_7.Controls.Add(Me.chkCaseOpen)
        Me._Frame_7.Controls.Add(Me.lblFinalPersonDateTime)
        Me._Frame_7.Controls.Add(Me.lblApproachedPersonDateTime)
        Me._Frame_7.Controls.Add(Me.lblSecondaryCompletePersonDateTime)
        Me._Frame_7.Controls.Add(Me.lblSystemEventsPersonDateTime)
        Me._Frame_7.Controls.Add(Me.lblCaseOpenPersonDateTime)
        Me._Frame_7.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_7.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Frame_7.Location = New System.Drawing.Point(7, 275)
        Me._Frame_7.Name = "_Frame_7"
        Me._Frame_7.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_7.Size = New System.Drawing.Size(403, 146)
        Me._Frame_7.TabIndex = 200
        Me._Frame_7.TabStop = False
        Me._Frame_7.Text = "Secondary Status"
        '
        'lblFinalPersonDateTime
        '
        Me.lblFinalPersonDateTime.BackColor = System.Drawing.SystemColors.Control
        Me.lblFinalPersonDateTime.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblFinalPersonDateTime.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblFinalPersonDateTime.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblFinalPersonDateTime.Location = New System.Drawing.Point(160, 118)
        Me.lblFinalPersonDateTime.Name = "lblFinalPersonDateTime"
        Me.lblFinalPersonDateTime.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblFinalPersonDateTime.Size = New System.Drawing.Size(217, 17)
        Me.lblFinalPersonDateTime.TabIndex = 200
        Me.lblFinalPersonDateTime.Visible = False
        '
        'lblApproachedPersonDateTime
        '
        Me.lblApproachedPersonDateTime.BackColor = System.Drawing.SystemColors.Control
        Me.lblApproachedPersonDateTime.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblApproachedPersonDateTime.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblApproachedPersonDateTime.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblApproachedPersonDateTime.Location = New System.Drawing.Point(160, 94)
        Me.lblApproachedPersonDateTime.Name = "lblApproachedPersonDateTime"
        Me.lblApproachedPersonDateTime.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblApproachedPersonDateTime.Size = New System.Drawing.Size(209, 17)
        Me.lblApproachedPersonDateTime.TabIndex = 200
        Me.lblApproachedPersonDateTime.Visible = False
        '
        'lblSecondaryCompletePersonDateTime
        '
        Me.lblSecondaryCompletePersonDateTime.BackColor = System.Drawing.SystemColors.Control
        Me.lblSecondaryCompletePersonDateTime.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblSecondaryCompletePersonDateTime.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblSecondaryCompletePersonDateTime.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblSecondaryCompletePersonDateTime.Location = New System.Drawing.Point(158, 69)
        Me.lblSecondaryCompletePersonDateTime.Name = "lblSecondaryCompletePersonDateTime"
        Me.lblSecondaryCompletePersonDateTime.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblSecondaryCompletePersonDateTime.Size = New System.Drawing.Size(201, 17)
        Me.lblSecondaryCompletePersonDateTime.TabIndex = 200
        Me.lblSecondaryCompletePersonDateTime.Visible = False
        '
        'lblSystemEventsPersonDateTime
        '
        Me.lblSystemEventsPersonDateTime.BackColor = System.Drawing.SystemColors.Control
        Me.lblSystemEventsPersonDateTime.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblSystemEventsPersonDateTime.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblSystemEventsPersonDateTime.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblSystemEventsPersonDateTime.Location = New System.Drawing.Point(160, 46)
        Me.lblSystemEventsPersonDateTime.Name = "lblSystemEventsPersonDateTime"
        Me.lblSystemEventsPersonDateTime.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblSystemEventsPersonDateTime.Size = New System.Drawing.Size(193, 17)
        Me.lblSystemEventsPersonDateTime.TabIndex = 200
        Me.lblSystemEventsPersonDateTime.Visible = False
        '
        'lblCaseOpenPersonDateTime
        '
        Me.lblCaseOpenPersonDateTime.BackColor = System.Drawing.SystemColors.Control
        Me.lblCaseOpenPersonDateTime.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblCaseOpenPersonDateTime.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblCaseOpenPersonDateTime.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblCaseOpenPersonDateTime.Location = New System.Drawing.Point(160, 21)
        Me.lblCaseOpenPersonDateTime.Name = "lblCaseOpenPersonDateTime"
        Me.lblCaseOpenPersonDateTime.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblCaseOpenPersonDateTime.Size = New System.Drawing.Size(193, 17)
        Me.lblCaseOpenPersonDateTime.TabIndex = 200
        Me.lblCaseOpenPersonDateTime.Visible = False
        '
        '_TabDonor_TabPage2
        '
        Me._TabDonor_TabPage2.Controls.Add(Me.Label4)
        Me._TabDonor_TabPage2.Controls.Add(Me.rtbScheduleAlert)
        Me._TabDonor_TabPage2.Controls.Add(Me._Frame_3)
        Me._TabDonor_TabPage2.Controls.Add(Me._Frame_0)
        Me._TabDonor_TabPage2.Location = New System.Drawing.Point(4, 4)
        Me._TabDonor_TabPage2.Name = "_TabDonor_TabPage2"
        Me._TabDonor_TabPage2.Size = New System.Drawing.Size(1275, 593)
        Me._TabDonor_TabPage2.TabIndex = 200
        Me._TabDonor_TabPage2.Text = "Event Log"
        '
        'Label4
        '
        Me.Label4.AutoSize = True
        Me.Label4.BackColor = System.Drawing.SystemColors.Control
        Me.Label4.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label4.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label4.ForeColor = System.Drawing.Color.Black
        Me.Label4.Location = New System.Drawing.Point(1001, 115)
        Me.Label4.Name = "Label4"
        Me.Label4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label4.Size = New System.Drawing.Size(75, 14)
        Me.Label4.TabIndex = 210
        Me.Label4.Text = "Contact Alerts"
        '
        'rtbScheduleAlert
        '
        Me.rtbScheduleAlert.BackColor = System.Drawing.SystemColors.Window
        Me.rtbScheduleAlert.Location = New System.Drawing.Point(1000, 132)
        Me.rtbScheduleAlert.Name = "rtbScheduleAlert"
        Me.rtbScheduleAlert.ReadOnly = True
        Me.rtbScheduleAlert.Required = False
        Me.rtbScheduleAlert.Size = New System.Drawing.Size(270, 396)
        Me.rtbScheduleAlert.SpellCheckEnabled = False
        Me.rtbScheduleAlert.TabIndex = 209
        Me.rtbScheduleAlert.Text = ""
        '
        '_Frame_3
        '
        Me._Frame_3.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_3.Controls.Add(Me.chkViewLogEventDeleted)
        Me._Frame_3.Controls.Add(Me.CmdColorKey)
        Me._Frame_3.Controls.Add(Me.GbPendingCase)
        Me._Frame_3.Controls.Add(Me.CmdNewEvent)
        Me._Frame_3.Controls.Add(Me.CmdDelete)
        Me._Frame_3.Controls.Add(Me.CmdReferral)
        Me._Frame_3.Controls.Add(Me._Picture_1)
        Me._Frame_3.Controls.Add(Me.LstViewLogEvent)
        Me._Frame_3.Controls.Add(Me.LstViewPending)
        Me._Frame_3.Controls.Add(Me._Lable_19)
        Me._Frame_3.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Frame_3.Location = New System.Drawing.Point(9, 1)
        Me._Frame_3.Name = "_Frame_3"
        Me._Frame_3.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_3.Size = New System.Drawing.Size(985, 527)
        Me._Frame_3.TabIndex = 200
        Me._Frame_3.TabStop = False
        '
        'chkViewLogEventDeleted
        '
        Me.chkViewLogEventDeleted.BackColor = System.Drawing.SystemColors.Control
        Me.chkViewLogEventDeleted.Cursor = System.Windows.Forms.Cursors.Default
        Me.chkViewLogEventDeleted.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.chkViewLogEventDeleted.ForeColor = System.Drawing.SystemColors.ControlText
        Me.chkViewLogEventDeleted.Location = New System.Drawing.Point(390, 498)
        Me.chkViewLogEventDeleted.Name = "chkViewLogEventDeleted"
        Me.chkViewLogEventDeleted.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.chkViewLogEventDeleted.Size = New System.Drawing.Size(129, 19)
        Me.chkViewLogEventDeleted.TabIndex = 200
        Me.chkViewLogEventDeleted.Text = "Display All Events"
        Me.chkViewLogEventDeleted.UseVisualStyleBackColor = False
        '
        'CmdColorKey
        '
        Me.CmdColorKey.BackColor = System.Drawing.SystemColors.Control
        Me.CmdColorKey.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdColorKey.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdColorKey.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdColorKey.Location = New System.Drawing.Point(20, 496)
        Me.CmdColorKey.Name = "CmdColorKey"
        Me.CmdColorKey.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdColorKey.Size = New System.Drawing.Size(73, 21)
        Me.CmdColorKey.TabIndex = 200
        Me.CmdColorKey.TabStop = False
        Me.CmdColorKey.Text = "Color Key"
        Me.CmdColorKey.UseVisualStyleBackColor = False
        '
        'GbPendingCase
        '
        Me.GbPendingCase.Controls.Add(Me._LblPendingCaseCoordinator)
        Me.GbPendingCase.Controls.Add(Me.TxtPendingCaseComment)
        Me.GbPendingCase.Controls.Add(Me._LblPendingCaseComment)
        Me.GbPendingCase.Controls.Add(Me.CboPendingCaseCoordinator)
        Me.GbPendingCase.Controls.Add(Me.ChkPendingCase)
        Me.GbPendingCase.Location = New System.Drawing.Point(705, 8)
        Me.GbPendingCase.Name = "GbPendingCase"
        Me.GbPendingCase.Size = New System.Drawing.Size(271, 97)
        Me.GbPendingCase.TabIndex = 208
        Me.GbPendingCase.TabStop = False
        '
        '_LblPendingCaseCoordinator
        '
        Me._LblPendingCaseCoordinator.AutoSize = True
        Me._LblPendingCaseCoordinator.BackColor = System.Drawing.SystemColors.Control
        Me._LblPendingCaseCoordinator.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblPendingCaseCoordinator.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LblPendingCaseCoordinator.ForeColor = System.Drawing.Color.Black
        Me._LblPendingCaseCoordinator.Location = New System.Drawing.Point(11, 40)
        Me._LblPendingCaseCoordinator.Name = "_LblPendingCaseCoordinator"
        Me._LblPendingCaseCoordinator.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblPendingCaseCoordinator.Size = New System.Drawing.Size(66, 14)
        Me._LblPendingCaseCoordinator.TabIndex = 207
        Me._LblPendingCaseCoordinator.Text = "Coordinator:"
        '
        'TxtPendingCaseComment
        '
        Me.TxtPendingCaseComment.AcceptsReturn = True
        Me.TxtPendingCaseComment.BackColor = System.Drawing.SystemColors.Window
        Me.TxtPendingCaseComment.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtPendingCaseComment.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtPendingCaseComment.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtPendingCaseComment.Location = New System.Drawing.Point(83, 65)
        Me.TxtPendingCaseComment.MaxLength = 50
        Me.TxtPendingCaseComment.Name = "TxtPendingCaseComment"
        Me.TxtPendingCaseComment.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtPendingCaseComment.Size = New System.Drawing.Size(169, 20)
        Me.TxtPendingCaseComment.TabIndex = 210
        '
        '_LblPendingCaseComment
        '
        Me._LblPendingCaseComment.AutoSize = True
        Me._LblPendingCaseComment.BackColor = System.Drawing.SystemColors.Control
        Me._LblPendingCaseComment.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblPendingCaseComment.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LblPendingCaseComment.ForeColor = System.Drawing.Color.Black
        Me._LblPendingCaseComment.Location = New System.Drawing.Point(23, 66)
        Me._LblPendingCaseComment.Name = "_LblPendingCaseComment"
        Me._LblPendingCaseComment.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblPendingCaseComment.Size = New System.Drawing.Size(54, 14)
        Me._LblPendingCaseComment.TabIndex = 209
        Me._LblPendingCaseComment.Text = "Comment:"
        '
        'CboPendingCaseCoordinator
        '
        Me.CboPendingCaseCoordinator.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboPendingCaseCoordinator.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboPendingCaseCoordinator.BackColor = System.Drawing.Color.White
        Me.CboPendingCaseCoordinator.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboPendingCaseCoordinator.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboPendingCaseCoordinator.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboPendingCaseCoordinator.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboPendingCaseCoordinator.Location = New System.Drawing.Point(83, 37)
        Me.CboPendingCaseCoordinator.Name = "CboPendingCaseCoordinator"
        Me.CboPendingCaseCoordinator.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboPendingCaseCoordinator.Size = New System.Drawing.Size(169, 22)
        Me.CboPendingCaseCoordinator.TabIndex = 208
        Me.CboPendingCaseCoordinator.TabStop = False
        '
        'ChkPendingCase
        '
        Me.ChkPendingCase.AutoSize = True
        Me.ChkPendingCase.BackColor = System.Drawing.SystemColors.Control
        Me.ChkPendingCase.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkPendingCase.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkPendingCase.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkPendingCase.Location = New System.Drawing.Point(83, 17)
        Me.ChkPendingCase.Name = "ChkPendingCase"
        Me.ChkPendingCase.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkPendingCase.Size = New System.Drawing.Size(92, 18)
        Me.ChkPendingCase.TabIndex = 206
        Me.ChkPendingCase.Text = "Pending Case"
        Me.ChkPendingCase.UseVisualStyleBackColor = False
        '
        'CmdNewEvent
        '
        Me.CmdNewEvent.BackColor = System.Drawing.SystemColors.Control
        Me.CmdNewEvent.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdNewEvent.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdNewEvent.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdNewEvent.Location = New System.Drawing.Point(559, 78)
        Me.CmdNewEvent.Name = "CmdNewEvent"
        Me.CmdNewEvent.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdNewEvent.Size = New System.Drawing.Size(83, 21)
        Me.CmdNewEvent.TabIndex = 200
        Me.CmdNewEvent.TabStop = False
        Me.CmdNewEvent.Text = "New Event..."
        Me.CmdNewEvent.UseVisualStyleBackColor = False
        '
        'CmdDelete
        '
        Me.CmdDelete.BackColor = System.Drawing.SystemColors.Control
        Me.CmdDelete.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdDelete.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdDelete.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdDelete.Location = New System.Drawing.Point(890, 496)
        Me.CmdDelete.Name = "CmdDelete"
        Me.CmdDelete.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdDelete.Size = New System.Drawing.Size(79, 21)
        Me.CmdDelete.TabIndex = 200
        Me.CmdDelete.TabStop = False
        Me.CmdDelete.Text = "Delete Event"
        Me.CmdDelete.UseVisualStyleBackColor = False
        '
        'CmdReferral
        '
        Me.CmdReferral.BackColor = System.Drawing.SystemColors.Control
        Me.CmdReferral.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdReferral.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdReferral.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdReferral.Location = New System.Drawing.Point(559, 52)
        Me.CmdReferral.Name = "CmdReferral"
        Me.CmdReferral.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdReferral.Size = New System.Drawing.Size(83, 21)
        Me.CmdReferral.TabIndex = 200
        Me.CmdReferral.TabStop = False
        Me.CmdReferral.Text = "On Call..."
        Me.CmdReferral.UseVisualStyleBackColor = False
        '
        '_Picture_1
        '
        Me._Picture_1.BackColor = System.Drawing.SystemColors.Control
        Me._Picture_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._Picture_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Picture_1.ForeColor = System.Drawing.SystemColors.WindowText
        Me._Picture_1.Location = New System.Drawing.Point(690, 36)
        Me._Picture_1.Name = "_Picture_1"
        Me._Picture_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Picture_1.Size = New System.Drawing.Size(9, 69)
        Me._Picture_1.TabIndex = 200
        '
        'LstViewLogEvent
        '
        Me.LstViewLogEvent.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewLogEvent.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.LstViewLogEvent.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewLogEvent.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewLogEvent.FullRowSelect = True
        Me.LstViewLogEvent.HideSelection = False
        Me.LstViewLogEvent.LabelWrap = False
        Me.LstViewLogEvent.Location = New System.Drawing.Point(8, 114)
        Me.LstViewLogEvent.Name = "LstViewLogEvent"
        Me.LstViewLogEvent.Size = New System.Drawing.Size(968, 370)
        Me.LstViewLogEvent.TabIndex = 200
        Me.LstViewLogEvent.TabStop = False
        Me.LstViewLogEvent.UseCompatibleStateImageBehavior = False
        Me.LstViewLogEvent.View = System.Windows.Forms.View.Details
        '
        'LstViewPending
        '
        Me.LstViewPending.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewPending.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.LstViewPending.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewPending.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewPending.FullRowSelect = True
        Me.LstViewPending.HideSelection = False
        Me.LstViewPending.LabelWrap = False
        Me.LstViewPending.Location = New System.Drawing.Point(8, 28)
        Me.LstViewPending.Name = "LstViewPending"
        Me.LstViewPending.Size = New System.Drawing.Size(533, 83)
        Me.LstViewPending.TabIndex = 200
        Me.LstViewPending.TabStop = False
        Me.LstViewPending.UseCompatibleStateImageBehavior = False
        Me.LstViewPending.View = System.Windows.Forms.View.Details
        '
        '_Lable_19
        '
        Me._Lable_19.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_19.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_19.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_19.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Lable_19.Location = New System.Drawing.Point(8, 13)
        Me._Lable_19.Name = "_Lable_19"
        Me._Lable_19.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_19.Size = New System.Drawing.Size(121, 15)
        Me._Lable_19.TabIndex = 200
        Me._Lable_19.Text = "Pending Events"
        '
        '_Frame_0
        '
        Me._Frame_0.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_0.Controls.Add(Me.TxtCallDate)
        Me._Frame_0.Controls.Add(Me.TxtTotalTimeCounter)
        Me._Frame_0.Controls.Add(Me.CboCallByEmployee)
        Me._Frame_0.Controls.Add(Me._LblReferral_20)
        Me._Frame_0.Controls.Add(Me._LblReferral_27)
        Me._Frame_0.Controls.Add(Me._LblReferral_28)
        Me._Frame_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Frame_0.Location = New System.Drawing.Point(9, 534)
        Me._Frame_0.Name = "_Frame_0"
        Me._Frame_0.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_0.Size = New System.Drawing.Size(984, 47)
        Me._Frame_0.TabIndex = 200
        Me._Frame_0.TabStop = False
        '
        'TxtCallDate
        '
        Me.TxtCallDate.AcceptsReturn = True
        Me.TxtCallDate.BackColor = System.Drawing.Color.White
        Me.TxtCallDate.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtCallDate.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtCallDate.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtCallDate.Location = New System.Drawing.Point(73, 16)
        Me.TxtCallDate.MaxLength = 0
        Me.TxtCallDate.Name = "TxtCallDate"
        Me.TxtCallDate.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtCallDate.Size = New System.Drawing.Size(87, 20)
        Me.TxtCallDate.TabIndex = 200
        Me.TxtCallDate.TabStop = False
        Me.TxtCallDate.Text = "00/00/00  00:00"
        '
        'TxtTotalTimeCounter
        '
        Me.TxtTotalTimeCounter.AcceptsReturn = True
        Me.TxtTotalTimeCounter.BackColor = System.Drawing.SystemColors.Control
        Me.TxtTotalTimeCounter.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtTotalTimeCounter.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtTotalTimeCounter.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtTotalTimeCounter.Location = New System.Drawing.Point(917, 16)
        Me.TxtTotalTimeCounter.MaxLength = 0
        Me.TxtTotalTimeCounter.Name = "TxtTotalTimeCounter"
        Me.TxtTotalTimeCounter.ReadOnly = True
        Me.TxtTotalTimeCounter.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtTotalTimeCounter.Size = New System.Drawing.Size(51, 20)
        Me.TxtTotalTimeCounter.TabIndex = 200
        Me.TxtTotalTimeCounter.TabStop = False
        Me.TxtTotalTimeCounter.Text = "00:00:00"
        '
        'CboCallByEmployee
        '
        Me.CboCallByEmployee.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboCallByEmployee.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboCallByEmployee.BackColor = System.Drawing.Color.White
        Me.CboCallByEmployee.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboCallByEmployee.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboCallByEmployee.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboCallByEmployee.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboCallByEmployee.Location = New System.Drawing.Point(375, 15)
        Me.CboCallByEmployee.Name = "CboCallByEmployee"
        Me.CboCallByEmployee.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboCallByEmployee.Size = New System.Drawing.Size(143, 22)
        Me.CboCallByEmployee.TabIndex = 200
        Me.CboCallByEmployee.TabStop = False
        '
        '_LblReferral_20
        '
        Me._LblReferral_20.AutoSize = True
        Me._LblReferral_20.BackColor = System.Drawing.SystemColors.Control
        Me._LblReferral_20.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblReferral_20.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LblReferral_20.ForeColor = System.Drawing.Color.Black
        Me._LblReferral_20.Location = New System.Drawing.Point(355, 19)
        Me._LblReferral_20.Name = "_LblReferral_20"
        Me._LblReferral_20.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblReferral_20.Size = New System.Drawing.Size(20, 14)
        Me._LblReferral_20.TabIndex = 200
        Me._LblReferral_20.Text = "By"
        '
        '_LblReferral_27
        '
        Me._LblReferral_27.AutoSize = True
        Me._LblReferral_27.BackColor = System.Drawing.SystemColors.Control
        Me._LblReferral_27.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblReferral_27.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LblReferral_27.ForeColor = System.Drawing.Color.Black
        Me._LblReferral_27.Location = New System.Drawing.Point(20, 19)
        Me._LblReferral_27.Name = "_LblReferral_27"
        Me._LblReferral_27.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblReferral_27.Size = New System.Drawing.Size(49, 14)
        Me._LblReferral_27.TabIndex = 200
        Me._LblReferral_27.Text = "Call Date"
        '
        '_LblReferral_28
        '
        Me._LblReferral_28.AutoSize = True
        Me._LblReferral_28.BackColor = System.Drawing.SystemColors.Control
        Me._LblReferral_28.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblReferral_28.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LblReferral_28.ForeColor = System.Drawing.Color.Black
        Me._LblReferral_28.Location = New System.Drawing.Point(842, 19)
        Me._LblReferral_28.Name = "_LblReferral_28"
        Me._LblReferral_28.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblReferral_28.Size = New System.Drawing.Size(74, 14)
        Me._LblReferral_28.TabIndex = 200
        Me._LblReferral_28.Text = "Total Call Time"
        '
        'Label2
        '
        Me.Label2.BackColor = System.Drawing.SystemColors.Control
        Me.Label2.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label2.Location = New System.Drawing.Point(472, 296)
        Me.Label2.Name = "Label2"
        Me.Label2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label2.Size = New System.Drawing.Size(81, 33)
        Me.Label2.TabIndex = 200
        Me.Label2.Text = "Label2"
        '
        'Label3
        '
        Me.Label3.BackColor = System.Drawing.Color.Red
        Me.Label3.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label3.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label3.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label3.Location = New System.Drawing.Point(202, 2)
        Me.Label3.Name = "Label3"
        Me.Label3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label3.Size = New System.Drawing.Size(265, 9)
        Me.Label3.TabIndex = 200
        Me.Label3.Text = "Label2"
        '
        'TimerTotalTime
        '
        Me.TimerTotalTime.Enabled = True
        Me.TimerTotalTime.Interval = 1000
        '
        'FrmReferral
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 14.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.ClientSize = New System.Drawing.Size(1334, 661)
        Me.Controls.Add(Me.ChkExclusive)
        Me.Controls.Add(Me.CmdOK)
        Me.Controls.Add(Me.ChkTemp)
        Me.Controls.Add(Me.ChkQAReview)
        Me.Controls.Add(Me._Frame_1)
        Me.Controls.Add(Me.CboReferralType)
        Me.Controls.Add(Me.CmdCancel)
        Me.Controls.Add(Me.TabDonor)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.Label3)
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ForeColor = System.Drawing.Color.FromArgb(CType(CType(255, Byte), Integer), CType(CType(128, Byte), Integer), CType(CType(0, Byte), Integer))
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.KeyPreview = True
        Me.Name = "FrmReferral"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Call #"
        Me._Frame_1.ResumeLayout(False)
        Me._Frame_1.PerformLayout()
        Me.TabDonor.ResumeLayout(False)
        Me._TabDonor_TabPage0.ResumeLayout(False)
        Me._Picture_2.ResumeLayout(False)
        Me._Picture_2.PerformLayout()
        Me.TabDisposition.ResumeLayout(False)
        Me._TabDisposition_TabPage0.ResumeLayout(False)
        Me._TabDisposition_TabPage1.ResumeLayout(False)
        Me._TabDisposition_TabPage2.ResumeLayout(False)
        Me._TabDisposition_TabPage2.PerformLayout()
        Me._Frame_5.ResumeLayout(False)
        Me._Frame_5.PerformLayout
        Me._Frame_4.ResumeLayout(False)
        Me._Frame_4.PerformLayout
        Me.Frame1.ResumeLayout(False)
        Me.Frame1.PerformLayout
        Me._TabDonor_TabPage1.ResumeLayout(False)
        Me.FrameTBINumber.ResumeLayout(False)
        Me.FrameTBINumber.PerformLayout
        Me._Frame_6.ResumeLayout(False)
        Me._Frame_7.ResumeLayout(False)
        Me._TabDonor_TabPage2.ResumeLayout(False)
        Me._TabDonor_TabPage2.PerformLayout
        Me._Frame_3.ResumeLayout(False)
        Me.GbPendingCase.ResumeLayout(False)
        Me.GbPendingCase.PerformLayout
        Me._Frame_0.ResumeLayout(False)
        Me._Frame_0.PerformLayout
        Me.ResumeLayout(False)

    End Sub
#End Region

    Private Sub Timer1_Disposed(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub
    Public WithEvents LstViewVerify As System.Windows.Forms.ListView
    Public WithEvents TimerTotalTime As System.Windows.Forms.Timer
    Friend WithEvents LblLSA As Statline.Stattrac.Windows.Forms.Label
    Public WithEvents lblPNELabel As System.Windows.Forms.Label
    Public WithEvents lblPNEBorderLeft As Statline.Stattrac.Windows.Forms.Label
    Public WithEvents lblPNEBorderRight As Statline.Stattrac.Windows.Forms.Label
    Public WithEvents TxtLSATime As System.Windows.Forms.TextBox
    Public WithEvents TxtLSADate As System.Windows.Forms.TextBox
    Friend WithEvents rtbSearching As Statline.Stattrac.Windows.Forms.RichTextBox
    Friend WithEvents LowMemoryWarning As Statline.Stattrac.Windows.Forms.Button
    Public WithEvents CmdDcdPotential As Button
    Public WithEvents cboDCDPotential As Statline.Stattrac.Windows.Forms.ComboBox
    Friend WithEvents GbPendingCase As Statline.Stattrac.Windows.Forms.GroupBox
    Public WithEvents _LblPendingCaseCoordinator As Label
    Public WithEvents TxtPendingCaseComment As TextBox
    Public WithEvents _LblPendingCaseComment As Label
    Public WithEvents CboPendingCaseCoordinator As ComboBox
    Public WithEvents ChkPendingCase As CheckBox
    Friend WithEvents rtbScheduleAlert As Statline.Stattrac.Windows.Forms.RichTextBox
    Public WithEvents Label4 As Label
    Public WithEvents LabelEReferral As Label
End Class
