<%Option Explicit%>

<%

Response.CacheControl = "no-cache" 
Response.AddHeader "Cache-Control", "private" 
Response.AddHeader "Pragma", "no-cache" 
Response.Expires = -1 

'Declare variables
Dim pvStartDate
Dim pvEndDate
Dim vErrorMsg
Dim ErrorReturn
Dim ReportTitle
Dim OrderBy
Dim TZ
Dim RSCount
Dim	i

Dim FontNameHead
Dim FontSizeHead
Dim FontNameData
Dim FontSizeData
Dim FontNameHeadLog
Dim FontSizeHeadLog
Dim FontSizeDataLog
Dim FontNameDataLog
Dim vReportTitle
Dim vMainTitle
Dim vTitlePeriod
Dim vTitleTo
Dim vTitleTimes%>

<%'Declare format vaiables
FontNameHead = "Arial"
FontSizeHead = "2"
FontNameData = "Times New Roman"
FontSizeData = "2"
FontNameHeadLog = "Arial"
FontSizeHeadLog = "1.5"
FontNameDataLog = "Times New Roman"
FontSizeDataLog = "1.5"%>

<HTML>
<HEAD>
<META HTTP-EQUIV="Expires" content="now">
<META HTTP-EQUIV="Content-Type" content="text/html; charset=iso-8859-1">
<TITLE>Message Activity</TITLE>
</HEAD>
<BODY bgcolor="#F5EBDD">

<!--#include virtual="/loginstatline/includes/Authorize.sls"-->
<!--#include virtual="/loginstatline/includes/TimeZoneProcess.vbs"-->

<%
'Execute the main page generating routine
If AuthorizeMain Then

	'Create a connection object
	Set Conn = server.CreateObject("ADODB.Connection")
	Conn.Open DataSourceName, DBUSER, DBPWD

	OrderBy = Request.QueryString("OrderBy")

	If ExecuteMain Then
	
		'Set Title Values
		vReportTitle = ReportTitle
		vMainTitle = "Message Activity"
		vTitlePeriod = pvStartDate
		vTitleTo = pvEndDate
		vTitleTimes = "All Times " & ZoneName(TZ)
	%>
		<!-- Print the header. -->
		<!--#include virtual="/loginstatline/reports/message/Head.sls"-->

		<!-- Print the detail. -->
		<!--#include virtual="/loginstatline/reports/message/ActivitySection1.sls"-->
		<!--#include virtual="/loginstatline/reports/message/ActivitySection2.sls"-->
	<%
	Else
	%>
		<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>No Messages</Font>
	<%
	End If

End If

Set RS = Nothing
Set Conn = Nothing

%>

<hr align="CENTER" color="#000000" noshade size="1" width="100%"></hr>
</body>
</html>

<%
Function ExecuteMain()

	'Set Order By
	If OrderBy = "" Or OrderBy = "0" Then
		OrderBy = 0
	Else
		If Left(OrderBy, 12) = "CallDateTime" Then
			OrderBy = 1
		Else
			OrderBy = 0
		End If
	End If

	'Get the organization name
	vQuery = "sps_OrganizationName " & UserOrgID & " "
	Set RS = Conn.Execute(vQuery)
	ReportTitle = RS("OrganizationName")
	Set RS = Nothing

	vQuery = "sps_OrganizationTimeZone " & UserOrgID & " "
	Set RS = Conn.Execute(vQuery)
	TZ = RS("OrganizationTimeZone")
	Set RS = Nothing

	'Get data counts
	vQuery = "sps_MessageCountType '" & pvStartDate & "', '" & pvEndDate & "', " & UserOrgID
	Set RSCount = Conn.Execute(vQuery)

	If RSCount.EOF = True Then
		ExecuteMain = False
		Exit Function
	Else
		ExecuteMain = True
	End If

	'Get data rows

	vQuery = "sps_MessageActivity '" & pvStartDate & "', '" & pvEndDate & "', " & UserOrgID & ", " & TZ & ", " & OrderBy
	Set RS = Conn.Execute(vQuery)

	If RS.EOF = True Then
		ExecuteMain = False
	Else
		ExecuteMain = True
	End If

End Function
%>

</BODY>
</HTML>
<!--#include virtual="/loginstatline/includes/copyright.shm"-->
<%
Sub FixQueryString(pvIn, pvOut)

	Dim x

	pvOut = ""

	For x=1 TO Len(pvIn)

		If Mid(pvIn,x,1) = "_" Then
			pvOut = pvOut & " "
		Else
			pvOut = pvOut & Mid(pvIn,x,1)
		End If

	Next

End Sub
%>