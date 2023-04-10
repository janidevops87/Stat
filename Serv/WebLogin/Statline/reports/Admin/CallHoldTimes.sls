<% Option Explicit %>
<HTML>
<HEAD>
<TITLE>Call Hold Times</TITLE>
</HEAD>
<BODY BGCOLOR="#F5EBDD">

<!--#include virtual="/loginstatline/includes/Authorize.sls"-->
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
Dim vTotalIncomingCalls
Dim vTotalRegionalCalls
Dim vTotalPageCalls
Dim pvUserOrgID
Dim vReportGroupID
Dim vReportGroupName

Dim x, ConnDash, RS0,RS1, vErrorMsg, vTotalCalls

FontNameHead = "Arial"
FontSizeHead = "2"
FontNameData = "Times New Roman"
FontSizeData = "2"
FontNameHeadLog = "Arial"
FontSizeDataLog = "1.5"
FontNameDataLog = "Times New Roman"



Call FixQueryString(Request.QueryString("StartDate"), pvStartDate)
Call FixQueryString(Request.QueryString("EndDate"), pvEndDate)
pvUserOrgID = Request.QueryString("UserOrgID")
vReportGroupID = Request.QueryString("ReportGroupID")
%>


<%If AuthorizeMain Then%>

<!-- Begin Header -->
<TABLE Width="100%">
<TD VALIGN=TOP>
	<TABLE WIDTH = "100%">
	<TR>
		<TD WIDTH="10%"><IMG SRC="/loginstatline/images/logo1.gif" WIDTH=60 HEIGHT=60></TD>
		<TD WIDTH="50%" ALIGN=LEFT>
			<TABLE> 
				<TR><TD ALIGN=LEFT><FONT SIZE="5" FACE="Arial Black"><B>Call Hold Times</TD></TR>
			</TABLE>
		</TD>
		<TD WIDTH="6%" VALIGN=CENTER><FONT SIZE="4" FACE="<%=FontNameHead%>"><B>Period:</TD>
		<TD WIDTH="14%" VALIGN=CENTER><FONT SIZE="3" FACE="<%=FontNameData%>"><%=pvStartDate%></TD>
		<TD WIDTH="6%" VALIGN=CENTER><FONT SIZE="4" FACE="<%=FontNameHead%>"><B>To:</TD>
		<TD WIDTH="14%" VALIGN=CENTER><FONT SIZE="3" FACE="<%=FontNameData%>"><%=pvEndDate%></TD>
	</TABLE>
</TD></TABLE>
<BR></BR>
<!-- End Header -->



<!-- Incoming Calls Section -->
<%
'Open production data connection
Set Conn = server.CreateObject("ADODB.Connection")
Conn.Open DataSourceName, DBUSER, DBPWD

'Open the dash data connection
Set ConnDash = server.CreateObject("ADODB.Connection")
ConnDash.Open "DashData", DBUSER, DBPWD

vQuery = "sps_HoldTimesIncoming '" & pvStartDate & "', '" & pvEndDate & "' "
'Response.Write vQuery
Set RS = ConnDash.Execute(vQuery)

vTotalIncomingCalls = RS("Counts")
RS.MoveNext
%>

