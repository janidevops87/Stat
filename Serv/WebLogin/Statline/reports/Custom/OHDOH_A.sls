
<% 
Option Explicit

Dim DataWarehouseConn
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
Dim pvCallID

Dim vTotals(5)
Dim vOrgTotals(5)
Dim x
Dim i

Dim FontNameHead
Dim FontNameData
pvCallID = 0
FontNameHead = "Arial"
FontNameData = "Times New Roman"

vReportName = ""

%>



<!--#include virtual="/loginstatline/includes/Authorize.sls"--> 

<%
Call Process

Function Process

'Execute the main page generating routine
If AuthorizeMain Then

	Set DataWarehouseConn = server.CreateObject("ADODB.Connection")
	DataWarehouseConn.Open WAREHOUSEDSN, DBUSER, DBPWD	'drh 1/6/04 - Un-hardcoded DSN
	
	Set Conn = server.CreateObject("ADODB.Connection")
	Conn.Open DataSourceName, DBUSER, DBPWD	'drh 1/6/04 - Un-hardcoded User/Pwd

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

	If pvReportGroupID <> 0 AND pvOrgID = 0 Then
		
		'If a report group has been selected, get the report group name
		'and set the report title to the name of the report group
		vQuery = "sps_ReportGroupName " & pvReportGroupID & " "
		Set RS = Conn.Execute(vQuery)

		If Conn.Errors.Count > 0 Then
			vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
			vErrorMsg = vErrorMsg & "There has been a database error. <BR>"
			vErrorMsg = vErrorMsg & "Please click refresh to try your request again. <BR> <BR>"
			vErrorMsg = vErrorMsg & "If the problem continues, <BR>"
			vErrorMsg = vErrorMsg & "please contact Statline at (888) 881-7828 for assistance. </B> <BR> <BR> <BR>"
			vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
			vErrorMsg = vErrorMsg & "Error:     (" & ErrorReturn & ", GetReportGroupName, FacilitySummary.sls) <BR> <BR>"
			vErrorMsg = vErrorMsg & "</FONT></FONT>"
			Response.Write(vErrorMsg)
		End If
		
		If RS.EOF = True Then
			vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
			vErrorMsg = vErrorMsg & "The selected report group is no longer valid. Please select another group.<BR> <BR>"
			vErrorMsg = vErrorMsg & "If you continue to have difficulty, <BR>"
			vErrorMsg = vErrorMsg & "Please contact Statline at (888) 881-7828 for assistance. </B> <BR> <BR> <BR>"
			vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
			vErrorMsg = vErrorMsg & "Error:     (100, GetReportGroupName, FacilitySummary.sls) <BR> <BR>"
			vErrorMsg = vErrorMsg & "</FONT></FONT>"
			Response.Write(vErrorMsg)
			
		Else
			vReportTitle = vReportTitle & RS("WebReportGroupName")		
		End If
		
		Set RS = Nothing
		
	ElseIf pvOrgID <> 0  Then

		'Else if a single organization has been selected, get the organization data 
		'and set the report title to the name of the selected organization

		'Get the organization information
		vQuery = "sps_OrganizationName " & pvOrgID
		
		Set RS = Conn.Execute(vQuery)
		
		If RS.EOF = True Then
			vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
			vErrorMsg = vErrorMsg & "The organization selected for this report does not exist. <BR> <BR>"
			vErrorMsg = vErrorMsg & "If you continue to have difficulty, <BR>"
			vErrorMsg = vErrorMsg & "Please contact Statline at (888) 881-7828 for assistance.</B> <BR> <BR> <BR>"
			vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
			vErrorMsg = vErrorMsg & "Error:     (100, Org.IdentifyOrganization, Activity.sls) <BR> <BR>"
			vErrorMsg = vErrorMsg & "</FONT></FONT>"
		Else
			vReportTitle = RS("OrganizationName")			
		End If
		
		Set RS = Nothing
		
	ElseIf pvOrgID = 0 AND pvReportGroupID = 0 Then

		vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
		vErrorMsg = vErrorMsg & "Either a report group or an organization must be selected. <BR> <BR>"
		vErrorMsg = vErrorMsg & "If you continue to have difficulty, <BR>"
		vErrorMsg = vErrorMsg & "Please contact Statline at (888) 881-7828 for assistance. </B> <BR> <BR> <BR>"
		vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
		vErrorMsg = vErrorMsg & "Error:     (-1, UnitSummary.sls) <BR> <BR>"
		vErrorMsg = vErrorMsg & "</FONT></FONT>"
		Response.Write(vErrorMsg)

	Else

		vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
		vErrorMsg = vErrorMsg & "Unexpected Error. <BR> "
		vErrorMsg = vErrorMsg & "Please click refresh to try your request again. <BR> <BR>"
		vErrorMsg = vErrorMsg & "If the problem continues, <BR>"
		vErrorMsg = vErrorMsg & "please contact Statline at (888) 881-7828 for assistance. </B> <BR> <BR> <BR>"
		vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
		vErrorMsg = vErrorMsg & "Error:     (-1, Unexpected, UnitSummary.sls) <BR> <BR>"
		vErrorMsg = vErrorMsg & "</FONT></FONT>"
		Response.Write(vErrorMsg)

	End if

	vQuery = "sps_OrganizationTimeZone " & pvUserOrg & " "
	Set RS = Conn.Execute(vQuery)
	vTZ = RS("OrganizationTimeZone")
	Set RS = Nothing
	
