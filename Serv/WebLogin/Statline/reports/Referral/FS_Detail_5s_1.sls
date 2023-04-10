<%Set Conn = server.CreateObject("ADODB.Connection")
  Server.ScriptTimeout = 2700
  conn.CommandTimeout = 90
  
  
  vQuery = "sps_SecondaryReferralReport2 " & ResultArray(1,i)
  Conn.Open DataSourceName, DBUSER, DBPWD
  'print(vQuery)
  Set rs = Conn.Execute(vQuery)
  
  'Get Medications in a separate recordset
  dim rs_meds
    vQuery = "SELECT DISTINCT " & _
                "sm.MedicationID, " & _
                "m.MedicationName " & _
                "FROM SecondaryMedication sm " & _
                "LEFT JOIN Medication m ON sm.MedicationId = m.MedicationId " & _
                "WHERE sm.CallId = " & ResultArray(1,i) & ";"
    'print(vQuery)
    Set rs_meds = Conn.Execute(vQuery)
    
    'Get Antibiotics in a separate recordset
    dim rs_antibiotic
    vQuery = "sps_SecondaryMedicationOther " & ResultArray(1,i) & ", 'antibiotic'"
    'print(vQuery)
    Set rs_antibiotic = Conn.Execute(vQuery)
  
    'Get Antibiotics in a separate recordset
    dim rs_steroid
    vQuery = "sps_SecondaryMedicationOther " & ResultArray(1,i) & ", 'steroid'"
    'print(vQuery)
    Set rs_steroid = Conn.Execute(vQuery)%>
  
  <%IF NOT rs.EOF THEN%>
    <br>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i>Case Management</i></b></font>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <table border="0" width="100%" rules="NONE" frame="VOID">
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Case Open: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("FSCaseOpen")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Secondary Billable: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("FSCaseBillSecondary")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>System Events: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("FSCaseSysEvents")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Family Unavailable: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("FSCaseBillUnavailable")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Secondary Complete: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("FSCaseSecComp")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Family Approached: </b></font></td>
	      <td width="30%">
	        <table width=100% cellpadding=0 cellspacing=0>
			          <tr>
			            <td width="80%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("FSCaseBillApproach")%></font></td>
			            <td width="10%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Count: </b></font></td>
			            <td width="10%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>">&nbsp;&nbsp;<%=rs("FSCaseBillApproachCount")%></font></td>
			          </tr>
	        </table></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Approached: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("FSCaseApproach")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Medical/Social History: </b></font></td>
	      <td width="30%">
	        <table width=100% cellpadding=0 cellspacing=0>
			          <tr>
			            <td width="80%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("FSCaseBillMedSoc")%></font></td>
			            <td width="10%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Count: </b></font></td>
			            <td width="10%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>">&nbsp;&nbsp;<%=rs("FSCaseBillMedSocCount")%></font></td>
			          </tr>
	        </table></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Final: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("FSCaseFinal")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Cryolife Form Completed: </b></font></td>
	      <td width="30%">
	        <table width=100% cellpadding=0 cellspacing=0>
				  <tr>
				    <td width="80%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("FSCaseBillCryolifeForm")%></font></td>
				    <td width="10%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Count: </b></font></td>
				    <td width="10%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>">&nbsp;&nbsp;<%=rs("FSCaseBillCryolifeFormCount")%></font></td>
				  </tr>
	        </table></td>
	    </tr>
	  </table><br>
	
	
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i>Admit</i></b></font>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <table border="0" width="100%" rules="NONE" frame="VOID">
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Admission Diagnosis: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryAdmissionDiagnosis")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Admission Date: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryAdmissionDate")%>&nbsp;<%=rs("SecondaryAdmissionTime")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>DNR Date: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryDNRDate")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Death Witnessed: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=YN(rs("SecondaryDeathWitnessed"))%></font></td>
	    </tr>	
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Death Witnessed By: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryDeathWitnessedBy")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Rhythm: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryRhythm")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>LSA Date/Time: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryLSADate")%>&nbsp;<%=rs("SecondaryLSATime")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b></b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>EMS Arrival To Patient Time: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryEMSArrivalToPatientTime")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>EMS Arrival To Hospital Time: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryEMSArrivalToHospitalTime")%></font></td>
	    </tr>
	  </table>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i>Alt Contact</i></b></font>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <table border="0" width="100%" rules="NONE" frame="VOID">
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Alt Contact: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryNOKAltContact")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Alt Contact Phone: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryNOKAltContactPhone")%></font></td>
	    </tr>
	    <tr>
	    </tr>
	  </table>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i>Antibiotics</i></b></font>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <table border="0" width="100%" rules="NONE" frame="VOID">
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Antibiotics: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=YN(rs("SecondaryAntibiotic"))%></font></td>
	    </tr>
	    
	    <%'Loop through and display antibiotics
	      p = 1
	      vEvenRow = false

	      if not rs_antibiotic.eof then
		while not rs_antibiotic.eof%>
		      <tr>
			<td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Antibiotic <%=p%> Name: </b></font></td>
			<td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs_antibiotic("SecondaryMedicationOtherName")%></font></td>
			<td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Antibiotic <%=p%> Dose: </b></font></td>
			<td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs_antibiotic("SecondaryMedicationOtherDose")%></font></td>
		      </tr>
		      <tr>
			<td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Antibiotic <%=p%> Start Date: </b></font></td>
			<td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs_antibiotic("SecondaryMedicationOtherStartDate")%></font></td>
			<td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Antibiotic <%=p%> End Date: </b></font></td>
			<td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs_antibiotic("SecondaryMedicationOtherEndDate")%></font></td>
		      </tr>
			
			<%p = p + 1
			rs_antibiotic.movenext
		wend

		if vEvenRow then%>
			</tr>
		<%end if
  	    end if%>	    
	    
	  </table>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i>Steroids</i></b></font>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <table border="0" width="100%" rules="NONE" frame="VOID">
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Steroids: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=YN(rs("SecondarySteroid"))%></font></td>
	    </tr>
	    
	    <%'Loop through and display antibiotics
	    	      p = 1
	    	      vEvenRow = false
	    
	    	      if not rs_steroid.eof then
	    		while not rs_steroid.eof%>
	    		      <tr>
	    			<td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Steroid <%=p%> Name: </b></font></td>
	    			<td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs_steroid("SecondaryMedicationOtherName")%></font></td>
	    			<td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Steroid <%=p%> Dose: </b></font></td>
	    			<td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs_steroid("SecondaryMedicationOtherDose")%></font></td>
	    		      </tr>
	    		      <tr>
	    			<td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Steroid <%=p%> Start Date: </b></font></td>
	    			<td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs_steroid("SecondaryMedicationOtherStartDate")%></font></td>
	    			<td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Steroid <%=p%> End Date: </b></font></td>
	    			<td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs_steroid("SecondaryMedicationOtherEndDate")%></font></td>
	    		      </tr>
	    			
	    			<%p = p + 1
	    			rs_steroid.movenext
	    		wend
	    
	    		if vEvenRow then%>
	    			</tr>
	    		<%end if
  	    end if%>
  	    
	  </table>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i>Autopsy</i></b></font>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <table border="0" width="100%" rules="NONE" frame="VOID">
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Autopsy: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=YN(rs("SecondaryAutopsy"))%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Date: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryAutopsyDate")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Time: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryAutopsyTime")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Location: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryAutopsyLocation")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Blood Requested: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=YN(rs("SecondaryAutopsyBloodRequested"))%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Copy Requested: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=YN(rs("SecondaryAutopsyCopyRequested"))%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Reminder: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryAutopsyReminder")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Reminder (Y/N): </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=YN(rs("SecondaryAutopsyReminderYN"))%></font></td>
	    </tr>
	    <tr>
	    </tr>
	  </table>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i>Blood Loss</i></b></font>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <table border="0" width="100%" rules="NONE" frame="VOID">
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Internal Blood Loss CC: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryInternalBloodLossCC")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>External Blood Loss CC: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryExternalBloodLossCC")%></font></td>
	    </tr>
	    <tr>
	    </tr>
	  </table>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i>Blood Products</i></b></font>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <table border="0" width="100%" rules="NONE" frame="VOID">
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Blood Products Received: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=YN(rs("SecondaryBloodProducts"))%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Product  1 Type: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryBloodProductsReceived1Type")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Product 1 Units: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryBloodProductsReceived1Units")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Product 1 CC: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryBloodProductsReceived1TypeCC")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Product 1 Unit Given: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryBloodProductsReceived1TypeUnitGiven")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Product 2 Type: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryBloodProductsReceived2Type")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Product 2 Units: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryBloodProductsReceived2Units")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Product 2 CC: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryBloodProductsReceived2TypeCC")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Product 2 Unit Given: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryBloodProductsReceived2TypeUnitGiven")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Product 3 Type: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryBloodProductsReceived3Type")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Product 3 Units: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryBloodProductsReceived3Units")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Product 3 CC: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryBloodProductsReceived3TypeCC")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Product 3Unit Given: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryBloodProductsReceived3TypeUnitGiven")%></font></td>
	    </tr>
	  </table>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i>Body Care</i></b></font>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <table border="0" width="100%" rules="NONE" frame="VOID">
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Hold on Body Placed: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryBodyHoldPlaced")%>&nbsp;<%=rs("SecondaryBodyHoldPlacedTime")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Hold Placed With: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryBodyHoldPlacedWith")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Future Contact for Update/Release: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryBodyFutureContact")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Phone Number: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryBodyHoldPhone")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Refrigeration Date: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryBodyRefrigerationDate")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Refrigeration Time: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryBodyRefrigerationTime")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Body Location: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryBodyLocation")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Cooling Method: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryBodyCoolingMethod")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Eye Care Instructions Given:</b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=CheckBoxYN(rs("SecondaryBodyHoldInstructionsGiven"))%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b></b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"></font></td>
	    </tr>
	  </table>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i>Case Info</i></b></font>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <table border="0" width="100%" rules="NONE" frame="VOID">
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>NOK Notified: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=YN(rs("SecondaryNOKaware"))%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>NOK Notified By: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryNOKNotifiedBy")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>NOK Notified Date: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryNOKNotifiedDate")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>NOK Notified Time: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryNOKNotifiedTime")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Family Interested: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=YN(rs("SecondaryFamilyInterested"))%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Family Consent: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=YN(rs("SecondaryFamilyConsent"))%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>NOK at Hospital: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=YN(rs("SecondaryNOKatHospital"))%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Est Time Since NOK Left: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryEstTimeSinceLeft")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Time NOK Left In MT: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryTimeLeftInMT")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>NOK Next Dest: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryNOKNextDest")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>NOK ETA: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryNOKETA")%></font></td>
	    </tr>
	  </table>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i>Case Numbers</i></b></font>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <table border="0" width="100%" rules="NONE" frame="VOID">
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>UNOS: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryUNOSNumber")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Client: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryClientNumber")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Cryolife: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryCryolifeNumber")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>MTF: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryMTFNumber")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Life Net: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryLifeNetNumber")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Free Text: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryFreeText")%></font></td>
	    </tr>
	    <tr>
	    </tr>
	  </table>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i>Colloids</i></b></font>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <table border="0" width="100%" rules="NONE" frame="VOID">
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Colloids Infused: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=YN(rs("SecondaryColloidsInfused"))%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Colloids 1 Type: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryColloidsInfused1Type")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Colloids 1 Units: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryColloidsInfused1Units")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Colloids 1 CC: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryColloidsInfused1CC")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Colloids 1 Unit Given: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryColloidsInfused1UnitGiven")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Colloids 2 Type: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryColloidsInfused2Type")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Colloids 2 Units: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryColloidsInfused2Units")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Colloids 2 CC: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryColloidsInfused2CC")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Colloids 2 Unit Given: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryColloidsInfused2UnitGiven")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Colloids 3 Type: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryColloidsInfused3Type")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Colloids 3 Units: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryColloidsInfused3Units")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Colloids 3 CC: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryColloidsInfused3CC")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Colloids 3 Unit Given: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryColloidsInfused3UnitGiven")%></font></td>
	    </tr>
	  </table>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i>Coroner</i></b></font>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <table border="0" width="100%" rules="NONE" frame="VOID">
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Coroner Case: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=YN(rs("SecondaryCoronerCase"))%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>CaseNumber: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryCoronerCaseNumber")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>State: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryCoronerState")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Organization: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryCoronerOrganization")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>County: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryCoronerCounty")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Investigator Name: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryCoronerInvestigatorName")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Investigator Phone: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryCoronerInvestigatorPhone")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Released: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryCoronerReleased")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Released Stipulations: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryCoronerReleasedStipulations")%></font></td>
	    </tr>
	  </table>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i>Crystalloids</i></b></font>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <table border="0" width="100%" rules="NONE" frame="VOID">
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Crystalloids: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=YN(rs("SecondaryCrystalloids"))%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Crystalloids 1 Type: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryCrystalloids1Type")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Crystalloids 1 Units: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryCrystalloids1Units")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Crystalloids 1 CC: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryCrystalloids1CC")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Crystalloids 1 Unit Given: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryCrystalloids1UnitGiven")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Crystalloids 2 Type: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryCrystalloids2Type")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Crystalloids 2 Units: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryCrystalloids2Units")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Crystalloids 2 CC: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryCrystalloids2CC")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Crystalloids 2 Unit Given: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryCrystalloids2UnitGiven")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Crystalloids 3 Type: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryCrystalloids3Type")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Crystalloids 3 Units: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryCrystalloids3Units")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Crystalloids 3 CC: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryCrystalloids3CC")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Crystalloids 3 Unit Given: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryCrystalloids3UnitGiven")%></font></td>
	    </tr>
	  </table>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i>Culture</i></b></font>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <table border="0" width="100%" rules="NONE" frame="VOID">
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Culture 1 Type: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryCulture1Type")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Culture 1 Drawn Date: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryCulture1DrawnDate")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Culture 1 Growth: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryCulture1Growth")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Culture 2 Type: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryCulture2Type")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Culture 2 Drawn Date: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryCulture2DrawnDate")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Culture 2 Growth: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryCulture2Growth")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Culture 3 Type: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryCulture3Type")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Culture 3 Drawn Date: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryCulture3DrawnDate")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Culture 3 Growth: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryCulture3Growth")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Sputum Characteristics: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondarySputumCharacteristics")%></font></td>
	    </tr>
	    <tr>
	    </tr>
	  </table>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i>CXR</i></b></font>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <table border="0" width="100%" rules="NONE" frame="VOID">
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>CXR Available: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=YN(rs("SecondaryCXRAvailable"))%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>CXR 1 Date: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryCXR1Date")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>CXR 1 Finding: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryCXR1Finding")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>CXR 2 Date: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryCXR2Date")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>CXR 2 Finding: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryCXR2Finding")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>CXR 3 Date: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryCXR3Date")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>CXR 3 Finding: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryCXR3Finding")%></font></td>
	    </tr>
	  </table>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i>DOD/COD/PCP/Attending</i></b></font>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <table border="0" width="100%" rules="NONE" frame="VOID">
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>DOD - Cardiac: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryPatientDOD")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>TOD - Cardiac: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryPatientTOD")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Brain Death Date: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryBrainDeathDate")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Brain Death Time: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryBrainDeathTime")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Cause of Death: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryCOD")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Signatory for COD: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryCODSignatory")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>PCP Name: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryPCPName")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>PCP Phone: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryPCPPhone")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>MD Attending: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("ReferralAttendingMD")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>MD Attending Phone: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryMDAttendingPhone")%></font></td>
	    </tr>
	    <tr>
	    </tr>
	  </table>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i>Funeral Home</i></b></font>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <table border="0" width="100%" rules="NONE" frame="VOID">
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Selected: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=YN(rs("SecondaryFuneralHomeSelected"))%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Name: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryFuneralHomeName")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Phone: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryFuneralHomePhone")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Address: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryFuneralHomeAddress")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Contact: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryFuneralHomeContact")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Notified: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=YN(rs("SecondaryFuneralHomeNotified"))%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Morgue Cooled: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=YN(rs("SecondaryFuneralHomeMorgueCooled"))%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Hold On Body: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=YN(rs("SecondaryHoldOnBody"))%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Hold On Body Tag: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryHoldOnBodyTag")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Reminder: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryFHReminder")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Reminder (Y/N): </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=YN(rs("SecondaryFHReminderYN"))%></font></td>
	    </tr>
	  </table>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i>History</i></b></font>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <table border="0" width="100%" rules="NONE" frame="VOID">
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Triage History: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("ReferralNotesCase")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Patient Ventilated: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("ReferralDonorOnVentilator")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Circumstances Of Death: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryCircumstanceOfDeath")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Sign of Infection: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=YN(rs("SecondarySignOfInfection"))%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Medical History: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryMedicalHistory")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Physical Appearance: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryPhysicalAppearance")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Substance Abuse History: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=YN(rs("SecondaryHistorySubstanceAbuse"))%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Substance Abuse Details: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondarySubstanceAbuseDetail")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Additional Comments: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=(rs("SecondaryAdditionalComments"))%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b></b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"></font></td>
	    </tr>
	    <tr>
	    </tr>
	  </table>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i>Hospital</i></b></font>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <table border="0" width="100%" rules="NONE" frame="VOID">
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Hospital Name: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryPatientHospitalName")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Given Phone #: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryPatientPhone")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Hospital Unit: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryPatientHospitalUnit")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Hospital Floor: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("ReferralCallerSubLocationLevel")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Contact Name: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryPatientContactName")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Contact Title: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryPatientContactTitle")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Medical Record Number: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryPatientMedicalRecordNumber")%></font></td>
	    </tr>
	  </table>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i>Medications</i></b></font>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <table border="0" width="100%" rules="NONE" frame="VOID">
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Medication/Rx: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=YN(rs("SecondaryMedication"))%></font></td>
	    </tr>
	    
	    <%'Loop through and display medications
	      dim p
	      dim vEvenRow
	      p = 1
	      vEvenRow = false
	      
	      if not rs_meds.eof then
		while not rs_meds.eof
			if not vEvenRow then%>
				<tr>
			<%end if%>
			
			<td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Medication <%=p%>: </b></font></td>
	      		<td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs_meds("MedicationName")%></font></td>
			
			<%if vEvenRow then
				vEvenRow = false%>
				</tr>
			<%else
				vEvenRow = true
			end if
			
			p = p + 1
			rs_meds.movenext
	      	wend
	      	
	      	if vEvenRow then%>
	      		</tr>
	      	<%end if
  	    end if%>
	    
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Additional Medications: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryAdditionalMedications")%></font></td>
	    </tr>
	    
	    <tr>
	    </tr>
	  </table>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i>NOK</i></b></font>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">	  
	  <table border="0" width="100%" rules="NONE" frame="VOID">
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Name: </b></font></td>
	       <%if rs("ReferralNOKID") > 0 then%>
			<td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryNOKName")%></font></td>
	      <%else%>
			<td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("ReferralApproachNOK")%></font></td>
	      <%end if%>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Phone: </b></font></td>
	       <%if rs("ReferralNOKID") > 0 then%>
			 <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryNOKPhone")%></font></td>
	      <%else%>
			 <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("ReferralNOKPhone")%></font></td>
	      <%end if%>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Alt Phone: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryNOKAltPhone")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Relation: </b></font></td>
	       <%if rs("ReferralNOKID") > 0 then%>
			  <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryNOKRelation")%></font></td>
	      <%else%>
			  <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("ReferralApproachRelation")%></font></td>
	      <%end if%>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>NOK Gender: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryNOKGender")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Address: </b></font></td>
	      <%if rs("ReferralNOKID") > 0 then%>
			 <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryNOKAddress")%></font></td>
	      <%else%>
			 <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("ReferralNOKAddress")%></font></td>
	      <%end if%>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Legal NOK: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=YN(rs("SecondaryNOKLegal"))%></font></td>
	    </tr>
	  </table>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i>Patient</i></b></font>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <table border="0" width="100%" rules="NONE" frame="VOID">
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Last Name: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryPatientLastName")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Middle Name: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryPatientMiddleName")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>First Name: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryPatientFirstName")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Suffix: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryPatientSuffix")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>DOB: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryPatientDOB")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Age: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryPatientAge")%>&nbsp;<%=rs("SecondaryPatientAgeUnit")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Sex: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryPatientGender")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Race: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryPatientRace")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>SSN: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryPatientSSN")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Weight: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryPatientWeight")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Height: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryPatientHeightFeet")%>&nbsp;ft.&nbsp;<%=rs("SecondaryPatientHeightInches")%>&nbsp;in.</font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>BMI: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryPatientBMICalc")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>ABO: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryPatientABO")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b></b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"></font></td>
	    </tr>
	    <tr>
	    </tr>
	  </table>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i>Post Mortem</i></b></font>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <table border="0" width="100%" rules="NONE" frame="VOID">
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Sample Test Suitable: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=YN(rs("SecondaryPostMordemSampleTestSuitable"))%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Location: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryPostMordemSampleLocation")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Contact: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryPostMordemSampleContact")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Collection Date: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryPostMordemSampleCollectionDate")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Collection Time: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryPostMordemSampleCollectionTime")%></font></td>
	    </tr>
	  </table>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i>Post-Mortem</i></b></font>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <table border="0" width="100%" rules="NONE" frame="VOID">
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Examination Authorized: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=YN(rs("SecondaryNOKPostMortemAuthorization"))%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Reminder: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryNOKPostMortemAuthorizationReminder")%></font></td>
	    </tr>
	    <tr>
	    </tr>
	  </table>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i>Pre-Transfusion</i></b></font>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <table border="0" width="100%" rules="NONE" frame="VOID">
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Sample Required: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=YN(rs("SecondaryPreTransfusionSampleRequired"))%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Sample Available: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=YN(rs("SecondaryPreTransfusionSampleAvailable"))%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Drawn Date: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryPreTransfusionSampleDrawnDate")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Drawn Time: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryPreTransfusionSampleDrawnTime")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Quantity: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryPreTransfusionSampleQuantity")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Held At: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryPreTransfusionSampleHeldAt")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Held Date: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryPreTransfusionSampleHeldDate")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Held Time: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryPreTransfusionSampleHeldTime")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Sample Held Teck: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryPreTransfusionSampleHeldTechnician")%></font></td>
	    </tr>
	  </table>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i>Temp</i></b></font>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <table border="0" width="100%" rules="NONE" frame="VOID">
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Lab Temp 1 Date: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryLabTemp1Date")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Lab Temp 1 Time: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryLabTemp1Time")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Lab Temp 1: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryLabTemp1")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Lab Temp 2 Date: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryLabTemp2Date")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Lab Temp 2 Time: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryLabTemp2Time")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Lab Temp 2: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryLabTemp2")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Lab Temp 3 Date: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryLabTemp3Date")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Lab Temp 3 Time: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryLabTemp3Time")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Lab Temp 3: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryLabTemp3")%></font></td>
	    </tr>
	  </table>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i>WBC</i></b></font>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <table border="0" width="100%" rules="NONE" frame="VOID">
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>WBC 1: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryWBC1")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>WBC 1 Date: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryWBC1Date")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>WBC 1 Bands: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryWBC1Bands")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>WBC 2: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryWBC2")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>WBC 2 Date: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryWBC2Date")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>WBC 2 Bands: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryWBC2Bands")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>WBC 3: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryWBC3")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>WBC 3 Date: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryWBC3Date")%></font></td>
	    </tr>
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>WBC 3 Bands: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryWBC3Bands")%></font></td>
	    </tr>
	  </table>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><i>Wrap-Up Items</i></b></font>
	  <hr align="CENTER" color="#000000" noshade size="1" width="100%">
	  <table border="0" width="100%" rules="NONE" frame="VOID">
	    <tr>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Reminder: </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=rs("SecondaryWrapUpReminder")%></font></td>
	      <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Reminder (Y/N): </b></font></td>
	      <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=YN(rs("SecondaryWrapUpReminderYN"))%></font></td>
	    </tr>
	    <tr>
	    </tr>
	  </table><br><br>
  <%END IF%>
  