<TABLE WIDTH="100%" BORDER=0>
<TR>

	<TD VALIGN=TOP WIDTH="50%" ALIGN=LEFT>

	<!-- Incoming Calls Header -->
	<TABLE WIDTH="100%" BORDER=0>
	<TR><TD ALIGN=LEFT COLSPAN=3> <FONT FACE="Arial"><B> All Incoming Calls </B></FONT> </TD></TR>
	<TR><TD ALIGN=LEFT COLSPAN=3> <FONT FACE="Arial" SIZE="1"> (all regions, excluding page responses) </FONT> </TD></TR>
	<TR><TD WIDTH="100%">

		<TABLE WIDTH="90%" BORDER=0>
		<TR>
			<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>Hold Time (sec)</TD></B>
			<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>% Calls</TD></B>
			<%If pvUserOrgID = 194 Then%>
				<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B># Calls</TD></B>
			<%Else%>
				<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>&nbsp</TD></B>	
			<%End If%>
		</TR>

		<%If vTotalIncomingCalls = 0 Then%>

			<TR>
				<TD ALIGN=LEFT WIDTH="90%"><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>"> There is no data available for the chosen date range. </TD>
			</TR>

		<%Else
			Call ExecuteIncoming
		End If
		Set RS = Nothing
		%>

		</TABLE>
	</TD></TR>
	</TABLE>
	</TD>



	<TD VALIGN=TOP WIDTH="50%" ALIGN=LEFT>

		<!-- Regional Incoming Calls Section (only if not a Statline user)-->
		<%If pvUserOrgID <> 194 Then

			vQuery = "sps_HoldTimesIncomingRegional '" & pvStartDate & "', '" & pvEndDate & "', " & pvUserOrgID
			'Response.Write vQuery
			Set RS = ConnDash.Execute(vQuery)

			vTotalRegionalCalls = RS("Counts")
			RS.MoveNext
			%>

				<!-- Regional Header -->
				<TABLE WIDTH="100%" BORDER=0>
				<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial"><B>Regional Incoming Calls </FONT></TD></TR>
				<%'Get the user's organization name
				vQuery = "sps_OrganizationName " & pvUserOrgID
				'Response.Write vQuery
				Set RS0 = Conn.Execute(vQuery)
				If RS0.EOF <> True Then
				%>				
					<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial" SIZE="1"><%=RS0("OrganizationName")%></FONT> </TD></TR>
				<%Else%>
					<TR><TD><FONT FACE="Arial" SIZE="1">&nbsp</TD></TR>
				<%End If
				Set RS0 = Nothing
				%>					
				
				<TR><TD WIDTH="100%" VALIGN=TOP>
					<TABLE WIDTH="90%" BORDER=0>
					<TR>
						<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>Hold Time (sec)</TD></B>
						<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>% Calls</TD></B>
						<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B># Calls</TD></B>
					</TR>

					<%If vTotalRegionalCalls = 0 Then%>
						<TR>
							<TD ALIGN=LEFT WIDTH="90%"><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>"> There is no data available for the chosen date range. </TD>
						</TR>

					<%Else
						Call ExecuteIncomingRegional
					End If
					Set RS = Nothing
					%>

					</TABLE>
				</TD></TR>
				</TABLE>

		<%ElseIf pvUserOrgID = 194 And vReportGroupID <> 0 Then

			'Get the report group name
			vQuery = "sps_ReportGroupName " & vReportGroupID

			Set RS = ConnDash.Execute(vQuery)
			
			vReportGroupName = RS("WebReportGroupName")
			Set RS = Nothing


			'Get the data
			vQuery = "sps_HoldTimesIncomingReportGrp '" & pvStartDate & "', '" & pvEndDate & "', " & vReportGroupID
			'Response.Write vQuery
			Set RS = ConnDash.Execute(vQuery)

			vTotalRegionalCalls = RS("Counts")
			RS.MoveNext
			%>

				<!-- Regional Header -->
				<TABLE WIDTH="100%" BORDER=0>
				<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial"><B>Report Group Incoming Calls </FONT></TD></TR>
				<TR><TD><FONT FACE="Arial" SIZE="1"><%=vReportGroupName%></TD></TR>
				<TR><TD WIDTH="100%" VALIGN=TOP>
					<TABLE WIDTH="90%" BORDER=0>
					<TR>
						<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>Hold Time (sec)</TD></B>
						<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>% Calls</TD></B>
						<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B># Calls</TD></B>
					</TR>

					<%If vTotalRegionalCalls = 0 Then%>
						<TR>
							<TD ALIGN=LEFT WIDTH="90%"><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>"> There is no data available for the chosen date range. </TD>
						</TR>

					<%Else
						Call ExecuteIncomingRegional
					End If
					Set RS = Nothing
					%>

					</TABLE>
				</TD></TR>
				</TABLE>

		<%End If%>

	</TD>

</TR>
</TABLE>




<!-- Page Response Section -->
<%
vQuery = "sps_HoldTimesPR '" & pvStartDate & "', '" & pvEndDate & "' "

Set RS = ConnDash.Execute(vQuery)

vTotalPageCalls = RS("Counts")
RS.MoveNext
%>

	<!-- Page Response Header -->
	<TR><TD>&nbsp</TD></TR>
	<TABLE WIDTH="50%" BORDER=0>
	<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial"><B>Page Responses </FONT></TD></TR>
	<TR><TD WIDTH="100%">
	<TABLE WIDTH="90%">
	<TR>
		<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>Hold Time (sec)</TD></B>
		<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>% Calls</TD></B>
		<%If pvUserOrgID = 194 Then%>
			<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B># Calls</TD></B>
		<%Else%>
			<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>&nbsp</TD></B>		
		<%End If%>	
	</TR>
	<TR><TD></TD></TR>

<%If vTotalPageCalls = 0 Then%>
	<TR>
		<TD ALIGN=LEFT WIDTH="90%"><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>"> There is no data available for the chosen date range. </TD>
	</TR>
	</TD></TR></TABLE></TABLE>	

