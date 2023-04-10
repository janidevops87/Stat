Option Strict Off
Option Explicit On
Imports Statline.Stattrac.Windows.CSharpUIMap
Imports Statline.Stattrac.Common
Imports Statline.Stattrac.Constant

Public Class FrmOpenOrganization
    Inherits System.Windows.Forms.Form

    Public GridList As Object
    Public SortOrder As Short
    Public Loaded As Short
    Public OrganizationId As Integer
    Public OrganizationName As String
    'bret 02/01/11 
    Private uIMap As UIMap

    Private Sub CmdClose_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdClose.Click

        Me.Close()

    End Sub


    Private Sub CmdDelete_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdDelete.Click

        Dim vReturn As Object
        Dim vResultArray As New Object
        Dim vQuery As Object


        vReturn = MsgBox("You are about to delete an organization. This action cannot be undone!!! Are you sure you want to continue?", MsgBoxStyle.YesNo, "Delete Organization")

        Select Case vReturn
            Case MsgBoxResult.Yes

                vReturn = MsgBox("You are *really* sure you want to delete this organization. Once it's gone, you must re-enter it and recreate all of it's group associations. This is your last chance. With this in mind, are you *positive* you want to continue?", MsgBoxStyle.YesNo, "Delete Organization")

                If vReturn = MsgBoxResult.Yes Then

                    'Get the call id
                    Me.OrganizationId = modConv.TextToLng(LstViewOrganization.FocusedItem.Tag)
                    'Get the Organization Name to display the name in the name change message box
                    Call modStatRefQuery.RefQueryOrganization(vResultArray, Me.OrganizationId)
                    Me.OrganizationName = vResultArray(0, 1)
                    'Check for any referrals associated with the organization about to be deleted
                    vReturn = modStatQuery.QueryOrganizationReferrals(Me)

                    If vReturn = NO_DATA Then

                        'Char Chaput 12/21/05
                        'Check if there are any associations to archive database
                        vQuery = "SELECT isnull(OrganizationArchive,0) FROM Organization " & "WHERE OrganizationID = " & Me.OrganizationId
                        vReturn = modODBC.Exec(vQuery, vResultArray)
                        If vReturn <> NO_DATA Then
                            If vResultArray(0, 0) = 1 Then
                                Call MsgBox("There are referrals associated with this organization in the Archive Database. The organization cannot be deleted until associated referrals have been reassigned to another organization.", MsgBoxStyle.OkOnly, "Delete Organization")
                                Exit Sub
                            Else
                                'Delete the organization
                                Call modStatSave.DeleteOrganization(Me.OrganizationId)
                                'Fill Grid
                                Call CmdFind_Click(CmdFind, New System.EventArgs())
                            End If
                        End If
                    Else
                        Call MsgBox("There are referrals associated with this organization. The organization cannot be deleted until associated referrals have been reassigned to another organization.", MsgBoxStyle.OkOnly, "Delete Organization")
                        Exit Sub
                    End If
                Else
                    Exit Sub
                End If

            Case MsgBoxResult.No
                Exit Sub
        End Select


    End Sub

    Private Sub CmdFind_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdFind.Click

        Call modUtility.Work()

        'Clear the grid
        LstViewOrganization.Items.Clear()
        LstViewOrganization.View = View.Details

        'Fill Grid
        Call modStatQuery.QueryOpenOrganization(Me)

        Call modUtility.Done()

    End Sub

    Private Sub CmdNew_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdNew.Click

        Dim vReturn() As String
        Dim vOrganizationId As Integer

        On Error Resume Next
        'Set the state of the form
        vOrganizationId = 0

        'Show the organization form
        vOrganizationId = uIMap.Open(AppScreenType.OrganizationsOrganizationEditPopup, vOrganizationId)

        If vOrganizationId <> 0 Then
            If modControl.GetID((Me.CboState)) <> ALL_STATES Or modControl.GetID((Me.CboOrganizationType)) <> ALL_ORG_TYPES Then
                'Refresh the list
                CmdFind_Click(CmdFind, New System.EventArgs())
            End If
        End If

    End Sub

    Private Sub CmdOpen_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdOpen.Click

        On Error Resume Next

        'Get the call ID
        'frmOrganization.OrganizationId = modConv.TextToLng(LstViewOrganization.FocusedItem.Tag)
        'frmOrganization.FormState = EXISTING_RECORD

        'Call frmOrganization.Display()

        'frmOrganization = Nothing

        Me.Activate()

    End Sub





    Private Sub CmdPrintList_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdPrintList.Click

        Dim vReportParameters As String
        Dim vReportName As String

        On Error GoTo handleError

        Call modUtility.Work()


        'Set the report name
        Select Case modControl.GetID(CboPrint)
            Case 1
                vReportName = "OrganizationList.rpt"
            Case 2
                vReportName = "Assignments1.rpt"
            Case 3
                vReportName = "Assignments1SC.rpt"
            Case 4
                vReportName = "Assignments2.rpt"
            Case 5
                vReportName = "Assignments2SC.rpt"
        End Select

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

        'Set the parameters
        If Me.ReportParams = False Then
            Call modUtility.Done()
            Exit Sub
        End If



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

    Private Sub FrmOpenOrganization_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load

        'Me.Loaded = False

        Call modControl.HighlightListViewRow(LstViewOrganization)
        Call LstViewOrganization.Columns.Insert(0, "", "Organization", CInt(VB6.TwipsToPixelsX(3600)))
        Call LstViewOrganization.Columns.Insert(1, "", "City", CInt(VB6.TwipsToPixelsX(1500)))
        Call LstViewOrganization.Columns.Insert(2, "", "State", CInt(VB6.TwipsToPixelsX(550)))
        Call LstViewOrganization.Columns.Insert(3, "", "Organization Type", CInt(VB6.TwipsToPixelsX(2000)))

        'Fill all reference data
        Call modStatRefQuery.RefQueryState(CboState, , , , , True)
        Call modStatRefQuery.RefQueryOrganizationType(CboOrganizationType, , , , , True)

        'Set the default types
        Call modControl.SelectID(CboState, ALL_STATES)
        Call modControl.SelectID(CboOrganizationType, ALL_ORG_TYPES)

        Me.SortOrder = System.Windows.Forms.SortOrder.Ascending

        'Set security options
        If modStatSecurity.GetPermission(AppMain.ParentForm.StatEmployeeID, "AllowCallDelete") Then
            Me.CmdDelete.Visible = True
            Me.CmdNew.Enabled = True
        Else
            Me.CmdDelete.Visible = False
            Me.CmdNew.Enabled = False
        End If

        'remove print options - delete it eventually.
        CboPrint.Visible = False
        CmdPrintList.Visible = False

        'Call modUtility.CenterForm()

    End Sub











    Private Sub FrmOpenOrganization_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing

        'Dispose()

        AppMain.frmOpenOrganization = Nothing

    End Sub












    Public Function Display() As Object


        Dim dialogResult As DialogResult = Me.ShowDialog()

    End Function














    Private Sub LstViewOrganization_ColumnClick(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.ColumnClickEventArgs) Handles LstViewOrganization.ColumnClick
        Dim ColumnHeader As System.Windows.Forms.ColumnHeader = LstViewOrganization.Columns(eventArgs.Column)

        Static vSortOrder As Short

        ' When a ColumnHeader object is clicked, the ListView control is
        ' sorted by the subitems of that column.
        ' Set the SortKey to the Index of the ColumnHeader - 1
        LstViewOrganization.Sorting = vSortOrder
        LstViewOrganization.ListViewItemSorter = New ListViewItemComparer(eventArgs.Column, vSortOrder)

        If vSortOrder = System.Windows.Forms.SortOrder.Ascending Then
            vSortOrder = System.Windows.Forms.SortOrder.Descending
        Else
            vSortOrder = System.Windows.Forms.SortOrder.Ascending
        End If

    End Sub


    Private Sub LstViewOrganization_DoubleClick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles LstViewOrganization.DoubleClick

        Call CmdOpen_Click(CmdOpen, New System.EventArgs())

    End Sub



    Public Function ReportParams() As Boolean

        Dim vPrintType As Short
        Dim SourceCode As New clsSourceCode
        Dim vReturn As String

        ReportParams = True

        vPrintType = modControl.GetID(CboPrint)


        If vPrintType = 3 Or vPrintType = 5 Then
            vReturn = InputBox("Please enter a source code.", "Source Code", SourceCode.Name)

            If vReturn <> "" Then
                SourceCode = Nothing
                Call SourceCode.GetItem(, vReturn, REFERRAL)
            Else
                MsgBox("You must enter a source code to create this report.")
                ReportParams = False
                Exit Function
            End If
        End If

        'Set the selection parameters
        If modControl.GetID((Me.CboState)) <> ALL_STATES And modControl.GetID((Me.CboOrganizationType)) = ALL_ORG_TYPES Then

            Select Case vPrintType
                Case 1
                                        ' bret 01/13/2010 remove reference ParentForm.CrystalReport1.SelectionFormula = "{sps_OrganizationList.StateID} = " & modControl.GetID((Me.CboState))
                                        ' bret 01/13/2010 remove reference ParentForm.CrystalReport1.StoredProcParam(0) = ""
                                        ' bret 01/13/2010 remove reference ParentForm.CrystalReport1.StoredProcParam(1) = ""
                Case 2, 4
                                        ' bret 01/13/2010 remove reference ParentForm.CrystalReport1.SelectionFormula = ""
                                        ' bret 01/13/2010 remove reference ParentForm.CrystalReport1.StoredProcParam(0) = modControl.GetID((Me.CboState))
                                        ' bret 01/13/2010 remove reference ParentForm.CrystalReport1.StoredProcParam(1) = ""
                Case 3, 5
                    ' bret 01/13/2010 remove reference ParentForm.CrystalReport1.SelectionFormula = ""
                    ' bret 01/13/2010 remove reference ParentForm.CrystalReport1.StoredProcParam(0) = modControl.GetID((Me.CboState))
                    ' bret 01/13/2010 remove reference ParentForm.CrystalReport1.StoredProcParam(1) = SourceCode.ID
            End Select

        ElseIf modControl.GetID((Me.CboState)) = ALL_STATES And modControl.GetID((Me.CboOrganizationType)) <> ALL_ORG_TYPES Then

            Select Case vPrintType
                Case 1
                                        ' bret 01/13/2010 remove reference ParentForm.CrystalReport1.SelectionFormula = "{sps_OrganizationList.OrganizationTypeID} = " & modControl.GetID((Me.CboOrganizationType))
                                        ' bret 01/13/2010 remove reference ParentForm.CrystalReport1.StoredProcParam(0) = ""
                                        ' bret 01/13/2010 remove reference ParentForm.CrystalReport1.StoredProcParam(1) = ""
                Case 2, 3, 4, 5
                    MsgBox("A State must be selected to create this report.")
                    ReportParams = False
                    Exit Function
            End Select

        ElseIf modControl.GetID((Me.CboState)) <> ALL_STATES And modControl.GetID((Me.CboOrganizationType)) <> ALL_ORG_TYPES Then

            Select Case vPrintType
                Case 1
                                        ' bret 01/13/2010 remove reference ParentForm.CrystalReport1.SelectionFormula = "{sps_OrganizationList.StateID} = " & modControl.GetID((Me.CboState)) & " AND " & "{sps_OrganizationList.OrganizationTypeID} = " & modControl.GetID((Me.CboOrganizationType))
                                        ' bret 01/13/2010 remove reference ParentForm.CrystalReport1.StoredProcParam(0) = ""
                                        ' bret 01/13/2010 remove reference ParentForm.CrystalReport1.StoredProcParam(1) = ""
                Case 2, 4
                                        ' bret 01/13/2010 remove reference ParentForm.CrystalReport1.SelectionFormula = ""
                                        ' bret 01/13/2010 remove reference ParentForm.CrystalReport1.StoredProcParam(0) = modControl.GetID((Me.CboState))
                                        ' bret 01/13/2010 remove reference ParentForm.CrystalReport1.StoredProcParam(1) = ""
                Case 3, 5
                    ' bret 01/13/2010 remove reference ParentForm.CrystalReport1.SelectionFormula = ""
                    ' bret 01/13/2010 remove reference ParentForm.CrystalReport1.StoredProcParam(0) = modControl.GetID((Me.CboState))
                    ' bret 01/13/2010 remove reference ParentForm.CrystalReport1.StoredProcParam(1) = SourceCode.ID
            End Select

        Else
            Select Case vPrintType
                Case 1
                    'Do nothing
                Case 2, 3, 4, 5
                    MsgBox("A State must be selected to create this report.")
                    ReportParams = False
                    Exit Function
            End Select
        End If

    End Function
End Class