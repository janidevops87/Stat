<% Option Explicit

Response.CacheControl = "no-cache" 
Response.AddHeader "Cache-Control", "private" 
Response.AddHeader "Pragma", "no-cache" 
Response.Expires = -1 

%>
<html>

<head>
<meta http-equiv="Expires" content="now">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="EXPIRES" content="0">
<title>Call Count Summary</title>
</head>

<body bgcolor="#F5EBDD">

<!--#include virtual="/loginstatline/includes/Authorize.sls"-->
<%	
Dim FontNameHead
Dim FontSizeHead
Dim FontNameData
Dim FontSizeData

Dim pvStartDate
Dim pvEndDate
Dim pvUserOrgID
Dim vOrgID
Dim vReportGroupID
Dim vSourceCodeID

Dim ReferralTypeList
Dim RSAccess

Dim vOrgName
Dim vMsgCount
Dim vImportCount

Dim vTotalUnknown
Dim vTotalConsented
Dim vDeniedTotals
Dim vTotalNotApprch

Dim vTotalOTE
Dim vTotalTissue
Dim vTotalTE
Dim vTotalE
Dim vTotalOther
Dim vTotalOtherEye
Dim vTotalRO
Dim vTotalROA
Dim vTotalROM

Dim vGrandTotal

Dim vValue
Dim x
Dim vErrorMsg
Dim RS0, RS1
Dim DataWarehouseConn
Dim ErrorReturn

Dim vReportTitle
Dim vMainTitle
Dim vTitlePeriod
Dim vTitleTo
Dim vTitleTimes


FontNameHead = "Arial"
FontSizeHead = "2"
FontNameData = "Times New Roman"
FontSizeData = "2"

Call FixQueryString(Request.QueryString("StartDate"), pvStartDate)
Call FixQueryString(Request.QueryString("EndDate"), pvEndDate)
pvUserOrgID = Request.QueryString("UserOrgID")
vReportGroupID = Request.QueryString("ReportGroupID")
vOrgID = 0	

%>

<%'Execute the main page generating routine
If AuthorizeMain Then

	'Set Title Values	
	vMainTitle = "Call Count Summary"
	vTitlePeriod = DateLiteral(pvStartDate)
	vTitleTo = DateLiteral(pvEndDate)
	vTitleTimes = "All Times Mountain Time"

%>
	<!--#include virtual="/loginstatline/reports/referral/statistics/Head.sls"-->

<%
'Open data connection
Set Conn = server.CreateObject("ADODB.Connection")
Conn.Open DataSourceName, DBUSER, DBPWD

'Open DataWarehouse Connection
Set DataWarehouseConn = server.CreateObject("ADODB.Connection")
DataWarehouseConn.Open WAREHOUSEDSN, DBUSER, DBPWD

%>


<!-- User Org Section -->
<%If pvUserOrgID = 194 Then

	'Replace user org id with the owner of the selected report group
	If vReportGroupID <> 0 Then

		'Get number of rows
		vQuery = "sps_ReportGroupOrgParentID " & vReportGroupID

		Set RS = Conn.Execute(vQuery)
	
		pvUserOrgID = RS("OrgHierarchyParentID")

		Set RS = Nothing

	End If

End If%>


<!-- Message & Import Section -->

<P STYLE="line-height: 1pt">&nbsp</P>




<!-- Get Total Data -->

<%'Get total data rows
vQuery = "sps_ReportGroupRefSourceCodes " & vReportGroupID
Set RS0 = Conn.Execute(vQuery)
'Print vQuery

'Get the referral type list 
vQuery = "sps_ReferralTypeViewAccess " & pvUserOrgID
Set RSAccess = Conn.Execute(vQuery)	
ReferralTypeList = RSAccess.GetRows
Set RSAccess = Nothing

''Print vQuery
%>

<!-- Build Table -->

<%If RS0.EOF = True Then
	'Set Title Values	
	vMainTitle = "Referral Counts "
	vTitlePeriod =  ""
	vTitleTo = ""
	vTitleTimes = ""
%>

	<P STYLE="line-height: 1pt">&nbsp</P>
	
	<!-- Header -->
	
	
	
<%Else

	Do Until RS0.EOF	
	%>
		<%vSourceCodeID = RS0("SourceCodeID")%>	
<!-- Get Raw Data -->
<%

'Get number of rows
vQuery = "sps_MessageCountSummary_B " & pvUserOrgID & ", '" & pvStartDate & "', '" & pvEndDate & "'," & vSourceCodeID
'Print vQuery