<%Else
	Call ExecutePR
End If
Set RS = Nothing
%>



<%If pvUserOrgID = 194 Then%>
<!-- Total Calls Section -->

	<%vTotalCalls = vTotalIncomingCalls + vTotalPageCalls

	If vTotalCalls = 0 Then%>

		<!-- Total Calls Header -->
		<TR><TD>&nbsp</TD></TR>
		<TABLE WIDTH="50%" BORDER=0>
		<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial"><B>Total Calls</FONT></TD></TR>
		<TR><TD WIDTH="100%">
		<TABLE WIDTH="90%">
		<TR>
			<TD ALIGN=LEFT WIDTH="90%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B># Calls</TD></B>
		</TR>
		<TR><TD></TD></TR>

		<TR>
			<TD ALIGN=LEFT WIDTH="90%"><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>"> There is no data available for the chosen date range. </TD>
		</TR>
		</TD></TR></TABLE></TABLE>	

	<%Else%>

		<!-- Total Calls Header -->
		<TR><TD>&nbsp</TD></TR>
		<TABLE WIDTH="50%" BORDER=0>
		<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial"><B>Total Calls</FONT></TD></TR>
		<TR><TD WIDTH="100%">
		<TABLE WIDTH="90%">
		<TR>
			<TD ALIGN=LEFT WIDTH="60%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>Total Incoming & Page Calls</TD></B>
			<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>">
				<a target="callholdtable" href="/loginstatline/reports/admin/callholdtable.sls?UserID=<%=Request.QueryString("UserID")%>&amp;ReportGroupID=<%=Request.QueryString("ReportGroupID")%>&amp;UserOrgID=<%=Request.QueryString("UserOrgID")%>&amp;DSN=<%=Request.QueryString("DSN")%>&amp;StartDate=<%=Request.QueryString("StartDate")%>&amp;EndDate=<%=Request.QueryString("EndDate")%>&amp;StartInterval=0&amp;EndInterval=0&amp;vDetailQuery=4"><%=vTotalCalls%></a>
			</TD>
		</TR>
		<TR><TD></TD></TR>

		</TR></TABLE></TABLE>	

	<%End If

End If

Set RS = Nothing
Set ConnDash = Nothing
Set Conn = Nothing

End If
%>

</BODY>
</HTML>
<!--#include virtual="/loginstatline/includes/copyright.shm"-->



