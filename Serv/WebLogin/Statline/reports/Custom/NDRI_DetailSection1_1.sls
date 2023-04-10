<br>
<table border="0" width="100%" rules="NONE" frame="VOID">
   <tr><%'iPageRowCount = iPageRowCount + 1%>
       <td colspan="4"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i>Case Info</i></b></font></td>
     </tr>
     <tr><%'iPageRowCount = iPageRowCount + 1%>
       <td colspan="4"><hr align="CENTER" color="#000000" noshade size="1" width="100%">
       </td>
  </tr>
   <tr><%'iPageRowCount = iPageRowCount + 1%>
    <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Date/Time: </b></font></td>
    <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(2,i) & " " & ResultArray(3,i)%></font></td>
    <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Coordinator Name: </b></font></td>
    <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(5,i)%></font></td>
  </tr>
  <tr><%'iPageRowCount = iPageRowCount + 1%>
    <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Donor #:</b></font></td>
    <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(4,i)%></font></td>
    <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Source: </b></font></td>
    <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(6,i)%></font></td>
  </tr>
  <tr><%'iPageRowCount = iPageRowCount + 1%>
      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Reference #:</b></font></td>
      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(1,i)%></font></td>
      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Telephone #:</b></font></td>
      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(7,i)%></font></td>
  </tr>
</table>


<hr align="CENTER" color="#000000" noshade size="1" width="100%"><%'iPageRowCount = iPageRowCount + 1%>

<table border="0" width="100%" rules="NONE" frame="VOID">
  <tr><%'iPageRowCount = iPageRowCount + 1%>
    <td colspan="4"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i>Patient Info</i></b></font></td>
  </tr>
  <tr><%'iPageRowCount = iPageRowCount + 1%>
    <td colspan="4"><hr align="CENTER" color="#000000" noshade size="1" width="100%">
    </td>
  </tr>
  <tr><%'iPageRowCount = iPageRowCount + 1%>
    <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>A/R/S: </b></font></td>
    <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(8,i) & " " & ResultArray(9,i) & " / " & ResultArray(33,i) & " / " & ResultArray(11,i)%></font></td>
    <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>ABO/Rh: </b></font></td>
    <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(34,i)%></font></td>
  </tr>
  <tr><%'iPageRowCount = iPageRowCount + 1%>
    <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>COD/S: </b></font></td>
    <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(32,i)%></font></td>
    <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Date/TOD: </b></font></td>
    <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(14,i) & " " & ResultArray(15,i)%></font></td>
  </tr>
  <tr><%'iPageRowCount = iPageRowCount + 1%>
      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>CD4: </b></font></td>
      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(16,i)%></font></td>
      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>V.L.: </b></font></td>
      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(17,i)%></font></td>
  </tr>
  <tr><%'iPageRowCount = iPageRowCount + 1%>
        <td width="20%" valign=top><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Other known diseases: </b></font></td>
        <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(18,i)%></font></td>
  </tr>
</table>

<hr align="CENTER" color="#000000" noshade size="1" width="100%"><%'iPageRowCount = iPageRowCount + 1%>

<table border="0" width="100%" rules="NONE" frame="VOID">
  <tr><%'iPageRowCount = iPageRowCount + 1%>
    <td colspan="4"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i>Medical History</i></b></font></td>
  </tr>
  <tr><%'iPageRowCount = iPageRowCount + 1%>
    <td colspan="4"><hr align="CENTER" color="#000000" noshade size="1" width="100%">
    </td>
  </tr>
  <tr><%'iPageRowCount = iPageRowCount + 1%>
    <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Sepsis: </b></font></td>
    <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(36,i)%></font></td>
    <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Chemotherapy: </b></font></td>
    <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(37,i)%></font></td>
  </tr>
  <tr><%'iPageRowCount = iPageRowCount + 1%>
    <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Radiation: </b></font></td>
    <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(38,i)%></font></td>
    <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Substance Abuse: </b></font></td>
    <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(39,i)%></font></td>
  </tr>
  <tr><%'iPageRowCount = iPageRowCount + 1%>
        <td width="20%" valign=top><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Other: </b></font></td>
        <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(23,i)%></font></td>
  </tr>
