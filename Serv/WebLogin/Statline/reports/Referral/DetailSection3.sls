<%
'Check if there are any values to display

Dim z
Dim ShowSection

ShowSection = False

For z = 36 to 50

	'Response.Write("Value:  ResultArray(" & i & "," & z & ") = " & ResultArray(i,z) & "<BR>")

	If ResultArray(i,z) <> "" Then
		ShowSection = True
	End If

Next

If ShowSection Then%>
<p></p>
<hr align="CENTER" color="#000000" noshade size="1" width="100%">

<table border="0" width="100%" rules="ALL">

  <tr>
    <td colspan="2"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i>Additional
    Information</i></b></font></td>
  </tr>

  <tr>
    <td colspan="2"><hr align="CENTER" color="#000000" noshade size="1" width="100%">
    </td>
  </tr>

<%'Check if there are any approach values 
	If ResultArray(i,36) <> "" Then%>
	  <tr valign="TOP">
		<td width="35%" valign="TOP"><table border="0" width="100%" rules="All">
		  <tr>
			<td width="40%"><b><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>">Approach
			Method:</font></td>
			<td width="60%"></b><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(i,36)%></font></td>
		  </tr>
		</table>
		</td>
		<%If ResultArray(i,37) <> "" OR ResultArray(i,38) <> "" Then %>	
			<td width="65%"><table border="0" width="100%" rules="All" valign="TOP" align="LEFT">
			  <tr>
				<td width="20%" valign="TOP" align="LEFT"><b><font align="LEFT"
				size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>">Approached By:</font></td>
				<td valign="TOP" align="LEFT" width="80%"></b><font size="<%=FontSizeDataLog%>"
				face="<%=FontNameDataLog%>"><%=ResultArray(i,37) & " " & ResultArray(i,38)%></font></td>
			  </tr>
			</table>
			</td>
	<%End If%>
  </tr>

  <%If ResultArray(i,80) <> "" Then %>
	  <tr valign="TOP">
		<td width="35%" valign="TOP"><table border="0" width="100%" rules="All">
		  <tr>
			<td width="40%"><b><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>">General
			Consent:</font></td>

			<%'Determine if an extension should be displayed
			Dim vGeneralConsent

			If ResultArray(i,80) = "1" Then 
				vGeneralConsent = "Yes - Written"
			ElseIf ResultArray(i,80) = "2" Then
				vGeneralConsent = "Yes - Verbal"
			ElseIf ResultArray(i,80) = "3" Then
				vGeneralConsent = "No"
			Else
				vGeneralConsent = ""
			End If%>

			<td width="60%"></b><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=vGeneralConsent%></font></td>
		  </tr>
		</table>
		</td>
		<td width="65%"><table border="0" width="100%" rules="All" valign="TOP" align="LEFT">
		  <tr>
			<td width="20%" valign="TOP" align="LEFT"><b><font align="LEFT"
			size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>"></font></td>
			<td valign="TOP" align="LEFT" width="80%"></b><font size="<%=FontSizeDataLog%>"
			face="<%=FontNameDataLog%>"></font></td>
		  </tr>
		</table>
		</td>
	  </tr>
  <%End If%>