Set RS = DataWarehouseConn.Execute(vQuery)

If RS.EOF = True Then%>

	<TABLE WIDTH="100%" BORDER=0>
		<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial"><B> Messages & Imports </B></FONT> </TD></TR>
		<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial" SIZE="<%=FontSizeData%>">Organization:&nbsp&nbsp&nbsp<i><%=vOrgName%></i></FONT> </TD></TR>
		<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial" SIZE="<%=FontSizeData%>">Source Code:&nbsp&nbsp&nbsp<i><%=RS0("SourceCodeName")%></i></FONT> </TD></TR>
		<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial" SIZE="<%=FontSizeData%>"> No Data Available </FONT> </TD></TR>
	</TABLE>

<%Else
	

	vOrgName = RS("OrganizationName")
	
	If IsNull(RS("TotalMessages")) Then
		vMsgCount = 0
	Else
		vMsgCount = RS("TotalMessages")
	End If

	If IsNull(RS("TotalImports")) Then
		vImportCount = 0
	Else
		vImportCount = RS("TotalImports")
	End If



Set RS = Nothing
%>

	<TABLE WIDTH="100%" BORDER=0>
		<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial"><B> Messages & Imports </B></FONT> </TD></TR>
		<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial" SIZE="<%=FontSizeData%>">Organization:&nbsp&nbsp&nbsp<i><%=vOrgName%></i></FONT> </TD></TR>
		<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial" SIZE="<%=FontSizeData%>">Source Code:&nbsp&nbsp&nbsp<i><%=RS0("SourceCodeName")%></i></FONT> </TD></TR>
	</TABLE>

	<!-- Format Table -->
	<TABLE BORDER=1>

		<TR>
			<TD ALIGN=LEFT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>Call Type</TD></B>
			<TD ALIGN=CENTER><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B># of Calls</TD></B>
		</TR>


		<TR> 
			<TD ALIGN=LEFT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeData%>">Messages</FONT> </TD>
			<TD ALIGN=CENTER><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><%=vMsgCount%></FONT> </TD>
		</TR>

		<TR> 
			<TD ALIGN=LEFT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeData%>">Imports</FONT> </TD>
			<TD ALIGN=CENTER><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><%=vImportCount%></FONT> </TD>
		</TR>

		<TR>
			<TD ALIGN=LEFT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>Total</TD></B>
			<TD ALIGN=CENTER><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B><%=vMsgCount + vImportCount%></TD></B>
		</TR>

	</TABLE>
	<BR>
	<%
	'Reset count numbers
	vMsgCount = 0
	vImportCount = 0
End If	
	
	RS0.MoveNext
	Loop
	
	RS0.MoveFirst
	Do Until RS0.EOF		
	%>
	

<!-- Referral Count Section -->


		<%vSourceCodeID = RS0("SourceCodeID")%>

		<P STYLE="line-height: 1pt">&nbsp</P>

<!-- Header -->

		<TABLE WIDTH="100%" BORDER=0>
			<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial"><B> Referrals </B></FONT> </TD></TR>
			<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial" SIZE="<%=FontSizeData%>">Source Code:&nbsp&nbsp&nbsp&nbsp<i><%=RS0("SourceCodeName")%></i></FONT> </TD></TR>
			<%If vReportGroupID <> 0 Then
				vQuery = "sps_ReportGroupName " & vReportGroupID
				Set RS = Conn.Execute(vQuery)
				
				If RS.EOF <> True Then%>			
					<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial" SIZE="<%=FontSizeData%>">Report Group:&nbsp&nbsp&nbsp<i><%=RS("WebReportGroupName")%></i></FONT> </TD></TR>
				<%End If%>
			<%End If%>
			<%If vOrgID <> 0 Then
				vQuery = "sps_OrganizationName " & vOrgID
				Set RS = Conn.Execute(vQuery)
				
				If RS.EOF <> True Then%>				
					<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial" SIZE="<%=FontSizeData%>">Organization:&nbsp&nbsp&nbsp&nbsp<i><%=RS("OrganizationName")%></i></FONT> </TD></TR>
				<%End If%>
			<%End If%>			
		</TABLE>
		
		<!-- Format Table -->
		<TABLE BORDER=1>
			