%>
	<%	
	
	'Get the list of organizations to be processed
	If Request.QueryString("ReferralNumber") = "" Then
		vQuery = "sps_OhioSpecialReport " & pvCallID &", "& pvOrgID & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvReportGroupID
	Else
		vQuery = "sps_OhioSpecialReport " & Request.QueryString("ReferralNumber") &", "& pvOrgID & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvReportGroupID	
	End If
	'Response.Write vQuery
	Set RS = Conn.Execute(vQuery)
%>

<html>	
<head>
<meta HTTP-EQUIV="Expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<title>Ohio Department of Health</title>
<STYLE MEDIA=ALL >
	H1 {page-break-after: always}
</STYLE >
</head>
<BODY bgcolor="#F5EBDD" topmargin=24 leftmargin=24 rightmargin=24 bottommargin=24>


<%
	Do While Not RS.EOF
%>

<!-- begin report -->

<P align=center>
	<STRONG>Ohio Department of Health</STRONG>
	<BR>Certificate of Request for Anatomical Gift
</P>
<P>
	<FONT face=FontNameData size=2>Section 2108.021 (A) of the Ohio Revised Code requires completion of this form for each 
	Patient who dies in a hospital. Machine or printed copies of this form are the only exceptions which may be used. If you need any assistance to complete this 
	form, please review your hospital's anatomical gift protocol or contact your Organ Procurement Organization for information. Please print all answers. This a 
	reporting form, 
	<U><STRONG>not</STRONG></U> a consent form.</FONT>
	
</P>

<Table BORDER=0 WIDTH="93%" cellpadding=3 cellSpacing="0">
	<TR>
		<TD WIDTH="16.5%">
			<FONT face=FontNameData size=2>Reporting Hosptial:
			</FONT>
		</TD>
		<TD WIDTH="25%">
			<FONT face=FontNameData size=2><%=RS("OrganizationName")%>
			</FONT>
		</TD>
		<TD WIDTH="20%">	
			<FONT face=FontNameData size=2>Reporting Staff Member:
			</FONT>
		</TD>
		<TD WIDTH="17.5%">	
			<FONT face=FontNameData size=2><%=RS("PersonName")%>
			</FONT>
		</TD>
		
	</TR>
