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
		<td width="540"><font color=#FFFFFF face="Arial" size="4"><b>&nbsp;UNOS Report</b></font></td>
	</tr>
  </table>

<p>&nbsp;</p>

<%
Dim ReportListIndex


%>
  <table cellPadding="0" cellSpacing="2">
    <tr>
      <td valign="center" width="95"><font size="2" face="Arial"><b>From Month</b></font></td>
      <td valign="center" align="left">
		<select name="fromMonth" size="1">
			<option value="1" <%If CurrentMonth = 1 Then%>selected<%End If%>>January</option>
			<option value="2" <%If CurrentMonth = 2 Then%>selected<%End If%>>February</option>
			<option value="3" <%If CurrentMonth = 3 Then%>selected<%End If%>>March</option>
			<option value="4" <%If CurrentMonth = 4 Then%>selected<%End If%>>April</option>
			<option value="5" <%If CurrentMonth = 5 Then%>selected<%End If%>>May</option>
			<option value="6" <%If CurrentMonth = 6 Then%>selected<%End If%>>June</option>
			<option value="7" <%If CurrentMonth = 7 Then%>selected<%End If%>>July</option>
			<option value="8" <%If CurrentMonth = 8 Then%>selected<%End If%>>August</option>
			<option value="9" <%If CurrentMonth = 9 Then%>selected<%End If%>>September</option>
			<option value="10" <%If CurrentMonth = 10 Then%>selected<%End If%>>October</option>
			<option value="11" <%If CurrentMonth = 11 Then%>selected<%End If%>>November</option>
			<option value="12" <%If CurrentMonth = 12 Then%>selected<%End If%>>December</option>
		</select>
      </td>
      <td valign="center" align="left"><font face="Arial" size="2"><b>Year</b></font></td>
      <td valign="center" align="left">
		 <select name="fromYear" size="1">
			<%=buildDropDownOptionYearList("1996")%>
		</select>

      </td>
    </tr>
    <tr>
      <td valign="center"><font size="2" face="Arial"><b>Thru Month</b></font></td>
      <td valign="center" align="left">
		<select name="toMonth" size="1">
			<option value="1" <%If CurrentMonth = 1 Then%>selected<%End If%>>January</option>
			<option value="2" <%If CurrentMonth = 2 Then%>selected<%End If%>>February</option>
			<option value="3" <%If CurrentMonth = 3 Then%>selected<%End If%>>March</option>
			<option value="4" <%If CurrentMonth = 4 Then%>selected<%End If%>>April</option>
			<option value="5" <%If CurrentMonth = 5 Then%>selected<%End If%>>May</option>
			<option value="6" <%If CurrentMonth = 6 Then%>selected<%End If%>>June</option>
			<option value="7" <%If CurrentMonth = 7 Then%>selected<%End If%>>July</option>
			<option value="8" <%If CurrentMonth = 8 Then%>selected<%End If%>>August</option>
			<option value="9" <%If CurrentMonth = 9 Then%>selected<%End If%>>September</option>
			<option value="10" <%If CurrentMonth = 10 Then%>selected<%End If%>>October</option>
			<option value="11" <%If CurrentMonth = 11 Then%>selected<%End If%>>November</option>
			<option value="12" <%If CurrentMonth = 12 Then%>selected<%End If%>>December</option>
		</select>
      </td>      <td valign="center" align="left"><font face="Arial" size="2"><b>Year</b></font></td>
      <td valign="center" align="left">
		<select name="toYear" size="1">
			<%=buildDropDownOptionYearList("1996")%>
		</select>
      </td>
    </tr>
  </table>

<!--Get the report Groups for the Box-->
<%
'Get the report groups list
vQuery = "sps_ReportGroups " & UserOrgID
Set RS = Conn.Execute(vQuery)
%>

