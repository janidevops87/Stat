Option Strict Off
Option Explicit On
Friend Class clsAlphaPage
    'Bret 1/06/10 add Option explicit for upgrade

    Private msSender As String
    Private msCC As String
    Private msBC As String
    Private msMessageBody As String
    Private msRecipient As String
    Private msMessageSubject As String


    Public Sub SendMail(ByRef iCallId As Integer)
        '************************************************************************************
        'Name: SendMail
        'Date Created: 4/21/05                          Created by: Scott Plummer
        'Release: 7.7.33                                Task: 418
        'Description: Sends alpha message pages or emails.
        'Returns: Nothing
        'Params: iCallId,
        'Stored Procedures: spi_SendAlphaPage
        '************************************************************************************


        On Error GoTo ERR_HANDLER

        Dim vQuery As String = ""
        Dim vResult As Short

        ' Creates a record in the AlphaPage table
        vQuery = "EXEC spi_SendAlphaPage " & iCallId & ",'" & msRecipient & "','" & msSender & "','" & msCC & "','" & msBC & "','" & msMessageSubject & "','" & msMessageBody & "' "
        vResult = modODBC.Exec(vQuery)

        Exit Sub

ERR_HANDLER:

        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())
        Resume Next

    End Sub

    Public WriteOnly Property Recipient() As String
        Set(ByVal Value As String)
            msRecipient = Left(Replace(Trim(Value), "'", ""), 100) ' Eliminate apostrophes
        End Set
    End Property

    Public WriteOnly Property Sender() As String
        Set(ByVal Value As String)
            msSender = Left(Replace(Trim(Value), "'", ""), 100) ' Eliminate apostrophes
        End Set
    End Property

    Public WriteOnly Property MessageSubject() As String
        Set(ByVal Value As String)
            msMessageSubject = Left(Replace(Trim(Value), "'", ""), 150) ' Eliminate apostrophes
        End Set
    End Property

    Public WriteOnly Property MessageBody() As String
        Set(ByVal Value As String)
            msMessageBody = Left(Replace(Value, "'", "''"), 7500) ' double apostrophes for SQL
        End Set
    End Property
End Class