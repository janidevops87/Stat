
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


<%TypeName = ""
For i = 0 to Ubound(ResultArray,1)

	If pvShowSection1 = True Then
		If ResultArray(i,12) <> TypeName Then

			TypeName = ResultArray(i,12)%>
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

<table border="0" width="100%" rules="NONE" frame="VOID">
  <tr>
    <th colspan="6" width="100%"></th>
  </tr>
  <tr>
    <td width="3%" valign="TOP" align="LEFT"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=(i+1)%></font></td>
    <td width="10%" valign="TOP" align="LEFT"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><a target="ReferralDetail" 
    href="/loginstatline/reports/referral/detail.sls?CallID=<%=ResultArray(i,1)%>&<%=Request.QueryString%>&NoLog=1&CountCheck=False"><%=ResultArray(i,2)%></a></font></td>
    <td width="13%" valign="TOP" align="LEFT"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(i,4) & "  " & ResultArray(i,5)%></font></td>
    <td width="35%" valign="TOP" align="LEFT"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(i,15)%></font></td>
		<%'Determine how to display patient name.
		Dim vPatientName
		
		If pvNoName = 1 Then
			vPatientName = "Anonymous"
		Else
			If ResultArray(i,13) = "" And ResultArray(i,14) <> "" Then
				vPatientName = ResultArray(i,14)
			ElseIf ResultArray(i,14) = "" And ResultArray(i,13) <> "" Then
				vPatientName = ResultArray(i,13)
			ElseIf ResultArray(i,13) = "" And ResultArray(i,14) = "" Then
				vPatientName = "N/A"
			Else
				vPatientName = ResultArray(i,13) & ", " & ResultArray(i,14)
			End If
		End If%>
    <td width="25%" valign="TOP" align="LEFT"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=vPatientName%> </font></td>
    <td width="14%" valign="TOP" align="LEFT"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(i,8)%></font></td>
  </tr>
</table>
<%Next%>
</u></b></u></b></u></b></u></b></u></b></u></b>
</body>
</html>
