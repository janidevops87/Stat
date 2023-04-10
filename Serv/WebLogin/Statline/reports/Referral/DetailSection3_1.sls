
<%
'03/21/2006 - Carroll, Christopher: StatTrac 8.0 Changes per Requirement Specifications:
'  - 4.7.2.3 Display both Attending and Pronouncing Physician Phone Numbers



'Check if there are any values to display

Dim z
Dim ShowSection
'Dim CheckGOLM
'Dim iPageRowCount

ShowSection = False

For z = 36 to 50

	'Response.Write("Value:  ResultArray(" & i & "," & z & ") = " & ResultArray(i,z) & "<BR>")

	If ResultArray(z,i) <> "" Then
		ShowSection = True
	End If

Next

If ShowSection Then
	'Just Do SSN Headers AND PAGE Break for GOLM
	IF CheckGOLM then %>
		<BR>
		<!--#include virtual="/loginstatline/includes/copyright.shm"-->
		<UL></UL>
		<TABLE border="0" width="100%">
		<TR><%'iPageRowCount = iPageRowCount + 1%>
		<TD align="Left">
		<Font size="2"><B>Patient SSN:&nbsp;&nbsp;<%=ResultArray(123,i)%></B></font>
		</TD>
		<TD align="right">
		<font size="2"><B>Patient Name:&nbsp;&nbsp;<%=vPatientName%></B></font>
		</TD>
		</TR>
		</TABLE>

		<hr align="CENTER" color="#000000" noshade size="1" width="100%"><%'iPageRowCount = iPageRowCount + 1%>
	<%END IF%>
<table border="0" width="100%" rules="ALL">


<!-- SSN/Patient Name HEADER-->
<%
iTempPageRowCount = iPageRowCount	'Start keeping track of the row count.
Dim bFirstPage 'Used for determining whether loop is still on first page.
bFirstPage = true
%>

  <tr><%iPageRowCount = iPageRowCount + 1%>
    <td colspan="2"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i>Additional
    Information</i></b></font></td>
  </tr>

  <tr><%iPageRowCount = iPageRowCount + 1%>
    <td colspan="2"><hr align="CENTER" color="#000000" noshade size="1" width="100%">
    </td>
  </tr>


<%'Check if there are any approach values 
  '08/26/03 drh - Use Hospital Approach if it's a Secondary (ie. SecondaryApproach.CallId exists)
	If (ResultArray(124,i) = -1 And ResultArray(36,i) <> "") or (ResultArray(124,i) <> -1 And ResultArray(125,i) <> "-1") Then%>
	  <tr valign="TOP"><%iPageRowCount = iPageRowCount + 2%>
		<td width="35%" valign="TOP"><table border="0" width="100%" rules="All">
		  <tr>
			<td width="40%"><b><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>">Approach
			Method:</font></td>
			<td width="60%"></b><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%'08/26/03 drh - Use Hospital Approach if it's a Secondary (ie. SecondaryApproach.CallId exists)
													    If ResultArray(124,i) = -1 then%>
														  <%=ResultArray(36,i)%>
													    <%else%>
														  <%=ResultArray(125,i)%>
													    <%end if%></font></td>
		  </tr>
		</table>
		</td>
		<%If ResultArray(37,i) <> "" OR ResultArray(38,i) <> "" Then %>	
			<td width="65%"><table border="0" width="100%" rules="All" valign="TOP" align="LEFT">
			  <tr>
				<td width="20%" valign="TOP" align="LEFT"><b><font align="LEFT"
				size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>">Approached By:</font></td>
				<td valign="TOP" align="LEFT" width="80%"></b><font size="<%=FontSizeDataLog%>"
				face="<%=FontNameDataLog%>"><%'08/26/03 drh - Use Hospital Approach if it's a Secondary (ie. SecondaryApproach.CallId exists)
								If ResultArray(124,i) = -1 then%>
									<%=ResultArray(37,i) & " " & ResultArray(38,i)%>
								<%else%>
									<%=ResultArray(126,i) & " " & ResultArray(127,i)%>
								<%end if%></font></td>
			  </tr>
			</table>
			</td>
	<%End If%>
  </tr>

  <%If ResultArray(80,i) <> "" Then %>
	  <tr valign="TOP"><%iPageRowCount = iPageRowCount + 2%>
		<td width="35%" valign="TOP"><table border="0" width="100%" rules="All">
		  <tr>
			<td width="40%"><b><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>">General
			Consent:</font></td>

			<%'Determine if an extension should be displayed
			Dim vGeneralConsent
			
			'08/26/03 drh - Use Hospital Approach Outcome if it's a Secondary (ie. SecondaryApproach.CallId exists)
			If ResultArray(124,i) = -1 then
				If ResultArray(80,i) = "1" Then 
					vGeneralConsent = "Yes - Written"
				ElseIf ResultArray(80,i) = "2" Then
					vGeneralConsent = "Yes - Verbal"
				ElseIf ResultArray(80,i) = "3" Then
					vGeneralConsent = "No"
				Else
					vGeneralConsent = ""
				End If
			Else
				If ResultArray(128,i) = "1" Then 
					vGeneralConsent = "Yes - Written"
				ElseIf ResultArray(128,i) = "2" Then
					vGeneralConsent = "Yes - Verbal"
				ElseIf ResultArray(128,i) = "3" Then
					vGeneralConsent = "No"
				Else
					vGeneralConsent = ""
				End If
			End If%>

			<td width="60%"></b><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=vGeneralConsent%></font></td>
		  </tr>
		</table>
		</td>
		<td width="65%"><table border="0" width="100%" rules="All" valign="TOP" align="LEFT">
		  <tr>
			<td width="20%" valign="TOP" align="LEFT"><b><font align="LEFT"
			size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>">Found on Registry?:</font></td>
			<td valign="TOP" align="LEFT" width="80%"></b><font size="<%=FontSizeDataLog%>"
			face="<%=FontNameDataLog%>"><%=ResultArray(131,i)%></font></td>
		  </tr>
		</table>
		</td>
	  </tr>
  <%End If%>

