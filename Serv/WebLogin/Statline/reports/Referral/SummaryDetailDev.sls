<% Option Explicit %>
<%If vShowGroup1 = False Then
	TypeName = "All Referrals"
	LastOrganization = ResultArray(i, 15)%>
	<html>

	<head>
	<title></title>
	</head>

	<body bgcolor="#F5EBDD">

	<p><img src="/loginstatline/images/redline.jpg" height="2" width="100%"> </p>

	<table border="0" width="100%" rules="NONE" frame="VOID">
	  <tr>
		<td><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i><%=TypeName%></i></b></font></td>
	  </tr>
	  <tr>
		<td><hr align="CENTER" color="#000000" noshade size="1" width="100%">
		</td>
	  </tr>
	</table>

	<table border="0" width="100%" rules="NONE" frame="VOID">
	  <tr>
		<td width="4%" valign="TOP"><b><u><font size="<%=FontSizeDataLog%>"
		face="<%=FontNameHeadLog%>">#</font></td>
		<td width="10%" valign="TOP"><b><u><font size="<%=FontSizeDataLog%>"
		face="<%=FontNameHeadLog%>">Call Date</font></td>
		<td width="38%" valign="TOP"><b><u><font size="<%=FontSizeDataLog%>"
		face="<%=FontNameHeadLog%>">Referral Info</font></td>
		<td width="48%"><table border="0" width="100%">
		  <tr>
			<td width="4%"></td>
			<td width="16%"><b><u><font size="<%=FontSizeDataLog%>" face="<%=FontNameHeadLog%>">Organs</font></td>
			<td width="16%"><b><u><font size="<%=FontSizeDataLog%>" face="<%=FontNameHeadLog%>">Bone</font></td>
			<td width="16%"><b><u><font size="<%=FontSizeDataLog%>" face="<%=FontNameHeadLog%>">Tissue</font></td>
			<td width="16%"><b><u><font size="<%=FontSizeDataLog%>" face="<%=FontNameHeadLog%>">Skin</font></td>
			<td width="16%"><b><u><font size="<%=FontSizeDataLog%>" face="<%=FontNameHeadLog%>">Valves</font></td>
			<td width="16%"><b><u><font size="<%=FontSizeDataLog%>" face="<%=FontNameHeadLog%>">Eyes</font></td>
		  </tr>
		</table>
		</td>
	  </tr>
	</table>
<%End If%>

