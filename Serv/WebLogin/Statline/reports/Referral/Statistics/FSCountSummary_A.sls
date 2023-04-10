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
<title>FS Call Count Summary</title>
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

Dim vTotalNoSecondary
Dim vTotalSecondary
Dim vTotalSecondaryApproach	'5/20/2003 DEO
Dim vTotalSecondaryNoApproach	'5/20/2003 DEO
Dim vTotalNoSecondaryApproach	'5/20/2003 DEO
Dim vFamilyApproachTotals
Dim vFamilyUnavailableTotals	'1/20/03 drh
Dim vCryolifeFormTotals		'1/20/03 drh
Dim vFamilyApproachTotalsCount	'1/20/03 drh
Dim vMedSocTotalsCount		'1/20/03 drh
Dim vCryolifeFormTotalsCount	'1/20/03 drh
Dim vTotalMedSoc

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
	vMainTitle = "FS Call Count Summary"	
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

<%If RS0.EOF = True Then%>

	<P STYLE="line-height: 1pt">&nbsp</P>

	<!-- Header -->
	<TABLE WIDTH="100%" BORDER=0>
		<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial"><B> Referral Counts </B></FONT> </TD></TR>
		<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial" SIZE="<%=FontSizeData%>"> No Data Available </FONT> </TD></TR>
	</TABLE>

<%Else
	Do Until RS0.EOF%>

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
			<TD></TD>
			<TD WIDTH="10%" COLSPAN="10" ALIGN=MIDDLE><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>Referral Type</B></TD>
				
			
			</TR>
			<TR>
				<TD WIDTH="9%" ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>Approach/Consent</B></TD>
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
							
<!-- NoSecondary -->
			<TR> 
				<TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeData%>">No Secondary</FONT></TD>
							
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
			
			vTotalNoSecondary = 0
			
			vQuery = "sps_FSCallCountSummary_A2 " & vReportGroupID & ", '"  & pvStartDate & "', '" & pvEndDate & "', " & vSourceCodeID & ", " & vOrgID  		
			
			'Print(vQuery)

			Set RS = DataWarehouseConn.Execute(vQuery)
			
			If RS.EOF <> True Then
				If ReferralTypeList(2,0)= 1 Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN__FSCase_fsc_ON_fsc.CallID=_Call.CallID&AND=_AND_Referral.ReferralTypeID=1_AND(fsc.FSCaseBillSecondaryUserID_IS_NULL_OR_fsc.FSCaseBillSecondaryUserID=0)_AND(fsc.FSCaseBillApproachUserID_IS_NULL_OR_fsc.FSCaseBillApproachUserID=0)_AND(fsc.FSCaseBillMedSocUserID_IS_NULL_OR_fsc.FSCaseBillMedSocUserID=0)_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<%=RS("NoSecondary OTE")%>
						</A>
					</FONT></TD>
					
				<%
					vTotalOTE = vTotalOTE + RS("NoSecondary OTE")
					vTotalNoSecondary = vTotalNoSecondary + RS("NoSecondary OTE")
					'RS.MoveNext
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
					''RS.MoveNext
				End If
				If ReferralTypeList(2,1)= 1 Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
					<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN__FSCase_fsc_ON_fsc.CallID=_Call.CallID&AND=_AND_Referral.ReferralTypeID=2_AND(fsc.FSCaseBillSecondaryUserID_IS_NULL_OR_fsc.FSCaseBillSecondaryUserID=0)_AND(fsc.FSCaseBillApproachUserID_IS_NULL_OR_fsc.FSCaseBillApproachUserID=0)_AND(fsc.FSCaseBillMedSocUserID_IS_NULL_OR_fsc.FSCaseBillMedSocUserID=0)_AND_ReferralOrganAppropriateID<>1_AND_ReferralEyesTransAppropriateID<>1_AND_( ReferralBoneAppropriateID=1_OR_ReferralTissueAppropriateID=1_OR_ReferralSkinAppropriateID=1_OR_ReferralValvesAppropriateID=1)_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
					<%=RS("NoSecondary Tissue")%>
					</A>
					</FONT></TD>
				<%
					vTotalNoSecondary = vTotalNoSecondary + RS("NoSecondary Tissue")
					vTotalTissue = vTotalTissue + RS("NoSecondary Tissue")
					'RS.MoveNext
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
					'RS.MoveNext
				End If
				If ReferralTypeList(2,1)= 1 Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">						
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=2__AND_(FSCaseBillSecondaryUserID_IS_NULL_OR_FSCaseBillSecondaryUserID=0)_AND_(FSCaseBillApproachUserID_IS_NULL_OR_FSCaseBillApproachUserID=0)_AND_(FSCaseBillMedSocUserID_IS_NULL_OR_FSCaseBillMedSocUserID=0)_AND_ReferralOrganAppropriateID<>1_AND_ReferralEyesTransAppropriateID=1_AND_(ReferralBoneAppropriateID=1_OR_ReferralTissueAppropriateID=1_OR_ReferralSkinAppropriateID=1_OR_ReferralValvesAppropriateID=1)_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<%=RS("NoSecondary T/E")%>
						</A>
					</FONT></TD>
				<%
					vTotalNoSecondary = vTotalNoSecondary + RS("NoSecondary T/E")
					vTotalTE = vTotalTE + RS("NoSecondary T/E")
					'RS.MoveNext
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
					'RS.MoveNext
				End If

				'NoSecondary Eye
				If ReferralTypeList(2,2)= 1 Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=3_AND_(FSCaseBillSecondaryUserID_IS_NULL_OR_FSCaseBillSecondaryUserID=0)_AND_(FSCaseBillApproachUserID_IS_NULL_OR_FSCaseBillApproachUserID=0)_AND_(FSCaseBillMedSocUserID_IS_NULL_OR_FSCaseBillMedSocUserID=0)_AND_ReferralOrganAppropriateID_<>1_AND_ReferralEyesTransAppropriateID_=1_AND_ReferralBoneAppropriateID_<>_1_AND_ReferralTissueAppropriateID_<>_1_AND_ReferralSkinAppropriateID_<>_1_AND_ReferralValvesAppropriateID_<>_1_AND_ReferralEyesRschAppropriateID_<>_1_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<%=RS("NoSecondary Eye")%>
						</A>
					</FONT></TD>
				<%
					vTotalNoSecondary = vTotalNoSecondary + RS("NoSecondary Eye")
					vTotalE = vTotalE + RS("NoSecondary Eye")
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
					'RS.MoveNext
				End If								
				'NoSecondary Other Eye
				If ReferralTypeList(2,2)= 1 Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_(Referral.ReferralTypeID=4_OR_Referral.ReferralTypeID=3)_AND_(FSCaseBillSecondaryUserID_IS_NULL_OR_FSCaseBillSecondaryUserID=0)_AND_(FSCaseBillApproachUserID_IS_NULL_OR_FSCaseBillApproachUserID=0)_AND_(FSCaseBillMedSocUserID_IS_NULL_OR_FSCaseBillMedSocUserID=0)_AND_ReferralOrganAppropriateID_<>1_AND_ReferralEyesTransAppropriateID=1_AND_ReferralBoneAppropriateID_>_1_AND_ReferralTissueAppropriateID_>_1_AND_ReferralSkinAppropriateID_>_1_AND_ReferralValvesAppropriateID_>_1_AND_ReferralEyesRschAppropriateID=1_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">	
						<%=RS("NoSecondary Other Eye")%>
						</A>
					</FONT></TD>
				<%
					vTotalNoSecondary = vTotalNoSecondary + RS("NoSecondary Other Eye")
					vTotalOtherEye = vTotalOtherEye + RS("NoSecondary Other Eye")
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
					'RS.MoveNext		
				END IF	
				'NoSecondary Other
				If ReferralTypeList(2,3)= 1 Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=4_AND_(FSCaseBillSecondaryUserID_IS_NULL_OR_FSCaseBillSecondaryUserID=0)_AND_(FSCaseBillApproachUserID_IS_NULL_OR_FSCaseBillApproachUserID=0)_AND_(FSCaseBillMedSocUserID_IS_NULL_OR_FSCaseBillMedSocUserID=0)_AND_ReferralOrganAppropriateID_<>1_AND_ReferralEyesTransAppropriateID_<>1_AND_ReferralBoneAppropriateID_<>_1_AND_ReferralTissueAppropriateID_<>_1_AND_ReferralSkinAppropriateID_<>_1_AND_ReferralValvesAppropriateID_<>_1_AND_ReferralEyesRschAppropriateID=1_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<%=RS("NoSecondary Other")%>
						</A>
					</FONT></TD>
				<%
					vTotalNoSecondary = vTotalNoSecondary + RS("NoSecondary Other")
					vTotalOther = vTotalOther + RS("NoSecondary Other")
				
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
					'RS.MoveNext
				End If								

				'RO Count
				If ReferralTypeList(2,3)= 1 Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
						
						<%=RS("NoSecondary Total RO")%>
						
					</FONT></TD>
				<%
					vTotalNoSecondary = vTotalNoSecondary + RS("NoSecondary Total RO")
					vTotalRO = vTotalRO + RS("NoSecondary Total RO")

				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%

				End If											



				If (ReferralTypeList(2,3)= 1) Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><i>
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=4_AND_(FSCaseBillSecondaryUserID_IS_NULL_OR_FSCaseBillSecondaryUserID=0)_AND_(FSCaseBillApproachUserID_IS_NULL_OR_FSCaseBillApproachUserID=0)_AND_(FSCaseBillMedSocUserID_IS_NULL_OR_FSCaseBillMedSocUserID=0)_AND_ReferralBoneAppropriateID_<>_4_AND_ReferralBoneAppropriateID_<>_3_AND_ReferralTissueAppropriateID_<>_4_AND_ReferralTissueAppropriateID_<>_3_AND_ReferralSkinAppropriateID_<>_4_AND_ReferralSkinAppropriateID_<>_3_AND_ReferralValvesAppropriateID_<>_4_AND_ReferralValvesAppropriateID_<>_3_AND_ReferralEyesTransAppropriateID_<>_4_AND_ReferralEyesTransAppropriateID_<>_3_AND_ReferralEyesRschAppropriateID_<>_1_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<%=RS("NoSecondary Age RO")%>
						</A>
					</i></FONT></TD>
				<%		
					vTotalROA = vTotalROA + RS("NoSecondary Age RO")

				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
				End If	
				'ROM Count

				If (ReferralTypeList(2,3)= 1) Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><i>
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=4_AND_(FSCaseBillSecondaryUserID_IS_NULL_OR_FSCaseBillSecondaryUserID=0)_AND_(FSCaseBillApproachUserID_IS_NULL_OR_FSCaseBillApproachUserID=0)_AND_(FSCaseBillMedSocUserID_IS_NULL_OR_FSCaseBillMedSocUserID=0)_AND_(ReferralBoneAppropriateID=4_OR_ReferralBoneAppropriateID=3_OR_ReferralTissueAppropriateID=4_OR_ReferralTissueAppropriateID=3_OR_ReferralSkinAppropriateID=4_OR_ReferralSkinAppropriateID=3_OR_ReferralValvesAppropriateID=4_OR_ReferralValvesAppropriateID=3_OR_ReferralEyesTransAppropriateID=4_OR_ReferralEyesTransAppropriateID=3)_AND_ReferralEyesRschAppropriateID_<>_1_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<%=RS("NoSecondary Med RO")%>
						</A>
					</i></FONT></TD>
				<%		
					vTotalROM = vTotalROM + RS("NoSecondary Med RO")	
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
				End If	

				
				'Total NoSecondary =vTotalNoSecondary RS("TotalNoSecondary")
				%>
				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><B><%=vTotalNoSecondary%></B></FONT></TD>
			</TR>
		


