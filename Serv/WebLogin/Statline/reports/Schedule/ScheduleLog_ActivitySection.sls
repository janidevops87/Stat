	<%
	'ResultArray Contents from sps_GetScheduleLog
	'LogDate                     
	'PersonName                                                                                            
	'OrganizationName                                                                 
	'ScheduleLogType      
	'ScheduleLogShift                                                                 
	'ScheduleLogChange                                                                                                                                                                                        
	%>
	<img src="/loginstatline/images/redline.jpg" height="2" width="100%">

	<table border="0" width="100%" rules="NONE" frame="VOID">
		<tr>
			<td ALIGN=LEFT VALIGN=TOP width="9%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><u>LogDate</b></u></font></td>
			<td ALIGN=LEFT VALIGN=TOP width="11%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><u>Person Name</b></u></font></td>
			<td ALIGN=LEFT VALIGN=TOP width="11%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><u>Organization</b></u></font></td>	
			<td ALIGN=LEFT VALIGN=TOP width="11%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><u>Change Type</b></u></font></td>
			<td ALIGN=LEFT VALIGN=TOP width="24%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><u>Shift Modified</b></u></font></td>
			<td ALIGN=LEFT VALIGN=TOP width="30%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><u>Change Description</b></u></font></td>
 		</tr>  	

			
<%


FOR ForLoopCounter = 0 to Ubound(ResultsArray,2)
%>

	<tr>
		
	    <td ALIGN=LEFT VALIGN=TOP ><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"><%= FormatDateTime(ResultsArray(0,ForLoopCounter),vbShortDate) & " " & FormatDateTime(ResultsArray(0,ForLoopCounter),vbShortTime)	%></FONT></td>
		<td ALIGN=LEFT VALIGN=TOP ><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"> <%= ResultsArray(1,ForLoopCounter) %></FONT></td>
		<td ALIGN=LEFT VALIGN=TOP ><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"> <%= ResultsArray(2,ForLoopCounter) %></FONT></td>
		<td ALIGN=LEFT VALIGN=TOP ><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"> <%= ResultsArray(3,ForLoopCounter) %></FONT></td>
		<td ALIGN=LEFT VALIGN=TOP ><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"> <%= ResultsArray(4,ForLoopCounter) %></FONT></td>
		<td ALIGN=LEFT VALIGN=TOP ><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"> <%= ResultsArray(5,ForLoopCounter) %></FONT></td>
	</tr>

<%
Next
%>
</table>

