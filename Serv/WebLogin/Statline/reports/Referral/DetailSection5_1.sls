

<!-- ------------------------------------------------------------------------------- -->
<!-- THIS IS AN INCLUDE THAT DOES THE CHECKING FOR WHETHER OR NOT TO DO A PAGE BREAK -->
<!-- ------------------------------------------------------------------------------- -->
<%

IF iPageRowCount > (iTempPageRowCount + 40) then
	iTempPageRowCount = iPageRowCount 'Reset the iPageRowCount variable to iPageRowCount for next page.
	%>
	
	
	dsafasd
	
	
	<TR><TD colspan='100'>&nbsp;</TD></TR><%'iPageRowCount = iPageRowCount + 1%>
	<TR><TD colspan='100'><!--#include virtual="/loginstatline/includes/copyright.shm"--></TD></TR>
	<TR><TD colspan='100'><UL></UL></TD></TR><%'iPageRowCount = iPageRowCount + 1%>

	<TR><TD colspan='100'><%'iPageRowCount = iPageRowCount + 1%>

		<TABLE border="0" width="100%">
			<TR>
			<TD align="Left">
			<Font size="2"><B>Patient SSN:&nbsp;&nbsp;<%'=ResultArray(123,i)%></B></font>
			</TD>
			<TD align="right">
			<font size="2"><B>Patient Name:&nbsp;&nbsp;<%'=vPatientName%></B></font>
			</TD>
			</TR>
		</TABLE>
		<hr align="CENTER" color="#000000" noshade size="1" width="100%">

	</TD></TR>

	<tr><%'iPageRowCount = iPageRowCount + 1%>
	    <td width="2%"><b><u><font size="2">#</font></td>
	    <td align="LEFT" width="10%"><b><u><font size="<%'=FontSizeHeadLog%>"
	    face="<%'=FontNameHeadLog%>">Date/Time</font></td>

	    <%
	    'If a Statline user is running the report, then add a column 
	    'to display the name of the person who created the log item.
	    'If UserOrgID = 194 Then%>
			<td align="LEFT" width="4%"><b><u><font size="<%'=FontSizeHeadLog%>"
			face="<%'=FontNameHeadLog%>">By</font></td>
		<%''End If%>	    

	    <td align="LEFT" width="12%"><b><u><font size="<%'=FontSizeHeadLog%>"
	    face="<%'=FontNameHeadLog%>">Event Type</font></td>
	    <td align="LEFT" width="22%"><b><u><font size="<%'=FontSizeHeadLog%>"
	    face="<%'=FontNameHeadLog%>">Organization</font></td>
	    <td align="LEFT" width="17%"><b><u><font size="<%'=FontSizeHeadLog%>"
	    face="<%'=FontNameHeadLog%>">To/From</font></td>

		<%''If UserOrgID = 194 Then%>
		    <td align="LEFT" width="23%"><b><u><font size="--><%'=FontSizeHeadLog%>"
			face="--><%'=FontNameHeadLog%>">Description</font></td>
		<%''End If%>
	</tr>

<%
End if
%>	
