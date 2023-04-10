<% 
Option Explicit

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
Dim vTotalDenied
Dim vTotalNotApprch

Dim vTotalOTE
Dim vTotalTE
Dim vTotalE
Dim vTotalRO
Dim vTotalROA
Dim vTotalROM

Dim vGrandTotal

Dim vValue
Dim x
Dim vErrorMsg
Dim RS0, RS1
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
vTitlePeriod = FormatDateTime(pvStartDate, vbShortDate) & " " & FormatDateTime(pvStartDate, vbShortTime)
vTitleTo = FormatDateTime(pvEndDate, vbShortDate) & " " & FormatDateTime(pvEndDate, vbShortTime)
vTitleTimes = "All Times Mountain Time"

%>
	<!-- Print the header. -->
	<!--#include virtual="/loginstatline/reports/admin/Head.sls"-->
<%

'Open data connection
Set Conn = server.CreateObject("ADODB.Connection")
Conn.Open DataSourceName, DBUSER, DBPWD
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


<!-- Get Raw Data -->
<%

'Get number of rows
vQuery = "sps_CallCountsMsgImportOrg " & pvUserOrgID & ", '" & pvStartDate & "', '" & pvEndDate & "'"
''Print vQuery

Set RS = Conn.Execute(vQuery)

If RS.EOF = True Then%>

	<TABLE WIDTH="100%" BORDER=0>
		<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial"><B> Messages & Imports </B></FONT> </TD></TR>
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

End If

Set RS = Nothing
%>

	<TABLE WIDTH="100%" BORDER=0>
		<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial"><B> Messages & Imports </B></FONT> </TD></TR>
		<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial" SIZE="<%=FontSizeData%>"><i><%=vOrgName%></i></FONT> </TD></TR>
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


<!-- Referral Count Section -->


<!-- Get Total Data -->

<%'Get total data rows
vQuery = "sps_ReportGroupRefSourceCodes " & vReportGroupID
Set RS0 = Conn.Execute(vQuery)


'Get the referral type list 
vQuery = "sps_ReferralTypeViewAccess " & pvUserOrgID
Set RSAccess = Conn.Execute(vQuery)	
ReferralTypeList = RSAccess.GetRows
Set RSAccess = Nothing

%>

<!-- Build Table -->

<%If RS0.EOF = True Then%>

	<P STYLE="line-height: 1pt">&nbsp</P>

	<!-- Header -->
	<TABLE WIDTH="100%" BORDER=0>
		<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial"><B> Referral Counts </B></FONT> </TD></TR>
		<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial" SIZE="<%=FontSizeData%>"> No Data Available </FONT> </TD></TR>
	</TABLE>

<%Else

	Do Until RS0.EOF
	%>

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
				<TD WIDTH="23%" ALIGN=LEFT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>Referral Type</B></TD>
				<TD WIDTH="11%" ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>O/T/E</B></TD>
				<TD WIDTH="11%" ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>T/E</B></TD>
				<TD WIDTH="11%" ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>E Only</B></TD>
				<TD WIDTH="11%" ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>Total RO</B></TD>
				<TD WIDTH="11%" ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B><I>Age RO</I></B></TD>
				<TD WIDTH="11%" ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B><I>Med RO</I></B></TD>
				<TD WIDTH="11%" ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>Totals</B></TD>	
			</TR>
							
			<TR> 
				<TD ALIGN=LEFT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeData%>"><B>Approach/Consent</FONT></B></TD>
			</TR>


