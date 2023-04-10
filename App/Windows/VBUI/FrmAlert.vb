Option Strict Off
Option Explicit On

Imports System.Drawing.Text
Imports Statline.Stattrac.Windows.CSharpUIMap
Imports Statline.Stattrac.Common
Imports Statline.Stattrac.Constant


Public Class FrmAlert
    Inherits System.Windows.Forms.Form

    Public FormState As Short
    Public AlertID As Integer
    Public AlertName As String
    Public AlertType As Short
    Public Saved As Short
    Public Loaded As Short

    Public AvailableGridList As Object
    Public AvailableSortOrder As Short
    Public SelectedGridList As Object
    Public SelectedSortOrder As Short

    Public I As Short


    Public SourceCodes As New colSourceCodes
    'Char Chaput 04/28/06 added new RTF Class
    Public RTF As New clsRTF


    Public AuditLogId As Integer 'AT2 drh 10/29/03
    Public AuditNoUpdate As Boolean 'AT2 drh 10/29/03
    Private frmAlertGroup As FrmAlertGroup
    'bret 02/01/11 
    Private uIMap As UIMap
    Private sourceCodeId As Integer
    Private sourceCodeName As String
    Private sourceCodeCallTypeId As Integer
    Private sourceCodeCallTypeName As String






    Private Sub CboAlertGroup_Leave(ByVal sender As Object, ByVal e As System.EventArgs) Handles CboAlertGroup.Leave
        Call CboAlertGroup_SelectedIndexChanged(CboAlertGroup, New System.EventArgs())
    End Sub
    Private Sub CboAlertGroup_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboAlertGroup.SelectedIndexChanged

        Call modUtility.Work()

        'Determine the state which to open the
        'form.
        If modControl.GetID(CboAlertGroup) = -1 Then
            Me.FormState = NEW_RECORD
            Me.AlertID = 0
        Else
            Me.FormState = EXISTING_RECORD
            Me.AlertID = modControl.GetID(CboAlertGroup)
        End If

        'AT2 drh 10/29/03 - See if an update is required
        If Not Me.AuditNoUpdate Then
            'AT2 drh 10/29/03 - If there's an existing Alert open, save final Audit Info
            If Me.AuditLogId > 0 Then
                'Call modStatAudit.AuditAlertSave(Me, AUDIT_REVIEW)
            End If

            'AT2 drh 10/29/03 - Save initial Audit Info for newly-selected Alert
            'Call modStatAudit.AuditAlertSave(Me, AUDIT_UNKNOWN)
        Else
            If Me.AuditLogId = 0 Then
                'AT2 drh 10/29/03 - Save initial Audit Info for newly-created/selected Alert
                ' Call modStatAudit.AuditAlertSave(Me, AUDIT_UNKNOWN)
            End If

            Me.AuditNoUpdate = False
        End If

        'Clear the Report and on call for lists.
        Call Me.ClearAll()

        'Fill the selected organizations grid
        Call modStatQuery.QueryAlertOrganization(Me)

        'Fill the source codes
        Call modStatQuery.QueryAlertSourceCode(Me)

        'Get the service level settings
        Call modStatQuery.QueryAlert(Me)

        If Me.AlertID = -1 Then
            CmdSelect.Enabled = False
            CmdDeselect.Enabled = False
        Else
            CmdSelect.Enabled = True
            CmdDeselect.Enabled = True
        End If

        Call modUtility.Done()

    End Sub



    Private Sub CboAlertgroup_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles CboAlertGroup.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        'Allow the delete key to clear the combo box
        Call modControl.AllowDelete(CboAlertGroup, KeyAscii)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub
    Private Sub CboType_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboType.SelectedIndexChanged


        Me.ClearAll()

        Select Case modControl.GetID(CboType)

            Case REFERRAL
                Me.AlertType = REFERRAL
                Me.Frame(1).Text = "Referral Alerts"
                Me.LblAlert1.Text = "This field should be used for medical information."
                Me.LblAlert2.Text = "This field should be used for approach instructions (hospital or agency) and any other miscellaneous info."
            Case Message
                Me.AlertType = Message
                Me.Frame(1).Text = "Message Alerts"
                Me.LblAlert2.Text = "This field should be used for announcements. Things that may change over time."
                Me.LblAlert1.Text = "If this alert applies to multiple organizations, this field should decribe rules for which organization should be contacted. Should be similar to the Alert Schedule Note."
            Case IMPORT
                Me.AlertType = IMPORT
                Me.Frame(1).Text = "Import Alerts"
                Me.LblAlert2.Text = "This field should be used for announcements. Things that may change over time."
                Me.LblAlert1.Text = "If this alert applies to multiple organizations, this field should decribe rules for which organization should be contacted. Should be similar to the Alert Schedule Note."
        End Select

        'Fill the Alert list box
        Call modStatRefQuery.ListRefQueryAlertGroup(CboAlertGroup, Me.AlertType)
        modControl.SelectID(CboAlertGroup, 0)

    End Sub


    Private Sub CmdAdd_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdAdd.Click

        If uIMap Is Nothing Then
            uIMap = OpenStatTracCSharpForms.CreateInstance()
        End If

        'ccarroll 03/08/2011 
        'Get SourceCode selection from SourceCode Popup
        Me.sourceCodeCallTypeId = modControl.GetID((Me.CboType))
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
        Call modStatSave.SaveAlertSourceCodes(Me)


    End Sub

    Private Sub CmdCancel_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdCancel.Click

        Me.Close()

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
        Call modStatSave.DeleteAlertOrganizations(vReturn)

        'Remove the current list
        LstViewSelectedOrganizations.Items.Clear()
        LstViewSelectedOrganizations.View = View.Details

        'Refill the selected organizations list
        Call modStatQuery.QueryAlertOrganization(Me)

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


    Private Sub CmdOK_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdOK.Click

        Dim vReturn As Short

        'Make sure the user wants to save
        vReturn = modMsgForm.FormSave

        If vReturn = MsgBoxResult.Cancel Then
            Exit Sub
        End If

        'Validate the data
        If Not modStatValidate.Alert(Me) Then
            Exit Sub
        End If

        Call modUtility.Work()

        'Save the alert
        Call modStatSave.SaveAlert(Me)
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

    Private Sub CmdPrintList_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdPrintList.Click


        Dim vReportParameters As String = ""
        Dim vReportName As String = ""

        On Error GoTo handleError

        Call modUtility.Work()

        'Set the report name
        If modControl.GetID((Me.CboType)) = 1 Then
            vReportName = "AlertList.rpt"
        Else
            vReportName = "AlertList2.rpt"
        End If

        vReportParameters = "{Alert.AlertTypeID} = " & modControl.GetID((Me.CboType))

        'Get the report file name
        Select Case AppMain.ConnectionType
            Case PROD_CONN
                                ' bret 01/13/2010 remove reference ParentForm.CrystalReport1.ReportFileName = AppMain.ReportDirectory & vReportName
                                ' bret 01/13/2010 remove reference ParentForm.CrystalReport1.Connect = "DSN = Production;UID = " & AppMain.DBUserID & ";PWD = " & AppMain.DBPassword & ";DSQ =_ReferralProd"
            Case TEST_CONN
                MsgBox("You cannot print from the Test database.")
            Case PROD_BKUP_CONN
                MsgBox("You cannot print from the Backup Production database.")
        End Select



        Call modUtility.Done()

        Exit Sub

