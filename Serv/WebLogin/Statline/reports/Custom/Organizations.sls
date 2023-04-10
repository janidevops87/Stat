<%Option Explicit%>
<!--Organizations.sls - created 2/25, 2/28-3/3, 3/6, 3/8-3/9, 4/6 2000 by Daniel Reddy. Statline, LLC.-->
<%
'****************************************************************************************************
'File Name:		Organizations.sls						Created By:		Daniel Reddy  Statline, LLC.
'Date(s):		2/25, 2/28-3/3, 3/6, 3/8-3/9 2000
'Description:	This is the Organizations Report.
'
'Changes:		4/6/2000 by Daniel Reddy.  Code Formatting changes and Constants declared as such.
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
Dim Counter				'Counter for Each Record
Dim OrgChoice			'Variable Containing the desired filter for the report in question.
Dim OrgType				'The OrganizationTypeID for the desired Organization Type.  Used in all calling reports.
Dim pvStartDate			'Required for \includes\Authorize.sls to work.  Not used for anything else in this page.
Dim pvEndDate			'Required for \includes\Authorize.sls to work.  Not used for anything else in this page.
Dim ReportName			'The ReportDisplayName of the calling report.  Used in all calling reports.
Dim TempOrgType			'Temporary Variable used in Organization Type Do...While loop.

Dim vReportTitle
Dim vMainTitle
Dim vTitlePeriod
Dim vTitleTo
Dim vTitleTimes

'Constants
Const FontNameData = "Times New Roman"	'Name of Font for Data Listing
Const FontNameHead = "Arial"			'Name of Font for Header Listing
Const FontSizeData = "1"				'Size of Font for Data Listing
Const FontSizeHead = "2"				'Size of Font for Header Listing

'Get values for the incoming variables
OrgChoice = Request.QueryString("OrgChoice")
OrgType = Request.QueryString("OrgType")
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
	Conn.CommandTimeout = 2000
	Conn.Open DataSourceName, DBUSER, DBPWD
	
%>
<html>

<head>
	<meta http-equiv="Expires" content="0">
	<title>Organizations Report</title>
</head>

<body bgcolor="#F5EBDD" text="BLACK">
<%'Statline page header%>
	<table width="100%">
		<tr><%'Insert the Name of the Report and the selected filter to the header%>
			<td width="75"><img src="/loginstatline/images/logo1.gif" width="60" height="60"></td>
			<td width="*" valign="Left"><b><font size="5" face="Arial Black"><%=ReportName%></font><%
				SELECT CASE ReportID
				CASE "73"  'the Organization (by State) report
					If OrgChoice <> 0 Then
						vQuery = "SELECT StateName FROM State WHERE StateID = " & OrgChoice
						Set RS = Conn.Execute(vQuery)%>	
							<br><font size="4" face="Arial"><%=RS("StateName")%></td><%
						Set RS = Nothing
						Set vQuery = Nothing
					Else%>
						<br><font size="4" face="Arial">All States</td><%
					End If
				CASE "75"  'the Organization (by Source Code) report%>
						<br><font size="4" face="Arial"><%=OrgChoice%></td><%
				CASE "76"  'the Organization (by Report Group) report
					If OrgChoice <> 0 Then
						vQuery = "EXECUTE sps_WebReportGroupName " & OrgChoice
						Set RS = Conn.Execute(vQuery)%>	
							<br><font size="4" face="Arial"><%=RS("ReportGroupName")%></td><%
						Set RS = Nothing
						Set vQuery = Nothing
					Else%>
						<br><font size="4" face="Arial">All Report Groups</td><%
					End If
				END SELECT%>
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
SELECT CASE ReportID
	CASE "73"  'the Organization (by State) report
		vQuery = "EXECUTE sps_GetOrgStateList " & OrgChoice & "," & OrgType & ",'OrganizationTypeName'"
		Set RS = Conn.Execute(vQuery)
	CASE "75"  'the Organization (by Source Code) report
		vQuery = "EXECUTE sps_GetOrgSCList " & "'" & OrgChoice & "'," & OrgType
		Set RS = Conn.Execute(vQuery)
	CASE "76"  'the Organization (by Report Group) report
		vQuery = "EXECUTE sps_GetOrgRptGrpList " & OrgChoice & "," & OrgType
		Set RS = Conn.Execute(vQuery)