<!-- Secondary -->
			<TR> 
				<TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeData%>">Secondary</FONT></TD>
				
			<%	
			vTotalSecondary = 0
						

				'OTE Count
				
				If ReferralTypeList(2,0)= 1 Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=1_AND_(FSCaseBillSecondaryUserID_IS_NOT_NULL_AND_FSCaseBillSecondaryUserID_<>_0)_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<%=RS("Secondary OTE")%>
						</A>
					</FONT></TD>
				<%
					vTotalSecondary = vTotalSecondary + RS("Secondary OTE")
					vTotalOTE = vTotalOTE + RS("Secondary OTE")
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
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=2_AND_(FSCaseBillSecondaryUserID_IS_NOT_NULL_AND_FSCaseBillSecondaryUserID_<>_0)_AND_ReferralOrganAppropriateID_<>1_AND_ReferralEyesTransAppropriateID_<>1_AND_(_ReferralBoneAppropriateID=1_OR_ReferralTissueAppropriateID=1_OR_ReferralSkinAppropriateID=1_OR_ReferralValvesAppropriateID=1)_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<%=RS("Secondary Tissue")%>
						</A>
					</FONT></TD>
				<%
					vTotalSecondary = vTotalSecondary + RS("Secondary Tissue")
					vTotalTissue = vTotalTissue + RS("Secondary Tissue")
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
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=2_AND_(FSCaseBillSecondaryUserID_IS_NOT_NULL_AND_FSCaseBillSecondaryUserID_<>_0)_AND_ReferralOrganAppropriateID_<>1_AND_ReferralEyesTransAppropriateID_=1_AND_(_ReferralBoneAppropriateID=1_OR_ReferralTissueAppropriateID=1_OR_ReferralSkinAppropriateID=1_OR_ReferralValvesAppropriateID=1)_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<%=RS("Secondary T/E")%>
						</A>
					</FONT></TD>
				<%
					vTotalSecondary = vTotalSecondary + RS("Secondary T/E")
					vTotalTE = vTotalTE + RS("Secondary T/E")
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
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=3_AND_(FSCaseBillSecondaryUserID_IS_NOT_NULL_AND_FSCaseBillSecondaryUserID_<>_0)_AND_ReferralOrganAppropriateID_<>1_AND_ReferralEyesTransAppropriateID_=1_AND_ReferralBoneAppropriateID_<>_1_AND_ReferralTissueAppropriateID_<>_1_AND_ReferralSkinAppropriateID_<>_1_AND_ReferralValvesAppropriateID_<>_1_AND_ReferralEyesRschAppropriateID_<>_1_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<%=RS("Secondary Eye")%>
						</A>						
					</FONT></TD>
				<%
					vTotalSecondary = vTotalSecondary + RS("Secondary Eye")
					vTotalE = vTotalE + RS("Secondary Eye")
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
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_(Referral.ReferralTypeID=4_OR_Referral.ReferralTypeID=3)_AND_(FSCaseBillSecondaryUserID_IS_NOT_NULL_AND_FSCaseBillSecondaryUserID_<>_0)_AND_ReferralOrganAppropriateID_<>1_AND_ReferralEyesTransAppropriateID=1_AND_ReferralBoneAppropriateID_<>_1_AND_ReferralTissueAppropriateID_<>_1_AND_ReferralSkinAppropriateID_<>_1_AND_ReferralValvesAppropriateID_<>_1_AND_ReferralEyesRschAppropriateID=1_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<%=RS("Secondary Other Eye")%>
						</A>
					</FONT></TD>
				<%
					vTotalSecondary = vTotalSecondary + RS("Secondary Other Eye")
					vTotalOtherEye = vTotalOtherEye + RS("Secondary Other Eye")
					'RS.MoveNext
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
					'RS.MoveNext
				End If		

				'Secondary Other
				If ReferralTypeList(2,3)= 1 Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=11&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=4_AND_(FSCaseBillSecondaryUserID_IS_NOT_NULL_AND_FSCaseBillSecondaryUserID_<>_0)_AND_ReferralOrganAppropriateID_<>1_AND_ReferralEyesTransAppropriateID_<>1_AND_ReferralBoneAppropriateID_<>_1_AND_ReferralTissueAppropriateID_<>_1_AND_ReferralSkinAppropriateID_<>_1_AND_ReferralValvesAppropriateID_<>_1_AND_ReferralEyesRschAppropriateID=1_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<%=RS("Secondary Other")%>
						</A>
					</FONT></TD>
				<%
					vTotalSecondary = vTotalSecondary + RS("Secondary Other")
					vTotalOther = vTotalOther + RS("Secondary Other")
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
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><%=RS("Secondary Total RO")%></FONT></TD>
				<%
					vTotalSecondary = vTotalSecondary + RS("Secondary Total RO")
					vTotalRO = vTotalRO + RS("Secondary Total RO")
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
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><i>
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=4_AND_(FSCaseBillSecondaryUserID_IS_NOT_NULL_AND_FSCaseBillSecondaryUserID_<>_0)_AND_ReferralBoneAppropriateID_<>_4_AND_ReferralBoneAppropriateID_<>_3_AND_ReferralTissueAppropriateID_<>_4_AND_ReferralTissueAppropriateID_<>_3_AND_ReferralSkinAppropriateID_<>_4_AND_ReferralSkinAppropriateID_<>_3_AND_ReferralValvesAppropriateID_<>_4_AND_ReferralValvesAppropriateID_<>_3_AND_ReferralEyesTransAppropriateID_<>_4_AND_ReferralEyesTransAppropriateID_<>_3_AND_ReferralEyesRschAppropriateID_<>_1_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<%=RS("Secondary Age RO")%>
						</A>
					</i></FONT></TD>
				<%		
					vTotalROA = vTotalROA + RS("Secondary Age RO")	
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
				End If	
				
				'ROM Count					
				If (ReferralTypeList(2,3)= 1) Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><i>
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=4_AND_(FSCaseBillSecondaryUserID_IS_NOT_NULL_AND_FSCaseBillSecondaryUserID_<>_0)_AND_(ReferralBoneAppropriateID=4_OR_ReferralBoneAppropriateID=3_OR_ReferralTissueAppropriateID=4_OR_ReferralTissueAppropriateID=3_OR_ReferralSkinAppropriateID=4_OR_ReferralSkinAppropriateID=3_OR_ReferralValvesAppropriateID=4_OR_ReferralValvesAppropriateID=3_OR_ReferralEyesTransAppropriateID=4_OR_ReferralEyesTransAppropriateID=3)_AND_ReferralEyesRschAppropriateID_<>_1_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<%=RS("Secondary Med RO")%>
						</A>
					</i></FONT></TD>
				<%		
					vTotalROM = vTotalROM + RS("Secondary Med RO")	
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
				End If	
							
			'TotalSecondary	vTotalSecondary RS("TotalSecondary")							
			%>

				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><B><%=vTotalSecondary%></B></FONT></TD>
			</TR>
			
