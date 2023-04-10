
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
		<td width="25%"><b><u><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>">Patient Name</font></td>
		<td width="35%"><b><u><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>">Referral Location</font></td>
		<td width="14%"><b><u><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>">Sex/Age</font></td>
	  </tr>
	</table>
	
<%End If%>


<%MyType = ""
For i = 0 to Ubound(ResultArray,2)

	If pvShowSection1 = True Then
		If ResultArray(12,i) <> MyType Then

			MyType = ResultArray(12,i)%>
			<html>

			<head>
			<title></title>
			</head>

			<body>

			<img src="/loginstatline/images/redline.jpg" height="2" width="100%">

			<table border="0" width="100%" rules="NONE" frame="VOID">

			  <tr>
				<td colspan="6"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i><%=MyType%></i></b></font></td>
			  </tr>
			  <tr>
				<td colspan="6"><hr align="CENTER" color="#000000" noshade size="1" width="100%">
				</td>
			  </tr>
			  <tr>
				<td width="3%"><b><u><font size="2">#</font></td>
				<td width="10%"><b><u><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>">Number</font></td>
				<td width="13%"><b><u><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>">Date/Time</font></td>
				<td width="25%"><b><u><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>">Patient Name</font></td>
				<td width="35%"><b><u><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>">Referral Location</font></td>
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
    <td width="15%" valign="TOP" align="LEFT" nowrap><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><a target="Detail" 
    href="/loginstatline/reports/referral/detail_1.sls?CallID=<%=ResultArray(1,i)%>&<%=Request.QueryString%>&NoLog=1&CountCheck=False"><%=ResultArray(2,i)%></a></font></td>
    <td width="15%" valign="TOP" align="LEFT" nowrap><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(4,i) & "  " & ResultArray(5,i)%></font></td>
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
    <td width="25%" valign="TOP" align="LEFT" nowrap><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=vPatientName%> </font></td>
     <td width="27%" valign="TOP" align="LEFT" nowrap><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(15,i)%></font></td>
    <td width="14%" valign="TOP" align="LEFT" nowrap><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(8,i)%></font></td>
  </tr>
</table>
<%Next%>
</u></b></u></b></u></b></u></b></u></b></u></b>
</body>
</html>
