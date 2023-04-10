Public Class FrmDCDPotential
    
	Inherits Form

	Public modalParent As Object 

    Private Sub FrmDCDPotential_Load(sender As Object, e As EventArgs) Handles MyBase.Load

        Dim isDCDPotentialSetToYes As Boolean = modalParent.cboDCDPotential.Text.Equals("Yes")
        rdbDCDPotentialYes.Checked = isDCDPotentialSetToYes
        rdbDCDPotentialNo.Checked = Not isDCDPotentialSetToYes

    End Sub

    Private Sub btnOk_Click(sender As Object, e As EventArgs) Handles btnOk.Click
        
        modalParent.cboDCDPotential.Text = IIf (rdbDCDPotentialYes.Checked, "Yes", "No")
        modalParent.bolDCDPotentialSelected = True
        Me.Close()

    End Sub 

    Private Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click
        Me.Close()
    End Sub

    Private Sub FrmDCDPotential_Shown(sender As Object, e As EventArgs) Handles MyBase.Shown
        BringToFront()
    End Sub
End Class