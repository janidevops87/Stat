<%Option Explicit%>
<!--OrganizationParams.sls - created 2/23-2/25, 2/28, 3/8, 4/6 2000 by Daniel Reddy. Statline, LLC.-->
<%
'****************************************************************************************************
'File Name:		OrganizationParams.sls					Created By:		Daniel Reddy  Statline, LLC.
'Date(s):		2/23-2/25, 2/28, 3/8 2000
'Description:	This is the parameters screen for Organizations Report.  On it the user selects the
'				various filters they desire to produce a list of organizations.
'
'Changes:		4/6/2000 by Daniel Reddy.  Code Formatting changes.
'****************************************************************************************************
'Section I:  Variables and Includes
'****************************************************************************************************
'Pre-defined variables:
'Conn					'Variable used for Database Connection.  Used in \includes\Authorize.sls
'DataSourceName			'Variable defining Database to be used. Used and defined in \includes\Authorize.sls
'ReportID				'The ReportID of the desired Report. Passed from parameters\FrameCustomParams.sls
'RS						'Variable for RecordSets. Used in \includes\Authorize.sls
'UserID					'The current user's UserID. Used in \includes\Authorize.sls
'UserOrgID				'The Organization the current user belongs to. Used in \includes\Authorize.sls
'vQuery					'Variable that contains the Query sent to the Database. Used in \includes\Authorize.sls

'New variables:
Dim pvStartDate			'Required for \includes\Authorize.sls to work.
Dim pvEndDate			'Required for \includes\Authorize.sls to work.

'Get values for the incoming variables
ReportID = Request.QueryString("ReportID")
UserID = Request.QueryString("UserID")
UserOrgID = Request.QueryString("UserOrgID")

'Includes for this page:
%>
<!--#include virtual="/loginstatline/includes/Authorize.sls"-->
<%
'****************************************************************************************************
'Section II:  HTML and Page Header
'****************************************************************************************************
If AuthorizeMain Then
'Open Connection to the Database
	Set Conn = server.CreateObject("ADODB.Connection")
	Conn.Open DataSourceName, DBUSER, DBPWD
'Retrieve Report Information
	vQuery = "EXECUTE sps_ReportInformation " & ReportID
	Set RS = Conn.Execute(vQuery)
%>
<html>

<head>
	<meta http-equiv="Expires" content="0">
	<title>Organizations Parameters</title>
</head>

<body bgcolor="#F5EBDD" text="BLACK" onload="document.OrgRepForm.OrgChoice.focus()">
<form name="OrgRepForm">

	<table align="left" border="0" cellPadding="0" cellSpacing="0" style="WIDTH: 550px" width="550" bgColor="#112084">
		<tr>
			<td width="540"><font color=#ffffff face="Arial" size="4"><B>&nbsp;<%=RS("ReportDisplayName")%></B></font></td>
		</tr>
	</table>
	<br><br>
<%
'****************************************************************************************************
'Section III: Main Body of Page
'****************************************************************************************************
'List the hidden fields
%>
<input type="hidden" name="ReportID" value="<%=ReportID%>">
<input type="hidden" name="ReportName" value="<%=RS("ReportDisplayName")%>">
<input type="hidden" name="ReportURL" value=<%=RS("ReportVirtualURL")%>>
<input type="hidden" name="ServerName" value="<%=Request.ServerVariables("SERVER_NAME")%>">
<input type="hidden" name="UserID" value="<%=UserID%>">
<input type="hidden" name="UserOrgID" value="<%=UserOrgID%>">
	<%Set RS = Nothing
	  Set vQuery = Nothing
