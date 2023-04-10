Option Strict Off
Option Explicit On
Friend Class FrmSecondaryDisposition_Conditionals
    Inherits System.Windows.Forms.Form

    Public DonorCategory As String
    Public SubTypename As String
    Public ProcessorName As String

    Private Const SC_ProcessorCriteria_ConditionalROID As Short = 0
    Private Const SC_FSConditionName As Short = 1
    Private Const SC_FSIndicationName As Short = 2
    Private Const SC_FSAppropriateName As Short = 3
    Private Const SC_FSIndicationID As Short = 4
    Private Const SC_FSConditionID As Short = 5
    Private Const SC_FSAppropriateID As Short = 6
    Private Const SC_SubCriteriaID As Short = 7

    Dim mReportErrors As Boolean
    Dim mReferringForm As System.Windows.Forms.Form
    Dim mSubCriteriaID As Integer

    Private Sub chkCriteriaAll_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles chkCriteriaAll.CheckStateChanged
        Call BuildListview(mSubCriteriaID)
    End Sub

    Private Sub CmdOK_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdOK.Click
        Me.Close()
    End Sub

    Public Property ReferringForm() As FrmReferralView
        Get
            ReferringForm = mReferringForm
        End Get
        Set(ByVal Value As FrmReferralView)
            mReferringForm = Value
        End Set
    End Property

    Public Property ReportErrors() As Boolean
        Get
            ReportErrors = mReportErrors
        End Get
        Set(ByVal Value As Boolean)
            mReportErrors = Value
        End Set
    End Property

    Public Property SubCriteriaID() As Integer
        Get
            SubCriteriaID = mSubCriteriaID
        End Get
        Set(ByVal Value As Integer)
            mSubCriteriaID = Value
            Call BuildListview(mSubCriteriaID)
        End Set
    End Property

    Private Sub frmSecondaryDisposition_Conditionals_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load
        Call lvConditionals.Columns.Insert(0, "", "Condition", CInt(VB6.TwipsToPixelsX(5800)))
        Call lvConditionals.Columns.Insert(1, "", "Indication", CInt(VB6.TwipsToPixelsX(3000)))
        Call lvConditionals.Columns.Insert(2, "", "Appropriate", CInt(VB6.TwipsToPixelsX(1600)))
    End Sub

    Private Function BuildListview(ByRef SubCriteriaID As Integer) As Object
        On Error GoTo err_BuildListview

        Dim sql As String = ""
        Dim I As Integer
        Dim Result As New Object
        Dim ResultsArray As New Object
        Dim vNewItem As System.Windows.Forms.ListViewItem

        Me.lvConditionals.Items.Clear()
        Me.Text = DonorCategory & "  -  " & SubTypename & "  -  " & ProcessorName

        sql = "exec sps_SecondaryDispositionRetrieveConditionals " & SubCriteriaID
        Result = modODBC.Exec(sql, ResultsArray)

        For I = 0 To UBound(ResultsArray, 1)
            If Me.chkCriteriaAll.CheckState Or Me.ReferringForm.Find(modConv.NullToText(ResultsArray(I, SC_FSIndicationName))) Then
                vNewItem = Me.lvConditionals.Items.Add("")
                vNewItem.Tag = "|" & ResultsArray(I, SC_ProcessorCriteria_ConditionalROID)
                vNewItem.Text = ResultsArray(I, SC_FSConditionName)
                If vNewItem.SubItems.Count > 1 Then
                    vNewItem.SubItems(1).Text = ResultsArray(I, SC_FSIndicationName)
                Else
                    vNewItem.SubItems.Insert(1, New System.Windows.Forms.ListViewItem.ListViewSubItem(Nothing, ResultsArray(I, SC_FSIndicationName)))
                End If
                If vNewItem.SubItems.Count > 2 Then
                    vNewItem.SubItems(2).Text = ResultsArray(I, SC_FSAppropriateName)
                Else
                    vNewItem.SubItems.Insert(2, New System.Windows.Forms.ListViewItem.ListViewSubItem(Nothing, ResultsArray(I, SC_FSAppropriateName)))
                End If
            End If
        Next I

exit_BuildListview:
        Exit Function

err_BuildListview:
        Select Case Err.Number
            Case 0
                Resume exit_BuildListview
            Case 13 'Type mismatch - invalid UBound(ResultsArray, 1)
                Resume exit_BuildListview
            Case 400 'Form already displayed; can't show modally
                Resume Next
            Case Else
                If mReportErrors Then MsgBox(Err.Description)
                Resume exit_BuildListview
                Resume
        End Select

    End Function

    Private Sub frmSecondaryDisposition_Conditionals_Resize(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Resize
        If Me.WindowState = 0 Then
            Me.lvConditionals.Height = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(Me.Height) - 1200)
            Me.lvConditionals.Width = VB6.TwipsToPixelsX(VB6.PixelsToTwipsX(Me.Width) - 400)
            Me.chkCriteriaAll.Left = VB6.TwipsToPixelsX(VB6.PixelsToTwipsX(Me.Width) - VB6.PixelsToTwipsX(Me.chkCriteriaAll.Width) - 300)
        End If
    End Sub
End Class