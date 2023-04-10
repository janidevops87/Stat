Option Strict Off
Option Explicit On
Friend Class FrmAlphaMsg
    Inherits System.Windows.Forms.Form

    Public AlphaMsg As String
    Public AutoPage As Boolean
    Public LogEventCode As String
    Public CallId As Integer ' For calling SendMail.  4/21/05 - SAP
    Public Recipient As String ' Added to eliminate CISMTP1.  4/21/05 - SAP
    Public Sender As String ' Added to eliminate CISMTP1.  4/21/05 - SAP
    Public MessageSubject As String ' Added to eliminate CISMTP1.  4/21/05 - SAP
    Public MessageBody As String ' Added to eliminate CISMTP1.  4/21/05 - SAP
    Public FormParent As Form
    Public MessageSentCancelled As Boolean = False

    Private Sub cmdCancel_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdCancel.Click

        MessageSentCancelled = True
        Me.Close()

    End Sub


    Private Sub CmdSend_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdSend.Click
        '************************************************************************************
        'Name: CmdSend_Click
        'Date Created: Unknown                          Created by: Unknown
        'Release: Unknown                               Task: Unknown
        'Description: Sends alpha message pages.
        'Returns: Nothing
        'Params: None
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 12/20/04                         Changed by: Scott Plummer
        'Release #: 7.7.2                               Task: 340
        'Description:  Added new subject line for AutoResponse pages.
        '====================================================================================
        'Date Changed: 4/21/05                          Changed by: Scott Plummer
        'Release #: 7.7.33                              Task: 418
        'Description:  Added new SQL Server method of sending email using clsAlphaPage
        '====================================================================================
        '************************************************************************************

        On Error GoTo localError

        If Not AutoPage Then Me.Sender = AppMain.ParentForm.StatEmployeeEmail 'mjd 05/28/2002 Page-AutoResponse

        'If autopage, use the LogEventCode as the subject line
        If AutoPage Then
            Me.MessageSubject = LogEventCode
        End If

        Me.MessageBody = TxtAlpha.Text & Environment.NewLine & LogEventCode

        Call modUtility.Work()

        ' Changed to use clsAlphaPage for sending SQL Server email,
        ' eliminating use of CISMTP1.  4/21/05 - SAP
        Dim objAlphaPage As New clsAlphaPage

        objAlphaPage.Recipient = Me.Recipient
        objAlphaPage.Sender = Me.Sender
        objAlphaPage.MessageSubject = Me.MessageSubject
        objAlphaPage.MessageBody = Me.MessageBody
        objAlphaPage.SendMail((Me.CallId))

        objAlphaPage = Nothing

        Call modUtility.Done()

        MsgBox("The alpha page was sent.")

        If Me.FormParent IsNot Nothing AndAlso Me.FormParent.Name = "FrmOnCallEvent" Then
            Me.FormParent.Close()
        End If

        Me.Close()

        Exit Sub

localError:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        Call MsgBox(Err.Number & " " & Err.Description)
        Resume Next

    End Sub


    Private Sub FrmAlphaMsg_Activated(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Activated


        Call modUtility.CenterForm()

        If Me.AlphaMsg <> "" Then
            TxtAlpha.Text = Me.AlphaMsg
        End If


    End Sub

    Private Sub FrmAlphaMsg_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing



    End Sub
End Class