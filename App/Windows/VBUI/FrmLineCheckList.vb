Option Strict Off
Option Explicit On
Friend Class FrmLineCheckList
	Inherits System.Windows.Forms.Form
	
	Public SortOrder As Short
	Public SourceCodes As New colSourceCodes
	Private Sub CmdCancel_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdCancel.Click
		
		Me.Close()
		
	End Sub
	
	
	Private Sub CmdRefresh_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdRefresh.Click
		
		Dim SourceCode As clsSourceCode
		
		Me.SourceCodes.GetItems()
		
		'Check for inactive source codes
		For	Each SourceCode In SourceCodes
			SourceCode.CheckLineActivity()
			If SourceCode.LineInactive = False Then
				Call SourceCodes.Remove((SourceCode.Key))
			End If
		Next SourceCode
		
		Call Me.SourceCodes.FillListViewLineCheck(LstViewLineCheck)
		
	End Sub

    Private Sub FrmLineCheckList_Activated(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Activated

        Call CmdRefresh_Click(CmdRefresh, New System.EventArgs())

        TxtMessage.Text = ""

    End Sub



    Private Sub FrmLineCheckList_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load

        Call modUtility.CenterForm(ParentForm)

        'Initialize the Indication indications grid
        Call modControl.HighlightListViewRow(LstViewLineCheck)
        Call LstViewLineCheck.Columns.Insert(0, "", "Source Code", CInt(VB6.TwipsToPixelsX(900)))
        Call LstViewLineCheck.Columns.Insert(1, "", "Line Check Instructions", CInt(VB6.TwipsToPixelsX(4700)))

    End Sub

    Private Sub FrmLineCheckList_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing



    End Sub



    Public Function Display() As Object

        Me.Show()

    End Function



    Private Sub LstViewLineCheck_ColumnClick(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.ColumnClickEventArgs) Handles LstViewLineCheck.ColumnClick
        Dim ColumnHeader As System.Windows.Forms.ColumnHeader = LstViewLineCheck.Columns(eventArgs.Column)

        ' When a ColumnHeader object is clicked, the ListView control is
        ' sorted by the subitems of that column.
        ' Set the SortKey to the Index of the ColumnHeader - 1
        LstViewLineCheck.Sorting = Me.SortOrder
        LstViewLineCheck.ListViewItemSorter = New ListViewItemComparer(eventArgs.Column, Me.SortOrder)
        ' Set Sorted to True to sort the list.
        LstViewLineCheck.Sort()

        If Me.SortOrder = System.Windows.Forms.SortOrder.Ascending Then
            Me.SortOrder = System.Windows.Forms.SortOrder.Descending
        Else
            Me.SortOrder = System.Windows.Forms.SortOrder.Ascending
        End If

    End Sub



    Private Sub LstViewLineCheck_DoubleClick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewLineCheck.DoubleClick

        Dim SourceCode As clsSourceCode
        Dim frmNoCall = New FrmNoCall()

        If LstViewLineCheck.Items.Count = 0 Then
            Exit Sub
        End If

        'Get the selected item
        SourceCode = SourceCodes.Item(LstViewLineCheck.FocusedItem.Tag)

        If Not modUtility.ChkOpenForm("FrmNoCall") Then
            frmNoCall.FormState = NEW_RECORD
            frmNoCall.NoCallTypeID = 19
            frmNoCall.Description = SourceCode.Name & " - " & TxtMessage.Text
            frmNoCall.SourceCode = SourceCode
            Call frmNoCall.Display()
        End If

    End Sub

    Private Sub LstViewLineCheck_ItemClick(ByVal Item As System.Windows.Forms.ListViewItem)

        TxtMessage.Text = LstViewLineCheck.Items.Item(LstViewLineCheck.FocusedItem.Index).SubItems(1).Text

    End Sub
End Class