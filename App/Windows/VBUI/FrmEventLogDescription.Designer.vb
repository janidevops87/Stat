<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmEventLogDescription
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
	Public WithEvents chkViewLogEventDeleted As System.Windows.Forms.CheckBox
	Public WithEvents LstViewLogEventdesc As System.Windows.Forms.ListView
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FrmEventLogDescription))
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.chkViewLogEventDeleted = New System.Windows.Forms.CheckBox
        Me.LstViewLogEventdesc = New System.Windows.Forms.ListView
        Me.pnlDisplayAllEvents = New Statline.Stattrac.Windows.Forms.Panel
        Me.pnlDisplayAllEvents.SuspendLayout()
        Me.SuspendLayout()
        '
        'chkViewLogEventDeleted
        '
        Me.chkViewLogEventDeleted.BackColor = System.Drawing.SystemColors.Control
        Me.chkViewLogEventDeleted.Cursor = System.Windows.Forms.Cursors.Default
        Me.chkViewLogEventDeleted.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.chkViewLogEventDeleted.ForeColor = System.Drawing.SystemColors.ControlText
        Me.chkViewLogEventDeleted.Location = New System.Drawing.Point(377, 9)
        Me.chkViewLogEventDeleted.Name = "chkViewLogEventDeleted"
        Me.chkViewLogEventDeleted.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.chkViewLogEventDeleted.Size = New System.Drawing.Size(129, 18)
        Me.chkViewLogEventDeleted.TabIndex = 1
        Me.chkViewLogEventDeleted.Text = "Display All Events"
        Me.chkViewLogEventDeleted.UseVisualStyleBackColor = False
        '
        'LstViewLogEventdesc
        '
        Me.LstViewLogEventdesc.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewLogEventdesc.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.LstViewLogEventdesc.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewLogEventdesc.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewLogEventdesc.FullRowSelect = True
        Me.LstViewLogEventdesc.HideSelection = False
        Me.LstViewLogEventdesc.LabelWrap = False
        Me.LstViewLogEventdesc.Location = New System.Drawing.Point(8, 8)
        Me.LstViewLogEventdesc.Name = "LstViewLogEventdesc"
        Me.LstViewLogEventdesc.Size = New System.Drawing.Size(985, 355)
        Me.LstViewLogEventdesc.TabIndex = 0
        Me.LstViewLogEventdesc.TabStop = False
        Me.LstViewLogEventdesc.UseCompatibleStateImageBehavior = False
        Me.LstViewLogEventdesc.View = System.Windows.Forms.View.Details
        '
        'pnlDisplayAllEvents
        '
        Me.pnlDisplayAllEvents.Controls.Add(Me.chkViewLogEventDeleted)
        Me.pnlDisplayAllEvents.Dock = System.Windows.Forms.DockStyle.Bottom
        Me.pnlDisplayAllEvents.Location = New System.Drawing.Point(0, 369)
        Me.pnlDisplayAllEvents.Name = "pnlDisplayAllEvents"
        Me.pnlDisplayAllEvents.Size = New System.Drawing.Size(1008, 30)
        Me.pnlDisplayAllEvents.TabIndex = 2
        '
        'FrmEventLogDescription
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 14.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.ClientSize = New System.Drawing.Size(1008, 399)
        Me.Controls.Add(Me.pnlDisplayAllEvents)
        Me.Controls.Add(Me.LstViewLogEventdesc)
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Location = New System.Drawing.Point(4, 23)
        Me.MinimizeBox = False
        Me.Name = "FrmEventLogDescription"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Text = "EventLogDescription"
        Me.pnlDisplayAllEvents.ResumeLayout(False)
        Me.ResumeLayout(False)

    End Sub
    Friend WithEvents pnlDisplayAllEvents As Statline.Stattrac.Windows.Forms.Panel
#End Region 
End Class