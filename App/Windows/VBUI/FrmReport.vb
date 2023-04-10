Option Strict Off
Option Explicit On
Imports Statline.Stattrac.Windows.CSharpUIMap
Imports Statline.Stattrac.Common
Imports Statline.Stattrac.Constant

Public Class FrmReport
    Inherits System.Windows.Forms.Form

    Public FormState As Short
    Public ReportID As Integer
    Public ReportName As String
    Public ReportGroupID As Integer
    Public Saved As Short
    Public Loaded As Short

    Public AvailableGridList As Object
    Public AvailableSortOrder As Short
    Public SelectedGridList As Object
    Public SelectedSortOrder As Short

    Public SourceCodes As New colSourceCodes
    Public sourceCodeId As Integer 'made this public so it can be used by StatSave.vb

    Private frmReportGroup As FrmReportGroup

    'bret 02/01/11 
    Private uIMap As UIMap
    Private sourceCodeName As String
    Private sourceCodeCallTypeId As Integer
    Private sourceCodeCallTypeName As String

    Private Sub CboReportGroup_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboReportGroup.SelectedIndexChanged

        Call modUtility.Work()

        'Get the ID of the selected location
        Me.ReportGroupID = modControl.GetID(CboReportGroup)

        'Clear the Report and on call for lists.
        Call Me.ClearAll()

        'Fill the selected organizations grid
        Call modReport.QueryWebReportOrganization(Me)

        'Fill the source codes
        Call modStatQuery.QueryWebReportGroupSourceCode(Me)

        'Fill the access dates
        Call modStatQuery.QueryWebReportGroupAccessDate(Me)

        If Me.ReportGroupID = -1 Then
            CmdSelect.Enabled = False
            CmdDeselect.Enabled = False
            CmdAdd.Enabled = False
            CmdRemove.Enabled = False
            CmdAddAccess.Enabled = False
            CmdRemoveAccess.Enabled = False
        Else
            CmdSelect.Enabled = True
            CmdDeselect.Enabled = True
            CmdAdd.Enabled = True
            CmdRemove.Enabled = True
            CmdAddAccess.Enabled = True
            CmdRemoveAccess.Enabled = True
        End If

        Call modUtility.Done()

    End Sub

    Private Sub CboReportGroup_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles CboReportGroup.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        'Allow the delete key to clear the combo box
        Call modControl.AllowDelete(ActiveControl, KeyAscii)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub CboReportParent_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboReportParent.SelectedIndexChanged

        CboReportGroup.Items.Clear()
        Call Me.ClearAll()
        Call modStatQuery.QueryWebParentReportGroups(Me)
        modControl.SelectID(CboReportGroup, 0)

        If modControl.GetID(CboReportParent) = -1 Then
            CmdReportGroupDetail.Enabled = False
        Else
            CmdReportGroupDetail.Enabled = True
        End If

    End Sub


    Private Sub CboReportParent_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles CboReportParent.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        'Allow the delete key to clear the combo box
        Call modControl.AllowDelete(ActiveControl, KeyAscii)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub ChkBone_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkBone.CheckStateChanged
        Dim Index As Short = ChkBone.GetIndex(eventSender)

        If Me.LstViewSourceCodes.Items.Count > 0 Then
            If Index = 0 Then
                SourceCodes.Item(LstViewSourceCodes.FocusedItem.Tag).WebReportGroupAccessBone = Me.ChkBone(0).CheckState
            Else
                SourceCodes.Item(LstViewSourceCodes.FocusedItem.Tag).WebReportGroupAccessBoneUpdate = Me.ChkBone(1).CheckState
            End If
            Call modStatSave.UpdateWebReportGroupSourceCodes(Me, GetSelectedSourceCodeId())
        End If

    End Sub

    Private Sub ChkEyeOnly_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkEyeOnly.CheckStateChanged

        If Me.LstViewSourceCodes.Items.Count > 0 Then
            SourceCodes.Item(LstViewSourceCodes.FocusedItem.Tag).WebReportGroupAccessTypeEyeOnly = Me.ChkEyeOnly.CheckState
            Call modStatSave.UpdateWebReportGroupSourceCodes(Me, GetSelectedSourceCodeId())
        End If

    End Sub

    Private Sub ChkEyes_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkEyes.CheckStateChanged
        Dim Index As Short = ChkEyes.GetIndex(eventSender)

        If Me.LstViewSourceCodes.Items.Count > 0 Then
            If Index = 0 Then
                SourceCodes.Item(LstViewSourceCodes.FocusedItem.Tag).WebReportGroupAccessEyes = Me.ChkEyes(0).CheckState
            Else
                SourceCodes.Item(LstViewSourceCodes.FocusedItem.Tag).WebReportGroupAccessEyesUpdate = Me.ChkEyes(1).CheckState
            End If
            Call modStatSave.UpdateWebReportGroupSourceCodes(Me, GetSelectedSourceCodeId())
        End If

    End Sub

    Private Sub ChkHeartValves_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkHeartValves.CheckStateChanged
        Dim Index As Short = ChkHeartValves.GetIndex(eventSender)

        If Me.LstViewSourceCodes.Items.Count > 0 Then
            If Index = 0 Then
                SourceCodes.Item(LstViewSourceCodes.FocusedItem.Tag).WebReportGroupAccessValves = Me.ChkHeartValves(0).CheckState
            Else
                SourceCodes.Item(LstViewSourceCodes.FocusedItem.Tag).WebReportGroupAccessValvesUpdate = Me.ChkHeartValves(1).CheckState
            End If
            Call modStatSave.UpdateWebReportGroupSourceCodes(Me, GetSelectedSourceCodeId())
        End If

    End Sub

    Private Sub ChkOrgans_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkOrgans.CheckStateChanged
        Dim Index As Short = ChkOrgans.GetIndex(eventSender)

        If Me.LstViewSourceCodes.Items.Count > 0 Then
            If Index = 0 Then
                SourceCodes.Item(LstViewSourceCodes.FocusedItem.Tag).WebReportGroupAccessOrgans = Me.ChkOrgans(0).CheckState
            Else
                SourceCodes.Item(LstViewSourceCodes.FocusedItem.Tag).WebReportGroupAccessOrgansUpdate = Me.ChkOrgans(1).CheckState
            End If
            Call modStatSave.UpdateWebReportGroupSourceCodes(Me, GetSelectedSourceCodeId())
        End If

    End Sub

    Private Sub ChkOTE_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkOTE.CheckStateChanged

        If Me.LstViewSourceCodes.Items.Count > 0 Then
            SourceCodes.Item(LstViewSourceCodes.FocusedItem.Tag).WebReportGroupAccessTypeOTE = Me.ChkOTE.CheckState
            Call modStatSave.UpdateWebReportGroupSourceCodes(Me, GetSelectedSourceCodeId())
        End If

    End Sub


    Private Sub ChkResearch_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkResearch.CheckStateChanged
        Dim Index As Short = ChkResearch.GetIndex(eventSender)

        If Me.LstViewSourceCodes.Items.Count > 0 Then
            If Index = 0 Then
                SourceCodes.Item(LstViewSourceCodes.FocusedItem.Tag).WebReportGroupAccessResearch = Me.ChkResearch(0).CheckState
            Else
                SourceCodes.Item(LstViewSourceCodes.FocusedItem.Tag).WebReportGroupAccessResearchUpdate = Me.ChkResearch(1).CheckState
            End If
            Call modStatSave.UpdateWebReportGroupSourceCodes(Me, GetSelectedSourceCodeId())
        End If

    End Sub

    Private Sub ChkRuleout_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkRuleout.CheckStateChanged

        If Me.LstViewSourceCodes.Items.Count > 0 Then
            SourceCodes.Item(LstViewSourceCodes.FocusedItem.Tag).WebReportGroupAccessTypeRuleout = Me.ChkRuleout.CheckState
            Call modStatSave.UpdateWebReportGroupSourceCodes(Me, GetSelectedSourceCodeId())
        End If

    End Sub

    Private Sub ChkSkin_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkSkin.CheckStateChanged
        Dim Index As Short = ChkSkin.GetIndex(eventSender)

        If Me.LstViewSourceCodes.Items.Count > 0 Then
            If Index = 0 Then
                SourceCodes.Item(LstViewSourceCodes.FocusedItem.Tag).WebReportGroupAccessSkin = Me.ChkSkin(0).CheckState
            Else
                SourceCodes.Item(LstViewSourceCodes.FocusedItem.Tag).WebReportGroupAccessSkinUpdate = Me.ChkSkin(1).CheckState
            End If
            Call modStatSave.UpdateWebReportGroupSourceCodes(Me, GetSelectedSourceCodeId())
        End If

    End Sub

    Private Sub ChkSoftTissue_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkSoftTissue.CheckStateChanged
        Dim Index As Short = ChkSoftTissue.GetIndex(eventSender)

        If Me.LstViewSourceCodes.Items.Count > 0 Then
            If Index = 0 Then
                SourceCodes.Item(LstViewSourceCodes.FocusedItem.Tag).WebReportGroupAccessTissue = Me.ChkSoftTissue(0).CheckState
            Else
                SourceCodes.Item(LstViewSourceCodes.FocusedItem.Tag).WebReportGroupAccessTissueUpdate = Me.ChkSoftTissue(1).CheckState
            End If
            Call modStatSave.UpdateWebReportGroupSourceCodes(Me, GetSelectedSourceCodeId())
        End If

    End Sub

    Private Sub ChkTE_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkTE.CheckStateChanged

        If Me.LstViewSourceCodes.Items.Count > 0 Then
            SourceCodes.Item(LstViewSourceCodes.FocusedItem.Tag).WebReportGroupAccessTypeTE = Me.ChkTE.CheckState
            Call modStatSave.UpdateWebReportGroupSourceCodes(Me, GetSelectedSourceCodeId())
        End If

    End Sub

    Private Sub CmdAdd_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdAdd.Click

        If uIMap Is Nothing Then
            uIMap = OpenStatTracCSharpForms.CreateInstance()
        End If

        'ccarroll 04/18/2011 
        'Get SourceCode selection from SourceCode Popup
        Me.sourceCodeId = uIMap.Open(AppScreenType.AdministrationSourceCodeEditPopup, Me.sourceCodeCallTypeId)
        Me.sourceCodeName = GeneralConstant.CreateInstance().SourceCodeName
        Me.sourceCodeCallTypeName = GeneralConstant.CreateInstance().SourceCodeCallTypeName

        'Reset value
        If IsNothing(SourceCodes) Then
            SourceCodes = New colSourceCodes()
        End If

        Dim newSourceCode As clsSourceCode = New clsSourceCode()

        'Define new SourceCode properties
        newSourceCode.ID = Me.sourceCodeId
        newSourceCode.Key = "k" & Me.sourceCodeId
        newSourceCode.Name = Me.sourceCodeName
        newSourceCode.CodeTypeName = Me.sourceCodeCallTypeName

        'Add new SourceCode item
        SourceCodes.AddItem(newSourceCode)

        Call SourceCodes.FillListView2(LstViewSourceCodes)
        Call modStatSave.InsertWebReportGroupSourceCodes(Me)

    End Sub

    Private Sub CmdAddAccess_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdAddAccess.Click

        On Error Resume Next

        If TxtStartActive.Text <> "" And TxtEndActive.Text <> "" Then

            Call modStatSave.SaveWebReportAccessDate(Me)
            LstViewDateAccess.Items.Clear()
            Call modStatQuery.QueryWebReportGroupAccessDate(Me)
            TxtStartActive.Text = ""
            TxtEndActive.Text = ""

        End If

    End Sub


    Private Sub CmdCancel_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdCancel.Click

        Me.Close()

    End Sub

    Private Sub cmdDeleteGroup_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdDeleteGroup.Click

        Dim ConfirmDelete As Object
        Dim vText As Object

        If Me.ReportGroupID <> 0 Then
            vText = "You are about to Delete the Report Group Titled " & Chr(13) & Me.CboReportGroup.Text & Chr(13) & Chr(13) & "This process is not reversible." & Chr(13) & Chr(13) & "Are you sure you want to continue?"

            ConfirmDelete = MsgBox(vText, MsgBoxStyle.Information + MsgBoxStyle.YesNo, "Confirmation of Deletion")

            If ConfirmDelete <> MsgBoxResult.No Then
                Call modReport.DeleteWebReportGroup(Me)
            End If

            Call modStatRefQuery.ListRefQueryWebReportGroup(CboReportGroup, modControl.GetID(CboReportParent))
        End If

        Call CboReportGroup_SelectedIndexChanged(CboReportGroup, New System.EventArgs())

    End Sub

    Private Sub CmdDeselect_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdDeselect.Click

        Dim vReturn As Object

        Call modUtility.Work()

        Call modControl.GetSelListViewID(LstViewSelectedOrganizations, vReturn)

        If IsNothing(vReturn) Then
            Call modUtility.Done()
            Exit Sub
        End If

        'Remove each of the selected rows
        Call modReport.DeleteWebReportOrganizations(vReturn)

        'Remove the current list
        LstViewSelectedOrganizations.Items.Clear()
        LstViewSelectedOrganizations.View = View.Details

        'Refill the selected organizations list
        Call modReport.QueryWebReportOrganization(Me)

        Call modUtility.Done()

    End Sub


    Private Sub CmdFind_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdFind.Click

        Call modUtility.Work()

        'Clear the grid
        LstViewAvailableOrganizations.Items.Clear()
        LstViewAvailableOrganizations.View = View.Details

        'Fill Grid
        Call modStatQuery.QueryOpenOrganization(Me)

        Call modUtility.Done()

    End Sub


    Private Sub CmdRemove_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdRemove.Click

        If Me.LstViewSourceCodes.Items.Count > 0 Then

            Call modStatSave.DeleteWebReportGroupSourceCodes(Me)

            Call SourceCodes.Remove(Me.LstViewSourceCodes.FocusedItem.Tag)

            Call SourceCodes.FillListView2(LstViewSourceCodes)

        End If

    End Sub


    Private Sub CmdRemoveAccess_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdRemoveAccess.Click

        On Error Resume Next

        If LstViewDateAccess.Items.Count > 0 Then

            Call modStatSave.DeleteWebReportAccessDate(Me)
            LstViewDateAccess.Items.Clear()
            Call modStatQuery.QueryWebReportGroupAccessDate(Me)

        End If

    End Sub


    Private Sub CmdReportGroupDetail_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdReportGroupDetail.Click

        Dim vReportGroupID As Integer

        On Error Resume Next

        frmReportGroup = New FrmReportGroup()
        'Determine the state which to open the
        'form.
        If modControl.GetID(CboReportGroup) = -1 Then
            frmReportGroup.FormState = NEW_RECORD
            frmReportGroup.ReportGroupID = 0
        Else
            frmReportGroup.FormState = EXISTING_RECORD
            frmReportGroup.ReportGroupID = modControl.GetID(CboReportGroup)
        End If

        frmReportGroup.ParentOrgID = modControl.GetID(CboReportParent)

        'Get the ReportGroup id from the ReportGroup form
        'after the user is done.
        vReportGroupID = frmReportGroup.Display
        frmReportGroup = Nothing
        If vReportGroupID = 0 Then
            'The user cancelled adding a new ReportGroup
            'so do nothing
        Else
            'Refill the combo box with the new (or updated)
            'ReportGroup id and name
            CboReportGroup.Items.Clear()
            Call Me.ClearAll()
            Call modStatQuery.QueryWebParentReportGroups(Me)
            Call modControl.SelectID(CboReportGroup, vReportGroupID)
        End If

    End Sub

    Private Sub cmdSelect_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdSelect.Click

        Dim vReturn As Object

        Call modUtility.Work()

        Call modControl.GetSelListViewID(LstViewAvailableOrganizations, vReturn)

        If IsNothing(vReturn) Then
            Call modUtility.Done()
            Exit Sub
        End If

        'Insert each of the new rows in the database
        If modReport.SaveWebReportOrganizations(Me, vReturn) = SUCCESS Then

            'Remove the current list
            LstViewSelectedOrganizations.Items.Clear()
            LstViewSelectedOrganizations.View = View.Details

            'Refill the selected organizations list
            Call modReport.QueryWebReportOrganization(Me)

        End If

        Call modUtility.Done()

    End Sub


    Private Sub CmdSelectParentOrg_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdSelectParentOrg.Click

        Dim vParentOrgID As Integer
        Dim vReturn() As String

        On Error Resume Next

        'Get the ParentOrg id from the ParentOrg form
        'after the user is done.
        AppMain.frmQuickLook = New FrmQuickLook
        AppMain.frmQuickLook.CmdClose.Text = "Select"
        AppMain.frmQuickLook.CallingForm = "FrmReport"
        AppMain.frmQuickLook.TxtPersonFirst.Enabled = False
        AppMain.frmQuickLook.TxtPersonLast.Enabled = False
        AppMain.frmQuickLook.LstPerson.Enabled = False
        AppMain.frmQuickLook.parentForm = Me
        Call AppMain.frmQuickLook.Display()

    End Sub

    Private Sub CmdUnassigned_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdUnassigned.Click

        Call modUtility.Work()

        'Clear the grid
        LstViewAvailableOrganizations.Items.Clear()
        LstViewAvailableOrganizations.View = View.Details

        'Fill Grid
        Call modStatQuery.QueryUnassignedWebReportGroupOrg(Me)

        Call modUtility.Done()

    End Sub

    Private Sub FrmReport_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load

        Call modUtility.CenterForm()

        Me.Saved = False
        Me.Loaded = False

        'Fill the report list box
        Call modStatQuery.QueryWebReportParent(Me)

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


        Call modControl.HighlightListViewRow(LstViewSourceCodes)
        Call LstViewSourceCodes.Columns.Insert(0, "", "Source Code", CInt(VB6.TwipsToPixelsX(1200)))
        Call LstViewSourceCodes.Columns.Insert(1, "", "Source Type", CInt(VB6.TwipsToPixelsX(1200)))

        Call modControl.HighlightListViewRow(LstViewDateAccess)
        Call LstViewDateAccess.Columns.Insert(0, "", "Begin", CInt(VB6.TwipsToPixelsX(1200)))
        Call LstViewDateAccess.Columns.Insert(1, "", "End", CInt(VB6.TwipsToPixelsX(1200)))

        'Get the reference data
        Call modStatRefQuery.RefQueryState(CboState, , , , , True)
        Call modStatRefQuery.RefQueryOrganizationType(CboOrganizationType, , , , , True)

        'Set the default types
        Call modControl.SelectID(CboState, ALL_STATES)
        Call modControl.SelectID(CboOrganizationType, ALL_ORG_TYPES)

        Me.AvailableSortOrder = ASCENDING_ORDER

        Call Me.ClearAll()

        Me.Loaded = True

    End Sub


    Private Sub FrmReport_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing

        AppMain.frmReport = Nothing
        'Me.Dispose()

    End Sub


    Public Function Display() As Object

        Me.ShowDialog()

    End Function



    Public Function ClearAll() As Object

        'Clear on call organizations
        LstViewAvailableOrganizations.Items.Clear()
        LstViewAvailableOrganizations.View = View.Details
        LstViewSelectedOrganizations.Items.Clear()
        LstViewSelectedOrganizations.View = View.Details

        Me.LstViewSourceCodes.Items.Clear()
        Me.LstViewDateAccess.Items.Clear()

        Me.ChkOrgans(0).CheckState = System.Windows.Forms.CheckState.Unchecked
        Me.ChkBone(0).CheckState = System.Windows.Forms.CheckState.Unchecked
        Me.ChkSoftTissue(0).CheckState = System.Windows.Forms.CheckState.Unchecked
        Me.ChkSkin(0).CheckState = System.Windows.Forms.CheckState.Unchecked
        Me.ChkHeartValves(0).CheckState = System.Windows.Forms.CheckState.Unchecked
        Me.ChkEyes(0).CheckState = System.Windows.Forms.CheckState.Unchecked
        Me.ChkResearch(0).CheckState = System.Windows.Forms.CheckState.Unchecked

        Me.ChkOrgans(0).Enabled = False
        Me.ChkBone(0).Enabled = False
        Me.ChkSoftTissue(0).Enabled = False
        Me.ChkSkin(0).Enabled = False
        Me.ChkHeartValves(0).Enabled = False
        Me.ChkEyes(0).Enabled = False
        Me.ChkResearch(0).Enabled = False

        Me.ChkOrgans(1).CheckState = System.Windows.Forms.CheckState.Unchecked
        Me.ChkBone(1).CheckState = System.Windows.Forms.CheckState.Unchecked
        Me.ChkSoftTissue(1).CheckState = System.Windows.Forms.CheckState.Unchecked
        Me.ChkSkin(1).CheckState = System.Windows.Forms.CheckState.Unchecked
        Me.ChkHeartValves(1).CheckState = System.Windows.Forms.CheckState.Unchecked
        Me.ChkEyes(1).CheckState = System.Windows.Forms.CheckState.Unchecked
        Me.ChkResearch(1).CheckState = System.Windows.Forms.CheckState.Unchecked

        Me.ChkOrgans(1).Enabled = False
        Me.ChkBone(1).Enabled = False
        Me.ChkSoftTissue(1).Enabled = False
        Me.ChkSkin(1).Enabled = False
        Me.ChkHeartValves(1).Enabled = False
        Me.ChkEyes(1).Enabled = False
        Me.ChkResearch(1).Enabled = False

        Me.ChkOTE.CheckState = System.Windows.Forms.CheckState.Unchecked
        Me.ChkTE.CheckState = System.Windows.Forms.CheckState.Unchecked
        Me.ChkEyeOnly.CheckState = System.Windows.Forms.CheckState.Unchecked
        Me.ChkRuleout.CheckState = System.Windows.Forms.CheckState.Unchecked

        Me.ChkOTE.Enabled = False
        Me.ChkTE.Enabled = False
        Me.ChkEyeOnly.Enabled = False
        Me.ChkRuleout.Enabled = False

        Me.SourceCodes = Nothing

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
        Dim organizationId As Integer = modConv.TextToLng(LstViewAvailableOrganizations.FocusedItem.Tag)
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
        ' Set Sorted to True to sort the list.
        LstViewSelectedOrganizations.Sort()

        If Me.SelectedSortOrder = System.Windows.Forms.SortOrder.Ascending Then
            Me.SelectedSortOrder = System.Windows.Forms.SortOrder.Descending
        Else
            Me.SelectedSortOrder = System.Windows.Forms.SortOrder.Ascending
        End If

    End Sub



    Private Sub LstViewSourceCodes_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles LstViewSourceCodes.Click
        Dim Item As ListViewItem = LstViewSourceCodes.FocusedItem
        Dim tagObject As Object = Item.Tag

        Me.ChkOrgans(0).Enabled = True
        Me.ChkBone(0).Enabled = True
        Me.ChkSoftTissue(0).Enabled = True
        Me.ChkSkin(0).Enabled = True
        Me.ChkHeartValves(0).Enabled = True
        Me.ChkEyes(0).Enabled = True
        Me.ChkResearch(0).Enabled = True

        Me.ChkOrgans(0).CheckState = SourceCodes.Item((tagObject)).WebReportGroupAccessOrgans
        Me.ChkBone(0).CheckState = SourceCodes.Item((tagObject)).WebReportGroupAccessBone
        Me.ChkSoftTissue(0).CheckState = SourceCodes.Item((tagObject)).WebReportGroupAccessTissue
        Me.ChkSkin(0).CheckState = SourceCodes.Item((tagObject)).WebReportGroupAccessSkin
        Me.ChkHeartValves(0).CheckState = SourceCodes.Item((tagObject)).WebReportGroupAccessValves
        Me.ChkEyes(0).CheckState = SourceCodes.Item((tagObject)).WebReportGroupAccessEyes
        Me.ChkResearch(0).CheckState = SourceCodes.Item((tagObject)).WebReportGroupAccessResearch

        Me.ChkOrgans(1).Enabled = True
        Me.ChkBone(1).Enabled = True
        Me.ChkSoftTissue(1).Enabled = True
        Me.ChkSkin(1).Enabled = True
        Me.ChkHeartValves(1).Enabled = True
        Me.ChkEyes(1).Enabled = True
        Me.ChkResearch(1).Enabled = True

        Me.ChkOrgans(1).CheckState = SourceCodes.Item((tagObject)).WebReportGroupAccessOrgansUpdate
        Me.ChkBone(1).CheckState = SourceCodes.Item((tagObject)).WebReportGroupAccessBoneUpdate
        Me.ChkSoftTissue(1).CheckState = SourceCodes.Item((tagObject)).WebReportGroupAccessTissueUpdate
        Me.ChkSkin(1).CheckState = SourceCodes.Item((tagObject)).WebReportGroupAccessSkinUpdate
        Me.ChkHeartValves(1).CheckState = SourceCodes.Item((tagObject)).WebReportGroupAccessValvesUpdate
        Me.ChkEyes(1).CheckState = SourceCodes.Item((tagObject)).WebReportGroupAccessEyesUpdate
        Me.ChkResearch(1).CheckState = SourceCodes.Item((tagObject)).WebReportGroupAccessResearchUpdate

        Me.ChkOTE.Enabled = True
        Me.ChkTE.Enabled = True
        Me.ChkEyeOnly.Enabled = True
        Me.ChkRuleout.Enabled = True

        Me.ChkOTE.CheckState = SourceCodes.Item((tagObject)).WebReportGroupAccessTypeOTE
        Me.ChkTE.CheckState = SourceCodes.Item((tagObject)).WebReportGroupAccessTypeTE
        Me.ChkEyeOnly.CheckState = SourceCodes.Item((tagObject)).WebReportGroupAccessTypeEyeOnly
        Me.ChkRuleout.CheckState = SourceCodes.Item((tagObject)).WebReportGroupAccessTypeRuleout

    End Sub

    Public Function GetSelectedSourceCodeId() As Integer

        On Error Resume Next

        Dim Item As ListViewItem = LstViewSourceCodes.FocusedItem
        Dim tagObject As Object = Item.Tag

        GetSelectedSourceCodeId = SourceCodes.Item((tagObject)).ID

    End Function

    Private Sub TxtEndActive_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtEndActive.Enter
        Call modControl.HighlightText(ActiveControl)
    End Sub

    Private Sub TxtEndActive_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtEndActive.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)
        KeyAscii = modMask.DateMask2000(KeyAscii, ActiveControl)
        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtEndActive_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles TxtEndActive.Validating
        Dim Cancel As Boolean = eventArgs.Cancel

        On Error Resume Next

        If TxtStartActive.Text <> "" Then

            If Not IsDate(TxtStartActive.Text) Then
                Call MsgBox("Date is not valid.", MsgBoxStyle.Exclamation, "Validation Error")
                Cancel = True
                GoTo EventExitSub
            End If

        End If

EventExitSub:
        eventArgs.Cancel = Cancel
    End Sub

    Private Sub TxtStartActive_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtStartActive.Enter
        Call modControl.HighlightText(ActiveControl)
    End Sub


    Private Sub TxtStartActive_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtStartActive.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)
        KeyAscii = modMask.DateMask2000(KeyAscii, ActiveControl)
        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtStartActive_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles TxtStartActive.Validating
        Dim Cancel As Boolean = eventArgs.Cancel

        On Error Resume Next

        If TxtStartActive.Text <> "" Then

            If Not IsDate(TxtStartActive.Text) Then
                Call MsgBox("Date is not valid.", MsgBoxStyle.Exclamation, "Validation Error")
                Cancel = True
                GoTo EventExitSub
            End If

        End If

EventExitSub:
        eventArgs.Cancel = Cancel
    End Sub

End Class