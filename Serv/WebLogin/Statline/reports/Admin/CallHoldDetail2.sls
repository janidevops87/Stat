<% Option Explicit %>
<HTML>
<HEAD>
<TITLE>Call Hold Distribution</TITLE>
</HEAD>
<BODY BGCOLOR="antiquewhite">
<%	
FontNameHead = "Arial"
FontSizeHead = "2"
FontNameData = "Times New Roman"
FontSizeData = "2"
FontNameHeadLog = "Arial"
FontSizeDataLog = "1.5"
FontNameDataLog = "Times New Roman"
FontSizeDataLog = "1.5"
	
Dim pvStartDate
Dim pvEndDate
Dim pvUserOrgID
Dim vStartInterval
Dim vEndInterval
Dim vCounter
Dim vDetailQuery
Dim vReportGroupID
Dim vDistArray(27,10)
Dim vHour
Dim vWeekDay
Dim i, j

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
		vQuery = "_sps_HoldTimesTop '" & pvStartDate & "', '" & pvEndDate & "', " & vStartInterval & ", " & vEndInterval & " "
	Case 1
		vQuery = "_sps_HoldTimesTopPR '" & pvStartDate & "', '" & pvEndDate & "', " & vStartInterval & ", " & vEndInterval & " "
	Case 2
		vQuery = "_sps_HoldTimesTopRegional '" & pvStartDate & "', '" & pvEndDate & "', " & vStartInterval & ", " & vEndInterval & ", " & pvUserOrgID & " "
	Case 3
		vQuery = "_sps_HoldTimesTopReportGroup '" & pvStartDate & "', '" & pvEndDate & "', " & vStartInterval & ", " & vEndInterval & ", " & vReportGroupID & " "
	Case 4
		vQuery = "_sps_HoldTimesTopAll '" & pvStartDate & "', '" & pvEndDate & "' "
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
		<%Case 4%>
			<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial"><B> All Incoming & Page Response Calls </B></FONT> </TD></TR>
	<%End Select%>

	<%If vDetailQuery <> 4 Then%>
		<%If vEndInterval <= 2.0167 Then%>
			<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial"><B> <%Response.Write(INT(vStartInterval * 60) & " - " & INT(vEndInterval * 60) - 1 & " Seconds ")%></B></FONT> </TD></TR>
		<%Else%>
			<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial"><B> <%Response.Write("> " & INT(vStartInterval * 60) - 1 & " Seconds ")%></B></FONT> </TD></TR>
		<%End If%>
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
		<%Case 4%>
			<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial" SIZE="1"> (all times MT) </FONT> </TD></TR>	
	<%End Select%>
	
	</Table>

<%If RS.EOF = True Then%>%>

	<P ALIGN=LEFT WIDTH="50%"><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>"> There is no data available for the chosen date range. </P>

