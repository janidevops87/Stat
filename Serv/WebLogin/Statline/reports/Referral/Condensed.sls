<%Option Explicit

Response.CacheControl = "no-cache" 
Response.AddHeader "Cache-Control", "private" 
Response.AddHeader "Pragma", "no-cache" 
Response.Expires = -1 

'Declare variables
Dim ErrorReturn
Dim pvStartDate
Dim pvEndDate
Dim vErrorMsg
Dim vOrgList
Dim pvUserOrgID
Dim pvOrgID
Dim pvReportGroupID
Dim pvReferralTypeID
Dim pvCallID
Dim pvOrderBy
Dim pvOptions
Dim pvNoName
Dim vReportGroupName
Dim vReportTitle
Dim vShowGroup1
Dim Identify
Dim Org
Dim Children
Dim Referral
Dim vTZ
Dim i
Dim RHead(3)
Dim y
Dim x
Dim ResultArray
Dim TypeName
Dim RefDataArray
Dim Section2
Dim Section4
Dim CountCheck

Dim FontNameHead
Dim FontSizeHead
Dim FontNameData
Dim FontSizeData
Dim FontNameHeadLog
Dim FontSizeHeadLog
Dim FontSizeDataLog
Dim FontNameDataLog

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
<meta http-equiv="Expires" content="now">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Referral Summary - Condensed</title>
</head>

<body bgcolor="#F5EBDD">
<!--#include virtual="/loginstatline/includes/Authorize.sls"-->
<!--#include virtual="/loginstatline/includes/CountWarning.vbs"-->
<!--#include virtual="/loginstatline/includes/VerifyRefType.vbs"-->
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
			Call CountWarning(400)

		End If

		'CountCheck = "False"

		If CountCheck = "False" Then

			If ExecuteMain Then%>

				<!-- Print the header. -->
				<!--#include virtual="/loginstatline/reports/referral/CondensedHead.sls"-->
				<!-- Format and display section -->
				<!--#include virtual="/loginstatline/reports/referral/CondensedDetail.sls"-->

				<%Set Referral = Nothing

			End If

		End If

	End If

End If

Set Conn = Nothing

%>

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
	If pvOrderBy = "" Or pvOrderBy = "0" Then
		pvOrderBy = "OrganizationName, CallDateTime"
		vShowGroup1 = True
	Else
		If Left(pvOrderBy, 23) = "OrganizationName" Then
			vShowGroup1 = True
		Else
			vShowGroup1 = False
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
			vErrorMsg = vErrorMsg & "Error:     (100, GetOrganization, Summary.sls) <BR> <BR>"
			vErrorMsg = vErrorMsg & "</FONT></FONT>"
			Response.Write(vErrorMsg)
			ExecuteMain = False
			Exit Function
		End If

		Set RS = Nothing

	End If

	If pvCallID = 0 Then

		'This is a multiple referral request
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
				vErrorMsg = vErrorMsg & "Error:     (100, GetReportGroupName, Summary.sls) <BR> <BR>"
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
				vErrorMsg = vErrorMsg & "Error:     (100, GetOrganizationName, Summary.sls) <BR> <BR>"
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
			vErrorMsg = vErrorMsg & "Error:     (-1, Summary.sls) <BR> <BR>"
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
			vErrorMsg = vErrorMsg & "Error:     (-1, Unexpected, Summary.sls) <BR> <BR>"
			vErrorMsg = vErrorMsg & "</FONT></FONT>"
			Response.Write(vErrorMsg)
			ExecuteMain = False
			Exit Function

		End If

	End If

	vQuery = "sps_OrganizationTimeZone " & pvUserOrgID & " "
	Set RS = Conn.Execute(vQuery)
	vTZ = RS("OrganizationTimeZone")
	Set RS = Nothing


	' Create the referral object used for queries. -->

	Set Referral = Server.CreateObject("StatWebReferral.clsReferral")

	' Get Primary Referral Data -->

	ErrorReturn = Referral.GetSummaryCondensed(ResultArray, vTZ, pvCallID, pvStartDate, pvEndDate, pvReportGroupID, pvOrgID, pvReferralTypeID,,pvOrderBy,pvUserOrgID,DataSourceName)

	If ErrorReturn = 100 Then

		vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
		vErrorMsg = vErrorMsg & "There are no records for the selected criteria. <BR>"
		vErrorMsg = vErrorMsg & "Change your criteria and try again. <BR> <BR>"
		vErrorMsg = vErrorMsg & "If you continue to have difficulty, <BR>"
		vErrorMsg = vErrorMsg & "please contact Statline at (888) 881-7828 for assistance.</B> <BR> <BR> <BR>"
		vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
		vErrorMsg = vErrorMsg & "Error:     (" & ErrorReturn & ", Referral.GetSummary, Summary.sls) <BR> <BR>"
		vErrorMsg = vErrorMsg & "</FONT></FONT>"
		Response.Write(vErrorMsg)
		ExecuteMain = False
		Exit Function

	ElseIf ErrorReturn <> 0 Then

		vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
		vErrorMsg = vErrorMsg & "There has been a database error. <BR>"
		vErrorMsg = vErrorMsg & "Please click refresh to try your request again. <BR> <BR>"
		vErrorMsg = vErrorMsg & "If the problem continues, <BR>"
		vErrorMsg = vErrorMsg & "please contact Statline at (888) 881-7828 for assistance.</B> <BR> <BR> <BR>"
		vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
		vErrorMsg = vErrorMsg & "Error:     (" & ErrorReturn & ", Referral.GetSummary, Summary.sls) <BR> <BR>"
		vErrorMsg = vErrorMsg & "</FONT></FONT>"
		Response.Write(vErrorMsg)
		ExecuteMain = False
		Exit Function

	End If

	ExecuteMain = True

End Function



Sub FixQueryString(pvIn, pvOut)

	Dim j

	pvOut = ""

	For j=1 TO Len(pvIn)

		If Mid(pvIn,j,1) = "_" Then
			pvOut = pvOut & " "
		Else
			pvOut = pvOut & Mid(pvIn,j,1)
		End If

	Next

End Sub
%>
