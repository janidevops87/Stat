Option Strict Off
Option Explicit On
Imports VB = Microsoft.VisualBasic
Imports Statline.Stattrac.Windows.CSharpUIMap
Imports Statline.Stattrac.Common
Imports Statline.Stattrac.Constant

Public Class FrmSourceCode
    Inherits System.Windows.Forms.Form

    Public AvailableGridList As Object
    Public AvailableSortOrder As Short
    Public SelectedGridList As Object
    Public SelectedSortOrder As Short
    Public SourceCodeID As Object


    Dim SourceCodes As New colSourceCodes
    Dim SelectedSourceCodes As New colSourceCodes

    Dim AvailableOrganizations As New colOrganizations

    'bret 02/01/11 
    Private uIMap As UIMap

    'ccarroll 12/09/2010 - Moved CboSourceCode_SelectedIndexChanged to CboSourceCode_SelectedValueChanged


    Private Sub CboSourceCode_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles CboSourceCode.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        'Allow the delete key to clear the combo box
        Call modControl.AllowDelete(CboSourceCode, KeyAscii)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub CboType_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboType.SelectedIndexChanged

        'Fill the list box
        Call SourceCodes.GetItems(modControl.GetID(CboType))
        Call SourceCodes.FillListBox(CboSourceCode)

        Call CboSourceCode_SelectedValueChanged(CboSourceCode, New System.EventArgs())
        modControl.SelectID(CboSourceCode, 0)

    End Sub




    Private Sub CmdCancel_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdCancel.Click

        Me.Close()

    End Sub






    Private Sub CmdDelete_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdDelete.Click
        Call modStatSave.DeleteTxCenter(Me, (Me.SourceCodeID), (Me.LstViewTxCenter.FocusedItem).Text)
        Call modStatQuery.QuerySourceCodeTxCenter(Me, (Me.SourceCodeID))
    End Sub

    Private Sub cmdDeleteGroup_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdDeleteGroup.Click

        Dim ConfirmDelete As New Object
        Dim vText As New Object
        Dim SourceCode As New clsSourceCode

        SourceCode = SourceCodes.Item("k" & modControl.GetID(CboSourceCode))

        If SourceCode.ID <> -1 Then

            vText = "You are about to Delete the group titled: " & Chr(13) & SourceCode.Name & Chr(13) & Chr(13) & "Are you sure you want to continue?"

            ConfirmDelete = MsgBox(vText, MsgBoxStyle.Information + MsgBoxStyle.YesNo, "Confirmation of Deletion")

            If ConfirmDelete <> MsgBoxResult.No Then
                Call SourceCode.Delete()
            End If

            'Refill the list
            Call SourceCodes.GetItems(modControl.GetID(CboType))
            Call SourceCodes.FillListBox(CboSourceCode)

            Call CboSourceCode_SelectedValueChanged(CboSourceCode, New System.EventArgs())

        End If

    End Sub

    Private Sub CmdDeselect_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdDeselect.Click

        Dim vReturn As New Object
        Dim SourceCode As New clsSourceCode
        Dim SelectedOrganizations As New colOrganizations
        Dim NewOrganization As New clsOrganization
        Dim I As Short

        Call modUtility.Work()


        'Get the selected object
        SourceCode = SourceCodes.Item("k" & modControl.GetID(CboSourceCode))


        'Get the selected items from the available list
        For I = 0 To LstViewSelectedOrganizations.Items.Count - 1

            If Me.LstViewSelectedOrganizations.Items.Item(I).Selected = True Then
                Call SourceCode.Organizations.Item((Me.LstViewSelectedOrganizations.Items.Item(I).Tag)).Delete()
            End If

        Next I


        Call SourceCode.Organizations.GetItems()
        Call SourceCode.Organizations.FillListView((Me.LstViewSelectedOrganizations))


        Call modUtility.Done()

    End Sub


    Private Sub CmdFind_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdFind.Click

        Call modUtility.Work()

        Call AvailableOrganizations.GetItems(modControl.GetID(CboState), modControl.GetID(CboOrganizationType))
        Call AvailableOrganizations.FillListView((Me.LstViewAvailableOrganizations))

        Call modUtility.Done()

    End Sub

    Private Sub CmdFrom_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdFrom.Click

        Dim I As Short

        For I = 1 To 7
            TxtFrom(I).Text = TxtFrom(2).Text
        Next I

    End Sub

    Private Sub cmdSave_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdSave.Click
        '************************************************************************************
        'Name: cmdSave_Click
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Saves SourceCode variables from form to DB
        'Returns: None
        'Params: None
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 12/8/04                          Changed by: Scott Plummer
        'Release #: 7.7.2                               Task: 312
        'Description:  Save new variable, NameUnAbbrev, to SourceCode object
        '====================================================================================
        '************************************************************************************
        On Error Resume Next


        If CmdSave.Text = "&Select" Then
            Call SelectedSourceCodes.AddItem(SourceCodes.Item("k" & modControl.GetID(CboSourceCode)))
            Me.Close()
            Exit Sub
        End If


        Call modUtility.Work()

        Dim SourceCode As New clsSourceCode
        Dim vReturn As Short

        SourceCode = SourceCodes.Item("k" & modControl.GetID(CboSourceCode))

        'Set the values of the object to the values of the form
        SourceCode.Name = TxtName.Text
        'T.T 01/07/2005 removes string extension from sourcecode Name
        If SourceCode.SourceCodeRotationTrue = -1 Then
            SourceCode.Name = VB.Left(SourceCode.Name, InStr(1, SourceCode.Name, SourceCode.SourceCodeRotationAlias) - 1)
        End If
        SourceCode.Description = TxtNote.Text
        SourceCode.DefaultAlert = TxtAlerts(0).Text
        SourceCode.LineCheckInstructions = TxtLineCheck.Text
        SourceCode.LineCheckInterval = CInt(TxtLineCheckInterval.Text)

        SourceCode.LineActiveStart1 = Me.TxtFrom(1).Text
        SourceCode.LineActiveStart2 = Me.TxtFrom(2).Text
        SourceCode.LineActiveStart3 = Me.TxtFrom(3).Text
        SourceCode.LineActiveStart4 = Me.TxtFrom(4).Text
        SourceCode.LineActiveStart5 = Me.TxtFrom(5).Text
        SourceCode.LineActiveStart6 = Me.TxtFrom(6).Text
        SourceCode.LineActiveStart7 = Me.TxtFrom(7).Text

        SourceCode.LineActiveEnd1 = Me.TxtTo(1).Text
        SourceCode.LineActiveEnd2 = Me.TxtTo(2).Text
        SourceCode.LineActiveEnd3 = Me.TxtTo(3).Text
        SourceCode.LineActiveEnd4 = Me.TxtTo(4).Text
        SourceCode.LineActiveEnd5 = Me.TxtTo(5).Text
        SourceCode.LineActiveEnd6 = Me.TxtTo(6).Text
        SourceCode.LineActiveEnd7 = Me.TxtTo(7).Text
        'Added for 7.7.2 to allow display of entire, unabbreviated
        'Source Code name.  12/8/04 - SAP
        SourceCode.NameUnAbbrev = Me.txtNameUnAbbrev.Text
        SourceCode.SourcecodeDonorTracClient = modConv.ChkValueToDBTrueValue(Me.ChkDonorTracClient.CheckState)
        'Save the item
        Call SourceCode.Save()

        'Make sure the user wants to close
        vReturn = modMsgForm.FormClose

        If vReturn = MsgBoxResult.Yes Then
            Me.Close()
        End If

        Call modUtility.Done()

    End Sub

    Private Sub CmdSourceCodeDetail_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdSourceCodeDetail.Click

        On Error Resume Next

        AppMain.frmSourceCodeGroup = New FrmSourceCodeGroup
        Dim SourceCode As New clsSourceCode

        'Get the selected object
        SourceCode = SourceCodes.Item("k" & modControl.GetID(CboSourceCode))

        'If the object is new, then set the type property
        If SourceCode.ID = -1 Then
            SourceCode.CodeType = modControl.GetID(CboType)
        End If

        Call AppMain.frmSourceCodeGroup.Display(SourceCode)

        'Refill the list
        Call SourceCodes.GetItems(modControl.GetID(CboType))
        Call SourceCodes.FillListBox(CboSourceCode)

        Call modControl.SelectID(CboSourceCode, SourceCode.ID)

    End Sub

    Private Sub cmdSelect_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdSelect.Click

        Dim vReturn As New Object
        Dim SourceCode As New clsSourceCode
        Dim SelectedOrganizations As New colOrganizations
        Dim NewOrganization As New clsOrganization
        Dim I As Short

        Call modUtility.Work()

        'Get the selected object
        SourceCode = SourceCodes.Item("k" & modControl.GetID(CboSourceCode))


        'Get the selected items from the available list
        For I = 0 To LstViewAvailableOrganizations.Items.Count - 1

            If LstViewAvailableOrganizations.Items.Item(I).Selected = True Then

                If VB.Left(LstViewAvailableOrganizations.Items.Item(I).Tag, 1) <> "k" Then

                    'Test if the selected item already belongs to the selected list
                    'If so, ignore it, if not, then add the item to the collection
                    'and save the item association
                    If SourceCode.Organizations.Item("k" & LstViewAvailableOrganizations.Items.Item(I).Tag).ID = -1 Then

                        NewOrganization.ID = LstViewAvailableOrganizations.Items.Item(I).Tag
                        NewOrganization.Key = "k" & NewOrganization.ID
                        Call SourceCode.Organizations.AddItem(NewOrganization)
                        Call SourceCode.Organizations.Item((NewOrganization.Key)).Save()
                        NewOrganization = Nothing
                    End If

                Else

                    'Test if the selected item already belongs to the selected list
                    'If so, ignore it, if not, then add the item to the collection
                    'and save the item association
                    If SourceCode.Organizations.Item((LstViewAvailableOrganizations.Items.Item(I).Tag)).ID = -1 Then

                        Call SourceCode.Organizations.AddItem(AvailableOrganizations.Item((LstViewAvailableOrganizations.Items.Item(I).Tag)))
                        Call SourceCode.Organizations.Item((LstViewAvailableOrganizations.Items.Item(I).Tag)).Save()

                    End If

                End If

            End If

        Next I

        Call SourceCode.Organizations.GetItems()
        Call SourceCode.Organizations.FillListView((Me.LstViewSelectedOrganizations))

        Call modUtility.Done()

    End Sub









    Private Sub CmdTo_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdTo.Click

        Dim I As Short

        For I = 1 To 7
            TxtTo(I).Text = TxtTo(2).Text
        Next I

    End Sub

    Private Sub cmdTxAdd_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdTxAdd.Click
        On Error Resume Next

        If Me.cboTcOrganizations.Text = "" Then
            MsgBox("Please choose an organization")
            Exit Sub
        End If

        If Me.TxCenterCode.Text = "" Then
            MsgBox("Please enter a TransplantCenter code. ")
            Exit Sub
        End If

        Call modStatSave.SaveTxCenter(Me, (Me.SourceCodeID), modControl.GetID(cboTcOrganizations), (Me.TxCenterCode.Text))
        Call modStatQuery.QuerySourceCodeTxCenter(Me, (Me.SourceCodeID))
        Me.TxCenterCode.Text = ""
    End Sub

    Private Sub CmdUnassigned_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdUnassigned.Click

        Call modUtility.Work()

        'Clear the grid
        LstViewAvailableOrganizations.Items.Clear()
        LstViewAvailableOrganizations.View = View.Details

        'Fill Grid
        Call modStatQuery.QueryUnassignedSourceCodeOrganization(Me)

        Call modUtility.Done()

    End Sub

    Private Sub FrmSourceCode_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load

        Call modUtility.CenterForm()

        Call modControl.SelectFirst(CboType)

        Me.CboType.Items.Add(New ValueDescriptionPair(REFERRAL, "Referrals"))
        Me.CboType.Items.Add(New ValueDescriptionPair(Message, "Messages"))
        Me.CboType.Items.Add(New ValueDescriptionPair(IMPORT, "Imports"))
        Me.CboType.Items.Add(New ValueDescriptionPair(INFORMATION_Renamed, "Information"))

        'ccarroll 04/12/2010 added to match old StatTrac
        Me.CboType.SelectedIndex = Me.CboType.FindString("Referrals")

        'check TxtFrom Array
        'Check lable array
        'Check txtTo array

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

        'T.T 1/05/2005 initialize the values
        Me.txtRotateExt.Enabled = False
        Me.chkRotating.Enabled = True



    End Sub


    Private Sub FrmSourceCode_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing

        AppMain.frmSourceCode = Nothing
        'Me.Dispose()

    End Sub












    Public Function Display(Optional ByRef pvrSourceCodes As colSourceCodes = Nothing) As Object

        SelectedSourceCodes = pvrSourceCodes

        Dim dialogResult As DialogResult = Me.ShowDialog()
        Return dialogResult
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

        uIMap.Open(AppScreenType.OrganizationsOrganizationEditPopup, organizationId)

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

        If Me.SelectedSortOrder = System.Windows.Forms.SortOrder.Ascending Then
            Me.SelectedSortOrder = System.Windows.Forms.SortOrder.Descending
        Else
            Me.SelectedSortOrder = System.Windows.Forms.SortOrder.Ascending
        End If

    End Sub



    Private Sub LstViewSelectedOrganizations_DoubleClick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewSelectedOrganizations.DoubleClick

        'Get the call ID
        Dim organizationId As Integer = SourceCodes.Item("k" & modControl.GetID(CboSourceCode)).Organizations.Item(LstViewSelectedOrganizations.FocusedItem.Tag).ID
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


    Private Sub TxtFrom_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtFrom.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)
        Dim Index As Short = TxtFrom.GetIndex(eventSender)

        KeyAscii = modMask.TimeMask(KeyAscii, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtLineCheckInterval_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtLineCheckInterval.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        KeyAscii = modMask.NumMask(KeyAscii, 8, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtLineCheckInterval_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtLineCheckInterval.Leave

        Dim I As Short

        If CDbl(TxtLineCheckInterval.Text) = 0 Or TxtLineCheckInterval.Text = "" Then

            'Clear and disable the acitivity period controls
            For I = 1 To 7
                TxtFrom(I).Text = ""
                TxtFrom(I).Enabled = False
                TxtTo(I).Text = ""
                TxtTo(I).Enabled = False
            Next I

            For I = 14 To 34
                Lable(I).Enabled = False
            Next I

            CmdFrom.Enabled = False
            CmdTo.Enabled = False

        Else

            'Clear and disable the acitivity period controls
            For I = 1 To 7
                TxtFrom(I).Enabled = True
                TxtTo(I).Enabled = True
            Next I

            For I = 14 To 34
                Lable(I).Enabled = True
            Next I

            CmdFrom.Enabled = True
            CmdTo.Enabled = True

        End If

    End Sub

    Private Sub TxtTo_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtTo.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)
        Dim Index As Short = TxtTo.GetIndex(eventSender)

        KeyAscii = modMask.TimeMask(KeyAscii, ActiveControl)
        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub



    Private Sub CboSourceCode_SelectedValueChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles CboSourceCode.SelectedValueChanged
        'Name: CboSourceCode_Click
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Saves SourceCode variables from form to DB
        'Returns: None
        'Params: None
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 12/8/04                          Changed by: Scott Plummer
        'Release #: 7.7.2                               Task: 312
        'Description:  Retrieve new variable, NameUnAbbrev, from SourceCode object
        '====================================================================================
        '************************************************************************************

        Dim SourceCode As New clsSourceCode


        Call modUtility.Work()

        'Get the selected object
        SourceCode = SourceCodes.Item("k" & modControl.GetID(CboSourceCode))

        Call SourceCode.Organizations.GetItems()

        Call SourceCode.Organizations.FillListView((Me.LstViewSelectedOrganizations))

        'Set the form fields to the values of the object
        Me.TxtName.Text = SourceCode.Name
        Me.TxtNote.Text = SourceCode.Description
        Me.TxtAlerts(0).Text = SourceCode.DefaultAlert
        Me.TxtLineCheck.Text = SourceCode.LineCheckInstructions
        Me.TxtLineCheckInterval.Text = CStr(SourceCode.LineCheckInterval)

        Me.TxtFrom(1).Text = SourceCode.LineActiveStart1
        Me.TxtFrom(2).Text = SourceCode.LineActiveStart2
        Me.TxtFrom(3).Text = SourceCode.LineActiveStart3
        Me.TxtFrom(4).Text = SourceCode.LineActiveStart4
        Me.TxtFrom(5).Text = SourceCode.LineActiveStart5
        Me.TxtFrom(6).Text = SourceCode.LineActiveStart6
        Me.TxtFrom(7).Text = SourceCode.LineActiveStart7

        Me.TxtTo(1).Text = SourceCode.LineActiveEnd1
        Me.TxtTo(2).Text = SourceCode.LineActiveEnd2
        Me.TxtTo(3).Text = SourceCode.LineActiveEnd3
        Me.TxtTo(4).Text = SourceCode.LineActiveEnd4
        Me.TxtTo(5).Text = SourceCode.LineActiveEnd5
        Me.TxtTo(6).Text = SourceCode.LineActiveEnd6
        Me.TxtTo(7).Text = SourceCode.LineActiveEnd7
        Me.txtRotateExt.Text = SourceCode.SourceCodeRotationAlias
        Me.chkRotating.CheckState = modConv.DBTrueValueToChkValue(SourceCode.SourceCodeRotationTrue)
        'Added for 7.7.2 to allow display of entire, unabbreviated
        'Source Code name.  12/8/04 - SAP
        Me.txtNameUnAbbrev.Text = SourceCode.NameUnAbbrev

        'T.T 01/22/2007 added donortrac client tracking
        Me.ChkDonorTracClient.CheckState = modConv.DBTrueValueToChkValue(SourceCode.SourcecodeDonorTracClient)

        Call TxtLineCheckInterval_Leave(TxtLineCheckInterval, New System.EventArgs())

        Call modUtility.Done()

        'T.T 04/15/2007 fill cboBox for Organizations TxCenter
        If SourceCode.ID <> -1 Then

            'Clear items
            Me.cboTcOrganizations.Items.Clear()
            Me.LstViewTxCenter.Items.Clear()

            Me.SourceCodeID = SourceCode.ID

            Call modStatQuery.QuerySourceCodeOrganizations(Me, (Me.SourceCodeID))

            'column headers for lstViewTxCenter
            Call modControl.HighlightListViewRow(LstViewTxCenter)
            Call LstViewTxCenter.Columns.Insert(0, "", "TxCenter", CInt(VB6.TwipsToPixelsX(1200)))
            Call LstViewTxCenter.Columns.Insert(1, "", "Organization", CInt(VB6.TwipsToPixelsX(2000)))

            Call modStatQuery.QuerySourceCodeTxCenter(Me, (Me.SourceCodeID))

        End If
    End Sub

    Private Sub CboSourceCode_Leave(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles CboSourceCode.Leave

        Call CboSourceCode_SelectedValueChanged(CboSourceCode, New System.EventArgs())

    End Sub
End Class