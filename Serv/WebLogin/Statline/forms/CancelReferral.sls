<html>
<head>
</head>
<body onLoad="javascript:self.close();">
<!--#include virtual="/loginstatline/includes/Authorize.sls"-->

<%
If AuthorizeMain then
	DataSourceName = "ProductionTransaction"
	
	Set Conn = server.CreateObject("ADODB.Connection")
	Conn.Open DataSourceName, DBUSER, DBPWD
	
	'See if User still has the referral open
	vQuery = "sps_IncompleteReferralDetail1 " & Request("TZ") & ", " & Request("CallID")
	'Response.Write(vQuery)
	Set RS = Conn.Execute(vQuery)
	
	'Response.Write("<br>" & RS("CallOpenByID") & "<br>" & RS("CallOpenByWebPersonId") & "<br>")

	'If User does have it open, then close it
	If RS("CallOpenByID") = 0 and RS("CallOpenByWebPersonId") = CInt(Request("UserID")) Then
		vQuery = "EXEC spu_SaveCallOpenBy " & Request("CallID") & ", -1, -1, 77, 3" 
		'Response.Write(vQuery)
		Set RS1 = Conn.Execute(vQuery)
	End If
End If

%>
</body>
</html>