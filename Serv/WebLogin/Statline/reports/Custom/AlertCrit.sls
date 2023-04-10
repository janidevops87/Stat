<%Option Explicit%>
<!--AlertCrit.sls - created 4/18, 4/20-4/21 2000 by Daniel Reddy. Statline, LLC.-->
<%
'****************************************************************************************************
'File Name:		AlertCrit.sls							Created By:		Daniel Reddy  Statline, LLC.
'Date(s):		4/18, 4/20-4/21 2000
'Description:	This is the Alert Criteria Report.
'
'Changes: ccarroll 05/16/06 Modified for StatTrac 8.0 Alert field ntext datatype (RTF2HTML)
' Uses stattrac.css for scrollable alerts
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
Dim AlertChoice			'Variable Containing the desired filter for the report in question.
Dim Counter				'Counter for Each Record
Dim PageFirst			'Counter used in formatting the page for printing.
Dim pvStartDate			'Required for \includes\Authorize.sls to work.  Not used for anything else in this page.
Dim pvEndDate			'Required for \includes\Authorize.sls to work.  Not used for anything else in this page.

Dim TempAlert			'Used in the Organization Loop.
Dim TempMsg1			'Carries the conversion of Carriage Returns to HTML <BR> for variable AlertMessage1.
Dim TempMsg2			'Carries the conversion of Carriage Returns to HTML <BR> for variable AlertMessage2.
Dim TempScMsg			'Carries the conversion of Carriage Returns to HTML <BR> for variable AlertScheduleMessage.

Dim vReportTitle		'The ReportDisplayName of the calling report.  Used in all calling reports.
Dim vMainTitle
Dim vTitlePeriod
Dim vTitleTo
Dim vTitleTimes
Dim vSourceCodeName
Dim pvUserOrgID

'Constants
Const FontNameData = "Times New Roman"	'Name of Font for Data Listing
Const FontNameHead = "Arial"			'Name of Font for Header Listing
Const FontSizeData = "1"				'Size of Font for Data Listing
Const FontSizeHead = "2"				'Size of Font for Header Listing

'Get values for the incoming variables
AlertChoice = Request.QueryString("AlertChoice")
ReportID = Request.QueryString("ReportID")
vReportTitle = Request.QueryString("ReportName")
UserID = Request.QueryString("UserID")
UserOrgID = Request.QueryString("UserOrgID")

pvUserOrgID = UserOrgID
'Includes for this page:
%>
<!--#include virtual="/loginstatline/includes/Authorize.sls"-->
<LINK href="stattrac.css" rel="stylesheet" type="text/css">
<%
'****************************************************************************************************
'Section II:  HTML and Page Header
'****************************************************************************************************

Function RTF2HTML(strRTF)
' Function to convert RTF to HTML - StatTrac 8.0 Design Document (4.1.4.2.3)
' 04/18/2006, ccarroll 
  
  Dim objConverter
  On Error Resume Next

    Set objConverter = server.CreateObject("EasyByte_RTF2HTML_Dll.Convert")

      RTF2HTML = objConverter.ConvertNoBody((strRTF),"","","EasyByteRTF2HTML","NO","NO","NO","","","NO","image")

    Set objConverter = Nothing
End Function




If AuthorizeMain Then
'Open Connection to the Database
	Set Conn = server.CreateObject("ADODB.Connection")
	Conn.Open DataSourceName, DBUSER, DBPWD
%>
<html>

<head>
	<meta http-equiv="Expires" content="0">
	<title>Alert Criteria Report</title>
	<style type="text/css">
		P.breakhere {page-break-after: always}
	</style>
</head>

<body bgcolor="#F5EBDD" text="BLACK">

<%
	'Statline page header

	vQuery = "SELECT SourceCodeName FROM SourceCode WHERE SourceCodeID = " & AlertChoice
	Set RS = Conn.Execute(vQuery)
	vSourceCodeName = RS("SourceCodeName")
	Set RS = Nothing
	Set vQuery = Nothing

	'Set Title Values		
	vMainTitle = vSourceCodeName
	vTitlePeriod = ""
	vTitleTo = ""
	vTitleTimes = ""	

