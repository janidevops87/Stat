Option Strict Off
Option Explicit On
Public Class ctlItemList
    Inherits System.Windows.Forms.UserControl
    'Bret 1/06/10 add Option explicit for upgrade

    Public ControlEnabled As Boolean
    Public MedicationType As String
    Dim DeletedSecondaryMedicationOtherList() As Integer

    Private Sub CmdAdd_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdAdd.Click

        Dim vItem As System.Windows.Forms.ListViewItem

        If Trim(cboAvailable.Text) <> "" Then
            If Trim(cmdAdd.Text) = "Add" Then
                vItem = lvwSelected.Items.Add("")
            ElseIf Trim(cmdAdd.Text) = "Modify" Then
                vItem = lvwSelected.FocusedItem
            End If

            If cboAvailable.SelectedIndex = -1 Then
                vItem.Tag = CStr(-1)
            Else
                vItem.Tag = modControl.GetID(cboAvailable) ' CStr(VB6.GetItemData(cboAvailable, cboAvailable.SelectedIndex))
            End If

            vItem.Text = cboAvailable.Text
            If vItem.SubItems.Count > 1 Then
                vItem.SubItems(1).Text = txtDose.Text
            Else
                vItem.SubItems.Insert(1, New System.Windows.Forms.ListViewItem.ListViewSubItem(Nothing, txtDose.Text))
            End If
            If vItem.SubItems.Count > 2 Then
                vItem.SubItems(2).Text = txtStartDate.Text
            Else
                vItem.SubItems.Insert(2, New System.Windows.Forms.ListViewItem.ListViewSubItem(Nothing, txtStartDate.Text))
            End If
            If vItem.SubItems.Count > 3 Then
                vItem.SubItems(3).Text = txtEndDate.Text
            Else
                vItem.SubItems.Insert(3, New System.Windows.Forms.ListViewItem.ListViewSubItem(Nothing, txtEndDate.Text))
            End If
            'Add placeholder for the SecondaryMedicationOtherID
            If vItem.SubItems.Count > 4 Then
                vItem.SubItems(4).Text = ""
            Else
                vItem.SubItems.Insert(4, New System.Windows.Forms.ListViewItem.ListViewSubItem(Nothing, ""))
            End If

            cboAvailable.SelectedIndex = -1
            cboAvailable.Text = ""
            txtDose.Text = ""
            txtStartDate.Text = ""
            txtEndDate.Text = ""

            cmdAdd.Text = "     Add     "
            'cmdAdd.ForeColor = System.Drawing.ColorTranslator.ToOle(System.Drawing.SystemColors.WindowText)
            cmdAdd.ForeColor = System.Drawing.SystemColors.WindowText

        End If

        cboAvailable.Focus()
    End Sub

    Private Sub cmdClear_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdClear.Click
        cboAvailable.SelectedIndex = -1
        cboAvailable.Text = ""
        txtDose.Text = ""
        txtStartDate.Text = ""
        txtEndDate.Text = ""

        cmdAdd.Text = "     Add     "
        'CmdAdd.ForeColor = System.Drawing.ColorTranslator.ToOle(System.Drawing.SystemColors.WindowText)
        cmdAdd.ForeColor = System.Drawing.SystemColors.WindowText
    End Sub

    Private Sub CmdRemove_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdRemove.Click

        Dim I As Integer
        For I = lvwSelected.Items.Count - 1 To 0 Step -1
            If lvwSelected.Items.Item(I).Selected Then
                If lvwSelected.Items.Item(I).SubItems.Count > 4 Then
                    DeletedSecondaryMedicationOtherList(UBound(DeletedSecondaryMedicationOtherList)) = IIf(lvwSelected.Items.Item(I).SubItems(4).Text = "", 0, lvwSelected.Items.Item(I).SubItems(4).Text)
                Else
                    DeletedSecondaryMedicationOtherList(UBound(DeletedSecondaryMedicationOtherList)) = 0
                End If

                ReDim Preserve DeletedSecondaryMedicationOtherList(UBound(DeletedSecondaryMedicationOtherList) + 1)
                Call lvwSelected.Items.RemoveAt(I)
            End If
        Next I

        cboAvailable.SelectedIndex = -1
        cboAvailable.Text = ""
        txtDose.Text = ""
        txtStartDate.Text = ""
        txtEndDate.Text = ""

        cmdAdd.Text = "     Add     "
        'CmdAdd.ForeColor = System.Drawing.ColorTranslator.ToOle(System.Drawing.SystemColors.WindowText)
        cmdAdd.ForeColor = System.Drawing.SystemColors.WindowText

    End Sub



    Private Sub txtEndDate_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles txtEndDate.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)
        If txtEndDate.SelectedText <> "" Then
            txtEndDate.Text = ""
        End If
        KeyAscii = modMask.DateMask_LY(KeyAscii, txtEndDate)
        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub txtEndDate_KeyUp(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles txtEndDate.KeyUp
        Dim KeyCode As Short = eventArgs.KeyCode
        Dim Shift As Short = eventArgs.KeyData \ &H10000
        If Len(txtEndDate.Text) = 8 Then
            Call cmdAdd.Focus()
        End If
    End Sub

    Private Sub txtEndDate_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles txtEndDate.Validating
        Dim Cancel As Boolean = eventArgs.Cancel
        If txtEndDate.Text <> "" And (Len(txtEndDate.Text) < 8 Or Not IsDate(txtEndDate.Text)) Then
            Call MsgBox("Date is not valid.", MsgBoxStyle.Exclamation, "Validation Error")
            Cancel = True
            GoTo EventExitSub
        End If
EventExitSub:
        eventArgs.Cancel = Cancel
    End Sub

    Private Sub txtStartDate_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles txtStartDate.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)
        If txtStartDate.SelectedText <> "" Then
            txtStartDate.Text = ""
        End If
        KeyAscii = modMask.DateMask_LY(KeyAscii, txtStartDate)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub txtStartDate_KeyUp(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles txtStartDate.KeyUp
        Dim KeyCode As Short = eventArgs.KeyCode
        Dim Shift As Short = eventArgs.KeyData \ &H10000
        If Len(txtStartDate.Text) = 8 Then
            Call txtEndDate.Focus()
        End If
    End Sub

    Private Sub txtStartDate_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles txtStartDate.Validating
        Dim Cancel As Boolean = eventArgs.Cancel
        If txtStartDate.Text <> "" And (Len(txtStartDate.Text) < 8 Or Not IsDate(txtStartDate.Text)) Then
            Call MsgBox("Date is not valid.", MsgBoxStyle.Exclamation, "Validation Error")
            Cancel = True
            GoTo EventExitSub
        End If
EventExitSub:
        eventArgs.Cancel = Cancel
    End Sub

    Private Sub UserControl_Initialize()

        'Initialize the Selected Items grid
        Call modControl.HighlightListViewRow(lvwSelected)
        Call lvwSelected.Columns.Insert(0, "", "Name", CInt(VB6.TwipsToPixelsX(2000)))
        Call lvwSelected.Columns.Insert(1, "", "Dose", CInt(VB6.TwipsToPixelsX(1000)))
        Call lvwSelected.Columns.Insert(2, "", "Start Date", CInt(VB6.TwipsToPixelsX(1000)))
        Call lvwSelected.Columns.Insert(3, "", "End Date", CInt(VB6.TwipsToPixelsX(1000)))
        Call lvwSelected.Columns.Insert(4, "", "", CInt(VB6.TwipsToPixelsX(0)))
        cmdAdd.Text = "     Add     "

    End Sub


    Public Shadows Property Enabled() As Boolean
        Get

            Enabled = ControlEnabled

        End Get
        Set(ByVal Value As Boolean)

            fmBorder.Enabled = Value
            cmdAdd.Enabled = Value
            cmdRemove.Enabled = Value
            cmdCreate.Enabled = Value
            cmdClear.Enabled = Value
            lvwSelected.Enabled = Value
            txtDose.Enabled = Value
            txtStartDate.Enabled = Value
            txtEndDate.Enabled = Value

            ControlEnabled = Value
        End Set
    End Property


    Public Function getItemArray() As Object
        Dim vItemArray(5, 0) As Object
        Dim vReturnArray As Boolean
        Dim vItem As System.Windows.Forms.ListViewItem
        Dim I As Short

        For I = 0 To lvwSelected.Items.Count - 1
            ReDim Preserve vItemArray(5, I)
            vItem = New ListViewItem
            vItem = lvwSelected.Items.Item(I)
            vItemArray(0, I) = vItem.Tag
            vItemArray(1, I) = vItem.Text
            vItemArray(2, I) = vItem.SubItems(1).Text
            vItemArray(3, I) = vItem.SubItems(2).Text
            vItemArray(4, I) = vItem.SubItems(3).Text
            vItemArray(5, I) = vItem.SubItems(4).Text
            vReturnArray = True
        Next I

        getItemArray = IIf(vReturnArray, vItemArray, "")
    End Function

    Public Sub getSelected(ByRef pvCallId As Integer)
        On Error GoTo localError

        Dim vQuery As String = ""
        Dim vParams As New Object
        Dim I As Integer

        '7/4/07 bret 8.4.3.8 AuditTrail
        ReDim Preserve DeletedSecondaryMedicationOtherList(0)

        'Get the items
        vQuery = "exec sps_SecondaryMedicationOther " & pvCallId & ", '" & Me.MedicationType & "'"

        'Fill the return parameter array
        Call modODBC.Exec(vQuery, vParams)

        Dim vItem As System.Windows.Forms.ListViewItem
        If IsArray(vParams) Then
            For I = 0 To UBound(vParams, 1)
                vItem = New ListViewItem
                vItem = lvwSelected.Items.Insert(I, "")
                vItem.Tag = vParams(I, 0)
                vItem.Text = vParams(I, 1)
                If vItem.SubItems.Count > 1 Then
                    vItem.SubItems(1).Text = vParams(I, 2)
                Else
                    vItem.SubItems.Insert(1, New System.Windows.Forms.ListViewItem.ListViewSubItem(Nothing, vParams(I, 2)))
                End If

                Dim startDate As Date
                vParams(I, 3) = IIf(DateTime.TryParse(vParams(I, 3), startDate), startDate.ToString("MM/dd/yy"), vParams(I, 3))
                If vItem.SubItems.Count > 2 Then
                    vItem.SubItems(2).Text = vParams(I, 3)
                Else
                    vItem.SubItems.Insert(2, New System.Windows.Forms.ListViewItem.ListViewSubItem(Nothing, vParams(I, 3)))
                End If

                Dim endDate As Date
                vParams(I, 4) = IIf(DateTime.TryParse(vParams(I, 4), endDate), endDate.ToString("MM/dd/yy"), vParams(I, 4))
                If vItem.SubItems.Count > 3 Then
                    vItem.SubItems(3).Text = vParams(I, 4)
                Else
                    vItem.SubItems.Insert(3, New System.Windows.Forms.ListViewItem.ListViewSubItem(Nothing, vParams(I, 4)))
                End If

                '07/05/07 bret 8.4.3.8 AuditTrail
                If vItem.SubItems.Count > 4 Then
                    vItem.SubItems(4).Text = vParams(I, 5)
                Else
                    vItem.SubItems.Insert(4, New System.Windows.Forms.ListViewItem.ListViewSubItem(Nothing, vParams(I, 5)))
                End If 'SecondaryMedicationOtherID
            Next I
        End If
        Exit Sub
localError:
        Resume Next
        Resume
    End Sub

    Public Sub saveSelected(ByRef pvCallId As Integer)
        '************************************************************************************
        'Name: saveSelected
        'Date Created: Unknown                          Created by: Dave Hoffmann
        'Release: Unknown                               Task: Unknown
        'Description: saves SecondaryMedicationOther
        'Params: pvCallid
        '
        'Stored Procedures: InsertSecondaryMedicationOther
        '====================================================================================
        '====================================================================================
        'Date Changed: 06/7/07                       Changed by: Bret Knoll
        'Release #: 8.4                              Task: AuditTrail
        'Description:   Changed code to use InsertCall and UpdateCall
        '               Add LastStatEmployeeID
        '====================================================================================

        'SMO refers to a record from the SecondaryMedicationOther table
        Dim vSmosFromForm As New Object
        Dim vSmosFromDb As New Object
        Dim vQuery As String = ""
        Dim I, J, vResult As Short
        Dim vSmoFound As Boolean = False

        vSmosFromForm = Me.getItemArray

        'Look up SMO records for this call from the db
        vQuery = "EXEC sps_SecondaryMedicationOther @CallId = " & pvCallId & ", @MedicationType = '" & Me.MedicationType & "';"
        Call modODBC.Exec(vQuery, vSmosFromDb)

        'If we have saved records, loop through them to find ones that need to be updated or deleted
        If IsArray(vSmosFromDb) Then
            vQuery = ""
            For I = 0 To UBound(vSmosFromDb, 1)

                'Loop through selected records to find a match
                vSmoFound = False
                If IsArray(vSmosFromForm) Then
                    For J = 0 To UBound(vSmosFromForm, 2)

                        'If we found a match (on the SecondaryMedicationOtherID), update the db record with form data
                        If vSmosFromDb(I, 5) = vSmosFromForm(5, J) Then
                            vSmoFound = True
                            vQuery = vQuery & "EXEC UpdateSecondaryMedicationOther @SecondaryMedicationOtherId = " & vSmosFromDb(I, 5) & ", @CallId = " & pvCallId & ", @MedicationId = " & vSmosFromForm(0, J) & ", @SecondaryMedicationOtherTypeUse = '" & Me.MedicationType & "', @SecondaryMedicationOtherName = '" & vSmosFromForm(1, J) & "', @SecondaryMedicationOtherDose = " & modODBC.BuildField(vSmosFromForm(2, J)) & ", @SecondaryMedicationOtherStartDate = " & modODBC.BuildField(vSmosFromForm(3, J)) & ", @SecondaryMedicationOtherEndDate = " & modODBC.BuildField(vSmosFromForm(4, J)) & ", @LastStatEmployeeID = " & modConv.TextToLng(AppMain.ParentForm.StatEmployeeID) & ", @AuditLogTypeID = 3; "
                            Exit For
                        End If

                    Next J
                End If

                'If we didn't find a match, delete it
                If vSmoFound = False Then
                    vQuery = vQuery & "EXEC DeleteSecondaryMedicationOther @SecondaryMedicationOtherId = " & vSmosFromDb(I, 5) & ", @LastStatEmployeeID = " & modConv.TextToLng(AppMain.ParentForm.StatEmployeeID) & "; "
                End If

            Next I
        End If

        'If we have SMO records in our form, loop through them to find ones that need to be inserted
        If IsArray(vSmosFromForm) Then
            For J = 0 To UBound(vSmosFromForm, 2)

                'Find records without a SecondaryMedicationOtherID
                If vSmosFromForm(5, J).Equals("") Then
                    vQuery = vQuery & "EXEC InsertSecondaryMedicationOther " & "@CallId = " & pvCallId & ", @MedicationId = " & vSmosFromForm(0, J) & ", @SecondaryMedicationOtherTypeUse = '" & Me.MedicationType & "', @SecondaryMedicationOtherName = '" & vSmosFromForm(1, J) & "', @SecondaryMedicationOtherDose = " & modODBC.BuildField(vSmosFromForm(2, J)) & ", @SecondaryMedicationOtherStartDate = " & modODBC.BuildField(vSmosFromForm(3, J)) & ", @SecondaryMedicationOtherEndDate = " & modODBC.BuildField(vSmosFromForm(4, J)) & ", @LastStatEmployeeID = " & modConv.TextToLng(AppMain.ParentForm.StatEmployeeID) & ", @AuditLogTypeID = 1; "
                End If

            Next J
        End If

        vResult = modODBC.Exec(vQuery)

    End Sub

    Public Sub populateAvailable()

        On Error Resume Next

        Dim vQuery As String = ""
        Dim vParams As New Object
        Dim I As Integer

        'Get the items
        vQuery = "sps_MedicationOther '" & Me.MedicationType & "'"

        'Fill the return parameter array
        Call modODBC.Exec(vQuery, vParams)

        If Not IsNothing(vParams) Then
            Call modControl.SetTextID(cboAvailable, vParams)
        End If

    End Sub

    Private Sub lvwSelected_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles lvwSelected.SelectedIndexChanged
        Dim j As Short
        If sender.selectedItems.Count <> 1 Then
            Exit Sub
        End If

        cboAvailable.SelectedIndex = cboAvailable.FindString(sender.selectedItems(0).Text)

        cboAvailable.Text = sender.selectedItems(0).Text
        txtDose.Text = sender.selectedItems(0).SubItems(1).Text
        txtStartDate.Text = sender.selectedItems(0).SubItems(2).Text
        txtEndDate.Text = sender.selectedItems(0).SubItems(3).Text


        cmdAdd.Text = "  Modify   "
        'CmdAdd.ForeColor = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.Blue)
        cmdAdd.ForeColor = System.Drawing.Color.Blue
    End Sub
End Class