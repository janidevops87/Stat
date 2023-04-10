<%
Option Explicit

Response.CacheControl = "no-cache" 
Response.AddHeader "Cache-Control", "private" 
Response.AddHeader "Pragma", "no-cache" 
Response.Expires = -1 

Dim OrgID
Dim YearID
Dim MonthID
Dim onTimeReferrals

Dim i
Dim UpdateSuccess
Dim ValidationMessage

Dim DebugMessage
DebugMessage = "<BR>Debug:"

%>

<!--#include virtual="/loginstatline/includes/Authorize.sls"-->
<%

'Update information
If UpdateOnTimeReferrals Then
	UpdateSuccess = True
	ValidationMessage = _
	"<FONT SIZE=4 FACE=Arial COLOR = Red>" & _
	"Update Successful." & _
	"</FONT>"
Else
	UpdateSuccess = False
	ValidationMessage = _
	"<FONT SIZE=4 FACE=Arial COLOR = Red>" & _
	"Update Failed." & _
	"</FONT>"
End If

%>



<html>

<head>
<meta http-equiv="Expires" content="now">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Process Update</title>
</head>

<body bgcolor="#F5EBDD">

	<%'Response.Write(ValidationMessage & "<BR>" & DebugMessage)%>
	<%Response.Write(ValidationMessage)%>

	<br></br>
	<%'Show a Back button if the update failed.
	If UpdateSuccess = False Then%>
		<A	HREF="javascript:window.history.back();" NAME="Back">
			<IMG src="/loginstatline/images/back.gif"
			NAME="Back"
			BORDER="0">
		</A>	
	<%End If%>
	
	<A	HREF="javascript:self.close();" NAME="Close">
		<IMG src="/loginstatline/images/close2.gif"
		NAME="Close"
		BORDER="0">
	</A>	
</body>
</html>



<%
Function UpdateOnTimeReferrals()

	'DataSourceName = WAREHOUSEDSN
	OrgID = Request.Form("OrgID")
	
	'Establish a database connection
	Set Conn = server.CreateObject("ADODB.Connection")
	Conn.Open WAREHOUSEDSN, DBUSER, DBPWD
	
	'drh 10/02/03 - Get the SourceCodeList
	Dim pvReportGroupID
	Dim vSourceCodeList	
	pvReportGroupID = FormatNumber(Request.QueryString("ReportGroupID"),0,,0,0)	
	vSourceCodeList = GetSourceCodeList(pvReportGroupID)

	i = 1
	
	Do While Request.Form("Row" & i) <> ""
	
		'Get the values
		onTimeReferrals = Request.Form("onTimeReferrals" & i)
		YearID = Request.Form("YearID" & i)
		MonthID = Request.Form("MonthID" & i)
		
		'First build the delete query
		vQuery = "DELETE OrganizationSuppliedData "
		'Specify the row to delete
		'drh 10/10/03 - Added SourceCodeList
		vQuery = vQuery & " WHERE YearID = " & YearID & " AND MonthID = " & MonthID & " AND OrganizationID = " & OrgID & " AND SourceCodeList = '" & vSourceCodeList & "'"

DebugMessage = DebugMessage & "<BR>" & vQuery

		Call Conn.Execute(vQuery)

		'Check if there was a db error
		If Conn.Errors.Count > 0 Then
			DebugMessage = DebugMessage & "<BR>" & Conn.Errors.Item(0).Description
			'Discontinue processing of the function
			UpdateOnTimeReferrals = False
			Exit Function
		End If
		
		'Next build the insert query
		'drh 10/10/03 - Added SourceCodeList
		vQuery = "INSERT OrganizationSuppliedData (YearID, MonthID, OrganizationID, SourceCodeList, OnTimeReferrals) "
		vQuery = vQuery & "VALUES (" & YearID & ", " & MonthID & ", " & OrgID & ", '" & vSourceCodeList & "', " & onTimeReferrals & ") "
	
DebugMessage = DebugMessage & "<BR>" & vQuery

		Call Conn.Execute(vQuery)
	
		'Check if there was a db error
		If Conn.Errors.Count > 0 Then
			DebugMessage = DebugMessage & "<BR>" & Conn.Errors.Item(0).Description
			'Discontinue processing of the function
			UpdateOnTimeReferrals = False
			Exit Function
		End If
	
		i = i + 1
		
	Loop
	
	UpdateOnTimeReferrals = True
	
End Function

Function GetSourceCodeList(ReportGroupId)

	'drh 10/02/03 - Get the SourceCodeList
	Dim Cmd
	Dim ps
	Set Cmd = CreateObject("ADODB.Command")
	Cmd.CommandText = "sps_GetReportGroupSourceCodeList"
	Cmd.CommandType = 4
	Set ps = Cmd.Parameters
	ps.Append Cmd.CreateParameter("ReportGroupID", 3, 1, 200, ReportGroupId)
	ps.Append Cmd.CreateParameter("SourceCodeList", 200, 2, 200)
	Cmd.ActiveConnection = Conn
	Cmd.Execute
		
	GetSourceCodeList = TRIM(Cmd("SourceCodeList"))

End Function

%>

