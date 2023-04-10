<%
Option Explicit

Dim UserName
Dim Password
'Dim DataSourceName
Dim	TryNumber
'Dim Conn
'Dim vQuery
'Dim RS
'Dim UserID
'Dim UserOrgID
Dim UserAgent

UserAgent = Request.ServerVariables("HTTP_USER_AGENT")
%>
<!--#include virtual="/loginstatline/includes/Authorize.sls"--> 
<%
If LoginUser Then

%>

<html>
	test
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
		'Set Conn = server.CreateObject("ADODB.Connection")
		'Conn.CommandTimeout = 2000
		
		Conn.Open DataSourceName, DBUSER, DBPWD
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
			Response.Write vQuery
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
		Response.Redirect "http://" & Request.ServerVariables("SERVER_NAME") & "/statline.sls?Error=Failed&T=" & TryNumber
	Else
		Response.Redirect "http://www.fbi.gov/"
	End If
	
End Sub
%>