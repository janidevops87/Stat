Option Strict Off
Option Explicit On
Friend Class FrmOrganizationProperties
    Inherits System.Windows.Forms.Form

    'Form Variables
    Public OrganizationId As Integer
    Public OrganizationName As String '5/15/2004 T.T added OrganizationName
    Public Saved As Short
    Public SortOrder As Short

    Public SourceCodes As New colSourceCodes
    '03/2010 bret add frm References
    Private frmFax As FrmFax
    Private frmReferralList As FrmReferralList

    Private Sub ChkFamilyServicesLO_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkFamilyServicesLO.CheckStateChanged
        If ChkFamilyServicesLO.CheckState = 1 Then 'T.T 5/15/2004 Added to make sure LO checkbox is clicked if Triage or Family services is clicked
            ChkLeaseOrganization.CheckState = System.Windows.Forms.CheckState.Checked
        End If
    End Sub

    Private Sub ChkTriageLO_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkTriageLO.CheckStateChanged
        If ChkTriageLO.CheckState = 1 Then 'T.T 5/15/2004 Added to make sure LO checkbox is clicked if Triage or Family services is clicked
            ChkLeaseOrganization.CheckState = System.Windows.Forms.CheckState.Checked
        End If


    End Sub

    Private Sub CmdAdd_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdAdd.Click

        frmFax = New FrmFax()
        frmFax.vFaxId = 0
        frmFax.vOrganizationId = Me.OrganizationId
        frmFax.txtFaxNumber.Text = ""
        Dim result As Integer = frmFax.Display()
        Call modStatQuery.QueryOrganizationFax(Me)
        frmFax = Nothing
    End Sub

    Private Sub CmdCancel_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdCancel.Click

        Me.Close()

    End Sub

    Private Sub CmdDelete_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdDelete.Click

        If lstFaxNumbers.SelectedIndex > -1 Then
            Call modStatSave.DeleteFax(lstFaxNumbers.SelectedItems.Item(0).Value)
        End If
        lstFaxNumbers.Items.Clear()
        Call modStatQuery.QueryOrganizationFax(Me)

    End Sub

    Private Sub CmdEdit_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdEdit.Click

        If lstFaxNumbers.SelectedIndex > -1 Then
            frmFax = New FrmFax()
            frmFax.vFaxId = lstFaxNumbers.SelectedItems.Item(0).Value
            frmFax.vOrganizationId = Me.OrganizationId
            frmFax.txtFaxNumber.Text = lstFaxNumbers.Text
            frmFax.Display()
        End If

        Call modStatQuery.QueryOrganizationFax(Me)

    End Sub

    Private Sub CmdFrom_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdFrom.Click

        Dim vPhoneList As New Object
        Dim vSubLocationList As New Object

        On Error Resume Next

        TxtFrom.Tag = LstViewPhone.FocusedItem.Tag

        Call modControl.GetSelListViewItems(LstViewPhone, vPhoneList)
        If modControl.GetSelListViewSubItems(LstViewPhone, vSubLocationList) > 0 Then
            TxtFrom.Text = vPhoneList(0, 0).ToString & ",  " & vSubLocationList(0, 1).ToString
        Else
            TxtFrom.Text = vPhoneList(0, 0)
        End If

    End Sub

    Private Sub CmdListReferrals_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdListReferrals.Click

        Dim vIDs(1) As String
        Dim vTemp As New Object

        On Error Resume Next
        frmReferralList = New FrmReferralList()

        vTemp = LstViewPhone.FocusedItem.Tag

        Call modString.GetWords(vTemp, ",", vIDs)

        If UBound(vIDs, 1) = 2 Then
            frmReferralList.PhoneID = vIDs(0)
            frmReferralList.SubLocationID = vIDs(1)
            frmReferralList.SubLocationLevel = vIDs(2)
        ElseIf UBound(vIDs, 1) = 1 Then
            frmReferralList.PhoneID = vIDs(0)
            frmReferralList.SubLocationID = vIDs(1)
            frmReferralList.SubLocationLevel = -1
        Else
            frmReferralList.PhoneID = modConv.TextToLng(vIDs(0))
            frmReferralList.SubLocationID = -1
            frmReferralList.SubLocationLevel = -1
        End If

        '11/15/01 drh Change zero's to -1 since Referral's use -1 if no ID exists
        If frmReferralList.SubLocationID = 0 Then
            frmReferralList.SubLocationID = -1
        End If
        If frmReferralList.SubLocationLevel = 0 Then
            frmReferralList.SubLocationLevel = -1
        End If

        frmReferralList.Display()

    End Sub

    Private Sub CmdOK_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdOK.Click

        Dim vReturn As Short

        'Make sure the user wants to save
        vReturn = modMsgForm.FormSave

        If vReturn = MsgBoxResult.Cancel Then
            Exit Sub
        End If

        'Validate the data
        If Not modStatValidate.OrganizationProperties(Me) Then
            Exit Sub

            'added 06/2001 bjk: validate Organization CallBack number.
        Else
            'Create a new record and
            'get the ID
            Me.OrganizationId = modStatSave.SaveOrganizationProperties(Me)
            If Len(TxtPhone.Text) > 4 Then
                Call modStatSave.SaveCallBack(Me)
            End If

            Me.Saved = True

        End If



        Me.Close()

    End Sub

    Private Sub CmdReassign_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdReassign.Click

        Dim vTemp As New Object
        Dim vOldIDs(1) As String
        Dim vNewIDs(1) As String

        If TxtFrom.Text = "" Or TxtTo.Text = "" Then
            Exit Sub
        ElseIf OptTo(0).Checked = True Then
            vTemp = TxtFrom.Tag
            Call modString.GetWords(vTemp, ",", vOldIDs)

            vTemp = TxtTo.Tag
            Call modString.GetWords(vTemp, ",", vNewIDs)

            Call modStatSave.UpdateReferralPhone(vOldIDs, vNewIDs)

            'Clear the text boxes
            TxtFrom.Text = ""
            TxtTo.Text = ""

            'Clear the grid
            LstViewPhone.Items.Clear()
            LstViewPhone.View = View.Details

            'Fill Grid
            Call modStatQuery.QueryOrganizationPhone(Me)

        ElseIf OptTo(1).Checked = True Then

            vTemp = TxtFrom.Tag
            Call modString.GetWords(vTemp, ",", vOldIDs)

            ReDim vNewIDs(0)
            vNewIDs(0) = TxtTo.Tag

            Call modStatSave.UpdateReferralOrganization(vOldIDs, vNewIDs)

            'Clear the text boxes
            TxtFrom.Text = ""
            TxtTo.Text = ""

            'Clear the grid
            LstViewPhone.Items.Clear()
            LstViewPhone.View = View.Details

            'Fill Grid
            Call modStatQuery.QueryOrganizationPhone(Me)

        End If

    End Sub


    Private Sub CmdTo_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdTo.Click

        Dim vPhoneList As New Object
        Dim vSubLocationList As New Object

        On Error Resume Next
        'inialize Option array
        OptTo.Container.Add(_OptTo_0)
        OptTo.Container.Add(_OptTo_1)

        If OptTo(0).Checked = True Then
            TxtTo.Tag = LstViewPhone.FocusedItem.Tag

            Call modControl.GetSelListViewItems(LstViewPhone, vPhoneList)
            If modControl.GetSelListViewSubItems(LstViewPhone, vSubLocationList) > 0 Then
                TxtTo.Text = vPhoneList(0, 0).ToString & ",  " & vSubLocationList(0, 1).ToString
            Else
                TxtTo.Text = vPhoneList(0, 0)
            End If
        ElseIf OptTo(1).Checked = True Then
            AppMain.frmQuickLook = New FrmQuickLook()
            AppMain.frmQuickLook.CmdClose.Text = "Select"
            AppMain.frmQuickLook.CallingForm = Me.Name
            AppMain.frmQuickLook.TxtPersonFirst.Enabled = False
            AppMain.frmQuickLook.TxtPersonLast.Enabled = False
            AppMain.frmQuickLook.LstPerson.Enabled = False
            AppMain.frmQuickLook.parentForm = Me
            AppMain.frmQuickLook.Display()

        End If

    End Sub

    Private Sub FrmOrganizationProperties_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load

        On Error Resume Next
        'Get the properites for the organization
        Call modUtility.CenterForm()

        Me.Saved = False

        'Initialize the phone grid
        Call modControl.HighlightListViewRow(LstViewPhone)
        Call LstViewPhone.Columns.Insert(0, "", "Phone #", CInt(VB6.TwipsToPixelsX(1500)))
        Call LstViewPhone.Columns.Insert(1, "", "Sub-Location", CInt(VB6.TwipsToPixelsX(2000)))

        'Get the organization properties detail
        Call modStatQuery.QueryOrganizationProperties(Me)

        'Clear the grids
        LstViewPhone.Items.Clear()
        LstViewPhone.View = View.Details

        'Fill Grids
        Call modStatQuery.QueryOrganizationPhone(Me)
        Call modStatQuery.QueryOrganizationFax(Me)

        'if user is LO do nothing
        If AppMain.ParentForm.LeaseOrganization = 0 Then
            ChkFamilyServicesLO.Visible = True 'T.T 5/15/2004 added for Family services
            ChkTriageLO.Visible = True
            ChkLeaseOrganization.Visible = True 'T.T 5/15/2004 added for Triage
        Else
            ChkFamilyServicesLO.Visible = False 'T.T 5/15/2004 added for Family services
            ChkTriageLO.Visible = False
            ChkLeaseOrganization.Visible = False
        End If



        '10/15/01 drh
        Me.TabProperty.SelectedIndex = 0

        'disable Save button
        '01/17/02 bjk: added to prevent organization from being saved in Archive.
        If Connection = ARCHIVE_DATASOURCE Then
            CmdOK.Enabled = False
        End If


    End Sub





    Public Function Display() As Integer

        Me.ShowDialog()

    End Function



    Private Sub FrmOrganizationProperties_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing

        Dim vReturn As Short

        If Me.Saved = True Then
            'The message was saved so just unload
            eventArgs.Cancel = False

        Else
            'The message was cancelled or closed so confirm cancellation
            vReturn = modMsgForm.FormCancel
            If vReturn = MsgBoxResult.Yes Then
                eventArgs.Cancel = False

            Else
                eventArgs.Cancel = True
            End If
        End If

        frmFax = Nothing
        frmReferralList = Nothing


    End Sub

    Private Sub LstViewPhone_ColumnClick(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.ColumnClickEventArgs) Handles LstViewPhone.ColumnClick
        Dim ColumnHeader As System.Windows.Forms.ColumnHeader = LstViewPhone.Columns(eventArgs.Column)

        ' When a ColumnHeader object is clicked, the ListView control is
        ' sorted by the subitems of that column.
        ' Set the SortKey to the Index of the ColumnHeader - 1
        LstViewPhone.Sorting = Me.SortOrder
        LstViewPhone.ListViewItemSorter = New ListViewItemComparer(eventArgs.Column, Me.SortOrder)

        If Me.SortOrder = System.Windows.Forms.SortOrder.Ascending Then
            Me.SortOrder = System.Windows.Forms.SortOrder.Descending
        Else
            Me.SortOrder = System.Windows.Forms.SortOrder.Ascending
        End If

    End Sub

    Private Sub Text1_Change()

    End Sub

    Private Sub Text1_KeyPress(ByRef KeyAscii As Short)


    End Sub


    Private Sub txtFaxNumber_KeyPress(ByRef KeyAscii As Short)



    End Sub


    Private Sub TxtPhone_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtPhone.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)
        KeyAscii = modMask.PhoneMask(KeyAscii, ActiveControl)
        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtConsentInterval_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtConsentInterval.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        KeyAscii = modMask.NumMask(KeyAscii, 8, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtPageInterval_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtPageInterval.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        KeyAscii = modMask.NumMask(KeyAscii, 8, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub
End Class