<table cellPadding="0" cellSpacing="2">
    <tr>
      <td valign="center" width="95"><font size="2" face="Arial"><b>Report Group</b></font></td>
      <td valign="center">
		<select name="reportGroup"
		<%If MSBrowser = "True" Then%>onChange="newSelect(this.options[this.selectedIndex].value);"<%End If%>>

		<%If UserOrgID = 194 Then%><option value="0" selected></option><%End If%>

		<%Do While Not RS.EOF%>
			<option value="<%=RS("WebReportGroupID")%>"><%=RS("ReportGroupName")%></option>
			<%RS.MoveNext%>
		<%
		Loop
		Set RS = Nothing
		%>
		</select>
	  </td>
	  <td>
	  	  <A href="javascript:clickGroup()">
		  <IMG SRC="/loginstatline/images/ellipses2.gif" NAME="groupMembers" BORDER="0"></A></td>
    </tr>
</table>

<table cellPadding="0" cellSpacing="2">
<%
If MSBrowser = "True" Then
%>
	<!-- Get the Children for this Box -->
	<tr>
	  <td width="95" valign="center"><font size="2" face="Arial"><b>Organization</b></font></td>
	  <td colspan="3">
		<iframe height=25 width=415 name="OrgFrame" Frameborder=0 MarginHeight=0 Marginwidth=0 Scrolling="no"
			src="/loginstatline/parameters/organizationList.sls?ReportGroupID=<%=MasterReportGroupID%>">
		</iframe>
	  </td>
	</tr>
<%
Else
	'Get the report groups list
	vQuery = "sps_ReportGroupOrgs " & MasterReportGroupID
	Set RS = Conn.Execute(vQuery)
%>
	<!-- Get the Children for this Box -->
	<tr>
	  <td width="95" valign="center"><font size="2" face="Arial"><b>Organization</b></font></td>
      <td valign="center">
		<select name="organization">
		<option value="0" selected></option>
		<%Do While Not RS.EOF%>
			<option value="<%=RS("OrganizationID")%>"><%=RS("OrganizationName")%></option>
			<%RS.MoveNext%>
		<%
		Loop
		Set RS = Nothing
		%>
		</select>
	  </td>
	</tr>
