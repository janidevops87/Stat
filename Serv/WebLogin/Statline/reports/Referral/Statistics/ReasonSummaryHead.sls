
<!-- Begin Header -->
<!-- Include any files here  -->

<!--#include virtual="/loginstatline/includes/TimeZoneProcess.vbs"-->

	<TABLE WIDTH = "100%">
	<TR><TD WIDTH=75><IMG SRC="/loginstatline/images/logo1.gif" WIDTH=60 HEIGHT=60></TD>
		<TD WIDTH="50%" VALIGN=CENTER>
			<TABLE>
				<TR><TD><FONT SIZE="5" FACE="Arial Black"><B>Referral Statistics</TD></TR>
				<TR><TD><FONT SIZE="4" FACE="<%=FontNameHead%>"><B>Reason Summary</B></TD></TR>
				<TR><TD><FONT SIZE="4" FACE="<%=FontNameHead%>"><B><%=vReportTitle%></B></TD></TR>
			</TABLE>
		</TD>
		<TD VALIGN=CENTER><FONT SIZE="4" FACE="<%=FontNameHead%>"><B>Period:&nbsp &nbsp </B>
		<FONT SIZE="3" FACE="<%=FontNameData%>"><%=pvStartDate%>&nbsp &nbsp 
		<FONT SIZE="4" FACE="<%=FontNameHead%>"><B>To:&nbsp &nbsp </B>
		<FONT SIZE="3" FACE="<%=FontNameData%>"><%=pvEndDate%>&nbsp &nbsp <BR>
		<FONT SIZE="3" FACE="<%=FontNameData%>">
			<% Response.Write("All Times " & ZoneName(vTZ))%>
		</TD></TR>

	</TABLE>

<!-- End Header -->