<!-- Secondary with Approach     DEO 5/20/2003 -->
			<TR> 
				<TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeData%>">Secondary with Approach</FONT></TD>
				
			<%	
			vTotalSecondaryApproach = 0
						

				'OTE Count
				
				If ReferralTypeList(2,0)= 1 Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=1_AND_(FSCaseBillSecondaryUserID_IS_NOT_NULL_AND_FSCaseBillSecondaryUserID_<>_0)_AND_(FSCaseBillApproachUserID_IS_NOT_NULL_AND_FSCaseBillApproachUserID_<>_0)_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<%=RS("SecondaryApproachOTE")%>
						</A>
					</FONT></TD>
				<%
					vTotalSecondaryApproach = vTotalSecondaryApproach + RS("SecondaryApproachOTE")
					vTotalOTE = vTotalOTE + RS("SecondaryApproachOTE")
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
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=2_AND_(FSCaseBillSecondaryUserID_IS_NOT_NULL_AND_FSCaseBillSecondaryUserID_<>_0)_AND_(FSCaseBillApproachUserID_IS_NOT_NULL_AND_FSCaseBillApproachUserID_<>_0)_AND_ReferralOrganAppropriateID_<>1_AND_ReferralEyesTransAppropriateID_<>1_AND_(_ReferralBoneAppropriateID=1_OR_ReferralTissueAppropriateID=1_OR_ReferralSkinAppropriateID=1_OR_ReferralValvesAppropriateID=1)_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<%=RS("SecondaryApproachTissue")%>
						</A>
					</FONT></TD>
				<%
					vTotalSecondaryApproach = vTotalSecondaryApproach + RS("SecondaryApproachTissue")
					vTotalTissue = vTotalTissue + RS("SecondaryApproachTissue")
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
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=2_AND_(FSCaseBillSecondaryUserID_IS_NOT_NULL_AND_FSCaseBillSecondaryUserID_<>_0)_AND_(FSCaseBillApproachUserID_IS_NOT_NULL_AND_FSCaseBillApproachUserID_<>_0)_AND_ReferralOrganAppropriateID_<>1_AND_ReferralEyesTransAppropriateID_=1_AND_(_ReferralBoneAppropriateID=1_OR_ReferralTissueAppropriateID=1_OR_ReferralSkinAppropriateID=1_OR_ReferralValvesAppropriateID=1)_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<%=RS("SecondaryApproachTE")%>
						</A>
					</FONT></TD>
				<%
					vTotalSecondaryApproach = vTotalSecondaryApproach + RS("SecondaryApproachTE")
					vTotalTE = vTotalTE + RS("SecondaryApproachTE")
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
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=3_AND_(FSCaseBillSecondaryUserID_IS_NOT_NULL_AND_FSCaseBillSecondaryUserID_<>_0)_AND_(FSCaseBillApproachUserID_IS_NOT_NULL_AND_FSCaseBillApproachUserID_<>_0)_AND_ReferralOrganAppropriateID_<>1_AND_ReferralEyesTransAppropriateID_=1_AND_ReferralBoneAppropriateID_<>_1_AND_ReferralTissueAppropriateID_<>_1_AND_ReferralSkinAppropriateID_<>_1_AND_ReferralValvesAppropriateID_<>_1_AND_ReferralEyesRschAppropriateID_<>_1_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<%=RS("SecondaryApproachEye")%>
						</A>						
					</FONT></TD>
				<%
					vTotalSecondaryApproach = vTotalSecondaryApproach + RS("SecondaryApproachEye")
					vTotalE = vTotalE + RS("SecondaryApproachEye")
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
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_(Referral.ReferralTypeID=4_OR_Referral.ReferralTypeID=3)_AND_(FSCaseBillSecondaryUserID_IS_NOT_NULL_AND_FSCaseBillSecondaryUserID_<>_0)_AND_(FSCaseBillApproachUserID_IS_NOT_NULL_AND_FSCaseBillApproachUserID_<>_0)_AND_ReferralOrganAppropriateID_<>1_AND_ReferralEyesTransAppropriateID=1_AND_ReferralBoneAppropriateID_<>_1_AND_ReferralTissueAppropriateID_<>_1_AND_ReferralSkinAppropriateID_<>_1_AND_ReferralValvesAppropriateID_<>_1_AND_ReferralEyesRschAppropriateID=1_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<%=RS("SecondaryApproachOtherEye")%>
						</A>
					</FONT></TD>
				<%
					vTotalSecondaryApproach = vTotalSecondaryApproach + RS("SecondaryApproachOtherEye")
					vTotalOtherEye = vTotalOtherEye + RS("SecondaryApproachOtherEye")
					'RS.MoveNext
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
					'RS.MoveNext
				End If		

				'Secondary Other
				If ReferralTypeList(2,3)= 1 Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=11&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=4_AND_(FSCaseBillSecondaryUserID_IS_NOT_NULL_AND_FSCaseBillSecondaryUserID_<>_0)_AND_(FSCaseBillApproachUserID_IS_NOT_NULL_AND_FSCaseBillApproachUserID_<>_0)_AND_ReferralOrganAppropriateID_<>1_AND_ReferralEyesTransAppropriateID_<>1_AND_ReferralBoneAppropriateID_<>_1_AND_ReferralTissueAppropriateID_<>_1_AND_ReferralSkinAppropriateID_<>_1_AND_ReferralValvesAppropriateID_<>_1_AND_ReferralEyesRschAppropriateID=1_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<%=RS("SecondaryApproachOther")%>
						</A>
					</FONT></TD>
				<%
					vTotalSecondaryApproach = vTotalSecondaryApproach + RS("SecondaryApproachOther")
					vTotalOther = vTotalOther + RS("SecondaryApproachOther")
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
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><%=RS("Total SecondaryApproach RO Count")%></FONT></TD>
				<%
					vTotalSecondaryApproach = vTotalSecondaryApproach + RS("Total SecondaryApproach RO Count")
					vTotalRO = vTotalRO + RS("Total SecondaryApproach RO Count")
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
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><i>
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=4_AND_(FSCaseBillSecondaryUserID_IS_NOT_NULL_AND_FSCaseBillSecondaryUserID_<>_0)_AND_(FSCaseBillApproachUserID_IS_NOT_NULL_AND_FSCaseBillApproachUserID_<>_0)_AND_ReferralBoneAppropriateID_<>_4_AND_ReferralBoneAppropriateID_<>_3_AND_ReferralTissueAppropriateID_<>_4_AND_ReferralTissueAppropriateID_<>_3_AND_ReferralSkinAppropriateID_<>_4_AND_ReferralSkinAppropriateID_<>_3_AND_ReferralValvesAppropriateID_<>_4_AND_ReferralValvesAppropriateID_<>_3_AND_ReferralEyesTransAppropriateID_<>_4_AND_ReferralEyesTransAppropriateID_<>_3_AND_ReferralEyesRschAppropriateID_<>_1_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<%=RS("SecondaryApproachAgeRO")%>
						</A>
					</i></FONT></TD>
				<%		
					vTotalROA = vTotalROA + RS("SecondaryApproachAgeRO")	
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
				End If	
				
				'ROM Count					
				If (ReferralTypeList(2,3)= 1) Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><i>
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=4_AND_(FSCaseBillSecondaryUserID_IS_NOT_NULL_AND_FSCaseBillSecondaryUserID_<>_0)_AND_(FSCaseBillApproachUserID_IS_NOT_NULL_AND_FSCaseBillApproachUserID_<>_0)_AND_(ReferralBoneAppropriateID=4_OR_ReferralBoneAppropriateID=3_OR_ReferralTissueAppropriateID=4_OR_ReferralTissueAppropriateID=3_OR_ReferralSkinAppropriateID=4_OR_ReferralSkinAppropriateID=3_OR_ReferralValvesAppropriateID=4_OR_ReferralValvesAppropriateID=3_OR_ReferralEyesTransAppropriateID=4_OR_ReferralEyesTransAppropriateID=3)_AND_ReferralEyesRschAppropriateID_<>_1_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<%=RS("SecondaryApproachMedRO")%>
						</A>
					</i></FONT></TD>
				<%		
					vTotalROM = vTotalROM + RS("SecondaryApproachMedRO")	
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
				End If	
							
			'TotalSecondary	vTotalSecondaryApproach RS("SecondaryApproach Totals Count")							
			%>

				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><B><%=vTotalSecondaryApproach%></B></FONT></TD>
			</TR>