<%TypeName = ""
For i = 0 to Ubound(ResultArray,1)
	
	If vShowGroup1 = True Then
		If ResultArray(i,12) <> TypeName Then

			TypeName = ResultArray(i,12)%>
			<html>

			<head>
			<title></title>
			</head>

			<body>

			<p><img src="/loginstatline/images/redline.jpg" height="2" width="100%"> </p>

			<table border="0" width="100%" rules="NONE" frame="VOID">
			  <tr>
				<td><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i><%=TypeName%></i></b></font></td>
			  </tr>
			  <tr>
				<td><hr align="CENTER" color="#000000" noshade size="1" width="100%">
				</td>
			  </tr>
			</table>

			<table border="0" width="100%" rules="NONE" frame="VOID">
			  <tr>
				<td width="4%" valign="TOP"><b><u><font size="<%=FontSizeDataLog%>"
				face="<%=FontNameHeadLog%>">#</font></td>
				<td width="10%" valign="TOP"><b><u><font size="<%=FontSizeDataLog%>"
				face="<%=FontNameHeadLog%>">Call Date</font></td>
				<td width="38%" valign="TOP"><b><u><font size="<%=FontSizeDataLog%>"
				face="<%=FontNameHeadLog%>">Referral Info</font></td>
				<td width="48%"><table border="0" width="100%">
				  <tr>
					<td width="4%"></td>
					<td width="16%"><b><u><font size="<%=FontSizeDataLog%>" face="<%=FontNameHeadLog%>">Organs</font></td>
					<td width="16%"><b><u><font size="<%=FontSizeDataLog%>" face="<%=FontNameHeadLog%>">Bone</font></td>
					<td width="16%"><b><u><font size="<%=FontSizeDataLog%>" face="<%=FontNameHeadLog%>">Tissue</font></td>
					<td width="16%"><b><u><font size="<%=FontSizeDataLog%>" face="<%=FontNameHeadLog%>">Skin</font></td>
					<td width="16%"><b><u><font size="<%=FontSizeDataLog%>" face="<%=FontNameHeadLog%>">Valves</font></td>
					<td width="16%"><b><u><font size="<%=FontSizeDataLog%>" face="<%=FontNameHeadLog%>">Eyes</font></td>
				  </tr>
				</table>
				</td>
			  </tr>
			</table>
		<%End If%>
	<%End If%>


	<table border="0" width="100%" rules="NONE">
	  <tr>
		<th colspan="4" width="100%"></th>
	  </tr>
	  <tr>
		<td width="4%" valign="TOP"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=i+1%></font></td>
		<td width="10%" valign="TOP"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(i,4) & " " & ResultArray(i,5)%>
		<p><a
		href="/loginstatline/reports/referral/detail.sls?CallID=<%=ResultArray(i,1)%>&amp;Token=<%=Request.QueryString("Token")%>&amp;UserID=<%=Request.QueryString("UserID")%>&amp;Lic=<%=Request.QueryString("Lic")%>&amp;UserOrgID=<%=Request.QueryString("UserOrgID")%>&amp;DSN=<%=Request.QueryString("DSN")%>&amp;Options=<%=Request.QueryString("Options")%>"><%=ResultArray(i,2)%></a>
		</font></td>

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
					vPatientName = ResultArray(i,14) & " " & ResultArray(i,13)
				End If
			End If%>  
	
		<td width="38%" valign="TOP"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(i,15)%>
	<%If ResultArray(i,19) <> "" Then Response.Write(", " & ResultArray(i,19) & " " & ResultArray(i,20))%>    <br>
	<%Response.Write(ResultArray(i,16) & " " & ResultArray(i,17))%>    <br>
	<%If ResultArray(i,36) <> "" Then Response.Write(ResultArray(i,36)) Else Response.Write("Not Approached") End If%><%If ResultArray(i,38) <> "" Then Response.Write(", " & ResultArray(i,37) & " " & ResultArray(i,38)) End If%>    <br>
	<%Response.Write(vPatientName)%>    , <%=ResultArray(i,26)%>, <%Response.Write(ResultArray(i,24) & " " & ResultArray(i,25))%>, <%=ResultArray(i,34)%><br>
	<%=ResultArray(i,35)%><%If ResultArray(i,31) <> "" Then Response.Write(", " & ResultArray(i,31) & " " & ResultArray(i,32))%>    </font></td>
	<!-- Begin Options Grid -->
		<td width="48%" valign="TOP"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><table
		border="0" width="100%" rules="NONE" frame="VOID">
		  <tr>
			<th colspan="7" width="100%"></th>
	<!-- Appropriate Row -->
		  </tr>
		  <tr>
			<td width="4%"><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>"><b>A</b></font></td>
			<td width="16%"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(i,47)%></font></td>
			<td width="16%"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(i,51)%></font></td>
			<td width="16%"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(i,55)%></font></td>
			<td width="16%"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(i,59)%></font></td>
			<td width="16%"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(i,63)%></font></td>
			<td width="16%"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(i,67)%></font></td>
		  </tr>
	<!-- Approach Row -->
		  <tr>
			<td width="4%"><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>"><b>A</b></font></td>
			<td width="16%"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(i,48)%></font></td>
			<td width="16%"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(i,52)%></font></td>
			<td width="16%"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(i,56)%></font></td>
			<td width="16%"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(i,60)%></font></td>
			<td width="16%"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(i,64)%></font></td>
			<td width="16%"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(i,68)%></font></td>
		  </tr>
	<!-- Consent Row -->
		  <tr>
			<td width="4%"><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>"><b>C</b></font></td>
			<td width="16%"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(i,49)%></font></td>
			<td width="16%"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(i,53)%></font></td>
			<td width="16%"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(i,57)%></font></td>
			<td width="16%"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(i,61)%></font></td>
			<td width="16%"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(i,65)%></font></td>
			<td width="16%"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(i,69)%></font></td>
		  </tr>
	<!-- Recovery Row -->
		  <tr>
			<td width="4%"><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>"><b>R</b></font></td>
			<td width="16%"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(i,50)%></font></td>
			<td width="16%"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(i,54)%></font></td>
			<td width="16%"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(i,58)%></font></td>
			<td width="16%"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(i,62)%></font></td>
			<td width="16%"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(i,66)%></font></td>
			<td width="16%"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(i,70)%></font></td>
		  </tr>
		  <tr>
			<td><font size="1"></font></td>
			<td></td>
			<td></td>
			<td></font></td>
		  </tr>
		</table>
		</td>
	<!-- End Options Grid -->
	  </tr>
	  <tr>
		<td colspan="4">
		
		<%If LastOrganization <> ResultArray(i, 15) Then%>
			<H5>Test<hr align="CENTER" color="black" noshade size="1" width="100%"></H5>
		<%Else%>
			<hr align="CENTER" color="black" noshade size="1" width="100%">
		<%End If%>		
		
		</td>
	  </tr>
	</table>
	
	<%LastOrganization = ResultArray(i, 15)%>
	