<%Sub ExecuteIncoming()%>

	<TR>
		<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>"> 0 - 60 </TD>
				
		<%If pvUserOrgID = 194 Then%>	
			<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>">
			<a target="callholdlist" href="/loginstatline/reports/admin/callholdlist.sls?UserID=<%=Request.QueryString("UserID")%>&amp;UserOrgID=<%=Request.QueryString("UserOrgID")%>&amp;DSN=<%=Request.QueryString("DSN")%>&amp;StartDate=<%=Request.QueryString("StartDate")%>&amp;EndDate=<%=Request.QueryString("EndDate")%>&amp;StartInterval=0&amp;EndInterval=1.0167&amp;vDetailQuery=0"><%=ROUND(RS("Counts")/vTotalIncomingCalls * 100,1)%></a>
			</TD>
		<%Else%>
			<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>"><%=ROUND(RS("Counts")/vTotalIncomingCalls * 100,1)%></TD>
		<%End If%>			
		
		<%If pvUserOrgID = 194 Then%>
			<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>">
			<a target="callholdtable" href="/loginstatline/reports/admin/callholdtable.sls?UserID=<%=Request.QueryString("UserID")%>&amp;UserOrgID=<%=Request.QueryString("UserOrgID")%>&amp;DSN=<%=Request.QueryString("DSN")%>&amp;StartDate=<%=Request.QueryString("StartDate")%>&amp;EndDate=<%=Request.QueryString("EndDate")%>&amp;StartInterval=0&amp;EndInterval=1.0167&amp;vDetailQuery=0"><%=RS("Counts")%></a>
			</TD>
		<%End If%>		
		<%RS.MoveNext%>
	</TR>

	<TR>
		<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>"> 61 - 90 </TD>
		
		<%If pvUserOrgID = 194 Then%>
			<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>">
			<a target="callholdlist" href="/loginstatline/reports/admin/callholdlist.sls?UserID=<%=Request.QueryString("UserID")%>&amp;UserOrgID=<%=Request.QueryString("UserOrgID")%>&amp;DSN=<%=Request.QueryString("DSN")%>&amp;StartDate=<%=Request.QueryString("StartDate")%>&amp;EndDate=<%=Request.QueryString("EndDate")%>&amp;StartInterval=1.0167&amp;EndInterval=1.5167&amp;vDetailQuery=0"><%=ROUND(RS("Counts")/vTotalIncomingCalls * 100,1)%></a>
			</TD>
		<%Else%>
			<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>"><%=ROUND(RS("Counts")/vTotalIncomingCalls * 100,1)%></TD>
		<%End If%>	

		<%If pvUserOrgID = 194 Then%>
			<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>">
			<a target="callholdtable" href="/loginstatline/reports/admin/callholdtable.sls?UserID=<%=Request.QueryString("UserID")%>&amp;UserOrgID=<%=Request.QueryString("UserOrgID")%>&amp;DSN=<%=Request.QueryString("DSN")%>&amp;StartDate=<%=Request.QueryString("StartDate")%>&amp;EndDate=<%=Request.QueryString("EndDate")%>&amp;StartInterval=1.0167&amp;EndInterval=1.5167&amp;vDetailQuery=0"><%=RS("Counts")%></a>
			</TD>
		<%End If%>		
		<%RS.MoveNext%>
	</TR>

	<TR>
		<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>"> 91 - 120 </TD>
		
		<%If pvUserOrgID = 194 Then%>
			<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>">
			<a target="callholdlist" href="/loginstatline/reports/admin/callholdlist.sls?UserID=<%=Request.QueryString("UserID")%>&amp;UserOrgID=<%=Request.QueryString("UserOrgID")%>&amp;DSN=<%=Request.QueryString("DSN")%>&amp;StartDate=<%=Request.QueryString("StartDate")%>&amp;EndDate=<%=Request.QueryString("EndDate")%>&amp;StartInterval=1.5167&amp;EndInterval=2.0167&amp;vDetailQuery=0"><%=ROUND(RS("Counts")/vTotalIncomingCalls * 100,1)%></a>
			</TD>
		<%Else%>
			<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>"><%=ROUND(RS("Counts")/vTotalIncomingCalls * 100,1)%></TD>
		<%End If%>
		
		<%If pvUserOrgID = 194 Then%>
			<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>">
			<a target="callholdtable" href="/loginstatline/reports/admin/callholdtable.sls?UserID=<%=Request.QueryString("UserID")%>&amp;UserOrgID=<%=Request.QueryString("UserOrgID")%>&amp;DSN=<%=Request.QueryString("DSN")%>&amp;StartDate=<%=Request.QueryString("StartDate")%>&amp;EndDate=<%=Request.QueryString("EndDate")%>&amp;StartInterval=1.5167&amp;EndInterval=2.0167&amp;vDetailQuery=0"><%=RS("Counts")%></a>
			</TD>
		<%End If%>		
		<%RS.MoveNext%>
	</TR>

	<TR>
		<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>"> > 120 </TD>
		
		<%If pvUserOrgID = 194 Then%>
			<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>">
			<a target="callholdlist" href="/loginstatline/reports/admin/callholdlist.sls?UserID=<%=Request.QueryString("UserID")%>&amp;UserOrgID=<%=Request.QueryString("UserOrgID")%>&amp;DSN=<%=Request.QueryString("DSN")%>&amp;StartDate=<%=Request.QueryString("StartDate")%>&amp;EndDate=<%=Request.QueryString("EndDate")%>&amp;StartInterval=2.0167&amp;EndInterval=60&amp;vDetailQuery=0"><%=ROUND(RS("Counts")/vTotalIncomingCalls * 100,1)%></a>
			</TD>
		<%Else%>	
			<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>"><%=ROUND(RS("Counts")/vTotalIncomingCalls * 100,1)%></TD>		
		<%End If%>	

		<%If pvUserOrgID = 194 Then%>
			<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>">
			<a target="callholdtable" href="/loginstatline/reports/admin/callholdtable.sls?UserID=<%=Request.QueryString("UserID")%>&amp;UserOrgID=<%=Request.QueryString("UserOrgID")%>&amp;DSN=<%=Request.QueryString("DSN")%>&amp;StartDate=<%=Request.QueryString("StartDate")%>&amp;EndDate=<%=Request.QueryString("EndDate")%>&amp;StartInterval=2.0167&amp;EndInterval=60&amp;vDetailQuery=0"><%=RS("Counts")%></a>
			</TD>
		<%End If%>		
		<%RS.MoveNext%>	
	</TR>

	<TR>
		<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>"><B> Totals </B></TD>
		<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>"><B> 100%</B></TD>
		<%If pvUserOrgID = 194 Then%>
			<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B><%=vTotalIncomingCalls%></B></TD>
		<%End If%>
	</TR>
	
	<TR>
		<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>">Average Hold</TD>
		<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>"><%=INT(RS("Counts"))%> seconds</TD>
	</TR>	

