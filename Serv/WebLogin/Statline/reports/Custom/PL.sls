<%Option Explicit%>
<!--PL.sls - created 3/9, 3/13-3/15, 4/6 2000 by Daniel Reddy. Statline, LLC.-->
<%
'****************************************************************************************************
'File Name:		PL.sls									Created By:		Daniel Reddy  Statline, LLC.
'Date(s):		3/9, 3/13-3/15 2000
'Description:	This is the Personnel Listing Report.
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
Dim OrderBy				'Sort Order decided by user. 
Dim PhoneCount			'Set for Do...While Loop to concatenate Phone Listing with the Person
Dim Organization		'Organization from which the personnel list is drawn.
Dim pvStartDate			'Required for \includes\Authorize.sls to work.  Not used for anything else in this page.
Dim pvEndDate			'Required for \includes\Authorize.sls to work.  Not used for anything else in this page.
Dim ReportName			'The ReportDisplayName of the calling report.  Used in all calling reports.
Dim TempName			'Set for Do...While Loop to concatenate Phone Listing with the Person
Dim TempNotes			'Set for Do...While Loop to concatenate Phone Listing with the Person and allows Carriage Returns and Tabs to be recognized.
Dim	TempPhone			'Set for Do...While Loop to concatenate Phone Listing with the Person
Dim TempTitle			'Set for Do...While Loop to concatenate Phone Listing with the Person

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
OrderBy = Request.QueryString("OrderBy")
Organization = Request.QueryString("Organization")
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
'Get OrganizationName
	vQuery = "SELECT OrganizationName FROM Organization WHERE OrganizationID = " & Organization
	Set RS = Conn.Execute(vQuery)
%>
<html>

<head>
	<meta http-equiv="Expires" content="0">
	<title>Personnel Listing Report</title>
</head>

<body bgcolor="#F5EBDD" text="BLACK">
<%'Statline page header%>
	<table width="100%">
		<tr><%'Insert the Name of the Report and the selected filter to the header%>
			<td width="75"><img src="/loginstatline/images/logo1.gif" width="60" height="60"></td>
			<td width="*" valign="Left"><b><font size="5" face="Arial Black"><%=ReportName%></font>
				<br><font size="4" face="Arial"><%=RS("OrganizationName")%></td>
		</tr>
	</table><p>
	<table width="662"><%'Add Red Line Separator%>
		<tr>
			<td width ="662"><img src="/loginstatline/images/redline.gif" width="652" height="2" align="left"></td>
		</tr>
	</table><% 	
	
	Set RS = Nothing
	Set vQuery = Nothing
'****************************************************************************************************
'Section III: Main Body of Page
'****************************************************************************************************
'Create Recordset
vQuery = "EXECUTE sps_GetPL " & OrderBy & "," & Organization
Set RS = Conn.Execute(vQuery)

'Check for No Records
If RS.EOF Then 'If there are no personnel listed for the organization.
	%><b><Font size="<%=FontSizeHead%>" face="<%=FontNameHead%>" color="Red">
		There are no personnel listed for this organization. Please try again. 
		If you continue to have difficulty please contact Statline at (888) 881-7828 for assistance.</font></b><%
End If

'Display Data
If RS.EOF Then
	%> &nbsp <%
Else%>
<table width="662"><%'Column Header%>
	<tr>
		<td width="16" valign="center" align="center"><b><u><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>">#</u></b></td>
		<td width="146" valign="center"><b><u><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>">Name</u></b></td>
		<td width="160" valign="center"><b><u><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>">Title</u></b></td>
		<td width="144" valign="center"><b><u><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>">Phone</u></b></td>
		<td width="196" valign="center"><b><u><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>">Notes</u></b></td>
	</tr>
</table><%
End If 'Header

Counter = 0
	
Do While Not RS.EOF%>

<table width="662"><%'Person Listing
	'Declare Variables for Phone Loop
		PhoneCount = 0
		TempName = RS("Person")
		TempTitle = RS("PersonTypeName")
		TempPhone = RS("Phone") & " &nbsp " & RS("PhoneTypeName")
		TempNotes = RS("PersonNotes")
	'Add Carriage Returns and Tabs to Notes
		TempNotes = Replace(TempNotes, Chr(09), " &nbsp &nbsp &nbsp &nbsp &nbsp ", 1)
		TempNotes = Replace(TempNotes, Chr(10), "<BR>", 1)%>
		
	<tr>
		<td width="16" valign="top"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=Counter+1%></td>
		<td width="146" valign="top"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=TempName%></td>
		<td width="160" valign="top"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=TempTitle%></td><%
			Do While Not RS.EOF
				If TempName = RS("Person") Then
					If PhoneCount = 0 Then
						TempPhone = TempPhone 
					Else
						TempPhone = TempPhone & " <br> " & RS("Phone") & " &nbsp " & RS("PhoneTypeName")
					End If
				Else
					Exit Do
				End If
				If RS.EOF Then
					Exit Do
				End If
				PhoneCount = PhoneCount + 1
				RS.MoveNext
			Loop %>
		<td width="144" valign="top"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=TempPhone%></td>			
		<td width="196" valign="top"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=TempNotes%></td>	
	</tr><br>
		<%

		Counter = Counter + 1
		
		If RS.EOF Then
			Exit Do
		End If
		
Loop 'Person listing Loop%>
	</table> 

<%

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
Set PhoneCount	   = Nothing
Set pvStartDate    = Nothing
Set pvEndDate	   = Nothing
Set OrderBy		   = Nothing
Set Organization   = Nothing
Set ReportID	   = Nothing
Set ReportName	   = Nothing
Set RS			   = Nothing
Set TempName	   = Nothing
Set TempNotes	   = Nothing
Set TempPhone	   = Nothing
Set TempTitle	   = Nothing
Set UserID		   = Nothing
Set UserOrgID	   = Nothing
Set vQuery		   = Nothing
%>
<%
'****************************************************************************************************
'Section V:  VBScript Functions and Subs 
'****************************************************************************************************

'****************************************************************************************************
'Section VI:  JavaScript Functions and Subs 
'****************************************************************************************************
%>
