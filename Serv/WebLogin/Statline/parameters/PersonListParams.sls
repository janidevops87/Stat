<%Option Explicit%>
<!--PersonListParams.sls - created 3/8-3/9, 4/6-4/7 2000 by Daniel Reddy. Statline, LLC.-->
<%
'****************************************************************************************************
'File Name:		PersonListParams.sls					Created By:		Daniel Reddy  Statline, LLC.
'Date(s):		3/8-3/9 2000
'Description:	This is the parameters screen for the Personnel Listing Report.  On it the user selects
'				the various filters they desire to produce a list of Employees based on the Organization.
'
'Changes:		4/6/2000 by Daniel Reddy.  Code Formatting changes and Validation Function.
'				4/7/2000 by Daniel Reddy.  Final amendmant to Validate Function.
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
Dim OrgTypeID			'Variable for the iframe
Dim pvStartDate			'Required for \includes\Authorize.sls to work.
Dim pvEndDate			'Required for \includes\Authorize.sls to work.
Dim StateID				'Variable for the iframe.

'Get values for the incoming variables
ReportID = Request.QueryString("ReportID")
UserID = Request.QueryString("UserID")
UserOrgID = Request.QueryString("UserOrgID")

'Establish starting values for variables
OrgTypeID = 0
StateID = 0

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
	<title>Person List Parameters</title>
</head>

<body bgcolor="#F5EBDD" text="BLACK" onload="document.PLRepForm.StateChoice.focus()">
<form name="PLRepForm">

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
'Create Form%>
<table border="0" cellpadding="0" cellspacing="2">
<%'Organization State Option%>
	<tr> <%'Select the State the Organization is in (default is blank).
		'Generate list of States
			vQuery = "EXECUTE sps_StateList"
			Set RS = Conn.Execute(vQuery)%>
		<td ALIGN=LEFT VALIGN=center WIDTH=138><font face="Arial" size="2"><b>Organization State:</b></font></td>
		<td ALIGN=LEFT VALIGN=center WIDTH=137><select name="StateChoice" onChange="NewSelect(this.options[this.selectedIndex].value);" size="1">
			<option value="0" selected> &nbsp </option>
				<%Do While Not RS.EOF%>
					<option value="<%=RS("StateID")%>"><%=RS("StateName")%></option>
					<%RS.MoveNext
				Loop
				Set RS = Nothing
				Set vQuery = Nothing%></select></td>
	</tr>

<%'Organization Type Option%>
	<tr> <%'Select Organization Type (default is all)
		'Generate list of Organization Types
			vQuery = "SELECT OrganizationTypeID, OrganizationTypeName FROM OrganizationType ORDER BY OrganizationTypeName ASC"
			Set RS = Conn.Execute(vQuery)%>
		<td ALIGN=LEFT VALIGN=center WIDTH=138><font face="Arial" size="2"><b>Organization Type:</b></font></td>
		<td ALIGN=LEFT VALIGN=center WIDTH=137><select name="OrgType" onChange="NewSelect(this.options[this.selectedIndex].value);" size="1">
			<option value="0" selected>All Types</option>
				<%Do While Not RS.EOF%>
					<option value="<%=RS("OrganizationTypeID")%>"><%=RS("OrganizationTypeName")%></option>
					<%RS.MoveNext
				Loop
				Set RS = Nothing
				Set vQuery = Nothing%></select></td>
	</tr>

<%'Organization Option%>
	<tr><%'Organization choice (default is blank).
		'Dynamically create list of Organizations based on above options selected%>
		<td ALIGN=LEFT VALIGN=center WIDTH=138><font face="Arial" size="2"><b>Organization:</b></font></td>
		<td ALIGN=LEFT VALIGN=center WIDTH=424>
			<iframe height=25 width=424 name="OrgFrame" Frameborder=0 MarginHeight=0 Marginwidth=0 Scrolling="no"
				src="/loginstatline/parameters/OrgStateList.sls?UserID=<%=UserID%>&UserOrgID=<%=UserOrgID%>&StateID=<%=StateID%>&OrgTypeID=<%=OrgTypeID%>">
			</iframe></td>
	</tr>
<%'Order By Option%>
	<tr><%'Order by First Name or Last Name (default is First Name)%>
		<td ALIGN=LEFT VALIGN=center WIDTH=138><font face="Arial" size="2"><b>Order By:</b></font></td>
		<td ALIGN=LEFT VALIGN=center WIDTH=137><select name="OrderBy" size="1">
			<option value="0" selected>First Name</option>
			<option value="1">Last Name</option></select></td>
	</tr>
</table>
<%'Show Button%>
<table border="0" cellpadding="0" cellspacing="2">
	<tr> <%'Show Button%>
		<td width="138"></td>
	    <td><A href="javascript:Validate();"><IMG SRC="/loginstatline/images/show.gif" NAME="Validate" BORDER="0"></A></td>
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
Set OrgTypeID	   = Nothing
Set pvStartDate	   = Nothing
Set pvEndDate	   = Nothing
Set ReportID	   = Nothing
Set RS			   = Nothing
Set StateID		   = Nothing
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

function NewSelect(StateID)
{
var OrgTypeID
var StateID
var UserID
var UserOrgID

OrgTypeID = document.PLRepForm.OrgType.value
StateID = document.PLRepForm.StateChoice.value
UserID = document.PLRepForm.UserID.value
UserOrgID = document.PLRepForm.UserOrgID.value

   frames[0].location.replace("/loginstatline/parameters//OrgStateList.sls?UserID=" + UserID + "&UserOrgID=" + UserOrgID + "&StateID=" + StateID + "&OrgTypeID=" + OrgTypeID);
}

function Validate()
{
if (document.PLRepForm.StateChoice.value == '0')
	{
		alert ("Please select a State Name.")
		document.PLRepForm.StateChoice.focus()
		return
	}

if (frames[0].organization.options[frames[0].organization.selectedIndex].value == '0')
	{
		alert ("Please select an Organization.")
		return
	}
else

var ReportID
var ReportName
var ReportURL
var URL = ""

OrderBy = document.PLRepForm.OrderBy.value
ReportID = document.PLRepForm.ReportID.value
ReportName = document.PLRepForm.ReportName.value
ReportURL = document.PLRepForm.ReportURL.value
URL = strHttpHeader + document.PLRepForm.ServerName.value + "/loginstatline" + ReportURL
URL = URL + "UserID=" + document.PLRepForm.UserID.value + "&UserOrgID=" + document.PLRepForm.UserOrgID.value
URL = URL + "&Organization=" + frames[0].organization.options[frames[0].organization.selectedIndex].value
URL = URL + "&OrderBy=" + OrderBy + "&ReportID=" + ReportID + "&ReportName=" + ReportName

window.open(URL,"_blank",'toolbar=1,location=0,directories=0,status=1,menubar=1,scrollbars=1,resizable=1')

return
}

</script>