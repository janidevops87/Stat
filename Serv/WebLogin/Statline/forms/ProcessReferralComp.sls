<%
Option Explicit

Response.CacheControl = "no-cache" 
Response.AddHeader "Cache-Control", "private" 
Response.AddHeader "Pragma", "no-cache" 
Response.Expires = -1 

Dim OrgID
Dim YearID
Dim MonthID
Dim TotalDeaths

Dim i
Dim UpdateSuccess
Dim ValidationMessage

Dim DebugMode
Dim DebugMessage

DebugMode = False
DebugMessage = "<BR>Debug:"
%>
<!--#include virtual="/loginstatline/includes/Authorize.sls"-->
<%
'Update information
If UpdateReferral Then
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

<%	If DebugMode = True Then
		Response.Write(ValidationMessage & "<BR>" & DebugMessage)
	Else
		Response.Write(ValidationMessage)
	End If  %>

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
Function UpdateReferral()

	'DataSourceName = WAREHOUSEDSN
	OrgID = Request.Form("OrgID")
	'Set DataWarehouseConn = server.CreateObject("ADODB.Connection")
	'DataWarehouseConn.Open WAREHOUSEDSN, DBUSER, DBPWD
	
	Set Conn = server.CreateObject("ADODB.Connection")
	Conn.Open WAREHOUSEDSN, DBUSER, DBPWD

	'Establish a database connection
	'Set DataWarehouseConn = server.CreateObject("ADODB.Connection")
	'DataWarehouseConn.Open DataSourceName, DBUSER, DBPWD
	
	'drh 10/02/03 - Get the SourceCodeList
	Dim pvReportGroupID
	Dim vSourceCodeList	
	pvReportGroupID = FormatNumber(Request.QueryString("ReportGroupID"),0,,0,0)	
	vSourceCodeList = GetSourceCodeList(pvReportGroupID)
	
	
	i = 1
	
	Do While Request.Form("Row" & i) <> ""
	
		'Get the values
		TotalDeaths = Request.Form("totalDeaths" & i)
		YearID = Request.Form("YearID" & i)
		MonthID = Request.Form("MonthID" & i)
		
		'First build the delete query
		vQuery = "DELETE OrganizationDeaths "
		'Specify the row to delete
		'drh 10/02/03 - Added SourceCodeList
		vQuery = vQuery & " WHERE YearID = " & YearID & " AND MonthID = " & MonthID & " AND OrganizationID = " & OrgID 
		' Commented SourceCodeList out of delete to ensure those having permissions to edit 
		' will delete any duplicate existing records for a single hospital.  4/7/08 - SAP
		'''& " AND SourceCodeList = '" & vSourceCodeList & "'"

DebugMessage = DebugMessage & "<BR>" & vQuery

		Conn.Execute(vQuery)

		'Check if there was a db error
		If Conn.Errors.Count > 0 Then
			DebugMessage = DebugMessage & "<BR>" & Conn.Errors.Item(0).Description
			'Discontinue processing of the function
			UpdateReferral = False
			Exit Function
		End If
		
		'Next build the insert query
		'drh 10/02/03 - Added SourceCodeList
		vQuery = "INSERT OrganizationDeaths (YearID, MonthID, OrganizationID, SourceCodeList, TotalDeaths) "
		vQuery = vQuery & "VALUES (" & YearID & ", " & MonthID & ", " & OrgID & ", '" & vSourceCodeList & "', " & TotalDeaths & ") "
	
DebugMessage = DebugMessage & "<BR>" & vQuery
	
		Conn.Execute(vQuery)
	
		'Check if there was a db error
		If Conn.Errors.Count > 0 Then
			DebugMessage = DebugMessage & "<BR>" & Conn.Errors.Item(0).Description
			'Discontinue processing of the function
			UpdateReferral = False
			Exit Function
		End If
	
		i = i + 1
		
	Loop
	
	UpdateReferral = True
	
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

