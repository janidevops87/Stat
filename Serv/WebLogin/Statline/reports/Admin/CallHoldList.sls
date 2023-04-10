<% Option Explicit %>
<HTML>
<HEAD>
<TITLE>Call Hold Detail</TITLE>
</HEAD>
<BODY BGCOLOR="#F5EBDD">
<%	
Dim FontNameHead 
Dim FontSizeHead 
Dim FontNameData 
Dim FontSizeData 
Dim FontNameHeadLog 
Dim FontSizeDataLog 
Dim FontNameDataLog 
	
Dim pvStartDate
Dim pvEndDate
Dim pvUserOrgID
Dim vStartInterval
Dim vEndInterval
Dim vCounter
Dim vDetailQuery
Dim vReportGroupID
Dim vReportGroupName
Dim vDistArray(27,10)
Dim vHour
Dim vWeekDay
Dim i, j

Dim x, ConnDash, RS0,RS1, vErrorMsg

FontNameHead = "Arial"
FontSizeHead = "2"
FontNameData = "Times New Roman"
FontSizeData = "2"
FontNameHeadLog = "Arial"
FontSizeDataLog = "1.5"
FontNameDataLog = "Times New Roman"
FontSizeDataLog = "1.5"

Call FixQueryString(Request.QueryString("StartDate"), pvStartDate)
Call FixQueryString(Request.QueryString("EndDate"), pvEndDate)
pvUserOrgID = Request.QueryString("UserOrgID")
vStartInterval = Request.QueryString("StartInterval")
vEndInterval = Request.QueryString("EndInterval")
vDetailQuery = Request.QueryString("vDetailQuery")
vReportGroupID = Request.QueryString("ReportGroupID")%>

<!--#include virtual="/loginstatline/includes/Authorize.sls"-->

<%If AuthorizeMain Then%>

<!-- Begin Header -->
<TABLE Width="100%">
<TD VALIGN=TOP>
	<TABLE WIDTH = "100%">
	<TR>
		<TD WIDTH="10%"><IMG SRC="/loginstatline/images/logo1.gif" WIDTH=60 HEIGHT=60></TD>
		<TD WIDTH="50%" ALIGN=LEFT>
			<TABLE> 
				<TR><TD ALIGN=LEFT><FONT SIZE="5" FACE="Arial Black"><B>Call Hold Detail</TD></TR>
			</TABLE>
		</TD>
		<TD WIDTH="6%" VALIGN=CENTER><FONT SIZE="4" FACE="<%=FontNameHead%>"><B>Period:</TD>
		<TD WIDTH="14%" VALIGN=CENTER><FONT SIZE="3" FACE="<%=FontNameData%>"><%=pvStartDate%></TD>
		<TD WIDTH="6%" VALIGN=CENTER><FONT SIZE="4" FACE="<%=FontNameHead%>"><B>To:</TD>
		<TD WIDTH="14%" VALIGN=CENTER><FONT SIZE="3" FACE="<%=FontNameData%>"><%=pvEndDate%></TD>
	</TABLE>
</TD></TABLE>
<!-- End Header -->



<!-- Incoming Calls Section -->
<%
Set Conn = server.CreateObject("ADODB.Connection")
Conn.Open "DashData", DBUSER, DBPWD

'Get the report group name
If vDetailQuery = 3 Then

	vQuery = "sps_ReportGroupName " & vReportGroupID & " "

	Set RS = Conn.Execute(vQuery)

	vReportGroupName = RS("WebReportGroupName")

	Set RS = Nothing

End If


Select Case vDetailQuery
	Case 0
		vQuery = "sps_HoldTimesTop '" & pvStartDate & "', '" & pvEndDate & "', " & vStartInterval & ", " & vEndInterval & " "
	Case 1
		vQuery = "sps_HoldTimesTopPR '" & pvStartDate & "', '" & pvEndDate & "', " & vStartInterval & ", " & vEndInterval & " "
	Case 2
		vQuery = "sps_HoldTimesTopRegional '" & pvStartDate & "', '" & pvEndDate & "', " & vStartInterval & ", " & vEndInterval & ", " & pvUserOrgID & " "
	Case 3
		vQuery = "sps_HoldTimesTopReportGroup '" & pvStartDate & "', '" & pvEndDate & "', " & vStartInterval & ", " & vEndInterval & ", " & vReportGroupID & " "
End Select

Set RS = Conn.Execute(vQuery)

%>

	<P STYLE="line-height: 1pt">&nbsp</P>

	<!-- Incoming Calls Header -->
	<TABLE WIDTH="100%" BORDER=0>
	<%Select Case vDetailQuery
		Case 0%>
			<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial"><B> All Incoming Calls </B></FONT> </TD></TR>
		<%Case 1%>
			<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial"><B> Page Reponse Calls </B></FONT> </TD></TR>
		<%Case 2%>
			<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial"><B> Regional Incoming Calls </B></FONT> </TD></TR>
		<%Case 3%>
			<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial"><B> Report Group Incoming Calls </B></FONT> </TD></TR>
	<%End Select%>

	<%If vEndInterval <= 2.0167 Then%>
		<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial"><B> <%Response.Write(INT(vStartInterval * 60) & " - " & INT(vEndInterval * 60) - 1 & " Seconds ")%></B></FONT> </TD></TR>
	<%Else%>
		<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial"><B> <%Response.Write("> " & INT(vStartInterval * 60) - 1 & " Seconds ")%></B></FONT> </TD></TR>
	<%End If%>

	<%Select Case vDetailQuery
		Case 0%>
			<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial" SIZE="1"> (excludes page responses, all times MT) </FONT> </TD></TR>
		<%Case 1%>
			<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial" SIZE="1"> (all times MT) </FONT> </TD></TR>
		<%Case 2%>
			<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial" SIZE="1"> (all times MT) </FONT> </TD></TR>
		<%Case 3%>
			<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial" SIZE="1"> <%Response.Write(vReportGroupName & "  (all times MT)")%> </FONT> </TD></TR>
	<%End Select%>
	
	</Table>


	<TABLE WIDTH="65%">
	<TR>
		<TD ALIGN=LEFT WIDTH="5%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>#</TD></B>
		<TD ALIGN=LEFT WIDTH="18%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>Date/Time</TD></B>
		<TD ALIGN=LEFT WIDTH="12%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>Hold (sec)</TD></B>
		<TD ALIGN=LEFT WIDTH="20%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>Source Code</TD></B>
	</TR>

	<TR><TD></TD></TR>

<%If RS.EOF = True Then%>%>
	<TR>
		<TD ALIGN=LEFT WIDTH="50%"><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>"> There is no data available for the chosen date range. </TD>
	</TR>
	</TD></TR></TABLE>	

<%Else

	
	vCounter = 0 

	Do Until RS.EOF
		
		vCounter = vCounter + 1%>
		
		<TR>
			<TD ALIGN=LEFT WIDTH="5%"><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>"> <%=vCounter%> </TD>
			<TD ALIGN=LEFT WIDTH="20%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><%=RS("CallDateTime")%></TD>
			<TD ALIGN=LEFT WIDTH="10%"><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>"><%=INT(RS("HoldSeconds"))%></TD>
			<TD ALIGN=LEFT WIDTH="20%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><%=RS("CallSourceCode")%></TD>
		</TR>

		<%RS.MoveNext%>

	<%Loop 

End If

Set RS = Nothing
Set Conn = Nothing

%>
</TABLE>

</BODY>
</HTML>
<!--#include virtual="/loginstatline/includes/copyright.shm"-->

<%End If%>


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