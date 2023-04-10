<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmReferralList
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
	Public WithEvents LstReferralList As System.Windows.Forms.ListView
	Public WithEvents Frame1 As System.Windows.Forms.GroupBox
	Public WithEvents CmdCancel As System.Windows.Forms.Button
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FrmReferralList))
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.Frame1 = New System.Windows.Forms.GroupBox
        Me.LstReferralList = New System.Windows.Forms.ListView
        Me.CmdCancel = New System.Windows.Forms.Button
        Me.Frame1.SuspendLayout()
        Me.SuspendLayout()
        '
        'Frame1
        '
        Me.Frame1.BackColor = System.Drawing.SystemColors.Control
        Me.Frame1.Controls.Add(Me.LstReferralList)
        Me.Frame1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Frame1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame1.Location = New System.Drawing.Point(2, 2)
        Me.Frame1.Name = "Frame1"
        Me.Frame1.Padding = New System.Windows.Forms.Padding(0)
        Me.Frame1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame1.Size = New System.Drawing.Size(299, 265)
        Me.Frame1.TabIndex = 1
        Me.Frame1.TabStop = False
        '
        'LstReferralList
        '
        Me.LstReferralList.BackColor = System.Drawing.SystemColors.Window
        Me.LstReferralList.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.LstReferralList.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstReferralList.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstReferralList.LabelEdit = True
        Me.LstReferralList.Location = New System.Drawing.Point(10, 14)
        Me.LstReferralList.Name = "LstReferralList"
        Me.LstReferralList.Size = New System.Drawing.Size(279, 243)
        Me.LstReferralList.TabIndex = 2
        Me.LstReferralList.UseCompatibleStateImageBehavior = False
        Me.LstReferralList.View = System.Windows.Forms.View.Details
        '
        'CmdCancel
        '
        Me.CmdCancel.BackColor = System.Drawing.SystemColors.Control
        Me.CmdCancel.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdCancel.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdCancel.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdCancel.Location = New System.Drawing.Point(306, 8)
        Me.CmdCancel.Name = "CmdCancel"
        Me.CmdCancel.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdCancel.Size = New System.Drawing.Size(82, 21)
        Me.CmdCancel.TabIndex = 0
        Me.CmdCancel.Text = "&Close"
        Me.CmdCancel.UseVisualStyleBackColor = False
        '
        'FrmReferralList
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 14.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.ClientSize = New System.Drawing.Size(391, 272)
        Me.Controls.Add(Me.Frame1)
        Me.Controls.Add(Me.CmdCancel)
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Location = New System.Drawing.Point(63, 262)
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "FrmReferralList"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Referral List"
        Me.Frame1.ResumeLayout(False)
        Me.ResumeLayout(False)

    End Sub
#End Region 
End Class