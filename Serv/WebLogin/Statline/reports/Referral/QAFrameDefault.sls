<%
Option Explicit

'Declare variables
Dim ErrorReturn
Dim pvStartDate
Dim pvEndDate
Dim DateTime
Dim vErrorMsg
Dim vOrgList
Dim pvUserOrgID
Dim pvOrgID
Dim pvReportGroupID
Dim pvReferralTypeID
Dim pvCallID
Dim vReportGroupName
Dim vReportTitle
Dim pvOrderBy
Dim pvOptions

Dim pvNoName
Dim pvShowSection1
Dim Identify
Dim Referral
Dim vTZ
Dim i
Dim ResultArray
Dim vNoRecords
Dim CountCheck
Dim ErrorCatch

Dim FontNameHead
Dim FontSizeHead
Dim FontNameData
Dim FontSizeData
Dim FontNameHeadLog
Dim FontSizeHeadLog
Dim FontSizeDataLog
Dim FontNameDataLog
Dim DateStart, DateEnd

%>

<!--#include virtual="/loginstatline/includes/Authorize.sls"-->

<%
'Verify Access

If AuthorizeMain Then


	'Open Connection
	Set Conn = server.CreateObject("ADODB.Connection")
	Conn.Open DataSourceName, DBUSER, DBPWD
	
	'Get the query variables
	Call FixQueryString(Request.QueryString("StartDate"), pvStartDate)
	Call FixQueryString(Request.QueryString("EndDate"), pvEndDate)
	
	pvUserOrgID = FormatNumber(Request.QueryString("UserOrgID"),0,,0,0)
	pvOrgID = FormatNumber(Request.QueryString("OrgID"),0,,0,0)
	pvReportGroupID = FormatNumber(Request.QueryString("ReportGroupID"),0,,0,0)
	pvReferralTypeID = FormatNumber(Request.QueryString("ReferralType"),0,,0,0)
	pvCallID = FormatNumber(Request.QueryString("CallID"),0,,0,0)
	pvOrderBy = Request.QueryString("OrderBy")
	pvOptions = Request.QueryString("Options")
	CountCheck = Request.QueryString("CountCheck")	
	Set RS = Nothing	
	Set Conn = Nothing
	
%>

<html>

<head bgcolor="#F5EBDD" >
<meta name="GENERATOR" content="Microsoft FrontPage 3.0">
<meta http-equiv="EXPIRES" content="0">
<meta http-equiv="Content-type" content="text/html; charset=iso-8859-1">
<title>ParametersFrameDefault</title>
</head>
 
<frameset border="0" framespacing="0" frameborder="1" cols="25%,75%">
	<frame name="Activity" scrolling="auto" target="contents" src="/loginstatline/reports/referral/QActivity.sls?StartDate=<%=pvStartDate%>&EndDate=<%=pvEndDate%>&ReportGroupID=<%=pvReportGroupID %>&OrgID=<%=pvOrgID %>&ReferralType=<%=pvReferralTypeID %>&OrderBy=<%=pvOrderBy %>&UserID=<%=UserID%>&UserOrgID=<%=pvUserOrgID%>&DSN=<%=DataSourceName%>">
	<frame name="Detail" scrolling="auto" >
</frameset>
  
  <noframes>
  <body topmargin="5" leftmargin="5" bgcolor="#F5EBDD" >
  <p>This page uses frames, but your browser doesn't support them.</p>
  </body>
  </noframes>

</html>

<%
End If
%>
