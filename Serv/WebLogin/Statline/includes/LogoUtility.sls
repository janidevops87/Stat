<%
' This utility is used to populate header files with client logos
' Most reports will use ReportGroupID to obtain the logo
' Schedule reports will use ScheduleGroupID to obtain the logo

' This function expects a UserOrgID to obtain the image tag for logos
' NOTE: this function is a pass through. It was implemented only to check for what 
' 	org is running report



'Response.Write( "<BR><B>DataSourceName</B><BR>" & DataSourceName & "<BR>" )	
Function GetLogoUserOrg(pvUserOrgID)
	If pvUserOrgID <> 194 then
		 GetLogoUserOrg = GetLogoUserOrgID(pvUserOrgID)
	End If	
End Function
' This Function expects ScheuleGroupID to obtain the image logo tag
' 
Function GetLogoScheduleGroup(pvScheduleGroupID)
	If pvUserOrgID <> 194 then
		GetLogoScheduleGroup = GetLogo(GetSourceCodeNameScheduleGroupID(pvScheduleGroupID))
	End If	
End Function
' This Function expects ReportGroupID to obtain the image logo tag
' 
Function GetLogoReportGroup(pvReportGroupID)	
	If pvUserOrgID <> 194 then	
		GetLogoReportGroup = GetLogo(GetSourceCodeNameReportGroupID(pvReportGroupID))
	End If	
End Function
' This Function expects SourceCodeName
' 
Function GetLogoSourceCode(pvSourceCodeName)
	If pvUserOrgID <> 194 then
		GetLogoSourceCode = GetLogo(pvSourceCodeName)
	End If	

End Function

' This function expects ScheduleGroupID to obtain SourceCodeName
'
Function GetSourceCodeNameScheduleGroupID(pvScheduleGroupID)
	On Error Resume Next
	Dim LogoConn, LogoRS
	'Establish a database connection
	Set LogoConn = server.CreateObject("ADODB.Connection")
	LogoConn.Open DataSourceName, DBUSER, DBPWD

	'get the logo information 
	vQuery = "EXEC sps_GetSourceCodeName_ScheduleGroupID " & pvScheduleGroupID
	
	'Response.Write vQuery
	Set LogoRS = LogoConn.Execute(vQuery)
	
	'There was a db error
	If LogoConn.Errors.Count > 0 Then
			Set Security = Nothing
			Set LogoConn = Nothing
			Set LogoRS = Nothing
			Exit Function
	End If
	
	'There was record
	If LogoRS.EOF Then
		GetSourceCodeNameScheduleGroupID = " "
		Set Security = Nothing
		Set LogoConn = Nothing
		Set LogoRS = Nothing
		Exit Function
	ELSE
		GetSourceCodeNameScheduleGroupID = LogoRS("SourceCodeName")
		Set Security = Nothing
		Set LogoConn = Nothing
		Set LogoRS = Nothing
	End If

End Function
' This function expects ReportGroupID to obtain SourceCodeName
'
Function GetSourceCodeNameReportGroupID(pvReportGroupID)
	Dim LogoConn, LogoRS
	
	'Establish a database connection
	Set Conn = server.CreateObject("ADODB.Connection")
	Conn.CommandTimeout = 2000
	Conn.Open PRODUCTIONDSN, DBUSER, DBPWD
	'Conn.Open DataSourceName, DBUSER, DBPWD
	'Set LogoConn = server.CreateObject("ADODB.Connection")
	'LogoConn.Open DataSourceName, DBUSER, DBPWD
	'Response.Write( "<BR><B>DataSourceName: </B><BR>" & DataSourceName & "<BR>" )
	'response.write "in here char"
	'get the logo information 
	vQuery = "EXEC sps_GetSourceCodeName_ReportGroupID " & pvReportGroupID
	
	'Response.Write DataSourceName
	'Response.Write LogoConn
	'Set LogoRS = LogoConn.Execute(vQuery)
	Set LogoRS = Conn.Execute(vQuery)
	'There was a db error
	If Conn.Errors.Count > 0 Then
	'If LogoConn.Errors.Count > 0 Then
			Set Security = Nothing
			Set LogoConn = Nothing
			Set LogoRS = Nothing
			Exit Function
	End If
	
	'There was record
	If LogoRS.EOF Then
		GetSourceCodeNameReportGroupID = " "
		Set Security = Nothing
		Set LogoConn = Nothing
		Set LogoRS = Nothing
		Exit Function
	ELSE
		GetSourceCodeNameReportGroupID = LogoRS("SourceCodeName")
		Set Security = Nothing
		Set LogoConn = Nothing
		Set LogoRS = Nothing
	End If

