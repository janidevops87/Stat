Option Strict Off
Option Explicit On
Public Class FrmKeyCodeSelect
    Inherits System.Windows.Forms.Form

    Public SelectedList As Object
    Public Saved As Short
    Public NoSelect As Short
    Public SortOrder As Object
    Private frmKeyCode As FrmKeyCode
    Private Sub CmdAdd_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdAdd.Click

        Dim vKeyCodeID As Integer

        On Error Resume Next

        'Determine the state which to open the
        'form.
        frmKeyCode = New FrmKeyCode
        frmKeyCode.FormState = NEW_RECORD
        frmKeyCode.KeyCodeID = 0

        'Get the KeyCode id from the KeyCode form
        'after the user is done.
        vKeyCodeID = frmKeyCode.Display

        If vKeyCodeID = 0 Then
            'The user cancelled adding a new KeyCode
            'so do nothing
        Else
            'Refill the list box with the new (or updated)
            'KeyCode id and name
            LstViewKeyCode.Items.Clear()
            LstViewKeyCode.View = View.Details
            Call modStatQuery.QueryKeyCode(Me)
        End If

    End Sub


    Private Sub CmdCancel_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdCancel.Click

        Me.Close()

    End Sub

    Private Sub CmdEdit_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdEdit.Click

        Dim vKeyCodeID As Integer
        'Dim vReturn() As String

        On Error Resume Next

        'Determine the state which to open the
        'form.
        frmKeyCode = New FrmKeyCode

        frmKeyCode.FormState = EXISTING_RECORD

        vKeyCodeID = modConv.TextToLng(LstViewKeyCode.FocusedItem.Tag)


        If vKeyCodeID = 0 Then
            'The user cancelled adding a new KeyCode
            'so do nothing
        Else

            frmKeyCode.KeyCodeID = vKeyCodeID

            'Get the KeyCode id from the KeyCode form
            'after the user is done.
            vKeyCodeID = frmKeyCode.Display

            'Refill the combo box with the new (or updated)
            'KeyCode id and name
            LstViewKeyCode.Items.Clear()
            LstViewKeyCode.View = View.Details
            Call modStatQuery.QueryKeyCode(Me)
        End If

        Me.Activate()

    End Sub

    Private Sub CmdOK_Click()

        Dim vReturn As New Object

        'Fill an array with the selected items
        Call modControl.GetSelListViewID(LstViewKeyCode, vReturn)

        Me.SelectedList = vReturn

        Me.Saved = True

        Me.Close()

    End Sub

    Private Sub CmdRemove_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdRemove.Click

        Dim vKeyCodeID As Integer

        On Error Resume Next

        'Determine the state which to open the
        'form.
        vKeyCodeID = modConv.TextToLng(LstViewKeyCode.FocusedItem.Tag)

        If vKeyCodeID = 0 Then
            'The user cancelled adding a new KeyCode
            'so do nothing
        Else
            If MsgBox("Are you sure you want to remove this item?", MsgBoxStyle.YesNo) = MsgBoxResult.Yes Then
                Call modStatSave.DeleteKeyCode(vKeyCodeID)
            End If
        End If

        Me.Activate()

    End Sub

    Private Sub FrmKeyCodeSelect_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load

        Call modUtility.CenterForm()

        'Initialize the KeyCode KeyCodes grid
        Call modControl.HighlightListViewRow(LstViewKeyCode)
        Call LstViewKeyCode.Columns.Insert(0, "", "Code", CInt(VB6.TwipsToPixelsX(900)))
        Call LstViewKeyCode.Columns.Insert(1, "", "Phrase", CInt(VB6.TwipsToPixelsX(3000)))

        'Fill all reference data
        Call modStatQuery.QueryKeyCode(Me)

        Me.Saved = False

    End Sub



    Public Function Display() As Object

        Me.ShowDialog()

        Display = Me.SelectedList

    End Function

    Private Sub FrmKeyCodeSelect_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing

        AppMain.frmKeyCodeSelect = Nothing
        'Me.Dispose()


    End Sub









    Private Sub LstViewKeyCode_ColumnClick(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.ColumnClickEventArgs) Handles LstViewKeyCode.ColumnClick
        Dim ColumnHeader As System.Windows.Forms.ColumnHeader = LstViewKeyCode.Columns(eventArgs.Column)

        ' When a ColumnHeader object is clicked, the ListView control is
        ' sorted by the subitems of that column.
        ' Set the SortKey to the Index of the ColumnHeader - 1
        LstViewKeyCode.Sorting = Me.SortOrder
        LstViewKeyCode.ListViewItemSorter = New ListViewItemComparer(eventArgs.Column, Me.SortOrder)
        ' Set Sorted to True to sort the list.
        LstViewKeyCode.Sort()

        If Me.SortOrder = System.Windows.Forms.SortOrder.Ascending Then
            Me.SortOrder = System.Windows.Forms.SortOrder.Descending
        Else
            Me.SortOrder = System.Windows.Forms.SortOrder.Ascending
        End If

    End Sub


    Private Sub LstViewKeyCode_DoubleClick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewKeyCode.DoubleClick

        Call CmdEdit_Click(CmdEdit, New System.EventArgs())

    End Sub
End Class