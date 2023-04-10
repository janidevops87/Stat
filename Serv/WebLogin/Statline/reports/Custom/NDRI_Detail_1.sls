<% Option Explicit %>



<%

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
Dim vNoRecords
Dim CountCheck
Dim CheckGOLM

'----------------------------------------------------------------
'MH 08/13/2003
'Need to be able to count the page rows for inserting page breaks in proper location.
'iPageRowCount only added to <tr> tags and <hr> tags that are not in a <tr> tag.
'Also, iPageRowCount are NOT added to the PatientName/SSN header/footers.
'These variables are used in DetailSection3_1.sls and DetailSection4_1.sls
Dim iPageRowCount
iPageRowCount = 0	'Default value for header logos.
Dim iTempPageRowCount
iTempPageRowCount = 0	' Holds the iPageRowCount at the top of each page, for comparison for page breaks.
'----------------------------------------------------------------

Dim FontNameHead
Dim FontSizeHead
Dim FontNameData
Dim FontSizeData
Dim FontNameHeadLog
Dim FontSizeHeadLog
Dim FontSizeDataLog
Dim FontNameDataLog
Dim ErrorCatch

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
<!--#include virtual="/loginstatline/includes/Authorize.sls"-->
<!--#include virtual="/loginstatline/includes/CountWarning.vbs"-->
<!--#include virtual="/loginstatline/includes/VerifyRefType.vbs"-->
<%

'Execute the main page generating routine

'Print " Detail_1 " & DataSourceName
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

%>
<html>

<head>

<meta http-equiv="Expires" content="now">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<title>NDRI Call Sheet</title>
<STYLE>
	UL {page-break-before: always}
</STYLE>
</head>



<body bgcolor="#F5EBDD">

<%

If AuthorizeMain Then

	'Create a connection object
	Set Conn = server.CreateObject("ADODB.Connection")
	Server.ScriptTimeout = 270
	Conn.CommandTimeout = 90
	Conn.Open DataSourceName, DBUSER, DBPWD


	'Call the referral type verification routine
	If VerifyReferralTypeAccess(True) Then

		'If the count check has not been set or should be explicitly
		'checked, the add the function and check count
		If CountCheck = "" Or CountCheck = "True" Then

			'Check the referral count. If the count exceeds the limit,
			'set CountCheck to "True" so the warning is displayed
			'and Execute Main is not called. If the count is not exceeded,
			'set CountCheck to "False" so ExecuteMain is called.
			Call CountWarning(200)

		End If

		'CountCheck = "False"

		If CountCheck = "False" Then

			If ExecuteMain Then
			
			%>
				<!-- Print the header. -->
				<!--#include virtual="/loginstatline/reports/custom/NDRI_DetailHead_1.sls"-->
				<!-- Get each referral record from the call list. -->
				<%TypeName = ""
				If vNoRecords Then
				%>

					<!-- Indicate no records. -->

					<p><img src="/loginstatline/images/redline.jpg" height="2" width="100%"></p>
					<%If pvCallID > 0 Then%>
						<p><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><%Response.Write("There is no record for referral    #" & pvCallID & ".    Please check the referral number.")%></b><font></p>
					<%Else%>
						<p><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>No activity during this period.</b><font></p>
					<%End If%>

					<p><img src="/loginstatline/images/redline.jpg" height="2" width="100%"></p>

				<%Else

					For i = 0 to Ubound(ResultArray, 2)


						If Ubound(ResultArray, 2) > 0 Then%>
							<!-- Add a counter header if there are more than one referral. -->

							<UL></UL>
							<table border="0" width="100%" cellpadding="0" cellspacing="0">
							<TR valign="bottom">
							<TD height="2" valign="bottom"><img src="/loginstatline/images/redline.jpg" height="2" width="100%"></TD>
							</TR>
							<TR>
							<TD height="8">
							<font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>#<%=i+1%></b></font>
							</TD>
							</TR>
							<TR height="2">
							<TD valign="top"><img src="/loginstatline/images/redline.jpg" height="2" width="100%"></TD>
							</TR>
							</TABLE>
							
							
						<%End If

						'FOR forLoop = 0 to UBound(ResultArray,1)
						'	Response.Write(forLoop & " " & ResultArray(forLoop,i) & "<br>")
						'Next

						
						%>
						<!-- Format and display each section -->
						<!--#include virtual="/loginstatline/reports/custom/NDRI_DetailSection1_1.sls"-->
						
						
						
						<BR>
						<!--#include virtual="/loginstatline/includes/copyright.shm"-->
						
					<%Next
				End If

				Set Referral = Nothing

			End If

		End If

	End If

End If

Set Conn = Nothing

%>
</p>
</font>
</body>
</html>


<%
Function ExecuteMain()

	'Parse the option settings
	If pvOptions = "" Then
		pvOptions = 0
	End If

	pvNoName = Mid(pvOptions, 1, 1)


	'Set Order By
	If pvOrderBy = "" Or pvOrderBy = "0" Then
		pvOrderBy = "Referral.ReferralTypeID, Organization.OrganizationName, CallDateTime"
		vShowGroup1 = True
	Else
		If Left(pvOrderBy, 23) = "Referral.ReferralTypeID" Then
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
			vErrorMsg = vErrorMsg & "Error:     (100, GetOrganization, Detail.sls) <BR> <BR>"
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
				vErrorMsg = vErrorMsg & "Error:     (100, GetOrganizationName, Detail.sls) <BR> <BR>"
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

		End If

	End If

	vQuery = "sps_OrganizationTimeZone " & pvUserOrgID & " "
	Set RS = Conn.Execute(vQuery)
	vTZ = RS("OrganizationTimeZone")
	Set RS = Nothing

	SET ErrorCatch =  server.CreateObject("ADODB.Error")
	'Response.Write formatDateTime(Now(),vblongtime)
	vQuery = "sps_GetNDRICallSheet " & pvCallId
	'Response.Write vQuery
	
	Set RS = Conn.Execute(vQuery)
	
	vNoRecords = False
	If ErrorCatch.Number <> 0 Then
		vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
		vErrorMsg = vErrorMsg & "There has been a database error. <BR>"
		vErrorMsg = vErrorMsg & "Please click refresh to try your request again. <BR> <BR>"
		vErrorMsg = vErrorMsg & "If the problem continues, <BR>"
		vErrorMsg = vErrorMsg & "please contact Statline at (888) 881-7828 for assistance.</B> <BR> <BR> <BR>"
		vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
		vErrorMsg = vErrorMsg & "Error:     (" & ErrorReturn & ", Referral.GetCallList, Activity.sls) <BR> <BR>"
		vErrorMsg = vErrorMsg & "</FONT></FONT>"
		Response.Write(vErrorMsg)
		ExecuteMain = False
		Exit Function
	Else
		If RS.EOF Then
			vNoRecords = True
		Else
			ResultArray = RS.GetRows
		End if
	End If

	Set RS = Nothing

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

'This sub is used by DetailSection3 to format note fields
Sub OutputMemo(memo)

	IF IsNull(memo) or memo = "" Then

		Exit Sub

	End If
	Dim mx

	For mx=1 to Len(memo)

		If Asc(Mid(memo, mx, 1)) = 13 Then
			Response.Write("<BR>")
		Else
			Response.Write(Mid(memo,mx,1))
		End If
	Next
End Sub

%>

