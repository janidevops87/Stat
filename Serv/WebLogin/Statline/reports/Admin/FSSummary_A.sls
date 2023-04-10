
<% 
Option Explicit

'Dim DataWarehouseConn
Dim pvStartDate
Dim pvEndDate
Dim pvUserOrg
Dim pvOrgID
Dim pvReportGroupID
Dim vReportTitle
Dim vTZ
Dim vErrorMsg
Dim vAnd
Dim ErrorReturn
Dim vReportName
Dim vCurrentColor
Dim LastOrganizationID
Dim LastMonthYear
Dim CurrentSourceCodeID

Dim vTotals(10)
Dim vOrgTotals(10)
Dim vUnapproached(8)
Dim vUnapproachedTotals(6)
Dim x
Dim i

Dim vColFieldName(10)
Dim FontNameHead
Dim FontNameData
Dim NumberCallPerson
Dim CallPersonArray()
ReDim CallPersonArray(7,0)

vColFieldName(0)=""
vColFieldName(1)=""
vColFieldName(2)=""
vColFieldName(3)="SecondaryScreening"
vColFieldName(4)="FamilyApproaches"
vColFieldName(5)="FamilyUnavailable"
vColFieldName(6)="TotalApproaches"
vColFieldName(7)="Consent"
vColFieldName(8)="WrittenConsent"
vColFieldName(9)="MedSoc"




NumberCallPerson = 1

FontNameHead = "Arial"
FontNameData = "Times New Roman"
LastOrganizationID = ""



vReportName = "Approach Person Consent Summary"

%>

<html>
<head>
<meta HTTP-EQUIV="Expires" content="0"> 
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<title><%=vReportName%></title>
</head>
<body bgcolor="#F5EBDD" >
<!-- Include any files here  -->

<!--#include virtual="/loginstatline/includes/TimeZoneProcess.vbs"-->

<!--#include virtual="/loginstatline/includes/Authorize.sls"--> 
<%
Call Process

Function Process

'Execute the main page generating routine
If AuthorizeMain Then

	'Set DataWarehouseConn = server.CreateObject("ADODB.Connection")
	'DataWarehouseConn.Open WAREHOUSEDSN, DBUSER, DBPWD
	
	Set Conn = server.CreateObject("ADODB.Connection")
	Conn.Open DataSourceName, DBUSER, DBPWD

	'Get the query variables
	Call FixQueryString(Request.QueryString("StartDate"), pvStartDate)
	Call FixQueryString(Request.QueryString("EndDate"), pvEndDate)
	pvUserOrg = FormatNumber(Request.QueryString("UserOrgID"),0,,0,0)
	pvOrgID = FormatNumber(Request.QueryString("OrgID"),0,,0,0)
	pvReportGroupID = FormatNumber(Request.QueryString("ReportGroupID"),0,,0,0)

	'Verify the requesting organization if it not Statline
	If pvUserOrg <> 194 then
		
		vQuery = "sps_OrganizationName " & pvUserOrg
		Set RS = Conn.Execute(vQuery)
		
		If RS.EOF = True Then
			vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
			vErrorMsg = vErrorMsg & "The organization attempting to run this report does not exist. <BR> <BR>"
			vErrorMsg = vErrorMsg & "If you continue to have difficulty, <BR>"
			vErrorMsg = vErrorMsg & "Please contact Statline at (888) 881-7828 for assistance.</B> <BR> <BR> <BR>"
			vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
			vErrorMsg = vErrorMsg & "Error:     (100, Org.IdentifyOrganization, Activity.sls) <BR> <BR>"
			vErrorMsg = vErrorMsg & "</FONT></FONT>"
			Response.Write(vErrorMsg)		
		End If
		
		Set RS = Nothing
	
	Else
	
		'If the user org = 194 and a report group has been selected,
		'the replace the user org id with the org owner of the 
		'selected report group.
		If pvReportGroupID <> 0 Then
			vQuery = "sps_ReportGroupOrgParentID " & pvReportGroupID & " "
			Set RS = Conn.Execute(vQuery)
			If RS.EOF <> True Then
				pvUserOrg = RS("OrgHierarchyParentID")
				vReportTitle = RS("OrganizationName") & " - "
			End If
			Set RS = Nothing
		End If		

	End If

	vQuery = "sps_OrganizationTimeZone " & pvUserOrg & " "
	
	Set RS = Conn.Execute(vQuery)
	vTZ = RS("OrganizationTimeZone")
	Set RS = Nothing
	
