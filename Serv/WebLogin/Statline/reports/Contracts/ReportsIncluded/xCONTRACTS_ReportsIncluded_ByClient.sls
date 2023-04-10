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
Dim TempOrgType			'Temporary Variable used in Organization Type Do...While loop.

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
	Server.ScriptTimeout = 270
	conn.CommandTimeout = 90
	
	'Create Recordset
    vQuery = "CONTRACTS_ReportsIncluded_ByClient """ & AsgChoice & """"
    Set RS = Conn.Execute(vQuery)%>
<html>

<head>
    <LINK REL="stylesheet" TYPE="text/css" HREF="..\StatlineContracts.css">
	<meta http-equiv="Expires" content="0">
	<title><%=ReportName%></title>
</head>

<body bgcolor="#F5EBDD" text="BLACK">
<%'Statline page header%>
	<table width="100%">
		<tr><%'Insert the Name of the Report and the selected filter to the header%>
			<td width="75"><img src="/loginstatline/images/logo1.gif" width="60" height="60"></td>
			<td width="*" CLASS="PageTitle"><b><%=ReportName%><br><FONT CLASS=PageTitle2>&nbsp&nbsp<%=RS("OrganizationName")%></FONT>
		</tr>
	</table><p>
	<table width="662"><%'Add Red Line Separator%>
		<tr>
			<td width ="662"><img src="/loginstatline/images/redline.gif" width="652" height="2" align="left"></td>
		</tr>
	</table>

<%
'****************************************************************************************************
'Section III: Main Body of Page
'****************************************************************************************************
	%><table border=1 width="662" cellSpacing=1 cellPadding=1 bordercolor="#F5EBDD" bordercolordark="#F5EBDD" bordercolorlight="#F5EBDD">
	<%HeaderRow%>
		<%Do While Not RS.EOF%>
		<tr>
			<td width="470" CLASS="DataCell" valign="Top"><%=RS("ReportDisplayName")%>&nbsp</td>
			<td width="120"  CLASS="DataCell" valign="Top"><%=RS("ReportType")%>&nbsp</td>
			<td width="72"  CLASS="DataCell" valign="Top"><%=RS("Included")%>&nbsp</td>
		</tr>
		<%RS.MoveNext
		Loop%>
		
	</table>	
  
<%End If

'****************************************************************************************************
'Section IV:  End of Page 
'****************************************************************************************************
%>
</body>

</html>
<!--#include virtual="/loginstatline/includes/copyright.shm"-->
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
Set TempOrgType	   = Nothing
Set UserID		   = Nothing
Set UserOrgID	   = Nothing
Set vQuery		   = Nothing
%>
<%
'****************************************************************************************************
'Section V:  VBScript Functions and Subs 
'****************************************************************************************************
'Organization Name and Column Header
Function HeaderRow

	'Column Heading%>
		<tr>
			<td width="470" CLASS="DataHeading" valign="Top">Report Name</b></td>
			<td width="120"  CLASS="DataHeading" valign="Top">Report Type</u></b></td>
			<td width="72"  CLASS="DataHeading" valign="Top">Included</u></b></td>
		</tr>
	<%
End Function 'HeaderRow

'****************************************************************************************************
'Section VI:  JavaScript Functions and Subs 
'****************************************************************************************************
%>
