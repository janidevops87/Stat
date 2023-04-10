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
Dim TempOrgType			'Temporary Variable used in Organization Type Do...While loop.

Dim vReportTitle		'The ReportDisplayName of the calling report.  Used in all calling reports.
Dim vMainTitle
Dim vTitlePeriod
Dim vTitleTo
Dim vTitleTimes
Dim pvUserOrgID
Dim vSourceCodeName

'Constants
Const FontNameData = "Times New Roman"	'Name of Font for Data Listing
Const FontNameHead = "Arial"			'Name of Font for Header Listing
Const FontSizeData = "1"				'Size of Font for Data Listing
Const FontSizeHead = "2"				'Size of Font for Header Listing

'Get values for the incoming variables
AsgChoice = Request.QueryString("AsgChoice")
ReportID = Request.QueryString("ReportID")
vReportTitle = Request.QueryString("ReportName")
UserID = Request.QueryString("UserID")
UserOrgID = Request.QueryString("UserOrgID")
pvUserOrgID = UserOrgID
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
	Conn.Open DataSourceName, "sa", "kuvasz"
%>
<html>

<head>
	<meta http-equiv="Expires" content="0">
	<title>Assignments Report</title>
</head>

<body bgcolor="#F5EBDD" text="BLACK">
<%'Statline page header
	'Set Title Values	
	SELECT CASE ReportID
		CASE "86"  'the Assignments (by State) report
				vQuery = "SELECT StateName FROM State WHERE StateID = " & AsgChoice
				Set RS = Conn.Execute(vQuery)	
					vMainTitle = RS("StateName")
				Set RS = Nothing
				Set vQuery = Nothing
		CASE "87"  'the Assignments (by Source Code) report
				vQuery = "SELECT SourceCodeName FROM SourceCode WHERE SourceCodeID = " &AsgChoice
				Set RS = Conn.Execute(vQuery)
					vMainTitle = RS("SourceCodeName")
					vSourceCodeName = RS("SourceCodeName")
				Set RS = Nothing
				Set vQuery = Nothing
	END SELECT	
	vTitlePeriod = ""
	vTitleTo = ""
	vTitleTimes = ""
	
%>
	<!--#include virtual="/loginstatline/reports/custom/Head_w_SourceCode.sls"-->

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
	CASE "86"  'the Assignments (by State) report
		vQuery = "EXECUTE sps2_FacilityAssignments " & AsgChoice
		'Response.Write vQuery
		Set RS = Conn.Execute(vQuery)
	CASE "87"  'the Assignments (by Source Code) report
		Server.ScriptTimeout = 5000
		vQuery = "EXECUTE sps2_FacilityAssignmentsSC " & AsgChoice
		Set RS = Conn.Execute(vQuery)
END SELECT
'Check for No Records
If RS.EOF Then 'If there are no organizations listed for the option selected.
	SELECT CASE ReportID
		CASE "86"  'the Assignments (by State) report
			%><b><Font size="<%=FontSizeHead%>" face="<%=FontNameHead%>" color="Red">
			There are no Organizations listed for this State with the options specified.  Please try again.  
			If you continue to have difficulty please contact Statline at (888) 881-7828 for assistance.</font></b><%
		CASE "87"  'the Assignments (by Source Code) report
			%><b><Font size="<%=FontSizeHead%>" face="<%=FontNameHead%>" color="Red">
			There are no Organizations listed for this Source Code with the options specified.  Please try again.  
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


	<table border=0 width="662"><%'Organization Listing%>
		<%'Organizations associated with the listed Organization Type
		Do While Not RS.EOF And TempOrgType = RS("OrganizationTypeName")%>
				
		<tr>
			<td width="20"  valign="Top"><font size="<%=FontSizeHead%>" face="<%=FontNameData%>"><%=Counter+1%></td>
			<td width="435" valign="Top"><font size="<%=FontSizeHead%>" face="<%=FontNameData%>"><%=RS("OrganizationName")%><br><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=RS("Phone")%> &nbsp &nbsp &nbsp <%=RS("OrganizationAddress1")%> <%=RS("OrganizationAddress2")%> &nbsp <%=RS("OrganizationCity")%>, <%=RS("StateAbbrv")%> &nbsp <%=RS("OrganizationZipCode")%> &nbsp &nbsp <%=RS("CountyName")%> County</td>
			<td width="70"  valign="Top"><font size="<%=FontSizeHead%>" face="<%=FontNameData%>"><%=RS("OrganAssigned")%></td>
			<td width="70"  valign="Top"><font size="<%=FontSizeHead%>" face="<%=FontNameData%>"><%=RS("TissueAssigned")%></td>
			<td width="70"  valign="Top"><font size="<%=FontSizeHead%>" face="<%=FontNameData%>"><%=RS("EyesAssigned")%></td>
		</tr>
		<tr>
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
Set AsgChoice	   = Nothing
Set ReportID	   = Nothing
Set vReportTitle	   = Nothing
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

	'Column Heading%>
	<table width="662"><%'Column Header%>
		<tr>
			<td width="20"><b><u><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>">#</u></b></td>
			<td width="435"><b><u><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><%=TempOrgType%></u></b></td>
			<td width="70"><b><u><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>">Organ</u></b></td>
			<td width="70"><b><u><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>">Tissue</u></b></td>
			<td width="70"><b><u><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>">Eyes</u></b></td>						
		</tr>
	</table><%
End Function 'HeaderRow

'****************************************************************************************************
'Section VI:  JavaScript Functions and Subs 
'****************************************************************************************************
%>
