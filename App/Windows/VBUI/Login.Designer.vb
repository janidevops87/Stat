<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmLogin
#Region "Windows Form Designer generated code "
	<System.Diagnostics.DebuggerNonUserCode()> Public Sub New()
		MyBase.New()
        'This call is required by the Windows Form Designer.

        InitializeComponent()
        CboConnect_Initialize()
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
	Public WithEvents CboQueue As System.Windows.Forms.ComboBox
	Public WithEvents TxtExtension As System.Windows.Forms.TextBox
	Public WithEvents CboConnect As System.Windows.Forms.ComboBox
	Public WithEvents CmdExit As System.Windows.Forms.Button
	Public WithEvents CmdLogin As System.Windows.Forms.Button
	Public WithEvents TxtPassword As System.Windows.Forms.TextBox
	Public WithEvents TxtUserID As System.Windows.Forms.TextBox
	Public WithEvents Label1 As System.Windows.Forms.Label
	Public WithEvents Label As System.Windows.Forms.Label
	Public WithEvents LblConnect As System.Windows.Forms.Label
	Public WithEvents LblLoginID As System.Windows.Forms.Label
	Public WithEvents LblPassword As System.Windows.Forms.Label
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FrmLogin))
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.CboQueue = New System.Windows.Forms.ComboBox
        Me.TxtExtension = New System.Windows.Forms.TextBox
        Me.CboConnect = New System.Windows.Forms.ComboBox
        Me.CmdExit = New System.Windows.Forms.Button
        Me.CmdLogin = New System.Windows.Forms.Button
        Me.TxtPassword = New System.Windows.Forms.TextBox
        Me.TxtUserID = New System.Windows.Forms.TextBox
        Me.Label1 = New System.Windows.Forms.Label
        Me.Label = New System.Windows.Forms.Label
        Me.LblConnect = New System.Windows.Forms.Label
        Me.LblLoginID = New System.Windows.Forms.Label
        Me.LblPassword = New System.Windows.Forms.Label
        Me.SuspendLayout()
        '
        'CboQueue
        '
        Me.CboQueue.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboQueue.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboQueue.BackColor = System.Drawing.Color.White
        Me.CboQueue.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboQueue.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboQueue.Enabled = False
        Me.CboQueue.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboQueue.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboQueue.Items.AddRange(New Object() {"(800) 494-7828"})
        Me.CboQueue.Location = New System.Drawing.Point(62, 54)
        Me.CboQueue.Name = "CboQueue"
        Me.CboQueue.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboQueue.Size = New System.Drawing.Size(127, 22)
        Me.CboQueue.TabIndex = 2
        Me.CboQueue.Visible = False
        '
        'TxtExtension
        '
        Me.TxtExtension.AcceptsReturn = True
        Me.TxtExtension.BackColor = System.Drawing.Color.White
        Me.TxtExtension.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtExtension.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtExtension.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtExtension.Location = New System.Drawing.Point(62, 80)
        Me.TxtExtension.MaxLength = 25
        Me.TxtExtension.Name = "TxtExtension"
        Me.TxtExtension.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtExtension.Size = New System.Drawing.Size(47, 20)
        Me.TxtExtension.TabIndex = 3
        '
        'CboConnect
        '
        Me.CboConnect.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboConnect.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboConnect.BackColor = System.Drawing.Color.White
        Me.CboConnect.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboConnect.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboConnect.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboConnect.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CboConnect.Location = New System.Drawing.Point(62, 104)
        Me.CboConnect.Name = "CboConnect"
        Me.CboConnect.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboConnect.Size = New System.Drawing.Size(127, 22)
        Me.CboConnect.TabIndex = 4
        '
        'CmdExit
        '
        Me.CmdExit.BackColor = System.Drawing.SystemColors.Control
        Me.CmdExit.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdExit.DialogResult = System.Windows.Forms.DialogResult.Cancel
        Me.CmdExit.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdExit.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdExit.Location = New System.Drawing.Point(26, 136)
        Me.CmdExit.Name = "CmdExit"
        Me.CmdExit.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdExit.Size = New System.Drawing.Size(79, 21)
        Me.CmdExit.TabIndex = 6
        Me.CmdExit.Text = "E&xit"
        Me.CmdExit.UseVisualStyleBackColor = False
        '
        'CmdLogin
        '
        Me.CmdLogin.BackColor = System.Drawing.SystemColors.Control
        Me.CmdLogin.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdLogin.Enabled = False
        Me.CmdLogin.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdLogin.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdLogin.Location = New System.Drawing.Point(112, 136)
        Me.CmdLogin.Name = "CmdLogin"
        Me.CmdLogin.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdLogin.Size = New System.Drawing.Size(79, 23)
        Me.CmdLogin.TabIndex = 5
        Me.CmdLogin.Text = "&Login"
        Me.CmdLogin.UseVisualStyleBackColor = False
        '
        'TxtPassword
        '
        Me.TxtPassword.AcceptsReturn = True
        Me.TxtPassword.BackColor = System.Drawing.Color.White
        Me.TxtPassword.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtPassword.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtPassword.ForeColor = System.Drawing.Color.Black
        Me.TxtPassword.ImeMode = System.Windows.Forms.ImeMode.Disable
        Me.TxtPassword.Location = New System.Drawing.Point(62, 30)
        Me.TxtPassword.MaxLength = 25
        Me.TxtPassword.Name = "TxtPassword"
        Me.TxtPassword.PasswordChar = Global.Microsoft.VisualBasic.ChrW(42)
        Me.TxtPassword.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtPassword.Size = New System.Drawing.Size(127, 20)
        Me.TxtPassword.TabIndex = 1
        '
        'TxtUserID
        '
        Me.TxtUserID.AcceptsReturn = True
        Me.TxtUserID.BackColor = System.Drawing.Color.White
        Me.TxtUserID.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtUserID.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtUserID.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtUserID.Location = New System.Drawing.Point(62, 6)
        Me.TxtUserID.MaxLength = 25
        Me.TxtUserID.Name = "TxtUserID"
        Me.TxtUserID.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtUserID.Size = New System.Drawing.Size(127, 20)
        Me.TxtUserID.TabIndex = 0
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.BackColor = System.Drawing.SystemColors.Control
        Me.Label1.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label1.Location = New System.Drawing.Point(7, 84)
        Me.Label1.Name = "Label1"
        Me.Label1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label1.Size = New System.Drawing.Size(54, 14)
        Me.Label1.TabIndex = 11
        Me.Label1.Text = "Extension"
        Me.Label1.TextAlign = System.Drawing.ContentAlignment.TopRight
        '
        'Label
        '
        Me.Label.AutoSize = True
        Me.Label.BackColor = System.Drawing.SystemColors.Control
        Me.Label.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label.Enabled = False
        Me.Label.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label.Location = New System.Drawing.Point(7, 58)
        Me.Label.Name = "Label"
        Me.Label.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label.Size = New System.Drawing.Size(56, 14)
        Me.Label.TabIndex = 10
        Me.Label.Text = "Callback #"
        Me.Label.TextAlign = System.Drawing.ContentAlignment.TopRight
        Me.Label.Visible = False
        '
        'LblConnect
        '
        Me.LblConnect.AutoSize = True
        Me.LblConnect.BackColor = System.Drawing.SystemColors.Control
        Me.LblConnect.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblConnect.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblConnect.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblConnect.Location = New System.Drawing.Point(7, 108)
        Me.LblConnect.Name = "LblConnect"
        Me.LblConnect.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblConnect.Size = New System.Drawing.Size(47, 14)
        Me.LblConnect.TabIndex = 9
        Me.LblConnect.Text = "Connect"
        Me.LblConnect.TextAlign = System.Drawing.ContentAlignment.TopRight
        '
        'LblLoginID
        '
        Me.LblLoginID.AutoSize = True
        Me.LblLoginID.BackColor = System.Drawing.SystemColors.Control
        Me.LblLoginID.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblLoginID.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblLoginID.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblLoginID.Location = New System.Drawing.Point(7, 10)
        Me.LblLoginID.Name = "LblLoginID"
        Me.LblLoginID.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblLoginID.Size = New System.Drawing.Size(16, 14)
        Me.LblLoginID.TabIndex = 8
        Me.LblLoginID.Text = "ID"
        Me.LblLoginID.TextAlign = System.Drawing.ContentAlignment.TopRight
        '
        'LblPassword
        '
        Me.LblPassword.AutoSize = True
        Me.LblPassword.BackColor = System.Drawing.SystemColors.Control
        Me.LblPassword.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblPassword.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblPassword.ForeColor = System.Drawing.SystemColors.ControlText
        Me.LblPassword.Location = New System.Drawing.Point(7, 34)
        Me.LblPassword.Name = "LblPassword"
        Me.LblPassword.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblPassword.Size = New System.Drawing.Size(57, 14)
        Me.LblPassword.TabIndex = 7
        Me.LblPassword.Text = "Password"
        Me.LblPassword.TextAlign = System.Drawing.ContentAlignment.TopRight
        '
        'FrmLogin
        '
        Me.AcceptButton = Me.CmdLogin
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 14.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.CancelButton = Me.CmdExit
        Me.ClientSize = New System.Drawing.Size(196, 160)
        Me.Controls.Add(Me.CboQueue)
        Me.Controls.Add(Me.TxtExtension)
        Me.Controls.Add(Me.CboConnect)
        Me.Controls.Add(Me.CmdExit)
        Me.Controls.Add(Me.CmdLogin)
        Me.Controls.Add(Me.TxtPassword)
        Me.Controls.Add(Me.TxtUserID)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.Label)
        Me.Controls.Add(Me.LblConnect)
        Me.Controls.Add(Me.LblLoginID)
        Me.Controls.Add(Me.LblPassword)
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Location = New System.Drawing.Point(507, 299)
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "FrmLogin"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.StartPosition = System.Windows.Forms.FormStartPosition.Manual
        Me.Tag = "FrmLogin"
        Me.Text = "Login"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
#End Region 
End Class