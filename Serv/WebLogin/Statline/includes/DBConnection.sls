<%
Dim config 
Set config = server.CreateObject("Statline.Stattrac.ClassicASPAccess.ASPLookup")

	Private DBUSER
	DBUSER = "streportadmin"
	'config.ReportUser()	
	Private DBPWD 
	DBPWD = "stattrac" 'config.ReportAuthenticate()	
	Private Const REPORTINGDSN = "Production" 
	Private Const WAREHOUSEDSN = "ProductionDataWarehouse"
	'Private Const DataWarehouseConn = "ProductionDataWarehouse"
	Private Const DONORREGISTRYDSN = "DonorRegistry"
	Private Const DMV_CO = "DMV_CO"
	Private Const PRODUCTIONDSN = "Production"
	Private Const TRANSACTIONDSN = "ProductionTransaction"
	Private Const DASHDSN = "DashData"
	Private Const VIRTUALDSN = "ProductionVirtual"
	Private Const ARCHIVEDSN = "Production"
	Private Const WEBPROD = "WebProd"
	Private Const DWPRODUCTIONDATA = "_ReferralProd"
	Private Const ArchiveMonths = 6
	
	Dim ArchiveDate, connectionErrorMsg

	Function GetReportSource(newDBSource,DateStart,DateEnd)
	Dim source

	'check newDBSoruce if empty set source = DATASOURCE constant else use value'

	source = DetermineReportingDSN(newDBSource,DateStart,DateEnd)


	Set GetReportSource = GetConnection(DBUSER, DBPWD, source)

	End Function

	Function GetWarehouseSource()
	Set GetWarehouseSource = GetConnection(DBUSER, DBPWD, DataWarehouseConn)
	End Function

	Public Function GetDashDataSource()
		Set GetDashDataSource = GetConnection(DBUSER, DBPWD, DASHDSN)
	End Function

	Public Function GetProductionSource()
		Set GetProductionSource = GetConnection(DBUSER, DBPWD, TRANSACTIONDSN)
	End Function

	
	Private Function GetConnection(user, password, dB)

		'DEBUG - checks passed parameters
		'Response.Write("db " + db + " password " + password + " user " + user)

		''Establish a database connection


		Set Conn = server.CreateObject("ADODB.Connection")
		Conn.Open dB, user, password

		Set GetConnection = Conn

	End Function

	Public Function DetermineReportingDSN(newDBSource,DateStart,DateEnd)
		dim conn, rs
	
		IF IsEmpty(newDBSource) Then
		
			IF (TypeName(DateStart) = "Date" and TypeName(DateEnd) = "Date") Then
			
				IF abs(DateDiff("m",DateStart,Now())) < ArchiveMonths and abs(DateDiff("m",DateEnd,Now())) < ArchiveMonths Then
					DetermineReportingDSN = REPORTINGDSN
					
				Else
					
					DetermineReportingDSN = CheckStatusTable(DateStart, DateEnd)
				End IF
			Else ''TypeName if statement else
				DetermineReportingDSN = REPORTINGDSN
			End If
		ELSE '' dsn empty statement else
			
			If newDBSource = "Production" Then
				If IsEmpty(DateStart) and IsEmpty(DateEnd) or _
				   Len(DateStart) = 0 and Len(DateEnd) = 0 Then
					DetermineReportingDSN = REPORTINGDSN
				Else							
					DetermineReportingDSN = CheckStatusTable(DateStart, DateEnd)
				End If				
			Else
				DetermineReportingDSN = newDBSource
			End IF
		End If

	End Function

	Private Function CheckStatusTable (DateStart, DateEnd)

		''Check the Current max TableDate value in ArchiveStatus
		''Connect to produciton database. Run sps_maxArchiveMonth
		''check daterange against max archive month if date range
		''if date range is < than max archive month return archive dsn
		'' if max month is 9/1/98 and date range is 9/1/97 to 9/10/97 it is
		'' less than 9/1/98 so the archive dsn will be returned.

		SET conn = GetConnection(DBUSER,DBPWD,REPORTINGDSN)

		vQuery = "sps_maxArchiveMonth"

		Set rs = Conn.Execute(vQuery)

		If rs.eof Then
			PrintError "Could not determine the max archive month", "CheckStatusTable", "DBConnection.sls"
		End If

		ArchiveDate=rs.Fields("maxDate")
		
		If(DateDiff("d", DateStart, ArchiveDate) > 0 and _
			DateDiff("d", DateEnd, ArchiveDate) > 0) Then
			CheckStatusTable = ARCHIVEDSN
		ElseIf (DateDiff("d", DateStart, ArchiveDate) <= 0 and _
			DateDiff("d", DateEnd, ArchiveDate) <= 0) Then
			CheckStatusTable = REPORTINGDSN
		End If
	End Function

	Private Function PrintError(errorMessage, errorLocation, errorFile )
		connectionErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
		connectionErrorMsg = connectionErrorMsg & errorMessage
		connectionErrorMsg = connectionErrorMsg & " <BR> <BR>"
		connectionErrorMsg = connectionErrorMsg & "If you continue to have difficulty, <BR>"
		connectionErrorMsg = connectionErrorMsg & "Please contact Statline at (888) 881-7828 for assistance.</B> <BR> <BR> <BR>"
		connectionErrorMsg = connectionErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
		connectionErrorMsg = connectionErrorMsg & "Error:     (100, "
		connectionErrorMsg = connectionErrorMsg & errorLocation
		connectionErrorMsg = connectionErrorMsg & ", "
		connectionErrorMsg = connectionErrorMsg & errorFile
		connectionErrorMsg = connectionErrorMsg & " ) <BR> <BR>"
		connectionErrorMsg = connectionErrorMsg & "</FONT></FONT>"
		Response.Write(connectionErrorMsg)

	End Function


	Public Function Print(message)
		Response.Write "<BR>"
		Response.Write message
		Response.Write "<BR>"
	
	End Function
	
	'Public Function ConfirmDataSource(pvCallID, DataSourceName)	
	'	Dim queryString, localConnection, localRecordSet
	'	
	'	queryString = "SELECT CallDateTime FROM Call where CallID = " & pvCallID
	'	Set localConnection = GetConnection(DBUser, DBPWD, DataSourceName)
	'
	'	
	'	Set localConnection = Nothing
	'	Set localRecordSet = Nothing
		
	
	'End Function
	
	'FUNCTION BUILDWHERE
	Function buildWhere(checkString)
		'This function checks for where in a string 
		'If where exists it returns and 
		'if where does not exist it returns and

		Dim returnString

		If ((instr(1,checkString, "WHERE")>0)) Then
			returnString = " AND "			
		Else
			returnString = " WHERE "
		End If

		buildWhere = returnString
	End Function
	
%>


