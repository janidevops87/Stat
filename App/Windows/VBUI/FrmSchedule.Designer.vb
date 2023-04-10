
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmSchedule
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
    Public WithEvents MnuCreateShift As System.Windows.Forms.ToolStripMenuItem
    Public WithEvents MnuEditShift As System.Windows.Forms.ToolStripMenuItem
    Public WithEvents MnuSplitShift As System.Windows.Forms.ToolStripMenuItem
    Public WithEvents MnuInsertShift As System.Windows.Forms.ToolStripMenuItem
    Public WithEvents MnuShifts As System.Windows.Forms.ToolStripMenuItem
    Public WithEvents MainMenu1 As System.Windows.Forms.MenuStrip
    Public WithEvents CmdPrintList As System.Windows.Forms.Button
    Public WithEvents CmdCancel As System.Windows.Forms.Button
    Public CommonDialog1Color As System.Windows.Forms.ColorDialog
    Public WithEvents CmdSelectParentOrg As System.Windows.Forms.Button
    Public WithEvents CmdScheduleDetail As System.Windows.Forms.Button
    Public WithEvents CboScheduleGroup As System.Windows.Forms.ComboBox
    Public WithEvents CboYear As System.Windows.Forms.ComboBox
    Public WithEvents CboOrganization As System.Windows.Forms.ComboBox
    Public WithEvents CboMonth As System.Windows.Forms.ComboBox
    Public WithEvents ProgressBar As System.Windows.Forms.ProgressBar
    Public WithEvents _Lable_4 As System.Windows.Forms.Label
    Public WithEvents _Lable_3 As System.Windows.Forms.Label
    Public WithEvents _Lable_2 As System.Windows.Forms.Label
    Public WithEvents _Lable_0 As System.Windows.Forms.Label
    Public WithEvents _Frame_1 As System.Windows.Forms.GroupBox
    Public WithEvents CmdOK As System.Windows.Forms.Button
    Public WithEvents ChkActive As System.Windows.Forms.CheckBox
    Public WithEvents PicGrid As System.Windows.Forms.Panel
    Public WithEvents CmdRefresh As System.Windows.Forms.Button
    Public WithEvents _TabSchedule_TabPage0 As System.Windows.Forms.TabPage
    Public WithEvents CmdUnassigned As System.Windows.Forms.Button
    Public WithEvents CmdSelect As System.Windows.Forms.Button
    Public WithEvents CmdDeselect As System.Windows.Forms.Button
    Public WithEvents CboOrganizationType As System.Windows.Forms.ComboBox
    Public WithEvents CmdFind As System.Windows.Forms.Button
    Public WithEvents CboState As System.Windows.Forms.ComboBox
    Public WithEvents LstViewAvailableOrganizations As System.Windows.Forms.ListView
    Public WithEvents LstViewSelectedOrganizations As System.Windows.Forms.ListView
    Public WithEvents _Lable_6 As System.Windows.Forms.Label
    Public WithEvents _LblOpenOrg_0 As System.Windows.Forms.Label
    Public WithEvents _Lable_5 As System.Windows.Forms.Label
    Public WithEvents _Lable_7 As System.Windows.Forms.Label
    Public WithEvents _Frame_0 As System.Windows.Forms.GroupBox
    Public WithEvents _TabSchedule_TabPage1 As System.Windows.Forms.TabPage
    Public WithEvents CmdEdit As System.Windows.Forms.Button
    Public WithEvents CmdRemove As System.Windows.Forms.Button
    Public WithEvents CmdAdd As System.Windows.Forms.Button
    Public WithEvents LstViewShifts As System.Windows.Forms.ListView
    Public WithEvents _Frame_2 As System.Windows.Forms.GroupBox
    Public WithEvents _TabSchedule_TabPage2 As System.Windows.Forms.TabPage
    Public WithEvents TxtScheduleReferralNotes As System.Windows.Forms.RichTextBox
    Public WithEvents _Label_2 As System.Windows.Forms.Label
    Public WithEvents _Frame_3 As System.Windows.Forms.GroupBox
    Public WithEvents TxtReferralNotes As System.Windows.Forms.RichTextBox
    Public WithEvents _Label_1 As System.Windows.Forms.Label
    Public WithEvents _Frame_4 As System.Windows.Forms.GroupBox
    Public WithEvents TxtMessageNotes As System.Windows.Forms.RichTextBox
    Public WithEvents _Label_0 As System.Windows.Forms.Label
    Public WithEvents _Frame_5 As System.Windows.Forms.GroupBox
    Public WithEvents TxtScheduleMessageNotes As System.Windows.Forms.RichTextBox
    Public WithEvents _Label_3 As System.Windows.Forms.Label
    Public WithEvents _Frame_6 As System.Windows.Forms.GroupBox
    Public WithEvents _TabSchedule_TabPage3 As System.Windows.Forms.TabPage
    Public WithEvents CmdAddSource As System.Windows.Forms.Button
    Public WithEvents CmdRemoveSource As System.Windows.Forms.Button
    Public WithEvents LstViewSourceCodes As System.Windows.Forms.ListView
    Public WithEvents _Lable_20 As System.Windows.Forms.Label
    Public WithEvents _Lable_19 As System.Windows.Forms.Label
    Public WithEvents _Lable_8 As System.Windows.Forms.Label
    Public WithEvents _Frame_7 As System.Windows.Forms.GroupBox
    Public WithEvents _TabSchedule_TabPage4 As System.Windows.Forms.TabPage
    Public WithEvents CmdInsertShift As System.Windows.Forms.Button
    Public WithEvents CmdAddPerson As System.Windows.Forms.Button
    Public WithEvents CmdSplitShift As System.Windows.Forms.Button
    Public WithEvents CmdRemoveShift As System.Windows.Forms.Button
    Public WithEvents CmdEditShift As System.Windows.Forms.Button
    Public WithEvents CmdCreateShift As System.Windows.Forms.Button
    Public WithEvents CmdGetSchedule As System.Windows.Forms.Button
    Public WithEvents _OptDates_1 As System.Windows.Forms.RadioButton
    Public WithEvents _OptDates_0 As System.Windows.Forms.RadioButton
    Public WithEvents _Label_5 As System.Windows.Forms.Label
    Public WithEvents _Label_4 As System.Windows.Forms.Label
    Public WithEvents _Frame_8 As System.Windows.Forms.GroupBox
    Public WithEvents _TabSchedule_TabPage5 As System.Windows.Forms.TabPage
    Public WithEvents CmdRefreshLog As System.Windows.Forms.Button
    Public WithEvents _Label_7 As System.Windows.Forms.Label
    Public WithEvents _Label_6 As System.Windows.Forms.Label
    Public WithEvents _Frame_10 As System.Windows.Forms.GroupBox
    Public WithEvents _TabSchedule_TabPage6 As System.Windows.Forms.TabPage
    Public WithEvents CmdSelectPerson As System.Windows.Forms.Button
    Public WithEvents CmdDeselectPerson As System.Windows.Forms.Button
    Public WithEvents LstViewAvailablePerson As System.Windows.Forms.ListView
    Public WithEvents LstViewSelectedPerson As System.Windows.Forms.ListView
    Public WithEvents _Frame_9 As System.Windows.Forms.GroupBox
    Public WithEvents _TabSchedule_TabPage7 As System.Windows.Forms.TabPage
    Public WithEvents TabSchedule As System.Windows.Forms.TabControl
    Public WithEvents Frame As Microsoft.VisualBasic.Compatibility.VB6.GroupBoxArray
    Public WithEvents Label As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
    Public WithEvents Lable As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
    Public WithEvents LblOpenOrg As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
    Public WithEvents OptDates As Microsoft.VisualBasic.Compatibility.VB6.RadioButtonArray
    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container
        Dim DateButton5 As Infragistics.Win.UltraWinSchedule.CalendarCombo.DateButton = New Infragistics.Win.UltraWinSchedule.CalendarCombo.DateButton
        Dim DateButton2 As Infragistics.Win.UltraWinSchedule.CalendarCombo.DateButton = New Infragistics.Win.UltraWinSchedule.CalendarCombo.DateButton
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FrmSchedule))
        Dim UltraGridBand1 As Infragistics.Win.UltraWinGrid.UltraGridBand = New Infragistics.Win.UltraWinGrid.UltraGridBand("Schedule", -1)
        Dim UltraGridColumn35 As Infragistics.Win.UltraWinGrid.UltraGridColumn = New Infragistics.Win.UltraWinGrid.UltraGridColumn("ScheduleItemID")
        Dim UltraGridColumn36 As Infragistics.Win.UltraWinGrid.UltraGridColumn = New Infragistics.Win.UltraWinGrid.UltraGridColumn("ScheduleGroupID")
        Dim UltraGridColumn37 As Infragistics.Win.UltraWinGrid.UltraGridColumn = New Infragistics.Win.UltraWinGrid.UltraGridColumn("ScheduleItemName")
        Dim UltraGridColumn38 As Infragistics.Win.UltraWinGrid.UltraGridColumn = New Infragistics.Win.UltraWinGrid.UltraGridColumn("ScheduleItemStartDate")
        Dim UltraGridColumn39 As Infragistics.Win.UltraWinGrid.UltraGridColumn = New Infragistics.Win.UltraWinGrid.UltraGridColumn("StartTime")
        Dim UltraGridColumn40 As Infragistics.Win.UltraWinGrid.UltraGridColumn = New Infragistics.Win.UltraWinGrid.UltraGridColumn("ScheduleStartDateTime")
        Dim UltraGridColumn41 As Infragistics.Win.UltraWinGrid.UltraGridColumn = New Infragistics.Win.UltraWinGrid.UltraGridColumn("ScheduleItemEndDate")
        Dim UltraGridColumn42 As Infragistics.Win.UltraWinGrid.UltraGridColumn = New Infragistics.Win.UltraWinGrid.UltraGridColumn("EndTime")
        Dim UltraGridColumn43 As Infragistics.Win.UltraWinGrid.UltraGridColumn = New Infragistics.Win.UltraWinGrid.UltraGridColumn("ScheduleEndDateTime")
        Dim UltraGridColumn44 As Infragistics.Win.UltraWinGrid.UltraGridColumn = New Infragistics.Win.UltraWinGrid.UltraGridColumn("Person1")
        Dim UltraGridColumn45 As Infragistics.Win.UltraWinGrid.UltraGridColumn = New Infragistics.Win.UltraWinGrid.UltraGridColumn("Person2")
        Dim UltraGridColumn46 As Infragistics.Win.UltraWinGrid.UltraGridColumn = New Infragistics.Win.UltraWinGrid.UltraGridColumn("Person3")
        Dim UltraGridColumn47 As Infragistics.Win.UltraWinGrid.UltraGridColumn = New Infragistics.Win.UltraWinGrid.UltraGridColumn("Person4")
        Dim UltraGridColumn48 As Infragistics.Win.UltraWinGrid.UltraGridColumn = New Infragistics.Win.UltraWinGrid.UltraGridColumn("Person5")
        Dim UltraGridColumn49 As Infragistics.Win.UltraWinGrid.UltraGridColumn = New Infragistics.Win.UltraWinGrid.UltraGridColumn("Person6")
        Dim UltraGridColumn50 As Infragistics.Win.UltraWinGrid.UltraGridColumn = New Infragistics.Win.UltraWinGrid.UltraGridColumn("Person7")
        Dim UltraGridColumn51 As Infragistics.Win.UltraWinGrid.UltraGridColumn = New Infragistics.Win.UltraWinGrid.UltraGridColumn("Person8")
        Dim UltraGridColumn52 As Infragistics.Win.UltraWinGrid.UltraGridColumn = New Infragistics.Win.UltraWinGrid.UltraGridColumn("Person9")
        Dim UltraGridColumn53 As Infragistics.Win.UltraWinGrid.UltraGridColumn = New Infragistics.Win.UltraWinGrid.UltraGridColumn("Person10")
        Dim UltraGridColumn54 As Infragistics.Win.UltraWinGrid.UltraGridColumn = New Infragistics.Win.UltraWinGrid.UltraGridColumn("Person11")
        Dim UltraGridColumn55 As Infragistics.Win.UltraWinGrid.UltraGridColumn = New Infragistics.Win.UltraWinGrid.UltraGridColumn("Person12")
        Dim UltraGridColumn56 As Infragistics.Win.UltraWinGrid.UltraGridColumn = New Infragistics.Win.UltraWinGrid.UltraGridColumn("Person13")
        Dim UltraGridColumn57 As Infragistics.Win.UltraWinGrid.UltraGridColumn = New Infragistics.Win.UltraWinGrid.UltraGridColumn("Person14")
        Dim UltraGridColumn58 As Infragistics.Win.UltraWinGrid.UltraGridColumn = New Infragistics.Win.UltraWinGrid.UltraGridColumn("Person15")
        Dim UltraGridColumn59 As Infragistics.Win.UltraWinGrid.UltraGridColumn = New Infragistics.Win.UltraWinGrid.UltraGridColumn("Person16")
        Dim UltraGridColumn60 As Infragistics.Win.UltraWinGrid.UltraGridColumn = New Infragistics.Win.UltraWinGrid.UltraGridColumn("Person17")
        Dim UltraGridColumn61 As Infragistics.Win.UltraWinGrid.UltraGridColumn = New Infragistics.Win.UltraWinGrid.UltraGridColumn("Person18")
        Dim Appearance4 As Infragistics.Win.Appearance = New Infragistics.Win.Appearance
        Dim Appearance1 As Infragistics.Win.Appearance = New Infragistics.Win.Appearance
        Dim DateButton1 As Infragistics.Win.UltraWinSchedule.CalendarCombo.DateButton = New Infragistics.Win.UltraWinSchedule.CalendarCombo.DateButton
        Dim UltraGridBand2 As Infragistics.Win.UltraWinGrid.UltraGridBand = New Infragistics.Win.UltraWinGrid.UltraGridBand("ScheduleLog", -1)
        Dim UltraGridColumn62 As Infragistics.Win.UltraWinGrid.UltraGridColumn = New Infragistics.Win.UltraWinGrid.UltraGridColumn("ScheduleLogID")
        Dim UltraGridColumn63 As Infragistics.Win.UltraWinGrid.UltraGridColumn = New Infragistics.Win.UltraWinGrid.UltraGridColumn("PersonID")
        Dim UltraGridColumn64 As Infragistics.Win.UltraWinGrid.UltraGridColumn = New Infragistics.Win.UltraWinGrid.UltraGridColumn("ScheduleLogDateTime")
        Dim UltraGridColumn65 As Infragistics.Win.UltraWinGrid.UltraGridColumn = New Infragistics.Win.UltraWinGrid.UltraGridColumn("PersonName")
        Dim UltraGridColumn66 As Infragistics.Win.UltraWinGrid.UltraGridColumn = New Infragistics.Win.UltraWinGrid.UltraGridColumn("ScheduleLogType")
        Dim UltraGridColumn67 As Infragistics.Win.UltraWinGrid.UltraGridColumn = New Infragistics.Win.UltraWinGrid.UltraGridColumn("ScheduleLogShift")
        Dim UltraGridColumn68 As Infragistics.Win.UltraWinGrid.UltraGridColumn = New Infragistics.Win.UltraWinGrid.UltraGridColumn("ScheduleLogChange")
        Dim Appearance2 As Infragistics.Win.Appearance = New Infragistics.Win.Appearance
        Dim DateButton3 As Infragistics.Win.UltraWinSchedule.CalendarCombo.DateButton = New Infragistics.Win.UltraWinSchedule.CalendarCombo.DateButton
        Dim DateButton4 As Infragistics.Win.UltraWinSchedule.CalendarCombo.DateButton = New Infragistics.Win.UltraWinSchedule.CalendarCombo.DateButton
        Me.UltraCalendarCombo = New Infragistics.Win.UltraWinSchedule.UltraCalendarCombo
        Me.UltraCalendarInfo = New Infragistics.Win.UltraWinSchedule.UltraCalendarInfo(Me.components)
        Me.CboFromDate = New Infragistics.Win.UltraWinSchedule.UltraCalendarCombo
        Me.MainMenu1 = New System.Windows.Forms.MenuStrip
        Me.MnuShifts = New System.Windows.Forms.ToolStripMenuItem
        Me.MnuCreateShift = New System.Windows.Forms.ToolStripMenuItem
        Me.MnuEditShift = New System.Windows.Forms.ToolStripMenuItem
        Me.MnuSplitShift = New System.Windows.Forms.ToolStripMenuItem
        Me.MnuInsertShift = New System.Windows.Forms.ToolStripMenuItem
        Me.CmdPrintList = New System.Windows.Forms.Button
        Me.CmdCancel = New System.Windows.Forms.Button
        Me._Frame_1 = New System.Windows.Forms.GroupBox
        Me.CmdSelectParentOrg = New System.Windows.Forms.Button
        Me.CmdScheduleDetail = New System.Windows.Forms.Button
        Me.CboScheduleGroup = New System.Windows.Forms.ComboBox
        Me.CboYear = New System.Windows.Forms.ComboBox
        Me.CboOrganization = New System.Windows.Forms.ComboBox
        Me.CboMonth = New System.Windows.Forms.ComboBox
        Me.ProgressBar = New System.Windows.Forms.ProgressBar
        Me._Lable_4 = New System.Windows.Forms.Label
        Me._Lable_3 = New System.Windows.Forms.Label
        Me._Lable_2 = New System.Windows.Forms.Label
        Me._Lable_0 = New System.Windows.Forms.Label
        Me.CmdOK = New System.Windows.Forms.Button
        Me.TabSchedule = New System.Windows.Forms.TabControl
        Me._TabSchedule_TabPage0 = New System.Windows.Forms.TabPage
        Me.ChkActive = New System.Windows.Forms.CheckBox
        Me.PicGrid = New System.Windows.Forms.Panel
        Me.CmdRefresh = New System.Windows.Forms.Button
        Me._TabSchedule_TabPage1 = New System.Windows.Forms.TabPage
        Me._Frame_0 = New System.Windows.Forms.GroupBox
        Me.CmdUnassigned = New System.Windows.Forms.Button
        Me.CmdSelect = New System.Windows.Forms.Button
        Me.CmdDeselect = New System.Windows.Forms.Button
        Me.CboOrganizationType = New System.Windows.Forms.ComboBox
        Me.CmdFind = New System.Windows.Forms.Button
        Me.CboState = New System.Windows.Forms.ComboBox
        Me.LstViewAvailableOrganizations = New System.Windows.Forms.ListView
        Me.LstViewSelectedOrganizations = New System.Windows.Forms.ListView
        Me._Lable_6 = New System.Windows.Forms.Label
        Me._LblOpenOrg_0 = New System.Windows.Forms.Label
        Me._Lable_5 = New System.Windows.Forms.Label
        Me._Lable_7 = New System.Windows.Forms.Label
        Me._TabSchedule_TabPage2 = New System.Windows.Forms.TabPage
        Me._Frame_2 = New System.Windows.Forms.GroupBox
        Me.CmdEdit = New System.Windows.Forms.Button
        Me.CmdRemove = New System.Windows.Forms.Button
        Me.CmdAdd = New System.Windows.Forms.Button
        Me.LstViewShifts = New System.Windows.Forms.ListView
        Me._TabSchedule_TabPage3 = New System.Windows.Forms.TabPage
        Me.Frame1 = New System.Windows.Forms.GroupBox
        Me.Toolbar1 = New System.Windows.Forms.ToolStrip
        Me.bold = New System.Windows.Forms.ToolStripButton
        Me.italic = New System.Windows.Forms.ToolStripButton
        Me._Toolbar1_Button4 = New System.Windows.Forms.ToolStripSeparator
        Me.underline = New System.Windows.Forms.ToolStripButton
        Me.color = New System.Windows.Forms.ToolStripButton
        Me._Toolbar1_Button6 = New System.Windows.Forms.ToolStripSeparator
        Me.left = New System.Windows.Forms.ToolStripButton
        Me.center = New System.Windows.Forms.ToolStripButton
        Me.right = New System.Windows.Forms.ToolStripButton
        Me._Toolbar1_Button10 = New System.Windows.Forms.ToolStripSeparator
        Me.bullet = New System.Windows.Forms.ToolStripButton
        Me.cmbsize = New System.Windows.Forms.ComboBox
        Me.cmbfont = New System.Windows.Forms.ComboBox
        Me._Frame_3 = New System.Windows.Forms.GroupBox
        Me.TxtScheduleReferralNotes = New System.Windows.Forms.RichTextBox
        Me._Label_2 = New System.Windows.Forms.Label
        Me._Frame_4 = New System.Windows.Forms.GroupBox
        Me.TxtReferralNotes = New System.Windows.Forms.RichTextBox
        Me._Label_1 = New System.Windows.Forms.Label
        Me._Frame_5 = New System.Windows.Forms.GroupBox
        Me.TxtMessageNotes = New System.Windows.Forms.RichTextBox
        Me._Label_0 = New System.Windows.Forms.Label
        Me._Frame_6 = New System.Windows.Forms.GroupBox
        Me.TxtScheduleMessageNotes = New System.Windows.Forms.RichTextBox
        Me._Label_3 = New System.Windows.Forms.Label
        Me._TabSchedule_TabPage4 = New System.Windows.Forms.TabPage
        Me._Frame_7 = New System.Windows.Forms.GroupBox
        Me.CmdAddSource = New System.Windows.Forms.Button
        Me.CmdRemoveSource = New System.Windows.Forms.Button
        Me.LstViewSourceCodes = New System.Windows.Forms.ListView
        Me._Lable_20 = New System.Windows.Forms.Label
        Me._Lable_19 = New System.Windows.Forms.Label
        Me._Lable_8 = New System.Windows.Forms.Label
        Me._TabSchedule_TabPage5 = New System.Windows.Forms.TabPage
        Me.ugSchedule = New Infragistics.Win.UltraWinGrid.UltraGrid
        Me.ScheduleDS = New Statline.Stattrac.Data.Types.Schedule.ScheduleDS
        Me._Frame_8 = New System.Windows.Forms.GroupBox
        Me.CboToDate = New Infragistics.Win.UltraWinSchedule.UltraCalendarCombo
        Me.CmdInsertShift = New System.Windows.Forms.Button
        Me.CmdAddPerson = New System.Windows.Forms.Button
        Me.CmdSplitShift = New System.Windows.Forms.Button
        Me.CmdRemoveShift = New System.Windows.Forms.Button
        Me.CmdEditShift = New System.Windows.Forms.Button
        Me.CmdCreateShift = New System.Windows.Forms.Button
        Me.CmdGetSchedule = New System.Windows.Forms.Button
        Me._OptDates_1 = New System.Windows.Forms.RadioButton
        Me._OptDates_0 = New System.Windows.Forms.RadioButton
        Me._Label_5 = New System.Windows.Forms.Label
        Me._Label_4 = New System.Windows.Forms.Label
        Me._TabSchedule_TabPage6 = New System.Windows.Forms.TabPage
        Me.ugScheduleLog = New Infragistics.Win.UltraWinGrid.UltraGrid
        Me.ScheduleLogDS = New Statline.Stattrac.Data.Types.Schedule.ScheduleLogDS
        Me._Frame_10 = New System.Windows.Forms.GroupBox
        Me.CboLogToDate = New Infragistics.Win.UltraWinSchedule.UltraCalendarCombo
        Me.CboLogFromDate = New Infragistics.Win.UltraWinSchedule.UltraCalendarCombo
        Me.CmdRefreshLog = New System.Windows.Forms.Button
        Me._Label_7 = New System.Windows.Forms.Label
        Me._Label_6 = New System.Windows.Forms.Label
        Me._TabSchedule_TabPage7 = New System.Windows.Forms.TabPage
        Me._Frame_9 = New System.Windows.Forms.GroupBox
        Me.CmdSelectPerson = New System.Windows.Forms.Button
        Me.CmdDeselectPerson = New System.Windows.Forms.Button
        Me.LstViewAvailablePerson = New System.Windows.Forms.ListView
        Me.LstViewSelectedPerson = New System.Windows.Forms.ListView
        Me.CommonDialog1Color = New System.Windows.Forms.ColorDialog
        Me.OptDates = New Microsoft.VisualBasic.Compatibility.VB6.RadioButtonArray(Me.components)
        CType(Me.UltraCalendarCombo, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.CboFromDate, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.MainMenu1.SuspendLayout()
        Me._Frame_1.SuspendLayout()
        Me.TabSchedule.SuspendLayout()
        Me._TabSchedule_TabPage0.SuspendLayout()
        Me._TabSchedule_TabPage1.SuspendLayout()
        Me._Frame_0.SuspendLayout()
        Me._TabSchedule_TabPage2.SuspendLayout()
        Me._Frame_2.SuspendLayout()
        Me._TabSchedule_TabPage3.SuspendLayout()
        Me.Frame1.SuspendLayout()
        Me.Toolbar1.SuspendLayout()
        Me._Frame_3.SuspendLayout()
        Me._Frame_4.SuspendLayout()
        Me._Frame_5.SuspendLayout()
        Me._Frame_6.SuspendLayout()
        Me._TabSchedule_TabPage4.SuspendLayout()
        Me._Frame_7.SuspendLayout()
        Me._TabSchedule_TabPage5.SuspendLayout()
        CType(Me.ugSchedule, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.ScheduleDS, System.ComponentModel.ISupportInitialize).BeginInit()
        Me._Frame_8.SuspendLayout()
        CType(Me.CboToDate, System.ComponentModel.ISupportInitialize).BeginInit()
        Me._TabSchedule_TabPage6.SuspendLayout()
        CType(Me.ugScheduleLog, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.ScheduleLogDS, System.ComponentModel.ISupportInitialize).BeginInit()
        Me._Frame_10.SuspendLayout()
        CType(Me.CboLogToDate, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.CboLogFromDate, System.ComponentModel.ISupportInitialize).BeginInit()
        Me._TabSchedule_TabPage7.SuspendLayout()
        Me._Frame_9.SuspendLayout()
        CType(Me.OptDates, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'UltraCalendarCombo
        '
        Me.UltraCalendarCombo.CalendarInfo = Me.UltraCalendarInfo
        Me.UltraCalendarCombo.DateButtons.Add(DateButton5)
        Me.UltraCalendarCombo.Format = "MM/dd/yyyy HH:mm, ddd"
        Me.UltraCalendarCombo.Location = New System.Drawing.Point(502, 44)
        Me.UltraCalendarCombo.Name = "UltraCalendarCombo"
        Me.UltraCalendarCombo.NonAutoSizeHeight = 21
        Me.UltraCalendarCombo.Size = New System.Drawing.Size(121, 21)
        Me.UltraCalendarCombo.TabIndex = 54
        Me.UltraCalendarCombo.Value = New Date(2011, 6, 3, 0, 0, 0, 0)
        Me.UltraCalendarCombo.Visible = False
        '
        'UltraCalendarInfo
        '
        Me.UltraCalendarInfo.DataBindingsForAppointments.BindingContextControl = Me
        Me.UltraCalendarInfo.DataBindingsForOwners.BindingContextControl = Me
        '
        'CboFromDate
        '
        Me.CboFromDate.DateButtons.Add(DateButton2)
        Me.CboFromDate.DayOfWeekCaptionStyle = Infragistics.Win.UltraWinSchedule.DayOfWeekCaptionStyle.ShortDescription
        Me.CboFromDate.Format = "MM/dd/yyyy"
        Me.CboFromDate.Location = New System.Drawing.Point(248, 22)
        Me.CboFromDate.Name = "CboFromDate"
        Me.CboFromDate.NonAutoSizeHeight = 21
        Me.CboFromDate.Size = New System.Drawing.Size(84, 21)
        Me.CboFromDate.TabIndex = 64
        Me.CboFromDate.Value = New Date(2011, 5, 19, 0, 0, 0, 0)
        '
        'MainMenu1
        '
        Me.MainMenu1.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.MnuShifts})
        Me.MainMenu1.Location = New System.Drawing.Point(0, 0)
        Me.MainMenu1.Name = "MainMenu1"
        Me.MainMenu1.Size = New System.Drawing.Size(776, 24)
        Me.MainMenu1.TabIndex = 53
        '
        'MnuShifts
        '
        Me.MnuShifts.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem() {Me.MnuCreateShift, Me.MnuEditShift, Me.MnuSplitShift, Me.MnuInsertShift})
        Me.MnuShifts.Name = "MnuShifts"
        Me.MnuShifts.Size = New System.Drawing.Size(48, 20)
        Me.MnuShifts.Text = "Shifts"
        Me.MnuShifts.Visible = False
        '
        'MnuCreateShift
        '
        Me.MnuCreateShift.Name = "MnuCreateShift"
        Me.MnuCreateShift.Size = New System.Drawing.Size(117, 22)
        Me.MnuCreateShift.Text = "Create..."
        '
        'MnuEditShift
        '
        Me.MnuEditShift.Name = "MnuEditShift"
        Me.MnuEditShift.Size = New System.Drawing.Size(117, 22)
        Me.MnuEditShift.Text = "&Edit..."
        '
        'MnuSplitShift
        '
        Me.MnuSplitShift.Name = "MnuSplitShift"
        Me.MnuSplitShift.Size = New System.Drawing.Size(117, 22)
        Me.MnuSplitShift.Text = "&Split..."
        '
        'MnuInsertShift
        '
        Me.MnuInsertShift.Name = "MnuInsertShift"
        Me.MnuInsertShift.Size = New System.Drawing.Size(117, 22)
        Me.MnuInsertShift.Text = "&Insert..."
        '
        'CmdPrintList
        '
        Me.CmdPrintList.BackColor = System.Drawing.SystemColors.Control
        Me.CmdPrintList.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdPrintList.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdPrintList.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdPrintList.Location = New System.Drawing.Point(692, 54)
        Me.CmdPrintList.Name = "CmdPrintList"
        Me.CmdPrintList.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdPrintList.Size = New System.Drawing.Size(79, 21)
        Me.CmdPrintList.TabIndex = 52
        Me.CmdPrintList.Text = "&Print"
        Me.CmdPrintList.UseVisualStyleBackColor = False
        '
        'CmdCancel
        '
        Me.CmdCancel.BackColor = System.Drawing.SystemColors.Control
        Me.CmdCancel.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdCancel.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdCancel.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdCancel.Location = New System.Drawing.Point(692, 78)
        Me.CmdCancel.Name = "CmdCancel"
        Me.CmdCancel.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdCancel.Size = New System.Drawing.Size(80, 21)
        Me.CmdCancel.TabIndex = 18
        Me.CmdCancel.Text = "&Cancel"
        Me.CmdCancel.UseVisualStyleBackColor = False
        '
        '_Frame_1
        '
        Me._Frame_1.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_1.Controls.Add(Me.UltraCalendarCombo)
        Me._Frame_1.Controls.Add(Me.CmdSelectParentOrg)
        Me._Frame_1.Controls.Add(Me.CmdScheduleDetail)
        Me._Frame_1.Controls.Add(Me.CboScheduleGroup)
        Me._Frame_1.Controls.Add(Me.CboYear)
        Me._Frame_1.Controls.Add(Me.CboOrganization)
        Me._Frame_1.Controls.Add(Me.CboMonth)
        Me._Frame_1.Controls.Add(Me.ProgressBar)
        Me._Frame_1.Controls.Add(Me._Lable_4)
        Me._Frame_1.Controls.Add(Me._Lable_3)
        Me._Frame_1.Controls.Add(Me._Lable_2)
        Me._Frame_1.Controls.Add(Me._Lable_0)
        Me._Frame_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Frame_1.Location = New System.Drawing.Point(4, 24)
        Me._Frame_1.Name = "_Frame_1"
        Me._Frame_1.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_1.Size = New System.Drawing.Size(683, 75)
        Me._Frame_1.TabIndex = 19
        Me._Frame_1.TabStop = False
        '
        'CmdSelectParentOrg
        '
        Me.CmdSelectParentOrg.BackColor = System.Drawing.SystemColors.Control
        Me.CmdSelectParentOrg.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdSelectParentOrg.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdSelectParentOrg.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdSelectParentOrg.Location = New System.Drawing.Point(302, 19)
        Me.CmdSelectParentOrg.Name = "CmdSelectParentOrg"
        Me.CmdSelectParentOrg.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdSelectParentOrg.Size = New System.Drawing.Size(17, 21)
        Me.CmdSelectParentOrg.TabIndex = 53
        Me.CmdSelectParentOrg.Text = "..."
        Me.CmdSelectParentOrg.UseVisualStyleBackColor = False
        '
        'CmdScheduleDetail
        '
        Me.CmdScheduleDetail.BackColor = System.Drawing.SystemColors.Control
        Me.CmdScheduleDetail.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdScheduleDetail.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdScheduleDetail.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdScheduleDetail.Location = New System.Drawing.Point(302, 41)
        Me.CmdScheduleDetail.Name = "CmdScheduleDetail"
        Me.CmdScheduleDetail.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdScheduleDetail.Size = New System.Drawing.Size(17, 21)
        Me.CmdScheduleDetail.TabIndex = 2
        Me.CmdScheduleDetail.Text = "..."
        Me.CmdScheduleDetail.UseVisualStyleBackColor = False
        '
        'CboScheduleGroup
        '
        Me.CboScheduleGroup.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboScheduleGroup.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboScheduleGroup.BackColor = System.Drawing.SystemColors.Window
        Me.CboScheduleGroup.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboScheduleGroup.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboScheduleGroup.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboScheduleGroup.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboScheduleGroup.Location = New System.Drawing.Point(70, 40)
        Me.CboScheduleGroup.Name = "CboScheduleGroup"
        Me.CboScheduleGroup.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboScheduleGroup.Size = New System.Drawing.Size(229, 22)
        Me.CboScheduleGroup.Sorted = True
        Me.CboScheduleGroup.TabIndex = 1
        '
        'CboYear
        '
        Me.CboYear.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboYear.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboYear.BackColor = System.Drawing.SystemColors.Window
        Me.CboYear.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboYear.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboYear.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboYear.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboYear.Items.AddRange(New Object() {"2003", "2004", "2005", "2006", "2007", "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017", "2018", "2019", "2020", "2021", "2022", "2023", "2024", "2025", "2026", "2027", "2028", "2029"})
        Me.CboYear.Location = New System.Drawing.Point(364, 40)
        Me.CboYear.Name = "CboYear"
        Me.CboYear.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboYear.Size = New System.Drawing.Size(93, 22)
        Me.CboYear.TabIndex = 4
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
        Me.CboOrganization.Location = New System.Drawing.Point(70, 18)
        Me.CboOrganization.Name = "CboOrganization"
        Me.CboOrganization.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboOrganization.Size = New System.Drawing.Size(229, 22)
        Me.CboOrganization.Sorted = True
        Me.CboOrganization.TabIndex = 0
        '
        'CboMonth
        '
        Me.CboMonth.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboMonth.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboMonth.BackColor = System.Drawing.SystemColors.Window
        Me.CboMonth.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboMonth.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboMonth.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboMonth.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboMonth.Items.AddRange(New Object() {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"})
        Me.CboMonth.Location = New System.Drawing.Point(364, 18)
        Me.CboMonth.Name = "CboMonth"
        Me.CboMonth.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboMonth.Size = New System.Drawing.Size(93, 22)
        Me.CboMonth.TabIndex = 3
        '
        'ProgressBar
        '
        Me.ProgressBar.Location = New System.Drawing.Point(478, 18)
        Me.ProgressBar.Name = "ProgressBar"
        Me.ProgressBar.Size = New System.Drawing.Size(165, 15)
        Me.ProgressBar.TabIndex = 24
        '
        '_Lable_4
        '
        Me._Lable_4.AutoSize = True
        Me._Lable_4.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_4.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_4.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Lable_4.Location = New System.Drawing.Point(19, 44)
        Me._Lable_4.Name = "_Lable_4"
        Me._Lable_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_4.Size = New System.Drawing.Size(52, 14)
        Me._Lable_4.TabIndex = 23
        Me._Lable_4.Text = "Schedule"
        '
        '_Lable_3
        '
        Me._Lable_3.AutoSize = True
        Me._Lable_3.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_3.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Lable_3.Location = New System.Drawing.Point(330, 44)
        Me._Lable_3.Name = "_Lable_3"
        Me._Lable_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_3.Size = New System.Drawing.Size(30, 14)
        Me._Lable_3.TabIndex = 22
        Me._Lable_3.Text = "Year"
        '
        '_Lable_2
        '
        Me._Lable_2.AutoSize = True
        Me._Lable_2.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Lable_2.Location = New System.Drawing.Point(328, 22)
        Me._Lable_2.Name = "_Lable_2"
        Me._Lable_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_2.Size = New System.Drawing.Size(36, 14)
        Me._Lable_2.TabIndex = 21
        Me._Lable_2.Text = "Month"
        '
        '_Lable_0
        '
        Me._Lable_0.AutoSize = True
        Me._Lable_0.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Lable_0.Location = New System.Drawing.Point(3, 22)
        Me._Lable_0.Name = "_Lable_0"
        Me._Lable_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_0.Size = New System.Drawing.Size(68, 14)
        Me._Lable_0.TabIndex = 20
        Me._Lable_0.Text = "Organization"
        '
        'CmdOK
        '
        Me.CmdOK.BackColor = System.Drawing.SystemColors.Control
        Me.CmdOK.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdOK.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdOK.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdOK.Location = New System.Drawing.Point(692, 30)
        Me.CmdOK.Name = "CmdOK"
        Me.CmdOK.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdOK.Size = New System.Drawing.Size(80, 21)
        Me.CmdOK.TabIndex = 17
        Me.CmdOK.Text = "&Save"
        Me.CmdOK.UseVisualStyleBackColor = False
        '
        'TabSchedule
        '
        Me.TabSchedule.Controls.Add(Me._TabSchedule_TabPage0)
        Me.TabSchedule.Controls.Add(Me._TabSchedule_TabPage1)
        Me.TabSchedule.Controls.Add(Me._TabSchedule_TabPage2)
        Me.TabSchedule.Controls.Add(Me._TabSchedule_TabPage3)
        Me.TabSchedule.Controls.Add(Me._TabSchedule_TabPage4)
        Me.TabSchedule.Controls.Add(Me._TabSchedule_TabPage5)
        Me.TabSchedule.Controls.Add(Me._TabSchedule_TabPage6)
        Me.TabSchedule.Controls.Add(Me._TabSchedule_TabPage7)
        Me.TabSchedule.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TabSchedule.ItemSize = New System.Drawing.Size(42, 18)
        Me.TabSchedule.Location = New System.Drawing.Point(2, 105)
        Me.TabSchedule.Name = "TabSchedule"
        Me.TabSchedule.SelectedIndex = 1
        Me.TabSchedule.Size = New System.Drawing.Size(769, 419)
        Me.TabSchedule.TabIndex = 5
        '
        '_TabSchedule_TabPage0
        '
        Me._TabSchedule_TabPage0.Controls.Add(Me.ChkActive)
        Me._TabSchedule_TabPage0.Controls.Add(Me.PicGrid)
        Me._TabSchedule_TabPage0.Controls.Add(Me.CmdRefresh)
        Me._TabSchedule_TabPage0.Location = New System.Drawing.Point(4, 22)
        Me._TabSchedule_TabPage0.Name = "_TabSchedule_TabPage0"
        Me._TabSchedule_TabPage0.Size = New System.Drawing.Size(761, 393)
        Me._TabSchedule_TabPage0.TabIndex = 0
        Me._TabSchedule_TabPage0.Text = "Call Schedule"
        '
        'ChkActive
        '
        Me.ChkActive.BackColor = System.Drawing.SystemColors.Control
        Me.ChkActive.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkActive.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkActive.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkActive.Location = New System.Drawing.Point(170, 28)
        Me.ChkActive.Name = "ChkActive"
        Me.ChkActive.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkActive.Size = New System.Drawing.Size(293, 19)
        Me.ChkActive.TabIndex = 87
        Me.ChkActive.Text = "Deactivate old schedule and use new schedule"
        Me.ChkActive.UseVisualStyleBackColor = False
        '
        'PicGrid
        '
        Me.PicGrid.BackColor = System.Drawing.SystemColors.Control
        Me.PicGrid.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.PicGrid.Cursor = System.Windows.Forms.Cursors.Default
        Me.PicGrid.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.PicGrid.ForeColor = System.Drawing.SystemColors.ControlText
        Me.PicGrid.Location = New System.Drawing.Point(4, 52)
        Me.PicGrid.Name = "PicGrid"
        Me.PicGrid.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.PicGrid.Size = New System.Drawing.Size(761, 361)
        Me.PicGrid.TabIndex = 25
        Me.PicGrid.TabStop = True
        '
        'CmdRefresh
        '
        Me.CmdRefresh.BackColor = System.Drawing.SystemColors.Control
        Me.CmdRefresh.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdRefresh.Enabled = False
        Me.CmdRefresh.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdRefresh.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdRefresh.Location = New System.Drawing.Point(4, 28)
        Me.CmdRefresh.Name = "CmdRefresh"
        Me.CmdRefresh.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdRefresh.Size = New System.Drawing.Size(131, 21)
        Me.CmdRefresh.TabIndex = 54
        Me.CmdRefresh.Text = "&Get Schedule"
        Me.CmdRefresh.UseVisualStyleBackColor = False
        '
        '_TabSchedule_TabPage1
        '
        Me._TabSchedule_TabPage1.Controls.Add(Me._Frame_0)
        Me._TabSchedule_TabPage1.Location = New System.Drawing.Point(4, 22)
        Me._TabSchedule_TabPage1.Name = "_TabSchedule_TabPage1"
        Me._TabSchedule_TabPage1.Size = New System.Drawing.Size(761, 393)
        Me._TabSchedule_TabPage1.TabIndex = 1
        Me._TabSchedule_TabPage1.Text = "On Call For"
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
        Me._Frame_0.Controls.Add(Me.LstViewAvailableOrganizations)
        Me._Frame_0.Controls.Add(Me.LstViewSelectedOrganizations)
        Me._Frame_0.Controls.Add(Me._Lable_6)
        Me._Frame_0.Controls.Add(Me._LblOpenOrg_0)
        Me._Frame_0.Controls.Add(Me._Lable_5)
        Me._Frame_0.Controls.Add(Me._Lable_7)
        Me._Frame_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Frame_0.Location = New System.Drawing.Point(8, 13)
        Me._Frame_0.Name = "_Frame_0"
        Me._Frame_0.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_0.Size = New System.Drawing.Size(751, 377)
        Me._Frame_0.TabIndex = 26
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
        Me.CmdUnassigned.TabIndex = 32
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
        Me.CmdSelect.Size = New System.Drawing.Size(54, 21)
        Me.CmdSelect.TabIndex = 10
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
        Me.CmdDeselect.TabIndex = 11
        Me.CmdDeselect.Text = "Remove"
        Me.CmdDeselect.UseVisualStyleBackColor = False
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
        Me.CboOrganizationType.Location = New System.Drawing.Point(128, 14)
        Me.CboOrganizationType.Name = "CboOrganizationType"
        Me.CboOrganizationType.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboOrganizationType.Size = New System.Drawing.Size(141, 22)
        Me.CboOrganizationType.Sorted = True
        Me.CboOrganizationType.TabIndex = 7
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
        Me.CmdFind.Size = New System.Drawing.Size(69, 21)
        Me.CmdFind.TabIndex = 8
        Me.CmdFind.Text = "&Find"
        Me.CmdFind.UseVisualStyleBackColor = False
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
        Me.CboState.Location = New System.Drawing.Point(42, 14)
        Me.CboState.Name = "CboState"
        Me.CboState.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboState.Size = New System.Drawing.Size(51, 22)
        Me.CboState.Sorted = True
        Me.CboState.TabIndex = 6
        '
        'LstViewAvailableOrganizations
        '
        Me.LstViewAvailableOrganizations.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewAvailableOrganizations.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.LstViewAvailableOrganizations.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewAvailableOrganizations.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewAvailableOrganizations.FullRowSelect = True
        Me.LstViewAvailableOrganizations.HideSelection = False
        Me.LstViewAvailableOrganizations.LabelWrap = False
        Me.LstViewAvailableOrganizations.Location = New System.Drawing.Point(10, 62)
        Me.LstViewAvailableOrganizations.Name = "LstViewAvailableOrganizations"
        Me.LstViewAvailableOrganizations.Size = New System.Drawing.Size(335, 301)
        Me.LstViewAvailableOrganizations.TabIndex = 9
        Me.LstViewAvailableOrganizations.UseCompatibleStateImageBehavior = False
        Me.LstViewAvailableOrganizations.View = System.Windows.Forms.View.Details
        '
        'LstViewSelectedOrganizations
        '
        Me.LstViewSelectedOrganizations.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewSelectedOrganizations.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.LstViewSelectedOrganizations.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewSelectedOrganizations.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewSelectedOrganizations.FullRowSelect = True
        Me.LstViewSelectedOrganizations.HideSelection = False
        Me.LstViewSelectedOrganizations.LabelWrap = False
        Me.LstViewSelectedOrganizations.Location = New System.Drawing.Point(408, 62)
        Me.LstViewSelectedOrganizations.Name = "LstViewSelectedOrganizations"
        Me.LstViewSelectedOrganizations.Size = New System.Drawing.Size(335, 301)
        Me.LstViewSelectedOrganizations.TabIndex = 12
        Me.LstViewSelectedOrganizations.UseCompatibleStateImageBehavior = False
        Me.LstViewSelectedOrganizations.View = System.Windows.Forms.View.Details
        '
        '_Lable_6
        '
        Me._Lable_6.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_6.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_6.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Lable_6.Location = New System.Drawing.Point(410, 46)
        Me._Lable_6.Name = "_Lable_6"
        Me._Lable_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_6.Size = New System.Drawing.Size(137, 17)
        Me._Lable_6.TabIndex = 30
        Me._Lable_6.Text = "Selected Organizations"
        '
        '_LblOpenOrg_0
        '
        Me._LblOpenOrg_0.BackColor = System.Drawing.SystemColors.Control
        Me._LblOpenOrg_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblOpenOrg_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LblOpenOrg_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me._LblOpenOrg_0.Location = New System.Drawing.Point(98, 18)
        Me._LblOpenOrg_0.Name = "_LblOpenOrg_0"
        Me._LblOpenOrg_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblOpenOrg_0.Size = New System.Drawing.Size(55, 17)
        Me._LblOpenOrg_0.TabIndex = 29
        Me._LblOpenOrg_0.Text = "Type"
        '
        '_Lable_5
        '
        Me._Lable_5.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_5.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_5.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Lable_5.Location = New System.Drawing.Point(12, 46)
        Me._Lable_5.Name = "_Lable_5"
        Me._Lable_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_5.Size = New System.Drawing.Size(137, 17)
        Me._Lable_5.TabIndex = 28
        Me._Lable_5.Text = "Available Organizations"
        '
        '_Lable_7
        '
        Me._Lable_7.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_7.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_7.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Lable_7.Location = New System.Drawing.Point(12, 18)
        Me._Lable_7.Name = "_Lable_7"
        Me._Lable_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_7.Size = New System.Drawing.Size(55, 19)
        Me._Lable_7.TabIndex = 27
        Me._Lable_7.Text = "State"
        '
        '_TabSchedule_TabPage2
        '
        Me._TabSchedule_TabPage2.Controls.Add(Me._Frame_2)
        Me._TabSchedule_TabPage2.Location = New System.Drawing.Point(4, 22)
        Me._TabSchedule_TabPage2.Name = "_TabSchedule_TabPage2"
        Me._TabSchedule_TabPage2.Size = New System.Drawing.Size(761, 393)
        Me._TabSchedule_TabPage2.TabIndex = 2
        Me._TabSchedule_TabPage2.Text = "Shifts"
        '
        '_Frame_2
        '
        Me._Frame_2.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_2.Controls.Add(Me.CmdEdit)
        Me._Frame_2.Controls.Add(Me.CmdRemove)
        Me._Frame_2.Controls.Add(Me.CmdAdd)
        Me._Frame_2.Controls.Add(Me.LstViewShifts)
        Me._Frame_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Frame_2.Location = New System.Drawing.Point(8, 17)
        Me._Frame_2.Name = "_Frame_2"
        Me._Frame_2.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_2.Size = New System.Drawing.Size(423, 353)
        Me._Frame_2.TabIndex = 31
        Me._Frame_2.TabStop = False
        '
        'CmdEdit
        '
        Me.CmdEdit.BackColor = System.Drawing.SystemColors.Control
        Me.CmdEdit.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdEdit.Enabled = False
        Me.CmdEdit.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdEdit.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdEdit.Location = New System.Drawing.Point(86, 18)
        Me.CmdEdit.Name = "CmdEdit"
        Me.CmdEdit.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdEdit.Size = New System.Drawing.Size(69, 21)
        Me.CmdEdit.TabIndex = 14
        Me.CmdEdit.Text = "Edit..."
        Me.CmdEdit.UseVisualStyleBackColor = False
        '
        'CmdRemove
        '
        Me.CmdRemove.BackColor = System.Drawing.SystemColors.Control
        Me.CmdRemove.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdRemove.Enabled = False
        Me.CmdRemove.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdRemove.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdRemove.Location = New System.Drawing.Point(160, 18)
        Me.CmdRemove.Name = "CmdRemove"
        Me.CmdRemove.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdRemove.Size = New System.Drawing.Size(69, 21)
        Me.CmdRemove.TabIndex = 15
        Me.CmdRemove.Text = "Remove"
        Me.CmdRemove.UseVisualStyleBackColor = False
        '
        'CmdAdd
        '
        Me.CmdAdd.BackColor = System.Drawing.SystemColors.Control
        Me.CmdAdd.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdAdd.Enabled = False
        Me.CmdAdd.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdAdd.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdAdd.Location = New System.Drawing.Point(12, 18)
        Me.CmdAdd.Name = "CmdAdd"
        Me.CmdAdd.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdAdd.Size = New System.Drawing.Size(69, 21)
        Me.CmdAdd.TabIndex = 13
        Me.CmdAdd.Text = "Add..."
        Me.CmdAdd.UseVisualStyleBackColor = False
        '
        'LstViewShifts
        '
        Me.LstViewShifts.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewShifts.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.LstViewShifts.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewShifts.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewShifts.FullRowSelect = True
        Me.LstViewShifts.HideSelection = False
        Me.LstViewShifts.LabelWrap = False
        Me.LstViewShifts.Location = New System.Drawing.Point(12, 46)
        Me.LstViewShifts.Name = "LstViewShifts"
        Me.LstViewShifts.Size = New System.Drawing.Size(400, 301)
        Me.LstViewShifts.TabIndex = 16
        Me.LstViewShifts.UseCompatibleStateImageBehavior = False
        Me.LstViewShifts.View = System.Windows.Forms.View.Details
        '
        '_TabSchedule_TabPage3
        '
        Me._TabSchedule_TabPage3.Controls.Add(Me.Frame1)
        Me._TabSchedule_TabPage3.Controls.Add(Me._Frame_3)
        Me._TabSchedule_TabPage3.Controls.Add(Me._Frame_4)
        Me._TabSchedule_TabPage3.Controls.Add(Me._Frame_5)
        Me._TabSchedule_TabPage3.Controls.Add(Me._Frame_6)
        Me._TabSchedule_TabPage3.Location = New System.Drawing.Point(4, 22)
        Me._TabSchedule_TabPage3.Name = "_TabSchedule_TabPage3"
        Me._TabSchedule_TabPage3.Size = New System.Drawing.Size(761, 393)
        Me._TabSchedule_TabPage3.TabIndex = 3
        Me._TabSchedule_TabPage3.Text = "On Call Notes"
        '
        'Frame1
        '
        Me.Frame1.BackColor = System.Drawing.SystemColors.Control
        Me.Frame1.Controls.Add(Me.Toolbar1)
        Me.Frame1.Controls.Add(Me.cmbsize)
        Me.Frame1.Controls.Add(Me.cmbfont)
        Me.Frame1.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me.Frame1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Frame1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame1.Location = New System.Drawing.Point(8, 3)
        Me.Frame1.Margin = New System.Windows.Forms.Padding(10, 3, 3, 3)
        Me.Frame1.Name = "Frame1"
        Me.Frame1.Padding = New System.Windows.Forms.Padding(0)
        Me.Frame1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame1.Size = New System.Drawing.Size(481, 45)
        Me.Frame1.TabIndex = 46
        Me.Frame1.TabStop = False
        '
        'Toolbar1
        '
        Me.Toolbar1.Anchor = System.Windows.Forms.AnchorStyles.None
        Me.Toolbar1.AutoSize = False
        Me.Toolbar1.Dock = System.Windows.Forms.DockStyle.None
        Me.Toolbar1.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.bold, Me.italic, Me._Toolbar1_Button4, Me.underline, Me.color, Me._Toolbar1_Button6, Me.left, Me.center, Me.right, Me._Toolbar1_Button10, Me.bullet})
        Me.Toolbar1.LayoutStyle = System.Windows.Forms.ToolStripLayoutStyle.Flow
        Me.Toolbar1.Location = New System.Drawing.Point(212, 11)
        Me.Toolbar1.Name = "Toolbar1"
        Me.Toolbar1.RenderMode = System.Windows.Forms.ToolStripRenderMode.System
        Me.Toolbar1.Size = New System.Drawing.Size(267, 25)
        Me.Toolbar1.TabIndex = 48
        '
        'bold
        '
        Me.bold.AutoSize = False
        Me.bold.Font = New System.Drawing.Font("Segoe UI", 9.0!, System.Drawing.FontStyle.Bold)
        Me.bold.Name = "bold"
        Me.bold.Size = New System.Drawing.Size(24, 24)
        Me.bold.Text = "B"
        Me.bold.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.bold.ToolTipText = "Bold"
        '
        'italic
        '
        Me.italic.AutoSize = False
        Me.italic.Font = New System.Drawing.Font("Segoe UI", 9.0!, System.Drawing.FontStyle.Italic)
        Me.italic.Name = "italic"
        Me.italic.Size = New System.Drawing.Size(24, 24)
        Me.italic.Text = "i"
        Me.italic.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.italic.ToolTipText = "Italic"
        '
        '_Toolbar1_Button4
        '
        Me._Toolbar1_Button4.AutoSize = False
        Me._Toolbar1_Button4.Name = "_Toolbar1_Button4"
        Me._Toolbar1_Button4.Size = New System.Drawing.Size(10, 22)
        '
        'underline
        '
        Me.underline.AutoSize = False
        Me.underline.Font = New System.Drawing.Font("Segoe UI", 9.0!, CType((System.Drawing.FontStyle.Italic Or System.Drawing.FontStyle.Underline), System.Drawing.FontStyle), System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.underline.Name = "underline"
        Me.underline.Size = New System.Drawing.Size(24, 22)
        Me.underline.Text = "U"
        Me.underline.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.underline.ToolTipText = "Underline"
        '
        'color
        '
        Me.color.AutoSize = False
        Me.color.Image = CType(resources.GetObject("color.Image"), System.Drawing.Image)
        Me.color.Name = "color"
        Me.color.Size = New System.Drawing.Size(24, 22)
        Me.color.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.color.ToolTipText = "Font Color"
        '
        '_Toolbar1_Button6
        '
        Me._Toolbar1_Button6.AutoSize = False
        Me._Toolbar1_Button6.Name = "_Toolbar1_Button6"
        Me._Toolbar1_Button6.Size = New System.Drawing.Size(10, 22)
        '
        'left
        '
        Me.left.AutoSize = False
        Me.left.Image = CType(resources.GetObject("left.Image"), System.Drawing.Image)
        Me.left.Name = "left"
        Me.left.Size = New System.Drawing.Size(24, 22)
        Me.left.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.left.ToolTipText = "Align Left"
        '
        'center
        '
        Me.center.AutoSize = False
        Me.center.Image = CType(resources.GetObject("center.Image"), System.Drawing.Image)
        Me.center.Name = "center"
        Me.center.Size = New System.Drawing.Size(24, 22)
        Me.center.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.center.ToolTipText = "Center"
        '
        'right
        '
        Me.right.AutoSize = False
        Me.right.Image = CType(resources.GetObject("right.Image"), System.Drawing.Image)
        Me.right.Name = "right"
        Me.right.Size = New System.Drawing.Size(24, 22)
        Me.right.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.right.ToolTipText = "Align Right"
        '
        '_Toolbar1_Button10
        '
        Me._Toolbar1_Button10.AutoSize = False
        Me._Toolbar1_Button10.Name = "_Toolbar1_Button10"
        Me._Toolbar1_Button10.Size = New System.Drawing.Size(10, 22)
        '
        'bullet
        '
        Me.bullet.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image
        Me.bullet.Image = CType(resources.GetObject("bullet.Image"), System.Drawing.Image)
        Me.bullet.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.bullet.Name = "bullet"
        Me.bullet.Size = New System.Drawing.Size(23, 20)
        Me.bullet.Text = "ToolStripButton1"
        Me.bullet.ToolTipText = "Bullet"
        '
        'cmbsize
        '
        Me.cmbsize.BackColor = System.Drawing.SystemColors.Window
        Me.cmbsize.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmbsize.Dock = System.Windows.Forms.DockStyle.Left
        Me.cmbsize.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cmbsize.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmbsize.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cmbsize.Location = New System.Drawing.Point(138, 13)
        Me.cmbsize.Margin = New System.Windows.Forms.Padding(3, 3, 10, 3)
        Me.cmbsize.Name = "cmbsize"
        Me.cmbsize.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmbsize.Size = New System.Drawing.Size(71, 22)
        Me.cmbsize.TabIndex = 47
        '
        'cmbfont
        '
        Me.cmbfont.BackColor = System.Drawing.SystemColors.Window
        Me.cmbfont.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmbfont.Dock = System.Windows.Forms.DockStyle.Left
        Me.cmbfont.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cmbfont.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmbfont.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cmbfont.Location = New System.Drawing.Point(0, 13)
        Me.cmbfont.Name = "cmbfont"
        Me.cmbfont.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmbfont.Size = New System.Drawing.Size(138, 22)
        Me.cmbfont.Sorted = True
        Me.cmbfont.TabIndex = 46
        '
        '_Frame_3
        '
        Me._Frame_3.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_3.Controls.Add(Me.TxtScheduleReferralNotes)
        Me._Frame_3.Controls.Add(Me._Label_2)
        Me._Frame_3.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Frame_3.Location = New System.Drawing.Point(304, 52)
        Me._Frame_3.Name = "_Frame_3"
        Me._Frame_3.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_3.Size = New System.Drawing.Size(287, 164)
        Me._Frame_3.TabIndex = 33
        Me._Frame_3.TabStop = False
        Me._Frame_3.Text = "Schedule Group Notes (Referral)"
        '
        'TxtScheduleReferralNotes
        '
        Me.TxtScheduleReferralNotes.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtScheduleReferralNotes.Location = New System.Drawing.Point(8, 64)
        Me.TxtScheduleReferralNotes.MaxLength = 255
        Me.TxtScheduleReferralNotes.Name = "TxtScheduleReferralNotes"
        Me.TxtScheduleReferralNotes.RightMargin = 247
        Me.TxtScheduleReferralNotes.Size = New System.Drawing.Size(255, 90)
        Me.TxtScheduleReferralNotes.TabIndex = 43
        Me.TxtScheduleReferralNotes.Text = ""
        '
        '_Label_2
        '
        Me._Label_2.BackColor = System.Drawing.SystemColors.Control
        Me._Label_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Label_2.Location = New System.Drawing.Point(10, 18)
        Me._Label_2.Name = "_Label_2"
        Me._Label_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_2.Size = New System.Drawing.Size(265, 43)
        Me._Label_2.TabIndex = 38
        Me._Label_2.Text = "These notes appear in the on call screen from a referral. Used to communicate not" &
            "es specific to a selected schedule group."
        '
        '_Frame_4
        '
        Me._Frame_4.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_4.Controls.Add(Me.TxtReferralNotes)
        Me._Frame_4.Controls.Add(Me._Label_1)
        Me._Frame_4.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_4.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Frame_4.Location = New System.Drawing.Point(8, 52)
        Me._Frame_4.Name = "_Frame_4"
        Me._Frame_4.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_4.Size = New System.Drawing.Size(287, 164)
        Me._Frame_4.TabIndex = 34
        Me._Frame_4.TabStop = False
        Me._Frame_4.Text = "Organization Notes (Referral)"
        '
        'TxtReferralNotes
        '
        Me.TxtReferralNotes.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtReferralNotes.Location = New System.Drawing.Point(10, 64)
        Me.TxtReferralNotes.MaxLength = 255
        Me.TxtReferralNotes.Name = "TxtReferralNotes"
        Me.TxtReferralNotes.RightMargin = 247
        Me.TxtReferralNotes.Size = New System.Drawing.Size(255, 90)
        Me.TxtReferralNotes.TabIndex = 41
        Me.TxtReferralNotes.Text = ""
        '
        '_Label_1
        '
        Me._Label_1.BackColor = System.Drawing.SystemColors.Control
        Me._Label_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Label_1.Location = New System.Drawing.Point(10, 20)
        Me._Label_1.Name = "_Label_1"
        Me._Label_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_1.Size = New System.Drawing.Size(265, 43)
        Me._Label_1.TabIndex = 36
        Me._Label_1.Text = "These notes appear in the on call screen from a referral. Used when there are mul" &
            "tiple schedule groups to determine which one to pick."
        '
        '_Frame_5
        '
        Me._Frame_5.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_5.Controls.Add(Me.TxtMessageNotes)
        Me._Frame_5.Controls.Add(Me._Label_0)
        Me._Frame_5.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_5.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Frame_5.Location = New System.Drawing.Point(8, 216)
        Me._Frame_5.Name = "_Frame_5"
        Me._Frame_5.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_5.Size = New System.Drawing.Size(287, 171)
        Me._Frame_5.TabIndex = 35
        Me._Frame_5.TabStop = False
        Me._Frame_5.Text = "Organization Notes (Message/Import)"
        '
        'TxtMessageNotes
        '
        Me.TxtMessageNotes.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtMessageNotes.Location = New System.Drawing.Point(10, 73)
        Me.TxtMessageNotes.MaxLength = 255
        Me.TxtMessageNotes.Name = "TxtMessageNotes"
        Me.TxtMessageNotes.RightMargin = 247
        Me.TxtMessageNotes.Size = New System.Drawing.Size(255, 87)
        Me.TxtMessageNotes.TabIndex = 42
        Me.TxtMessageNotes.Text = ""
        '
        '_Label_0
        '
        Me._Label_0.BackColor = System.Drawing.SystemColors.Control
        Me._Label_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Label_0.Location = New System.Drawing.Point(10, 20)
        Me._Label_0.Name = "_Label_0"
        Me._Label_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_0.Size = New System.Drawing.Size(265, 42)
        Me._Label_0.TabIndex = 37
        Me._Label_0.Text = "These notes appear in the on call screen from a message or import. Used when ther" &
            "e are multiple schedule groups to determine which one to pick."
        '
        '_Frame_6
        '
        Me._Frame_6.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_6.Controls.Add(Me.TxtScheduleMessageNotes)
        Me._Frame_6.Controls.Add(Me._Label_3)
        Me._Frame_6.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_6.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Frame_6.Location = New System.Drawing.Point(304, 216)
        Me._Frame_6.Name = "_Frame_6"
        Me._Frame_6.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_6.Size = New System.Drawing.Size(287, 170)
        Me._Frame_6.TabIndex = 39
        Me._Frame_6.TabStop = False
        Me._Frame_6.Text = "Schedule Group Notes (Message/Import)"
        '
        'TxtScheduleMessageNotes
        '
        Me.TxtScheduleMessageNotes.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtScheduleMessageNotes.Location = New System.Drawing.Point(8, 73)
        Me.TxtScheduleMessageNotes.MaxLength = 255
        Me.TxtScheduleMessageNotes.Name = "TxtScheduleMessageNotes"
        Me.TxtScheduleMessageNotes.RightMargin = 247
        Me.TxtScheduleMessageNotes.Size = New System.Drawing.Size(255, 87)
        Me.TxtScheduleMessageNotes.TabIndex = 44
        Me.TxtScheduleMessageNotes.Text = ""
        '
        '_Label_3
        '
        Me._Label_3.BackColor = System.Drawing.SystemColors.Control
        Me._Label_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_3.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Label_3.Location = New System.Drawing.Point(10, 18)
        Me._Label_3.Name = "_Label_3"
        Me._Label_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_3.Size = New System.Drawing.Size(265, 42)
        Me._Label_3.TabIndex = 40
        Me._Label_3.Text = "These notes appear in the on call screen from a message or import. Used to commun" &
            "icate notes specific to a selected schedule group."
        '
        '_TabSchedule_TabPage4
        '
        Me._TabSchedule_TabPage4.Controls.Add(Me._Frame_7)
        Me._TabSchedule_TabPage4.Location = New System.Drawing.Point(4, 22)
        Me._TabSchedule_TabPage4.Name = "_TabSchedule_TabPage4"
        Me._TabSchedule_TabPage4.Size = New System.Drawing.Size(761, 393)
        Me._TabSchedule_TabPage4.TabIndex = 4
        Me._TabSchedule_TabPage4.Text = "Source Codes"
        '
        '_Frame_7
        '
        Me._Frame_7.BackColor = System.Drawing.Color.FromArgb(CType(CType(192, Byte), Integer), CType(CType(192, Byte), Integer), CType(CType(192, Byte), Integer))
        Me._Frame_7.Controls.Add(Me.CmdAddSource)
        Me._Frame_7.Controls.Add(Me.CmdRemoveSource)
        Me._Frame_7.Controls.Add(Me.LstViewSourceCodes)
        Me._Frame_7.Controls.Add(Me._Lable_20)
        Me._Frame_7.Controls.Add(Me._Lable_19)
        Me._Frame_7.Controls.Add(Me._Lable_8)
        Me._Frame_7.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_7.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Frame_7.Location = New System.Drawing.Point(8, 26)
        Me._Frame_7.Name = "_Frame_7"
        Me._Frame_7.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_7.Size = New System.Drawing.Size(515, 229)
        Me._Frame_7.TabIndex = 45
        Me._Frame_7.TabStop = False
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
        Me.CmdAddSource.TabIndex = 47
        Me.CmdAddSource.Text = "Add..."
        Me.CmdAddSource.UseVisualStyleBackColor = False
        '
        'CmdRemoveSource
        '
        Me.CmdRemoveSource.BackColor = System.Drawing.SystemColors.Control
        Me.CmdRemoveSource.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdRemoveSource.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdRemoveSource.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdRemoveSource.Location = New System.Drawing.Point(160, 18)
        Me.CmdRemoveSource.Name = "CmdRemoveSource"
        Me.CmdRemoveSource.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdRemoveSource.Size = New System.Drawing.Size(69, 21)
        Me.CmdRemoveSource.TabIndex = 46
        Me.CmdRemoveSource.Text = "Remove"
        Me.CmdRemoveSource.UseVisualStyleBackColor = False
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
        Me.LstViewSourceCodes.Size = New System.Drawing.Size(219, 173)
        Me.LstViewSourceCodes.TabIndex = 51
        Me.LstViewSourceCodes.UseCompatibleStateImageBehavior = False
        Me.LstViewSourceCodes.View = System.Windows.Forms.View.Details
        '
        '_Lable_20
        '
        Me._Lable_20.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_20.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_20.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_20.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Lable_20.Location = New System.Drawing.Point(243, 158)
        Me._Lable_20.Name = "_Lable_20"
        Me._Lable_20.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_20.Size = New System.Drawing.Size(255, 57)
        Me._Lable_20.TabIndex = 50
        Me._Lable_20.Text = "Therefore, the combination of an ""Applies To"" organization and a source code must" &
            " be unique.  In other words, the combination can only be used once."
        '
        '_Lable_19
        '
        Me._Lable_19.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_19.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_19.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_19.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Lable_19.Location = New System.Drawing.Point(242, 40)
        Me._Lable_19.Name = "_Lable_19"
        Me._Lable_19.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_19.Size = New System.Drawing.Size(255, 115)
        Me._Lable_19.TabIndex = 49
        Me._Lable_19.Text = resources.GetString("_Lable_19.Text")
        '
        '_Lable_8
        '
        Me._Lable_8.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_8.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_8.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_8.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Lable_8.Location = New System.Drawing.Point(10, 20)
        Me._Lable_8.Name = "_Lable_8"
        Me._Lable_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_8.Size = New System.Drawing.Size(81, 17)
        Me._Lable_8.TabIndex = 48
        Me._Lable_8.Text = "Source Codes"
        '
        '_TabSchedule_TabPage5
        '
        Me._TabSchedule_TabPage5.Controls.Add(Me.ugSchedule)
        Me._TabSchedule_TabPage5.Controls.Add(Me._Frame_8)
        Me._TabSchedule_TabPage5.Location = New System.Drawing.Point(4, 22)
        Me._TabSchedule_TabPage5.Name = "_TabSchedule_TabPage5"
        Me._TabSchedule_TabPage5.Size = New System.Drawing.Size(761, 393)
        Me._TabSchedule_TabPage5.TabIndex = 5
        Me._TabSchedule_TabPage5.Text = "Schedule"
        '
        'ugSchedule
        '
        Me.ugSchedule.DataMember = "Schedule"
        Me.ugSchedule.DataSource = Me.ScheduleDS
        UltraGridColumn35.Header.VisiblePosition = 0
        UltraGridColumn35.Hidden = True
        UltraGridColumn36.Header.VisiblePosition = 1
        UltraGridColumn36.Hidden = True
        UltraGridColumn37.CellActivation = Infragistics.Win.UltraWinGrid.Activation.NoEdit
        UltraGridColumn37.Header.VisiblePosition = 2
        UltraGridColumn38.Header.VisiblePosition = 3
        UltraGridColumn38.Hidden = True
        UltraGridColumn39.Header.VisiblePosition = 4
        UltraGridColumn39.Hidden = True
        UltraGridColumn40.CellActivation = Infragistics.Win.UltraWinGrid.Activation.NoEdit
        UltraGridColumn40.EditorComponent = Me.UltraCalendarCombo
        UltraGridColumn40.Header.VisiblePosition = 5
        UltraGridColumn40.MaskInput = "{date} hh:mm, Day"
        UltraGridColumn40.Width = 120
        UltraGridColumn41.Header.VisiblePosition = 6
        UltraGridColumn41.Hidden = True
        UltraGridColumn42.Header.VisiblePosition = 7
        UltraGridColumn42.Hidden = True
        UltraGridColumn42.MaskInput = "{date} {time}"
        UltraGridColumn43.CellActivation = Infragistics.Win.UltraWinGrid.Activation.NoEdit
        UltraGridColumn43.EditorComponent = Me.UltraCalendarCombo
        UltraGridColumn43.Header.VisiblePosition = 8
        UltraGridColumn43.MaskInput = "{date} hh:mm, Day"
        UltraGridColumn43.Width = 120
        UltraGridColumn44.Header.VisiblePosition = 9
        UltraGridColumn44.MinWidth = 25
        UltraGridColumn45.Header.VisiblePosition = 10
        UltraGridColumn45.MinWidth = 25
        UltraGridColumn46.Header.VisiblePosition = 11
        UltraGridColumn46.MinWidth = 25
        UltraGridColumn47.Header.VisiblePosition = 12
        UltraGridColumn47.MinWidth = 25
        UltraGridColumn48.Header.VisiblePosition = 13
        UltraGridColumn48.MinWidth = 25
        UltraGridColumn49.Header.VisiblePosition = 14
        UltraGridColumn49.Hidden = True
        UltraGridColumn49.MinWidth = 25
        UltraGridColumn50.Header.VisiblePosition = 15
        UltraGridColumn50.Hidden = True
        UltraGridColumn50.MinWidth = 25
        UltraGridColumn51.Header.VisiblePosition = 16
        UltraGridColumn51.Hidden = True
        UltraGridColumn51.MinWidth = 25
        UltraGridColumn52.Header.VisiblePosition = 17
        UltraGridColumn52.Hidden = True
        UltraGridColumn52.MinWidth = 25
        UltraGridColumn53.Header.VisiblePosition = 18
        UltraGridColumn53.Hidden = True
        UltraGridColumn53.MinWidth = 25
        UltraGridColumn54.Header.VisiblePosition = 19
        UltraGridColumn54.Hidden = True
        UltraGridColumn54.MinWidth = 25
        UltraGridColumn55.Header.VisiblePosition = 20
        UltraGridColumn55.Hidden = True
        UltraGridColumn55.MinWidth = 25
        UltraGridColumn56.Header.VisiblePosition = 21
        UltraGridColumn56.Hidden = True
        UltraGridColumn56.MinWidth = 25
        UltraGridColumn57.Header.VisiblePosition = 22
        UltraGridColumn57.Hidden = True
        UltraGridColumn57.MinWidth = 25
        UltraGridColumn58.Header.VisiblePosition = 23
        UltraGridColumn58.Hidden = True
        UltraGridColumn58.MinWidth = 25
        UltraGridColumn59.Header.VisiblePosition = 24
        UltraGridColumn59.Hidden = True
        UltraGridColumn59.MinWidth = 25
        UltraGridColumn60.Header.VisiblePosition = 25
        UltraGridColumn60.Hidden = True
        UltraGridColumn60.MinWidth = 25
        UltraGridColumn61.Header.VisiblePosition = 26
        UltraGridColumn61.Hidden = True
        UltraGridColumn61.MinWidth = 25
        UltraGridBand1.Columns.AddRange(New Object() {UltraGridColumn35, UltraGridColumn36, UltraGridColumn37, UltraGridColumn38, UltraGridColumn39, UltraGridColumn40, UltraGridColumn41, UltraGridColumn42, UltraGridColumn43, UltraGridColumn44, UltraGridColumn45, UltraGridColumn46, UltraGridColumn47, UltraGridColumn48, UltraGridColumn49, UltraGridColumn50, UltraGridColumn51, UltraGridColumn52, UltraGridColumn53, UltraGridColumn54, UltraGridColumn55, UltraGridColumn56, UltraGridColumn57, UltraGridColumn58, UltraGridColumn59, UltraGridColumn60, UltraGridColumn61})
        Me.ugSchedule.DisplayLayout.BandsSerializer.Add(UltraGridBand1)
        Appearance4.FontData.BoldAsString = "True"
        Appearance4.FontData.Name = "Tahoma"
        Appearance4.FontData.SizeInPoints = 8.0!
        Me.ugSchedule.DisplayLayout.Override.HeaderAppearance = Appearance4
        Appearance1.BackColor = System.Drawing.Color.FromArgb(CType(CType(255, Byte), Integer), CType(CType(255, Byte), Integer), CType(CType(192, Byte), Integer))
        Me.ugSchedule.DisplayLayout.Override.RowAlternateAppearance = Appearance1
        Me.ugSchedule.Font = New System.Drawing.Font("Tahoma", 7.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ugSchedule.Location = New System.Drawing.Point(7, 89)
        Me.ugSchedule.Name = "ugSchedule"
        Me.ugSchedule.Size = New System.Drawing.Size(751, 287)
        Me.ugSchedule.TabIndex = 62
        Me.ugSchedule.UpdateMode = Infragistics.Win.UltraWinGrid.UpdateMode.OnCellChangeOrLostFocus
        '
        'ScheduleDS
        '
        Me.ScheduleDS.DataSetName = "ScheduleDS"
        Me.ScheduleDS.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema
        '
        '_Frame_8
        '
        Me._Frame_8.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_8.Controls.Add(Me.CboToDate)
        Me._Frame_8.Controls.Add(Me.CboFromDate)
        Me._Frame_8.Controls.Add(Me.CmdInsertShift)
        Me._Frame_8.Controls.Add(Me.CmdAddPerson)
        Me._Frame_8.Controls.Add(Me.CmdSplitShift)
        Me._Frame_8.Controls.Add(Me.CmdRemoveShift)
        Me._Frame_8.Controls.Add(Me.CmdEditShift)
        Me._Frame_8.Controls.Add(Me.CmdCreateShift)
        Me._Frame_8.Controls.Add(Me.CmdGetSchedule)
        Me._Frame_8.Controls.Add(Me._OptDates_1)
        Me._Frame_8.Controls.Add(Me._OptDates_0)
        Me._Frame_8.Controls.Add(Me._Label_5)
        Me._Frame_8.Controls.Add(Me._Label_4)
        Me._Frame_8.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_8.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Frame_8.Location = New System.Drawing.Point(8, 4)
        Me._Frame_8.Name = "_Frame_8"
        Me._Frame_8.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_8.Size = New System.Drawing.Size(751, 79)
        Me._Frame_8.TabIndex = 55
        Me._Frame_8.TabStop = False
        Me._Frame_8.Text = "Schedule Dates"
        '
        'CboToDate
        '
        Me.CboToDate.DateButtons.Add(DateButton1)
        Me.CboToDate.DayOfWeekCaptionStyle = Infragistics.Win.UltraWinSchedule.DayOfWeekCaptionStyle.ShortDescription
        Me.CboToDate.Format = "MM/dd/yyyy"
        Me.CboToDate.Location = New System.Drawing.Point(354, 22)
        Me.CboToDate.Name = "CboToDate"
        Me.CboToDate.NonAutoSizeHeight = 21
        Me.CboToDate.Size = New System.Drawing.Size(90, 21)
        Me.CboToDate.TabIndex = 70
        Me.CboToDate.Value = New Date(2011, 5, 19, 0, 0, 0, 0)
        '
        'CmdInsertShift
        '
        Me.CmdInsertShift.BackColor = System.Drawing.SystemColors.Control
        Me.CmdInsertShift.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdInsertShift.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdInsertShift.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdInsertShift.Location = New System.Drawing.Point(456, 48)
        Me.CmdInsertShift.Name = "CmdInsertShift"
        Me.CmdInsertShift.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdInsertShift.Size = New System.Drawing.Size(77, 21)
        Me.CmdInsertShift.TabIndex = 65
        Me.CmdInsertShift.Text = "&Insert..."
        Me.CmdInsertShift.UseVisualStyleBackColor = False
        Me.CmdInsertShift.Visible = False
        '
        'CmdAddPerson
        '
        Me.CmdAddPerson.BackColor = System.Drawing.SystemColors.Control
        Me.CmdAddPerson.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdAddPerson.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdAddPerson.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdAddPerson.Location = New System.Drawing.Point(656, 48)
        Me.CmdAddPerson.Name = "CmdAddPerson"
        Me.CmdAddPerson.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdAddPerson.Size = New System.Drawing.Size(87, 21)
        Me.CmdAddPerson.TabIndex = 67
        Me.CmdAddPerson.Text = "&Add Person..."
        Me.CmdAddPerson.UseVisualStyleBackColor = False
        '
        'CmdSplitShift
        '
        Me.CmdSplitShift.BackColor = System.Drawing.SystemColors.Control
        Me.CmdSplitShift.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdSplitShift.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdSplitShift.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdSplitShift.Location = New System.Drawing.Point(178, 48)
        Me.CmdSplitShift.Name = "CmdSplitShift"
        Me.CmdSplitShift.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdSplitShift.Size = New System.Drawing.Size(77, 21)
        Me.CmdSplitShift.TabIndex = 64
        Me.CmdSplitShift.Text = "&Split..."
        Me.CmdSplitShift.UseVisualStyleBackColor = False
        '
        'CmdRemoveShift
        '
        Me.CmdRemoveShift.BackColor = System.Drawing.SystemColors.Control
        Me.CmdRemoveShift.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdRemoveShift.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdRemoveShift.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdRemoveShift.Location = New System.Drawing.Point(264, 48)
        Me.CmdRemoveShift.Name = "CmdRemoveShift"
        Me.CmdRemoveShift.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdRemoveShift.Size = New System.Drawing.Size(77, 21)
        Me.CmdRemoveShift.TabIndex = 66
        Me.CmdRemoveShift.Text = "&Remove"
        Me.CmdRemoveShift.UseVisualStyleBackColor = False
        '
        'CmdEditShift
        '
        Me.CmdEditShift.BackColor = System.Drawing.SystemColors.Control
        Me.CmdEditShift.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdEditShift.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdEditShift.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdEditShift.Location = New System.Drawing.Point(94, 48)
        Me.CmdEditShift.Name = "CmdEditShift"
        Me.CmdEditShift.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdEditShift.Size = New System.Drawing.Size(77, 21)
        Me.CmdEditShift.TabIndex = 63
        Me.CmdEditShift.Text = "&Edit..."
        Me.CmdEditShift.UseVisualStyleBackColor = False
        '
        'CmdCreateShift
        '
        Me.CmdCreateShift.BackColor = System.Drawing.SystemColors.Control
        Me.CmdCreateShift.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdCreateShift.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdCreateShift.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdCreateShift.Location = New System.Drawing.Point(10, 48)
        Me.CmdCreateShift.Name = "CmdCreateShift"
        Me.CmdCreateShift.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdCreateShift.Size = New System.Drawing.Size(77, 21)
        Me.CmdCreateShift.TabIndex = 62
        Me.CmdCreateShift.Text = "&Create..."
        Me.CmdCreateShift.UseVisualStyleBackColor = False
        '
        'CmdGetSchedule
        '
        Me.CmdGetSchedule.BackColor = System.Drawing.SystemColors.Control
        Me.CmdGetSchedule.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdGetSchedule.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdGetSchedule.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdGetSchedule.Location = New System.Drawing.Point(450, 22)
        Me.CmdGetSchedule.Name = "CmdGetSchedule"
        Me.CmdGetSchedule.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdGetSchedule.Size = New System.Drawing.Size(133, 21)
        Me.CmdGetSchedule.TabIndex = 60
        Me.CmdGetSchedule.Text = "&Get Schedule Period"
        Me.CmdGetSchedule.UseVisualStyleBackColor = False
        '
        '_OptDates_1
        '
        Me._OptDates_1.BackColor = System.Drawing.SystemColors.Control
        Me._OptDates_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._OptDates_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._OptDates_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.OptDates.SetIndex(Me._OptDates_1, CType(1, Short))
        Me._OptDates_1.Location = New System.Drawing.Point(113, 22)
        Me._OptDates_1.Name = "_OptDates_1"
        Me._OptDates_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._OptDates_1.Size = New System.Drawing.Size(59, 19)
        Me._OptDates_1.TabIndex = 57
        Me._OptDates_1.TabStop = True
        Me._OptDates_1.Text = "Today"
        Me._OptDates_1.UseVisualStyleBackColor = False
        '
        '_OptDates_0
        '
        Me._OptDates_0.BackColor = System.Drawing.SystemColors.Control
        Me._OptDates_0.Checked = True
        Me._OptDates_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._OptDates_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._OptDates_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.OptDates.SetIndex(Me._OptDates_0, CType(0, Short))
        Me._OptDates_0.Location = New System.Drawing.Point(10, 22)
        Me._OptDates_0.Name = "_OptDates_0"
        Me._OptDates_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._OptDates_0.Size = New System.Drawing.Size(93, 19)
        Me._OptDates_0.TabIndex = 56
        Me._OptDates_0.TabStop = True
        Me._OptDates_0.Text = "Current Month"
        Me._OptDates_0.UseVisualStyleBackColor = False
        '
        '_Label_5
        '
        Me._Label_5.BackColor = System.Drawing.SystemColors.Control
        Me._Label_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_5.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_5.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Label_5.Location = New System.Drawing.Point(334, 22)
        Me._Label_5.Name = "_Label_5"
        Me._Label_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_5.Size = New System.Drawing.Size(37, 11)
        Me._Label_5.TabIndex = 69
        Me._Label_5.Text = "To"
        '
        '_Label_4
        '
        Me._Label_4.BackColor = System.Drawing.SystemColors.Control
        Me._Label_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_4.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_4.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Label_4.Location = New System.Drawing.Point(214, 22)
        Me._Label_4.Name = "_Label_4"
        Me._Label_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_4.Size = New System.Drawing.Size(37, 11)
        Me._Label_4.TabIndex = 68
        Me._Label_4.Text = "From"
        '
        '_TabSchedule_TabPage6
        '
        Me._TabSchedule_TabPage6.Controls.Add(Me.ugScheduleLog)
        Me._TabSchedule_TabPage6.Controls.Add(Me._Frame_10)
        Me._TabSchedule_TabPage6.Location = New System.Drawing.Point(4, 22)
        Me._TabSchedule_TabPage6.Name = "_TabSchedule_TabPage6"
        Me._TabSchedule_TabPage6.Size = New System.Drawing.Size(761, 393)
        Me._TabSchedule_TabPage6.TabIndex = 6
        Me._TabSchedule_TabPage6.Text = "Schedule Log"
        '
        'ugScheduleLog
        '
        Me.ugScheduleLog.DataMember = "ScheduleLog"
        Me.ugScheduleLog.DataSource = Me.ScheduleLogDS
        UltraGridColumn62.Header.VisiblePosition = 0
        UltraGridColumn62.Hidden = True
        UltraGridColumn63.Header.VisiblePosition = 1
        UltraGridColumn63.Hidden = True
        UltraGridColumn64.Header.VisiblePosition = 2
        UltraGridColumn64.Hidden = True
        UltraGridColumn65.Header.VisiblePosition = 3
        UltraGridColumn66.Header.VisiblePosition = 4
        UltraGridColumn67.Header.VisiblePosition = 5
        UltraGridColumn67.Width = 134
        UltraGridColumn68.Header.VisiblePosition = 6
        UltraGridColumn68.Width = 377
        UltraGridBand2.Columns.AddRange(New Object() {UltraGridColumn62, UltraGridColumn63, UltraGridColumn64, UltraGridColumn65, UltraGridColumn66, UltraGridColumn67, UltraGridColumn68})
        Me.ugScheduleLog.DisplayLayout.BandsSerializer.Add(UltraGridBand2)
        Me.ugScheduleLog.DisplayLayout.Override.AllowAddNew = Infragistics.Win.UltraWinGrid.AllowAddNew.No
        Me.ugScheduleLog.DisplayLayout.Override.AllowDelete = Infragistics.Win.DefaultableBoolean.[False]
        Me.ugScheduleLog.DisplayLayout.Override.AllowUpdate = Infragistics.Win.DefaultableBoolean.[False]
        Me.ugScheduleLog.DisplayLayout.Override.CellMultiLine = Infragistics.Win.DefaultableBoolean.[True]
        Appearance2.BackColor = System.Drawing.Color.FromArgb(CType(CType(255, Byte), Integer), CType(CType(255, Byte), Integer), CType(CType(192, Byte), Integer))
        Me.ugScheduleLog.DisplayLayout.Override.RowAlternateAppearance = Appearance2
        Me.ugScheduleLog.DisplayLayout.Override.RowSizing = Infragistics.Win.UltraWinGrid.RowSizing.AutoFree
        Me.ugScheduleLog.Location = New System.Drawing.Point(8, 74)
        Me.ugScheduleLog.Name = "ugScheduleLog"
        Me.ugScheduleLog.Size = New System.Drawing.Size(750, 316)
        Me.ugScheduleLog.TabIndex = 77
        '
        'ScheduleLogDS
        '
        Me.ScheduleLogDS.DataSetName = "ScheduleLog"
        Me.ScheduleLogDS.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema
        '
        '_Frame_10
        '
        Me._Frame_10.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_10.Controls.Add(Me.CboLogToDate)
        Me._Frame_10.Controls.Add(Me.CboLogFromDate)
        Me._Frame_10.Controls.Add(Me.CmdRefreshLog)
        Me._Frame_10.Controls.Add(Me._Label_7)
        Me._Frame_10.Controls.Add(Me._Label_6)
        Me._Frame_10.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_10.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Frame_10.Location = New System.Drawing.Point(8, 1)
        Me._Frame_10.Name = "_Frame_10"
        Me._Frame_10.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_10.Size = New System.Drawing.Size(751, 49)
        Me._Frame_10.TabIndex = 76
        Me._Frame_10.TabStop = False
        '
        'CboLogToDate
        '
        Me.CboLogToDate.DateButtons.Add(DateButton3)
        Me.CboLogToDate.DayOfWeekCaptionStyle = Infragistics.Win.UltraWinSchedule.DayOfWeekCaptionStyle.ShortDescription
        Me.CboLogToDate.Format = "MM/dd/yyyy"
        Me.CboLogToDate.Location = New System.Drawing.Point(150, 16)
        Me.CboLogToDate.Name = "CboLogToDate"
        Me.CboLogToDate.NonAutoSizeHeight = 21
        Me.CboLogToDate.Size = New System.Drawing.Size(84, 21)
        Me.CboLogToDate.TabIndex = 81
        Me.CboLogToDate.Value = New Date(2011, 5, 19, 0, 0, 0, 0)
        '
        'CboLogFromDate
        '
        Me.CboLogFromDate.DateButtons.Add(DateButton4)
        Me.CboLogFromDate.DayOfWeekCaptionStyle = Infragistics.Win.UltraWinSchedule.DayOfWeekCaptionStyle.ShortDescription
        Me.CboLogFromDate.Format = "MM/dd/yyyy"
        Me.CboLogFromDate.Location = New System.Drawing.Point(38, 16)
        Me.CboLogFromDate.Name = "CboLogFromDate"
        Me.CboLogFromDate.NonAutoSizeHeight = 21
        Me.CboLogFromDate.Size = New System.Drawing.Size(84, 21)
        Me.CboLogFromDate.TabIndex = 80
        Me.CboLogFromDate.Value = New Date(2011, 5, 19, 0, 0, 0, 0)
        '
        'CmdRefreshLog
        '
        Me.CmdRefreshLog.BackColor = System.Drawing.SystemColors.Control
        Me.CmdRefreshLog.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdRefreshLog.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdRefreshLog.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdRefreshLog.Location = New System.Drawing.Point(240, 16)
        Me.CmdRefreshLog.Name = "CmdRefreshLog"
        Me.CmdRefreshLog.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdRefreshLog.Size = New System.Drawing.Size(105, 21)
        Me.CmdRefreshLog.TabIndex = 77
        Me.CmdRefreshLog.Text = "&Refresh Log"
        Me.CmdRefreshLog.UseVisualStyleBackColor = False
        '
        '_Label_7
        '
        Me._Label_7.BackColor = System.Drawing.SystemColors.Control
        Me._Label_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_7.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_7.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Label_7.Location = New System.Drawing.Point(8, 16)
        Me._Label_7.Name = "_Label_7"
        Me._Label_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_7.Size = New System.Drawing.Size(37, 11)
        Me._Label_7.TabIndex = 79
        Me._Label_7.Text = "From"
        '
        '_Label_6
        '
        Me._Label_6.BackColor = System.Drawing.SystemColors.Control
        Me._Label_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_6.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_6.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Label_6.Location = New System.Drawing.Point(128, 16)
        Me._Label_6.Name = "_Label_6"
        Me._Label_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_6.Size = New System.Drawing.Size(37, 11)
        Me._Label_6.TabIndex = 78
        Me._Label_6.Text = "To"
        '
        '_TabSchedule_TabPage7
        '
        Me._TabSchedule_TabPage7.Controls.Add(Me._Frame_9)
        Me._TabSchedule_TabPage7.Location = New System.Drawing.Point(4, 22)
        Me._TabSchedule_TabPage7.Name = "_TabSchedule_TabPage7"
        Me._TabSchedule_TabPage7.Size = New System.Drawing.Size(761, 393)
        Me._TabSchedule_TabPage7.TabIndex = 7
        Me._TabSchedule_TabPage7.Text = "Schedule People"
        '
        '_Frame_9
        '
        Me._Frame_9.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_9.Controls.Add(Me.CmdSelectPerson)
        Me._Frame_9.Controls.Add(Me.CmdDeselectPerson)
        Me._Frame_9.Controls.Add(Me.LstViewAvailablePerson)
        Me._Frame_9.Controls.Add(Me.LstViewSelectedPerson)
        Me._Frame_9.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_9.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Frame_9.Location = New System.Drawing.Point(8, 26)
        Me._Frame_9.Name = "_Frame_9"
        Me._Frame_9.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_9.Size = New System.Drawing.Size(713, 313)
        Me._Frame_9.TabIndex = 70
        Me._Frame_9.TabStop = False
        '
        'CmdSelectPerson
        '
        Me.CmdSelectPerson.BackColor = System.Drawing.SystemColors.Control
        Me.CmdSelectPerson.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdSelectPerson.Enabled = False
        Me.CmdSelectPerson.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdSelectPerson.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdSelectPerson.Location = New System.Drawing.Point(330, 138)
        Me.CmdSelectPerson.Name = "CmdSelectPerson"
        Me.CmdSelectPerson.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdSelectPerson.Size = New System.Drawing.Size(54, 21)
        Me.CmdSelectPerson.TabIndex = 72
        Me.CmdSelectPerson.Text = "Add  >>"
        Me.CmdSelectPerson.UseVisualStyleBackColor = False
        '
        'CmdDeselectPerson
        '
        Me.CmdDeselectPerson.BackColor = System.Drawing.SystemColors.Control
        Me.CmdDeselectPerson.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdDeselectPerson.Enabled = False
        Me.CmdDeselectPerson.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdDeselectPerson.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdDeselectPerson.Location = New System.Drawing.Point(330, 164)
        Me.CmdDeselectPerson.Name = "CmdDeselectPerson"
        Me.CmdDeselectPerson.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdDeselectPerson.Size = New System.Drawing.Size(54, 21)
        Me.CmdDeselectPerson.TabIndex = 71
        Me.CmdDeselectPerson.Text = "Remove"
        Me.CmdDeselectPerson.UseVisualStyleBackColor = False
        '
        'LstViewAvailablePerson
        '
        Me.LstViewAvailablePerson.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewAvailablePerson.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.LstViewAvailablePerson.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewAvailablePerson.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewAvailablePerson.FullRowSelect = True
        Me.LstViewAvailablePerson.HideSelection = False
        Me.LstViewAvailablePerson.LabelWrap = False
        Me.LstViewAvailablePerson.Location = New System.Drawing.Point(8, 14)
        Me.LstViewAvailablePerson.Name = "LstViewAvailablePerson"
        Me.LstViewAvailablePerson.Size = New System.Drawing.Size(315, 291)
        Me.LstViewAvailablePerson.TabIndex = 73
        Me.LstViewAvailablePerson.UseCompatibleStateImageBehavior = False
        Me.LstViewAvailablePerson.View = System.Windows.Forms.View.Details
        '
        'LstViewSelectedPerson
        '
        Me.LstViewSelectedPerson.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewSelectedPerson.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.LstViewSelectedPerson.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewSelectedPerson.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewSelectedPerson.HideSelection = False
        Me.LstViewSelectedPerson.LabelWrap = False
        Me.LstViewSelectedPerson.Location = New System.Drawing.Point(390, 14)
        Me.LstViewSelectedPerson.Name = "LstViewSelectedPerson"
        Me.LstViewSelectedPerson.Size = New System.Drawing.Size(315, 291)
        Me.LstViewSelectedPerson.TabIndex = 74
        Me.LstViewSelectedPerson.UseCompatibleStateImageBehavior = False
        Me.LstViewSelectedPerson.View = System.Windows.Forms.View.Details
        '
        'OptDates
        '
        '
        'FrmSchedule
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 14.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.ClientSize = New System.Drawing.Size(776, 529)
        Me.Controls.Add(Me.CmdPrintList)
        Me.Controls.Add(Me.CmdCancel)
        Me.Controls.Add(Me._Frame_1)
        Me.Controls.Add(Me.CmdOK)
        Me.Controls.Add(Me.TabSchedule)
        Me.Controls.Add(Me.MainMenu1)
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.Location = New System.Drawing.Point(27, 143)
        Me.MaximizeBox = False
        Me.Name = "FrmSchedule"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.StartPosition = System.Windows.Forms.FormStartPosition.Manual
        Me.Text = "Call Schedule"
        CType(Me.UltraCalendarCombo, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.CboFromDate, System.ComponentModel.ISupportInitialize).EndInit()
        Me.MainMenu1.ResumeLayout(False)
        Me.MainMenu1.PerformLayout()
        Me._Frame_1.ResumeLayout(False)
        Me._Frame_1.PerformLayout()
        Me.TabSchedule.ResumeLayout(False)
        Me._TabSchedule_TabPage0.ResumeLayout(False)
        Me._TabSchedule_TabPage1.ResumeLayout(False)
        Me._Frame_0.ResumeLayout(False)
        Me._TabSchedule_TabPage2.ResumeLayout(False)
        Me._Frame_2.ResumeLayout(False)
        Me._TabSchedule_TabPage3.ResumeLayout(False)
        Me.Frame1.ResumeLayout(False)
        Me.Toolbar1.ResumeLayout(False)
        Me.Toolbar1.PerformLayout()
        Me._Frame_3.ResumeLayout(False)
        Me._Frame_4.ResumeLayout(False)
        Me._Frame_5.ResumeLayout(False)
        Me._Frame_6.ResumeLayout(False)
        Me._TabSchedule_TabPage4.ResumeLayout(False)
        Me._Frame_7.ResumeLayout(False)
        Me._TabSchedule_TabPage5.ResumeLayout(False)
        CType(Me.ugSchedule, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.ScheduleDS, System.ComponentModel.ISupportInitialize).EndInit()
        Me._Frame_8.ResumeLayout(False)
        Me._Frame_8.PerformLayout()
        CType(Me.CboToDate, System.ComponentModel.ISupportInitialize).EndInit()
        Me._TabSchedule_TabPage6.ResumeLayout(False)
        CType(Me.ugScheduleLog, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.ScheduleLogDS, System.ComponentModel.ISupportInitialize).EndInit()
        Me._Frame_10.ResumeLayout(False)
        Me._Frame_10.PerformLayout()
        CType(Me.CboLogToDate, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.CboLogFromDate, System.ComponentModel.ISupportInitialize).EndInit()
        Me._TabSchedule_TabPage7.ResumeLayout(False)
        Me._Frame_9.ResumeLayout(False)
        CType(Me.OptDates, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Public WithEvents ImageList1 As System.Windows.Forms.ImageList
    Public WithEvents Frame1 As System.Windows.Forms.GroupBox
    Public WithEvents Toolbar1 As System.Windows.Forms.ToolStrip
    Public WithEvents bold As System.Windows.Forms.ToolStripButton
    Public WithEvents italic As System.Windows.Forms.ToolStripButton
    Public WithEvents _Toolbar1_Button4 As System.Windows.Forms.ToolStripSeparator
    Public WithEvents underline As System.Windows.Forms.ToolStripButton
    Public WithEvents color As System.Windows.Forms.ToolStripButton
    Public WithEvents _Toolbar1_Button6 As System.Windows.Forms.ToolStripSeparator
    Public WithEvents left As System.Windows.Forms.ToolStripButton
    Public WithEvents center As System.Windows.Forms.ToolStripButton
    Public WithEvents right As System.Windows.Forms.ToolStripButton
    Public WithEvents _Toolbar1_Button10 As System.Windows.Forms.ToolStripSeparator
    Public WithEvents cmbsize As System.Windows.Forms.ComboBox
    Public WithEvents cmbfont As System.Windows.Forms.ComboBox
    Friend WithEvents ugScheduleLog As Infragistics.Win.UltraWinGrid.UltraGrid
    Friend WithEvents ScheduleLogDS As Statline.Stattrac.Data.Types.Schedule.ScheduleLogDS
    Friend WithEvents ugSchedule As Infragistics.Win.UltraWinGrid.UltraGrid
    Friend WithEvents ScheduleDS As Statline.Stattrac.Data.Types.Schedule.ScheduleDS
    Friend WithEvents CboFromDate As Infragistics.Win.UltraWinSchedule.UltraCalendarCombo
    Friend WithEvents CboToDate As Infragistics.Win.UltraWinSchedule.UltraCalendarCombo
    Friend WithEvents CboLogToDate As Infragistics.Win.UltraWinSchedule.UltraCalendarCombo
    Friend WithEvents CboLogFromDate As Infragistics.Win.UltraWinSchedule.UltraCalendarCombo
    Friend WithEvents UltraCalendarInfo As Infragistics.Win.UltraWinSchedule.UltraCalendarInfo
    Friend WithEvents UltraCalendarCombo As Infragistics.Win.UltraWinSchedule.UltraCalendarCombo
    Public WithEvents bullet As System.Windows.Forms.ToolStripButton
#End Region
End Class