<!-- Unknown -->
			<TR> 
				<TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeData%>">Unknown</FONT></TD>
							
			<%'Get data items
			vTotalOTE = 0
			vTotalTE = 0
			vTotalE = 0
			vTotalRO = 0
			vTotalROA = 0
			vTotalROM = 0
			
			vTotalUnknown = 0
							
			vQuery = "sps_ReferralCountTypeUnknown " & pvUserOrgID & ", '" & pvStartDate & "', '" & pvEndDate & "', " & vSourceCodeID & ", " & vReportGroupID & ", "  & vOrgID & ", 0"
			''Print vQuery
			Set RS = Conn.Execute(vQuery)
			
			If RS.EOF <> True Then
			
				'OTE Count
				If RS("ReferralTypeID") = 1 Then
					If ReferralTypeList(2,0)= 1 Then
					%>
						<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><%=RS("ReferralCount")%></FONT></TD>
					<%
						vTotalUnknown = vTotalUnknown + RS("ReferralCount")
						vTotalOTE = vTotalOTE + RS("ReferralCount")
						RS.MoveNext
					Else
					%>
						<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
					<%
						RS.MoveNext
					End If
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
				End If
				
				If RS.EOF <> True Then
					'TE Count
					If RS("ReferralTypeID") = 2 Then
						If ReferralTypeList(2,1)= 1 Then
						%>
							<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><%=RS("ReferralCount")%></FONT></TD>
						<%
							vTotalUnknown = vTotalUnknown + RS("ReferralCount")
							vTotalTE = vTotalTE + RS("ReferralCount")
							RS.MoveNext
						Else
						%>
							<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
						<%
							RS.MoveNext
						End If
					Else
					%>
						<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
					<%
					End If	
					
					If RS.EOF <> True Then
						'E Count
						If RS("ReferralTypeID") = 3 Then
							If ReferralTypeList(2,2)= 1 Then
							%>
								<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><%=RS("ReferralCount")%></FONT></TD>
							<%
								vTotalUnknown = vTotalUnknown + RS("ReferralCount")
								vTotalE = vTotalE + RS("ReferralCount")
								RS.MoveNext
							Else
							%>
								<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
							<%
								RS.MoveNext
							End If								
						Else
						%>
							<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
						<%
						End If		
						
						If RS.EOF <> True Then
							'RO Count
							If RS("ReferralTypeID") = 4 Then
								If ReferralTypeList(2,3)= 1 Then
								%>
									<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><%=RS("ReferralCount")%></FONT></TD>
								<%
									vTotalUnknown = vTotalUnknown + RS("ReferralCount")
									vTotalRO = vTotalRO + RS("ReferralCount")
									Set RS = Nothing
								Else
								%>
									<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
								<%
									Set RS = Nothing
								End If											
							Else
							%>
								<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
							<%
							End If		
						Else
						%>
							<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
						<%
						End If	
											
					Else
					%>
						<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
						<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
					<%
					End If	
										
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
				End If				
				
			Else
			%>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
			<%			
			End If
			
			
			'ROA Count	
			vQuery = "sps_ReferralCountTypeUnknown " & pvUserOrgID & ", '" & pvStartDate & "', '" & pvEndDate & "', " & vSourceCodeID & ", " & vReportGroupID & ", "  & vOrgID & ", 1"			
			''Print vQuery
			Set RS1 = Conn.Execute(vQuery)
			
			If RS1.EOF <> True And (ReferralTypeList(2,3)= 1) Then
			%>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><i><%=RS1("ReferralCount")%></i></FONT></TD>
			<%		
				vTotalROA = vTotalROA + RS1("ReferralCount")	
			Else
			%>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
			<%
			End If	
				
			'ROM Count					
			vQuery = "sps_ReferralCountTypeUnknown " & pvUserOrgID & ", '" & pvStartDate & "', '" & pvEndDate & "', " & vSourceCodeID & ", " & vReportGroupID & ", "  & vOrgID & ", 2"			
			
			Set RS1 = Conn.Execute(vQuery)

			If RS1.EOF <> True And (ReferralTypeList(2,3)= 1) Then
			%>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><i><%=RS1("ReferralCount")%></i></FONT></TD>
			<%		
				vTotalROM = vTotalROM + RS1("ReferralCount")	
			Else
			%>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
			<%
			End If	
							
			%>

				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><B><%=vTotalUnknown%></B></FONT></TD>
			</TR>
		


