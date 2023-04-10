Option Strict Off
Option Explicit On
Imports Statline.Stattrac.Framework

Public Class clsRTF
    'Bret 1/06/10 add Option explicit for upgrade

    Function UpdateTextInfo(ByRef pvControl As ToolStrip, ByRef pvTextbox As RichTextBox, ByRef pvCombofont As ComboBox, ByRef pvCombosize As ComboBox) As Object       '************************************************************************************
        'Date Changed: 4/28/06                          Changed by: Char Chaput
        'Release #: 8.0                               Task: Unknown
        'Description:  Added for RTF - toolbar functionality
        '====================================================================================
        '************************************************************************************

        On Error Resume Next
        Static fLast As String 'font
        Static sLast As String 'font size


        If pvTextbox.SelectionFont.Bold Then

            DirectCast(pvControl.Items("bold"), ToolStripButton).Checked = True

        Else
            DirectCast(pvControl.Items("bold"), ToolStripButton).Checked = False
        End If

        ' update italic button
        If pvTextbox.SelectionFont.Italic Then
            DirectCast(pvControl.Items("italic"), ToolStripButton).Checked = True
        Else
            DirectCast(pvControl.Items("italic"), ToolStripButton).Checked = False
        End If

        ' update underline button
        If pvTextbox.SelectionFont.Underline Then
            DirectCast(pvControl.Items("underline"), ToolStripButton).Checked = True
        Else
            DirectCast(pvControl.Items("underline"), ToolStripButton).Checked = False
        End If

        ' update alignment buttons
        Select Case pvTextbox.SelectionAlignment
            ' MOVING following to Case Else branch
            'Case System.DBNull
            '    DirectCast(pvControl.Items("left"), ToolStripButton).Checked = False
            '    DirectCast(pvControl.Items("center"), ToolStripButton).Checked = False
            '    DirectCast(pvControl.Items("right"), ToolStripButton).Checked = False
            Case System.Windows.Forms.HorizontalAlignment.Left
                DirectCast(pvControl.Items("left"), ToolStripButton).Checked = True
                DirectCast(pvControl.Items("center"), ToolStripButton).Checked = False
                DirectCast(pvControl.Items("right"), ToolStripButton).Checked = False
            Case System.Windows.Forms.HorizontalAlignment.Center
                DirectCast(pvControl.Items("left"), ToolStripButton).Checked = False
                DirectCast(pvControl.Items("center"), ToolStripButton).Checked = True
                DirectCast(pvControl.Items("right"), ToolStripButton).Checked = False
            Case System.Windows.Forms.HorizontalAlignment.Right
                DirectCast(pvControl.Items("left"), ToolStripButton).Checked = False
                DirectCast(pvControl.Items("center"), ToolStripButton).Checked = False
                DirectCast(pvControl.Items("right"), ToolStripButton).Checked = True
            Case Else
                DirectCast(pvControl.Items("left"), ToolStripButton).Checked = False
                DirectCast(pvControl.Items("center"), ToolStripButton).Checked = False
                DirectCast(pvControl.Items("right"), ToolStripButton).Checked = False
        End Select

        Dim blnFound As Boolean 'found flag
        Dim intI As Short ' counter
        If fLast <> pvTextbox.SelectionFont.Name Then
            ' find current font, and display name
            For intI = 0 To pvCombofont.Items.Count - 1
                If pvCombofont.Items(intI) = pvTextbox.SelectionFont.Name Then
                    pvCombofont.SelectedIndex = intI
                    intI = pvCombofont.Items.Count
                    blnFound = True
                End If
            Next intI
            If blnFound = True Then
                fLast = pvTextbox.SelectionFont.Name
            Else
                ' if font name not found, show nothing
                fLast = ""
                pvCombofont.SelectedIndex = -1
            End If
        End If


        pvCombosize.Text = pvTextbox.SelectionFont.Size

    End Function
    Function ToolbarButtonClick(ByVal Button As Object, ByRef pvToolbar As Object, ByRef pvTextbox As System.Windows.Forms.RichTextBox, ByRef pvCombofont As System.Windows.Forms.Control, ByRef pvCombosize As System.Windows.Forms.Control, ByRef pvDialog As System.Windows.Forms.ColorDialog) As Object
        '************************************************************************************
        'Date Changed: 4/28/06                          Changed by: Char Chaput
        'Release #: 8.0                               Task: Unknown
        'Description:  Added for RTF - captures the button from the toolbar
        '====================================================================================
        '************************************************************************************
        'ccarroll 01/20/2010 changed Toolbar Button to Object was System.Windows.Forms.ToolStripButton

        Try
            Dim currentFont As Font = pvTextbox.SelectionFont
            Dim newFontStyle As FontStyle

            Select Case Button.Name
                Case Is = "bold"
                    pvTextbox.SelectionFont = New Font(currentFont, pvTextbox.SelectionFont.Style Xor FontStyle.Bold)
                Case Is = "italic"
                    pvTextbox.SelectionFont = New Font(currentFont, pvTextbox.SelectionFont.Style Xor FontStyle.Italic)
                Case Is = "underline"
                    pvTextbox.SelectionFont = New Font(currentFont, pvTextbox.SelectionFont.Style Xor FontStyle.Underline)
                Case Is = "color"
                    pvDialog.Color = pvTextbox.SelectionColor
                    If (pvDialog.ShowDialog) = DialogResult.OK Then
                        pvTextbox.SelectionColor = pvDialog.Color
                    End If
                Case Is = "left"
                    pvTextbox.SelectionAlignment = HorizontalAlignment.Left
                Case Is = "center"
                    pvTextbox.SelectionAlignment = System.Windows.Forms.HorizontalAlignment.Center
                Case Is = "right"
                    pvTextbox.SelectionAlignment = System.Windows.Forms.HorizontalAlignment.Right
                Case Is = "bullet"
                    With pvTextbox
                        If (IsDBNull(.SelectionBullet) = True) Or (.SelectionBullet = False) Then
                            ' selection is mixed or not bulleted
                            ' so set it.
                            .SelectionBullet = True
                        ElseIf .SelectionBullet = True Then
                            ' selection is bold, toggle it
                            .SelectionBullet = False
                            .SelectionIndent = False
                        End If
                    End With
                Case Is = "cut"
                    System.Windows.Forms.SendKeys.Send("+{DEL}")
                Case Is = "copy"
                    pvTextbox.SelectedRtf = My.Computer.Clipboard.GetText(TextDataFormat.Rtf)
                Case Is = "paste"
                    System.Windows.Forms.SendKeys.Send("+{INSERT}")
            End Select

            Call Me.UpdateTextInfo(pvToolbar, pvTextbox, pvCombofont, pvCombosize)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try
    End Function
End Class