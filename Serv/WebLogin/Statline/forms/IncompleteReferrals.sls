<% Option Explicit 

    Response.CacheControl = "no-cache" 
    Response.AddHeader "Cache-Control", "private" 
    Response.AddHeader "Pragma", "no-cache" 
    Response.Expires = -1 

%>
<html>

<head>
<meta http-equiv="Expires" content="now">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Pending/Incomplete Referrals List</title>
</head>

<body bgcolor="#F5EBDD">

<!-- Include any files here Response.Write("All Times " & ZoneName(vTZ)) -->

<!--#include virtual="/loginstatline/includes/TimeZoneProcess.vbs"-->
<!--#include virtual="/loginstatline/includes/Authorize.sls"-->
<!--#include virtual="/loginstatline/includes/StatUtility.js"-->

<%

Dim FontNameHead
Dim FontSizeHead
Dim FontNameData
Dim FontSizeData

Dim pvStartDate
Dim pvEndDate
Dim vUserOrgID
Dim vReportGroupID
Dim vValue
Dim i
Dim vTZ
Dim vPendingType
Dim pvOrgId

Dim vReportTitle
Dim vMainTitle
Dim vTitlePeriod
Dim vTitleTo
Dim vTitleTimes
Dim vSectionName
Dim vReportDesc
Dim pvSortOrgType
Dim pvReferralType
Dim pvUserOrgID
Dim bPrintRecord

Dim DebugMode

DebugMode = False

FontNameHead = "Arial"
FontSizeHead = "2"
FontNameData = "Times New Roman"
FontSizeData = "2"

' Prints a list of all Request.QueryString variables received.  2/15/05 - SAP
If DebugMode = True Then
    Dim strItem

    For Each strItem In Request.QueryString
        Response.Write "<br>" & strItem & " = " 
        Response.Write Request.QueryString(strItem) & vbCrLf
    Next
    Response.Write "<br><br>"	
End If


Call FixQueryString(Request.QueryString("StartDate"), pvStartDate)
Call FixQueryString(Request.QueryString("EndDate"), pvEndDate)
vUserOrgID = Request.QueryString("UserOrgID")
vReportGroupID = Request.QueryString("ReportGroupID")
pvOrgId = Request.QueryString("OrgId")
pvSortOrgType = Request.QueryString("SortOrgType")
If Len(pvSortOrgType) = 0 Then pvSortOrgType = 0  ' Default to 0
' Fixed to make filtering by ReferralType work. 3/15/05 - SAP
pvReferralType = Request.QueryString("ReferralType")
If Len(pvReferralType) = 0 Then pvReferralType = 0  ' Default to 0
'If a pvReferralType has been selected, set pvSortOrgType to 1 for sorting
If pvReferralType > 0 Then
	pvSortOrgType = 1
End If

'Execute the main page generating routine
If AuthorizeMain Then
%>

<!-- User Org Section -->
<%
'Open Connection
Set Conn = server.CreateObject("ADODB.Connection")
Conn.Open DataSourceName, DBUSER, DBPWD

If vUserOrgID = 194 Then

	'Replace user org id with the owner of the selected report group
	If vReportGroupID <> 0 Then

		vQuery = "sps_ReportGroupOrgParentID " & vReportGroupID
		Set RS = Conn.Execute(vQuery)
		vUserOrgID = RS("OrgHierarchyParentID")
		Set RS = Nothing

	End If

End If

'Get the user's time zone
vQuery = "sps_OrganizationTimeZone " & vUserOrgID
Set RS = Conn.Execute(vQuery)
vTZ = RS("OrganizationTimeZone")
Set RS = Nothing

'Get the user's master report group
vQuery = "sps_ReportGroupMaster " & vUserOrgID
Set RS = Conn.Execute(vQuery)
'Response.Write vQuery
If not RS.EOF and not RS.BOF Then
	'vReportGroupID = RS("WebReportGroupID")
End If
Set RS = Nothing
vTitlePeriod = FormatDateTime(pvStartDate, vbShortDate) & " " & FormatDateTime(pvStartDate, vbShortTime)
vTitleTo = FormatDateTime(pvEndDate, vbShortDate) & " " & FormatDateTime(pvEndDate, vbShortTime)
vTitleTimes = "All Times " & ZoneName(vTZ)						
vMainTitle = "Pending Referrals"
If Cstr(Request.QueryString("RegStatus")) = "0" Then
	vReportTitle = "Non Registry"
ElseIf Cstr(Request.QueryString("RegStatus")) = "1" Then
	vReportTitle = "Registry"
End If

%>

<!-- Begin Header -->
<!-- Print the header. -->
<!--#include virtual="/loginstatline/forms/Head_w_ReportGroup.sls"-->
<!-- End Header -->


<!-- Pending Referrals Table -->
<% ' Fixed to make filtering by ReferralType work. 3/15/05 - SAP
   Select Case pvReferralType
	Case 1
		vReportDesc = "Organ"	
		pvReferralType = "O"
	Case 2
		vReportDesc = "Tissue"
		pvReferralType = "T"
	Case 3
		vReportDesc = "Eye"	
		pvReferralType = "E"
	Case Else
		vReportDesc = "All"
		pvReferralType = 0
   End Select
%>

<P STYLE="line-height: 1pt">&nbsp</P>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td colspan="7"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i><%=vReportDesc%> Referrals</i></b></font></td>
	</tr>
	<tr>
		<td colspan="7"><hr align="CENTER" color="#000000" noshade size="1" width="100%"></td>
	</tr>
</table>

