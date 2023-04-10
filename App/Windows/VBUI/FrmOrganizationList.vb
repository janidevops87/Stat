Option Strict Off
Option Explicit On
Friend Class FrmOrganizationList
	Inherits System.Windows.Forms.Form
	
	'Form Variables
	Dim fvSortOrder As Short
	Dim pOrganizationList As Object
	
	
	Public Property SortOrder() As Object
		Get

            SortOrder = fvSortOrder

        End Get
        Set(ByVal Value As Object)

            fvSortOrder = Value

        End Set
    End Property




    Public Property OrganizationList() As Object
        Get

            OrganizationList = pOrganizationList

        End Get
        Set(ByVal Value As Object)

            pOrganizationList = Value

        End Set
    End Property

    Private Sub CmdCancel_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdCancel.Click

        Me.Close()

    End Sub

    Private Sub FrmOrganizationList_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load

        'Get the properites for the organization
        Call modUtility.CenterForm()

        'Initialize the phone grid
        Call LstOrganizationList.Columns.Insert(1, "", "#", CInt(VB6.TwipsToPixelsX(200)))
        Call LstOrganizationList.Columns.Insert(2, "", "Criteria Group", CInt(VB6.TwipsToPixelsX(1400)))
        Call LstOrganizationList.Columns.Insert(3, "", "Organization", CInt(VB6.TwipsToPixelsX(4000)))

        'Clear the grid
        LstOrganizationList.Items.Clear()
        LstOrganizationList.View = View.Details

        'Fill Grid
        Call modControl.SetListViewRows((Me.OrganizationList), True, LstOrganizationList, True)

    End Sub





    Public Function Display() As Integer


        Me.ShowDialog()


    End Function


    Private Sub FrmOrganizationList_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing



    End Sub

    Private Sub LstOrganizationList_ColumnClick(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.ColumnClickEventArgs) Handles LstOrganizationList.ColumnClick
        Dim ColumnHeader As System.Windows.Forms.ColumnHeader = LstOrganizationList.Columns(eventArgs.Column)

        ' When a ColumnHeader object is clicked, the ListView control is
        ' sorted by the subitems of that column.
        ' Set the SortKey to the Index of the ColumnHeader - 1
        LstOrganizationList.Sorting = Me.SortOrder

        LstOrganizationList.ListViewItemSorter = New ListViewItemComparer(eventArgs.Column, Me.SortOrder)
		' Set Sorted to True to sort the list.
		LstOrganizationList.Sort()
		
		If Me.SortOrder = System.Windows.Forms.SortOrder.Ascending Then
			Me.SortOrder = System.Windows.Forms.SortOrder.Descending
		Else
			Me.SortOrder = System.Windows.Forms.SortOrder.Ascending
		End If
		
	End Sub
End Class