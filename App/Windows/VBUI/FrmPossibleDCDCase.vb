Imports Statline.Stattrac.Windows.UI

Public Class FrmPossibleDCDCase

    Inherits Form

    Public modalParent As Object

    Private Sub btnOkayPossibleDcdCase_Click(sender As Object, e As EventArgs) Handles btnOkayPossibleDcdCase.Click
        If chkNoOrganDonationPotential.Checked Then
            modalParent.cboDCDPotential.Text = "No"
            modalParent.bolDCDPotentialSelected = True
        End If
        Me.Close()
    End Sub

    Private Sub chkNoOrganDonationPotential_CheckedChanged(sender As Object, e As EventArgs) Handles chkNoOrganDonationPotential.CheckedChanged
        If sender.Checked Then
            Dim response = BaseMessageBox.ShowWarning("This will rule out DCD potential from this point forward." & vbNewLine & vbNewLine & "Only do this if you are absolutely sure that organs are not candidates for transplant.", "WARNING!", MessageBoxDefaultButton.Button2)
            If response = vbCancel Then
                chkNoOrganDonationPotential.Checked = Not (chkNoOrganDonationPotential.Checked)
            End If
        End If
    End Sub
End Class