<%Next%>


<!-- Begin Legend -->

<p><img src="/loginstatline/images/redline.jpg" height="2" width="100%"> </p>

<table border="0" width="100%" rules="NONE" frame="VOID">
  <tr>
    <td colspan="4"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i>Legend</i></b></font></td>
  </tr>
  <tr>
    <td colspan="4"><hr align="CENTER" color="#000000" noshade size="1" width="100%">
    </td>
  </tr>
  <tr>
    <td width="4%" valign="TOP"><b><u><font size="<%=FontSizeDataLog%>"
    face="<%=FontNameHeadLog%>">#</font></td>
    <td width="10%" valign="TOP"><b><u><font size="<%=FontSizeDataLog%>"
    face="<%=FontNameHeadLog%>">Call Date</font></td>
    <td width="39%" valign="TOP"><b><u><font size="<%=FontSizeDataLog%>"
    face="<%=FontNameHeadLog%>">Referral Info</font></td>
    <td width="47%"></td>
  </tr>
  <tr>
    <td valign="TOP" align="LEFT"><font size="<%=FontSizeDataLog%>"
    face="<%=FontNameDataLog%>">#</font></td>
    <td valign="TOP" align="LEFT"><font size="<%=FontSizeDataLog%>"
    face="<%=FontNameDataLog%>">Referral Date<p>Referral Number</font></td>
    <td valign="TOP" align="LEFT"><font size="<%=FontSizeDataLog%>"
    face="<%=FontNameDataLog%>">Referring Hospital, Referring Unit<br>
    Referring Person<br>
    Approach Method, Approach Person<br>
    Patient Name, Gender, Age, Race<br>
    Cause Of Death, Date/Time of Death</font></td>
    <td valign="TOP" align="LEFT"><font size="<%=FontSizeDataLog%>"
    face="<%=FontNameDataLog%>">A - Appropriate options at time of Referral with available
    information. If other than 'Yes', then this field is the reason the option was not
    appropriate.<br>
    A - Approached. If other than 'Yes', then this field is the reason approach was not made.<br>
    C - Consented. If other than 'Yes', then this field is the reason consent was not
    obtained.<br>
    R - Recovered. If Other than 'Yes', then this field is the reason for non-recovery.</font></td>
  </tr>
  <tr>
    <td colspan="4"><hr align="CENTER" color="#000000" noshade size="1" width="100%">
    </td>
  </tr>
</table>
<!-- End Legend -->
</u></b></u></b></u></b></u></b></u></b></u></b></u></b></u></b></u></b></u></b></u></b></u></b>
</body>
</html>