<!-- Secondary No Approach  DEO 5/20/2003 -->
			<TR> 
				<TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeData%>">Secondary without Approach</FONT></TD>
				
			<%	
			vTotalSecondaryNoApproach = 0
						

				'OTE Count
				
				If ReferralTypeList(2,0)= 1 Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=1_AND_(FSCaseBillSecondaryUserID_IS_NOT_NULL_AND_FSCaseBillSecondaryUserID_<>_0)_AND_(FSCaseBillApproachUserID_IS_NULL_OR_FSCaseBillApproachUserID_=_0)_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<%=RS("SecondaryNoApproachOTE")%>
						</A>
					</FONT></TD>
				<%
					vTotalSecondaryNoApproach = vTotalSecondaryNoApproach + RS("SecondaryNoApproachOTE")
					vTotalOTE = vTotalOTE + RS("SecondaryNoApproachOTE")
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
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=2_AND_(FSCaseBillSecondaryUserID_IS_NOT_NULL_AND_FSCaseBillSecondaryUserID_<>_0)_AND_(FSCaseBillApproachUserID_IS_NULL_OR_FSCaseBillApproachUserID_=_0)_AND_ReferralOrganAppropriateID_<>1_AND_ReferralEyesTransAppropriateID_<>1_AND_(_ReferralBoneAppropriateID=1_OR_ReferralTissueAppropriateID=1_OR_ReferralSkinAppropriateID=1_OR_ReferralValvesAppropriateID=1)_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<%=RS("SecondaryNoApproachTissue")%>
						</A>
					</FONT></TD>
				<%
					vTotalSecondaryNoApproach = vTotalSecondaryNoApproach + RS("SecondaryNoApproachTissue")
					vTotalTissue = vTotalTissue + RS("SecondaryNoApproachTissue")
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
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=2_AND_(FSCaseBillSecondaryUserID_IS_NOT_NULL_AND_FSCaseBillSecondaryUserID_<>_0)_AND_(FSCaseBillApproachUserID_IS_NULL_OR_FSCaseBillApproachUserID_=_0)_AND_ReferralOrganAppropriateID_<>1_AND_ReferralEyesTransAppropriateID_=1_AND_(_ReferralBoneAppropriateID=1_OR_ReferralTissueAppropriateID=1_OR_ReferralSkinAppropriateID=1_OR_ReferralValvesAppropriateID=1)_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<%=RS("SecondaryNoApproachTE")%>
						</A>
					</FONT></TD>
				<%
					vTotalSecondaryNoApproach = vTotalSecondaryNoApproach + RS("SecondaryNoApproachTE")
					vTotalTE = vTotalTE + RS("SecondaryNoApproachTE")
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
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=3_AND_(FSCaseBillSecondaryUserID_IS_NOT_NULL_AND_FSCaseBillSecondaryUserID_<>_0)_AND_(FSCaseBillApproachUserID_IS_NULL_OR_FSCaseBillApproachUserID_=_0)_AND_ReferralOrganAppropriateID_<>1_AND_ReferralEyesTransAppropriateID_=1_AND_ReferralBoneAppropriateID_<>_1_AND_ReferralTissueAppropriateID_<>_1_AND_ReferralSkinAppropriateID_<>_1_AND_ReferralValvesAppropriateID_<>_1_AND_ReferralEyesRschAppropriateID_<>_1_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<%=RS("SecondaryNoApproachEye")%>
						</A>						
					</FONT></TD>
				<%
					vTotalSecondaryNoApproach = vTotalSecondaryNoApproach + RS("SecondaryNoApproachEye")
					vTotalE = vTotalE + RS("SecondaryNoApproachEye")
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
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_(Referral.ReferralTypeID=4_OR_Referral.ReferralTypeID=3)_AND_(FSCaseBillSecondaryUserID_IS_NOT_NULL_AND_FSCaseBillSecondaryUserID_<>_0)_AND_(FSCaseBillApproachUserID_IS_NULL_OR_FSCaseBillApproachUserID_=_0)_AND_ReferralOrganAppropriateID_<>1_AND_ReferralEyesTransAppropriateID=1_AND_ReferralBoneAppropriateID_<>_1_AND_ReferralTissueAppropriateID_<>_1_AND_ReferralSkinAppropriateID_<>_1_AND_ReferralValvesAppropriateID_<>_1_AND_ReferralEyesRschAppropriateID=1_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<%=RS("SecondaryNoApproachOtherEye")%>
						</A>
					</FONT></TD>
				<%
					vTotalSecondaryNoApproach = vTotalSecondaryNoApproach + RS("SecondaryNoApproachOtherEye")
					vTotalOtherEye = vTotalOtherEye + RS("SecondaryNoApproachOtherEye")
					'RS.MoveNext
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
					'RS.MoveNext
				End If		

				'Secondary Other
				If ReferralTypeList(2,3)= 1 Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=11&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=4_AND_(FSCaseBillSecondaryUserID_IS_NOT_NULL_AND_FSCaseBillSecondaryUserID_<>_0)_AND_(FSCaseBillApproachUserID_IS_NULL_OR_FSCaseBillApproachUserID_=_0)_AND_ReferralOrganAppropriateID_<>1_AND_ReferralEyesTransAppropriateID_<>1_AND_ReferralBoneAppropriateID_<>_1_AND_ReferralTissueAppropriateID_<>_1_AND_ReferralSkinAppropriateID_<>_1_AND_ReferralValvesAppropriateID_<>_1_AND_ReferralEyesRschAppropriateID=1_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<%=RS("SecondaryNoApproachOther")%>
						</A>
					</FONT></TD>
				<%
					vTotalSecondaryNoApproach = vTotalSecondaryNoApproach + RS("SecondaryNoApproachOther")
					vTotalOther = vTotalOther + RS("SecondaryNoApproachOther")
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
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><%=RS("Total SecondaryNoApproach RO Count")%></FONT></TD>
				<%
					vTotalSecondaryNoApproach = vTotalSecondaryNoApproach + RS("Total SecondaryNoApproach RO Count")
					vTotalRO = vTotalRO + RS("Total SecondaryNoApproach RO Count")
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
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><i>
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=4_AND_(FSCaseBillSecondaryUserID_IS_NOT_NULL_AND_FSCaseBillSecondaryUserID_<>_0)_AND_(FSCaseBillApproachUserID_IS_NULL_OR_FSCaseBillApproachUserID_=_0)_AND_ReferralBoneAppropriateID_<>_4_AND_ReferralBoneAppropriateID_<>_3_AND_ReferralTissueAppropriateID_<>_4_AND_ReferralTissueAppropriateID_<>_3_AND_ReferralSkinAppropriateID_<>_4_AND_ReferralSkinAppropriateID_<>_3_AND_ReferralValvesAppropriateID_<>_4_AND_ReferralValvesAppropriateID_<>_3_AND_ReferralEyesTransAppropriateID_<>_4_AND_ReferralEyesTransAppropriateID_<>_3_AND_ReferralEyesRschAppropriateID_<>_1_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<%=RS("SecondaryNoApproachAgeRO")%>
						</A>
					</i></FONT></TD>
				<%		
					vTotalROA = vTotalROA + RS("SecondaryNoApproachAgeRO")	
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
				End If	
				
				'ROM Count					
				If (ReferralTypeList(2,3)= 1) Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><i>
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=4_AND_(FSCaseBillSecondaryUserID_IS_NOT_NULL_AND_FSCaseBillSecondaryUserID_<>_0)_AND_(FSCaseBillApproachUserID_IS_NULL_OR_FSCaseBillApproachUserID_=_0)_AND_(ReferralBoneAppropriateID=4_OR_ReferralBoneAppropriateID=3_OR_ReferralTissueAppropriateID=4_OR_ReferralTissueAppropriateID=3_OR_ReferralSkinAppropriateID=4_OR_ReferralSkinAppropriateID=3_OR_ReferralValvesAppropriateID=4_OR_ReferralValvesAppropriateID=3_OR_ReferralEyesTransAppropriateID=4_OR_ReferralEyesTransAppropriateID=3)_AND_ReferralEyesRschAppropriateID_<>_1_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<%=RS("SecondaryNoApproachMedRO")%>
						</A>
					</i></FONT></TD>
				<%		
					vTotalROM = vTotalROM + RS("SecondaryNoApproachMedRO")	
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
				End If	
							
			'TotalSecondary	vTotalSecondaryNoApproach RS("SecondaryNoApproach Totals Count")							
			%>

				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><B><%=vTotalSecondaryNoApproach%></B></FONT></TD>
			</TR>




