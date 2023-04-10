<%	dim strHttpHeader
	'If Request.ServerVariables("SERVER_PORT_SECURE")=1 then
	strHttpHeader = "HTTPS://"
%>
		<script language="JavaScript">
			var strHttpHeader = "HTTPS://"
		</script>






<!--#include virtual="/loginstatline/includes/CheckAuthorization.sls"-->
<!--#include virtual="/loginstatline/includes/DBConnection.sls"-->
<!--#include virtual="/loginstatline/includes/LogoUtility.sls"-->
<!--#include virtual="/loginstatline/includes/ADOVBS.INC"-->
<%
Dim DataSourceName
Dim UserId
Dim UserOrgID
Dim ReferralTypeID
Dim ReferralTypeAccessList

Dim ReportID
Dim NoLog
Dim vQueryString
Dim AccessAllowed
Dim DatesArray
Dim ArrayCount
Dim ReportGroupID

Dim Security
Dim SessionValid
Dim vErrorResult
Dim Conn
Dim vQuery
Dim RS

Function AuthorizeMain
	


	AuthorizeMain = False

	'Check to see if the user is authorized	
	CheckAuthorization
	
	UserID= Session("StatlineUserID") 
	
	UserOrgID = FormatNumber(Request("UserOrgID"),0,,0,0)
	ReportID = FormatNumber(Request("ReportID"),0,,0,0)
	ReportGroupID = FormatNumber(Request("ReportGroupID"),0,,0,0)
	If ReportID = "" Then
		ReportID = 0
	End If
	NoLog = Request("NoLog")
	Call FixQueryString(Request("StartDate"), pvStartDate)
	Call FixQueryString(Request("EndDate"), pvEndDate)
	'Print("Authorize:pvStartDate" & pvStartDate)
	ReferralTypeID = FormatNumber(Request("ReferralType"),0,,0,0)

	''Use DetermineReportingDSN function to get a connection DSN
	DataSourceName = REPORTINGDSN 
	'DetermineReportingDSN(Request("DSN"),pvStartDate,pvEndDate)

	

	If IsEmpty(DataSourceName) and Not IsStat() Then
		PrintError "Date Range is invalid. <BR> Change your date range before or after " + CStr(rs.Fields("maxDate")), "Get Reporting DSN", "DBConnection.sls"
		AuthorizeMain = False
		Set Security = Nothing
		Set Conn = Nothing
		Set RS = Nothing
		Exit Function
	ElseIf IsEmpty(DataSourceName) and IsStat() Then
		DataSourceName = REPORTINGDSN
	End If

	'Print "Authorize " & DataSourceName

	 

	''Establish a database connection
	Set Conn = server.CreateObject("ADODB.Connection")	
	Conn.Open TRANSACTIONDSN, DBUSER, DBPWD
	
	'Print Reportingdsn

	'First check if the user is authorized
	vQuery = "sps_AuthenticateUser '0', '0', " & UserID & ", " & UserOrgID
	'Response.Write vQuery
	Set RS = Conn.Execute(vQuery)

	'There was a db error
	If Conn.Errors.Count > 0 Then
		vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
		vErrorMsg = vErrorMsg & "There has been a database error. <BR>"
		vErrorMsg = vErrorMsg & "Please hit refresh to try your request again. <BR> <BR>"
		vErrorMsg = vErrorMsg & "If the problem continues, <BR>"
		vErrorMsg = vErrorMsg & "please contact Statline at (888) 881-7828 for assistance.</B><BR> <BR> <BR>"
		vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
		vErrorMsg = vErrorMsg & "Error:     (" & ErrorReturn & ", Authorize.sls) <BR> <BR>"
		vErrorMsg = vErrorMsg & "</FONT></FONT>"
		Response.Write(vErrorMsg)
		AuthorizeMain = False
		Set Security = Nothing
		Set Conn = Nothing
		Set RS = Nothing
		Exit Function
	End If

	'There was no user found
	If RS.EOF Then
		vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
		vErrorMsg = vErrorMsg & "Unauthorized User. <BR> <BR>"
		vErrorMsg = vErrorMsg & "If you continue to have difficulty, <BR>"
		vErrorMsg = vErrorMsg & "Please contact Statline at (888) 881-7828 for assistance.</B><BR> <BR> <BR>"
		vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
		vErrorMsg = vErrorMsg & "Error:     (100, Authorize.sls) <BR> <BR>"
		vErrorMsg = vErrorMsg & "</FONT></FONT>"
		Response.Write(vErrorMsg)
		AuthorizeMain = False
		Set Security = Nothing
		Set Conn = Nothing
		Set RS = Nothing
		Exit Function
	End If

	'If the user is not Statline, then check if the session is valid
	If UserOrgID <> 194 Then

		vQuery = _
		"SELECT WebPerson.WebPersonLastSessionAccess " & _
		"FROM WebPerson " & _
		"WHERE WebPersonID = " & CLng(UserID)

		Set RS = Conn.Execute(vQuery)

		If Conn.Errors.Count > 0 Then
			vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
			vErrorMsg = vErrorMsg & "There has been a database error. <BR>"
			vErrorMsg = vErrorMsg & "Please hit refresh to try your request again. <BR> <BR>"
			vErrorMsg = vErrorMsg & "If the problem continues, <BR>"
			vErrorMsg = vErrorMsg & "please contact Statline at (888) 881-7828 for assistance.</B><BR> <BR> <BR>"
			vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
			vErrorMsg = vErrorMsg & "Error:     (" & ErrorReturn & ", Authorize.sls) <BR> <BR>"
			vErrorMsg = vErrorMsg & "</FONT></FONT>"
			Response.Write(vErrorMsg)
			AuthorizeMain = False
			Set Security = Nothing
			Set Conn = Nothing
			Set RS = Nothing
			Exit Function
		End If

		If DateAdd("n", 30, RS("WebPersonLastSessionAccess")) > Now Then

			'Since the user has been authorized and the session is valid, update the last session access field
			'so the last access is set to now
			vQuery = "UPDATE WebPerson SET WebPersonLastSessionAccess = '" & CDate(Now) & "' WHERE WebPersonID = " & CLng(UserID)
			Call Conn.Execute(vQuery)

			If Conn.Errors.Count > 0 Then
				vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
				vErrorMsg = vErrorMsg & "There has been a database error. <BR>"
				vErrorMsg = vErrorMsg & "Please hit refresh to try your request again. <BR> <BR>"
				vErrorMsg = vErrorMsg & "If the problem continues, <BR>"
				vErrorMsg = vErrorMsg & "please contact Statline at (888) 881-7828 for assistance.</B><BR> <BR> <BR>"
				vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
				vErrorMsg = vErrorMsg & "Error:     (" & ErrorReturn & ", Authorize.sls) <BR> <BR>"
				vErrorMsg = vErrorMsg & "</FONT></FONT>"
				Response.Write(vErrorMsg)
				AuthorizeMain = False
				Set Security = Nothing
				Set Conn = Nothing
				Set RS = Nothing
				Exit Function
			End If

		Else

			vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
			vErrorMsg = vErrorMsg & "Your session has timed-out. <BR>"
			vErrorMsg = vErrorMsg & "Please return to the login page and re-enter your login.</B> <BR>"
			vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
			vErrorMsg = vErrorMsg & "You are automatically logged out if there is no activity for 30 minutes.</FONT> <BR><BR>"
			vErrorMsg = vErrorMsg & "<B>If you continue to have difficulty, <BR>"
			vErrorMsg = vErrorMsg & "please contact Statline at (888) 881-7828 for assistance.</B> <BR> <BR> <BR>"
			vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
			vErrorMsg = vErrorMsg & "Error:     (" & ErrorReturn & ", Authorize.sls) <BR> <BR>"
			vErrorMsg = vErrorMsg & "</FONT></FONT>"
			Response.Write(vErrorMsg)
			AuthorizeMain = False
			Set Security = Nothing
			Set Conn = Nothing
			Set RS = Nothing
			Exit Function
		End If


	End If


	'The user has been authorized successfully, so continue
	AuthorizeMain = True

	'Log the access to the report if not a Statline user
	'If UserOrgID <> 194 And NoLog = "" And ReportID <> 0 Then '(ReportID <> "" Or ReportID <> 0) Then
	If UserOrgID <> 194 And NoLog = "" And ReportID <> 0 Then '(ReportID <> "" Or ReportID <> 0) Then
		Call ReportLog
	End If

	'Check the report date parameters for allowed access
	If UserOrgID <> 194 Then

		'Verfity Access Dates
		vQuery = "sps_ReportGroupAccessDate " & ReportGroupID
		'Print(vQuery)
		Set RS = Conn.Execute(vQuery)

		'If there are date restrictions
		'then test requested report date ranges (otherwise do nothing)
		If RS.EOF <> True Then
			AccessAllowed = False
			DatesArray = RS.GetRows
			For ArrayCount = 0 To UBound(DatesArray, 2)
				'Check for any ranges which are valid, otherwise access is not allowed
				If len(pvStartDate) < 1 and len(pvEndDate) < 1 Then
					'Print("pvCallID " & pvCallID)
					pvStartDate = GetCallDateTime(pvCallid)
					pvEndDate = pvStartDate
				End If
				If CDate(pvStartDate) >= DatesArray(1, ArrayCount) And CDate(pvEndDate) <= DatesArray(2, ArrayCount) Then
					AccessAllowed = True
					Exit For
				End If
			Next
		Else
			AccessAllowed = True
		End If

		If AccessAllowed = False Then

			vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
			vErrorMsg = vErrorMsg & "<BR>Invalid Report Dates."
			vErrorMsg = vErrorMsg & "<BR>You do not have access to data from the date range you have selected.</BR>"
			vErrorMsg = vErrorMsg & "</B></FONT>"

			vErrorMsg = vErrorMsg & "<FONT SIZE=2 FACE=Arial FONT COLOR = Black>"
			vErrorMsg = vErrorMsg & "<BR>You only have access to data between the following dates:"
			For ArrayCount = 0 To UBound(DatesArray, 2)
				vErrorMsg = vErrorMsg & "<BR>" & DatesArray(1, ArrayCount) & "  To  " & DatesArray(2, ArrayCount)
			Next
			vErrorMsg = vErrorMsg & "</FONT></BR>"

			vErrorMsg = vErrorMsg & "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
			vErrorMsg = vErrorMsg & "<BR>If you continue to have difficulty, "
			vErrorMsg = vErrorMsg & "please contact Statline at (888) 881-7828 for assistance.</B></BR>"
			vErrorMsg = vErrorMsg & "</B></FONT>"

			Response.Write(vErrorMsg)
			AuthorizeMain = False
			Set Security = Nothing
			Set Conn = Nothing
			Set RS = Nothing
			Exit Function

		End If

	End If

	Set Security = Nothing
	Set Conn = Nothing
	Set RS = Nothing

