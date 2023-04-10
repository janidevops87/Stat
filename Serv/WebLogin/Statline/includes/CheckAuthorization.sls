<%

Function CheckAuthorization()
	
	
	Dim statlineUserID
	Dim checkUrl 
	checkUrl = GetURL
	
	statlineUserID = FormatNumber(Request("UserID"),0,,0,0)
	If CInt(statlineUserID) <> CInt(Session("StatlineUserID")) Then
		Session("StatlineUserID") = Empty 						
	End If
	
	statlineUserID=Session("StatlineUserID") 
	
	If IsEmpty(statlineUserID) Then
		Response.Status = "301 Moved Permanently"
		Response.AddHeader "Location", checkUrl
		Response.End()
	End If
End Function
Function GetURL()

	Dim serverName 
	serverName = Request.ServerVariables("SERVER_NAME") 
	'return URL by setting function equal to return value
	GetURL = "http://" & serverName

End Function


%>