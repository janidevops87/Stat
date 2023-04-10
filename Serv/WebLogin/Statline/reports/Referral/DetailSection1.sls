
<%

Dim vCallExtension
vCallExtension = ""
If pvUserOrgID = 194 Then

	IF InStr(ResultArray(i,2),"-") > 0 Then
		vQuery = "sps_CallExtension " & Left(ResultArray(i,2),InStr(ResultArray(i,2),"-")-1)
	ELSE
		
		vQuery = "sps_CallExtension " & Left(ResultArray(i,2),7)
	END IF	

	Response.Write vQuery
	Set RS = Conn.Execute(vQuery)

	vCallExtension = "(" & RS("CallExtension") & ")"

	Set RS = Nothing
	
End IF	
%>

<table border="0" width="100%" rules="NONE" frame="VOID">
  <tr>
    <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Call Number: </b></font></td>
    <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(i,2)%></font></td>
    <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Referral Type: </b></font></td>
    <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(i,12)%></font></td>
  </tr>
  <tr>
    <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Call Date/Time:
    </b></font></td>
    <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(i,4) & " " & ResultArray(i,5)%></font></td>
    <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Triage
    Coordinator: </b></font></td>
    <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(i,6) & " " & ResultArray(i,7) & " " & vCallExtension%></font></td>
  </tr>
<!--  
  <tr>
    <td></td>
    <td></td>
    <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Status:</b></font></td>
    <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(i,8)%></font></td>
  </tr>
 -->
</table>


<hr align="CENTER" color="#000000" noshade size="1" width="100%">

<table border="0" width="100%" rules="NONE" frame="VOID">
<%'Determine if an extension should be displayed
	Dim vExt

	If ResultArray(i,22) <> "" Then 
		vExt = " Ext. " & ResultArray(i,22) 
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
    <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(i,16) & " " & ResultArray(i,17)%></font></td>
    <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Title: </b></font></td>
    <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(i,18)%></font></td>
  </tr>
  <tr>
    <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Called From: </b></font></td>
    <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(i,15)%></font></td>
    <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Sublocation: </b></font></td>
    <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(i,19) & " " & ResultArray(i,20)%></font></td>
  </tr>
  <tr>
    <td><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Contact Number:</b></font></td>
    <td><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(i,21) & vExt%></font></td>
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
		<%'Determine how to display patient name & record number.
		Dim vPatientName
		Dim vMedRecNum
		
		If pvNoName = 1 Then
			vPatientName = "Anonymous"
			vMedRecNum = ""
		Else
			If ResultArray(i,13) = "" And ResultArray(i,14) <> "" Then
				vPatientName = ResultArray(i,13)
			ElseIf ResultArray(i,14) = "" And ResultArray(i,13) <> "" Then
				vPatientName = ResultArray(i,14)
			ElseIf ResultArray(i,13) = "" And ResultArray(i,14) = "" Then
				vPatientName = "N/A"
			Else
				vPatientName = ResultArray(i,13) & ", " & ResultArray(i,14)
			End If
			vMedRecNum = ResultArray(i,23)
		End If%>  

  <tr>
    <td><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Patient Name: </b></font></td>
    <td colspan="3"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=vPatientName%></font></td>
    <td><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Medical Record #: </b></font></td>
    <td><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=vMedRecNum%></font></td>
  </tr>
  <tr>
    <td><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Admit Date: </b></font></td>
    <td colspan="3"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(i,29) & " " & ResultArray(i,30)%></font></td>
    <td><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>On Ventilator: </b></font></td>
    <td><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(i,28)%></font></td>
  </tr>
  <tr>
    <td width="14%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Age: </b></font></td>
    <td width="11%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(i,24) & " " & ResultArray(i,25)%></font></td>
    <td width="12%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Gender: </b></font></td>
    <td width="13%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(i,26)%></font></td> 
    <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Date of Death: </b></font></td>
    <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(i,31) & " " & ResultArray(i,32)%></font></td>
  </tr>
  <tr>
    <td width="14%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Race: </b></font></td>
    <td width="11%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(i,34)%></font></td>
    <td width="12%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Weight (kg): </b></font></td>
    <td width="13%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(i,27)%></font></td>
    <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Cause of Death:
    </b></font></td>
    <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(i,35)%></font></td>
  </tr>
  <tr>
    <td valign="TOP"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Medical Info: </b></font></td>
    <td colspan="4" valign="TOP"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(i,33)%></font></td>
  </tr>
</table>


