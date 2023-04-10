<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmRotationCreate
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
    Public WithEvents CmdOK As System.Windows.Forms.Button
    Public WithEvents CmdCancel As System.Windows.Forms.Button
    Public WithEvents TxtRotationName As System.Windows.Forms.TextBox
    Public WithEvents _Lable_0 As System.Windows.Forms.Label
    Public WithEvents FraOrgInfo As System.Windows.Forms.GroupBox
    Public WithEvents Lable As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Dim resources As System.Resources.ResourceManager = New System.Resources.ResourceManager(GetType(frmRotationCreate))
        Me.components = New System.ComponentModel.Container()
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(components)
        Me.CmdOK = New System.Windows.Forms.Button
        Me.CmdCancel = New System.Windows.Forms.Button
        Me.FraOrgInfo = New System.Windows.Forms.GroupBox
        Me.TxtRotationName = New System.Windows.Forms.TextBox
        Me._Lable_0 = New System.Windows.Forms.Label
        Me.Lable = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(components)
        Me.FraOrgInfo.SuspendLayout()
        Me.SuspendLayout()
        Me.ToolTip1.Active = True
        CType(Me.Lable, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.Text = "Rotation Group"
        Me.ClientSize = New System.Drawing.Size(387, 62)
        Me.Location = New System.Drawing.Point(4, 23)
        Me.Icon = CType(resources.GetObject("frmRotationCreate.Icon"), System.Drawing.Icon)
        Me.StartPosition = System.Windows.Forms.FormStartPosition.WindowsDefaultLocation
        Me.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.Sizable
        Me.ControlBox = True
        Me.Enabled = True
        Me.KeyPreview = False
        Me.MaximizeBox = True
        Me.MinimizeBox = True
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ShowInTaskbar = True
        Me.HelpButton = False
        Me.WindowState = System.Windows.Forms.FormWindowState.Normal
        Me.Name = "frmRotationCreate"
        Me.CmdOK.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        Me.CmdOK.Text = "&Save"
        Me.CmdOK.Size = New System.Drawing.Size(80, 21)
        Me.CmdOK.Location = New System.Drawing.Point(296, 5)
        Me.CmdOK.TabIndex = 3
        Me.CmdOK.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdOK.BackColor = System.Drawing.SystemColors.Control
        Me.CmdOK.CausesValidation = True
        Me.CmdOK.Enabled = True
        Me.CmdOK.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdOK.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdOK.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdOK.TabStop = True
        Me.CmdOK.Name = "CmdOK"
        Me.CmdCancel.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        Me.CmdCancel.Text = "C&ancel"
        Me.CmdCancel.Size = New System.Drawing.Size(80, 21)
        Me.CmdCancel.Location = New System.Drawing.Point(296, 31)
        Me.CmdCancel.TabIndex = 2
        Me.CmdCancel.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdCancel.BackColor = System.Drawing.SystemColors.Control
        Me.CmdCancel.CausesValidation = True
        Me.CmdCancel.Enabled = True
        Me.CmdCancel.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdCancel.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdCancel.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdCancel.TabStop = True
        Me.CmdCancel.Name = "CmdCancel"
        Me.FraOrgInfo.Size = New System.Drawing.Size(291, 54)
        Me.FraOrgInfo.Location = New System.Drawing.Point(0, 0)
        Me.FraOrgInfo.TabIndex = 0
        Me.FraOrgInfo.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FraOrgInfo.BackColor = System.Drawing.SystemColors.Control
        Me.FraOrgInfo.Enabled = True
        Me.FraOrgInfo.ForeColor = System.Drawing.SystemColors.ControlText
        Me.FraOrgInfo.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.FraOrgInfo.Visible = True
        Me.FraOrgInfo.Padding = New System.Windows.Forms.Padding(0)
        Me.FraOrgInfo.Name = "FraOrgInfo"
        Me.TxtRotationName.AutoSize = False
        Me.TxtRotationName.Size = New System.Drawing.Size(225, 25)
        Me.TxtRotationName.Location = New System.Drawing.Point(48, 16)
        Me.TxtRotationName.TabIndex = 4
        Me.TxtRotationName.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtRotationName.AcceptsReturn = True
        Me.TxtRotationName.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
        Me.TxtRotationName.BackColor = System.Drawing.SystemColors.Window
        Me.TxtRotationName.CausesValidation = True
        Me.TxtRotationName.Enabled = True
        Me.TxtRotationName.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtRotationName.HideSelection = True
        Me.TxtRotationName.ReadOnly = False
        Me.TxtRotationName.MaxLength = 0
        Me.TxtRotationName.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtRotationName.Multiline = False
        Me.TxtRotationName.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtRotationName.ScrollBars = System.Windows.Forms.ScrollBars.None
        Me.TxtRotationName.TabStop = True
        Me.TxtRotationName.Visible = True
        Me.TxtRotationName.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.TxtRotationName.Name = "TxtRotationName"
        Me._Lable_0.Text = "Name"
        Me._Lable_0.Size = New System.Drawing.Size(93, 15)
        Me._Lable_0.Location = New System.Drawing.Point(16, 24)
        Me._Lable_0.TabIndex = 1
        Me._Lable_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_0.TextAlign = System.Drawing.ContentAlignment.TopLeft
        Me._Lable_0.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_0.Enabled = True
        Me._Lable_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Lable_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_0.UseMnemonic = True
        Me._Lable_0.Visible = True
        Me._Lable_0.AutoSize = False
        Me._Lable_0.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me._Lable_0.Name = "_Lable_0"
        Me.Controls.Add(CmdOK)
        Me.Controls.Add(CmdCancel)
        Me.Controls.Add(FraOrgInfo)
        Me.FraOrgInfo.Controls.Add(TxtRotationName)
        Me.FraOrgInfo.Controls.Add(_Lable_0)
        Me.Lable.SetIndex(_Lable_0, CType(0, Short))
        CType(Me.Lable, System.ComponentModel.ISupportInitialize).EndInit()
        Me.FraOrgInfo.ResumeLayout(False)
        Me.ResumeLayout(False)
        Me.PerformLayout()
    End Sub
#End Region
End Class