
<!-- Begin Header -->

	<TABLE WIDTH = "100%">
	<TR><TD WIDTH=75><IMG SRC="/loginstatline/images/logo1.gif" WIDTH=60 HEIGHT=60></TD>
		<TD WIDTH="50%" VALIGN=CENTER>
			<TABLE>
				<TR><TD><FONT SIZE="4" FACE="<%=FontNameHead%>"><B><%=vReportName%></B></TD></TR>
				<TR><TD><FONT SIZE="4" FACE="<%=FontNameHead%>"><B><%=vReportTitle%></B></TD></TR>
			</TABLE>
		</TD>
		<TD VALIGN=CENTER><FONT SIZE="2" FACE="<%=FontNameHead%>"><B>Period:&nbsp</B>
		<FONT SIZE="2" FACE="<%=FontNameData%>"><%=DateLiteral(pvStartDate)%>&nbsp&nbsp 
		<FONT SIZE="2" FACE="<%=FontNameHead%>"><B>Thru:&nbsp</B>
		<FONT SIZE="2" FACE="<%=FontNameData%>"><%=DateLiteral(pvEndDate)%>&nbsp&nbsp<BR>
		<FONT SIZE="1" FACE="<%=FontNameData%>">
			<% Response.Write("All Times " & ZoneName(vTZ))%>
		</TD></TR>
	</TABLE>

<!-- End Header -->

