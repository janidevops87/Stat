<%
Function VerifyReferralTypeAccess(pvDisplayMsg)

	Dim ReferralTypeAccessList
	

	
	'Verify referral type access 
	vQuery = "sps_ReferralTypeViewAccess " & UserOrgID
	Set RS = Conn.Execute(vQuery)	
	ReferralTypeAccessList = RS.GetRows
	
	Set RS = Nothing
		
	If ReferralTypeID = 0 Then
		
		'Check if all access is allowed
		If ReferralTypeAccessList(2,0) = 1 _
		And ReferralTypeAccessList(2,1) = 1 _
		And ReferralTypeAccessList(2,2) = 1 _
		And ReferralTypeAccessList(2,3) = 1 Then
			AccessAllowed = True
		Else
			AccessAllowed = False
		End If
		
	Else
		
		'Check if selected referral type is restricted
		For i = 0 to Ubound(ReferralTypeAccessList,2)
			If CInt(ReferralTypeID) = ReferralTypeAccessList(0,i) Then
				If ReferralTypeAccessList(2,i) = 1 Then
					AccessAllowed = True
				Else
					AccessAllowed = False
				End If
			End If
		Next
		
	End If
		
	If AccessAllowed = False Then
		
		If pvDisplayMsg = True Then
			vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
			vErrorMsg = vErrorMsg & "<BR>Invalid Referral Type."
			vErrorMsg = vErrorMsg & "<BR>You do not have access to data from selected referral type.</BR>"
			vErrorMsg = vErrorMsg & "</B></FONT>"
				
			vErrorMsg = vErrorMsg & "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
			vErrorMsg = vErrorMsg & "<BR>If you continue to have difficulty, "
			vErrorMsg = vErrorMsg & "please contact Statline at (888) 881-7828 for assistance.</B></BR>"
			vErrorMsg = vErrorMsg & "</B></FONT>"
				
			Response.Write(vErrorMsg)
		End If
		
		VerifyReferralTypeAccess = False
		Set Conn = Nothing
		Set RS = Nothing				
		Exit Function
	
	End If		
		
	Set RS = Nothing			
	VerifyReferralTypeAccess = True
		
End Function
%>