<!-- Get  Data -->

	<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr>&nbsp</tr>
		<tr>
			<td ALIGN=LEFT VALIGN=TOP width="3%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><u>#</b></u></font></td>
			<td ALIGN=LEFT VALIGN=TOP width="10%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><u>Number</b></u></font></td>
			<td ALIGN=LEFT VALIGN=TOP width="13%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><u>Date/Time</b></u></font></td>
			<td ALIGN=LEFT VALIGN=TOP width="35%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><u>Referral Location</b></u></font></td>
			<td ALIGN=LEFT VALIGN=TOP width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><u>Patient Name</b></u></font></td>
			<td ALIGN=LEFT VALIGN=TOP width="4%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><u>Sex</b></u></font></td>
			<td ALIGN=LEFT VALIGN=TOP width="8%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><u>Age</b></u></font></td>
			<td ALIGN=LEFT VALIGN=TOP width="7%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><u></b></u></font></td>
		</tr>

<%
'Get data rows
vQuery = "sps_IncompleteReferralsFilterSort " & vTZ & ", '" & pvStartDate & "', '" & pvEndDate & "', " & vReportGroupID & ", " & pvOrgId & ", " & pvSortOrgType & ", " & pvReferralType
DebugPrint( "vQuery: " & vQuery )
Set RS = Conn.Execute(vQuery)

If RS.EOF = True Then
	Response.Write "No data Available"

Else

	i = 1
	vSectionName = ""
	Do Until RS.EOF = True
		' Check to see if this report was requested for a particular registry status
		bPrintRecord = False
		If Cstr(Request.QueryString("RegStatus")) = "0" Then
			' NON Registry was requested
			If CInt(RS("RegistryStatus")) = 0 Then
				bPrintRecord = True
			End If
		ElseIf Cstr(Request.QueryString("RegStatus")) = "1" Then
			' Registry was requested
			If CInt(RS("RegistryStatus")) > 0 Then
				bPrintRecord = True
			End If
		Else
			' No registry status requested, print all
			bPrintRecord = True
		End If
		
		If bPrintRecord = True Then %>
		<tr>
		    <td ALIGN=LEFT VALIGN=TOP width="3%"><font size="<%=FontSizeData%>"><%=i%></font></td>
		    <td ALIGN=LEFT VALIGN=TOP width="10%"><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>">
<%		    ' Modified link to use StatWindow from StatUtility.js, hiding menu, toolbars and address bars in new browser window.  2/15/05 - SAP %>
		    <a href=javascript:statWindow('ReferralDetail','/loginstatline/reports/referral/detail_1.sls?CallID=<%=RS("CallID")%>&amp;<%=Request.QueryString%>&NoLog=1&CountCheck=False')><%=RS("CallNumber")%></a></FONT></td>
		    <!-- UserID=<%=Request.QueryString("UserID")%>&amp;UserOrgID=<%=Request.QueryString("UserOrgID")%>&amp;DSN=<%=DataSourceName%>&amp;Options=0 &NoLog=1&CountCheck=False><%=RS("CallNumber")%></a></FONT></td>-->
		    <td ALIGN=LEFT VALIGN=TOP width="13%"><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"><%=RS("CallDate") & " " & RS("CallTime")%></FONT></td>
		    <td ALIGN=LEFT VALIGN=TOP width="35%"><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"><%=RS("OrganizationName")%></FONT></td>
		    <td ALIGN=LEFT VALIGN=TOP width="20%"><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"><%=RS("ReferralDonorName")%></FONT></td>
		    <td ALIGN=LEFT VALIGN=TOP width="4%"><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"><%=RS("ReferralSex")%></FONT></td>
		    <td ALIGN=LEFT VALIGN=TOP width="8%"><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"><%=RS("ReferralAge")%></FONT></td>
		    <td ALIGN=LEFT VALIGN=TOP width="7%"><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>">
				<A	HREF="javascript:doNothing();"
					onclick="window.open('/loginstatline/forms/UpdateReferral.sls?CallID=<%=RS("CallID")%>&amp;UserID=<%=Request.QueryString("UserID")%>&amp;UserOrgID=<%=Request.QueryString("UserOrgID")%>&amp;DSN=<%=DataSourceName%>&amp;ReportGroupID=<%=Request.QueryString("ReportGroupID")%>','updateReferral','resizable,scrollbars');">
				Update
				</A>
				</FONT>
			 </td>

		</tr>

<%			i = i + 1
		End If  ' If bPrintRecord = True
		RS.MoveNext

		

	Loop
%>

	</table>

<%
End If
%>


</BODY>
</HTML>
<!--#include virtual="/loginstatline/includes/copyright.shm"-->
<%
End If

Set RS = Nothing
Set Conn = Nothing


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

Sub DebugPrint(sDbg)
	If DebugMode = True Then
		Response.Write "<br>" & sDbg & "<br><br>"
	End If
End Sub

%>

<script language="JavaScript">

	function clickDesc()
	{

	var url = ""
	var reportvalue = ""
	var reportdescfile = ""
	var pipeIndex = 0

	reportvalue = reportForm.report.options[reportForm.report.selectedIndex].value
	pipeIndex = reportvalue.indexOf("|",0)
	reportdescfile = reportvalue.substring(0,pipeIndex)

	url = strHttpHeader + reportForm.serverName.value + "/loginstatline/reportdesc/" + reportdescfile
	window.open(url,"UpdateReferral",'toolbar=1,location=0,directories=0,status=1,menubar=1,scrollbars=1,resizable=1')

	return 0

	}

	function doNothing()
	{
	}
</script>