</TABLE>	
<Table BORDER=0 WIDTH="93%" cellpadding=3 cellSpacing="0">
	<TR>
		<TD WIDTH="3%">
			<FONT face=FontNameData size=2>
			1.
			</FONT>
		</TD>
		<TD WIDTH="18%">
			<FONT face=FontNameData size=2>
			Date of Death:
			</FONT>
		</TD>
		<TD WIDTH="32%">
			<FONT face=FontNameData size=2><%=RS("DeathDate")%>
			</FONT>
		</TD>
		<TD WIDTH="20%">	
			<FONT face=FontNameData size=2>For Hospital Use:
			</FONT>
		</TD>
		<TD WIDTH="25%">	
			
		</TD>

	</TR>	
	<TR>
		<TD>
		</TD>
		<TD WIDTH="18%">
			    <FONT face=FontNameData size=2> a. Dead on Arrival:  
			    </FONT>
		</TD>
		<TD WIDTH="32%">
			<FONT face=FontNameData size=2><%If RS("ReferralDOA") = -1 Then Response.Write "Yes" Else Response.Write "No"    %>
			</FONT>
		</TD>
		<TD WIDTH="20%">	
			
		</TD>
		<TD WIDTH="25%">	
			
		</TD>
	</TR>	
	<TR VALIGN=TOP>
	
		<TD WIDTH="3%">
			    <FONT face=FontNameData size=2>
			    2.
			    </FONT>
		</TD>
		<TD WIDTH="25%" COLSPAN=2>
			    <FONT face=FontNameData size=2>Was a request for organ(s), tissue(s), or eyes made?  
			    &nbsp
			    <%	If RS("ReferralOrganApproachID") = 1 or RS("ReferralBoneApproachID") = 1 or RS("ReferralTissueApproachID") = 1 or RS("ReferralSkinApproachID") = 1 or RS("ReferralValvesApproachID") = 1 or RS("ReferralEyesTransApproachID") = 1 Then
						Response.Write "Yes"
					Else
						Response.Write "No"
					End If	
				%>
			    </FONT>
		</TD>
			
		<TD WIDTH="15%" VALIGN=BOTTOM>
			<FONT face=FontNameData size=2>
			
			</FONT>																	  
		</TD>
		<TD WIDTH="20%">	
			
		</TD>
		<TD WIDTH="40%">	
			
		</TD>
	</TR>	
	<TR VALIGN=TOP>
		<TD WIDTH="3%">
			<FONT face=FontNameData size=2> 
			3.
			</FONT>
		</TD>
		<TD WIDTH="25%" ALIGN=LEFT COLSPAN=4>
			<FONT face=FontNameData size=2>
			Indicate below whether a request for any anatomical gift was made. 
			Check YES or NO for organ, tissue, and eye request. If patient was medically unsuitable, check only that line in Question 3a, b or c below:
			</FONT>
		</TD>
	</TR>		
</TABLE>
<BR>
<TABLE WIDTH="93%" ALIGN=CENTER BORDER=0>
	<TR>
		<TD WIDTH="31%" ALIGN=LEFT >
			<U><STRONG>
			<FONT face=FontNameData size=2>Organ Request
			</U></STRONG>
			<BR>
			Heart, Liver, Kidney,
			<BR>
			Pancreas, heart-lung,
			<BR>
			lung, bowel
			</FONT>
		</TD>
		<TD WIDTH="31%" ALIGN=LEFT>
			<U><STRONG>
			<FONT face=FontNameData size=2>Tissue Request
			</U></STRONG>
			<BR>
			Bone, skin, soft tissue,
			<BR>
			heart for heart valve
			</FONT>
		</TD>		
		<TD WIDTH="31%" ALIGN=LEFT>
			<U><STRONG>
			<FONT face=FontNameData size=2>Eye Request
			</U></STRONG>
			<BR>
			Eye, cornea
			</FONT>
		</TD>

	</TR>		    
	<TR VALIGN=BOTTOM>
		<TD WIDTH="31%" ALIGN=LEFT >
			<FONT face=FontNameData size=2><BR>a. 	<%	If RS("ReferralOrganApproachID") = 1 Then
						Response.Write "Yes"
					Else
						Response.Write "No"
					End If	
				%>
			</FONT>				
		</TD>
		<TD WIDTH="31%" ALIGN=LEFT>
			<FONT face=FontNameData size=2><BR>b.  <%	If RS("ReferralBoneApproachID") <> 1 And RS("ReferralTissueApproachID") <> 1 And RS("ReferralSkinApproachID") <> 1 And RS("ReferralValvesApproachID") <> 1  Then
						Response.Write "No"
					Else
						Response.Write "Yes" 
					End If	
					%>
			</FONT>					
		</TD>		
		<TD WIDTH="31%" ALIGN=LEFT>
			<FONT face=FontNameData size=2><BR>c.  <%	If  RS("ReferralEyesTransApproachID") = 1 Then
						Response.Write "Yes"
					Else
						Response.Write "No"
					End If	
				%>
			</FONT>				
		</TD>

	</TR>		    
</TABLE>
<BR>
<!--Begin first section of table -->
<!-- Place the table inside another table to provide proper indention-->
<TABLE WIDTH="100%" BORDER=0><TR><TD WIDTH="1%"></TD><TD WIDTH="99%">