<%
End If
%>
	<tr>
		<td width="95"><font size="2" face="Arial"><b>Options</b></font></td>
		      <td><input type="checkbox" name="BreakOnOrgID"><small>Page Break on Organization</small></td>
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

	function newSelect(vID)
	{
	   frames[0].location.replace("/loginstatline/parameters/organizationList.sls?ReportGroupID=" + vID);
	}

	function clickShow()
	{

	var url = ""
	var reportvalue = ""
	var reportfile = ""
	var reportid = ""
	var pipeIndex = 0
	var pipeIndex2 = 0
	var optionString = ""
	var BreakOnOrgIDString = ""
	var orderby = ""
	var fromMonth = ""
	var fromYear = ""
	var fromDate = ""
	var toMonth = ""
	var toDay = ""
	var toYear = ""
	var toDate = ""
	//AppropSum.shm|/reports/referral/statistics/AppropriateSummary_A.sls?|37
	//if (document.reportForm.rollup[0].checked) {optionString="0"}
	//if (document.reportForm.rollup[1].checked) {optionString="1"}

	//reportvalue = document.reportForm.report.options[document.reportForm.report.selectedIndex].value
	//pipeIndex = reportvalue.indexOf("|",0)
	//pipeIndex2 = reportvalue.indexOf("|",pipeIndex + 1)
	reportfile = "/reports/custom/UNOSReport.sls?"
	reportid = 167

	fromMonth = document.reportForm.fromMonth.options[document.reportForm.fromMonth.selectedIndex].value
	fromYear = document.reportForm.fromYear.options[document.reportForm.fromYear.selectedIndex].value
	fromDate = fromMonth + "/1/" + fromYear

	toMonth = document.reportForm.toMonth.options[document.reportForm.toMonth.selectedIndex].value
	toYear = document.reportForm.toYear.options[document.reportForm.toYear.selectedIndex].value

	if (toMonth == 2)
		{
		toDay = daysInFebruary(toYear)
		}
	else
		{
		toDay = daysInMonth(toMonth)
		}

	toDate = toMonth + "/" + toDay + "/" + toYear

	if (validate())
		{
		url = strHttpHeader + document.reportForm.serverName.value + "/loginstatline"
		url = url + reportfile
		url = url + "StartDate=" + fromDate + "_00:00"
		url = url + "&EndDate=" + toDate + "_23:59"
		url = url + "&ReportGroupID=" + document.reportForm.reportGroup.options[document.reportForm.reportGroup.selectedIndex].value

		if (document.reportForm.MSBrowser.value == 'True')
			{
			url = url + "&OrgID=" + frames[0].organization.options[frames[0].organization.selectedIndex].value
			}

		if (document.reportForm.MSBrowser.value == 'False')
			{
			url = url + "&OrgID=" + document.reportForm.organization.options[document.reportForm.organization.selectedIndex].value
			}

		url = url + "&userID=" + document.reportForm.userID.value
		url = url + "&userOrgID=" + document.reportForm.userOrgID.value
		url = url + "&DSN=" + document.reportForm.datasource.value
		url = url + "&Options=" + optionString

		if (document.reportForm.BreakOnOrgID.checked)
			BreakOnOrgIDString = "TRUE"
		else
			BreakOnOrgIDString = "FALSE"

		url = url + "&BreakOnOrgID=" + BreakOnOrgIDString
		url = url + "&ReportID=" + reportid

		window.open(url,"_blank",'toolbar=1,location=0,directories=0,status=1,menubar=1,scrollbars=1,resizable=1')

		return
		}

	return

	}


	function clickGroup()
	{

	if (document.reportForm.reportGroup.options[document.reportForm.reportGroup.selectedIndex].value == 0)
		{
			alert ("Please select a report group.")
			document.reportForm.reportGroup.focus()
			return
		}

	var url = ""

	url = strHttpHeader + document.reportForm.serverName.value + "/loginstatline/reports/admin/GetOrgList.sls"
	url = url + "?ReportGroupID=" + document.reportForm.reportGroup.options[document.reportForm.reportGroup.selectedIndex].value
	window.open(url,"_blank",'toolbar=1,location=0,directories=0,status=1,menubar=1,scrollbars=1,resizable=1')

	return

	}


	function validate()
	{

	if (document.reportForm.MSBrowser.value == 'True')
		{
		if (document.reportForm.reportGroup.options[document.reportForm.reportGroup.selectedIndex].value == 0
			&& frames[0].organization.options[frames[0].organization.selectedIndex].value == 0)
			{
			alert ("Please select either a report group or an organization.")
			return false
			}
		}
	else
		{
		if (document.reportForm.reportGroup.options[document.reportForm.reportGroup.selectedIndex].value == 0
			&& document.reportForm.organization.options[document.reportForm.organization.selectedIndex].value == 0)
			{
			alert ("Please select either a report group or an organization.")
			return false
			}
		}

	return true

	}

// daysInFebruary (INTEGER year)
//
// Given integer argument year,
// returns number of days in February of that year.

function daysInFebruary (year)
{
	// February has 29 days in any year evenly divisible by four,
    // EXCEPT for centurial years which are not also divisible by 400.
    var intYear

    intYear = parseInt(year,10)

    return (  ((intYear % 4 == 0) && ( (!(intYear % 100 == 0)) || (intYear % 400 == 0) ) ) ? 29 : 28 );
}

function daysInMonth (month)
{
	var monthDays = makeArray(12);

	monthDays[1] = 31;
	monthDays[2] = 29;
	monthDays[3] = 31;
	monthDays[4] = 30;
	monthDays[5] = 31;
	monthDays[6] = 30;
	monthDays[7] = 31;
	monthDays[8] = 31;
	monthDays[9] = 30;
	monthDays[10] = 31;
	monthDays[11] = 30;
	monthDays[12] = 31;

    return monthDays[parseInt(month,10)];
}

function makeArray(n)
{
   for (var i = 1; i <= n; i++) {
      this[i] = 0
   }
   return this
}
</script>