End Function
'07/16/02 - bjk: returns CallDateTime when StartDateTime does not exist
Function GetCallDateTime(pvCallID)
	dim rs
	dim conn
	dim DataSourceName

	If Request.QueryString("DSN") <> "" Then
		DataSourceName = Request.QueryString("DSN")
	Else
		DataSourceName = "Production"
	End If

	'Open Connection
	Set Conn = server.CreateObject("ADODB.Connection")
	Conn.Open DataSourceName, DBUSER, DBPWD

	vQuery = "Select CallDateTime FROM Call WHERE CallID = " & pvCallID
	'Print(vQuery)

	Set rs = Server.CreateObject("ADODB.Recordset")
	rs.Open vQuery, conn, 3, 3

	'old method below
	'Set RS = Conn.Execute(vQuery)

	If not rs.EOF then
		GetCallDateTime = RS("CallDateTime")
	End If

End Function
Function ReportLog

	vQueryString = Left(Request.ServerVariables("QUERY_STRING"),199)

	'Log the report access.
	vQuery = "spi_ReportLog '" & Now & "', " & CInt(ReportID) & ", " & CLng(UserID) & ", '" & Request.ServerVariables("REMOTE_ADDR") & "', '" & vQueryString & "'"

	Call Conn.Execute(vQuery)



