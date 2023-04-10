Option Strict Off
Option Explicit On
Friend Class FrmEventLogDescription
	Inherits System.Windows.Forms.Form
	Public CallId As Integer
	
	
	
	Private Sub CmdClose_Click()
		Me.Close()
	End Sub

    Private Sub chkViewLogEventDeleted_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles chkViewLogEventDeleted.CheckStateChanged
        '************************************************************************************
        'Name: chkViewLogEventDeleted_Click
        'Date Created: 06/11/07                         Created by: Bret Knoll
        'Release: 8.4                                   Task: 8.4.3.9 logevent deleted
        'Description: refereshes logevent with or w/o deleted logevents
        'Returns: na
        'Params: na
        '
        '
        'Stored Procedures: na
        '====================================================================================
        'Clear the grid
        LstViewLogEventdesc.Items.Clear()
        'Fill Grid
        Call modStatQuery.QueryOpenLogEvent(Me)
        'Me.chkViewLogEventDeleted
    End Sub

    Private Sub FrmEventLogDescription_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load
        '************************************************************************************
        'Name: Form_Load
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Loads LogEventDescription
        'Returns: Nothing
        'Params: None
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 6/13/07                       Changed by: Bret Knoll
        'Release #: 8.4                              Task: 8.4.3.9 Deleted logevent, Logevent number
        'Description:
        '   Change size and order of logevent columns
        '   add deleted check box
        '   check for permissions
        '
        '====================================================================================
        '************************************************************************************
        'Log Event Info
        'Initialize the grid

        Call modUtility.CenterForm()

        Call modControl.HighlightListViewRow(LstViewLogEventdesc)

        Call LstViewLogEventdesc.Columns.Insert(0, "", "Date           Time", CInt(VB6.TwipsToPixelsX(1700)))
        Call LstViewLogEventdesc.Columns.Insert(1, "", "Event Type", CInt(VB6.TwipsToPixelsX(1700)))
        Call LstViewLogEventdesc.Columns.Insert(2, "", "From/To", CInt(VB6.TwipsToPixelsX(1600)))
        Call LstViewLogEventdesc.Columns.Insert(3, "", "Organization", CInt(VB6.TwipsToPixelsX(2000)))
        Call LstViewLogEventdesc.Columns.Insert(4, "", "By", CInt(VB6.TwipsToPixelsX(1800)))
        Call LstViewLogEventdesc.Columns.Insert(5, "", "Description", CInt(VB6.TwipsToPixelsX(4500)))
        Call LstViewLogEventdesc.Columns.Insert(6, "", "#", CInt(VB6.TwipsToPixelsX(500)))
        Call LstViewLogEventdesc.Columns.Insert(7, "", "Code", CInt(VB6.TwipsToPixelsX(1000)))

        'bret 6/11/07 8.4.3.9 LogEventDeleted
        If modStatSecurity.GetPermission(AppMain.ParentForm.StatEmployeeID, "AllowViewDeletedLogEvents") Then
            Me.chkViewLogEventDeleted.Visible = True
        Else
            Me.chkViewLogEventDeleted.Visible = False
        End If

        Call modStatQuery.QueryOpenLogEvent(Me)
    End Sub
    Public Function Display(ByRef CallNum As Integer) As Object
        Me.CallId = CallNum
        Me.ShowDialog()

    End Function

    Private Sub FrmEventLogDescription_Resize(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Resize
        If VB6.PixelsToTwipsY(LstViewLogEventdesc.Height) < 200 Then
            Exit Sub
        End If
        If VB6.PixelsToTwipsX(LstViewLogEventdesc.Width) < 50 Then
            Exit Sub
        End If



        LstViewLogEventdesc.Height = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(Me.Height) - 1065)
        LstViewLogEventdesc.Width = VB6.TwipsToPixelsX(VB6.PixelsToTwipsX(Me.Width) - 465)


    End Sub
End Class