Option Strict Off
Option Explicit On
Friend Class FrmNDRICallSheet
	Inherits System.Windows.Forms.Form
	
	Public PassedForm As System.Windows.Forms.Form
	
	'10/8/01 drh
	Public vParentForm As System.Windows.Forms.Form
	
	Public FormState As Short
	Public CallId As Integer
	Public CallNumber As String
	
	Public Saved As Short
	Public FormLoad As Short
	
	Public OrganizationId As Integer
	Public OrganizationName As String
	Public OrganizationTimeZone As String





    Private Sub CmdCancel_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdCancel.Click

        Me.Close()

    End Sub



    Private Sub CmdOK_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdOK.Click

        Dim vReturn As String = ""

        'Make sure the user wants to save
        vReturn = CStr(modMsgForm.FormSave)

        If vReturn = CStr(MsgBoxResult.Cancel) Then
            Exit Sub
        End If

        'Save the Call Sheet
        Call modStatSave.SaveNDRICallSheet(Me)
        Call ctlNDRIMedications.saveSelected((Me.CallId))

        Me.Saved = True

        Me.Close()

    End Sub
	
	Private Sub FrmNDRICallSheet_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load


		Me.Saved = False
		
		'Populate the combo boxes
		Call PopulateComboBoxes()
		
		'Get the selected event
		Call modStatQuery.QueryNDRICallSheet(Me)
		Call ctlNDRIMedications.getSelected((Me.CallId))
		
		Me.Text = "NDRI Call Sheet - Call # " & Me.CallNumber
		
        Call modUtility.CenterForm(ParentForm)
		
	End Sub
	
	Public Function Display() As Object
		
		Me.ShowDialog()
		
	End Function
	
    Private Sub FrmNDRICallSheet_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing

        Dim vReturn As Short

        If Me.Saved = True Or CmdCancel.Text = "&Close" Then
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

    End Sub
































    Private Sub txtAttendingPhone_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtAttendingPhone.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub txtAttendingPhone_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles txtAttendingPhone.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        KeyAscii = modMask.PhoneMask(KeyAscii, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub txtAttendingPhone_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles txtAttendingPhone.Validating
        Dim Cancel As Boolean = eventArgs.Cancel

        On Error Resume Next

        If Len(TxtAttendingPhone.Text) > 0 And Len(TxtAttendingPhone.Text) < 14 Then
            Call MsgBox("Phone Number is not valid.", MsgBoxStyle.Exclamation, "Validation Error")
            Cancel = True
        End If

        eventArgs.Cancel = Cancel
    End Sub



    Private Sub txtCallTime_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtCallTime.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub

    Private Sub txtCallTime_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles txtCallTime.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        KeyAscii = modMask.TimeMask(KeyAscii, ActiveControl, Me.OrganizationTimeZone)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub txtCallTime_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles txtCallTime.Validating
        Dim Cancel As Boolean = eventArgs.Cancel

        On Error Resume Next

        If Len(txtCallTime.Text) > 0 And Len(txtCallTime.Text) < 8 Then
            Call MsgBox("Time is not valid.", MsgBoxStyle.Exclamation, "Validation Error")
            Cancel = True
        End If

        eventArgs.Cancel = Cancel
    End Sub

    Private Sub txtDOD_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtDOD.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub

    Private Sub TxtCallDate_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtCallDate.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtCallDate_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtCallDate.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        KeyAscii = modMask.DateMask_LY(KeyAscii, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtCallDate_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles TxtCallDate.Validating
        Dim Cancel As Boolean = eventArgs.Cancel

        On Error Resume Next

        If Len(TxtCallDate.Text) > 0 And (Not IsDate(TxtCallDate.Text) Or Len(TxtCallDate.Text) < 8) Then
            Call MsgBox("Date is not valid.", MsgBoxStyle.Exclamation, "Validation Error")
            Cancel = True
        End If

        eventArgs.Cancel = Cancel
    End Sub





















    Private Sub txtDOD_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles txtDOD.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        KeyAscii = modMask.DateMask_LY(KeyAscii, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub txtDOD_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles txtDOD.Validating
        Dim Cancel As Boolean = eventArgs.Cancel

        On Error Resume Next

        If Len(txtDOD.Text) > 0 And (Not IsDate(txtDOD.Text) Or Len(txtDOD.Text) < 8) Then
            Call MsgBox("Date is not valid.", MsgBoxStyle.Exclamation, "Validation Error")
            Cancel = True
        End If

        eventArgs.Cancel = Cancel
    End Sub




    Private Sub TxtSourcePhone_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtSourcePhone.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub


    Private Sub TxtSourcePhone_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtSourcePhone.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        KeyAscii = modMask.PhoneMask(KeyAscii, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub





    Public Sub PopulateComboBoxes()

        'Populate Y/N combo boxes
        Dim YesNoList(2, 1) As Object
        YesNoList(0, 0) = 1
        YesNoList(0, 1) = "Yes"
        YesNoList(1, 0) = 2
        YesNoList(1, 1) = "No"
        YesNoList(2, 0) = 0
        YesNoList(2, 1) = "Unk"
        Call modControl.SetTextID(cboSepsis, YesNoList)
        Call modControl.SetTextID(cboRadiation, YesNoList)
        Call modControl.SetTextID(cboChemotherapy, YesNoList)
        Call modControl.SetTextID(cboSubstanceAbuse, YesNoList)
        Call modControl.SetTextID(cboFamilyAtHospital, YesNoList)
        Call modControl.SetTextID(cboFamilyKnowsStatus, YesNoList)

        'DEFAULT COMBOBOXES TO 'Unknown'
        cboSepsis.SelectedIndex = 2
        cboRadiation.SelectedIndex = 2
        cboChemotherapy.SelectedIndex = 2
        cboSubstanceAbuse.SelectedIndex = 2
        cboFamilyAtHospital.SelectedIndex = 2
        cboFamilyKnowsStatus.SelectedIndex = 2

        'Populate ABO_Rh combo box
        Call modStatRefQuery.ListSecABORef(cboABO_Rh)

        'Populate COD/S combo box
        Dim CauseOfDeathList As New Object
        Call modStatRefQuery.SecQueryCauseOfDeath(CauseOfDeathList)
        Call modControl.SetTextID(cboCOD_S, CauseOfDeathList)

        'Populate Race combo box
        Call modStatRefQuery.ListRefQueryRace(CboRace)

        'Due to a known bug with UserControl property pages, this needs to be set manually
        Me.ctlNDRIMedications.MedicationType = "ndri_medication"
        Me.ctlNDRIMedications.Enabled = True
        Call Me.ctlNDRIMedications.populateAvailable()

    End Sub



    Private Sub TxtSourcePhone_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles TxtSourcePhone.Validating
        Dim Cancel As Boolean = eventArgs.Cancel

        On Error Resume Next

        If Len(TxtSourcePhone.Text) > 0 And Len(TxtSourcePhone.Text) < 14 Then
            Call MsgBox("Phone Number is not valid.", MsgBoxStyle.Exclamation, "Validation Error")
            Cancel = True
        End If

        eventArgs.Cancel = Cancel
    End Sub


    Private Sub txtTOD_Enter(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtTOD.Enter

        Call modControl.HighlightText(ActiveControl)

    End Sub

    Private Sub txtTOD_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles txtTOD.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        KeyAscii = modMask.TimeMask(KeyAscii, ActiveControl, Me.OrganizationTimeZone)

        eventArgs.KeyChar = Chr(KeyAscii)
		If KeyAscii = 0 Then
			eventArgs.Handled = True
		End If
	End Sub
	
	
	Private Sub txtTOD_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles txtTOD.Validating
		Dim Cancel As Boolean = eventArgs.Cancel
		
		On Error Resume Next
		
		If Len(txtTOD.Text) > 0 And Len(txtTOD.Text) < 8 Then
			Call MsgBox("Time is not valid.", MsgBoxStyle.Exclamation, "Validation Error")
			Cancel = True
		End If
		
		eventArgs.Cancel = Cancel
	End Sub
End Class