<%Option Explicit%>

<html>

<head>
<meta http-equiv="Expires" content="now">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>UpdateReferral</title>
</head>

<%'drh 11/20/02 - added onUnload event handler%>
<body bgcolor="#F5EBDD" onUnload="cancelReferral();">
 <!-- Include any files here Response.Write("All Times " & ZoneName(vTZ)) -->

<!--#include virtual="/loginstatline/includes/TimeZoneProcess.vbs"-->
<!--#include virtual="/loginstatline/includes/Authorize.sls"-->

<%	
Response.CacheControl = "no-cache" 
Response.AddHeader "Cache-Control", "private" 
Response.AddHeader "Pragma", "no-cache" 
Response.Expires = -1 

Dim FontNameHead
Dim FontSizeHead
Dim FontNameData
Dim FontSizeData

Dim pvStartDate
Dim pvEndDate
Dim vUserID
Dim vUserName
Dim vUserOrgID
Dim vUserOrgName
Dim pvCallID
Dim vReportGroupID
Dim vUpdateApproachInfo

'ccarroll 11/22/2006 added vSourceCode to only display listbox items allowed by referrals SCID
Dim vSourceCodeID

Dim ApproachTypeList
Dim ApproachUserOrgPersonList
Dim ApproachReferralOrgPersonList

Dim AppropriateList
Dim ApproachList
Dim ConsentList
Dim ConversionList

Dim DataViewList
Dim DataUpdateList
Dim DataServiceList

Dim ConsentToUpdate
Dim	RecoveryToUpdate

Dim RS1
Dim vValue
Dim i
Dim vTZ
Dim vErrorMsg
Dim ErrorReturn

'11/13/02 drh
Dim vLogId

'11/18/02 bjk
Dim vReadOnly '1 ReadOnly and 0 Read/Write
Dim vReferralOpenDateTime 'time the referral is opened

'Approach Variables
Const NA = 0		'Not Approached                                       
Const PRE_RC = 1	'Pre-Ref, Coupled                                   
Const PRE_RD = 2	'Pre-Ref, Decoupled                                 
Const POST_RC = 3  'Post Ref, Coupled                                  
Const POST_RD = 4  'Post Ref, Decoupled                                
Const PRE_FI = 5   'Pre-Ref, Family Initiated                          
Const UNKN = 6     'Unknown     
Const REG = 7	   'Registry Approach

'Font Constants
FontNameHead = "Arial"
FontSizeHead = "2"
FontNameData = "Times New Roman"
FontSizeData = "3"

Call FixQueryString(Request.QueryString("StartDate"), pvStartDate)
Call FixQueryString(Request.QueryString("EndDate"), pvEndDate)
vUserID = Request.QueryString("UserID")
vUserOrgID = Request.QueryString("UserOrgID")
vReportGroupID = Request.QueryString("ReportGroupID")
pvCallID = Request.QueryString("CallID")


'Execute the main page generating routine
If AuthorizeMain Then

'Print("Got Past AuthorizeMain ")
'Open Connection
'***Data Archive Change. Replacing DataSourceName = "ProductionTransaction"
'***Check DataSourceName if = Production set = to TRANSACTIONDSN. 
'***If = ProductionArchive set = ArchiveDSN

If DataSourceName = REPORTINGDSN Then
	DataSourceName = TRANSACTIONDSN
ElseIf DataSourceName = ARCHIVEDSN Then	
	DataSourceName = ARCHIVEDSN 
End If

Set Conn = server.CreateObject("ADODB.Connection")
Conn.Open DataSourceName, DBUSER, DBPWD

If vUserOrgID = 194 Then

	'Replace user org id with the owner of the selected report group
	If vReportGroupID <> 0 Then

		'Get number of rows
		vQuery = "SELECT OrgHierarchyParentID AS ParentID FROM WebReportGroup WHERE WebReportGroupID = " & vReportGroupID

		Set RS = Conn.Execute(vQuery)
		vUserOrgID = RS("ParentID")

		Set RS = Nothing
		
	End If

End If

'Get the user's time zone
vQuery = "sps_OrganizationTimeZone " & vUserOrgID
Set RS = Conn.Execute(vQuery)
vTZ = RS("OrganizationTimeZone")
Set RS = Nothing

'Get the user org name
vQuery = "sps_OrganizationName " & vUserOrgID
Set RS = Conn.Execute(vQuery)
vUserOrgName = RS("OrganizationName")
Set RS = Nothing

'Get the user name
vQuery = "sps_WebPerson " & vUserID
Set RS = Conn.Execute(vQuery)
vUserName = RS("PersonFirst") & " " & RS("PersonLast")
Set RS = Nothing
%>


<!-- Pending Referrals Table -->
<form name="UpdateReferralForm"
    action="<%=strHttpHeader & Request.ServerVariables("SERVER_NAME")%>/loginstatline/forms/ProcessReferral.sls"
    method="POST">

<%'List the hidden fields%>   
<input type="hidden" name="DataSourceName" value=<%=DataSourceName%>>

<input type="hidden" name="CallID" value=<%=pvCallID%>>
<input type="hidden" name="UserName" value="<%=vUserName%>">
<input type="hidden" name="UserOrgName" value="<%=vUserOrgName%>">
<input type="hidden" name="UserOrgID" value=<%=Request.QueryString("UserOrgID")%>>
<input type="hidden" name="UserID" value=<%=vUserID%>>
<input type="hidden" name="TZ" value=<%=vTZ%>>
<%'11/13/01 drh - Pass Log Id%>
<input type="hidden" name="LogId" value=<%=vLogId%>>
    

<!-- Get  Data -->

<%
'11/13/02 drh - Save Audit Info
'vQuery = "spu_AuditReferralSave 5, " & pvCallId & ", " & vUserId & ", 0, 1"
'Set RS = Conn.Execute(vQuery)
'Response.Write(vQuery)

'Get data rows
vQuery = "sps_IncompleteReferralDetail1 " & vTZ & ", " & pvCallID
'Print vQuery
'Response.Write(vQuery)
Set RS = Conn.Execute(vQuery)

If RS.EOF = True Then
	'BJK 11/18/2002; Moved header down and added a second header for No Data 
%>
	<!-- Begin Header If No Data-->
	<table  border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td ALIGN=LEFT width="75"><img src="/loginstatline/images/logo1.gif" width="60" height="60"></td>
			<td ALIGN=LEFT width="400" valign="CENTER"><font size="5" face="Arial Black"><b>Update Referral</b></font>
				<br>
				<font size="2" face="<%=FontNameData%>">
				<%	Response.Write("All Times " & ZoneName(vTZ)) %>
				</font>
				</br>
			</td>
			<td>
				&nbsp;
			</td>
			<td>&nbsp;&nbsp;</td>
			<td>
				<A	HREF="javascript:self.close();" NAME="Cancel">
					<IMG src="/loginstatline/images/cancel2.gif"
					NAME="Cancel"
					BORDER="0">
				</A>			
			</td>
		</tr>
	</table>

	<br>
	<img src="/loginstatline/images/redline.gif" height="2" width="100%">
	<!-- End Header If No Data-->

	<p><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><%Response.Write("There is no record for referral    #" & pvCallID & ".    Please check the referral number.")%></b><font></p>

<%
Else

	%>
	<input type=hidden name=OldApproachPersonId value=<%=RS("ReferralApproachedByPersonID")%>>
	<%
	'BJK 11/18/2002; Moved Header Print down below query of sps_IncompleteReferralDetail1
	vReferralOpenDateTime = RS("Now")
	'Response.Write(vReferralOpenDateTime)
%>
	<!-- Begin Header -->
	<table  border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td ALIGN=LEFT width="75"><img src="/loginstatline/images/logo1.gif" width="60" height="60"></td>
			<td ALIGN=LEFT width="400" valign="CENTER"><font size="5" face="Arial Black"><b>Update Referral</b></font>
				<br>
				<font size="2" face="<%=FontNameData%>">
				<%	Response.Write("All Times " & ZoneName(vTZ)) %>
				</font>
				</br>
			</td>
			<td>
				<% 'bjk 11/18/02
				If ( RS("CallOpenByID") = -1 ) Or (RS("CallOpenByWebPersonId") = CInt(vUserId)) Or ( RS("CallOpenByID") = 0 And DateDiff("n",RS("LastModified"),RS("Now")) > 10 )Then
					'Open the Referral ReadWrite
					vReadOnly = 0
				%>
					<%'drh 11/20/02 - Dont close the Referral if we're saving%>
					<A	HREF="javascript:callCancel=0; document.UpdateReferralForm.submit();" NAME="Save">
						<IMG src="/loginstatline/images/submit2.gif"
						NAME="Save"
						BORDER="0">
					</A>		

				<%
				Else
					'Open the Referral ReadOnly
					vReadOnly = 1
				%>
					&nbsp;
				<%
				End IF
				%>
			</td>
			<td>&nbsp;&nbsp;</td>
			<td>
				<A	HREF="javascript:self.close();" NAME="Cancel">
					<IMG src="/loginstatline/images/cancel2.gif"
					NAME="Cancel"
					BORDER="0">
				</A>			
			</td>
		</tr>
		<%
		If vReadOnly = 1 Then		
		%>
		<tr>
			<td colspan=100%>
			<font size="<%=FontSizeHead%>" face="<%=FontNameHead%>">
			<br>
			<B>Note:</B>
			<br>
			This referral is currently open and cannot be modified at this time. 
			<br>
			Please try again later. 
			</font>
			</td>
		</tr>
		<%
		End If
		%>
		
		
	</table>

	<br>
	<img src="/loginstatline/images/redline.gif" height="2" width="100%">
	<!-- End Header -->
