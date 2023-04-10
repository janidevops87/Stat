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
Dim AsgChoiceID
Dim AsgCategory
Dim Counter				'Counter for Each Record
Dim pvStartDate			'Required for \includes\Authorize.sls to work.  Not used for anything else in this page.
Dim pvEndDate			'Required for \includes\Authorize.sls to work.  Not used for anything else in this page.
Dim ReportName			'The ReportDisplayName of the calling report.  Used in all calling reports.
Dim CriteriaID			'Temporary Variable used in Organization Type Do...While loop.
Dim OrganizationID		'Temporary Variable used in Organization Type Do...While loop.
dim hdr

'Constants
Const FontNameData = "Times New Roman"	'Name of Font for Data Listing
Const FontNameHead = "Arial"			'Name of Font for Header Listing
Const FontSizeData = "1"				'Size of Font for Data Listing
Const FontSizeHead = "2"				'Size of Font for Header Listing

'Get values for the incoming variables
AsgChoiceID = Request.QueryString("AsgChoice")
AsgCategory = Request.QueryString("AsgCategory")
ReportID = Request.QueryString("ReportID")
ReportName = Request.QueryString("ReportName")
UserID = Request.QueryString("UserID")
UserOrgID = Request.QueryString("UserOrgID")

if AsgChoiceID = "" then AsgChoiceID = -1 End If

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
	Server.ScriptTimeout = 27000
	conn.CommandTimeout = 90
	Conn.Open DataSourceName, DBUSER, DBPWD
	
	
	If AsgChoiceID <> -1 Then
		'GET THE CriteriaGroups Name
		vQuery = "sps_CONTRACTS_CriteriaGroupsName " & AsgChoiceID
		Set RS = Conn.Execute(vQuery)
	
		AsgChoice = RS("CriteriaGroupName")
	Else
		AsgChoice = " " 
	End If
	
%>
<html>

<head>
	<LINK REL="stylesheet" TYPE="text/css" HREF="..\StatlineContracts.css">
	<meta http-equiv="Expires" content="0">
	<STYLE>H5{page-break-before: always}</STYLE>
	<title><%=ReportName%></title>
</head>

<body bgcolor="#F5EBDD" text="BLACK">
<%'Statline page header%>
	<table width="100%">
		<tr><%'Insert the Name of the Report and the selected filter to the header%>
			<td width="75"><img src="/loginstatline/images/logo1.gif" width="60" height="60"></td>
			<td width="*" CLASS="PageTitle"><b>CONTRACTS - Client Secondary Screening Criteria<br><FONT CLASS=PageTitle2>&nbsp&nbsp<%=SetAsgChoice(AsgChoice)%> <%if trim(AsgChoice) <> "" then%> - <%end if%> <%=UCase(AsgCategory)%></FONT>
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
'Create Recordset
vQuery = "sps_CONTRACTS_FSCriteriaGroups_ByClient " & AsgChoiceID
'print vQuery
Set RS = Conn.Execute(vQuery)%>


<%Do While Not RS.EOF%>
	<%IF CriteriaID <> RS("SubCategoryID") OR OrganizationID <> RS("ProcessorID") THEN%>
		<%HeaderRow%>
		<tr>
			<td width="200" CLASS="DataCell" valign="Top"><%=RS("SubCategory")%>&nbsp</td>
			<td width="190" CLASS="DataCell" valign="Top"><%=RS("Processor")%>&nbsp</td>
			<td width="70"  CLASS="DataCell" valign="Top"><%=RS("Processor Order")%>&nbsp</td>
			<td width="70"  CLASS="DataCell" valign="Top"><%=RS("Male Age")%>&nbsp</td>
			<td width="62"  CLASS="DataCell" valign="Top"><%=RS("Male Weight")%>&nbsp</td>
			<td width="70"  CLASS="DataCell" valign="Top"><%=RS("Female Age")%>&nbsp</td>
			<td width="62"  CLASS="DataCell" valign="Top"><%=RS("Female Weight")%>&nbsp</td>
		</tr><tr>
			<td width="500" CLASS="DataCell" valign="Top"><b>General Alert</b></td>
			<td width="500" colspan=6 CLASS="DataCell" valign="Top"><%=RS("General Alert")%>&nbsp</td>
		</tr><tr>
		<%IF NOT ISNULL(rs("IndicationID")) THEN%>
			<td width="200" CLASS="DataCell"    valign="Top">&nbsp</td>
			<td width="190" CLASS="DataHeading" valign="Top">Indicator</td>
			<td width="190" CLASS="DataHeading" valign="Top">R/O Reason</td>
			<td width="272" CLASS="DataHeading" valign="Top" colspan="4">Indicator Note</td>
			<%CriteriaID = RS("SubCategoryID")%>
			<%OrganizationID = RS("ProcessorID")%>
			
			</tr><tr>
				<td width="200" CLASS="DataCell" valign="Top">&nbsp</td>
				<td width="190" CLASS="DataCell" valign="Top"><%=RS("Indicator")%>&nbsp</td>
				<td width="190" CLASS="DataCell" valign="Top"><%=RS("R/O Reason")%>&nbsp</td>
				<td width="272" CLASS="DataCell" valign="Top" colspan="4"><%=RS("Indicator Note")%>&nbsp</td>
	    		</tr>
		<%END IF%>  
	<%ELSE%>
	    <tr>
		<td width="200" CLASS="DataCell" valign="Top">&nbsp</td>
		<td width="190" CLASS="DataCell" valign="Top"><%=RS("Indicator")%>&nbsp</td>
		<td width="190" CLASS="DataCell" valign="Top"><%=RS("R/O Reason")%>&nbsp</td>
		<td width="272" CLASS="DataCell" valign="Top" colspan="4"><%=RS("Indicator Note")%>&nbsp</td>
	    </tr>
	<%END IF%>
	<%RS.MoveNext%>
<%Loop%>
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
Set UserID		   = Nothing
Set UserOrgID	   = Nothing
Set vQuery		   = Nothing
%>
<%
'****************************************************************************************************
'Section V:  VBScript Functions and Subs 
'****************************************************************************************************
'Organization Name and Column Header
Function HeaderRow%>
    </table>
    <%IF NOT rs.EOF THEN%><H5><%END IF%>
    <table border=1 width="662" cellSpacing=1 cellPadding=1 bordercolor="#F5EBDD" bordercolordark="#F5EBDD" bordercolorlight="#F5EBDD">
	<tr>
		<td width="200"  CLASS="DataHeading" valign="Top">Sub-Category</b></td>
		<td width="190"  CLASS="DataHeading" valign="Top">Processor</u></b></td>
		<td width="60"   CLASS="DataHeading" valign="Top">Processor Order</u></b></td>
		<td width="50"   CLASS="DataHeading" valign="Top">Male Age</u></b></td>
		<td width="50"   CLASS="DataHeading" valign="Top">Male Weight</u></b></td>
		<td width="50"   CLASS="DataHeading" valign="Top">Female Age</u></b></td>
		<td width="50"   CLASS="DataHeading" valign="Top">Female Weight</u></b></td>
	</tr>
<%End Function 'HeaderRow

Function SetAsgChoice(pvAsgChoice)

	IF (pvAsgChoice="%") Then 
		SetAsgChoice = "All Clients" 
	ELSE 
		SetAsgChoice = pvAsgChoice 
	End If


End Function


'****************************************************************************************************
'Section VI:  JavaScript Functions and Subs 
'****************************************************************************************************
%>
