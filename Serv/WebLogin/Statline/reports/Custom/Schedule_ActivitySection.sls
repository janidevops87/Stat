	<img src="/loginstatline/images/redline.jpg" height="2" width="100%">

	<table border="0" width="100%" rules="NONE" frame="VOID">
		<tr>
			<td ALIGN=LEFT VALIGN=TOP width="4%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><u>Name</b></u></font></td>
			<td ALIGN=LEFT VALIGN=TOP width="7%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><u>Start</b></u></font></td>
			<td ALIGN=LEFT VALIGN=TOP width="7%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><u>End</b></u></font></td>	
			<% 
			
			vSizeofRows = 82/Ubound(ScheduleArray,1) -4 
			'Response.Write vSizeofRows
			FOR ForLoopColumnCounter = 5 to Ubound(ScheduleArray,1)
			
			%>
				<td ALIGN=LEFT VALIGN=TOP width="<%=vSizeofRows%>%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><u>Person <% Response.Write (ForLoopColumnCounter-4) %></b></u></font></td>
			<%
			Next
			%>
			
		</tr>  	
		
<%
FOR ForLoopCounter = 0 to Ubound(ScheduleArray,2)
%>

	<tr>
		
	    <td ALIGN=LEFT VALIGN=TOP ><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"> <%= ScheduleArray(2,ForLoopCounter) %></FONT></td>
	    <td ALIGN=LEFT VALIGN=TOP ><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"><%= ScheduleArray(3,ForLoopCounter)	%></FONT></td>	
	    <td ALIGN=LEFT VALIGN=TOP ><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"><%= ScheduleArray(4,ForLoopCounter)	%></FONT></td>
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

