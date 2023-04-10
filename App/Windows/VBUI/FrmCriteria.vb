Option Strict Off
Option Explicit On
Imports VB = Microsoft.VisualBasic
Imports Statline.Stattrac.Windows.CSharpUIMap
Imports Statline.Stattrac.Common
Imports Statline.Stattrac.Constant

Public Class FrmCriteria
    Inherits System.Windows.Forms.Form

    Public FormState As Short
    Public CriteriaID As Integer
    Public DonorCategoryID As Integer
    Public DonorCategoryName As String
    Public CriteriaGroupID As Integer
    'T.T 08/19/2005 DonorTrac criteria map
    Public CriteriaDonorTracID As Integer
    Public ReferralOrganizationID As Integer
    Public Saved As Short
    Public Loaded As Short
    'FSProj drh 4/29/02 - Added CriteriaStatusID&
    Public CriteriaStatusID As Integer
    'FSProj drh 5/17/02 - (Fix) Switch variable to handle Schedule Group updates
    Public vUpdateScheduleGroupValue As Boolean

    Public AvailableGridList As Object
    Public AvailableSortOrder As Short
    Public SelectedGridList As Object
    Public SelectedSortOrder As Short
    Public IndicationList As Object
    Public IndicationSortOrder As Short

    'FSProj drh 6/30/02
    Public CurrentSubCriteriaId As Integer

    Public SourceCodes As New colSourceCodes
    Public SourceCode As clsSourceCode

    '3/2010 bret add form references
    Private frmConditional As FrmConditional
    Private frmDynamicDonorCategory As FrmDynamicDonorCategory
    Private frmCriteriaTemplate As FrmCriteriaTemplate
    Private frmCriteriaGroup As FrmCriteriaGroup
    Private frmSubtype As FrmSubtype
    'bret 02/01/11 
    Private uIMap As UIMap
    Private sourceCodeId As Integer
    Private sourceCodeName As String
    Private sourceCodeCallTypeId As Integer
    Private sourceCodeCallTypeName As String

    Private frmIndication As FrmIndication

    'bret 04/14/2010
    Private _LstViewSubtypeProcessorsButton As Integer

    Public Property LstViewSubtypeProcessorsButton() As Integer
        Get
            Return _LstViewSubtypeProcessorsButton
        End Get
        Set(ByVal value As Integer)
            _LstViewSubtypeProcessorsButton = value
        End Set
    End Property
    Private Sub CboDonorCategory_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboDonorCategory.SelectedIndexChanged

        Dim vReturn As New Object

        'Get the ID of the selected location
        Me.DonorCategoryID = modControl.GetID(CboDonorCategory)

        'Clear the Criteria and on call for lists.
        Call Me.ClearAll()

        'Fill the criteria group list
        If Me.ReferralOrganizationID = 0 Then
            CboCriteriaGroup.Items.Clear()

            'FSProj drh 4/29/02 - Pass Criteria Status so the Working Criteria will be used
            Call modStatRefQuery.RefQueryCriteriaGroup(vReturn, , , Me.DonorCategoryID, CriteriaStatusID)
            Call modControl.SetTextID(CboCriteriaGroup, vReturn)
            'reset Criteria Group value
            Call modControl.SelectID(CboCriteriaGroup, 0)

        End If

        If Me.DonorCategoryID = 0 Then
            Pic(1).Visible = True
            Pic(0).Visible = False
        Else
            Pic(1).Visible = False
            Pic(0).Visible = True
        End If


    End Sub



    Private Sub CboDonorCategory_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles CboDonorCategory.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        'Allow the delete key to clear the combo box
        Call modControl.AllowDelete(CboDonorCategory, KeyAscii)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub CboCriteriaGroup_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboCriteriaGroup.SelectedIndexChanged

        Call modUtility.Work()

        Call Me.ClearAll()

        'FSProj drh 5/17/02 - Clear all SubCriteria items
        Call Me.ClearAllSub()

        'Get the ID of the selected location
        Me.CriteriaGroupID = modControl.GetID(CboCriteriaGroup)

        If Me.CriteriaGroupID = -1 Then
            CmdSelect.Enabled = False
            CmdDeselect.Enabled = False
            CmdIndicationAdd.Enabled = False
            CmdIndicationRemove.Enabled = False

            'FSProj drh 5/8/02 - Disable Subtype and Processor buttons
            cmdSubtype.Enabled = False
            cmdAddSubtype.Enabled = False
            cmdRemoveSubtype.Enabled = False
            cmdAddProcessor.Enabled = False
            cmdRemoveProcessor.Enabled = False
            cmdNewTemplate.Enabled = False
        Else
            CmdSelect.Enabled = True
            CmdDeselect.Enabled = True
            CmdIndicationAdd.Enabled = True
            CmdIndicationRemove.Enabled = True

            'FSProj drh 5/8/02 - Enable Subtype and Processor buttons
            cmdSubtype.Enabled = True
            cmdAddSubtype.Enabled = True
            cmdRemoveSubtype.Enabled = True
            cmdAddProcessor.Enabled = True
            cmdRemoveProcessor.Enabled = True
            cmdNewTemplate.Enabled = True
        End If
        Call modUtility.Done()
        Call modUtility.Work()
        Call Me.GetCriteria()
        Call modUtility.Done()

    End Sub

    Private Sub CboCriteriaGroup_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles CboCriteriaGroup.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        'Allow the delete key to clear the combo box
        Call modControl.AllowDelete(CboCriteriaGroup, KeyAscii)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub
    Private Sub CboCriteriaGroup_DropDown(ByVal sender As Object, ByVal e As System.EventArgs) Handles CboCriteriaGroup.DropDown
        RemoveHandler CboCriteriaGroup.SelectedIndexChanged, AddressOf CboCriteriaGroup_SelectedIndexChanged
    End Sub

    Private Sub CboCriteriaGroup_DropDownClosed(ByVal sender As Object, ByVal e As System.EventArgs) Handles CboCriteriaGroup.DropDownClosed
        AddHandler CboCriteriaGroup.SelectedIndexChanged, AddressOf CboCriteriaGroup_SelectedIndexChanged
    End Sub


    Private Sub CboOrganization_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboOrganization.SelectedIndexChanged

        Dim vReturn As New Object

        Call modControl.SelectNone(CboScheduleGroup)

        If modStatRefQuery.RefQueryScheduleGroup(vReturn, , , modControl.GetID(CboOrganization)) = SUCCESS Then

            Call modControl.SetTextID(CboScheduleGroup, vReturn)

            'If there is only one item, select and display it.
            If UBound(vReturn, 1) = 0 Then
                Call modControl.SelectFirst(CboScheduleGroup)
            End If

        End If

    End Sub


    Private Sub cboOrganizationSub_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cboOrganizationSub.SelectedIndexChanged

        Dim vReturn As New Object

        Call modControl.SelectNone(cboScheduleGroupSub)

        If modStatRefQuery.RefQueryScheduleGroup(vReturn, , , modControl.GetID(cboOrganizationSub)) = SUCCESS Then

            Call modControl.SetTextID(cboScheduleGroupSub, vReturn)

            'If there is only one item, select and display it.
            If UBound(vReturn, 1) = 0 Then
                Call modControl.SelectFirst(cboScheduleGroupSub)
            End If

        End If

    End Sub


    Private Sub cboProcessorOrganizationType_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cboProcessorOrganizationType.SelectedIndexChanged

        LstViewAvailableProcessors.Items.Clear()
        LstViewAvailableProcessors.View = View.Details

    End Sub


    Private Sub cboProcessorState_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cboProcessorState.SelectedIndexChanged

        LstViewAvailableProcessors.Items.Clear()
        LstViewAvailableProcessors.View = View.Details

    End Sub


    Private Sub cboSubtypeProcessor_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cboSubtypeProcessor.SelectedIndexChanged
        Dim Index As Short = cboSubtypeProcessor.GetIndex(eventSender)

        If Index = 0 Then

            'FSProj drh 5/15/02 - Clear SubCriteria items
            ChkNotAppropriateMaleSub.CheckState = System.Windows.Forms.CheckState.Unchecked
            ChkNotAppropriateFemaleSub.CheckState = System.Windows.Forms.CheckState.Unchecked
            TxtMaleUpperSub.Text = ""
            TxtMaleLowerSub.Text = ""
            TxtFemaleUpperSub.Text = ""
            TxtFemaleLowerSub.Text = ""
            TxtUpperWeightSub.Text = ""
            TxtLowerWeightSub.Text = ""
            TxtFemaleUpperWeightSub.Text = ""
            TxtFemaleLowerWeightSub.Text = ""
            TxtGeneralRuleoutSub.Text = ""
            ChkReferNonPotentialSub.CheckState = System.Windows.Forms.CheckState.Unchecked

            'FSProj drh 5/15/02 - Clear Conditionals list
            LstViewConditionals.Items.Clear()
            LstViewConditionals.View = View.Details

            'Fill the Criteria info
            Call modStatQuery.QuerySubCriteria(Me)
            Call modStatQuery.QuerySubCriteriaConditional(Me)

        Else
            'FSProj drh 5/17/02 - Turn off the click event code temporarily
            vUpdateScheduleGroupValue = False

            'FSProj drh 5/17/02 - Clear SubCriteria Schedule Group items
            Me.ChkOrgansSub.CheckState = System.Windows.Forms.CheckState.Unchecked
            Me.ChkBoneSub.CheckState = System.Windows.Forms.CheckState.Unchecked
            Me.ChkSoftTissueSub.CheckState = System.Windows.Forms.CheckState.Unchecked
            Me.ChkSkinSub.CheckState = System.Windows.Forms.CheckState.Unchecked
            Me.ChkHeartValvesSub.CheckState = System.Windows.Forms.CheckState.Unchecked
            Me.ChkEyesSub.CheckState = System.Windows.Forms.CheckState.Unchecked
            Me.ChkResearchSub.CheckState = System.Windows.Forms.CheckState.Unchecked
            Me.ChkNoContactOnDenySub.CheckState = System.Windows.Forms.CheckState.Unchecked
            Me.ChkContactOnConsentSub.CheckState = System.Windows.Forms.CheckState.Unchecked
            Me.ChkContactOnHospitalConsentSub.CheckState = System.Windows.Forms.CheckState.Unchecked
            Me.ChkContactOnCoronerSub.CheckState = System.Windows.Forms.CheckState.Unchecked
            Me.chkCoronerOnlySub.CheckState = System.Windows.Forms.CheckState.Unchecked
            Me.ChkContactOnStatlineSecondarySub.CheckState = System.Windows.Forms.CheckState.Unchecked
            Me.ChkContactOnStatlineConsentSub.CheckState = System.Windows.Forms.CheckState.Unchecked

            'FSProj drh 5/17/02 - Turns the click event code back on
            vUpdateScheduleGroupValue = True

            'FSProj drh 5/17/02 - Disable SubCriteria Schedule Group items
            ChkOrgansSub.Enabled = False
            ChkBoneSub.Enabled = False
            ChkSoftTissueSub.Enabled = False
            ChkSkinSub.Enabled = False
            ChkHeartValvesSub.Enabled = False
            ChkEyesSub.Enabled = False
            ChkResearchSub.Enabled = False
            ChkContactOnConsentSub.Enabled = False
            ChkNoContactOnDenySub.Enabled = False
            ChkContactOnHospitalConsentSub.Enabled = False
            ChkContactOnCoronerSub.Enabled = False
            chkCoronerOnlySub.Enabled = False
            ChkContactOnStatlineSecondarySub.Enabled = False
            ChkContactOnStatlineConsentSub.Enabled = False

            'Code for getting/displaying Schedule Group info
            LstViewScheduleSub.Enabled = True
            LstViewScheduleSub.Items.Clear()
            LstViewScheduleSub.View = View.Details
            Call modStatQuery.QuerySubCriteriaScheduleGroup(Me)
        End If


    End Sub


    Private Sub ChkBone_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkBone.CheckStateChanged

        On Error Resume Next

        'FSProj drh 5/1/02 - Added IF statement so we only save when editing
        If Me.CriteriaStatusID = WORKING_CRITERIA And vUpdateScheduleGroupValue Then
            If Me.LstViewSchedule.Items.Count > 0 Then
                Call modStatSave.UpdateCriteriaScheduleGroupOption(modControl.GetID(CboCriteriaGroup), modConv.TextToLng(LstViewSchedule.FocusedItem.Tag), BONE, ChkBone.CheckState)
            End If
        End If

    End Sub

    Private Sub ChkBoneSub_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkBoneSub.CheckStateChanged
        'FSProj drh 5/17/02

        On Error Resume Next

        If Me.CriteriaStatusID = WORKING_CRITERIA And vUpdateScheduleGroupValue Then
            If Me.LstViewScheduleSub.Items.Count > 0 Then
                Call modStatSave.UpdateSubCriteriaScheduleGroupOption(modControl.GetID(cboSubtypeProcessor(1)), modConv.TextToLng(LstViewScheduleSub.FocusedItem.Tag), BONE, ChkBoneSub.CheckState)
            End If
        End If

    End Sub

    Private Sub ChkContactOnConsentSub_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkContactOnConsentSub.CheckStateChanged
        'FSProj drh 5/17/02

        On Error Resume Next

        If Me.CriteriaStatusID = WORKING_CRITERIA And vUpdateScheduleGroupValue Then
            If Me.LstViewScheduleSub.Items.Count > 0 Then
                Call modStatSave.UpdateSubCriteriaScheduleGroupOption(modControl.GetID(cboSubtypeProcessor(1)), modConv.TextToLng(LstViewScheduleSub.FocusedItem.Tag), CONTACT_ON_CONSENT, ChkContactOnConsentSub.CheckState)
            End If
        End If

    End Sub

    Private Sub ChkContactOnCoronerSub_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkContactOnCoronerSub.CheckStateChanged
        'FSProj drh 5/17/02

        On Error Resume Next

        If Me.CriteriaStatusID = WORKING_CRITERIA And vUpdateScheduleGroupValue Then
            If Me.LstViewScheduleSub.Items.Count > 0 Then
                Call modStatSave.UpdateSubCriteriaScheduleGroupOption(modControl.GetID(cboSubtypeProcessor(1)), modConv.TextToLng(LstViewScheduleSub.FocusedItem.Tag), CONTACT_ON_CORONER, ChkContactOnCoronerSub.CheckState)
            End If
        End If

    End Sub


    Private Sub ChkContactOnHospitalConsent_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkContactOnHospitalConsent.CheckStateChanged

        On Error Resume Next

        'FSProj drh 5/1/02 - Added IF statement so we only save when editing
        If Me.CriteriaStatusID = WORKING_CRITERIA And vUpdateScheduleGroupValue Then
            If Me.LstViewSchedule.Items.Count > 0 Then
                Call modStatSave.UpdateCriteriaScheduleGroupOption(modControl.GetID(CboCriteriaGroup), modConv.TextToLng(LstViewSchedule.FocusedItem.Tag), CONTACT_ON_APPROACH, ChkContactOnHospitalConsent.CheckState)
            End If
        End If


    End Sub

    Private Sub ChkContactOnConsent_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkContactOnConsent.CheckStateChanged

        On Error Resume Next

        'FSProj drh 5/1/02 - Added IF statement so we only save when editing
        If Me.CriteriaStatusID = WORKING_CRITERIA And vUpdateScheduleGroupValue Then
            If Me.LstViewSchedule.Items.Count > 0 Then
                Call modStatSave.UpdateCriteriaScheduleGroupOption(modControl.GetID(CboCriteriaGroup), modConv.TextToLng(LstViewSchedule.FocusedItem.Tag), CONTACT_ON_CONSENT, ChkContactOnConsent.CheckState)
            End If
        End If

    End Sub

    Private Sub ChkContactOnCoroner_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkContactOnCoroner.CheckStateChanged

        On Error Resume Next

        'FSProj drh 5/1/02 - Added IF statement so we only save when editing
        If Me.CriteriaStatusID = WORKING_CRITERIA And vUpdateScheduleGroupValue Then
            If Me.LstViewSchedule.Items.Count > 0 Then
                Call modStatSave.UpdateCriteriaScheduleGroupOption(modControl.GetID(CboCriteriaGroup), modConv.TextToLng(LstViewSchedule.FocusedItem.Tag), CONTACT_ON_CORONER, ChkContactOnCoroner.CheckState)
            End If
        End If

    End Sub

    Private Sub ChkContactOnHospitalConsentSub_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkContactOnHospitalConsentSub.CheckStateChanged
        'FSProj drh 5/17/02

        On Error Resume Next

        If Me.CriteriaStatusID = WORKING_CRITERIA And vUpdateScheduleGroupValue Then
            If Me.LstViewScheduleSub.Items.Count > 0 Then
                Call modStatSave.UpdateSubCriteriaScheduleGroupOption(modControl.GetID(cboSubtypeProcessor(1)), modConv.TextToLng(LstViewScheduleSub.FocusedItem.Tag), CONTACT_ON_APPROACH, ChkContactOnHospitalConsentSub.CheckState)
            End If
        End If

    End Sub

    Private Sub ChkContactOnStatlineConsent_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkContactOnStatlineConsent.CheckStateChanged

        On Error Resume Next

        'FSProj drh 5/1/02 - Added IF statement so we only save when editing
        If Me.CriteriaStatusID = WORKING_CRITERIA And vUpdateScheduleGroupValue Then
            If Me.LstViewSchedule.Items.Count > 0 Then
                Call modStatSave.UpdateCriteriaScheduleGroupOption(modControl.GetID(CboCriteriaGroup), modConv.TextToLng(LstViewSchedule.FocusedItem.Tag), CONTACT_ON_STATLINE_CONSENT, ChkContactOnStatlineConsent.CheckState)
            End If
        End If

    End Sub

    Private Sub ChkContactOnStatlineConsentSub_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkContactOnStatlineConsentSub.CheckStateChanged
        'FSProj drh 5/17/02

        On Error Resume Next

        If Me.CriteriaStatusID = WORKING_CRITERIA And vUpdateScheduleGroupValue Then
            If Me.LstViewScheduleSub.Items.Count > 0 Then
                Call modStatSave.UpdateSubCriteriaScheduleGroupOption(modControl.GetID(cboSubtypeProcessor(1)), modConv.TextToLng(LstViewScheduleSub.FocusedItem.Tag), CONTACT_ON_STATLINE_CONSENT, ChkContactOnStatlineConsentSub.CheckState)
            End If
        End If

    End Sub

    Private Sub ChkContactOnStatlineSecondary_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkContactOnStatlineSecondary.CheckStateChanged

        On Error Resume Next

        'FSProj drh 5/1/02 - Added IF statement so we only save when editing
        If Me.CriteriaStatusID = WORKING_CRITERIA And vUpdateScheduleGroupValue Then
            If Me.LstViewSchedule.Items.Count > 0 Then
                Call modStatSave.UpdateCriteriaScheduleGroupOption(modControl.GetID(CboCriteriaGroup), modConv.TextToLng(LstViewSchedule.FocusedItem.Tag), CONTACT_ON_STATLINE_SECONDARY, ChkContactOnStatlineSecondary.CheckState)
            End If
        End If

    End Sub

    Private Sub ChkContactOnStatlineSecondarySub_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkContactOnStatlineSecondarySub.CheckStateChanged
        'FSProj drh 5/17/02

        On Error Resume Next

        If Me.CriteriaStatusID = WORKING_CRITERIA And vUpdateScheduleGroupValue Then
            If Me.LstViewScheduleSub.Items.Count > 0 Then
                Call modStatSave.UpdateSubCriteriaScheduleGroupOption(modControl.GetID(cboSubtypeProcessor(1)), modConv.TextToLng(LstViewScheduleSub.FocusedItem.Tag), CONTACT_ON_STATLINE_SECONDARY, ChkContactOnStatlineSecondarySub.CheckState)
            End If
        End If

    End Sub

    Private Sub chkCoronerOnly_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles chkCoronerOnly.CheckStateChanged

        On Error Resume Next

        'FSProj drh 5/1/02 - Added IF statement so we only save when editing
        If Me.CriteriaStatusID = WORKING_CRITERIA And vUpdateScheduleGroupValue Then
            If Me.LstViewSchedule.Items.Count > 0 Then
                Call modStatSave.UpdateCriteriaScheduleGroupOption(modControl.GetID(CboCriteriaGroup), modConv.TextToLng(LstViewSchedule.FocusedItem.Tag), CONTACT_ON_CORONER_ONLY, chkCoronerOnly.CheckState)
            End If
        End If

    End Sub

    Private Sub chkCoronerOnlySub_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles chkCoronerOnlySub.CheckStateChanged
        'FSProj drh 5/17/02

        On Error Resume Next

        If Me.CriteriaStatusID = WORKING_CRITERIA And vUpdateScheduleGroupValue Then
            If Me.LstViewScheduleSub.Items.Count > 0 Then
                Call modStatSave.UpdateSubCriteriaScheduleGroupOption(modControl.GetID(cboSubtypeProcessor(1)), modConv.TextToLng(LstViewScheduleSub.FocusedItem.Tag), CONTACT_ON_CORONER_ONLY, chkCoronerOnlySub.CheckState)
            End If
        End If

    End Sub

    Private Sub ChkEyes_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkEyes.CheckStateChanged

        On Error Resume Next

        'FSProj drh 5/1/02 - Added IF statement so we only save when editing
        If Me.CriteriaStatusID = WORKING_CRITERIA And vUpdateScheduleGroupValue Then
            If Me.LstViewSchedule.Items.Count > 0 Then
                Call modStatSave.UpdateCriteriaScheduleGroupOption(modControl.GetID(CboCriteriaGroup), modConv.TextToLng(LstViewSchedule.FocusedItem.Tag), EYES, ChkEyes.CheckState)
            End If
        End If

    End Sub

    Private Sub ChkEyesSub_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkEyesSub.CheckStateChanged
        'FSProj drh 5/17/02

        On Error Resume Next

        If Me.CriteriaStatusID = WORKING_CRITERIA And vUpdateScheduleGroupValue Then
            If Me.LstViewScheduleSub.Items.Count > 0 Then
                Call modStatSave.UpdateSubCriteriaScheduleGroupOption(modControl.GetID(cboSubtypeProcessor(1)), modConv.TextToLng(LstViewScheduleSub.FocusedItem.Tag), EYES, ChkEyesSub.CheckState)
            End If
        End If

    End Sub

    Private Sub ChkHeartValves_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkHeartValves.CheckStateChanged

        On Error Resume Next

        'FSProj drh 5/1/02 - Added IF statement so we only save when editing
        If Me.CriteriaStatusID = WORKING_CRITERIA And vUpdateScheduleGroupValue Then
            If Me.LstViewSchedule.Items.Count > 0 Then
                Call modStatSave.UpdateCriteriaScheduleGroupOption(modControl.GetID(CboCriteriaGroup), modConv.TextToLng(LstViewSchedule.FocusedItem.Tag), VALVES, ChkHeartValves.CheckState)
            End If
        End If

    End Sub

    Private Sub ChkHeartValvesSub_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkHeartValvesSub.CheckStateChanged
        'FSProj drh 5/17/02

        On Error Resume Next

        If Me.CriteriaStatusID = WORKING_CRITERIA And vUpdateScheduleGroupValue Then
            If Me.LstViewScheduleSub.Items.Count > 0 Then
                Call modStatSave.UpdateSubCriteriaScheduleGroupOption(modControl.GetID(cboSubtypeProcessor(1)), modConv.TextToLng(LstViewScheduleSub.FocusedItem.Tag), VALVES, ChkHeartValvesSub.CheckState)
            End If
        End If

    End Sub

    Private Sub ChkNoContactOnDeny_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkNoContactOnDeny.CheckStateChanged

        On Error Resume Next

        'FSProj drh 5/1/02 - Added IF statement so we only save when editing
        If Me.CriteriaStatusID = WORKING_CRITERIA And vUpdateScheduleGroupValue Then
            If Me.LstViewSchedule.Items.Count > 0 Then
                Call modStatSave.UpdateCriteriaScheduleGroupOption(modControl.GetID(CboCriteriaGroup), modConv.TextToLng(LstViewSchedule.FocusedItem.Tag), NO_CONTACT_ON_DENY, ChkNoContactOnDeny.CheckState)
            End If
        End If

    End Sub

    Private Sub ChkNoContactOnDenySub_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkNoContactOnDenySub.CheckStateChanged
        'FSProj drh 5/17/02

        On Error Resume Next

        If Me.CriteriaStatusID = WORKING_CRITERIA And vUpdateScheduleGroupValue Then
            If Me.LstViewScheduleSub.Items.Count > 0 Then
                Call modStatSave.UpdateSubCriteriaScheduleGroupOption(modControl.GetID(cboSubtypeProcessor(1)), modConv.TextToLng(LstViewScheduleSub.FocusedItem.Tag), NO_CONTACT_ON_DENY, ChkNoContactOnDenySub.CheckState)
            End If
        End If

    End Sub


    Private Sub ChkNotAppropriateFemale_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkNotAppropriateFemale.CheckStateChanged

        On Error Resume Next

        Dim I As Short

        'Both not appropriate
        If ChkNotAppropriateMale.CheckState = 1 And ChkNotAppropriateFemale.CheckState = 1 Then

            For I = 2 To 4
                Frame(I).Enabled = False
            Next I
            For I = 6 To 18
                Lable(I).Enabled = False
            Next I
            CmdIndicationAdd.Enabled = False
            CmdIndicationRemove.Enabled = False
            TxtMaleUpper.Enabled = False
            TxtMaleLower.Enabled = False
            TxtFemaleUpper.Enabled = False
            TxtFemaleLower.Enabled = False
            LstViewIndication.Enabled = False
            ChkReferNonPotential.Enabled = False
            TxtLowerWeight.Enabled = False
            TxtUpperWeight.Enabled = False
            TxtGeneralRuleout.Enabled = False

            'Both appropriate
        ElseIf ChkNotAppropriateMale.CheckState = 0 And ChkNotAppropriateFemale.CheckState = 0 Then

            For I = 2 To 4
                Frame(I).Enabled = True
            Next I
            For I = 6 To 18
                Lable(I).Enabled = True
            Next I
            CmdIndicationAdd.Enabled = True
            CmdIndicationRemove.Enabled = True
            TxtMaleUpper.Enabled = True
            TxtMaleLower.Enabled = True
            TxtFemaleUpper.Enabled = True
            TxtFemaleLower.Enabled = True
            LstViewIndication.Enabled = True
            ChkReferNonPotential.Enabled = True
            TxtLowerWeight.Enabled = True
            TxtUpperWeight.Enabled = True
            TxtGeneralRuleout.Enabled = True

            'Male not appropriate, female appropriate
        ElseIf ChkNotAppropriateMale.CheckState = 1 And ChkNotAppropriateFemale.CheckState = 0 Then

            For I = 2 To 4
                Frame(I).Enabled = True
            Next I
            For I = 6 To 9
                Lable(I).Enabled = True
            Next I
            'Male
            For I = 10 To 12
                Lable(I).Enabled = False
            Next I
            'Female
            For I = 13 To 18
                Lable(I).Enabled = True
            Next I
            CmdIndicationAdd.Enabled = True
            CmdIndicationRemove.Enabled = True
            TxtMaleUpper.Enabled = False
            TxtMaleLower.Enabled = False
            TxtFemaleUpper.Enabled = True
            TxtFemaleLower.Enabled = True
            LstViewIndication.Enabled = True
            ChkReferNonPotential.Enabled = True
            TxtLowerWeight.Enabled = True
            TxtUpperWeight.Enabled = True
            TxtGeneralRuleout.Enabled = True

            'Male appropriate, female not appropriate
        ElseIf ChkNotAppropriateMale.CheckState = 0 And ChkNotAppropriateFemale.CheckState = 1 Then

            For I = 2 To 4
                Frame(I).Enabled = True
            Next I
            For I = 6 To 9
                Lable(I).Enabled = True
            Next I
            'Male
            For I = 10 To 12
                Lable(I).Enabled = True
            Next I
            'Female
            For I = 13 To 15
                Lable(I).Enabled = False
            Next I

            For I = 16 To 18
                Lable(I).Enabled = True
            Next I

            CmdIndicationAdd.Enabled = True
            CmdIndicationRemove.Enabled = True
            TxtMaleUpper.Enabled = True
            TxtMaleLower.Enabled = True
            TxtFemaleUpper.Enabled = False
            TxtFemaleLower.Enabled = False
            LstViewIndication.Enabled = True
            ChkReferNonPotential.Enabled = True
            TxtLowerWeight.Enabled = True
            TxtUpperWeight.Enabled = True
            TxtGeneralRuleout.Enabled = True

        End If

    End Sub

    Private Sub ChkNotAppropriateFemaleSub_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkNotAppropriateFemaleSub.CheckStateChanged

        On Error Resume Next

        Dim I As Short

        'Both not appropriate
        If ChkNotAppropriateMaleSub.CheckState = 1 And ChkNotAppropriateFemaleSub.CheckState = 1 Then

            For I = 2 To 4
                FrameSub(I).Enabled = False
            Next I
            For I = 6 To 21
                LableSub(I).Enabled = False
            Next I
            cmdAddConditional.Enabled = False
            cmdRemoveConditional.Enabled = False
            TxtMaleUpperSub.Enabled = False
            TxtMaleLowerSub.Enabled = False
            TxtFemaleUpperSub.Enabled = False
            TxtFemaleLowerSub.Enabled = False
            LstViewConditionals.Enabled = False
            ChkReferNonPotentialSub.Enabled = False
            TxtLowerWeightSub.Enabled = False
            TxtUpperWeightSub.Enabled = False
            TxtFemaleLowerWeightSub.Enabled = False
            TxtFemaleUpperWeightSub.Enabled = False
            TxtGeneralRuleoutSub.Enabled = False

            'Both appropriate
        ElseIf ChkNotAppropriateMaleSub.CheckState = 0 And ChkNotAppropriateFemaleSub.CheckState = 0 Then

            For I = 2 To 4
                FrameSub(I).Enabled = True
            Next I
            For I = 6 To 21
                LableSub(I).Enabled = True
            Next I
            cmdAddConditional.Enabled = True
            cmdRemoveConditional.Enabled = True
            TxtMaleUpperSub.Enabled = True
            TxtMaleLowerSub.Enabled = True
            TxtFemaleUpperSub.Enabled = True
            TxtFemaleLowerSub.Enabled = True
            LstViewConditionals.Enabled = True
            ChkReferNonPotentialSub.Enabled = True
            TxtLowerWeightSub.Enabled = True
            TxtUpperWeightSub.Enabled = True
            TxtFemaleLowerWeightSub.Enabled = True
            TxtFemaleUpperWeightSub.Enabled = True
            TxtGeneralRuleoutSub.Enabled = True

            'Male not appropriate, female appropriate
        ElseIf ChkNotAppropriateMaleSub.CheckState = 1 And ChkNotAppropriateFemaleSub.CheckState = 0 Then

            For I = 2 To 4
                FrameSub(I).Enabled = True
            Next I
            LableSub(7).Enabled = True

            'Male
            For I = 10 To 12
                LableSub(I).Enabled = False
            Next I
            LableSub(6).Enabled = False
            LableSub(17).Enabled = False
            LableSub(18).Enabled = False

            'Female
            For I = 13 To 15
                LableSub(I).Enabled = True
            Next I
            For I = 19 To 21
                LableSub(I).Enabled = True
            Next I

            cmdAddConditional.Enabled = True
            cmdRemoveConditional.Enabled = True
            TxtMaleUpperSub.Enabled = False
            TxtMaleLowerSub.Enabled = False
            TxtFemaleUpperSub.Enabled = True
            TxtFemaleLowerSub.Enabled = True
            LstViewConditionals.Enabled = True
            ChkReferNonPotentialSub.Enabled = True
            TxtLowerWeightSub.Enabled = False
            TxtUpperWeightSub.Enabled = False
            TxtFemaleLowerWeightSub.Enabled = True
            TxtFemaleUpperWeightSub.Enabled = True
            TxtGeneralRuleoutSub.Enabled = True

            'Male appropriate, female not appropriate
        ElseIf ChkNotAppropriateMaleSub.CheckState = 0 And ChkNotAppropriateFemaleSub.CheckState = 1 Then

            For I = 2 To 4
                FrameSub(I).Enabled = True
            Next I
            LableSub(7).Enabled = True
            'Male
            For I = 10 To 12
                LableSub(I).Enabled = True
            Next I
            LableSub(6).Enabled = True
            LableSub(17).Enabled = True
            LableSub(18).Enabled = True

            'Female
            For I = 13 To 15
                LableSub(I).Enabled = False
            Next I
            For I = 19 To 21
                LableSub(I).Enabled = False
            Next I

            cmdAddConditional.Enabled = True
            cmdRemoveConditional.Enabled = True
            TxtMaleUpperSub.Enabled = True
            TxtMaleLowerSub.Enabled = True
            TxtFemaleUpperSub.Enabled = False
            TxtFemaleLowerSub.Enabled = False
            LstViewConditionals.Enabled = True
            ChkReferNonPotentialSub.Enabled = True
            TxtLowerWeightSub.Enabled = True
            TxtUpperWeightSub.Enabled = True
            TxtFemaleLowerWeightSub.Enabled = False
            TxtFemaleUpperWeightSub.Enabled = False
            TxtGeneralRuleoutSub.Enabled = True

        End If

    End Sub

    Private Sub ChkNotAppropriateMale_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkNotAppropriateMale.CheckStateChanged

        On Error Resume Next

        Dim I As Short

        'Both not appropriate
        If ChkNotAppropriateMale.CheckState = 1 And ChkNotAppropriateFemale.CheckState = 1 Then

            For I = 2 To 4
                Frame(I).Enabled = False
            Next I
            For I = 6 To 18
                Lable(I).Enabled = False
            Next I
            CmdIndicationAdd.Enabled = False
            CmdIndicationRemove.Enabled = False
            TxtMaleUpper.Enabled = False
            TxtMaleLower.Enabled = False
            TxtFemaleUpper.Enabled = False
            TxtFemaleLower.Enabled = False
            LstViewIndication.Enabled = False
            ChkReferNonPotential.Enabled = False
            TxtLowerWeight.Enabled = False
            TxtUpperWeight.Enabled = False
            TxtGeneralRuleout.Enabled = False

            'Both appropriate
        ElseIf ChkNotAppropriateMale.CheckState = 0 And ChkNotAppropriateFemale.CheckState = 0 Then

            For I = 2 To 4
                Frame(I).Enabled = True
            Next I
            For I = 6 To 18
                Lable(I).Enabled = True
            Next I
            CmdIndicationAdd.Enabled = True
            CmdIndicationRemove.Enabled = True
            TxtMaleUpper.Enabled = True
            TxtMaleLower.Enabled = True
            TxtFemaleUpper.Enabled = True
            TxtFemaleLower.Enabled = True
            LstViewIndication.Enabled = True
            ChkReferNonPotential.Enabled = True
            TxtLowerWeight.Enabled = True
            TxtUpperWeight.Enabled = True
            TxtGeneralRuleout.Enabled = True

            'Male not appropriate, female appropriate
        ElseIf ChkNotAppropriateMale.CheckState = 1 And ChkNotAppropriateFemale.CheckState = 0 Then

            For I = 2 To 4
                Frame(I).Enabled = True
            Next I
            For I = 6 To 9
                Lable(I).Enabled = True
            Next I
            'Male
            For I = 10 To 12
                Lable(I).Enabled = False
            Next I
            'Female
            For I = 13 To 18
                Lable(I).Enabled = True
            Next I
            CmdIndicationAdd.Enabled = True
            CmdIndicationRemove.Enabled = True
            TxtMaleUpper.Enabled = False
            TxtMaleLower.Enabled = False
            TxtFemaleUpper.Enabled = True
            TxtFemaleLower.Enabled = True
            LstViewIndication.Enabled = True
            ChkReferNonPotential.Enabled = True
            TxtLowerWeight.Enabled = True
            TxtUpperWeight.Enabled = True
            TxtGeneralRuleout.Enabled = True

            'Male appropriate, female not appropriate
        ElseIf ChkNotAppropriateMale.CheckState = 0 And ChkNotAppropriateFemale.CheckState = 1 Then

            For I = 2 To 4
                Frame(I).Enabled = True
            Next I
            For I = 6 To 9
                Lable(I).Enabled = True
            Next I
            'Male
            For I = 10 To 12
                Lable(I).Enabled = True
            Next I
            'Female
            For I = 13 To 15
                Lable(I).Enabled = False
            Next I

            For I = 16 To 18
                Lable(I).Enabled = True
            Next I

            CmdIndicationAdd.Enabled = True
            CmdIndicationRemove.Enabled = True
            TxtMaleUpper.Enabled = True
            TxtMaleLower.Enabled = True
            TxtFemaleUpper.Enabled = False
            TxtFemaleLower.Enabled = False
            LstViewIndication.Enabled = True
            ChkReferNonPotential.Enabled = True
            TxtLowerWeight.Enabled = True
            TxtUpperWeight.Enabled = True
            TxtGeneralRuleout.Enabled = True

        End If

    End Sub

    Private Sub ChkNotAppropriateMaleSub_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkNotAppropriateMaleSub.CheckStateChanged

        On Error Resume Next

        Dim I As Short

        'Both not appropriate
        If ChkNotAppropriateMaleSub.CheckState = 1 And ChkNotAppropriateFemaleSub.CheckState = 1 Then

            For I = 2 To 4
                FrameSub(I).Enabled = False
            Next I
            For I = 6 To 21
                LableSub(I).Enabled = False
            Next I
            cmdAddConditional.Enabled = False
            cmdRemoveConditional.Enabled = False
            TxtMaleUpperSub.Enabled = False
            TxtMaleLowerSub.Enabled = False
            TxtFemaleUpperSub.Enabled = False
            TxtFemaleLowerSub.Enabled = False
            LstViewConditionals.Enabled = False
            ChkReferNonPotentialSub.Enabled = False
            TxtLowerWeightSub.Enabled = False
            TxtUpperWeightSub.Enabled = False
            TxtFemaleLowerWeightSub.Enabled = False
            TxtFemaleUpperWeightSub.Enabled = False
            TxtGeneralRuleoutSub.Enabled = False

            'Both appropriate
        ElseIf ChkNotAppropriateMaleSub.CheckState = 0 And ChkNotAppropriateFemaleSub.CheckState = 0 Then

            For I = 2 To 4
                FrameSub(I).Enabled = True
            Next I
            For I = 6 To 21
                LableSub(I).Enabled = True
            Next I
            cmdAddConditional.Enabled = True
            cmdRemoveConditional.Enabled = True
            TxtMaleUpperSub.Enabled = True
            TxtMaleLowerSub.Enabled = True
            TxtFemaleUpperSub.Enabled = True
            TxtFemaleLowerSub.Enabled = True
            LstViewConditionals.Enabled = True
            ChkReferNonPotentialSub.Enabled = True
            TxtLowerWeightSub.Enabled = True
            TxtUpperWeightSub.Enabled = True
            TxtFemaleLowerWeightSub.Enabled = True
            TxtFemaleUpperWeightSub.Enabled = True
            TxtGeneralRuleoutSub.Enabled = True

            'Male not appropriate, female appropriate
        ElseIf ChkNotAppropriateMaleSub.CheckState = 1 And ChkNotAppropriateFemaleSub.CheckState = 0 Then

            For I = 2 To 4
                FrameSub(I).Enabled = True
            Next I
            LableSub(7).Enabled = True

            'Male
            For I = 10 To 12
                LableSub(I).Enabled = False
            Next I
            LableSub(6).Enabled = False
            LableSub(17).Enabled = False
            LableSub(18).Enabled = False

            'Female
            For I = 13 To 15
                LableSub(I).Enabled = True
            Next I
            For I = 19 To 21
                LableSub(I).Enabled = True
            Next I

            cmdAddConditional.Enabled = True
            cmdRemoveConditional.Enabled = True
            TxtMaleUpperSub.Enabled = False
            TxtMaleLowerSub.Enabled = False
            TxtFemaleUpperSub.Enabled = True
            TxtFemaleLowerSub.Enabled = True
            LstViewConditionals.Enabled = True
            ChkReferNonPotentialSub.Enabled = True
            TxtLowerWeightSub.Enabled = False
            TxtUpperWeightSub.Enabled = False
            TxtFemaleLowerWeightSub.Enabled = True
            TxtFemaleUpperWeightSub.Enabled = True
            TxtGeneralRuleoutSub.Enabled = True

            'Male appropriate, female not appropriate
        ElseIf ChkNotAppropriateMaleSub.CheckState = 0 And ChkNotAppropriateFemaleSub.CheckState = 1 Then

            For I = 2 To 4
                FrameSub(I).Enabled = True
            Next I
            LableSub(7).Enabled = True
            'Male
            For I = 10 To 12
                LableSub(I).Enabled = True
            Next I
            LableSub(6).Enabled = True
            LableSub(17).Enabled = True
            LableSub(18).Enabled = True

            'Female
            For I = 13 To 15
                LableSub(I).Enabled = False
            Next I
            For I = 19 To 21
                LableSub(I).Enabled = False
            Next I

            cmdAddConditional.Enabled = True
            cmdRemoveConditional.Enabled = True
            TxtMaleUpperSub.Enabled = True
            TxtMaleLowerSub.Enabled = True
            TxtFemaleUpperSub.Enabled = False
            TxtFemaleLowerSub.Enabled = False
            LstViewConditionals.Enabled = True
            ChkReferNonPotentialSub.Enabled = True
            TxtLowerWeightSub.Enabled = True
            TxtUpperWeightSub.Enabled = True
            TxtFemaleLowerWeightSub.Enabled = False
            TxtFemaleUpperWeightSub.Enabled = False
            TxtGeneralRuleoutSub.Enabled = True

        End If

    End Sub

    Private Sub ChkOrgans_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkOrgans.CheckStateChanged

        On Error Resume Next

        'FSProj drh 5/1/02 - Added IF statement so we only save when editing
        If Me.CriteriaStatusID = WORKING_CRITERIA And vUpdateScheduleGroupValue Then
            If Me.LstViewSchedule.Items.Count > 0 Then
                Call modStatSave.UpdateCriteriaScheduleGroupOption(modControl.GetID(CboCriteriaGroup), modConv.TextToLng(LstViewSchedule.FocusedItem.Tag), ORGAN, ChkOrgans.CheckState)
            End If
        End If

    End Sub

    Private Sub ChkOrgansSub_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkOrgansSub.CheckStateChanged
        'FSProj drh 5/17/02

        On Error Resume Next

        If Me.CriteriaStatusID = WORKING_CRITERIA And vUpdateScheduleGroupValue Then
            If Me.LstViewScheduleSub.Items.Count > 0 Then
                Call modStatSave.UpdateSubCriteriaScheduleGroupOption(modControl.GetID(cboSubtypeProcessor(1)), modConv.TextToLng(LstViewScheduleSub.FocusedItem.Tag), ORGAN, ChkOrgansSub.CheckState)
            End If
        End If

    End Sub

    Private Sub ChkResearch_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkResearch.CheckStateChanged

        On Error Resume Next

        'FSProj drh 5/1/02 - Added IF statement so we only save when editing
        If Me.CriteriaStatusID = WORKING_CRITERIA And vUpdateScheduleGroupValue Then
            If Me.LstViewSchedule.Items.Count > 0 Then
                Call modStatSave.UpdateCriteriaScheduleGroupOption(modControl.GetID(CboCriteriaGroup), modConv.TextToLng(LstViewSchedule.FocusedItem.Tag), RESEARCH, ChkResearch.CheckState)
            End If
        End If

    End Sub


    Private Sub ChkResearchSub_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkResearchSub.CheckStateChanged
        'FSProj drh 5/17/02

        On Error Resume Next

        If Me.CriteriaStatusID = WORKING_CRITERIA And vUpdateScheduleGroupValue Then
            If Me.LstViewScheduleSub.Items.Count > 0 Then
                Call modStatSave.UpdateSubCriteriaScheduleGroupOption(modControl.GetID(cboSubtypeProcessor(1)), modConv.TextToLng(LstViewScheduleSub.FocusedItem.Tag), RESEARCH, ChkResearchSub.CheckState)
            End If
        End If

    End Sub

    Private Sub ChkSkin_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkSkin.CheckStateChanged

        On Error Resume Next

        'FSProj drh 5/1/02 - Added IF statement so we only save when editing
        If Me.CriteriaStatusID = WORKING_CRITERIA And vUpdateScheduleGroupValue Then
            If Me.LstViewSchedule.Items.Count > 0 Then
                Call modStatSave.UpdateCriteriaScheduleGroupOption(modControl.GetID(CboCriteriaGroup), modConv.TextToLng(LstViewSchedule.FocusedItem.Tag), SKIN, ChkSkin.CheckState)
            End If
        End If

    End Sub

    Private Sub ChkSkinSub_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkSkinSub.CheckStateChanged
        'FSProj drh 5/17/02

        On Error Resume Next

        If Me.CriteriaStatusID = WORKING_CRITERIA And vUpdateScheduleGroupValue Then
            If Me.LstViewScheduleSub.Items.Count > 0 Then
                Call modStatSave.UpdateSubCriteriaScheduleGroupOption(modControl.GetID(cboSubtypeProcessor(1)), modConv.TextToLng(LstViewScheduleSub.FocusedItem.Tag), SKIN, ChkSkinSub.CheckState)
            End If
        End If

    End Sub

    Private Sub ChkSoftTissue_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkSoftTissue.CheckStateChanged

        On Error Resume Next

        'FSProj drh 5/1/02 - Added IF statement so we only save when editing
        If Me.CriteriaStatusID = WORKING_CRITERIA And vUpdateScheduleGroupValue Then
            If Me.LstViewSchedule.Items.Count > 0 Then
                Call modStatSave.UpdateCriteriaScheduleGroupOption(modControl.GetID(CboCriteriaGroup), modConv.TextToLng(LstViewSchedule.FocusedItem.Tag), TISSUE, ChkSoftTissue.CheckState)
            End If
        End If

    End Sub

    Private Sub ChkSoftTissueSub_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles ChkSoftTissueSub.CheckStateChanged
        'FSProj drh 5/17/02

        On Error Resume Next

        If Me.CriteriaStatusID = WORKING_CRITERIA And vUpdateScheduleGroupValue Then
            If Me.LstViewScheduleSub.Items.Count > 0 Then
                Call modStatSave.UpdateSubCriteriaScheduleGroupOption(modControl.GetID(cboSubtypeProcessor(1)), modConv.TextToLng(LstViewScheduleSub.FocusedItem.Tag), TISSUE, ChkSoftTissueSub.CheckState)
            End If
        End If

    End Sub

    Private Sub CmdAdd_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdAdd.Click
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
        Call modStatSave.SaveCriteriaSourceCodes(Me)

    End Sub

    Private Sub cmdAddConditional_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdAddConditional.Click

        frmConditional = New FrmConditional
        frmConditional.vSubCriteriaId = modControl.GetID(Me.cboSubtypeProcessor(0))
        Dim dialogResult As DialogResult = frmConditional.ShowDialog()
        frmConditional = Nothing

        'FSProj drh 5/16/02 - Mark Criteria Updated
        Call modStatSave.SaveCriteriaWorking(Me)

        'FSProj drh 5/8/02 - Fill the conditionals grid
        LstViewConditionals.Items.Clear()
        LstViewConditionals.View = View.Details
        Call modStatQuery.QuerySubCriteriaConditional(Me)

    End Sub

    Private Sub cmdAddProcessor_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdAddProcessor.Click

        Dim vReturn As New Object
        'Dim LstViewCriteriaTemplates As New ListView

        If LstViewAvailableProcessors.SelectedItems.Count > 0 Then
            If LstViewAvailableProcessors.Items.Item(LstViewAvailableProcessors.FocusedItem.Index).Tag > 0 Then

                Call modUtility.Work()

                Call modControl.GetSelListViewID(LstViewAvailableProcessors, vReturn)

                If IsNothing(vReturn) Then
                    Call modUtility.Done()
                    Exit Sub
                End If

                'Insert each of the new rows in the database
                If modStatSave.SaveCriteriaProcessors(Me, vReturn) = SUCCESS Then

                    'FSProj drh 5/6/02 - Mark Criteria Updated
                    Call modStatSave.SaveCriteriaWorking(Me)

                    'Remove the current lists
                    LstViewSelectedProcessors.Items.Clear()
                    LstViewSelectedProcessors.View = View.Details
                    LstViewCriteriaTemplates.Items.Clear()
                    LstViewCriteriaTemplates.View = View.Details
                    LstViewSubtypeProcessors.Items.Clear()
                    LstViewSubtypeProcessors.View = View.Details

                    'Refill the lists
                    Call modStatQuery.QueryCriteriaProcessor(Me)
                    Call modStatQuery.QueryCriteriaTemplate(Me)

                    'Only fill SubtypeProcessors if there's a template selected
                    If LstViewCriteriaTemplates.SelectedItems.Count > 0 Then
                        If CDbl(LstViewCriteriaTemplates.Items.Item(LstViewCriteriaTemplates.FocusedItem.Index).SubItems(2).Text) > 0 Then
                            Call modStatQuery.QuerySubtypeProcessors(Me)
                        End If
                    End If

                End If

                Call modUtility.Done()

            End If
        End If

    End Sub

    Private Sub CmdAddSchedule_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdAddSchedule.Click

        'Add selected schedule group
        Call modStatSave.SaveCriteriaScheduleGroups(Me)

        'Clear the list
        LstViewSchedule.Items.Clear()

        'Get the schedule groups
        Call modStatQuery.QueryCriteriaScheduleGroup(Me)

    End Sub

    Private Sub cmdAddScheduleSub_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdAddScheduleSub.Click
        'FSProj drh 5/17/02

        If modControl.GetID(cboSubtypeProcessor(1)) <> -1 And modControl.GetID(cboScheduleGroupSub) <> -1 Then
            'Add selected schedule group
            Call modStatSave.SaveSubCriteriaScheduleGroups(Me)

            'Clear the list
            LstViewScheduleSub.Items.Clear()

            'Get the schedule groups
            Call modStatQuery.QuerySubCriteriaScheduleGroup(Me)
        End If

    End Sub


    Private Sub cmdAddSubtype_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdAddSubtype.Click
        'FSProj drh 5/8/02

        Dim vReturn As New Object
        Dim LstViewCriteriaTemplates As New ListView

        If LstViewAvailableSubtypes.SelectedItems.Count > 0 Then
            If LstViewAvailableSubtypes.Items.Item(LstViewAvailableSubtypes.FocusedItem.Index).Tag > 0 Then

                Call modUtility.Work()

                Call modControl.GetSelListViewID(LstViewAvailableSubtypes, vReturn)

                If IsNothing(vReturn) Then
                    Call modUtility.Done()
                    Exit Sub
                End If

                'Insert each of the new rows in the database
                If modStatSave.SaveCriteriaSubtypes(Me, vReturn) = SUCCESS Then

                    'FSProj drh 5/6/02 - Mark Criteria Updated
                    Call modStatSave.SaveCriteriaWorking(Me)

                    'Remove the current list
                    LstViewSelectedSubtypes.Items.Clear()
                    LstViewSelectedSubtypes.View = View.Details
                    LstViewAvailableSubtypes.Items.Clear()
                    LstViewAvailableSubtypes.View = View.Details
                    LstViewCriteriaTemplates.Items.Clear()
                    LstViewCriteriaTemplates.View = View.Details
                    LstViewSubtypeProcessors.Items.Clear()
                    LstViewSubtypeProcessors.View = View.Details

                    'Refill the selected subtypes list
                    Call modStatQuery.QueryCriteriaSubtype(Me)
                    Call modStatQuery.QueryAvailableSubtype(Me)
                    Call modStatQuery.QueryCriteriaTemplate(Me)

                    'Only fill SubtypeProcessors if there's a template selected
                    If LstViewCriteriaTemplates.SelectedItems.Count > 0 Then
                        If CDbl(LstViewCriteriaTemplates.Items.Item(LstViewCriteriaTemplates.FocusedItem.Index).SubItems(2).Text) > 0 Then
                            Call modStatQuery.QuerySubtypeProcessors(Me)
                        End If
                    End If

                End If

                Call modUtility.Done()

            End If
        End If

    End Sub

    Private Sub CmdCancel_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdCancel.Click

        Me.Close()

    End Sub




    Private Sub CmdIndicationAdd_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdIndicationAdd.Click

        AppMain.frmIndicationSelect = New FrmIndicationSelect

        Me.IndicationList = AppMain.frmIndicationSelect.Display

        If Not IsNothing(Me.IndicationList) Then

            'Insert each of the new rows in the database
            If modStatSave.SaveCriteriaGroupIndication(Me) = SUCCESS Then

                'FSProj drh 5/6/02 - Mark Criteria Updated
                Call modStatSave.SaveCriteriaWorking(Me)

                'Remove the current list
                LstViewIndication.Items.Clear()
                LstViewIndication.View = View.Details

                'Refill the list
                Call modStatQuery.QueryCriteriaGroupIndication(Me)

            End If
        End If

    End Sub


    Private Sub CmdIndicationRemove_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdIndicationRemove.Click

        Dim vReturn As New Object

        Call modUtility.Work()

        Call modControl.GetSelListViewID(LstViewIndication, vReturn)

        If Not IsNothing(vReturn) Then

            Me.IndicationList = vReturn

            'Remove each of the selected rows
            Call modStatSave.DeleteCriteriaGroupIndication(Me)

            'FSProj drh 5/6/02 - Mark Criteria Updated
            Call modStatSave.SaveCriteriaWorking(Me)

            'Remove the current list
            LstViewIndication.Items.Clear()
            LstViewIndication.View = View.Details

            'Refill the list
            Call modStatQuery.QueryCriteriaGroupIndication(Me)
        End If

        Call modUtility.Done()

    End Sub

    Private Sub CmdDeselect_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdDeselect.Click

        Dim vReturn As New Object

        Call modUtility.Work()

        Call modControl.GetSelListViewID(LstViewSelectedOrganizations, vReturn)

        If IsNothing(vReturn) Then
            Call modUtility.Done()
            Exit Sub
        End If

        'Remove each of the selected rows
        Call modStatSave.DeleteCriteriaReferralOrganizations(vReturn)

        'FSProj drh 5/6/02 - Mark Criteria Updated
        Call modStatSave.SaveCriteriaWorking(Me)

        'Remove the current list
        LstViewSelectedOrganizations.Items.Clear()
        LstViewSelectedOrganizations.View = View.Details

        'Refill the selected organizations list
        Call modStatQuery.QueryCriteriaReferralOrganization(Me)

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

    Private Sub CmdMapCategory_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdMapCategory.Click
        'Get Current Criteria GroupID
        'If the current Criteria Group ID is 0 request a criteria group id be selected
        If modControl.GetID(CboCriteriaGroup) = -1 Then
            'request a criteriat group ID is selected
            modMsgForm.FormValidate((CboCriteriaGroup.Name))
        Else
            frmDynamicDonorCategory = New FrmDynamicDonorCategory
            frmDynamicDonorCategory.CriteriaGroupID = modControl.GetID(CboCriteriaGroup)
            frmDynamicDonorCategory.DonorCategoryName = modControl.GetText(CboDonorCategory)
            'display form
            frmDynamicDonorCategory.Display()

        End If


    End Sub

    Private Sub cmdNewTemplate_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdNewTemplate.Click
        'FSProj drh 5/9/02
        'Dim LstViewCriteriaTemplates As New ListView

        If LstViewCriteriaTemplates.SelectedItems.Count > 0 Then
            frmCriteriaTemplate = New FrmCriteriaTemplate
            frmCriteriaTemplate.vProcessorId = CShort(LstViewCriteriaTemplates.Items.Item(LstViewCriteriaTemplates.FocusedItem.Index).SubItems.Item(2).Text)
            frmCriteriaTemplate.Text = "Criteria Template - " & LstViewCriteriaTemplates.Items.Item(LstViewCriteriaTemplates.FocusedItem.Index).Text
            frmCriteriaTemplate.FormState = NEW_RECORD
            Dim dialogResult As DialogResult = frmCriteriaTemplate.ShowDialog()
            frmCriteriaTemplate = Nothing

            'FSProj drh 5/8/02 - Fill the criteria templates grid
            LstViewCriteriaTemplates.Items.Clear()
            LstViewCriteriaTemplates.View = View.Details
            Call modStatQuery.QueryCriteriaTemplate(Me)
        Else
            Call MsgBox("Please select a Processor in the list below.", MsgBoxStyle.OkOnly, "No Processor Selected")
        End If
    End Sub

    Private Sub CmdOK_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdOK.Click

        Dim vReturn As Short

        'Make sure the user wants to save
        vReturn = modMsgForm.FormSave

        If vReturn = MsgBoxResult.Cancel Then
            Exit Sub
        End If

        'Validate the data
        If Not modStatValidate.Criteria(Me) Then
            Exit Sub
        End If

        Call modUtility.Work()

        'Save the referral
        Call modStatSave.SaveCriteria(Me)
        Me.Saved = True

        'Make sure the user wants to close
        vReturn = modMsgForm.FormClose

        If vReturn = MsgBoxResult.No Then
            Me.FormState = EXISTING_RECORD
        Else
            Me.Close()
        End If

        Call modUtility.Done()

    End Sub



    Private Sub CmdCriteriaGroupDetail_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdCriteriaGroupDetail.Click

        Dim vCriteriaGroupID As Integer
        Dim vReturn As New Object

        On Error Resume Next

        'Determine the state which to open the
        'form.
        If modControl.GetID(CboCriteriaGroup) = -1 Then
            frmCriteriaGroup = New FrmCriteriaGroup
            frmCriteriaGroup.FormState = NEW_RECORD
            frmCriteriaGroup.CriteriaGroupID = CStr(0)
        Else
            frmCriteriaGroup = New FrmCriteriaGroup
            frmCriteriaGroup.FormState = EXISTING_RECORD
            frmCriteriaGroup.CriteriaGroupID = CStr(modControl.GetID(CboCriteriaGroup))
        End If

        frmCriteriaGroup.DonorCategoryID = CStr(Me.DonorCategoryID)

        'FSProj drh 5/6/02 - Set the Criteria StatusID
        frmCriteriaGroup.CriteriaStatusID = Me.CriteriaStatusID

        'Get the CriteriaGroup id from the CriteriaGroup form
        'after the user is done.
        vCriteriaGroupID = frmCriteriaGroup.Display

        If vCriteriaGroupID = 0 Then
            'The user cancelled adding a new CriteriaGroup
            'so do nothing
        Else
            'Refill the combo box with the new (or updated)
            'CriteriaGroup id and name
            'FSProj drh 4/29/02 - Pass in the Criteria Status so we get the correct Historical Criteria type (CriteriaStatus)
            Call modStatRefQuery.RefQueryCriteriaGroup(vReturn, , , Me.DonorCategoryID, CriteriaStatusID)
            Call modControl.SetTextID(CboCriteriaGroup, vReturn)
            Call modControl.SelectID(CboCriteriaGroup, vCriteriaGroupID)
        End If

    End Sub

    Private Sub cmdProcessorFind_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdProcessorFind.Click

        Call modUtility.Work()

        'Clear the grid
        LstViewAvailableProcessors.Items.Clear()
        LstViewAvailableProcessors.View = View.Details

        'Fill Grid
        Call modStatQuery.QueryOpenProcessor(Me)

        Call modUtility.Done()

    End Sub

    Private Sub CmdRemove_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdRemove.Click

        If Me.LstViewSourceCodes.SelectedItems.Count > 0 Then

            Call SourceCodes.Remove(LstViewSourceCodes.FocusedItem.Tag)

            Call SourceCodes.FillListView2(LstViewSourceCodes)

            Call modStatSave.SaveCriteriaSourceCodes(Me)

        End If

    End Sub

    Private Sub cmdRemoveConditional_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdRemoveConditional.Click

        If LstViewConditionals.SelectedItems.Count > 0 Then
            Call modStatSave.DeleteSubCriteriaConditional((LstViewConditionals.Items.Item(LstViewConditionals.FocusedItem.Index).Tag))

            'FSProj drh 5/16/02 - Mark Criteria Updated
            Call modStatSave.SaveCriteriaWorking(Me)

            'FSProj drh 5/16/02 - Fill the conditionals grid
            LstViewConditionals.Items.Clear()
            LstViewConditionals.View = View.Details
            Call modStatQuery.QuerySubCriteriaConditional(Me)
        End If

    End Sub

    Private Sub cmdRemoveProcessor_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdRemoveProcessor.Click
        'FSProj drh 5/8/02

        Dim vReturn As New Object
        Dim vItemUsed As Boolean
        vItemUsed = False

        If LstViewSelectedProcessors.SelectedItems.Count > 0 Then
            If LstViewSelectedProcessors.Items.Item(LstViewSelectedProcessors.FocusedItem.Index).Tag > 0 Then

                Call modUtility.Work()

                Call modControl.GetUnusedListViewID(Me, LstViewSelectedProcessors, vReturn, vItemUsed)

                If IsNothing(vReturn) Then
                    If vItemUsed Then
                        Call MsgBox("One or more of the Processors you selected is currently associated with a SubCriteria and was not removed.", MsgBoxStyle.OkOnly, "Processor Not Removed")
                    End If

                    Call modUtility.Done()
                    Exit Sub
                End If

                'Remove each of the selected rows
                Call modStatSave.DeleteCriteriaProcessors(vReturn)

                'FSProj drh 5/6/02 - Mark Criteria Updated
                Call modStatSave.SaveCriteriaWorking(Me)

                'Remove the current lists
                LstViewSelectedProcessors.Items.Clear()
                LstViewSelectedProcessors.View = View.Details
                LstViewCriteriaTemplates.Items.Clear()
                LstViewCriteriaTemplates.View = View.Details
                LstViewSubtypeProcessors.Items.Clear()
                LstViewSubtypeProcessors.View = View.Details

                'Refill the lists
                Call modStatQuery.QueryCriteriaProcessor(Me)
                Call modStatQuery.QueryCriteriaTemplate(Me)

                'Only fill SubtypeProcessors if there's a template selected
                'If LstViewCriteriaTemplates.Items.Count > 0 Then
                '    If CDbl(LstViewCriteriaTemplates.Items.Item(LstViewCriteriaTemplates.FocusedItem.Index).SubItems(2).Text) > 0 Then
                '        Call modStatQuery.QuerySubtypeProcessors(Me)
                '    End If
                'End If

                If vItemUsed Then
                    Call MsgBox("One or more of the Processors you selected is currently associated with a SubCriteria and was not removed.", MsgBoxStyle.OkOnly, "Processor Not Removed")
                End If

                Call modUtility.Done()

            End If
        End If

    End Sub

    Private Sub cmdRemoveScheduleSub_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdRemoveScheduleSub.Click
        'FSProj drh 5/17/02

        On Error Resume Next

        Dim vSCScheduleGroupID As Integer
        If LstViewSubtypeProcessors.SelectedItems.Count > 0 Then
            If modControl.GetID(cboSubtypeProcessor(1)) <> -1 And LstViewScheduleSub.FocusedItem.Index <> -1 Then

                vSCScheduleGroupID = LstViewScheduleSub.FocusedItem.Tag

                'Delete the item
                Call modStatSave.DeleteSubCriteriaGroupScheduleGroup(Me, vSCScheduleGroupID)

                'Clear the list
                LstViewScheduleSub.Items.Clear()

                'Fill the schedule groups
                Call modStatQuery.QuerySubCriteriaScheduleGroup(Me)

                If LstViewScheduleSub.Items.Count = 0 Then
                    Me.ChkOrgansSub.Enabled = False
                    Me.ChkBoneSub.Enabled = False
                    Me.ChkSoftTissueSub.Enabled = False
                    Me.ChkSkinSub.Enabled = False
                    Me.ChkHeartValvesSub.Enabled = False
                    Me.ChkEyesSub.Enabled = False
                    Me.ChkResearchSub.Enabled = False
                End If
            End If
        End If

    End Sub

    Private Sub cmdRemoveSubtype_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdRemoveSubtype.Click
        'FSProj drh 5/8/02

        Dim vReturn As New Object
        Dim vItemUsed As Boolean
        Dim LstViewCriteriaTemplates As New ListView

        vItemUsed = False

        If LstViewSelectedSubtypes.SelectedItems.Count > 0 Then
            If LstViewSelectedSubtypes.Items.Item(LstViewSelectedSubtypes.FocusedItem.Index).Tag > 0 Then

                Call modUtility.Work()

                Call modControl.GetUnusedListViewID(Me, LstViewSelectedSubtypes, vReturn, vItemUsed)

                If IsNothing(vReturn) Then
                    If vItemUsed Then
                        Call MsgBox("One or more of the Processors you selected is currently associated with a SubCriteria and was not removed.", MsgBoxStyle.OkOnly, "Processor Not Removed")
                    End If

                    Call modUtility.Done()
                    Exit Sub
                End If

                'Remove each of the selected rows
                Call modStatSave.DeleteCriteriaSubtypes(vReturn)

                'FSProj drh 5/6/02 - Mark Criteria Updated
                Call modStatSave.SaveCriteriaWorking(Me)

                'Remove the current list
                LstViewSelectedSubtypes.Items.Clear()
                LstViewSelectedSubtypes.View = View.Details
                LstViewAvailableSubtypes.Items.Clear()
                LstViewAvailableSubtypes.View = View.Details
                LstViewCriteriaTemplates.Items.Clear()
                LstViewCriteriaTemplates.View = View.Details
                LstViewSubtypeProcessors.Items.Clear()
                LstViewSubtypeProcessors.View = View.Details

                'Refill the selected subtypes list
                Call modStatQuery.QueryCriteriaSubtype(Me)
                Call modStatQuery.QueryAvailableSubtype(Me)
                Call modStatQuery.QueryCriteriaTemplate(Me)

                'Only fill SubtypeProcessors if there's a template selected
                If LstViewCriteriaTemplates.SelectedItems.Count > 0 Then
                    If CDbl(LstViewCriteriaTemplates.Items.Item(LstViewCriteriaTemplates.FocusedItem.Index).SubItems(2).Text) > 0 Then
                        Call modStatQuery.QuerySubtypeProcessors(Me)
                    End If
                End If

                If vItemUsed Then
                    Call MsgBox("One or more of the Subtypes you selected is currently associated with a SubCriteria and was not removed.", MsgBoxStyle.OkOnly, "Subtype Not Removed")
                End If

                Call modUtility.Done()

            End If
        End If

    End Sub

    Private Sub cmdSaveSubCriteria_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdSaveSubCriteria.Click

        Dim vReturn As Short

        'Make sure the user wants to save
        vReturn = modMsgForm.FormSave

        If vReturn = MsgBoxResult.Cancel Then
            Exit Sub
        End If

        'Validate the data
        If Not modStatValidate.SubCriteria(Me) Then
            Exit Sub
        End If

        Call modUtility.Work()

        'Save the subcriteria
        Call modStatSave.SaveExistingSubCriteria(Me)

        'FSProj drh 5/16/02 - Mark Criteria Updated
        Call modStatSave.SaveCriteriaWorking(Me)

        Call modUtility.Done()

    End Sub


    Private Sub cmdSelect_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdSelect.Click

        Dim vReturn As New Object

        Call modUtility.Work()

        Call modControl.GetSelListViewID(LstViewAvailableOrganizations, vReturn)

        If IsNothing(vReturn) Then
            Call modUtility.Done()
            Exit Sub
        End If

        'Insert each of the new rows in the database
        If modStatSave.SaveCriteriaReferralOrganizations(Me, vReturn) = SUCCESS Then

            'FSProj drh 5/6/02 - Mark Criteria Updated
            Call modStatSave.SaveCriteriaWorking(Me)

            'Remove the current list
            LstViewSelectedOrganizations.Items.Clear()
            LstViewSelectedOrganizations.View = View.Details

            'Refill the selected organizations list
            Call modStatQuery.QueryCriteriaReferralOrganization(Me)

        End If

        Call modUtility.Done()

    End Sub






    Private Sub cmdTemp_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdTemp.Click

        On Error Resume Next

        Dim vQuery As String = ""
        Dim I As Short
        Dim vReturn As New Object
        Dim vMsg As String = ""

        vQuery = "ABATCH_UPDATECRITERIA"

        If modODBC.Exec(vQuery, vReturn) = SUCCESS Then
            MsgBox("Update Complete.", MsgBoxStyle.OkOnly, "Historical Criteria Update")
        Else
            MsgBox("There was a problem with the update.", MsgBoxStyle.OkOnly, "Error")
        End If

    End Sub

    Private Sub CmdUnassigned_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdUnassigned.Click

        Call modUtility.Work()

        'Clear the grid
        LstViewAvailableOrganizations.Items.Clear()
        LstViewAvailableOrganizations.View = View.Details

        'Fill Grid
        Call modStatQuery.QueryUnassignedCriteriaOrganization(Me)

        Call modUtility.Done()

    End Sub

    Private Sub cmdSubtype_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdSubtype.Click
        frmSubtype = New FrmSubtype
        Dim dialogResult As DialogResult = frmSubtype.ShowDialog()

        'FSProj drh 5/6/02 - Clear Available Subtypes list
        LstViewAvailableSubtypes.Items.Clear()
        LstViewAvailableSubtypes.View = View.Details

        'FSProj drh 5/6/02 - Fill the available subtypes grid
        Call modStatQuery.QueryAvailableSubtype(Me)

    End Sub

    Private Sub Command12_Click()
        frmConditional = New FrmConditional
        Dim dialogResult As DialogResult = frmConditional.ShowDialog()
    End Sub



    Private Sub FrmCriteria_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load

        'Call modUtility.CenterForm()

        Me.Saved = False
        Me.Loaded = False

        '*******************************
        'Initialize 'Donor Criteria' Information
        '*******************************

        'Initialize the Indication indications grid
        Call modControl.HighlightListViewRow(LstViewIndication)
        Call LstViewIndication.Columns.Insert(0, "", "Ruleout Item", CInt(VB6.TwipsToPixelsX(1700)))
        Call LstViewIndication.Columns.Insert(1, "", "Ruleout only if...", CInt(VB6.TwipsToPixelsX(3800)))

        Call modControl.HighlightListViewRow(LstViewSourceCodes)
        Call LstViewSourceCodes.Columns.Insert(0, "", "Source Code", CInt(VB6.TwipsToPixelsX(1200)))
        Call LstViewSourceCodes.Columns.Insert(1, "", "Source Type", CInt(VB6.TwipsToPixelsX(1200)))

        'If the category ID has not been set and the referral
        'organization ID has not been set, then fill the organization
        'list box with all categories.
        If Me.DonorCategoryID = 0 And Me.ReferralOrganizationID = 0 Then
            Call modStatRefQuery.ListRefQueryDonorCategory(CboDonorCategory)
            'T.T 08/19/2005 DonorCriteria mapping
            Call modStatRefQuery.ListDonorTracRefQueryDonorCategory(CboDonorTracCriteriaGroup)
            'Else if the category ID has been set, but the
            'referral organization ID has not been set, then
            'fill the category list with only the selected category.
        ElseIf Me.DonorCategoryID <> 0 And Me.ReferralOrganizationID = 0 Then
            CboDonorCategory.Items.Add(New ValueDescriptionPair(Me.DonorCategoryID, Me.DonorCategoryName))
            'Set the category combo box to the current category
            Call modControl.SelectID(CboDonorCategory, Me.DonorCategoryID)

            'Else if the category ID has been set, and
            'if the referral organization ID has been set, then
            'fill the category list with only the selected category, and
            'find all the criteria category groups that apply to the
            'referral organization ID.
        ElseIf Me.ReferralOrganizationID <> 0 Then
            CboDonorCategory.Items.Add(New ValueDescriptionPair(Me.DonorCategoryID, Me.DonorCategoryName))
            'Set the category combo box to the current category
            Call modControl.SelectID(CboDonorCategory, Me.DonorCategoryID)
            'T.T 08/19/2005 DonorCriteria mapping
            Call modStatRefQuery.ListDonorTracRefQueryDonorCategory(CboDonorTracCriteriaGroup)
            Me.CboDonorTracCriteriaGroup.SelectedIndex = Me.CriteriaDonorTracID
            'FSProj drh 4/29/02 - Pass in CriteriaStatusID so we can get the correct Historical Criteria Status type (CriteriaStatus)
            '*********************************************************************************
            If Me.CriteriaStatusID <> WORKING_CRITERIA And Me.CriteriaGroupID <> 0 Then
                Call modStatQuery.QueryCategoryGroupsApplicable(Me, , Me.CriteriaGroupID)
            Else
                Call modStatQuery.QueryCategoryGroupsApplicable(Me, CriteriaStatusID)
            End If

            If CboCriteriaGroup.Items.Count = 1 Then
                Call modControl.SelectFirst(CboCriteriaGroup)
            End If
            '*********************************************************************************
        End If


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

        'FSProj drh 5/8/02 - Get the processor reference data
        Call modStatRefQuery.RefQueryState(cboProcessorState, , , , , True)
        Call modStatRefQuery.RefQueryOrganizationType(cboProcessorOrganizationType, , , , , True)

        'Set the default types
        Call modControl.SelectID(CboState, ALL_STATES)
        Call modControl.SelectID(CboOrganizationType, ALL_ORG_TYPES)

        'FSProj drh 5/8/02 - Set the processor default types
        Call modControl.SelectID(cboProcessorState, ALL_STATES)
        Call modControl.SelectID(cboProcessorOrganizationType, ALL_ORG_TYPES)

        Me.AvailableSortOrder = ASCENDING_ORDER


        '*******************************
        'Initialize 'Schedule Group' Information
        '*******************************

        Call modControl.HighlightListViewRow(LstViewSchedule)
        Call LstViewSchedule.Columns.Insert(0, "", "Organization", CInt(VB6.TwipsToPixelsX(4000)))
        Call LstViewSchedule.Columns.Insert(1, "", "Schedule Group", CInt(VB6.TwipsToPixelsX(1500)))

        Call modStatQuery.QueryScheduleOrganizations(Me)

        'Determine whether to show the Category map button
        If modStatSecurity.GetPermission(AppMain.ParentForm.StatEmployeeID, "AllowMaintainAccess") Then
            Me.CmdMapCategory.Visible = True
        Else
            Me.CmdMapCategory.Visible = False
        End If

        'FSProj drh 5/6/02 - Initialize the selected subtypes grid
        Call modControl.HighlightListViewRow(LstViewSelectedSubtypes)
        Call LstViewSelectedSubtypes.Columns.Insert(0, "", "Subtype", CInt(VB6.TwipsToPixelsX(1500)))
        Call LstViewSelectedSubtypes.Columns.Insert(1, "", "Order", CInt(VB6.TwipsToPixelsX(700)))
        Call LstViewSelectedSubtypes.Columns.Insert(2, "", "Description", CInt(VB6.TwipsToPixelsX(4000)))
        Call LstViewSelectedSubtypes.Columns.Insert(3, "", "", CInt(VB6.TwipsToPixelsX(0)))

        'FSProj drh 5/6/02 - Initialize the available subtypes grid
        Call modControl.HighlightListViewRow(LstViewAvailableSubtypes)
        Call LstViewAvailableSubtypes.Columns.Insert(0, "", "Subtype", CInt(VB6.TwipsToPixelsX(1500)))
        Call LstViewAvailableSubtypes.Columns.Insert(1, "", "Description", CInt(VB6.TwipsToPixelsX(4000)))

        'FSProj drh 5/6/02 - Initialize the selected processors grid
        Call modControl.HighlightListViewRow(LstViewSelectedProcessors)
        Call LstViewSelectedProcessors.Columns.Insert(0, "", "Processor", CInt(VB6.TwipsToPixelsX(2500)))
        Call LstViewSelectedProcessors.Columns.Insert(1, "", "City", CInt(VB6.TwipsToPixelsX(1100)))
        Call LstViewSelectedProcessors.Columns.Insert(2, "", "State", CInt(VB6.TwipsToPixelsX(550)))
        Call LstViewSelectedProcessors.Columns.Insert(3, "", "Organization Type", CInt(VB6.TwipsToPixelsX(1800)))
        Call LstViewSelectedProcessors.Columns.Insert(4, "", "", CInt(VB6.TwipsToPixelsX(0)))

        'FSProj drh 5/6/02 - Initialize the available processors grid
        Call modControl.HighlightListViewRow(LstViewAvailableProcessors)
        Call LstViewAvailableProcessors.Columns.Insert(0, "", "Processor", CInt(VB6.TwipsToPixelsX(2500)))
        Call LstViewAvailableProcessors.Columns.Insert(1, "", "City", CInt(VB6.TwipsToPixelsX(1100)))
        Call LstViewAvailableProcessors.Columns.Insert(2, "", "State", CInt(VB6.TwipsToPixelsX(550)))
        Call LstViewAvailableProcessors.Columns.Insert(3, "", "Organization Type", CInt(VB6.TwipsToPixelsX(1800)))

        'FSProj drh 5/8/02 - Initialize the criteria templates
        Call modControl.HighlightListViewRow(LstViewCriteriaTemplates)
        Call LstViewCriteriaTemplates.Columns.Insert(0, "", "Processor", CInt(VB6.TwipsToPixelsX(3400)))
        Call LstViewCriteriaTemplates.Columns.Insert(1, "", "Template Name", CInt(VB6.TwipsToPixelsX(3400)))
        Call LstViewCriteriaTemplates.Columns.Insert(2, "", "ProcId", CInt(VB6.TwipsToPixelsX(0)))

        'FSProj drh 5/8/02 - Initialize the subtype/processor list
        Call modControl.HighlightListViewRow(LstViewSubtypeProcessors)
        Call LstViewSubtypeProcessors.Columns.Insert(0, "", "Subtype (Assigned Y/N)", CInt(VB6.TwipsToPixelsX(2500)))
        Call LstViewSubtypeProcessors.Columns.Insert(1, "", "Order", CInt(VB6.TwipsToPixelsX(1000)))
        Call LstViewSubtypeProcessors.Columns.Insert(2, "", "", CInt(VB6.TwipsToPixelsX(0)))

        'FSProj drh 5/15/02 - Initialize the conditional list
        Call modControl.HighlightListViewRow(LstViewConditionals)
        Call LstViewConditionals.Columns.Insert(0, "", "Criteria", CInt(VB6.TwipsToPixelsX(3000)))
        Call LstViewConditionals.Columns.Insert(1, "", "Reason", CInt(VB6.TwipsToPixelsX(2000)))
        Call LstViewConditionals.Columns.Insert(2, "", "Condition", CInt(VB6.TwipsToPixelsX(10000)))

        'FSProj drh 5/15/02 - Initialize the subcriteria schedule group list
        Call modControl.HighlightListViewRow(LstViewScheduleSub)
        Call LstViewScheduleSub.Columns.Insert(0, "", "Organization", CInt(VB6.TwipsToPixelsX(4000)))
        Call LstViewScheduleSub.Columns.Insert(1, "", "Schedule Group", CInt(VB6.TwipsToPixelsX(1500)))

        'FSProj drh 5/1/02 - Disable buttons if not Working Criteria type
        If Me.CriteriaStatusID <> WORKING_CRITERIA Then
            Me.CmdIndicationAdd.Visible = False
            Me.CmdIndicationAdd.Enabled = False
            Me.CmdIndicationRemove.Visible = False
            Me.CmdIndicationRemove.Enabled = False
            Me.CmdAddSchedule.Visible = False
            Me.CmdAddSchedule.Enabled = False
            Me.RemoveSchedule.Visible = False
            Me.RemoveSchedule.Enabled = False
            Me.CmdMapCategory.Visible = False
            Me.CmdMapCategory.Enabled = False
            Me.CmdCriteriaGroupDetail.Visible = False
            Me.CmdCriteriaGroupDetail.Enabled = False
        End If


        Me.Loaded = True

    End Sub


    Private Sub FrmCriteria_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing

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
                Exit Sub
            End If
        End If
        AppMain.frmCriteria = Nothing
        'Me.Dispose()
    End Sub

    Private Sub ListView1_DblClick()
        Dim vPrec As String = ""
        vPrec = InputBox("Please enter Precedence", "LifeNet Precedence", CStr(2))
    End Sub

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

    End Sub


    Private Sub LstViewCriteriaTemplates_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewCriteriaTemplates.Click

        'FSProj drh 5/14/02 - Clear the list
        LstViewSubtypeProcessors.Items.Clear()
        LstViewSubtypeProcessors.View = View.Details

        'FSProj drh 5/8/02 - Fill the subtype/processor info
        If LstViewCriteriaTemplates.Items.Count > 0 Then
            If CDbl(LstViewCriteriaTemplates.Items.Item(LstViewCriteriaTemplates.FocusedItem.Index).SubItems(2).Text) > 0 Then
                Call modStatQuery.QuerySubtypeProcessors(Me)
            End If
        End If

    End Sub





    Private Sub LstViewScheduleSub_ItemClick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewScheduleSub.Click
        'FSProj drh 5/17/02
        Dim Item As New ListViewItem '= LstViewSchedule.FocusedItem
        On Error Resume Next

        'ccarroll 04/12/2010 created New ListViewItem Item instance. Changed LstViewSchedule to Me.LstViewScheduleSub
        Item = LstViewScheduleSub.FocusedItem

        Dim vOptions As New Object

        ChkOrgansSub.Enabled = True
        ChkBoneSub.Enabled = True
        ChkSoftTissueSub.Enabled = True
        ChkSkinSub.Enabled = True
        ChkHeartValvesSub.Enabled = True
        ChkEyesSub.Enabled = True
        ChkResearchSub.Enabled = True
        ChkContactOnConsentSub.Enabled = True
        ChkNoContactOnDenySub.Enabled = True
        ChkContactOnHospitalConsentSub.Enabled = True
        ChkContactOnCoronerSub.Enabled = True
        chkCoronerOnlySub.Enabled = True
        ChkContactOnStatlineSecondarySub.Enabled = True
        ChkContactOnStatlineConsentSub.Enabled = True

        'FSProj drh 5/17/02 - Turn off the click event code temporarily
        vUpdateScheduleGroupValue = False

        'Get the schedule group options
        If modStatQuery.QuerySubCriteriaScheduleGroupOptions(modControl.GetID(cboSubtypeProcessor(1)), modConv.TextToLng(Item.Tag), vOptions) = SUCCESS Then

            If vOptions(0, 0) = "" Then
                Me.ChkOrgansSub.CheckState = System.Windows.Forms.CheckState.Unchecked
            Else
                Me.ChkOrgansSub.CheckState = vOptions(0, 0)
            End If
            If vOptions(0, 1) = "" Then
                Me.ChkBoneSub.CheckState = System.Windows.Forms.CheckState.Unchecked
            Else
                Me.ChkBoneSub.CheckState = vOptions(0, 1)
            End If
            If vOptions(0, 2) = "" Then
                Me.ChkSoftTissueSub.CheckState = System.Windows.Forms.CheckState.Unchecked
            Else
                Me.ChkSoftTissueSub.CheckState = vOptions(0, 2)
            End If
            If vOptions(0, 3) = "" Then
                Me.ChkSkinSub.CheckState = System.Windows.Forms.CheckState.Unchecked
            Else
                Me.ChkSkinSub.CheckState = vOptions(0, 3)
            End If
            If vOptions(0, 4) = "" Then
                Me.ChkHeartValvesSub.CheckState = System.Windows.Forms.CheckState.Unchecked
            Else
                Me.ChkHeartValvesSub.CheckState = vOptions(0, 4)
            End If
            If vOptions(0, 5) = "" Then
                Me.ChkEyesSub.CheckState = System.Windows.Forms.CheckState.Unchecked
            Else
                Me.ChkEyesSub.CheckState = vOptions(0, 5)
            End If
            If vOptions(0, 6) = "" Then
                Me.ChkResearchSub.CheckState = System.Windows.Forms.CheckState.Unchecked
            Else
                Me.ChkResearchSub.CheckState = vOptions(0, 6)
            End If
            If vOptions(0, 7) = "" Then
                Me.ChkNoContactOnDenySub.CheckState = System.Windows.Forms.CheckState.Unchecked
            Else
                Me.ChkNoContactOnDenySub.CheckState = vOptions(0, 7)
            End If
            If vOptions(0, 8) = "" Then
                Me.ChkContactOnConsentSub.CheckState = System.Windows.Forms.CheckState.Unchecked
            Else
                Me.ChkContactOnConsentSub.CheckState = vOptions(0, 8)
            End If
            If vOptions(0, 9) = "" Then
                Me.ChkContactOnHospitalConsentSub.CheckState = System.Windows.Forms.CheckState.Unchecked
            Else
                Me.ChkContactOnHospitalConsentSub.CheckState = vOptions(0, 9)
            End If
            If vOptions(0, 10) = "" Then
                Me.ChkContactOnCoronerSub.CheckState = System.Windows.Forms.CheckState.Unchecked
            Else
                Me.ChkContactOnCoronerSub.CheckState = vOptions(0, 10)
            End If
            If vOptions(0, 11) = "" Then
                Me.ChkContactOnStatlineSecondarySub.CheckState = System.Windows.Forms.CheckState.Unchecked
            Else
                Me.ChkContactOnStatlineSecondarySub.CheckState = vOptions(0, 11)
            End If
            If vOptions(0, 12) = "" Then
                Me.ChkContactOnStatlineConsentSub.CheckState = System.Windows.Forms.CheckState.Unchecked
            Else
                Me.ChkContactOnStatlineConsentSub.CheckState = vOptions(0, 12)
            End If
            If vOptions(0, 13) = "" Then
                Me.chkCoronerOnlySub.CheckState = System.Windows.Forms.CheckState.Unchecked
            Else
                Me.chkCoronerOnlySub.CheckState = vOptions(0, 13)
            End If
        Else

            Me.ChkOrgansSub.CheckState = System.Windows.Forms.CheckState.Unchecked
            Me.ChkBoneSub.CheckState = System.Windows.Forms.CheckState.Unchecked
            Me.ChkSoftTissueSub.CheckState = System.Windows.Forms.CheckState.Unchecked
            Me.ChkSkinSub.CheckState = System.Windows.Forms.CheckState.Unchecked
            Me.ChkHeartValvesSub.CheckState = System.Windows.Forms.CheckState.Unchecked
            Me.ChkEyesSub.CheckState = System.Windows.Forms.CheckState.Unchecked
            Me.ChkResearchSub.CheckState = System.Windows.Forms.CheckState.Unchecked
            Me.ChkNoContactOnDenySub.CheckState = System.Windows.Forms.CheckState.Unchecked
            Me.ChkContactOnConsentSub.CheckState = System.Windows.Forms.CheckState.Unchecked
            Me.ChkContactOnHospitalConsentSub.CheckState = System.Windows.Forms.CheckState.Unchecked
            Me.ChkContactOnCoronerSub.CheckState = System.Windows.Forms.CheckState.Unchecked
            Me.chkCoronerOnlySub.CheckState = System.Windows.Forms.CheckState.Unchecked
            Me.ChkContactOnStatlineSecondarySub.CheckState = System.Windows.Forms.CheckState.Unchecked
            Me.ChkContactOnStatlineConsentSub.CheckState = System.Windows.Forms.CheckState.Unchecked

        End If

        'FSProj drh 5/17/02 - Turns the click event code back on
        vUpdateScheduleGroupValue = True

    End Sub



    Private Sub LstViewSubtypeProcessors_ProcessDoubleClick()

        'FSProj drh 5/15/02
        On Error GoTo localError

        Dim vOrder As String = ""

        If LstViewSubtypeProcessors.Items.Count > 0 Then
            If LstViewSubtypeProcessors.FocusedItem.Index <> -1 Then
                If CDbl(LstViewSubtypeProcessors.Items.Item(LstViewSubtypeProcessors.FocusedItem.Index).SubItems.Item(2).Text) <> 0 Then
                    vOrder = InputBox("Please enter the display/processing sequence for this Subtype/Processor: '" & LstViewSubtypeProcessors.FocusedItem.Text & "'.", "Subtype/Processor Order")

                    If vOrder = "" Then
                        Return
                    Else
                        If IsNumeric(vOrder) Then
                            Call modStatSave.SaveCriteriaSubtypeProcessorOrder(CInt(LstViewSubtypeProcessors.Items.Item(LstViewSubtypeProcessors.FocusedItem.Index).SubItems.Item(2).Text), CShort(VB.Left(vOrder, 3)))

                            'FSProj drh 5/15/02 - Clear selected Subtypes list
                            LstViewSubtypeProcessors.Items.Clear()
                            LstViewSubtypeProcessors.View = View.Details

                            'FSProj drh 5/15/02 - Fill the selected subtype/processor grid
                            Call modStatQuery.QuerySubtypeProcessors(Me)

                            'FSProj drh 5/15/02 - Mark Criteria Updated
                            Call modStatSave.SaveCriteriaWorking(Me)
                        Else
                            Call MsgBox("Please enter a valid number.", MsgBoxStyle.OkOnly, "Invalid Number")
                        End If
                    End If
                Else
                    Call MsgBox("Order may only be updated for 'checked' Subtype/Processor items.", MsgBoxStyle.OkOnly, "No Update")
                End If
            Else
                Return
            End If
        End If


        Return
localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        Resume Next
        Resume
    End Sub

    Private Sub LstViewSubtypeProcessors_MouseUp(ByVal sender As System.Object, ByVal e As System.Windows.Forms.MouseEventArgs) Handles LstViewSubtypeProcessors.MouseUp
        LstViewSubtypeProcessorsButton = e.Button
    End Sub

    Private Sub LstViewSubTypeProcessors_ProcessItemCheck()

        On Error GoTo localError

        Dim Item As System.Windows.Forms.ListViewItem = LstViewSubtypeProcessors.FocusedItem
        If (IsNothing(Item)) Then
            Return
        End If

        If (Item.Text = "") Then
            Return
        End If
        'FSProj drh 5/14/02
        'Dim LstViewCriteriaTemplates As New ListView


        If Item.Checked Then
            'Add SubCriteria
            If LstViewCriteriaTemplates.SelectedItems(0).SubItems(2).Text > 0 Then
                'Create SubCriteria using Criteria Template
                Call modStatSave.SaveSubCriteria(Me, NEW_RECORD, True)
            Else
                'Create blank SubCriteria
                Call modStatSave.SaveSubCriteria(Me, NEW_RECORD, False)
            End If

            'FSProj drh 5/15/02 - Clear selected Subtypes list
            LstViewSubtypeProcessors.Items.Clear()
            LstViewSubtypeProcessors.View = View.Details

            'FSProj drh 5/15/02 - Fill the selected subtype/processor grid
            Call modStatQuery.QuerySubtypeProcessors(Me)

            'FSProj drh 5/15/02 - Fill the Subtype/Processor (SubCriteria) drop-downs
            Call modStatQuery.QuerySubCriteriaApplicable(Me)

            'FSProj drh 5/6/02 - Mark Criteria Updated
            Call modStatSave.SaveCriteriaWorking(Me)

        Else
            'Remove SubCriteria
            If MsgBox("Are you sure you want to remove this SubCriteria?", MsgBoxStyle.OkCancel, "SubCriteria Delete") = MsgBoxResult.Ok Then
                If modStatSave.DeleteSubCriteria(Me) <> SUCCESS Then
                    LstViewSubtypeProcessors.FocusedItem.Checked = True
                    Return
                Else
                    'FSProj drh 5/15/02 - Clear selected Subtypes list
                    LstViewSubtypeProcessors.Items.Clear()
                    LstViewSubtypeProcessors.View = View.Details

                    'FSProj drh 5/15/02 - Fill the selected subtype/processor grid
                    Call modStatQuery.QuerySubtypeProcessors(Me)

                    'FSProj drh 5/15/02 - Fill the Subtype/Processor (SubCriteria) drop-downs
                    Call modStatQuery.QuerySubCriteriaApplicable(Me)

                    'FSProj drh 5/6/02 - Mark Criteria Updated
                    Call modStatSave.SaveCriteriaWorking(Me)
                End If
            Else
                LstViewSubtypeProcessors.FocusedItem.Checked = True
                Return
            End If

        End If

        Return
localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        Resume Next
        Resume
    End Sub


    Private Sub LstViewCriteriaTemplates_DoubleClick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewCriteriaTemplates.DoubleClick
        'Dim LstViewCriteriaTemplates As New ListView

        'If LstViewCriteriaTemplates.SelectedItems.Count > 0 Then
        If LstViewCriteriaTemplates.Items.Item(LstViewCriteriaTemplates.FocusedItem.Index).Tag > 0 Then
            frmCriteriaTemplate = New FrmCriteriaTemplate
            frmCriteriaTemplate.vCriteriaTemplateId = LstViewCriteriaTemplates.Items.Item(LstViewCriteriaTemplates.FocusedItem.Index).Tag
            'frmCriteriaTemplate.vCriteriaTemplateId = LstViewCriteriaTemplates.Items.Item(LstViewCriteriaTemplates.SelectedItems.Index).Tag
            frmCriteriaTemplate.vProcessorId = CShort(LstViewCriteriaTemplates.Items.Item(LstViewCriteriaTemplates.FocusedItem.Index).SubItems.Item(2).Text)
            frmCriteriaTemplate.FormState = EXISTING_RECORD
            frmCriteriaTemplate.vCaption = "Criteria Template - " & LstViewCriteriaTemplates.Items.Item(LstViewCriteriaTemplates.FocusedItem.Index).Text
            Dim dialogResult As DialogResult = frmCriteriaTemplate.ShowDialog()
            frmCriteriaTemplate = Nothing

            'FSProj drh 5/8/02 - Fill the criteria templates grid
            LstViewCriteriaTemplates.Items.Clear()
            LstViewCriteriaTemplates.View = View.Details
            Call modStatQuery.QueryCriteriaTemplate(Me)
        Else
            MsgBox("Please select a non-blank template to edit.", MsgBoxStyle.OkOnly, "Blank Template")
        End If
        'End If

    End Sub


    Private Sub LstViewIndication_ColumnClick(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.ColumnClickEventArgs) Handles LstViewIndication.ColumnClick
        Dim ColumnHeader As System.Windows.Forms.ColumnHeader = LstViewIndication.Columns(eventArgs.Column)

        ' When a ColumnHeader object is clicked, the ListView control is
        ' sorted by the subitems of that column.
        ' Set the SortKey to the Index of the ColumnHeader - 1
        LstViewIndication.Sorting = Me.IndicationSortOrder
        LstViewIndication.ListViewItemSorter = New ListViewItemComparer(eventArgs.Column, Me.IndicationSortOrder)

        If Me.IndicationSortOrder = System.Windows.Forms.SortOrder.Ascending Then
            Me.IndicationSortOrder = System.Windows.Forms.SortOrder.Descending
        Else
            Me.IndicationSortOrder = System.Windows.Forms.SortOrder.Ascending
        End If

    End Sub

    Private Sub LstViewIndication_DoubleClick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewIndication.DoubleClick

        Dim vIndicationID As Integer
        Dim vReturn As New Object

        On Error Resume Next

        If Me.CriteriaStatusID <> WORKING_CRITERIA Then
            Exit Sub
        End If

        'Determine the state which to open the
        'form.
        frmIndication = New FrmIndication
        frmIndication.FormState = EXISTING_RECORD
        Call modControl.GetSelListViewID(LstViewIndication, vReturn)
        If IsNothing(vReturn) Then
            'Nothing is selected, so don't show the form
            Exit Sub
        Else
            frmIndication.IndicationID = vReturn(0, 0)
        End If

        'Get the Indication id from the Indication form
        'after the user is done.
        vIndicationID = frmIndication.Display

        If vIndicationID = 0 Then
            'The user cancelled adding a new Indication
            'so do nothing
        Else
            'Remove the current list
            LstViewIndication.Items.Clear()
            LstViewIndication.View = View.Details

            'Refill the list
            Call modStatQuery.QueryCriteriaGroupIndication(Me)
        End If

        TabCriteria.SelectedIndex = 1
        TabCriteria.SelectedIndex = 0

        Me.Activate()

    End Sub



    Private Sub LstViewSchedule_ItemClick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewSchedule.Click

        On Error Resume Next
        Dim Item As New ListViewItem '= LstViewScheduleSub.FocusedItem
        Dim vOptions As New Object

        'ccarroll 04/12/2010 created New ListViewItem Item instance. Changed LstViewScheduleSub to Me.LstViewSchedule
        Item = Me.LstViewSchedule.FocusedItem

        ChkOrgans.Enabled = True
        ChkBone.Enabled = True
        ChkSoftTissue.Enabled = True
        ChkSkin.Enabled = True
        ChkHeartValves.Enabled = True
        ChkEyes.Enabled = True
        ChkResearch.Enabled = True
        ChkContactOnConsent.Enabled = True
        ChkNoContactOnDeny.Enabled = True
        ChkContactOnHospitalConsent.Enabled = True
        ChkContactOnCoroner.Enabled = True
        chkCoronerOnly.Enabled = True
        ChkContactOnStatlineSecondary.Enabled = True
        ChkContactOnStatlineConsent.Enabled = True

        'FSProj drh 5/17/02 - Turn off the click event code temporarily
        vUpdateScheduleGroupValue = False

        'Get the schedule group options
        If modStatQuery.QueryCriteriaScheduleGroupOptions(modControl.GetID(CboCriteriaGroup), modConv.TextToLng(Item.Tag), vOptions) = SUCCESS Then

            If vOptions(0, 0) = "" Then
                Me.ChkOrgans.CheckState = System.Windows.Forms.CheckState.Unchecked
            Else
                Me.ChkOrgans.CheckState = vOptions(0, 0)
            End If
            If vOptions(0, 1) = "" Then
                Me.ChkBone.CheckState = System.Windows.Forms.CheckState.Unchecked
            Else
                Me.ChkBone.CheckState = vOptions(0, 1)
            End If
            If vOptions(0, 2) = "" Then
                Me.ChkSoftTissue.CheckState = System.Windows.Forms.CheckState.Unchecked
            Else
                Me.ChkSoftTissue.CheckState = vOptions(0, 2)
            End If
            If vOptions(0, 3) = "" Then
                Me.ChkSkin.CheckState = System.Windows.Forms.CheckState.Unchecked
            Else
                Me.ChkSkin.CheckState = vOptions(0, 3)
            End If
            If vOptions(0, 4) = "" Then
                Me.ChkHeartValves.CheckState = System.Windows.Forms.CheckState.Unchecked
            Else
                Me.ChkHeartValves.CheckState = vOptions(0, 4)
            End If
            If vOptions(0, 5) = "" Then
                Me.ChkEyes.CheckState = System.Windows.Forms.CheckState.Unchecked
            Else
                Me.ChkEyes.CheckState = vOptions(0, 5)
            End If
            If vOptions(0, 6) = "" Then
                Me.ChkResearch.CheckState = System.Windows.Forms.CheckState.Unchecked
            Else
                Me.ChkResearch.CheckState = vOptions(0, 6)
            End If
            If vOptions(0, 7) = "" Then
                Me.ChkNoContactOnDeny.CheckState = System.Windows.Forms.CheckState.Unchecked
            Else
                Me.ChkNoContactOnDeny.CheckState = vOptions(0, 7)
            End If
            If vOptions(0, 8) = "" Then
                Me.ChkContactOnConsent.CheckState = System.Windows.Forms.CheckState.Unchecked
            Else
                Me.ChkContactOnConsent.CheckState = vOptions(0, 8)
            End If
            If vOptions(0, 9) = "" Then
                Me.ChkContactOnHospitalConsent.CheckState = System.Windows.Forms.CheckState.Unchecked
            Else
                Me.ChkContactOnHospitalConsent.CheckState = vOptions(0, 9)
            End If
            If vOptions(0, 10) = "" Then
                Me.ChkContactOnCoroner.CheckState = System.Windows.Forms.CheckState.Unchecked
            Else
                Me.ChkContactOnCoroner.CheckState = vOptions(0, 10)
            End If
            If vOptions(0, 11) = "" Then
                Me.ChkContactOnStatlineSecondary.CheckState = System.Windows.Forms.CheckState.Unchecked
            Else
                Me.ChkContactOnStatlineSecondary.CheckState = vOptions(0, 11)
            End If
            If vOptions(0, 12) = "" Then
                Me.ChkContactOnStatlineConsent.CheckState = System.Windows.Forms.CheckState.Unchecked
            Else
                Me.ChkContactOnStatlineConsent.CheckState = vOptions(0, 12)
            End If
            If vOptions(0, 13) = "" Then
                Me.chkCoronerOnly.CheckState = System.Windows.Forms.CheckState.Unchecked
            Else
                Me.chkCoronerOnly.CheckState = vOptions(0, 13)
            End If
        Else

            Me.ChkOrgans.CheckState = System.Windows.Forms.CheckState.Unchecked
            Me.ChkBone.CheckState = System.Windows.Forms.CheckState.Unchecked
            Me.ChkSoftTissue.CheckState = System.Windows.Forms.CheckState.Unchecked
            Me.ChkSkin.CheckState = System.Windows.Forms.CheckState.Unchecked
            Me.ChkHeartValves.CheckState = System.Windows.Forms.CheckState.Unchecked
            Me.ChkEyes.CheckState = System.Windows.Forms.CheckState.Unchecked
            Me.ChkResearch.CheckState = System.Windows.Forms.CheckState.Unchecked
            Me.ChkNoContactOnDeny.CheckState = System.Windows.Forms.CheckState.Unchecked
            Me.ChkContactOnConsent.CheckState = System.Windows.Forms.CheckState.Unchecked
            Me.ChkContactOnHospitalConsent.CheckState = System.Windows.Forms.CheckState.Unchecked
            Me.ChkContactOnCoroner.CheckState = System.Windows.Forms.CheckState.Unchecked
            Me.chkCoronerOnly.CheckState = System.Windows.Forms.CheckState.Unchecked
            Me.ChkContactOnStatlineSecondary.CheckState = System.Windows.Forms.CheckState.Unchecked
            Me.ChkContactOnStatlineConsent.CheckState = System.Windows.Forms.CheckState.Unchecked

        End If

        'FSProj drh 5/17/02 - Turns the click event code back on
        vUpdateScheduleGroupValue = True

    End Sub


    Private Sub LstViewSelectedOrganizations_ColumnClick(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.ColumnClickEventArgs) Handles LstViewSelectedOrganizations.ColumnClick
        Dim ColumnHeader As System.Windows.Forms.ColumnHeader = LstViewSelectedOrganizations.Columns(eventArgs.Column)

        ' When a ColumnHeader object is clicked, the ListView control is
        ' sorted by the subitems of that column.
        ' Set the SortKey to the Index of the ColumnHeader - 1
        LstViewSelectedOrganizations.Sorting = Me.AvailableSortOrder
        LstViewSelectedOrganizations.ListViewItemSorter = New ListViewItemComparer(eventArgs.Column, Me.AvailableSortOrder)

        If Me.SelectedSortOrder = System.Windows.Forms.SortOrder.Ascending Then
            Me.SelectedSortOrder = System.Windows.Forms.SortOrder.Descending
        Else
            Me.SelectedSortOrder = System.Windows.Forms.SortOrder.Ascending
        End If

    End Sub




    Public Function Display() As Object


        Me.ShowDialog()

    End Function



    Public Function ClearAll() As Object

        'Clear criteria
        LstViewIndication.Items.Clear()
        LstViewIndication.View = View.Details
        TxtMaleUpper.Text = ""
        TxtMaleLower.Text = ""
        TxtFemaleUpper.Text = ""
        TxtFemaleLower.Text = ""
        TxtVerifyMessage.Text = ""
        TxtUpperWeight.Text = ""
        TxtLowerWeight.Text = ""
        TxtGeneralRuleout.Text = ""

        'Clear on call organizations
        LstViewAvailableOrganizations.Items.Clear()
        LstViewAvailableOrganizations.View = View.Details
        LstViewSelectedOrganizations.Items.Clear()
        LstViewSelectedOrganizations.View = View.Details

        SourceCodes = Nothing
        LstViewSourceCodes.Items.Clear()

        Call modControl.SelectNone(CboOrganization)
        Call modControl.SelectNone(CboScheduleGroup)

        LstViewSchedule.Items.Clear()

        'FSProj drh 5/17/02 - Turn off the click event code temporarily
        vUpdateScheduleGroupValue = False

        Me.ChkOrgans.CheckState = System.Windows.Forms.CheckState.Unchecked
        Me.ChkBone.CheckState = System.Windows.Forms.CheckState.Unchecked
        Me.ChkSoftTissue.CheckState = System.Windows.Forms.CheckState.Unchecked
        Me.ChkSkin.CheckState = System.Windows.Forms.CheckState.Unchecked
        Me.ChkHeartValves.CheckState = System.Windows.Forms.CheckState.Unchecked
        Me.ChkEyes.CheckState = System.Windows.Forms.CheckState.Unchecked
        Me.ChkResearch.CheckState = System.Windows.Forms.CheckState.Unchecked
        Me.ChkContactOnConsent.CheckState = System.Windows.Forms.CheckState.Unchecked
        Me.ChkNoContactOnDeny.CheckState = System.Windows.Forms.CheckState.Unchecked
        Me.ChkContactOnHospitalConsent.CheckState = System.Windows.Forms.CheckState.Unchecked
        Me.ChkContactOnCoroner.CheckState = System.Windows.Forms.CheckState.Unchecked
        Me.ChkContactOnStatlineSecondary.CheckState = System.Windows.Forms.CheckState.Unchecked
        Me.ChkContactOnStatlineConsent.CheckState = System.Windows.Forms.CheckState.Unchecked

        'FSProj drh 5/17/02 - Turns the click event code back on
        vUpdateScheduleGroupValue = True

        Me.ChkOrgans.Enabled = False
        Me.ChkBone.Enabled = False
        Me.ChkSoftTissue.Enabled = False
        Me.ChkSkin.Enabled = False
        Me.ChkHeartValves.Enabled = False
        Me.ChkEyes.Enabled = False
        Me.ChkResearch.Enabled = False
        Me.ChkContactOnConsent.Enabled = False
        Me.ChkNoContactOnDeny.Enabled = False
        Me.ChkContactOnHospitalConsent.Enabled = False
        Me.ChkContactOnCoroner.Enabled = False
        Me.chkCoronerOnly.Enabled = False
        Me.ChkContactOnStatlineSecondary.Enabled = False
        Me.ChkContactOnStatlineConsent.Enabled = False

    End Function

    Public Function ClearAllSub() As Object
        'FSProj drh 5/17/02

        'FSProj drh 5/15/02 - Clear SubCriteria items
        ChkNotAppropriateMaleSub.CheckState = System.Windows.Forms.CheckState.Unchecked
        ChkNotAppropriateFemaleSub.CheckState = System.Windows.Forms.CheckState.Unchecked
        TxtMaleUpperSub.Text = ""
        TxtMaleLowerSub.Text = ""
        TxtFemaleUpperSub.Text = ""
        TxtFemaleLowerSub.Text = ""
        TxtUpperWeightSub.Text = ""
        TxtLowerWeightSub.Text = ""
        TxtGeneralRuleoutSub.Text = ""
        ChkReferNonPotentialSub.CheckState = System.Windows.Forms.CheckState.Unchecked

        'Turn off event buttons
        cmdSaveSubCriteria.Enabled = False
        cmdAddConditional.Enabled = False
        cmdRemoveConditional.Enabled = False

        'FSProj drh 5/6/02 - Clear SubCriteria lists
        LstViewAvailableSubtypes.Items.Clear()
        LstViewAvailableSubtypes.View = View.Details
        LstViewSelectedSubtypes.Items.Clear()
        LstViewSelectedSubtypes.View = View.Details
        LstViewAvailableProcessors.Items.Clear()
        LstViewAvailableProcessors.View = View.Details
        LstViewSelectedProcessors.Items.Clear()
        LstViewSelectedProcessors.View = View.Details
        LstViewCriteriaTemplates.Items.Clear()
        LstViewCriteriaTemplates.View = View.Details
        LstViewSubtypeProcessors.Items.Clear()
        LstViewSubtypeProcessors.View = View.Details
        LstViewConditionals.Items.Clear()
        LstViewConditionals.View = View.Details
        LstViewScheduleSub.Items.Clear()
        LstViewScheduleSub.View = View.Details

        'FSProj drh 5/17/02 - Turn off the click event code temporarily
        vUpdateScheduleGroupValue = False

        'FSProj drh 5/17/02 - Clear SubCriteria Schedule Group items
        Me.ChkOrgansSub.CheckState = System.Windows.Forms.CheckState.Unchecked
        Me.ChkBoneSub.CheckState = System.Windows.Forms.CheckState.Unchecked
        Me.ChkSoftTissueSub.CheckState = System.Windows.Forms.CheckState.Unchecked
        Me.ChkSkinSub.CheckState = System.Windows.Forms.CheckState.Unchecked
        Me.ChkHeartValvesSub.CheckState = System.Windows.Forms.CheckState.Unchecked
        Me.ChkEyesSub.CheckState = System.Windows.Forms.CheckState.Unchecked
        Me.ChkResearchSub.CheckState = System.Windows.Forms.CheckState.Unchecked
        Me.ChkNoContactOnDenySub.CheckState = System.Windows.Forms.CheckState.Unchecked
        Me.ChkContactOnConsentSub.CheckState = System.Windows.Forms.CheckState.Unchecked
        Me.ChkContactOnHospitalConsentSub.CheckState = System.Windows.Forms.CheckState.Unchecked
        Me.ChkContactOnCoronerSub.CheckState = System.Windows.Forms.CheckState.Unchecked
        Me.chkCoronerOnlySub.CheckState = System.Windows.Forms.CheckState.Unchecked
        Me.ChkContactOnStatlineSecondarySub.CheckState = System.Windows.Forms.CheckState.Unchecked
        Me.ChkContactOnStatlineConsentSub.CheckState = System.Windows.Forms.CheckState.Unchecked

        'FSProj drh 5/17/02 - Turns the click event code back on
        vUpdateScheduleGroupValue = True

        'FSProj drh 5/17/02 - Disable SubCriteria Schedule Group items
        ChkOrgansSub.Enabled = False
        ChkBoneSub.Enabled = False
        ChkSoftTissueSub.Enabled = False
        ChkSkinSub.Enabled = False
        ChkHeartValvesSub.Enabled = False
        ChkEyesSub.Enabled = False
        ChkResearchSub.Enabled = False
        ChkContactOnConsentSub.Enabled = False
        ChkNoContactOnDenySub.Enabled = False
        ChkContactOnHospitalConsentSub.Enabled = False
        ChkContactOnCoronerSub.Enabled = False
        chkCoronerOnlySub.Enabled = False
        ChkContactOnStatlineSecondarySub.Enabled = False
        ChkContactOnStatlineConsentSub.Enabled = False

        'Clear the Schedule Groups and select nothing in Organizations
        Me.cboOrganizationSub.SelectedIndex = -1
        Me.cboScheduleGroupSub.Items.Clear()

    End Function

    Public Function GetCriteria() As Object

        Call modUtility.Work()

        Call Me.ClearAll()

        'Get the current category ID
        Me.DonorCategoryID = modControl.GetID(CboDonorCategory)

        'Get the current criteria group ID
        Me.CriteriaGroupID = modControl.GetID(CboCriteriaGroup)

        'Fill the Criteria info
        Call modStatQuery.QueryCategoryCriteria(Me)

        'Fill the selected organizations grid
        Call modStatQuery.QueryCriteriaReferralOrganization(Me)

        'FSProj drh 5/6/02 - Fill the selected subtypes grid
        Call modStatQuery.QueryCriteriaSubtype(Me)

        'FSProj drh 5/6/02 - Fill the available subtypes grid
        Call modStatQuery.QueryAvailableSubtype(Me)

        'FSProj drh 5/6/02 - Fill the selected subtypes grid
        Call modStatQuery.QueryCriteriaProcessor(Me)

        'FSProj drh 5/8/02 - Fill the criteria templates grid
        Call modStatQuery.QueryCriteriaTemplate(Me)

        'FSProj drh 5/8/02 - Fill the subtype/processor info
        If Me.LstViewCriteriaTemplates.Items.Count > 0 Then
            Call modStatQuery.QuerySubtypeProcessors(Me)
        End If

        'Fill the indication lists
        Call modStatQuery.QueryCriteriaGroupIndication(Me)

        'Fill the standard MRO list
        Call modStatQuery.QueryCriteriaGroupIndicationSMRO(Me)

        'Fill the source codes
        Call modStatQuery.QueryCriteriaSourceCode(Me)

        'Fill the schedule groups
        Call modStatQuery.QueryCriteriaScheduleGroup(Me)

        'FSProj drh 5/15/02 - Fill the Subtype/Processor (SubCriteria) drop-downs
        Call modStatQuery.QuerySubCriteriaApplicable(Me)

        Call modUtility.Done()

    End Function



    Private Sub LstViewSelectedSubtypes_DoubleClick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewSelectedSubtypes.DoubleClick
        'FSProj drh 5/8/02

        Dim vOrder As String = ""

        If LstViewSelectedSubtypes.SelectedItems.Count > 0 Then
            If LstViewSelectedSubtypes.FocusedItem.Index <> -1 Then
                vOrder = InputBox("Please enter the display/processing sequence for Subtype: '" & LstViewSelectedSubtypes.FocusedItem.Text & "'.", "Subtype Order")

                If vOrder = "" Then
                    Exit Sub
                Else
                    If IsNumeric(vOrder) Then
                        Call modStatSave.SaveCriteriaSubtypeOrder((LstViewSelectedSubtypes.Items.Item(LstViewSelectedSubtypes.FocusedItem.Index).Tag), CShort(VB.Left(vOrder, 3)))

                        'FSProj drh 5/8/02 - Clear selected Subtypes list
                        LstViewSelectedSubtypes.Items.Clear()
                        LstViewSelectedSubtypes.View = View.Details

                        'FSProj drh 5/8/02 - Fill the selected subtypes grid
                        Call modStatQuery.QueryCriteriaSubtype(Me)

                        'FSProj drh 5/8/02 - Mark Criteria Updated
                        Call modStatSave.SaveCriteriaWorking(Me)
                    Else
                        Call MsgBox("Please enter a valid number.", MsgBoxStyle.OkOnly, "Invalid Number")
                    End If
                End If
            Else
                Exit Sub
            End If
        End If

    End Sub


    Private Sub Picture2_Click()

    End Sub



    Private Sub RemoveSchedule_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles RemoveSchedule.Click

        On Error Resume Next

        Dim vScheduleGroupID As Integer

        vScheduleGroupID = LstViewSchedule.FocusedItem.Tag

        'Delete the item
        Call modStatSave.DeleteCriteriaGroupScheduleGroup(Me, vScheduleGroupID)

        'Clear the list
        LstViewSchedule.Items.Clear()

        'Fill the schedule groups
        Call modStatQuery.QueryCriteriaScheduleGroup(Me)

        If LstViewSchedule.Items.Count = 0 Then
            Me.ChkOrgans.Enabled = False
            Me.ChkBone.Enabled = False
            Me.ChkSoftTissue.Enabled = False
            Me.ChkSkin.Enabled = False
            Me.ChkHeartValves.Enabled = False
            Me.ChkEyes.Enabled = False
            Me.ChkResearch.Enabled = False
        End If

    End Sub


    Private Sub TxtFemaleLower_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtFemaleLower.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtFemaleLower_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtFemaleLower.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        If (KeyAscii = 121 Or KeyAscii = 89) Then
            If Lable(15).Text = "Lower              mos." Then
                Lable(15).Text = "Lower              yrs."
            End If
        ElseIf (KeyAscii = 109 Or KeyAscii = 77) Then
            If Lable(15).Text = "Lower              yrs." Then
                Lable(15).Text = "Lower              mos."
            End If
        End If

        KeyAscii = modMask.NumMask(KeyAscii, 3, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtFemaleLowerSub_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtFemaleLowerSub.Enter
        Call modControl.HighlightText(ActiveControl)
    End Sub

    Private Sub TxtFemaleLowerSub_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtFemaleLowerSub.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        If (KeyAscii = 121 Or KeyAscii = 89) Then
            If LableSub(15).Text = "Lower              mos." Then
                LableSub(15).Text = "Lower              yrs."
            End If
        ElseIf (KeyAscii = 109 Or KeyAscii = 77) Then
            If LableSub(15).Text = "Lower              yrs." Then
                LableSub(15).Text = "Lower              mos."
            End If
        End If

        KeyAscii = modMask.NumMask(KeyAscii, 3, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtFemaleLowerWeightSub_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtFemaleLowerWeightSub.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        KeyAscii = modMask.DecimalMask(KeyAscii, 7, 2, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtFemaleUpper_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtFemaleUpper.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtFemaleUpper_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtFemaleUpper.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        If (KeyAscii = 121 Or KeyAscii = 89) Then
            If Lable(13).Text = "Upper              mos." Then
                Lable(13).Text = "Upper              yrs."
            End If
        ElseIf (KeyAscii = 109 Or KeyAscii = 77) Then
            If Lable(13).Text = "Upper              yrs." Then
                Lable(13).Text = "Upper              mos."
            End If
        End If

        KeyAscii = modMask.NumMask(KeyAscii, 3, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtFemaleUpperSub_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtFemaleUpperSub.Enter
        Call modControl.HighlightText(ActiveControl)
    End Sub

    Private Sub TxtFemaleUpperSub_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtFemaleUpperSub.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        If (KeyAscii = 121 Or KeyAscii = 89) Then
            If LableSub(13).Text = "Upper              mos." Then
                LableSub(13).Text = "Upper              yrs."
            End If
        ElseIf (KeyAscii = 109 Or KeyAscii = 77) Then
            If LableSub(13).Text = "Upper              yrs." Then
                LableSub(13).Text = "Upper              mos."
            End If
        End If

        KeyAscii = modMask.NumMask(KeyAscii, 3, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtFemaleUpperWeightSub_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtFemaleUpperWeightSub.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        KeyAscii = modMask.DecimalMask(KeyAscii, 7, 2, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtGeneralRuleout_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtGeneralRuleout.Enter

        Call modControl.HighlightText(ActiveControl)


    End Sub


    Private Sub TxtGeneralRuleoutSub_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtGeneralRuleoutSub.Enter
        Call modControl.HighlightText(ActiveControl)
    End Sub


    Private Sub TxtLowerWeightSub_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtLowerWeightSub.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        KeyAscii = modMask.DecimalMask(KeyAscii, 7, 2, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtMaleLower_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtMaleLower.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtMaleLower_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtMaleLower.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        If (KeyAscii = 121 Or KeyAscii = 89) Then
            If Lable(10).Text = "Lower              mos." Then
                Lable(10).Text = "Lower              yrs."
            End If
        ElseIf (KeyAscii = 109 Or KeyAscii = 77) Then
            If Lable(10).Text = "Lower              yrs." Then
                Lable(10).Text = "Lower              mos."
            End If
        End If

        KeyAscii = modMask.NumMask(KeyAscii, 3, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub





    Private Sub TxtMaleLowerSub_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtMaleLowerSub.Enter
        Call modControl.HighlightText(ActiveControl)
    End Sub

    Private Sub TxtMaleLowerSub_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtMaleLowerSub.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        If (KeyAscii = 121 Or KeyAscii = 89) Then
            If LableSub(10).Text = "Lower              mos." Then
                LableSub(10).Text = "Lower              yrs."
            End If
        ElseIf (KeyAscii = 109 Or KeyAscii = 77) Then
            If LableSub(10).Text = "Lower              yrs." Then
                LableSub(10).Text = "Lower              mos."
            End If
        End If

        KeyAscii = modMask.NumMask(KeyAscii, 3, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtMaleUpper_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtMaleUpper.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtMaleUpper_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtMaleUpper.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        If (KeyAscii = 121 Or KeyAscii = 89) Then
            If Lable(11).Text = "Upper              mos." Then
                Lable(11).Text = "Upper              yrs."
            End If
        ElseIf (KeyAscii = 109 Or KeyAscii = 77) Then
            If Lable(11).Text = "Upper              yrs." Then
                Lable(11).Text = "Upper              mos."
            End If
        End If

        KeyAscii = modMask.NumMask(KeyAscii, 3, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub






    Private Sub TxtMaleUpperSub_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtMaleUpperSub.Enter
        Call modControl.HighlightText(ActiveControl)
    End Sub

    Private Sub TxtMaleUpperSub_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtMaleUpperSub.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        If (KeyAscii = 121 Or KeyAscii = 89) Then
            If LableSub(11).Text = "Upper              mos." Then
                LableSub(11).Text = "Upper              yrs."
            End If
        ElseIf (KeyAscii = 109 Or KeyAscii = 77) Then
            If LableSub(11).Text = "Upper              yrs." Then
                LableSub(11).Text = "Upper              mos."
            End If
        End If

        KeyAscii = modMask.NumMask(KeyAscii, 3, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtUpperWeightSub_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtUpperWeightSub.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        KeyAscii = modMask.DecimalMask(KeyAscii, 7, 2, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub _LableSub_14_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles _LableSub_14.Click

    End Sub


    Public Sub LstViewSubtypeProcessors_ItemChecked(ByVal sender As System.Object, ByVal e As System.Windows.Forms.ItemCheckedEventArgs) Handles LstViewSubtypeProcessors.ItemChecked
        LstViewSubtypeProcessors.FocusedItem = e.Item
        If LstViewSubtypeProcessorsButton = Windows.Forms.MouseButtons.Left Then
            LstViewSubtypeProcessorsButton = 0
            LstViewSubTypeProcessors_ProcessItemCheck()
        End If

    End Sub


    Private Sub LstViewSubtypeProcessors_DoubleClick(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles LstViewSubtypeProcessors.DoubleClick

        If LstViewSubtypeProcessorsButton = Windows.Forms.MouseButtons.Right Then
            LstViewSubtypeProcessorsButton = 0
            LstViewSubtypeProcessors_ProcessDoubleClick()
        End If

    End Sub

    Private Sub CboCriteriaGroup_Leave(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles CboCriteriaGroup.Leave
        Call CboCriteriaGroup_SelectedIndexChanged(CboCriteriaGroup, New System.EventArgs())
    End Sub
End Class