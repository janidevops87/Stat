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
  text-decoration: underline;
  }
a:visited { 
  color: #888888;
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
Dim vStartDate
Dim vEndDate
Dim RS
Dim Conn
Dim sMsg
Dim DebugMode
Dim vHoursBack
Dim ctr
Dim vQuery
Dim vTimeColor

DebugMode = False

'Open Connection
Set Conn = server.CreateObject("ADODB.Connection")
Conn.Open TRANSACTIONDSN, DBUSER, DBPWD
'Conn.Open "Test", DBUSER, DBPWD

' Default to 3 hours back
If Len(Request.Form("HoursBack")) > 0 And IsNumeric(Request.Form("HoursBack")) Then
	vHoursBack = Request.Form("HoursBack")
Else  ' Default to 3 hours back
	vHoursBack = 3
End If
	

If DebugMode = True Then %>
	<table>	
		<tr>
			<td>vHoursBack: <%=vHoursBack%></td>
		</tr>
	</table>
<%
End If

' Print table header   
%>
<h1>Alpha Pager Monitor</h1>
<table border="1" cellpadding="2">
	<tr><form action="AlphaPagerMonitor.sls" method="post">
		<td colspan=7 align=center>Search back <input type="text" name="HoursBack" value="<%=vHoursBack%>" size=2> hours&nbsp;&nbsp;&nbsp;<input type="submit" value="Submit"></td>
	</tr></form>
	<tr bgcolor="white">
		<td rowspan=2>&nbsp;&nbsp;&nbsp;</td>
		<td align=center rowspan=2><font size=2><b>Send<br>Attempts</b></font></td>
		<td align=center rowspan=2><font size=2><b>Seconds<br>to send</b></font></td>
		<td align=center rowspan=2><font size=2><b>Call Id</b></font></td>
		<td align=center><font size=2><b>Time Created</b></font></td>
		<td align=center><font size=2><b>To</b></font></td>
		<td align=center rowspan=2><font size=2><b>Subject</b></font></td>
	</tr>
	<tr bgcolor="white">
		<td align=center><font size=2><b>Time Sent</b></font></td>
		<td align=center><font size=2><b>From</b></font></td>
	</tr>

<%
vQuery = "EXEC sps_AlphaPagerMonitor " & vHoursBack
Set RS = Conn.Execute(vQuery)

ctr = 0

If RS.EOF Then
	sMsg = "There were no alpha pages sent in the last " & vHoursBack & " hours."
Else
	Do While Not RS.EOF 
		ctr = ctr + 1		%>
	<tr>
		<td rowspan=2 align=right bgcolor="white"><font size=2><%=ctr%></font></td>
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
		<td rowspan=2><font size=2><a href="AlphaPagerDetail.sls?AlphaPageId=<%=RS("AlphaPageId")%>&HoursBack=<%=vHoursBack%>"><%=RS("CallId")%></a></font></td>
		<td><font size=2><%=RS("AlphaPageCreated")%></font></td>
		
		<td><font size=2><%=RS("AlphaPageRecipient")%></font></td>
		
		<td rowspan=2><font size=2><%=RS("AlphaPageSubject")%>&nbsp;</font></td>
	
	</tr>
	<tr>
		<td><font size=2><%=RS("AlphaPageSent")%></font></td>
		<td align=right><font size=2><%=RS("AlphaPageSender")%></font></td>
	</tr>
<% 		
		RS.MoveNext
	Loop
End If


Set Conn = Nothing  %>
	
</table><%'END OVERALL TABLE %>
</body>
</html>