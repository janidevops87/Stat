<%
Option Explicit

'Declare variables
Dim pvStartDate
Dim pvEndDate
Dim vErrorMsg
Dim ErrorReturn
Dim pvUserOrgID
Dim pvReportGroupID
Dim pvScheduleGroupID
Dim pvReferralTypeID
Dim vReportTitle
Dim pvScheduleAccess
Dim vTZ
Dim i
dim cmd
Dim vScheduleGroupName
Dim vSizeofRows
Dim ResultsArray
Dim ForLoopCounter
Dim ForLoopColumnCounter
'Dim Conn
'Dim RS
'Dim vQuery

Dim FontNameHead
Dim FontSizeHead
Dim FontNameData
Dim FontSizeData
Dim FontNameHeadLog
Dim FontSizeHeadLog
Dim FontSizeDataLog
Dim FontNameDataLog

'Declare format vaiables
FontNameHead = "Arial"
FontSizeHead = "2"
FontNameData = "Times New Roman"
FontSizeData = "1"
FontNameHeadLog = "Arial"
FontSizeHeadLog = "1.5"
FontNameDataLog = "Times New Roman"
FontSizeDataLog = "1.5"
%>

<html>

<head>
<meta http-equiv="Expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<title>Schedule Update</title>
</head>

<body  bgColor=#F5EBDD>
<!--#include virtual="/loginstatline/includes/Authorize.sls"-->

<%

'Execute the main page generating routine


	'Create a connection object
	DataSourceName = PRODUCTIONDSN
	Set Conn = server.CreateObject("ADODB.Connection")
	Conn.Open DataSourceName, DBUSER, DBPWD
	'Print Request.QueryString
	'Get the query variables
	Call FixQueryString(Request.QueryString("StartDate"), pvStartDate)
	Call FixQueryString(Request.QueryString("EndDate"), pvEndDate)
	pvUserOrgID = FormatNumber(Request.QueryString("UserOrgID"),0,,0,0)
	pvReportGroupID = FormatNumber(Request.QueryString("ReportGroupID"),0,,0,0)
	
	pvScheduleGroupID = FormatNumber(Request.QueryString("ScheduleGroupID"),0,,0,0)
	If Request.QueryString("ScheduleAccess") = 0 Then
		pvScheduleAccess = 	"UnAuthorized"
	ElseIF 	Request.QueryString("ScheduleAccess") = -1 Then
		pvScheduleAccess = 	"Authorized"	
	End If	
	
	If ExecuteMain Then
	%>
		
		
		
	    <Table bgcolor=White border=1 width=100% height=100%>
			<TR>
				<TD  valign=top>
					<%For ForLoopCounter = 0 to Ubound(ResultsArray,2)
						%>
						
						<A ondblclick="processAccess()">
						<%=ResultsArray(1,ForLoopCounter)%>
						</A>
						<BR>
					<%		
					Next
					%>
				<TD>   
			</TR>
		</Table>
		
	<%
	Else
	%>
		<Table bgcolor=White border=1 width=100% height=100%>
			<TR>
				<TD   valign=top>
					No Access Set
				<TD>   
			</TR>
		</Table>
	<%					
	End If



Set RS = Nothing
Set Conn = Nothing

%>

</body>
</html>
<!--#include virtual="/loginstatline/includes/copyright.shm"-->

<%
Function ExecuteMain()

	
	'Get data rows
	vQuery = "select * from sourcecode " 
	'Response.Write vQuery
	Set RS = Conn.Execute(vQuery)

	If RS.EOF = True Then
		ExecuteMain = False
	Else
		ExecuteMain = True
		ResultsArray = RS.GetRows
	End If
	

	
	Set RS = Nothing
	Set Conn = Nothing

End Function

Function ExecuteMainSource()

			 Set cmd = Server.CreateObject("ADODB.Command")
						cmd.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
						cmd.CommandText = "sps_OnlineHospitalSourceCodeChange"
						cmd.CommandType = adCmdStoredProc
						'cmd.Parameters.Append cmd.CreateParameter("@OrganizationID", adInteger, adParamInput)
						'cmd.Parameters("@OrganizationID").Value = Request.QueryString("UserOrgID")
				
	SET rs = cmd.Execute
	'SET RS = cmd.Execute	
	'Get data rows
	'print DataSourceName
	'vQuery = "insert into onlinehospitalsourcecodewebperson (webpersonID,sourceCodeID,SourceCodeName) values (1,20,'coda')" 
	'Response.Write vQuery
	'Set RS = Conn.Execute(vQuery)
	
	ExecuteMainSource = True
 

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
%>
<script language="JavaScript">
	function processAccess()
	{
	<% 	if ExecuteMainSource then
					'Response.write "Good"
			end if
	%>
		var url
		var features
		//url of process page with ScheduleGroupID , ScheudleAccess and PersonID
		//url = "/loginstatline/forms/ProcessOnlineScheduleAccess.sls?"
		//url = url + "ScheduleGroupID=" + ScheduleGroupID 
		//url = url + "&ScheduleAccess=" + AccessLevel
		//url = url + "&PersonID=" + PersonID
		//url = url + ""
		//Specify which feature the process window will use
		features = "location=no,menubar=no, resizable=no,scrollbars=no,toolbar=no"


		//alert(PersonID)
		//alert(PersonName)
		//alert(AccessLevel)
		//alert(url)
		//document.open("http://www2.statline.com")//close //document.close //.open(Window.open(document.location.href), "replace")
		//frames[0].
		//document.url //.open("/loginstatline/forms/OnlineScheduleAccessUpdate_Activity.sls?ScheduleGroupID=" + ScheduleGroup + "&ScheduleAccess=" + AccessLevel,,,0)
		//document.open("http://www2.statline.com")
		return 0
		
	}


	function clickDesc()
	{

	var url = ""
	var reportvalue = ""
	var reportdescfile = ""
	var pipeIndex = 0

	reportvalue = reportForm.report.options[reportForm.report.selectedIndex].value
	pipeIndex = reportvalue.indexOf("|",0)
	reportdescfile = reportvalue.substring(0,pipeIndex)

	url = strHttpHeader + reportForm.serverName.value + "/loginstatline/reportdesc/" + reportdescfile
	window.open(url,"UpdateReferral",'toolbar=1,location=0,directories=0,status=1,menubar=1,scrollbars=1,resizable=1')
	
	return 0

	}
	
	function doNothing() 
	{
	}	
</script>