'Create Form
%>
<table border="0" cellpadding="0" cellspacing="2">
<%'Report Option
	'Determine available options
	SELECT CASE ReportID
	CASE "73"  'the Organization (by State) report%>
	<tr> <%'Select the State for the report (default is all)
		'Generate list of States
			vQuery = "EXECUTE sps_StateList"
			Set RS = Conn.Execute(vQuery)%>
		<td ALIGN=LEFT VALIGN=center WIDTH=138><font face="Arial" size="2"><b>State:</b></font></td>
		<td ALIGN=LEFT VALIGN=center WIDTH=137><select name="OrgChoice" size="1"><option value="0" selected>All States</option>
				<%Do While Not RS.EOF%>
					<option value="<%=RS("StateID")%>"><%=RS("StateName")%></option>
					<%RS.MoveNext
				Loop
				Set RS = Nothing
				Set vQuery = Nothing%></select></td><%
	CASE "75"  'the Organization (by Source Code) report%>
	<tr> <%'Select the Source Code for the report (default is all)
		'Generate list of Source Codes
			vQuery = "EXECUTE sps_SourceCodeList"
			Set RS = Conn.Execute(vQuery)%>
		<td ALIGN=LEFT VALIGN=center WIDTH=138><font face="Arial" size="2"><b>Source Code:</b></font></td>
		<td ALIGN=LEFT VALIGN=center WIDTH=137><select name="OrgChoice" size="1"><option value="All Source Codes" selected>All Source Codes</option>
				<%Do While Not RS.EOF%>
					<option value="<%=RS("SourceCodeName")%>"><%=RS("SourceCodeName")%></option>
					<%RS.MoveNext
				Loop
				Set RS = Nothing
				Set vQuery = Nothing%></select></td><%
	CASE "76"  'the Organization (by Report Group) report%>
	<tr> <%'Select the Report Group for the report (default is all)
		'Generate list of Report Groups
			vQuery = "sps_ReportGroups " & UserOrgID
			Set RS = Conn.Execute(vQuery)%>
		<td ALIGN=LEFT VALIGN=center WIDTH=138><font face="Arial" size="2"><b>Report Group:</b></font></td>
		<td ALIGN=LEFT VALIGN=center WIDTH=137><select name="OrgChoice" size="1"><option value="0" selected>All Report Groups</option>
				<%Do While Not RS.EOF%>
					<option value="<%=RS("WebReportGroupID")%>"><%=RS("ReportGroupName")%></option>
					<%RS.MoveNext
				Loop
				Set RS = Nothing
				Set vQuery = Nothing%></select></td><%
	END SELECT%>
	</tr>

<%'Organization Type Option%>
	<tr> <%'Select Organization Type (default is all)
		'Generate list of Organization Types
			vQuery = "SELECT OrganizationTypeID, OrganizationTypeName FROM OrganizationType ORDER BY OrganizationTypeName ASC"
			Set RS = Conn.Execute(vQuery)%>
		<td ALIGN=LEFT VALIGN=center WIDTH=138><font face="Arial" size="2"><b>Organization Type:</b></font></td>
		<td ALIGN=LEFT VALIGN=center WIDTH=137><select name="OrgType"><option value="0" selected>All Types</option>
				<%Do While Not RS.EOF%>
					<option value="<%=RS("OrganizationTypeID")%>"><%=RS("OrganizationTypeName")%></option>
					<%RS.MoveNext
				Loop
				Set RS = Nothing
				Set vQuery = Nothing%></select></td>
	</tr>
</table>
<%'Show Button%>
<table border="0" cellpadding="0" cellspacing="2">
	<tr> <%'Show Button%>
		<td width="138"></td>
	    <td><A href="javascript:ShowResults()"><IMG SRC="/loginstatline/images/show.gif" NAME="showReport" BORDER="0"></A></td>
	    <td><A href="javascript:history.back();"><IMG src="/loginstatline/images/cancel2.gif" NAME="Cancel" BORDER="0"></A></td>
	</tr>
</table>
<%
End If	'End of the AuthorizeMain If...Then statement (top of Section II).

'****************************************************************************************************
'Section IV:  End of Page
'****************************************************************************************************
%>
</form>
</body>

</html>
<%'Clear Open Variables
Set Conn		   = Nothing
Set DataSourceName = Nothing
Set pvStartDate	   = Nothing
Set pvEndDate	   = Nothing
Set ReportID	   = Nothing
Set RS			   = Nothing
Set UserID		   = Nothing
Set UserOrgID	   = Nothing
Set vQuery		   = Nothing
%>
<%
'****************************************************************************************************
'Section V:  VBScript Functions and Subs
'****************************************************************************************************
%>
<%
'****************************************************************************************************
'Section VI:  JavaScript Functions and Subs
'****************************************************************************************************
%>
<script language="JavaScript">

function ShowResults()
{
var ReportID
var ReportName
var ReportURL
var URL = ""

ReportID = document.OrgRepForm.ReportID.value
ReportName = document.OrgRepForm.ReportName.value
ReportURL = document.OrgRepForm.ReportURL.value
URL = strHttpHeader + document.OrgRepForm.ServerName.value + "/loginstatline" + ReportURL
URL = URL + "UserID=" + document.OrgRepForm.UserID.value + "&UserOrgID=" + document.OrgRepForm.UserOrgID.value
URL = URL + "&OrgChoice=" + document.OrgRepForm.OrgChoice.value + "&OrgType=" + document.OrgRepForm.OrgType.value
URL = URL + "&ReportID=" + ReportID + "&ReportName=" + ReportName

window.open(URL,"_blank",'toolbar=1,location=0,directories=0,status=1,menubar=1,scrollbars=1,resizable=1')
return
}
</script>