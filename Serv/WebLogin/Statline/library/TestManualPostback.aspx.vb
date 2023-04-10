Public Class TestManualPostback
    Inherits System.Web.UI.Page
    Protected WithEvents RegularExpressionValidator1 As System.Web.UI.WebControls.RegularExpressionValidator
    Protected WithEvents txtRegExValidate As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtTestManualPostback As System.Web.UI.WebControls.TextBox

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
        Dim strTreeName As String = "txtTestManualPostback"
        Dim strRef As String = Page.GetPostBackEventReference(txtTestManualPostback)
        Dim strScript As String = "<script language=""JavaScript""> " & vbCrLf & _
            "<!-- " & vbCrLf & _
            "	function initTextbox() { " & vbCrLf & _
            "		" & strTreeName & ".onfocus = function() { " & vbCrLf & _
            "			//this.queueEvent('onfocus', event.value); " & vbCrLf & _
            "			window.setTimeout('" & strRef.Replace("'", "\'") & "', 0, 'JavaScript'); " & vbCrLf & _
            "		} " & vbCrLf & _
            "	} " & vbCrLf & _
            "// --> " & vbCrLf & _
            "</script>"

        Page.RegisterClientScriptBlock("InitTextbox", strScript)
    End Sub

End Class
