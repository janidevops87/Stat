Option Strict Off
Option Explicit On
Friend Class FrmEmail
    Inherits System.Windows.Forms.Form
    '************************************************************************************
    'Name: FrmEmail
    'Date Created: 12/04                            Created by: Scott Plummer
    'Release: 7.7.2                                 Task: Form for sending emails
    'Description: Allows StatTrac users to send emails directly from program
    '************************************************************************************

    Public EmailMsg As String
    Public EmailDestAddress As String
    Public EmailAddendum As String
    Public AutoPage As Boolean
    Public LogEventCode As String
    Public CallId As Integer ' For calling SendMail.  4/21/05 - SAP
    Public Recipient As String ' Added to eliminate CISMTP1.  4/21/05 - SAP
    Public Sender As String ' Added to eliminate CISMTP1.  4/21/05 - SAP
    Public MessageSubject As String ' Added to eliminate CISMTP1.  4/21/05 - SAP
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
        'Description: Sends Emails
        'Returns: Nothing
        'Params: None
        'Stored Procedures: None
        '====================================================================================
        'Date Changed: 4/21/05                          Changed by: Scott Plummer
        'Release #: 7.7.33                              Task: 418
        'Description:  Use new method of sending emails through SQL Server using clsAlphaPage.
        '====================================================================================
        '************************************************************************************
        On Error GoTo localError

        Dim sMsg As String = ""
        Dim CR As String = ""

        CR = Environment.NewLine

        If txtAddendum.Text > "" Then
            sMsg = TxtEmail.Text & vbNewLine & "Additional Information:" & vbNewLine & txtAddendum.Text
            EmailAddendum = txtAddendum.Text
        Else
            sMsg = TxtEmail.Text
        End If

        'Add disclaimer
        sMsg = sMsg & CR & CR & "CONFIDENTIAL AND PROPRIETARY, STATLINE, LLC." & CR & CR & LogEventCode

        Call modUtility.Work()

        Dim objAlphaPage As clsAlphaPage
        objAlphaPage = New clsAlphaPage

        objAlphaPage.Recipient = Me.Recipient
        objAlphaPage.Sender = Me.Sender
        objAlphaPage.MessageSubject = Me.MessageSubject
        objAlphaPage.MessageBody = sMsg
        objAlphaPage.SendMail((Me.CallId))

        objAlphaPage = Nothing
        Call modUtility.Done()

        MsgBox("The email was sent.")

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


    Private Sub FrmEmail_Activated(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Activated


        Call modUtility.CenterForm(ParentForm)

        If Me.EmailMsg <> "" Then
            TxtEmail.Text = Me.EmailMsg
        End If


    End Sub

    Private Sub FrmEmail_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing



    End Sub
End Class