<%Else
	
	For i = 0 to 27
		For j = 0 to 10
			vDistArray(i,j) = 0
		Next
	Next

	Do Until RS.EOF
		
		'Get the distribution values
		vHour = Hour(RS("CallDateTime"))
		vWeekDay = Weekday(RS("CallDateTime")) - 1
		
		vDistArray(vHour,vWeekDay) = vDistArray(vHour,vWeekDay) + 1

		RS.MoveNext

	Loop

	'Calculate weekday row totals
	For i = 0 to 23
		For j = 1 to 5
			vDistArray(i,7) = vDistArray(i,7) + vDistArray(i, j)
		Next 
	Next 

	'Calculate weekend row totals
	For i = 0 to 23
		vDistArray(i,9) = vDistArray(i,9) + vDistArray(i, 0) + vDistArray(i, 6)
	Next 

	'Calculate weekday column totals
	For j = 1 to 5
		For i = 0 to 23
			vDistArray(24, j) = vDistArray(24, j) + vDistArray(i, j)
		Next 
	Next 

	'Calculate weekend column totals
	For i = 0 to 23
		vDistArray(26, 0) = vDistArray(26, 0) + vDistArray(i, 0)
		vDistArray(26, 6) = vDistArray(26, 6) + vDistArray(i, 6)
	Next 

	'Calculate weekday grand total
	For j = 1 to 5
		vDistArray(24,7) = vDistArray(24,7) + vDistArray(24,j)
	Next 

	'Calculate weekend grand total
	vDistArray(26,9) = vDistArray(26,0) + vDistArray(26,6)


	'Calculate weekday row percentages
	For i = 0 to 23
		If vDistArray(24,7) <> 0 Then
			vDistArray(i, 8) = Round((vDistArray(i,7)/vDistArray(24,7) * 100),1)
		Else
			vDistArray(i, 8) = 0
		End If
	Next 

	'Calculate weekend row percentages
	For i = 0 to 23
		If vDistArray(26,9) <> 0 Then
			vDistArray(i, 10) = Round((vDistArray(i,9)/vDistArray(26,9) * 100),1)
		Else
			vDistArray(i, 10) = 0
		End If
	Next 

	'Calculate weekday column percentages
	For j = 1 to 5
		If vDistArray(24,7) <> 0 Then
			vDistArray(25, j) = Round((vDistArray(24,j)/vDistArray(24,7) * 100),1)
		Else
			vDistArray(25, j) = 0
		End If
	Next 

	'Calculate weekend column percentages
	If vDistArray(26,9) <> 0 Then
		vDistArray(27, 0) = Round((vDistArray(26,0)/vDistArray(26,9) * 100),1)
 	Else
		vDistArray(27, 0) = 0
	End If

	If vDistArray(26,9) <> 0 Then
		vDistArray(27, 6) = Round((vDistArray(26,6)/vDistArray(26,9) * 100),1)
	Else
		vDistArray(27, 6) = 0
	End If


	'Format Weekday Table%>

	<TABLE WIDTH="100%" BORDER=1>
		
		<!-- Format table header -->
		<TR> 
			<TD WIDTH="10%" VALIGN=LEFT><FONT FACE="Arial" SIZE=2><B> Hour/Day </B></FONT> </TD>
			<TD WIDTH="8%" ALIGN=CENTER><FONT FACE="Arial" SIZE=2><B> M </B></FONT> </TD>
			<TD WIDTH="8%" ALIGN=CENTER><FONT FACE="Arial" SIZE=2><B> T </B></FONT> </TD>
			<TD WIDTH="8%" ALIGN=CENTER><FONT FACE="Arial" SIZE=2><B> W </B></FONT> </TD>
			<TD WIDTH="8%" ALIGN=CENTER><FONT FACE="Arial" SIZE=2><B> R </B></FONT> </TD>
			<TD WIDTH="8%" ALIGN=CENTER><FONT FACE="Arial" SIZE=2><B> F </B></FONT> </TD>
			<TD WIDTH="8%" ALIGN=CENTER><FONT FACE="Arial" SIZE=2><B> Total </B></FONT> </TD>
			<TD WIDTH="8%" ALIGN=CENTER><FONT FACE="Arial" SIZE=2><B> % </B></FONT> </TD>
			<TD WIDTH="2%" ALIGN=CENTER><FONT FACE="Arial" SIZE=2><B>  </B></FONT> </TD>
			<TD WIDTH="8%" ALIGN=CENTER><FONT FACE="Arial" SIZE=2><B> Sat </B></FONT> </TD>
			<TD WIDTH="8%" ALIGN=CENTER><FONT FACE="Arial" SIZE=2><B> Sun </B></FONT> </TD>
			<TD WIDTH="8%" ALIGN=CENTER><FONT FACE="Arial" SIZE=2><B> Total </B></FONT> </TD>
			<TD WIDTH="8%" ALIGN=CENTER><FONT FACE="Arial" SIZE=2><B> % </B></FONT> </TD>
		</TR>
	
		<%For i = 0 to 23%>
			<TR> 
				<TD WIDTH="10%" VALIGN=LEFT><FONT FACE="Arial" SIZE=2><B> <%=i%> </B></FONT> </TD>
				<TD WIDTH="8%" ALIGN=CENTER><FONT FACE="Arial" SIZE=2> <%=vDistArray(i,1)%> </FONT> </TD>
				<TD WIDTH="8%" ALIGN=CENTER><FONT FACE="Arial" SIZE=2> <%=vDistArray(i,2)%> </FONT> </TD>
				<TD WIDTH="8%" ALIGN=CENTER><FONT FACE="Arial" SIZE=2> <%=vDistArray(i,3)%> </FONT> </TD>
				<TD WIDTH="8%" ALIGN=CENTER><FONT FACE="Arial" SIZE=2> <%=vDistArray(i,4)%> </FONT> </TD>
				<TD WIDTH="8%" ALIGN=CENTER><FONT FACE="Arial" SIZE=2> <%=vDistArray(i,5)%> </FONT> </TD>
				<TD WIDTH="8%" ALIGN=CENTER><FONT FACE="Arial" SIZE=2><B><%=vDistArray(i,7)%> </B></FONT> </TD>
				<TD WIDTH="8%" ALIGN=CENTER><FONT FACE="Arial" SIZE=2><B><%=vDistArray(i,8) & "%" %> </B></FONT> </TD>
				<TD WIDTH="2%" ALIGN=CENTER><FONT FACE="Arial" SIZE=2><B>  </B></FONT> </TD>
				<TD WIDTH="8%" ALIGN=CENTER><FONT FACE="Arial" SIZE=2> <%=vDistArray(i,6)%> </FONT> </TD>
				<TD WIDTH="8%" ALIGN=CENTER><FONT FACE="Arial" SIZE=2> <%=vDistArray(i,0)%> </FONT> </TD>
				<TD WIDTH="8%" ALIGN=CENTER><FONT FACE="Arial" SIZE=2><B><%=vDistArray(i,9)%> </B></FONT> </TD>
				<TD WIDTH="8%" ALIGN=CENTER><FONT FACE="Arial" SIZE=2><B><%=vDistArray(i,10) & "%" %> </B></FONT> </TD>
			</TR>
		<%Next%>

		<TR> 
			<TD WIDTH="10%" VALIGN=LEFT><FONT FACE="Arial" SIZE=2><B> Total </B></FONT> </TD>
			<TD WIDTH="8%" ALIGN=CENTER><FONT FACE="Arial" SIZE=2><B> <%=vDistArray(24,1)%> </B></FONT> </TD>
			<TD WIDTH="8%" ALIGN=CENTER><FONT FACE="Arial" SIZE=2><B> <%=vDistArray(24,2)%> </B></FONT> </TD>
			<TD WIDTH="8%" ALIGN=CENTER><FONT FACE="Arial" SIZE=2><B> <%=vDistArray(24,3)%> </B></FONT> </TD>
			<TD WIDTH="8%" ALIGN=CENTER><FONT FACE="Arial" SIZE=2><B> <%=vDistArray(24,4)%> </B></FONT> </TD>
			<TD WIDTH="8%" ALIGN=CENTER><FONT FACE="Arial" SIZE=2><B> <%=vDistArray(24,5)%> </B></FONT> </TD>
			<TD WIDTH="8%" ALIGN=CENTER><FONT FACE="Arial" SIZE=2><B> <%=vDistArray(24,7)%> </B></FONT> </TD>
			<TD WIDTH="8%" ALIGN=CENTER><FONT FACE="Arial" SIZE=2><B> - </B></FONT> </TD>
			<TD WIDTH="2%" ALIGN=CENTER><FONT FACE="Arial" SIZE=2><B>  </B></FONT> </TD>
			<TD WIDTH="8%" ALIGN=CENTER><FONT FACE="Arial" SIZE=2><B> <%=vDistArray(26,6)%> </B></FONT> </TD>
			<TD WIDTH="8%" ALIGN=CENTER><FONT FACE="Arial" SIZE=2><B> <%=vDistArray(26,0)%> </B></FONT> </TD>
			<TD WIDTH="8%" ALIGN=CENTER><FONT FACE="Arial" SIZE=2><B> <%=vDistArray(26,9)%> </B></FONT> </TD>
			<TD WIDTH="8%" ALIGN=CENTER><FONT FACE="Arial" SIZE=2><B> - </B></FONT> </TD>
		</TR>

		<TR> 
			<TD WIDTH="10%" VALIGN=LEFT><FONT FACE="Arial" SIZE=2><B> % </B></FONT> </TD>
			<TD WIDTH="8%" ALIGN=CENTER><FONT FACE="Arial" SIZE=2><B> <%=vDistArray(25,1) & "%" %> </B></FONT> </TD>
			<TD WIDTH="8%" ALIGN=CENTER><FONT FACE="Arial" SIZE=2><B> <%=vDistArray(25,2) & "%" %> </B></FONT> </TD>
			<TD WIDTH="8%" ALIGN=CENTER><FONT FACE="Arial" SIZE=2><B> <%=vDistArray(25,3) & "%" %> </B></FONT> </TD>
			<TD WIDTH="8%" ALIGN=CENTER><FONT FACE="Arial" SIZE=2><B> <%=vDistArray(25,4) & "%" %> </B></FONT> </TD>
			<TD WIDTH="8%" ALIGN=CENTER><FONT FACE="Arial" SIZE=2><B> <%=vDistArray(25,5) & "%" %> </B></FONT> </TD>
			<TD WIDTH="8%" ALIGN=CENTER><FONT FACE="Arial" SIZE=2><B> - </B></FONT> </TD>
			<TD WIDTH="8%" ALIGN=CENTER><FONT FACE="Arial" SIZE=2><B> 100% </B></FONT> </TD>
			<TD WIDTH="2%" ALIGN=CENTER><FONT FACE="Arial" SIZE=2><B>  </B></FONT> </TD>
			<TD WIDTH="8%" ALIGN=CENTER><FONT FACE="Arial" SIZE=2><B> <%=vDistArray(27,6) & "%" %> </B></FONT> </TD>
			<TD WIDTH="8%" ALIGN=CENTER><FONT FACE="Arial" SIZE=2><B> <%=vDistArray(27,0) & "%" %> </B></FONT> </TD>
			<TD WIDTH="8%" ALIGN=CENTER><FONT FACE="Arial" SIZE=2><B> - </B></FONT> </TD>
			<TD WIDTH="8%" ALIGN=CENTER><FONT FACE="Arial" SIZE=2><B> 100% </B></FONT> </TD>
		</TR>

	</Table>


<%End If

Set RS = Nothing
Set Conn = Nothing

%>

<%End If%>

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