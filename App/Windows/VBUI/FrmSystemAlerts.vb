Option Strict Off
Option Explicit On
Public Class FrmSystemAlert
    Inherits System.Windows.Forms.Form

    Public SortOrder As Short
    Public AlertState As Short
    Public SystemAlertID As Integer
    Public SetResolved As Boolean
    Private Sub CmdCancel_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdCancel.Click

        Me.Close()

    End Sub





    Private Sub CmdDelete_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdDelete.Click

        Call modStatSave.DeleteSystemAlert(Me)
        Call modStatQuery.QuerySystemAlert(Me)

    End Sub

    Private Sub CmdResolve_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdResolve.Click

        Me.SetResolved = True
        Call modStatSave.UpdateSystemAlert(Me)
        Call modStatQuery.QuerySystemAlert(Me)

    End Sub

    Private Sub CmdUnresolved_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdUnresolved.Click

        Me.SetResolved = False
        Call modStatSave.UpdateSystemAlert(Me)
        Call modStatQuery.QuerySystemAlert(Me)

    End Sub


    Private Sub FrmSystemAlert_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load

        Call modUtility.CenterForm(ParentForm)

        'Initialize the Indication indications grid
        Call modControl.HighlightListViewRow(LstViewAlerts)
        Call LstViewAlerts.Columns.Insert(0, "", "#", CInt(VB6.TwipsToPixelsX(250)))
        Call LstViewAlerts.Columns.Insert(1, "", "Date", CInt(VB6.TwipsToPixelsX(1500)))
        Call LstViewAlerts.Columns.Insert(2, "", "User", CInt(VB6.TwipsToPixelsX(1400)))
        Call LstViewAlerts.Columns.Insert(3, "", "Alert", CInt(VB6.TwipsToPixelsX(2500)))
        Call LstViewAlerts.Columns.Insert(4, "", "Resolved", CInt(VB6.TwipsToPixelsX(900)))

        Me.AlertState = UNRESOLVED_ALERTS

        OptState(Me.AlertState).Checked = True

    End Sub

    Private Sub FrmSystemAlert_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing

        AppMain.frmSystemAlert = Nothing
        'Me.Dispose()

    End Sub



    Public Function Display() As Object

        Me.Show()

    End Function







    Private Sub LstViewAlerts_ColumnClick(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.ColumnClickEventArgs) Handles LstViewAlerts.ColumnClick
        Dim ColumnHeader As System.Windows.Forms.ColumnHeader = LstViewAlerts.Columns(eventArgs.Column)

        ' When a ColumnHeader object is clicked, the ListView control is
        ' sorted by the subitems of that column.
        ' Set the SortKey to the Index of the ColumnHeader - 1
        LstViewAlerts.Sorting = Me.SortOrder
        LstViewAlerts.ListViewItemSorter = New ListViewItemComparer(eventArgs.Column, Me.SortOrder)
        ' Set Sorted to True to sort the list.
        LstViewAlerts.Sort()

        If Me.SortOrder = System.Windows.Forms.SortOrder.Ascending Then
            Me.SortOrder = System.Windows.Forms.SortOrder.Descending
        Else
            Me.SortOrder = System.Windows.Forms.SortOrder.Ascending
        End If

    End Sub




    Private Sub LstViewAlerts_ItemClick(ByVal Item As System.Windows.Forms.ListViewItem)

        Dim vSubItemsList As Object

        Me.SystemAlertID = modConv.TextToLng(LstViewAlerts.FocusedItem.Tag)

        Call modControl.GetSelListViewSubItems(LstViewAlerts, vSubItemsList)

        TxtAlertMessage.Text = vSubItemsList(0, 2)

    End Sub


    Private Sub OptState_CheckedChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles OptState.CheckedChanged
        If eventSender.Checked Then
            Dim Index As Short = OptState.GetIndex(eventSender)

            Me.AlertState = Index

            OptState(Me.AlertState).Checked = True

            Call modStatQuery.QuerySystemAlert(Me)

        End If
    End Sub
End Class