Option Strict Off
Option Explicit On
Imports VB = Microsoft.VisualBasic
Imports Statline.Stattrac.Windows.CSharpUIMap
Imports Statline.Stattrac.Common
Imports Statline.Stattrac.Constant


Public Class FrmServiceLevel
    Inherits System.Windows.Forms.Form

    Public AvailableGridList As Object
    Public AvailableSortOrder As Short
    Public SelectedSortOrder As Short

    Public ServiceLevel As New clsServiceLevel

    Public SourceCodes As New colSourceCodes
    Public ApproachLevel As Short 'T.T 08/23/2006 approach level added
    Private frmListItem As New FrmListItem

    'bret 02/01/11 
    Private uIMap As UIMap
    Private sourceCodeId As Integer
    Private sourceCodeName As String
    Private sourceCodeCallTypeId As Integer
    Private sourceCodeCallTypeName As String

    Private frmServiceLevelGroup As FrmServiceLevelGroup
    'FSProj drh 5/22/02
    '*******************************************
    Private Structure tTree
        Dim TreeItemId As String
        Dim ParentId As String
        Dim DisplayText As String
        Dim Checked As Boolean
    End Structure

    Private ThisNode As System.Windows.Forms.TreeNode
    Private IgnorePassedNode As Boolean
    '*******************************************


    Public Sub ATempFunc_LoadTree()

    End Sub

    Private Function LoadTree() As Integer
        'FSProj drh 5/21/02

        Dim c As Integer
        Dim vReturn As New Object
        Dim Tree() As tTree
        'put show code below in because when a service level was changed, it defaulted to expanded jth 6/10
        tvwTree.Hide()
        'Initialize the image list
        tvwTree.ImageList = Me.ImageList1

        'Clear the tree
        tvwTree.Nodes.Clear()

        'Get the Tree data
        Call modStatQuery.QueryDataTree(Me, vReturn)

        'Populate tree
        If Not IsNothing(vReturn) Then
            'Populate User-defined type/array first for fun
            ReDim Tree(UBound(vReturn))
            For c = 0 To UBound(vReturn)
                Tree(c).TreeItemId = """" & vReturn(c, 0) & """"
                Tree(c).ParentId = """" & vReturn(c, 2) & """"
                Tree(c).DisplayText = vReturn(c, 4)
                Tree(c).Checked = IIf(vReturn(c, 6), True, False)
            Next

            For c = 0 To UBound(Tree)
                Select Case Tree(c).ParentId
                    'is this a root entry?
                    Case """"""
                        ThisNode = tvwTree.Nodes.Add(Tree(c).TreeItemId, Tree(c).DisplayText, "image_bell")
                        ThisNode.Tag = Tree(c).TreeItemId
                        'must be a child entry
                    Case Else
                        ThisNode = tvwTree.Nodes.Find(Tree(c).ParentId, True)(0).Nodes.Add(Tree(c).TreeItemId, Tree(c).DisplayText, "image_blue")
                        ThisNode.Tag = Tree(c).TreeItemId
                End Select

                'See if the item needs to be checked
                If Tree(c).Checked Then
                    'bret 04/2010 replaced this tvwTree.Nodes.Item(c).Checked = True with following 
                    ThisNode.Checked = True
                End If

                '7/10/02 drh - This was causing a problem if two letters were typed quickly in ServiceLevel drop-down (ie. duplicate key error)
                '7/10/02 drh - Left it in but commented out in case we need it later
                'DoEvents
            Next

            'if anything is loaded, select first item
            ThisNode = tvwTree.Nodes.Item(1)
            tvwTree.SelectedNode = ThisNode
            'put show code below in because when a service level was changed, it defaulted to expanded jth 6/10
            tvwTree.Show()
            tvwTree.CollapseAll()
        End If

    End Function






    Public Sub GetDonorIntentListInfo()

        '9/28/01 drh
        Call ServiceLevel.GetAssignedOrgs(Me.cmbOrganization)
        Call ServiceLevel.GetDonorIntentPeople((Me.cmbPerson), (ServiceLevel.ID))

    End Sub

    Private Sub ADD_Click()

        Me.ApproachLevel = 1

    End Sub

    Private Sub CboField_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles CboField.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)
        Dim Index As Short = CboField.GetIndex(eventSender)

        'Allow the delete key to clear the combo box
        Call modControl.AllowDelete(CboField(Index), KeyAscii)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub CboServiceLevelGroup_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboServiceLevelGroup.SelectedIndexChanged

        Call modUtility.Work()

        Call Me.ClearAll()

        Me.ServiceLevel = Nothing
        If IsNothing(ServiceLevel) Then
            ServiceLevel = New clsServiceLevel
        End If

        ServiceLevel.ID = modControl.GetID(CboServiceLevelGroup)

        If ServiceLevel.GetData = SUCCESS Then

            '9/28/01 drh
            Call Me.GetDonorIntentListInfo()

            Call Me.SetData()

            '10/5/01 drh
            If chkFax.CheckState = 0 Then
                cmbPerson.Enabled = False
                cmbOrganization.Enabled = False
                cmbFaxNumber.Enabled = False
                txtDocumentName.Enabled = False
                chkCheckRegistry.Enabled = True
            Else
                cmbPerson.Enabled = True
                cmbOrganization.Enabled = True
                cmbFaxNumber.Enabled = True
                txtDocumentName.Enabled = True
                chkCheckRegistry.Enabled = False
            End If

            '10/11/01 drh
            If rbtnIntent(1).Checked = True Then
                chkCheckRegistry.Enabled = True
            Else
                chkCheckRegistry.Enabled = False
            End If

            Call ServiceLevel.GetAssignedOrgs(Me.LstViewSelectedOrganizations)

            'Fill the source codes
            Call modStatQuery.QueryServiceLevelSourceCode(Me)

            'FSProj drh 5/20/02 - Load Data Field Tree
            Call LoadTree()

            '03/10/03 drh - Populate DSN lists
            Call ServiceLevel.GetAvailableDSNs(Me.LstViewAvailableDSN)
            Call ServiceLevel.GetSelectedDSNs(Me.LstViewSelectedDSN)

            CmdSelect.Enabled = True
            CmdDeselect.Enabled = True
        Else
            CmdSelect.Enabled = False
            CmdDeselect.Enabled = False
        End If

        Call modUtility.Done()

    End Sub




    Private Sub CboServiceLevelgroup_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles CboServiceLevelGroup.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        'Allow the delete key to clear the combo box
        Call modControl.AllowDelete(CboServiceLevelGroup, KeyAscii)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub




    Private Sub Check1_Click()

    End Sub

    Private Sub ChkApproachMethod_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkApproachMethod.CheckStateChanged

        If ChkApproachMethod.CheckState = System.Windows.Forms.CheckState.Checked Then
            Frame(11).Enabled = True
            LabelPrompt(0).Enabled = True
            LabelPrompt(1).Enabled = True
            LabelPrompt(2).Enabled = True
            LabelPrompt(3).Enabled = True
            OptOTEPrompt(0).Enabled = True
            OptOTEPrompt(1).Enabled = True
            OptTEPrompt(0).Enabled = True
            OptTEPrompt(1).Enabled = True
            OptEPrompt(0).Enabled = True
            OptEPrompt(1).Enabled = True
            OptROPrompt(0).Enabled = True
            OptROPrompt(1).Enabled = True
        Else
            Frame(11).Enabled = False
            Frame(11).Enabled = False
            LabelPrompt(0).Enabled = False
            LabelPrompt(1).Enabled = False
            LabelPrompt(2).Enabled = False
            LabelPrompt(3).Enabled = False
            OptOTEPrompt(0).Enabled = False
            OptOTEPrompt(1).Enabled = False
            OptTEPrompt(0).Enabled = False
            OptTEPrompt(1).Enabled = False
            OptEPrompt(0).Enabled = False
            OptEPrompt(1).Enabled = False
            OptROPrompt(0).Enabled = False
            OptROPrompt(1).Enabled = False
        End If

    End Sub

    Private Sub chkCheckRegistry_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles chkCheckRegistry.CheckStateChanged

        '03/11/03 drh - Validate datasource
        If Not modStatValidate.ServiceLevelDataSource(Me) Then
            chkCheckRegistry.CheckState = System.Windows.Forms.CheckState.Unchecked
        End If

    End Sub

    Private Sub ChkExcludePrevVent_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkExcludePrevVent.CheckStateChanged

        If OptPrevVent.Count = 0 Then
            Exit Sub
        End If
        If ChkExcludePrevVent.CheckState = 1 Then
            OptPrevVent(0).Enabled = False
            OptPrevVent(1).Enabled = False
        Else
            OptPrevVent(0).Enabled = True
            OptPrevVent(1).Enabled = True
        End If

    End Sub

    Private Sub chkFax_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles chkFax.CheckStateChanged

        If chkFax.CheckState = 0 Then
            cmbPerson.Enabled = False
            cmbOrganization.Enabled = False
            cmbFaxNumber.Enabled = False
            txtDocumentName.Enabled = False
        Else
            cmbPerson.Enabled = True
            cmbOrganization.Enabled = True
            cmbFaxNumber.Enabled = True
            txtDocumentName.Enabled = True
        End If

    End Sub

    Private Sub ChkWeight_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkWeight.CheckStateChanged

        If ChkWeight.CheckState = 1 Then
            LblWeightAgeLimit.Enabled = True
            TxtWeightAgeLimit.Enabled = True
        Else
            LblWeightAgeLimit.Enabled = False
            TxtWeightAgeLimit.Enabled = False
        End If

    End Sub

    Private Sub ChkAttending_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkAttending.CheckStateChanged

        If ChkAttending.CheckState = System.Windows.Forms.CheckState.Unchecked Then
            OptAttending(0).Enabled = False
            OptAttending(1).Enabled = False
            ChkAttendingPhone.Enabled = False
            ChkAttendingPhone.CheckState = System.Windows.Forms.CheckState.Unchecked
        Else
            OptAttending(0).Enabled = True
            OptAttending(1).Enabled = True
            ChkAttendingPhone.Enabled = True
            ChkAttendingPhone.CheckState = System.Windows.Forms.CheckState.Checked
        End If

    End Sub

    Private Sub ChkPhysicianInfo_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkPhysicianInfo.CheckStateChanged

        If ChkPhysicianInfo.CheckState = False Then
            ChkAttending.Enabled = False
            ChkPronouncing.Enabled = False
            ChkAttending.CheckState = System.Windows.Forms.CheckState.Unchecked
            ChkPronouncing.CheckState = System.Windows.Forms.CheckState.Unchecked
        Else
            ChkAttending.Enabled = True
            ChkPronouncing.Enabled = True
            ChkAttending.CheckState = System.Windows.Forms.CheckState.Checked
            ChkPronouncing.CheckState = System.Windows.Forms.CheckState.Checked
        End If

    End Sub

    Private Sub ChkPronouncing_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkPronouncing.CheckStateChanged
        If OptPronouncing.Count = 0 Then
            Return
        End If
        If ChkPronouncing.CheckState = System.Windows.Forms.CheckState.Unchecked Then
            OptPronouncing(0).Enabled = False
            OptPronouncing(1).Enabled = False
            ChkPronouncingPhone.Enabled = False
            ChkPronouncingPhone.CheckState = System.Windows.Forms.CheckState.Unchecked
        Else
            OptPronouncing(0).Enabled = True
            OptPronouncing(1).Enabled = True
            ChkPronouncingPhone.Enabled = True
            ChkPronouncingPhone.CheckState = System.Windows.Forms.CheckState.Checked
        End If

    End Sub

    Private Sub cmbOrganization_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmbOrganization.SelectedIndexChanged

        If Me.cmbOrganization.SelectedIndex <> -1 Then
            Me.cmbFaxNumber.Items.Clear()
            Call ServiceLevel.GetOrgFaxNumbers((Me.cmbFaxNumber), modControl.GetID(Me.cmbOrganization))
        End If

    End Sub


    Private Sub CmdAdd_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdAdd.Click
        Dim Index As Short = CmdAdd.GetIndex(eventSender)
        frmListItem = New FrmListItem()
        On Error Resume Next

        Dim vNewListID As Short
        Dim vItemName As String
        Dim test As Integer

        vItemName = modControl.GetText(CboField(Index))

        If modControl.GetID(CboField(Index)) = -1 Then

            'Add a new item
            Call frmListItem.Display(vItemName)

            'Find the last id for the list
            vNewListID = 1 + CboField(Index).Items.Count

            'Add new item to list
            CboField(Index).Items.Add(New ValueDescriptionPair(vNewListID, vItemName))
            CboField(Index).Text = vItemName

        Else

            'Modify an existing item
            Call frmListItem.Display(vItemName)
            CboField(Index).Items.RemoveAt(CboField(Index).SelectedIndex)
            CboField(Index).Items.Add(New ValueDescriptionPair(vNewListID, vItemName))
            'modControl.SetTextID(CboField(Index), vItemName)
            CboField(Index).Text = vItemName
            'VB6.SetItemString(CboField(Index), CboField(Index).SelectedIndex, vItemName)
        End If

    End Sub

    Private Sub cmdAddDSN_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdAddDSN.Click
        '03/10/03 drh - Add DSN's to the selected list

        Dim SelectedArray As New Object
        Dim I As Short

        Call modUtility.Work()

        If Me.LstViewAvailableDSN.Items.Count > 0 Then
            Call modControl.GetSelListViewID((Me.LstViewAvailableDSN), SelectedArray)
        Else
            Call modUtility.Done()
            Exit Sub
        End If

        Call modControl.SwitchListView(SelectedArray, LstViewAvailableDSN, LstViewSelectedDSN)

        Call modUtility.Done()

    End Sub

    Private Sub CmdAddSource_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdAddSource.Click

        If uIMap Is Nothing Then
            uIMap = OpenStatTracCSharpForms.CreateInstance()
        End If

        'ccarroll 04/13/2011 
        'Get SourceCode selection from SourceCode Popup
        Me.sourceCodeCallTypeId = REFERRAL
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

        Call SourceCodes.FillListView2(Me.LstViewSourceCodes)
        Call modStatSave.SaveServiceLevelSourceCodes(Me)

    End Sub


    Private Sub CmdCancel_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdCancel.Click

        Me.Close()

    End Sub






    Private Sub CmdDelete_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdDelete.Click
        Dim Index As Short = CmdDelete.GetIndex(eventSender)

        If modControl.GetID(CboField(Index)) <> -1 Then

            'Delete selected item
            Call CboField(Index).Items.RemoveAt(CboField(Index).SelectedIndex)

        End If

    End Sub

    Private Sub CmdDeselect_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdDeselect.Click

        Dim SelectedArray As New Object
        Dim I As Short

        Call modControl.GetSelListViewID(LstViewSelectedOrganizations, SelectedArray)

        If IsNothing(SelectedArray) Then
            Exit Sub
        End If

        Call modUtility.Work()

        For I = 0 To UBound(SelectedArray)
            'Remove each of the selected rows
            Call Me.ServiceLevel.DeleteOrgAssociation(SelectedArray(I, 0))

            Call modStatSave.SaveServiceLevelWorking(Me)
        Next I

        'Remove the current list
        LstViewSelectedOrganizations.Items.Clear()
        LstViewSelectedOrganizations.View = View.Details

        'Refill the selected organizations list
        Call Me.ServiceLevel.GetAssignedOrgs(LstViewSelectedOrganizations)

        Call modUtility.Done()

    End Sub

    Private Sub cmdExpandAll_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdExpandAll.Click
        Dim c As Integer
        IgnorePassedNode = True
        For c = 0 To tvwTree.Nodes.Count - 1
            'For c = 1 To tvwTree.Nodes.Count
            'tvwTree.Nodes.Item(c).EnsureVisible()
            tvwTree.Nodes.Item(c).Expand()
        Next
        IgnorePassedNode = False
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


    Private Sub CmdOK_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdOK.Click

        On Error GoTo localError

        Dim vReturn As Short
        Dim SelectedArray As Object

        'Make sure the user wants to save
        vReturn = modMsgForm.FormSave

        If vReturn = MsgBoxResult.Cancel Then
            Exit Sub
        End If

        'Validate the data
        If Not modStatValidate.ServiceLevel(Me) Then
            Exit Sub
        End If

        Call modUtility.Work()

        'Save the referral
        Me.ServiceLevel.CheckDupName = False
        Call Me.GetData()
        Call Me.ServiceLevel.Save()

        'FSProj drh 5/22/02 - Save the Secondary Data Tree
        Call SaveSecondaryDataTree(Me, tvwTree)

        '03/12/03 drh - Save Data Sources
        If LstViewSelectedDSN.Items.Count > 0 Then
            Call modControl.GetListViewRows((Me.LstViewSelectedDSN), SelectedArray)

            If Not IsNothing(SelectedArray) Then
                Call Me.ServiceLevel.SaveDSNAssociations(SelectedArray)
            End If
        End If

        'Make sure the user wants to close
        vReturn = modMsgForm.FormClose

        If vReturn = MsgBoxResult.No Then
            'Do nothing
        Else
            Me.Close()
        End If

        Call modUtility.Done()

        Exit Sub