<%End If %>

	<%'Check if there are any NOK values 
	If ResultArray(39,i) <> "" OR ResultArray(40,i) <> "" OR ResultArray(41,i) <> "" OR ResultArray(42,i) <> "" Then %>
	  <tr valign="TOP"><%iPageRowCount = iPageRowCount + 3%>
		<td width="35%" valign="TOP"><table border="0" width="100%" rules="All">
		  <tr>
			<td width="40%"><b><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>">Next Of
			Kin:</font></td>
			<td width="60%"></b><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(39,i)%></font></td>
		  </tr>
		  <tr><%iPageRowCount = iPageRowCount + 1%>
			<td width="40%"><b><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>">Relation:</font></td>
			<td width="60%"></b><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(40,i)%></font></td>
		  </tr>
		  <tr><%iPageRowCount = iPageRowCount + 1%>
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
	  <tr valign="TOP"><%iPageRowCount = iPageRowCount + 3%>
		<td width="35%" valign="TOP"><table border="0" width="100%" rules="All">
		  <tr>
			<td width="40%"><b><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>">Coroner/ME:</font></td>
			<td width="60%"></b><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(43,i)%></font></td>
		  </tr>
		  <tr><%iPageRowCount = iPageRowCount + 1%>
			<td width="40%"><b><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>">Office:</font></td>
			<td width="60%"></b><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(44,i)%></font></td>
		  </tr>
		  <tr><%iPageRowCount = iPageRowCount + 1%>
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
	'Char Chaput commented out if so that pronuncing always display's whether or not there is data so per Help Desk Case #720
	'If ResultArray(47,i) <> "" OR ResultArray(48,i) <> "" Then %>
	  <tr valign="TOP"><%iPageRowCount = iPageRowCount + 2%>
		<td width="35%" valign="TOP"><table border="0" width="100%" rules="All">
		  <tr>
			<td width="40%"><b><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>">Attending:</font></td>
			<td></b><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(47,i) & " " & ResultArray(48,i)%></font></td>
		  </tr>
		  <tr>
			<!-- 4.7.2.3 03/21/06 ccarroll Added for StatTrac 8.0 release -->
			<td width="40%"><b><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>">Attending Phone:</font></td>
			<td></b><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(137,i) %></font></td>
		  </tr>
		</table>
		</td>
	  </tr>
	<%'End If%>

	<%'Check if there is an pronouncing
	'Char Chaput commented out if so that pronuncing always display's whether or not there is data so per Help Desk Case #720
	'If ResultArray(49,i) <> "" OR ResultArray(50,i) <> "" Then %>
	  <tr valign="TOP"><%iPageRowCount = iPageRowCount + 2%>
		<td width="35%" valign="TOP"><table border="0" width="100%" rules="All">
		  <tr>
			<td width="40%"><b><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>">Pronouncing:</font></td>
			<td></b><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(49,i) & " " & ResultArray(50,i)%></font></td>
		  </tr>
		  <tr>
			<!-- 4.7.2.3 03/21/06 ccarroll Added for StatTrac 8.0 release -->
			<td width="40%"><b><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>">Pronouncing Phone:</font></td>
			<td></b><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(136,i) %></font></td>
		  </tr>
		</table>
		</td>
	  </tr>
	<%'End If%>

	<%'Check if there are approach minutes
	If ResultArray(81,i) <> "0" And ResultArray(81,i) <> "" Then %>
	  <tr valign="TOP"><%iPageRowCount = iPageRowCount + 2%>
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
	  <tr valign="TOP"><%iPageRowCount = iPageRowCount + 2%>
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
		  <tr valign="TOP"><%iPageRowCount = iPageRowCount + 2%>
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