<TABLE width=93% bordercolordark=Black bordercolor=Black border=1 ALIGN=LEFT bordercolorlight=Black>
	<TR>
		<TD>
			<TABLE>
					<TR>
						<TD>
							<FONT face=FontNameData size=2>
							Indicate why a request for Organ was not made. Only one answer.
							</FONT>
						</TD>
					</TR>	
					<TR>
						<TD>
							<FONT face=FontNameData size=2><BR> 
							Medically Unsuitable
							</FONT>
						</TD>
					</TR>
					<TR>	
						<TD>
							<FONT face=FontNameData size=2>1) &nbsp
				<%	If RS("ReferralOrganAppropriateID") > 1 Then
								Response.Write "Yes"
								
				%>		
					
							</FONT>
						</TD>
					</TR>	
					<TR>	
						<TD><BR>
							<FONT face=FontNameData size=2>
							(Reason)
							</FONT>
						</TD>
					</TR>	
					<TR>	
						<TD>
							<FONT face=FontNameData size=2>
							<%	If RS("ReferralOrganAppropriateID") > 1 Then
									Response.Write RS("AppropriateOrgan") 
								End IF 
							%>
							</FONT>
						</TD>
					</TR>								
										
				<%		
					Else
						If RS("ReferralOrganAppropriateID") < 1 Then Response.Write "No" End IF
				%>
							</TD>
						</TR>	
						<TR>	
							<TD><BR>
								<FONT face=FontNameData size=2>
								(Reason)
								</FONT>
							</TD>
						</TR>	
						<TR>	
							<TD>
							
							</TD>				
						</TR>								
				<%						
						
					End If	
				%>

							
			</TABLE>
		</TD>
		<!-- Begin Tissue  -->
		<TD>
			<TABLE>
						<TR>
							<TD>
							<FONT face=FontNameData size=2>	
							Indicate why a request for Tissue was not made. Only one answer:
							</FONT>
							</TD>
						</TR>	
						<TR>
							<TD>
								<FONT face=FontNameData size=2><BR>
								Medically Unsuitable
								</FONT>
							</TD>
						</TR>
						<TR>	
							<TD>
								<FONT face=FontNameData size=2>1) &nbsp
				<%If RS("ReferralBoneApproachID") <> 1 And RS("ReferralTissueApproachID") <> 1 And RS("ReferralSkinApproachID") <> 1 And RS("ReferralValvesApproachID") <> 1 AND (RS("ReferralBoneAppropriateID") > 1 Or RS("ReferralTissueAppropriateID") > 1 Or RS("ReferralSkinAppropriateID") > 1 Or RS("ReferralValvesAppropriateID") > 1) Then
								Response.Write "Yes"
								
				%>
								</FONT>
							</TD>
						</TR>
						<TR>	
							<TD><BR>
								<FONT face=FontNameData size=2>
								(Reason)
								</FONT>
							</TD>
						</TR>	
						<TR>	
							<TD>
								<FONT face=FontNameData size=2>
								<% If RS("ReferralBoneApproachID") <> 1 And RS("ReferralTissueApproachID") <> 1 And RS("ReferralSkinApproachID") <> 1 And RS("ReferralValvesApproachID") <> 1 Then  
										If RS("ReferralBoneAppropriateID")>1 Then
											Response.Write RS("AppropriateBone")
										ElseIf RS("ReferralTissueAppropriateID")>1 Then
											Response.Write RS("AppropriateTissue")
										ElseIf RS("ReferralSkinAppropriateID")>1 Then
											Response.Write RS("AppropriateSkin")
										ElseIf RS("ReferralValvesAppropriateID")> 1 Then
											Response.Write RS("AppropriateValves")
										End If 
									End If	
								%>	
								</FONT>
							</TD>
						</TR>											
				<%		
					Else
						IF RS("ReferralBoneAppropriateID") < 1 and RS("ReferralTissueAppropriateID") < 1 and RS("ReferralSkinAppropriateID") < 1 and RS("ReferralValvesAppropriateID") < 1  Then Response.Write "No" End IF
				%>
							</TD>
						</TR>
						<TR>	
							<TD><BR>
								<FONT face=FontNameData size=2>
								(Reason)
								</FONT>
							</TD>
						</TR>	
						<TR>	
							<TD>
							</TD>
						</TR>	
				<%		
					End If	
				%>			

			</TABLE>
		</TD>
		<TD>
			<TABLE>
						<TR>
							<TD>
								<FONT face=FontNameData size=2>
								Indicate why a request for Eyes was not made. Only one answer:
								</FONT>
							</TD>
						</TR>	
						<TR>
							<TD>
								<FONT face=FontNameData size=2>
								<BR> Medically Unsuitable
								</FONT>
							</TD>
						</TR>
						<TR>	
							<TD>
								<FONT face=FontNameData size=2>1) &nbsp
				<%	If  RS("ReferralEyesTransAppropriateID") > 1 Then
								Response.Write "Yes"
				%>
								</FONT>
							</TD>
						</TR>	
						<TR>	
							<TD><BR>
								<FONT face=FontNameData size=2>
								(Reason)
								</FONT>
							</TD>
						</TR>	
						<TR>	
							<TD>
								<FONT face=FontNameData size=2>
								<% If  RS("ReferralEyesTransAppropriateID") > 1 Then Response.Write RS("AppropriateEyes")End IF  %>
								</FONT>
							</TD>
						</TR>								
							
				<%		
					Else
						If RS("ReferralEyesTransAppropriateID") < 1 Then Response.Write "No" End IF
				%>
							</TD>
						</TR>	
						<TR>	
							<TD><BR>
								<FONT face=FontNameData size=2>
								(Reason)
								</FONT>
							</TD>
						</TR>	
						<TR>	
							<TD>
							</TD>
						</TR>							
				<%			
					End If	
				%>
	
							
						
			</TABLE>
		</TD>		
	</TR>
	<TR>
		<!-- START SECOND SECTION IN TABLE -->
		<TD>
			<TABLE>
				<TR>
					<TD>
						<FONT face=FontNameData size=2>2)&nbsp
			 <%If (RS("ReferralGeneralConsent") = 3 And (RS("ReferralApproachTypeID") = 2 or RS("ReferralApproachTypeID") = 3 or RS("ReferralApproachTypeID") = 6))and RS("ReferralOrganApproachID")<> 1 Then
						Response.Write "[X]Prior Patient/Family Objection "
			 %>			
						</FONT>			
					</TD>
				</TR>		
				<TR>
					<TD><BR>
						<FONT face=FontNameData size=2>
						3)&nbsp[ ] Other
						</FONT>
					</TD>
				</TR>
				<TR>
					<TD><BR>
						<FONT face=FontNameData size=2>
						(Describe)
						</FONT>
					</TD>
				</TR>																
			<%		
				Else
						Response.Write "[ ] Prior Patient/Family Objection"
			 %>		
						</FONT>				
					</TD>
				</TR>		
				<TR>
					<TD><BR>
						<FONT face=FontNameData size=2>
						<% If RS("ReferralOrganApproachID")> 1 Then %> 3)&nbsp[X] Other <% Else %>3)&nbsp[ ] Other  <%End IF%>
						</FONT>
					</TD>
				</TR>
				<TR>
					<TD><BR>
						<FONT face=FontNameData size=2>
						(Describe)
						</FONT>
						
					</TD>
				</TR>
				<TR>
					<TD>
						<FONT face=FontNameData size=2>
						
						<% If RS("ReferralOrganApproachID")> 1  Then Response.Write RS("ApproachOrgan") End IF%>												
						</FONT>
					</TD>
				</TR>																																				
			<%		
						
				End IF		
			%>
			</TABLE>
		</TD>
		<TD>			
			<TABLE>
				<TR>
					<TD>
						<FONT face=FontNameData size=2>
						2)&nbsp
			 <%If (RS("ReferralGeneralConsent") = 3 And (RS("ReferralApproachTypeID") = 2 or RS("ReferralApproachTypeID") = 3 or RS("ReferralApproachTypeID") = 6)) and (RS("ReferralBoneApproachID") <> 1 or RS("ReferralTissueApproachID") <> 1 or RS("ReferralSkinApproachID") <> 1 or RS("ReferralValvesApproachID") <> 1) Then
						Response.Write "[X]Prior Patient/Family Objection "
			 %>			
						</FONT>			
					</TD>
				</TR>		
				<TR>
					<TD><BR>
						<FONT face=FontNameData size=2>
						3)&nbsp[ ] Other
						</FONT>
					</TD>
				</TR>
				<TR>
					<TD><BR>
						<FONT face=FontNameData size=2>
						(Describe)
						</FONT>
					</TD>
				</TR>																

				
			<%		
				Else
						Response.Write "[ ] Prior Patient/Family Objection"
			 %>			</FONT>			
					</TD>
				</TR>		
				<TR>
					<TD><BR>
						<FONT face=FontNameData size=2>
						<% If (RS("ReferralBoneApproachID") <> 1 And RS("ReferralTissueApproachID") <> 1 And RS("ReferralSkinApproachID") <> 1 And RS("ReferralValvesApproachID") <> 1)And (RS("ReferralBoneAppropriateID") > 1 And RS("ReferralTissueAppropriateID") > 1 And RS("ReferralSkinAppropriateID") > 1 And RS("ReferralValvesAppropriateID") > 1) And (RS("ReferralBoneApproachID") > 1 Or RS("ReferralTissueApproachID") > 1 Or RS("ReferralSkinApproachID") > 1 Or RS("ReferralValvesApproachID") > 1)Then %>  3)&nbsp[X] Other <% Else %>  3)&nbsp[ ] Other <% End If %>
						</FONT>
					</TD>
				</TR>
				<TR>
					<TD><BR>
						<FONT face=FontNameData size=2>
						(Describe)
						</FONT>
						
					</TD>
				</TR>
				<TR>	
					<TD>
						<FONT face=FontNameData size=2>						
						<%If RS("ReferralBoneApproachID") <> 1 And RS("ReferralTissueApproachID") <> 1 And RS("ReferralSkinApproachID") <> 1 And RS("ReferralValvesApproachID") <> 1 And (RS("ReferralBoneAppropriateID") > 1 And RS("ReferralTissueAppropriateID") > 1 And RS("ReferralSkinAppropriateID") > 1 And RS("ReferralValvesAppropriateID") > 1) Then
								If RS("ReferralBoneApproachID") > 1 Then
									Response.Write RS("ApproachBone")
								ElseIf RS("ReferralTissueApproachID") > 1 Then
									Response.Write RS("ApproachTissue")
								ElseIf RS("ReferralSkinApproachID") > 1 Then
									Response.Write RS("ApproachSkin")
								ElseIf RS("ReferralValvesApproachID") > 1 Then
									Response.Write RS("ApproachValves")
								End If
							End If	
							
						%>	
						</FONT>
					</TD>
				</TR>	
			<%		
						
				End IF		
			%>
			</TABLE>
		</TD>
		<TD>						
			<TABLE>
				<TR>
					<TD>
						<FONT face=FontNameData size=2>
						2)&nbsp
			 <%If (RS("ReferralGeneralConsent") = 3 And (RS("ReferralApproachTypeID") = 2 or RS("ReferralApproachTypeID") = 3 or RS("ReferralApproachTypeID") = 6)) and RS("ReferralEyesTransApproachID") <> 1 Then
						Response.Write "[X]Prior Patient/Family Objection "
			 %>			
						</FONT>			
					</TD>
				</TR>		
				<TR>
					<TD><BR>
						<FONT face=FontNameData size=2>
						3)&nbsp[ ] Other
						</FONT>
					</TD>
				</TR>
				<TR>
					<TD><BR>
						<FONT face=FontNameData size=2>
						(Describe)
						</FONT>
					</TD>
				</TR>																
			<%		
				Else
						Response.Write "[ ] Prior Patient/Family Objection"
			 %>					
						</FONT>	
					</TD>
				</TR>		
				<TR>
					<TD><BR>
						<FONT face=FontNameData size=2>
						<%If RS("ReferralEyesTransApproachID") > 1 Then %> 3)&nbsp[X] Other <% Else %>  3)&nbsp[ ] Other <%End If%>
						</FONT>
					</TD>
				</TR>
				<TR>
					<TD><BR>
						<FONT face=FontNameData size=2>
						(Describe)
						</FONT>
						
					</TD>
				</TR>	
				<TR>	
					<TD>
						<FONT face=FontNameData size=2>
						<%	If RS("ReferralEyesTransApproachID") > 1 Then
							 Response.Write RS("ApproachEyes")
							End IF  
						%>
						</FONT>
					</TD>				
				</TR>	
																			
			<%		
						
				End IF		
			%>

			</TABLE>
		
		</TD>
	</TR>			