End Function

Sub FixQueryString(pvIn, pvOut)
	Dim x
	pvOut = ""
	For x=1 TO Len(pvIn)
		If Mid(pvIn,x,1) = "_" Then
			pvOut = pvOut & " "
		Else
			pvOut = pvOut & Mid(pvIn,x,1)
		End If
	Next
End Sub

'00.0831 - ttw: Returns StatEmployee user name proper...
Function GetUserName(pvUserID)
	dim intPersonId
	dim rsStatEmployee
	dim rs
	dim conn
	dim DataSourceName

	If Request.QueryString("DSN") <> "" Then
		DataSourceName = Request.QueryString("DSN")
	Else
		DataSourceName = "Production"
	End If

	'Open Connection
	Set Conn = server.CreateObject("ADODB.Connection")
	Conn.Open DataSourceName, DBUSER, DBPWD

	'Get the user ID
	vQuery = "SELECT * FROM WebPerson"
	vQuery = vQuery & " WHERE WebPersonId = " & pvUserId & ";"
	'Response.Write(vQuery)

	'ttw method of access to database
	Set rs = Server.CreateObject("ADODB.Recordset")
	rs.Open vQuery, conn, 3, 3

	'old method below
	'Set RS = Conn.Execute(vQuery)

	If rs.EOF then
		GetUserName = "Invalid User"
	Else
		'check for existing survey for person.
		rs.MoveFirst
		intPersonId = rs.Fields("PersonID")
		'Get the user name
		vQuery = "SELECT * FROM StatEmployee"
		vQuery = vQuery & " WHERE PersonId = " & intPersonId & ";"
		'Response.Write(vQuery)

		Set rsStatEmployee = Server.CreateObject("ADODB.Recordset")
		rsStatEmployee.Open vQuery, conn, 3, 3
		If rsStatEmployee.EOF then
			GetUserName = "Database error..."
		Else
			rsStatEmployee.MoveFirst
			GetUserName = rsStatEmployee.Fields("StatEmployeeFirstName") & " " & rsStatEmployee.Fields("StatEmployeeLastName")
		End If
	End If
