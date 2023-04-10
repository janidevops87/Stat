<!-- Begin Conversion -->
	<%%>
	<TABLE BORDER=0 WIDTH="100%">
	<TH COLSPAN=7 WIDTH="100%"> </TH>
	<TR><TD COLSPAN=7><IMG SRC="/loginstatline/images/redline.jpg" HEIGHT=2 WIDTH="100%"></TD></TR>
	<TR>
		<TD WIDTH="12%" ALIGN=LEFT><B><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">Recovery</B></TD>
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
			<TD WIDTH="12%"><FONT SIZE="<%=FontSizeDataLog%>" FACE="<%=FontNameDataLog%>"><B>Recovered</B></TD>
			<% For y = 2 To 13 Step 2 %>
				<TD WIDTH="6%" ALIGN=Right><FONT SIZE="<%=FontSizeDataLog%>" FACE="<%=FontNameDataLog%>"><B><%=pvConversion(1,y)%>%</B></TD>
				<TD WIDTH="1%"><FONT SIZE="<%=FontSizeDataLog%>" FACE="<%=FontNameDataLog%>">&nbsp</TD>
				<TD WIDTH="6%" ALIGN=Left><FONT SIZE="<%=FontSizeDataLog%>" FACE="<%=FontNameDataLog%>"><B>
				<%
				If pvConversion(1, y+1) <> 0 Then
				Select Case ((y/2)-1)
					case 0
						pvIn = "AND ReferralOrganConversionID = 1 AND ReferralOrganConsentID = 1 AND ReferralOrganApproachID = 1 AND ReferralOrganAppropriateID = 1"
					case 1
						pvIn = "AND ReferralBoneConversionID = 1 AND ReferralBoneConsentID = 1 AND ReferralBoneApproachID = 1 AND ReferralBoneAppropriateID = 1"
					case 2
						pvIn = "AND ReferralTissueConversionID = 1 AND ReferralTissueConsentID = 1 AND ReferralTissueApproachID = 1 AND ReferralTissueAppropriateID = 1"
					case 3
						pvIn = "AND ReferralSkinConversionID = 1 AND ReferralSkinConsentID = 1 AND ReferralSkinApproachID = 1 AND ReferralSkinAppropriateID = 1"
					case 4
						pvIn = "AND ReferralValvesConversionID = 1 AND ReferralValvesConsentID = 1 AND ReferralValvesApproachID = 1 AND ReferralValvesAppropriateID = 1"
					case 5
						pvIn = "AND ReferralEyesTransConversionID = 1 AND ReferralEyesTransConsentID = 1 AND ReferralEyesTransApproachID = 1 AND ReferralEyesTransAppropriateID = 1"
				End Select
				Call MakeQueryString(pvIn, pvOut)%>
				<A target="ReferralSummary"  HREF="/loginstatline/reports/referral/summary.sls?<%=Request.QueryString%>&NoLog=1&And=<%=pvOut%>">
				<%End If%>
				<%=pvConversion(1,y+1)%></A></B></TD>
			<% next %>
		</TR>
		
		<!--Do No Accumulated-->
		<TR>
			<TD WIDTH="12%"><FONT SIZE="<%=FontSizeDataLog%>" FACE="<%=FontNameDataLog%>"><B>Not Recovered</B></TD>
			<% For y = 2 To 13 Step 2 %>
				<% vTemp=0
					For x=2 To Ubound(pvConversion,1)
						If Not IsNull(pvConversion(x,y)) Then
							vTemp = vTemp + pvConversion(x,y+1)
						End If
					Next %>
				<TD WIDTH="6%" ALIGN=Right><FONT SIZE="<%=FontSizeDataLog%>" FACE="<%=FontNameDataLog%>"><B>
					<% If (vTemp+ pvConversion(1,y+1)) = 0 Then
						Response.Write("0")
					 Else
						Response.Write(Refer.Round(100*vTemp/(vTemp+ pvConversion(1,y+1))))
					 End If%>%</B></TD>
				<TD WIDTH="1%"><FONT SIZE="<%=FontSizeDataLog%>" FACE="<%=FontNameDataLog%>">&nbsp</TD>
				<% vTemp=0
				For x=2 To Ubound(pvConversion,1)
					If Not IsNull(pvConversion(x,y)) Then
						vTemp = vTemp + pvConversion(x,y+1)
					End If
				Next %>
				<TD WIDTH="6%" ALIGN=Left><FONT SIZE="<%=FontSizeDataLog%>" FACE="<%=FontNameDataLog%>"><B>
				<%
				If vTemp <> 0 Then
				Select Case ((y/2)-1)
					case 0
						pvIn = "AND ReferralOrganConversionID <> 1 AND ReferralOrganConsentID = 1 AND ReferralOrganApproachID = 1 AND ReferralOrganAppropriateID = 1"
					case 1
						pvIn = "AND ReferralBoneConversionID <> 1 AND ReferralBoneConsentID = 1 AND ReferralBoneApproachID = 1 AND ReferralBoneAppropriateID = 1"
					case 2
						pvIn = "AND ReferralTissueConversionID <> 1 AND ReferralTissueConsentID = 1 AND ReferralTissueApproachID = 1 AND ReferralTissueAppropriateID = 1"
					case 3
						pvIn = "AND ReferralSkinConversionID <> 1 AND ReferralSkinConsentID = 1 AND ReferralSkinApproachID = 1 AND ReferralSkinAppropriateID = 1"
					case 4
						pvIn = "AND ReferralValvesConversionID <> 1 AND ReferralValvesConsentID = 1 AND ReferralValvesApproachID = 1 AND ReferralValvesAppropriateID = 1"
					case 5
						pvIn = "AND ReferralEyesTransConversionID <> 1 AND ReferralEyesTransConsentID = 1 AND ReferralEyesTransApproachID = 1 AND ReferralEyesTransAppropriateID = 1"
				End Select
				Call MakeQueryString(pvIn, pvOut)%>
				<A target="ReferralSummary"  HREF="/loginstatline/reports/referral/summary.sls?<%=Request.QueryString%>&NoLog=1&And=<%=pvOut%>">
				<%End If%>
				<%=vTemp%></B></TD>
			<% next %>
		</TR>
		
		<!--Itemize No's-->
		<% For x=2 To Ubound(pvConversion,1)%>
		<% If pvConversion(x,1) <> "" Then %>
		<TR>

			<TD WIDTH="12%"><FONT SIZE="<%=FontSizeDataLog%>" FACE="<%=FontNameDataLog%>">&nbsp &nbsp<%=pvConversion(x,1)%></TD>
			<% For y = 2 To 13 Step 2 %>
				<% vTemp=0
					For z=2 To Ubound(pvConversion,1)
						If Not IsNull(pvConversion(x,y)) Then
							vTemp = vTemp + pvConversion(z,y+1)
						End If
					Next %>
				<TD WIDTH="6%" ALIGN=Right><FONT SIZE="<%=FontSizeDataLog%>" FACE="<%=FontNameDataLog%>">
					<%if vTemp > 0 Then 
						Response.Write(Refer.Round(pvConversion(x,y+1)/vTemp * 100))
					  Else
						Response.Write("0")
					  End If%>%</TD>
				<TD WIDTH="1%"><FONT SIZE="<%=FontSizeDataLog%>" FACE="<%=FontNameDataLog%>">&nbsp</TD>
				<TD WIDTH="6%" ALIGN=Left><FONT SIZE="<%=FontSizeDataLog%>" FACE="<%=FontNameDataLog%>">
				<%
				If pvConversion(x,y+1) <> 0 Then
				Select Case ((y/2)-1)
					case 0
						pvIn = "AND ReferralOrganConversionID = " & pvConversion(x, 14) & " AND ReferralOrganConsentID = 1 AND ReferralOrganApproachID = 1 AND ReferralOrganAppropriateID = 1"
					case 1
						pvIn = "AND ReferralBoneConversionID = " & pvConversion(x, 14) & " AND ReferralBoneConsentID = 1 AND ReferralBoneApproachID = 1 AND ReferralBoneAppropriateID = 1"
					case 2
						pvIn = "AND ReferralTissueConversionID = " & pvConversion(x, 14) & " AND ReferralTissueConsentID = 1 AND ReferralTissueApproachID = 1 AND ReferralTissueAppropriateID = 1"
					case 3
						pvIn = "AND ReferralSkinConversionID = " & pvConversion(x, 14) & " AND ReferralSkinConsentID = 1 AND ReferralSkinApproachID = 1 AND ReferralSkinAppropriateID = 1"
					case 4
						pvIn = "AND ReferralValvesConversionID = " & pvConversion(x, 14) & " AND ReferralValvesConsentID = 1 AND ReferralValvesApproachID = 1 AND ReferralValvesAppropriateID = 1"
					case 5
						pvIn = "AND ReferralEyesTransConversionID = " & pvConversion(x, 14) & " AND ReferralEyesTransConsentID = 1 AND ReferralEyesTransApproachID = 1 AND ReferralEyesTransAppropriateID = 1"
				End Select
				Call MakeQueryString(pvIn, pvOut)%>
				<A target="ReferralSummary"  HREF="/loginstatline/reports/referral/summary.sls?<%=Request.QueryString%>&NoLog=1&And=<%=pvOut%>">
				<%End if%>
				<%=pvConversion(x,y+1)%></A></B></TD>
			<% next %>
		</TR>

		<% End If %>
		<% Next %>
	</TABLE>
<!-- End Conversion -->