%>

	<!--#include virtual="/loginstatline/reports/admin/FSSummary_AHead.sls"-->

	<!-- Display Table Header -->

	<IMG SRC="/loginstatline/images/redline.jpg" height=2 WIDTH="100%">

	<TABLE BORDER=0 WIDTH="100%" cellPadding="2" cellSpacing="0">

	<TR>
		<!--
		<TD ALIGN=Left width="20%" rowspan=1 valign=middle><FONT SIZE="1" FACE="<%=FontNameHead%>"></TD>
		<TD ALIGN=Left COLSPAN=1 width="10%"><FONT SIZE="1" FACE="<%=FontNameHead%>">&nbsp</TD>
		<TD ALIGN=Left COLSPAN=4 width="10%"><FONT SIZE="1" FACE="<%=FontNameHead%>">Tissues</TD>
		<TD ALIGN=Left COLSPAN=4 width="10%"><FONT SIZE="1" FACE="<%=FontNameHead%>">Eyes</TD>
		<TD ALIGN=Left COLSPAN=1 width="10%"><FONT SIZE="1" FACE="<%=FontNameHead%>"></TD>	
		-->
		
	</TR>	
	<TR valign=middle bordercolor=Red cellPadding="0">
						
		<TD ALIGN=Left COLSPAN=6 width="15%" height=1 rowspan=0><FONT SIZE="1" FACE="<%=FontNameHead%>"><B> Source Code Name</B></TD>
		<!--
		<TD ALIGN=Left COLSPAN=4 width="10%" height=1 rowspan=0>
		<HR ALIGN=Left COLOR="#000000" NOSHADE SIZE=1 WIDTH="90%"></TD>
		<TD ALIGN=Left COLSPAN=4 width="10%" height=1 rowspan=0>
		<HR ALIGN=Left COLOR="#000000" NOSHADE SIZE=1 WIDTH="90%"></TD>
		<TD ALIGN=Left COLSPAN=1 width="15%" height=1 rowspan=0>&nbsp</TD>	
		-->
		
	</TR>	
	<TR>
		
				
		<TD ALIGN=Left  width="30%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>&nbsp &nbsp Statline Employee</B></TD>
		<TD ALIGN=Left COLSPAN=1 width="10%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Secondary Screening</B></TD>


	<!--'tissue -->
		<TD ALIGN=CENTER COLSPAN=1 width="10%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Family Approach</B></TD>
		
		<!--<TD ALIGN=CENTER  COLSPAN=1 width="10%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Family Unavailable</B></TD>
		-->

		<TD ALIGN=CENTER  COLSPAN=1 width="10%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Total Family Approaches</B></TD>

		<TD ALIGN=CENTER  COLSPAN=1 width="10%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Total Consent</B></TD>
		<TD ALIGN=CENTER  COLSPAN=1 width="10%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Written Consent</B></TD>
		<TD ALIGN=CENTER  COLSPAN=1 width="10%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Consent Rate</B></TD>
		<TD ALIGN=CENTER  COLSPAN=1 width="10%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>MedSoc</B></TD>
	<!--' eyes -->
	<!--
		<TD ALIGN=Left COLSPAN=1 width="6%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>A</B></TD>
		<TD ALIGN=Left COLSPAN=1 width="5%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>C </B></TD>
		<TD ALIGN=Left COLSPAN=1 width="9%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><I>%</I></B></TD>
		<TD ALIGN=Left COLSPAN=1 width="9%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><I>Family Unav.</I></B></TD>
		<TD ALIGN=Left COLSPAN=1 width="10%"><FONT SIZE="1" FACE="<%=FontNameHead%>"></TD>	
		-->
		
	</TR>	
		
		
	<TR>
		<TD COLSPAN=11><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%"></TD>
	</TR>

