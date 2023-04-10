Option Strict Off
Option Explicit On

Friend Class FrmColorKey
    Inherits System.Windows.Forms.Form
    'Bret 1/06/10 add Option explicit for upgrade

    Private Sub FrmColorKey_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load
        '************************************************************************************
        'Name:Form_Load
        'Date Created: Thien                         Created by: Thien
        'Release: Unknown                               Task: 8.0
        'Description: Gets colors for events from database
        'Returns:  result of vQuery
        'Params: pvForm = calling form,
        'Stored Procedures:
        '====================================================================================
        Dim vQuery As String = ""
        Dim SetCallColor As New Object
        Dim vRS As New Recordset
        Dim vResult As New Object

        'Page Pending
        vQuery = "select EventColor from logeventtype where LogEventTypeName = 'Page Pending'"
        Call modODBC.Exec(vQuery, vResult, , True, vRS)
        SetCallColor = vRS("EventColor").Value



        Me.txtPE.BackColor = System.Drawing.ColorTranslator.FromOle(vRS("EventColor").Value)

        'Recovery Outcome'
        vQuery = "select EventColor from logeventtype where LogEventTypeName = 'Recovery Outcome'"
        Call modODBC.Exec(vQuery, vResult, , True, vRS)
        SetCallColor = vRS("EventColor").Value
        Me.txtOE.BackColor = System.Drawing.ColorTranslator.FromOle(vRS("EventColor").Value)

        'Case Update'
        vQuery = "select EventColor from logeventtype where LogEventTypeName = 'Case Update'"
        Call modODBC.Exec(vQuery, vResult, , True, vRS)
        SetCallColor = vRS("EventColor").Value
        Me.txtUE.BackColor = System.Drawing.ColorTranslator.FromOle(vRS("EventColor").Value)


    End Sub
End Class