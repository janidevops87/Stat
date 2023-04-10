Module AppMain
    Public vDataSource = ""
    Public mainstate As CookieManager

    Public Sub setDataSource(ByVal vDSN$)

        If vDSN <> "" Then
            vDataSource = vDSN
        End If
    End Sub
End Module