<%End Sub%>



<%Sub ExecutePR()%>

	<TR>
		<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>"> 0 - 60 </TD>
		
		<%If pvUserOrgID = 194 Then%>
			<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>">
			<a target="callholdlist" href="/loginstatline/reports/admin/callholdlist.sls?UserID=<%=Request.QueryString("UserID")%>&amp;UserOrgID=<%=Request.QueryString("UserOrgID")%>&amp;DSN=<%=Request.QueryString("DSN")%>&amp;StartDate=<%=Request.QueryString("StartDate")%>&amp;EndDate=<%=Request.QueryString("EndDate")%>&amp;StartInterval=0&amp;EndInterval=1.0167&amp;vDetailQuery=1"><%=ROUND(RS("Counts")/vTotalPageCalls * 100,1)%></a>
			</TD>
		<%Else%>
			<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>"><%=ROUND(RS("Counts")/vTotalPageCalls * 100,1)%></TD>
		<%End If%>

		<%If pvUserOrgID = 194 Then%>
			<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>">
			<a target="callholdtable" href="/loginstatline/reports/admin/callholdtable.sls?UserID=<%=Request.QueryString("UserID")%>&amp;UserOrgID=<%=Request.QueryString("UserOrgID")%>&amp;DSN=<%=Request.QueryString("DSN")%>&amp;StartDate=<%=Request.QueryString("StartDate")%>&amp;EndDate=<%=Request.QueryString("EndDate")%>&amp;StartInterval=0&amp;EndInterval=1.0167&amp;vDetailQuery=1"><%=RS("Counts")%></a>
			</TD>
		<%End If%>	
		<%RS.MoveNext%>
	</TR>

	<TR>
		<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>"> 61 - 90 </TD>
		
		<%If pvUserOrgID = 194 Then%>
			<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>">
			<a target="callholdlist" href="/loginstatline/reports/admin/callholdlist.sls?UserID=<%=Request.QueryString("UserID")%>&amp;UserOrgID=<%=Request.QueryString("UserOrgID")%>&amp;DSN=<%=Request.QueryString("DSN")%>&amp;StartDate=<%=Request.QueryString("StartDate")%>&amp;EndDate=<%=Request.QueryString("EndDate")%>&amp;StartInterval=1.0167&amp;EndInterval=1.5167&amp;vDetailQuery=1"><%=ROUND(RS("Counts")/vTotalPageCalls * 100,1)%></a>
			</TD>
		<%Else%>
			<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>"><%=ROUND(RS("Counts")/vTotalPageCalls * 100,1)%></TD>
		<%End If%>
				
		<%If pvUserOrgID = 194 Then%>
			<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>">
			<a target="callholdtable" href="/loginstatline/reports/admin/callholdtable.sls?UserID=<%=Request.QueryString("UserID")%>&amp;UserOrgID=<%=Request.QueryString("UserOrgID")%>&amp;DSN=<%=Request.QueryString("DSN")%>&amp;StartDate=<%=Request.QueryString("StartDate")%>&amp;EndDate=<%=Request.QueryString("EndDate")%>&amp;StartInterval=1.0167&amp;EndInterval=1.5167&amp;vDetailQuery=1"><%=RS("Counts")%></a>
			</TD>
		<%End If%>			
		<%RS.MoveNext%>
	</TR>

	<TR>
		<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>"> 91 - 120 </TD>
		
		<%If pvUserOrgID = 194 Then%>
			<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>">
			<a target="callholdlist" href="/loginstatline/reports/admin/callholdlist.sls?UserID=<%=Request.QueryString("UserID")%>&amp;UserOrgID=<%=Request.QueryString("UserOrgID")%>&amp;DSN=<%=Request.QueryString("DSN")%>&amp;StartDate=<%=Request.QueryString("StartDate")%>&amp;EndDate=<%=Request.QueryString("EndDate")%>&amp;StartInterval=1.5167&amp;EndInterval=2.0167&amp;vDetailQuery=1"><%=ROUND(RS("Counts")/vTotalPageCalls * 100,1)%></a>
			</TD>
		<%Else%>
			<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>"><%=ROUND(RS("Counts")/vTotalPageCalls * 100,1)%></TD>
		<%End If%>	

		<%If pvUserOrgID = 194 Then%>
			<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>">
			<a target="callholdtable" href="/loginstatline/reports/admin/callholdtable.sls?UserID=<%=Request.QueryString("UserID")%>&amp;UserOrgID=<%=Request.QueryString("UserOrgID")%>&amp;DSN=<%=Request.QueryString("DSN")%>&amp;StartDate=<%=Request.QueryString("StartDate")%>&amp;EndDate=<%=Request.QueryString("EndDate")%>&amp;StartInterval=1.5167&amp;EndInterval=2.0167&amp;vDetailQuery=1"><%=RS("Counts")%></a>
			</TD>
		<%End If%>			
		<%RS.MoveNext%>
	</TR>

	<TR>
		<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>"> > 120 </TD>

		<%If pvUserOrgID = 194 Then%>
			<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>">
			<a target="callholdlist" href="/loginstatline/reports/admin/callholdlist.sls?UserID=<%=Request.QueryString("UserID")%>&amp;UserOrgID=<%=Request.QueryString("UserOrgID")%>&amp;DSN=<%=Request.QueryString("DSN")%>&amp;StartDate=<%=Request.QueryString("StartDate")%>&amp;EndDate=<%=Request.QueryString("EndDate")%>&amp;StartInterval=2.0167&amp;EndInterval=60&amp;vDetailQuery=1"><%=ROUND(RS("Counts")/vTotalPageCalls * 100,1)%></a>
			</TD>
		<%Else%>
			<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>"><%=ROUND(RS("Counts")/vTotalPageCalls * 100,1)%></TD>
		<%End If%>	

		<%If pvUserOrgID = 194 Then%>
			<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>">
			<a target="callholdtable" href="/loginstatline/reports/admin/callholdtable.sls?UserID=<%=Request.QueryString("UserID")%>&amp;UserOrgID=<%=Request.QueryString("UserOrgID")%>&amp;DSN=<%=Request.QueryString("DSN")%>&amp;StartDate=<%=Request.QueryString("StartDate")%>&amp;EndDate=<%=Request.QueryString("EndDate")%>&amp;StartInterval=2.0167&amp;EndInterval=60&amp;vDetailQuery=1"><%=RS("Counts")%></a>
			</TD>
		<%End If%>	
		<%RS.MoveNext%>	
	</TR>

	<TR>
		<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>"><B> Totals </TD></B>
		<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>"><B> 100%</TD></B>
		<%If pvUserOrgID = 194 Then%>
			<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B><%=vTotalPageCalls%></TD></B>
		<%End If%>	
	</TR>

	<TR>
		<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>">Average Hold</TD>
		<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>"><%=INT(RS("Counts"))%> seconds</TD>
	</TR>	
	
	</TD></TR></TABLE></TABLE>
	

