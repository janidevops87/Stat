Option Strict Off
Option Explicit On
Imports Statline.Stattrac.Framework
Imports Statline.Stattrac.Windows.UI

Public Class FrmLeaseOrganizationCalls
    Inherits System.Windows.Forms.Form
    'Bret 1/06/10 add Option explicit for upgrade
    Private Sub CmdClose_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdClose.Click
        Me.Close()
    End Sub

    Private Sub CmdDisable_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdDisable.Click

        If LstViewEnabledLOCalls.SelectedItems.Count = 0 Then
            BaseMessageBox.ShowWarning("Please select a Lease Organization before clicking this button.")
            Exit Sub
        End If

        'get selected list
        Dim vReturn As New Object

        Call modUtility.Work()

        If LstViewEnabledLOCalls.Items.Count > 0 Then

            Call modControl.GetSelListViewID(LstViewEnabledLOCalls, vReturn)
            If IsNothing(vReturn) Then
                Call modUtility.Done()
                Exit Sub
            End If
        Else
            Call modUtility.Done()
            Exit Sub
        End If

        'Disable Selected Organizations

        'Insert each of the new rows in the database

        If modStatSave.UpdateEnabledLOCalls(Me, vReturn, 0) = SUCCESS Then


            'Switch List
            Call modControl.SwitchListView(vReturn, LstViewEnabledLOCalls, LstViewDisabledLOCalls)


        End If
        Call modControl.AdjustListView(LstViewDisabledLOCalls, LstViewEnabledLOCalls)
        Call modUtility.Done()


    End Sub

    Private Sub CmdEnable_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdEnable.Click

        If LstViewDisabledLOCalls.SelectedItems.Count = 0 Then
            BaseMessageBox.ShowWarning("Please select a StatLine Organization before clicking this button.")
            Exit Sub
        End If

        'get selected list
        Dim vReturn As New Object

        Call modUtility.Work()

        If LstViewDisabledLOCalls.Items.Count > 0 Then


            Call modControl.GetSelListViewID(LstViewDisabledLOCalls, vReturn)
            If Not TypeOf vReturn Is Array Then
                Call modUtility.Done()
                Exit Sub
            End If

        Else
            Call modUtility.Done()
            Exit Sub
        End If

        'Disable Selected Organizations

        'Insert each of the new rows in the database

        If modStatSave.UpdateEnabledLOCalls(Me, vReturn, -1) = SUCCESS Then

            'Switch List bad
            Call modControl.SwitchListView(vReturn, LstViewDisabledLOCalls, LstViewEnabledLOCalls)
            'Call modControl.LeaseOrgListView(LstViewDisabledLOCalls, LstViewEnabledLOCalls)
        End If
        Call modControl.AdjustListView(LstViewDisabledLOCalls, LstViewEnabledLOCalls)
        Call modUtility.Done()
    End Sub

    Private Sub FrmLeaseOrganizationCalls_FormClosing(ByVal sender As Object, ByVal e As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing
        AppMain.frmLeaseOrganizationCalls = Nothing
        'Me.Dispose()

    End Sub

    Private Sub FrmLeaseOrganizationCalls_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load

        'Center Form
        Call modUtility.CenterForm()

        'Hide buttons form LO
        If AppMain.ParentForm.LeaseOrganization <> 0 Then
            CmdDisable.Visible = False
            CmdEnable.Visible = False
        End If

        'Initialize Enabled LOs
        Call modControl.HighlightListViewRow(LstViewEnabledLOCalls)
        Call LstViewEnabledLOCalls.Columns.Insert(0, "", "Organization", CInt(VB6.TwipsToPixelsX(2500)))
        'Call LstViewEnabledLOCalls.ColumnHeaders.Add(2, , "City", 1100)
        'Call LstViewEnabledLOCalls.ColumnHeaders.Add(3, , "State", 400)


        'Initialize Disabled LOs
        Call modControl.HighlightListViewRow(LstViewDisabledLOCalls)
        Call LstViewDisabledLOCalls.Columns.Insert(0, "", "Organization", CInt(VB6.TwipsToPixelsX(2500)))
        'Call LstViewDisabledLOCalls.ColumnHeaders.Add(2, , "City", 1100)
        'Call LstViewDisabledLOCalls.ColumnHeaders.Add(3, , "State", 400)

        'Query & Populate Enabled Lease Organizations
        Dim leaseOrgsEnabled As Object = modDataQuery.GetOrganizationCallStatusList(organizationID:=AppMain.ParentForm.LeaseOrganization, organizationLOEnabled:=True)
        If Validater.ObjectIsValidArray(leaseOrgsEnabled, 2, 0, 0) Then
            Call modControl.SetListViewRows(leaseOrgsEnabled, True, LstViewEnabledLOCalls, False)
        End If

        'Query & Populate Disabled Lease Organizations
        Dim leaseOrgsDisabled As Object = modDataQuery.GetOrganizationCallStatusList(organizationID:=AppMain.ParentForm.LeaseOrganization, organizationLOEnabled:=False)
        If Validater.ObjectIsValidArray(leaseOrgsDisabled, 2, 0, 0) Then
            Call modControl.SetListViewRows(leaseOrgsDisabled, True, LstViewEnabledLOCalls, False)
        End If

        Call modControl.LeaseOrgListView(LstViewDisabledLOCalls, LstViewEnabledLOCalls)
        Call modControl.LeaseOrgListView(LstViewEnabledLOCalls, LstViewDisabledLOCalls)



    End Sub

End Class