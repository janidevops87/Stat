Option Strict Off
Option Explicit On
Friend Class FrmVerifyWeight
	Inherits System.Windows.Forms.Form
	'Bret 1/06/10 add Option explicit for upgrade

    Public modalParent As Object

	Private Sub CmdOK_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdOK.Click
		'************************************************************************************
		'Name: VerifyWeight
		'Date Created: 05/30/2007                         Created by: T.T
		'Release: 8.4                             Task: None
		'Description: verify weight when a referral is ruled out
		'Returns:
		'Params:
		'Stored Procedures: None
		'=============================================================================
		
		'FrmReferral.txtWeight.SetFocus
        modalParent.vVerifyWeight = True
		
		'ccarroll 09/17/2007 convert to kg before saving
		If lblweight.Text = "lbs" Then
			txtWeight.Text = FormatNumber(System.Math.Round(CDbl(txtWeight.Text) / 2.2, 1), 1)
		End If
		
        modalParent.txtWeight.Text = CStr(CDec(Me.txtWeight.Text))
		
		'Reset WeightRuleout flags
        modalParent.WeightRuleOut = False
        modalParent.vVerifyWeight = False
		
        modalParent.VerifyWeightRuleout()
		
        If modalParent.WeightRuleOut = False Then
            modalParent.VerifyWeightValidate()
        End If
		
		Me.Close()
		
		
	End Sub
	
	Private Sub cmdTest_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdTest.Click
		'************************************************************************************
		'Name: Verifyweight test
		'Date Created: 05/30/2007                         Created by: T.T
		'Release: 8.4                             Task: None
		'Description: verify weight test when a referral is ruled out
		'Returns:
		'Params:
		'Stored Procedures: None
		'=============================================================================
        Dim vReturn As New Object
        Dim vResultArray As New Object
        Dim vQuery As New Object
        Dim I As New Object
        Dim Criteria As New Object
        Dim WeightRuleOut As Boolean

        For I = 1 To 7

            'Get criteria number
            vQuery = "SELECT DISTINCT CriteriaOrganization.CriteriaID, Criteria.CriteriaGroupName  FROM Criteria  JOIN CriteriaOrganization ON Criteria.CriteriaID = CriteriaOrganization.CriteriaID  JOIN CriteriaSourceCode ON CriteriaSourceCode.CriteriaID = Criteria.CriteriaID  WHERE CriteriaOrganization.OrganizationID = " & modalParent.OrganizationId & "  AND Criteria.DonorCategoryID = " & I
            vQuery = vQuery & " AND CriteriaSourceCode.SourceCodeID = " & modalParent.SourceCode.ID & " AND Criteria.CriteriaStatus = 1 ORDER BY Criteria.CriteriaGroupName ASC "

            vReturn = modODBC.Exec(vQuery, vResultArray)
            Criteria = vResultArray(0, 0)

            vQuery = "Select * from Criteria Where Criteria.DonorCategoryID = " & I & " And Criteria.CriteriaID = " & Criteria

            vReturn = modODBC.Exec(vQuery, vResultArray)


            If modConv.TextToInt(Me.txtWeight.Text) < vResultArray(0, 14) Then
                WeightRuleOut = True
            End If

            If modConv.TextToInt(Me.txtWeight.Text) > vResultArray(0, 15) Then
                WeightRuleOut = True
            End If

        Next I
    End Sub

    Private Sub FrmVerifyWeight_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load
        Dim dis As New Object
        Me.CmdOK.Enabled = False
        dis = modCloseBtn.EnableCloseButton(Me.Handle.ToInt32, False)
    End Sub

    Private Sub txtWeight_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles txtWeight.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)
        On Error Resume Next

        ' ccarroll 09/17/2007 changed to case statement
        Select Case KeyAscii

            Case Is = 107 Or 75 '[K, k] key pressed
                lblweight.Text = "kg"

            Case Is = 108 Or 76 '[L, l] key pressed
                lblweight.Text = "lbs"

        End Select

        KeyAscii = modMask.DecimalMask(KeyAscii, 7, 1, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub txtWeight_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtWeight.Leave
        If Me.txtWeight.Text <> "" Then
            If CDbl(Me.txtWeight.Text) > 0 Then
                Me.CmdOK.Enabled = True
            End If
        End If
    End Sub

    Private Sub txtWeight_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtWeight.TextChanged

        'ccarroll 09/18/2004 disable save if no value
        If Len(Me.txtWeight.Text) > 0 Then
            Me.CmdOK.Enabled = True
        Else
            Me.CmdOK.Enabled = False
        End If

    End Sub
End Class