<!-- Consented -->
			<TR> 
				<TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeData%>">Consented</FONT></TD>
				
			<%	
			vTotalConsented = 0
						

			vQuery = "sps_ReferralCountTypeConsented " & pvUserOrgID & ", '" & pvStartDate & "', '" & pvEndDate & "', " & vSourceCodeID & ", " & vReportGroupID & ", "  & vOrgID & ", 0" 
			'Print vQuery
			Set RS = Conn.Execute(vQuery)


	
			If RS.EOF <> True Then
				'OTE Count
				If RS("ReferralTypeID") = 1 Then
					If ReferralTypeList(2,0)= 1 Then
					%>
						<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><%=RS("ReferralCount")%></FONT></TD>
					<%
						vTotalConsented = vTotalConsented + RS("ReferralCount")
						vTotalOTE = vTotalOTE + RS("ReferralCount")
						RS.MoveNext
					Else
					%>
						<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
					<%
						RS.MoveNext
					End If						
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
				End If
				
				If RS.EOF <> True Then
					'TE Count
					If RS("ReferralTypeID") = 2 Then
						If ReferralTypeList(2,1)= 1 Then
						%>
							<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><%=RS("ReferralCount")%></FONT></TD>
						<%
							vTotalConsented = vTotalConsented + RS("ReferralCount")
							vTotalTE = vTotalTE + RS("ReferralCount")
							RS.MoveNext
						Else
						%>
							<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
						<%
							RS.MoveNext
						End If								
					Else
					%>
						<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
					<%
					End If	
					
					If RS.EOF <> True Then
						'E Count
						If RS("ReferralTypeID") = 3 Then
							If ReferralTypeList(2,2)= 1 Then
							%>
								<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><%=RS("ReferralCount")%></FONT></TD>
							<%
								vTotalConsented = vTotalConsented + RS("ReferralCount")
								vTotalE = vTotalE + RS("ReferralCount")
								RS.MoveNext
							Else
							%>
								<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
							<%
								RS.MoveNext
							End If									
						Else
						%>
							<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
						<%
						End If		
						
						If RS.EOF <> True Then
							'RO Count
							If RS("ReferralTypeID") = 4 Then
								If ReferralTypeList(2,3)= 1 Then
								%>
									<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><%=RS("ReferralCount")%></FONT></TD>
								<%
									vTotalConsented = vTotalConsented + RS("ReferralCount")
									vTotalRO = vTotalRO + RS("ReferralCount")
									Set RS = Nothing
								Else
								%>
									<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
								<%
									Set RS = Nothing
								End If										
							Else
							%>
								<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
							<%
							End If		
						Else
						%>
							<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
						<%
						End If	
											
					Else
					%>
						<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
						<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
					<%
					End If	
										
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
				End If				
				
			Else
			%>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
			<%			
			End If
			
			
			'ROA Count	
			vQuery = "sps_ReferralCountTypeConsented " & pvUserOrgID & ", '" & pvStartDate & "', '" & pvEndDate & "', " & vSourceCodeID & ", " & vReportGroupID & ", "  & vOrgID & ", 1"			
			
			Set RS1 = Conn.Execute(vQuery)

			If RS1.EOF <> True And (ReferralTypeList(2,3)= 1) Then
			%>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><i><%=RS1("ReferralCount")%></i></FONT></TD>
			<%		
				vTotalROA = vTotalROA + RS1("ReferralCount")	
			Else
			%>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
			<%
			End If	
				
			'ROM Count					
			vQuery = "sps_ReferralCountTypeConsented " & pvUserOrgID & ", '" & pvStartDate & "', '" & pvEndDate & "', " & vSourceCodeID & ", " & vReportGroupID & ", "  & vOrgID & ", 2"			

			Set RS1 = Conn.Execute(vQuery)
			
			If RS1.EOF <> True And (ReferralTypeList(2,3)= 1) Then
			%>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><i><%=RS1("ReferralCount")%></i></FONT></TD>
			<%		
				vTotalROM = vTotalROM + RS1("ReferralCount")	
			Else
			%>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
			<%
			End If	
							
			%>

				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><B><%=vTotalConsented%></B></FONT></TD>
			</TR>
			

