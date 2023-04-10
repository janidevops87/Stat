Option Strict Off
Option Explicit On
Public Class FrmIndicationSelect
    Inherits System.Windows.Forms.Form

    Dim fvSelectedList As New Object
    Dim fvSaved As Short
    Dim fvNoSelect As Short
    Dim fvSortOrder As New Object
    '03/2010 bret 
    Private frmIndication As FrmIndication

    Private Sub CmdAdd_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdAdd.Click

        Dim vIndicationID As Integer

        On Error Resume Next

        'Determine the state which to open the
        'form.
        frmIndication = New FrmIndication
        frmIndication.FormState = NEW_RECORD
        frmIndication.IndicationID = 0

        'Get the Indication id from the Indication form
        'after the user is done.
        vIndicationID = frmIndication.Display

        If vIndicationID = 0 Then
            'The user cancelled adding a new Indication
            'so do nothing
        Else
            'Refill the list box with the new (or updated)
            'Indication id and name
            LstViewIndication.Items.Clear()
            LstViewIndication.View = View.Details
            Call modStatQuery.QueryIndication(Me)
        End If

    End Sub


    Private Sub CmdCancel_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdCancel.Click

        Me.Close()

    End Sub

    Private Sub CmdEdit_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdEdit.Click

        Dim vIndicationID As Integer
        'Dim vReturn As New Object

        On Error Resume Next

        'Determine the state which to open the
        'form.
        frmIndication = New FrmIndication
        frmIndication.FormState = EXISTING_RECORD

        frmIndication.IndicationID = modConv.TextToLng(LstViewIndication.FocusedItem.Tag)

        'Get the Indication id from the Indication form
        'after the user is done.
        vIndicationID = frmIndication.Display

        If vIndicationID = 0 Then
            'The user cancelled adding a new Indication
            'so do nothing
        Else
            'Refill the combo box with the new (or updated)
            'Indication id and name
            LstViewIndication.Items.Clear()
            LstViewIndication.View = View.Details
            Call modStatQuery.QueryIndication(Me)
        End If

        Me.Activate()

    End Sub

    Private Sub CmdOK_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdOK.Click

        Dim vReturn As New Object

        'Fill an array with the selected items
        Call modControl.GetSelListViewID(LstViewIndication, vReturn)

        Me.SelectedList = vReturn

        Me.Saved = True

        Me.Close()

    End Sub

    Private Sub Command1_Click()

    End Sub

    Private Sub FrmIndicationSelect_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load

        Call modUtility.CenterForm()

        'Initialize the Indication indications grid
        Call modControl.HighlightListViewRow(LstViewIndication)
        Call LstViewIndication.Columns.Insert(0, "", "Ruleout", CInt(VB6.TwipsToPixelsX(1500)))
        Call LstViewIndication.Columns.Insert(1, "", "Ruleout only if...", CInt(VB6.TwipsToPixelsX(5000)))

        'Fill all reference data
        Call modStatQuery.QueryIndication(Me)

        Me.Saved = False

    End Sub



    Public Function Display() As Object

        Dim dialogResult As DialogResult = Me.ShowDialog()

        Display = Me.SelectedList

    End Function


    Public Property SelectedList() As Object
        Get

            SelectedList = fvSelectedList

        End Get
        Set(ByVal Value As Object)

            fvSelectedList = Value

        End Set
    End Property




    Public Property Saved() As Object
        Get

            Saved = fvSaved

        End Get
        Set(ByVal Value As Object)

            fvSaved = Value

        End Set
    End Property








    Public Property NoSelect() As Object
        Get

            NoSelect = fvNoSelect

        End Get
        Set(ByVal Value As Object)

            fvNoSelect = Value

        End Set
    End Property




    Public Property SortOrder() As Object
        Get

            SortOrder = fvSortOrder

        End Get
        Set(ByVal Value As Object)

            fvSortOrder = Value

        End Set
    End Property

    Private Sub FrmIndicationSelect_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing

        AppMain.frmIndicationSelect = Nothing
        'Me.Dispose()

    End Sub


    Private Sub LstViewIndication_ColumnClick(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.ColumnClickEventArgs) Handles LstViewIndication.ColumnClick
        Dim ColumnHeader As System.Windows.Forms.ColumnHeader = LstViewIndication.Columns(eventArgs.Column)

        ' When a ColumnHeader object is clicked, the ListView control is
        ' sorted by the subitems of that column.
        ' Set the SortKey to the Index of the ColumnHeader - 1
        LstViewIndication.Sorting = Me.SortOrder
        LstViewIndication.ListViewItemSorter = New ListViewItemComparer(eventArgs.Column, Me.SortOrder)

        If Me.SortOrder = System.Windows.Forms.SortOrder.Ascending Then
            Me.SortOrder = System.Windows.Forms.SortOrder.Descending
        Else
            Me.SortOrder = System.Windows.Forms.SortOrder.Ascending
        End If

    End Sub


    Private Sub LstViewIndication_DoubleClick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewIndication.DoubleClick

        Call CmdEdit_Click(CmdEdit, New System.EventArgs())

    End Sub
End Class