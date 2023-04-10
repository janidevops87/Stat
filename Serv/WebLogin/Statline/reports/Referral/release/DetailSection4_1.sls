<%	'00.0731 - Added MT not to Callout message description
	'only a temporary fix to the problem.
	'should update the query instead.
%>
<p></p>
<hr align="CENTER" color="#000000" noshade size="1" width="100%">

<table border="0" width="100%" rules="NONE" frame="VOID">
  <tr>
    <td colspan="6"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i>Event Log
    Information</i></b></font></td>
  </tr>
  <tr>
	<%'If UserOrgID = 194 Then%>
	    <td colspan="7"><hr align="CENTER" color="#000000" noshade size="1" width="100%">
		</td>
	<%'Else%>
	<!--    <td colspan="6"><hr align="CENTER" color="#000000" noshade size="1" width="100%">
		</td>
	-->
	<%'End If%>
  </tr>
  <tr>
    <td width="2%"><b><u><font size="2">#</font></td>
    <td align="LEFT" width="10%"><b><u><font size="<%=FontSizeHeadLog%>"
    face="<%=FontNameHeadLog%>">Date/Time</font></td>
    
    <%
    'If a Statline user is running the report, then add a column 
    'to display the name of the person who created the log item.
    'If UserOrgID = 194 Then%>
		<td align="LEFT" width="4%"><b><u><font size="<%=FontSizeHeadLog%>"
		face="<%=FontNameHeadLog%>">By</font></td> 
	<%'End If%>	    
    
    <td align="LEFT" width="12%"><b><u><font size="<%=FontSizeHeadLog%>"
    face="<%=FontNameHeadLog%>">Event Type</font></td>
    <td align="LEFT" width="22%"><b><u><font size="<%=FontSizeHeadLog%>"
    face="<%=FontNameHeadLog%>">Organization</font></td>
    <td align="LEFT" width="17%"><b><u><font size="<%=FontSizeHeadLog%>"
    face="<%=FontNameHeadLog%>">To/From</font></td>
	
	<%'If UserOrgID = 194 Then%>
	    <td align="LEFT" width="23%"><b><u><font size="<%=FontSizeHeadLog%>"
		face="<%=FontNameHeadLog%>">Description</font></td>
	<%'Else%>
	<!--    <td align="LEFT" width="27%"><b><u><font size="<%=FontSizeHeadLog%>"
		face="<%=FontNameHeadLog%>">Description</font></td>
	-->
	<%'End If%>
	
  </tr>
<%Redim Section4(0,0)

	SET ErrorCatch =  server.CreateObject("ADODB.Error")									
	'ErrorReturn = Referral.GetLog(Section4, ResultArray(i, 1), vTZ,DataSourceName)
	vQuery = "Sps_ReferralLogEvent " & ResultArray(1,i) & ", '" & vTZ & "'"
	'Response.Write vQuery
	Set RS = Conn.Execute(vQuery)
	
	vNoRecords = False
	
	If RS.EOF Then
		
		vNoRecords = True
		reDim Section4(5,0)
		Section4(0,0) = "No Log Events"
		for x = 1 to Ubound(Section4,2)
		Section4(x,0)=" "
		Next
	Else	
		Section4 = RS.GetRows
	
	End if	


	If  ErrorCatch.Number <> 0 AND ErrorReturn <> 100 Then


		vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
		vErrorMsg = vErrorMsg & "There has been a database error. <BR>"
		vErrorMsg = vErrorMsg & "Please click refresh to try your request again. <BR> <BR>"
		vErrorMsg = vErrorMsg & "If the problem continues, <BR>"
		vErrorMsg = vErrorMsg & "please contact Statline at (888) 881-7828 for assistance.</B> <BR> <BR> <BR>"
		vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
		vErrorMsg = vErrorMsg & "Error:     (" & ErrorReturn & ", Referral.GetLog, Detail.sls) <BR> <BR>"
		vErrorMsg = vErrorMsg & "</FONT></FONT>"
		Response.Write(vErrorMsg)
		'Exit For
	End If
		
	'Format each record
	Dim DateTime
	 
	For x = 0 To Ubound(Section4,2)%>
  <tr>
    <td align="LEFT" valign="TOP"><font size="<%=FontSizeDataLog%>"
    face="<%=FontNameDataLog%>"><%=(x+1)%></font></td>
	<td align="LEFT" valign="TOP"><font size="<%=FontSizeDataLog%>"
	face="<%=FontNameDataLog%>"><%=Section4(0,x)%></font></td>
	
    <%
    'If a Statline user is running the report, then add a column 
    'to display the name of the person who created the log item.
    'If UserOrgID = 194 Then%>
		<td align="LEFT" valign="TOP"><font size="<%=FontSizeDataLog%>"
		face="<%=FontNameDataLog%>"><%=Section4(5,x)%></font></td>    
	<%'End If%>	
	
    <td align="LEFT" valign="TOP"><font size="<%=FontSizeDataLog%>"
    face="<%=FontNameDataLog%>"><%=Section4(1,x)%></font></td>
    <td align="LEFT" valign="TOP"><font size="<%=FontSizeDataLog%>"
    face="<%=FontNameDataLog%>"><%=Section4(2,x)%></font></td>
    <td align="LEFT" valign="TOP"><font size="<%=FontSizeDataLog%>"
    face="<%=FontNameDataLog%>"><%=Section4(3,x)%></font></td>
    
<%	'00.0731 change%>
<%	If left(Section4(4,x),13) = "Callout after" then%>
		<td align="LEFT" valign="TOP"><font size="<%=FontSizeDataLog%>"
		face="<%=FontNameDataLog%>"><%=Section4(4,x)%>(MT)</font></td>
<%	Else%>
		<td align="LEFT" valign="TOP"><font size="<%=FontSizeDataLog%>"
		face="<%=FontNameDataLog%>"><%=Section4(4,x)%></font></td>
<%	End If%>
  </tr>
<% Next %>

</table>
</u></b></u></b></u></b></u></b></u></b></u></b>
