<%Option Explicit%>
<!--AssignmentParams.sls - created 4/6-4/7 2000 by Daniel Reddy. Statline, LLC.-->
<%
'****************************************************************************************************
'File Name:		AssignmentParams.sls					Created By:		Daniel Reddy  Statline, LLC.
'Date(s):		4/6-4/7 2000
'Description:	This is the parameters screen for Assignments Report.  On it the user selects the
'				various filters they desire to produce a list of organizations and the assigned OPOs.
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
Dim DonorConn
Dim RegistryDSN			'Required for registry source lists

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
	<title>Assignment Parameters</title>
</head>

<body bgcolor="#F5EBDD" text="BLACK" onload="document.AsgRepForm.AsgChoice.focus()">
<form name="AsgRepForm">

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
	CASE "86"  'the Assignments (by State) report%>
	<tr> <%'Select the State for the report (default is blank)
		'Generate list of States
			vQuery = "EXECUTE sps_StateList"
			Set RS = Conn.Execute(vQuery)%>
		<td ALIGN=LEFT VALIGN=center WIDTH=138><font face="Arial" size="2"><b>State:</b></font></td>
		<td ALIGN=LEFT VALIGN=center WIDTH=137><select name="AsgChoice" size="1"><option value="0" selected> &nbsp </option>
				<%Do While Not RS.EOF%>
					<option value="<%=RS("StateID")%>"><%=RS("StateName")%></option>
					<%RS.MoveNext
				Loop
				Set RS = Nothing
				Set vQuery = Nothing%></select></td><%
	CASE "87"  'the Assignments (by Source Code) report%>
	<tr> <%'Select the Source Code for the report (default is blank)
		'Generate list of Source Codes
			vQuery = "EXECUTE sps_SourceCodeList 1"
			Set RS = Conn.Execute(vQuery)%>
		<td ALIGN=LEFT VALIGN=center WIDTH=138><font face="Arial" size="2"><b>Source Code:</b></font></td>
		<td ALIGN=LEFT VALIGN=center WIDTH=137><select name="AsgChoice" size="1"><option value="0" selected> &nbsp </option>
				<%Do While Not RS.EOF%>
					<option value="<%=RS("SourceCodeID")%>"><%=RS("SourceCodeName")%></option>
					<%RS.MoveNext
				Loop
				Set RS = Nothing
				Set vQuery = Nothing%></select></td><%
	CASE "129" ' the CO Donor Alliance Source List%>
	<tr>
		<%
		'Select the source list for the report (default is blank)

		 vQuery = "EXECUTE sps_CO_SourceEvent"
		 Set DonorConn = server.CreateObject("ADODB.Connection")
		 DonorConn.Open DONORREGISTRYDSN, DBUSER, DBPWD
		 Set RS = DonorConn.Execute(vQuery)

	      %>

		<td ALIGN=LEFT VALIGN=center WIDTH=138><font face="Arial" size="2"><b>Event Code:</b></font></td>
		<td ALIGN=LEFT VALIGN=center WIDTH=137><select name="AsgChoice" size="1"><option value="0" selected> &nbsp </option>
	      <%
		Do While Not RS.EOF
	      %>
			<option value="<%=RS("SourceCodeID")%>"><%=RS("SourceCodeName")%></option>
			<%RS.MoveNext
		Loop
		Set RS = Nothing
		Set vQuery = Nothing%></select></td>
		<%


	CASE "137" ' Registry II the CO Donor Alliance Source List%>
	<tr> <%
		call CreateList(Request.QueryString("RegistryDSN"))

	CASE "142" ' Registry II the CO Donor Alliance Source List%>
	<tr> <%
		call CreateList(Request.QueryString("RegistryDSN"))
	CASE "147" ' Registry II the CO Donor Alliance Source List%>
	<tr> <%
		call CreateList(Request.QueryString("RegistryDSN"))

	END SELECT %>
	</tr>
</table>
<%'Show Button%>
<table border="0" cellpadding="0" cellspacing="2">
	<tr> <%'Show Button%>
		<td width="138"></td>
	    <td><A href="javascript:Validate()"><IMG SRC="/loginstatline/images/show.gif" NAME="showReport" BORDER="0"></A></td>
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
	Function CreateList(RegistryDSN)
		'Select the source list for the report (default is blank)
		 vQuery = "EXECUTE sps_SourceEvent"
		 Set DonorConn = server.CreateObject("ADODB.Connection")
		 DonorConn.Open RegistryDSN, DBUSER, DBPWD
		 Set RS = DonorConn.Execute(vQuery)
		 %>
		 <input type="hidden" name="RegistryDSN" value="<%=RegistryDSN%>">

		<td ALIGN=LEFT VALIGN=center WIDTH=138><font face="Arial" size="2"><b>Event Code:</b></font></td>
		<td ALIGN=LEFT VALIGN=center WIDTH=137><select name="AsgChoice" size="1"><option value="0" selected> &nbsp </option>
	      <%
	      	Do While Not RS.EOF
	      %>
			<option value="<%=RS("SourceCodeID")%>"><%=RS("SourceCodeName")%></option>
			<%RS.MoveNext
		Loop
		Set RS = Nothing
		Set vQuery = Nothing%></select></td><%
	End Function


%>
<%
'****************************************************************************************************
'Section VI:  JavaScript Functions and Subs
'****************************************************************************************************
%>
<script language="JavaScript">

function Validate()
{
if (document.AsgRepForm.AsgChoice.value == '0')
	{
		alert ("Please make a selection.")
		document.AsgRepForm.AsgChoice.focus()
		return
	}
else
var ReportID
var ReportName
var ReportURL
var URL = ""

ReportID = document.AsgRepForm.ReportID.value
ReportName = document.AsgRepForm.ReportName.value
ReportURL = document.AsgRepForm.ReportURL.value
URL = strHttpHeader + document.AsgRepForm.ServerName.value + "/loginstatline" + ReportURL
URL = URL + "UserID=" + document.AsgRepForm.UserID.value + "&UserOrgID=" + document.AsgRepForm.UserOrgID.value
URL = URL + "&AsgChoice=" + document.AsgRepForm.AsgChoice.value
URL = URL + "&ReportID=" + ReportID + "&ReportName=" + ReportName
if(ReportID == 129)
{
 	URL = URL + "&SourceID=" + document.AsgRepForm.AsgChoice.value
}

window.open(URL,"_blank",'toolbar=1,location=0,directories=0,status=1,menubar=1,scrollbars=1,resizable=1')
return
}
</script>
