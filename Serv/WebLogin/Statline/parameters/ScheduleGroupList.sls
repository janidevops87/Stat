<%
Option Explicit

Dim pvStartDate
Dim PvEndDate
Dim vErrorMsg
Dim pvCallId
Dim vUserOrgID

pvCallId = 0

%>
<!--#include virtual="/loginstatline/includes/Authorize.sls"-->
<html>

<head>
<meta NAME="GENERATOR" Content="Microsoft FrontPage 3.0">
<meta http-equiv="EXPIRES" content="0">
<meta http-equiv="Content-type" content="text/html; charset=iso-8859-1">
<title>ScheduleGroup List</title>
</head>

<body bgcolor="#F5EBDD">

<%
Call AuthorizeMain
ReportGroupID = Request.QueryString("ReportGroupID")

'And (Request.QueryString("userOrgID") <> 194 Or Request.QueryString("StatOrgID") = 194) 
If ReportGroupID = 0 And Request.QueryString("userOrgID") <> 194 Then %>
	<select name="organization">
	    <option value="0" selected></option>
	</select>
<%
Else
	vUserOrgID = Request.QueryString("userOrgID")
	' If a StatOrgId was provided, this supersedes userOrgID, because a Statline user is editing schedules.  4/29/05 - SAP
	If Len(Request.QueryString("StatOrgID")) Then
		vUserOrgID = Request.QueryString("StatOrgID")
	End If

	'Open Connection
	Set Conn = server.CreateObject("ADODB.Connection")
	Conn.Open DataSourceName, DBUSER, DBPWD
	DebugPrint(DataSourceName)	
	'Get the report groups list 
	Set RS = Conn.Execute("sps_ScheduleGroups " & vUserOrgID)
	'Response.Write("sps_ScheduleGroups " & Request.QueryString("userOrgID"))
	%>
		
	<select name="organization">
	  
	    <!--<option value="0" selected></option>-->
		<%Do While Not RS.EOF
			If RS.CursorLocation = 1 Then
		%>
				<option selected value="<%=RS("ScheduleGroupID")%>"><%=RS("ScheduleGroupName")%></option>
		<%
			ELSE
		%>		
				<option value="<%=RS("ScheduleGroupID")%>"><%=RS("ScheduleGroupName")%></option>
		<%
			End IF
		%>		
			<%RS.MoveNext%>
		<%Loop
		Set RS = Nothing
		Set Conn = Nothing
		%>      
	</select>

<%
'''Response.Write "xxxxxx vUserOrgID  " & vUserOrgID
End If
Function DebugPrint(printString)
	'Response.Write("<!-- DEBUG-> <br>" & printString) & " -->"
End Function

%>

</body>
</html>