END SELECT

'Check for No Records
If RS.EOF Then 'If there are no organizations listed for the option selected.
	SELECT CASE ReportID
		CASE "73"  'the Organization (by State) report
			%><b><Font size="<%=FontSizeHead%>" face="<%=FontNameHead%>" color="Red">
			There are no Organizations listed for this State with the options specified.  Please try again.  
			If you continue to have difficulty please contact Statline at (888) 881-7828 for assistance.</font></b><%
		CASE "75"  'the Organization (by Source Code) report
			%><b><Font size="<%=FontSizeHead%>" face="<%=FontNameHead%>" color="Red">
			There are no Organizations listed for this Source Code with the options specified.  Please try again.  
			If you continue to have difficulty please contact Statline at (888) 881-7828 for assistance.</font></b><%
		CASE "76"  'the Organization (by Report Group) report
			%><b><Font size="<%=FontSizeHead%>" face="<%=FontNameHead%>" color="Red">
			There are no Organizations listed for this Report Group with the options specified.  Please try again.  
			If you continue to have difficulty please contact Statline at (888) 881-7828 for assistance.</font></b><%
	END SELECT
End If

'Display Data
Do While Not RS.EOF 
	'Loop is based on Organization Type.  This creates a block heading for each Organization Type and displays 
	'associated organizations in the list below it. This process repeats until the Recordset is displayed.
	
	TempOrgType = RS("OrganizationTypeName")
	Call HeaderRow(TempOrgType)

	Counter = 0%>


	<table width="662"><%'Organization Listing%>
		<%'Organizations associated with the listed Organization Type
		Do While Not RS.EOF And TempOrgType = RS("OrganizationTypeName")%>
				
		<tr>
			<td width="20"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=Counter+1%></td>
			<td width="239"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=RS("OrganizationName")%></td>
			<td width="68"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=RS("Phone")%></td>
			<td width="157"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=RS("OrganizationAddress1")%></td>
			<td width="78"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=RS("OrganizationCity")%></td>
			<td width="71"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=RS("CountyName")%></td>	
			<td width="29"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=RS("OrganizationZipCode")%></td>
		</tr>
		<%
		Counter = Counter + 1
		RS.MoveNext
		
		If RS.EOF Then
			Exit Do
		End If
		
		Loop 'Organization listing Loop%>
	</table>
<%

If RS.EOF Then
	Exit Do
End If

Loop 'Organization Type Loop

End If	'End of the AuthorizeMain If...Then statement (top of Section II).

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
Set OrgChoice	   = Nothing
Set OrgType		   = Nothing
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
Function HeaderRow(TempOrgType)
	'Block heading (Organization Type)%>
	<table width="662"><%'Organization Type%>
		<tr>
			<td width="662"><b><font size="<%=FontSizeHead%>" face="<%=FontNameData%>"><%=TempOrgType%></b></td>
		</tr>
	</table><%
	'Column Heading%>
	<table width="662"><%'Column Header%>
		<tr>
			<td width="20"><b><u><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>">#</u></b></td>
			<td width="239"><b><u><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>">Name</u></b></td>
			<td width="68"><b><u><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>">Phone</u></b></td>
			<td width="157"><b><u><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>">Address</u></b></td>
			<td width="78"><b><u><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>">City</u></b></td>
			<td width="71"><b><u><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>">County</u></b></td>
			<td width="29"><b><u><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>">Zip</u></b></td>
		</tr>
	</table><%
End Function 'HeaderRow

'****************************************************************************************************
'Section VI:  JavaScript Functions and Subs 
'****************************************************************************************************
%>