End Function

'00.0831 - ttw: Returns user Login...
Function GetUserLogin(pvUserID)
	If Request.QueryString("DSN") <> "" Then
		DataSourceName = Request.QueryString("DSN")
	Else
		DataSourceName = "Production"
	End If

	'Open Connection
	Set Conn = server.CreateObject("ADODB.Connection")
	Conn.Open DataSourceName, DBUSER, DBPWD

	'Get the user ID
	vQuery = "SELECT * FROM WebPerson"
	vQuery = vQuery & " WHERE WebPersonId = " & pvUserId & ";"
	'Response.Write(vQuery)

	'ttw method of access to database
	Set rs = Server.CreateObject("ADODB.Recordset")
	rs.Open vQuery, conn, 3, 3

	'old method below
	'Set RS = Conn.Execute(vQuery)

	If rs.EOF then
		GetUserLogin = ""
	Else
		'check for existing survey for person.
		rs.MoveFirst
		GetUserLogin = rs.Fields("WebPersonUserName")
	End If
End Function

'00.0831 - ttw: Returns user Org ID...
Function GetUserLoginOrgID(pvUserLogin)
	dim intPersonId
	dim rsStatEmployee

	If Request.QueryString("DSN") <> "" Then
		DataSourceName = Request.QueryString("DSN")
	Else
		DataSourceName = "Production"
	End If

	'Open Connection
	Set Conn = server.CreateObject("ADODB.Connection")
	Conn.Open DataSourceName, DBUSER, DBPWD

	'Get the user ID
	vQuery = "SELECT * FROM WebPerson"
	vQuery = vQuery & " WHERE WebPersonUserName = '" & pvUserLogin & "';"
	'Response.Write(vQuery)

	'ttw method of access to database
	Set rs = Server.CreateObject("ADODB.Recordset")
	rs.Open vQuery, conn, 3, 3

	'old method below
	'Set RS = Conn.Execute(vQuery)

	If rs.EOF then
		GetUserLoginOrgID = 0
	Else
		'check for existing survey for person.
		rs.MoveFirst
		intPersonId = rs.Fields("PersonID")
		'Get the user name
		vQuery = "SELECT * FROM StatEmployee"
		vQuery = vQuery & " WHERE PersonId = " & intPersonId & ";"
		'Response.Write(vQuery)

		Set rsStatEmployee = Server.CreateObject("ADODB.Recordset")
		rsStatEmployee.Open vQuery, conn, 3, 3
		If rsStatEmployee.EOF then
			GetUserLoginOrgID = 0
		Else
			rsStatEmployee.MoveFirst
			GetUserLoginOrgID = 194
		End If
	End If
