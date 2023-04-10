<%
Option Explicit

'Dim RS
'Dim Conn
'Dim ReportGroupID
%>
<!--#include virtual="/loginstatline/includes/Authorize.sls"-->
<html>

<head>
<meta NAME="GENERATOR" Content="Microsoft FrontPage 3.0">
<meta http-equiv="EXPIRES" content="0">
<meta http-equiv="Content-type" content="text/html; charset=iso-8859-1">
<title>Organization List</title>
</head>

<body bgcolor="#F5EBDD">

<%
ReportGroupID = Request.QueryString("ReportGroupID")

If ReportGroupID = 0 Then
%>
	<select name="organization">
	    <option value="0" selected></option>
	</select>
<%
Else

	'Open Connection
	Set Conn = server.CreateObject("ADODB.Connection")
	Conn.Open REPORTINGDSN, DBUSER, DBPWD
		
	'Get the report groups list 
	Set RS = Conn.Execute("sps_ReportGroupOrgs " & Request.QueryString("ReportGroupID"))	
	%>
		
	<select name="organization">
	  
	    <option value="0" selected></option>
		<%Do While Not RS.EOF%>        
			<option value="<%=RS("OrganizationID")%>"><%=RS("OrganizationName")%></option>
			<%RS.MoveNext%>
		<%Loop
		Set RS = Nothing
		Set Conn = Nothing
		%>      
	</select>

<%
End If
%>

</body>
</html>