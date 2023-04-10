<html>

<body bgcolor="#F5EBDD">

<table border="0" width="100%" rules="NONE" frame="VOID">
  <tr>
    <td width="2%"><b><u><font size="2">#</font></td>
    <td align="LEFT" width="10%"><b><u><font size="<%=FontSizeHeadLog%>"
    face="<%=FontNameHeadLog%>">Date/Time</font></td>
    
    <%
    'If a Statline user is running the report, then add a column 
    'to display the name of the person who created the log item.
    'If pvUserOrg = 194 Then%>
		<td align="LEFT" width="4%"><b><u><font size="<%=FontSizeHeadLog%>"
		face="<%=FontNameHeadLog%>">By</font></td> 
	<%'End If%>	  
	    
    <td align="LEFT" width="12%"><b><u><font size="<%=FontSizeHeadLog%>"
    face="<%=FontNameHeadLog%>">Event Type</font></td>
    <td align="LEFT" width="22%"><b><u><font size="<%=FontSizeHeadLog%>"
    face="<%=FontNameHeadLog%>">Organization</font></td>
    <td align="LEFT" width="17%"><b><u><font size="<%=FontSizeHeadLog%>"
    face="<%=FontNameHeadLog%>">To/From</font></td>
	
	<%'If pvUserOrg = 194 Then%>
	    <td align="LEFT" width="23%"><b><u><font size="<%=FontSizeHeadLog%>"
		face="<%=FontNameHeadLog%>">Description</font></td>
	<%'Else%>
	<!--    <td align="LEFT" width="27%"><b><u><font size="<%=FontSizeHeadLog%>"
		face="<%=FontNameHeadLog%>">Description</font></td>
	-->
	<%'End If%>
	
	</tr>
<% For x = 0 To Ubound(Section2,2)%>
<% DateTime = Mid(Section2(0,x),6,2) + "/" + Mid(Section2(0,x),9,2) + "/" + Mid(Section2(0,x),3,2) + " " + Mid(Section2(0,x), 12, 5) %>
  <tr>
    <td align="LEFT" valign="TOP"><font size="<%=FontSizeDataLog%>"
    face="<%=FontNameDataLog%>">
    <%
    'ccarroll 06/28/2007 StatTrac 8.4 Release added for compatibility
    If IsNull(Section2(5,x)) Then
	Response.write(x+1) 
    Else
    	Response.write(Section2(5,x))
    End If
    
    %></font></td>
    <td align="LEFT" valign="TOP"><font size="<%=FontSizeDataLog%>"
    face="<%=FontNameDataLog%>"><%=Section2(0,x)%></font></td>
    
    <%
    'If a Statline user is running the report, then add a column 
    'to display the name of the person who created the log item.
    'If pvUserOrg = 194 Then%>
		<td align="LEFT" valign="TOP"><font size="<%=FontSizeDataLog%>"
		face="<%=FontNameDataLog%>"><%=Section2(5,x)%></font></td>    
	<%'End If%>	
	    
    <td align="LEFT" valign="TOP"><font size="<%=FontSizeDataLog%>"
    face="<%=FontNameDataLog%>"><%=Section2(1,x)%></font></td>
    <td align="LEFT" valign="TOP"><font size="<%=FontSizeDataLog%>"
    face="<%=FontNameDataLog%>"><%=Section2(2,x)%></font></td>
    <td align="LEFT" valign="TOP"><font size="<%=FontSizeDataLog%>"
    face="<%=FontNameDataLog%>"><%=Section2(3,x)%></font></td>
    <td align="LEFT" valign="TOP"><font size="<%=FontSizeDataLog%>"
    face="<%=FontNameDataLog%>"><%=Section2(4,x)%></font></td>
  </tr>
<% Next %>
</table>
</u></b></u></b></u></b></u></b></u></b></u></b>
</body>
</html>
