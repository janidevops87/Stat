<%


Dim LastOrg
Dim RefCount
Dim OrganCount
Dim BoneCount
Dim TissueCount
Dim SkinCount
Dim ValvesCount
Dim EyesCount

LastOrg = ""
RefCount = 0
OrganCount = 0
BoneCount = 0
TissueCount = 0
SkinCount = 0
ValvesCount = 0
EyesCount = 0%>
<html>

<head>
<title></title>
</head>

<body bgcolor="#F5EBDD">



<table border="0" width="100%" rules="NONE" frame="VOID">
  <tr>
<%For i=0 to UBound(ResultArray,2)%>
<%If ResultArray(15,i) <> LastOrg Then%>
<!-- Begin Group Footer. This is first used as the footer of the first group if there is more than one group. -->
<%If i > 0 Then%>
  </tr>
  <tr>
    <td colspan="26"><hr align="CENTER" color="#000000" noshade size="1" width="100%">
    </td>
  </tr>
  <tr>
    <td colspan="6" align="LEFT"><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>">Total
    Number of Referrals: &nbsp; &nbsp; &nbsp; <%=RefCount%></font></td>
    <td colspan="7">&nbsp; </td>
    <td colspan="7" align="RIGHT"><font size="<%=FontSizeHeadLog%>"
    face="<%=FontNameHeadLog%>">Total Donors: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </font></td>
    <td><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>"><%=OrganCount%></font></td>
    <td><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>"><%=BoneCount%></font></td>
    <td><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>"><%=TissueCount%></font></td>
    <td><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>"><%=SkinCount%></font></td>
    <td><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>"><%=ValvesCount%></font></td>
    <td><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>"><%=EyesCount%></font></td>
  </tr>
<%End If%>
</table>
<!-- Begin Group Footer -->


<%'drh 1/17/02 Add page break logic here
if vInsertBreaks and i > 0 then
	if ResultArray(15,i) <> vBreakValue then
		if not isEmpty(vBreakValue) then
			response.write("</H5>")
		end if

		vBreakValue = ResultArray(15,i)
		response.write("<H5>")
	end if
end if%>

<!-- Begin Group Header -->

<p><img src="/loginstatline/images/redline.jpg" height="2" width="100%"> </p>

<table border="0" width="100%" rules="NONE" frame="VOID">
<%If Request.QueryString("OrgID") = 0 Then%>
  <tr>
    <td colspan="26"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i><%=ResultArray(15,i)%></i></b></font></td>
  </tr>
  <tr>
    <td colspan="26"><hr align="CENTER" color="#000000" noshade size="1" width="100%">
    </td>
  </tr>
<%End If%>
  <tr>
    <td colspan="6">&nbsp; </td>
    <td colspan="7" align="LEFT"><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>"><b>Appropriate/Approached</b></font></td>
    <td colspan="7" align="LEFT"><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>"><b>Consented</b></font></td>
    <td colspan="6" align="LEFT"><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>"><b>Recovered</b></font></td>
  </tr>
  <tr>
    <td width="5%" valign="TOP"><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>"><u><b>Date</b></u></font></td>
    <td width="11%" valign="TOP"><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>"><u><b>
    Caller Person</b></u></font></td>
    <td width="6%" valign="TOP"><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>"><u><b>Unit</b></u></font></td>
    <td width="12%" valign="TOP"><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>"><u><b>Donor
    Name</b></u></font></td>
    <td width="3%" valign="TOP"><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>"><u><b>Sex</b></u></font></td>
    <td width="7%" valign="TOP"><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>"><u><b>Age</b></u></font></td>
    <td width="3%" valign="TOP"><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>"><u><b>O</b></u></font></td>
    <td width="3%" valign="TOP"><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>"><u><b>B</b></u></font></td>
    <td width="3%" valign="TOP"><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>"><u><b>T</b></u></font></td>
    <td width="3%" valign="TOP"><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>"><u><b>S</b></u></font></td>
    <td width="3%" valign="TOP"><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>"><u><b>V</b></u></font></td>
    <td width="3%" valign="TOP"><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>"><u><b>E</b></u></font></td>
    <td width="1%" valign="TOP">&nbsp; </td>
    <td width="3%" valign="TOP"><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>"><u><b>O</b></u></font></td>
    <td width="3%" valign="TOP"><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>"><u><b>B</b></u></font></td>
    <td width="3%" valign="TOP"><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>"><u><b>T</b></u></font></td>
    <td width="3%" valign="TOP"><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>"><u><b>S</b></u></font></td>
    <td width="3%" valign="TOP"><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>"><u><b>V</b></u></font></td>
    <td width="3%" valign="TOP"><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>"><u><b>E</b></u></font></td>
    <td width="1%" valign="TOP">&nbsp; </td>
    <td width="3%" valign="TOP"><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>"><u><b>O</b></u></font></td>
    <td width="3%" valign="TOP"><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>"><u><b>B</b></u></font></td>
    <td width="3%" valign="TOP"><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>"><u><b>T</b></u></font></td>
    <td width="3%" valign="TOP"><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>"><u><b>S</b></u></font></td>
    <td width="3%" valign="TOP"><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>"><u><b>V</b></u></font></td>
    <td width="3%" valign="TOP"><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>"><u><b>E</b></u></font></td>
  </tr>