</Table>
<!-- End Outer table -->
</TD></TR></TABLE>


<!-- Organ Tissue or Eye Request Granted -->
		
<TABLE WIDTH="100%" ALIGN=LEFT border=0 cellpadding=3>
 	<TR>
		<TD WIDTH="3%" ALIGN=LEFT VALIGN=TOP>
			<FONT face=FontNameData size=2>
			4.
			</FONT>
		</TD>
		<TD WIDTH="3%" ALIGN=LEFT VALIGN=TOP>
			<FONT face=FontNameData size=2>
			a.
			</FONT>
		</TD>		
		<TD WIDTH="26%" ALIGN=LEFT >
			<FONT face=FontNameData size=2>
			Organ Request granted?

			<BR>
			 	<%	If RS("ReferralOrganConsentID") = 1 Then
						Response.Write "Yes"
					Else
						Response.Write "No"
					End If	
				%>
			</FONT>	
		</TD>
		<TD WIDTH="3%" ALIGN=LEFT VALIGN=TOP>
			<FONT face=FontNameData size=2>
			b.
			</FONT>
		</TD>		
		<TD WIDTH="27%" ALIGN=LEFT >
			<FONT face=FontNameData size=2>
			Tissue Request granted?
			<BR>
			  <%	If RS("ReferralBoneConsentID") = 1 or RS("ReferralTissueConsentID") = 1 or RS("ReferralSkinConsentID") = 1 or RS("ReferralValvesConsentID") = 1 Then
						Response.Write "Yes"
					Else
						Response.Write "No"
					End If	
					%>
			</FONT>					
		</TD>		
		<TD WIDTH="3%" ALIGN=LEFT VALIGN=TOP>
			<FONT face=FontNameData size=2>
			c.
			</FONT>
		</TD>		
		<TD WIDTH="26%" ALIGN=LEFT >
			<FONT face=FontNameData size=2>
			Eye Request granted?
			  <BR>
				<%	If  RS("ReferralEyesTransConsentID") = 1 Then
						Response.Write "Yes"
					Else
						Response.Write "No"
					End If	
				%>
			</FONT>				
		</TD> 
	</TR>		    

