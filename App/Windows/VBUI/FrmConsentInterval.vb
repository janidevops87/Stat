Option Strict Off
Option Explicit On
Imports Statline.Stattrac.Windows.CSharpUIMap
Imports Statline.Stattrac.Common
Imports Statline.Stattrac.Constant

Public Class FrmConsentInterval
    Inherits System.Windows.Forms.Form

    Public AvailableGridList As Object
    Public AvailableSortOrder As Short
    Public SelectedGridList As Object
    Public SelectedSortOrder As Short


    Dim SelectedOrganizations As New colOrganizations
    Dim AvailableOrganizations As New colOrganizations


    'bret 02/01/11 
    Private uIMap As UIMap




    Private Sub CboConsentInterval_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboConsentInterval.TextChanged

        Call modUtility.Work()

        Call SelectedOrganizations.GetItems(-1, -1, CboConsentInterval.Text)
        Call SelectedOrganizations.FillListView((Me.LstViewSelectedOrganizations))

        Call modUtility.Done()

    End Sub

    Private Sub CboConsentInterval_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboConsentInterval.SelectedIndexChanged

        Call modUtility.Work()

        Call SelectedOrganizations.GetItems(-1, -1, CboConsentInterval.Text)
        Call SelectedOrganizations.FillListView((Me.LstViewSelectedOrganizations))

        Call modUtility.Done()

    End Sub


    Private Sub CmdCancel_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdCancel.Click

        Me.Close()

    End Sub


    Private Sub CmdDeselect_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdDeselect.Click

        Dim I As Short
        Dim vInterval As Short
        Dim vResultArray As New Object

        Call modUtility.Work()

        vInterval = modConv.TextToInt(CboConsentInterval.Text)

        'Get the selected items from the available list
        For I = 1 To LstViewSelectedOrganizations.Items.Count - 1

            If LstViewSelectedOrganizations.Items.Item(I).Selected = True Then
                SelectedOrganizations.Item((LstViewSelectedOrganizations.Items.Item(I).Tag)).ConsentInterval = 0
                Call SelectedOrganizations.Item((LstViewSelectedOrganizations.Items.Item(I).Tag)).UpdateConsentInterval()
            End If

        Next I

        Call SelectedOrganizations.GetItems(-1, -1, CboConsentInterval.Text)
        Call SelectedOrganizations.FillListView((Me.LstViewSelectedOrganizations))

        Call SelectedOrganizations.GetUniqueConsentIntervals(vResultArray)
        Call modControl.SetTextID(CboConsentInterval, vResultArray)

        Call modControl.SelectText(CboConsentInterval, CStr(vInterval))

        Call modUtility.Done()

    End Sub


    Private Sub CmdFind_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdFind.Click

        Call modUtility.Work()

        Call AvailableOrganizations.GetItems(modControl.GetID(CboState), modControl.GetID(CboOrganizationType))
        Call AvailableOrganizations.FillListView((Me.LstViewAvailableOrganizations))

        Call modUtility.Done()

    End Sub

    Private Sub cmdSelect_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdSelect.Click

        Dim I As Short
        Dim vInterval As Short
        Dim vResultArray As New Object

        Call modUtility.Work()

        vInterval = modConv.TextToInt(CboConsentInterval.Text)

        'Get the selected items from the available list
        For I = 1 To LstViewAvailableOrganizations.Items.Count - 1

            If LstViewAvailableOrganizations.Items.Item(I).Selected = True Then

                'Test if the selected item already belongs to the selected list
                'If so, ignore it, if not, then add the item to the collection
                'and save the item association
                If SelectedOrganizations.Item((LstViewAvailableOrganizations.Items.Item(I).Tag)).ID = -1 Then

                    Call SelectedOrganizations.AddItem(AvailableOrganizations.Item((LstViewAvailableOrganizations.Items.Item(I).Tag)))
                    SelectedOrganizations.Item((LstViewAvailableOrganizations.Items.Item(I).Tag)).ConsentInterval = vInterval
                    Call SelectedOrganizations.Item((LstViewAvailableOrganizations.Items.Item(I).Tag)).UpdateConsentInterval()

                End If

            End If

        Next I

        Call SelectedOrganizations.GetItems(-1, -1, CboConsentInterval.Text)
        Call SelectedOrganizations.FillListView((Me.LstViewSelectedOrganizations))

        Call SelectedOrganizations.GetUniqueConsentIntervals(vResultArray)
        Call modControl.SetTextID(CboConsentInterval, vResultArray)

        Call modControl.SelectText(CboConsentInterval, CStr(vInterval))

        Call modUtility.Done()

    End Sub
    Private Sub FrmConsentInterval_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load

        Dim vResultArray As New Object

        Call modUtility.CenterForm()

        Call SelectedOrganizations.GetUniqueConsentIntervals(vResultArray)
        Call modControl.SetTextID(CboConsentInterval, vResultArray)

        '*******************************
        'Initialize 'Applies To' Information
        '*******************************

        'Initialize the available organizations grid
        Call modControl.HighlightListViewRow(LstViewAvailableOrganizations)
        Call LstViewAvailableOrganizations.Columns.Insert(0, "", "Organization", CInt(VB6.TwipsToPixelsX(2500)))
        Call LstViewAvailableOrganizations.Columns.Insert(1, "", "City", CInt(VB6.TwipsToPixelsX(1100)))
        Call LstViewAvailableOrganizations.Columns.Insert(2, "", "State", CInt(VB6.TwipsToPixelsX(550)))
        Call LstViewAvailableOrganizations.Columns.Insert(3, "", "Organization Type", CInt(VB6.TwipsToPixelsX(1800)))

        'Initialize the selected organizations grid
        Call modControl.HighlightListViewRow(LstViewSelectedOrganizations)
        Call LstViewSelectedOrganizations.Columns.Insert(0, "", "Organization", CInt(VB6.TwipsToPixelsX(2500)))
        Call LstViewSelectedOrganizations.Columns.Insert(1, "", "City", CInt(VB6.TwipsToPixelsX(1100)))
        Call LstViewSelectedOrganizations.Columns.Insert(2, "", "State", CInt(VB6.TwipsToPixelsX(550)))
        Call LstViewSelectedOrganizations.Columns.Insert(3, "", "Organization Type", CInt(VB6.TwipsToPixelsX(1800)))

        'Get the reference data
        Call modStatRefQuery.RefQueryState(CboState, , , , , True)
        Call modStatRefQuery.RefQueryOrganizationType(CboOrganizationType, , , , , True)

        'Set the default types
        Call modControl.SelectID(CboState, ALL_STATES)
        Call modControl.SelectID(CboOrganizationType, ALL_ORG_TYPES)

        Me.AvailableSortOrder = ASCENDING_ORDER

    End Sub


    Private Sub FrmConsentInterval_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing

        AppMain.frmConsentInterval = Nothing
        'Me.Dispose()

    End Sub

    Public Function Display() As Object

        Me.Show()

    End Function



    Public Function ClearAll() As Object

        'Clear on call organizations
        LstViewAvailableOrganizations.Items.Clear()
        LstViewAvailableOrganizations.View = View.Details
        LstViewSelectedOrganizations.Items.Clear()
        LstViewSelectedOrganizations.View = View.Details

    End Function


    Private Sub LstViewAvailableOrganizations_ColumnClick(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.ColumnClickEventArgs) Handles LstViewAvailableOrganizations.ColumnClick
        Dim ColumnHeader As System.Windows.Forms.ColumnHeader = LstViewAvailableOrganizations.Columns(eventArgs.Column)

        ' When a ColumnHeader object is clicked, the ListView control is
        ' sorted by the subitems of that column.
        ' Set the SortKey to the Index of the ColumnHeader - 1
        LstViewAvailableOrganizations.Sorting = Me.AvailableSortOrder
        LstViewAvailableOrganizations.ListViewItemSorter = New ListViewItemComparer(eventArgs.Column, Me.AvailableSortOrder)
        ' Set Sorted to True to sort the list.
        LstViewAvailableOrganizations.Sort()

        If Me.AvailableSortOrder = System.Windows.Forms.SortOrder.Ascending Then
            Me.AvailableSortOrder = System.Windows.Forms.SortOrder.Descending
        Else
            Me.AvailableSortOrder = System.Windows.Forms.SortOrder.Ascending
        End If

    End Sub



    Private Sub LstViewAvailableOrganizations_DoubleClick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewAvailableOrganizations.DoubleClick

        'Get the call ID
        Dim organizationId As Integer = AvailableOrganizations.Item(LstViewAvailableOrganizations.FocusedItem.Tag).ID
        If uIMap Is Nothing Then
            uIMap = OpenStatTracCSharpForms.CreateInstance()
        End If

        uIMap.Open(AppScreenType.OrganizationsOrganizationContactsContactPropertiesEditPopup, organizationId)

        LstViewAvailableOrganizations.Visible = False
        LstViewSelectedOrganizations.Visible = False
        LstViewAvailableOrganizations.Visible = True
        LstViewSelectedOrganizations.Visible = True

        Me.Activate()

    End Sub


    Private Sub LstViewSelectedOrganizations_ColumnClick(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.ColumnClickEventArgs) Handles LstViewSelectedOrganizations.ColumnClick
        Dim ColumnHeader As System.Windows.Forms.ColumnHeader = LstViewSelectedOrganizations.Columns(eventArgs.Column)

        ' When a ColumnHeader object is clicked, the ListView control is
        ' sorted by the subitems of that column.
        ' Set the SortKey to the Index of the ColumnHeader - 1
        LstViewSelectedOrganizations.Sorting = Me.SelectedSortOrder
        LstViewSelectedOrganizations.ListViewItemSorter = New ListViewItemComparer(eventArgs.Column, Me.SelectedSortOrder)
        ' Set Sorted to True to sort the list.
        LstViewSelectedOrganizations.Sort()

        If Me.SelectedSortOrder = System.Windows.Forms.SortOrder.Ascending Then
            Me.SelectedSortOrder = System.Windows.Forms.SortOrder.Descending
        Else
            Me.SelectedSortOrder = System.Windows.Forms.SortOrder.Ascending
        End If

    End Sub



    Private Sub LstViewSelectedOrganizations_DoubleClick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewSelectedOrganizations.DoubleClick

        'Get the call ID

        Dim organizationId = AvailableOrganizations.Item(LstViewAvailableOrganizations.FocusedItem.Tag).ID
        If uIMap Is Nothing Then
            uIMap = OpenStatTracCSharpForms.CreateInstance()
        End If

        uIMap.Open(AppScreenType.OrganizationsOrganizationEditPopup, organizationId)


        LstViewAvailableOrganizations.Visible = False
        LstViewSelectedOrganizations.Visible = False
        LstViewAvailableOrganizations.Visible = True
        LstViewSelectedOrganizations.Visible = True

        Me.Activate()

    End Sub

End Class