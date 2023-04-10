Imports System
Imports System.Web.UI
Imports System.Web
Imports System.Text
Imports System.Collections


Public Class MessageBox
    Private Shared m_executingPages As Hashtable = New Hashtable

    Private Sub New()
    End Sub

    Public Shared Sub Show(ByVal sMessage As String)
        If Not m_executingPages.Contains(HttpContext.Current.Handler) Then
            Dim executingPage As Page '= CType(ConversionHelpers.AsWorkaround(HttpContext.Current.Handler, GetType(Page)), Page)
            If Not (executingPage Is Nothing) Then
                Dim messageQueue As Queue = New Queue
                messageQueue.Enqueue(sMessage)
                m_executingPages.Add(HttpContext.Current.Handler, messageQueue)
                AddHandler executingPage.Unload, AddressOf ExecutingPage_Unload
            End If
        Else
            Dim queue As Queue = CType(m_executingPages(HttpContext.Current.Handler), Queue)
            queue.Enqueue(sMessage)
        End If
    End Sub

    Private Shared Sub ExecutingPage_Unload(ByVal sender As Object, ByVal e As EventArgs)
        Dim queue As Queue = CType(m_executingPages(HttpContext.Current.Handler), Queue)
        If Not (queue Is Nothing) Then
            Dim sb As StringBuilder = New StringBuilder
            Dim iMsgCount As Integer = queue.Count
            sb.Append("<script language='javascript'>")
            Dim sMsg As String
            While System.Math.Max(System.Threading.Interlocked.Decrement(iMsgCount), iMsgCount + 1) > 0
                sMsg = CType(queue.Dequeue, String)
                sMsg = sMsg.Replace("" & Microsoft.VisualBasic.Chr(10) & "", "\n")
                sMsg = sMsg.Replace("""", "'")
                sb.Append("alert( """ + sMsg + """ );")
            End While
            sb.Append("</script>")
            m_executingPages.Remove(HttpContext.Current.Handler)
            HttpContext.Current.Response.Write(sb.ToString)
        End If
    End Sub
End Class