<!-- Denied -->
			<TR> 
				<TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeData%>">Denied</FONT></TD>
				
			<%				
			vTotalDenied = 0
						

			vQuery = "sps_ReferralCountTypeDenied " & pvUserOrgID & ", '" & pvStartDate & "', '" & pvEndDate & "', " & vSourceCodeID & ", " & vReportGroupID & ", "  & vOrgID & ", 0"
			'Print vQuery
			Set RS = Conn.Execute(vQuery)

	
			If RS.EOF <> True Then
				'OTE Count
				If RS("ReferralTypeID") = 1 Then
					If ReferralTypeList(2,0)= 1 Then
					%>
						<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><%=RS("ReferralCount")%></FONT></TD>
					<%
						vTotalDenied = vTotalDenied + RS("ReferralCount")
						vTotalOTE = vTotalOTE + RS("ReferralCount")
						RS.MoveNext
					Else
					%>
						<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
					<%
						RS.MoveNext
					End If						
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
				End If
				
				If RS.EOF <> True Then
					'TE Count
					If RS("ReferralTypeID") = 2 Then
						If ReferralTypeList(2,1)= 1 Then
						%>
							<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><%=RS("ReferralCount")%></FONT></TD>
						<%
							vTotalDenied = vTotalDenied + RS("ReferralCount")
							vTotalTE = vTotalTE + RS("ReferralCount")
							RS.MoveNext
						Else
						%>
							<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
						<%
							RS.MoveNext
						End If								
					Else
					%>
						<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
					<%
					End If	
					
					If RS.EOF <> True Then
						'E Count
						If RS("ReferralTypeID") = 3 Then
							If ReferralTypeList(2,2)= 1 Then
							%>
								<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><%=RS("ReferralCount")%></FONT></TD>
							<%
								vTotalDenied = vTotalDenied + RS("ReferralCount")
								vTotalE = vTotalE + RS("ReferralCount")
								RS.MoveNext
							Else
							%>
								<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
							<%
								RS.MoveNext
							End If										
						Else
						%>
							<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
						<%
						End If		
						
						If RS.EOF <> True Then
							'RO Count
							If RS("ReferralTypeID") = 4 Then
								If ReferralTypeList(2,3)= 1 Then
								%>
									<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><%=RS("ReferralCount")%></FONT></TD>
								<%
									vTotalDenied = vTotalDenied + RS("ReferralCount")
									vTotalRO = vTotalRO + RS("ReferralCount")
									Set RS = Nothing
								Else
								%>
									<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
								<%
									Set RS = Nothing
								End If										
							Else
							%>
								<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
							<%
							End If		
						Else
						%>
							<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
						<%
						End If	
											
					Else
					%>
						<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
						<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
					<%
					End If	
										
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
				End If				
				
			Else
			%>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
			<%			
			End If
			
			
			'ROA Count	
			vQuery = "sps_ReferralCountTypeDenied " & pvUserOrgID & ", '" & pvStartDate & "', '" & pvEndDate & "', " & vSourceCodeID & ", " & vReportGroupID & ", "  & vOrgID & ", 1"			
		
			Set RS1 = Conn.Execute(vQuery)

			If RS1.EOF <> True And (ReferralTypeList(2,3)= 1) Then
			%>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><i><%=RS1("ReferralCount")%></i></FONT></TD>
			<%		
				vTotalROA = vTotalROA + RS1("ReferralCount")	
			Else
			%>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
			<%
			End If	
				
			'ROM Count					
			vQuery = "sps_ReferralCountTypeDenied " & pvUserOrgID & ", '" & pvStartDate & "', '" & pvEndDate & "', " & vSourceCodeID & ", " & vReportGroupID & ", "  & vOrgID & ", 2"			


			Set RS1 = Conn.Execute(vQuery)

			If RS1.EOF <> True And (ReferralTypeList(2,3)= 1) Then
			%>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><i><%=RS1("ReferralCount")%></i></FONT></TD>
			<%		
				vTotalROM = vTotalROM + RS1("ReferralCount")	
			Else
			%>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
			<%
			End If	
							
			%>

				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><B><%=vTotalDenied%></B></FONT></TD>
			</TR>
			

