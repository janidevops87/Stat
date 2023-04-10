<%Option Explicit%>
<!--Assignments.sls - created 4/6-4/7, 4/10 2000 by Daniel Reddy. Statline, LLC.-->
<%
'****************************************************************************************************
'File Name:		Organizations.sls						Created By:		Daniel Reddy  Statline, LLC.
'Date(s):		4/6-4/7, 4/10 2000
'Description:	This is the Assignments Report.
'
'****************************************************************************************************
'Section I:  Variables and Includes
'****************************************************************************************************
'Pre-defined variables:
'Conn					'Variable used for Database Connection.  Used in \includes\Authorize.sls
'DataSourceName			'Variable defining Database to be used. Used and defined in \includes\Authorize.sls
'ReportID				'The ReportID of the desired Report.
'RS						'Variable for RecordSets. Used in \includes\Authorize.sls
'UserID					'The current user's UserID. Used in \includes\Authorize.sls
'UserOrgID				'The Organization the current user belongs to. Used in \includes\Authorize.sls
'vQuery					'Variable that contains the Query sent to the Database. Used in \includes\Authorize.sls

'New variables:
Dim AsgChoice			'Variable Containing the desired filter for the report in question.
Dim Counter				'Counter for Each Record
Dim pvStartDate			'Required for \includes\Authorize.sls to work.  Not used for anything else in this page.
Dim pvEndDate			'Required for \includes\Authorize.sls to work.  Not used for anything else in this page.
Dim ReportName			'The ReportDisplayName of the calling report.  Used in all calling reports.
Dim CriteriaID			'Temporary Variable used in Organization Type Do...While loop.
Dim OrganizationID		'Temporary Variable used in Organization Type Do...While loop.

'Constants
Const FontNameData = "Times New Roman"	'Name of Font for Data Listing
Const FontNameHead = "Arial"			'Name of Font for Header Listing
Const FontSizeData = "1"				'Size of Font for Data Listing
Const FontSizeHead = "2"				'Size of Font for Header Listing

'Get values for the incoming variables
AsgChoice = Request.QueryString("AsgChoice")
ReportID = Request.QueryString("ReportID")
ReportName = Request.QueryString("ReportName")
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
%>
<html>

<head>
	<LINK REL="stylesheet" TYPE="text/css" HREF="..\StatlineContracts.css">
	<meta http-equiv="Expires" content="0">
	<title><%=ReportName%></title>
</head>

<body bgcolor="#F5EBDD" text="BLACK"><%
'****************************************************************************************************
'Section III: Main Body of Page
'****************************************************************************************************
'Create Recordset
Set RS = Conn.Execute("sps_CONTRACTS_FSCriteriaGroups_TOC")%>

<table width="100%" CLASS="SideBarHeading">
	<tr>
		<td CLASS="SideBarHeading">Clients<br></td>
	</tr>
</table>

<!--<a CLASS="SideBarData" TARGET=page href="CONTRACTS_FSCriteriaGroups_ByClient.sls?UserID=<%=UserID%>&UserOrgID=<%=UserOrgID%>&AsgChoice=0&ReportID=<%=ReportID%>&ReportName=<%=ReportName%>">All Clients</a><br>-->
<%Do While Not RS.EOF%>
	<a CLASS="SideBarData" TARGET=page href="CONTRACTS_FSCriteriaGroups_ByClient.sls?UserID=<%=UserID%>&UserOrgID=<%=UserOrgID%>&AsgChoice=<%=rs("CriteriaGroupID")%>&AsgCategory=<%=RS("Donor Category")%>&ReportID=<%=ReportID%>&ReportName=<%=ReportName%>"><%=RS("Criteria Group")%> - <%=RS("Donor Category")%>&nbsp</a><br>
	<%RS.MoveNext%>
<%Loop%>
  
<%End If

'****************************************************************************************************
'Section IV:  End of Page 
'****************************************************************************************************
%>
</body>

</html>
<%'Clear Open Variables
Set Conn		   = Nothing
Set Counter		   = Nothing
Set DataSourceName = Nothing
Set pvStartDate    = Nothing
Set pvEndDate	   = Nothing
Set AsgChoice	   = Nothing
Set ReportID	   = Nothing
Set ReportName	   = Nothing
Set RS			   = Nothing
Set UserID		   = Nothing
Set UserOrgID	   = Nothing
Set vQuery		   = Nothing
%>
<%
'****************************************************************************************************
'Section V:  VBScript Functions and Subs 
'****************************************************************************************************
function PatchURL(s)
  PatchURL = replace(s," ","%20")
end function

'****************************************************************************************************
'Section VI:  JavaScript Functions and Subs 
'****************************************************************************************************
%>
