Public Class FrmCustomMessageBox

    Private PromptMsg As String
    Private ButtonYesText As String
    Private ButtonNoText As String

    Sub New(promptMsg As String, buttonYesText As String, buttonNoText As String)

        InitializeComponent()
        Me.PromptMsg = promptMsg
        Me.ButtonYesText = buttonYesText
        Me.ButtonNoText = buttonNoText

    End Sub

    Private Sub FrmCustomMessageBox_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        'populate the text on the label & buttons
        Me.lblPrompt.Text = Me.PromptMsg
        Me.btnYes.Text = Me.ButtonYesText
        Me.btnNo.Text = Me.ButtonNoText
    End Sub

    Private Sub btnYes_Click(sender As Object, e As EventArgs) Handles btnYes.Click
        Me.DialogResult = DialogResult.Yes
        Me.Close()
    End Sub

    Private Sub btnNo_Click(sender As Object, e As EventArgs) Handles btnNo.Click
        Me.DialogResult = DialogResult.No
        Me.Close()
    End Sub

End Class