<%
	vCurrentColor = "bgcolor=#FFFFFF"
	
	'Get the list of organizations to be processed
	vQuery = "SPS_FSCSummary1" & " '" & pvStartDate & "', '" & pvEndDate & "'"
	'Print(vQuery)
	Set RS = Conn.Execute(vQuery)
	
	IF RS.EOF Then
		%>
		<TR>
			<TD colspan=6><FONT color=Red>No Records Found</FONT></TD>		
		</TR>
		<%
	ELSE IF true Then	
		Do While Not RS.EOF
		
		'confirm the current row has values > 0. loop until 
		ConfirmCurrentLoop()
	%>

			<!-- Process Subtotals -->
			<%
			 
			
			
			If LastOrganizationID <> RS("SourceCodeName") Then	
				If LastOrganizationID <> "" Then
					CALL SubTotal("")
					
				End If
				CALL ReferralOrganizationHeader()

			End If	
			LastOrganizationID = RS("SourceCodeName")
			CurrentSourceCodeID = RS("SourceCodeID")
			Call AddToTotal
					IF RS("PersonName") <> "Unavailable" Then	
					
			%>
			
					<TR>
			<%					
						Call PersonNameHeader()
												
			%>	
						<!-- Detail -->
						
						<TD ALIGN=CENTER width="10%" <%=vCurrentColor%>>
							<FONT SIZE="1" FACE="<%=FontNameHead%>">
							<A target="ReferralSummary" HREF="../Referral/summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=0&OrgID=0&CallID=-1&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_JOIN_StatEmployee_SE_ON_SE.StatEmployeeID=fsc.FSCaseBillSecondaryUserID_JOIN_Person_P_ON_P.PersonID=SE.PersonID_&AND=_AND_fsc.FSCaseBillSecondaryUserID>0_AND_P.OrganizationID=194_AND_SE.PersonID=" & RS("PersonID") &"_AND_SourceCode.SourceCodeID="& RS("SourceCodeID") &"&OrderBy=CALL.CALLID")%>">
							<%=RS("SecondaryScreening")%>
							</A>
							</FONT></TD>
						
														
						<TD ALIGN=CENTER width="10%" <%=vCurrentColor%>>
							<FONT SIZE="1" FACE="<%=FontNameHead%>">
							<A target="ReferralSummary" HREF="../Referral/summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=0&OrgID=0&CallID=-1&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_JOIN_SecondaryApproach_SA_ON_SA.CallID=Call.CallID_JOIN_Person_AP_ON_AP.PersonID=SA.SecondaryApproachedBy_&AND=_AND_SA.SecondaryApproached=1_AND_AP.OrganizationID=194__AND_AP.PersonID=" & RS("PersonID") &"_AND_SourceCode.SourceCodeID="& RS("SourceCodeID") &"&OrderBy=CALL.CALLID")%>">
							<%=RS("FamilyApproaches")%>
							</A>
							</FONT></TD>
						<!-- <TD ALIGN=CENTER width="10%" <%=vCurrentColor%>>
							<FONT SIZE="1" FACE="<%=FontNameHead%>">
							<A target="ReferralSummary" HREF="../Referral/summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=0&OrgID=0&CallID=-1&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_JOIN_SecondaryApproach_SA_ON_SA.CallID=Call.CallID_JOIN_Person_AP_ON_AP.PersonID=SA.SecondaryApproachedBy_&AND=_AND_SA.SecondaryApproached=2_AND_SA.SecondaryApproachReason=3_AND_AP.OrganizationID=194__AND_AP.PersonID=" & RS("PersonID") &"_AND_SourceCode.SourceCodeID="& RS("SourceCodeID") &"&OrderBy=CALL.CALLID")%>">
							<%=RS("FamilyUnavailable")%>
							</A>
							</FONT></TD>						
						-->
						<TD ALIGN=CENTER width="10%" <%=vCurrentColor%>>
							<FONT SIZE="1" FACE="<%=FontNameHead%>">
							<A target="ReferralSummary" HREF="../Referral/summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=0&OrgID=0&CallID=-1&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_JOIN_SecondaryApproach_SA_ON_SA.CallID=Call.CallID_JOIN_Person_SD_ON_SD.PersonID=SA.SecondaryApproachedBy_&AND=_AND_FSCaseBillApproachUserID>0_AND_SD.PersonID=" & RS("PersonID") &"_AND_SourceCode.SourceCodeID="& RS("SourceCodeID") & "_AND_SD.OrganizationID=194_&OrderBy=CALL.CALLID")%>">
							<%=RS("TotalApproaches")%>
							</A>							
							</FONT></TD>
						
						<TD ALIGN=CENTER width="10%" <%=vCurrentColor%>>
							<FONT SIZE="1" FACE="<%=FontNameHead%>">
							<A target="ReferralSummary" HREF="../Referral/summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=0&OrgID=0&CallID=-1&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_JOIN_SecondaryApproach_SA_ON_SA.CallID=Call.CallID_JOIN_Person_AP_ON_AP.PersonID=SA.SecondaryApproachedBy_&AND=_AND_SA.SecondaryApproached=1_AND_((SA.SecondaryApproachOutcome=1_OR_SA.SecondaryApproachOutcome=2)_OR_SA.SecondaryConsentOutcome=1)_AND_AP.OrganizationID=194__AND_AP.PersonID=" & RS("PersonID") &"_AND_SourceCode.SourceCodeID="& RS("SourceCodeID") &"&OrderBy=CALL.CALLID")%>">
							<%=RS("Consent")%>
							</FONT></TD>
						<TD ALIGN=CENTER width="10%" <%=vCurrentColor%>>
							<FONT SIZE="1" FACE="<%=FontNameHead%>">
							<A target="ReferralSummary" HREF="../Referral/summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=0&OrgID=0&CallID=-1&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_JOIN_SecondaryApproach_SA_ON_SA.CallID=Call.CallID_LEFT_JOIN_Person_AP1_ON_AP1.PersonID=SA.SecondaryConsentBy_LEFT_JOIN_Person_AP2_ON_AP2.PersonID=SA.SecondaryApproachedBy_&AND=_AND_SA.SecondaryConsented=1_AND_(AP1.OrganizationID=194_OR_AP2.OrganizationID=194)__AND_(AP1.PersonID=" & RS("PersonID") &"_OR_AP2.PersonID=" & RS("PersonID") & ")_AND_SourceCode.SourceCodeID="& RS("SourceCodeID") &"&OrderBy=CALL.CALLID")%>">
							<%=RS("WrittenConsent")%>
							</A>
							</FONT></TD>
						<TD ALIGN=CENTER width="10%" <%=vCurrentColor%>>
							<FONT SIZE="1" FACE="<%=FontNameHead%>">
							<%
							  If RS("FamilyApproaches") >0 and RS("Consent") >0 Then  
							  	Response.Write(FormatNumber(RS("Consent")/RS("FamilyApproaches")*100,0) & "%") 
							  ELSE	
							  	Response.Write("0%")
							  End If
							%>
							</FONT></TD>
						<TD ALIGN=CENTER width="10%" <%=vCurrentColor%>>
							<FONT SIZE="1" FACE="<%=FontNameHead%>">																																																						
							<A target="ReferralSummary" HREF="../Referral/summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=0&OrgID=0&CallID=-1&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_JOIN_SecondaryApproach_SA_ON_SA.CallID=Call.CallID_LEFT_JOIN_Person_SCP_ON_SCP.PersonID=SA.SecondaryConsentBy_LEFT_JOIN_Person_SAP_ON_SAP.PersonID=SA.SecondaryConsentBy_&AND=_AND_FSCaseBillMedSocUserID>0_AND_((SA.SecondaryConsentBy>0_AND_SCP.OrganizationID=194)_OR_SAP.OrganizationID=194)__AND_((SA.SecondaryConsentBy>0_AND_SCP.PersonID=" & RS("PersonID") &")_OR_SAP.PersonID=" & RS("PersonID") &")__AND_SourceCode.SourceCodeID="& RS("SourceCodeID") &"&OrderBy=CALL.CALLID")%>">							
							<%=RS("MedSoc")%>
							</A>
							</FONT></TD>
					</TR>
			<%
					If vCurrentColor = "bgcolor=#FFFFFF" Then
						vCurrentColor = "bgcolor=#F5EBDD"
					Else
						vCurrentColor = "bgcolor=#FFFFFF"
					End If
					End If
			RS.MoveNext
			'response.flush
		Loop
		%>
		
		<!-- Process Subtotals -->
		<%
			Call SubTotal(-1)
			
		%>	
		
		<!-- Process Totals -->
		<TR>
			<!--<TD colspan=12><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%"></TD>-->
		</TR>

		<TR>
			
			<TD ALIGN=CENTER ><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Totals</B></TD>
			<TD ALIGN=CENTER ><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>
				<A target="ReferralSummary" HREF="../Referral/summary_A.sls?<%=("StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=0&OrgID=0&CallID=-1&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID__JOIN_StatEmployee_SE_ON_SE.StatEmployeeID=fsc.FSCaseBillSecondaryUserID_JOIN_Person_P_ON_P.PersonID=SE.PersonID_&AND=_AND_fsc.FSCaseBillSecondaryUserID>0_AND_P.OrganizationID=194_&OrderBy=CALL.CALLID")%>">
				<%=vTotals(3)%>
				</A>
			</B></FONT></TD>
			
			<TD ALIGN=CENTER ><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>
				<A target="ReferralSummary" HREF="../Referral/summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=0&OrgID=0&CallID=-1&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_JOIN_SecondaryApproach_SA_ON_SA.CallID=Call.CallID_JOIN_Person_AP_ON_AP.PersonID=SA.SecondaryApproachedBy_&AND=_AND_SA.SecondaryApproached=1_AND_AP.OrganizationID=194_&OrderBy=CALL.CALLID")%>">
				<%=vTotals(4)%>
				</A>
			</B></FONT></TD>	
			<!--
			<TD ALIGN=CENTER ><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>
				<A target="ReferralSummary" HREF="../Referral/summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=0&OrgID=0&CallID=-1&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_JOIN_SecondaryApproach_SA_ON_SA.CallID=Call.CallID_JOIN_Person_AP_ON_AP.PersonID=SA.SecondaryApproachedBy_&AND=_AND_SA.SecondaryApproached=1_AND_SA.SecondaryApproachOutcome=3_AND_AP.OrganizationID=194_&OrderBy=CALL.CALLID")%>">
				<%=vTotals(5)%>
				</A>
			</B></FONT></TD>
			-->
			<TD ALIGN=CENTER ><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>											
				<A target="ReferralSummary" HREF="../Referral/summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=0&OrgID=0&CallID=-1&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_JOIN_SecondaryApproach_SA_ON_SA.CallID=Call.CallID_JOIN_Person_SD_ON_SD.PersonID=SA.SecondaryApproachedBy_&AND=_AND_FSCaseBillApproachUserID>0_AND_SD.OrganizationID=194_&OrderBy=CALL.CALLID")%>">
				<%=vTotals(6)%>
				</A>
			</B></FONT></TD>						
			<TD ALIGN=CENTER ><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>
				<A target="ReferralSummary" HREF="../Referral/summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=0&OrgID=0&CallID=-1&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_JOIN_SecondaryApproach_SA_ON_SA.CallID=Call.CallID_JOIN_Person_AP_ON_AP.PersonID=SA.SecondaryApproachedBy_&AND=_AND_SA.SecondaryApproached=1_AND_((SA.SecondaryApproachOutcome=1_OR_SA.SecondaryApproachOutcome=2)_OR_SA.SecondaryConsentOutcome=1)_AND_AP.OrganizationID=194_&OrderBy=CALL.CALLID")%>">
				<%=vTotals(7)%>
				</A>
			</B></FONT></TD>
			
			<TD ALIGN=CENTER ><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>
				<A target="ReferralSummary" HREF="../Referral/summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=0&OrgID=0&CallID=-1&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_JOIN_SecondaryApproach_SA_ON_SA.CallID=Call.CallID_LEFT_JOIN_Person_AP1_ON_AP1.PersonID=SA.SecondaryConsentBy_LEFT_JOIN_Person_AP2_ON_AP2.PersonID=SA.SecondaryApproachedBy_&AND=_AND_SA.SecondaryConsented=1_AND_(AP1.OrganizationID=194_OR_AP2.OrganizationID=194)_&OrderBy=CALL.CALLID")%>">
				<%=vTotals(8)%>
				</A>
			</B></FONT></TD>
			<TD ALIGN=CENTER ><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>
				<%
				  If vTotals(4) >0 and vTotals(7) >0 Then  
					Response.Write(FormatNumber(vTotals(7)/vTotals(4)*100,0) & "%") 
				  ELSE	
					Response.Write("0%")
				  End If
				%>
			</B></FONT></TD>

			
			
			<TD ALIGN=CENTER ><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>																																																	       																																												
				<A target="ReferralSummary" HREF="../Referral/summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=0&OrgID=0&CallID=-1&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_JOIN_SecondaryApproach_SA_ON_SA.CallID=Call.CallID_LEFT_JOIN_Person_SCP_ON_SCP.PersonID=SA.SecondaryConsentBy_LEFT_JOIN_Person_SAP_ON_SAP.PersonID=SA.SecondaryConsentBy_&AND=_AND_FSCaseBillMedSocUserID>0_AND_((SA.SecondaryConsentBy>0_AND_SCP.OrganizationID=194)_OR_SAP.OrganizationID=194)_&OrderBy=CALL.CALLID")%>">							
				<%=vTotals(9)%>
				</A>
			</B></FONT></TD>
			
			
		</TR>
		
		<!-- Print Person Totals -->
		<%
		Call FamilyUnavailable(-1, vTotals(5), "Family Unavailable Total")
		If CallPersonArray(0,0) <> "" Then
		%>
			<TR>
				<TD <%'=vCurrentColor%> ALIGN=Left colspan=11  ><FONT SIZE="1" FACE="<%=FontNameHead%>">&nbsp</FONT></TD>
			</TR>

			<% 
			For i = 0 To Ubound(CallPersonArray, 2)
				If CallPersonArray(0,i)<> "" Then 
			%>
					<TR>
						<TD <%=vCurrentColor%> ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>">&nbsp &nbsp &nbsp &nbsp 
							<A target="ReferralSummary" HREF="../summary_a.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & pvReportGroupID & "&OrgID=" & CallPersonArray(6,i) & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&AND=_AND_ReferralCallerOrganizationID_=_"& CallPersonArray(6,i) &"_AND_ReferralApproachedByPersonID_=_" & CallPersonArray(7,i) & "_")%>
							<%=vAnd%>"> 
							<%=CallPersonArray(0,i) %></FONT>
						</TD>
						<TD <%=vCurrentColor%> ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=CallPersonArray(1,i)%></FONT></TD>
						<!-- Detail -->
						<TD width="14%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=CallPersonArray(2,i)%></FONT></TD>
						<TD width="14%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=CallPersonArray(3,i)%></FONT></TD>
						<TD width="14%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=CallPersonArray(4,i)%></FONT></TD>
						<TD width="14%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=CallPersonArray(5,i)%></FONT></TD>
					</TR>
			<%		
				End If	
				If vCurrentColor = "bgcolor=#FFFFFF" Then
					vCurrentColor = "bgcolor=#F5EBDD"
				Else
					vCurrentColor = "bgcolor=#FFFFFF"
				End If
			Next 	
			' Print Total Unassigned
			
		End If
			
			%>
		</TABLE>
	<%
	End If
	End If