<!-- Header -->
			<TR>
				<TD WIDTH="10%" ALIGN=LEFT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>Referral Type</B></TD>
				<TD WIDTH="9%" ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>O/T/E</B></TD>
				<TD WIDTH="9%" ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>Tissue</TD>
				<TD WIDTH="9%" ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>T/E</B></TD>
				<TD WIDTH="9%" ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>E Only</B></TD>
				<TD WIDTH="9%" ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>Other/Eye</B></TD>
				<TD WIDTH="9%" ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>Other</B></TD>
				<TD WIDTH="9%" ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>Total RO</B></TD>
				<TD WIDTH="9%" ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B><I>Age RO</I></B></TD>
				<TD WIDTH="9%" ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B><I>Med RO</I></B></TD>
				<TD WIDTH="9%" ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>Totals</B></TD>	
			</TR>
							
			<TR> 
				<TD ALIGN=LEFT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeData%>"><B>Approach/Consent</FONT></B></TD>
			</TR>


<!-- Unknown -->
			<TR> 
				<TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeData%>">Unknown</FONT></TD>
							
			<%'Get data items
			vTotalOTE = 0
			vTotalTissue = 0
			vTotalTE = 0
			vTotalE = 0
			vTotalOtherEye = 0
			vTotalOther = 0
			vTotalRO = 0
			vTotalROA = 0
			vTotalROM = 0
			
			vTotalUnknown = 0
			vQuery = "sps_CallCountSummary_A " & vReportGroupID & ", '"  & pvStartDate & "', '" & pvEndDate & "', " & vSourceCodeID & ", " & vOrgID  		

'Print vQuery
			Set RS = DataWarehouseConn.Execute(vQuery)
			
			If RS.EOF <> True Then
				If ReferralTypeList(2,0)= 1 Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><%=RS("Unknown OTE")%></FONT></TD>
					
				<%
					vTotalOTE = vTotalOTE + RS("Unknown OTE")
					vTotalUnknown = vTotalUnknown + RS("Unknown OTE")
					'RS.MoveNext
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
					''RS.MoveNext
				End If
				If ReferralTypeList(2,1)= 1 Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><%=RS("Unknown Tissue")%></FONT></TD>
				<%
					vTotalUnknown = vTotalUnknown + RS("Unknown Tissue")
					vTotalTissue = vTotalTissue + RS("Unknown Tissue")
					'RS.MoveNext
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
					'RS.MoveNext
				End If
				If ReferralTypeList(2,1)= 1 Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><%=RS("Unknown T/E")%></FONT></TD>
				<%
					vTotalUnknown = vTotalUnknown + RS("Unknown T/E")
					vTotalTE = vTotalTE + RS("Unknown T/E")
					'RS.MoveNext
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
					'RS.MoveNext
				End If

				'Unknown Eye
				If ReferralTypeList(2,2)= 1 Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><%=RS("Unknown Eye")%></FONT></TD>
				<%
					vTotalUnknown = vTotalUnknown + RS("Unknown Eye")
					vTotalE = vTotalE + RS("Unknown Eye")
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
					'RS.MoveNext
				End If								
				'Unknown Other Eye
				If ReferralTypeList(2,2)= 1 Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><%=RS("Unknown Other Eye")%></FONT></TD>
				<%
					vTotalUnknown = vTotalUnknown + RS("Unknown Other Eye")
					vTotalOtherEye = vTotalOtherEye + RS("Unknown Other Eye")
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
					'RS.MoveNext		
				END IF	
				'Unknown Other
				If ReferralTypeList(2,3)= 1 Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><%=RS("Unknown Other")%></FONT></TD>
				<%
					vTotalUnknown = vTotalUnknown + RS("Unknown Other")
					vTotalOther = vTotalOther + RS("Unknown Other")
				
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
					'RS.MoveNext
				End If								

				'RO Count
				If ReferralTypeList(2,3)= 1 Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><%=RS("Unknown Total RO")%></FONT></TD>
				<%
					vTotalUnknown = vTotalUnknown + RS("Unknown Total RO")
					vTotalRO = vTotalRO + RS("Unknown Total RO")

				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%

				End If											



				If (ReferralTypeList(2,3)= 1) Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><i><%=RS("Unknown Age RO")%></i></FONT></TD>
				<%		
					vTotalROA = vTotalROA + RS("Unknown Age RO")

				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
				End If	
				'ROM Count

				If (ReferralTypeList(2,3)= 1) Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><i><%=RS("Unknown Med RO")%></i></FONT></TD>
				<%		
					vTotalROM = vTotalROM + RS("Unknown Med RO")	
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
				End If	

				
				'Total Unknown =vTotalUnknown RS("TotalUnknown")
				%>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><B><%=vTotalUnknown%></B></FONT></TD>
			</TR>
		