localError:
        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        Resume Next
    End Sub

    Private Sub CmdRemove_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdRemove.Click

        If Me.LstViewSourceCodes.Items.Count > 0 Then

            Call SourceCodes.Remove(Me.LstViewSourceCodes.FocusedItem.Tag)

            Call SourceCodes.FillListView2(LstViewSourceCodes)

            Call modStatSave.SaveServiceLevelSourceCodes(Me)

        End If

    End Sub

    Private Sub cmdRemoveDSN_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdRemoveDSN.Click
        '03/10/03 drh - Remove selected DSN's

        Dim SelectedArray As New Object
        Dim I As Short

        If LstViewSelectedDSN.Items.Count > 0 Then
            Call modControl.GetSelListViewID(LstViewSelectedDSN, SelectedArray)
        Else
            Call modUtility.Done()
            Exit Sub
        End If

        If IsNothing(SelectedArray) Then
            Call modUtility.Done()
            Exit Sub
        End If

        '03/11/03 drh - Validate datasource
        If Not modStatValidate.ServiceLevelDataSource(Me, UBound(SelectedArray, 1) + 1) Then
            Call modUtility.Done()
            Exit Sub
        End If

        Call modUtility.Work()

        Call modControl.SwitchListView(SelectedArray, LstViewSelectedDSN, LstViewAvailableDSN)

        Call modUtility.Done()

    End Sub

    Private Sub cmdSelect_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdSelect.Click

        Dim SelectedArray As New Object
        Dim I As Short

        Call modUtility.Work()

        If Me.LstViewAvailableOrganizations.Items.Count > 0 Then
            Call modControl.GetSelListViewID((Me.LstViewAvailableOrganizations), SelectedArray)
        Else
            Exit Sub
        End If

        For I = 0 To UBound(SelectedArray)
            'Insert each of the new rows in the database
            Call Me.ServiceLevel.SaveOrgAssociation(SelectedArray(I, 0))

            Call modStatSave.SaveServiceLevelWorking(Me)
        Next I

        'Remove the current list
        LstViewSelectedOrganizations.Items.Clear()
        LstViewSelectedOrganizations.View = View.Details

        'Refill the selected organizations list
        Call Me.ServiceLevel.GetAssignedOrgs(LstViewSelectedOrganizations)

        Call modUtility.Done()

    End Sub

    Private Sub CmdServiceLevelGroupDetail_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdServiceLevelGroupDetail.Click

        Dim vServiceLevelGroupID As Integer

        On Error GoTo localError

        Me.ServiceLevel.ID = modControl.GetID((Me.CboServiceLevelGroup))
        If IsNothing(frmServiceLevelGroup) Then
            frmServiceLevelGroup = New FrmServiceLevelGroup()
        End If
        Call frmServiceLevelGroup.Display((Me.ServiceLevel))

        If Me.ServiceLevel.ID <> -1 Then
            'Refill the combo box with the new (or updated)
            'ServiceLevelGroup id and name

            'FSProj drh 5/2/02 - Pass in ServiceLevelStatus so we only get Working Service Levels
            Call modStatRefQuery.RefQueryServiceLevelGroup(CboServiceLevelGroup, , , , , WORKING_SERVICELEVEL)
            Call modControl.SelectID(CboServiceLevelGroup, Me.ServiceLevel.ID)
        End If

        Exit Sub

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        Resume Next

    End Sub

    Private Sub cmdTest_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdTest.Click

        On Error Resume Next

        Dim vQuery As String
        Dim I As Short
        Dim vReturn() As String
        Dim vMsg As String

        vQuery = "ABATCH_UPDATESERVICELEVEL"
        'If modODBC.Exec(vQuery, vReturn) = SUCCESS Then
        If modODBC.Exec(vQuery) = SUCCESS Then
            MsgBox("Update Complete.", MsgBoxStyle.OkOnly, "For Testing Only!!")
        Else
            MsgBox("Update Complete.", MsgBoxStyle.OkOnly, "For Testing Only!!")
            'MsgBox "There was a problem with the update.", vbOKOnly, "For Testing Only!!"
        End If

    End Sub

    Private Sub CmdUnassigned_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdUnassigned.Click

        Call modUtility.Work()

        'Clear the grid
        LstViewAvailableOrganizations.Items.Clear()
        LstViewAvailableOrganizations.View = View.Details

        'Fill Grid
        Call modStatQuery.QueryUnassignedServiceLevelOrganization(Me)

        Call modUtility.Done()

    End Sub

    Private Sub FrmServiceLevel_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load

        Call modUtility.CenterForm()
        Me.CboTriageLevel.Items.Add(New ValueDescriptionPair(0, "Vent Only"))
        Me.CboTriageLevel.Items.Add(New ValueDescriptionPair(1, "Age Only"))
        Me.CboTriageLevel.Items.Add(New ValueDescriptionPair(2, "Vent & Age"))
        Me.CboTriageLevel.Items.Add(New ValueDescriptionPair(3, "Vent, Age, & MRO"))

        'Fill the ServiceLevel list box
        'FSProj drh 5/2/02 - Pass in ServiceLevelStatus ID so we only get a list of Working Service Levels
        Call modStatRefQuery.RefQueryServiceLevelGroup(CboServiceLevelGroup, , , , , WORKING_SERVICELEVEL)

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

        '03/10/03 drh - Initialize the available dsn grid
        Call modControl.HighlightListViewRow(LstViewAvailableDSN)
        Call LstViewAvailableDSN.Columns.Insert(0, "", "DataSource Name", CInt(VB6.TwipsToPixelsX(2440)))

        '03/10/03 drh - Initialize the selected dsn grid
        Call modControl.HighlightListViewRow(LstViewSelectedDSN)
        Call LstViewSelectedDSN.Columns.Insert(0, "", "DataSource Name", CInt(VB6.TwipsToPixelsX(2440)))

        Call modControl.HighlightListViewRow(LstViewSourceCodes)
        Call LstViewSourceCodes.Columns.Insert(0, "", "Source Code", CInt(VB6.TwipsToPixelsX(1200)))
        Call LstViewSourceCodes.Columns.Insert(1, "", "Source Type", CInt(VB6.TwipsToPixelsX(1200)))

        'Get the reference data
        Call modStatRefQuery.RefQueryState(Me.CboState, , , , , True)
        Call modStatRefQuery.RefQueryOrganizationType(Me.CboOrganizationType, , , , , True)

        'Set the default types
        Call modControl.SelectID(CboState, ALL_STATES)
        Call modControl.SelectID(CboOrganizationType, ALL_ORG_TYPES)

        Me.AvailableSortOrder = System.Windows.Forms.SortOrder.Ascending

        '10/5/01 drh
        Me.TabServiceLevel.SelectedIndex = 0

    End Sub


    Private Sub FrmServiceLevel_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing

        AppMain.frmServiceLevel = Nothing
        'Me.Dispose()

    End Sub











    Public Function Display() As Object

        Me.ShowDialog()

    End Function



    Public Function ClearAll() As Object

        On Error GoTo localError

        Dim I As Short

        'Clear on call organizations
        LstViewAvailableOrganizations.Items.Clear()
        LstViewAvailableOrganizations.View = View.Details
        LstViewSelectedOrganizations.Items.Clear()
        LstViewSelectedOrganizations.View = View.Details

        '03/10/03 drh - Clear DataSources
        LstViewAvailableDSN.Items.Clear()
        LstViewAvailableDSN.View = View.Details
        LstViewSelectedDSN.Items.Clear()
        LstViewSelectedDSN.View = View.Details

        Call modControl.SelectID(CboTriageLevel, -1)
        Me.OptOTEHistory(0).Checked = True
        Me.OptTEHistory(0).Checked = True
        Me.OptEHistory(0).Checked = True
        Me.DD(0).Checked = True 'T.T 08/23/06 servicelevel for approach

        Me.ChkLastName.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkFirstName.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkRecNum.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkGender.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkAge.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkWeight.CheckState = System.Windows.Forms.CheckState.Checked
        Me.TxtWeightAgeLimit.Text = ""
        Me.ChkRace.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkVent.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkExcludePrevVent.CheckState = System.Windows.Forms.CheckState.Checked
        Me.OptPrevVent(0).Checked = True
        Me.ChkDeathDate.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkDeathTime.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkAdmitDate.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkAdmitTime.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkCOD.CheckState = System.Windows.Forms.CheckState.Checked
        Me.chkCheckRegistry.CheckState = System.Windows.Forms.CheckState.Checked

        Me.ChkCoronerInfo.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkAttending.CheckState = System.Windows.Forms.CheckState.Checked
        Me.OptAttending(0).Checked = System.Windows.Forms.CheckState.Checked
        Me.ChkPronouncing.CheckState = System.Windows.Forms.CheckState.Checked
        Me.OptPronouncing(0).Checked = System.Windows.Forms.CheckState.Checked

        'ccarroll 09/13/2011 - CCRST151
        Me.ChkPNEAllowSaveWithoutContactRequired.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkDCDPotentialMessageEnabled.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkPendingCase.CheckState = System.Windows.Forms.CheckState.Unchecked

        Me.ChkAppropriateOrgan.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkAppropriateBone.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkAppropriateTissue.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkAppropriateSkin.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkAppropriateValves.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkAppropriateEyes.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkAppropriateResearch.CheckState = System.Windows.Forms.CheckState.Checked

        Me.ChkApproachMethod.CheckState = System.Windows.Forms.CheckState.Unchecked
        Me.ChkApproachMethod.Enabled = True

        Me.OptOTEPrompt(0).Checked = True
        Me.OptTEPrompt(0).Checked = True
        Me.OptEPrompt(0).Checked = True
        Me.OptROPrompt(0).Checked = True

        Me.ChkApproachBy.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkNOKName.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkNOKRelation.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkNOKPhone.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkNOKAddress.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkNOKConsent.CheckState = System.Windows.Forms.CheckState.Checked 'T.T 8/20/2003 added consent nok
        Me.ChkNOKRegistered.CheckState = System.Windows.Forms.CheckState.Checked 'T.T 8/20/2004 added registration nok

        Me.ChkApproachOrgan.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkApproachBone.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkApproachTissue.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkApproachSkin.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkApproachValves.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkApproachEyes.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkApproachResearch.CheckState = System.Windows.Forms.CheckState.Checked

        Me.ChkConsentOrgan.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkConsentBone.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkConsentTissue.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkConsentSkin.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkConsentValves.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkConsentEyes.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkConsentResearch.CheckState = System.Windows.Forms.CheckState.Checked

        Me.ChkRecoveryOrgan.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkRecoveryBone.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkRecoveryTissue.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkRecoverySkin.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkRecoveryValves.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkRecoveryEyes.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkRecoveryResearch.CheckState = System.Windows.Forms.CheckState.Checked

        Me.ChkPrompt.CheckState = System.Windows.Forms.CheckState.Unchecked
        Me.TxtAlert(0).Text = ""
        Me.TxtAlert(1).Text = ""

        For I = 1 To 16
            Me.TxtLabel(I).Text = ""
        Next I

        For I = 9 To 16
            Me.CboField(I).Items.Clear()
            'ccarroll 04/28/2010 added to disable access 
            Me.CboField(I).Enabled = False
        Next I

        SourceCodes = Nothing
        LstViewSourceCodes.Items.Clear()

        Me.ChkSecondary.CheckState = System.Windows.Forms.CheckState.Unchecked
        Me.TxtSecondaryAlert.Text = ""
        Me.ChkSecondaryNote.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ChkHemodilution.CheckState = System.Windows.Forms.CheckState.Checked
        Me.TxtTBIPrefix.Text = ""

        Exit Function

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        Resume Next

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

        If Me.SelectedSortOrder = System.Windows.Forms.SortOrder.Ascending Then
            Me.SelectedSortOrder = System.Windows.Forms.SortOrder.Descending
        Else
            Me.SelectedSortOrder = System.Windows.Forms.SortOrder.Ascending
        End If

    End Sub



    Private Sub NDD_Click()
        Me.ApproachLevel = 2
    End Sub

    Private Sub ODD_Click()
        Me.ApproachLevel = 3
    End Sub

    Private Sub rbtnIntent_CheckedChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles rbtnIntent.CheckedChanged
        If eventSender.Checked Then
            Dim Index As Short = rbtnIntent.GetIndex(eventSender)
            If rbtnIntent(1).Checked = True Then
                chkCheckRegistry.Enabled = True
            Else
                chkCheckRegistry.Enabled = False

                '03/11/03 drh
                chkCheckRegistry.CheckState = System.Windows.Forms.CheckState.Unchecked

                '03/11/03 drh - Validate datasource
                If Not modStatValidate.ServiceLevelDataSource(Me) Then
                    rbtnIntent(1).Checked = True
                    rbtnIntent(0).Checked = False
                End If
            End If
        End If
    End Sub

    Private Sub tvwTree_AfterCollapse(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.TreeViewEventArgs) Handles tvwTree.AfterCollapse
        Dim Node As System.Windows.Forms.TreeNode = eventArgs.Node
        tvwTree.SelectedNode = Node
    End Sub


    Private Sub tvwTree_AfterExpand(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.TreeViewEventArgs) Handles tvwTree.AfterExpand
        Dim Node As System.Windows.Forms.TreeNode = eventArgs.Node
        'major kludgeworks necessary because Node is
        'unpredictable when event fires due to expansion via code
        If IgnorePassedNode Then
            tvwTree.SelectedNode = ThisNode
        Else
            tvwTree.SelectedNode = Node
        End If
    End Sub


    Private Sub tvwTree_AfterCheck(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.TreeViewEventArgs) Handles tvwTree.AfterCheck
        Dim Node As System.Windows.Forms.TreeNode = eventArgs.Node
        tvwTree.SelectedNode = Node

        If chkRecurseChecks.CheckState Then
            CheckTree((Node.Checked), Node, True)
        End If
    End Sub

    Private Sub CheckTree(ByRef CheckMode As Boolean, ByRef WhichNode As System.Windows.Forms.TreeNode, ByRef StartMode As Boolean)
        'FSProj drh 5/21/02

        'Dim'd variables will NOT retain their values between invocations of the procedure,
        'however they WILL retain their values in the CURRENT instance once the recursed
        'instances return here.
        Dim ThisChild As Integer
        Dim ChildCount As Integer
        Dim ChildNode As System.Windows.Forms.TreeNode
        'ItemCount is static because we need it to always retain the same value
        'in EACH instance of the procedure.
        Static ItemCount As Integer

        ItemCount = ItemCount '+ 1

        'set Checked property
        WhichNode.Checked = CheckMode
        ChildCount = WhichNode.GetNodeCount(False)
        If ChildCount Then
            ChildNode = WhichNode.FirstNode
            'recurse into first child
            CheckTree(CheckMode, ChildNode, False)
            'recurse into remaining children
            For ThisChild = 1 To ChildCount - 1
                ChildNode = ChildNode.NextNode
                CheckTree(CheckMode, ChildNode, False)
            Next
        End If

        'when popping out of the orignal instance
        If StartMode Then
            'lblItemCount = ItemCount
            ItemCount = 0
        End If

    End Sub


    Private Sub tvwTree_NodeClick(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.TreeNodeMouseClickEventArgs) Handles tvwTree.NodeMouseClick
        Dim Node As System.Windows.Forms.TreeNode = eventArgs.Node
        tvwTree.SelectedNode = Node
    End Sub


    Private Sub TxtLabel_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtLabel.TextChanged
        Dim Index As Short = TxtLabel.GetIndex(eventSender)

        On Error Resume Next

        If TxtLabel(Index).Text = "" And Index > 8 And CboField(Index).Items.Count = 0 Then
            If CboField.Count <> 0 Then
                CboField(Index).Enabled = False
                CmdAdd(Index).Enabled = False
                CmdDelete(Index).Enabled = False
            End If
        ElseIf TxtLabel(Index).Text <> "" And Index > 8 Then
            CboField(Index).Enabled = True
            CmdAdd(Index).Enabled = True
            CmdDelete(Index).Enabled = True
        End If

    End Sub

    Private Sub TxtLabel_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles TxtLabel.Validating
        Dim Cancel As Boolean = eventArgs.Cancel
        Dim Index As Short = TxtLabel.GetIndex(eventSender)

        On Error Resume Next

        If TxtLabel(Index).Text = "" And Index > 8 Then
            If CboField(Index).Items.Count <> 0 Then
                MsgBox("You cannont clear the field label while list items remain. Please delete list items first.", MsgBoxStyle.OkOnly, "List Items")
                Cancel = True
            End If
        End If

        eventArgs.Cancel = Cancel
    End Sub

    Private Sub txtNurseScript_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtNurseScript.TextChanged

        If Len(txtNurseScript.Text) > 255 Then
            Call MsgBox("You've exceeded the maximum allowed length for Nurse Script.", MsgBoxStyle.OkOnly, "Maximum Length Exceeded")
            txtNurseScript.Text = VB.Left(txtNurseScript.Text, 255)
        End If

    End Sub

    Private Sub TxtWeightAgeLimit_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtWeightAgeLimit.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        KeyAscii = modMask.NumMask(KeyAscii, 3, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub



    Public Sub SetData()
        '************************************************************************************
        'Name: SetData
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Sets ServiceLevel object variable values
        'Returns: Nothing
        'Params: None
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 12/9/04                          Changed by: Scott Plummer
        'Release #: 7.7.2                               Task: 312
        'Description:  Added new variable: EmailDisposition
        '====================================================================================
        '====================================================================================
        'Date Changed: 6/17/04                          Changed by: Char Chaput
        'Release #: 8.0                               Release 7.7.4
        'Description:  Added new referral screen fields. MD Phone, Brain Death Date/time,
        '              Specific COD, Patient MI
        '====================================================================================

        '************************************************************************************
        On Error GoTo localError

        Dim I As Short

        Call modControl.SelectID((Me.CboTriageLevel), ServiceLevel.TriageLevel)
        Me.OptOTEHistory(ServiceLevel.OTE_MROLevel).Checked = True
        Me.OptTEHistory(ServiceLevel.TE_MROLevel).Checked = True
        Me.OptEHistory(ServiceLevel.E_MROLevel).Checked = True
        Me.DD(ServiceLevel.ApproachLevel).Checked = True 'T.T 08/23/06 approachServiceLevel

        Me.ChkLastName.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.LastName)
        Me.ChkFirstName.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.FirstName)
        Me.ChkMI.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.NameMI)
        Me.ChkRecNum.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.RecordNum)
        Me.ChkSSN.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.SSN)
        Me.ChkGender.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.Gender)
        Me.ChkAge.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.Age)
        Me.ChkWeight.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.Weight)
        If Me.ChkWeight.CheckState Then
            Me.TxtWeightAgeLimit.Text = CStr(ServiceLevel.WeightAgeUpperLimit)
        End If
        Me.ChkRace.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.Race)
        Me.ChkVent.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.Vent)
        Me.ChkExcludePrevVent.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.ExcludePrevVent)
        Select Case ServiceLevel.PrevVentClass
            Case PREVVENT_OTE
                Me.OptPrevVent(0).Checked = True
            Case PREVVENT_TE
                Me.OptPrevVent(1).Checked = True
        End Select

        '01/06/04 mds HeartBeat
        Me.ChkHeartBeat.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.HeartBeat)

        Me.ChkDOB.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.DOB)
        Me.ChkDOBILB.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.DOBILB)
        Me.ChkDOA.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.DOA)

        Me.ChkDeathDate.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.DeathDate)
        Me.ChkDeathTime.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.DeathTime)
        Me.ChkBrainDeathDate.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.BrainDeathDate)
        Me.ChkBrainDeathTime.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.BrainDeathTime)
        Me.ChkAdmitDate.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.AdmitDate)
        Me.ChkAdmitTime.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.AdmitTime)
        'Me.ChkCOD.Value = modConv.DBTrueValueToChkValue(ServiceLevel.CauseOfDeath)
        'T.T 08/20/2007 set COD permanently to 1
        Me.ChkCOD.CheckState = modConv.DBTrueValueToChkValue(1)
        Me.ChkSpecificCOD.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.SpecificCauseofDeath)
        '10/11/01 drh Modified to "RegCheckRegistry"
        Me.chkCheckRegistry.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.RegCheckRegistry)

        Me.ChkCoronerInfo.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.CoronerInfo)

        If ServiceLevel.AttendingMD = MD_ALWAYS Or ServiceLevel.AttendingMD = MD_VENT Or ServiceLevel.PronouncingMD = MD_ALWAYS Or ServiceLevel.PronouncingMD = MD_VENT Then
            Me.ChkPhysicianInfo.CheckState = System.Windows.Forms.CheckState.Checked
        Else
            Me.ChkPhysicianInfo.CheckState = System.Windows.Forms.CheckState.Unchecked
        End If

        Select Case ServiceLevel.AttendingMD
            Case MD_NEVER
                Me.ChkAttending.CheckState = System.Windows.Forms.CheckState.Unchecked
                If ChkAttending.CheckState = System.Windows.Forms.CheckState.Unchecked Then
                    OptAttending(0).Enabled = False
                    OptAttending(1).Enabled = False
                    ChkAttendingPhone.Enabled = False
                Else
                    OptAttending(0).Enabled = True
                    OptAttending(1).Enabled = True
                    ChkAttendingPhone.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.AttendingMDPhone)
                End If
            Case MD_ALWAYS
                Me.ChkAttending.CheckState = System.Windows.Forms.CheckState.Checked
                If ChkAttending.CheckState = System.Windows.Forms.CheckState.Unchecked Then
                    OptAttending(0).Enabled = False
                    OptAttending(1).Enabled = False
                    ChkAttendingPhone.Enabled = False
                Else
                    OptAttending(0).Enabled = True
                    OptAttending(1).Enabled = True
                    ChkAttendingPhone.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.AttendingMDPhone)
                End If
                Me.OptAttending(0).Checked = True
            Case MD_VENT
                Me.ChkAttending.CheckState = System.Windows.Forms.CheckState.Checked
                If ChkAttending.CheckState = System.Windows.Forms.CheckState.Unchecked Then
                    OptAttending(0).Enabled = False
                    OptAttending(1).Enabled = False
                    ChkAttendingPhone.Enabled = False
                Else
                    OptAttending(0).Enabled = True
                    OptAttending(1).Enabled = True
                    ChkAttendingPhone.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.AttendingMDPhone)
                End If
                Me.OptAttending(1).Checked = True
        End Select

        Select Case ServiceLevel.PronouncingMD
            Case MD_NEVER
                Me.ChkPronouncing.CheckState = System.Windows.Forms.CheckState.Unchecked
                If ChkPronouncing.CheckState = System.Windows.Forms.CheckState.Unchecked Then
                    OptPronouncing(0).Enabled = False
                    OptPronouncing(1).Enabled = False
                    ChkPronouncingPhone.Enabled = False
                Else
                    OptPronouncing(0).Enabled = True
                    OptPronouncing(1).Enabled = True
                    ChkPronouncingPhone.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.PronouncingMDPhone)
                End If
            Case MD_ALWAYS
                Me.ChkPronouncing.CheckState = System.Windows.Forms.CheckState.Checked
                If ChkPronouncing.CheckState = System.Windows.Forms.CheckState.Unchecked Then
                    OptPronouncing(0).Enabled = False
                    OptPronouncing(1).Enabled = False
                    ChkPronouncingPhone.Enabled = False
                Else
                    OptPronouncing(0).Enabled = True
                    OptPronouncing(1).Enabled = True
                    ChkPronouncingPhone.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.PronouncingMDPhone)
                End If
                Me.OptPronouncing(0).Checked = True
            Case MD_VENT
                Me.ChkPronouncing.CheckState = System.Windows.Forms.CheckState.Checked
                If ChkPronouncing.CheckState = System.Windows.Forms.CheckState.Unchecked Then
                    OptPronouncing(0).Enabled = False
                    OptPronouncing(1).Enabled = False
                    ChkPronouncingPhone.Enabled = False
                Else
                    OptPronouncing(0).Enabled = True
                    OptPronouncing(1).Enabled = True
                    ChkPronouncingPhone.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.PronouncingMDPhone)
                End If
                Me.OptPronouncing(1).Checked = True
        End Select

        'ccarroll 09/13/2011 - CCRST151
        Me.ChkPNEAllowSaveWithoutContactRequired.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.PNEAllowSaveWithoutContactRequired)
        Me.ChkDCDPotentialMessageEnabled.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.DCDPotentialMessageEnabled)
        Me.ChkPendingCase.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.PendingCase)

        Me.ChkAppropriateOrgan.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.AppropriateOrgan)
        Me.ChkAppropriateBone.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.AppropriateBone)
        Me.ChkAppropriateTissue.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.AppropriateTissue)
        Me.ChkAppropriateSkin.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.AppropriateSkin)
        Me.ChkAppropriateValves.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.AppropriateValves)
        Me.ChkAppropriateEyes.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.AppropriateEyes)
        Me.ChkAppropriateResearch.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.AppropriateResearch)

        Me.ChkApproachMethod.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.ApproachMethod)

        Me.OptOTEPrompt(ServiceLevel.ApproachOTEPrompt).Checked = True
        Me.OptTEPrompt(ServiceLevel.ApproachTEPrompt).Checked = True
        Me.OptEPrompt(ServiceLevel.ApproachEPrompt).Checked = True
        Me.OptROPrompt(ServiceLevel.ApproachROPrompt).Checked = True

        Me.ChkApproachBy.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.ApproachBy)

        Me.ChkNOKName.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.NOKName)
        Me.ChkNOKRelation.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.NOKRelation)
        Me.ChkNOKPhone.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.NOKPhone)
        Me.ChkNOKAddress.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.NOKAddress)
        Me.ChkNOKConsent.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.NOKConsent) 'T.T 8/20/2004 added nok consent
        Me.ChkNOKRegistered.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.NOKRegistration) 'T.T 8/20/2004 added registration nok

        Me.ChkApproachOrgan.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.ApproachOrgan)
        Me.ChkApproachBone.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.ApproachBone)
        Me.ChkApproachTissue.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.ApproachTissue)
        Me.ChkApproachSkin.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.ApproachSkin)
        Me.ChkApproachValves.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.ApproachValves)
        Me.ChkApproachEyes.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.ApproachEyes)
        Me.ChkApproachResearch.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.ApproachResearch)

        Me.ChkConsentOrgan.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.ConsentOrgan)
        Me.ChkConsentBone.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.ConsentBone)
        Me.ChkConsentTissue.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.ConsentTissue)
        Me.ChkConsentSkin.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.ConsentSkin)
        Me.ChkConsentValves.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.ConsentValves)
        Me.ChkConsentEyes.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.ConsentEyes)
        Me.ChkConsentResearch.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.ConsentResearch)

        Me.ChkRecoveryOrgan.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.RecoveryOrgan)
        Me.ChkRecoveryBone.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.RecoveryBone)
        Me.ChkRecoveryTissue.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.RecoveryTissue)
        Me.ChkRecoverySkin.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.RecoverySkin)
        Me.ChkRecoveryValves.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.RecoveryValves)
        Me.ChkRecoveryEyes.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.RecoveryEyes)
        Me.ChkRecoveryResearch.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.RecoveryResearch)

        Me.ChkPrompt.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.CustomPromptOn)

        Me.TxtAlert(0).Text = ServiceLevel.AlertField1
        Me.TxtAlert(1).Text = ServiceLevel.AlertField2


        Me.TxtLabel(1).Text = ServiceLevel.FieldLabel1
        Me.TxtLabel(2).Text = ServiceLevel.FieldLabel2
        Me.TxtLabel(3).Text = ServiceLevel.FieldLabel3
        Me.TxtLabel(4).Text = ServiceLevel.FieldLabel4
        Me.TxtLabel(5).Text = ServiceLevel.FieldLabel5
        Me.TxtLabel(6).Text = ServiceLevel.FieldLabel6
        Me.TxtLabel(7).Text = ServiceLevel.FieldLabel7
        Me.TxtLabel(8).Text = ServiceLevel.FieldLabel8
        Me.TxtLabel(9).Text = ServiceLevel.FieldLabel9
        Me.TxtLabel(10).Text = ServiceLevel.FieldLabel10
        Me.TxtLabel(11).Text = ServiceLevel.FieldLabel11
        Me.TxtLabel(12).Text = ServiceLevel.FieldLabel12
        Me.TxtLabel(13).Text = ServiceLevel.FieldLabel13
        Me.TxtLabel(14).Text = ServiceLevel.FieldLabel14
        Me.TxtLabel(15).Text = ServiceLevel.FieldLabel15
        Me.TxtLabel(16).Text = ServiceLevel.FieldLabel16

        Call modControl.SetTextID(Me.CboField(9), (ServiceLevel.ListField9))
        Call modControl.SetTextID(Me.CboField(10), (ServiceLevel.ListField10))
        Call modControl.SetTextID(Me.CboField(11), (ServiceLevel.ListField11))
        Call modControl.SetTextID(Me.CboField(12), (ServiceLevel.ListField12))
        Call modControl.SetTextID(Me.CboField(13), (ServiceLevel.ListField13))
        Call modControl.SetTextID(Me.CboField(14), (ServiceLevel.ListField14))
        Call modControl.SetTextID(Me.CboField(15), (ServiceLevel.ListField15))
        Call modControl.SetTextID(Me.CboField(16), (ServiceLevel.ListField16))


        Me.ChkSecondary.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.SecondaryOn)
        Me.TxtSecondaryAlert.Text = ServiceLevel.SecondaryAlert
        Me.ChkSecondaryNote.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.SecondaryHistory)
        Me.ChkHemodilution.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.Hemodilution)
        Me.TxtTBIPrefix.Text = ServiceLevel.SecondaryTBIPrefix 'ccarroll 05/31/2007 StatTrac 8.4 release

        Me.txtNurseScript.Text = ServiceLevel.NurseScript
        Me.txtDocumentName.Text = ServiceLevel.DocumentName
        Me.txtRetries.Text = CStr(ServiceLevel.Retries)
        Me.chkFax.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.FaxYN)
        Call modControl.SelectID((Me.cmbOrganization), ServiceLevel.OrganizationId)
        Call modControl.SelectID((Me.cmbFaxNumber), ServiceLevel.FaxId)
        Call modControl.SelectID((Me.cmbPerson), ServiceLevel.PersonID)
        Me.rbtnIntent(modConv.DBTrueValueToChkValue(ServiceLevel.CheckRegistryMode)).Checked = True

        'drh FSMod 06/23/03
        Me.txtEyeCareReminder.Text = Me.ServiceLevel.EyeCareReminder

        'Added in conjunction with email capability.  ver. 7.7.2 12/8/04 - SAP
        Me.chkEmailDisposition.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.EmailDisposition)

        'T.T 11/13/2006 added for disable save asp
        Me.chkDisableSave.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.DisableASPSave)

        If Not ServiceLevel.AlwaysPopRegistry Then
            Me.RadioDisplayMultiple.Checked = True
        Else
            Me.RadioDisplaySearch.Checked = True
        End If

        'T.T 06/20/2007 verify sex and weight
        Me.chkVerifySex.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.VerifySex)

        Me.chkVerifyWeight.CheckState = modConv.DBTrueValueToChkValue(ServiceLevel.VerifyWeight)

        Exit Sub

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        Resume Next

    End Sub
    Public Sub GetData()
        '************************************************************************************
        'Name: GetData
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Gets ServiceLevel values from DB and populates object variables
        'Returns: Nothing
        'Params: None
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 12/9/04                          Changed by: Scott Plummer
        'Release #: 7.7.2                               Task: 312
        'Description:  Added new variable: EmailDisposition
        '====================================================================================
        '====================================================================================
        'Date Changed: 6/17/04                          Changed by: Char Chaput
        'Release #: 8.0                               Release 8.0
        'Description:  Added new referral screen fields. MD Phone, Brain Death Date/time,
        '              Specific COD, Patient MI
        '====================================================================================
        '************************************************************************************

        Dim I As Short
        Dim vListField9 As New Object
        Dim vListField10 As New Object
        Dim vListField11 As New Object
        Dim vListField12 As New Object
        Dim vListField13 As New Object
        Dim vListField14 As New Object
        Dim vListField15 As New Object
        Dim vListField16 As New Object

        On Error GoTo localError

        ServiceLevel.TriageLevel = modControl.GetID((Me.CboTriageLevel))

        For I = 0 To 2
            If Me.OptOTEHistory(I).Checked = True Then
                ServiceLevel.OTE_MROLevel = I
            End If
        Next I

        For I = 0 To 2
            If Me.OptTEHistory(I).Checked = True Then
                ServiceLevel.TE_MROLevel = I
            End If
        Next I

        For I = 0 To 2
            If Me.OptEHistory(I).Checked = True Then
                ServiceLevel.E_MROLevel = I
            End If
        Next I

        'T.T 08/23/2006 approach serviceLevel
        For I = 0 To 2
            If Me.DD(I).Checked = True Then
                ServiceLevel.ApproachLevel = I
            End If
        Next I

        ServiceLevel.LastName = modConv.ChkValueToDBTrueValue(Me.ChkLastName.CheckState)
        ServiceLevel.FirstName = modConv.ChkValueToDBTrueValue(Me.ChkFirstName.CheckState)
        ServiceLevel.NameMI = modConv.ChkValueToDBTrueValue(Me.ChkMI.CheckState)
        ServiceLevel.RecordNum = modConv.ChkValueToDBTrueValue(Me.ChkRecNum.CheckState)
        ServiceLevel.SSN = modConv.ChkValueToDBTrueValue(Me.ChkSSN.CheckState)
        ServiceLevel.Gender = modConv.ChkValueToDBTrueValue(Me.ChkGender.CheckState)
        ServiceLevel.Age = modConv.ChkValueToDBTrueValue(Me.ChkAge.CheckState)
        ServiceLevel.Weight = modConv.ChkValueToDBTrueValue(Me.ChkWeight.CheckState)

        If Me.ChkWeight.CheckState = System.Windows.Forms.CheckState.Checked Then
            ServiceLevel.WeightAgeUpperLimit = CShort(Me.TxtWeightAgeLimit.Text)
        Else
            ServiceLevel.WeightAgeUpperLimit = 0
        End If

        ServiceLevel.Race = modConv.ChkValueToDBTrueValue(Me.ChkRace.CheckState)
        ServiceLevel.Vent = modConv.ChkValueToDBTrueValue(Me.ChkVent.CheckState)
        ServiceLevel.ExcludePrevVent = modConv.ChkValueToDBTrueValue(Me.ChkExcludePrevVent.CheckState)
        If Me.OptPrevVent(0).Checked = True Then
            ServiceLevel.PrevVentClass = PREVVENT_OTE
        Else
            ServiceLevel.PrevVentClass = PREVVENT_TE
        End If

        '01/06/04 mds Heartbeat
        ServiceLevel.HeartBeat = modConv.ChkValueToDBTrueValue(Me.ChkHeartBeat.CheckState)

        ServiceLevel.DOB = modConv.ChkValueToDBTrueValue(Me.ChkDOB.CheckState)
        ServiceLevel.DOBILB = modConv.ChkValueToDBTrueValue(Me.ChkDOBILB.CheckState)
        ServiceLevel.DOA = modConv.ChkValueToDBTrueValue(Me.ChkDOA.CheckState)

        ServiceLevel.DeathDate = modConv.ChkValueToDBTrueValue(Me.ChkDeathDate.CheckState)
        ServiceLevel.DeathTime = modConv.ChkValueToDBTrueValue(Me.ChkDeathTime.CheckState)
        ServiceLevel.BrainDeathDate = modConv.ChkValueToDBTrueValue(Me.ChkBrainDeathDate.CheckState)
        ServiceLevel.BrainDeathTime = modConv.ChkValueToDBTrueValue(Me.ChkBrainDeathTime.CheckState)
        ServiceLevel.AdmitDate = modConv.ChkValueToDBTrueValue(Me.ChkAdmitDate.CheckState)
        ServiceLevel.AdmitTime = modConv.ChkValueToDBTrueValue(Me.ChkAdmitTime.CheckState)
        ServiceLevel.CauseOfDeath = modConv.ChkValueToDBTrueValue(Me.ChkCOD.CheckState)
        ServiceLevel.SpecificCauseofDeath = modConv.ChkValueToDBTrueValue(Me.ChkSpecificCOD.CheckState)

        '10/11/01 drh Modified to "RegCheckRegistry"
        ServiceLevel.RegCheckRegistry = modConv.ChkValueToDBTrueValue(Me.chkCheckRegistry.CheckState)

        ServiceLevel.CoronerInfo = modConv.ChkValueToDBTrueValue(Me.ChkCoronerInfo.CheckState)

        If ChkAttending.CheckState = System.Windows.Forms.CheckState.Checked Then
            ServiceLevel.AttendingMDPhone = modConv.ChkValueToDBTrueValue(Me.ChkAttendingPhone.CheckState)
            If Me.OptAttending(0).Checked = True Then
                ServiceLevel.AttendingMD = MD_ALWAYS
            Else
                ServiceLevel.AttendingMD = MD_VENT
            End If
        Else
            ServiceLevel.AttendingMD = MD_NEVER
        End If

        If ChkPronouncing.CheckState = System.Windows.Forms.CheckState.Checked Then
            ServiceLevel.PronouncingMDPhone = modConv.ChkValueToDBTrueValue(Me.ChkPronouncingPhone.CheckState)
            If Me.OptPronouncing(0).Checked = True Then
                ServiceLevel.PronouncingMD = MD_ALWAYS
            Else
                ServiceLevel.PronouncingMD = MD_VENT
            End If
        Else
            ServiceLevel.PronouncingMDPhone = modConv.ChkValueToDBTrueValue(Me.ChkPronouncingPhone.CheckState)
            ServiceLevel.PronouncingMD = MD_NEVER
        End If

        'ccarroll 09/13/2011 - CCRST151
        ServiceLevel.PNEAllowSaveWithoutContactRequired = modConv.ChkValueToDBTrueValue(Me.ChkPNEAllowSaveWithoutContactRequired.CheckState)
        ServiceLevel.DCDPotentialMessageEnabled = modConv.ChkValueToDBTrueValue(Me.ChkDCDPotentialMessageEnabled.CheckState)
        ServiceLevel.PendingCase = modConv.ChkValueToDBTrueValue(Me.ChkPendingCase.CheckState)

        ServiceLevel.AppropriateOrgan = modConv.ChkValueToDBTrueValue(Me.ChkAppropriateOrgan.CheckState)
        ServiceLevel.AppropriateBone = modConv.ChkValueToDBTrueValue(Me.ChkAppropriateBone.CheckState)
        ServiceLevel.AppropriateTissue = modConv.ChkValueToDBTrueValue(Me.ChkAppropriateTissue.CheckState)
        ServiceLevel.AppropriateSkin = modConv.ChkValueToDBTrueValue(Me.ChkAppropriateSkin.CheckState)
        ServiceLevel.AppropriateValves = modConv.ChkValueToDBTrueValue(Me.ChkAppropriateValves.CheckState)
        ServiceLevel.AppropriateEyes = modConv.ChkValueToDBTrueValue(Me.ChkAppropriateEyes.CheckState)
        ServiceLevel.AppropriateResearch = modConv.ChkValueToDBTrueValue(Me.ChkAppropriateResearch.CheckState)

        ServiceLevel.ApproachMethod = modConv.ChkValueToDBTrueValue(Me.ChkApproachMethod.CheckState)

        If Me.OptOTEPrompt(0).Checked = True Then
            ServiceLevel.ApproachOTEPrompt = 0
        Else
            ServiceLevel.ApproachOTEPrompt = 1
        End If

        If Me.OptTEPrompt(0).Checked = True Then
            ServiceLevel.ApproachTEPrompt = 0
        Else
            ServiceLevel.ApproachTEPrompt = 1
        End If

        If Me.OptEPrompt(0).Checked = True Then
            ServiceLevel.ApproachEPrompt = 0
        Else
            ServiceLevel.ApproachEPrompt = 1
        End If

        If Me.OptROPrompt(0).Checked = True Then
            ServiceLevel.ApproachROPrompt = 0
        Else
            ServiceLevel.ApproachROPrompt = 1
        End If

        ServiceLevel.ApproachBy = modConv.ChkValueToDBTrueValue(Me.ChkApproachBy.CheckState)

        ServiceLevel.NOKName = modConv.ChkValueToDBTrueValue(Me.ChkNOKName.CheckState)
        ServiceLevel.NOKRelation = modConv.ChkValueToDBTrueValue(Me.ChkNOKRelation.CheckState)
        ServiceLevel.NOKPhone = modConv.ChkValueToDBTrueValue(Me.ChkNOKPhone.CheckState)
        ServiceLevel.NOKAddress = modConv.ChkValueToDBTrueValue(Me.ChkNOKAddress.CheckState)
        ServiceLevel.NOKConsent = modConv.ChkValueToDBTrueValue(Me.ChkNOKConsent.CheckState) 'T.T 8/20/2004 added consent nok
        ServiceLevel.NOKRegistration = modConv.ChkValueToDBTrueValue(Me.ChkNOKRegistered.CheckState) 'T.T 8/20/2004 added registration nok



        ServiceLevel.ApproachOrgan = modConv.ChkValueToDBTrueValue(Me.ChkApproachOrgan.CheckState)
        ServiceLevel.ApproachBone = modConv.ChkValueToDBTrueValue(Me.ChkApproachBone.CheckState)
        ServiceLevel.ApproachTissue = modConv.ChkValueToDBTrueValue(Me.ChkApproachTissue.CheckState)
        ServiceLevel.ApproachSkin = modConv.ChkValueToDBTrueValue(Me.ChkApproachSkin.CheckState)
        ServiceLevel.ApproachValves = modConv.ChkValueToDBTrueValue(Me.ChkApproachValves.CheckState)
        ServiceLevel.ApproachEyes = modConv.ChkValueToDBTrueValue(Me.ChkApproachEyes.CheckState)
        ServiceLevel.ApproachResearch = modConv.ChkValueToDBTrueValue(Me.ChkApproachResearch.CheckState)

        ServiceLevel.ConsentOrgan = modConv.ChkValueToDBTrueValue(Me.ChkConsentOrgan.CheckState)
        ServiceLevel.ConsentBone = modConv.ChkValueToDBTrueValue(Me.ChkConsentBone.CheckState)
        ServiceLevel.ConsentTissue = modConv.ChkValueToDBTrueValue(Me.ChkConsentTissue.CheckState)
        ServiceLevel.ConsentSkin = modConv.ChkValueToDBTrueValue(Me.ChkConsentSkin.CheckState)
        ServiceLevel.ConsentValves = modConv.ChkValueToDBTrueValue(Me.ChkConsentValves.CheckState)
        ServiceLevel.ConsentEyes = modConv.ChkValueToDBTrueValue(Me.ChkConsentEyes.CheckState)
        ServiceLevel.ConsentResearch = modConv.ChkValueToDBTrueValue(Me.ChkConsentResearch.CheckState)

        ServiceLevel.RecoveryOrgan = modConv.ChkValueToDBTrueValue(Me.ChkRecoveryOrgan.CheckState)
        ServiceLevel.RecoveryBone = modConv.ChkValueToDBTrueValue(Me.ChkRecoveryBone.CheckState)
        ServiceLevel.RecoveryTissue = modConv.ChkValueToDBTrueValue(Me.ChkRecoveryTissue.CheckState)
        ServiceLevel.RecoverySkin = modConv.ChkValueToDBTrueValue(Me.ChkRecoverySkin.CheckState)
        ServiceLevel.RecoveryValves = modConv.ChkValueToDBTrueValue(Me.ChkRecoveryValves.CheckState)
        ServiceLevel.RecoveryEyes = modConv.ChkValueToDBTrueValue(Me.ChkRecoveryEyes.CheckState)
        ServiceLevel.RecoveryResearch = modConv.ChkValueToDBTrueValue(Me.ChkRecoveryResearch.CheckState)

        ServiceLevel.CustomPromptOn = modConv.ChkValueToDBTrueValue(Me.ChkPrompt.CheckState)

        ServiceLevel.AlertField1 = Me.TxtAlert(0).Text
        ServiceLevel.AlertField2 = Me.TxtAlert(1).Text

        ServiceLevel.FieldLabel1 = Me.TxtLabel(1).Text
        ServiceLevel.FieldLabel2 = Me.TxtLabel(2).Text
        ServiceLevel.FieldLabel3 = Me.TxtLabel(3).Text
        ServiceLevel.FieldLabel4 = Me.TxtLabel(4).Text
        ServiceLevel.FieldLabel5 = Me.TxtLabel(5).Text
        ServiceLevel.FieldLabel6 = Me.TxtLabel(6).Text
        ServiceLevel.FieldLabel7 = Me.TxtLabel(7).Text
        ServiceLevel.FieldLabel8 = Me.TxtLabel(8).Text
        ServiceLevel.FieldLabel9 = Me.TxtLabel(9).Text
        ServiceLevel.FieldLabel10 = Me.TxtLabel(10).Text
        ServiceLevel.FieldLabel11 = Me.TxtLabel(11).Text
        ServiceLevel.FieldLabel12 = Me.TxtLabel(12).Text
        ServiceLevel.FieldLabel13 = Me.TxtLabel(13).Text
        ServiceLevel.FieldLabel14 = Me.TxtLabel(14).Text
        ServiceLevel.FieldLabel15 = Me.TxtLabel(15).Text
        ServiceLevel.FieldLabel16 = Me.TxtLabel(16).Text

        'Put the list data into arrays
        Call modControl.GetListTextID(Me.CboField(9), vListField9)
        Call modControl.GetListTextID(Me.CboField(10), vListField10)
        Call modControl.GetListTextID(Me.CboField(11), vListField11)
        Call modControl.GetListTextID(Me.CboField(12), vListField12)
        Call modControl.GetListTextID(Me.CboField(13), vListField13)
        Call modControl.GetListTextID(Me.CboField(14), vListField14)
        Call modControl.GetListTextID(Me.CboField(15), vListField15)
        Call modControl.GetListTextID(Me.CboField(16), vListField16)

        ServiceLevel.ListField9 = vListField9
        ServiceLevel.ListField10 = vListField10
        ServiceLevel.ListField11 = vListField11
        ServiceLevel.ListField12 = vListField12
        ServiceLevel.ListField13 = vListField13
        ServiceLevel.ListField14 = vListField14
        ServiceLevel.ListField15 = vListField15
        ServiceLevel.ListField16 = vListField16

        'Get the secondary data
        ServiceLevel.SecondaryOn = modConv.ChkValueToDBTrueValue(Me.ChkSecondary.CheckState)
        ServiceLevel.SecondaryAlert = Me.TxtSecondaryAlert.Text
        ServiceLevel.SecondaryHistory = modConv.ChkValueToDBTrueValue(Me.ChkSecondaryNote.CheckState)
        ServiceLevel.Hemodilution = modConv.ChkValueToDBTrueValue(Me.ChkHemodilution.CheckState)
        ServiceLevel.SecondaryTBIPrefix = modConv.NullToText(Me.TxtTBIPrefix.Text) 'ccarrroll 05/31/2007 StatTrac 8.4 release

        '10/11/01 drh
        ServiceLevel.FaxYN = modConv.ChkValueToDBTrueValue(Me.chkFax.CheckState)
        ServiceLevel.NurseScript = Me.txtNurseScript.Text
        ServiceLevel.OrganizationId = modControl.GetID((Me.cmbOrganization))
        ServiceLevel.FaxId = modControl.GetID((Me.cmbFaxNumber))
        ServiceLevel.PersonID = modControl.GetID((Me.cmbPerson))
        ServiceLevel.Retries = CShort(Me.txtRetries.Text)
        ServiceLevel.DocumentName = Me.txtDocumentName.Text

        '10/11/01 drh
        If Me.rbtnIntent(1).Checked = True Then
            ServiceLevel.CheckRegistryMode = CheckRegistryMode.NoRegistry

        Else
            ServiceLevel.CheckRegistryMode = CheckRegistryMode.DonorIntent
        End If

        'drh FSMod 06/23/03
        ServiceLevel.EyeCareReminder = Me.txtEyeCareReminder.Text

        'Added in conjunction with Email capability.  ver. 7.7.2 12/8/04 - SAP
        ServiceLevel.EmailDisposition = modConv.ChkValueToDBTrueValue(Me.chkEmailDisposition.CheckState)

        'T.T 11/13/2006 added disable save asp
        ServiceLevel.DisableASPSave = modConv.ChkValueToDBTrueValue(Me.chkDisableSave.CheckState)

        'T.T 05/17/2007 added always pop registry
        ServiceLevel.AlwaysPopRegistry = Me.RadioDisplaySearch.Checked

        'T.T 7/02/2007 added verify sex and weight
        ServiceLevel.VerifySex = modConv.ChkValueToDBTrueValue(Me.chkVerifySex.CheckState)

        ServiceLevel.VerifyWeight = modConv.ChkValueToDBTrueValue(Me.chkVerifyWeight.CheckState)

        Exit Sub

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        Resume Next

    End Sub

    Private Sub _OptOTEHistory_2_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles _OptOTEHistory_2.CheckedChanged

    End Sub

    Private Sub CboServiceLevelGroup_Leave(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles CboServiceLevelGroup.Leave
        Call CboServiceLevelGroup_SelectedIndexChanged(CboServiceLevelGroup, New System.EventArgs())
    End Sub
End Class