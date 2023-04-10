<IMG SRC="/loginstatline/images/redline.jpg" HEIGHT=2 WIDTH="100%">

<TABLE BORDER=0 WIDTH="100%" RULES="NONE" FRAME="VOID">
<TH COLSPAN=4 WIDTH="100%"> </TH>

<%
Do Until RSCount.EOF
%>
	<TR>
		<TD WIDTH="20%"><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>"><B>Total Import Offers</B></TD>
		<TD WIDTH="30%"><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=RSCount("MessageTypeCount")%></TD>
	</TR>
<%	
	RSCount.MoveNext
	
Loop

Set RSCount = Nothing
%>
	
</TABLE>


