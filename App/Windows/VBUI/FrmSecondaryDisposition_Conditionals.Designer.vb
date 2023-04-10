<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmSecondaryDisposition_Conditionals
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
    Public WithEvents cmdOK As System.Windows.Forms.Button
    Public WithEvents Picture1 As System.Windows.Forms.Panel
    Public WithEvents chkCriteriaAll As System.Windows.Forms.CheckBox
    Public WithEvents lvConditionals As System.Windows.Forms.ListView
    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.Picture1 = New System.Windows.Forms.Panel
        Me.cmdOK = New System.Windows.Forms.Button
        Me.chkCriteriaAll = New System.Windows.Forms.CheckBox
        Me.lvConditionals = New System.Windows.Forms.ListView
        Me.Picture1.SuspendLayout()
        Me.SuspendLayout()
        '
        'Picture1
        '
        Me.Picture1.BackColor = System.Drawing.SystemColors.ScrollBar
        Me.Picture1.Controls.Add(Me.cmdOK)
        Me.Picture1.Cursor = System.Windows.Forms.Cursors.Default
        Me.Picture1.Dock = System.Windows.Forms.DockStyle.Bottom
        Me.Picture1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Picture1.ForeColor = System.Drawing.SystemColors.WindowText
        Me.Picture1.Location = New System.Drawing.Point(0, 265)
        Me.Picture1.Name = "Picture1"
        Me.Picture1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Picture1.Size = New System.Drawing.Size(739, 41)
        Me.Picture1.TabIndex = 2
        Me.Picture1.TabStop = True
        '
        'cmdOK
        '
        Me.cmdOK.BackColor = System.Drawing.SystemColors.Control
        Me.cmdOK.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdOK.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdOK.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdOK.Location = New System.Drawing.Point(8, 8)
        Me.cmdOK.Name = "cmdOK"
        Me.cmdOK.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdOK.Size = New System.Drawing.Size(121, 25)
        Me.cmdOK.TabIndex = 3
        Me.cmdOK.Text = "&Close"
        Me.cmdOK.UseVisualStyleBackColor = False
        '
        'chkCriteriaAll
        '
        Me.chkCriteriaAll.BackColor = System.Drawing.SystemColors.Control
        Me.chkCriteriaAll.CheckAlign = System.Drawing.ContentAlignment.MiddleRight
        Me.chkCriteriaAll.Cursor = System.Windows.Forms.Cursors.Default
        Me.chkCriteriaAll.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.chkCriteriaAll.ForeColor = System.Drawing.SystemColors.ControlText
        Me.chkCriteriaAll.Location = New System.Drawing.Point(600, 0)
        Me.chkCriteriaAll.Name = "chkCriteriaAll"
        Me.chkCriteriaAll.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.chkCriteriaAll.Size = New System.Drawing.Size(129, 17)
        Me.chkCriteriaAll.TabIndex = 1
        Me.chkCriteriaAll.Text = "Show All Indications"
        Me.chkCriteriaAll.UseVisualStyleBackColor = False
        '
        'lvConditionals
        '
        Me.lvConditionals.BackColor = System.Drawing.SystemColors.Window
        Me.lvConditionals.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.lvConditionals.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lvConditionals.ForeColor = System.Drawing.SystemColors.WindowText
        Me.lvConditionals.FullRowSelect = True
        Me.lvConditionals.HideSelection = False
        Me.lvConditionals.LabelWrap = False
        Me.lvConditionals.Location = New System.Drawing.Point(8, 16)
        Me.lvConditionals.Name = "lvConditionals"
        Me.lvConditionals.Size = New System.Drawing.Size(721, 243)
        Me.lvConditionals.TabIndex = 0
        Me.lvConditionals.UseCompatibleStateImageBehavior = False
        Me.lvConditionals.View = System.Windows.Forms.View.Details
        '
        'frmSecondaryDisposition_Conditionals
        '
        Me.AcceptButton = Me.cmdOK
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 14.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.ClientSize = New System.Drawing.Size(739, 306)
        Me.Controls.Add(Me.Picture1)
        Me.Controls.Add(Me.chkCriteriaAll)
        Me.Controls.Add(Me.lvConditionals)
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Location = New System.Drawing.Point(4, 23)
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "frmSecondaryDisposition_Conditionals"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Picture1.ResumeLayout(False)
        Me.ResumeLayout(False)

    End Sub
#End Region
End Class