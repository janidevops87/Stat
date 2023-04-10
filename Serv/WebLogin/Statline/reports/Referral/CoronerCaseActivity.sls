<%
'	Updated 07.1100	ttw	Openned report access for Coroner Activity Report to all
'						clients

Option Explicit

'Declare variables
Dim pvStartDate
Dim pvEndDate
Dim vErrorMsg
Dim ErrorReturn
Dim pvUserOrgID
Dim pvReportGroupID
Dim pvOrgID
Dim pvOrderBy
Dim pvReferralTypeID

'Dim vReportTitle
'Dim vMainTitle

Dim vTZ
Dim i
Dim ReferralCoronerPhone 'AlertGroupName

Dim FontNameHead
Dim FontSizeHead
Dim FontNameData
Dim FontSizeData
Dim FontNameHeadLog
Dim FontSizeHeadLog
Dim FontSizeDataLog
Dim FontNameDataLog

Dim vReportTitle
Dim vMainTitle
Dim vTitlePeriod
Dim vTitleTo
Dim vTitleTimes

'Declare format vaiables
FontNameHead = "Arial"
FontSizeHead = "2"
FontNameData = "Times New Roman"
FontSizeData = "2"
FontNameHeadLog = "Arial"
FontSizeHeadLog = "1.5"
FontNameDataLog = "Times New Roman"
FontSizeDataLog = "1.5"
vMainTitle = "Coroner Case Activity"
%>

<html>

<head>
<meta http-equiv="Expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<title>Coroner Case Activity</title>
</head>

<body bgcolor="#F5EBDD">
<!--#include virtual="/loginstatline/includes/Authorize.sls"-->
<!--#include virtual="/loginstatline/includes/TimeZoneProcess.vbs"-->
<!--#include virtual="/loginstatline/includes/StatUtility.js"-->
<%

'Execute the main page generating routine
If AuthorizeMain Then

	'Create a connection object
	Set Conn = server.CreateObject("ADODB.Connection")
	Conn.Open DataSourceName, DBUSER, DBPWD
	
	'Get the query variables
	Call FixQueryString(Request.QueryString("StartDate"), pvStartDate)
	Call FixQueryString(Request.QueryString("EndDate"), pvEndDate)
	pvUserOrgID = FormatNumber(Request.QueryString("UserOrgID"),0,,0,0)
	pvReportGroupID = FormatNumber(Request.QueryString("ReportGroupID"),0,,0,0)
	pvOrgID = FormatNumber(Request.QueryString("OrgID"),0,,0,0)
	pvReferralTypeID = FormatNumber(Request.QueryString("ReferralType"),0,,0,0)	
	pvOrderBy = Request.QueryString("OrderBy")
	
	vTitlePeriod = FormatDateTime(pvStartDate, vbShortDate) & " " & FormatDateTime(pvStartDate, vbShortTime)
	vTitleTo = FormatDateTime(pvEndDate, vbShortDate) & " " & FormatDateTime(pvEndDate, vbShortTime)
	vTitleTimes = "All Times " & ZoneName(vTZ)						
	If ExecuteMain Then
	%>
		<!-- Print the header. -->
		<!--#include virtual="/loginstatline/reports/referral/Head_w_ReportGroup.sls"-->
					
		<!-- Get the counts of each alert group and referral type. -->
		<!--#include virtual="/loginstatline/reports/referral/CoronerCaseActivitySection.sls"-->
	<%
	Else
	%>
		No Data Available
	<%					
	End If

End If

Set RS = Nothing
Set Conn = Nothing

%>

<hr align="CENTER" color="#000000" noshade size="1" width="100%"></hr>
</body>
</html>
<!--#include virtual="/loginstatline/includes/copyright.shm"-->