</table>

<hr align="CENTER" color="#000000" noshade size="1" width="100%"><%'iPageRowCount = iPageRowCount + 1%>

<table border="0" width="100%" rules="NONE" frame="VOID">
  <tr><%'iPageRowCount = iPageRowCount + 1%>
    <td colspan="4"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i>Medications</i></b></font></td>
  </tr>
  <tr><%'iPageRowCount = iPageRowCount + 1%>
      <td colspan="4"><hr align="CENTER" color="#000000" noshade size="1" width="100%">
      </td>
  </tr>
  <tr><%'iPageRowCount = iPageRowCount + 1%>
      <td width="25%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><u><b>Medication</b></u></font></td>
      <td width="25%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><u><b>Dose</b></u></font></td>
      <td width="25%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><u><b>Start Date</b></u></font></td>
      <td width="25%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><u><b>End Date</b></u></font></td>
  </tr>
  
  <%'Get NDRI Medications
    vQuery = "sps_SecondaryMedicationOther " & pvCallId & ", 'ndri_medication'"
    Set RS = Conn.Execute(vQuery)
    
    If Not RS.EOF Then
    	Do While Not RS.EOF%>
    	
    		<tr><%'iPageRowCount = iPageRowCount + 1%>
    			<td width="25%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=RS("SecondaryMedicationOtherName")%></font></td>
    			<td width="25%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=RS("SecondaryMedicationOtherDose")%></font></td>
    			<td width="25%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=RS("SecondaryMedicationOtherStartDate")%></font></td>
    			<td width="25%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=RS("SecondaryMedicationOtherEndDate")%></font></td>
    		</tr>
    		
    	<%	RS.MoveNext
    	  Loop
    End If
    
    Set RS = Nothing
  %>
</table>

<hr align="CENTER" color="#000000" noshade size="1" width="100%"><%'iPageRowCount = iPageRowCount + 1%>

<table border="0" width="100%" rules="NONE" frame="VOID">
  <tr><%'iPageRowCount = iPageRowCount + 1%>
    <td colspan="4"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i>Other</i></b></font></td>
  </tr>
  <tr><%'iPageRowCount = iPageRowCount + 1%>
    <td colspan="4"><hr align="CENTER" color="#000000" noshade size="1" width="100%">
    </td>
  </tr>
  <tr><%'iPageRowCount = iPageRowCount + 1%>
    <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Hospital: </b></font></td>
    <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(24,i)%></font></td>
    <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Nurse: </b></font></td>
    <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(25,i)%></font></td>
  </tr>
  <tr><%'iPageRowCount = iPageRowCount + 1%>
    <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Physician:</b></font></td>
    <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(26,i)%></font></td>
    <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Physician Number:</b></font></td>
    <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(27,i)%></font></td>
  </tr>
  <tr><%'iPageRowCount = iPageRowCount + 1%>
        <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Family at Hospital?</b></font></td>
	    <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(40,i)%></font></td>
	    <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Family knows HIV status:</b></font></td>
    <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(41,i)%></font></td>
  </tr>
  <tr><%'iPageRowCount = iPageRowCount + 1%>
          <td width="20%" valign=top><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Funeral Home:</b></font></td>
  	    <td width="30%" valign=top><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(30,i)%></font></td>
  	  <td width="20%" valign=top><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Additional Comments:</b></font></td>
    <td width="30%" valign=top><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=ResultArray(31,i)%></font></td>
  </tr>
</table>

<hr align="CENTER" color="#000000" noshade size="1" width="100%"><%'iPageRowCount = iPageRowCount + 1%>
