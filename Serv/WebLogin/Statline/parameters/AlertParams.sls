<%Option Explicit%>
<!--AlertParams.sls - created 3/6, 3/8, 4/6 2000 by Daniel Reddy. Statline, LLC.-->
<%
'****************************************************************************************************
'File Name:		AlertParams.sls							Created By:		Daniel Reddy  Statline, LLC.
'Date(s):		3/6, 3/8 2000
'Description:	This is the parameters screen for the Alerts Report.  On it the user selects the
'				various filters they desire to produce a list of Alerts based on the Source Code.
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
	<title>Alert Parameters</title>
</head>

<body bgcolor="#F5EBDD" text="BLACK" onload="document.AlertRepForm.AlertChoice.focus()">
<form name="AlertRepForm">

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
<input type="hidden" name="ReportURL" value="<%=RS("ReportVirtualURL")%>">
<input type="hidden" name="ServerName" value="<%=Request.ServerVariables("SERVER_NAME")%>">
<input type="hidden" name="UserID" value="<%=UserID%>">
<input type="hidden" name="UserOrgID" value="<%=UserOrgID%>">
	<%Set RS = Nothing
	  Set vQuery = Nothing

'Create Form%>
<table border="0" cellpadding="0" cellspacing="2">
<%'Source Code Option%>
	<tr> <%'Select the Source Code for the report (default is all)
		'Generate list of Source Codes
			vQuery = "EXECUTE sps_SourceCodeList"
			Set RS = Conn.Execute(vQuery)%>
		<td ALIGN=LEFT VALIGN=center WIDTH=138><font face="Arial" size="2"><b>Source Code:</b></font></td>
		<td ALIGN=LEFT VALIGN=center WIDTH=137><select name="AlertChoice" size="1"><option value="All Source Codes" selected>All Source Codes</option>
			<%Do While Not RS.EOF%>
				<option value="<%=RS("SourceCodeName")%>"><%=RS("SourceCodeName")%></option>
				<%RS.MoveNext
			Loop
			Set RS = Nothing
			Set vQuery = Nothing%></select></td>
	</tr>
<%'Alert Type Option%>
	<tr> <%'Select Alert Type (default is all)
		'Generate list of Organization Types %>
		<td ALIGN=LEFT VALIGN=center WIDTH=138><font face="Arial" size="2"><b>Alert Type:</b></font></td>
		<td ALIGN=LEFT VALIGN=center WIDTH=137><select name="AlertType">
			<option value="0" selected>All Alert Types</option>
			<option value="1">Referral Alerts</option>
			<option value="2">Message Alerts</option>
			<option value="4">Import Offer Alerts</option></td>
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

ReportID = document.AlertRepForm.ReportID.value
ReportName = document.AlertRepForm.ReportName.value
ReportURL = document.AlertRepForm.ReportURL.value
URL = strHttpHeader + document.AlertRepForm.ServerName.value + "/loginstatline" + ReportURL
URL = URL + "UserID=" + document.AlertRepForm.UserID.value + "&UserOrgID=" + document.AlertRepForm.UserOrgID.value
URL = URL + "&AlertChoice=" + document.AlertRepForm.AlertChoice.value + "&AlertType=" + document.AlertRepForm.AlertType.value
URL = URL + "&ReportID=" + ReportID + "&ReportName=" + ReportName

window.open(URL,"_blank",'toolbar=1,location=0,directories=0,status=1,menubar=1,scrollbars=1,resizable=1')
return
}
</script>