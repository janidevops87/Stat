
<% 
Option Explicit

Dim DonorRegistryConn
Dim pvStartDate
Dim pvEndDate
Dim pvUserOrg
Dim pvOrgID
Dim pvReportGroupID
Dim vTZ
Dim vErrorMsg
Dim vAnd
Dim ErrorReturn
Dim vReportName
Dim vCurrentColor
Dim LastOrganizationID
Dim LastMonthYear
Dim pvCallID

Dim OnlineTotal
Dim OutreachTotal

Dim x
Dim i

Dim FontNameHead
Dim FontNameData
Dim RegistryDSN

Dim vReportTitle
Dim vMainTitle
Dim vTitlePeriod
Dim vTitleTo
Dim vTitleTimes
Dim pvReportID

pvCallID = 0
FontNameHead = "Arial"
FontNameData = "Times New Roman"
vReportTitle = ""
vReportName = ""
RegistryDSN = Request.QueryString("DMV_CO")

DIM PORGANIZATIONID
PORGANIZATIONID= 50
%>

<!-- Include any files here Response.Write("All Times " & ZoneName(vTZ)) -->

<!--#include virtual="/loginstatline/includes/TimeZoneProcess.vbs"-->

<!--#include virtual="/loginstatline/includes/Authorize.sls"--> 

<%


'Execute the main page generating routine
If AuthorizeMain Then

	Set DonorRegistryConn = server.CreateObject("ADODB.Connection")
	DonorRegistryConn.Open DMV_CO, DBUSER, DBPWD
	
	Set Conn = server.CreateObject("ADODB.Connection")
	Conn.Open PRODUCTIONDSN, DBUSER, DBPWD

	'Get the query variables
	Call FixQueryString(Request.QueryString("StartDate"), pvStartDate)
	Call FixQueryString(Request.QueryString("EndDate"), pvEndDate)
	pvUserOrg = FormatNumber(Request.QueryString("UserOrgID"),0,,0,0)
	pvReportID = Request.QueryString("ReportID")
		
	'Get the report Name
	vQuery = "sps_ReportInformation " & pvReportID
	'print(vQuery)
	Set RS = Conn.Execute(vQuery)

	If RS.EOF = True Then
	  vReportTitle = "Registry Count (Source Summary) "
	Else
	  'RS.MoveFirst
	  vReportTitle = RS("ReportDisplayName")
	End If
	
	Set RS = Nothing
	
	'Verify the requesting organization if it not Statline
	If pvUserOrg <> 194 then
		
		vQuery = "sps_OrganizationName " & pvUserOrg
		Set RS = Conn.Execute(vQuery)
		
		If RS.EOF = True Then
			vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
			vErrorMsg = vErrorMsg & "The organization attempting to run this report does not exist. <BR> <BR>"
			vErrorMsg = vErrorMsg & "If you continue to have difficulty, <BR>"
			vErrorMsg = vErrorMsg & "Please contact Statline at (888) 881-7828 for assistance.</B> <BR> <BR> <BR>"
			vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
			vErrorMsg = vErrorMsg & "Error:     (100, Org.IdentifyOrganization, Activity.sls) <BR> <BR>"
			vErrorMsg = vErrorMsg & "</FONT></FONT>"
			Response.Write(vErrorMsg)		
		End If
		
		Set RS = Nothing
	
	Else
	
		'If the user org = 194 use Colorado Donor as the default.
		'the replace the user org id with the org owner of the 
		'selected report group.
		vQuery = "sps_OrganizationName " & PORGANIZATIONID 'Colorado Donor Alliance
		'print(vQuery)
		Set RS = Conn.Execute(vQuery)
		
		If RS.EOF = True Then
			vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
			vErrorMsg = vErrorMsg & "The organization attempting to run this report does not exist. <BR> <BR>"
			vErrorMsg = vErrorMsg & "If you continue to have difficulty, <BR>"
			vErrorMsg = vErrorMsg & "Please contact Statline at (888) 881-7828 for assistance.</B> <BR> <BR> <BR>"
			vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
			vErrorMsg = vErrorMsg & "Error:     (100, Org.IdentifyOrganization, Activity.sls) <BR> <BR>"
			vErrorMsg = vErrorMsg & "</FONT></FONT>"
			Response.Write(vErrorMsg)		
		End If
		
		Set RS = Nothing

	End If

	vQuery = "sps_OrganizationTimeZone " & pvUserOrg & " "
	
	Set RS = Conn.Execute(vQuery)
	vTZ = RS("OrganizationTimeZone")
	Set RS = Nothing

	
%>
	<%	
	
	'Get Data  
	
	vQuery = " sps_DonorRegistrySource  '" & pvStartDate & "', '" & pvEndDate & "'"
	' Print(vQuery)	
	Set RS = DonorRegistryConn.Execute(vQuery)

%>
<html>

<head>
<meta http-equiv="Expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">





<title><%=vReportTitle%></title>
<STYLE MEDIA=ALL >
	H1 {page-break-after: always}
</STYLE >
</head>