handleError:

        If Err.Number = 20504 Or Err.Number = 20997 Then
            Call modMsgForm.MissingReport()
        Else
            MsgBox("There has been a reporting error. Please try again. If the problem continues, contact your system administrator.", , "Reporting Error")
        End If

        Call modUtility.Done()


    End Sub

    Private Sub CmdRemove_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdRemove.Click

        If Me.LstViewSourceCodes.Items.Count > 0 Then

            Call SourceCodes.Remove(Me.LstViewSourceCodes.FocusedItem.Tag)

            Call SourceCodes.FillListView2(LstViewSourceCodes)

            Call modStatSave.SaveAlertSourceCodes(Me)

        End If

    End Sub

    Private Sub cmdSelect_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdSelect.Click

        Dim vReturn As New Object

        Call modUtility.Work()

        If LstViewAvailableOrganizations.Items.Count > 0 Then
            Call modControl.GetSelListViewID(LstViewAvailableOrganizations, vReturn)
        Else
            Call modUtility.Done()
            Exit Sub
        End If

        'Insert each of the new rows in the database
        If modStatSave.SaveAlertOrganizations(Me, vReturn) = SUCCESS Then

            'Remove the current list
            LstViewSelectedOrganizations.Items.Clear()
            LstViewSelectedOrganizations.View = View.Details

            'Refill the selected organizations list
            Call modStatQuery.QueryAlertOrganization(Me)

        End If

        Call modUtility.Done()

    End Sub
    Private Sub CmdAlertGroupDetail_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdAlertGroupDetail.Click

        Dim vAlertGroupID As Integer
        Dim vReturn As New Object

        On Error Resume Next

        frmAlertGroup = New FrmAlertGroup()
        'Determine the state which to open the
        'form.
        If modControl.GetID(CboAlertGroup) = -1 Then
            frmAlertGroup.FormState = NEW_RECORD
            frmAlertGroup.AlertGroupID = 0
        Else
            frmAlertGroup.FormState = EXISTING_RECORD
            frmAlertGroup.AlertGroupID = modControl.GetID(CboAlertGroup)
            frmAlertGroup.TxtName.Text = modControl.GetText(CboAlertGroup)
        End If

        frmAlertGroup.AlertType = modControl.GetID(CboType)

        'Get the AlertGroup id from the AlertGroup form
        'after the user is done.
        Me.SendToBack()
        vAlertGroupID = frmAlertGroup.Display()
        frmAlertGroup = Nothing

        'AT2 drh 10/29/03 - Do not need to update when CboAlertGroup
        'click event is fired since update was handled in FrmAlertGroup
        Me.AuditNoUpdate = True

        If vAlertGroupID = 0 Then
            'The user cancelled adding a new AlertGroup
            'so do nothing
        Else
            'Refill the combo box with the new (or updated)
            'AlertGroup id and name
            Call modStatRefQuery.ListRefQueryAlertGroup(CboAlertGroup, Me.AlertType)
            Call modControl.SelectID(CboAlertGroup, vAlertGroupID)
        End If

    End Sub


    Private Sub CmdUnassigned_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdUnassigned.Click

        Call modUtility.Work()

        'Clear the grid
        LstViewAvailableOrganizations.Items.Clear()
        LstViewAvailableOrganizations.View = View.Details

        'Fill Grid
        Call modStatQuery.QueryUnassignedAlertOrganization(Me)

        Call modUtility.Done()

    End Sub
    Private Sub FrmAlert_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load
        Dim intI As Short ' counter

        Call modUtility.CenterForm()

        Me.Saved = False
        Me.Loaded = False

        'ccarroll 04/08/2010 changed value description pair to use constants 
        CboType.Items.Add(New ValueDescriptionPair(REFERRAL, "Referrals"))
        CboType.Items.Add(New ValueDescriptionPair(Message, "Messages"))
        CboType.Items.Add(New ValueDescriptionPair(IMPORT, "Imports"))
        Call modControl.SelectFirst(CboType)

        '*******************************
        'Initialize 'Applies To' Information
        '*******************************
        'ccarroll 01/20/2010 changed to zero based array for VB.Net conversion.

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

        'Get the reference data
        Call modStatRefQuery.RefQueryState(CboState, , , , , True)
        Call modStatRefQuery.RefQueryOrganizationType(CboOrganizationType, , , , , True)
        'Set the default types
        Call modControl.SelectID(CboState, ALL_STATES)
        Call modControl.SelectID(CboOrganizationType, ALL_ORG_TYPES)

        'Fill up the Font Name combo box

        ' Get the installed fonts collection.
        Dim installedFonts As New InstalledFontCollection

        ' Get an array of the system's font familiies.
        Dim font_families() As FontFamily = installedFonts.Families()

        ' Display the font families.
        For Each fontFamily As FontFamily In font_families
            cmbfont.Items.Add(fontFamily.Name)
        Next fontFamily

        '' fill size combo
        For intI = 6 To 150
            cmbsize.Items.Add(Str(intI))
        Next intI

        '' set default font to Arial 9pt
        ''
        cmbsize.SelectedIndex = cmbsize.FindStringExact(" 9")
        cmbfont.SelectedIndex = cmbfont.FindStringExact("Arial")

        Me.AvailableSortOrder = System.Windows.Forms.SortOrder.Ascending

        Me.Loaded = True

    End Sub


    Private Sub FrmAlert_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing

        Dim vReturn As Short

        If Me.Saved = True Then
            'The message was saved so just unload
            eventArgs.Cancel = False

        Else
            'The message was cancelled or closed so confirm cancellation
            vReturn = modMsgForm.FormCancel
            If vReturn = MsgBoxResult.Yes Then
                'AT2 drh 10/29/03 - Save final Audit Info

                eventArgs.Cancel = False

            Else
                eventArgs.Cancel = True
                Exit Sub
            End If
        End If

        RTF = Nothing
        'Me.Dispose()
        AppMain.frmAlert = Nothing

    End Sub
    Public Function Display() As Object

        Dim dialogResult As DialogResult = Me.ShowDialog()
        Dispose()
    End Function
    Public Function ClearAll() As Object

        'Clear on call organizations
        LstViewAvailableOrganizations.Items.Clear()
        LstViewAvailableOrganizations.View = View.Details
        LstViewSelectedOrganizations.Items.Clear()
        LstViewSelectedOrganizations.View = View.Details

        Me.TxtAlerts(0).Text = ""
        Me.TxtAlerts(1).Text = ""
        Me.TxtAlerts(2).Text = ""

        SourceCodes = Nothing
        LstViewSourceCodes.Items.Clear()

    End Function
    Private Sub LstViewAvailableOrganizations_ColumnClick(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.ColumnClickEventArgs) Handles LstViewAvailableOrganizations.ColumnClick
        Dim ColumnHeader As System.Windows.Forms.ColumnHeader = LstViewAvailableOrganizations.Columns(eventArgs.Column)

        ' When a ColumnHeader object is clicked, the ListView control is
        ' sorted by the subitems of that column.
        ' Set the SortKey to the Index of the ColumnHeader - 1
        LstViewAvailableOrganizations.Sorting = Me.AvailableSortOrder

        LstViewAvailableOrganizations.ListViewItemSorter = New ListViewItemComparer(eventArgs.Column, LstViewAvailableOrganizations.Sorting)

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
        LstViewSelectedOrganizations.ListViewItemSorter = New ListViewItemComparer(eventArgs.Column, LstViewSelectedOrganizations.Sorting)

        If Me.SelectedSortOrder = System.Windows.Forms.SortOrder.Ascending Then
            Me.SelectedSortOrder = System.Windows.Forms.SortOrder.Descending
        Else
            Me.SelectedSortOrder = System.Windows.Forms.SortOrder.Ascending
        End If

    End Sub

    Private Sub TxtAlerts_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtAlerts.Enter
        Dim Index As Short = TxtAlerts.GetIndex(eventSender)
        '************************************************************************************
        'Date Changed: 4/28/06                          Changed by: Char Chaput
        'Release #: 8.0                               Task: Unknown
        'Description:  Added for RTF
        '====================================================================================
        '************************************************************************************
        I = Index
        Call RTF.UpdateTextInfo((Me.Toolbar1), Me.TxtAlerts(I), (Me.cmbfont), (Me.cmbsize))
    End Sub

    Private Sub TxtAlerts_SelectionChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtAlerts.SelectionChanged
        Dim Index As Short = TxtAlerts.GetIndex(eventSender)
        '************************************************************************************
        'Date Changed: 4/28/06                          Changed by: Char Chaput
        'Release #: 8.0                               Task: Unknown
        'Description:  Added for RTF
        '====================================================================================
        '************************************************************************************

        Call RTF.UpdateTextInfo((Me.Toolbar1), Me.TxtAlerts(Index), (Me.cmbfont), (Me.cmbsize))
    End Sub
    Private Sub CmbFont_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmbfont.TextChanged
        '************************************************************************************
        'Date Changed: 4/28/06                          Changed by: Char Chaput
        'Release #: 8.0                               Task: Unknown
        'Description:  Added for RTF - font name functionality
        '====================================================================================
        '************************************************************************************

        TxtAlerts(I).SelectionFont = VB6.FontChangeName(TxtAlerts(I).SelectionFont, cmbfont.Text)
    End Sub
    Private Sub CmbFont_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmbfont.SelectedIndexChanged
        '************************************************************************************
        'Date Changed: 4/28/06                          Changed by: Char Chaput
        'Release #: 8.0                               Task: Unknown
        'Description:  Added for RTF - font name functionality
        '====================================================================================
        '************************************************************************************

        TxtAlerts(I).SelectionFont = VB6.FontChangeName(TxtAlerts(I).SelectionFont, cmbfont.Text)
    End Sub
    Private Sub cmbsize_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmbsize.TextChanged
        '************************************************************************************
        'Date Changed: 4/28/06                          Changed by: Char Chaput
        'Release #: 8.0                               Task: Unknown
        'Description:  Added for RTF - font size functionality
        '====================================================================================
        '************************************************************************************

        TxtAlerts(I).SelectionFont = VB6.FontChangeSize(TxtAlerts(I).SelectionFont, CDec(cmbsize.Text))
    End Sub
    Private Sub cmbsize_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmbsize.SelectedIndexChanged
        '************************************************************************************
        'Date Changed: 4/28/06                          Changed by: Char Chaput
        'Release #: 8.0                               Task: Unknown
        'Description:  Added for RTF - font size functionality
        '====================================================================================
        '************************************************************************************

        TxtAlerts(I).SelectionFont = VB6.FontChangeSize(TxtAlerts(I).SelectionFont, CDec(cmbsize.Text))
    End Sub

    Private Sub Toolbar1_ButtonClick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles bold.Click, italic.Click, underline.Click, _Toolbar1_Button4.Click, color.Click, _Toolbar1_Button6.Click, left.Click, center.Click, right.Click, _Toolbar1_Button10.Click, bullet.Click
        Dim Button As System.Windows.Forms.ToolStripItem = CType(eventSender, System.Windows.Forms.ToolStripItem)
        '************************************************************************************
        'Date Changed: 4/28/06                          Changed by: Char Chaput
        'Release #: 8.0                               Task: Unknown
        'Description:  Added for RTF - toolbar functionality
        '====================================================================================
        '************************************************************************************

        Call RTF.ToolbarButtonClick(Button, (Me.Toolbar1), Me.TxtAlerts(I), (Me.cmbfont), (Me.cmbsize), Me.CommonDialog1Color)
    End Sub
End Class