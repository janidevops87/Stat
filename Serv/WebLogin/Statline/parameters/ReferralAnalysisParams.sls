
<%
Option Explicit
%>
<!--#include virtual="/loginstatline/includes/Authorize.sls"-->

<%
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
Dim RefTypePermission

'Dim UserId
'Dim UserOrgID

'Dim ReportID
'Dim ReportGroupID

'Dim vErrorResult
'Dim Conn
'Dim vQuery
'Dim RS
Dim ForLoopCounter


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

	UserID = FormatNumber(Request.QueryString("UserID"),0,,0,0)
	UserOrgID = FormatNumber(Request.QueryString("UserOrgID"),0,,0,0)

	ReportID = FormatNumber(Request.QueryString("ReportID"),0,,0,0)
	ReportGroupID = FormatNumber(Request.QueryString("ReportGroupID"),0,,0,0)

	Call FixQueryString(Request.QueryString("StartDate"), pvStartDate)
	Call FixQueryString(Request.QueryString("EndDate"), pvEndDate)

	If Request.QueryString("DSN") <> "" Then
		DataSourceName = Request.QueryString("DSN")
	Else
		DataSourceName = "Production"
	End If



'Verify Access
If UserOrgID = 194 or UserOrgID = 3314 Or UserOrgId = 3052 Then
	Call DisplayParameters

Else
			vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
			vErrorMsg = vErrorMsg & "The User Organization does not have access.<BR> <BR>"
			vErrorMsg = vErrorMsg & "Please contact Statline at (888) 881-7828 for assistance. </B> <BR> <BR> <BR>"
			vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
			vErrorMsg = vErrorMsg & "Error:     (100, GetReportGroupName, Activity.sls) <BR> <BR>"
			vErrorMsg = vErrorMsg & "</FONT></FONT>"
			Response.Write(vErrorMsg)
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
<title>Referral Analysis </title>
</head>

<body bgcolor="#F5EBDD" text="BLACK" >

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
		<td width="540"><font color=#FFFFFF face="Arial" size="4"><b>&nbsp;Referral Analysis</b></font></td>
	</tr>
  </table>

<p>&nbsp;</p>

<%


vQuery = "SELECT ReportID, ReportDisplayName, ReportVirtualUrl, ReportDescFileName FROM Report WHERE ReportTypeID = 6 AND ReportID = 172 "
Set RS = Conn.Execute(vQuery)
%>

		<input type="hidden" name="report" size="1" value="<%=RS("ReportDescFileName") & "|" & RS("ReportVirtualUrl") & "|" & RS("ReportID")%>">
<%
		Set RS = Nothing
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
			<% For ForLoopCounter = CurrentYear - 1 to CurrentYear + 3 %>
			<option value=<%=ForLoopCounter%> <%If CurrentYear = ForLoopCounter Then%> selected<%End If%>><%=ForLoopCounter%></option>
			<% NEXT %>
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
		<% For ForLoopCounter = CurrentYear - 1 to CurrentYear + 3 %>
			<option value=<%=ForLoopCounter%> <%If CurrentYear = ForLoopCounter Then%> selected<%End If%>><%=ForLoopCounter%></option>
			<% NEXT %>

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

		<%If UserOrgID = 194 or RS.EOF Then%><option value="0" selected>&nbsp;</option><%End If%>

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

'Get the organization's referral type permissions
vQuery = "sps_NWLEB_ReferralTypeViewAccess " & UserOrgID
Set RS = Conn.Execute(vQuery)
If Not RS.EOF Then
   RefTypePermission = RS("RefTypePermission")
Else
   RefTypePermission = ""
End If
%>

   <tr>
      <td valign="center" width="95"><font size="2" face="Arial"><b>Organization Type</b></font></td>
      <td valign="center">
		<select name="OrgType">
		<option value="O">Organs</option>
		<option value="T">Tissue</option>
		<option value="E">Eyes</option>
		</select>
      </td>
   </tr>            

   <tr>
      <td>
      <font size="2" face="Arial"><b>Options</b></font>
      </td>
      <td colspan=2>
      <input type=checkbox name="PageBreak" value="Y"><font size="2" face="Arial">Page Break on Organization</font>
      </td>
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

<%End Function

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
			var orderby = ""
			var fromMonth = ""
			var fromYear = ""
			var fromDate = ""
			var toMonth = ""
			var toDay = ""
			var toYear = ""
			var toDate = ""

			//if (document.reportForm.rollup[0].checked) {optionString="0"}
			//if (document.reportForm.rollup[1].checked) {optionString="1"}

			reportvalue = document.reportForm.report.value
			pipeIndex = reportvalue.indexOf("|",0)
			pipeIndex2 = reportvalue.indexOf("|",pipeIndex + 1)
			reportfile = reportvalue.substring(pipeIndex + 1,pipeIndex2)
			reportid = reportvalue.substring(pipeIndex2 + 1,reportvalue.length)

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
				url = url + "&OrgType=" + document.reportForm.OrgType.options[document.reportForm.OrgType.selectedIndex].value
				if (document.reportForm.PageBreak.checked == true)
					{ 
					url = url + "&PageBreak=1"
					}					
				url = url + "&ReportID=" + 46
				
				//reportid

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

	url = strHttpHeader + document.reportForm.serverName.value + "/loginstatline/parameters/GetOrgList.sls"
	url = url + "?ReportGroupID=" + document.reportForm.reportGroup.options[document.reportForm.reportGroup.selectedIndex].value
	window.open(url,"_blank",'toolbar=1,location=0,directories=0,status=1,menubar=1,scrollbars=1,resizable=1')

	return

	}

	function clickDesc()
	{

	/*if (document.reportForm.report.options[document.reportForm.report.selectedIndex].value == 0)
		{
			alert ("Please select a report.")
			// document.reportForm.report.focus()
			return
		}
*/
	var url = ""
	var reportvalue = ""
	var reportdescfile = ""
	var pipeIndex = 0

	reportvalue = document.reportForm.report.options[document.reportForm.report.selectedIndex].value
	pipeIndex = reportvalue.indexOf("|",0)
	reportdescfile = reportvalue.substring(0,pipeIndex)

	url = strHttpHeader + document.reportForm.serverName.value + "/loginstatline/reportdesc/" + reportdescfile
	window.open(url,"_blank",'toolbar=1,location=0,directories=0,status=1,menubar=1,scrollbars=1,resizable=1')

	return

	}


	function validate()
	{

/*	if (document.reportForm.report.selectedIndex == 0)
		{
			alert ("Please select a report.")
			// document.reportForm.report.focus()
			return false
		}
*/
	if (document.reportForm.MSBrowser.value == 'True')
		{
		if (document.reportForm.reportGroup.options[document.reportForm.reportGroup.selectedIndex].value == 0
			&& frames[0].organization.options[frames[0].organization.selectedIndex].value == 0)
			{
			alert ("Please select a schedule organization and schedule group.")
			return false
			}
		}
	else
		{
		if (document.reportForm.reportGroup.options[document.reportForm.reportGroup.selectedIndex].value == 0
			&& document.reportForm.organization.options[document.reportForm.organization.selectedIndex].value == 0)
			{
			alert ("Please select a schedule organization and schedule group.")
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

