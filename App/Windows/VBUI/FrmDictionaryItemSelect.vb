Option Strict Off
Option Explicit On
Public Class FrmDictionaryItemSelect
    Inherits System.Windows.Forms.Form
    Private frmDictionaryItem As FrmDictionaryItem

    Private Sub CmdAdd_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdAdd.Click

        Dim vDictionaryItemID As Integer

        On Error Resume Next

        'Determine the state which to open the
        'form.
        frmDictionaryItem = New FrmDictionaryItem
        frmDictionaryItem.FormState = NEW_RECORD
        frmDictionaryItem.DictionaryItemID = 0

        'Get the DictionaryItem id from the DictionaryItem form
        'after the user is done.
        vDictionaryItemID = frmDictionaryItem.Display

        If vDictionaryItemID = 0 Then
            'The user cancelled adding a new DictionaryItem
            'so do nothing
        Else
            'Refill the list box with the new (or updated)
            'DictionaryItem id and name
            LstDictionaryItem.Items.Clear()
            Call modStatRefQuery.ListRefQueryDictionaryItem(LstDictionaryItem)
        End If

    End Sub


    Private Sub CmdCancel_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdCancel.Click

        Me.Close()

    End Sub

    Private Sub CmdEdit_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdEdit.Click

        Dim vDictionaryItemID As Integer
        Dim vReturn As New Object

        On Error Resume Next

        'Determine the state which to open the
        'form.
        frmDictionaryItem = New FrmDictionaryItem
        frmDictionaryItem.FormState = EXISTING_RECORD
        Call modControl.GetSelID(LstDictionaryItem, vReturn)
        If vReturn(0) < 1 Then
            'Nothing is selected, so don't show the cause of death form
            Exit Sub
        Else
            frmDictionaryItem.DictionaryItemID = vReturn(0)
        End If

        'Get the DictionaryItem id from the DictionaryItem form
        'after the user is done.
        vDictionaryItemID = frmDictionaryItem.Display

        If vDictionaryItemID = 0 Then
            'The user cancelled adding a new DictionaryItem
            'so do nothing
        Else
            'Refill the combo box with the new (or updated)
            'DictionaryItem id and name
            LstDictionaryItem.Items.Clear()
            Call modStatRefQuery.ListRefQueryDictionaryItem(LstDictionaryItem)
        End If

    End Sub



    Private Sub FrmDictionaryItemSelect_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load

        Call modUtility.CenterForm()

        'Fill all reference data
        Call modStatRefQuery.ListRefQueryDictionaryItem(LstDictionaryItem)

    End Sub



    Public Function Display() As Object

        Me.ShowDialog()

    End Function

    Private Sub FrmDictionaryItemSelect_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing

        AppMain.frmDictionaryItemSelect = Nothing
        'Me.Dispose()

    End Sub




    Private Sub LstDictionaryItem_DoubleClick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstDictionaryItem.DoubleClick

        Call CmdEdit_Click(CmdEdit, New System.EventArgs())

    End Sub

End Class