<!-- Consented -->
			<TR> 
				<TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeData%>">Consented</FONT></TD>
				
			<%	
			vTotalConsented = 0
						

				'OTE Count
				
				If ReferralTypeList(2,0)= 1 Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><%=RS("Consented OTE")%></FONT></TD>
				<%
					vTotalConsented = vTotalConsented + RS("Consented OTE")
					vTotalOTE = vTotalOTE + RS("Consented OTE")
					'RS.MoveNext
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
					'RS.MoveNext
				End If						

				'Tissue Count
				If ReferralTypeList(2,1)= 1 Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><%=RS("Consented Tissue")%></FONT></TD>
				<%
					vTotalConsented = vTotalConsented + RS("Consented Tissue")
					vTotalTissue = vTotalTissue + RS("Consented Tissue")
					'RS.MoveNext
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
					'RS.MoveNext
				End If								
				'TE Count
				If ReferralTypeList(2,1)= 1 Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><%=RS("Consented T/E")%></FONT></TD>
				<%
					vTotalConsented = vTotalConsented + RS("Consented T/E")
					vTotalTE = vTotalTE + RS("Consented T/E")
					'RS.MoveNext
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
					'RS.MoveNext
				End If								

				'E Count
				If ReferralTypeList(2,2)= 1 Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><%=RS("Consented Eye")%></FONT></TD>
				<%
					vTotalConsented = vTotalConsented + RS("Consented Eye")
					vTotalE = vTotalE + RS("Consented Eye")
					'RS.MoveNext
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
					'RS.MoveNext
				End If		
				
				'Other/Eye Count
				If ReferralTypeList(2,2)= 1 Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><%=RS("Consented Other Eye")%></FONT></TD>
				<%
					vTotalConsented = vTotalConsented + RS("Consented Other Eye")
					vTotalOtherEye = vTotalOtherEye + RS("Consented Other Eye")
					'RS.MoveNext
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
					'RS.MoveNext
				End If		

				'Consented Other
				If ReferralTypeList(2,3)= 1 Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><%=RS("Consented Other")%></FONT></TD>
				<%
					vTotalConsented = vTotalConsented + RS("Consented Other")
					vTotalOther = vTotalOther + RS("Consented Other")
					'RS.MoveNext
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
					'RS.MoveNext
				End If									

				'RO Count
				If ReferralTypeList(2,3)= 1 Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><%=RS("Consented Total RO")%></FONT></TD>
				<%
					vTotalConsented = vTotalConsented + RS("Consented Total RO")
					vTotalRO = vTotalRO + RS("Consented Total RO")
					'Set RS = Nothing
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
					'Set RS = Nothing
				End If										
	
			
				'ROA Count	
				If (ReferralTypeList(2,3)= 1) Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><i><%=RS("Consented Age RO")%></i></FONT></TD>
				<%		
					vTotalROA = vTotalROA + RS("Consented Age RO")	
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
				End If	
				
				'ROM Count					
				If (ReferralTypeList(2,3)= 1) Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><i><%=RS("Consented Med RO")%></i></FONT></TD>
				<%		
					vTotalROM = vTotalROM + RS("Consented Med RO")	
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
				End If	
							
			'TotalConsented	vTotalConsented RS("TotalConsented")							
			%>

				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><B><%=vTotalConsented%></B></FONT></TD>
			</TR>
			