<!-- Identify Procurement Organization -->

	<TR VALIGN=BOTTOM>
		<TD WIDTH="3%" ALIGN=LEFT VALIGN=TOP>
			<FONT face=FontNameData size=2>
			5.
			</FONT>
		</TD>
		<TD WIDTH="2%" ALIGN=LEFT VALIGN=TOP>
			<FONT face=FontNameData size=2>
			a.
			</FONT>
		</TD>		
		<TD WIDTH="27%" ALIGN=LEFT VALIGN=TOP>
			<FONT face=FontNameData size=2>
			Identify the procurement organization notified.
			<BR><%= RS("OrganAssigned")%><BR>
			</FONT>
		</TD>
		<TD WIDTH="2%" ALIGN=LEFT VALIGN=TOP>
			<FONT face=FontNameData size=2>
			b.
			</FONT>
		</TD>		
		<TD WIDTH="28%" ALIGN=LEFT VALIGN=TOP>
			<FONT face=FontNameData size=2>
			Identify the procurement organization notified.
			<BR><%= RS("TissueAssigned")%><BR>
			</FONT>
		</TD>		
		<TD WIDTH="2%" ALIGN=LEFT VALIGN=TOP>
			<FONT face=FontNameData size=2>
			c.
			</FONT>
		</TD>		
		<TD WIDTH="27%" ALIGN=LEFT VALIGN=TOP>
			<FONT face=FontNameData size=2>
			Identify the procurement organization notified.
			<BR><%= RS("EyeAssigned")%><BR>
			</FONT>
		</TD>
	</TR>		    

