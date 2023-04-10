	<img src="/loginstatline/images/redline.jpg" height="2" width="100%">

	<table border="0" width="100%" rules="NONE" frame="VOID">
		<tr>
			<td ALIGN=LEFT VALIGN=TOP width="3%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><u>#</b></u></font></td>
			<td ALIGN=LEFT VALIGN=TOP width="10%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><u>Number</b></u></font></td>
			<td ALIGN=LEFT VALIGN=TOP width="15%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><u>Date/Time</b></u></font></td>
			<td ALIGN=LEFT VALIGN=TOP width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><u>For</b></u></font></td>
			<td ALIGN=LEFT VALIGN=TOP width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><u>From</b></u></font></td>
			<td ALIGN=LEFT VALIGN=TOP width="31%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><u>Of</b></u></font></td>
		</tr>  	
	</table>

<table border="0" width="100%" rules="NONE" frame="VOID">
			
<%
AlertGroupName = ""

i = 1

Do Until RS.EOF = True	

	If RS("AlertGroupName") <> AlertGroupName Then
		AlertGroupName = RS("AlertGroupName")
	%>
		<tr>
			<td colspan="8"><hr align="CENTER" color="#000000" noshade size="1" width="100%"></td>
		</tr>	
		<tr>
			<td colspan="8"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i>
		    <a target="AlertGroup" href="/loginstatline/reports/admin/alertgroup.sls?AlertID=<%=RS("AlertID")%>"><%=RS("AlertGroupName")%></a></i></b></font></td>
		</tr>
	<%End If%>
		
	<tr>
		<td ALIGN=LEFT VALIGN=TOP width="3%"><font size="<%=FontSizeData%>"><%=i%></font></td>
	    <td ALIGN=LEFT VALIGN=TOP width="10%"><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>">
		  <a target="MessageDetail" href="/loginstatline/reports/import/detail.sls?CallID=<%=RS("CallID")%>&amp;UserID=<%=Request.QueryString("UserID")%>&amp;UserOrgID=<%=Request.QueryString("UserOrgID")%>&amp;DSN=<%=DataSourceName%>&amp;Options=0&NoLog=1&CountCheck=False"><%=RS("CallNumber")%></a></FONT></td>
	    <td ALIGN=LEFT VALIGN=TOP width="15%"><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"><%=FormatDateTime(RS("CallDateTime"), vbShortDate) & " " & FormatDateTime(RS("CallDateTime"), vbShortTime)%></FONT></td>
	    <td ALIGN=LEFT VALIGN=TOP width="20%"><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"><%=RS("PersonName")%></FONT></td>
	    <td ALIGN=LEFT VALIGN=TOP width="20%"><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"><%=RS("MessageCallerName")%></FONT></td>
	    <td ALIGN=LEFT VALIGN=TOP width="31%"><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"><%=RS("MessageCallerOrganization")%></FONT></td>
	</tr>

<%
	RS.MoveNext	
	i = i + 1
Loop
%>

</table>