<!-- Denied -->
			<TR> 
				<TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeData%>">Denied</FONT></TD>
				
			<%				
			vDeniedTotals = 0
						
				'OTE Count

				If ReferralTypeList(2,0)= 1 Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><%=RS("Denied OTE")%></FONT></TD>
				<%
					vDeniedTotals = vDeniedTotals + RS("Denied OTE")
					vTotalOTE = vTotalOTE + RS("Denied OTE")
					'RS.MoveNext
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
					'RS.MoveNext
				End If						
				'Tissue Count
				If ReferralTypeList(2,1)= 1 Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><%=RS("Denied Tissue")%></FONT></TD>
				<%
					vDeniedTotals = vDeniedTotals + RS("Denied Tissue")
					vTotalTissue = vTotalTissue + RS("Denied Tissue")
					'RS.MoveNext
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
					'RS.MoveNext
				End If								
				'TE Count
				If ReferralTypeList(2,1)= 1 Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><%=RS("Denied T/E")%></FONT></TD>
				<%
					vDeniedTotals = vDeniedTotals + RS("Denied T/E")
					vTotalTE = vTotalTE + RS("Denied T/E")
					'RS.MoveNext
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
					'RS.MoveNext
				End If								
				'E Count
				If ReferralTypeList(2,2)= 1 Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><%=RS("Denied Eye")%></FONT></TD>
				<%
					vDeniedTotals = vDeniedTotals + RS("Denied Eye")
					vTotalE = vTotalE + RS("Denied Eye")
					'RS.MoveNext
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
					'RS.MoveNext
				End If										

				'Other Eye Count
				If ReferralTypeList(2,2)= 1 Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><%=RS("Denied Other Eye")%></FONT></TD>
				<%
					vDeniedTotals = vDeniedTotals + RS("Denied Other Eye")
					vTotalOtherEye = vTotalOtherEye + RS("Denied Other Eye")
					'RS.MoveNext
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
					'RS.MoveNext
				End If										

				'Denied Other
				If ReferralTypeList(2,2)= 1 Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><%=RS("Denied Other")%></FONT></TD>
				<%
					vDeniedTotals = vDeniedTotals + RS("Denied Other")
					vTotalOther = vTotalOther + RS("Denied Other")
					'RS.MoveNext
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
					'RS.MoveNext
				End If										
				
				'RO Count
				If ReferralTypeList(2,3)= 1 Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><%=RS("Total Denied RO")%></FONT></TD>
				<%
					vDeniedTotals = vDeniedTotals + RS("Total Denied RO")
					vTotalRO = vTotalRO + RS("Total Denied RO")
					'Set RS = Nothing
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
					'Set RS = Nothing
				End If										
			
				'ROA Count	

				If (ReferralTypeList(2,3)= 1) Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><i><%=RS("Denied Age RO")%></i></FONT></TD>
				<%		
					vTotalROA = vTotalROA + RS("Denied Age RO")	
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
				End If	

				'ROM Count					

				If (ReferralTypeList(2,3)= 1) Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><i><%=RS("Denied Med RO")%></i></FONT></TD>
				<%		
					vTotalROM = vTotalROM + RS("Denied Med RO")	
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
				End If	

				'Denied Totals	vDeniedTotals RS("Denied Totals")
				%>

					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><B><%=vDeniedTotals%></B></FONT></TD>
			</TR>


<!-- NotApprch -->
			<TR> 
					<TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeData%>">NotApprch</FONT></TD>

				<%				
				vTotalNotApprch = 0


				'OTE Count
				If ReferralTypeList(2,0)= 1 Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><%=RS("Not Approached OTE")%></FONT></TD>
				<%
					vTotalNotApprch = vTotalNotApprch + RS("Not Approached OTE")
					vTotalOTE = vTotalOTE + RS("Not Approached OTE")
					'RS.MoveNext
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
					'RS.MoveNext
				End If						
				'Tissue Count
				If ReferralTypeList(2,1)= 1 Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><%=RS("Not Approached Tissue")%></FONT></TD>
				<%
					vTotalNotApprch = vTotalNotApprch + RS("Not Approached Tissue")
					vTotalTissue = vTotalTissue + RS("Not Approached Tissue")
					'RS.MoveNext
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
					'RS.MoveNext
				End If								

				'TE Count
				If ReferralTypeList(2,1)= 1 Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><%=RS("Not Approached TE")%></FONT></TD>
				<%
					vTotalNotApprch = vTotalNotApprch + RS("Not Approached TE")
					vTotalTE = vTotalTE + RS("Not Approached TE")
					'RS.MoveNext
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
					'RS.MoveNext
				End If								
				'E Count
				If ReferralTypeList(2,2)= 1 Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><%=RS("Not Approached Eye")%></FONT></TD>
				<%
					vTotalNotApprch = vTotalNotApprch + RS("Not Approached Eye")
					vTotalE = vTotalE + RS("Not Approached Eye")
					'RS.MoveNext
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
					'RS.MoveNext
				End If									

				'Other Eye Count
				If ReferralTypeList(2,2)= 1 Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><%=RS("Not Approached Other Eye")%></FONT></TD>
				<%
					vTotalNotApprch = vTotalNotApprch + RS("Not Approached Other Eye")
					vTotalOtherEye = vTotalOtherEye + RS("Not Approached Other Eye")
					'RS.MoveNext
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
					'RS.MoveNext
				End If									

				'Not Approached Other
				If ReferralTypeList(2,3)= 1 Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><%=RS("Not Approached Other")%></FONT></TD>
				<%
					vTotalNotApprch = vTotalNotApprch + RS("Not Approached Other")
					vTotalOther = vTotalOther + RS("Not Approached Other")
					'RS.MoveNext
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
					'RS.MoveNext
				End If									
				
				'RO Count

				If ReferralTypeList(2,3)= 1 Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><%=RS("Not Approached Total RO")%></FONT></TD>
				<%
					vTotalNotApprch = vTotalNotApprch + RS("Not Approached Total RO")
					vTotalRO = vTotalRO + RS("Not Approached Total RO")
					'Set RS = Nothing
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
					'Set RS = Nothing
				End If										

				'ROA Count	

				If (ReferralTypeList(2,3)= 1) Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><i><%=RS("Not Approached Age RO")%></i></FONT></TD>
				<%		
					vTotalROA = vTotalROA + RS("Not Approached Age RO")	
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
				End If	

				'ROM Count					

				If (ReferralTypeList(2,3)= 1) Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><i><%=RS("Not Approached Med RO")%></i></FONT></TD>
				<%		
					vTotalROM = vTotalROM + RS("Not Approached Med RO")	
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
				End If	

				'TotalNotApproached vTotalNotApprch RS("TotalNotApprch")
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><B><%=vTotalNotApprch%></B></FONT></TD>
			</TR>
			
			
						
