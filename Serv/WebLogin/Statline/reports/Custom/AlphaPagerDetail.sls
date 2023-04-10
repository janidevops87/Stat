<%
Option Explicit

Response.CacheControl = "no-cache" 
Response.AddHeader "Cache-Control", "private" 
Response.AddHeader "Pragma", "no-cache" 
Response.Expires = -1 
%>
<html>

<head>
<meta http-equiv="Expires" content="now">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="EXPIRES" content="0">
<title>Stat Trac Alpha Pager Monitor</title>
<STYLE>
UL {
   page-break-before: always
   }
a:link {
  color: #000000;
  text-decoration: none;
  }
a:visited { 
  color: #000000;
  text-decoration: none;
  }
a:hover { 
  color: #D13028;
  text-decoration: none;
  }
</STYLE>


</head>

<body bgcolor="#F5EBDD">
<!--#include virtual="/loginstatline/includes/DBConnection.sls"-->
<%'!--#include virtual="/loginstatline/includes/Authorize.sls"--%>

<%
Dim RS
Dim Conn
Dim sMsg
Dim DebugMode
Dim vAlphaPageId
Dim vHoursBack
Dim vQuery
Dim vTimeColor

DebugMode = False

'Open Connection
Set Conn = server.CreateObject("ADODB.Connection")
Conn.Open TRANSACTIONDSN, DBUSER, DBPWD
'Conn.Open "Test", DBUSER, DBPWD

vAlphaPageId = Request.QueryString("AlphaPageId")
vHoursBack = Request.QueryString("HoursBack")
	

If DebugMode = True Then %>
	<table>	
		<tr>
			<td>vCallId: <%=vCallId%></td>
		</tr>
	</table>
<%
End If

' Print table header   
%>
<h1>Alpha Pager Detail</h1>
<table border="1" cellpadding="2" width="800">
	<tr><form action="AlphaPagerMonitor.sls" method="post">
		<td colspan=7 align=center>Search back <input type="text" name="HoursBack" value="<%=Request.QueryString("HoursBack")%>" size=2> hours&nbsp;&nbsp;&nbsp;<input type="submit" value="Submit"></td>
	</tr></form>
	<tr bgcolor="white">
		<td rowspan=2>&nbsp;</td>
		<td align=center rowspan=2><font size=2><b>Send<br>Attempts</b></font></td>
		<td align=center rowspan=2><font size=2><b>Seconds<br>to send</b></font></td>
		<td align=center rowspan=2><font size=2><b>Call Id</b></font></td>
		<td align=center><font size=2><b>Time Created</b></font></td>
		<td align=center><font size=2><b>To</b></font></td>
	</tr>
	<tr bgcolor="white">
		<td align=center><font size=2><b>Time Sent</b></font></td>
		<td align=center><font size=2><b>From</b></font></td>
	</tr>

<%
vQuery = "EXEC sps_AlphaPagerDetail " & vAlphaPageId
Set RS = Conn.Execute(vQuery)


If RS.EOF Then
	sMsg = "There were no alpha pages sent in the last " & vHoursBack & " hours."
Else  %>
	<tr>
		<td rowspan=2>&nbsp;</td>
<%		If RS("AlphaPageComplete") > 1 Then  %>
		<td bgcolor="orange" rowspan=2 align=center><font size=2><%=RS("AlphaPageComplete")%></font></td>
<%		Else  %>
		<td rowspan=2 align=center><font size=2><%=RS("AlphaPageComplete")%></font></td>
<%		End If  
		If RS("AlphaPageDelay") < 60 Then  
			vTimeColor = "BLACK"
		ElseIf RS("AlphaPageDelay") < 600 Then
			vTimeColor = "BLUE"
		Else
			vTimeColor = "RED"			
		End If %>
		<td rowspan=2 align=center><font size=2 color="<%=vTimeColor%>"><%=RS("AlphaPageDelay")%></font></td>
		<td rowspan=2 align=center><font size=2><%=RS("CallId")%></font></td>
		<td><font size=2><%=RS("AlphaPageCreated")%></font></td>
		
		<td><font size=2><%=RS("AlphaPageRecipient")%></font></td>
	
	</tr>
	<tr>
		<td><font size=2><%=RS("AlphaPageSent")%></font></td>
		<td align=right><font size=2><%=RS("AlphaPageSender")%></font></td>
	</tr>
	<tr>
		<td bgcolor="white"><font size=2><b>Subject:</b></font></td>
		<td colspan=5><font size=2><%=RS("AlphaPageSubject")%>&nbsp;</font></td>
	</tr>
	<tr>
		<td bgcolor="white"><font size=2><b>Body Text:</b></font></td>
		<td colspan=5><font size=2><%=RS("AlphaPageBody")%>&nbsp;</font></td>
	</tr>	
	<tr>
		<td colspan=6>
			<table border="1" cellpadding=2 width="100%">
				<tr bgcolor="white">
					<td align=center colspan=5><b>Log Events</b></td>
				</tr>
<% 	Do While Not RS.EOF %>
				<tr>
					<td><font size=2><font size=2><%=RS("LogEventDateTime")%>&nbsp;</font></td>
					<td><font size=2><font size=2><%=RS("LogEventTypeName")%>&nbsp;</font></td>
					<td><font size=2><font size=2><%=RS("LogEventName")%>&nbsp;</font></td>
					<td><font size=2><font size=2><%=RS("LogEventOrg")%>&nbsp;</font></td>
					<td><font size=2><font size=2><%=RS("StatEmployeeName")%>&nbsp;</font></td>
				</tr>
				
<%		RS.MoveNext
	Loop  %>
			</table>
		</td>
	</tr>
<%	
End If



Set Conn = Nothing  %>
	
</table><%'END OVERALL TABLE %>
</body>
</html>