%>
	<!--#include virtual="/loginstatline/reports/Custom/Head_w_SourceCode.sls"-->

	<table width="662"><%'Add Red Line Separator%>
		<tr>
			<td width ="662"><img src="/loginstatline/images/redline.gif" width="652" height="2" align="left"></td>
		</tr>
	</table><p></p>
<%
'****************************************************************************************************
'Section III: Main Body of Page
'****************************************************************************************************
'Create Recordset
	vQuery = "EXECUTE sps_FacilityAssignments2SC " & AlertChoice
	'Conn.Timeout = 360
	Server.ScriptTimeout = 5000 ' 5 minutes

	Conn.CommandTimeout = 9000

	Set RS = Conn.Execute(vQuery)

'Check for No Records
If RS.EOF Then 'If there are no alerts listed for the option selected.
	%><b><Font size="<%=FontSizeHead%>" face="<%=FontNameHead%>" color="Red">
	There are no Alerts listed for this Source Code with the options specified.  Please try again.
	If you continue to have difficulty please contact Statline at (888) 881-7828 for assistance.</font></b><%
End If

'Display results
Counter = 0
PageFirst = 0

'Display Data
Do While Not RS.EOF
	'Loop is based on AlertGroupName.  This creates a block heading for each AlertGroup and displays
	'associated organizations in the list below it. This process repeats until the Recordset is displayed.

	TempAlert = RS("AlertGroupName")

	'Alert Listing

	'Changes: ccarroll 05/16/06 Modified for StatTrac 8.0 Alert field ntext datatype (RTF2HTML)
	' Uses stattrac.css (class=alert1) for scrollable alerts	
	%>
	<P class = "breakhere">
	<table width="662">
		<tr>
			<td width="662"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><b><%=RS("AlertGroupName")%></b></td>
		</tr>
	</table>
	<table width="662">
	<tr>
	  <td><div class="alert1"><%=RTF2HTML(RS("AlertMessage1"))%></div></td>
	  <td><div class="alert1"><%=RTF2HTML(RS("AlertMessage2"))%></div></td>
	  <td><div class="alert1"><%=RTF2HTML(RS("AlertScheduleMessage"))%></div></td>
	</tr>
	</table>

	<%'Header Row
	Call HeaderRow()
