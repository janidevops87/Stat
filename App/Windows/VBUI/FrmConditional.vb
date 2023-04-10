Option Strict Off
Option Explicit On
Friend Class FrmConditional
	Inherits System.Windows.Forms.Form
	'Bret 1/06/10 add Option explicit for upgrade
	Public vCriteriaTemplateId As Integer
	Public vSubCriteriaId As Integer
	Public vSelectedCriteriaId As Integer
	Public vSelectedReasonId As Integer
	Public vSelectedConditionId As Integer
	
	Private Sub CmdCancel_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdCancel.Click
		Me.Close()
	End Sub
	
	Private Sub cmdNewCondition_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdNewCondition.Click
        Dim frmFSCondition = New FrmFSCondition()

        Call frmFSCondition.ShowDialog()
		
		'FSProj drh 5/6/02 - Clear Available Subtypes list
		LstViewCondition.Items.Clear()
        LstViewCondition.View = View.Details

        'FSProj drh 5/6/02 - Fill the available subtypes grid
        Call modStatQuery.QueryFSCondition(Me)

    End Sub

    Private Sub cmdNewCriteria_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdNewCriteria.Click
        Dim frmFSIndication = New FrmFSIndication
        Call FrmFSIndication.ShowDialog()

        'FSProj drh 5/6/02 - Clear Available Subtypes list
        LstViewCriteria.Items.Clear()
        LstViewCriteria.View = View.Details

        'FSProj drh 5/6/02 - Fill the available subtypes grid
        Call modStatQuery.QueryFSIndication(Me)

    End Sub

    Private Sub cmdSelect_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdSelect.Click

        Dim vQuery As String = ""
        Dim vReturn As New Object

        If LstViewCriteria.SelectedItems.Count > 0 And LstViewReason.SelectedItems.Count > 0 And LstViewCondition.SelectedItems.Count > 0 Then

            Call modUtility.Work()

            Me.vSelectedCriteriaId = LstViewCriteria.Items.Item(LstViewCriteria.FocusedItem.Index).Tag
            Me.vSelectedReasonId = LstViewReason.Items.Item(LstViewReason.FocusedItem.Index).Tag
            'Me.vSelectedReasonId = LstViewReason.Items.Item(LstViewReason.SelectedItems.Item.Index).Tag
            Me.vSelectedConditionId = LstViewCondition.Items.Item(LstViewCondition.FocusedItem.Index).Tag
            'Me.vSelectedConditionId = LstViewCondition.Items.Item(LstViewCondition.SelectedItems.IndexOf().Tag

            'Query to see if the record already exists
            If vCriteriaTemplateId > 0 Then
                vQuery = "SELECT * FROM CriteriaTemplate_ConditionalRO " & "WHERE CriteriaTemplateId = " & vCriteriaTemplateId & " " & "AND FSIndicationId = " & vSelectedCriteriaId & " " & "AND FSAppropriateId = " & vSelectedReasonId & " " & "AND FSConditionId = " & vSelectedConditionId & ";"
            ElseIf vSubCriteriaId > 0 Then
                vQuery = "SELECT * FROM ProcessorCriteria_ConditionalRO " & "WHERE SubCriteriaId = " & vSubCriteriaId & " " & "AND FSIndicationId = " & vSelectedCriteriaId & " " & "AND FSAppropriateId = " & vSelectedReasonId & " " & "AND FSConditionId = " & vSelectedConditionId & ";"
            End If

            'If record doesn't exist, insert it
            If modODBC.Exec(vQuery, vReturn) = NO_DATA Then

                If vCriteriaTemplateId > 0 Then
                    Call modStatSave.SaveTemplateConditional(Me)
                ElseIf vSubCriteriaId > 0 Then
                    Call modStatSave.SaveSubCriteriaConditional(Me)
                End If

                'Make sure the user wants to close
                vReturn = modMsgForm.FormClose

                If vReturn <> MsgBoxResult.No Then
                    Me.Close()
                End If

                Call modUtility.Done()

            Else
                Call MsgBox("Record already exists.", MsgBoxStyle.OkOnly, "Existing Record")
                Call modUtility.Done()
                Exit Sub
            End If

        Else
            Call MsgBox("Please select a Criteria, Reason, and Condition.", MsgBoxStyle.OkOnly, "Missing Data")
        End If

    End Sub

    Private Sub FrmConditional_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load

        'FSProj drh 5/8/02 - Initialize the conditional lists
        'Call modControl.HighlightListViewRow(LstViewCriteria)

        Call LstViewCriteria.Columns.Insert(0, "", "Indication", CInt(VB6.TwipsToPixelsX(5350)))

        'Call modControl.HighlightListViewRow(LstViewReason)
        Call LstViewReason.Columns.Insert(0, "", "R/O Reason", CInt(VB6.TwipsToPixelsX(3060)))

        'Call modControl.HighlightListViewRow(LstViewCondition)
        Call LstViewCondition.Columns.Insert(0, "", "Condition", CInt(VB6.TwipsToPixelsX(8825)))

        Call modStatQuery.QueryFSIndication(Me)
		Call modStatQuery.QueryFSAppropriate(Me)
        Call modStatQuery.QueryFSCondition(Me)

        LstViewCriteria.TopItem.Selected = True
        LstViewReason.TopItem.Selected = True
        LstViewCondition.TopItem.Selected = True
        LstViewReason.TopItem.Focused = True
        LstViewCondition.TopItem.Focused = True
	End Sub
End Class