END IF
Set RS = Nothing
Set Conn = Nothing


End Function
%>
</body>
</html>
<%
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


Private Function SubTotal(PrintLine)
'Set PrintLine to Print a horizontal line after printing the subtotals.

			
				%>

				<TR>
					<TD ALIGN=CENTER ><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Sub Totals</B></TD>
					<TD ALIGN=CENTER ><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>																																																			
						<A target="ReferralSummary" HREF="../Referral/summary_A.sls?<%=("StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=0&OrgID=0&CallID=-1&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID__JOIN_StatEmployee_SE_ON_SE.StatEmployeeID=fsc.FSCaseBillSecondaryUserID_JOIN_Person_P_ON_P.PersonID=SE.PersonID_&AND=_AND_fsc.FSCaseBillSecondaryUserID>0_AND_SourceCode.SourceCodeID="& CurrentSourceCodeID &"_AND_P.OrganizationID=194_&OrderBy=CALL.CALLID")%>">
							<%=vOrgTotals(3)%>
						</A>
					</B></FONT></TD>

					<TD ALIGN=CENTER ><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>
						<A target="ReferralSummary" HREF="../Referral/summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=0&OrgID=0&CallID=-1&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_JOIN_SecondaryApproach_SA_ON_SA.CallID=Call.CallID_JOIN_Person_AP_ON_AP.PersonID=SA.SecondaryApproachedBy_&AND=_AND_SA.SecondaryApproached=1_AND_AP.OrganizationID=194_AND_SourceCode.SourceCodeID="& CurrentSourceCodeID &"&OrderBy=CALL.CALLID")%>">
						<%=vOrgTotals(4)%>
						</A>
					</B></FONT></TD>
					<!--
					<TD ALIGN=CENTER ><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>
						<A target="ReferralSummary" HREF="../Referral/summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=0&OrgID=0&CallID=-1&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_JOIN_SecondaryApproach_SA_ON_SA.CallID=Call.CallID_JOIN_Person_AP_ON_AP.PersonID=SA.SecondaryApproachedBy_&AND=_AND_SA.SecondaryApproached=2_AND_SA.SecondaryApproachReason=3_AND_AP.OrganizationID=194_AND_SourceCode.SourceCodeID="& CurrentSourceCodeID &"&OrderBy=CALL.CALLID")%>">
						<%=vOrgTotals(5)%>
						</A>
					</B></FONT></TD>
					-->
					
					<TD ALIGN=CENTER ><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>
						<A target="ReferralSummary" HREF="../Referral/summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=0&OrgID=0&CallID=-1&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_JOIN_SecondaryApproach_SA_ON_SA.CallID=Call.CallID_JOIN_Person_SD_ON_SD.PersonID=SA.SecondaryApproachedBy_&AND=_AND_FSCaseBillApproachUserID>0_AND_SourceCode.SourceCodeID="& CurrentSourceCodeID &"_AND_SD.OrganizationID=194_&OrderBy=CALL.CALLID")%>">						
						<%=vOrgTotals(6)%>
						</A>
					</B></FONT></TD>			
					
					<TD ALIGN=CENTER ><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>
						<A target="ReferralSummary" HREF="../Referral/summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=0&OrgID=0&CallID=-1&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_JOIN_SecondaryApproach_SA_ON_SA.CallID=Call.CallID_JOIN_Person_AP_ON_AP.PersonID=SA.SecondaryApproachedBy_&AND=_AND_SA.SecondaryApproached=1_AND_((SA.SecondaryApproachOutcome=1_OR_SA.SecondaryApproachOutcome=2)_OR_SA.SecondaryConsentOutcome=1)_AND_AP.OrganizationID=194_AND_SourceCode.SourceCodeID="& CurrentSourceCodeID &"&OrderBy=CALL.CALLID")%>">
						<%=vOrgTotals(7)%>
						</A>
					</B></FONT></TD>
					
					<TD ALIGN=CENTER ><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>
						<A target="ReferralSummary" HREF="../Referral/summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=0&OrgID=0&CallID=-1&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_JOIN_SecondaryApproach_SA_ON_SA.CallID=Call.CallID_LEFT_JOIN_Person_AP1_ON_AP1.PersonID=SA.SecondaryConsentBy_LEFT_JOIN_Person_AP2_ON_AP2.PersonID=SA.SecondaryApproachedBy_&AND=_AND_SA.SecondaryConsented=1_AND_(AP1.OrganizationID=194_OR_AP2.OrganizationID=194)_AND_SourceCode.SourceCodeID="& CurrentSourceCodeID &"&OrderBy=CALL.CALLID")%>">
						<%=vOrgTotals(8)%>
						</A>
					</B></FONT></TD>
					<TD ALIGN=CENTER ><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>
						<%
						  If vOrgTotals(4) >0 and vOrgTotals(7) >0 Then  
							Response.Write(FormatNumber(vOrgTotals(7)/vOrgTotals(4)*100,0) & "%") 
						  ELSE	
							Response.Write("0%")
						  End If
						%>
					</B></FONT></TD>
					<TD ALIGN=CENTER ><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>																																																			       						
						<A target="ReferralSummary" HREF="../Referral/summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=0&OrgID=0&CallID=-1&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_FSCase_fsc_ON_fsc.CallID=Call.CallID_JOIN_SecondaryApproach_SA_ON_SA.CallID=Call.CallID_LEFT_JOIN_Person_SCP_ON_SCP.PersonID=SA.SecondaryConsentBy_LEFT_JOIN_Person_SAP_ON_SAP.PersonID=SA.SecondaryConsentBy_&AND=_AND_FSCaseBillMedSocUserID>0_AND_((SA.SecondaryConsentBy>0_AND_SCP.OrganizationID=194)_OR_SAP.OrganizationID=194)__AND_SourceCode.SourceCodeID="& CurrentSourceCodeID &"&OrderBy=CALL.CALLID")%>">							
						<%=vOrgTotals(9)%>
						</A>
					</B></FONT></TD>
				</TR>	
				<% Call FamilyUnavailable(1, vOrgTotals(5), "Family Unavailable Sub Total")%>
				<TR>
					<TD colspan=12><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%"></TD>
				</TR>

				<%
								
				
				If vCurrentColor = "bgcolor=#FFFFFF" Then
					vCurrentColor = "bgcolor=#F5EBDD"
				Else
					vCurrentColor = "bgcolor=#FFFFFF"
				End	If
			
				%>	
	
