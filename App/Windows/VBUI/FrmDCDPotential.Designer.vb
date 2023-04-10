<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class FrmDCDPotential
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
        Me.rdbDCDPotentialYes = New Statline.Stattrac.Windows.Forms.RadioButton()
        Me.rdbDCDPotentialNo = New Statline.Stattrac.Windows.Forms.RadioButton()
        Me.lblDCDPotential = New Statline.Stattrac.Windows.Forms.Label()
        Me.btnOk = New Statline.Stattrac.Windows.Forms.Button()
        Me.btnCancel = New Statline.Stattrac.Windows.Forms.Button()
        Me.SuspendLayout
        '
        'rdbDCDPotentialYes
        '
        Me.rdbDCDPotentialYes.AutoSize = true
        Me.rdbDCDPotentialYes.Location = New System.Drawing.Point(120, 25)
        Me.rdbDCDPotentialYes.Name = "rdbDCDPotentialYes"
        Me.rdbDCDPotentialYes.Size = New System.Drawing.Size(43, 17)
        Me.rdbDCDPotentialYes.TabIndex = 0
        Me.rdbDCDPotentialYes.TabStop = true
        Me.rdbDCDPotentialYes.Text = "Yes"
        Me.rdbDCDPotentialYes.UseVisualStyleBackColor = true
        '
        'rdbDCDPotentialNo
        '
        Me.rdbDCDPotentialNo.AutoSize = true
        Me.rdbDCDPotentialNo.Location = New System.Drawing.Point(169, 25)
        Me.rdbDCDPotentialNo.Name = "rdbDCDPotentialNo"
        Me.rdbDCDPotentialNo.Size = New System.Drawing.Size(39, 17)
        Me.rdbDCDPotentialNo.TabIndex = 1
        Me.rdbDCDPotentialNo.TabStop = true
        Me.rdbDCDPotentialNo.Text = "No"
        Me.rdbDCDPotentialNo.UseVisualStyleBackColor = true
        '
        'lblDCDPotential
        '
        Me.lblDCDPotential.AutoSize = true
        Me.lblDCDPotential.Font = New System.Drawing.Font("Tahoma", 8!)
        Me.lblDCDPotential.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None
        Me.lblDCDPotential.Location = New System.Drawing.Point(21, 25)
        Me.lblDCDPotential.Name = "lblDCDPotential"
        Me.lblDCDPotential.Size = New System.Drawing.Size(77, 13)
        Me.lblDCDPotential.TabIndex = 2
        Me.lblDCDPotential.Text = "DCD Potential:"
        '
        'btnOk
        '
        Me.btnOk.Location = New System.Drawing.Point(133, 71)
        Me.btnOk.Name = "btnOk"
        Me.btnOk.Size = New System.Drawing.Size(75, 23)
        Me.btnOk.TabIndex = 3
        Me.btnOk.Text = "OK"
        Me.btnOk.UseVisualStyleBackColor = true
        '
        'btnCancel
        '
        Me.btnCancel.Location = New System.Drawing.Point(214, 71)
        Me.btnCancel.Name = "btnCancel"
        Me.btnCancel.Size = New System.Drawing.Size(75, 23)
        Me.btnCancel.TabIndex = 4
        Me.btnCancel.Text = "Cancel"
        Me.btnCancel.UseVisualStyleBackColor = true
        '
        'FrmDCDPotential
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6!, 13!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(307, 113)
        Me.Controls.Add(Me.btnCancel)
        Me.Controls.Add(Me.btnOk)
        Me.Controls.Add(Me.lblDCDPotential)
        Me.Controls.Add(Me.rdbDCDPotentialNo)
        Me.Controls.Add(Me.rdbDCDPotentialYes)
        Me.MaximizeBox = false
        Me.MaximumSize = New System.Drawing.Size(323, 152)
        Me.MinimizeBox = false
        Me.MinimumSize = New System.Drawing.Size(323, 152)
        Me.Name = "FrmDCDPotential"
        Me.ShowIcon = false
        Me.SizeGripStyle = System.Windows.Forms.SizeGripStyle.Hide
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent
        Me.Text = "DCD Potential"
        Me.ResumeLayout(false)
        Me.PerformLayout

End Sub

    Friend WithEvents rdbDCDPotentialYes As Statline.Stattrac.Windows.Forms.RadioButton
    Friend WithEvents rdbDCDPotentialNo As Statline.Stattrac.Windows.Forms.RadioButton
    Friend WithEvents lblDCDPotential As Statline.Stattrac.Windows.Forms.Label
    Friend WithEvents btnOk As Statline.Stattrac.Windows.Forms.Button
    Friend WithEvents btnCancel As Statline.Stattrac.Windows.Forms.Button
End Class