<%
Function ExecuteMain()
	If pvOrderBy = "" Or pvOrderBy = "0" Then
		pvOrderBy = "Referral.ReferralTypeID, OrganizationName, CallDateTime"
		
	END IF
	If Right(pvOrderBy,1) = "," Then
		pvOrderBy = Mid(pvOrderBy, 1, Len(pvOrderBy) - 1)
	End If

	'Verify the requesting organization if it not Statline
	If pvUserOrgID <> 194 then
		'run query to verify ReportGroup access
		vQuery = "sps_OrganizationName " & pvUserOrgID
		Set RS = Conn.Execute(vQuery)
		
		If RS.EOF = True Then
			'Access denied - display
			vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
			vErrorMsg = vErrorMsg & "The organization attempting to run this report does not exist. <BR> <BR>"
			vErrorMsg = vErrorMsg & "If you continue to have difficulty, <BR>"
			vErrorMsg = vErrorMsg & "Please contact Statline at (888) 881-7828 for assistance.</B> <BR> <BR> <BR>"
			vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
			vErrorMsg = vErrorMsg & "Error:     (100, GetOrganization, Activity.sls) <BR> <BR>"
			vErrorMsg = vErrorMsg & "</FONT></FONT>"
			Response.Write(vErrorMsg)
			ExecuteMain = False
			Exit Function	
		End If
		
		Set RS = Nothing

	End If

	If pvReportGroupID <> 0 Then
		
		'If a report group has been selected, get the report group name
		'and set the report title to the name of the report group
		vQuery = "sps_ReportGroupName " & pvReportGroupID & " "
		Set RS = Conn.Execute(vQuery)
		
		If RS.EOF = True Then
			vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
			vErrorMsg = vErrorMsg & "The selected report group is no longer valid. Please select another group.<BR> <BR>"
			vErrorMsg = vErrorMsg & "If you continue to have difficulty, <BR>"
			vErrorMsg = vErrorMsg & "Please contact Statline at (888) 881-7828 for assistance. </B> <BR> <BR> <BR>"
			vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
			vErrorMsg = vErrorMsg & "Error:     (100, GetReportGroupName, Activity.sls) <BR> <BR>"
			vErrorMsg = vErrorMsg & "</FONT></FONT>"
			Response.Write(vErrorMsg)
			Response.Write(vErrorMsg)
			ExecuteMain = False
			Exit Function			
		Else
			vReportTitle = RS("WebReportGroupName")	
		End If
		
		Set RS = Nothing

	ElseIf pvReportGroupID = 0 Then

		vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
		vErrorMsg = vErrorMsg & "Either a report group or an organization must be selected. <BR> <BR>"
		vErrorMsg = vErrorMsg & "If you continue to have difficulty, <BR>"
		vErrorMsg = vErrorMsg & "Please contact Statline at (888) 881-7828 for assistance.</B> <BR> <BR> <BR>"
		vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
		vErrorMsg = vErrorMsg & "Error:     (-1, Activity.sls) <BR> <BR>"
		vErrorMsg = vErrorMsg & "</FONT></FONT>"
		Response.Write(vErrorMsg)
		ExecuteMain = False
		Exit Function

	Else

		vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
		vErrorMsg = vErrorMsg & "Unexpected Error. <BR> "
		vErrorMsg = vErrorMsg & "Please click refresh to try your request again. <BR> <BR>"
		vErrorMsg = vErrorMsg & "If the problem continues, <BR>"
		vErrorMsg = vErrorMsg & "please contact Statline at (888) 881-7828 for assistance.</B> <BR> <BR> <BR>"
		vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
		vErrorMsg = vErrorMsg & "Error:     (-1, Unexpected, Activity.sls) <BR> <BR>"
		vErrorMsg = vErrorMsg & "</FONT></FONT>"
		Response.Write(vErrorMsg)
		ExecuteMain = False
		Exit Function

	End if

	vQuery = "sps_OrganizationTimeZone " & pvUserOrgID & " "
	Set RS = Conn.Execute(vQuery)
	vTZ = RS("OrganizationTimeZone")
	Set RS = Nothing
	
	
	'Get data rows
	vQuery = "sps_CoronerCaseActivity " & pvReportGroupID & ", '" & pvStartDate &"', " & "'" & pvEndDate &"', " &  pvOrgID & ", " & vTZ &", " & pvReferralTypeID &", " & "'" & pvOrderBy &"', " & pvUserOrgID 
	'Response.Write vQuery
	Set RS = Conn.Execute(vQuery)

	If RS.EOF = True Then
		ExecuteMain = False
	Else
		ExecuteMain = True
	End If
	
End Function


Sub FixQueryString(pvIn, pvOut)
	Dim x
	pvOut = ""
	For x=1 TO Len(pvIn)
		If Mid(pvIn,x,1) = "_" Then
			pvOut = pvOut & " "
		Else
			pvOut = pvOut & Mid(pvIn,x,1)
		End If
	Next
End Sub
%>
