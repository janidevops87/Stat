<!-- Begin Totals -->
	<TABLE BORDER=0 WIDTH="100%" RULES="NONE" FRAME="VOID">
	<TH WIDTH="100%"> </TH>
	<TR><TD><IMG SRC="/loginstatline/images/redline.jpg" HEIGHT=2 WIDTH="100%"></TD></TR>
	<TR><TD><B><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">Totals</B></TD></TR>
	<TR><TD><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%"></TD></TR>
	</TABLE>
	<TABLE>
		<% For x=0 To Ubound(pvTotals,1) - 1 %>
		<TR>
			<TD Width=150><FONT SIZE="<%=FontSizeDataLog%>" FACE="<%=FontNameDataLog%>"><B><%=pvTotals(x,1)%></TD>
			<TD Width=50 ALIGN=Right><FONT SIZE="<%=FontSizeDataLog%>" FACE="<%=FontNameDataLog%>"><B><%=pvTotals(x,2)%>%</TD>
			<TD Width=25 ALIGN=Left><FONT SIZE="<%=FontSizeDataLog%>" FACE="<%=FontNameDataLog%>"><B>&nbsp</TD>
			<TD Width=50 ALIGN=Left><FONT SIZE="<%=FontSizeDataLog%>" FACE="<%=FontNameDataLog%>"><B><%=pvTotals(x,3)%></TD>
		</TR>

		<% Next %>
		<TR><TD COLSPAN=4><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%"></TD></TR>
		<TR>
			<TD Width=150><FONT SIZE="<%=FontSizeDataLog%>" FACE="<%=FontNameDataLog%>"><B><I>Total Referrals</I></TD>
			<TD Width=50 ALIGN=Right><FONT SIZE="<%=FontSizeDataLog%>" FACE="<%=FontNameDataLog%>"><B><%=pvTotals(x,2)%>%</TD>
			<TD Width=25 ALIGN=Left><FONT SIZE="<%=FontSizeDataLog%>" FACE="<%=FontNameDataLog%>"><B>&nbsp</TD>
			<TD Width=50 ALIGN=Left><FONT SIZE="<%=FontSizeDataLog%>" FACE="<%=FontNameDataLog%>"><B><%=pvTotals(x,3)%></TD>
		</TR>
	</TABLE>
<!-- End Totals -->