<!-- Were Organs Recovered  -->

	<TR VALIGN=BOTTOM>
		<TD WIDTH="3%" ALIGN=LEFT VALIGN=TOP>
			<FONT face=FontNameData size=2>
			6.
			</FONT>
		</TD>
		<TD WIDTH="3%" ALIGN=LEFT VALIGN=TOP>
			<FONT face=FontNameData size=2>
			a.
			</FONT>
		</TD>		
		<TD WIDTH="26%" ALIGN=LEFT >
			<FONT face=FontNameData size=2>
			Were organs recovered?
			
			<BR>
			<%
				If RS("ReferralOrganConversionID") = 1 Then
					Response.Write "Yes"
				Else
					Response.Write "No"
				End if
			%>
			</FONT> 	
		</TD>
		<TD WIDTH="3%" ALIGN=LEFT VALIGN=TOP>
			<FONT face=FontNameData size=2>
			b.
			</FONT>
		</TD>		
		<TD WIDTH="27%" ALIGN=LEFT >
			<FONT face=FontNameData size=2>
			Was tissue recovered?
			<BR>
			<%
				If RS("ReferralBoneConversionID") = 1 or RS("ReferralSkinConversionID") = 1 or RS("ReferralTissueConversionID") = 1 or RS("ReferralValvesConversionID") = 1 Then
					Response.Write "Yes"
				Else
					Response.Write "No"
				End if
			%>
			</FONT>
		</TD>		
		<TD WIDTH="3%" ALIGN=LEFT VALIGN=TOP>
			<FONT face=FontNameData size=2>
			c.
			</FONT>
		</TD>		
		<TD WIDTH="26%" ALIGN=LEFT >
			<FONT face=FontNameData size=2>
			Were eyes recovered?
			<BR>
			<%
				If RS("ReferralEyesTransConversionID") = 1 Then
					Response.Write "Yes"
				Else
					Response.Write "No"
				End if
			%>
			</FONT>
		</TD>
	</TR>		    