<%End Sub%>



<%Sub ExecuteIncomingRegional()%>

	<TR>
		<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>"> 0 - 60 </TD>

		<TD ALIGN=LEFT WIDTH="20%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>">		
		<%If pvUserOrgID = 194 Then%>					
			<a target="callholdlist" href="/loginstatline/reports/admin/callholdlist.sls?UserID=<%=Request.QueryString("UserID")%>&amp;ReportGroupID=<%=Request.QueryString("ReportGroupID")%>&amp;UserOrgID=<%=Request.QueryString("UserOrgID")%>&amp;DSN=<%=Request.QueryString("DSN")%>&amp;StartDate=<%=Request.QueryString("StartDate")%>&amp;EndDate=<%=Request.QueryString("EndDate")%>&amp;StartInterval=0&amp;EndInterval=1.0167&amp;vDetailQuery=3"><%=ROUND(RS("Counts")/vTotalRegionalCalls * 100,1)%></a>
		<%Else%>
			<%=ROUND(RS("Counts")/vTotalRegionalCalls * 100,1)%></TD>
		<%End If%>
		</TD>		

		<TD ALIGN=LEFT WIDTH="20%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>">		
		<%If pvUserOrgID <> 194 Then%>		
			<a target="callholdlist" href="/loginstatline/reports/admin/callholdlist.sls?UserID=<%=Request.QueryString("UserID")%>&amp;ReportGroupID=<%=Request.QueryString("ReportGroupID")%>&amp;UserOrgID=<%=Request.QueryString("UserOrgID")%>&amp;DSN=<%=Request.QueryString("DSN")%>&amp;StartDate=<%=Request.QueryString("StartDate")%>&amp;EndDate=<%=Request.QueryString("EndDate")%>&amp;StartInterval=0&amp;EndInterval=1.0167&amp;vDetailQuery=2"><%=RS("Counts")%></a>
		<%Else%>
			<a target="callholdtable" href="/loginstatline/reports/admin/callholdtable.sls?UserID=<%=Request.QueryString("UserID")%>&amp;ReportGroupID=<%=Request.QueryString("ReportGroupID")%>&amp;UserOrgID=<%=Request.QueryString("UserOrgID")%>&amp;DSN=<%=Request.QueryString("DSN")%>&amp;StartDate=<%=Request.QueryString("StartDate")%>&amp;EndDate=<%=Request.QueryString("EndDate")%>&amp;StartInterval=0&amp;EndInterval=1.0167&amp;vDetailQuery=3"><%=RS("Counts")%></a>
		<%End If%>
		</TD>	
		<%RS.MoveNext%>
	</TR>

	<TR>
		<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>"> 61 - 90 </TD>
		<TD ALIGN=LEFT WIDTH="20%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>">
		<%If pvUserOrgID = 194 Then%>		
			<a target="callholdlist" href="/loginstatline/reports/admin/callholdlist.sls?UserID=<%=Request.QueryString("UserID")%>&amp;ReportGroupID=<%=Request.QueryString("ReportGroupID")%>&amp;UserOrgID=<%=Request.QueryString("UserOrgID")%>&amp;DSN=<%=Request.QueryString("DSN")%>&amp;StartDate=<%=Request.QueryString("StartDate")%>&amp;EndDate=<%=Request.QueryString("EndDate")%>&amp;StartInterval=1.0167&amp;EndInterval=1.5167&amp;vDetailQuery=3"><%=ROUND(RS("Counts")/vTotalRegionalCalls * 100,1)%></a>
		<%Else%>
			<%=ROUND(RS("Counts")/vTotalRegionalCalls * 100,1)%></TD>
		<%End If%>
		</TD>		

		<TD ALIGN=LEFT WIDTH="20%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>">
		<%If pvUserOrgID <> 194 Then%>		
			<a target="callholdlist" href="/loginstatline/reports/admin/callholdlist.sls?UserID=<%=Request.QueryString("UserID")%>&amp;ReportGroupID=<%=Request.QueryString("ReportGroupID")%>&amp;UserOrgID=<%=Request.QueryString("UserOrgID")%>&amp;DSN=<%=Request.QueryString("DSN")%>&amp;StartDate=<%=Request.QueryString("StartDate")%>&amp;EndDate=<%=Request.QueryString("EndDate")%>&amp;StartInterval=1.0167&amp;EndInterval=1.5167&amp;vDetailQuery=2"><%=RS("Counts")%></a>
		<%Else%>
			<a target="callholdtable" href="/loginstatline/reports/admin/callholdtable.sls?UserID=<%=Request.QueryString("UserID")%>&amp;ReportGroupID=<%=Request.QueryString("ReportGroupID")%>&amp;UserOrgID=<%=Request.QueryString("UserOrgID")%>&amp;DSN=<%=Request.QueryString("DSN")%>&amp;StartDate=<%=Request.QueryString("StartDate")%>&amp;EndDate=<%=Request.QueryString("EndDate")%>&amp;StartInterval=1.0167&amp;EndInterval=1.5167&amp;vDetailQuery=3"><%=RS("Counts")%></a>
		<%End If%>
		</TD>	
		<%RS.MoveNext%>
	</TR>

	<TR>
		<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>"> 91 - 120 </TD>
		<TD ALIGN=LEFT WIDTH="20%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>">
		<%If pvUserOrgID = 194 Then%>		
			<a target="callholdlist" href="/loginstatline/reports/admin/callholdlist.sls?UserID=<%=Request.QueryString("UserID")%>&amp;ReportGroupID=<%=Request.QueryString("ReportGroupID")%>&amp;UserOrgID=<%=Request.QueryString("UserOrgID")%>&amp;DSN=<%=Request.QueryString("DSN")%>&amp;StartDate=<%=Request.QueryString("StartDate")%>&amp;EndDate=<%=Request.QueryString("EndDate")%>&amp;StartInterval=1.5167&amp;EndInterval=2.0167&amp;vDetailQuery=3"><%=ROUND(RS("Counts")/vTotalRegionalCalls * 100,1)%></a>
		<%Else%>
			<%=ROUND(RS("Counts")/vTotalRegionalCalls * 100,1)%></TD>
		<%End If%>
		</TD>		

		<TD ALIGN=LEFT WIDTH="20%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>">
		<%If pvUserOrgID <> 194 Then%>		
			<a target="callholdlist" href="/loginstatline/reports/admin/callholdlist.sls?UserID=<%=Request.QueryString("UserID")%>&amp;ReportGroupID=<%=Request.QueryString("ReportGroupID")%>&amp;UserOrgID=<%=Request.QueryString("UserOrgID")%>&amp;DSN=<%=Request.QueryString("DSN")%>&amp;StartDate=<%=Request.QueryString("StartDate")%>&amp;EndDate=<%=Request.QueryString("EndDate")%>&amp;StartInterval=1.5167&amp;EndInterval=2.0167&amp;vDetailQuery=2"><%=RS("Counts")%></a>
		<%Else%>
			<a target="callholdtable" href="/loginstatline/reports/admin/callholdtable.sls?UserID=<%=Request.QueryString("UserID")%>&amp;ReportGroupID=<%=Request.QueryString("ReportGroupID")%>&amp;UserOrgID=<%=Request.QueryString("UserOrgID")%>&amp;DSN=<%=Request.QueryString("DSN")%>&amp;StartDate=<%=Request.QueryString("StartDate")%>&amp;EndDate=<%=Request.QueryString("EndDate")%>&amp;StartInterval=1.5167&amp;EndInterval=2.0167&amp;vDetailQuery=3"><%=RS("Counts")%></a>
		<%End If%>
		</TD>	
		<%RS.MoveNext%>
	</TR>

	<TR>
		<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>"> > 120 </TD>
		<TD ALIGN=LEFT WIDTH="20%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>">
		<%If pvUserOrgID = 194 Then%>		
			<a target="callholdlist" href="/loginstatline/reports/admin/callholdlist.sls?UserID=<%=Request.QueryString("UserID")%>&amp;ReportGroupID=<%=Request.QueryString("ReportGroupID")%>&amp;UserOrgID=<%=Request.QueryString("UserOrgID")%>&amp;DSN=<%=Request.QueryString("DSN")%>&amp;StartDate=<%=Request.QueryString("StartDate")%>&amp;EndDate=<%=Request.QueryString("EndDate")%>&amp;StartInterval=2.0167&amp;EndInterval=60&amp;vDetailQuery=3"><%=ROUND(RS("Counts")/vTotalRegionalCalls * 100,1)%></a>
		<%Else%>
			<%=ROUND(RS("Counts")/vTotalRegionalCalls * 100,1)%></TD>
		<%End If%>
		</TD>		

		<TD ALIGN=LEFT WIDTH="20%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>">
		<%If pvUserOrgID <> 194 Then%>		
			<a target="callholdlist" href="/loginstatline/reports/admin/callholdlist.sls?UserID=<%=Request.QueryString("UserID")%>&amp;ReportGroupID=<%=Request.QueryString("ReportGroupID")%>&amp;UserOrgID=<%=Request.QueryString("UserOrgID")%>&amp;DSN=<%=Request.QueryString("DSN")%>&amp;StartDate=<%=Request.QueryString("StartDate")%>&amp;EndDate=<%=Request.QueryString("EndDate")%>&amp;StartInterval=2.0167&amp;EndInterval=60&amp;vDetailQuery=2"><%=RS("Counts")%></a>
		<%Else%>
			<a target="callholdtable" href="/loginstatline/reports/admin/callholdtable.sls?UserID=<%=Request.QueryString("UserID")%>&amp;ReportGroupID=<%=Request.QueryString("ReportGroupID")%>&amp;UserOrgID=<%=Request.QueryString("UserOrgID")%>&amp;DSN=<%=Request.QueryString("DSN")%>&amp;StartDate=<%=Request.QueryString("StartDate")%>&amp;EndDate=<%=Request.QueryString("EndDate")%>&amp;StartInterval=2.0167&amp;EndInterval=60&amp;vDetailQuery=3"><%=RS("Counts")%></a>
		<%End If%>
		<%RS.MoveNext%>
		</TD>		
	</TR>

	<TR>
		<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>"><B> Totals </TD></B>
		<TD ALIGN=LEFT WIDTH="20%"><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>"><B> 100%</TD></B>
		<TD ALIGN=LEFT WIDTH="20%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>
		<a target="callholdtable" href="/loginstatline/reports/admin/callholdtable.sls?UserID=<%=Request.QueryString("UserID")%>&amp;ReportGroupID=<%=Request.QueryString("ReportGroupID")%>&amp;UserOrgID=<%=Request.QueryString("UserOrgID")%>&amp;DSN=<%=Request.QueryString("DSN")%>&amp;StartDate=<%=Request.QueryString("StartDate")%>&amp;EndDate=<%=Request.QueryString("EndDate")%>&amp;StartInterval=0&amp;EndInterval=120&amp;vDetailQuery=3">
		
		<%=vTotalRegionalCalls%></a>
		</TD></B>
	</TR>

	<TR>
		<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>">Average Hold</TD>
		<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>"><%=INT(RS("Counts"))%> seconds</TD>
	</TR>	
	
	</TD></TR></TABLE></TABLE>	
		

<%End Sub%>



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
