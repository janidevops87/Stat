<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class FrmCustomMessageBox
    Inherits System.Windows.Forms.Form

    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.lblPrompt = New Statline.Stattrac.Windows.Forms.Label()
        Me.btnYes = New Statline.Stattrac.Windows.Forms.Button()
        Me.btnNo = New Statline.Stattrac.Windows.Forms.Button()
        Me.Panel1 = New Statline.Stattrac.Windows.Forms.Panel()
        Me.Panel2 = New Statline.Stattrac.Windows.Forms.Panel()
        Me.Panel1.SuspendLayout()
        Me.Panel2.SuspendLayout()
        Me.SuspendLayout()
        '
        'lblPrompt
        '
        Me.lblPrompt.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.lblPrompt.Font = New System.Drawing.Font("Tahoma", 8.0!)
        Me.lblPrompt.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None
        Me.lblPrompt.Location = New System.Drawing.Point(8, 13)
        Me.lblPrompt.Name = "lblPrompt"
        Me.lblPrompt.Size = New System.Drawing.Size(404, 45)
        Me.lblPrompt.TabIndex = 0
        Me.lblPrompt.Text = "Custom prompt"
        Me.lblPrompt.TextAlign = System.Drawing.ContentAlignment.TopCenter
        '
        'btnYes
        '
        Me.btnYes.Location = New System.Drawing.Point(181, 0)
        Me.btnYes.Name = "btnYes"
        Me.btnYes.Size = New System.Drawing.Size(100, 23)
        Me.btnYes.TabIndex = 1
        Me.btnYes.Text = "Custom Yes"
        Me.btnYes.UseVisualStyleBackColor = True
        '
        'btnNo
        '
        Me.btnNo.Location = New System.Drawing.Point(298, 0)
        Me.btnNo.Name = "btnNo"
        Me.btnNo.Size = New System.Drawing.Size(100, 23)
        Me.btnNo.TabIndex = 2
        Me.btnNo.Text = "Custom No"
        Me.btnNo.UseVisualStyleBackColor = True
        '
        'Panel1
        '
        Me.Panel1.Controls.Add(Me.btnNo)
        Me.Panel1.Controls.Add(Me.btnYes)
        Me.Panel1.Location = New System.Drawing.Point(4, 73)
        Me.Panel1.Name = "Panel1"
        Me.Panel1.Size = New System.Drawing.Size(422, 38)
        Me.Panel1.TabIndex = 3
        '
        'Panel2
        '
        Me.Panel2.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.Panel2.BackColor = System.Drawing.Color.White
        Me.Panel2.Controls.Add(Me.lblPrompt)
        Me.Panel2.Location = New System.Drawing.Point(1, 0)
        Me.Panel2.Name = "Panel2"
        Me.Panel2.Size = New System.Drawing.Size(425, 67)
        Me.Panel2.TabIndex = 4
        '
        'FrmCustomMessageBox
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.ClientSize = New System.Drawing.Size(425, 105)
        Me.ControlBox = False
        Me.Controls.Add(Me.Panel2)
        Me.Controls.Add(Me.Panel1)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.Name = "FrmCustomMessageBox"
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent
        Me.Text = "Warning"
        Me.Panel1.ResumeLayout(False)
        Me.Panel2.ResumeLayout(False)
        Me.ResumeLayout(False)

    End Sub

    Friend WithEvents lblPrompt As Statline.Stattrac.Windows.Forms.Label
    Friend WithEvents btnYes As Statline.Stattrac.Windows.Forms.Button
    Friend WithEvents btnNo As Statline.Stattrac.Windows.Forms.Button
    Friend WithEvents Panel1 As Statline.Stattrac.Windows.Forms.Panel
    Friend WithEvents Panel2 As Statline.Stattrac.Windows.Forms.Panel
End Class