<%End If %>

	<%'Check if there are any NOK values 
	If ResultArray(i,39) <> "" OR ResultArray(i,40) <> "" OR ResultArray(i,41) <> "" OR ResultArray(i,42) <> "" Then %>
	  <tr valign="TOP">
		<td width="35%" valign="TOP"><table border="0" width="100%" rules="All">
		  <tr>
			<td width="40%"><b><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>">Next Of
			Kin:</font></td>
			<td width="60%"></b><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(i,39)%></font></td>
		  </tr>
		  <tr>
			<td width="40%"><b><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>">Relation:</font></td>
			<td width="60%"></b><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(i,40)%></font></td>
		  </tr>
		  <tr>
			<td width="40%"><b><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>">Phone:</font></td>
			<td width="60%"></b><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(i,41)%></font></td>
		  </tr>
		</table>
		</td>
		<td width="65%"><table border="0" width="100%" rules="All" valign="TOP">
		  <tr>
			<td width="20%" valign="TOP"><b><font size="<%=FontSizeHeadLog%>"
			face="<%=FontNameHeadLog%>">Address:</font></td>
			<td valign="TOP" width="80%"></b><font size="<%=FontSizeDataLog%>"
			face="<%=FontNameDataLog%>"><%Call OutputMemo(ResultArray(i,42))%></font></td>
		  </tr>
		</table>
		</td>
	  </tr>
	<%End If %>

	<%'Check if there are any Coroner values
	If ResultArray(i,43) <> "" OR ResultArray(i,44) <> "" OR ResultArray(i,45) <> "" OR ResultArray(i,46) <> "" Then %>
	  <tr valign="TOP">
		<td width="35%" valign="TOP"><table border="0" width="100%" rules="All">
		  <tr>
			<td width="40%"><b><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>">Coroner/ME:</font></td>
			<td width="60%"></b><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(i,43)%></font></td>
		  </tr>
		  <tr>
			<td width="40%"><b><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>">Office:</font></td>
			<td width="60%"></b><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(i,44)%></font></td>
		  </tr>
		  <tr>
			<td width="40%"><b><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>">Phone:</font></td>
			<td width="60%"></b><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(i,45)%></font></td>
		  </tr>
		</table>
		</td>
		<td width="65%" valign="TOP"><table border="0" width="100%" rules="All">
		  <tr>
			<td width="20%" valign="TOP"><b><font size="<%=FontSizeHeadLog%>"
			face="<%=FontNameHeadLog%>">Note:</font></td>
			<td valign="TOP" width="80%"></b><font size="<%=FontSizeDataLog%>"
			face="<%=FontNameDataLog%>"><%Call OutputMemo(ResultArray(i,46))%></font></td>
		  </tr>
		</table>
		</td>
	  </tr>
	<% End If %>

	<%'Check if there is an attending
	If ResultArray(i,47) <> "" OR ResultArray(i,48) <> "" Then %>
	  <tr valign="TOP">
		<td width="35%" valign="TOP"><table border="0" width="100%" rules="All">
		  <tr>
			<td width="40%"><b><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>">Attending:</font></td>
			<td></b><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(i,47) & " " & ResultArray(i,48)%></font></td>
		  </tr>
		</table>
		</td>
	  </tr>
	<%End If%>

	<%'Check if there is an pronouncing
	If ResultArray(i,49) <> "" OR ResultArray(i,50) <> "" Then %>
	  <tr valign="TOP">
		<td width="35%" valign="TOP"><table border="0" width="100%" rules="All">
		  <tr>
			<td width="40%"><b><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>">Pronouncing:</font></td>
			<td></b><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(i,49) & " " & ResultArray(i,50)%></font></td>
		  </tr>
		</table>
		</td>
	  </tr>
	<%End If%>

	<%'Check if there are approach minutes
	If ResultArray(i,81) <> "0" And ResultArray(i,81) <> "" Then %>
	  <tr valign="TOP">
		<td width="35%" valign="TOP"><table border="0" width="100%" rules="All">
		  <tr>
			<td width="40%"><b><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>">Time to contact NOK (min.):</font></td>
			<td></b><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(i,81)%></font></td>
		  </tr>
		</table>
		</td>
	  </tr>
	<%End If%>

	<%'Check if there are consent minutes
	If ResultArray(i,82) <> "0" And ResultArray(i,82) <> "" Then %>
	  <tr valign="TOP">
		<td width="35%" valign="TOP"><table border="0" width="100%" rules="All">
		  <tr>
			<td width="40%"><b><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>">Length of consent conversation (min.):</font></td>
			<td></b><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(i,82)%></font></td>
		  </tr>
		</table>
		</td>
	  </tr>
	<%End If%>

</table>
<% End If%>