<!-- End Group Header -->
<!-- Reset the group counts -->
<%LastOrg = ResultArray(15,i)
		RefCount = 0
		OrganCount = 0
		BoneCount = 0
		TissueCount = 0
		SkinCount = 0
		ValvesCount = 0
		EyesCount = 0
	End If%>
<!-- Display each row of referral information -->
  <tr>
    <td width="5%" align="LEFT"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(4,i)%></font></td>
    <td width="11%" align="LEFT"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(16,i) & " " & ResultArray(17,i) %></font></td>
    <td width="5%" align="LEFT"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(19,i) & " " & ResultArray(20,i)%></font></td>
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
	<td width="12%" align="LEFT"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=vPatientName%></font></td>
    <td width="3%" align="LEFT"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(26,i)%></font></td>
    <td width="7%" align="LEFT"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(24,i) & " " & ResultArray(25,i)%></font></td>
<!-- Appropriate/Approached Data -->
<!-- This loop cycles through the appropriate columns (36-56 Step 4) and references the  -->
<!-- approach column values by incrementing the current column value (y) by 1 -->
<% For y = 51 to 71 Step 4 %>
    <td width="3%" align="LEFT"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><!-- If the option was appropriate and approached, then count as a reportable "Appropriate" option -->
<%If ResultArray(y,i) = "Yes" And ResultArray(y+1,i) = "Yes" Then
				Response.Write ("Yes")
			Else 
				Response.Write ("&nbsp ")
			End If%>    </font></td>
<% Next %>
    <td width="1%"><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>">&nbsp; </font></td>
<!-- Consented Data -->
<!-- This loop cycles through the consent columns (37-57) and references the appropriate and -->
<!-- approach column values by decrementing the current column value (y) by 2 and 1, respectively -->
<% For y = 53 to 73 Step 4 %>
    <td width="3%" align="LEFT"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><!-- If the option was appropriate and approached, then count as a reportable "Consented" option -->
<%If ResultArray(y-2,i) = "Yes" And ResultArray(y-1,i) = "Yes" Then
				Response.Write (ResultArray(y,i))
			 Else 
				Response.Write ("&nbsp ")
			 End If%>    </font></td>
<% Next %>
    <td width="1%"><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>">&nbsp; </font></td>
<!-- Recovered Data -->
<% For y = 54 to 74 Step 4 %>

    <td width="3%" align="LEFT"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%Response.Write(ResultArray(y,i))%>

<!-- Count each recovered donor --><%Select Case (y)
				Case 54
					If ResultArray(y,i) = "Yes" Then
						OrganCount = OrganCount + 1
					End If
				Case 58
					If ResultArray(y,i) = "Yes" Then
						BoneCount = BoneCount + 1
					End If
				Case 62
					If ResultArray(y,i) = "Yes" Then
						TissueCount = TissueCount + 1
					End If
				Case 66
					If ResultArray(y,i) = "Yes" Then
						SkinCount = SkinCount + 1
					End If
				Case 70
					If ResultArray(y,i) = "Yes" Then
						ValvesCount = ValvesCount + 1
					End If
				Case 74
					If ResultArray(y,i) = "Yes" Then
						EyesCount = EyesCount + 1
					End If
			End Select%>    </font></td>
<%
if vInsertBreaks and i = Ubound(ResultArray,2) then
	response.write("</H5>")
end if
%>
<%Next %>
  </tr>
<%RefCount = RefCount + 1%>
<%Next%>
<!-- Begin Group Footer. This footer is used as the footer for the last group. -->
<%If i > 0 Then%>
  <tr>
    <td colspan="26"><hr align="CENTER" color="#000000" noshade size="1" width="100%">
    </td>
  </tr>
  <tr>
    <td colspan="6" align="LEFT"><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>">Total
    Number of Referrals: &nbsp; &nbsp; &nbsp; <%=RefCount%></font></td>
    <td colspan="7">&nbsp; </td>
    <td colspan="7" align="RIGHT"><font size="<%=FontSizeHeadLog%>"
    face="<%=FontNameHeadLog%>">Total Donors: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </font></td>
    <td><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>"><%=OrganCount%></font></td>
    <td><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>"><%=BoneCount%></font></td>
    <td><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>"><%=TissueCount%></font></td>
    <td><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>"><%=SkinCount%></font></td>
    <td><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>"><%=ValvesCount%></font></td>
    <td><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>"><%=EyesCount%></font></td>
  </tr>
<%End If%>
<!-- Begin Group Footer -->
</table>


</body>
</html>
