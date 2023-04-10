	<img src="/loginstatline/images/redline.jpg" height="2" width="100%">

	<table border="0" width="100%" rules="NONE" frame="VOID">
		<tr>
			<td ALIGN=LEFT VALIGN=TOP width="5%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><u>Name</b></u></font></td>
			<td ALIGN=LEFT VALIGN=TOP width="7%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><u>Start</b></u></font></td>
			<td ALIGN=LEFT VALIGN=TOP width="7%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><u>End</b></u></font></td>	
			<% 
			vSizeofRows = 81/Ubound(ScheduleArray,1)
			'Response.Write vSizeofRows
			FOR ForLoopColumnCounter = 5 to Ubound(ScheduleArray,1)
			
			%>
				<td ALIGN=LEFT VALIGN=TOP width="<%=vSizeofRows%>%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><u>On Call <% Response.Write (ForLoopColumnCounter-4) %></b></u></font></td>
			<%
			Next
			%>
			
		</tr>  	

			
<%


FOR ForLoopCounter = 0 to Ubound(ScheduleArray,2)
%>

	<tr> 
		
	    <td ALIGN=LEFT VALIGN=TOP ><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"><A	HREF="javascript:doNothing();"
					onclick="window.open('/loginstatline/forms/ScheduleUpdateForm.sls?ScheduleItemID=<%=ScheduleArray(0,ForLoopCounter)%>&amp;UserID=<%=Request.QueryString("UserID")%>&amp;UserOrgID=<%=Request.QueryString("UserOrgID")%>&amp;DSN=<%=Request.QueryString("DSN")%>&amp;ReportGroupID=<%=Request.QueryString("ReportGroupID")%>&amp;ScheduleGroupID=<%=pvScheduleGroupID%>','updateReferral','resizable,scrollbars');">
				
				 <%= ScheduleArray(2,ForLoopCounter) %></A></FONT></td>
	    <td ALIGN=LEFT VALIGN=TOP ><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"><%= FormatDateTime(ScheduleArray(3,ForLoopCounter),vbShortDate) & " " & FormatDateTime(ScheduleArray(3,ForLoopCounter),vbShortTime) & ", " & WeekDayName(WeekDay(ScheduleArray(3,ForLoopCounter)),True)%></FONT></td>	
	    <td ALIGN=LEFT VALIGN=TOP ><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"><%= FormatDateTime(ScheduleArray(4,ForLoopCounter),vbShortDate) & " " & FormatDateTime(ScheduleArray(4,ForLoopCounter),vbShortTime) & ", " & WeekDayName(WeekDay(ScheduleArray(4,ForLoopCounter)),True)%></FONT></td>
		<% 
		FOR ForLoopColumnCounter = 5 to Ubound(ScheduleArray,1)
		%>

		    <td ALIGN=LEFT VALIGN=TOP ><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"><%= ScheduleArray(ForLoopColumnCounter,ForLoopCounter)%></FONT></td>
		<%
		Next
		%>
		
	</tr>

<%
Next
%>
</table>
