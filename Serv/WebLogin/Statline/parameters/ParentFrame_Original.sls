<%
Option Explicit

Dim UserName
Dim Password
Dim DataSourceName
Dim	TryNumber
Dim Conn
Dim vQuery
Dim RS
Dim UserID
Dim UserOrgID
Dim UserAgent

UserAgent = Request.ServerVariables("HTTP_USER_AGENT")


If LoginUser Then
%>

<html>

<head bgcolor="#F5EBDD" >
<meta name="GENERATOR" content="Microsoft FrontPage 3.0">
<meta http-equiv="EXPIRES" content="0">
<meta http-equiv="Content-type" content="text/html; charset=iso-8859-1">
<title>ParentFrame</title>
</head>
 
<frameset border="0" framespacing="0" frameborder="0" rows="85,*">
  <frame name="banner" scrolling="no" noresize target="contents" src="ParentFrameHeader.shm"
  marginheight="0" marginwidth="0">
  <frameset border="0" framespacing="0" frameborder="0" cols="110,*">
	<frameset border="0" rows="100%,*">
		<frame name="contents" scrolling="no" noresize target="main" src="ContentsFrameDefault.sls?UserID=<%=UserID%>&UserOrgID=<%=UserOrgID%>" scrolling="no" noresize>
	</frameset>
	
     <frame name="main" src="ParametersFrameDefault.sls?UserID=<%=UserID%>&UserOrgID=<%=UserOrgID%>" scrolling="auto" noresize>
  
  </frameset>
  
  <noframes>
  <body topmargin="5" leftmargin="5" bgcolor="#F5EBDD" >
  <p>This page uses frames, but your browser doesn't support them.</p>
  </body>
  </noframes>
</frameset>
</html>

<%
End If

Function LoginUser()

	If Request.Form("UserName") = "" or Request.Form("Password") = "" Then
		
		TryNumber = Request.Form("TryNumber")
		Call LoginError(TryNumber)
		LoginUser = False
		Exit Function
		
	Else


		'Look for a foward slash to see if the user wishes to login to the
		'test database
		UserName = Request.Form("UserName")
		Password = Request.Form("Password")	
	
		If Instr(1, UserName, "/") = 0 Then
			'DataSourceName = "Production"
			DataSourceName = REPORTINGDSN
		Else
			DataSourceName = Mid(UserName, InStr(1, UserName, "/") + 1)
		End If

		'Establish a database connection
		Set Conn = Server.CreateObject("ADODB.Connection")
		Conn.Open DataSourceName, "streportadmin", "report4dmin!"
		'Response.Write DataSourceName
		'Authenticate the user
		vQuery = "sps_AuthenticateUser '" & UserName & "', '" & Password & "' "
		'Response.Write vQuery
		Set RS = Conn.Execute(vQuery)
		
		'There was a db error
		If Conn.Errors.Count > 0 Then
			Call LoginError(0)
			'Discontinue processing of the function
			LoginUser = False
			Exit Function
		End If
		
		'There was no user found
		If RS.EOF Then
			Call LoginError(Request.Form("TryNumber"))
			'Discontinue processing of the function
			LoginUser = False
			Exit Function
		Else
			
			'Update web access fields
			vQuery = "spu_WebAccess " & RS("WebPersonID") & ", '" & UserAgent & "' "
			'Response.Write vQuery
			Call Conn.Execute(vQuery)
			
			'Set the user and org ids
			
			UserID = RS("WebPersonID")
			UserOrgID = RS("OrganizationID")
			
			'The user has been authorized successfully, so continue		
			LoginUser = True
			
		End If
		
	End If
	
End Function


Sub LoginError(TryNumber)

	TryNumber = TryNumber + 1
	
	If TryNumber < 4 Then
		Response.Redirect "http://" & Request.ServerVariables("SERVER_NAME") & "/loginstatline/statline.sls?Error=Failed&T=" & TryNumber
	Else
		Response.Redirect "http://www.fbi.gov/"
	End If
	
End Sub
%>

<!--#include virtual="/loginstatline/includes/DBConnection.sls"-->