<%
	
	'BJK 11/18/02 Set the CallOpenBy if the Call is Read/Write
	If vReadOnly = 0 Then
	vQuery = "EXEC spu_SaveCallOpenBy " & pvCallID & ", 0, " & vUserId & ", 77, 2"
	Set RS1 = Conn.Execute(vQuery)	
	End If
	'Get the view data list for the selected report group
	vQuery = "sps_ReferralDataViewAccess " & vReportGroupID & ", " & pvCallID
	'Response.Write(vQuery)

	Set RS1 = Conn.Execute(vQuery)	
	DataViewList = RS1.GetRows
	
	'Get the update data list for the selected report group
	vQuery = "sps_ReferralDataUpdateAccess " & vReportGroupID & ", " & pvCallID
	'Response.Write(vQuery)
	Set RS1 = Conn.Execute(vQuery)	
	DataUpdateList = RS1.GetRows

	'ccarroll 11/22/2006 added vSourceCodeID to only display listbox items allowed by referrals SCID
	'Get sourceCodeID for referral
	vQuery = "sps_ReferralSourceCodeID " & pvCallID
	
	Set RS1 = Conn.Execute(vQuery)	
		While Not RS1.EOF
		   vSourceCodeID = RS1("SourceCodeID")
			'response.write(vSourceCodeID)
			RS1.MoveNext
		Wend
	
	'Get the service level data list for the selected call
	vQuery = "sps_ReferralDataServiceAccess " & pvCallID
	Set RS1 = Conn.Execute(vQuery)	
	DataServiceList = RS1.GetRows

   
	'Get the Approach data list 
	'(post referral approach types only)
	vQuery = "sps_ListApproachType"
	Set RS1 = Conn.Execute(vQuery)	
	ApproachTypeList = RS1.GetRows
		
	'Get the Appropriate data list
	vQuery = "sps_ListAppropriate " & vSourceCodeID
	Set RS1 = Conn.Execute(vQuery)	
	AppropriateList = RS1.GetRows
	
	'Get the Approach data list
	vQuery = "sps_ListApproach " & vSourceCodeID
	Set RS1 = Conn.Execute(vQuery)	
	ApproachList = RS1.GetRows
		
	'Get the Consent data list
	vQuery = "sps_ListConsent " & vSourceCodeID
	Set RS1 = Conn.Execute(vQuery)	
	ConsentList = RS1.GetRows
	
	'Get the Appropriate data list
	vQuery = "sps_ListRecovery " & vSourceCodeID
	Set RS1 = Conn.Execute(vQuery)	
	ConversionList = RS1.GetRows
	
	Set RS1 = Nothing

%>
	
