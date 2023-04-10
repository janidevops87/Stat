<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmMessage
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
        'bret 1/4/2010 dll conversion Me.MdiParent = AppMain.ParentForm
        'bret 1/4/2010 dll conversion MdiParent.Show() 'StatTrac.MDIFormStatLine.Show
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
	Public WithEvents ChkExclusive As System.Windows.Forms.CheckBox
	Public WithEvents ChkTemp As System.Windows.Forms.CheckBox
	Public WithEvents CmdCancel As System.Windows.Forms.Button
	Public WithEvents CmdModify As System.Windows.Forms.Button
	Public WithEvents _Lable_8 As System.Windows.Forms.Label
	Public WithEvents _Lable_2 As System.Windows.Forms.Label
	Public WithEvents _LblReferral_23 As System.Windows.Forms.Label
	Public WithEvents _Lable_4 As System.Windows.Forms.Label
	Public WithEvents LblPhone As System.Windows.Forms.Label
	Public WithEvents LblExtension As System.Windows.Forms.Label
	Public WithEvents LblName As System.Windows.Forms.Label
	Public WithEvents LblOrganization As System.Windows.Forms.Label
	Public WithEvents _Frame_0 As System.Windows.Forms.GroupBox
	Public WithEvents CmdOK As System.Windows.Forms.Button
	Public WithEvents _TxtAlerts_0 As System.Windows.Forms.RichTextBox
	Public WithEvents _TxtAlerts_1 As System.Windows.Forms.RichTextBox
	Public WithEvents _Lable_0 As System.Windows.Forms.Label
	Public WithEvents _Frame_4 As System.Windows.Forms.GroupBox
	Public WithEvents CmdFind As System.Windows.Forms.Button
	Public WithEvents CmdOnCallMain As System.Windows.Forms.Button
	Public WithEvents ChkUrgent As System.Windows.Forms.CheckBox
	Public WithEvents CboOrganization As System.Windows.Forms.ComboBox
	Public WithEvents TxtPersonType As System.Windows.Forms.TextBox
	Public WithEvents CboName As System.Windows.Forms.ComboBox
	Public WithEvents CboMessageType As System.Windows.Forms.ComboBox
	Public WithEvents TxtMessage As System.Windows.Forms.RichTextBox
	Public WithEvents TxtImportPatient As System.Windows.Forms.TextBox
	Public WithEvents TxtUNOSID As System.Windows.Forms.TextBox
	Public WithEvents TxtImportCenter As System.Windows.Forms.TextBox
	Public WithEvents LblUNOSID As System.Windows.Forms.Label
	Public WithEvents LblImportPatient As System.Windows.Forms.Label
	Public WithEvents LblMessage As System.Windows.Forms.Label
	Public WithEvents _Lable_6 As System.Windows.Forms.Label
	Public WithEvents _Lable_5 As System.Windows.Forms.Label
	Public WithEvents _Lable_3 As System.Windows.Forms.Label
	Public WithEvents LblImportCenter As System.Windows.Forms.Label
	Public WithEvents _Frame_1 As System.Windows.Forms.GroupBox
	Public WithEvents _Picture_0 As System.Windows.Forms.PictureBox
	Public WithEvents CmdChangeSource As System.Windows.Forms.Button
	Public WithEvents _TabMessage_TabPage0 As System.Windows.Forms.TabPage
	Public WithEvents TxtCallDate As System.Windows.Forms.TextBox
	Public WithEvents TxtTotalTimeCounter As System.Windows.Forms.TextBox
	Public WithEvents CboCallByEmployee As System.Windows.Forms.ComboBox
	Public WithEvents LblBy As System.Windows.Forms.Label
	Public WithEvents LblInitialCallDate As System.Windows.Forms.Label
	Public WithEvents LblTotalTime As System.Windows.Forms.Label
	Public WithEvents _Frame_2 As System.Windows.Forms.GroupBox
	Public WithEvents chkViewLogEventDeleted As System.Windows.Forms.CheckBox
	Public WithEvents CmdColorKey As System.Windows.Forms.Button
	Public WithEvents CmdNewEvent As System.Windows.Forms.Button
	Public WithEvents CmdDelete As System.Windows.Forms.Button
	Public WithEvents CmdOnCall As System.Windows.Forms.Button
	Public WithEvents _Picture_1 As System.Windows.Forms.PictureBox
	Public WithEvents LstViewLogEvent As System.Windows.Forms.ListView
	Public WithEvents LstViewPending As System.Windows.Forms.ListView
	Public WithEvents _Lable_19 As System.Windows.Forms.Label
	Public WithEvents _Frame_3 As System.Windows.Forms.GroupBox
	Public WithEvents _Picture_2 As System.Windows.Forms.PictureBox
	Public WithEvents _TabMessage_TabPage1 As System.Windows.Forms.TabPage
	Public WithEvents TabMessage As System.Windows.Forms.TabControl
	Public WithEvents VP_Timer As System.Windows.Forms.Timer
	Public WithEvents TimerTotalTime As System.Windows.Forms.Timer
	Public WithEvents Frame As Microsoft.VisualBasic.Compatibility.VB6.GroupBoxArray
	Public WithEvents Lable As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
	Public WithEvents LblReferral As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
	Public WithEvents Picture As Microsoft.VisualBasic.Compatibility.VB6.PictureBoxArray
	Public WithEvents TxtAlerts As Microsoft.VisualBasic.Compatibility.VB6.RichTextBoxArray
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FrmMessage))
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.ChkExclusive = New System.Windows.Forms.CheckBox()
        Me.ChkTemp = New System.Windows.Forms.CheckBox()
        Me.CmdCancel = New System.Windows.Forms.Button()
        Me._Frame_0 = New System.Windows.Forms.GroupBox()
        Me.CmdModify = New System.Windows.Forms.Button()
        Me._Lable_8 = New System.Windows.Forms.Label()
        Me._Lable_2 = New System.Windows.Forms.Label()
        Me._LblReferral_23 = New System.Windows.Forms.Label()
        Me._Lable_4 = New System.Windows.Forms.Label()
        Me.LblPhone = New System.Windows.Forms.Label()
        Me.LblExtension = New System.Windows.Forms.Label()
        Me.LblName = New System.Windows.Forms.Label()
        Me.LblOrganization = New System.Windows.Forms.Label()
        Me.CmdOK = New System.Windows.Forms.Button()
        Me.TabMessage = New System.Windows.Forms.TabControl()
        Me._TabMessage_TabPage0 = New System.Windows.Forms.TabPage()
        Me._Frame_4 = New System.Windows.Forms.GroupBox()
        Me._TxtAlerts_0 = New System.Windows.Forms.RichTextBox()
        Me._TxtAlerts_1 = New System.Windows.Forms.RichTextBox()
        Me._Lable_0 = New System.Windows.Forms.Label()
        Me._Frame_1 = New System.Windows.Forms.GroupBox()
        Me.CmdChangeSource = New System.Windows.Forms.Button()
        Me.CmdFind = New System.Windows.Forms.Button()
        Me.CmdOnCallMain = New System.Windows.Forms.Button()
        Me.ChkUrgent = New System.Windows.Forms.CheckBox()
        Me.CboOrganization = New System.Windows.Forms.ComboBox()
        Me.TxtPersonType = New System.Windows.Forms.TextBox()
        Me.CboName = New System.Windows.Forms.ComboBox()
        Me.CboMessageType = New System.Windows.Forms.ComboBox()
        Me.TxtMessage = New System.Windows.Forms.RichTextBox()
        Me.TxtImportPatient = New System.Windows.Forms.TextBox()
        Me.TxtUNOSID = New System.Windows.Forms.TextBox()
        Me.TxtImportCenter = New System.Windows.Forms.TextBox()
        Me.LblUNOSID = New System.Windows.Forms.Label()
        Me.LblImportPatient = New System.Windows.Forms.Label()
        Me.LblMessage = New System.Windows.Forms.Label()
        Me._Lable_6 = New System.Windows.Forms.Label()
        Me._Lable_5 = New System.Windows.Forms.Label()
        Me._Lable_3 = New System.Windows.Forms.Label()
        Me.LblImportCenter = New System.Windows.Forms.Label()
        Me._Picture_0 = New System.Windows.Forms.PictureBox()
        Me._TabMessage_TabPage1 = New System.Windows.Forms.TabPage()
        Me._Frame_2 = New System.Windows.Forms.GroupBox()
        Me.TxtCallDate = New System.Windows.Forms.TextBox()
        Me.TxtTotalTimeCounter = New System.Windows.Forms.TextBox()
        Me.CboCallByEmployee = New System.Windows.Forms.ComboBox()
        Me.LblBy = New System.Windows.Forms.Label()
        Me.LblInitialCallDate = New System.Windows.Forms.Label()
        Me.LblTotalTime = New System.Windows.Forms.Label()
        Me._Frame_3 = New System.Windows.Forms.GroupBox()
        Me.CmdNewEvent = New System.Windows.Forms.Button()
        Me.chkViewLogEventDeleted = New System.Windows.Forms.CheckBox()
        Me.CmdColorKey = New System.Windows.Forms.Button()
        Me.CmdDelete = New System.Windows.Forms.Button()
        Me.CmdOnCall = New System.Windows.Forms.Button()
        Me._Picture_1 = New System.Windows.Forms.PictureBox()
        Me.LstViewLogEvent = New System.Windows.Forms.ListView()
        Me.LstViewPending = New System.Windows.Forms.ListView()
        Me._Lable_19 = New System.Windows.Forms.Label()
        Me._Picture_2 = New System.Windows.Forms.PictureBox()
        Me.VP_Timer = New System.Windows.Forms.Timer(Me.components)
        Me.TimerTotalTime = New System.Windows.Forms.Timer(Me.components)
        Me.Frame = New Microsoft.VisualBasic.Compatibility.VB6.GroupBoxArray(Me.components)
        Me.Lable = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(Me.components)
        Me.LblReferral = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(Me.components)
        Me.Picture = New Microsoft.VisualBasic.Compatibility.VB6.PictureBoxArray(Me.components)
        Me.TxtAlerts = New Microsoft.VisualBasic.Compatibility.VB6.RichTextBoxArray(Me.components)
        Me.Label4 = New System.Windows.Forms.Label()
        Me.rtbScheduleAlert = New Statline.Stattrac.Windows.Forms.RichTextBox()
        Me._Frame_0.SuspendLayout
        Me.TabMessage.SuspendLayout
        Me._TabMessage_TabPage0.SuspendLayout
        Me._Frame_4.SuspendLayout
        Me._Frame_1.SuspendLayout
        CType(Me._Picture_0,System.ComponentModel.ISupportInitialize).BeginInit
        Me._TabMessage_TabPage1.SuspendLayout
        Me._Frame_2.SuspendLayout
        Me._Frame_3.SuspendLayout
        CType(Me._Picture_1,System.ComponentModel.ISupportInitialize).BeginInit
        CType(Me._Picture_2,System.ComponentModel.ISupportInitialize).BeginInit
        CType(Me.Frame,System.ComponentModel.ISupportInitialize).BeginInit
        CType(Me.Lable,System.ComponentModel.ISupportInitialize).BeginInit
        CType(Me.LblReferral,System.ComponentModel.ISupportInitialize).BeginInit
        CType(Me.Picture,System.ComponentModel.ISupportInitialize).BeginInit
        CType(Me.TxtAlerts,System.ComponentModel.ISupportInitialize).BeginInit
        Me.SuspendLayout
        '
        'ChkExclusive
        '
        Me.ChkExclusive.BackColor = System.Drawing.SystemColors.Control
        Me.ChkExclusive.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkExclusive.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.ChkExclusive.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkExclusive.Location = New System.Drawing.Point(1196, 80)
        Me.ChkExclusive.Name = "ChkExclusive"
        Me.ChkExclusive.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkExclusive.Size = New System.Drawing.Size(77, 15)
        Me.ChkExclusive.TabIndex = 21
        Me.ChkExclusive.TabStop = false
        Me.ChkExclusive.Text = "Exclusive"
        Me.ChkExclusive.UseVisualStyleBackColor = false
        Me.ChkExclusive.Visible = false
        '
        'ChkTemp
        '
        Me.ChkTemp.BackColor = System.Drawing.SystemColors.Control
        Me.ChkTemp.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkTemp.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.ChkTemp.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkTemp.Location = New System.Drawing.Point(1196, 58)
        Me.ChkTemp.Name = "ChkTemp"
        Me.ChkTemp.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkTemp.Size = New System.Drawing.Size(77, 17)
        Me.ChkTemp.TabIndex = 20
        Me.ChkTemp.TabStop = false
        Me.ChkTemp.Text = "Incomplete"
        Me.ChkTemp.UseVisualStyleBackColor = false
        '
        'CmdCancel
        '
        Me.CmdCancel.BackColor = System.Drawing.SystemColors.Control
        Me.CmdCancel.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdCancel.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.CmdCancel.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdCancel.Location = New System.Drawing.Point(1193, 554)
        Me.CmdCancel.Name = "CmdCancel"
        Me.CmdCancel.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdCancel.Size = New System.Drawing.Size(80, 21)
        Me.CmdCancel.TabIndex = 101
        Me.CmdCancel.Text = "Cancel"
        Me.CmdCancel.UseVisualStyleBackColor = false
        '
        '_Frame_0
        '
        Me._Frame_0.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_0.Controls.Add(Me.CmdModify)
        Me._Frame_0.Controls.Add(Me._Lable_8)
        Me._Frame_0.Controls.Add(Me._Lable_2)
        Me._Frame_0.Controls.Add(Me._LblReferral_23)
        Me._Frame_0.Controls.Add(Me._Lable_4)
        Me._Frame_0.Controls.Add(Me.LblPhone)
        Me._Frame_0.Controls.Add(Me.LblExtension)
        Me._Frame_0.Controls.Add(Me.LblName)
        Me._Frame_0.Controls.Add(Me.LblOrganization)
        Me._Frame_0.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me._Frame_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_0, CType(0,Short))
        Me._Frame_0.Location = New System.Drawing.Point(6, 1)
        Me._Frame_0.Name = "_Frame_0"
        Me._Frame_0.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_0.Size = New System.Drawing.Size(953, 52)
        Me._Frame_0.TabIndex = 200
        Me._Frame_0.TabStop = false
        '
        'CmdModify
        '
        Me.CmdModify.BackColor = System.Drawing.SystemColors.Control
        Me.CmdModify.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdModify.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.CmdModify.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdModify.Location = New System.Drawing.Point(874, 16)
        Me.CmdModify.Name = "CmdModify"
        Me.CmdModify.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdModify.Size = New System.Drawing.Size(51, 21)
        Me.CmdModify.TabIndex = 204
        Me.CmdModify.Text = "Modify"
        Me.CmdModify.UseVisualStyleBackColor = false
        '
        '_Lable_8
        '
        Me._Lable_8.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_8.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_8.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me._Lable_8.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_8, CType(8,Short))
        Me._Lable_8.Location = New System.Drawing.Point(615, 8)
        Me._Lable_8.Name = "_Lable_8"
        Me._Lable_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_8.Size = New System.Drawing.Size(43, 15)
        Me._Lable_8.TabIndex = 57
        Me._Lable_8.Text = "From:"
        '
        '_Lable_2
        '
        Me._Lable_2.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_2.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me._Lable_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_2, CType(2,Short))
        Me._Lable_2.Location = New System.Drawing.Point(305, 8)
        Me._Lable_2.Name = "_Lable_2"
        Me._Lable_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_2.Size = New System.Drawing.Size(40, 15)
        Me._Lable_2.TabIndex = 56
        Me._Lable_2.Text = "Phone:"
        '
        '_LblReferral_23
        '
        Me._LblReferral_23.BackColor = System.Drawing.SystemColors.Control
        Me._LblReferral_23.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblReferral_23.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me._LblReferral_23.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblReferral.SetIndex(Me._LblReferral_23, CType(23,Short))
        Me._LblReferral_23.Location = New System.Drawing.Point(485, 8)
        Me._LblReferral_23.Name = "_LblReferral_23"
        Me._LblReferral_23.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblReferral_23.Size = New System.Drawing.Size(28, 15)
        Me._LblReferral_23.TabIndex = 55
        Me._LblReferral_23.Text = "Ext.:"
        '
        '_Lable_4
        '
        Me._Lable_4.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_4.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me._Lable_4.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_4, CType(4,Short))
        Me._Lable_4.Location = New System.Drawing.Point(78, 8)
        Me._Lable_4.Name = "_Lable_4"
        Me._Lable_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_4.Size = New System.Drawing.Size(37, 15)
        Me._Lable_4.TabIndex = 54
        Me._Lable_4.Text = "Name:"
        '
        'LblPhone
        '
        Me.LblPhone.BackColor = System.Drawing.SystemColors.Control
        Me.LblPhone.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblPhone.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.LblPhone.ForeColor = System.Drawing.Color.Red
        Me.LblPhone.Location = New System.Drawing.Point(344, 8)
        Me.LblPhone.Name = "LblPhone"
        Me.LblPhone.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblPhone.Size = New System.Drawing.Size(99, 13)
        Me.LblPhone.TabIndex = 53
        '
        'LblExtension
        '
        Me.LblExtension.BackColor = System.Drawing.SystemColors.Control
        Me.LblExtension.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblExtension.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.LblExtension.ForeColor = System.Drawing.Color.Red
        Me.LblExtension.Location = New System.Drawing.Point(518, 8)
        Me.LblExtension.Name = "LblExtension"
        Me.LblExtension.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblExtension.Size = New System.Drawing.Size(48, 13)
        Me.LblExtension.TabIndex = 52
        '
        'LblName
        '
        Me.LblName.BackColor = System.Drawing.SystemColors.Control
        Me.LblName.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblName.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.LblName.ForeColor = System.Drawing.Color.Red
        Me.LblName.Location = New System.Drawing.Point(115, 8)
        Me.LblName.Name = "LblName"
        Me.LblName.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblName.Size = New System.Drawing.Size(161, 29)
        Me.LblName.TabIndex = 51
        '
        'LblOrganization
        '
        Me.LblOrganization.BackColor = System.Drawing.SystemColors.Control
        Me.LblOrganization.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblOrganization.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.LblOrganization.ForeColor = System.Drawing.Color.Red
        Me.LblOrganization.Location = New System.Drawing.Point(664, 8)
        Me.LblOrganization.Name = "LblOrganization"
        Me.LblOrganization.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblOrganization.Size = New System.Drawing.Size(178, 29)
        Me.LblOrganization.TabIndex = 50
        '
        'CmdOK
        '
        Me.CmdOK.BackColor = System.Drawing.SystemColors.Control
        Me.CmdOK.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdOK.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.CmdOK.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdOK.Location = New System.Drawing.Point(1194, 32)
        Me.CmdOK.Name = "CmdOK"
        Me.CmdOK.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdOK.Size = New System.Drawing.Size(80, 21)
        Me.CmdOK.TabIndex = 100
        Me.CmdOK.Text = "Save"
        Me.CmdOK.UseVisualStyleBackColor = false
        '
        'TabMessage
        '
        Me.TabMessage.Alignment = System.Windows.Forms.TabAlignment.Right
        Me.TabMessage.Controls.Add(Me._TabMessage_TabPage0)
        Me.TabMessage.Controls.Add(Me._TabMessage_TabPage1)
        Me.TabMessage.Font = New System.Drawing.Font("Arial", 9!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.TabMessage.ItemSize = New System.Drawing.Size(42, 30)
        Me.TabMessage.Location = New System.Drawing.Point(6, 55)
        Me.TabMessage.Multiline = true
        Me.TabMessage.Name = "TabMessage"
        Me.TabMessage.SelectedIndex = 0
        Me.TabMessage.Size = New System.Drawing.Size(987, 532)
        Me.TabMessage.TabIndex = 15
        Me.TabMessage.TabStop = false
        '
        '_TabMessage_TabPage0
        '
        Me._TabMessage_TabPage0.Controls.Add(Me._Frame_4)
        Me._TabMessage_TabPage0.Controls.Add(Me._Frame_1)
        Me._TabMessage_TabPage0.Controls.Add(Me._Picture_0)
        Me._TabMessage_TabPage0.Location = New System.Drawing.Point(4, 4)
        Me._TabMessage_TabPage0.Name = "_TabMessage_TabPage0"
        Me._TabMessage_TabPage0.Size = New System.Drawing.Size(949, 524)
        Me._TabMessage_TabPage0.TabIndex = 0
        Me._TabMessage_TabPage0.Text = "Message Info"
        '
        '_Frame_4
        '
        Me._Frame_4.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_4.Controls.Add(Me._TxtAlerts_0)
        Me._Frame_4.Controls.Add(Me._TxtAlerts_1)
        Me._Frame_4.Controls.Add(Me._Lable_0)
        Me._Frame_4.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me._Frame_4.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_4, CType(4,Short))
        Me._Frame_4.Location = New System.Drawing.Point(0, 208)
        Me._Frame_4.Name = "_Frame_4"
        Me._Frame_4.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_4.Size = New System.Drawing.Size(545, 308)
        Me._Frame_4.TabIndex = 43
        Me._Frame_4.TabStop = false
        '
        '_TxtAlerts_0
        '
        Me._TxtAlerts_0.BackColor = System.Drawing.SystemColors.Window
        Me._TxtAlerts_0.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me._TxtAlerts_0.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.TxtAlerts.SetIndex(Me._TxtAlerts_0, CType(0,Short))
        Me._TxtAlerts_0.Location = New System.Drawing.Point(66, 14)
        Me._TxtAlerts_0.Name = "_TxtAlerts_0"
        Me._TxtAlerts_0.ReadOnly = true
        Me._TxtAlerts_0.ScrollBars = System.Windows.Forms.RichTextBoxScrollBars.Vertical
        Me._TxtAlerts_0.Size = New System.Drawing.Size(225, 289)
        Me._TxtAlerts_0.TabIndex = 58
        Me._TxtAlerts_0.TabStop = false
        Me._TxtAlerts_0.Text = ""
        '
        '_TxtAlerts_1
        '
        Me._TxtAlerts_1.BackColor = System.Drawing.SystemColors.Window
        Me._TxtAlerts_1.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me._TxtAlerts_1.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.TxtAlerts.SetIndex(Me._TxtAlerts_1, CType(1,Short))
        Me._TxtAlerts_1.Location = New System.Drawing.Point(308, 14)
        Me._TxtAlerts_1.Name = "_TxtAlerts_1"
        Me._TxtAlerts_1.ReadOnly = true
        Me._TxtAlerts_1.ScrollBars = System.Windows.Forms.RichTextBoxScrollBars.Vertical
        Me._TxtAlerts_1.Size = New System.Drawing.Size(225, 289)
        Me._TxtAlerts_1.TabIndex = 59
        Me._TxtAlerts_1.TabStop = false
        Me._TxtAlerts_1.Text = ""
        '
        '_Lable_0
        '
        Me._Lable_0.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_0.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me._Lable_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_0, CType(0,Short))
        Me._Lable_0.Location = New System.Drawing.Point(9, 14)
        Me._Lable_0.Name = "_Lable_0"
        Me._Lable_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_0.Size = New System.Drawing.Size(65, 15)
        Me._Lable_0.TabIndex = 44
        Me._Lable_0.Text = "Alerts"
        '
        '_Frame_1
        '
        Me._Frame_1.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_1.Controls.Add(Me.CmdChangeSource)
        Me._Frame_1.Controls.Add(Me.CmdFind)
        Me._Frame_1.Controls.Add(Me.CmdOnCallMain)
        Me._Frame_1.Controls.Add(Me.ChkUrgent)
        Me._Frame_1.Controls.Add(Me.CboOrganization)
        Me._Frame_1.Controls.Add(Me.TxtPersonType)
        Me._Frame_1.Controls.Add(Me.CboName)
        Me._Frame_1.Controls.Add(Me.CboMessageType)
        Me._Frame_1.Controls.Add(Me.TxtMessage)
        Me._Frame_1.Controls.Add(Me.TxtImportPatient)
        Me._Frame_1.Controls.Add(Me.TxtUNOSID)
        Me._Frame_1.Controls.Add(Me.TxtImportCenter)
        Me._Frame_1.Controls.Add(Me.LblUNOSID)
        Me._Frame_1.Controls.Add(Me.LblImportPatient)
        Me._Frame_1.Controls.Add(Me.LblMessage)
        Me._Frame_1.Controls.Add(Me._Lable_6)
        Me._Frame_1.Controls.Add(Me._Lable_5)
        Me._Frame_1.Controls.Add(Me._Lable_3)
        Me._Frame_1.Controls.Add(Me.LblImportCenter)
        Me._Frame_1.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me._Frame_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_1, CType(1,Short))
        Me._Frame_1.Location = New System.Drawing.Point(0, -6)
        Me._Frame_1.Name = "_Frame_1"
        Me._Frame_1.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_1.Size = New System.Drawing.Size(545, 208)
        Me._Frame_1.TabIndex = 0
        Me._Frame_1.TabStop = false
        '
        'CmdChangeSource
        '
        Me.CmdChangeSource.BackColor = System.Drawing.SystemColors.Control
        Me.CmdChangeSource.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdChangeSource.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.CmdChangeSource.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdChangeSource.Location = New System.Drawing.Point(3, 153)
        Me.CmdChangeSource.Name = "CmdChangeSource"
        Me.CmdChangeSource.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdChangeSource.Size = New System.Drawing.Size(66, 21)
        Me.CmdChangeSource.TabIndex = 18
        Me.CmdChangeSource.Text = "For Org..."
        Me.CmdChangeSource.UseVisualStyleBackColor = false
        '
        'CmdFind
        '
        Me.CmdFind.BackColor = System.Drawing.SystemColors.Control
        Me.CmdFind.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdFind.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.CmdFind.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdFind.Location = New System.Drawing.Point(72, 130)
        Me.CmdFind.Name = "CmdFind"
        Me.CmdFind.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdFind.Size = New System.Drawing.Size(85, 21)
        Me.CmdFind.TabIndex = 17
        Me.CmdFind.Text = "Find Person..."
        Me.CmdFind.UseVisualStyleBackColor = false
        '
        'CmdOnCallMain
        '
        Me.CmdOnCallMain.BackColor = System.Drawing.SystemColors.Control
        Me.CmdOnCallMain.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdOnCallMain.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.CmdOnCallMain.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdOnCallMain.Location = New System.Drawing.Point(396, 153)
        Me.CmdOnCallMain.Name = "CmdOnCallMain"
        Me.CmdOnCallMain.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdOnCallMain.Size = New System.Drawing.Size(83, 21)
        Me.CmdOnCallMain.TabIndex = 20
        Me.CmdOnCallMain.Text = "On Call..."
        Me.CmdOnCallMain.UseVisualStyleBackColor = false
        '
        'ChkUrgent
        '
        Me.ChkUrgent.BackColor = System.Drawing.SystemColors.Control
        Me.ChkUrgent.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkUrgent.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.ChkUrgent.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkUrgent.Location = New System.Drawing.Point(282, 18)
        Me.ChkUrgent.Name = "ChkUrgent"
        Me.ChkUrgent.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkUrgent.Size = New System.Drawing.Size(129, 15)
        Me.ChkUrgent.TabIndex = 12
        Me.ChkUrgent.Text = "Callback ASAP"
        Me.ChkUrgent.UseVisualStyleBackColor = false
        '
        'CboOrganization
        '
        Me.CboOrganization.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboOrganization.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboOrganization.BackColor = System.Drawing.SystemColors.Window
        Me.CboOrganization.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboOrganization.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboOrganization.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.CboOrganization.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboOrganization.Location = New System.Drawing.Point(72, 154)
        Me.CboOrganization.Name = "CboOrganization"
        Me.CboOrganization.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboOrganization.Size = New System.Drawing.Size(317, 22)
        Me.CboOrganization.Sorted = true
        Me.CboOrganization.TabIndex = 19
        '
        'TxtPersonType
        '
        Me.TxtPersonType.AcceptsReturn = true
        Me.TxtPersonType.BackColor = System.Drawing.SystemColors.Window
        Me.TxtPersonType.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtPersonType.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.TxtPersonType.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtPersonType.Location = New System.Drawing.Point(343, 178)
        Me.TxtPersonType.MaxLength = 0
        Me.TxtPersonType.Name = "TxtPersonType"
        Me.TxtPersonType.ReadOnly = true
        Me.TxtPersonType.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtPersonType.Size = New System.Drawing.Size(188, 20)
        Me.TxtPersonType.TabIndex = 22
        Me.TxtPersonType.TabStop = false
        '
        'CboName
        '
        Me.CboName.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboName.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboName.BackColor = System.Drawing.SystemColors.Window
        Me.CboName.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboName.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboName.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.CboName.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboName.Location = New System.Drawing.Point(72, 178)
        Me.CboName.Name = "CboName"
        Me.CboName.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboName.Size = New System.Drawing.Size(233, 22)
        Me.CboName.Sorted = true
        Me.CboName.TabIndex = 21
        '
        'CboMessageType
        '
        Me.CboMessageType.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboMessageType.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboMessageType.BackColor = System.Drawing.SystemColors.Window
        Me.CboMessageType.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboMessageType.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboMessageType.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.CboMessageType.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboMessageType.Location = New System.Drawing.Point(72, 14)
        Me.CboMessageType.Name = "CboMessageType"
        Me.CboMessageType.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboMessageType.Size = New System.Drawing.Size(203, 22)
        Me.CboMessageType.Sorted = true
        Me.CboMessageType.TabIndex = 11
        '
        'TxtMessage
        '
        Me.TxtMessage.BackColor = System.Drawing.Color.White
        Me.TxtMessage.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.TxtMessage.Location = New System.Drawing.Point(72, 38)
        Me.TxtMessage.MaxLength = 1000
        Me.TxtMessage.Name = "TxtMessage"
        Me.TxtMessage.RightMargin = 380
        Me.TxtMessage.ScrollBars = System.Windows.Forms.RichTextBoxScrollBars.Vertical
        Me.TxtMessage.Size = New System.Drawing.Size(465, 89)
        Me.TxtMessage.TabIndex = 16
        Me.TxtMessage.Text = ""
        '
        'TxtImportPatient
        '
        Me.TxtImportPatient.AcceptsReturn = true
        Me.TxtImportPatient.BackColor = System.Drawing.SystemColors.Window
        Me.TxtImportPatient.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtImportPatient.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.TxtImportPatient.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtImportPatient.Location = New System.Drawing.Point(176, 38)
        Me.TxtImportPatient.MaxLength = 50
        Me.TxtImportPatient.Name = "TxtImportPatient"
        Me.TxtImportPatient.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtImportPatient.Size = New System.Drawing.Size(159, 20)
        Me.TxtImportPatient.TabIndex = 14
        Me.TxtImportPatient.Visible = false
        '
        'TxtUNOSID
        '
        Me.TxtUNOSID.AcceptsReturn = true
        Me.TxtUNOSID.BackColor = System.Drawing.SystemColors.Window
        Me.TxtUNOSID.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtUNOSID.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.TxtUNOSID.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtUNOSID.Location = New System.Drawing.Point(392, 38)
        Me.TxtUNOSID.MaxLength = 20
        Me.TxtUNOSID.Name = "TxtUNOSID"
        Me.TxtUNOSID.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtUNOSID.Size = New System.Drawing.Size(83, 20)
        Me.TxtUNOSID.TabIndex = 15
        Me.TxtUNOSID.Visible = false
        '
        'TxtImportCenter
        '
        Me.TxtImportCenter.AcceptsReturn = true
        Me.TxtImportCenter.BackColor = System.Drawing.SystemColors.Window
        Me.TxtImportCenter.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtImportCenter.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.TxtImportCenter.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtImportCenter.Location = New System.Drawing.Point(72, 38)
        Me.TxtImportCenter.MaxLength = 5
        Me.TxtImportCenter.Name = "TxtImportCenter"
        Me.TxtImportCenter.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtImportCenter.Size = New System.Drawing.Size(61, 20)
        Me.TxtImportCenter.TabIndex = 13
        Me.TxtImportCenter.Visible = false
        '
        'LblUNOSID
        '
        Me.LblUNOSID.BackColor = System.Drawing.SystemColors.Control
        Me.LblUNOSID.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblUNOSID.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.LblUNOSID.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblUNOSID.Location = New System.Drawing.Point(340, 42)
        Me.LblUNOSID.Name = "LblUNOSID"
        Me.LblUNOSID.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblUNOSID.Size = New System.Drawing.Size(55, 15)
        Me.LblUNOSID.TabIndex = 48
        Me.LblUNOSID.Text = "UNOS ID"
        Me.LblUNOSID.Visible = false
        '
        'LblImportPatient
        '
        Me.LblImportPatient.BackColor = System.Drawing.SystemColors.Control
        Me.LblImportPatient.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblImportPatient.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.LblImportPatient.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblImportPatient.Location = New System.Drawing.Point(138, 42)
        Me.LblImportPatient.Name = "LblImportPatient"
        Me.LblImportPatient.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblImportPatient.Size = New System.Drawing.Size(39, 15)
        Me.LblImportPatient.TabIndex = 47
        Me.LblImportPatient.Text = "Patient"
        Me.LblImportPatient.Visible = false
        '
        'LblMessage
        '
        Me.LblMessage.BackColor = System.Drawing.SystemColors.Control
        Me.LblMessage.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblMessage.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.LblMessage.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblMessage.Location = New System.Drawing.Point(9, 38)
        Me.LblMessage.Name = "LblMessage"
        Me.LblMessage.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblMessage.Size = New System.Drawing.Size(55, 15)
        Me.LblMessage.TabIndex = 27
        Me.LblMessage.Text = "Message"
        '
        '_Lable_6
        '
        Me._Lable_6.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_6.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me._Lable_6.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_6, CType(6,Short))
        Me._Lable_6.Location = New System.Drawing.Point(310, 182)
        Me._Lable_6.Name = "_Lable_6"
        Me._Lable_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_6.Size = New System.Drawing.Size(28, 15)
        Me._Lable_6.TabIndex = 26
        Me._Lable_6.Text = "Role"
        '
        '_Lable_5
        '
        Me._Lable_5.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_5.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me._Lable_5.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_5, CType(5,Short))
        Me._Lable_5.Location = New System.Drawing.Point(9, 182)
        Me._Lable_5.Name = "_Lable_5"
        Me._Lable_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_5.Size = New System.Drawing.Size(55, 15)
        Me._Lable_5.TabIndex = 25
        Me._Lable_5.Text = "Name"
        '
        '_Lable_3
        '
        Me._Lable_3.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_3.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me._Lable_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_3, CType(3,Short))
        Me._Lable_3.Location = New System.Drawing.Point(9, 18)
        Me._Lable_3.Name = "_Lable_3"
        Me._Lable_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_3.Size = New System.Drawing.Size(90, 15)
        Me._Lable_3.TabIndex = 24
        Me._Lable_3.Text = "Msg Type"
        '
        'LblImportCenter
        '
        Me.LblImportCenter.BackColor = System.Drawing.SystemColors.Control
        Me.LblImportCenter.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblImportCenter.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.LblImportCenter.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblImportCenter.Location = New System.Drawing.Point(16, 42)
        Me.LblImportCenter.Name = "LblImportCenter"
        Me.LblImportCenter.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblImportCenter.Size = New System.Drawing.Size(53, 15)
        Me.LblImportCenter.TabIndex = 49
        Me.LblImportCenter.Text = "Tx Center"
        Me.LblImportCenter.Visible = false
        '
        '_Picture_0
        '
        Me._Picture_0.BackColor = System.Drawing.SystemColors.Control
        Me._Picture_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._Picture_0.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me._Picture_0.ForeColor = System.Drawing.SystemColors.WindowText
        Me.Picture.SetIndex(Me._Picture_0, CType(0,Short))
        Me._Picture_0.Location = New System.Drawing.Point(516, 0)
        Me._Picture_0.Name = "_Picture_0"
        Me._Picture_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Picture_0.Size = New System.Drawing.Size(7, 91)
        Me._Picture_0.TabIndex = 45
        Me._Picture_0.TabStop = false
        '
        '_TabMessage_TabPage1
        '
        Me._TabMessage_TabPage1.Controls.Add(Me._Frame_2)
        Me._TabMessage_TabPage1.Controls.Add(Me._Frame_3)
        Me._TabMessage_TabPage1.Controls.Add(Me._Picture_2)
        Me._TabMessage_TabPage1.Location = New System.Drawing.Point(4, 4)
        Me._TabMessage_TabPage1.Name = "_TabMessage_TabPage1"
        Me._TabMessage_TabPage1.Size = New System.Drawing.Size(949, 524)
        Me._TabMessage_TabPage1.TabIndex = 1
        Me._TabMessage_TabPage1.Text = "Event Info"
        '
        '_Frame_2
        '
        Me._Frame_2.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_2.Controls.Add(Me.TxtCallDate)
        Me._Frame_2.Controls.Add(Me.TxtTotalTimeCounter)
        Me._Frame_2.Controls.Add(Me.CboCallByEmployee)
        Me._Frame_2.Controls.Add(Me.LblBy)
        Me._Frame_2.Controls.Add(Me.LblInitialCallDate)
        Me._Frame_2.Controls.Add(Me.LblTotalTime)
        Me._Frame_2.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me._Frame_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_2, CType(2,Short))
        Me._Frame_2.Location = New System.Drawing.Point(7, 477)
        Me._Frame_2.Name = "_Frame_2"
        Me._Frame_2.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_2.Size = New System.Drawing.Size(924, 39)
        Me._Frame_2.TabIndex = 36
        Me._Frame_2.TabStop = false
        '
        'TxtCallDate
        '
        Me.TxtCallDate.AcceptsReturn = true
        Me.TxtCallDate.BackColor = System.Drawing.Color.FromArgb(CType(CType(192,Byte),Integer), CType(CType(192,Byte),Integer), CType(CType(192,Byte),Integer))
        Me.TxtCallDate.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtCallDate.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.TxtCallDate.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtCallDate.Location = New System.Drawing.Point(139, 12)
        Me.TxtCallDate.MaxLength = 0
        Me.TxtCallDate.Name = "TxtCallDate"
        Me.TxtCallDate.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtCallDate.Size = New System.Drawing.Size(87, 20)
        Me.TxtCallDate.TabIndex = 39
        Me.TxtCallDate.TabStop = false
        Me.TxtCallDate.Text = "00/00/00  00:00"
        '
        'TxtTotalTimeCounter
        '
        Me.TxtTotalTimeCounter.AcceptsReturn = true
        Me.TxtTotalTimeCounter.BackColor = System.Drawing.Color.FromArgb(CType(CType(192,Byte),Integer), CType(CType(192,Byte),Integer), CType(CType(192,Byte),Integer))
        Me.TxtTotalTimeCounter.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtTotalTimeCounter.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.TxtTotalTimeCounter.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtTotalTimeCounter.Location = New System.Drawing.Point(729, 12)
        Me.TxtTotalTimeCounter.MaxLength = 0
        Me.TxtTotalTimeCounter.Name = "TxtTotalTimeCounter"
        Me.TxtTotalTimeCounter.ReadOnly = true
        Me.TxtTotalTimeCounter.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtTotalTimeCounter.Size = New System.Drawing.Size(51, 20)
        Me.TxtTotalTimeCounter.TabIndex = 38
        Me.TxtTotalTimeCounter.TabStop = false
        Me.TxtTotalTimeCounter.Text = "00:00:00"
        '
        'CboCallByEmployee
        '
        Me.CboCallByEmployee.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboCallByEmployee.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboCallByEmployee.BackColor = System.Drawing.Color.FromArgb(CType(CType(192,Byte),Integer), CType(CType(192,Byte),Integer), CType(CType(192,Byte),Integer))
        Me.CboCallByEmployee.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboCallByEmployee.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboCallByEmployee.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.CboCallByEmployee.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboCallByEmployee.Location = New System.Drawing.Point(384, 12)
        Me.CboCallByEmployee.Name = "CboCallByEmployee"
        Me.CboCallByEmployee.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboCallByEmployee.Size = New System.Drawing.Size(127, 22)
        Me.CboCallByEmployee.TabIndex = 37
        Me.CboCallByEmployee.TabStop = false
        '
        'LblBy
        '
        Me.LblBy.BackColor = System.Drawing.SystemColors.Control
        Me.LblBy.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblBy.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.LblBy.ForeColor = System.Drawing.Color.Black
        Me.LblBy.Location = New System.Drawing.Point(360, 15)
        Me.LblBy.Name = "LblBy"
        Me.LblBy.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblBy.Size = New System.Drawing.Size(20, 15)
        Me.LblBy.TabIndex = 42
        Me.LblBy.Text = "By"
        '
        'LblInitialCallDate
        '
        Me.LblInitialCallDate.AutoSize = true
        Me.LblInitialCallDate.BackColor = System.Drawing.SystemColors.Control
        Me.LblInitialCallDate.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblInitialCallDate.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.LblInitialCallDate.ForeColor = System.Drawing.Color.Black
        Me.LblInitialCallDate.Location = New System.Drawing.Point(91, 15)
        Me.LblInitialCallDate.Name = "LblInitialCallDate"
        Me.LblInitialCallDate.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblInitialCallDate.Size = New System.Drawing.Size(49, 14)
        Me.LblInitialCallDate.TabIndex = 41
        Me.LblInitialCallDate.Text = "Call Date"
        '
        'LblTotalTime
        '
        Me.LblTotalTime.AutoSize = true
        Me.LblTotalTime.BackColor = System.Drawing.SystemColors.Control
        Me.LblTotalTime.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblTotalTime.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.LblTotalTime.ForeColor = System.Drawing.Color.Black
        Me.LblTotalTime.Location = New System.Drawing.Point(648, 15)
        Me.LblTotalTime.Name = "LblTotalTime"
        Me.LblTotalTime.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblTotalTime.Size = New System.Drawing.Size(74, 14)
        Me.LblTotalTime.TabIndex = 40
        Me.LblTotalTime.Text = "Total Call Time"
        '
        '_Frame_3
        '
        Me._Frame_3.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_3.Controls.Add(Me.CmdNewEvent)
        Me._Frame_3.Controls.Add(Me.chkViewLogEventDeleted)
        Me._Frame_3.Controls.Add(Me.CmdColorKey)
        Me._Frame_3.Controls.Add(Me.CmdDelete)
        Me._Frame_3.Controls.Add(Me.CmdOnCall)
        Me._Frame_3.Controls.Add(Me._Picture_1)
        Me._Frame_3.Controls.Add(Me.LstViewLogEvent)
        Me._Frame_3.Controls.Add(Me.LstViewPending)
        Me._Frame_3.Controls.Add(Me._Lable_19)
        Me._Frame_3.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me._Frame_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_3, CType(3,Short))
        Me._Frame_3.Location = New System.Drawing.Point(7, 9)
        Me._Frame_3.Name = "_Frame_3"
        Me._Frame_3.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_3.Size = New System.Drawing.Size(924, 463)
        Me._Frame_3.TabIndex = 28
        Me._Frame_3.TabStop = false
        '
        'CmdNewEvent
        '
        Me.CmdNewEvent.BackColor = System.Drawing.SystemColors.Control
        Me.CmdNewEvent.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdNewEvent.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.CmdNewEvent.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdNewEvent.Location = New System.Drawing.Point(537, 78)
        Me.CmdNewEvent.Name = "CmdNewEvent"
        Me.CmdNewEvent.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdNewEvent.Size = New System.Drawing.Size(83, 21)
        Me.CmdNewEvent.TabIndex = 18
        Me.CmdNewEvent.TabStop = false
        Me.CmdNewEvent.Text = "New Event..."
        Me.CmdNewEvent.UseVisualStyleBackColor = false
        '
        'chkViewLogEventDeleted
        '
        Me.chkViewLogEventDeleted.BackColor = System.Drawing.SystemColors.Control
        Me.chkViewLogEventDeleted.Cursor = System.Windows.Forms.Cursors.Default
        Me.chkViewLogEventDeleted.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.chkViewLogEventDeleted.ForeColor = System.Drawing.SystemColors.ControlText
        Me.chkViewLogEventDeleted.Location = New System.Drawing.Point(255, 431)
        Me.chkViewLogEventDeleted.Name = "chkViewLogEventDeleted"
        Me.chkViewLogEventDeleted.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.chkViewLogEventDeleted.Size = New System.Drawing.Size(125, 22)
        Me.chkViewLogEventDeleted.TabIndex = 62
        Me.chkViewLogEventDeleted.Text = "Display All Events"
        Me.chkViewLogEventDeleted.UseVisualStyleBackColor = false
        '
        'CmdColorKey
        '
        Me.CmdColorKey.BackColor = System.Drawing.SystemColors.Control
        Me.CmdColorKey.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdColorKey.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.CmdColorKey.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdColorKey.Location = New System.Drawing.Point(15, 431)
        Me.CmdColorKey.Name = "CmdColorKey"
        Me.CmdColorKey.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdColorKey.Size = New System.Drawing.Size(89, 22)
        Me.CmdColorKey.TabIndex = 61
        Me.CmdColorKey.Text = "Color Key"
        Me.CmdColorKey.UseVisualStyleBackColor = false
        '
        'CmdDelete
        '
        Me.CmdDelete.BackColor = System.Drawing.SystemColors.Control
        Me.CmdDelete.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdDelete.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.CmdDelete.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdDelete.Location = New System.Drawing.Point(801, 432)
        Me.CmdDelete.Name = "CmdDelete"
        Me.CmdDelete.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdDelete.Size = New System.Drawing.Size(95, 21)
        Me.CmdDelete.TabIndex = 30
        Me.CmdDelete.TabStop = false
        Me.CmdDelete.Text = "Delete Event"
        Me.CmdDelete.UseVisualStyleBackColor = false
        '
        'CmdOnCall
        '
        Me.CmdOnCall.BackColor = System.Drawing.SystemColors.Control
        Me.CmdOnCall.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdOnCall.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.CmdOnCall.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdOnCall.Location = New System.Drawing.Point(537, 54)
        Me.CmdOnCall.Name = "CmdOnCall"
        Me.CmdOnCall.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdOnCall.Size = New System.Drawing.Size(83, 21)
        Me.CmdOnCall.TabIndex = 17
        Me.CmdOnCall.TabStop = false
        Me.CmdOnCall.Text = "On Call..."
        Me.CmdOnCall.UseVisualStyleBackColor = false
        '
        '_Picture_1
        '
        Me._Picture_1.BackColor = System.Drawing.SystemColors.Control
        Me._Picture_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._Picture_1.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me._Picture_1.ForeColor = System.Drawing.SystemColors.WindowText
        Me.Picture.SetIndex(Me._Picture_1, CType(1,Short))
        Me._Picture_1.Location = New System.Drawing.Point(626, 16)
        Me._Picture_1.Name = "_Picture_1"
        Me._Picture_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Picture_1.Size = New System.Drawing.Size(9, 73)
        Me._Picture_1.TabIndex = 29
        Me._Picture_1.TabStop = false
        '
        'LstViewLogEvent
        '
        Me.LstViewLogEvent.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewLogEvent.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.LstViewLogEvent.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.LstViewLogEvent.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewLogEvent.FullRowSelect = true
        Me.LstViewLogEvent.HideSelection = false
        Me.LstViewLogEvent.LabelWrap = false
        Me.LstViewLogEvent.Location = New System.Drawing.Point(8, 105)
        Me.LstViewLogEvent.Name = "LstViewLogEvent"
        Me.LstViewLogEvent.Size = New System.Drawing.Size(906, 316)
        Me.LstViewLogEvent.TabIndex = 19
        Me.LstViewLogEvent.TabStop = false
        Me.LstViewLogEvent.UseCompatibleStateImageBehavior = false
        Me.LstViewLogEvent.View = System.Windows.Forms.View.Details
        '
        'LstViewPending
        '
        Me.LstViewPending.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewPending.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.LstViewPending.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.LstViewPending.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewPending.FullRowSelect = true
        Me.LstViewPending.HideSelection = false
        Me.LstViewPending.LabelWrap = false
        Me.LstViewPending.Location = New System.Drawing.Point(8, 34)
        Me.LstViewPending.Name = "LstViewPending"
        Me.LstViewPending.Size = New System.Drawing.Size(523, 69)
        Me.LstViewPending.TabIndex = 16
        Me.LstViewPending.TabStop = false
        Me.LstViewPending.UseCompatibleStateImageBehavior = false
        Me.LstViewPending.View = System.Windows.Forms.View.Details
        '
        '_Lable_19
        '
        Me._Lable_19.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_19.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_19.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me._Lable_19.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_19, CType(19,Short))
        Me._Lable_19.Location = New System.Drawing.Point(10, 18)
        Me._Lable_19.Name = "_Lable_19"
        Me._Lable_19.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_19.Size = New System.Drawing.Size(121, 15)
        Me._Lable_19.TabIndex = 33
        Me._Lable_19.Text = "Pending Events"
        '
        '_Picture_2
        '
        Me._Picture_2.BackColor = System.Drawing.SystemColors.Control
        Me._Picture_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._Picture_2.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me._Picture_2.ForeColor = System.Drawing.SystemColors.WindowText
        Me.Picture.SetIndex(Me._Picture_2, CType(2,Short))
        Me._Picture_2.Location = New System.Drawing.Point(711, 362)
        Me._Picture_2.Name = "_Picture_2"
        Me._Picture_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Picture_2.Size = New System.Drawing.Size(3, 69)
        Me._Picture_2.TabIndex = 46
        Me._Picture_2.TabStop = false
        '
        'VP_Timer
        '
        Me.VP_Timer.Interval = 30000
        '
        'TimerTotalTime
        '
        Me.TimerTotalTime.Enabled = true
        Me.TimerTotalTime.Interval = 1000
        '
        'Label4
        '
        Me.Label4.AutoSize = true
        Me.Label4.BackColor = System.Drawing.SystemColors.Control
        Me.Label4.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label4.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0,Byte))
        Me.Label4.ForeColor = System.Drawing.Color.Black
        Me.Label4.Location = New System.Drawing.Point(1004, 178)
        Me.Label4.Name = "Label4"
        Me.Label4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label4.Size = New System.Drawing.Size(75, 14)
        Me.Label4.TabIndex = 212
        Me.Label4.Text = "Contact Alerts"
        '
        'rtbScheduleAlert
        '
        Me.rtbScheduleAlert.BackColor = System.Drawing.SystemColors.Window
        Me.rtbScheduleAlert.Location = New System.Drawing.Point(1003, 195)
        Me.rtbScheduleAlert.Name = "rtbScheduleAlert"
        Me.rtbScheduleAlert.ReadOnly = true
        Me.rtbScheduleAlert.Required = false
        Me.rtbScheduleAlert.Size = New System.Drawing.Size(270, 336)
        Me.rtbScheduleAlert.SpellCheckEnabled = false
        Me.rtbScheduleAlert.TabIndex = 211
        Me.rtbScheduleAlert.Text = ""
        '
        'FrmMessage
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6!, 14!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.ClientSize = New System.Drawing.Size(1287, 592)
        Me.Controls.Add(Me.Label4)
        Me.Controls.Add(Me.rtbScheduleAlert)
        Me.Controls.Add(Me.ChkExclusive)
        Me.Controls.Add(Me.ChkTemp)
        Me.Controls.Add(Me.CmdCancel)
        Me.Controls.Add(Me._Frame_0)
        Me.Controls.Add(Me.CmdOK)
        Me.Controls.Add(Me.TabMessage)
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.KeyPreview = True
        Me.Location = New System.Drawing.Point(157, 102)
        Me.MaximizeBox = False
        Me.Name = "FrmMessage"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Message - Call #"
        Me._Frame_0.ResumeLayout(false)
        Me.TabMessage.ResumeLayout(false)
        Me._TabMessage_TabPage0.ResumeLayout(false)
        Me._Frame_4.ResumeLayout(false)
        Me._Frame_1.ResumeLayout(false)
        Me._Frame_1.PerformLayout
        CType(Me._Picture_0,System.ComponentModel.ISupportInitialize).EndInit
        Me._TabMessage_TabPage1.ResumeLayout(false)
        Me._Frame_2.ResumeLayout(false)
        Me._Frame_2.PerformLayout
        Me._Frame_3.ResumeLayout(false)
        CType(Me._Picture_1,System.ComponentModel.ISupportInitialize).EndInit
        CType(Me._Picture_2,System.ComponentModel.ISupportInitialize).EndInit
        CType(Me.Frame,System.ComponentModel.ISupportInitialize).EndInit
        CType(Me.Lable,System.ComponentModel.ISupportInitialize).EndInit
        CType(Me.LblReferral,System.ComponentModel.ISupportInitialize).EndInit
        CType(Me.Picture,System.ComponentModel.ISupportInitialize).EndInit
        CType(Me.TxtAlerts,System.ComponentModel.ISupportInitialize).EndInit
        Me.ResumeLayout(false)
        Me.PerformLayout

End Sub

    Public WithEvents Label4 As Label
    Friend WithEvents rtbScheduleAlert As Statline.Stattrac.Windows.Forms.RichTextBox
#End Region
End Class