<BODY bgcolor="#F5EBDD" >
<%
	'Set Title Values		
	vMainTitle = ""
	vTitlePeriod = FormatDateTime(pvStartDate, vbShortDate) & " " & FormatDateTime(pvStartDate, vbShortTime)
	vTitleTo = FormatDateTime(pvEndDate, vbShortDate) & " " & FormatDateTime(pvEndDate, vbShortTime)
	vTitleTimes = "All Times " & ZoneName(vTZ)	
%>

<!--#include virtual="/loginstatline/reports/custom/RegistryCountHead.sls"--> 
<img src="/loginstatline/images/redline.jpg" height="2" width="100%">

<!-- table header -->
<Table BORDER=0 WIDTH="93%" cellpadding=3 cellSpacing="0">
	<TR>
		<TH WIDTH="25%">
			<FONT face=FontNameHead size=2>Source Name
			</FONT>
		</TH>

		<TH WIDTH="25%">	
			<FONT face=FontNameHead size=2>OUTREACH COUNT
			</FONT>
		</TH>		
	</TR>

<%
	Do While Not RS.EOF
%>

<!-- begin report -->

	<TR>
		<TD WIDTH="25%" ALIGN=LEFT>
			<A target="RegistryCount_(Source)" HREF="RegistryCount_(Source).sls?<%=("RegistryDsn=DMV_CO" & "&Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&SourceID=" & RS("SourceID") & "&ReportID=135" )%>">
			<FONT face=FontNameData size=2><%=RS("EventName")%>			
			</FONT>
			</A>

			
		</TD>

		
		<TD WIDTH="25%" ALIGN=CENTER>	
			<FONT face=FontNameData size=2><%=RS("Outreach")%>
			</FONT>
			<% OutreachTotal = OutreachTotal + RS("Outreach")%>
		</TD>
		
	</TR>
	
	<%
	RS.MoveNext
	
	Loop

	%>	
	</TABLE>
	<img src="/loginstatline/images/redline.jpg" height="2" width="100%">

	<Table BORDER=0 WIDTH="93%" cellpadding=3 cellSpacing="0">
	
		<TR>
		
				<TD WIDTH="25%" ALIGN=CENTER>
					<FONT face=FontNameData size=2>&nbsp
					</FONT>
				</TD>
		
				<TD WIDTH="25%" ALIGN=CENTER>
					<FONT face=FontNameData size=2>&nbsp
					</FONT>
				</TD>
				<TD WIDTH="25%" ALIGN=CENTER>
					<FONT face=FontNameData size=2><B>Totals:</B>
					</FONT>
				</TD>				
				<TD WIDTH="25%" ALIGN=CENTER>	
					<FONT face=FontNameData size=2><%=OutreachTotal%>
					</FONT>
				</TD>
				
		</TR>

	</TABLE>	
</BODY>
</HTML>
	
	
<%
End If

Set RS = Nothing
Set Conn = Nothing
Set DonorRegistryConn = Nothing


%>


<%
Function DateLiteral(pvDate)

	Select Case Month(pvDate)
	
		Case 1
			DateLiteral = "Jan "
		Case 2
			DateLiteral = "Feb "
		Case 3
			DateLiteral = "March "
		Case 4
			DateLiteral = "April "
		Case 5
			DateLiteral = "May "
		Case 6
			DateLiteral = "June "
		Case 7
			DateLiteral = "July "
		Case 8
			DateLiteral = "Aug "
		Case 9
			DateLiteral = "Sept "
		Case 10
			DateLiteral = "Oct "
		Case 11
			DateLiteral = "Nov "
		Case 12
			DateLiteral = "Dec "
	End Select
	
	DateLiteral = DateLiteral & Year(pvDate)
	
End Function

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


Private Function SubTotal(PrintLine)
'Set PrintLine to Print a horizontal line after printing the subtotals.
%>
	<TR>
		<TD <%=vCurrentColor%>  ALIGN=CENTER><FONT SIZE="1" FACE="<%=FontNameData%>"><B><i>&nbsp &nbsp &nbsp &nbsp Subtotal</i></B></TD>
		<TD <%=vCurrentColor%>  ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameData%>"><B><i><%=vOrgTotals(0)%></i></B></FONT></TD>
		<TD <%=vCurrentColor%> ><FONT SIZE="1" FACE="<%=FontNameData%>"><B><i><%=vOrgTotals(1)%></i></B></FONT></TD>
		<TD <%=vCurrentColor%> ><FONT SIZE="1" FACE="<%=FontNameData%>"><B><i><%=vOrgTotals(2)%></i></B></FONT></TD>
		<TD <%=vCurrentColor%> ><FONT SIZE="1" FACE="<%=FontNameData%>"><B><i><%=vOrgTotals(3)%></i></B></FONT></TD>
		<TD <%=vCurrentColor%> ><FONT SIZE="1" FACE="<%=FontNameData%>"><B><i><%=vOrgTotals(4)%></i></B></FONT></TD>
	</TR>
	<% 
	If PrintLine = 1 Then 
	%>
		<TR>
			<TD COLSPAN=8><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%"></TD>
		</TR>
	<% 
	End If		
	%>	
<%	
	For i = 0 to UBound(vOrgTotals,1)
			vOrgTotals(i)=0
	Next
End Function

'End of Function Section
%>