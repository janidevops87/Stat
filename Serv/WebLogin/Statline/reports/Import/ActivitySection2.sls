<TABLE BORDER=0 WIDTH="100%" RULES="NONE" FRAME="VOID">
			
		<TR>
			<TD COLSPAN=6 WIDTH="100%">
			<IMG SRC="/loginstatline/images/redline.jpg" HEIGHT=2 WIDTH="100%"></TD>
		</TR>
		<TR>
			<TD>&nbsp</TD>
		</TR>
		<TR>
			<TD WIDTH="4%"><B><U><FONT SIZE=2>#</TD>
			<TD WIDTH="10%"><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">Number</TD>
			<TD WIDTH="15%"><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">Date/Time</TD>
			<TD WIDTH="20%"><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">For</TD>
			<TD WIDTH="20%"><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">From</TD>
			<TD WIDTH="31%"><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">Of</TD>
		</TR>
					
<%
i = 1

Do Until RS.EOF = True	
	%>

		<TR>
			<TD VALIGN=TOP><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=i%></TD>
			<TD VALIGN=TOP><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><A target="ImportDetail" HREF="/loginstatline/reports/import/detail.sls?CallID=<%=RS("CallID")%>&<%=Request.QueryString%>&NoLog=1"><%=RS("CallNumber")%></A></TD>
			<TD VALIGN=TOP><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=FormatDateTime(RS("CallDateTime"), vbShortDate) & " " & FormatDateTime(RS("CallDateTime"), vbShortTime)%></TD>
			<TD VALIGN=TOP><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=RS("PersonName")%></TD>
			<TD VALIGN=TOP><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=RS("MessageCallerName")%></TD>
			<TD VALIGN=TOP NOWRAP=NOWRAP><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=RS("MessageCallerOrganization")%></TD>
		</TR>

<%
	RS.MoveNext
	i = i + 1
	
Loop
%>

</TABLE>

	