End Function
' This function expects a SourceCodeName to obtain the image tag for logos
'
Function GetLogo(pvSourceCodeName)
	Dim LogoURL, LogoWidth, LogoHeight, ReturnString, LogoConn, LogoRS

	'Establish a database connection
	Set LogoConn = server.CreateObject("ADODB.Connection")
	LogoConn.Open WEBPROD, DBUSER, DBPWD

	'get the logo information 	
	vQuery = "EXEC sps_GetLogo " & pvSourceCodeName
		
	'Response.Write vQuery
	Set LogoRS = LogoConn.Execute(vQuery)
	
	'There was a db error
	If LogoConn.Errors.Count > 0 Then
			Set Security = Nothing
			Set LogoConn = Nothing
			Set LogoRS = Nothing
			Exit Function
	End If
	
	'There was record
	If LogoRS.EOF Then
		GetLogo = " "
		Set Security = Nothing
		Set LogoConn = Nothing
		Set LogoRS = Nothing
		Exit Function
	ELSE	
	  ReturnString = "<table CELLPADDING=0 CELLSPACING=0>"
	  LogoRS.MoveFirst
	  ReturnString = ReturnString + "<tr>"
	  Do While not LogoRS.EOF
	  ReturnString = ReturnString + "<td>"
	  ReturnString = ReturnString + "<img src="
	 
	  ReturnString = ReturnString + "/loginstatline/" +LogoRS("SourceCodeLogoURL") 
	  ReturnString = ReturnString + " width="
	 
	  ReturnString = ReturnString + cstr(LogoRS("SourceCodeLogoWidth")) 
	  ReturnString = ReturnString + " height="
	 
	  ReturnString = ReturnString + cstr(LogoRS("SourceCodeLogoHeight"))
	  ReturnString = ReturnString + " >"
	  ReturnString = ReturnString + "</td>"
	  LogoRS.Movenext
	  Loop
	  ReturnString = ReturnString + "</td></tr>"
	  ReturnString = ReturnString + "</table>"
	  GetLogo = ReturnString
    	  Set Security = Nothing
 	  Set LogoConn = Nothing
	  Set LogoRS = Nothing  
	  
	End If
	
End Function

' This function expects a UserOrgID to obtain the image tag for logos
'
Function GetLogoUserOrgID(pvUserOrgID)
	Dim LogoURL, LogoWidth, LogoHeight, ReturnString, LogoConn, LogoRS

	'Establish a database connection
	Set LogoConn = server.CreateObject("ADODB.Connection")
	LogoConn.Open WEBPROD, DBUSER, DBPWD

	'get the logo information 	
	vQuery = "EXEC sps_GetLogoUserOrgID " & pvUserOrgID
		
	'Response.Write vQuery
	Set LogoRS = LogoConn.Execute(vQuery)
	
	'There was a db error
	If LogoConn.Errors.Count > 0 Then
			Set Security = Nothing
			Set LogoConn = Nothing
			Set LogoRS = Nothing
			Exit Function
	End If
	
	'There was record
	If LogoRS.EOF Then
		GetLogoUserOrgID = " "
		Set Security = Nothing
		Set LogoConn = Nothing
		Set LogoRS = Nothing
		Exit Function
	ELSE	
	 
	  ReturnString = "<img src="
	 
	  ReturnString = ReturnString + LogoRS("SourceCodeLogoURL") 
	  ReturnString = ReturnString + " width="
	 
	  ReturnString = ReturnString + cstr(LogoRS("SourceCodeLogoWidth")) 
	  ReturnString = ReturnString + " height="
	 
	  ReturnString = ReturnString + cstr(LogoRS("SourceCodeLogoHeight"))
	  ReturnString = ReturnString + " >"
	  
	  GetLogoUserOrgID = ReturnString
    	  Set Security = Nothing
 	  Set LogoConn = Nothing
	  Set LogoRS = Nothing  
	  
	End If
	
End Function






%>
