
<%
'03/21/2006 - Carroll, Christopher: StatTrac 8.0 Changes per Requirement Specifications:
'  - 4.3.5   Display the Specific COD field
'  - 4.6.3   Display the Brain Death Date and Time fields
'  - 4.8.5   Display the Current Ref. Type field

Dim vCallExtension
vCallExtension = ""
If pvUserOrgID = 194 Then

	IF InStr(ResultArray(2,i),"-") > 0 Then
		vQuery = "sps_CallExtension " & Left(ResultArray(2,i),InStr(ResultArray(2,i),"-")-1)
	ELSE
		vQuery = "sps_CallExtension " & Left(ResultArray(2,i),7)
	END IF	

	Set RS = Conn.Execute(vQuery)

	vCallExtension = "(" & RS("CallExtension") & ")"

	Set RS = Nothing
	
End IF	
%>

<table border="0" width="100%" rules="NONE" frame="VOID">
 
  <tr>
    <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Call Number: </b></font></td>
    <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(2,i)%></font></td>
    <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Preliminary Ref Type: </b></font></td>
    <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(12,i)%></font></td>
  </tr>
<!-- 03/22/06 ccarroll Added field per StatTrac 8.0 specification: 4.8.5 -->
  <tr>
    <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>">&nbsp;</font></td>
    <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>">&nbsp;</font></td>
    <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Current Ref Type:</b></font></td>
    <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(138,i)%></font></td>
  </tr>

  
  
  <tr>
    <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Call Date/Time:</b></font></td>
    <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(4,i) & " " & ResultArray(5,i)%></font></td>
    <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Triage Coordinator: </b></font></td>
    <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(6,i) & " " & ResultArray(7,i) & " " & vCallExtension%></font></td>
  </tr>
<!--  
  <tr>
    <td></td>
    <td></td>
    <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Status:</b></font></td>
    <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(8,i)%></font></td>
  </tr>
 -->
</table>


<hr align="CENTER" color="#000000" noshade size="1" width="100%">

<table border="0" width="100%" rules="NONE" frame="VOID">
<%'Determine if an extension should be displayed
	Dim vExt

	If ResultArray(22,i) <> "" Then 
		vExt = " Ext. " & ResultArray(22,i) 
	Else 
		vExt = "" 
	End If%>
  <tr>
    <td colspan="4"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i>Caller
    Information</i></b></font></td>
  </tr>
  <tr>
    <td colspan="4"><hr align="CENTER" color="#000000" noshade size="1" width="100%">
    </td>
  </tr>
  <tr>
    <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Caller Name: </b></font></td>
    <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(16,i) & " " & ResultArray(17,i)%></font></td>
    <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Title: </b></font></td>
    <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(18,i)%></font></td>
  </tr>
  <tr>
    <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Called From: </b></font></td>
    <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(15,i)%></font></td>
    <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Sublocation: </b></font></td>
    <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(19,i) & " " & ResultArray(20,i)%></font></td>
  </tr>
  <tr>
    <td><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Contact Number:</b></font></td>
    <td><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(21,i) & vExt%></font></td>
    <td width="20%"></td>
    <td width="30%"></td>
  </tr>
</table>

<p></p>
<hr align="CENTER" color="#000000" noshade size="1" width="100%">

<table border="0" width="100%" rules="NONE">
  <tr>
    <td colspan="6"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i>Patient
    Information</i></b></font></td>
  </tr>
  <tr>
    <td colspan="6"><hr align="CENTER" color="#000000" noshade size="1" width="100%">
    </td>
  </tr>
		<% 'Determine how to display patient name & record number.
		Dim vPatientName
		Dim vMedRecNum
		
		If pvNoName = 1 Then
			vPatientName = "Anonymous"
			vMedRecNum = ""
		Else
			If ResultArray(13,i) = "" And ResultArray(14,i) <> "" Then
				vPatientName = ResultArray(13,i)
			ElseIf ResultArray(14,i) = "" And ResultArray(13,i) <> "" Then
				vPatientName = ResultArray(14,i)
			ElseIf ResultArray(13,i) = "" And ResultArray(14,i) = "" Then
				vPatientName = "N/A"
			Else
				vPatientName = ResultArray(13,i) & ", " & ResultArray(14,i) & " " & ResultArray(139,i)

			End If
			vMedRecNum = ResultArray(23,i)
		End If%>  

  <tr>
    <td><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Patient Name: </b></font></td>
    <td colspan="3"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=vPatientName%></font></td>
    <td><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>UNOS ID #: </b></font></td>
    <td><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=vMedRecNum%></font></td>
  </tr>
  <tr>
    <td><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Admit Date: </b></font></td>
    <td colspan="3"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(29,i) & " " & ResultArray(30,i)%></font></td>
    <td><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>On Ventilator: </b></font></td>
    <td><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(28,i)%></font></td>
  </tr>
  <% IF NOT IsNULL(ResultArray(84,i)) Then %>
  <tr>
    <td><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b></b></font></td>
    <td colspan="3"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"></font></td>
    <td><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Extubated:  </b></font></td>
    <td><font size="<%=FontSizeData%>" face="<%=FontNameData%>"></b><%=ResultArray(84,i)%></font></td>
  </tr>
  <% END IF %>
  <tr>
    <td width="14%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Age: </b></font></td>
    <td width="11%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(24,i) & " " & ResultArray(25,i)%></font></td>
    <td width="12%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Gender: </b></font></td>
    <td width="13%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(26,i)%></font></td> 
    <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Date of Death:</b></font></td>
    <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(31,i) & " " & ResultArray(32,i)%></font></td>
  </tr>
  <tr>
    <td width="14%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Race: </b></font></td>
    <td width="11%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(34,i)%></font></td>
    <td width="12%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Weight (kg): </b></font></td>
    <td width="13%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(27,i)%></font></td>
<!-- 03/22/06 ccarroll Added field per StatTrac 8.0 specification: 4.6.3 -->
    <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Brain Death Date:</b></font></td>
    <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(134,i) & " " & ResultArray(135,i)%></font></td>
  </tr>
  <tr>
    <td width="14%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>">&nbsp;</font></td>
    <td width="11%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>">&nbsp;</font></td>
    <td width="12%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>">&nbsp;</font></td>
    <td width="13%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>">&nbsp;</font></td>
    <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Cause of Death:</b></font></td>
    <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(35,i)%></font></td>
  </tr>
  <tr>
    <td width="14%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>">&nbsp;</font></td>
    <td width="11%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>">&nbsp;</font></td>
    <td width="12%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>">&nbsp;</font></td>
    <td width="13%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>">&nbsp;</font></td>
<!-- 03/22/06 ccarroll Added field per StatTrac 8.0 specification: 4.3.5 -->
    <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Specific C.O.D.:</b></font></td>
    <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(133,i)%></font></td>
  </tr>

  <tr>
    <td valign="TOP"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Medical Info: </b></font></td>
    <td colspan="4" valign="TOP"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(33,i)%></font></td>
  </tr>
  
 <%
	' *** Display ResultArray ***    
	'dim j
    	'response.write("test:<br>")
  	'for j = 0 to ubound(ResultArray,1)
   	'response.write("<br>" & j & ": " & ResultArray(j,i))
  	'next
  %>  
  
  <% 
  IF len(ResultArray(83,i))>1 THEN
  %>
  <tr>
    <td valign="TOP"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Secondary Info: </b></font></td>
    <td colspan="4" valign="TOP"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(83,i)%></font></td>
  </tr>
   
  
  <%
  END IF
  %>
</table>

