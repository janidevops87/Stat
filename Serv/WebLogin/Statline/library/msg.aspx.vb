Public Class msg
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Response.Write(buildMessage)
    End Sub

    Private Function buildMessage()
        Dim vMsg$ = "<center><font face=arial color=red size=5><b>Access Denied!</font></center><br>"
        vMsg = vMsg & "<font face=arial size=2>" & _
        "<br><u>Sorry, there were one or more problems with your request:</u></font></b><br>"

        If Request.QueryString("msg1") = "true" Then
            vMsg = vMsg & "<font face=arial size=2>" & _
                            "<br>1. This page requires Internet Explorer 5.0 or greater.  " & _
                            "Some Internet Service Providers require you to log onto the Internet using a browser other than Internet Explorer.  " & _
                            "In most cases, it's possible to log onto the Internet using your Internet Service Provider's browser, then open Internet Explorer to view Statline's website.  " & _
                            "Internet Explorer may be downloaded for free at <a href=http://www.microsoft.com/windows/ie/default.asp target=_window>www.microsoft.com</a>.  " & _
                            "If have questions, or are unable to view the site using IE, please contact your Client Services representative." & _
                            "</font>"
        End If

        If Request.QueryString("msg2") = "true" Then
            vMsg = vMsg & "<br><font face=arial size=2>" & _
                            "<br>2. This page requires cookies to be turned ON.  Please adjust your browser settings to allow cookies and try again."
        End If

        If Request.QueryString("msg3") = "true" Then
            vMsg = vMsg & "<br><font face=arial size=2>" & _
                            "<br>3. This page requires Javascript to be turned ON.  Please adjust your browser settings to allow Javascript and try again."
        End If

        buildMessage = vMsg
    End Function

End Class