<!-- No Secondary with Approach    DEO 5/20/2003-->
			<TR> 
				<TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeData%>">No Secondary with Approach</FONT></TD>
				
			<%	
			vTotalNoSecondaryApproach = 0
						

				'OTE Count
				
				If ReferralTypeList(2,0)= 1 Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=1_AND_(FSCaseBillSecondaryUserID_IS_NULL_OR_FSCaseBillSecondaryUserID_=_0)_AND_(FSCaseBillApproachUserID_IS_NOT_NULL_AND_FSCaseBillApproachUserID_<>_0)_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<%=RS("NoSecondaryApproachOTE")%>
						</A>
					</FONT></TD>
				<%
					vTotalNoSecondaryApproach = vTotalNoSecondaryApproach + RS("NoSecondaryApproachOTE")
					vTotalOTE = vTotalOTE + RS("NoSecondaryApproachOTE")
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
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=2_AND_(FSCaseBillSecondaryUserID_IS_NULL_OR_FSCaseBillSecondaryUserID_=_0)_AND_(FSCaseBillApproachUserID_IS_NOT_NULL_AND_FSCaseBillApproachUserID_<>_0)_AND_ReferralOrganAppropriateID_<>1_AND_ReferralEyesTransAppropriateID_<>1_AND_(_ReferralBoneAppropriateID=1_OR_ReferralTissueAppropriateID=1_OR_ReferralSkinAppropriateID=1_OR_ReferralValvesAppropriateID=1)_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<%=RS("NoSecondaryApproachTissue")%>
						</A>
					</FONT></TD>
				<%
					vTotalNoSecondaryApproach = vTotalNoSecondaryApproach + RS("NoSecondaryApproachTissue")
					vTotalTissue = vTotalTissue + RS("NoSecondaryApproachTissue")
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
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=2_AND_(FSCaseBillSecondaryUserID_IS_NULL_OR_FSCaseBillSecondaryUserID_=_0)_AND_(FSCaseBillApproachUserID_IS_NOT_NULL_AND_FSCaseBillApproachUserID_<>_0)_AND_ReferralOrganAppropriateID_<>1_AND_ReferralEyesTransAppropriateID_=1_AND_(_ReferralBoneAppropriateID=1_OR_ReferralTissueAppropriateID=1_OR_ReferralSkinAppropriateID=1_OR_ReferralValvesAppropriateID=1)_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<%=RS("NoSecondaryApproachTE")%>
						</A>
					</FONT></TD>
				<%
					vTotalNoSecondaryApproach = vTotalNoSecondaryApproach + RS("NoSecondaryApproachTE")
					vTotalTE = vTotalTE + RS("NoSecondaryApproachTE")
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
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=3_AND_(FSCaseBillSecondaryUserID_IS_NULL_OR_FSCaseBillSecondaryUserID_=_0)_AND_(FSCaseBillApproachUserID_IS_NOT_NULL_AND_FSCaseBillApproachUserID_<>_0)_AND_ReferralOrganAppropriateID_<>1_AND_ReferralEyesTransAppropriateID_=1_AND_ReferralBoneAppropriateID_<>_1_AND_ReferralTissueAppropriateID_<>_1_AND_ReferralSkinAppropriateID_<>_1_AND_ReferralValvesAppropriateID_<>_1_AND_ReferralEyesRschAppropriateID_<>_1_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<%=RS("NoSecondaryApproachEye")%>
						</A>						
					</FONT></TD>
				<%
					vTotalNoSecondaryApproach = vTotalNoSecondaryApproach + RS("NoSecondaryApproachEye")
					vTotalE = vTotalE + RS("NoSecondaryApproachEye")
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
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_(Referral.ReferralTypeID=4_OR_Referral.ReferralTypeID=3)_AND_(FSCaseBillSecondaryUserID_IS_NULL_OR_FSCaseBillSecondaryUserID_=_0)_AND_(FSCaseBillApproachUserID_IS_NOT_NULL_AND_FSCaseBillApproachUserID_<>_0)_AND_ReferralOrganAppropriateID_<>1_AND_ReferralEyesTransAppropriateID=1_AND_ReferralBoneAppropriateID_<>_1_AND_ReferralTissueAppropriateID_<>_1_AND_ReferralSkinAppropriateID_<>_1_AND_ReferralValvesAppropriateID_<>_1_AND_ReferralEyesRschAppropriateID=1_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<%=RS("NoSecondaryApproachOtherEye")%>
						</A>
					</FONT></TD>
				<%
					vTotalNoSecondaryApproach = vTotalNoSecondaryApproach + RS("NoSecondaryApproachOtherEye")
					vTotalOtherEye = vTotalOtherEye + RS("NoSecondaryApproachOtherEye")
					'RS.MoveNext
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
					'RS.MoveNext
				End If		

				'Secondary Other
				If ReferralTypeList(2,3)= 1 Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=11&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=4_AND_(FSCaseBillSecondaryUserID_IS_NULL_OR_FSCaseBillSecondaryUserID_=_0)_AND_(FSCaseBillApproachUserID_IS_NOT_NULL_AND_FSCaseBillApproachUserID_<>_0)_AND_ReferralOrganAppropriateID_<>1_AND_ReferralEyesTransAppropriateID_<>1_AND_ReferralBoneAppropriateID_<>_1_AND_ReferralTissueAppropriateID_<>_1_AND_ReferralSkinAppropriateID_<>_1_AND_ReferralValvesAppropriateID_<>_1_AND_ReferralEyesRschAppropriateID=1_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<%=RS("NoSecondaryApproachOther")%>
						</A>
					</FONT></TD>
				<%
					vTotalNoSecondaryApproach = vTotalNoSecondaryApproach + RS("NoSecondaryApproachOther")
					vTotalOther = vTotalOther + RS("NoSecondaryApproachOther")
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
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><%=RS("Total NoSecondaryApproach RO Count")%></FONT></TD>
				<%
					vTotalNoSecondaryApproach = vTotalNoSecondaryApproach + RS("Total NoSecondaryApproach RO Count")
					vTotalRO = vTotalRO + RS("Total NoSecondaryApproach RO Count")
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
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><i>
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=4_AND_(FSCaseBillSecondaryUserID_IS_NULL_OR_FSCaseBillSecondaryUserID_=_0)_AND_(FSCaseBillApproachUserID_IS_NOT_NULL_AND_FSCaseBillApproachUserID_<>_0)_AND_ReferralBoneAppropriateID_<>_4_AND_ReferralBoneAppropriateID_<>_3_AND_ReferralTissueAppropriateID_<>_4_AND_ReferralTissueAppropriateID_<>_3_AND_ReferralSkinAppropriateID_<>_4_AND_ReferralSkinAppropriateID_<>_3_AND_ReferralValvesAppropriateID_<>_4_AND_ReferralValvesAppropriateID_<>_3_AND_ReferralEyesTransAppropriateID_<>_4_AND_ReferralEyesTransAppropriateID_<>_3_AND_ReferralEyesRschAppropriateID_<>_1_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<%=RS("NoSecondaryApproachAgeRO")%>
						</A>
					</i></FONT></TD>
				<%		
					vTotalROA = vTotalROA + RS("NoSecondaryApproachAgeRO")	
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
				End If	
				
				'ROM Count					
				If (ReferralTypeList(2,3)= 1) Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><i>
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=4_AND_(FSCaseBillSecondaryUserID_IS_NULL_OR_FSCaseBillSecondaryUserID_=_0)_AND_(FSCaseBillApproachUserID_IS_NOT_NULL_AND_FSCaseBillApproachUserID_<>_0)_AND_(ReferralBoneAppropriateID=4_OR_ReferralBoneAppropriateID=3_OR_ReferralTissueAppropriateID=4_OR_ReferralTissueAppropriateID=3_OR_ReferralSkinAppropriateID=4_OR_ReferralSkinAppropriateID=3_OR_ReferralValvesAppropriateID=4_OR_ReferralValvesAppropriateID=3_OR_ReferralEyesTransAppropriateID=4_OR_ReferralEyesTransAppropriateID=3)_AND_ReferralEyesRschAppropriateID_<>_1_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<%=RS("NoSecondaryApproachMedRO")%>
						</A>
					</i></FONT></TD>
				<%		
					vTotalROM = vTotalROM + RS("NoSecondaryApproachMedRO")	
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
				End If	
							
			'TotalSecondary	vTotalNoSecondaryApproach RS("NoSecondaryApproach Totals Count")							
			%>

				<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><B><%=vTotalNoSecondaryApproach%></B></FONT></TD>
			</TR>



			
<!-- 1/20/03 drh - FamilyUnavailable -->
<TR> 
				<TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeData%>">Family Unavailable</FONT></TD>
				
			<%				
			vFamilyUnavailableTotals = 0
						
				'OTE Count

				If ReferralTypeList(2,0)= 1 Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1	&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=1_AND_(FSCaseBillFamUnavailUserID_IS_NOT_NULL_AND_FSCaseBillFamUnavailUserID_<>_0)_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<%=RS("FamilyUnavailable OTE")%>
						</A>
					</FONT></TD>
				<%
					vFamilyUnavailableTotals = vFamilyUnavailableTotals + RS("FamilyUnavailable OTE")
					vTotalOTE = vTotalOTE + RS("FamilyUnavailable OTE")
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
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=2_AND_(FSCaseBillFamUnavailUserID_IS_NOT_NULL_AND_FSCaseBillFamUnavailUserID_<>_0)_AND_ReferralOrganAppropriateID_<>1_AND_ReferralEyesTransAppropriateID_<>1_AND_(_ReferralBoneAppropriateID=1_OR_ReferralTissueAppropriateID=1_OR_ReferralSkinAppropriateID=1_OR_ReferralValvesAppropriateID=1)_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<%=RS("FamilyUnavailable Tissue")%>
						</A>
					</FONT></TD>
				<%
					vFamilyUnavailableTotals = vFamilyUnavailableTotals + RS("FamilyUnavailable Tissue")
					vTotalTissue = vTotalTissue + RS("FamilyUnavailable Tissue")
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
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=2_AND_(FSCaseBillFamUnavailUserID_IS_NOT_NULL_AND_FSCaseBillFamUnavailUserID_<>_0)_AND_ReferralOrganAppropriateID_<>1_AND_ReferralEyesTransAppropriateID_=1_AND_(_ReferralBoneAppropriateID=1_OR_ReferralTissueAppropriateID=1_OR_ReferralSkinAppropriateID=1_OR_ReferralValvesAppropriateID=1)_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<%=RS("FamilyUnavailable T/E")%>
						</A>
					</FONT></TD>
				<%
					vFamilyUnavailableTotals = vFamilyUnavailableTotals + RS("FamilyUnavailable T/E")
					vTotalTE = vTotalTE + RS("FamilyUnavailable T/E")
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
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=3_AND_(FSCaseBillFamUnavailUserID_IS_NOT_NULL_AND_FSCaseBillFamUnavailUserID_<>_0)_AND_ReferralOrganAppropriateID_<>1_AND_ReferralEyesTransAppropriateID_=1_AND_ReferralBoneAppropriateID_<>_1_AND_ReferralTissueAppropriateID_<>_1_AND_ReferralSkinAppropriateID_<>_1_AND_ReferralValvesAppropriateID_<>_1_AND_ReferralEyesRschAppropriateID_<>_1_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<%=RS("FamilyUnavailable Eye")%>
						</A>
					</FONT></TD>
				<%
					vFamilyUnavailableTotals = vFamilyUnavailableTotals + RS("FamilyUnavailable Eye")
					vTotalE = vTotalE + RS("FamilyUnavailable Eye")
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
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_(Referral.ReferralTypeID=4_OR_Referral.ReferralTypeID=3)_AND_(FSCaseBillFamUnavailUserID_IS_NOT_NULL_AND_FSCaseBillFamUnavailUserID_<>_0)_AND_ReferralOrganAppropriateID_<>1_AND_ReferralEyesTransAppropriateID=1_AND_ReferralBoneAppropriateID_<>_1_AND_ReferralTissueAppropriateID_<>_1_AND_ReferralSkinAppropriateID_<>_1_AND_ReferralValvesAppropriateID_<>_1_AND_ReferralEyesRschAppropriateID=1_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<%=RS("FamilyUnavailable Other Eye")%>
						</A>					
					</FONT></TD>
				<%
					vFamilyUnavailableTotals = vFamilyUnavailableTotals + RS("FamilyUnavailable Other Eye")
					vTotalOtherEye = vTotalOtherEye + RS("FamilyUnavailable Other Eye")
					'RS.MoveNext
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
					'RS.MoveNext
				End If										

				'FamilyUnavailable Other
				If ReferralTypeList(2,2)= 1 Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=4_AND_(FSCaseBillFamUnavailUserID_IS_NOT_NULL_AND_FSCaseBillFamUnavailUserID_<>_0)_AND_ReferralOrganAppropriateID_<>1_AND_ReferralEyesTransAppropriateID_<>1_AND_ReferralBoneAppropriateID_<>_1_AND_ReferralTissueAppropriateID_<>_1_AND_ReferralSkinAppropriateID_<>_1_AND_ReferralValvesAppropriateID_<>_1_AND_ReferralEyesRschAppropriateID=1_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<%=RS("FamilyUnavailable Other")%>
						</A>
					</FONT></TD>
				<%
					vFamilyUnavailableTotals = vFamilyUnavailableTotals + RS("FamilyUnavailable Other")
					vTotalOther = vTotalOther + RS("FamilyUnavailable Other")
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
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><%=RS("Total FamilyUnavailable RO")%></FONT></TD>
				<%
					vFamilyUnavailableTotals = vFamilyUnavailableTotals + RS("Total FamilyUnavailable RO")
					vTotalRO = vTotalRO + RS("Total FamilyUnavailable RO")
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
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><i>
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=4_AND_(FSCaseBillFamUnavailUserID_IS_NOT_NULL_AND_FSCaseBillFamUnavailUserID_<>_0)_AND_ReferralBoneAppropriateID_<>_4_AND_ReferralBoneAppropriateID_<>_3_AND_ReferralTissueAppropriateID_<>_4_AND_ReferralTissueAppropriateID_<>_3_AND_ReferralSkinAppropriateID_<>_4_AND_ReferralSkinAppropriateID_<>_3_AND_ReferralValvesAppropriateID_<>_4_AND_ReferralValvesAppropriateID_<>_3_AND_ReferralEyesTransAppropriateID_<>_4_AND_ReferralEyesTransAppropriateID_<>_3_AND_ReferralEyesRschAppropriateID_<>_1_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<%=RS("FamilyUnavailable Age RO")%>
						</A>
					</i></FONT></TD>
				<%		
					vTotalROA = vTotalROA + RS("FamilyUnavailable Age RO")	
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
				End If	

				'ROM Count					

				If (ReferralTypeList(2,3)= 1) Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><i>
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=4_AND_(FSCaseBillFamUnavailUserID_IS_NOT_NULL_AND_FSCaseBillFamUnavailUserID_<>_0)_AND_(ReferralBoneAppropriateID=4_OR_ReferralBoneAppropriateID=3_OR_ReferralTissueAppropriateID=4_OR_ReferralTissueAppropriateID=3_OR_ReferralSkinAppropriateID=4_OR_ReferralSkinAppropriateID=3_OR_ReferralValvesAppropriateID=4_OR_ReferralValvesAppropriateID=3_OR_ReferralEyesTransAppropriateID=4_OR_ReferralEyesTransAppropriateID=3)_AND_ReferralEyesRschAppropriateID_<>_1_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<%=RS("FamilyUnavailable Med RO")%>
						</A>
					</i></FONT></TD>
				<%		
					vTotalROM = vTotalROM + RS("FamilyUnavailable Med RO")	
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
				End If	

				'FamilyUnavailable Totals	vFamilyUnavailableTotals RS("FamilyUnavailable Totals")
				%>

					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><B><%=vFamilyUnavailableTotals%></B></FONT></TD>
			</TR>
			