%><table width ="662"><%
	'Organization List
		Do While Not RS.EOF And TempAlert = RS("AlertGroupName")%>

			<tr>
				<td width="15"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=Counter+1%></td>
				<td width="272"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=RS("OrganizationName")%></td>
				<td width="5"><font size="<%=FontSizeData%>" face="<%=FontNameData%>">M</td>
				<td width="60"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><center><%=RS("OMLA")%><%=RS("OMLAU")%>-<%=RS("OMUA")%><%=RS("OMUAU")%></center></td>
				<td width="60"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><center><%=RS("BMLA")%><%=RS("BMLAU")%>-<%=RS("BMUA")%><%=RS("BMUAU")%></center></td>
				<td width="60"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><center><%=RS("TMLA")%><%=RS("TMLAU")%>-<%=RS("TMUA")%><%=RS("TMUAU")%></center></td>
				<td width="60"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><center><%=RS("SMLA")%><%=RS("SMLAU")%>-<%=RS("SMUA")%><%=RS("SMUAU")%></center></td>
				<td width="60"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><center><%=RS("VMLA")%><%=RS("VMLAU")%>-<%=RS("VMUA")%><%=RS("VMUAU")%></center></td>
				<td width="60"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><center><%=RS("EMLA")%><%=RS("EMLAU")%>-<%=RS("EMUA")%><%=RS("EMUAU")%></center></td>
			</tr>
			<tr>
				<td width="15"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"> &nbsp </td>
				<td width="272"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=RS("OrganizationCity")%></td>
				<td width="5"><font size="<%=FontSizeData%>" face="<%=FontNameData%>">F</td>
				<td width="60"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><center><%=RS("OFLA")%><%=RS("OFLAU")%>-<%=RS("OFUA")%><%=RS("OFUAU")%></center></td>
				<td width="60"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><center><%=RS("BFLA")%><%=RS("BFLAU")%>-<%=RS("BFUA")%><%=RS("BFUAU")%></center></td>
				<td width="60"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><center><%=RS("TFLA")%><%=RS("TFLAU")%>-<%=RS("TFUA")%><%=RS("TFUAU")%></center></td>
				<td width="60"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><center><%=RS("SFLA")%><%=RS("SFLAU")%>-<%=RS("SFUA")%><%=RS("SFUAU")%></center></td>
				<td width="60"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><center><%=RS("VFLA")%><%=RS("VFLAU")%>-<%=RS("VFUA")%><%=RS("VFUAU")%></center></td>
				<td width="60"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><center><%=RS("EFLA")%><%=RS("EFLAU")%>-<%=RS("EFUA")%><%=RS("EFUAU")%></center></td>
			</tr>
			<tr>
				<td width="15"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"> &nbsp </td>
				<td width="272"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"> &nbsp </td>
				<td width="5"><font size="<%=FontSizeData%>" face="<%=FontNameData%>">SG</td>
				<td width="60"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><center><%=RS("OrganSchedule")%></center></td>
				<td width="60"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><center><%=RS("BoneSchedule")%></center></td>
				<td width="60"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><center><%=RS("TissueSchedule")%></center></td>
				<td width="60"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><center><%=RS("SkinSchedule")%></center></td>
				<td width="60"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><center><%=RS("ValvesSchedule")%></center></td>
				<td width="60"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><center><%=RS("EyesSchedule")%></center></td>
			</tr><%
		Counter = Counter + 1
		RS.MoveNext

		If RS.EOF Then
			Exit Do
		End If

		Loop 'Organization List Do While Loop%>

		</table><%
	Counter = 0

	If RS.EOF Then
		Exit Do
	End If

	Loop  'Display Data Do While Loop

End If	'End of the AuthorizeMain If...Then statement (top of Section II).

'****************************************************************************************************
'Section IV:  End of Page
'****************************************************************************************************
%>
</body>

</html>
<!--#include virtual="/loginstatline/includes/copyright.shm"-->
<%'Clear Open Variables
Set AlertChoice	   = Nothing
Set Conn		   = Nothing
Set Counter		   = Nothing
Set DataSourceName = Nothing
Set PageFirst	   = Nothing
Set pvStartDate    = Nothing
Set pvEndDate	   = Nothing
Set ReportID	   = Nothing
Set vReportTitle	   = Nothing
Set RS			   = Nothing
Set TempAlert	   = Nothing
Set TempMsg1	   = Nothing
Set TempMsg2	   = Nothing
Set TempScMsg	   = Nothing
Set UserID		   = Nothing
Set UserOrgID	   = Nothing
Set vQuery		   = Nothing
%>
<%
'****************************************************************************************************
'Section V:  VBScript Functions and Subs
'****************************************************************************************************

Function HeaderRow()
	'Column Heading%>
	<table width="662"><%'Column Header%>
		<tr>
			<td width="15"><b><u><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>">#</u></b></td>
			<td width="272"><b><u><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>">Name</u></b></td>
			<td width="5"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"> &nbsp </u></b></td>
			<td width="60"><b><u><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><center>Organ</center></td>
			<td width="60"><b><u><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><center>Bone</center></u></b></td>
			<td width="60"><b><u><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><center>Tissue</center></u></b></td>
			<td width="60"><b><u><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><center>Skin</center></u></b></td>
			<td width="60"><b><u><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><center>Valves</center></u></b></td>
			<td width="60"><b><u><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><center>Eyes</center></u></b></td>
		</tr>
	</table><%
End Function 'HeaderRow

'****************************************************************************************************
'Section VI:  JavaScript Functions and Subs
'****************************************************************************************************
%>
