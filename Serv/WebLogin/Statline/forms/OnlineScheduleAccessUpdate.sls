<%
Option Explicit

'Declare variables
Dim pvStartDate
Dim pvEndDate
Dim vErrorMsg
Dim ErrorReturn
Dim pvUserOrgID
Dim pvReportGroupID
Dim	pvScheduleGroupID
Dim pvReferralTypeID
Dim vReportTitle
Dim vTZ
Dim i
Dim vScheduleGroupName
Dim vSizeofRows
Dim ResultsArray
Dim ForLoopCounter
Dim ForLoopColumnCounter

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
FontSizeData = "1"
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
<title>Schedule Access</title>
</head>

<body bgcolor="#F5EBDD">
<!--#include virtual="/loginstatline/includes/Authorize.sls"-->

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
	
	pvScheduleGroupID = FormatNumber(Request.QueryString("ScheduleGroupID"),0,,0,0)
	'print Request.QueryString
	
	If ExecuteMain Then
	%>
		<Form Name="ScheduleAccess" >
		<Table border=0 width=70%>
		
			<TR>
				<TD WIDTH=33% colspan=3 align=center>
					<H2>Schedule Access Setup</H2>			
				</TD>
				
								
			</TR>
			<TR>
				<TD WIDTH=33% colspan=3 align=center>
					<H3><%=vReportTitle%></H3>			
				</TD>
			</TR>
			<TR>
			<TD WIDTH=33% colspan=3 align=center><A HREF="javascript:alert('To grant Schedule Update and Schedule Log Access, double-click a name in the Unauthorized list; wait a few seconds, then click Refresh to view your change.\n\nTo revoke Schedule Update and Schedule Log Access, double-click a name in the Authorized list; wait a few seconds, then click Refresh to view your change.\n\nNote: Changes may take up to a minute to show up.  If your changes do not show up upon clicking Refresh, wait a few more seconds and click Refresh again.')">INSTRUCTIONS</A></TD>
			</TR>
			<TR>
				<TD WIDTH=45%>
					<H3>Unauthorized</H3>
				</TD>
				<TD WIDTH=10%>
				</TD>
				<TD WIDTH=45%>
					<H3>Authorized</H3>
				</TD>
			</TR>
			<TR>
				<TD border=1 >
					<iframe height=400 name="UnAuthorized" Frameborder=0 MarginHeight=0 Marginwidth=0 scrolling=auto
					
					src="/loginstatline/forms/OnlineScheduleAccessUpdate_Activity.sls?ReportGroupID=<%=pvReportGroupID%>&ScheduleAccess=0" noresize>
					</iframe>
				</TD>
				<TD  valign=top>
					<input type=button onclick="refreshForm()" readonly value=Refresh  id=button1 name=button1>
				</TD>
				<TD border=1  >
					<iframe height=400 name="Authorized" Frameborder=0 MarginHeight=0 Marginwidth=0 scrolling=auto 
					src="/loginstatline/forms/OnlineScheduleAccessUpdate_Activity.sls?ReportGroupID=<%=pvReportGroupID%>&ScheduleAccess=-1" noresize>
					</iframe>

				</TD>

			</TR>
		</Table>
		</Form>			
		
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

	If pvReportGroupID = 0 Then

		vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
		vErrorMsg = vErrorMsg & "Either a report group or an organization must be selected. <BR> <BR>"
		vErrorMsg = vErrorMsg & "If you continue to have difficulty, <BR>"
		vErrorMsg = vErrorMsg & "Please contact Statline at (888) 881-7828 for assistance.</B> <BR> <BR> <BR>"
		vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
		vErrorMsg = vErrorMsg & "Error:     (-1, Schedule.sls) <BR> <BR>"
		vErrorMsg = vErrorMsg & "</FONT></FONT>"
		Response.Write(vErrorMsg)
		ExecuteMain = False
		Exit Function
	
	End if
	
	vQuery = "sps_OrganizationTimeZone " & pvUserOrgID & " "
	Set RS = Conn.Execute(vQuery)
	vTZ = RS("OrganizationTimeZone")
	Set RS = Nothing
	
	vQuery = " sps_ScheduleGroupName " & pvScheduleGroupID
	'Response.Write vQuery
	Set RS = Conn.Execute(vQuery)
	
	IF RS.EOF = FALSE Then
		'vScheduleGroupName = RS("ScheduleGroupname")	
		vReportTitle = RS("OrganizationName")
	ELSE
		vScheduleGroupName = ""
	END IF	
	
	Set RS = Nothing
	
	'Get data rows
	'vQuery = "sps_OnlineScheduleAccessList "  & pvScheduleGroupID 
	'Response.Write vQuery
	'Set RS = Conn.Execute(vQuery)

	'If RS.EOF = True Then
	'	ExecuteMain = False
	'Else
	'	ExecuteMain = True
	'	ResultsArray = RS.GetRows
	'End If
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
%>
<script language="JavaScript">

	function refreshForm()
	{	
		frames[0].location.replace("/loginstatline/forms/OnlineScheduleAccessUpdate_Activity.sls?ScheduleGroupID=<%=pvScheduleGroupID%>&ReportGroupID=<%=pvReportGroupID%>&ScheduleAccess=0")
		frames[1].location.replace("/loginstatline/forms/OnlineScheduleAccessUpdate_Activity.sls?ScheduleGroupID=<%=pvScheduleGroupID%>&ReportGroupID=<%=pvReportGroupID%>&ScheduleAccess=-1")
		return 0
	}

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
