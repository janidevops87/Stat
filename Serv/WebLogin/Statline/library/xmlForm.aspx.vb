Public Class xmlForm
    Inherits System.Web.UI.Page
    Protected WithEvents Xml1 As System.Web.UI.WebControls.Xml

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
        Dim XMLDOC As System.Xml.XmlDocument = New System.Xml.XmlDocument()
        XMLDOC.Load(Server.MapPath("PUBTITLESDATA.XML"))
        Dim XSLTRAN As System.Xml.Xsl.XslTransform = New System.Xml.Xsl.XslTransform()
        XSLTRAN.Load(Server.MapPath("PUBTITLES.XSL"))
        Me.Xml1.Document = XMLDOC
        Me.Xml1.Transform = XSLTRAN
    End Sub

End Class
