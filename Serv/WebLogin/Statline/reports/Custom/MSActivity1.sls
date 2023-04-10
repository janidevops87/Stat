<%
Option Explicit

'Declare variables
Dim ErrorReturn
Dim pvStartDate
Dim pvEndDate
Dim DateTime
Dim vErrorMsg
Dim vOrgList
Dim pvUserOrgID
Dim pvOrgID
Dim pvReportGroupID
Dim pvReferralTypeID
Dim pvCallID
Dim vReportGroupName
Dim pvOrderBy
Dim pvOptions

Dim pvNoName
Dim pvShowSection1
Dim Identify
Dim Referral
Dim vTZ
Dim i
Dim ResultArray
Dim TypeName
Dim vNoRecords
Dim CountCheck
Dim ErrorCatch

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
%>

<html>

<head>
<meta http-equiv="Expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<title>Oklahoma Referral Activity</title>
</head>

<body bgcolor="#F5EBDD">

<!--#include virtual="/loginstatline/includes/Authorize.sls"-->
<!--#include virtual="/loginstatline/includes/CountWarning.vbs"-->
<!--#include virtual="/loginstatline/includes/VerifyRefType.vbs"-->
<!--#include virtual="/loginstatline/includes/TimeZoneProcess.vbs"-->
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
	pvOrgID = FormatNumber(Request.QueryString("OrgID"),0,,0,0)
	pvReportGroupID = FormatNumber(Request.QueryString("ReportGroupID"),0,,0,0)
	pvReferralTypeID = FormatNumber(Request.QueryString("ReferralType"),0,,0,0)
	pvCallID = FormatNumber(Request.QueryString("CallID"),0,,0,0)
	pvOrderBy = Request.QueryString("OrderBy")
	pvOptions = Request.QueryString("Options")
	CountCheck = Request.QueryString("CountCheck")

	'Call the referral type verification routine
	If VerifyReferralTypeAccess(True) Then

		'If the count check has not been set or should be explicitly
		'checked, the add the function and check count
		If CountCheck = "" Or CountCheck = "True" Then

			'Check the referral count. If the count exceeds the limit,
			'set CountCheck to "True" so the warning is displayed
			'and Execute Main is not called. If the count is not exceeded,
			'set CountCheck to "False" so ExecuteMain is called.
			Call CountWarning(2000)

		End If

		'CountCheck = "False"

		If CountCheck = "False" Then

			If ExecuteMain Then
			
				'Set Title Values		
				vMainTitle = "Referral Activity"
				vTitlePeriod = FormatDateTime(pvStartDate, vbShortDate) & " " & FormatDateTime(pvStartDate, vbShortTime)
				vTitleTo = FormatDateTime(pvEndDate, vbShortDate) & " " & FormatDateTime(pvEndDate, vbShortTime)
				vTitleTimes = "All Times " & ZoneName(vTZ)						
			%>

				<!-- Print the header. -->
				<!--#include virtual="/loginstatline/reports/custom/Head_w_ReportGroup.sls"-->

				<!-- Get the counts of each referral type. -->
				<%If pvShowSection1 Then%>
					<!--#include virtual="/loginstatline/reports/custom/MSActivitySection1_1.sls"-->
				<%
				End If

				If Not vNoRecords Then
				%>
					<!-- Get each referral record from the data list and format. -->
					<!--#include virtual="/loginstatline/reports/custom/MSActivitySection2_1.sls"-->
				<%
				End If

			End If

		End If

	End If

End If

Set Conn = Nothing
%>

<hr align="CENTER" color="#000000" noshade size="1" width="100%"></hr>
</body>
</html>
<!--#include virtual="/loginstatline/includes/copyright.shm"-->