<%	
	For i = 0 to UBound(vOrgTotals,1)
			vOrgTotals(i)=0
	Next
	
	LastOrganizationID = ""
	
End Function

Private Function ReferralOrganizationHeader()
	%>
	<TR>
	
		<TD COLSPAN=8 <%=vCurrentColor%> ><FONT SIZE="1" FACE="<%=FontNameData%>"><%=RS("SourceCodeName")%> </TD>
	</TR>
	<%
	If vCurrentColor = "bgcolor=#FFFFFF" Then
		vCurrentColor = "bgcolor=#F5EBDD"
	Else
		vCurrentColor = "bgcolor=#FFFFFF"
	End If

End Function
Private Function ApproachOrganizationHeader()
						
	
		%>
			<TD width=30% <%=vCurrentColor%> ><FONT SIZE="1" FACE="<%=FontNameData%>">&nbsp &nbsp <%=RS("ApproachOrganizationName")%> </TD>
		<%
	
										
End Function

Private Function PersonNameHeader()
						
	If LEN(RS("PersonName"))> 0 Then
		%>
			<TD <%=vCurrentColor%> ><FONT SIZE="1" FACE="<%=FontNameData%>"> &nbsp &nbsp &nbsp &nbsp <%=RS("PersonName")%> </TD>
		<%
	End If
										
