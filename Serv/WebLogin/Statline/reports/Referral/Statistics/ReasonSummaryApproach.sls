<!-- Begin Approach -->
	<TABLE BORDER=0 WIDTH="100%">
	<TH COLSPAN=7 WIDTH="100%"> </TH>
	<TR><TD COLSPAN=7><IMG SRC="/loginstatline/images/redline.jpg" HEIGHT=2 WIDTH="100%"></TD></TR>
	<TR>
		<TD WIDTH="12%" ALIGN=LEFT><B><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">Approach</B></TD>
		<TD WIDTH="13%" ALIGN=CENTER><B><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">Organs&nbsp &nbsp &nbsp</B></TD>
		<TD WIDTH="13%" ALIGN=CENTER><B><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">Bone&nbsp &nbsp &nbsp &nbsp &nbsp</B></TD>
		<TD WIDTH="13%" ALIGN=CENTER><B><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">Tissue&nbsp &nbsp &nbsp &nbsp</B></TD>
		<TD WIDTH="13%" ALIGN=CENTER><B><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">Skin&nbsp &nbsp &nbsp &nbsp &nbsp</B></TD>
		<TD WIDTH="13%" ALIGN=CENTER><B><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">Valves&nbsp &nbsp &nbsp &nbsp</B></TD>
		<TD WIDTH="13%" ALIGN=CENTER><B><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">Eyes&nbsp &nbsp &nbsp &nbsp &nbsp</B></TD>
	</TR>
	<TR><TD COLSPAN=7><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%"></TD></TR>
	</TABLE>
	<TABLE WIDTH="100%">
		<!--Do Yes-->
		<TR>
			<TD WIDTH="12%"><FONT SIZE="<%=FontSizeDataLog%>" FACE="<%=FontNameDataLog%>"><B>Approached</B></TD>
			<% For y = 2 To 13 Step 2 %>
				<TD WIDTH="6%" ALIGN=Right><FONT SIZE="<%=FontSizeDataLog%>" FACE="<%=FontNameDataLog%>"><B><%=pvApproach(1,y)%>%</B></TD>
				<TD WIDTH="1%"><FONT SIZE="<%=FontSizeDataLog%>" FACE="<%=FontNameDataLog%>">&nbsp</TD>
				<TD WIDTH="6%" ALIGN=Left><FONT SIZE="<%=FontSizeDataLog%>" FACE="<%=FontNameDataLog%>"><B>
				<%
				If pvApproach(1,y+1) <> 0 Then
				Select Case ((y/2)-1)
					case 0
						pvIn = "AND ReferralOrganApproachID = 1 AND ReferralOrganAppropriateID = 1"
					case 1
						pvIn = "AND ReferralBoneApproachID = 1 AND ReferralBoneAppropriateID = 1"
					case 2
						pvIn = "AND ReferralTissueApproachID = 1 AND ReferralTissueAppropriateID = 1"
					case 3
						pvIn = "AND ReferralSkinApproachID = 1 AND ReferralSkinAppropriateID = 1"
					case 4
						pvIn = "AND ReferralValvesApproachID = 1 AND ReferralValvesAppropriateID = 1"
					case 5
						pvIn = "AND ReferralEyesTransApproachID = 1 AND ReferralEyesTransAppropriateID = 1"
				End Select
				Call MakeQueryString(pvIn, pvOut)%>
				<A target="ReferralSummary"  HREF="/loginstatline/reports/referral/summary.sls?<%=Request.QueryString%>&NoLog=1&And=<%=pvOut%>">
				<%End if%>
				<%=pvApproach(1,y+1)%></A></B></TD>
			<% next %>
		</TR>
		
		<!--Do No Accumulated-->
		<TR>
			<TD WIDTH="12%"><FONT SIZE="<%=FontSizeDataLog%>" FACE="<%=FontNameDataLog%>"><B>Not Approached</B></TD>
			<% For y = 2 To 13 Step 2 %>
				<% vTemp=0
					For x=2 To Ubound(pvApproach,1)
						If Not IsNull(pvApproach(x,y)) Then
							vTemp = vTemp + pvApproach(x,y+1)
						End If
					Next %>
				<TD WIDTH="6%" ALIGN=Right><FONT SIZE="<%=FontSizeDataLog%>" FACE="<%=FontNameDataLog%>"><B>
					<% If (vTemp+ pvApproach(1,y+1)) = 0 Then
						Response.Write("0")
					 Else
						Response.Write(Refer.Round(100*vTemp/(vTemp+ pvApproach(1,y+1))))
					 End If%>%</B></TD>
				<TD WIDTH="1%"><FONT SIZE="<%=FontSizeDataLog%>" FACE="<%=FontNameDataLog%>">&nbsp</TD>
				<% vTemp=0
					For x=2 To Ubound(pvApproach,1)
						If Not IsNull(pvApproach(x,y)) Then
							vTemp = vTemp + pvApproach(x,y+1)
						End If
					Next %>
				<TD WIDTH="6%" ALIGN=Left><FONT SIZE="<%=FontSizeDataLog%>" FACE="<%=FontNameDataLog%>"><B>
				<%
				If vTemp <> 0 Then
				Select Case ((y/2)-1)
					case 0
						pvIn = "AND ReferralOrganApproachID <> 1 AND ReferralOrganAppropriateID = 1"
					case 1
						pvIn = "AND ReferralBoneApproachID <> 1 AND ReferralBoneAppropriateID = 1"
					case 2
						pvIn = "AND ReferralTissueApproachID <> 1 AND ReferralTissueAppropriateID = 1"
					case 3
						pvIn = "AND ReferralSkinApproachID <> 1 AND ReferralSkinAppropriateID = 1"
					case 4
						pvIn = "AND ReferralValvesApproachID <> 1 AND ReferralValvesAppropriateID = 1"
					case 5
						pvIn = "AND ReferralEyesTransApproachID <> 1 AND ReferralEyesTransAppropriateID = 1"
				End Select
				Call MakeQueryString(pvIn, pvOut)%>
				<A target="ReferralSummary"  HREF="/loginstatline/reports/referral/summary.sls?<%=Request.QueryString%>&NoLog=1&And=<%=pvOut%>">
				<%End if%>
				<%=vTemp%></A></B></TD>
			<% next %>
		</TR>
		
		
		<!--Itemize No's-->
		<% For x=2 To Ubound(pvApproach,1)%>
		<% If pvApproach(x,1) <> "" Then %>
		<TR>

			<TD WIDTH="12%"><FONT SIZE="<%=FontSizeDataLog%>" FACE="<%=FontNameDataLog%>">&nbsp &nbsp<%=pvApproach(x,1)%></TD>
			<% For y = 2 To 13 Step 2 %>
				<% vTemp=0
					For z=2 To Ubound(pvApproach,1)
						If Not IsNull(pvApproach(x,y)) Then
							vTemp = vTemp + pvApproach(z,y+1)
						End If
					Next %>
				<TD WIDTH="6%" ALIGN=Right><FONT SIZE="<%=FontSizeDataLog%>" FACE="<%=FontNameDataLog%>">
					<%if vTemp > 0 Then 
						Response.Write(Refer.Round(pvApproach(x,y+1)/vTemp * 100))
					  Else
						Response.Write("0")
					  End If%>%</TD>
				<TD WIDTH="1%"><FONT SIZE="<%=FontSizeDataLog%>" FACE="<%=FontNameDataLog%>">&nbsp</TD>
				<TD WIDTH="6%" ALIGN=Left><FONT SIZE="<%=FontSizeDataLog%>" FACE="<%=FontNameDataLog%>">
				<%
				If pvApproach(x,y+1) <> 0 Then
				Select Case ((y/2)-1)
					case 0
						pvIn = "AND ReferralOrganApproachID = " & pvApproach(x, 14) & " AND ReferralOrganAppropriateID = 1"
					case 1
						pvIn = "AND ReferralBoneApproachID = " & pvApproach(x, 14) & " AND ReferralBoneAppropriateID = 1"
					case 2
						pvIn = "AND ReferralTissueApproachID = " & pvApproach(x, 14) & " AND ReferralTissueAppropriateID = 1"
					case 3
						pvIn = "AND ReferralSkinApproachID = " & pvApproach(x, 14) & " AND ReferralSkinAppropriateID = 1"
					case 4
						pvIn = "AND ReferralValvesApproachID = " & pvApproach(x, 14) & " AND ReferralValvesAppropriateID = 1"
					case 5
						pvIn = "AND ReferralEyesTransApproachID = " & pvApproach(x, 14) & " AND ReferralEyesTransAppropriateID = 1"
				End Select
				Call MakeQueryString(pvIn, pvOut)%>
				<A target="ReferralSummary"  HREF="/loginstatline/reports/referral/summary.sls?<%=Request.QueryString%>&NoLog=1&And=<%=pvOut%>">
				<%End if%>
				<%=pvApproach(x,y+1)%></A></B></TD>
			<% next %>
		</TR>

		<% End If %>
		<% Next %>
	</TABLE>
<!-- End Approach -->
