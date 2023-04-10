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
<%For i=0 to UBound(ResultArray,1)%>
<%If ResultArray(i,15) <> LastOrg Then%>
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




<!-- Begin Group Header -->

<p><img src="/loginstatline/images/redline.jpg" height="2" width="100%"> </p>

<table border="0" width="100%" rules="NONE" frame="VOID">
<%If Request.QueryString("OrgID") = 0 Then%>
  <tr>
    <td colspan="26"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i><%=ResultArray(i,15)%></i></b></font></td>
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
    <td width="11%" valign="TOP"><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>"><u><b>Caller
    Person</b></u></font></td>
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
<%LastOrg = ResultArray(i,15)
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
    <td width="5%" align="LEFT"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(i,4)%></font></td>
    <td width="11%" align="LEFT"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(i,16) & " " & ResultArray(i,17)%></font></td>
    <td width="5%" align="LEFT"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(i,19) & " " & ResultArray(i,20)%></font></td>
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
	<td width="12%" align="LEFT"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=vPatientName%></font></td>
    <td width="3%" align="LEFT"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(i,26)%></font></td>
    <td width="7%" align="LEFT"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%=ResultArray(i,24) & " " & ResultArray(i,25)%></font></td>
<!-- Appropriate/Approached Data -->
<!-- This loop cycles through the appropriate columns (36-56 Step 4) and references the  -->
<!-- approach column values by incrementing the current column value (y) by 1 -->
<% For y = 36 to 56 Step 4 %>
    <td width="3%" align="LEFT"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><!-- If the option was appropriate and approached, then count as a reportable "Appropriate" option -->
<%If ResultArray(i,y) = "Yes" And ResultArray(i,y+1) = "Yes" Then
				Response.Write ("Yes")
			Else 
				Response.Write ("&nbsp ")
			End If%>    </font></td>
<% Next %>
    <td width="1%"><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>">&nbsp; </font></td>
<!-- Consented Data -->
<!-- This loop cycles through the consent columns (37-57) and references the appropriate and -->
<!-- approach column values by decrementing the current column value (y) by 2 and 1, respectively -->
<% For y = 38 to 58 Step 4 %>
    <td width="3%" align="LEFT"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><!-- If the option was appropriate and approached, then count as a reportable "Consented" option -->
<%If ResultArray(i,y-2) = "Yes" And ResultArray(i,y-1) = "Yes" Then
				Response.Write (ResultArray(i,y))
			 Else 
				Response.Write ("&nbsp ")
			 End If%>    </font></td>
<% Next %>
    <td width="1%"><font size="<%=FontSizeHeadLog%>" face="<%=FontNameHeadLog%>">&nbsp; </font></td>
<!-- Recovered Data -->
<% For y = 39 to 59 Step 4 %>
    <td width="3%" align="LEFT"><font size="<%=FontSizeDataLog%>" face="<%=FontNameDataLog%>"><%Response.Write (ResultArray(i,y))%>
<!-- Count each recovered donor --><%Select Case (y)
				Case 39
					If ResultArray(i,y) = "Yes" Then
						OrganCount = OrganCount + 1
					End If
				Case 43
					If ResultArray(i,y) = "Yes" Then
						BoneCount = BoneCount + 1
					End If
				Case 47
					If ResultArray(i,y) = "Yes" Then
						TissueCount = TissueCount + 1
					End If
				Case 51
					If ResultArray(i,y) = "Yes" Then
						SkinCount = SkinCount + 1
					End If
				Case 55
					If ResultArray(i,y) = "Yes" Then
						ValvesCount = ValvesCount + 1
					End If
				Case 59
					If ResultArray(i,y) = "Yes" Then
						EyesCount = EyesCount + 1
					End If
			End Select%>    </font></td>
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