End Function

'00.0831 - ttw: Returns user password...
Function GetUserLoginPassword(pvUserLogin)
	If Request.QueryString("DSN") <> "" Then
		DataSourceName = Request.QueryString("DSN")
	Else
		DataSourceName = "Production"
	End If

	'Open Connection
	Set Conn = server.CreateObject("ADODB.Connection")
	Conn.Open DataSourceName, DBUSER, DBPWD

	'Get the user ID
	vQuery = "SELECT * FROM WebPerson"
	vQuery = vQuery & " WHERE WebPersonUserName = '" & pvUserLogin & "';"
	'Response.Write(vQuery)

	'ttw method of access to database
	Set rs = Server.CreateObject("ADODB.Recordset")
	rs.Open vQuery, conn, 3, 3

	'old method below
	'Set RS = Conn.Execute(vQuery)

	If rs.EOF then
		GetUserLoginPassword = ""
	Else
		'check for existing survey for person.
		rs.MoveFirst
		GetUserLoginPassword = rs.Fields("WebPersonPassword")
	End If
End Function

'00.0831 - ttw: Returns user password...
Function GetUserIDPassword(pvUserID)
	If Request.QueryString("DSN") <> "" Then
		DataSourceName = Request.QueryString("DSN")
	Else
		DataSourceName = "Production"
	End If

	'Open Connection
	Set Conn = server.CreateObject("ADODB.Connection")
	Conn.Open DataSourceName, DBUSER, DBPWD

	'Get the user ID
	vQuery = "SELECT * FROM WebPerson"
	vQuery = vQuery & " WHERE WebPersonID = '" & pvUserID & "';"
	'Response.Write(vQuery)

	'ttw method of access to database
	Set rs = Server.CreateObject("ADODB.Recordset")
	rs.Open vQuery, conn, 3, 3

	'old method below
	'Set RS = Conn.Execute(vQuery)

	If rs.EOF then
		GetUserIDPassword = ""
	Else
		'check for existing survey for person.
		rs.MoveFirst
		GetUserIDPassword = rs.Fields("WebPersonPassword")
	End If
End Function

