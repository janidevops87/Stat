<%
'Option Explicit

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

<body bgcolor="#DDDDDD">
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

DebugMode = True

'Open Connection
Set Conn = server.CreateObject("ADODB.Connection")
'Conn.Open TRANSACTIONDSN, DBUSER, DBPWD
Conn.Open "Test", DBUSER, DBPWD

' Default to 3 hours back
vHoursBack = 88
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
<table border="1" cellpadding="2">
	<tr><form action="AlphaPagerMonitor.sls" method="post">
		<td colspan=5 align=center>Search back <input type="text" name="HoursBack" value="<%=vHoursBack%>" size=2> hours</td>
		<td colspan=2><input type="submit" value="Submit"></td>
	</tr></form>
	<tr bgcolor="white">
		<td><font size=2><b>Sent?</b></font></td>
		<td><font size=2><b>Seconds to send</b></font></td>
		<td><font size=2><b>Call Id</b></font></td>
		<td><font size=2><b>Time Created</b></font></td>
		<td><font size=2><b>Time Sent</b></font></td>
		<td><font size=2><b>To</b></font></td>
		<td><font size=2><b>From</b></font></td>
	</tr>

<%
vQuery = "EXEC sps_AlphaPagerMonitor " & vHoursBack
Set RS = Conn.Execute(vQuery)

If RS.EOF Then
	sMsg = "There were no alpha pages sent between " & vStartDate & " and " & vEndDate
Else
	Do While Not RS.EOF %>
	<tr>
<%		If RS("AlphaPageComplete") Then  %>
		<td>SENT</td>
<%		Else  %>
		<td bgcolor="orange">UNSENT</td>
<%		End If  
		If RS("AlphaPageDelay") > 20 Then  %>
		<td><font size=2><%=RS("AlphaPageDelay")%></font></td>
		<td><font size=2><%=RS("CallId")%></font></td>
		<td><font size=2><%=RS("AlphaPageCreated")%></font></td>
		<td><font size=2><%=RS("AlphaPageSent")%></font></td>
		<td><font size=2><%=RS("AlphaPageRecipient")%></font></td>
		<td><font size=2><%=RS("AlphaPageSubject")%>&nbsp;</font></td>
	
	</tr>
<% 		End If	

'	AlphaPageId, CallId, AlphaPageRecipient, AlphaPageSender, AlphaPageBC, 
'	AlphaPageCC, AlphaPageSubject, /*AlphaPageBody,*/ AlphaPageCreated, 
'	AlphaPageSent, AlphaPageComplete,
'	DateDiff(ss, AlphaPageCreated, AlphaPageSent) AS AlphaPageDelay


		RS.MoveNext
	Loop
End If


Set Conn = Nothing  %>
	
</table><%'END OVERALL TABLE %>
</body>
</html>