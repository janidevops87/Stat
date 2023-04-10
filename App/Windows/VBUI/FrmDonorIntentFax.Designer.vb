<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmDonorIntentFax
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
	Public WithEvents cmdCancel As System.Windows.Forms.Button
    Public WithEvents cmdSend As System.Windows.Forms.Button
    Public WithEvents _Frame_19 As System.Windows.Forms.GroupBox
    Public WithEvents Frame As Microsoft.VisualBasic.Compatibility.VB6.GroupBoxArray
    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.cmdCancel = New System.Windows.Forms.Button()
        Me.cmdSend = New System.Windows.Forms.Button()
        Me._Frame_19 = New System.Windows.Forms.GroupBox()
        Me.RootTableLayoutPanel = New System.Windows.Forms.TableLayoutPanel()
        Me.txtDocumentName = New System.Windows.Forms.TextBox()
        Me.Txtsentto = New System.Windows.Forms.TextBox()
        Me.txtFaxEmail = New System.Windows.Forms.TextBox()
        Me.cmbOrganization = New System.Windows.Forms.ComboBox()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.cmbPerson = New System.Windows.Forms.ComboBox()
        Me.cmbFaxNumber = New System.Windows.Forms.ComboBox()
        Me.lblOrganization = New System.Windows.Forms.Label()
        Me.lblPerson = New System.Windows.Forms.Label()
        Me.lblDocumentName = New System.Windows.Forms.Label()
        Me.lblFaxNumber = New System.Windows.Forms.Label()
        Me.lblFaxEmail = New System.Windows.Forms.Label()
        Me.Frame = New Microsoft.VisualBasic.Compatibility.VB6.GroupBoxArray(Me.components)
        Me._Frame_19.SuspendLayout()
        Me.RootTableLayoutPanel.SuspendLayout()
        CType(Me.Frame, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'cmdCancel
        '
        Me.cmdCancel.BackColor = System.Drawing.SystemColors.Control
        Me.cmdCancel.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdCancel.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdCancel.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdCancel.Location = New System.Drawing.Point(337, 112)
        Me.cmdCancel.Name = "cmdCancel"
        Me.cmdCancel.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdCancel.Size = New System.Drawing.Size(90, 24)
        Me.cmdCancel.TabIndex = 14
        Me.cmdCancel.Text = "Cancel"
        Me.cmdCancel.UseVisualStyleBackColor = False
        '
        'cmdSend
        '
        Me.cmdSend.BackColor = System.Drawing.SystemColors.Control
        Me.cmdSend.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdSend.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdSend.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdSend.Location = New System.Drawing.Point(337, 16)
        Me.cmdSend.Name = "cmdSend"
        Me.cmdSend.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdSend.Size = New System.Drawing.Size(90, 24)
        Me.cmdSend.TabIndex = 13
        Me.cmdSend.Text = "Send"
        Me.cmdSend.UseVisualStyleBackColor = False
        '
        '_Frame_19
        '
        Me._Frame_19.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_19.Controls.Add(Me.RootTableLayoutPanel)
        Me._Frame_19.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_19.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_19, CType(19, Short))
        Me._Frame_19.Location = New System.Drawing.Point(8, 0)
        Me._Frame_19.Name = "_Frame_19"
        Me._Frame_19.Padding = New System.Windows.Forms.Padding(3, 3, 3, 0)
        Me._Frame_19.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_19.Size = New System.Drawing.Size(323, 181)
        Me._Frame_19.TabIndex = 0
        Me._Frame_19.TabStop = False
        '
        'RootTableLayoutPanel
        '
        Me.RootTableLayoutPanel.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink
        Me.RootTableLayoutPanel.ColumnCount = 2
        Me.RootTableLayoutPanel.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle())
        Me.RootTableLayoutPanel.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle())
        Me.RootTableLayoutPanel.Controls.Add(Me.txtDocumentName, 1, 5)
        Me.RootTableLayoutPanel.Controls.Add(Me.Txtsentto, 1, 2)
        Me.RootTableLayoutPanel.Controls.Add(Me.txtFaxEmail, 1, 4)
        Me.RootTableLayoutPanel.Controls.Add(Me.cmbOrganization, 1, 1)
        Me.RootTableLayoutPanel.Controls.Add(Me.Label1, 0, 2)
        Me.RootTableLayoutPanel.Controls.Add(Me.cmbPerson, 1, 0)
        Me.RootTableLayoutPanel.Controls.Add(Me.cmbFaxNumber, 1, 3)
        Me.RootTableLayoutPanel.Controls.Add(Me.lblOrganization, 0, 1)
        Me.RootTableLayoutPanel.Controls.Add(Me.lblPerson, 0, 0)
        Me.RootTableLayoutPanel.Controls.Add(Me.lblDocumentName, 0, 5)
        Me.RootTableLayoutPanel.Controls.Add(Me.lblFaxNumber, 0, 3)
        Me.RootTableLayoutPanel.Controls.Add(Me.lblFaxEmail, 0, 4)
        Me.RootTableLayoutPanel.Dock = System.Windows.Forms.DockStyle.Top
        Me.RootTableLayoutPanel.Location = New System.Drawing.Point(3, 31)
        Me.RootTableLayoutPanel.Name = "RootTableLayoutPanel"
        Me.RootTableLayoutPanel.RowCount = 6
        Me.RootTableLayoutPanel.RowStyles.Add(New System.Windows.Forms.RowStyle())
        Me.RootTableLayoutPanel.RowStyles.Add(New System.Windows.Forms.RowStyle())
        Me.RootTableLayoutPanel.RowStyles.Add(New System.Windows.Forms.RowStyle())
        Me.RootTableLayoutPanel.RowStyles.Add(New System.Windows.Forms.RowStyle())
        Me.RootTableLayoutPanel.RowStyles.Add(New System.Windows.Forms.RowStyle())
        Me.RootTableLayoutPanel.RowStyles.Add(New System.Windows.Forms.RowStyle())
        Me.RootTableLayoutPanel.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 20.0!))
        Me.RootTableLayoutPanel.Size = New System.Drawing.Size(317, 162)
        Me.RootTableLayoutPanel.TabIndex = 20
        '
        'txtDocumentName
        '
        Me.txtDocumentName.AcceptsReturn = True
        Me.txtDocumentName.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.txtDocumentName.BackColor = System.Drawing.SystemColors.Window
        Me.txtDocumentName.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtDocumentName.Enabled = False
        Me.txtDocumentName.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtDocumentName.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtDocumentName.Location = New System.Drawing.Point(234, 208)
        Me.txtDocumentName.MaxLength = 0
        Me.txtDocumentName.Name = "txtDocumentName"
        Me.txtDocumentName.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtDocumentName.Size = New System.Drawing.Size(204, 35)
        Me.txtDocumentName.TabIndex = 12
        '
        'Txtsentto
        '
        Me.Txtsentto.AcceptsReturn = True
        Me.Txtsentto.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.Txtsentto.BackColor = System.Drawing.SystemColors.Window
        Me.Txtsentto.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.Txtsentto.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Txtsentto.ForeColor = System.Drawing.SystemColors.WindowText
        Me.Txtsentto.Location = New System.Drawing.Point(234, 85)
        Me.Txtsentto.MaxLength = 0
        Me.Txtsentto.Name = "Txtsentto"
        Me.Txtsentto.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Txtsentto.Size = New System.Drawing.Size(204, 35)
        Me.Txtsentto.TabIndex = 6
        '
        'txtFaxEmail
        '
        Me.txtFaxEmail.AcceptsReturn = True
        Me.txtFaxEmail.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.txtFaxEmail.BackColor = System.Drawing.SystemColors.Window
        Me.txtFaxEmail.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtFaxEmail.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtFaxEmail.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtFaxEmail.Location = New System.Drawing.Point(234, 167)
        Me.txtFaxEmail.MaxLength = 0
        Me.txtFaxEmail.Name = "txtFaxEmail"
        Me.txtFaxEmail.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtFaxEmail.Size = New System.Drawing.Size(204, 35)
        Me.txtFaxEmail.TabIndex = 10
        '
        'cmbOrganization
        '
        Me.cmbOrganization.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.cmbOrganization.BackColor = System.Drawing.SystemColors.Window
        Me.cmbOrganization.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmbOrganization.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmbOrganization.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cmbOrganization.Location = New System.Drawing.Point(234, 44)
        Me.cmbOrganization.Name = "cmbOrganization"
        Me.cmbOrganization.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmbOrganization.Size = New System.Drawing.Size(204, 35)
        Me.cmbOrganization.TabIndex = 4
        '
        'Label1
        '
        Me.Label1.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.Label1.AutoSize = True
        Me.Label1.BackColor = System.Drawing.SystemColors.Control
        Me.Label1.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label1.Location = New System.Drawing.Point(83, 85)
        Me.Label1.Margin = New System.Windows.Forms.Padding(3)
        Me.Label1.Name = "Label1"
        Me.Label1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label1.Size = New System.Drawing.Size(145, 35)
        Me.Label1.TabIndex = 5
        Me.Label1.Text = "Attention To:"
        Me.Label1.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        '
        'cmbPerson
        '
        Me.cmbPerson.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.cmbPerson.BackColor = System.Drawing.SystemColors.Window
        Me.cmbPerson.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmbPerson.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmbPerson.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cmbPerson.Location = New System.Drawing.Point(234, 3)
        Me.cmbPerson.Name = "cmbPerson"
        Me.cmbPerson.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmbPerson.Size = New System.Drawing.Size(204, 35)
        Me.cmbPerson.TabIndex = 2
        '
        'cmbFaxNumber
        '
        Me.cmbFaxNumber.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.cmbFaxNumber.BackColor = System.Drawing.SystemColors.Window
        Me.cmbFaxNumber.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmbFaxNumber.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmbFaxNumber.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cmbFaxNumber.Location = New System.Drawing.Point(234, 126)
        Me.cmbFaxNumber.Name = "cmbFaxNumber"
        Me.cmbFaxNumber.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmbFaxNumber.Size = New System.Drawing.Size(204, 35)
        Me.cmbFaxNumber.TabIndex = 8
        '
        'lblOrganization
        '
        Me.lblOrganization.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.lblOrganization.AutoSize = True
        Me.lblOrganization.BackColor = System.Drawing.SystemColors.Control
        Me.lblOrganization.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblOrganization.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblOrganization.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblOrganization.Location = New System.Drawing.Point(84, 44)
        Me.lblOrganization.Margin = New System.Windows.Forms.Padding(3)
        Me.lblOrganization.Name = "lblOrganization"
        Me.lblOrganization.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblOrganization.Size = New System.Drawing.Size(144, 35)
        Me.lblOrganization.TabIndex = 3
        Me.lblOrganization.Text = "Sent to Org:"
        Me.lblOrganization.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        '
        'lblPerson
        '
        Me.lblPerson.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.lblPerson.AutoSize = True
        Me.lblPerson.BackColor = System.Drawing.SystemColors.Control
        Me.lblPerson.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblPerson.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblPerson.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblPerson.Location = New System.Drawing.Point(3, 3)
        Me.lblPerson.Margin = New System.Windows.Forms.Padding(3)
        Me.lblPerson.Name = "lblPerson"
        Me.lblPerson.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblPerson.Size = New System.Drawing.Size(225, 35)
        Me.lblPerson.TabIndex = 1
        Me.lblPerson.Text = "Requesting Person:"
        Me.lblPerson.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        '
        'lblDocumentName
        '
        Me.lblDocumentName.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.lblDocumentName.AutoSize = True
        Me.lblDocumentName.BackColor = System.Drawing.SystemColors.Control
        Me.lblDocumentName.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblDocumentName.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblDocumentName.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblDocumentName.Location = New System.Drawing.Point(97, 208)
        Me.lblDocumentName.Margin = New System.Windows.Forms.Padding(3)
        Me.lblDocumentName.Name = "lblDocumentName"
        Me.lblDocumentName.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblDocumentName.Size = New System.Drawing.Size(131, 35)
        Me.lblDocumentName.TabIndex = 11
        Me.lblDocumentName.Text = "Doc Name:"
        Me.lblDocumentName.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        '
        'lblFaxNumber
        '
        Me.lblFaxNumber.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.lblFaxNumber.AutoSize = True
        Me.lblFaxNumber.BackColor = System.Drawing.SystemColors.Control
        Me.lblFaxNumber.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblFaxNumber.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblFaxNumber.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblFaxNumber.Location = New System.Drawing.Point(150, 126)
        Me.lblFaxNumber.Margin = New System.Windows.Forms.Padding(3)
        Me.lblFaxNumber.Name = "lblFaxNumber"
        Me.lblFaxNumber.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblFaxNumber.Size = New System.Drawing.Size(78, 35)
        Me.lblFaxNumber.TabIndex = 7
        Me.lblFaxNumber.Text = "Fax #:"
        Me.lblFaxNumber.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        '
        'lblFaxEmail
        '
        Me.lblFaxEmail.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.lblFaxEmail.AutoSize = True
        Me.lblFaxEmail.BackColor = System.Drawing.SystemColors.Control
        Me.lblFaxEmail.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblFaxEmail.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblFaxEmail.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblFaxEmail.Location = New System.Drawing.Point(149, 167)
        Me.lblFaxEmail.Margin = New System.Windows.Forms.Padding(3)
        Me.lblFaxEmail.Name = "lblFaxEmail"
        Me.lblFaxEmail.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblFaxEmail.Size = New System.Drawing.Size(79, 35)
        Me.lblFaxEmail.TabIndex = 9
        Me.lblFaxEmail.Text = "Email:"
        Me.lblFaxEmail.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        '
        'FrmDonorIntentFax
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(14.0!, 27.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.ClientSize = New System.Drawing.Size(434, 188)
        Me.ControlBox = False
        Me.Controls.Add(Me.cmdCancel)
        Me.Controls.Add(Me.cmdSend)
        Me.Controls.Add(Me._Frame_19)
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.Location = New System.Drawing.Point(189, 103)
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "FrmDonorIntentFax"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Donor Intent Form"
        Me._Frame_19.ResumeLayout(False)
        Me.RootTableLayoutPanel.ResumeLayout(False)
        Me.RootTableLayoutPanel.PerformLayout()
        CType(Me.Frame, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)

    End Sub
    Public WithEvents Txtsentto As TextBox
    Public WithEvents cmbOrganization As ComboBox
    Public WithEvents Label1 As Label
    Public WithEvents cmbPerson As ComboBox
    Public WithEvents lblOrganization As Label
    Public WithEvents lblPerson As Label
    Friend WithEvents RootTableLayoutPanel As TableLayoutPanel
    Public WithEvents cmbFaxNumber As ComboBox
    Public WithEvents txtFaxEmail As TextBox
    Public WithEvents txtDocumentName As TextBox
    Public WithEvents lblDocumentName As Label
    Public WithEvents lblFaxNumber As Label
    Public WithEvents lblFaxEmail As Label
#End Region
End Class