<input type="hidden" name="CallerOrgID" value=<%=RS("OrganizationID")%>>
<input type="hidden" name="vReadOnly" value=<%=vReadOnly%>>
<input type="hidden" name="vReferralOpenDateTime" value=<%=vReferralOpenDateTime%> >
	
	<!-- Format Data -->
	<BR>
	<table border="0" cellpadding="0" cellspacing="2">	

		<tr>
			<td ALIGN=LEFT VALIGN=CENTER width="80"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Number:</b></font></td>
		    <td ALIGN=LEFT VALIGN=CENTER width="150"><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>">
			  <a target="ReferralDetail" href="/loginstatline/reports/referral/detail_1.sls?CallID=<%=RS("CallID")%>&amp;UserID=<%=Request.QueryString("UserID")%>&amp;UserOrgID=<%=Request.QueryString("UserOrgID")%>&amp;DSN=<%=Request.QueryString("DSN")%>&amp;Options=0&NoLog=1&CountCheck=False"><%=RS("CallNumber")%></a></FONT></td>
		
			<td ALIGN=LEFT VALIGN=CENTER width="80"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Location:</b></font></td>
		    <td ALIGN=LEFT VALIGN=CENTER><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"><%=RS("OrganizationName")%></FONT></td>
		
		</tr>
		
		<tr>
			<td ALIGN=LEFT VALIGN=CENTER><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Date:</b></font></td>
		    <td ALIGN=LEFT VALIGN=CENTER><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"><%=RS("CallDate") & " " & RS("CallTime")%></FONT></td>
		
			<td ALIGN=LEFT VALIGN=CENTER><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Patient:</b></font></td>		
		    <td ALIGN=LEFT VALIGN=CENTER><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"><%=RS("ReferralDonorName")%></FONT></td>
	
		</tr>		
		
	</table>
	</BR>
	
	
	<table border="0" cellpadding="0" cellspacing="2">	

		<%'Format Approach Type field%>
		<%
		If CInt(RS("ReferralApproachTypeID")) = -1 Then
			vValue = CInt(RS("ReferralApproachTypeID"))
		Else
			vValue = CInt(RS("ReferralApproachTypeID")) - 1
		End If
		%>
		<%'drh 11/16/01 Added Registry Type%>
		<%If (vValue >= PRE_RC And vValue < UNKN) or vValue = REG Then%>
			
			<%vUpdateApproachInfo = False%>
			
			<tr>
				<td ALIGN=LEFT VALIGN=CENTER width="80"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Approach:</b></font></td>
				<TD ALIGN=LEFT VALIGN=TOP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>">
					<%'drh 11/16/01 Added Registry Type%>
					<select name="ApproachType" size="1">
						<option value="<%=ApproachTypeList(0,NA)%>"<%If (ApproachTypeList(0,NA)-1)=vValue Then%> selected<%End If%>><%=ApproachTypeList(1,NA)%></option>
						<option value="<%=ApproachTypeList(0,POST_RC)%>"<%If (ApproachTypeList(0,POST_RC)-1)=vValue Then%> selected<%End If%>><%=ApproachTypeList(1,POST_RC)%></option>
						<option value="<%=ApproachTypeList(0,POST_RD)%>"<%If (ApproachTypeList(0,POST_RD)-1)=vValue Then%> selected<%End If%>><%=ApproachTypeList(1,POST_RD)%></option>
						<option value="<%=ApproachTypeList(0,PRE_RC)%>"<%If (ApproachTypeList(0,PRE_RC)-1)=vValue Then%> selected<%End If%>><%=ApproachTypeList(1,PRE_RC)%></option>	
						<option value="<%=ApproachTypeList(0,PRE_RD)%>"<%If (ApproachTypeList(0,PRE_RD)-1)=vValue Then%> selected<%End If%>><%=ApproachTypeList(1,PRE_RD)%></option>	
						<option value="<%=ApproachTypeList(0,PRE_FI)%>"<%If (ApproachTypeList(0,PRE_FI)-1)=vValue Then%> selected<%End If%>><%=ApproachTypeList(1,PRE_FI)%></option>
						<option value="<%=ApproachTypeList(0,REG)%>"<%If (ApproachTypeList(0,REG)-1)=vValue Then%> selected<%End If%>><%=ApproachTypeList(1,REG)%></option>
					</select>			
			</tr>
		
		<%Else%>
		
			<%vUpdateApproachInfo = True%>
			
			<tr>
				<td ALIGN=LEFT VALIGN=CENTER width="80"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Approach:</b></font></td>
				<TD ALIGN=LEFT VALIGN=TOP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>">
					<%'drh 11/16/01 Added Registry Type%>
					<select name="ApproachType" size="1">
						<option value="<%=ApproachTypeList(0,NA)%>" selected ><%=ApproachTypeList(1,NA)%></option>
						<option value="<%=ApproachTypeList(0,POST_RC)%>"><%=ApproachTypeList(1,POST_RC)%></option>
						<option value="<%=ApproachTypeList(0,POST_RD)%>"><%=ApproachTypeList(1,POST_RD)%></option>
						<option value="<%=ApproachTypeList(0,PRE_RC)%>"><%=ApproachTypeList(1,PRE_RC)%></option>	
						<option value="<%=ApproachTypeList(0,PRE_RD)%>"><%=ApproachTypeList(1,PRE_RD)%></option>	
						<option value="<%=ApproachTypeList(0,PRE_FI)%>"><%=ApproachTypeList(1,PRE_FI)%></option>
						<option value="<%=ApproachTypeList(0,REG)%>"><%=ApproachTypeList(1,REG)%></option>
					</select>
				</FONT>
				</TD>	
			</tr>
			
		<%End If%>
		<%'03/04/03 drh - Temporary - remove to go live
		'print vUpdateApproachInfo%>
		
		
		<%'Format Approach Person Field field%>
		<%If vUpdateApproachInfo Then%>
		
			<%
			'Get the User Org Approach Person data list
			'vQuery = "sps_Person " & vUserOrgID & ", null, " & 1
			'Response.Write vQuery
			'Set RS1 = Conn.Execute(vQuery)	
			'ApproachUserOrgPersonList = RS1.GetRows
			'Set RS1 = Nothing
			'Get the Referral Org Approach Person data list
			vQuery = "sps_ApproachPerson " & RS("OrganizationID") & ", null, " & 1
			'Response.Write vQuery
			Set RS1 = Conn.Execute(vQuery)	
			ApproachReferralOrgPersonList = RS1.GetRows
			Set RS1 = Nothing			
			%>
			
			<tr>
				<td ALIGN=LEFT VALIGN=CENTER><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>By:</b></font></td>
				<TD ALIGN=LEFT VALIGN=TOP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>">
					<%vValue = CLng(RS("ReferralApproachedByPersonID"))%>
					<select name="ApproachPerson" size="1">
						<%If vValue = -1 Then%>
							<option value="-1" selected></option>
						<%Else%>
							<option value="-1"></option>
						<%End If%>
						<%For i = 0 to Ubound(ApproachReferralOrgPersonList,2)%>
							<%If vValue = ApproachReferralOrgPersonList(0,i) Then%>
								<option value="<%=ApproachReferralOrgPersonList(0,i)%>" selected><%=ApproachReferralOrgPersonList(1,i) & " " & ApproachReferralOrgPersonList(2,i)%></option>
							<%Else%>
								<option value="<%=ApproachReferralOrgPersonList(0,i)%>"><%=ApproachReferralOrgPersonList(1,i) & " " & ApproachReferralOrgPersonList(2,i)%></option>
							<%End If%>
						<%Next %> 						
					</select>
				</FONT>
				</TD>
			</tr>
		
		<%Else%>
		
			<%vValue = CLng(RS("ReferralApproachedByPersonID"))%>
			
			<%
			'Get the Approach Person data list
			vQuery = "sps_Person null, " & vValue
				
			Set RS1 = Conn.Execute(vQuery)	
			ApproachUserOrgPersonList = RS1.GetRows
			Set RS1 = Nothing
			%>
					
			<tr>
				<td ALIGN=LEFT VALIGN=CENTER><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>By:</b></font></td>
				<TD ALIGN=LEFT VALIGN=TOP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>">
					<%=ApproachUserOrgPersonList(1,0) & " " & ApproachUserOrgPersonList(2,0)%>
				</FONT>
				</TD>
			<%'11/19/02 drh - Only show Change button if Read/Write
			if vReadOnly = 0 then%>
				<td>
					<A	HREF="javascript:doNothing();"
						onclick="window.open('/loginstatline/forms/updateApproachPerson.sls?<%=Request.QueryString%>&OrgID=<%=RS("OrganizationID")%>&ApproachPersonID=<%=RS("ReferralApproachedByPersonID")%>',
						'approachWindow',
						'width=300,height=280,resizable')">
						<IMG src="/loginstatline/images/changeWhite2.gif"
						NAME="Refresh"
						BORDER="0">
					</A>
				</td>				
				<td>&nbsp</td>
			<%end if%>
				<td>
					<A	HREF="javascript:window.location.reload();"
						TARGET=_self>
						<IMG src="/loginstatline/images/refr2.gif"
						NAME="Refresh"
						BORDER="0">
					</A>
				</td>
			</tr>		
		
		<%End If%>
		
		
		<%'General Consent%>
		<tr>
			<td ALIGN=LEFT VALIGN=CENTER><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Consent:</b></font></td>
			<TD ALIGN=LEFT VALIGN=TOP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>">
				<%vValue = CLng(RS("ReferralGeneralConsent"))%>
				<select name="GeneralConsent" size="1">
					<%If vValue = -1 Then%>
						<option value="-1" selected></option>
					<%Else%>
						<option value="-1"></option>
					<%End If%>
					<option value="1"<%If vValue=1 Then%> selected<%End If%>>Yes-Written
					<option value="2"<%If vValue=2 Then%> selected<%End If%>>Yes-Verbal</option>
					<option value="3"<%If vValue=3 Then%> selected<%End If%>>No</option>						
				</select>
			</FONT>
			</TD>
		</tr>
		
	
	</table>
		
	<BR>
	
	<%
	'Build the options table
	%>
	
	<table border="1" cellpadding="2" cellspacing="1" width="200">	
		<TR> 
            <td width="80" ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><b></b></td>
            <%If DataViewList(1,0) = "1" And DataServiceList(1,0) = "-1" Then%>
	            <td width="100" ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><b>Organ</b></td>
			<%End If%>
			<%If DataViewList(2,0) = "1" And DataServiceList(2,0) = "-1" Then%>
				<td width="100" ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><b>Bone</b></td>
			<%End If%>
			<%If DataViewList(3,0) = "1" And DataServiceList(3,0) = "-1" Then%>
				<td width="100" ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><b>Tissue</b></td>
			<%End If%>
			<%If DataViewList(4,0) = "1" And DataServiceList(4,0) = "-1" Then%>
				<td width="100" ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><b>Skin</b></td>
			<%End If%>
			<%If DataViewList(5,0) = "1" And DataServiceList(5,0) = "-1" Then%>
				<td width="100" ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><b>Valves</b></td>
			<%End If%>
			<%If DataViewList(6,0) = "1" And DataServiceList(6,0) = "-1" Then%>
				<td width="100" ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><b>Eyes</b></td>
			<%End If%>
			<%If DataViewList(7,0) = "1" And DataServiceList(7,0) = "-1" Then%>
				<td width="100" ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><b>Other</b></td>
			<%End If%>
		</tr>
				
				
		<!-- Appropriate -->			
		<TR> 
			<TD ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>Appropriate</FONT></B> </TD>
			<%
			If (CInt(RS("ReferralOrganAppropriateID")) - 1) > -1 Then 
				vValue = AppropriateList(1, CInt(RS("ReferralOrganAppropriateID")) - 1)
			Else
				vValue = "-"
			End If
			
			If DataViewList(1,0) = "1" And DataServiceList(1,0) = "-1" Then
			%>			
				<TD ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"></FONT><%=vValue%></TD>
			<%
			End If
			If (CInt(RS("ReferralBoneAppropriateID")) - 1) > -1 Then 
				vValue = AppropriateList(1, CInt(RS("ReferralBoneAppropriateID")) - 1)
			Else
				vValue = "-"
			End If
			
			If DataViewList(2,0) = "1" And DataServiceList(2,0) = "-1" Then			
			%>
				<TD ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"></FONT><%=vValue%> </TD>
			<%
			End If
			If (CInt(RS("ReferralTissueAppropriateID")) - 1) > -1 Then 
				vValue = AppropriateList(1, CInt(RS("ReferralTissueAppropriateID")) - 1)
			Else
				vValue = "-"
			End If
						
			If DataViewList(3,0) = "1" And DataServiceList(3,0) = "-1" Then
			%>
				<TD ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"></FONT><%=vValue%> </TD>
			<%
			End If
			If (CInt(RS("ReferralSkinAppropriateID")) - 1) > -1 Then 
				vValue = AppropriateList(1, CInt(RS("ReferralSkinAppropriateID")) - 1)
			Else
				vValue = "-"
			End If
						
			If DataViewList(4,0) = "1" And DataServiceList(4,0) = "-1" Then
			%>
				<TD ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"></FONT><%=vValue%> </TD>
			<%
			End If
			If (CInt(RS("ReferralValvesAppropriateID")) - 1) > -1 Then 
				vValue = AppropriateList(1, CInt(RS("ReferralValvesAppropriateID")) - 1)
			Else
				vValue = "-"
			End If
						
			If DataViewList(5,0) = "1" And DataServiceList(5,0) = "-1" Then
			%>
				<TD ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"></FONT><%=vValue%> </TD>
			<%
			End If
			If (CInt(RS("ReferralEyesTransAppropriateID")) - 1) > -1 Then 
				vValue = AppropriateList(1, CInt(RS("ReferralEyesTransAppropriateID")) - 1)
			Else
				vValue = "-"
			End If
						
			If DataViewList(6,0) = "1" And DataServiceList(6,0) = "-1" Then
			%>
				<TD ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"></FONT><%=vValue%> </TD>
			<%
			End If
			If (CInt(RS("ReferralEyesRschAppropriateID")) - 1) > -1 Then 
				vValue = AppropriateList(1, CInt(RS("ReferralEyesRschAppropriateID")) - 1)
			Else
				vValue = "-"
			End If
						
			If DataViewList(7,0) = "1" And DataServiceList(7,0) = "-1" Then
			%>
				<TD ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"></FONT><%=vValue%> </TD>
			<%End If%>
		</TR>
		
		
		<!-- Approach -->
		<TR> 
			<TD ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>Approach</FONT></B> </TD>
			<%
			'Organ Approach
			If DataViewList(1,0) = "1" And DataServiceList(1,0) = "-1" Then
			
				vValue = CInt(RS("ReferralOrganApproachID"))
				
				'ADD:	04/10/01 ttw
				'02/28/03 drh - Removed "And vValue = -1 _" after second line
				If DataUpdateList(1,0) = "1" And DataServiceList(8,0) = "-1" _
				And	CInt(RS("ReferralOrganAppropriateID")) = 1 _
				or (RS("ReferralApproachTypeID") = 7 and vValue = 2 and DataUpdateList(1,0) = "1") _
				Then
			%>
					<TD ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>">
						<select name="ApproachOrgan" size="1">
							<%If vValue = -1 Then%>
								<option value="-1" selected></option>
							<%Else%>
								<option value="-1"></option>
							<%End If%>
							<%For i = 0 to Ubound(ApproachList,2)%>
								<%If vValue = ApproachList(0,i) Then%>
									<option value="<%=ApproachList(0,i)%>" selected><%=ApproachList(1,i)%></option>
								<%Else%>
									<option value="<%=ApproachList(0,i)%>"><%=ApproachList(1,i)%></option>
								<%End If%>
							<%Next %> 
						</select>
					</FONT>
					</TD>
			<%
				Else
					If vValue > -1 Then 
						If vValue >= 11 Then ' Change from = 11 to >= 11
							vValue = ApproachList(1, vValue - 2)
						Else
							vValue = ApproachList(1, vValue - 1)
						End If
					Else
						vValue = "-"
					End If		
					%>	
					<TD ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"></FONT><%=vValue%> </TD>
					<%
				End If
				
			End If
			
			'Bone Approach
			If DataViewList(2,0) = "1" And DataServiceList(2,0) = "-1" Then
	
				vValue = CInt(RS("ReferralBoneApproachID"))
				
				'ADD:	04/10/01 ttw
				'02/28/03 drh - Removed "And vValue = -1 _" after second line
				If DataUpdateList(2,0) = "1" And DataServiceList(9,0) = "-1"  _
				And	CInt(RS("ReferralBoneAppropriateID")) = 1 _
				or (RS("ReferralApproachTypeID") = 7 and vValue = 2 and DataUpdateList(2,0) = "1") _
				Then		
			%>
					<TD ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>">
						<select name="ApproachBone" size="1">
							<%If vValue = -1 Then%>
								<option value="-1" selected></option>
							<%Else%>
								<option value="-1"></option>
							<%End If%>
							<%For i = 0 to Ubound(ApproachList,2)%>
								<%If vValue = ApproachList(0,i) Then%>
									<option value="<%=ApproachList(0,i)%>" selected><%=ApproachList(1,i)%></option>
								<%Else%>
									<option value="<%=ApproachList(0,i)%>"><%=ApproachList(1,i)%></option>
								<%End If%>
							<%Next %> 
						</select>
					</FONT>
					</TD>
			<%
				Else
					If vValue > -1 Then 
						If vValue >= 11 Then ' Change from = 11, 12 or 13 to >= 11
							vValue = ApproachList(1, vValue - 2)
						Else
							vValue = ApproachList(1, vValue - 1)
						End If
					Else
						vValue = "-"
					End If		
					%>	
					<TD ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"></FONT><%=vValue%> </TD>
					<%
				End If
				
			End If
			
			'Tissue Approach
			If DataViewList(3,0) = "1" And DataServiceList(3,0) = "-1" Then
	
				vValue = CInt(RS("ReferralTissueApproachID"))
				
				'ADD:	04/10/01 ttw
				'02/28/03 drh - Removed "And vValue = -1 _" after second line
				If DataUpdateList(3,0) = "1" And DataServiceList(10,0) = "-1"  _
				And	CInt(RS("ReferralTissueAppropriateID")) = 1 _
				or (RS("ReferralApproachTypeID") = 7 and vValue = 2 and DataUpdateList(3,0) = "1") _
				Then	
			%>			
					<TD ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>">
						<select name="ApproachTissue" size="1">
							<%If vValue = -1 Then%>
								<option value="-1" selected></option>
							<%Else%>
								<option value="-1"></option>
							<%End If%>
							<%For i = 0 to Ubound(ApproachList,2)%>
								<%If vValue = ApproachList(0,i) Then%>
									<option value="<%=ApproachList(0,i)%>" selected><%=ApproachList(1,i)%></option>
								<%Else%>
									<option value="<%=ApproachList(0,i)%>"><%=ApproachList(1,i)%></option>
								<%End If%>
							<%Next %> 
						</select>
					</FONT>
					</TD>
			<%
				Else
					If vValue > -1 Then 
						If vValue >= 11 Then ' Change from = 11,12,or 13  to >= 11
							vValue = ApproachList(1, vValue - 2)
						Else
							vValue = ApproachList(1, vValue - 1)
						End If
					Else
						vValue = "-"
					End If		
					%>	
					<TD ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"></FONT><%=vValue%> </TD>
					<%
				End If
				
			End If
			
			'Skin Approach
			If DataViewList(4,0) = "1" And DataServiceList(4,0) = "-1" Then
	
				vValue = CInt(RS("ReferralSkinApproachID"))
				
				'ADD:	04/10/01 ttw
				'02/28/03 drh - Removed "And vValue = -1 _" after second line
				If DataUpdateList(4,0) = "1" And DataServiceList(11,0) = "-1" _
				And	CInt(RS("ReferralSkinAppropriateID")) = 1 _
				or (RS("ReferralApproachTypeID") = 7 and vValue = 2 and DataUpdateList(4,0) = "1") _
				Then		
			%>			
					<TD ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>">
						<select name="ApproachSkin" size="1">
							<%If vValue = -1 Then%>
								<option value="-1" selected></option>
							<%Else%>
								<option value="-1"></option>
							<%End If%>
							<%For i = 0 to Ubound(ApproachList,2)%>
								<%If vValue = ApproachList(0,i) Then%>
									<option value="<%=ApproachList(0,i)%>" selected><%=ApproachList(1,i)%></option>
								<%Else%>
									<option value="<%=ApproachList(0,i)%>"><%=ApproachList(1,i)%></option>
								<%End If%>
							<%Next %> 
						</select>
					</FONT>
					</TD>
			<%
				Else
					If vValue > -1 Then 
						If vValue >= 11 Then ' Change from = 11,12,or 13  to >= 11
							vValue = ApproachList(1, vValue - 2)
						Else
							vValue = ApproachList(1, vValue - 1)
						End If
					Else
						vValue = "-"
					End If		
					%>	
					<TD ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"></FONT><%=vValue%> </TD>
					<%
				End If
				
			End If
			
			'Valves Approach
			If DataViewList(5,0) = "1" And DataServiceList(5,0) = "-1" Then
	
				vValue = CInt(RS("ReferralValvesApproachID"))
				
				'ADD:	04/10/01 ttw
				'02/28/03 drh - Removed "And vValue = -1 _" after second line
				If DataUpdateList(5,0) = "1" And DataServiceList(12,0) = "-1"  _
				And	CInt(RS("ReferralValvesAppropriateID")) = 1 _
				or (RS("ReferralApproachTypeID") = 7 and vValue = 2 and DataUpdateList(5,0) = "1") _
				Then	
			%>			
					<TD ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>">
						<select name="ApproachValves" size="1">
							<%If vValue = -1 Then%>
								<option value="-1" selected></option>
							<%Else%>
								<option value="-1"></option>
							<%End If%>
							<%For i = 0 to Ubound(ApproachList,2)%>
								<%If vValue = ApproachList(0,i) Then%>
									<option value="<%=ApproachList(0,i)%>" selected><%=ApproachList(1,i)%></option>
								<%Else%>
									<option value="<%=ApproachList(0,i)%>"><%=ApproachList(1,i)%></option>
								<%End If%>
							<%Next %> 
						</select>
					</FONT>
					</TD>
			<%
				Else
					If vValue > -1 Then 
						If vValue >= 11 Then ' Change from = 11,12,or 13  to >= 11
							vValue = ApproachList(1, vValue - 2)
						Else
							vValue = ApproachList(1, vValue - 1)
						End If
					Else
						vValue = "-"
					End If		
					%>	
					<TD ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"></FONT><%=vValue%> </TD>
					<%
				End If
				
			End If
			
			'Eyes Approach			
			If DataViewList(6,0) = "1" And DataServiceList(6,0) = "-1" Then
	
				vValue = CInt(RS("ReferralEyesTransApproachID"))
				
				'ADD:	04/10/01 ttw
				'02/28/03 drh - Removed "And vValue = -1 _" after second line
				If DataUpdateList(6,0) = "1" And DataServiceList(13,0) = "-1"  _
					And	CInt(RS("ReferralEyesTransAppropriateID")) = 1 _
					or (RS("ReferralApproachTypeID") = 7 and vValue = 2 and DataUpdateList(6,0) = "1") _
				Then		
			%>		
					<TD ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>">
						<select name="ApproachEyes" size="1">
							<%If vValue = -1 Then%>
								<option value="-1" selected></option>
							<%Else%>
								<option value="-1"></option>
							<%End If%>
							<%For i = 0 to Ubound(ApproachList,2)%>
								<%If vValue = ApproachList(0,i) Then%>
									<option value="<%=ApproachList(0,i)%>" selected><%=ApproachList(1,i)%></option>
								<%Else%>
									<option value="<%=ApproachList(0,i)%>"><%=ApproachList(1,i)%></option>
								<%End If%>
							<%Next %> 
						</select>
					</FONT>
					</TD>
			<%
				Else
					
					If vValue > -1 Then 
					
						If vValue >= 11  Then ' Change from = 11,12,or 13  to >= 11
							vValue = ApproachList(1, vValue - 2)
						Else
							vValue = ApproachList(1, vValue - 1)
						End If
					Else
						vValue = "-"
					End If		
					%>	
					<TD ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"></FONT><%=vValue%> </TD>
					<%
				End If
				
			End If
			
			'Other Approach
			If DataViewList(7,0) = "1" And DataServiceList(7,0) = "-1" Then
	
				vValue = CInt(RS("ReferralEyesRschApproachID"))
				
				'ADD:	04/10/01 ttw
				'02/28/03 drh - Removed "And vValue = -1 _" after second line
				If DataUpdateList(7,0) = "1" And DataServiceList(14,0) = "-1"  _
				And	CInt(RS("ReferralEyesRschAppropriateID")) = 1 _
				or (RS("ReferralApproachTypeID") = 7 and vValue = 2 and DataUpdateList(7,0) = "1") _
				Then	
			%>				
					<TD ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>">
						<select name="ApproachOther" size="1">
							<%If vValue = -1 Then%>
								<option value="-1" selected></option>
							<%Else%>
								<option value="-1"></option>
							<%End If%>
							<%For i = 0 to Ubound(ApproachList,2)%>
								<%If vValue = ApproachList(0,i) Then%>
									<option value="<%=ApproachList(0,i)%>" selected><%=ApproachList(1,i)%></option>
								<%Else%>
									<option value="<%=ApproachList(0,i)%>"><%=ApproachList(1,i)%></option>
								<%End If%>
							<%Next %> 
						</select>
					</FONT>
					</TD>
			<%
				Else
					If vValue > -1 Then 
						If vValue >= 11 Then ' Change from = 11,12,or 13  to >= 11
							vValue = ApproachList(1, vValue - 2)
						Else
							vValue = ApproachList(1, vValue - 1)
						End If
					Else
						vValue = "-"
					End If		
					%>	
					<TD ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"></FONT><%=vValue%> </TD>
					<%
				End If
				
			End If
			%>			
		</TR>
		
		
		<!-- Consent -->
		<%ConsentToUpdate = False%>
		<TR> 
			<TD ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>Consent</FONT></B> </TD>
			<%
			'Organ Consent
			If DataViewList(1,0) = "1" And DataServiceList(1,0) = "-1" Then
			
				vValue = CInt(RS("ReferralOrganConsentID"))
				
				'02/28/03 drh - Removed "And (vValue = -1 or vValue = 2) _" after third line
				If DataUpdateList(1,0) = "1" And DataServiceList(15,0) = "-1"  _
				And	CInt(RS("ReferralOrganAppropriateID")) = 1 _
				And	(CInt(RS("ReferralOrganApproachID")) = 1 Or CInt(RS("ReferralOrganApproachID")) = -1 Or CInt(RS("ReferralOrganApproachID")) = 12 Or CInt(RS("ReferralOrganApproachID")) = 13) _	
				or (RS("ReferralApproachTypeID") = 7 and vValue = 2 and DataUpdateList(1,0) = "1") _
				Then
					ConsentToUpdate = True
			%>		
					<TD ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>">
						<select name="ConsentOrgan" size="1">
							<%If vValue = -1 Then%>
								<option value="-1" selected></option>
							<%Else%>
								<option value="-1"></option>
							<%End If%>
							<%For i = 0 to Ubound(ConsentList,2)%>
								<%If vValue = ConsentList(0,i) Then%>
									<option value="<%=ConsentList(0,i)%>" selected><%=ConsentList(1,i)%></option>
								<%Else%>
									<option value="<%=ConsentList(0,i)%>"><%=ConsentList(1,i)%></option>
								<%End If%>
							<%Next %> 
						</select>
					</FONT>
					</TD>
			<%
				Else
					If vValue > -1 Then 
						vValue = ConsentList(1, vValue - 1)
					Else
						vValue = "-"
					End If		
					%>	
					<TD ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"></FONT><%=vValue%> </TD>
					<%
				End If
				
			End If
			
			'Bone Consent
			If DataViewList(2,0) = "1" And DataServiceList(2,0) = "-1" Then
	
				vValue = CInt(RS("ReferralBoneConsentID"))
				
				'02/28/03 drh - Removed "And (vValue = -1 or vValue = 2) _" after third line
				If DataUpdateList(2,0) = "1" And DataServiceList(16,0) = "-1"  _
				And	CInt(RS("ReferralBoneAppropriateID")) = 1 _
				And	(CInt(RS("ReferralBoneApproachID")) = 1 Or CInt(RS("ReferralBoneApproachID")) = -1 Or CInt(RS("ReferralBoneApproachID")) = 12 Or CInt(RS("ReferralBoneApproachID")) = 13) _	
				or (RS("ReferralApproachTypeID") = 7 and vValue = 2 and DataUpdateList(1,0) = "1") _
				or (RS("ReferralApproachTypeID") = 7 and vValue = -1 and DataUpdateList(2,0) = "1") _
				Then	
					ConsentToUpdate = True
			%>		
					<TD ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>">
						<select name="ConsentBone" size="1">
							<%If vValue = -1 Then%>
								<option value="-1" selected></option>
							<%Else%>
								<option value="-1"></option>
							<%End If%>
							<%For i = 0 to Ubound(ConsentList,2)%>
								<%If vValue = ConsentList(0,i) Then%>
									<option value="<%=ConsentList(0,i)%>" selected><%=ConsentList(1,i)%></option>
								<%Else%>
									<option value="<%=ConsentList(0,i)%>"><%=ConsentList(1,i)%></option>
								<%End If%>
							<%Next %> 
						</select>
					</FONT>
					</TD>
			<%
				Else
					If vValue > -1 Then 
						vValue = ConsentList(1, vValue - 1)
					Else
						vValue = "-"
					End If		
					%>	
					<TD ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"></FONT><%=vValue%> </TD>
					<%
				End If
				
			End If
			
			'Tissue Consent
			If DataViewList(3,0) = "1" And DataServiceList(3,0) = "-1" Then
	
				vValue = CInt(RS("ReferralTissueConsentID"))
				
				'02/28/03 drh - Removed "And (vValue = -1 or vValue = 2) _" after third line
				If DataUpdateList(3,0) = "1" And DataServiceList(17,0) = "-1"  _
				And	CInt(RS("ReferralTissueAppropriateID")) = 1 _
				And	(CInt(RS("ReferralTissueApproachID")) = 1 Or CInt(RS("ReferralTissueApproachID")) = -1 Or CInt(RS("ReferralTissueApproachID")) = 12 Or CInt(RS("ReferralTissueApproachID")) = 13) _	
				or (RS("ReferralApproachTypeID") = 7 and vValue = -1 and DataUpdateList(3,0) = "1" And CInt(RS("ReferralTissueAppropriateID")) = 1) _
				Then	
					ConsentToUpdate = True
			%>				
					<TD ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>">
						<select name="ConsentTissue" size="1">
							<%If vValue = -1 Then%>
								<option value="-1" selected></option>
							<%Else%>
								<option value="-1"></option>
							<%End If%>
							<%For i = 0 to Ubound(ConsentList,2)%>
								<%If vValue = ConsentList(0,i) Then%>
									<option value="<%=ConsentList(0,i)%>" selected><%=ConsentList(1,i)%></option>
								<%Else%>
									<option value="<%=ConsentList(0,i)%>"><%=ConsentList(1,i)%></option>
								<%End If%>
							<%Next %> 
						</select>
					</FONT>
					</TD>
			<%
				Else
					If vValue > -1 Then 
						vValue = ConsentList(1, vValue - 1)
					Else
						vValue = "-"
					End If		
					%>	
					<TD ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"></FONT><%=vValue%> </TD>
					<%
				End If
				
			End If
			
			'Skin Consent
			If DataViewList(4,0) = "1" And DataServiceList(4,0) = "-1" Then
	
				vValue = CInt(RS("ReferralSkinConsentID"))
				
				'02/28/03 drh - Removed "And (vValue = -1 or vValue = 2) _" after third line
				If DataUpdateList(4,0) = "1" And DataServiceList(18,0) = "-1"  _
				And	CInt(RS("ReferralSkinAppropriateID")) = 1 _
				And	(CInt(RS("ReferralSkinApproachID")) = 1 Or CInt(RS("ReferralSkinApproachID")) = -1 Or CInt(RS("ReferralSkinApproachID")) = 12 Or CInt(RS("ReferralSkinApproachID")) = 13) _	
				or (RS("ReferralApproachTypeID") = 7 and vValue = -1 and DataUpdateList(4,0) = "1") _
				Then		
					ConsentToUpdate = True
			%>			
					<TD ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>">
						<select name="ConsentSkin" size="1">
							<%If vValue = -1 Then%>
								<option value="-1" selected></option>
							<%Else%>
								<option value="-1"></option>
							<%End If%>
							<%For i = 0 to Ubound(ConsentList,2)%>
								<%If vValue = ConsentList(0,i) Then%>
									<option value="<%=ConsentList(0,i)%>" selected><%=ConsentList(1,i)%></option>
								<%Else%>
									<option value="<%=ConsentList(0,i)%>"><%=ConsentList(1,i)%></option>
								<%End If%>
							<%Next %> 
						</select>
					</FONT>
					</TD>
			<%
				Else
					If vValue > -1 Then 
						vValue = ConsentList(1, vValue - 1)
					Else
						vValue = "-"
					End If		
					%>	
					<TD ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"></FONT><%=vValue%> </TD>
					<%
				End If
				
			End If
			
			'Valves Consent
			If DataViewList(5,0) = "1" And DataServiceList(5,0) = "-1" Then
	
				vValue = CInt(RS("ReferralValvesConsentID"))
				
				'02/28/03 drh - Removed "And (vValue = -1 or vValue = 2) _" after third line
				If DataUpdateList(5,0) = "1" And DataServiceList(19,0) = "-1"  _
				And	CInt(RS("ReferralValvesAppropriateID")) = 1 _
				And	(CInt(RS("ReferralValvesApproachID")) = 1 Or CInt(RS("ReferralValvesApproachID")) = -1 Or CInt(RS("ReferralValvesApproachID")) = 12 Or CInt(RS("ReferralValvesApproachID")) = 13) _	
				or (RS("ReferralApproachTypeID") = 7 and vValue = -1 and DataUpdateList(5,0) = "1") _
				Then	
					ConsentToUpdate = True
			%>		
					<TD ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>">
						<select name="ConsentValves" size="1">
							<%If vValue = -1 Then%>
								<option value="-1" selected></option>
							<%Else%>
								<option value="-1"></option>
							<%End If%>
							<%For i = 0 to Ubound(ConsentList,2)%>
								<%If vValue = ConsentList(0,i) Then%>
									<option value="<%=ConsentList(0,i)%>" selected><%=ConsentList(1,i)%></option>
								<%Else%>
									<option value="<%=ConsentList(0,i)%>"><%=ConsentList(1,i)%></option>
								<%End If%>
							<%Next %> 
						</select>
					</FONT>
					</TD>
			<%
				Else
					If vValue > -1 Then 
						vValue = ConsentList(1, vValue - 1)
					Else
						vValue = "-"
					End If		
					%>	
					<TD ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"></FONT><%=vValue%> </TD>
					<%
				End If
				
			End If
			
			'Eyes Consent
			If DataViewList(6,0) = "1" And DataServiceList(6,0) = "-1" Then
	
				vValue = CInt(RS("ReferralEyesTransConsentID"))
				
				'02/28/03 drh - Removed "And (vValue = -1 or vValue = 2) _" after third line
				If DataUpdateList(6,0) = "1" And DataServiceList(20,0) = "-1"  _
				And	CInt(RS("ReferralEyesTransAppropriateID")) = 1 _
				And	(CInt(RS("ReferralEyesTransApproachID")) = 1 Or CInt(RS("ReferralEyesTransApproachID")) = -1 Or CInt(RS("ReferralEyesTransApproachID")) = 12 Or CInt(RS("ReferralEyesTransApproachID")) = 13) _	
				or (RS("ReferralApproachTypeID") = 7 and vValue = -1 and DataUpdateList(6,0) = "1") _
				Then	
					ConsentToUpdate = True
			%>			
					<TD ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>">
						<select name="ConsentEyes" size="1">
							<%If vValue = -1 Then%>
								<option value="-1" selected></option>
							<%Else%>
								<option value="-1"></option>
							<%End If%>
							<%For i = 0 to Ubound(ConsentList,2)%>
								<%If vValue = ConsentList(0,i) Then%>
									<option value="<%=ConsentList(0,i)%>" selected><%=ConsentList(1,i)%></option>
								<%Else%>
									<option value="<%=ConsentList(0,i)%>"><%=ConsentList(1,i)%></option>
								<%End If%>
							<%Next %> 
						</select>
					</FONT>
					</TD>
			<%
				Else
					If vValue > -1 Then 
						vValue = ConsentList(1, vValue - 1)
					Else
						vValue = "-"
					End If		
					%>	
					<TD ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"></FONT><%=vValue%> </TD>
					<%
				End If
				
			End If
			
			'Other Consent
			If DataViewList(7,0) = "1" And DataServiceList(7,0) = "-1" Then
	
				vValue = CInt(RS("ReferralEyesRschConsentID"))
				
				'02/28/03 drh - Removed "And (vValue = -1 or vValue = 2) _" after third line
				If DataUpdateList(7,0) = "1" And DataServiceList(21,0) = "-1"  _
				And	CInt(RS("ReferralEyesRschAppropriateID")) = 1 _
				And	(CInt(RS("ReferralEyesRschApproachID")) = 1 Or CInt(RS("ReferralEyesRschApproachID")) = -1 Or CInt(RS("ReferralEyesRschApproachID")) = 12 Or CInt(RS("ReferralEyesRschApproachID")) = 13) _	
				or (RS("ReferralApproachTypeID") = 7 and vValue = -1 and DataUpdateList(7,0) = "1") _
				Then		
					ConsentToUpdate = True
			%>		
					<TD ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>">
						<select name="ConsentOther" size="1">
							<%If vValue = -1 Then%>
								<option value="-1" selected></option>
							<%Else%>
								<option value="-1"></option>
							<%End If%>
							<%For i = 0 to Ubound(ConsentList,2)%>
								<%If vValue = ConsentList(0,i) Then%>
									<option value="<%=ConsentList(0,i)%>" selected><%=ConsentList(1,i)%></option>
								<%Else%>
									<option value="<%=ConsentList(0,i)%>"><%=ConsentList(1,i)%></option>
								<%End If%>
							<%Next %> 
						</select>
					</FONT>
					</TD>
			<%
				Else
					If vValue > -1 Then 
						vValue = ConsentList(1, vValue - 1)
					Else
						vValue = "-"
					End If		
					%>	
					<TD ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"></FONT><%=vValue%> </TD>
					<%
				End If
				
			End If
			%>
		</TR>
		
		
		<!-- Recovery -->
		<%RecoveryToUpdate = False%>
		<TR> 
			<TD width="80" ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>Recovery</FONT></B> </TD>
			<%
			'Organ Recovery
			If DataViewList(1,0) = "1" And DataServiceList(1,0) = "-1" Then
				
				vValue = CInt(RS("ReferralOrganConversionID"))
				
				'02/28/03 drh - Removed "And (vValue = -1 or vValue = 2) _" after fourth line
				'response.Write(RS("ReferralOrganAppropriateID"))
				If DataUpdateList(1,0) = "1" And DataServiceList(22,0) = "-1"  _
				And CInt(RS("ReferralOrganAppropriateID")) = 1 _
				And	(CInt(RS("ReferralOrganApproachID")) = 1 Or CInt(RS("ReferralOrganApproachID")) = 12 Or CInt(RS("ReferralOrganApproachID")) = 13 Or CInt(RS("ReferralOrganApproachID")) = -1) _				
				And	(CInt(RS("ReferralOrganConsentID")) = 1 Or CInt(RS("ReferralOrganConsentID")) = 7 Or CInt(RS("ReferralOrganConsentID")) = 8 Or CInt(RS("ReferralOrganConsentID")) = -1) _
					or (RS("ReferralApproachTypeID") = 7 _
						and vValue = -1 and DataUpdateList(1,0) = "1" _
						And CInt(RS("ReferralOrganAppropriateID")) = 1) _
				Then		
					RecoveryToUpdate = True
			%>			
					<TD ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>">
						<select name="ConversionOrgan" size="1">
							<%If vValue = -1 Then%>
								<option value="-1" selected></option>
							<%Else%>
								<option value="-1"></option>
							<%End If%>
							<%For i = 0 to Ubound(ConversionList,2)%>
								<%If vValue = ConversionList(0,i) Then%>
									<option value="<%=ConversionList(0,i)%>" selected><%=ConversionList(1,i)%></option>
								<%Else%>
									<option value="<%=ConversionList(0,i)%>"><%=ConversionList(1,i)%></option>
								<%End If%>
							<%Next %> 
						</select>
					</FONT>
					</TD>
			<%
				Else
					If vValue > -1 Then 
						vValue = ConversionList(1, vValue - 1)
					Else
						vValue = "-"
					End If		
					%>	
					<TD ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"></FONT><%=vValue%> </TD>
					<%
				End If
				
			End If
			
			'Bone Recovery
			If DataViewList(2,0) = "1" And DataServiceList(2,0) = "-1" Then
	
				vValue = CInt(RS("ReferralBoneConversionID"))
				
				'02/28/03 drh - Removed "And (vValue = -1 or vValue = 2) _" after fourth line
				If DataUpdateList(2,0) = "1" And DataServiceList(23,0) = "-1"  _
				And CInt(RS("ReferralBoneAppropriateID")) = 1 _
				And	(CInt(RS("ReferralBoneApproachID")) = 1 Or CInt(RS("ReferralBoneApproachID")) = 12 Or CInt(RS("ReferralBoneApproachID")) = 13 Or CInt(RS("ReferralBoneApproachID")) = -1) _				
				And	(CInt(RS("ReferralBoneConsentID")) = 1 Or CInt(RS("ReferralBoneConsentID")) = 7 Or CInt(RS("ReferralBoneConsentID")) = 8 Or CInt(RS("ReferralBoneConsentID")) = -1) _
				or (RS("ReferralApproachTypeID") = 7 _
						and vValue = -1 and DataUpdateList(2,0) = "1" _
						And CInt(RS("ReferralBoneAppropriateID")) = 1) _
				Then
					RecoveryToUpdate = True
			%>			
					<TD ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>">
						<select name="ConversionBone" size="1">
							<%If vValue = -1 Then%>
								<option value="-1" selected></option>
							<%Else%>
								<option value="-1"></option>
							<%End If%>
							<%For i = 0 to Ubound(ConversionList,2)%>
								<%If vValue = ConversionList(0,i) Then%>
									<option value="<%=ConversionList(0,i)%>" selected><%=ConversionList(1,i)%></option>
								<%Else%>
									<option value="<%=ConversionList(0,i)%>"><%=ConversionList(1,i)%></option>
								<%End If%>
							<%Next %> 
						</select>
					</FONT>
					</TD>
			<%
				Else
					If vValue > -1 Then 
						vValue = ConversionList(1, vValue - 1)
					Else
						vValue = "-"
					End If		
					%>	
					<TD ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"></FONT><%=vValue%> </TD>
					<%
				End If
				
			End If
			
			'Tissue Recovery
			If DataViewList(3,0) = "1" And DataServiceList(3,0) = "-1" Then
	
				vValue = CInt(RS("ReferralTissueConversionID"))
				
				'02/28/03 drh - Removed "And (vValue = -1 or vValue = 2) _" after fourth line
				If DataUpdateList(3,0) = "1" And DataServiceList(24,0) = "-1"  _
				And CInt(RS("ReferralTissueAppropriateID")) = 1 _
				And	(CInt(RS("ReferralTissueApproachID")) = 1 Or CInt(RS("ReferralTissueApproachID")) = 12 Or CInt(RS("ReferralTissueApproachID")) = 13 Or CInt(RS("ReferralTissueApproachID")) = -1) _				
				And	(CInt(RS("ReferralTissueConsentID")) = 1 Or CInt(RS("ReferralTissueConsentID")) = 7 Or CInt(RS("ReferralTissueConsentID")) = 8 Or CInt(RS("ReferralTissueConsentID")) = -1) _
				or (RS("ReferralApproachTypeID") = 7 _
						and vValue = -1 and DataUpdateList(3,0) = "1" _
						And CInt(RS("ReferralTissueAppropriateID")) = 1) _
				Then			
					RecoveryToUpdate = True
			%>				
					<TD ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>">
						<select name="ConversionTissue" size="1">
							<%If vValue = -1 Then%>
								<option value="-1" selected></option>
							<%Else%>
								<option value="-1"></option>
							<%End If%>
							<%For i = 0 to Ubound(ConversionList,2)%>
								<%If vValue = ConversionList(0,i) Then%>
									<option value="<%=ConversionList(0,i)%>" selected><%=ConversionList(1,i)%></option>
								<%Else%>
									<option value="<%=ConversionList(0,i)%>"><%=ConversionList(1,i)%></option>
								<%End If%>
							<%Next %> 
						</select>
					</FONT>
					</TD>
			<%
				Else
					If vValue > -1 Then 
						vValue = ConversionList(1, vValue - 1)
					Else
						vValue = "-"
					End If		
					%>	
					<TD ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"></FONT><%=vValue%> </TD>
					<%
				End If
				
			End If
			
			'Skin Recovery
			If DataViewList(4,0) = "1" And DataServiceList(4,0) = "-1" Then
				
				vValue = CInt(RS("ReferralSkinConversionID"))
				
				'02/28/03 drh - Removed "And (vValue = -1 or vValue = 2) _" after fourth line
				If DataUpdateList(4,0) = "1" And DataServiceList(25,0) = "-1"  _
				And CInt(RS("ReferralSkinAppropriateID")) = 1 _
				And	(CInt(RS("ReferralSkinApproachID")) = 1 Or CInt(RS("ReferralSkinApproachID")) = 12 Or CInt(RS("ReferralSkinApproachID")) = 13 Or CInt(RS("ReferralSkinApproachID")) = -1) _				
				And	(CInt(RS("ReferralSkinConsentID")) = 1 Or CInt(RS("ReferralSkinConsentID")) = 7 Or CInt(RS("ReferralSkinConsentID")) = 8 Or CInt(RS("ReferralSkinConsentID")) = -1) _
				or (RS("ReferralApproachTypeID") = 7 _
						and vValue = -1 and DataUpdateList(4,0) = "1" _
						And CInt(RS("ReferralSkinAppropriateID")) = 1) _
				Then			
					RecoveryToUpdate = True
			%>			
					<TD ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>">
						<select name="ConversionSkin" size="1">
							<%If vValue = -1 Then%>
								<option value="-1" selected></option>
							<%Else%>
								<option value="-1"></option>
							<%End If%>
							<%For i = 0 to Ubound(ConversionList,2)%>
								<%If vValue = ConversionList(0,i) Then%>
									<option value="<%=ConversionList(0,i)%>" selected><%=ConversionList(1,i)%></option>
								<%Else%>
									<option value="<%=ConversionList(0,i)%>"><%=ConversionList(1,i)%></option>
								<%End If%>
							<%Next %> 
						</select>
					</FONT>
					</TD>
			<%
				Else
					If vValue > -1 Then 
						vValue = ConversionList(1, vValue - 1)
					Else
						vValue = "-"
					End If		
					%>	
					<TD ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"></FONT><%=vValue%> </TD>
					<%
				End If
				
			End If
			
			'Valves Recovery
			If DataViewList(5,0) = "1" And DataServiceList(5,0) = "-1" Then
				
				vValue = CInt(RS("ReferralValvesConversionID"))
				
				'02/28/03 drh - Removed "And (vValue = -1 or vValue = 2) _" after fourth line
				If DataUpdateList(5,0) = "1" And DataServiceList(26,0) = "-1"  _
				And CInt(RS("ReferralValvesAppropriateID")) = 1 _
				And	(CInt(RS("ReferralValvesApproachID")) = 1 Or CInt(RS("ReferralValvesApproachID")) = 12 Or CInt(RS("ReferralValvesApproachID")) = 13 Or CInt(RS("ReferralValvesApproachID")) = -1) _				
				And	(CInt(RS("ReferralValvesConsentID")) = 1 Or CInt(RS("ReferralValvesConsentID")) = 7 Or CInt(RS("ReferralValvesConsentID")) = 8 Or CInt(RS("ReferralValvesConsentID")) = -1) _
				or (RS("ReferralApproachTypeID") = 7 _
						and vValue = -1 and DataUpdateList(5,0) = "1" _
						And CInt(RS("ReferralValvesAppropriateID")) = 1) _
				Then		
					RecoveryToUpdate = True
			%>				
					<TD ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>">
						<select name="ConversionValves" size="1">
							<%If vValue = -1 Then%>
								<option value="-1" selected></option>
							<%Else%>
								<option value="-1"></option>
							<%End If%>
							<%For i = 0 to Ubound(ConversionList,2)%>
								<%If vValue = ConversionList(0,i) Then%>
									<option value="<%=ConversionList(0,i)%>" selected><%=ConversionList(1,i)%></option>
								<%Else%>
									<option value="<%=ConversionList(0,i)%>"><%=ConversionList(1,i)%></option>
								<%End If%>
							<%Next %> 
						</select>
					</FONT>
					</TD>
			<%
				Else
					If vValue > -1 Then 
						vValue = ConversionList(1, vValue - 1)
					Else
						vValue = "-"
					End If		
					%>	
					<TD ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"></FONT><%=vValue%> </TD>
					<%
				End If
				
			End If
			
			'Eyes Recovery
			If DataViewList(6,0) = "1" And DataServiceList(6,0) = "-1" Then
				
				vValue = CInt(RS("ReferralEyesTransConversionID"))
				
				'02/28/03 drh - Removed "And (vValue = -1 or vValue = 2) _" after fourth line
				If DataUpdateList(6,0) = "1" And DataServiceList(27,0) = "-1"  _
				And CInt(RS("ReferralEyesTransAppropriateID")) = 1 _
				And	(CInt(RS("ReferralEyesTransApproachID")) = 1 Or CInt(RS("ReferralEyesTransApproachID")) = 12 Or CInt(RS("ReferralEyesTransApproachID")) = 13 Or CInt(RS("ReferralEyesTransApproachID")) = -1) _				
				And	(CInt(RS("ReferralEyesTransConsentID")) = 1 Or CInt(RS("ReferralEyesTransConsentID")) = 7 Or CInt(RS("ReferralEyesTransConsentID")) = 8 Or CInt(RS("ReferralEyesTransConsentID")) = -1) _
				or (RS("ReferralApproachTypeID") = 7 _
						and vValue = -1 and DataUpdateList(6,0) = "1" _
						And CInt(RS("ReferralEyesTransAppropriateID")) = 1) _
				Then		
					RecoveryToUpdate = True
			%>		
					<TD ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>">
						<select name="ConversionEyes" size="1">
							<%If vValue = -1 Then%>
								<option value="-1" selected></option>
							<%Else%>
								<option value="-1"></option>
							<%End If%>
							<%For i = 0 to Ubound(ConversionList,2)%>
								<%If vValue = ConversionList(0,i) Then%>
									<option value="<%=ConversionList(0,i)%>" selected><%=ConversionList(1,i)%></option>
								<%Else%>
									<option value="<%=ConversionList(0,i)%>"><%=ConversionList(1,i)%></option>
								<%End If%>
							<%Next %> 
						</select>
					</FONT>
					</TD>
			<%
				Else
					If vValue > -1 Then 
						vValue = ConversionList(1, vValue - 1)
					Else
						vValue = "-"
					End If		
					%>	
					<TD ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"></FONT><%=vValue%> </TD>
					<%
				End If
				
			End If
			
			'Other Recovery
			If DataViewList(7,0) = "1" And DataServiceList(7,0) = "-1" Then
			
				vValue = CInt(RS("ReferralEyesRschConversionID"))
				
				'02/28/03 drh - Removed "And (vValue = -1 or vValue = 2) _" after fourth line
				If DataUpdateList(7,0) = "1" And DataServiceList(28,0) = "-1"  _
				And CInt(RS("ReferralEyesRschAppropriateID")) = 1 _
				And	(CInt(RS("ReferralEyesRschApproachID")) = 1 Or CInt(RS("ReferralEyesRschApproachID")) = 12 Or CInt(RS("ReferralEyesRschApproachID")) = 13 Or CInt(RS("ReferralEyesRschApproachID")) = -1) _				
				And	(CInt(RS("ReferralEyesRschConsentID")) = 1 Or CInt(RS("ReferralEyesRschConsentID")) = 7 Or CInt(RS("ReferralEyesRschConsentID")) = 8 Or CInt(RS("ReferralEyesRschConsentID")) = -1) _
				or (RS("ReferralApproachTypeID") = 7 _
						and vValue = -1 and DataUpdateList(7,0) = "1" _
						And CInt(RS("ReferralEyesRschAppropriateID")) = 1) _
				Then			
					RecoveryToUpdate = True
			%>				
					<TD ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>">
						<select name="ConversionOther" size="1">
							<%If vValue = -1 Then%>
								<option value="-1" selected></option>
							<%Else%>
								<option value="-1"></option>
							<%End If%>
							<%For i = 0 to Ubound(ConversionList,2)%>
								<%If vValue = ConversionList(0,i) Then%>
									<option value="<%=ConversionList(0,i)%>" selected><%=ConversionList(1,i)%></option>
								<%Else%>
									<option value="<%=ConversionList(0,i)%>"><%=ConversionList(1,i)%></option>
								<%End If%>
							<%Next %> 
						</select>
					</FONT>
					</TD>
			<%
				Else
					If vValue > -1 Then 
						vValue = ConversionList(1, vValue - 1)
					Else
						vValue = "-"
					End If		
					%>	
					<TD ALIGN=LEFT VALIGN=TOP NOWRAP><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"></FONT><%=vValue%> </TD>
					<%
				End If
				
			End If
			%>			
		</TR>

	</TABLE>
	</BR>
