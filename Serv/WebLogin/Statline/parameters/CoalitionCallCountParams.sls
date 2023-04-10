<%
Option Explicit

Dim pvStartDate
Dim pvEndDate
Dim RS1
Dim RestrictReferralType
Dim ReferralTypeList
Dim i
Dim vErrorMessage
Dim BrowserUA
Dim MasterReportGroupID
Dim Temp
Dim MSBrowser
Dim CurrentMonth
Dim CurrentYear
Dim vErrorMsg
Dim ErrorReturn

'Get the current month and year
CurrentMonth = Month(now())
CurrentYear = Year(now())

'Get the browser type
MSBrowser = "False"
BrowserUA = Request.ServerVariables("HTTP_USER_AGENT")
Temp = InStr(1, BrowserUA, "MSIE")
If Temp > 0 Then
	MSBrowser = "True"
End If
%>

<!--#include virtual="/loginstatline/includes/Authorize.sls"-->
<!--#include virtual="/loginstatline/includes/ParamDates.sls"-->
<%
'Verify Access
If AuthorizeMain Then
	Call DisplayParameters
End If


Function DisplayParameters()

	'Open Connection
	Set Conn = server.CreateObject("ADODB.Connection")
	Conn.Open DataSourceName, DBUSER, DBPWD

	'Get the master group for the user's organization
	vQuery = "sps_ReportGroupMaster " & UserOrgID
	Set RS = Conn.Execute(vQuery)
	If Not RS.EOF Then
		MasterReportGroupID = RS("WebReportGroupID")
	Else
		MasterReportGroupID = 0
	End If
	Set RS = Nothing
%>

<html>

<head>
<meta name="GENERATOR" content="Microsoft FrontPage 3.0">
<meta http-equiv="EXPIRES" content="0">
<meta http-equiv="Content-type" content="text/html; charset=iso-8859-1">
<title>Parameters</title>
</head>

<body bgcolor="#F5EBDD" text="BLACK" onload="">

<form name="reportForm">
  <input type="hidden" name="serverName" value="<%=Request.ServerVariables("SERVER_NAME")%>">
  <input type="hidden" name="userID" value="<%=UserID%>">
  <input type="hidden" name="userOrgID" value="<%=UserOrgID%>">
  <input type="hidden" name="datasource" value="<%=DataSourceName%>">
  <input type="hidden" name="MSBrowser" value="<%=MSBrowser%>">

<!-- Information Notice--->
  <table align="left" border="0" cellPadding="0" cellSpacing="0" style="WIDTH: 550px"
	width="550" bgColor="#112084">
	<tr>
		<td width="540"><font color=#FFFFFF face="Arial" size="4"><b>&nbsp;Donate Life America Call Count</b></font></td>
	</tr>
  </table>

<p>&nbsp;</p>

<%
Dim ReportListIndex


%>
  <table cellPadding="0" cellSpacing="2">
        <tr>
        	<td valign="center" width="95"><font size="2" face="Arial"><b>From Date</b></font></td>
            <td valign="center" align="left"><font face="Arial"><input onfocus="this.select()" value="<%=FormatDateTime(Now-1,vbShortDate)%>" size="7" name="startDate" maxlength="8"> </td>
            <td valign="center" align="left"><font face="Arial" size="2"><b>Time</b></font></td>
            <td valign="center" align="left"><font face="Arial"><input onfocus="this.select()" value="00:00" size="7" name="startTime" maxlength="5"> </td>
        </tr>
        <tr>
            <td valign="center"><font size="2" face="Arial"><b>To Date</b></font></td>
            <td valign="center" align="left"><font face="Arial"><input onfocus="this.select()" value="<%=FormatDateTime(Now,vbShortDate)%>" size="7" name="endDate" maxlength="8"> </td>
            <td valign="center" align="left"><font face="Arial" size="2"><b>Time</b></font></td>
            <td valign="center" align="left"><font face="Arial"><input onfocus="this.select()" value="23:59" size="7" name="endTime" maxlength="5"> </td>
    	</tr>

  </table>


 <HR SIZE=1 width=550 align="left">

	<table>
	  <tr>
	    <td width="95"></td>
	    <td>
		  	<A href="javascript:clickShow()">
			<IMG SRC="/loginstatline/images/show.gif" NAME="showReport" BORDER="0"></A>
		</td>
	  </tr>
	</table>


</form>
</body>
</html>

<%End Function%>



<script language="JavaScript">

	function clickShow()
	{

	var url = ""
	var reportvalue = ""
	var reportfile = ""
	var reportid = ""
	var pipeIndex = 0
	var pipeIndex2 = 0
	var optionString = ""
	var orderby = ""

	reportfile = "/reports/Information/CoalitionCallCount.sls?"
	reportid = 173


	if (validate())
		{
		url = strHttpHeader + document.reportForm.serverName.value + "/loginstatline"
		url = url + reportfile
		url = url + "StartDate=" + document.reportForm.startDate.value + "_" + document.reportForm.startTime.value
		url = url + "&EndDate=" + document.reportForm.endDate.value + "_" + document.reportForm.endTime.value
		url = url + "&userID=" + document.reportForm.userID.value
		url = url + "&userOrgID=" + document.reportForm.userOrgID.value
		url = url + "&DSN=" + document.reportForm.datasource.value
		url = url + "&Options=" + optionString
		url = url + "&ReportID=" + reportid

		window.open(url,"_blank",'toolbar=1,location=0,directories=0,status=1,menubar=1,scrollbars=1,resizable=1')

		return
		}

	return

	}


	function validate()
	{

	if (document.reportForm.MSBrowser.value == 'True')
		{
		if (!isDate(document.reportForm.startDate.value))
			{
			alert ("Date error. Please enter a date in the format of mm/dd/yy.")
			document.reportForm.startDate.focus()
			document.reportForm.startDate.select()
			return false
			}
		if (!isTime(document.reportForm.startTime.value))
			{
			alert ("Time error. Please enter a time in the format of hh:mm.")
			document.reportForm.startTime.focus()
			document.reportForm.startTime.select()
			return false
			}
		if (!isDate(document.reportForm.endDate.value))
			{
			alert ("Date error. Please enter a date in the format of mm/dd/yy.")
			document.reportForm.endDate.focus()
			document.reportForm.endDate.select()
			return false
			}
		if (!isTime(document.reportForm.endTime.value))
			{
			alert ("Time error. Please enter a time in the format of hh:mm.")
			document.reportForm.endTime.focus()
			document.reportForm.endTime.select()
			return false
			}
		}
	return true

	}


function makeArray(n)
{
   for (var i = 1; i <= n; i++) {
      this[i] = 0
   }
   return this
}
</script>

<!--#include virtual="/loginstatline/includes/datevalidation.js"-->