End Function

Function AddToTotal
	'vTotals(0) = vTotals(0) + RS("TotalApproached")
	'vOrgTotals(0) = vOrgTotals(0) + RS("TotalApproached")

	'vTotals(1) = vTotals(1) + RS("ConsentOrgan")
	'vOrgTotals(1) = vOrgTotals(1) + RS("ConsentOrgan")				

	'vTotals(2) = vTotals(2) + RS(vColFieldName(2))
	'vOrgTotals(2) = vOrgTotals(2) + RS(vColFieldName(2))
	
	vTotals(3) = vTotals(3) + RS(vColFieldName(3))
	vOrgTotals(3) = vOrgTotals(3) + RS(vColFieldName(3))

	vTotals(4) = vTotals(4) + RS(vColFieldName(4))
	vOrgTotals(4) = vOrgTotals(4) + RS(vColFieldName(4))

	vTotals(5) = vTotals(5) + RS(vColFieldName(5))
	vOrgTotals(5) = vOrgTotals(5) + RS(vColFieldName(5))

	vTotals(6) = vTotals(6) + RS(vColFieldName(6))
	vOrgTotals(6) = vOrgTotals(6) + RS(vColFieldName(6))

	vTotals(7) = vTotals(7) + RS(vColFieldName(7))
	vOrgTotals(7) = vOrgTotals(7) + RS(vColFieldName(7))

	vTotals(8) = vTotals(8) + RS(vColFieldName(8))
	vOrgTotals(8) = vOrgTotals(8) + RS(vColFieldName(8))

	vTotals(9) = vTotals(9) + RS(vColFieldName(9))
	vOrgTotals(9) = vOrgTotals(9) + RS(vColFieldName(9))
	
	
