<%
'03/22/2006 - Carroll, Christopher: StatTrac 8.0 Changes per Requirement Specifications:
'  - 4.7.2.3 Display both Attending and Pronouncing Physician Phone Numbers



'Check if there are any values to display

Dim z
Dim ShowSection

ShowSection = False

For z = 36 to 50

	'Response.Write("Value:  ResultArray(" & i & "," & z & ") = " & ResultArray(i,z) & "<BR>")

	If ResultArray(z,i) <> "" Then
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
	If ResultArray(36,i) <> "" Then%>
	  <tr valign="TOP">
		<td width="35%" valign="TOP"><table border="0" width="100%" rules="All">
		  <tr>
			<td width="40%"><b><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>">Approach
			Method:</font></td>
			<td width="60%"></b><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(36,i)%></font></td>
		  </tr>
		</table>
		</td>
		<%If ResultArray(37,i) <> "" OR ResultArray(38,i) <> "" Then %>	
			<td width="65%"><table border="0" width="100%" rules="All" valign="TOP" align="LEFT">
			  <tr>
				<td width="20%" valign="TOP" align="LEFT"><b><font align="LEFT"
				size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>">Approached By:</font></td>
				<td valign="TOP" align="LEFT" width="80%"></b><font size="<%=FontSizeDataLog%>"
				face="<%=FontNameDataLog%>"><%=ResultArray(37,i) & " " & ResultArray(38,i)%></font></td>
			  </tr>
			</table>
			</td>
	<%End If%>
  </tr>

  <%If ResultArray(80,i) <> "" Then %>
	  <tr valign="TOP">
		<td width="35%" valign="TOP"><table border="0" width="100%" rules="All">
		  <tr>
			<td width="40%"><b><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>">General
			Consent:</font></td>

			<%'Determine if an extension should be displayed
			Dim vGeneralConsent

			If ResultArray(80,i) = "1" Then 
				vGeneralConsent = "Yes - Written"
			ElseIf ResultArray(80,i) = "2" Then
				vGeneralConsent = "Yes - Verbal"
			ElseIf ResultArray(80,i) = "3" Then
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
	If ResultArray(39,i) <> "" OR ResultArray(40,i) <> "" OR ResultArray(41,i) <> "" OR ResultArray(42,i) <> "" Then %>
	  <tr valign="TOP">
		<td width="35%" valign="TOP"><table border="0" width="100%" rules="All">
		  <tr>
			<td width="40%"><b><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>">Next Of
			Kin:</font></td>
			<td width="60%"></b><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(39,i)%></font></td>
		  </tr>
		  <tr>
			<td width="40%"><b><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>">Relation:</font></td>
			<td width="60%"></b><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(40,i)%></font></td>
		  </tr>
		  <tr>
			<td width="40%"><b><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>">Phone:</font></td>
			<td width="60%"></b><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(41,i)%></font></td>
		  </tr>
		</table>
		</td>
		<td width="65%"><table border="0" width="100%" rules="All" valign="TOP">
		  <tr>
			<td width="20%" valign="TOP"><b><font size="<%=FontSizeHeadLog%>"
			face="<%=FontNameHeadLog%>">Address:</font></td>
			<td valign="TOP" width="80%"></b><font size="<%=FontSizeDataLog%>"
			face="<%=FontNameDataLog%>"><%Call OutputMemo(ResultArray(42,i))%></font></td>
		  </tr>
		</table>
		</td>
	  </tr>
	<%End If %>

	<%'Check if there are any Coroner values
	If ResultArray(43,i) <> "" OR ResultArray(44,i) <> "" OR ResultArray(45,i) <> "" OR ResultArray(46,i) <> "" Then %>
	  <tr valign="TOP">
		<td width="35%" valign="TOP"><table border="0" width="100%" rules="All">
		  <tr>
			<td width="40%"><b><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>">Coroner/ME:</font></td>
			<td width="60%"></b><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(43,i)%></font></td>
		  </tr>
		  <tr>
			<td width="40%"><b><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>">Office:</font></td>
			<td width="60%"></b><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(44,i)%></font></td>
		  </tr>
		  <tr>
			<td width="40%"><b><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>">Phone:</font></td>
			<td width="60%"></b><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(45,i)%></font></td>
		  </tr>
		</table>
		</td>
		<td width="65%" valign="TOP"><table border="0" width="100%" rules="All">
		  <tr>
			<td width="20%" valign="TOP"><b><font size="<%=FontSizeHeadLog%>"
			face="<%=FontNameHeadLog%>">Note:</font></td>
			<td valign="TOP" width="80%"></b><font size="<%=FontSizeDataLog%>"
			face="<%=FontNameDataLog%>"><%Call OutputMemo(ResultArray(46,i))%></font></td>
		  </tr>
		</table>
		</td>
	  </tr>
	<% End If %>

	<%'Check if there is an attending
	If ResultArray(47,i) <> "" OR ResultArray(48,i) <> "" Then %>
	  <tr valign="TOP">
		<td width="35%" valign="TOP"><table border="0" width="100%" rules="All">
		  <tr>
			<td width="40%"><b><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>">Attending:</font></td>
			<td></b><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(47,i) & " " & ResultArray(48,i)%></font></td>
		  </tr>
		  <tr>
			<!-- 4.7.2.3 03/22/06 ccarroll Added for StatTrac 8.0 release -->
			<td width="40%"><b><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>">Attending Phone:</font></td>
			<td></b><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(128,i) %></font></td>
		  </tr>
		</table>
		</td>
	  </tr>
	<%End If%>

	<%'Check if there is an pronouncing
	If ResultArray(49,i) <> "" OR ResultArray(50,i) <> "" Then %>
	  <tr valign="TOP">
		<td width="35%" valign="TOP"><table border="0" width="100%" rules="All">
		  <tr>
			<td width="40%"><b><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>">Pronouncing:</font></td>
			<td></b><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(49,i) & " " & ResultArray(50,i)%></font></td>
		  </tr>
		  <tr>
			<!-- 4.7.2.3 03/22/06 ccarroll Added for StatTrac 8.0 release -->
			<td width="40%"><b><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>">Pronouncing Phone:</font></td>
			<td></b><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(127,i) %></font></td>
		  </tr>
		</table>
		</td>
	  </tr>
	<%End If%>

	<%'Check if there are approach minutes
	If ResultArray(81,i) <> "0" And ResultArray(81,i) <> "" Then %>
	  <tr valign="TOP">
		<td width="35%" valign="TOP"><table border="0" width="100%" rules="All">
		  <tr>
			<td width="40%"><b><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>">Time to contact NOK (min.):</font></td>
			<td></b><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(81,i)%></font></td>
		  </tr>
		</table>
		</td>
	  </tr>
	<%End If%>

	<%'Check if there are consent minutes
	If ResultArray(82,i) <> "0" And ResultArray(82,i) <> "" Then %>
	  <tr valign="TOP">
		<td width="35%" valign="TOP"><table border="0" width="100%" rules="All">
		  <tr>
			<td width="40%"><b><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>">Length of consent conversation (min.):</font></td>
			<td></b><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(82,i)%></font></td>
		  </tr>
		</table>
		</td>
	  </tr>
	<%End If%>
	
	<% 
		'Check for value in Custom Fields 1 - 16

	
		'Response.Write Ubound(ResultArray,1)
		
		For y = 0 to 15 
		IF ResultArray(106 + y,i)<> "" Then 
	%>
		  <tr valign="TOP">
			<td width="35%" valign="TOP"><table border="0" width="100%" rules="All">
			  <tr valign="TOP" >
				<td width="40%" valign="TOP"><b><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>"><%=ResultArray(106+y, i) & ":"%> </font></b></td>
				<td valign="TOP"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(90+y,i)%></font></td>
			  </tr>
			</table>
			</td>
		  </tr>
		<% End If%>

	
	<% Next %>
	
	

</table>
<% End If%>