<%
Function ExecuteMain()


	'Parse the option settings
	If pvOptions = "" Then
		pvOptions = 0
	End If

	pvNoName = Mid(pvOptions, 1, 1)

	'Set Order By
	'remove FixOrderBy function, not needed with sp that uses dynamic query string
	'IF InStr(1,pvOrderBy, "Referral.") > 0 THEN
	'	pvOrderBy = FixOrderBY(pvOrderBy)
	'END IF
	If pvOrderBy = "" Or pvOrderBy = "0" Then
		pvOrderBy = "Referral.ReferralTypeID, Organization.OrganizationName, Call.CallDateTime"
		pvShowSection1 = True
	Else
		If Left(pvOrderBy, 23) = "Referral.ReferralTypeID" Then
			pvShowSection1 = True
		Else
			pvShowSection1 = False
		End If
	End If

	If Right(pvOrderBy,1) = "," Then
		pvOrderBy = Mid(pvOrderBy, 1, Len(pvOrderBy) - 1)
	End If




	'Verify the requesting organization if it not Statline
	If pvUserOrgID <> 194 then

		vQuery = "sps_OrganizationName " & pvUserOrgID
		Set RS = Conn.Execute(vQuery)

		If RS.EOF = True Then
			vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
			vErrorMsg = vErrorMsg & "The organization attempting to run this report does not exist. <BR> <BR>"
			vErrorMsg = vErrorMsg & "If you continue to have difficulty, <BR>"
			vErrorMsg = vErrorMsg & "Please contact Statline at (888) 881-7828 for assistance.</B> <BR> <BR> <BR>"
			vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
			vErrorMsg = vErrorMsg & "Error:     (100, GetOrganization, MSActivity.sls) <BR> <BR>"
			vErrorMsg = vErrorMsg & "</FONT></FONT>"
			Response.Write(vErrorMsg)
			ExecuteMain = False
			Exit Function
		End If

		Set RS = Nothing

	End If

	If pvReportGroupID <> 0 AND pvOrgID = 0 Then

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
			vErrorMsg = vErrorMsg & "Error:     (100, GetReportGroupName, MSActivity.sls) <BR> <BR>"
			vErrorMsg = vErrorMsg & "</FONT></FONT>"
			Response.Write(vErrorMsg)
			Response.Write(vErrorMsg)
			ExecuteMain = False
			Exit Function
		Else
			vReportTitle = RS("WebReportGroupName")
		End If

		Set RS = Nothing

	ElseIf pvOrgID <> 0  Then

		'Else if a single organization has been selected, get the organization data
		'and set the report title to the name of the selected organization

		'Get the organization information
		vQuery = "sps_OrganizationName " & pvOrgID

		Set RS = Conn.Execute(vQuery)

		If RS.EOF = True Then
			vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
			vErrorMsg = vErrorMsg & "The organization selected for this report does not exist. <BR> <BR>"
			vErrorMsg = vErrorMsg & "If you continue to have difficulty, <BR>"
			vErrorMsg = vErrorMsg & "Please contact Statline at (888) 881-7828 for assistance.</B> <BR> <BR> <BR>"
			vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
			vErrorMsg = vErrorMsg & "Error:     (100, GetOrganizationName, MSActivity.sls) <BR> <BR>"
			vErrorMsg = vErrorMsg & "</FONT></FONT>"
			Response.Write(vErrorMsg)
			ExecuteMain = False
			Exit Function
		Else
			vReportTitle = RS("OrganizationName")
		End If

		Set RS = Nothing

	ElseIf pvOrgID = 0 AND pvReportGroupID = 0 Then

		vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
		vErrorMsg = vErrorMsg & "Either a report group or an organization must be selected. <BR> <BR>"
		vErrorMsg = vErrorMsg & "If you continue to have difficulty, <BR>"
		vErrorMsg = vErrorMsg & "Please contact Statline at (888) 881-7828 for assistance.</B> <BR> <BR> <BR>"
		vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
		vErrorMsg = vErrorMsg & "Error:     (-1, MSActivity.sls) <BR> <BR>"
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
		vErrorMsg = vErrorMsg & "Error:     (-1, Unexpected, MSActivity.sls) <BR> <BR>"
		vErrorMsg = vErrorMsg & "</FONT></FONT>"
		Response.Write(vErrorMsg)
		ExecuteMain = False
		Exit Function

	End if

	vQuery = "sps_OrganizationTimeZone " & pvUserOrgID & " "
	Set RS = Conn.Execute(vQuery)
	vTZ = RS("OrganizationTimeZone")
	Set RS = Nothing


	'Create the referral object used for queries.

	'Set Referral = Server.CreateObject("StatWebReferral.clsReferral")

	'Get the data set to be formated

	Redim ResultArray(0,0)

	'ErrorReturn = Referral.GetActivity(ResultArray, vTZ, ,pvStartDate, pvEndDate, pvReportGroupID, pvOrgID,
	'									pvReferralTypeID, ,pvOrderBy, pvUserOrgID,DataSourceName)

	SET ErrorCatch =  server.CreateObject("ADODB.Error")
	Set Conn = server.CreateObject("ADODB.Connection")
	Conn.Open DataSourceName, DBUSER, DBPWD
	vQuery = "sps_ReferralActivity_OK " & pvReportGroupID & ", '" & pvStartDate &"', " & "'" & pvEndDate &"', " &  pvOrgID & ", " & vTZ &", " & pvReferralTypeID &", " & "'" & pvOrderBy &"', " & pvUserOrgID
	'Response.Write vQuery
	Set RS = Conn.Execute(vQuery)

	vNoRecords = False

	If RS.EOF Then
		vNoRecords = True
	Else
		ResultArray = RS.GetRows

	End if



	If ErrorCatch.Number <> 0 Then

		vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
		vErrorMsg = vErrorMsg & "There has been a database error. <BR>"
		vErrorMsg = vErrorMsg & "Please click refresh to try your request again. <BR> <BR>"
		vErrorMsg = vErrorMsg & "If the problem continues, <BR>"
		vErrorMsg = vErrorMsg & "please contact Statline at (888) 881-7828 for assistance.</B> <BR> <BR> <BR>"
		vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
		vErrorMsg = vErrorMsg & "Error:     (" & ErrorReturn & ", Referral.GetActivity, Activity.sls) <BR> <BR>"
		vErrorMsg = vErrorMsg & "</FONT></FONT>"
		Response.Write(vErrorMsg)
		ExecuteMain = False
		Exit Function

	End If

	SET RS = Nothing
	SET ErrorCatch = Nothing


	ExecuteMain = True

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

FUNCTION FixOrderBY(pvOrderBy)
	DIM FirstStr,SecondStr
	FirstStr = InStr(1,PvOrderBy, "Referral.")
	SecondStr = len(pvOrderby) - (FirstStr + Len("Referral."))

	FixOrderBy = Left(pvOrderBy,FirstStr) & Right(pvOrderBy,SecondStr)
END FUNCTION


%>


