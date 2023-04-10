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
Dim pvUserOrg
Dim pvUserID
Dim pvOrgID
Dim pvReportGroup
Dim pvCallID
Dim pvSortID
Dim Children
Dim Org
Dim Message
Dim TZ
Dim i
Dim j
Dim x
Dim DateTime
Dim Section1 
Dim Section2
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


<HTML>
<HEAD>
<META HTTP-EQUIV="Expires" content="now">
<META HTTP-EQUIV="Content-Type" content="text/html; charset=iso-8859-1">
<TITLE>Message Detail</TITLE>
</HEAD>
<BODY bgcolor="#F5EBDD">
<!-- Include any files here  -->

<!--#include virtual="/loginstatline/includes/TimeZoneProcess.vbs"-->

<!--#include virtual="/loginstatline/includes/Authorize.sls"--> 

<%'Execute the main page generating routine
If AuthorizeMain Then
	Call ExecuteMain
End If

Function ExecuteMain()


	
	Call FixQueryString(Request.QueryString("StartDate"), pvStartDate)
	Call FixQueryString(Request.QueryString("EndDate"), pvEndDate)
	pvUserOrg = FormatNumber(Request.QueryString("UserOrgID"),0,,0,0)
	pvOrgID = FormatNumber(Request.QueryString("OrgID"),0,,0,0)
	pvReportGroup = FormatNumber(Request.QueryString("ReportGroupID"),0,,0,0)
	pvUserID = FormatNumber(Request.QueryString("UserID"),0,,0,0)
	pvSortID = Request.QueryString("Orderby")
	

	'Create a connection object
	Set Conn = server.CreateObject("ADODB.Connection")
	Conn.Open DataSourceName, DBUSER, DBPWD

	'Verify the requesting organization if it not Statline
	If pvUserOrg <> 194 then

		vQuery  = "sps_IdentifyOrganization " & pvUserOrg
		'Response.Write vQuery
		Set RS = Conn.Execute(vQuery)

		If RS.EOF Then
			vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
			vErrorMsg = vErrorMsg & "There has been a database error. <BR>"
			vErrorMsg = vErrorMsg & "Please click refresh to try your request again. <BR> <BR>"
			vErrorMsg = vErrorMsg & "If the problem continues, <BR>"
			vErrorMsg = vErrorMsg & "please contact Statline at (888) 881-7828 for assistance.</B> <BR> <BR> <BR>"
			vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
			vErrorMsg = vErrorMsg & "Error:     (" & ErrorReturn & ", Org.IdentifyOrganization, MultiDetail.sls) <BR> <BR>"
			vErrorMsg = vErrorMsg & "</FONT></FONT>"
			Response.Write(vErrorMsg)
			Exit Function
		End If
		
		vOrgList = RS.GetRows
		Set RS = Nothing


		'Verify the requesting organization is a procurement agency
		If vOrgList(3,0) <> 1 Then
			vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
			vErrorMsg = vErrorMsg & "Your organization does not have permissions to view this report. <BR> <BR>"
			vErrorMsg = vErrorMsg & "If you continue to have difficulty, <BR>"
			vErrorMsg = vErrorMsg & "Please contact Statline at (888) 881-7828 for assistance.</B> <BR> <BR> <BR>"
			vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
			vErrorMsg = vErrorMsg & "Error:     (-1, MultiDetail.sls) <BR> <BR>"
			vErrorMsg = vErrorMsg & "</FONT></FONT>"
			Response.Write(vErrorMsg)
			Exit Function
		End If

		'Because the request is for import offers, override any selected report group
		'or organization and only select records from the requesting organization
		pvReportGroup = 0
		pvOrgID = vOrgList(0,0)

	End If
	
		If pvUserOrg = 194 then

		vQuery  = "sps_IdentifyOrganization " & pvUserOrg
		'Response.Write vQuery
		Set RS = Conn.Execute(vQuery)

		If RS.EOF Then
			vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
			vErrorMsg = vErrorMsg & "There has been a database error. <BR>"
			vErrorMsg = vErrorMsg & "Please click refresh to try your request again. <BR> <BR>"
			vErrorMsg = vErrorMsg & "If the problem continues, <BR>"
			vErrorMsg = vErrorMsg & "please contact Statline at (888) 881-7828 for assistance.</B> <BR> <BR> <BR>"
			vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
			vErrorMsg = vErrorMsg & "Error:     (" & ErrorReturn & ", Org.IdentifyOrganization, MultiDetail.sls) <BR> <BR>"
			vErrorMsg = vErrorMsg & "</FONT></FONT>"
			Response.Write(vErrorMsg)
			Exit Function
		End If
		
		vOrgList = RS.GetRows
		Set RS = Nothing

		'Because the request is for import offers, override any selected report group
		'or organization and only select records from the requesting organization
		pvReportGroup = 0
		pvOrgID = vOrgList(0,0)

	End If
		
	vQuery = "sps_OrganizationTimeZone " & pvUserOrg
	Set RS = Conn.Execute(vQuery)
	TZ = RS("OrganizationTimeZone")
	Set RS = Nothing
	'Set Title Values
	vReportTitle = ""
	vMainTitle = "Message Detail"
	vTitlePeriod = pvStartDate
	vTitleTo = pvEndDate
	vTitleTimes = "All Times " & ZoneName(TZ)
	


	For i = 0 to Ubound(vOrgList, 2)
	%>

		<!-- Print the header. -->
		<!--#include virtual="/loginstatline/reports/message/Head.sls"-->	

		<%'Reset the detail array
		Redim Section1(0,0)

		'GetSection1
		vQuery = "sps_GetMessageDetailList " & pvUserID & ", '" & pvStartDate & "', '" & pvEndDate & "', " & vOrgList(i,0) & ", " & 0 & ", '" & pvSortID & "'"
		'Response.Write vQuery
		Set RS = Conn.Execute(vQuery)
				
		If RS.EOF Then

			vErrorMsg = "<BR> <BR> <BR> <FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
			vErrorMsg = vErrorMsg & "There are no detail records available. <BR>"
			vErrorMsg = vErrorMsg & "Change your selection criteria and try your request again.</B> <BR> <BR>"
			vErrorMsg = vErrorMsg & "</FONT></FONT>"
			Response.Write(vErrorMsg)
			Exit Function

		Else
			Section1 = RS.GetRows
			Set RS = Nothing

			For j = 0 TO Ubound(Section1, 2)
		%>

				<!--#include virtual="/loginstatline/reports/message/DetailSection1.sls"--> 

				<%'Reset the log array
				Redim Section2(0,0)

				'GetSection1
				vQuery = "sps_LogDetail " & Section1(1, j) & ", " & TZ
				'Response.Write vQuery
				Set RS = Conn.Execute(vQuery)
			
				If RS.EOF Then

					vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
					vErrorMsg = vErrorMsg & "There has been a database error. <BR>"
					vErrorMsg = vErrorMsg & "Please click refresh to try your request again. <BR> <BR>"
					vErrorMsg = vErrorMsg & "If the problem continues, <BR>"
					vErrorMsg = vErrorMsg & "please contact Statline at (888) 881-7828 for assistance.</B> <BR> <BR> <BR>"
					vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
					vErrorMsg = vErrorMsg & "Error:     (" & ErrorReturn & ", Import.GetDetailList, MultiDetail.sls) <BR> <BR>"
					vErrorMsg = vErrorMsg & "</FONT></FONT>"
					Response.Write(vErrorMsg)
					Exit Function

				Else
					Section2 = RS.GetRows
					Set RS = Nothing
					

				%>
					<!--#include virtual="/loginstatline/reports/message/DetailSection2.sls"--> 
				<%
				End If
	
			Next 

		End If  
	
	Next
	
	Set Message = Nothing
	Set Conn = Nothing
	%>

<%End Function%>

</BODY>
</HTML>
<!--#include virtual="/loginstatline/includes/copyright.shm"-->
<%
Sub FixQueryString(pvIn, pvOut)
	
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