'00.0906 - ttw: Returns user password...
Function GetUserIDAccessLevel(pvUserID)
	dim intPersonId
	dim rsStatEmployee

	If Request.QueryString("DSN") <> "" Then
		DataSourceName = Request.QueryString("DSN")
	Else
		DataSourceName = "Production"
	End If

	'Open Connection
	Set Conn = server.CreateObject("ADODB.Connection")
	Conn.Open DataSourceName, DBUSER, DBPWD

	'Get the user ID
	vQuery = "SELECT * FROM WebPerson"
	vQuery = vQuery & " WHERE WebPersonId = " & pvUserId & ";"
	'Response.Write(vQuery)

	'ttw method of access to database
	Set rs = Server.CreateObject("ADODB.Recordset")
	rs.Open vQuery, conn, 3, 3

	'old method below
	'Set RS = Conn.Execute(vQuery)

	If rs.EOF then
		GetUserIDAccessLevel = 0
	Else
		'check for existing survey for person.
		rs.MoveFirst
		intPersonId = rs.Fields("PersonID")
		'Get the user name
		vQuery = "SELECT * FROM StatEmployee"
		vQuery = vQuery & " WHERE PersonId = " & intPersonId & ";"
		'Response.Write(vQuery)

		Set rsStatEmployee = Server.CreateObject("ADODB.Recordset")
		rsStatEmployee.Open vQuery, conn, 3, 3
		If rsStatEmployee.EOF then
			GetUserIDAccessLevel = 0
		Else
			rsStatEmployee.MoveFirst
			GetUserIDAccessLevel = rsStatEmployee.Fields(18)
		End If
	End If
End Function
Function IsStat()
	IsStat= False

	On Error Resume Next
	If IsEmpty(DataWarehouseConn) Then
		If Err Then
			IsStat=False
			Exit Function
		End If
		IsStat= True
	End If

End Function

'01.0730 - ttw: Returns user Stat ID...
Function GetUserStatID(pvUserWebId)
	dim intPersonId
	dim rsStatEmployee

	If Request.QueryString("DSN") <> "" Then
		DataSourceName = Request.QueryString("DSN")
	Else
		DataSourceName = "Production"
	End If

	'Open Connection
	Set Conn = server.CreateObject("ADODB.Connection")
	Conn.Open DataSourceName, DBUSER, DBPWD

	'Get the user ID
	vQuery = "SELECT * FROM WebPerson"
	vQuery = vQuery & " WHERE WebPersonID = " & pvUserWebId
	'Response.Write(vQuery)

	'ttw method of access to database
	Set rs = Server.CreateObject("ADODB.Recordset")
	rs.Open vQuery, conn, 3, 3

	'old method below
	'Set RS = Conn.Execute(vQuery)

	If rs.EOF then
		GetUserStatID = 0
	Else
		'check for existing survey for person.
		rs.MoveFirst
		intPersonId = rs.Fields("PersonID")
		'Get the user name
		vQuery = "SELECT * FROM StatEmployee"
		vQuery = vQuery & " WHERE PersonId = " & intPersonId & ";"
		'Response.Write(vQuery)

		Set rsStatEmployee = Server.CreateObject("ADODB.Recordset")
		rsStatEmployee.Open vQuery, conn, 3, 3
		If rsStatEmployee.EOF then
			GetUserStatID = 0
		Else
			rsStatEmployee.MoveFirst
			GetUserStatID = rsStatEmployee.Fields("StatEmployeeID")
		End If
	End If
End Function
Function GetUserLoginUserID(pvUserLogin)
	dim intPersonId
	dim rsStatEmployee

	If Request.QueryString("DSN") <> "" Then
		DataSourceName = Request.QueryString("DSN")
	Else
		DataSourceName = "Production"
	End If

	'Open Connection
	Set Conn = server.CreateObject("ADODB.Connection")
	Conn.Open DataSourceName, DBUSER, DBPWD

	'Get the user ID
	vQuery = "SELECT * FROM WebPerson"
	vQuery = vQuery & " WHERE WebPersonUserName = '" & pvUserLogin & "';"
	'Response.Write(vQuery)

	'ttw method of access to database
	Set rs = Server.CreateObject("ADODB.Recordset")
	rs.Open vQuery, conn, 3, 3

	'old method below
	'Set RS = Conn.Execute(vQuery)

	If rs.EOF then
		GetUserLoginUserID = 0
	Else
		GetUserLoginUserID = rs("WebPersonID")
	End If
End Function


%>
