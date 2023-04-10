Option Strict Off
Option Explicit On
Public Class FrmRefDups
    Inherits System.Windows.Forms.Form

    Dim vRefList As New Object
    Public SortOrder As Short
    Public CallId As Integer
    Public modalParent As Object
    Private Sub CmdCancel_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdCancel.Click

        '8/25/03 drh - Added error-handling so we can log user action
        On Error GoTo localError

        '8/25/03 drh - Raise error so we can log message
        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Nothing, "Referral duplicate form closed.  No duplicate selected.")

        Me.Close()

        Exit Sub

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        Resume Next

    End Sub



    Private Sub FrmRefDups_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load

        Call modUtility.CenterForm()

        'Initialize the Indication indications grid
        Call modControl.HighlightListViewRow(LstViewDups)
        Call LstViewDups.Columns.Insert(0, "", "Call #", CInt(VB6.TwipsToPixelsX(1200)))
        Call LstViewDups.Columns.Insert(1, "", "Date           Time", CInt(VB6.TwipsToPixelsX(1500)))
        Call LstViewDups.Columns.Insert(2, "", "Patient", CInt(VB6.TwipsToPixelsX(1850)))
        Call LstViewDups.Columns.Insert(3, "", "Patient Location", CInt(VB6.TwipsToPixelsX(3500)))
        Call LstViewDups.Columns.Insert(4, "", "Age", CInt(VB6.TwipsToPixelsX(700)))
        Call LstViewDups.Columns.Insert(5, "", "Race", CInt(VB6.TwipsToPixelsX(1000)))
        Call LstViewDups.Columns.Insert(6, "", "Sex", CInt(VB6.TwipsToPixelsX(500)))
        Call LstViewDups.Columns.Insert(7, "", "Admit", CInt(VB6.TwipsToPixelsX(1400)))


        'Fill the list
        Call modMask.DateTimeColumn(vRefList, 2)
        Call modControl.ClearListView(LstViewDups)
        Call modControl.SetListViewRows(vRefList, True, LstViewDups, False)

        VB6.SetDefault(CmdCancel, False)

    End Sub

    Public Function Display(ByRef pvRefList As Object) As Object

        vRefList = pvRefList
        'ccarroll Changed to modal was: Me.Show() (wi:8325)
        Me.ShowDialog()
        Return Me.CallId
    End Function



    Private Sub LstViewDups_ColumnClick(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.ColumnClickEventArgs) Handles LstViewDups.ColumnClick
        Dim ColumnHeader As System.Windows.Forms.ColumnHeader = LstViewDups.Columns(eventArgs.Column)

        ' When a ColumnHeader object is clicked, the ListView control is
        ' sorted by the subitems of that column.
        ' Set the SortKey to the Index of the ColumnHeader - 1
        LstViewDups.Sorting = Me.SortOrder
        LstViewDups.ListViewItemSorter = New ListViewItemComparer(eventArgs.Column, Me.SortOrder)

        If Me.SortOrder = System.Windows.Forms.SortOrder.Ascending Then
            Me.SortOrder = System.Windows.Forms.SortOrder.Descending
        Else
            Me.SortOrder = System.Windows.Forms.SortOrder.Ascending
        End If

    End Sub
    Private Sub LstViewDups_DoubleClick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewDups.DoubleClick

        '8/25/03 drh - Added error-handling so we can log user action
        On Error GoTo localError

        Dim vCallID As Integer
        Dim I As Short
        'Get the call ID
        Me.CallId = modConv.TextToLng(LstViewDups.FocusedItem.Tag)


        Me.Close()
        Exit Sub

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        Resume Next

    End Sub
    Public Sub Closeform()
        CmdCancel_Click(CmdCancel, New EventArgs)
    End Sub

    Private Sub FrmRefDups_LostFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.LostFocus

    End Sub
End Class