<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmNew
#Region "Windows Form Designer generated code "
    <System.Diagnostics.DebuggerNonUserCode()> Public Sub New()
        MyBase.New()
        'This call is required by the Windows Form Designer.
        InitializeComponent()
        CboCallType_Initialize()
        'MdiParent = AppMain.ParentForm
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
    Public WithEvents ChkStopTimer As System.Windows.Forms.CheckBox
    Public WithEvents FrameTimer As System.Windows.Forms.GroupBox
    Public WithEvents LblAlert As System.Windows.Forms.Label
    Public WithEvents LblDefault As System.Windows.Forms.Label
    Public WithEvents _Frame_2 As System.Windows.Forms.GroupBox
    Public WithEvents CmdDirectionsNote As System.Windows.Forms.Button
    Public WithEvents TxtTotalTimeCounter As System.Windows.Forms.TextBox
    Public WithEvents CmdChangeSource As System.Windows.Forms.Button
    Public WithEvents TxtLevel As System.Windows.Forms.TextBox
    Public WithEvents TxtExtension As System.Windows.Forms.TextBox
    Public WithEvents TxtPersonType As System.Windows.Forms.TextBox
    Public WithEvents CboSubLocation As System.Windows.Forms.ComboBox
    Public WithEvents CboName As System.Windows.Forms.ComboBox
    Public WithEvents TxtPhone As System.Windows.Forms.TextBox
    Public WithEvents TxtCallerName As System.Windows.Forms.TextBox
    Public WithEvents TxtCallerOrganization As System.Windows.Forms.ComboBox
    Public WithEvents CmdLocationDetail As System.Windows.Forms.Button
    Public WithEvents CmdNameDetail As System.Windows.Forms.Button
    Public WithEvents CmdReference1 As System.Windows.Forms.Button
    Public WithEvents CmdReference2 As System.Windows.Forms.Button
    Public WithEvents _LblReferral_28 As System.Windows.Forms.Label
    Public WithEvents _LblReferral_23 As System.Windows.Forms.Label
    Public WithEvents _Lable_0 As System.Windows.Forms.Label
    Public WithEvents _Lable_2 As System.Windows.Forms.Label
    Public WithEvents _LblLocation_1 As System.Windows.Forms.Label
    Public WithEvents _Lable_5 As System.Windows.Forms.Label
    Public WithEvents _Lable_4 As System.Windows.Forms.Label
    Public WithEvents _Frame_1 As System.Windows.Forms.GroupBox
    Public WithEvents CmdNew As System.Windows.Forms.Button
    Public WithEvents CmdCancel As System.Windows.Forms.Button
    Public WithEvents TxtGreeting As System.Windows.Forms.TextBox
    Public WithEvents TxtSourceCode As System.Windows.Forms.TextBox
    Public WithEvents CboCallType As System.Windows.Forms.ComboBox
    Public WithEvents _Label_2 As System.Windows.Forms.Label
    Public WithEvents _Label_1 As System.Windows.Forms.Label
    Public WithEvents _Label_0 As System.Windows.Forms.Label
    Public WithEvents Image1 As System.Windows.Forms.PictureBox
    Public WithEvents _Frame_0 As System.Windows.Forms.GroupBox
    Public WithEvents TimerTotalTime As System.Windows.Forms.Timer
    Public WithEvents Frame As Microsoft.VisualBasic.Compatibility.VB6.GroupBoxArray
    Public WithEvents Label As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
    Public WithEvents Lable As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
    Public WithEvents LblLocation As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
    Public WithEvents LblReferral As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FrmNew))
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.FrameTimer = New System.Windows.Forms.GroupBox()
        Me.ChkStopTimer = New System.Windows.Forms.CheckBox()
        Me._Frame_2 = New System.Windows.Forms.GroupBox()
        Me.TxtDefaultAlert = New System.Windows.Forms.RichTextBox()
        Me.LblAlert = New System.Windows.Forms.Label()
        Me.LblDefault = New System.Windows.Forms.Label()
        Me._Frame_1 = New System.Windows.Forms.GroupBox()
        Me.CboOrganization = New System.Windows.Forms.ComboBox()
        Me.CmdDirectionsNote = New System.Windows.Forms.Button()
        Me.TxtTotalTimeCounter = New System.Windows.Forms.TextBox()
        Me.CmdChangeSource = New System.Windows.Forms.Button()
        Me.TxtExtension = New System.Windows.Forms.TextBox()
        Me.TxtPersonType = New System.Windows.Forms.TextBox()
        Me.CmdNameDetail = New System.Windows.Forms.Button()
        Me.TxtPhone = New System.Windows.Forms.TextBox()
        Me.CmdLocationDetail = New System.Windows.Forms.Button()
        Me.CmdReference1 = New System.Windows.Forms.Button()
        Me.TxtCallerName = New System.Windows.Forms.TextBox()
        Me.TxtCallerOrganization = New System.Windows.Forms.ComboBox()
        Me.CmdReference2 = New System.Windows.Forms.Button()
        Me._LblReferral_28 = New System.Windows.Forms.Label()
        Me._LblReferral_23 = New System.Windows.Forms.Label()
        Me._Lable_0 = New System.Windows.Forms.Label()
        Me._Lable_2 = New System.Windows.Forms.Label()
        Me._LblLocation_1 = New System.Windows.Forms.Label()
        Me._Lable_5 = New System.Windows.Forms.Label()
        Me._Lable_4 = New System.Windows.Forms.Label()
        Me.CboName = New System.Windows.Forms.ComboBox()
        Me.TxtLevel = New System.Windows.Forms.TextBox()
        Me.CboSubLocation = New System.Windows.Forms.ComboBox()
        Me.CmdNew = New System.Windows.Forms.Button()
        Me.CmdCancel = New System.Windows.Forms.Button()
        Me._Frame_0 = New System.Windows.Forms.GroupBox()
        Me.TxtGreeting = New System.Windows.Forms.TextBox()
        Me.TxtSourceCode = New System.Windows.Forms.TextBox()
        Me.CboCallType = New System.Windows.Forms.ComboBox()
        Me._Label_2 = New System.Windows.Forms.Label()
        Me._Label_1 = New System.Windows.Forms.Label()
        Me._Label_0 = New System.Windows.Forms.Label()
        Me.Image1 = New System.Windows.Forms.PictureBox()
        Me.TimerTotalTime = New System.Windows.Forms.Timer(Me.components)
        Me.Frame = New Microsoft.VisualBasic.Compatibility.VB6.GroupBoxArray(Me.components)
        Me.Label = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(Me.components)
        Me.Lable = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(Me.components)
        Me.LblLocation = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(Me.components)
        Me.LblReferral = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(Me.components)
        Me.FrameTimer.SuspendLayout()
        Me._Frame_2.SuspendLayout()
        Me._Frame_1.SuspendLayout()
        Me._Frame_0.SuspendLayout()
        CType(Me.Image1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.Frame, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.Label, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.Lable, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.LblLocation, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.LblReferral, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'FrameTimer
        '
        Me.FrameTimer.BackColor = System.Drawing.SystemColors.Control
        Me.FrameTimer.Controls.Add(Me.ChkStopTimer)
        Me.FrameTimer.Enabled = False
        Me.FrameTimer.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FrameTimer.ForeColor = System.Drawing.SystemColors.ControlText
        Me.FrameTimer.Location = New System.Drawing.Point(382, 183)
        Me.FrameTimer.Name = "FrameTimer"
        Me.FrameTimer.Padding = New System.Windows.Forms.Padding(0)
        Me.FrameTimer.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.FrameTimer.Size = New System.Drawing.Size(71, 47)
        Me.FrameTimer.TabIndex = 37
        Me.FrameTimer.TabStop = False
        '
        'ChkStopTimer
        '
        Me.ChkStopTimer.BackColor = System.Drawing.SystemColors.ActiveBorder
        Me.ChkStopTimer.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkStopTimer.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkStopTimer.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkStopTimer.Location = New System.Drawing.Point(4, 7)
        Me.ChkStopTimer.Name = "ChkStopTimer"
        Me.ChkStopTimer.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkStopTimer.Size = New System.Drawing.Size(65, 37)
        Me.ChkStopTimer.TabIndex = 38
        Me.ChkStopTimer.TabStop = False
        Me.ChkStopTimer.Text = "Stop Timer"
        Me.ChkStopTimer.UseVisualStyleBackColor = False
        '
        '_Frame_2
        '
        Me._Frame_2.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_2.Controls.Add(Me.TxtDefaultAlert)
        Me._Frame_2.Controls.Add(Me.LblAlert)
        Me._Frame_2.Controls.Add(Me.LblDefault)
        Me._Frame_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_2, CType(2, Short))
        Me._Frame_2.Location = New System.Drawing.Point(9, 126)
        Me._Frame_2.Name = "_Frame_2"
        Me._Frame_2.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_2.Size = New System.Drawing.Size(360, 125)
        Me._Frame_2.TabIndex = 28
        Me._Frame_2.TabStop = False
        '
        'TxtDefaultAlert
        '
        Me.TxtDefaultAlert.Location = New System.Drawing.Point(97, 10)
        Me.TxtDefaultAlert.MaxLength = 255
        Me.TxtDefaultAlert.Name = "TxtDefaultAlert"
        Me.TxtDefaultAlert.ScrollBars = System.Windows.Forms.RichTextBoxScrollBars.Vertical
        Me.TxtDefaultAlert.Size = New System.Drawing.Size(231, 109)
        Me.TxtDefaultAlert.TabIndex = 3
        Me.TxtDefaultAlert.TabStop = False
        Me.TxtDefaultAlert.Text = ""
        '
        'LblAlert
        '
        Me.LblAlert.AutoSize = True
        Me.LblAlert.BackColor = System.Drawing.SystemColors.Control
        Me.LblAlert.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblAlert.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblAlert.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblAlert.Location = New System.Drawing.Point(66, 28)
        Me.LblAlert.Name = "LblAlert"
        Me.LblAlert.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblAlert.Size = New System.Drawing.Size(30, 14)
        Me.LblAlert.TabIndex = 30
        Me.LblAlert.Text = "Alert"
        '
        'LblDefault
        '
        Me.LblDefault.AutoSize = True
        Me.LblDefault.BackColor = System.Drawing.SystemColors.Control
        Me.LblDefault.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblDefault.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblDefault.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblDefault.Location = New System.Drawing.Point(55, 14)
        Me.LblDefault.Name = "LblDefault"
        Me.LblDefault.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblDefault.Size = New System.Drawing.Size(41, 14)
        Me.LblDefault.TabIndex = 29
        Me.LblDefault.Text = "Default"
        '
        '_Frame_1
        '
        Me._Frame_1.AutoSize = True
        Me._Frame_1.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_1.Controls.Add(Me.CboOrganization)
        Me._Frame_1.Controls.Add(Me.CmdDirectionsNote)
        Me._Frame_1.Controls.Add(Me.TxtTotalTimeCounter)
        Me._Frame_1.Controls.Add(Me.CmdChangeSource)
        Me._Frame_1.Controls.Add(Me.TxtExtension)
        Me._Frame_1.Controls.Add(Me.TxtPersonType)
        Me._Frame_1.Controls.Add(Me.CmdNameDetail)
        Me._Frame_1.Controls.Add(Me.TxtPhone)
        Me._Frame_1.Controls.Add(Me.CmdLocationDetail)
        Me._Frame_1.Controls.Add(Me.CmdReference1)
        Me._Frame_1.Controls.Add(Me.TxtCallerName)
        Me._Frame_1.Controls.Add(Me.TxtCallerOrganization)
        Me._Frame_1.Controls.Add(Me.CmdReference2)
        Me._Frame_1.Controls.Add(Me._LblReferral_28)
        Me._Frame_1.Controls.Add(Me._LblReferral_23)
        Me._Frame_1.Controls.Add(Me._Lable_0)
        Me._Frame_1.Controls.Add(Me._Lable_2)
        Me._Frame_1.Controls.Add(Me._LblLocation_1)
        Me._Frame_1.Controls.Add(Me._Lable_5)
        Me._Frame_1.Controls.Add(Me._Lable_4)
        Me._Frame_1.Controls.Add(Me.CboName)
        Me._Frame_1.Controls.Add(Me.TxtLevel)
        Me._Frame_1.Controls.Add(Me.CboSubLocation)
        Me._Frame_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_1.ForeColor = System.Drawing.Color.Black
        Me.Frame.SetIndex(Me._Frame_1, CType(1, Short))
        Me._Frame_1.Location = New System.Drawing.Point(9, 250)
        Me._Frame_1.Name = "_Frame_1"
        Me._Frame_1.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_1.Size = New System.Drawing.Size(360, 181)
        Me._Frame_1.TabIndex = 20
        Me._Frame_1.TabStop = False
        '
        'CboOrganization
        '
        Me.CboOrganization.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboOrganization.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboOrganization.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboOrganization.Location = New System.Drawing.Point(100, 39)
        Me.CboOrganization.Name = "CboOrganization"
        Me.CboOrganization.Size = New System.Drawing.Size(227, 22)
        Me.CboOrganization.Sorted = True
        Me.CboOrganization.TabIndex = 7
        '
        'CmdDirectionsNote
        '
        Me.CmdDirectionsNote.BackColor = System.Drawing.SystemColors.Control
        Me.CmdDirectionsNote.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdDirectionsNote.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdDirectionsNote.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdDirectionsNote.Image = CType(resources.GetObject("CmdDirectionsNote.Image"), System.Drawing.Image)
        Me.CmdDirectionsNote.Location = New System.Drawing.Point(328, 66)
        Me.CmdDirectionsNote.Name = "CmdDirectionsNote"
        Me.CmdDirectionsNote.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdDirectionsNote.Size = New System.Drawing.Size(20, 21)
        Me.CmdDirectionsNote.TabIndex = 11
        Me.CmdDirectionsNote.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me.CmdDirectionsNote.UseVisualStyleBackColor = False
        '
        'TxtTotalTimeCounter
        '
        Me.TxtTotalTimeCounter.AcceptsReturn = True
        Me.TxtTotalTimeCounter.BackColor = System.Drawing.SystemColors.Control
        Me.TxtTotalTimeCounter.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtTotalTimeCounter.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtTotalTimeCounter.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtTotalTimeCounter.Location = New System.Drawing.Point(184, 144)
        Me.TxtTotalTimeCounter.MaxLength = 0
        Me.TxtTotalTimeCounter.Name = "TxtTotalTimeCounter"
        Me.TxtTotalTimeCounter.ReadOnly = True
        Me.TxtTotalTimeCounter.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtTotalTimeCounter.Size = New System.Drawing.Size(51, 20)
        Me.TxtTotalTimeCounter.TabIndex = 31
        Me.TxtTotalTimeCounter.TabStop = False
        Me.TxtTotalTimeCounter.Text = "00:00:00"
        '
        'CmdChangeSource
        '
        Me.CmdChangeSource.AutoSize = True
        Me.CmdChangeSource.BackColor = System.Drawing.SystemColors.Control
        Me.CmdChangeSource.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdChangeSource.Enabled = False
        Me.CmdChangeSource.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdChangeSource.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdChangeSource.Location = New System.Drawing.Point(3, 37)
        Me.CmdChangeSource.Margin = New System.Windows.Forms.Padding(0)
        Me.CmdChangeSource.Name = "CmdChangeSource"
        Me.CmdChangeSource.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdChangeSource.Size = New System.Drawing.Size(94, 24)
        Me.CmdChangeSource.TabIndex = 6
        Me.CmdChangeSource.Text = "Referral Facility"
        Me.CmdChangeSource.UseVisualStyleBackColor = False
        '
        'TxtExtension
        '
        Me.TxtExtension.AcceptsReturn = True
        Me.TxtExtension.BackColor = System.Drawing.SystemColors.Window
        Me.TxtExtension.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtExtension.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtExtension.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtExtension.Location = New System.Drawing.Point(277, 12)
        Me.TxtExtension.MaxLength = 0
        Me.TxtExtension.Name = "TxtExtension"
        Me.TxtExtension.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtExtension.Size = New System.Drawing.Size(49, 20)
        Me.TxtExtension.TabIndex = 5
        '
        'TxtPersonType
        '
        Me.TxtPersonType.AcceptsReturn = True
        Me.TxtPersonType.BackColor = System.Drawing.SystemColors.Window
        Me.TxtPersonType.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtPersonType.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtPersonType.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtPersonType.Location = New System.Drawing.Point(100, 120)
        Me.TxtPersonType.MaxLength = 0
        Me.TxtPersonType.Name = "TxtPersonType"
        Me.TxtPersonType.ReadOnly = True
        Me.TxtPersonType.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtPersonType.Size = New System.Drawing.Size(223, 20)
        Me.TxtPersonType.TabIndex = 14
        Me.TxtPersonType.TabStop = False
        '
        'CmdNameDetail
        '
        Me.CmdNameDetail.BackColor = System.Drawing.SystemColors.Control
        Me.CmdNameDetail.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdNameDetail.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdNameDetail.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdNameDetail.Location = New System.Drawing.Point(325, 94)
        Me.CmdNameDetail.Name = "CmdNameDetail"
        Me.CmdNameDetail.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdNameDetail.Size = New System.Drawing.Size(20, 21)
        Me.CmdNameDetail.TabIndex = 13
        Me.CmdNameDetail.Text = "..."
        Me.CmdNameDetail.UseVisualStyleBackColor = False
        '
        'TxtPhone
        '
        Me.TxtPhone.AcceptsReturn = True
        Me.TxtPhone.BackColor = System.Drawing.SystemColors.Window
        Me.TxtPhone.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtPhone.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtPhone.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtPhone.Location = New System.Drawing.Point(100, 12)
        Me.TxtPhone.MaxLength = 0
        Me.TxtPhone.Name = "TxtPhone"
        Me.TxtPhone.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtPhone.Size = New System.Drawing.Size(147, 20)
        Me.TxtPhone.TabIndex = 4
        '
        'CmdLocationDetail
        '
        Me.CmdLocationDetail.BackColor = System.Drawing.SystemColors.Control
        Me.CmdLocationDetail.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdLocationDetail.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdLocationDetail.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdLocationDetail.Location = New System.Drawing.Point(325, 39)
        Me.CmdLocationDetail.Name = "CmdLocationDetail"
        Me.CmdLocationDetail.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdLocationDetail.Size = New System.Drawing.Size(20, 21)
        Me.CmdLocationDetail.TabIndex = 8
        Me.CmdLocationDetail.Text = "..."
        Me.CmdLocationDetail.UseVisualStyleBackColor = False
        '
        'CmdReference1
        '
        Me.CmdReference1.BackColor = System.Drawing.SystemColors.Control
        Me.CmdReference1.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdReference1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdReference1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdReference1.Location = New System.Drawing.Point(328, 93)
        Me.CmdReference1.Name = "CmdReference1"
        Me.CmdReference1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdReference1.Size = New System.Drawing.Size(17, 21)
        Me.CmdReference1.TabIndex = 35
        Me.CmdReference1.Text = "..."
        Me.CmdReference1.UseVisualStyleBackColor = False
        Me.CmdReference1.Visible = False
        '
        'TxtCallerName
        '
        Me.TxtCallerName.BackColor = System.Drawing.SystemColors.Window
        Me.TxtCallerName.Cursor = System.Windows.Forms.Cursors.Default
        Me.TxtCallerName.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtCallerName.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtCallerName.Location = New System.Drawing.Point(100, 93)
        Me.TxtCallerName.Name = "TxtCallerName"
        Me.TxtCallerName.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtCallerName.Size = New System.Drawing.Size(159, 20)
        Me.TxtCallerName.TabIndex = 33
        Me.TxtCallerName.TabStop = False
        Me.TxtCallerName.Visible = False
        '
        'TxtCallerOrganization
        '
        Me.TxtCallerOrganization.BackColor = System.Drawing.SystemColors.Window
        Me.TxtCallerOrganization.Cursor = System.Windows.Forms.Cursors.Default
        Me.TxtCallerOrganization.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtCallerOrganization.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtCallerOrganization.Location = New System.Drawing.Point(100, 39)
        Me.TxtCallerOrganization.Name = "TxtCallerOrganization"
        Me.TxtCallerOrganization.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtCallerOrganization.Size = New System.Drawing.Size(227, 22)
        Me.TxtCallerOrganization.TabIndex = 34
        Me.TxtCallerOrganization.TabStop = False
        Me.TxtCallerOrganization.Visible = False
        '
        'CmdReference2
        '
        Me.CmdReference2.BackColor = System.Drawing.SystemColors.Control
        Me.CmdReference2.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdReference2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdReference2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdReference2.Location = New System.Drawing.Point(325, 39)
        Me.CmdReference2.Name = "CmdReference2"
        Me.CmdReference2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdReference2.Size = New System.Drawing.Size(17, 21)
        Me.CmdReference2.TabIndex = 36
        Me.CmdReference2.Text = "..."
        Me.CmdReference2.UseVisualStyleBackColor = False
        Me.CmdReference2.Visible = False
        '
        '_LblReferral_28
        '
        Me._LblReferral_28.AutoSize = True
        Me._LblReferral_28.BackColor = System.Drawing.SystemColors.Control
        Me._LblReferral_28.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblReferral_28.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LblReferral_28.ForeColor = System.Drawing.Color.Black
        Me.LblReferral.SetIndex(Me._LblReferral_28, CType(28, Short))
        Me._LblReferral_28.Location = New System.Drawing.Point(106, 147)
        Me._LblReferral_28.Name = "_LblReferral_28"
        Me._LblReferral_28.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblReferral_28.Size = New System.Drawing.Size(77, 14)
        Me._LblReferral_28.TabIndex = 32
        Me._LblReferral_28.Text = "Total Call Time:"
        '
        '_LblReferral_23
        '
        Me._LblReferral_23.AutoSize = True
        Me._LblReferral_23.BackColor = System.Drawing.SystemColors.Control
        Me._LblReferral_23.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblReferral_23.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LblReferral_23.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblReferral.SetIndex(Me._LblReferral_23, CType(23, Short))
        Me._LblReferral_23.Location = New System.Drawing.Point(250, 18)
        Me._LblReferral_23.Name = "_LblReferral_23"
        Me._LblReferral_23.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblReferral_23.Size = New System.Drawing.Size(25, 14)
        Me._LblReferral_23.TabIndex = 26
        Me._LblReferral_23.Text = "Ext."
        '
        '_Lable_0
        '
        Me._Lable_0.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_0, CType(0, Short))
        Me._Lable_0.Location = New System.Drawing.Point(61, 15)
        Me._Lable_0.Name = "_Lable_0"
        Me._Lable_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_0.Size = New System.Drawing.Size(37, 14)
        Me._Lable_0.TabIndex = 25
        Me._Lable_0.Text = "Phone"
        '
        '_Lable_2
        '
        Me._Lable_2.AutoSize = True
        Me._Lable_2.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_2, CType(2, Short))
        Me._Lable_2.Location = New System.Drawing.Point(33, 70)
        Me._Lable_2.Name = "_Lable_2"
        Me._Lable_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_2.Size = New System.Drawing.Size(66, 14)
        Me._Lable_2.TabIndex = 24
        Me._Lable_2.Text = "Hospital Unit"
        '
        '_LblLocation_1
        '
        Me._LblLocation_1.BackColor = System.Drawing.SystemColors.Control
        Me._LblLocation_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblLocation_1.Enabled = False
        Me._LblLocation_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LblLocation_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblLocation.SetIndex(Me._LblLocation_1, CType(1, Short))
        Me._LblLocation_1.Location = New System.Drawing.Point(25, 42)
        Me._LblLocation_1.Name = "_LblLocation_1"
        Me._LblLocation_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblLocation_1.Size = New System.Drawing.Size(45, 15)
        Me._LblLocation_1.TabIndex = 23
        Me._LblLocation_1.Text = "Location"
        '
        '_Lable_5
        '
        Me._Lable_5.AutoSize = True
        Me._Lable_5.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_5.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_5.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_5, CType(5, Short))
        Me._Lable_5.Location = New System.Drawing.Point(76, 122)
        Me._Lable_5.Name = "_Lable_5"
        Me._Lable_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_5.Size = New System.Drawing.Size(26, 14)
        Me._Lable_5.TabIndex = 22
        Me._Lable_5.Text = "Title"
        '
        '_Lable_4
        '
        Me._Lable_4.AutoSize = True
        Me._Lable_4.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_4.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_4.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_4, CType(4, Short))
        Me._Lable_4.Location = New System.Drawing.Point(16, 96)
        Me._Lable_4.Name = "_Lable_4"
        Me._Lable_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_4.Size = New System.Drawing.Size(83, 14)
        Me._Lable_4.TabIndex = 21
        Me._Lable_4.Text = "Referral Person"
        '
        'CboName
        '
        Me.CboName.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboName.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboName.BackColor = System.Drawing.SystemColors.Window
        Me.CboName.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboName.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboName.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboName.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboName.Location = New System.Drawing.Point(100, 93)
        Me.CboName.Name = "CboName"
        Me.CboName.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboName.Size = New System.Drawing.Size(226, 22)
        Me.CboName.Sorted = True
        Me.CboName.TabIndex = 12
        '
        'TxtLevel
        '
        Me.TxtLevel.BackColor = System.Drawing.SystemColors.Window
        Me.TxtLevel.Cursor = System.Windows.Forms.Cursors.Default
        Me.TxtLevel.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtLevel.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtLevel.Location = New System.Drawing.Point(270, 66)
        Me.TxtLevel.MaxLength = 4
        Me.TxtLevel.Name = "TxtLevel"
        Me.TxtLevel.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtLevel.Size = New System.Drawing.Size(57, 20)
        Me.TxtLevel.TabIndex = 10
        '
        'CboSubLocation
        '
        Me.CboSubLocation.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboSubLocation.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboSubLocation.BackColor = System.Drawing.SystemColors.Window
        Me.CboSubLocation.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboSubLocation.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboSubLocation.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboSubLocation.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboSubLocation.Location = New System.Drawing.Point(100, 66)
        Me.CboSubLocation.Name = "CboSubLocation"
        Me.CboSubLocation.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboSubLocation.Size = New System.Drawing.Size(167, 22)
        Me.CboSubLocation.Sorted = True
        Me.CboSubLocation.TabIndex = 9
        '
        'CmdNew
        '
        Me.CmdNew.BackColor = System.Drawing.SystemColors.Control
        Me.CmdNew.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdNew.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdNew.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdNew.Location = New System.Drawing.Point(378, 8)
        Me.CmdNew.Name = "CmdNew"
        Me.CmdNew.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdNew.Size = New System.Drawing.Size(75, 23)
        Me.CmdNew.TabIndex = 15
        Me.CmdNew.Text = "&New"
        Me.CmdNew.UseVisualStyleBackColor = False
        '
        'CmdCancel
        '
        Me.CmdCancel.BackColor = System.Drawing.SystemColors.Control
        Me.CmdCancel.CausesValidation = False
        Me.CmdCancel.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdCancel.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdCancel.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdCancel.Location = New System.Drawing.Point(375, 390)
        Me.CmdCancel.Name = "CmdCancel"
        Me.CmdCancel.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdCancel.Size = New System.Drawing.Size(78, 23)
        Me.CmdCancel.TabIndex = 16
        Me.CmdCancel.Text = "&Cancel"
        Me.CmdCancel.UseVisualStyleBackColor = False
        '
        '_Frame_0
        '
        Me._Frame_0.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_0.Controls.Add(Me.TxtGreeting)
        Me._Frame_0.Controls.Add(Me.TxtSourceCode)
        Me._Frame_0.Controls.Add(Me.CboCallType)
        Me._Frame_0.Controls.Add(Me._Label_2)
        Me._Frame_0.Controls.Add(Me._Label_1)
        Me._Frame_0.Controls.Add(Me._Label_0)
        Me._Frame_0.Controls.Add(Me.Image1)
        Me._Frame_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_0, CType(0, Short))
        Me._Frame_0.Location = New System.Drawing.Point(9, 2)
        Me._Frame_0.Name = "_Frame_0"
        Me._Frame_0.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_0.Size = New System.Drawing.Size(360, 125)
        Me._Frame_0.TabIndex = 17
        Me._Frame_0.TabStop = False
        '
        'TxtGreeting
        '
        Me.TxtGreeting.AcceptsReturn = True
        Me.TxtGreeting.BackColor = System.Drawing.SystemColors.Window
        Me.TxtGreeting.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtGreeting.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtGreeting.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtGreeting.Location = New System.Drawing.Point(97, 40)
        Me.TxtGreeting.MaxLength = 0
        Me.TxtGreeting.Multiline = True
        Me.TxtGreeting.Name = "TxtGreeting"
        Me.TxtGreeting.ReadOnly = True
        Me.TxtGreeting.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtGreeting.Size = New System.Drawing.Size(231, 79)
        Me.TxtGreeting.TabIndex = 2
        Me.TxtGreeting.TabStop = False
        '
        'TxtSourceCode
        '
        Me.TxtSourceCode.AcceptsReturn = True
        Me.TxtSourceCode.BackColor = System.Drawing.SystemColors.Window
        Me.TxtSourceCode.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtSourceCode.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtSourceCode.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtSourceCode.Location = New System.Drawing.Point(97, 16)
        Me.TxtSourceCode.MaxLength = 0
        Me.TxtSourceCode.Name = "TxtSourceCode"
        Me.TxtSourceCode.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtSourceCode.Size = New System.Drawing.Size(67, 20)
        Me.TxtSourceCode.TabIndex = 0
        '
        'CboCallType
        '
        Me.CboCallType.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboCallType.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboCallType.BackColor = System.Drawing.SystemColors.Window
        Me.CboCallType.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboCallType.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboCallType.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboCallType.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboCallType.Location = New System.Drawing.Point(213, 16)
        Me.CboCallType.Name = "CboCallType"
        Me.CboCallType.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboCallType.Size = New System.Drawing.Size(109, 22)
        Me.CboCallType.Sorted = True
        Me.CboCallType.TabIndex = 1
        '
        '_Label_2
        '
        Me._Label_2.AutoSize = True
        Me._Label_2.BackColor = System.Drawing.SystemColors.Control
        Me._Label_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_2, CType(2, Short))
        Me._Label_2.Location = New System.Drawing.Point(48, 46)
        Me._Label_2.Name = "_Label_2"
        Me._Label_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_2.Size = New System.Drawing.Size(48, 14)
        Me._Label_2.TabIndex = 27
        Me._Label_2.Text = "Greeting"
        '
        '_Label_1
        '
        Me._Label_1.AutoSize = True
        Me._Label_1.BackColor = System.Drawing.SystemColors.Control
        Me._Label_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_1, CType(1, Short))
        Me._Label_1.Location = New System.Drawing.Point(164, 18)
        Me._Label_1.Name = "_Label_1"
        Me._Label_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_1.Size = New System.Drawing.Size(50, 14)
        Me._Label_1.TabIndex = 19
        Me._Label_1.Text = "Call Type"
        '
        '_Label_0
        '
        Me._Label_0.AutoSize = True
        Me._Label_0.BackColor = System.Drawing.SystemColors.Control
        Me._Label_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Label_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.SetIndex(Me._Label_0, CType(0, Short))
        Me._Label_0.Location = New System.Drawing.Point(26, 18)
        Me._Label_0.Name = "_Label_0"
        Me._Label_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label_0.Size = New System.Drawing.Size(70, 14)
        Me._Label_0.TabIndex = 18
        Me._Label_0.Text = "Source Code"
        '
        'Image1
        '
        Me.Image1.Cursor = System.Windows.Forms.Cursors.Default
        Me.Image1.Image = CType(resources.GetObject("Image1.Image"), System.Drawing.Image)
        Me.Image1.Location = New System.Drawing.Point(55, 70)
        Me.Image1.Name = "Image1"
        Me.Image1.Size = New System.Drawing.Size(32, 32)
        Me.Image1.TabIndex = 28
        Me.Image1.TabStop = False
        '
        'TimerTotalTime
        '
        Me.TimerTotalTime.Enabled = True
        Me.TimerTotalTime.Interval = 1000
        '
        'FrmNew
        '
        Me.AcceptButton = Me.CmdNew
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 14.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.ClientSize = New System.Drawing.Size(462, 431)
        Me.Controls.Add(Me.FrameTimer)
        Me.Controls.Add(Me._Frame_2)
        Me.Controls.Add(Me._Frame_1)
        Me.Controls.Add(Me.CmdNew)
        Me.Controls.Add(Me.CmdCancel)
        Me.Controls.Add(Me._Frame_0)
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.KeyPreview = True
        Me.Location = New System.Drawing.Point(279, 73)
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "FrmNew"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "New Call"
        Me.FrameTimer.ResumeLayout(False)
        Me._Frame_2.ResumeLayout(False)
        Me._Frame_2.PerformLayout()
        Me._Frame_1.ResumeLayout(False)
        Me._Frame_1.PerformLayout()
        Me._Frame_0.ResumeLayout(False)
        Me._Frame_0.PerformLayout()
        CType(Me.Image1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.Frame, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.Label, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.Lable, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.LblLocation, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.LblReferral, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Public WithEvents CboOrganization As System.Windows.Forms.ComboBox
    Friend WithEvents TxtDefaultAlert As RichTextBox
#End Region
End Class