<!-- FamilyApproach -->
			<TR> 
				<TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeData%>">Family Approach<br><i># Referrals:<br># Billable:</i></FONT></TD>
				
			<%				
			vFamilyApproachTotals = 0
			vFamilyApproachTotalsCount = 0	'1/20/03 drh
						
				'OTE Count

				If ReferralTypeList(2,0)= 1 Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1	&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=1_AND_(FSCaseBillApproachUserID_IS_NOT_NULL_AND_FSCaseBillApproachUserID_<>_0)_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<br><%=RS("FamilyApproach OTE")%><br><%=RS("FamilyApproach OTE Count")%>
						</A>
					</FONT></TD>
				<%
					vFamilyApproachTotals = vFamilyApproachTotals + RS("FamilyApproach OTE")
					vFamilyApproachTotalsCount = vFamilyApproachTotalsCount + RS("FamilyApproach OTE Count")	'1/20/03 drh
					vTotalOTE = vTotalOTE + RS("FamilyApproach OTE")
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
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=2_AND_(FSCaseBillApproachUserID_IS_NOT_NULL_AND_FSCaseBillApproachUserID_<>_0)_AND_ReferralOrganAppropriateID_<>1_AND_ReferralEyesTransAppropriateID_<>1_AND_(_ReferralBoneAppropriateID=1_OR_ReferralTissueAppropriateID=1_OR_ReferralSkinAppropriateID=1_OR_ReferralValvesAppropriateID=1)_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<br><%=RS("FamilyApproach Tissue")%><br><%=RS("FamilyApproach Tissue Count")%>
						</A>
					</FONT></TD>
				<%
					vFamilyApproachTotals = vFamilyApproachTotals + RS("FamilyApproach Tissue")
					vFamilyApproachTotalsCount = vFamilyApproachTotalsCount + RS("FamilyApproach Tissue Count")	'1/20/03 drh
					vTotalTissue = vTotalTissue + RS("FamilyApproach Tissue")
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
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=2_AND_(FSCaseBillApproachUserID_IS_NOT_NULL_AND_FSCaseBillApproachUserID_<>_0)_AND_ReferralOrganAppropriateID_<>1_AND_ReferralEyesTransAppropriateID_=1_AND_(_ReferralBoneAppropriateID=1_OR_ReferralTissueAppropriateID=1_OR_ReferralSkinAppropriateID=1_OR_ReferralValvesAppropriateID=1)_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<br><%=RS("FamilyApproach T/E")%><br><%=RS("FamilyApproach T/E Count")%>
						</A>
					</FONT></TD>
				<%
					vFamilyApproachTotals = vFamilyApproachTotals + RS("FamilyApproach T/E")
					vTotalTE = vTotalTE + RS("FamilyApproach T/E")
					vFamilyApproachTotalsCount = vFamilyApproachTotalsCount + RS("FamilyApproach T/E Count")	'1/20/03 drh
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
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=3_AND_(FSCaseBillApproachUserID_IS_NOT_NULL_AND_FSCaseBillApproachUserID_<>_0)_AND_ReferralOrganAppropriateID_<>1_AND_ReferralEyesTransAppropriateID_=1_AND_ReferralBoneAppropriateID_<>_1_AND_ReferralTissueAppropriateID_<>_1_AND_ReferralSkinAppropriateID_<>_1_AND_ReferralValvesAppropriateID_<>_1_AND_ReferralEyesRschAppropriateID_<>_1_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<br><%=RS("FamilyApproach Eye")%><br><%=RS("FamilyApproach Eye Count")%>
						</A>
					</FONT></TD>
				<%
					vFamilyApproachTotals = vFamilyApproachTotals + RS("FamilyApproach Eye")
					vFamilyApproachTotalsCount = vFamilyApproachTotalsCount + RS("FamilyApproach Eye Count")	'1/20/03 drh
					vTotalE = vTotalE + RS("FamilyApproach Eye")
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
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_(Referral.ReferralTypeID=4_OR_Referral.ReferralTypeID=3)_AND_(FSCaseBillApproachUserID_IS_NOT_NULL_AND_FSCaseBillApproachUserID_<>_0)_AND_ReferralOrganAppropriateID_<>1_AND_ReferralEyesTransAppropriateID=1_AND_ReferralBoneAppropriateID_<>_1_AND_ReferralTissueAppropriateID_<>_1_AND_ReferralSkinAppropriateID_<>_1_AND_ReferralValvesAppropriateID_<>_1_AND_ReferralEyesRschAppropriateID=1_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<br><%=RS("FamilyApproach Other Eye")%><br><%=RS("FamilyApproach Other Eye Count")%>
						</A>					
					</FONT></TD>
				<%
					vFamilyApproachTotals = vFamilyApproachTotals + RS("FamilyApproach Other Eye")
					vFamilyApproachTotalsCount = vFamilyApproachTotalsCount + RS("FamilyApproach Other Eye Count")	'1/20/03 drh
					vTotalOtherEye = vTotalOtherEye + RS("FamilyApproach Other Eye")
					'RS.MoveNext
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
					'RS.MoveNext
				End If										

				'FamilyApproach Other
				If ReferralTypeList(2,2)= 1 Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=4_AND_(FSCaseBillApproachUserID_IS_NOT_NULL_AND_FSCaseBillApproachUserID_<>_0)_AND_ReferralOrganAppropriateID_<>1_AND_ReferralEyesTransAppropriateID_<>1_AND_ReferralBoneAppropriateID_<>_1_AND_ReferralTissueAppropriateID_<>_1_AND_ReferralSkinAppropriateID_<>_1_AND_ReferralValvesAppropriateID_<>_1_AND_ReferralEyesRschAppropriateID=1_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<br><%=RS("FamilyApproach Other")%><br><%=RS("FamilyApproach Other Count")%>
			
						</A>
					</FONT></TD>
				<%
					vFamilyApproachTotals = vFamilyApproachTotals + RS("FamilyApproach Other")
					vFamilyApproachTotalsCount = vFamilyApproachTotalsCount + RS("FamilyApproach Other Count")	'1/20/03 drh
					vTotalOther = vTotalOther + RS("FamilyApproach Other")
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
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><br><%=RS("Total FamilyApproach RO")%><br><%=RS("Total FamilyApproach RO Count")%></FONT></TD>
				<%
					vFamilyApproachTotals = vFamilyApproachTotals + RS("Total FamilyApproach RO")
					vFamilyApproachTotalsCount = vFamilyApproachTotalsCount + RS("Total FamilyApproach RO Count")	'1/20/03 drh
					vTotalRO = vTotalRO + RS("Total FamilyApproach RO")
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
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><i>
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=4_AND_(FSCaseBillApproachUserID_IS_NOT_NULL_AND_FSCaseBillApproachUserID_<>_0)_AND_ReferralBoneAppropriateID_<>_4_AND_ReferralBoneAppropriateID_<>_3_AND_ReferralTissueAppropriateID_<>_4_AND_ReferralTissueAppropriateID_<>_3_AND_ReferralSkinAppropriateID_<>_4_AND_ReferralSkinAppropriateID_<>_3_AND_ReferralValvesAppropriateID_<>_4_AND_ReferralValvesAppropriateID_<>_3_AND_ReferralEyesTransAppropriateID_<>_4_AND_ReferralEyesTransAppropriateID_<>_3_AND_ReferralEyesRschAppropriateID_<>_1_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<br><%=RS("FamilyApproach Age RO")%><br><%=RS("FamilyApproach Age RO Count")%>
						</A>
					</i></FONT></TD>
				<%		
					vTotalROA = vTotalROA + RS("FamilyApproach Age RO")	
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
				End If	

				'ROM Count					

				If (ReferralTypeList(2,3)= 1) Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><i>
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=4_AND_(FSCaseBillApproachUserID_IS_NOT_NULL_AND_FSCaseBillApproachUserID_<>_0)_AND_(ReferralBoneAppropriateID=4_OR_ReferralBoneAppropriateID=3_OR_ReferralTissueAppropriateID=4_OR_ReferralTissueAppropriateID=3_OR_ReferralSkinAppropriateID=4_OR_ReferralSkinAppropriateID=3_OR_ReferralValvesAppropriateID=4_OR_ReferralValvesAppropriateID=3_OR_ReferralEyesTransAppropriateID=4_OR_ReferralEyesTransAppropriateID=3)_AND_ReferralEyesRschAppropriateID_<>_1_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<br><%=RS("FamilyApproach Med RO")%><br><%=RS("FamilyApproach Med RO Count")%>
						</A>
					</i></FONT></TD>
				<%		
					vTotalROM = vTotalROM + RS("FamilyApproach Med RO")	
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
				End If	

				'FamilyApproach Totals	vFamilyApproachTotals RS("FamilyApproach Totals")
				%>

					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><br><B><%=vFamilyApproachTotals%><br><%=vFamilyApproachTotalsCount%></B></FONT></TD>
			</TR>