<!-- Who is responsible for filling out this form -->
	<TR>
		<TD WIDTH="3%">
		<FONT face=FontNameData size=2>
		7.
		</FONT>
		</TD>
		<TD WIDTH="3%" ALIGN=LEFT COLSPAN=4>
			<FONT face=FontNameData size=2>
			Identify person responsible for completion of this form: 
			</FONT>
		</TD>	
	</TR>
	<TR>
		<TD>
		</TD>
		<TD WIDTH="3%" ALIGN=LEFT COLSPAN=4>
			<FONT face=FontNameData size=2>
			Name:
			</FONT>
		</TD>
		<TD WIDTH="20%" ALIGN=LEFT COLSPAN=2>
			<FONT face=FontNameData size=2>
			Title:
			</FONT>
		</TD>		
		<TD WIDTH="20%" ALIGN=LEFT >
		</TD>		
	</TR>
	<TR>
		<TD WIDTH="1%">
		</TD>
		<TD WIDTH="3%" ALIGN=LEFT COLSPAN=4 >
			<FONT face=FontNameData size=2>
			Signature________________________________ 
			</FONT>
		</TD>
			
				
		<TD WIDTH="1%" ALIGN=LEFT COLSPAN=2>
			<FONT face=FontNameData size=2>
			Date:&nbsp <%= Date %>
			</FONT>
		</TD>
	</TR>		    
</TABLE>
<BR><BR><BR><BR><BR>
<H1><BR><BR><BR><BR><BR><!--end--> </H1>




	<%
	RS.MoveNext
	
	Loop

	%>
</BODY>
</HTML>
	
	
<%
End If

Set RS = Nothing
Set Conn = Nothing
Set DataWarehouseConn = Nothing

End Function
%>


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
		<TD <%=vCurrentColor%>  ALIGN=CENTER><FONT SIZE="1" FACE="<%=FontNameData%>"><B><i>&nbsp &nbsp &nbsp &nbsp Subtotal</i></B></TD>
		<TD <%=vCurrentColor%>  ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameData%>"><B><i><%=vOrgTotals(0)%></i></B></FONT></TD>
		<TD <%=vCurrentColor%> ><FONT SIZE="1" FACE="<%=FontNameData%>"><B><i><%=vOrgTotals(1)%></i></B></FONT></TD>
		<TD <%=vCurrentColor%> ><FONT SIZE="1" FACE="<%=FontNameData%>"><B><i><%=vOrgTotals(2)%></i></B></FONT></TD>
		<TD <%=vCurrentColor%> ><FONT SIZE="1" FACE="<%=FontNameData%>"><B><i><%=vOrgTotals(3)%></i></B></FONT></TD>
		<TD <%=vCurrentColor%> ><FONT SIZE="1" FACE="<%=FontNameData%>"><B><i><%=vOrgTotals(4)%></i></B></FONT></TD>
	</TR>
	<% 
	If PrintLine = 1 Then 
	%>
		<TR>
			<TD COLSPAN=8><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%"></TD>
		</TR>
	<% 
	End If		
	%>	
<%	
	For i = 0 to UBound(vOrgTotals,1)
			vOrgTotals(i)=0
	Next
End Function

'End of Function Section
%>