<!-- Totals -->
			<TR>
				<!--<TD ALIGN=LEFT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>Total Referrals</B></TD>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><B><%=RS("Total Referrals OTE")%></B></FONT></TD>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><B><%=RS("Total Referrals Tissue")%></B></FONT></TD>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><B><%=RS("Total Referrals T/E")%></B></FONT></TD>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><B><%=RS("Total Referrals Eye")%></B></FONT></TD>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><B><%=RS("Total Referrals Other")%></B></FONT></TD>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><B><%=RS("Total Referrals Total RO")%></B></FONT></TD>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><B><I><%=RS("Total Referrals Age RO")%></I></B></FONT></TD>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><B><I><%=RS("Total Referrals Med RO")%></I></B></FONT></TD>			
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeHead%>"><B><I><%=RS("Total Referrals Totals")%></I></B></TD>	
				-->
			
			
				<TD ALIGN=LEFT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>Total Referrals</B></TD>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><B><%=vTotalOTE%></B></FONT></TD>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><B><%=vTotalTissue%></B></FONT></TD>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><B><%=vTotalTE%></B></FONT></TD>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><B><%=vTotalE%></B></FONT></TD>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><B><%=vTotalOtherEye%></B></FONT></TD>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><B><%=vTotalOther%></B></FONT></TD>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><B><%=vTotalRO%></B></FONT></TD>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><B><I><%=vTotalROA%></I></B></FONT></TD>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><B><I><%=vTotalROM%></I></B></FONT></TD>			
				<%vGrandTotal = vTotalOTE + vTotalTissue + vTotalTE + vTotalE + vTotalOther + vTotalRO + vTotalOtherEye%>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeHead%>"><B><I><%=vGrandTotal%></I></B></TD>	
			
			</TR>

		</TABLE>
<%

		RS0.MoveNext
	END IF	
	Loop
	
	Set RS0 = Nothing
	Set RS1 = Nothing
	Set RS = Nothing

End If 
'If for Build Table

%>
<BR>
<!--#include virtual="/loginstatline/includes/copyright.shm"-->

</BODY>
</HTML>

<% End If 
  'End IF AuthorizeMain
  %>
 

<%
Sub FixQueryString(pvIn, pvOut)
	pvOut = ""
	For x=1 TO Len(pvIn)
		If Mid(pvIn,x,1) = "_" Then
			pvOut = pvOut & " "
		Else
			pvOut = pvOut & Mid(pvIn,x,1)
		End If
	Next
End Sub

Function DateLiteral(pvDate)

	Select Case Month(pvDate)
	
		Case 1
			DateLiteral = "Jan "
		Case 2
			DateLiteral = "Feb "
		Case 3
			DateLiteral = "March "
		Case 4
			DateLiteral = "April "
		Case 5
			DateLiteral = "May "
		Case 6
			DateLiteral = "June "
		Case 7
			DateLiteral = "July "
		Case 8
			DateLiteral = "Aug "
		Case 9
			DateLiteral = "Sept "
		Case 10
			DateLiteral = "Oct "
		Case 11
			DateLiteral = "Nov "
		Case 12
			DateLiteral = "Dec "
	End Select
	
	DateLiteral = DateLiteral & Year(pvDate)
	
End Function
%>