<!-- MedSoc -->
			<TR> 
					<TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeData%>">MedSoc<i><br># Referrals:<br># Billable:</i></FONT></TD>

				<%				
				vTotalMedSoc = 0
				vMedSocTotalsCount = 0	'1/20/03 drh


				'OTE Count
				If ReferralTypeList(2,0)= 1 Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=1_AND_(FSCaseBillMedSocUserID_IS_NOT_NULL_AND_FSCaseBillMedSocUserID_<>_0)_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<br><%=RS("MedSoc OTE")%><br><%=RS("MedSoc OTE Count")%>
						</A>	
					</FONT></TD>
				<%
					vTotalMedSoc = vTotalMedSoc + RS("MedSoc OTE")
					vMedSocTotalsCount = vMedSocTotalsCount + RS("MedSoc OTE Count")	'drh 1/20/03
					vTotalOTE = vTotalOTE + RS("MedSoc OTE")
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
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=2_AND_(FSCaseBillMedSocUserID_IS_NOT_NULL_AND_FSCaseBillMedSocUserID_<>_0)_AND_ReferralOrganAppropriateID_<>1_AND_ReferralEyesTransAppropriateID_<>1_AND_(_ReferralBoneAppropriateID=1_OR_ReferralTissueAppropriateID=1_OR_ReferralSkinAppropriateID=1_OR_ReferralValvesAppropriateID=1)_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<br><%=RS("MedSoc Tissue")%><br><%=RS("MedSoc Tissue Count")%>
						</A>
					</FONT></TD>
				<%
					vTotalMedSoc = vTotalMedSoc + RS("MedSoc Tissue")
					vMedSocTotalsCount = vMedSocTotalsCount + RS("MedSoc Tissue Count")	'drh 1/20/03
					vTotalTissue = vTotalTissue + RS("MedSoc Tissue")
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
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=2_AND_(FSCaseBillMedSocUserID_IS_NOT_NULL_AND_FSCaseBillMedSocUserID_<>_0)_AND_ReferralOrganAppropriateID_<>1_AND_ReferralEyesTransAppropriateID_=1_AND_(_ReferralBoneAppropriateID=1_OR_ReferralTissueAppropriateID=1_OR_ReferralSkinAppropriateID=1_OR_ReferralValvesAppropriateID=1)_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<br><%=RS("MedSoc TE")%><br><%=RS("MedSoc TE Count")%>
						</A>
					</FONT></TD>
				<%
					vTotalMedSoc = vTotalMedSoc + RS("MedSoc TE")
					vMedSocTotalsCount = vMedSocTotalsCount + RS("MedSoc TE Count")	'drh 1/20/03
					vTotalTE = vTotalTE + RS("MedSoc TE")
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
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=3_AND_(FSCaseBillMedSocUserID_IS_NOT_NULL_AND_FSCaseBillMedSocUserID_<>_0)_AND_ReferralOrganAppropriateID_<>1_AND_ReferralEyesTransAppropriateID_=1_AND_ReferralBoneAppropriateID_<>_1_AND_ReferralTissueAppropriateID_<>_1_AND_ReferralSkinAppropriateID_<>_1_AND_ReferralValvesAppropriateID_<>_1_AND_ReferralEyesRschAppropriateID_<>_1_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<br><%=RS("MedSoc Eye")%><br><%=RS("MedSoc Eye Count")%>
						</A>
						</FONT></TD>
				<%
					vTotalMedSoc = vTotalMedSoc + RS("MedSoc Eye")
					vMedSocTotalsCount = vMedSocTotalsCount + RS("MedSoc Eye Count")	'drh 1/20/03
					vTotalE = vTotalE + RS("MedSoc Eye")
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
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_(Referral.ReferralTypeID=4_OR_Referral.ReferralTypeID=3)_AND_(FSCaseBillMedSocUserID_IS_NOT_NULL_AND_FSCaseBillMedSocUserID_<>_0)_AND_ReferralOrganAppropriateID_<>1_AND_ReferralEyesTransAppropriateID_=1_AND_ReferralBoneAppropriateID_<>_1_AND_ReferralTissueAppropriateID_<>_1_AND_ReferralSkinAppropriateID_<>_1_AND_ReferralValvesAppropriateID_<>_1_AND_ReferralEyesRschAppropriateID=1_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<br><%=RS("MedSoc Other Eye")%><br><%=RS("MedSoc Other Eye Count")%>
						</A>
						</FONT></TD>
				<%
					vTotalMedSoc = vTotalMedSoc + RS("MedSoc Other Eye")
					vMedSocTotalsCount = vMedSocTotalsCount + RS("MedSoc Other Eye Count")	'drh 1/20/03
					vTotalOtherEye = vTotalOtherEye + RS("MedSoc Other Eye")
					'RS.MoveNext
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
					'RS.MoveNext
				End If									

				'MedSoc Other
				If ReferralTypeList(2,3)= 1 Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=4_AND_(FSCaseBillMedSocUserID_IS_NOT_NULL_AND_FSCaseBillMedSocUserID_<>_0)_AND_ReferralOrganAppropriateID_<>1_AND_ReferralEyesTransAppropriateID_<>1_AND_ReferralBoneAppropriateID_<>_1_AND_ReferralTissueAppropriateID_<>_1_AND_ReferralSkinAppropriateID_<>_1_AND_ReferralValvesAppropriateID_<>_1_AND_ReferralEyesRschAppropriateID=1_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">					
						<br><%=RS("MedSoc Other")%><br><%=RS("MedSoc Other Count")%>
						</A>					
					</FONT></TD>
				<%
					vTotalMedSoc = vTotalMedSoc + RS("MedSoc Other")
					vMedSocTotalsCount = vMedSocTotalsCount + RS("MedSoc Other Count")	'drh 1/20/03
					vTotalOther = vTotalOther + RS("MedSoc Other")
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
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><br><%=RS("MedSoc Total RO")%><br><%=RS("MedSoc Total RO Count")%></FONT></TD>
				<%
					vTotalMedSoc = vTotalMedSoc + RS("MedSoc Total RO")
					vMedSocTotalsCount = vMedSocTotalsCount + RS("MedSoc Total RO Count")	'drh 1/20/03
					vTotalRO = vTotalRO + RS("MedSoc Total RO")
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
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><i>
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=4_AND_(FSCaseBillMedSocUserID_IS_NOT_NULL_AND_FSCaseBillMedSocUserID_<>_0)_AND_ReferralBoneAppropriateID_<>_4_AND_ReferralBoneAppropriateID_<>_3_AND_ReferralTissueAppropriateID_<>_4_AND_ReferralTissueAppropriateID_<>_3_AND_ReferralSkinAppropriateID_<>_4_AND_ReferralSkinAppropriateID_<>_3_AND_ReferralValvesAppropriateID_<>_4_AND_ReferralValvesAppropriateID_<>_3_AND_ReferralEyesTransAppropriateID_<>_4_AND_ReferralEyesTransAppropriateID_<>_3_AND_ReferralEyesRschAppropriateID_<>_1_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<br><%=RS("MedSoc Age RO")%><br><%=RS("MedSoc Age RO Count")%>
						</A>
						</i></FONT></TD>
				<%		
					vTotalROA = vTotalROA + RS("MedSoc Age RO")	
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
				End If	

				'ROM Count					

				If (ReferralTypeList(2,3)= 1) Then
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><i>
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=4_AND_(FSCaseBillMedSocUserID_IS_NOT_NULL_AND_FSCaseBillMedSocUserID_<>_0)_AND_(ReferralBoneAppropriateID=4_OR_ReferralBoneAppropriateID=3_OR_ReferralTissueAppropriateID=4_OR_ReferralTissueAppropriateID=3_OR_ReferralSkinAppropriateID=4_OR_ReferralSkinAppropriateID=3_OR_ReferralValvesAppropriateID=4_OR_ReferralValvesAppropriateID=3_OR_ReferralEyesTransAppropriateID=4_OR_ReferralEyesTransAppropriateID=3)_AND_ReferralEyesRschAppropriateID_<>_1_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<br><%=RS("MedSoc Med RO")%><br><%=RS("MedSoc Med RO Count")%>
						</A>
					</i></FONT></TD>
				<%		
					vTotalROM = vTotalROM + RS("MedSoc Med RO")	
				Else
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
				<%
				End If	

				'TotalNotApproached vTotalMedSoc RS("TotalMedSoc")
				%>
					<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><B><br><%=vTotalMedSoc%><br><%=vMedSocTotalsCount%></B></FONT></TD>
			</TR>
			
			
