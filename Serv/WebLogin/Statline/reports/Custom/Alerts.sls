<%Option Explicit%>
<!--Alerts.sls - created 3/6-3/8, 4/6 2000 by Daniel Reddy. Statline, LLC.-->
<%
'****************************************************************************************************
'File Name:		Alerts.sls								Created By:		Daniel Reddy  Statline, LLC.
'Date(s):		3/6-3/8 2000
'Description:	This is the Alerts Report.
'
'Changes:		4/6/2000 by Daniel Reddy.  Code Formatting changes and Constants declared as such.
'ccarroll 05/16/06 Modified for StatTrac 8.0 Alert field ntext datatype (RTF2HTML)
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
Dim AlertType			'The AlertTypeID for the desired Alert Type.
Dim Counter				'Counter for Each Record
Dim PageFirst			'Counter used in formatting the page for printing.
Dim PageNext			'Counter used in formatting the page for printing.
Dim pvStartDate			'Required for \includes\Authorize.sls to work.  Not used for anything else in this page.
Dim pvEndDate			'Required for \includes\Authorize.sls to work.  Not used for anything else in this page.

Dim TempMsg1			'Carries the conversion of Carriage Returns to HTML <BR> for variable AlertMessage1.
Dim TempMsg2			'Carries the conversion of Carriage Returns to HTML <BR> for variable AlertMessage2.
Dim TempScMsg			'Carries the conversion of Carriage Returns to HTML <BR> for variable AlertScheduleMessage.

'Constants
Const FontNameData = "Times New Roman"	'Name of Font for Data Listing
Const FontNameHead = "Arial"			'Name of Font for Header Listing
Const FontSizeData = "1"				'Size of Font for Data Listing
Const FontSizeHead = "2"				'Size of Font for Header Listing

Dim vReportTitle		'The ReportDisplayName of the calling report.  Used in all calling reports.
Dim vMainTitle
Dim vTitlePeriod
Dim vTitleTo
Dim vTitleTimes
Dim pvUserOrgID
Dim vSourceCodeName

'Get values for the incoming variables
AlertChoice = Request.QueryString("AlertChoice")
AlertType = Request.QueryString("AlertType")
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
      'RTF2HTML = strRTF
    Set objConverter = Nothing
End Function


If AuthorizeMain Then 
'Open Connection to the Database
	Set Conn = server.CreateObject("ADODB.Connection")

%>
<html>

<head>
	<meta http-equiv="Expires" content="0">
	<title>Organizations Report</title>
</head>

<body bgcolor="#F5EBDD" text="BLACK">


<%'Statline page header


	'Set Title Values		
	SELECT CASE AlertType
		CASE "0"
			vMainTitle = "All Alert Types "
		CASE "1"
			vMainTitle = "Referral Alerts "
		CASE "2"
			vMainTitle = "Message Alerts "
		CASE "4"
			vMainTitle = "Import Offer Alerts "
	END SELECT
	vMainTitle = vMainTitle & "for " & AlertChoice
	If AlertChoice = "All Source Codes" Then vSourceCodeName = "" Else vSourceCodeName = AlertChoice End IF
	vTitlePeriod = ""
	vTitleTo = ""
	vTitleTimes = ""	

%>

	<!--#include virtual="/loginstatline/reports/custom/Head_w_SourceCode.sls"-->

	<table width="662"><%'Add Red Line Separator%>
		<tr>
			<td width ="662"><img src="/loginstatline/images/redline.gif" width="652" height="2" align="left"></td>
		</tr>
	</table><p>
<%
'****************************************************************************************************
'Section III: Main Body of Page
'****************************************************************************************************
'Create Recordset
	vQuery = "EXECUTE sps_GetAlertList " & "'" & AlertChoice & "'," & AlertType 
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
PageNext = 0
	'Alert Listing

Do While Not RS.EOF%>		
	<table width="662">			
		<tr>
			<td width="20"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><b><%=Counter+1%></b></td>
			<td width="642"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><b><%=RS("AlertGroupName")%></b></td>
		</tr>
	</table>

	<table width="662">
	<tr>
	  <td><div class="alert1"><%=RTF2HTML(RS("AlertMessage1"))%></div></td>
	  <td><div class="alert1"><%=RTF2HTML(RS("AlertMessage2"))%></div></td>
	  <td><div class="alert1"><%=RTF2HTML(RS("AlertScheduleMessage"))%></div></td>
	</tr>
	</table>


	<%
	Counter = Counter + 1
	PageFirst = PageFirst + 1
	PageNext = PageNext +1
	'Formatting routine for Printing.  The first page can hold 4 alerts, all following hold 5.
	If PageFirst = 4 Then
		%><p> &nbsp
		  <p> &nbsp<%
		PageNext = 0
	Else
		If PageNext = 5 Then
			%><br> &nbsp <%
			PageNext = 0
		End If
	End If	'End of the formatting routine
	
	RS.MoveNext
		
	If RS.EOF Then
		Exit Do
	End If
		
	Loop

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
Set AlertType	   = Nothing
Set Conn		   = Nothing
Set Counter		   = Nothing
Set DataSourceName = Nothing
Set PageFirst	   = Nothing
Set PageNext	   = Nothing
Set pvStartDate    = Nothing
Set pvEndDate	   = Nothing
Set ReportID	   = Nothing
Set vReportTitle	   = Nothing
Set RS			   = Nothing
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

'****************************************************************************************************
'Section VI:  JavaScript Functions and Subs 
'****************************************************************************************************
%>
