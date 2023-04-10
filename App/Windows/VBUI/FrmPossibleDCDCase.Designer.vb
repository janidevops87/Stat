<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class FrmPossibleDCDCase
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
        Me.Label1 = New Statline.Stattrac.Windows.Forms.Label()
        Me.btnOkayPossibleDcdCase = New Statline.Stattrac.Windows.Forms.Button()
        Me.chkNoOrganDonationPotential = New Statline.Stattrac.Windows.Forms.CheckBox()
        Me.SuspendLayout
        '
        'Label1
        '
        Me.Label1.Font = New System.Drawing.Font("Tahoma", 8!)
        Me.Label1.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None
        Me.Label1.Location = New System.Drawing.Point(12, 18)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(350, 39)
        Me.Label1.TabIndex = 0
        Me.Label1.Text = "This is a possible donation after cardiac death (DCD) case and may have organ don"& _ 
    "ation potential."
        '
        'btnOkayPossibleDcdCase
        '
        Me.btnOkayPossibleDcdCase.Location = New System.Drawing.Point(287, 69)
        Me.btnOkayPossibleDcdCase.Name = "btnOkayPossibleDcdCase"
        Me.btnOkayPossibleDcdCase.Size = New System.Drawing.Size(75, 23)
        Me.btnOkayPossibleDcdCase.TabIndex = 1
        Me.btnOkayPossibleDcdCase.Text = "OK"
        Me.btnOkayPossibleDcdCase.UseVisualStyleBackColor = true
        '
        'chkNoOrganDonationPotential
        '
        Me.chkNoOrganDonationPotential.AutoSize = true
        Me.chkNoOrganDonationPotential.Checked = false
        Me.chkNoOrganDonationPotential.Font = New System.Drawing.Font("Tahoma", 8!)
        Me.chkNoOrganDonationPotential.Location = New System.Drawing.Point(15, 73)
        Me.chkNoOrganDonationPotential.Name = "chkNoOrganDonationPotential"
        Me.chkNoOrganDonationPotential.Size = New System.Drawing.Size(230, 17)
        Me.chkNoOrganDonationPotential.TabIndex = 2
        Me.chkNoOrganDonationPotential.Text = "This case has no organ donation potential."
        Me.chkNoOrganDonationPotential.UseVisualStyleBackColor = true
        '
        'FrmPossibleDCDCase
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6!, 13!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(385, 110)
        Me.Controls.Add(Me.chkNoOrganDonationPotential)
        Me.Controls.Add(Me.btnOkayPossibleDcdCase)
        Me.Controls.Add(Me.Label1)
        Me.MaximizeBox = false
        Me.MaximumSize = New System.Drawing.Size(401, 149)
        Me.MinimizeBox = false
        Me.MinimumSize = New System.Drawing.Size(401, 149)
        Me.Name = "FrmPossibleDCDCase"
        Me.ShowIcon = false
        Me.SizeGripStyle = System.Windows.Forms.SizeGripStyle.Hide
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent
        Me.Text = "Possible DCD Case"
        Me.ResumeLayout(false)
        Me.PerformLayout

End Sub

    Friend WithEvents Label1 As Statline.Stattrac.Windows.Forms.Label
    Friend WithEvents btnOkayPossibleDcdCase As Statline.Stattrac.Windows.Forms.Button
    Friend WithEvents chkNoOrganDonationPotential As Statline.Stattrac.Windows.Forms.CheckBox
End Class