<!-- 1/20/03 drh - CryolifeForm -->

			<TR> 
							<TD ALIGN=RIGHT><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeData%>">Cryolife Form<i><br># Referrals:<br># Billable:</i></FONT></TD>
							
						<%				
						vCryolifeFormTotals = 0
						vCryolifeFormTotalsCount = 0		'1/20/03 drh
									
							'OTE Count
			
							If ReferralTypeList(2,0)= 1 Then
							%>
								<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
									<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1	&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=1_AND_(FSCaseBillCryoFormUserID_IS_NOT_NULL_AND_FSCaseBillCryoFormUserID_<>_0)_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
									<br><%=RS("CryolifeForm OTE")%><br><%=RS("CryolifeForm OTE Count")%>
									</A>
								</FONT></TD>
							<%
								vCryolifeFormTotals = vCryolifeFormTotals + RS("CryolifeForm OTE")
								vCryolifeFormTotalsCount = vCryolifeFormTotalsCount + RS("CryolifeForm OTE Count")	'1/20/03 drh
								vTotalOTE = vTotalOTE + RS("CryolifeForm OTE")
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
								<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
									<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=2_AND_(FSCaseBillCryoFormUserID_IS_NOT_NULL_AND_FSCaseBillCryoFormUserID_<>_0)_AND_ReferralOrganAppropriateID_<>1_AND_ReferralEyesTransAppropriateID_<>1_AND_(_ReferralBoneAppropriateID=1_OR_ReferralTissueAppropriateID=1_OR_ReferralSkinAppropriateID=1_OR_ReferralValvesAppropriateID=1)_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
									<br><%=RS("CryolifeForm Tissue")%><br><%=RS("CryolifeForm Tissue Count")%>
									</A>
								</FONT></TD>
							<%
								vCryolifeFormTotals = vCryolifeFormTotals + RS("CryolifeForm Tissue")
								vCryolifeFormTotalsCount = vCryolifeFormTotalsCount + RS("CryolifeForm Tissue Count")	'1/20/03 drh
								vTotalTissue = vTotalTissue + RS("CryolifeForm Tissue")
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
								<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
									<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=2_AND_(FSCaseBillCryoFormUserID_IS_NOT_NULL_AND_FSCaseBillCryoFormUserID_<>_0)_AND_ReferralOrganAppropriateID_<>1_AND_ReferralEyesTransAppropriateID_=1_AND_(_ReferralBoneAppropriateID=1_OR_ReferralTissueAppropriateID=1_OR_ReferralSkinAppropriateID=1_OR_ReferralValvesAppropriateID=1)_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
									<br><%=RS("CryolifeForm T/E")%><br><%=RS("CryolifeForm T/E Count")%>
									</A>
								</FONT></TD>
							<%
								vCryolifeFormTotals = vCryolifeFormTotals + RS("CryolifeForm T/E")
								vCryolifeFormTotalsCount = vCryolifeFormTotalsCount + RS("CryolifeForm T/E Count")	'1/20/03 drh
								vTotalTE = vTotalTE + RS("CryolifeForm T/E")
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
								<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
									<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=3_AND_(FSCaseBillCryoFormUserID_IS_NOT_NULL_AND_FSCaseBillCryoFormUserID_<>_0)_AND_ReferralOrganAppropriateID_<>1_AND_ReferralEyesTransAppropriateID_=1_AND_ReferralBoneAppropriateID_<>_1_AND_ReferralTissueAppropriateID_<>_1_AND_ReferralSkinAppropriateID_<>_1_AND_ReferralValvesAppropriateID_<>_1_AND_ReferralEyesRschAppropriateID_<>_1_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
									<br><%=RS("CryolifeForm Eye")%><br><%=RS("CryolifeForm Eye Count")%>
									</A>
								</FONT></TD>
							<%
								vCryolifeFormTotals = vCryolifeFormTotals + RS("CryolifeForm Eye")
								vCryolifeFormTotalsCount = vCryolifeFormTotalsCount + RS("CryolifeForm Eye Count")	'1/20/03 drh
								vTotalE = vTotalE + RS("CryolifeForm Eye")
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
								<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
									<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_(Referral.ReferralTypeID=4_OR_Referral.ReferralTypeID=3)_AND_(FSCaseBillCryoFormUserID_IS_NOT_NULL_AND_FSCaseBillCryoFormUserID_<>_0)_AND_ReferralOrganAppropriateID_<>1_AND_ReferralEyesTransAppropriateID=1_AND_ReferralBoneAppropriateID_<>_1_AND_ReferralTissueAppropriateID_<>_1_AND_ReferralSkinAppropriateID_<>_1_AND_ReferralValvesAppropriateID_<>_1_AND_ReferralEyesRschAppropriateID=1_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
									<br><%=RS("CryolifeForm Other Eye")%><br><%=RS("CryolifeForm Other Eye Count")%>
									</A>					
								</FONT></TD>
							<%
								vCryolifeFormTotals = vCryolifeFormTotals + RS("CryolifeForm Other Eye")
								vCryolifeFormTotalsCount = vCryolifeFormTotalsCount + RS("CryolifeForm Other Eye Count")	'1/20/03 drh
								vTotalOtherEye = vTotalOtherEye + RS("CryolifeForm Other Eye")
								'RS.MoveNext
							Else
							%>
								<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
							<%
								'RS.MoveNext
							End If										
			
							'CryolifeForm Other
							If ReferralTypeList(2,2)= 1 Then
							%>
								<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">
									<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=4_AND_(FSCaseBillCryoFormUserID_IS_NOT_NULL_AND_FSCaseBillCryoFormUserID_<>_0)_AND_ReferralOrganAppropriateID_<>1_AND_ReferralEyesTransAppropriateID_<>1_AND_ReferralBoneAppropriateID_<>_1_AND_ReferralTissueAppropriateID_<>_1_AND_ReferralSkinAppropriateID_<>_1_AND_ReferralValvesAppropriateID_<>_1_AND_ReferralEyesRschAppropriateID=1_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
									<br><%=RS("CryolifeForm Other")%><br><%=RS("CryolifeForm Other Count")%>
									</A>
								</FONT></TD>
							<%
								vCryolifeFormTotals = vCryolifeFormTotals + RS("CryolifeForm Other")
								vCryolifeFormTotalsCount = vCryolifeFormTotalsCount + RS("CryolifeForm Other Count")	'1/20/03 drh
								vTotalOther = vTotalOther + RS("CryolifeForm Other")
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
								<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><br><%=RS("Total CryolifeForm RO")%><br><%=RS("Total CryolifeForm RO Count")%></FONT></TD>
							<%
								vCryolifeFormTotals = vCryolifeFormTotals + RS("Total CryolifeForm RO")
								vCryolifeFormTotalsCount = vCryolifeFormTotalsCount + RS("Total CryolifeForm RO Count")	'1/20/03 drh
								vTotalRO = vTotalRO + RS("Total CryolifeForm RO")
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
								<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><i>
									<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=4_AND_(FSCaseBillCryoFormUserID_IS_NOT_NULL_AND_FSCaseBillCryoFormUserID_<>_0)_AND_ReferralBoneAppropriateID_<>_4_AND_ReferralBoneAppropriateID_<>_3_AND_ReferralTissueAppropriateID_<>_4_AND_ReferralTissueAppropriateID_<>_3_AND_ReferralSkinAppropriateID_<>_4_AND_ReferralSkinAppropriateID_<>_3_AND_ReferralValvesAppropriateID_<>_4_AND_ReferralValvesAppropriateID_<>_3_AND_ReferralEyesTransAppropriateID_<>_4_AND_ReferralEyesTransAppropriateID_<>_3_AND_ReferralEyesRschAppropriateID_<>_1_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
									<br><%=RS("CryolifeForm Age RO")%><br><%=RS("CryolifeForm Age RO Count")%>
									</A>
								</i></FONT></TD>
							<%		
								vTotalROA = vTotalROA + RS("CryolifeForm Age RO")	
							Else
							%>
								<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
							<%
							End If	
			
							'ROM Count					
			
							If (ReferralTypeList(2,3)= 1) Then
							%>
								<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><i>
									<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & vReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_&AND=_AND_Referral.ReferralTypeID=4_AND_(FSCaseBillCryoFormUserID_IS_NOT_NULL_AND_FSCaseBillCryoFormUserID_<>_0)_AND_(ReferralBoneAppropriateID=4_OR_ReferralBoneAppropriateID=3_OR_ReferralTissueAppropriateID=4_OR_ReferralTissueAppropriateID=3_OR_ReferralSkinAppropriateID=4_OR_ReferralSkinAppropriateID=3_OR_ReferralValvesAppropriateID=4_OR_ReferralValvesAppropriateID=3_OR_ReferralEyesTransAppropriateID=4_OR_ReferralEyesTransAppropriateID=3)_AND_ReferralEyesRschAppropriateID_<>_1_AND_Call.SourceCodeID="& vSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
									<br><%=RS("CryolifeForm Med RO")%><br><%=RS("CryolifeForm Med RO Count")%>
									</A>
								</i></FONT></TD>
							<%		
								vTotalROM = vTotalROM + RS("CryolifeForm Med RO")	
							Else
							%>
								<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>">0</FONT></TD>
							<%
							End If	
			
							'CryolifeForm Totals	vCryolifeFormTotals RS("CryolifeForm Totals")
							%>
			
								<TD ALIGN=RIGHT><FONT FACE="Arial" SIZE="<%=FontSizeData%>"><B><br><%=vCryolifeFormTotals%><br><%=vCryolifeFormTotalsCount%></B></FONT></TD>
			</TR>

		<TR>					<TD ALIGN=Right><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeData%>">OTE Screening</FONT></TD>
							<TD ALIGN=Right><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeData%>"><%=RS("FSCaseBillOTE")%></FONT></TD>
							<TD></TD>
							<TD></TD>
							<TD></TD>
							<TD></TD>
							<TD></TD>
							<TD></TD>
							<TD></TD>
							<TD></TD>
							<TD></TD>
			</TR>
						
				
						
<!-- Totals -->
			

		</TABLE>
<%

		RS0.MoveNext
		'ccarroll 08/28/2006 - added response flush to elimiate errors
		'ref Helpdesk 4458
		response.flush
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