 
<%
Function CountWarning(pvCountLimit)

	Dim ReferralCount

	Conn.CommandTimeOut = 120		
	'Referral Count
	vQuery = "sps_ReferralCountType '" & pvStartDate & "', '" & pvEndDate & "', " & pvReferralTypeID & ", " & pvReportGroupID & ", " & pvOrgID
	'Response.Write vQuery
	Set RS = Conn.Execute(vQuery)
	
	Conn.CommandTimeOut = 30
	
	If RS.EOF = True Then
		ReferralCount = 0
	Else
		ReferralCount = RS("ReferralCount")
	End If

	If ReferralCount > pvCountLimit Then%>
		
		<hr align="CENTER" color="#000000" noshade size="1" width="100%">
				
		<br><strong><font color="#FF0000" FACE="Arial">Warning! Count Limit Exceeded!</font></strong></br>

		<br>You are about to retrieve <font color="#FF0000"><b><%=ReferralCount%></b></font> referral records.
		Retrieving this many records will take a considerable amount of time to download (and may use
		all the memory on your computer). You may only retrieve up to <B><%=pvCountLimit%></B> records for this type of
		report. Please change your criteria to generate a smaller data set (e.g. limit by referral type or
		organization) or use a different report to satisfy your requirement.</br>
		
		<br>
		
		<input type="image" src="/loginstatline/images/close2.gif" name="close" onclick="javascript:window.top.close();" language="JavaScript">
	
		</br>
		
		<br>
		<hr align="CENTER" color="#000000" noshade size="1" width="100%"></hr>
			
		<FONT SIZE="1" FACE="Arial">	
		If you would like assistance determining the best method of satisfying your reporting requirements, please contact Ian
		Client Services at (888) 881-7828 or email at 
		<!--#include virtual="/loginstatline/includes/ClientServicesMailTo.sls"-->.
		</FONT>
		</br>
					
		<%
		CountCheck = "True"
		
	Else
		
		CountCheck = "False"
			
	End If
	
End Function

%>
