Public Class wfMsg
    Inherits System.Web.UI.Page
    Protected WithEvents Button1 As System.Web.UI.WebControls.Button

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

        If Not Page.IsPostBack Then
            Dim wfLogEvent2 As wfLogEvent
            wfLogEvent2 = CType(Context.Handler, wfLogEvent)
            Me.Button1.Text = wfLogEvent2.OldCalloutDate
            Button1.Attributes.Add("onmouseover", "clientfunction();")
        End If
    End Sub

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        Server.Transfer("wfLogEvent.aspx")
    End Sub
End Class
