Option Strict Off
Option Explicit On
Public Class FrmNoCall
    Inherits System.Windows.Forms.Form

    'Form Variables
    Public FormState As Short
    Public CallType As Short
    Public CallId As Integer
    Public CallNumber As String
    Public fvCallDate As Date
    Public fvCallTotalTime As Date
    Public TimeSnapshot As Date
    Public CallOpenByID As Integer

    Public Description As String
    Public NoCallTypeID As Integer

    Public Saved As Short

    Public SourceCode As New clsSourceCode

    '6/28/07 bjk empirix StatTrac 8.0 6594
    Public RecycledNC As Boolean
    Public Cancel As Boolean
    '3/2010 bret add form references
    Private frmNoCallType As FrmNoCallType


    Public Property CallTotalTime() As Object
        Get

            CallTotalTime = VB6.Format(TimeValue(CStr(fvCallTotalTime)), "hh:mm:ss")

        End Get
        Set(ByVal Value As Object)

            fvCallTotalTime = CDate(VB6.Format(TimeValue(Value), "hh:mm:ss"))

        End Set
    End Property




    Public Property CallDate() As Object
        Get

            CallDate = VB6.Format(fvCallDate, "mm/dd/yy  hh:mm")

        End Get
        Set(ByVal Value As Object)

            fvCallDate = CDate(VB6.Format(Value, "mm/dd/yy  hh:mm"))

        End Set
    End Property





    Public Function Display() As Object

        Me.Show()

    End Function









    Private Sub CboNoCallType_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboNoCallType.SelectedIndexChanged

        Me.NoCallTypeID = modControl.GetID(CboNoCallType)

    End Sub


    Private Sub CboNoCallType_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles CboNoCallType.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        'Allow the delete key to clear the combo box
        Call modControl.AllowDelete(CboNoCallType, KeyAscii)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub CboNoCallType_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CboNoCallType.Leave

        Me.NoCallTypeID = modControl.GetID(CboNoCallType)

    End Sub

    Private Sub CmdCancel_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdCancel.Click

        Me.Close()

    End Sub






    Private Sub CmdOK_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdOK.Click

        Dim vReturn As Short

        'Make sure the user wants to save
        vReturn = modMsgForm.FormSave

        If vReturn = MsgBoxResult.Cancel Then
            Exit Sub
        End If

        'Set the incomplete value
        ChkTemp.CheckState = System.Windows.Forms.CheckState.Unchecked

        'Validate the data
        If Not modStatValidate.NoCallVal(Me) Then
            Exit Sub
        End If

        '06/09/07 bret 8.4.3.8 set CallOpenbyID
        Me.CallOpenByID = -1

        'Save the NoCall
        Call modStatSave.SaveCall(Me, Me.CallId)
        Call modStatSave.SaveNoCall(Me)
        Me.Saved = True

        Me.Close()

    End Sub




    Private Sub CmdNoCallTypeDetail_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdNoCallTypeDetail.Click

        Dim vNoCallTypeID As Integer
        Dim vReturn As New Object

        On Error Resume Next

        If IsNothing(frmNoCallType) Then
            frmNoCallType = New FrmNoCallType()
        End If

        'Determine the form state which to open the
        'NoCallType form.
        If modControl.GetID(CboNoCallType) = -1 Then
            frmNoCallType.FormState = NEW_RECORD
            frmNoCallType.NoCallTypeID = 0
        Else
            frmNoCallType.FormState = EXISTING_RECORD
            frmNoCallType.NoCallTypeID = modControl.GetID(CboNoCallType)
        End If

        'Get the NoCallType id from the NoCallType form
        'after the user is done.
        Me.SendToBack()
        Me.NoCallTypeID = frmNoCallType.Display
        frmNoCallType = Nothing
        If Me.NoCallTypeID = 0 Then
            'The user cancelled adding a new NoCallType
            'so do nothing
        Else
            'Refill the combo boxes with the new (or updated) NoCallTypes
            Call modStatRefQuery.ListRefQueryNoCallType(CboNoCallType)
            Call modControl.SelectID(CboNoCallType, Me.NoCallTypeID)
        End If

    End Sub





    Private Sub FrmNoCall_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load
        '====================================================================================
        'Date Changed: 12/28/05                           Changed by: Char Chaput
        'Release #: 7.7.36                                Task: 484
        'Description:  Stattrac was allowing multiple people into a referral. Added a transaction
        'on the record in modStatSave.SaveCallOpenBy when hit at the same time along with
        'set callopenbyid equal to person in this instance of stattrac when the form is loaded
        '====================================================================================


        Dim vParams() As String

        'bjk 04/16/02 do not need to change time
        'Dim vTimeZoneDif%
        'vTimeZoneDif = modStatQuery.QueryTimeZoneDif(AppMain.ParentForm.TimeZone)

        'Call modUtility.CenterForm()
        Me.Saved = False

        'Set the call type
        Me.CallType = NOCALL
        Me.Saved = False

        '6/28/07 bjk empirix StatTrac 8.0 6594
        Me.RecycledNC = False

        'Fill all reference data
        Call modStatRefQuery.ListRefQueryNoCallType(CboNoCallType)
        Call modStatRefQuery.ListRefQueryStatEmployee(CboCallByEmployee)

        If Me.FormState = NEW_RECORD Then

            'Initialize the call by
            Call modControl.SelectID(CboCallByEmployee, AppMain.ParentForm.StatEmployeeID)
            Call modControl.SelectID(CboNoCallType, Me.NoCallTypeID)
            TxtDescription.Text = Me.Description

            'Initialize the total call time
            Me.CallTotalTime = VB6.Format(0, "hh:mm:ss")
            Me.TimeSnapshot = Now

            'Initialize the call date
            'bjk 04/16/02 do not need to change time
            'Me.CallDate = Format(DateAdd("h", vTimeZoneDif, Now), "mm/dd/yy  hh:mm")
            Me.CallDate = VB6.Format(Now, "mm/dd/yy  hh:mm")
            TxtCallDate.Text = Me.CallDate

            'Save the call record and get the new call id
            Me.CallId = modStatSave.SaveCall(Me)

        ElseIf Me.FormState = EXISTING_RECORD Then

            '11/16/05 C.Chaput set callopenbyid for this for equal to person in this instance of stattrac
            Me.CallOpenByID = AppMain.ParentForm.StatEmployeeID

            'Get the call record
            Call modStatQuery.QueryCall(Me)

            'Set the call date
            TxtCallDate.Text = Me.CallDate

            'Get the NoCall record
            Call modStatQuery.QueryNoCall(Me)

            'And set the lable to the saved total time
            TxtTotalTimeCounter.Text = Me.CallTotalTime

        End If

        Me.Text = "# " & Me.CallNumber & "    " & Me.SourceCode.Name

        '5/17/2004 T.T added disable of save button for Lease Organizations
        If AppMain.ParentForm.LeaseOrganizationType = "FamilyServices" Then
            Me.CmdOK.Enabled = False
        End If
        'If AppMain.ParentForm.LeaseOrganizationType = "TriageFamilyServices" Then
        '    Me.CmdOK.Enabled = False
        'End If

    End Sub

    Private Sub VP_Timer_Tick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles VP_Timer.Tick
        '8/18/03 drh - Timer event for adding CallId to Voiceprint call record

    End Sub

    Private Sub FrmNoCall_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing
        '====================================================================================
        'Date Changed: 12/28/05                           Changed by: Char Chaput
        'Release #: 7.7.36                                Task: 484
        'Description:  Stattrac was allowing multiple people into a referral. Added a transaction
        'on the record in modStatSave.SaveCallOpenBy when hit at the same time and
        'set callopenbyid = -1 when the form is unloaded if the person have save ability only
        '====================================================================================

        Dim vReturn As Short

        'Save culative call time
        If TimerTotalTime.Enabled = True Then
            Call modStatSave.SaveTotalTime(Me)
        End If

        If Me.Saved = True Then
            'The message was saved so just unload
            eventArgs.Cancel = False

        Else
            'The message was cancelled or closed so confirm cancellation
            vReturn = modMsgForm.FormCancel
            If vReturn = MsgBoxResult.Yes Then
                'Char Chaput 12/27/05
                'Update call open by only if have save ability
                If Me.CmdOK.Enabled Then
                    If Me.CallOpenByID = AppMain.ParentForm.StatEmployeeID Then
                        Me.CallOpenByID = -1
                        Call modStatSave.SaveCallCancel(Me)
                    End If
                End If
                If Me.FormState = NEW_RECORD Then
                    'A new call was created but not saved.
                    'Remove the call record and log event items
                    Call modStatSave.DeleteCall(Me.CallId)
                    Call modStatSave.DeleteLogEvent(Me, , 1)
                    'And unload
                    eventArgs.Cancel = False

                ElseIf Me.FormState = EXISTING_RECORD Then
                    'And unload
                    eventArgs.Cancel = False

                End If
            Else
                eventArgs.Cancel = True
                Exit Sub
            End If
        End If

        AppMain.frmNoCall = Nothing
        Me.Dispose()

    End Sub



    Private Sub TimerTotalTime_Tick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TimerTotalTime.Tick

        Dim vTimeDiff As New Object

        vTimeDiff = DateDiff(Microsoft.VisualBasic.DateInterval.Second, Me.TimeSnapshot, Now)

        TxtTotalTimeCounter.Text = VB6.Format(DateAdd(Microsoft.VisualBasic.DateInterval.Second, vTimeDiff, Me.CallTotalTime), "hh:mm:ss")
        Me.CallTotalTime = TxtTotalTimeCounter.Text

        'Take a snap shot of the time
        Me.TimeSnapshot = Now

    End Sub





    Private Sub TxtCallDate_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtCallDate.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        KeyAscii = modMask.DateTimeMask(KeyAscii, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub


    Private Sub TxtCallDate_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtCallDate.Leave

        Me.CallDate = TxtCallDate.Text

    End Sub


    Private Sub TxtDescription_KeyDown(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles TxtDescription.KeyDown
        Dim KeyCode As Short = eventArgs.KeyCode
        Dim Shift As Short = eventArgs.KeyData \ &H10000

        If Shift = 2 Then
            KeyCode = IIf(KeyCode = System.Windows.Forms.Keys.Tab, 0, KeyCode)
        End If

    End Sub

    Private Sub TxtDescription_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtDescription.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        Call modStatQuery.QueryKeyCodePhrase(TxtDescription, KeyAscii)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    Private Sub TxtDescription_Leave(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles TxtDescription.Leave

        Call modStatValidate.ValidateSpelling(TxtDescription)

    End Sub


    Private Sub TxtTotalTimeCounter_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles TxtTotalTimeCounter.KeyPress
        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)

        KeyAscii = 0
        'KeyAscii = modMask.TimerMask(KeyAscii, ActiveControl)

        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub
End Class