<%
End If
%>

<%
'Show the consent and recovery outcome comments field
%>

	<table border="0" cellpadding="0" cellspacing="2">	

		<tr>
			<%If ConsentToUpdate = True Then%>
				<td ALIGN=LEFT VALIGN=TOP width="80"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Consent Outcome:</b></font></td>
				<td ALIGN=LEFT VALIGN=TOP width="275"><textarea rows="6" name="ConsentComments" cols="30" wrap="virtual"><%=Request.Cookies("ConsentComments")%></textarea></td>
				<input type="hidden" name="ConsentVisible" value="True">
			<%End If%>
			
			<%If RecoveryToUpdate = True Then%>
				<td ALIGN=LEFT VALIGN=TOP width="80"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Recovery Outcome:</b></font></td>
				<td ALIGN=LEFT VALIGN=TOP><textarea rows="6" name="RecoveryComments" cols="30" wrap="virtual"><%=Request.Cookies("RecoveryComments")%></textarea></td>
				<input type="hidden" name="RecoveryVisible" value="True">
			<%End If%>
		</tr>
		
	</table>

</form>

</BODY>
</HTML>
<!--#include virtual="/loginstatline/includes/copyright.shm"-->
<%
End If

Set RS = Nothing
Set Conn = Nothing


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

	<%'drh 11/20/02%>
	var callCancel = 1;
	
	function getCookie(Name) 
	{
	   var search = Name + "="
	
	   if (document.cookie.length > 0) 
	   { // if there are any cookies
	   
	      offset = document.cookie.indexOf(search) 
	      
	      if (offset != -1) 
	      { // if cookie exists 
	      
	         offset += search.length 
	         
	         // set index of beginning of value
	         end = document.cookie.indexOf(";", offset) 
	         
	         // set index of end of cookie value
	         if (end == -1) 
	            end = document.cookie.length
	            
	         return unescape(document.cookie.substring(offset, end))
	
	      } 
	   }
	}
	
	// Sets cookie values. Expiration date is optional
	//
	function setCookie(name, value, expire) 
	{
		if (value == null)
		{
			value = ""
		}
		
		document.cookie = name + "=" + escape(value) + ((expire == null) ? "" : ("; expires=" + expire.toGMTString()))
	}
	
	function doNothing() 
	{
	}
	
	<%'drh 11/20/02%>
	function cancelReferral()
	{
		if (callCancel==1)
		{
			window.open('CancelReferral.sls?CallID=' + document.UpdateReferralForm.CallID.value + '&UserID=' + document.UpdateReferralForm.UserID.value + '&UserOrgID=' + document.UpdateReferralForm.UserOrgID.value + '&TZ=' + document.UpdateReferralForm.TZ.value + '&LogId=' + document.UpdateReferralForm.LogId.value)
		}
	}
	
</script>