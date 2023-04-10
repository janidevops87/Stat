<% Option Explicit %>
<!--#include virtual="/loginstatline/includes/Authorize.sls"-->

<%
' 4.1.4.2.3 - ccarroll - 04/18/2006 Per StatTrac 8.0 Design Document
' Added function to convert RTF to HTML
' Requires EasyByte_RTF2HTML_DLL.dll to be registered on server
' Changes include addition of stattrac.css to control rich text
' div boxes.

Dim AlertID
Dim Test



Function RTF2HTML(strRTF)
' Function to convert RTF to HTML - StatTrac 8.0 Design Document (4.1.4.2.3)
' 04/18/2006, ccarroll 
  
  Dim objConverter
  On Error Resume Next

    Set objConverter = server.CreateObject("EasyByte_RTF2HTML_Dll.Convert")

      RTF2HTML = objConverter.ConvertNoBody((strRTF),"","","EasyByteRTF2HTML","NO","NO","NO","","","NO","image")

    Set objConverter = Nothing
End Function



AlertID = Request.QueryString("AlertID")
Set Conn = server.CreateObject("ADODB.Connection")
	Conn.CommandTimeout = 2000
	'Conn.Open DataSourceName, DBUSER, DBPWD
'Set Conn = server.CreateObject("ADODB.Connection")
Conn.Open PRODUCTIONDSN, DBUSER, DBPWD

vQuery = "SELECT * FROM Alert WHERE AlertID = " & AlertID

Set RS = Conn.Execute(vQuery)

%>

<html>

<head>
<title>Report Description</title>
<meta name="GENERATOR" content="Microsoft FrontPage 3.0">
<meta http-equiv="EXPIRES" content="0">
<LINK href="stattrac.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="#F5EBDD">

<%If RS.EOF = True Then%>

<table align="left" border="0" cellpadding="0" cellspacing="0" width="575">
	<TR>
		<TD ALIGN=LEFT WIDTH="50%"><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>"> There is no data available for the chosen date range. </TD>
	</TR>
	
</TABLE>	

<%Else
'Response.write(VarType(RS("AlertQAMessage1")))
'Response.write(VarType(RS("AlertQAMessage2")))

%>

<table align="left" border="0" cellpadding="0" cellspacing="0" width="575">
  <tr>
    <td width="17%"><font size="2" face="arial"><strong>Alert Group:</strong></font></td>
    <td><font size="2" face="times new roman"><%=RS("AlertGroupName")%></font></td>
  </tr>
</table>

<p><br>
</p>

<hr align="left" color="#000000" noshade size="1" width="100%">

<table align="left" border="0" cellpadding="0" cellspacing="0" width="100%">

  <tr>
    <td align="left"><font size="2" face="arial"><strong>Alert #1</strong></font></td>
    <td align="left"><font size="2" face="arial"><strong>Alert #2</strong></font></td>
  </tr>
  <tr>
	
    <td align="left"><div class="alert1"><%=RTF2HTML(RS("AlertMessage1"))%></div></td>
    <td align="left"><div class="alert2"><%=RTF2HTML(RS("AlertMessage2"))%></div></td>
  </tr>

  <tr>
    <td align="left"><font size="2" face="arial"><strong>QA Alert Message #1</strong></font></td>
    <td align="left"><font size="2" face="arial"><strong>QA Alert Message #2</strong></font></td>
  </tr>
  <tr>
    <td align="left"><div class="alert3"><%=RTF2HTML(RS("AlertQAMessage1"))%></div></td>
    <td align="left"><div class="alert4"><%=RTF2HTML(RS("AlertQAMessage2"))%></div></td>
  </tr>  

</table>


<%End If%>

<BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR>
	
</body>

</html>
	<!--#include virtual="/loginstatline/includes/copyright.shm"-->