End Function					
Function CalcPercentage(Top, Bottom)

	If Bottom = 0 Then
		CalcPercentage = 0
		Exit Function
	ELSE
		CalcPercentage = FormatNumber(Top/Bottom*100, 0)
	END IF

End Function

Function ConfirmCurrentLoop()

	Dim functionloopcount	
	Do While (	RS(vColFieldName(3)) = 0 AND RS(vColFieldName(4)) = 0 AND RS(vColFieldName(4)) = 0 AND RS(vColFieldName(5)) = 0 AND RS(vColFieldName(6)) = 0 AND RS(vColFieldName(7)) = 0 AND RS(vColFieldName(8)) = 0 AND RS(vColFieldName(9)) = 0 )
	RS.MoveNext			
	Loop
End Function
Private Function FamilyUnavailable(IncludeSource, Total, LineTotal)
'Set PrintLine to Print a horizontal line after printing the subtotals.

			
				%>

				<TR>
					<TD ALIGN=CENTER ><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=LineTotal%></B></TD>
					<TD ALIGN=CENTER ><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>
						
					</B></FONT></TD>

						
					<TD ALIGN=CENTER ><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>
						<% IF IncludeSource = 1 Then %>
							<A target="ReferralSummary" HREF="../Referral/summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=0&OrgID=0&CallID=-1&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_SecondaryApproach_SA_ON_SA.CallID=Call.CallID_&AND=_AND_SA.SecondaryApproached=2_AND_SA.SecondaryApproachReason=3_AND_SourceCode.SourceCodeID="& CurrentSourceCodeID  &"&OrderBy=CALL.CALLID")%>">
						<% Else %>
							<A target="ReferralSummary" HREF="../Referral/summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=0&OrgID=0&CallID=-1&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&JOIN=_JOIN_SecondaryApproach_SA_ON_SA.CallID=Call.CallID_&AND=_AND_SA.SecondaryApproached=2_AND_SA.SecondaryApproachReason=3_&OrderBy=CALL.CALLID")%>">
						<% End If %>
						<%=Total%>
						</A>
					</B></FONT></TD>			
					
					<TD ALIGN=CENTER ><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>
						
					</B></FONT></TD>			

					<TD ALIGN=CENTER ><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>
						
					</B></FONT></TD>
					
					<TD ALIGN=CENTER ><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>
						
					</B></FONT></TD>
					<TD ALIGN=CENTER ><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>
						
					</B></FONT></TD>
				</TR>	
				

				<%
								
				
				If vCurrentColor = "bgcolor=#FFFFFF" Then
					vCurrentColor = "bgcolor=#F5EBDD"
				Else
					vCurrentColor = "bgcolor=#FFFFFF"
				End	If
			
End Function

'End of Function Section
%>