<!-- NotApprch -->
			<TR> 
				<TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeData%>">NotApprch</FONT></TD>
				
			<%				
			vTotalNotApprch = 0
						
			vQuery = "sps_ReferralCountTypeNotApprch " & pvUserOrgID & ", '" & pvStartDate & "', '" & pvEndDate & "', " & vSourceCodeID & ", " & vReportGroupID & ", "  & vOrgID & ", 0"
			'Print vQuery
			Set RS = Conn.Execute(vQuery)


	
			If RS.EOF <> True Then
				'OTE Count
				If RS("ReferralTypeID") = 1 Then
					If ReferralTypeList(2,0)= 1 Then
					%>
						<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><%=RS("ReferralCount")%></FONT></TD>
					<%
						vTotalNotApprch = vTotalNotApprch + RS("ReferralCount")
						vTotalOTE = vTotalOTE + RS("ReferralCount")
						RS.MoveNext
					Else
					%>
						<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
					<%
						RS.MoveNext
					End If						
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
				End If
				
				If RS.EOF <> True Then
					'TE Count
					If RS("ReferralTypeID") = 2 Then
						If ReferralTypeList(2,1)= 1 Then
						%>
							<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><%=RS("ReferralCount")%></FONT></TD>
						<%
							vTotalNotApprch = vTotalNotApprch + RS("ReferralCount")
							vTotalTE = vTotalTE + RS("ReferralCount")
							RS.MoveNext
						Else
						%>
							<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
						<%
							RS.MoveNext
						End If								
					Else
					%>
						<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
					<%
					End If	
					
					If RS.EOF <> True Then
						'E Count
						If RS("ReferralTypeID") = 3 Then
							If ReferralTypeList(2,2)= 1 Then
							%>
								<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><%=RS("ReferralCount")%></FONT></TD>
							<%
								vTotalNotApprch = vTotalNotApprch + RS("ReferralCount")
								vTotalE = vTotalE + RS("ReferralCount")
								RS.MoveNext
							Else
							%>
								<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
							<%
								RS.MoveNext
							End If									
						Else
						%>
							<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
						<%
						End If		
						
						If RS.EOF <> True Then
							'RO Count
							If RS("ReferralTypeID") = 4 Then
								If ReferralTypeList(2,3)= 1 Then
								%>
									<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><%=RS("ReferralCount")%></FONT></TD>
								<%
									vTotalNotApprch = vTotalNotApprch + RS("ReferralCount")
									vTotalRO = vTotalRO + RS("ReferralCount")
									Set RS = Nothing
								Else
								%>
									<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
								<%
									Set RS = Nothing
								End If										
							Else
							%>
								<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
							<%
							End If		
						Else
						%>
							<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
						<%
						End If	
											
					Else
					%>
						<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
						<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
					<%
					End If	
										
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
				End If				
				
			Else
			%>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
			<%			
			End If
			
			
			'ROA Count	
			vQuery = "sps_ReferralCountTypeNotApprch " & pvUserOrgID & ", '" & pvStartDate & "', '" & pvEndDate & "', " & vSourceCodeID & ", " & vReportGroupID & ", "  & vOrgID & ", 1"			
			''Print(vQuery)
			Set RS1 = Conn.Execute(vQuery)

			If RS1.EOF <> True And (ReferralTypeList(2,3)= 1) Then
			%>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><i><%=RS1("ReferralCount")%></i></FONT></TD>
			<%		
				vTotalROA = vTotalROA + RS1("ReferralCount")	
			Else
			%>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
			<%
			End If	
				
			'ROM Count					
			vQuery = "sps_ReferralCountTypeNotApprch " & pvUserOrgID & ", '" & pvStartDate & "', '" & pvEndDate & "', " & vSourceCodeID & ", " & vReportGroupID & ", "  & vOrgID & ", 2"			
			
	
			Set RS1 = Conn.Execute(vQuery)

			If RS1.EOF <> True And (ReferralTypeList(2,3)= 1) Then
			%>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><i><%=RS1("ReferralCount")%></i></FONT></TD>
			<%		
				vTotalROM = vTotalROM + RS1("ReferralCount")	
			Else
			%>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
			<%
			End If	
							
			%>

				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><B><%=vTotalNotApprch%></B></FONT></TD>
			</TR>
			
			
						
<!-- Totals -->
			<TR>
				<TD ALIGN=LEFT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>Total Referrals</B></TD>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><B><%=vTotalOTE%></B></FONT></TD>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><B><%=vTotalTE%></B></FONT></TD>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><B><%=vTotalE%></B></FONT></TD>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><B><%=vTotalRO%></B></FONT></TD>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><B><I><%=vTotalROA%></I></B></FONT></TD>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><B><I><%=vTotalROM%></I></B></FONT></TD>			
				<%vGrandTotal = vTotalOTE + vTotalTE + vTotalE + vTotalRO%>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeHead%>"><B><I><%=vGrandTotal%></I></B></TD>	
			</TR>

		</TABLE>
<%

		RS0.MoveNext
		
	Loop
	
	Set RS0 = Nothing
	Set RS1 = Nothing
	Set RS = Nothing

End If
%>

</BODY>
</HTML>
<!--#include virtual="/loginstatline/includes/copyright.shm"-->
<%End If%>


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
%>