<IMG SRC="/loginstatline/images/redline.jpg" HEIGHT=2 WIDTH="100%">

<TABLE BORDER=0 WIDTH="100%" RULES="NONE" FRAME="VOID">
<TH COLSPAN=4 WIDTH="100%"> </TH>

<%
Dim TotalCount

Do Until RSCount.EOF
%>
	<TR>
		<TD WIDTH="20%"><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>"><B><%=RSCount("MessageTypeName")%></B></TD>
		<TD WIDTH="30%"><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=RSCount("MessageTypeCount")%></TD>
	</TR>
<%	
	TotalCount = TotalCount + RSCount("MessageTypeCount")
	RSCount.MoveNext
	
Loop

Set RSCount = Nothing
%>

	<TR>
		<TD COLSPAN=4><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%"></TD>
	</TR>
	
	<TR>
		<TD WIDTH="20%"><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>"><B>Total: </B></TD>
		<TD WIDTH="30%"><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=TotalCount%></TD>
	</TR>
	
</TABLE>


