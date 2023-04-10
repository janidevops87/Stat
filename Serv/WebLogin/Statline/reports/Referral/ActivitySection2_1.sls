
<%If pvShowSection1 = False Then%>
	<html>

	<head>
	<title></title>
	</head>

	<body bgcolor="#F5EBDD">

	<img src="/loginstatline/images/redline.jpg" height="2" width="100%">
	
	<table border="0" width="100%" rules="NONE" frame="VOID">
	  <tr>
		<td colspan="6"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i>All Referrals</i></b></font></td>
	  </tr>
	  <tr>
		<td colspan="6"><hr align="CENTER" color="#000000" noshade size="1" width="100%">
		</td>
	  </tr>
	  <%if not vInsertBreaks then%>
		  <tr>
			<td width="3%"><b><u><font size="2">#</font></td>
			<td width="10%"><b><u><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>">Number</font></td>
			<td width="13%"><b><u><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>">Date/Time</font></td>
			<td width="35%"><b><u><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>">Referral Location</font></td>
			<td width="25%"><b><u><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>">Patient Name</font></td>
			<td width="14%"><b><u><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>">Sex/Age</font></td>
	  	</tr>
	  <%end if%>
	</table>
<%End If%>


<%TypeName = ""
For i = 0 to Ubound(ResultArray,2)

	If pvShowSection1 = True Then
		If ResultArray(12,i) <> TypeName Then

			TypeName = ResultArray(12,i)%>
			<html>

			<head>
			<title></title>
			</head>

			<body>

			<img src="/loginstatline/images/redline.jpg" height="2" width="100%">

			<table border="0" width="100%" rules="NONE" frame="VOID">

			  <tr>
				<td colspan="6"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i><%=TypeName%></i></b></font></td>
			  </tr>
			  <tr>
				<td colspan="6"><hr align="CENTER" color="#000000" noshade size="1" width="100%">
				</td>
			  </tr>
			  <tr>
				<td width="3%"><b><u><font size="2">#</font></td>
				<td width="10%"><b><u><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>">Number</font></td>
				<td width="13%"><b><u><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>">Date/Time</font></td>
				<td width="35%"><b><u><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>">Referral Location</font></td>
				<td width="25%"><b><u><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>">Patient Name</font></td>
				<td width="14%"><b><u><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>">Sex/Age</font></td>
			  </tr>
			</table>
		<%End If%>
	<%End If%>

<%
if vInsertBreaks and i = 0 then%>
	<font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><%=ResultArray(15,i)%></b></font>
	<img src="/loginstatline/images/redline.jpg" height="2" width="100%">	
	
	<table border="0" width="100%" rules="NONE" frame="VOID">
		<tr>
			<td width="3%"><b><u><font size="2">#</font></td>
			<td width="10%"><b><u><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>">Number</font></td>
			<td width="13%"><b><u><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>">Date/Time</font></td>
			<td width="35%"><b><u><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>">Referral Location</font></td>
			<td width="25%"><b><u><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>">Patient Name</font></td>
			<td width="14%"><b><u><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>">Sex/Age</font></td>
		</tr>
	</table>
<%end if

'drh 1/17/02 Add page break logic here
if vInsertBreaks and i > 0 then
	if ResultArray(15,i) <> vBreakValue then
		if not isEmpty(vBreakValue) then
			response.write("</H5>")
		end if
		
		vBreakValue = ResultArray(15,i)
		response.write("<H5>")%>
		<img src="/loginstatline/images/redline.jpg" height="2" width="100%">
		<font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><%=ResultArray(15,i)%></b></font>
		<img src="/loginstatline/images/redline.jpg" height="2" width="100%">
		
		<table border="0" width="100%" rules="NONE" frame="VOID">
			  <tr>
				<td width="3%"><b><u><font size="2">#</font></td>
				<td width="10%"><b><u><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>">Number</font></td>
				<td width="13%"><b><u><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>">Date/Time</font></td>
				<td width="35%"><b><u><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>">Referral Location</font></td>
				<td width="25%"><b><u><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>">Patient Name</font></td>
				<td width="14%"><b><u><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>">Sex/Age</font></td>
			  </tr>
		</table>
<%	end if
end if
  %>

<table border="0" width="100%" rules="NONE" frame="VOID">
  <tr>
    <th colspan="6" width="100%"></th>
  </tr>
  <tr>
    <td width="3%" valign="TOP" align="LEFT"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=(i+1)%></font></td>
    <td width="10%" valign="TOP" align="LEFT"><font size="<%=FontSizeData%>" face="<%=FontNameData%>">    
    <%' Changed links to access statWindow() javascript routine to pop up browser windows without tool or address bars.  The javascript file allowing this (statUtility.js) was included in Activity1.sls.  2/11/05 - SAP %>
    <a href=javascript:statWindow('ReferralDetail','/loginstatline/reports/referral/detail_1.sls?CallID=<%=ResultArray(1,i)%>&<%=Request.QueryString%>&NoLog=1&CountCheck=False')><%=ResultArray(2,i)%></a></font>
    </td>
    <td width="13%" valign="TOP" align="LEFT"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(4,i) & "  " & ResultArray(5,i)%></font></td>
    <td width="35%" valign="TOP" align="LEFT"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(15,i)%></font></td>
		<%'Determine how to display patient name.
		Dim vPatientName
		
		If pvNoName = 1 Then
			vPatientName = "Anonymous"
		Else
			If ResultArray(13,i) = "" And ResultArray(14,i) <> "" Then
				vPatientName = ResultArray(14,i)
			ElseIf ResultArray(14,i) = "" And ResultArray(13,i) <> "" Then
				vPatientName = ResultArray(13,i)
			ElseIf ResultArray(13,i) = "" And ResultArray(14,i) = "" Then
				vPatientName = "N/A"
			Else
				vPatientName = ResultArray(13,i) & ", " & ResultArray(14,i)
			End If
		End If%>
    <td width="25%" valign="TOP" align="LEFT"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=vPatientName%> </font></td>
    <td width="14%" valign="TOP" align="LEFT"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(8,i)%></font></td>
 
    <!--10/23/02 drh Add link to Audit-->
    <%if Request.QueryString("userOrgID") = 194 then%>
    <td width="10%" valign="TOP" align="LEFT"><font size="<%=FontSizeData%>" face="<%=FontNameData%>">
    <%' Changed links to access statWindow() javascript routine to pop up browser windows without tool or address bars.  The javascript file allowing this (statUtility.js) was included in Activity1.sls.  2/11/05 - SAP %>
    <a href=javascript:statWindow('ReferralAudit','/AuditReport/AuditReport.aspx?CallID=<%=ResultArray(1,i)%>&UserOrgId=<%=Request("UserOrgId")%>')>Audit</a></font></td>
    <%end if%>
  </tr>
</table>
<%
if i = Ubound(ResultArray,2) then
	response.write("</H5>")
end if
%>
<%Next%>
</u></b></u></b></u></b></u></b></u></b></u></b>
</body>
</html>
