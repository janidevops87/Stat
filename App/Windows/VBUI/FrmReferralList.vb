Option Strict Off
Option Explicit On
Friend Class FrmReferralList
    Inherits System.Windows.Forms.Form

    'Form Variables
    Dim fvOrganizationID As Integer
    Dim fvPhoneID As Integer
    Dim fvSubLocationID As Integer
    Dim fvSubLocationLevel As String
    Dim fvSortOrder As Short


    Public Property SortOrder() As Object
        Get

            SortOrder = fvSortOrder

        End Get
        Set(ByVal Value As Object)

            fvSortOrder = Value

        End Set
    End Property



    Public Property PhoneID() As Object
        Get

            PhoneID = fvPhoneID

        End Get
        Set(ByVal Value As Object)

            fvPhoneID = Value

        End Set
    End Property



    Public Property SubLocationID() As Object
        Get

            SubLocationID = fvSubLocationID

        End Get
        Set(ByVal Value As Object)

            fvSubLocationID = Value

        End Set
    End Property


    Public Property SubLocationLevel() As Object
        Get

            SubLocationLevel = fvSubLocationLevel

        End Get
        Set(ByVal Value As Object)

            fvSubLocationLevel = Value

        End Set
    End Property


    Public Property OrganizationId() As Object
        Get

            OrganizationId = fvOrganizationID

        End Get
        Set(ByVal Value As Object)

            fvOrganizationID = Value

        End Set
    End Property

    Private Sub CmdCancel_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdCancel.Click

        Me.Close()

    End Sub

    Private Sub CmdOpen_Click()

        Dim vCallID As Integer

        If LstReferralList.Items.Count = 0 Then
            Exit Sub
        End If

        Call modUtility.Work()

        'Get the call ID
        vCallID = modConv.TextToLng(LstReferralList.FocusedItem.Tag)

        If Not modUtility.ChkOpenForm("frmReferral") Then
            AppMain.frmReferral.FormState = EXISTING_RECORD
            AppMain.frmReferral.CallId = vCallID
            Call AppMain.frmReferral.Display()
        End If

        Call modUtility.Done()

    End Sub

    Private Sub FrmReferralList_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load

        'Get the properites for the organization
        Call modUtility.CenterForm()

        'Initialize the phone grid
        Call modControl.HighlightListViewRow(LstReferralList)
        Call LstReferralList.Columns.Insert(0, "", "Call #", CInt(VB6.TwipsToPixelsX(800)))
        Call LstReferralList.Columns.Insert(1, "", "Date/Time", CInt(VB6.TwipsToPixelsX(1400)))
        Call LstReferralList.Columns.Insert(2, "", "Taken By", CInt(VB6.TwipsToPixelsX(1000)))

        'Clear the grid
        LstReferralList.Items.Clear()
        LstReferralList.View = View.Details

        'Fill Grid
        Call modStatQuery.QueryReferralList(Me)

    End Sub





    Public Function Display() As Integer

        Dim dialogResult As DialogResult = Me.ShowDialog()

    End Function




    Private Sub FrmReferralList_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing

        'Dispose()

    End Sub

    Private Sub LstReferralList_ColumnClick(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.ColumnClickEventArgs) Handles LstReferralList.ColumnClick
        Dim ColumnHeader As System.Windows.Forms.ColumnHeader = LstReferralList.Columns(eventArgs.Column)

        ' When a ColumnHeader object is clicked, the ListView control is
        ' sorted by the subitems of that column.
        ' Set the SortKey to the Index of the ColumnHeader - 1
        LstReferralList.Sorting = Me.SortOrder
        LstReferralList.ListViewItemSorter = New ListViewItemComparer(eventArgs.Column, Me.SortOrder)

        If Me.SortOrder = System.Windows.Forms.SortOrder.Ascending Then
            Me.SortOrder = System.Windows.Forms.SortOrder.Descending
        Else
            Me.SortOrder = System.Windows.Forms.SortOrder.Ascending
        End If

    End Sub
End Class