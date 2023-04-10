Option Strict Off
Option Explicit On
Friend Class FrmCriteriaTemplate
	Inherits System.Windows.Forms.Form
	'Bret 1/06/10 add Option explicit for upgrade
	
	Public vProcessorId As Short
	Public vCriteriaTemplateId As Short
	Public FormState As Integer
	Public vCaption As String

    Private Sub ChkNotAppropriateFemale_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkNotAppropriateFemale.CheckStateChanged

        On Error Resume Next

        Dim I As Short

        'Both not appropriate
        If ChkNotAppropriateMale.CheckState = 1 And ChkNotAppropriateFemale.CheckState = 1 Then

            For I = 2 To 4
                Frame(I).Enabled = False
            Next I
            For I = 6 To 21
                Lable(I).Enabled = False
            Next I
            cmdAddIndication.Enabled = False
            cmdRemoveIndication.Enabled = False
            TxtMaleUpper.Enabled = False
            TxtMaleLower.Enabled = False
            TxtFemaleUpper.Enabled = False
            TxtFemaleLower.Enabled = False
            LstViewConditionals.Enabled = False
            ChkReferNonPotential.Enabled = False
            TxtLowerWeight.Enabled = False
            TxtUpperWeight.Enabled = False
            TxtFemaleLowerWeight.Enabled = False
            TxtFemaleUpperWeight.Enabled = False
            TxtGeneralRuleout.Enabled = False

            'Both appropriate
        ElseIf ChkNotAppropriateMale.CheckState = 0 And ChkNotAppropriateFemale.CheckState = 0 Then

            For I = 2 To 4
                Frame(I).Enabled = True
            Next I
            For I = 6 To 21
                Lable(I).Enabled = True
            Next I
            cmdAddIndication.Enabled = True
            cmdRemoveIndication.Enabled = True
            TxtMaleUpper.Enabled = True
            TxtMaleLower.Enabled = True
            TxtFemaleUpper.Enabled = True
            TxtFemaleLower.Enabled = True
            LstViewConditionals.Enabled = True
            ChkReferNonPotential.Enabled = True
            TxtLowerWeight.Enabled = True
            TxtUpperWeight.Enabled = True
            TxtFemaleLowerWeight.Enabled = True
            TxtFemaleUpperWeight.Enabled = True
            TxtGeneralRuleout.Enabled = True

            'Male not appropriate, female appropriate
        ElseIf ChkNotAppropriateMale.CheckState = 1 And ChkNotAppropriateFemale.CheckState = 0 Then

            For I = 2 To 4
                Frame(I).Enabled = True
            Next I
            Lable(7).Enabled = True

            'Male
            For I = 10 To 12
                Lable(I).Enabled = False
            Next I
            Lable(6).Enabled = False
            Lable(17).Enabled = False
            Lable(18).Enabled = False

            'Female
            For I = 13 To 15
                Lable(I).Enabled = True
            Next I
            For I = 19 To 21
                Lable(I).Enabled = True
            Next I

            cmdAddIndication.Enabled = True
            cmdRemoveIndication.Enabled = True
            TxtMaleUpper.Enabled = False
            TxtMaleLower.Enabled = False
            TxtFemaleUpper.Enabled = True
            TxtFemaleLower.Enabled = True
            LstViewConditionals.Enabled = True
            ChkReferNonPotential.Enabled = True
            TxtLowerWeight.Enabled = False
            TxtUpperWeight.Enabled = False
            TxtFemaleLowerWeight.Enabled = True
            TxtFemaleUpperWeight.Enabled = True
            TxtGeneralRuleout.Enabled = True

            'Male appropriate, female not appropriate
        ElseIf ChkNotAppropriateMale.CheckState = 0 And ChkNotAppropriateFemale.CheckState = 1 Then

            For I = 2 To 4
                Frame(I).Enabled = True
            Next I
            Lable(7).Enabled = True
            'Male
            For I = 10 To 12
                Lable(I).Enabled = True
            Next I
            Lable(6).Enabled = True
            Lable(17).Enabled = True
            Lable(18).Enabled = True

            'Female
            For I = 13 To 15
                Lable(I).Enabled = False
            Next I
            For I = 19 To 21
                Lable(I).Enabled = False
            Next I

            cmdAddIndication.Enabled = True
            cmdRemoveIndication.Enabled = True
            TxtMaleUpper.Enabled = True
            TxtMaleLower.Enabled = True
            TxtFemaleUpper.Enabled = False
            TxtFemaleLower.Enabled = False
            LstViewConditionals.Enabled = True
            ChkReferNonPotential.Enabled = True
            TxtLowerWeight.Enabled = True
            TxtUpperWeight.Enabled = True
            TxtFemaleLowerWeight.Enabled = False
            TxtFemaleUpperWeight.Enabled = False
            TxtGeneralRuleout.Enabled = True

        End If

    End Sub

    Private Sub ChkNotAppropriateMale_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkNotAppropriateMale.CheckStateChanged

        On Error Resume Next

        Dim I As Short

        'Both not appropriate
        If ChkNotAppropriateMale.CheckState = 1 And ChkNotAppropriateFemale.CheckState = 1 Then

            For I = 2 To 4
                Frame(I).Enabled = False
            Next I
            For I = 6 To 21
                Lable(I).Enabled = False
            Next I
            cmdAddIndication.Enabled = False
            cmdRemoveIndication.Enabled = False
            TxtMaleUpper.Enabled = False
            TxtMaleLower.Enabled = False
            TxtFemaleUpper.Enabled = False
            TxtFemaleLower.Enabled = False
            LstViewConditionals.Enabled = False
            ChkReferNonPotential.Enabled = False
            TxtLowerWeight.Enabled = False
            TxtUpperWeight.Enabled = False
            TxtFemaleLowerWeight.Enabled = False
            TxtFemaleUpperWeight.Enabled = False
            TxtGeneralRuleout.Enabled = False

            'Both appropriate
        ElseIf ChkNotAppropriateMale.CheckState = 0 And ChkNotAppropriateFemale.CheckState = 0 Then

            For I = 2 To 4
                Frame(I).Enabled = True
            Next I
            For I = 6 To 21
                Lable(I).Enabled = True
            Next I
            'bret 01/06/10 removed no reference        CmdIndicationAdd.Enabled = True
            'bret 01/06/10 removed no reference        CmdIndicationRemove.Enabled = True
            TxtMaleUpper.Enabled = True
            TxtMaleLower.Enabled = True
            TxtFemaleUpper.Enabled = True
            TxtFemaleLower.Enabled = True
            'bret 01/06/10 removed no reference        LstViewIndication.Enabled = True
            ChkReferNonPotential.Enabled = True
            TxtLowerWeight.Enabled = True
            TxtUpperWeight.Enabled = True
            TxtFemaleLowerWeight.Enabled = True
            TxtFemaleUpperWeight.Enabled = True
            TxtGeneralRuleout.Enabled = True

            'Male not appropriate, female appropriate
        ElseIf ChkNotAppropriateMale.CheckState = 1 And ChkNotAppropriateFemale.CheckState = 0 Then

            For I = 2 To 4
                Frame(I).Enabled = True
            Next I
            Lable(7).Enabled = True

            'Male
            For I = 10 To 12
                Lable(I).Enabled = False
            Next I
            Lable(6).Enabled = False
            Lable(17).Enabled = False
            Lable(18).Enabled = False

            'Female
            For I = 13 To 15
                Lable(I).Enabled = True
            Next I
            For I = 19 To 21
                Lable(I).Enabled = True
            Next I

            cmdAddIndication.Enabled = True
            cmdRemoveIndication.Enabled = True
            TxtMaleUpper.Enabled = False
            TxtMaleLower.Enabled = False
            TxtFemaleUpper.Enabled = True
            TxtFemaleLower.Enabled = True
            LstViewConditionals.Enabled = True
            ChkReferNonPotential.Enabled = True
            TxtLowerWeight.Enabled = False
            TxtUpperWeight.Enabled = False
            TxtFemaleLowerWeight.Enabled = True
            TxtFemaleUpperWeight.Enabled = True
            TxtGeneralRuleout.Enabled = True

            'Male appropriate, female not appropriate
        ElseIf ChkNotAppropriateMale.CheckState = 0 And ChkNotAppropriateFemale.CheckState = 1 Then

            For I = 2 To 4
                Frame(I).Enabled = True
            Next I
            Lable(7).Enabled = True
            'Male
            For I = 10 To 12
                Lable(I).Enabled = True
            Next I
            Lable(6).Enabled = True
            Lable(17).Enabled = True
            Lable(18).Enabled = True

            'Female
            For I = 13 To 15
                Lable(I).Enabled = False
            Next I
            For I = 19 To 21
                Lable(I).Enabled = False
            Next I

            cmdAddIndication.Enabled = True
            cmdRemoveIndication.Enabled = True
            TxtMaleUpper.Enabled = True
            TxtMaleLower.Enabled = True
            TxtFemaleUpper.Enabled = False
            TxtFemaleLower.Enabled = False
            LstViewConditionals.Enabled = True
            ChkReferNonPotential.Enabled = True
            TxtLowerWeight.Enabled = True
            TxtUpperWeight.Enabled = True
            TxtFemaleLowerWeight.Enabled = False
            TxtFemaleUpperWeight.Enabled = False
            TxtGeneralRuleout.Enabled = True

        End If

    End Sub

    Private Sub cmdAddIndication_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdAddIndication.Click
        Dim vFrmConditional As Object = New FrmConditional

        vFrmConditional.vCriteriaTemplateId = vCriteriaTemplateId
        Call vFrmConditional.ShowDialog()
        vFrmConditional = Nothing

        'FSProj drh 5/8/02 - Fill the conditionals grid
        LstViewConditionals.Items.Clear()
        LstViewConditionals.View = View.Details
        Call modStatQuery.QueryTemplateConditional(Me)
    End Sub

    Private Sub CmdCancel_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdCancel.Click
        Me.Close()
    End Sub

    Private Sub CmdOK_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdOK.Click

        Dim vReturn As Short

        'Make sure the user wants to save
        vReturn = modMsgForm.FormSave

        If vReturn = MsgBoxResult.Cancel Then
            Exit Sub
        End If

        'Validate the data
        If Not modStatValidate.CriteriaTemplate(Me) Then
            Exit Sub
        End If

        Call modUtility.Work()

        'Save the template
        Call modStatSave.SaveCriteriaTemplate(Me)

        If Me.FormState = NEW_RECORD Then
            Call modStatQuery.QueryCriteriaTemplateId(Me)
        End If

        'Make sure the user wants to close
        vReturn = modMsgForm.FormClose

        If vReturn = MsgBoxResult.No Then
            Me.FormState = EXISTING_RECORD
        Else
            Me.Close()
        End If

        Call modUtility.Done()


        'Enable Indication buttons
        cmdAddIndication.Enabled = True
        cmdRemoveIndication.Enabled = True
    End Sub

    Private Sub cmdRemoveIndication_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdRemoveIndication.Click

        If LstViewConditionals.Items.Count > 0 Then
            Call modStatSave.DeleteTemplateConditional((LstViewConditionals.Items.Item(LstViewConditionals.FocusedItem.Index).Tag))

            'FSProj drh 5/8/02 - Fill the conditionals grid
            LstViewConditionals.Items.Clear()
            LstViewConditionals.View = View.Details
            Call modStatQuery.QueryTemplateConditional(Me)
        End If

    End Sub

    Private Sub FrmCriteriaTemplate_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load

        If Me.FormState = EXISTING_RECORD Then
            'Enable Indication buttons
            cmdAddIndication.Enabled = True
            cmdRemoveIndication.Enabled = True

            'Fill the Criteria info
            Call modStatQuery.QueryTemplateCriteria(Me)

        Else
            'Enable Indication buttons
            cmdAddIndication.Enabled = False
            cmdRemoveIndication.Enabled = False
        End If

        Me.Text = vCaption

        'FSProj drh 5/8/02 - Initialize the conditional list
        Call modControl.HighlightListViewRow(LstViewConditionals)
        Call LstViewConditionals.Columns.Insert(0, "", "Criteria", CInt(VB6.TwipsToPixelsX(3000)))
        Call LstViewConditionals.Columns.Insert(1, "", "Reason", CInt(VB6.TwipsToPixelsX(2000)))
        Call LstViewConditionals.Columns.Insert(2, "", "Condition", CInt(VB6.TwipsToPixelsX(10000)))

        If Me.FormState = EXISTING_RECORD Then
            'Fill the indication lists
            Call modStatQuery.QueryTemplateConditional(Me)
        End If

        Call modUtility.CenterForm()

    End Sub






    Private Sub TxtFemaleLower_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtFemaleLower.Enter
        Call modControl.HighlightText(ActiveControl)
    End Sub

    Private Sub TxtFemaleLower_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtFemaleLower.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        If (KeyAscii = 121 Or KeyAscii = 89) Then
            If Lable(15).Text = "Lower              mos." Then
                Lable(15).Text = "Lower              yrs."
            End If
        ElseIf (KeyAscii = 109 Or KeyAscii = 77) Then
            If Lable(15).Text = "Lower              yrs." Then
                Lable(15).Text = "Lower              mos."
            End If
        End If

        KeyAscii = modMask.NumMask(KeyAscii, 3, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtFemaleUpper_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtFemaleUpper.Enter
        Call modControl.HighlightText(ActiveControl)
    End Sub

    Private Sub TxtFemaleUpper_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtFemaleUpper.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        If (KeyAscii = 121 Or KeyAscii = 89) Then
            If Lable(13).Text = "Upper              mos." Then
                Lable(13).Text = "Upper              yrs."
            End If
        ElseIf (KeyAscii = 109 Or KeyAscii = 77) Then
            If Lable(13).Text = "Upper              yrs." Then
                Lable(13).Text = "Upper              mos."
            End If
        End If

        KeyAscii = modMask.NumMask(KeyAscii, 3, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtGeneralRuleout_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtGeneralRuleout.Enter
        Call modControl.HighlightText(ActiveControl)
    End Sub

    Private Sub TxtMaleLower_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtMaleLower.Enter
        Call modControl.HighlightText(ActiveControl)
    End Sub

    Private Sub TxtMaleLower_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtMaleLower.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        If (KeyAscii = 121 Or KeyAscii = 89) Then
            If Lable(10).Text = "Lower              mos." Then
                Lable(10).Text = "Lower              yrs."
            End If
        ElseIf (KeyAscii = 109 Or KeyAscii = 77) Then
            If Lable(10).Text = "Lower              yrs." Then
                Lable(10).Text = "Lower              mos."
            End If
        End If

        KeyAscii = modMask.NumMask(KeyAscii, 3, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtMaleUpper_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtMaleUpper.Enter
        Call modControl.HighlightText(ActiveControl)
    End Sub

    Private Sub TxtMaleUpper_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtMaleUpper.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        If (KeyAscii = 121 Or KeyAscii = 89) Then
            If Lable(11).Text = "Upper              mos." Then
                Lable(11).Text = "Upper              yrs."
            End If
        ElseIf (KeyAscii = 109 Or KeyAscii = 77) Then
            If Lable(11).Text = "Upper              yrs." Then
                Lable(11).Text = "Upper              mos."
            End If
        End If

        KeyAscii = modMask.NumMask(KeyAscii, 3, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
		If KeyAscii = 0 Then
			eventArgs.Handled = True
		End If
	End Sub
End Class